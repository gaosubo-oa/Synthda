package com.xoa.model.wages_manage;

import java.math.BigDecimal;

/**
 * @author 马东辉
 * @date 2021/11/25
 * @desc  薪资数据
 */
public class WagesSalaryData {
    private Integer salaryDataId;//薪资数据ID
    private String userId;//user表USER_ID
    private String userName;//姓名
    private Integer deptId;//关联部门表
    private String deptName;//部门名称
    private String idNumber;//身份证号
    private String dataYear;//年份
    private String dataMonth;//月份
    private Integer jobManageId;//薪岗
    private  String manageIdName;
    private BigDecimal jobRatio;//薪岗比例
    private BigDecimal seaGoingPerformance;//出海绩效
    private BigDecimal floatPay;//浮动工资
    private BigDecimal basePay;//基本工资
    private BigDecimal jobPay;//机关岗位工资
    private BigDecimal other1;//其他1
    private BigDecimal other2;//其他2
    private Integer onSiteWork;//现场上班
    private Integer jobWork;//机关上班
    private Integer rest;//休息
    private Integer totalAttendance;//出勤合计
    private BigDecimal onSiteWorkPay;//现场上班工资
    private BigDecimal jobWorkPay;//机关上班工资
    private BigDecimal restPay;//休息工资
    private String assessmentType;//考核类别(SYS_CODE)
    private String assessmentName;
    private BigDecimal assessmentRatio;//考核比例
    private BigDecimal assessmentRetained;//考核留存工资
    private BigDecimal assessmentScore;//考核分
    private BigDecimal deductAssessmentPay;//扣考核工资
    private BigDecimal actuaiAssessmentPay;//实发考核工资
    private BigDecimal deductShippingBusiness;//扣船务公司发放部分
    private BigDecimal deductPublicHoliday;//扣公休期间个人缴金部分
    private BigDecimal actualJobPay;//应发岗位工资
    private String employmentForm;//用工形式(SYS_CODE)
    private String emplName;
    private String employmentCompany;//所属劳务公司
    private BigDecimal performancePay1;//绩效工资1
    private BigDecimal performancePay2;//绩效工资2
    private BigDecimal performancePay3;//绩效工资3
    private String ackStatus;//确认状态(0-待确认，1-已确认)
    private String remarks;//备注

     private  String jobNumber;//工号

    public String getAssessmentName() {
        return assessmentName;
    }

    public void setAssessmentName(String assessmentName) {
        this.assessmentName = assessmentName;
    }

    public String getEmplName() {
        return emplName;
    }

    public void setEmplName(String emplName) {
        this.emplName = emplName;
    }

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public String getManageIdName() {
        return manageIdName;
    }

    public void setManageIdName(String manageIdName) {
        this.manageIdName = manageIdName;
    }

    public Integer getSalaryDataId() {
        return salaryDataId;
    }

