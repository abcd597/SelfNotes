```sql
select xmlcolumn.value('(/parent/child1/child2.../valuename/node())[1]','nvarchar(50)') from table
```
