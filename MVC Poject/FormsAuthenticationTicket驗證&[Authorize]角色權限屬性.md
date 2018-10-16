### 表單驗證FormsAuthenticationTicket
最簡單的驗證方法就是驗完帳密後用Session儲存使用者各個資訊(員工編號、公司、性別甚麼有的沒的)，
但是在其他地方要使用就必須記住Session的名字→Session["名字"].ToString()這樣，
而在學MVC過程中學到了表單驗證的方法，FormsAuthentication，源自於ASP.NET，  
[→官方文件](https://docs.microsoft.com/en-us/previous-versions/msp-n-p/ff647070(v=pandp.10))  
下面筆記一下使用方法。 
  
1.寫入方法
```c#
FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                                                                 login.USER_ACC,
                                                                 DateTime.Now,
                                                                 DateTime.Now.AddMinutes(300),
                                                                 true,
                                                                 login.USER_AUTHORITY.ToString(),
                                                                 FormsAuthentication.FormsCookiePath);
string enticket = FormsAuthentication.Encrypt(ticket);
Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, enticket));
```
驗完帳秘或其他資訊成功後加上這段，new的部分是建立ticket的參數，之後利用Encrypt加密，再Response.Cookies.Add存入cookie。  
  
2.取出方法
```c#
User.Identity.Name.ToString()
```
這是在第1點`FormsAuthenticationTicket`中存入的`login.USER_ACC`資料。   

```c#
  FormsIdentity id = (FormsIdentity)User.Identity;
  FormsAuthenticationTicket ticket = id.Ticket;
```
取出完整的ticket資料，第1點中有儲存`login.USER_AUTHORITY.ToString()`我拿來控制權限用，但這位置可塞其他資料，
之後可能會試試塞個Json字串來儲存user資訊。

```c#
((FormsIdentity)User.Identity).Ticket.UserData
```
直接取得上面講到的`login.USER_AUTHORITY.ToString()`，用在Master Page中Menu顯示連結好用  
  
3.設定腳色  
使用AuthorizeAttribute的功能可以控制在進入Controller中某些funciton時的權限
```c#
[Authorize]//←這個
public ActionResult OneAction()
{
    return View();
}
```
屬性最簡單的分兩種「AllowAnonymous」、「Authorize」，  
AllowAnonymous:允許任何人進入這個function  
Authorize:需要經過登入驗證成功後才可以進入這個function  
  
Authorize又可再依據Role,User是那些在劃分權限  
`[Authorize(Roles="Administrators")]、[Authorize(Users="Alice,Bob")]`這樣

但是必須在Global.asax.cs中增加一段像第2點取驗證資訊的方法:  
參考自(其實是照抄)→[別人的Blog](https://dotblogs.com.tw/mickey/2017/01/01/154812)
```c#
protected void Application_AuthenticateRequest(object sender, EventArgs e)
{
  if (Request.IsAuthenticated)
  {
   // 先取得該使用者的 FormsIdentity
   FormsIdentity id = (FormsIdentity)User.Identity;
   // 再取出使用者的 FormsAuthenticationTicket
   FormsAuthenticationTicket ticket = id.Ticket;
   // 將儲存在 FormsAuthenticationTicket 中的角色定義取出，並轉成字串陣列
   string[] roles = ticket.UserData.Split(new char[] { ',' });
   // 指派角色到目前這個 HttpContext 的 User 物件去
   //剛剛在創立表單的時候，你的UserData 放使用者名稱就是取名稱，我放的是群組代號，所以取出來就是群組代號
   //然後會把這個資料放到Context.User內
   Context.User = new GenericPrincipal(Context.User.Identity, roles);
   }
}
```
然後Web.config中也要設定:
```c#
<authentication mode="Forms">
 <forms loginUrl="~/System/Login" timeout="3000" protection="All" slidingExpiration="true" />
</authentication>
```
之後當沒有權限或沒通過登入驗證時畫面就會跳轉到`System/Login`這畫面。
