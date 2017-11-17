layout: post
date: 2014/12/25
title: Hadoop中Partition解析
categories: [learning, hadoop]
tags: [Java]
---


### 1.解析Partition

Map的结果，会通过partition分发到Reducer上，Reducer做完Reduce操作后，通过OutputFormat，进行输出，下面我们就来分析参与这个过程的类。
Mapper的结果，可能送到Combiner做合并，Combiner在系统中并没有自己的基类，而是用Reducer作为Combiner的基类，他们对外的功能是一样的，
只是使用的位置和使用时的上下文不太一样而已。Mapper最终处理的键值对<key, value>，是需要送到Reducer去合并的，合并的时候，有相同key的
键/值对会送到同一个Reducer那。哪个key到哪个Reducer的分配过程，是由Partitioner规定的。它只有一个方法,

	getPartition(Text key, Text value, int numPartitions) 

输入时Map的结果对<key, value>和Reducer的数目，输出则是分配的Reducer（整数编号）。就是指定Mapper输出的键值到哪一个reducer上去。系统缺省的Partition是HashPartitoner,它已key的Hash值对Reducer的数目取模，得到对应的Reducer。这样保证如果有相对的key值，肯定被分配到同一个reducer上。如果有N个reducer，编号就为0,1,2,3……（N-1)。

<!--more-->

Reducer是所有用户定制Reducer类的基类，和Mapper类似，它也有setup，reducer，cleanup和run方法，其中setup和cleanup含义和和Mapper相同，reduce是真正合并到Mapper结果的地方，它的输入是key和这个key对用的所有value的一个迭代器，同时还包括Reducer的上下文。系统中定义了两个非常简单的Reducer，IntSumReducer和LongSumReducer，分别用于对整形/长整形的value求和。

Reduce的结果，通过Reducer.Context的方法collect输出到文件中，和输入类似，Hadoop引入了OutputFormat。OutputFormat依赖两个辅助接口：RecordWriter和OutputCommitter，来处理输出。RecordWriter提供了write方法，用于输出<key, value>和close方法，用于关闭对应的输出。OutputCommitter提供了一系列方法，用户通过实现这些方法，可以定制OutputFormat生存期某些阶段需要的特殊操作。我们在TaskInputOutputContext中讨论过这些方法（明显，TaskInputOutputContext是OutputFormat和Reducer间的桥梁）。OutputFormat和RecordWriter分别对应着InputFormat和RecordReader，系统提供了空输出NullOutputFormat（什么结果都不输出，NullOutputFormat.RecordWriter只是示例，系统中没有定义），LazyOutputFormat（没在类图中出现，不分析），FilterOutputFormat（不分析）和基于文件FileOutputFormat的SequenceFileOutputFormat和TextOutputFormat输出。

基于文件的输出FileOutputFormat利用了一些配置项配合工作，包括:

- mapred.output.compress：是否压缩；
- mapred.output.compression.codec：压缩方法；
- mapred.output.dir：输出路径；
- mapred.work.output.dir：输出工作路径。
- FileOutputFormat还依赖于FileOutputCommitter，通过FileOutputCommitter提供一些和Job，Task相关的临时文件管理功能。如FileOutputCommitter的setupJob，会在输出路径下创建一个名为_temporary的临时目录，cleanupJob则会删除这个目录。
- SequenceFileOutputFormat输出和TextOutputFormat输出分别对应输入的SequenceFileInputFormat和TextInputFormat。

### 2.代码实例
	package org.apache.hadoop.examples;

	import java.io.IOException;
	import java.util.*;
	import org.apache.hadoop.fs.Path;
	import org.apache.hadoop.conf.*;
	import org.apache.hadoop.io.*;
	import org.apache.hadoop.mapred.*;
	import org.apache.hadoop.util.*;
	
	/**
	 * 输入文本，以tab间隔
	 * kaka    1       28
	 * hua     0       26
	 * chao    1
	 * tao     1       22
	 * mao     0       29      22
	 * */
	
	//Partitioner函数的使用
	
	public class MyPartitioner {
		// Map函数
		public static class MyMap extends MapReduceBase implements
				Mapper<LongWritable, Text, Text, Text> {
			public void map(LongWritable key, Text value,
					OutputCollector<Text, Text> output, Reporter reporter)
					throws IOException {
				String[] arr_value = value.toString().split("\t");
				//测试输出
	//			for(int i=0;i<arr_value.length;i++)
	//			{
	//				System.out.print(arr_value[i]+"\t");
	//			}
	//			System.out.print(arr_value.length);
	//			System.out.println();		
				Text word1 = new Text();
				Text word2 = new Text();
				if (arr_value.length > 3) {
					word1.set("long");
					word2.set(value);
				} else if (arr_value.length < 3) {
					word1.set("short");
					word2.set(value);
				} else {
					word1.set("right");
					word2.set(value);
				}
				output.collect(word1, word2);
			}
		}
	
	public static class MyReduce extends MapReduceBase implements
			Reducer<Text, Text, Text, Text> {
		public void reduce(Text key, Iterator<Text> values,
				OutputCollector<Text, Text> output, Reporter reporter)
				throws IOException {
			int sum = 0;
			System.out.println(key);
			while (values.hasNext()) {
				output.collect(key, new Text(values.next().getBytes()));	
			}
		}
	}

	// 接口Partitioner继承JobConfigurable，所以这里有两个override方法
	public static class MyPartitionerPar implements Partitioner<Text, Text> {
		/**
		 * getPartition()方法的
		 * 输入参数：键/值对<key,value>与reducer数量numPartitions
		 * 输出参数：分配的Reducer编号，这里是result
		 * */
		@Override
		public int getPartition(Text key, Text value, int numPartitions) {
			// TODO Auto-generated method stub
			int result = 0;
			System.out.println("numPartitions--" + numPartitions);
			if (key.toString().equals("long")) {
				result = 0 % numPartitions;
			} else if (key.toString().equals("short")) {
				result = 1 % numPartitions;
			} else if (key.toString().equals("right")) {
				result = 2 % numPartitions;
			}
			System.out.println("result--" + result);
			return result;
		}
		
		@Override
		public void configure(JobConf arg0) 
		{
			// TODO Auto-generated method stub
		}
	}

	//输入参数：/home/hadoop/input/PartitionerExample /home/hadoop/output/Partitioner
	public static void main(String[] args) throws Exception {
		JobConf conf = new JobConf(MyPartitioner.class);
		conf.setJobName("MyPartitioner");
		
		//控制reducer数量，因为要分3个区，所以这里设定了3个reducer
		conf.setNumReduceTasks(3);

		conf.setMapOutputKeyClass(Text.class);
		conf.setMapOutputValueClass(Text.class);

		//设定分区类
		conf.setPartitionerClass(MyPartitionerPar.class);

		conf.setOutputKeyClass(Text.class);
		conf.setOutputValueClass(Text.class);

		//设定mapper和reducer类
		conf.setMapperClass(MyMap.class);
		conf.setReducerClass(MyReduce.class);

		conf.setInputFormat(TextInputFormat.class);
		conf.setOutputFormat(TextOutputFormat.class);

		FileInputFormat.setInputPaths(conf, new Path(args[0]));
		FileOutputFormat.setOutputPath(conf, new Path(args[1]));

		JobClient.runJob(conf);
	}
}



	
	