-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: 192.168.2.206    Database: realTimeDB
-- ------------------------------------------------------
-- Server version	5.0.45-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Not dumping tablespaces as no INFORMATION_SCHEMA.FILES table on this server
--

--
-- Table structure for table `9z_sqoop_test`
--

DROP TABLE IF EXISTS `9z_sqoop_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `9z_sqoop_test` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) default NULL,
  `email` varchar(100) default NULL,
  `telephone` varchar(20) default NULL,
  `address` varchar(500) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `9z_sqoop_test`
--

LOCK TABLES `9z_sqoop_test` WRITE;
/*!40000 ALTER TABLE `9z_sqoop_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `9z_sqoop_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `9z_sqoop_test_tem`
--

DROP TABLE IF EXISTS `9z_sqoop_test_tem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `9z_sqoop_test_tem` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(50) default NULL,
  `email` varchar(100) default NULL,
  `telephone` varchar(20) default NULL,
  `address` varchar(500) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `9z_sqoop_test_tem`
--

LOCK TABLES `9z_sqoop_test_tem` WRITE;
/*!40000 ALTER TABLE `9z_sqoop_test_tem` DISABLE KEYS */;
/*!40000 ALTER TABLE `9z_sqoop_test_tem` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `t_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_analytics` (
  `id` int(11) NOT NULL auto_increment,
  `projectId` int(11) NOT NULL,
  `type` varchar(45) default NULL,
  `name` varchar(45) NOT NULL,
  `sql` text,
  `status` varchar(45) default 'init',
  `createUid` varchar(45) NOT NULL default 'enable',
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `containDatasource` varchar(45) default NULL,
  `outputFields` varchar(1145) default NULL,
  `isLanding` varchar(45) default 'n',
  `addLuceneIndex` varchar(45) default 'n',
  `anaMethod` varchar(45) NOT NULL,
  `indexName` varchar(45) default NULL,
  `periodJSON` varchar(245) default NULL,
  `updateTime` datetime default NULL,
  `hbaseTableName` varchar(145) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `indexName_UNIQUE` (`indexName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_analytics`
--

LOCK TABLES `t_analytics` WRITE;
/*!40000 ALTER TABLE `t_analytics` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_analyticsHistory`
--

DROP TABLE IF EXISTS `t_analyticsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_analyticsHistory` (
  `id` int(11) NOT NULL auto_increment,
  `anaId` int(11) NOT NULL,
  `sql` text NOT NULL,
  `createTime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_analyticsHistory`
--

LOCK TABLES `t_analyticsHistory` WRITE;
/*!40000 ALTER TABLE `t_analyticsHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_analyticsHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_analyticsResult`
--

DROP TABLE IF EXISTS `t_analyticsResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_analyticsResult` (
  `id` int(11) NOT NULL,
  `jobId` varchar(64) NOT NULL,
  `anaId` int(11) NOT NULL,
  `sql` text NOT NULL,
  `log` text,
  `resultFmt` text,
  `result` text,
  `submitTime` datetime default NULL,
  `startTime` datetime default NULL,
  `endTime` datetime default NULL,
  `status` varchar(45) NOT NULL,
  `tableName` varchar(45) default NULL,
  `jobType` varchar(45) default NULL,
  `execTime` varchar(45) default NULL,
  PRIMARY KEY  (`id`,`jobId`),
  KEY `jobId` (`jobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_analyticsResult`
--

LOCK TABLES `t_analyticsResult` WRITE;
/*!40000 ALTER TABLE `t_analyticsResult` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_analyticsResult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_chart`
--

DROP TABLE IF EXISTS `t_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_chart` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `connType` varchar(45) default NULL,
  `fields` text,
  `groupFields` varchar(45) default NULL,
  `quota` varchar(45) default NULL,
  `quotaFunc` varchar(45) default NULL,
  `chartType` varchar(45) NOT NULL,
  `dsId` varchar(45) default NULL,
  `createUid` varchar(45) default NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL,
  `sql` text,
  `rangeType` varchar(45) default NULL,
  `startTime` varchar(45) default NULL,
  `stopTime` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_chart`
--

LOCK TABLES `t_chart` WRITE;
/*!40000 ALTER TABLE `t_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_component`
--

DROP TABLE IF EXISTS `t_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_component` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `config` text,
  `version` varchar(45) default NULL,
  `status` varchar(45) default NULL,
  `createtime` varchar(45) default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` varchar(45) default NULL,
  `updateAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_component`
--

LOCK TABLES `t_component` WRITE;
/*!40000 ALTER TABLE `t_component` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_configure`
--

DROP TABLE IF EXISTS `t_configure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_configure` (
  `id` int(11) NOT NULL auto_increment,
  `nodeId` int(11) NOT NULL,
  `type` varchar(125) NOT NULL,
  `fileName` varchar(125) NOT NULL,
  `key` varchar(125) default NULL,
  `value` text,
  `valueDef` text,
  `remark` text,
  `status` varchar(11) default NULL,
  `updateFlag` varchar(11) default NULL,
  `updateCount` int(11) default NULL,
  `updateOk` int(11) default NULL,
  `createUid` varchar(11) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL,
  PRIMARY KEY  (`id`,`nodeId`,`fileName`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_configure`
--

LOCK TABLES `t_configure` WRITE;
/*!40000 ALTER TABLE `t_configure` DISABLE KEYS */;
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','DARWIN_HOME','/home/yimr/yiprods/yimr/DarwinApp','/home/yimr/yiprods/yimr/DarwinApp','DARWIN-4.1.0后台的home目录【固定】','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','SEARCH_XMS','512m','512m','节点服务内存设置SEARCH_XMS为最小内存','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','SEARCH_MAX_MEM','512m','512m','节点服务内存设置SEARCH_MAX_MEM为最大内存','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','HADOOP_CLASSPATH','/opt/cloudera/parcels/CDH/lib/hadoop/lib','/opt/cloudera/parcels/CDH/lib/hadoop/lib','HADOOP_CLASSPATH为hadoop的lib目录','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','SPARK_CLASSPATH','/opt/cloudera/parcels/CDH/lib/spark/lib','/opt/cloudera/parcels/CDH/lib/spark/lib','SPARK_CLASSPATH为spark的lib目录','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','HADOOP_SPARK_CLASSPATH','/opt/cloudera/parcels/CDH/lib/spark/conf:/opt/cloudera/parcels/CDH/lib/spark/lib/spark-assembly.jar:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/client/*:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/./:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/.//*:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-library.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-compiler.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/jline.jar','/opt/cloudera/parcels/CDH/lib/spark/conf:/opt/cloudera/parcels/CDH/lib/spark/lib/spark-assembly.jar:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/client/*:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/./:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/.//*:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-library.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-compiler.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/jline.jar','HADOOP_SPARK_CLASSPATH为hadoop和spark环境运行需要的类库，\r\n【注】该参数存在的话，HADOOP_CLASSPATH和SPARK_CLASSPATH则无效','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','HADOOP_CONF_DIR','/etc/hadoop/conf','/etc/hadoop/conf','hadoop配置文件路径','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','darwin-env.sh','SPARK_EXECUTOR_INSTANCES','10','10','yarn model, set executor instances number','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','1','APP.properties','app.env','prod','prod','环境','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','1','APP.properties','app.preloads','API_BIZ,NODE_BIZ,CT_BIZ,DS_BIZ,HDFS_BIZ,SPARK_BIZ,log4j,jdbc,SLOG_BIZ,MD5_BIZ,CREATE_BIZ,ALERT_BIZ','API_BIZ,NODE_BIZ,CT_BIZ,DS_BIZ,HDFS_BIZ,SPARK_BIZ,log4j,jdbc,SLOG_BIZ,MD5_BIZ,CREATE_BIZ,ALERT_BIZ','预加载的配置文件集合','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','elasticsearch.conf','index.refresh_interval','10','10','# 建索引的刷新时间。刷新后，新增删改的索引数据就能查询到','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.ui.port','4042','4042','spark的任务运行情况的webUI端口','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.executor.memory','#4g','#4g','节点向spark每个work申请的内存资源大小','off',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.cores.max','60','60','节点向spark请求的总core资源大小','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.default.parallelism','10','10','默认分区数量，申请的core多的话该值可以适当调大','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.shuffle.spill','true','true','节点向spark每个work申请的内存资源大小','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.storage.memoryFraction','0.5','0.5','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.shuffle.memoryFraction','0.5','0.5','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.shuffle.consolidateFiles','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.streaming.unpersist','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.io.compression.snappy','32768','32768','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.io.compression.codec','org.apache.spark.io.SnappyCompressionCodec','org.apache.spark.io.SnappyCompressionCodec','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','spark.conf','spark.local.dir','/home/yimr/hadoop-logs/spark-tmp','/home/yimr/hadoop-logs/spark-tmp','spark存储临时数据的本地位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','alert_record_home_dir','/home/yimr/yiprods/yimr/data/alert','/home/yimr/yiprods/yimr/data/alert','告警记录位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.weburl.host','192.168.2.50','192.168.2.50','告警回溯的web端ip','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.weburl.port','8000','8000','告警回溯的web端port','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.text.format','<p>Dear Master,\\\r\n<p>\\tThere is A Alert From [<ALERT_TITLE>]\\\r\n<p>Priority:[<ALERT_PRIORITY>]\\\r\n<p>\\tMonitor Result:\\\r\n<p><MONITOR_RESULT>\\\r\n<p>\\\r\n<p>[Darwin Server Alert]\\\r\n<p>Date:<ALERT_DATETIME>\r\n','<p>Dear Master,\\\r\n<p>\\tThere is A Alert From [<ALERT_TITLE>]\\\r\n<p>Priority:[<ALERT_PRIORITY>]\\\r\n<p>\\tMonitor Result:\\\r\n<p><MONITOR_RESULT>\\\r\n<p>\\\r\n<p>[Darwin Server Alert]\\\r\n<p>Date:<ALERT_DATETIME>\r\n','告警默认格式模板[<xxx>]为系统内置的参数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.title.format','Darwin Alert[%s]','Darwin Alert[%s]','告警邮件标题','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.params.title','<ALERT_TITLE>','<ALERT_TITLE>','系统参数名设置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.params.priority','<ALERT_PRIORITY>','<ALERT_PRIORITY>','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.params.monitor','<MONITOR_RESULT>','<MONITOR_RESULT>','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.params.datetime','<ALERT_DATETIME>','<ALERT_DATETIME>','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','alert_shell_home_dir','/home/yimr/yiprods/yimr/web/realTimeWeb/web','/home/yimr/yiprods/yimr/web/realTimeWeb/web','告警执行脚本的脚本根目录（已过时）','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','alert_shell_env_format_text','#!/bin/bash\\n\\\r\nexport ALERT_TITLE=<ALERT_TITLE>\\n\\\r\nexport ALERT_PRIORITY=<ALERT_PRIORITY>\\n\\\r\nexport MONITOR_RESULT=<MONITOR_RESULT>\\n\\\r\nexport ALERT_DATETIME=<ALERT_DATETIME>\r\n','#!/bin/bash\\n\\\r\nexport ALERT_TITLE=<ALERT_TITLE>\\n\\\r\nexport ALERT_PRIORITY=<ALERT_PRIORITY>\\n\\\r\nexport MONITOR_RESULT=<MONITOR_RESULT>\\n\\\r\nexport ALERT_DATETIME=<ALERT_DATETIME>\r\n','告警执行脚本的脚本默认参数变量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.mail.account','13051568235@163.com','13051568235@163.com','snmp告警服务器设置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.mail.password','stonesun','stonesun','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','yialert.mail.sendserver','smtp.163.com','smtp.163.com','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','api_thread_count','20','20','总线服务API线程池数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','server_port','18011','18011','总线服务监听端口','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','service.sign','apiservice','apiservice','总线服务标识','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','dbname','darwin','darwin','数据库配置名称','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','sshpass_filepath','/home/yimr/yiprods/yimr/Darwin/ssh/sshpass_64','/home/yimr/yiprods/yimr/Darwin/ssh/sshpass_64','ssh无密码传输和执行命令所需程序','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','es_conf_file','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/elasticsearch.conf','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/elasticsearch.conf','elasticsearch调优配置位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','index_map_size','10000','10000','记录索引数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','index_period_unit','month','month','日期索引生成周期单位（已过时）','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','create_request_timeout_minutes','1','1','建索引请求超时时间','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','create_failed_sleep_milli','1000','1000','建索引失败重试前等待毫秒数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','create_failed_max_try','5','5','建索引失败最大重试次数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','hdfs_read_thread_count','5','5','读取hdfs数据建索引的读线程并发数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','create_index_thread_count','10','10','建索引线程的并发数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','local_read_lines','2000','2000','建索引线程加载数据条数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','hdfs_read_lines','2000','2000','建索引线程加载数据条数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','hdfs_batch_size','1024000','1024000','读取hdfs数据的缓存大小','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','api_thread_count','10','10','CT服务API线程池数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','server_port','18012','18012','总线服务监听端口','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','service.sign','yict','yict','总线服务标识','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.report.trytimes','3','3','任务汇报重试次数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.online.dir','/home/yimr/yiprods/yimr/data/yict/online','/home/yimr/yiprods/yimr/data/yict/online','任务数据路径配置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.offline.dir','/home/yimr/yiprods/yimr/data/yict/offline','/home/yimr/yiprods/yimr/data/yict/offline','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','ins.args.dir','/home/yimr/yiprods/yimr/data/yict/args','/home/yimr/yiprods/yimr/data/yict/args','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.slog.dir','/home/yimr/yiprods/yimr/data/yict/slog','/home/yimr/yiprods/yimr/data/yict/slog','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','udc.jar.dir','/home/yimr/yiprods/yimr/data/yict/jar','/home/yimr/yiprods/yimr/data/yict/jar','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','ds.task.dir','/home/yimr/yiprods/yimr/data/ds','/home/yimr/yiprods/yimr/data/ds','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.online.hdfs.dir','/user/yimr/Darwin/data/yict/online','/user/yimr/Darwin/data/yict/online','任务上下线，数据目录同步至hdfs配置 ','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','task.offline.hdfs.dir','/user/yimr/Darwin/data/yict/offline','/user/yimr/Darwin/data/yict/offline','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','alert.online.hdfs.dir','/user/yimr/Darwin/data/alert/online','/user/yimr/Darwin/data/alert/online','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','alert.offline.hdfs.dir','/user/yimr/Darwin/data/alert/offline','/user/yimr/Darwin/data/alert/offline','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','ds.hdfs.dir','/user/yimr/Darwin/data/ds','/user/yimr/Darwin/data/ds','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','alert.online.dir','/home/yimr/yiprods/yimr/data/alert/online','/home/yimr/yiprods/yimr/data/alert/online','告警数据路径配置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','alert.offline.dir','/home/yimr/yiprods/yimr/data/alert/offline','/home/yimr/yiprods/yimr/data/alert/offline','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','crontab.datasource','com.darwin.util.period.crontab.data.FileSource','com.darwin.util.period.crontab.data.FileSource','调度配置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','crontab.refreshFrequency','1','1','调度任务更新周期，单位分钟','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','crontab.file','/home/yimr/yiprods/yimr/data/yict/batch.crontab','/home/yimr/yiprods/yimr/data/yict/batch.crontab','离线调度crontab文件位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','rt.executeMillisecond','5000','5000','实时日志周期，单位毫秒','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','rt.taskfile','/home/yimr/yiprods/yimr/data/yict/rt.task','/home/yimr/yiprods/yimr/data/yict/rt.task','实时调度任务记录文件位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','toHbase.path','/home/yimr/yiprods/yimr/DarwinApp/hbaseTest/','/home/yimr/yiprods/yimr/DarwinApp/hbaseTest/','hbase相关路径','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','prg_exec_home','/home/yimr/yiprods/yimr/data/ds','/home/yimr/yiprods/yimr/data/ds','数据源程序执行临时目录','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CT_BIZ.properties','web_local_file_root','/home/yimr/yiprods/yimr/web/realTimeWeb/web','/home/yimr/yiprods/yimr/web/realTimeWeb/web','web端的本地数据目录（已过时）','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','DS_BIZ.properties','hdfs_prefix','RESULT_DATA','RESULT_DATA','数据写入到hdfs的数据前缀（已过时）','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','DS_BIZ.properties','local_prefix','LOCAL_DATA','LOCAL_DATA','数据写入到hdfs的数据前缀（已过时）','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','DS_BIZ.properties','exec_env','java:/home/yimr/hadoop-installed/jdk/bin/java;python:/home/yimr/hadoop-installed/python/bin/python;php:/home/yimr/lamp/php/bin/php;\\\r\nbash:/bin/bash;binary:./\r\n','java:/home/yimr/hadoop-installed/jdk/bin/java;python:/home/yimr/hadoop-installed/python/bin/python;php:/home/yimr/lamp/php/bin/php;\\\r\nbash:/bin/bash;binary:./\r\n','各种类型程序的执行环境设置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','HDFS_BIZ.properties','hdfs.root','hdfs://ston04:8020','hdfs://yi06:8020,hdfs://yi07:8020','hdfs文件系统设置，HA可用nameservice名称或者多个逗号隔开','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','HDFS_BIZ.properties','hdfs.user.darwin','yimr','yimr','darwin服务的访问hdfs用户设置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','HDFS_BIZ.properties','hdfs.user.super','hdfs','hdfs','hdfs超级用户设置，用于检查hdfs健康状况','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','HDFS_BIZ.properties','hdfs.writer.buffsize','1024000','1024000','hdfs写数据的缓冲区大小','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.mysql.driverClassName','com.mysql.jdbc.Driver','com.mysql.jdbc.Driver','mysql配置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.darwin.url','jdbc:mysql://192.168.2.50:20001/realTimeDB?characterEncoding=utf8','jdbc:mysql://192.168.2.50:20001/realTimeDB?characterEncoding=utf8','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.darwin.username','mmaster_db_user','mmaster_db_user','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.darwin.password','D_%bPwd%05%09','D_%bPwd%05%09','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.checkin.test','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.checkout.test','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.checkout.timeout','10000','10000','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.pool.minsize','1','1','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','jdbc.pool.maxsize','30','30','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.driverClass','org.apache.phoenix.jdbc.PhoenixDriver','org.apache.phoenix.jdbc.PhoenixDriver','phoenix hbase配置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.jdbcUrl','jdbc:phoenix:192.168.2.87:2181','jdbc:phoenix:192.168.2.87:2181','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.user','','','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.password','','','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.minsize','10','10','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.maxsize','20','20','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.maxidletime','3600','3600','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','jdbc.properties','c3p0.phoenix.checkouttimeout','20000','20000','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','MD5_BIZ.properties','ds.md5.dir','/home/yimr/yiprods/yimr/data/yict/md5','/home/yimr/yiprods/yimr/data/yict/md5','数据源文件md5信息记录','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','slog.dir','/home/yimr/yiprods/yimr/data/yict/slog','/home/yimr/yiprods/yimr/data/yict/slog','socket log 消息数据存储位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','slog.realtime.dir','/home/yimr/yiprods/yimr/data/yict/rlog','/home/yimr/yiprods/yimr/data/yict/rlog','实时日志存储位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','slog.report.trytimes','3','3','slog消息发送失败重试次数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SPARK_BIZ.properties','spark.master','yarn-client','spark://yi07:7077','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SPARK_BIZ.properties','spark.conffile','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/spark.conf','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/spark.conf','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SPARK_BIZ.properties','depend_files','/home/yimr/yiprods/yimr/DarwinApp/lib/util/stonesunV2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-beanutils-1.7.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-collections-3.2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-lang-2.3.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-logging-1.1.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/ezmorph-1.0.4.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/json-lib-2.4-jdk15.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/fel/fel.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-util-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-crontab-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-distributed-1.0.0.jar\r\n','/home/yimr/yiprods/yimr/DarwinApp/lib/util/stonesunV2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-beanutils-1.7.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-collections-3.2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-lang-2.3.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-logging-1.1.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/ezmorph-1.0.4.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/json-lib-2.4-jdk15.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/fel/fel.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-util-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-crontab-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-distributed-1.0.0.jar\r\n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SPARK_BIZ.properties','hive_depend_jars','/opt/cloudera/parcels/CDH/jars/hive-contrib-0.13.1-cdh5.3.3.jar,\\\r\n/opt/cloudera/parcels/CDH/jars/hive-exec-0.13.1-cdh5.3.3.jar\r\n','/opt/cloudera/parcels/CDH/jars/hive-contrib-0.13.1-cdh5.3.3.jar,\\\r\n/opt/cloudera/parcels/CDH/jars/hive-exec-0.13.1-cdh5.3.3.jar\r\n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SPARK_BIZ.properties','hdfs.iplist.path','/user/yimr/YiMR/publicdict/ip_area.data','/user/yimr/YiMR/publicdict/ip_area.data','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','cluster.name','elasticsearch_darwin','elasticsearch_darwin','elasticsearch 集群名称【全局唯一】','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','index.number_of_shards','5','5','分片数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','bootstrap.mlockall','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','http.enabled','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','indices.store.throttle.type','merge','merge','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','indices.store.throttle.max_bytes_per_sec','50mb','50mb','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','http.cors.allow-origin','\"*\"','\"*\"','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','http.cors.enabled','true','true','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','http.port','19200','19200','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','indices.cache.filter.size','100mb','100mb','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','index.cache.field.type','soft','soft','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','index.cache.field.max_size','50000','50000','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','index.cache.field.expire','10m','10m','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
--insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','indices.fielddata.cache.size','150mb','150mb','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch','ES_HEAP_SIZE','4g','4g','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.rootLogger','info,common,Console','info,common,Console','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin','info,darwin','info,darwin','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin.crontab','info,crontab','info,crontab','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin.single','info,single','info,single','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin.search','info,search','info,search','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin.alert','info,alert','info,alert','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.logger.com.darwin.apiservice','info,apiservice','info,apiservice','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.additivity.crawl','false','false','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.common','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.common.File','log/log4j.log','log/log4j.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.common.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.common.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.common.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.darwin','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.darwin.File','log/darwin.log','log/darwin.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.darwin.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.darwin.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.darwin.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.crontab','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.crontab.File','log/crontab.log','log/crontab.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.crontab.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.crontab.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.crontab.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.apiservice','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.apiservice.File','log/crontab.log','log/crontab.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.apiservice.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.apiservice.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.apiservice.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.single','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.single.File','log/crontab.log','log/crontab.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.single.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.single.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.single.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.search','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.search.File','log/crontab.log','log/crontab.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.search.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.search.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.search.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.alert','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.alert.File','log/crontab.log','log/crontab.log','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.alert.DatePattern','.yyyyMMddHH','.yyyyMMddHH','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.alert.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.alert.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.Console','org.apache.log4j.ConsoleAppender','org.apache.log4j.ConsoleAppender','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.Console.layout','org.apache.log4j.PatternLayout ','org.apache.log4j.PatternLayout ','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','log4j.properties','log4j.appender.Console.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
/*!40000 ALTER TABLE `t_configure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_configuredef`
--

DROP TABLE IF EXISTS `t_configuredef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_configuredef` (
  `id` int(11) default NULL,
  `flag` int(11) default NULL,
  `folder` varchar(125) default NULL,
  `type` varchar(125) default NULL,
  `fileName` varchar(125) default NULL,
  `description` varchar(255) default NULL,
  `key` varchar(125) default NULL,
  `value` text,
  `valueDef` text,
  `remark` text,
  `status` varchar(11) default NULL,
  `createUid` varchar(11) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `t_configuredef`
--

LOCK TABLES `t_configuredef` WRITE;
/*!40000 ALTER TABLE `t_configuredef` DISABLE KEYS */;
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('1','1','/bin','common','darwin-env.sh','Darwin环境变量','DARWIN_HOME','/home/yimr/yiprods/yimr/DarwinApp','/home/yimr/yiprods/yimr/DarwinApp','DARWIN-4.1.0后台的home目录【固定】','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('2','1','/bin','common','darwin-env.sh','Darwin环境变量','SEARCH_XMS','512m','512m','节点服务内存设置SEARCH_XMS为最小内存','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('3','1','/bin','common','darwin-env.sh','Darwin环境变量','SEARCH_MAX_MEM','512m','512m','节点服务内存设置SEARCH_MAX_MEM为最大内存','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('4','1','/bin','common','darwin-env.sh','Darwin环境变量','HADOOP_CLASSPATH','/opt/cloudera/parcels/CDH/lib/hadoop/lib','/opt/cloudera/parcels/CDH/lib/hadoop/lib','HADOOP_CLASSPATH为hadoop的lib目录','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('5','1','/bin','common','darwin-env.sh','Darwin环境变量','SPARK_CLASSPATH','/opt/cloudera/parcels/CDH/lib/spark/lib','/opt/cloudera/parcels/CDH/lib/spark/lib','SPARK_CLASSPATH为spark的lib目录','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('6','1','/bin','common','darwin-env.sh','Darwin环境变量','HADOOP_SPARK_CLASSPATH','/opt/cloudera/parcels/CDH/lib/spark/conf:/opt/cloudera/parcels/CDH/lib/spark/lib/spark-assembly.jar:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/client/*:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/./:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/.//*:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-library.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-compiler.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/jline.jar','/opt/cloudera/parcels/CDH/lib/spark/conf:/opt/cloudera/parcels/CDH/lib/spark/lib/spark-assembly.jar:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/client/*:/etc/hadoop/conf:/opt/cloudera/parcels/CDH/lib/hadoop/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/./:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-hdfs/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-yarn/.//*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/lib/*:/opt/cloudera/parcels/CDH/lib/hadoop-mapreduce/.//*:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-library.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/scala-compiler.jar:/opt/cloudera/parcels/CDH/lib/spark/lib/jline.jar','HADOOP_SPARK_CLASSPATH为hadoop和spark环境运行需要的类库，\r\n【注】该参数存在的话，HADOOP_CLASSPATH和SPARK_CLASSPATH则无效','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('7','1','/bin','common','darwin-env.sh','Darwin环境变量','HADOOP_CONF_DIR','/etc/hadoop/conf','/etc/hadoop/conf','hadoop配置文件路径','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('7','1','/bin','common','darwin-env.sh','Darwin环境变量','SPARK_EXECUTOR_INSTANCES','10','10','yarn model, set executor instances number','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('8','1','/lib/darwin/config','1','APP.properties','配置文件加载','app.env','prod','prod','环境','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('9','1','/lib/darwin/config','1','APP.properties','配置文件加载','app.preloads','API_BIZ,NODE_BIZ,CT_BIZ,DS_BIZ,HDFS_BIZ,SPARK_BIZ,log4j,jdbc,SLOG_BIZ,MD5_BIZ,CREATE_BIZ,ALERT_BIZ','API_BIZ,NODE_BIZ,CT_BIZ,DS_BIZ,HDFS_BIZ,SPARK_BIZ,log4j,jdbc,SLOG_BIZ,MD5_BIZ,CREATE_BIZ,ALERT_BIZ','预加载的配置文件集合','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('16','1','/lib/darwin/config','yict','elasticsearch.conf','ElasticSearch索引配置','index.refresh_interval','10','10','# 建索引的刷新时间。刷新后，新增删改的索引数据就能查询到','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('17','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.ui.port','4042','4042','spark的任务运行情况的webUI端口','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('18','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.executor.memory','#4g','#4g','节点向spark每个work申请的内存资源大小','off','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('19','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.cores.max','60','60','节点向spark请求的总core资源大小','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('20','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.default.parallelism','10','10','默认分区数量，申请的core多的话该值可以适当调大','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('21','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.shuffle.spill','true','true','节点向spark每个work申请的内存资源大小','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('22','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.storage.memoryFraction','0.5','0.5',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('23','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.shuffle.memoryFraction','0.5','0.5',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('24','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.shuffle.consolidateFiles','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('25','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.streaming.unpersist','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('26','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.io.compression.snappy','32768','32768',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('27','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.io.compression.codec','org.apache.spark.io.SnappyCompressionCodec','org.apache.spark.io.SnappyCompressionCodec',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('28','1','/lib/darwin/config','yict','spark.conf','Spark配置','spark.local.dir','/home/yimr/hadoop-logs/spark-tmp','/home/yimr/hadoop-logs/spark-tmp','spark存储临时数据的本地位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('29','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','alert_record_home_dir','/home/yimr/yiprods/yimr/data/alert','/home/yimr/yiprods/yimr/data/alert','告警记录位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('30','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.weburl.host','192.168.2.50','192.168.2.50','告警回溯的web端ip','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('31','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.weburl.port','8000','8000','告警回溯的web端port','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('32','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.text.format','<p>Dear Master,\\\r\n<p>\\tThere is A Alert From [<ALERT_TITLE>]\\\r\n<p>Priority:[<ALERT_PRIORITY>]\\\r\n<p>\\tMonitor Result:\\\r\n<p><MONITOR_RESULT>\\\r\n<p>\\\r\n<p>[Darwin Server Alert]\\\r\n<p>Date:<ALERT_DATETIME>\r\n','<p>Dear Master,\\\r\n<p>\\tThere is A Alert From [<ALERT_TITLE>]\\\r\n<p>Priority:[<ALERT_PRIORITY>]\\\r\n<p>\\tMonitor Result:\\\r\n<p><MONITOR_RESULT>\\\r\n<p>\\\r\n<p>[Darwin Server Alert]\\\r\n<p>Date:<ALERT_DATETIME>\r\n','告警默认格式模板[<xxx>]为系统内置的参数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('33','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.title.format','Darwin Alert[%s]','Darwin Alert[%s]','告警邮件标题','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('34','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.params.title','<ALERT_TITLE>','<ALERT_TITLE>','系统参数名设置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('35','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.params.priority','<ALERT_PRIORITY>','<ALERT_PRIORITY>',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('36','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.params.monitor','<MONITOR_RESULT>','<MONITOR_RESULT>',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('37','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.params.datetime','<ALERT_DATETIME>','<ALERT_DATETIME>',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('38','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','alert_shell_home_dir','/home/yimr/yiprods/yimr/web/realTimeWeb/web','/home/yimr/yiprods/yimr/web/realTimeWeb/web','告警执行脚本的脚本根目录（已过时）','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('39','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','alert_shell_env_format_text','#!/bin/bash\\n\\\r\nexport ALERT_TITLE=<ALERT_TITLE>\\n\\\r\nexport ALERT_PRIORITY=<ALERT_PRIORITY>\\n\\\r\nexport MONITOR_RESULT=<MONITOR_RESULT>\\n\\\r\nexport ALERT_DATETIME=<ALERT_DATETIME>\r\n','#!/bin/bash\\n\\\r\nexport ALERT_TITLE=<ALERT_TITLE>\\n\\\r\nexport ALERT_PRIORITY=<ALERT_PRIORITY>\\n\\\r\nexport MONITOR_RESULT=<MONITOR_RESULT>\\n\\\r\nexport ALERT_DATETIME=<ALERT_DATETIME>\r\n','告警执行脚本的脚本默认参数变量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('40','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.mail.account','13051568235@163.com','13051568235@163.com','snmp告警服务器设置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('41','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.mail.password','stonesun','stonesun',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('42','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','yialert.mail.sendserver','smtp.163.com','smtp.163.com',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('43','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','api_thread_count','20','20','总线服务API线程池数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('44','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','server_port','18011','18011','总线服务监听端口','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('45','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','service.sign','apiservice','apiservice','总线服务标识','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('46','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','dbname','darwin','darwin','数据库配置名称','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('47','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','sshpass_filepath','/home/yimr/yiprods/yimr/Darwin/ssh/sshpass_64','/home/yimr/yiprods/yimr/Darwin/ssh/sshpass_64','ssh无密码传输和执行命令所需程序','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('49','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','es_conf_file','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/elasticsearch.conf','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/elasticsearch.conf','elasticsearch调优配置位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('50','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','index_map_size','10000','10000','记录索引数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('51','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','index_period_unit','month','month','日期索引生成周期单位（已过时）','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('52','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','create_request_timeout_minutes','1','1','建索引请求超时时间','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('53','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','create_failed_sleep_milli','1000','1000','建索引失败重试前等待毫秒数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('54','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','create_failed_max_try','5','5','建索引失败最大重试次数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('55','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','hdfs_read_thread_count','5','5','读取hdfs数据建索引的读线程并发数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('56','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','create_index_thread_count','10','10','建索引线程的并发数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('57','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','local_read_lines','2000','2000','建索引线程加载数据条数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('58','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','hdfs_read_lines','2000','2000','建索引线程加载数据条数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('59','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','hdfs_batch_size','1024000','1024000','读取hdfs数据的缓存大小','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('60','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','api_thread_count','10','10','CT服务API线程池数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('61','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','server_port','18012','18012','总线服务监听端口','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('62','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','service.sign','yict','yict','总线服务标识','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('63','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.report.trytimes','3','3','任务汇报重试次数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('64','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.online.dir','/home/yimr/yiprods/yimr/data/yict/online','/home/yimr/yiprods/yimr/data/yict/online','任务数据路径配置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('65','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.offline.dir','/home/yimr/yiprods/yimr/data/yict/offline','/home/yimr/yiprods/yimr/data/yict/offline',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('66','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','ins.args.dir','/home/yimr/yiprods/yimr/data/yict/args','/home/yimr/yiprods/yimr/data/yict/args',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('67','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.slog.dir','/home/yimr/yiprods/yimr/data/yict/slog','/home/yimr/yiprods/yimr/data/yict/slog',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('68','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','udc.jar.dir','/home/yimr/yiprods/yimr/data/yict/jar','/home/yimr/yiprods/yimr/data/yict/jar',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('69','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','ds.task.dir','/home/yimr/yiprods/yimr/data/ds','/home/yimr/yiprods/yimr/data/ds',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('70','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.online.hdfs.dir','/user/yimr/Darwin/data/yict/online','/user/yimr/Darwin/data/yict/online','任务上下线，数据目录同步至hdfs配置 ','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('71','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','task.offline.hdfs.dir','/user/yimr/Darwin/data/yict/offline','/user/yimr/Darwin/data/yict/offline',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('72','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','alert.online.hdfs.dir','/user/yimr/Darwin/data/alert/online','/user/yimr/Darwin/data/alert/online',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('73','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','alert.offline.hdfs.dir','/user/yimr/Darwin/data/alert/offline','/user/yimr/Darwin/data/alert/offline',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('74','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','ds.hdfs.dir','/user/yimr/Darwin/data/ds','/user/yimr/Darwin/data/ds',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('75','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','alert.online.dir','/home/yimr/yiprods/yimr/data/alert/online','/home/yimr/yiprods/yimr/data/alert/online','告警数据路径配置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('76','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','alert.offline.dir','/home/yimr/yiprods/yimr/data/alert/offline','/home/yimr/yiprods/yimr/data/alert/offline',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('77','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','crontab.datasource','com.darwin.util.period.crontab.data.FileSource','com.darwin.util.period.crontab.data.FileSource','调度配置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('78','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','crontab.refreshFrequency','1','1','调度任务更新周期，单位分钟','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('79','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','crontab.file','/home/yimr/yiprods/yimr/data/yict/batch.crontab','/home/yimr/yiprods/yimr/data/yict/batch.crontab','离线调度crontab文件位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('80','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','rt.executeMillisecond','5000','5000','实时日志周期，单位毫秒','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('81','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','rt.taskfile','/home/yimr/yiprods/yimr/data/yict/rt.task','/home/yimr/yiprods/yimr/data/yict/rt.task','实时调度任务记录文件位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('82','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','toHbase.path','/home/yimr/yiprods/yimr/DarwinApp/hbaseTest/','/home/yimr/yiprods/yimr/DarwinApp/hbaseTest/','hbase相关路径','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('83','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','prg_exec_home','/home/yimr/yiprods/yimr/data/ds','/home/yimr/yiprods/yimr/data/ds','数据源程序执行临时目录','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('84','1','/lib/darwin/config/prod','yict','CT_BIZ.properties','调度服务配置','web_local_file_root','/home/yimr/yiprods/yimr/web/realTimeWeb/web','/home/yimr/yiprods/yimr/web/realTimeWeb/web','web端的本地数据目录（已过时）','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('85','1','/lib/darwin/config/prod','yict','DS_BIZ.properties','数据源配置','hdfs_prefix','RESULT_DATA','RESULT_DATA','数据写入到hdfs的数据前缀（已过时）','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('86','1','/lib/darwin/config/prod','yict','DS_BIZ.properties','数据源配置','local_prefix','LOCAL_DATA','LOCAL_DATA','数据写入到hdfs的数据前缀（已过时）','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('87','1','/lib/darwin/config/prod','yict','DS_BIZ.properties','数据源配置','exec_env','java:/home/yimr/hadoop-installed/jdk/bin/java;python:/home/yimr/hadoop-installed/python/bin/python;php:/home/yimr/lamp/php/bin/php;\\\r\nbash:/bin/bash;binary:./\r\n','java:/home/yimr/hadoop-installed/jdk/bin/java;python:/home/yimr/hadoop-installed/python/bin/python;php:/home/yimr/lamp/php/bin/php;\\\r\nbash:/bin/bash;binary:./\r\n','各种类型程序的执行环境设置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('88','1','/lib/darwin/config/prod','common','HDFS_BIZ.properties','HDFS配置','hdfs.root','hdfs://yi06:8020,hdfs://yi07:8020','hdfs://yi06:8020,hdfs://yi07:8020','hdfs文件系统设置，HA可用nameservice名称或者多个逗号隔开','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('89','1','/lib/darwin/config/prod','common','HDFS_BIZ.properties','HDFS配置','hdfs.user.darwin','yimr','yimr','darwin服务的访问hdfs用户设置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('90','1','/lib/darwin/config/prod','common','HDFS_BIZ.properties','HDFS配置','hdfs.user.super','hdfs','hdfs','hdfs超级用户设置，用于检查hdfs健康状况','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('91','1','/lib/darwin/config/prod','common','HDFS_BIZ.properties','HDFS配置','hdfs.writer.buffsize','1024000','1024000','hdfs写数据的缓冲区大小','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('92','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.mysql.driverClassName','com.mysql.jdbc.Driver','com.mysql.jdbc.Driver','mysql配置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('93','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.darwin.url','jdbc:mysql://192.168.2.50:20001/realTimeDB?characterEncoding=utf8','jdbc:mysql://192.168.2.50:20001/realTimeDB?characterEncoding=utf8',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('94','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.darwin.username','mmaster_db_user','mmaster_db_user',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('95','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.darwin.password','D_%bPwd%05%09','D_%bPwd%05%09',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('96','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.checkin.test','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('97','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.checkout.test','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('98','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.checkout.timeout','10000','10000',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('99','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.pool.minsize','1','1',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('100','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','jdbc.pool.maxsize','30','30',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('101','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.driverClass','org.apache.phoenix.jdbc.PhoenixDriver','org.apache.phoenix.jdbc.PhoenixDriver','phoenix hbase配置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('102','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.jdbcUrl','jdbc:phoenix:192.168.2.87:2181','jdbc:phoenix:192.168.2.87:2181',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('103','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.user','','',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('104','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.password','','',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('105','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.minsize','10','10',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('106','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.maxsize','20','20',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('107','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.maxidletime','3600','3600',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('108','3','/lib/darwin/config/prod','api','jdbc.properties','数据库连接配置','c3p0.phoenix.checkouttimeout','20000','20000',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('109','1','/lib/darwin/config/prod','common','MD5_BIZ.properties','MD5配置','ds.md5.dir','/home/yimr/yiprods/yimr/data/yict/md5','/home/yimr/yiprods/yimr/data/yict/md5','数据源文件md5信息记录','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('116','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','slog.dir','/home/yimr/yiprods/yimr/data/yict/slog','/home/yimr/yiprods/yimr/data/yict/slog','socket log 消息数据存储位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('117','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','slog.realtime.dir','/home/yimr/yiprods/yimr/data/yict/rlog','/home/yimr/yiprods/yimr/data/yict/rlog','实时日志存储位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('118','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','slog.report.trytimes','3','3','slog消息发送失败重试次数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('119','1','/lib/darwin/config/prod','common','SPARK_BIZ.properties','Spark依赖配置','spark.master','spark://yi07:7077','spark://yi07:7077',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('120','1','/lib/darwin/config/prod','common','SPARK_BIZ.properties','Spark依赖配置','spark.conffile','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/spark.conf','/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/config/spark.conf',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('121','1','/lib/darwin/config/prod','common','SPARK_BIZ.properties','Spark依赖配置','depend_files','/home/yimr/yiprods/yimr/DarwinApp/lib/util/stonesunV2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-beanutils-1.7.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-collections-3.2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-lang-2.3.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-logging-1.1.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/ezmorph-1.0.4.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/json-lib-2.4-jdk15.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/fel/fel.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-util-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-crontab-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-distributed-1.0.0.jar\r\n','/home/yimr/yiprods/yimr/DarwinApp/lib/util/stonesunV2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-beanutils-1.7.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-collections-3.2.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-lang-2.3.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/commons-logging-1.1.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/ezmorph-1.0.4.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/json/json-lib-2.4-jdk15.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/fel/fel.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-util-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-crontab-1.0.0.jar,\\\r\n/home/yimr/yiprods/yimr/DarwinApp/lib/darwin/darwin-distributed-1.0.0.jar\r\n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('122','1','/lib/darwin/config/prod','common','SPARK_BIZ.properties','Spark依赖配置','hive_depend_jars','/opt/cloudera/parcels/CDH/jars/hive-contrib-0.13.1-cdh5.3.3.jar,\\\r\n/opt/cloudera/parcels/CDH/jars/hive-exec-0.13.1-cdh5.3.3.jar\r\n','/opt/cloudera/parcels/CDH/jars/hive-contrib-0.13.1-cdh5.3.3.jar,\\\r\n/opt/cloudera/parcels/CDH/jars/hive-exec-0.13.1-cdh5.3.3.jar\r\n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('123','1','/lib/darwin/config/prod','common','SPARK_BIZ.properties','Spark依赖配置','hdfs.iplist.path','/user/yimr/YiMR/publicdict/ip_area.data','/user/yimr/YiMR/publicdict/ip_area.data',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('124','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','cluster.name','elasticsearch_darwin','elasticsearch_darwin','elasticsearch 集群名称【全局唯一】','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('125','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','index.number_of_shards','5','5','分片数量','on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('126','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','bootstrap.mlockall','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('127','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','http.enabled','true','true',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('128','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','indices.store.throttle.type','merge','merge',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('129','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','indices.store.throttle.max_bytes_per_sec','50mb','50mb',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('130','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','http.cors.allow-origin','\"*\"','\"*\"',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('131','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','http.cors.enabled','true','true',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('132','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','http.port','19200','19200',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('132','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','indices.cache.filter.size','100mb','100mb',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('133','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','index.cache.field.type','soft','soft',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('134','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','index.cache.field.max_size','50000','50000',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('135','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','index.cache.field.expire','10m','10m',NULL,'on','1',NULL,NULL);
--insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('136','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','indices.fielddata.cache.size','150mb','150mb',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('137','2','/bin','elasticsearch','elasticsearch','ElasticSearch内存配置','ES_HEAP_SIZE','4g','4g',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('140','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.rootLogger','info,common,Console','info,common,Console',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('141','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin','info,darwin','info,darwin',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('142','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin.crontab','info,crontab','info,crontab',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('143','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin.single','info,single','info,single',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('144','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin.search','info,search','info,search',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('145','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin.alert','info,alert','info,alert',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('146','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.logger.com.darwin.apiservice','info,apiservice','info,apiservice',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('147','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.additivity.crawl','false','false',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('148','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.common','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('149','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.common.File','log/log4j.log','log/log4j.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('150','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.common.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('151','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.common.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('152','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.common.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('153','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.darwin','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('154','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.darwin.File','log/darwin.log','log/darwin.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('155','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.darwin.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('156','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.darwin.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('157','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.darwin.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('158','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.crontab','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('159','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.crontab.File','log/crontab.log','log/crontab.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('160','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.crontab.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('161','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.crontab.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('162','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.crontab.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('169','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.apiservice','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('170','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.apiservice.File','log/crontab.log','log/crontab.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('171','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.apiservice.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('172','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.apiservice.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('173','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.apiservice.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('174','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.single','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('175','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.single.File','log/crontab.log','log/crontab.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('176','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.single.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('177','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.single.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('178','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.single.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('179','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.search','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('180','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.search.File','log/crontab.log','log/crontab.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('181','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.search.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('182','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.search.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('183','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.search.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('184','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.alert','org.apache.log4j.DailyRollingFileAppender','org.apache.log4j.DailyRollingFileAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('185','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.alert.File','log/crontab.log','log/crontab.log',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('186','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.alert.DatePattern','.yyyyMMddHH','.yyyyMMddHH',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('187','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.alert.layout','org.apache.log4j.PatternLayout','org.apache.log4j.PatternLayout',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('188','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.alert.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('189','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.Console','org.apache.log4j.ConsoleAppender','org.apache.log4j.ConsoleAppender',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('190','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.Console.layout','org.apache.log4j.PatternLayout ','org.apache.log4j.PatternLayout ',NULL,'on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('191','1','/lib/darwin/config/prod','common','log4j.properties','log4j配置','log4j.appender.Console.layout.ConversionPattern','[%d][%p][%t](%F\\:%L)$ %m%n','[%d][%p][%t](%F\\:%L)$ %m%n',NULL,'on','1',NULL,NULL);
/*!40000 ALTER TABLE `t_configuredef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_createIndexOperation`
--

DROP TABLE IF EXISTS `t_createIndexOperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_createIndexOperation` (
  `id` int(11) NOT NULL auto_increment COMMENT '序号',
  `tableName` varchar(200) default NULL COMMENT '表名称',
  `period` varchar(32) default NULL COMMENT '周期',
  `opDetail` text COMMENT '参数信息',
  `submitTime` datetime default NULL COMMENT '提交时间',
  `status` varchar(24) default 'add' COMMENT '状态',
  `runTime` datetime default NULL COMMENT '开始时间',
  `stopTime` datetime default NULL COMMENT '结束时间',
  `errorLog` text COMMENT '错误日志',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_createIndexOperation`
--

LOCK TABLES `t_createIndexOperation` WRITE;
/*!40000 ALTER TABLE `t_createIndexOperation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_createIndexOperation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dashBoard`
--

DROP TABLE IF EXISTS `t_dashBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dashBoard` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `createUid` varchar(45) NOT NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `panelArray` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dashBoard`
--

LOCK TABLES `t_dashBoard` WRITE;
/*!40000 ALTER TABLE `t_dashBoard` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_dashBoard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_datasource`
--

DROP TABLE IF EXISTS `t_datasource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_datasource` (
  `id` int(11) NOT NULL auto_increment,
  `projectId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `tableName` varchar(120) NOT NULL default 'default_dsId',
  `status` varchar(45) NOT NULL default 'add',
  `source` varchar(45) NOT NULL,
  `sourceType` varchar(15) NOT NULL,
  `sourceDetail` text NOT NULL,
  `field_seting` text,
  `dataSavePath` varchar(145) default '5000',
  `interval` varchar(45) default NULL,
  `delimited` varchar(45) default NULL,
  `delimitedColumnNum` varchar(45) default 'y',
  `lgnoreStr` varchar(45) default NULL,
  `strPosition` varchar(45) default NULL,
  `className` varchar(145) default NULL,
  `charset` varchar(45) default 'utf-8',
  `onOff` varchar(45) default 'enable',
  `remark` varchar(545) default NULL,
  `tags` varchar(145) default NULL,
  `createUid` varchar(45) default NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL,
  `ruleConf` text NOT NULL,
  `validDay` int(11) default NULL,
  `addLuceneIndex` varchar(2) default 'n',
  `accelerate` varchar(2) default 'n' COMMENT '是否加速',
  `rate` decimal(20,0) default NULL,
  `rowPerscon` decimal(20,0) default NULL,
  PRIMARY KEY  (`id`,`tableName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_datasource`
--

LOCK TABLES `t_datasource` WRITE;
/*!40000 ALTER TABLE `t_datasource` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_datasource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_dsTemplate`
--

DROP TABLE IF EXISTS `t_dsTemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dsTemplate` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) default NULL,
  `ruleConf` text NOT NULL,
  `createUid` varchar(45) NOT NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_dsTemplate`
--

LOCK TABLES `t_dsTemplate` WRITE;
/*!40000 ALTER TABLE `t_dsTemplate` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_dsTemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_esIndex`
--

DROP TABLE IF EXISTS `t_esIndex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_esIndex` (
  `id` int(45) NOT NULL auto_increment,
  `type` varchar(45) default NULL,
  `indexName` varchar(250) default NULL,
  `charset` varchar(45) default NULL,
  `tableName` varchar(25) default NULL,
  `columnNames` text,
  `createTime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `createUid` varchar(45) default NULL,
  `updateTime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `groupId` varchar(45) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_type` USING BTREE (`indexName`,`tableName`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_esIndex`
--

LOCK TABLES `t_esIndex` WRITE;
/*!40000 ALTER TABLE `t_esIndex` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_esIndex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_favorites`
--

DROP TABLE IF EXISTS `t_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_favorites` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(245) default NULL,
  `title` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_favorites`
--

LOCK TABLES `t_favorites` WRITE;
/*!40000 ALTER TABLE `t_favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_flow`
--

DROP TABLE IF EXISTS `t_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_flow` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `projectId` int(11) default NULL,
  `name` varchar(45) NOT NULL,
  `config` text,
  `status` varchar(45) default NULL,
  `runStatus` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `nodeId` int(11) default '0',
  `periodType` varchar(45) default NULL,
  `cron` varchar(45) default NULL,
  `relyMySelf` varchar(2) default NULL,
  `cronMaxThreads` int(11) default '0',
  `isTemplate` varchar(2) default 'n',
  `createUid` varchar(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_flow`
--

LOCK TABLES `t_flow` WRITE;
/*!40000 ALTER TABLE `t_flow` DISABLE KEYS */;
insert into `t_flow` (`id`, `type`, `projectId`, `name`, `config`, `status`, `runStatus`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `nodeId`, `periodType`, `cron`, `relyMySelf`, `cronMaxThreads`, `isTemplate`, `createUid`) values('1','1','1','模板-导入FTP数据','[{\"comp\":1,\"compName\":\"导入ftp数据\",\"depends\":\"\",\"type\":\"sFTP\",\"x\":110,\"y\":60}]','offline',NULL,'2015-07-28 18:09:47','admin','2015-07-28 18:09:47',NULL,'71','','',NULL,'0','y','1');
insert into `t_flow` (`id`, `type`, `projectId`, `name`, `config`, `status`, `runStatus`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `nodeId`, `periodType`, `cron`, `relyMySelf`, `cronMaxThreads`, `isTemplate`, `createUid`) values('2','1','1','模板-远程文件监控','[{\"comp\":2,\"compName\":\"远程文件监控\",\"depends\":\"\",\"type\":\"sFTPIncrement\",\"x\":129,\"y\":86}]','offline',NULL,'2015-07-28 18:11:20','admin','2015-07-28 18:11:20',NULL,'71','second','',NULL,'0','y','1');
insert into `t_flow` (`id`, `type`, `projectId`, `name`, `config`, `status`, `runStatus`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `nodeId`, `periodType`, `cron`, `relyMySelf`, `cronMaxThreads`, `isTemplate`, `createUid`) values('3','1','1','模板-数据库导入与导出','[{\"comp\":3,\"compName\":\"Sqoop数据交换\",\"depends\":\"\",\"type\":\"sqoopSwap\",\"x\":87,\"y\":49}]','offline',NULL,'2015-07-28 18:12:58','admin','2015-07-30 15:31:15',NULL,'71','','',NULL,'0','y','1');
insert into `t_flow` (`id`, `type`, `projectId`, `name`, `config`, `status`, `runStatus`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `nodeId`, `periodType`, `cron`, `relyMySelf`, `cronMaxThreads`, `isTemplate`, `createUid`) values('4','1','1','模板-清洗HDFS上的数据','[{\"comp\":4,\"compName\":\"清洗HDFS上的数据\",\"depends\":\"\",\"type\":\"dataClean\",\"x\":150,\"y\":43}]','offline',NULL,'2015-07-28 18:34:12','admin','2015-07-30 15:36:07',NULL,'71','','',NULL,'0','y','1');
/*!40000 ALTER TABLE `t_flow` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

DROP TABLE IF EXISTS `t_flowComp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_flowComp` (
  `id` int(11) NOT NULL auto_increment,
  `flowId` int(11) default NULL,
  `code` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `config` text,
  `version` varchar(45) default NULL,
  `status` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `type` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_flowComp`
--

LOCK TABLES `t_flowComp` WRITE;
/*!40000 ALTER TABLE `t_flowComp` DISABLE KEYS */;
insert into `t_flowComp` (`id`, `flowId`, `code`, `name`, `config`, `version`, `status`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `type`) values('1','1','sFTP','导入ftp数据','{\"code\":\"sFTP\",\"config\":{\"retry\":\"3\",\"sleep\":\"10\",\"threads\":\"1\",\"timeout\":\"30\"},\"inputinfo\":{\"charset\":\"UTF-8\",\"rules\":[{\"connId\":\"80\",\"dirRule\":\"/home/yimr/lamp/tomcat/logs/\",\"fileRule\":\"localhost_access_log.@{yyyy-MM-dd}.txt\",\"no\":1}]},\"storeinfo\":{\"path\":\"/user/yimr/ftp\"}}',NULL,NULL,'2015-07-28 18:09:47','admin',NULL,NULL,NULL);
insert into `t_flowComp` (`id`, `flowId`, `code`, `name`, `config`, `version`, `status`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `type`) values('2','2','sFTPIncrement','远程文件监控','{\"code\":\"sFTPIncrement\",\"config\":{\"retry\":\"3\",\"sleep\":\"10\",\"threads\":\"1\",\"timeout\":\"30\"},\"inputinfo\":{\"charset\":\"UTF-8\",\"rules\":[{\"connId\":\"204\",\"dirRule\":\"/home/yimr/lamp/tomcat/logs/\",\"fileRule\":\"localhost_access_log.*\",\"no\":1}]},\"storeinfo\":{\"path\":\"/user/yimr/test\"}}',NULL,NULL,'2015-07-28 18:11:20','admin','2015-07-30 15:26:19',NULL,NULL);
insert into `t_flowComp` (`id`, `flowId`, `code`, `name`, `config`, `version`, `status`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `type`) values('3','3','sqoopSwap','Sqoop数据交换','{\"code\":\"sqoopSwap\",\"config\":{\"dbStatus\":\"full\",\"state\":\"toHdfs\"},\"inputinfo\":{\"datebase\":\"205\",\"tables\":[{\"db_table\":\"test\",\"no\":1,\"split_column\":\"name\"}]},\"storeinfo\":{\"field_split\":\"\\\\t\",\"path\":\"/user/yimr/test\"}}',NULL,NULL,'2015-07-28 18:12:58','admin','2015-07-30 15:31:15',NULL,NULL);
insert into `t_flowComp` (`id`, `flowId`, `code`, `name`, `config`, `version`, `status`, `createtime`, `createAccount`, `updatetime`, `updateAccount`, `type`) values('4','4','dataClean','清洗HDFS上的数据','{\"code\":\"dataClean\",\"compname\":\"清洗HDFS上的数据\",\"config\":{\"filter\":{\"grouprels\":[],\"groups\":[]},\"relation\":{\"joinDetail\":{\"cond\":[],\"relation\":[]},\"type\":\"union\",\"unionDetail\":{}},\"vcol\":[{\"args\":[{\"desc\":\"待转换列\",\"type\":\"field\",\"value\":\"data1.c1\"},{\"desc\":\"粒度\",\"type\":\"string\",\"value\":\"city\"}],\"colName\":\"ipTocity\",\"data\":\"data1\",\"funcName\":\"ip2area\",\"returnType\":\"string\"}]},\"inputinfo\":[{\"colCount\":\"5\",\"colDelimitExpr\":\"\\\\t\",\"colDelimitType\":\"FIELD\",\"colDetail\":[{\"dateFormat\":\"\",\"name\":\"c1\",\"type\":\"string\"},{\"dateFormat\":\"\",\"name\":\"c2\",\"type\":\"string\"},{\"dateFormat\":\"\",\"name\":\"c3\",\"type\":\"string\"},{\"dateFormat\":\"\",\"name\":\"c4\",\"type\":\"string\"},{\"dateFormat\":\"\",\"name\":\"c5\",\"type\":\"string\"}],\"combineRegex\":\"^[.*\",\"dataDir\":\"/user/yimr\",\"dataName\":\"data1\",\"dataRange\":\"period\",\"dataRangeDetail\":{\"dirnameTimeRule\":\"@{yyyyMMdd}\",\"filenameMatch\":\".*\",\"filenameNotMatch\":\"\",\"filenameTimeRule\":\"@{yyyyMMdd}\",\"timeRangeFrom\":\"1\",\"timeRangeTo\":\"1\",\"timeUnit\":\"day\"},\"dataType\":\"text\",\"encoding\":\"UTF-8\",\"multilineCombine\":\"0\"}],\"storeinfo\":[{\"colDelimitExpr\":\"\\t\",\"dataDir\":\"once\",\"dataType\":\"text\",\"outCols\":[],\"outrowfilter\":\"no\",\"outrowfilterType\":\"and\",\"paDataDir\":\"/user/yimr/test\",\"rowfilterDetail\":[]}]}',NULL,NULL,'2015-07-28 18:34:12','admin','2015-07-30 15:36:07',NULL,NULL);
/*!40000 ALTER TABLE `t_flowComp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_flowStatus`
--

DROP TABLE IF EXISTS `t_flowStatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_flowStatus` (
  `flowId` int(12) NOT NULL,
  `flowCompId` int(12) NOT NULL,
  `period` varchar(32) NOT NULL,
  `status` varchar(24) default NULL,
  `progressBar` varchar(45) default NULL,
  `returnCode` int(12) default NULL,
  `submitTime` varchar(15) default NULL,
  `runTime` varchar(15) default NULL,
  `stopTime` varchar(15) default NULL,
  `log` text,
  `createUid` varchar(11) default NULL,
  `historyFlag` int(1) NOT NULL default '0',
  PRIMARY KEY  (`flowId`,`flowCompId`,`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_flowStatus`
--

LOCK TABLES `t_flowStatus` WRITE;
/*!40000 ALTER TABLE `t_flowStatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_flowStatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_gr`
--

DROP TABLE IF EXISTS `t_gr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_gr` (
  `id` int(11) NOT NULL auto_increment,
  `gid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_gr`
--

LOCK TABLES `t_gr` WRITE;
/*!40000 ALTER TABLE `t_gr` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_gr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_group`
--

DROP TABLE IF EXISTS `t_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `roleIds` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `total` int(11) default NULL,
  `unit` varchar(45) default NULL,
  `usagekb` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_group`
--

LOCK TABLES `t_group` WRITE;
/*!40000 ALTER TABLE `t_group` DISABLE KEYS */;
INSERT INTO `t_group` VALUES (1,'test',NULL,'2015-07-27 20:23:23',NULL,NULL,NULL,1,'GB','0');
/*!40000 ALTER TABLE `t_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_hdfsDirCache`
--

DROP TABLE IF EXISTS `t_hdfsDirCache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_hdfsDirCache` (
  `id` int(11) NOT NULL auto_increment,
  `dirName` varchar(45) default NULL,
  `dirSize` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_hdfsDirCache`
--

LOCK TABLES `t_hdfsDirCache` WRITE;
/*!40000 ALTER TABLE `t_hdfsDirCache` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_hdfsDirCache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_hdfsPrivilege`
--

DROP TABLE IF EXISTS `t_hdfsPrivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_hdfsPrivilege` (
  `id` int(45) NOT NULL auto_increment,
  `connType` varchar(45) default NULL,
  `tableName` varchar(250) default NULL,
  `type` varchar(25) default NULL,
  `path` varchar(250) default NULL,
  `createTime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updateTime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `groupId` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_hdfsPrivilege`
--

LOCK TABLES `t_hdfsPrivilege` WRITE;
/*!40000 ALTER TABLE `t_hdfsPrivilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_hdfsPrivilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_keyvalueItem`
--

DROP TABLE IF EXISTS `t_keyvalueItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_keyvalueItem` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(45) NOT NULL,
  `value` varchar(145) NOT NULL,
  `dsId` int(11) default '0',
  `createUid` int(11) default '0',
  `kvMainId` int(11) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_keyvalueItem`
--

LOCK TABLES `t_keyvalueItem` WRITE;
/*!40000 ALTER TABLE `t_keyvalueItem` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_keyvalueItem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_keyvalueMain`
--

DROP TABLE IF EXISTS `t_keyvalueMain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_keyvalueMain` (
  `id` int(11) NOT NULL auto_increment,
  `field` varchar(45) NOT NULL,
  `createUid` int(11) default NULL,
  `dsId` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_keyvalueMain`
--

LOCK TABLES `t_keyvalueMain` WRITE;
/*!40000 ALTER TABLE `t_keyvalueMain` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_keyvalueMain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_menu`
--

DROP TABLE IF EXISTS `t_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) default NULL,
  `url` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `orderNum` int(11) default NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_menu`
--

LOCK TABLES `t_menu` WRITE;
/*!40000 ALTER TABLE `t_menu` DISABLE KEYS */;
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('1','0','no','基础配置','5','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('3','1','no','系统扩展管理','7','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('27','1','no','连接管理','6','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('28','27','/user/connConf?method=index&type=ftp','FTP连接管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('29','27','/user/connConf?method=index&type=database','数据库连接管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('31','3','/script?method=index','数据获取脚本管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('35','3','/udc?method=index','自定义组件管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('36','0','no','数据管理','1','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('37','36','/configure/hdfsManage.jsp','HDFS数据管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('38','36','/analytics?method=index','BigDB服务','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('40','36','/es?method=index','BigSearch服务','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('41','0','no','流程管理','2','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('42','41','/flow?method=index','流程管理','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('44','1','/user/project?method=index','项目管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('46','41','/flowStatus?method=index','流程监控','2','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('47','41','/flow?method=templates','流程模板','4','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('48','0','no','权限管理','7','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('54','48','/sys?method=index','功能权限管理','6','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('57','48','/sys/role?method=index','角色管理','0','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('86','44','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('87','44','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('88','44','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('89','35','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('90','35','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('91','35','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('92','38','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('93','38','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('94','38','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('95','40','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('96','40','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('97','40','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('98','42','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('99','42','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('100','42','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('101','46','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('102','46','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('103','47','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('104','47','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('105','47','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('114','28','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('115','28','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('116','28','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('117','31','select','查看','0','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('118','31','save','编辑','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('120','31','delete','删除','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('121','0','no','系统配置','4','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('122','121','/node?method=index','服务管理','2','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('123','121','/server?method=index','主机管理','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('125','123','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('126','123','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('127','123','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('131','122','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('132','122','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('133','122','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('134','29','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('135','36','/share?method=index','数据分享','4','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('136','48','/org?method=index','用户与组织机构','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('137','0','no','监控管理','3','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('138','137','/user/monitor?method=index','监控项管理','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('139','137','/user/trigger?method=index','监控告警','2','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('140','138','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('141','138','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('142','138','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('143','139','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('144','139','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('145','139','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('146','37','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('147','37','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('148','37','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('149','135','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('150','135','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('151','135','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('152','29','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('153','29','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('154','36','/clearRule?method=index','数据清理','5','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('155','57','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('156','57','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('157','57','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('158','136','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('159','136','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('160','136','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('161','54','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('162','54','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('163','54','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('164','154','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('165','154','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('166','154','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('167','0','no','检索仪表盘','6','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('168','167','/search/dashboard.jsp','检索仪表盘','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('169','168','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('170','168','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('171','168','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('172','0','no','报表','6','module');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('174','172','/dashBoard?method=report','报表列表','1','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('175','174','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('176','174','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('177','174','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('178','1','/user/keyvalue?method=index','字典管理','10','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('181','36','/dataCategory?method=index','数据分类','7','page');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('186','181','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('187','181','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('188','181','delete','删除','3','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('189','178','select','查看','1','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('190','178','save','编辑','2','button');
insert into `t_menu` (`id`, `pid`, `url`, `name`, `orderNum`, `type`) values('191','178','delete','删除','3','button');
/*!40000 ALTER TABLE `t_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_monitor`
--

DROP TABLE IF EXISTS `t_monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_monitor` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(145) NOT NULL,
  `type` varchar(45) default NULL,
  `cond` text NOT NULL,
  `rangeType` varchar(32) default 'none' COMMENT '时间范围类型',
  `startTime` varchar(32) default NULL COMMENT '开始时间',
  `stopTime` varchar(32) default NULL COMMENT '结束时间',
  `datetimeField` varchar(45) default NULL,
  `target` varchar(45) default NULL,
  `createUid` varchar(45) NOT NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `maxMin` varchar(45) default NULL,
  `groupFields` varchar(245) default NULL,
  `quota` varchar(45) default NULL,
  `quotaFunc` varchar(45) default NULL,
  `time` varchar(45) default NULL,
  `index` varchar(145) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_monitor`
--

LOCK TABLES `t_monitor` WRITE;
/*!40000 ALTER TABLE `t_monitor` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_node`
--

DROP TABLE IF EXISTS `t_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_node` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `port` int(11) default NULL,
  `key` varchar(45) default NULL,
  `status` varchar(45) default NULL,
  `flowNum` int(11) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `serverID` int(11) default NULL,
  `startStopStatus` varchar(45) default NULL,
  `successTotal` int(11) default '0',
  `faildTotal` int(11) default '0',
  `sshPort` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_node`
--

--
-- Table structure for table `t_opLog`
--

DROP TABLE IF EXISTS `t_opLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_opLog` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `opType` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `createTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_opLog`
--

LOCK TABLES `t_opLog` WRITE;
/*!40000 ALTER TABLE `t_opLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_opLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_or`
--

DROP TABLE IF EXISTS `t_or`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_or` (
  `id` int(11) NOT NULL auto_increment,
  `oid` int(11) default NULL,
  `rid` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_or`
--

LOCK TABLES `t_or` WRITE;
/*!40000 ALTER TABLE `t_or` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_or` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_org`
--

DROP TABLE IF EXISTS `t_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_org` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `pid` int(11) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_org`
--

LOCK TABLES `t_org` WRITE;
/*!40000 ALTER TABLE `t_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_panel`
--

DROP TABLE IF EXISTS `t_panel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_panel` (
  `id` int(11) NOT NULL auto_increment,
  `dashBoardId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `style` text,
  `chartId` int(11) default NULL,
  `html` text,
  `createUid` varchar(45) default NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_panel`
--

LOCK TABLES `t_panel` WRITE;
/*!40000 ALTER TABLE `t_panel` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_panel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_privilege`
--

DROP TABLE IF EXISTS `t_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_privilege` (
  `id` int(11) NOT NULL auto_increment,
  `rid` int(11) default NULL,
  `mid` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21540 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_privilege`
--

LOCK TABLES `t_privilege` WRITE;
/*!40000 ALTER TABLE `t_privilege` DISABLE KEYS */;
insert into `t_privilege` (`id`, `rid`, `mid`) values('23314','1','36');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23315','1','37');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23316','1','146');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23317','1','147');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23318','1','148');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23319','1','38');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23320','1','92');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23321','1','93');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23322','1','94');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23323','1','40');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23324','1','95');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23325','1','96');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23326','1','97');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23327','1','135');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23328','1','149');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23329','1','150');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23330','1','151');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23331','1','154');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23332','1','164');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23333','1','165');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23334','1','166');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23335','1','181');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23336','1','186');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23337','1','187');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23338','1','188');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23339','1','41');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23340','1','42');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23341','1','98');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23342','1','99');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23343','1','100');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23344','1','46');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23345','1','101');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23346','1','102');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23347','1','47');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23348','1','103');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23349','1','104');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23350','1','105');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23351','1','137');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23352','1','138');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23353','1','140');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23354','1','141');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23355','1','142');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23356','1','139');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23357','1','143');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23358','1','144');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23359','1','145');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23360','1','121');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23361','1','123');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23362','1','125');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23363','1','126');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23364','1','127');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23365','1','122');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23366','1','131');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23367','1','132');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23368','1','133');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23369','1','1');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23370','1','44');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23371','1','88');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23372','1','86');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23373','1','87');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23374','1','27');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23375','1','28');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23376','1','114');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23377','1','115');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23378','1','116');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23379','1','29');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23380','1','134');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23381','1','152');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23382','1','153');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23383','1','3');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23384','1','31');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23385','1','117');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23386','1','118');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23387','1','120');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23388','1','35');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23389','1','90');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23390','1','89');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23391','1','91');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23392','1','178');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23393','1','189');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23394','1','190');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23395','1','191');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23396','1','167');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23397','1','168');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23398','1','169');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23399','1','170');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23400','1','171');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23401','1','172');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23402','1','174');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23403','1','175');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23404','1','176');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23405','1','177');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23406','1','48');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23407','1','54');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23408','1','57');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23409','1','136');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23410','1','155');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23411','1','156');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23412','1','157');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23413','1','158');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23414','1','159');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23415','1','160');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23416','1','161');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23417','1','162');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23418','1','163');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23502','2','36');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23503','2','37');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23504','2','146');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23505','2','147');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23506','2','148');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23507','2','38');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23508','2','92');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23509','2','93');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23510','2','94');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23511','2','40');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23512','2','95');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23513','2','96');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23514','2','97');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23515','2','135');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23516','2','149');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23517','2','150');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23518','2','151');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23519','2','154');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23520','2','164');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23521','2','165');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23522','2','166');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23523','2','181');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23524','2','186');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23525','2','187');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23526','2','188');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23527','2','41');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23528','2','42');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23529','2','98');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23530','2','99');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23531','2','100');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23532','2','46');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23533','2','101');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23534','2','102');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23535','2','47');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23536','2','103');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23537','2','104');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23538','2','105');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23539','2','137');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23540','2','138');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23541','2','140');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23542','2','141');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23543','2','142');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23544','2','139');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23545','2','143');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23546','2','144');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23547','2','145');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23548','2','1');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23549','2','44');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23550','2','88');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23551','2','86');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23552','2','87');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23553','2','27');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23554','2','28');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23555','2','114');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23556','2','115');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23557','2','116');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23558','2','29');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23559','2','134');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23560','2','152');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23561','2','153');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23562','2','3');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23563','2','31');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23564','2','117');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23565','2','118');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23566','2','120');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23567','2','35');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23568','2','90');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23569','2','89');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23570','2','91');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23571','2','178');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23572','2','189');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23573','2','190');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23574','2','191');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23575','2','167');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23576','2','168');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23577','2','169');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23578','2','170');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23579','2','171');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23580','2','172');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23581','2','174');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23582','2','175');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23583','2','176');
insert into `t_privilege` (`id`, `rid`, `mid`) values('23584','2','177');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21486','3','36');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21487','3','37');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21488','3','146');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21489','3','38');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21490','3','92');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21491','3','40');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21492','3','95');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21493','3','135');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21494','3','149');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21495','3','154');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21496','3','164');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21497','3','41');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21498','3','42');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21499','3','98');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21500','3','46');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21501','3','101');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21502','3','47');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21503','3','103');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21504','3','137');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21505','3','138');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21506','3','140');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21507','3','139');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21508','3','143');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21509','3','121');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21510','3','123');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21511','3','125');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21512','3','122');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21513','3','131');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21514','3','1');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21515','3','44');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21516','3','88');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21517','3','27');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21518','3','28');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21519','3','114');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21520','3','29');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21521','3','134');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21522','3','3');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21523','3','31');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21524','3','117');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21525','3','35');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21526','3','90');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21527','3','167');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21528','3','168');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21529','3','169');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21530','3','172');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21531','3','174');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21532','3','175');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21533','3','48');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21534','3','57');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21535','3','155');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21536','3','136');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21537','3','158');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21538','3','54');
insert into `t_privilege` (`id`, `rid`, `mid`) values('21539','3','161');
/*!40000 ALTER TABLE `t_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_project`
--

DROP TABLE IF EXISTS `t_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_project` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `createUid` varchar(45) default NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_project`
--

LOCK TABLES `t_project` WRITE;
/*!40000 ALTER TABLE `t_project` DISABLE KEYS */;
INSERT INTO `t_project` VALUES (1,'默认项目组','1','admin','2015-07-27 19:38:10',NULL);
/*!40000 ALTER TABLE `t_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `desc` varchar(45) default NULL,
  `dbPrivilege` varchar(45) default NULL,
  `status` varchar(45) default 'y',
  `orgId` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
--INSERT INTO `t_role` VALUES (1,'超级管理员',NULL,NULL,'y',''),(2,'普通用户',NULL,NULL,'y','3');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_run_info`
--

DROP TABLE IF EXISTS `t_run_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_run_info` (
  `task_id` int(11) NOT NULL COMMENT '任务id',
  `period` varchar(16) NOT NULL COMMENT '任务运行周期',
  `status` varchar(12) default NULL COMMENT '任务状态',
  `starttime` datetime default NULL COMMENT '开始时间',
  `stoptime` datetime default NULL COMMENT '结束时间',
  `outputPathPos` varchar(250) default NULL COMMENT '输出路径和对应的文件字节范围',
  `logInfo` text COMMENT '部分-日志信息',
  PRIMARY KEY  (`task_id`,`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_run_info`
--

LOCK TABLES `t_run_info` WRITE;
/*!40000 ALTER TABLE `t_run_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_run_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_script`
--

DROP TABLE IF EXISTS `t_script`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_script` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `remark` varchar(45) default NULL,
  `version` varchar(45) default NULL,
  `filePath` varchar(100) default NULL,
  `mainFile` varchar(45) default NULL,
  `scriptClassName` varchar(45) default NULL,
  `params` text,
  `status` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `createUid` varchar(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_script`
--

LOCK TABLES `t_script` WRITE;
/*!40000 ALTER TABLE `t_script` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_script` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_server`
--

DROP TABLE IF EXISTS `t_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_server` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(45) NOT NULL,
  `host` varchar(45) NOT NULL,
  `rootPwd` varchar(45) default NULL,
  `sshdPort` varchar(45) default NULL,
  `status` varchar(45) default NULL,
  `communicatePort` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_server`
--

--
-- Table structure for table `t_stage`
--

DROP TABLE IF EXISTS `t_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_stage` (
  `id` int(11) NOT NULL auto_increment,
  `analytics_id` int(11) NOT NULL,
  `window_id` int(11) NOT NULL default '0',
  `name` varchar(145) NOT NULL,
  `p_stageid` int(11) NOT NULL default '0',
  `sql` varchar(1024) default NULL,
  `field_seting` varchar(1024) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_stage`
--

LOCK TABLES `t_stage` WRITE;
/*!40000 ALTER TABLE `t_stage` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_task`
--

DROP TABLE IF EXISTS `t_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_task` (
  `id` int(11) NOT NULL auto_increment,
  `pid` varchar(45) default '0',
  `dependsList` varchar(1024) default '',
  `dsId` varchar(45) NOT NULL,
  `groupId` int(11) default NULL,
  `triggerId` int(11) default NULL,
  `name` varchar(145) NOT NULL,
  `type` varchar(45) NOT NULL,
  `scheduled` varchar(45) default NULL,
  `periodType` varchar(45) default '' COMMENT '周期类型,minute,hour等等',
  `cron` varchar(45) default NULL,
  `priority` varchar(45) default NULL,
  `onLine` varchar(45) default NULL,
  `status` varchar(45) NOT NULL,
  `createUid` int(11) NOT NULL,
  `createUsername` varchar(45) NOT NULL,
  `createTime` datetime default NULL,
  `remark` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_task`
--

LOCK TABLES `t_task` WRITE;
/*!40000 ALTER TABLE `t_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_taskGroup`
--

DROP TABLE IF EXISTS `t_taskGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_taskGroup` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(145) NOT NULL,
  `createUid` int(11) default NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_taskGroup`
--

LOCK TABLES `t_taskGroup` WRITE;
/*!40000 ALTER TABLE `t_taskGroup` DISABLE KEYS */;
INSERT INTO `t_taskGroup` VALUES (1,'默认任务组',1,'admin','2015-07-27 19:38:10');
/*!40000 ALTER TABLE `t_taskGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_task_test`
--

DROP TABLE IF EXISTS `t_task_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_task_test` (
  `id` int(11) NOT NULL auto_increment,
  `pid` varchar(45) default '0',
  `dependsList` varchar(1024) default '',
  `dsId` varchar(45) NOT NULL,
  `groupId` int(11) default NULL,
  `triggerId` int(11) default NULL,
  `name` varchar(145) NOT NULL,
  `type` varchar(45) NOT NULL,
  `scheduled` varchar(45) default NULL,
  `periodType` varchar(45) default '' COMMENT '周期类型,minute,hour等等',
  `cron` varchar(45) default NULL,
  `priority` varchar(45) default NULL,
  `onLine` varchar(45) default NULL,
  `status` varchar(45) NOT NULL,
  `createUid` int(11) NOT NULL,
  `createUsername` varchar(45) NOT NULL,
  `createTime` datetime default NULL,
  `remark` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_task_test`
--

LOCK TABLES `t_task_test` WRITE;
/*!40000 ALTER TABLE `t_task_test` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_task_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_transferPrivilege`
--

DROP TABLE IF EXISTS `t_transferPrivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_transferPrivilege` (
  `id` int(11) NOT NULL auto_increment,
  `srcUid` int(11) default NULL,
  `targetUid` int(11) default NULL,
  `type` varchar(45) default NULL,
  `opPrivilege` varchar(45) default NULL,
  `resourceID` int(11) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_transferPrivilege`
--

LOCK TABLES `t_transferPrivilege` WRITE;
/*!40000 ALTER TABLE `t_transferPrivilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_transferPrivilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_transferprivilege`
--

DROP TABLE IF EXISTS `t_transferprivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_transferprivilege` (
  `id` int(11) NOT NULL auto_increment,
  `srcUid` int(11) default NULL,
  `targetUid` int(11) default NULL,
  `type` varchar(45) default NULL,
  `opPrivilege` varchar(45) default NULL,
  `resourceID` int(11) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_transferprivilege`
--

LOCK TABLES `t_transferprivilege` WRITE;
/*!40000 ALTER TABLE `t_transferprivilege` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_transferprivilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_trigger`
--

DROP TABLE IF EXISTS `t_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_trigger` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(145) NOT NULL,
  `level` varchar(20) default NULL,
  `status` varchar(45) default 'enable',
  `strategy` text NOT NULL,
  `notice` text NOT NULL,
  `limitType` varchar(12) default 'hour' COMMENT '发送限制单位',
  `maxTimes` int(11) default '10' COMMENT '限制单位内的最大发送次数',
  `periodTimes` int(12) default '0' COMMENT '限制单位内，告警总发送次数',
  `lastPeriod` varchar(20) default NULL COMMENT '上次告警时间',
  `createUid` varchar(45) NOT NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `shellFile` varchar(1024) default NULL,
  `noticeTemplate` varchar(1024) default NULL,
  `cron` varchar(45) default NULL,
  `priority` varchar(45) default NULL,
  `periodType` varchar(45) default NULL,
  `nodeId` int(11) default '0' COMMENT '保存节点信息',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_trigger`
--

LOCK TABLES `t_trigger` WRITE;
/*!40000 ALTER TABLE `t_trigger` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_triggerHistory`
--

DROP TABLE IF EXISTS `t_triggerHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_triggerHistory` (
  `triggerId` int(11) NOT NULL,
  `triggerDateTime` datetime NOT NULL,
  `context` text NOT NULL,
  `type` varchar(45) NOT NULL,
  `errorLog` text,
  PRIMARY KEY  (`triggerId`,`triggerDateTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_triggerHistory`
--

LOCK TABLES `t_triggerHistory` WRITE;
/*!40000 ALTER TABLE `t_triggerHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_triggerHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_triggerItemHistory`
--

DROP TABLE IF EXISTS `t_triggerItemHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_triggerItemHistory` (
  `id` int(11) NOT NULL auto_increment,
  `triggerId` varchar(45) default NULL,
  `triggerDateTime` datetime default NULL,
  `monitorId` int(11) default NULL,
  `type` varchar(45) default NULL,
  `lastCond` text,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_triggerItemHistory`
--

LOCK TABLES `t_triggerItemHistory` WRITE;
/*!40000 ALTER TABLE `t_triggerItemHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_triggerItemHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_udc`
--

DROP TABLE IF EXISTS `t_udc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udc` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `remark` varchar(45) default NULL,
  `version` varchar(45) default NULL,
  `filePath` varchar(100) default NULL,
  `mainFile` varchar(45) default NULL,
  `udcClassName` varchar(45) default NULL,
  `params` text,
  `status` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `createUid` varchar(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_udc`
--

LOCK TABLES `t_udc` WRITE;
/*!40000 ALTER TABLE `t_udc` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_udc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_udcHistory`
--

DROP TABLE IF EXISTS `t_udcHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_udcHistory` (
  `id` int(11) NOT NULL,
  `type` varchar(45) default '',
  `name` varchar(45) default '',
  `remark` varchar(45) default NULL,
  `version` varchar(45) NOT NULL,
  `filePath` varchar(100) default NULL,
  `mainFile` varchar(45) default NULL,
  `udcClassName` varchar(45) default NULL,
  `params` text,
  `status` varchar(45) default NULL,
  `createtime` datetime default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  PRIMARY KEY  (`id`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_udcHistory`
--

LOCK TABLES `t_udcHistory` WRITE;
/*!40000 ALTER TABLE `t_udcHistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_udcHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_ug`
--

DROP TABLE IF EXISTS `t_ug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_ug` (
  `id` int(11) NOT NULL auto_increment,
  `uid` int(11) default NULL,
  `gid` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_ug`
--

LOCK TABLES `t_ug` WRITE;
/*!40000 ALTER TABLE `t_ug` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_ug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) default NULL,
  `roleId` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `nickname` varchar(45) default NULL,
  `groupId` int(11) default NULL,
  `createAccount` varchar(45) default NULL,
  `updatetime` datetime default NULL,
  `updateAccount` varchar(45) default NULL,
  `groupIds` varchar(45) default NULL,
  `loginCount` int(11) default NULL,
  `loginIp` varchar(45) default NULL,
  `loginArea` varchar(45) default NULL,
  `loginTime` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'admin','21232f297a57a5a743894a0e4a801fc3','admin@qq.com','1','2015-02-26 00:00:00','admin',1,NULL,NULL,NULL,'1,',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_userLoginHistory`
--

DROP TABLE IF EXISTS `t_userLoginHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_userLoginHistory` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(45) default NULL,
  `loginTime` datetime default NULL,
  `loginIp` varchar(45) default NULL,
  `loginArea` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_userLoginHistory`
--

--
-- Table structure for table `t_warehouseOperation`
--

DROP TABLE IF EXISTS `t_warehouseOperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_warehouseOperation` (
  `id` int(11) NOT NULL auto_increment,
  `tableName` varchar(120) default NULL COMMENT '操作表名',
  `opType` varchar(20) default NULL COMMENT '操作类型/周期',
  `opDetail` text COMMENT '操作参数',
  `submitTime` datetime default NULL COMMENT '提交时间',
  `status` varchar(20) default 'add' COMMENT '执行状态',
  `runTime` datetime default NULL COMMENT '执行开始时间',
  `stopTime` datetime default NULL COMMENT '执行结束时间',
  `sqlText` text COMMENT '执行的sql内容',
  `errorLog` text COMMENT '执行日志',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_warehouseOperation`
--

LOCK TABLES `t_warehouseOperation` WRITE;
/*!40000 ALTER TABLE `t_warehouseOperation` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_warehouseOperation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_webLog`
--

DROP TABLE IF EXISTS `t_webLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_webLog` (
  `id` int(11) NOT NULL auto_increment,
  `ip` varchar(45) NOT NULL,
  `userId` varchar(45) NOT NULL,
  `account` varchar(45) NOT NULL,
  `content` text,
  `type` varchar(45) NOT NULL,
  `createTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_webLog`
--

LOCK TABLES `t_webLog` WRITE;
/*!40000 ALTER TABLE `t_webLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_webLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_window`
--

DROP TABLE IF EXISTS `t_window`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_window` (
  `id` int(11) NOT NULL auto_increment,
  `analyticsID` varchar(45) NOT NULL,
  `dsid` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `windowLength` varchar(45) default '5000',
  `windowInterval` varchar(45) default '5000',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_window`
--

LOCK TABLES `t_window` WRITE;
/*!40000 ALTER TABLE `t_window` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_window` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_connConf`
--

DROP TABLE IF EXISTS `t_connConf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_connConf` (
  `id` int(11) NOT NULL auto_increment,
  `type` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `conf` varchar(1024) NOT NULL,
  `createUid` varchar(45) NOT NULL,
  `createUsername` varchar(45) default NULL,
  `createTime` datetime default NULL,
  `updateTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_connConf`
--

LOCK TABLES `t_connConf` WRITE;
/*!40000 ALTER TABLE `t_connConf` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_connConf` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-28 11:23:44


DROP TABLE IF EXISTS `t_version`;
CREATE TABLE `t_version` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `version` VARCHAR(45) NULL,
  PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `t_version` (`id`, `version`) VALUES ('1', '5.0.3');


ALTER TABLE `t_flow` 
ADD COLUMN `shared` CHAR(2) NULL DEFAULT 'n' AFTER `createUid`;

UPDATE `t_flow` SET `shared`='y' WHERE `id`='1';
UPDATE `t_flow` SET `shared`='y' WHERE `id`='2';
UPDATE `t_flow` SET `shared`='y' WHERE `id`='3';
UPDATE `t_flow` SET `shared`='y' WHERE `id`='4';

--
ALTER TABLE `t_flowComp` 
ADD COLUMN `activated` VARCHAR(5) NULL DEFAULT 'true' AFTER `type`;

ALTER TABLE `t_node` 
ADD COLUMN `cpuResources` INT(11) NULL DEFAULT 1 AFTER `sshPort`,
ADD COLUMN `memoryResources` VARCHAR(45) NULL AFTER `cpuResources`;

ALTER TABLE `t_udc` 
CHANGE COLUMN `udcClassName` `udcClassName` VARCHAR(1024) NULL DEFAULT NULL ;

ALTER TABLE `t_flowStatus`   
ADD COLUMN `runNode` INT(11) NULL AFTER `historyFlag`;

CREATE TABLE `t_share` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createUid` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `resources` VARCHAR(245) NOT NULL,
  `createtime` DATETIME NULL ,
  PRIMARY KEY (`id`));
  
ALTER TABLE `t_share` 
ADD COLUMN `shareType` VARCHAR(45) NOT NULL AFTER `createtime`,
ADD COLUMN `shareUsers` TEXT NULL AFTER `shareType`;

ALTER TABLE `t_share` 
ADD COLUMN `status` VARCHAR(5) NULL DEFAULT 'y' AFTER `shareUsers`;

ALTER TABLE `t_user` 
ADD COLUMN `orgId` VARCHAR(45) NULL AFTER `loginTime`;

ALTER TABLE `t_user`   
  ADD COLUMN `totalSpace` VARCHAR(45) NULL AFTER `orgId`;
  
UPDATE `t_user` SET `orgId`='1' WHERE `id`='1';

ALTER TABLE `t_role`   
  ADD COLUMN `createTime` DATETIME NULL AFTER `orgId`,
  ADD COLUMN `createUid` INT(11) NULL AFTER `createTime`;

ALTER TABLE `t_org`   
  ADD COLUMN `fullName` VARCHAR(1024) NULL AFTER `name`;
  
ALTER TABLE `t_share` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL ,
ADD COLUMN `orgId` INT(11) NULL AFTER `status`;

ALTER TABLE `t_share` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;

 LOCK TABLES `t_org` WRITE;
/*!40000 ALTER TABLE `t_org` DISABLE KEYS */;
insert into `t_org` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('1','中国联通','中国联通','0','2015-08-28 13:11:06','admin',NULL,NULL);
insert into `t_org` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('2','北京分公司','中国联通/北京分公司','1','2015-08-28 13:11:55','admin',NULL,NULL);
insert into `t_org` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('3','上海分公司','中国联通/上海分公司','1','2015-08-28 13:11:55','admin',NULL,NULL);
insert into `t_org` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('4','福建分公司','中国联通/福建分公司','1','2015-08-28 13:12:42','admin',NULL,NULL);
/*!40000 ALTER TABLE `t_org` ENABLE KEYS */;
UNLOCK TABLES;

