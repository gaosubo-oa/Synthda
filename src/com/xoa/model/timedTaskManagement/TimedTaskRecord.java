package com.xoa.model.timedTaskManagement;

import java.util.Date;

public class TimedTaskRecord {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column timed_task_record.TTR_ID
     *
     * @mbggenerated
     */
    private Integer ttrId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column timed_task_record.TTM_ID
     *
     * @mbggenerated
     */
    private Integer ttmId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column timed_task_record.USER_ID
     *
     * @mbggenerated
     */
    private String userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column timed_task_record.EXECUTION_TIME
     *
     * @mbggenerated
     */
    private String executionTime;


    public String getExecutionTime() {
        return executionTime;
    }

    public void setExecutionTime(String executionTime) {
        this.executionTime = executionTime;
    }

    public Date getExecutionTimeDate() {
        return executionTimeDate;
    }

    public void setExecutionTimeDate(Date executionTimeDate) {
        this.executionTimeDate = executionTimeDate;
    }

    private Date executionTimeDate;


    private String lishiTime;

    public String getLishiTime() {
        return lishiTime;
    }

    public void setLishiTime(String lishiTime) {
        this.lishiTime = lishiTime;
    }

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column timed_task_record.RESULT
     *
     * @mbggenerated
     */
    private Integer result;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column timed_task_record.TTR_ID
     *
     * @return the value of timed_task_record.TTR_ID
     *
     * @mbggenerated
     */
    public Integer getTtrId() {
        return ttrId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column timed_task_record.TTR_ID
     *
     * @param ttrId the value for timed_task_record.TTR_ID
     *
     * @mbggenerated
     */
    public void setTtrId(Integer ttrId) {
        this.ttrId = ttrId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column timed_task_record.TTM_ID
     *
     * @return the value of timed_task_record.TTM_ID
     *
     * @mbggenerated
     */
    public Integer getTtmId() {
        return ttmId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column timed_task_record.TTM_ID
     *
     * @param ttmId the value for timed_task_record.TTM_ID
     *
     * @mbggenerated
     */
    public void setTtmId(Integer ttmId) {
        this.ttmId = ttmId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column timed_task_record.USER_ID
     *
     * @return the value of timed_task_record.USER_ID
     *
     * @mbggenerated
     */
    public String getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column timed_task_record.USER_ID
     *
     * @param userId the value for timed_task_record.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column timed_task_record.EXECUTION_TIME
     *
     * @return the value of timed_task_record.EXECUTION_TIME
     *
     * @mbggenerated
     */


    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column timed_task_record.EXECUTION_TIME
     *
     * @param executionTime the value for timed_task_record.EXECUTION_TIME
     *
     * @mbggenerated
     */


    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column timed_task_record.RESULT
     *
     * @return the value of timed_task_record.RESULT
     *
     * @mbggenerated
     */
    public Integer getResult() {
        return result;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column timed_task_record.RESULT
     *
     * @param result the value for timed_task_record.RESULT
     *
     * @mbggenerated
     */
    public void setResult(Integer result) {
        this.result = result;
    }
}