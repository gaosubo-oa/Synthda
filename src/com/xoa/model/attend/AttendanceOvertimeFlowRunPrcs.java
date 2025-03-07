package com.xoa.model.attend;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;

/**
 * Created by gsb on 2018/9/29.
 */
public class AttendanceOvertimeFlowRunPrcs extends AttendanceOvertime{
    Integer overtimeId;

    @Override
    public Integer getOvertimeId() {
        return overtimeId;
    }

    public void setOvertimeId(Integer overtimeId) {
        this.overtimeId = overtimeId;
    }

    Integer id;
    String flowId;
    String createrName; //创建人名
    Integer prFlag;//发文状态
    String prcsName;//步骤节点
    Integer realPrcsId;//真实步骤ID
    Integer step;//流程步骤
    Date endTime;//流程结束时间
    String codeName;

    String curUserIdName;
    String allUserIdName;

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

    @Override
    public Integer getId() {
        return id;
    }

    @Override
    public void setId(Integer id) {
        this.id = id;
    }
}
