package com.xoa.model.attend;

import com.xoa.util.common.StringUtils;

import java.util.Map;

public class AttendSet {
    /**
     * 唯一自增ID
     */
    private Integer sid;
    /**
     * 创建者ID
     */
    private Integer uid;
    /**
     * 打卡类型
     */
    private String attendType;
    /**
     * 考勤打卡类型名称
     */
    private String title;
    /**
     * 第一次打卡开关
     */
    private String atime1Set;
    /**
     * 第一次打卡标准时间
     */
    private String atime1;
    /**
     * 第二次打卡开关
     */
    private String atime2Set;
    /**
     * 第二次打卡标准时间
     */
    private String atime2;
    /**
     * 第三次打卡开关
     */
    private String atime3Set;
    /**
     * 第三次打卡标准时间
     */
    private String atime3;
    /**
     * 第四次打卡开关
     */
    private String atime4Set;
    /**
     * 第四次打卡标准时间
     */
    private String atime4;
    /**
     * 第五次打卡开关
     */
    private String atime5Set;
    /**
     * 第五次打卡标准时间
     */
    private String atime5;
    /**
     * 第六次打卡开关
     */
    private String atime6Set;
    /**
     * 第六次打卡标准时间
     */
    private String atime6;


    /**
     * 第七次打卡开关
     */
    private String atime7Set;
    /**
     * 第七次打卡标准时间
     */
    private String atime7;
    /**
     * 第八次打卡开关
     */
    private String atime8Set;
    /**
     * 第八次打卡标准时间
     */
    private String atime8;

    /**
     * 上班可提前打卡分钟数
     */
    private String worktimeF;
    /**
     * 上班可延后分钟数
     */
    private String worktimeB;
    /**
     * 下班可提前分钟数
     */
    private String workafterF;
    /**
     * 下班可延后分钟数
     */
    private String workafterB;
    /**
     * 弹性工作开始时间24小时制
     */
    private String workStart;
    /**
     * 弹性结束开始时间24小时制
     */
    private String workEnd;
    /**
     * 弹性工时-最小工作小时
     */
    private Integer workHours;
    /**
     * 位置是否开启
     */
    private String locationOn;
    /**
     * 规定打卡地点
     */
    private String location;
    /**
     * 可打卡位置范围（米）
     */
    private String ranges;
    /**
     * 是否开启wifi打卡
     */
    private String wifiOn;
    /**
     * wifi地址
     */
    private String wifiAddr;
    /**
     * wifi名称
     */
    private String wifiName;
    /**
     * 是否开启IP限制打卡（0-关闭，1-开启）
     */
    private String ipOn;
    /**
     * IP段（`-`分隔）
     */
    private String ipParagraph;
    /**
     * IP段开始
     */
    private String iPStart;
    /**
     * IP段结束
     */
    private String iPEnd;
    /**
     * 加班开关
     */
    private String isOvertime;
    /**
     * 请假开关
     */
    private String isLeave;
    /**
     * 外出开关
     */
    private String isGo;
    /**
     * 出差开关
     */
    private String isTrip;
    /**
     * 外勤开关
     */
    private String isOut;
    /**
     * 值班开关
     */
    private String isDuty;
    /**
     * 上班日期(待删除)
     */
    private String workdate;
    /**
     * 计算总排班时长（新增排班用）
     */
    private String duration;
    /**
     * 总时长秒数
     */
    private Integer durationSeconde;

    private String userId;

    private String atime1Setother;//第1次打卡开关
    private String atime2Setother;//第2次打卡开关
    private String atime3Setother;//第3次打卡开关
    private String atime4Setother;//第4次打卡开关
    private String atime5Setother;//第5次打卡开关
    private String atime6Setother;//第6次打卡开关
    private String atime7Setother;//第7次打卡开关
    private String atime8Setother;//第8次打卡开关

    private String commute1;//第1次上下班开关
    private String commute2;//第2次上下班开关
    private String commute3;//第3次上下班开关
    private String commute4;//第4次上下班开关
    private String commute5;//第5次上下班开关
    private String commute6;//第6次上下班开关
    private String commute7;//第7次上下班开关
    private String commute8;//第8次上下班开关

    Map<String, String> atimeSetotherList;
    Map<String, String> commuteList;
    Map<String, String> timeList;
    private String faceRecog ;//第6次上下班开关

    public String getAtime7Set() {
        return StringUtils.checkNull(atime7Set)?"0|1":atime7Set;
    }

    public void setAtime7Set(String atime7Set) {
        this.atime7Set = atime7Set;
    }

    public String getAtime7() {
        return atime7;
    }

