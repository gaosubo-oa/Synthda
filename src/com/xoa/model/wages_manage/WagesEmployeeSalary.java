package com.xoa.model.wages_manage;

import java.math.BigDecimal;

/**
 * @author 马东辉
 * @date 2021/11/29
 * @desc
 */
public class WagesEmployeeSalary {
    private Integer salaryId;//自增
    private String theYear;//年份
    private String theMonth;//月份
    private String userId;//user表USER_ID
    private String userName;//姓名
    private Integer deptId;//部门id（关联部门表）
    private String deptName;//单位（部门名称）
    private String idNumber;//身份证号
    private String jobNumber;//工号
    private String mobilNo;//手机号
    private Integer manageId;//薪岗(职务，关联岗位薪资设置表ID)
    private String manageIdName;
    private String exManageIdName;
    private BigDecimal jobRatio;//薪岗比例
    private Integer manageId2;//薪岗2(职务，关联岗位薪资设置表ID)
    private String manageId2Name;
    private String exManageId2Name;
    private BigDecimal jobRatio2;//薪岗2比例
    private Integer manageId3;//薪岗3(职务，关联岗位薪资设置表ID)
    private String manageId3Name;
    private String exManageId3Name;
    private BigDecimal jobRatio3;//薪岗3比例
    private String employmentForm;//用工形式(SYS_CODE)
    private String emplName;
    private String employmentCompany;//所属劳务公司
    private BigDecimal employmentCompanyBase;//劳务公司代发工资基数
    private BigDecimal assessmentProportion;//考核比例
    private String assessmentState;//考核类别(SYS_CODE)
    private String asserssName;
    private BigDecimal assessmentScore;//考核分
    private BigDecimal assessmentKeepSalary;//考核留存工资
    private BigDecimal publicTimePayment;//扣公休期间个人缴金部分
    private BigDecimal performancePay1;//绩效工资1
    private BigDecimal performancePay2;//绩效工资2
    private BigDecimal performancePay3;//绩效工资3
    private String remarks;//备注

    public String getTheYear() {
        return theYear;
    }

    public void setTheYear(String theYear) {
        this.theYear = theYear;
    }

    public String getTheMonth() {
        return theMonth;
    }

    public void setTheMonth(String theMonth) {
        this.theMonth = theMonth;
    }

    public String getExManageIdName() {
        return exManageIdName;
    }

    public void setExManageIdName(String exManageIdName) {
        this.exManageIdName = exManageIdName;
    }

    public String getExManageId2Name() {
        return exManageId2Name;
    }

    public void setExManageId2Name(String exManageId2Name) {
        this.exManageId2Name = exManageId2Name;
    }

    public String getExManageId3Name() {
        return exManageId3Name;
    }

    public void setExManageId3Name(String exManageId3Name) {
        this.exManageId3Name = exManageId3Name;
    }

    public String getEmplName() {
        return emplName;
    }

    public void setEmplName(String emplName) {
        this.emplName = emplName;
    }

    public String getAsserssName() {
        return asserssName;
    }

    public void setAsserssName(String asserssName) {
        this.asserssName = asserssName;
    }

    public Integer getSalaryId() {
        return salaryId;
    }

    public void setSalaryId(Integer salaryId) {
        this.salaryId = salaryId;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getManageId() {
        return manageId;
    }

    public void setManageId(Integer manageId) {
        this.manageId = manageId;
    }

    public Integer getManageId2() {
        return manageId2;
    }

    public void setManageId2(Integer manageId2) {
        this.manageId2 = manageId2;
    }

    public Integer getManageId3() {
        return manageId3;
    }

    public void setManageId3(Integer manageId3) {
        this.manageId3 = manageId3;
    }

    public String getManageIdName() {
        return manageIdName;
    }

    public void setManageIdName(String manageIdName) {
        this.manageIdName = manageIdName;
    }

    public String getManageId2Name() {
        return manageId2Name;
    }

    public void setManageId2Name(String manageId2Name) {
        this.manageId2Name = manageId2Name;
    }

    public String getManageId3Name() {
        return manageId3Name;
    }

    public void setManageId3Name(String manageId3Name) {
        this.manageId3Name = manageId3Name;
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

    public String getJobNumber() {
        return jobNumber;
    }

    public void setJobNumber(String jobNumber) {
        this.jobNumber = jobNumber;
    }

    public String getMobilNo() {
        return mobilNo;
    }

    public void setMobilNo(String mobilNo) {
        this.mobilNo = mobilNo;
    }


    public BigDecimal getJobRatio() {
        return jobRatio;
    }

    public void setJobRatio(BigDecimal jobRatio) {
        this.jobRatio = jobRatio;
    }


    public BigDecimal getJobRatio2() {
        return jobRatio2;
    }

    public void setJobRatio2(BigDecimal jobRatio2) {
        this.jobRatio2 = jobRatio2;
    }


    public BigDecimal getJobRatio3() {
        return jobRatio3;
    }

    public void setJobRatio3(BigDecimal jobRatio3) {
        this.jobRatio3 = jobRatio3;
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

    public BigDecimal getEmploymentCompanyBase() {
        return employmentCompanyBase;
    }

    public void setEmploymentCompanyBase(BigDecimal employmentCompanyBase) {
        this.employmentCompanyBase = employmentCompanyBase;
    }

    public BigDecimal getAssessmentProportion() {
        return assessmentProportion;
    }

    public void setAssessmentProportion(BigDecimal assessmentProportion) {
        this.assessmentProportion = assessmentProportion;
    }

    public String getAssessmentState() {
        return assessmentState;
    }

    public void setAssessmentState(String assessmentState) {
        this.assessmentState = assessmentState;
    }

    public BigDecimal getAssessmentScore() {
        return assessmentScore;
    }

    public void setAssessmentScore(BigDecimal assessmentScore) {
        this.assessmentScore = assessmentScore;
    }

    public BigDecimal getAssessmentKeepSalary() {
        return assessmentKeepSalary;
    }

    public void setAssessmentKeepSalary(BigDecimal assessmentKeepSalary) {
        this.assessmentKeepSalary = assessmentKeepSalary;
    }

    public BigDecimal getPublicTimePayment() {
        return publicTimePayment;
    }

    public void setPublicTimePayment(BigDecimal publicTimePayment) {
        this.publicTimePayment = publicTimePayment;
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
