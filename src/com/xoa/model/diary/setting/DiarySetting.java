package com.xoa.model.diary.setting;

//日志设置 汇报设置
public class DiarySetting {
    private String reportBegins;//汇报开始时间（为空表示不限制）
    private String reportEnd;//汇报结束时间（为空表示不限制）
    private String whiteListUser;//白名单(用户)（白名单内的用户无需汇报）
    private String whiteListUserName;//白名单(用户)（白名单内的用户无需汇报）名称
    private String whiteListPriv;//白名单(角色)（白名单内的角色无需汇报）
    private String whiteListPrivName;//白名单(角色)（白名单内的角色无需汇报）名称
    private String whiteListDept;//白名单(部门)（白名单内的部门无需汇报）
    private String whiteListDeptName;//白名单(部门)（白名单内的部门无需汇报）名称
    private String reportReminder;//汇报提醒时间
    private String weekly;//周报汇报时间
    private String monthlyReport;//月报汇报时间
    private Integer comment;//是否开启点评（1开启  0关闭）
    private Integer whetherRemind;//是否提醒（1提醒，0不提醒）
    private String holidaySetting;//假期汇报设置
    private String holidayData;//假期日期（当日不提醒）

    public String getReportBegins() {
        return reportBegins;
    }

    public void setReportBegins(String reportBegins) {
        this.reportBegins = reportBegins;
    }

    public String getReportEnd() {
        return reportEnd;
    }

    public void setReportEnd(String reportEnd) {
        this.reportEnd = reportEnd;
    }

    public String getWhiteListUser() {
        return whiteListUser;
    }

    public void setWhiteListUser(String whiteListUser) {
        this.whiteListUser = whiteListUser;
    }

    public String getWhiteListUserName() {
        return whiteListUserName;
    }

    public void setWhiteListUserName(String whiteListUserName) {
        this.whiteListUserName = whiteListUserName;
    }

    public String getWhiteListPriv() {
        return whiteListPriv;
    }

    public void setWhiteListPriv(String whiteListPriv) {
        this.whiteListPriv = whiteListPriv;
    }

    public String getWhiteListPrivName() {
        return whiteListPrivName;
    }

    public void setWhiteListPrivName(String whiteListPrivName) {
        this.whiteListPrivName = whiteListPrivName;
    }

    public String getWhiteListDept() {
        return whiteListDept;
    }

    public void setWhiteListDept(String whiteListDept) {
        this.whiteListDept = whiteListDept;
    }

    public String getWhiteListDeptName() {
        return whiteListDeptName;
    }

    public void setWhiteListDeptName(String whiteListDeptName) {
        this.whiteListDeptName = whiteListDeptName;
    }

    public String getReportReminder() {
        return reportReminder;
    }

    public void setReportReminder(String reportReminder) {
        this.reportReminder = reportReminder;
    }

    public String getWeekly() {
        return weekly;
    }

    public void setWeekly(String weekly) {
        this.weekly = weekly;
    }

    public String getMonthlyReport() {
        return monthlyReport;
    }

    public void setMonthlyReport(String monthlyReport) {
        this.monthlyReport = monthlyReport;
    }

    public Integer getComment() {
        return comment;
    }

    public void setComment(Integer comment) {
        this.comment = comment;
    }

    public Integer getWhetherRemind() {
        return whetherRemind;
    }

    public void setWhetherRemind(Integer whetherRemind) {
        this.whetherRemind = whetherRemind;
    }

    public String getHolidaySetting() {
        return holidaySetting;
    }

    public void setHolidaySetting(String holidaySetting) {
        this.holidaySetting = holidaySetting;
    }

    public String getHolidayData() {
        return holidayData;
    }

    public void setHolidayData(String holidayData) {
        this.holidayData = holidayData;
    }
}
