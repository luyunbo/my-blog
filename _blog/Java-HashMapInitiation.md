# Java 中 HashMap 的初始化


### 1、普通写法

	HashMap<String, String> map = new HashMap<String, String>();
	map.put("Name", "June");  
	map.put("QQ", "4889983");

<!--more-->

### 2、文艺写法

	HashMap<String, String> map = new HashMap<String, String>() {
    	{
        put("Name", "June");  
        put("QQ", "4889983");  
    	}
	};

第一层括弧实际是定义了一个匿名内部类 (Anonymous Inner Class)，第二层括弧实际上是一个实例初始化块 (instance initializer block)，这个块在内部匿名类构造时被执行。这个块之所以被叫做“实例初始化块”是因为它们被定义在了一个类的实例范围内。

类似都可以在ArrayList、set上推广：

	List<String> names = new ArrayList<String>() {
	    {
	        for (int i = 0; i < 10; i++) {
	            add("A" + i);
	        }
	    }
	};

### 3、文艺写法存在的问题

如果这个对象要串行化，可能会导致串行化失败。

1. 此种方式是匿名内部类的声明方式，所以引用中持有着外部类的引用。所以当时串行化这个集合时外           部类也会被不知不觉的串行化，当外部类没有实现serialize接口时，就会报错。

2. 上例中，其实是声明了一个继承自HashMap的子类。然而有些串行化方法，例如要通过Gson串行化为         json，或者要串行化为xml时，类库中提供的方式，是无法串行化Hashset或者HashMap的子类的，从而导致串行化失败。解决办法：重新初始化为一个HashMap对象：

	`new HashMap(map);`

	这样就可以正常初始化了。
3. 效率比普通写法低。
