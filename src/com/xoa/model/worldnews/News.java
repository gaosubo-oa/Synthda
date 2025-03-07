package com.xoa.model.worldnews;

import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.role.Role;
import com.xoa.model.users.Users;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * 
 * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:25:09 类介绍 : 新闻实体类 构造参数: 无
 * 
 */
public class News implements Serializable {

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
	 * 发布者
	 */
	private String provider;

	/**
	 * 发布时间
	 */
	private Date newsTime;

	/**
	 * 点击数
	 */
	private Integer clickCount;

	/**
	 * 评论类型(0-实名评论,1-匿名评论,2-禁止评论)
	 */
	private String anonymityYn;


	/**
	 * 新闻格式(0-普通格式,1-MHT格式,2-超链接)
	 */
	private String format;

	/**
	 * 新闻类型
	 */
	private String typeId;

	/**
	 * 发布标识(0-未发布,1-已发布,2-已终止)
	 */
	private String publish;

	/**
	 * 是否置顶(0-否,1-是)
	 */
	private String top;

	/**
	 * 最后编辑人
	 */
	private String lastEditor;

	/**
	 * 最后编辑时间
	 */
	private Date lastEditTime;

	/**
	 * 新闻标题颜色
	 */
	private String subjectColor;

	/**
	 * 内容关键词
	 */
	private String keyword;

	/**
	 * 限制新闻置顶时间
	 */
	private String topDays;

	/**
	 * 新闻内容
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
	 * 发布部门
	 */
	private String toId;

	/**
	 * 发布角色
	 */
	private String privId;

	/**
	 * 发布人员
	 */
	private String userId;

	/**
	 * 阅读人员ID串
	 */
	private String readers;

	/**
	 * 压缩后的新闻内容
	 */
	private byte[] compressContent;

	/**
	 * 新闻内容简介
	 */
	private String summary;
	/**
	 * 未读，已读的判断(0是未读,1是已读)
	 */
	private Integer read;
	/**
	 * 用户关联
	 */
	private Users users;
	/**
	 * 部门关联
	 */
	private Department dep;
	/**
	 * 角色关联
	 */
	private Role role;

	private SysCode codes;

	private String newsDateTime;

	private String userrange;

	private String rolerange;

	private String deprange;
	
	/**
	 * 附件对象
	 */
	private List<Attachment> attachment;

	private	String photoCount;

	private	String wordsCount;

	public String getPhotoCount() {
		return photoCount;
	}

	public void setPhotoCount(String photoCount) {
		this.photoCount = photoCount;
	}

	public String getWordsCount() {
		return wordsCount;
	}

	public void setWordsCount(String wordsCount) {
		this.wordsCount = wordsCount;
	}

	/**
	 * 发布者
	 */
	private String providerName;

	private  List<Department> departmentList;

	private  Integer  readSize;

	private  Integer  unreadSize;

   //新闻评论数
	private  Integer newsCount;

	private String auditer;//审批人

	private String auditerName;

	private Date auditerTime;//审批时间

	private String auditerStatus;//审批状态(0-待审批,1-批准，2-不批准)

	private Integer runId ;//流程关联的run_id

	private String author;//作者

	private String photographer;//摄影

	private String titlePicId;//封面图片id

	private String titlePicName;//封面图片名称

	private Attachment titlePicAttachment;//封面图片附件对象

	private String contentStr;

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPhotographer() {
		return photographer;
	}

	public void setPhotographer(String photographer) {
		this.photographer = photographer;
	}

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	public List<Department> getDepartmentList() {
		return departmentList;
	}

	public void setDepartmentList(List<Department> departmentList) {
		this.departmentList = departmentList;
	}

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
	 * 发布人
	 * 
	 * @return
	 */
	public String getProvider() {
		return provider;
	}

	/**
	 * 发布人
	 * 
	 * @param provider
	 */
	public void setProvider(String provider) {
		this.provider = provider == null ? null : provider.trim();
	}

	/**
	 * 发布时间
	 * 
	 * @return
	 */
	public Date getNewsTime() {
		return newsTime;
	}

	/**
	 * 发布时间
	 * 
	 * @param newsTime
	 */
	public void setNewsTime(Date newsTime) {
		this.newsTime = newsTime;
	}

	/**
	 * 点击数
	 * 
	 * @return
	 */
	public Integer getClickCount() {
		return clickCount==null?0:clickCount;
	}

	/**
	 * 点击数
	 * 
	 * @param clickCount
	 */
	public void setClickCount(Integer clickCount) {
		this.clickCount = clickCount;
	}

	/**
	 * 评论类型(0-实名评论,1-匿名评论,2-禁止评论)
	 * 
	 * @return
	 */
	public String getAnonymityYn() {
		return anonymityYn;
	}

