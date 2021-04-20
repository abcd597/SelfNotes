```csharp
            Type serviceType=Type.GetType("fullnamespace.fullclassname");
            ConstructorInfo serviceConstructor=serviceType.GetConstructor(Type.EmptyTypes);
            object serviceObject=serviceConstructor.Invoke(new object[]{});//Create Instance
            var method=serviceType.GetMethod("methodName");//find method
            var result=await (dynamic)method.Invoke(serviceObject,new object[]{parameter});//calling method,use(dynamic)or(Task)to await async method,use new object[]{parameter}
```
