package com.xoa.dev.crossEmail.model;

import java.io.Serializable;

public class EmailPlus implements Serializable {
    private static final long serialVersionUID = 1076969159692234636L;

    /**
     * 自增唯一ID
     */
    private Integer emailId;

    /**
     * 收件人USER_ID
     */
    private String toId;

    /**
     * 收件人姓名
     */
    private String toName;

    /**
     * 邮件读取状态(0-未读,1-已读)
     */
    private String readFlag;

    /**
     * 邮件删除状态
     */
    private String deleteFlag;

    /**
     * 邮件箱分类ID
     */
    private Integer boxId;

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    /**
     * 邮件体ID

     */
    private Integer bodyId;

    /**
     * 是否请求阅读收条(0-不请求,1-请求)
     */
    private String receipt;

    /**
     * 是否转发(0-未转发,1-已转发)
     */
    private String isF;

    /**
     * 是否回复(0-未回复,1-已回复)
     */
    private String isR;

    /**
     * 星标标记(0-无,1-灰,2-绿,3-黄,4-红)
     */
    private String sign;

    /**
     * 一对多关联 EmailBody
     */
    private EmailBodyplusWithBLOBs emailBody;

    private String userName;

    private String deptName;

    // 撤回状态
    private String withdrawFlag;

    public String getWithdrawFlag() {
        return withdrawFlag==null?"0":withdrawFlag;
    }

    public void setWithdrawFlag(String withdrawFlag) {
        this.withdrawFlag = withdrawFlag;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * 一对多关联 EmailBody
     * @return
     */
    public EmailBodyplusWithBLOBs getEmailBody() {
        return emailBody;
    }

    /**
     * 一对多关联 EmailBody
     * @param emailBody
     */
    public void setEmailBody(EmailBodyplusWithBLOBs emailBody) {
        this.emailBody = emailBody;
    }

    /**
     * 自增唯一ID
     * @return
     */
    public Integer getEmailId() {
        return emailId;
    }

    /**
     * 自增唯一ID
     * @param emailId
     */
    public void setEmailId(Integer emailId) {
        this.emailId = emailId;
    }

    /**
     * 收件人USER_ID
     * @return
     */
    public String getToId() {
        return toId;
    }

    /**
     * 收件人USER_ID
     * @param toId
     */
    public void setToId(String toId) {
        this.toId = toId == null ? null : toId.trim();
    }

    /**
     * 邮件读取状态(0-未读,1-已读)
     * @return
     */
    public String getReadFlag() {
        return readFlag == null ? "0":readFlag;
    }

    /**
     * 邮件读取状态(0-未读,1-已读)
     * @param readFlag
     */
    public void setReadFlag(String readFlag) {
        this.readFlag = readFlag;
    }

    /**
     * 邮件删除状态
     * @return
     */
    public String getDeleteFlag() {
        return deleteFlag == null ? "0" : deleteFlag;
    }

    /**
     * 邮件删除状态
     * @param deleteFlag
     */
    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag == null ? null : deleteFlag.trim();
    }

    /**
     * 邮件箱分类ID
     * @return
     */
    public Integer getBoxId() {
        return boxId;
    }

    /**
     * 邮件箱分类ID
     * @param boxId
     */
    public void setBoxId(Integer boxId) {
        this.boxId = boxId;
    }

    /**
     * 邮件体ID
     * @return
     */
    public Integer getBodyId() {
        return bodyId;
    }

    /**
     * 邮件体ID
     * @param bodyId
     */
    public void setBodyId(Integer bodyId) {
        this.bodyId = bodyId;
    }

    /**
     * 是否请求阅读收条(0-不请求,1-请求)
     * @return
     */
    public String getReceipt() {
        return receipt == null ? "0" : receipt;
    }

    /**
     * 是否请求阅读收条(0-不请求,1-请求)
     * @param receipt
     */
    public void setReceipt(String receipt) {
        this.receipt = receipt == null ? null : receipt.trim();
    }

    /**
     * 是否转发(0-未转发,1-已转发)
     * @return
     */
    public String getIsF() {
        return isF == null ? "":isF;
    }

    /**
     * 是否转发(0-未转发,1-已转发)
     * @param isF
     */
    public void setIsF(String isF) {
        this.isF = isF == null ? null : isF.trim();
    }

    /**
     * 是否回复(0-未回复,1-已回复)
     * @return
     */
    public String getIsR() {
        return isR == null ? "" : isR;
    }

    /**
     * 是否回复(0-未回复,1-已回复)
     * @param isR
     */
    public void setIsR(String isR) {
        this.isR = isR == null ? null : isR.trim();
    }

    /**
     * 星标标记(0-无,1-灰,2-绿,3-黄,4-红)
     * @return
     */
    public String getSign() {
        return sign == null ? "0" : sign;
    }

    /**
     * 星标标记(0-无,1-灰,2-绿,3-黄,4-红)
     * @param sign
     */
    public void setSign(String sign) {
        this.sign = sign == null ? null : sign.trim();
    }

    /**
     *
     * 创建作者:   张勇
     * 创建日期:   2017-4-26 下午7:19:25
     * 方法介绍:   收件人姓名
     * 参数说明:   @return
     * @return     String
     */
    public String getToName() {
        return toName;
    }

    /**
     *
     * 创建作者:   张勇
     * 创建日期:   2017-4-26 下午7:19:35
     * 方法介绍:   收件人姓名
     * 参数说明:   @param toName
     * @return     void
     */
    public void setToName(String toName) {
        this.toName = toName;
    }



    private String UID;

    public String getUID() {
        return UID;
    }

    public void setUID(String UID) {
        this.UID = UID;
    }

    private String readTime;

    public String getReadTime() {
        return readTime;
    }

    public void setReadTime(String readTime) {
        this.readTime = readTime;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }
}