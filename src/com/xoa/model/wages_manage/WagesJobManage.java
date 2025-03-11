package com.xoa.model.wages_manage;

import java.math.BigDecimal;

/**
 * @author 马东辉
 * @date 2021/11/30
 * @desc
 */
public class WagesJobManage {
    private Integer jobManageId;//自增
    private String type1;//一级分类(SYS_CODE)
    private String type1Name;//一级分类名称
    private String type2;//二级分类(SYS_CODE)
    private String type2Name;//二级分类名称
    private String job;//薪岗名称(职务)
    private BigDecimal salaryTypea;//岗位薪资类型A
    private BigDecimal salaryTypeb;//岗位薪资类型B
    private BigDecimal salaryTypec;//岗位薪资类型C
    private BigDecimal salaryTyped;//岗位薪资类型D
    private BigDecimal salaryTypee;//岗位薪资类型E
    private BigDecimal salaryTypef;//岗位薪资类型F
    private String remarks;//备注



    public Integer getJobManageId() {
        return jobManageId;
    }

    public String getType1Name() {
        return type1Name;
    }

    public void setType1Name(String type1Name) {
        this.type1Name = type1Name;
    }

    public String getType2Name() {
        return type2Name;
    }

    public void setType2Name(String type2Name) {
        this.type2Name = type2Name;
    }

    public void setJobManageId(Integer jobManageId) {
        this.jobManageId = jobManageId;
    }

    public String getType1() {
        return type1;
    }

    public void setType1(String type1) {
        this.type1 = type1;
    }

    public String getType2() {
        return type2;
    }

    public void setType2(String type2) {
        this.type2 = type2;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public BigDecimal getSalaryTypea() {
        return salaryTypea;
    }

    public void setSalaryTypea(BigDecimal salaryTypea) {
        this.salaryTypea = salaryTypea;
    }

    public BigDecimal getSalaryTypeb() {
        return salaryTypeb;
    }

    public void setSalaryTypeb(BigDecimal salaryTypeb) {
        this.salaryTypeb = salaryTypeb;
    }

    public BigDecimal getSalaryTypec() {
        return salaryTypec;
    }

    public void setSalaryTypec(BigDecimal salaryTypec) {
        this.salaryTypec = salaryTypec;
    }

    public BigDecimal getSalaryTyped() {
        return salaryTyped;
    }

    public void setSalaryTyped(BigDecimal salaryTyped) {
        this.salaryTyped = salaryTyped;
    }

    public BigDecimal getSalaryTypee() {
        return salaryTypee;
    }

    public void setSalaryTypee(BigDecimal salaryTypee) {
        this.salaryTypee = salaryTypee;
    }

    public BigDecimal getSalaryTypef() {
        return salaryTypef;
    }

    public void setSalaryTypef(BigDecimal salaryTypef) {
        this.salaryTypef = salaryTypef;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
