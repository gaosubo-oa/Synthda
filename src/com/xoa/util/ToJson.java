//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.xoa.util;

import com.xoa.util.common.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ToJson<T> {
    private List<T> obj = new ArrayList();
    private Object object;
    private Object obj1;
    private boolean flag;
    private String msg;
    private String code;
    private String token;
    private Integer totleNum;
    private Integer draftsCount;
    private Integer hairboxCount;
    private Integer noReadCount;
    private Integer inboxCount;
    private Integer wasteCount;
    private boolean isTurn;
    private Object data;
    private String sys_version;

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getNoReadCount() {
        return this.noReadCount;
    }

    public void setNoReadCount(Integer noReadCount) {
        this.noReadCount = noReadCount;
    }

    public Integer getWasteCount() {
        return this.wasteCount;
    }

    public void setWasteCount(Integer wasteCount) {
        this.wasteCount = wasteCount;
    }

    public Integer getDraftsCount() {
        return this.draftsCount;
    }

    public void setDraftsCount(Integer draftsCount) {
        this.draftsCount = draftsCount;
    }

    public Integer getHairboxCount() {
        return this.hairboxCount;
    }

    public void setHairboxCount(Integer hairboxCount) {
        this.hairboxCount = hairboxCount;
    }

    public Integer getInboxCount() {
        return this.inboxCount;
    }

    public void setInboxCount(Integer inboxCount) {
        this.inboxCount = inboxCount;
    }

    public Object getObj1() {
        return this.obj1;
    }

    public void setObj1(Object obj1) {
        this.obj1 = obj1;
    }

    public boolean isTurn() {
        return this.isTurn;
    }

    public void setTurn(boolean turn) {
        this.isTurn = turn;
    }

    public ToJson(int flag, String msg) {
        if (flag == 0) {
            this.flag = true;
        } else {
            this.flag = false;
        }

        this.msg = msg;
    }

    public ToJson() {
    }

    public List<T> getObj() {
        return this.obj;
    }

    public void setObj(List<T> obj) {
        this.obj = obj;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setMsg(String msg) {
        if(!StringUtils.checkNull(msg)){
            if(msg.contains("成功")){
                msg = "success";
            } else if (msg.contains("失败")){
                msg = "fail";
            } else if (msg.contains("异常")){
                msg = "err";
            }
        }
        this.msg = msg;
    }

    public Object getObject() {
        return this.object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public boolean isFlag() {
        return this.flag;
    }

    public void setFlag(int flag) {
        if (flag == 0) {
            this.flag = true;
        } else {
            this.flag = false;
        }

    }

    public Integer getTotleNum() {
        return this.totleNum;
    }

    public void setTotleNum(Integer totleNum) {
        this.totleNum = totleNum;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getToken() {
        return this.token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    String id;
    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    Date birthday;

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public Date getBirthday() {
        return birthday;
    }


    public String getSys_version() {
        return sys_version;
    }

    public void setSys_version(String sys_version) {
        this.sys_version = sys_version;
    }
}
