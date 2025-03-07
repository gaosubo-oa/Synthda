package com.xoa.model.portals;

import com.xoa.model.diary.DiaryModel;

/**
 * Created by Administrator on 2018/3/1.
 */
public class PortalsUser {

    private String avatar;

    private String deptId;
    private String deptName;

    private String userName;

    private String userId;

    private Integer userPriv;

    private String userPrivName;

    private String sex;

    // 职务名称
    private String postName;

    // 岗位名称
    private String jobName;

    // 最新日志内容
    private DiaryModel diary;

    // 待办数量
    private Integer toDoCount;

    // 办结数量
    private Integer doneCount;

    //辅助角色
    private String userPrivOtherName;

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getUserPrivOtherName() {
        return userPrivOtherName;
    }

    public void setUserPrivOtherName(String userPrivOtherName) {
        this.userPrivOtherName = userPrivOtherName;
    }


    public Integer getUserPriv() {
        return userPriv;
    }

    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    public String getUserPrivName() {
        return userPrivName;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public DiaryModel getDiary() {
        return diary;
    }

    public void setDiary(DiaryModel diary) {
        this.diary = diary;
    }

    public Integer getToDoCount() {
        return toDoCount;
    }

    public void setToDoCount(Integer toDoCount) {
        this.toDoCount = toDoCount;
    }

    public Integer getDoneCount() {
        return doneCount;
    }

    public void setDoneCount(Integer doneCount) {
        this.doneCount = doneCount;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
