package com.xoa.service.common.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.util.dataSource.Verification;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

public class PlcSql {


    public static void PlcSql(Integer oid) throws Exception {

        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
        String url = props.getProperty("url" + oid);

        String driver = props.getProperty("driverClassName");
        String username = props.getProperty("uname" + oid);
        String password = props.getProperty("password" + oid);
        Class.forName(driver).newInstance();
        Connection conn = (Connection) DriverManager.getConnection(url, username, password);
        try {

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_assess_score")) {
                String sql = " CREATE TABLE `plc_assess_score` (   `SOCORE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '考核打分主键',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `SUBMIT_TIME` date DEFAULT NULL COMMENT '提交时间',   `PLAN_ITEM_ID` int(11) DEFAULT NULL COMMENT '关联任务ID',   `TG_ID` int(11) DEFAULT NULL COMMENT '关联目标ID',   `HARD_DEGREE` decimal(11,2) DEFAULT NULL COMMENT '难度系数',   `TASK_PRECESS` int(11) DEFAULT NULL COMMENT '完成度',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `MINUS_POINTS` decimal(11,2) DEFAULT NULL COMMENT '扣分项',   `END_SCORE` decimal(11,2) DEFAULT NULL COMMENT '最终得分',   `APPRIVAL_COMMENT` text COMMENT '审核意见',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期，5-完成，6-延期完成，7-暂停，8-关闭)',   `PLAN_CLASS` varchar(10) DEFAULT '1' COMMENT '类型（1-主项计划，2-职能计划，3-任务计划）',   `BELONG_DEPT` int(255) DEFAULT '0' COMMENT '所在部门DEPT_ID',   `APPRIVAL_OPINION` text COMMENT '考核小组审批意见',   `GROUP_APPRIVAL_STATUS` varchar(10) DEFAULT '0' COMMENT '考核小组审批状态(0-未审批，1-已审批)',   `APPRIVAL_STATUS` varchar(10) DEFAULT '0' COMMENT '目标或任务审核状态(0-待考核，1-已考核，2-同意，3-不同意)',   `UNUSUAL_STUFF` text COMMENT '异常原因',   `ATTACHMENT_ID1` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME1` text COMMENT '成果文件NAME串',   `ATTACHMENT_ID2` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME2` text COMMENT '异常支撑材料NAME串',   PRIMARY KEY (`SOCORE_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='计划考核打分表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_assessdata_record")) {
                String sql = " CREATE TABLE `plc_assessdata_record` (   `ADATA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `AD_YEAR` varchar(10) DEFAULT NULL COMMENT '年份',   `AD_QUARTER` varchar(10) DEFAULT NULL COMMENT '季度',   `AD_MONTH` varchar(10) DEFAULT NULL COMMENT '月份',   `DEPT_ID` int(11) DEFAULT NULL COMMENT '用户所在部门',   `USER_ID` varchar(50) DEFAULT NULL COMMENT '用户名',   `SCORE` decimal(11,2) DEFAULT NULL COMMENT '任务或目标得分',   `TG_ID` int(11) DEFAULT NULL COMMENT '所属目标(TG_ID)',   `PLAN_ITEM_ID` int(11) DEFAULT NULL COMMENT '所属任务(PLAN_ITEM_ID)',   `AD_TIME` datetime DEFAULT NULL COMMENT '考核时间',   `AD_USER` varchar(50) DEFAULT NULL COMMENT '考核人USER_ID',   `HARD_DEGREE` decimal(11,2) DEFAULT NULL COMMENT '难度系数',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型',   PRIMARY KEY (`ADATA_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='目标任务考核统计中间表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_dept_daily")) {
                String sql = " CREATE TABLE `plc_dept_daily` (   `DAILY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `PLAN_ITEM_ID` int(11) NOT NULL COMMENT '部门计划任务PLAN_ITEM_ID',   `TASK_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',   `CTREATE_TIME` datetime NOT NULL COMMENT '填报时间',   `CTREATE_USER` varchar(50) NOT NULL DEFAULT '' COMMENT '填报人',   `TADAY_PROGRESS` int(11) NOT NULL DEFAULT '0' COMMENT '今日完成百分比',   `TADAY_DESC` text NOT NULL COMMENT '当日完成情况',   `ATTACHMENT_ID` text COMMENT '成果附件ID',   `ATTACHMENT_NAME` text COMMENT '成果附件NAME',   `UNUSUAL_REASON` text COMMENT '异常原因',   `ATTACHMENT_ID2` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME2` text COMMENT '异常支撑材料名称串',   `DUTY_USER` varchar(50) NOT NULL DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text NOT NULL COMMENT '协作人（多人）',   PRIMARY KEY (`DAILY_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门计划任务执行日报表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_dept_item")) {
                String sql = " CREATE TABLE `plc_dept_item` (   `PLAN_ITEM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `TG_ID` int(11) DEFAULT NULL COMMENT '关联目标TG_ID',   `TASK_NO` varchar(255) DEFAULT '' COMMENT '任务编码',   `TASK_NAME` varchar(255) DEFAULT '' COMMENT '任务名称',   `PARENT_PLAN_ITEM_ID` varchar(255) DEFAULT '' COMMENT '父级任务',   `PRE_TASK` varchar(255) DEFAULT '' COMMENT '前置任务,选择工作项逗号分隔',   `BREAK_TIMES` int(11) DEFAULT NULL COMMENT '分解子任务数量',   `WORK_ITEM_ID` int(11) DEFAULT NULL COMMENT '工作项ITEM_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `MAIN_AREA_DEPT` text COMMENT '一级监督部门',   `MAIN_PROJECT_DEPT` text COMMENT '二级监督部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '异常原因',   `UNUSUAL_STUFF` text COMMENT '异常支撑材料',   `QUALITY_SCORE` varchar(255) DEFAULT '' COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT '' COMMENT '任务状态',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '任务进度(0-100)',   `ATTACHMENT_ID` text COMMENT '任务文件ID串',   `ATTACHMENT_NAME` text COMMENT '任务文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型（DICT_NO）',   `TASK_DESC` text COMMENT '任务说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级任务(0-否，1-是)',   `END_SCORE` decimal(10,0) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT NULL COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   PRIMARY KEY (`PLAN_ITEM_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门计划任务表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_dept_target")) {
                String sql = " CREATE TABLE `plc_dept_target` (   `TG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TG_NO` varchar(255) DEFAULT '' COMMENT '目标编号',   `TG_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '目标名称',   `PARENT_TG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级目标',   `TG_TYPE` varchar(255) DEFAULT '' COMMENT '目标类型（DICT_NO）',   `TG_GRADE` varchar(255) DEFAULT '' COMMENT '目标等级（DICT_NO）',   `TG_DESC` text COMMENT '目标说明',   `MAIN_AREA_DEPT` text COMMENT '一级监督部门',   `MAIN_PROJECT_DEPT` text COMMENT '二级监督部门',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '异常原因',   `UNUSUAL_STUFF` text COMMENT '异常支撑材料',   `QUALITY_SCORE` varchar(255) DEFAULT '' COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT '' COMMENT '目标状态',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '目标进度(0-100)',   `ATTACHMENT_ID` text COMMENT '目标文件ID串',   `ATTACHMENT_NAME` text COMMENT '目标文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '目标类型（DICT_NO）',   `TASK_DESC` text COMMENT '目标说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级目标(0-否，1-是)',   `END_SCORE` decimal(10,0) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT '' COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   PRIMARY KEY (`TG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='部门计划目标表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_edit_record")) {
                String sql = " CREATE TABLE `plc_edit_record` (   `EDIT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `B_EDIT_CONTENT` text COMMENT '修改前内容(字段名称：内容)',   `A_EDIT_CONTENT` text COMMENT '修改后内容(字段名称：内容)',   `TG_ID` int(11) DEFAULT NULL COMMENT '被修改目标ID(TG_ID)',   `PLAN_ITEM_ID` int(11) DEFAULT NULL COMMENT '被修改任务ID(PLAN_ITEM_ID)',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '被修改子项目ID(PBAG_ID)',   `EDIT_USER` varchar(50) DEFAULT NULL COMMENT '修改人',   `EDIT_TIME` datetime DEFAULT NULL COMMENT '修改时间',   PRIMARY KEY (`EDIT_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='子项目、目标、任务主要字段修编记录表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_period_set")) {
                String sql = " CREATE TABLE `plc_period_set` (   `PERIOD_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',   `PERIOD_YEAR` char(10) NOT NULL DEFAULT '' COMMENT '计划年份',   `PERIOD_MONTH` char(10) NOT NULL DEFAULT '' COMMENT '计划月份',   `START_DATE` date NOT NULL COMMENT '起始日期',   `END_DATE` date NOT NULL COMMENT '结束日期',   PRIMARY KEY (`PERIOD_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='计划期间设置表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_plan")) {
                String sql = " CREATE TABLE `plc_plan` (   `PLAN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `PLAN_NO` varchar(255) DEFAULT NULL COMMENT '计划编号',   `PLAN_CLASS` varchar(10) DEFAULT '1' COMMENT '类型（1-主项计划，2-职能计划，3-任务计划）',   `PLAN_NAME` varchar(255) DEFAULT NULL COMMENT '计划名称',   `PLAN_CYCLE` varchar(50) DEFAULT NULL COMMENT '周期类型(DICT_NO)',   `PLAN_YEAR` varchar(50) DEFAULT NULL COMMENT '年度(DICT_NO)',   `PLAN_MONTH` varchar(50) DEFAULT NULL COMMENT '月度(DICT_NO)',   `PLAN_TYPE` varchar(50) DEFAULT NULL COMMENT '计划类型(DICT_NO)',   `DUTY_USER` varchar(50) DEFAULT NULL COMMENT '责任人',   `BELONGTO_PROJ` int(11) DEFAULT NULL COMMENT '所属项目(PROJECT_ID)',   `BELONGTO_DEPT` int(11) DEFAULT NULL COMMENT '所属部门(DEPT_ID)',   `BELONGTO_USER` varchar(50) DEFAULT NULL COMMENT '上报人（USER_ID)）',   `APPRIVAL_STATUS` varchar(255) DEFAULT '0' COMMENT '上报状态(状态(0-未上报，1-已上报(待批)，2-同意，3-不同意)',   `BELONGTO_UNIT` int(11) DEFAULT NULL COMMENT '所属单位（DEPT_ID）',   `AGREE_STATUS` varchar(10) DEFAULT NULL COMMENT '目标审批状态(2-同意，3-不同意)',   `TG_IDS` mediumtext COMMENT '目标ID串(TG_ID)',   `PLAN_ITEM_IDS` mediumtext COMMENT '任务ID串(PLAN_ITEM_ID)',   `PLAN_QUARTER` varchar(50) DEFAULT NULL COMMENT '季度',   `RETURN_COMMENTS` text COMMENT '退回意见',   `QUESTION_NAME` text COMMENT '问题名称',   `MODIFY` varchar(10) DEFAULT '0' COMMENT '是否为计划修改，0-不是计划修改，1-是计划修改',   PRIMARY KEY (`PLAN_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='计划表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_bag")) {
                String sql = " CREATE TABLE `plc_project_bag` (   `PBAG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',   `PARENT_PBAG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级子项目',   `PBAG_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '子项目名称',   `PBAG_NATURE` varchar(50) DEFAULT NULL COMMENT '子项目性质(DICT_NO)',   `PBAG_CONTENT` text COMMENT '子项目内容',   `PBAG_CLASS` varchar(50) DEFAULT NULL COMMENT '子项目分类(DICT_NO)',   `PBAG_TYPE` varchar(50) DEFAULT '' COMMENT '子项目类型(DICT_NO)',   `COST_TYPE` varchar(50) DEFAULT '' COMMENT '成本类型',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `DUTY_USER_TEL` varchar(50) DEFAULT '' COMMENT '责任人电话',   `DUTY_DEPT` int(11) DEFAULT '0' COMMENT '责任部门',   `PLAN_BEGIN_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划结束时间',   `REAL_BEGIN_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `ACCEPT_STANDARD` text COMMENT '验收标准',   `BUDGET_YN` char(10) DEFAULT NULL COMMENT '是否预算控制',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_LEVEL` varchar(50) DEFAULT '' COMMENT '子项目层级(DICT_NO)',   `BUILD_UNIT` varchar(255) DEFAULT '' COMMENT '建设单位',   `DESIGN_UNIT` varchar(255) DEFAULT '' COMMENT '设计单位',   `TRUE_PERIOD` varchar(255) DEFAULT '' COMMENT '实际工期',   `PLAN_PERIOD` varchar(255) DEFAULT '' COMMENT '计划工期',   `PBAG_TARGET` text COMMENT '子项目目标',   `IS_NEW_CHILD` char(10) DEFAULT '0' COMMENT '是否开放下级子项目(0-不开发，1-开发)',   `IS_NEW_ITEM` char(10) DEFAULT '1' COMMENT '是否新建任务(0-否，1-是)',   `IS_NEW_TARGET` char(10) DEFAULT '1' COMMENT '是否新建目标(0-否，1-是)',   `ATTACHMENT_ID` text COMMENT '附件ID串',   `ATTACHMENT_NAME` text COMMENT '附件名称串',   `ISINITIALIZTION` int(11) DEFAULT '0' COMMENT '是否初始化 0 未初始化 1 已初始化',   `BUILD_UNIT_USER` varchar(255) DEFAULT NULL COMMENT '建设单位负责人及电话',   `DESIGN_UNIT_USER` varchar(255) DEFAULT NULL COMMENT '设计单位负责人及电话',   `BAG_STATUS` varchar(10) DEFAULT '1' COMMENT '子项目状态(1-未开始，2-超时未开始，3-正在进行，4-进度滞后，5-进度超前，6-暂停执行，7-正常完成，8-滞后完成，9-提前完成)',   `PURCHASE_UNIT_USER` varchar(255) DEFAULT NULL COMMENT '采购单位负责人及电话',   `BAG_NUMBER` varchar(50) DEFAULT NULL COMMENT '子项目编号',   `AUDITER_STATUS` char(10) DEFAULT NULL COMMENT '审批状态(0-待审批,1-批准，2-不批准)',   `AUDITER` varchar(50) DEFAULT '' COMMENT '审批人',   PRIMARY KEY (`PBAG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目子项目表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_daily")) {
                String sql = " CREATE TABLE `plc_project_daily` (   `DAILY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TG_ID` int(11) DEFAULT NULL COMMENT '项目目标TG_ID',   `TASK_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称',   `CTREATE_TIME` datetime NOT NULL COMMENT '填报时间',   `CTREATE_USER` varchar(50) NOT NULL DEFAULT '' COMMENT '填报人',   `TADAY_PROGRESS` int(11) NOT NULL DEFAULT '0' COMMENT '今日完成百分比',   `TADAY_DESC` text NOT NULL COMMENT '当日完成情况',   `ATTACHMENT_ID` text COMMENT '成果附件ID',   `ATTACHMENT_NAME` text COMMENT '成果附件NAME',   `UNUSUAL_REASON` text COMMENT '异常原因',   `ATTACHMENT_ID2` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME2` text COMMENT '异常支撑材料名称串',   `DUTY_USER` varchar(50) DEFAULT NULL COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `PLAN_ITEM_ID` int(11) DEFAULT NULL COMMENT '任务表PLAN_ITEM_ID',   `DO_STATUS` char(10) DEFAULT '1' COMMENT '进展状态(1-正常，2-延迟，3-完成，4-暂停，5-关闭)',   `COMPLETE_QUANTITY` int(11) DEFAULT '0' COMMENT '累计完成量(0-100)',   `TRANSFER` varchar(50) DEFAULT NULL COMMENT '转办人',   PRIMARY KEY (`DAILY_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目任务执行日报表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_info")) {
                String sql = " CREATE TABLE `plc_project_info` (   `PROJECT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `PROJECT_NO` varchar(255) NOT NULL DEFAULT '' COMMENT '项目编号',   `PROJECT_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '项目名称',   `PROJECT_TYPE` varchar(50) NOT NULL COMMENT '项目类型（DICT_NO）',   `PROJECT_ABBREVIATION` varchar(255) NOT NULL DEFAULT '' COMMENT '项目简称',   `IMPORTANT_YN` char(10) NOT NULL DEFAULT '0' COMMENT '是否是公司重点(0-否，1-是)',   `PROJECT_CODE` varchar(255) NOT NULL DEFAULT '' COMMENT '项目编码',   `PROJECT_PLACE` varchar(255) NOT NULL DEFAULT '' COMMENT '项目地点',   `RESPECTIVE_REGION` varchar(255) NOT NULL DEFAULT '' COMMENT '所属区域',   `OWNER_UNIT` varchar(255) NOT NULL DEFAULT '' COMMENT '业主单位',   `OWNER_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '业主联系人',   `OWNER_PHONE` varchar(255) NOT NULL DEFAULT '' COMMENT '业主联系电话',   `MANAGE_UNIT` varchar(255) NOT NULL DEFAULT '' COMMENT '监理单位',   `MANAGE_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '监理联系人',   `MANAGE_PHONE` varchar(255) NOT NULL DEFAULT '' COMMENT '监理联系电话',   `CONTRACT_MONEY` decimal(14,2) DEFAULT NULL COMMENT '合同总金额',   `CONTRACT_DURATION` varchar(255) NOT NULL DEFAULT '' COMMENT '合同总工期',   `STATRT_TIME` date DEFAULT NULL COMMENT '计划开始时间',   `END_TIME` date DEFAULT NULL COMMENT '计划结束时间',   `PROJECT_MANAGE` varchar(255) DEFAULT '' COMMENT '项目经理',   `PROJECT_MANAGE_PHONE` varchar(255) DEFAULT '' COMMENT '项目经理联系电话',   `PROJECT_CHIEF` varchar(255) DEFAULT NULL COMMENT '项目总工',   `PROJECT_CHIEF_PHONE` varchar(255) DEFAULT '' COMMENT '项目总工电话',   `WINNING_DATE` date DEFAULT NULL COMMENT '中标日期',   `CREATE_USER` varchar(255) NOT NULL DEFAULT '' COMMENT '编制人',   `MAIN_PLAN_TPL` varchar(255) DEFAULT '' COMMENT '计划模板',   `BELONG_DEPT` varchar(255) DEFAULT '' COMMENT '所属上级机构',   `ACCEPT_STANDARD` text COMMENT '验收标准',   `CONTRACT_DEPT` int(11) DEFAULT NULL COMMENT '总承包部',   `WORK_CONTENT` text COMMENT '施工内容',   `BREAK_TIMES` int(11) DEFAULT NULL COMMENT '初始化分解层级',   `REAL_BEGIN_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完工时间',   `PROJECT_STATUS` varchar(255) DEFAULT NULL COMMENT '项目进展(0-在建,1-收尾,2-竣工,3-关闭)',   `ATTACHMENT_ID` text COMMENT '附件ID串',   `ATTACHMENT_NAME` text COMMENT '附件名称串',   `PROJECT_DESC` text COMMENT '项目概述',   `PROJ_ORG_ID` int(11) DEFAULT NULL COMMENT '项目机构主键',   `OVERALL_LEADER` varchar(50) DEFAULT NULL COMMENT '总承包部负责人',   `TARGET_APPRIVAL_STATUS` varchar(10) DEFAULT '0' COMMENT '项目目标审批状态(0-未上报，1-已上报(待批)，2-同意，3-不同意)',   `TARGET_APPRIVAL_COMMENT` text COMMENT '项目目标审批意见',   `PROJ_UD_TYPE` varchar(10) DEFAULT '0' COMMENT '项目人部门类型(0-项目，1-人，2-部门)',   `USER_OR_DEPT` text COMMENT '用户USER_ID或部门DEPT_ID',   `ISINITIALIZTION` int(11) DEFAULT '0' COMMENT '是否初始化(0-未初始化,1-已初始化)',   `ITEM_APPRIVAL_STATUS` varchar(10) DEFAULT '0' COMMENT '项目任务审批状态(0-未上报，1-已上报(待批)，2-同意，3-不同意)',   `EXPERIENCE` text COMMENT '项目经验',   `EXPERIENCE_ATTACHMENT_ID` text COMMENT '项目经验附件id',   `EXPERIENCE_ATTACHMENT_NAME` text COMMENT '项目经验附件名称',   `INFO_CHECK` varchar(255) DEFAULT '' COMMENT '校核、审批人',   `AUDITER_STATUS` char(10) DEFAULT NULL COMMENT '审批状态(0-待审批,1-批准，2-不批准)',   `AUDITER` varchar(50) DEFAULT '' COMMENT '审批人',   `PAYMENT_RATIO1` decimal(10,2) DEFAULT NULL COMMENT '支付比例1',   `SETTLEMENT_RATIO1` decimal(10,2) DEFAULT NULL COMMENT '结算比例1',   `PAYMENT_RATIO2` decimal(10,2) DEFAULT NULL COMMENT '支付比例2',   `SETTLEMENT_RATIO2` decimal(10,2) DEFAULT NULL COMMENT '结算比例2',   `PAYMENT_RATIO3` decimal(10,2) DEFAULT NULL COMMENT '支付比例3',   `SETTLEMENT_RATIO3` decimal(10,2) DEFAULT NULL COMMENT '结算比例3',   `CONTRACT_START_DATE` date DEFAULT NULL COMMENT '合同开始时间',   `CONTRACT_END_DATE` date DEFAULT NULL COMMENT '合同完成时间',   `CONTRACT_CONTINUED_DATE` varchar(255) DEFAULT NULL COMMENT '合同工期',   PRIMARY KEY (`PROJECT_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目信息表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_item")) {
                String sql = " CREATE TABLE `plc_project_item` (   `PLAN_ITEM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `TG_ID` varchar(255) DEFAULT NULL COMMENT '关联目标',   `TASK_NO` varchar(255) DEFAULT '' COMMENT '任务编码',   `TASK_NAME` varchar(255) DEFAULT '' COMMENT '任务名称(工作包名称+工作项名称)',   `PARENT_PLAN_ITEM_ID` varchar(255) DEFAULT '' COMMENT '父级任务',   `PRE_TASK` varchar(255) DEFAULT '' COMMENT '前置任务,选择工作项逗号分隔',   `BREAK_TIMES` int(11) DEFAULT NULL COMMENT '分解子任务数量',   `WORK_ITEM_ID` int(11) DEFAULT NULL COMMENT '工作项ITEM_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `MAIN_AREA_DEPT` text COMMENT '总承包部责任部门',   `MAIN_PROJECT_DEPT` text COMMENT '区域责任部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '异常原因',   `UNUSUAL_STUFF` text COMMENT '异常支撑材料',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期，5-完成，6-延期完成，7-暂停，8-关闭)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '任务进度(0-100)',   `ATTACHMENT_ID` text COMMENT '任务文件ID串',   `ATTACHMENT_NAME` text COMMENT '任务文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型（DICT_NO）',   `TASK_DESC` text COMMENT '任务说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级任务(0-否，1-是)',   `END_SCORE` decimal(10,2) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT NULL COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `WAREHOUSING_YN` char(10) DEFAULT NULL COMMENT '是否入库(0-未入库,1-1已入库)',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `ITEM_BELONG_DEPT` int(11) DEFAULT '0' COMMENT '任务所在部门DEPT_ID',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `ITEM_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '任务审核状态(0-待考核，1-已考核，2-同意，3-不同意)',   `ITEM_REPORTING_STATUS` varchar(10) DEFAULT '0' COMMENT '任务上报状态(0-未上报，1-已上报，2-同意，3-不同意)',   `MINUS_POINTS` decimal(11,2) DEFAULT NULL COMMENT '扣分项',   `APPRIVAL_OPINION` varchar(255) DEFAULT NULL COMMENT '小组审批意见',   `GROUP_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '考核小组审批状态(0-未审批，1-已审批)',   `EXAMINE_STATUS` varchar(10) DEFAULT NULL COMMENT '审批状态（1-正在审批，2-同意，3-退回，4-已上报）',   `ALLOCATION_STATUS` varchar(10) DEFAULT '0' COMMENT '分配状态',   `LINKED_TASK` varchar(255) DEFAULT NULL COMMENT '关联任务',   `RETURN_COMMENTS` text COMMENT '退回意见',   `QUESTION_NAME` text COMMENT '问题名称',   `REVISION` varchar(10) DEFAULT '0' COMMENT '否修编，0-未修编，1已修编',   `EARLY_WARNING` int(11) DEFAULT NULL COMMENT '提前几天提醒',   PRIMARY KEY (`PLAN_ITEM_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目任务表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_item_pretask")) {
                String sql = " CREATE TABLE `plc_project_item_pretask` (   `PRE_TASK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `PLAN_ITEM_ID` int(11) NOT NULL COMMENT '项目计划任务PLAN_ITEM_ID',   `WORK_ITEM_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '任务名称(工作包名称+工作项名称)',   `PRETASK_ITEM_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '前置类型FS SS SF FF',   `EXTEND_DATES` int(11) DEFAULT '0' COMMENT '延隔时间(如：2天)',   PRIMARY KEY (`PRE_TASK_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目任务前置任务表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_org")) {
                String sql = " CREATE TABLE `plc_project_org` (   `PROJ_ORG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '序号',   `PROJECT_NO` varchar(255) DEFAULT NULL COMMENT '编号',   `CONTRACTOR_NAME` varchar(255) DEFAULT NULL COMMENT '总承包部名称',   `CONTRACTORS_NAME` varchar(255) DEFAULT NULL COMMENT '总承包部简称',   `LOCALE_NAME` varchar(255) DEFAULT NULL COMMENT '地点',   `DEPT_ID` int(11) DEFAULT '0' COMMENT '本部门ID（部门表）',   `ORG_TYPE` varchar(255) DEFAULT NULL COMMENT '组织类型（DICT_NO）',   `PRINCIPAL_USER` varchar(50) DEFAULT NULL COMMENT '组织负责人',   `PRINCIPAL_PHONE` varchar(50) DEFAULT NULL COMMENT '联系电话',   `SAFETYMAJORDOMO_USER` varchar(50) DEFAULT NULL COMMENT '安全总监',   `SAFETYMAJORDOMO_PHONE` varchar(50) DEFAULT NULL COMMENT '联系电话',   `DEPT_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '上级部门ID',   `DISABLE_YN` int(11) DEFAULT '1' COMMENT '是否启用（1-启用，0-不启用）',   `PLAN_USER` varchar(50) DEFAULT NULL COMMENT '计划负责人',   `PLAN_PHONE` varchar(50) DEFAULT NULL COMMENT '计划负责人电话',   `BUDGET_USER` varchar(50) DEFAULT NULL COMMENT '预算负责人',   `BUDGET_PHONE` varchar(50) DEFAULT NULL COMMENT '预算负责人电话',   `SHOW_INFO` varchar(50) DEFAULT '1' COMMENT '是否显示项目信息（1-显示，2-不显示）',   `USER_PRIV` text COMMENT '人员授权范围',   `DEPT_PRIV` text COMMENT '部门授权范围',   `ROLE_PRIV` text COMMENT '角色授权范围',   `DEPT_PARENT_IDS` text COMMENT '所有的父级部门ID串',   `ASSESSMENT_TEAM_USERS` text COMMENT '考核小组人员',   PRIMARY KEY (`PROJ_ORG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_target")) {
                String sql = " CREATE TABLE `plc_project_target` (   `TG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TG_NO` varchar(255) DEFAULT '' COMMENT '目标编号',   `TG_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '目标名称',   `PARENT_TG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级目标',   `TG_TYPE` varchar(255) DEFAULT '' COMMENT '目标类型（DICT_NO）',   `TG_GRADE` varchar(255) DEFAULT '' COMMENT '目标等级（DICT_NO）',   `TG_DESC` text COMMENT '目标说明',   `MAIN_AREA_DEPT` text COMMENT '总承包部责任部门',   `MAIN_AREA_USER` varchar(50) DEFAULT '' COMMENT '区域责任部门负责人',   `MAIN_PROJECT_DEPT` text COMMENT '区域责任部门',   `MAIN_PROJECT_USER` varchar(50) DEFAULT '' COMMENT '总承包部责任负责人',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '中心责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '进展情况',   `UNUSUAL_STUFF` text COMMENT '异常原因',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期，5-完成，6-延期完成，7-暂停，8-关闭)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '目标进度(0-100)',   `ATTACHMENT_ID` text COMMENT '目标文件ID串',   `ATTACHMENT_NAME` text COMMENT '目标文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '目标类型（DICT_NO）',   `TASK_DESC` text COMMENT '目标说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级目标(0-否，1-是)',   `END_SCORE` decimal(10,2) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT '' COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `WAREHOUSING_YN` char(10) DEFAULT NULL COMMENT '是否入库 （0-未入库，1-已入库）',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `TARGET_BELONG_DEPT` int(11) DEFAULT '0' COMMENT '目标所在部门DEPT_ID',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `ITEM_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '目标审核状态(0-待考核，1-已考核，2-同意，3-不同意)',   `ITEM_REPORTING_STATUS` varchar(10) DEFAULT '0' COMMENT '目标上报状态(0-未上报，1-已上报，2-同意，3-不同意)',   `MINUS_POINTS` decimal(11,2) DEFAULT NULL COMMENT '扣分项',   `APPRIVAL_OPINION` varchar(255) DEFAULT NULL COMMENT '小组审批意见',   `GROUP_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '考核小组审批状态(0-未审批，1-已审批)',   `EXAMINE_STATUS` varchar(10) DEFAULT NULL COMMENT '审批状态（1-正在审批，2-同意，3-退回，4-已上报）',   `ALLOCATION_STATUS` varchar(10) DEFAULT '0' COMMENT '分配状态',   `LINKED_TARGET` varchar(255) DEFAULT NULL COMMENT '关联目标',   `PRE_TARGET` varchar(255) DEFAULT NULL COMMENT '前置目标',   `IS_IMPORT` varchar(10) DEFAULT '' COMMENT '是否导入模板（0-不是，1-是）',   `RETURN_COMMENTS` text COMMENT '退回意见',   `QUESTION_NAME` text COMMENT '问题名称',   `REVISION` varchar(10) DEFAULT '0' COMMENT '否修编，0-未修编，1已修编',   `CENTER_DUTY` text COMMENT '中心职责',   `AREA_DUTY` text COMMENT '总承包部职责',   `PROJECT_DUTY` text COMMENT '区域职责',   `EARLY_WARNING` int(11) DEFAULT NULL COMMENT '提前几天提醒',   PRIMARY KEY (`TG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目目标表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_project_target_pretask")) {
                String sql = " CREATE TABLE `plc_project_target_pretask` (   `PRE_TG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TG_ID` int(11) NOT NULL COMMENT '项目目标TG_ID',   `WORK_TARGET_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '目标名称',   `PRETASK_ITEM_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '前置类型FS SS SF FF',   `EXTEND_DATES` int(11) DEFAULT '0' COMMENT '延隔时间(如：2天)',   PRIMARY KEY (`PRE_TG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='项目目标前置目标表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_task_item")) {
                String sql = " CREATE TABLE `plc_task_item` (   `TASK_ITEM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',   `TASK_NO` varchar(255) DEFAULT '' COMMENT '任务编码',   `TASK_NAME` varchar(255) DEFAULT '' COMMENT '任务名称(工作包名称+工作项名称)',   `PARENT_PLAN_ITEM_ID` varchar(255) DEFAULT '' COMMENT '父级任务',   `PRE_TASK` varchar(255) DEFAULT '' COMMENT '前置任务,选择工作项逗号分隔',   `BREAK_TIMES` int(11) DEFAULT NULL COMMENT '分解子任务数量',   `WORK_ITEM_ID` int(11) DEFAULT NULL COMMENT '工作项ITEM_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `MAIN_AREA_DEPT` text COMMENT '一级监督部门',   `MAIN_PROJECT_DEPT` text COMMENT '二级监督部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '异常原因',   `UNUSUAL_STUFF` text COMMENT '异常支撑材料',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期,5-完成)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '任务进度(0-100)',   `ATTACHMENT_ID` text COMMENT '任务文件ID串',   `ATTACHMENT_NAME` text COMMENT '任务文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型（DICT_NO）',   `TASK_DESC` text COMMENT '任务说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级任务(0-否，1-是)',   `END_SCORE` decimal(10,2) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT NULL COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `WAREHOUSING_YN` char(10) DEFAULT NULL COMMENT '是否入库(0-未入库,1-1已入库)',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `ITEM_BELONG_DEPT` int(11) DEFAULT '0' COMMENT '任务所在部门DEPT_ID',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `ITEM_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '任务审批状态(0-未审批，1-已审批，2-同意，3-不同意)',   `ITEM_REPORTING_STATUS` varchar(10) DEFAULT '0' COMMENT '任务上报状态(0-未上报，1-已上报，2-同意，3-不同意)',   PRIMARY KEY (`TASK_ITEM_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务库';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_task_template_item")) {
                String sql = " CREATE TABLE `plc_task_template_item` (   `TTASK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',   `TTASK_TYPE_ID` int(11) DEFAULT NULL COMMENT '所属任务模板TTASK_TYPE_ID',   `TASK_NO` varchar(255) DEFAULT '' COMMENT '任务编码',   `TASK_NAME` varchar(255) DEFAULT '' COMMENT '任务名称(工作包名称+工作项名称)',   `PARENT_PLAN_ITEM_ID` varchar(255) DEFAULT '' COMMENT '父级任务',   `PRE_TASK` varchar(255) DEFAULT '' COMMENT '前置任务,选择工作项逗号分隔',   `BREAK_TIMES` int(11) DEFAULT NULL COMMENT '分解子任务数量',   `WORK_ITEM_ID` int(11) DEFAULT NULL COMMENT '工作项ITEM_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '所属部门',   `MAIN_AREA_DEPT` text COMMENT '一级监督部门',   `MAIN_PROJECT_DEPT` text COMMENT '二级监督部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '异常原因',   `UNUSUAL_STUFF` text COMMENT '异常支撑材料',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期,5-完成)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '任务进度(0-100)',   `ATTACHMENT_ID` text COMMENT '任务文件ID串',   `ATTACHMENT_NAME` text COMMENT '任务文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '任务类型（DICT_NO）',   `TASK_DESC` text COMMENT '任务说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级任务(0-否，1-是)',   `END_SCORE` decimal(10,2) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT NULL COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `WAREHOUSING_YN` char(10) DEFAULT NULL COMMENT '是否入库(0-未入库,1-1已入库)',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `ITEM_BELONG_DEPT` int(11) DEFAULT '0' COMMENT '任务所在部门DEPT_ID',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `ITEM_APPRIVAL_STATUS` varchar(10) DEFAULT NULL COMMENT '任务审批状态(0-未审批，1-已审批，2-同意，3-不同意)',   `ITEM_REPORTING_STATUS` varchar(10) DEFAULT '0' COMMENT '任务上报状态(0-未上报，1-已上报，2-同意，3-不同意)',   PRIMARY KEY (`TTASK_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务模板任务项表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_task_template_type")) {
                String sql = " CREATE TABLE `plc_task_template_type` (   `TTASK_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TYPE_NO` varchar(50) NOT NULL DEFAULT '' COMMENT '模板编号',   `TYPE_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '模板名称',   `TPL_TYPE` varchar(255) NOT NULL DEFAULT '' COMMENT '模板类型(项目/工区/工程)',   `PARENT_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级模板ID',   `TPL_TYPE_DESC` text NOT NULL COMMENT '模板类型描述',   `DISABLE_YN` varchar(10) DEFAULT '1' COMMENT '是否停用（1-使用,2-停用',   PRIMARY KEY (`TTASK_TYPE_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务模板分类';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_template_item")) {
                String sql = " CREATE TABLE `plc_template_item` (   `TG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TPL_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '目标模板分类TPL_TYPE_ID',   `TG_NO` varchar(255) DEFAULT '' COMMENT '目标编号',   `TG_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '目标名称',   `PARENT_TG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级目标',   `TG_TYPE` varchar(255) DEFAULT '' COMMENT '目标类型（DICT_NO）',   `TG_GRADE` varchar(255) DEFAULT '' COMMENT '目标等级（DICT_NO）',   `TG_DESC` text COMMENT '目标说明',   `MAIN_AREA_DEPT` text COMMENT '责任区域部门',   `MAIN_PROJECT_DEPT` text COMMENT '责任项目部门',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '责任中心部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果描述',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '进展情况',   `UNUSUAL_STUFF` text COMMENT '异常原因',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期,5-完成)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '目标进度(0-100)',   `ATTACHMENT_ID` text COMMENT '目标文件ID串',   `ATTACHMENT_NAME` text COMMENT '目标文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '目标类型（DICT_NO）',   `TASK_DESC` text COMMENT '目标说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级目标(0-否，1-是)',   `END_SCORE` decimal(10,0) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT '' COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `WAREHOUSING_YN` char(10) DEFAULT NULL COMMENT '是否入库 （0-未入库，1-已入库）',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `FORCE_CHECK` varchar(10) DEFAULT NULL COMMENT '是否强制勾选（0-不是，1-是）',   `CENTER_DUTY` text COMMENT '中心职责',   `AREA_DUTY` text COMMENT '总承包部职责',   `PROJECT_DUTY` text COMMENT '区域职责',   PRIMARY KEY (`TG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='目标模板工作项表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_template_type")) {
                String sql = " CREATE TABLE `plc_template_type` (   `TPL_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TYPE_NO` varchar(50) NOT NULL DEFAULT '' COMMENT '模板编号',   `TYPE_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '模板名称',   `TPL_TYPE` varchar(255) NOT NULL DEFAULT '' COMMENT '模板类型(项目/工区/工程)',   `TPL_TYPE_DESC` text COMMENT '模板类型描述',   `PARENT_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级模板ID',   `DISABLE_YN` varchar(10) DEFAULT '1' COMMENT '是否停用1-使用,2-停用',  `LEVEL` varchar(255) DEFAULT NULL COMMENT '初始化等级',   PRIMARY KEY (`TPL_TYPE_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='目标模板分类';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_work_item")) {
                String sql = " CREATE TABLE `plc_work_item` (   `TG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',   `TG_NO` varchar(255) DEFAULT '' COMMENT '目标编号',   `TG_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '目标名称',   `PARENT_TG_ID` int(11) NOT NULL DEFAULT '0' COMMENT '上级目标',   `TG_TYPE` varchar(255) DEFAULT '' COMMENT '目标类型（DICT_NO）',   `TG_GRADE` varchar(255) DEFAULT '' COMMENT '目标等级（DICT_NO）',   `TG_DESC` text COMMENT '目标说明',   `MAIN_AREA_DEPT` text COMMENT '责任区域部门',   `MAIN_PROJECT_DEPT` text COMMENT '责任项目部门',   `PROJECT_ID` int(11) DEFAULT NULL COMMENT '所属项目PROJECT_ID',   `PBAG_ID` int(11) DEFAULT NULL COMMENT '所属子项目PBAG_ID',   `DUTY_USER` varchar(50) DEFAULT '' COMMENT '责任人',   `ASSIST_USER` text COMMENT '协作人（多人）',   `MAIN_CENTER_DEPT` text COMMENT '责任中心部门',   `ASSIST_COMPANY_DEPTS` text COMMENT '协助部门DEPT_IDS',   `PLAN_TYPE` varchar(50) DEFAULT '' COMMENT '计划类型（DICT_NO）',   `PLAN_STAGE` varchar(50) DEFAULT '' COMMENT '计划阶段（DICT_NO）',   `PLAN_RATE` varchar(50) DEFAULT '' COMMENT '计划形式（DICT_NO）',   `PLAN_LEVEL` varchar(50) DEFAULT '' COMMENT '计划级次（DICT_NO）',   `CONTROL_LEVEL` varchar(50) DEFAULT '' COMMENT '关注等级（DICT_NO）',   `ACCORDING` varchar(255) DEFAULT '' COMMENT '工作项依据（DICT_NO）',   `IS_KEYPOINT` char(10) DEFAULT '0' COMMENT '是否关键工作项(0-否，1-是)',   `IS_EXAM` char(10) DEFAULT '0' COMMENT '是否考核(0-不考核，1-考核)',   `IS_RESULT` varchar(255) DEFAULT '0' COMMENT '是否提交成果(0-不提交，1-提交)',   `PLAN_SYCLE` varchar(255) DEFAULT '' COMMENT '周期类型（DICT_NO）',   `FLOW_ID` int(11) DEFAULT '0' COMMENT '审批流程FLOW_ID',   `PLAN_START_DATE` date DEFAULT NULL COMMENT '计划开始时间',   `PLAN_END_DATE` date DEFAULT NULL COMMENT '计划完成时间',   `PLAN_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '计划工期',   `REAL_START_DATE` date DEFAULT NULL COMMENT '实际开始时间',   `REAL_END_DATE` date DEFAULT NULL COMMENT '实际完成时间',   `REAL_CONTINUED_DATE` varchar(255) DEFAULT '' COMMENT '实际工期',   `STANDARD_DEGREE` int(11) DEFAULT NULL COMMENT '标准难度系数',   `HARD_DEGREE` decimal(11,2) DEFAULT '0.00' COMMENT '难度系数',   `RESULT_CONFIRM` text COMMENT '成果确认',   `RESULT_DESC` text COMMENT '成果材料',   `FINAL_RESULT_DESC` varchar(255) DEFAULT '' COMMENT '最终交付成果描述',   `UNUSUAL_RES` text COMMENT '进展情况',   `UNUSUAL_STUFF` text COMMENT '异常原因',   `QUALITY_SCORE` decimal(11,2) DEFAULT NULL COMMENT '质量得分',   `TASK_STATUS` char(10) DEFAULT NULL COMMENT '任务状态(0-未开始，1-进行中，2-将到期，4-已延期,5-完成)',   `TASK_PRECESS` int(11) DEFAULT '0' COMMENT '目标进度(0-100)',   `ATTACHMENT_ID` text COMMENT '目标文件ID串',   `ATTACHMENT_NAME` text COMMENT '目标文件名称串',   `TASK_TYPE` varchar(50) DEFAULT NULL COMMENT '目标类型（DICT_NO）',   `TASK_DESC` text COMMENT '目标说明',   `ATTACHMENT_ID2` text COMMENT '成果文件ID串',   `ATTACHMENT_NAME2` text COMMENT '成果文件名称串',   `RISK_POINT` text COMMENT '风险点',   `DIFFICULT_POINT` text COMMENT '难度点',   `OPEN_NEXT_TASK` char(10) DEFAULT '0' COMMENT '是否开放下级目标(0-否，1-是)',   `END_SCORE` decimal(10,0) DEFAULT NULL COMMENT '最终得分',   `RESULT_STANDARD` text COMMENT '完成标准',   `ITEM_QUANTITY` varchar(50) DEFAULT '' COMMENT '工程量',   `ITEM_QUANTITY_NUIT` varchar(50) DEFAULT NULL COMMENT '工程量单位',   `DEPT_OR_PROJECT` char(10) DEFAULT NULL COMMENT '区分项目、部门任务 （0-项目任务，1-部门任务）',   `WAREHOUSING_YN` char(10) DEFAULT '1' COMMENT '是否启用 （0-不启用，1-启用）',   `EMERGENCY` int(11) DEFAULT NULL COMMENT '紧急程度(1-重要紧急，2-重要不紧急，3-不重要紧急，4-不重要不紧急)',   `DESIGN_QUANTITY` varchar(50) DEFAULT '' COMMENT '设计量',   `ATTACHMENT_ID3` text COMMENT '异常支撑材料ID串',   `ATTACHMENT_NAME3` text COMMENT '异常支撑材料文件名称串',   `COMPLETE_QUANTITY` varchar(50) DEFAULT '' COMMENT '完成量',   `APPRIVAL_COMMENT` text COMMENT '审批意见',   `RESULT_DICT` varchar(255) DEFAULT '' COMMENT '成果材料（DICT_NO）',   `FORCE_CHECK` varchar(10) DEFAULT NULL COMMENT '是否强制勾选（0-不是，1-是）',   `CENTER_DUTY` text COMMENT '中心职责',   `AREA_DUTY` text COMMENT '总承包部职责',   `PROJECT_DUTY` text COMMENT '区域职责',   PRIMARY KEY (`TG_ID`) USING BTREE ) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='工作项库表';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_dictionary")) {
                String sql = "CREATE TABLE `plc_dictionary`  (\n" +
                        "  `DICT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',\n" +
                        "  `DICT_NO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典编号',\n" +
                        "  `DICT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典名称',\n" +
                        "  `DICT_ORDER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典排序号',\n" +
                        "  `PARENT_NO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典主分类（存主分类的字典编码）',\n" +
                        "  `REMARKS` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '字典备注',\n" +
                        "  `FACILITY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '字典功能',\n" +
                        "  `SHOW_STYLE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '表现形式',\n" +
                        "  `CREATE_TIME` datetime(0) DEFAULT NULL COMMENT '编制时间',\n" +
                        "  `CREATE_USER` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '编制人',\n" +
                        "  PRIMARY KEY (`DICT_ID`) USING BTREE\n" +
                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = Compact;\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
                sql = "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PLAN_TYPE', '计划类型', '01', '', '计划类型', '', '', '2020-04-16 20:33:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '主项目标', '0', 'PLAN_TYPE', '2', '2', '', '2020-08-12 18:26:27', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PLAN_LEVEL', '计划级次', '02', '', '计划级次', '', '', '2020-04-17 11:01:01', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '一级', '0', 'PLAN_LEVEL', '', '', '1', '2020-04-17 11:02:23', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '二级', '0', 'PLAN_LEVEL', '', '', '1.1', '2020-04-17 11:02:33', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '三级', '0', 'PLAN_LEVEL', '', '', '1.1.1', '2020-04-17 11:02:42', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '四级', '0', 'PLAN_LEVEL', '', '', '1.1.1.1', '2020-04-17 11:02:50', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('5', '五级', '0', 'PLAN_LEVEL', '', '', '1.1.1.1.1', '2020-04-17 11:03:02', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PLAN_PHASE', '计划阶段', '03', '', '', '', '', '2020-04-17 11:03:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '前期经营', '0', 'PLAN_PHASE', '', '', '', '2020-04-17 11:04:11', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '设计', '0', 'PLAN_PHASE', '', '', '', '2020-04-17 11:04:29', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '施工', '0', 'PLAN_PHASE', '', '', '', '2020-04-17 11:04:35', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '验收', '0', 'PLAN_PHASE', '', '', '', '2020-04-17 11:04:42', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '顶层关注', '0', 'CONTROL_LEVEL', '', '', '', '2020-04-17 11:05:31', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '一级', '0', 'CONTROL_LEVEL', '', '', '', '2020-04-17 11:05:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '二级', '0', 'CONTROL_LEVEL', '', '', '', '2020-04-17 11:05:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '三级', '0', 'CONTROL_LEVEL', '', '', '', '2020-04-17 11:05:52', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PROJECT_TYPE', '项目类型', '05', '', '', '', '', '2020-04-17 11:41:23', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', 'PPP项目', '0', 'PROJECT_TYPE', '', '', '', '2020-04-28 11:12:04', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '成本类', '0', 'PBAG_TYPE', '', '', '', '2020-04-28 11:21:57', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '费用类', '0', 'PBAG_TYPE', '', '', '', '2020-04-28 11:22:03', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '一级', '0', 'PBAG_LEVEL', '', '', '', '2020-04-17 19:57:47', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '二级', '0', 'PBAG_LEVEL', '', '', '', '2020-04-17 19:57:56', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '三级', '0', 'PBAG_LEVEL', '', '', '', '2020-04-17 19:58:09', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('COST_TYPE', '成本类型', '08', '', '成本类型', '', '', '2020-04-17 19:58:51', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '成本', '0', 'COST_TYPE', '', '', '', '2020-07-17 17:07:24', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '费用', '0', 'COST_TYPE', '', '', '', '2020-07-17 17:07:29', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PLAN_RATE', '计划形式', '10', '', '', '', '', '2020-04-22 16:05:49', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '一次性', '0', 'PLAN_RATE', '', '', '', '2020-07-10 15:03:04', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '每周', '0', 'PLAN_RATE', '', '', '', '2020-07-10 20:36:07', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PLAN_SYCLE', '周期类型', '11', '', '', '', '', '2020-04-28 10:24:44', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('CONTROL_LEVEL', '关注等级', '12', '', '', '', '', '2020-04-28 10:25:21', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('TASK_TYPE', '任务类型（不用）', '13', '', '', '', '', '2020-07-17 17:08:10', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('TG_TYPE', '目标类型', '14', '', '', '', '', '2020-04-28 11:29:57', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PBAG_LEVEL', '子项目层级', '15', '', '', '', '', '2020-04-28 10:31:31', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PBAG_CLASS', '子项目分类', '16', '', '', '', '', '2020-04-28 10:33:08', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PBAG_NATURE', '子项目性质', '17', '', '', '', '', '2020-04-28 10:33:25', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('PBAG_TYPE', '子项目类型', '18', '', '', '', '', '2020-04-28 10:33:42', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '质量目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:12:48', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '安全目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:14:05', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '进度目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:14:33', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '设计目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:14:59', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('5', '工程量目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:15:22', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('6', '营销目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:15:39', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('7', '管理目标', '0', 'TG_TYPE', '', '', '', '2020-04-28 11:15:49', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '设计类', '0', 'TASK_TYPE', '', '', '', '2020-04-28 11:17:51', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '管理类', '0', 'TASK_TYPE', '', '', '', '2020-04-28 11:18:04', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '施工类', '0', 'TASK_TYPE', '', '', '', '2020-04-28 11:18:27', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '安全类', '0', 'TASK_TYPE', '', '', '', '2020-04-28 11:20:10', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '整体', '0', 'PLAN_SYCLE', '', '', '', '2020-04-28 11:20:53', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '年度', '0', 'PLAN_SYCLE', '', '', '', '2020-04-28 11:21:02', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '季度', '0', 'PLAN_SYCLE', '', '', '', '2020-04-28 11:21:09', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '月度', '0', 'PLAN_SYCLE', '', '', '', '2020-04-28 11:21:19', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '管网施工', '0', 'PBAG_CLASS', '', '', '', '2020-08-19 18:02:53', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '河道清淤', '0', 'PBAG_CLASS', '', '', '', '2020-04-28 11:22:44', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '接驳工程', '0', 'PBAG_CLASS', '', '', '', '2020-04-28 11:22:53', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '湿地工程', '0', 'PBAG_CLASS', '', '', '', '2020-04-28 11:23:10', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('TG_GRADE', '目标等级', '19', '', '', '', '', '2020-04-28 11:34:08', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('1', '新建项目', '0', 'PBAG_NATURE', '', '', '', '2020-04-28 11:43:33', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', '扩建项目', '0', 'PBAG_NATURE', '', '', '', '2020-04-28 11:43:47', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', '改建项目', '0', 'PBAG_NATURE', '', '', '', '2020-04-28 11:44:00', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('4', '迁建项目', '0', 'PBAG_NATURE', '', '', '', '2020-04-28 11:44:28', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '一级', '0', 'TG_GRADE', '', '', '', '2020-04-28 14:27:50', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '二级', '0', 'TG_GRADE', '', '', '', '2020-04-28 14:28:00', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '三级', '0', 'TG_GRADE', '', '', '', '2020-04-28 14:28:15', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('ACCORDING', '工作项依据', '20', '', '', '', '', '2020-04-28 15:43:12', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '建筑', '0', 'ACCORDING', '', '', '', '2020-04-28 15:44:05', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '河流', '0', 'ACCORDING', '', '', '', '2020-04-28 15:44:38', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('CUSTOMER_UNIT', '客户管理', '98', '', '', '', '', '2020-06-12 15:21:38', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('RENWUJIHUA_TYPE', '任务类型', '09', '', '', '', '', '2020-07-17 17:08:18', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '计划分解', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-09-15 16:44:42', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '领导分配', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-06-19 14:51:13', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '专项分配', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-06-19 14:51:25', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '日常工作', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-06-19 14:51:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '外部临时', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-06-19 14:51:57', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '内部临时', '0', 'RENWUJIHUA_TYPE', '', '', '', '2020-06-19 14:52:06', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('WORKAREA_NAME', '工区名称', '100', '', '', '', '', '2020-06-16 16:17:32', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('001', '一工区', '0', 'WORKAREA_NAME', '', '', '', '2020-06-16 15:30:34', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('002', '二工区', '0', 'WORKAREA_NAME', '', '', '', '2020-06-16 15:30:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('003', '三工区', '0', 'WORKAREA_NAME', '', '', '', '2020-06-16 15:34:38', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('004', '四工区', '0', 'WORKAREA_NAME', '', '', '', '2020-06-16 15:35:19', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('005', '五工区', '0', 'WORKAREA_NAME', '', '', '', '2020-06-16 15:35:27', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('ORG_TYPE', '机构类型', '11', '', '', '', '', '2020-06-19 15:40:59', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '中心部门', '0', 'ORG_TYPE', '部门', '', '', '2020-07-13 15:46:28', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '区域部门', '0', 'ORG_TYPE', '部门', '', '', '2020-07-13 15:46:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('CGCL_TYPE', '成果材料', '130', '', '', '', '', '2020-06-22 19:55:39', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '《开工令》', '0', 'CGCL_TYPE', '', '', '', '2020-07-01 23:36:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '《结算单》', '0', 'CGCL_TYPE', '', '', '', '2020-07-01 23:36:56', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('UNIT', '单位', '135', '', '', '', '', '2020-06-23 19:08:13', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '米', '0', 'UNIT', '', '', '', '2020-06-23 19:08:47', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '天', '0', 'UNIT', '', '', '', '2020-06-23 19:09:03', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '吨', '0', 'UNIT', '', '', '', '2020-06-23 19:09:13', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '升', '0', 'UNIT', '', '', '', '2020-06-23 19:09:24', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '《中标通知书》', '0', 'CGCL_TYPE', '', '', '', '2020-07-01 23:37:07', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('2', 'EPC项目', '0', 'PROJECT_TYPE', '', '', '', '2020-07-01 23:33:17', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('3', 'EPC+O项目', '0', 'PROJECT_TYPE', '', '', '', '2020-07-01 23:33:48', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('ORGANIZATION_TYPE', '组织层级', '9', '', '', '', '', '2020-07-13 15:56:36', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '综合管理部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:10', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '工程管理部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:12', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '财务管理部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:15', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '设计管理部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:20', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '总承包部部门', '0', 'ORG_TYPE', '部门', '', '', '2020-07-13 15:46:42', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '子公司部门', '0', 'ORG_TYPE', '部门', '', '', '2020-07-13 15:46:45', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '每月', '0', 'PLAN_RATE', '', '', '', '2020-07-10 20:36:15', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '每季度', '0', 'PLAN_RATE', '', '', '', '2020-07-10 20:36:25', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '区域总部', '0', 'ORG_TYPE', '区域总部', '', '', '2020-07-13 15:47:31', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '子公司', '0', 'ORG_TYPE', '子公司', '', '', '2020-07-13 15:47:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '总承包部', '0', 'ORG_TYPE', '总承包部', '', '', '2020-07-13 15:48:03', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '安全环保部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:22', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '运营管理部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:06', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '市场营销部', '0', 'ORGANIZATION_TYPE', '区域总部层级', '区域责任部门', '', '2020-07-23 12:01:26', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '综合部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:38', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('FUNC_OP_PRIV', '模块功能权限', '150', '', '', '', '', '2020-07-07 17:19:52', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('01', '新增', '0', 'FUNC_OP_PRIV', '新增', '7203,7217,7218,7224,7220,7221,7222,', '', '2020-07-17 16:45:18', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '导入', '0', 'FUNC_OP_PRIV', '导入', '7201,7202,7203,7221,7222,', '', '2020-07-17 16:45:22', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '导出', '0', 'FUNC_OP_PRIV', '导出', '7201,7202,7203,', '', '2020-07-17 16:45:25', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '删除', '0', 'FUNC_OP_PRIV', '删除', '7201,7202,7203,7204,7217,7218,7224,7253,7220,7221,7222,7206,', '', '2020-08-25 12:56:22', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '编辑', '0', 'FUNC_OP_PRIV', '编辑', '7201,7202,7203,7204,7217,7218,7224,7253,7220,7221,7222,', '', '2020-07-17 16:45:43', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '修编', '0', 'FUNC_OP_PRIV', '修编', '7201,7202,7203,7204,', '', '2020-07-21 17:14:56', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '初始化', '0', 'FUNC_OP_PRIV', '初始化', '7202,7203,', '', '2020-07-17 16:41:16', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '上报', '0', 'FUNC_OP_PRIV', '上报', '7206,', '', '2020-08-25 12:55:41', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '查询', '0', 'FUNC_OP_PRIV', '所有页面', '7201,7202,7203,7204,7206,7250,7207,7320,7210,7211,7213,7214,7215,7217,7218,7224,7253,7220,7221,7222,7219,7250,7251,7206,7209,7315,7252,', '', '2020-09-08 09:09:56', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '审核', '0', 'FUNC_OP_PRIV', '审批', '7209,7319,7252,', '', '2020-08-31 09:57:14', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '添加平级', '0', 'FUNC_OP_PRIV', '添加平级', '7202,7204,', '', '2020-07-17 16:45:55', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('12', '添加下一级', '0', 'FUNC_OP_PRIV', '添加下一级', '7202,7204,', '', '2020-07-17 16:45:58', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('13', '今日', '0', 'FUNC_OP_PRIV', '今日', '7210,7320,', '', '2020-08-25 13:40:49', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('14', '增加协作人', '0', 'FUNC_OP_PRIV', '增加协作人', '7210,7320,', '', '2020-08-25 13:41:00', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('15', '转办', '0', 'FUNC_OP_PRIV', '转办', '7210,7320,', '', '2020-08-25 13:40:56', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('16', '提交考核', '0', 'FUNC_OP_PRIV', '提交考核', '7210,7320,', '', '2020-08-25 13:40:10', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '《合同》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:34:54', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '《公司发文》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:35:05', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '《委托协议书》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:35:24', '164');\n";
                st.executeUpdate(sql);
                sql = "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '《项目管理策划报告》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:35:44', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '《会议纪要》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:35:54', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '《现场照片》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:36:10', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '《项目整体经营目标责任书》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:36:57', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '《保函》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:37:19', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('12', '《勘察方案》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:37:49', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('13', '《结算单》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:38:41', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('14', '《验收报告》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:38:55', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('15', '《整体进度计划》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:50:56', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('16', '《项目整体预算》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:51:09', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('17', '《施工组织方案》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:51:25', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('18', '《安全措施计划》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:51:42', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('19', '《可研方案》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:51:55', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('20', '《初设方案》', '0', 'CGCL_TYPE', '', '', '', '2020-08-19 17:59:43', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('21', '《施工白图》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:52:24', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('22', '《施工蓝图》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:52:33', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('23', '《交付单》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:53:02', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('24', '《审计报告》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:53:15', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('25', '《退回质保金申请》', '0', 'CGCL_TYPE', '', '', '', '2020-07-02 09:53:43', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('26', '《报告》', '0', 'CGCL_TYPE', '', '', '', '2020-07-03 09:34:10', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('27', '《表单》', '0', 'CGCL_TYPE', '', '', '', '2020-07-03 09:34:20', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('17', '保存', '0', 'FUNC_OP_PRIV', '', '7253,7209,7252,', '', '2020-08-25 13:17:07', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('18', '取消', '0', 'FUNC_OP_PRIV', '', '', '', '2020-07-17 16:46:19', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('19', '添加项目', '0', 'FUNC_OP_PRIV', '', '7201,', '', '2020-07-17 16:46:23', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('20', '项目进展', '0', 'FUNC_OP_PRIV', '', '7201,', '', '2020-07-17 16:46:26', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('21', '提交', '0', 'FUNC_OP_PRIV', '', '7201,7202,7203,7204,7203,', '', '2020-07-25 14:32:31', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('22', '暂停', '0', 'FUNC_OP_PRIV', '', '7202,', '', '2020-07-17 16:46:35', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('23', '禁用', '0', 'FUNC_OP_PRIV', '', '7221,7222,', '', '2020-07-17 16:46:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('24', '模板导入', '0', 'FUNC_OP_PRIV', '', '7206,7204,', '', '2020-07-21 17:01:57', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('25', '退回', '0', 'FUNC_OP_PRIV', '', '7206,7207,7250,7251,', '', '2020-08-25 16:43:29', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('26', '任务分配', '0', 'FUNC_OP_PRIV', '', '', '', '2020-08-25 13:13:06', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('27', '完成', '0', 'FUNC_OP_PRIV', '', '7211,7209,7319,7252,', '', '2020-08-27 09:30:10', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('28', '查看明细', '0', 'FUNC_OP_PRIV', '', '7214,7215,', '', '2020-07-17 16:46:59', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('29', '重置', '0', 'FUNC_OP_PRIV', '', '7253,', '', '2020-07-17 16:47:03', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '立方米', '0', 'UNIT', '', '', '', '2020-07-17 16:22:22', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('30', '右新增', '0', 'FUNC_OP_PRIV', '', '7217,', '', '2020-07-17 16:45:14', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('31', '右修改', '0', 'FUNC_OP_PRIV', '', '7221,7222,7217,', '', '2020-07-17 21:29:01', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('32', '右删除', '0', 'FUNC_OP_PRIV', '', '7221,7222,7217,', '', '2020-07-17 21:28:17', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '年度重点', '0', 'TG_TYPE', '', '', '', '2020-09-15 16:50:20', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('04', '施工项目', '0', 'PROJECT_TYPE', '', '', '', '2020-07-17 17:06:35', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', 'BOT项目', '0', 'PROJECT_TYPE', '', '', '', '2020-07-17 17:06:45', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', 'PC项目', '0', 'PROJECT_TYPE', '', '', '', '2020-07-17 17:06:58', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '四级', '0', 'CONTROL_LEVEL', '', '', '', '2020-07-17 17:07:44', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '六工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:08:41', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '七工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:08:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '八工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:08:54', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '九工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:09:00', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '十工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:09:05', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '十一工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:09:11', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('12', '十二工区', '0', 'WORKAREA_NAME', '', '', '', '2020-07-17 17:09:16', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('33', '同意', '0', 'FUNC_OP_PRIV', '同意', '7206,7207,7250,7251,', '', '2020-08-25 16:43:39', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('35', '归档', '0', 'FUNC_OP_PRIV', '归档', '7211,', '', '2020-07-17 21:19:18', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('36', '经验总结', '0', 'FUNC_OP_PRIV', '经验总结', '7211,', '', '2020-07-17 21:19:23', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('37', '转模板', '0', 'FUNC_OP_PRIV', '转模板', '7211,', '', '2020-07-17 21:21:41', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('38', '提交审核', '0', 'FUNC_OP_PRIV', '', '7201,', '', '2020-08-25 13:39:10', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('39', '修编详情', '0', 'FUNC_OP_PRIV', '修编详情', '7202,7203,7204,', '', '2020-07-21 17:15:02', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '财务部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:40', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '工程部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:43', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '合同部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:46', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('12', '安全部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:49', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('13', '设计部', '0', 'ORGANIZATION_TYPE', '总承包部', '总承包部责任部门', '', '2020-07-23 12:01:53', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '整体目标', '0', 'TG_TYPE', '', '', '', '2020-07-23 14:25:42', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '年中目标', '0', 'TG_TYPE', '', '', '', '2020-07-23 14:25:55', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '季度目标', '0', 'TG_TYPE', '', '', '', '2020-07-23 14:26:03', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('12', '月度目标', '0', 'TG_TYPE', '', '', '', '2020-07-23 14:26:12', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('28', '《支付单》', '0', 'CGCL_TYPE', '', '', '', '2020-07-24 10:03:47', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('02', '职能目标', '0', 'PLAN_TYPE', '', '', '', '2020-07-24 10:52:49', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('03', '计划任务', '0', 'PLAN_TYPE', '', '', '', '2020-07-24 10:52:55', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('29', '其它', '0', 'CGCL_TYPE', '', '', '', '2020-07-24 15:19:22', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '%', '0', 'UNIT', '', '', '', '2020-07-24 15:44:37', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '运营', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:09:02', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '结算', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:09:11', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '准备', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:09:23', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '策划', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:11:24', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '竣工', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:14:12', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '收尾', '0', 'PLAN_PHASE', '', '', '', '2020-07-26 13:15:50', 'admin');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('40', '分配完成', '0', 'FUNC_OP_PRIV', '', '7318,', '', '2020-08-25 13:13:19', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('05', '防洪工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 08:36:08', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('06', '园林绿化', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 08:36:16', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('07', '物联网工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 08:36:24', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '水利工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 15:00:52', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('09', '房屋建筑工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 15:00:59', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('10', '公路工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 15:01:06', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('11', '市政工程', '0', 'PBAG_CLASS', '', '', '', '2020-08-25 15:01:14', '164');\n" +
                        "INSERT INTO `plc_dictionary`(`DICT_NO`, `DICT_NAME`, `DICT_ORDER`, `PARENT_NO`, `REMARKS`, `FACILITY`, `SHOW_STYLE`, `CREATE_TIME`, `CREATE_USER`) VALUES ('08', '直属总承包部', '0', 'ORG_TYPE', '直属总承包部', '', '', '2020-09-01 10:38:00', 'admin');\n";
                st.executeUpdate(sql);
            }


            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "plc_priv")) {
                String sql = " CREATE TABLE `plc_priv`  (\n" +
                        "  `PLC_PRIV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                        "  `FUNC_ID` int(11) DEFAULT NULL COMMENT '菜单ID',\n" +
                        "  `FUNC_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '菜单名称',\n" +
                        "  `PRIV_STR` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '权限JSON串',\n" +
                        "  `USER_PRIV` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '人员授权范围',\n" +
                        "  `DEPT_PRIV` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '部门授权范围',\n" +
                        "  `ROLE_PRIV` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '角色授权范围',\n" +
                        "  PRIMARY KEY (`PLC_PRIV_ID`) USING BTREE\n" +
                        ") ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (1, 7253, '权限管理', '01,02,03,04,05,17,', '', NULL, '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (2, 7201, '项目信息', '02,03,04,05,06,09,19,20,21,38,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (3, 7202, '子项目', '02,03,04,05,06,07,09,11,12,21,22,39,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (4, 7203, '目标编制', '01,02,03,04,05,06,07,09,21,39,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (5, 7204, '任务编制', '04,05,06,09,11,12,21,24,39,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (6, 7206, '计划上报', '04,08,09,24,25,33,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (7, 7250, '项目信息审核', '09,25,33,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (8, 7251, '子项目审核', '09,25,33,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (9, 7207, '关键任务审批', '09,25,33,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (10, 7315, '子任务审批', '09,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (11, 7318, '分配确认', '40,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (12, 7320, '目标填报', '09,13,14,15,16,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (13, 7210, '子任务填报', '09,13,14,15,16,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (14, 7209, '子任务考核', '09,10,17,27,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (15, 7319, '关键任务考核', '10,27,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (16, 7252, '考核审核', '09,10,17,27,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (17, 7211, '项目关闭', '09,27,35,36,37,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (18, 7213, '计划进展报表', '09,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (19, 7214, '个人考核结果', '09,28,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (20, 7215, '部门考核结果', '09,28,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (21, 7217, '数据字典管理', '01,04,05,09,30,31,32,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (22, 7218, '计划期间设置', '01,04,05,09,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (23, 7224, '机构管理', '01,04,05,09,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (24, 7220, '计划项库', '01,04,05,09,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (25, 7221, '目标模板', '01,02,04,05,09,23,31,32,', '', '', '1,');\n" +
                        "INSERT INTO  `plc_priv`(`PLC_PRIV_ID`, `FUNC_ID`, `FUNC_NAME`, `PRIV_STR`, `USER_PRIV`, `DEPT_PRIV`, `ROLE_PRIV`) VALUES (26, 7222, '任务模板', '01,02,04,05,09,23,31,32,', '', '', '1,');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }


            //菜单

            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "74")) {
                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('74', '计划与项目管理', '', '', '', '', '', '', 'planandexam');";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7200")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7200, '7410', '计划编制', NULL, NULL, NULL, NULL, NULL, '@pcproj', '', NULL, NULL, NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7201")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7201, '741001', '项目信息', NULL, NULL, NULL, NULL, NULL, '/ProjectInfo/index', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7202")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7202, '741005', '子项目', NULL, NULL, NULL, NULL, NULL, '/ProjectInfo/subprojects', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7203")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7203, '741010', '关键任务编制', NULL, NULL, NULL, NULL, NULL, '/projectTarget/planTarget', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7204")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7204, '741015', '子任务编制', NULL, NULL, NULL, NULL, NULL, '/plcProjectItem/planTask', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7206")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7206, '741020', '计划上报', NULL, NULL, NULL, NULL, NULL, '/plcProjectItem/projectPlanPage', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7205")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7205, '7415', '计划审批', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7250")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7250, '741505', '项目信息审核', NULL, NULL, NULL, NULL, NULL, '/ProjectInfo/projectInformationCheck', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7251")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7251, '741510', '子项目审核', NULL, NULL, NULL, NULL, NULL, '/ProjectInfo/subprojectsCheck', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7207")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7207, '741515', '关键任务审批', NULL, NULL, NULL, NULL, NULL, '/plcProjectItem/targetApproval', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7315")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7315, '741520', '子任务审批', NULL, NULL, NULL, NULL, NULL, '/plcProjectItem/taskApproval', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7316")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7316, '7420', '计划分配', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7318")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7318, '742001', '分配确认', NULL, NULL, NULL, NULL, NULL, '/projectTarget/assessment', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7208")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7208, '7425', '计划执行', NULL, NULL, NULL, NULL, NULL, '@', '', '0', NULL, NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7320")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7320, '742501', '关键任务填报', NULL, NULL, NULL, NULL, NULL, '/ProjectDaily/planExecutionReport', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7210")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7210, '742505', '子任务填报', NULL, NULL, NULL, NULL, NULL, '/ProjectDaily/taskPlanReport', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7317")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7317, '7430', '计划考核', NULL, NULL, NULL, NULL, NULL, '@', '', '0', NULL, NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7209")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7209, '743001', '子任务考核', NULL, NULL, NULL, NULL, NULL, '/projectTarget/taskAssessment', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7319")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7319, '743005', '关键任务考核', NULL, NULL, NULL, NULL, NULL, '/projectTarget/targetAssessment', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7252")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7252, '743010', '考核审核', NULL, NULL, NULL, NULL, NULL, '/projectTarget/assessmentCheck', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7211")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7211, '7435', '项目关闭', NULL, NULL, NULL, NULL, NULL, '/ProjectInfo/goProjectClose', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7212")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7212, '7440', '统计报表', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7213")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7213, '744001', '计划进展报表', NULL, NULL, NULL, NULL, NULL, '/Assessment/planProgressReport', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7214")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7214, '744005', '个人考核结果', NULL, NULL, NULL, NULL, NULL, '/Assessment/personal', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7215")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7215, '744010', '部门考核结果', NULL, NULL, NULL, NULL, NULL, '/Assessment/section', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7216")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7216, '7445', '管理配置', NULL, NULL, NULL, NULL, NULL, '@', ' ', NULL, NULL, NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7217")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7217, '744501', '数据字典管理', NULL, NULL, NULL, NULL, NULL, '/Dictonary/dictionaryDefinition', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7218")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7218, '744505', '计划期间设置', NULL, NULL, NULL, NULL, NULL, '/plancheckGateway/planPeriodSetting', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7224")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7224, '744510', '机构管理', NULL, NULL, NULL, NULL, NULL, '/plcOrg/projectOrg', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7253")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7253, '744515', '权限管理', NULL, NULL, NULL, NULL, NULL, 'plcPriv/authorityManagement', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7219")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7219, '7450', '档案管理', NULL, NULL, NULL, NULL, NULL, '@', ' ', NULL, NULL, NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7220")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7220, '745001', '计划项库', NULL, NULL, NULL, NULL, NULL, '/WorkItem/workLibrary', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7221")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7221, '745005', '关键任务模板', NULL, NULL, NULL, NULL, NULL, '/TemplateItem/targetTemplate', '', '0', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7222")) {
                String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7222, '745010', '子任务模板', '', '', '', '', '', '/TaskTemplateItem/itemTemplate', '', '', '0', '', 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }
            //此模块未开发完成，暂注释
     /*   if (!Verification.CheckIsExistFunction(conn, driver, url, username, password,"7223")) {
            String sql = " INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (7223, '745015', '档案管理', NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0);";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);
        }*/

            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7265")) {
                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2308, '500910', '评分汇总', NULL, NULL, NULL, NULL, NULL, 'ScoreFlowController/assessmentTaskStatistics', '', '0', '0', NULL, 0);";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "plc_project_target", "TASK_APPROVAL")) {
                String sql = "ALTER TABLE plc_project_target ADD COLUMN TASK_APPROVAL varchar(10) DEFAULT NULL COMMENT '关键任务审批（二级）（1-正在审批，2-同意，3-退回）';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "plc_plan", "TASK_APPROVAL")) {
                String sql = " ALTER TABLE plc_plan ADD COLUMN TASK_APPROVAL varchar(10) DEFAULT NULL COMMENT '关键任务审批（二级）（1-正在审批，2-同意，3-退回）';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow", "ASSESSMENT_UNIT")) {
                String sql = " ALTER TABLE score_flow ADD COLUMN ASSESSMENT_UNIT varchar(255) DEFAULT NULL COMMENT '考核单位';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow", "AASSESSMENT_CYCLESSESSMENT_UNIT")) {
                String sql = "ALTER TABLE score_flow ADD COLUMN ASSESSMENT_CYCLE varchar(255) DEFAULT NULL COMMENT '考核周期';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_users", "ASSESSMENT_ROLE")) {
                String sql = "ALTER TABLE score_flow_users ADD COLUMN ASSESSMENT_ROLE text COMMENT '考核角色';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow", "PARTICIPANT_DEPT")) {
                String sql = "ALTER TABLE score_flow ADD COLUMN PARTICIPANT_DEPT text COMMENT '被考核人部门';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "ASSESSMENT_CYCLE", "")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('ASSESSMENT_CYCLE', '考核周期', NULL, NULL, NULL, NULL, NULL, NULL, '', '', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "ASSESSMENT_CYCLE")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('01', '2020年上半年', NULL, NULL, NULL, NULL, NULL, NULL, '', 'ASSESSMENT_CYCLE', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "ASSESSMENT_CYCLE")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('02', '2020年第三季度', NULL, NULL, NULL, NULL, NULL, NULL, '', 'ASSESSMENT_CYCLE', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "ASSESSMENT_CYCLE")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('03', '2020年第二季度', NULL, NULL, NULL, NULL, NULL, NULL, '', 'ASSESSMENT_CYCLE', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "ASSESSMENT_CYCLE")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('04', '2020年下半年', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'ASSESSMENT_CYCLE', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "ASSESSMENT_CYCLE")) {
                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('05', '2021年上半年', NULL, NULL, NULL, NULL, NULL, NULL, '1234', 'ASSESSMENT_CYCLE', '1', '', '1', '1', '1');\n";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }


            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_sort", "VIEW_SCOPE")) {
                String sql = " ALTER TABLE `institution_sort` MODIFY COLUMN `VIEW_SCOPE` varchar(255) DEFAULT NULL COMMENT '分类可见范围（sys_code表中code_no)';";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

        }catch (Exception e){

        }finally {
            if (conn!=null){
                conn.close();
            }
        }

    }
}
