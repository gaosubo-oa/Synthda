package com.xoa.model.officesupplies;

import java.util.Date;

/**
 *  物品库表
 */
public class OfficeDepository {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_depository.ID
     *
     * @mbggenerated
     */
    private Integer id;//唯一自增ID

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_depository.DEPOSITORY_NAME
     *
     * @mbggenerated
     */
    private String depositoryName;//库名称

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_depository.PRIV_ID
     *
     * @mbggenerated
     */
    private String privId;//所属角色

    private String privName;//所属角色名称

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_depository.RETURN_STATUS
     *
     * @mbggenerated
     */
    private Integer returnStatus;//归还状态

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_depository.RETURN_DATE
     *
     * @mbggenerated
     */
    private Date returnDate;//归还时间

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_depository.ID
     *
     * @return the value of office_depository.ID
     *
     * @mbggenerated
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_depository.ID
     *
     * @param id the value for office_depository.ID
     *
     * @mbggenerated
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_depository.DEPOSITORY_NAME
     *
     * @return the value of office_depository.DEPOSITORY_NAME
     *
     * @mbggenerated
     */
    public String getDepositoryName() {
        return depositoryName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_depository.DEPOSITORY_NAME
     *
     * @param depositoryName the value for office_depository.DEPOSITORY_NAME
     *
     * @mbggenerated
     */
    public void setDepositoryName(String depositoryName) {
        this.depositoryName = depositoryName == null ? null : depositoryName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_depository.PRIV_ID
     *
     * @return the value of office_depository.PRIV_ID
     *
     * @mbggenerated
     */
    public String getPrivId() {
        return privId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_depository.PRIV_ID
     *
     * @param privId the value for office_depository.PRIV_ID
     *
     * @mbggenerated
     */
    public void setPrivId(String privId) {
        this.privId = privId == null ? null : privId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_depository.RETURN_STATUS
     *
     * @return the value of office_depository.RETURN_STATUS
     *
     * @mbggenerated
     */
    public Integer getReturnStatus() {
        return returnStatus;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_depository.RETURN_STATUS
     *
     * @param returnStatus the value for office_depository.RETURN_STATUS
     *
     * @mbggenerated
     */
    public void setReturnStatus(Integer returnStatus) {
        this.returnStatus = returnStatus;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_depository.RETURN_DATE
     *
     * @return the value of office_depository.RETURN_DATE
     *
     * @mbggenerated
     */
    public Date getReturnDate() {
        return returnDate;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_depository.RETURN_DATE
     *
     * @param returnDate the value for office_depository.RETURN_DATE
     *
     * @mbggenerated
     */
    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getPrivName() {
        return privName==null?"":privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName;
    }
}