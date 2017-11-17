---
layout: post
date: 2015/05/28
title: php 抽奖算法
categories: [php]
tags: [php]
---


今天股票大跌，黑色星期四。

今天写了一个用来负载均衡程序，抽象一下可以看成就是一抽奖程序。

现在A股也想抽奖，就应景一下把这程序记录一下，其实很简单，直接贴代码。
<!--more-->
	function get_rand($proArr) { 
	    $result = ''; 
	    //概率数组的总概率精度 
	    $proSum = array_sum($proArr); 
	    //概率数组循环 
	    foreach ($proArr as $key => $proCur) { 
	        $randNum = mt_rand(1, $proSum);             //抽取随机数
	        if ($randNum <= $proCur) { 
	            $result = $key;                         //得出结果
	            break; 
	        } else { 
	            $proSum -= $proCur;                     
	        } 
	    } 
	    unset ($proArr); 
	    return $result; 
	}

这段代码能够实现抽奖功能，当比较难从数学上证明正好服从设置的概率分布（有待证明,样本空间不变因此概率是一样的，有待补充。）

写成这样，思维上比较顺。

    function get_rand($arr)
    {
        $pro_sum=array_sum($arr);
        $rand_num=mt_rand(1,$pro_sum);
        $tmp_num=0;
        foreach($arr as $k=>$val)
        {    
            if($rand_num<=$val+$tmp_num)
            {
                $n=$k;
                break;
            }else
            {
                $tmp_num+=$val;
            }
        }
        return $n;
    }

