# CentOS7系统修改主机名

这篇文章主要讲讲CentOS7系统如何修改主机名。

## 1 CentOS7以下的版本修改主机名的方法

CentOS7以下的系统（包括CentOS6~CentOS6.5），我们通过修改HOSTNAME的方式即可得到想要的效果。如下所示，iZ28p4ey8n3Z是阿里云主机实例名（也即主机名），将其修改成了example。
```
[root@iZ28p4ey8n3Z ~]# vim /etc/sysconfig/network
  1 # Created by anaconda
  2 NETWORKING_IPV6=no
  3 PEERNTP=no
  4 GATEWAY=115.29.207.247
  5 HOSTNAME=example
[root@iZ28p4ey8n3Z ~]# hostname example
[root@example ~]#
```
<!--more-->

## 2 CentOS7以及CentOS7.1版本修改主机名的方法

在CentOS7或者CentOS7.1系统中，直接使用上面的方法修改主机名，最后都是没有效果的。它已经被简化为下面这条命令：
```
[root@iZ28p4ey8n3Z ~]# hostnamectl set-hostname typecodes
[root@example ~]#
```
