layout: post
date: 2015/02/27
title: Vim粘贴代码时缩进混乱
categories: [Linux]
tags: [vim]
---


## 1.问题

在终端Vim中粘贴代码时，发现插入的代码会有多余的缩进，而且会逐行累加。
原因是终端把粘贴的文本存入键盘缓存（Keyboard Buffer）中，Vim则把这些内容作为用户的键盘输入来处理。
导致在遇到换行符的时候，如果Vim开启了自动缩进，就会默认的把上一行缩进插入到下一行的开头，最终使代码变乱。

另外SecureCRT会将你原来的文本原封不动的按照字符串的样式发送给服务器。所以当你的服务器上的vim设置为autoindent的话，在i模式下，那么它会将secureCRT传输而来的这些字符串再进行一下缩进。
若你拷贝的文本中已经有表示缩进的空格或者制表符的话，它们也会被当成字符串，而被缩进。

## 2.解决方法

<!--more-->

##### 1. 取消自动缩进
在命令模式下，使用“:set nosmartindent”和“:set noautoindent”取消自动缩进，然后再粘贴即可。完成后再开启自动缩进“:set smartindent”和“:set autoindent”，以上命令都可使用简写，比如“:set si”，可通过Vim的帮助“:help smartindent”查看相应说明。
	
##### 2. Paste模式
Vim的编辑模式中，还有一个Paste模式，在该模式下，可将文本原本的粘贴到Vim中，以避免一些格式错误。通过“:set paste”和“:set nopaste”进入和退出该模式。更简便的方式是，在Vim中设置一个进入和退出Paste模式的快捷键，往“~/.vimrc”中添加一行配置“set pastetoggle=<F12>”，这样即可通过F12快速的在Paste模式中切换，当然快捷键在不冲突的前提下可以任意指定，具体如何指定，参考附带的教程链接。	