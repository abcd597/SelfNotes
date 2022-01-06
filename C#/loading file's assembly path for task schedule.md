### 排程程式有讀取檔案時程式路徑需調整


因為windows排程主程式是放在 C:\WINDOWS\System32 底下，  
所以如果有要讀檔案讀取路徑沒特別設定會變成C:\WINDOWS\System32\XXX，  
但是要排的檔案不一定會放在那邊，  
造成讀取檔案時找不到路徑出錯，  
所以語法要調整成: 
```csharp
Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location), "filename.xxx"))
```  
去讀取執行的組件(.exe)檔所在的路徑

