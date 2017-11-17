layout: post
date: 2017/10/30
title: Redis的编译安装
categories: [tech]
tags: [redis]
---

安装Redis的建议方法是从源代码编译它，因为Redis除了一个工作GCC编译器和libc之外没有其他依赖项。如果使用Linux发行版的包管理器安装它有个缺点是其安装可用的版本不是最新的。

<!--more-->

### 1 编译与安装

```
## 下载并编译
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable
make

## Redis 的核心文件就这两个
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/

## 此目录用于保存各端口配置文件
sudo mkdir /etc/redis

## 此目录用于保存各端口的持久化数据文件
sudo mkdir /var/redis

## 端口6379的配置文件
sudo cp redis.conf /etc/redis/6379.conf

## 端口6379的持久化目录
sudo mkdir /var/redis/6379

## =================================== ##
## 编辑配置文件
sudo vi /etc/redis/6379.conf

#### 修改以下字段 ####
daemonize => yes
pidfile => /var/run/redis_6379.pid
port => 6379
logfile => /var/log/redis_6379.log
dir => /var/redis/6379

#### 考虑安全性，添加以下记录 ####
bind 127.0.0.1
rename-command FLUSHALL ""
rename-command FLUSHDB ""
rename-command CONFIG ""
rename-command EVAL ""
## =================================== ##

## 启动脚本 for Linux
sudo cp utils/redis_init_script /etc/init.d/redis_6379

## 启动脚本 for OS X，因为没有 init.d 目录，故放在 /etc/redis 下
sudo cp utils/redis_init_script /etc/redis/redis_6379
```
### 2 开机启动
#### 2.1 Linux
```
## CentOS - 开机启动
echo "/etc/init.d/redis_6379 start" | sudo tee --append /etc/rc.d/rc.local
## Ubuntu - 开机启动
sudo update-rc.d redis_6379 defaults

## 启动 redis_6379
sudo /etc/init.d/redis_6379 start 

## 停止 redis_6379
sudo /etc/init.d/redis_6379 stop
```

#### 2.2 Mac OS
``` 
sudo vi /Library/LaunchDaemons/io.redis.6379.plist
```

内容

```

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
        <key>Label</key>
        <string>io.redis.6379</string>
        <key>ProgramArguments</key>
        <array>
                <string>/etc/redis/redis_6379</string>
                <string>start</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
</dict>
</plist>
```

设置开机启动

```
## 添加启动项
sudo launchctl load -w /Library/LaunchDaemons/io.redis.6379.plist

## 删除启动项
sudo launchctl unload -w /Library/LaunchDaemons/io.redis.6379.plist

```

启动与停止

```
## 启动 redis_6379
sudo /etc/redis/redis_6379 start 

## 停止 redis_6379
sudo /etc/redis/redis_6379 stop
```


参考连接：

<http://redis.io/topics/quickstart>

<http://fqk.io/redis-installation/>
