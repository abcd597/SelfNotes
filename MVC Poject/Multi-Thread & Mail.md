### 多執行緒語送信
>這裡紀錄一下多執行緒的使用與送信的方法  
>當初會這樣用是為了在User填完表單送出後同步送信通知新增了這張單子給要去簽核的人，  
>但是不使用多執行續會讓按下送出按鈕後卡住個10秒左右，之後想到或許可以利用多執行緒背景可以同時運作的特性來達成  
>讓User按下送出後，背景執行送信部分，前景則做其他操作(跳轉頁面等等)

1.Thread
```c#
using System.Threading;

public void UseThread() {
            Thread t = new Thread(sendmail)
            {
                IsBackground = true
            };
            t.Start();
        }
```
簡單的建立Thread與執行，但是Thread還有很多很多事情可以做，  
可以再研究官網 https://msdn.microsoft.com/zh-tw/library/system.threading.thread(v=vs.110).aspx  

2.Mail
```c#
using System.Net.Mail;

public void sendmail()
        {
            MailMessage m = new MailMessage
            {
                From = new MailAddress("demo@demo.com.tw"),
                Subject = "測試",
                Body = "測試的<strong>內容</strong>",
                IsBodyHtml = true
            };
            m.To.Add(new MailAddress("demo@demo.com.tw"));
            m.CC.Add(new MailAddress("demo@demo.com.tw"));
            SmtpClient c = new SmtpClient("demo.com.tw");
            //c.Credentials = new NetworkCredential(mailAccount, mailPwd);
            c.Send(m);
        }
```
`From`:寄信人  
`Subject`:標題  
`Body`:內容  
`IsBodyHtml`:是不是HTML格式，有可能因此被當垃圾郵件  
`m.To.Add`:收信人，可用迴圈增加  
`m.CC.Add`:CC，可用迴圈增加
`SmtpClient`:SMTP Server
`Credentials`:SMTP Server驗證，當SMTP Server需要帳密驗證時，則需要這行   
`Send()`:將信寄出  


這樣便可做到利用背景執行緒來送信，又不影響前端畫面操作!


