package com.xoa.model.users;

import java.io.Serializable;

/**
 * @ClassName (类名):  Users
 * @Description(简述): TODO
 * @author(作者): wyq
 * @date(日期): 2017年4月17日 下午3:44:46
 */
public class UsersWidgetVO implements Serializable {
    /**
     * 唯一自增ID
     */
    private Integer uid;
    /**
     * 用户名
     */
    private String userId;
    /**
     * 用户真实姓名
     */
    private String userName;
    /**
     * 自定义小头像
     */
    private String avatar;

    public String getAvatar() {
            return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
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

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getUid() {
        return uid;
    }
}
