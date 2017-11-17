# Javascript构造函数的继承

动物的构造函数

```javascript
function Animal(){
　　　　this.species = "动物";
　　}
```

猫的构造函数

{% codeblock lang:js%}
function Cat(name,color){
　　　　this.name = name;
　　　　this.color = color;
　　}
{% endcodeblock %}

猫继承动物

{% codeblock lang:js%}
function extend(Child, Parent) {

　　　　var F = function(){};
　　　　F.prototype = Parent.prototype;
　　　　Child.prototype = new F();
　　　　Child.prototype.constructor = Child;
　　　　Child.uber = Parent.prototype;
　　}
{% endcodeblock %}
