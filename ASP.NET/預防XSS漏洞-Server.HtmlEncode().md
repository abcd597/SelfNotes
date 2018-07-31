###預防XSS攻擊-Server.HtmlEncode()

>公司請廠商寫的舊系統弱點掃瞄出200多個XSS漏洞，與70多個SQL Injection，SQL Injection大部分都是因為T-SQL使用字串串接的原因造成，比較好改，
但XSS部分看了下報告都是ASP.NET的語法`<%= %>`造成，原以為這是ASP.NET的特色語法無法更改，不過爬了下Google後查到說可以使用Server.HtmlEncode()
解決這問題，後來隨便寫個畫面測試也確實有用

1.含XSS漏洞的寫法
```c#
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% 
        string test_par = "<script>alert('123')</script>";//可能是資料庫中被塞進的攻擊Javascript
    %>
    <div class="jumbotron">
        <h1><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </h1>
        <h1>
        <%= test_par %>
        </h1>
     </div>
</asp:Content>
```
執行後會直接alert出'123'，這就是XSS攻擊，惡意人士可能在填寫表單時塞入Javascript程式碼進DB，如果在儲存時沒做甚麼處理(白名單、黑名單篩選)，
這段Javascript Code就會直接被儲存進資料庫，之後在撈出來顯示在前端時就會被執行。  

2.使用`Server.HtmlEncode()`方法防範
```c#
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% 
        string test_par = "<script>alert('123')</script>";
    %>
    <div class="jumbotron">
        <h1><asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </h1>
        <h1>
        <%=Server.HtmlEncode(test_par)%>
        <%--<%:test_par%>--%>
        </h1>
     </div>
</asp:Content>
```
在原本的參數外多加個`Server.HtmlEncode()`function把參數包住，
程式會先將特殊字元`<`、`>`、`(`、`)`等等先進行編碼成這些符號原始的code`&lt;`、`	&gt;`之類的，
送到瀏覽器時會再經由瀏覽器識別這些code，最後顯示出編碼前的資料，這裡就會顯示出`"<script>alert('123')</script>"`這個字串，
而不是執行這段Javascript。
