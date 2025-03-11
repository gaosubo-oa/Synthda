package com.xoa.model.calender;

import java.util.Date;
import java.util.List;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年5月4日 上午10:52:18
 * 类介绍  :
 * 构造参数:
 */
public class Calendar {
    /**
     * 唯一自增ID
     */
    private Integer calId;


    /**
     * Affair表唯一自增ID
     */

    private Integer affId;

    public Integer getAffId() {
        return affId;
    }

    public void setAffId(Integer affId) {
        this.affId = affId;
    }

    /**
     * 用户ID
     */
    private String userId;

    /**
     * 开始时间:
     */
    private Integer calTime;

    /**
     * 结束时间
     */
    private Integer endTime;

    /**
     * 事务类型(1-工作事务,2-个人事务)
     */
    private String calType;

    /**
     * 是否拥有编辑权限
     */
    private boolean isEdit = false;

    /**
     * 提醒类型(2-按日提醒,3-按周提醒,4-按月提醒,5按年提醒,6-按工作日提醒)
     */

    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }


    /**
     * 优先级(1-重要/紧急,2-重要/不紧急,3-不重要/紧急,4-不重要/不紧急)',
     */
    private String calLevel;

    /**
     * 事务内容
     */
    private String managerId;

    /**
     * 安排人的用户ID
     */
    private String overStatus;

    /**
     * 完成状态(0-未完成,1-已完成)
     */
    private String beforeRemaind;

    /**
     * 提前提醒时间
     */
    private String beforeDay;//提前天数
    private String beforeHour;//提前小时数
    private String beforeMin;//提前分钟数


    private Date addTime;

    /**
     * 新建时间
     */
    private Integer allday;

    /**
     * 从哪个模块添加的日程(1-外出,2-会议申请,3-工作计划,4-人力资源)',
     */
    private Integer fromModule;

    /**
     * 详情url
     */
    private String url;

    /**
     * 关联的模块的id
     */
    private Integer mId;

    /**
     * 对应模块id
     */
    private Integer resId;

    /**
     * 事物内容
     */
    private String content;

    /**
     * 所属者
     */
    private String owner;

    /**
     * 参与者
     */
    private String taker;
    //参与者名字
    private String takeName;
    //所属者名字
    private String ownerName;

    private String calData;

    private List<CalendarAll> calMessage;

    private String stim;

    private String etim;

    private Integer deptId;

    private String deptFunc;

    private String byName;

    private Integer uId;

    private Date remindDate;

    private Date remindTime;

    private String contentSecrecy;// 密级：系统代码

    public Date getRemindDate() {
        return remindDate;
    }

    public void setRemindDate(Date remindDate) {
        this.remindDate = remindDate;
    }

    public Date getRemindTime() {
        return remindTime;
    }

    public void setRemindTime(Date remindTime) {
        this.remindTime = remindTime;
    }

    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }


    private String deptName;

    private String userName;

    public void setBeforeDay(String beforeDay) {
        if (beforeDay == null || beforeDay == "") {
            this.beforeDay = "0";
        } else {
            this.beforeDay = beforeDay;
        }

    }

    public String getTakeName() {
        return takeName == null ? "" : takeName;
    }

    public void setTakeName(String takeName) {
        this.takeName = takeName;
    }

    public String getOwnerName() {
        return ownerName == null ? "" : ownerName;
    }

    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    public void setBeforeHour(String beforeHour) {
        if (beforeHour == null || beforeHour == "") {
            this.beforeHour = "0";
        } else {
            this.beforeHour = beforeHour;
        }
    }

    public void setBeforeMin(String beforeMin) {
        if (beforeMin == null || beforeMin == "") {
            this.beforeMin = "0";
        } else {
            this.beforeMin = beforeMin;
        }
    }

    public String getBeforeDay() {
        if (beforeDay == null || beforeDay == "") {
            beforeDay = "0";
        }
        return beforeDay;
    }

    public String getBeforeHour() {
        if (beforeHour == null || beforeHour == "") {
            beforeHour = "0";
        }
        return beforeHour;
    }

    public String getBeforeMin() {
        if (beforeMin == null || beforeMin == "") {
            beforeMin = "0";
        }
        return beforeMin;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }


    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getByName() {
        return byName;
    }

    public void setByName(String byName) {
        this.byName = byName;
    }


    public String getDeptFunc() {
        return deptFunc;
    }

    public void setDeptFunc(String deptFunc) {
        this.deptFunc = deptFunc;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getStim() {
        return stim;
    }

    public void setStim(String stim) {
        this.stim = stim;
    }

    public String getEtim() {
        return etim;
    }

    public String setEtim(String etim) {
        this.etim = etim;
        return etim;
    }

    public String getCalData() {
        return calData;
    }

    public void setCalData(String calData) {
        this.calData = calData;
    }

    public List<CalendarAll> getCalMessage() {
        return calMessage;
    }

    public void setCalMessage(List<CalendarAll> calMessage) {
        this.calMessage = calMessage;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getOwner() {
        return owner == null ? "" : owner;
    }

    public void setOwner(String owner) {
        this.owner = owner == null ? null : owner.trim();
    }

    public String getTaker() {
        return taker == null ? "" : taker;
    }

    public void setTaker(String taker) {
        this.taker = taker == null ? null : taker.trim();
    }

    public Integer getCalId() {
        return calId;
    }

    public void setCalId(Integer calId) {
        this.calId = calId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getCalTime() {
        return calTime;
    }

    public void setCalTime(Integer calTime) {
        this.calTime = calTime;
    }

    public Integer getEndTime() {
        return endTime;
    }

    public void setEndTime(Integer endTime) {
        this.endTime = endTime;
    }

    public String getCalType() {
        return calType;
    }

    public void setCalType(String calType) {
        this.calType = calType == null ? null : calType.trim();
    }

    public boolean isEdit() {
        return isEdit;
    }

    public void setEdit(boolean edit) {
        isEdit = edit;
    }

    public String getCalLevel() {
        return calLevel;
    }

    public void setCalLevel(String calLevel) {
        this.calLevel = calLevel == null ? null : calLevel.trim();
    }

    public String getManagerId() {
        return managerId == null ? "" : managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId == null ? null : managerId.trim();
    }

    public String getOverStatus() {
        return overStatus == null ? "" : overStatus;
    }

    public void setOverStatus(String overStatus) {
        this.overStatus = overStatus == null ? null : overStatus.trim();
    }

    public String getBeforeRemaind() {
        return beforeRemaind;
    }

    public void setBeforeRemaind(String beforeRemaind) {
        this.beforeRemaind = beforeRemaind == null ? null : beforeRemaind.trim();
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public Integer getAllday() {
        return allday == null ? 0 : allday;
    }

    public void setAllday(Integer allday) {
        this.allday = allday;
    }

    public Integer getFromModule() {
        return fromModule == null ? 0 : fromModule;
    }

    public void setFromModule(Integer fromModule) {
        this.fromModule = fromModule;
    }

    public String getUrl() {
        return url == null ? "" : url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public Integer getmId() {
        return mId == null ? 1 : mId;
    }

    public void setmId(Integer mId) {
        this.mId = mId;
    }

    public Integer getResId() {
        return resId == null ? 1 : resId;
    }

    public void setResId(Integer resId) {
        this.resId = resId;
    }

    public String getContentSecrecy() {
        return contentSecrecy;
    }

    public void setContentSecrecy(String contentSecrecy) {
        this.contentSecrecy = contentSecrecy;
    }
}