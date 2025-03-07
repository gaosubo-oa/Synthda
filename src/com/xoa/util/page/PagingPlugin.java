package com.xoa.util.page;

import com.xoa.global.intercptor.CommonDatase;
import com.xoa.util.ReflectUtil;
import com.xoa.util.common.L;
import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.ibatis.session.Configuration;

import javax.transaction.NotSupportedException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;


  
/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午11:08:23
 * 类介绍  :   分页插件拦截器
 * 构造参数:   
 *
 */
@Intercepts({  
    @Signature(type = StatementHandler.class,  
            method = "prepare",  
            args = {Connection.class,Integer.class})})
public class PagingPlugin implements Interceptor {

    public static final String[] TABLE_NAME_STR = {"address",
            "ADDRESS_GROUP",
            "AFFAIR",
            "AI_SETTING",
            "ALIDAAS_SET",
            "APP_CONNECT",
            "APP_CONNECT_USER",
            "APP_LOG",
            "ATTACHMENT",
            "ATTACHMENT_EDIT",
            "ATTACHMENT_MODULE",
            "ATTACHMENT_POSITION",
            "ATTEND",
            "ATTEND_ASK_DUTY",
            "ATTEND_CONFIG",
            "ATTEND_DUTY",
            "ATTEND_DUTY_SHIFT",
            "ATTEND_EVECTION",
            "ATTEND_EXTRAWORK",
            "ATTEND_HOLIDAY",
            "ATTEND_INTEGRAL",
            "ATTEND_LEAVE",
            "ATTEND_LEAVE_MANAGER",
            "ATTEND_LEAVE_PARAM",
            "ATTEND_MACHINE",
            "ATTEND_MANAGER",
            "ATTEND_MOBILE",
            "ATTEND_OUT",
            "ATTEND_RULE",
            "ATTEND_SCHEDULE",
            "ATTEND_SET",
            "ATTENDANCE_OVERTIME",
            "BBQ",
            "BBS_BOARD",
            "BBS_COMMENT",
            "BIS_VIEW_LIST_ITEM",
            "BONUS",
            "BONUS_PRIV",
            "BONUSMSG",
            "BOOK_INFO",
            "BOOK_MANAGE",
            "BOOK_MANAGER",
            "BOOK_TYPE",
            "BUDGET_FILE",
            "BUDGET_ITEM",
            "BUDGET_LOG",
            "BUDGET_LOG11",
            "BUDGET_PROCESS_LOG",
            "BUDGETING_PROCESS",
            "BVCX",
            "C_ACCOUNTINFO",
            "CALENDAR",
            "CALENDAR_LEADER_PRIV",
            "CAPACITY_CHANNEL_INFO",
            "CAPACITY_CHNLDOC",
            "CAPACITY_DOCUMENT_CATEGORY",
            "CAPACITY_DOCUMENT_INFO",
            "CAPACITY_SITE_INFO",
            "CAS_CONFIG",
            "CENSOR_DATA",
            "CENSOR_MODULE",
            "CENSOR_MODULE_COPY1",
            "CENSOR_WORDS",
            "CHARGE_LIST",
            "CHARGE_PERMISSION",
            "CHARGE_SETTING",
            "CHARGE_SETTING_TYPE",
            "CHARGE_TYPE",
            "CMS_CHANNEL_INFO",
            "CMS_CHNLDOC",
            "CMS_DOCUMENT_CATEGORY",
            "CMS_DOCUMENT_INFO",
            "CMS_SITE_INFO",
            "CMS_SITE_TEMPLATE",
            "COM_GATE_INFORMATION",
            "COM_VEHICLE_ACCESS",
            "COMLICENSE_INFO",
            "COMLICENSE_TYPE",
            "COMLICENSE_USE",
            "COMLICENSE_VERSION",
            "CONCERN_USER",
            "CONSTRUCTING_UNIT",
            "CONTRACT",
            "CONTRACT_FLOW",
            "CONTRACT_NO",
            "CONTRACT_NO_SET",
            "CONTRACT_PROJECT",
            "CONTRACT_REMIND",
            "CONTRACT_TRANSPORT",
            "CONTRACT_TYPE",
            "COST_DATA",
            "COST_TYPE",
            "COURSE",
            "COURSE_GRADE",
            "CP_ASSET_DISPATCH",
            "CP_ASSET_GROUP",
            "CP_ASSET_KEEP",
            "CP_ASSET_REFLECT",
            "CP_ASSET_REFLECT_TRANSFER",
            "CP_ASSET_TYPE",
            "CP_ASSETS_APPLYS",
            "CP_ASSETS_INVENTORY",
            "CP_ASSETS_INVENTORY_RECORDS",
            "CRASH_DISPATCH",
            "CRASH_DISPATCH_PARENT",
            "CRM_ACCOUNT",
            "CRM_ACCOUNT_CARE",
            "CRM_ACCOUNT_CONTACT",
            "CRM_ACTION",
            "CRM_BIDDING_INFO",
            "CRM_CERTIFICATE",
            "CRM_CONTRACT",
            "CRM_CUSTOMER",
            "CRM_FOLLOW",
            "CRM_LEADS",
            "CRM_LINKMAN",
            "CRM_MANAGER",
            "CRM_ORDER",
            "CRM_PRODUCT",
            "CRM_ROLE",
            "CRM_SUPPLIER",
            "CRM_TENDER_INFO",
            "CUS_PAYMENT",
            "CUS_RECEIPT",
            "CUS_REPAYMENT",
            "CUSTOM_NUMBER",
            "CUSTOM_NUMBER_RECORD",
            "DATA_123",
            "DATA_AS",
            "DATA_SRC",
            "DATA_ZXCV",
            "DEPARTMENT",
            "DEPT_MAP",
            "DIARY",
            "DIARY_COMMENT",
            "DIARY_COMMENT_REPLY",
            "DIARY_SHARE",
            "DIARY_TOP",
            "DOCUMENT",
            "DOCUMENT_EXCHANGE_OUTUNIT",
            "DOCUMENT_EXCHANGE_RECEIVE",
            "DOCUMENT_EXCHANGE_SET",
            "DOCUMENT_ORG",
            "DOCUMENT_OUT_CONFIG",
            "DOCUMENT_OUTSEND_RECORD",
            "DOCUMENT_POW",
            "DOCUMENT_RIZHI",
            "DOCUMENT_SYNTHESIS",
            "DUTY_CALL",
            "DUTY_FORM",
            "DUTY_POLICE_USERS",
            "DUTY_RECEIPT",
            "DUTY_SITUATION",
            "DUTY_TH",
            "EDU_FIXED_ASSETS_MANGEMENT",
            "EDU_FIXED_ASSETS_MANGEMENT_COPY",
            "EDU_MAINTAIN",
            "EDU_MAINTAIN_COPY",
            "EDU_TRAINING_PLAN",
            "EDU_TRAINING_RECORD",
            "EDU_TRANSFER",
            "EMAIL",
            "EMAIL_BODY",
            "EMAIL_BODY_COPY",
            "EMAIL_BODYPLUS",
            "EMAIL_BOX",
            "EMAIL_BOXGROUP",
            "EMAIL_COPY",
            "EMAIL_KEYWORD",
            "EMAIL_NAME",
            "EMAIL_SET",
            "EMAIL_SET2",
            "EMAIL_TAG",
            "EMAILPLUS",
            "ENTRY_FORM",
            "EVAL_TYPE",
            "EXA_PAPER",
            "EXA_QUESTIONS",
            "EXA_SCORE_SHEET",
            "EXA_SORT",
            "EXA_TEST",
            "EXAMINATION",
            "EXT_DEPT",
            "EXT_USER",
            "FIELD_DATE",
            "FIELDSETTING",
            "FILE_COMMENT",
            "FILE_CONTENT",
            "FILE_SCORE",
            "FILE_SORT",
            "FLOW_ASSIGN",
            "FLOW_CHART",
            "FLOW_FEEDBACK_COMMON",
            "FLOW_FORM_TYPE",
            "FLOW_FORM_VERSION",
            "FLOW_HOOK",
            "FLOW_MANAGE_LOG",
            "FLOW_OPERATION",
            "FLOW_OPERATION111",
            "FLOW_OPINION",
            "FLOW_PARA",
            "FLOW_PLUGIN",
            "FLOW_PRINT_TPL",
            "FLOW_PRIV",
            "FLOW_PRIV_",
            "FLOW_PROCESS",
            "FLOW_PROCESS_",
            "FLOW_QUERY_TPL",
            "FLOW_RELATION",
            "FLOW_RELATION_FUNC",
            "FLOW_REPORT",
            "FLOW_REPORT_PRIV",
            "FLOW_RULE",
            "FLOW_RUN",
            "FLOW_RUN_ATTACH",
            "FLOW_RUN_DATA",
            "FLOW_RUN_FEEDBACK",
            "FLOW_RUN_HOOK",
            "FLOW_RUN_LOG",
            "FLOW_RUN_PRCS",
            "FLOW_RUN_READ",
            "FLOW_SETTING_HOLIDAY",
            "FLOW_SORT",
            "FLOW_SORT_BAK",
            "FLOW_TIMER",
            "FLOW_TRIGGER",
            "FLOW_TRIGGER_BAK",
            "FLOW_TYPE",
            "FLOW_TYPE_BAK",
            "FLOW_TYPE_ERR",
            "FLOW_VERSION",
            "FOOT",
            "FOOT_SET",
            "FORM_SORT",
            "FORM_SORT_BAK",
            "GBT_CONF",
            "GRID_CHECK",
            "GRID_EVENT",
            "GRID_INFO",
            "GUIDE_GOAL",
            "GUIDE_GOAL_BACK",
            "GUIDE_GOAL_BACK_REPLY",
            "GUIDE_GOAL_MANAGE",
            "GUIDE_GOAL_TYPE",
            "HELP_QUESTION",
            "HELP_SORT",
            "HIERARCHICAL_GLOBAL",
            "HIGHSCHOOL",
            "HJKL",
            "HLPA",
            "HOPQ",
            "HR_CARD_MODULE",
            "HR_CODE",
            "HR_DISPATCHER",
            "HR_EVALUATE",
            "HR_EVALUATE_PRIV",
            "HR_INSURANCE_PARA",
            "HR_INTEGRAL_DATA",
            "HR_INTEGRAL_ITEM",
            "HR_INTEGRAL_ITEM_TYPE",
            "HR_INTEGRAL_OA",
            "HR_JOB_RESPONSIBILITIES",
            "HR_MANAGER",
            "HR_RECRUIT_FILTER",
            "HR_RECRUIT_PLAN",
            "HR_RECRUIT_POOL",
            "HR_RECRUIT_RECRUITMENT",
            "HR_RECRUIT_REQUIREMENTS",
            "HR_REHAB",
            "HR_ROLE_MANAGE",
            "HR_SAL_DATA",
            "HR_SCHEDULING",
            "HR_SCHEDULING_LOG",
            "HR_SOCIAL_RELATIONS",
            "HR_STAFF_ATTACHMENT",
            "HR_STAFF_CARE",
            "HR_STAFF_CONTRACT",
            "HR_STAFF_ENTRY",
            "HR_STAFF_ENTRY_EDUCATION",
            "HR_STAFF_ENTRY_EXPERIENCE",
            "HR_STAFF_INCENTIVE",
            "HR_STAFF_INFO",
            "HR_STAFF_LABOR_SKILLS",
            "HR_STAFF_LEARN_EXPERIENCE",
            "HR_STAFF_LEAVE",
            "HR_STAFF_LICENSE",
            "HR_STAFF_REINSTATEMENT",
            "HR_STAFF_RELATIVES",
            "HR_STAFF_TITLE_EVALUATION",
            "HR_STAFF_TRANSFER",
            "HR_STAFF_WORK_EXPERIENCE",
            "HR_TRAINING_PLAN",
            "HR_TRAINING_RECORD",
            "HR_WELFARE_MANAGE",
            "HST_MEETING",
            "HST_MEETING1",
            "HST_ROOM",
            "HST_ROOM1",
            "HTMLDOCUMENT",
            "HTMLHISTORY",
            "HTMLSIGNATURE",
            "IM_CHAT_LIST",
            "IM_CHATLIST",
            "IM_FRIENDS",
            "IM_MESSAGE",
            "IM_ROOM",
            "INCOME_EXPENSE_PLAN",
            "INCOME_EXPENSE_PLAN_TYPE",
            "INCOME_EXPENSE_RECORDS",
            "INCOME_EXPENSE_STAT",
            "INFO_CENTER",
            "INFORMATION",
            "INSTITUTION_CONTENT",
            "INSTITUTION_SORT",
            "INTEGRAL_MANAGER",
            "INTERFACE",
            "INV_WAREHOUSE",
            "IP_RULE",
            "JCCCC",
            "JHT_MEETING",
            "JJJ",
            "JKSD",
            "KEYWORDS",
            "KG_RELATION_KEYSIGN",
            "KG_RELATION_KEYUSER",
            "KG_SIGNATURE",
            "KG_SIGNKEY",
            "KINDERGARTEN",
            "KKKKL",
            "KNOWLEDGE_COLUMN",
            "KNOWLEDGE_CUSTOMER",
            "KNOWLEDGE_CUSTOMER_USELOG",
            "KNOWLEDGE_DOCFILE",
            "KNOWLEDGE_ROLE_COLUMN",
            "KNOWLEDGE_SUBSCRIBE",
            "KOBE",
            "KOBE2",
            "KOBE3",
            "LEARNING_EXPERIENCE",
            "LEARNPHASE",
            "LIMS_COMMON_CODE",
            "LIMS_DEPT_LOCATION",
            "LIMS_EQUIP_CAPY",
            "LIMS_EQUIP_EVENT_PLAN_PARA",
            "LIMS_EQUIP_EVENTLOG",
            "LIMS_EQUIP_EVENTS_CAPY",
            "LIMS_EQUIP_EVENTS_PLAN",
            "LIMS_EQUIP_EXPERIENCE",
            "LIMS_EQUIP_FILE",
            "LIMS_EQUIP_INVE_CONT",
            "LIMS_EQUIP_INVE_PLAN",
            "LIMS_EQUIP_INVENTORY",
            "LIMS_EQUIP_LEND",
            "LIMS_EQUIP_LENDLIST",
            "LIMS_EQUIP_OWNERLIST",
            "LIMS_EQUIP_OWNERLOG",
            "LIMS_EQUIP_PARTS",
            "LIMS_EQUIP_REPARLOG",
            "LIMS_EQUIP_REPARLOG_FILE",
            "LIMS_EQUIP_SCRAPLIST",
            "LIMS_EQUIP_SCRAPLOG",
            "LIMS_EQUIP_TYPES",
            "LIMS_EQUIP_TYPES_COPY1",
            "LIMS_EQUIP_USELOG",
            "LIMS_EQUIPMENT",
            "LIUKAIXUAN",
            "LKX",
            "LKX_RAPBEAN",
            "LOGIN_APP",
            "LPOK",
            "MEAL_MANAGE",
            "MEETING",
            "MEETING_ATTEND_CONFIRM",
            "MEETING_COMMENT",
            "MEETING_COPY",
            "MEETING_EQUUIPMENT",
            "MEETING_ROOM",
            "MEETING_RULE",
            "MESSAGE",
            "MIDDLESCHOOL",
            "MOBILE_APP",
            "MOBILE_VERIFY",
            "MODULE_MANAGE",
            "MODULE_PRIV",
            "MP_JIS_CONFIG",
            "MYTABLE",
            "NETCHAT",
            "NETDISK",
            "NEWS",
            "NEWS_COMMENT",
            "NOTES",
            "NOTIFY",
            "NOTIFY_OPINION",
            "OA2SSO",
            "OA_CYCLESOURCE_USED",
            "OA_SOURCE",
            "OA_SOURCE_USED",
            "OFFICE_DEPOSITORY",
            "OFFICE_LOG",
            "OFFICE_PRODUCTS",
            "OFFICE_TASK",
            "OFFICE_TASK_COPY",
            "OFFICE_TRANSHISTORY",
            "OFFICE_TYPE",
            "OLD_EMAIL",
            "OLD_EMAIL_BODY",
            "OM_RETURN",
            "OM_SHIPMENT",
            "OPINION_MANAGE",
            "OPOPOP",
            "OPQ",
            "OPQRSJ",
            "ORG_DEPARTMENT",
            "ORG_GOVIMENT",
            "ORG_MANAGE",
            "ORG_PARTY_MEMBER",
            "PARTY",
            "PARTY_MEMBER",
            "PICTURE",
            "PLAN_TYPE",
            "PLC_ASSESS_SCORE",
            "PLC_ASSESSDATA_RECORD",
            "PLC_ASSIST",
            "PLC_DEPT_DAILY",
            "PLC_DEPT_ITEM",
            "PLC_DEPT_TARGET",
            "PLC_DICTIONARY",
            "PLC_EDIT_RECORD",
            "PLC_PERIOD_SET",
            "PLC_PLAN",
            "PLC_PRIV",
            "PLC_PROJECT_BAG",
            "PLC_PROJECT_DAILY",
            "PLC_PROJECT_INFO",
            "PLC_PROJECT_ITEM",
            "PLC_PROJECT_ITEM_PRETASK",
            "PLC_PROJECT_ORG",
            "PLC_PROJECT_TARGET",
            "PLC_PROJECT_TARGET_PRETASK",
            "PLC_TARGET_APPROVAL",
            "PLC_TARGET_ITEM",
            "PLC_TARGET_MANAGE",
            "PLC_TARGET_ORG",
            "PLC_TARGET_TEMPLATE",
            "PLC_TARGET_TEMPLATE_TYPE",
            "PLC_TASK_ITEM",
            "PLC_TASK_TEMPLATE_ITEM",
            "PLC_TASK_TEMPLATE_TYPE",
            "PLC_TEMPLATE_ITEM",
            "PLC_TEMPLATE_ITEM_PRETASK",
            "PLC_TEMPLATE_TYPE",
            "PLC_WORK_ITEM",
            "PO_COMMODITY_ENTER",
            "PO_COMMODITY_OUT",
            "PORTAL_ARTICLE",
            "PORTAL_COLUMN",
            "PORTAL_SITE",
            "PORTAL_TEMPLATE",
            "PORTAL_TEMPLATES",
            "PORTALS",
            "PORTALS1",
            "PRODUCT_TYPE",
            "PROPAGATE_POSITION",
            "QIYEWEIXIN_CONFIG",
            "RD_INSTRUCTIONS",
            "RD_INSTRUCTIONS_RECEIVE",
            "RD_INSTRUCTIONS_RECEIVE_LOG",
            "REMINDERS",
            "REP_DATA",
            "REP_FIELD",
            "REP_FLOW",
            "REP_REPORT",
            "REP_TABLE",
            "REPORT_TPL_ITEM",
            "RMS_FILE",
            "RMS_LEND",
            "RMS_ROLL",
            "RMS_ROLL_ROOM",
            "RPM_ACHIEVEMENTS_AWARDS",
            "RPM_ACHIEVEMENTS_PROMOTION",
            "RPM_BUDGET",
            "RPM_DICTIONARY",
            "RPM_EXPECTED_RESULTS",
            "RPM_EXPERT",
            "RPM_FORECAST",
            "RPM_PLAN",
            "RPM_PROGRAMME",
            "RPM_PROJECT_DEMONSTRATION",
            "RPM_RESEARCH_GROUPING",
            "RPM_RESEARCH_SCORE",
            "RPM_SIGNATURE",
            "RPM_TOPIC",
            "RPM_TOPIC_REMARK",
            "RPM_TOPICES",
            "SAL_DATA",
            "SAL_FLOW",
            "SAL_ITEM",
            "SCHEDULE",
            "SCHOOL_PRIV",
            "SCHOOL_ROLL_INFO",
            "SCHOOLINFO",
            "SCORE_FLOW",
            "SCORE_FLOW_ITEM",
            "SCORE_FLOW_USERS",
            "SCORE_GROUP",
            "SCORE_ITEM",
            "SCORE_SELF_DATA",
            "SD_FILE",
            "SD_SORT",
            "SEAL",
            "SEAL_JINGE",
            "SEAL_JINGE_KEY",
            "SEAL_LOG",
            "SECURE_KEY",
            "SECURE_LOG",
            "SECURE_RULE",
            "SENIOR_RE_CAT",
            "SESSION",
            "SMARTY_ENROLL_CLASS",
            "SMARTY_ENROLL_DEPT",
            "SMARTY_ENROLL_DISTRICT_INFO",
            "SMARTY_ENROLL_GRADE",
            "SMARTY_ENROLL_NOTICE",
            "SMARTY_ENROLL_NOTICE_FILE",
            "SMARTY_ENROLL_PLAN",
            "SMARTY_ENROLL_POINT",
            "SMARTY_ENROLL_SCHOOL",
            "SMARTY_ENROLL_SCHOOL_DISTRICT",
            "SMARTY_ENROLL_STUDENT",
            "SMS",
            "SMS2",
            "SMS2_PRIV",
            "SMS3",
            "SMS_BODY",
            "SMS_SETTINGS",
            "STR_STATUS",
            "SUBJECT_ACTIVITY",
            "SUP_ASSIST",
            "SUP_FEED_BACK",
            "SUP_FEED_BACK_REPLY",
            "SUP_REPAYMENT",
            "SUP_TYPE_DEPT_PRIV",
            "SUP_TYPE_ROLE_PRIV",
            "SUP_TYPE_USER_PRIV",
            "SUP_URGE",
            "SUPERVISION",
            "SUPERVISION_APPLY",
            "SUPERVISION_TYPE",
            "SYN_USER",
            "SYS_CODE",
            "SYS_FUNCTION",
            "SYS_LOG",
            "SYS_MENU",
            "SYS_MENU_BAK",
            "SYS_MENU_H5",
            "SYS_PARA",
            "SYS_RULE",
            "SYS_TASKS",
            "SYS_USER_TOKEN",
            "SYS_WORDS",
            "T_ORG_BM",
            "TASK_CHANGE_RECORD",
            "TASK_FEEDBACK",
            "TASK_MANAGE",
            "TASK_ORDER",
            "TASK_REMINDS",
            "TASK_TAG",
            "TASK_TYPE",
            "TASK_USER",
            "TASKCENTER",
            "TEACHER_INFO",
            "TEMPLATE",
            "TERP_SERVER",
            "THIRD_SYS_CONFIG",
            "TIMED_TASK",
            "TIMED_TASK_RECORD",
            "TIMELINE",
            "TIMELINE_COPY1",
            "TIMELINE_EVENT",
            "TIMELINE_POST_DEPT",
            "TIMELINE_POST_ROLE",
            "TIMELINE_POST_USER",
            "TIMELINE_VIEW_DEPT",
            "TIMELINE_VIEW_ROLE",
            "TIMELINE_VIEW_USER",
            "TODAY_CAR_NO",
            "TR_COURSE",
            "TR_COURSE_MANAGE",
            "TR_COURSE_SCHEDULE",
            "TR_COURSE_STAGE",
            "TR_STUDY_RECORD",
            "TRAFFIC_RESTRICTION",
            "TRASH",
            "TRASH_DETECTION",
            "TRASH_MINIATURE",
            "UE_TEMPLATE",
            "UNIT",
            "URL",
            "\"USER\"",
            "USER_ALIDAAS",
            "USER_ALIDAAS_DEPT",
            "USER_DD_MAP",
            "USER_DEPT_MAP",
            "USER_DEPT_ORDER",
            "USER_DUTY",
            "USER_DUTY_BACKUP",
            "USER_EXT",
            "USER_EXT2",
            "USER_FUNCTION",
            "USER_GROUP",
            "USER_JOB",
            "USER_JPUSH",
            "USER_LX_MAP",
            "USER_MAP",
            "USER_MOBILE",
            "USER_MOBILE_DEVICES",
            "USER_ONLINE",
            "USER_POST",
            "USER_PRIV",
            "USER_WEIXIN_MAP",
            "USER_WEIXIN_UID",
            "USER_WEIXINGZH_MAP",
            "USER_WEIXINQY",
            "USER_WELINK",
            "USER_WIDGET_SET",
            "VEHICLE",
            "VEHICLE_MAINTENANCE",
            "VEHICLE_OIL_CARD",
            "VEHICLE_OIL_USE",
            "VEHICLE_OPERATOR",
            "VEHICLE_USAGE",
            "VERSION",
            "VIDEO_CONF",
            "VIDEO_DEVICE",
            "VOTE_DATA",
            "VOTE_ITEM",
            "VOTE_TITLE",
            "WEATHER",
            "WEBMAIL",
            "WEBMAIL_BODY",
            "WECHAT",
            "WECHAT_COMMENT",
            "WECHAT_COMMENT_REPLY",
            "WECHAT_TOPIC",
            "WEIXUN_SHARE",
            "WEIXUN_SHARE_FOLLOW",
            "WEIXUN_SHARE_TOPIC",
            "WIDGET",
            "WINEXE",
            "WORK_DETAIL",
            "WORK_PERSON",
            "WORK_PLAN",
            "WORK_PLAN_COPY",
            "WPS_FILES",
            "WX_CHECK",
            "WX_FILTER",
            "XSIGN"};

