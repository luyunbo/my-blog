---
layout: post
date: 2015/05/13
title: ++i 和 i++ 的效率对比
categories: [Base programming]
tags: [C++]
---


这个问题需要分两种情况来解说：

1、当变量i的数据类型是c++语言默认提供的类型的话，他们的效率是一样的。
<!--more-->
int a,i=0;     a=++i;汇编代码如下：

	 int a,i=0;
	01221A4E  mov         dword ptr [i],0 
	 a=++i;
	01221A55  mov         eax,dword ptr [i] 
	01221A58  add         eax,1 
	01221A5B  mov         dword ptr [i],eax 
	01221A5E  mov         ecx,dword ptr [i] 
	01221A61  mov         dword ptr [a],ecx

int a,i=0;     a=i++;汇编代码如下：

	  int a,i=0;
	009E1A4E  mov         dword ptr [i],0 
	 a=i++;
	009E1A55  mov         eax,dword ptr [i] 
	009E1A58  mov         dword ptr [a],eax 
	009E1A5B  mov         ecx,dword ptr [i] 
	009E1A5E  add         ecx,1 
	009E1A61  mov         dword ptr [i],ecx

从汇编代码可以看出，他们的执行行数是一样的！ 

 2、我们自定的数据类型，++i效率高于i++，通过运算符重载来给大家说明这一点。

	Operator Operator::operator++()
	{
	   ++value;    //内部成员变量
	   return *this;
	}

	Operator Operator::operator++(int)
	{
	 Operator temp;
	 temp.value=value;
	 value++;
	 return temp;
	}

后++必须要有一个临时对象才可以