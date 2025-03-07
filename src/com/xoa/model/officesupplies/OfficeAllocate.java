package com.xoa.model.officesupplies;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class OfficeAllocate {

    private Integer id;//唯一自增ID

    private  Integer proTypeOut;  //调出办公用品库ID

    private  String proNameOut;  //调出办公用品名称

    private  String offcieProTypeOut; //调出物品所属类别ID

    private  Integer proIdOut; //调出办公用品ID

    private  String creator; //创建人

    private  String creatorName; //创建人名称
    private  Integer proTypeIn;  //调入办公用品库ID

    private  String proNameIn;  //调入办公用品名称

    private  String offcieProTypeIn; //调入物品所属类别ID

    private  Integer proIdIN; //调入办公用品ID

    private  String auditer; //操作员/审批人

    private  String auditerName; //操作员/审批人 名称
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date allocateDate;//调拨时间
    private String   approvalStatus;//审批状态

    private String allocateNum;//调拨数量


    private String  remark;//备注
    private String overruleRemark;//驳回说明


    private String proDesc;//规格/型号

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProTypeOut() {
        return proTypeOut;
    }

    public void setProTypeOut(Integer proTypeOut) {
        this.proTypeOut = proTypeOut;
    }

    public String getProNameOut() {
        return proNameOut;
    }

    public void setProNameOut(String proNameOut) {
        this.proNameOut = proNameOut;
    }

    public String getOffcieProTypeOut() {
        return offcieProTypeOut;
    }

    public void setOffcieProTypeOut(String offcieProTypeOut) {
        this.offcieProTypeOut = offcieProTypeOut;
    }

    public Integer getProIdOut() {
        return proIdOut;
    }

    public void setProIdOut(Integer proIdOut) {
        this.proIdOut = proIdOut;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Integer getProTypeIn() {
        return proTypeIn;
    }

    public void setProTypeIn(Integer proTypeIn) {
        this.proTypeIn = proTypeIn;
    }

    public String getProNameIn() {
        return proNameIn;
    }

    public void setProNameIn(String proNameIn) {
        this.proNameIn = proNameIn;
    }

    public String getOffcieProTypeIn() {
        return offcieProTypeIn;
    }

    public void setOffcieProTypeIn(String offcieProTypeIn) {
        this.offcieProTypeIn = offcieProTypeIn;
    }

    public Integer getProIdIN() {
        return proIdIN;
    }

    public void setProIdIN(Integer proIdIN) {
        this.proIdIN = proIdIN;
    }

    public String getAuditer() {
        return auditer;
    }

    public void setAuditer(String auditer) {
        this.auditer = auditer;
    }

    public Date getAllocateDate() {
        return allocateDate;
    }

    public void setAllocateDate(Date allocateDate) {
        this.allocateDate = allocateDate;
    }

    public String getApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(String approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getAllocateNum() {
        return allocateNum;
    }

    public void setAllocateNum(String allocateNum) {
        this.allocateNum = allocateNum;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getOverruleRemark() {
        return overruleRemark;
    }

    public void setOverruleRemark(String overruleRemark) {
        this.overruleRemark = overruleRemark;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public String getAuditerName() {
        return auditerName;
    }

    public void setAuditerName(String auditerName) {
        this.auditerName = auditerName;
    }

    public String getProDesc() {
        return proDesc;
    }

    public void setProDesc(String proDesc) {
        this.proDesc = proDesc;
    }
}
