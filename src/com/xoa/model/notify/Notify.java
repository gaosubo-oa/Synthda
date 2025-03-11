package com.xoa.model.notify;

import com.alibaba.fastjson.annotation.JSONField;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 
 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:36:27 类介绍 : 公告实体类 构造参数: 无
 * 
 */
public class Notify {


	private Integer notifyId;
	/**
	 * 发布部门id
	 */

	private Integer fromDept;
	/**
	 * 发布用户USER_ID
	 */
	private String fromId;
	/**
	 * 公告标题
	 */
	private String subject;
	/**
	 * 发布时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Date sendTime;
	private String sendTimeStr;
	/**
	 * 开始日期
	 */
	private Integer beginDate;
	/**
	 * 结束日期
	 */
	private Integer endDate;
	/**
	 * 是否允许打印office附件
	 */
	private String print;
	/**
	 * 公告类型
	 */
	private String typeId;
	/**
	 * 是否置顶(0-否,1-是)
	 */
	private String top;
	/**
	 * 置顶天数
	 */
	private Integer topDays;

	/**
	 * 公告通知格式(0-普通格式,1-MHT格式,2-超链接)
	 */
	private String format;
	/**
	 * 发布标示(0-未发布,1-已发布,2-已终止)
	 */
	private String publish;
	/**
	 * 审核人用户ID
	 */
	private String auditer;
	/**
	 * 审核时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JSONField(format = "yyyy-MM-dd")
	private Date auditDate;
	/**
	 * 是否允许下载office附件
	 */
	private String download;
	/**
	 * 最后编辑人
	 */
	private String lastEditor;
	/**
	 * 最后编辑时间
	 */
	private Date lastEditTime;
	/**
	 * 公告标题颜色
	 */
	private String subjectColor;
	/**
	 * 内容关键字
	 */
	private String keyword;
	/**
	 * 是否转发
	 */
	private String isFw;
	/**
	 * 按部门发布
	 */
	private String toId;
	/**
	 * 发布通知内容
	 */
	private String content;
	/**
	 * 附件ID串
	 */
	private String attachmentId;
	/**
	 * 附件名称串
	 */
	private String attachmentName;
	/**
	 * 阅读人员用户ID串
	 */
	private String readers;
	/**
	 * 按角色发布
	 */
	private String privId;
	/**
	 * 按人员发布
	 */
	private String userId;
	/**
	 * 审核人不同意的原因
	 */
	private String reason;
	/**
	 * 压缩后的公告通知内容
	 */
	private byte[] compressContent;
	/**
	 * 内容简介
	 */
	private String summary;
   //用户对象
	private Users users;
	private String name;

	private SysCode codes;

	private String notifyDateTime;

	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 */
	private Integer read;

	private String typeName;
	private String userrange;
	private String rolerange;
	private String deprange;

	private String begin;

	private String end;

	private  String auditerName;//审批名字
	private  String depName;//部门名字

	private String smsRemind;

	private String approveRemind;

	// 回执信息
	private List<NotifyOpinionWithBLOBs> notifyOpinions;

	private Integer modelType;

	private String openWindow;

	private String contentSecrecy;

	public String getOpenWindow() {
		return openWindow;
	}

	public void setOpenWindow(String openWindow) {
		this.openWindow = openWindow;
	}

	public List<NotifyOpinionWithBLOBs> getNotifyOpinions() {
		return notifyOpinions;
	}

	public void setNotifyOpinions(List<NotifyOpinionWithBLOBs> notifyOpinions) {
		this.notifyOpinions = notifyOpinions;
	}

	public String getAuditerName() {
		return auditerName==null?"":auditerName;
	}

	public void setAuditerName(String auditerName) {
		this.auditerName = auditerName;
	}

	public String getDepName() {
		return depName==null?"":depName;
	}

	public void setDepName(String depName) {
		this.depName = depName;
	}

	private  String totleNum;

	private  List<Department> departmentList;

	private  Integer  readSize;

	private  Integer  unreadSize;

	public Integer getReadSize() {
		return readSize;
	}

	public void setReadSize(Integer readSize) {
		this.readSize = readSize;
	}

	public Integer getUnreadSize() {
		return unreadSize;
	}

	public void setUnreadSize(Integer unreadSize) {
		this.unreadSize = unreadSize;
	}

	public List<Department> getDepartmentList() {
		return departmentList;
	}

	public void setDepartmentList(List<Department> departmentList) {
		this.departmentList = departmentList;
	}

