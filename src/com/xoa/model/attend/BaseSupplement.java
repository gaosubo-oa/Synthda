package com.xoa.model.attend;

import java.io.Serializable;
import java.util.List;

/**
 * Created by gsb on 2017/7/7.
 */
public class BaseSupplement implements Serializable{

    private static final long serialVersionUID = 1L;

    private  Integer uid;
    private  String name;
    private  String dept;
    private  String str;
    private  String avatar;
    private  String flag;
    private  String content;

    private List<Attend> cishu;


    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Attend> getCishu() {
        return cishu;
    }

    public void setCishu(List<Attend> cishu) {
        this.cishu = cishu;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}
