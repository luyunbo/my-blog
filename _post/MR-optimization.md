---
layout: post
date: 2015/05/20
title: MapReduce 的优化Tips
categories: [MapReduce]
tags: [hadoop]
---


最近在都做MapReduce，但是MapReduce没有想象中处理数据这么快，结果发现并不能盲目的使用MapReduce。MapReduce是可以许多机器同时计算，但是并行计算带来的性能提升是有限的，有事反而会因为使用MapReduce过于简单粗暴，不根据具体的业务场景做适当的优化，反而会使程序性能下降。下面以最近的一个任务的完成为线索，将最近学习到的优化经验总结一下。
## 任务场景
 
* 数据A：包含url、ip、cookie、id、pv等数据
* 数据B：ip字典（ip到地区的id映射）
* 要求：以site*ip为统计粒度，计算数据分布，并且需要在数据里拼接上id
* 目的：分析不同地区是否方位不同站点的偏好，去掉无法查到地区ip的数据

<!--more-->

### Mapreduce程序设计

以url和ip为key，ip为partition，在reduce阶段进行数据合并

* Map1输出：`(key:<ip1,url1>,vaule:pv1)`

* Map2输出：`(key:<ip2,"", vaule:locationid)`

* Reducer输出：`（ip, url, locationid, total_pv)`

### 性能优化

* 在map阶段加上combiner，减少从map到reducer传输的数据量

* 在map的task中开辟一块内存，构造一个cache，代替combiner的工作

* 对ip数据进行采样，计算出合理的分桶方法，重写并设置partition
	* 从100条数据中抽取一天数据
	* 将ip转化为数字进行排序
	* 划分区间

* 如果ip字典很小，不采用reduce合并的方法，在map阶段，加载ip字典到内存中，直接查询。

*  如果ip字典很大，但是很多ip在字典中查不到。仍采用reduce阶段合并，预先计算一个ip的bloomfilter，用于在map阶段过来数据。

