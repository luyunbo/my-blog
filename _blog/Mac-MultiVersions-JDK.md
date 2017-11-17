# Mac OS X管理多版本jdk

## 安装
### 安装包(注意都是下载mac下的dmg安装包)：
JDK 1.6（验证OS X 10.11可用）：http://support.apple.com/kb/DL1572
JDK 1.7&1.8（1.7在页面下方）:http://www.oracle.com/technetwork/java/javase/downloads/index.html

### 安装
dmg安装包，安装过程如一般程序，略

### 最终安装目录(版本号根据情况略有不同)：
* JDK 1.6：

	/System/Library/Java/JavaVirtualMachines/1.6.0.jdk

* JDK 1.7&1.8:
	
	/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk
	/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk

<!--more-->

## 多本管理方式
### 管理方式一

添加到一下以下内容.zshrc或.bashrc

```
- # Mac默认 JDK 6（Mac默认自带了一个jdk6版本）
- export JAVA_6_HOME=`/usr/libexec/java_home -v 1.6`
- # 设置 JDK 7
- export JAVA_7_HOME=`/usr/libexec/java_home -v 1.7`
- # 设置 JDK 8
- export JAVA_8_HOME=`/usr/libexec/java_home -v 1.8`
-
- #默认JDK 6
- export JAVA_HOME=$JAVA_6_HOME
-
- #alias命令动态切换JDK版本
- alias jdk6="export JAVA_HOME=$JAVA_6_HOME"
- alias jdk7="export JAVA_HOME=$JAVA_7_HOME"
- alias jdk8="export JAVA_HOME=$JAVA_8_HOME"
```
然后执行
```
source .zshrc
```

默认jdk为1.6,执行jdk6或jdk7或jdk8后，通过java -version可看到已切换成相应版本。


### 管理方式二
jEnv 可以用简单的命令切换 Java 版本，但无法安装任何版本的 Java，所以我们自己必须安装它们，将 jEnv 指向它们。
#### 安装jEnv
Linux / OS X
```
$ git clone https://github.com/gcuisinier/jenv.git ~/.jenv
```
Mac OS X via Homebrew

```
$ brew install jenv
```

#### 设置 JAVA_HOME

Bash

```
$ echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(jenv init -)"' >> ~/.bash_profile

# JAVA_HOME
$ echo 'JAVA_HOME=`/usr/libexec/java_home`' >> ~/.bash_profile
$ echo 'export JAVA_HOME' >> ~/.bash_profile
```

Zsh

```
$ echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
$ echo 'eval "$(jenv init -)"' >> ~/.zshrc

# JAVA_HOME
$ echo 'JAVA_HOME=`/usr/libexec/java_home`' >> ~/.zshrc
$ echo 'export JAVA_HOME' >> ~/.zshrc
查看当前 Java 版本

$ echo $JAVA_HOME
```

另外可以使用 -V 选项列出所有版本的 JAVA_HOME：

```
$ /usr/libexec/java_home -V
```

安装不同版本的 Java，并添加到 jEnv
jEnv 安装和配置完成后，先安装 Java 包。

从 Apple webiste 下载 Java6 来安装。用下面的命令来把它添加到 

#### 配置jEnv

```
$ jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
  oracle64-1.6.0.39 added
$ jenv add /Library/Java/JavaVirtualMachines/jdk17011.jdk/Contents/Home
  oracle64-1.7.0.11 added
```
 
 
运行 jenv versions 将看到：

```
$ jenv versions
 *system (set by /Users/ajones/.jenv/version)
  oracle64-1.6.0.39
  oracle64-1.7.0.11 (set by /Users/hikage/.jenv/version)
```

让我们从 Oracle 下载并安装 Java 7。这次他被安装到 /Library/Java/JavaVirtualMachines/，所以用下面的命令把它添加到 jEnv：

```
jenv add /Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/
```

同样，我们也可以使用 Homebrew Cask 安装：

```
brew cask install java
```

它将被安装到和 Java 7 相同的位置，因此以相同的方式添加它。

使用 jEnv 管理 Java 版本
列出当前系统已安装的 Java 版本

```
$ jenv versions
  system
  oracle64-1.6.0.39
 *oracle64-1.7.0.11 (set by /Users/hikage/.jenv/version)
```

#### jEnv用法
全局配置

```
$ jenv global oracle64-1.6.0.39
```

单个项目设置

```
$ jenv local oracle64-1.6.0.39
```

shell 设置

```
$ jenv shell oracle64-1.6.0.39
```

Mac 上管理多个 Java 版本的解决方案，目前 github 上有 2 个项目：一个是国人的 jenv（有段时间没更新了，2016.1.19），一个是老外的 jEnv。
