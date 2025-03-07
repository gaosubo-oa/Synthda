package com.xoa.model.modulePriv;

import java.io.Serializable;
import java.util.List;

/**
 * Created by gsb on 2017/6/27.
 */
public class ModulePriv implements Serializable{

    private Integer uid;

    private Integer moduleId;

    private String deptPriv;

    private String rolePriv;

    private String deptId;

    private String deptName;

    private String privId;

    private String privName;

    private String userId;

    private String userName;

    private String description;

    private String moduleName;

    private List<ModulePriv> otherModulePrivs;

    public ModulePriv(Integer moduleId,String description,String moduleName) {
        this.moduleId = moduleId;
        this.description = description;
        this.moduleName = moduleName;
    }

    public ModulePriv() {
    }

    public ModulePriv(Integer uid, Integer moduleId, String deptPriv, String rolePriv, String deptId, String privId, String userId) {
        this.uid = uid;
        this.moduleId = moduleId;
        this.deptPriv = deptPriv;
        this.rolePriv = rolePriv;
        this.deptId = deptId;
        this.privId = privId;
        this.userId = userId;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getDeptPriv() {
        return deptPriv;
    }

    public void setDeptPriv(String deptPriv) {
        this.deptPriv = deptPriv;
    }

    public String getRolePriv() {
        return rolePriv;
    }

    public void setRolePriv(String rolePriv) {
        this.rolePriv = rolePriv;
    }

    public String getDeptId() {
        return deptId==null?"":deptId.trim();
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public String getPrivId() {
        return privId==null?"":privId.trim();
    }

    public void setPrivId(String privId) {
        this.privId = privId;
    }

    public String getUserId() {
        return userId==null?"":userId.trim();
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public List<ModulePriv> getOtherModulePrivs() {
        return otherModulePrivs;
    }

    public void setOtherModulePrivs(List<ModulePriv> otherModulePrivs) {
        this.otherModulePrivs = otherModulePrivs;
    }
}
