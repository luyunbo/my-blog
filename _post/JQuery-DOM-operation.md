layout: post
date: 2016/04/12
title: JQuery获取内容和属性
categories: [JQuery]
tags: [JQuery,Javascript]
---
### 获得内容 - text()、html() 以及 val

三个简单实用的用于 DOM 操作的 jQuery 方法：
* text() - 设置或返回所选元素的文本内容
* html() - 设置或返回所选元素的内容（包括 HTML 标记）
* val() - 设置或返回表单字段的值

### 获取属性 - attr()
jQuery attr() 方法用于获取属性值。

<!--more-->

```html
<!DOCTYPE html>
<html>
<head>
<script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js">
</script>
<script>
$(document).ready(function(){
  $("#btn1").click(function(){
    alert("Text: " + $("#test").text());
  });

  $("#btn2").click(function(){
    alert("HTML: " + $("#test").html());
  });

  $("#btn3").click(function(){
    alert("Value: " + $("#testval").val());
  });

  $("#btn4").click(function(){
    alert($("#w3s").attr("href"));
  });
});
</script>
</head>

<body>
<p id="test">This is some <b>bold</b> text in a paragraph.</p>
<button id="btn1">Show Text</button>
<button id="btn2">Show HTML</button>

<p>Name: <input type="text" id="testval" value="Mickey Mouse"></p>
<button id="btn3">Show Value</button>

<p><a href="http://www.w3cschool.cc" id="w3s">W3Cschool.cc</a></p>
<button id="btn4">Show href Value</button>
</body>
</html>
```