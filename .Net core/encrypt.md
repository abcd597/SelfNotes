```csharp
using System;
using System.Security.Cryptography;
namespace ApplicationNamespace
{

public static class Encrypt{
///<summary>
///SHA256 Encrypt
///</summary>
public static string ToSHA256(this string Text,string key){//use this to become static method("text want to encrypt".ToSHA256(salt))
    var encoding = new System.Text.UTF8Encoding();
        byte[] keyByte=encoding.GetBytes(key);//add salt
        byte[] messageBytes=encoding.GetBytes(Text);
        using(var sha256=new HMACSHA256(keyByte)){
            byte[] hashText=sha256.ComputeHash(messageBytes);
            return BitConverter.ToString(hashText).Replace("-","");//remove "-"
        }
}
}
}
```
