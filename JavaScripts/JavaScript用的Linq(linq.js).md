### JavaScript使用linq語法

>在JavaScript中使用linq處理資料，但語法會跟c#中的稍為不一樣  
>https://github.com/abcd597/SelfNotes/blob/master/JavaScripts/linq.min.js  
>官網: https://archive.codeplex.com/?p=linqjs

#### 1.下載+Include檔案
只要去官網下載檔案，把`linq.js`丟進專案就行了

#### 2.語法
不像c#可以直接`data.where(x=>x.name=="Tom")`這樣直接使用linq的函式，
前面要再多加`Enumerable.From(data)`，而且Select或是Where等function內也不能直接`.Select(x=>x.name)`這樣用，  
必須寫成`.Select(function(x){return x.name})`才行，而且之後要再ToArray()
```javascript
var LinqData = Enumerable.From(data)
               .Where(function (x) { return x.user.id < 200 })
               .OrderBy(function (x) { return x.user.screen_name })
               .Select(function (x) { return x.user.screen_name + ':' + x.text })
               .ToArray();
```
還有配合JQuery的用法，在官網有寫
