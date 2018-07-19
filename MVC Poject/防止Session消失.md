### 防止Session自動消失(Web.config)
>有時會用session來儲存某些資料(登入驗證或常駐欄位)，可是就算在web.config中設定了timeout，  
>而且IIS中也有設定了時間，還是在短時間內就會遺失session，後來經前輩指導，只要在web.config中更改個地方就OK了!

1.  
```c#
<sessionState mode="InProc" customProvider="DefaultSessionProvider" timeout="480">
```
原本web.config中有關session狀態的設定會是這樣。

2.  
```c#
<sessionState mode="StateServer" stateConnectionString="tcpip=localhost:42424" timeout="480">
```
修改為這樣，在發行後放上IIS就行了，不過如果是本機開發階段必須使用1.的那行，不然會不能debug
