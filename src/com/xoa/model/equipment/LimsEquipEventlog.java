package com.xoa.model.equipment;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LimsEquipEventlog {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EVENT_LOG_ID
     *
     * @mbggenerated
     */
    private Integer eventLogId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EVENT_ID
     *
     * @mbggenerated
     */
    private Integer eventId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_EVENT_TYPE
     *
     * @mbggenerated
     */
    private String equipEventType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_ID
     *
     * @mbggenerated
     */
    private Integer equipId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.DEPT_ID
     *
     * @mbggenerated
     */
    private Integer deptId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_NAME
     *
     * @mbggenerated
     */
    private String equipName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_STATUS
     *
     * @mbggenerated
     */
    private String equipStatus;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_NO
     *
     * @mbggenerated
     */
    private String equipNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.FACTORY_NO
     *
     * @mbggenerated
     */
    private String factoryNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.MODEL_NO
     *
     * @mbggenerated
     */
    private String modelNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.FREQUENCY
     *
     * @mbggenerated
     */
    private String frequency;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EXE_TIME
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date exeTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EXPIRE_DATE
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date expireDate;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.COMPANY
     *
     * @mbggenerated
     */
    private String company;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CERT_NO
     *
     * @mbggenerated
     */
    private Integer certNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_INTEGRITY
     *
     * @mbggenerated
     */
    private String concluIntegrity;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_RANGE
     *
     * @mbggenerated
     */
    private String concluRange;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_RESULT
     *
     * @mbggenerated
     */
    private String concluResult;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_USER
     *
     * @mbggenerated
     */
    private String concluUser;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_USDESIRE
     *
     * @mbggenerated
     */
    private String concluUsdesire;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.CONCLU_ADDTIME
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date concluAddtime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.AUDITMIND
     *
     * @mbggenerated
     */
    private String auditmind;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.APPROVER
     *
     * @mbggenerated
     */
    private String approver;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.APPROVER_TIME
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date approverTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.MEMO
     *
     * @mbggenerated
     */
    private String memo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.WORKFLOW_NO
     *
     * @mbggenerated
     */
    private String workflowNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.IDENT_TYPE
     *
     * @mbggenerated
     */
    private String identType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.GRANT_USER
     *
     * @mbggenerated
     */
    private String grantUser;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.GRANT_TIME
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date grantTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.RECEIVE_USER
     *
     * @mbggenerated
     */
    private String receiveUser;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.RECEIVE_TIME
     *
     * @mbggenerated
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date receiveTime;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.EQUIP_TYPE_ID
     *
     * @mbggenerated
     */
    private Integer equipTypeId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column lims_equip_eventlog.USED_EQUIP
     *
     * @mbggenerated
     */
    private String usedEquip;

    private String columnName;

    private String inputValue;

    private String deptName;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EVENT_LOG_ID
     *
     * @return the value of lims_equip_eventlog.EVENT_LOG_ID
     *
     * @mbggenerated
     */
    public Integer getEventLogId() {
        return eventLogId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EVENT_LOG_ID
     *
     * @param eventLogId the value for lims_equip_eventlog.EVENT_LOG_ID
     *
     * @mbggenerated
     */
    public void setEventLogId(Integer eventLogId) {
        this.eventLogId = eventLogId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EVENT_ID
     *
     * @return the value of lims_equip_eventlog.EVENT_ID
     *
     * @mbggenerated
     */
    public Integer getEventId() {
        return eventId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EVENT_ID
     *
     * @param eventId the value for lims_equip_eventlog.EVENT_ID
     *
     * @mbggenerated
     */
    public void setEventId(Integer eventId) {
        this.eventId = eventId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_EVENT_TYPE
     *
     * @return the value of lims_equip_eventlog.EQUIP_EVENT_TYPE
     *
     * @mbggenerated
     */
    public String getEquipEventType() {
        return equipEventType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_EVENT_TYPE
     *
     * @param equipEventType the value for lims_equip_eventlog.EQUIP_EVENT_TYPE
     *
     * @mbggenerated
     */
    public void setEquipEventType(String equipEventType) {
        this.equipEventType = equipEventType == null ? null : equipEventType.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_ID
     *
     * @return the value of lims_equip_eventlog.EQUIP_ID
     *
     * @mbggenerated
     */
    public Integer getEquipId() {
        return equipId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_ID
     *
     * @param equipId the value for lims_equip_eventlog.EQUIP_ID
     *
     * @mbggenerated
     */
    public void setEquipId(Integer equipId) {
        this.equipId = equipId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.DEPT_ID
     *
     * @return the value of lims_equip_eventlog.DEPT_ID
     *
     * @mbggenerated
     */
    public Integer getDeptId() {
        return deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.DEPT_ID
     *
     * @param deptId the value for lims_equip_eventlog.DEPT_ID
     *
     * @mbggenerated
     */
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_NAME
     *
     * @return the value of lims_equip_eventlog.EQUIP_NAME
     *
     * @mbggenerated
     */
    public String getEquipName() {
        return equipName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_NAME
     *
     * @param equipName the value for lims_equip_eventlog.EQUIP_NAME
     *
     * @mbggenerated
     */
    public void setEquipName(String equipName) {
        this.equipName = equipName == null ? null : equipName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_STATUS
     *
     * @return the value of lims_equip_eventlog.EQUIP_STATUS
     *
     * @mbggenerated
     */
    public String getEquipStatus() {
        return equipStatus;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_STATUS
     *
     * @param equipStatus the value for lims_equip_eventlog.EQUIP_STATUS
     *
     * @mbggenerated
     */
    public void setEquipStatus(String equipStatus) {
        this.equipStatus = equipStatus == null ? null : equipStatus.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_NO
     *
     * @return the value of lims_equip_eventlog.EQUIP_NO
     *
     * @mbggenerated
     */
    public String getEquipNo() {
        return equipNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_NO
     *
     * @param equipNo the value for lims_equip_eventlog.EQUIP_NO
     *
     * @mbggenerated
     */
    public void setEquipNo(String equipNo) {
        this.equipNo = equipNo == null ? null : equipNo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.FACTORY_NO
     *
     * @return the value of lims_equip_eventlog.FACTORY_NO
     *
     * @mbggenerated
     */
    public String getFactoryNo() {
        return factoryNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.FACTORY_NO
     *
     * @param factoryNo the value for lims_equip_eventlog.FACTORY_NO
     *
     * @mbggenerated
     */
    public void setFactoryNo(String factoryNo) {
        this.factoryNo = factoryNo == null ? null : factoryNo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.MODEL_NO
     *
     * @return the value of lims_equip_eventlog.MODEL_NO
     *
     * @mbggenerated
     */
    public String getModelNo() {
        return modelNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.MODEL_NO
     *
     * @param modelNo the value for lims_equip_eventlog.MODEL_NO
     *
     * @mbggenerated
     */
    public void setModelNo(String modelNo) {
        this.modelNo = modelNo == null ? null : modelNo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.FREQUENCY
     *
     * @return the value of lims_equip_eventlog.FREQUENCY
     *
     * @mbggenerated
     */
    public String getFrequency() {
        return frequency;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.FREQUENCY
     *
     * @param frequency the value for lims_equip_eventlog.FREQUENCY
     *
     * @mbggenerated
     */
    public void setFrequency(String frequency) {
        this.frequency = frequency == null ? null : frequency.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EXE_TIME
     *
     * @return the value of lims_equip_eventlog.EXE_TIME
     *
     * @mbggenerated
     */
    public Date getExeTime() {
        return exeTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EXE_TIME
     *
     * @param exeTime the value for lims_equip_eventlog.EXE_TIME
     *
     * @mbggenerated
     */
    public void setExeTime(Date exeTime) {
        this.exeTime = exeTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EXPIRE_DATE
     *
     * @return the value of lims_equip_eventlog.EXPIRE_DATE
     *
     * @mbggenerated
     */
    public Date getExpireDate() {
        return expireDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EXPIRE_DATE
     *
     * @param expireDate the value for lims_equip_eventlog.EXPIRE_DATE
     *
     * @mbggenerated
     */
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.COMPANY
     *
     * @return the value of lims_equip_eventlog.COMPANY
     *
     * @mbggenerated
     */
    public String getCompany() {
        return company;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.COMPANY
     *
     * @param company the value for lims_equip_eventlog.COMPANY
     *
     * @mbggenerated
     */
    public void setCompany(String company) {
        this.company = company == null ? null : company.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CERT_NO
     *
     * @return the value of lims_equip_eventlog.CERT_NO
     *
     * @mbggenerated
     */
    public Integer getCertNo() {
        return certNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CERT_NO
     *
     * @param certNo the value for lims_equip_eventlog.CERT_NO
     *
     * @mbggenerated
     */
    public void setCertNo(Integer certNo) {
        this.certNo = certNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_INTEGRITY
     *
     * @return the value of lims_equip_eventlog.CONCLU_INTEGRITY
     *
     * @mbggenerated
     */
    public String getConcluIntegrity() {
        return concluIntegrity;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_INTEGRITY
     *
     * @param concluIntegrity the value for lims_equip_eventlog.CONCLU_INTEGRITY
     *
     * @mbggenerated
     */
    public void setConcluIntegrity(String concluIntegrity) {
        this.concluIntegrity = concluIntegrity == null ? null : concluIntegrity.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_RANGE
     *
     * @return the value of lims_equip_eventlog.CONCLU_RANGE
     *
     * @mbggenerated
     */
    public String getConcluRange() {
        return concluRange;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_RANGE
     *
     * @param concluRange the value for lims_equip_eventlog.CONCLU_RANGE
     *
     * @mbggenerated
     */
    public void setConcluRange(String concluRange) {
        this.concluRange = concluRange == null ? null : concluRange.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_RESULT
     *
     * @return the value of lims_equip_eventlog.CONCLU_RESULT
     *
     * @mbggenerated
     */
    public String getConcluResult() {
        return concluResult;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_RESULT
     *
     * @param concluResult the value for lims_equip_eventlog.CONCLU_RESULT
     *
     * @mbggenerated
     */
    public void setConcluResult(String concluResult) {
        this.concluResult = concluResult == null ? null : concluResult.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_USER
     *
     * @return the value of lims_equip_eventlog.CONCLU_USER
     *
     * @mbggenerated
     */
    public String getConcluUser() {
        return concluUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_USER
     *
     * @param concluUser the value for lims_equip_eventlog.CONCLU_USER
     *
     * @mbggenerated
     */
    public void setConcluUser(String concluUser) {
        this.concluUser = concluUser == null ? null : concluUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_USDESIRE
     *
     * @return the value of lims_equip_eventlog.CONCLU_USDESIRE
     *
     * @mbggenerated
     */
    public String getConcluUsdesire() {
        return concluUsdesire;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_USDESIRE
     *
     * @param concluUsdesire the value for lims_equip_eventlog.CONCLU_USDESIRE
     *
     * @mbggenerated
     */
    public void setConcluUsdesire(String concluUsdesire) {
        this.concluUsdesire = concluUsdesire == null ? null : concluUsdesire.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.CONCLU_ADDTIME
     *
     * @return the value of lims_equip_eventlog.CONCLU_ADDTIME
     *
     * @mbggenerated
     */
    public Date getConcluAddtime() {
        return concluAddtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.CONCLU_ADDTIME
     *
     * @param concluAddtime the value for lims_equip_eventlog.CONCLU_ADDTIME
     *
     * @mbggenerated
     */
    public void setConcluAddtime(Date concluAddtime) {
        this.concluAddtime = concluAddtime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.AUDITMIND
     *
     * @return the value of lims_equip_eventlog.AUDITMIND
     *
     * @mbggenerated
     */
    public String getAuditmind() {
        return auditmind;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.AUDITMIND
     *
     * @param auditmind the value for lims_equip_eventlog.AUDITMIND
     *
     * @mbggenerated
     */
    public void setAuditmind(String auditmind) {
        this.auditmind = auditmind == null ? null : auditmind.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.APPROVER
     *
     * @return the value of lims_equip_eventlog.APPROVER
     *
     * @mbggenerated
     */
    public String getApprover() {
        return approver;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.APPROVER
     *
     * @param approver the value for lims_equip_eventlog.APPROVER
     *
     * @mbggenerated
     */
    public void setApprover(String approver) {
        this.approver = approver == null ? null : approver.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.APPROVER_TIME
     *
     * @return the value of lims_equip_eventlog.APPROVER_TIME
     *
     * @mbggenerated
     */
    public Date getApproverTime() {
        return approverTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.APPROVER_TIME
     *
     * @param approverTime the value for lims_equip_eventlog.APPROVER_TIME
     *
     * @mbggenerated
     */
    public void setApproverTime(Date approverTime) {
        this.approverTime = approverTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.MEMO
     *
     * @return the value of lims_equip_eventlog.MEMO
     *
     * @mbggenerated
     */
    public String getMemo() {
        return memo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.MEMO
     *
     * @param memo the value for lims_equip_eventlog.MEMO
     *
     * @mbggenerated
     */
    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.WORKFLOW_NO
     *
     * @return the value of lims_equip_eventlog.WORKFLOW_NO
     *
     * @mbggenerated
     */
    public String getWorkflowNo() {
        return workflowNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.WORKFLOW_NO
     *
     * @param workflowNo the value for lims_equip_eventlog.WORKFLOW_NO
     *
     * @mbggenerated
     */
    public void setWorkflowNo(String workflowNo) {
        this.workflowNo = workflowNo == null ? null : workflowNo.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.IDENT_TYPE
     *
     * @return the value of lims_equip_eventlog.IDENT_TYPE
     *
     * @mbggenerated
     */
    public String getIdentType() {
        return identType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.IDENT_TYPE
     *
     * @param identType the value for lims_equip_eventlog.IDENT_TYPE
     *
     * @mbggenerated
     */
    public void setIdentType(String identType) {
        this.identType = identType == null ? null : identType.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.GRANT_USER
     *
     * @return the value of lims_equip_eventlog.GRANT_USER
     *
     * @mbggenerated
     */
    public String getGrantUser() {
        return grantUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.GRANT_USER
     *
     * @param grantUser the value for lims_equip_eventlog.GRANT_USER
     *
     * @mbggenerated
     */
    public void setGrantUser(String grantUser) {
        this.grantUser = grantUser == null ? null : grantUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.GRANT_TIME
     *
     * @return the value of lims_equip_eventlog.GRANT_TIME
     *
     * @mbggenerated
     */
    public Date getGrantTime() {
        return grantTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.GRANT_TIME
     *
     * @param grantTime the value for lims_equip_eventlog.GRANT_TIME
     *
     * @mbggenerated
     */
    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.RECEIVE_USER
     *
     * @return the value of lims_equip_eventlog.RECEIVE_USER
     *
     * @mbggenerated
     */
    public String getReceiveUser() {
        return receiveUser;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.RECEIVE_USER
     *
     * @param receiveUser the value for lims_equip_eventlog.RECEIVE_USER
     *
     * @mbggenerated
     */
    public void setReceiveUser(String receiveUser) {
        this.receiveUser = receiveUser == null ? null : receiveUser.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.RECEIVE_TIME
     *
     * @return the value of lims_equip_eventlog.RECEIVE_TIME
     *
     * @mbggenerated
     */
    public Date getReceiveTime() {
        return receiveTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.RECEIVE_TIME
     *
     * @param receiveTime the value for lims_equip_eventlog.RECEIVE_TIME
     *
     * @mbggenerated
     */
    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.EQUIP_TYPE_ID
     *
     * @return the value of lims_equip_eventlog.EQUIP_TYPE_ID
     *
     * @mbggenerated
     */
    public Integer getEquipTypeId() {
        return equipTypeId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.EQUIP_TYPE_ID
     *
     * @param equipTypeId the value for lims_equip_eventlog.EQUIP_TYPE_ID
     *
     * @mbggenerated
     */
    public void setEquipTypeId(Integer equipTypeId) {
        this.equipTypeId = equipTypeId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column lims_equip_eventlog.USED_EQUIP
     *
     * @return the value of lims_equip_eventlog.USED_EQUIP
     *
     * @mbggenerated
     */
    public String getUsedEquip() {
        return usedEquip;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column lims_equip_eventlog.USED_EQUIP
     *
     * @param usedEquip the value for lims_equip_eventlog.USED_EQUIP
     *
     * @mbggenerated
     */
    public void setUsedEquip(String usedEquip) {
        this.usedEquip = usedEquip == null ? null : usedEquip.trim();
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getInputValue() {
        return inputValue;
    }

    public void setInputValue(String inputValue) {
        this.inputValue = inputValue;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}