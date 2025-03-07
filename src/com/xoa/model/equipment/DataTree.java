package com.xoa.model.equipment;

import java.util.List;

/**
* 创建作者:   刘欢
* 创建日期:   9:34 2019/8/13
* 方法介绍:   下拉树实体，存储下拉搜索参数，数据格式参考设备台账新增中下拉设备类型
* 参数说明:   * @param null
* @return
*/
//
public class DataTree {

    private List<DataTree> children;//子类信息
    private String name;//树名
    private int id;//树的id
    private boolean isLeaf;//是否有子集，无true,有false
    private String status; //状态；
    private String label;
    private  Integer  sort;
    public Integer getSort() {
        return sort;
    }
    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public void setChildren(List<DataTree> children) {
        this.children = children;
    }
    public List<DataTree> getChildren() {
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
}