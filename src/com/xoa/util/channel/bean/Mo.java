/**
 * Mo.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.xoa.util.channel.bean;

public class Mo implements java.io.Serializable {
    private String addSerial;

    private String addSerialRev;

    private String channelnumber;

    private String mobileNumber;

    private String sentTime;

    private String smsContent;

    public Mo() {
    }

    public Mo(String addSerial, String addSerialRev, String channelnumber, String mobileNumber, String sentTime, String smsContent) {
	this.addSerial = addSerial;
	this.addSerialRev = addSerialRev;
	this.channelnumber = channelnumber;
	this.mobileNumber = mobileNumber;
	this.sentTime = sentTime;
	this.smsContent = smsContent;
    }

    /**
     * Gets the addSerial value for this Mo.
     *
     * @return addSerial
     */
    public String getAddSerial() {
	return addSerial;
    }

    /**
     * Sets the addSerial value for this Mo.
     *
     * @param addSerial
     */
    public void setAddSerial(String addSerial) {
	this.addSerial = addSerial;
    }

    /**
     * Gets the addSerialRev value for this Mo.
     *
     * @return addSerialRev
     */
    public String getAddSerialRev() {
	return addSerialRev;
    }

    /**
     * Sets the addSerialRev value for this Mo.
     *
     * @param addSerialRev
     */
    public void setAddSerialRev(String addSerialRev) {
	this.addSerialRev = addSerialRev;
    }

    /**
     * Gets the channelnumber value for this Mo.
     *
     * @return channelnumber
     */
    public String getChannelnumber() {
	return channelnumber;
    }

    /**
     * Sets the channelnumber value for this Mo.
     *
     * @param channelnumber
     */
    public void setChannelnumber(String channelnumber) {
	this.channelnumber = channelnumber;
    }

    /**
     * Gets the mobileNumber value for this Mo.
     *
     * @return mobileNumber
     */
    public String getMobileNumber() {
	return mobileNumber;
    }

    /**
     * Sets the mobileNumber value for this Mo.
     *
     * @param mobileNumber
     */
    public void setMobileNumber(String mobileNumber) {
	this.mobileNumber = mobileNumber;
    }

    /**
     * Gets the sentTime value for this Mo.
     *
     * @return sentTime
     */
    public String getSentTime() {
	return sentTime;
    }

    /**
     * Sets the sentTime value for this Mo.
     *
     * @param sentTime
     */
    public void setSentTime(String sentTime) {
	this.sentTime = sentTime;
    }

    /**
     * Gets the smsContent value for this Mo.
     *
     * @return smsContent
     */
    public String getSmsContent() {
	return smsContent;
    }

    /**
     * Sets the smsContent value for this Mo.
     *
     * @param smsContent
     */
    public void setSmsContent(String smsContent) {
	this.smsContent = smsContent;
    }

    public String toString() {
	return addSerial + "|" + addSerialRev + "|" + channelnumber + "|" + mobileNumber + "|" + sentTime + "|" + smsContent;
    }

}
