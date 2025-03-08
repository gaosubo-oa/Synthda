package com.xoa.model.institution;

public class InstitutionContentWithBLOBs extends InstitutionContent {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.INST_CONTENT
     *
     * @mbggenerated
     */
    private String instContent;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.READER_USERS
     *
     * @mbggenerated
     */
    private String readerUsers;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.EDIT_CONTENT
     *
     * @mbggenerated
     */
    private String editContent;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.FLOW_ID
     *
     * @mbggenerated
     */
    private String flowId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.USER_IDS
     *
     * @mbggenerated
     */
    private String userIds;


    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.VIEW_DEPTS
     *
     * @mbggenerated
     */
    private String viewDepts;

    private String viewDeptsName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.VIEW_PRIVS
     *
     * @mbggenerated
     */
    private String viewPrivs;

    private String viewPrivsName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.VIEW_USERS
     *
     * @mbggenerated
     */
    private String viewUsers;

    private String viewUsersName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column institution_content.VIEW_USER_TYPE
     *
     * @mbggenerated
     */
    private String viewUserType;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.INST_CONTENT
     *
     * @return the value of institution_content.INST_CONTENT
     *
     * @mbggenerated
     */
    public String getInstContent() {
        return instContent;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.INST_CONTENT
     *
     * @param instContent the value for institution_content.INST_CONTENT
     *
     * @mbggenerated
     */
    public void setInstContent(String instContent) {
        this.instContent = instContent == null ? null : instContent.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.READER_USERS
     *
     * @return the value of institution_content.READER_USERS
     *
     * @mbggenerated
     */
    public String getReaderUsers() {
        return readerUsers;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.READER_USERS
     *
     * @param readerUsers the value for institution_content.READER_USERS
     *
     * @mbggenerated
     */
    public void setReaderUsers(String readerUsers) {
        this.readerUsers = readerUsers == null ? null : readerUsers.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.EDIT_CONTENT
     *
     * @return the value of institution_content.EDIT_CONTENT
     *
     * @mbggenerated
     */
    public String getEditContent() {
        return editContent;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.EDIT_CONTENT
     *
     * @param editContent the value for institution_content.EDIT_CONTENT
     *
     * @mbggenerated
     */
    public void setEditContent(String editContent) {
        this.editContent = editContent == null ? null : editContent.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.FLOW_ID
     *
     * @return the value of institution_content.FLOW_ID
     *
     * @mbggenerated
     */
    public String getFlowId() {
        return flowId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.FLOW_ID
     *
     * @param flowId the value for institution_content.FLOW_ID
     *
     * @mbggenerated
     */
    public void setFlowId(String flowId) {
        this.flowId = flowId == null ? null : flowId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.USER_IDS
     *
     * @return the value of institution_content.USER_IDS
     *
     * @mbggenerated
     */
    public String getUserIds() {
        return userIds;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.USER_IDS
     *
     * @param userIds the value for institution_content.USER_IDS
     *
     * @mbggenerated
     */
    public void setUserIds(String userIds) {
        this.userIds = userIds == null ? null : userIds.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.VIEW_DEPTS
     *
     * @return the value of institution_content.VIEW_DEPTS
     *
     * @mbggenerated
     */
    public String getViewDepts() {
        return viewDepts;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.VIEW_DEPTS
     *
     * @param viewDepts the value for institution_content.VIEW_DEPTS
     *
     * @mbggenerated
     */
    public void setViewDepts(String viewDepts) {
        this.viewDepts = viewDepts == null ? null : viewDepts.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.VIEW_PRIVS
     *
     * @return the value of institution_content.VIEW_PRIVS
     *
     * @mbggenerated
     */
    public String getViewPrivs() {
        return viewPrivs;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.VIEW_PRIVS
     *
     * @param viewPrivs the value for institution_content.VIEW_PRIVS
     *
     * @mbggenerated
     */
    public void setViewPrivs(String viewPrivs) {
        this.viewPrivs = viewPrivs == null ? null : viewPrivs.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.VIEW_USERS
     *
     * @return the value of institution_content.VIEW_USERS
     *
     * @mbggenerated
     */
    public String getViewUsers() {
        return viewUsers;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.VIEW_USERS
     *
     * @param viewUsers the value for institution_content.VIEW_USERS
     *
     * @mbggenerated
     */
    public void setViewUsers(String viewUsers) {
        this.viewUsers = viewUsers == null ? null : viewUsers.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column institution_content.VIEW_USER_TYPE
     *
     * @return the value of institution_content.VIEW_USER_TYPE
     *
     * @mbggenerated
     */
    public String getViewUserType() {
        return viewUserType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column institution_content.VIEW_USER_TYPE
     *
     * @param viewUserType the value for institution_content.VIEW_USER_TYPE
     *
     * @mbggenerated
     */
    public void setViewUserType(String viewUserType) {
        this.viewUserType = viewUserType == null ? null : viewUserType.trim();
    }

    public String getViewDeptsName() {
        return viewDeptsName;
    }

    public void setViewDeptsName(String viewDeptsName) {
        this.viewDeptsName = viewDeptsName;
    }

    public String getViewPrivsName() {
        return viewPrivsName;
    }

    public void setViewPrivsName(String viewPrivsName) {
        this.viewPrivsName = viewPrivsName;
    }

    public String getViewUsersName() {
        return viewUsersName;
    }

    public void setViewUsersName(String viewUsersName) {
        this.viewUsersName = viewUsersName;
    }
}