--ALTER TABLE `t_org` 
--ADD COLUMN `code` VARCHAR(45) NOT NULL AFTER `id`;

--
ALTER TABLE `t_flow` AUTO_INCREMENT = 5 ;
ALTER TABLE `t_server` AUTO_INCREMENT = 1 ;
ALTER TABLE `t_node` AUTO_INCREMENT = 1 ;
ALTER TABLE `t_user` AUTO_INCREMENT = 2 ;
ALTER TABLE `t_group` AUTO_INCREMENT = 2 ;
ALTER TABLE `t_trigger` AUTO_INCREMENT = 1 ;
ALTER TABLE `t_monitor` AUTO_INCREMENT = 1 ;

-----------------v5.0.8----------------------------
CREATE TABLE `t_clearRule` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `days` INT NULL,
  `createUid` INT NULL,
  `createtime` DATETIME NULL,
  `status` VARCHAR(2) NULL DEFAULT 'y',
  PRIMARY KEY (`id`));
  
ALTER TABLE `t_clearRule` 
ADD COLUMN `dir` VARCHAR(1024) NULL AFTER `status`;

CREATE TABLE `t_sourceType` (
  `id` INT NOT NULL,
  `sourceType` TEXT NOT NULL,
  `createUid` INT NULL,
  `createtime` DATETIME NULL,
  PRIMARY KEY (`id`));

