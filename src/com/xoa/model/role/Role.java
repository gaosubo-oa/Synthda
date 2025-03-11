package com.xoa.model.role;

import com.xoa.model.users.Users;

import java.io.Serializable;
import java.util.List;

public class Role implements Serializable {
	/**
	 * 角色ID
	 */
    private Integer userPriv;
    /**
	 * 角色名称
	 */
    private String privName;
    /**
	 * 角色编码
	 */
    private Short privNo;
    /**
	 * 角色对应的功能ID串
	 */
    private String funcIdStr;
    /**
	 * 所属部门
	 */
    private Integer privDeptId;
    /**
	 * 角色类型(0-普通,1-OA管理员,2-分支机构管理员)
	 */
    private Integer privType;
    /**
	 * 全局角色(0-系统全局角色,1-部门私有角色,2-机构全局角色)
	 */
    private Integer isGlobal;
    
    private List<Users>  users;
    public List<Users> getUsers() {
		return users;
	}

	public void setUsers(List<Users> users) {
		this.users = users;
	}

	public Integer getUserPriv() {
        return userPriv;
    }

    public void setUserPriv(Integer userPriv) {
        this.userPriv = userPriv;
    }

    public String getPrivName() {
        return privName;
    }

    public void setPrivName(String privName) {
        this.privName = privName == null ? null : privName.trim();
    }

    public Short getPrivNo() {
        return privNo;
    }

    public void setPrivNo(Short privNo) {
        this.privNo = privNo;
    }

    public String getFuncIdStr() {
        return funcIdStr;
    }

    public void setFuncIdStr(String funcIdStr) {
        this.funcIdStr = funcIdStr == null ? null : funcIdStr.trim();
    }

    public Integer getPrivDeptId() {
        return privDeptId;
    }

    public void setPrivDeptId(Integer privDeptId) {
        this.privDeptId = privDeptId;
    }

    public Integer getPrivType() {
        return privType;
    }

    public void setPrivType(Integer privType) {
        this.privType = privType;
    }

    public Integer getIsGlobal() {
        return isGlobal;
    }

    public void setIsGlobal(Integer isGlobal) {
        this.isGlobal = isGlobal;
    }
}