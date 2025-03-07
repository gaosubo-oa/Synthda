package com.xoa.model.alidaas;

/**
 * @author ZhuYiZe
 * @date 2020/11/10 9:33
 * @describe
 **/
public class IDaasUser {

    private Integer uid;
    private String userId;
    private String userName;
    private String byname;
    private String password;
    private String mobilNo;
    private String email;
    private String sex;
    private String externalId;
    private String company;
    private String theme;
    private String deptId;
    private Integer userPriv;
    private String userPrivName;
    private String bpNo;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getUserId() { return userId; }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getByname() { return byname; }

    public void setByname(String byname) {
        this.byname = byname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMobilNo() {
        return mobilNo;
    }

    public void setMobilNo(String mobilNo) {
        this.mobilNo = mobilNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getDeptId() { return deptId; }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
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

    public String getBpNo() { return bpNo; }

    public void setBpNo(String bpNo) { this.bpNo = bpNo; }
}
