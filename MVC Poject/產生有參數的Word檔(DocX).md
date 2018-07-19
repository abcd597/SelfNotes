### 產生可更改參數的word檔案套件

>一個蠻好用的套件，在程式中先放入一個固定格式的word檔，檔案裏面的資料值可以用變數去更改數值，  
>最後再讓使用者下載

1.下載DocX  
去Nuget管理員搜尋下載DocX套件  
![nuget download](https://github.com/abcd597/SelfNotes/blob/master/MVC%20Poject/DocX%20Nuget%20Download.png)  
2.專案加入一個存放Word檔的資料夾，並加入word檔案，需要兩個檔案，1個放參數未放值前的，1個放帶入數值之後的
![add folder](https://github.com/abcd597/SelfNotes/blob/0ae525fe0e59f199b8e1344f3bfaa7097090ea7f/MVC%20Poject/DocX%20Word%20Folder.png)  
3.Controller 中include DocX參考  
```c#
using Xceed.Words.NET;
```
4.建立Controller並加入word中的參數
```c#
public ActionResult WordDownload() {
            string wordpath = Server.MapPath("~/Word/docxsample.docx");//未帶入變數前檔案
            string SavePath = Server.MapPath("~/Word/docxsample_valued.docx");//帶入變數後檔案
            DocX document = DocX.Load(wordpath);
            document.ReplaceText("{{title}}", "這是標題");//替換word中的變數
            document.ReplaceText("{{name}}", "John Smith");
            document.ReplaceText("{{birthday}}", "1900/01/01");
            document.ReplaceText("{{phonenumber}}", "1234-5678");
            document.ReplaceText("{{downloadtime}}", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            document.SaveAs(SavePath);//將帶入變數結果儲存
            return File(SavePath, "application/docx","DocX範例.docx");
}
```
5.下載結果
![download word](https://github.com/abcd597/SelfNotes/blob/0ae525fe0e59f199b8e1344f3bfaa7097090ea7f/MVC%20Poject/DocX%20WordDownload.png)
