```csharp
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
namespace Project.Filter{

public class RedirectFilter:IActionFilter{
    //reditect to Home/Index action before executing action
    public void OnActionExecuting(ActionExecutingContext context)
        {
          
            context.Result=new RedirectToRouteResult(
                new RouteValueDictionary 
                { 
                    { "controller", "Home" }, 
                    { "action", "Index" } 
                });
        }
        public void OnActionExecuted(ActionExecutedContext context)
        {
            context.HttpContext.Response.WriteAsync($"{GetType().Name} out. \r\n");
        }
}

}
```
usage
```csharp
[TypeFilter(typeof(RedirectFilter))]
public IActionResult SomeAction(){
return View();
}
```
