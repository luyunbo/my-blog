---
title: 上网
date: 2018-04-03 13:03:08
---
 
shadowsocks是一个可穿透防火墙的快速代理。简称ss. ss由曾经主要由@clowwindy开发维护的一个基于socks5协议的开源项目，官网为shadowsocks.org，托管在github上。注意，另有一个收费服务shadowsocks.com，使用其作为客户端，但是和ss项目是两回事，很多人甚至把它们混淆。

<!-- more -->

## 服务端

### 安装

Debian / Ubuntu:

    apt-get install python-pip
    pip install shadowsocks

CentOS:

    yum install python-setuptools && easy_install pip
    pip install shadowsocks


### 使用

    ssserver -p 443 -k password -m rc4-md5

如果要后台运行：

    sudo ssserver -p 443 -k password -m rc4-md5 --user nobody -d start

如果要停止：

    sudo ssserver -d stop

如果要检查日志：

    sudo less /var/log/shadowsocks.log

用 `-h` 查看所有参数。

### 使用[配置文件]进行配置。

创建一个配置文件 `/etc/shadowsocks.json`.

例如:

    {
        "server":"my_server_ip",
        "server_port":8388,
        "local_address": "127.0.0.1",
        "local_port":1080,
        "password":"mypassword",
        "timeout":300,
        "method":"aes-256-cfb",
        "fast_open": false
    }

配置解释:

| Name          | Explanation                                     |
| ------------- | ----------------------------------------------- |
| server        | the address your server listens                 |
| server_port   | server port                                     |
| local_address | the address your local listens                  |
| local_port    | local port                                      |
| password      | password used for encryption                    |
| timeout       | in seconds                                      |
| method        | default: "aes-256-cfb", see [Encryption]        |
| fast_open     | use [TCP_FASTOPEN], true / false                |
| workers       | number of workers, available on Unix/Linux      |

前台运行:

    ssserver -c /etc/shadowsocks.json

后台运行:

    ssserver -c /etc/shadowsocks.json -d start
    ssserver -c /etc/shadowsocks.json -d stop



建议选择 Ubuntu 14.04 LTS 作为服务器以便使用 [TCP Fast Open]。除非有明确理由，不建议用对新手不友好的 CentOS。


## 客户端

* [Windows] / [OS X]
* [Android] / [iOS]
* [OpenWRT]

在你本地的 PC 或手机上使用图形客户端。具体使用参见它们的使用说明。


[配置文件]:     https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File
[Android]:           https://github.com/shadowsocks/shadowsocks-android
[OpenWRT]:           https://github.com/shadowsocks/openwrt-shadowsocks
[OS X]:              https://github.com/shadowsocks/shadowsocks-iOS/wiki/Shadowsocks-for-OSX-Help
[Debian sid]:        https://packages.debian.org/unstable/python/shadowsocks
[iOS]:               https://github.com/shadowsocks/shadowsocks-iOS/wiki/Help
[TCP Fast Open]:     https://github.com/clowwindy/shadowsocks/wiki/TCP-Fast-Open
[Windows]:           https://github.com/shadowsocks/shadowsocks-windows/wiki/Shadowsocks-Windows-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E
