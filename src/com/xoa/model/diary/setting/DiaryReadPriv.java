package com.xoa.model.diary.setting;

//工作日志查看权限
public class DiaryReadPriv {
    private Integer rprivId;//主键id
    private String userId;//用户USER_ID
    private String userIdName;//用户USER_ID名称
    private String readRange;//查看范围
    private String readRangeName;//查看范围用户名称

    public Integer getRprivId() {
        return rprivId;
    }

    public void setRprivId(Integer rprivId) {
        this.rprivId = rprivId;
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

    public String getReadRange() {
        return readRange;
    }

    public void setReadRange(String readRange) {
        this.readRange = readRange;
    }

    public String getReadRangeName() {
        return readRangeName;
    }

    public void setReadRangeName(String readRangeName) {
        this.readRangeName = readRangeName;
    }
}
