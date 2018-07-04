# Linux和Mac环境下sed命令区别


sed命令在mac环境下，与linux有点不一样：

1，-i 需要在sed命令后面加上''引号

2，添加的文本需要换行，必须在文本后面加上\且按回车才有换行的效果

更多区别参考 [Differences between sed on Mac OSX and other “standard” sed?] (https://unix.stackexchange.com/questions/13711/differences-between-sed-on-mac-osx-and-other-standard-sed)

可以在Mac安装gsed，来使用和Linux一样的

```
brew install gnu-sed
```