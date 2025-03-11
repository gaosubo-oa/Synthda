package com.xoa.model.rms;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class RmsRollWithBLOBs extends RmsRoll {

    // 案卷管理员
    private String manageUser;

    // 预留
    private String readUser;

    // 保管期限开始
    private String deadBeginDate;

    // 保管期限结束
    private String deadEndDate;

    // 开始日期2 对应查询
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date beginDate2;

    // 结束日期2  对应查询
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date EndDate2;

    // 凭证编号开始2 对应查询
    private String certificateStart2;

    // 凭证编号结束2 对应查询
    private String certificateEnd2;

    // 页数2  对应查询
    private String rollPage2;

    // 所属部门名称

    private String deptName;

    public Integer getAnjuanCount() {
        return anjuanCount;
    }

    public void setAnjuanCount(Integer anjuanCount) {
        this.anjuanCount = anjuanCount;
    }

    //拥有文件个数
    private Integer anjuanCount;

    // 管理人员姓名
    private String managerName;

    private String urgency;

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getRollPage2() {
        return rollPage2;
    }

    public void setRollPage2(String rollPage2) {
        this.rollPage2 = rollPage2;
    }

    public String getCertificateStart2() {
        return certificateStart2;
    }

    public void setCertificateStart2(String certificateStart2) {
        this.certificateStart2 = certificateStart2;
    }

    public String getCertificateEnd2() {
        return certificateEnd2;
    }

    public void setCertificateEnd2(String certificateEnd2) {
        this.certificateEnd2 = certificateEnd2;
    }

    public String getDeadBeginDate() {
        return deadBeginDate;
    }

    public void setDeadBeginDate(String deadBeginDate) {
        this.deadBeginDate = deadBeginDate;
    }

    public String getDeadEndDate() {
        return deadEndDate;
    }

    public void setDeadEndDate(String deadEndDate) {
        this.deadEndDate = deadEndDate;
    }

    public Date getBeginDate2() {
        return beginDate2;
    }

    public void setBeginDate2(Date beginDate2) {
        this.beginDate2 = beginDate2;
    }

    public Date getEndDate2() {
        return EndDate2;
    }

    public void setEndDate2(Date endDate2) {
        EndDate2 = endDate2;
    }

    public String getManageUser() {
        return manageUser;
    }

    public void setManageUser(String manageUser) {
        this.manageUser = manageUser == null ? null : manageUser.trim();
    }

    public String getReadUser() {
        return readUser;
    }

    public void setReadUser(String readUser) {
        this.readUser = readUser == null ? null : readUser.trim();
    }

    public String getUrgency() {
        return urgency;
    }

    public void setUrgency(String urgency) {
        this.urgency = urgency;
    }

    public String getManager(){
        return super.getManager();
    }
}