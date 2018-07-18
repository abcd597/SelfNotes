### 把JQuery datepicker包成Vue component使用  
>在Vue中使用jquery的東西有時會出錯或是沒反應，  
>上網查原因是說兩者的DOM會打架，所以若要使用jquery的套件，必須把它包裝成component比較好
>文章參考:https://vuejsdevelopers.com/2017/05/20/vue-js-safely-jquery-plugin/

今天試了在`<input v-for="" />`上額外在script中用了`$('input').datepicker()`讓他能啟用日期選擇器，  
一開始都能正常使用，但是如果input是動態產生的，再加`.datepicker()`會沒反應，單純只是個文字輸入框，
上網找了各種原因，發現是因為這兩個框架再產生DOM時會互相衝突，然後找到了必須把jquery的套件包在Vue的component裡，  
照做之後也確實能用，不過他對事件後產生的input還是有點問題，還要再研究。

1. 建立component
```javascript
<script>
Vue.component('input-date',{
        template:'<input class="form-control" autocomplete="off"/>',
        mounted: function () {
            var self = this;
            $(this.$el).datepicker({
                onSelect: function (date) {
                    $(this.$el).val(date);
                }
            });
        },
        beforeDestory: function () {
            $(this.$el).datepicker('hide').datepicker('destroy');
        }
    })
</script>
```
因為瀏覽器產生的autocomplete提示會蓋住時間選擇器，所以加個`autocomplete="off"`把它關掉，  
然後套用Bootstrap的`class="form-control"`css，  
`mounted:function()`內放的是啟用`.datepicker()`的動作，指向這個component，  
並且裡面有個onSelect事件處理選到的日期pass給那個input，不加`$(this.$el).val(date);`的話，  
會pop出選擇器，但是按了日期會沒反應的狀況，beforeDestory裡放的是選完，選擇器消失後把他釋放掉的動作，
目的應該是為了觸發他生命周期結束的動作。

2. 在HTML中使用
```c#
<input-date v-for="(data,key,i) in BodDate" :name="key" :id="key" :value="data"></input-date>
<script>
new Vue({
        el: '#bodpartial',
        data: {
            yearselected: new Date().getFullYear(),
            tablehead: ["月份", "日期"],
            BodDate: []
        },
        methods:{
        /*BodDate撈資料塞資料動作*/
        }
        });
</script>
```


在參考(照抄)過程中有提到一個Vue的屬性`v-once`，https://www.jianshu.com/p/4545df97ffd5 有解說
