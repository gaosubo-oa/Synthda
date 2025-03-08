package com.xoa.model.users;

public class UserModulePage {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_module_page.PAGE_ID
     *
     * @mbggenerated
     */
    private Integer pageId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_module_page.USER_ID
     *
     * @mbggenerated
     */
    private String userId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_module_page.MODULE_TABLE
     *
     * @mbggenerated
     */
    private String moduleTable;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_module_page.PAGES
     *
     * @mbggenerated
     */
    private Integer pages;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_module_page.PAGE_ID
     *
     * @return the value of user_module_page.PAGE_ID
     *
     * @mbggenerated
     */
    public Integer getPageId() {
        return pageId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_module_page.PAGE_ID
     *
     * @param pageId the value for user_module_page.PAGE_ID
     *
     * @mbggenerated
     */
    public void setPageId(Integer pageId) {
        this.pageId = pageId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_module_page.USER_ID
     *
     * @return the value of user_module_page.USER_ID
     *
     * @mbggenerated
     */
    public String getUserId() {
        return userId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_module_page.USER_ID
     *
     * @param userId the value for user_module_page.USER_ID
     *
     * @mbggenerated
     */
    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_module_page.MODULE_TABLE
     *
     * @return the value of user_module_page.MODULE_TABLE
     *
     * @mbggenerated
     */
    public String getModuleTable() {
        return moduleTable;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_module_page.MODULE_TABLE
     *
     * @param moduleTable the value for user_module_page.MODULE_TABLE
     *
     * @mbggenerated
     */
    public void setModuleTable(String moduleTable) {
        this.moduleTable = moduleTable == null ? null : moduleTable.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_module_page.PAGES
     *
     * @return the value of user_module_page.PAGES
     *
     * @mbggenerated
     */
    public Integer getPages() {
        return pages;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_module_page.PAGES
     *
     * @param pages the value for user_module_page.PAGES
     *
     * @mbggenerated
     */
    public void setPages(Integer pages) {
        this.pages = pages;
    }
}