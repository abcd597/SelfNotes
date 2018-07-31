### 數字補0
改舊系統看到一段舊的程式碼，要在下拉選單建立1~12月的選項，只有1位數的話要補0，舊程式是用for迴圈判斷`<10`前面加0，但其實用ToString()就能解決
  
1.
```c#
for (int i = 1; i <= 12; i++)
{
        if (i < 10)
        {
            ddlmonth.Items.Add("0" + i.ToString());
        }
        else
        {
            ddlmonth.Items.Add(i.ToString());
        }
}
```
舊程式做法，如果月份小於10，10位數補0，但是既然都用到`ToString()`這方法了，可以直接在這裡增加參數補0就好  
  
2.
```c#
for (int i = 1; i <= 12; i++)
{
   ddlmonth.Items.Add(i.ToString("00"));
}
```
8行code → 1行
