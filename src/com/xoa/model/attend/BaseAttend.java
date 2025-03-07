package com.xoa.model.attend;

import java.util.List;

/**
 * Created by gsb on 2017/7/6.
 */
public class BaseAttend {

    private Double days;

    public Double getDays() {
        return days;
    }

    public void setDays(Double days) {
        this.days = days;
    }

    private List<BaseAttend> attendList;

    public List<BaseAttend> getAttendList() {
        return attendList;
    }

    public void setAttendList(List<BaseAttend> attendList) {
        this.attendList = attendList;
    }

    private  String date;

    private  String week;

    private  List<String> attendDate;

    public List<String> getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(List<String> attendDate) {
        this.attendDate = attendDate;
    }

    //所属流程
    private String runName;

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
    }

    private  String time;//时间

    private  String phoneId;//手机ID
    private  String str;//信息
    private  String atime;//异常时间
    private  List<Attend> remark;//异常时间
    private String signTime; //打卡时间
    private String signTimeStr; // 打卡时间备注
    private String signTimeDate; //打卡日期
    private String signStatus; //打卡状态

    private Integer item; //项

    public Integer getItem() {
        return item;
    }

    public void setItem(Integer item) {
        this.item = item;
    }

    public String getSignTime() {
        return signTime;
    }

    public void setSignTime(String signTime) {
        this.signTime = signTime;
    }

    public String getSignTimeStr() {
        return signTimeStr;
    }

    public void setSignTimeStr(String signTimeStr) {
        this.signTimeStr = signTimeStr;
    }

    public String getSignTimeDate() {
        return signTimeDate;
    }

    public void setSignTimeDate(String signTimeDate) {
        this.signTimeDate = signTimeDate;
    }

    public String getSignStatus() {
        return signStatus;
    }

    public void setSignStatus(String signStatus) {
        this.signStatus = signStatus;
    }

    public List<Attend> getRemark() {
        return remark;
    }

    public void setRemark(List<Attend> remark) {
        this.remark = remark;
    }

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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getWeek() {
        return week;
    }

    public void setWeek(String week) {
        this.week = week;
    }

    private  String strat;
    private  String end;
    private String cause;
    private  String hour;

    public String getHour() {
        return hour;
    }

    public void setHour(String hour) {
        this.hour = hour;
    }

    public String getStrat() {
        return strat;
    }

    public void setStrat(String strat) {
        this.strat = strat;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getCause() {
        return cause;
    }

    public void setCause(String cause) {
        this.cause = cause;
    }
}
