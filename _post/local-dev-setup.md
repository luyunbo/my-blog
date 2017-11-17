layout: post
date: 2016/04/26
title: 本地环境搭建
categories: [extra]
tags: [PHP,HTTP,Apache]
---
在搭建本地开发环境踩的一些坑，下面总结一下。

## 需要理解的概念
### hosts文件
将一些常用的网址域名与其对应的IP地址建立一个关联“数据库”，当用户在浏览器中输入一个需要登录的网址时，系统会首先自动从Hosts文件中寻找对应的IP地址，一旦找到，系统会立即打开对应网页，如果没有找到，则系统会再将网址提交DNS域名解析服务器进行IP地址的解析。可以利用host文件虚拟域名。

### MySQL中的 127.0.0.1 vs localhost
localhost应该解释成:本地服务器。

127.0.0.1应该解释成:本机地址。

localhost是不经网卡传输！它不受网络防火墙和网卡相关的的限制。

127.0.0.1是通过网卡传输，依赖网卡，并受到网络防火墙和网卡相关的限制。

<!--more-->

一般设置程序时本地服务用localhost是最好的，localhost不会解析成ip，也不会占用网卡、网络资源。
有时候用localhost可以，但用127.0.0.1就不可以的情况就是在于此。猜想localhost访问时，系统带的本机当前用户的权限去访问，而用ip的时候，等于本机是通过网络再去访问本机，可能涉及到网络用户的权限。

 mysql -h 127.0.0.1 的时候，使用TCP/IP连接。mysql server 认为该连接来自于127.0.0.1或者是"localhost.localdomain"

mysql -h localhost 的时候，是不使用TCP/IP连接的，而使用Unix socket。
此时，mysql server则认为该client是来自"localhost"。

可以通过mysql交互命令status查看两者connection的区别:
* mysql -h 127.0.0.1
```
mysql> status;
--------------
mysql  Ver 14.14 Distrib 5.6.24, for Linux (x86_64) using  EditLine wrapper

Connection id:          45
Current database:
Current user:           root@127.0.0.1
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         5.6.24-log Source distribution
Protocol version:       10
Connection:             127.0.0.1 via TCP/IP
Server characterset:    utf8
Db     characterset:    utf8
Client characterset:    utf8
Conn.  characterset:    utf8
TCP port:               3306
Uptime:                 1 hour 43 min 54 sec

Threads: 2  Questions: 98815  Slow queries: 0  Opens: 269  Flush tables: 1  Open tables: 115  Queries per second avg: 15.850
--------------
```

* mysql -h localhost
```
mysql> status;
--------------
mysql  Ver 14.14 Distrib 5.6.24, for Linux (x86_64) using  EditLine wrapper

Connection id:          46
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         5.6.24-log Source distribution
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8
Db     characterset:    utf8
Client characterset:    utf8
Conn.  characterset:    utf8
UNIX socket:            /var/run/mysql/mysql.sock
Uptime:                 1 hour 50 min 37 sec

Threads: 2  Questions: 98820  Slow queries: 0  Opens: 269  Flush tables: 1  Open tables: 115  Queries per second avg: 14.889
--------------
```





## apache多端口多站点配置

* 增加监听端口
```
Listen 8088
```
* 开启虚拟端口
```
# Virtual hosts 
#Include conf/extra/httpd-vhosts.conf 
#修改为 
# Virtual hosts 
Include conf/extra/httpd-vhosts.conf 
```

配置conf/extra/httpd-vhosts.conf 
```
<VirtualHost *:8088>
    #ServerAdmin webmaster@example.com
    DocumentRoot "/your/webserver/path"
    ServerName example.com
    #ServerAlias www.example.com
    #ErrorLog "logs/example.com.log"
    #CustomLog "logs/example.com.log" common
</VirtualHost>
<Directory /your/webserver/path>
    Options FollowSymLinks
    AllowOverride ALL
    Order deny,allow
    Allow from all
</Directory>
```

## 创建视图
语法
```
CREATE
    [OR REPLACE]
    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]
    VIEW view_name [(column_list)]
    AS select_statement
    [WITH [CASCADED | LOCAL] CHECK OPTION]
```

## 创建存储过程
语法
```
CREATE
    [DEFINER = { user | CURRENT_USER }]
    PROCEDURE sp_name ([proc_parameter[,...]])
    [characteristic ...] routine_body

CREATE
    [DEFINER = { user | CURRENT_USER }]
    FUNCTION sp_name ([func_parameter[,...]])
    RETURNS type
    [characteristic ...] routine_body

proc_parameter:
    [ IN | OUT | INOUT ] param_name type

func_parameter:
    param_name type

type:
    Any valid MySQL data type

characteristic:
    COMMENT 'string'
  | LANGUAGE SQL
  | [NOT] DETERMINISTIC
  | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
  | SQL SECURITY { DEFINER | INVOKER }

routine_body:
    Valid SQL routine statement
```

## cookie相关
当cookie domain设置为IP:PORT时，后面的PORT不起作用。同一个IP都用共用cookie的。