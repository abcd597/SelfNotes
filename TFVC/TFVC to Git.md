1.  安裝 chocolatey  
    [Chocolaty 官網連結](https://chocolatey.org/)
2.  安裝 git-tfs
    > cmd 輸入:  
    > `choco install gittfs`
3.  確認 git-tfs 有安裝到
    > cmd 輸入:  
    > `git tfs -version`
4.  輸入 git-tfs 語法下載 Azure 上的原來的 TFVC 專案  
     專案名字可到這裡找: http://tfs:8080/tfs/DefaultCollection/\_projects

    > 輸入:  
    > `git tfs clone http://tfs:8080/tfs/defaultcollection $/{專案名字:例如 UserInformation} "要下載到電腦裡的路徑"`

    > e.g.  
    > `git tfs clone http://tfs:8080/tfs/defaultcollection $/UserInformation "D:\Code\UserInformation_Git"`

5.  可以建一個分支區分一下原來的 TFVC 程式
    > 建立新分支並切換過去 `git switch -c TFVC`  
    > 切換回 master 線以 push 上新 git 專案 `git switch master`
6.  git 遠端路徑指到新 git 專案

    > `git remote add origin http://tfs:8080/tfs/DefaultCollection/_git/UserInformation`

7.  拉回一次新 git 專案的遠端紀錄

    > `git pull origin master:master`

    \*可能會遇到"refusing to merge unrelated histories"的錯誤，這時候要把語法改為(只 for 新 git 專案)  
    `git pull origin master --allow-unrelated-histories`

8.  把下載回來的 master 分支與 TFVC 版本的合併(這裡使用 merge)

    > `git merge TFVC`  
    > (可能會有 Conflict，解 Conflict 不贅述)

9.  把合併好的程式 push 回遠端新 git 專案

    > `git push origin master:master`

10. 回 Azure 上看應該就有包含先前紀錄的新 git 專案了

    > e.g. 程式的新 git 歷史紀錄:http://tfs:8080/tfs/DefaultCollection/\_git/UserInformation/history?\_a=history
