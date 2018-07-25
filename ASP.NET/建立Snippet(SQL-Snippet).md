### 建立Snippet

>改SQL Injection改到厭世，沒次都要打一大串`SqlConnection`、`SqlCommand`、`CommandText`甚麼有的沒的，決定把它寫成程式碼片段用快捷鍵帶出來~  
>檔案連結[SQL-Snippet.snippet](https://github.com/abcd597/SelfNotes/blob/master/ASP.NET/SQL-Snippet.snippet)  

1.新增1個XML檔案
開Visual Studio→檔案→新增→檔案→XML檔  
  
2.建立snippet內容
```XML
<?xml version="1.0" encoding="utf-8"?>
<CodeSnippets
    xmlns="http://schemas.microsoft.com/VisualStudio/2005/CodeSnippet">
  <CodeSnippet Format="1.0.0">
    <Header>
      <Title>DB</Title>
      <Shortcut>cmd</Shortcut>
    </Header>
    <Snippet>
      <Code Language="CSharp">
        <![CDATA[
        using (SqlConnection con = new SqlConnection(ut.connectionString))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.CommandText = "";//T-SQL
                    command.Parameters.AddWithValue("","");//Parameter
                    command.Connection = con;
                    con.Open();
                    /*command.Execute()*/
                    con.Close();
                }
            }
        ]]>
      </Code>
    </Snippet>
  </CodeSnippet>
</CodeSnippets>
```
重要標籤:   
`<Shortcut>cmd</Shortcut>`:之後輸入啥快捷鍵(這裡是`cmd`)可以帶出這串程式碼  
`<Code Language="CSharp">`:使用甚麼語言，這裡是C#  
`<![CDATA[   ]]>`:中間中括弧內就塞希望產生的程式碼  

3.另存為副檔名`.snippet`的檔案
到這邊就算製作完成了，接下來是匯入

4.Visual Studio中→工具→程式碼片段管理員→選擇語言(這裡是Visual C#)→匯入→選剛剛儲存的那個.snippet檔案→選要儲存在哪個資料夾(My Snippet)→確定

5.在程式碼中使用
在程式碼中打`cmd`後 **按兩下`Tab`** 就會產生`<![CDATA[]]>`中的程式碼
