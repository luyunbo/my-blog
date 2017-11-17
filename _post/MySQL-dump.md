layout: post
date: 2016/05/23
title: MySQL备份与还原
categories: [MySQL]
tags: [MySQL]
---

### MySQL的备份

备份要用到MySQL的mysqldump工具，基本用法是：
```
mysqldump [OPTIONS] database [tables]
```
备份MySQL数据库的命令:
```
mysqldump -hhostname -uusername -ppassword databasename > backupfile.sql
```
备份MySQL数据库为带删除表的格式，能够让该备份覆盖已有数据库而不需要手动删除原有数据库,命令如下：
```
mysqldump -–add-drop-table -uusername -ppassword databasename > backupfile.sql
```

<!--more-->

直接将MySQL数据库压缩备份：
```
mysqldump -hhostname -uusername -ppassword databasename | gzip > backupfile.sql.gz
```
备份MySQL数据库某个(些)表
```
mysqldump -hhostname -uusername -ppassword databasename specific_table1 specific_table2 > backupfile.sql
```
同时备份多个MySQL数据库
```
mysqldump -hhostname -uusername -ppassword –databases databasename1 databasename2 databasename3 > multibackupfile.sql
```
仅仅备份数据库结构
```
mysqldump –no-data –databases databasename1 databasename2 databasename3 > structurebackupfile.sql
```
备份服务器上所有数据库
```
mysqldump –all-databases > allbackupfile.sql
```

### MySQL导入还原
导入MySQL数据库的命令
```
mysql -hhostname -uusername -ppassword databasename < backupfile.sql
mysql -hhostname -ppassword databasename tablename < backuptablefile.sql
```
导入压缩的MySQL数据库
```
gunzip < backupfile.sql.gz | mysql -uusername -ppassword databasename
```
将数据库转移到新服务器
```
mysqldump -uusername -ppassword databasename | mysql –host=*.*.*.* -C databasename
```

### mysqldump的更多参数

`--compatible=name`：它告诉 mysqldump，导出的数据将和哪种数据库或哪个旧版本的 MySQL 服务器相兼容。值可以为 ansi、mysql323、mysql40、postgresql、oracle、mssql、db2、maxdb、no_key_options、no_tables_options、no_field_options 等，要使用几个值，用逗号将它们隔开。当然了，它并不保证能完全兼容，而是尽量兼容。

`--complete-insert，-c`：导出的数据采用包含字段名的完整 INSERT 方式，也就是把所有的值都写在一行。这么做能提高插入效率，但是可能会受到 max_allowed_packet 参数的影响而导致插入失败。
`--default-character-set=charset`：指定导出数据时采用何种字符集，如果数据表不是采用默认的 latin1 字符集的话，那么导出时必须指定该选项，否则再次导入数据后将产生乱码问题。

`--disable-keys`：告诉 mysqldump 在 INSERT 语句的开头和结尾增加 /*!40000 ALTER TABLE table DISABLE KEYS */; 和 /*!40000 ALTER TABLE table ENABLE KEYS */; 语句，这能大大提高插入语句的速度，因为它是在插入完所有数据后才重建索引的。该选项只适合 MyISAM 表。

`--extended-insert = true|false`：默认情况下，mysqldump 开启 `--complete-insert` 模式，因此不想用它的的话，就使用本选项，设定它的值为 false 即可。

`--hex-blob`：使用十六进制格式导出二进制字符串字段。如果有二进制数据就必须使用本选项。影响到的字段类型有 BINARY、VARBINARY、BLOB。

`--lock-all-tables，-x`：在开始导出之前，提交请求锁定所有数据库中的所有表，以保证数据的一致性。这是一个全局读锁，并且自动关闭 `--single-transaction` 和 `--lock-tables` 选项。

`--lock-tables` 它和 `--lock-all-tables` 类似，不过是锁定当前导出的数据表，而不是一下子锁定全部库下的表。本选项只适用于 MyISAM 表，如果是 Innodb 表可以用 --single-transaction 选项。

`--no-create-info，-t`：只导出数据，而不添加 CREATE TABLE 语句。

`--no-data，-d `：不导出任何数据，只导出数据库表结构。
`--opt`: 这只是一个快捷选项，等同于同时添加 `--add-drop-tables --add-locking --create-option --disable-keys --extended-insert --lock-tables --quick`

`--set-charset`：本选项能让 mysqldump 很快的导出数据，并且导出的数据能很快导回。该选项默认开启，但可以用 `--skip-opt` 禁用。注意，如果运行 mysqldump 没有指定 `--quick` 或 `--opt` 选项，则会将整个结果集放在内存中。如果导出大数据库的话可能会出现问题。

`--quick，-q`：该选项在导出大表时很有用，它强制 mysqldump 从服务器查询取得记录直接输出而不是取得所有记录后将它们缓存到内存中。

`--routines，-R`：导出存储过程以及自定义函数。

`--single-transaction`：该选项在导出数据之前提交一个 BEGIN SQL语句，BEGIN 不会阻塞任何应用程序且能保证导出时数据库的一致性状态。它只适用于事务表，例如 InnoDB 和 BDB。本选项和 `--lock-tables`选项是互斥的，因为 LOCK TABLES 会使任何挂起的事务隐含提交。要想导出大表的话，应结合使用 `--quick` 选项。

`--triggers`：同时导出触发器。该选项默认启用，用 `--skip-triggers` 禁用它。

### 参考

[mysqldump — A Database Backup Program](http://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)

[MYSQL基础笔记-导入与导出](http://www.wklken.me/posts/2013/08/11/mysql-base.html#_25)

[mysql备份还原（视图、存储过程）](http://kerry.blog.51cto.com/172631/177570)

