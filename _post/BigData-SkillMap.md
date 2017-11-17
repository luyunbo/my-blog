---
layout: post
date: 2015/03/20
title: 大数据工程人员知识图谱
categories: [learning]
tags: [bigdata]
---

大数据相关工程人员需要掌握的技术相关知识点。主要涉及到数据库、数据仓库、编程、分布式系统、Hadoop生态系统相关、数据挖掘和机器学习相关的基础知识点
<!--more-->
<table>
	<tr>
		<td valign="top" width="62"><span style="color: #000000;">Topic</span></td>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Content</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Key points</span></td>
		<td valign="top" width="80"><span style="color: #000000;">Reference</span></td>
		</tr>
	<tr>
		<td rowspan="4" valign="top" width="62"><span style="color: #000000;">DB/OLTP &amp; DW/OLAP</span></td>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Database/OLTP basic</span></td>
		<td valign="top" width="149"><span style="color: #000000;">The relational model, SQL, index/secondary index, inner join/left join/right join/full join, transaction/ACID</span></td>
		<td rowspan="4" valign="top" width="80"><span style="color: #000000;">Ramakrishnan, Raghu, and Johannes Gehrke. Database Management Systems.</span></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Database internal &amp; implementation</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Architecture, memory management, storage/B+ tree, query parse /optimization/execution, hash join/sort-merge join</span></td>
		</tr>
		<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Distributed and parallel database</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Sharding, database proxy</span></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Data warehouse/OLAP</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Materialized views, ETL, column-oriented storage, reporting, BI tools</span></td>
	</tr>
	<tr>
		<td rowspan="5" valign="top" width="62"><span style="color: #000000;">Basic programming</span></td>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Programming language</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Java, Python (Pandas/NumPy/SciPy/scikit-learn), SQL, Functional programming, R/SAS/SPSS</span></td>
		<td rowspan="5" valign="top" width="80"><span style="color: #000000;">Wes McKinney. Python for Data Analysis: Agile Tools for Real World Data.</span>&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">OS</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Linux</span></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">DB &amp; DW system</span></td>
		<td valign="top" width="149"><span style="color: #000000;">MySQL/ Hive/Impala</span></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Text format and process</span></td>
		<td valign="top" width="149"><span style="color: #000000;">JSON/XML, regex</span></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Tool</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Git/SVN, Maven</span></td>
	</tr>
	<tr>
		<td rowspan="10" valign="top" width="62"><span style="color: #000000;">Distributed system &amp; Hadoop ecosystem &amp; NoSQL</span></td>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Distributed system principal theory</span></td>
		<td valign="top" width="149"><span style="color: #000000;">CAP theorem, RPC (Protocol Buffer/Thrift/Avro), Zookeeper, Metadata management (HCatalog)</span></td>
		<td valign="top" width="80"></td>
	</tr>
	<tr>
		<td colspan="2" valign="top" width="113"><span style="color: #000000;">Distributed storage &amp; computing framework &amp; resource management</span></td>
		<td valign="top" width="149"><span style="color: #000000;">Hadoop/HDFS/MapReduce/YARN</span></td>
		<td valign="top" width="80"><span style="color: #000000;">Tom White. Hadoop : The Definitive Guide.</span><p></p>
		<p><span style="color: #000000;">Donald Miner, Adam Shook. MapReduce Design Patterns : Building Effective Algorithm and Analytics for Hadoop and Other Systems.</span></p></td>
	</tr>
	<tr>
	<td rowspan="2" valign="top" width="50"><span style="color: #000000;">SQL on Hadoop</span></td>
	<td valign="top" width="64"><span style="color: #000000;">Data (log) acquisition/integration/fusion, normalization, feature extraction</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Sqoop, Flume/Scribe/Chukwa,</span><span style="color: #000000;">SerDe</span></td>
	<td rowspan="2" valign="top" width="80"><span style="color: #000000;">Edward Capriolo, Dean Wampler, Jason Rutherglen. Programming Hive.</span></td>
	</tr>
	<tr>
	<td valign="top" width="64"><span style="color: #000000;">Query &amp; In-database analytics</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Hive, Impala, UDF/UDAF</span></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Large scale data mining &amp; machine learning framework</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Spark/MLbase, MR/Mahout</span></td>
	<td valign="top" width="80"></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Streaming process</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Storm</span></td>
	<td valign="top" width="80"></td>
	</tr>
	<tr>
	<td rowspan="4" colspan="2" valign="top" width="113"><span style="color: #000000;">NoSQL</span></td>
	<td valign="top" width="149"><span style="color: #000000;">HBase/Cassandra (column oriented database)</span></td>
	<td rowspan="4" valign="top" width="80"><span style="color: #000000;">Lars George. HBase: The Definitive Guide.</span></td>
	</tr>
	<tr>
	<td valign="top" width="149"><span style="color: #000000;">Mongodb (Document database)</span></td>
	</tr>
	<tr>
	<td valign="top" width="149"><span style="color: #000000;">Neo4j (graph database)</span></td>
	</tr>
	<tr>
	<td valign="top" width="149"><span style="color: #000000;">Redis (cache)</span></td>
	</tr>
	<tr>
	<td rowspan="10" valign="top" width="62"><span style="color: #000000;">Data mining &amp; Machine learning</span></td>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">DM &amp; ML basic</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Numerical/Categorical variable, training/test data, over fitting, bias/variance, precision/recall, tagging</span></td>
	<td valign="top" width="80"></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Statistic</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Data exploration (mean, median/range/standard deviation/variance/histogram), Continues distributions (Normal/ Poisson/Gaussian), covariance, correlation coefficient, distance and similarity computing, Bayes theorem, Monte Carlo Method, Hypothesis testing</span></td>
	<td valign="top" width="80"></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Supervised learning</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Classifier, boosting, prediction, regression analysis</span></td>
	<td rowspan="7" valign="top" width="80">
	<p align="left"><span style="color: #000000;">Han, Jiawei,Micheline Kamber, and Jian Pei.&nbsp;Data mining: concepts and techniques.</span></p>
	<p>&nbsp;</p></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Unsupervised learning</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Cluster, deep learning</span></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Collaborative filtering</span></td>
	<td valign="top" width="149">
	<p align="left"><span style="color: #000000;">Item based CF, user based CF</span></p>
	<p>&nbsp;</p></td>
	</tr>
	<tr>
	<td rowspan="4" valign="top" width="50"><span style="color: #000000;">Algorithm</span></td>
	<td valign="top" width="64"><span style="color: #000000;">Classifier</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Decision trees, KNN (K-Nearest neighbor), SVM (support vector machines), SVD (Singular Value Decomposition), naïve Bayes classifiers, neural networks,</span></td>
	</tr>
	<tr>
	<td valign="top" width="64"><span style="color: #000000;">Regression</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Linear regression, logistic regression, ranking, perception</span></td>
	</tr>
	<tr>
	<td valign="top" width="64"><span style="color: #000000;">Cluster</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Hierarchical cluster, K-means cluster, Spectral Cluster</span></td>
	</tr>
	<tr>
	<td valign="top" width="64"><span style="color: #000000;">Dimensionality reduction</span></td>
	<td valign="top" width="149"><span style="color: #000000;">PCA (Principal Component Analysis), LDA (Linear discriminant Analysis), MDS (Multidimensional scaling)</span></td>
	</tr>
	<tr>
	<td colspan="2" valign="top" width="113"><span style="color: #000000;">Text mining &amp; Information retrieval</span></td>
	<td valign="top" width="149"><span style="color: #000000;">Corpus, term document matrix, term frequency &amp; weight, association rules, market based analysis, vocabulary mapping, sentiment analysis, tagging, PageRank, VSM (Vector Space Model), inverted index</span></td>
	<td valign="top" width="80"><span style="color: #000000;">Jimmy Lin and Chris Dyer. Data-Intensive Text Processing with MapReduce.</span></td>
	</tr>
</table>