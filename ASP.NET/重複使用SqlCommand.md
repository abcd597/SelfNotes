### 重複使用SqlCommand

>連結資料庫的步驟是宣告SqlConnection→宣告SqlCommand→建立SqlCommand.CommandText→建立SqlCommand.Connection→SqlConnection.Open()→SqlCommand.Execute→SqlConnection.Close()  
>原以為每個Execute(ExecuteReader()、ExecuteNonQuery()....等等)都要一次SqlConnection.Open()，SqlConnection.Close()  
>但後來找到方法其實不用，在這紀錄一下

網路上有找到兩種解決方法解決重複使用SqlCommand:  
1.ConnectionString 增加 `MultipleActiveResultSets=true`(我用了沒效果，或可以說不影響要再研究)  
2.先把它.ToList()  
但我遇到的狀況是顯示 *已經開啟一個與這個 Command 相關的 DataReader，必須先將它關閉。* ，
以為是遇到網路上查到的不能重複使用SqlCommand的狀況，後來發現是我在第1次對DB做IO時有做個`while (reader.Read())`，
但沒有將reader關閉
```c#
using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand()) {
                        command.CommandText = "select * from list";
                        command.Connection = con;
                        con.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        while (reader.Read()) {
                         /*資料處理*/
                        }
                            command.Parameters.Clear();
                            command.CommandType = CommandType.Text;
                            command.Connection = con;
                            command.CommandText = @"delete from list where id=@id;
                                                    update list set id = id-1 where id > @id;";
                            command.Parameters.AddWithValue("@id",id);
                            command.ExecuteNonQuery();
                        }
                        con.Close();

                    }
                }
```
這時出現了 *已經開啟一個與這個 Command 相關的 DataReader，必須先將它關閉。* 錯誤
只要做個`reader.Close();`就能解決!
```c#
using (SqlConnection con = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand()) {
                        command.CommandText = "select * from list";
                        command.Connection = con;
                        con.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        while (reader.Read()) {
                         /*資料處理*/
                        }
                        reader.Close();//加這行
                        command.Parameters.Clear();
                        command.CommandType = CommandType.Text;
                        command.Connection = con;
                        command.CommandText = @"delete from list where id=@id;
                                                update list set id = id-1 where id > @id;";
                        command.Parameters.AddWithValue("@id",id);
                        command.ExecuteNonQuery();
                        }
                        con.Close();
                    }
                }
```
