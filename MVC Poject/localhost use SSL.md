## localhost use SSL(localhost https)
>mkcert  
>choco

1. Install Chocolatey(windows)  
[Official website](https://chocolatey.org/)  
a. Open cmd with administrator  
b. Write  
```console
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
```
c. Write  
```console
choco install mkcert
```    
2. Instal mkcert  
[mkcert github](https://github.com/FiloSottile/mkcert)  
a.Open cmd.exe  
b.Write  
```console
mkcert -install
```
c.Write  
```console
mkcert example.com "*.example.com" example.test localhost 127.0.0.1 ::1
```
3. Change visual studio project attribute 
[stack overflow](https://stackoverflow.com/a/48980188) 
(3rd floor)  
