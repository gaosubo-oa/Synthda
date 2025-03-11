package com.xoa.util;
//用来处理显示静态中文信息
public class Constant {

	public static final String syser="admin";

	public static final String deleteMessage="该部门下有人员，请处理后再删除该部门";

	public static final String exesit="您要下载或查看的资源不存在！";

	public static final String depExesit = "该部门名称或排序号已经存在，请重新填写！";

	public static final String attach = "[A@]";

	public static final int S_THIS_DEP = 1;

	public static final String checkSecureAdminInfo = "当前用户并非三员超级管理员，不可执行该操作";

	public static final String workName = "[B@]";

	public static final String mobileFunction = "校务";

	public static final String noData = "该表单对应流程没有数据！";

	public static final String delete = "delete";


	/**  工作流程使用日志  ↓  **/

	/**  1-新建 **/
	public static final String TYPE0="0";
	/**  1-转交 **/
	public static final String TYPE1="1";
	/**  2-保存/保存返回  **/
	public static final String TYPE2="2";
	/**  3-回退  **/
	public static final String TYPE3="3";
	/**  4-收回  **/
	public static final String TYPE4="4";
	/**  5-归档  **/
	public static final String TYPE5="5";
	/**  6-导出  **/
	public static final String TYPE6="6";
	/**  7-打印  **/
	public static final String TYPE7="7";
	/**  8-上传附件 **/
	public static final String TYPE8="8";
	/**  9-工作委托 **/
	public static final String TYPE9="9";
	/**  10-删除工作 **/
	public static final String TYPE10="10";
	/**  11-结束工作 **/
	public static final String TYPE11="11";
	/**  12-强制结束工作 **/
	public static final String TYPE12="12";
	/**  13-销毁工作 **/
	public static final String TYPE13="13";
	/**  14-还原工作 **/
	public static final String TYPE14="14";
	/**  15-编辑工作 **/
	public static final String TYPE15="15";
	/**  16-催办工作 **/
	public static final String TYPE16="16";
	/**  17-在我的工作中删除待办工作 **/
	public static final String TYPE17="17";
	/**  18-工作交办 **/
	public static final String TYPE18="18";
	/**  19-办理完毕 **/
	public static final String TYPE19="19";
	/**  20-增加经办人 **/
	public static final String TYPE20="20";
	/**  21-删除意见 **/
	public static final String TYPE21="21";
	/**  22-保存正文 **/
	public static final String TYPE22="22";
	/**  23-正文上传word**/
	public static final String TYPE23="23";
	/**  24-正文上传pdf **/
	public static final String TYPE24="24";
	/**  25-超时跳转 **/
	public static final String TYPE25="25";
	/**  26-超时跳转 **/
	public static final String TYPE26="26";
	/**  27-增加经办人 **/
	public static final String TYPE27="27";
	/**  28-批量结束工作 **/
	public static final String TYPE28="28";

	/**  工作流程设计 日志**/

	/** 	新建表单	  **/
	public static final Integer DESIGNTYPE1=1;
	/** 	保存表单	  **/
	public static final Integer DESIGNTYPE2=2;
	/** 	新建流程	  **/
	public static final Integer DESIGNTYPE3=3;
	/** 	新建步骤	  **/
	public static final Integer DESIGNTYPE4=4;
	/** 	可写字段	  **/
	public static final Integer DESIGNTYPE5=5;
	/** 	保密字段	  **/
	public static final Integer DESIGNTYPE6=6;
	/** 	必填字段	  **/
	public static final Integer DESIGNTYPE7=7;
	/** 	经办权限	  **/
	public static final Integer DESIGNTYPE8=8;
	/** 	智能选人	  **/
	public static final Integer DESIGNTYPE9=9;
	/** 	流转设置	  **/
	public static final Integer DESIGNTYPE10=10;
	/** 	编辑流程步骤	  **/
	public static final Integer DESIGNTYPE11=11;
	/** 	删除流程	  **/
	public static final Integer DESIGNTYPE12=12;
	/** 	删除步骤	  **/
	public static final Integer DESIGNTYPE13=13;
	/** 	修改权限（管理权限）	  **/
	public static final Integer DESIGNTYPE14=14;
	/**  	删除权限 （管理权限）**/
	public static final Integer DESIGNTYPE15=15;
	/** 	导入流程	  **/
	public static final Integer DESIGNTYPE16=16;
	/** 	清空流程	  **/
	public static final Integer DESIGNTYPE17=17;
	/**  	编辑表单      **/
	public static final Integer DESIGNTYPE18=18;
	/** 	导入表单	  **/
	public static final Integer DESIGNTYPE19=19;
	/** 	删除表单	  **/
	public static final Integer DESIGNTYPE20=20;
	/**  	编辑流程      **/
	public static final Integer DESIGNTYPE21=21;
	/** 	删除连线	  **/
	public static final Integer DESIGNTYPE22=22;
	/** 	节点连线	  **/
	public static final Integer DESIGNTYPE23=23;
}
