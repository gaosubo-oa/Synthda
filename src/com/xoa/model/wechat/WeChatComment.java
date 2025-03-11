package com.xoa.model.wechat;

import java.util.List;

/**
 * Created by gsb on 2017/10/12.
 */
public class WeChatComment {
    private Integer cid;//唯一自增ID

    private Integer wid;//微博ID

    private Integer uid;//点评用户的UID

    private String message;//点评内容

    private Integer sTime;//点评保存时间

    private String messageUnt;//内容unicode存储

    private String userName;
    private String userAvatar;
    private String time;
    private List<WeChatCommentReply> weChatCommentReplyList;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public List<WeChatCommentReply> getWeChatCommentReplyList() {
        return weChatCommentReplyList;
    }

    public void setWeChatCommentReplyList(List<WeChatCommentReply> weChatCommentReplyList) {
        this.weChatCommentReplyList = weChatCommentReplyList;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getWid() {
        return wid;
    }

    public void setWid(Integer wid) {
        this.wid = wid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getsTime() {
        return sTime;
    }

    public void setsTime(Integer sTime) {
        this.sTime = sTime;
    }

    public String getMessageUnt() {
        return messageUnt;
    }

    public void setMessageUnt(String messageUnt) {
        this.messageUnt = messageUnt;
    }

}
