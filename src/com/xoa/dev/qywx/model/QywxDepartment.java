package com.xoa.dev.qywx.model;

/**
 * Created by Administrator on 2019/6/24.
 */
public class QywxDepartment {

    // 部门id
    private Integer id;

    // 部门名称
    private String name;

    // 父部门id id=1为根部门
    private Integer parentid;

    // 排序号 越大越靠前
    private String order;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }
}
