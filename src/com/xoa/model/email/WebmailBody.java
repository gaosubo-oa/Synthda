package com.xoa.model.email;

import java.io.Serializable;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/12 14:02
 * 方法介绍:   外部邮箱实体类信息
 * 参数说明:
 * @return
 */
public class WebmailBody implements Serializable{
    private static final long serialVersionUID = 6115632115735203188L;

    /**
     * 自增唯一ID
     */
    private Integer bodyId;

    /**
     * 发送邮箱
     */
    private String fromMail;

    /**
     * 回复邮箱
     */
    private String replyMail;

    /**
     * 邮件主题
     */
    private String subject;

    /**
     * 是否有html格式(1-有,0-无) 默认为 1
     */
    private String isHtml;

    /**
     * 1-大邮件不接受附件,0-小邮件可接受附件
     */
    private String largeAttachment;

    /**
     * 附件ID串
     */
    private String attachmentId;

    /**
     * 附件名称串
     */
    private String attachmentName;

    /**
     * 外部邮件的标识符
     */
    private String webmailUid;

    /**
     * 接收邮箱
     */
    private String toMail;

    /**
     * 抄送邮箱
     */
    private String ccMail;

    /**
     * 压缩的邮件html格式正文
     */
    private byte[] contentHtml;

    /**
     * 自增唯一ID
     * @return
     */
    public Integer getBodyId() {
        return bodyId;
    }

    /**
     * 自增唯一ID
     * @param bodyId
     */
    public void setBodyId(Integer bodyId) {
        this.bodyId = bodyId;
    }

    /**
     * 发送邮箱
     * @return
     */
    public String getFromMail() {
        return fromMail;
    }

    /**
     * 发送邮箱
     * @param fromMail
     */
    public void setFromMail(String fromMail) {
        this.fromMail = fromMail;
    }

    /**
     * 回复邮箱
     * @return
     */
    public String getReplyMail() {
        return replyMail;
    }

    /**
     * 回复邮箱
     * @param replyMail
     */
    public void setReplyMail(String replyMail) {
        this.replyMail = replyMail;
    }

    /**
     * 邮件主题
     * @return
     */
    public String getSubject() {
        return subject;
    }

    /**
     * 邮件主题
     * @param subject
     */
    public void setSubject(String subject) {
        this.subject = subject;
    }

    /**
     * 是否有html格式(1-有,0-无) 默认为 1
     * @return
     */
    public String getIsHtml() {
        return isHtml;
    }

    /**
     * 是否有html格式(1-有,0-无) 默认为 1
     * @param isHtml
     */
    public void setIsHtml(String isHtml) {
        this.isHtml = isHtml;
    }

    /**
     * 1-大邮件不接受附件,0-小邮件可接受附件
     * @return
     */
    public String getLargeAttachment() {
        return largeAttachment;
    }

    /**
     * 1-大邮件不接受附件,0-小邮件可接受附件
     * @param largeAttachment
     */
    public void setLargeAttachment(String largeAttachment) {
        this.largeAttachment = largeAttachment;
    }

    /**
     * 附件ID串
     * @return
     */
    public String getAttachmentId() {
        return attachmentId;
    }

    /**
     * 附件ID串
     * @param attachmentId
     */
    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    /**
     * 附件名称串
     * @return
     */
    public String getAttachmentName() {
        return attachmentName;
    }

    /**
     * 附件名称串
     * @param attachmentName
     */
    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    /**
     * 外部邮件的标识符
     * @return
     */
    public String getWebmailUid() {
        return webmailUid;
    }

    /**
     * 外部邮件的标识符
     * @param webmailUid
     */
    public void setWebmailUid(String webmailUid) {
        this.webmailUid = webmailUid;
    }

    /**
     * 接收邮箱
     * @return
     */
    public String getToMail() {
        return toMail;
    }

    /**
     * 接收邮箱
     * @param toMail
     */
    public void setToMail(String toMail) {
        this.toMail = toMail;
    }

    /**
     * 抄送邮箱
     * @return
     */
    public String getCcMail() {
        return ccMail;
    }

    /**
     * 抄送邮箱
     * @param ccMail
     */
    public void setCcMail(String ccMail) {
        this.ccMail = ccMail;
    }

    /**
     * 压缩的邮件html格式正文
     * @return
     */
    public byte[] getContentHtml() {
        return contentHtml;
    }

    /**
     * 压缩的邮件html格式正文
     * @param contentHtml
     */
    public void setContentHtml(byte[] contentHtml) {
        this.contentHtml = contentHtml;
    }
}