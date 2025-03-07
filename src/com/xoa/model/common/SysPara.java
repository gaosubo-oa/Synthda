package com.xoa.model.common;

import com.xoa.model.users.Users;

import java.io.Serializable;
import java.util.List;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-18 下午5:36:22
 * 类介绍   :    APP端
 * 构造参数:   无
 */
public class SysPara implements Serializable{
    /**
     * 参数名称
     */
    private String paraName;
    /**
     * 参数值
     */
    private String paraValue;
   //用户姓名
    private String userName;
    // 部门
    private String deptName;
    // 角色
    private String privName;
    //用户信息集合
    private List<Users> usersList;
    private List<Users> eduUserList;
    private String userId;

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName;
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午5:36:36
     * 方法介绍:   参数名称
     * 参数说明:   @return
     *
     * @return String  paraName(参数名称)
     */
    public String getParaName() {
        return paraName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午5:43:52
     * 方法介绍:    参数名称
     * 参数说明:   @param paraName
     *
     * @return void
     */


    public void setParaName(String paraName) {
        this.paraName = paraName == null ? null : paraName.trim();
    }

    public List<Users> getUsersList() {
        return usersList;
    }

    public void setUsersList(List<Users> usersList) {
        this.usersList = usersList;
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午5:44:25
     * 方法介绍:   参数值
     * 参数说明:   @return
     *
     * @return String paraValue(参数值)
     */


    public String getParaValue() {
        return paraValue;
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午5:44:47
     * 方法介绍:   参数值
     * 参数说明:   @param paraValue
     *
     * @return void
     */
    public void setParaValue(String paraValue) {
        this.paraValue = paraValue == null ? null : paraValue.trim();
    }

    public String getUserName() {
        return userName;
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