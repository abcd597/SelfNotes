### SqlCommand帶入複數變數  
  
使用`SqlCommand.CommandText`可以建立T-SQL字串，為了避免SQL Injection漏洞，要由外部帶入的變數可以使用`@parameter`變數前加個 **@** 的方法，
之後再使用`SqlCommand.Parameters.AddWithValue("@paramter",InputParameter)`帶入外部的InputParameter參數，但是這方法一次只能帶入1個變數，
如果要一次帶入多個變數`@para1,@para2,@para3`這樣，就必須使用`SqlParameter`類別配合`AddRange()`方法操作 
  
如果今天有這樣一個SQL敘述
```c#
using (SqlConnection con = new SqlConnection(connectionString))
{
     using (SqlCommand command = new SqlCommand())
       {
               command.CommandType = CommandType.Text;
               command.CommandText = "select * from list l where l.id=@para1 and l.name=@para2 and l.phone=@para3;";//T-SQL
               command.Parameters.AddWithValue("@para1", para1);//Parameter1
               command.Parameters.AddWithValue("@para2", para2);//Parameter2
               command.Parameters.AddWithValue("@para3", para3);//Parameter3
               command.Connection = con;
               con.Open();
               /*command.Execute()*/
               con.Close();
        }
}
```
有3個`@para`變數，如果使用`Parameters.AddWithVlaue`就必須打3行帶入3次

而使用SqlParameter後可以改寫成這樣  
```c#
command.CommandText = "select * from list l where l.id=@para1 and l.name=@para2 and l.phone=@para3;";
SqlParameter[] p = new SqlParameter[] {new SqlParameter("@para1",para1),new SqlParameter("@para2",para2),new SqlParameter("@para3",para3)};
command.Parameters.AddRange(p);
command.Connection = con;
con.Open();
/*command.Execute()*/
con.Close();
```
也可把SqlParameter行直接寫在`AddRange()`裡  
```c#
command.Parameters.AddRange(new SqlParameter[] {new SqlParameter("@para1",para1),new SqlParameter("@para2",para2),new SqlParameter("@para3",para3)});
```
能夠再少掉一行~

