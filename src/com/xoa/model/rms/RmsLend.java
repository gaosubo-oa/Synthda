package com.xoa.model.rms;

public class RmsLend {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.LEND_ID
     *
     * @mbggenerated
     */
    private Integer lendId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.FILE_ID
     *
     * @mbggenerated
     */
    private Integer fileId;

    private Integer rollId;
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.USER_ID
     *
     * @mbggenerated
     */
    private String userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.ADD_TIME
     *
     * @mbggenerated
     */
    private String addTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.LEND_TIME
     *
     * @mbggenerated
     */
    private String lendTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.RETURN_TIME
     *
     * @mbggenerated
     */
    private String returnTime;

    public String getFileCode() {
        return fileCode;
    }

    public void setFileCode(String fileCode) {
        this.fileCode = fileCode;
    }

    private String fileCode;
//    private String returnTimeStr;
//    private String allowTimeStr;
//    private String lendTimeStr;
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.ALLOW_TIME
     *
     * @mbggenerated
     */
    private String allowTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.ALLOW
     *
     * @mbggenerated
     */
    private String allow;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.APPROVE
     *
     * @mbggenerated
     */
    private String approve;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.DELETE_FLAG
     *
     * @mbggenerated
     */
    private String deleteFlag;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column rms_lend.OPERATOR
     *
     * @mbggenerated
     */
    private String operator;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.LEND_ID
     *
     * @return the value of rms_lend.LEND_ID
     *
     * @mbggenerated
     */
    public Integer getLendId() {
        return lendId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.LEND_ID
     *
     * @param lendId the value for rms_lend.LEND_ID
     *
     * @mbggenerated
     */
    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.FILE_ID
     *
     * @return the value of rms_lend.FILE_ID
     *
     * @mbggenerated
     */
    public Integer getFileId() {
        return fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.FILE_ID
     *
     * @param fileId the value for rms_lend.FILE_ID
     *
     * @mbggenerated
     */
    public void setFileId(Integer fileId) {
        this.fileId = fileId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.USER_ID
     *
     * @return the value of rms_lend.USER_ID
     *
     * @mbggenerated
     */
    public String getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.USER_ID
     *
     * @param userId the value for rms_lend.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.ADD_TIME
     *
     * @return the value of rms_lend.ADD_TIME
     *
     * @mbggenerated
     */
    public String getAddTime() {
        return addTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.ADD_TIME
     *
     * @param addTime the value for rms_lend.ADD_TIME
     *
     * @mbggenerated
     */
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.LEND_TIME
     *
     * @return the value of rms_lend.LEND_TIME
     *
     * @mbggenerated
     */
    public String getLendTime() {
        return lendTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.LEND_TIME
     *
     * @param lendTime the value for rms_lend.LEND_TIME
     *
     * @mbggenerated
     */
    public void setLendTime(String lendTime) {
        this.lendTime = lendTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.RETURN_TIME
     *
     * @return the value of rms_lend.RETURN_TIME
     *
     * @mbggenerated
     */
    public String getReturnTime() {
        return returnTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.RETURN_TIME
     *
     * @param returnTime the value for rms_lend.RETURN_TIME
     *
     * @mbggenerated
     */
    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.ALLOW_TIME
     *
     * @return the value of rms_lend.ALLOW_TIME
     *
     * @mbggenerated
     */
    public String getAllowTime() {
        return allowTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.ALLOW_TIME
     *
     * @param allowTime the value for rms_lend.ALLOW_TIME
     *
     * @mbggenerated
     */
    public void setAllowTime(String allowTime) {
        this.allowTime = allowTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.ALLOW
     *
     * @return the value of rms_lend.ALLOW
     *
     * @mbggenerated
     */
    public String getAllow() {
        return allow;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.ALLOW
     *
     * @param allow the value for rms_lend.ALLOW
     *
     * @mbggenerated
     */
    public void setAllow(String allow) {
        this.allow = allow == null ? null : allow.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.APPROVE
     *
     * @return the value of rms_lend.APPROVE
     *
     * @mbggenerated
     */
    public String getApprove() {
        return approve;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.APPROVE
     *
     * @param approve the value for rms_lend.APPROVE
     *
     * @mbggenerated
     */
    public void setApprove(String approve) {
        this.approve = approve == null ? null : approve.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.DELETE_FLAG
     *
     * @return the value of rms_lend.DELETE_FLAG
     *
     * @mbggenerated
     */
    public String getDeleteFlag() {
        return deleteFlag;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.DELETE_FLAG
     *
     * @param deleteFlag the value for rms_lend.DELETE_FLAG
     *
     * @mbggenerated
     */
    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag == null ? null : deleteFlag.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column rms_lend.OPERATOR
     *
     * @return the value of rms_lend.OPERATOR
     *
     * @mbggenerated
     */
    public String getOperator() {
        return operator;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column rms_lend.OPERATOR
     *
     * @param operator the value for rms_lend.OPERATOR
     *
     * @mbggenerated
     */
    public void setOperator(String operator) {
        this.operator = operator == null ? null : operator.trim();
    }


    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRollName() {
        return rollName;
    }

    public void setRollName(String rollName) {
        this.rollName = rollName;
    }

    public String getFileSubject() {
        return fileSubject;
    }

    public void setFileSubject(String fileSubject) {
        this.fileSubject = fileSubject;
    }

    public String getFileTitle() {
        return fileTitle;
    }

    public void setFileTitle(String fileTitle) {
        this.fileTitle = fileTitle;
    }

    public String getFileTitle0() {
        return fileTitle0;
    }

    public void setFileTitle0(String fileTitle0) {
        this.fileTitle0 = fileTitle0;
    }

    public String getSendUnit() {
        return sendUnit;
    }

    public void setSendUnit(String sendUnit) {
        this.sendUnit = sendUnit;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getSECRET() {
        return SECRET;
    }

    public void setSECRET(String SECRET) {
        this.SECRET = SECRET;
    }

    public String getUrgency() {
        return urgency;
    }

    public void setUrgency(String urgency) {
        this.urgency = urgency;
    }

    String roomName;
    String rollName;
    String fileSubject;
    String fileTitle;
    String fileTitle0;
    String sendUnit;
    String remark;
    String SECRET;
    String urgency;

    String name;

    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getRollId() {
        return rollId;
    }

    public void setRollId(Integer rollId) {
        this.rollId = rollId;
    }
}