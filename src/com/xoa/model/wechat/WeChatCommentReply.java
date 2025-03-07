package com.xoa.model.wechat;

/**
 * Created by gsb on 2017/10/12.
 */
public class WeChatCommentReply {

    private Integer rid;//唯一自增ID

    private String message;//回复内容

    private Integer rTime;//回复时间

    private Integer uid;//回复人

    private Integer cid;//评论ID

    private Integer tid;//评论的对象

    private Integer wid;//微讯ID

    private Integer messageUnt;//内容unicode存储

    private String userName;
    private String userAvatar;
    private String time;
    private String toName;
    private String toAvatar;
//    private String fileName;
//
//    public String getFileName() {
//        return fileName;
//    }
//
//    public void setFileName(String fileName) {
//        this.fileName = fileName;
//    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getToAvatar() {
        return toAvatar;
    }

    public void setToAvatar(String toAvatar) {
        this.toAvatar = toAvatar;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public Integer getRid() {
        return rid;
    }

    public void setRid(Integer rid) {
        this.rid = rid;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getrTime() {
        return rTime;
    }

    public void setrTime(Integer rTime) {
        this.rTime = rTime;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer getWid() {
        return wid;
    }

    public void setWid(Integer wid) {
        this.wid = wid;
    }

    public Integer getMessageUnt() {
        return messageUnt;
    }

    public void setMessageUnt(Integer messageUnt) {
        this.messageUnt = messageUnt;
    }

}
