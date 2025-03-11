package com.xoa.util.common;

import java.util.List;

//下拉树实体，存储下拉搜索参数
public class DataTree<T> {
    private List<T> children;//子类信息
    private String name;//树名
    private int id;//树的id
    private boolean isLeaf;//是否有子集，无true,有false
    private boolean open; //true:开启节点，false不开启节点

    public boolean isOpen() {
        return open;
    }
    public void setOpen(boolean open) {
        this.open = open;
    }

    public List<T> getChildren() {
        return children;
    }
    public void setChildren(List<T> children) {
        this.children = children;
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
}