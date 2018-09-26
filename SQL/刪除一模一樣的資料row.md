### Delete duplicate data in SQL Server
>如果在建立table時沒有設定primary key的話，就有可能會出現完全一模一樣的資料，  
>如果當初又沒有建一個increment的欄位(其實這也算一種primary key)，出現重複資料就很難處理，  
>這時候就可以用`ROW_NUMBER() OVER()`搭配`WITH AS`兩個SQL的語法來做處理
1.  
![duplicate data](https://github.com/abcd597/SelfNotes/blob/master/SQL/duplicate%20data.png)  
今天我有個這樣的table，裡面有大量的重複資料，如果直接下delete，會把所有的資料刪掉，這時候可以加個`ROW_NUMBER() OVER()`
語法:
```SQL
SELECT ROW_NUMBER() OVER (PARTITION BY A.ID ORDER BY A.ID DESC) AS ROWID,* FROM TABLE A;
````
  
![ROWID](https://github.com/abcd597/SelfNotes/blob/master/SQL/duplicate%20data_ROWID.png)  
便會幫它加上編號
  
2.
如果想要刪除重複資料但是保留唯一一個的話，需再配上`WITH AS`的語法，把剛剛加上編號的Table建立成類似虛擬Table的東西，並刪掉編號>1，也就是出現2次以上的資料
```SQL
WITH CTE AS(
SELECT ROW_NUMBER() OVER (PARTITION BY A.ID ORDER BY A.ID DESC) AS ROWID,* FROM TABLE A
)
DELETE FROM CTE WHERE ROWID>1;
```

