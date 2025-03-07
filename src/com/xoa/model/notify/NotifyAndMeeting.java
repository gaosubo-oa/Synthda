package com.xoa.model.notify;

import java.util.Date;
import java.util.Map;

//公文门户中公告模块显示公告和会议的数据
public class NotifyAndMeeting {
    private String subject;//标题名
    private Date sendTime;//发送时间
    private String url;//打开路径
    private Integer modelType;//1、公告    2、会议    3、视频会议
    private String author;
    private Map<String,Object> mps;//视频会议的数据集合

    public Map<String, Object> getMps() {
        return mps;
    }

    public void setMps(Map<String, Object> mps) {
        this.mps = mps;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getModelType() {
        return modelType;
    }

    public void setModelType(Integer modelType) {
        this.modelType = modelType;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
