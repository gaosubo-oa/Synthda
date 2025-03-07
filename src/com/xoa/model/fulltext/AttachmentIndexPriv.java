package com.xoa.model.fulltext;

public class AttachmentIndexPriv {
    private Integer moduleId; //模块id
    private String moduleName; //模块名称
    private String privIds; //角色 id串
    private String deptIds;//部门 id串
    private String userIds;//用户 id串
    private String privNames;//角色 名称串
    private String deptNames;//部门 名称串
    private String userNames;//用户 名称串

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getPrivIds() {
        return privIds;
    }

    public void setPrivIds(String privIds) {
        this.privIds = privIds;
    }

    public String getDeptIds() {
        return deptIds;
    }

    public void setDeptIds(String deptIds) {
        this.deptIds = deptIds;
    }

    public String getUserIds() {
        return userIds;
    }

    public void setUserIds(String userIds) {
        this.userIds = userIds;
    }

    public String getPrivNames() {
        return privNames;
    }

    public void setPrivNames(String privNames) {
        this.privNames = privNames;
    }

    public String getDeptNames() {
        return deptNames;
    }

    public void setDeptNames(String deptNames) {
        this.deptNames = deptNames;
    }

    public String getUserNames() {
        return userNames;
    }

    public void setUserNames(String userNames) {
        this.userNames = userNames;
    }
}
