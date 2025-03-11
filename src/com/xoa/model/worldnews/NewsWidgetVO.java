package com.xoa.model.worldnews;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.UsersWidgetVO;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:25:09 类介绍 : 新闻实体类 构造参数: 无
 * 
 */
public class NewsWidgetVO implements Serializable {

	private static final long serialVersionUID = 6368734497100640940L;

	/**
	 * 主键ID
	 */
	private Integer newsId;

	/**
	 * 新闻标题
	 */
	private String subject;

	/**
	 * 附件ID串
	 */
	private String attachmentId;

	/**
	 * 发布者
	 */
	private String providerName;

	private String newsDateTime;

	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 */
	private Integer read;
	/**
	 * 用户关联
	 */
	private UsersWidgetVO users;
	/**
	 * 附件对象
	 */
	private List<Attachment> attachment;

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/**
	 * 主键ID
	 * 
	 * @return
	 */
	public Integer getNewsId() {
		return newsId;
	}

	/**
	 * 主键ID
	 * 
	 * @param newsId
	 */
	public void setNewsId(Integer newsId) {
		this.newsId = newsId;
	}

	/**
	 * 新闻标题
	 * 
	 * @return
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * 新闻标题
	 * 
	 * @param subject
	 */
	public void setSubject(String subject) {
		this.subject = subject == null ? null : subject.trim();
	}
	/**
	 * 附件ID串
	 * 
	 * @return
	 */
	public String getAttachmentId() {
		return attachmentId==null?"":attachmentId;
	}

	/**
	 * 附件ID串
	 * 
	 * @param attachmentId
	 */
	public void setAttachmentId(String attachmentId) {
		this.attachmentId = attachmentId;
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
	 * 用户关联
	 * 
	 * @return
	 */
	public UsersWidgetVO getUsers() {
		return users;
	}

	/**
	 * 用户关联
	 * 
	 * @param users
	 */
	public void setUsers(UsersWidgetVO users) {
		this.users = users;
	}

	private String typeName="";

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName  ==null?"":typeName;
	}

	public List<Attachment> getAttachment() {
		return attachment;
	}

	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	public String getProviderName() {
		return providerName;
	}

	public void setProviderName(String providerName) {
		this.providerName = providerName;
	}

	public String getNewsDateTime() {
		return newsDateTime;
	}

	public void setNewsDateTime(String newsDateTime) {
		this.newsDateTime = newsDateTime;
	}
}