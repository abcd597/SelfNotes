# Vue.js簡單介紹

>### 使用Vue.js步驟:
> 1. include js
> 2. javascript裡Vue.js宣告
> 3. html元件加入對應Vue屬性

### 1. include js
畫面先需include Vue.js的相關檔案才能用Vue語法，
可以去官網下載.js檔或直接用CDN加入:    
(1) Vue.js 本身檔案:   
```javascript
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
```
(2) Bootstrap for Vue:
```javascript 
<script src="https://cdn.jsdelivr.net/npm/bootstrap-vue@2.0.0-rc.11/dist/bootstrap-vue.common.min.js"></script> 
```
(3) Vue 使用的ajax:     
```javascript
<script src="https://unpkg.com/axios/dist/axios.min.js"></script> 
```
***
### 2. javascript裡Vue.js宣告
使用Vue.js需要先在javascript裡宣告Vue的物件才能使用後續語法
```javascript
<script type="text/javascript">  
new Vue({ 
 el: '#id', //使用Vue 區塊的id
data: {  }, //使用Vue 語法塞值要使用的data
 methods: {  } //事件處理使用的function擺這
})
</script>
```
```html
<div id="id"></div>
```
***
### 3. html元件加入對應Vue屬性
要在畫面中顯示的資料要使用data內給予參數綁定，
要使用function則要在method裡建立
基本Vue語法:
#### 1) {{參數1}}  *在html中直接顯示參數*
```javascript
<script type="text/javascript">  
new Vue({ 
 el: '#div1', //使用Vue 區塊的id
data: {
par1:"參數A"
}
})
</script>
```
```html
<div id="div1">
{{par1}} <!--將顯示「參數A」-->
</div>
```
#### 2)使用 v-* 屬性
>最常用到的兩個屬性 :
>v-bind  : 綁定html屬性，id、href、value、自訂參數...etc
>v-on     : 處理事件，click、change...etc
>兩者有簡寫語法 :
>```Vue 
><a v-bind:href="url"></a> = <a :href="url"></a> 
> <a v-on:click="doSomething"></a> = <a @click="doSomething"></a>
>```
* v-if="para1"--*就是if，等號後面參數加在data:{ }裡，true | false*
* v-else-if : *if系列語法*
* v-else : *if系列語法*
* v-show : *等同v-if*
* `v-for="data in datas"` : * 用在迴圈列出列表，table、dropdown list....清單類的都能使用，
ex:
```Vue
   <tr v-for="data in TableData">  
   <td>{{data.SERVERTYPE}}</td>  
   <td>{{data.SERVERFUNTION}}</td>   
   <td>{{data.SERVERLINK}}</td>   
   </tr> 
```
datas為Json 資料，data為datas的子元素，可以為物件或元素，可為多值ex: `v-for="(value, key, index) in object`*
* `v-model` : * 用來做資料雙向繫結使用*
#### 3)method
Vue 用來處理function的語法
```javascript
new Vue({
el: '#id', 
data: {  },
methods: {
method1:function(){
/*function內容*/
}
}
})
```



