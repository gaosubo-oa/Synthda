package com.xoa.model.menu;


/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/1 17:34
 * @类介绍: 系统管理，添加菜单权限,向前台传已经有该菜单权限的角色（userPri）名或 用户名
 * @构造参数:
 **/
public class UserAuthModel {

    private String userPrivName;
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPrivName() {

        return userPrivName;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }
}
