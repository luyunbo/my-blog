---
title: Redis持久化----RDB和AOF
date: 2018-03-29 17:25:22
categories: [tech]
tags: [Redis]
---

### redis持久化----两种方式

1. redis提供了两种持久化的方式，分别是RDB（Redis DataBase）和AOF（Append Only File）。

2. RDB，简而言之，就是在不同的时间点，将redis存储的数据生成快照并存储到磁盘等介质上；

3. AOF，则是换了一个角度来实现持久化，那就是将redis执行过的所有写指令记录下来，在下次redis重新启动时，只要把这些写指令从前到后再重复执行一遍，就可以实现数据恢复了。

4. 其实RDB和AOF两种方式也可以同时使用，在这种情况下，如果redis重启的话，则会优先采用AOF方式来进行数据恢复，这是因为AOF方式的数据恢复完整度更高。

5. 如果你没有数据持久化的需求，也完全可以关闭RDB和AOF方式，这样的话，redis将变成一个纯内存数据库，就像memcache一样。
