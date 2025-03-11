package com.xoa.model.attend;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 外出
 */
public class AttendOut  {
    /**
     * 唯一自增ID
     */
    private Integer outId;

    /**
     * 外出人
     */
    private String userId;
    /**
     * 外出人姓名
     */
    private String userName;

    /**
     * 审批人
     */
    private String leaderId;
    /**
     * 审批人姓名
     */
    private String leaderName;

    /**
     * 外出申请创建时间
     */
    private Date createDate;

    /**
     * 外出申请提交时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date submitTime;

    /**
     * 外出开始时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JSONField(format = "yyyy-MM-dd HH:mm")
    private String outTime1;

    /**
     * 外出结束时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JSONField(format = "yyyy-MM-dd HH:mm")
    private String outTime2;

    /**
     * 审批状态(0—待审批,1—已批准,2—未批准)
     */
    private String allow;

    /**
     * 确认状态(0—未确认,1—确认归来)
     */
    private String status;

    /**
     * 外出登记的IP
     */
    private String registerIp;

    /**
     * 请求处理时间
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
     * 外出原因
     */
    private String outType;

    /**
     * 不批准的原因
     */
    private String reason;

    /**
     * 流水号
     */
    private  Integer runId;

    private  String tableName;

    private String beginDate;//开始时间
    private String endDate;//结束时间


    private String flowId;//流程ID
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

    public Integer getOutId() {
        return outId;
    }

    public void setOutId(Integer outId) {
        this.outId = outId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getLeaderId() {
        return leaderId== null ? "" :leaderId;
}

    public void setLeaderId(String leaderId) {
        this.leaderId = leaderId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public String getOutTime1() {
        return outTime1;
    }

    public void setOutTime1(String outTime1) {
        this.outTime1 = outTime1;
    }

    public String getOutTime2() {
        return outTime2;
    }

    public void setOutTime2(String outTime2) {
        this.outTime2 = outTime2;
    }

    public String getAllow() {
        return allow;
    }

    public void setAllow(String allow) {
        this.allow = allow;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getOutType() {
        return outType==null?"":outType;
    }

    public void setOutType(String outType) {
        this.outType = outType;
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
    private String outTime;//外出时间

    public String getOutTime() {
        return outTime;
    }

    public void setOutTime(String outTime) {
        this.outTime = outTime;
    }
    /**
     * 请假人所在部门
     */
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