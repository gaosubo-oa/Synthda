package com.xoa.model.diary.setting;

//日志设置 移动端模板设置
public class DiaryTemplate {
    private Integer templateId;//主键id
    private String templateName;//模板名称
    private String diaType;//日志类型(0-工作日报，1-工作日志，2-个人日志，3-工作周报，4-工作月报)
    private String diaTypeName;//日志类型名称
    private String userId;//按人员设置
    private String userIdName;//按人员设置名称
    private String privId;//按角色设置
    private String privIdName;//按角色设置名称
    private String deptId;//按部门设置
    private String deptIdName;//按部门设置名称
    private byte[] content;//模板内容
    private String contentStr;//模板内容 字符串
    private Integer operationTime;//上次操作时间
    private String operationTimeStr;//上次操作时间 字符串
    private String userUpdateId;//上次操作人
    private String userUpdateIdName;//上次操作人

    public Integer getTemplateId() {
        return templateId;
    }

    public void setTemplateId(Integer templateId) {
        this.templateId = templateId;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getDiaType() {
        return diaType;
    }

    public void setDiaType(String diaType) {
        this.diaType = diaType;
    }

    public String getDiaTypeName() {
        return diaTypeName;
    }

    public void setDiaTypeName(String diaTypeName) {
        this.diaTypeName = diaTypeName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserIdName() {
        return userIdName;
    }

    public void setUserIdName(String userIdName) {
        this.userIdName = userIdName;
    }

    public String getPrivId() {
        return privId;
    }

    public void setPrivId(String privId) {
        this.privId = privId;
    }

    public String getPrivIdName() {
        return privIdName;
    }

    public void setPrivIdName(String privIdName) {
        this.privIdName = privIdName;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getDeptIdName() {
        return deptIdName;
    }

    public void setDeptIdName(String deptIdName) {
        this.deptIdName = deptIdName;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }

    public String getContentStr() {
        return contentStr;
    }

    public void setContentStr(String contentStr) {
        this.contentStr = contentStr;
    }

    public Integer getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(Integer operationTime) {
        this.operationTime = operationTime;
    }

    public String getOperationTimeStr() {
        return operationTimeStr;
    }

    public void setOperationTimeStr(String operationTimeStr) {
        this.operationTimeStr = operationTimeStr;
    }

    public String getUserUpdateId() {
        return userUpdateId;
    }

    public void setUserUpdateId(String userUpdateId) {
        this.userUpdateId = userUpdateId;
    }

    public String getUserUpdateIdName() {
        return userUpdateIdName;
    }

    public void setUserUpdateIdName(String userUpdateIdName) {
        this.userUpdateIdName = userUpdateIdName;
    }
}
