### Vue 列表搜尋
>上網查到在Vue 1.0版本可用的filterBy(應該是沿自AngularJS的filter)已經不能用了，所以2.0版本filter功能必須自己加  
>參考網址:https://codepen.io/AndrewThian/pen/QdeOVa

#### 步驟1
* HTML裡的`<input />`必須給他`v-model="search"(search名稱自訂)`讓他啟用Vue model屬性，變成`<input type="text" v-model="search"/>`
* v-for裡的`data in datas`，datas必須是filter過後的資料
#### 步驟2
JavaScript裡:  
```javascript
<script type="text/javascript">     
new Vue({
            el: '#mydiv',
            data: {
                search:'',
                TableData: ViewbagData, 
            },
            methods: {
                keywordscheck: function (value) {
                    return value.SERVERFUNTION.toLowerCase().includes(this.search.toLowerCase());
                }
            },
            computed: {
                filterlist: function () {
                    return this.TableData.filter(this.keywordscheck);
                }
            }
        })
    </script>
```
* `TableData`:後端撈出來要搜尋的資料
* `search`:`<input type="text" v-model="search"/>`中v-model裡的參數，預設為空(剛進入畫面還沒使用搜尋)
* `computed`:先講computed，computed與method這兩個區塊其實都能把function放進去，
只是computed裡的function只有在function裡相關參數有變動到的時候才會執行，而method裡的function只要Vue裡有任何資料改變都會進行function動作，
因此若要追求效能，只有相關變數改動才執行function時可用computed。而這篇裡的computed放的是用來做回傳篩選過後的data的function，裡面呼叫的是methods裡的
keywordscheck方法  
* `methods`:裡面放的是keywordscheck function，用來判斷要搜尋的欄位裡包不包含`v-model`裡我們輸入的關鍵字，在使用javascript的filter()函式篩選出資料
>`filter()`方法:傳回符合回呼函式中指定之條件的陣列元素。  
>語法:array1.filter(callbackfn[, thisArg])  
>參考網址:https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/Array/filter  
   
>因為使用VS2012開發，它的javascripts版本不到ES6，所以filter內使用的function寫在methods裡，不然可直接用連結內的lambda語法做filter()

#### 步驟3
HTML中列表使用`v-for="data in filterlist`列出資料
```c#
 <table>
                    <thead>
                        <tr>
                            <th>資料表頭/th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="data in filterlist">
                            <td>{{data.SERVERFUNCTION}}</td>
                        </tr>
                    </tbody>
                </table>
