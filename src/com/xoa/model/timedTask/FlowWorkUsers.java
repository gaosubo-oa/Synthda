package com.xoa.model.timedTask;/*
 *
 *
 */

public class FlowWorkUsers {
    private  Integer runId;
    private  String  runName;
     private  String timeField;
     private  String usersField;

    public Integer getRunId() {
        return runId;
    }

    public void setRunId(Integer runId) {
        this.runId = runId;
    }

    public String getRunName() {
        return runName;
    }

    public void setRunName(String runName) {
        this.runName = runName;
    }

    public String getTimeField() {
        return timeField;
    }

    public void setTimeField(String timeField) {
        this.timeField = timeField;
    }

    public String getUsersField() {
        return usersField;
    }

    public void setUsersField(String usersField) {
        this.usersField = usersField;
    }
}