	/**
	 * 默认页码  
	 */
    private Integer defaultPage; 
    /**
     * 默认每页条数 
     */
    private Integer defaultPageSize; 
    /**
     * 默认是否启用插件  
     */
    private Boolean defaultUseFlag; 
    /**
     * 默认是否检测页码参数  
     */
    private Boolean defaultCheckFlag; 
    /**
     * 默认是否清除最后一个order by 后的语句 
     */
    private Boolean defaultCleanOrderBy;  

    private static final String DB_TYPE_MYSQL = "mysql";
    private static final String DB_TYPE_ORACLE = "oracle";
    private static final String DB_TYPE_SQLSERVER = "sqlserver";
    private static final String DB_TYPE_DMSQL="dmsql";
    private static final String KB_TYPE_DMSQL="kingbase";

    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:08:23
     * 类介绍  :   插件实现方法
     * 构造参数:   
     *
     */
    @Override  
    public Object intercept(Invocation invocation) throws Throwable {  
        StatementHandler stmtHandler = (StatementHandler) getUnProxyObject(invocation.getTarget());  
  
        MetaObject metaStatementHandler = SystemMetaObject.forObject(stmtHandler);  
        String sql = (String) metaStatementHandler.getValue("delegate.boundSql.sql");  
         
        MappedStatement mappedStatement =  (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");

        //获取数据源连接类型

//        String dbType = dyTypeDate.determineCurrentLookupKey().toString();  
        String dbType = this.returnSqlType();


//        String dbType = dyTypeDate.determineCurrentLookupKey().toString();  
        BoundSql boundSql = (BoundSql) metaStatementHandler.getValue("delegate.boundSql");

        //不是select语句.
        if (!this.checkSelect(sql)) {
            L.d("you sql is not select ,pleasecheck");
            if(DB_TYPE_DMSQL.equals(dbType)){
                return   this.preDmSQL(invocation, metaStatementHandler, boundSql);
            }
            return invocation.proceed();
        }
        
        Object parameterObject = boundSql.getParameterObject();  
        PageParams pageParams = getPageParamsForParamObj(parameterObject);  
        if (pageParams == null) { //无法获取分页参数，不进行分页。  

            if(DB_TYPE_DMSQL.equals(dbType)){
                return   this.preDmSQL(invocation, metaStatementHandler, boundSql);
            }
        	return invocation.proceed();  
        }  
  
        //获取配置中是否启用分页功能.  
        Boolean useFlag = pageParams.getUseFlag() == null? this.defaultUseFlag : pageParams.getUseFlag();  
        if (!useFlag) {  //不使用分页插件. 
        	L.d("useFlag"+useFlag);
            if(DB_TYPE_DMSQL.equals(dbType)){
                return   this.preDmSQL(invocation, metaStatementHandler, boundSql);
            }
            return invocation.proceed();  
        }  
        //获取相关配置的参数.  
        Integer pageNum = pageParams.getPage() == null? defaultPage : pageParams.getPage();  
        Integer pageSize = pageParams.getPageSize() == null? defaultPageSize : pageParams.getPageSize();  
        Boolean checkFlag = pageParams.getCheckFlag() == null? defaultCheckFlag : pageParams.getCheckFlag();  
        Boolean cleanOrderBy = pageParams.getCleanOrderBy() == null? defaultCleanOrderBy : pageParams.getCleanOrderBy();  
        //计算总条数  
        int total = this.getTotal(invocation, metaStatementHandler, boundSql, cleanOrderBy, dbType);  
        //回填总条数到分页参数  
        pageParams.setTotal(total);  
        //计算总页数.  
        int totalPage = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;  
        //回填总页数到分页参数.  
        pageParams.setTotalPage(totalPage);  
        //检查当前页码的有效性.  
        this.checkPage(checkFlag, pageNum, totalPage);


        //修改sql
        return this.preparedSQL(invocation, metaStatementHandler, boundSql, pageNum, pageSize, dbType);  
    }  
  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:09:54
     * 方法介绍:   分离出分页参数
     * 参数说明:   @param parameterObject
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     * @return     PageParams
     */
    public PageParams getPageParamsForParamObj(Object parameterObject) throws Exception {  
        PageParams pageParams = null;  
        if (parameterObject == null) {  
            return null;  
        }  
        //处理map参数和@Param注解参数，都是MAP  
        if (parameterObject instanceof Map) {  

            Map<String, Object> paramMap = (Map<String, Object>) parameterObject;  
            Set<String> keySet = paramMap.keySet();  
            Iterator<String> iterator = keySet.iterator();  
            while(iterator.hasNext()) {  
                String key = iterator.next();
                Object value = paramMap.get(key);
                if (value instanceof PageParams) {  
                    return (PageParams)value;  
                }  
            }  
        } else if (parameterObject instanceof PageParams) { //参数POJO继承了PageParams  
            return (PageParams) parameterObject;  
        } else { //从POJO尝试读取分页参数.  
            Field[] fields = parameterObject.getClass().getDeclaredFields();  
            //尝试从POJO中获得类型为PageParams的属性  
            for (Field field : fields) {  
                if (field.getType() == PageParams.class) {  
                    PropertyDescriptor pd = new PropertyDescriptor (field.getName(), parameterObject.getClass());  
                    Method method = pd.getReadMethod();  
                    return (PageParams) method.invoke(parameterObject);  
                }  
            }  
        }  
        return pageParams;  
    }  
  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:10:05
     * 方法介绍:   判断是否select语句.
     * 参数说明:   @param sql
     * 参数说明:   @return
     * @return     boolean
     */
    private boolean checkSelect(String sql) {  
        String trimSql = sql.trim();  
        int idx = trimSql.toLowerCase().indexOf("select");  
        return idx == 0;  
    }  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:10:27
     * 方法介绍:    检查当前页码的有效性.
     * 参数说明:   @param checkFlag
     * 参数说明:   @param pageNum
     * 参数说明:   @param pageTotal
     * 参数说明:   @throws Throwable
     * @return     void
     */
    private void checkPage(Boolean checkFlag, Integer pageNum, Integer pageTotal) throws Throwable  {  
        if (checkFlag) {  
            //检查页码page是否合法.  
            if (pageNum > pageTotal) {  
                throw new Exception("查询失败，查询页码【" + pageNum + "】大于总页数【" + pageTotal + "】！！");  
            }  
        }  
    }  
  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:10:37
     * 方法介绍:   预编译改写后的SQL，并设置分页参数 
     * 参数说明:   @param invocation
     * 参数说明:   @param metaStatementHandler
     * 参数说明:   @param boundSql
     * 参数说明:   @param pageNum
     * 参数说明:   @param pageSize
     * 参数说明:   @param dbType
     * 参数说明:   @return
     * 参数说明:   @throws Exception
     * @return     Object
     */
    private Object preparedSQL(Invocation invocation, MetaObject metaStatementHandler, BoundSql boundSql, int pageNum, int pageSize, String dbType) throws Exception {  
        //获取当前需要执行的SQL  

    	String sql = boundSql.getSql();  
        String newSql = this.getPageDataSQL(sql, dbType);  
        //修改当前需要执行的SQL  
        metaStatementHandler.setValue("delegate.boundSql.sql", newSql);  
        //执行编译，这里相当于StatementHandler执行了prepared()方法，这个时候，就剩下2个分页参数没有设置。  
        Object statementObj = invocation.proceed();  
        //设置两个分页参数。  
        this.preparePageDataParams((PreparedStatement)statementObj, pageNum, pageSize, dbType);  
        return statementObj;  
    }  

    private String preDmStrSql(String sql){
        String currSql = sql;
        currSql  =  currSql.toUpperCase();
        currSql =currSql.replaceAll("`","");
//        currSql =currSql.replaceAll("USER ","USER_ ");
        String dataUrl = "";
        String currentDB =  CommonDatase.getCurrentDB();
        if(currentDB.equals("Mysql")){
            dataUrl = "XOA"+"1001";
        }else if(currentDB.equals("Oracle")){
            dataUrl = "XOA"+"1001";
        }else if(currentDB.equals("DM")){
            dataUrl = "XOA"+"1001";
        }else if(currentDB.equals("Kingbase")){
            dataUrl = "XOAKB"+"1001";
        }
        for(String tableName:TABLE_NAME_STR){
            if(currSql.contains(tableName)){
                currSql=currSql.replace("\n"," ");
                currSql=currSql.replace("\t"," ");
                if(currSql.lastIndexOf(tableName)+tableName.length()==currSql.length()){
                    currSql=currSql.replaceAll(" "+tableName ," "+dataUrl+"."+tableName+" ");
                }
                if(currSql.contains("IDENT_CURRENT")){
                    currSql=currSql.replace("IDENT_CURRENT('"+tableName+"')","IDENT_CURRENT('"+dataUrl+"."+tableName+"')");
                }
                currSql=currSql.replace(" "+tableName+" " ," "+dataUrl+"."+tableName+" ");
                currSql=currSql.replace(","+tableName+" " ," ,"+dataUrl+"."+tableName+" ");
                //currSql=currSql.replaceAll(" "+tableName+"." ," "+dataUrl+"."+tableName+".");
                currSql=currSql.replace(" \""+tableName+"\" " ," "+dataUrl+".\""+tableName+"\" ");
            }
        }
        L.s("renderSql:",currSql);
        return currSql;
    }
    private Object preDmSQL(Invocation invocation, MetaObject metaStatementHandler, BoundSql boundSql)throws Exception {
        String sql = boundSql.getSql();
//        String currSql = sql;
//        currSql  =  currSql.toUpperCase();
//        currSql =currSql.replaceAll("`","");
//        currSql =currSql.replaceAll("USER ","USER_ ");
//        for(String a:TABLE_NAME_STR){
//            currSql=currSql.replaceAll(" "+a ," XOA1004."+a);
//        }
//        for(String a:TABLE_NAME_STR){
//
//            currSql=currSql.replaceAll(","+a+" " ,",XOA1004."+a+" ");
//        }
        //修改当前需要执行的SQL
        metaStatementHandler.setValue("delegate.boundSql.sql", preDmStrSql(sql));

        Object statementObj = invocation.proceed();
        return statementObj;
    }


    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:10:50
     * 方法介绍:   获取总条数. 
     * 参数说明:   @param ivt
     * 参数说明:   @param metaStatementHandler
     * 参数说明:   @param boundSql
     * 参数说明:   @param cleanOrderBy
     * 参数说明:   @param dbType
     * 参数说明:   @return
     * 参数说明:   @throws Throwable
     * @return     int
     */
    private int getTotal(Invocation ivt, MetaObject metaStatementHandler, BoundSql boundSql, Boolean cleanOrderBy, String dbType) throws Throwable {



        //获取当前的mappedStatement  
        MappedStatement mappedStatement = (MappedStatement) metaStatementHandler.getValue("delegate.mappedStatement");  
        //配置对象  
        Configuration cfg = mappedStatement.getConfiguration();  
        //当前需要执行的SQL  
        String sql = (String) metaStatementHandler.getValue("delegate.boundSql.sql");  
        //去掉最后的order by语句  
        if (cleanOrderBy) {  
            sql = this.cleanOrderByForSql(sql);  
        }  
        String countSql = this.getTotalSQL(sql, dbType);  
        //获取拦截方法参数，根据插件签名，知道是Connection对象.  
        Connection connection = (Connection) ivt.getArgs()[0];  
        PreparedStatement ps = null;  
        int total = 0;  
        try {  
            //预编译统计总数SQL  
            ps = connection.prepareStatement(countSql);
            //构建统计总数SQL
            BoundSql countBoundSql = new BoundSql(cfg, countSql, boundSql.getParameterMappings(), boundSql.getParameterObject());
//            BoundSql countBS = new BoundSql(cfg, sql, boundSql.getParameterMappings(), boundSql.getParameterObject());
            Field metaParamsField = ReflectUtil.getFieldByFieldName(boundSql, "metaParameters");
            if (metaParamsField != null) {
                MetaObject mo = (MetaObject) ReflectUtil.getValueByFieldName(boundSql, "metaParameters");
                ReflectUtil.setValueByFieldName(countBoundSql, "metaParameters", mo);
                ReflectUtil.setValueByFieldName(countBoundSql, "additionalParameters", ReflectUtil.getValueByFieldName(boundSql, "additionalParameters"));
            }
            //构建MyBatis的ParameterHandler用来设置总数Sql的参数。
            ParameterHandler handler = new DefaultParameterHandler(mappedStatement, boundSql.getParameterObject(), countBoundSql);  
            //设置总数SQL参数  
            handler.setParameters(ps);
            //执行查询.  
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {  
                total = rs.getInt("total");  
            }  
        } finally {  
            //这里不能关闭Connection否则后续的SQL就没法继续了。  
            if (ps != null) {  
                ps.close();  
            }  
        }  
        return total;  
    }  
  
    private String cleanOrderByForSql(String sql) {  
        StringBuilder sb = new StringBuilder(sql);  
        String newSql = sql.toLowerCase();  
        //如果没有order语句,直接返回  
        if (newSql.indexOf("order") == -1) {  
            return sql;  
        }  
        int idx = newSql.lastIndexOf("order");  
        return sb.substring(0, idx).toString();  
    }  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:11:01
     * 方法介绍:   从代理对象中分离出真实对象.
     * 参数说明:   @param target
     * 参数说明:   @return
     * @return     Object
     */
    private Object getUnProxyObject(Object target) {  
        MetaObject metaStatementHandler = SystemMetaObject.forObject(target);  
        // 分离代理对象链(由于目标类可能被多个拦截器拦截，从而形成多次代理，通过循环可以分离出最原始的的目标类)  
        Object object = null;  
        while (metaStatementHandler.hasGetter("h")) {  
            object = metaStatementHandler.getValue("h");  
        }  
        if (object == null) {  
            return target;  
        }  
        return object;  
    }  
  
    /** 
     * 生成代理对象 
     * 参数说明 :  @param statementHandler 原始对象 
     * @return 代理对象 
     */  
    @Override  
    public Object plugin(Object statementHandler) {  
        return Plugin.wrap(statementHandler, this);  
    }  
  
    /** 
     * 设置插件配置参数。 
     */  
    @Override  
    public void setProperties(Properties props) {  
    	
        String strDefaultPage = props.getProperty("default.page", "1");  
        String strDefaultPageSize = props.getProperty("default.pageSize", "10");  
        String strDefaultUseFlag = props.getProperty("default.useFlag", "false");  
        String strDefaultCheckFlag = props.getProperty("default.checkFlag", "false");  
        String StringDefaultCleanOrderBy = props.getProperty("default.cleanOrderBy", "false");  
  
        this.defaultPage = Integer.parseInt(strDefaultPage);  
        this.defaultPageSize = Integer.parseInt(strDefaultPageSize);  
        this.defaultUseFlag = Boolean.parseBoolean(strDefaultUseFlag);  
        this.defaultCheckFlag = Boolean.parseBoolean(strDefaultCheckFlag);  
        this.defaultCleanOrderBy = Boolean.parseBoolean(StringDefaultCleanOrderBy);  
    }  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:11:54
     * 方法介绍:   计算总数的SQL,这里需要根据数据库的类型改写SQL，目前支持MySQL和Oracle 
     * 参数说明:   @param currSql 当前执行的SQL 
     * 参数说明:   @param dbType
     * 参数说明:   @return 改写后的SQL 
     * 参数说明:   @throws NotSupportedException
     * @return     String
     */
    private String getTotalSQL(String currSql, String dbType) throws NotSupportedException {

        if (DB_TYPE_MYSQL.equals(dbType)) {
            return  "select count(*) as total from (" + currSql + ") $_paging";  
        } else if (DB_TYPE_ORACLE.equals(dbType)) {  
            return "select count(*) as total from (" + currSql +")";  
        } else if(DB_TYPE_DMSQL.equals(dbType)){
            currSql= this.preDmStrSql(currSql);
            return ("select count(*) as total from (" + currSql +")").toUpperCase();
        } else if(KB_TYPE_DMSQL.equals(dbType)){
            return ("select count(*) as total from (" + currSql +")").toUpperCase();
        } else {
            throw new NotSupportedException("当前插件未支持此类型数据库");  
        }  
    }  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:12:19
     * 方法介绍:    需要使用其他数据库需要改写 ,分页获取参数的SQL,这里需要根据数据库的类型改写SQL，目前支持MySQL和Oracle 
     * 参数说明:   @param currSql 当前执行的SQL
     * 参数说明:   @param dbType
     * 参数说明:   @return 改写后的SQL
     * 参数说明:   @throws NotSupportedException
     * @return     String
     */
    private String getPageDataSQL(String currSql, String dbType) throws NotSupportedException {
    	//System.out.println("getPageDataSQL:"+dbType);
        if (DB_TYPE_MYSQL.equals(dbType)) {
          /*  currSql = currSql.toUpperCase();
            if(currSql.indexOf("ORDER")!=-1){
                String order = currSql.substring(currSql.indexOf("ORDER"),currSql.length());
                currSql = currSql.substring(0,currSql.indexOf("ORDER"));
                return "select * from  ("+currSql+") $_paging_table "+ order +" limit ?, ? ";
            }*/
            return "select * from (" + currSql + ") $_paging_table limit ?, ?";  
        } else if (DB_TYPE_ORACLE.equals(dbType)) {  
            return " select * from (select cur_sql_result.*, rownum rn from (" + currSql + ") cur_sql_result  where rownum <= ?) where rn > ?";  
        }else if(DB_TYPE_DMSQL.equals(dbType)) {
            currSql=    preDmStrSql(currSql);
            return (" select * from (select cur_sql_result.*, rownum rn from (" + currSql + ") cur_sql_result  where rownum <= ?) where rn > ?").toUpperCase();
        }else if(KB_TYPE_DMSQL.equals(dbType)) {
            return (" select * from (select cur_sql_result.*, rownum rn from (" + currSql + ") cur_sql_result  where rownum <= ?) where rn > ?").toUpperCase();
        }else {
            throw new NotSupportedException("当前插件未支持此类型数据库");  
        }  
    }  
  
    /**
     * 
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午11:12:55
     * 方法介绍:   需要使用其他数据库需要改写 ,使用PreparedStatement预编译两个分页参数，如果数据库的规则不一样，需要改写设置的参数规则。目前支持MySQL和Oracle 
     * 参数说明:   @param ps
     * 参数说明:   @param pageNum
     * 参数说明:   @param pageSize
     * 参数说明:   @param dbType
     * 参数说明:   @throws Exception
     * @return     void
     */
    private void preparePageDataParams(PreparedStatement ps, int pageNum, int pageSize, String dbType) throws Exception {  
        //prepared()方法编译SQL，由于MyBatis上下文没有我们分页参数的信息，所以这里需要设置这两个参数.  
            //获取需要设置的参数个数，由于我们的参数是最后的两个，所以很容易得到其位置  
    	//System.out.println("preparePageDataParams:"+dbType);
            int idx = ps.getParameterMetaData().getParameterCount();  
            if (DB_TYPE_MYSQL.equals(dbType)) {  
                //最后两个是我们的分页参数.  
                ps.setInt(idx -1, (pageNum - 1) * pageSize);//开始行  
                ps.setInt(idx, pageSize); //限制条数  
            } else if (DB_TYPE_ORACLE.equals(dbType)) {  
                ps.setInt(idx -1, pageNum * pageSize);//结束行  
                ps.setInt(idx, (pageNum - 1) * pageSize); //开始行  
            } else if(DB_TYPE_DMSQL.equals(dbType)){
                ps.setInt(idx -1, pageNum * pageSize);//结束行
                ps.setInt(idx, (pageNum - 1) * pageSize); //开始行
            }else if(KB_TYPE_DMSQL.equals(dbType)){
                ps.setInt(idx -1, pageNum * pageSize);//结束行
                ps.setInt(idx, (pageNum - 1) * pageSize); //开始行
            } else {
                throw new NotSupportedException("当前插件未支持此类型数据库");
            }
  
    }
  
//    /** 
//     * 
//     * TODO 需要使用其他数据库需要改写 
//     * 目前支持MySQL和Oracle 
//     * @param mappedStatement 
//     * @return 
//     * @throws Exception 
//     */  
//    private String getDataSourceType(MappedStatement mappedStatement) throws Exception {  
//        Connection conn = null;  
//        String dbConnectionStr = null;  
//        try {  
//            conn = mappedStatement.getConfiguration().getEnvironment().getDataSource().getConnection();  
//            dbConnectionStr  = conn.toString();  
//        	System.out.println("getDataSourceType:"+dbConnectionStr);
//        } finally {  
//            if (conn != null) {  
//                conn.close();  
//            }  
//        }  
//        if (null == dbConnectionStr || dbConnectionStr.trim().equals(""))  {  
//            throw new NotSupportedException("当前插件未能获得数据库连接信息。");  
//        }  
//        dbConnectionStr = dbConnectionStr.toLowerCase();  
//        if (dbConnectionStr.contains(DB_TYPE_MYSQL)) {  
//            return DB_TYPE_MYSQL;  
//        } else if (dbConnectionStr.contains(DB_TYPE_ORACLE)) {  
//            return DB_TYPE_ORACLE;  
//        } else {  
//            throw new NotSupportedException("当前插件未支持此类型数据库");  
//        }  
//    }  

    /**
     *
     * 创建作者:   张勇
     * 创建日期:   2017-5-2 下午14:10:10
     * 方法介绍:   数据库连接类型
     * @return     String 数据库类型
     */
    public String returnSqlType(){
        String retrunSql = "";
//	   com.microsoft.sqlserver.jdbc.SQLServerDriver
        String name=  ResourceBundle.getBundle("jdbc-sql").getString("driverClassName");
        if("com.mysql.cj.jdbc.Driver".equals(name.trim())){
            retrunSql = "mysql";
        }else if("oracle.jdbc.driver.OracleDriver".equals(name.trim())){
            retrunSql = "oracle";
        }else if("com.microsoft.sqlserver.jdbc.SQLServerDriver".equals(name.trim())){
            retrunSql = "sqlserver";
        }else if("dm.jdbc.driver.DmDriver".equals(name.trim())){
            retrunSql ="dmsql";
        }else if("com.kingbase8.Driver".equals(name.trim())){
            retrunSql ="kingbase";
        }
        return retrunSql;
    }

    
}
