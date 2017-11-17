---
layout: post
date: 2015/03/20
title: php中global和$GLOBALS[]的用法、解释、区别
categories: [learning,php]
tags: [php]
---

php语法中，很多人都认为global和$GLOBALS[]只是写法上面的差别，其实不然
根据官方的解释是
1.$GLOBALS[‘var’]是外部的全局变量本身
2.global $var是外部$var的同名引用或者指针。
<!--more-->
举例说明一下： 

	<?php
	$var1 = 1;
	$var2 = 2;
	function test(){
	$GLOBALS[‘var2′] = &$GLOBALS[‘var1′];
	}
	test();
	echo $var2;
	?>


正常打印结果为1


	<?php
	$var1 = 1;
	$var2 = 2;
	function test(){
	global $var1,$var2;
	$var2 = &$var1;
	}
	test();
	echo $var2;
	?>


意外打印结果为2

为什么会打印结果为2呢？其实就是因为$var1的引用指向了$var2的引用地址。导致实质的值没有改变。
我们再来看一个例子吧。


	<?php
	$var1 = 1;
	function test(){
	unset($GLOBALS[‘var1′]);
	}
	test();
	echo $var1;
	?>


因为$var1被删除了，所以什么东西都没有打印


	<?php
	$var1 = 1;
	function test(){
	global $var1;
	unset($var1);
	}
	test();
	echo $var1;
	?>


意外的打印了1。证明删除的只是别名|引用，起本身的值没有受到任何的改变
明白了吧？
也就是说global $var其实就是$var = &$GLOBALS[‘var’]。调用外部变量的一个别名而已