    public void setAtime7(String atime7) {
        this.atime7 = atime7;
    }

    public String getAtime8Set() {
        return StringUtils.checkNull(atime8Set)?"0|1":atime8Set;
    }

    public void setAtime8Set(String atime8Set) {
        this.atime8Set = atime8Set;
    }

    public String getAtime8() {
        return atime8;
    }

    public void setAtime8(String atime8) {
        this.atime8 = atime8;
    }

    public String getAtime7Setother() {
        return atime7Setother;
    }

    public void setAtime7Setother(String atime7Setother) {
        this.atime7Setother = atime7Setother;
    }

    public String getAtime8Setother() {
        return atime8Setother;
    }

    public void setAtime8Setother(String atime8Setother) {
        this.atime8Setother = atime8Setother;
    }

    public String getCommute7() {
        return commute7;
    }

    public void setCommute7(String commute7) {
        this.commute7 = commute7;
    }

    public String getCommute8() {
        return commute8;
    }

    public void setCommute8(String commute8) {
        this.commute8 = commute8;
    }

    public String getFaceRecog() {
        return faceRecog;
    }

    public void setFaceRecog(String faceRecog) {
        this.faceRecog = faceRecog;
    }

    public Integer getSid() {
        return sid;
    }
    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAtime1Set() {
        return atime1Set;
    }

    public void setAtime1Set(String atime1Set) {
        this.atime1Set = atime1Set;
    }

    public String getAtime1() {
        return atime1;
    }

    public void setAtime1(String atime1) {
        this.atime1 = atime1;
    }

    public String getAtime2Set() {
        return atime2Set;
    }

    public void setAtime2Set(String atime2Set) {
        this.atime2Set = atime2Set;
    }

    public String getAtime2() {
        return atime2;
    }

    public void setAtime2(String atime2) {
        this.atime2 = atime2;
    }

    public String getAtime3Set() {
        return atime3Set;
    }

    public void setAtime3Set(String atime3Set) {
        this.atime3Set = atime3Set;
    }

    public String getAtime3() {
        return atime3;
    }

    public void setAtime3(String atime3) {
        this.atime3 = atime3;
    }

    public String getAtime4Set() {
        return atime4Set;
    }

    public void setAtime4Set(String atime4Set) {
        this.atime4Set = atime4Set;
    }

    public String getAtime4() {
        return atime4;
    }

    public void setAtime4(String atime4) {
        this.atime4 = atime4;
    }

    public String getAtime5Set() {
        return atime5Set;
    }

    public void setAtime5Set(String atime5Set) {
        this.atime5Set = atime5Set;
    }

    public String getAtime5() {
        return atime5;
    }

    public void setAtime5(String atime5) {
        this.atime5 = atime5;
    }

    public String getAtime6Set() {
        return atime6Set;
    }

    public void setAtime6Set(String atime6Set) {
        this.atime6Set = atime6Set;
    }

    public String getAtime6() {
        return atime6;
    }

    public void setAtime6(String atime6) {
        this.atime6 = atime6;
    }

    public String getWorktimeF() {
        return worktimeF;
    }

    public void setWorktimeF(String worktimeF) {
        this.worktimeF = worktimeF;
    }

    public String getWorktimeB() {
        return worktimeB;
    }

    public void setWorktimeB(String worktimeB) {
        this.worktimeB = worktimeB;
    }

    public String getWorkafterF() {
        return workafterF;
    }

    public void setWorkafterF(String workafterF) {
        this.workafterF = workafterF;
    }

    public String getWorkafterB() {
        return workafterB;
    }

