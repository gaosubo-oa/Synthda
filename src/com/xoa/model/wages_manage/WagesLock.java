package com.xoa.model.wages_manage;

public class WagesLock {
      private   Integer lockId;
      private  String lockName;
      private  String lockStatus;
      private  String lockContent;
      private  String theYear;
      private   String theMonth;

    public Integer getLockId() {
        return lockId;
    }

    public void setLockId(Integer lockId) {
        this.lockId = lockId;
    }

    public String getLockName() {
        return lockName;
    }

    public void setLockName(String lockName) {
        this.lockName = lockName;
    }

    public String getLockStatus() {
        return lockStatus;
    }

    public void setLockStatus(String lockStatus) {
        this.lockStatus = lockStatus;
    }

    public String getLockContent() {
        return lockContent;
    }

    public void setLockContent(String lockContent) {
        this.lockContent = lockContent;
    }

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
}
