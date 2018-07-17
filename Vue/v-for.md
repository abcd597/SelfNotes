### v-for用法

>v-for是個很好用的產生列表東西，可以用在各種需要loop產生資料的地方，table、select等等  

1. v-for select
如果要在下拉選單使用v-for，v-for必須加在`<option></option>`裡，而`<select></select>`裡面則需要一個`v-model=""`來綁定選到的值，
```c#
<div id="myVue">
<select v-model="TypeSelected">
    <option v-for="data in tooltype" :value="data.value">{{data.name}}</option>
</select>
</div>
<script>
new Vue({
el:"#myVue",
data:{
tooltype: [{ "name": "汽車", "value": "C" }, { "name": "機車", "value": "M" }],
TypeSelected:""  
     }
})
</script>
```
2. v-for table  
table裡使用`v-for`的話，可以使用在表頭`<th></th>`裡loop產生，  
以及在`<tr></tr>`裡產生資料列表，如果查詢網頁分兩部分，上半部是查詢條件，下面是查出資料，  
表頭相同的話，`<th></th>`部分可以用Vue的Component來製作 [可參考這](https://github.com/abcd597/SelfNotes/blob/master/Vue/Vue%E7%9A%84Component.md)
```c#
<div id="myVue">
  <table>
    <thead>
      <tr>  
        <th v-for="data in TableHead">{{data}}</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="data in TableData">
        <td>{{data.name}}</td>
        <td>{{data.value}}</td>
      </tr>
    </tbody>
  </table>
</div>

<script>
new Vue({
el:"#myVue",
data:{
TableHead:["種類","數值"],
TableData:[{"name":"汽車","value":"C"},{"name":"機車","value":"M"}]
	}
})
</script>
```

