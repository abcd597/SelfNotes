### 後端呼叫跨站api
>call api步驟:  
>1.宣告`HttpiClient()`  
>2.得api網址  
>3.組參數(如果是post的話，get就不用)  
>4.呼叫`HttpResponseMessage`，呼叫api  
>5.確認成功語法`EnsureSuccessStatusCode()`  
>6.接收api來的資料  

```c#
public async Task<ObjectClass> CallApiFunction(string ApiUrl, string parameter1, string parameter2, string parameter3)
{
     HttpClient client = new HttpClient();
     var api_input = JsonConvert.SerializeObject(new API_Input(parameter1,parameter2,parameter3));//組參數&把Object轉成Json
     HttpResponseMessage response = await client.PostAsync(ApiUrl, new StringContent(api_input, Encoding.UTF8, "application/json"));//call api
     response.EnsureSuccessStatusCode();
     string responseBody = await response.Content.ReadAsStringAsync();
     var data_get = JsonConvert.DeserializeObject<ObjectClass>(responseBody);
     return data_get;
}
```

`new StringContent(api_input, Encoding.UTF8, "application/json")`因為api接受的傳入參數型態是Json字串，
所以在`JsonConvert.SerializeObject(new API_Input(parameter1,parameter2,parameter3));`後再把她轉成Json String，
而得到的回傳資料也是Json String，所以也需要將它反序列化回Object，
而建立Function的型態`async Task<T>`，採用async非同步方法是必要的，
更多可以看[官方文件](https://docs.microsoft.com/zh-tw/dotnet/csharp/language-reference/keywords/async) 
而使用非同步宣告就必須搭配`await`運算子，一樣可以看[官方文件](https://docs.microsoft.com/zh-tw/dotnet/csharp/language-reference/keywords/await)
