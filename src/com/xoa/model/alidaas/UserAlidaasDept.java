package com.xoa.model.alidaas;

public class UserAlidaasDept {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_alidaas_dept.DEPT_ID
     *
     * @mbggenerated
     */
    private Integer deptId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column user_alidaas_dept.ORGANIZATION_UUID
     *
     * @mbggenerated
     */
    private String organizationUuid;

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_alidaas_dept.DEPT_ID
     *
     * @return the value of user_alidaas_dept.DEPT_ID
     *
     * @mbggenerated
     */
    public Integer getDeptId() {
        return deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_alidaas_dept.DEPT_ID
     *
     * @param deptId the value for user_alidaas_dept.DEPT_ID
     *
     * @mbggenerated
     */
    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column user_alidaas_dept.ORGANIZATION_UUID
     *
     * @return the value of user_alidaas_dept.ORGANIZATION_UUID
     *
     * @mbggenerated
     */
    public String getOrganizationUuid() {
        return organizationUuid;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column user_alidaas_dept.ORGANIZATION_UUID
     *
     * @param organizationUuid the value for user_alidaas_dept.ORGANIZATION_UUID
     *
     * @mbggenerated
     */
    public void setOrganizationUuid(String organizationUuid) {
        this.organizationUuid = organizationUuid == null ? null : organizationUuid.trim();
    }

    private String type;

    public String getType() { return type; }

    public void setType(String type) { this.type = type; }

    private String deptName;

    public String getDeptName() { return deptName; }

    public void setDeptName(String deptName) { this.deptName = deptName; }

    private String company;

    public String getCompany() { return company; }

    public void setCompany(String company) { this.company = company; }
}