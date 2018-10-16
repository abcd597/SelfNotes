### 權限角色屬性[Authorize]

>Controller中很常用的Action屬性`[AllowAnonymous]`、`[Authorize]`，  
>這裡紀錄一下怎麼幫Controller中的funciton設定權限角色控制  
>參考(照抄)自保哥的文章 https://blog.miniasp.com/post/2008/06/11/How-to-define-Roles-but-not-implementing-Role-Provider-in-ASPNET.aspx

1.`[Authorize]`  
如果只在Action上面加上`[Authorize]`  
```c#
[Authorize]
public ActionResult ABC()
{
   return View();
}
``` 
則只要有登入驗證成功的都能進入使用這個Function。  

2.`[Authorize(Roles="1,2,3")]`  
如果要更進一步控制  
```c#
[Authorize(Roles="2,3")]
public ActionResult ABC()
{
   return View();
}
```
這樣的話，在登入成功時，專案就要有動作將權限角色的值加入，  
這邊用的是專案中`Global.asax`這個檔案，搭配`FormsAuthenticationTicket`表單驗證的class，  
將表單驗證存入Ticket中的`UserData`取出之後存入`Context.User`，  
以下是`Global.asax`中的程式碼:
```c#
/// <summary>
/// 登入成功權限加入
/// </summary>
/// <param name="sender"></param>
/// <param name="e"></param>
protected void Application_AuthenticateRequest(object sender, EventArgs e)
{
   if (Request.IsAuthenticated)
   {
     FormsIdentity id = (FormsIdentity)User.Identity;
     FormsAuthenticationTicket ticket = id.Ticket;
     string[] roles = ticket.UserData.Split(new char[] { ',' });
     Context.User = new GenericPrincipal(Context.User.Identity, roles);
    }
}
```
`FormsAuthenticationTicket`:
```c#
FormsAuthenticationTicket ticket = new FormsAuthenticationTicket(1,
                                                                 login.USER_ACC,//User,通常塞User帳號
                                                                 DateTime.Now,
                                                                 DateTime.Now.AddMinutes(300),
                                                                 true,
                                                                 login.USER_AUTHORITY.ToString(),//UserData,可塞權限角色代碼
                                                                 FormsAuthentication.FormsCookiePath);
string enticket = FormsAuthentication.Encrypt(ticket);
Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, enticket));
```  
如果是沒權限的角色要使用Function便會把他導回Web.config中重新導向的網址  
```c#
    <authentication mode="Forms">
      <forms loginUrl="~/System/Index" timeout="480" protection="All" slidingExpiration="true" />
    </authentication>
```
