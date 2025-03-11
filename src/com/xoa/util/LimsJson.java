package com.xoa.util;


import java.util.ArrayList;
import java.util.List;

/**
* @创建作者:李然  Lr
* @方法描述：lims系统所用前后台交互json类
* @创建时间：18:44 2019/7/15
**/
public class LimsJson<T> {
    private Integer count;//返回分页总数
    private String msg;//返回提示语句
    private List<T> data = new ArrayList();//返回集合
    private Object object;//返回对象
    private int code;//返回是否正常标识，如果出现异常，msg给出异常信息.0为正常，1为异常
    private Object obj;//扩展返回
    private boolean flag;

    public Object getObj() {
        return obj;
    }

    public void setObj(Object obj) {
        this.obj = obj;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public LimsJson(){

    }
    public LimsJson(int code, String msg){
        this.code=code;
        this.msg=msg;
    }
    public LimsJson(String msg){
        this.msg=msg;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data) {
        this.data = data;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    public boolean isFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        if (flag == 0) {
            this.flag = true;
        } else {
            this.flag = false;
        }

    }
}
