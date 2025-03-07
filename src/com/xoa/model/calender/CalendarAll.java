package com.xoa.model.calender;

import java.util.Date;

public class CalendarAll {
	
    /**  
     * 唯一自增ID
     */ 
    private Integer calId;

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
    
    private String stim;
    
    private String etim;

	private Integer uid;

	public Integer getUid() {
		return uid;
	}

	public void setUid(Integer uid) {
		this.uid = uid;
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

	public void setEtim(String etim) {
		this.etim = etim;
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
		this.userId = userId;
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
		this.calType = calType;
	}

	public String getCalLevel() {
		return calLevel;
	}

	public void setCalLevel(String calLevel) {
		this.calLevel = calLevel;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public String getOverStatus() {
		return overStatus;
	}

	public void setOverStatus(String overStatus) {
		this.overStatus = overStatus;
	}

	public String getBeforeRemaind() {
		return beforeRemaind;
	}

	public void setBeforeRemaind(String beforeRemaind) {
		this.beforeRemaind = beforeRemaind;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	public Integer getAllday() {
		return allday;
	}

	public void setAllday(Integer allday) {
		this.allday = allday;
	}

	public Integer getFromModule() {
		return fromModule;
	}

	public void setFromModule(Integer fromModule) {
		this.fromModule = fromModule;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getmId() {
		return mId;
	}

	public void setmId(Integer mId) {
		this.mId = mId;
	}

	public Integer getResId() {
		return resId;
	}

	public void setResId(Integer resId) {
		this.resId = resId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getTaker() {
		return taker;
	}

	public void setTaker(String taker) {
		this.taker = taker;
	}
    
    
    
}
