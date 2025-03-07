package com.xoa.model.attend;

import java.util.Date;

/**
 *加班
 */
public class AttendanceOvertime {
    /**
     * 自增字段
     */
    private Integer overtimeId;

    /**
     * 用户名
     */
    private String userId;

    /**
     * 审批人
     */
    private String approveId;

    /**
     * 登记时间
     */
    private Date recordTime;

    /**
     * 加班开始时间
     */
    private Date startTime;

    /**
     * 加班结束时间
     */
    private Date endTime;

    /**
     * 加班时长
     */
    private String overtimeHours;

    /**
     * 确认时间
     */
    private Date confirmTime;

    /**
     * 审批状态(0—待审批,1—已批准,2—未批准,3—待确认)
     */
    private String allow;

    /**
     * 确认状态(0—未确认,1—已确认)
     */
    private String status;

    /**
     * 登记IP
     */
    private String registerIp;

    /**
     * 请求处理时间
     */
    private Date handleTime;

    /**
     * 创建人
     */
    private String agent;

    /**
     * 排序号
     */
    private Integer orderNo;
    /**
     * 加班内容
     */
    private String overtimeContent;

    /**
     * 确认意见
     */
    private String confirmView;

    /**
     * 不准原因
     */
    private String reason;
    /**
     * 流水号
     */
    private  Integer runId;

    private  String tableName;

    private  String flowId;
    private  String flowPrcs;
    private  String prcsId;

    private  String flowName;
    private  Integer id;
    private String runName;

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
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

    public String getFlowName() {
        return flowName;
    }

    public void setFlowName(String flowName) {
        this.flowName = flowName;
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

    public Integer getOvertimeId() {
        return overtimeId;
    }

    public void setOvertimeId(Integer overtimeId) {
        this.overtimeId = overtimeId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getApproveId() {
        return approveId==null?"":approveId;
    }

    public void setApproveId(String approveId) {
        this.approveId = approveId;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getOvertimeHours() {
        return overtimeHours==null?"":overtimeHours;
    }

    public void setOvertimeHours(String overtimeHours) {
        this.overtimeHours = overtimeHours;
    }

    public Date getConfirmTime() {
        return confirmTime;
    }

    public void setConfirmTime(Date confirmTime) {
        this.confirmTime = confirmTime;
    }

    public String getAllow() {
        return allow==null?"":allow;
    }

    public void setAllow(String allow) {
        this.allow = allow;
    }

    public String getStatus() {
        return status==null?"":status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRegisterIp() {
        return registerIp==null?"":registerIp;
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

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getOvertimeContent() {
        return overtimeContent==null?"":overtimeContent;
    }

    public void setOvertimeContent(String overtimeContent) {
        this.overtimeContent = overtimeContent;
    }

    public String getConfirmView() {
        return confirmView==null?"":confirmView;
    }

    public void setConfirmView(String confirmView) {
        this.confirmView = confirmView;
    }

    public String getReason() {
        return reason==null?"":reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    private String userName;
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    private String deptName;
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getDeptName() {
        return deptName;
    }

    private String overTime;
    public void setOverTime(String overTime) {
        this.overTime = overTime;
    }

    public String getOverTime() {
        return overTime;
    }
}