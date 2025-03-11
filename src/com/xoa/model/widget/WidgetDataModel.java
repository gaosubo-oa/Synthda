package com.xoa.model.widget;

import java.util.List;

/**
 * 作者：张航宁
 */
public class WidgetDataModel<T> {

    private String data;
    private String name;
    private String img;
    private Integer number;
    private List<T> data_info;
    private Object object;

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public List<T> getData_info() {
        return data_info;
    }

    public void setData_info(List<T> data_info) {
        this.data_info = data_info;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