    public void setSalaryDataId(Integer salaryDataId) {
        this.salaryDataId = salaryDataId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getDataYear() {
        return dataYear;
    }

    public void setDataYear(String dataYear) {
        this.dataYear = dataYear;
    }

    public String getDataMonth() {
        return dataMonth;
    }

    public void setDataMonth(String dataMonth) {
        this.dataMonth = dataMonth;
    }

    public Integer getJobManageId() {
        return jobManageId;
    }

    public void setJobManageId(Integer jobManageId) {
        this.jobManageId = jobManageId;
    }

    public String getAckStatus() {
        return ackStatus;
    }

    public void setAckStatus(String ackStatus) {
        this.ackStatus = ackStatus;
    }

    public BigDecimal getJobRatio() {
        return jobRatio;
    }

    public void setJobRatio(BigDecimal jobRatio) {
        this.jobRatio = jobRatio;
    }

    public BigDecimal getSeaGoingPerformance() {
        return seaGoingPerformance;
    }

    public void setSeaGoingPerformance(BigDecimal seaGoingPerformance) {
        this.seaGoingPerformance = seaGoingPerformance;
    }

    public BigDecimal getFloatPay() {
        return floatPay;
    }

    public void setFloatPay(BigDecimal floatPay) {
        this.floatPay = floatPay;
    }

    public BigDecimal getBasePay() {
        return basePay;
    }

    public void setBasePay(BigDecimal basePay) {
        this.basePay = basePay;
    }

    public BigDecimal getJobPay() {
        return jobPay;
    }

    public void setJobPay(BigDecimal jobPay) {
        this.jobPay = jobPay;
    }

    public BigDecimal getOther1() {
        return other1;
    }

    public void setOther1(BigDecimal other1) {
        this.other1 = other1;
    }

    public BigDecimal getOther2() {
        return other2;
    }

    public void setOther2(BigDecimal other2) {
        this.other2 = other2;
    }

    public Integer getOnSiteWork() {
        return onSiteWork;
    }

    public void setOnSiteWork(Integer onSiteWork) {
        this.onSiteWork = onSiteWork;
    }

    public Integer getJobWork() {
        return jobWork;
    }

    public void setJobWork(Integer jobWork) {
        this.jobWork = jobWork;
    }

    public Integer getRest() {
        return rest;
    }

    public void setRest(Integer rest) {
        this.rest = rest;
    }

    public Integer getTotalAttendance() {
        return totalAttendance;
    }

    public void setTotalAttendance(Integer totalAttendance) {
        this.totalAttendance = totalAttendance;
    }

    public BigDecimal getOnSiteWorkPay() {
        return onSiteWorkPay;
    }

    public void setOnSiteWorkPay(BigDecimal onSiteWorkPay) {
        this.onSiteWorkPay = onSiteWorkPay;
    }

    public BigDecimal getJobWorkPay() {
        return jobWorkPay;
    }

    public void setJobWorkPay(BigDecimal jobWorkPay) {
        this.jobWorkPay = jobWorkPay;
    }

    public BigDecimal getRestPay() {
        return restPay;
    }

    public void setRestPay(BigDecimal restPay) {
        this.restPay = restPay;
    }

    public String getAssessmentType() {
        return assessmentType;
    }

    public void setAssessmentType(String assessmentType) {
        this.assessmentType = assessmentType;
    }

    public BigDecimal getAssessmentRatio() {
        return assessmentRatio;
    }

    public void setAssessmentRatio(BigDecimal assessmentRatio) {
        this.assessmentRatio = assessmentRatio;
    }

    public BigDecimal getAssessmentRetained() {
        return assessmentRetained;
    }

    public void setAssessmentRetained(BigDecimal assessmentRetained) {
        this.assessmentRetained = assessmentRetained;
    }

    public BigDecimal getAssessmentScore() {
        return assessmentScore;
    }

    public void setAssessmentScore(BigDecimal assessmentScore) {
        this.assessmentScore = assessmentScore;
    }

    public BigDecimal getDeductAssessmentPay() {
        return deductAssessmentPay;
    }

    public void setDeductAssessmentPay(BigDecimal deductAssessmentPay) {
        this.deductAssessmentPay = deductAssessmentPay;
    }

    public BigDecimal getActuaiAssessmentPay() {
        return actuaiAssessmentPay;
    }

    public void setActuaiAssessmentPay(BigDecimal actuaiAssessmentPay) {
        this.actuaiAssessmentPay = actuaiAssessmentPay;
    }

    public BigDecimal getDeductShippingBusiness() {
        return deductShippingBusiness;
    }

    public void setDeductShippingBusiness(BigDecimal deductShippingBusiness) {
        this.deductShippingBusiness = deductShippingBusiness;
    }

    public BigDecimal getDeductPublicHoliday() {
        return deductPublicHoliday;
    }

    public void setDeductPublicHoliday(BigDecimal deductPublicHoliday) {
        this.deductPublicHoliday = deductPublicHoliday;
    }

    public BigDecimal getActualJobPay() {
        return actualJobPay;
    }

    public void setActualJobPay(BigDecimal actualJobPay) {
        this.actualJobPay = actualJobPay;
    }

    public String getEmploymentForm() {
        return employmentForm;
    }

    public void setEmploymentForm(String employmentForm) {
        this.employmentForm = employmentForm;
    }

    public String getEmploymentCompany() {
        return employmentCompany;
    }

    public void setEmploymentCompany(String employmentCompany) {
        this.employmentCompany = employmentCompany;
    }

    public BigDecimal getPerformancePay1() {
        return performancePay1;
    }

    public void setPerformancePay1(BigDecimal performancePay1) {
        this.performancePay1 = performancePay1;
    }

    public BigDecimal getPerformancePay2() {
        return performancePay2;
    }

    public void setPerformancePay2(BigDecimal performancePay2) {
        this.performancePay2 = performancePay2;
    }

    public BigDecimal getPerformancePay3() {
        return performancePay3;
    }

    public void setPerformancePay3(BigDecimal performancePay3) {
        this.performancePay3 = performancePay3;
    }


    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
