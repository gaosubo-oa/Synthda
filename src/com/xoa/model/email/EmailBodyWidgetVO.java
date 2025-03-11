package com.xoa.model.email;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.UsersWidgetVO;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:45:51
 * 类介绍  :    发件箱、收件箱内容信息保存
 * 构造参数:   
 *
 */
public class EmailBodyWidgetVO implements Serializable {
	private static final long serialVersionUID = 1076969159692234636L;

	/**
	 * 大概时间
	 */
	private String probablyDate;

	/**
	 * 一对多（一个用户对应多个邮件）
	 */
	private UsersWidgetVO users;
	/**
	 * 自增唯一ID
	 */
	private Integer bodyId;

	/**
	 * 邮件主题
	 */
	private String subject;

	/**
	 * 附件ID串
	 */
	private String attachmentId;

	/**
	 * 一对多关联email
	 */
	private List<EmailModel> emailList;

	/**
	 * 附件对象
	 */
	private List<Attachment> attachment;

	/**
	 * 邮件状态
	 */
	private String readFlag;

	public String getReadFlag() {
		return readFlag;
	}

	public void setReadFlag(String readFlag) {
		this.readFlag = readFlag;
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
	 * 一对多（一个用户对应多个邮件）
	 */
	public UsersWidgetVO getUsers() {
		return users;
	}

	/**
	 * 一对多（一个用户对应多个邮件）
	 */
	public void setUsers(UsersWidgetVO users) {
		this.users = users;
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

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
}