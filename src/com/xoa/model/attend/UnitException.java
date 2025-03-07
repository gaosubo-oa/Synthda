package com.xoa.model.attend;

/**
 * Created by gsb on 2017/7/7.
 */

/**
 * 设备异常
 */
public class UnitException extends  BaseAttend{

    private  String time;//时间
    private  String phoneId;//手机ID
    private  String str;//信息
    private  String atime;//异常时间

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getPhoneId() {
        return phoneId;
    }

    public void setPhoneId(String phoneId) {
        this.phoneId = phoneId;
    }

    public String getStr() {
        return str;
    }

    public void setStr(String str) {
        this.str = str;
    }

    public String getAtime() {
        return atime;
    }

    public void setAtime(String atime) {
        this.atime = atime;
    }
}
