package com.xoa.util.quartz.model;

import java.util.Date;

/**
 * Created by 刘建 on 2020/7/9 16:01
 * 定时任务实体类
 */
public class SchedulerJob {

    //任务id
    private Integer jobId;

    //任务名称
    private String jobName;

    //任务组
    private String jobGroup;

    //任务参数
    private String jobData;

    //任务描述
    private String description;

    //是否可以同步
    private boolean isSync;

    //是否同步 走不同的 boj 实现类
    private String syncClass;

    //执行类 包名+类名
    private String className;

    //任务调用的方法名
    private String methodName;

    //触发器名称
    private String triggerName;

    //触发器组
    private String triggerGroup;

    //时间表达式
    private String cronExpression;

    //任务失败后是否继续执行下一次
    private boolean errContinueYn;

    //任务状态 是否启动任务
    private Boolean jobStatus;

    //当前任务执行人（立即执行）
    private String userId;

    //当前执行记录ID
    private Integer lastRecordId;

    //创建时间
    private Date createTime;

    //更新时间
    private Date updateTime;

    public Integer getJobId() {
        return jobId;
    }

    public void setJobId(Integer jobId) {
        this.jobId = jobId;
    }

    public String getJobName() {
        return jobName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public String getJobGroup() {
        return jobGroup;
    }

    public void setJobGroup(String jobGroup) {
        this.jobGroup = jobGroup;
    }

    public String getJobData() {
        return jobData;
    }

    public void setJobData(String jobData) {
        this.jobData = jobData;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setSync(boolean sync) {
        this.syncClass = sync ? "com.xoa.util.quartz.component.QuartzJobFactory" : "com.xoa.util.quartz.component.QuartzStatefulJobFactory";
        isSync = sync;
    }

    public String getSyncClass() {
        return syncClass;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public String getTriggerName() {
        return triggerName;
    }

    public void setTriggerName(String triggerName) {
        this.triggerName = triggerName;
    }

    public String getTriggerGroup() {
        return triggerGroup;
    }

    public void setTriggerGroup(String triggerGroup) {
        this.triggerGroup = triggerGroup;
    }

    public String getCronExpression() {
        return cronExpression;
    }

    public void setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression;
    }

    public boolean isErrContinueYn() {
        return errContinueYn;
    }

    public void setErrContinueYn(boolean errContinueYn) {
        this.errContinueYn = errContinueYn;
    }

    public Boolean getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(Boolean jobStatus) {
        this.jobStatus = jobStatus;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getLastRecordId() {
        return lastRecordId;
    }

    public void setLastRecordId(Integer lastRecordId) {
        this.lastRecordId = lastRecordId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
