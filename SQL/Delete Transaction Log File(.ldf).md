### 1.  
select Database Property→select "Option" in menu→change the "recovery mode" to "simple"→apply 

### 2.  
```sql
select * from sys.database_files
```   
record the "name" column which value is "xxx_Log" 

### 3.  
```sql
DBCC SHRINKFILE (xxx_Log , 2)
```  

### 4.  
change the recovery mode back 
