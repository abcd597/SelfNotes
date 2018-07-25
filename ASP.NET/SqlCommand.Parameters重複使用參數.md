### 重複使用SqlCommand.Parameter帶入參數

在改公司舊系統SQL Injection遇到的問題:
```c#
using (SqlConnection con = new SqlConnection(connectionString)) {
     using (SqlCommand command = new SqlCommand()) {
     command.CommandText = "select * from list where id=@id";
         command.Parameters.AddWithValue("@id", id);
         command.Connection = con;
         con.Open();
         SqlDataReader reader = command.ExecuteReader();
         while (reader.Read()) {
         /*資料處理*/
         }
        con.Close();
        /*資料處理*/
        command.CommandText = @"delete from list where id=@id;
                                update list set id = id-1 where id > @id;";
        command.Parameters.AddWithValue("@id",id);
        command.Connection = con;
        con.Open();
        command.ExecuteNonQuery();
        con.Close();
     }
}
```
這時出現了*變數名稱在一個查詢批次或預存程序內必須是唯一的*錯誤，  
上網查了後發現是`@id`被重複宣告且使用了，所以出錯，  
解決方法，最直接的就是把第2次宣告的`@id`名稱改掉`@id2`之類的，  
但是這樣就沒有它其實是同一個參數的意義了，  
這是需要在第2次使用`command.CommandText`之前加一句`command.Parameters.Clear();`  
將之前宣告使用的parameter清空，之後就可以在重複宣告`@id`哩~  
```c#
using (SqlConnection con = new SqlConnection(connectionString)) {
     using (SqlCommand command = new SqlCommand()) {
     command.CommandText = "select * from list where id=@id";
         command.Parameters.AddWithValue("@id", id);
         command.Connection = con;
         con.Open();
         SqlDataReader reader = command.ExecuteReader();
         while (reader.Read()) {
         /*資料處理*/
         }
        con.Close();
        /*資料處理*/
        command.Parameters.Clear();//添加這行清空Parameter
        command.CommandText = @"delete from list where id=@id;
                                update list set id = id-1 where id > @id;";
        command.Parameters.AddWithValue("@id",id);
        command.Connection = con;
        con.Open();
        command.ExecuteNonQuery();
        con.Close();
     }
}
