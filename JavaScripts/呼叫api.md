### Javascript呼叫api(使用JQuery)

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
