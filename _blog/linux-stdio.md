# linux shell的标准输入、输出和错误

## 1、文件描述符
<table border="1">
	<tr>
		<td>文件</td>
		<td>文件描述符</td>
	</tr>
	<tr>
		<td>输入文件——标准输入</td>
		<td>0(缺省是键盘，为0时是文件后者其他命令输出)</td>
	<tr>
		<td>输出文件——标准输出</td>
		<td>1(缺省的是屏幕，为1时文件）</td>
	</tr>
	<tr>
		<td>错误输出文件</td>
		<td>2（缺省的是屏幕，为2是文件）</td>
	</tr>
</table>

<!--more-->

## 2、文件重定向


### 2.1 输出重定向

<table border="1">
	<tr>
		<td>cmd > filename</td>
		<td>把标准输出重定向到一个新文件中（如果文件不存在则新建，如果文件存在则覆盖</td>
	</tr>
	<tr>
		<td>cmd >> filename</td>
		<td>把标准输出重定向到一个文件中（追加）</td>
	</tr>
	<tr>
		<td>cmd > filename 2>&1</td>
		<td>把标准输出和错误一起重定向到一个文件中</td>
	</tr>
	<tr>
		<td>cmd 2 > filename</td>
		<td>把标准错误重定向到一个文件中</td>
	</tr>
	<tr>
		<td>cmd 2 >> filename</td>
		<td>把标准错误重定向追加到一个文件中</td>
	</tr>
	<tr>
		<td>cmd >> filename 2>&1</td>
		<td>把标准输出和错误重定向追加到一个文件中</td>
	</tr>
</table>

### 2.2 输入重定向

<table border="1">
	<tr>
		<td>cmd < filename > filename2</td>
		<td>cmd的命令以 filename 文件作为标准输入，以 filename2 作为作为标准输出</td>
	</tr>
	<tr>
		<td>cmd < filename</td>
		<td>cmd命令以 filename 文件作为标准输入</td>
	</tr>
	<tr>
		<td>cmd << delimiter</td>
		<td>从标准输入中读入，直到遇到delimiter分界符</td>
	</tr>
</table>

### 2.3 绑定重定向

<table>
	<tr>
		<td>cmd > &m</td>
		<td>把标准输出重定向到文件描述符中</td>
	</tr>
	<tr>
		<td>cmd < &-</td>
		<td>关闭标准输入</td>
	</tr>
	<td>cmd 0 > &-</td>
	<td>g关闭标准输入</td>
</table>

## 3 shell重定向的一些高级用法

### 3.1 重定向标准错误

例子1：
	
	command 2> /dev/null

如果command执行出错，将错误的信息重定向到空设备

例子2：
	
	command > out.put 2>&1

将command执行的标准输出和标准错误重定向到out.put（也就是说不管command执行正确还是错误，输出都打印到out.put）。



### 3.2 exec用法
exec命令可以用来替代当前shell；换句话说，并没有启动子shell，使用这一条命令时任何现有环境变量将会被清除，并重新启动一个shell（重新输入用户名和密码进入）。
	
	exec command

其中，command通常是一个shell脚本。

对文件描述符操作的时候用（也只有再这时候），它不会覆盖你当前的shell

例子1：

	#!/bin/bash
	#file_desc
	exec 3<&0 0<name.txt
	read line1
	read line2
	exec 0<&3
	echo $line1
	echo $line2

其中：
首先，`exec 3<&0 0<name.txt`的意思是把标准输入重定向到文件描述符3（0表示标准输入），然后把文件name.txt内容重定向到文件描述符0，实际上就是把文件name.txt中的内容重定向到文件描述符3。然后通过exec打开文件描述符3；
然后，通过read命令读取name.txt的第一行内容line1，第二行内容line2，通过Exec 0<&3关闭文件描述符3；
最后，用echo命令输出line1和line2。最好在终端运行一下这个脚本，亲自尝试一下。


例子2：

	exec 3<>test.sh;
	#打开test.sh可读写操作，与文件描述符3绑定
	while read line<&3
 	do
    	echo $line;
	done
	#循环读取文件描述符3（读取的是test.sh内容）
	exec 3>&-
	exec 3<&-
	#关闭文件的，输入，输出绑定
