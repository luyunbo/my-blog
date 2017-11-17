layout: post
date: 2017/04/14
title: GBDT
categories: [tech]
tags: [machine learning]
---

### 1. 简介
GBDT 是一种迭代的决策树算法，该算法由多棵决策树组成，所有树的结论累加起来做最终答案。它在被提出之初就和SVM一起被认为是泛化能力（generalization)较强的算法。近些年更因为被用于搜索、推荐排序的机器学习模型而引起大家关注。 
<!-- more -->

GBDT有不同的名称如下，但所指算法都是一样的。

* GBDT - Gradient Boosting Decision Tree
* GBRT - Gradient Boosting Regression Tree
* MART - Multiple Additive Regression Tree
* GBM - Gradient Boosting Machine 


### 2. 应用领域
* 分类、回归、排序
* 推荐、广告等领域ctr预估（排序、分类）
* 特征组合(lr,fm,ffm + gbdt)， 应用于各类ctr大赛
 
### 3. 相关概念
GBDT作为一种机器学习算法， 其中所涉及的相关概念如下：

* 损失函数: 模型的不靠谱程度，值越大，模型越差
* 泛化能力: 模型在真实样本的表现，与模型复杂度有关
* 过拟合: 一味追求低损失，导致模型太复杂，泛化能力太差
* 学习率:迭代过程中权重更新时所乘的系数，也叫步长
* 正则化项:一般代表模型的复杂度，迭代时的惩罚因子，防止过拟合
* Gini指数: 度量样本分布的混乱程度，越纯净，值越小 

### 4. gbdt在推荐系统ctr预估中的应用
当gbdt作为ctr预估算法时， 可以把问题抽象成二分类问题。通过对数据抽取特征作为gbdt模型的输入，以预测最终是否被点击为目标， 通过训练得到模型供线上使用，以达到推荐排序的目的。 

### 5. gbdt 训练脚本

~~~shell
base_path=/home/work/zhaolunan/train/gbdt_tool
train_file_full=$base_path/data/gbdt_feature_expand_train
train_file=$base_path/data/gbdt_feature_expand_train_small
test_file_full=$base_path/data/gbdt_feature_test.ori
test_file=$base_path/data/gbdt_feature_test_small
model_name=$base_path/models/pic_gbdt.model
python $base_path/bin/extract_fileds.py $train_file_full $1 >$train_file
python $base_path/bin/extract_fileds.py $test_file_full $1 >$test_file
 
./gbrank-train -C ./tree_bigmodel_puni_balance.cfg -f $train_file -m ${model_name}
rm $base_path/tmp_data/score_expand.txt
 
./gbrank-test-fast ${model_name} $test_file $base_path/tmp_data/score_expand.txt.bak
awk -F " " '{print $1}' $test_file > $base_path/tmp_data/label_expand
 
paste -d " " $base_path/tmp_data/score_expand.txt.bak $base_path/tmp_data/label_expand > $base_path/tmp_data/score_expand.txt
echo $'\n'>>test_rst
echo -e "$1 \c">>test_rst
cat $base_path/tmp_data/score_expand.txt | python $base_path/bin/roc.py >>test_rst
~~~


### 6. gbdt 配置参数文件
```
# 该配置文件为树类算法的基本参数配置文件
[gbrank_info]
 
# 是否打印训练信息: 0代表不打印，1代表打印
is_print : 1
 
# 是否放回抽样, 0代表无放回抽样，1代表有放回抽样
bagging : 0
 
# 随机抽样方式：0代表按doc随机抽样，1代表按query随机抽样
rand_type : 0
 
# 损失函数：0代表hinge loss，1代表cross entropy, 2表示least square loss
loss_type : 0
 
# 样本采样率
sample_ratio : 1.0
 
# feature采30
rand_fea_ratio : 1.0
 
# 学习率
shrink : 0.1
 
# margin
tau : 0.5
 
# 指数
power : 1.0
 
#scale parameter in cross entropy
scale_nv : 1.0
 
# 树的数目
tree_num : 30
 
# 树的生长停止条件:树的最大深度
gbdt_max_depth : 6
 
# 树的生长停止条件:最大叶子节点个数
gbdt_max_node_num : 30
 
# 树的生长停止条件:节点覆盖的最小数据量
gbdt_min_node_size : 30
 
#随机种子
random_seed : 0
 
# 每步迭代同时建立树的棵树
mini_batch : 1
 
# 0: Random Forest, 1: GBDT, 2: GBRank
ens_type : 1
 
# 0: regression, 1 : classification，只有ensemble_type为0时，此配置才有效
reg_cls_type : 1
 
# 数据中是否含有query列，区别于LTR数据与普通数据，
has_qry_column : 0
 
# 开辟的多线程数目
process_num : 100
# 是否进行半监督学习
do_semi_supervise: 0
```

