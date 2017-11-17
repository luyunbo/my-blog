layout: post
date: 2015/01/27
title: shell编程
categories: [Linux]
tags: [vim]
---


# 1.什么是shell

 shell script 是利用 shell 的功能所写的一个程序 (program)，这个程序是使用纯文字档，将一些 shell 的语法与命令(含外部命令)写在里面， 搭配正规表示法、管线命令与数据流重导向等功能，以达到我们所想要的处理目的。   

<!--more-->

shell脚本示例

    #!/bin/bash
    # Program:
    #   This program shows "Hello World!" in your screen.
    # History:
    # 2005/08/23	VBird	First release
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
    export PATH
    echo -e "Hello World! \a \n"
    exit 0

示例解释

1. 第一行#!/bin/bash在宣告这个script使用的shell名称      
      

注意事项
---

1. 命令的运行是从上而下、从左而右的分析与运行；
2. 命令的下达就如同第五章内提到的： 命令、选项与参数间的多个空白都会被忽略掉；
3. 空白行也将被忽略掉，并且 [tab] 按键所推开的空白同样视为空白键；
4. 如果读取到一个 Enter 符号 (CR) ，就尝试开始运行该行 (或该串) 命令；
5. 至於如果一行的内容太多，则可以使用『 \[Enter] 』来延伸至下一行；
6. 『 # 』可做为注解！任何加在 # 后面的数据将全部被视为注解文字而被忽略！



1.

