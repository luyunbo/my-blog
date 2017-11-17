# jQuery each() 方法遍历

### 定义和用法
each() 方法规定为每个匹配元素规定运行的函数。
提示：返回 false 可用于及早停止循环。

<!--more-->

### 语法

```
$(selector).each(function(index,element))
```
<table>
    <tr>
        <td>参数</td>
        <td>描述</td>
    </tr>
    <tr>
        <td>function(index,element)</td>
        <td>必需。为每个匹配元素规定运行的函数。<li>index  - 选择器的 index 位置 </li> <li> element - 当前的元素（也可使用 "this" 选择器</li></td>
    </tr>
</table>

### 实例
```javascript
$("button").click(function(){
  $("li").each(function(){
    alert($(this).text())
  });
});
```


### each和map的区别
jquery中的each函数和map函数的用法看起来差不多，但其实还是有一点区别的。

其中一个重要的区别是，each返回的是原来的数组，并不会新创建一个数组。而map方法会返回一个新的数组。如果在没有必要的情况下使用map，则有可能造成内存浪费。

```javascript
var items = [1,2,3,4];
​  $.each(items, function() {
      alert('this is ' + this);
  });
  var newItems = $.map(items, function(i) {
      return i + 1;
  });
  // newItems is [2,3,4,5]
  ```

  使用each时，改变的还是原来的items数组，而使用map时，不改变items，只是新建一个新的数组。

  ```javascript
  var items = [0,1,2,3,4,5,6,7,8,9];
​  var itemsLessThanEqualFive = $.map(items, function(i) {
      // removes all items > 5
      if (i > 5) 
        return null;
      return i;
    });
    // itemsLessThanEqualFive = [0,1,2,3,4,5]


当需要对数组进行删除时也是如此，所以删除时错误使用each或map后果还是蛮严重的。
