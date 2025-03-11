package com.xoa.model.budget;

import com.alibaba.fastjson.annotation.JSONField;

import java.math.BigDecimal;
import java.util.Date;

public class BudgetingProcessFlowRunPrcs extends BudgetingProcess {
    String flowId;
    String createrName; //创建人名
    Integer prFlag;//状态
    String prcsName;//步骤节点
    Integer realPrcsId;//真实步骤ID
    Integer step;//流程步骤
    Date endTime;//流程步骤结束时间
    String codeName;
    String runName;
    String frpId;
    String setpName;//步骤状态名称
    Date FrEndtime; // 整个流程结束时间 用来判断流程是否已经结束
    //预支出金额
   private BigDecimal allAdvance;

    public BigDecimal getAllAdvance() {
        return allAdvance;
    }

    public String getSetpName() {
        return setpName;
    }

    public void setSetpName(String setpName) {
        this.setpName = setpName;
    }

    public void setAllAdvance(BigDecimal allAdvance) {
        this.allAdvance = allAdvance;
    }

    public String getFrpId() {
        return frpId;
    }

    public void setFrpId(String frpId) {
        this.frpId = frpId;
    }

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
    }

    String curUserIdName;
    String allUserIdName;


    String year;

    public Date getFrEndtime() {
        return FrEndtime;
    }

    public void setFrEndtime(Date frEndtime) {
        FrEndtime = frEndtime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    Integer id;

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    @Override
    public String getFlowId() {
        return flowId;
    }

    public void setFlowId(String flowId) {
        this.flowId = flowId;
    }

    public String getCreaterName() {
        return createrName;
    }

    public void setCreaterName(String createrName) {
        this.createrName = createrName;
    }

    public Integer getPrFlag() {
        return prFlag;
    }

    public void setPrFlag(Integer prFlag) {
        this.prFlag = prFlag;
    }

    public String getPrcsName() {
        return prcsName;
    }

    public void setPrcsName(String prcsName) {
        this.prcsName = prcsName;
    }

    public Integer getRealPrcsId() {
        return realPrcsId;
    }

    public void setRealPrcsId(Integer realPrcsId) {
        this.realPrcsId = realPrcsId;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public String getCurUserIdName() {
        return curUserIdName;
    }

    public void setCurUserIdName(String curUserIdName) {
        this.curUserIdName = curUserIdName;
    }

    public String getAllUserIdName() {
        return allUserIdName;
    }

    public void setAllUserIdName(String allUserIdName) {
        this.allUserIdName = allUserIdName;
    }
}
