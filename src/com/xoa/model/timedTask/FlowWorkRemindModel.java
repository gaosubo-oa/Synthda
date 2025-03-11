package com.xoa.model.timedTask;/*
 *
 *
 */

public class FlowWorkRemindModel {
    private  Integer remindId;
    private  Integer flowId;
    private  String remindUsersField;
    private  String remindTimeField;
    private  String remindContent;
    private  String remindUser;
    private  Integer runId;
    private  String isDelete;
    public Integer getRunId() {
        return runId;
    }

    public void setRunId(Integer runId) {
        this.runId = runId;
    }

    public Integer getRemindId() {
        return remindId;
    }

    public void setRemindId(Integer remindId) {
        this.remindId = remindId;
    }

    public Integer getFlowId() {
        return flowId;
    }

    public void setFlowId(Integer flowId) {
        this.flowId = flowId;
    }

    public String getRemindUsersField() {
        return remindUsersField;
    }

    public void setRemindUsersField(String remindUsersField) {
        this.remindUsersField = remindUsersField;
    }

    public String getRemindTimeField() {
        return remindTimeField;
    }

    public void setRemindTimeField(String remindTimeField) {
        this.remindTimeField = remindTimeField;
    }

    public String getRemindContent() {
        return remindContent;
    }

    public void setRemindContent(String remindContent) {
        this.remindContent = remindContent;
    }

    public String getRemindUser() {
        return remindUser;
    }

    public void setRemindUser(String remindUser) {
        this.remindUser = remindUser;
    }

    public String getIsDelete() {
        return isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }
}
