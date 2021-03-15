###C#使用Memory Cache
宣告   
```csharp
System.Runtime.Caching.ObjectCache myDataCache = System.Runtime.Caching.MemoryCache.Default;
```

```csharp
if (null != myDataCache.Get("myCache"))//如果快取還在
        {
            DataWantCache = (Dictionary<int, string>)myDataCache["myCache"];//取用快取
        }
else{
#region取得資料動作
  //Do something...
  //Get data
#endregion
    System.Runtime.Caching.CacheItemPolicy policy = new System.Runtime.Caching.CacheItemPolicy();//set cache expiration time
    policy.SlidingExpiration = TimeSpan.FromDays(3);//expiration time= 3 day
    subproglistDataTabkeCache.Set("myCache", data, policy);//set cache
    }
```
