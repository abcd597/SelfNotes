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
直接取得上面講到的`login.USER_AUTHORITY.ToString()`

