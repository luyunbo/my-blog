# JSP学习笔记一
- learning
- JSP
- JSP
comments: true


# 1. JSP简介
JSP是 Java ServerPages的缩写，是有SUN公司于1999年6月推出的技术，通过在HTML中插入脚本代码从而构成JSP页面。JSP是基于 Java Servlet 及整个 Java 体系的Web开发技术，可以利用这一技术来构建安全的，跨平台的动态Web站点。JSP目前在不断的优化。

<!--more-->

JSP具有以下主要特点

*   程序逻辑和显示分离
*   可重用组件
*   使用标签化页面开发
*   具有Java的特点

# 2. JSP运行机制
先看简单的JSP示例

HelloWorld.jsp

    <html>
    <head>
        <title>Hello JSP</title>
    </head>
    <body>
    <%
        out.println("Hello JSP!");
    %>
    </body>
    </html>

在浏览器地址栏中输入HelloJSP.jsp，打开页面可以得到输出

    Hello JSP

该示例代码中通过out.println()实现网页的输出是为了与转义之后的Servlet文件比较。

运行完成该JSP页面后，打开Tomcat安装目录下的Work文件夹。在该目录中可以找到与该JSP文件相对应的Java文件，以及编译后的Class文件。下面勒出了部分Java代码。

    out.write("<html>\r\n");
    out.write("<head>\r\n");
    out.write("<title>Hello JSP</title>\r\n");
    out.write("</head>\r\n");
    out.write("<body>\r\n");
    out.write("\t");
    out.println("Hello JSP!");
    out.write("\r\n");
    out.write("</body>\r\n");
    out.write("</html>\r\n");
    
使用I浏览器打开该JSP页面，选择查看页面源代码，代码如下所示

    <html>
    <head>
        <title>Hello JSP</title>
    </head>
    <body>
        Hello JSP!
    </body>
    </html>

可以把JSP页面的执行分成两个阶段，一个是转译阶段，一个是请求阶段。

 -   转译阶段：JSP页面转换成Servlet类。
 -   请求阶段：Servlet类执行，将相应结果发送给客户端。

JSP执行流程解释如下：

 1. 用户（客户机）请求相应的JSP页面。
 2. 服务器找到相应的JSP页面。
 3. 服务器将JSP转译成Servlet的源代码。
 4. 服务器将Servlet源代码编译成class文件。
 5. 服务器将class文件加载到内存并执行。
 6. 服务器将class文件执行后生成的HTML代码发送给客户机，客户机浏览器根据相应的HTML代码进行显示。
 
如果该JSP页面为第一次执行，那么会经过这两个阶段，而如果不是第一次执行，那么僵只会执行清酒阶段。这要是为什么第二次执行JSP页面时明显比第一次执行要快的原因。
如果修改了JSP页面，那么服务器将发现该修改，并重新执行转译阶段和请求阶段。这也是为什么修改页面之后访问速度变慢的原因。