ALTER TABLE `t_sourceType` 
CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `t_sourceType` 
ADD COLUMN `name` VARCHAR(45) NOT NULL AFTER `id`;

ALTER TABLE `t_share` 
ADD COLUMN `esType` VARCHAR(100) NULL AFTER `orgId`;

LOCK TABLES `t_configure` WRITE;
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','clean_time','01:00:00','01:00:00','数据清理的时间','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','api','API_BIZ.properties','darwin_home_path','/home/yimr/yiprods/yimr/DarwinApp','/home/yimr/yiprods/yimr/DarwinApp','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','zookeeper.connect','192.168.2.91:2182','192.168.2.91:2182','zookeeper地址','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','zookeeper.sync.time.ms','200','200','zookeeper同步时间','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','zookeeper.session.timeout.ms','40000','40000','zookeeper的session超时时间','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','group.id','default-group','default-group','消费者group id前缀','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','auto.commit.interval.ms','1000','1000','offset提交时间间隔','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','auto.offset.reset','smallest','smallest','offset重置位置','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_BIZ.properties','serializer.class','kafka.serializer.StringEncoder','kafka.serializer.StringEncoder','消息序列化类','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_PRO_BIZ.properties','metadata.broker.list','192.168.2.91:9093,192.168.2.91:9094','192.168.2.91:9093,192.168.2.91:9094','kafka地址列表','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_PRO_BIZ.properties','request.required.acks','1','1','消息是否需要确认','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','KAFKA_PRO_BIZ.properties','serializer.class','kafka.serializer.StringEncoder','kafka.serializer.StringEncoder','消息序列化类','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','es_batch_size','5000','5000','实时数据获取批量入ES条数','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','es_wait_mills','10000','10000','如果没有达到批量的条数的等待时间','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','isbatch','true','true','是否批量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','concurrentLevel','8','8','并发数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','shell.executor.port','18099','18099','# shell executor port','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','shell.api.count','5','5','# shell executor api thread count','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','shell.executor.count','50','50','# shell executor count','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','common','SLOG_BIZ.properties','shell.executor.home','/home/yimr/yiprods/yimr/data/yict/shell','/home/yimr/yiprods/yimr/data/yict/shell','# shell executor home','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
UNLOCK TABLES;

