# Protocol Buffer Encoding

这篇文章描述了protocol buffre消息的二进制有序格式。使用protocol buffers不需要理解这些，但是理解这些能够帮助你了解不同的protocol buffer格式是如何影响你的消息的编码。
<!--more-->
## 一个简单的消息

定义以下一个简单的消息：
```
	message Test1 {
	  required int32 a = 1;
	}
```
在应用程序中，你可以创建一个Test1 消息，然后设置它的值为150。然后你将该消息序列化得到一个输出流。如果你可以查看编码过的消息，会看到 以下3 byte：
```
	88 96 01
```
## Base 128 Varint
Varint 是一种紧凑的表示数字的方法。它用一个或多个字节来表示一个数字，值越小的数字使用越少的字节数。这能减少用来表示数字的字节数。
比如对于 int32 类型的数字，一般需要 4 个 byte 来表示。但是采用 Varint，对于很小的 int32 类型的数字，则可以用 1 个 byte 来表示。当然凡事都有好的也有不好的一面，采用 Varint 表示法，大的数字则需要 5 个 byte 来表示。从统计的角度来说，一般不会所有的消息中的数字都是大数，因此大多数情况下，采用 Varint 后，可以用更少的字节数来表示数字信息。下面就详细介绍一下 Varint。

Varint 中的每个 byte 的最高位 bit 有特殊的含义，如果该位为 1，表示后续的 byte 也是该数字的一部分，如果该位为 0，则结束。其他的 7 个 bit 都用来表示数字。因此小于 128 的数字都可以用一个 byte 表示。大于 128 的数字，比如 300，会用两个字节来表示：
```
	1010 1100 0000 0010
```
## Message Structure
protocol buffer是 一系列的 key-value 对。二进制消息只是用他们的域的数值来作为他们的key——可以有message 类型唯一解析的域名和域的类型。
消息被编码的时候，key和value都会被串连到一个字节流汇总。当消息被解析的时候，解析器能够跳过它不能识别的域。通过这种方式，新的域能过被添加到一条消息里面，同时不破坏不能解析它们的老程序。为了这个目的，每对的key其实是两个值得组合——域的数值和wire type（能够提供足够信息找到后面value的长度）

<div class="devsite-table-wrapper"><table width="50%" border="1">
<tbody><tr><th>Type</th><th>Meaning</th><th>Used For</th></tr>
<tr><td>0</td><td>Varint</td><td>int32, int64, uint32, uint64, sint32, sint64, bool, enum</td></tr><tr>
</tr><tr><td>1</td><td>64-bit</td><td>fixed64, sfixed64, double</td></tr><tr>
</tr><tr><td>2</td><td>Length-delimited</td><td>string, bytes, embedded messages, packed repeated fields</td></tr><tr>
</tr><tr><td>3</td><td>Start group</td><td>groups (deprecated)</td></tr><tr>
</tr><tr><td>4</td><td>End group</td><td>groups (deprecated)</td></tr><tr>
</tr><tr><td>5</td><td>32-bit</td><td>fixed32, sfixed32, float</td></tr><tr>
</tr></tbody></table></div>

Key 用来标识具体的 field，在解包的时候，Protocol Buffer 根据 Key 就可以知道相应的 Value 应该对应于消息中的哪一个 field。
Key 的定义如下：
```
	 (field_number << 3) | wire_type
```
可以看到 Key 由两部分组成。最后3 bit是用来存储wire type。第一部分是 field_numbe。第二部分为 wire_type。表示 Value 的传输类型。
再来看一个简单的例子。一条消息的第一个数字总是varint key，是08，或者如下（去掉msb）：
```
	000 1000
```
去最后三位得到wire type 0，然后右移三位得到 field number 1.因为你知道tag是1，加下来的value是varint。使用前面描述的varint解码，得到后续两个字节存储的是150.

>96 01 = 1001 0110  0000 0001
       → 000 0001  ++  001 0110 (drop the msb and reverse the groups of 7 bits)
       → 10010110
       → 2 + 4 + 16 + 128 = 150

在计算机内，一个负数一般会被表示为一个很大的整数，因为计算机定义负数的符号位为数字的最高位。如果采用 Varint 表示一个负数，那么一定需要 5 个 byte。为此 Google Protocol Buffer 定义了 sint32 这种类型，采用 zigzag 编码。
Zigzag 编码用无符号数来表示有符号数字，正数和负数交错，这就是 zigzag 这个词的含义了。
如下表所示：

