# node-yarn-hexo
使用Docker架設Hexo Blog Server
## 建議
在建立之後請到`http://<yoursite>:4000/admin`建立帳號密碼並加入到你的伺服器主設定檔並重啟！

## Quick start
```shell
docker run -itd --name=hexo-blog -p 4000:4000 t985026/node-yarn-hexo:latest hexo server -i 0.0.0.0
```
## 掛載
如果你需要備份文件，先啟動容器後輸入下列指令後再重新創建容器並掛載目錄
### 僅文章
```shell
docker run -itd --name=hexo-blog -p 4000:4000 -v /somewhere/source:/workspace/blog/source t985026/node-yarn-hexo:latest hexo server -i 0.0.0.0
```

### 全目錄
```shell
docker run --rm -d --name=hexo-blog t985026/node-yarn-hexo:latest hexo server && \
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo new page "categories" && \
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo new page "about" && \
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo new page "tags" && \
rm -rf /somewhere/blog && \
docker cp hexo-blog:/workspace/blog /somewhere/blog && \
docker stop hexo-blog && \
docker run -itd --name=hexo-blog -p 4000:4000 -v /somewhere/blog:/workspace/blog t985026/node-yarn-hexo:latest hexo server -i 0.0.0.0
```

## 控制器
```
# Start the server
docker run -itd --name=hexo-blog t985026/node-yarn-hexo:latest hexo server -i 0.0.0.0
# New pages
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo new page "categories"
# New post
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo new foo
# Generate static files:
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo gen
# Deploy
docker run --rm --volumes-from hexo-blog t985026/node-yarn-hexo:latest hexo deploy
```


## 目錄結構
```
blog/
  _config.yml            -> 主設定檔
  package.json           -> 相依套件列表
  node_modules/          -> 相依套件
  public/                -> 生成的靜態網站資源
  source/
    _posts               -> 你寫的文章都放在這裡面
      hello-world.md     -> 文章
  themes/                -> 網站主題都放裡面
    next/
      _config.yml        -> 主題設定檔
  scaffolds/
    draft.md
    page.md
    post.md
```

## 命令
```
# 新增文章
docker exec hexo-blog hexo new post 文章
# 建立新頁面
docker exec hexo-blog hexo new page "pages"
```
