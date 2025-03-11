package com.xoa.model.attendance;

/**
 * 考勤排班设置列表
 */
public class AttendScheduleWithBLOBs extends AttendSchedule {
    /**
     * 部门ID 串
     */
    private String deptId;
    /**
     * 部门名称 串
     */
    private String deptName;

    /**
     * 角色ID 串
     */
    private String privId;

    /**
     * 角色名称 串
     */
    private String privName;

    /**
     * 用户ID 串
     */
    private String userId;
    /**
     * 用户名称 串
     */
    private String userName;

    /**
     * 全部应用人员
     */
    private String useUsers;

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUseUsers() {
        return useUsers;
    }

    public void setUseUsers(String useUsers) {
        this.useUsers = useUsers;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId == null ? null : deptId.trim();
    }

    public String getPrivId() {
        return privId;
    }

    public void setPrivId(String privId) {
        this.privId = privId == null ? null : privId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}