/**
 * StatusReport.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.xoa.util.channel.bean;

public class StatusReport implements java.io.Serializable {
    private String errorCode;

    private String memo;

    private String mobile;

    private String receiveDate;

    private int reportStatus;

    private long seqID;

    private String serviceCodeAdd;

    private String submitDate;

    public StatusReport() {
    }

    public StatusReport(String errorCode, String memo, String mobile, String receiveDate, int reportStatus, long seqID, String serviceCodeAdd,
                        String submitDate) {
	this.errorCode = errorCode;
	this.memo = memo;
	this.mobile = mobile;
	this.receiveDate = receiveDate;
	this.reportStatus = reportStatus;
	this.seqID = seqID;
	this.serviceCodeAdd = serviceCodeAdd;
	this.submitDate = submitDate;
    }

    /**
     * Gets the errorCode value for this StatusReport.
     *
     * @return errorCode
     */
    public String getErrorCode() {
	return errorCode;
    }

    /**
     * Sets the errorCode value for this StatusReport.
     *
     * @param errorCode
     */
    public void setErrorCode(String errorCode) {
	this.errorCode = errorCode;
    }

    /**
     * Gets the memo value for this StatusReport.
     *
     * @return memo
     */
    public String getMemo() {
	return memo;
    }

    /**
     * Sets the memo value for this StatusReport.
     *
     * @param memo
     */
    public void setMemo(String memo) {
	this.memo = memo;
    }

    /**
     * Gets the mobile value for this StatusReport.
     *
     * @return mobile
     */
    public String getMobile() {
	return mobile;
    }

    /**
     * Sets the mobile value for this StatusReport.
     *
     * @param mobile
     */
    public void setMobile(String mobile) {
	this.mobile = mobile;
    }

    /**
     * Gets the receiveDate value for this StatusReport.
     *
     * @return receiveDate
     */
    public String getReceiveDate() {
	return receiveDate;
    }

    /**
     * Sets the receiveDate value for this StatusReport.
     *
     * @param receiveDate
     */
    public void setReceiveDate(String receiveDate) {
	this.receiveDate = receiveDate;
    }

    /**
     * Gets the reportStatus value for this StatusReport.
     *
     * @return reportStatus
     */
    public int getReportStatus() {
	return reportStatus;
    }

    /**
     * Sets the reportStatus value for this StatusReport.
     *
     * @param reportStatus
     */
    public void setReportStatus(int reportStatus) {
	this.reportStatus = reportStatus;
    }

    /**
     * Gets the seqID value for this StatusReport.
     *
     * @return seqID
     */
    public long getSeqID() {
	return seqID;
    }

    /**
     * Sets the seqID value for this StatusReport.
     *
     * @param seqID
     */
    public void setSeqID(long seqID) {
	this.seqID = seqID;
    }

    /**
     * Gets the serviceCodeAdd value for this StatusReport.
     *
     * @return serviceCodeAdd
     */
    public String getServiceCodeAdd() {
	return serviceCodeAdd;
    }

    /**
     * Sets the serviceCodeAdd value for this StatusReport.
     *
     * @param serviceCodeAdd
     */
    public void setServiceCodeAdd(String serviceCodeAdd) {
	this.serviceCodeAdd = serviceCodeAdd;
    }

    /**
     * Gets the submitDate value for this StatusReport.
     *
     * @return submitDate
     */
    public String getSubmitDate() {
	return submitDate;
    }

    /**
     * Sets the submitDate value for this StatusReport.
     *
     * @param submitDate
     */
    public void setSubmitDate(String submitDate) {
	this.submitDate = submitDate;
    }
}
