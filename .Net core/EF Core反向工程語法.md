> [官方文件連結](https://docs.microsoft.com/zh-tw/ef/core/managing-schemas/scaffolding?tabs=dotnet-core-cli)  

使用EF Core但自料庫已建好資料表時可用反向工程建立Entity Model  

```c#  
Scaffold-DbContext "Data Source=DBSource;Initial Catalog=DBName;User id=Account;password=Password" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Entity -Tables "table1","table2","table3","table4","table5" -ContextDir Context -Context EntityContext
```
