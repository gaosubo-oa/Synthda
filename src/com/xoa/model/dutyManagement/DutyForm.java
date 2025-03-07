package com.xoa.model.dutyManagement;

import com.xoa.model.enclosure.Attachment;

import java.util.List;

/**
 * 值班表
 * author:殷冬
 * time:2018-05-12
 * vision:1.0.0
 */
public class DutyForm {
    /**
     * 主键id
     */
    private Integer dutyId;
    /**
     * 发布用户id
     */
    private String formId;
    /**
     * 发布部门id
     */
    private Integer formDept;
    /**
     * 开始时间
     */
    private String startTime;
    /**
     * 结束时间
     */
    private String endTime;
    /**
     * 星期
     */
    private String week;
    /**
     * 日期
     */
    private String dateTime;
    /**
     * 带班领导
     */
    private String leaderClass;
    /**
     * 值班室白班
     */
    private String dayClass;
    /**
     * 值班室夜班
     */
    private String nightClass;
    /**
     * 机要室值班
     */
    private String chanceClass;
    /**
     * 文秘室值班
     */
    private String secretary;
    /**
     * 驾驶员值班
     */
    private String driveClass;
    /**
     * 按部门发布
     */
    private String toId;
    /**
     * 按角色发布
     */
    private String privId;
    /**
     * 按人员发布
     */
    private String userId;
    /**
     * 附件id串
     */
    private String attachmentId;
    /**
     * 附件名称串
     */
    private String attachmentName;

    /**
     * 附件对象
     */
    private List<Attachment> attachment;

    /**
     * 发布部门名称串
     */
    private String toIdStr;

    /**
     * 发布角色名称串
     */
    private String privIdStr;

    /**
     * 发布人员名称串
     */
    private String userIdStr;

    /**
     *  事务提醒路径
     */
    private String url;

    /**
     *  事务提醒内容
     */
    private String content;

    /**
     * 事务提醒时间
     */
    private String sendTime;

    /**
     * 发送人姓名
     */
    private String sendName;

    List<Attachment> attachmentList;

    //一级部门权限
    private  String deptYj;

    public String getDeptYj() {
        return deptYj;
    }

    public void setDeptYj(String deptYj) {
        this.deptYj = deptYj;
    }

    public List<Attachment> getAttachmentList() {
        return attachmentList;
    }

    public void setAttachmentList(List<Attachment> attachmentList) {
        this.attachmentList = attachmentList;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getSendName() {
        return sendName;
    }

    public void setSendName(String sendName) {
        this.sendName = sendName;
    }

    public String getToIdStr() {
        return toIdStr;
    }

    public void setToIdStr(String toIdStr) {
        this.toIdStr = toIdStr;
    }

    public String getPrivIdStr() {
        return privIdStr;
    }

    public void setPrivIdStr(String privIdStr) {
        this.privIdStr = privIdStr;
    }

    public String getUserIdStr() {
        return userIdStr;
    }

    public void setUserIdStr(String userIdStr) {
        this.userIdStr = userIdStr;
    }

    public List<Attachment> getAttachment() {
        return attachment;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

    public Integer getDutyId() {
        return dutyId;
    }

    public void setDutyId(Integer dutyId) {
        this.dutyId = dutyId;
    }

    public String getFormId() {
        return formId;
    }

    public void setFormId(String formId) {
        this.formId = formId;
    }

    public Integer getFormDept() {
        return formDept;
    }

    public void setFormDept(Integer formDept) {
        this.formDept = formDept;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    public String getDateTime() {
        return dateTime;
    }

    public void setDateTime(String dateTime) {
        this.dateTime = dateTime;
    }

    public String getLeaderClass() {
        return leaderClass;
    }

    public void setLeaderClass(String leaderClass) {
        this.leaderClass = leaderClass;
    }

    public String getDayClass() {
        return dayClass;
    }

    public void setDayClass(String dayClass) {
        this.dayClass = dayClass;
    }

    public String getNightClass() {
        return nightClass;
    }

    public void setNightClass(String nightClass) {
        this.nightClass = nightClass;
    }

    public String getChanceClass() {
        return chanceClass;
    }

    public void setChanceClass(String chanceClass) {
        this.chanceClass = chanceClass;
    }

    public String getSecretary() {
        return secretary;
    }

    public void setSecretary(String secretary) {
        this.secretary = secretary;
    }

    public String getDriveClass() {
        return driveClass;
    }

    public void setDriveClass(String driveClass) {
        this.driveClass = driveClass;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId;
    }

    public String getPrivId() {
        return privId;
    }

    public void setPrivId(String privId) {
        this.privId = privId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }
}
