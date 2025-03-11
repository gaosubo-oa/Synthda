package com.xoa.model.department;

import java.io.Serializable;
import java.util.List;

/**
 * 类介绍  :   部门简易版
 * 构造参数:   无
 *
 */
public class DepartmentVO implements Serializable {
    /**
     * 自增唯一ID
     */
    private Integer deptId;
    /**
     * 部门名称
     */
    private String deptName;
    /**
     * 部门排序号
     */
    private String deptNo;
    /**
     * 上级部门ID
     */
    private Integer deptParent;
    /**
     * 是否是分支机构(0-否,1-是)
     */
    private String isOrg;
    /**
     * 部门是否失效（1有效   0失效）
     */
    private Integer deptDisplay;

    //是否有子集，无true,有false
    private boolean isLeaf;

    //是否拥有子部门
    private String isHaveCh;

    private List<DepartmentVO> child;

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean leaf) {
        isLeaf = leaf;
    }

    public String getIsHaveCh() {
        return isHaveCh;
    }

    public void setIsHaveCh(String isHaveCh) {
        this.isHaveCh = isHaveCh;
    }

    public List<DepartmentVO> getChild() {
        return child;
    }

    public void setChild(List<DepartmentVO> child) {
        this.child = child;
    }

    public String getDeptName() {
        return deptName == null ? "" : deptName.trim();
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? "" : deptName.trim();
    }

    public String getDeptNo() {
        return deptNo== null ? "" : deptNo.trim();
    }

    public void setDeptNo(String deptNo) {
        this.deptNo = deptNo == null ? "" : deptNo.trim();
    }

    public Integer getDeptParent() {
        return deptParent;
    }

    public void setDeptParent(Integer deptParent) {
        this.deptParent = deptParent;
    }

    public String getIsOrg() {
        return isOrg == null ? "" : isOrg.trim();
    }

    public void setIsOrg(String isOrg) {
        this.isOrg = isOrg == null ? "" : isOrg.trim();
    }

    @Override
    public String toString() {
        return "Department{" +
                "deptId=" + deptId +
                ", deptName='" + deptName + '\'' +
                ", deptNo='" + deptNo + '\'' +
                ", deptParent=" + deptParent +
                ", isOrg='" + isOrg + '\'' +
                ", isHaveCh='" + isHaveCh + '\'' +
                ", child=" + child +
                '}';
    }

    public Integer getDeptDisplay() {
        return deptDisplay;
    }

    public void setDeptDisplay(Integer deptDisplay) {
        this.deptDisplay = deptDisplay;
    }
}