LOCK TABLES `t_configuredef` WRITE;
/*!40000 ALTER TABLE `t_configuredef` DISABLE KEYS */;
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('192','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','darwin_home_path','/home/yimr/yiprods/yimr/DarwinApp/ssh/sshpass_64','/home/yimr/yiprods/yimr/DarwinApp/ssh/sshpass_64','','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('195','3','/lib/darwin/config/prod','api','API_BIZ.properties','总线服务配置','clean_time','01:00:00','01:00:00','数据清理时间','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('196','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','zookeeper.connect','192.168.2.91:2182','192.168.2.91:2182','zookeeper地址','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('197','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','group.id','default-group','default-group','消费者group id前缀','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('198','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','zookeeper.session.timeout.ms','40000','40000','zookeeper的session超时时间','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('199','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','zookeeper.sync.time.ms','200','200','zookeeper同步时间','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('200','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','auto.commit.interval.ms','1000','1000','offset提交时间间隔','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('201','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','auto.offset.reset','smallest','smallest','offset重置位置','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('203','1','/lib/darwin/config/prod','common','KAFKA_BIZ.properties','kafka服务配置','serializer.class','kafka.serializer.StringEncoder','kafka.serializer.StringEncoder','消息序列化类','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('202','1','/lib/darwin/config/prod','common','KAFKA_PRO_BIZ.properties','kafka生产者配置','metadata.broker.list','192.168.2.91:9093,192.168.2.91:9094','192.168.2.91:9093,192.168.2.91:9094','kafka地址列表','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('204','1','/lib/darwin/config/prod','common','KAFKA_PRO_BIZ.properties','kafka生产者配置','request.required.acks','1','1','消息是否需要确认','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('205','1','/lib/darwin/config/prod','common','KAFKA_PRO_BIZ.properties','kafka生产者配置','serializer.class','kafka.serializer.StringEncoder','kafka.serializer.StringEncoder','消息序列化类','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('206','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','es_batch_size','5000','5000','实时数据获取批量入ES条数','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('207','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','es_wait_mills','10000','10000','如果没有达到批量的条数的等待时间','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('208','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','isbatch','true','true','是否批量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('209','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','concurrentLevel','8','8','并发数量','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('210','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','shell.executor.port','18099','18099','shell executor port','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('211','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','shell.api.count','5','5','shell executor api thread count','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('212','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','shell.executor.count','50','50','shell executor count','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('213','1','/lib/darwin/config/prod','common','SLOG_BIZ.properties','SLOG配置','shell.executor.home','/home/yimr/yiprods/yimr/data/yict/shell','/home/yimr/yiprods/yimr/data/yict/shell','shell executor home','on','1',NULL,NULL);
/*!40000 ALTER TABLE `t_configuredef` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
insert into `t_role` (`id`, `name`, `desc`, `dbPrivilege`, `status`, `orgId`, `createTime`, `createUid`) values('1','超级管理员',NULL,NULL,'y','1','2015-05-03 11:09:36',NULL);
insert into `t_role` (`id`, `name`, `desc`, `dbPrivilege`, `status`, `orgId`, `createTime`, `createUid`) values('2','普通用户',NULL,NULL,'y','1','2015-05-03 11:09:36',NULL);
insert into `t_role` (`id`, `name`, `desc`, `dbPrivilege`, `status`, `orgId`, `createTime`, `createUid`) values('3','只读权限',NULL,NULL,'y','1','2015-05-03 11:09:36',NULL);
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;
  
  
/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.1.73 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'snmp日志','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(\\\\S+)\\\\:\\\\:(\\\\S+)\\\\s*\\\\=\\\\s*(\\\\S+):\\\\s+(.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"MIB\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"detail\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"type\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"value\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 15:16:22');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'apache日志1','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(.*) - - \\\\[(.*) .*\\\\] \\\\\\\"(.*) (.*) (.*)\\\\\\\" (.*) (.*)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"ip\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"[E]dd/MMM/yyyy:HH:mm:ss\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"method\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"url\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"http\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"rcode\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Integer\"},{\"isTime\":false,\"name\":\"size\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Integer\"}]}','0','','2015-10-27 15:33:58');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'syslog日志(匹配登录)','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(\\\\S+\\\\s+\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+(\\\\w+)\\\\s+(\\\\S+)\\\\:\\\\s+.+(\\\\d+\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+)\\\\s+\\\\w+\\\\s+(\\\\d+)\\\\s+(.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"[E]MMM dd HH:mm:ss\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"hostname\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"comid\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"ip\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"port\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"command\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 15:49:12');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'tomcat日志','es','{\"delimited_type\":\"REGX\",\"delimited\":\"\\\\[(\\\\d+\\\\-\\\\d+\\\\-\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+\\\\,\\\\d+)\\\\]\\\\[(\\\\w+)\\\\]\\\\[(\\\\S+)\\\\](.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"yyyy-MM-dd HH:mm:ss.SSS\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"status\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"thread\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"detail\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 15:52:11');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'mysql日志','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(\\\\d+)\\\\s+(\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+\\\\[(\\\\S+)\\\\]\\\\s+(.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"threadID\",\"desc\":\"\",\"dateFormat\":\"yyyy-MM-dd HH:mm:ss.SSS\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"HH:mm:ss\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"status\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"detail\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 15:55:10');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'DB2日志格式','es','{\"delimited_type\":\"REGX\",\"delimited\":\"([^\\\\s]+)\\\\+.+ ([^\\\\s]+)\\\\s+LEVEL\\\\: ([^\\\\s]*)\\\\s*(.*)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"yyyy-MM-dd-HH.mm.ss.SSS\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"id\",\"desc\":\"\",\"dateFormat\":\"HH:mm:ss\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"level\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"detail\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 16:16:13');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'weblogic日志','es','{\"delimited_type\":\"REGX\",\"delimited\":\"####\\\\<(.+\\\\s.+)\\\\s[^\\\\s]*\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<<(.*)\\\\>> \\\\<\\\\> \\\\<\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\>\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"yyyy-MM-dd-HH.mm.ss.SSS\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"level\",\"desc\":\"\",\"dateFormat\":\"HH:mm:ss\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"status\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"c4\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"server\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"module\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"username\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"date\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"c9\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"log\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 16:43:57');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'Apache日志','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(.+) - - \\\\[(.+) .+\\\\] \\\\\\\"(.+) (.+) (.+)\\\\\\\" (.+) (.+) \\\\\\\"(.+)\\\\\\\" \\\\\\\"(.+)\\\\\\\" (.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"ip\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"[E]dd/MMM/yyyy:HH:mm:ss\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"method\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"url\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"http\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"rcode\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Integer\"},{\"isTime\":false,\"name\":\"costtime\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Integer\"},{\"isTime\":false,\"name\":\"log\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"agent\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"size\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Integer\"}]}','0','','2015-10-27 16:54:49');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'syslog日志（操作）','es','{\"delimited_type\":\"REGX\",\"delimited\":\"(\\\\S+\\\\s+\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+(\\\\S+)\\\\s+(\\\\S+)\\\\:\\\\s+.+(\\\\d+\\\\-\\\\d+\\\\-\\\\d+\\\\s+\\\\d+\\\\:\\\\d+)\\\\s+\\\\((\\\\d+\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+)\\\\)\\\\:\\\\[(.+)\\\\](.+)\",\"notParser\":\"n\",\"line\":\"false\",\"lineReg\":\"\",\"columns\":[{\"isTime\":false,\"name\":\"time\",\"desc\":\"\",\"dateFormat\":\"[E]MMM dd HH:mm:ss\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"hostname\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"user\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"date\",\"desc\":\"\",\"dateFormat\":\"dd-MM-yyyy HH:mm\",\"type\":\"Datetime\"},{\"isTime\":false,\"name\":\"ip\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"dir\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"},{\"isTime\":false,\"name\":\"command\",\"desc\":\"\",\"dateFormat\":\"\",\"type\":\"Text\"}]}','0','','2015-10-27 16:56:34');
  
ALTER TABLE `t_version`   
  ADD COLUMN `url` VARCHAR(250) NULL AFTER `version`,
  ADD COLUMN `remark` TEXT NULL AFTER `url`,
  ADD COLUMN `status` VARCHAR(45) NULL AFTER `remark`,
  ADD COLUMN `rollback` VARCHAR(125) NULL AFTER `status`,
  ADD COLUMN `logs` text NULL AFTER `rollback`;
  
-----------------阿里云环境up.2015.11.10----------------------------

DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='queueFactor';
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='isdebug';
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='es_host_list';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND `key`='queueFactor';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND `key`='isdebug';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND `key`='es_host_list';

LOCK TABLES `t_configure` WRITE;
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','queueFactor','50','50','队列负载因子，这个值乘以每批的数量就是队列的长度','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','isdebug','false','false','是否为debug模式(true 或者false)，默认是false，用于查看队列的堆积情况以及提交给ES的情况','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','es_host_list','darwin01,darwin02,darwin03','darwin01,darwin02,darwin03','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
UNLOCK TABLES;

LOCK TABLES `t_configuredef` WRITE;
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('214','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','queueFactor','50','50','队列负载因子，这个值乘以每批的数量就是队列的长度','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('215','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','isdebug','false','false','是否为debug模式(true 或者false)，默认是false，用于查看队列的堆积情况以及提交给ES的情况','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('216','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','es_host_list','darwin01,darwin02,darwin03','darwin01,darwin02,darwin03','','on','1',NULL,NULL);
UNLOCK TABLES;

-----------------银联5.0.11.2升级包-2015.11.19----------------------------

ALTER TABLE `t_monitor`   
  ADD COLUMN `polyMethod` VARCHAR(45) NULL  COMMENT '聚合方法' AFTER `target`,
  ADD COLUMN `colName` VARCHAR(125) NULL  COMMENT '聚合字段名称' AFTER `polyMethod`,
  ADD COLUMN `remark` TEXT NULL  COMMENT '监控描述' AFTER `colName`;
  
CREATE TABLE `t_baseLine`(  
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(125),
  `type` VARCHAR(125),
  `index` VARCHAR(125),
  `granular` VARCHAR(45),
  PRIMARY KEY (`id`)
);

-----------------光大5.0.12小芳打包-2015.11.24----------------------------
DELETE FROM `t_configure` WHERE fileName='ALERT_BIZ.properties' AND `key`='es_host';
DELETE FROM `t_configure` WHERE fileName='ALERT_BIZ.properties' AND `key`='es_port';
DELETE FROM `t_configuredef` WHERE fileName='ALERT_BIZ.properties' AND `key`='es_host';
DELETE FROM `t_configuredef` WHERE fileName='ALERT_BIZ.properties' AND `key`='es_port';

insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','es_host','192.168.2.92','192.168.2.92','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','ALERT_BIZ.properties','es_port','19200','19200','告警回溯的web端ip','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('217','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','es_host','192.168.2.92','192.168.2.92','','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('218','1','/lib/darwin/config/prod','yict','ALERT_BIZ.properties','告警配置','es_port','19200','19200','','on','1',NULL,NULL);

/*
实时组件内置模板
*********************************************************************
*/
DELETE FROM `t_dsTemplate` WHERE `name`='snmp日志' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='Apache日志' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='Apache日志（10列）' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='syslog日志（匹配登录）' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='syslog日志（匹配操作）' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='tomcat日志' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='MySQL日志' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='DB2日志' AND `type`='realtimeReceive';
DELETE FROM `t_dsTemplate` WHERE `name`='weblogic日志' AND `type`='realtimeReceive';

insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'snmp日志','realtimeReceive','{\"colDelimitExpr\":\"(\\\\S+)\\\\:\\\\:(\\\\S+)\\\\s*\\\\=\\\\s*(\\\\S+):\\\\s+(.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"4\",\"columns\":[{\"column_name\":\"MIB\",\"id\":\"0\",\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"detail\",\"id\":\"1\",\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:227\"},{\"column_name\":\"type\",\"id\":\"2\",\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:228\"},{\"column_name\":\"value\",\"id\":\"3\",\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:229\"}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:16:28');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'Apache日志','realtimeReceive','{\"colDelimitExpr\":\"(.*) - - \\\\[(.*) .*\\\\] \\\\\\\"(.*) (.*) (.*)\\\\\\\" (.*) (.*)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"7\",\"columns\":[{\"column_name\":\"ip\",\"id\":0,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"time\",\"id\":1,\"type_name\":\"datetime\",\"dateFormat\":\"[E]dd/MMM/yyyy:HH:mm:ss\",\"isTime\":\"false\",\"$$hashKey\":\"object:227\"},{\"column_name\":\"method\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:228\"},{\"column_name\":\"url\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:229\"},{\"column_name\":\"http\",\"id\":4,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"rcode\",\"id\":5,\"type_name\":\"int\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"size\",\"id\":6,\"type_name\":\"int\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:20:07');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'Apache日志（10列）','realtimeReceive','{\"colDelimitExpr\":\"(.+) - - \\\\[(.+) .+\\\\] \\\\\\\"(.+) (.+) (.+)\\\\\\\" (.+) (.+) \\\\\\\"(.+)\\\\\\\" \\\\\\\"(.+)\\\\\\\" (.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"10\",\"columns\":[{\"column_name\":\"ip\",\"id\":0,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"time\",\"id\":1,\"type_name\":\"datetime\",\"dateFormat\":\"[E]dd/MMM/yyyy:HH:mm:ss\",\"isTime\":false},{\"column_name\":\"method\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"url\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"http\",\"id\":4,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"rcode\",\"id\":5,\"type_name\":\"int\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"costtime\",\"id\":6,\"type_name\":\"int\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"log\",\"id\":7,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"agent\",\"id\":8,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"size\",\"id\":9,\"type_name\":\"int\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:22:04');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'syslog日志（匹配登录）','realtimeReceive','{\"colDelimitExpr\":\"(\\\\S+\\\\s+\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+(\\\\w+)\\\\s+(\\\\S+)\\\\:\\\\s+.+(\\\\d+\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+)\\\\s+\\\\w+\\\\s+(\\\\d+)\\\\s+(.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"6\",\"columns\":[{\"column_name\":\"time\",\"id\":0,\"type_name\":\"datetime\",\"dateFormat\":\"[E]MMM dd HH:mm:ss\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"hostname\",\"id\":1,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"comid\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"ip\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"port\",\"id\":4,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"command\",\"id\":5,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:25:03');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'syslog日志（匹配操作）','realtimeReceive','{\"colDelimitExpr\":\"(\\\\S+\\\\s+\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+(\\\\S+)\\\\s+(\\\\S+)\\\\:\\\\s+.+(\\\\d+\\\\-\\\\d+\\\\-\\\\d+\\\\s+\\\\d+\\\\:\\\\d+)\\\\s+\\\\((\\\\d+\\\\.\\\\d+\\\\.\\\\d+\\\\.\\\\d+)\\\\)\\\\:\\\\[(.+)\\\\](.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"7\",\"columns\":[{\"column_name\":\"time\",\"id\":0,\"type_name\":\"datetime\",\"dateFormat\":\"[E]MMM dd HH:mm:ss\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"hostname\",\"id\":1,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"user\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"date\",\"id\":3,\"type_name\":\"datetime\",\"dateFormat\":\"dd-MM-yyyy HH:mm\",\"isTime\":false},{\"column_name\":\"ip\",\"id\":4,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"dir\",\"id\":5,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"command\",\"id\":6,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:26:29');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'tomcat日志','realtimeReceive','{\"colDelimitExpr\":\"\\\\[(\\\\d+\\\\-\\\\d+\\\\-\\\\d+\\\\s+\\\\d+\\\\:\\\\d+\\\\:\\\\d+\\\\,\\\\d+)\\\\]\\\\[(\\\\w+)\\\\]\\\\[(\\\\S+)\\\\](.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"4\",\"columns\":[{\"column_name\":\"time\",\"id\":0,\"type_name\":\"datetime\",\"dateFormat\":\"yyyy-MM-dd HH:mm:ss.SSS\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"status\",\"id\":1,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"thread\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"detail\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:27:36');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'MySQL日志','realtimeReceive','{\"colDelimitExpr\":\"(\\\\d+)\\\\s+(\\\\d+\\\\:\\\\d+\\\\:\\\\d+)\\\\s+\\\\[(\\\\S+)\\\\]\\\\s+(.+)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"4\",\"columns\":[{\"column_name\":\"threadID\",\"id\":0,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"time\",\"id\":1,\"type_name\":\"datetime\",\"dateFormat\":\"HH:mm:ss\",\"isTime\":false},{\"column_name\":\"status\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"detail\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:28:38');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'DB2日志','realtimeReceive','{\"colDelimitExpr\":\"([^\\\\s]+)\\\\+.+ ([^\\\\s]+)\\\\s+LEVEL\\\\: ([^\\\\s]*)\\\\s*(.*)\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"4\",\"columns\":[{\"column_name\":\"time\",\"id\":0,\"type_name\":\"datetime\",\"dateFormat\":\"yyyy-MM-dd-HH.mm.ss.SSS\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"id\",\"id\":1,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"level\",\"id\":2,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"detail\",\"id\":3,\"type_name\":\"text\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:29:51');
insert into `t_dsTemplate` (`id`, `name`, `type`, `ruleConf`, `createUid`, `createUsername`, `createTime`) values(NULL,'weblogic日志','realtimeReceive','{\"colDelimitExpr\":\"####\\\\<(.+\\\\s.+)\\\\s[^\\\\s]*\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<<(.*)\\\\>> \\\\<\\\\> \\\\<\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\> \\\\<(.*)\\\\>\",\"colDelimitType\":\"REGX\",\"colDellimitExprType\":\"defalut\",\"columnSize\":\"10\",\"columns\":[{\"column_name\":\"time\",\"id\":0,\"type_name\":\"datetime\",\"dateFormat\":\"yyyy-MM-dd-HH.mm.ss.SSS\",\"isTime\":\"false\",\"$$hashKey\":\"object:226\"},{\"column_name\":\"level\",\"id\":1,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"status\",\"id\":2,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"c4\",\"id\":3,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"server\",\"id\":4,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"module\",\"id\":5,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"username\",\"id\":6,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"date\",\"id\":7,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"c9\",\"id\":8,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false},{\"column_name\":\"detail\",\"id\":9,\"type_name\":\"string\",\"dateFormat\":\"\",\"isTime\":false}],\"encoding\":\"UTF-8\",\"sourceType\":\"\",\"topic\":\"student\",\"type\":\"kafka\"}','0','','2015-11-30 11:31:39');

/*
elasticsearch数据的存储路径
*********************************************************************
*/
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='path.data';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND `key`='path.data';
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','path.data','/home/yimr/lamp/elasticsearch/data','/home/yimr/lamp/elasticsearch/data','ES数据的存储路径','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('219','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','path.data','/home/yimr/lamp/elasticsearch/data','/home/yimr/lamp/elasticsearch/data','ES数据的存储路径','on','1',NULL,NULL);

-----------------光大5.0.12升级包-2015.12.01----------------------------

---------在创建索引的配置文件里面添加一个配置，interval=3，意思是每隔3s打印一次当前入索引的速度-------------
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='interval';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND `key`='interval';
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','interval','3','3','每隔几秒打印一次当前入索引的速度','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('220','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','interval','3','3','每隔几秒打印一次当前入索引的速度','on','1',NULL,NULL);

---------删除三个配置，跟资源池的核数内存有关------------------------------------------------
DELETE FROM `t_configure` WHERE fileName='darwin-env.sh' AND `key`='SPARK_EXECUTOR_INSTANCES';
DELETE FROM `t_configure` WHERE fileName='spark.conf' AND `key`='spark.executor.memory';
DELETE FROM `t_configure` WHERE fileName='spark.conf' AND `key`='spark.cores.max';
DELETE FROM `t_configuredef` WHERE fileName='darwin-env.sh' AND `key`='SPARK_EXECUTOR_INSTANCES';
DELETE FROM `t_configuredef` WHERE fileName='spark.conf' AND `key`='spark.executor.memory';
DELETE FROM `t_configuredef` WHERE fileName='spark.conf' AND `key`='spark.cores.max';

---------删除以下ES配置，参照文档------------------------------------------------------
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='bootstrap.mlockall';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='indices.store.throttle.type';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='indices.store.throttle.max_bytes_per_sec';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='indices.cache.filter.size';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='index.cache.field.type';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='index.cache.field.max_size';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='index.cache.field.expire';
DELETE FROM `t_configure` WHERE fileName='elasticsearch.yml' AND `key`='indices.fielddata.cache.size';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='bootstrap.mlockall';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='indices.store.throttle.type';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='indices.store.throttle.max_bytes_per_sec';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='indices.cache.filter.size';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='index.cache.field.type';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='index.cache.field.max_size';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='index.cache.field.expire';
DELETE FROM `t_configuredef` WHERE fileName='elasticsearch.yml' AND`key`='indices.fielddata.cache.size';

------------------------es数据模板共享------------------------------------
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='snmp日志' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='apache日志1' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='syslog日志(匹配登录)' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='tomcat日志' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='mysql日志' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='DB2日志格式' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='weblogic日志' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='Apache日志' AND `type`='es';
UPDATE `t_dsTemplate` SET createUid='0', createUsername=NULL WHERE `name`='syslog日志（操作）' AND `type`='es';

------------------------流程模板状态必须是offline---------------------------
UPDATE `t_flow` SET STATUS='offline' WHERE `isTemplate`='y';

-------------------------5.0.14.2数据分类-------------------------------
DROP TABLE IF EXISTS `t_dataCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_dataCategory` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `fullName` VARCHAR(1024) NULL,
  `pid` INT(11) DEFAULT NULL,
  `createtime` DATETIME DEFAULT NULL,
  `createAccount` VARCHAR(45) DEFAULT NULL,
  `updatetime` DATETIME DEFAULT NULL,
  `updateAccount` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

insert into `t_dataCategory` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('1','分类1',NULL,'0',NULL,NULL,'2015-12-16 19:02:50','admin');
insert into `t_dataCategory` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('2','模块1',NULL,'1',NULL,NULL,NULL,NULL);
insert into `t_dataCategory` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('3','模块2',NULL,'1',NULL,NULL,NULL,NULL);
insert into `t_dataCategory` (`id`, `name`, `fullName`, `pid`, `createtime`, `createAccount`, `updatetime`, `updateAccount`) values('4','分类2',NULL,'0',NULL,NULL,NULL,NULL);

-------------------------2015-12-09银联升级包已提供，华北油田第三次同步-------------------------------

ALTER TABLE `t_esIndex`   
  ADD COLUMN `categoryId` INT(11) NULL AFTER `groupId`;

ALTER TABLE `t_monitor`   
  ADD COLUMN `categoryId` INT(11) NULL AFTER `index`;

ALTER TABLE `t_trigger`   
  ADD COLUMN `categoryId` INT(11) NULL AFTER `nodeId`;

ALTER TABLE `t_configure` ENGINE = INNODB;

-------------------------es增加配置-------------------------------
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','elasticsearch','elasticsearch.yml','index.number_of_replicas','1','1','设置默认索引副本个数，默认为1个副本。','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('221','2','/config','elasticsearch','elasticsearch.yml','ElasticSearch配置','index.number_of_replicas','1','1','设置默认索引副本个数，默认为1个副本。','on','1',NULL,NULL);

------------------------es增加配置--------------------------------
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='messages';
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='hosts';
DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='paths';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND`key`='messages';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND`key`='hosts';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND`key`='paths';

insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','messages','message,@message','message,@message','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','hosts','host,@host','host,@host','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','paths','path,@path','path,@path','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('222','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','messages','message,@message','message,@message','','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('223','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','hosts','host,@host','host,@host','','on','1',NULL,NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('224','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','paths','path,@path','path,@path','','on','1',NULL,NULL);

----------------------------配置文件存在数据库里面--------------------------------
ALTER TABLE `t_version` 
ADD COLUMN `updatetime` DATETIME NULL AFTER `logs`;

DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='self_monitor_template';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND`key`='self_monitor_template';
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','self_monitor_template','/home/yimr/lamp/logstash-2.1.1/elasticsearch-template.json','/home/yimr/lamp/logstash-2.1.1/elasticsearch-template.json','','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('225','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','self_monitor_template','/home/yimr/lamp/logstash-2.1.1/elasticsearch-template.json','/home/yimr/lamp/logstash-2.1.1/elasticsearch-template.json','','on','1',NULL,NULL);

DELETE FROM `t_configure` WHERE fileName='CREATE_BIZ.properties' AND `key`='esapi.size';
DELETE FROM `t_configuredef` WHERE fileName='CREATE_BIZ.properties' AND`key`='esapi.size';
insert into `t_configure` (`id`, `nodeId`, `type`, `fileName`, `key`, `value`, `valueDef`, `remark`, `status`, `updateFlag`, `updateCount`, `updateOk`, `createUid`, `createTime`, `updateTime`) values(NULL,'0','yict','CREATE_BIZ.properties','esapi.size','3','3','每台机器EsApi的数量','on',NULL,NULL,NULL,'1','2015-07-31 18:28:52',NULL);
insert into `t_configuredef` (`id`, `flag`, `folder`, `type`, `fileName`, `description`, `key`, `value`, `valueDef`, `remark`, `status`, `createUid`, `createTime`, `updateTime`) values('226','1','/lib/darwin/config/prod','yict','CREATE_BIZ.properties','创建索引配置','esapi.size','3','3','每台机器EsApi的数量','on','1',NULL,NULL);

DROP TABLE IF EXISTS `t_kbnQuery`;
CREATE TABLE `t_kbnQuery`(  
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(125),
  `query` TEXT,
  `createUid` VARCHAR(125),
  `createTime` DATETIME,
  PRIMARY KEY (`id`)
);

ALTER TABLE `t_org`   
  ADD COLUMN `nodeId` INT(11) NOT NULL AFTER `pid`;
  
