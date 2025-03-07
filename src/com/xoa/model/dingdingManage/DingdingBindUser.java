package com.xoa.model.dingdingManage;

/**
 * Created by lenovo on 2018/2/9.
 */
public class DingdingBindUser {

    private String userid;

    private String name;

    private boolean bind;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isBind() {
        return bind;
    }

    public void setBind(boolean bind) {
        this.bind = bind;
    }
}
