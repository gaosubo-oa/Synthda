package com.xoa.model.oaSource;


public class OaSource {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column oa_source.SOURCEID
     *
     * @mbggenerated
     */
    private Integer sourceid;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column oa_source.SOURCENO
     *
     * @mbggenerated
     */
    private Integer sourceno;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column oa_source.SOURCENAME
     *
     * @mbggenerated
     */
    private String sourcename;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column oa_source.DAY_LIMIT
     *
     * @mbggenerated
     */
    private String dayLimit;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column oa_source.WEEKDAY_SET
     *
     * @mbggenerated
     */
    private String weekdaySet;

    /*&***********备选人员用到的字段*******************/

    //临时封装字段用于排序
    private String sort;

    private String userid;

    private String username;

    private String deptid;

    private String deptName;

    private String userPriv;

    private String privName;

    private Integer type;


    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDeptid() {
        return deptid;
    }

    public void setDeptid(String deptid) {
        this.deptid = deptid;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getUserPriv() {
        return userPriv;
    }

    public void setUserPriv(String userPriv) {
        this.userPriv = userPriv;
    }

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column oa_source.SOURCEID
     *
     * @return the value of oa_source.SOURCEID
     *
     * @mbggenerated
     */
    public Integer getSourceid() {
        return sourceid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column oa_source.SOURCEID
     *
     * @param sourceid the value for oa_source.SOURCEID
     *
     * @mbggenerated
     */
    public void setSourceid(Integer sourceid) {
        this.sourceid = sourceid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column oa_source.SOURCENO
     *
     * @return the value of oa_source.SOURCENO
     *
     * @mbggenerated
     */
    public Integer getSourceno() {
        return sourceno;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column oa_source.SOURCENO
     *
     * @param sourceno the value for oa_source.SOURCENO
     *
     * @mbggenerated
     */
    public void setSourceno(Integer sourceno) {
        this.sourceno = sourceno;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column oa_source.SOURCENAME
     *
     * @return the value of oa_source.SOURCENAME
     *
     * @mbggenerated
     */
    public String getSourcename() {
        return sourcename;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column oa_source.SOURCENAME
     *
     * @param sourcename the value for oa_source.SOURCENAME
     *
     * @mbggenerated
     */
    public void setSourcename(String sourcename) {
        this.sourcename = sourcename == null ? null : sourcename.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column oa_source.DAY_LIMIT
     *
     * @return the value of oa_source.DAY_LIMIT
     *
     * @mbggenerated
     */
    public String getDayLimit() {
        return dayLimit;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column oa_source.DAY_LIMIT
     *
     * @param dayLimit the value for oa_source.DAY_LIMIT
     *
     * @mbggenerated
     */
    public void setDayLimit(String dayLimit) {
        this.dayLimit = dayLimit == null ? null : dayLimit.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column oa_source.WEEKDAY_SET
     *
     * @return the value of oa_source.WEEKDAY_SET
     *
     * @mbggenerated
     */
    public String getWeekdaySet() {
        return weekdaySet;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column oa_source.WEEKDAY_SET
     *
     * @param weekdaySet the value for oa_source.WEEKDAY_SET
     *
     * @mbggenerated
     */
    public void setWeekdaySet(String weekdaySet) {
        this.weekdaySet = weekdaySet == null ? null : weekdaySet.trim();
    }

}