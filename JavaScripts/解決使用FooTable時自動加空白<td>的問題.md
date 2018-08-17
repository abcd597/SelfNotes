### 解決使用FooTable時自動加空白<td>的問題
>下載了很好用的Table套件-[FooTable](https://fooplugins.github.io/FooTable/index.html)
>不過在某些`<td>`欄位有`colspan=""`屬性時他會自動增加對應數量的空`<td></td>`
>解決方法是在footable載入完成後使用`.remove()`移除

1.額外建立欄位table
```c#
<table id="myfootable" class="table table-bordered table-striped" data-paging="true">
	<thead>
		<tr>
			<th>欄1</th>
			<th>欄2</th>
			<th>欄3</th>
			<th>欄4</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>
		<tr>
			<td>5</td>
			<td colspan="3">6</td>
		</tr>
		<tr>
			<td colspan="4">7</td>
		</tr>
	</tbody>
</table>
<script>
$(function(){
$('#myfootable').footable();
})
</script>
```
會變這樣  
![footable_extra_td](https://github.com/abcd597/SelfNotes/blob/master/JavaScripts/footable_extra_td.png)
會強制讓他變成最大數量  
2.使用`.remove()`移除欄位
首先先在會多出欄位的那個`<tr>`增加一個id或是class，好讓等下可以選擇到他
```c#
<tr class="remove-2">
	<td>5</td>
	<td colspan="3">6</td>
</tr>
<tr class="remove-3">
	<td colspan="4">7</td>
</tr>
```
之後在footable後面增加移除的動作
```javascript
<script>
$(function(){
$('#myfootable').footable().ready(function(){
$('.remove-2>td:nth-child(3),.remove-2>td:nth-child(4)').remove();
$('.remove-3>td:nth-child(2),.remove-3>td:nth-child(3),.remove-3>td:nth-child(4)').remove();
});
})
</script>
```
就正常了~
![footable_remove_td](https://github.com/abcd597/SelfNotes/blob/master/JavaScripts/footable_remove_td.png)

完整程式碼
```c#
<table id="myfootable" class="table table-bordered table-striped" data-paging="true">
	<thead>
		<tr>
			<th>欄1</th>
			<th>欄2</th>
			<th>欄3</th>
			<th>欄4</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>2</td>
			<td>3</td>
			<td>4</td>
		</tr>
		<tr class="remove-2">
			<td>5</td>
			<td colspan="3">6</td>
		</tr>
		<tr class="remove-3">
			<td colspan="4">7</td>
		</tr>
	</tbody>
</table>
<script>
$(function(){
$('#myfootable').footable().ready(function(){
$('.remove-2>td:nth-child(3),.remove-2>td:nth-child(4)').remove();
$('.remove-3>td:nth-child(2),.remove-3>td:nth-child(3),.remove-3>td:nth-child(4)').remove();
	});
})
</script>
```

更新:  
後來再度使用時發現，換頁後的的td如果還是有colspan的話一樣會額外填滿，所以改用另一種方法  
```javascript
 $('#ListTable').footable({
            "paging": {
                enable: true
            },
            "on": {
                "postdraw.ft.table": function (e, ft) {
                    $('#ListTable > tbody > tr.text-alert > td:nth-child(2),#ListTable > tbody > tr.text-alert > td:nth-child(3),#ListTable > tbody > tr.text-alert > td:nth-child(4)').remove();
                },
                "after.ft.paging": function (e, ft) {
                    $('#ListTable > tbody > tr.text-alert > td:nth-child(2),#ListTable > tbody > tr.text-alert > td:nth-child(3),#ListTable > tbody > tr.text-alert > td:nth-child(4)').remove();
                }
            }
        });
```
搭配footable本身的事件處理`on`裡面多加了2個事件處理的動作`"postdraw.ft.table"`、`"after.ft.paging"`，
`postdraw.ft.table`:畫表格時的事件處理。  
`after.ft.paging`:換頁完畢後做的動作，主要的處理在這邊，在切換到分頁的某頁後才做的動作，裡面是吧多餘的td給`remove()`掉

