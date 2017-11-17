layout: post
date: 2017/03/23
title: Shell 文件注释Tip
categories: [tech]
tags: [Shell]
---


仅调试时才使用多行注释，多行注释建议使用 :<<\###的方式，方便开关

```
:<<\###  下面是本次要注释的内容
    do_something
    do_other_thing
###
```

如果需要执行这段代码，则

```
#:<<\###  下面是本次要注释的内容
    do_something
    do_other_thing
###
```
