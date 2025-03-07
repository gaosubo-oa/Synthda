package com.xoa.model.notify;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.UsersWidgetVO;

import java.util.List;

/**
 * 
 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:36:27 类介绍 : 公告实体类 构造参数: 无
 * 
 */
public class NotifyWidgetVO {


	private Integer notifyId;
	/**
	 * 发布部门id
	 */

	/**
	 * 公告标题
	 */
	private String subject;
	/**
	 * 附件ID串
	 */
	private String attachmentId;

   //用户对象
	private UsersWidgetVO users;
	private String name;

	private String notifyDateTime;

	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 */
	private Integer read;

	private String typeName;

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
	public UsersWidgetVO getUsers() {
		return users;
	}

	/**
	 *
	 * 创建作者: 张丽军 创建日期: 2017-4-18 下午6:49:03 方法介绍: set方法 设置用户 参数说明: @param users
	 *
	 * @return void
	 */
	public void setUsers(UsersWidgetVO users) {
		this.users = users;
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

	public List<Attachment> getAttachment() {
		return attachment;
	}

	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	public NotifyWidgetVO() {
	}


	public String getNotifyDateTime() {
		return notifyDateTime;
	}

	public void setNotifyDateTime(String notifyDateTime) {
		this.notifyDateTime = notifyDateTime;
	}
}