package com.xoa.model.diary;

import com.xoa.model.enclosure.Attachment;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

/**
 * 
 * 创建作者:   杨 胜
 * 创建日期:   2017-4-19 上午10:58:29
 * 类介绍  :    工作日志表实体类 
 * 构造参数:   
 *
 */
public class DiaryWidgetVO {

    /**
     * 唯一自增ID
     */
    private Integer diaId;
    /**
     * 用户ID
     */
    private String userId;
    /**
     * 用户name
     */
    private String userName;

    private Integer  uid;

    private String avatar;//自定义小头像

    /**
     * 附件ID串
     */
    private String attachmentId;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName==null?"":userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    String sex;
    /**
	 * @return the sex
	 */
	public String getSex() {
		return sex;
	}

	/**
	 * @param sex the sex to set
	 */
	public void setSex(String sex) {
		this.sex = sex;
	}

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:41:44
     * 方法介绍:   附件ID串
     * 参数说明:   @return
     *
     * @return String
     */
    public String getAttachmentId() {
        return attachmentId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:42:06
     * 方法介绍:   附件ID串
     * 参数说明:   @param attachmentId
     *
     * @return void
     */
    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId == null ? null : attachmentId.trim();
    }

    /**
     * 最近一次的编辑时间
     */
    private String diaTime;
    /**
     * 日志类型(1-工作日志,2-个人日志)
     */
    private String diaType;//diaType(日志类型(1-工作日志,2-个人日志))、 subject（日志标题）、content（日志内容）、toAll（是否全部共享(0-否,1-是)）、toId（共享用户ID串）、attachmentId（附件ID串）、attachmentName（附件名称串）
    /**
     * 日志标题
     */
    private String subject;

    //***************************************附件生成json转换***************************************
    private List<Attachment> attachment;

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:23
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @return
     *
     * @return String
     */
    public String getDiaTime() {
        return diaTime==null?"":diaTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:40:36
     * 方法介绍:   最近一次的编辑时间
     * 参数说明:   @param diaTime
     *
     * @return void
     */
    public void setDiaTime(String diaTime) {
        this.diaTime = diaTime;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:11
     * 方法介绍:   唯一自增ID
     * 参数说明:   @return
     *
     * @return Integer
     */
    public Integer getDiaId() {
        return diaId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:24
     * 方法介绍:   唯一自增ID
     * 参数说明:   @param diaId
     *
     * @return void
     */
    public void setDiaId(Integer diaId) {
        this.diaId = diaId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:38
     * 方法介绍:   用户ID
     * 参数说明:   @return
     *
     * @return String
     */
    public String getUserId() {
        return userId;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:48:50
     * 方法介绍:   用户ID
     * 参数说明:   @param userId
     *
     * @return void
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:49:04
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @return
     *
     * @return String
     */
    public String getDiaType() {
        return diaType;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:49:15
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @param diaType
     *
     * @return void
     */
    public void setDiaType(String diaType) {
        this.diaType = diaType == null ? null : diaType.trim();
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:56:05
     * 方法介绍:   日志类型(1-工作日志,2-个人日志)
     * 参数说明:   @return
     *
     * @return String
     */
    public String getSubject() {
        return subject;
    }

    /**
     * 创建作者:   杨 胜
     * 创建日期:   2017-4-19 上午10:56:41
     * 方法介绍:   日志标题
     * 参数说明:   @param subject
     *
     * @return void
     */
    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }


    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}

