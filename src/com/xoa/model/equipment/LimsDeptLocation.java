package com.xoa.model.equipment;

public class LimsDeptLocation {
    private Integer id;

    private Integer deptId;

    private String positionCode;

    private Integer pid;

    private String label;

    private String memo;

    private Integer locatSort;

    private Boolean isLeaf=true;

    public Boolean getIsLeaf(){return isLeaf;}

    public void setIsLeaf(Boolean isLeaf){this.isLeaf=isLeaf;}

    public Integer getLocatSort(){ return locatSort;}

    public void setLocatSort(Integer locatSort){ this.locatSort=locatSort;}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getPositionCode() {
        return positionCode;
    }

    public void setPositionCode(String positionCode) {
        this.positionCode = positionCode == null ? null : positionCode.trim();
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label == null ? null : label.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}