## Vue的ajax操作

>Vue.js的ajax操作跟AngularJS的幾乎一樣，只是需要先使用Axios來啟用$http的函式

#### 步驟1
include axios:
```javascript
 <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
 ```
***
#### 步驟2
在`<script></script>`裡宣告Vue的`$http`為axios來啟用`$http`方法
```javascript
Vue.prototype.$http = axios
```
***
#### 步驟3
在`mothod:{}`中製作ajax方法   
HTML:
```Vue
<button type="button" class="btn btn-success" role="button" v-on:click="btn_add()">新增</button>
```
javascript:
```javascript
 <script type="text/javascript">     
        Vue.prototype.$http = axios
        new Vue({
            el: '#mydiv',
            data: {
            TableData:[]
            },
            methods: {
                btn_add:function(){
                    var vm = this;
                    this.$http.post('/*action路徑*/', {/*參數*/})
                    .then(function(response){
                    vm.TableData = response.data;
                    /* 成功後動作 */
                    }, funciton(response){
                    /* 失敗後動作 */
                    });
                }
            }
        })
```
function中如果then裡使用的是`function(response){}`則必須在事件function內先加入`var vm=this;`，
以用來成功後更新TableData。
或可改寫為
`.then((reponse)=>{
this.TableData=reponse.data;
})`  
>Vue的ajax response不像jquery的可以直接使用response處理資料，要取到回傳資料值必須用`response.data`取值
