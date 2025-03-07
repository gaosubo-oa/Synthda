package com.xoa.util.attend;

/**
 * Created by gsb on 2018/9/21.
 */
public class AttendExt {

    //用户id
    Integer uid;
    String usesId;

    //用户姓名
    String userName;
    //用户部门
    String deptName;

    //应出勤天数
    Integer yingChuQin;

    //实际出勤天数
    Integer shiJiChuQin;

    //请假天数
    Integer attendLeave;
    //请假时长
    Integer attendLeaveDate;


    //外出次数
    Integer attendOuts;
    //外出时长
    Integer attendOutDate;


    //加班次数
    Integer attendanceOvertimes;
    //加班时长
    Integer attendanceOvertimeDate;


    //出差次数
    Integer attendEvection;
    //出差时长
    Integer attendEvectionDate;


    Integer zhengChangQianDao;//统计上班准时次数
    Integer zhengChangQianTui;//统计下班准时次数
    Integer chiDao;//统计迟到次数
    Integer zaoTui;//统计早退次数
    Integer weiQianDao;//统计未打卡次数
    Integer weiQianTui;//统计未签退次数
    Integer waiQin;//统计外勤次数


    Long timeDifference;//加班时间

    Integer quanQin;//全勤（）
    Integer kuangGong;//旷工天数（）
    Integer sheBeiYiChang;//设备异常（）


    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public void setUsesId(String usesId) {
        this.usesId = usesId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public void setYingChuQin(Integer yingChuQin) {
        this.yingChuQin = yingChuQin;
    }

    public void setShiJiChuQin(Integer shiJiChuQin) {
        this.shiJiChuQin = shiJiChuQin;
    }

    public void setAttendLeave(Integer attendLeave) {
        this.attendLeave = attendLeave;
    }

    public void setAttendLeaveDate(Integer attendLeaveDate) {
        this.attendLeaveDate = attendLeaveDate;
    }

    public void setAttendOuts(Integer attendOuts) {
        this.attendOuts = attendOuts;
    }

    public void setAttendOutDate(Integer attendOutDate) {
        this.attendOutDate = attendOutDate;
    }

    public void setAttendanceOvertimes(Integer attendanceOvertimes) {
        this.attendanceOvertimes = attendanceOvertimes;
    }

    public void setAttendanceOvertimeDate(Integer attendanceOvertimeDate) {
        this.attendanceOvertimeDate = attendanceOvertimeDate;
    }

    public void setAttendEvection(Integer attendEvection) {
        this.attendEvection = attendEvection;
    }

    public void setAttendEvectionDate(Integer attendEvectionDate) {
        this.attendEvectionDate = attendEvectionDate;
    }

    public void setZhengChangQianDao(Integer zhengChangQianDao) {
        this.zhengChangQianDao = zhengChangQianDao;
    }

    public void setZhengChangQianTui(Integer zhengChangQianTui) {
        this.zhengChangQianTui = zhengChangQianTui;
    }

    public void setChiDao(Integer chiDao) {
        this.chiDao = chiDao;
    }

    public void setZaoTui(Integer zaoTui) {
        this.zaoTui = zaoTui;
    }

    public void setWeiQianDao(Integer weiQianDao) {
        this.weiQianDao = weiQianDao;
    }

    public void setWeiQianTui(Integer weiQianTui) {
        this.weiQianTui = weiQianTui;
    }

    public void setWaiQin(Integer waiQin) {
        this.waiQin = waiQin;
    }

    public void setTimeDifference(Long timeDifference) {
        this.timeDifference = timeDifference;
    }

    public void setQuanQin(Integer quanQin) {
        this.quanQin = quanQin;
    }

    public void setKuangGong(Integer kuangGong) {
        this.kuangGong = kuangGong;
    }

    public void setSheBeiYiChang(Integer sheBeiYiChang) {
        this.sheBeiYiChang = sheBeiYiChang;
    }

    public Integer getUid() {
        return uid;
    }

    public String getUsesId() {
        return usesId;
    }

    public String getUserName() {
        return userName;
    }

    public String getDeptName() {
        return deptName;
    }

    public Integer getYingChuQin() {
        return yingChuQin;
    }

    public Integer getShiJiChuQin() {
        return shiJiChuQin;
    }

    public Integer getAttendLeave() {
        return attendLeave;
    }

    public Integer getAttendLeaveDate() {
        return attendLeaveDate;
    }

    public Integer getAttendOuts() {
        return attendOuts;
    }

    public Integer getAttendOutDate() {
        return attendOutDate;
    }

    public Integer getAttendanceOvertimes() {
        return attendanceOvertimes;
    }

    public Integer getAttendanceOvertimeDate() {
        return attendanceOvertimeDate;
    }

    public Integer getAttendEvection() {
        return attendEvection;
    }

    public Integer getAttendEvectionDate() {
        return attendEvectionDate;
    }

    public Integer getZhengChangQianDao() {
        return zhengChangQianDao;
    }

    public Integer getZhengChangQianTui() {
        return zhengChangQianTui;
    }

    public Integer getChiDao() {
        return chiDao;
    }

    public Integer getZaoTui() {
        return zaoTui;
    }

    public Integer getWeiQianDao() {
        return weiQianDao;
    }

    public Integer getWeiQianTui() {
        return weiQianTui;
    }

    public Integer getWaiQin() {
        return waiQin;
    }

    public Long getTimeDifference() {
        return timeDifference;
    }

    public Integer getQuanQin() {
        return quanQin;
    }

    public Integer getKuangGong() {
        return kuangGong;
    }

    public Integer getSheBeiYiChang() {
        return sheBeiYiChang;
    }
}
