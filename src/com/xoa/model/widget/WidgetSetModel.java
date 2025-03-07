package com.xoa.model.widget;

import java.util.List;

/**
 * Created by gsb on 2017/7/19.
 */
public class WidgetSetModel {

    // id
    private Integer id;

    // 用户id
    private Integer uid;

    // 类型
    private String type;

    // 门户模型id串
    private String moduleIds;

    // 背景
    private String bg;

    // 正在使用的模块
    private List<WidgetModel> on;

    // 未使用的模块
    private List<WidgetModel> off;

    // 所有模块的总数
    private Integer count;

    private List<WidgetDataModel> data;

    public String getBg() {
        return bg;
    }

    public void setBg(String bg) {
        this.bg = bg;
    }

    public List<WidgetDataModel> getData() {
        return data;
    }

    public void setData(List<WidgetDataModel> data) {
        this.data = data;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getModuleIds() {
        return moduleIds;
    }

    public void setModuleIds(String moduleIds) {
        this.moduleIds = moduleIds;
    }

    public List<WidgetModel> getOn() {
        return on;
    }

    public void setOn(List<WidgetModel> on) {
        this.on = on;
    }

    public List<WidgetModel> getOff() {
        return off;
    }

    public void setOff(List<WidgetModel> off) {
        this.off = off;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
