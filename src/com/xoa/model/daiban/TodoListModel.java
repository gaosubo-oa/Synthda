package com.xoa.model.daiban;

import com.xoa.model.sms.SmsBodyExtend;

import java.util.List;

public class TodoListModel {

    private String name;
    private String img;
    private String code;
    private Integer count;
    private String type;
    private String url;
    private List<SmsBodyExtend> bodyList;

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

    public String getCode() {
        return code==null?"0":code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getCount() {
        return count==null?0:count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getType() {
        return type==null?"":type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<SmsBodyExtend> getBodyList() {
        return bodyList;
    }

    public void setBodyList(List<SmsBodyExtend> bodyList) {
        this.bodyList = bodyList;
    }
}
