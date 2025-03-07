package com.xoa.util;

import java.util.List;

public class LimsDataTree {

    private List<LimsDataTree> children;//子类信息
    private String name;//树名
    private int id;//树的id
    private String label;//树结构名称
    private boolean isLeaf;//是否有子集，无true,有false
    private String status; //状态；


    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public void setChildren(List<LimsDataTree> children) {
        this.children = children;
    }
    public List<LimsDataTree> getChildren() {
        return children;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }

    public void setIsLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }
    public boolean getIsLeaf() {
        return isLeaf;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}