    public void setWorkafterB(String workafterB) {
        this.workafterB = workafterB;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getRanges() {
        return ranges;
    }

    public void setRanges(String ranges) {
        this.ranges = ranges;
    }

    public String getIsOut() {
        return isOut;
    }

    public void setIsOut(String isOut) {
        this.isOut = isOut;
    }

    public String getLocationOn() {
        return locationOn;
    }

    public void setLocationOn(String locationOn) {
        this.locationOn = locationOn;
    }

    public String getWifiOn() {
        return wifiOn;
    }

    public void setWifiOn(String wifiOn) {
        this.wifiOn = wifiOn;
    }

    public String getWifiAddr() {
        return wifiAddr;
    }

    public void setWifiAddr(String wifiAddr) {
        this.wifiAddr = wifiAddr;
    }

    public String getWifiName() {
        return wifiName;
    }

    public void setWifiName(String wifiName) {
        this.wifiName = wifiName;
    }

    public String getWorkdate() {
        return workdate;
    }

    public void setWorkdate(String workdate) {
        this.workdate = workdate;
    }

    public String getCommute1() {
        return commute1;
    }

    public void setCommute1(String commute1) {
        this.commute1 = commute1;
    }

    public String getCommute2() {
        return commute2;
    }

    public void setCommute2(String commute2) {
        this.commute2 = commute2;
    }

    public String getCommute3() {
        return commute3;
    }

    public void setCommute3(String commute3) {
        this.commute3 = commute3;
    }

    public String getCommute4() {
        return commute4;
    }

    public void setCommute4(String commute4) {
        this.commute4 = commute4;
    }

    public String getCommute5() {
        return commute5;
    }

    public void setCommute5(String commute5) {
        this.commute5 = commute5;
    }

    public String getCommute6() {
        return commute6;
    }

    public void setCommute6(String commute6) {
        this.commute6 = commute6;
    }

    public String getAtime1Setother() {
        return atime1Setother;
    }

    public void setAtime1Setother(String atime1Setother) {
        this.atime1Setother = atime1Setother;
    }

    public String getAtime2Setother() {
        return atime2Setother;
    }

    public void setAtime2Setother(String atime2Setother) {
        this.atime2Setother = atime2Setother;
    }

    public String getAtime3Setother() {
        return atime3Setother;
    }

    public void setAtime3Setother(String atime3Setother) {
        this.atime3Setother = atime3Setother;
    }

    public String getAtime4Setother() {
        return atime4Setother;
    }

    public void setAtime4Setother(String atime4Setother) {
        this.atime4Setother = atime4Setother;
    }

    public String getAtime5Setother() {
        return atime5Setother;
    }

    public void setAtime5Setother(String atime5Setother) {
        this.atime5Setother = atime5Setother;
    }

    public String getAtime6Setother() {
        return atime6Setother;
    }

    public void setAtime6Setother(String atime6Setother) {
        this.atime6Setother = atime6Setother;
    }

    public String getAttendType() {
        return attendType;
    }

    public void setAttendType(String attendType) {
        this.attendType = attendType;
    }

    public String getWorkStart() {
        return workStart;
    }

    public void setWorkStart(String workStart) {
        this.workStart = workStart;
    }

    public String getWorkEnd() {
        return workEnd;
    }

    public void setWorkEnd(String workEnd) {
        this.workEnd = workEnd;
    }

    public Integer getWorkHours() {
        return workHours;
    }

    public void setWorkHours(Integer workHours) {
        this.workHours = workHours;
    }

    public String getIpOn() {
        return ipOn;
    }

    public void setIpOn(String ipOn) {
        this.ipOn = ipOn;
    }

    public String getIpParagraph() {
        return ipParagraph;
    }

    public void setIpParagraph(String ipParagraph) {
        this.ipParagraph = ipParagraph;
    }

    public String getiPStart() {
        return iPStart;
    }

    public void setiPStart(String iPStart) {
        this.iPStart = iPStart;
    }

    public String getiPEnd() {
        return iPEnd;
    }

    public void setiPEnd(String iPEnd) {
        this.iPEnd = iPEnd;
    }

    public String getIsOvertime() {
        return isOvertime;
    }

    public void setIsOvertime(String isOvertime) {
        this.isOvertime = isOvertime;
    }

    public String getIsLeave() {
        return isLeave;
    }

    public void setIsLeave(String isLeave) {
        this.isLeave = isLeave;
    }

    public String getIsGo() {
        return isGo;
    }

    public void setIsGo(String isGo) {
        this.isGo = isGo;
    }

    public String getIsTrip() {
        return isTrip;
    }

    public void setIsTrip(String isTrip) {
        this.isTrip = isTrip;
    }

    public String getIsDuty() {
        return isDuty;
    }

    public void setIsDuty(String isDuty) {
        this.isDuty = isDuty;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public Integer getDurationSeconde() {
        return durationSeconde;
    }

    public void setDurationSeconde(Integer durationSeconde) {
        this.durationSeconde = durationSeconde;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Map<String, String> getAtimeSetotherList() {
        return atimeSetotherList;
    }

    public void setAtimeSetotherList(Map<String, String> atimeSetotherList) {
        this.atimeSetotherList = atimeSetotherList;
    }

    public Map<String, String> getCommuteList() {
        return commuteList;
    }

    public void setCommuteList(Map<String, String> commuteList) {
        this.commuteList = commuteList;
    }

    public Map<String, String> getTimeList() {
        return timeList;
    }

    public void setTimeList(Map<String, String> timeList) {
        this.timeList = timeList;
    }
}