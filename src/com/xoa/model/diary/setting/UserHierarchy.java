package com.xoa.model.diary.setting;

//日志设置 层级关系
public class UserHierarchy {
    private Integer id;//主键id
    private String userId;//用户USER_ID
    private String userIdName;//用户USER_ID名称
    private String userTopId;//上级
    private String userTopIdName;//上级名称
    private String userBottomId;//下属
    private String userBottomIdName;//下属名称
    private Integer operationTime;//上次操作时间
    private String operationTimeStr;//上次操作时间 字符串类型
    private String userUpdateId;//最后操作人
    private String userUpdateIdName;//最后操作人名称
    private String xiajiUsers;//全部下属
    private String xiajiUsersName;//全部下属名称

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getUserTopId() {
        return userTopId;
    }

    public void setUserTopId(String userTopId) {
        this.userTopId = userTopId;
    }

    public String getUserTopIdName() {
        return userTopIdName;
    }

    public void setUserTopIdName(String userTopIdName) {
        this.userTopIdName = userTopIdName;
    }

    public String getUserBottomId() {
        return userBottomId;
    }

    public void setUserBottomId(String userBottomId) {
        this.userBottomId = userBottomId;
    }

    public String getUserBottomIdName() {
        return userBottomIdName;
    }

    public void setUserBottomIdName(String userBottomIdName) {
        this.userBottomIdName = userBottomIdName;
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

    public String getXiajiUsers() {
        return xiajiUsers;
    }

    public void setXiajiUsers(String xiajiUsers) {
        this.xiajiUsers = xiajiUsers;
    }

    public String getXiajiUsersName() {
        return xiajiUsersName;
    }

    public void setXiajiUsersName(String xiajiUsersName) {
        this.xiajiUsersName = xiajiUsersName;
    }
}
