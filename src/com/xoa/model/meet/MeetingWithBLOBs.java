package com.xoa.model.meet;

import com.xoa.model.users.Users;

import java.util.List;
import java.util.Map;

public class MeetingWithBLOBs extends Meeting {

    private String attendee;//出席人员（内部）

    private String attendeeName;//出席人员名字

    private String attendeeUserId;

    private String realAttendeeName;//真正出席人员的名字

    private String attendeeNot;

    private String attendeeOut;//出席人员（外部）

    private String meetDesc;//会议描述

    private String readPeopleId;//会议纪要读者

    private String readPeopleNames;//会议纪要读者名字

    private String summary;//会议纪要内容

    private String equipments;

    private String attendeeNotIds;

    private String attendeeNotNames;

    private String equipmentIds;

    private String equipmentNames;

    private List<Users> usersList;

    private String myAttend;

    private Integer myAttendStatus;

    private Integer userPriv;


    private String cycleStartDate;

    private String cycleEndDate;

    private String cycleStartTime;

    private String cycleEndTime;

    private String cycleWeek;

    //视频会议拉起客户端参数
    private Map videoContent;

    //会议室管理员
    private String managerIds;

    public String getManagerIds() {
        return managerIds;
    }

    public void setManagerIds(String managerIds) {
        this.managerIds = managerIds;
    }

    public Map getVideoContent() {
        return videoContent;
    }

    public void setVideoContent(Map videoContent) {
        this.videoContent = videoContent;
    }

    public String getCycleStartDate() {
        return cycleStartDate;
    }

    public void setCycleStartDate(String cycleStartDate) {
        this.cycleStartDate = cycleStartDate;
    }

    public String getCycleEndDate() {
        return cycleEndDate;
    }

    public void setCycleEndDate(String cycleEndDate) {
        this.cycleEndDate = cycleEndDate;
    }

    public String getCycleStartTime() {
        return cycleStartTime;
    }

    public void setCycleStartTime(String cycleStartTime) {
        this.cycleStartTime = cycleStartTime;
    }

    public String getCycleEndTime() {
        return cycleEndTime;
    }

    public void setCycleEndTime(String cycleEndTime) {
        this.cycleEndTime = cycleEndTime;
    }

    public String getCycleWeek() {
        return cycleWeek;
    }

    public void setCycleWeek(String cycleWeek) {
        this.cycleWeek = cycleWeek;
    }

    public Integer getMyAttendStatus() {
        return myAttendStatus==null?0:myAttendStatus;
    }

    public void setMyAttendStatus(Integer myAttendStatus) {
        this.myAttendStatus = myAttendStatus;
    }

    public String getMyAttend() {
        return myAttend==null?"未签到":myAttend;
    }

    public void setMyAttend(String myAttend) {
        this.myAttend = myAttend;
    }

    public List<Users> getUsersList() {
        return usersList;
    }

    public void setUsersList(List<Users> usersList) {
        this.usersList = usersList;
    }

    public String getRealAttendeeName() {
        return realAttendeeName==null?"":realAttendeeName;
    }

    public void setRealAttendeeName(String realAttendeeName) {
        this.realAttendeeName = realAttendeeName;
    }

    public String getAttendeeName() {
        return attendeeName==null?"":attendeeName;
    }

    public void setAttendeeName(String attendeeName) {
        this.attendeeName = attendeeName;
    }

    public String getSummary() {
        return summary==null?"":summary;
    }

    public String getAttendee() {
        return attendee==null?"":attendee;
    }

    public void setAttendee(String attendee) {
        this.attendee = attendee == null ? null : attendee.trim();
    }

    public String getAttendeeNot() {
        return attendeeNot;
    }

    public void setAttendeeNot(String attendeeNot) {
        this.attendeeNot = attendeeNot == null ? null : attendeeNot.trim();
    }

    public String getAttendeeOut() {
        return attendeeOut;
    }

    public void setAttendeeOut(String attendeeOut) {
        this.attendeeOut = attendeeOut == null ? null : attendeeOut.trim();
    }

    public String getReadPeopleNames() {
        return readPeopleNames==null?"":readPeopleNames.trim();
    }

    public void setReadPeopleNames(String readPeopleNames) {
        this.readPeopleNames = readPeopleNames;
    }

    public String getMeetDesc() {
        return meetDesc==null?"":meetDesc;
    }

    public void setMeetDesc(String meetDesc) {
        this.meetDesc = meetDesc == null ? null : meetDesc.trim();
    }

    public String getReadPeopleId() {
        return readPeopleId;
    }

    public void setReadPeopleId(String readPeopleId) {
        this.readPeopleId = readPeopleId == null ? null : readPeopleId.trim();
    }

    public void setSummary(String summary) {
        this.summary = summary == null ? null : summary.trim();
    }

    public String getEquipments() {
        return equipments;
    }

    public void setEquipments(String equipments) {
        this.equipments = equipments == null ? null : equipments.trim();
    }

    public String getAttendeeNotIds() {
        return attendeeNotIds;
    }

    public void setAttendeeNotIds(String attendeeNotIds) {
        this.attendeeNotIds = attendeeNotIds == null ? null : attendeeNotIds.trim();
    }

    public String getAttendeeNotNames() {
        return attendeeNotNames;
    }

    public void setAttendeeNotNames(String attendeeNotNames) {
        this.attendeeNotNames = attendeeNotNames == null ? null : attendeeNotNames.trim();
    }

    public String getEquipmentIds() {
        return equipmentIds;
    }

    public void setEquipmentIds(String equipmentIds) {
        this.equipmentIds = equipmentIds == null ? null : equipmentIds.trim();
    }

    public String getEquipmentNames() {
        return equipmentNames==null?"":equipmentNames;
    }

    public void setEquipmentNames(String equipmentNames) {
        this.equipmentNames = equipmentNames == null ? null : equipmentNames.trim();
    }

    public Integer getUserPriv() {
        return userPriv;
    }

    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    public String getAttendeeUserId() {
        return attendeeUserId;
    }

    public void setAttendeeUserId(String attendeeUserId) {
        this.attendeeUserId = attendeeUserId;
    }
}