	public String getTotleNum() {
		return totleNum;
	}

	public void setTotleNum(String totleNum) {
		this.totleNum = totleNum;
	}

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	/**
	 * 附件对象
	 */
	private List<Attachment> attachment;
	

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-20 下午6:30:51 方法介绍: 获取公告类型 参数说明: @return
	 * 
	 * @return String
	 */
	public String getTypeName() {
		return typeName;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-20 下午6:31:21 方法介绍: 设置公告类型 参数说明: @param typeName
	 * 
	 * @return void
	 */
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:38:20 方法介绍: get方法，获取用户名 参数说明: @return
	 * 
	 * @return String
	 */
	public String getName() {
		return name;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:43:26 方法介绍: set方法，设置用户名 参数说明: @param name
	 * 
	 * @return void
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:47:08 方法介绍: get方法 获取用户 参数说明: @return
	 * 
	 * @return Users
	 */
	public Users getUsers() {
		return users;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:49:03 方法介绍: set方法 设置用户 参数说明: @param users
	 * 
	 * @return void
	 */
	public void setUsers(Users users) {
		this.users = users;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:50:41 方法介绍: 获取按部门发布信息 参数说明: @return
	 * 
	 * @return String
	 */
	public String getToId() {
		return toId==null?"":toId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:51:05 方法介绍: 设置按部门发布信息 参数说明: @param toId
	 * 
	 * @return void
	 */
	public void setToId(String toId) {
		this.toId = toId == null ? "" : toId.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:52:00 方法介绍: 获取内容信息 参数说明: @return
	 * 
	 * @return String
	 */
	public String getContent() {
		return content==null?"":content;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:52:44 方法介绍: 设置内容信息 参数说明: @param content
	 * 
	 * @return void
	 */
	public void setContent(String content) {
		this.content = content == null ? "" : content.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:54:17 方法介绍: 获取附件ID串 参数说明: @return
	 * 
	 * @return String
	 */
	public String getAttachmentId() {
		if(attachmentId==null){
			attachmentId="";
		}
		return attachmentId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:54:30 方法介绍: 设置附件ID串 参数说明: @param
	 * attachmentId
	 * 
	 * @return void
	 */
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:55:07 方法介绍: 获取附件名称串 参数说明: @return
	 * 
	 * @return String
	 */
	public String getAttachmentName() {
		return attachmentName==null?"":attachmentName;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:55:30 方法介绍: 设置附件名称串 参数说明: @param
	 * attachmentName
	 * 
	 * @return void
	 */
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:55:54 方法介绍: 获取阅读人员ID 参数说明: @return
	 * 
	 * @return String
	 */
	public String getReaders() {


		return readers==null?"":readers;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:56:20 方法介绍: 设置阅读人员ID 参数说明: @param readers
	 * 
	 * @return void
	 */
	public void setReaders(String readers) {
		this.readers = readers == null ? null : readers.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:56:48 方法介绍: 获取按角色发布ID 参数说明: @return
	 * 
	 * @return String
	 */
	public String getPrivId() {

		return privId==null?"":privId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:57:05 方法介绍: 设置按角色发布ID 参数说明: @param privId
	 * 
	 * @return void
	 */
	public void setPrivId(String privId) {
		this.privId = privId == null ? null : privId.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:57:21 方法介绍: 获取用户ID 参数说明: @return
	 * 
	 * @return String
	 */
	public String getUserId() {

		return userId==null?"":userId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:57:49 方法介绍: 设置用户ID 参数说明: @param userId
	 * 
	 * @return void
	 */
	public void setUserId(String userId) {
		this.userId = userId == null ? null : userId.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:58:50 方法介绍: 获取审核人不同意的原因 参数说明: @return
	 * 
	 * @return String
	 */
	public String getReason() {
		return reason==null?"":reason;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:59:08 方法介绍: 设置审核人不同意的原因 参数说明: @param reason
	 * 
	 * @return void
	 */
	public void setReason(String reason) {
		this.reason = reason == null ? null : reason.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:59:23 方法介绍: 获取得到压缩后的公告通知内容 参数说明: @return
	 * 
	 * @return byte[]
	 */
	public byte[] getCompressContent() {
		return compressContent==null?new byte[0]:compressContent;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:59:43 方法介绍: 设置压缩后的公告通知内容 参数说明: @param
	 * compressContent
	 * 
	 * @return void
	 */
	public void setCompressContent(byte[] compressContent) {
		this.compressContent = compressContent;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:00:08 方法介绍: 获取内容简介信息 参数说明: @return
	 * 
	 * @return String
	 */
	public String getSummary() {
		return summary==null?"":summary;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:00:35 方法介绍: 设置内容简介信息 参数说明: @param summary
	 * 
	 * @return void
	 */
	public void setSummary(String summary) {
		this.summary = summary == null ? null : summary.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:05:00 方法介绍: 获取公告ID(主键) 参数说明: @return
	 * 
	 * @return Integer
	 */
	public Integer getNotifyId() {
		return notifyId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:05:13 方法介绍: 设置公告ID(主键) 参数说明: @param
	 * notifyId
	 * 
	 * @return void
	 */
	public void setNotifyId(Integer notifyId) {
		this.notifyId = notifyId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:05:25 方法介绍: 获取发布部门ID 参数说明: @return
	 * 
	 * @return Integer
	 */

	public Integer getFromDept() {
		return fromDept==null?0:fromDept;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:05:51 方法介绍: 设置发布部门ID 参数说明: @param fromDept
	 * 
	 * @return void
	 */
	public void setFromDept(Integer fromDept) {
		this.fromDept = fromDept;
	}
	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 * 
	 * @return
	 */
	public Integer getRead() {
		return read;
	}

	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 * 
	 * @param read
	 */
	public void setRead(Integer read) {
		this.read = read;
	}
	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:06:24 方法介绍: 获取发布用户ID(USER_ID) 参数说明: @return
	 * 
	 * @return String
	 */
	public String getFromId() {
		return fromId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:06:47 方法介绍: 设置发布用户ID(USER_ID) 参数说明: @param
	 * fromId
	 * 
	 * @return void
	 */
	public void setFromId(String fromId) {
		this.fromId = fromId == null ? null : fromId.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:06:54 方法介绍: 获取公告标题 参数说明: @return
	 * 
	 * @return String
	 */
	public String getSubject() {
		return subject==null?"":subject;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:07:11 方法介绍: 设置公告标题 参数说明: @param subject
	 * 
	 * @return void
	 */
	public void setSubject(String subject) {
		this.subject = subject == null ? null : subject.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:07:39 方法介绍: 获取开始日期 参数说明: @return
	 * 
	 * @return Integer
	 */
	public Integer getBeginDate() {
		return beginDate==null?0:beginDate;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:07:51 方法介绍: 设置开始日期 参数说明: @param beginDate
	 * 
	 * @return void
	 */
	public void setBeginDate(Integer beginDate) {
		this.beginDate = beginDate;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:08:05 方法介绍: 获取结束日期 参数说明: @return
	 * 
	 * @return Integer
	 */
	public Integer getEndDate() {
		return endDate==null?0:endDate;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:08:41 方法介绍: 设置结束日期 参数说明: @param endDate
	 * 
	 * @return void
	 */
	public void setEndDate(Integer endDate) {
		this.endDate = endDate;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:08:59 方法介绍: 获取是否允许打印office附件信息(0-不允许,1-允许)
	 * 参数说明: @return
	 * 
	 * @return String
	 */
	public String getPrint() {
		return print==null?"":print;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:09:12 方法介绍: 获取是否允许打印office附件信息(0-不允许,1-允许)
	 * 参数说明: @param print
	 * 
	 * @return void
	 */
	public void setPrint(String print) {
		this.print = print == null ? null : print.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:09:42 方法介绍: 获取公告类型ID 参数说明: @return
	 * 
	 * @return String
	 */
	public String getTypeId() {
		return typeId==null?"":typeId;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:09:51 方法介绍: 设置公告类型ID 参数说明: @param typeId
	 * 
	 * @return void
	 */
	public void setTypeId(String typeId) {
		this.typeId = typeId == null ? null : typeId.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:10:13 方法介绍: 获取置顶信息 参数说明: @return
	 * 
	 * @return String
	 */
	public String getTop() {
		return top==null?"":top;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:10:25 方法介绍: 设置置顶信息 参数说明: @param top
	 * 
	 * @return void
	 */
	public void setTop(String top) {
		this.top = top == null ? null : top.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:10:43 方法介绍: 获取置顶天数 参数说明: @return
	 * 
	 * @return Integer
	 */
	public Integer getTopDays() {
		return topDays==null?0:topDays;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:10:52 方法介绍: 设置置顶天数 参数说明: @param topDays
	 * 
	 * @return void
	 */
	public void setTopDays(Integer topDays) {
		this.topDays = topDays;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:11:13 方法介绍:
	 * 获取公告通知格式信息(0-普通格式,1-html格式,2-超链接) 参数说明: @return
	 * 
	 * @return String
	 */
	public String getFormat() {
		return format==null?"":format;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:11:37 方法介绍:
	 * 设置公告通知格式信息(0-普通格式,1-html格式,2-超链接) 参数说明: @param format
	 * 
	 * @return void
	 */
	public void setFormat(String format) {
		this.format = format == null ? null : format.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:12:11 方法介绍:
	 * 获取发布标识信息(0-未发布,1-已发布,2-待审批,3-未通过) 参数说明: @return
	 * 
	 * @return String
	 */
	public String getPublish() {
		return publish==null?"":publish;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:12:27 方法介绍:
	 * 设置发布标识信息(0-未发布,1-已发布,2-待审批,3-未通过) 参数说明: @param publish
	 * 
	 * @return void
	 */
	public void setPublish(String publish) {
		this.publish = publish == null ? null : publish.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:12:51 方法介绍: 获取审核人用户ID 参数说明: @return
	 * 
	 * @return String
	 */
	public String getAuditer() {
		return auditer==null?"":auditer;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:13:28 方法介绍: 设置审核人用户ID 参数说明: @param auditer
	 * 
	 * @return void
	 */
	public void setAuditer(String auditer) {
		this.auditer = auditer == null ? null : auditer.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:13:47 方法介绍: 获取是否允许下载office附件(0-不允许,1-允许)
	 * 参数说明: @return
	 * 
	 * @return String
	 */
	public String getDownload() {
		return download==null?"":download;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:14:27 方法介绍: 设置是否允许下载office附件(0-不允许,1-允许)
	 * 参数说明: @param download
	 * 
	 * @return void
	 */
	public void setDownload(String download) {
		this.download = download == null ? null : download.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:14:38 方法介绍: 获取最后编辑人 参数说明: @return
	 * 
	 * @return String
	 */
	public String getLastEditor() {
		return lastEditor==null?"":lastEditor;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:14:50 方法介绍: 设置最后编辑人 参数说明: @return
	 * 
	 * @return DateTest
	 */
	public void setLastEditor(String lastEditor) {
		this.lastEditor = lastEditor;
	}

	/**
	 * 
	 * 创建作者: 吴道全 创建日期: 2017-4-19 下午2:52:26 方法介绍: 获取审核日期 参数说明: @return
	 * 
	 * @return String
	 */
	public Date getAuditDate() {
		return auditDate==null?new Date():auditDate;
	}

	/**
	 * 
	 * 创建作者: 吴道全 创建日期: 2017-4-19 下午2:51:33 方法介绍: 设置审核日期 参数说明: @param auditDate
	 * 
	 * @return void
	 */
	public void setAuditDate(Date auditDate) {
		this.auditDate = auditDate;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:51:17 方法介绍: 获取发送时间 参数说明: @return
	 * 
	 * @return DateTest
	 */

	public Date getSendTime() {
		return sendTime;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:51:45 方法介绍: 设置发送时间 参数说明: @param sendTime
	 * 
	 * @return void
	 */
	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:52:52 方法介绍: 获取最后编辑时间 参数说明: @return
	 * 
	 * @return DateTest
	 */
	public Date getLastEditTime() {
		return lastEditTime;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:53:19 方法介绍: 设置最后编辑时间 参数说明: @param
	 * lastEditTime
	 * 
	 * @return void
	 */
	public void setLastEditTime(Date lastEditTime) {
		this.lastEditTime = lastEditTime;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:59:20 方法介绍: 获取公告标题颜色 参数说明: @return
	 * 
	 * @return String
	 */
	public String getSubjectColor() {
		return subjectColor==null?"":subjectColor;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:59:31 方法介绍: 设置公告标题颜色 参数说明: @param
	 * subjectColor
	 * 
	 * @return void
	 */
	public void setSubjectColor(String subjectColor) {
		this.subjectColor = subjectColor == null ? null : subjectColor.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:59:43 方法介绍: 获取内容关键字 参数说明: @return
	 * 
	 * @return String
	 */
	public String getKeyword() {
		return keyword==null?"":keyword;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午7:59:57 方法介绍: 设置内容关键字 参数说明: @param keyword
	 * 
	 * @return void
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword == null ? null : keyword.trim();
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午8:00:07 方法介绍: 获取是否转发信息 参数说明: @return
	 * 
	 * @return String
	 */
	public String getIsFw() {
		return isFw==null?"":isFw;
	}

	/**
	 * 
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午8:00:17 方法介绍: 设置是否转发信息 参数说明: @param isFw
	 * 
	 * @return void
	 */
	public void setIsFw(String isFw) {
		this.isFw = isFw == null ? null : isFw.trim();
	}

	public String getNotifyDateTime() {
		return notifyDateTime;
	}

	public void setNotifyDateTime(String notifyDateTime) {
		this.notifyDateTime = notifyDateTime;
	}

	public SysCode getCodes() {
		return codes;
	}

	public void setCodes(SysCode codes) {
		this.codes = codes;
	}

	public String getDeprange() {
		return deprange==null?"":deprange;
	}

	public void setDeprange(String deprange) {
		this.deprange = deprange;
	}

	public String getUserrange() {
		return userrange==null?"":userrange;
	}

	public void setUserrange(String userrange) {
		this.userrange = userrange;
	}

	public String getRolerange() {
		return rolerange==null?"":rolerange;
	}

	public void setRolerange(String rolerange) {
		this.rolerange = rolerange;
	}

	public List<Attachment> getAttachment() {
		return attachment;
	}

	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	public Notify() {
	}

	public Notify(String format,String fromId,Date sendTime,String subject, String content,String toId,String publish) {
		this.format = format;
		this.fromId = fromId;
		this.sendTime = sendTime;
		this.subject = subject;
		this.content = content;
		this.toId = toId;
		this.publish = publish;
	}

	//用于公告的发布时间段
	private String beginTime;//开始时间
	private String endTime;//结束时间

	public String getBeginTime() {
		return beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	private int resultCount;//对应结果的数量

	public int getResultCount() {
		return resultCount;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}
	private String fromDeptStr;//发布公告部门的名称
	private String fromIdStr;//发布公告用户的名称

	public void setFromDeptStr(String fromDeptStr) {
		this.fromDeptStr = fromDeptStr;
	}

	public void setFromIdStr(String fromIdStr) {
		this.fromIdStr = fromIdStr;
	}

	public String getFromDeptStr() {
		return fromDeptStr;
	}

	public String getFromIdStr() {
		return fromIdStr;
	}

	private String range;//发布范围

	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}

	private String thingDefault;
	private String smsDefault;

	private String howRenind;

	public String getThingDefault() {
		return thingDefault;
	}

	public String getSmsDefault() {
		return smsDefault;
	}

	public void setThingDefault(String thingDefault) {
		this.thingDefault = thingDefault;
	}

	public void setSmsDefault(String smsDefault) {
		this.smsDefault = smsDefault;
	}

	public String getSmsRemind() {
		return smsRemind;
	}

	public void setSmsRemind(String smsRemind) {
		this.smsRemind = smsRemind;
	}

	public String getApproveRemind() {
		return approveRemind;
	}

	public void setApproveRemind(String approveRemind) {
		this.approveRemind = approveRemind;
	}

	public String getSendTimeStr() {
		return sendTimeStr;
	}

	public void setSendTimeStr(String sendTimeStr) {
		this.sendTimeStr = sendTimeStr;
	}

	public String getHowRenind() {
		return howRenind;
	}

	public void setHowRenind(String howRenind) {
		this.howRenind = howRenind;
	}

	private String isOpin ;

	private String opinionFields;


	private String opinUsers;

	private String draftDept;

	private String userType;

	private String draftDeptName;

	public String getIsOpin() {
		return isOpin;
	}

	public void setIsOpin(String isOpin) {
		this.isOpin = isOpin;
	}

	public String getOpinionFields() {
		return opinionFields;
	}

	public void setOpinionFields(String opinionFields) {
		this.opinionFields = opinionFields;
	}

	public String getOpinUsers() {
		return opinUsers;
	}

	public void setOpinUsers(String opinUsers) {
		this.opinUsers = opinUsers;
	}

	public Integer getModelType() {
		return modelType;
	}

	public void setModelType(Integer modelType) {
		this.modelType = modelType;
	}

	public String getDraftDept() {
		return draftDept;
	}

	public void setDraftDept(String draftDept) {
		this.draftDept = draftDept;
	}

	public String getDraftDeptName() {
		return draftDeptName;
	}

	public void setDraftDeptName(String draftDeptName) {
		this.draftDeptName = draftDeptName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getContentSecrecy() {
		return contentSecrecy;
	}

	public void setContentSecrecy(String contentSecrecy) {
		this.contentSecrecy = contentSecrecy;
	}
}