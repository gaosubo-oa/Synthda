package com.xoa.model.email;

import com.alibaba.fastjson.annotation.JSONField;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import com.xoa.util.DateFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:45:51
 * 类介绍  :    发件箱、收件箱内容信息保存
 * 构造参数:   
 *
 */
public class EmailBodyModel implements Serializable {
	private static final long serialVersionUID = 1076969159692234636L;
	
	/**
	 * 大概时间
	 */
	private String probablyDate;
	
	/**
	 * 时间段区间查询传入的开始时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Integer startTime;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private String startTimes;

	/**
	 * 时间段区间查询传入的结束时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Integer endTime;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private String endTimes;
	
	/**
	 * 第一个参数
	 */
	private String firstFlag;
	
	/**
	 * 第二个参数
	 */
	private String secondFlag;
	 
	/**
	 * 一对多（一个用户对应多个邮件）
	 */
	private Users users;
	/**
	 * 自增唯一ID
	 */
	private Integer bodyId;

	/**
	 * 发件人USER_ID
	 */
	private String fromId;

	private String fromName;
	
	/**
	 * 邮件主题
	 */
	private String subject;

	/**
	 * 发送时间
	 */
	private Integer sendTime;

	/**
	 * 是否已发送(0-未发送,1-已发送)
	 */
	private String sendFlag;

	/**
	 * 是否使用短信提醒(0-不提醒,1-提醒)
	 */
	private String smsRemind;

	/**
	 * 重要程度(空-一般邮件,1-重要,2-非常重要)
	 */
	private String important;

	/**
	 * 邮件大小
	 */
	private Long size;

	/**
	 * 从自己的哪个外部邮箱ID对应emailbox中id
	 */
	private Integer fromWebmailId;

	/**
	 * 从自己的哪个外部邮箱向外发送
	 */
	private String fromWebmail;

	/**
	 * 外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)
	 */
	private String webmailFlag;

	/**
	 * 接收外部邮箱名称
	 */
	private String recvFromName;
	/**
	 * 接收外部邮箱ID
	 */
	private String recvFrom;
	/**
	 * 发送外部邮件ID
	 */
	private Integer recvToId;
	/**
	 * 发送外部邮箱名称
	 */
	private String recvTo;
	/**
	 * 是否为外部邮件(0-内部邮件,1-外部邮件)
	 */
	private String isWebmail;
	/**
	 * 是否同时外发(0-不外发,1-勾选向此人发送外部邮件)
	 */
	private String isWf;
	/**
	 * 内容关键词
	 */
	private String keyword;
	/**
	 * 邮件密级等级
	 */
	private Integer secretLevel;
	/**
	 * 审核人USER_ID
	 * 
	 */
	private String auditMan;

	/**
	 * 收件人USER_ID串
	 */
	private String toId2;
	
	/**
	 * 收件人姓名
	 */
	private String toName;
	

	/**
	 * 抄送人USER_ID串
	 */
	private String copyToId;
	
	/**
	 * 抄送人姓名
	 */
	private String copyName;
	

	/**
	 * 密送人USER_ID串
	 */
	private String secretToId;
	
	/**
	 * 密送人姓名
	 */
	private String secretToName;

	/**
	 * 邮件内容
	 */
	private String content;

	/**
	 * 附件ID串
	 */
	private String attachmentId;

	/**
	 * 附件文件名串
	 */
	private String attachmentName;

	/**
	 * 外部收件人邮箱串
	 */
	private String toWebmail;

	/**
	 * 压缩后的邮件内容
	 */
	private byte[] compressContent;

	/**
	 * 外部邮件内容
	 */
	private byte[] webmailContent;

	/**
	 * 审核不通过备注
	 */
	private String auditRemark;
	/**
	 * 抄送外部邮箱串
	 */
	private String copyToWebmail;
	/**
	 * 密送外部邮箱串
	 */
	private String secretToWebmail;
	/**
	 * 点赞人user_id串
	 */
	private String praise;
	/**
	 * 一对多关联email
	 */
	private List<EmailModel> emailList;
	
	/**
	 * 附件对象
	 */
	private List<Attachment> attachment;

	/**
	 * 一对多 外部邮箱
	 */
	private List<Webmail> webmailList;


	/**
	 * 其他邮件
	 */
	private EmailBoxModel emailBoxModel;

	/**
	 * 条件查询发件人拓展自定义字段
	 */
	private String fromUserId;

	/**
	 * 排序参数
	 */
	private String orderByName;

