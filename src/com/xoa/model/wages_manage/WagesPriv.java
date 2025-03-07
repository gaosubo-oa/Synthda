package com.xoa.model.wages_manage;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/11/30
 * 说明   ：   薪资权限表
 */
public class WagesPriv {
    private Integer payPriv;//薪资权限ID
    private String userId;//主管USER_ID
    private String subordinateUserId;//下属员工USER_ID串
    private String subordinateDeptId;//下属部门DEPT_ID串
    private String userName;//主管名称
    private String subordinateUserName;//下属员工名称
    private String subordinateDeptName;//下属部门名称

    public Integer getPayPriv() {
        return payPriv;
    }

    public void setPayPriv(Integer payPriv) {
        this.payPriv = payPriv;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSubordinateUserId() {
        return subordinateUserId;
    }

    public void setSubordinateUserId(String subordinateUserId) {
        this.subordinateUserId = subordinateUserId;
    }

    public String getSubordinateDeptId() {
        return subordinateDeptId;
    }

    public void setSubordinateDeptId(String subordinateDeptId) {
        this.subordinateDeptId = subordinateDeptId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSubordinateUserName() {
        return subordinateUserName;
    }

    public void setSubordinateUserName(String subordinateUserName) {
        this.subordinateUserName = subordinateUserName;
    }

    public String getSubordinateDeptName() {
        return subordinateDeptName;
    }

    public void setSubordinateDeptName(String subordinateDeptName) {
        this.subordinateDeptName = subordinateDeptName;
    }
}
