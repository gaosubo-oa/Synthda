package com.xoa.model.attend;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 请假
 */
public class AttendLeave  {
    /**
     * 请假登记ID
     */
    private Integer leaveId;

    /**
     * 请假人
     */
    private String userId;
    /**
     * 请假人姓名
     */
    private String userName;
    /**
     * 请假人所在部门
     */
    private String deptName;

    /**
     * 审批人
     */
    private String leaderId;
    /**
     * 审批人姓名
     */
    private String leaderName;
    /**
     * 请假开始时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date leaveDate1;

    private String  leavesDate1;

    /**
     * 请假结束时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date leaveDate2;

    private  String leavesDate2;

    /**
     * 占用年休假时间
     */
    private BigDecimal annualLeave;

    /**
     * 确认状态(1—未确认,2—确认销假)
     */
    private String status;

    /**
     * 审批状态(0—待审批,1—已批准,2—未批准,3—申请销假)
     */
    private String allow;

    /**
     * 销假时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date destroyTime;

    /**
     * 登记IP
     */
    private String registerIp;

    /**
     * 请假登录时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date recordTime;

    /**
     * 请假类型(1—事假,2—病假,3—年假,9—其他)
     */
    private String leaveType2;

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
     * 排序号
     */
    private Integer orderNo;

    /**
     * 请假原因
     */
    private String leaveType;

    /**
     * 审批不通过的原因
     */
    private String reason;
    /**
     * 流水号
     */
    private  Integer runId;

    private String runName;

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
    }

    private  String  tableName;
    private String columnName;//数据字段
    private String columnComment;//数据字段注释

    private String beginDate;//开始时间
    private String endDate;//结束时间

    private String flowId;//流程ID
    private  String flowPrcs;
    private  String prcsId;
    private  String flowName;
    private  String monthname;
    private  Integer id;

    private String number;//请假天数

    public void setNumber(String number) {
        this.number = number;
    }

    public String getNumber() {
        return number;
    }

    public void setLeavesDate1(String leavesDate1) {
        this.leavesDate1 = leavesDate1;
    }

    public void setLeavesDate2(String leavesDate2) {
        this.leavesDate2 = leavesDate2;
    }

    public String getLeavesDate1() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd mm:HH:ss");
        if (leaveDate1 != null) {
            return leavesDate1 = sdf.format(leaveDate1);
        } else {
            return "";
        }
    }
    public String getLeavesDate2() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd mm:HH:ss");
        if (leaveDate2 != null) {
            return leavesDate2 = sdf.format(leaveDate2);
        } else {
            return "";
        }
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMonthname() {
        return monthname;
    }

    public void setMonthname(String monthname) {
        this.monthname = monthname;
    }

    public String getFlowName() {
        return flowName;
    }

    public void setFlowName(String flowName) {
        this.flowName = flowName;
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


    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
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

    public String getColumnName() {
        return columnName ;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public void setColumnComment(String columnComment) {
        this.columnComment = columnComment;
    }

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLeaderId() {
        return leaderId==null?"":leaderId;
    }

    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId;
    }

    public Date getLeaveDate1() {
        return leaveDate1;
    }

    public void setLeaveDate1(Date leaveDate1) {
        this.leaveDate1 = leaveDate1;
    }

    public Date getLeaveDate2() {
        return leaveDate2;
    }

    public void setLeaveDate2(Date leaveDate2) {
        this.leaveDate2 = leaveDate2;
    }

    public BigDecimal getAnnualLeave() {
        return annualLeave;
    }

    public void setAnnualLeave(BigDecimal annualLeave) {
        this.annualLeave = annualLeave;
    }

    public String getStatus() {
        return status==null?"":status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAllow() {
        return allow==null?"":allow;
    }

    public void setAllow(String allow) {
        this.allow = allow;
    }

    public Date getDestroyTime() {
        return destroyTime;
    }

    public void setDestroyTime(Date destroyTime) {
        this.destroyTime = destroyTime;
    }

    public String getRegisterIp() {
        return registerIp;
    }

    public void setRegisterIp(String registerIp) {
        this.registerIp = registerIp;
    }

    public Date getRecordTime() {
        return recordTime;
    }

    public void setRecordTime(Date recordTime) {
        this.recordTime = recordTime;
    }

    public String getLeaveType2() {
        return leaveType2==null?"":leaveType2;
    }

    public void setLeaveType2(String leaveType2) {
        this.leaveType2 = leaveType2;
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
        return orderNo==null?0:orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getLeaveType() {
        return leaveType==null?"":leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getReason() {
        return reason==null?"":reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

    private String leaveTime;//请假时间

    public String getLeaveTime() {
        return leaveTime;
    }

    public void setLeaveTime(String leaveTime) {
        this.leaveTime = leaveTime;
    }

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