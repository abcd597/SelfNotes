```javascript

function checkAccount(){
    var result = 1;
    $.ajax({
        url : 'test.do',
        type : "post",
        data : {},
        async : false,
        success : function(data) {
            result = 2;
        }
    });
    return result;

```