<div class="devsite-table-wrapper"><table width="50%" border="1">
<tbody><tr><th>Signed Original</th><th>Encoded As</th></tr>
<tr><td>0</td><td>0</td></tr><tr>
</tr><tr><td>-1</td><td>1</td></tr><tr>
</tr><tr><td>1</td><td>2</td></tr><tr>
</tr><tr><td>-2</td><td>3</td></tr><tr>
</tr><tr><td>2147483647</td><td>4294967294</td></tr><tr>
</tr><tr><td>-2147483648</td><td>4294967295</td></tr><tr>
</tr></tbody></table></div>

也可以理解成，对于sint32，每个值 n 被编码成
```
	(n << 1) ^ (n >> 31)
```
对于sint64
```	
	(n << 1) ^ (n >> 63)
```
 注意到第二个因为是算数移位。其实也就是，移位的结果要么全是0（n 是正数）要么全是1（n 是负数）
当 sint32 或sint64 被解析的时候，他的value被解码成原来的带符号的版本。

### 非 varint 数字
非 varint 数值类型比较简单，double 和 fixed64 的wire type为1，这告诉解析器这是一个固定为64 bit 的数据块。类似的，float 和 fixed64 的 wire type 为5，这说明就是32 bit的。这两种类型的都是采用 little-endian 的存储方式。

### String
一个 wire type 2移位这个这个value是varint 编码，后面跟着一序列的特殊数据的字节。
```
	message Test2 {
	  required string b = 2;
	}
```
设置b成“testing”，则有：

>12 07 **74 65 73 74 69 6e 67**

加粗部分为”testing“的UTF-8编码，key 为 0x12 → tag = 2, type = 2。value的 varint 长度为7。

### 嵌套消息
定义如下一个嵌套消息：
```
	message Test3 {
	  required Test1 c = 3;
	}
```
Test1的域 a 被设置成150，则编码过后得到：
> 1a 03 **08 96 01**
后三位 08 96 01 正好是前面150的编码，数字3在他们前面，嵌套消息被看成是string。

###可选项和重复元素
如果你定义的message拥有repeated成员（没有选项[packed = true]），那么编码的消息有零到多个相同tag的key-value对。这些repeated values 不一定连续。他们可能和其他字段交错。这写元素彼此的相对位置在解析的时候会被保留，然后和其他域的相对位置会丢失。

如果有optionan成员，tag对应的key-value对可能有，也可能没有。

通常，一个编码的消息不会有多余一个的optional或required的示例。然后解析器也能处理多余一个情况。对于数值类型和字符串，如果相同的value出现多次，他们将接受它认为的最后一个value。对于嵌套消息的字段，解析器合并相同域的多个实例，就像用`Message::MergeFrom`，所有的单一标量字段将有后来代替先来的。单一个嵌套message会被合并，重复的字段被串连在一起。这些规则保证了间歇两个嵌套的消息的结果和你单独分开解析两个消息然后合并他们的结果是一致的。示例如下：
```c++
	MyMessage message;
	message.ParseFromString(str1 + str2);
```
等价于：
```c++
	MyMessage message, message2;
	message.ParseFromString(str1);
	message2.ParseFromString(str2);
	message.MergeFrom(message2);
```
这个性质比较有用，因为他允许你合并两个消息，尽管你不知道他们的类型。

Packed Repeated Fields
Version 2.1.0引入了packed repeated 字段，带有选项[packed=true]的repeated字段。这个功能像repeated字段，但编码不同。0个元素的Packed Repeated  字段不会出现在编码消息中。否则，所有的字段元素都会被打包成成一个key-value对，wire type 为2。 每个元素都会以同样的方式编码，除了没有tag在他们前面。
例如：
```
	message Test4 {
	  repeated int32 d = 4 [packed=true];
	}
```
假设Test4 的字段d有值有3,270和86942，则编码形式如下：
```
	22        // tag (field number 4, wire type 2)
	06        // payload size (6 bytes)
	03        // first element (varint 3)
	8E 02     // second element (varint 270)
	9E A7 05  // third element (varint 86942)
```
只有原始数值类型的repeated字段可以有“packed”。
注意到尽管一般没有理由编码更多的key-value对给一个packed repeated字段。编码器必须准备应复合key-value对。在这种情况下，负荷必须边串连进去。每对必须包含所有所有元素。

## 字段顺序
在.proto文件中使字段可以是任意顺序的，当一条消息被序列化的时候，它所知道的字段是会根据字段标号顺序写入，就像C++，Java，Python的序列化代码。这允许解析代码可以根据有序的字段标号进行进行优化。然后protocol buffer 的解析器必须是能够解析任意顺序的字段，因为并非所有的消息都是被建成有序的对象，例如，这有时对简单串联合并的两个消息很有用。

如果一个消息的拥有未知字段，现有Java 和C++ 操作在完成其他已知字段的序列化后将他们以任意顺序写入。现有的Python追踪未知字段。
