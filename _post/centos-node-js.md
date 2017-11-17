layout: post
date: 2017/02/23
title: CentOS下安装Node.js
categories: [tech]
tags: [node]
---


1. 下载源码，你需要在https://nodejs.org/en/download/下载最新的Nodejs版本，本文以v6.10.0为例:
	
```
cd /your/downloads/ 
wget https://nodejs.org/dist/v6.10.0/node-v6.10.0-linux-x64.tar.xz
```

<!--more-->

2、解压源码

```
tar -xzvf node-v6.10.0.tar.gz
```

3、 编译安装

```
cd node-v6.10.0
./configure --prefix=/usr/local/node/6.10.0
make
make install
```

4、配置NODE_HOME，进入profile编辑环境变量

```
vim /etc/profile
```

设置nodejs环境变量，在 export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL 一行的上面添加如下内容:

```
#set for nodejs
export NODE_HOME=/usr/local/node/6.10.0
export PATH=$NODE_HOME/bin:$PATH
```

wq保存并退出，编译/etc/profile 使配置生效
```
source /etc/profile
```

验证是否安装配置成功

```
node -v
```
输出 v6.10.0 表示配置成功

npm模块安装路径
```
/usr/local/node/6.10.0/lib/node_modules/
```






