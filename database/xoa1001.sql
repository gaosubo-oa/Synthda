-- MySQL dump 10.13  Distrib 5.6.45, for Linux (x86_64)
--
-- Host: localhost    Database: xoa1123
-- ------------------------------------------------------
-- Server version	5.6.45-log

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `ADD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `USER_ID` varchar(20) DEFAULT '' COMMENT '创建人USER_ID',
  `PSN_NAME` varchar(120) NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `SEX` char(1) DEFAULT '' COMMENT '性别(0-男,1-女)',
  `NICK_NAME` varchar(50) DEFAULT '' COMMENT '昵称',
  `BIRTHDAY` date DEFAULT '0000-00-00' COMMENT '生日',
  `MINISTRATION` varchar(50) DEFAULT '' COMMENT '职务',
  `MATE` varchar(50) DEFAULT '' COMMENT '配偶',
  `CHILD` varchar(50) DEFAULT '' COMMENT '子女',
  `DEPT_NAME` varchar(50) DEFAULT '' COMMENT '单位名称',
  `ADD_OFFICE` varchar(50) DEFAULT '' COMMENT '办公室',
  `POST_NO_DEPT` varchar(50) DEFAULT '' COMMENT '单位邮编',
  `TEL_NO_DEPT` varchar(50) DEFAULT '' COMMENT '工作电话',
  `FAX_NO_DEPT` varchar(50) DEFAULT '' COMMENT '工作传真',
  `ADD_HOME` varchar(200) DEFAULT '' COMMENT '家庭住址',
  `POST_NO_HOME` varchar(50) DEFAULT '' COMMENT '家庭邮编',
  `TEL_NO_HOME` varchar(50) DEFAULT '' COMMENT '家庭电话',
  `MOBIL_NO` varchar(50) DEFAULT '' COMMENT '手机',
  `EMAIL` varchar(100) DEFAULT '' COMMENT '电子邮件',
  `OICQ_NO` varchar(50) DEFAULT '' COMMENT 'QQ',
  `ICQ_NO` varchar(50) DEFAULT '' COMMENT 'MSN号码',
  `NOTES` text COMMENT '备注',
  `PSN_NO` int(11) DEFAULT '0' COMMENT '排序',
  `SHARE_USER` text COMMENT '共享范围',
  `MANAGE_USER` text COMMENT '修改权限用户',
  `ADD_SHARE_NAME` varchar(11) DEFAULT NULL COMMENT '共享名',
  `ATTACHMENT_ID` text COMMENT '附件id',
  `ATTACHMENT_NAME` text COMMENT '附件名称',
  `ADD_START` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '共享开始时间',
  `ADD_END` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '共享结束时间',
  `PER_WEB` varchar(200) DEFAULT NULL COMMENT '个人主页',
  `GROUP_ID` int(11) DEFAULT NULL COMMENT '所属组',
  `ADD_DEPT` varchar(200) DEFAULT NULL COMMENT '单位地址',
  `BP_NO` varchar(50) DEFAULT NULL COMMENT '小灵通',
  PRIMARY KEY (`ADD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_group`
--

DROP TABLE IF EXISTS `address_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_group` (
  `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `GROUP_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '分组名称',
  `USER_ID` varchar(200) NOT NULL DEFAULT '' COMMENT '创建人USER_ID',
  `PRIV_DEPT` text NOT NULL COMMENT '部门权限',
  `PRIV_ROLE` text NOT NULL COMMENT '角色权限',
  `PRIV_USER` text NOT NULL COMMENT '用户权限',
  `ORDER_NO` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `SUPPORT_DEPT` text NOT NULL COMMENT '维护权限部门',
  `SUPPORT_USER` text NOT NULL COMMENT '维护权限用户',
  `SHARE_GROUP_ID` int(11) NOT NULL COMMENT '共享组',
  `SHARE_USER_ID` text NOT NULL COMMENT '共享用户',
  PRIMARY KEY (`GROUP_ID`) USING BTREE,
  KEY `GROUP_NAME` (`GROUP_NAME`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `ORDER_NO` (`ORDER_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='通讯簿分组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_group`
--

LOCK TABLES `address_group` WRITE;
/*!40000 ALTER TABLE `address_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `affair`
--

DROP TABLE IF EXISTS `affair`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affair` (
  `AFF_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户ID',
  `BEGIN_TIME` int(10) unsigned NOT NULL COMMENT '起始日期',
  `END_TIME` int(10) unsigned NOT NULL COMMENT '结束日期',
  `TYPE` char(1) NOT NULL DEFAULT '' COMMENT '提醒类型(2-按日提醒,3-按周提醒,4-按月提醒,5按年提醒,6-按工作日提醒)',
  `REMIND_DATE` varchar(200) NOT NULL DEFAULT '' COMMENT '提醒日期',
  `REMIND_TIME` time NOT NULL DEFAULT '00:00:00' COMMENT '提醒时间',
  `CONTENT` text NOT NULL COMMENT '事务内容 ',
  `LAST_REMIND` date NOT NULL DEFAULT '0000-00-00' COMMENT '最近一次提醒的时间',
  `SMS_REMIND` char(1) NOT NULL DEFAULT '1' COMMENT '是否使用事务提醒(0-否,1-是)',
  `SMS2_REMIND` varchar(2) NOT NULL COMMENT '是否使用手机短信提醒(0-否,1-是)',
  `LAST_SMS2_REMIND` date NOT NULL DEFAULT '0000-00-00' COMMENT '最近一次手机短信提醒的时间',
  `MANAGER_ID` varchar(20) NOT NULL COMMENT '任务安排人的用户ID',
  `CAL_TYPE` char(1) NOT NULL COMMENT '事务类型(1-工作事务,2-个人事务)',
  `ADD_TIME` datetime NOT NULL COMMENT '新建时间',
  `TAKER` text NOT NULL COMMENT '参与人',
  `BEGIN_TIME_TIME` time NOT NULL COMMENT '开始时间',
  `END_TIME_TIME` time NOT NULL COMMENT '结束时间',
  `ALLDAY` tinyint(3) unsigned NOT NULL COMMENT '全天',
  PRIMARY KEY (`AFF_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `BEGIN_TIME_2` (`BEGIN_TIME`) USING BTREE,
  KEY `END_TIME_2` (`END_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='日期安排-周期性事务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affair`
--

LOCK TABLES `affair` WRITE;
/*!40000 ALTER TABLE `affair` DISABLE KEYS */;
/*!40000 ALTER TABLE `affair` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_setting`
--

DROP TABLE IF EXISTS `ai_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_setting` (
  `UID` int(20) NOT NULL COMMENT 'user的主键',
  `greet` int(10) DEFAULT NULL COMMENT '启动时自动语音问候(0-是，1-否)',
  `approval` int(10) DEFAULT NULL COMMENT '启动时自动语音审批(0-是，1-否)',
  `rouse` int(10) DEFAULT NULL COMMENT '语音唤醒(0-是，1-否)',
  PRIMARY KEY (`UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='AI设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_setting`
--

LOCK TABLES `ai_setting` WRITE;
/*!40000 ALTER TABLE `ai_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alidaas_set`
--

DROP TABLE IF EXISTS `alidaas_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alidaas_set` (
  `IDAAS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `APP_ID` varchar(255) DEFAULT NULL COMMENT '应用ID',
  `APP_NAME` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `JWT_PUBLICKEY` text COMMENT 'JWT PublicKey',
  `IDAAS_BASE_URL` varchar(255) DEFAULT NULL COMMENT 'IDaaS主域名',
  `API_KEY` varchar(255) DEFAULT NULL COMMENT '连接IDaas的client-id',
  `API_SECRET` varchar(255) DEFAULT NULL COMMENT '连接IDaas的client-secret',
  `OID` varchar(255) DEFAULT NULL COMMENT '组织ID',
  PRIMARY KEY (`IDAAS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alidaas_set`
--

LOCK TABLES `alidaas_set` WRITE;
/*!40000 ALTER TABLE `alidaas_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `alidaas_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `antiepidemic`
--

DROP TABLE IF EXISTS `antiepidemic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `antiepidemic` (
  `ANTI_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水号',
  `NAME` varchar(60) DEFAULT NULL COMMENT '姓名',
  `COMPANY` varchar(255) DEFAULT NULL COMMENT '单位',
  `POST` varchar(255) DEFAULT NULL COMMENT '岗位职务',
  `MOBIL_NO` varchar(50) DEFAULT NULL COMMENT '手机号码',
  `ID_NUMBER` varchar(100) DEFAULT NULL COMMENT '身份证号码',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '访问地点',
  `VISIT_TIME` datetime DEFAULT NULL COMMENT '计划到访时间',
  `LSOLATION` varchar(255) DEFAULT NULL COMMENT '访问前隔离情况',
  `VISIT_LOCATION` char(10) DEFAULT NULL COMMENT '访问地址(SYS_CODE)',
  `PROMISE_STATE` char(10) DEFAULT NULL COMMENT '承诺书意见(0-不同意1-同意)',
  `REGISTER_TIME` datetime DEFAULT NULL COMMENT '登记时间',
  `TRIP` text COMMENT '详细行程',
  `ATTACHMENT_ID_HEALTH` text COMMENT '附件ID串(健康码)',
  `ATTACHMENT_NAME_HEALTH` text COMMENT '附件名称串(健康码)',
  `ATTACHMENT_ID_TRAVEL` text COMMENT '附件ID串(行程码)',
  `ATTACHMENT_NAME_TRAVEL` text COMMENT '附件名称串(行程码)',
  `ATTACHMENT_ID_VACCINATION` text COMMENT '附件ID串(疫苗接种)',
  `ATTACHMENT_NAME_VACCINATION` text COMMENT '附件名称串(疫苗接种)',
  `ATTACHMENT_ID_TOUCH` text COMMENT '附件ID串(同行密接自查)',
  `ATTACHMENT_NAME_TOUCH` text COMMENT '附件名称串(同行密接自查)',
  `ATTACHMENT_ID_NUCLEIN` text COMMENT '附件ID串(核酸记录)',
  `ATTACHMENT_NAME_NUCLEIN` text COMMENT '附件名称串(核酸记录)',
  `STATE` char(10) DEFAULT NULL COMMENT '审批意见(0-不同意1-同意 2-待审批)',
  PRIMARY KEY (`ANTI_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='防疫登记表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `antiepidemic`
--

LOCK TABLES `antiepidemic` WRITE;
/*!40000 ALTER TABLE `antiepidemic` DISABLE KEYS */;
/*!40000 ALTER TABLE `antiepidemic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_connect`
--

DROP TABLE IF EXISTS `app_connect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_connect` (
  `AID` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方应用ID',
  `APP_ID` varchar(255) NOT NULL COMMENT '应用内部ID',
  `APP_NAME` varchar(255) DEFAULT NULL COMMENT '应用名字',
  `ACCESS_TOKEN` varchar(255) NOT NULL COMMENT '调用接口凭证',
  `IP1` char(50) DEFAULT NULL COMMENT 'IP段1',
  `IP2` char(50) DEFAULT NULL COMMENT 'IP段2',
  `APP_DESC` text COMMENT '应用描述',
  PRIMARY KEY (`AID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='第三方应用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_connect`
--

LOCK TABLES `app_connect` WRITE;
/*!40000 ALTER TABLE `app_connect` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_connect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_connect_user`
--

DROP TABLE IF EXISTS `app_connect_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_connect_user` (
  `AUID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `AID` int(11) NOT NULL COMMENT '应用id',
  `APP_USER` varchar(255) DEFAULT NULL COMMENT '应用用户名',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT 'OA用户名',
  PRIMARY KEY (`AUID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_connect_user`
--

LOCK TABLES `app_connect_user` WRITE;
/*!40000 ALTER TABLE `app_connect_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_connect_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_log`
--

DROP TABLE IF EXISTS `app_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_log` (
  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT 'OA用户名',
  `TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  `MODULE` varchar(10) NOT NULL DEFAULT '' COMMENT '模块id',
  `OPP_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '操作记录的id',
  `TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '操作类型',
  `REMARK` longtext NOT NULL COMMENT '备注',
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  KEY `MODULE_OPP_USER_TYPE` (`MODULE`,`OPP_ID`,`USER_ID`,`TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='各模块操作日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_log`
--

LOCK TABLES `app_log` WRITE;
/*!40000 ALTER TABLE `app_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment`
--

DROP TABLE IF EXISTS `attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment` (
  `AID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `POSITION` tinyint(3) unsigned NOT NULL COMMENT '位置',
  `MODULE` tinyint(3) unsigned NOT NULL COMMENT '对应attachment_module表中模块的module_id号',
  `YM` char(4) NOT NULL COMMENT '年月',
  `ATTACH_ID` int(11) NOT NULL COMMENT '附件ID',
  `ATTACH_FILE` varchar(200) NOT NULL COMMENT '附件文件',
  `ATTACH_NAME` varchar(200) NOT NULL COMMENT '附件名称',
  `ATTACH_SIGN` bigint(20) NOT NULL COMMENT '标记',
  `DEL_FLAG` tinyint(3) unsigned NOT NULL COMMENT '删除标记(0-未删除,1-已删除)',
  `SIZE` varchar(255) DEFAULT NULL COMMENT '附件大小',
  PRIMARY KEY (`AID`) USING BTREE,
  KEY `ATTACH_ID_INDEX` (`ATTACH_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment`
--

LOCK TABLES `attachment` WRITE;
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_edit`
--

DROP TABLE IF EXISTS `attachment_edit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_edit` (
  `ATTACHMENT_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '附件ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户ID',
  `LAST_VISIT` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '访问时间',
  PRIMARY KEY (`ATTACHMENT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Office文档在线编辑操作表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_edit`
--

LOCK TABLES `attachment_edit` WRITE;
/*!40000 ALTER TABLE `attachment_edit` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment_edit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_index`
--

DROP TABLE IF EXISTS `attachment_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_index` (
  `AID` int(10) NOT NULL COMMENT '附件ID',
  `ATTACH_KEYWORDS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '附件关键词',
  `ATTACH_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '附件内容',
  PRIMARY KEY (`AID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件全文检索信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_index`
--

LOCK TABLES `attachment_index` WRITE;
/*!40000 ALTER TABLE `attachment_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_index_priv`
--

DROP TABLE IF EXISTS `attachment_index_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_index_priv` (
  `MODULE_ID` tinyint(3) NOT NULL COMMENT '模块ID',
  `MODULE_NAME` varchar(30) NOT NULL COMMENT '模块名称',
  `PRIV_IDS` text COMMENT '角色权限',
  `DEPT_IDS` text COMMENT '部门权限',
  `USER_IDS` text COMMENT '用户权限',
  PRIMARY KEY (`MODULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件全文检索权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_index_priv`
--

LOCK TABLES `attachment_index_priv` WRITE;
/*!40000 ALTER TABLE `attachment_index_priv` DISABLE KEYS */;
INSERT INTO `attachment_index_priv` VALUES (1,'电子邮件',NULL,NULL,NULL),(2,'流程中心',NULL,NULL,NULL),(3,'文件柜',NULL,NULL,NULL),(4,'公告通知',NULL,NULL,NULL),(5,'新闻',NULL,NULL,NULL),(6,'工作日志',NULL,NULL,NULL),(7,'日程',NULL,NULL,NULL),(9,'CRM',NULL,NULL,NULL),(10,'公文管理',NULL,NULL,NULL),(12,'人事档案',NULL,NULL,NULL),(26,'即时通讯',NULL,NULL,NULL),(98,'人员',NULL,NULL,NULL);
/*!40000 ALTER TABLE `attachment_index_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_module`
--

DROP TABLE IF EXISTS `attachment_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_module` (
  `MODULE_ID` tinyint(3) unsigned NOT NULL COMMENT '模块ID',
  `MODULE_NAME` varchar(30) NOT NULL COMMENT '模块名称',
  `MODULE_CODE` varchar(30) NOT NULL COMMENT '模块代码',
  PRIMARY KEY (`MODULE_ID`) USING BTREE,
  UNIQUE KEY `MODULE_CODE` (`MODULE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='附件模块信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_module`
--

LOCK TABLES `attachment_module` WRITE;
/*!40000 ALTER TABLE `attachment_module` DISABLE KEYS */;
INSERT INTO `attachment_module` VALUES (1,'电子邮件','email'),(2,'工作流','workflow'),(3,'文件柜','file_folder'),(4,'公告通知','notify'),(5,'新闻','news'),(6,'工作日志','diary'),(7,'会议纪要','summary_meet'),(8,'会议管理','meeting'),(9,'人力资源','hr_staffinfo'),(10,'人力资源','hr_staffcontract'),(11,'印章','seal'),(12,'人力资源','hr'),(14,'办公用品','office_product'),(15,'项目管理','project'),(16,'报表管理','reportshop'),(17,'档案管理','roll_manage'),(18,'学生请假查询','eduAttend'),(19,'校园短信','edu_dxfw'),(20,'督办发表反馈','supervision'),(21,'督办','supervise'),(22,'奖惩','incentive'),(23,'大事记管理','timeline'),(24,'固定资产','fixAssets'),(25,'Word模板','model'),(26,'即时通讯','im'),(27,'数据交互平台','ext_data'),(28,'固定资产','asset'),(29,'其它','unknown'),(30,'通讯簿','address'),(31,'语音微讯','voicemsg'),(32,'门户','portal'),(33,'微讯分享','weixunshare'),(34,'安全文档中心','safedoc'),(35,'临时文件夹','upload_temp'),(36,'智协同','itask'),(37,'手机考勤','attend'),(38,'系统管理','sys'),(39,'微讯','wechat'),(40,'邮件统计','emailCount'),(41,'讨论区','bbs'),(42,'图书管理','book'),(43,'CRM','crm'),(44,'公文管理','document'),(45,'电子传真','fax'),(46,'销售管理','sale_manage'),(47,'培训管理','training'),(48,'车辆管理','vehicle'),(49,'投票','vote'),(50,'工作计划','work_plan'),(51,'OA知道','zhidao'),(52,'单位管理','unit');
/*!40000 ALTER TABLE `attachment_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachment_position`
--

DROP TABLE IF EXISTS `attachment_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachment_position` (
  `POS_ID` tinyint(3) unsigned NOT NULL COMMENT '标识ID',
  `POS_NAME` varchar(100) NOT NULL COMMENT '描述',
  `POS_PATH` varchar(500) NOT NULL COMMENT '目录',
  `IS_ACTIVE` char(1) NOT NULL DEFAULT '0' COMMENT '是否将所有新附件存至该目录(1-是,0-否)',
  PRIMARY KEY (`POS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自定义附件存储路径表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachment_position`
--

LOCK TABLES `attachment_position` WRITE;
/*!40000 ALTER TABLE `attachment_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c_accountinfo`
--

DROP TABLE IF EXISTS `c_accountinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c_accountinfo` (
  `PERSON_ID` varchar(255) NOT NULL COMMENT '用户主键',
  `USER_ID` varchar(32) NOT NULL COMMENT '用户组织id_userId',
  `ACCOUNT` varchar(100) NOT NULL COMMENT '用户账号',
  `PASSWORD` varchar(200) NOT NULL COMMENT '用户密码 MD5加密',
  `NAME` varchar(100) DEFAULT NULL COMMENT '用户姓名',
  `ID_CARD_NO` varchar(200) DEFAULT NULL COMMENT '证件号码',
  `CRED_TYPE` char(2) DEFAULT NULL COMMENT '证件类型 0:身份证 1:护照 2：军人证 3：其他',
  `GENDER` char(1) DEFAULT NULL COMMENT '性别 0：女 1：男 2：保密',
  `USER_TYPE` varchar(50) DEFAULT NULL,
  `PHONE_NUMBERS` varchar(20) DEFAULT NULL COMMENT '电话号码',
  `EMAILS` varchar(100) DEFAULT NULL COMMENT '电子邮件',
  `DATE_OF_BIRTH` datetime DEFAULT NULL COMMENT '出生日期',
  `REGI_TIME` datetime DEFAULT NULL COMMENT '注册时间',
  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态 -1：删除 0：正常 1：未激活 2：注销',
  `OPERATION` varchar(2) DEFAULT NULL COMMENT '更新操作 01：新增 02：修改 99：删除',
  `REMARK` varchar(200) DEFAULT NULL COMMENT '更新备注',
  `ORG_ID` varchar(32) DEFAULT NULL COMMENT '所属组织id',
  PRIMARY KEY (`PERSON_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户中间表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c_accountinfo`
--

LOCK TABLES `c_accountinfo` WRITE;
/*!40000 ALTER TABLE `c_accountinfo` DISABLE KEYS */;
INSERT INTO `c_accountinfo` VALUES ('94cb2234-e1ff-427b-b9d1-b488dc8fd20e','1001_zhangwei','zhangwei','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','张伟','','0','1','2','','',NULL,'2021-02-01 17:36:02','0','01','','1001');
/*!40000 ALTER TABLE `c_accountinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar` (
  `CAL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户ID ',
  `CAL_TIME` int(10) unsigned NOT NULL COMMENT '开始时间 ',
  `END_TIME` int(10) unsigned NOT NULL COMMENT '结束时间 ',
  `CAL_TYPE` char(1) NOT NULL DEFAULT '' COMMENT '事务类型(1-工作事务,2-个人事务)',
  `CAL_LEVEL` char(1) NOT NULL DEFAULT '' COMMENT '优先级(1-重要/紧急,2-重要/不紧急,3-不重要/紧急,4-不重要/不紧急)',
  `CONTENT` text NOT NULL COMMENT '事务内容',
  `MANAGER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '安排人的用户ID',
  `OVER_STATUS` varchar(20) NOT NULL DEFAULT '' COMMENT '完成状态(0-未完成,1-已完成)',
  `BEFORE_REMAIND` varchar(20) NOT NULL COMMENT '提前提醒时间',
  `ADD_TIME` datetime NOT NULL COMMENT '新建时间',
  `OWNER` text NOT NULL COMMENT '所属者',
  `TAKER` text NOT NULL COMMENT '参与者',
  `ALLDAY` tinyint(3) unsigned NOT NULL COMMENT '全天',
  `FROM_MODULE` tinyint(3) unsigned NOT NULL COMMENT '从哪个模块添加的日程(1-外出,2-会议申请,3-工作计划,4-人力资源)',
  `URL` varchar(200) NOT NULL COMMENT '详情URL',
  `M_ID` int(11) NOT NULL COMMENT '关联的模块的id',
  `res_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应模块数据ID',
  UNIQUE KEY `ID` (`CAL_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `MANAGER_ID` (`MANAGER_ID`) USING BTREE,
  KEY `CAL_TIME_2` (`CAL_TIME`) USING BTREE,
  KEY `END_TIME_2` (`END_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='日程安排-我的日程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar`
--

LOCK TABLES `calendar` WRITE;
/*!40000 ALTER TABLE `calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calendar_leader_priv`
--

DROP TABLE IF EXISTS `calendar_leader_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendar_leader_priv` (
  `priv_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `managers` text COMMENT '领导的user_Id串',
  `query_priv_users` text COMMENT '有查询权限人员的user_id串',
  `edit_priv_users` text COMMENT '有编辑权限人员的user_id串',
  PRIMARY KEY (`priv_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='领导日程权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendar_leader_priv`
--

LOCK TABLES `calendar_leader_priv` WRITE;
/*!40000 ALTER TABLE `calendar_leader_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_leader_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacity_channel_info`
--

DROP TABLE IF EXISTS `capacity_channel_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capacity_channel_info` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CHNL_IDENTITY` varchar(255) DEFAULT NULL COMMENT '栏目标识',
  `CHNL_NAME` varchar(255) DEFAULT NULL COMMENT '显示名称',
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CR_USERID` int(11) DEFAULT NULL COMMENT '创建人id',
  `CR_USERNAME` varchar(255) DEFAULT NULL COMMENT '创建人姓名',
  `DEL_FLAG` int(11) DEFAULT NULL COMMENT '1：回收站  0：正常',
  `DETAIL_TPL` int(11) DEFAULT NULL COMMENT '细览模板ID',
  `FOLDER` varchar(255) DEFAULT NULL COMMENT '存放位置',
  `INDEX_TPL` int(11) DEFAULT NULL COMMENT '首页模板ID',
  `PARENT_CHNL` int(11) DEFAULT NULL COMMENT '父栏目ID',
  `PATH` varchar(255) DEFAULT NULL COMMENT '栏目层级路径',
  `SITE_ID` int(11) DEFAULT NULL COMMENT '站点ID',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',
  `STATUS` int(11) DEFAULT NULL COMMENT '1：允许发布 2：禁止发布',
  `PAGE_SIZE` int(11) DEFAULT '0' COMMENT '分页大小',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacity_channel_info`
--

LOCK TABLES `capacity_channel_info` WRITE;
/*!40000 ALTER TABLE `capacity_channel_info` DISABLE KEYS */;
INSERT INTO `capacity_channel_info` VALUES (4,'xwzx','新闻中心','2014-05-29 11:33:00',4,'admin',0,11,'xwzx',10,0,'/4.ch',1,3,1,0),(5,'qjmm','全景本省','2014-05-29 11:33:14',4,'admin',0,12,'qjmm',12,0,'/5.ch',1,4,1,0),(6,'zfxxgk','政府信息公开','2014-05-29 11:33:28',4,'admin',0,1,'zfxxgk',1,0,'/6.ch',1,5,1,0),(7,'ggfw','公共服务','2014-05-29 11:33:42',4,'admin',0,13,'ggfw',13,0,'/7.ch',1,6,1,0),(28,'jlhd','交流互动','2014-06-08 15:43:28',4,'admin',0,14,'jlhd',14,0,'/28.ch',1,7,1,0),(29,'zfbm','政府部门','2014-06-08 15:43:51',4,'admin',0,15,'zfbm',15,0,'/29.ch',1,8,1,0),(30,'aboutUs','关于我们','2014-08-16 16:04:21',4,'admin',0,8,'about',9,0,'/30.ch',2,1,1,0),(31,'serverContent','服务内容','2014-08-16 16:04:35',4,'admin',0,8,'content',9,0,'/31.ch',2,2,1,0),(32,'news','新闻资讯','2014-08-16 16:04:56',4,'admin',0,7,'news',6,0,'/32.ch',2,3,1,0),(34,'rczp','人才招聘','2014-08-16 16:06:10',4,'admin',0,8,'rczp',9,0,'/34.ch',2,5,1,0),(35,'contact','联系我们','2014-08-16 16:06:20',4,'admin',0,8,'contact',9,0,'/35.ch',2,6,1,0),(36,'zxly','在线留言','2014-08-16 16:06:32',4,'admin',1,5,'zxly',5,0,'/36.ch',2,7,1,0),(37,'companyNews','公司新闻','2015-09-16 22:21:13',4,'admin',0,7,'companyNews',6,32,'/32.ch/37.ch',2,1,1,0),(38,'hydt','行业动态','2015-09-16 22:21:48',4,'admin',0,7,'hydt',6,32,'/32.ch/38.ch',2,2,1,0);
/*!40000 ALTER TABLE `capacity_channel_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacity_chnldoc`
--

DROP TABLE IF EXISTS `capacity_chnldoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capacity_chnldoc` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `CHNL_ID` int(11) DEFAULT NULL,
  `CR_TIME` datetime DEFAULT NULL,
  `DEL_FLAG` int(11) DEFAULT NULL,
  `DOC_ID` int(11) DEFAULT NULL,
  `PATH` varchar(255) DEFAULT NULL,
  `PUB_TIME` datetime DEFAULT NULL,
  `SORT_NO` int(11) DEFAULT NULL,
  `TOP_` int(11) DEFAULT NULL COMMENT '//置顶  0：不置顶  1：置顶  2：限时置顶',
  `TYPE` int(11) DEFAULT NULL COMMENT '//1：原始数据 2：引用',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacity_chnldoc`
--

LOCK TABLES `capacity_chnldoc` WRITE;
/*!40000 ALTER TABLE `capacity_chnldoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `capacity_chnldoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacity_document_category`
--

DROP TABLE IF EXISTS `capacity_document_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capacity_document_category` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `PRIV_` int(11) DEFAULT NULL COMMENT '//权限值   1，2，4，8，16，……',
  `CAT_NAME_` varchar(255) DEFAULT NULL COMMENT '//分类名称',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacity_document_category`
--

LOCK TABLES `capacity_document_category` WRITE;
/*!40000 ALTER TABLE `capacity_document_category` DISABLE KEYS */;
INSERT INTO `capacity_document_category` VALUES (1,1,'幻灯'),(2,2,'头条'),(3,4,'推荐'),(4,8,'滚动'),(5,16,'图片');
/*!40000 ALTER TABLE `capacity_document_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacity_document_info`
--

DROP TABLE IF EXISTS `capacity_document_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capacity_document_info` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `ABSTRACTS` varchar(255) DEFAULT NULL COMMENT '摘要',
  `AUTHOR` varchar(255) DEFAULT NULL COMMENT '作者',
  `CHNL_ID` int(11) DEFAULT NULL,
  `CONTENT` longtext COMMENT '内容',
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CR_USERID` int(11) DEFAULT NULL,
  `CR_USERNAME` varchar(255) DEFAULT NULL,
  `DOC_TITLE` varchar(255) DEFAULT NULL,
  `HTML_CONTENT` longtext COMMENT 'html内容',
  `KEY_WORDS` varchar(255) DEFAULT NULL COMMENT '关键词',
  `MAIN_TITLE` varchar(255) DEFAULT NULL COMMENT '主标题',
  `PUB_TIME` datetime DEFAULT NULL COMMENT '发布时间',
  `SOURCE` varchar(255) DEFAULT NULL COMMENT '来源',
  `STATUS` int(11) DEFAULT NULL COMMENT '1、新稿 2、已编 3、返工 4、已否 5、已签 6、正审',
  `SUB_TITLE` varchar(255) DEFAULT NULL COMMENT '子标题',
  `WRITE_TIME` datetime DEFAULT NULL COMMENT '撰写时间',
  `THUMBNAIL_` int(11) DEFAULT '0',
  `CATEGORY_` int(11) DEFAULT '0' COMMENT '自定义分类',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacity_document_info`
--

LOCK TABLES `capacity_document_info` WRITE;
/*!40000 ALTER TABLE `capacity_document_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `capacity_document_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capacity_site_info`
--

DROP TABLE IF EXISTS `capacity_site_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `capacity_site_info` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CR_USERID` int(11) DEFAULT NULL COMMENT '创建人id',
  `CR_USERNAME` varchar(255) DEFAULT NULL COMMENT '创建人名称',
  `DETAIL_TPL` int(11) DEFAULT NULL COMMENT '细览模版',
  `FOLDER` varchar(255) DEFAULT NULL COMMENT '存放位置',
  `INDEX_TPL` int(11) DEFAULT NULL COMMENT '首页模版，关联模版id',
  `PUB_PATH` varchar(255) DEFAULT NULL COMMENT '发布路径',
  `PUB_STATUS` int(11) DEFAULT NULL COMMENT '发布状态',
  `SITE_IDENTITY` varchar(255) DEFAULT NULL COMMENT '站点标识',
  `SITE_NAME` varchar(255) DEFAULT NULL COMMENT '站点名称',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',
  `PUB_FILE_EXT` varchar(255) DEFAULT 'html' COMMENT '//发布页面后缀名   html  jsp  php  aspx',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capacity_site_info`
--

LOCK TABLES `capacity_site_info` WRITE;
/*!40000 ALTER TABLE `capacity_site_info` DISABLE KEYS */;
INSERT INTO `capacity_site_info` VALUES (1,'2014-10-01 20:14:14',4,'admin',4,'D:\\zwmh',1,NULL,0,'zwmh','政务门户',1,'html'),(2,'2015-09-14 18:00:26',4,'admin',5,'D:\\qymh',5,NULL,0,'qymh','企业门户',2,'html');
/*!40000 ALTER TABLE `capacity_site_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cas_config`
--

DROP TABLE IF EXISTS `cas_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cas_config` (
  `CAS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CAS_NAME` varchar(255) NOT NULL COMMENT '单点登录名称',
  `CAS_ADDRESS` varchar(255) NOT NULL COMMENT '单点登录服务器地址',
  `CAS_STATUS` char(1) NOT NULL DEFAULT '0' COMMENT '单点登录是否开启（0-关闭    1开启）',
  `CAS_TIME` datetime NOT NULL COMMENT '最后一次保存日期',
  `CAS_USER` varchar(255) NOT NULL COMMENT '最后一次保存人员',
  `CAS_LOGIN_ORG` varchar(255) NOT NULL COMMENT '登录OA组织  （例如：1001、1002 ）',
  `CAS_INTERFACE` varchar(255) DEFAULT NULL COMMENT '心通达OA单点登录接口地址(如GsuboSso/ssoLogin),过滤器不拦截',
  PRIMARY KEY (`CAS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cas_config`
--

LOCK TABLES `cas_config` WRITE;
/*!40000 ALTER TABLE `cas_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `cas_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `censor_data`
--

DROP TABLE IF EXISTS `censor_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `censor_data` (
  `DATA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `MODULE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '对应的模块代码',
  `CENSOR_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '审核标记(0-待审核,1-审核通过,2-审核未通过)',
  `CHECK_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '审核人',
  `CHECK_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',
  `CONTENT` mediumtext NOT NULL COMMENT '审核意见',
  PRIMARY KEY (`DATA_ID`) USING BTREE,
  KEY `MODULE_CODE` (`MODULE_CODE`) USING BTREE,
  KEY `CHECK_USER` (`CHECK_USER`) USING BTREE,
  KEY `CHECK_TIME` (`CHECK_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='敏感词语待审核数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `censor_data`
--

LOCK TABLES `censor_data` WRITE;
/*!40000 ALTER TABLE `censor_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `censor_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `censor_module`
--

DROP TABLE IF EXISTS `censor_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `censor_module` (
  `MODULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `MODULE_CODE` varchar(20) DEFAULT '' COMMENT '模块代码',
  `USE_FLAG` char(1) DEFAULT '1' COMMENT '启用过滤(1-启用,0-不启用)',
  `CHECK_USER` text COMMENT '审核人员',
  `SMS_REMIND` varchar(20) DEFAULT '1' COMMENT '内部短信提醒标识',
  `SMS2_REMIND` varchar(20) DEFAULT '0' COMMENT '手机短信提醒标识',
  `BANNED_HINT` varchar(255) DEFAULT '' COMMENT '禁止提示',
  `MOD_HINT` varchar(255) DEFAULT '' COMMENT '审核提示',
  `FILTER_HINT` varchar(255) DEFAULT '' COMMENT '过滤提示',
  PRIMARY KEY (`MODULE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='敏感词语过滤模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `censor_module`
--

LOCK TABLES `censor_module` WRITE;
/*!40000 ALTER TABLE `censor_module` DISABLE KEYS */;
INSERT INTO `censor_module` VALUES (1,'0101','0','admin,','1','0','','','');
/*!40000 ALTER TABLE `censor_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `censor_words`
--

DROP TABLE IF EXISTS `censor_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `censor_words` (
  `WORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '添加人',
  `FIND` varchar(255) NOT NULL DEFAULT '' COMMENT '不良词语',
  `REPLACEMENT` varchar(255) NOT NULL DEFAULT '' COMMENT '替换词语',
  PRIMARY KEY (`WORD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='敏感词语定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `censor_words`
--

LOCK TABLES `censor_words` WRITE;
/*!40000 ALTER TABLE `censor_words` DISABLE KEYS */;
/*!40000 ALTER TABLE `censor_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coes_staff_register`
--

DROP TABLE IF EXISTS `coes_staff_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coes_staff_register` (
  `REG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `MOBIL_NO` varchar(50) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ID_NUMBER` varchar(50) NOT NULL DEFAULT '' COMMENT '身份证号码',
  `COMPANY` varchar(255) NOT NULL DEFAULT '' COMMENT '单位',
  `POST` varchar(255) NOT NULL DEFAULT '' COMMENT '岗位',
  `STAFF_TYPE` varchar(50) NOT NULL DEFAULT '' COMMENT '人员类型',
  `ROOM_NUMBER` varchar(255) NOT NULL DEFAULT '' COMMENT '房间号',
  `BOAT_NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '船名/项目',
  `BOARD_TIME` datetime DEFAULT NULL COMMENT '登船时间',
  `BOARD_SCAN_TIME` datetime DEFAULT NULL COMMENT '登船扫描时间',
  `BOARD_ADDRESS` varchar(255) NOT NULL DEFAULT '' COMMENT '登船地点',
  `ASHORE_TIME` datetime DEFAULT NULL COMMENT '离船时间',
  `ASHORE_SCAN_TIME` datetime DEFAULT NULL COMMENT '离船扫描时间',
  `ASHORE_ADDRESS` varchar(255) NOT NULL DEFAULT '' COMMENT '离船地点',
  `BOARD_DAYS` varchar(50) NOT NULL DEFAULT '' COMMENT '在船天数',
  PRIMARY KEY (`REG_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='人员登记管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coes_staff_register`
--

LOCK TABLES `coes_staff_register` WRITE;
/*!40000 ALTER TABLE `coes_staff_register` DISABLE KEYS */;
/*!40000 ALTER TABLE `coes_staff_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comlicense_info`
--

DROP TABLE IF EXISTS `comlicense_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comlicense_info` (
  `LICENSE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `LICENSE_NO` varchar(100) NOT NULL COMMENT '证照注册编号',
  `LICENSE_NAME` varchar(255) DEFAULT '' COMMENT '证照名称',
  `LICENSE_TYPE` int(11) DEFAULT NULL COMMENT '证照类型（证照类型表中取id）',
  `LICENSE_STATUS` varchar(10) DEFAULT '1' COMMENT '证照状态（0-无效，1-有效）',
  `VALIDITY_BEGIN_DATE` date DEFAULT NULL COMMENT '有效期的开始日期',
  `VALIDITY_END_DATE` date DEFAULT NULL COMMENT '有效期的结束日期',
  `VALIDITY_YEAR` varchar(10) DEFAULT '' COMMENT '有效年限',
  `INSSUE_DATE` date DEFAULT NULL COMMENT '发证日期',
  `ANNUAL_INSPECTION_DATE` date DEFAULT NULL COMMENT '年检日期',
  `ISSUE_UNIT` varchar(100) DEFAULT NULL COMMENT '发证单位',
  `REMARK` text COMMENT '备注',
  `ATTACHMENT_ID` text COMMENT '证照附件ID',
  `ATTACHMENT_NAME` text COMMENT '证照附件名称',
  `VERSION_ID` int(11) NOT NULL COMMENT '版本id号',
  PRIMARY KEY (`LICENSE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='证照信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comlicense_info`
--

LOCK TABLES `comlicense_info` WRITE;
/*!40000 ALTER TABLE `comlicense_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `comlicense_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comlicense_type`
--

DROP TABLE IF EXISTS `comlicense_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comlicense_type` (
  `LICENSE_TYPE` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `LICENSE_TYPE_NAME` varchar(255) NOT NULL COMMENT '证照类型',
  `REMARK` text COMMENT '备注',
  `LICENSE_TYPE_NO` varchar(10) DEFAULT NULL COMMENT '证照类型序号',
  PRIMARY KEY (`LICENSE_TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='证照类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comlicense_type`
--

LOCK TABLES `comlicense_type` WRITE;
/*!40000 ALTER TABLE `comlicense_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `comlicense_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comlicense_use`
--

DROP TABLE IF EXISTS `comlicense_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comlicense_use` (
  `LICENSE_USE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增id',
  `LEND_TITLE` varchar(255) DEFAULT NULL COMMENT '借阅标题',
  `APPROVAL_USER` varchar(50) DEFAULT NULL COMMENT '申请人',
  `APPROVAL_DEPT` int(11) DEFAULT NULL COMMENT '申请人所在部门',
  `CUSTOMER` varchar(200) DEFAULT NULL COMMENT '客户名称',
  `URGENCY` varchar(10) DEFAULT NULL COMMENT ' 紧急程度（0-普通，1-紧急，2-非常紧急）',
  `USE_REASON` text COMMENT '借阅理由',
  `LICENSE_IDS` text COMMENT '借阅证照id,可能有多个',
  `USE_TIME` datetime DEFAULT NULL COMMENT '借阅时间',
  `PLAN_RETURN_TIME` datetime DEFAULT NULL COMMENT '计划归还时间',
  `REAL_RETURN_TIME` datetime DEFAULT NULL COMMENT '实际归还时间',
  `APPROVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '审核状态（0-未审核，1-待审核，2-已审核）',
  `REVIEWER` varchar(50) DEFAULT NULL COMMENT '审核人',
  `SENDER` varchar(50) DEFAULT NULL COMMENT '寄件人',
  `ADDRESSEE` varchar(100) DEFAULT NULL COMMENT '收件人',
  `COURIER_NUM` varchar(100) DEFAULT NULL COMMENT '快递单号',
  `DISPATCH_TIME` datetime DEFAULT NULL COMMENT '寄件时间',
  `MAIL_ADDRESS` varchar(255) DEFAULT NULL COMMENT '寄件地址（收货人地址）',
  `USE_STATUS` varchar(10) DEFAULT NULL COMMENT '借阅状态（0-未借出，1-已借出，2-已归还）',
  PRIMARY KEY (`LICENSE_USE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='证照使用借阅表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comlicense_use`
--

LOCK TABLES `comlicense_use` WRITE;
/*!40000 ALTER TABLE `comlicense_use` DISABLE KEYS */;
/*!40000 ALTER TABLE `comlicense_use` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comlicense_version`
--

DROP TABLE IF EXISTS `comlicense_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comlicense_version` (
  `VERSION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '版本号，主键自增',
  `LICENSE_ID` int(11) NOT NULL COMMENT '证照表的主键id',
  `CREATE_TIME` datetime NOT NULL COMMENT '版本创建时间',
  `VERSION_NAME` varchar(255) DEFAULT '' COMMENT '版本名称',
  `VERSION_EXPLAIN` text COMMENT '版本说明',
  `LICENSE_NAME` varchar(255) DEFAULT '' COMMENT '证照名称',
  `LICENSE_TYPE` varchar(50) DEFAULT '' COMMENT '证照类型（证照类型表中取id）',
  `VALIDITY_BEGIN_DATE` date DEFAULT NULL COMMENT '有效期的开始日期',
  `VALIDITY_END_DATE` date DEFAULT NULL COMMENT '有效期的结束日期',
  `VALIDITY_YEAR` varchar(10) DEFAULT '' COMMENT '有效年限',
  `INSSUE_DATE` date DEFAULT NULL COMMENT '发证日期',
  `ANNUAL_INSPECTION_DATE` date DEFAULT NULL COMMENT '年检日期',
  `ISSUE_UNIT` varchar(100) DEFAULT NULL COMMENT '发证单位',
  `REMARK` text COMMENT '备注',
  `ATTACHMENT_ID` text COMMENT '证照附件ID',
  `ATTACHMENT_NAME` text COMMENT '证照附件名称',
  PRIMARY KEY (`VERSION_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='证照日志记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comlicense_version`
--

LOCK TABLES `comlicense_version` WRITE;
/*!40000 ALTER TABLE `comlicense_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `comlicense_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_bidding_info`
--

DROP TABLE IF EXISTS `crm_bidding_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_bidding_info` (
  `BIDDING_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `PROJECT_NO` varchar(100) DEFAULT NULL COMMENT '项目编号',
  `PROJECT_NAME` varchar(100) DEFAULT NULL COMMENT '项目名称',
  `PROJECT_YEAR` varchar(100) DEFAULT NULL COMMENT '项目年度',
  `PURCHASE_DEPTID` int(11) DEFAULT NULL COMMENT '采购部门',
  `INFO_DESC` text COMMENT '详细要求',
  `RELEASE_DATE` date DEFAULT NULL COMMENT '发布日期',
  `BIDDING_BEGIN_DATE` date DEFAULT NULL COMMENT '投标开始日期',
  `BIDDING_END_DATE` date DEFAULT NULL COMMENT '投标结束日期',
  `ATTACHMENT_ID` text COMMENT '招标文件ID串',
  `ATTACHMENT_NAME` text COMMENT '招标文件NAME串',
  `STATUS` char(10) DEFAULT NULL COMMENT '状态（1-未发布，2-已发布，3-开标中，4-结束）',
  `RELEASE_USERID` varchar(50) DEFAULT NULL COMMENT '发布人',
  `TENDER_USERID` text COMMENT '投标人',
  `VIEW_USERID` text COMMENT '查看人',
  PRIMARY KEY (`BIDDING_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='招标信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_bidding_info`
--

LOCK TABLES `crm_bidding_info` WRITE;
/*!40000 ALTER TABLE `crm_bidding_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_bidding_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_certificate`
--

DROP TABLE IF EXISTS `crm_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_certificate` (
  `CERT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CONTACT_PERSON` varchar(100) DEFAULT NULL COMMENT '联系人（手机）',
  `PHONE` varchar(100) DEFAULT NULL COMMENT '联系电话（座机）',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `PROFESSION` varchar(100) DEFAULT NULL COMMENT '相关专业',
  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',
  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '地址详情',
  `LAW_NAME` varchar(100) DEFAULT NULL COMMENT '法人',
  `CONTRACT_NO` text COMMENT '合同编号',
  `ATTACHMENT_ID` text COMMENT '附件Id(证件照)',
  `ATTACHMENT_NAME` text COMMENT '附件名称(证件照)',
  `CERT_NO` text COMMENT '证件照编号',
  `CERT_NUMBER` text COMMENT '证件号码',
  `CERT_NAME` text COMMENT '证件照名称',
  `CERT_START_TIME` datetime DEFAULT NULL COMMENT '证件照起始时间',
  `CERT_END_TIME` datetime DEFAULT NULL COMMENT '证件照截止时间',
  `REMARK` text COMMENT '备注',
  `REMIND_TIME` datetime DEFAULT NULL COMMENT '提醒时间（可以提前一个月提醒）',
  `SUPPLIER_USER` varchar(100) DEFAULT NULL COMMENT '供应商userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '成立时间',
  `IS_REMIND` varchar(10) NOT NULL DEFAULT '0' COMMENT '是否提醒（0-未提醒，1-已提醒）',
  `COMPANY_NAME` varchar(100) DEFAULT NULL COMMENT '公司名称',
  PRIMARY KEY (`CERT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='资格证书管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_certificate`
--

LOCK TABLES `crm_certificate` WRITE;
/*!40000 ALTER TABLE `crm_certificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_contract`
--

DROP TABLE IF EXISTS `crm_contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_contract` (
  `CONTRACT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售合同表唯一自增主键',
  `CONTRACT_NO` varchar(40) DEFAULT NULL COMMENT '合同编号',
  `CONTRACT_NAME` varchar(40) NOT NULL COMMENT '合同名称',
  `CUSTOMER_ID` int(11) unsigned DEFAULT NULL COMMENT '所属客户，关联客户信息表主键',
  `TYPE` char(10) DEFAULT NULL COMMENT '合同类型|系统代码表：01-产品销售；02-服务；03-合作；04-代理；05-其他；',
  `STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '合同状态：0-执行中;1-结束;2-意外终止;',
  `TOTAL` decimal(10,0) DEFAULT NULL COMMENT '总金额',
  `TOTAL_CAPS` varchar(40) DEFAULT NULL COMMENT '总金额大写',
  `RECEIVED_MONEY` decimal(10,0) DEFAULT NULL COMMENT '已收款',
  `PAY_WAY` char(10) DEFAULT NULL COMMENT '支付方式|系统代码表：01-现金；02-转账；03-支票；04-支付宝；05-微信；06-其他；',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `VALID_TIME` datetime DEFAULT NULL COMMENT '合同有效期',
  `REMIND_EXPIRE` tinyint(3) unsigned DEFAULT NULL COMMENT '到期事务提醒：0-否；1-是；',
  `REMIND_EXPIRE_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '到期短信提醒：0-否；1-是；',
  `RECIEVE_TIME` datetime DEFAULT NULL COMMENT '收款时间',
  `DELIVER_TIME` datetime DEFAULT NULL COMMENT '交付时间',
  `REMIND_RECIEVE` tinyint(3) unsigned DEFAULT NULL COMMENT '收款事务提醒：0-否；1-是；',
  `REMIND_RECIEVE_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '收款短信提醒：0-否；1-是；',
  `REMIND_DELIVER` tinyint(3) unsigned DEFAULT NULL COMMENT '交付事务提醒：0-否；1-是；',
  `REMIND_DELIVER_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '交付短信提醒：0-否；1-是；',
  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '合同内容',
  `FIST_PARTY_SIGN_TIME` datetime DEFAULT NULL COMMENT '甲方签约时间',
  `FIST_PARTY` varchar(40) DEFAULT NULL COMMENT '甲方',
  `SECOND_PARTY_SIGN_TIME` datetime DEFAULT NULL COMMENT '乙方签约时间',
  `SECOND_PARTY` varchar(40) DEFAULT NULL COMMENT '乙方',
  `ITEM` varchar(100) DEFAULT NULL COMMENT '项目，关联项目模块',
  `APPROVAL_STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '审批状态：0-待审批;1-已通过;2-已驳回;',
  `APPROVAL_USER` varchar(40) DEFAULT NULL COMMENT '审批人 userId',
  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `APPROVAL_ADVICE` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  `EXTERNAL_CUSTOMER` varchar(200) DEFAULT NULL COMMENT '外部客户',
  PRIMARY KEY (`CONTRACT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_contract`
--

LOCK TABLES `crm_contract` WRITE;
/*!40000 ALTER TABLE `crm_contract` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_customer`
--

DROP TABLE IF EXISTS `crm_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_customer` (
  `CUSTOMER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户信息表唯一自增主键',
  `CUSTOMER_NO` varchar(100) DEFAULT NULL COMMENT '客户编号',
  `CUSTOMER_NAME` varchar(100) NOT NULL COMMENT '客户名称',
  `CUSTOMER_MANAGER` varchar(40) DEFAULT NULL COMMENT '客户经理',
  `CUSTOMER_TYPE` char(10) DEFAULT NULL COMMENT '客户类型|系统代码表：\r\n1 潜在客户 2正式客户 3重要客户\r\n',
  `CUSTOMER_STATUS` char(10) DEFAULT NULL COMMENT '客户状态|系统代码表：\r\n01初步接触 02客户拜访 03需求沟通  04方案报价  05 商务谈判 06签约成功06业务暂缓\r\n',
  `CUSTOMER_FROM` char(10) DEFAULT NULL COMMENT '客户来源|系统代码表：\r\n01广告推广 02会议营销 03客户介绍 04网上搜索 05渠道拓展 06伙伴介绍 07独立开发 08社群营销\r\n',
  `CUSTOMER_LEVEL` char(10) DEFAULT NULL COMMENT '客户级别|系统代码表：\r\n01 A类重要客户  02 B类普通客户  03 C类一般客户 04  D类不重要客户\r\n',
  `CUSTOMER_INDUSTRY` char(10) DEFAULT NULL COMMENT '客户行业|系统代码表：\r\n01 农、林、牧、渔业 02 采矿业 03 制造业 04 电力、燃气及水的生产和供应业 05 建筑业 06 交通运输、仓储和邮政业 07 信息传输、计算机服务和软件业 08 批发和零售业 09 住宿和餐饮业 10 金融业 11 房地产业 12 租赁和商务服务业 13 科学研究、技术服务和地质勘查业 14 水利、环境和公共设施管理业 15 居民服务和其他服务业 \r\n16 教育 17 卫生和社会工作 18 文化、体育和娱乐业 19 公共管理、社会保障和社会组织 20 国际组织 21 政务机关、事业单位\r\n',
  `LEGAL_PERSON` varchar(40) DEFAULT NULL COMMENT '企业法人',
  `SCALE` char(10) DEFAULT NULL COMMENT '公司规模|系统代码表：\r\n01微型(10人以下) 02小型(10-100人) 03中型(500-1000人) 04中小型(100-500人) 05大型(1000人以上)\r\n',
  `ANNUAL_SALES` varchar(50) DEFAULT NULL COMMENT '年销售额',
  `INTRODUCTION` text COMMENT '企业介绍',
  `EXPECT_PRICE` varchar(50) DEFAULT NULL COMMENT '预计成交金额',
  `EXPECT_TIME` datetime DEFAULT NULL COMMENT '预计成交日期',
  `FAX` varchar(200) DEFAULT NULL COMMENT '传真号码',
  `WEBSITE` varchar(200) DEFAULT NULL COMMENT '公司网址',
  `ZIP_CODE` varchar(50) DEFAULT NULL COMMENT '邮政编码',
  `EMAIL` varchar(200) DEFAULT NULL COMMENT '电子邮箱',
  `ADDRESS` varchar(200) DEFAULT NULL COMMENT '公司地址',
  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',
  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',
  `LNG` varchar(20) DEFAULT NULL COMMENT '经度，用于地图选点',
  `LAT` varchar(20) DEFAULT NULL COMMENT '纬度，用于地图选点',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` char(10) DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` text COMMENT '允许查看人员：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  `PRODUCT_ID` int(11) DEFAULT NULL COMMENT '自有产品id',
  `HEADQUARTERS_CITY` varchar(100) DEFAULT NULL COMMENT '总部城市',
  `CUSTOMER_PRODUCTS` varchar(255) DEFAULT NULL COMMENT '客户产品',
  `BUSINESS_MODULE` varchar(255) DEFAULT NULL COMMENT '业务模块',
  `HOT_CONCEPT` varchar(255) DEFAULT NULL COMMENT '热点概念',
  `REGISTERED_CAPITAL` varchar(255) DEFAULT NULL COMMENT '注册资金',
  `REGISTERED_DATE` varchar(100) DEFAULT NULL COMMENT '注册时间',
  `REMARK` text COMMENT '备注',
  PRIMARY KEY (`CUSTOMER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_customer`
--

LOCK TABLES `crm_customer` WRITE;
/*!40000 ALTER TABLE `crm_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_diary_setting`
--

DROP TABLE IF EXISTS `crm_diary_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_diary_setting` (
  `diary_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `user_priv` text NOT NULL COMMENT '用户权限编号',
  `diary_table` text NOT NULL COMMENT '模块权限列表',
  `all_select` int(11) NOT NULL COMMENT '是否选择了全部模块',
  PRIMARY KEY (`diary_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='日志权限设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_diary_setting`
--

LOCK TABLES `crm_diary_setting` WRITE;
/*!40000 ALTER TABLE `crm_diary_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_diary_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_evaluate`
--

DROP TABLE IF EXISTS `crm_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_evaluate` (
  `EV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `USER_ID` varchar(50) NOT NULL COMMENT '被评价人',
  `EV_LEVEL` char(10) NOT NULL COMMENT '综合评价(1优秀，2合格，3不合格)',
  `SUPPLY_QUALITY` int(11) NOT NULL COMMENT '供货质量',
  `SUPPLY_CAPACITY` int(11) NOT NULL COMMENT '供货能力',
  `BIDDING_PROJECT` varchar(255) NOT NULL COMMENT '招标项目',
  `EV_DETAIL` text COMMENT '详细评价',
  `EV_USER` varchar(50) NOT NULL COMMENT '评价人',
  `EV_TIME` datetime NOT NULL COMMENT '评价时间',
  `ATTACHMENT_ID` text COMMENT '附件id串',
  `ATTACHMENT_NAME` text COMMENT '附件name串',
  PRIMARY KEY (`EV_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='供应商评价表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_evaluate`
--

LOCK TABLES `crm_evaluate` WRITE;
/*!40000 ALTER TABLE `crm_evaluate` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_evaluate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_evaluate_priv`
--

DROP TABLE IF EXISTS `crm_evaluate_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_evaluate_priv` (
  `PRIV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `EVALUATE_USERS` text COMMENT '查看或评价人',
  `PRIV_USERS` text COMMENT '被查看或被评价人',
  `PRIV_DEPTS` text COMMENT '被查看或被评价部门',
  `PRIV_TYPE` varchar(10) DEFAULT NULL COMMENT '类型（1-查看权限，2-评价权限）',
  PRIMARY KEY (`PRIV_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评价权限设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_evaluate_priv`
--

LOCK TABLES `crm_evaluate_priv` WRITE;
/*!40000 ALTER TABLE `crm_evaluate_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_evaluate_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_follow`
--

DROP TABLE IF EXISTS `crm_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_follow` (
  `FOLLOW_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户跟进表唯一自增主键',
  `FOLLOW_NO` varchar(100) DEFAULT NULL COMMENT '客户跟进编号',
  `CUSTOMER_ID` int(11) unsigned NOT NULL COMMENT '客户id，关联客户信息表主键',
  `FOLLOW_TYPE` char(10) DEFAULT NULL COMMENT '跟进方式|系统代码表:01-电话；02-短信；03-微信；04-QQ；05-会面；',
  `FOLLOW_TIME` datetime DEFAULT NULL COMMENT '跟进时间',
  `FOLLOW_SITUATION` varchar(500) DEFAULT NULL COMMENT '跟进情况',
  `PICTURE` varchar(200) DEFAULT NULL COMMENT '跟进图片',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '跟进地点',
  `LNG` varchar(20) DEFAULT NULL COMMENT '经度，用于地图选点',
  `LAT` varchar(20) DEFAULT NULL COMMENT '纬度，用于地图选点',
  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',
  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',
  `FEEDBACK` varchar(500) DEFAULT NULL COMMENT '需求反馈',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  `NEXT_FOLLOW_TIME` datetime DEFAULT NULL COMMENT '下次跟进时间',
  PRIMARY KEY (`FOLLOW_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_follow`
--

LOCK TABLES `crm_follow` WRITE;
/*!40000 ALTER TABLE `crm_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_linkman`
--

DROP TABLE IF EXISTS `crm_linkman`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_linkman` (
  `LINKMAN_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户联系人表唯一自增主键',
  `LINKMAN_NAME` varchar(20) NOT NULL COMMENT '联系人姓名',
  `CUSTOMER_ID` int(11) DEFAULT NULL COMMENT '所属客户，关联客户信息表主键',
  `IS_MAJOR` tinyint(3) unsigned DEFAULT NULL COMMENT '是否主联系人：0-否；1-是；',
  `JOB` varchar(20) DEFAULT NULL COMMENT '联系人职务',
  `DEPARTMENT` varchar(20) DEFAULT NULL COMMENT '联系人部门',
  `SEX` tinyint(3) unsigned DEFAULT '0' COMMENT '联系人性别：0-未知;1-男;2-女;(默认未知)',
  `CALL` varchar(20) DEFAULT NULL COMMENT '联系人称呼',
  `TITLE` varchar(40) DEFAULT NULL COMMENT '联系人头衔',
  `HOBBY` varchar(200) DEFAULT NULL COMMENT '联系人爱好',
  `BIRTHDAY` datetime DEFAULT NULL COMMENT '联系人出生日期',
  `FIRST_CONTACT` char(10) DEFAULT NULL COMMENT '首选联系方式|系统代码表：\r\n01电话联系 02邮件联系 03微信联系 04 QQ联系 05短信联系\r\n',
  `MOBILE` varchar(20) DEFAULT NULL COMMENT '联系人手机',
  `EMAIL` varchar(40) DEFAULT NULL COMMENT '联系人邮箱',
  `WECHAT` varchar(40) DEFAULT NULL COMMENT '联系人微信',
  `QQ` varchar(20) DEFAULT NULL COMMENT '联系人qq',
  `COMPANY_PHONE` varchar(20) DEFAULT NULL COMMENT '联系人公司电话',
  `FAMILY_PHONE` varchar(20) DEFAULT NULL COMMENT '联系人家庭电话',
  `COMPANY_ADDRESS` varchar(100) DEFAULT NULL COMMENT '联系人公司地址',
  `FAMILY_ADDRESS` varchar(100) DEFAULT NULL COMMENT '联系人家庭住址',
  `COMPANY_ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '联系人公司邮编',
  `FAMILY_ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '联系人家庭邮编',
  `RELATIONSHIP` varchar(40) DEFAULT NULL COMMENT '角色关系',
  `FRIENDSHIP` varchar(20) DEFAULT NULL COMMENT '亲密程度',
  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  `PHOTO` varchar(200) DEFAULT NULL COMMENT '照片',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  PRIMARY KEY (`LINKMAN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_linkman`
--

LOCK TABLES `crm_linkman` WRITE;
/*!40000 ALTER TABLE `crm_linkman` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_linkman` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_manager`
--

DROP TABLE IF EXISTS `crm_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_manager` (
  `MID` int(11) NOT NULL AUTO_INCREMENT,
  `MANAGER_ID` text COMMENT '主管用户名串',
  `SALES_ID` text COMMENT '下属id',
  PRIMARY KEY (`MID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_manager`
--

LOCK TABLES `crm_manager` WRITE;
/*!40000 ALTER TABLE `crm_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_order`
--

DROP TABLE IF EXISTS `crm_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_order` (
  `ORDER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售订单表唯一自增主键',
  `ORDER_NO` varchar(40) DEFAULT NULL COMMENT '订单编号',
  `CUSTOMER_ID` int(11) unsigned DEFAULT NULL COMMENT '客户ID，关联客户信息表主键',
  `ORDER_NAME` varchar(40) NOT NULL COMMENT '订单名称',
  `STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '订单状态：0-下单;1-发货;2-完成;',
  `TYPE` tinyint(3) unsigned DEFAULT NULL COMMENT '订单类型：0-订货单;1-发货单;2-收货单;',
  `TOTAL` decimal(10,0) DEFAULT NULL COMMENT '订单总金额',
  `MONETARY_UNIT` char(10) DEFAULT NULL COMMENT '货币单位|系统代码表：01-人民币；02-美元；03-欧元；04-英镑；05-日元；06-港币；07-台币；08-新加坡币；',
  `PAY_WAY` char(10) DEFAULT NULL COMMENT '付款方式|系统代码表：01-现金；02-转账；03-支票；04-支付宝；05-微信；06-其他；',
  `ORDER_TIME` datetime DEFAULT NULL COMMENT '下单时间',
  `FINISH_TIME` datetime DEFAULT NULL COMMENT '结单时间',
  `ITEM` varchar(100) DEFAULT NULL COMMENT '项目，关联项目模块',
  `CONTRACT_ID` int(11) unsigned DEFAULT NULL COMMENT '合同ID，关联销售合同表主键',
  `APPROVAL_STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '审批状态：0-待审批;1-已通过;2-已驳回;',
  `APPROVAL_USER` varchar(40) DEFAULT NULL COMMENT '审批人 userId',
  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `APPROVAL_ADVICE` varchar(500) DEFAULT NULL COMMENT '审批意见',
  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  `PRODUCT_ID` int(11) DEFAULT NULL COMMENT '产品id',
  PRIMARY KEY (`ORDER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_order`
--

LOCK TABLES `crm_order` WRITE;
/*!40000 ALTER TABLE `crm_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_product`
--

DROP TABLE IF EXISTS `crm_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_product` (
  `PRODUCT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品信息表[唯一自增主键]',
  `PRODUCT_NAME` varchar(40) NOT NULL COMMENT '产品名称',
  `SUPPLIER_ID` int(11) unsigned DEFAULT NULL COMMENT '产品供应商表[关联供应商管理表主键]',
  `TYPE` varchar(40) DEFAULT NULL COMMENT '产品类型',
  `COST` decimal(10,2) DEFAULT NULL COMMENT '成本价',
  `PRICE` decimal(10,2) DEFAULT NULL COMMENT '销售价',
  `METERING_UNIT` char(10) DEFAULT NULL COMMENT '计量单位',
  `MONETARY_UNIT` char(10) DEFAULT NULL COMMENT '货币单位|系统代码表：01-人民币；02-美元；03-欧元；04-英镑；05-日元；06-港币；07-台币；08-新加坡币；',
  `STOCK` int(11) DEFAULT NULL COMMENT '产品库存',
  `SPECIFICATION` varchar(255) DEFAULT NULL COMMENT '规格型号',
  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  `PHOTO` varchar(200) DEFAULT NULL COMMENT '照片',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  `PRODUCT_LOWPRICE` double DEFAULT NULL COMMENT '最低售价',
  PRIMARY KEY (`PRODUCT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='产品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_product`
--

LOCK TABLES `crm_product` WRITE;
/*!40000 ALTER TABLE `crm_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_role`
--

DROP TABLE IF EXISTS `crm_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_role` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `EDIT_USER` text COMMENT '编辑权限',
  `DEL_USER` text COMMENT '删除权限',
  PRIMARY KEY (`RID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_role`
--

LOCK TABLES `crm_role` WRITE;
/*!40000 ALTER TABLE `crm_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_supplier`
--

DROP TABLE IF EXISTS `crm_supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_supplier` (
  `SUPPLIER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商管理表唯一自增主键',
  `SUPPLIER_NAME` varchar(100) NOT NULL COMMENT '供应商名称',
  `PHONE` varchar(40) DEFAULT NULL COMMENT '供应商电话',
  `FAX` varchar(40) DEFAULT NULL COMMENT '传真号码',
  `WEBSITE` varchar(100) DEFAULT NULL COMMENT '供应商网址',
  `ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '邮政编码',
  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子邮箱',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '供应商地址',
  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',
  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',
  `REGISTER_BANK` varchar(100) DEFAULT NULL COMMENT '开户行',
  `BANK_ACCOUNT` varchar(100) DEFAULT NULL COMMENT '银行账号',
  `ACCOUNT_NAME` varchar(100) DEFAULT NULL COMMENT '户名',
  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',
  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',
  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',
  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',
  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',
  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',
  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',
  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',
  PRIMARY KEY (`SUPPLIER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_supplier`
--

LOCK TABLES `crm_supplier` WRITE;
/*!40000 ALTER TABLE `crm_supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crm_tender_info`
--

DROP TABLE IF EXISTS `crm_tender_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crm_tender_info` (
  `TENDER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `BIDDING_ID` varchar(50) DEFAULT NULL COMMENT '关联招标信息表',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '供应商',
  `END_DATE` date DEFAULT NULL COMMENT '完成投标日期',
  `ATTACHMENT_ID` text COMMENT '投标文件ID串',
  `ATTACHMENT_NAME` text COMMENT '投标文件NAME串',
  `TENDER_STATUS` char(10) DEFAULT NULL COMMENT '投标状态（1-未查看，2-未完成，3-完成）',
  `HIT_STATUS` char(10) DEFAULT NULL COMMENT '中标状态（0-待定，1-中标，2-未中标）',
  `LAST_DESC` text COMMENT '评标结论',
  PRIMARY KEY (`TENDER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='投标信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_tender_info`
--

LOCK TABLES `crm_tender_info` WRITE;
/*!40000 ALTER TABLE `crm_tender_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_tender_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_number`
--

DROP TABLE IF EXISTS `custom_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_number` (
  `uuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `SET_STYLE` varchar(500) DEFAULT NULL COMMENT '编号样式  YYYYMMDD##',
  `TYPES` int(11) DEFAULT NULL COMMENT '累加方式  1自动累加  2按年累加  3按月累加  4按日累加',
  `NUMBER_BIT` int(11) DEFAULT NULL COMMENT '编号位数',
  `CURRENT_NUMBER` int(11) DEFAULT NULL COMMENT '当前编号',
  `LAST_DATE` datetime DEFAULT NULL COMMENT '最后一次修改 ',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_number`
--

LOCK TABLES `custom_number` WRITE;
/*!40000 ALTER TABLE `custom_number` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_number_record`
--

DROP TABLE IF EXISTS `custom_number_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_number_record` (
  `uuid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `CUSTOM_NUMBER_ID` int(11) DEFAULT NULL COMMENT '关联编号',
  `NUMBER_STYLE` varchar(30) DEFAULT NULL COMMENT '编号样式    2016050300002',
  `NUMBER_VALUE` int(11) DEFAULT NULL COMMENT '编号值   2',
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MODEL_` varchar(255) DEFAULT NULL COMMENT '模块编码',
  `MODEL_ID` varchar(255) DEFAULT NULL COMMENT '模块ID',
  PRIMARY KEY (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_number_record`
--

LOCK TABLES `custom_number_record` WRITE;
/*!40000 ALTER TABLE `custom_number_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_number_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_src`
--

DROP TABLE IF EXISTS `data_src`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_src` (
  `d_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据源自增ID',
  `d_name` varchar(40) NOT NULL COMMENT '数据源名称',
  `d_desc` varchar(200) NOT NULL COMMENT '数据源描述',
  `d_creator` varchar(20) NOT NULL COMMENT '创建者',
  `d_editor` varchar(20) NOT NULL COMMENT '最后修改人',
  `d_priv` varchar(200) NOT NULL DEFAULT '0' COMMENT '数据权限',
  `d_dept` text NOT NULL COMMENT '数据源创建部门',
  `d_create_time` datetime NOT NULL COMMENT '数据源创建时间',
  `d_edit_time` datetime NOT NULL COMMENT '最后修改时间',
  `d_nmarking` text COMMENT '标记数据源查询字段',
  `d_nmarkingdesc` text COMMENT '数据源查询字段描述',
  `d_module_name` varchar(100) DEFAULT NULL COMMENT '区分平台',
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_src`
--

LOCK TABLES `data_src` WRITE;
/*!40000 ALTER TABLE `data_src` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_src` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `DEPT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `DEPT_NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '部门名称',
  `DEPT_TYPE` char(10) DEFAULT '0' COMMENT '部门类型（sys_code表）',
  `DEPT_ABBR_NAME` varchar(50) DEFAULT '' COMMENT '部门简称',
  `TEL_NO` varchar(50) NOT NULL DEFAULT '' COMMENT '电话',
  `FAX_NO` varchar(50) NOT NULL DEFAULT '' COMMENT '传真',
  `DEPT_ADDRESS` varchar(100) NOT NULL COMMENT '部门地址',
  `DEPT_NO` varchar(200) NOT NULL DEFAULT '0' COMMENT '部门排序号',
  `DEPT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级部门ID',
  `MANAGER` text NOT NULL COMMENT '部门主管',
  `ASSISTANT_ID` text NOT NULL COMMENT '部门助理',
  `LEADER1` text NOT NULL COMMENT '上级主管领导',
  `LEADER2` text NOT NULL COMMENT '上级分管领导',
  `DEPT_FUNC` text NOT NULL COMMENT '部门职能',
  `IS_ORG` char(1) NOT NULL DEFAULT '0' COMMENT '是否是分支机构(0-否,1-是)',
  `ORG_ADMIN` varchar(200) NOT NULL COMMENT '机构管理员',
  `DEPT_EMAIL_AUDITS_IDS` varchar(255) NOT NULL DEFAULT '' COMMENT '保密邮件审核人',
  `WEIXIN_DEPT_ID` varchar(225) DEFAULT '' COMMENT '关联企业微信的部门id',
  `DINGDING_DEPT_ID` varchar(225) DEFAULT '' COMMENT '关联钉钉的部门id',
  `G_DEPT` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否全局部门(0-否,1-是)',
  `ClASSIFY_ORG` int(11) DEFAULT '0' COMMENT '分级机构（0-不是，1-是）',
  `ClASSIFY_ORG_ADMIN` varchar(255) DEFAULT NULL COMMENT '分级机构的管理员(uid)',
  `DEPT_CODE` varchar(255) DEFAULT NULL COMMENT '部门编码',
  `SMS_GATE_ACCOUNT` varchar(50) DEFAULT NULL COMMENT '账号',
  `SMS_GATE_PASSWORD` varchar(50) DEFAULT NULL COMMENT '密码',
  `WELINK_DEPT` varchar(255) DEFAULT '' COMMENT 'welink的deptcode(即id)',
  `PRIV_TYPES` text COMMENT '角色分类id串',
  `DEPT_DISPLAY` int(1) NOT NULL DEFAULT '1' COMMENT '部门是否失效（1有效   0失效）',
  `IS_SUB_ORG` char(10) NOT NULL DEFAULT '1' COMMENT '是否包含下级分支机构(0-否,1-是)',
  `DEPT_APPROVER` text COMMENT '部门涉密数据审核人',
  PRIMARY KEY (`DEPT_ID`) USING BTREE,
  UNIQUE KEY `DEPT_NO_2` (`DEPT_NO`) USING BTREE,
  KEY `DEPT_NO` (`DEPT_NO`) USING BTREE,
  KEY `DEPT_PARENT` (`DEPT_PARENT`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Board of directors','0','','010-51299001','','','005',0,'zhangwei,','','','','Board of directors','1','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(2,'Finance Department','0','','010-51299003','','','010',0,'liuyang,','','','','Finance Department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(3,'Personnel department','0','','010-51299004','','','015',0,'wangfang,','','','','Personnel department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(4,'Administration Department','0','','005005020005','','','020',0,'lijie,','','','','Administration Department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(5,'R&D department','0','','010-51299007','','','025',0,'lihua,','','','','R&D department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(6,'R&D department I','0','','010-51299008','','','025005',5,'lihua,','','','','R&D department I','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(7,'R&D Department II','0','','010-51299009','','','025010',5,'lihua,','','','','R&D Department II','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(8,'R&D group 1','0','','010-51299011','','','025005005',6,'lihua,','','','','R&D group 1','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(9,'R&D group II','0','','010-51299014','','','025005010',6,'lihua,','','','','R&D group II','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(10,'R&D group III','0','','010-51299015','','','025005015',6,'lihua,','','','','R&D group III','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(11,'Customer service department','0','','010-51299017','','','030',0,'baixue,','','','','Customer service department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(12,'Production department','0','','010-51299018','','','035',0,'wangqiang,','','','','Production department','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(13,'Branch','0','','010-51299019','','','040',0,'admin,','','','','Branch','0','','','0','0',0,0,'',NULL,NULL,NULL,'',NULL,1,'1',NULL),(14,'Resignation','0','','','','','0',99999999,' ',' ',' ',' ',' ','0',' ','','0','0',0,0,'',' ',' ',' ','',NULL,1,'1',NULL);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_map`
--

DROP TABLE IF EXISTS `dept_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_map` (
  `DEPT_GUID` char(36) NOT NULL COMMENT '域组织单位GUID',
  `DEPT_ID` int(11) NOT NULL COMMENT '部门ID',
  `DN` text NOT NULL COMMENT '域组织单位DN',
  PRIMARY KEY (`DEPT_GUID`) USING BTREE,
  KEY `DEPT_ID` (`DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='域组织单位和部门映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_map`
--

LOCK TABLES `dept_map` WRITE;
/*!40000 ALTER TABLE `dept_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `dept_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `key_word` varchar(255) DEFAULT NULL COMMENT '主题词',
  `unit` varchar(255) DEFAULT NULL COMMENT '来文单位/发文单位',
  `doc_no` varchar(255) DEFAULT NULL COMMENT '文号',
  `urgency` varchar(255) DEFAULT NULL COMMENT '紧急程度(0急件1特急2加急)',
  `secrecy` varchar(255) DEFAULT NULL COMMENT '机密等级(0秘密1机密2绝密)',
  `main_delivery` varchar(255) DEFAULT NULL COMMENT '主送',
  `copy_delivery` varchar(255) DEFAULT NULL COMMENT '抄送',
  `deadline` int(11) DEFAULT NULL COMMENT '保存期限',
  `copies` int(11) DEFAULT NULL COMMENT '份数',
  `remark` text COMMENT '附注',
  `creater` varchar(255) DEFAULT NULL COMMENT '发文人',
  `create_dept` varchar(255) DEFAULT NULL COMMENT '发文部门',
  `print_dept` varchar(255) DEFAULT NULL COMMENT '印发机关',
  `print_date` date DEFAULT NULL COMMENT '印发日期',
  `document_type` varchar(255) DEFAULT NULL COMMENT '公文类型(1收文0发文)',
  `dispatch_type` varchar(255) DEFAULT NULL COMMENT '公文种类(公告、通告、通知。。。)',
  `main_file` varchar(255) DEFAULT NULL COMMENT '正文ID',
  `main_file_name` varchar(255) DEFAULT NULL COMMENT '正文名称',
  `pages` int(11) DEFAULT NULL COMMENT '正文页数',
  `content` text COMMENT '正文内容',
  `main_aip_file` varchar(255) DEFAULT NULL COMMENT '版式正文ID',
  `main_aip_file_name` varchar(255) DEFAULT NULL COMMENT '版式正文名称',
  `public_flag` varchar(255) DEFAULT NULL COMMENT '拟公开属性（0不予公开1依申请公开2主动公开）',
  `print_copies` int(11) DEFAULT NULL COMMENT '打印份数',
  `print_user` varchar(11) DEFAULT NULL COMMENT '打印人',
  `flow_id` int(11) DEFAULT NULL COMMENT '流程类型',
  `run_id` int(11) DEFAULT NULL COMMENT '流水号',
  `flow_run_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `flow_status` varchar(255) DEFAULT '0' COMMENT '流程状态（办理中0、已结束1）',
  `flow_prcs` varchar(255) DEFAULT '1' COMMENT '流程步骤（当前处于什么步骤）',
  `cur_user_id` varchar(255) DEFAULT NULL COMMENT '当前经办人id',
  `all_user_id` varchar(255) DEFAULT NULL COMMENT '全部经办人id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `sys_rule_id` int(11) DEFAULT '0' COMMENT '自动编号规则ID',
  `main_origin_file` varchar(255) DEFAULT NULL COMMENT '原始正文ID',
  `main_origin_file_name` varchar(255) DEFAULT NULL COMMENT '原始正文名称',
  `main_clear_file` varchar(255) DEFAULT NULL COMMENT '清稿正文ID',
  `main_clear_file_name` varchar(255) DEFAULT NULL COMMENT '清稿正文名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `I_CREATER` (`creater`) USING BTREE,
  KEY `I_RNN_ID` (`run_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_exchange_outunit`
--

DROP TABLE IF EXISTS `document_exchange_outunit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_exchange_outunit` (
  `OU_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `OU_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '外部单位类别',
  `OUNIT_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '接收单位名称',
  `DEPT_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '接收单位部门',
  `DOC_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '来文类型(1-上级来文，2-下级来文，3-其他来文)',
  `DELIVERY_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '主送/抄送(1-主送，2-抄送)',
  `OUNIT_DESC` text NOT NULL COMMENT '外部单位说明',
  `OUNIT_FULL_NAME` varchar(255) DEFAULT NULL COMMENT '单位全称',
  `ORG_FULL_NAME` varchar(255) DEFAULT NULL COMMENT '单位全称',
  `OUNIT_SHOT_NAME` varchar(255) DEFAULT NULL COMMENT '单位简称',
  `OU_NO` int(11) DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`OU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部单位管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_exchange_outunit`
--

LOCK TABLES `document_exchange_outunit` WRITE;
/*!40000 ALTER TABLE `document_exchange_outunit` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_exchange_outunit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_exchange_receive`
--

DROP TABLE IF EXISTS `document_exchange_receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_exchange_receive` (
  `RECEIVE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `DOC_TITLE` varchar(255) DEFAULT NULL COMMENT '文件标题',
  `FROM_UNIT` varchar(255) DEFAULT NULL COMMENT '来文单位',
  `DOC_NO` varchar(255) DEFAULT NULL COMMENT '文件字号',
  `FROM_RUN_ID` int(11) DEFAULT NULL COMMENT '发文流程RUN_ID',
  `FROM_TIME` datetime DEFAULT NULL COMMENT '来文时间',
  `RECEIVE_STATUS` char(5) DEFAULT '0' COMMENT '签收状态（待签收-0，已签收-1,已收回-2)',
  `RECEIVE_DEPT_ID` int(11) DEFAULT NULL COMMENT '收文部门DEPT_ID',
  `RECEIVE_UNIT` varchar(255) DEFAULT NULL COMMENT '收文单位',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '收文时间',
  `RECEIVE_USER` varchar(255) DEFAULT NULL COMMENT '登记人',
  `RECEIVE_RUN_ID` int(11) DEFAULT NULL COMMENT '收文流程RUN_ID',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `ATTACHMENT_ID2` text COMMENT '正文ID',
  `ATTACHMENT_NAME2` text COMMENT '正文名称',
  `RETURN_COMMENTS` text COMMENT '退回意见',
  `URGENCY` varchar(50) DEFAULT NULL COMMENT '紧急程度',
  `EXCHANGE_ID` int(11) DEFAULT NULL COMMENT '公文交换表对应主键id',
  `PRINT_DEPT` varchar(255) DEFAULT NULL COMMENT '印刷机关',
  PRIMARY KEY (`RECEIVE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='来文接收表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_exchange_receive`
--

LOCK TABLES `document_exchange_receive` WRITE;
/*!40000 ALTER TABLE `document_exchange_receive` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_exchange_receive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_exchange_set`
--

DROP TABLE IF EXISTS `document_exchange_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_exchange_set` (
  `EXCHANGE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `EXCHANGE_TYPE` char(5) DEFAULT '0' COMMENT '交换类型(内部交换-0，外部交换-1)',
  `UNIT_TYPE` varchar(255) DEFAULT NULL COMMENT '单位类型(SYS_CODE表）',
  `FROM_UNIT` varchar(255) DEFAULT NULL COMMENT '发文单位名',
  `RECEIVE_UNIT` varchar(255) DEFAULT NULL COMMENT '收文单位名',
  `EXCHANGE_DEPT_ID` int(11) DEFAULT NULL,
  `EXCHANGE_USER_ID` text COMMENT '部门对应用户',
  `DOCUMENT_PRIV` varchar(50) DEFAULT '1' COMMENT '权限(收文-1，发文-2)',
  `CREATE_USER_ID` varchar(255) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `PARENT_DEPT` varchar(10) DEFAULT NULL COMMENT '上级部门ID',
  `CHILD_DEPTS` text COMMENT '下级部门ID串',
  PRIMARY KEY (`EXCHANGE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公文交换表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_exchange_set`
--

LOCK TABLES `document_exchange_set` WRITE;
/*!40000 ALTER TABLE `document_exchange_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_exchange_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_org`
--

DROP TABLE IF EXISTS `document_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `key_word` varchar(255) DEFAULT NULL COMMENT '主题词',
  `unit` varchar(255) DEFAULT NULL COMMENT '来文单位/发文单位',
  `doc_no` varchar(255) DEFAULT NULL COMMENT '文号',
  `urgency` varchar(255) DEFAULT NULL COMMENT '紧急程度(0急件1特急2加急)',
  `secrecy` varchar(255) DEFAULT NULL COMMENT '机密等级(0秘密1机密2绝密)',
  `main_delivery` varchar(255) DEFAULT NULL COMMENT '主送',
  `copy_delivery` varchar(255) DEFAULT NULL COMMENT '抄送',
  `deadline` int(11) DEFAULT NULL COMMENT '保存期限',
  `copies` int(11) DEFAULT NULL COMMENT '份数',
  `remark` text COMMENT '附注',
  `creater` varchar(255) DEFAULT NULL COMMENT '发文人',
  `create_dept` varchar(255) DEFAULT NULL COMMENT '发文部门',
  `print_dept` varchar(255) DEFAULT NULL COMMENT '印发机关',
  `print_date` date DEFAULT NULL COMMENT '印发日期',
  `document_type` varchar(255) DEFAULT NULL COMMENT '公文类型(1收文0发文)',
  `dispatch_type` varchar(255) DEFAULT NULL COMMENT '公文种类(公告、通告、通知。。。)',
  `main_file` varchar(255) DEFAULT NULL COMMENT '正文ID',
  `main_file_name` varchar(255) DEFAULT NULL COMMENT '正文名称',
  `pages` int(11) DEFAULT NULL COMMENT '正文页数',
  `content` text COMMENT '正文内容',
  `main_aip_file` varchar(255) DEFAULT NULL COMMENT '版式正文ID',
  `main_aip_file_name` varchar(255) DEFAULT NULL COMMENT '版式正文名称',
  `public_flag` varchar(255) DEFAULT NULL COMMENT '拟公开属性（0不予公开1依申请公开2主动公开）',
  `print_copies` int(11) DEFAULT NULL COMMENT '打印份数',
  `print_user` varchar(11) DEFAULT NULL COMMENT '打印人',
  `flow_id` int(11) DEFAULT NULL COMMENT '流程类型',
  `run_id` int(11) DEFAULT NULL COMMENT '流水号',
  `flow_run_name` varchar(255) DEFAULT NULL COMMENT '流程名称',
  `flow_status` varchar(255) DEFAULT '0' COMMENT '流程状态（办理中0、已结束1）',
  `flow_prcs` varchar(255) DEFAULT '1' COMMENT '流程步骤（当前处于什么步骤）',
  `cur_user_id` varchar(255) DEFAULT NULL COMMENT '当前经办人id',
  `all_user_id` varchar(255) DEFAULT NULL COMMENT '全部经办人id',
  `transfer_flag` int(1) DEFAULT NULL COMMENT '转交状态(0-未转交 1-已转交)',
  `org_flag` int(1) DEFAULT NULL COMMENT '是否是上级组织（0-不是上级组织 1-上级组织）',
  `transfer_org` varchar(255) DEFAULT NULL COMMENT '转交组织',
  `transfer_user` varchar(255) DEFAULT NULL COMMENT '转交人',
  `transfer_receive_org` varchar(255) DEFAULT NULL COMMENT '转交后的接收组织',
  `transfer_receive_user` varchar(255) DEFAULT NULL COMMENT '转交后的接收人',
  `transfer_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '转交时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_org`
--

LOCK TABLES `document_org` WRITE;
/*!40000 ALTER TABLE `document_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_out_config`
--

DROP TABLE IF EXISTS `document_out_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_out_config` (
  `CONFIG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OUT_SYS_URL` varchar(255) NOT NULL COMMENT '外部系统URL',
  `OUT_SYS_USER` varchar(255) NOT NULL COMMENT '外部系统账号',
  `OUT_SYS_PWD` varchar(255) NOT NULL COMMENT '外部系统密码',
  PRIMARY KEY (`CONFIG_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部公文集成参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_out_config`
--

LOCK TABLES `document_out_config` WRITE;
/*!40000 ALTER TABLE `document_out_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_out_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_outsend_record`
--

DROP TABLE IF EXISTS `document_outsend_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_outsend_record` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `RUN_ID` int(11) NOT NULL COMMENT '向集团发文时对应的runid',
  `DOC_UNID` varchar(255) NOT NULL DEFAULT '' COMMENT '已发公文返回的id串',
  `OUNIT_NAMES` text NOT NULL COMMENT '接收单位名称',
  `DEPT_NAMES` text NOT NULL COMMENT '接收单位部门',
  `RECEIVE_STATUS` varchar(50) NOT NULL DEFAULT '' COMMENT '签收状态',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '接收时间',
  `SEND_TYPE` varchar(50) NOT NULL DEFAULT '' COMMENT '发送类型',
  `SEND_TIME` datetime NOT NULL COMMENT '发文时间',
  `UNIT_UNID` varchar(255) NOT NULL DEFAULT '' COMMENT '单位对应的unid(用于收回操作)',
  `REMARK` text COMMENT '备注',
  PRIMARY KEY (`RECORD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='已发公文记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_outsend_record`
--

LOCK TABLES `document_outsend_record` WRITE;
/*!40000 ALTER TABLE `document_outsend_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_outsend_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `EMAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `TO_ID` varchar(40) NOT NULL COMMENT '收件人USER_ID',
  `READ_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件读取状态(0-未读,1-已读)',
  `DELETE_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件删除状态',
  `BOX_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件箱分类ID',
  `BODY_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件体ID',
  `RECEIPT` char(1) NOT NULL DEFAULT '0' COMMENT '是否请求阅读收条(0-不请求,1-请求)',
  `IS_F` char(1) NOT NULL COMMENT '是否转发(0-未转发,1-已转发)',
  `IS_R` char(1) NOT NULL COMMENT '是否回复(0-未回复,1-已回复)',
  `SIGN` char(1) NOT NULL COMMENT '星标标记(0-无,1-灰,2-绿,3-黄,4-红)',
  `withdraw_flag` varchar(1) DEFAULT '0' COMMENT '撤回状态（0-未撤回，1-撤回)',
  UNIQUE KEY `ID` (`EMAIL_ID`) USING BTREE,
  KEY `BODY_ID` (`BODY_ID`) USING BTREE,
  KEY `TO_ID` (`TO_ID`) USING BTREE,
  KEY `EMAIL_DATA` (`BODY_ID`,`BOX_ID`,`TO_ID`,`DELETE_FLAG`) USING BTREE,
  KEY `USER_BOX` (`BOX_ID`,`TO_ID`) USING BTREE,
  KEY `READ_FLAG` (`READ_FLAG`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_body`
--

DROP TABLE IF EXISTS `email_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_body` (
  `BODY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_ID` varchar(40) NOT NULL COMMENT '发件人USER_ID',
  `TO_ID2` text NOT NULL COMMENT '收件人USER_ID串',
  `COPY_TO_ID` text NOT NULL COMMENT '抄送人USER_ID串',
  `SECRET_TO_ID` text NOT NULL COMMENT '密送人USER_ID串',
  `SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '邮件主题',
  `CONTENT` mediumtext NOT NULL COMMENT '邮件内容',
  `SEND_TIME` int(10) unsigned NOT NULL COMMENT '发送时间',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件文件名串',
  `SEND_FLAG` varchar(10) NOT NULL DEFAULT '' COMMENT '是否已发送(0-未发送,1-已发送)',
  `SMS_REMIND` varchar(10) NOT NULL DEFAULT '' COMMENT '是否使用短信提醒(0-不提醒,1-提醒)',
  `IMPORTANT` varchar(10) NOT NULL DEFAULT '0' COMMENT '重要程度(空-一般邮件,1-重要,2-非常重要)',
  `SIZE` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件大小',
  `FROM_WEBMAIL_ID` int(11) NOT NULL COMMENT '从自己的哪个外部邮箱ID对应emailbox中id',
  `FROM_WEBMAIL` varchar(200) NOT NULL DEFAULT '' COMMENT '从自己的哪个外部邮箱向外发送',
  `TO_WEBMAIL` text NOT NULL COMMENT '外部收件人邮箱串',
  `COMPRESS_CONTENT` mediumblob NOT NULL COMMENT '压缩后的邮件内容',
  `WEBMAIL_CONTENT` mediumblob NOT NULL COMMENT '外部邮件内容',
  `WEBMAIL_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)',
  `RECV_FROM_NAME` varchar(100) NOT NULL COMMENT '接收外部邮箱名称',
  `RECV_FROM` varchar(100) NOT NULL COMMENT '接收外部邮箱ID',
  `RECV_TO_ID` int(11) NOT NULL COMMENT '发送外部邮件ID',
  `RECV_TO` varchar(100) NOT NULL COMMENT '发送外部邮箱名称',
  `IS_WEBMAIL` char(1) NOT NULL DEFAULT '0' COMMENT '是否为外部邮件(0-内部邮件,1-外部邮件)',
  `IS_WF` char(1) NOT NULL DEFAULT '0' COMMENT '是否同时外发(0-不外发,1-勾选向此人发送外部邮件)',
  `KEYWORD` varchar(100) NOT NULL COMMENT '内容关键词',
  `SECRET_LEVEL` int(2) DEFAULT '0' COMMENT '邮件密级等级',
  `AUDIT_MAN` varchar(100) NOT NULL DEFAULT '' COMMENT '审核人USER_ID',
  `AUDIT_REMARK` text NOT NULL COMMENT '审核不通过备注',
  `COPY_TO_WEBMAIL` text NOT NULL COMMENT '抄送外部邮箱串',
  `SECRET_TO_WEBMAIL` text NOT NULL COMMENT '密送外部邮箱串',
  `PRAISE` text NOT NULL COMMENT '点赞人user_id串',
  `EXAM_FLAG` varchar(10) DEFAULT NULL COMMENT '一般审核状态（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',
  `WORD_FLAG` varchar(10) DEFAULT NULL COMMENT '过滤词审核（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',
  PRIMARY KEY (`BODY_ID`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `SEND_TIME_2` (`SEND_TIME`) USING BTREE,
  KEY `FROM_WEBMAIL_ID` (`FROM_WEBMAIL_ID`) USING BTREE,
  KEY `RECV_TO_ID` (`RECV_TO_ID`) USING BTREE,
  KEY `SEND_FLAG` (`SEND_FLAG`) USING BTREE,
  KEY `SEND_COUNT` (`FROM_ID`,`SEND_FLAG`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件主体内容存储表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_body`
--

LOCK TABLES `email_body` WRITE;
/*!40000 ALTER TABLE `email_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_bodyplus`
--

DROP TABLE IF EXISTS `email_bodyplus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_bodyplus` (
  `BODY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_NAME1` varchar(255) DEFAULT NULL COMMENT '发送人姓名',
  `FROM_ID` varchar(40) CHARACTER SET utf8mb4 NOT NULL COMMENT '发件人USER_ID',
  `TO_ID2` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '收件人USER_ID串',
  `COPY_TO_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '抄送人USER_ID串',
  `SECRET_TO_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '密送人USER_ID串',
  `SUBJECT` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '邮件主题',
  `CONTENT` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT '邮件内容',
  `SEND_TIME` int(10) unsigned NOT NULL COMMENT '发送时间',
  `ATTACHMENT_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '附件文件名串',
  `SEND_FLAG` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '是否已发送(0-未发送,1-已发送)',
  `SMS_REMIND` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '是否使用短信提醒(0-不提醒,1-提醒)',
  `IMPORTANT` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '重要程度(空-一般邮件,1-重要,2-非常重要)',
  `SIZE` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件大小',
  `FROM_WEBMAIL_ID` int(11) NOT NULL COMMENT '从自己的哪个外部邮箱ID对应emailbox中id',
  `FROM_WEBMAIL` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '从自己的哪个外部邮箱向外发送',
  `TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '外部收件人邮箱串',
  `COMPRESS_CONTENT` mediumblob NOT NULL COMMENT '压缩后的邮件内容',
  `WEBMAIL_CONTENT` mediumblob NOT NULL COMMENT '外部邮件内容',
  `WEBMAIL_FLAG` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)',
  `RECV_FROM_NAME` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '接收外部邮箱名称',
  `RECV_FROM` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '接收外部邮箱ID',
  `RECV_TO_ID` int(11) NOT NULL COMMENT '发送外部邮件ID',
  `RECV_TO` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '发送外部邮箱名称',
  `IS_WEBMAIL` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '是否为外部邮件(0-内部邮件,1-外部邮件)',
  `IS_WF` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '是否同时外发(0-不外发,1-勾选向此人发送外部邮件)',
  `KEYWORD` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '内容关键词',
  `SECRET_LEVEL` int(2) DEFAULT '0' COMMENT '邮件密级等级',
  `AUDIT_MAN` varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '审核人USER_ID',
  `AUDIT_REMARK` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '审核不通过备注',
  `COPY_TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '抄送外部邮箱串',
  `SECRET_TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '密送外部邮箱串',
  `PRAISE` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '点赞人user_id串',
  `EXAM_FLAG` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '一般审核状态（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',
  `WORD_FLAG` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '过滤词审核（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',
  `SEX` char(2) DEFAULT NULL COMMENT '性别',
  `SEX_NAME` varchar(100) DEFAULT NULL COMMENT '性别名称',
  `AVATAR` varchar(255) DEFAULT NULL COMMENT '头像',
  `USER_PRIV_NAME` varchar(255) DEFAULT NULL COMMENT '角色',
  `TO_ID2_NAME` varchar(255) DEFAULT NULL COMMENT '收件人名称',
  `COPY_TO_ID_NAME` varchar(255) DEFAULT NULL COMMENT '抄送人名称',
  `SECRET_TO_ID_NAME` varchar(255) DEFAULT NULL COMMENT '密送人名称',
  PRIMARY KEY (`BODY_ID`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `SEND_TIME_2` (`SEND_TIME`) USING BTREE,
  KEY `FROM_WEBMAIL_ID` (`FROM_WEBMAIL_ID`) USING BTREE,
  KEY `RECV_TO_ID` (`RECV_TO_ID`) USING BTREE,
  KEY `SEND_FLAG` (`SEND_FLAG`) USING BTREE,
  KEY `SEND_COUNT` (`FROM_ID`,`SEND_FLAG`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_bodyplus`
--

LOCK TABLES `email_bodyplus` WRITE;
/*!40000 ALTER TABLE `email_bodyplus` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_bodyplus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_box`
--

DROP TABLE IF EXISTS `email_box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_box` (
  `BOX_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `BOX_NO` int(11) NOT NULL DEFAULT '0' COMMENT '邮件箱排序号',
  `BOX_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '邮件箱名称',
  `USER_ID` varchar(40) NOT NULL COMMENT '邮件箱所有者USER_ID',
  `DEFAULT_COUNT` varchar(5) NOT NULL DEFAULT '10' COMMENT '每页显示的记录条数',
  PRIMARY KEY (`BOX_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `BOX_NO` (`BOX_NO`) USING BTREE,
  KEY `BOX_NAME` (`BOX_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自定义邮件箱表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_box`
--

LOCK TABLES `email_box` WRITE;
/*!40000 ALTER TABLE `email_box` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_box` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_boxgroup`
--

DROP TABLE IF EXISTS `email_boxgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_boxgroup` (
  `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `USER_ID` varchar(20) NOT NULL COMMENT '整理规则的创建人USER_ID',
  `F_BOX` int(11) NOT NULL COMMENT '起始邮箱',
  `T_BOX` int(11) NOT NULL COMMENT '目标邮箱',
  `SUBJECT` varchar(200) NOT NULL COMMENT '主题',
  `TO_NAME` varchar(200) NOT NULL COMMENT '收件人',
  `CONTENT` varchar(200) NOT NULL COMMENT '内容',
  `GROUP_SELECT` tinyint(1) NOT NULL COMMENT '关系选择',
  `FROM_NAME` varchar(100) NOT NULL COMMENT '发件人',
  `SELF_SELECT` varchar(300) NOT NULL DEFAULT '' COMMENT '自定义关系选择',
  `IS_USE_TASK` int(1) NOT NULL DEFAULT '0' COMMENT '是否启用定时整体(0-不启用,1-启用)',
  PRIMARY KEY (`GROUP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件整理规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_boxgroup`
--

LOCK TABLES `email_boxgroup` WRITE;
/*!40000 ALTER TABLE `email_boxgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_boxgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_keyword`
--

DROP TABLE IF EXISTS `email_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_keyword` (
  `EMAIL_ID` int(11) NOT NULL COMMENT '邮件ID',
  `UID` int(11) NOT NULL COMMENT '用户UID',
  `KEYWORD` varchar(10) NOT NULL DEFAULT '' COMMENT '关键词',
  KEY `UID` (`UID`,`KEYWORD`) USING BTREE,
  KEY `EMAIL_ID` (`EMAIL_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件关键词索引表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_keyword`
--

LOCK TABLES `email_keyword` WRITE;
/*!40000 ALTER TABLE `email_keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_name`
--

DROP TABLE IF EXISTS `email_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_name` (
  `NAME_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `USER_ID` varchar(20) NOT NULL COMMENT '签名所有者USER_ID',
  `NAME` mediumtext NOT NULL COMMENT '签名内容',
  `IS_USE` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用(0-不启用,1-启用)',
  PRIMARY KEY (`NAME_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件签名表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_name`
--

LOCK TABLES `email_name` WRITE;
/*!40000 ALTER TABLE `email_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_set`
--

DROP TABLE IF EXISTS `email_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_set` (
  `ESS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮件审核设置ID',
  `DEPT_ID` text COMMENT '所属部门',
  `USER_ID` text COMMENT '审核人',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `SEND_AMOUNT` int(11) DEFAULT NULL COMMENT '群发数量',
  `EXCLUDE_USER_ID` text COMMENT '排除人员',
  PRIMARY KEY (`ESS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_set`
--

LOCK TABLES `email_set` WRITE;
/*!40000 ALTER TABLE `email_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_tag`
--

DROP TABLE IF EXISTS `email_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_tag` (
  `TAG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `TAG_NO` varchar(20) NOT NULL,
  `TAG_NAME` varchar(20) NOT NULL,
  `KEYWORDS` tinytext NOT NULL,
  PRIMARY KEY (`TAG_ID`) USING BTREE,
  KEY `TAG_ID` (`TAG_ID`,`TAG_NO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_tag`
--

LOCK TABLES `email_tag` WRITE;
/*!40000 ALTER TABLE `email_tag` DISABLE KEYS */;
INSERT INTO `email_tag` VALUES (1,'01','日程','邮件，便笺，行程，规则，电话簿，日程表，时间，日程安排'),(2,'02','会议','讲座，讨论会，宣传，拜访，博览，招待，文化交流，公务，住宿，疗养，夏令营，纪要，会议室，场地，器材，设备，签到簿，记录，资料，背景，展板，电话会议，视频会议，礼仪，纪念品'),(3,'03','日志','记录，工作，阅读，发表，记载，博客，文件，用户，留言'),(4,'04','汇报','工作，指示，提纲，总结，批准，指正'),(5,'05','计划','方案，战略，目标，流程，模型，进度，预算，监督，规则，规划，制定 ，排班， 报告，计量，运作，整顿，决策'),(6,'06','通知','附件，贡献，积分，年度，绩效，传达，部门，总结，报销，申请，出差，通告，会议纪要，贡献，提交，意见，会议纪要，反馈，批示，告知'),(7,'07','新闻','报道，媒体，文化传播，消息，通讯，特写，速写，批准，报刊，电视，网络，媒体，报道，通讯，电视，网络，广播'),(8,'08','公文','收文，发文，审批，传阅，纪要，意见，批复，请示，通报，报告，拟稿，主送，正文，机关，印章，字号，机密等级，抄送，阅读'),(9,'09','项目','审批，完成，任务，项目，立项，解决方案，沟通，进度'),(10,'10','人事','奖惩，专员，录用，规章制度，编制'),(11,'11','考核','评语，制度，办法，表单，方案，细则，指标，总结，绩效，进度，评分，完成情况，材料，意见，业绩'),(12,'12','报表','数据，业务，运营，财务，项目，预算，表格，图表，信息，清单，单据，记录，统计，汇总，分析，合计，台账，票据，打印，报告，图纸，凭证，应付，核算'),(13,'13','工作流','拟稿， 签发， 表单， 控件， 应用程序'),(14,'14','客户','客户，忠诚度，满意度，拜访'),(15,'15','合同','工作，债权，劳动，违约，解约，签订 ，到期，提醒，法律，成立，变更，当事人，法人，法律，民事，物权，契约，签约，有偿合同，无偿合同，生效，义务，利益，纠纷，发票，担保，评');
/*!40000 ALTER TABLE `email_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emailplus`
--

DROP TABLE IF EXISTS `emailplus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emailplus` (
  `EMAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `TO_ID` varchar(40) NOT NULL COMMENT '收件人USER_ID',
  `READ_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件读取状态(0-未读,1-已读)',
  `DELETE_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件删除状态',
  `BOX_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件箱分类ID',
  `BODY_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件体ID',
  `RECEIPT` char(1) NOT NULL DEFAULT '0' COMMENT '是否请求阅读收条(0-不请求,1-请求)',
  `IS_F` char(1) NOT NULL COMMENT '是否转发(0-未转发,1-已转发)',
  `IS_R` char(1) NOT NULL COMMENT '是否回复(0-未回复,1-已回复)',
  `SIGN` char(1) NOT NULL COMMENT '星标标记(0-无,1-灰,2-绿,3-黄,4-红)',
  `withdraw_flag` varchar(1) DEFAULT '0' COMMENT '撤回状态（0-未撤回，1-撤回）',
  UNIQUE KEY `ID` (`EMAIL_ID`) USING BTREE,
  KEY `BODY_ID` (`BODY_ID`) USING BTREE,
  KEY `TO_ID` (`TO_ID`) USING BTREE,
  KEY `USER_BOX` (`BOX_ID`,`TO_ID`) USING BTREE,
  KEY `READ_FLAG` (`READ_FLAG`) USING BTREE,
  KEY `EMAIL_DATA` (`BODY_ID`,`BOX_ID`,`TO_ID`,`DELETE_FLAG`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emailplus`
--

LOCK TABLES `emailplus` WRITE;
/*!40000 ALTER TABLE `emailplus` DISABLE KEYS */;
/*!40000 ALTER TABLE `emailplus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_dept`
--

DROP TABLE IF EXISTS `ext_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ext_dept` (
  `DEPT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `DEPT_NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '外部机构名称',
  `ESB_USER` varchar(50) NOT NULL DEFAULT '' COMMENT '使用用户',
  `DEPT_NO` varchar(200) NOT NULL DEFAULT '0' COMMENT '外部机构编号',
  `DEPT_PARENT` int(11) NOT NULL COMMENT '上级部门',
  `DEPT_DESC` text NOT NULL COMMENT '外部机构描述',
  `SYNC_STATE` char(1) NOT NULL DEFAULT '0' COMMENT '同步状态',
  `ACTIVE` tinyint(1) NOT NULL DEFAULT '0' COMMENT '(0-停用,1-启用,2-临界)',
  PRIMARY KEY (`DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='互联互通外部发送对象';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_dept`
--

LOCK TABLES `ext_dept` WRITE;
/*!40000 ALTER TABLE `ext_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `ext_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ext_user`
--

DROP TABLE IF EXISTS `ext_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ext_user` (
  `UID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `PASSWORD` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `USE_FLAG` char(1) NOT NULL DEFAULT '1' COMMENT '用户状态(0-信用,1-停用)',
  `AUTH_MODULE` varchar(200) NOT NULL DEFAULT '' COMMENT '模块权限(1-提醒,4-工作流,5-互联互通访问接口,6-数据交换访问接口_',
  `POSTFIX` varchar(200) NOT NULL DEFAULT '' COMMENT '内容后缀',
  `REMARK` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',
  `SYS_USER` char(1) NOT NULL DEFAULT '0' COMMENT '是否系统用户(0-否,1-是)',
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='接口用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ext_user`
--

LOCK TABLES `ext_user` WRITE;
/*!40000 ALTER TABLE `ext_user` DISABLE KEYS */;
INSERT INTO `ext_user` VALUES (1,'OfficeTask','','1','','','','1'),(2,'SmsRemind','','1','','','','1');
/*!40000 ALTER TABLE `ext_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data`
--

DROP TABLE IF EXISTS `field_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data` (
  `TAB_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '表名',
  `FIELD_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '字段编号',
  `IDENTY_ID` varchar(200) DEFAULT '' COMMENT '关联唯一ID',
  `ITEM_DATA` text COMMENT '字段数据'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自定义字段数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data`
--

LOCK TABLES `field_data` WRITE;
/*!40000 ALTER TABLE `field_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_set`
--

DROP TABLE IF EXISTS `field_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_set` (
  `TAB_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '表名',
  `FIELD_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '字段编号',
  `FIELD_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '字段名',
  `ORDER_NO` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `STYPE` varchar(20) NOT NULL DEFAULT '' COMMENT '字段类型',
  `TYPE_NAME` text COMMENT '代码名称串',
  `TYPE_VALUE` text COMMENT '代码值串',
  `TYPE_CODE` varchar(50) DEFAULT '' COMMENT '代码对应的系统代码值',
  `IS_QUERY` varchar(20) NOT NULL DEFAULT '' COMMENT '是否做为查询字段',
  `IS_GROUP` varchar(20) NOT NULL DEFAULT '' COMMENT '是否做为排序字段',
  `CODE_TYPE` varchar(10) DEFAULT '' COMMENT '代码类别（1-系统代码，2-自定义选项）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自定义字段设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_set`
--

LOCK TABLES `field_set` WRITE;
/*!40000 ALTER TABLE `field_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_comment`
--

DROP TABLE IF EXISTS `file_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `FILE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '文件ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '点评用户的USER_ID',
  `CONTENT` text NOT NULL COMMENT '点评内容 ',
  `SEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '点评保存时间',
  PRIMARY KEY (`COMMENT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公共文件柜文档评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_comment`
--

LOCK TABLES `file_comment` WRITE;
/*!40000 ALTER TABLE `file_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_content`
--

DROP TABLE IF EXISTS `file_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_content` (
  `CONTENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `SORT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '目录ID',
  `SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '文件名称',
  `CONTENT` mediumtext NOT NULL COMMENT '文件内容',
  `SEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '保存时间',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `ATTACHMENT_DESC` varchar(100) NOT NULL DEFAULT '' COMMENT '附件描述',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '有访问权限的用户ID串',
  `CONTENT_NO` int(11) NOT NULL COMMENT '文件排序号',
  `NEW_PERSON` varchar(100) NOT NULL DEFAULT '' COMMENT '文件转发人',
  `READERS` text NOT NULL COMMENT '阅读人员',
  `CREATER` varchar(100) NOT NULL DEFAULT '' COMMENT '创建人',
  `LOGS` text NOT NULL COMMENT '对该文件所做主要操作的日志',
  `KEYWORD` varchar(100) NOT NULL COMMENT '内容关键词',
  `FILE_SIZE` varchar(255) DEFAULT NULL COMMENT '文件大小',
  UNIQUE KEY `ITEM_ID` (`CONTENT_ID`) USING BTREE,
  KEY `SUBJECT` (`SUBJECT`) USING BTREE,
  KEY `CONTENT_NO` (`CONTENT_NO`) USING BTREE,
  KEY `ID_TIME` (`SORT_ID`,`SEND_TIME`) USING BTREE,
  KEY `SEND_TIME` (`SEND_TIME`) USING BTREE,
  KEY `CREATER` (`CREATER`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文件柜文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_content`
--

LOCK TABLES `file_content` WRITE;
/*!40000 ALTER TABLE `file_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_score`
--

DROP TABLE IF EXISTS `file_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_score` (
  `SCORE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `FILE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '文件ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '打分用户的USER_ID',
  `SEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '打分时间',
  `FRACTION` int(11) NOT NULL COMMENT '分数',
  PRIMARY KEY (`SCORE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公共文件柜文档打分表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_score`
--

LOCK TABLES `file_score` WRITE;
/*!40000 ALTER TABLE `file_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_sort`
--

DROP TABLE IF EXISTS `file_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_sort` (
  `SORT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `SORT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `SORT_NO` varchar(20) NOT NULL DEFAULT '' COMMENT '目录排序号',
  `SORT_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '目录名称',
  `SORT_TYPE` char(1) NOT NULL DEFAULT '' COMMENT '类型(5-公共文件柜,4-个人文件柜)',
  `USER_ID` text NOT NULL COMMENT '有访问权限的用户ID串',
  `NEW_USER` text NOT NULL COMMENT '有新建权限的用户ID串',
  `MANAGE_USER` text NOT NULL COMMENT '有编辑权限的用户ID串',
  `DEL_USER` text NOT NULL COMMENT '有删除权限的用户ID串',
  `DOWN_USER` text NOT NULL COMMENT '有下载/打印权限的用户ID串',
  `SHARE_USER` text NOT NULL COMMENT '个人共享',
  `OWNER` text NOT NULL COMMENT '所有者ID串',
  `SIGN_USER` text NOT NULL COMMENT '有签阅权限的用户ID串',
  `REVIEW` text NOT NULL COMMENT '评论/打分权限',
  `DESCRIPTION` text COMMENT '文件夹描述',
  `SPACE_LIMIT` int(11) DEFAULT NULL,
  `SPACE_USE` double DEFAULT '0' COMMENT '已用容量',
  `BRANCH_DEPT_ID` int(11) DEFAULT NULL COMMENT '分支机构ID',
  UNIQUE KEY `ITEM_ID` (`SORT_ID`) USING BTREE,
  KEY `PARENT_NO_NAME` (`SORT_PARENT`,`SORT_NO`,`SORT_NAME`) USING BTREE,
  KEY `SORT_TYPE` (`SORT_TYPE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文件柜目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_sort`
--

LOCK TABLES `file_sort` WRITE;
/*!40000 ALTER TABLE `file_sort` DISABLE KEYS */;
INSERT INTO `file_sort` VALUES (1,0,'1','公司制度','5','|1,2,3,5,7,9,11,12,4,6,8,10,13,|','||admin,','||admin,','','','','','','','',NULL,0,NULL),(2,0,'2','部门制度','5','|1,2,3,5,7,9,11,12,4,6,8,10,13,|admin,','||admin,','||admin,','','','','','','','',NULL,0,NULL),(3,0,'3','常用文件','5','|1,2,3,5,7,9,11,12,4,6,8,10,13,|admin,','||admin,','||admin,','','','','','','','',NULL,0,NULL);
/*!40000 ALTER TABLE `file_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_assign`
--

DROP TABLE IF EXISTS `flow_assign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_assign` (
  `ASSIGN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `RUN_ID` int(11) DEFAULT NULL COMMENT '流水号',
  `PRCS_ID` int(11) DEFAULT NULL COMMENT '流程实例步骤ID',
  `FLOW_PRCS` int(11) DEFAULT NULL COMMENT '步骤ID[设计流程中的步骤号]',
  `PRCS_NAME` varchar(200) DEFAULT NULL COMMENT '步骤名称',
  `ASSIGN_USER` varchar(50) DEFAULT NULL COMMENT '交办人',
  `ASSIGN_TIME` datetime DEFAULT NULL COMMENT '交办时间',
  `ASSIGN_TASK` text COMMENT '交办任务',
  `SING_YN` varchar(10) DEFAULT '0' COMMENT '是否允许填写会签意见(0不允许，1允许)',
  `ATTACHMENT_ID` text COMMENT '交办附件ID窜',
  `ATTACHMENT_NAME` text COMMENT '交办附件NAME窜',
  `HANDLE_HOUR` varchar(20) DEFAULT NULL COMMENT '办理小时数',
  `HANDLE_USER` varchar(50) DEFAULT NULL COMMENT '办理人',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '任务接收时间',
  `TASK_FEEDBACK` text COMMENT '办理汇报',
  `FD_ATTACHMENT_ID` text COMMENT '办理附件ID窜',
  `FD_ATTACHMENT_NAME` text COMMENT '办理附件NAME窜',
  `PARENT_ASSIGN_ID` int(255) DEFAULT '0' COMMENT '上一级任务ID',
  `HANDLE_STATUS` int(10) DEFAULT '0' COMMENT '办理状态(0未接收，1办理中，2办结)',
  PRIMARY KEY (`ASSIGN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程交办表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_assign`
--

LOCK TABLES `flow_assign` WRITE;
/*!40000 ALTER TABLE `flow_assign` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_assign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_business`
--

DROP TABLE IF EXISTS `flow_business`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_business` (
  `BIZ_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `PRCS_NAME` varchar(200) DEFAULT NULL COMMENT '生成办理节点名称',
  `RUN_ID` int(11) DEFAULT NULL COMMENT '流程RUN_ID',
  `FLOW_ID` int(11) DEFAULT NULL COMMENT '流程FLOW_ID',
  `PRCS_ID` int(11) DEFAULT NULL COMMENT '流程实例运行步骤ID',
  `FLOW_PRCS` int(11) DEFAULT NULL COMMENT '设计流程步骤ID',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '用户ID',
  `DEPT_ID` int(11) DEFAULT NULL COMMENT '部门ID',
  `PRCS_TYPE` varchar(20) DEFAULT NULL COMMENT '业务应用节点类型',
  `BUSINESS_MODULE` varchar(20) DEFAULT NULL COMMENT '业务模块(字典内置数据维护)',
  `BUSINESS_ID` int(11) DEFAULT NULL COMMENT '业务模块关联主键ID',
  `IF_AGREE` char(10) DEFAULT '0' COMMENT '是否同意（0-是，1-否）',
  `OPINION` text COMMENT '意见',
  PRIMARY KEY (`BIZ_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程-业务审批记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_business`
--

LOCK TABLES `flow_business` WRITE;
/*!40000 ALTER TABLE `flow_business` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_business` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_controls`
--

DROP TABLE IF EXISTS `flow_controls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_controls` (
  `control_id` varchar(30) NOT NULL DEFAULT '' COMMENT '控件ID',
  `control_name` varchar(30) NOT NULL DEFAULT '' COMMENT '控件名称',
  `control_no` smallint(5) unsigned NOT NULL COMMENT '控件排序号',
  `control_type` tinyint(3) unsigned NOT NULL COMMENT '控件类型',
  `diag_width` smallint(5) unsigned NOT NULL COMMENT '表单设计器控件属性窗口宽度',
  `diag_height` smallint(5) unsigned NOT NULL COMMENT '表单设计器控件属性窗口高度',
  `sys_flag` tinyint(3) unsigned NOT NULL COMMENT '是否为系统内置(1-是,0-否)',
  PRIMARY KEY (`control_id`) USING BTREE,
  KEY `control_no` (`control_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='表单控件定义表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_controls`
--

LOCK TABLES `flow_controls` WRITE;
/*!40000 ALTER TABLE `flow_controls` DISABLE KEYS */;
INSERT INTO `flow_controls` VALUES ('Calc','计算控件',90,0,380,310,1),('Calendar','日历控件',80,0,380,230,1),('Checkbox','复选框',50,0,380,210,1),('DataSelection','数据选择控件',120,0,500,350,1),('ExtDataSelection','外部数据选择控件',130,0,500,350,1),('FileUpload','附件上传控件',170,0,380,160,1),('FormDataSelection','表单数据控件',140,0,500,350,1),('ImageUpload','图片上传控件',160,0,380,210,1),('ListView','列表控件',60,0,950,425,1),('Macro','宏控件',70,0,380,250,1),('MobileSign','移动签章控件',190,0,380,210,1),('MobileWriteSign','移动手写签章控件',200,0,400,220,1),('OrgSelect','部门人员控件',100,0,380,210,1),('ProgressBar','进度条控件',150,0,380,210,1),('QRCode','二维码控件',180,0,380,260,1),('Radio','单选框',40,0,370,340,1),('Select','下拉菜单',30,0,480,310,1),('Text','单行输入框',10,0,260,320,1),('Textarea','多行输入框',20,0,300,300,1),('WebSign','签章控件',110,0,380,260,1);
/*!40000 ALTER TABLE `flow_controls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_data_139`
--

DROP TABLE IF EXISTS `flow_data_139`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_data_139` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `run_id` int(10) NOT NULL DEFAULT '0',
  `run_name` varchar(200) NOT NULL DEFAULT '',
  `begin_user` varchar(20) NOT NULL DEFAULT '',
  `begin_time` datetime DEFAULT NULL,
  `flow_auto_num` int(11) NOT NULL DEFAULT '0',
  `flow_auto_num_year` int(11) NOT NULL DEFAULT '0',
  `flow_auto_num_month` int(11) NOT NULL DEFAULT '0',
  `DATA_3` text NOT NULL,
  `DATA_19` text NOT NULL,
  `DATA_20` text NOT NULL,
  `DATA_21` text NOT NULL,
  `DATA_30` text NOT NULL,
  `DATA_31` text NOT NULL,
  `DATA_32` text NOT NULL,
  `DATA_25` text NOT NULL,
  `DATA_39` text NOT NULL,
  `DATA_37` text NOT NULL,
  `DATA_40` text NOT NULL,
  `DATA_43` text NOT NULL,
  `DATA_41` text NOT NULL,
  `DATA_44` text NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `run_id` (`run_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_data_139`
--

LOCK TABLES `flow_data_139` WRITE;
/*!40000 ALTER TABLE `flow_data_139` DISABLE KEYS */;
INSERT INTO `flow_data_139` VALUES (1,2,'印章申请 2018-09-13 17:33:35','admin','2018-09-13 17:33:35',0,0,0,'系统管理员','2018年09月13日','分公司','OA管理员','公章','','','','','','系统管理员 2018-09-14 16:07:34','','','');
/*!40000 ALTER TABLE `flow_data_139` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_favorite`
--

DROP TABLE IF EXISTS `flow_favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_favorite` (
  `FAVORITE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '所属用户userId',
  `FAVORITE_NAME` varchar(255) DEFAULT NULL COMMENT '收藏夹名称',
  `RUN_IDS` text COMMENT '流程的run_id串，通过","拼接',
  PRIMARY KEY (`FAVORITE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='工作流收藏夹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_favorite`
--

LOCK TABLES `flow_favorite` WRITE;
/*!40000 ALTER TABLE `flow_favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_feedback_common`
--

DROP TABLE IF EXISTS `flow_feedback_common`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_feedback_common` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  `CONTENT` text COMMENT '会签意见常用语内容',
  `CREATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',
  `UPDATE_TIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会签意见常用语';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_feedback_common`
--

LOCK TABLES `flow_feedback_common` WRITE;
/*!40000 ALTER TABLE `flow_feedback_common` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_feedback_common` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_form_ext`
--

DROP TABLE IF EXISTS `flow_form_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_form_ext` (
  `FORM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `ORDER_ID` int(11) DEFAULT NULL COMMENT '排序号',
  `FLOW_ID` int(11) DEFAULT NULL COMMENT '流程ID',
  `FORM_NAME` varchar(50) DEFAULT NULL COMMENT '业务表单名称',
  `FORM_TYPE` varchar(10) DEFAULT NULL COMMENT '业务表单类型',
  `FORM_DETAILS_URL` varchar(200) DEFAULT NULL COMMENT '业务表单详情URL',
  `FORM_DETAILS_URL_SECRET` varchar(200) DEFAULT NULL COMMENT '详情URL密钥',
  `FORM_EDIT_URL` varchar(200) DEFAULT NULL COMMENT '业务表单编辑URL',
  `FORM_EDIT_URL_SECRET` varchar(200) DEFAULT NULL COMMENT '编辑URL密钥',
  `FORM_RESTFUL` varchar(200) DEFAULT NULL COMMENT '业务表单字段Restful接口',
  `DATA_MAP` text COMMENT '数据关系映射',
  `DATA_DIRECTION` char(10) DEFAULT NULL COMMENT '数据方向',
  `FORM_DESC` text COMMENT '描述',
  `SYSTEM` char(10) DEFAULT '0' COMMENT '是否系统内置(0-否,1-是)',
  `USE_FLAG` char(10) DEFAULT '1' COMMENT '是否启用(0-否,1-是)',
  `EDIT_PRCS` text COMMENT '可编辑节点',
  PRIMARY KEY (`FORM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程业务表单管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_form_ext`
--

LOCK TABLES `flow_form_ext` WRITE;
/*!40000 ALTER TABLE `flow_form_ext` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_form_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_form_type`
--

DROP TABLE IF EXISTS `flow_form_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_form_type` (
  `FORM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '表单ID',
  `FORM_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '表单名称',
  `PRINT_MODEL` longtext NOT NULL COMMENT '表单设计信息',
  `PRINT_MODEL_SHORT` longtext NOT NULL COMMENT '精简后的表单设计信息',
  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '表单所属部门',
  `SCRIPT` mediumtext NOT NULL COMMENT '表单拓展脚本',
  `CSS` mediumtext NOT NULL COMMENT '表单扩展样式',
  `ITEM_MAX` int(11) NOT NULL COMMENT '最大的项目编号',
  `FORM_SORT` int(11) NOT NULL DEFAULT '0' COMMENT '表单所属分类',
  `is_new` int(11) NOT NULL DEFAULT '1' COMMENT '表单类型 1 - 新表单 0 - 老表单',
  `MOBILE_DATA_SORT` text COMMENT '移动端表单字段排序信息',
  `MOBILE_PRINT_MODEL` text COMMENT '移动表单设计信息',
  PRIMARY KEY (`FORM_ID`) USING BTREE,
  KEY `DEPT_ID` (`DEPT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设计表单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_form_type`
--

LOCK TABLES `flow_form_type` WRITE;
/*!40000 ALTER TABLE `flow_form_type` DISABLE KEYS */;
INSERT INTO `flow_form_type` VALUES (1,'Seal application form','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Seal application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp; Application time&nbsp;&nbsp;</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_19\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_19\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Application Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_20\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Position</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_21\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_21\" datafld=\"SYS_SQL\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" orghidden=\"0\" orgsql=\"SELECT USER_NAME FROM user WHERE DEPT_ID=`[SYS_DEPT_ID]`\" orgsqllist=\"\" macrostype=\"1\"/><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Type of seal used&nbsp;</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><select name=\"DATA_30\" class=\"form_item\" data-type=\"select\" id=\"DATA_30\" title=\"用印类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"公章\">公章</option><option value=\"合同章\">合同章</option></select></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; &nbsp;Number of seals used</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_31\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"用印数量\" value=\"\" id=\"DATA_31\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Reporting unit</span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_32\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报送单位\" value=\"\" id=\"DATA_32\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243); word-break: break-all;\"><p style=\"margin-bottom: 0px; padding: 0px; text-align: -webkit-center; white-space: normal;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-size: 16px;\">&nbsp; Reason for application</span></span></p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\"></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\"><textarea name=\"DATA_25\" id=\"DATA_25\" class=\"form_item\" data-type=\"textarea\" title=\"申请事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Leader&nbsp;approval&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"text-wrap-mode: wrap;\">Remarks</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;</span></p><p>1. Anyone using the company seal must fill out this form;</p><p>2. The application reason column should clearly fill in the name and content of the printed text, such as the text of a contract</p><p>The amount involved and the name of the other party signing the contract should be filled in;</p><p style=\"margin-bottom: 0px; padding: 0px; white-space: normal;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Seal application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp; Application time&nbsp;&nbsp;</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_19\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_19\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Application Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_20\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Position</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_21\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_21\" datafld=\"SYS_SQL\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" orghidden=\"0\" orgsql=\"SELECT USER_NAME FROM user WHERE DEPT_ID=`[SYS_DEPT_ID]`\" orgsqllist=\"\" macrostype=\"1\"/><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Type of seal used&nbsp;</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><select name=\"DATA_30\" class=\"form_item\" data-type=\"select\" id=\"DATA_30\" title=\"用印类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"公章\">公章</option><option value=\"合同章\">合同章</option></select></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; &nbsp;Number of seals used</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_31\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"用印数量\" value=\"\" id=\"DATA_31\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Reporting unit</span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_32\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报送单位\" value=\"\" id=\"DATA_32\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243); word-break: break-all;\"><p style=\"margin-bottom: 0px; padding: 0px; text-align: -webkit-center; white-space: normal;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-size: 16px;\">&nbsp; Reason for application</span></span></p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\"></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\"><textarea name=\"DATA_25\" id=\"DATA_25\" class=\"form_item\" data-type=\"textarea\" title=\"申请事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Leader&nbsp;approval&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"text-wrap-mode: wrap;\">Remarks</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;</span></p><p>1. Anyone using the company seal must fill out this form;</p><p>2. The application reason column should clearly fill in the name and content of the printed text, such as the text of a contract</p><p>The amount involved and the name of the other party signing the contract should be filled in;</p><p style=\"margin-bottom: 0px; padding: 0px; white-space: normal;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',44,4,1,NULL,NULL),(2,'Leave Application Form ','<p style=\"text-align: center;\"><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Leave registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Leave type</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><select name=\"DATA_8\" class=\"form_item\" data-type=\"select\" id=\"DATA_8\" title=\"请假类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"事假\" selected=\"selected\">事假</option><option value=\"病假\">病假</option><option value=\"年假\">年假</option><option value=\"婚假\">婚假</option><option value=\"丧假\">丧假</option><option value=\"其他假期\">其他假期</option></select></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Start Date&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_9\" title=\"请假开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_9\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; End Date&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_10\" title=\"请假结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_10\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason for leave</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"请假事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Leaders a<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_18\" id=\"DATA_18\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_17\" class=\"form_item\" data-type=\"select\" id=\"DATA_17\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_33\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导签字\" id=\"DATA_33\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_27\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_27\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Personnel administrative approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_30\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_30\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p style=\"text-align: center;\"><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Leave registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Leave type</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><select name=\"DATA_8\" class=\"form_item\" data-type=\"select\" id=\"DATA_8\" title=\"请假类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"事假\" selected=\"selected\">事假</option><option value=\"病假\">病假</option><option value=\"年假\">年假</option><option value=\"婚假\">婚假</option><option value=\"丧假\">丧假</option><option value=\"其他假期\">其他假期</option></select></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Start Date&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_9\" title=\"请假开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_9\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; End Date&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_10\" title=\"请假结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_10\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason for leave</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"请假事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Leaders a<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_18\" id=\"DATA_18\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_17\" class=\"form_item\" data-type=\"select\" id=\"DATA_17\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_33\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导签字\" id=\"DATA_33\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_27\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_27\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Personnel administrative approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval Opinion</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_30\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_30\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',33,5,1,NULL,NULL),(3,'Overtime application form ','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Overtime registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Position</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_50\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_50\" datafld=\"SYS_USERPRIV\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"text-align: -webkit-center; background-color: rgb(219, 238, 243); font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Start Time</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;&nbsp;</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_52\" title=\"加班开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_52\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">End Time</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;&nbsp;</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_54\" title=\"加班结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_54\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp;Overtime location</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_55\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"加班地点\" value=\"\" id=\"DATA_55\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason for overtime</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"加班事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Overtime registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Position</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_50\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_50\" datafld=\"SYS_USERPRIV\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"text-align: -webkit-center; background-color: rgb(219, 238, 243); font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Start Time</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;&nbsp;</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_52\" title=\"加班开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_52\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">End Time</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">&nbsp;&nbsp;</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_54\" title=\"加班结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_54\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp;Overtime location</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_55\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"加班地点\" value=\"\" id=\"DATA_55\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason for overtime</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"加班事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span>：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-size: 16px; background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',55,6,1,NULL,NULL),(4,'Travel application form','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Business trip application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Position</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_50\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_50\" datafld=\"SYS_USERPRIV\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Business trip location</span></td><td valign=\"middle\" align=\"center\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_32\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"出差地点\" value=\"\" id=\"DATA_32\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; Start Time&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_52\" title=\"出差开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_52\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; End Time&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_53\" title=\"出差结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_53\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Estimated cost</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_35\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"预计费用\" value=\"\" id=\"DATA_35\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"150\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 150px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Reason for business trip</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"出差事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Business trip application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Position</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_50\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"职务\" id=\"DATA_50\" datafld=\"SYS_USERPRIV\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Business trip location</span></td><td valign=\"middle\" align=\"center\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_32\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"出差地点\" value=\"\" id=\"DATA_32\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; Start Time&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_52\" title=\"出差开始时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_52\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; End Time&nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_53\" title=\"出差结束时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_53\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Estimated cost</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\"><input name=\"DATA_35\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"预计费用\" value=\"\" id=\"DATA_35\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"150\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 150px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Reason for business trip</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"出差事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',53,5,1,NULL,NULL),(6,'On duty application form','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Duty registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_8\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"受理日期\" id=\"DATA_8\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Acceptance time</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_10\" title=\"受理时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_10\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Acceptor</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_11\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"受理人\" id=\"DATA_11\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Acceptance method</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><select name=\"DATA_12\" class=\"form_item\" data-type=\"select\" id=\"DATA_12\" title=\"受理方式\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电话来电\" selected=\"selected\">电话来电</option><option value=\"QQ咨询\">QQ咨询</option><option value=\"微信咨询\">微信咨询</option><option value=\"其他方式\">其他方式</option></select><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp; &nbsp;Contacts</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_13\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"联系人\" value=\"\" id=\"DATA_13\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp;Phone</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_15\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"电话\" value=\"\" id=\"DATA_15\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">&nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Unit Name</span></span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_17\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"单位名称\" value=\"\" id=\"DATA_17\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Duty reasons</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"值班事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Duty registration</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_8\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"受理日期\" id=\"DATA_8\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Acceptance time</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_10\" title=\"受理时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_10\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Acceptor</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_11\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"受理人\" id=\"DATA_11\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Acceptance method</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><select name=\"DATA_12\" class=\"form_item\" data-type=\"select\" id=\"DATA_12\" title=\"受理方式\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"150\" style=\"width: 150px;\"><option value=\"电话来电\" selected=\"selected\">电话来电</option><option value=\"QQ咨询\">QQ咨询</option><option value=\"微信咨询\">微信咨询</option><option value=\"其他方式\">其他方式</option></select><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp; &nbsp;Contacts</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_13\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"联系人\" value=\"\" id=\"DATA_13\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp;Phone</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_15\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"电话\" value=\"\" id=\"DATA_15\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">&nbsp; &nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Unit Name</span></span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_17\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"单位名称\" value=\"\" id=\"DATA_17\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Duty reasons</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><textarea name=\"DATA_36\" id=\"DATA_36\" class=\"form_item\" data-type=\"textarea\" title=\"值班事由\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size:16px;width:520px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Leaders a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">CEO&nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">a</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Personnel administrative approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Approval Opinion</span></span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-wrap-mode: wrap;\">Sign</span>：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',48,6,1,NULL,NULL),(26,'Expense budget application form','<p><br/></p><p style=\"text-align: center;\"><span style=\"color:#366092;font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 24px;\"><strong>Expense budget application form</strong></span></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Recording date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_9\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录单日期\" id=\"DATA_9\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); border-style: solid; word-break: break-all;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Application type</span><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><select name=\"DATA_2\" class=\"form_item\" data-type=\"select\" id=\"DATA_2\" title=\"申请类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"个人预算\" selected=\"selected\">个人预算</option><option value=\"部门预算\">部门预算</option></select></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); border-style: solid; word-break: break-all;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reasons for expenses</span><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_4\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"费用事由\" value=\"\" id=\"DATA_4\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_22\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所在部门\" id=\"DATA_22\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Total budget application amount&nbsp;&nbsp;</span><br/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_1\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"总预算申请金额\" value=\"\" id=\"DATA_1\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Remarks</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Supervisor <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">opinion</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"主管意见\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"主管审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>sign：<input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"主管签字\" id=\"DATA_20\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"text-align: -webkit-center; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Financial opinion</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"财务审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"财务审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>sign：<input name=\"DATA_25\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"财务签字\" id=\"DATA_25\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color:#366092;font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 24px;\"><strong>Expense budget application form</strong></span></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">Applicant</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Recording date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_9\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录单日期\" id=\"DATA_9\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); border-style: solid; word-break: break-all;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Application type</span><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><select name=\"DATA_2\" class=\"form_item\" data-type=\"select\" id=\"DATA_2\" title=\"申请类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"个人预算\" selected=\"selected\">个人预算</option><option value=\"部门预算\">部门预算</option></select></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); border-style: solid; word-break: break-all;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reasons for expenses</span><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_4\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"费用事由\" value=\"\" id=\"DATA_4\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Department</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_22\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所在部门\" id=\"DATA_22\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Total budget application amount&nbsp;&nbsp;</span><br/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_1\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"总预算申请金额\" value=\"\" id=\"DATA_1\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Remarks</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Supervisor <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">opinion</span>&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"主管意见\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"主管审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>sign：<input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"主管签字\" id=\"DATA_20\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"text-align: -webkit-center; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Financial opinion</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"财务审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"财务审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>sign：<input name=\"DATA_25\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"财务签字\" id=\"DATA_25\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',29,17,0,NULL,NULL),(27,'travel expense ','<p style=\"text-align: center;\"><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 24px;\"><strong>Travel expense reimbursement</strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Number of invoices</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_2\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"发票数\" value=\"\" id=\"DATA_2\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reimbursement content</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"报销内容\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Total reimbursement amount</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146);\"><input name=\"DATA_5\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销总金额\" value=\"\" id=\"DATA_5\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Total reimbursement amount in words &nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146);\"><input name=\"DATA_6\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销总金额大写\" value=\"\" id=\"DATA_6\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; word-break: break-all; background-color: rgb(219, 238, 243); border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Remark</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_11\" id=\"DATA_11\" class=\"form_item\" data-type=\"textarea\" title=\"备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp; Comments of department head&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_18\" id=\"DATA_18\" class=\"form_item\" data-type=\"textarea\" title=\"部门主管审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_17\" class=\"form_item\" data-type=\"select\" id=\"DATA_17\" title=\"部门主管审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_15\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门主管签字\" id=\"DATA_15\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Financial opinion</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"财务审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"财务审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; Sign</span>：<input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"财务签字\" id=\"DATA_20\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px; text-align: -webkit-center;\">Leadership opinions</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_23\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"领导签字\" id=\"DATA_23\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p style=\"text-align: center;\"><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 24px;\"><strong>Travel expense reimbursement</strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_4\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请部门\" id=\"DATA_4\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Date</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请时间\" id=\"DATA_7\" datafld=\"SYS_DATE_CN\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Number of invoices</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_2\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"发票数\" value=\"\" id=\"DATA_2\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reimbursement content</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\" rowspan=\"1\" colspan=\"3\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><textarea name=\"DATA_12\" id=\"DATA_12\" class=\"form_item\" data-type=\"textarea\" title=\"报销内容\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Total reimbursement amount</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146);\"><input name=\"DATA_5\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销总金额\" value=\"\" id=\"DATA_5\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Total reimbursement amount in words &nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-width: 1px; border-style: solid; border-color: rgb(54, 96, 146);\"><input name=\"DATA_6\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销总金额大写\" value=\"\" id=\"DATA_6\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"text-align: left; width: 200px; font-size: 16px; height: 30px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; word-break: break-all; background-color: rgb(219, 238, 243); border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Remark</span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_11\" id=\"DATA_11\" class=\"form_item\" data-type=\"textarea\" title=\"备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp; Comments of department head&nbsp;&nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_18\" id=\"DATA_18\" class=\"form_item\" data-type=\"textarea\" title=\"部门主管审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_17\" class=\"form_item\" data-type=\"select\" id=\"DATA_17\" title=\"部门主管审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_15\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门主管签字\" id=\"DATA_15\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><br/></span></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Financial opinion</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_26\" id=\"DATA_26\" class=\"form_item\" data-type=\"textarea\" title=\"财务审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_24\" class=\"form_item\" data-type=\"select\" id=\"DATA_24\" title=\"财务审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; Sign</span>：<input name=\"DATA_20\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"财务签字\" id=\"DATA_20\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 18px; text-align: -webkit-center;\">Leadership opinions</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_29\" id=\"DATA_29\" class=\"form_item\" data-type=\"textarea\" title=\"领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"535\" orgheight=\"100\" style=\"font-size: 16px; width: 535px; height: 100px;\"></textarea><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_28\" class=\"form_item\" data-type=\"select\" id=\"DATA_28\" title=\"领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_23\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"领导签字\" id=\"DATA_23\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',29,18,0,NULL,NULL),(28,'Expense reimbursement application','<p><br/></p><p style=\"text-align: center;\"><span style=\"color:#366092;font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 24px;\"><strong>Expense reimbursement application</strong></span></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_2\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录单日期\" id=\"DATA_2\" datafld=\"SYS_DATE\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Type</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><select name=\"DATA_4\" class=\"form_item\" data-type=\"select\" id=\"DATA_4\" title=\"申请类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"个人报销\">个人报销</option><option value=\"部门报销\">部门报销</option></select></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_6\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销事由\" value=\"\" id=\"DATA_6\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp;Department&nbsp;&nbsp;</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所在部门\" id=\"DATA_7\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; Reimbursement amount&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_8\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"总报销金额\" value=\"\" id=\"DATA_8\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">&nbsp; &nbsp;Remark</span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_55\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"加班地点\" value=\"\" id=\"DATA_55\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"100\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 100px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Leader&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Personnel administrative approval &nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color:#366092;font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 24px;\"><strong>Expense reimbursement application</strong></span></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Applicant</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_3\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"申请人\" id=\"DATA_3\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">Date</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><input name=\"DATA_2\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录单日期\" id=\"DATA_2\" datafld=\"SYS_DATE\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">Type</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"><select name=\"DATA_4\" class=\"form_item\" data-type=\"select\" id=\"DATA_4\" title=\"申请类型\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"200\" style=\"width: 200px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"个人报销\">个人报销</option><option value=\"部门报销\">部门报销</option></select></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Reason</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_6\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"报销事由\" value=\"\" id=\"DATA_6\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\">&nbsp;Department&nbsp;&nbsp;</span></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_7\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所在部门\" id=\"DATA_7\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-size: 16px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">&nbsp; Reimbursement amount&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_8\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"总报销金额\" value=\"\" id=\"DATA_8\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family:微软雅黑, Microsoft YaHei\"><span style=\"font-size: 16px;\">&nbsp; &nbsp;Remark</span></span></td><td valign=\"middle\" align=\"left\" colspan=\"3\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_55\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"加班地点\" value=\"\" id=\"DATA_55\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"520\" orgheight=\"100\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 100px; width: 520px;\"/></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Leader&nbsp;<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">approval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_39\" id=\"DATA_39\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp;Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_37\" class=\"form_item\" data-type=\"select\" id=\"DATA_37\" title=\"部门领导审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_40\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导审批签字\" id=\"DATA_40\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_43\" id=\"DATA_43\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_41\" class=\"form_item\" data-type=\"select\" id=\"DATA_41\" title=\"CEO审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_44\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_44\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Personnel administrative approval &nbsp;</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_47\" id=\"DATA_47\" class=\"form_item\" data-type=\"textarea\" title=\"人事行政审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"520\" orgheight=\"100\" style=\"font-size: 16px; width: 520px; height: 100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; <span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Approval comments</span><span style=\"background-color: transparent; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">：<select name=\"DATA_45\" class=\"form_item\" data-type=\"select\" id=\"DATA_45\" title=\"人事行政审批意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;</span>Sign：<input name=\"DATA_48\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"人事行政审批签字\" id=\"DATA_48\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',55,19,0,NULL,NULL),(29,'Contract approval application','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Contract application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\" rowspan=\"1\" colspan=\"4\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Basic contract data</span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract name</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_34\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同名称\" value=\"\" id=\"DATA_34\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Classification</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_35\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同分类\" value=\"\" id=\"DATA_35\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Type</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_36\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同类型\" value=\"\" id=\"DATA_36\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract No</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_37\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同编号\" value=\"\" id=\"DATA_37\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"text-align: -webkit-center; background-color: rgb(219, 238, 243); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" width=\"166\"><input name=\"DATA_38\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所属部门\" id=\"DATA_38\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Business personnel</span></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><textarea name=\"DATA_41\" id=\"DATA_41\" class=\"form_item userselect\" data-type=\"textarea\" title=\"业务人员\" readonly=\"readonly\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"cursor: pointer;background: #fff url(/img/workflow/form/user_select.png) no-repeat right;height:30px;width:200px;font-size:16px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243); word-break: break-all;\"><p style=\"margin-bottom: 0px; padding: 0px; text-align: -webkit-center; white-space: normal;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Signing time&nbsp;&nbsp;</span></p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\"></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\" width=\"166\"><input name=\"DATA_42\" title=\"签约时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_42\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all; background-color: rgb(219, 238, 243);\"><p>Contract amount</p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\"><input name=\"DATA_43\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同金额\" value=\"\" id=\"DATA_43\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"150\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 150px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp; Start date&nbsp; &nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_45\" title=\"合同开始日期\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_45\" value=\"YYYY-MM-DD\" date_format=\"YYYY-MM-DD\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp;End date&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_46\" title=\"合同结束日期\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_46\" value=\"YYYY-MM-DD\" date_format=\"YYYY-MM-DD\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Entry personnel</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_47\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录入人员\" id=\"DATA_47\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><br/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Company information</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Party A</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_48\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方单位\" value=\"\" id=\"DATA_48\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_52\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方单位\" value=\"\" id=\"DATA_52\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact person of Party A</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_49\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方联系人\" value=\"\" id=\"DATA_49\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact person of Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_53\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方联系人\" value=\"\" id=\"DATA_53\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Contact information of Party A&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_50\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方联系方式\" value=\"\" id=\"DATA_50\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact information of Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_54\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方联系方式\" value=\"\" id=\"DATA_54\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract content</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(255, 255, 255); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_55\" id=\"DATA_55\" class=\"form_item\" data-type=\"textarea\" title=\"合同内容\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"680\" orgheight=\"100\" style=\"font-size: 16px; width: 680px; height: 100px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract remarks</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(255, 255, 255); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_61\" id=\"DATA_61\" class=\"form_item\" data-type=\"textarea\" title=\"合同备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"680\" orgheight=\"100\" style=\"font-size:16px;width:680px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); word-break: break-all; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract approval</span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Leader a<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_62\" id=\"DATA_62\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"570\" orgheight=\"100\" style=\"font-size: 16px; width: 570px; height: 100px;\"></textarea></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; Opinions：<select name=\"DATA_66\" class=\"form_item\" data-type=\"select\" id=\"DATA_66\" title=\"部门领导意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_69\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导签字\" id=\"DATA_69\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span><br/></p><p><br/></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_72\" id=\"DATA_72\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"570\" orgheight=\"100\" style=\"font-size:16px;width:570px;height:100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Opinions：<select name=\"DATA_73\" class=\"form_item\" data-type=\"select\" id=\"DATA_73\" title=\"CEO意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_75\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_75\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><br/></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>','<p><br/></p><p style=\"text-align: center;\"><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\">Contract application</span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"><strong><span style=\"font-size: 24px; font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\"><br/></span></strong></span></p><p><span style=\"color: rgb(54, 96, 146);\"></span></p><table border=\"1\" class=\"td-min-height\" style=\"border: 1px solid rgb(54, 96, 146);\" align=\"center\" data-sort=\"sortDisabled\"><tbody><tr class=\"firstRow\"><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\" rowspan=\"1\" colspan=\"4\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Basic contract data</span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract name</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_34\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同名称\" value=\"\" id=\"DATA_34\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Classification</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"center\"><input name=\"DATA_35\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同分类\" value=\"\" id=\"DATA_35\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Type</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_36\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同类型\" value=\"\" id=\"DATA_36\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract No</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_37\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同编号\" value=\"\" id=\"DATA_37\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"text-align: -webkit-center; background-color: rgb(219, 238, 243); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Department</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" width=\"166\"><input name=\"DATA_38\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"所属部门\" id=\"DATA_38\" datafld=\"SYS_DEPTNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243);\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Business personnel</span></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><textarea name=\"DATA_41\" id=\"DATA_41\" class=\"form_item userselect\" data-type=\"textarea\" title=\"业务人员\" readonly=\"readonly\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"cursor: pointer;background: #fff url(/img/workflow/form/user_select.png) no-repeat right;height:30px;width:200px;font-size:16px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; background-color: rgb(219, 238, 243); word-break: break-all;\"><p style=\"margin-bottom: 0px; padding: 0px; text-align: -webkit-center; white-space: normal;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Signing time&nbsp;&nbsp;</span></p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; background-color: rgb(219, 238, 243);\"></span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\" width=\"166\"><input name=\"DATA_42\" title=\"签约时间\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_42\" value=\"YYYY-MM-DD hh:mm:ss\" date_format=\"YYYY-MM-DD hh:mm:ss\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all; background-color: rgb(219, 238, 243);\"><p>Contract amount</p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\"></span></td><td rowspan=\"1\" valign=\"middle\" align=\"center\" width=\"166\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid; word-break: break-all;\"><input name=\"DATA_43\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"合同金额\" value=\"\" id=\"DATA_43\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"150\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 150px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp; Start date&nbsp; &nbsp;&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_45\" title=\"合同开始日期\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_45\" value=\"YYYY-MM-DD\" date_format=\"YYYY-MM-DD\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; &nbsp;End date&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_46\" title=\"合同结束日期\" class=\"form_item laydate-icon\" data-type=\"calendar\" id=\"DATA_46\" value=\"YYYY-MM-DD\" date_format=\"YYYY-MM-DD\" gwidth=\"200\" gheight=\"30\" orgfontsize=\"16\" style=\"width:200px;height:30px;font-size:16px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Entry personnel</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_47\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"录入人员\" id=\"DATA_47\" datafld=\"SYS_USERNAME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\"><br/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><br/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Company information</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Party A</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_48\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方单位\" value=\"\" id=\"DATA_48\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_52\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方单位\" value=\"\" id=\"DATA_52\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact person of Party A</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\"><input name=\"DATA_49\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方联系人\" value=\"\" id=\"DATA_49\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact person of Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_53\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方联系人\" value=\"\" id=\"DATA_53\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Contact information of Party A&nbsp;</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_50\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"甲方联系方式\" value=\"\" id=\"DATA_50\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contact information of Party B</span></td><td valign=\"middle\" align=\"center\" colspan=\"1\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; border-style: solid;\"><input name=\"DATA_54\" class=\"form_item\" data-type=\"text\" type=\"text\" title=\"乙方联系方式\" value=\"\" id=\"DATA_54\" orgfontsize=\"16\" orgalign=\"left\" orgwidth=\"200\" orgheight=\"30\" align=\"left\" style=\"font-size: 16px; text-align: left; height: 30px; width: 200px;\"/></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract content</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(255, 255, 255); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_55\" id=\"DATA_55\" class=\"form_item\" data-type=\"textarea\" title=\"合同内容\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"680\" orgheight=\"100\" style=\"font-size: 16px; width: 680px; height: 100px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(219, 238, 243); word-break: break-all; border-width: 1px; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract remarks</span></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); background-color: rgb(255, 255, 255); border-width: 1px; border-style: solid;\"><textarea name=\"DATA_61\" id=\"DATA_61\" class=\"form_item\" data-type=\"textarea\" title=\"合同备注\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"680\" orgheight=\"100\" style=\"font-size:16px;width:680px;height:100px;\"></textarea></td></tr><tr><td valign=\"middle\" align=\"center\" colspan=\"4\" rowspan=\"1\" style=\"border-color: rgb(54, 96, 146); border-width: 1px; background-color: rgb(219, 238, 243); word-break: break-all; border-style: solid;\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Contract approval</span></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">&nbsp; Leader a<span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; text-align: -webkit-center; text-wrap-mode: wrap; background-color: rgb(219, 238, 243);\">pproval</span></span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_62\" id=\"DATA_62\" class=\"form_item\" data-type=\"textarea\" title=\"部门领导审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"570\" orgheight=\"100\" style=\"font-size: 16px; width: 570px; height: 100px;\"></textarea></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\"><br/></span></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: transparent;\">&nbsp; Opinions：<select name=\"DATA_66\" class=\"form_item\" data-type=\"select\" id=\"DATA_66\" title=\"部门领导意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_69\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"部门领导签字\" id=\"DATA_69\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span><br/></p><p><br/></p></td></tr><tr><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; background-color: rgb(219, 238, 243); border-width: 1px; border-style: solid;\" align=\"center\"><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">CEO approval</span></td><td valign=\"middle\" style=\"border-color: rgb(54, 96, 146); word-break: break-all; border-width: 1px; border-style: solid;\" align=\"left\" rowspan=\"1\" colspan=\"3\"><p><textarea name=\"DATA_72\" id=\"DATA_72\" class=\"form_item\" data-type=\"textarea\" title=\"CEO审批\" value=\"\" rich=\"0\" orgfontsize=\"16\" orgwidth=\"570\" orgheight=\"100\" style=\"font-size:16px;width:570px;height:100px;\"></textarea></p><p><br/></p><p><span style=\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\">Opinions：<select name=\"DATA_73\" class=\"form_item\" data-type=\"select\" id=\"DATA_73\" title=\"CEO意见\" plugins=\"select\" size=\"1\" fieldflow=\"0\" orgwidth=\"100\" style=\"width: 100px;\"><option value=\"\" selected=\"selected\">&nbsp;</option><option value=\"同意\">同意</option><option value=\"不同意\">不同意</option></select>&nbsp; &nbsp; &nbsp;Sign：<input name=\"DATA_75\" type=\"text\" value=\"{macros}\" class=\"AUTO form_item\" data-type=\"macros\" title=\"CEO审批签字\" id=\"DATA_75\" datafld=\"SYS_USERNAME_DATETIME\" orghide=\"0\" orgfontsize=\"16\" orgwidth=\"200\" orgheight=\"30\" style=\"font-size: 16px; width: 200px; height: 30px;\" macrostype=\"1\"/></span></p><p><br/></p></td></tr></tbody></table><p style=\"text-align: center;\"><br/></p>',0,'','',75,20,0,NULL,NULL);
/*!40000 ALTER TABLE `flow_form_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_form_version`
--

DROP TABLE IF EXISTS `flow_form_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_form_version` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FORM_ID` int(11) NOT NULL COMMENT '表单ID',
  `PRINT_MODEL` mediumtext NOT NULL COMMENT '表单设计信息',
  `PRINT_MODEL_SHORT` mediumtext NOT NULL COMMENT '精简后的表单设计信息',
  `SCRIPT` text NOT NULL COMMENT '表单拓展脚本',
  `CSS` text NOT NULL COMMENT '表单扩展样式',
  `TIME` datetime NOT NULL COMMENT '版本时间',
  `MARK` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设计表单版本库';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_form_version`
--

LOCK TABLES `flow_form_version` WRITE;
/*!40000 ALTER TABLE `flow_form_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_form_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_hook`
--

DROP TABLE IF EXISTS `flow_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_hook` (
  `hid` int(11) NOT NULL AUTO_INCREMENT COMMENT '引擎ID',
  `flow_id` int(11) NOT NULL COMMENT '流程ID',
  `hname` varchar(40) NOT NULL COMMENT '业务引擎名称',
  `hdesc` varchar(200) NOT NULL COMMENT '描述',
  `hmodule` varchar(40) NOT NULL COMMENT '模块',
  `plugin` varchar(100) NOT NULL COMMENT '调用插件',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '状态(0-停用,1-必选,可选状态无效)',
  `map` text NOT NULL COMMENT '数据关系映射',
  `condition` text NOT NULL COMMENT '条件列表',
  `condition_set` text NOT NULL COMMENT '条件公式',
  `system` varchar(1) NOT NULL DEFAULT '1' COMMENT '是否系统内置(0-否,1-是)',
  `order_id` int(11) NOT NULL COMMENT '排序号',
  `data_direction` int(1) NOT NULL COMMENT '数据方向',
  PRIMARY KEY (`hid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='业务引擎';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_hook`
--

LOCK TABLES `flow_hook` WRITE;
/*!40000 ALTER TABLE `flow_hook` DISABLE KEYS */;
INSERT INTO `flow_hook` VALUES (19,159,'发文单业务接口（流程-业务）','发文单业务接口','document','',0,'发文字=>doc_no,标题=>title,主题词=>key_word,单位=>unit,缓急=>urgency,密级=>secrecy,主送=>main_delivery,抄送=>copy_delivery,保密期限=>deadline,份数=>copies,部门=>create_dept,印发机关=>print_dept,','','','1',20,2),(20,160,'发文处理单映射（流程-业务）','发文处理单映射','document','',0,'文件标题=>title,来文单位=>unit,缓急=>urgency,密级=>secrecy,份数=>copies,','','','1',30,2),(21,162,'报告单映射（流程-映射）','报告单映射','document','',0,'标题=>title,汇报单位=>unit,主送=>main_delivery,抄送=>copy_delivery,','','','1',40,2),(22,163,'会议纪要映射（流程-业务）','会议纪要映射','document','',0,'会议名称=>title,','','','1',50,2),(23,164,'收文单映射（流程-业务）','收文单映射','document','',0,'来文单位=>unit,来文文号=>doc_no,密级=>secrecy,保密期限=>deadline,紧急=>urgency,标题=>title,主题词=>key_word,限时时间=>deadline,份数=>copies,','','','1',60,2),(24,140,'请假映射','请假','attend_leave','',0,'申请人=>USER_ID,请假开始时间=>LEAVE_DATE1,请假结束时间=>LEAVE_DATE2,请假事由=>LEAVE_TYPE,人事行政审批签字=>LEADER_ID,','','','1',70,2),(25,143,'外出映射','外出','attend_out','',0,'申请人=>USER_ID,外出事由=>OUT_TYPE,外出开始时间=>OUT_TIME1,外出结束时间=>OUT_TIME2,人事行政审批签字=>LEADER_ID,','','','1',80,2),(26,142,'出差映射','出差','attend_evection','',0,'申请人=>USER_ID,出差地点=>EVECTION_DEST,出差开始时间=>EVECTION_DATE1,出差结束时间=>EVECTION_DATE2,人事行政审批签字=>LEADER_ID,出差事由=>REASON,','','','1',90,2),(27,169,'预算','','budgeting_process','',0,'用户id控件=>applicant,部门ID=>dept_id,申请时间=>application_date,支付方式=>per_pay,是否预算=>is_per,固定资产有无=>fixed_assets,项目ID=>budget_id,项目名称=>budget_item_name,大写可用金额=>is_payment,额度号=>line_no,款额=>payment,用途说明=>instructions,明细表=>schedule_of,部门主管审批=>department_head,校级主管是否同意=>is_opinion,会计审批意见=>accounting_advice,是否拆分=>is_break_up,会计签字=>treasurer_signature,财务主管审批意见=>treasurer_opinion,项目拆分=>break_up_plan,校长签字=>headmaster_signature,校长审批意见=>headmaster_opinion,实际支出金额=>actual_expenditure,大写2=>amount_words,项目拆分结果=>cashier_opinion,','','','1',1,2),(28,170,'入党申请','入党申请','party_member','',0,'姓名=>USER_NAME,提交时间=>APPLY_TIME,发展阶段=>DEVELOP_PHASE,申请人谈话意见=>ATT_URL1,党支部=>PARENT_PEDT_ID,入党申请书=>ATT_URL,性别=>SEX,部门=>USER_NAME,民族=>FAMILY_NAME,签字=>SIGN,出生日期=>BIRTHDAY,职务=>POST_ID,','','','1',1,2),(29,171,'积极分子','积极分子','party_member','',0,'支委会会议记录文件=>ATT_URL4,群团（工会/团支部）推优表文件=>ATT_URL3,入党积极分子备案表=>ATT_URL7,党员推荐汇总票文件=>ATT_URL2,支委会会议决议文件=>ATT_URL5,党员推荐票文件=>ATT_URL1,入党积极分子备案报告=>ATT_URL6,培养联系人登记表文件=>ATT_URL8,确定积极分子时间=>ACTIVISTS_TIME','','','1',1,2),(30,172,'积极分子思想汇报','积极分子思想汇报','party_member','',0,'思想汇报附件=>ATT_URL','','','1',1,2),(31,173,'发展对象和报上级党委备案','发展对象和报上级党委备案','party_member','',0,'征求党内外群众意见会议记录附件=>ATT_URL1,支委会会议记录附件=>ATT_URL2,支委会会议会议附件=>ATT_URL3,发展对象人选备案报告附件=>ATT_URL4,上级党委备案批复意见=>ATT_URL','','','1',1,2),(32,174,'发展对象公示,确认入党介绍人','发展对象公示,确认入党介绍人','party_member','',0,'确定发展对象公示=>ATT_URL1,确定发展对象公示结论=>ATT_URL2,确定入党介绍人附件=>ATT_URL3','','','1',1,2),(33,175,'政治审查开展集中培训','政治审查开展集中培训','party_member','',0,'政治审查函调材料附件=>ATT_URL1,政治审查综合报告附件=>ATT_URL2,短期集中培训材料附件=>ATT_URL3,确定发展对象期间思想汇报附件=>ATT_URL4','','','1',1,2),(34,176,'支委会审查','支委会审查','party_member','',0,'自传=>ATT_URL1,确定预备党员候选人会议记录=>ATT_URL2,拟接收预备党员公示=>ATT_URL3,拟接收预备党员公示结论=>ATT_URL4,拟接收预备党员预审请示附件=>ATT_URL5,上级党委预审意见=>ATT_URL6','','','1',1,2),(35,177,'支部大会讨论','支部大会讨论','party_member','',0,'\r\n接收预备党员表决票附件=>ATT_URL1,接收预备党员汇总票附件=>ATT_URL2,接收预备党员支部大会会议记录附件=>ATT_URL3,接收预备党员支部大会会议决议附件=>ATT_URL4,接收预备党员审批请示附件=>ATT_URL5,谈话人意见附件=>ATT_URL6,上级党委审批意见附件=>ATT_URL7,接收预备党员时间=>RECEIVE_TIME','','','1',1,2),(36,178,'入党宣誓','入党宣誓','party_member','',0,'入党宣誓活动纪实附件=>ATT_URL1','','','1',1,2),(37,179,'预备党员思想汇报','预备党员思想汇报','party_member','',0,'思想汇报附件=>ATT_URL','','','1',1,2),(38,180,'预备党员转正','预备党员转正','party_member','',0,'转正申请书=>ATT_URL1,征求党内外群众意见会议记录=>ATT_URL2,拟转正公示=>ATT_URL3,拟转正公示结论文件=>ATT_URL4,转正表决票文件=>ATT_URL5,转正表决汇总票=>ATT_URL6,支部大会会议记录=>ATT_URL7,支部大会会议决议文件=>ATT_URL8,转正审批请示=>ATT_URL9,上级党委审批意见=>ATT_URL','','','1',1,2),(39,181,'积极分子第四次思想汇报','积极分子第四次思想汇报','party_member','',0,'思想汇报附件=>ATT_URL,预备党员考察记录表=>ATT_URL1','','','1',1,2),(40,182,'预备党员第四次思想汇报','预备党员第四次思想汇报','party_member','',0,'思想汇报附件=>ATT_URL,中共预备党员教育考察表=>ATT_URL1','','','1',1,2),(41,183,'入党介绍人变更','入党介绍人变更','party_member','',0,'新入党介绍人姓名=>RECOMMEND_PERSON,附件=>ATT_URL1,PARTY_INTRODUCER=>PARTY_INTRODUCER,审批意见=>APPROVAL','','','1',260,2),(42,184,'培养联系人变更','培养联系人变更','party_member','',0,'\r\n新培养联系人姓名=>DEVELOP_CONTACTS,附件=>ATT_URL1,CONTACTS_CHANGE=>CONTACTS_CHANGE,审批意见=>APPROVAL','','','1',250,2),(43,185,'思想汇报','思想汇报','party_member','',0,'思想汇报附件=>ATT_URL1,思想汇报时间=>REPORT_TIME,REPORT=>REPORT,用户ID=>USER_ID','','','1',290,2),(44,186,'自传提交','自传提交','party_member','',0,'自传附件=>ATT_URL1,提交日期=>REPORT_TIME,AUTOBIOGRAPHY=>AUTOBIOGRAPHY','','','1',300,2),(45,187,'转正申请书提交','转正申请书提交','party_member','',0,'转正申请书附件=>ATT_URL1,提交时间=>REPORT_TIME,REGULAR=>REGULAR','','','1',310,2),(46,188,'培养考察档案移交','培养考察档案移交','','',0,'移交时间=>REPORT_TIME,用户ID=>USER_ID,ARCHIVES=>ARCHIVES,转交下一步人员=>SECRETARY,审批意见=>APPROVAL,材料转接证明=>ATT_URL1,','','','1',320,2);
/*!40000 ALTER TABLE `flow_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_manage_log`
--

DROP TABLE IF EXISTS `flow_manage_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_manage_log` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `FLOW_NAME` varchar(200) NOT NULL COMMENT '流程名称',
  `UID` int(11) NOT NULL COMMENT '操作用户唯一标识即用户表主键ID',
  `TIME` datetime NOT NULL COMMENT '操作时间',
  `IP` varchar(20) NOT NULL COMMENT '操作用户的IP地址',
  `TYPE` int(11) NOT NULL COMMENT '日志类型(1-增加,2-修改,3-删除,但实际1、2类型存的比较混乱)',
  `CONTENT` text NOT NULL COMMENT '日志内容',
  `USER_ID` varchar(40) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `I_TYPE` (`TYPE`) USING BTREE,
  KEY `I_USER_ID` (`USER_ID`) USING BTREE,
  KEY `I_TIME` (`TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程管理日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_manage_log`
--

LOCK TABLES `flow_manage_log` WRITE;
/*!40000 ALTER TABLE `flow_manage_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_manage_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_operation`
--

DROP TABLE IF EXISTS `flow_operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_operation` (
  `OP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `OP_NO` varchar(255) DEFAULT NULL COMMENT '排序号',
  `OP_NAME` varchar(255) DEFAULT NULL COMMENT '操作项名称',
  `USE_FUNC` varchar(255) DEFAULT NULL COMMENT '调用程序的方法',
  `PIC_NAME` varchar(255) DEFAULT NULL COMMENT '图标',
  PRIMARY KEY (`OP_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='关联操作设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_operation`
--

LOCK TABLES `flow_operation` WRITE;
/*!40000 ALTER TABLE `flow_operation` DISABLE KEYS */;
INSERT INTO `flow_operation` VALUES (1,'1','Official document distribution','documentExchangeReceive/insertDocumentReceive','conditionsSet'),(2,'2','Reissue of official documents','documentExchangeReceive/insertDocumentReceive','conditionsSet'),(3,'5','Query distribution','documentExchangeReceive/selectByRunId','requiredFields'),(8,'6','Work assignment','/flowAssign/saveWork','conditionsSet'),(13,'13','Internal distribution','','conditionsSet'),(14,'14','Done','workflow/work/updateFrpByPrcsId','conditionsSet'),(15,'15','Resume processing','workflow/work/updateFrpByPrcsId','conditionsSet');
/*!40000 ALTER TABLE `flow_operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_opinion`
--

DROP TABLE IF EXISTS `flow_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_opinion` (
  `OPINION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `OPINION_CONTENT` text COMMENT '意见模板内容',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '所属人',
  `OPINION_TYPE` varchar(10) DEFAULT NULL COMMENT '意见类型(0-公共，1个人)',
  `SORT_NO` int(11) DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`OPINION_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='常用意见管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_opinion`
--

LOCK TABLES `flow_opinion` WRITE;
/*!40000 ALTER TABLE `flow_opinion` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_opinion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_plugin`
--

DROP TABLE IF EXISTS `flow_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_plugin` (
  `flow_plugin_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '插件自增id',
  `flow_plugin_name` varchar(22) NOT NULL COMMENT '插件名称',
  `flow_plugin_instructions` varchar(150) DEFAULT NULL COMMENT '3、插件说明',
  `flow_plugin_perform` varchar(32) NOT NULL COMMENT '执行类型',
  `flow_plugin_model` varchar(32) DEFAULT NULL COMMENT '模块名',
  `flow_plugin_method` varchar(255) DEFAULT NULL COMMENT '方法',
  `flow_plugin_service` varchar(64) DEFAULT NULL COMMENT 'service类名',
  `flow_plugin_create_date` int(10) DEFAULT NULL COMMENT '创建时间',
  `flow_plugin_update_date` int(10) DEFAULT NULL COMMENT '修改时间',
  `flow_plugin_create_user` varchar(16) DEFAULT NULL COMMENT '插件创建人',
  `flow_plugin_update_user` varchar(16) DEFAULT NULL COMMENT '插件修改人',
  `flow_plugin_update_count` int(6) DEFAULT NULL COMMENT '插件修改次数',
  `flow_plugin_flag` int(1) NOT NULL DEFAULT '0' COMMENT '内部、外部插件标识符(0-内置 1-对外接口获取数据 2-数据推送对方接口)',
  PRIMARY KEY (`flow_plugin_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_plugin`
--

LOCK TABLES `flow_plugin` WRITE;
/*!40000 ALTER TABLE `flow_plugin` DISABLE KEYS */;
INSERT INTO `flow_plugin` VALUES (2,'自动提醒公告','用户设置后，自定义提醒公告','BEFORE_BACKEND','NotifyTrigger','addNotify(notify);','@Resource NotifyService notify',1498025565,NULL,'admin',NULL,1,0),(3,'预算压缩附件','用户设置后，可以讲流程附件，表单附件，以及表单压缩','BEFORE_BACKEND','BudgetCompressTrigger','updateAttachmentByRunId(budgetingProcess);','@Resource BudgetingProcessMapper budgetingProcessMapper',1537518116,NULL,'admin',NULL,1,0),(4,'材料变更','用户设置后，可以上传附件','BEFORE_BACKEND','ChangeAttachmentTrigger','',NULL,1537518116,NULL,'admin',NULL,1,0),(5,'组织关系','用户设置后，可以转入到其他党支部，也可以转出工队党委','BEFORE_BACKEND','ChangePartyBranchTrigger','',NULL,1537518116,NULL,'admin',NULL,1,0);
/*!40000 ALTER TABLE `flow_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_print_tpl`
--

DROP TABLE IF EXISTS `flow_print_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_print_tpl` (
  `T_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '模版ID',
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `T_TYPE` char(1) NOT NULL COMMENT '模版类型(1-打印模版,2-手写呈批单)',
  `T_NAME` varchar(100) NOT NULL COMMENT '打印模版名称',
  `CONTENT` mediumtext NOT NULL COMMENT '打印模版内容',
  `FLOW_PRCS` text NOT NULL COMMENT '可使用该模版的步骤',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`T_ID`) USING BTREE,
  KEY `FLOW_ID` (`FLOW_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='打印模版';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_print_tpl`
--

LOCK TABLES `flow_print_tpl` WRITE;
/*!40000 ALTER TABLE `flow_print_tpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_print_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_priv`
--

DROP TABLE IF EXISTS `flow_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_priv` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `PRIV_TYPE` int(11) NOT NULL COMMENT '授权类型(1-管理,2-监控,3-查询,4-编辑,5-点评)',
  `PRIV_SCOPE` text NOT NULL COMMENT '管理范围[SELF_ORG-本机构,ALL_DEPT-所有部门,SELF_DEPT-本部门,部门ID串]',
  `USER` text NOT NULL COMMENT '按人员设定授权范围',
  `DEPT` text NOT NULL COMMENT '按部门设定授权范围',
  `ROLE` text NOT NULL COMMENT '按角色设定授权范围',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='管理权限';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_priv`
--

LOCK TABLES `flow_priv` WRITE;
/*!40000 ALTER TABLE `flow_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_process`
--

DROP TABLE IF EXISTS `flow_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_process` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `PRCS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '步骤ID',
  `PRCS_TYPE` tinyint(4) NOT NULL DEFAULT '0' COMMENT '节点类型(0-步骤节点,1-自流程节点,2-外部流转节点)',
  `PRCS_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '步骤名称',
  `PRCS_USER` text COMMENT '经办人ID串',
  `PRCS_ITEM` text COMMENT '可写字段串',
  `HIDDEN_ITEM` text COMMENT '保密字段串',
  `REQUIRED_ITEM` text COMMENT '必填字段串',
  `PRCS_DEPT` text COMMENT '经办部门ID串',
  `PRCS_PRIV` text COMMENT '经办角色ID串',
  `PRCS_TO` text COMMENT '转交步骤ID串',
  `SET_LEFT` int(11) NOT NULL DEFAULT '0' COMMENT '节点横坐标',
  `SET_TOP` int(11) NOT NULL DEFAULT '0' COMMENT '节点纵坐标',
  `PLUGIN` text COMMENT '转交调用插件',
  `PLUGIN_SAVE` text NOT NULL COMMENT '保存调用插件',
  `PRCS_ITEM_AUTO` text NOT NULL COMMENT '允许在不可写情况下自动赋值的宏控件',
  `PRCS_IN` text NOT NULL COMMENT '转入条件组成的串',
  `PRCS_OUT` text NOT NULL COMMENT '转出条件组成的串',
  `FEEDBACK` varchar(20) NOT NULL DEFAULT '0' COMMENT '是否允许会签(0-允许会签,1-禁止会签,2-强制会签)',
  `PRCS_IN_SET` text NOT NULL COMMENT '转入条件组成的逻辑表达式',
  `PRCS_OUT_SET` text NOT NULL COMMENT '转出条件组成的逻辑表达式',
  `AUTO_TYPE` varchar(20) NOT NULL DEFAULT '' COMMENT '自动选人规则(1-自动选择流程发起人,2-自动选择本部门主管,3-指定自动选择默认人员,4-自动选择上级主管领导,5-自动选择一级部门主管,6-自动选择上级分管领导,7-按表单字段选择,8-自动选择指定步骤主办人,9-自动选择本部门助理,10-自动选择本部门内符合条件所有人员,11-自动选择本一级部门内符合条件所有人员,12-自动选择指定部门主管,13-自动选择指定部门助理,14-自动选择指定部门上级主管领导,15-自动选择指定部门上级分管领导)',
  `AUTO_DEPT` text NOT NULL COMMENT '自动选择指定自动选择的部门',
  `AUTO_USER_OP` text NOT NULL COMMENT '指定自动选择默认人员—主办人',
  `AUTO_USER` text NOT NULL COMMENT '指定自动选择默认人员—经办人',
  `AUTO_USER_OP_RETURN` text NOT NULL COMMENT '指定子流程返回父流程时自动选择默认人员—主办人',
  `AUTO_USER_RETURN` text NOT NULL COMMENT '指定子流程返回父流程时自动选择默认人员—经办人',
  `USER_FILTER` varchar(20) NOT NULL DEFAULT '' COMMENT '选人过滤规则(1-只允许选择本部门经办人,2-只允许选择本角色经办人,3-只允许选择上级部门经办人,4-只允许选择下级部门经办人,)',
  `USER_FILTER_PRCS_PRIV` text COMMENT '选人过滤规则指定角色',
  `USER_FILTER_PRCS_PRIV_OTHER` text COMMENT '选人过滤规则指定辅助角色',
  `USER_FILTER_PRCS_DEPT` text COMMENT '选人过滤规则指定部门',
  `USER_FILTER_PRCS_DEPT_OTHER` text COMMENT '选人过滤规则指定辅助部门',
  `TIME_OUT` varchar(20) NOT NULL DEFAULT '' COMMENT '办理时限',
  `TIME_OUT_MODIFY` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许转交时设置办理时限(0-不允许,1-允许)',
  `TIME_OUT_ATTEND` char(1) NOT NULL DEFAULT '0' COMMENT '是否排除非工作时段(按排班类型)：(0-否,1-是,)',
  `SIGNLOOK` char(1) NOT NULL DEFAULT '0' COMMENT '会签意见可见性(0-总是可见,1-本步骤经办人之间不可见,2-针对其他步骤不可见,)',
  `TOP_DEFAULT` char(1) NOT NULL DEFAULT '0' COMMENT '主办人相关选项：(0-明确指定主办人,1-先接收者为主办人,2-无主办人会签,)',
  `USER_LOCK` char(1) NOT NULL DEFAULT '1' COMMENT '是否允许修改主办人相关选项及默认经办人：(0-不允许,1-允许,)',
  `MAIL_TO` text NOT NULL COMMENT '转交时内部邮件通知以下人员ID串',
  `MAIL_TO_DEPT` text NOT NULL COMMENT '转交时内部邮件通知以下部门人员ID串',
  `MAIL_TO_PRIV` text NOT NULL COMMENT '转交时内部邮件通知以下角色人员ID串',
  `SYNC_DEAL` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许并发(0-禁止并发,1-允许并发,2-强制并发)',
  `SYNC_DEAL_CHECK` tinytext NOT NULL COMMENT '用途未知',
  `TURN_PRIV` char(1) NOT NULL DEFAULT '1' COMMENT '强制转交，经办人未办理完毕时是否允许主办人强制转交(0-不允许,1-允许,经办人工作强制结束 2-允许,经办人工作可继续办理)',
  `CHILD_FLOW` int(11) NOT NULL DEFAULT '0' COMMENT '子流程的流程ID',
  `GATHER_NODE` char(1) NOT NULL DEFAULT '0' COMMENT '并发合并选项(0-非强制合并,1-强制合并,)',
  `ALLOW_BACK` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许回退(0-不允许,1-允许回退上一步骤,2-允许回退之前步骤,)',
  `ATTACH_PRIV` varchar(50) NOT NULL DEFAULT '1,2,3,4,6,' COMMENT '公共附件中的Office文档详细权限设置：(1-新建权限,2-编辑权限,3-删除权限,4-下载权限,5-打印权限,6-查阅权限,)',
  `AUTO_BASE_USER` int(11) NOT NULL DEFAULT '0' COMMENT '部门针对对象步骤的ID，0为当前步骤。配合自动选人规则使用。当自动选人规则为以下选项时启用(2-自动选择本部门主管,4-自动选择上级主管领导,6-自动选择上级分管领导,9-自动选择本部门助理,)',
  `CONDITION_DESC` text NOT NULL COMMENT '不符合条件公式时，给用户的文字描述',
  `RELATION_IN` text NOT NULL COMMENT '父流程->子流程映射关系',
  `RELATION_OUT` text NOT NULL COMMENT '子流程->父流程映射关系',
  `REMIND_FLAG` int(11) NOT NULL COMMENT '用途未知',
  `DISP_AIP` int(11) NOT NULL DEFAULT '0' COMMENT '对应呈批单(0-表示不启用呈批单)',
  `TIME_OUT_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT '超时计算方法(0-本步骤接收后开始计时,1-上一步骤转交后开始计时,)',
  `ATTACH_EDIT_PRIV` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许本步骤经办人编辑附件(0-不允许,1-允许,)',
  `ATTACH_EDIT_PRIV_ONLINE` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许本步骤经办人在线创建文档(0-允许,1-不允许,)',
  `ATTACH_MACRO_MARK` char(1) NOT NULL DEFAULT '0' COMMENT '宏标记附件上传为图片时展示效果(0-显示图片,1-显示图标和名称,)',
  `CONTROL_MODE` text COMMENT '列表控件模式(1-修改模式,2-添加模式,3-删除模式,保存格式如下例：列表控件1,列表控件2,|1`2`3,1`2,)',
  `LIST_COLUMN_PRIV` text COMMENT '列表控件单独列权限(1-只读,2-保密,4-必填，各项的与值)',
  `VIEW_PRIV` int(1) DEFAULT NULL COMMENT '传阅设置(0-不允许,1-允许,)',
  `FILEUPLOAD_PRIV` text NOT NULL COMMENT '附件上传控件的权限(1-新建,2-编辑,3-删除,4-下载,5-打印)',
  `IMGUPLOAD_PRIV` text NOT NULL COMMENT '图片上传控件的权限(1-新建,2-删除,3-下载)',
  `SIGN_TYPE` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会签人设置(0-不允许,1-本步骤经办人,2-全部人员)',
  `COUNTERSIGN` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会签人加签(0-不允许，1-允许)',
  `WORKINGDAYS_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT '工作天数换算方式(0-24小时为一天，1-按个人排班类型工作时长为一天)',
  `DOCUMENT_EDIT_PRIV` int(11) NOT NULL DEFAULT '0' COMMENT '是否允许本步骤经办人编辑正文(0-不允许,1-允许,)',
  `DOCUMENT_EDIT_PRIV_DETAIL` varchar(255) DEFAULT NULL,
  `RELATION_ID` int(11) DEFAULT NULL COMMENT '应用关联表关联id',
  `OPERATION_BUTTON` varchar(255) DEFAULT NULL COMMENT '关联操作设置（flow_operation表）',
  `AUTO_ARCHIVE_SET` text COMMENT '归档设置',
  `TIME_AUTO_TURN` varchar(10) DEFAULT '0' COMMENT '超时自动转交(0-不自动转,1-自动转)',
  `RELATION_WORK_YN` char(10) NOT NULL DEFAULT '0' COMMENT '允许添加关联工作(0-不允许，1-允许)',
  `NOMAIN_SIGNER_FILE_YN` char(10) DEFAULT '1' COMMENT '是否允许本步骤无主办人会签上传、删除附件(含表单附件和图片上传，0-否，1-是)',
  `TURN_CONTINUE_YN` varchar(10) DEFAULT '0' COMMENT '允许转交后不办结本步骤，可继续办理(0-不允许,1-允许)',
  `PRCS_EXT_FLAG` varchar(255) DEFAULT NULL COMMENT '节点扩展属性',
  `COUNTERSIGN_AGAIN` char(1) DEFAULT '0' COMMENT '是否允许增加的经办人加签(0-不允许，1-允许)',
  `PRE_PROCESS` text COMMENT '前置办理步骤（如经过这些步骤需办结）',
  `PRESET_YN` char(1) DEFAULT '0' COMMENT '是否允许预设后续步骤经办人(0-否，1-是)',
  `ALLOW_BACK_OPINION` char(10) NOT NULL DEFAULT '0' COMMENT '是否必须填写回退意见(0-不必填,1-必填)',
  `ONE_CLICK_DELIVERY` char(10) NOT NULL DEFAULT '0' COMMENT '是否一键转交(0-否,1-是)',
  `SYNC_BACK_SET` char(10) DEFAULT '1' COMMENT '并发回退设置（1.仅回退本并发分支 2.回退所有未转交的并发分支 3.回退所有并发分支，且删除已转交的后续步骤）',
  `PRCS_JOB` text COMMENT '经办岗位ID串',
  `PRCS_BUSINESS_TYPE` varchar(20) DEFAULT NULL COMMENT '业务应用节点类型',
  `AUTO_FLOW_PANEL` char(10) DEFAULT '0' COMMENT '是否允许自动展开预设面板 0-否 1-是',
  `DO_MODLE` char(10) DEFAULT NULL COMMENT '办理模式选项（1-同时办理，最后办结者转交  2-同时办理，均可转交  3-依次办理），固定流程不出现 依次办理 选择，只有自由流程允许出现 依次办理',
  `SYNC_SELECT_SET` varchar(200) DEFAULT '' COMMENT '默认勾选并发步骤，用,拼接',
  `PLUGIN_DELETE` varchar(200) DEFAULT NULL COMMENT '删除流程调用插件',
  `PLUGIN_BACK` varchar(200) DEFAULT NULL COMMENT '回退流程调用插件',
  `SYNC_UNCHECK_SET` char(10) DEFAULT '0' COMMENT '是否允许取消预设的步骤（0-否，1-是）',
  `PRCS_TO_LINE` varchar(255) DEFAULT NULL COMMENT '节点连线(1,2,3, 对应三种线型 1表示直线(sl)、2表示中段可左右移动型折线(lr)、3中段可上下移动型折线(tb))',
  `IS_SELECT_BRANCH` char(10) DEFAULT '1' COMMENT '是否允许选择本分支机构之外人员，默认是允许（0-否，1-是）',
  `FOLD_TYPE` char(10) DEFAULT '0' COMMENT '移动端是否默认折叠表单，默认不折叠（0-不折叠，1-折叠）',
  `PRCS_OUT_END` text COMMENT '针对步骤结束流程的转出条件字符串串',
  `PRCS_OUT_END_SET` text COMMENT '针对步骤结束流程的转出条件组成的逻辑表达式',
  `PRCS_OUT_END_DESC` text COMMENT '针对步骤结束流程的转出条件失败时候的描述',
  `AUTO_NEXT_PRCS` char(10) DEFAULT '0' COMMENT '自动跳过下一步骤（0-否，1-是）',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FLOW_ID` (`FLOW_ID`) USING BTREE,
  KEY `FORM_ID` (`PRCS_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2152 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程步骤定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_process`
--

LOCK TABLES `flow_process` WRITE;
/*!40000 ALTER TABLE `flow_process` DISABLE KEYS */;
INSERT INTO `flow_process` VALUES (1584,140,1,0,'Leave application','','[A@],申请人,申请部门,申请时间,请假类型,请假开始时间,请假结束时间,请假事由','','填表日期,申请人,申请部门,请假类型,请假开始时间,请假结束时间,请假事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',122,201,'','','','','','0','','','','','','','','','','','','','','2,hour','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1585,140,2,0,'Approval of department leader','','[A@],部门领导审批,部门领导审批意见,部门领导签字','','填表日期,申请人,申请部门,请假类型,请假开始时间,请假结束时间,请假事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',274,203,'','','','','','0','','','','','','','','','','','','','','2,hour','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1589,140,3,0,'CEO approval','','[A@],CEO审批,CEO审批意见,CEO审批签字','','填表日期,申请人,申请部门,请假类型,请假开始时间,请假结束时间,请假事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',478,202,'','','','','','0','','','','','','','','','','','','','','2,hour','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'请注意','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1590,140,4,0,'Personnel administrative approval','','[A@],人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',663,201,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1591,141,1,0,'application','','[A@],申请人,申请部门,申请时间,职务,加班开始时间,加班结束时间,加班地点,加班事由,[B@]','','申请人,申请部门,申请时间,职务,加班开始时间,加班结束时间,加班地点,加班事由,','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',34,168,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1592,141,2,0,'Approval of department leader','','部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',128,176,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1593,141,3,0,'CEO approval','admin,','CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',303,176,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1597,142,1,0,'application','','[A@],申请人,申请部门,申请时间,职务,出差地点,出差开始时间,出差结束时间,预计费用,出差事由','','填表日期,姓名,所属部门,职务,联系电话,出差地点,出差开始时间,出差结束时间,预计费用,出差事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',149,134,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1598,142,2,0,'Approval of department leader','','[A@],部门领导审批,部门领导审批意见,部门领导审批签字','','填表日期,姓名,所属部门,职务,联系电话,出差地点,出差开始时间,出差结束时间,预计费用,出差事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',283,138,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1599,142,3,0,'CEO approval','','[A@],CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',466,137,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1600,143,1,0,'application','','[A@],申请人,申请部门,申请时间,职务,外出单位,外出开始时间,外出结束时间,外出地点,外出事由,[B@]','','填表日期,姓名,所属部门,职务,联系电话,外出单位,外出地点,外出开始时间,外出结束时间,外出事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',95,128,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1601,143,2,0,'Approval of department leader','','[A@],部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',297,132,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1602,143,3,0,'CEO approval','','[A@],CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',551,143,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1603,144,1,0,'application','admin,','[A@],受理日期,受理时间,受理人,受理方式,联系人,电话,单位名称,值班事由,[B@]','','编号,受理日期,具体时间,受理人,受理方式,单位名称,电话,联系人,值班事由','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',235,99,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1604,144,2,0,'Approval of department leader','admin,','部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,,',463,150,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1605,144,3,0,'CEO approval','admin,','CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',771,181,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1606,145,1,0,'application','admin,','[A@],申请人,申请时间,申请部门,职务,入职日期,试用期,转正薪资,试用期主要工作描述,自我评价,[B@]','','填表日期,申请人,职务,所属部门,入职时间,试用期,转正薪资,试用期主要工作描述,自我评价','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',100,90,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1607,145,2,0,'Approval of department leader','admin,','[A@],部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',286,105,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1608,145,3,0,'CEO approval','liutong,admin,','[A@],CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',508,110,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1609,145,4,0,'Personnel administrative approval','admin,','人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',715,117,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1610,146,1,0,'application','admin,','[A@],申请人,申请时间,申请部门,职务,卡号,申请调薪原因,[B@]','','填表日期,申请人,职务,所属部门,卡号,申请调薪原因','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',72,104,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1611,146,2,0,'Approval of department leader','admin,','[A@],部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',256,115,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,1,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1612,146,3,0,'CEO approval','admin,','CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',507,127,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,1,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1613,146,4,0,'Personnel administrative approval','admin,','人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',730,133,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,1,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1629,159,1,0,'Draft document','admin,','[A@],标题,主题词,主送,抄送,单位,拟稿人,部门,份数,印发机关,印发日期,印发人','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',110,164,'','','','','','0','','','','','','DATA_27,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1630,159,2,0,'Check draft','admin,liutong,gb,','[A@],核稿,校对','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',281,173,'','','','','','0','','','','','','DATA_27,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1631,159,3,0,'Department head','admin,','[A@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','4,5,',508,178,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1632,159,4,0,'general manager','admin,','[A@],签发,会签','','','1,2,','1,2,4,6,8,12,14,15,5,7,9,13,16,','5,',698,182,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1633,159,5,0,'No. and seal','admin,','[A@],发文字,年,号,缓急,密级,保密期限,定密依据','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','0,',715,327,'','','','','','0','','','','','','DATA_2,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1682,160,1,0,'Draft','admin,','[A@],收文日期,发文字,字,号,来文单位,原发文字,原字,原号,原文日期,份数,缓急,密级,标题,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',126,116,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1683,160,2,0,'Department head','admin,','[A@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',309,125,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1684,160,3,0,'General manager approval','admin,','[A@],领导批示','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','0,',508,133,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1794,162,1,0,'Draft','admin,','[A@],汇报单位,汇报时间,标题,主送,抄送,附件,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',180,100,'','','','','','0','','','','','','DATA_7,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1796,162,2,0,'Department leader','admin,','[A@],部门批示','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',370,110,'','','','','','0','','','','','','DATA_7,','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1797,162,3,0,'General manager approval','admin,','[A@],领导批示','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','0,',611,117,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1877,163,1,0,'Draft','admin,','[A@],会议名称,时间,会议地点,主持人,出席人员,列席人员,会议主题,会议内容,记录人,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',194,134,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1878,163,2,0,'Leader approval','admin,','领导签字','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','0,',358,153,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1888,164,1,0,'Incoming document registration','admin,','[A@],发文字,年,号,收文时间,来文单位,密级,保密期限,紧急,标题,主题词,限时时间,份数,页数,送签领导,收文类型,收文编号,备注,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',168,98,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',1,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1889,164,2,0,'Leadership instructions','admin,','[A@],领导批示','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',330,110,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1890,164,3,0,'Completion of incoming documents','admin,','[A@],领导批示','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','0,',522,132,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'','',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1900,139,1,0,'application','','[A@],申请人,申请时间,申请部门,职务,用印类型,用印数量,报送单位,申请事由,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',107,97,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','0','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1901,139,2,0,'Approval of department leader','','部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',311,111,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1902,139,3,0,'CEO approval','','CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',556,122,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1909,165,1,0,'applicant','','[A@],申请人,录单日期,申请类型,费用事由,所在部门,总预算申请金额,备注','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',154,134,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','0','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1910,165,2,0,'Supervisor comments','','[A@],主管意见,主管审批意见,主管签字','','主管领导意见,主管领导签字,','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',292,145,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1911,165,3,0,'Financial opinion','','[A@],财务审批,财务审批意见,财务签字','','财务意见,财务签字,','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',489,143,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1913,166,1,0,'applicant','','[A@],申请人,申请部门,申请时间,发票数,报销内容,报销总金额,报销总金额大写,备注,[B@]','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','2,',63,135,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','0','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1914,166,2,0,'Comments of department head','','[A@],部门主管审批,部门主管审批意见,部门主管签字','','','','1,2,4,6,8,12,14,15,5,7,9,13,16,','3,',221,146,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',1,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1917,166,3,0,'Financial opinion','','[A@],财务审批,财务审批意见,财务签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',399,139,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1919,167,1,0,'applicant','admin,','[A@],申请人,录单日期,申请类型,报销事由,所在部门,总报销金额,加班地点,[B@]','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',96,185,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1920,167,2,0,'Approval of department leader','admin,','[A@],部门领导审批,部门领导审批意见,部门领导审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',275,191,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1921,167,3,0,'CEO approval','admin,','[A@],CEO审批,CEO审批意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','4,',463,192,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1923,168,1,0,'applicant','admin,','[A@],合同名称,合同分类,合同类型,合同编号,所属部门,业务人员,签约时间,合同金额,合同开始日期,合同结束日期,录入人员,甲方单位,乙方单位,甲方联系人,乙方联系人,甲方联系方式,乙方联系方式,合同内容,合同备注,[B@]','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','2,',122,102,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','1,2,3,4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,1,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(1924,168,2,0,'Approval of department leader','admin,','[A@],部门领导审批,部门领导意见,部门领导签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','3,',250,120,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2066,166,4,0,'Leadership opinions','','[A@],领导审批,领导审批意见,领导签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',633,154,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',1,'[]','[]',1,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2067,141,4,0,'Personnel administrative approval','','人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',468,185,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2068,144,4,0,'Personnel administrative approval','','人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',1185,207,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2069,142,4,0,'Personnel administrative approval','','[A@],人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',672,148,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2070,143,4,0,'Personnel administrative approval','','[A@],人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',794,132,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2071,168,3,0,'CEO approval','','[A@],CEO审批,CEO意见,CEO审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',608,151,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2072,167,4,0,'Personnel administrative approval','','[A@],人事行政审批,人事行政审批意见,人事行政审批签字','','','','1,2,3,5,7,9,11,12,4,6,8,10,13,','0,',716,227,'','','','','','0','','','','','','','','','','','','','','','0','0','0','0','1','','','','0','','1',0,'0','2','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2073,169,1,0,'Party application','liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,','[A@],申请人,申请部门,申请时间,支付方式,用途简述,是否预算,固定资产有无,项目ID,项目名称,额度号,款额,大写,合同,用途说明,用途说明附件,收款单位,明细表,用户id控件,部门ID,[B@]','','支付方式,是否预算,项目ID,项目名称,款额,大写,','','','2,',76,339,'','','','','\"款额\">=\"30000\"\n\"合同\"!=\"\"\n\"款额\"<\"30000\"\n','0','','([1] AND [2]) OR [3]','1','','','','','','0','','','','','','0','0','0','0','1','','','','2','','1',0,'1','0','1,2,3,4,5,',0,'3万元以上项目需要提交合同','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2074,169,2,0,'Department head','liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,','[A@],合同,会议纪要,部门主管审批是否同意,部门主管审批,部门主管签字','','DATA_129,','','','3,1,',355,83,'','','','','\"款额\">=\"100000\"\n\"会议纪要\"!=\"\"\n\"款额\"<\"100000\"\n','0','','([1] AND [2]) OR [3]','2','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'10万元以上项目请联系办公室上传会议纪要后方可转交！','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2075,169,3,0,'School level supervisor','liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,','[A@],校级主管是否同意,校级主管审批意见,校级主管签字','','DATA_184,DATA_185,','','','4,1,',378,174,'','','','','','0','','','4','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2076,169,4,0,'Accounting review payment','liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,','[A@],合同,会议纪要,会计审批意见,是否拆分,会计签字,会计,项目拆分','','DATA_142,','','','5,1,',362,270,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2077,169,5,0,'Approval of financial supervisor','','[A@],合同,会议纪要,财务主管审批是否同意,财务主管签字,财务主管审批意见','','DATA_201,DATA_193,','','2,3,5,7,9,11,4,6,8,10,12,1,13,','6,7,1,',369,347,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2078,169,6,0,'President approval','','[A@],合同,会议纪要,校长审批是否同意,校长签字,校长审批意见','','DATA_208,DATA_195,','','2,3,5,7,9,11,4,6,8,10,12,1,13,','7,1,',372,464,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2079,169,7,0,'The cashier receives and makes an appointment with the initiator','','[A@],合同,会议纪要,财务主管审批是否同意,财务主管审批意见,实际支出金额,大写2,支票号,项目拆分结果','','DATA_204,DATA_205,DATA_206,','','2,3,5,7,9,11,4,6,8,10,12,1,13,','9,0,',503,405,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2080,169,9,0,'Fixed property register','','[A@],合同,会议纪要','','','','2,3,5,7,9,11,4,6,8,10,12,1,13,','0,',670,406,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','4,5,',0,'','','',0,0,'0','1','0','0','','',0,'','',0,0,'0',0,NULL,NULL,NULL,NULL,'0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2081,170,1,0,'Party membership applicant','','[C@],[A@],出生日期,民族,入党申请书,提交时间,支部书记（组织委员）预设','','民族,入党申请书,','','','2,',95,174,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_31\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_32\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2082,170,2,0,'Branch secretary','','申请人谈话意见,签字,支部书记（组织委员）预设','','申请人谈话意见,','','','3,',287,191,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_31\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_32\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2083,170,3,0,'Party masses Department','','','','','','','4,',544,186,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_31\":[\"1\"]},{\"FILE_PRIV_DATA_32\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2084,170,4,0,'Contact leaders','','','','','','','0,',806,205,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_31\":[\"1\"]},{\"FILE_PRIV_DATA_32\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2085,171,1,0,'Branch secretary','','[C@],[A@],党员推荐票文件,党员推荐票日期,党员推荐汇总票文件,党员推荐汇总票日期,群团（工会/团支部）推优表文件,群团（工会/团支部）推优表日期,支委会会议记录文件,支委会会议记录日期,支委会会议决议文件,支委会会议决议日期,入党积极分子备案报告,入党积极分子备案报告日期,入党积极分子备案表,入党积极分子备案表日期,培养联系人登记表文件,培养联系人登记表日期,培养联系人姓名,确定积极分子时间,[B@]','','党员推荐票文件,党员推荐汇总票文件,群团（工会/团支部）推优表文件,支委会会议记录文件,支委会会议决议文件,入党积极分子备案报告,入党积极分子备案表,培养联系人登记表文件,','','','2,',160,86,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_9\":[]},{\"FILE_PRIV_DATA_11\":[]},{\"FILE_PRIV_DATA_15\":[]},{\"FILE_PRIV_DATA_18\":[]},{\"FILE_PRIV_DATA_26\":[]},{\"FILE_PRIV_DATA_28\":[]},{\"FILE_PRIV_DATA_30\":[]},{\"FILE_PRIV_DATA_33\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2086,171,2,0,'Party masses Department','','支部书记签字','','支部书记签字,','','','3,',283,103,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_9\":[\"1\"]},{\"FILE_PRIV_DATA_11\":[\"1\"]},{\"FILE_PRIV_DATA_15\":[\"1\"]},{\"FILE_PRIV_DATA_18\":[\"1\"]},{\"FILE_PRIV_DATA_26\":[\"1\"]},{\"FILE_PRIV_DATA_28\":[\"1\"]},{\"FILE_PRIV_DATA_30\":[\"1\"]},{\"FILE_PRIV_DATA_33\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2087,171,3,0,'Contact leaders','','','','','','','0,',486,101,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_9\":[\"1\"]},{\"FILE_PRIV_DATA_11\":[\"1\"]},{\"FILE_PRIV_DATA_15\":[\"1\"]},{\"FILE_PRIV_DATA_18\":[\"1\"]},{\"FILE_PRIV_DATA_26\":[\"1\"]},{\"FILE_PRIV_DATA_28\":[\"1\"]},{\"FILE_PRIV_DATA_30\":[\"1\"]},{\"FILE_PRIV_DATA_33\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2088,172,1,0,'Party membership applicant','','[C@],[A@],思想汇报时间,思想汇报结束时间,思想汇报附件,[B@]','','思想汇报附件,','','','2,',120,119,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_10\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_12\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2089,172,2,0,'Branch secretary','','','','','','','3,',415,122,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_10\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_12\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2090,172,3,0,'Party masses Department','','','','','','','4,',660,137,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2091,172,4,0,'Contact leaders','','预备党员考察记录表','','','','','0,',903,136,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_10\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_12\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2092,173,1,0,'Branch secretary','','[C@],[A@],征求党内外群众意见会议记录附件,征求党内外群众意见会议记录附件上传时间,支委会会议记录附件,支委会会议记录附件上传时间,支委会会议会议附件,支委会会议决议附件上传时间,发展对象人选备案报告附件,展对象人选 备案报告附件上传时间,[B@]','','','','','2,',198,163,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_41\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_42\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_48\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_32\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2093,173,2,0,'Head of the party masses Department','','上级党委备案批复意见,上级党委备案批复意见日期','','','','','3,',346,181,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_10\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_15\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_17\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_32\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2094,173,3,0,'Branch secretary','','支部书记签字,提交时间','','','','','4,',697,189,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_10\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_15\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_17\":[\"4\",\"1\"]},{\"FILE_PRIV_DATA_32\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2095,173,4,0,'Contact leaders','','','','','','','0,',1096,208,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2096,174,1,0,'Branch secretary','','确定发展对象公示,确定发展对象公示时间,确定发展对象公示结论,确定发展对象公示结论时间,确定入党介绍人附件,确定入党介绍人,入党介绍人姓名','','确定发展对象公示,确定发展对象公示结论,','','','2,',38,108,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[]},{\"FILE_PRIV_DATA_10\":[]},{\"FILE_PRIV_DATA_12\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2097,174,2,0,'Party masses Department','','','','','','','3,',227,125,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2098,174,3,0,'Contact leaders','','','','','','','0,',502,131,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2099,175,1,0,'Branch secretary','','政治审查开始时间,政治审查结束时间,集中培训开始时间,集中培训结束时间,政治审查函调材料附件,政治审查函调材料签字,政治审查综合报告附件,政治审查综合报告签字,短期集中培训材料附件,短期集中培训材料签字,确定发展对象期间思想汇报附件','','政治审查开始时间,政治审查结束时间,集中培训开始时间,集中培训结束时间,政治审查函调材料附件,政治审查综合报告附件,短期集中培训材料附件,确定发展对象期间思想汇报附件,','','','2,',89,131,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_10\":[]},{\"FILE_PRIV_DATA_13\":[]},{\"FILE_PRIV_DATA_15\":[]},{\"FILE_PRIV_DATA_17\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2100,175,2,0,'Party masses Department','','','','','','','3,',297,135,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2101,175,3,0,'Contact leaders','','','','','','','0,',560,136,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2102,176,1,0,'Branch secretary','','自传,自传日期,确定预备党员候选人会议记录,确定预备党员候选人会议记录日期,拟接收预备党员公示,拟接收预备党员公示日期,拟接收预备党员公示结论,拟接收预备党员公示结论日期,拟接收预备党员预审请示附件,拟接收预备党员预审请示附件上传时间,上级党委审核人预设','','自传,自传日期,确定预备党员候选人会议记录,确定预备党员候选人会议记录日期,拟接收预备党员公示,拟接收预备党员公示日期,拟接收预备党员公示结论,拟接收预备党员公示结论日期,拟接收预备党员预审请示附件,拟接收预备党员预审请示附件上传时间,','','','2,',117,135,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_25\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_28\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_33\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_35\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_38\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_45\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2103,176,2,0,'Party masses Department','','上级党委预审意见,上级党委预审意见日期','','上级党委预审意见,上级党委预审意见日期,','','','3,',306,150,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_25\":[\"1\"]},{\"FILE_PRIV_DATA_28\":[\"1\"]},{\"FILE_PRIV_DATA_33\":[\"1\"]},{\"FILE_PRIV_DATA_35\":[\"1\"]},{\"FILE_PRIV_DATA_38\":[\"1\"]},{\"FILE_PRIV_DATA_45\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2104,176,3,0,'Branch secretary','','','','','','','4,',558,155,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2105,176,4,0,'Contact leaders','','','','','','','5,',750,159,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2106,176,5,0,'Secretary of the Party committee','','','','','','','0,',1016,182,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2107,177,1,0,'Branch secretary','','接收预备党员表决票附件,接收预备党员表决票日期,接收预备党员汇总票附件,接收预备党员汇总票日期,接收预备党员支部大会会议记录附件,接收预备党员支部大会会议记录日期,接收预备党员支部大会会议决议附件,接收预备党员支部大会会议决议日期,接收预备党员审批请示附件,接收预备党员审批请示日期','','接收预备党员表决票附件,党员推荐票日期,接收预备党员汇总票附件,接收预备党员汇总票日期,接收预备党员支部大会会议记录附件,接收预备党员支部大会会议记录日期,接收预备党员支部大会会议决议附件,接收预备党员支部大会会议决议日期,接收预备党员审批请示附件,接收预备党员审批请示日期,','','','2,',60,181,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_61\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_62\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_63\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_64\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_65\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_52\":[]},{\"FILE_PRIV_DATA_53\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2108,177,2,0,'Party masses Department','','谈话人意见附件,谈话人意见时间,上级党委审批意见附件,上级党委审批意见时间','','谈话人意见附件,谈话人意见时间,上级党委审批意见附件,上级党委审批意见时间,','','','3,',209,190,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_61\":[\"1\"]},{\"FILE_PRIV_DATA_62\":[\"1\"]},{\"FILE_PRIV_DATA_63\":[\"1\"]},{\"FILE_PRIV_DATA_64\":[\"1\"]},{\"FILE_PRIV_DATA_65\":[\"1\"]},{\"FILE_PRIV_DATA_52\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_53\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2109,177,3,0,'Branch secretary','','接收预备党员时间,支部书记签字','','接收预备党员时间,支部书记签字,','','','4,',470,188,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_61\":[\"1\"]},{\"FILE_PRIV_DATA_62\":[\"1\"]},{\"FILE_PRIV_DATA_63\":[\"1\"]},{\"FILE_PRIV_DATA_64\":[\"1\"]},{\"FILE_PRIV_DATA_65\":[\"1\"]},{\"FILE_PRIV_DATA_52\":[\"1\"]},{\"FILE_PRIV_DATA_53\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2110,177,4,0,'Contact leaders','','','','','','','5,',781,179,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2111,177,5,0,'Secretary of the Party committee','','','','','','','0,',1079,188,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2112,178,1,0,'Party membership applicant','','思想汇报开始时间,思想汇报结束时间,思想汇报附件','','思想汇报开始时间,思想汇报结束时间,思想汇报附件,','','','2,',133,111,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_8\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2113,178,2,0,'Branch secretary','','','','','','','3,',336,131,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2114,178,3,0,'Party masses Department','','','','','','','4,',612,146,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2115,178,4,0,'Contact leaders','','','','','','','0,',859,169,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2116,179,1,0,'Branch secretary','','转正申请书,提交时间,征求党内外群众意见会议记录,征求党内外群众意见会议记录日期,拟转正公示,拟转正公示日期,拟转正公示结论文件,拟转正公示结论日期,转正表决票文件,转正表决票日期,转正表决汇总票,转正表决汇总票日期,支部大会会议记录,支部大会会议记录日期,支部大会会议决议文件,支部大会会议决议日期,转正审批请示,转正审批请示日期,转正支部大会时间,支部书记签字','','转正申请书,提交时间,征求党内外群众意见会议记录,征求党内外群众意见会议记录日期,拟转正公示,拟转正公示日期,拟转正公示结论文件,拟转正公示结论日期,转正表决票文件,转正表决票日期,转正表决汇总票,转正表决汇总票日期,支部大会会议记录,支部大会会议记录日期,支部大会会议决议文件,支部大会会议决议日期,转正审批请示,转正审批请示日期,转正支部大会时间,支部书记签字,','','','2,',127,126,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_67\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_68\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_14\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_17\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_20\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_22\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_24\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_40\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_75\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2117,179,2,0,'Party masses Department','','上级党委审批意见,审批时间','','上级党委审批意见,','','','3,',355,164,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"1\"]},{\"FILE_PRIV_DATA_67\":[\"1\"]},{\"FILE_PRIV_DATA_68\":[\"1\"]},{\"FILE_PRIV_DATA_14\":[\"1\"]},{\"FILE_PRIV_DATA_17\":[\"1\"]},{\"FILE_PRIV_DATA_20\":[\"1\"]},{\"FILE_PRIV_DATA_22\":[\"1\"]},{\"FILE_PRIV_DATA_24\":[\"1\"]},{\"FILE_PRIV_DATA_40\":[\"1\"]},{\"FILE_PRIV_DATA_75\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2118,179,3,0,'Branch secretary','','第二次支部书记签字','','第二次支部书记签字,','','','4,',625,163,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"1\"]},{\"FILE_PRIV_DATA_67\":[\"1\"]},{\"FILE_PRIV_DATA_68\":[\"1\"]},{\"FILE_PRIV_DATA_14\":[\"1\"]},{\"FILE_PRIV_DATA_17\":[\"1\"]},{\"FILE_PRIV_DATA_20\":[\"1\"]},{\"FILE_PRIV_DATA_22\":[\"1\"]},{\"FILE_PRIV_DATA_24\":[\"1\"]},{\"FILE_PRIV_DATA_40\":[\"1\"]},{\"FILE_PRIV_DATA_75\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2119,179,4,0,'Contact leaders','','','','','','','5,',843,165,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2120,179,5,0,'Secretary of the Party committee','','','','','','','0,',1050,159,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2121,180,1,0,'Branch secretary','','转正申请书,提交时间,征求党内外群众意见会议记录,征求党内外群众意见会议记录日期,拟转正公示,拟转正公示日期,拟转正公示结论文件,拟转正公示结论日期,转正表决票文件,转正表决票日期,转正表决汇总票,转正表决汇总票日期,支部大会会议记录,支部大会会议记录日期,支部大会会议决议文件,支部大会会议决议日期,转正审批请示,转正审批请示日期,转正支部大会时间,支部书记签字','','转正申请书,提交时间,征求党内外群众意见会议记录,征求党内外群众意见会议记录日期,拟转正公示,拟转正公示日期,拟转正公示结论文件,拟转正公示结论日期,转正表决票文件,转正表决票日期,转正表决汇总票,转正表决汇总票日期,支部大会会议记录,支部大会会议记录日期,支部大会会议决议文件,支部大会会议决议日期,转正审批请示,转正审批请示日期,转正支部大会时间,支部书记签字,','','','2,',127,126,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_67\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_68\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_14\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_17\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_20\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_22\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_24\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_40\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_75\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2122,180,2,0,'Party masses Department','','上级党委审批意见,审批时间','','上级党委审批意见,','','','3,',355,164,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"1\"]},{\"FILE_PRIV_DATA_67\":[\"1\"]},{\"FILE_PRIV_DATA_68\":[\"1\"]},{\"FILE_PRIV_DATA_14\":[\"1\"]},{\"FILE_PRIV_DATA_17\":[\"1\"]},{\"FILE_PRIV_DATA_20\":[\"1\"]},{\"FILE_PRIV_DATA_22\":[\"1\"]},{\"FILE_PRIV_DATA_24\":[\"1\"]},{\"FILE_PRIV_DATA_40\":[\"1\"]},{\"FILE_PRIV_DATA_75\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2123,180,3,0,'Branch secretary','','第二次支部书记签字','','第二次支部书记签字,','','','4,',625,163,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_66\":[\"1\"]},{\"FILE_PRIV_DATA_67\":[\"1\"]},{\"FILE_PRIV_DATA_68\":[\"1\"]},{\"FILE_PRIV_DATA_14\":[\"1\"]},{\"FILE_PRIV_DATA_17\":[\"1\"]},{\"FILE_PRIV_DATA_20\":[\"1\"]},{\"FILE_PRIV_DATA_22\":[\"1\"]},{\"FILE_PRIV_DATA_24\":[\"1\"]},{\"FILE_PRIV_DATA_40\":[\"1\"]},{\"FILE_PRIV_DATA_75\":[\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2124,180,4,0,'Contact leaders','','','','','','','5,',843,165,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2125,180,5,0,'Secretary of the Party committee','','','','','','','0,',1050,159,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2126,181,1,0,'Party membership applicant','','思想汇报时间,思想汇报结束时间,思想汇报附件','','思想汇报时间,思想汇报结束时间,思想汇报附件,','','','2,',114,211,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2127,181,2,0,'Branch secretary','','预备党员考察记录表','','预备党员考察记录表,','','','3,',342,235,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_10\":[]},{\"FILE_PRIV_DATA_12\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2128,181,3,0,'Party masses Department','','','','','','','4,',628,233,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2129,181,4,0,'Contact leaders','','','','','','','0,',971,262,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2130,182,1,0,'Party membership applicant','','思想汇报开始时间,思想汇报结束时间,思想汇报附件','','思想汇报开始时间,思想汇报结束时间,思想汇报附件,','','','2,',141,238,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_8\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_21\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2131,182,2,0,'Branch secretary','','中共预备党员教育考察表','','中共预备党员教育考察表,','','','3,',277,249,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_8\":[\"1\"]},{\"FILE_PRIV_DATA_21\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2132,182,3,0,'Party masses Department','','','','','','','4,',508,261,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2133,182,4,0,'Contact leaders','','','','','','','0,',841,236,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'0','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2134,183,1,0,'Current branch secretary','','新入党介绍人姓名,入党介绍人变更理由,附件,时间','','新入党介绍人姓名,入党介绍人变更理由,附件,时间,','','','0,',223,222,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_55\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2135,184,1,0,'Current branch secretary','','新培养联系人姓名,培养联系人变更理由 ,附件,时间','','新培养联系人姓名,培养联系人变更理由 ,附件,时间,','','','0,',231,258,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_55\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2136,185,1,0,'Submission of ideological Report','','思想汇报附件,思想汇报时间','','思想汇报附件,','ALL_DEPT','','2,',238,237,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2137,185,2,0,'Training contact person/introducer of Party membership/branch secretary','','','','','ALL_DEPT','','0,',527,286,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_7\":[\"4\",\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2138,186,1,0,'Autobiography submission','','自传附件,提交日期','','自传附件,','ALL_DEPT','','2,',165,224,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_3\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2139,186,2,0,'Approval of branch secretary','','','','','ALL_DEPT','','0,',441,242,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_3\":[\"4\",\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2140,187,1,0,'Submission of employment confirmation application','','转正申请书附件,提交时间','','转正申请书附件,','ALL_DEPT','','2,',125,277,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_3\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2141,187,2,0,'Approval of branch secretary','','','','','ALL_DEPT','','0,',368,284,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','1','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_3\":[\"4\",\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2142,188,1,0,'Branch secretary','','材料转接证明,现支部书记签字','','材料转接证明,','ALL_DEPT','','2,',195,252,'','','','','','0','','','0','','','91,','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_107\":[\"4\",\"1\",\"2\",\"3\"]},{\"FILE_PRIV_DATA_105\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2143,188,2,0,'New branch secretary','','新支部书记签字,移交时间,审批意见,回执','','','','','3,',447,263,'','','','','','0','','','7','','','91,','','','0','','','','','3,day','0','0','0','0','1','','','','0','','1',0,'0','1','',0,'','','',0,0,'1','1','0','0','','',0,'[{\"FILE_PRIV_DATA_105\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','1','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2144,188,3,0,'Receipt','','','','','','','0,',819,268,'','','','','','0','','','1','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_105\":[\"4\",\"1\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1',NULL,NULL,'0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2145,189,1,0,'Branch secretary','','[C@],[A@],文件名称,姓名,所属党支部,变更原因,上传附件,时间,[B@]','','','ALL_DEPT','','2,',40,127,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_11\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2146,189,2,0,'Party masses Department','','','','','ALL_DEPT','','0,',207,141,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2147,190,1,0,'Step 1','','[C@],[A@],党员类型,党费交纳时间,去往党支部,去往党支部2,备注,[B@]','','去往党支部,','ALL_DEPT','','2,',96,102,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2148,190,2,0,'Branch secretary','','转入支部意见','','','ALL_DEPT','','3,',301,124,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2149,190,3,0,'Party masses Department','','','','','ALL_DEPT','','0,',553,118,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','','','','','',0,'','',0,0,'0',0,NULL,0,'','','0','0',NULL,'0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2150,191,1,0,'Step 1','','[C@],[A@],党员类型,党费交纳时间,去往党组织名称,党员联系电话,转入支部意见,[B@]','','','ALL_DEPT','','2,',119,142,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_13\":[]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0'),(2151,191,2,0,'Party masses Department','','转入支部意见','','','ALL_DEPT','','0,',337,155,'','','','','','0','','','0','','','','','','0','','','','','','0','0','0','0','1','','','','0','','1',0,'0','0','',0,'','','',0,0,'0','1','0','0','','',0,'[{\"FILE_PRIV_DATA_13\":[\"4\",\"1\",\"2\",\"3\"]}]','[]',0,0,'0',0,NULL,0,'','','0','0','1','0',NULL,'0',NULL,'1','0','0','1','','0','0',NULL,'',NULL,NULL,'0',NULL,'1','0',NULL,NULL,NULL,'0');
/*!40000 ALTER TABLE `flow_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_query_tpl`
--

DROP TABLE IF EXISTS `flow_query_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_query_tpl` (
  `SEQ_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `TPL_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '模板名称',
  `USER_ID` varchar(100) NOT NULL DEFAULT '' COMMENT '用户ID',
  `FLOW_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `VIEW_EXT_FIELDS` text COMMENT '扩展显示字段',
  `GROUP_BY_FIELDS` text COMMENT '分组字段',
  `DATA_CONDITIONS` text COMMENT '表单数据过滤条件',
  `FLOW_CONDITIONS` text COMMENT '流程过滤条件',
  `DATA_XML` text NOT NULL COMMENT '查询模板内容',
  `COND_FORMULA` varchar(200) NOT NULL COMMENT '查询条件公式',
  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`SEQ_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程查询模板';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_query_tpl`
--

LOCK TABLES `flow_query_tpl` WRITE;
/*!40000 ALTER TABLE `flow_query_tpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_query_tpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_relation`
--

DROP TABLE IF EXISTS `flow_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_relation` (
  `FLOW_REL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',
  `FLOW_REF_NO` int(11) DEFAULT NULL,
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `FLOW_REL_NAME` varchar(40) DEFAULT NULL,
  `RELATION_TYPE` int(11) NOT NULL COMMENT '关联类型（1-固定关联卡片2-关联流程）',
  `RELATION_FLOW_ID` varchar(255) DEFAULT NULL COMMENT '关联字段',
  `RELATION_STATUS` int(11) DEFAULT NULL,
  `FLOW_RANGE` int(255) DEFAULT '0' COMMENT '关联人员范围(0为所有，1为经办)',
  `TIME_RANGE` varchar(255) DEFAULT NULL COMMENT '时间范围(上月1、上季度2、上年度3、本月4、本季度5、本年6)',
  `DATA_DIRECTION` int(11) DEFAULT NULL,
  `FLOW_REL_DESC` text,
  `MAPPING` text NOT NULL COMMENT '数据关系映射',
  `MAPPING_DESC` text NOT NULL COMMENT '中文数据关联映射',
  PRIMARY KEY (`FLOW_REL_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程关联';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_relation`
--

LOCK TABLES `flow_relation` WRITE;
/*!40000 ALTER TABLE `flow_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_relation_func`
--

DROP TABLE IF EXISTS `flow_relation_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_relation_func` (
  `RELATION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增,关联应用ID',
  `FUNC_NAME` varchar(255) NOT NULL COMMENT '关联应用名',
  `FUNC_URL` varchar(255) NOT NULL COMMENT '关联应用URL',
  `FUNC_DESC` text NOT NULL COMMENT '应用说明',
  `RELATION_PARENT_ID` int(11) DEFAULT NULL COMMENT '父级ID',
  `JSON_VALUE` text COMMENT '应用JSON',
  `FLOW_FORM_ID` int(11) DEFAULT NULL COMMENT '表单ID',
  PRIMARY KEY (`RELATION_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='关联应用设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_relation_func`
--

LOCK TABLES `flow_relation_func` WRITE;
/*!40000 ALTER TABLE `flow_relation_func` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_relation_func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_report`
--

DROP TABLE IF EXISTS `flow_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_report` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tid` int(11) NOT NULL COMMENT '用途未知',
  `flow_id` int(11) NOT NULL COMMENT '流程ID',
  `form_id` int(11) NOT NULL COMMENT '表单ID',
  `r_name` varchar(100) NOT NULL COMMENT '报表名称',
  `list_item` text NOT NULL COMMENT '报表字段',
  `query_item` text NOT NULL COMMENT '查询条件字段',
  `CREATEUSER` varchar(40) NOT NULL COMMENT '创建人ID',
  `createdate` datetime NOT NULL COMMENT '创建时间',
  `group_type` char(1) NOT NULL COMMENT '统计方式(0-按分组统计计算,1-按分组列出详情,)',
  `group_field` varchar(20) NOT NULL COMMENT '分组字段',
  `CHART_TITLE` varchar(200) DEFAULT NULL COMMENT '图表标题',
  `ABSCISSA_AXIS` varchar(50) DEFAULT NULL COMMENT '横坐标轴（表单字段）',
  `ORDINATE_AXIS` varchar(50) DEFAULT NULL COMMENT '纵坐标轴（表单字段）',
  `CHART_TYPE` varchar(50) DEFAULT NULL COMMENT '图表类型',
  `CHART_COLOUR` varchar(50) DEFAULT NULL COMMENT '图谱颜色类型',
  `SUMMARY_TYPE` char(10) DEFAULT NULL COMMENT '数据汇总类型（0-计数汇总、1-加和汇总）',
  PRIMARY KEY (`rid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='报表设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_report`
--

LOCK TABLES `flow_report` WRITE;
/*!40000 ALTER TABLE `flow_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_report_priv`
--

DROP TABLE IF EXISTS `flow_report_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_report_priv` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `rid` int(11) NOT NULL COMMENT '报表ID',
  `user_str` text NOT NULL COMMENT '管理员ID串',
  `dept_str` text NOT NULL COMMENT '权限范围[部门ID串]',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='报表管理权限';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_report_priv`
--

LOCK TABLES `flow_report_priv` WRITE;
/*!40000 ALTER TABLE `flow_report_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_report_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_rule`
--

DROP TABLE IF EXISTS `flow_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_rule` (
  `RULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `USER_ID` varchar(40) NOT NULL COMMENT '委托人ID',
  `TO_ID` varchar(40) NOT NULL COMMENT '被委托人ID',
  `BEGIN_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '开始时间',
  `END_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '结束时间',
  `STATUS` char(1) NOT NULL DEFAULT '1' COMMENT '状态(0-关闭,1-开启)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(20) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `update_user` varchar(20) DEFAULT NULL COMMENT '最后修改人',
  `REMIND_STATUS` char(10) DEFAULT NULL COMMENT '提醒状态：0无提醒、1事务提醒、2短信提醒、3事务与短信提醒',
  PRIMARY KEY (`RULE_ID`) USING BTREE,
  KEY `FLOW_ID` (`FLOW_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `BEGIN_DATE` (`BEGIN_DATE`) USING BTREE,
  KEY `END_DATE` (`END_DATE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='工作委托';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_rule`
--

LOCK TABLES `flow_rule` WRITE;
/*!40000 ALTER TABLE `flow_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run`
--

DROP TABLE IF EXISTS `flow_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run` (
  `RID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例ID',
  `RUN_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '流程实例名称',
  `FLOW_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `BEGIN_USER` varchar(40) NOT NULL COMMENT '流程发起人ID',
  `BEGIN_DEPT` int(11) NOT NULL COMMENT '流程发起人部门ID',
  `BEGIN_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '流程实例创建时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '流程实例结束时间',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `DEL_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记(0-未删除,1-已删除)删除后流程实例可在工作销毁中确实删除或还原',
  `FOCUS_USER` text NOT NULL COMMENT '关注该流程的用户',
  `PARENT_RUN` int(11) NOT NULL DEFAULT '0' COMMENT '父流程ID',
  `FROM_USER` varchar(20) DEFAULT NULL,
  `AIP_FILES` text NOT NULL COMMENT '相关的版式文件信息',
  `PRE_SET` text NOT NULL COMMENT '待定',
  `VIEW_USER` text NOT NULL COMMENT '传阅人ID串工作办理结束时选择的传阅人',
  `ARCHIVE` int(1) NOT NULL COMMENT '是否归档(0-否,1-是)',
  `FORCE_OVER` text NOT NULL COMMENT '强制结束信息',
  `work_level` int(11) NOT NULL DEFAULT '0' COMMENT '工作等级 0-普通 1-重要 2-紧急',
  `DEL_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',
  `RELATION_RUN_IDS` text COMMENT '主办人添加的关联流程工作',
  `PRESET_USER` text COMMENT '预设后续步骤经办人串',
  `APPROVE_STATUS` char(10) DEFAULT '0' COMMENT '审批状态(0-未审批1-已通过2-已拒绝)',
  `MAIN_FILE` varchar(255) DEFAULT NULL COMMENT '正文ID',
  `MAIN_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '正文名称',
  `MAIN_AIP_FILE` varchar(255) DEFAULT NULL COMMENT '版式正文ID',
  `MAIN_AIP_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '版式正文名称',
  `MAIN_ORIGIN_FILE` varchar(255) DEFAULT NULL COMMENT '原始正文ID',
  `MAIN_ORIGIN_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '原始正文名称',
  `MAIN_CLEAR_FILE` varchar(255) DEFAULT NULL COMMENT '清稿正文ID',
  `MAIN_CLEAR_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '清稿正文名称',
  `CANCEL_STATUS` char(10) DEFAULT '0' COMMENT '作废状态(0-未作废，1-已作废)',
  PRIMARY KEY (`RID`) USING BTREE,
  KEY `FLOW_ID` (`RUN_ID`) USING BTREE,
  KEY `FORM_ID` (`FLOW_ID`) USING BTREE,
  KEY `RUN_NAME` (`RUN_NAME`) USING BTREE,
  KEY `BEGIN_TIME` (`BEGIN_TIME`) USING BTREE,
  KEY `END_TIME` (`END_TIME`) USING BTREE,
  KEY `USER_AND_RUN` (`BEGIN_USER`,`RUN_ID`) USING BTREE,
  KEY `DEL_FLAG` (`DEL_FLAG`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程实例基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run`
--

LOCK TABLES `flow_run` WRITE;
/*!40000 ALTER TABLE `flow_run` DISABLE KEYS */;
INSERT INTO `flow_run` VALUES (1,0,'',0,'',0,'0000-00-00 00:00:00',NULL,'','','0','',0,'','','','',0,'',0,'0000-00-00 00:00:00',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0');
/*!40000 ALTER TABLE `flow_run` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_attach`
--

DROP TABLE IF EXISTS `flow_run_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_attach` (
  `SEQ_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL COMMENT '流程实例ID',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL,
  `ATTACHMENT_NAME` varchar(255) NOT NULL COMMENT '附件名称',
  `FLOW_PRCS` int(11) NOT NULL COMMENT '步骤号',
  `UPLOAD_USER` varchar(40) NOT NULL COMMENT '上传人员',
  `UPLOAD_TIME` datetime NOT NULL COMMENT '上传时间',
  `ATTACHMENT_TYPE` int(2) DEFAULT '0' COMMENT '附件类型（0-普通附件，1-正文附件，2-版式文件附件）',
  PRIMARY KEY (`SEQ_ID`) USING BTREE,
  KEY `RUN_ID` (`RUN_ID`,`ATTACHMENT_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程实例附件信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_attach`
--

LOCK TABLES `flow_run_attach` WRITE;
/*!40000 ALTER TABLE `flow_run_attach` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_attach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_data`
--

DROP TABLE IF EXISTS `flow_run_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_data` (
  `RUN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例ID',
  `ITEM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '表单字段ID',
  `ITEM_DATA` text NOT NULL COMMENT '表单字段数据',
  KEY `FLOW_ID` (`RUN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_data`
--

LOCK TABLES `flow_run_data` WRITE;
/*!40000 ALTER TABLE `flow_run_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_feedback`
--

DROP TABLE IF EXISTS `flow_run_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_feedback` (
  `FEED_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例ID',
  `PRCS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例步骤ID[实际步骤号]',
  `FLOW_PRCS` int(11) NOT NULL COMMENT '流程步骤号[设计流程中的步骤号]',
  `USER_ID` varchar(40) NOT NULL COMMENT '用户ID',
  `CONTENT` mediumtext NOT NULL COMMENT '会签意见内容',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `EDIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最近一次会签意见的保存时间',
  `FEED_FLAG` varchar(50) NOT NULL DEFAULT '0' COMMENT '会签意见类型(1-点评意见,其他-会签意见)',
  `SIGN_DATA` text NOT NULL COMMENT '手写签批意见',
  `REPLY_ID` int(11) NOT NULL COMMENT '回复的是哪条意见ID',
  `FEED_TYPE` varchar(50) NOT NULL DEFAULT '0' COMMENT '意见类型',
  `LIKE_IDS` text COMMENT '点赞的userId串',
  `TO_IDS` text COMMENT '@的userId串',
  `SECRET_TYPE` char(10) DEFAULT '0' COMMENT '密送类型（0-不密送，普通会签；1-密送会签意见）',
  PRIMARY KEY (`FEED_ID`) USING BTREE,
  KEY `RUN_ID` (`RUN_ID`) USING BTREE,
  KEY `PRCS_ID` (`PRCS_ID`) USING BTREE,
  KEY `REPLY_ID` (`REPLY_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会签意见';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_feedback`
--

LOCK TABLES `flow_run_feedback` WRITE;
/*!40000 ALTER TABLE `flow_run_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_hook`
--

DROP TABLE IF EXISTS `flow_run_hook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_hook` (
  `run_id` int(11) NOT NULL COMMENT '流程实例ID',
  `module` varchar(40) NOT NULL COMMENT '映射业务模块',
  `field` varchar(40) NOT NULL COMMENT '映射字段',
  `key_id` int(11) NOT NULL COMMENT '映射字段的数据',
  PRIMARY KEY (`run_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程实例与业务引擎数据映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_hook`
--

LOCK TABLES `flow_run_hook` WRITE;
/*!40000 ALTER TABLE `flow_run_hook` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_hook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_log`
--

DROP TABLE IF EXISTS `flow_run_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_log` (
  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例ID',
  `RUN_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '流程实例名称',
  `FLOW_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程ID',
  `PRCS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例步骤ID[流程实例实际步骤号]',
  `FLOW_PRCS` int(11) NOT NULL DEFAULT '0' COMMENT '流程步骤ID[设计流程步骤号]',
  `USER_ID` varchar(40) NOT NULL COMMENT '操作人ID',
  `TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',
  `IP` varchar(20) NOT NULL DEFAULT '' COMMENT '操作人IP地址',
  `TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '日志类型：(1-新建、转交、回退、收回,2-委托,3-删除,4-销毁,5-还原被终止的流程,6-编辑数据,7-流转过程中修改经办权限,)',
  `CONTENT` text NOT NULL COMMENT '日志信息',
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '用户UID',
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  KEY `RUN_ID` (`RUN_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `IP` (`IP`) USING BTREE,
  KEY `RUN_NAME` (`RUN_NAME`) USING BTREE,
  KEY `FLOW_ID` (`FLOW_ID`) USING BTREE,
  KEY `TIME` (`TIME`) USING BTREE,
  KEY `I_TYPE` (`TYPE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程实例日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_log`
--

LOCK TABLES `flow_run_log` WRITE;
/*!40000 ALTER TABLE `flow_run_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_prcs`
--

DROP TABLE IF EXISTS `flow_run_prcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_prcs` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例ID',
  `PRCS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '流程实例步骤ID',
  `USER_ID` varchar(40) NOT NULL COMMENT '用户ID',
  `PRCS_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '工作接收时间',
  `DELIVER_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '工作转交/办结时间',
  `PRCS_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '步骤状态(1-未接收,2-办理中,3-转交下一步，下一步经办人无人接收,4-已办结,5-自由流程预设步骤,6-已挂起,)',
  `FLOW_PRCS` int(11) NOT NULL DEFAULT '0' COMMENT '步骤ID[设计流程中的步骤号]',
  `OP_FLAG` varchar(20) NOT NULL DEFAULT '1' COMMENT '是否主办(0-经办,1-主办)',
  `TOP_FLAG` varchar(20) NOT NULL DEFAULT '0' COMMENT '主办人选项(0-指定主办人,1-先接收者主办,2-无主办人会签,)',
  `PARENT` varchar(200) NOT NULL DEFAULT '0' COMMENT '上一步流程FLOW_PRCS',
  `CHILD_RUN` int(11) NOT NULL DEFAULT '0' COMMENT '子流程的流程实例ID',
  `TIME_OUT` varchar(20) NOT NULL DEFAULT '' COMMENT '待定',
  `FREE_ITEM` text NOT NULL COMMENT '步骤可写字段[仅自由流程且只有主办人生效]',
  `TIME_OUT_TEMP` varchar(50) NOT NULL COMMENT '待定',
  `OTHER_USER` varchar(255) NOT NULL DEFAULT '' COMMENT '工作委托用户ID串',
  `TIME_OUT_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '是否超时(1-超时,其他-不超时)',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '工作创建时间',
  `FROM_USER` varchar(20) NOT NULL COMMENT '工作移交用户ID',
  `ACTIVE_TIME` datetime NOT NULL COMMENT '取消挂起的时间',
  `COMMENT` text NOT NULL COMMENT '批注',
  `PRCS_DEPT` int(11) NOT NULL COMMENT '超时统计查询增加部门',
  `PARENT_PRCS_ID` varchar(200) NOT NULL DEFAULT '0' COMMENT '上一步流程PRCS_ID',
  `BACK_PRCS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '返回步骤PRCS_ID标志',
  `BACK_FLOW_PRCS` int(11) NOT NULL DEFAULT '0' COMMENT '返回步骤FLOW_PRCS标志',
  `TIME_OUT_ATTEND` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否排除工作时段按排班类型(0-否,1-是)',
  `TIME_OUT_TYPE` tinyint(2) NOT NULL DEFAULT '0' COMMENT '超时计算方法(0-本步骤接收后开始计时,1-上一步骤转交后开始计时 )',
  `RUN_PRCS_NAME` varchar(100) NOT NULL,
  `RUN_PRCS_ID` varchar(50) NOT NULL,
  `MOBILE_FLAG` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是移动端操作(0-否,1-是)',
  `IS_REMIND` int(1) NOT NULL DEFAULT '0' COMMENT '是否催办',
  `TEMP_PRCS_FLAG` tinyint(1) NOT NULL DEFAULT '0' COMMENT '区分自由流程回收的是预设步骤还是普通流转步骤，1-普通流转步骤，5-预设步骤',
  `WORKINGDAYS_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT '工作天数换算方式(0-24小时为一天，1-按个人排班类型工作时长为一天)',
  `BRANCH_COUNT` varchar(100) DEFAULT NULL COMMENT '并发步骤',
  `OPADD_USER` varchar(50) DEFAULT NULL COMMENT '加签人',
  `PRCS_NO` int(11) DEFAULT '0' COMMENT '依次办理顺序',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `I_PRCS_FLAG` (`PRCS_FLAG`) USING BTREE,
  KEY `I_RUN_ID` (`RUN_ID`) USING BTREE,
  KEY `I_USER_ID` (`USER_ID`) USING BTREE,
  KEY `I_PRCS_ID` (`RUN_ID`,`PRCS_ID`) USING BTREE,
  KEY `I_R_U_ID` (`RUN_ID`,`USER_ID`) USING BTREE,
  KEY `OP_FLAG` (`OP_FLAG`) USING BTREE,
  KEY `TIME_OUT_FLAG` (`TIME_OUT_FLAG`) USING BTREE,
  KEY `TIME_OUT` (`TIME_OUT`) USING BTREE,
  KEY `CHILD_RUN` (`CHILD_RUN`,`OTHER_USER`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程实例步骤信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_prcs`
--

LOCK TABLES `flow_run_prcs` WRITE;
/*!40000 ALTER TABLE `flow_run_prcs` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_prcs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_read`
--

DROP TABLE IF EXISTS `flow_run_read`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_read` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `RUN_ID` int(11) NOT NULL COMMENT '流程实例ID',
  `USER_ID` varchar(40) NOT NULL COMMENT '传阅人',
  `READ_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '阅读时间',
  `READ_FLAG` int(11) NOT NULL DEFAULT '0' COMMENT '是否阅读',
  `CREATE_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `PRCS_ID` int(11) NOT NULL COMMENT '实际步骤',
  `FLOW_PRCS` varchar(255) NOT NULL COMMENT '设计步骤',
  `TABLE_ID` int(40) DEFAULT NULL COMMENT '公文唯一标识ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='传阅表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_read`
--

LOCK TABLES `flow_run_read` WRITE;
/*!40000 ALTER TABLE `flow_run_read` DISABLE KEYS */;
INSERT INTO `flow_run_read` VALUES (1,1,'','0000-00-00 00:00:00',0,'0000-00-00 00:00:00',1,'1',NULL);
/*!40000 ALTER TABLE `flow_run_read` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_run_temp`
--

DROP TABLE IF EXISTS `flow_run_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_run_temp` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL COMMENT '流水号',
  `CREATE_TIME` int(20) unsigned NOT NULL COMMENT '流水号生成时间',
  `TEMP_TIME` int(20) unsigned NOT NULL COMMENT '流水号时间戳',
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RUN_ID` (`RUN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='临时流水号';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_run_temp`
--

LOCK TABLES `flow_run_temp` WRITE;
/*!40000 ALTER TABLE `flow_run_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_run_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_sort`
--

DROP TABLE IF EXISTS `flow_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_sort` (
  `SORT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `SORT_NO` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',
  `SORT_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '分类名称',
  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门ID',
  `SORT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `HAVE_CHILD` char(1) NOT NULL DEFAULT '' COMMENT '是否有子分类(1-是,其他-否)',
  `SORT_MAIN_TYPE` varchar(200) DEFAULT '0' COMMENT '流程类型主分类（根据系统代码走）',
  `SORT_DETAIL_TYPE` varchar(200) DEFAULT '0' COMMENT '流程类型详细分类（根据系统代码走）',
  PRIMARY KEY (`SORT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=351 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_sort`
--

LOCK TABLES `flow_sort` WRITE;
/*!40000 ALTER TABLE `flow_sort` DISABLE KEYS */;
INSERT INTO `flow_sort` VALUES (1,1,'Administrative office',0,0,'0','0','0'),(2,2,'Human resources management',0,0,'0','0','0'),(4,1,'Seal management',0,1,'0','0','0'),(5,1,'Attendance management',0,2,'0','KQQJTYPE','140'),(6,2,'Manpower management',0,2,'0','0','0'),(18,0,'Expense management',0,0,'1','',''),(19,0,'Contract management',0,0,'0','',''),(20,1,'Expense budget application',0,18,'0','',''),(21,2,'Travel expense reimbursement',0,18,'0','',''),(22,3,'Expense reimbursement application',0,18,'0','','');
/*!40000 ALTER TABLE `flow_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_timer`
--

DROP TABLE IF EXISTS `flow_timer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_timer` (
  `TID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',
  `USER_STR` text NOT NULL COMMENT '发起人ID串',
  `DEPT_STR` text COMMENT '定时任务发起部门串',
  `PRIV_STR` text COMMENT '定时任务发起角色串',
  `TYPE` varchar(1) NOT NULL COMMENT '提醒类型(1-仅此一次,2-按日,3-按周,4-按月,5-按年,)',
  `REMIND_DATE` varchar(10) NOT NULL COMMENT '提醒日期(1-仅此一次，存具体日期,2-按日，为空,3-按周，存星期几,4-按月，存每月几号,5-按年，存每年几月几号,)',
  `REMIND_TIME` time NOT NULL COMMENT '提醒时间',
  `LAST_TIME` datetime NOT NULL COMMENT '最近一次提醒时间',
  PRIMARY KEY (`TID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设计流程定时设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_timer`
--

LOCK TABLES `flow_timer` WRITE;
/*!40000 ALTER TABLE `flow_timer` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_timer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_trigger`
--

DROP TABLE IF EXISTS `flow_trigger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_trigger` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `NAME` varchar(255) DEFAULT NULL COMMENT '触发器名称',
  `FLOW_ID` int(11) unsigned NOT NULL COMMENT '流程ID',
  `FLOW_PRCS` int(11) unsigned NOT NULL COMMENT '步骤ID',
  `PLUGIN_TYPE` varchar(32) NOT NULL COMMENT '触发节点',
  `PLUGIN_WAY` varchar(32) NOT NULL COMMENT '执行方式',
  `PLUGIN` int(10) NOT NULL COMMENT '已启用的插件，新插件为文件夹名，老插件为文件名',
  `ACTIVED` tinyint(1) unsigned NOT NULL COMMENT '是否已启用：0未启用，1已启用',
  `SORT_ID` int(11) unsigned NOT NULL COMMENT '排序号',
  `DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '描述',
  `BUSINESS_LOGIC_ID` int(10) DEFAULT NULL COMMENT '业务逻辑ID',
  `ISGLOBAL` tinyint(1) DEFAULT '0' COMMENT '是否全部触发器 0-局部 1-全部',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=399 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程触发器表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_trigger`
--

LOCK TABLES `flow_trigger` WRITE;
/*!40000 ALTER TABLE `flow_trigger` DISABLE KEYS */;
INSERT INTO `flow_trigger` VALUES (1,'金蝶财务记账',129,3,'CREATE','AFTER_BACKEND',2,1,1,'金蝶财务记账',NULL,0),(2,'用友财务记账',130,3,'CREATE','AFTER_BACKEND',2,1,1,'用友财务记账',NULL,0),(3,'tiring',129,3,'CREATE','BEFORE_FRONTEND',2,1,0,'鈤日日',NULL,0),(4,'同样可以他',129,3,'CREATE','BEFORE_FRONTEND',2,1,11,'就如同就如同',NULL,0),(5,'erur',129,3,'CREATE','BEFORE_FRONTEND',2,1,5,'jrtujrtujr6e',NULL,0),(6,'herhje',129,3,'CREATE','BEFORE_FRONTEND',2,1,7,'rtjrtj',NULL,0),(24,'发文处理单触发',160,1,'TURN','BEFORE_FRONTEND',0,1,1,'处理',20,1),(25,'发文处理单触发',160,2,'TURN','BEFORE_FRONTEND',0,1,1,'处理',20,1),(26,'发文处理单触发',160,3,'TURN','BEFORE_FRONTEND',0,1,1,'处理',20,1),(27,'报告单触发',162,1,'TURN','BEFORE_FRONTEND',0,1,1,'报告单',21,1),(28,'报告单触发',162,2,'TURN','BEFORE_FRONTEND',0,1,1,'报告单',21,1),(29,'报告单触发',162,3,'TURN','BEFORE_FRONTEND',0,1,1,'报告单',21,1),(30,'会议纪要',163,1,'TURN','BEFORE_FRONTEND',0,1,1,'会议纪要',22,1),(31,'会议纪要',163,2,'TURN','BEFORE_FRONTEND',0,1,1,'会议纪要',22,1),(32,'收文单映射',164,1,'TURN','BEFORE_FRONTEND',0,1,1,'收文单',23,1),(33,'收文单映射',164,2,'TURN','BEFORE_FRONTEND',0,1,1,'收文单',23,1),(34,'收文单映射',164,3,'TURN','BEFORE_FRONTEND',0,1,1,'收文单',23,1),(125,'公务',159,1,'TURN','BEFORE_FRONTEND',0,1,1,'公务',19,1),(340,'请假',140,1,'TURN','BEFORE_FRONTEND',0,1,80,'请假',24,1),(341,'请假',140,2,'TURN','BEFORE_FRONTEND',0,1,80,'请假',24,1),(342,'请假',140,3,'TURN','BEFORE_FRONTEND',0,1,80,'请假',24,1),(343,'请假',140,4,'TURN','BEFORE_FRONTEND',0,1,80,'请假',24,1),(353,'出差',142,1,'TURN','BEFORE_FRONTEND',0,1,1,'出差',26,1),(354,'出差',142,2,'TURN','BEFORE_FRONTEND',0,1,1,'出差',26,1),(355,'出差',142,3,'TURN','BEFORE_FRONTEND',0,1,1,'出差',26,1),(356,'出差',142,4,'TURN','BEFORE_FRONTEND',0,1,1,'出差',26,1),(357,'外出',143,1,'TURN','BEFORE_FRONTEND',0,1,2,'外出',25,1),(358,'外出',143,2,'TURN','BEFORE_FRONTEND',0,1,2,'外出',25,1),(359,'外出',143,3,'TURN','BEFORE_FRONTEND',0,1,2,'外出',25,1),(360,'外出',143,4,'TURN','BEFORE_FRONTEND',0,1,2,'外出',25,1),(361,'预算压缩和计算金额',169,1,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(362,'预算压缩和计算金额',169,2,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(363,'预算压缩和计算金额',169,3,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(364,'预算压缩和计算金额',169,4,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(365,'预算压缩和计算金额',169,5,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(366,'预算压缩和计算金额',169,6,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(367,'预算压缩和计算金额',169,7,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(368,'预算压缩和计算金额',169,9,'TURN','BEFORE_FRONTEND',3,1,1,'',27,1),(369,'入党申请',170,1,'TURN','AFTER_FRONTEND',0,1,1,'',28,0),(370,'提交申请',170,2,'TURN','AFTER_FRONTEND',0,1,1,'',28,0),(371,'确认积极分子',171,1,'TURN','AFTER_FRONTEND',0,1,1,'',29,0),(372,'积极分子思想汇报',172,1,'TURN','AFTER_FRONTEND',0,1,1,'',30,0),(373,'确认发展对象',173,1,'TURN','AFTER_FRONTEND',0,1,1,'',31,0),(374,'报上级党委备案',173,2,'TURN','AFTER_FRONTEND',0,1,1,'',31,0),(375,'发展对象公示,确认入党介绍人',174,1,'TURN','AFTER_FRONTEND',0,1,1,'',32,0),(376,'政治审查开展集中裴秀',175,1,'TURN','AFTER_FRONTEND',0,1,1,'',33,0),(377,'支委会审查',176,1,'TURN','AFTER_FRONTEND',0,1,1,'',34,0),(378,'支委会审查上级党委预审',176,2,'TURN','AFTER_FRONTEND',0,1,1,'',34,0),(379,'接受预备党员',177,3,'TURN','AFTER_FRONTEND',0,1,1,'',35,0),(380,'支部大会讨论',177,1,'TURN','AFTER_FRONTEND',0,1,1,'',35,0),(381,'支部大会讨论上级党委预审',177,2,'TURN','AFTER_FRONTEND',0,1,1,'',35,0),(382,'入党宣誓',178,1,'TURN','AFTER_FRONTEND',0,1,1,'',36,0),(383,'预备党员思想汇报',179,1,'TURN','AFTER_FRONTEND',0,1,1,'',37,0),(384,'预备党员转正',180,1,'TURN','AFTER_FRONTEND',0,1,1,'',38,0),(385,'预备党员转正党群部',180,2,'TURN','AFTER_FRONTEND',0,1,1,'',38,0),(386,'预备党员转正党群部-支部书记',180,3,'TURN','AFTER_FRONTEND',0,1,1,'',38,0),(387,'第四次积极分子思想报告',181,1,'TURN','AFTER_FRONTEND',0,1,1,'',39,0),(388,'第四次预备党员思想汇报',182,1,'TURN','AFTER_FRONTEND',0,1,1,'',40,0),(389,'第四次预备党员思想汇报的支部书记',182,2,'TURN','AFTER_FRONTEND',0,1,1,'',40,0),(390,'入党介绍人变更',183,1,'TURN','AFTER_FRONTEND',0,1,1,'',41,0),(391,'培养联系人变更',184,1,'TURN','AFTER_FRONTEND',0,1,1,'',42,0),(392,'思想汇报提交',185,2,'TURN','AFTER_FRONTEND',0,1,1,'',43,0),(393,'自传提交',186,2,'TURN','AFTER_FRONTEND',0,1,1,'',44,0),(394,'转正申请书提交',187,2,'TURN','AFTER_FRONTEND',0,1,1,'',45,0),(395,'培养考察档案移交',188,2,'TURN','AFTER_FRONTEND',0,1,1,'',46,0),(396,'材料更变',189,1,'TURN','AFTER_BACKEND',4,1,1,'',0,0),(397,'转入工队其他党支部',190,1,'TURN','AFTER_BACKEND',5,1,1,'',0,0),(398,'转出工队党委',191,1,'TURN','AFTER_BACKEND',5,1,2,'',0,0);
/*!40000 ALTER TABLE `flow_trigger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_type`
--

DROP TABLE IF EXISTS `flow_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_type` (
  `FLOW_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `FLOW_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '流程名称',
  `FORM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '表单ID',
  `FLOW_DOC` char(1) NOT NULL DEFAULT '' COMMENT '是否允许附件(0-否,1-是)',
  `FLOW_TYPE` char(1) NOT NULL DEFAULT '' COMMENT '流程类型(1-固定流程,2-自由流程,3-关联业务模块流程)',
  `MANAGE_USER` mediumtext NOT NULL COMMENT '管理与监控权限[全局]-已废弃',
  `FLOW_NO` int(11) NOT NULL DEFAULT '1' COMMENT '流程排序号',
  `FLOW_SORT` int(11) NOT NULL DEFAULT '0' COMMENT '流程分类ID',
  `AUTO_NAME` mediumtext NOT NULL COMMENT '自动文号表达式',
  `AUTO_NUM` int(11) NOT NULL DEFAULT '0' COMMENT '自动编号计数器',
  `AUTO_LEN` int(11) NOT NULL DEFAULT '0' COMMENT '自动编号显示长度',
  `QUERY_USER` mediumtext NOT NULL COMMENT '查询权限[全局]-已废弃',
  `FLOW_DESC` mediumtext NOT NULL COMMENT '流程说明',
  `AUTO_EDIT` varchar(20) NOT NULL DEFAULT '1' COMMENT '新建工作时是否允许手工修改文号：(0-不允许手工修改文号,1-允许手工修改文号,2-允许在自动文号前输入前缀,3-允许在自动文号后输入后缀,4-允许在自动文号前后输入前缀和后缀,)',
  `NEW_USER` mediumtext NOT NULL COMMENT '自由流程新建权限：分为按用户、按部门、按角色三种授权方式,形成“用户ID串|部门ID串|角色ID串”格式的字符串,其中用户ID串、部门ID串和角色ID串均是逗号分隔的字符串,',
  `QUERY_ITEM` mediumtext NOT NULL COMMENT '查询字段串',
  `COMMENT_PRIV` char(1) NOT NULL DEFAULT '3' COMMENT '点评权限-已废弃',
  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门ID',
  `FREE_PRESET` char(1) NOT NULL DEFAULT '1' COMMENT '是否允许预设步骤(0-否,1-是)',
  `FREE_OTHER` char(1) NOT NULL DEFAULT '2' COMMENT '委托类型(0-禁止委托,1-仅允许委托当前步骤经办人(本步骤实际的经办人，该步骤可能定义了五个人，但是转交时选择了三个),2-自由委托,3-按步骤设置的经办权限委托(跟1的区别是按照定义的经办人来委托))',
  `QUERY_USER_DEPT` mediumtext NOT NULL COMMENT '本部门发起查询权限-已废弃',
  `MANAGE_USER_DEPT` mediumtext NOT NULL COMMENT '本部门管理与监控权限-已废弃',
  `EDIT_PRIV` mediumtext NOT NULL COMMENT '编辑权限-已废弃',
  `LIST_FLDS_STR` mediumtext NOT NULL COMMENT '列表扩展字段串查询页面仅查询该流程时生效',
  `ALLOW_PRE_SET` char(1) NOT NULL DEFAULT '0' COMMENT '待定',
  `FORCE_PRE_SET` char(1) NOT NULL DEFAULT '0' COMMENT '是否强制修改文号(1-是,其他-否),新建工作时是否允许手工修改文号为(2-允许在自动文号前输入前缀,3-允许在自动文号后输入后缀,4-允许在自动文号前后输入前缀和后缀,时可设置该选项)',
  `MODEL_ID` mediumtext NOT NULL COMMENT '流程对应模块ID',
  `MODEL_NAME` mediumtext NOT NULL COMMENT '流程对应模块名称',
  `ATTACHMENT_ID` mediumtext NOT NULL COMMENT '说明文档附件ID串',
  `ATTACHMENT_NAME` mediumtext NOT NULL COMMENT '说明文档附件名称串',
  `VIEW_USER` mediumtext COMMENT '传阅人ID串',
  `VIEW_DEPT` mediumtext COMMENT '传阅部门ID串',
  `VIEW_ROLE` mediumtext COMMENT '传阅角色ID串',
  `VIEW_PRIV` int(1) DEFAULT NULL COMMENT '允许传阅(0-不允许,1-允许)',
  `IS_VERSION` int(1) NOT NULL COMMENT '是否启用版本控制(0-否,1-是)',
  `FLOW_ACTION` varchar(10) DEFAULT NULL COMMENT '更多选项(1公告通知,2内部邮件,3转存,4归档)',
  `AUTO_NUM_YEAR` int(11) NOT NULL DEFAULT '0' COMMENT '自动编号计数器年刷新',
  `AUTO_NUM_MONTH` int(11) NOT NULL DEFAULT '0' COMMENT '自动编号计数器月刷新',
  `AUTO_NUM_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '年月编号刷新标记',
  `NEW_TYPE` varchar(10) DEFAULT NULL COMMENT '新建的时候可选择快速新建0，新建向导1',
  `MOBILE_NEW_TYPE` varchar(10) DEFAULT '1' COMMENT '是否允许手机端新建该流程 0-否 1-是',
  `document_flag` char(10) DEFAULT '0' COMMENT '是否开启正文 0-否 1-是',
  `document_layout` char(10) DEFAULT NULL COMMENT '正文版式文件格式pdf和aip 1-pdf  2-aip',
  `TEMPLATE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '默认公文模板ID',
  `SYS_RULE_YN` char(10) DEFAULT '0' COMMENT '是否允许选择文号类型(0-不允许,1-允许)',
  `QUERY_FIELD` mediumtext COMMENT '查询条件字段定义',
  `QUERY_LIST_FIELD` mediumtext COMMENT '查询列表字段定义',
  `QUERY_NEW_YN` char(10) DEFAULT '0' COMMENT '是否查询界面允许新建',
  `GROUP_USER_YN` char(10) NOT NULL DEFAULT '0' COMMENT '允许选择经办人时自定义组不受经办权限限制(0-受限，1-不受限)',
  `TO_NOTIFY_YN` char(10) DEFAULT '0' COMMENT '步骤结束后是否自动转发公告（0-否，1-是）',
  `USER_GROUP_DEPTS` mediumtext COMMENT '个人分组受限范围（部门deptId串）',
  `TIME_OUT_REMIND_TIME` varchar(10) DEFAULT NULL COMMENT '流程超时多久进行催办提醒时间（单位小时）',
  `TIME_OUT_INTERVAL` varchar(10) DEFAULT NULL COMMENT '超时提醒时间间隔（每隔多久提醒一次，单位小时）',
  `TIME_OUT_REMIND_TYPE` varchar(10) DEFAULT NULL COMMENT '超时提醒类型（0关闭提醒，1事务提醒，2短信提醒，3，事务和短信同时提醒）',
  `TIME_OUT_REMIND_NUM` int(11) DEFAULT NULL COMMENT '超时提醒次数（提醒过多少次后不再提醒）',
  `FEED_SECRET_TYPE` char(10) DEFAULT '0' COMMENT ' 是否允许密送（0不允许，1允许）',
  `FEED_SECRET_USER` mediumtext COMMENT '允许发送密送的人员',
  `ATTACHMENT_ID_ICON` varchar(100) DEFAULT NULL COMMENT '移动端图标ID',
  `ATTACHMENT_NAME_ICON` varchar(100) DEFAULT NULL COMMENT '移动端图标名称为FLOW_ID值',
  `NEW_DATE_TYPE` char(10) DEFAULT '' COMMENT '允许新建日期类型（1-每日,2-每周,3-每月）',
  `NEW_DATE` varchar(255) DEFAULT '' COMMENT '允许新建日期范围，使用英文逗号分隔',
  `NEW_BEGIN_TIME` varchar(20) DEFAULT '' COMMENT '允许新建开始时间',
  `NEW_END_TIME` varchar(20) DEFAULT '' COMMENT '允许新建结束时间',
  `WATERMARK_FLAG` char(10) DEFAULT '0' COMMENT '开启水印设置(0-不开启,1-开启)',
  `PRCS_DELETE_FLAG` char(10) DEFAULT '1' COMMENT '第一步是否可删除(0-不可以,1-可以)',
  `FEEDBACK_PRIV` char(10) NOT NULL DEFAULT '0' COMMENT '传阅是否允许填写会签意见（0否,1是）',
  `GO_AHEAD_FLAG` char(10) DEFAULT '0' COMMENT '是否开启继续办理',
  `FLOW_CANCEL` char(10) DEFAULT '0' COMMENT '回退或转交给发起人后允许其作废(0-不允许，1-允许)',
  `OP_DISPLAY` char(10) DEFAULT '1' COMMENT '流程图中显示主办人、经办人标识（0否/1是）',
  `BACK_CLEAR_MACROS` char(10) DEFAULT '1' COMMENT '回退是否清除表单宏控件中的内容（0-不清除，1-清除）',
  PRIMARY KEY (`FLOW_ID`) USING BTREE,
  KEY `FLOW_SORT` (`FLOW_SORT`) USING BTREE,
  KEY `FORM_ID` (`FORM_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='设计流程';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_type`
--

LOCK TABLES `flow_type` WRITE;
/*!40000 ALTER TABLE `flow_type` DISABLE KEYS */;
INSERT INTO `flow_type` VALUES (139,'Seal application',1,'1','1','',1,4,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','','',0,1,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(140,'Leave Application',2,'1','1','',2,5,'',0,0,'','','1','','','3',1,'0','2','','','','','0','0','','','','','','','',0,0,'',0,0,'0002-11-30 00:00:00','','1','0','1',0,'0',NULL,NULL,'0','0','0',NULL,'','','0',NULL,'0','','','','1','','','','0','1','0','0','0','1','1'),(141,'Overtime application',3,'1','1','',3,6,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','','',0,1,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(142,'Travel application',4,'1','1','',4,5,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','',NULL,0,0,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(144,'Duty application',6,'1','1','',6,6,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','','',0,0,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(165,'Expense budget application',26,'1','1','',14,20,'',0,0,'','','1','','','3',1,'1','1','','','','','0','4','','','','','','','',0,0,'',0,0,'0002-11-30 00:00:00','','1','0','1',0,'0',NULL,NULL,'0','0','0',NULL,'','','0',NULL,'0','','','','1','','','','0','1','0','0','0','1','1'),(166,'Travel expense reimbursement',27,'1','1','',15,21,'',0,3,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','','',0,1,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(167,'Expense reimbursement application',28,'1','1','',16,22,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','','','','',NULL,0,1,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1'),(168,'Contract approval application',29,'1','1','',17,19,'',0,0,'','','1','','','3',-1,'1','2','','','','','0','0','','','4536@1708_365761929','测试流程.xml','','','',0,1,'',0,0,'0002-11-30 00:00:00',NULL,'1','0',NULL,0,'0',NULL,NULL,'0','0','0',NULL,NULL,NULL,NULL,NULL,'0',NULL,NULL,NULL,'','','','','0','1','0','0','0','1','1');
/*!40000 ALTER TABLE `flow_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flow_version`
--

DROP TABLE IF EXISTS `flow_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flow_version` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `RUN_ID` int(11) NOT NULL COMMENT '流程实例ID',
  `PRCS_ID` int(11) NOT NULL COMMENT '流程实例步骤ID',
  `FLOW_PRCS` int(11) NOT NULL COMMENT '流程步骤ID',
  `ITEM_ID` int(11) NOT NULL COMMENT '表单字段ID',
  `ITEM_DATA` text NOT NULL COMMENT '表单字段的数据',
  `TIME` datetime NOT NULL COMMENT '操作时间',
  `MARK` int(11) NOT NULL COMMENT '版本号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='流程版本控制(历史数据)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flow_version`
--

LOCK TABLES `flow_version` WRITE;
/*!40000 ALTER TABLE `flow_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foot`
--

DROP TABLE IF EXISTS `foot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foot` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `UID` int(11) NOT NULL COMMENT '用户ID',
  `CREATE_TIME` int(11) NOT NULL COMMENT '创建时间',
  `LOCATION` varchar(50) NOT NULL COMMENT '地址',
  `LNG` varchar(20) NOT NULL COMMENT '经度',
  `LAT` varchar(20) NOT NULL COMMENT '纬度',
  `IS_NEW` tinyint(1) NOT NULL DEFAULT '0' COMMENT '标记',
  `UPDATE_TIME` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='我的足迹表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foot`
--

LOCK TABLES `foot` WRITE;
/*!40000 ALTER TABLE `foot` DISABLE KEYS */;
/*!40000 ALTER TABLE `foot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foot_set`
--

DROP TABLE IF EXISTS `foot_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foot_set` (
  `TIME` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foot_set`
--

LOCK TABLES `foot_set` WRITE;
/*!40000 ALTER TABLE `foot_set` DISABLE KEYS */;
INSERT INTO `foot_set` VALUES ('15');
/*!40000 ALTER TABLE `foot_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_sort`
--

DROP TABLE IF EXISTS `form_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_sort` (
  `SORT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `SORT_NO` int(11) NOT NULL DEFAULT '0' COMMENT '分类排序号',
  `SORT_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '分类名称',
  `SORT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `HAVE_CHILD` char(1) NOT NULL DEFAULT '0' COMMENT '是否存在下级分类(0-否,1-是)',
  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门ID',
  PRIMARY KEY (`SORT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='表单分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_sort`
--

LOCK TABLES `form_sort` WRITE;
/*!40000 ALTER TABLE `form_sort` DISABLE KEYS */;
INSERT INTO `form_sort` VALUES (1,1,'Administrative office',0,'0',0),(2,2,'Human resources management',0,'0',0),(4,1,'Seal management',1,'0',0),(5,1,'Attendance management',2,'0',0),(6,2,'Manpower management',2,'0',0),(16,0,'Expense management',0,'1',0),(17,1,'Expense budget application',16,'0',0),(18,2,'Travel expense',16,'0',0),(19,3,'Expense reimbursement application',16,'0',0),(20,0,'Contract management',0,'0',0);
/*!40000 ALTER TABLE `form_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gapp`
--

DROP TABLE IF EXISTS `gapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gapp` (
  `GAPP_ID` varchar(40) NOT NULL COMMENT '全局ID 32位UUID',
  `GAPP_NO` varchar(50) DEFAULT NULL COMMENT '排序号',
  `GAPP_NAME` varchar(100) DEFAULT NULL COMMENT '应用名称',
  `GAPP_TYPE` int(11) DEFAULT NULL COMMENT '应用分类ID',
  `GAPP_PIC_ID` varchar(100) DEFAULT NULL COMMENT '内置应用图标ID',
  `GAPP_PIC_NAME` varchar(200) DEFAULT NULL COMMENT '自定义应用图标名称',
  `CREATE_USER_ID` varchar(50) DEFAULT NULL COMMENT '创建人userId',
  `FLOW_ID` int(11) DEFAULT NULL COMMENT '流程ID',
  PRIMARY KEY (`GAPP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='GAPP应用';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gapp`
--

LOCK TABLES `gapp` WRITE;
/*!40000 ALTER TABLE `gapp` DISABLE KEYS */;
/*!40000 ALTER TABLE `gapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gapp_logs`
--

DROP TABLE IF EXISTS `gapp_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gapp_logs` (
  `APPLOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `OP_USER` varchar(50) DEFAULT NULL COMMENT '操作用户',
  `OP_OBJECT` char(10) DEFAULT '1' COMMENT '操作对象(0-应用设计，1-使用数据)',
  `OP_TYEP` char(10) DEFAULT NULL COMMENT '操作类型（0-删除，1-编辑，2-新增）',
  `OP_TIME` datetime DEFAULT NULL COMMENT '操作时间',
  `OP_APP` varchar(32) DEFAULT NULL COMMENT '操作应用TAB_ID',
  `OP_APP_NAME` varchar(255) DEFAULT NULL COMMENT '操作应用表单名',
  `OP_DESC` text COMMENT '操作内容',
  PRIMARY KEY (`APPLOG_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='应用日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gapp_logs`
--

LOCK TABLES `gapp_logs` WRITE;
/*!40000 ALTER TABLE `gapp_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gapp_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gapp_type`
--

DROP TABLE IF EXISTS `gapp_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gapp_type` (
  `TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `ORDER_NO` varchar(50) DEFAULT NULL COMMENT '排序号',
  `TYPE_NAME` varchar(100) DEFAULT NULL COMMENT '分类名称',
  `PARENT_GTYPE_ID` int(11) DEFAULT NULL COMMENT '父级分类ID',
  PRIMARY KEY (`TYPE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='GAPP应用分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gapp_type`
--

LOCK TABLES `gapp_type` WRITE;
/*!40000 ALTER TABLE `gapp_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `gapp_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gbt_conf`
--

DROP TABLE IF EXISTS `gbt_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gbt_conf` (
  `CONF_ID` int(10) unsigned NOT NULL COMMENT '唯一自增ID',
  `SUBJECT` varchar(100) NOT NULL COMMENT '主题',
  `BEGIN_TIME` datetime NOT NULL COMMENT '开始时间',
  `END_TIME` datetime NOT NULL COMMENT '结束时间',
  `CHAIRMAN` varchar(20) NOT NULL COMMENT '会议主席USER_ID',
  `CHAIRMAN_PWD` varchar(50) NOT NULL COMMENT '会议主席密码',
  `TO_ID` varchar(3000) NOT NULL COMMENT '参会人员',
  `USER_PWD` varchar(30) NOT NULL COMMENT '参会密码',
  `CREATOR` int(10) unsigned NOT NULL COMMENT '会议创建人UID',
  `CONTENT` varchar(1000) NOT NULL COMMENT '会议简介',
  PRIMARY KEY (`CONF_ID`) USING BTREE,
  KEY `BEGIN_TIME` (`BEGIN_TIME`) USING BTREE,
  KEY `END_TIME` (`END_TIME`) USING BTREE,
  KEY `CHAIRMAN` (`CHAIRMAN`) USING BTREE,
  KEY `CREATOR` (`CREATOR`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='视频会议表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gbt_conf`
--

LOCK TABLES `gbt_conf` WRITE;
/*!40000 ALTER TABLE `gbt_conf` DISABLE KEYS */;
/*!40000 ALTER TABLE `gbt_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gcolumn`
--

DROP TABLE IF EXISTS `gcolumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gcolumn` (
  `COL_ID` varchar(40) NOT NULL COMMENT '字段ID 允许重复',
  `TAB_ID` varchar(40) DEFAULT NULL COMMENT '所属表单',
  `COL_NO` varchar(20) DEFAULT NULL COMMENT '控件排序号',
  `COL_NAME` varchar(100) DEFAULT NULL COMMENT '控件名称',
  `COL_TYPE` char(10) DEFAULT NULL COMMENT '控件类型 如单行文本、数字',
  `COL_KTYPE` char(10) DEFAULT NULL COMMENT '控件详细类型 如单行文本的身份证类型',
  `COL_STYLE` text COMMENT '控件格式 如单选框、下拉框的选项内容，多行文本的行数，子表的表单ID',
  `COL_DTYPE` varchar(200) DEFAULT NULL COMMENT '数据库类型',
  `COL_FONT` varchar(200) DEFAULT NULL COMMENT '控件名称字体样式如 微软雅黑',
  `COL_COLOR` varchar(200) DEFAULT NULL COMMENT '控件名称字色样式如 #FF0000',
  `IS_KEY` char(10) DEFAULT '0' COMMENT '是否主键1是,0否',
  `IS_MUST` char(10) DEFAULT '0' COMMENT '是否必填1是,0否',
  `IS_HIDDEN` char(10) DEFAULT '0' COMMENT '是否隐藏1是,0否',
  `IS_READONLY` char(10) DEFAULT '0' COMMENT '是否只读1是,0否',
  `DEFAULT_VAL` varchar(255) DEFAULT NULL COMMENT '默认值',
  `HIDDEN_COND` text COMMENT '隐藏本控件的条件支持表达式',
  `FORMULA_STYLE` char(10) DEFAULT NULL COMMENT '公式类型1计算公式，2数据联动',
  `FORMULA_CONTENT` text COMMENT '公式内容',
  `DATA_FROM` text COMMENT '数据来源支持表达式',
  `COL_FROM` varchar(40) DEFAULT NULL COMMENT '源字段',
  `REF_TAB_ID` varchar(255) DEFAULT NULL COMMENT '关联表',
  `REF_COND` text COMMENT '关联条件',
  `ORDER_TYPE` varchar(10) DEFAULT '0' COMMENT '默认排序方式1升序,0降序',
  `INPUT_TIPS` varchar(255) DEFAULT NULL COMMENT '输入时提示',
  `INPUT_DESC` text COMMENT '输入时说明',
  `INPUT_SCAN` char(10) DEFAULT '0' COMMENT '允许扫码输入1是,0否,2允许并可修改',
  `IS_CHECKHAVE` char(10) DEFAULT '0' COMMENT '不允许重复录入0允许重复录入,1不允许重复录入',
  `COL_DESC` varchar(255) DEFAULT NULL COMMENT '控件描述',
  `BELONG_COL_ID` text COMMENT '所属表单子表字段COL_ID',
  `SUB_DATA_TITLE` varchar(255) DEFAULT NULL COMMENT '子表数据标题'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='GAPP控件定义';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gcolumn`
--

LOCK TABLES `gcolumn` WRITE;
/*!40000 ALTER TABLE `gcolumn` DISABLE KEYS */;
/*!40000 ALTER TABLE `gcolumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `glist`
--

DROP TABLE IF EXISTS `glist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `glist` (
  `LIST_ID` varchar(40) NOT NULL COMMENT '字段ID在任何系统中不重复',
  `TAB_ID` varchar(40) NOT NULL COMMENT '针对表单',
  `GAPP_ID` varchar(40) NOT NULL COMMENT '所属应用',
  `SEL_COL_IDS` text COMMENT '控件ID串，列表上查询的控件字段',
  `SHOW_COL_IDS` text COMMENT '控件ID串，列表表头字段',
  `LIST_VIEW_TYPE` char(10) NOT NULL COMMENT '视图类型：1-列表视图2-日历视图3-时间轴4-甘特图',
  `LIST_ORDER_COL` varchar(40) NOT NULL COMMENT '列表视图排序字段',
  `LIST_ORDER_TYPE` char(10) NOT NULL COMMENT '列表视图排序字段的排序方式：1-降序2-升序',
  `SHOW_C` char(10) DEFAULT NULL COMMENT '电脑端：1-列表显示',
  `SHOW_M` char(10) DEFAULT NULL COMMENT '手机端：1-列表显示',
  `BATCH_OPERATE` char(10) NOT NULL COMMENT '批量操作：1-允许0-不允许',
  `LIST_BUTTONS` varchar(255) DEFAULT NULL COMMENT '列表功能按钮',
  `LIST_COL_ORDER` text COMMENT '控件ID串，列表设计右侧控件名排序',
  PRIMARY KEY (`LIST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='GAPP应用列表设计表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `glist`
--

LOCK TABLES `glist` WRITE;
/*!40000 ALTER TABLE `glist` DISABLE KEYS */;
/*!40000 ALTER TABLE `glist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grid_info`
--

DROP TABLE IF EXISTS `grid_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grid_info` (
  `GRID_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `GRID_NAME` varchar(255) DEFAULT '' COMMENT '网格名称',
  `UPPER_GRID` varchar(255) DEFAULT NULL COMMENT '上级网格',
  `GRID_TYPE` varchar(255) DEFAULT NULL COMMENT '网格类型',
  `SCOPE` varchar(255) DEFAULT NULL COMMENT '社区范围',
  `AREA` varchar(255) DEFAULT NULL COMMENT '社区面积',
  `MAP_INFO` text COMMENT '社区坐标',
  `TEL_NO` varchar(255) DEFAULT NULL COMMENT '社区电话',
  `LOCATION` varchar(255) DEFAULT '' COMMENT '社区位置',
  `BAOPIAN_ID` varchar(255) DEFAULT NULL COMMENT '包片领导id',
  `BAOPIAN_TEL` varchar(255) DEFAULT NULL COMMENT '包片领导联系方式',
  `BAOJU_ID` varchar(255) DEFAULT NULL COMMENT '包居科长id',
  `BAOJU_TEL` varchar(255) DEFAULT NULL COMMENT '包居科长联系方式',
  `DIRECTOR_ID` varchar(255) DEFAULT NULL COMMENT '居委会主任id',
  `DIRECTOR_TEL` varchar(255) DEFAULT NULL COMMENT '居委会主任联系方式',
  `VICE_DIRECTOR_ID` varchar(255) DEFAULT NULL COMMENT '居委会副主任id',
  `GRID_USER_ID` varchar(255) DEFAULT NULL COMMENT '网格员',
  `COMMUNITY_BUILDING` int(11) DEFAULT NULL COMMENT '社区楼栋数',
  `HOUSEHOLDS` int(11) DEFAULT NULL COMMENT '社区总户数',
  `POPULATION` int(11) DEFAULT NULL COMMENT '社区总人口',
  `FLOATING_POPULATION` int(11) DEFAULT NULL COMMENT '流动人口',
  `REGISTERED_POPULATION` int(11) DEFAULT NULL COMMENT '户籍人口',
  `PERMANENT_POPULATION` int(11) DEFAULT NULL COMMENT '常住人口',
  `RESIDENTIAL_BUILDING` int(11) DEFAULT NULL COMMENT '居住建筑数',
  `COMMERCIAL_BUILDING` int(11) DEFAULT NULL COMMENT '商用建筑数',
  `RENTAL` int(11) DEFAULT NULL COMMENT '出租屋数',
  `GRID_INFO` text COMMENT '社区描述',
  PRIMARY KEY (`GRID_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='网格信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grid_info`
--

LOCK TABLES `grid_info` WRITE;
/*!40000 ALTER TABLE `grid_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `grid_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gtable`
--

DROP TABLE IF EXISTS `gtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gtable` (
  `TAB_ID` varchar(32) NOT NULL COMMENT '32位UUID',
  `TAB_NAME` varchar(255) DEFAULT NULL COMMENT '表单名',
  `GAPP_ID` varchar(32) DEFAULT NULL COMMENT '应用ID',
  `TYPE_ID` int(11) DEFAULT NULL COMMENT '应用分类ID',
  `TAB_DATA_TITLE` varchar(255) DEFAULT NULL COMMENT '数据标题',
  PRIMARY KEY (`TAB_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='GAPP表单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gtable`
--

LOCK TABLES `gtable` WRITE;
/*!40000 ALTER TABLE `gtable` DISABLE KEYS */;
/*!40000 ALTER TABLE `gtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gtable_priv`
--

DROP TABLE IF EXISTS `gtable_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gtable_priv` (
  `TPRIV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `TAB_ID` varchar(32) DEFAULT NULL COMMENT '所属表单',
  `TAB_BUTTON_PRIV` varchar(200) DEFAULT NULL COMMENT '表单按钮权限',
  `LIST_BUTTON_PRIV` varchar(200) DEFAULT NULL COMMENT '列表按钮权限',
  `CREATE_USER_ID` char(10) DEFAULT NULL COMMENT '数据权限(创建人)0-否，1-是',
  `ALL_USERS` char(10) DEFAULT '0' COMMENT '数据权限(全部)0-否，1-是',
  `OWNER_USER_ID` char(10) DEFAULT NULL COMMENT '数据权限(拥有者)0-否，1-是',
  `OWNER_DEPT_ID` char(10) DEFAULT NULL COMMENT '数据权限(所属部门)0-否，1-是',
  `DEPT_ID_RPIVS` text COMMENT '授权部门ID字符串',
  `RPIV_ID_RPIVS` text,
  `USER_ID_RPIVS` text COMMENT '授权用户ID字符串',
  `TYPE_ID` int(11) DEFAULT NULL COMMENT '应用分类ID',
  PRIMARY KEY (`TPRIV_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='权限设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gtable_priv`
--

LOCK TABLES `gtable_priv` WRITE;
/*!40000 ALTER TABLE `gtable_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `gtable_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_question`
--

DROP TABLE IF EXISTS `help_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_question` (
  `q_id` char(3) NOT NULL COMMENT '问题id',
  `sort_id` varchar(9) NOT NULL COMMENT '分类id',
  `q_keyword` varchar(100) NOT NULL DEFAULT '' COMMENT '问题和答案关键词',
  `question` varchar(200) NOT NULL DEFAULT '' COMMENT '问题',
  PRIMARY KEY (`q_id`,`sort_id`) USING BTREE,
  KEY `q_keyword` (`q_keyword`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='帮助主题-问题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_question`
--

LOCK TABLES `help_question` WRITE;
/*!40000 ALTER TABLE `help_question` DISABLE KEYS */;
INSERT INTO `help_question` VALUES ('001','010003','新手入门 个人 信息设置','如何进行个人信息设置？'),('001','010006','新手入门 修改 OA 用户名','OA用户名可以修改吗？'),('001','010009','新手入门 精灵 登录 OA系统','精灵客户端如何登录OA系统？'),('001','010012','新手入门 发送 电子邮件','如何发送电子邮件？'),('001','010015','新手入门 软件 注册','怎么注册软件？'),('001','015021060','个人事务 电子邮件 内部邮件 特点','内部邮件有什么特点？'),('001','015021071','个人事务 工作日志  模板','怎样创建工作日志模板？'),('001','015021073','个人事务 个人文件柜 文件 共享','个人文件柜里的文件怎么让别人看到？'),('001','015022075','工作流 新建工作 看不到 流程','为什么我在新建工作中看不到流程？'),('001','015022076','工作流 我的工作 待办  了解  基本情况','如何了解待办工作的基本情况？'),('001','015022077','工作流 工作查询  高级查询  区别','查询与高级查询的区别应用？'),('001','015022078','工作流 工作监控 作用','工作监控的作用是什么？'),('001','015022079','工作流 数据报表','工作流数据报表如何使用？'),('001','015022080','工作流 工作委托 类型','委托有几种类型呢？'),('001','015022081','工作流 工作销毁 作用','工作销毁的作用是什么？'),('001','015022082','工作流 数据归档 作用','数据归档的作用是什么？'),('001','015022083','工作流 表单设计 快速 制作','怎样快速制作表单？'),('001','015022084','工作流 流程设计 快速 新建 工作流程','如何快速新建工作流程？'),('001','015023085','行政办公 公告通知 类型 控制 审批','能否按公告通知类型控制是否需要审批？'),('001','015023087','行政办公 新闻管理 图文新闻  发布','图文新闻是怎样发布的？'),('001','015023088','行政办公 投票管理 子投票','什么是子投票？'),('001','015023089','行政办公 日程安排 安排工作','我如何为别人安排工作？'),('001','015023092','行政办公 工作计划   负责人  其他人  查看','负责人可以查看到其他人的工作计划吗？'),('001','015024100','知识管理 公共文件柜 office文档  下载','如何下载公共文件柜里的office文档？'),('001','015025','智能门户 集团门户  屏蔽  自定义  新闻网站  链接','在集团门户中，怎样屏蔽部分新闻或者能自定义所链接的新闻网站？'),('001','015027121','在线考试','OA系统如何设置在线考试？'),('001','015030','项目管理 添加 项目任务','添加项目任务说明'),('001','015038143','系统管理 OA系统  设置部门','OA系统如何设置部门？'),('001','015038163','接口设置 事务提醒 工作流 接口 地址 形式','系统接口设置相关应用有哪些？ '),('001','015038170','文档 编辑 存取 错误 电子印章','Office文档在线编辑有哪些注意事项？'),('001','015048','OA精灵PC端 配置参数','开始使用OA精灵前您需要配置哪些参数？'),('001','020160181','个人事务 电子邮件 打开邮件  短信  乱码  无法写入','打开邮件或短信有乱码，提示D:\\MYOA\\tmp中有个文件无法写入？'),('001','020160183','个人事务 手机短信  服务器  短信猫  自动发送','为什么手机短信在停止服务器和重插短信猫后还会不停的自动发送？'),('001','020160190','个人事务 个人考勤 上下班 登记时间','怎样修改上下班登记的时间？'),('001','020160192','个人事务 工作日志 归档  删除','怎样删除归档的工作日志？'),('001','020160194','常用软件  文件共享  目录','怎样设置一些常用软件放在一个文件共享目录中？'),('001','020161196','工作流  活动审批  申请人  无法填写  活动详情','活动审批流程申请人无法填写活动详情？'),('001','020161197','工作流 OA系统  取消  工作委托','OA系统如何取消工作委托？'),('001','020161198','工作流 查询  条件','工作流查询中怎样保存反复用到一些相同的查询条件？'),('001','020161199','工作流 表单设计  预览表单  空白','表单设计好之后点击“预览表单”，显示空白？'),('001','020161200','工作流 流程设计器  新建步骤  保存不上','流程设计器中新建步骤时为何保存不上？'),('001','020162206','行政办公  公告通知  数据库','行政办公中“公告通知查阅情况”是放在数据库里的吗？是哪张表？'),('001','020162215','行政办公 增加固定资产','怎样增加固定资产？'),('001','020163221','知识管理 公共文件柜  排序  文件夹','公共文件柜怎样实现按排序号排序文件夹？'),('001','020163222','知识管理 网络硬盘  文件说明字段  增加','网络硬盘中能否增加文件说明字段？'),('001','020166227','人力资源 办公用品  离职  管理员','办公用品管理员离职了，更改办公用品管理员怎么处理？'),('001','020166230','人力资源 外出登记  下拉栏  审批人  读取','外出登记里下拉栏里的审批人是读取哪些人？'),('001','020169','复制  客户信息  字段  删除','复制客户信息模块后，为什么里面的字段不能删除？'),('001','020172240','交流园地 论坛  服务器  同一台  安装','怎样把DISCUZ论坛和OA软件安装在同一台服务器？'),('001','020177255','系统管理 印章删除  初始化  印章存储区  失败','系统管理-印章管理-印章删除，点击“印章初始化，提示：印章存储区初始化失败”？'),('001','020177256','系统管理 签章授权文件  安装','签章授权文件的安装？'),('001','020177264','系统管理 数据备份  恢复','怎样进行OA软件的数据备份与恢复？'),('001','020178','OA精灵PC端 升级  精灵  面板  黑屏','升级到最新精灵后，精灵面板出现黑屏？'),('001','020179','OA精灵移动版 手机登录  用户名  密码错误','手机客户端登录提示：用户名密码错误。'),('001','020180275','服务器  内网访问  外网访问  很慢','服务器内网访问没问题，外网访问为什么会很慢？'),('001','020180276','注册服务  智能配置  停留','重新注册服务的时候一直停留在智能配置上，服务注册不上的原因？'),('001','020180277','应用服务 IM分离  服务器','怎样将IM分离到其他的服务器上？'),('001','020180278','登录界面 动态密码输入错误','动态密码器输入错误怎样处理？'),('002','010006','新手入门 修改 OA 密码','怎样修改OA密码？'),('002','010009','新手入门 管理员 分配 用户 登录 ','管理员如何分配用户并使其登录OA系统？'),('002','010012','新手入门 发送 外部邮件','怎样从OA系统里发送外部邮件？'),('002','010015','新手入门 备份 数据','怎样备份数据？'),('002','015021060','个人事务 电子邮件 内部邮件  安全性','怎样设置内部邮件的安全性？'),('002','015021071','个人事务 工作日志 查询','我可以查询哪些人的工作日志？'),('002','015021073','个人事务  限制 文件柜 容量','文件柜的容量大小能限制吗？'),('002','015022075','工作流 新建工作  工作流程','什么是常用工作流程？'),('002','015022076','工作流 我的工作 主办  会签  区别','主办与会签有什么区别？'),('002','015022077','工作流 工作查询  归档 查询','归档查询如何使用？'),('002','015022078','工作流 工作监控 查询 区别','工作流监控和工作流查询的的区别是什么？'),('002','015022080','工作流 工作委托 作用','工作委托的作用是什么？'),('002','015022082','工作流 数据归档 操作 ','进行数据归档操作时需要注意什么？'),('002','015022083','工作流 表单设计 word 表格 表单 智能 设计器  居中','从word里复制表格到表单智能设计器中，怎样居中？'),('002','015022084','工作流 流程设计 工作移交  作用','工作流中的工作移交的作用？'),('002','015023085','行政办公 公告通知 审批 公告 修改 内容 ','我想让审批人在审批公告时可以修改公告内容，怎样实现？'),('002','015023087','行政办公 新闻管理  编辑框  插入图像','怎样在新闻编辑框中插入图像？'),('002','015023088','行政办公 投票管理 投票  形式','投票有哪些形式？'),('002','015023089','行政办公 日程安排 查询','我可以查询哪些人的日程安排？'),('002','015023092','行政办公 工作计划  发布范围   参与人  负责人  批注领导  含义','新建工作计划中，发布范围、参与人、负责人、批注领导分别是什么含义？'),('002','015024100','知识管理 公共文件柜  设置 权限','公共文件柜设置中的权限都是什么意思？'),('002','015025','智能门户 资讯门户  信息  自定义  播放  视频媒体','资讯门户上的信息怎样自定义可以播放视频媒体？'),('002','015030','项目管理  文档目录 文档库 添加','文档目录添加说明'),('002','015038143','系统管理 OA系统管理员  修改  名称','为何不能修改OA系统管理员及其名称？'),('002','015048','OA精灵PC端 传输 文件','精灵客户端下如何传输文件？'),('002','020160181','个人事务 电子邮件 接收者  邮件  正文内容  发送者  丢失','接收者和发送者看到的邮件正文内容丢失了部分的可能情况？'),('002','020160183','个人事务 手机短信 服务器  每天 重启服务器    发送超时 ','服务器设置了每天早上重启，为何手机短信都发送超时，需要重启服务器才可以？'),('002','020160194','公共文件柜  个人文件柜  共享文件柜  区别','公共文件柜，个人文件柜，共享文件柜之间的区别？'),('002','020161196','工作流  员工离职  申请过的流程','员工离职其之前申请过的流程怎么办？'),('002','020161197','工作流 委托工作  用户','是否可以帮其他用户委托工作？'),('002','020161198','工作流  表单  查询','工作流中表单怎样才能保存起来以备以后的查询？'),('002','020161199','工作流 表单  控件  备选字段  显示','为什么表单添加了控件以后在备选字段没有显示？'),('002','020161200','工作流 流程属性  所属部门','流程属性中流程所属部门在什么情况下使用？'),('002','020162206','行政办公 公告通知  MHT格式  超级链接','怎样使用公告通知中的MHT格式和超级链接？'),('002','020162215','行政办公 参数设置  计算折旧方式  残值处理方式  修改  设定','在参数设置中“计算折旧方式”和“残值处理方式”一经设定后，还可以修改 吗？'),('002','020163221','知识管理 公共文件柜  多余  错误的文件','怎样删除公共文件柜中多余的或者错误的文件？'),('002','020166227','人力资源 人事档案  人员档案  管理  删除  在职人员  树状结构  列表','在人事档案管理中删除人员档案后，为什么在职人员在树状结构目录下还存在，但右侧列表中却显示已删除？'),('002','020166230','人力资源 办公地点  考勤机  多个','如果有多个办公地点，能不能同时使用多个考勤机？'),('002','020169','CRM模块  显示字段  修改','CRM模块显示字段如何修改？'),('002','020172240','交流园地 集成  论坛  系统  同步  登录','集成了discuz X2论坛，登录OA系统，为什么不能同步登录论坛？'),('002','020177255','系统管理 Office附件  在线编辑  盖章  印章','Office附件在线编辑的时选择盖章为什么看不到在印章管理里面制作的印章？'),('002','020177256','系统管理 签章不能保存','签章不能保存？'),('002','020177264','系统管理 数据库备份  注意事项','数据库备份注意事项？'),('002','020178','OA精灵PC端 自动升级  版本信息  进度条','精灵自动升级，一直提示“读取版本信息”，进度条不走？'),('002','020179','OA精灵移动版  手机客户端  空白','精灵手机客户端登录，出现面板空白登录不上的几种情况：'),('002','020180275','托管服务器  端口映射  外网访问','托管服务器，不做端口映射，为何外网访问不了？'),('002','020180276','控制中心  无法启动  卸载  一闪即过','通达应用服务控制中心各个服务都无法启动，服务卸载和服务注册时，为何弹出的窗口一闪即过？'),('002','020180277','应用服务 数据库  应用服务  升级','怎样将数据库与web应用服务分离的程序版本升级？'),('002','020180278','登录界面 验证失败 域','OA系统登录提示：用户【XXX】域验证失败(Invalid credentials)的对应解决？'),('003','010006','新手入门 忘记 OA 密码','OA密码忘记了怎么办？'),('003','010012','新手入门 发布 公告通知','怎么发布公告通知？'),('003','010015','新手入门 增量 升级包','什么是增量升级包？'),('003','015021060','个人事务 电子邮件 导出 内部邮件 附件','如何导出内部邮件的附件？'),('003','015021071','个人事务  工作日志 导出','怎样导出工作日志？'),('003','015022076','工作流 我的工作  删除 作废 工作','如何进行工作删除？'),('003','015022077','工作流 工作查询   分类汇总','工作流查询后，怎样分类汇总？'),('003','015022083','工作流 表单设计 宏控件','宏控件是什么意思？'),('003','015022084','工作流 流程设计 固定流程  自由流程  区别','固定流程与自由流程有什么区别？'),('003','015023085','行政办公 公告通知 授权 公告 审批','怎么授权可以审批公告的人员？'),('003','015023087','行政办公 新闻管理  特殊功能','“新闻”具有哪些特殊功能？'),('003','015023088','行政办公 投票管理 选择型投票  特殊写法','在选择型投票中有哪些特殊写法？'),('003','015023092','行政办公 工作计划  管理模块  作用','工作计划管理模块的作用？'),('003','015024100','知识管理 公共文件柜 删除 子目录','怎样删除公共文件柜里的某个子目录？'),('003','015025','智能门户 企业门户  定时  自动刷新','企业门户是否可以定时自动刷新？'),('003','015030','项目管理  汇总报表','汇总报表展示'),('003','015038143','系统管理 辅助角色  用户','怎样使用用户的辅助角色？'),('003','015048','OA精灵PC端 显示 名片 二维码','如何使用名片二维码？'),('003','020160181','个人事务 电子邮件 发送  收取  附件  外部邮件  打不开','发送或收取带附件的外部邮件时，附件打不开？'),('003','020160183','个人事务 手机短信  提醒','手机短信能收到但是不提醒？'),('003','020161196','工作流  兼职  两个部门  使用流程','当某一个员工兼职两个部门，如何使用流程？'),('003','020161197','工作流 工作委托规则  自动委托  查询','工作委托规则，自动委托出去的工作，能否查询到？'),('003','020161198','工作流 高级查询  统计  数字','工作流高级查询统计出来的excel文件，数字列没有统计？'),('003','020161199','工作流 表单  字段  信息  无法保存','表单某些字段输入信息后无法保存？'),('003','020161200','工作流 版式文件  转换','工作流版式文件转换中，但是转换不成功？'),('003','020162206','行政办公 公告通知  进行管理','公告通知由哪些人进行管理？'),('003','020162215','行政办公 数据导入  资产  保管人  列表  无法显示','数据导入后资产保管人在列表中为什么无法显示？'),('003','020163221','知识管理 公共文件夹  1T大小  性能','在公共文件夹放1T大小的文件,会不会影响性能？'),('003','020169','客户信息  客户联络  售前  字段  自定义','CRM中，在查看客户信息中，“客户联络”、“售前”等字段怎样自定义？'),('003','020172240','交流园地 升级  超级论坛  同步','升级之后超级论坛不能同步？'),('003','020177256','系统管理 修改  上传附件  大小  限制','怎样修改OA上传附件大小限制?'),('003','020177264','系统管理 备份  数据库目录  附件目录  转移  其它电脑  定期','定期将备份的数据的必要性'),('003','020178','OA精灵PC端 升级  停止工作','win7下精灵升级出现：TDUpdate已停止工作？'),('003','020179','OA精灵移动版 无法连接  白板  无法打开  客户端','无法连接情况：iOS客户端登录不成功，显示白板，或Android客户端无法打开页面？'),('003','020180275','路由器  端口映射  域名  外网访问','Adsl路由器上网，已做端口映射，域名正常，为何外网访问不了？'),('003','020180276','服务器监控  错误服务器信息  内容','现象：系统管理-服务器监控，看到的错误服务器信息或者没有显示内容？'),('003','020180277','应用服务 服务器  修正合集  重新登录  升级','服务器安装修正合集后，重新登录后为何没有提示升级？'),('003','020180278','登录界面 OA系统用户  禁止登陆','OA系统显示用户XX被设定为禁止登录！'),('004','010006','新手入门 登录 修改  OA密码','怎样实现第一次登录OA系统时必须修改OA密码？'),('004','010012','新手入门 查询 公告通知','如何查询别人发给我的公告通知、新闻以及需要我参与的投票？'),('004','010015','新手入门 修正 合集','什么是修正合集？'),('004','015021060','个人事务 电子邮件 鼠标手势 阅读 邮件','如何使用鼠标手势阅读下一封邮件？'),('004','015022076','工作流 我的工作 OA系统  收回流程','OA系统流程如何收回流程？'),('004','015022077','工作流 工作查询  权限 个人 部门 全体','工作流查询的权限怎样按不同范围设置？'),('004','015022083','工作流 表单设计 列表控件','在什么情况下用到列表控件？'),('004','015022084','工作流 流程设计 子流程  使用','子流程在是什么意思，在什么情况下使用？'),('004','015023085','行政办公 公告通知 设置 集团公告 发布 不用审批','如何在审批公告中设置无需审批人员？'),('004','015024100','知识管理 公共文件柜 文件 移动 目录','怎样把公共文件柜中A目录下的某文件移动到B目录下？'),('004','015025','智能门户 集团门户  企业网站  系统','什么是集团门户？怎样将集团门户改为以企业网站系统为中心的门户？'),('004','015030','项目管理  立项信息 预算','立项信息填写说明'),('004','015038143','系统管理 添加  部门信息  分支机构','添加部门信息里，“做为分支机构”是什么意思？'),('004','015048','OA精灵PC端 新建便签 设置 自动弹出','如何新建便签并设置为下次登录自动弹出？'),('004','020160181','个人事务 电子邮件 用户  邮件  无权打开','打开用户邮件出现提示：您无权打开该邮件？'),('004','020161196','工作流  OA系统 流程  主办人  正确选择','OA系统流程如何正确选择主办人？'),('004','020161197','工作流 委托人  查看  办理情况','委托过的工作流，委托人可以查看目前的办理情况吗？'),('004','020161198','工作流 归档  参数无效','为什么工作流归档时提示参数无效？'),('004','020161199','工作流 表单数据 修改表单 影响','工作流在建立过一些流程后，怎么修改表单不会影响之前的表单数据？'),('004','020161200','工作流 流程设计器  可写字段  步骤  无法保存','流程设计器里面设置步骤可写字段无法保存？'),('004','020162215','行政办公 固定资产  导入  类型','行政办公中固定资产模块的导入设置中，增加类型是什么意思？'),('004','020163221','知识管理 公共文件柜  加载','打开公共文件柜 显示 加载……？'),('004','020169','CRM模块  管理员  视图  默认字段  实体','crm模块提示：联系管理员，您没有对应的可查看的视图或显示实体下默认字段？'),('004','020172240','交流园地 讨论区  数据  恢复','讨论区的数据如何恢复？'),('004','020177264','系统管理 数据库管理  在线人员  作用','数据库管理中，在线人员的作用是什么？'),('004','020178','OA精灵PC端  菜单功能  浏览器  修改','修改了默认浏览器打开精灵的菜单功能，为什么打开的都是IE浏览器？'),('004','020180275','远程访问  不生效  IP地址','设置远程访问后不生效，为何IP地址可以ping通？'),('004','020180276','用户  运行  服务数据库  锁定','用户运行OA出现提示：服务数据库已锁定？'),('004','020180277','应用服务 更换  服务器  注意  事项','更换服务器需要注意哪些事项？'),('005','010003','新手入门 设置 取消 关注','如何设置和取消人员关注？ '),('005','010012','新手入门 办公用品 申领','怎样进行办公用品的申领？'),('005','010015','新手入门 安装 修正 合集 ','怎样安装修正合集？'),('005','015021060','个人事务 电子邮件 收回 已发送 邮件','如何收回已发送的邮件？'),('005','015022076','工作流 我的工作 退回流程','OA系统如何退回流程？'),('005','015022077','工作流 工作查询 保存 反复 相同 查询条件 ','我经常反复用到一些相同的查询条件，能保存吗？'),('005','015022083','工作流 表单设计 设置 获取 其他表单 ','要获取其他表单中的数据该如何设置？'),('005','015022084','工作流 流程设计 流程属性  所属部门','流程属性中，流程所属部门，这个具体在什么情况下应用？'),('005','015023085','行政办公 公告通知 删除 不需要 审批 公告','作为公告发布人，如何删除公告？'),('005','015023088','行政办公 投票管理 子投票 投票 形式','子投票及投票有哪些注意事项及应用技巧？'),('005','015023089','行政办公 日程安排 查询 日程','日程安排有哪些相关注意事项？'),('005','015024100','知识管理 公共文件柜 目录 移动','怎样把公共文件柜中A1目录移动到A目录下？'),('005','015030','项目管理  立项 添加审批','立项与审批说明'),('005','015038143','系统管理 用户管理  多个角色  其中一个  符合条件  筛选','在用户管理中，怎么才能把多个角色中的其中一个符合条件的角色的人员都筛选出来？'),('005','015048','OA精灵PC端 即时 通讯 未授权 操作 限制','即时通讯未授权（即体验版）用户有哪些操作限制？'),('005','020160181','个人事务 电子邮件 外部邮件  失败  附件  发送','为何发送带附件的外部邮件会失败？'),('005','020161196','工作流  OA系统  环节  频繁  办理人员  查询  辅助角色','OA系统某环节经常频繁出现某人为办理人员，但查询其辅助角色没有此环节的经办角色？'),('005','020161197','工作流 被委托人  委托  办理','被委托人可以把别人委托的工作流程再委托给其他人办理吗？'),('005','020161198','工作流 我的工作  工作监控  空白','我的工作和工作监控页面，流程显示空白？'),('005','020161199','工作流 控件  居中  居左','添加的控件如何设置居中，不能居左？'),('005','020161200','工作流 试用  打印模板','打印模板为何会显示“试用”水印？'),('005','020163221','知识管理 公文文件柜  子文件夹  设置权限','公共文件柜的子文件夹怎样独立设置权限？'),('005','020178','OA精灵PC端 登录  即时通讯  不存在  用户名称  系统管理员','登录即时通讯时，提示：用户名称不存在，请联系管理员？'),('005','020180276','office_Task服务  启动  报错  情况  系统  弹出','Office_Task服务启动不了,报错:Runtime Error!Program: e:\\MYOA\\bin\\Office_Task.exe系统不断弹出跟tmp有关报错，清空tmp下内容后隔一会还是弹出同样报错。'),('005','020180277','应用服务  数据库服务器  分离','应用服务与数据库服务分离的一些情况？'),('006','010012','新手入门 文件柜 使用','如何使用文件柜？'),('006','015021060','个人事务 电子邮件 避免 丢失 编辑 邮件','怎样避免丢失正在编辑的邮件？'),('006','015022076','工作流 我的工作 套打实现','套打怎么实现？'),('006','015022077','工作流 工作查询   excel形式 导出 工作数据','工作查询中能否以excel形式导出某流程下的工作数据？'),('006','015022083','工作流 表单设计 日历 部门人员 控件','怎样使用日历控件、部门人员控件？'),('006','015022084','工作流 流程设计 手写呈批单','手写呈批单如何应用？'),('006','015023085','行政办公 公告通知 公告通知 发布 范围','我能给哪些人员发布公告通知？'),('006','015024100','知识管理 查询 全局搜索 区别','文件柜中的“查询”和“全局搜索”有什么区别？'),('006','015030','项目管理  时间管理','时间管理展示'),('006','015038143','系统管理 模块设置权限  实现  功能','按模块设置权限可以实现什么功能？'),('006','015048','OA精灵PC端 登录 提示 用户 授权 范围','为什么登录的时候提示“用户不在即时通讯授权使用范围”？'),('006','020160181','个人事务 电子邮件 163邮箱  收邮件  发邮件','为什么外部163邮箱只能收邮件不能发邮件？'),('006','020161196','工作流  查看  父子流程  表单  流水号','OA系统如何查看父子流程表单及父子流程的流水号？'),('006','020161197','工作流 委托规则  被委托人  委托人  流程  办理','设置委托规则后的流程，在被委托人没有办理之前，委托人还可以办理吗？'),('006','020161199','工作流 多行输入框  默认值  预览  换行','在多行输入框中设置多行默认值后，在预览文字时为什么不能换行？'),('006','020161200','工作流 升级  版式文件  试用','升级OA后，为什么版式文件变成试用了？'),('006','020163221','知识管理 公共文件柜  文件夹  文件名  下载  阅读  文档  浏览','公共文件柜能否设置某人可以浏览文件夹内文件名，但是不能下载和阅读文件夹内的文档?'),('006','020178','OA精灵PC端  浏览器  登录  用户名  不存在','精灵登录很慢，用浏览器就正常，并且精灵登录后，IM提示：用户名不存在？'),('006','020180276','客户端  服务器  非常慢  无法显示网页  报错','OA服务都正常，客户端访问不了，服务器上访问非常慢，登录后很多地方出现无法显示网页，以及waring报错？'),('007','010003','新手入门 绑定 企业社区 账号','如何绑定企业社区账号?'),('007','010012','新手入门 工作 办理','如何进行工作办理？'),('007','015021060','个人事务 电子邮件 邮件 容量控制','电子邮件的容量控制是指什么？'),('007','015022083','工作流 表单设计 word 表单导入 预览为空','为什么将word中的表单导入之后，表单预览时为空？'),('007','015022084','工作流 流程设计 设置 列表 扩展 字段','设置列表扩展字段有什么作用？'),('007','015023085','行政办公 公告通知 审批公告 无权限 设置 角色','我收到“请审批公告通知”的提醒，点开提示“无该模块使用权限！如需使用该模块，请联系管理员重新设置本角色权限！”怎么回事？'),('007','015023089','行政办公 日程安排 建立 时段 日 周 月 安排','如何建立各类日程安排？'),('007','015024100','知识管理 附件 误删除  ','文件柜中的附件被我误删除了，如何找回？'),('007','015030','项目管理  添加干系人','添加干系人说明'),('007','015038143','系统管理 一台机器  多个  用户  登录','一台机器能多个用户登录吗？'),('007','015048','OA精灵PC端 即时 通讯 内网 外网 连接','为什么即时通讯内网可以连接外网连接不了？'),('007','020161196','工作流  流程结束  看不到  打印凭证  按钮','OA系统流程结束为什么看不到打印凭证的按钮？'),('007','020161199','工作流 宏控件  升级后  升级前  获取信息','某流程在升级后和升级前走过的该流程宏控件显示的都是“宏控件”，而不是宏控件获取到的信息？'),('007','020161200','工作流 可写字段  备选字段  空白字段','在设置步骤可写字段时，备选字段里面有一些空白字段？'),('007','020163221','知识管理 公共文件柜  部分  标签项','公共文件柜设置中部分电脑上显示不出对应的标签项？'),('007','020178','OA精灵PC端 登录  网页登录  菜单功能  不出来  请稍等','为什么同一台电脑精灵登录时，菜单功能显示不出来，用网页登录OA时，显示：正在登录OA系统，请稍候......？'),('007','020180276','未登录  重新登录','提示：用户未登录，请重新登录！'),('008','010012','新手入门 流程设计 步骤','流程设计的必要步骤是什么？'),('008','015021060','个人事务 电子邮件 设置 邮件 签名','如何设置邮件签名？'),('008','015022083','工作流 表单设计 word 表单 复制 粘贴 智能 设计器 边框消失','Word设计好的表单复制粘贴到智能设计器边框消失怎么办？'),('008','015022084','工作流 流程设计 打印 模板 作用','打印模板的作用是什么？'),('008','015023085','行政办公 公告通知  公告通知 查阅 ','我发布出去的公告通知，如何查看已阅范围？'),('008','015030','项目管理  首页 新建 状态 查询 看板','项目首页说明'),('008','015038143','系统管理  动态密码卡  绑定  取消动态密码卡','系统管理员绑定了动态密码卡，怎样取消动态密码卡？'),('008','015048','OA精灵PC端 自动更新','怎样设置客户端自动更新OA精灵？'),('008','020161196','工作流  经办人  转交下一步  可选','为什么转交下一步时无经办人可选？'),('008','020161199','工作流 表单  整体设计','如何查看表单的整体设计情况？'),('008','020161200','工作流 办理人  表单  相关内容  控制','如何控制流程办理人只能填写表单中的相关内容？'),('008','020178','OA精灵PC端 用户名  密码  错误','用户名或密码错误情况？'),('008','020180276','升级文件 无反应','升级时点击升级文件无反应。'),('009','010003','新手入门 设置 精灵照片 头像','怎样设置精灵照片与头像？'),('009','010012','新手入门 角色','什么是角色？'),('009','015021060','个人事务 电子邮件 POP3 ','如何使用POP3功能？'),('009','015022083','工作流 表单设计  打印 控件 字体大小 样式 ','打印表单时，某些控件里显示的字体大小样式与其他的不一样，怎么调整？'),('009','015022084','工作流 流程设计 查询 字段 作用','查询字段的作用是什么？'),('009','015030','项目管理  详情 文档 任务 问题 讨论 批注','项目详情说明'),('009','020161196','工作流  办理界面  表单控件  置灰  显示','工作流办理界面，为什么表单控件处会显示为灰色，无法输入内容？'),('009','020161199','工作流 列表控件  默认数据  下拉项  内容','列表控件里的下拉项填写内容后点击保存，数据恢复成默认数据？'),('009','020161200','工作流 发起人  附件  后续步骤  修改  查看','流程发起人上传的附件，如何实现后续步骤只允许查看不能修改？'),('009','020178','OA精灵PC端 用户  组织  登录  在线  单位  名称  即时通讯','用户已登录上即时通讯，为何在组织-在线中只能看到单位的名称？'),('009','020180276','服务器  加密锁  重启  操作系统  插入','现象：服务器插入加密锁不能重启（操作系统window2008），拔掉即可。'),('010','010012','新手入门 角色 排序号','角色排序号的作用是什么？'),('010','015021060','个人事务 电子邮件 邮件 智能分类','如何使用邮件智能分类功能？'),('010','015022083','工作流 表单设计  添加 公司 logo','如何在表单中添加公司的logo图片？'),('010','015022084','工作流 流程设计 菜单定义指南  作用','菜单定义指南的作用是什么？'),('010','015030','项目管理  详情 首页 进度','项目进度展示'),('010','020161196','工作流  表单  空白  内容','为什么表单显示空白，无法输入内容？'),('010','020161199','工作流 自动收取  外部邮件  间隔时间','怎样设置自动收取外部邮件的间隔时间？'),('010','020161200','工作流 打印  版式文件','打印板式文件不出现？'),('010','020178','OA精灵PC端 修改图片  不显示','精灵修改图片后为何不显示？'),('011','015021060','个人事务 电子邮件 信件 转移 其他邮件箱','如何将信件快速转移到其他邮件箱中？'),('011','015022083','工作流 表单设计 下拉 菜单 多级联动','如何实现下拉菜单多级联动？'),('011','015022084','工作流 流程设计 清除 流程 测试 数据','如何清除流程测试的数据？'),('011','015030','项目管理  预算 成本','预算及成本展示'),('011','020161196','工作流  办理界面  转交下一步  按钮','工作办理界面看不到“转交下一步”按钮？'),('011','020161199','工作流 列表控件  列表项  数据错位','删除列表控件中某列表项后导致之前数据错位？'),('011','020161200','工作流 打印模板  页码界面  模板文件','打印模板选择模板文件未出现转化页码界面，点新建模板的时候提示：请选择模板文件？'),('011','020178','OA精灵PC端 登录  精灵图标  自动消失  右下角','精灵登录后，桌面右下角精灵图标会自动消失？'),('012','010012','角色 排序号 作用','角色都有哪些注意事项及相关应用？'),('012','015021060','个人事务 电子邮件 发送人 部门','怎样设置在发送电子邮件选择发送人时只能看到或者发送给部门的人员？ '),('012','015022083','工作流 表单设计 智能 设计器 宏 模 css js','在什么情况下使用表单智能设计器上方的宏、模、CSS、JS？'),('012','015022084','工作流 流程设计 并发  允许并发  强制并发  区别','并发是什么意思，允许并发与强制并发的区别是什么？'),('012','015030','项目管理  资源管理','资源管理展示'),('012','020161196','工作流  工作流转交  提示  加载完毕  表单  提交','工作流转交提示：表单尚未加载完毕，请等待后提交？'),('012','020161199','工作流 表单  不显示','表单设计源码完整，但不能显示表单的可能情况'),('012','020161200','工作流 打印模板  打印纸  映射  字段  表格','表单打印界面选择打印模板后打印，为何打印纸上只显示映射的字段而不显示设计好的表格？'),('013','010003','新手入门 界面主题 选择','怎样进行界面主题选择？'),('013','010012','新手入门 设置 用户 同一个门户','怎样设置所有用户打开系统时显示同一个门户？'),('013','015022084','工作流 流程设计 条件设置  作用  流程','条件设置的作用是什么？'),('013','015030','项目管理  自定义 字段','自定义字段添加说明'),('013','020161196','工作流 退回 办理界面 按钮','设置允许退回后，办理界面没有退回按钮？'),('013','020161199','工作流 手写签章控件  作用','手写签章控件的作用？'),('013','020161200','工作流 版式文件  打印  映射','版式文件打印的时候没有映射的内容？'),('014','010012','新手入门 OA系统  OA精灵  下载位置','OA系统里OA精灵下载位置？'),('014','015022084','工作流 流程设计 步骤号','当前流程设计步骤号和当前步骤号的区别是什么？'),('014','020161196','工作流  转交  下一步骤  勾选','流程办理转交，选择下一步骤时不能勾选某些步骤？'),('014','020161199','工作流 计算控件  作用','计算控件的作用？什么情况下可以使用该控件？'),('014','020161200','工作流 版式文件  打印  网络下载  路径  已存在','在用版式文件打印时，有的电脑会出现提示：阅读pdf需要gsdll32.dll，请您直接从网络下载，如果该文件已存在，就检查路径。'),('015','010012','新手入门 OA精灵 使用','开始使用OA精灵前，您需要知道什么？'),('015','015022084','工作流 流程设计 编号 流水号 区别','编号与流水号的区别是什么？'),('015','020161196','工作流  新建流程  文号  不能修改','新建流程时,为什么文号不能修改?'),('015','020161199','工作流 表单默认值  使用','表单默认值的使用方法'),('015','020161200','工作流 经办权限  部门  角色  人员  合集','经办权限为“部门”、“角色”、“人员”三者的合集，何谓“合集”？'),('016','010003','新手入门 快捷菜单 增加 删除 ','我的桌面，快捷菜单如何根据需要进行增加和删除？'),('016','010012','新手入门 OA精灵 发送 即时通讯 消息 ','如何发送即时通讯消息？'),('016','015022084','工作流 流程设计 工作 流程设计 字段保密','工作流程设计中的字段保密是什么概念？'),('016','020161196','工作流  主办人  已办结  执行中','为什么执行中的某步骤的主办人在我的工作中看到的状态是已办结？'),('016','020161199','工作流 表单设计器  宽度  汉字','在表单设计器中，设置一个框的宽度时，多少宽度等于一个汉字？'),('016','020161200','工作流 流程设计器  作用','流程设计器的作用是什么？'),('017','015022084','工作流 流程设计 表单  必填项  数据  提交表单','工作流表单中如何设定必填项？'),('017','020161196','工作流  流程数据  保存  自动消失','走流程，流程数据填写后点击保存会自动消失？'),('017','020161199','工作流 表单  锚点链接','如何在表单里加页内锚点链接？'),('017','020161200','工作流 编辑权限  点评权限  作用','编辑权限、点评权限的作用？'),('018','015022084','工作流 流程设计 条件设置  转入条件  ，满足','在条件设置中，如何设置转入条件的关系为：1和2同时满足，或者满足3？'),('018','020161196','工作流  转交下一步  没反应  正常','某个流程点转交下一步没反应，其他流程都正常？'),('019','015022084','工作流 流程设计 流程  跳转','如何实现流程的跳转，例如：从第一步到第二步或是第四步？'),('019','020161196','工作流  办理界面  上传附件  公共附件  无权上传附件','工作流办理界面，为什么上传附件提示“无公共附件,并且您无权上传附件!”？'),('020','015022084','工作流 流程设计 办理时限  步骤','怎么设置某一步骤的办理时限？'),('020','020161196','工作流  结束流程  通知  用户  参加','怎样把结束流程通知给没有参加此流程的用户？'),('021','015022084','工作流 流程设计 定时流程  发起','怎么设置定时流程的发起？'),('021','020161196','工作流  主办人  经办人  工作移交  会签界面','主办人和经办人把工作移交给了B，B点击主办为何进入的是会签界面？'),('022','015022084','工作流 流程设计 表单 自动赋值   不可修改','如何实现表单里某一项内容，实现自动赋值但不可修改？'),('022','020161196','工作流  附件不能上传','个别附件不能上传？'),('023','015022084','工作流 流程设计 控制 流程 办理人员 填写 内容','如何控制流程办理人员只能填写表单中的相关内容？'),('023','020161196','工作流  新建工作  解析  文档','新建工作时，出现“不能解析XML文档”？'),('024','015022084','工作流 流程设计 部门主管  审批  自动选择','流程中怎样直接选择自己部门主管审批?如：请假申请后，系统智能选择本部门主管。'),('024','020161196','工作流  打印表单  电子签章  控件组件  提示','为什么每次打印表单时都提示让安装点聚电子签章控件组件？'),('025','015022084','工作流 流程设计 传阅 作用','传阅的作用是什么？'),('025','020161196','工作流  表单打印  选项','表单打印中怎样将右边的选项放在下面？'),('026','015022084','工作流 流程设计  internet 邮件提醒','如何使用工作流Internert邮件提醒？'),('026','020161196','工作流  打印界面  数据','表单打印界面不显示数据，而显示DATA_ID？'),('027','020161196','工作流  手写签章   表格  错位  原因','手写签章与表格发生有错位的原因？'),('028','020161196','工作流  pdf附件  打开  空白','PDF附件打开后显示空白？'),('029','020161196','工作流  excel文件  下载  丢失  打不开  项目','excel文件下载到本地打不开，提示：丢失了Visual Basic 项目？'),('030','020161196','工作流  在线编辑  提示  读取错误','在线编辑文档时提示：文件读取错误？');
/*!40000 ALTER TABLE `help_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help_sort`
--

DROP TABLE IF EXISTS `help_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help_sort` (
  `sort_id` varchar(9) NOT NULL COMMENT '排序号',
  `sort_name` varchar(50) NOT NULL DEFAULT '' COMMENT '分类名称',
  `sort_code` varchar(100) NOT NULL DEFAULT '' COMMENT '分类目录名',
  PRIMARY KEY (`sort_id`) USING BTREE,
  UNIQUE KEY `sort_code` (`sort_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='帮助主题-分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_sort`
--

LOCK TABLES `help_sort` WRITE;
/*!40000 ALTER TABLE `help_sort` DISABLE KEYS */;
INSERT INTO `help_sort` VALUES ('010','新手入门','new'),('010003','个人设置','new/set'),('010006','帐号与密码','new/password'),('010009','登录','new/login'),('010012','新手应用','new/apply'),('010015','系统注册与维护','new/system_regist'),('015','高级应用技巧','skill'),('015021','个人事务','skill/mytable'),('015021060','电子邮件','skill/mytable/email'),('015021071','工作日志','skill/mytable/diary'),('015021073','个人文件柜','skill/mytable/file_folder'),('015022','工作流','skill/workflow'),('015022075','新建工作','skill/workflow/new'),('015022076','我的工作','skill/workflow/list'),('015022077','工作查询','skill/workflow/query'),('015022078','工作监控','skill/workflow/manage'),('015022079','数据报表','skill/workflow/report'),('015022080','工作委托','skill/workflow/rule'),('015022081','工作销毁','skill/workflow/destroy'),('015022082','数据归档','skill/workflow/archive'),('015022083','表单设计','skill/workflow/form'),('015022084','流程设计','skill/workflow/guide'),('015023','行政办公','skill/erp'),('015023085','公告通知','skill/erp/notify'),('015023087','新闻管理','skill/erp/news_manage'),('015023088','投票管理','skill/erp/vote_manage'),('015023089','日程安排','skill/erp/calendar'),('015023092','工作计划','skill/erp/work_plan'),('015024','知识管理','skill/knowledge'),('015024100','公共文件柜','skill/knowledge/file_folder'),('015025','智能门户','skill/portal'),('015027','人力资源','skill/hr'),('015027121','在线考试','skill/hr/exam_manage'),('015030','项目管理','skill/project'),('015038','系统管理','skill/system'),('015038143','组织机构设置','skill/system/dept'),('015038163','系统接口设置','skill/system/ext_user'),('015038170','Office文档在线编辑','skill/system/module_oc'),('015048','OA精灵PC端','skill/ispirit_pc'),('020','常见问题','common'),('020160','个人事务','common/mytable'),('020160181','电子邮件','common/mytable/email'),('020160183','手机短信','common/mytable/mobile_sms'),('020160190','个人考勤','common/mytable/attendance'),('020160192','工作日志','common/mytable/diary'),('020160194','个人文件柜','common/mytable/file_folder'),('020161','工作流','common/workflow'),('020161196','工作流办理','common/workflow/flow_work'),('020161197','工作委托','common/workflow/flow_rule'),('020161198','工作查询/监控','common/workflow/query_manage'),('020161199','表单设计','common/workflow/flow_form'),('020161200','流程设计','common/workflow/flow_guide'),('020162','行政办公','common/erp'),('020162206','公告通知','common/erp/notify'),('020162215','固定资产','common/erp/asset'),('020163','知识管理','common/knowledge'),('020163221','公共文件柜','common/knowledge/file_folder'),('020163222','网络硬盘','common/knowledge/netdisk'),('020166','人力资源','common/hr'),('020166227','人事管理','common/hr/manage'),('020166230','考勤管理','common/hr/attendance'),('020169','CRM系统','common/crm'),('020172','交流园地','common/comm'),('020172240','论坛','common/comm/bbs2'),('020177','系统管理','common/system'),('020177255','印章管理','common/system/seal_manage'),('020177256','手机签章管理','common/system/mobile_seal'),('020177264','数据库管理','common/system/database'),('020178','OA精灵PC端','common/ispirit_pc'),('020179','OA精灵移动版','common/ispirit_mobile'),('020180','其他','common/others'),('020180275','外网/内网访问慢','common/others/network_slow'),('020180276','升级、注册、加密锁','common/others/update_reg_lock'),('020180277','应用服务','common/others/operate'),('020180278','登录界面','common/others/login_window');
/*!40000 ALTER TABLE `help_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hierarchical_global`
--

DROP TABLE IF EXISTS `hierarchical_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hierarchical_global` (
  `GLOBAL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MODEL_ID` varchar(10) DEFAULT NULL COMMENT '模块id（要进行全局的模块）',
  `GLOBAL_PERSON` text,
  `GLOBAL_DEPT` text,
  `GLOBAL_PRIV` text,
  PRIMARY KEY (`GLOBAL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hierarchical_global`
--

LOCK TABLES `hierarchical_global` WRITE;
/*!40000 ALTER TABLE `hierarchical_global` DISABLE KEYS */;
INSERT INTO `hierarchical_global` VALUES (1,'0132','admin,','','');
/*!40000 ALTER TABLE `hierarchical_global` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hst_meeting`
--

DROP TABLE IF EXISTS `hst_meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hst_meeting` (
  `MEETING_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `MEET_NAME` varchar(255) NOT NULL COMMENT '会议名称',
  `SUBJECT` varchar(255) NOT NULL COMMENT '会议主题',
  `MEET_DESC` text NOT NULL COMMENT '会议描述',
  `START_TIME` datetime NOT NULL COMMENT '会议开始时间',
  `END_TIME` datetime NOT NULL COMMENT '会议结束时间',
  `USER_IDS` text NOT NULL COMMENT '出席人员',
  `ROOM_ID` int(11) NOT NULL COMMENT '会议室主键',
  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '申请人',
  `PROPOSER_TIME` datetime NOT NULL COMMENT '申请时间',
  `MANAGER_ID` varchar(50) NOT NULL COMMENT '审批人',
  `MANAGER_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `MEET_STATUS` char(10) NOT NULL DEFAULT '1' COMMENT '会议状态(1-待批 2-已批准 3-进行中 4-未批准 5-已结束)',
  `ATTACHMENT_ID` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '会议附件ID',
  `ATTACHMENT_NAME` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '会议附件NAME',
  `REASON` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '不批准原因',
  `ADVANCE_MIN` int(11) DEFAULT '0' COMMENT '提前进入会议时间（分钟)',
  PRIMARY KEY (`MEETING_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='视频会议会议详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hst_meeting`
--

LOCK TABLES `hst_meeting` WRITE;
/*!40000 ALTER TABLE `hst_meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `hst_meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hst_room`
--

DROP TABLE IF EXISTS `hst_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hst_room` (
  `ROOM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROOM_NAME` varchar(255) NOT NULL COMMENT '会议室名称',
  `USER_IDS` text NOT NULL COMMENT '开放使用人员',
  `DEPT_IDS` text NOT NULL COMMENT '开放使用部门',
  `PRIV_IDS` text NOT NULL COMMENT '开放使用角色',
  `ROOM_NO` varchar(255) NOT NULL COMMENT '会议室号',
  `ROOM_PWD` varchar(255) NOT NULL COMMENT '会议室密码',
  `SERVER_ADDR` varchar(255) NOT NULL COMMENT '服务器地址',
  `ROOM_MANAGER` text NOT NULL COMMENT '会议室管理员',
  PRIMARY KEY (`ROOM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='视频会议会议室表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hst_room`
--

LOCK TABLES `hst_room` WRITE;
/*!40000 ALTER TABLE `hst_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `hst_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `htmldocument`
--

DROP TABLE IF EXISTS `htmldocument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `htmldocument` (
  `AutoNo` int(11) NOT NULL AUTO_INCREMENT,
  `DocumentID` varchar(50) DEFAULT NULL,
  `XYBH` varchar(64) DEFAULT NULL,
  `BMJH` varchar(20) DEFAULT NULL,
  `JF` varchar(128) DEFAULT NULL,
  `YF` varchar(128) DEFAULT NULL,
  `HZNR` text,
  `QLZR` text,
  `CPMC` varchar(254) DEFAULT NULL,
  `DGSL` varchar(254) DEFAULT NULL,
  `DGRQ` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`AutoNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `htmldocument`
--

LOCK TABLES `htmldocument` WRITE;
/*!40000 ALTER TABLE `htmldocument` DISABLE KEYS */;
/*!40000 ALTER TABLE `htmldocument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `htmlhistory`
--

DROP TABLE IF EXISTS `htmlhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `htmlhistory` (
  `AutoNo` int(11) NOT NULL AUTO_INCREMENT,
  `DocumentID` varchar(50) DEFAULT NULL,
  `SignatureID` varchar(50) DEFAULT NULL,
  `SignatureName` varchar(50) DEFAULT NULL,
  `SignatureUnit` varchar(50) DEFAULT NULL,
  `SignatureUser` varchar(50) DEFAULT NULL,
  `KeySN` varchar(50) DEFAULT NULL,
  `SignatureSN` varchar(200) DEFAULT NULL,
  `SignatureGUID` varchar(50) DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `LogType` varchar(20) DEFAULT NULL,
  `LogTime` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AutoNo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `htmlhistory`
--

LOCK TABLES `htmlhistory` WRITE;
/*!40000 ALTER TABLE `htmlhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `htmlhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `htmlsignature`
--

DROP TABLE IF EXISTS `htmlsignature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `htmlsignature` (
  `DocumentID` varchar(254) DEFAULT NULL,
  `Signature` text,
  `SignatureID` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `htmlsignature`
--

LOCK TABLES `htmlsignature` WRITE;
/*!40000 ALTER TABLE `htmlsignature` DISABLE KEYS */;
/*!40000 ALTER TABLE `htmlsignature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_chat_list`
--

DROP TABLE IF EXISTS `im_chat_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `im_chat_list` (
  `LIST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '云办公用户UID',
  `FROM_UID` varchar(255) DEFAULT NULL COMMENT '云办公发消息人UID',
  `TO_UID` varchar(255) DEFAULT NULL COMMENT '云办公接收消息人UID',
  `OF_FROM` varchar(255) DEFAULT NULL COMMENT 'OF发消息人UID',
  `OF_TO` varchar(255) DEFAULT NULL COMMENT 'OF收消息人UID',
  `LAST_TIME` varchar(255) DEFAULT NULL COMMENT '最后消息时间',
  `LAST_ATIME` varchar(255) DEFAULT NULL COMMENT '入库时间',
  `LAST_CONTENT` text COMMENT '最后消息内容',
  `LAST_FILE_ID` varchar(255) DEFAULT NULL,
  `LAST_FILE_NAME` varchar(255) DEFAULT NULL,
  `LAST_THUMBNAIL_URL` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `MSG_TYPE` char(1) DEFAULT '1' COMMENT '会话类型（0单聊，1群聊）',
  `UUID` varchar(255) DEFAULT NULL,
  `msg_free` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LIST_ID`) USING BTREE,
  KEY `LAST_TIME` (`LAST_TIME`) USING BTREE,
  KEY `FROM_UID` (`FROM_UID`) USING BTREE,
  KEY `TO_UID` (`TO_UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `im_chat_list`
--

LOCK TABLES `im_chat_list` WRITE;
/*!40000 ALTER TABLE `im_chat_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `im_chat_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_chatlist`
--

DROP TABLE IF EXISTS `im_chatlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `im_chatlist` (
  `LIST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '云办公用户UID',
  `FROM_UID` varchar(255) DEFAULT NULL COMMENT '云办公发消息人UID',
  `TO_UID` varchar(255) DEFAULT NULL COMMENT '云办公接收消息人UID',
  `OF_FROM` varchar(255) DEFAULT NULL COMMENT 'OF发消息人UID',
  `OF_TO` varchar(255) DEFAULT NULL COMMENT 'OF收消息人UID',
  `LAST_TIME` varchar(255) DEFAULT NULL COMMENT '最后消息时间',
  `LAST_ATIME` varchar(255) DEFAULT NULL COMMENT '入库时间',
  `LAST_CONTENT` text COMMENT '最后消息内容',
  `LAST_FILE_ID` varchar(255) DEFAULT NULL,
  `LAST_FILE_NAME` varchar(255) DEFAULT NULL,
  `LAST_THUMBNAIL_URL` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `MSG_TYPE` char(1) DEFAULT '1' COMMENT '会话类型（0单聊，1群聊）',
  `UID_IGNORE` varchar(255) DEFAULT NULL COMMENT '会话列表忽略标记',
  `UUID` varchar(255) DEFAULT NULL,
  `msg_free` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LIST_ID`) USING BTREE,
  KEY `LAST_TIME` (`LAST_TIME`) USING BTREE,
  KEY `FROM_UID` (`FROM_UID`) USING BTREE,
  KEY `TO_UID` (`TO_UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会话列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `im_chatlist`
--

LOCK TABLES `im_chatlist` WRITE;
/*!40000 ALTER TABLE `im_chatlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `im_chatlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_friends`
--

DROP TABLE IF EXISTS `im_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `im_friends` (
  `FRD_ID` int(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `UID` varchar(20) DEFAULT NULL COMMENT '用户UID1',
  `FUID` varchar(20) DEFAULT NULL COMMENT '用户FuID',
  `MESSAGE` varchar(255) DEFAULT NULL COMMENT '验证消息',
  `PASS` int(20) DEFAULT NULL COMMENT '是否为好友的状态',
  PRIMARY KEY (`FRD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `im_friends`
--

LOCK TABLES `im_friends` WRITE;
/*!40000 ALTER TABLE `im_friends` DISABLE KEYS */;
/*!40000 ALTER TABLE `im_friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_message`
--

DROP TABLE IF EXISTS `im_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `im_message` (
  `IMID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_UID` varchar(40) DEFAULT NULL COMMENT '发消息人云办公UID',
  `TO_UID` varchar(40) DEFAULT NULL COMMENT '发消息人云办公UID',
  `OF_FROM` varchar(100) DEFAULT NULL COMMENT 'OF发消息人',
  `OF_TO` varchar(100) DEFAULT NULL COMMENT 'OF收消息人',
  `CONTENT` text COMMENT '纯文本消息内容',
  `FILE_ID` text COMMENT '附件ID串',
  `FILE_NAME` text COMMENT '附件文件名串',
  `THUMBNAIL_URL` text,
  `STIME` varchar(255) DEFAULT NULL COMMENT '发送时间',
  `ATIME` varchar(255) DEFAULT NULL COMMENT '入库时间',
  `TYPE` varchar(255) DEFAULT 'text' COMMENT '消息类型',
  `DFLAG` char(1) DEFAULT '0' COMMENT '删除标记（0未删除，1已删除）',
  `MSG_TYPE` varchar(1) DEFAULT '1' COMMENT '会话类型（1单聊，2群聊）',
  `UUID` varchar(255) DEFAULT NULL,
  `REAL_URL` varchar(255) DEFAULT NULL COMMENT '真实路径',
  PRIMARY KEY (`IMID`) USING BTREE,
  KEY `STIME` (`STIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `im_message`
--

LOCK TABLES `im_message` WRITE;
/*!40000 ALTER TABLE `im_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `im_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `im_room`
--

DROP TABLE IF EXISTS `im_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `im_room` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `RNAMR` text,
  `RSET_UID` varchar(255) DEFAULT NULL COMMENT '创建人ID',
  `RSET_OFID` varchar(255) DEFAULT NULL COMMENT '创建人openforeID',
  `RTIME` varchar(255) DEFAULT NULL COMMENT '创建时间',
  `RMEMBER_UID` text,
  `RMEMBER_OFID` varchar(255) DEFAULT NULL COMMENT '房间成员openfireID',
  `ROUT_UID` varchar(255) DEFAULT NULL COMMENT '已离开房间人员ID',
  `ROUT_OFID` varchar(255) DEFAULT NULL COMMENT '已离开房间成员openfireID',
  `RINVITE` varchar(1) DEFAULT '1' COMMENT '邀请权限(1为有权限，0为无权限)',
  `RCHANGE` varchar(1) DEFAULT '1' COMMENT '修改房间名称的权限',
  `ROOM_OF` varchar(255) DEFAULT NULL,
  `ROOM_STATUS` int(11) DEFAULT '0' COMMENT '群状态（0：正常，-1：群解散）',
  PRIMARY KEY (`RID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `im_room`
--

LOCK TABLES `im_room` WRITE;
/*!40000 ALTER TABLE `im_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `im_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_expense_plan`
--

DROP TABLE IF EXISTS `income_expense_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_expense_plan` (
  `PLAN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `PLAN_CODE` varchar(255) NOT NULL DEFAULT '' COMMENT '计划编码',
  `PLAN_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '计划名称',
  `PLAN_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '计划类别',
  `PLAN_CYCLE` int(11) DEFAULT '0' COMMENT '计划执行周期',
  `PLAN_CYCLE_UNIT` char(10) NOT NULL DEFAULT '1' COMMENT '周期单位(1-天,2-周,3-月,4-年)',
  `EXPENSE_BUDGET` decimal(12,2) DEFAULT '0.00' COMMENT '支出预算',
  `INCOME_BUDGET` decimal(12,2) DEFAULT '0.00' COMMENT '收入预估',
  `REAL_EXPENSE` decimal(13,2) DEFAULT '0.00' COMMENT '总支出',
  `REAL_INCOME` decimal(13,2) DEFAULT '0.00' COMMENT '总收入',
  `EXPENSE_BUDGET_ALERT` decimal(13,2) NOT NULL DEFAULT '1.00' COMMENT '支出预算超额提醒',
  `PLAN_STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '计划状态（0-未启动，1-进行中，2结束）',
  `IS_START` char(10) NOT NULL DEFAULT '0' COMMENT '是否支出超预算（0-否，1-是）',
  `BEGIN_TIME` datetime DEFAULT NULL COMMENT '启动时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `ALL_USER` char(10) NOT NULL DEFAULT '1' COMMENT '选择所有用户',
  `DEPT_IDS` text COMMENT '部门ID串',
  `ROLE_IDS` text COMMENT '角色ID串',
  `USER_IDS` text COMMENT '用户ID串',
  `CREATOR` varchar(50) NOT NULL COMMENT '创建人',
  `ATTACHMENT_ID` text COMMENT '附件ID',
  `ATTACHMENT_NAME` text COMMENT '附件名称',
  `PLAN_DESC` text COMMENT '描述',
  `PLAN_CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`PLAN_ID`) USING BTREE,
  UNIQUE KEY `INCOME_EXPENSE_PLAN_PLAN_CODE_UNIQUE` (`PLAN_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='计划管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_expense_plan`
--

LOCK TABLES `income_expense_plan` WRITE;
/*!40000 ALTER TABLE `income_expense_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_expense_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_expense_plan_type`
--

DROP TABLE IF EXISTS `income_expense_plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_expense_plan_type` (
  `PLAN_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `PLAN_TYPE_NAME` varchar(255) NOT NULL COMMENT '计划类别名称',
  `PLAN_TYPE_DESC` text COMMENT '计划类别描述',
  PRIMARY KEY (`PLAN_TYPE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='计划类别';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_expense_plan_type`
--

LOCK TABLES `income_expense_plan_type` WRITE;
/*!40000 ALTER TABLE `income_expense_plan_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_expense_plan_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_expense_records`
--

DROP TABLE IF EXISTS `income_expense_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_expense_records` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `PLAN_ID` int(11) NOT NULL COMMENT '收支计划ID',
  `EXPENSE` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '支出金额',
  `INCOME` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '收入金额',
  `RECORD_YEAR` varchar(10) NOT NULL DEFAULT '' COMMENT '年',
  `RECORD_QUARTER` varchar(10) NOT NULL DEFAULT '' COMMENT '季节',
  `RECORD_MONTH` varchar(10) NOT NULL DEFAULT '' COMMENT '月',
  `RECORD_DAY` varchar(10) NOT NULL DEFAULT '' COMMENT '日',
  `CREATOR` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',
  `RECORD_TIME` datetime DEFAULT NULL COMMENT '收支产生时间',
  `RECORD_DESC` text COMMENT '备注',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `CREATED_RE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`RECORD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收支记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_expense_records`
--

LOCK TABLES `income_expense_records` WRITE;
/*!40000 ALTER TABLE `income_expense_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_expense_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `income_expense_stat`
--

DROP TABLE IF EXISTS `income_expense_stat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `income_expense_stat` (
  `PLAN_ID` int(11) NOT NULL COMMENT '计划ID',
  `RECORD_ID` int(11) NOT NULL COMMENT '收支记录ID',
  `STAT_YEAR` varchar(10) NOT NULL DEFAULT '' COMMENT '年',
  `STAT_QUARTER` varchar(10) NOT NULL DEFAULT '' COMMENT '季节',
  `STAT_MONTH` varchar(10) NOT NULL DEFAULT '' COMMENT '月',
  `STAT_EXPENSE` decimal(13,2) DEFAULT '0.00' COMMENT '支出金额',
  `STAT_INCOME` decimal(13,2) DEFAULT '0.00' COMMENT '收入金额',
  `STAT_TIMES` int(11) NOT NULL DEFAULT '0' COMMENT '记录个数',
  `STAT_RECORD_TIME` datetime NOT NULL COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收支统计';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `income_expense_stat`
--

LOCK TABLES `income_expense_stat` WRITE;
/*!40000 ALTER TABLE `income_expense_stat` DISABLE KEYS */;
/*!40000 ALTER TABLE `income_expense_stat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info_center`
--

DROP TABLE IF EXISTS `info_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info_center` (
  `INFO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `INFO_NO` varchar(50) NOT NULL DEFAULT '0' COMMENT '默认应用序号',
  `INFO_NAME1` varchar(50) NOT NULL COMMENT '应用名称（简体中文）',
  `INFO_NAME2` varchar(50) NOT NULL COMMENT '应用名称（英文）',
  `INFO_NAME3` varchar(50) NOT NULL COMMENT '应用名称（繁体中文）',
  `INFO_NAME4` varchar(50) NOT NULL COMMENT '应用名称',
  `INFO_NAME5` varchar(50) NOT NULL COMMENT '应用名称',
  `INFO_FUNC_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '对应的FUNC_ID',
  `ICON_PATH` varchar(200) NOT NULL DEFAULT '' COMMENT '图标',
  PRIMARY KEY (`INFO_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='首页信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info_center`
--

LOCK TABLES `info_center` WRITE;
/*!40000 ALTER TABLE `info_center` DISABLE KEYS */;
INSERT INTO `info_center` VALUES (1,'01','公告','Notice','公告','','','4','0116.png'),(2,'02','新闻','News','新聞','','','147','0117.png'),(3,'03','邮件','Email','郵件','','','1','0101.png'),(5,'06','日程安排','Schedule','日程安排','','','8','0124.png'),(6,'07','常用功能','Common function','常用功能','','','0','dbgw.png'),(10,'11','会议通知','Meeting notice','會議通知','','','88','3010.png'),(12,'00','今日看板A','Kanban today A','今日看板A','','','00','38.png'),(13,'0b','今日看板B','Kanban today B','今日看板B','','','0b','38.png'),(16,'17','自定义告示栏1','Custom notice board1','自定義告示欄1',' ',' ','62','38.png'),(17,'18','自定义告示栏2','Custom notice board2','自定義告示欄2',' ',' ','0d','38.png'),(18,'19','自定义告示栏3','Custom notice board3','自定義告示欄3',' ',' ','0e','38.png');
/*!40000 ALTER TABLE `info_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `information`
--

DROP TABLE IF EXISTS `information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `information` (
  `ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',
  `DEPT_ID` varchar(11) DEFAULT NULL COMMENT '所属部门',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '填报人',
  `MANAGER_ID` varchar(255) DEFAULT NULL COMMENT '审批人',
  `MANAGER_TYPE` varchar(11) DEFAULT NULL COMMENT '审批方式',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '填报时间',
  `PHONE` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `DELIVERY_DEPT_ID` varchar(255) DEFAULT NULL COMMENT '报送部门',
  `IMAGE` varchar(255) DEFAULT NULL COMMENT '图片',
  `CONTEXT` varchar(255) DEFAULT NULL COMMENT '内容',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '附件ID',
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `PUBLISH` char(1) DEFAULT '0' COMMENT '发布标识(0-未转交,1-已转交)',
  `ISREAD` varchar(10) DEFAULT '0' COMMENT '是否阅读（0否,1是）',
  `ISCOLLECTION` varchar(10) DEFAULT '0' COMMENT '是否采集（0否,1是）',
  `SIGN` varchar(10) DEFAULT '0' COMMENT '是否出现修改字段（0否,1是）',
  `STR2` varchar(255) DEFAULT NULL COMMENT '备用字段2',
  `ATTACHMENT_ID2` varchar(255) DEFAULT NULL COMMENT '图片附件ID',
  `ATTACHMENT_NAME2` varchar(255) DEFAULT NULL COMMENT '图片附件名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `information`
--

LOCK TABLES `information` WRITE;
/*!40000 ALTER TABLE `information` DISABLE KEYS */;
/*!40000 ALTER TABLE `information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_content`
--

DROP TABLE IF EXISTS `institution_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institution_content` (
  `INST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `SORT_ID` int(11) DEFAULT NULL COMMENT '分类ID',
  `INST_TYPE` varchar(10) DEFAULT NULL COMMENT '文档类型(1-HTML,2-FILE)',
  `INST_NO` int(11) DEFAULT NULL COMMENT '制度排序号',
  `INST_NUMBER` varchar(50) DEFAULT NULL COMMENT '制度内控编号',
  `INST_NAME` varchar(255) DEFAULT NULL COMMENT '文档名称',
  `INST_CONTENT` text COMMENT '制度内容',
  `KEY_WORDS` varchar(255) DEFAULT NULL COMMENT '制度关键字',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '制度文件ID',
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '制度文件名称',
  `FILE_NUM` int(11) DEFAULT NULL COMMENT '附件数',
  `INST_STATUS` char(10) DEFAULT NULL COMMENT '使用状态(0-停用,1-正常)',
  `VERSION` varchar(10) DEFAULT NULL COMMENT '当前版本',
  `APPROVE_STATUS` char(10) DEFAULT NULL COMMENT '审批状态(0-待批,1-已准,2-未准，3-未提交)',
  `APPROVAL_USER` varchar(255) DEFAULT NULL COMMENT '审批人',
  `READER_NUM` int(11) DEFAULT '0' COMMENT '制度阅读量',
  `READER_USERS` text COMMENT '制度阅读人员',
  `OWNER_USER` varchar(50) DEFAULT NULL COMMENT '所有者',
  `EDIT_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `EDIT_CONTENT` text COMMENT '编修说明',
  `HTML_URL` varchar(255) DEFAULT NULL COMMENT 'HTMLURL',
  `FLOW_ID` text COMMENT '关联流程',
  `USER_IDS` text COMMENT '我的收藏',
  `VIEW_DEPTS` text COMMENT '制度文件查看部门',
  `VIEW_PRIVS` text COMMENT '制度文件查看角色',
  `VIEW_USERS` text COMMENT '制度文件查看人员',
  `VIEW_USER_TYPE` text COMMENT '制度文档查看人员类别',
  `BELONGTO_DEPTS` varchar(50) DEFAULT NULL COMMENT '所属部门',
  `BELONGTO_UNIT` varchar(50) DEFAULT NULL COMMENT '所属单位',
  `INST_NUMBER_OUT` varchar(50) DEFAULT NULL COMMENT '制度外控编号',
  PRIMARY KEY (`INST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='制度内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_content`
--

LOCK TABLES `institution_content` WRITE;
/*!40000 ALTER TABLE `institution_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_sort`
--

DROP TABLE IF EXISTS `institution_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `institution_sort` (
  `SORT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '分类排序号',
  `SORT_NAME` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `SORT_PARENT` int(11) DEFAULT NULL COMMENT '上级分类ID',
  `SORT_DESC` text COMMENT '分类描述',
  `BELONGTO_DEPTS` text COMMENT '分类所属部门',
  `VIEW_DEPTS` text COMMENT '制度文件查看部门',
  `VIEW_PRIVS` text COMMENT '制度文件查看角色',
  `VIEW_USERS` text COMMENT '制度文件查看人员',
  `VIEW_USER_TYPE` varchar(255) DEFAULT NULL COMMENT '制度文档查看人员类别（对应user_ext表中user_type）',
  `SORT_LEVEL` varchar(10) DEFAULT NULL COMMENT '制度分类级别（sys_code表中code_no)',
  `VIEW_SCOPE` varchar(255) DEFAULT NULL COMMENT '分类可见范围（sys_code表中code_no)',
  PRIMARY KEY (`SORT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='制度管理分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_sort`
--

LOCK TABLES `institution_sort` WRITE;
/*!40000 ALTER TABLE `institution_sort` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integral_manager`
--

DROP TABLE IF EXISTS `integral_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integral_manager` (
  `IMID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `PARTY_BRANCH` varchar(255) DEFAULT NULL COMMENT '活动党组织',
  `PARTY_MEMBER` varchar(255) DEFAULT NULL COMMENT '党员',
  `ACTIVITY_SUBJECT` varchar(255) DEFAULT NULL COMMENT '活动主题',
  `ACTIVITY_CONTENT` text,
  `ATTACHMENT_ID` text COMMENT '照片ID串',
  `ATTACHMENT_NAME` text COMMENT '照片名称串',
  `SCORE_STANDARD` varchar(255) DEFAULT NULL COMMENT '计分标准',
  `SCORE` varchar(255) DEFAULT NULL COMMENT '分数',
  `SCORE_OLD` varchar(255) DEFAULT NULL COMMENT '旧分数',
  `PARTY_BRANCHAUDIT` varchar(255) DEFAULT NULL COMMENT '党支部初审',
  `ASSESSMENT_TEAMAUDIT` varchar(255) DEFAULT NULL COMMENT '考核小组审核',
  `STATUS` varchar(255) DEFAULT NULL COMMENT '状态',
  `STEP_STATUS` varchar(255) DEFAULT NULL COMMENT '步骤状态',
  `COMMIT_USER` varchar(255) DEFAULT NULL COMMENT '提交人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '提交时间',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '接受时间',
  `HANDLE_TIME` datetime DEFAULT NULL COMMENT '办理时间',
  `ATTACHMENT_ID2` text COMMENT '附件ID串',
  `ATTACHMENT_NAME2` text COMMENT '附件名称串',
  `PARTY_ACTIVITE_TYPE` char(10) DEFAULT NULL COMMENT '党员活动类型(SYS_CODE)',
  `ACTIVITE_DATE` datetime DEFAULT NULL COMMENT '活动日期',
  `TEST_URL` varchar(255) DEFAULT NULL COMMENT '答题链接地址(考试试题URL)',
  PRIMARY KEY (`IMID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='活动及活动积分管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integral_manager`
--

LOCK TABLES `integral_manager` WRITE;
/*!40000 ALTER TABLE `integral_manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `integral_manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `IE_TITLE` varchar(200) NOT NULL DEFAULT '' COMMENT 'IE浏览器窗口标题',
  `STATUS_TEXT` text NOT NULL COMMENT '主界面底部状态栏置中文字',
  `BANNER_TEXT` varchar(200) NOT NULL DEFAULT '' COMMENT '主界面顶部大标题文字',
  `BANNER_FONT` varchar(200) NOT NULL DEFAULT '' COMMENT '字体',
  `ATTACHMENT_ID` varchar(200) NOT NULL DEFAULT '' COMMENT '主界面顶部图标ID',
  `ATTACHMENT_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '主界面顶部图标NAME',
  `IMG_WIDTH` int(11) NOT NULL DEFAULT '110' COMMENT '主界面顶部图标宽度',
  `IMG_HEIGHT` int(11) NOT NULL DEFAULT '40' COMMENT '主界面顶部图标高度',
  `ATTACHMENT_ID1` varchar(200) NOT NULL DEFAULT '' COMMENT '登录界面图片ID',
  `ATTACHMENT_NAME1` varchar(200) NOT NULL DEFAULT '' COMMENT '登录界面图片NAME',
  `AVATAR_UPLOAD` char(1) NOT NULL DEFAULT '1' COMMENT '允许用户上传头像(1-允许,0-不允许)',
  `AVATAR_WIDTH` int(11) NOT NULL DEFAULT '20' COMMENT '用户上传头像最大宽度',
  `AVATAR_HEIGHT` int(11) NOT NULL DEFAULT '20' COMMENT '用户上传头像最大高度',
  `LOGIN_INTERFACE` varchar(20) NOT NULL DEFAULT '1' COMMENT '选择界面布局',
  `UI` varchar(200) NOT NULL DEFAULT '0' COMMENT '默认界面布局',
  `THEME_SELECT` varchar(20) NOT NULL DEFAULT '1' COMMENT '是否允许用户选择界面主题(1-允许,0-不允许)',
  `THEME` varchar(200) NOT NULL DEFAULT '1' COMMENT '默认界面主题',
  `TEMPLATE` varchar(200) NOT NULL DEFAULT 'default' COMMENT '登录界面模板',
  `WEATHER_CITY` varchar(50) DEFAULT NULL,
  `SHOW_RSS` char(1) NOT NULL DEFAULT '1' COMMENT '允许用户使用今日资讯',
  `NOTIFY_TEXT` text NOT NULL COMMENT '紧急通知内容',
  `IMG_TOS` tinyint(1) NOT NULL DEFAULT '0' COMMENT '在设置顶部图标时增加是否应用到tos',
  `ATTACHMENT_ID2` varchar(255) DEFAULT NULL,
  `ATTACHMENT_NAME2` varchar(255) DEFAULT NULL,
  `LOGIN_LITERALS` varchar(255) DEFAULT NULL,
  `LOGIN_VALIDATION` varchar(255) NOT NULL COMMENT '0演示环境1标准2教育3网格',
  `ATTACHMENT_ID3` text COMMENT 'app界面附件',
  `ATTACHMENT_NAME3` text COMMENT 'app界面附件',
  `ATTACHMENT_ID4` text COMMENT 'apps首页附件',
  `ATTACHMENT_NAME4` text COMMENT 'apps首页附件',
  `MOBILE_WATERMARK` char(10) DEFAULT '1' COMMENT '是否开启或关闭移动端水印(1:开启  0:关闭)',
  `BLACK_THEME` char(10) DEFAULT '0' COMMENT '黑色主题（0-关，1-开）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='界面设置信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES ('Synthda','Synthda OA Network Intelligent Office System\r\n\r\nHeart to Heart Mission Achievement','','','','',110,40,'','','1',110,110,'0','','1','20','16','0','','',0,'','','Synthda','1','','','','','1','0');
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inv_warehouse`
--

DROP TABLE IF EXISTS `inv_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inv_warehouse` (
  `WAREHOUSE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库主键ID',
  `WAREHOUSE_NO` varchar(50) DEFAULT NULL COMMENT '仓库编号',
  `WAREHOUSE_PERSON` varchar(100) DEFAULT NULL COMMENT '仓库负责人',
  `WAREHOUSE_NAME` varchar(100) DEFAULT NULL COMMENT '仓库名称',
  `WAREHOUSE_PHONE` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `WAREHOUSE_ADRESS` varchar(200) DEFAULT NULL COMMENT '仓库地址',
  `WAREHOUSE_DEFAULT` char(10) DEFAULT NULL COMMENT '是否为默认仓库（1：是；0：否）',
  `WAREHOUSE_REMARKS` varchar(255) DEFAULT NULL COMMENT '备注',
  `PROVINCE` varchar(100) DEFAULT NULL COMMENT '省',
  `CITY` varchar(100) DEFAULT NULL COMMENT '市',
  `WAREHOUSE_LONG` varchar(50) DEFAULT NULL COMMENT '仓库地址经度',
  `WAREHOUSE_LAT` varchar(50) DEFAULT NULL COMMENT '仓库地址纬度',
  PRIMARY KEY (`WAREHOUSE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='仓库表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inv_warehouse`
--

LOCK TABLES `inv_warehouse` WRITE;
/*!40000 ALTER TABLE `inv_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `inv_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_rule`
--

DROP TABLE IF EXISTS `ip_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_rule` (
  `RULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `BEGIN_IP` varchar(20) NOT NULL DEFAULT '' COMMENT '开始IP',
  `END_IP` varchar(20) NOT NULL DEFAULT '' COMMENT '结束IP',
  `TYPE` varchar(10) NOT NULL DEFAULT '0' COMMENT '规则类型(0-OA允许登录,1-考勤限制,2-OA禁止登录)',
  `REMARK` text NOT NULL COMMENT '备注',
  PRIMARY KEY (`RULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='登录IP限制规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_rule`
--

LOCK TABLES `ip_rule` WRITE;
/*!40000 ALTER TABLE `ip_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kg_relation_keysign`
--

DROP TABLE IF EXISTS `kg_relation_keysign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kg_relation_keysign` (
  `RELATION_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `KEY_ID` int(11) DEFAULT NULL,
  `SIGN_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RELATION_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kg_relation_keysign`
--

LOCK TABLES `kg_relation_keysign` WRITE;
/*!40000 ALTER TABLE `kg_relation_keysign` DISABLE KEYS */;
INSERT INTO `kg_relation_keysign` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,5),(5,2,4);
/*!40000 ALTER TABLE `kg_relation_keysign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kg_relation_keyuser`
--

DROP TABLE IF EXISTS `kg_relation_keyuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kg_relation_keyuser` (
  `KEY_USER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL COMMENT '用户UID',
  `KEY_ID` int(11) DEFAULT NULL COMMENT 'keyId',
  PRIMARY KEY (`KEY_USER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kg_relation_keyuser`
--

LOCK TABLES `kg_relation_keyuser` WRITE;
/*!40000 ALTER TABLE `kg_relation_keyuser` DISABLE KEYS */;
INSERT INTO `kg_relation_keyuser` VALUES (1,1,1),(2,1,2);
/*!40000 ALTER TABLE `kg_relation_keyuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kg_signature`
--

DROP TABLE IF EXISTS `kg_signature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kg_signature` (
  `SIGNATURE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `SIGNATURE_NAME` varchar(255) DEFAULT NULL COMMENT '签章名称',
  `SIGNATURE_UNIT` varchar(255) DEFAULT NULL COMMENT '单位名称',
  `SIGNATURE_KGID` varchar(255) DEFAULT NULL COMMENT '金格签章id',
  `SIGNATURE_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常，1禁制使用，-1删除',
  PRIMARY KEY (`SIGNATURE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kg_signature`
--

LOCK TABLES `kg_signature` WRITE;
/*!40000 ALTER TABLE `kg_signature` DISABLE KEYS */;
INSERT INTO `kg_signature` VALUES (1,'金格演示公章','北京高速波科技有限公司','BCxhL9mkEgv2dFTcpQHz8uUtNiqIXG35+rYJj1lfeb/KO4=yaWV0DSAPnw67oZsRM',-1),(2,'金格演示合同章','北京高速波科技有限公司','M=dUfvWPYlTLAOt70V9p1x5nRFm2aizZc3b/w+8SGhXj6JEoIQyNHCkrsguDeqB4K',0),(3,'金格科技私章1X2.24','北京高速波科技有限公司','0myIz5atpgOPbM8wYqiLWnAuBJXDrSjE9U376VFkT=KxeRhf+vosNC1Gc4/HdZQl2',0),(4,'金格演示发票专用章','北京高速波科技有限公司','0wAeTICLvyhqi1KJkOgsarYNQ5BUGEmSV8Z23P94lfno=M6pjFDdxuz+/cX7bHWRt',0),(5,'金格演示合同章1','北京高速波科技有限公司','8x2=rAUbHvF3/4dQDaptogRz70mfMI6LNCsnKV9SqYiPWXZE1euhyTkj+JOwlGB5c',0),(6,'心通达演示公章','北京高速波科技有限公司','3KLmcTy0VR5FjgoAWeb7YBO24C1JsU8iqfzrQ9dNanu=MG/Sxk6ZwhtDEHXvlP+Ip',0),(7,'心通达演示发票专用章','北京高速波科技有限公司','PFxBSYkjo80hi4H15=mfzdM97bX6GK3URc/+ENOnDAqQIvsTtaJZLwuyeglrWCVp2',0),(8,'心通达演示合同章','北京高速波科技有限公司','xytDQgAwfJ23=GvXWd1jShRl7BEeMib0+No/4UK9aT8CpcHm6VsOkqIuP5nLFYrzZ',0);
/*!40000 ALTER TABLE `kg_signature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kg_signkey`
--

DROP TABLE IF EXISTS `kg_signkey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kg_signkey` (
  `SIGNKEY_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `SIGNKEY_NAME` varchar(255) DEFAULT NULL COMMENT '名称',
  `SIGNKEY_KEYSN` varchar(255) DEFAULT NULL COMMENT '金格签章keysn',
  `SIGNKEY_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常 -1 停止使用',
  PRIMARY KEY (`SIGNKEY_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kg_signkey`
--

LOCK TABLES `kg_signkey` WRITE;
/*!40000 ALTER TABLE `kg_signkey` DISABLE KEYS */;
INSERT INTO `kg_signkey` VALUES (1,'测试盘1','C84CF78C359E757E',0),(2,'测试盘2','44871127553E5D00',0);
/*!40000 ALTER TABLE `kg_signkey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning_experience`
--

DROP TABLE IF EXISTS `learning_experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `learning_experience` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 自增id',
  `USER_ID` varchar(11) NOT NULL COMMENT '单位员工',
  `PROFESSION` varchar(255) DEFAULT NULL COMMENT '所学专业',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `REGISTER_TIME` datetime DEFAULT NULL COMMENT '登记时间',
  `LASTMODIFY_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `ACADEMIC` varchar(255) DEFAULT NULL COMMENT '学历',
  `DEGREE` varchar(255) DEFAULT NULL COMMENT '学位',
  `CLASSCADRE` varchar(255) DEFAULT NULL COMMENT '曾任班干',
  `CERTIFIER` varchar(255) DEFAULT NULL COMMENT '证明人',
  `UNIVERSITY` text COMMENT '所在院校',
  `UNIVERSITY_LOCATION` text COMMENT '院校所在地',
  `HONOR` mediumtext COMMENT '获奖情况',
  `CERTIFICATE` mediumtext COMMENT '所获证书',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `ATTACHMENT_ID` mediumtext,
  `ATTACHMENT_NAME` mediumtext COMMENT '附件名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='人员的学习经历';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning_experience`
--

LOCK TABLES `learning_experience` WRITE;
/*!40000 ALTER TABLE `learning_experience` DISABLE KEYS */;
/*!40000 ALTER TABLE `learning_experience` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_app`
--

DROP TABLE IF EXISTS `login_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_app` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `APP_UNIT` varchar(255) NOT NULL DEFAULT '' COMMENT '申请单位',
  `APP_USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '申请人USER_ID',
  `APP_TIME` varchar(50) NOT NULL DEFAULT '' COMMENT '申请时间',
  `APP_USERS` text NOT NULL COMMENT '申请用户USER_ID串',
  `APP_USERS_NAME` text NOT NULL COMMENT '申请用户姓名串',
  `STATE` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '审批状态',
  `AUDIT_TIME` varchar(50) NOT NULL DEFAULT '' COMMENT '审批时间',
  `AUDITED_USERS` text NOT NULL COMMENT '审批人员',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='互联互通单点登录应用表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_app`
--

LOCK TABLES `login_app` WRITE;
/*!40000 ALTER TABLE `login_app` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meal_manage`
--

DROP TABLE IF EXISTS `meal_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meal_manage` (
  `MEAL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '申请人',
  `DEPT_ID` int(11) DEFAULT NULL COMMENT '部门ID',
  `BREAKFAST_NUM` int(11) DEFAULT NULL COMMENT '早餐',
  `LUNCH_NUM` int(11) DEFAULT NULL COMMENT '中餐',
  `COLLEGE` char(10) DEFAULT NULL COMMENT '院办（0-待审批，1-通过，2-不通过）',
  `MEAL_TYPE` varchar(10) DEFAULT NULL COMMENT '用餐类型（1-访客，2-教职工）',
  `PREDESTINE_TIME` datetime DEFAULT NULL COMMENT '预定时间',
  `DINNER_NUM` int(11) DEFAULT NULL COMMENT '晚餐',
  PRIMARY KEY (`MEAL_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用餐管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meal_manage`
--

LOCK TABLES `meal_manage` WRITE;
/*!40000 ALTER TABLE `meal_manage` DISABLE KEYS */;
/*!40000 ALTER TABLE `meal_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键（会议ID）',
  `ATTENDEE` longtext COLLATE utf8_bin COMMENT '出席人员（内部）',
  `ATTENDEE_NOT` longtext COLLATE utf8_bin,
  `ATTENDEE_OUT` longtext COLLATE utf8_bin COMMENT '出席人员（外部）',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '会议结束时间',
  `IS_WRITE_CALEDNAR` int(11) DEFAULT '0' COMMENT '是否写入日程',
  `MEET_DESC` text CHARACTER SET utf8 COMMENT '会议描述',
  `MEET_NAME` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '会议名称',
  `READ_PEOPLE_ID` longtext COLLATE utf8_bin COMMENT '会议纪要读者',
  `RESEND_HOUR` int(11) NOT NULL COMMENT '提醒设置：提前几个小时提醒',
  `RESEND_MINUTE` int(11) NOT NULL DEFAULT '0' COMMENT '提前分钟小时提醒',
  `RESEND_SEVERAL` int(11) NOT NULL DEFAULT '0' COMMENT '提醒设置：提醒几次',
  `SMS2_REMIND` char(20) COLLATE utf8_bin DEFAULT NULL COMMENT '手机短信提醒出席人员,0：不提醒，1：提醒',
  `SMS_REMIND` char(20) COLLATE utf8_bin DEFAULT NULL COMMENT '是否内部短信通知出席人员，使用内部短信提醒，选中为1，不选中为0',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '会议状态 1-待批 2-已批准 3-进行中 4-未批准 5-已结束',
  `SUBJECT` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '会议主题',
  `SUMMARY` longtext COLLATE utf8_bin COMMENT '会议纪要内容',
  `MANAGER_ID` int(11) DEFAULT NULL COMMENT '审批管理员',
  `MEET_ROOM_ID` int(11) DEFAULT NULL COMMENT '会议室id',
  `UID` int(11) DEFAULT NULL COMMENT '申请人',
  `EQUIPMENTS` longtext COLLATE utf8_bin COMMENT '会议设备',
  `RECORDER_ID` int(11) DEFAULT NULL COMMENT '会议纪要员',
  `ATTENDEE_NOT_IDS` longtext COLLATE utf8_bin,
  `ATTENDEE_NOT_NAMES` longtext COLLATE utf8_bin,
  `EQUIPMENT_IDS` longtext COLLATE utf8_bin COMMENT '会议设备id',
  `EQUIPMENT_NAMES` longtext COLLATE utf8_bin COMMENT '会议设备名称',
  `ISUPLOADSUMMARY` varchar(20) COLLATE utf8_bin DEFAULT '' COMMENT '会议纪要状态',
  `ATTACHMENT_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会议附件Id',
  `ATTACHMENT_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会议纪要附件名字',
  `SUMMARY_ATTACHMENT_ID` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会议纪要附件ID',
  `SUMMARY_ATTACHMENT_NAME` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '会议纪要附件名字',
  `SECRET_TO_ID` text COLLATE utf8_bin COMMENT '查看人员',
  `PRIV_ID` text COLLATE utf8_bin COMMENT '查看角色',
  `TO_ID` text COLLATE utf8_bin COMMENT '查看部门',
  `CYCLE` char(1) COLLATE utf8_bin DEFAULT '' COMMENT '周期性会议标记',
  `CYCLE_NO` int(11) DEFAULT '0' COMMENT '周期性会议ID',
  `M_FACT_ATTENDEE` text COLLATE utf8_bin COMMENT '实际参会人员',
  `REASON` text COLLATE utf8_bin COMMENT '不批准原因',
  `APPROVE_NAME` varchar(10) COLLATE utf8_bin DEFAULT '' COMMENT '审批人',
  `SEND_NAME` varchar(10) COLLATE utf8_bin DEFAULT '' COMMENT '发送人',
  `TO_SCOPE` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否提醒查看范围',
  `TO_EMAIL` char(1) COLLATE utf8_bin DEFAULT '1' COMMENT '是否发送电子邮件提醒',
  `M_PROPOSER` varchar(10) COLLATE utf8_bin DEFAULT '' COMMENT '通达会议表中的申请人字段，用来进行通达数据升级后同步uid',
  `M_MANAGER` varchar(20) COLLATE utf8_bin DEFAULT '' COMMENT '通达会议表中的管理员字段，用来进行通达数据升级后同步uid',
  `MOBILE_NO` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '联系电话',
  `VIDEO_CONF_ID` char(100) COLLATE utf8_bin DEFAULT NULL COMMENT '服务端视频会议室Id',
  `VIDEO_CONF_FLAG` char(10) COLLATE utf8_bin DEFAULT NULL COMMENT '是否是视频会议(0否,1是)',
  `MEET_CODE` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '参会验证码',
  `SERVICE_USER` text COLLATE utf8_bin COMMENT '会议服务人员',
  `PHOTO_ID` text COLLATE utf8_bin COMMENT '会议照片ID串',
  `PHOTO_NAME` text COLLATE utf8_bin COMMENT '会议照片名称串',
  `VIDEO_ID` text COLLATE utf8_bin COMMENT '会议录像ID串',
  `AGENDA_ID` text COLLATE utf8_bin COMMENT '会议议程ID串',
  `AGENDA_NAME` text COLLATE utf8_bin COMMENT '会议议程名称串',
  `CREATE_QRCODE_TIME` datetime DEFAULT NULL COMMENT '生成二维码时间',
  `SIGN_IN_TIME` datetime DEFAULT NULL COMMENT '会议签到时间',
  `HANDWRITING_SIGN_YN` char(10) COLLATE utf8_bin DEFAULT '0' COMMENT '是否开启手写签到(0-不开启、1-开启)',
  PRIMARY KEY (`SID`) USING BTREE,
  KEY `IDX30f3297a40ec47d2a8f814c880e` (`UID`) USING BTREE,
  KEY `IDX36350ed0d1734c939ba6d689cd7` (`MANAGER_ID`) USING BTREE,
  KEY `IDXd2b2ee25d8c34823bb4f451615c` (`MEET_ROOM_ID`) USING BTREE,
  KEY `IDX36350ed0d1734c939ba6d6wocao` (`RECORDER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT COMMENT='会议详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_attend_confirm`
--

DROP TABLE IF EXISTS `meeting_attend_confirm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_attend_confirm` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `ATTEND_FLAG` int(11) DEFAULT '0' COMMENT '参会状态：0-待确认，1-参会，2-参会迟到，3-请假，4-缺勤',
  `CONFIRM_TIME` datetime DEFAULT NULL COMMENT '确认参会时间',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MEETING_ID` int(11) DEFAULT '0' COMMENT '会议ID',
  `READ_FLAG` int(11) DEFAULT '0' COMMENT '签阅状态：0-未阅读，1-已阅',
  `READING_TIME` datetime DEFAULT NULL COMMENT '签阅时间',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `CREATE_USER` int(11) DEFAULT NULL COMMENT '创建人',
  `ATTENDEE_ID` int(11) DEFAULT NULL COMMENT '出席人员id',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '签到地址',
  `SIGN_ID` text COMMENT '个人签字照片ID串',
  `SIGN_NAME` text COMMENT '个人签字照片名称串',
  `MEETING_NOTES` text COMMENT '会议笔记',
  PRIMARY KEY (`SID`) USING BTREE,
  KEY `IDX_MEETING_CONFIRM_CR_USER` (`CREATE_USER`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会议参会及查阅情况';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_attend_confirm`
--

LOCK TABLES `meeting_attend_confirm` WRITE;
/*!40000 ALTER TABLE `meeting_attend_confirm` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_attend_confirm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_comment`
--

DROP TABLE IF EXISTS `meeting_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PARENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上一次评论ID',
  `MEETING_ID` int(11) NOT NULL DEFAULT '0' COMMENT '会议ID',
  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '评论人',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `CONTENT` text NOT NULL COMMENT '评论内容',
  `RE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发表时间',
  PRIMARY KEY (`COMMENT_ID`) USING BTREE,
  KEY `PARENT_ID` (`PARENT_ID`) USING BTREE,
  KEY `NEWS_ID` (`MEETING_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `RE_TIME` (`RE_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会议纪要评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_comment`
--

LOCK TABLES `meeting_comment` WRITE;
/*!40000 ALTER TABLE `meeting_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_equuipment`
--

DROP TABLE IF EXISTS `meeting_equuipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_equuipment` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动自增Id',
  `EQUIPMENT_NAME` varchar(200) DEFAULT NULL COMMENT '会议设备名称',
  `EQUIPMENT_NO` varchar(200) DEFAULT NULL COMMENT '会议设备编码',
  `GROUP_NO` varchar(200) DEFAULT NULL COMMENT '同类设备名称',
  `REMARK` longtext COMMENT '备注',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '设备状态  0-正常 1-不可用',
  `MEETING_ROOM_ID` int(11) DEFAULT NULL COMMENT '会议室ID',
  `GROUP_YN` int(1) DEFAULT '0' COMMENT '同类设备(0-没有,1-有)',
  PRIMARY KEY (`SID`) USING BTREE,
  KEY `IDXaa14d6d7705c4cc5b7a8227401e` (`MEETING_ROOM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会议设备';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_equuipment`
--

LOCK TABLES `meeting_equuipment` WRITE;
/*!40000 ALTER TABLE `meeting_equuipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_equuipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_room`
--

DROP TABLE IF EXISTS `meeting_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_room` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动递增Id',
  `managerIds` varchar(255) DEFAULT NULL COMMENT '会议室管理员ID串',
  `MR_CAPACITY` varchar(255) DEFAULT NULL COMMENT '会议室容纳人数',
  `MR_DEVICE` longtext COMMENT '设备情况',
  `MR_NAME` varchar(255) DEFAULT NULL COMMENT '会议室名称',
  `MR_PLACE` varchar(255) DEFAULT NULL COMMENT '会议室地址',
  `MR_DESC` longtext COMMENT '会议室描述',
  `MEETING_EQUIP` longtext,
  `EQUIPMENT_IDS` varchar(255) DEFAULT NULL COMMENT '会议设备ID字符串',
  `EQUIPMENT_NAMES` varchar(255) DEFAULT NULL COMMENT '会议室设备名称',
  `MEET_ROOM_PERSON` text COMMENT '会议室申请人员名字',
  `MEET_ROOM_DEPT` text COMMENT '会议室申请部门',
  `APPLY_WEEKDAYS` varchar(30) DEFAULT '1,2,3,4,5' COMMENT '允许申请的星期设置',
  `OPERATOR` text COMMENT '通达会议室表中的管理员字段，用来进行通达数据升级后同步uid',
  `SECRET_TO_ID` text COMMENT '通达会议室表中的申请人员字段，用来进行通达数据升级后同步uid',
  `ROOM_CODE` varchar(255) DEFAULT NULL COMMENT '会议编码（第三方对接）',
  `ROOM_ADDRESS` varchar(255) DEFAULT NULL COMMENT '会议地址（第三方对接）',
  `ORDER_NO` int(11) DEFAULT NULL COMMENT '排序号',
  `IS_APPROVE` char(10) NOT NULL DEFAULT '2' COMMENT '审批设置 1不需要审批，2需要审批，3超过三小时需要审批',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='会议室';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_room`
--

LOCK TABLES `meeting_room` WRITE;
/*!40000 ALTER TABLE `meeting_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_rule`
--

DROP TABLE IF EXISTS `meeting_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_rule` (
  `RULE_ID` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `MEETING_OPERATOR` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '会议管理员',
  `MEETING_ROOM_RULE` mediumtext CHARACTER SET utf8 NOT NULL COMMENT '会议室管理制度',
  `MEETING_IS_APPROVE` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否需要审核(0-不需要,1-需要)',
  `ATTACHMENT_ID` text CHARACTER SET utf8 NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text CHARACTER SET utf8 NOT NULL COMMENT '附件名称串',
  PRIMARY KEY (`RULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='会议管理制度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_rule`
--

LOCK TABLES `meeting_rule` WRITE;
/*!40000 ALTER TABLE `meeting_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_app`
--

DROP TABLE IF EXISTS `mobile_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_app` (
  `APP_ID` int(3) NOT NULL AUTO_INCREMENT COMMENT '桌面应用的ID',
  `APP_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '应用的名称',
  `APP_TYPE` enum('system','custom','vip') NOT NULL COMMENT '应用的类型 system是系统内置不允许改变，vip组件为需要购买，custom是用户可以自己定制的',
  `APP_MODULE` varchar(100) NOT NULL DEFAULT '' COMMENT '应用所代表的模块',
  `APP_ICON` varchar(200) NOT NULL DEFAULT '' COMMENT '应用的图标',
  `APP_URL` varchar(200) NOT NULL DEFAULT '' COMMENT '如果应用是打开连接地址的，则不为空',
  `APP_DESC` varchar(1000) NOT NULL DEFAULT '' COMMENT '应用的描述',
  `APP_PRIV` text NOT NULL COMMENT '应用权限',
  PRIMARY KEY (`APP_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='移动考勤表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_app`
--

LOCK TABLES `mobile_app` WRITE;
/*!40000 ALTER TABLE `mobile_app` DISABLE KEYS */;
INSERT INTO `mobile_app` VALUES (1,'电子邮件','system','email','email.png','email','','ALL_DEPT||'),(4,'公告通知','system','notify/show','notify.png','notify/show','','ALL_DEPT||'),(5,'我的工作','system','workflow/list','user_info.png','workflow/list','','ALL_DEPT||'),(8,'日程安排','system','calendar','calendar.png','calendar','','ALL_DEPT||'),(9,'工作日志','system','diary/show','diary.png','diary/show','','ALL_DEPT||'),(15,'公共文件柜','system','knowledge_management','public_folder.png','knowledge_management','','ALL_DEPT||'),(16,'个人文件柜','system','file_folder/index2.php','file_folder.png','file_folder/index2.php','','ALL_DEPT||'),(17,'单位信息查询','system','info/unit','user_info.png','info/unit','','ALL_DEPT||'),(18,'部门信息查询','vip','info/dept','attend_mobile.png','info/dept','','ALL_DEPT||'),(19,'用户信息查询','vip','info/user','attend_mobile.png','info/user','','ALL_DEPT||'),(38,'系统信息','system','system/reg_view','workflow.png','system/reg_view','','ALL_DEPT||'),(76,'网络硬盘','system','netdisk','user_info.png','netdisk','','ALL_DEPT||'),(130,'新建工作','vip','workflow/new','attend_mobile.png','workflow/new','','ALL_DEPT||'),(147,'新闻','system','news/show','news.png','news/show','','ALL_DEPT||'),(701,'我的公文','system','document/mine','user_info.png','document/mine','','ALL_DEPT||');
/*!40000 ALTER TABLE `mobile_app` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_verify`
--

DROP TABLE IF EXISTS `mobile_verify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_verify` (
  `VERIFY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `USER_ID` varchar(50) DEFAULT '' COMMENT 'OA用户ID',
  `MOBIL_NO` varchar(50) DEFAULT '' COMMENT '手机号',
  `VERIFY_CODE` varchar(50) DEFAULT '' COMMENT '验证码',
  `CODE_TIME` datetime DEFAULT NULL COMMENT '验证码生成时间',
  PRIMARY KEY (`VERIFY_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='手机号获取验证码记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_verify`
--

LOCK TABLES `mobile_verify` WRITE;
/*!40000 ALTER TABLE `mobile_verify` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_verify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobile_workflow_style`
--

DROP TABLE IF EXISTS `mobile_workflow_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_workflow_style` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FORM_ID` int(11) NOT NULL COMMENT '表单ID',
  `STYLE` text NOT NULL COMMENT '样式内容',
  `TYPE` char(10) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobile_workflow_style`
--

LOCK TABLES `mobile_workflow_style` WRITE;
/*!40000 ALTER TABLE `mobile_workflow_style` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobile_workflow_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_manage`
--

DROP TABLE IF EXISTS `module_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_manage` (
  `m_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '模块类型（1-email, 2-diary, 3-notify, 4-knowledge, 5-hr, 6-workflow）',
  `manage_content` varchar(50) NOT NULL DEFAULT '' COMMENT '管理权限内容（备用）',
  `manage_user_id` varchar(200) NOT NULL DEFAULT '' COMMENT '管理员用户名串',
  `manage_dept_id` varchar(200) NOT NULL DEFAULT '' COMMENT '管理员部门id串',
  `manage_priv_id` varchar(200) NOT NULL DEFAULT '' COMMENT '管理员角色id串',
  PRIMARY KEY (`m_id`) USING BTREE,
  KEY `module_type` (`module_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='功能管理中心';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_manage`
--

LOCK TABLES `module_manage` WRITE;
/*!40000 ALTER TABLE `module_manage` DISABLE KEYS */;
INSERT INTO `module_manage` VALUES (1,0,'33','','',''),(2,0,'44','','',''),(3,0,'55','','',''),(4,0,'66','','','');
/*!40000 ALTER TABLE `module_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module_priv`
--

DROP TABLE IF EXISTS `module_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module_priv` (
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '用户UID',
  `MODULE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '模块ID',
  `DEPT_PRIV` char(1) NOT NULL DEFAULT '' COMMENT '部门权限范围',
  `ROLE_PRIV` char(1) NOT NULL DEFAULT '' COMMENT '角色权限范围',
  `DEPT_ID` text NOT NULL COMMENT '部门ID串',
  `PRIV_ID` text NOT NULL COMMENT '角色ID串',
  `USER_ID` text NOT NULL COMMENT '人员USER_ID串',
  KEY `UID_MODULE` (`UID`,`MODULE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户管理按模块权限设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module_priv`
--

LOCK TABLES `module_priv` WRITE;
/*!40000 ALTER TABLE `module_priv` DISABLE KEYS */;
INSERT INTO `module_priv` VALUES (23,0,'1','2','','1,',''),(106,0,'1','2','','','');
/*!40000 ALTER TABLE `module_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mytable`
--

DROP TABLE IF EXISTS `mytable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mytable` (
  `MODULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `MODULE_NO` int(11) NOT NULL DEFAULT '0' COMMENT '模块序号',
  `MODULE_NAME` varchar(600) NOT NULL COMMENT '模块名称',
  `MODULE_FILE` varchar(200) NOT NULL DEFAULT '' COMMENT '文件',
  `MODULE_POS` char(1) NOT NULL DEFAULT '' COMMENT '默认位置',
  `VIEW_TYPE` varchar(20) NOT NULL DEFAULT '1' COMMENT '显示属性(1-用户可选,2-用户必选,3-暂停显示)',
  `MODULE_LINES` tinyint(4) NOT NULL DEFAULT '5' COMMENT '显示行数',
  `MODULE_SCROLL` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许滚动显示',
  `MODULE_BORDER_COLOR` tinyint(3) NOT NULL COMMENT '标题栏颜色',
  PRIMARY KEY (`MODULE_ID`) USING BTREE,
  KEY `MODULE_NO` (`MODULE_NO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='桌面模块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mytable`
--

LOCK TABLES `mytable` WRITE;
/*!40000 ALTER TABLE `mytable` DISABLE KEYS */;
INSERT INTO `mytable` VALUES (1,1,'a:1:{s:5:\"zh-CN\";s:8:\"公告通知\";}','公告通知.php','l','2',5,'0',0),(2,2,'a:1:{s:5:\"zh-CN\";s:4:\"新闻\";}','新闻.php','l','1',5,'0',0),(3,3,'a:1:{s:5:\"zh-CN\";s:8:\"待办事宜\";}','待办事宜.php','l','2',5,'0',0),(5,6,'a:1:{s:5:\"zh-CN\";s:8:\"生日提醒\";}','生日提醒.php','r','1',5,'0',0),(6,2,'a:1:{s:5:\"zh-CN\";s:8:\"内部邮件\";}','内部邮件.php','r','1',5,'0',0),(7,4,'a:1:{s:5:\"zh-CN\";s:8:\"常用网址\";}','常用网址.php','r','1',5,'0',0),(8,8,'a:1:{s:5:\"zh-CN\";s:14:\"在线时长排行榜\";}','在线时长排行榜.php','l','1',5,'0',0),(9,9,'a:1:{s:5:\"zh-CN\";s:4:\"投票\";}','投票.php','r','1',5,'0',0),(10,9,'a:1:{s:5:\"zh-CN\";s:14:\"外出人员公告牌\";}','外出人员公告牌.php','l','1',5,'0',0),(11,10,'a:1:{s:5:\"zh-CN\";s:10:\"菜单快捷组\";}','菜单快捷组.php','r','1',5,'0',0),(13,5,'a:1:{s:5:\"zh-CN\";s:8:\"今日计划\";}','今日计划.php','l','1',5,'0',0),(14,7,'a:1:{s:5:\"zh-CN\";s:14:\"公共通讯簿查询\";}','公共通讯簿查询.php','r','1',5,'0',0),(15,6,'a:1:{s:5:\"zh-CN\";s:10:\"内部讨论区\";}','内部讨论区.php','l','1',5,'0',0),(16,8,'a:1:{s:5:\"zh-CN\";s:8:\"员工查询\";}','员工查询.php','r','1',5,'0',0),(17,7,'a:1:{s:5:\"zh-CN\";s:8:\"网络硬盘\";}','网络硬盘.php','l','1',5,'0',0),(19,5,'a:1:{s:5:\"zh-CN\";s:6:\"文件柜\";}','文件柜.php','r','1',5,'0',0),(24,99,'a:1:{s:5:\"zh-CN\";s:8:\"广播电台\";}','广播电台.php','r','3',5,'0',0),(26,12,'a:1:{s:5:\"zh-CN\";s:8:\"最新图书\";}','最新图书.php','l','1',5,'0',0),(27,99,'a:1:{s:5:\"zh-CN\";s:10:\"Discuz论坛\";}','Discuz论坛.php','l','3',5,'0',0),(28,11,'a:1:{s:5:\"zh-CN\";s:8:\"倒计时牌\";}','倒计时牌.php','r','1',5,'0',0),(29,99,'a:1:{s:5:\"zh-CN\";s:8:\"在线翻译\";}','在线翻译.php','l','3',5,'0',0),(30,99,'a:1:{s:5:\"zh-CN\";s:14:\"工作流超时警示\";}','工作流超时警示.php','r','1',5,'0',0),(35,99,'a:1:{s:5:\"zh-CN\";s:8:\"紧急通知\";}','紧急通知.php','l','3',5,'0',0),(36,99,'a:1:{s:5:\"zh-CN\";s:8:\"考试信息\";}','考试信息.php','r','3',5,'0',0),(38,99,'a:1:{s:5:\"zh-CN\";s:6:\"OA知道\";}','OA知道.php','l','1',5,'0',0),(39,99,'a:1:{s:5:\"zh-CN\";s:8:\"外汇牌价\";}','外汇牌价.php','r','3',5,'0',0),(40,99,'a:1:{s:5:\"zh-CN\";s:8:\"工作日志\";}','工作日志.php','l','1',5,'0',0),(43,99,'a:1:{s:5:\"zh-CN\";s:8:\"我的项目\";}','我的项目.php','r','1',5,'0',0),(44,99,'a:1:{s:5:\"zh-CN\";s:8:\"报表提示\";}','报表提示.php','l','3',5,'0',0),(46,99,'a:1:{s:5:\"zh-CN\";s:8:\"网络传真\";}','网络传真.php','l','3',5,'0',0),(55,3,'a:1:{s:5:\"zh-CN\";s:6:\"工作流\";}','工作流.php','l','2',5,'0',0),(56,99,'a:1:{s:5:\"zh-CN\";s:8:\"我的会议\";}','我的会议.php','r','1',5,'0',0),(57,99,'a:1:{s:5:\"zh-CN\";s:8:\"日程安排\";}','日程安排.php','l','1',5,'0',0),(58,99,'a:1:{s:5:\"zh-CN\";s:15:\"积分排行榜\";}','积分排行榜.php','l','3',5,'0',0),(59,99,'a:1:{s:5:\"zh-CN\";s:9:\"计时牌\";}','计时牌.php','r','3',5,'0',0),(60,99,'a:1:{s:5:\"zh-CN\";s:9:\"文件夹\";}','文件夹.php','l','3',5,'0',0),(61,99,'a:1:{s:5:\"zh-CN\";s:12:\"最新词条\";}','最新词条.php','r','3',5,'0',0),(62,99,'a:1:{s:5:\"zh-CN\";s:12:\"图片新闻\";}','图片新闻.php','l','3',5,'0',0),(63,99,'a:1:{s:5:\"zh-CN\";s:18:\"值班排班安排\";}','值班排班安排.php','r','3',5,'0',0),(64,99,'a:1:{s:5:\"zh-CN\";s:16:\"windows快捷组\";}','windows快捷组.php','l','3',5,'0',0),(65,99,'a:1:{s:5:\"zh-CN\";s:12:\"视频播放\";}','视频播放.php','r','3',5,'0',0),(66,99,'a:1:{s:5:\"zh-CN\";s:17:\"Discuz!X1.5论坛\";}','Discuz!X1.5论坛.php','l','3',5,'0',0);
/*!40000 ALTER TABLE `mytable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netchat`
--

DROP TABLE IF EXISTS `netchat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netchat` (
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户USER_ID',
  `IP` varchar(15) NOT NULL DEFAULT '' COMMENT '用户IP地址',
  `LAST_VISIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后访问时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Netmeeting互动会议';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netchat`
--

LOCK TABLES `netchat` WRITE;
/*!40000 ALTER TABLE `netchat` DISABLE KEYS */;
/*!40000 ALTER TABLE `netchat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netdisk`
--

DROP TABLE IF EXISTS `netdisk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netdisk` (
  `DISK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `DISK_NAME` text NOT NULL COMMENT '网络硬盘名称',
  `DISK_PATH` text NOT NULL COMMENT '目录路径',
  `NEW_USER` text NOT NULL COMMENT '新建权限',
  `MANAGE_USER` text NOT NULL COMMENT '管理权限',
  `USER_ID` text NOT NULL COMMENT '访问权限',
  `DISK_NO` int(11) NOT NULL DEFAULT '0' COMMENT '网络硬盘排序号',
  `SPACE_LIMIT` int(11) NOT NULL DEFAULT '0' COMMENT '最大容量',
  `ORDER_BY` varchar(20) NOT NULL DEFAULT '' COMMENT '默认排序字段',
  `ASC_DESC` varchar(20) NOT NULL DEFAULT '' COMMENT '默认升序降序',
  `DOWN_USER` text NOT NULL COMMENT '下载打印权限',
  `REMARK` text NOT NULL COMMENT '备注',
  `EDIT_USER` text COMMENT '编辑权限',
  `BRANCH_DEPT_ID` int(11) DEFAULT NULL COMMENT '分支机构ID',
  PRIMARY KEY (`DISK_ID`) USING BTREE,
  KEY `DISK_NO` (`DISK_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='网络硬盘表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netdisk`
--

LOCK TABLES `netdisk` WRITE;
/*!40000 ALTER TABLE `netdisk` DISABLE KEYS */;
/*!40000 ALTER TABLE `netdisk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `NEWS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '新闻标题',
  `CONTENT` mediumtext NOT NULL COMMENT '新闻内容',
  `PROVIDER` varchar(200) NOT NULL DEFAULT '' COMMENT '发布者',
  `NEWS_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `CLICK_COUNT` int(11) NOT NULL DEFAULT '0' COMMENT '点击数',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `ANONYMITY_YN` varchar(20) NOT NULL DEFAULT '0' COMMENT '评论类型(0-实名评论,1-匿名评论,2-禁止评论)',
  `FORMAT` varchar(20) NOT NULL DEFAULT '0' COMMENT '新闻格式(0-普通格式,1-MHT格式,2-超链接)',
  `TYPE_ID` varchar(200) NOT NULL DEFAULT '' COMMENT '新闻类型',
  `PUBLISH` char(1) NOT NULL DEFAULT '1' COMMENT '发布标识(0-未发布,1-已发布,2-已终止)',
  `TO_ID` text NOT NULL COMMENT '发布部门',
  `PRIV_ID` text NOT NULL COMMENT '发布角色',
  `USER_ID` text NOT NULL COMMENT '发布人员',
  `READERS` text NOT NULL COMMENT '阅读人员ID串',
  `COMPRESS_CONTENT` mediumblob NOT NULL COMMENT '压缩后的新闻内容',
  `TOP` varchar(2) NOT NULL DEFAULT '0' COMMENT '是否置顶(0-否,1-是)',
  `LAST_EDITOR` varchar(200) NOT NULL COMMENT '最后编辑人',
  `LAST_EDIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后编辑时间',
  `SUBJECT_COLOR` varchar(8) NOT NULL COMMENT '新闻标题颜色',
  `SUMMARY` text NOT NULL COMMENT '新闻内容简介',
  `KEYWORD` varchar(100) NOT NULL COMMENT '内容关键词',
  `TOP_DAYS` varchar(32) NOT NULL COMMENT '限制新闻置顶时间',
  `AUDITER` varchar(50) NOT NULL DEFAULT '' COMMENT '审批人',
  `AUDITER_TIME` datetime NOT NULL COMMENT '审批时间',
  `AUDITER_STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '审批状态(0-待审批,1-批准，2-不批准)',
  `RUN_ID` int(11) DEFAULT '0' COMMENT '新闻审批关联的runId',
  `AUTHOR` varchar(50) DEFAULT '' COMMENT '作者',
  `PHOTOGRAPHER` varchar(50) DEFAULT '' COMMENT '摄影',
  `TITLE_PIC_ID` varchar(255) DEFAULT '' COMMENT '封面图片id',
  `TITLE_PIC_NAME` varchar(255) DEFAULT '' COMMENT '封面图片名称',
  PRIMARY KEY (`NEWS_ID`) USING BTREE,
  KEY `SUBJECT` (`SUBJECT`) USING BTREE,
  KEY `PROVIDER` (`PROVIDER`) USING BTREE,
  KEY `NEWS_TIME` (`NEWS_TIME`) USING BTREE,
  KEY `PUBLISH` (`PUBLISH`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='新闻表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_comment`
--

DROP TABLE IF EXISTS `news_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PARENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '跟帖用的字段',
  `NEWS_ID` int(11) NOT NULL DEFAULT '0' COMMENT '新闻ID',
  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '发表评论/回复的用户',
  `NICK_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `CONTENT` text NOT NULL COMMENT '评论/回复内容',
  `RE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '评论/回复时间',
  PRIMARY KEY (`COMMENT_ID`) USING BTREE,
  KEY `PARENT_ID` (`PARENT_ID`) USING BTREE,
  KEY `NEWS_ID` (`NEWS_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `RE_TIME` (`RE_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='新闻点评表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_comment`
--

LOCK TABLES `news_comment` WRITE;
/*!40000 ALTER TABLE `news_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `news_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `NOTE_ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '便签ID',
  `UID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属用户UID',
  `CONTENT` text NOT NULL COMMENT '便签内容',
  `COLOR` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '便签颜色',
  `SHOW_FLAG` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'OA精灵固定显示标记(0-不显示，1-第一次显示，2-始终显示)',
  `CREATE_TIME` int(10) unsigned NOT NULL COMMENT '创建时间',
  `EDIT_TIME` int(10) unsigned NOT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`NOTE_ID`) USING BTREE,
  KEY `UID` (`UID`) USING BTREE,
  KEY `CREATE_TIME` (`CREATE_TIME`) USING BTREE,
  KEY `EDIT_TIME` (`EDIT_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='便签表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify`
--

DROP TABLE IF EXISTS `notify`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify` (
  `NOTIFY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `FROM_DEPT` int(11) NOT NULL DEFAULT '0' COMMENT '发布部门ID',
  `FROM_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '发布用户USER_ID',
  `TO_ID` text NOT NULL COMMENT '按部门发布',
  `SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '公告标题',
  `CONTENT` mediumtext NOT NULL COMMENT '公告通知内容',
  `SEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `BEGIN_DATE` int(10) unsigned NOT NULL COMMENT '开始日期',
  `END_DATE` int(10) unsigned NOT NULL COMMENT '结束日期',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  `READERS` text NOT NULL COMMENT '阅读人员用户ID串',
  `PRINT` char(1) NOT NULL DEFAULT '' COMMENT '是否允许打印office附件(0-不允许,1-允许)',
  `PRIV_ID` text NOT NULL COMMENT '按角色发布',
  `USER_ID` text NOT NULL COMMENT '按人员发布',
  `TYPE_ID` varchar(200) NOT NULL DEFAULT '' COMMENT '公告类型',
  `TOP` varchar(20) NOT NULL DEFAULT '0' COMMENT '是否置顶(0-否,1-是)',
  `TOP_DAYS` int(4) NOT NULL DEFAULT '0' COMMENT '置顶天数',
  `FORMAT` varchar(20) NOT NULL DEFAULT '0' COMMENT '公告通知格式(0-普通格式,1-mht格式,2-超链接)',
  `PUBLISH` char(1) NOT NULL DEFAULT '1' COMMENT '发布标识(0-未发布,1-生效,2-待审批,3-未通过,4-待生效，5-终止)',
  `AUDITER` varchar(20) NOT NULL DEFAULT '' COMMENT '审核人用户ID',
  `REASON` text NOT NULL COMMENT '审核人不同意的原因',
  `AUDIT_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '审核时间',
  `COMPRESS_CONTENT` mediumblob NOT NULL COMMENT '压缩后的公告通知内容',
  `DOWNLOAD` char(1) NOT NULL DEFAULT '' COMMENT '是否允许下载office附件(0-不允许,1-允许)',
  `LAST_EDITOR` varchar(200) NOT NULL COMMENT '最后编辑人',
  `LAST_EDIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后编辑时间',
  `SUBJECT_COLOR` varchar(8) NOT NULL COMMENT '公告标题颜色',
  `SUMMARY` text NOT NULL COMMENT '内容简介',
  `KEYWORD` varchar(100) NOT NULL COMMENT '内容关键词',
  `IS_FW` char(1) NOT NULL COMMENT '是否转发',
  `HOW_RENIND` varchar(20) DEFAULT NULL COMMENT '0.事务提醒1.手机短信提醒',
  `IS_OPIN` char(10) DEFAULT '0' COMMENT '是否开启公告反馈',
  `OPINION_FIELDS` varchar(255) DEFAULT NULL COMMENT '开启栏位（1-2-3-4.....）',
  `OPIN_USERS` text NOT NULL COMMENT '已反馈人员ID串',
  `DRAFT_DEPT` varchar(200) DEFAULT NULL COMMENT '拟稿部门',
  `USER_TYPE` varchar(255) DEFAULT NULL COMMENT '人员类型（用于区分正式员工等）',
  `OPEN_WINDOW` char(10) DEFAULT '0' COMMENT '登录后自动弹出显示，1-自动弹出，0-不弹出',
  `CONTENT_SECRECY` varchar(50) DEFAULT NULL COMMENT '密级：系统代码',
  UNIQUE KEY `ID` (`NOTIFY_ID`) USING BTREE,
  KEY `FROM_DEPT` (`FROM_DEPT`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `SUBJECT` (`SUBJECT`) USING BTREE,
  KEY `SEND_TIME` (`SEND_TIME`) USING BTREE,
  KEY `AUDITER` (`AUDITER`) USING BTREE,
  KEY `AUDIT_DATE` (`AUDIT_DATE`) USING BTREE,
  KEY `BEGIN_DATE_2` (`BEGIN_DATE`) USING BTREE,
  KEY `END_DATE_2` (`END_DATE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公告通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify`
--

LOCK TABLES `notify` WRITE;
/*!40000 ALTER TABLE `notify` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notify_opinion`
--

DROP TABLE IF EXISTS `notify_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notify_opinion` (
  `OP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOTY_ID` int(11) NOT NULL COMMENT '公告ID',
  `USER_ID` varchar(200) NOT NULL COMMENT '填报用户USER_ID',
  `STATE` char(10) DEFAULT NULL COMMENT '退回状态（0-正常，1-已退回未修改，2-修改完成重新提交）',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `FIELD1` varchar(255) DEFAULT NULL,
  `FIELD2` varchar(255) DEFAULT NULL,
  `FIELD3` varchar(255) DEFAULT NULL,
  `FIELD4` varchar(255) DEFAULT NULL,
  `FIELD5` varchar(255) DEFAULT NULL,
  `FIELD6` varchar(255) DEFAULT NULL,
  `FIELD7` varchar(255) DEFAULT NULL,
  `FIELD8` varchar(255) DEFAULT NULL,
  `FIELD9` varchar(255) DEFAULT NULL,
  `FIELD10` varchar(255) DEFAULT NULL,
  `INUPUT_TIME` datetime NOT NULL COMMENT '添加时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `RETURN_COMMENTS` varchar(255) DEFAULT NULL COMMENT '退回意见',
  PRIMARY KEY (`OP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='公告反馈填报表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notify_opinion`
--

LOCK TABLES `notify_opinion` WRITE;
/*!40000 ALTER TABLE `notify_opinion` DISABLE KEYS */;
/*!40000 ALTER TABLE `notify_opinion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oa2sso`
--

DROP TABLE IF EXISTS `oa2sso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa2sso` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `GH` varchar(100) DEFAULT NULL,
  `USER_ID` varchar(100) DEFAULT NULL,
  `USER_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa2sso`
--

LOCK TABLES `oa2sso` WRITE;
/*!40000 ALTER TABLE `oa2sso` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa2sso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oa_cyclesource_used`
--

DROP TABLE IF EXISTS `oa_cyclesource_used`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_cyclesource_used` (
  `CYCID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `SOURCEID` int(11) NOT NULL COMMENT '资源ID',
  `B_APPLY_TIME` date NOT NULL COMMENT '开始日期',
  `E_APPLY_TIME` date NOT NULL COMMENT '结束日期',
  `WEEKDAY_SET` varchar(200) NOT NULL COMMENT '使用星期',
  `TIME_TITLE` varchar(200) NOT NULL COMMENT '使用时间段',
  `REMARK` varchar(400) NOT NULL COMMENT '备注',
  `USER_ID` varchar(45) NOT NULL COMMENT '用户USER_ID',
  `APPLY_TIME` datetime NOT NULL COMMENT '申请时间',
  PRIMARY KEY (`CYCID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='周期性资源信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_cyclesource_used`
--

LOCK TABLES `oa_cyclesource_used` WRITE;
/*!40000 ALTER TABLE `oa_cyclesource_used` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_cyclesource_used` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oa_source`
--

DROP TABLE IF EXISTS `oa_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_source` (
  `SOURCEID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `SOURCENO` int(11) NOT NULL DEFAULT '0' COMMENT '资源序号',
  `SOURCENAME` varchar(255) NOT NULL DEFAULT '' COMMENT '资源名称',
  `DAY_LIMIT` varchar(50) NOT NULL DEFAULT '' COMMENT '预约天数',
  `WEEKDAY_SET` varchar(50) NOT NULL DEFAULT '' COMMENT '星期设定',
  `TIME_TITLE` text NOT NULL COMMENT '时间段',
  `MANAGE_USER` text NOT NULL COMMENT '管理员',
  `VISIT_USER` text NOT NULL COMMENT '用户权限',
  `VISIT_PRIV` text NOT NULL COMMENT '角色权限',
  `REMARK` text NOT NULL COMMENT '备注',
  PRIMARY KEY (`SOURCEID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='资源信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_source`
--

LOCK TABLES `oa_source` WRITE;
/*!40000 ALTER TABLE `oa_source` DISABLE KEYS */;
INSERT INTO `oa_source` VALUES (1,1,'投影仪','7','1,2,3,4,5','09:00-09:30,09:30-10:00,10:00-10:30,10:30-11:00,11:00-11:30,11:30-12:00,12:00-12:30,12:30-13:00,13:00-13:30,13:30-14:00,14:00-14:30,14:30-15:00,15:00-15:30,15:30-16:00,16:00-16:30,16:30-17:00,17:00-17:30,17:30-18:00,18:00-21:00','wangyun,','admin,chenchangliu,lilingli,lichang,chenqiang,wuhai,naideshi,liutong,lihongguang,liqi,yinyunfei,zhanglan,zhangshan,lihai,zhuhong,litian,chenfeifei,wangyi,liuyongkang,wangwu,liumingcai,zhaomin,changbai,huhaifeng,lirui,zhangmingyao,liuna,wangde,wangyun,lijia,','','');
/*!40000 ALTER TABLE `oa_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oa_source_used`
--

DROP TABLE IF EXISTS `oa_source_used`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_source_used` (
  `SOURCEID` int(11) NOT NULL,
  `APPLY_DATE` date NOT NULL,
  `USER_ID` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oa_source_used`
--

LOCK TABLES `oa_source_used` WRITE;
/*!40000 ALTER TABLE `oa_source_used` DISABLE KEYS */;
/*!40000 ALTER TABLE `oa_source_used` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_depository`
--

DROP TABLE IF EXISTS `office_depository`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_depository` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `DEPOSITORY_NAME` varchar(200) DEFAULT NULL COMMENT '库名称',
  `OFFICE_TYPE_ID` text COMMENT '物品类表ID',
  `DEPT_ID` text COMMENT '所属部门',
  `MANAGER` text COMMENT '仓库管理员',
  `PRO_KEEPER` text COMMENT '物品调度员',
  `PRIV_ID` varchar(50) DEFAULT NULL,
  `RETURN_STATUS` int(1) DEFAULT '0' COMMENT '归还状态',
  `RETURN_DATE` date DEFAULT '0000-00-00' COMMENT '归还时间',
  `RETURN_REASON` text COMMENT '归还不同意理由',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='物品库表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_depository`
--

LOCK TABLES `office_depository` WRITE;
/*!40000 ALTER TABLE `office_depository` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_depository` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_log`
--

DROP TABLE IF EXISTS `office_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(1) NOT NULL COMMENT '1.调拨',
  `user_id` varchar(20) NOT NULL DEFAULT '' COMMENT '操作员',
  `office_str` text NOT NULL COMMENT '操作日志',
  `add_time` int(10) NOT NULL COMMENT '操作时间',
  `remark` text NOT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='办公用品操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_log`
--

LOCK TABLES `office_log` WRITE;
/*!40000 ALTER TABLE `office_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_products`
--

DROP TABLE IF EXISTS `office_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_products` (
  `PRO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PRO_NAME` varchar(200) DEFAULT '' COMMENT '办公用品名称',
  `PRO_DESC` text COMMENT '办公用品描述',
  `OFFICE_PROTYPE` varchar(20) DEFAULT '' COMMENT '物品所属类别ID',
  `PRO_CODE` varchar(20) DEFAULT '' COMMENT '办公用品编码',
  `PRO_UNIT` varchar(20) DEFAULT '' COMMENT '计量单位',
  `PRO_PRICE` decimal(10,2) DEFAULT '0.00' COMMENT '单价',
  `PRO_SUPPLIER` text COMMENT '供应商',
  `PRO_LOWSTOCK` int(11) DEFAULT '0' COMMENT '最低警戒库存',
  `PRO_MAXSTOCK` int(11) DEFAULT '0' COMMENT '最高警戒库存',
  `PRO_STOCK` int(11) DEFAULT '0' COMMENT '当前库存',
  `PRO_DEPT` text COMMENT '登记权限部门',
  `PRO_MANAGER` text COMMENT '登记权限用户',
  `PRO_CREATOR` varchar(20) DEFAULT '' COMMENT '创建人',
  `PRO_AUDITER` text COMMENT '审批权限用户',
  `PRO_ORDER` varchar(11) DEFAULT NULL,
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `OFFICE_PRODUCT_TYPE` int(11) DEFAULT '2' COMMENT '办公用品类型(1-领用, 2-借用)',
  `ALLOCATION` tinyint(1) DEFAULT '0' COMMENT '调拨属性',
  PRIMARY KEY (`PRO_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='物品信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_products`
--

LOCK TABLES `office_products` WRITE;
/*!40000 ALTER TABLE `office_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_task`
--

DROP TABLE IF EXISTS `office_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_task` (
  `TASK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `TASK_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT '任务类型(0-间隔执行PHP程序,1-定时执行PHP程序,2-定时执行EXE程序,3-间隔执行EXE程序)',
  `INTERVAL` int(11) NOT NULL DEFAULT '10' COMMENT '执行间隔，单位分钟',
  `EXEC_TIME` time NOT NULL COMMENT '执行时间',
  `LAST_EXEC` datetime NOT NULL COMMENT '上次执行时间',
  `EXEC_FLAG` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '执行标记(0-未执行,1-执行成功,2-执行失败)',
  `EXEC_MSG` varchar(200) NOT NULL DEFAULT '' COMMENT '任务执行结果描述',
  `TASK_URL` varchar(200) NOT NULL DEFAULT '' COMMENT '任务文件',
  `TASK_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '任务名称',
  `TASK_DESC` varchar(250) NOT NULL DEFAULT '' COMMENT '任务详细描述',
  `TASK_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '任务唯一代码',
  `USE_FLAG` char(1) NOT NULL DEFAULT '1' COMMENT '是否启用(1-是,0-否)',
  `SYS_TASK` char(1) NOT NULL DEFAULT '0' COMMENT '是否系统内置任务(1-是,0-否)',
  `EXT_DATA` text NOT NULL COMMENT '扩展数据',
  `EXCEPTION_LOG` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '执行失败是否记录异常日志（0 不记录，1 记录）',
  PRIMARY KEY (`TASK_ID`) USING BTREE,
  UNIQUE KEY `TASK_CODE` (`TASK_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_task`
--

LOCK TABLES `office_task` WRITE;
/*!40000 ALTER TABLE `office_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_transhistory`
--

DROP TABLE IF EXISTS `office_transhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_transhistory` (
  `TRANS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PRO_ID` int(11) DEFAULT '0' COMMENT '办公用品ID',
  `BORROWER` varchar(20) DEFAULT NULL COMMENT '申请人',
  `TRANS_FLAG` varchar(20) DEFAULT '' COMMENT '登记类型',
  `TRANS_QTY` int(11) DEFAULT '0' COMMENT '申请时的数量',
  `PRICE` decimal(10,2) DEFAULT '0.00' COMMENT '物品价格',
  `REMARK` text COMMENT '备注',
  `TRANS_DATE` date DEFAULT '0000-00-00' COMMENT '申请时间',
  `OPERATOR` varchar(20) DEFAULT '' COMMENT '操作员',
  `TRANS_STATE` varchar(20) DEFAULT '' COMMENT '申请的状态标志(01-待部门审批人审批,02-待库管理员审批,1-同意,21-部门审批驳回，22-库管员驳回)',
  `FACT_QTY` int(11) DEFAULT '0' COMMENT '实际的申请数量',
  `REASON` text COMMENT '不同意理由',
  `COMPANY` varchar(20) DEFAULT NULL COMMENT '厂家',
  `BAND` varchar(20) DEFAULT NULL COMMENT '品牌',
  `CYCLE_NO` int(11) DEFAULT '0' COMMENT '批量申请的ID',
  `CYCLE` char(1) DEFAULT NULL COMMENT '批量申请标记',
  `DEPT_ID` int(11) DEFAULT NULL COMMENT '部门ID',
  `PRO_KEEPER` varchar(20) DEFAULT NULL COMMENT '物品调度员',
  `GRANTOR` varchar(20) DEFAULT NULL COMMENT '发放物品的操作员',
  `GRANT_STATUS` char(1) DEFAULT '0' COMMENT '物品发放处理状态(0-未处理,1-已处理)',
  `DEPT_MANAGER` varchar(200) DEFAULT NULL COMMENT '部门审批人',
  `DEPT_STATUS` int(1) DEFAULT '1' COMMENT '部门审批状态标志',
  `RETURN_STATUS` int(1) DEFAULT '0' COMMENT '归还状态',
  `RETURN_DATE` date DEFAULT '0000-00-00' COMMENT '归还时间',
  `RETURN_REASON` text COMMENT '归还不同意理由',
  `GET_SUBMIT_STATUS` char(10) DEFAULT '1' COMMENT '批量申领提交状态(0-未提交，1-已提交)',
  `GET_SUBMIT_LIST` text COMMENT '批量申领办公用品明细JSON',
  `AVAILABLE` varchar(200) DEFAULT '' COMMENT '维护时间串',
  PRIMARY KEY (`TRANS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='物品登记申请记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_transhistory`
--

LOCK TABLES `office_transhistory` WRITE;
/*!40000 ALTER TABLE `office_transhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_transhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_type`
--

DROP TABLE IF EXISTS `office_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `office_type` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `TYPE_NAME` varchar(200) DEFAULT '' COMMENT '类别名称',
  `TYPE_ORDER` varchar(200) DEFAULT '' COMMENT '排序号',
  `TYPE_PARENT_ID` int(10) unsigned DEFAULT '0' COMMENT '父类型ID',
  `TYPE_DEPOSITORY` int(10) unsigned DEFAULT '1' COMMENT '所属库的库ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='物品类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_type`
--

LOCK TABLES `office_type` WRITE;
/*!40000 ALTER TABLE `office_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `only_office_history`
--

DROP TABLE IF EXISTS `only_office_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `only_office_history` (
  `OID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AID` int(11) DEFAULT NULL COMMENT 'attachment表中的附件id',
  `USER_ID` varchar(50) DEFAULT NULL COMMENT '用户userId',
  `USER_NAME` varchar(60) DEFAULT NULL COMMENT '用户姓名',
  `HISTORY_KEY` varchar(100) DEFAULT NULL COMMENT '历史版本key',
  `CHANGES_URL` text COMMENT '回调接口中返回的url，用于展示历史版本的时候调用',
  `FILE_URL` text COMMENT '文件的url，用于历史版本的切换',
  `CREATED` varchar(50) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`OID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='onlyoffice文档历史记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `only_office_history`
--

LOCK TABLES `only_office_history` WRITE;
/*!40000 ALTER TABLE `only_office_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `only_office_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org_department`
--

DROP TABLE IF EXISTS `org_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_department` (
  `ORG_DEPT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORG_DEPT_NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '组织名称',
  `ORG_TEL_NO` varchar(50) DEFAULT '' COMMENT '电话',
  `ORG_FAX_NO` varchar(50) DEFAULT '' COMMENT '传真',
  `ORG_DEPT_ADDRESS` varchar(100) DEFAULT NULL COMMENT '组织地址',
  `ORG_DEPT_NO` varchar(200) NOT NULL DEFAULT '0' COMMENT '组织排序号',
  `ORG_DEPT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级组织ID',
  `ORG_MANAGER` text COMMENT '组织主管',
  `ORG_ASSISTANT_ID` text COMMENT '组织助理',
  `ORG_DEPT_FUNC` text NOT NULL COMMENT '组织简介',
  `ORG_ORG_ADMIN` varchar(200) DEFAULT NULL COMMENT '机构管理员',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `GRID_LOCATION` text COMMENT '标注地址',
  `ORG_VICECLERK` varchar(255) DEFAULT NULL COMMENT '副书记',
  `ORG_COUNCIL` varchar(255) DEFAULT NULL COMMENT '委员数',
  `ORG_TENURE` varchar(255) DEFAULT NULL COMMENT '任期',
  `ORG_OLDDATE` varchar(255) DEFAULT NULL COMMENT '上次换届时间',
  `ORG_NEWDATE` varchar(255) DEFAULT NULL COMMENT '本次换届时间',
  `ORG_ORGCOUNT` varchar(255) DEFAULT NULL COMMENT '划分党小组',
  `ORG_USERORG` varchar(255) DEFAULT NULL COMMENT '党组织书记',
  `ORG_IPHONE` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `ORG_FEIGONG` varchar(255) DEFAULT NULL COMMENT '非公企业数',
  `ORG_ZHIDAO` varchar(255) DEFAULT NULL COMMENT '非公指导员',
  `ORG_LIUDONG` varchar(255) DEFAULT NULL COMMENT '流动党员数',
  `ORG_REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ORG_DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='党支部';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org_department`
--

LOCK TABLES `org_department` WRITE;
/*!40000 ALTER TABLE `org_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `org_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org_goviment`
--

DROP TABLE IF EXISTS `org_goviment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_goviment` (
  `gid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '文件标题',
  `content` text COMMENT '文件内容',
  `type` varchar(255) DEFAULT NULL COMMENT '文件类型（SYS_CODE-PARTY_FILE_TYPE）',
  `sendTime` varchar(255) DEFAULT NULL COMMENT '发布时间',
  `sendUser` varchar(255) DEFAULT NULL COMMENT '发布人',
  `orgDepId` int(11) DEFAULT NULL COMMENT '发布党组织',
  `addName` varchar(255) DEFAULT NULL,
  `delName` varchar(255) DEFAULT NULL,
  `PARTY_FILE_TYPE` char(10) DEFAULT NULL COMMENT '政策文件类型(SYS_CODE)',
  PRIMARY KEY (`gid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='政策文件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org_goviment`
--

LOCK TABLES `org_goviment` WRITE;
/*!40000 ALTER TABLE `org_goviment` DISABLE KEYS */;
/*!40000 ALTER TABLE `org_goviment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org_manage`
--

DROP TABLE IF EXISTS `org_manage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_manage` (
  `OID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `NAME` text NOT NULL COMMENT '单位名称',
  `EN_NAME` varchar(255) DEFAULT NULL COMMENT '英文',
  `FT_NAME` varchar(255) DEFAULT NULL COMMENT '繁体',
  `JP_NAME` varchar(255) DEFAULT NULL COMMENT '日文',
  `KR_NAME` varchar(255) DEFAULT NULL COMMENT '韩文',
  `VERSION` varchar(200) NOT NULL COMMENT '版本信息',
  `IS_ORG` char(255) DEFAULT NULL COMMENT '是否组织',
  `LICENSE_USERS` int(11) DEFAULT '0' COMMENT '授权用户数',
  `USED_USERS` int(11) DEFAULT '0' COMMENT '系统用户数',
  `LICENSE_SPACE` int(11) DEFAULT '0' COMMENT '授权存储空间G',
  `USED_SPACE` int(11) DEFAULT '0' COMMENT '已使用存储空间G',
  `REGIST_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `REMIND_TIME` datetime DEFAULT NULL COMMENT '提醒时间',
  `AGENT_ID` int(11) DEFAULT '0' COMMENT '代理商ID',
  PRIMARY KEY (`OID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统架构表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org_manage`
--

LOCK TABLES `org_manage` WRITE;
/*!40000 ALTER TABLE `org_manage` DISABLE KEYS */;
INSERT INTO `org_manage` VALUES (1001,'北京集团总公司','BeiJing Group','北京集團網路智慧辦公平臺',NULL,NULL,'17.07.03','1',0,0,0,0,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `org_manage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org_party_member`
--

DROP TABLE IF EXISTS `org_party_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_party_member` (
  `OP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '党员自增ID',
  `ORG_DEPT_ID` int(11) NOT NULL COMMENT '优秀党支部ID',
  `USER_ID` varchar(255) DEFAULT NULL COMMENT 'User表Id',
  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',
  `SEX` varchar(50) DEFAULT NULL COMMENT '性别',
  `FAMILY_NAME` varchar(255) DEFAULT NULL COMMENT '民族',
  `BIRTHDAY` varchar(255) DEFAULT NULL COMMENT '出生日期',
  `MEMBER_TYPE` varchar(255) DEFAULT NULL COMMENT '党员类型',
  `ADMISSION_DATE` datetime DEFAULT NULL COMMENT '入党日期',
  `POST` varchar(255) DEFAULT NULL COMMENT '工作岗位',
  `EDUCATION` varchar(255) DEFAULT NULL COMMENT '学历',
  `TEL` varchar(255) DEFAULT NULL COMMENT '联系方式',
  `BECOME_DATE` datetime DEFAULT NULL COMMENT '转正日期',
  `PARTY_STATE` varchar(255) DEFAULT NULL COMMENT '党籍状态',
  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `ADDRESS_LOCATION` longtext,
  `CONTACT_NOS` varchar(255) DEFAULT NULL COMMENT '是否是失联党员',
  `CONTACT_DATE` varchar(255) DEFAULT NULL COMMENT '失联日期',
  `FLOW_MEMBER_NOS` varchar(50) DEFAULT NULL COMMENT '是否未流动党员',
  `EXTR_MEMBER` varchar(255) DEFAULT NULL COMMENT '外出流向',
  `MEMBER_TYPE_TO` varchar(50) DEFAULT NULL COMMENT '党员类别',
  `TIS1` varchar(255) DEFAULT NULL COMMENT '备用字段',
  `TIS2` varchar(255) DEFAULT NULL COMMENT '备用字段',
  `TIS3` varchar(255) DEFAULT NULL COMMENT '备用字段',
  `PARTY_POST` varchar(100) DEFAULT NULL COMMENT '党内职务(SYS_CODE)',
  `NATIVE_PLACE` varchar(200) DEFAULT NULL COMMENT '籍贯',
  `CREW_STATE` varchar(10) DEFAULT NULL COMMENT '船员状态(0-在船1-休假2-机关上班3-流动党员)',
  `STATE_BEGIN_TIME` datetime DEFAULT NULL COMMENT '状态开始时间',
  PRIMARY KEY (`OP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='党员表--org_party_member';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org_party_member`
--

LOCK TABLES `org_party_member` WRITE;
/*!40000 ALTER TABLE `org_party_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `org_party_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party_member`
--

DROP TABLE IF EXISTS `party_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `party_member` (
  `MEMBER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(100) NOT NULL DEFAULT '' COMMENT '申请人UserId',
  `USER_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '申请人姓名',
  `DEPT_ID` int(11) NOT NULL COMMENT '部门ID',
  `FAMILY_NAME` varchar(255) NOT NULL COMMENT '民族',
  `PARENT_PEDT_ID` int(11) NOT NULL COMMENT '所属党支部（主部门ID）',
  `SEX` char(10) NOT NULL DEFAULT '0' COMMENT '性别（0-男，1-女）',
  `POST_ID` int(11) DEFAULT NULL,
  `BIRTHDAY` date DEFAULT NULL COMMENT '出身年月日',
  `DEVELOP_PHASE` char(10) NOT NULL DEFAULT '0' COMMENT '发展阶段（0-申请阶段，1-申请通过 ，2-入党积极分子，3-发展对象，4-预备党员未接收，5-已接收预备党员，6-党员）',
  `APPLY_TIME` datetime DEFAULT NULL COMMENT '入党通过申请时间',
  `ACTIVISTS_TIME` datetime DEFAULT NULL COMMENT '确定积极分子时间',
  `DEVELOP_TIME` datetime DEFAULT NULL COMMENT '确定发展对象时间',
  `PREPARE_TIME` datetime DEFAULT NULL COMMENT '确定预备党员时间',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '预备党员接收时间',
  `REPORTS` char(10) DEFAULT NULL COMMENT '考察培养（最少四个阶段1234）',
  `STATE` char(10) DEFAULT NULL COMMENT '审核状态（0-未审核，1-审核未通过，2-审核通过）',
  `STATE_TIME` datetime DEFAULT NULL COMMENT '审核通过时间',
  `OLD_RUN_ID` varchar(255) DEFAULT NULL COMMENT '历史流程ID（规定条数 1||2,3||4,5,6||7）',
  `RUN_ID` varchar(255) DEFAULT NULL COMMENT '关联流程ID',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件名称串',
  `ATTACHMENT_ID_APPLY` text COMMENT '附件ID串(申请阶段)',
  `ATTACHMENT_NAME_APPLY` text COMMENT '附件名称串',
  `ATTACHMENT_ID_AUDIT` text COMMENT '附件ID串(审核阶段)',
  `ATTACHMENT_NAME_AUDIT` text COMMENT '附件名称串',
  `ATTACHMENT_ID_POSITIVE` text COMMENT '附件ID串(入党积极分子)',
  `ATTACHMENT_NAME_POSITIVE` text COMMENT '附件名称串',
  `ATTACHMENT_ID_DEVELOP` text COMMENT '附件ID串(发展对象)',
  `ATTACHMENT_NAME_DEVELOP` text COMMENT '附件名称串',
  `ATTACHMENT_ID_PREPARE` text COMMENT '附件ID串(接收党员)',
  `ATTACHMENT_NAME_PREPARE` text COMMENT '附件名称串',
  `ATTACHMENT_ID_RECEIVE` text COMMENT '附件ID串(预备党员)',
  `ATTACHMENT_NAME_RECEIVE` text COMMENT '附件名称串',
  `ATTACHMENT_ID_MEMBER` text COMMENT '附件ID串(正式党员)',
  `ATTACHMENT_NAME_MEMBER` text COMMENT '附件名称串',
  `ATTACHMENT_ID_DEVELOPS_REPORT` text COMMENT '发展对象思想汇报附件ID串',
  `ATTACHMENT_NAME_DEVELOPS_REPORT` text COMMENT '发展对象思想汇报附件串',
  `REPORT_TIME` text,
  `THOUGHT_REPORT_TIME` text,
  `DEVELOPS_REPORT_TIME` text,
  `ATTACHMENT_NAME_THOUGHT_REPORT` text COMMENT '预备党员思想汇报附件串',
  `ATTACHMENT_ID_THOUGHT_REPORT` text COMMENT '预备党员思想汇报附件ID串',
  `NODE_STATUS` varchar(255) DEFAULT NULL COMMENT '入党阶段子节点(0-从申请入党跳过其他阶段进入当前阶段第一步,1-根据流程进入子节点第一步,2-根据流程进入子节点第二步)',
  `ATTACHMENT_NAME_REPORT` text COMMENT '积极分子思想汇报附件串',
  `ATTACHMENT_ID_REPORT` text COMMENT '积极分子思想汇报附件ID串',
  `RECOMMEND_PERSON` varchar(255) DEFAULT NULL COMMENT '入党介绍人',
  `DEVELOP_CONTACTS` varchar(255) DEFAULT NULL COMMENT '培养联系人',
  `ATTACHMENT_NAME_RECOMMEND` text COMMENT '入党介绍人附件串',
  `ATTACHMENT_ID_RECOMMEND` text COMMENT '\r\n入党介绍人附件ID串',
  `ATTACHMENT_NAME_DEVELOPS` text COMMENT '培养联系人附件串',
  `ATTACHMENT_ID_DEVELOPS` text COMMENT '培养联系人附件ID串',
  `ATTACHMENT_ID_APPLY_REPORT` text COMMENT '入党申请人思想汇报附件ID串',
  `ATTACHMENT_NAME_APPLY_REPORT` text COMMENT '入党申请人思想汇报附件串',
  `APPLY_REPORT_TIME` text COMMENT '入党申请人思想汇报时间',
  `ATTACHMENT_ID_AUTOBIOGRAPHY_REPORT` text COMMENT '自传附件ID',
  `ATTACHMENT_NAME_AUTOBIOGRAPHY_REPORT` text COMMENT '自传附件',
  `ATTACHMENT_ID_REGULAR_REPORT` text COMMENT '转正申请书附件ID',
  `ATTACHMENT_NAME_REGULAR_REPORT` text COMMENT '转正申请书附件',
  `AUTOBIOGRAPHY_TIME` text COMMENT '自传时间',
  `REGULAR_TIME` text COMMENT '转正申请书时间',
  `CENTRALIZED_TRAINING_TIME` datetime DEFAULT NULL COMMENT '短期集中培训发证时间',
  `ARCHIVES_HISTORY` text COMMENT '培养考察档案移交历史,格式:旧支部=>新支部*时间,',
  PRIMARY KEY (`MEMBER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='党员档案表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party_member`
--

LOCK TABLES `party_member` WRITE;
/*!40000 ALTER TABLE `party_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `party_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture`
--

DROP TABLE IF EXISTS `picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture` (
  `PIC_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `PIC_NAME` varchar(250) NOT NULL DEFAULT '' COMMENT '图片目录名称',
  `PIC_PATH` text NOT NULL COMMENT '图片目录路径',
  `TO_DEPT_ID` text NOT NULL COMMENT '部门发布范围',
  `TO_PRIV_ID` text NOT NULL COMMENT '角色发布范围',
  `TO_USER_ID` text NOT NULL COMMENT '用户发布范围',
  `PRIV_STR` text NOT NULL COMMENT '上传权限',
  `DEL_PRIV_STR` text NOT NULL COMMENT '管理权限',
  `ROW_PIC_NUM` int(2) NOT NULL DEFAULT '7' COMMENT '每行显示的图片张数',
  `ROW_PIC` int(2) NOT NULL DEFAULT '5' COMMENT '每页显示行数',
  PRIMARY KEY (`PIC_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='图片浏览表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture`
--

LOCK TABLES `picture` WRITE;
/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
INSERT INTO `picture` VALUES (1,'项目启动','d:/myoa/项目启动','ALL_DEPT','','','','',7,5),(2,'员工活动','d:/myoa/员工活动','ALL_DEPT','','','','',7,5);
/*!40000 ALTER TABLE `picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_article`
--

DROP TABLE IF EXISTS `portal_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_article` (
  `ARTICLE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `COLUMN_ID` int(11) NOT NULL COMMENT '所属栏目ID',
  `CREATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '创建人USER_ID',
  `CREATE_USER_NAME` varchar(100) DEFAULT NULL COMMENT '创建人姓名',
  `MAIN_HEAD` text NOT NULL COMMENT '主标题',
  `SUB_HEAD` text NOT NULL COMMENT '副标题',
  `KEY_WORD` varchar(255) DEFAULT NULL COMMENT '关键词',
  `ARTICLE_SUMMARY` text NOT NULL COMMENT '摘要',
  `ARTICLE_TITLE` text COMMENT '文章标题',
  `ARTICLE_COMTENT` text NOT NULL COMMENT '文章内容',
  `ARTICLE_SOURCE` varchar(255) DEFAULT '' COMMENT '文章来源',
  `AUTHOR` varchar(255) DEFAULT NULL COMMENT '作者',
  `AUTHOR_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '写作时间',
  `TOP_YN` char(1) NOT NULL DEFAULT '0' COMMENT '是否置顶(0-否,1-是)',
  `AUDIT_STATE` char(1) CHARACTER SET utf8mb4 DEFAULT '1' COMMENT '审核状态(0未通过，1通过)',
  `THUMBNAIL_ID` varchar(255) DEFAULT NULL COMMENT '缩略图ID',
  `THUMBNAIL_NAME` varchar(255) DEFAULT NULL COMMENT '缩略图NAME',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '附件ID',
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '附件名',
  PRIMARY KEY (`ARTICLE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_article`
--

LOCK TABLES `portal_article` WRITE;
/*!40000 ALTER TABLE `portal_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_column`
--

DROP TABLE IF EXISTS `portal_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_column` (
  `COLUMN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '栏目ID',
  `PORTAL_ID` int(11) NOT NULL COMMENT '所属门户ID',
  `SORT_NO` varchar(10) DEFAULT NULL COMMENT '栏目排序号',
  `COLUMN_MARK` varchar(50) DEFAULT NULL COMMENT '栏目标识',
  `COLUMN_NAME` varchar(255) NOT NULL COMMENT '栏目名称',
  `PAGE_SIZE` int(11) NOT NULL DEFAULT '10' COMMENT '分页大小',
  `PARENT_COLUMN_ID` int(11) DEFAULT NULL COMMENT '上级栏目ID',
  `PATH` varchar(50) NOT NULL COMMENT '路径',
  `LIST_TEMPLATE` int(11) NOT NULL COMMENT '列表模板',
  `DETAIL_TEMPLATE` int(11) DEFAULT NULL COMMENT '详情模板',
  `AUDIT_YN` char(1) DEFAULT '0' COMMENT '是否审核(0-否,1-是)',
  `AUDIT_USER` varchar(50) DEFAULT NULL COMMENT '审核人USERID',
  `APPENDIX` varchar(50) DEFAULT NULL COMMENT '附件',
  PRIMARY KEY (`COLUMN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='栏目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_column`
--

LOCK TABLES `portal_column` WRITE;
/*!40000 ALTER TABLE `portal_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_site`
--

DROP TABLE IF EXISTS `portal_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_site` (
  `PORTAL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '门户ID',
  `SORT_NO` varchar(10) DEFAULT NULL COMMENT '门户排序号',
  `PORTAL_MARK` varchar(50) NOT NULL COMMENT '门户标识',
  `PORTAL_NAME` varchar(255) DEFAULT NULL COMMENT '门户名称',
  `HOME_TEMPLATE` int(11) DEFAULT NULL COMMENT '首页模板',
  `PATH` varchar(255) DEFAULT NULL COMMENT '存放位置',
  `PUB_FILE_EXT` varchar(255) DEFAULT 'html' COMMENT '页面发布类型',
  `DETAIL_TEMPLATE` int(11) DEFAULT NULL COMMENT '细览模板',
  PRIMARY KEY (`PORTAL_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='门户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_site`
--

LOCK TABLES `portal_site` WRITE;
/*!40000 ALTER TABLE `portal_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_template`
--

DROP TABLE IF EXISTS `portal_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_template` (
  `TEMPLATE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '模板ID',
  `PORTAL_ID` int(11) NOT NULL COMMENT '所属门户ID',
  `TEMPLATE_NAME` text NOT NULL COMMENT '模板名称',
  `TEMPLATE_FILE` varchar(255) DEFAULT NULL COMMENT '模板文件',
  `TEMPLATE_DESC` text NOT NULL COMMENT '模板描述',
  PRIMARY KEY (`TEMPLATE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_template`
--

LOCK TABLES `portal_template` WRITE;
/*!40000 ALTER TABLE `portal_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `portal_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portal_templates`
--

DROP TABLE IF EXISTS `portal_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portal_templates` (
  `template_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '模版ID（自增唯一）',
  `template_no` smallint(5) unsigned NOT NULL COMMENT '模版编号',
  `template_name` varchar(30) NOT NULL DEFAULT '' COMMENT '模版名称',
  `template_link` varchar(100) NOT NULL DEFAULT '' COMMENT '模版程序路径',
  `sys_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否系统内置模版(0 –不是,1-是)',
  PRIMARY KEY (`template_id`) USING BTREE,
  KEY `template _no` (`template_no`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='门户模版表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portal_templates`
--

LOCK TABLES `portal_templates` WRITE;
/*!40000 ALTER TABLE `portal_templates` DISABLE KEYS */;
INSERT INTO `portal_templates` VALUES (1,10,'总部（集团）门户模版','/portal/group/',1),(2,20,'部门（分支机构）门户模版','/portal/enterprise/',1);
/*!40000 ALTER TABLE `portal_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portals`
--

DROP TABLE IF EXISTS `portals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portals` (
  `portals_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `portals_no` int(11) DEFAULT NULL COMMENT '排序号',
  `portal_name` varchar(255) DEFAULT NULL COMMENT '门户名称',
  `portal_name1` varchar(255) DEFAULT NULL,
  `portal_name2` varchar(255) DEFAULT NULL,
  `portal_name3` varchar(255) DEFAULT NULL,
  `portal_name4` varchar(255) DEFAULT NULL,
  `portal_name5` varchar(255) DEFAULT NULL,
  `portal_type` int(11) DEFAULT NULL COMMENT '门户类型（0：系统门户；1：自定义门户）',
  `portal_link` varchar(255) DEFAULT NULL COMMENT '系统门户关联地址',
  `module_id` varchar(255) DEFAULT NULL COMMENT '自定义门户关联id',
  `use_flag` int(11) DEFAULT NULL COMMENT '启用标记(0-停用,1-启用)',
  `access_priv_dept` longtext COMMENT '授权部门',
  `access_priv_priv` varchar(255) DEFAULT NULL COMMENT '授权角色',
  `access_priv_user` longtext COMMENT '授权用户',
  `access_priv` int(1) DEFAULT '0' COMMENT '是否授权（0所有人1指定授权）',
  `portals_show` varchar(255) DEFAULT NULL COMMENT '我的门户模块显示id串',
  `portals_menu` varchar(255) DEFAULT NULL COMMENT '应用门户显示菜单串',
  `show_num` int(10) DEFAULT '0' COMMENT '排列方式每行几个',
  `portals_manage` varchar(255) DEFAULT NULL COMMENT '管理门户模块显示id串',
  `new_window` varchar(50) DEFAULT '0' COMMENT '是否在新窗口打开',
  PRIMARY KEY (`portals_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portals`
--

LOCK TABLES `portals` WRITE;
/*!40000 ALTER TABLE `portals` DISABLE KEYS */;
INSERT INTO `portals` VALUES (1,1,'我的门户','My Portal','我的門戶','マイポータル','ໂຮງຮຽນ',NULL,0,'','/common/myOA2',1,'','','',0,'0b,01,02,04,03,07,05,09,10,06,12,08,11,14,17,','01,03,02,04,05,06,07,10,08,09,',NULL,'','1'),(2,2,'应用门户','Application Portal','應用門戶','アプリケーションポータル','ໂປຣເເກຣມທົວໄປ',NULL,0,'','/common/applyOA',1,'','','',0,'0116,0117,0101,0124,0128,0136,3001,1010,1020,3010,208002,208004,208006,','3010,3001,208002,0117,0136,1010,0101,0124,1020,0116,',5,'','0');
/*!40000 ALTER TABLE `portals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portals1`
--

DROP TABLE IF EXISTS `portals1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portals1` (
  `portal_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '门户ID（自增唯一）',
  `portal_no` smallint(5) unsigned NOT NULL COMMENT '门户编号',
  `portal_name` varchar(30) NOT NULL DEFAULT '' COMMENT '门户名称',
  `portal_icon` tinyint(3) unsigned NOT NULL COMMENT '门户名称前显示的图标编号',
  `portal_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '门户类型(0-使用门户模版,1-使用链接地址)',
  `portal_link` varchar(100) NOT NULL DEFAULT '' COMMENT '门户链接地址',
  `portal_code` varchar(20) NOT NULL DEFAULT '' COMMENT '门户代码，做为内置门户唯一标记',
  `logo_img_id` varchar(30) NOT NULL DEFAULT '' COMMENT '门户logo文件ID',
  `logo_img_name` varchar(300) NOT NULL DEFAULT '' COMMENT '门户logo文件名称',
  `logo_text` varchar(100) NOT NULL DEFAULT '' COMMENT '门户logo文字',
  `logo_link` varchar(100) NOT NULL DEFAULT '' COMMENT '门户logo超链接地址',
  `template_id` smallint(5) unsigned NOT NULL COMMENT '门户使用的模版ID',
  `use_flag` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '启用标记(0-停用,1-启用)',
  `access_flag` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '访问权限类型(0-所有OA用户可访问, 1-无身份限制（外部人员可访问），2-指定访问权限)',
  `access_priv_dept` text NOT NULL COMMENT '有访问权限的部门ID串',
  `access_priv_priv` text NOT NULL COMMENT '有访问权限的角色ID串',
  `access_priv_user` text NOT NULL COMMENT '有访问权限的人员UID串',
  `manage_priv_user` varchar(300) NOT NULL DEFAULT '',
  PRIMARY KEY (`portal_id`) USING BTREE,
  KEY `portal_no` (`portal_no`) USING BTREE,
  KEY `template_id` (`template_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='门户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portals1`
--

LOCK TABLES `portals1` WRITE;
/*!40000 ALTER TABLE `portals1` DISABLE KEYS */;
INSERT INTO `portals1` VALUES (3,10,'总部门户',1,0,'','group','2469@1309_1231865064','logo.jpg','中国兵器工业集团公司','http://www.norincogroup.com.cn/',1,1,1,'','','',''),(4,20,'信息中心',3,1,'/general/mytable/intel_view/','mytable','','','','',0,1,0,'','','',''),(5,40,'我的桌面',5,1,'/portal/personal/','personal','','','','',0,1,0,'','','',''),(10,50,'部门门户',2,0,'','enterprise','2520@1309_729349235','logo5.png','北京通达信科科技有限公司','http://www.tongda2000.com/',2,1,0,'','','',''),(11,30,'管理中心',4,1,'/general/management_center/portal/','management_center','','','','',0,1,0,'','','','');
/*!40000 ALTER TABLE `portals1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `PRODUCT_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品类型',
  `PRODUCT_TYPE_NAME` varchar(255) NOT NULL COMMENT '商品类型名称',
  `PRODUCT_TYPE_NO` int(10) DEFAULT NULL COMMENT '商品类型编号',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`PRODUCT_TYPE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='商品类别表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propagate_position`
--

DROP TABLE IF EXISTS `propagate_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propagate_position` (
  `P_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `ORG_DEPT_ID` int(11) DEFAULT NULL COMMENT '党组织',
  `COMMUNITY_NO` varchar(255) DEFAULT '' COMMENT '场所编号',
  `ACTIVITY_PLACE` varchar(255) DEFAULT '' COMMENT '宣传场所',
  `NAME` varchar(255) DEFAULT '' COMMENT '宣传主题',
  `PLACE` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '位置',
  `AREA` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '面积',
  `APPLICATION` text COMMENT '用途',
  `REMARK1` text COMMENT '备注',
  `REMARK2` text COMMENT '经纬度',
  `REMARK3` text COMMENT '宣传内容',
  `PROPAGANDA_MODE` char(10) DEFAULT NULL COMMENT '宣传形式(SYS_CODE)',
  `ATTACHMENT_ID` text COMMENT '图片ID串',
  `ATTACHMENT_NAME` text COMMENT '图片名称串',
  `ATTACHMENT_ID2` text COMMENT '附件ID串',
  `ATTACHMENT_NAME2` text COMMENT '附件名称串',
  PRIMARY KEY (`P_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='宣传阵地表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propagate_position`
--

LOCK TABLES `propagate_position` WRITE;
/*!40000 ALTER TABLE `propagate_position` DISABLE KEYS */;
/*!40000 ALTER TABLE `propagate_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qiyeweixin_config`
--

DROP TABLE IF EXISTS `qiyeweixin_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qiyeweixin_config` (
  `corpid` varchar(255) NOT NULL DEFAULT '' COMMENT '服务商CorpID',
  `provider_secret` varchar(255) DEFAULT '' COMMENT '服务商密钥',
  `suite_id` varchar(255) DEFAULT '' COMMENT '应用id',
  `suite_secret` varchar(255) DEFAULT '' COMMENT '应用secret',
  `suite_ticket_url` varchar(255) DEFAULT '' COMMENT '企业微信后台推送ticket的url',
  `permanent_code` text COMMENT '企业微信永久授权码,最长为512字节',
  `corpsecret` varchar(255) DEFAULT '' COMMENT '应用的凭证密钥',
  `agentid` varchar(255) DEFAULT '' COMMENT '企业微信中的应用id(agentid)',
  `oa_url` varchar(255) DEFAULT '' COMMENT 'OA的访问地址',
  `API_DOMAIN` varchar(255) DEFAULT '' COMMENT '企业微信API接口域名',
  `address_secret` varchar(255) DEFAULT NULL COMMENT '通讯录密钥（操作企业微信的部门和用户需要用到）',
  PRIMARY KEY (`corpid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qiyeweixin_config`
--

LOCK TABLES `qiyeweixin_config` WRITE;
/*!40000 ALTER TABLE `qiyeweixin_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `qiyeweixin_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qr_code_login`
--

DROP TABLE IF EXISTS `qr_code_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qr_code_login` (
  `QR_CODE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `SECRET_KEY` varchar(255) NOT NULL DEFAULT '' COMMENT '密钥',
  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '用户id',
  `KEY_CREATE_TIME` datetime NOT NULL COMMENT '秘钥创建时间',
  `LOGIN_TIME` datetime DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`QR_CODE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='扫码登录记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qr_code_login`
--

LOCK TABLES `qr_code_login` WRITE;
/*!40000 ALTER TABLE `qr_code_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `qr_code_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reminders`
--

DROP TABLE IF EXISTS `reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reminders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户ID',
  `APPOINT_TIME` int(11) DEFAULT NULL COMMENT '指定日期',
  `TYPE` char(1) NOT NULL DEFAULT '' COMMENT '提醒类型(2-按日提醒,3-按周提醒,4-按月提醒,5按年提醒,6-按工作日提醒)',
  `REMIND_DATE` varchar(200) NOT NULL COMMENT '重复日期',
  `REMIND_TIME` time NOT NULL DEFAULT '00:00:00' COMMENT '重复时间',
  `TITLE` varchar(200) NOT NULL DEFAULT '' COMMENT '标题',
  `CONTENT` text NOT NULL COMMENT '事务内容 ',
  `ADD_TIME` datetime NOT NULL COMMENT '新建时间',
  `CLASSIFY` tinyint(3) unsigned NOT NULL COMMENT '提醒事务类型',
  `STATUS` int(11) NOT NULL DEFAULT '0' COMMENT '任务状态，0为执行中，1为已完成',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务中心提醒事项';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reminders`
--

LOCK TABLES `reminders` WRITE;
/*!40000 ALTER TABLE `reminders` DISABLE KEYS */;
/*!40000 ALTER TABLE `reminders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL COMMENT '活动议题',
  `undertake` varchar(100) DEFAULT NULL COMMENT '承办单位',
  `location` varchar(255) DEFAULT NULL COMMENT '活动地点',
  `attendee` varchar(255) DEFAULT NULL COMMENT '参加人员',
  `remark` tinytext COMMENT '备注',
  `leader` varchar(100) DEFAULT NULL COMMENT '领导-用于排序',
  `begin_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `create_user` int(10) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(20) DEFAULT '0' COMMENT '创建时间',
  `schedule_type` varchar(255) DEFAULT NULL COMMENT '活动类别',
  `end_time` bigint(20) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `order_no` int(11) DEFAULT NULL,
  `status` varchar(1) DEFAULT '0',
  `reason` tinytext,
  `approver` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `is_sure` int(1) DEFAULT NULL,
  `begin_date` varchar(100) DEFAULT NULL,
  `begin_period` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sd_file`
--

DROP TABLE IF EXISTS `sd_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sd_file` (
  `file_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `attachment_id` varchar(255) NOT NULL COMMENT '安全文档文件id',
  `attachment_name` varchar(255) NOT NULL DEFAULT '' COMMENT '安全文档文件名',
  `sort_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安全文档文件目录id',
  `uid` int(10) unsigned NOT NULL COMMENT '所属人uid',
  `file_size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安全文档文件字节大小',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安全文档文件创建时间',
  `module_id` tinyint(3) unsigned NOT NULL COMMENT '对应attachment_module表',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0待转化,1转化成功,2转化失败',
  PRIMARY KEY (`file_id`) USING BTREE,
  KEY `sort_id` (`sort_id`) USING BTREE,
  KEY `module_id` (`module_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='安全文档中心文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sd_file`
--

LOCK TABLES `sd_file` WRITE;
/*!40000 ALTER TABLE `sd_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `sd_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sd_sort`
--

DROP TABLE IF EXISTS `sd_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sd_sort` (
  `sort_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sort_name` varchar(255) NOT NULL DEFAULT '' COMMENT '目录名称',
  `sort_parent` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父目录id',
  `sort_no` varchar(255) NOT NULL DEFAULT '' COMMENT '目录序号',
  `uid` int(11) unsigned NOT NULL COMMENT '创建人uid',
  PRIMARY KEY (`sort_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='安全文档中心目录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sd_sort`
--

LOCK TABLES `sd_sort` WRITE;
/*!40000 ALTER TABLE `sd_sort` DISABLE KEYS */;
/*!40000 ALTER TABLE `sd_sort` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secure_key`
--

DROP TABLE IF EXISTS `secure_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secure_key` (
  `KEY_SN` varchar(20) NOT NULL COMMENT '动态密码卡卡号',
  `KEY_INFO` mediumtext NOT NULL COMMENT '动态密码卡数据',
  PRIMARY KEY (`KEY_SN`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='动态密码卡信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secure_key`
--

LOCK TABLES `secure_key` WRITE;
/*!40000 ALTER TABLE `secure_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `secure_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secure_log`
--

DROP TABLE IF EXISTS `secure_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secure_log` (
  `LOG_ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `RULE_ID` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '对应SECURE_RULE表RULE_ID',
  `UID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作人',
  `LOG_TIME` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日志时间',
  `IP` varchar(50) NOT NULL DEFAULT '' COMMENT '操作IP',
  `REMARK` varchar(1000) NOT NULL DEFAULT '' COMMENT '操作内容',
  `FROM_BODY_ID` int(10) DEFAULT '0' COMMENT '邮件审核中源邮件内容ID对应EMAIL_BODY表中的BODY_ID',
  `TO_BODY_ID` int(10) DEFAULT '0' COMMENT '邮件审核中新邮件内容ID对应EMAIL_BODY表中的BODY_ID',
  `FROM_TABLE_EXTENDS` varchar(50) NOT NULL DEFAULT '' COMMENT '邮件审核中源表的归档表的前辍',
  `TO_TABLE_EXTENDS` varchar(50) NOT NULL DEFAULT '' COMMENT '邮件审核中目标表的归档表的前辍',
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  KEY `RULE_ID` (`RULE_ID`) USING BTREE,
  KEY `UID` (`UID`) USING BTREE,
  KEY `LOG_TIME` (`LOG_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='三员安全管理日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secure_log`
--

LOCK TABLES `secure_log` WRITE;
/*!40000 ALTER TABLE `secure_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `secure_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `secure_rule`
--

DROP TABLE IF EXISTS `secure_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secure_rule` (
  `RULE_ID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '主键',
  `RULE_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT '预留',
  `RULE_PRIV` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '操作权限(1-系统管理员,2-安全员,3-审计员)',
  `RULE_DESC` varchar(250) NOT NULL DEFAULT '' COMMENT '规则描述',
  `RULE_CODE` varchar(40) NOT NULL DEFAULT '' COMMENT '规则代码:SYS_USER_EDIT-创建及修改用户;SYS_USER_BAN-是否允许用户登录系统;SYS_PRIV_EDIT-创建及修改角色信息;SYS_USER_PRIV-修改用户的角色;WORKFLOW_NORMAL-工作流业务设置修改;workflow_setuser-工作流 - 流程设计 - 经办权限;workflow_query-工作流 - 流程设计 - 管理权限（查询、监控、管理等特权权限分配）;workflow_EDITFORM-工作流 - 表单设计;WORKFLOW_SETHIDDEN-工作流 - 流程设计 - 保密字段;WORKFLOW_MANAGE-工作流 - 流程管理;USER_LOG-工作流 - 流程日志（公文起草、流转、审批环节等）;ADMIN_LOG-管理审计日志 - 系统管理员、安全管理员(71-变更邮件审核开关,72-变更用户密级,73-变更部门的邮件审核人,77-审核邮件,78-变更邮件免审人员,79-退回邮件编辑再发送,80-发送需审核邮件,81-发送免审核邮件)',
  `USE_FLAG` char(1) NOT NULL DEFAULT '1' COMMENT '使用状态(0-关闭,1-启用)',
  `SYS_RULE` char(1) NOT NULL DEFAULT '0' COMMENT '系统规则(0-否,1-是)',
  PRIMARY KEY (`RULE_ID`) USING BTREE,
  UNIQUE KEY `RULE_CODE` (`RULE_CODE`) USING BTREE,
  KEY `RULE_PRIV` (`RULE_PRIV`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='三员安全管理规则';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `secure_rule`
--

LOCK TABLES `secure_rule` WRITE;
/*!40000 ALTER TABLE `secure_rule` DISABLE KEYS */;
INSERT INTO `secure_rule` VALUES (1,'1',1,'创建及修改用户','sys_user_edit','1','1'),(2,'1',1,'是否允许用户登录系统','sys_user_ban','1','1'),(3,'1',2,'创建及修改角色信息','sys_priv_edit','1','1'),(4,'1',1,'修改用户的角色','sys_user_priv','1','1'),(5,'1',1,'工作流业务设置修改','workflow_normal','1','1'),(6,'2',2,'工作流 - 流程设计 - 经办权限','workflow_setuser','1','1'),(7,'2',2,'工作流 - 流程设计 - 管理权限（查询、监控、管理等特权权限分配）','workflow_query','1','1'),(8,'2',1,'工作流 - 表单设计','workflow_editform','1','1'),(9,'2',2,'工作流 - 流程设计 - 保密字段','workflow_sethidden','1','1'),(11,'1',3,'工作流 - 流程日志（公文起草、流转、审批环节等）','user_log','1','1'),(12,'3',3,'工作流-管理日志','admin_log','1','1');
/*!40000 ALTER TABLE `secure_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_approval`
--

DROP TABLE IF EXISTS `security_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_approval` (
  `SP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `MODULE_TABLE` varchar(50) NOT NULL COMMENT '模块主表',
  `RECORD_ID` int(11) NOT NULL COMMENT '关联模块主表中ID',
  `OPERATION_USER_ID` varchar(50) NOT NULL COMMENT '操作人USER_ID',
  `OPERATION_TIME` datetime NOT NULL COMMENT '操作时间',
  `OPERATION_CONTENT` text COMMENT '操作内容，记录操作人员填写的需要审批的操作内容，json格式',
  `OPERATION_TYPE` char(10) DEFAULT NULL COMMENT '操作类型，用于标记进行哪种操作:0表示新建，1表示编辑，2表示删除',
  `OPERATION_REASON` text COMMENT '操作原因',
  `ATTACHMENT_ID` text COMMENT '附件ID串',
  `ATTACHMENT_NAME` text COMMENT '附件文件名串',
  `APPROVER_USER_ID` varchar(50) DEFAULT NULL COMMENT '''审批人USER_ID',
  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审批时间',
  `APPROVAL_STATUS` char(10) DEFAULT NULL COMMENT '审批状态，标记审批是否通过，0为未审批，1为通过，2为拒绝',
  `APPROVAL_OPINION` text COMMENT '审批意见',
  PRIMARY KEY (`SP_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='三员安全审批表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_approval`
--

LOCK TABLES `security_approval` WRITE;
/*!40000 ALTER TABLE `security_approval` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_approval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_content_approval`
--

DROP TABLE IF EXISTS `security_content_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_content_approval` (
  `SPC_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `MODULE_TABLE` varchar(50) NOT NULL COMMENT '模块主表',
  `RECORD_ID` varchar(40) NOT NULL COMMENT '主表记录ID',
  `MODULE_NAME` varchar(250) NOT NULL COMMENT '模块',
  `DATA_SUBJECT` varchar(250) NOT NULL COMMENT '数据标题',
  `DATA_URL` varchar(250) NOT NULL COMMENT '数据详情URL',
  `OPERATION_USER_ID` varchar(50) NOT NULL COMMENT '操作人USER_ID',
  `OPERATION_TIME` datetime NOT NULL COMMENT '操作时间',
  `OPERATION_TYPE` char(10) DEFAULT NULL COMMENT '操作类型:0新建，1编辑，2删除',
  `CONTENT_SECRECY` varchar(50) DEFAULT NULL COMMENT '密级：系统代码',
  `APPROVER_USER_ID` varchar(200) DEFAULT NULL COMMENT '可审核人USER_ID串',
  `REAL_APPROVER_USER_ID` varchar(50) DEFAULT NULL COMMENT '实际审核人USER_ID',
  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审核时间',
  `APPROVAL_STATUS` char(10) DEFAULT NULL COMMENT '审核状态：0待审核，1通过，2未通过',
  `APPROVAL_OPINION` text COMMENT '审核意见',
  PRIMARY KEY (`SPC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='内容安全审核表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_content_approval`
--

LOCK TABLES `security_content_approval` WRITE;
/*!40000 ALTER TABLE `security_content_approval` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_content_approval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_log`
--

DROP TABLE IF EXISTS `security_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_log` (
  `SLOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `USER_ID` varchar(50) NOT NULL COMMENT '操作人',
  `USER_PRIV` varchar(50) DEFAULT NULL COMMENT '操作人角色',
  `MODULE` varchar(100) NOT NULL COMMENT '操作模块',
  `CONTENT` varchar(200) NOT NULL COMMENT '操作内容',
  `OPERATE_TIME` datetime NOT NULL COMMENT '操作时间',
  `ACCESS_ID` varchar(100) DEFAULT NULL COMMENT '操作记录ID',
  `PARAMETERS` text NOT NULL COMMENT '操作主要参数',
  `CLIENT_TYPE` varchar(50) DEFAULT NULL COMMENT '使用客户端（IP地址或客户端标识）',
  `REMARKS` varchar(200) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`SLOG_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='三员安全审计日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_log`
--

LOCK TABLES `security_log` WRITE;
/*!40000 ALTER TABLE `security_log` DISABLE KEYS */;
INSERT INTO `security_log` VALUES (1,'admin','1','登录系统','登录成功，用户名为系统管理员','2023-04-13 18:43:46','admin','{\"userAgent\":[\"pcc\"],\"loginId\":[\"1001\"],\"username\":[\"bzlnLyhSnqxhr6d6pex2T6FDd/Dw8AB6GSvq1bk9xtIYBW0RY1fUNuJeaMfv/EgbCbehEmheNYSjfxNcQpfLWQ==\"],\"password\":[\"ZqmH3/c78NDBTXQl4ebd1x/NNCWi9BoRtgfNNPv+XJ0+mCr73iEiQl2EwFNIzzYCCm6ZlStHjNjBLmlhIhC8bQ==\"]}','WEB: 127.0.0.1',''),(2,'admin','1','登录系统','登录成功，用户名为系统管理员','2023-06-27 17:59:24','admin','{\"userAgent\":[\"pcc\"],\"loginId\":[\"1001\"],\"username\":[\"S0gKkA7bzYAHxqCK/kINbH54xAwwN+Phdp6nzm9O6R7gr5Daoo5gEgglwU/4+ujLgwalZ70xWKswC1x265VWtw==\"],\"password\":[\"SkbqLOfkVkoGu8wOxI7tjzkdfnB7XC9tGZrrzxPQ7//xCKWYoE68C7uTH/TkL93V01WB7SwBaFEOibEPrS5MVw==\"]}','WEB: 127.0.0.1','');
/*!40000 ALTER TABLE `security_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `senior_re_cat`
--

DROP TABLE IF EXISTS `senior_re_cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `senior_re_cat` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `COLOR` varchar(255) DEFAULT NULL,
  `CAT_NAME` varchar(255) DEFAULT NULL,
  `SORT_NO` int(11) DEFAULT NULL,
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `senior_re_cat`
--

LOCK TABLES `senior_re_cat` WRITE;
/*!40000 ALTER TABLE `senior_re_cat` DISABLE KEYS */;
/*!40000 ALTER TABLE `senior_re_cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `SESS_ID` char(32) NOT NULL COMMENT 'Session ID',
  `SESS_EXPIRES` int(10) unsigned NOT NULL COMMENT 'Session过期时间',
  `SESS_DATA` varchar(5000) NOT NULL COMMENT 'Session数据',
  PRIMARY KEY (`SESS_ID`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='登录会话表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_template`
--

DROP TABLE IF EXISTS `site_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site_template` (
  `SID` int(11) NOT NULL AUTO_INCREMENT,
  `SITE_ID` int(11) DEFAULT NULL,
  `TPL_DESC` varchar(255) DEFAULT NULL COMMENT '模板描述',
  `TPL_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '模板文件名称',
  `TPL_NAME` varchar(255) DEFAULT NULL COMMENT '模板名称',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_template`
--

LOCK TABLES `site_template` WRITE;
/*!40000 ALTER TABLE `site_template` DISABLE KEYS */;
INSERT INTO `site_template` VALUES (1,1,'首页概览','index.html','门户首页'),(5,2,'','index.html','首页模板'),(6,2,'','newsIndex.html','新闻栏目模板'),(7,2,'','newsDetail.html','详情模板'),(8,2,'','detail.html','详情页面'),(9,2,'','list.html','列表页'),(10,1,'','news_list.html','新闻栏目概览'),(11,1,'','news_detail.html','新闻栏目细览'),(12,1,'','quanjing.html','全景概览'),(13,1,'','service.html','公共服务概览'),(14,1,'','ia.html','交流互动概览'),(15,1,'','department.html','政府部门概览');
/*!40000 ALTER TABLE `site_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `SMS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `TO_ID` varchar(40) NOT NULL COMMENT '收信人USER_ID',
  `REMIND_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '接收标记(0-已阅读,1-未阅读,2-未阅读已弹出)',
  `DELETE_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记(0-没删除,1-收信人删除,2-发信人删除)',
  `BODY_ID` int(11) NOT NULL DEFAULT '0' COMMENT 'SMS_BODY表对应记录的BODY_ID',
  `REMIND_TIME` int(11) NOT NULL DEFAULT '0' COMMENT '最近一次提醒时间',
  UNIQUE KEY `ID` (`SMS_ID`) USING BTREE,
  KEY `BODY_ID` (`BODY_ID`) USING BTREE,
  KEY `REMIND_TIME` (`REMIND_TIME`) USING BTREE,
  KEY `TO_AND_BODY` (`TO_ID`,`BODY_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='内部短信记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms2`
--

DROP TABLE IF EXISTS `sms2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms2` (
  `SMS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '发送人用户ID',
  `PHONE` varchar(20) NOT NULL DEFAULT '' COMMENT '接收人手机号',
  `CONTENT` text NOT NULL COMMENT '短信内容',
  `SEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发送时间',
  `SEND_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '短信发送状态(0-未发送,1-发送成功,2-发送超时请人工确认,3-发送中)',
  `SEND_NUM` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '短信发送数量',
  `TO_ID` varchar(50) DEFAULT NULL COMMENT '接收人用户ID',
  `MODULE_ID` varchar(20) DEFAULT NULL COMMENT '模块ID（与事务提醒设置模块ID一致）',
  `DATA_ID` varchar(50) DEFAULT NULL COMMENT '短信对应的模块数据主键',
  PRIMARY KEY (`SMS_ID`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `PHONE` (`PHONE`) USING BTREE,
  KEY `SEND_TIME` (`SEND_TIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='手机短信表（发送）';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms2`
--

LOCK TABLES `sms2` WRITE;
/*!40000 ALTER TABLE `sms2` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms2_priv`
--

DROP TABLE IF EXISTS `sms2_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms2_priv` (
  `TYPE_PRIV` text NOT NULL COMMENT '模块权限',
  `REMIND_PRIV` text NOT NULL COMMENT '被提醒权限',
  `OUT_PRIV` text NOT NULL COMMENT '外发权限',
  `SMS2_REMIND_PRIV` text NOT NULL COMMENT '提醒权限',
  `OUT_TO_SELF` char(1) NOT NULL DEFAULT '0' COMMENT '是否允许给自己发送手机短信(0-不允许,1-允许)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='手机短信权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms2_priv`
--

LOCK TABLES `sms2_priv` WRITE;
/*!40000 ALTER TABLE `sms2_priv` DISABLE KEYS */;
INSERT INTO `sms2_priv` VALUES ('1,2,5,7','admin,','admin,','','0');
/*!40000 ALTER TABLE `sms2_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_body`
--

DROP TABLE IF EXISTS `sms_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_body` (
  `BODY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_ID` varchar(40) NOT NULL COMMENT '发信人USER_ID',
  `SMS_TYPE` varchar(200) NOT NULL DEFAULT '' COMMENT '短信类型',
  `CONTENT` text NOT NULL COMMENT '短信内容',
  `SEND_TIME` int(10) unsigned NOT NULL COMMENT '发送时间',
  `REMIND_URL` varchar(255) NOT NULL DEFAULT '' COMMENT '相关的URL',
  `IS_ATTACH` varchar(255) DEFAULT NULL COMMENT '附件标识',
  PRIMARY KEY (`BODY_ID`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `SMS_TYPE` (`SMS_TYPE`) USING BTREE,
  KEY `SEND_TIME_2` (`SEND_TIME`) USING BTREE,
  KEY `BODY_ID` (`BODY_ID`) USING BTREE,
  KEY `REMIND_URL` (`REMIND_URL`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='内部短信主体表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_body`
--

LOCK TABLES `sms_body` WRITE;
/*!40000 ALTER TABLE `sms_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_settings`
--

DROP TABLE IF EXISTS `sms_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_settings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `NAME` varchar(255) DEFAULT NULL COMMENT '网关名称',
  `PROTOCOL` varchar(255) DEFAULT NULL COMMENT '协议',
  `HOST` varchar(255) DEFAULT NULL COMMENT '主机',
  `PORT` varchar(255) DEFAULT '' COMMENT '接口',
  `USERNAME` varchar(255) DEFAULT '' COMMENT '账号参数名',
  `PWD` varchar(255) DEFAULT NULL COMMENT '密码参数名',
  `CONTENT_FIELD` varchar(255) DEFAULT NULL COMMENT '内容字段参数名',
  `CODE` varchar(255) DEFAULT NULL COMMENT '内容编码参数名',
  `MOBILE` varchar(255) DEFAULT NULL COMMENT '接收号码参数名',
  `TIME_CONTENT` varchar(20) DEFAULT NULL,
  `SIGN` varchar(255) DEFAULT NULL COMMENT '签名参数名',
  `LOCATION` varchar(100) DEFAULT NULL COMMENT '签名位置',
  `EXTEND_1` varchar(255) DEFAULT '' COMMENT '扩展参数1:',
  `EXTEND_2` varchar(255) DEFAULT NULL COMMENT '扩展参数2:',
  `EXTEND_3` varchar(255) DEFAULT NULL COMMENT '扩展参数3',
  `EXTEND_4` varchar(255) DEFAULT NULL COMMENT '扩展参数4',
  `EXTEND_5` varchar(255) DEFAULT NULL COMMENT '扩展参数5',
  `STATE` varchar(100) DEFAULT '' COMMENT '状态',
  `SIGN_VALUE` varchar(50) DEFAULT NULL COMMENT '签名参数值',
  `SIGN_POSITION` char(10) DEFAULT '0' COMMENT '短信内容中加入签名的位置(0-不加人，1-开头加入签名，2-结尾加入签名)',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_settings`
--

LOCK TABLES `sms_settings` WRITE;
/*!40000 ALTER TABLE `sms_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `srms_pj_project`
--

DROP TABLE IF EXISTS `srms_pj_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `srms_pj_project` (
  `ID` varchar(36) NOT NULL COMMENT '主键ID',
  `PJ_NAME` varchar(500) DEFAULT NULL COMMENT '课题名称',
  `PJ_NUMBER` varchar(500) DEFAULT NULL COMMENT '课题编号',
  `PJ_CLASS` varchar(1) DEFAULT NULL COMMENT '课题归属类型（1、公司科技项目；2、示范科技项目）',
  `PJ_YEAR` decimal(11,0) DEFAULT NULL COMMENT '申请年度',
  `PJ_PUNIT` varchar(500) DEFAULT NULL COMMENT '申请单位',
  `PJ_CDATE` date DEFAULT NULL COMMENT '录入时间',
  `PJ_ORGID` varchar(60) DEFAULT NULL COMMENT '录入单位ID',
  `PJ_USERID` varchar(60) DEFAULT NULL COMMENT '录入人ID',
  `PJ_SENDEE` varchar(60) DEFAULT NULL COMMENT '录入人姓名',
  `PJ_AUTHOR` varchar(255) DEFAULT NULL COMMENT '课题负责人姓名',
  `PJ_AUNIT` varchar(500) DEFAULT NULL COMMENT '承担单位',
  `PJ_AGE` int(11) DEFAULT NULL COMMENT '年龄',
  `PJ_PROFESSION` varchar(255) DEFAULT NULL COMMENT '专业',
  `PJ_JOBPOST` varchar(255) DEFAULT NULL COMMENT '职称',
  `PJ_PTYPE` varchar(255) DEFAULT NULL COMMENT '课题分类',
  `PJ_SQDATE` date DEFAULT NULL COMMENT '申请日期',
  `PJ_ADDRESS` varchar(500) DEFAULT NULL COMMENT '通信地址',
  `PJ_POST` varchar(255) DEFAULT NULL COMMENT '邮政编码',
  `PJ_PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `PJ_PCTIME` date DEFAULT NULL COMMENT '项目申报日期',
  `PJ_TEAMUNIT` varchar(500) DEFAULT NULL COMMENT '协作单位',
  `PJ_PSTIME` date DEFAULT NULL COMMENT '开始时间',
  `PJ_PETIME` date DEFAULT NULL COMMENT '结束时间',
  `PJ_PJALL` int(11) DEFAULT NULL COMMENT '课题组人员总数',
  `PJ_HP` int(11) DEFAULT NULL COMMENT '正高级人数',
  `PJ_LP` int(11) DEFAULT NULL COMMENT '高级人数',
  `PJ_RP` int(11) DEFAULT NULL COMMENT '中级人数',
  `PJ_NEWP` int(11) DEFAULT NULL COMMENT '初级人数',
  `PJ_RMONEY` int(15) DEFAULT NULL COMMENT '资助资金',
  `PJ_STATE` varchar(255) DEFAULT NULL COMMENT '状态(申报:1,审核中:2,退回中:3:初审通过:5:予以立项:6,不予以立项:4)',
  `PJ_IMBURSE` int(15) DEFAULT NULL COMMENT '资助金额',
  `PJ_IMBURSECOMMENT` varchar(4000) DEFAULT NULL COMMENT '资助金额备注',
  `PJ_SELFFUNDS` int(15) DEFAULT NULL COMMENT '自筹资金',
  `PJ_SELFFCOMMENT` varchar(4000) DEFAULT NULL COMMENT '自筹资金备注',
  `PJ_AUDITORG` varchar(255) DEFAULT NULL COMMENT '审批单位',
  `PJ_ORGNAME` varchar(500) DEFAULT NULL COMMENT '录入单位名称',
  `PJ_VERIFYID` varchar(255) DEFAULT NULL COMMENT '审批ID',
  `PJ_ASDATE` date DEFAULT NULL COMMENT '协作单位开始时间',
  `PJ_AEDATE` date DEFAULT NULL COMMENT '协作单位结束时间',
  `PROCESSINSTID` int(18) DEFAULT NULL COMMENT '流程实例id',
  `PROCESSSTATUS` int(18) DEFAULT NULL COMMENT '流程状态',
  `PJ_DEPEND` varchar(600) DEFAULT NULL COMMENT '依托工程',
  `PJ_OTHER` int(7) DEFAULT NULL COMMENT '其他人数',
  `PJ_USER_UNIT` varchar(500) DEFAULT NULL,
  `PJ_PLOT_ID` varchar(255) DEFAULT NULL COMMENT '项目策划id',
  `PJ_SEX` varchar(1) DEFAULT NULL,
  `PJ_CO_PERSON` varchar(255) DEFAULT NULL COMMENT '协办负责人',
  `PJ_CO_PERSON_ID` varchar(255) DEFAULT NULL COMMENT '协办负责人id',
  `EPS_NAME` varchar(500) DEFAULT NULL,
  `EPS_CODE` varchar(255) DEFAULT NULL COMMENT '企业项目名称',
  `PLOT_NAME` varchar(500) DEFAULT NULL COMMENT '项目策划名称',
  `DSP_STATE` varchar(255) DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='科创系统项目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `srms_pj_project`
--

LOCK TABLES `srms_pj_project` WRITE;
/*!40000 ALTER TABLE `srms_pj_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `srms_pj_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_activity`
--

DROP TABLE IF EXISTS `subject_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subject_activity` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',
  `COMMUNITY` varchar(255) DEFAULT NULL COMMENT '活动地点',
  `SUBJECT_TIME` datetime DEFAULT NULL COMMENT '活动主题时间',
  `SUBJECT` varchar(255) DEFAULT NULL COMMENT '活动主题',
  `SUBJECT_CONTENT` text COMMENT '活动内容',
  `JOIN_NUM` varchar(255) DEFAULT NULL COMMENT '参加人数',
  `ATTACHMENT_ID` text COMMENT '照片ID串',
  `ATTACHMENT_NAME` text COMMENT '照片名称串',
  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',
  `ORGANIZE` varchar(255) DEFAULT NULL COMMENT '活动党组织',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(255) DEFAULT NULL COMMENT '创建人',
  `ATTACHMENT_ID2` text COMMENT '附件ID串',
  `ATTACHMENT_NAME2` text COMMENT '附件名称串',
  `PARTY_EDU_TYPE` char(10) DEFAULT NULL COMMENT '主题教育类型(SYS_CODE)',
  `TEST_URL` varchar(255) DEFAULT NULL COMMENT '答题链接地址(考试试题URL)',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='主题教育活动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_activity`
--

LOCK TABLES `subject_activity` WRITE;
/*!40000 ALTER TABLE `subject_activity` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_assist`
--

DROP TABLE IF EXISTS `sup_assist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_assist` (
  `sup_id` int(11) DEFAULT NULL COMMENT '督办ID',
  `assist_id` int(11) DEFAULT NULL COMMENT '督办任务ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_assist`
--

LOCK TABLES `sup_assist` WRITE;
/*!40000 ALTER TABLE `sup_assist` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_assist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_feed_back`
--

DROP TABLE IF EXISTS `sup_feed_back`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_feed_back` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `level_` int(11) DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  `creater_id` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `ATTACHMENT_ID` varchar(225) DEFAULT NULL,
  `ATTACHMENT_NAME` varchar(225) DEFAULT NULL,
  `PROGRESS_RATE` int(3) DEFAULT NULL COMMENT '进度百分比(0-100)%',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_feed_back`
--

LOCK TABLES `sup_feed_back` WRITE;
/*!40000 ALTER TABLE `sup_feed_back` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_feed_back` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_feed_back_reply`
--

DROP TABLE IF EXISTS `sup_feed_back_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_feed_back_reply` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `fb_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `creater_id` varchar(11) DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_feed_back_reply`
--

LOCK TABLES `sup_feed_back_reply` WRITE;
/*!40000 ALTER TABLE `sup_feed_back_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_feed_back_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_type_dept_priv`
--

DROP TABLE IF EXISTS `sup_type_dept_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_type_dept_priv` (
  `type_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_type_dept_priv`
--

LOCK TABLES `sup_type_dept_priv` WRITE;
/*!40000 ALTER TABLE `sup_type_dept_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_type_dept_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_type_role_priv`
--

DROP TABLE IF EXISTS `sup_type_role_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_type_role_priv` (
  `type_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_type_role_priv`
--

LOCK TABLES `sup_type_role_priv` WRITE;
/*!40000 ALTER TABLE `sup_type_role_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_type_role_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_type_user_priv`
--

DROP TABLE IF EXISTS `sup_type_user_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_type_user_priv` (
  `type_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_type_user_priv`
--

LOCK TABLES `sup_type_user_priv` WRITE;
/*!40000 ALTER TABLE `sup_type_user_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_type_user_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sup_urge`
--

DROP TABLE IF EXISTS `sup_urge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sup_urge` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `creater_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `is_include_children` int(11) DEFAULT NULL,
  `sup_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sup_urge`
--

LOCK TABLES `sup_urge` WRITE;
/*!40000 ALTER TABLE `sup_urge` DISABLE KEYS */;
/*!40000 ALTER TABLE `sup_urge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervision`
--

DROP TABLE IF EXISTS `supervision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervision` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',
  `sup_name` varchar(255) DEFAULT NULL COMMENT '督办名称',
  `type_id` int(11) DEFAULT NULL COMMENT '督办类型ID',
  `leader_id` varchar(100) DEFAULT NULL COMMENT '责任领导人ID',
  `manager_id` varchar(11) DEFAULT NULL COMMENT '主办人ID',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `begin_time` datetime DEFAULT NULL COMMENT '开始时间',
  `content` varchar(255) DEFAULT NULL COMMENT '督办内容',
  `creater_id` varchar(255) DEFAULT NULL COMMENT '创建人ID',
  `creater_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT NULL COMMENT '督办状态（0-未发布1-代签收2-正常办理中3-逾期办理中4-已暂停5-正常已办结6-逾期已办结）',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID',
  `real_end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `dept_id` varchar(11) DEFAULT NULL COMMENT '部门ID',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `role_id` varchar(255) DEFAULT NULL COMMENT '角色ID',
  `attment_id` varchar(255) DEFAULT NULL COMMENT '附件信息',
  `attment_name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `assist_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervision`
--

LOCK TABLES `supervision` WRITE;
/*!40000 ALTER TABLE `supervision` DISABLE KEYS */;
/*!40000 ALTER TABLE `supervision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervision_apply`
--

DROP TABLE IF EXISTS `supervision_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervision_apply` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',
  `status` int(11) DEFAULT NULL COMMENT '申请状态（0-不同意 1-同意）',
  `content` varchar(255) DEFAULT NULL COMMENT '督办内容',
  `type` int(11) DEFAULT NULL COMMENT '督办类型\r\n1-暂停 2-办理 3-办结 4-催办',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `reason` varchar(255) DEFAULT NULL COMMENT '原因',
  `creater_id` varchar(255) DEFAULT NULL COMMENT '创建人ID',
  `sup_id` int(11) DEFAULT NULL COMMENT '督办ID',
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervision_apply`
--

LOCK TABLES `supervision_apply` WRITE;
/*!40000 ALTER TABLE `supervision_apply` DISABLE KEYS */;
/*!40000 ALTER TABLE `supervision_apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervision_type`
--

DROP TABLE IF EXISTS `supervision_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervision_type` (
  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',
  `type_name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序号',
  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID',
  `user_id` text,
  PRIMARY KEY (`sid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervision_type`
--

LOCK TABLES `supervision_type` WRITE;
/*!40000 ALTER TABLE `supervision_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `supervision_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_code`
--

DROP TABLE IF EXISTS `sys_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_code` (
  `CODE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `CODE_NO` varchar(200) NOT NULL DEFAULT '' COMMENT '代码编号',
  `CODE_NAME` varchar(200) NOT NULL COMMENT '代码名称',
  `CODE_NAME1` varchar(200) DEFAULT NULL,
  `CODE_NAME2` varchar(200) DEFAULT NULL,
  `CODE_NAME3` varchar(200) DEFAULT NULL,
  `CODE_NAME4` varchar(200) DEFAULT NULL,
  `CODE_NAME5` varchar(200) DEFAULT NULL,
  `CODE_NAME6` varchar(200) DEFAULT NULL,
  `CODE_ORDER` varchar(200) NOT NULL DEFAULT '' COMMENT '排序号',
  `PARENT_NO` varchar(200) NOT NULL DEFAULT '' COMMENT '代码主分类',
  `CODE_FLAG` varchar(20) NOT NULL DEFAULT '1' COMMENT '代码标记(0-不能删除,1-可删除)',
  `CODE_EXT` varchar(600) NOT NULL COMMENT '国际版多语言代码名称',
  `IS_CAN` varchar(50) NOT NULL DEFAULT '1' COMMENT '是否允许事务提醒开关 （1-允许，0-不允许）',
  `IS_IPHONE` varchar(50) NOT NULL DEFAULT '1' COMMENT '手机短信默认提醒（1提醒0不提醒）',
  `IS_REMIND` varchar(50) CHARACTER SET utf8mb4 NOT NULL DEFAULT '1' COMMENT '事务提醒开关 （1-开，0-关）',
  PRIMARY KEY (`CODE_ID`) USING BTREE,
  KEY `CODE_ORDER` (`CODE_ORDER`) USING BTREE,
  KEY `PARENT_AND_CODE_NO` (`PARENT_NO`,`CODE_NO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4251 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统代码设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_code`
--

LOCK TABLES `sys_code` WRITE;
/*!40000 ALTER TABLE `sys_code` DISABLE KEYS */;
INSERT INTO `sys_code` VALUES (20,'NOTIFY','公告通知类型','NOTICE_TYPE','公告通知類型','公告通知タイプ','ຮູບແບບສະຖານະຂໍ້ມູນ',NULL,NULL,'0512','','1','','1','1','1'),(21,'NEWS','新闻类型','NEWS_TYPE','新聞類型','ニュースの種類','ຮູບແບບຂ່າວ',NULL,NULL,'0513','','1','','1','1','1'),(22,'SYS_LOG','系统日志类型','SYS_LOG_TYPE','系統日誌類型','システムログタイプ','ຮູບແບບຂອງ ລະບົບ',NULL,NULL,'2028','','1','','1','1','1'),(23,'1','登录日志','LOGIN_LOG','登入日誌','ログインログ','ໂປຣເເກຣມໂປຣເເກຣມ',NULL,NULL,'01','SYS_LOG','1','','1','1','1'),(24,'2','登录密码错误','LOGIN_PASSWORD_ERROR','登入密碼錯誤','ログインパスワードエラー','ລະຫັດຜ່ອນລະຫັດຜ່ານ',NULL,NULL,'02','SYS_LOG','1','','1','1','1'),(25,'3','添加部门','ADD_DEPT','添加部門','部門の追加','ເພີ່ມໂປຣເເກຣມ',NULL,NULL,'03','SYS_LOG','1','','1','1','1'),(26,'4','编辑部门','EDIT_DEPT','編輯部門','部門の編集','ໂປຣແກຣມເຄື່ອງມືແກ້ໄຂລາຍການແບບງ່າຍ%s',NULL,NULL,'04','SYS_LOG','1','','1','1','1'),(27,'5','删除部门','DELETE_DEPT','删除部門','部門の削除','ລຶບບ',NULL,NULL,'05','SYS_LOG','1','','1','1','1'),(28,'6','添加用户','ADD_USER','添加用戶','ユーザーの追加','ເພີ້ມລະບົບ',NULL,NULL,'06','SYS_LOG','1','','1','1','1'),(29,'7','编辑用户','EDIT_USER','編輯用戶','ユーザーの編集','ແກ້ໄຂລະບົບ',NULL,NULL,'07','SYS_LOG','1','','1','1','1'),(30,'8','删除用户','DELETE_USER','删除用戶','ユーザーの削除','ລຶບບັນຊີໃຊ້',NULL,NULL,'08','SYS_LOG','1','','1','1','1'),(31,'9','非法IP登录','LOGIN_IP_ERROR','非法IP登入','不正なIPログイン','ຕິດຕັ້ງຂໍ້ມູນ',NULL,NULL,'09','SYS_LOG','1','','1','1','1'),(32,'10','错误用户名','USER_NAME_ERROR','錯誤用戶名','エラーユーザ名','ຊື່ເເຟ້ມຊື່ທີ່ໃຊ້ບໍ່ໄດ້',NULL,NULL,'101','SYS_LOG','1','','1','1','1'),(33,'11','admin清空密码1','DROP_PASSWORD','admin清空密碼1','adminクリアパスワード1','ເບີ່ງເເຍງລະບົບ, ລະຫັດຜ່ານ 1',NULL,NULL,'1122','SYS_LOG','1','','1','1','1'),(34,'12','系统资源回收','SYS_RESOURCE_RECOVERY','系統資源回收','システム資源回収','ເຄື່ອງມືອຄຳນົດເເອນລະບົບ',NULL,NULL,'12','SYS_LOG','1','','1','1','1'),(36,'14','修改登录密码','EDIT_PASSWORD','修改登入密碼','ログインパスワードの変更','ກະລຸນາປ່ຽນລະຫັດຜ່ານ',NULL,NULL,'14','SYS_LOG','1','','1','1','1'),(39,'15','公告通知管理','NOTICE_MANAGE','公告通知管理','公告通知管理','ຂໍ້ມູນ ແລະ ເບີ່ງເເຍງລະບົບ',NULL,NULL,'15','SYS_LOG','1','','1','1','1'),(135,'DIARY_TYPE','工作日志类型','DIARY_TYPE','工作日志類型','作業ログタイプ','ຮູບແບບສຳລັບ',NULL,NULL,'012832','','1','','1','1','1'),(136,'1','工作日志','WORK_LOG','工作日志','作業ログ','ໂປຣເເກຣມເຄື່ອງມືອງ',NULL,NULL,'01','DIARY_TYPE','1','','1','1','1'),(137,'2','个人日志','PERSON_LOG','個人日誌','個人ログ','ໂປຣເເກຣມສຳລັບເຄື່ອງສ່ວນຕົວ',NULL,NULL,'02','DIARY_TYPE','1','','1','1','1'),(158,'16','公共文件柜','Public File Cabinet','公共文件櫃','パブリックキャビネット','ທົດລະບຽບສຳລັບສາທາລະນະ',NULL,NULL,'16','SYS_LOG','1','','1','1','1'),(159,'17','网络硬盘','Network hard disk','網路硬碟','ネットワークハードディスクドライブ','hard',NULL,NULL,'17','SYS_LOG','1','','1','1','1'),(160,'18','软件注册','Software Registration','軟件注册','ソフトウェア登録','ໂປຣເເກຣມແກຣມ',NULL,NULL,'18','SYS_LOG','1','','1','1','1'),(161,'19','用户批量设置','User Batch Settings','用戶批量設定','ユーザーの一括設定','ຕັ້ງຄ່າຈຳນວຍຄວາມສະດວກຜູ້ໃຊ້',NULL,NULL,'19','SYS_LOG','1','','1','1','1'),(220,'22','退出系统','Exit','退出系統','システムを終了する','ກຳລັງອອກລະບົບ',NULL,NULL,'22','SYS_LOG','1','','1','1','1'),(545,'02','决定','Decisions','决定','に決心させる','ຕັ້ງຄ່າ',NULL,NULL,'02','NOTIFY','1','','1','1','1'),(546,'01','通知','Notice','通知','に知らせる','ຂໍ້ມູນ',NULL,NULL,'01','NOTIFY','1','','1','1','1'),(547,'03','通报','Bulletin','通報','つうしん','ຂໍ້ມູນ',NULL,NULL,'03','NOTIFY','1','','1','1','1'),(548,'04','其他','Other','其他','その他','ອື່ນ ໆ',NULL,NULL,'04','NOTIFY','1','','1','1','1'),(549,'01','公司动态','Company News','公司動態','企業の動向','ຂ່າວິລະຄວສັດ',NULL,NULL,'01','NEWS','1','','1','1','1'),(550,'02','媒体关注','Media attention','媒體關注','メディア・ウォッチ','ລາຍການສືປະສົມ',NULL,NULL,'02','NEWS','1','','1','1','1'),(551,'03','行业资讯','Industry News','行業資訊','業界情報','ຂ່າວິທະຍາສາດການຄ້າ',NULL,NULL,'03','NEWS','1','','1','1','1'),(552,'04','合作伙伴新闻','Partner news','合作夥伴新聞','パートナーのニュース','ຂ່າວ່າ',NULL,NULL,'04','NEWS','1','','1','1','1'),(553,'05','客户新闻','Customer news','客戶新聞','お客様のニュース','ຂ່າວ່າ ໂປຣເເກຣມ',NULL,NULL,'05','NEWS','1','','1','1','1'),(643,'34224','新闻','Journalism','新聞','ニュース','ວິທະຍາສາດການເມືອງ',NULL,NULL,'444332','NEWS','1','','1','1','1'),(684,'HR_ENTERPRISE','合同签约公司','Contract signing company','契约簽約公司','契約会社','ບໍລິສັນຍ່າງພາຍໃຕ້',NULL,NULL,'100','','1','','1','1','1'),(685,'1','北京某某某软件有限公司','Beijing Moumou Software Co., Ltd','北京某某某軟件有限公司','北京某某ソフトウェア有限会社','ໂປຣແກຣມແກຣມສຳລັບເເກຣມປິກລະດູຮ້ອນໂປຣເເກຣມ ອິກລະດູຮ້ອນ ອິກລະດູຮ້ອນໂປຣເເກຣມ',NULL,NULL,'1','HR_ENTERPRISE','1','','1','1','1'),(687,'FLOWTYPE','流程分类','Process classification','流程分類','プロセス分類','ຜລງານ',NULL,NULL,'1','','1','','1','1','1'),(689,'DOCUMENTTYPE','公文','Document','公文','公文書','ໂປຣເເກຣມ',NULL,NULL,'1','FLOWTYPE','1','','1','1','1'),(690,'PTTYPE','普通','ordinary','普通','標準','ປົກຕິ',NULL,NULL,'2','FLOWTYPE','1','','1','1','1'),(693,'KQQJTYPE','考勤流程','Attendance process','考勤流程','勤務評定の流れ','ຂະບວນການຕ່າງໆ',NULL,NULL,'1','FLOWTYPE','1','','1','1','1'),(694,'140','请假申请','Leave application','請假申請','休暇申請','ລຶກໂປຣເເກຣມ',NULL,NULL,'1','KQQJTYPE','1','','1','1','1'),(712,'SMS_REMIND','提醒类型','Reminder type','提醒類型','アラームのタイプ','ເຂດຂໍ້ມູນ',NULL,NULL,'010802','','1','','1','1','1'),(713,'0','系统类型','System type','系統類型','システムタイプ','ຮູບແບບລະບົບ',NULL,NULL,'01','SMS_REMIND','1','','1','1','1'),(714,'1','公告通知','Announcement Notice','公告通知','公告通知','ຂໍ້ມູນເເຕັບສຳຫລັນ',NULL,NULL,'02','SMS_REMIND','1','','1','1','1'),(715,'2','电子邮件','E-mail','電子郵件','Eメール','ອີເມວລ໌',NULL,NULL,'03','SMS_REMIND','1','','1','1','1'),(716,'3','网络会议','Online Meeting','網路會議','Web会議','ກອງປະຊຸມຄູ່ສົນທະນາ',NULL,NULL,'04','SMS_REMIND','1','','1','1','1'),(717,'4','工资上报','Salary reporting','薪水上報','賃金上申','ຂໍ້ມູນເພີ້ມຄວາມສະດວກ',NULL,NULL,'05','SMS_REMIND','1','','1','1','1'),(718,'5','日程安排','Schedule arrangement','排程','スケジュール','ສະຖານະການຖ້າ',NULL,NULL,'06','SMS_REMIND','1','','1','1','1'),(719,'6','考勤批示','Attendance instructions','考勤批示','勤務評定の指示.','ຕົວເຕັດຜ່ອນຄວາມສະດວກຕ່າງໆ',NULL,NULL,'07','SMS_REMIND','1','','1','1','1'),(720,'7','工作流：提醒下一步经办人','Workflow: Remind the next handler','工作流：提醒下一步經辦人','ワークフロー：次の担当者に注意する','ກຳລັງອອກດ້ວຍຄວາມຈຳ: ຈຶດເຈົ້າກັບຄຳລັບຄຳລັບ',NULL,NULL,'08','SMS_REMIND','1','','1','0','1'),(721,'8','会议申请','Meeting application','會議申請','会議の申し込み','ໂປຣເເກຣມຄູ່ສົນທະນາ',NULL,NULL,'09','SMS_REMIND','1','','1','1','1'),(722,'9','车辆申请','Vehicle application','車輛申請','車両申請','ໂປຣເເກຣມທົວໄປ',NULL,NULL,'10','SMS_REMIND','1','','1','1','1'),(723,'10','手机短信','Mobile SMS','手機短信','携帯メール','ສູງຂໍ້ມູນ',NULL,NULL,'11','SMS_REMIND','1','','1','1','1'),(724,'11','投票提醒','Voting reminder','投票提醒','投票の注意','ຄ່າຂໍ້ມູນກ່ຽວກັບ',NULL,NULL,'12','SMS_REMIND','1','','1','1','1'),(725,'12','工作计划','Work Plan','工作計畫','作業計画','ໂປຣເເກຣມ',NULL,NULL,'13','SMS_REMIND','1','','1','1','1'),(726,'13','工作日志','Work log','工作日志','作業ログ','ໂປຣເເກຣມເຄື່ອງມືອງ',NULL,NULL,'14','SMS_REMIND','1','','1','1','1'),(727,'14','新闻','Journalism','新聞','ニュース','ວິທະຍາສາດການເມືອງ',NULL,NULL,'15','SMS_REMIND','1','','1','1','1'),(728,'15','考核','assessment','考核','レビュー','ການສຶກສາ',NULL,NULL,'16','SMS_REMIND','1','','1','1','1'),(729,'16','公共文件柜','Public filing cabinet','公共文件櫃','パブリックキャビネット','ທົດລະບຽບສຳລັບສາທາລະນະ',NULL,NULL,'17','SMS_REMIND','1','','1','1','1'),(730,'17','网络硬盘','Network hard drive','網路硬碟','ネットワークハードディスクドライブ','hard',NULL,NULL,'18','SMS_REMIND','1','','1','1','1'),(731,'40','工作流：提醒流程发起人','Workflow: Remind the initiator of the process','工作流：提醒流程發起人','ワークフローわーくふろー：リマインダプロセスの開始者','ກຳລັງສຳລັບ: ຈົດເຈື່ອເລີ້ມໂປຣເຊດຍ່າງ',NULL,NULL,'0801','SMS_REMIND','1','','1','0','0'),(732,'41','工作流：提醒流程所有人员','Workflow: Remind all personnel involved in the process','工作流：提醒流程所有人員','ワークフローわーくふろー：リマインダプロセスのすべてのユーザ','ສິ່ງອຳນວຍຄວາມສະດວກ: ຈົດເພື່ອຈົດການວນຕ່າງໆທີ່ກ່ຽວຂ້ອງກັບ',NULL,NULL,'0802','SMS_REMIND','1','','1','0','0'),(733,'18','内部讨论区','Internal discussion area','內部討論區','内部ディスカッション領域','ພື້ນທີ່ກ່ຽວຂ້ອງພາຍນອກ',NULL,NULL,'19','SMS_REMIND','1','','1','1','1'),(734,'19','工资条','Salary slip','工資條','給与明細','ຈົດເຊື້ອຫາຍໂກ',NULL,NULL,'20','SMS_REMIND','1','','1','1','1'),(735,'20','个人文件柜','Personal file cabinet','個人文件櫃','パーソナルキャビネット','ໂປຣເເກຣມແຟ້ມສ່ວນຕົວ',NULL,NULL,'21','SMS_REMIND','1','','1','1','1'),(736,'22','审核提醒','Audit Reminder','稽核提醒','レビューのリマインダ','ຈຸດເຊື່ອນໄຫວ',NULL,NULL,'23','SMS_REMIND','1','','1','1','1'),(741,'70','公文管理','Official document management','公文管理','公文書管理','ເບີ່ງເເຍງລະບົບຫ້ອງການ',NULL,NULL,'70','SMS_REMIND','1','','1','1','1'),(742,'OFFICE_TEMPLATE_CATEGORY','模板分类','Template classification','範本分類','テンプレート分類','ຄ່າຂອງເຫລວດ້ອມ',NULL,NULL,'100','','1','','1','1','1'),(743,'1','正文模板','Text Template','正文範本','テキストテンプレート','ຮູບແບບ່ມຄຳສັ່ງ',NULL,NULL,'1','OFFICE_TEMPLATE_CATEGORY','1','','1','1','1'),(744,'2','套红模板','Red Template','套紅範本','カラーテンプレート','ເມວລູກໃກ້ດິນ',NULL,NULL,'2','OFFICE_TEMPLATE_CATEGORY','1','','1','1','1'),(745,'142','出差申请','Business trip application','出差申請','出張申請','ໂປຣມແກຣມສຳລັບຫ້າອິລະກິດ',NULL,NULL,'142','KQQJTYPE','1','','1','1','1'),(746,'143','外出申请','Application for Going Out','外出申請','外出申請','ໂປຣເເກຣມທົວໄປ',NULL,NULL,'143','KQQJTYPE','1','','1','1','1'),(918,'TYPE','类型','type','類型','を選択してオプションを設定します。','ເະນິດ',NULL,NULL,'','','1','','1','1','1'),(919,'0','单选','Single Choice','單選','単一選択','ໂຕເລືອກທີ່ສຸດ',NULL,NULL,'0','TYPE','1','','1','1','1'),(920,'1','多选','Multiple Choice','多選','複数選択','ຜລງານ',NULL,NULL,'1','TYPE','1','','1','1','1'),(921,'2','文本输入','Text input','文字輸入','テキスト入力','ຊ່ວຍເລກຄຳສັ່ງ',NULL,NULL,'2','TYPE','1','','1','1','1'),(922,'VIEW_PRIV','查看投票结果选项','View Voting Results Options','查看投票結果選項','投票結果の表示オプション','ສະນົບໂຕເລືອກທີ່ບັນຫາການເກີອກ',NULL,NULL,'','','1','','1','1','1'),(923,'0','投票后允许查看','Allow viewing after voting','投票後允許查看','投票後に表示を許可','ອະນຸຍາມເບິ່ງເເຍງຫລັງຈາກການເລືອກ',NULL,NULL,'0','VIEW_PRIV','1','','1','1','1'),(924,'1','投票前允许查看','Allow viewing before voting','投票前允許查看','投票前に表示を許可','ອະນຸຍາມເບິ່ງເເຕັງ ກ່ອນເລືອກ',NULL,NULL,'1','VIEW_PRIV','1','','1','1','1'),(925,'2','不允许查看','Not allowed to view','不允許查看','表示不可','ບໍ່ສາມາດເບິ່ງ',NULL,NULL,'2','VIEW_PRIV','1','','1','1','1'),(972,'function','职务类型','Job type','職務類型','役職タイプ','ສະນິດບົວລັບ',NULL,NULL,'01','','1','','1','1','1'),(973,'1','管理','Administration','管理','管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'01','function','1','','1','1','1'),(974,'2','技术','technology','科技','ぎじゅつ','ເຕັກໂນໂລຢີ (ຕາຂ່າຍໄຟ້າ)',NULL,NULL,'02','function','1','','1','1','1'),(975,'3','行政','administration','行政','行政','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'03','function','1','','1','1','1'),(976,'141','加班申请','Overtime application','加班申請','残業申請','ໂປຣເເກຣມທົວໄປ',NULL,NULL,'141','KQQJTYPE','1','','1','1','1'),(977,'71','督办','supervise','督辦','監督する','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'71','SMS_REMIND','1','','1','1','1'),(978,'72','会议','meeting','會議','ミーティング','ເຫດການ',NULL,NULL,'72','SMS_REMIND','1','','1','1','1'),(979,'23','领导活动安排','Leadership activity arrangement','領導活動安排','指導活動の手配','ຮັບລວມການປະຕິບັດດ້ວຍຄວາມຈຳ',NULL,NULL,'23','SMS_REMIND','1','','1','1','1'),(1030,'25','邮件互发','Email exchange','郵件互發','メールの相互送信','ການຄົ້າເເຕີມອີເມວລ໌','','','25','SMS_REMIND','1','','1','1','1'),(1031,'26','添加好友','Add friend','添加好友','友達を追加','ເພີ່ມຄູ່ສົນທະນາ',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(1032,'27','添加好友','Add friend','添加好友','友達を追加','ເພີ່ມຄູ່ສົນທະນາ',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(1033,'28','会议管理','management of meetings','會議管理','ミーティング管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(1045,'LOCATION_ADDRESS','所在位置','location','所在位置','場所','ຕັ້ງຄ່າ',NULL,NULL,'1','','1','','1','1','1'),(1050,'01','海淀','Haidian District','海澱','海淀','ປະເທດອາບນຊີເນັດ',NULL,NULL,'01','LOCATION_ADDRESS','1','','1','1','1'),(1051,'02','朝阳','Chaoyang','朝陽','朝日','ເຄື່ອງມືອງ',NULL,NULL,'02','LOCATION_ADDRESS','1','','1','1','1'),(1052,'03','昌平','Changping','昌平','昌平','ການປ່ຽນແປງ',NULL,NULL,'03','LOCATION_ADDRESS','1','','1','1','1'),(1055,'29','人员调度','Personnel scheduling','人員調度','ユーザスケジュール','ໂປຣແກຣມແກຣມສຳລັບເຄື່ອງ',NULL,NULL,'29','SMS_REMIND','1','','1','1','1'),(1056,'01','公告','Notice','公告','公告','ຂໍ້ມູນເພີ້ມ',NULL,NULL,'01','portals_show','1','/img/main_img/app/0116.png','1','1','1'),(1057,'02','新闻','Journalism','新聞','ニュース','ວິທະຍາສາດການເມືອງ',NULL,NULL,'02','portals_show','1','/img/main_img/app/0117.png','1','1','1'),(1058,'03','邮件箱','Mail box','郵件箱','メールボックス','ເຄື່ອງມືໂຕອັກສອນ',NULL,NULL,'03','portals_show','1','/img/main_img/app/0101.png','1','1','1'),(1059,'04','待办流程','To Do Process','待辦流程','ToDoプロセス','ເພື່ອເຮັດໃຫ້ໂປຣເຊດຍ່',NULL,NULL,'04','portals_show','1','/img/main_img/app/dblc.png','1','1','1'),(1060,'05','待办公文','Pending official documents','待辦公文','保留中の公文書','ໂປຣເເກຣມຫ້ອງການລົກເກດຢ່າງເປັນທະນາ',NULL,NULL,'05','portals_show','1','/img/main_img/app/dbgw.png','1','1','1'),(1061,'06','日程安排','Schedule arrangement','排程','スケジュール','ສະຖານະການຖ້າ',NULL,NULL,'06','portals_show','1','/img/main_img/app/0124.png','1','1','1'),(1062,'07','常用功能','Common functions','常用功能','一般的な機能','ໂປຣເເກຣມທົວໄປ',NULL,NULL,'07','portals_show','1','/img/main_img/app/cygn.png','1','1','1'),(1063,'08','日志','journal','日誌','ログ＃ログ＃','ປະຈຸບັນ',NULL,NULL,'08','portals_show','1','/img/main_img/app/0128.png','1','1','1'),(1064,'09','文件柜','File cabinet','文件櫃','キャビネット','ໂປຣເເກຣມຟີມ',NULL,NULL,'09','portals_show','1','/img/main_img/app/0136.png','1','1','1'),(1065,'10','网络硬盘','Network hard drive','網路硬碟','ネットワークハードディスクドライブ','hard',NULL,NULL,'10','portals_show','1','/img/main_img/app/3010.png','1','1','1'),(1066,'11','会议通知','Meeting Notice','會議通知','会議のお知らせ','ຂໍ້ມູນເພີ່ມຄູ່ສົນທະນາ',NULL,NULL,'11','portals_show','1','/img/main_img/app/hytz.png','1','1','1'),(1067,'01','今日考勤统计','Today\'s attendance statistics','今日考勤統計','今日の勤務統計','ສະຖານະການທີ່ເຂົ້າຮ່ອນປະຈຸບັນ',NULL,NULL,'01','portals_manage','1','/img/main_img/mana/kqtj.png','1','1','1'),(1068,'02','员工请假统计','Employee leave statistics','員工請假統計','従業員休暇統計','ຜູ້ປະຕິບັດການລົບດ້ານການເມືອງ',NULL,NULL,'02','portals_manage','1','/img/main_img/mana/qjtj.png','1','1','1'),(1069,'03','公告发布数统计','Announcement release statistics','公告發佈數統計','公告発行数統計','ສະຖານະຂໍ້ມູນເສຍການ ທົ່ວໄປ',NULL,NULL,'03','portals_manage','1','/img/main_img/mana/ggfb.png','1','1','1'),(1070,'04','新闻发布数统计','Statistics on the number of news releases','新聞發佈數統計','ニュースリリース数統計','ສະຖານະການດ້ວຍຄວາມສໍາພັນຂອງຂ່າວ',NULL,NULL,'04','portals_manage','1','/img/main_img/mana/xwtj.png','1','1','1'),(1071,'05','工作流统计','Workflow statistics','工作流統計','ワークフロー統計','ຖານຂໍ້ມູນລົບ',NULL,NULL,'05','portals_manage','1','/img/main_img/mana/gzltj.png','1','1','1'),(1072,'06','员工统计','Employee statistics','員工統計','従業員統計','ລາຊະອານາຈັກອັກທຸລະກິດ',NULL,NULL,'06','portals_manage','1','/img/main_img/mana/ygtj.png','1','1','1'),(1073,'07','员工合同统计','Employee Contract Statistics','員工契约統計','従業員契約統計','ຕົວເຕັກໂຕະຫຼາດ ທຸກຄົນ',NULL,NULL,'07','portals_manage','1','/img/main_img/mana/yght.png','1','1','1'),(1074,'08','合同到期员工','Employees whose contracts have expired','合同到期員工','契約失効従業員','ໂປຣເເກຣມທົວໄປທີ່ສຳລັນຍັງຊ່ຽວຂ້ອງ',NULL,NULL,'08','portals_manage','1','/img/main_img/mana/ygrz.png','1','1','1'),(1075,'09','新入职员工','Newly hired employee','新入職員工','新入社員','ສຳລັບຜູ້ຊ່ຽວຊານ',NULL,NULL,'09','portals_manage','1','/img/main_img/mana/htdq.png','1','1','1'),(1076,'20','编辑角色与权限','Edit roles and permissions','編輯角色與許可權','ロールと権限の編集','ແກ້ໄຂບົດລະບົງ ແລະ ສິດລະບົງ','','','20','SYS_LOG','1','','1','1','1'),(1077,'21','删除角色与权限','Delete roles and permissions','删除角色與許可權','ロールと権限の削除','ລຶບບການພົດແລະສິດລ','','','21','SYS_LOG','1','','1','1','1'),(1078,'BUDGETTYPE','预算','budget','預算','予算','ຄູ່ສົນທະນາ',NULL,NULL,'3','FLOWTYPE','1','','1','1','1'),(1081,'HR_STAFF_CONTRACT2','合同类型','type of contract','契约類型','契約タイプ','ຮູບແບບຂອງ ຕັ້ງ',NULL,NULL,'100','','1','','1','1','1'),(1082,'01','产品销售','Product sales','產品銷售','製品販売','ການຄ້າສະເໝີບຜະລິດຕະພັນ',NULL,NULL,'01','HR_STAFF_CONTRACT2','1','','1','1','1'),(1083,'02','业务销售','Business Sales','業務銷售','ビジネス・セールス','ການຄ້າອັກທາງການຄ້າ',NULL,NULL,'02','HR_STAFF_CONTRACT2','1','','1','1','1'),(1084,'03','售后服务','after-sale service','售後服務','アフターサービス','ໂປຣເເກຣມຫລັງຈາກການຄ້າ',NULL,NULL,'03','HR_STAFF_CONTRACT2','1','','1','1','1'),(1085,'04','代理分销','Proxy distribution','代理分銷','代理販売','ການຈ່າຍແຈກແພັກເກດ',NULL,NULL,'04','HR_STAFF_CONTRACT2','1','','1','1','1'),(1086,'05','其他','other','其他','その他','ອື່ນ ໆ',NULL,NULL,'05','HR_STAFF_CONTRACT2','1','','1','1','1'),(1087,'CUSTOMER_STATUS','客户状态','Customer status','客戶狀態','顧客ステータス','ສະຖານະຂະຫຍາຍເຕັກຕ່າງໆ',NULL,NULL,'08','','1','','1','1','1'),(1088,'01','初步接触','Initial contact','初步接觸','しょきせっしょく','ໂປຣເເກຣມຫລືໂຕເລືອກ',NULL,NULL,'01','CUSTOMER_STATUS','1','','1','1','1'),(1089,'02','客户拜访','Customer visits','客戶拜訪','顧客訪問','ເຄື່ອງມືເຂົ້າຮ່ວມຕົວຢ່າງຕໍ່ກັນ',NULL,NULL,'02','CUSTOMER_STATUS','1','','1','1','1'),(1090,'03','需求沟通','Requirement communication','需求溝通','コミュニケーションが必要','ຄວາມຕ້ອງການສຳຫ້າມ',NULL,NULL,'03','CUSTOMER_STATUS','1','','1','1','1'),(1091,'04','方案报价','Proposal quotation','方案報價','シナリオ見積もり','ວັນຖຶກສຽງໂທ',NULL,NULL,'04','CUSTOMER_STATUS','1','','1','1','1'),(1092,'05','商务谈判','business negotiation','商務談判','ビジネス交渉','ຂ່ນກັບການຂ່າງໂຕະຫ່າດ້ວຍສັກທາງການຄ້າ',NULL,NULL,'05','CUSTOMER_STATUS','1','','1','1','1'),(1093,'06','签约成功','Signed successfully','簽約成功','契約が成立した','ລິ້ມຄຳສຳເລັບຜູ້ໃຊ້',NULL,NULL,'06','CUSTOMER_STATUS','1','','1','1','1'),(1094,'CUSTOMERSOURCE','客户来源','Customer source','客戶來源','顧客ソース','ແຫ່ນ ຜູ້ຄ່າຕ່າງໆ',NULL,NULL,'09','','1','','1','1','1'),(1095,'01','广告推广','Advertising Promotion','廣告推廣','広告宣伝','ການເຕີມຄະນະຜູ້ໃຊ້',NULL,NULL,'01','CUSTOMERSOURCE','1','','1','1','1'),(1096,'02','会议营销','Conference Marketing','會議行銷','会議マーケティング','ການຄົ້າຂອງເຂດຂໍ້ມູນ',NULL,NULL,'02','CUSTOMERSOURCE','1','','1','1','1'),(1097,'03','客户介绍','Customer Introduction','客戶介紹','顧客紹介','ອົງການເຂົ້າຮ່ວມຕົວໄປ',NULL,NULL,'03','CUSTOMERSOURCE','1','','1','1','1'),(1098,'04','网上搜索','Search online','網上蒐索','インターネット検索','ຄົ້ນຫາທີ່ອີນເຕີເນັດຕັ້ງ',NULL,NULL,'04','CUSTOMERSOURCE','1','','1','1','1'),(1099,'05','渠道拓展','Channel expansion','通路拓展','チャネル拡張','ແຫຼ່ງຂໍ້ມູນ',NULL,NULL,'05','CUSTOMERSOURCE','1','','1','1','1'),(1100,'06','伙伴介绍','Partner Introduction','夥伴介紹','パートナーの紹介','ໂປຣເເກຣມຄູ່ສົນທະນາ',NULL,NULL,'06','CUSTOMERSOURCE','1','','1','1','1'),(1101,'07','独立开发','Independent development','獨立開發','独自開発','ການພັດທະນາແບບຍືນຍົງ',NULL,NULL,'07','CUSTOMERSOURCE','1','','1','1','1'),(1102,'08','社群营销','social marketing ','社群行銷','コミュニティマーケティング','ການຄ້າລາຍສັງຄົມ',NULL,NULL,'08','CUSTOMERSOURCE','1','','1','1','1'),(1103,'CUSTOMERLEVEL','客户级别','Customer level','客戶級別','顧客レベル','ສະນັງດ້ານການເຄື່ອນໄຫວ',NULL,NULL,'07','','1','','1','1','1'),(1104,'01','A(重要客户)','A (Important Customer)','A（重要客戶）','A（重要顧客）','ອາ (ມີບັນຍາ)',NULL,NULL,'01','CUSTOMERLEVEL','1','','1','1','1'),(1105,'02','B(普通客户)','B (ordinary customer)','B（普通客戶）','B（一般顧客）','ບໍ່ມີ (ໂປຣເເກຣມີສຳຫລັບເກົ່າ)',NULL,NULL,'02','CUSTOMERLEVEL','1','','1','1','1'),(1106,'03','C(一般客户)','C (General Customers)','C（一般客戶）','C（一般顧客）','ສະນີ (ໂປຕິກຕ່າງໆທົ່ວໄປ)',NULL,NULL,'03','CUSTOMERLEVEL','1','','1','1','1'),(1107,'04','D(不重要客户)','D (unimportant customer)','D（不重要客戶）','D（重要でない顧客）','D (ໂປຣເເກຣມ ບໍ່ໄດ້ຕໍ່ຈົງ)',NULL,NULL,'04','CUSTOMERLEVEL','1','','1','1','1'),(1108,'CUSTOMERINDUSTRY','客户行业','Customer Industry','客戶行業','顧客業界','ອຸດສະດິນ ຜູ້ຄືດເຫັນແລະຮູບພາບເຄື່ອນໄຫວຕ່າງໆ',NULL,NULL,'11','','1','','1','1','1'),(1109,'01','农、林、牧、渔业','Agriculture, forestry, animal husbandry and fishery','農、林、牧、漁業','農、林、牧、漁業','ການກະແຫດ, ພູກເມືດ, ລາຊະອານາດ ແລະ ອຸກພົ້າ',NULL,NULL,'01','CUSTOMERINDUSTRY','1','','1','1','1'),(1110,'02','采矿业','Mining','採礦業','採鉱業','ຈິດເກັງ',NULL,NULL,'02','CUSTOMERINDUSTRY','1','','1','1','1'),(1111,'03','制造业','manufacturing','製造業','製造業','ການຜະລິດຕະພັນ',NULL,NULL,'03','CUSTOMERINDUSTRY','1','','1','1','1'),(1112,'04','电力、燃气及水的生产和供应业','Production and supply of electricity, gas, and water','電力、燃氣及水的生產和供應業','電力、ガス及び水の生産及び供給業','ການຜະລິດພະລັງງານແລະສະຫນອງໄຟຟ້າ, ພະລັງງານແລະນ້ໍາ',NULL,NULL,'04','CUSTOMERINDUSTRY','1','','1','1','1'),(1113,'05','建筑业','construction','建築業','けんちく業','ສ້າງ',NULL,NULL,'05','CUSTOMERINDUSTRY','1','','1','1','1'),(1114,'06','交通运输、仓储和邮政业','Transportation, storage and postal services','交通運輸、倉儲和郵政業','交通運輸、倉庫、郵便業','ຕົວຈັດການຂົນສົ່ງອອກ, ບັນທຶກ ແລະ ບໍລິການຕ່າງໆຂອງຂົນສົ່ງອອກ',NULL,NULL,'06','CUSTOMERINDUSTRY','1','','1','1','1'),(1115,'07','信息传输、计算机服务和软件业','Information transmission, computer services, and software industry','資訊傳輸、電腦服務和軟體業','情報伝達、コンピュータサービス、ソフトウェア業界','ການຂ່າວເຕ່ອນຂໍ້ມູນ, ບໍລິດຄອມລະບົບ ແລະ ອັກໂນໂລຍີດຊ໌ທອບ',NULL,NULL,'07','CUSTOMERINDUSTRY','1','','1','1','1'),(1116,'08','批发和零售业','Wholesale and retail','批發和零售業','卸売業と小売業','ທຸດສະທອບທຸກຄົນ ແລະ ຫຼຸດຄົນ',NULL,NULL,'08','CUSTOMERINDUSTRY','1','','1','1','1'),(1117,'09','住宿和餐饮业','Accommodation and catering','住宿和餐飲業','宿泊と飲食業','ການຮູ້ຕ່າງໆ ແລະ ສຸລະກາກອນ',NULL,NULL,'09','CUSTOMERINDUSTRY','1','','1','1','1'),(1118,'10','金融业','finance','金融業','金融業','ເສດຖະສາດ',NULL,NULL,'10','CUSTOMERINDUSTRY','1','','1','1','1'),(1119,'11','房地产业','real estate','房地產業','不動産業','ຖານຮາກ ຟີດສະຖານະຂະນະຕິດຕັ້ງ',NULL,NULL,'11','CUSTOMERINDUSTRY','1','','1','1','1'),(1120,'12','租赁和商务服务业','Leasing and business services','租賃和商務服務業','リースおよびビジネスサービス','ລູງຂຶ້ນ ແລະ ບໍ່ລິການັດການຄ້າ',NULL,NULL,'12','CUSTOMERINDUSTRY','1','','1','1','1'),(1121,'13','科学研究、技术服务和地质勘查业','Scientific research, technical services, and geological exploration industry','科學研究、技術服務和地質勘查業','科学研究、技術サービス、地質調査業','ການຄົ້ນຄວ້ທະຍາສາດ, ບໍລິການທາງເຕັກນິກທໍລະນີ, ແລະ ສັງຄົມການຄົ້ນຄວ້າສະຫຼາດ (Biology)',NULL,NULL,'13','CUSTOMERINDUSTRY','1','','1','1','1'),(1122,'14','水利、环境和公共设施管理业','Water conservancy, environment and public facilities management','水利、環境和公共設施管理業','水利、環境、公共施設管理業','ການອະນຸລັກຮ້ອງດ້ານນ້ໍາ, ສິ່ງແວດລ້ອມ ແລະ ປັດໃຈດ້ານການເມືອງສາທາລະນະຕ່າງໆ',NULL,NULL,'14','CUSTOMERINDUSTRY','1','','1','1','1'),(1123,'15','居民服务和其他服务业','Resident services and other service industries','居民服務和其他服務業','住民サービスとその他のサービス業','ບໍ່ລິການ ທີ່ຊ່ຽວຊານ ແລະ ອັກທາງການຄ້າອັນດຸບຕົ້ນໆ',NULL,NULL,'15','CUSTOMERINDUSTRY','1','','1','1','1'),(1124,'16','教育','education','教育','教育','ການສຶກສາ',NULL,NULL,'16','CUSTOMERINDUSTRY','1','','1','1','1'),(1125,'17','卫生和社会工作','Health and social work','衛生和社會工作','衛生と社会的な仕事','ສຸຂະພາບ ແລະ ເຮັດວຽກສັງຄົມ',NULL,NULL,'17','CUSTOMERINDUSTRY','1','','1','1','1'),(1126,'18','文化、体育和娱乐业','Culture, sports and entertainment','文化、體育和娛樂業','文化、スポーツ、娯楽','ວັດທະນະທໍາ, ເກລະດູຮ້ອນ ແລະ ສຸບລາ',NULL,NULL,'18','CUSTOMERINDUSTRY','1','','1','1','1'),(1127,'19','公共管理、社会保障和社会组织','Public administration, social security and social organizations','公共管理、社會保障和社會組織','公共管理、社会保障、社会組織','ເບີ່ງເເຍງລະບົບສາທາລະນະ, ຄວາມສະດວກສັງຄົມ ແລະ ອົງການສັງຄົມ',NULL,NULL,'19','CUSTOMERINDUSTRY','1','','1','1','1'),(1128,'20','国际组织','international organization','國際組織','国際機関','ອົງການສາກົນ',NULL,NULL,'20','CUSTOMERINDUSTRY','1','','1','1','1'),(1129,'21','政务机关、事业单位','Government agencies and public institutions','政務機關、事業單位','政務機関、事業体','ອົງການຂອງລັດຖະບານ ແລະ ອົງການຕ່າງໆຂອງສາທາລະນະ',NULL,NULL,'21','CUSTOMERINDUSTRY','1','','1','1','1'),(1130,'MONETARYUNIT','货币单位','Monetary unit','貨幣單位','通貨単位','ໂຮງງານໄຟຟ້າ',NULL,NULL,'13','','1','','1','1','1'),(1131,'01','人民币','RMB','人民幣','人民元','ຕິດຕັ້ງ (M)',NULL,NULL,'01','MONETARYUNIT','1','','1','1','1'),(1132,'02','美元','Dollar','美元','ドル','ໂດລດົງ',NULL,NULL,'02','MONETARYUNIT','1','','1','1','1'),(1133,'03','欧元','Euro','歐元','ユーロ','ເອີຣົບ',NULL,NULL,'03','MONETARYUNIT','1','','1','1','1'),(1134,'04','英镑','Pound','英鎊','ポンド','ເປັນນານ (kg)',NULL,NULL,'04','MONETARYUNIT','1','','1','1','1'),(1135,'05','日元','Japanese yen','日元','円','ຊີເນີນຊ໌',NULL,NULL,'05','MONETARYUNIT','1','','1','1','1'),(1136,'06','港币','Hong Kong dollar','港幣','香港ドル','ໂປຣເເກຣມ ປະເທດກຽກກີງ',NULL,NULL,'06','MONETARYUNIT','1','','1','1','1'),(1137,'07','台币','Taiwan dollar','台幣','台湾ドル','ຄ່າຈຳນວນເຕັງ',NULL,NULL,'07','MONETARYUNIT','1','','1','1','1'),(1138,'08','新加坡币','Singapore dollar','新加坡幣','シンガポールドル','ລູກໂນໂລຍ໌',NULL,NULL,'08','MONETARYUNIT','1','','1','1','1'),(1139,'PAYMENTMETHOD','付款方式','Payment method','付款方式','支払い方法','ວິທີການສຳລັບຜູ້ໃຊ້',NULL,NULL,'12','','1','','1','1','1'),(1140,'01','现金','Cash','現金','現金','ອິດລົງ',NULL,NULL,'01','PAYMENTMETHOD','1','','1','1','1'),(1141,'02','转账','Transfer accounts','轉帳','振り替え','ບັນຊີທົວເຕີງ',NULL,NULL,'02','PAYMENTMETHOD','1','','1','1','1'),(1142,'03','支票','Check','支票','小切手','ກວດດ້ອບ',NULL,NULL,'03','PAYMENTMETHOD','1','','1','1','1'),(1143,'04','支付宝','Alipay','支付寶','アリペイ','ນາມແຝງ',NULL,NULL,'04','PAYMENTMETHOD','1','','1','1','1'),(1144,'05','微信','WeChat','微信','ウィーチャット','ວິເຄດີສົນທະນາ',NULL,NULL,'05','PAYMENTMETHOD','1','','1','1','1'),(1145,'06','其他','Other','其他','その他','ອື່ນ ໆ',NULL,NULL,'06','PAYMENTMETHOD','1','','1','1','1'),(1146,'FOLLOWUPMODE','跟进方式','Follow up method','跟進管道','フォローアップ方式','ໃຊ້ທາງເລືອກ',NULL,NULL,'10','','1','','1','1','1'),(1147,'01','电话','Telephone','電話','電話番号','ໂທລະໂທ',NULL,NULL,'01','FOLLOWUPMODE','1','','1','1','1'),(1148,'02','短信','short message','簡訊','ショートメッセージ','ຂໍ້ມູນເກົ່າ',NULL,NULL,'02','FOLLOWUPMODE','1','','1','1','1'),(1149,'03','微信','WeChat','微信','ウィーチャット','ວິເຄດີສົນທະນາ',NULL,NULL,'03','FOLLOWUPMODE','1','','1','1','1'),(1150,'04','QQ','QQ','QQ','QQ','QQ',NULL,NULL,'04','FOLLOWUPMODE','1','','1','1','1'),(1151,'05','会面','meet','會面','に会う','ຂໍ້ມູນກ່ຽວກັບ',NULL,NULL,'05','FOLLOWUPMODE','1','','1','1','1'),(1155,'34','公告反馈通知','Announcement Feedback Notice','公告迴響通知','公告フィードバック通知','ຂໍ້ມູນເເຫຍເຕັບສຳຫລັກ','','','02','SMS_REMIND','1','','1','1','1'),(1156,'35','救援任务通知','Rescue mission notification','救援任務通知','救援任務のお知らせ','ແກ້ໄຂລະບົບ','','','02','SMS_REMIND','1','','1','1','1'),(1157,'staffType','员工类型','Employee type','員工類型','従業員タイプ','ຮູບແບບຜູ້ສຳລັບຜູ້ໃຊ້',NULL,NULL,'12','','1','','1','1','1'),(1158,'01','技术开发','technological development','技術開發','技術開発','ການພັດທະນາ ເຕັກໂນໂລຢີການເມືອງ',NULL,NULL,'01','staffType','1','','1','1','1'),(1159,'02','技术支持','technical support','技術支援','テクニカルサポート','ສຳຫລັບຜູ້ຊ່ວຍເຕັກໂນໂລຍ',NULL,NULL,'01','staffType','1','','1','1','1'),(1160,'03','销售','sale','銷售','セールス','ປັກຄ້າ',NULL,NULL,'01','staffType','1','','1','1','1'),(1162,'12','待阅事宜','Pending Matters','待閱事宜','未読事項','ບັນຊີທົວໄປ',NULL,NULL,'12','portals_show','1','/img/main_img/app/dysy.png','1','1','1'),(1163,'73','视频会议','Videoconferencing','視訊會議','ビデオ会議','ຂໍ້ມູນກ່ຽວກັບວິດີໂອ',NULL,NULL,'73','SMS_REMIND','1','','1','1','1'),(1165,'74','固定资产','fixed assets','固定資產','固定資産','ຖານຮາກ ຟີດທີ່ຕ່າງໆ',NULL,NULL,'74','SMS_REMIND','1','','1','1','1'),(1166,'00','今日看板','Today\'s Kanban','今日看板','今日のカンバン','ວັນນີ້ກໍ່ວາງ',NULL,NULL,'00','portals_show','1','/img/main_img/app/38.png','1','1','1'),(1167,'0b','今日看板B','Today\'s Kanban B','今日看板B','本日の看板B','ວັນນີ້ເປັນຊ່ວຍເປນນີ້',NULL,NULL,'0b','portals_show','1','/img/main_img/app/38.png','1','1','1'),(1168,'75','合同管理','contract management ','契约管理','契約管理','ເບີ່ງເເຍງຂໍ້ມູນຍັງ',NULL,NULL,'75','SMS_REMIND','1','','1','1','1'),(1169,'77','公安局值班管理','Duty management of the Public Security Bureau','警察局值班管理','警察署の当直管理','ເບີ່ງເເຍງລະບົບຄຳບຄຸມລະບົບ ທີ່ກົດຄຳບຄຸມລະບົບ',NULL,NULL,'77','SMS_REMIND','1','','1','1','1'),(1884,'78','报警信息','Alarm information','報警資訊','アラームメッセージ','ຂໍ້ມູນແຕ່ງຂໍ້ມູນ',NULL,NULL,'78','SMS_REMIND','1','','1','1','1'),(1944,'DEPT_TYPE','部门类型','Department type','部門類型','部門タイプ','ຮູບແບບ່ວນເຂດຂໍ້ມູນ',NULL,NULL,'62','','1','','1','1','1'),(1962,'CONTRACT_TYPE','合同种类','Contract type','契约種類','契約の種類','ສະນິດຄວາມແຕກຕ່າງໆ',NULL,NULL,'','90','1','','1','1','1'),(1963,'82','智慧党建','Smart Party Building','智慧黨建','知恵の党建設','ສ້າງພື້ນຖານ Smart',NULL,NULL,'82','SMS_REMIND','1','','1','0','1'),(1966,'01','公司总部','Company Headquarters','公司總部','本社','ໂປຣເເກຣມສຳລັບຫ້ອງການ',NULL,NULL,'01','DEPT_TYPE','1','','1','1','1'),(1967,'02','区域总部/直属总包部','Regional headquarters/direct general contracting department','區域總部/直屬總包部','地域本部/直属統括本部','ບ້ານເມືອງພາຍໃຕ້ດິນ/ສັນຍົນຄ່ນຍົງ ທຸກຄົນ',NULL,NULL,'02','DEPT_TYPE','1','','1','1','1'),(1968,'03','总承包部','General Contracting Department','總承包部','元請け部','ໂປຣເເກຣມແກຕ່າງພາຍໃຕ້ທົ່ວໄປ',NULL,NULL,'03','DEPT_TYPE','1','','1','1','1'),(1969,'04','联盟类型','Alliance type','聯盟類型','フェデレーション・タイプ','ຮູບແບບສະໜູບທຳອິງ',NULL,NULL,'04','DEPT_TYPE','1','','1','1','1'),(1970,'51','用餐管理','Meal management','用餐管理','食事管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'51','SYS_LOG','1','','1','1','1'),(1971,'52','项目申报','Project application','專案申報','プロジェクト申告','ໂປຣເເກຣມທົວໄປ',NULL,NULL,'52','SYS_LOG','1','','1','1','1'),(1972,'53','单项评选','Individual selection','單項評選','単項選考','ຕົວເລືອກ',NULL,NULL,'53','SYS_LOG','1','','1','1','1'),(1973,'54','综合评选','Comprehensive evaluation','綜合評選','総合選考','ການສຶກສາທີ່ລວມຕົງ',NULL,NULL,'54','SYS_LOG','1','','1','1','1'),(1974,'55','会议申请','Meeting application','會議申請','会議の申し込み','ໂປຣເເກຣມຄູ່ສົນທະນາ',NULL,NULL,'55','SYS_LOG','1','','1','1','1'),(1975,'56','日程安排','Schedule arrangement','排程','スケジュール','ສະຖານະການຖ້າ',NULL,NULL,'56','SYS_LOG','1','','1','1','1'),(1976,'JOB_LEVEL','岗级','Post level','崗級','こうばい','ລູງຂໍ້ມູນ',NULL,NULL,'62','','1','','1','1','1'),(1977,'01','一级','class a','一級','1レベル','ນາມແລກ a',NULL,NULL,'01','JOB_LEVEL','1','','1','1','1'),(1978,'02','二级','second level','二級','にだん','ມີຄວາມຈຳນວຍໂຕ',NULL,NULL,'02','JOB_LEVEL','1','','1','1','1'),(1979,'03','三级','Level 3','三級','3レベル','ລູງ3',NULL,NULL,'03','JOB_LEVEL','1','','1','1','1'),(1980,'04','四级','Level 4','四級','よんだん','ເລກ4',NULL,NULL,'04','JOB_LEVEL','1','','1','1','1'),(2039,'87','招投标管理','Tendering and Bidding Management','招投標管理','入札募集管理','ການຮອງຮ້າຍແລະການຮອງຮ້າງຄຳສຸດ',NULL,NULL,'87','SMS_REMIND','1','','1','1','1'),(2070,'88','理论学习管理','Theoretical Learning Management','理論學習管理','理論学習管理','ຄວບຄຸມລະບົບຄວບຄຸມນິເວດວິທະຍາ',NULL,NULL,'88','SMS_REMIND','1','','1','1','1'),(2071,'PORTAL_GROUP_TYPE','H5门户菜单分组类型','H5 portal menu grouping type','H5門戶選單分組類型','H 5ポータルメニューグループタイプ','ຮູບແບບຂອງ H5 ໂປຣເເກຣມ',NULL,NULL,'201','','1','','1','1','1'),(2072,'01','内部管理','Internal management','內部管理','内部管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'01','PORTAL_GROUP_TYPE','1','','1','1','1'),(2073,'02','人事管理','personnel management','人事管理','人事管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'02','PORTAL_GROUP_TYPE','1','','1','1','1'),(2074,'90','密码提示','Password prompt','密碼提示','パスワードのヒント','ຄຳຖາມລະຫັດຜ່ານ',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(2075,'88','理论学习','Theoretical learning','理論學習','りろんがく','ວິທະຍາສາດທຳມະຊາດ (Theo)',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(2076,'89','员工关怀','Employee care','員工關懷','従業員の配慮','ທຸດສະດີສຳລັບຜູ້ປະຕິບັດດ',NULL,NULL,'','SMS_REMIND','1','','1','1','1'),(2199,'91','薪资管理','Salary Management','薪資管理','給与管理','ເບີ່ງເເຍງລະບົບສຳລັບຫ້ອງການ',NULL,NULL,'91','SMS_REMIND','1','','1','0','1'),(2200,'92','考勤数据管理','Attendance data management','考勤資料管理','勤務評定データ管理','ເບີ່ງເເຍງລະບົບ ຂໍ້ມູນແພັກເກດ',NULL,NULL,'91','SMS_REMIND','1','','1','0','1'),(2723,'FIELDDEF','自定义字段模块','Custom Field Module','自定義欄位模塊','カスタムフィールドモジュール','ໂຕເລືອກເຂດຂໍ້ມູນ',NULL,NULL,'100','','1','','1','1','1'),(2724,'hr_staff_info','人事档案','Personnel files','人事檔案','人事ファイル','ແຟ້ມບ່ວນຕົວ',NULL,NULL,'1','FIELDDEF','1','0','1','1','1'),(2725,'hr_staff_contract','合同管理','contract management ','契约管理','契約管理','ເບີ່ງເເຍງຂໍ້ມູນຍັງ',NULL,NULL,'2','FIELDDEF','1','0','1','1','1'),(2726,'knowledge_customer','客户管理','customer management','客戶管理','顧客管理','ເບີ່ງເເຍງລະບົບຫ້ອງການ',NULL,NULL,'3','FIELDDEF','1','0','1','1','1'),(2727,'HTML_MODEL_TYPE','HTML模板类别','HTML Template Category','HTML範本類別','HTMLテンプレートカテゴリ','ເລກຮູບແບບ',NULL,NULL,'100','','1','','1','1','1'),(2728,'01','工作流','Workflow','工作流','ワークフロー','ຖານຮາກ ຟ້າອັດວຽກ',NULL,NULL,'01','HTML_MODEL_TYPE','1','0','1','1','1'),(2729,'02','电子邮件','E-mail','電子郵件','Eメール','ອີເມວລ໌',NULL,NULL,'02','HTML_MODEL_TYPE','1','0','1','1','1'),(2730,'03','工作日志','Work log','工作日志','作業ログ','ໂປຣເເກຣມເຄື່ອງມືອງ',NULL,NULL,'03','HTML_MODEL_TYPE','1','0','1','1','1'),(2731,'04','公告通知','Announcement Notice','公告通知','公告通知','ຂໍ້ມູນເເຕັບສຳຫລັນ',NULL,NULL,'04','HTML_MODEL_TYPE','1','0','1','1','1'),(2732,'05','新闻','Journalism','新聞','ニュース','ວິທະຍາສາດການເມືອງ',NULL,NULL,'05','HTML_MODEL_TYPE','1','0','1','1','1'),(2733,'06','讨论区','Discussion Area','討論區','ディスカッションエリア','ເຂດຂໍ້ມູນທີ່ກ່ຽວຂ້ອງ',NULL,NULL,'06','HTML_MODEL_TYPE','1','0','1','1','1'),(2734,'07','文件柜','File cabinet','文件櫃','キャビネット','ໂປຣເເກຣມຟີມ',NULL,NULL,'07','HTML_MODEL_TYPE','1','0','1','1','1'),(2735,'08','会议管理','management of meetings','會議管理','ミーティング管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'08','HTML_MODEL_TYPE','1','0','1','1','1'),(2736,'09','工作计划','Work Plan','工作計畫','作業計画','ໂປຣເເກຣມ',NULL,NULL,'09','HTML_MODEL_TYPE','1','0','1','1','1'),(2737,'10','项目管理','project management','專案管理','プロジェクト管理','ເບີ່ງເເຍງລະບົບ',NULL,NULL,'10','HTML_MODEL_TYPE','1','0','1','1','1'),(2738,'11','维基百科','Wikipedia','維琪百科','ウィキペディア','ເຄວິດີໂນ',NULL,NULL,'11','HTML_MODEL_TYPE','1','0','1','1','1'),(2739,'12','OA知道','OA knows','OA知道','OAは知っている','ສາເຫດຂອງດິນ',NULL,NULL,'12','HTML_MODEL_TYPE','1','0','1','1','1'),(2740,'13','人力资源 - 考勤','Human Resources - Attendance','人力資源-考勤','人的資源-勤務評定','ເຄື່ອງມືແຫຼ່ງຂໍ້ມູນ - ສິ່ງທີ່ມີຄວາມສະດວກ',NULL,NULL,'13','HTML_MODEL_TYPE','1','0','1','1','1'),(2741,'14','人力资源 - 人事档案','Human Resources - Personnel Files','人力資源-人事檔案','人事資料','ແຫຼ່ງຂໍ້ມູນ - ລະບົບແຟ້ມບ່ວນຕົວ',NULL,NULL,'14','HTML_MODEL_TYPE','1','0','1','1','1'),(2742,'15','人力资源 - 招聘管理','Human Resources - Recruitment Management','人力資源-招聘管理','人事-採用管理','ສິ່ງແຫຼ່ງຂໍ້ມູນ - ການຈັດຕັ້ງຄຳບຄຸມລະບົບ',NULL,NULL,'15','HTML_MODEL_TYPE','1','0','1','1','1'),(2743,'16','人力资源 - 培训管理','Human Resources - Training Management','人力資源-培訓管理','人的資源-トレーニング管理','ແຫຼ່ງຂໍ້ມູນ - ການຄົ້າຄວບຄຸມລະບົບ',NULL,NULL,'16','HTML_MODEL_TYPE','1','0','1','1','1'),(2744,'17','人力资源 - 考核','Human Resources - Assessment','人力資源-考核','人的資源-レビュー','ແຫຼ່ງຂໍ້ມູນ - ການສຶກສາ',NULL,NULL,'17','HTML_MODEL_TYPE','1','0','1','1','1'),(2745,'18','计时','time','計時','タイミング','recursive',NULL,NULL,'18','HTML_MODEL_TYPE','1','0','1','1','1'),(2746,'94','流程信息提醒','Process information reminder','流程資訊提醒','プロセス情報のリマインダ','ໂປຣເເກຣມຂໍ້ມູນກ່ຽວກັບ',NULL,NULL,'94','SMS_REMIND','1','','1','1','1'),(2747,'96','客户跟进提醒','Customer follow-up reminder','客戶跟進提醒','顧客フォローアップ通知','ຄືນຄ່າຕັ້ງຄ່າຄອນຄືນຄ່າຕັ້ງ',NULL,NULL,'96','SMS_REMIND','1','','1','1','1'),(2759,'98','社区','community','社區','コミュニティ','ສັງຄົມ',NULL,NULL,'98','SMS_REMIND','1','','1','1','1'),(4246,'100','通讯簿','address book','通訊錄','アドレス帳','ບ້ານເເດງຂໍ້ມູນ',NULL,NULL,'100','SMS_REMIND','1','','1','1','1'),(4248,'99','薪酬管理','Salary management','薪酬管理','給与管理','ເບີ່ງເເຍງລະບົບສຳລັບຫ້ອງການ',NULL,NULL,'99','SMS_REMIND','1','','1','1','1'),(4249,'102','APP视频会议','APP video conference','APP視訊會議','APPビデオ会議','ກອງປະຊຸມວິດີໂອ',NULL,NULL,'102','SMS_REMIND','1','','1','0','1'),(4250,'147','调班申请','Shift adjustment application','調班申請','シフト申請','ປັບ ຕັ້ງຄ່າໂປຣເເກຣມ',NULL,NULL,'147','KQQJTYPE','1','','1','1','1');
/*!40000 ALTER TABLE `sys_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_function`
--

DROP TABLE IF EXISTS `sys_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_function` (
  `FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '菜单ID',
  `MENU_ID` varchar(10) NOT NULL DEFAULT '0' COMMENT '子菜单项代码',
  `FUNC_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '子菜单名称',
  `FUNC_NAME1` varchar(255) DEFAULT NULL,
  `FUNC_NAME2` varchar(255) DEFAULT NULL,
  `FUNC_NAME3` varchar(255) DEFAULT NULL,
  `FUNC_NAME4` varchar(255) DEFAULT NULL,
  `FUNC_NAME5` varchar(255) DEFAULT NULL,
  `FUNC_CODE` varchar(300) NOT NULL COMMENT '子菜单模块路径',
  `FUNC_EXT` varchar(600) NOT NULL COMMENT '国际版多语言菜单名称',
  `ISOPEN_NEW` varchar(10) DEFAULT NULL,
  `SEND_USER` char(10) DEFAULT NULL COMMENT '1开启/0关闭(传递加密后的用户信息)',
  `SEND_KEY` varchar(255) DEFAULT NULL COMMENT '密钥',
  `IS_SHOW_FUNC` int(10) DEFAULT '0' COMMENT '是否在移动端显示该二级菜单0.显示1.不显示',
  PRIMARY KEY (`FUNC_ID`) USING BTREE,
  KEY `MENU_ID` (`MENU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_function`
--

LOCK TABLES `sys_function` WRITE;
/*!40000 ALTER TABLE `sys_function` DISABLE KEYS */;
INSERT INTO `sys_function` VALUES (1,'0101','电子邮件','Email','電子郵件','Eメール','ອີເມວລ໌',NULL,'email/index','',NULL,NULL,NULL,0),(4,'0116','公告通知','Notice','公告通知','公告通知','ຂໍ້ມູນເເຕັບສຳຫລັນ',NULL,'notice/allNotifications','',NULL,NULL,NULL,0),(8,'0124','日程安排','Schedule','日程安排','スケジュール','ສະຖານະການຖ້າ',NULL,'schedule/index','',NULL,NULL,NULL,0),(10,'0132','通讯簿','Address Book','通訊錄','アドレス帳','ບ້ານເເດງຂໍ້ມູນ',NULL,'address/index','','0',NULL,NULL,0),(11,'0140','控制面板','Control Panel','控制面板','コントロールパネル','ຮູບແບບຄວບຄຸມລະບົບ',NULL,'controlpanel/index','',NULL,NULL,NULL,0),(24,'2006','公告通知管理','Notice Manage','公告通知查詢','公告通知管理','ຂໍ້ມູນ ແລະ ເບີ່ງເເຍງລະບົບ',NULL,'notice/noticeManagement','',NULL,NULL,NULL,0),(30,'z00402','单位管理','Unit  Manage','單位管理','単位管理','ເບີ່ງເເຍງລະບົບ',NULL,'sys/companyInfo','',NULL,NULL,NULL,0),(31,'z00406','部门管理','Dept Manage','部門管理','部門管理','ເບີ່ງເເຍງລະບົບ',NULL,'common/deptManagement','',NULL,NULL,NULL,0),(32,'z00410','角色与权限管理','Role&Priv  Manage','角色與權限管理','役割と権限管理','ເບີ່ງເເຍງລະບົບ ແລະ ເບີ່ງເເຍງລະບົບ',NULL,'roleAuthorization','',NULL,NULL,NULL,0),(33,'z00408','用户管理','User Manage','用戶管理','ユーザー管理','ເບີ່ງເເຍງລະບົບ',NULL,'common/userManagement','',NULL,NULL,NULL,0),(38,'z099','系统信息','System Info','系統信息','システム情報','ຂໍ້ມູນລະບົບ',NULL,'sys/sysInfo','',NULL,NULL,NULL,0),(56,'z004','组织机构设置','Organization Setting','組織機構設置','組織機構の設定','ຕັ້ງຄ່າຄວາມສະດວກຕັ້ງຄ່າ',NULL,'@unitsetup','',NULL,NULL,NULL,0),(57,'z008','行政办公设置','Administrative office setting','行政辦公設定','エグゼクティブオフィスの設定','ຕັ້ງຄ່າຄຳບຄຸມລະບົບ',NULL,'@officesetting','',NULL,NULL,NULL,0),(78,'z030','界面设置','Interface Setting','界面設置','インタフェースの設定','ຕັ້ງຄ່າຮູບແບບ',NULL,'sys/interfaceSettings','',NULL,NULL,NULL,0),(84,'z067','数据库管理','Database Management','数据库管理','データベース管理','ເບີ່ງເເຍງລະບົບຖານຂໍ້ມູນ',NULL,'/sysDataBase/index','',NULL,NULL,NULL,0),(85,'6010','会议管理','Meeting Management','會議管理','ミーティング管理','ເບີ່ງເເຍງລະບົບ',NULL,'@meeting','',NULL,NULL,NULL,0),(86,'601001','会议申请','Meeting Application','會議申請','会議の申し込み','ໂປຣເເກຣມຄູ່ສົນທະນາ',NULL,'/MeetingCommon/MeetingApply','',NULL,NULL,NULL,0),(87,'601004','会议查询','Meeting Inquiries','會議查詢','会議の問い合わせ','ຂໍ້ມູນຄຳຖາມກ່ຽວກັບ',NULL,'/MeetingCommon/selectMeeting','',NULL,NULL,NULL,0),(88,'601003','会议管理','Meeting Management','會議管理','ミーティング管理','ເບີ່ງເເຍງລະບົບ',NULL,'/MeetingCommon/selectMeetingMange','',NULL,NULL,NULL,0),(89,'601006','会议室管理','Meeting Room Management','會議室管理','会議室の管理','ເບີ່ງເເຍງລະບົບ',NULL,'/MeetingCommon/MeetingRoom','',NULL,NULL,NULL,0),(99,'z060','系统日志管理','System Logs Manage','系統日誌管理','システムログ管理','ເບີ່ງເເຍງລະບົບ',NULL,'sys/journal','',NULL,NULL,NULL,0),(100,'z065','系统资源管理','Resource Manage','\r\n\r\n系统资源管理\r\n\r\n系統資源管理','システム資源管理','ເບີ່ງເເຍງລະບົບ',NULL,'disk/system','',NULL,NULL,NULL,0),(104,'z040','菜单设置','Meun Setting','菜單設置','メニュー設定','ຕັ້ງຄ່າລາຍການ',NULL,'sys/menuSetting','',NULL,NULL,NULL,0),(105,'2013','新闻管理','News Mangement','新聞管理','ニュース管理','ເບີ່ງເເຍງຂ່າວ',NULL,'news/manage','',NULL,NULL,NULL,0),(113,'z080','系统参数设置','System Parameter Setting','系統參數設置','システムパラメータ設定','ຕັ້ງຄ່າລະບົບ',NULL,'sysTasks/sysTaskIndex','','0',NULL,NULL,0),(119,'2014','投票管理','Voting Management','投票管理','投票管理','ເບີ່ງເເຍງລະບົບ',NULL,'vote/manage/vote','',NULL,NULL,NULL,0),(121,'z045','系统代码设置','System Code Setting','系統代碼設置','システムコード設定','ຕັ້ງຄ່າລະບົບ',NULL,'common/systemCode','',NULL,NULL,NULL,0),(126,'6060','办公用品','Office Supplies','辦公用品','事務用品','ໂປຣມແກຣມສຳລັບຫ້ອງການ',NULL,'@officeSupplies','',NULL,NULL,NULL,0),(127,'606005','办公用品信息管理','Office Supplies Information Management','辦公用品信息管理','事務用品情報管理','ໂປຣເເກຣມແກຣມສຳລັບຫ້ອງການ',NULL,'officeSupplies/goInfomationHome','',NULL,NULL,NULL,0),(128,'606007','办公用品库存管理','Office Supplies Inventory Management','辦公用品庫存管理','事務用品在庫管理','ໂປຣມແກຣມສຳລັບຫ້ອງການ',NULL,'officetransHistory/stockIndex','',NULL,NULL,NULL,0),(129,'606009','办公用品采购清单','Shopping List','辦公用品采购清单','事務用品調達リスト','ລາຍການແບບຄຳສ້າງຫ້ອງການ','','officeDepository/goDepositoryShopList ','','','','',0),(137,'601008','管理员设置','Administrator Setting','管理員設置','管理者設定','ຕັ້ງຄ່າຄວບຄຸມລະບົບ',NULL,'/MeetingCommon/MeetingMange','',NULL,NULL,NULL,0),(138,'601005','会议纪要','Meeting Summary','會議紀要','議事録','ນາມແພັກເກດ',NULL,'/MeetingCommon/selectMeetingMinutes','',NULL,NULL,NULL,0),(147,'0117','新闻','News','新聞','ニュース','ວິທະຍາສາດການເມືອງ',NULL,'news/index','',NULL,NULL,NULL,0),(148,'0118','投票','Vote','投票','投票する','ບັນຊີໂຕເລືອກ',NULL,'vote/manage/voteIndex','',NULL,NULL,NULL,0),(178,'z035','状态栏设置','Status Bar Setting','狀態欄設置','ステータスバーの設定','ຕັ້ງຄ່າລາຍສະຖານະຂະນະ',NULL,'sys/statusBar','',NULL,NULL,NULL,0),(179,'606001','办公用品申领','Office Supplies Application','辦公用品申領','事務用品の申請','ໂປຣເເກຣມສຳລັບຫ້ອງການຫ້ອງການ',NULL,'officetransHistory/OfficeProductApplyIndex','',NULL,NULL,NULL,0),(196,'2008','公告通知审批','Approval Of Notice','公告通知審批','公告通知承認','ວົນຖືກຕັ້ງຄ່າສະເພາະຈໍທີ່ສຶກສາ',NULL,'notice/appprove','',NULL,NULL,NULL,0),(197,'z00830','公告通知设置','Setting Of Notice','公告通知設定','公告通知の設定','ຕັ້ງຄ່າສັນຍານ ແລະ ຕັ້ງຄ່າກ່ຽວກັບ',NULL,'notice/notificAtion','',NULL,NULL,NULL,0),(222,'601007','会议室设备管理','Meeting Room Equipment Manage','會議室設備管理','会議室設備管理','ເບີ່ງເເຍງລະບົບຄຳບຄຸມລະບົບ',NULL,'/MeetingCommon/MeetingDeviceMange','',NULL,NULL,NULL,0),(238,'606006','办公用品库管理','Office Supplies Library Management','辦公用品庫管理','事務用品倉庫管理','ເບີ່ງເເຍງຫ້ອງການ',NULL,'officeDepository/goDepositoryindex','',NULL,NULL,NULL,0),(255,'z068','数据源管理','Data Source Management','數據源管理','データソース管理','ເບີ່ງເເຍງຂໍ້ມູນແຫ່ນ',NULL,'TerpServerController/terpserverIndex','','0','0','',0),(257,'z00835','新闻审核设置','News Review Setting','新聞審覈設置','ニュース監査設定','ຕັ້ງຄ່າສຶກສາຂ່າວ',NULL,'/news/setAuditing','',NULL,NULL,NULL,0),(258,'2015','新闻审核','News Review','新聞審覈','ニュースレビュー','ເບີ່ງເເຍງຂ່າວ',NULL,'/news/doAuditing','',NULL,NULL,NULL,0),(259,'6075','证照管理','Certificate Manage','證照管理','証明書管理','ເບີ່ງເເຍງລະບົບ',NULL,'@','','0','0','',0),(260,'607510','证照管理','License Management','證照管理','証明書管理','ເບີ່ງເເຍງລະບົບ',NULL,'/comlicenseInfo/toPage','','0','0','',0),(261,'607515','证照借阅','Borrow A License','證照借閱','証明書を借用する','ຮ່ອນຈິດການອະນຸຍາດ',NULL,'/comlicenseUse/toPage','','0',NULL,NULL,0),(262,'607520','证照类别管理','License Category Management','證照類別管理','証明書カテゴリ管理','ເບີ່ງເເຍງລະບົບຄຳບຄຸມຮູບແບບ',NULL,'/comlicenseType/toPage','','0','0','',0),(539,'606003','办公用品发放','Office Distribution','辦公用品發放','事務用品の支給','ຜູ້ຈັດກຽມສະຫນອງຫ້ອງການໂປຣເເກຣມ',NULL,'officetransHistory/productRelease','',NULL,NULL,NULL,0),(607,'606002','办公用品审批','Office Supplies Approval','辦公用品審批','事務用品承認','ປັນຍົງດ້ານສະຫນອງຫ້ອງການຫ້ອງການ',NULL,'officetransHistory/approvalIndex','',NULL,NULL,NULL,0),(2004,'z077','清除数据','Clear Data','清除數據','データの消去','ລຶບ',NULL,'deleteDatePage','',NULL,NULL,NULL,0),(2005,'0138','事务提醒','Transaction Reminder','事務提醒','トランザクションのリマインダ','ຄ່າຕັ້ງຄ່າຜູ້ມຄ່າຕັ້ງ',NULL,'sms/index','',NULL,NULL,NULL,0),(2006,'601002','我的会议','My Meeting','我的會議','私の会議','ກອງປະຊຸມສຸດຍອດຂອງຂ້າພະເຈົ້າ',NULL,'/MeetingCommon/selectMyMeeting','',NULL,NULL,NULL,0),(2011,'0137','便签','Note','便簽','メモ','ຕິດຕັ້ງ',NULL,'Notes/index','',NULL,NULL,NULL,0),(2047,'z032','门户设置','Portal Settings','門戶設定','ポータルの設定','ຕັ້ງຄ່າໂປຣເເກຣມ',NULL,'portals/index','','0',NULL,NULL,0),(3014,'z011','电子文件设置','Official Document Set','公文設置','電子ファイルの設定','ຕັ້ງຄ່າແຟ້ມຮູບພາບ','','@document/setting','',NULL,NULL,NULL,0),(3021,'z074','定时任务管理','Timed Task Management','定時任務管理','スケジュールタスク管理','ເບີ່ງເເຍງລະບົບ',NULL,'timedTaskJob/imedTaskManagement','','0',NULL,NULL,0),(3029,'z00411','岗位管理','Post Management','崗位管理','ポジション管理','ເບີ່ງເເຍງລະບົບ',NULL,'/sys/getPostmanagement','','0',NULL,NULL,0),(3030,'z00412','职务管理','Job Management','職務管理','役職管理','ຕຳແຫນ່ງ',NULL,'/duties/dutiesjsp','',NULL,NULL,NULL,0),(3055,'z01105','文档设置','Document Setup','文档设置','ドキュメントの設定','ຕັ້ງຄ່າກ່ຽວກັບ',NULL,'/wps/editSettings','',NULL,NULL,NULL,0),(5020,'z090','事务提醒设置','Reminder Set','事務提醒設置','トランザクション・アラート設定','ຕັ້ງຄ່າຂໍ້ມູນແຕ່ມຄ່າຕັ້ງ',NULL,'/smsSettings/remindindex','','0',NULL,NULL,0);
/*!40000 ALTER TABLE `sys_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_log` (
  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户USER_ID',
  `TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '记录时间',
  `IP` varchar(20) NOT NULL DEFAULT '' COMMENT 'IP地址',
  `TYPE` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '日志类型(详见系统代码)',
  `REMARK` mediumtext NOT NULL COMMENT '备注',
  `CLIENT_TYPE` tinyint(3) DEFAULT NULL COMMENT '客户端类型(1：网页端，2：PC客户端，3：IOS端，4：安卓端)',
  `CLIENT_VERSION` varchar(20) DEFAULT NULL COMMENT '版本号',
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  KEY `TIME` (`TIME`) USING BTREE,
  KEY `TYPE_USER` (`TYPE`,`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_log`
--

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `MENU_ID` varchar(10) NOT NULL DEFAULT '0' COMMENT '菜单ID',
  `MENU_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `MENU_NAME1` varchar(100) NOT NULL,
  `MENU_NAME2` varchar(100) NOT NULL,
  `MENU_NAME3` varchar(100) NOT NULL,
  `MENU_NAME4` varchar(100) NOT NULL,
  `MENU_NAME5` varchar(100) NOT NULL DEFAULT '',
  `MENU_EXT` varchar(600) NOT NULL COMMENT '国际版多语言菜单名称',
  `IMAGE` varchar(100) NOT NULL DEFAULT '' COMMENT '图片名',
  PRIMARY KEY (`MENU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES ('01','个人事务','My Affairs','個人事務','個人事務','ສ່ວນຕົວ','','','mytable'),('20','行政办公','Administrative Office','行政辦公','行政事務','ໂປຣເເກຣມຄວບຄຸມລະບົບ','','','erp'),('60','资源管理','Resource Manage','資源管理','リソース管理','ເບີ່ງເເຍງລະບົບ','','','resource'),('z0','系统管理','System Manage','系統管理','システム管理','ເບີ່ງເເຍງລະບົບ','','','system');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu_h5`
--

DROP TABLE IF EXISTS `sys_menu_h5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu_h5` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `sort_no` varchar(100) DEFAULT NULL COMMENT '排序号',
  `menu_name` varchar(255) DEFAULT NULL COMMENT '菜单名称（中文）',
  `menu_name1` varchar(255) DEFAULT NULL COMMENT '菜单名称（英文）',
  `menu_name2` varchar(255) DEFAULT NULL COMMENT '菜单名称（繁中）',
  `menu_h5_url` varchar(255) DEFAULT NULL COMMENT '菜单h5页面跳转地址',
  `menu_icon` varchar(255) DEFAULT NULL COMMENT '菜单图标',
  `menu_pc_id` int(11) DEFAULT NULL COMMENT '菜单对应的pc网页菜单id',
  `open_status` varchar(2) DEFAULT NULL COMMENT '开启状态（0-关闭，1-开启）',
  `is_system` varchar(2) DEFAULT NULL COMMENT '是否是系统内置应用菜单（1-系统内置应用，2-用户自建）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `PORTAL_GROUP_TYPE` varchar(10) DEFAULT NULL COMMENT 'H5门户菜单分组类型',
  `agent_id` varchar(255) DEFAULT '' COMMENT '应用id',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='h5页面应用菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu_h5`
--

LOCK TABLES `sys_menu_h5` WRITE;
/*!40000 ALTER TABLE `sys_menu_h5` DISABLE KEYS */;
INSERT INTO `sys_menu_h5` VALUES (1,'005','电子邮件','','','/ewx/emailList','email.png?1',1,'1','1','','01',''),(4,'010','公告通知','','','/ewx/noticeList','notice.png?1',NULL,'1','1','','01',''),(5,'015','日程安排','','','/ewx/calendar','schedule.png?1',NULL,'1','1','','01',''),(6,'020','审批','','','/workflow/work/workflowIndexh5','approval.png?1',NULL,'1','1','','01',''),(7,'025','个人文件柜','','','/ewx/fileIndex','files.png?1',NULL,'1','1','','01',''),(8,'030','工作日志','','','/ewx/diaryIndex','workLog.png?1',NULL,'1','1','','01',''),(9,'035','新闻','','','/ewx/newsList','news.png?1',NULL,'1','1','','01',''),(10,'040','车辆','','','/ewx/carList','che.png',NULL,'1','1','','01',''),(11,'045','会议','','','/ewx/meetingList','meeting.png',NULL,'1','1','','01',''),(12,'050','签到','','','/ewx/attend','PersonalAttendance.png',NULL,'1','1','','02',''),(13,'055','车辆审批','','','/ewx/carApprovalList','che.png',NULL,'1','1','','01',''),(14,'060','领导日程','','','/ewx/leadCalendar','lingdaoricheng.png',NULL,'1','1','','01',''),(15,'065','会议审批','','','ewx/meetingApprovalList','icon_meetingManagr.png',NULL,'1','1','','01',''),(16,'070','我的课程','','','train/courses','myCourse.png',NULL,'1','1','','02',''),(17,'075','打卡统计','','','ewx/attendStatistics','Attendancemanagement.png',NULL,'1','1','','02',''),(18,'080','值班','','','DutyPoliceUsers/dutypoliceusersapp','dutyManagement.png',NULL,'1','2','','02',''),(20,'080','公告管理','','','notice/noticeManagement','noticeManage.png',NULL,'1','2','','01',''),(21,'082','公文管理','','','/ewx/documentIndex','documentManage.png',NULL,'1','2','','01',''),(26,'037','通讯簿','','','/ewx/addressBook','meeting.png',NULL,'1','1','','01',''),(27,'027','公共文件柜','','','/newFileContent/getFileContent','files.png?1',NULL,'1','1','','01',''),(28,'056','企业动态','','','/ewx/trends','dongtai.png',NULL,'0','2','','01',''),(29,'090','待阅事宜','','','/ewx/toReadFile','PendingMatters.png',NULL,'1','1','','01',''),(31,'073','薪资查询','','','/salary/lclb','dutyManagement.png',NULL,'1','2','','02','');
/*!40000 ALTER TABLE `sys_menu_h5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_para`
--

DROP TABLE IF EXISTS `sys_para`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_para` (
  `PARA_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '参数名称',
  `PARA_VALUE` varchar(10000) NOT NULL COMMENT '参数值',
  PRIMARY KEY (`PARA_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='系统参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_para`
--

LOCK TABLES `sys_para` WRITE;
/*!40000 ALTER TABLE `sys_para` DISABLE KEYS */;
INSERT INTO `sys_para` VALUES ('ADDRESS_SHOW_FIELDS','PSN_NO,PSN_NAME,DEPT_NAME,TEL_NO_DEPT,MOBIL_NO,OICQ_NO,|排序号,姓名,单位名称,工作电话,手机,QQ号码,'),('AES_ENCRYPTION','1'),('ALLDOC_INDEX_DOTIME','{\"BEGIN_TIME\":\"02:30:00\",\"END_TIME\":\"05:30:00\"}'),('ALLDOC_INDEX_FILENUM','1000'),('ALLDOC_INDEX_FILETYPE','{\"WORD_INDEX\":\"1\",\"EXCLE_INDEX\":\"0\",\"PPT_INDEX\":\"0\",\"PDF_INDEX\":\"0\",\"HTML_INDEX\":\"0\",\"TXT_INDEX\":\"0\"}'),('ALLDOC_INDEX_YN','0'),('ALL_SHARE','0'),('ANNUAL_BEGIN_TIME','-01-01 00:00:01'),('ANNUAL_END_TIME','-12-30 23:59:59'),('APP_Android_Version','2023.09.27.1'),('APP_IOS_Version','2023.05.18'),('APP_PC_DownUrl','/file/pc/ispiritXOASetup.exe'),('APP_PC_Version','2023.09.10.1'),('ATTACH_ENCRYPT','a:6:{s:6:\"ENABLE\";i:0;s:7:\"MODULES\";s:0:\"\";s:5:\"TYPES\";s:41:\"doc,docx,xls,xlsx,wps,et,csv,aip,pdf,amr,\";s:8:\"COMPLETE\";s:1:\"0\";s:8:\"MAX_SIZE\";i:1024;s:6:\"METHOD\";s:9:\"XXTEA-128\";}'),('ATTEND_FREE_DEPT',''),('ATTEND_FREE_PRIV',''),('ATTEND_FREE_USER',''),('AUTO_UPDATE','1'),('AUTO_UPDATE_FAILED','0'),('BACKUPS_KEY_ENCRYPTION',''),('BUDGET_EDIT_PRIV',''),('BUDGET_EDIT_USER',''),('CALENDAR_TASK_COLOR','1,,,,,'),('DAEMON_HOST','127.0.0.1'),('DAEMON_PORT','52630'),('DAEMON_SVC_VERSION','2015.03.16'),('DAEMON_TIMER','2'),('DATABASE_BACKUP_PATH',''),('DEFAULT_ATTACH_PATH',''),('DEPT_HR_AGENT',''),('DESKTOP_LEFT_WIDTH','65'),('DESKTOP_SELF_DEFINE','POS,WIDTH,LINES,SCROLL,EXPAND,'),('DIARY_WORK_LOG_FORMAT',''),('DINGDING_APP_CALENDAR',''),('DINGDING_APP_DIARY',''),('DINGDING_APP_EMAIL',''),('DINGDING_APP_FILEFOLDER',''),('DINGDING_APP_MEETING',''),('DINGDING_APP_NEWS',''),('DINGDING_APP_NOTIFY',''),('DINGDING_APP_PICTURE',''),('DINGDING_APP_PUBLICFOLDER',''),('DINGDING_APP_SALARY',''),('DINGDING_APP_SNS',''),('DINGDING_APP_VOTE',''),('DINGDING_APP_WORKFLOW',''),('DINGDING_CORPID',''),('DINGDING_OAURL',''),('DINGDING_SECRET',''),('DINGDING_TYPE','1'),('DISCUSS_GROUP_USER_MAX','5'),('DOCUMENT_PREVIEW ','https://owa-box.vips100.com'),('DOCUMENT_PREVIEW_OPEN','2'),('DOCUMENT_PREVIEW_WATERMARK','1'),('DOC_AIP','1'),('DOC_CGRS','0'),('DOMAIN_SYNC_CONFIG','a:3:{s:8:\\\"DISABLED\\\";s:1:\\\"0\\\";s:9:\\\"USER_PRIV\\\";s:1:\\\"0\\\";s:9:\\\"NOT_LOGIN\\\";s:1:\\\"0\\\";}'),('DOMAIN_SYNC_CONFIG2','{\"DOMAIN_NAME\":\"\",\"DOMAIN_CONTROLLERS\":\"\",\"AD_USER\":\"\",\"AD_PWD\":\"\",\"DISABLED\":\"0\",\"USER_PRIV\":\"\",\"NOT_LOGIN\":\"0\"}'),('DUTY_INTERVAL_AFTER1','10'),('DUTY_INTERVAL_AFTER2','60'),('DUTY_INTERVAL_BEFORE1','30'),('DUTY_INTERVAL_BEFORE2','10'),('DUTY_MACHINE','0'),('EDIT_BYNAME','0'),('EDU_DEFAULT_PASSWORD','123'),('EMAIL_AUDIT_OPTION',''),('EMAIL_CAPACITY','100'),('EMAIL_EXAM','1'),('EMAIL_FREE_AUDIT_MAN',''),('EMAIL_NAME_USEPRIV',''),('ESB_CONFIG',''),('EXCEPTION_LOG','0'),('EXPIRED_TIME_APP',''),('FLOW_ACTION','1,2,3,4,'),('FLOW_DATA_TRANS',''),('FLOW_REMIND_AFTER','1d'),('FLOW_REMIND_BEFORE','15m'),('FLOW_REMIND_TIME','2007-11-16 14:46:34'),('FOLDER_CAPACITY','100'),('GBT_CONFIG','a:4:{s:4:\"HOST\";s:0:\"\";s:4:\"PORT\";s:0:\"\";s:4:\"USER\";s:5:\"admin\";s:3:\"PWD\";s:5:\"admin\";}'),('GBT_MANAGE_PRIV','admin,'),('GBT_NEW_PRIV','admin,'),('GWIKI_NOTIFY','维基知识库已经建设完成，请大家踊跃参与词条的创建和完善。'),('HOME_PAGE_PORTAL',''),('HRMS_OPEN_FIELDS',''),('HR_MANAGER_ARCHIVES','STAFF_SEX,STAFF_BIRTH,STAFF_NATIONALITY,STAFF_NATIVE_PLACE,STAFF_POLITICAL_STATUS,DATES_EMPLOYED,|性别,出生日期,民族,籍贯,政治面貌,入职时间,'),('HR_SET_SPECIALIST','1'),('HR_SET_USER_LOGIN','0'),('HTML_FONT_SIZE',''),('IM_HOST',''),('IM_PORT',''),('IM_SAVE_MSG','0'),('IM_STUTES','0'),('IM_SVC_VERSION','2015.10.30'),('IM_WINDOW_CAPTION','心通达OA'),('INDEX_FILE_STYLE','doc,docx,xls,xlsx,ppt,pptx,rtf,txt,pdf'),('INDEX_HOST','127.0.0.1'),('INDEX_PORT','2287'),('INDEX_SVC_VERSION','2015.03.16'),('IP_UNLIMITED_USER',''),('ISIMFRIENDS','0'),('IS_CHECK_DEMO','1'),('IS_COMMENTS','1'),('IS_CPDA_BYIP','0'),('IS_OPEN_GET_PASSWORD','1'),('IS_OPEN_SANYUAN','1'),('IS_SHOW_JMJ',''),('IS_SHOW_SECRET',''),('IS_USE_APP','0'),('KEY_ENCRYPTION',''),('LAST_PUSH_TIME','0'),('LOCK_SHARE','0'),('LOCK_TIME','2017-04-27,2017-04-29,0'),('LOGIN_DISPLACE','0'),('LOGIN_KEY','0'),('LOGIN_RSA_PASS','0'),('LOGIN_SECURE_KEY','0'),('LOGIN_USE_DOMAIN','0'),('LOG_OUT_TEXT','轻轻的您走了，正如您轻轻的来...'),('MAIL_HOST','127.0.0.1'),('MAIL_POP_PORT','110'),('MAIL_PORT','2597'),('MAIL_RECV_INTERVAL','10'),('MAIL_RECV_MAX_SIZE','2'),('MAIL_SVC_VERSION','2015.10.30'),('MEDIA_MS_TYPE','wmv,asf,mp3,mpg,mpeg,mp4,avi,wmv,wma,wav,dat,'),('MEDIA_REAL_TYPE','rm,rmvb,ram,ra,mpa,mpv,mps,m2v,m1v,mpe,mov,smi,'),('MEETING_IS_APPROVE','1'),('MEETING_MANAGER_TYPE','1,'),('MEETING_OPERATOR',''),('MEETING_ROOM_RULE',''),('MENU_DISPLAY',',menuQuickGroup,menuWinexe,menuUrl'),('MENU_EXPAND_SINGLE','menuExpandSingle'),('MIIBEIAN',''),('MOBILE_PC_OPTION',''),('MOBILE_PUSH_OPTION','1'),('MOBILE_SCREEN','4,147,1,8,9,16,15,130,5,76,701,17,18,19,38,'),('MOBILE_SMS_SET','0'),('MONITOR_ALERT_UID','admin,'),('MQ_SVC_VERSION','2016.07.22'),('MSG_PUSH_SET','1'),('MSM_MSG_AUTO_EML_TIME','1490236157'),('MYPROJECT',''),('MYTABLE_BKGROUND','500'),('NEWS_APPROVAL_TYPE',''),('NEWS_AUDITERS',''),('NEWS_AUDITING_YN','0'),('NEW_IMGROUP_PRIV',''),('NOTIFY_AUDITING_ALL',''),('NOTIFY_AUDITING_EDIT','0'),('NOTIFY_AUDITING_EXCEPTION',''),('NOTIFY_AUDITING_MANAGER','0'),('NOTIFY_AUDITING_PART',''),('NOTIFY_AUDITING_SINGLE','0'),('NOTIFY_AUDITING_SINGLE_NEW','TYPE-0,01-0,02-0,03-0,04-0,'),('NOTIFY_EDIT_PRIV','1'),('NOTIFY_TOP_DAYS',''),('NO_DUTY_USER',''),('NTKO_LICENSE',''),('OA_CONNECT_KEY','XOA2020AESKEY001'),('OA_URL','http://192.168.0.17:88/'),('OFFICETASK_BUG_REPORT','1490060489'),('OFFICE_EDIT','1'),('OFUSERPWD','0'),('ONEFILE_SIZE_LIMIT','0'),('ONE_ATTACHMENT_SIZE','0'),('ONE_USER_MUL_LOGIN','1'),('ONLINE_VIEW',''),('ONLY_OFFICE_ADDRESS_LAN',''),('OPERATOR_NAME','admin,'),('ORG_SCOPE','0'),('ORG_UPDATE','2017-04-25 11:01:58'),('OUTSIDE_ADDRESS',''),('OUT_REQUIREMENT',''),('PAGE_BAR_SIZE','a:0:{}'),('PARTYER_MANAGE_USER',''),('PASSWORD_NULL_TIPS','0'),('PASSWORD_STRENGTH_CHECK','0'),('PASSWORD_VALIDITY_CHECK','0'),('PCONLINE_MOBILE_PUSH','1'),('PC_FAVORITE_MENU','1'),('PC_IS_OPEN_GET_PASSWORD','1'),('PC_IS_SHOW_IM','1'),('PC_IS_SHOW_JMJ','0'),('PC_MESSAGE_POPUP','0'),('PFX_ATTACH',''),('POP3_GETTIME',''),('POP3_GETTIME_STYLE','0'),('POP3_SVC_VERSION','2015.10.30'),('PORTALS_TIME','30'),('PORTAL_NOTICE1_CONTENT',' '),('PORTAL_NOTICE1_TITLE',' '),('PORTAL_NOTICE2_CONTENT',' '),('PORTAL_NOTICE2_TITLE',' '),('PORTAL_NOTICE3_CONTENT',' '),('PORTAL_NOTICE3_TITLE',' '),('PRIV1_DELETE_USER','0'),('PRODUCT_TYPE','XOA'),('PUSH_MNO','00FF5DA4D0F20F5A'),('PUSH_TD_NOTICE','2'),('PWEG_HR_SYN_TIME',''),('QRCODE_LOGIN_SECRET_KEY','WE9BUVJDT0RFTE9HSU4='),('QRCODE_LOGIN_SET','1'),('REDIS_SVC_HOST','127.0.0.1'),('REDIS_SVC_PORT','2377'),('REDIS_SVC_VERSION','2015.06.30'),('RETIRE_AGE','60,55'),('RETRIEVE_PWD','0'),('SALARY_PASS','t.KNnZ13xCrRI'),('SALARY_PASSWORD_VERIFICATION','1'),('SEAL_FROM','1'),('SECURE_DOC_OPTION','0'),('SECURE_SUPER_PASS','$1$YdBpzXkk$SgMrzc1kwZ5mJfOvaEYZK.'),('SECURE_SWITCH','{\"userPriv\":\"20\",\"swith\":\"0\"}'),('SEC_BAN_TIME','10'),('SEC_GRAPHIC','0'),('SEC_INIT_PASS','0'),('SEC_INIT_PASS_SHOW','0'),('SEC_KEY_USER','1'),('SEC_OC_MARK','0'),('SEC_OC_REVISION','0'),('SEC_ON_STATUS','1'),('SEC_PASS_FLAG','0'),('SEC_PASS_IMG','0'),('SEC_PASS_MAX','20'),('SEC_PASS_MIN','8'),('SEC_PASS_SAFE','1'),('SEC_PASS_TIME','30'),('SEC_RETRY_BAN','1'),('SEC_RETRY_TIMES','3'),('SEC_SHOW_IP','1'),('SEC_USER_MEM','1'),('SEC_USE_RTX','0'),('SET_PARTY_FLOW','{\"APPLICATION_FORM\":\"170\",\"ACTIVIST\":\"171\",\"ACTIVIST_REPROT\":\"172\",\"DEVELOP_OBJ\":\"173\",\"REVIEW\":\"175\",\"EXAMINATION\":\"176\",\"DISCUSS\":\"177\",\"OATH\":\"178\",\"PROPARTY_REPORT\":\"179\",\"REGULAR\":\"180\",\"RECOMMEND_PERSON\":\"183\",\"DEVELOP_CONTACTS\":\"184\",\"REPORT\":\"185\",\"AUTOBIOGRAPHY\":\"186\",\"REGULAR_REPORT\":\"187\",\"ARCHIVES\":\"188\",\"CAILIAOBIANGENG\":\"189\",\"CHANAPARTYBRANCH\":\"190\",\"TRANSFEROUTPARTY\":\"191\"}'),('SIGNATURE',''),('SIGN_SIZE','100'),('SMS_REMIND','1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,81,8_1,||1,2,3,4,5,6,7,40,41,8,9,11,12,13,14,15,16,17,18,19,20,22,30,31,32,33,35,34,42,37,43,44,45,81,8_1,|1,13,14,16,|1,13,14,16,'),('SP_ADMIN','admin,'),('STATUS_TEXT_MARQUEE','10'),('SUMMER_VACATION_END',''),('SUPER_PASS','$1$Bpb0ItOu$KYnF8q9k8Z06u3qEsWFLT0'),('SYNC_OA2DD_ORG_TYPE','0'),('SYNC_OA2WX_ORG_TYPE','0'),('SYSECURITY_AUDIT_PRIV',''),('SYSECURITY_MANAGE_PRIV',''),('SYSECURITY_SECRECY_PRIV',''),('SYS_EMAIL',''),('SYS_PARA_1','ccc3SMckXYPe85NrXkW9dmRX/WIcvIkLvKid8drseZQPePzzjGbM'),('SYS_REG_INFO',''),('SYS_SESSION_TIME','0'),('TASK_CLEAN','a:7:{s:13:\"CLEAN_SYS_LOG\";i:1;s:9:\"CLEAN_SMS\";i:1;s:7:\"DAY_SMS\";i:30;s:10:\"CLEAN_LOGS\";i:1;s:8:\"DAY_LOGS\";i:30;s:12:\"CLEAN_DAEMON\";i:1;s:10:\"DAY_DAEMON\";i:30;}'),('TASK_HOST','127.0.0.1'),('TASK_PORT','2397'),('TASK_SVC_VERSION','2016.01.05'),('TDIMMSG_MONITOR','0'),('TOP_MENU_NUM','5'),('TRAIL_EXPRIE','2017-04-26'),('TRIAL_LABOR_DAY','7,30'),('USERID_LOGIN_SET','1'),('USER_DEPT_ORDER','0'),('USE_CC','1'),('USE_DISCUZ','0'),('USE_JPUSH','1'),('VECHICLE_TAKE_BACK','1'),('VMEET_NEW_PRIV','admin,'),('WEBROOT','/data/webroot'),('WEB_SVC_HOST','127.0.0.1'),('WEB_SVC_PORT','2367'),('WEB_SVC_VERSION','2015.06.30'),('WEIXINQY_APP_CALENDAR',''),('WEIXINQY_APP_DIARY',''),('WEIXINQY_APP_DIARY_CONSULT','/ewx/consult|1000323|LJ9qb323y2jj7FICv63-UaHQrRw3Vo_Y4BD0mKosKVU'),('WEIXINQY_APP_EMAIL',''),('WEIXINQY_APP_FILEFOLDER',''),('WEIXINQY_APP_MEETING',''),('WEIXINQY_APP_MESSAGE',''),('WEIXINQY_APP_NEWS',''),('WEIXINQY_APP_NOTIFY',''),('WEIXINQY_APP_PERSONINFO',''),('WEIXINQY_APP_PICTURE',''),('WEIXINQY_APP_PUBLICFOLDER',''),('WEIXINQY_APP_ROBOT',''),('WEIXINQY_APP_SALARY',''),('WEIXINQY_APP_SMS',''),('WEIXINQY_APP_SNS',''),('WEIXINQY_APP_VOTE',''),('WEIXINQY_APP_WORKFLOW',''),('WEIXINQY_CORPID',''),('WEIXINQY_OAURL',''),('WEIXINQY_SECRET',''),('WEIXIN_TYPE','1'),('WELINK_APPID',''),('WELINK_APPSECRET',''),('WINTER_VACATION_END',''),('WORD_SEAL','0'),('WUHAN_SERVICE_URL',''),('YUN_AGENT_CODE','');
/*!40000 ALTER TABLE `sys_para` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule`
--

DROP TABLE IF EXISTS `sys_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `order_id` int(11) NOT NULL COMMENT '排序号',
  `expression` text NOT NULL COMMENT '表达式',
  `description` varchar(255) NOT NULL COMMENT '描述',
  `counter` int(11) NOT NULL COMMENT '计数器',
  `digit` int(4) NOT NULL DEFAULT '4' COMMENT '位数',
  `code` varchar(32) NOT NULL COMMENT '唯一标识',
  `PRIV_USER` text COMMENT '授权人员',
  `PRIV_DEPT` text COMMENT '授权部门',
  `PRIV_ROLE` text COMMENT '授权角色',
  `IS_ADD0` char(10) DEFAULT NULL COMMENT '是否编号补零 (1-是，0-否)',
  `IS_NUM_FORMFIELD` char(10) DEFAULT NULL COMMENT '是否表单字段变量参与编号 (1-是，0-否)',
  `COUNTER_TYPE` char(10) DEFAULT '1' COMMENT '计数器类型(1-单计数器、2-多计数器)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule`
--

LOCK TABLES `sys_rule` WRITE;
/*!40000 ALTER TABLE `sys_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_rule_data`
--

DROP TABLE IF EXISTS `sys_rule_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_rule_data` (
  `RD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `RULE_ID` int(11) DEFAULT NULL COMMENT '关联sys_rule表的id',
  `YY` char(10) DEFAULT NULL COMMENT '当前年份(缩写)',
  `ALL_YY` char(10) DEFAULT NULL COMMENT '当前年份(完整)',
  `DATE` varchar(50) DEFAULT NULL COMMENT '当前日期',
  `DATE_TIME` varchar(50) DEFAULT NULL COMMENT '日期时间',
  `H_MOS` char(10) DEFAULT NULL COMMENT '几日(补零)',
  `H_MO` char(10) DEFAULT NULL COMMENT '几日(不补零)',
  `MONTHS` char(10) DEFAULT NULL COMMENT '几月(补零)',
  `MONTH` char(10) DEFAULT NULL COMMENT '几月(不补零)',
  `DEPT_NAME` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `PRIV_NAME` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `COUNTER` int(11) DEFAULT NULL COMMENT '编号计数器',
  `FORM_FILED_VALUE` varchar(255) DEFAULT NULL COMMENT '表单字段变量',
  PRIMARY KEY (`RD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自动编号规则记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_rule_data`
--

LOCK TABLES `sys_rule_data` WRITE;
/*!40000 ALTER TABLE `sys_rule_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_rule_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taskcenter`
--

DROP TABLE IF EXISTS `taskcenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taskcenter` (
  `TCID` int(11) NOT NULL COMMENT '自增唯一ID',
  `CATAGORY` varchar(15) NOT NULL COMMENT '任务类型',
  `SOURCEID` int(11) NOT NULL COMMENT '任务的来源ID',
  `USER_ID` varchar(20) NOT NULL COMMENT '所属用户',
  `TAKER` text NOT NULL COMMENT '参与用户',
  `BEGIN_TIME` int(10) NOT NULL COMMENT '开始时间',
  `END_TIME` int(10) NOT NULL COMMENT '结束时间',
  `CONTENT` text NOT NULL COMMENT '主要内容',
  `STATUS` varchar(8) NOT NULL COMMENT '任务状态',
  `DELAY_TIME` int(10) NOT NULL COMMENT '推迟到的时间',
  `IGNORE_FLAG` int(1) NOT NULL COMMENT '忽略标志(0-未忽略,1-已忽略,2-已删除)',
  `DELAY_ADD_TIME` int(10) NOT NULL COMMENT '推迟时间',
  PRIMARY KEY (`TCID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务中心信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taskcenter`
--

LOCK TABLES `taskcenter` WRITE;
/*!40000 ALTER TABLE `taskcenter` DISABLE KEYS */;
/*!40000 ALTER TABLE `taskcenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(100) NOT NULL COMMENT '模版名称',
  `type` varchar(20) NOT NULL COMMENT '模版类别',
  `priv_user` longtext COMMENT '授权人员',
  `priv_org` longtext COMMENT '授权部门',
  `priv_role` varchar(100) DEFAULT NULL COMMENT '授权角色',
  `category_id` char(13) NOT NULL COMMENT '所属类别（系统代码）',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `create_user` int(11) NOT NULL COMMENT '创建者',
  `att_url` varchar(255) DEFAULT NULL COMMENT '模板地址',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '模板文件ID',
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '模板文件名称',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terp_server`
--

DROP TABLE IF EXISTS `terp_server`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terp_server` (
  `SERVER_ID` int(4) NOT NULL AUTO_INCREMENT COMMENT '连接ID',
  `DB_SERVER_NAME` varchar(100) NOT NULL COMMENT '服务器名称',
  `DB_SERVER_IP` varchar(50) NOT NULL COMMENT '服务器IP',
  `DB_SERVER_PORT` varchar(10) DEFAULT NULL COMMENT '服务器端口',
  `DB_SERVER_USER` varchar(20) NOT NULL COMMENT '服务器用户名    ',
  `DB_SERVER_PASS` varchar(50) DEFAULT NULL COMMENT '服务器密码',
  `DB_SERVER_REMARK` text COMMENT '连接描述',
  `DBMS_TYPE` varchar(20) NOT NULL DEFAULT 'SQLSERVER' COMMENT 'DBMS类型',
  `DBMS_VERSION` varchar(50) NOT NULL DEFAULT '2000' COMMENT 'DBMS版本',
  `SERVER_NAME_OR_SID` varchar(150) NOT NULL DEFAULT '' COMMENT 'server name/SID的值',
  `ORACLE_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT 'server name/SID类型(REDIO_TYPE:service_name，1:SID)',
  `LINK_TYPE` char(1) NOT NULL DEFAULT '0' COMMENT 'ORACLE连接类型(LINK_TYPE:Basic,TNS)',
  `OLD_SERVER_ID` varchar(11) NOT NULL COMMENT '旧的server_id',
  `DB_DATABASE_NAME` varchar(200) DEFAULT NULL COMMENT '数据源名称',
  `DB_DATABASE_CHARSET` varchar(20) DEFAULT NULL COMMENT '字符格式',
  PRIMARY KEY (`SERVER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='数据源表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terp_server`
--

LOCK TABLES `terp_server` WRITE;
/*!40000 ALTER TABLE `terp_server` DISABLE KEYS */;
INSERT INTO `terp_server` VALUES (1,'金蝶ERP数据源','127.0.0.1','1433','sa','',NULL,'SQLServer','2000','','0','0','',NULL,NULL),(2,'用友ERP数据源','127.0.0.1','1433','sa','',NULL,'SQLServer','2000','','0','0','',NULL,NULL);
/*!40000 ALTER TABLE `terp_server` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `third_sys_config`
--

DROP TABLE IF EXISTS `third_sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_sys_config` (
  `SYS_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `SYS_NAME` varchar(255) DEFAULT NULL COMMENT '系统名称',
  `SYS_DESC` text COMMENT '系统描述',
  `PARA_1` varchar(255) DEFAULT NULL COMMENT '参数',
  `PARA_2` varchar(255) DEFAULT NULL COMMENT '参数',
  `PARA_3` varchar(255) DEFAULT NULL COMMENT '参数',
  `PARA_4` varchar(255) DEFAULT NULL COMMENT '参数',
  `PARA_5` varchar(255) DEFAULT NULL COMMENT '参数',
  `PARA_6` text COMMENT '参数',
  `PARA_7` text COMMENT '参数',
  `PARA_8` text COMMENT '参数',
  `PARA_9` text COMMENT '参数',
  `PARA_0` text COMMENT '参数',
  PRIMARY KEY (`SYS_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='第三方系统集成参数表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `third_sys_config`
--

LOCK TABLES `third_sys_config` WRITE;
/*!40000 ALTER TABLE `third_sys_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `third_sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timed_task`
--

DROP TABLE IF EXISTS `timed_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timed_task` (
  `TASK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `TASK_NAME` varchar(100) NOT NULL COMMENT '任务名称',
  `TASK_DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `TASK_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '任务类型（0-间隔执行，1-定点执行，2-自定义）',
  `SYNC_YN` char(10) NOT NULL DEFAULT '0' COMMENT '是否同步（0-同步，1-异步）',
  `STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '任务状态（0-关闭，1-开启）',
  `ERR_CONTINUE_YN` char(10) NOT NULL DEFAULT '0' COMMENT '任务失败后是否继续（0-终止任务，1-继续执行）',
  `INTERVAL_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '间隔类型（间隔执行：0-分钟，1-小时）（定点执行：2-天，3-周，4-月）',
  `INTERVAL_TIME` int(3) DEFAULT '1' COMMENT '间隔时间（分钟，小时，天，周（1-7），月）',
  `EXECUTION_DATE` int(3) DEFAULT NULL COMMENT '执行日期（定点按月执行时生效 1-31）',
  `EXECUTION_TIME` time DEFAULT NULL COMMENT '执行时间（定点执行时间）',
  `CRON` varchar(255) NOT NULL COMMENT 'cron 表达式',
  `CLASS_PATH` varchar(50) NOT NULL COMMENT '任务执行类（className）',
  `METHOD_NAME` varchar(50) NOT NULL COMMENT '任务执行方法',
  `LAST_TIME` datetime DEFAULT NULL COMMENT '最后一次执行时间',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `IS_SYSTEM_TASK` int(2) DEFAULT '0' COMMENT '是否是系统任务（1是系统任务，2是用户自定义任务）',
  PRIMARY KEY (`TASK_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timed_task`
--

LOCK TABLES `timed_task` WRITE;
/*!40000 ALTER TABLE `timed_task` DISABLE KEYS */;
INSERT INTO `timed_task` VALUES (1,'Backup Database','Backup Database','1','0','0','1','2',3,10,'01:00:00','00 00 01 1/3 * ?','BakupDataBase','bakupDataBase','2020-07-21 23:03:02','2020-07-30 16:00:23',1);
/*!40000 ALTER TABLE `timed_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timed_task_record`
--

DROP TABLE IF EXISTS `timed_task_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timed_task_record` (
  `TRE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务记录ID',
  `TASK_ID` int(11) NOT NULL COMMENT '定时任务ID',
  `USER_ID` varchar(255) DEFAULT NULL COMMENT '执行人ID(手动执行)',
  `EXECUTION_BEGIN_TIME` datetime NOT NULL COMMENT '执行开始时间',
  `EXECUTION_END_TIME` datetime DEFAULT NULL COMMENT '执行结束时间',
  `RESULT` char(10) NOT NULL DEFAULT '0' COMMENT '执行结果(0执行中，1执行成功，2-执行失败)',
  `RESULT_LOG` text COMMENT '执行任务详情(异常日志)',
  PRIMARY KEY (`TRE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='定时任务执行记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timed_task_record`
--

LOCK TABLES `timed_task_record` WRITE;
/*!40000 ALTER TABLE `timed_task_record` DISABLE KEYS */;
INSERT INTO `timed_task_record` VALUES (1,10,NULL,'2023-09-21 18:26:00','2023-09-21 18:26:00','1',''),(2,10,NULL,'2023-09-21 18:27:00','2023-09-21 18:27:00','1',''),(3,10,NULL,'2023-09-21 18:28:00','2023-09-21 18:28:00','1',''),(4,10,NULL,'2023-09-21 18:29:00','2023-09-21 18:29:00','1',''),(5,10,NULL,'2023-10-25 16:03:00','2023-10-25 16:03:00','1',''),(6,10,NULL,'2023-10-25 16:04:00','2023-10-25 16:04:00','1',''),(7,10,NULL,'2023-10-25 16:05:00','2023-10-25 16:05:00','1',''),(8,10,NULL,'2023-10-25 16:06:00','2023-10-25 16:06:00','1',''),(9,10,NULL,'2023-10-25 16:07:00','2023-10-25 16:07:00','1',''),(10,10,NULL,'2023-10-25 16:08:00','2023-10-25 16:08:00','1',''),(11,10,NULL,'2023-10-25 16:09:00','2023-10-25 16:09:00','1',''),(12,10,NULL,'2023-10-25 16:10:00','2023-10-25 16:10:00','1',''),(13,10,NULL,'2023-10-25 16:11:00','2023-10-25 16:11:00','1',''),(14,10,NULL,'2023-10-25 16:12:00','2023-10-25 16:12:00','1',''),(15,10,NULL,'2023-10-25 16:13:00','2023-10-25 16:13:00','1',''),(16,10,NULL,'2023-10-25 16:14:00','2023-10-25 16:14:00','1',''),(17,10,NULL,'2023-10-25 16:15:00','2023-10-25 16:15:00','1',''),(18,10,NULL,'2023-10-25 16:16:00','2023-10-25 16:16:00','1',''),(19,10,NULL,'2023-10-25 16:17:00','2023-10-25 16:17:00','1',''),(20,10,NULL,'2023-10-25 16:18:00','2023-10-25 16:18:00','1',''),(21,10,NULL,'2023-10-25 16:19:00','2023-10-25 16:19:00','1',''),(22,10,NULL,'2023-10-25 16:20:00','2023-10-25 16:20:00','1',''),(23,10,NULL,'2023-10-25 16:21:00','2023-10-25 16:21:00','1',''),(24,10,NULL,'2023-10-25 16:22:00','2023-10-25 16:22:00','1',''),(25,10,NULL,'2023-10-25 16:23:00','2023-10-25 16:23:00','1',''),(26,10,NULL,'2023-10-25 16:24:00','2023-10-25 16:24:00','1',''),(27,10,NULL,'2023-10-25 16:25:00','2023-10-25 16:25:00','1',''),(28,10,NULL,'2023-10-25 16:26:00','2023-10-25 16:26:00','1',''),(29,10,NULL,'2023-10-25 16:27:00','2023-10-25 16:27:00','1',''),(30,10,NULL,'2023-10-25 16:28:00','2023-10-25 16:28:00','1',''),(31,10,NULL,'2023-10-25 16:29:00','2023-10-25 16:29:00','1',''),(32,10,NULL,'2023-10-25 16:30:00','2023-10-25 16:30:00','1',''),(33,10,NULL,'2023-10-25 16:31:00','2023-10-25 16:31:00','1',''),(34,10,NULL,'2023-10-25 16:32:00','2023-10-25 16:32:00','1',''),(35,10,NULL,'2023-10-25 16:33:00','2023-10-25 16:33:00','1',''),(36,10,NULL,'2023-10-25 16:34:00','2023-10-25 16:34:00','1',''),(37,10,NULL,'2023-10-25 16:35:00','2023-10-25 16:35:00','1',''),(38,10,NULL,'2023-10-25 16:36:00','2023-10-25 16:36:00','1',''),(39,10,NULL,'2023-10-25 16:37:00','2023-10-25 16:37:00','1',''),(40,10,NULL,'2023-10-25 16:38:00','2023-10-25 16:38:00','1',''),(41,10,NULL,'2023-10-25 16:39:00','2023-10-25 16:39:00','1',''),(42,10,NULL,'2023-10-25 16:40:00','2023-10-25 16:40:00','1',''),(43,10,NULL,'2023-10-25 16:41:00','2023-10-25 16:41:00','1',''),(44,10,NULL,'2023-10-25 16:42:00','2023-10-25 16:42:00','1',''),(45,10,NULL,'2023-10-25 16:43:00','2023-10-25 16:43:00','1',''),(46,10,NULL,'2023-10-25 16:44:00','2023-10-25 16:44:00','1',''),(47,10,NULL,'2023-10-25 16:45:00','2023-10-25 16:45:00','1',''),(48,10,NULL,'2023-10-25 16:46:00','2023-10-25 16:46:00','1',''),(49,10,NULL,'2023-10-25 16:47:00','2023-10-25 16:47:00','1',''),(50,10,NULL,'2023-10-25 16:48:00','2023-10-25 16:48:00','1',''),(51,10,NULL,'2023-10-25 16:49:00','2023-10-25 16:49:00','1',''),(52,10,NULL,'2023-10-25 16:50:00','2023-10-25 16:50:00','1',''),(53,10,NULL,'2023-10-25 16:51:00','2023-10-25 16:51:00','1',''),(54,10,NULL,'2023-10-25 16:52:00','2023-10-25 16:52:00','1',''),(55,10,NULL,'2023-10-25 16:53:00','2023-10-25 16:53:00','1',''),(56,10,NULL,'2023-10-25 16:54:00','2023-10-25 16:54:00','1',''),(57,10,NULL,'2023-10-25 16:55:00','2023-10-25 16:55:00','1',''),(58,10,NULL,'2023-10-25 16:56:00','2023-10-25 16:56:00','1',''),(59,10,NULL,'2023-10-25 16:57:00','2023-10-25 16:57:00','1',''),(60,10,NULL,'2023-10-25 16:58:00','2023-10-25 16:58:00','1',''),(61,10,NULL,'2023-10-25 16:59:00','2023-10-25 16:59:00','1',''),(62,10,NULL,'2023-10-25 17:00:00','2023-10-25 17:00:00','1',''),(63,10,NULL,'2023-10-25 17:01:00','2023-10-25 17:01:00','1',''),(64,10,NULL,'2023-10-25 17:02:00','2023-10-25 17:02:00','1',''),(65,10,NULL,'2023-10-25 17:03:00','2023-10-25 17:03:00','1',''),(66,10,NULL,'2023-10-25 17:04:00','2023-10-25 17:04:00','1','');
/*!40000 ALTER TABLE `timed_task_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline`
--

DROP TABLE IF EXISTS `timeline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline` (
  `UUID` char(32) NOT NULL COMMENT '自增id',
  `CONTENT_` longtext COMMENT '大事记内容',
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',
  `TITLE_` varchar(255) DEFAULT NULL COMMENT '标题',
  `TYPE_` varchar(255) DEFAULT NULL COMMENT '大事记分类',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `CR_USER_ID` int(11) DEFAULT NULL COMMENT '创建人',
  `UPDATE_USER_ID` int(11) DEFAULT NULL COMMENT '更新人',
  `TAG_` varchar(255) DEFAULT NULL COMMENT '标签',
  `attment_id` varchar(255) DEFAULT NULL,
  `attment_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UUID`) USING BTREE,
  KEY `TIMELINE_CR_UID` (`CR_USER_ID`) USING BTREE,
  KEY `TIMELINE_UPDATE_UID` (`UPDATE_USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline`
--

LOCK TABLES `timeline` WRITE;
/*!40000 ALTER TABLE `timeline` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_event`
--

DROP TABLE IF EXISTS `timeline_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_event` (
  `UUID` char(32) NOT NULL COMMENT '自增id',
  `CONTENT_` longtext COMMENT '事件内容',
  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `END_TIME` datetime DEFAULT NULL COMMENT '结束日期',
  `LAST_EDIT_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',
  `START_TIME` datetime DEFAULT NULL COMMENT '开始日期',
  `TITLE_` varchar(255) DEFAULT NULL COMMENT '事件标题',
  `CR_USER_ID` int(11) DEFAULT NULL COMMENT '创建人',
  `UPDATE_USER_ID` int(11) DEFAULT NULL COMMENT '更新人',
  `TIMELINE_UUID` char(32) DEFAULT NULL,
  PRIMARY KEY (`UUID`) USING BTREE,
  KEY `TIMELINE_EVENT_UPDATE_UID` (`UPDATE_USER_ID`) USING BTREE,
  KEY `TIMELINE_EVENT_CR_UID` (`CR_USER_ID`) USING BTREE,
  KEY `TIMELINE_EVENT_TIMELINE_UUID` (`TIMELINE_UUID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_event`
--

LOCK TABLES `timeline_event` WRITE;
/*!40000 ALTER TABLE `timeline_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_post_dept`
--

DROP TABLE IF EXISTS `timeline_post_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_post_dept` (
  `TIMELINE_ID` char(32) NOT NULL,
  `DEPT_ID` bigint(11) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_post_dept`
--

LOCK TABLES `timeline_post_dept` WRITE;
/*!40000 ALTER TABLE `timeline_post_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_post_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_post_role`
--

DROP TABLE IF EXISTS `timeline_post_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_post_role` (
  `TIMELINE_ID` char(32) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`ROLE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_post_role`
--

LOCK TABLES `timeline_post_role` WRITE;
/*!40000 ALTER TABLE `timeline_post_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_post_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_post_user`
--

DROP TABLE IF EXISTS `timeline_post_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_post_user` (
  `TIMELINE_ID` char(32) NOT NULL,
  `USER_ID` varchar(40) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_post_user`
--

LOCK TABLES `timeline_post_user` WRITE;
/*!40000 ALTER TABLE `timeline_post_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_post_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_view_dept`
--

DROP TABLE IF EXISTS `timeline_view_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_view_dept` (
  `TIMELINE_ID` char(32) NOT NULL,
  `DEPT_ID` int(11) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_view_dept`
--

LOCK TABLES `timeline_view_dept` WRITE;
/*!40000 ALTER TABLE `timeline_view_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_view_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_view_role`
--

DROP TABLE IF EXISTS `timeline_view_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_view_role` (
  `TIMELINE_ID` char(32) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`ROLE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_view_role`
--

LOCK TABLES `timeline_view_role` WRITE;
/*!40000 ALTER TABLE `timeline_view_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_view_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeline_view_user`
--

DROP TABLE IF EXISTS `timeline_view_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeline_view_user` (
  `TIMELINE_ID` char(32) NOT NULL,
  `USER_ID` varchar(40) NOT NULL,
  PRIMARY KEY (`TIMELINE_ID`,`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeline_view_user`
--

LOCK TABLES `timeline_view_user` WRITE;
/*!40000 ALTER TABLE `timeline_view_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeline_view_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traffic_restriction`
--

DROP TABLE IF EXISTS `traffic_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traffic_restriction` (
  `city_id` tinyint(3) unsigned NOT NULL COMMENT '城市ID',
  `year` smallint(5) unsigned NOT NULL COMMENT '年份',
  `month` tinyint(3) unsigned NOT NULL COMMENT '月份',
  `day_1` varchar(30) NOT NULL DEFAULT '' COMMENT '1号限行尾号',
  `day_2` varchar(30) NOT NULL DEFAULT '' COMMENT '2号限行尾号',
  `day_3` varchar(30) NOT NULL DEFAULT '' COMMENT '3号限行尾号',
  `day_4` varchar(30) NOT NULL DEFAULT '' COMMENT '4号限行尾号',
  `day_5` varchar(30) NOT NULL DEFAULT '' COMMENT '5号限行尾号',
  `day_6` varchar(30) NOT NULL DEFAULT '' COMMENT '6号限行尾号',
  `day_7` varchar(30) NOT NULL DEFAULT '' COMMENT '7号限行尾号',
  `day_8` varchar(30) NOT NULL DEFAULT '' COMMENT '8号限行尾号',
  `day_9` varchar(30) NOT NULL DEFAULT '' COMMENT '9号限行尾号',
  `day_10` varchar(30) NOT NULL DEFAULT '' COMMENT '10号限行尾号',
  `day_11` varchar(30) NOT NULL DEFAULT '' COMMENT '11号限行尾号',
  `day_12` varchar(30) NOT NULL DEFAULT '' COMMENT '12号限行尾号',
  `day_13` varchar(30) NOT NULL DEFAULT '' COMMENT '13号限行尾号',
  `day_14` varchar(30) NOT NULL DEFAULT '' COMMENT '14号限行尾号',
  `day_15` varchar(30) NOT NULL DEFAULT '' COMMENT '15号限行尾号',
  `day_16` varchar(30) NOT NULL DEFAULT '' COMMENT '16号限行尾号',
  `day_17` varchar(30) NOT NULL DEFAULT '' COMMENT '17号限行尾号',
  `day_18` varchar(30) NOT NULL DEFAULT '' COMMENT '18号限行尾号',
  `day_19` varchar(30) NOT NULL DEFAULT '' COMMENT '19号限行尾号',
  `day_20` varchar(30) NOT NULL DEFAULT '' COMMENT '20号限行尾号',
  `day_21` varchar(30) NOT NULL DEFAULT '' COMMENT '21号限行尾号',
  `day_22` varchar(30) NOT NULL DEFAULT '' COMMENT '22号限行尾号',
  `day_23` varchar(30) NOT NULL DEFAULT '' COMMENT '23号限行尾号',
  `day_24` varchar(30) NOT NULL DEFAULT '' COMMENT '24号限行尾号',
  `day_25` varchar(30) NOT NULL DEFAULT '' COMMENT '25号限行尾号',
  `day_26` varchar(30) NOT NULL DEFAULT '' COMMENT '26号限行尾号',
  `day_27` varchar(30) NOT NULL DEFAULT '' COMMENT '27号限行尾号',
  `day_28` varchar(30) NOT NULL DEFAULT '' COMMENT '28号限行尾号',
  `day_29` varchar(30) NOT NULL DEFAULT '' COMMENT '29号限行尾号',
  `day_30` varchar(30) NOT NULL DEFAULT '' COMMENT '30号限行尾号',
  `day_31` varchar(30) NOT NULL DEFAULT '' COMMENT '31号限行尾号',
  PRIMARY KEY (`city_id`,`year`,`month`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='车辆限行尾号表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traffic_restriction`
--

LOCK TABLES `traffic_restriction` WRITE;
/*!40000 ALTER TABLE `traffic_restriction` DISABLE KEYS */;
/*!40000 ALTER TABLE `traffic_restriction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `UNIT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UNIT_NAME` char(100) NOT NULL DEFAULT '' COMMENT '单位名称',
  `TEL_NO` char(100) NOT NULL DEFAULT '' COMMENT '联系电话',
  `FAX_NO` char(100) NOT NULL DEFAULT '' COMMENT '传真',
  `POST_NO` char(50) NOT NULL DEFAULT '' COMMENT '邮政编码',
  `ADDRESS` char(200) NOT NULL DEFAULT '' COMMENT '单位地址',
  `URL` char(200) NOT NULL DEFAULT '' COMMENT '单位网站',
  `EMAIL` char(200) NOT NULL DEFAULT '' COMMENT '电子信箱',
  `BANK_NAME` char(200) NOT NULL DEFAULT '' COMMENT '开户行名称',
  `BANK_NO` char(200) NOT NULL DEFAULT '' COMMENT '开户行帐号',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称',
  `CONTENT` text NOT NULL COMMENT '单位简介',
  `TAX_NUMBER` varchar(100) DEFAULT NULL COMMENT '税号',
  PRIMARY KEY (`UNIT_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='单位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (1,'Synthda','','','','北京市海淀区','www.8oa.cn','','','','','','','');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url`
--

DROP TABLE IF EXISTS `url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url` (
  `URL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `URL_NO` int(11) NOT NULL DEFAULT '0' COMMENT '序号',
  `URL_DESC` text NOT NULL COMMENT '名称',
  `URL` varchar(200) NOT NULL DEFAULT '' COMMENT '单位网站',
  `USER` varchar(20) NOT NULL DEFAULT '' COMMENT '添加人',
  `URL_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '类型',
  `SUB_TYPE` varchar(10) NOT NULL COMMENT 'RSS类别',
  `URL_ICON` varchar(100) NOT NULL DEFAULT '' COMMENT '图标地址',
  PRIMARY KEY (`URL_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='个人和公共网址表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url`
--

LOCK TABLES `url` WRITE;
/*!40000 ALTER TABLE `url` DISABLE KEYS */;
INSERT INTO `url` VALUES (1,1,'心通达官网','http://www.tongda3000.com','','0','1','');
/*!40000 ALTER TABLE `url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `UID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(50) DEFAULT NULL,
  `USER_NAME` varchar(60) DEFAULT '' COMMENT '用户真实姓名',
  `USER_NAME_INDEX` varchar(60) DEFAULT '' COMMENT '用户姓名索引',
  `BYNAME` varchar(50) DEFAULT NULL,
  `USEING_KEY` char(1) DEFAULT '0' COMMENT '使用USB KEY登录',
  `USING_FINGER` char(1) DEFAULT '0' COMMENT '使用指纹验证',
  `PASSWORD` varchar(50) DEFAULT '' COMMENT '用户密码',
  `KEY_SN` varchar(50) DEFAULT NULL,
  `SECURE_KEY_SN` varchar(50) DEFAULT NULL,
  `USER_PRIV` int(10) unsigned DEFAULT '0' COMMENT '角色编号',
  `USER_PRIV_NO` smallint(5) unsigned DEFAULT '0' COMMENT '角色排序号',
  `USER_PRIV_NAME` varchar(50) DEFAULT NULL,
  `POST_PRIV` char(1) DEFAULT '0' COMMENT '管理范围',
  `POST_DEPT` varchar(1000) DEFAULT '' COMMENT '管理范围指定部门',
  `DEPT_ID` int(11) DEFAULT '0' COMMENT '部门ID',
  `DEPT_ID_OTHER` varchar(100) DEFAULT '' COMMENT '辅助部门',
  `SEX` char(1) DEFAULT '' COMMENT '性别',
  `BIRTHDAY` date DEFAULT '0000-00-00' COMMENT '生日',
  `IS_LUNAR` char(1) DEFAULT '0' COMMENT '是否农历(1-是,0-否)',
  `TEL_NO_DEPT` varchar(50) DEFAULT '' COMMENT '工作电话',
  `FAX_NO_DEPT` varchar(50) DEFAULT '' COMMENT '工作传真',
  `ADD_HOME` varchar(200) DEFAULT '' COMMENT '家庭住址',
  `POST_NO_HOME` varchar(50) DEFAULT '' COMMENT '家庭邮编',
  `TEL_NO_HOME` varchar(50) DEFAULT '' COMMENT '家庭电话',
  `MOBIL_NO` varchar(50) DEFAULT '' COMMENT '手机号',
  `BP_NO` varchar(50) DEFAULT '' COMMENT '主题颜色',
  `EMAIL` varchar(50) DEFAULT '' COMMENT '电子邮件地址',
  `OICQ_NO` varchar(50) DEFAULT '' COMMENT 'QQ号码',
  `ICQ_NO` varchar(255) DEFAULT NULL,
  `MSN` varchar(200) DEFAULT '' COMMENT 'MSN号码',
  `AVATAR` varchar(50) DEFAULT NULL,
  `CALL_SOUND` char(1) DEFAULT '1' COMMENT '短信提示音',
  `LAST_VISIT_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '上次访问系统的时间',
  `SMS_ON` char(1) DEFAULT '' COMMENT '短信提醒窗口弹出方式(1-自动,0-手动)',
  `MENU_TYPE` char(1) DEFAULT '1' COMMENT '登录模式(1-在本窗口打开OA,2-在新窗口打开OA显示工具栏,3-在新窗口打开)',
  `LAST_PASS_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '上次修改密码的时间',
  `THEME` tinyint(3) unsigned DEFAULT '10' COMMENT '界面主题',
  `SHORTCUT` text COMMENT '快捷菜单ID串',
  `PORTAL` varchar(50) DEFAULT NULL,
  `PANEL` char(1) DEFAULT '1' COMMENT '登录后显示的左侧面板(1-导航,2-组织,3-短信,4-搜索)',
  `ONLINE` int(11) DEFAULT '0' COMMENT '在线时长',
  `ON_STATUS` char(1) DEFAULT '1' COMMENT '记录在线状态(1-联机,2-忙碌,3-离开)',
  `ATTEND_STATUS` char(1) DEFAULT '0' COMMENT '岗位状态(1-出差,2-请假,3-外出)',
  `MOBIL_NO_HIDDEN` char(1) DEFAULT '0' COMMENT '手机号码是否公开(0-公开,1-不公开)',
  `MYTABLE_LEFT` varchar(200) DEFAULT 'ALL' COMMENT '左侧的桌面模块',
  `MYTABLE_RIGHT` varchar(200) DEFAULT 'ALL' COMMENT '右侧的桌面模块',
  `USER_PRIV_OTHER` varchar(100) DEFAULT '' COMMENT '辅助角色编码串',
  `USER_NO` smallint(5) unsigned DEFAULT '10' COMMENT '用户排序号',
  `NOT_LOGIN` tinyint(3) unsigned DEFAULT '1' COMMENT '禁止登录OA系统(1-禁止,0-不禁止)',
  `NOT_VIEW_USER` char(1) DEFAULT '0' COMMENT '禁止查看用户列表(1-禁止,0-不禁止)',
  `NOT_VIEW_TABLE` char(1) DEFAULT '0' COMMENT '禁止显示桌面(1-禁止,0-不禁止)',
  `NOT_SEARCH` char(1) DEFAULT '0' COMMENT '禁止OA搜索(1-禁止,0-不禁止)',
  `BKGROUND` varchar(200) DEFAULT '' COMMENT '桌面背景图片',
  `BIND_IP` varchar(200) DEFAULT '' COMMENT '绑定IP地址',
  `LAST_VISIT_IP` varchar(50) DEFAULT NULL,
  `MENU_IMAGE` varchar(50) DEFAULT NULL,
  `WEATHER_CITY` varchar(50) DEFAULT NULL,
  `SHOW_RSS` char(1) DEFAULT '1' COMMENT '是否显示今日资讯(1-显示,0-不显示)',
  `MY_RSS` text COMMENT '今日资讯中的网址设置',
  `REMARK` text COMMENT '备注',
  `MENU_EXPAND` char(2) DEFAULT '' COMMENT '默认展开菜单',
  `MY_STATUS` varchar(200) DEFAULT '' COMMENT '个性签名',
  `LIMIT_LOGIN` char(1) DEFAULT '0' COMMENT '登录次数限制',
  `PHOTO` varchar(50) DEFAULT NULL,
  `IM_RANGE` tinyint(3) unsigned DEFAULT '1' COMMENT '即时通讯使用权限(1-允许使用,2-禁止使用)',
  `LEAVE_TIME` datetime DEFAULT NULL COMMENT '早退时间',
  `SECRET_LEVEL` int(2) DEFAULT '0' COMMENT '邮件密级类型(1-非涉密,2-秘密[一般],3-机密[重要],4-绝密[非常重要])',
  `USER_PARA` text COMMENT '用户参数',
  `NOT_MOBILE_LOGIN` tinyint(3) unsigned DEFAULT '1' COMMENT '禁止登录OA系统手机客户端(1-禁止,0-不禁止)',
  `MANAGE_MODULE_TYPE` varchar(50) DEFAULT '' COMMENT '用户管理的模块',
  `USER_PRIV_TYPE` tinyint(3) unsigned DEFAULT '0' COMMENT '用户角色类型',
  `USER_MANAGE_ORGS` varchar(200) DEFAULT '' COMMENT '用户管理的分支机构ID串',
  `ID_NUMBER` varchar(100) DEFAULT NULL COMMENT '身份证号',
  `TRA_NUMBER` varchar(100) DEFAULT NULL COMMENT '培训编号',
  `SUBJECT` varchar(100) DEFAULT NULL COMMENT '学科',
  `POST` varchar(255) DEFAULT NULL COMMENT '岗位',
  `AVATAR_128` varchar(255) DEFAULT NULL COMMENT '128头像',
  `POST_ID` int(255) DEFAULT NULL COMMENT '职务ID 对应user_post表',
  `JOB_ID` int(11) DEFAULT NULL COMMENT '岗位ID 对应user_job表',
  `ROOM_NUM` varchar(225) DEFAULT NULL COMMENT '房间号',
  `DEPT_YJ` varchar(225) DEFAULT NULL COMMENT '一级部门',
  `MYTABLE_MID` varchar(200) DEFAULT 'ALL' COMMENT '中间的桌面模块',
  `SIGN_IMAGE_ID` varchar(255) DEFAULT NULL COMMENT '用户签名ID',
  `SIGN_IMAGE_NAME` varchar(255) DEFAULT NULL COMMENT '用户签名ID',
  `MOBILE_TYPE` char(10) DEFAULT NULL COMMENT '手机类型（1表示华为，2表示小米，3表示OPPO，4表示vivo，5表示魅族，0表示其他）',
  `SIMPLE_INTERFACE` char(10) DEFAULT '0' COMMENT '限定使用极简界面（不显示门户、组织及主题切换功能），0否 1是',
  `LEAVE_DEPT` int(10) NOT NULL DEFAULT '0' COMMENT '离职部门ID',
  `USER_SECRECY` varchar(50) DEFAULT NULL COMMENT '关联系统代码人员密级USER_SECRECY',
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `USER_PRIV` (`USER_PRIV`) USING BTREE,
  KEY `DEPT_ID` (`DEPT_ID`) USING BTREE,
  KEY `BYNAME` (`BYNAME`) USING BTREE,
  KEY `PRIV_NO_NAME` (`USER_PRIV_NO`,`USER_NO`,`USER_NAME`) USING BTREE,
  KEY `USER_NAME_INDEX` (`USER_NAME_INDEX`) USING BTREE,
  KEY `USER_PRIV_OTHER` (`USER_PRIV_OTHER`) USING BTREE,
  KEY `USER_PRIV_TYPE` (`USER_PRIV_TYPE`) USING BTREE,
  KEY `DEPT_ID_OTHER` (`DEPT_ID_OTHER`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','system administrator','x*t*g*l*y*','admin','0','0','tVHbkPWW57Hw.','','',1,1,'OA administrator','0','',13,'','0','0000-00-00','0','','010345678901','北京市石景山区玉泉路1','1000001','09090909091','','','','','','','0','1','2023-09-21 18:27:09','','1','0000-00-00 00:00:00',20,'1,4,147,8,130,5,131,9,16,15,76,62,','','1',0,'1','0','1','ALL','ALL','',10,0,'','','0','','','192.168.0.218','0','0','1','','','','','0','',1,'0000-00-00 00:00:00',0,'a:1:{s:11:\"login_first\";i:4;}',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(106,'zhangwei','Zhang Wei','z*w*','zhangwei','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',2,2,'Chairman/ceo','0','',1,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','01',NULL,NULL,0,NULL,NULL,'','ALL','','',NULL,'0',0,NULL),(107,'wangfang','Wang Fang','w*f*','wangfang','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',6,4,'Personnel specialist','0','',3,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(108,'lijie','Li Jie','l*j*','lijie','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',8,4,'Administrative officer','0','',4,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(109,'liuyang','Liu Yang','l*y*','liuyang','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',4,4,'Finance Specialist','0','',2,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(110,'lihua','Lihua','l*h*','lihua','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',12,3,'Production manager','0','',6,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(111,'wangli','Wangli','w*l*','wangli','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',13,4,'Production team leader','0','',7,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(112,'wanghai','Wang Hai','w*h*','wanghai','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',13,4,'Production team leader','0','',8,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(113,'baixue','Snow white','b*x*','baixue','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',11,3,'Customer service staff','0','',11,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL),(114,'wangqiang','Wang Qiang','w*q*','wangqiang','0','0','$1$EPMlnh21$m5aAi14SEJbW6hYmMbXvI0','','',12,3,'Production manager','0','',12,'','0','0000-00-00','0','','','','','','','','','','','','0','','0000-00-00 00:00:00','','','0000-00-00 00:00:00',20,'','','1',0,'','0','1','ALL','ALL','',10,0,'0','0','0','','','','0','0','1','','','1','','0','',1,'0000-00-00 00:00:00',0,'',0,'',1,'','','','',NULL,NULL,NULL,NULL,NULL,NULL,'ALL',NULL,NULL,NULL,'0',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_alidaas`
--

DROP TABLE IF EXISTS `user_alidaas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_alidaas` (
  `USER_ID` varchar(50) NOT NULL COMMENT '用户USER_ID',
  `EXTERNALID` varchar(255) DEFAULT NULL COMMENT '阿里IDaas统一人员身份标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='阿里IDaas与OA用户对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_alidaas`
--

LOCK TABLES `user_alidaas` WRITE;
/*!40000 ALTER TABLE `user_alidaas` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_alidaas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_alidaas_dept`
--

DROP TABLE IF EXISTS `user_alidaas_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_alidaas_dept` (
  `DEPT_ID` int(11) DEFAULT NULL COMMENT '部门id',
  `ORGANIZATION_UUID` varchar(255) DEFAULT NULL COMMENT '本组织机构的uuid或外部ID（唯一）',
  `TYPE` varchar(255) DEFAULT NULL COMMENT '部门类型（SELF_OU(自建组织机构)或DEPARTMENT("自建部门")）'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_alidaas_dept`
--

LOCK TABLES `user_alidaas_dept` WRITE;
/*!40000 ALTER TABLE `user_alidaas_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_alidaas_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dd_map`
--

DROP TABLE IF EXISTS `user_dd_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dd_map` (
  `OA_UID` varchar(40) NOT NULL COMMENT 'OA用户UID',
  `DD_UID` varchar(40) NOT NULL COMMENT '钉钉用户ID',
  KEY `OA_UID` (`OA_UID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='OA与钉钉用户对应表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dd_map`
--

LOCK TABLES `user_dd_map` WRITE;
/*!40000 ALTER TABLE `user_dd_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_dd_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dept_map`
--

DROP TABLE IF EXISTS `user_dept_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dept_map` (
  `DEPT_ID` int(11) NOT NULL COMMENT 'OA部门ID',
  `OTHER_DEPT_ID` varchar(255) DEFAULT NULL COMMENT '其他系统部门ID',
  PRIMARY KEY (`DEPT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='OA部门与其他系统部门映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dept_map`
--

LOCK TABLES `user_dept_map` WRITE;
/*!40000 ALTER TABLE `user_dept_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_dept_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dept_order`
--

DROP TABLE IF EXISTS `user_dept_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dept_order` (
  `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `DEPT_ID` int(11) NOT NULL COMMENT '部门ID',
  `ORDER_NO` int(11) NOT NULL DEFAULT '0' COMMENT '在该部门的排序号',
  `POST_ID` int(11) NOT NULL DEFAULT '0' COMMENT '在该部门的职务',
  PRIMARY KEY (`ORDER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门独立用户排序表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dept_order`
--

LOCK TABLES `user_dept_order` WRITE;
/*!40000 ALTER TABLE `user_dept_order` DISABLE KEYS */;
INSERT INTO `user_dept_order` VALUES (1,'admin',13,10,0),(2,'zhangwei',1,10,0),(3,'wangfang',3,10,0),(4,'lijie',4,10,0),(5,'liuyang',2,10,0),(6,'lihua',6,10,0),(7,'wangli',7,10,0),(8,'wanghai',8,10,0),(9,'baixue',11,10,0),(10,'wangqiang',12,10,0);
/*!40000 ALTER TABLE `user_dept_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_duty`
--

DROP TABLE IF EXISTS `user_duty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_duty` (
  `UDID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `UID` int(11) DEFAULT NULL COMMENT '用户UID',
  `DUTY_TYPE` int(11) DEFAULT NULL COMMENT '排班ID（1、正常  2、全日   休息无数据）',
  `DUTY_DATE` date DEFAULT NULL COMMENT '排班日期',
  `ADD_TYPE` char(10) DEFAULT '1' COMMENT '添加类型（1-排班，2-调休，3-节假日,“-”分割）',
  PRIMARY KEY (`UDID`) USING BTREE,
  UNIQUE KEY `index` (`UID`,`DUTY_DATE`) USING BTREE,
  KEY `uid` (`UID`) USING BTREE,
  KEY `duty_type` (`DUTY_TYPE`) USING BTREE,
  KEY `duty_date` (`DUTY_DATE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户排班表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_duty`
--

LOCK TABLES `user_duty` WRITE;
/*!40000 ALTER TABLE `user_duty` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_duty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_duty_backup`
--

DROP TABLE IF EXISTS `user_duty_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_duty_backup` (
  `UDBID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `DUTY_ID` int(11) DEFAULT NULL COMMENT '对应user_duty表中的id',
  `UID` int(11) DEFAULT NULL COMMENT '对应user_duty表中uid',
  `DUTY_TYPE` int(11) DEFAULT NULL COMMENT '对应user_duty表中duty_type',
  `DUTY_DATE` date DEFAULT NULL COMMENT '对应user_duty表中duty_date',
  PRIMARY KEY (`UDBID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='该表用于操作免签节假日时备份user_duty表中数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_duty_backup`
--

LOCK TABLES `user_duty_backup` WRITE;
/*!40000 ALTER TABLE `user_duty_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_duty_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_ext`
--

DROP TABLE IF EXISTS `user_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ext` (
  `UID` int(11) NOT NULL COMMENT '对应user表的UID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '对应user表的USER_ID',
  `TABLE_ICON` varchar(2000) NOT NULL DEFAULT '' COMMENT '桌面图标ID串',
  `EMAIL_RECENT_LINKMAN` mediumtext NOT NULL,
  `NICK_NAME` varchar(50) NOT NULL COMMENT '昵称',
  `BBS_SIGNATURE` text NOT NULL COMMENT '讨论区签名档',
  `BBS_COUNTER` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发表文章数',
  `EMAIL_CAPACITY` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内部邮箱容量',
  `FOLDER_CAPACITY` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '个人文件柜容量',
  `WEBMAIL_CAPACITY` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '每个Internet邮箱容量',
  `WEBMAIL_NUM` tinyint(4) NOT NULL DEFAULT '0' COMMENT '可使用Internet邮箱数量',
  `CONCERN_USER` text NOT NULL COMMENT '我关注的用户ID串',
  `SCORE` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'OA知道积分',
  `TDER_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT 'OA知道管理员标识',
  `DUTY_TYPE` smallint(4) unsigned NOT NULL DEFAULT '1' COMMENT '考勤排班类型(1-正常班,2-全日班,99-轮班制)',
  `USE_POP3` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用POP3功能(1-是,0-否)',
  `IS_USE_POP3` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启POP3功能(1-是,0-否)',
  `POP3_PASS_STYLE` tinyint(1) NOT NULL DEFAULT '0' COMMENT '密码验证',
  `POP3_PASS` varchar(50) NOT NULL DEFAULT '' COMMENT 'POP3密码',
  `CC_USERNAME` varchar(50) NOT NULL DEFAULT '' COMMENT '企业社区账号用户名',
  `CC_PWD` varchar(100) NOT NULL DEFAULT '' COMMENT '密码',
  `IS_USE_EMAILSEND` tinyint(1) NOT NULL DEFAULT '1',
  `TASKCENTER_OPEN_START` tinyint(1) NOT NULL DEFAULT '0',
  `EMAIL_GETBOX` varchar(100) NOT NULL DEFAULT '',
  `FOLDER_VIEW_MODEL` tinyint(1) NOT NULL DEFAULT '1' COMMENT '文件柜视图标志',
  `U_FUNC_ID_STR` text NOT NULL COMMENT '用户菜单ID串',
  `USE_EMAIL` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否启用邮件发送限制',
  `LOGIN_RESTRICTION` varchar(225) DEFAULT '0',
  `LOGIN_TIME` varchar(225) DEFAULT NULL,
  `EMPLOYMENT_TYPE` varchar(10) DEFAULT NULL COMMENT '人员类型（对应sys_code表中的code_no)',
  `PLAN_COCKPIT_SET` text COMMENT '计划管理运营驾驶舱自定义设置',
  `FLOW_FAVORITES` text COMMENT '流程收藏',
  `PLAN_MANAGE_SETTINGS` text COMMENT '计划管理运营驾驶舱自定义设置',
  `MENU_PANEL` char(10) NOT NULL DEFAULT '0' COMMENT '0-展开，1-隐藏',
  `EMAIL_PANEL` char(10) NOT NULL DEFAULT '0' COMMENT '邮件面板(0-纵列，1-横列)',
  `JOB_LEVEL` varchar(20) DEFAULT NULL COMMENT '岗级',
  `BANK_DEPOSIT` varchar(100) DEFAULT NULL COMMENT '开户行',
  `BANK_CARD_NUMBER` varchar(100) DEFAULT NULL COMMENT '银行卡号',
  `DOCUMENT_PANEL` char(10) DEFAULT '1' COMMENT '公文新建收发文拟稿界面版式样式',
  PRIMARY KEY (`UID`) USING BTREE,
  UNIQUE KEY `USER_ID` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户扩展信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_ext`
--

LOCK TABLES `user_ext` WRITE;
/*!40000 ALTER TABLE `user_ext` DISABLE KEYS */;
INSERT INTO `user_ext` VALUES (1,'admin','','','我是管理员','业精于勤',18,0,0,0,0,'',1,'0',1,1,0,0,'','','',1,1,'',1,'',0,'0','',NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(106,'zhangwei','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0','','',NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(107,'wangfang','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(108,'lijie','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0','',NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(109,'liuyang','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(110,'lihua','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(111,'wangli','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(112,'wanghai','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(113,'baixue','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1'),(114,'wangqiang','','','','',0,500,500,0,0,'',0,'0',1,0,0,0,'','','',1,0,'',1,'',0,'0',NULL,NULL,NULL,NULL,NULL,'0','0',NULL,NULL,NULL,'1');
/*!40000 ALTER TABLE `user_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_function`
--

DROP TABLE IF EXISTS `user_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_function` (
  `uid` int(11) unsigned NOT NULL COMMENT '对应user表的UID',
  `user_id` varchar(20) NOT NULL DEFAULT '' COMMENT '对应user表的USER_ID',
  `user_func_id_str` text NOT NULL COMMENT '用户菜单ID串',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户完整菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_function`
--

LOCK TABLES `user_function` WRITE;
/*!40000 ALTER TABLE `user_function` DISABLE KEYS */;
INSERT INTO `user_function` VALUES (1,'admin','1,10,100,104,105,11,113,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,134,135,136,137,138,139,147,148,149,15,16,17,178,179,18,182,183,184,19,196,197,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2013,2014,2015,2024,2025,2026,2027,2028,2031,2032,2033,2034,2040,2041,2042,2043,2044,2045,2047,2051,2052,2054,2055,2056,2057,2058,2059,2060,2061,2068,2069,2070,2071,2072,2073,2074,2075,2076,2077,2078,2079,2080,2081,2082,2085,2086,2087,2088,2089,2090,2091,2092,2093,2094,2095,2096,2097,2098,2099,2100,2101,2102,2103,2104,2105,2106,2107,2108,2109,2110,2111,2113,2114,2115,2201,2202,2203,2204,2205,2206,2207,2208,2209,2210,2211,2212,2213,2214,2215,2216,2217,2218,2219,222,2220,2221,2222,2223,2224,2225,2226,2227,2228,2229,2230,2231,2232,2233,2234,2235,2236,2237,2241,2270,2271,2272,2273,2274,2275,2276,2277,2278,2279,2280,2281,2282,2283,2284,2285,2287,2288,2289,229,2290,2291,2292,2293,2294,2295,2296,2298,2299,2300,2301,2302,2303,2304,2307,2308,2310,2311,2312,2313,2315,2316,2317,2318,2319,2320,2321,2322,2323,2328,2329,2330,2331,2332,2333,2334,2335,2336,2337,2338,2339,2340,2342,2343,2344,2345,2346,2347,2348,2349,2350,2351,2352,2353,2354,2355,238,24,2501,2502,2503,2504,2505,2506,2507,2508,2509,2510,2511,2512,2513,2514,2515,2516,2517,2518,2519,2520,2521,2522,2523,2524,2525,2526,2527,2528,2529,2530,2531,2532,2533,2534,2535,2536,2537,2538,2539,254,2540,2541,2542,2543,2544,2545,2546,2547,2548,2549,255,2550,2551,2552,2553,2554,2555,2556,2557,2558,2559,256,2560,2561,2562,2563,2564,2565,2566,2567,2568,2569,257,2570,2571,2572,2573,2574,2575,2576,2577,2578,2579,258,2580,2581,2582,2583,2584,2585,2586,2587,2588,2589,259,2590,2591,2592,2593,2594,2595,2596,2597,2598,2599,26,260,2600,2601,2602,2603,2604,2605,2606,2607,2608,2609,261,2610,2611,2612,2613,2614,2615,2616,2617,2618,2619,262,263,27,30,3001,3002,3003,3004,3005,3006,3007,3008,3009,301,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,302,3020,3021,3022,3023,3024,3026,3027,3028,3029,303,3030,3031,3032,3033,3034,3035,3036,3037,3038,3039,304,3040,3041,3042,3043,3044,3045,3046,3047,3048,3049,305,3050,3051,3052,3053,3054,3055,3056,306,3060,3061,3062,3064,307,308,309,31,310,317,319,32,321,33,34,36,37,38,4,401,402,403,404,408,409,410,411,412,413,414,415,416,417,42,43,480,481,482,483,484,485,486,487,488,489,490,491,492,493,494,495,496,5,5017,5018,5019,502,5020,5021,5023,5025,5026,503,504,505,5052,5053,5054,5055,5056,5057,5058,5059,506,5060,5061,5062,5063,5064,5065,5068,508,509,510,511,512,513,514,515,516,517,518,519,520,521,522,523,5301,5302,5303,5304,5305,5306,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5320,5321,5323,5324,5325,5326,5327,5328,5329,5330,5331,5332,5333,5334,5335,5336,5337,5338,5339,5340,5341,5342,5343,5344,5345,5346,5347,5348,5349,5350,5351,536,537,539,540,541,542,543,55,550,551,552,553,554,555,556,557,558,559,56,560,561,57,60,607,61,62,626,628,629,630,7,7200,7201,7202,7203,7204,7205,7206,7207,7208,7209,7210,7211,7212,7213,7214,7215,7216,7217,7218,7219,7220,7221,7222,7224,7225,7227,7228,7250,7251,7252,7253,7315,7316,7317,7318,7319,7320,7327,7334,757559,757560,757561,757562,757567,757568,757569,757570,757571,757572,757574,76,77,78,8,80,84,85,86,87,88,89,9,90,91,92,93,94,95,96,99,','2023-09-21 18:26:31'),(106,'zhangwei','1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(107,'wangfang',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(108,'lijie',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(109,'liuyang',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(110,'lihua',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(111,'wangli',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(112,'wanghai',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(113,'baixue',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50'),(114,'wangqiang',',1,10,105,11,118,119,120,122,123,124,125,126,127,128,130,131,137,138,147,148,15,16,17,179,18,182,183,19,196,2005,2006,2011,2013,2014,2015,2024,2025,2026,2031,2032,2033,2034,2040,2041,2043,2044,2045,2055,2056,2057,2058,2059,2060,2068,2069,2070,2071,222,238,24,256,26,27,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3017,3018,3019,3020,3022,3023,3024,3026,3027,3028,3031,36,4,43,481,482,483,484,485,486,487,488,489,490,491,492,5,502,503,504,505,506,508,509,511,513,539,55,60,607,61,628,7,76,77,8,80,85,86,87,88,89,9,90,91,92,93,94,95,96,0c,','2022-03-20 23:35:50');
/*!40000 ALTER TABLE `user_function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '创建人USER_ID',
  `GROUP_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '用户组名称',
  `ORDER_NO` varchar(20) NOT NULL DEFAULT '' COMMENT '排序号',
  `USER_STR` text NOT NULL COMMENT '设置的用户信息',
  `LIMITS` varchar(2) NOT NULL COMMENT '0,公共自定义组。1,用户自定义组',
  PRIMARY KEY (`GROUP_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `ORDER_NO` (`ORDER_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='自定义用户组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_hierarchy`
--

DROP TABLE IF EXISTS `user_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_hierarchy` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `USER_ID` varchar(50) NOT NULL COMMENT '用户USER_ID',
  `USER_TOP_ID` mediumtext COMMENT '上级',
  `USER_BOTTOM_ID` mediumtext COMMENT '下属',
  `OPERATION_TIME` int(11) DEFAULT NULL COMMENT '上次操作时间',
  `USER_UPDATE_ID` varchar(50) NOT NULL COMMENT '最后操作人',
  `XIAJI_USERS` mediumtext COMMENT '全部下属',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户上下级关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_hierarchy`
--

LOCK TABLES `user_hierarchy` WRITE;
/*!40000 ALTER TABLE `user_hierarchy` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_job`
--

DROP TABLE IF EXISTS `user_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_job` (
  `JOB_ID` int(11) NOT NULL AUTO_INCREMENT,
  `JOB_NAME` varchar(255) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `LEVEL` varchar(255) DEFAULT NULL,
  `JOB_NO` varchar(255) DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  `JOB_PLAN` varchar(255) DEFAULT NULL,
  `DUTY` varchar(255) DEFAULT NULL,
  `DESCRIPTION` text,
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL,
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_job`
--

LOCK TABLES `user_job` WRITE;
/*!40000 ALTER TABLE `user_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_jpush`
--

DROP TABLE IF EXISTS `user_jpush`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_jpush` (
  `uid` int(80) NOT NULL COMMENT 'oa用户userid',
  `jpush_id` varchar(80) NOT NULL COMMENT '极光推送id',
  `client_ver` tinyint(1) NOT NULL,
  `last_active` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户极光信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_jpush`
--

LOCK TABLES `user_jpush` WRITE;
/*!40000 ALTER TABLE `user_jpush` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_jpush` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_map`
--

DROP TABLE IF EXISTS `user_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_map` (
  `USER_ID` varchar(20) NOT NULL COMMENT '用户USER_ID',
  `USER_GUID` char(36) NOT NULL COMMENT '域用户GUID',
  PRIMARY KEY (`USER_ID`) USING BTREE,
  KEY `USER_GUID` (`USER_GUID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='OA和域用户映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_map`
--

LOCK TABLES `user_map` WRITE;
/*!40000 ALTER TABLE `user_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_mobile_devices`
--

DROP TABLE IF EXISTS `user_mobile_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_mobile_devices` (
  `uid` int(10) unsigned NOT NULL,
  `device_token` varchar(80) NOT NULL DEFAULT '' COMMENT '用户的设备token',
  `client_ver` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:apple store  2:enterprise version',
  `last_active` int(10) NOT NULL COMMENT '设备最后登录时间戳',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_mobile_devices`
--

LOCK TABLES `user_mobile_devices` WRITE;
/*!40000 ALTER TABLE `user_mobile_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mobile_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_module_page`
--

DROP TABLE IF EXISTS `user_module_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_module_page` (
  `PAGE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `USER_ID` varchar(20) DEFAULT NULL COMMENT '用户userId',
  `MODULE_TABLE` varchar(100) DEFAULT NULL COMMENT '模块，例如 email',
  `PAGES` int(11) DEFAULT NULL COMMENT '页数',
  PRIMARY KEY (`PAGE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='模块分页设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_module_page`
--

LOCK TABLES `user_module_page` WRITE;
/*!40000 ALTER TABLE `user_module_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_module_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_online`
--

DROP TABLE IF EXISTS `user_online`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_online` (
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '在线人员UID',
  `TIME` int(11) NOT NULL DEFAULT '0' COMMENT '上次更新时间',
  `SID` char(32) NOT NULL DEFAULT '' COMMENT '在线人员Session ID',
  `CLIENT` tinyint(4) NOT NULL COMMENT '客户端登录设备类型(0-浏览器,1-手机浏览器,2-OA精灵,5-iPhone,6-Android)',
  PRIMARY KEY (`SID`) USING HASH
) ENGINE=MEMORY DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='在线用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_online`
--

LOCK TABLES `user_online` WRITE;
/*!40000 ALTER TABLE `user_online` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_online` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_post`
--

DROP TABLE IF EXISTS `user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_post` (
  `POST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `POST_NAME` varchar(255) DEFAULT NULL COMMENT '职务名称',
  `TYPE` int(11) DEFAULT NULL COMMENT '职务类型',
  `LEVEL` varchar(255) DEFAULT NULL COMMENT '职务级别',
  `POST_NO` varchar(255) DEFAULT NULL COMMENT '职务编号',
  `DEPT_ID` int(11) DEFAULT NULL COMMENT '所属部门',
  `DUTY` varchar(255) DEFAULT NULL COMMENT '职责',
  `DESCRIPTION` text COMMENT '职务描述',
  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '附件id',
  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '附件名称',
  PRIMARY KEY (`POST_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_post`
--

LOCK TABLES `user_post` WRITE;
/*!40000 ALTER TABLE `user_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_priv`
--

DROP TABLE IF EXISTS `user_priv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_priv` (
  `USER_PRIV` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `PRIV_NAME` varchar(40) NOT NULL DEFAULT '' COMMENT '角色名称',
  `PRIV_NO` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '角色编码',
  `FUNC_ID_STR` varchar(10000) NOT NULL DEFAULT '' COMMENT '角色对应的功能ID串',
  `PRIV_DEPT_ID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '所属部门',
  `PRIV_TYPE` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '角色类型(0-普通,1-OA管理员,2-分支机构管理员)',
  `IS_GLOBAL` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '全局角色(0-系统全局角色,1-部门私有角色,2-机构全局角色)',
  `PRIV_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '角色分类id',
  PRIMARY KEY (`USER_PRIV`) USING BTREE,
  KEY `PRIV_NO` (`PRIV_NO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_priv`
--

LOCK TABLES `user_priv` WRITE;
/*!40000 ALTER TABLE `user_priv` DISABLE KEYS */;
INSERT INTO `user_priv` VALUES (1,'OA administrator',1,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,1,0,0),(2,'Chairman/ceo',2,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(3,'Chief financial officer',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(4,'Finance Specialist',4,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(5,'HR Director',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(6,'Personnel specialist',4,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(7,'Executive director',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(8,'Administrative officer',4,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(9,'R&D director',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(10,'Research and Development Manager',4,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(11,'Customer service staff',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(12,'Production manager',3,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0),(13,'Production team leader',4,'1,3032,4,147,148,8,10,16,2011,2005,11,130,5,132,131,3022,256,182,183,134,37,135,136,2002,514,515,536,24,196,105,119,258,15,36,76,77,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,129,259,260,261,262,2201,2202,2203,2204,2205,2206,56,30,31,33,32,3029,3030,57,197,257,3014,3055,78,2047,178,104,121,99,100,84,255,3021,2004,113,5020,38,',0,0,0,0);
/*!40000 ALTER TABLE `user_priv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_priv_type`
--

DROP TABLE IF EXISTS `user_priv_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_priv_type` (
  `PRIV_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色分类id',
  `PRIV_TYPE_NAME` varchar(255) NOT NULL COMMENT '角色分类名称',
  `PRIV_TYPE_NO` int(11) NOT NULL DEFAULT '0' COMMENT '角色分类排序号',
  `FUNC_ID_STR` text COMMENT '菜单id串',
  PRIMARY KEY (`PRIV_TYPE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='角色分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_priv_type`
--

LOCK TABLES `user_priv_type` WRITE;
/*!40000 ALTER TABLE `user_priv_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_priv_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_set`
--

DROP TABLE IF EXISTS `user_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_set` (
  `SET_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',
  `SET_ITEM` varchar(50) NOT NULL DEFAULT '' COMMENT '设置项',
  `SET_VALUE` varchar(255) DEFAULT '' COMMENT '设置值',
  PRIMARY KEY (`SET_ID`) USING BTREE,
  KEY `USER_ID_INDEX` (`USER_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_set`
--

LOCK TABLES `user_set` WRITE;
/*!40000 ALTER TABLE `user_set` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_weixinqy`
--

DROP TABLE IF EXISTS `user_weixinqy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_weixinqy` (
  `user_id` varchar(40) NOT NULL COMMENT 'oa用户userid',
  `open_id` varchar(40) NOT NULL COMMENT '微信用户id',
  `deviceId` varchar(40) NOT NULL COMMENT '微信设备id',
  `is_sys` tinyint(3) unsigned NOT NULL COMMENT '是否为管理员',
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微信用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_weixinqy`
--

LOCK TABLES `user_weixinqy` WRITE;
/*!40000 ALTER TABLE `user_weixinqy` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_weixinqy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_welink`
--

DROP TABLE IF EXISTS `user_welink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_welink` (
  `OA_USER_ID` varchar(255) DEFAULT NULL COMMENT 'OA中用户的USER_ID',
  `WL_USER_ID` varchar(255) DEFAULT NULL COMMENT 'WeLink中的用户的USER_ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='OA用户和WeLink用户绑定表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_welink`
--

LOCK TABLES `user_welink` WRITE;
/*!40000 ALTER TABLE `user_welink` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_welink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_widget_set`
--

DROP TABLE IF EXISTS `user_widget_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_widget_set` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `UID` int(10) unsigned NOT NULL COMMENT '用户UID',
  `WIDGET_TYPE` varchar(20) NOT NULL DEFAULT '' COMMENT '所在位置所属类型',
  `WIDGET_IDS` varchar(200) NOT NULL COMMENT 'widget的id串',
  `WIDGET_BG` char(1) NOT NULL DEFAULT '5' COMMENT '背景色',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `UID` (`UID`) USING BTREE,
  KEY `WIDGET_TYPE` (`WIDGET_TYPE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='widget用户设置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_widget_set`
--

LOCK TABLES `user_widget_set` WRITE;
/*!40000 ALTER TABLE `user_widget_set` DISABLE KEYS */;
INSERT INTO `user_widget_set` VALUES (1,1,'1','1,2,4,5,','8');
/*!40000 ALTER TABLE `user_widget_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle` (
  `V_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `V_MODEL` varchar(200) DEFAULT NULL COMMENT '厂牌型号',
  `V_NUM` varchar(20) DEFAULT NULL COMMENT '车牌号',
  `V_DRIVER` text NOT NULL COMMENT '司机',
  `V_TYPE` varchar(20) DEFAULT NULL COMMENT '车辆类型',
  `V_DATE` date DEFAULT NULL COMMENT '购买日期',
  `V_PRICE` int(11) DEFAULT NULL COMMENT '购买价格',
  `V_ENGINE_NUM` varchar(20) DEFAULT NULL COMMENT '发动机号',
  `V_STATUS` varchar(20) DEFAULT '0' COMMENT '当前状态(0-可用,1-损坏,2-维修中,3-报废)',
  `V_REMARK` text COMMENT '备注',
  `ATTACHMENT_ID` text COMMENT '车辆照片ID',
  `ATTACHMENT_NAME` text COMMENT '车辆照片名称',
  `USEING_FLAG` char(1) DEFAULT '0' COMMENT '是否使用',
  `CAR_USER` varchar(50) DEFAULT NULL COMMENT '申请权限',
  `HISTORT` text COMMENT '历史记录',
  `ATTACH_ID` text COMMENT '附件ID',
  `ATTACH_NAME` text COMMENT '附件名称',
  `V_PHONE_NO` varchar(50) DEFAULT NULL COMMENT '司机手机号',
  `DEPT_RANGE` text COMMENT '申请部门',
  `USER_RANGE` text COMMENT '申请人员',
  `V_MANAGE` varchar(20) DEFAULT NULL COMMENT '车辆信息新建人',
  `V_MOT` date DEFAULT NULL COMMENT '年检日期',
  `V_INSURE` date DEFAULT NULL COMMENT '保险日期',
  `V_MOT_SMS` date DEFAULT NULL COMMENT '年检到期日期',
  `V_INSURE_SMS` date DEFAULT NULL COMMENT '保险到期日期',
  `V_MOT_SMS_TYPE` int(11) DEFAULT '0' COMMENT '年检提醒类型：1-事务；2-手机；3-均有',
  `V_INSURE_SMS_TYPE` int(11) DEFAULT '0' COMMENT '保险提醒类型：1-事务；2-手机；3-均有',
  `V_DISPLACEMENT` varchar(20) DEFAULT NULL COMMENT '排量',
  `V_COLOR` varchar(20) DEFAULT NULL COMMENT '车身颜色',
  `V_SEATING` varchar(20) DEFAULT NULL COMMENT '座位数',
  `V_FRAME` varchar(20) DEFAULT NULL COMMENT '车架号后6位',
  `V_CERTIFICATION` varchar(20) DEFAULT NULL COMMENT '机动车登记证书后7位',
  `V_DEPART` varchar(20) DEFAULT NULL COMMENT '保管部门',
  `V_ONWER` varchar(20) DEFAULT NULL COMMENT '车辆所有人',
  `V_CARUSER` varchar(20) DEFAULT NULL COMMENT '车辆使用人',
  `V_TAX` int(11) DEFAULT NULL COMMENT '购置税价格',
  `V_BINSURE` date DEFAULT NULL COMMENT '商业险日期',
  `V_BINSURE_SMS` date DEFAULT NULL COMMENT '商业险到期提醒时间',
  `V_RECORD` text COMMENT '车辆档案情况',
  `V_BACKRECORD` text COMMENT '档案借还记录',
  `V_NATURE` varchar(20) DEFAULT NULL COMMENT '车辆性质',
  `V_PAY` varchar(20) DEFAULT NULL COMMENT '财务借支',
  `V_MILEAGE` varchar(20) DEFAULT NULL COMMENT '初始里程',
  `V_DEPART_PHONE` varchar(20) DEFAULT NULL,
  `V_ONWER_PHONE` varchar(20) DEFAULT NULL,
  `V_CARUSER_PHONE` varchar(20) DEFAULT NULL,
  `V_BINSURE_SMS_TYPE` int(11) DEFAULT '1',
  `V_TITLES` text COMMENT '自定义标题',
  `V_FIELDS` text COMMENT '自定义内容',
  `V_NUMBERS` varchar(20) DEFAULT NULL COMMENT '自定义字段数量',
  `V_OIL` varchar(20) DEFAULT NULL COMMENT '油卡编号',
  PRIMARY KEY (`V_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='车辆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_maintenance`
--

DROP TABLE IF EXISTS `vehicle_maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_maintenance` (
  `VM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `V_ID` varchar(20) DEFAULT NULL COMMENT '车辆ID',
  `VM_REQUEST_DATE` date DEFAULT NULL COMMENT '维护日期',
  `VM_TYPE` varchar(20) DEFAULT NULL COMMENT '维护类型',
  `VM_REASON` text COMMENT '维护原因',
  `VM_FEE` decimal(10,2) DEFAULT '0.00' COMMENT '维护费用',
  `VM_PERSON` varchar(20) DEFAULT NULL COMMENT '经办人',
  `VM_REMARK` text COMMENT '备注',
  PRIMARY KEY (`VM_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='车辆维护记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_maintenance`
--

LOCK TABLES `vehicle_maintenance` WRITE;
/*!40000 ALTER TABLE `vehicle_maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_oil_card`
--

DROP TABLE IF EXISTS `vehicle_oil_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_oil_card` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `OC_ID` varchar(20) DEFAULT '' COMMENT '油卡ID',
  `OC_DATE` date DEFAULT '0000-00-00' COMMENT '发卡日期',
  `RECORDER_HANDLED` varchar(20) DEFAULT '' COMMENT '经手人ID',
  `OC_HANDLED` varchar(20) DEFAULT '' COMMENT '经手人',
  `OC_COMPANY` varchar(20) DEFAULT '' COMMENT '油卡发行单位',
  `OC_PASSWORD` varchar(20) DEFAULT '' COMMENT '油卡密码',
  `OC_STATUS` varchar(20) DEFAULT '' COMMENT '使用状态',
  `V_ID` int(11) unsigned DEFAULT NULL COMMENT '车辆ID',
  `V_NUM` varchar(20) DEFAULT '' COMMENT '车牌号码',
  `V_DEPT` varchar(20) DEFAULT '' COMMENT '保管部门',
  `V_TYPE` varchar(20) DEFAULT '' COMMENT '车辆类型',
  `V_ONWER` varchar(20) DEFAULT '' COMMENT '车辆所有人',
  `V_USER` varchar(20) DEFAULT '' COMMENT '车辆使用人',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `id` (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='油卡管理表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_oil_card`
--

LOCK TABLES `vehicle_oil_card` WRITE;
/*!40000 ALTER TABLE `vehicle_oil_card` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_oil_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_oil_use`
--

DROP TABLE IF EXISTS `vehicle_oil_use`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_oil_use` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `DRIVER` varchar(20) DEFAULT NULL COMMENT '司机',
  `YEAR` varchar(20) DEFAULT NULL COMMENT '年份',
  `MONTH` varchar(20) DEFAULT NULL COMMENT '月份',
  `MILEAGE` varchar(20) DEFAULT NULL COMMENT '里程数',
  `OIL_USE` varchar(20) DEFAULT NULL COMMENT '耗油数',
  `PER_OIL_USE` varchar(20) DEFAULT NULL COMMENT '油耗',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='司机油耗';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_oil_use`
--

LOCK TABLES `vehicle_oil_use` WRITE;
/*!40000 ALTER TABLE `vehicle_oil_use` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_oil_use` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_operator`
--

DROP TABLE IF EXISTS `vehicle_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_operator` (
  `OPERATOR_ID` int(11) DEFAULT '0' COMMENT '唯一自增ID',
  `OPERATOR_NAME` text COMMENT '调度人员'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='调度人员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_operator`
--

LOCK TABLES `vehicle_operator` WRITE;
/*!40000 ALTER TABLE `vehicle_operator` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_usage`
--

DROP TABLE IF EXISTS `vehicle_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_usage` (
  `VU_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `V_ID` varchar(20) DEFAULT NULL COMMENT '车辆ID',
  `VU_REQUEST_DATE` datetime DEFAULT NULL COMMENT '申请日期',
  `VU_PROPOSER` varchar(20) DEFAULT '' COMMENT '申请人',
  `VU_USER` varchar(20) DEFAULT NULL COMMENT '用车人',
  `VU_REASON` text COMMENT '事由',
  `VU_START` datetime DEFAULT NULL COMMENT '起始时间',
  `VU_END` datetime DEFAULT NULL COMMENT '结束时间',
  `VU_FINAL_END` datetime DEFAULT NULL COMMENT '实际结束时间',
  `VU_MILEAGE` int(11) DEFAULT '0' COMMENT '行驶里程',
  `VU_DEPT` varchar(20) DEFAULT NULL COMMENT '用车部门',
  `VU_STATUS` varchar(20) DEFAULT '0' COMMENT '使用状态',
  `VU_REMARK` text COMMENT '备注',
  `VU_DESTINATION` varchar(200) DEFAULT '' COMMENT '目的地',
  `VU_OPERATOR` varchar(20) DEFAULT '' COMMENT '调度人员',
  `VU_DRIVER` varchar(20) DEFAULT '' COMMENT '司机',
  `SMS_REMIND` varchar(20) DEFAULT '' COMMENT '车辆申请部门审批',
  `SMS2_REMIND` varchar(20) DEFAULT '' COMMENT '调度员审批提醒',
  `DEPT_MANAGER` varchar(20) DEFAULT NULL COMMENT '部门审批人',
  `SHOW_FLAG` char(1) DEFAULT NULL COMMENT '判断显示标志',
  `DMER_STATUS` varchar(20) DEFAULT '' COMMENT '部门申请状态(0-等待批准,1-已批准,2-未批准)',
  `DEPT_REASON` text COMMENT '部门批准说明',
  `OPERATOR_REASON` text COMMENT '调度员审批说明',
  `VU_MILEAGE_TRUE` int(11) DEFAULT NULL COMMENT '实际里程',
  `VU_PARKING_FEES` decimal(11,2) DEFAULT NULL COMMENT '停车费用',
  `VU_SUITE` text COMMENT '随行人员',
  `SMS_REMIND_DRIVER` varchar(20) DEFAULT NULL COMMENT '内部短信提醒司机',
  `SMS2_REMIND_DRIVER` varchar(20) DEFAULT NULL COMMENT '手机短信提醒司机',
  `REMIND_CONTENT` varchar(1000) DEFAULT NULL COMMENT '提醒内容',
  `IS_BACK` int(1) DEFAULT '0' COMMENT '是否归还',
  `VU_OPERATOR1` varchar(20) DEFAULT NULL COMMENT '备选调度员',
  `VU_OPERATOR1_SMS_TYPE` int(11) DEFAULT '0' COMMENT '提醒备选调度员类型',
  `VU_DEPARTURE` varchar(200) NOT NULL COMMENT '出发地',
  `VU_NUM` int(11) NOT NULL COMMENT '实际坐车人数',
  PRIMARY KEY (`VU_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='车辆使用情况表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_usage`
--

LOCK TABLES `vehicle_usage` WRITE;
/*!40000 ALTER TABLE `vehicle_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `VER` varchar(255) NOT NULL DEFAULT '' COMMENT '内部版本号',
  `EA` varchar(255) NOT NULL DEFAULT '' COMMENT '保留字段',
  `SN` varchar(255) NOT NULL DEFAULT '' COMMENT '软件序列号',
  `CODE` varchar(500) NOT NULL COMMENT '注册码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='版本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('2023.09.10.1','2.0.060101','','');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vi_flow_run`
--

DROP TABLE IF EXISTS `vi_flow_run`;
/*!50001 DROP VIEW IF EXISTS `vi_flow_run`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vi_flow_run` AS SELECT 
 1 AS `RUN_ID`,
 1 AS `USER_ID`,
 1 AS `PRCS_ID`,
 1 AS `FLOW_PRCS`,
 1 AS `CREATE_TIME`,
 1 AS `PRCS_TIME`,
 1 AS `DELIVER_TIME`,
 1 AS `PRCS_FLAG`,
 1 AS `TOP_FLAG`,
 1 AS `OP_FLAG`,
 1 AS `OTHER_USER`,
 1 AS `BEGIN_USER`,
 1 AS `BEGIN_TIME`,
 1 AS `RUN_NAME`,
 1 AS `FLOW_ID`,
 1 AS `DEL_FLAG`,
 1 AS `FLOW_NAME`,
 1 AS `FLOW_TYPE`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `video_conf`
--

DROP TABLE IF EXISTS `video_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `video_conf` (
  `ID` int(1) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `SERVER` varchar(100) NOT NULL COMMENT '地址ip',
  `PORT` varchar(50) NOT NULL COMMENT '端口',
  `COMPANY_ID` varchar(50) NOT NULL COMMENT '企业ID',
  `CONF_TYPE` char(10) NOT NULL DEFAULT '1' COMMENT '视频会议类型(1-腾讯云会议, 2-全视通)',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='视频会议设置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `video_conf`
--

LOCK TABLES `video_conf` WRITE;
/*!40000 ALTER TABLE `video_conf` DISABLE KEYS */;
INSERT INTO `video_conf` VALUES (1,'','','','1'),(2,'','','','');
/*!40000 ALTER TABLE `video_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_data`
--

DROP TABLE IF EXISTS `vote_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_data` (
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '投票人',
  `ITEM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '投票ID',
  `FIELD_NAME` varchar(20) DEFAULT '1' COMMENT '投票项目名称',
  `FIELD_DATA` text COMMENT '投票项目ID',
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `ITEM_ID` (`ITEM_ID`) USING BTREE,
  KEY `FIELD_NAME` (`FIELD_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='投票结果表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_data`
--

LOCK TABLES `vote_data` WRITE;
/*!40000 ALTER TABLE `vote_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_item`
--

DROP TABLE IF EXISTS `vote_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_item` (
  `ITEM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `VOTE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '投票ID',
  `ITEM_NAME` text COMMENT '选项名称',
  `VOTE_COUNT` int(11) DEFAULT '0' COMMENT '票数',
  `VOTE_USER` text COMMENT '投票人',
  `ANONYMOUS` text COMMENT '匿名名称',
  `VOTE_REASON` text COMMENT '用户投票原因',
  `ATTACHMENT_ID` text COMMENT '附件ID串 ',
  `ATTACHMENT_NAME` text COMMENT '附件文件名串',
  PRIMARY KEY (`ITEM_ID`) USING BTREE,
  KEY `VOTE_ID` (`VOTE_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='投票选项信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_item`
--

LOCK TABLES `vote_item` WRITE;
/*!40000 ALTER TABLE `vote_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_title`
--

DROP TABLE IF EXISTS `vote_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote_title` (
  `VOTE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PARENT_ID` int(11) DEFAULT '0' COMMENT '投票项的上一级VOTE_ID',
  `FROM_ID` varchar(20) DEFAULT '' COMMENT '投票新建人USER_ID',
  `TO_ID` mediumtext COMMENT '发布部门',
  `PRIV_ID` mediumtext COMMENT '发布角色',
  `USER_ID` mediumtext COMMENT '发布用户',
  `SUBJECT` varchar(200) DEFAULT '' COMMENT '标题',
  `CONTENT` mediumtext COMMENT '投票描述',
  `TYPE` varchar(10) DEFAULT '0' COMMENT '类型',
  `MAX_NUM` int(11) DEFAULT '0' COMMENT '选择最大项数',
  `MIN_NUM` int(11) DEFAULT '0' COMMENT '选择最小项数',
  `ANONYMITY` varchar(10) DEFAULT '0' COMMENT '是否匿名(0-不允许匿名,1-允许匿名)',
  `VIEW_PRIV` varchar(10) DEFAULT '0' COMMENT '查看投票结果选项(0-投票后允许查看,1-投票前允许查看,2-不允许查看)',
  `SEND_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',
  `BEGIN_DATE` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '投票开始时间',
  `END_DATE` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '投票结束时间',
  `PUBLISH` varchar(10) DEFAULT '0' COMMENT '发布标记(0-未发布,1-生效,2-终止)',
  `READERS` mediumtext COMMENT '投票者',
  `VOTE_NO` varchar(20) DEFAULT '' COMMENT '排序号',
  `ATTACHMENT_ID` mediumtext COMMENT '附件ID串',
  `ATTACHMENT_NAME` mediumtext COMMENT '附件名称串',
  `TOP` varchar(2) DEFAULT '0' COMMENT '置顶标记(0-不置顶,1-置顶)',
  `VIEW_RESULT_PRIV_ID` mediumtext COMMENT '有查看投票信息权限的角色',
  `VIEW_RESULT_USER_ID` mediumtext COMMENT '有查看投票信息权限的人物',
  `REMIND` int(2) DEFAULT NULL COMMENT '事务提醒(1.提醒，0.不提醒)',
  `SMSREMIND` int(2) DEFAULT NULL COMMENT '短信提醒(1.提醒，0.不提醒)',
  PRIMARY KEY (`VOTE_ID`) USING BTREE,
  KEY `PARENT_ID` (`PARENT_ID`) USING BTREE,
  KEY `FROM_ID` (`FROM_ID`) USING BTREE,
  KEY `SEND_TIME` (`SEND_TIME`) USING BTREE,
  KEY `BEGIN_DATE` (`BEGIN_DATE`) USING BTREE,
  KEY `END_DATE` (`END_DATE`) USING BTREE,
  KEY `VOTE_NO` (`VOTE_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='投票基本信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_title`
--

LOCK TABLES `vote_title` WRITE;
/*!40000 ALTER TABLE `vote_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weather` (
  `wid` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `date` varchar(255) DEFAULT NULL COMMENT '显示天气时间',
  `dateComen` datetime DEFAULT NULL COMMENT '访问天气的时间',
  `location` varchar(255) DEFAULT NULL COMMENT '城市位置',
  `weather` varchar(255) DEFAULT NULL COMMENT '天气（阴晴多云等）',
  `pmTwoPointFive` varchar(255) DEFAULT NULL,
  `tempertureNow` varchar(255) DEFAULT NULL,
  `tempertureOfDay` longtext,
  `week` varchar(255) DEFAULT NULL,
  `wind` varchar(255) DEFAULT NULL,
  `weihao` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`wid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='weather 天气表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather`
--

LOCK TABLES `weather` WRITE;
/*!40000 ALTER TABLE `weather` DISABLE KEYS */;
INSERT INTO `weather` VALUES (1,'2022-07-25','2022-07-25 15:53:57','北京','阴','0','32','24 ~ 33℃','星期一','南风',NULL,'/img/weather/02.png'),(2,'2019-12-31','2019-12-31 16:27:31','湛江','多云','0','23','18 ~ 24℃','星期二','持续无风向','5,0','/img/weather/01.png'),(3,'','2022-04-07 18:41:33',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(4,'','2022-04-07 18:47:17',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(5,'','2022-04-09 19:03:47',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(6,'','2022-04-28 20:30:04',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(7,'','2022-04-28 20:42:52',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(8,'','2022-04-28 20:45:01',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(9,'','2022-04-28 20:45:55',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(10,'','2022-07-25 15:53:51',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined'),(11,'','2022-07-25 15:54:25',NULL,NULL,'0',NULL,NULL,NULL,NULL,NULL,'undefined');
/*!40000 ALTER TABLE `weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webmail`
--

DROP TABLE IF EXISTS `webmail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webmail` (
  `MAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `EMAIL` varchar(200) NOT NULL DEFAULT '' COMMENT '邮件地址',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '用户USER_ID',
  `POP_SERVER` varchar(100) NOT NULL DEFAULT '' COMMENT '接收服务器',
  `SMTP_SERVER` varchar(100) NOT NULL DEFAULT '' COMMENT '发送服务器',
  `LOGIN_TYPE` char(1) NOT NULL DEFAULT '' COMMENT '登录类型',
  `SMTP_PASS` varchar(20) NOT NULL DEFAULT '' COMMENT 'SMTP需要身份验证',
  `EMAIL_USER` varchar(100) NOT NULL COMMENT '登录账户',
  `EMAIL_PASS` varchar(200) NOT NULL DEFAULT '' COMMENT '登录密码',
  `POP3_PORT` int(11) NOT NULL DEFAULT '110' COMMENT '接受服务器端口',
  `SMTP_PORT` int(11) NOT NULL DEFAULT '25' COMMENT '发送服务器端口',
  `IS_DEFAULT` char(1) NOT NULL DEFAULT '0' COMMENT '是否默认邮箱(1-是,0-不是)',
  `POP3_SSL` char(1) NOT NULL DEFAULT '0' COMMENT '此服务器要求SSL安全连接(1-是,0-不是)',
  `SMTP_SSL` char(1) NOT NULL DEFAULT '0' COMMENT '此服务器要求SSL安全连接(1-是,0-不是)',
  `QUOTA_LIMIT` int(11) NOT NULL DEFAULT '0' COMMENT '邮箱容量',
  `EMAIL_UID` mediumtext NOT NULL COMMENT '外部邮件ID串',
  `CHECK_FLAG` char(1) NOT NULL COMMENT '自动收取外部邮件(1-是,0-否)',
  `PRIORITY` char(1) NOT NULL DEFAULT '0' COMMENT '优先级',
  `RECV_DEL` char(1) NOT NULL DEFAULT '0' COMMENT '收信删设置',
  `RECV_REMIND` char(1) NOT NULL DEFAULT '1' COMMENT '新邮件提醒设置',
  `RECV_FW` char(1) NOT NULL COMMENT '转发设置',
  `CREATE_USER` varchar(20) DEFAULT NULL COMMENT '创建者id',
  PRIMARY KEY (`MAIL_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `EMAIL` (`EMAIL`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部邮件';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webmail`
--

LOCK TABLES `webmail` WRITE;
/*!40000 ALTER TABLE `webmail` DISABLE KEYS */;
/*!40000 ALTER TABLE `webmail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webmail_body`
--

DROP TABLE IF EXISTS `webmail_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webmail_body` (
  `BODY_ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `FROM_MAIL` varchar(100) NOT NULL COMMENT '发送邮箱',
  `REPLY_MAIL` varchar(100) NOT NULL COMMENT '回复邮箱',
  `TO_MAIL` text NOT NULL COMMENT '接收邮箱',
  `CC_MAIL` text NOT NULL COMMENT '抄送邮箱',
  `SUBJECT` varchar(200) NOT NULL COMMENT '邮件主题',
  `IS_HTML` char(1) NOT NULL DEFAULT '1' COMMENT '是否有html格式(1-有,0-无)',
  `LARGE_ATTACHMENT` char(1) NOT NULL COMMENT '1-大邮件不接受附件,0-小邮件可接受附件',
  `ATTACHMENT_ID` varchar(3000) NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` varchar(3000) NOT NULL COMMENT '附件名称串',
  `CONTENT_HTML` mediumblob NOT NULL COMMENT '压缩的邮件html格式正文',
  `WEBMAIL_UID` varchar(200) NOT NULL COMMENT '外部邮件的标识符',
  PRIMARY KEY (`BODY_ID`) USING BTREE,
  KEY `LARGE_ATTACHMENT` (`LARGE_ATTACHMENT`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='外部邮件信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webmail_body`
--

LOCK TABLES `webmail_body` WRITE;
/*!40000 ALTER TABLE `webmail_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `webmail_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat`
--

DROP TABLE IF EXISTS `wechat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat` (
  `WID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '发讯人',
  `MESSAGE` mediumtext NOT NULL COMMENT '发讯内容',
  `STIME` int(10) NOT NULL COMMENT '发讯时间',
  `LIKE_IDS` varchar(5000) DEFAULT '' COMMENT '点赞的UIDS串',
  `FILE_ID` mediumtext COMMENT '附件ID串',
  `FILE_NAME` mediumtext COMMENT '附件名字',
  `APP` varchar(50) DEFAULT 'wechat' COMMENT '此条消息来自于哪个模块',
  `APP_ID` int(11) DEFAULT NULL COMMENT '关联业务模块的数据ID',
  `TOPICS` varchar(255) DEFAULT NULL COMMENT '话题的ID串',
  `TOPICS_NAME` varchar(1000) DEFAULT NULL COMMENT '话题的名称',
  `AT_UIDS` varchar(2000) DEFAULT NULL COMMENT '@人员的UID串',
  `MESSAGE_UNI` mediumtext,
  `LOCATE_INFORMATION` varchar(50) DEFAULT NULL COMMENT '定位信息',
  `FORUM_ID` int(11) DEFAULT '1' COMMENT '版块ID',
  PRIMARY KEY (`WID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微讯信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat`
--

LOCK TABLES `wechat` WRITE;
/*!40000 ALTER TABLE `wechat` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_comment`
--

DROP TABLE IF EXISTS `wechat_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_comment` (
  `CID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `WID` int(11) unsigned NOT NULL COMMENT '微博ID',
  `UID` int(11) NOT NULL COMMENT '点评用户的UID',
  `MESSAGE` mediumtext NOT NULL COMMENT '点评内容 ',
  `STIME` int(11) NOT NULL COMMENT '点评保存时间',
  `MESSAGE_UNI` mediumtext COMMENT '内容unicode存储',
  PRIMARY KEY (`CID`) USING BTREE,
  KEY `USER_ID` (`UID`) USING BTREE,
  KEY `ID_TIME` (`WID`,`STIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微讯评论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_comment`
--

LOCK TABLES `wechat_comment` WRITE;
/*!40000 ALTER TABLE `wechat_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_comment_reply`
--

DROP TABLE IF EXISTS `wechat_comment_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_comment_reply` (
  `RID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `MESSAGE` mediumtext NOT NULL COMMENT '回复内容',
  `RTIME` int(11) NOT NULL COMMENT '回复时间',
  `UID` int(11) NOT NULL COMMENT '回复人',
  `CID` int(11) unsigned NOT NULL COMMENT '评论ID',
  `TID` int(11) NOT NULL COMMENT '评论的对象',
  `WID` int(11) NOT NULL COMMENT '微讯ID',
  `MESSAGE_UNI` mediumtext COMMENT '内容unicode存储',
  PRIMARY KEY (`RID`) USING BTREE,
  KEY `ID_TIME` (`CID`,`RTIME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微讯评论回复表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_comment_reply`
--

LOCK TABLES `wechat_comment_reply` WRITE;
/*!40000 ALTER TABLE `wechat_comment_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_comment_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_forum`
--

DROP TABLE IF EXISTS `wechat_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_forum` (
  `FORUM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `FORUM_NAME` varchar(255) DEFAULT NULL COMMENT '版块名称',
  `OPEN_USERS` text COMMENT '开放用户',
  `OPEN_DEPTS` text COMMENT '开放部门',
  PRIMARY KEY (`FORUM_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='社区版块表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_forum`
--

LOCK TABLES `wechat_forum` WRITE;
/*!40000 ALTER TABLE `wechat_forum` DISABLE KEYS */;
INSERT INTO `wechat_forum` VALUES (1,'默认版块','','');
/*!40000 ALTER TABLE `wechat_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_set`
--

DROP TABLE IF EXISTS `wechat_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_set` (
  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `VIEW_SCOPE` char(10) DEFAULT '0' COMMENT '社区内容查看范围（0-全部用户相互可见，1-本分支机构用户相互可见）',
  `PUBLISHING_PERMISSIONS` char(10) DEFAULT '0' COMMENT '社区内容发布权限（0-不限制，1-指定用户发布）',
  `SPECIFY_USER` text COMMENT '社区内容发布权限指定用户',
  `REMOVE_PERMISSIONS` char(10) DEFAULT '0' COMMENT '分支机将管理员可删发木分支机的用户发布的内客（0-分支机构管理员可删除本分支机构用户发布的内容(1-是，0-否）',
  `IS_INDEX` char(10) DEFAULT '1' COMMENT '首页是否显示(0-否，1-是)',
  `DROP_USER` char(10) DEFAULT '0' COMMENT '社区内容删除权限（0-不限制，1-指定用户发布）',
  `DELETE_USER` text COMMENT '社区内容删除权限指定用户',
  PRIMARY KEY (`SID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='社区权限控制表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_set`
--

LOCK TABLES `wechat_set` WRITE;
/*!40000 ALTER TABLE `wechat_set` DISABLE KEYS */;
INSERT INTO `wechat_set` VALUES (1,'0','0','','1','1','0',NULL);
/*!40000 ALTER TABLE `wechat_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wechat_topic`
--

DROP TABLE IF EXISTS `wechat_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wechat_topic` (
  `TOPIC_ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '话题自增ID',
  `TOPIC_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '话题名称',
  `TAKER_UIDS` varchar(2000) NOT NULL DEFAULT '' COMMENT '参与该话题的UID串',
  `COUNT` int(10) NOT NULL COMMENT '话题次数',
  PRIMARY KEY (`TOPIC_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='社区话题表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wechat_topic`
--

LOCK TABLES `wechat_topic` WRITE;
/*!40000 ALTER TABLE `wechat_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `wechat_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weixun_share`
--

DROP TABLE IF EXISTS `weixun_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weixun_share` (
  `WEIXUN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '发讯人',
  `CONTENT` varchar(400) NOT NULL COMMENT '发讯内容',
  `ADDTIME` int(10) NOT NULL COMMENT '发讯时间',
  `TOPICS` varchar(255) NOT NULL COMMENT '话题',
  `MENTIONED_IDS` varchar(200) NOT NULL COMMENT '提到的微讯ID',
  `BROADCAST_IDS` varchar(500) NOT NULL COMMENT '转发的微讯ID',
  `REPOST_ID` int(11) NOT NULL DEFAULT '0',
  `REPOST_ORG_ID` int(11) NOT NULL DEFAULT '0',
  `REPOST_COUNT` int(11) NOT NULL DEFAULT '0',
  `TOPICS_IDS` varchar(255) NOT NULL DEFAULT '' COMMENT '话题的UIDS串',
  `FAVORITE_IDS` varchar(5000) NOT NULL DEFAULT '' COMMENT '收藏的UIDS串',
  `UPVOTE_IDS` varchar(5000) NOT NULL DEFAULT '' COMMENT '点赞的UIDS串',
  `TO_IDS` varchar(5000) NOT NULL DEFAULT '' COMMENT '发送给哪些人 空：全部 非空：接收消息的UIDS',
  `MODULE` varchar(50) NOT NULL DEFAULT 'weixunshare' COMMENT '此条消息来自于哪个模块',
  `MODULE_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '业务模块的关联id',
  PRIMARY KEY (`WEIXUN_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微讯分享信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weixun_share`
--

LOCK TABLES `weixun_share` WRITE;
/*!40000 ALTER TABLE `weixun_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `weixun_share` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weixun_share_follow`
--

DROP TABLE IF EXISTS `weixun_share_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weixun_share_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `uid` int(11) NOT NULL COMMENT '用户UID',
  `follow_uid` int(11) NOT NULL COMMENT '用户关注的UID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weixun_share_follow`
--

LOCK TABLES `weixun_share_follow` WRITE;
/*!40000 ALTER TABLE `weixun_share_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `weixun_share_follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weixun_share_topic`
--

DROP TABLE IF EXISTS `weixun_share_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `weixun_share_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',
  `topic_name` varchar(255) NOT NULL COMMENT '话题名称',
  `followed_uid` varchar(5000) NOT NULL DEFAULT '' COMMENT '关注此话题的UID串',
  PRIMARY KEY (`topic_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微讯话题分享信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weixun_share_topic`
--

LOCK TABLES `weixun_share_topic` WRITE;
/*!40000 ALTER TABLE `weixun_share_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `weixun_share_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widget`
--

DROP TABLE IF EXISTS `widget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widget` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `NAME` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
  `AID` int(10) NOT NULL COMMENT '对应的app模块',
  `TID` int(10) NOT NULL COMMENT '所属类别',
  `DATA` varchar(50) NOT NULL DEFAULT '' COMMENT '该widget请求数据的时候英文参数',
  `IS_SET` char(1) NOT NULL DEFAULT '1' COMMENT '是否允许其他类别使用1允许0不允许',
  `IS_ON` char(1) NOT NULL DEFAULT '1' COMMENT '是否开启',
  `NO` int(11) NOT NULL COMMENT '排序号',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `IS_ON` (`IS_ON`) USING BTREE,
  KEY `TID` (`TID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='widget表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widget`
--

LOCK TABLES `widget` WRITE;
/*!40000 ALTER TABLE `widget` DISABLE KEYS */;
INSERT INTO `widget` VALUES (1,'天气',1,1,'weather','0','1',1),(2,'日程',2,1,'calendar','1','1',2),(3,'日志',3,1,'diary','1','1',6),(4,'邮件',4,1006,'email','1','1',4),(5,'公告',5,1006,'notify','1','1',3),(6,'工作流待办',6,1,'flowRunPrcs','1','1',5),(7,'新闻',0,0,'news','1','1',7),(8,'公文',0,0,'document','1','1',7),(9,'待阅',0,1,'waitRead','1','1',9),(10,'小卓AI',0,1,'XiaoZhuoAI','1','1',10),(11,'最新文件',0,1,'NewFile','1','1',11),(12,'计划填报',0,1,'PlanExecution','1','1',12);
/*!40000 ALTER TABLE `widget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `winexe`
--

DROP TABLE IF EXISTS `winexe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `winexe` (
  `WIN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `WIN_NO` int(11) NOT NULL DEFAULT '0' COMMENT '序号',
  `WIN_DESC` text NOT NULL COMMENT '快捷方式名称',
  `WIN_PATH` text NOT NULL COMMENT '程序路径',
  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '创建人USER_ID',
  PRIMARY KEY (`WIN_ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `WIN_NO` (`WIN_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Windows快捷组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `winexe`
--

LOCK TABLES `winexe` WRITE;
/*!40000 ALTER TABLE `winexe` DISABLE KEYS */;
/*!40000 ALTER TABLE `winexe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_detail`
--

DROP TABLE IF EXISTS `work_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work_detail` (
  `DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',
  `PLAN_ID` varchar(40) DEFAULT '' COMMENT '计划ID',
  `WRITE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '日志/批注撰写时间 ',
  `PROGRESS` text NOT NULL COMMENT '进度详情',
  `PERCENT` int(11) NOT NULL DEFAULT '0' COMMENT '完成百分比',
  `TYPE_FLAG` varchar(10) NOT NULL DEFAULT '' COMMENT '日志类型(0-进度日志,1-领导批注)',
  `WRITER` varchar(50) NOT NULL DEFAULT '' COMMENT '撰写人',
  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',
  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',
  PRIMARY KEY (`DETAIL_ID`) USING BTREE,
  KEY `PLAN_ID` (`PLAN_ID`) USING BTREE,
  KEY `WRITE_TIME` (`WRITE_TIME`) USING BTREE,
  KEY `WRITER` (`WRITER`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='工作进度日志批注表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_detail`
--

LOCK TABLES `work_detail` WRITE;
/*!40000 ALTER TABLE `work_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `vi_flow_run`
--

/*!50001 DROP VIEW IF EXISTS `vi_flow_run`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dev`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vi_flow_run` AS select 1 AS `RUN_ID`,1 AS `USER_ID`,1 AS `PRCS_ID`,1 AS `FLOW_PRCS`,1 AS `CREATE_TIME`,1 AS `PRCS_TIME`,1 AS `DELIVER_TIME`,1 AS `PRCS_FLAG`,1 AS `TOP_FLAG`,1 AS `OP_FLAG`,1 AS `OTHER_USER`,1 AS `BEGIN_USER`,1 AS `BEGIN_TIME`,1 AS `RUN_NAME`,1 AS `FLOW_ID`,1 AS `DEL_FLAG`,1 AS `FLOW_NAME`,1 AS `FLOW_TYPE` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-07 18:50:26
