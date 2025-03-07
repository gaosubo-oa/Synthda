package com.xoa.model.knowledge;

import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.users.UserPriv;

import java.util.List;

public class KnowledgeRoleColumn {
    private String docfileClass;
    private List<SysCode> fileClassList;
    private String privName;
    private Integer deptId;
    private Integer privId;
    private List<Department> deptList;
    private List<UserPriv> privList;
    private String columnName; //临时封装参数，栏目名称

    private Integer roleId;

    private String columnId;

    private String roleName;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getColumnId() {
        return columnId;
    }

    public void setColumnId(String columnId) {
        this.columnId = columnId == null ? null : columnId.trim();
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public List<Department> getDeptList() {
        return deptList;
    }

    public void setDeptList(List<Department> deptList) {
        this.deptList = deptList;
    }

    public List<UserPriv> getPrivList() {
        return privList;
    }

    public void setPrivList(List<UserPriv> privList) {
        this.privList = privList;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Integer getPrivId() {
        return privId;
    }

    public void setPrivId(Integer privId) {
        this.privId = privId;
    }

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName;
    }

    public List<SysCode> getFileClassList() {
        return fileClassList;
    }

    public void setFileClassList(List<SysCode> fileClassList) {
        this.fileClassList = fileClassList;
    }

    public String getDocfileClass() {
        return docfileClass;
    }

    public void setDocfileClass(String docfileClass) {
        this.docfileClass = docfileClass;
    }
}