	/**
	 * 评论类型(0-实名评论,1-匿名评论,2-禁止评论)
	 * 
	 * @param anonymityYn
	 */
	public void setAnonymityYn(String anonymityYn) {
		this.anonymityYn = anonymityYn == null ? null : anonymityYn.trim();
	}

	/**
	 * 新闻格式(0-普通格式,1-MHT格式,2-超链接)
	 * 
	 * @return
	 */
	public String getFormat() {
		return format;
	}

	/**
	 * 新闻格式(0-普通格式,1-MHT格式,2-超链接)
	 * 
	 * @param format
	 */
	public void setFormat(String format) {
		this.format = format == null ? null : format.trim();
	}

	/**
	 * 新闻类型
	 * 
	 * @return
	 */
	public String getTypeId() {
		return typeId==null?"":typeId;
	}

	/**
	 * 新闻类型
	 * 
	 * @param typeId
	 */
	public void setTypeId(String typeId) {
		this.typeId = typeId == null ? null : typeId.trim();
	}

	/**
	 * 发布标识(0-未发布,1-已发布,2-已终止)
	 * 
	 * @return
	 */
	public String getPublish() {
		return publish;
	}

	/**
	 * 发布标识(0-未发布,1-已发布,2-已终止)
	 * 
	 * @param publish
	 */
	public void setPublish(String publish) {
		this.publish = publish == null ? null : publish.trim();
	}

	/**
	 * 是否置顶(0-否,1-是)
	 * 
	 * @return
	 */
	public String getTop() {
		return top;
	}

	/**
	 * 是否置顶(0-否,1-是)
	 * 
	 * @param top
	 */
	public void setTop(String top) {
		this.top = top == null ? null : top.trim();
	}

	/**
	 * 最后编辑人
	 * 
	 * @return
	 */
	public String getLastEditor() {
		return lastEditor==null?"":lastEditor;
	}

	/**
	 * 最后编辑人
	 * 
	 * @param lastEditor
	 */
	public void setLastEditor(String lastEditor) {
		this.lastEditor = lastEditor == null ? null : lastEditor.trim();
	}

	/**
	 * 最后编辑时间
	 * 
	 * @return
	 */
	public Date getLastEditTime() {
		return lastEditTime;
	}

	/**
	 * 最后编辑时间
	 * 
	 * @param lastEditTime
	 */
	public void setLastEditTime(Date lastEditTime) {
		this.lastEditTime = lastEditTime;
	}

	/**
	 * 新闻标题颜色
	 * 
	 * @return
	 */
	public String getSubjectColor() {
		return subjectColor==null?"":subjectColor;
	}

	/**
	 * 新闻标题颜色
	 * 
	 * @param subjectColor
	 */
	public void setSubjectColor(String subjectColor) {
		this.subjectColor = subjectColor == null ? null : subjectColor.trim();
	}

	/**
	 * 内容关键词
	 * 
	 * @return
	 */
	public String getKeyword() {
		return keyword==null?"":keyword;
	}

	/**
	 * 内容关键词
	 * 
	 * @param keyword
	 */
	public void setKeyword(String keyword) {
		this.keyword = keyword == null ? null : keyword.trim();
	}

	/**
	 * 限制新闻置顶时间
	 * 
	 * @return
	 */
	public String getTopDays() {
		return topDays==null?"":topDays;
		}

	/**
	 * 限制新闻置顶时间
	 * 
	 * @param topDays
	 */
	public void setTopDays(String topDays) {
		this.topDays = topDays == null ? null : topDays.trim();
	}

	/**
	 * 新闻内容
	 * 
	 * @return
	 */
	public String getContent() {
		return content==null?"":content;
	}