### 7. 训练数据格式
```
0 1:0.008854 2:0.011858 3:0.102610 4:0.165738 5:0.158512 6:0.586097 7:0.457950 8:0.100000 9:0.166104 10:0.011175 11:0.001764 12:0.003159 13:0.150759 14:0.138463 15:0.159089
0 1:0.005988 2:0.056539 3:0.099910 4:0.168533 5:0.050087 6:0.387259 7:0.072639 8:0.100000 9:0.050452 10:0.000000 11:0.050000 12:0.002245 13:0.440000 14:0.377017 15:0.049781
0 1:0.005988 2:0.000000 3:0.027003 4:0.156873 5:0.139522 6:0.585824 7:0.657016 8:0.200000 9:0.123281 10:0.151865 11:0.101937 12:0.000984 13:0.026884 14:0.009311 15:0.139212
0 1:0.017546 2:0.040792 3:0.007651 4:0.148147 5:0.143464 6:0.511610 7:0.737472 8:0.100000 9:0.156684 10:0.105788 11:0.032701 12:0.007229 13:0.176786 14:0.113610 15:0.157376
0 1:0.009049 2:0.020002 3:0.028803 4:0.102345 5:0.051461 6:0.586217 7:0.157447 8:0.100000 9:0.090286 10:0.036820 11:0.042546 12:0.001852 13:0.141935 14:0.086241 15:0.090083
0 1:0.008997 2:0.016620 3:0.404590 4:0.103703 5:0.033516 6:0.380074 7:0.011515 8:0.100000 9:0.033929 10:0.000000 11:0.000000 12:0.002034 13:0.275000 14:0.194069 15:0.033537
0 1:0.000000 2:0.000000 3:0.059856 4:0.133561 5:0.128314 6:0.377338 7:0.761609 8:0.000000 9:0.064029 10:0.000000 11:0.377195 12:0.000000 13:0.000000 14:0.000000 15:0.127030
0 1:0.000000 2:0.000000 3:0.019802 4:0.224952 5:0.227674 6:0.582775 7:1.000000 8:0.000000 9:0.199200 10:0.000000 11:0.000000 12:0.000263 13:0.000000 14:0.000000 15:0.227588
0 1:0.023523 2:0.000000 3:0.048605 4:0.236241 5:0.253660 6:0.585986 7:1.000000 8:0.400000 9:0.253660 10:0.086405 11:0.050000 12:0.000000 13:0.550000 14:0.183884 15:0.253560
0 1:0.001010 2:0.000000 3:0.008101 4:0.192940 5:0.259353 6:0.584675 7:0.985832 8:0.000000 9:0.259372 10:0.000000 11:0.000000 12:0.000553 13:0.000000 14:0.000000 15:0.259165
0 1:0.017330 2:0.019344 3:0.009901 4:0.151321 5:0.129787 6:0.504581 7:0.648080 8:0.100000 9:0.119076 10:0.149573 11:0.108619 12:0.002881 13:0.550000 14:0.406306 15:0.129791
1 1:0.017330 2:0.019344 3:0.009901 4:0.151321 5:0.129787 6:0.504581 7:0.648080 8:0.100000 9:0.119076 10:0.149573 11:0.108619 12:0.002881 13:0.550000 14:0.406306 15:0.129791
0 1:0.004968 2:0.010922 3:0.029253 4:0.168129 5:0.184124 6:0.477756 7:0.755409 8:0.100000 9:0.179824 10:0.131692 11:0.000000 12:0.000000 13:1.000000 14:0.405405 15:0.187660
```

### 8. gbdt 参考资料
<https://statweb.stanford.edu/~jhf/ftp/trebst.pdf>
<http://statweb.stanford.edu/~jhf/ftp/stobst.pdf>
<https://arxiv.org/pdf/1603.02754.pdf>
<http://statweb.stanford.edu/~tibs/ElemStatLearn/printings/ESLII_print10.pdf>

### 9. gbdt 源码实现
[xgboos](https://github.com/dmlc/xgboost/)

[lightgbm](https://github.com/Microsoft/LightGBM)