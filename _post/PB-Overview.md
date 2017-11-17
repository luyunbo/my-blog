---
layout: post
date: 2015/05/07
title: Protocol Buffers Overview
categories: [RPC,pb]
tags: [RPC]
---


## Protocol Buffers(PB)简介
protocol buffers是google提供的一种将结构化数据进行序列化和反序列化的方法，其优点是语言中立，平台中立，可扩展性好，目前在google内部大量用于数据存储，通讯协议等方面。PB在功能上类似XML，但是序列化后的数据更小，解析更快，使用上更简单。用户只要按照proto语法在.proto文件中定义好数据的结构，就可以使用PB提供的工具（protoc）自动生成处理数据的代码，使用这些代码就能在程序中方便的通过各种数据流读写数据。PB目前支持Java, C++和Python3种语言。另外，PB还提供了很好的向后兼容，即旧版本的程序可以正常处理新版本的数据，新版本的程序也能正常处理旧版本的数据。
<!--more-->
>Protocol buffers are Google’s language-neutral, platform-neutral, extensible mechanism for serializing structured data – think XML, but smaller, faster, and simpler. You define how you want your data to be structured once, then you can use special generated source code to easily write and read your structured data to and from a variety of data streams and using a variety of languages – Java, C++, or Python. You can even update your data structure without breaking deployed programs that are compiled against the “old” format.（摘自[PB官网](https://developers.google.com/protocol-buffers/docs/overview?hl=zh-cn)）

## 如何使用Protocol Buffers
1. 定义一个.proto文件

	在addressbook.proto文件里定义通讯簿消息的格式，一个通讯簿（AddressBook）由可重复的Person组成，一个person由两个必需存在的name和id字段，以及一个可选的email字段，和可重复的PhoneNumber构成。PhoneNumber由number和type组成。

		message Person {
	  		required string name = 1;
	  		required int32 id = 2;
	  		optional string email = 3;

			enum PhoneType {
	    		MOBILE = 0;
	    		HOME = 1;
	    		WORK = 2;
	  		}

	  		message PhoneNumber {
	    		required string number = 1;
	    		optional PhoneType type = 2 [default = HOME];
	  		}

	 		repeated PhoneNumber phone = 4;
		}
	

2. 使用protocol编译器

	使用PB使用的工具Protocol根据.proto文件自动生成处理消息的代码
	
		protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/addressbook.proto
	
	在$DST_DIR里生成了下面两个文件：
	>addressbook.pb.h
	><br>
	>addressbook.pb.cc

3. 使用PB的API来写入和读取messages
	
	程序使用生成的代码来读写（序列化，反序列化）和操作（get，set）消。
	
	写的代码：
	
		Person person;
		person.set_name("John Doe");
		person.set_id(1234);
		person.set_email("jdoe@example.com");
		fstream output("myfile", ios::out | ios::binary);
		person.SerializeToOstream(&output);
	
	读的代码：
	
		fstream input("myfile", ios::in | ios::binary);
		Person person;
		person.ParseFromIstream(&input);
		cout << "Name: " << person.name() << endl;
		cout << "E-mail: " << person.email() << endl;

## why not just use XML
相比XML在序列化结构语言上protocol buffers有以下特点：

* 更简单
* 体积上小3~10倍
* 速度上快20~100倍
* 定义更清晰
* 更容易通过程序产生数据接入类

例如，你想简历一个模型person，它有name和email。在XML中，你需要这样做：
	
	<person>
	<name>John Doe</name>
	<email>jdoe@example.com</email>
	</person>

然而相应的protocol buffer的message是这样的：

	# Textual representation of a protocol buffer.
	# This is *not* the binary format used on the wire.
	person {
  		name: "John Doe"
  		email: "jdoe@example.com"
	}

这条message被编码成protocol buffer 二进制格式（上述文本格式只是便于人类可读性表达，更利于调试和修改），它可能只是28 byte长，只需要100~200ns来解析。而XML的版本如果扣除空白部分可能需要69 byte，将需要5,000~10,000ns来解析。
另外，操作一个protocol buffer更容易：

	cout << "Name: " << person.name() << endl;
	cout << "E-mail: " << person.email() << endl;

然而XML需要这样解析：

	cout << "Name: "
     	 << person.getElementsByTagName("name")->item(0)->innerText()
     	 << endl;
	cout << "E-mail: "
      	 << person.getElementsByTagName("email")->item(0)->innerText()
     	 << endl;

不过，protocol buffer也不是总比XML是个解决方案，例如protocol buffer不能很好的对一个基于文档标记的文本进行建模（如 HTML），因为你不能交错文本结构。另外XML可读性和可编辑性更强。protocol buffer至少在他们的原始格式是并不是。XML同时也是可扩展，自描述的。Protocol buffer只有提供了message描述文件.proto 文件才有意义。

## A bit of history
Protocol Buffer一开始在google是为了处理一个索引服务器请求/响应协议。在Protocol Buffer之前，请求和响应一个用来请求/响应的封装或解封的格式，它支持大量版本的协议。它是通过非常丑陋的代码来解决的，像下面这样：

	if (version == 3) {
   	...
 	} else if (version > 4) {
   		if (version == 5) {
     	...
   		}
   	...
 	}

显然，格式化协议使得采用新的协议的版本上线更复杂，因为开发者必须确保请求发起服务器和实际处理这些请求的服务器中间经过的所有服务器在他们切换到开始使用新协议之前能够理解新协议。
Protocol Buffer就是来解决这样许多这样的问题：

* 新的域能够很容易的引入。中间服务器不需要注入数据就能简单地解析他，并且不需要了解所有的域就可以传输数据。
* 格式要能够自描述，能够处理各种类型的编程语言（C++,java,etc）

然而，用户仍然要手写他们自己的解析代码。
因为系统升级，有大量的特性和用途：

* 自动化产生序列化和反序列化代码，避免手动解析。
* 另外对于短生命周期的RPC请求，人们开始使用protocol buffers 作为一种手动的自描述格式来短期存储数据（例如在，Bigtable中）
* 服务器RPC 接口开始成为protocl文件的一部分，protocol编译器产生存根类，用户可以重写服务器端接口实际的操作。

protocol buffer现在是Google数据的通用语，在google代码树中通过12,183个 .proto文件定义了48,162种不同的message类型。他们被应用在RPC系统和各种存储系统的各种短期存储中。




	
## proto3
最新的version 3 [发布页](https://github.com/google/protobuf/releases)  介绍了一个 新语言版本——Protocol Buffers language version 3（aka proto3），同时现有版本的语言（aka proto2）增加了很多新特性。Proto3简化了protocol buffer语言，同时简化了使用，使得可以应用在更广泛的编程语言:现有的支持Java，C++，Python，JavaNano和Ruby，和一些限制。另外最新版的proto3通过Go protoc插件支持Go。更多的语言支持正在进行中。
只在以下情况建议使用proto3:
* 如果你想在只有新版本支持的语言中使用protocol buffers。
* 如果你想尝试新的开源RPC操作gRPC，我们建议对所有的新gRPC服务器和客服端中使用proto3，因为他避免了兼容性问题。

注意到这两个版本的API不是完全兼容。为了避免给现有用户带来不便，我们需要在新的protocol buffers发布中继续支持已有的语言版本。

