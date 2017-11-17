layout: post
date: 2016/01/13
title: JQuery的insert、prepend和append
categories: [Javascript]
tags: [Javascript]
---

insert 是值将元素插入到对应元素之外即`<a></a>`,使用`$("a").insertBefore("<span>insert</span>")`后，效果是`<span>insert</span>`

prepend 是值将元素插入对应元素标签之内，紧跟标签元素。如`<a><div></div></a>`,
使用`$("a").prepend("<span>prepend</span>")`后，效果是`<a><span>prepend</span><div></div></a>`。与其等效的方法是`("<span>prepend</span>").prependTo("a")`

append的是将值插入到对应的元素之内，放置其后`<a><div></div></a>`,使用`$("a").append("<span>prepend</span>")`后，效果是`<a><div></div><span>prepend</span></a>`与其等效的方法是`("<span>prepend</span>").appendTo("a")`。
