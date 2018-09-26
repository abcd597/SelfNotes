### Delete duplicate data in SQL Server
>如果在建立table時沒有設定primary key的話，就有可能會出現完全一模一樣的資料，  
>如果當初又沒有建一個increment的欄位(其實這也算一種primary key)，出現重複資料就很難處理，  
>這時候就可以用`ROW_NUMBER() OVER()`搭配`WITH AS`兩個SQL的語法來做處理
