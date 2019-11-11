1. Modify Web.config   
```c#
   /*Add*/
   <authentication mode="Windows" />
   <anonymousIdentification enabled="false"/>
```   
2. Change the project's attribute(click the project and press F4)  
Windows Authentication -> Enable  
Anonymous Authentication -> Disable  

3. Change IIS Authentication Setting  
Enable Windows Authentication and Disable Anonymous Authentication  