	/**
	 * 是否倒序或升序
	 */
	private String orderWhere;

	/**
	 * 搜索条件
	 */
	private String searchCriteria;


	/**
	 * 收件人信息状态
	 */
	public List<EmailModel> toUserEmailInfo;
	/**
	 * 抄送人信息状态
	 */
   public List<EmailModel> copyUserEmailInfo;
	/**
	 * 秘送人信息状态
	 */
	public List<EmailModel> sercUserEmailInfo;
	/**
	 * 邮件状态
	 */
	private String readFlag;

	/**
	 * 时间
	 */
	private String sendTimeStr;

	public String getSendTimeStr() {
		return sendTimeStr;
	}

	public void setSendTimeStr(String sendTimeStr) {
		this.sendTimeStr = sendTimeStr;
	}

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
	}

	public String getStartTimes() {
		return startTimes;
	}

	public void setStartTimes(String startTimes) {
		this.startTimes = startTimes;
	}

	public String getEndTimes() {
		return endTimes;
	}

	public void setEndTimes(String endTimes) {
		this.endTimes = endTimes;
	}

	private String deptName;

	private Integer deptId;

	private String examFlag;

	private String wordFlag;

	private String approveFlag;

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	private Integer draftsCount;

	private Integer HairboxCount;

	public List<EmailModel> getSercUserEmailInfo() {
		return sercUserEmailInfo;
	}

	public void setSercUserEmailInfo(List<EmailModel> sercUserEmailInfo) {
		this.sercUserEmailInfo = sercUserEmailInfo;
	}

	public List<EmailModel> getToUserEmailInfo() {
		return toUserEmailInfo;
	}

	public void setToUserEmailInfo(List<EmailModel> toUserEmailInfo) {
		this.toUserEmailInfo = toUserEmailInfo;
	}

	public List<EmailModel> getCopyUserEmailInfo() {
		return copyUserEmailInfo;
	}

	public void setCopyUserEmailInfo(List<EmailModel> copyUserEmailInfo) {
		this.copyUserEmailInfo = copyUserEmailInfo;
	}

	/**
	 * 一对多关联email
	 * 
	 * @return
	 */
	public List<EmailModel> getEmailList() {
		return emailList;
	}



	/**
	 * 一对多关联email
	 * 
	 * @param emailList
	 */
	public void setEmailList(List<EmailModel> emailList) {
		this.emailList = emailList;
	}


	/**
	 * 收件人USER_ID串
	 */
	public String getToId2() {
		return toId2 == null ? "":toId2.trim();
	}

	/**
	 * 收件人USER_ID串
	 */
	public void setToId2(String toId2) {
		this.toId2 = toId2;
	}

	/**
	 * 抄送人USER_ID串
	 */
	public String getCopyToId() {
		return copyToId == null ? "" : copyToId.trim();
	}

	/**
	 * 抄送人USER_ID串
	 */
	public void setCopyToId(String copyToId) {
		this.copyToId = copyToId;
	}

	/**
	 * 密送人USER_ID串
	 */
	public String getSecretToId() {
		return secretToId == null ? "":secretToId.trim();
	}

	/**
	 * 密送人USER_ID串
	 */
	public void setSecretToId(String secretToId) {
		this.secretToId = secretToId;
	}

	/**
	 * 一对多（一个用户对应多个邮件）
	 */
	public Users getUsers() {
		return users;
	}

	/**
	 * 一对多（一个用户对应多个邮件）
	 */
	public void setUsers(Users users) {
		this.users = users;
	}

	/**
	 * 时间段区间查询传入的开始时间
	 */
	public Integer getStartTime() {
		return startTime;
	}

	/**
	 * 时间段区间查询传入的开始时间
	 */
	public void setStartTime(Integer startTime) {
		this.startTime = startTime;
	}

	/**
	 * 时间段区间查询传入的结束时间
	 */
	public Integer getEndTime() {
		return endTime;
	}

	/**
	 * 时间段区间查询传入的结束时间
	 */
	public void setEndTime(Integer endTime) {
		this.endTime = endTime;
	}

	/**
	 * 邮件内容
	 */
	public String getContent() {
		return content == null ? "" : content.trim();
	}

	/**
	 * 邮件内容
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * 附件ID串
	 */
	public String getAttachmentId() {
		return attachmentId == null ? "":attachmentId.trim();
	}

	/**
	 * 附件ID串
	 */
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
	}

	/**
	 * 附件文件名串
	 */
	public String getAttachmentName() {
		return attachmentName == null ? "":attachmentName.trim();
	}

	/**
	 * 附件文件名串
	 */
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	/**
	 * 接收外部邮箱名称
	 */
	public void setRecvFromName(String recvFromName) {
		this.recvFromName = recvFromName;
	}

	/**
	 * 接收外部邮箱名称
	 */
	public String getRecvFromName() {
		return recvFromName == null ? "" : recvFromName.trim();
	}

	/**
	 * 接收外部邮箱名称
	 */
	public void From(String recvFromName) {
		this.recvFromName = recvFromName == null ? "" : recvFromName.trim();
	}


	/**
	 * 接收外部邮箱名称
	 */
	public String getToWebmail() {
		return toWebmail == null ? "" : toWebmail.trim();
	}

	/**
	 * 接收外部邮箱名称
	 */
	public void setToWebmail(String toWebmail) {
		this.toWebmail = toWebmail;
	}

	/**
	 * 外部收件人邮箱串
	 */
	public byte[] getCompressContent() {
		return compressContent == null ? new byte[0] : compressContent;
	}

	/**
	 * 压缩后的邮件内容
	 */
	public void setCompressContent(byte[] compressContent) {
		this.compressContent = compressContent;
	}

	/**
	 * 压缩后的邮件内容
	 */
	public byte[] getWebmailContent() {
		return webmailContent== null ? new byte[0] : webmailContent;
	}

	/**
	 * 外部邮件内容
	 */
	public void setWebmailContent(byte[] webmailContent) {
		this.webmailContent = webmailContent;
	}

	/**
	 * 外部邮件内容
	 */
	public String getAuditRemark() {
		return auditRemark == null ? "" : auditRemark.trim();
	}

	/**
	 * 审核不通过备注
	 */
	public void setAuditRemark(String auditRemark) {
		this.auditRemark = auditRemark;
	}

	/**
	 * 抄送外部邮箱串
	 */
	public String getCopyToWebmail() {
		return copyToWebmail == null ? "":copyToWebmail.trim();
	}

	/**
	 * 抄送外部邮箱串
	 */
	public void setCopyToWebmail(String copyToWebmail) {
		this.copyToWebmail = copyToWebmail;
	}

	/**
	 * 密送外部邮箱串
	 */
	public String getSecretToWebmail() {
		return secretToWebmail == null ? "":secretToWebmail.trim();
	}

	/**
	 * 密送外部邮箱串
	 */
	public void setSecretToWebmail(String secretToWebmail) {
		this.secretToWebmail = secretToWebmail;
	}

	/**
	 * 点赞人user_id串
	 */
	public String getPraise() {
		return praise == null ? "":praise.trim();
	}

	/**
	 * 点赞人user_id串
	 */
	public void setPraise(String praise) {
		this.praise = praise;
	}

	/**
	 * 自增唯一ID
	 */

	public Integer getBodyId() {
		return bodyId;
	}

	/**
	 * 自增唯一ID
	 */
	public void setBodyId(Integer bodyId) {
		this.bodyId = bodyId;
	}

	/**
	 * 发件人USER_ID
	 */
	public String getFromId() {
		return fromId == null ? "" : fromId.trim();
	}

	/**
	 * 发件人USER_ID
	 */
	public void setFromId(String fromId) {
		this.fromId = fromId == null ? null : fromId.trim();
	}

	/**
	 * 邮件主题
	 */
	public String getSubject() {
		return subject == null ? "" : subject.trim();
	}

	/**
	 * 邮件主题
	 */
	public void setSubject(String subject) {
		this.subject = subject == null ? null : subject.trim();
	}

	/**
	 * 发送时间
	 */
	public Integer getSendTime() {
		return sendTime;
	}

	/**
	 * 发送时间
	 */
	public void setSendTime(Integer sendTime) {
		this.sendTime = sendTime;
	}

	/**
	 * 是否已发送(0-未发送,1-已发送)
	 */
	public String getSendFlag() {
		return sendFlag;
	}

	/**
	 * 是否已发送(0-未发送,1-已发送)
	 */
	public void setSendFlag(String sendFlag) {
		this.sendFlag = sendFlag == null ? null : sendFlag.trim();
	}

	/**
	 * 是否使用短信提醒(0-不提醒,1-提醒)
	 */
	public String getSmsRemind() {
		return smsRemind == null ? "0" : smsRemind.trim();
	}

	/**
	 * 是否使用短信提醒(0-不提醒,1-提醒)
	 */
	public void setSmsRemind(String smsRemind) {
		this.smsRemind = smsRemind == null ? null : smsRemind.trim();
	}

	/**
	 * 重要程度(空-一般邮件,1-重要,2-非常重要)
	 */
	public String getImportant() {
		return important == null ? "" : important.trim();
	}

	/**
	 * 重要程度(空-一般邮件,1-重要,2-非常重要)
	 */
	public void setImportant(String important) {
		this.important = important == null ? null : important.trim();
	}

	/**
	 * 邮件大小
	 */
	public Long getSize() {
		return size == null ? 0L:size;
	}

	/**
	 * 邮件大小
	 */
	public void setSize(Long size) {
		this.size = size;
	}

	/**
	 * 从自己的哪个外部邮箱ID对应emailbox中id
	 */
	public Integer getFromWebmailId() {
		return fromWebmailId == null ? 0 : fromWebmailId;
	}

	/**
	 * 从自己的哪个外部邮箱ID对应emailbox中id
	 */
	public void setFromWebmailId(Integer fromWebmailId) {
		this.fromWebmailId = fromWebmailId;
	}

	/**
	 * 从自己的哪个外部邮箱向外发送
	 */
	public String getFromWebmail() {
		return fromWebmail == null ? "" : fromWebmail.trim();
	}

	/**
	 * 从自己的哪个外部邮箱向外发送
	 */
	public void setFromWebmail(String fromWebmail) {
		this.fromWebmail = fromWebmail == null ? null : fromWebmail.trim();
	}

	/**
	 * 外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)
	 */
	public String getWebmailFlag() {
		return webmailFlag == null ? "0" : webmailFlag.trim();
	}

	/**
	 * 外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)
	 */
	public void setWebmailFlag(String webmailFlag) {
		this.webmailFlag = webmailFlag == null ? null : webmailFlag.trim();
	}

	/**
	 * 接收外部邮箱ID
	 */
	public String getRecvFrom() {
		return recvFrom == null ? "" : recvFrom.trim();
	}

	/**
	 * 接收外部邮箱ID
	 */
	public void setRecvFrom(String recvFrom) {
		this.recvFrom = recvFrom == null ? null : recvFrom.trim();
	}

	/**
	 * 发送外部邮件ID
	 */
	public Integer getRecvToId() {
		return recvToId == null ? 0:recvToId;
	}

	/**
	 * 发送外部邮件ID
	 */
	public void setRecvToId(Integer recvToId) {
		this.recvToId = recvToId;
	}

	/**
	 * 发送外部邮箱名称
	 */
	public String getRecvTo() {
		return recvTo == null ? "" : recvTo.trim();
	}

	/**
	 * 发送外部邮箱名称
	 */
	public void setRecvTo(String recvTo) {
		this.recvTo = recvTo == null ? null : recvTo.trim();
	}

	/**
	 * 是否为外部邮件(0-内部邮件,1-外部邮件)
	 */
	public String getIsWebmail() {
		return isWebmail == null ? "0" : isWebmail.trim();
	}

	/**
	 * 是否为外部邮件(0-内部邮件,1-外部邮件)
	 */
	public void setIsWebmail(String isWebmail) {
		this.isWebmail = isWebmail == null ? null : isWebmail.trim();
	}

	/**
	 * 是否同时外发(0-不外发,1-勾选向此人发送外部邮件)
	 */
	public String getIsWf() {
		return isWf == null ? "0" : isWf.trim();
	}

	/**
	 * 是否同时外发(0-不外发,1-勾选向此人发送外部邮件)
	 */
	public void setIsWf(String isWf) {
		this.isWf = isWf == null ? null : isWf.trim();
	}

	/**
	 * 内容关键词
	 */
	public String getKeyword() {
		return keyword == null ? "" : keyword.trim();
	}

	/**
	 * 内容关键词
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword == null ? null : keyword.trim();
	}

	/**
	 * 邮件密级等级
	 */
	public Integer getSecretLevel() {
		return secretLevel == null ? 0: secretLevel;
	}

	/**
	 * 邮件密级等级
	 */
	public void setSecretLevel(Integer secretLevel) {
		this.secretLevel = secretLevel;
	}

	/**
	 * 审核人USER_ID
	 */
	public String getAuditMan() {
		return auditMan  == null ? "" : auditMan.trim();
	}

	/**
	 * 审核人USER_ID
	 */
	public void setAuditMan(String auditMan) {
		this.auditMan = auditMan == null ? null : auditMan.trim();
	}
	
	
	/**
	 * 第一个参数
	 * @return
	 */
	public String getFirstFlag() {
		return firstFlag;
	}

	/**
	 * 第一个参数
	 * @param firstFlag
	 */
	public void setFirstFlag(String firstFlag) {
		this.firstFlag = firstFlag;
	}

	/**
	 * 第二个参数
	 * @return
	 */
	public String getSecondFlag() {
		return secondFlag;
	}

	/**
	 * 第二个参数
	 * @param secondFlag
	 */
	public void setSecondFlag(String secondFlag) {
		this.secondFlag = secondFlag;
	}

	/**
	 * 收件人姓名
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:12:54
	 * 方法介绍:   收件人姓名
	 * 参数说明:   @return
	 * @return     String
	 */
	public String getToName() {
		return toName==null?"":toName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:14:11
	 * 方法介绍:   收件人姓名
	 * 参数说明:   @param toName
	 * @return     void
	 */
	public void setToName(String toName) {
		this.toName = toName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:14:33
	 * 方法介绍:   抄送人姓名
	 * 参数说明:   @return
	 * @return     String
	 */
	public String getCopyName() {
		return copyName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:14:44
	 * 方法介绍:   抄送人姓名
	 * 参数说明:   @param copyName
	 * @return     void
	 */
	public void setCopyName(String copyName) {
		this.copyName = copyName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:14:54
	 * 方法介绍:   密送人姓名
	 * 参数说明:   @return
	 * @return     String
	 */
	public String getSecretToName() {
		return secretToName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-26 下午6:15:04
	 * 方法介绍:   密送人姓名
	 * 参数说明:   @param secretToName
	 * @return     void
	 */
	public void setSecretToName(String secretToName) {
		this.secretToName = secretToName;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-27 上午10:37:14
	 * 方法介绍:   大概时间
	 * 参数说明:   @return
	 * @return     String
	 */
	public String getProbablyDate() {
		return probablyDate;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-27 上午10:37:21
	 * 方法介绍:   大概时间
	 * 参数说明:   @param probablyDate
	 * @return     void
	 */
	public void setProbablyDate(String probablyDate) {
		this.probablyDate = probablyDate;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-27 下午1:53:18
	 * 方法介绍:   附件对象
	 * 参数说明:   @return
	 * @return     List<Attachment>
	 */
	public List<Attachment> getAttachment() {
		return attachment;
	}

	/**
	 * 
	 * 创建作者:   张勇
	 * 创建日期:   2017-4-27 下午1:53:26
	 * 方法介绍:   附件对象
	 * 参数说明:   @param attachment
	 * @return     void
	 */
	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 13:36
	 * 方法介绍:   其他邮件
	 * 参数说明:
	 * @return
	 */
	public EmailBoxModel getEmailBoxModel() {
		return emailBoxModel;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/5/15 13:36
	 * 方法介绍:   其他邮件
	 * 参数说明:
	 * @return
	 */
	public void setEmailBoxModel(EmailBoxModel emailBoxModel) {
		this.emailBoxModel = emailBoxModel;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/6/15 19:27
	 * 方法介绍:   一对多 外部邮箱
	 * 参数说明:
	 * @return
	 */
	public List<Webmail> getWebmailList() {
		return webmailList;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/6/15 19:27
	 * 方法介绍:   一对多 外部邮箱
	 * 参数说明:
	 * @return
	 */
	public void setWebmailList(List<Webmail> webmailList) {
		this.webmailList = webmailList;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/3 13:38
	 * 方法介绍:   条件查询发件人拓展自定义字段
	 * 参数说明:
	 * @return
	 */
	public String getFromUserId() {
		return fromUserId;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/3 13:39
	 * 方法介绍:   条件查询发件人拓展自定义字段
	 * 参数说明:
	 * @return
	 */
	public void setFromUserId(String fromUserId) {
		this.fromUserId = fromUserId;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 14:53
	 * 方法介绍:   排序参数
	 * 参数说明:
	 * @return
	 */
	public String getOrderByName() {
		return orderByName;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 14:53
	 * 方法介绍:   排序参数
	 * 参数说明:
	 * @return
	 */
	public void setOrderByName(String orderByName) {
		this.orderByName = orderByName;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 15:16
	 * 方法介绍:   搜索条件
	 * 参数说明:
	 * @return
	 */
	public String getSearchCriteria() {
		return searchCriteria;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 15:16
	 * 方法介绍:   搜索条件
	 * 参数说明:
	 * @return
	 */
	public void setSearchCriteria(String searchCriteria) {
		this.searchCriteria = searchCriteria;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 14:53
	 * 方法介绍:   是否倒序或升序
	 * 参数说明:
	 * @return
	 */
	public String getOrderWhere() {
		return orderWhere;
	}

	/**
	 * 创建作者:   张勇
	 * 创建日期:   2017/7/5 14:54
	 * 方法介绍:   是否倒序或升序
	 * 参数说明:
	 * @return
	 */
	public void setOrderWhere(String orderWhere) {
		this.orderWhere = orderWhere;
	}

	public EmailBodyModel() {
	}

	public EmailBodyModel(String fromId, Date sendTime,String subject, String content,String toId2) {
		this.fromId = fromId;
		this.sendTime = DateFormat.getTime(DateFormat.getStrDate(sendTime));
		this.subject = subject;
		this.content = content;
		this.toId2 = toId2;
	}

	public Integer getDraftsCount() {
		return draftsCount;
	}

	public void setDraftsCount(Integer draftsCount) {
		this.draftsCount = draftsCount;
	}

	public Integer getHairboxCount() {
		return HairboxCount;
	}

	public void setHairboxCount(Integer hairboxCount) {
		HairboxCount = hairboxCount;
	}

	private String sendTimes;
	public void setSendTimes(String sendTimes) {
		this.sendTimes = sendTimes;
	}
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public String getSendTimes() {
		return sendTimes;
	}

	private String Months;
    public String getMonths() {
        return Months;
    }

	public void setMonths(String Months) {

		this.Months = Months;
	}
	private Integer count1;
	private Integer count2;
	private Integer count3;
	private Integer count4;
	private Integer count5;
	private Integer count6;
	private Integer count7;
	private Integer count8;
	private Integer count9;
	private Integer count10;
	private Integer count11;
	private Integer count12;


	public Integer getCount1() {
		return count1;
	}

	public void setCount1(Integer count1) {
		this.count1 = count1;
	}

	public Integer getCount2() {
		return count2;
	}

	public void setCount2(Integer count2) {
		this.count2 = count2;
	}

	public Integer getCount3() {
		return count3;
	}

	public void setCount3(Integer count3) {
		this.count3 = count3;
	}

	public Integer getCount4() {
		return count4;
	}

	public void setCount4(Integer count4) {
		this.count4 = count4;
	}

	public Integer getCount5() {
		return count5;
	}

	public void setCount5(Integer count5) {
		this.count5 = count5;
	}

	public Integer getCount6() {
		return count6;
	}

	public void setCount6(Integer count6) {
		this.count6 = count6;
	}

	public Integer getCount7() {
		return count7;
	}

	public void setCount7(Integer count7) {
		this.count7 = count7;
	}

	public Integer getCount8() {
		return count8;
	}

	public void setCount8(Integer count8) {
		this.count8 = count8;
	}

	public Integer getCount9() {
		return count9;
	}

	public void setCount9(Integer count9) {
		this.count9 = count9;
	}

	public Integer getCount10() {
		return count10;
	}

	public void setCount10(Integer count10) {
		this.count10 = count10;
	}

	public Integer getCount11() {
		return count11;
	}

	public void setCount11(Integer count11) {
		this.count11 = count11;
	}

	public Integer getCount12() {
		return count12;
	}

	public void setCount12(Integer count12) {
		this.count12 = count12;
	}

	List<Attachment> attachmentList;
	public void setAttachmentList(List<Attachment> attachmentList) {
		this.attachmentList = attachmentList;
	}

	public List<Attachment> getAttachmentList() {
		return attachmentList;
	}
	Map<String, String> map;
	public void setMaps(Map<String, String> map) {
	}

	public Map<String, String> getMap() {
		return map;
	}

	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	private String smsDefault;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getSmsDefault() {
		return smsDefault;
	}

	public void setSmsDefault(String smsDefault) {
		this.smsDefault = smsDefault;
	}

	public String getExamFlag() {
		return examFlag;
	}

	public void setExamFlag(String examFlag) {
		this.examFlag = examFlag;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getWordFlag() {
		return wordFlag;
	}

	public void setWordFlag(String wordFlag) {
		this.wordFlag = wordFlag;
	}

	public String getFromName() {
		return fromName==null?"":fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public String getApproveFlag() {
		return approveFlag;
	}

	public void setApproveFlag(String approveFlag) {
		this.approveFlag = approveFlag;
	}
}