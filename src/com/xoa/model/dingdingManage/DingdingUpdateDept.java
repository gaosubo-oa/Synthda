package com.xoa.model.dingdingManage;

/**
 * Created by 张雨 on 2018/2/5.
 * 钉钉部门类
 */
public class DingdingUpdateDept {

    private String name;

    private String parentid;

    private long id;

    private String order;

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getParentid() {
        return parentid;
    }

    public void setParentid(String parentid) {
        this.parentid = parentid;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}
