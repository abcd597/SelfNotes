### Controller控制View的Alert
1. Controller部分
有catch到Exception時
```c#
catch (Exception e)
 {
   TempData["AlertMessage"] = "修改失敗!";
   return Redirect(ControllerContext.HttpContext.Request.UrlReferrer.ToString());
 }
```
`TempData["AlertMessage"] = "";`裡的字串可隨錯誤類型自己填寫  
`return Redirect(ControllerContext.HttpContext.Request.UrlReferrer.ToString());`回到上一頁  
2. View部分
放在Master Page(_Layout.cshtml)裡
```c#
@{
   var message = TempData["AlertMessage"] ?? string.Empty;
 }
<script>
   var message = '@message';
   if (message) alert(message);
</script>
```
>*Controller盡量不要去控制View的動作(前後端分離)，所以雖然好用但不建議*
