package com.xoa.model.users;

public class UsersIm {

    /**
     * 唯一自增ID
     */
    private Integer uid;

    /**
     * 用户UserId
     */
    private String userId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 自定义小头像
     */
    private String avatar;

    /**
     * 个性签名
     */
    private String myStatus;

    /**
     * 用户名片图片
     */
    private String photo;

    /**
     * 用户部门Id
     */
    private Integer deptId;

    /**
     * 用户部门名称
     */
    private String deptName;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getMyStatus() {
        return myStatus;
    }

    public void setMyStatus(String myStatus) {
        this.myStatus = myStatus;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
