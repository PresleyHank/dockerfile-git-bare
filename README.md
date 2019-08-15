# 关于项目

这是一个`dockerfile`镜像构建文件， 用于搭建一个自动部署的git中心仓库。

- 基于`ubuntu18:04` 
- install `git`、`openssh-server`

# Use

1. 配置无密码登录

`./conf/authorized_keys` 填入你的公钥，一行一个 （容器内修改路径 `/home/git/.ssh/authorized_keys`）

2. build 构建镜像

`docker build -t awsl .`  （注意后面有个点）

3. 运行一个容器 (容器内公开ssh 22端口， 不建议牺牲宿主机22端口)

`docker run -it -p 23:22 awsl /bin/bash`

4. 启动ssh服务

`service ssh start`

ok， 你的git地址`ssh://git@{YOUR_HOST}:{23}/home/git/dev.git`

`Tis：`空仓库， 第一次先push

自动部署路径 `/app` ，你可以绑定到宿主机的web目录



其他的还没想到～