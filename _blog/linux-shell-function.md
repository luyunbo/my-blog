# shell函数

shell的函数只能返回整数值，如果想让函数返回字符串，一般有两种方法：将返回值赋值给一个字符串变量、输出返回值，在函数调用处为变量赋值。

## shell函数
Shell 函数的定义格式如下

```shell
function_name () {
    list of commands
    [ return value ]
}
```

如果你愿意，也可以在函数名前加上关键字 function：

```shell
function function_name () {
    list of commands
    [ return value ]
}
```

函数返回值，可以显式增加return语句；如果不加，会将最后一条命令运行结果作为返回值。

Shell 函数返回值只能是整数，一般用来表示函数执行成功与否，0表示成功，其他值表示失败。如果 return 其他数据，比如一个字符串，往往会得到错误提示：“numeric argument required”。

如果一定要让函数返回字符串，那么可以先定义一个变量，用来接收函数的计算结果，脚本在需要的时候访问这个变量来获得函数返回值。

将返回值赋值给一个字符串变量

```shell
get_project_version(){
  VERSION=`grep version $1/pom.xml | head -n 1 | sed -E 's:</?version>::g' | sed -E 's/^\t*//' | sed -E 's/^ *//' | sed -E 's/\r$//'`
}
```

输出返回值，在函数调用处为变量赋值

~~~shell
get_project_version(){
  echo `grep version $1/pom.xml | head -n 1 | sed -E 's:</?version>::g' | sed -E 's/^\t*//' | sed -E 's/^ *//' | sed -E 's/\r$//'`
}
version=`get_project_version $PROJECT_PATH`
~~~

## 特殊变量列表

| 变量|含义|
|---|---------------|
|$0	|是脚本本身的名字；|
|$#	 |是传给脚本的参数个数；|
|$@	 |是传给脚本的所有参数的列表，即被扩展为”$1” “$2” “$3”等；|
|$*	 | 是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个，即被扩展成”$1c$2c$3”，其中c是IFS的第一个字符；|
|$$	 | 是脚本运行的当前进程ID号；|
|$? | 是显示最后命令的退出状态，0表示没有错误，其他表示有错误；|
|$n |	获取参数的值，$1表示第一个参数，当n>=10时，需要使用${n}来获取参数。|
