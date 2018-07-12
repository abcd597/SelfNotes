### MVC PartialView(部分檢視)
>MVC 部分檢視功能，蠻簡單使用的，紀錄一下

#### 1.Controller中建立ActionResult
如果不會經由後端撈資料可以跳過個步驟直接在前端呼叫Partial就好
```c#
 public ActionResult MyPartial() {
    var data = getdata();//撈資料
    return PartialView("_MyPartial", data); //return資料至PartialView畫面
}
```
#### 2.建立PartialView
在要新增的View資料夾裡面加入檢視  
![Image](https://github.com/abcd597/SelfNotes/blob/master/MVC%20Poject/AddPartialView.png)  
`建立成部分檢視`要打勾，也可建立強型別檢視來做剛剛撈的資料的綁定

#### 3.刻PartialView畫面
製作PartialView畫面，利用剛剛綁定的強型別資料來製作  
>可以使用css做畫面調整，但是javascript不能在外面用`@section scripts{}`包住，直接使用`<script></script>`就好

#### 4.在其他畫面呼叫PartialView  
直接使用Razor的HtmlHelper呼叫  
```c#
@{
Html.RenderAction("MyPartial", "MyController");
}
```
或是利用ajax呼叫後段function之後塞進標籤裡
```c#
<div id="MyHtmlPartial"></div>
<script>
/*利用JQuery的ajax get撈出整個Partial的Html，再塞進div MyHtmlPartial裡*/
 $.get('@Url.Action("MyPartial", "MyController")', function (response) {
            $('#MyHtmlPartial').html(response);
 }
</script>
```

**製作好的Partial可再搭配Bootstrap的Carousel幻燈片功能或是Modal彈出視窗功能呼叫**
