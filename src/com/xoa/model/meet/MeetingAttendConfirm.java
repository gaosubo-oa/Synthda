package com.xoa.model.meet;

import java.util.List;

/**
 *  参会及查阅情况
 */
public class MeetingAttendConfirm {

    private Integer sid;//自增id

    private Integer attendFlag;//参会状态：0-待确认，1-参会，2-不参会，3-参会迟到，4-缺勤，5-请假

    private String confirmTime;//确认参会时间

    private String createTime;//创建时间

    private Integer meetingId;//会议ID

    private Integer readFlag;//签阅状态：0-未阅读，1-已阅

    private String readingTime;//签阅时间

    private String remark;//备注说明

    private Integer createUser;//创建人

    private  String userPrivName;//角色名称

    private String deptName;//部门名称

    private String createName;//创建人名称

    private String attendFlagStr;//参会状态名称

    private String readFlagStr;//签阅状态名称

    private Integer attendeeId;//出席人员id

    private String attendeeName;//出席人员名字

    private String address;//签到地址

    private String avatar;//出席人员头像

    private String signId;//个人签字照片ID串

    private String signName;//个人签字照片名称串

    private List signImage;

    private String meetingNotes;//会议笔记

    private Integer countNumber;//应当人数

    private Integer punctualNumber;//准时人数

    private Integer latecomersNumber;//迟到人数

    private Integer leaveNumber;//请假人数

    private Integer absenceFromDutyNumber;//缺勤人数

    public Integer getCountNumber() {
        return countNumber;
    }

    public void setCountNumber(Integer countNumber) {
        this.countNumber = countNumber;
    }

    public Integer getPunctualNumber() {
        return punctualNumber;
    }

    public void setPunctualNumber(Integer punctualNumber) {
        this.punctualNumber = punctualNumber;
    }

    public Integer getLatecomersNumber() {
        return latecomersNumber;
    }

    public void setLatecomersNumber(Integer latecomersNumber) {
        this.latecomersNumber = latecomersNumber;
    }

    public Integer getLeaveNumber() {
        return leaveNumber;
    }

    public void setLeaveNumber(Integer leaveNumber) {
        this.leaveNumber = leaveNumber;
    }

    public Integer getAbsenceFromDutyNumber() {
        return absenceFromDutyNumber;
    }

    public void setAbsenceFromDutyNumber(Integer absenceFromDutyNumber) {
        this.absenceFromDutyNumber = absenceFromDutyNumber;
    }

    public String getMeetingNotes() {
        return meetingNotes;
    }

    public void setMeetingNotes(String meetingNotes) {
        this.meetingNotes = meetingNotes;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getAddress() {
        return address==null?"":address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getAttendeeId() {
        return attendeeId;
    }

    public String getAttendeeName() {
        return attendeeName==null?"":attendeeName;
    }

    public void setAttendeeId(Integer attendeeId) {
        this.attendeeId = attendeeId;
    }

    public void setAttendeeName(String attendeeName) {
        this.attendeeName = attendeeName;
    }

    public Integer getSid() {
        return sid;
    }

    public Integer getAttendFlag() {
        return attendFlag;
    }

    public String getConfirmTime() {
        return confirmTime==null?"":confirmTime;
    }

    public String getCreateTime() {
        return createTime==null?"":createTime;
    }

    public Integer getMeetingId() {
        return meetingId;
    }

    public Integer getReadFlag() {
        return readFlag;
    }

    public String getReadingTime() {
        return readingTime==null?"":readingTime;
    }

    public String getRemark() {
        return remark==null?"":remark;
    }

    public Integer getCreateUser() {
        return createUser;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public void setAttendFlag(Integer attendFlag) {
        this.attendFlag = attendFlag;
    }

    public void setConfirmTime(String confirmTime) {
        this.confirmTime = confirmTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public void setMeetingId(Integer meetingId) {
        this.meetingId = meetingId;
    }

    public void setReadFlag(Integer readFlag) {
        this.readFlag = readFlag;
    }

    public void setReadingTime(String readingTime) {
        this.readingTime = readingTime;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setCreateUser(Integer createUser) {
        this.createUser = createUser;
    }

    public String getUserPrivName() {
        return userPrivName==null?"":userPrivName;
    }

    public String getDeptName() {
        return deptName==null?"":deptName;
    }

    public String getCreateName() {
        return createName;
    }

    public String getAttendFlagStr() {
        return attendFlagStr==null?"":attendFlagStr;
    }

    public String getReadFlagStr() {
        return readFlagStr==null?"":readFlagStr;
    }

    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public void setAttendFlagStr(String attendFlagStr) {
        this.attendFlagStr = attendFlagStr;
    }

    public void setReadFlagStr(String readFlagStr) {
        this.readFlagStr = readFlagStr;
    }

    public List getSignImage() {
        return signImage;
    }

    public void setSignImage(List signImage) {
        this.signImage = signImage;
    }

    public String getSignId() {
        return signId;
    }

    public void setSignId(String signId) {
        this.signId = signId;
    }

    public String getSignName() {
        return signName;
    }

    public void setSignName(String signName) {
        this.signName = signName;
    }
}