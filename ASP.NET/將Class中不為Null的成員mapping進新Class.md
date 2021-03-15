### 將Class中不為Null的成員mapping進新Class

情境:從前端接過來的values中，整個class包含有異動的(不為null表示異動過資料)，沒異動的(沒異動則不回傳至後端所以為null)，  
想要將不為null，也就是有修改過的新資料直接修改至資料庫撈出來的entity class中。  
  
ex:
```csharp
//前端接來的class
class A{
name:'abc',
phone:'123',
address:null,
age:null,
gender:'male',
mail:null
}
```
想將`name`、`phone`、`gender`修改進  
```csharp
//資料庫撈出來的class
class B{
name:'xyz',
phone:'789',
address:'taiwan taipei',
age:20,
gender:'female',
mail:'aaa@gmail.com'
}
```   
以下語法:  
```csharp
  public IActionResult Put(DataViewModel DatafromFronted){
      var dbData   =  service.FindBy(x=>x.id.Equals(DatafromFronted.id)).FirstOrDefault();
      var properties  =  DatafromFronted.GetType().GetProperties();
          properties.ToList().ForEach(p=>{//如果接近來的參數「不等於null」，將值賦予將異動進資料庫的class
          if(p.GetValue(DatafromFronted) != null){
                var propertyInfo=typeof(Data).GetProperty(p.Name);//dbData's class name(class Data{...})
                propertyInfo.SetValue(dbData,p.GetValue(DatafromFronted),null);
                }
          });
            
      //service save datas;
        return Ok(DatafromFronted);
}
```
