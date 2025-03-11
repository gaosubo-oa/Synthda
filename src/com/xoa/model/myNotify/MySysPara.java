package com.xoa.model.myNotify;


import com.xoa.model.users.Users;

import java.io.Serializable;
import java.util.List;



//
//*
// * 创建作者:   王曰岐
// * 创建日期:   2017-4-18 下午5:36:22
// * 类介绍   :    APP端
// * 构造参数:   无




public class MySysPara implements Serializable{

    private String paraName;

//*
//     * 参数
    private String paraValue;
   //用户姓名
    private String userName;
    //用户信息集合
    private List<Users> usersList;
    private List<Users> eduUserList;
    private String userId;

    private String typeApproval;//公告类型
    private String topDates;//置顶天数
    private String approvalUsers;//指定可审批公告人员
    private String notApprovalUsers;//不经审批发公告人员

    public String getTypeApproval() {
        return typeApproval;
    }

    public void setTypeApproval(String typeApproval) {
        this.typeApproval = typeApproval;
    }

    public String getTopDates() {
        return topDates;
    }

    public void setTopDates(String topDates) {
        this.topDates = topDates;
    }

    public String getApprovalUsers() {
        return approvalUsers;
    }

    public void setApprovalUsers(String approvalUsers) {
        this.approvalUsers = approvalUsers;
    }

    public String getNotApprovalUsers() {
        return notApprovalUsers;
    }

    public void setNotApprovalUsers(String notApprovalUsers) {
        this.notApprovalUsers = notApprovalUsers;
    }

    //*
//     * 创建作者:   王曰岐
//     * 创建日期:   2017-4-18 下午5:36:36
//     * 方法介绍:   参数名称
//     * 参数说明:   @return
//     *
//     * @return String  paraName(参数名称)




    public String getParaName() {
        return paraName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }





//*
//     * 创建作者:   王曰岐
//     * 创建日期:   2017-4-18 下午5:43:52
//     * 方法介绍:    参数名称
//     * 参数说明:   @param paraName
//     *
//     * @return void






    public void setParaName(String paraName) {
        this.paraName = paraName == null ? null : paraName.trim();
    }

    public List<Users> getUsersList() {
        return usersList;
    }

    public void setUsersList(List<Users> usersList) {
        this.usersList = usersList;
    }


    public String getParaValue() {
        return paraValue;
    }


    public void setParaValue(String paraValue) {
        this.paraValue = paraValue == null ? null : paraValue.trim();
    }

    public String getUserName() {
        return userName == null ? "": userName.trim();
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<Users> getEduUserList() {
        return eduUserList;
    }

    public void setEduUserList(List<Users> eduUserList) {
        this.eduUserList = eduUserList;
    }
}

