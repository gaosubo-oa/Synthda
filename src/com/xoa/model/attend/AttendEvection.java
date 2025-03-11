package com.xoa.model.attend;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 出差
 */
public class AttendEvection {
    /**
     * 出差登记ID
     */
    private Integer evectionId;

    /**
     * 出差人
     */
    private String userId;
    /**
     * 出差人姓名
     */
    private  String userName;
    /**
     * 出差地点
     */
    private String evectionDest;

    /**
     * 出差开始时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JSONField(format = "yyyy-MM-dd HH:mm")
    private Date evectionDate1;

    /**
     * 出差结束时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JSONField(format = "yyyy-MM-dd HH:mm")
    private Date evectionDate2;

    /**
     * 确认状态(1—未确认,2—已确认)
     */
    private String status;

    /**
     * 审批人
     */
    private String leaderId;

    /**
     * 审批人姓名
     */
    private String leaderName;
    /**
     * 审批状态(0—待审批,1—已批准,2—未批准)
     */
    private String allow;

    /**
     * 登记IP
     */
    private String registerIp;

    /**
     * 处理时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date handleTime;

    /**
     * 创建人
     */
    private String agent;

    /**
     * 登记时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date recordTime;

    /**
     * 排序号
     */
    private Integer orderNo;

    /**
     *出差时间
     */
    private String evecDays;

    /**
     * 出差原因
     */
    private String reason;

    /**
     * 不准的原因
     */
    private String notReason;

    /**
     * 流水号
     */
    private  Integer runId;

    private  String tableName;

    private String beginDate;//开始时间
    private String endDate;//结束时间

    private  String flowId;
    private  String flowPrcs;
    private  String prcsId;

    private  String flowName;
    private String runName;

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
    }

    public String getFlowName() {
        return flowName;
    }

    public void setFlowName(String flowName) {
        this.flowName = flowName;
    }

    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getFlowPrcs() {
        return flowPrcs;
    }

    public void setFlowPrcs(String flowPrcs) {
        this.flowPrcs = flowPrcs;
    }

    public String getPrcsId() {
        return prcsId;
    }

    public void setPrcsId(String prcsId) {
        this.prcsId = prcsId;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public Integer getRunId() {
        return runId;
    }

    public void setRunId(Integer runId) {
        this.runId = runId;
    }

    public Integer getEvectionId() {
        return evectionId;
    }

    public void setEvectionId(Integer evectionId) {
        this.evectionId = evectionId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getEvectionDest() {
        return evectionDest;
    }

    public void setEvectionDest(String evectionDest) {
        this.evectionDest = evectionDest;
    }

    public Date getEvectionDate1() {
        return evectionDate1;
    }

    public void setEvectionDate1(Date evectionDate1) {
        this.evectionDate1 = evectionDate1;
    }

    public Date getEvectionDate2() {
        return evectionDate2;
    }

    public void setEvectionDate2(Date evectionDate2) {
        this.evectionDate2 = evectionDate2;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLeaderId() {
        return leaderId== null ? "" :leaderId;
    }

    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId;
    }

    public String getAllow() {
        return allow;
    }

    public void setAllow(String allow) {
        this.allow = allow;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp;
    }

    public Date getHandleTime() {
        return handleTime;
    }

    public void setHandleTime(Date handleTime) {
        this.handleTime = handleTime;
    }

    public String getAgent() {
        return agent==null?"":agent;
    }

    public void setAgent(String agent) {
        this.agent = agent;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getEvecDays() {
        return evecDays==null?"":evecDays;
    }

    public void setEvecDays(String evecDays) {
        this.evecDays = evecDays;
    }

    public String getReason() {
        return reason==null?"":reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getNotReason() {
        return notReason==null?"":notReason;
    }

    public void setNotReason(String notReason) {
        this.notReason = notReason;
    }

    public String getUserName() {
        return userName==null?"":userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLeaderName() {
        return leaderName==null?"":leaderName;
    }

    public void setLeaderName(String leaderName) {
        this.leaderName = leaderName;
    }
    private String evectionTime;

    public String getEvectionTime() {
        return evectionTime;
    }

    public void setEvectionTime(String evectionTime) {
        this.evectionTime = evectionTime;
    }

    private String deptName;
    public String getDeptName() {
        return deptName==null?"":deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
    private Integer uid;
    private String avatar;

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }
}