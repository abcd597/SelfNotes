### Vue的Component
>Vue.js的最大特色應該就是他的component了，可以定義重複使用的元件

#### 步驟1 Vue.component的宣告
```Vue
<script type="text/javascript">
Vue.component('name1',{template: '<h2>Component Test!</h2>'});
Vue.component('hr1',{template: '<hr />'});
new Vue({
el:'#mydiv',
data:{}
});
</script>
```
Component的宣告很簡單，最基本的:`Vue.component('標籤名字',{template: '元件內容'});`，基本的`new Vue({})`建構宣告還是要有

#### 步驟2 在HTML中使用
```Vue
<div id="mydiv">
<name1></name1>
<hr1></hr1>
<name1></name1>
<name1></name1>
<hr1></hr1>
</div>
```
#### 帶入參數
component也可以使用帶參數的方法對component的內容使用參數變化
```javascript
 Vue.component('tablethead', { props: ['title'], template: '<th>{{title}}</th>' });
 new Vue({
            el: '#mydiv',
            data: {
                titles: ["表頭1", "表頭2", "表頭3"],
            }
          })
```
```Vue
<table>
<thead>
<tr><th is="tablethead" v-for="title in titles" v-bind:title="title"></th></tr>
</thead>
<tbody>
<tr><td>1</td><td>2</td><td>3</td></tr>
</tbody>
</table>
```
表格表頭部分便可藉由參數帶入列出  
![Image](https://github.com/abcd597/SelfNotes/blob/master/Vue/table.png)
