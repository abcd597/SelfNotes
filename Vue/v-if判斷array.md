### v-if判斷array是不是空

Vue在宣告array時會給個`array:[]`來建立陣列，但是如果陣列沒值又要用`{{array}}`來綁定資料時就會直接跑出 [] 在畫面上，
這時候可以用`v-if="array.length"`來控制如果是[]就不顯示，之前使用`v-if="array!=[]"`這樣會沒反應，必須利用陣列長度判斷
[參考網址](https://stackoverflow.com/questions/49152074/vue-print-array)

但是如果跟v-for同一行就能直接用`v-for="array!=[]"`來控制，可能要再研究
```c#
 <tr v-for="(data,key,i) in Data" v-if="Data!=[]"><!--可行-->
```
