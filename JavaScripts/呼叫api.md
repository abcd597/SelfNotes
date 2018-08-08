### Javascript呼叫api(使用JQuery)

javascript呼叫api不算難，跟使用ajax一樣，使用JQuery的話，只要知道api網址，要傳甚麼參數過去，跟參數型態就好~

```javascript
<script>
        $(function () {
            var jsonData = {};//要傳給api的參數
            
            $.ajax({
                type: "POST",
                url: ApiUrl,
                data: JSON.stringify(jsonData),
                contentType: "application/json",
                success: function (response) {
                    console.log(response);
                    /*成功後動作*/
                }
            });
         })
    </script>
```
`JSON.stringify(jsonData)`這裡因為api那邊接受的型態是JSON，所以必須先把jsondata(原本是Object)給轉型成JSON字串，
而有個宣告很重要`contentType: "application/json"`，必須要加上去，通知api說，我傳過去的參數是JSON，否則會呼叫失敗，
這也是為什麼不能用`$.post()`而必須要用`$.ajax()`傳完整的ajax資訊過去的原因。
