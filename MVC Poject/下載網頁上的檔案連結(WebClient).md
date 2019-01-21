### 下載網頁上的檔案連結(WebClient)

>當初開發時寫了一段程式碼，目的是抓政府關務署裡面每旬的報關匯率，
>那時後的做法是利用`HtmlAgilityPack`把整個畫面抓下來轉成HtmlDocument後，
>很土法煉鋼的去找畫面上表格有幾欄幾列後去做成陣列塞key跟value，然後再用雙迴圈做成json傳給前端，
>非常暴力破解的方法。

>結果最近發現畫面改版重置了，而且也提供個json檔的link可以下載(已前只有.txt的樣子)，那整個過程就變的簡單很多~


#### 當初的程式碼(連結已失效，當時的畫面就是個很傳統的table然後列出國家|貨幣|年|月|買進匯率|賣出匯率)   
```c#
                using HtmlAgilityPack;
                //指定來源網頁
                WebClient url2 = new WebClient();
                //將網頁來源資料暫存到記憶體內
                MemoryStream ms2 = new MemoryStream(url2.DownloadData("http://web.customs.gov.tw/currency/currency/currency.asp?qry=0&language=c"));
                //每旬報關匯率查詢
                // 使用預設編碼讀入 HTML
                HtmlDocument doc2 = new HtmlDocument();
                //doc2.Load(ms2, Encoding.UTF8);
                doc2.Load(ms2, Encoding.Default);

                //49個<tr>標籤
                int tr_number = doc2.DocumentNode.ChildNodes[2].ChildNodes[3].ChildNodes[1].ChildNodes[16].ChildNodes[1].ChildNodes[8].ChildNodes.Count;
                //int tr_number = doc2.DocumentNode.ChildNodes[2].ChildNodes[3].ChildNodes[1].ChildNodes[16].ChildNodes[1].ChildNodes[7].ChildNodes.Count;
                //17個<td>標籤在49個<tr>標籤裡
                int td_number = doc2.DocumentNode.ChildNodes[2].ChildNodes[3].ChildNodes[1].ChildNodes[16].ChildNodes[1].ChildNodes[8].ChildNodes[1].ChildNodes.Count;
                string[,] test = new string[(tr_number - 1) / 2, (td_number - 1) / 2];//陣列大小

                for (int i = 0; i < (tr_number - 1) / 2; i++)//製作二維陣列
                {
                    for (int j = 0; j < (td_number - 1) / 2; j++)
                    {
                        test[i, j] = doc2.DocumentNode.ChildNodes[2].ChildNodes[3].ChildNodes[1].ChildNodes[16].ChildNodes[1].ChildNodes[8].ChildNodes[2 * i + 1].ChildNodes[2 * j + 1].InnerText;
                    }
                }
                #region 把上面2維陣列做成json字串
                string json_doc2 = "[";
                for (int i = 0; i < (tr_number - 1) / 2; i++)
                {
                    json_doc2 += "{";
                    for (int j = 0; j < (td_number - 1) / 2; j++)
                    {
                        switch (j)
                        {
                            case 0:
                                json_doc2 += '"' + "country" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 1:
                                json_doc2 += '"' + "cur_ch" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 2:
                                json_doc2 += '"' + "cur" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 3:
                                json_doc2 += '"' + "year" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 4:
                                json_doc2 += '"' + "month" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 5:
                                json_doc2 += '"' + "month_part" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 6:
                                json_doc2 += '"' + "buy_rate" + '"' + ":" + '"' + test[i, j] + '"' + ",";
                                break;
                            case 7:
                                json_doc2 += '"' + "sell_rate" + '"' + ":" + '"' + test[i, j] + '"';
                                break;
                        }
                    }
                    json_doc2 += i == (tr_number - 3) / 2 ? "}" : "},";
                }
                json_doc2 += "]";
                #endregion
                return Json(json_doc2, JsonRequestBehavior.AllowGet);
```

### 現在的方法
首先政府提供了開放資料的平台可以下載JSON檔案:https://data.gov.tw/dataset/6708   
如果連結都不會改變，直接複製裡面JSON按鈕的URL來用就好    
```c#
            using System.Net;
            using Newtonsoft.Json;
            WebClient w = new WebClient();
            var downloadJSON=w.DownloadString("https://portal.sw.nat.gov.tw/APGQ/GC331!downLoad?formBean.downLoadFile=CURRENT_JSON");
            var jsonObject = JsonConvert.DeserializeObject<RootObject>(downloadJSON);//轉成RootObject class之後的資料  
```
```c#
             public class Item
             {
             public string code { get; set; }
             public string buyValue { get; set; }
             public string sellValue { get; set; }
             }

             public class RootObject
             {
             public string start { get; set; }
             public string end { get; set; }
             public List<Item> items { get; set; }
             }
```
製作class的方法是用了一個很方便的網站[json2csharp](http://json2csharp.com/)   
可以直接貼上json string，網站會幫忙轉成class顯示!
