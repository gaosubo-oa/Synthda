package com.xoa.model.users;

import java.io.Serializable;

/**
 * 创建作者:   牛江丽
 * 创建日期:   ${date} ${time}
 * 类介绍  :
 * 构造参数:
 */
public class RoleManager implements Serializable {
    private Integer roleManagerId;//管理员id
    private String roleManager;//管理员
    private String roleManagerText;
    private String userPriv;//权限
    private String userPrivText;

    public String getRoleManagerText() {
        return roleManagerText;
    }

    public String getUserPrivText() {
        return userPrivText;
    }

    public void setRoleManagerText(String roleManagerText) {
        this.roleManagerText = roleManagerText;
    }

    public void setUserPrivText(String userPrivText) {
        this.userPrivText = userPrivText;
    }

    public void setRoleManagerId(Integer roleManagerId) {
        this.roleManagerId = roleManagerId;
    }

    public void setRoleManager(String roleManager) {
        this.roleManager = roleManager;
    }

    public void setUserPriv(String userPriv) {
        this.userPriv = userPriv;
    }

    public Integer getRoleManagerId() {
        return roleManagerId;
    }

    public String getRoleManager() {
        return roleManager;
    }

    public String getUserPriv() {
        return userPriv;
    }
}