	/**
	 * 新闻内容
	 * 
	 * @param content
	 */
	public void setContent(String content) {
		this.content = content;
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
	 * 附件名称串
	 * 
	 * @return
	 */
	public String getAttachmentName() {
		return attachmentName==null?"":attachmentName;
	}

	/**
	 * 附件名称串
	 * 
	 * @param attachmentName
	 */
	public void setAttachmentName(String attachmentName) {
		this.attachmentName = attachmentName;
	}

	/**
	 * 发布部门
	 * 
	 * @return
	 */
	public String getToId() {
		return toId==null?"":toId;
	}

	/**
	 * 发布部门
	 * 
	 * @param toId
	 */
	public void setToId(String toId) {
		this.toId = toId;
	}

	/**
	 * 发布角色
	 * 
	 * @return
	 */
	public String getPrivId() {
		return privId==null?"":privId;
	
	}

	/**
	 * 发布角色
	 * 
	 * @param privId
	 */
	public void setPrivId(String privId) {
		this.privId = privId;
	}

	/**
	 * 发布人员
	 * 
	 * @return
	 */
	public String getUserId() {
		return userId==null?"":userId;
	}

	/**
	 * 发布人员
	 * 
	 * @param userId
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 阅读人员ID串
	 * 
	 * @return
	 */
	public String getReaders() {
		return readers==null?"":readers;
	}

	/**
	 * 阅读人员ID串
	 * 
	 * @param readers
	 */
	public void setReaders(String readers) {
		this.readers = readers;
	}

	/**
	 * 压缩后的新闻内容
	 * 
	 * @return
	 */
	public byte[] getCompressContent() {
		return compressContent;
	}

	/**
	 * 压缩后的新闻内容
	 * 
	 * @param compressContent
	 */
	public void setCompressContent(byte[] compressContent) {
		this.compressContent = compressContent;
	}

	/**
	 * 新闻内容简介
	 * 
	 * @return
	 */
	public String getSummary() {
		return summary==null?"":summary;
	}

	/**
	 * 新闻内容简介
	 * 
	 * @param summary
	 */
	public void setSummary(String summary) {
		this.summary = summary;
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
	public Users getUsers() {
		return users;
	}

	/**
	 * 用户关联
	 * 
	 * @param users
	 */
	public void setUsers(Users users) {
		this.users = users;
	}

	/**
	 * 部门关联
	 * 
	 * @return
	 */
	public Department getDep() {
		return dep;
	}

	/**
	 * 部门关联
	 * 
	 * @param dep
	 */
	public void setDep(Department dep) {
		this.dep = dep;
	}

	/**
	 * 角色关联
	 * 
	 * @return
	 */
	public Role getRole() {
		return role;
	}

	/**
	 * 角色关联
	 * 
	 * @param role
	 */
	public void setRole(Role role) {
		this.role = role;
	}

	public String getNewsDateTime() {
		return newsDateTime;
	}

	public void setNewsDateTime(String newsDateTime) {
		this.newsDateTime = newsDateTime;
	}

	public SysCode getCodes() {
		return codes;
	}

	public void setCodes(SysCode codes) {
		this.codes = codes;
	}

	private String typeName="";

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName  ==null?"":typeName;
	}

	public String getProviderName() {
		return providerName;
	}

	public void setProviderName(String providerName) {
		this.providerName = providerName ==null?"":providerName;
	}

	private String depName;

	public String getDepName() {
		return depName;
	}

	public void setDepName(String depName) {
		this.depName = depName ==null?"":depName;
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

	public String getDeprange() {
		return deprange==null?"":deprange;
	}

	public void setDeprange(String deprange) {
		this.deprange = deprange == null ? "" : deprange;
	}

	public List<Attachment> getAttachment() {
		return attachment;
	}

	public void setAttachment(List<Attachment> attachment) {
		this.attachment = attachment;
	}

	public Integer getNewsCount() {
		return newsCount;
	}

	public void setNewsCount(Integer newsCount) {
		this.newsCount = newsCount  == null ? 0 : newsCount;
	}

	public String getAuditer() {
		return auditer;
	}

	public void setAuditer(String auditer) {
		this.auditer = auditer == null ? "" : auditer.trim();
	}

	public Date getAuditerTime() {
		return auditerTime;
	}



	public void setAuditerTime(Date auditerTime){
		this.auditerTime = auditerTime;
	}

	public String getAuditerStatus() {
		return auditerStatus;
	}

	public void setAuditerStatus(String auditerStatus) {
		this.auditerStatus = auditerStatus == null ? "" : auditerStatus.trim();
	}

	public String getAuditerName() {
		return auditerName;
	}

	public void setAuditerName(String auditerName) {
		this.auditerName = auditerName == null ? "" : auditerName.trim();
	}

	public Integer getRunId() {
		return runId;
	}

	public void setRunId(Integer runId) {
		this.runId = runId;
	}

	public String getTitlePicId() {
		return titlePicId;
	}

	public void setTitlePicId(String titlePicId) {
		this.titlePicId = titlePicId;
	}

	public String getTitlePicName() {
		return titlePicName;
	}

	public void setTitlePicName(String titlePicName) {
		this.titlePicName = titlePicName;
	}

	public Attachment getTitlePicAttachment() {
		return titlePicAttachment;
	}

	public void setTitlePicAttachment(Attachment titlePicAttachment) {
		this.titlePicAttachment = titlePicAttachment;
	}

	public String getContentStr() {
		return contentStr;
	}

	public void setContentStr(String contentStr) {
		this.contentStr = contentStr;
	}
}