#### MVC上使用ReportViewer
>使用ReportViewer for MVC套件   
>套件網站: https://github.com/armanio123/ReportViewerForMvc


##### 步驟1:下載ReportViewer for MVC
去下載ReportViewer for MVC
VS使用Nuget搜尋`ReportViewerForMvc`
`PM> Install-Package ReportViewerForMvc`
##### 步驟2建立報表檔案.rdlc
要建立.rdlc要先建立DataSet.xsd資料集，
才能在報表檔裡使用讀取的資料

##### 步驟3後端撈取資料塞到 ReportViewer()的屬性裡
後端撈完資料後要設定ReportViewer的各種環境屬性
```c#
public ActionResult A()
{
    ReportViewer reportViewer = new ReportViewer();
    reportViewer.ProcessingMode = ProcessingMode.Local;
    reportViewer.SizeToReportContent = true;
    reportViewer.LocalReport.ReportPath = Request.MapPath(Request.ApplicationPath) + @"\Report\DataReport.rdlc";//報表檔案存放路徑
    string UserName = "";
    using(user u=new user()){
    UserName = u.Get_One_User(User.Identity.Name.ToString()).AFB_USER_NAME;
    }
    using (foreign f = new foreign())
    {
    var data=InputDate==null?f.DataForReport();
    reportViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSet1",data));//撈的資料塞到dataset裡
    reportViewer.LocalReport.SetParameters(new ReportParameter("User", UserName));
    reportViewer.LocalReport.SetParameters(new ReportParameter("datetime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
    }
    ViewBag.ReportViewer = reportViewer;
    return View();
}
```
#### 步驟4前端輸出
cshtml畫面上面要先加上`@using ReportViewerForMvc;`把套件include進來才能用html.helper直接帶出報表

```c#
@using ReportViewerForMvc;
<style>
    #reportviewer_control
    {
    <!--設定報表的最大高度-->
    max-height:768px;
    }
</style>
<div style="text-align: center" id="ReportViewerArea">
    @Html.ReportViewer(ViewBag.ReportViewer as Microsoft.Reporting.WebForms.ReportViewer, new { id = "reportviewer_control", style = "width:90%;height:90%;text-align:center;" })
</div>
```
