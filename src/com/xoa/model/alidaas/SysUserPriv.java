package com.xoa.model.alidaas;

public class SysUserPriv {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.USER_PRIV
     *
     * @mbggenerated
     */
    private Integer userPriv;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.PRIV_NAME
     *
     * @mbggenerated
     */
    private String privName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.PRIV_NO
     *
     * @mbggenerated
     */
    private Short privNo;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.FUNC_ID_STR
     *
     * @mbggenerated
     */
    private String funcIdStr;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.PRIV_DEPT_ID
     *
     * @mbggenerated
     */
    private Integer privDeptId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.PRIV_TYPE
     *
     * @mbggenerated
     */
    private Integer privType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_priv.IS_GLOBAL
     *
     * @mbggenerated
     */
    private Integer isGlobal;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.USER_PRIV
     *
     * @return the value of user_priv.USER_PRIV
     *
     * @mbggenerated
     */
    public Integer getUserPriv() {
        return userPriv;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.USER_PRIV
     *
     * @param userPriv the value for user_priv.USER_PRIV
     *
     * @mbggenerated
     */
    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.PRIV_NAME
     *
     * @return the value of user_priv.PRIV_NAME
     *
     * @mbggenerated
     */
    public String getPrivName() {
        return privName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.PRIV_NAME
     *
     * @param privName the value for user_priv.PRIV_NAME
     *
     * @mbggenerated
     */
    public void setPrivName(String privName) {
        this.privName = privName == null ? null : privName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.PRIV_NO
     *
     * @return the value of user_priv.PRIV_NO
     *
     * @mbggenerated
     */
    public Short getPrivNo() {
        return privNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.PRIV_NO
     *
     * @param privNo the value for user_priv.PRIV_NO
     *
     * @mbggenerated
     */
    public void setPrivNo(Short privNo) {
        this.privNo = privNo;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.FUNC_ID_STR
     *
     * @return the value of user_priv.FUNC_ID_STR
     *
     * @mbggenerated
     */
    public String getFuncIdStr() {
        return funcIdStr;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.FUNC_ID_STR
     *
     * @param funcIdStr the value for user_priv.FUNC_ID_STR
     *
     * @mbggenerated
     */
    public void setFuncIdStr(String funcIdStr) {
        this.funcIdStr = funcIdStr == null ? null : funcIdStr.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.PRIV_DEPT_ID
     *
     * @return the value of user_priv.PRIV_DEPT_ID
     *
     * @mbggenerated
     */
    public Integer getPrivDeptId() {
        return privDeptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.PRIV_DEPT_ID
     *
     * @param privDeptId the value for user_priv.PRIV_DEPT_ID
     *
     * @mbggenerated
     */
    public void setPrivDeptId(Integer privDeptId) {
        this.privDeptId = privDeptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.PRIV_TYPE
     *
     * @return the value of user_priv.PRIV_TYPE
     *
     * @mbggenerated
     */
    public Integer getPrivType() {
        return privType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.PRIV_TYPE
     *
     * @param privType the value for user_priv.PRIV_TYPE
     *
     * @mbggenerated
     */
    public void setPrivType(Integer privType) {
        this.privType = privType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_priv.IS_GLOBAL
     *
     * @return the value of user_priv.IS_GLOBAL
     *
     * @mbggenerated
     */
    public Integer getIsGlobal() {
        return isGlobal;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_priv.IS_GLOBAL
     *
     * @param isGlobal the value for user_priv.IS_GLOBAL
     *
     * @mbggenerated
     */
    public void setIsGlobal(Integer isGlobal) {
        this.isGlobal = isGlobal;
    }
}