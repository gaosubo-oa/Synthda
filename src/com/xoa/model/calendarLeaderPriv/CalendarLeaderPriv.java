package com.xoa.model.calendarLeaderPriv;

public class CalendarLeaderPriv {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column calendar_leader_priv.priv_id
     *
     * @mbggenerated
     */
    private Integer privId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column calendar_leader_priv.managers
     *
     * @mbggenerated
     */
    private String managers;

    private String managerNames;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column calendar_leader_priv.query_priv_users
     *
     * @mbggenerated
     */
    private String queryPrivUsers;


    private String queryPrivNames;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column calendar_leader_priv.edit_priv_users
     *
     * @mbggenerated
     */
    private String editPrivUsers;

    private String editPrivNames;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column calendar_leader_priv.priv_id
     *
     * @return the value of calendar_leader_priv.priv_id
     *
     * @mbggenerated
     */
    public Integer getPrivId() {
        return privId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column calendar_leader_priv.priv_id
     *
     * @param privId the value for calendar_leader_priv.priv_id
     *
     * @mbggenerated
     */
    public void setPrivId(Integer privId) {
        this.privId = privId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column calendar_leader_priv.managers
     *
     * @return the value of calendar_leader_priv.managers
     *
     * @mbggenerated
     */
    public String getManagers() {
        return managers;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column calendar_leader_priv.managers
     *
     * @param managers the value for calendar_leader_priv.managers
     *
     * @mbggenerated
     */
    public void setManagers(String managers) {
        this.managers = managers == null ? null : managers.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column calendar_leader_priv.query_priv_users
     *
     * @return the value of calendar_leader_priv.query_priv_users
     *
     * @mbggenerated
     */
    public String getQueryPrivUsers() {
        return queryPrivUsers;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column calendar_leader_priv.query_priv_users
     *
     * @param queryPrivUsers the value for calendar_leader_priv.query_priv_users
     *
     * @mbggenerated
     */
    public void setQueryPrivUsers(String queryPrivUsers) {
        this.queryPrivUsers = queryPrivUsers == null ? null : queryPrivUsers.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column calendar_leader_priv.edit_priv_users
     *
     * @return the value of calendar_leader_priv.edit_priv_users
     *
     * @mbggenerated
     */
    public String getEditPrivUsers() {
        return editPrivUsers;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column calendar_leader_priv.edit_priv_users
     *
     * @param editPrivUsers the value for calendar_leader_priv.edit_priv_users
     *
     * @mbggenerated
     */
    public void setEditPrivUsers(String editPrivUsers) {
        this.editPrivUsers = editPrivUsers == null ? null : editPrivUsers.trim();
    }

    public String getManagerNames() {
        return managerNames;
    }

    public void setManagerNames(String managerNames) {
        this.managerNames = managerNames;
    }

    public String getQueryPrivNames() {
        return queryPrivNames;
    }

    public void setQueryPrivNames(String queryPrivNames) {
        this.queryPrivNames = queryPrivNames;
    }

    public String getEditPrivNames() {
        return editPrivNames;
    }

    public void setEditPrivNames(String editPrivNames) {
        this.editPrivNames = editPrivNames;
    }
}