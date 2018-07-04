---
title: SSH Tips
date:
categories: [tech]
tags: [linux,ssh]
---

原文：[SSH Can Do That? Productivity Tips for Working with Remote Servers](http://blogs.perl.org/users/smylers/2011/08/ssh-productivity-tips.html) / 作者：[Smylers](http://blogs.perl.org/users/smylers/) 

<!--more-->

### 多条连接共享
如果你需要在多个窗口中打开到同一个服务器的连接，而不想每次都输入用户名，密码，或是等待连接建立，那么你可以配置SSH的连接共享选项，在本地打开你的SSH配置文件，通常它们位于~/.ssh/config，然后添加下面2行：

```
ControlMaster auto
ControlPath /tmp/ssh_mux_%h_%p_%r
```

现在试试断开你与服务器的连接，并建立一条新连接，然后打开一个新窗口，再创建一条连接，你会发现，第二条连接几乎是在瞬间就建立好了。

### 长连接
如果你发现自己每条需要连接同一个服务器无数次，那么长连接选项就是为你准备的：

```
ControlPersist 4h
```

现在你每次通过SSH与服务器建立连接之后，这条连接将被保持4个小时，即使在你退出服务器之后，这条连接依然可以重用，因此，在你下一次（4小时之内）登录服务器时，你会发现连接以闪电般的速度建立完成，这个选项对于通过scp拷贝多个文件提速尤其明显，因为你不在需要为每个文件做单独的认证了。

### 别再输入密码
如果你还在通过密码方式登录SSH，那么你或许应该试试SSH Keys，首先使用OpenSSH为自己声称一对密钥：
```
$ ssh-keygen
```
跟随指示，完成之后，你应该可以在你的.ssh目录下看到两个文件，id_rsa就是你的私钥，而id_ras.pub则是你的公钥，现在你需要将你的公钥拷贝到服务器上，如果你的系统有ssh-copy-id命令，拷贝会很简单：

```
$ ssh-copy-id smylers@compo.example.org
```

否则，你需要手动将你的私钥拷贝的服务器上的~/.ssh/authorized_keys文件中：

```
$ < ~/.ssh/id_rsa.pub ssh clegg.example.org ‘mkdir -p .ssh; cat >> .ssh/authorized_keys; chmod go-w .ssh .ssh/authorized_keys’
```
