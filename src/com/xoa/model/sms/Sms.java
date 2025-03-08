package com.xoa.model.sms;

public class Sms {
    // 主键
    private Integer smsId;
    //收信人id
    private String toId;
    //接收标记(0-已阅读,1-未阅读,2-未阅读已弹出)
    private String remindFlag;
    //删除标记(0-没删除,1-收信人删除,2-发信人删除)
    private String deleteFlag;
    // 对应smsbody中的id
    private Integer bodyId;
    // 最近一次提醒时间
    private Integer remindTime;
    private String remindUrl;

    public String getRemindUrl() {
        return remindUrl;
    }

    public void setRemindUrl(String remindUrl) {
        this.remindUrl = remindUrl;
    }
    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Sms() {
    }

    public Integer getSmsId() {
        return smsId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.SMS_ID
     *
     * @param smsId the value for sms.SMS_ID
     * @mbggenerated
     */
    public void setSmsId(Integer smsId) {
        this.smsId = smsId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms.TO_ID
     *
     * @return the value of sms.TO_ID
     * @mbggenerated
     */
    public String getToId() {
        return toId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.TO_ID
     *
     * @param toId the value for sms.TO_ID
     * @mbggenerated
     */
    public void setToId(String toId) {
        this.toId = toId == null ? null : toId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms.REMIND_FLAG
     *
     * @return the value of sms.REMIND_FLAG
     * @mbggenerated
     */
    public String getRemindFlag() {
        return remindFlag;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.REMIND_FLAG
     *
     * @param remindFlag the value for sms.REMIND_FLAG
     * @mbggenerated
     */
    public void setRemindFlag(String remindFlag) {
        this.remindFlag = remindFlag == null ? null : remindFlag.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms.DELETE_FLAG
     *
     * @return the value of sms.DELETE_FLAG
     * @mbggenerated
     */
    public String getDeleteFlag() {
        return deleteFlag;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.DELETE_FLAG
     *
     * @param deleteFlag the value for sms.DELETE_FLAG
     * @mbggenerated
     */
    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag == null ? null : deleteFlag.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms.BODY_ID
     *
     * @return the value of sms.BODY_ID
     * @mbggenerated
     */
    public Integer getBodyId() {
        return bodyId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.BODY_ID
     *
     * @param bodyId the value for sms.BODY_ID
     * @mbggenerated
     */
    public void setBodyId(Integer bodyId) {
        this.bodyId = bodyId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column sms.REMIND_TIME
     *
     * @return the value of sms.REMIND_TIME
     * @mbggenerated
     */
    public Integer getRemindTime() {
        return remindTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column sms.REMIND_TIME
     *
     * @param remindTime the value for sms.REMIND_TIME
     * @mbggenerated
     */
    public void setRemindTime(Integer remindTime) {
        this.remindTime = remindTime;
    }
}