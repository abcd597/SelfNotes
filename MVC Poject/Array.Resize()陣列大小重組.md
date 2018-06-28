### 陣列大小重組Array.Resize()

>在還不知道IEnumerable這東西的時候需要把已設定長度的陣列改變大小(動態改變陣列長度)，所使用的方法   
>參考網站:https://msdn.microsoft.com/zh-tw/library/bb348051(v=vs.110).aspx
```c# 
string[] array1 = { "", "" };
Array.Resize(ref array1, new_length);
```
就能重新定義陣列長度
