package com.xoa.model.wechat;

import com.xoa.model.enclosure.Attachment;

import java.util.List;

/**
 * Created by gsb on 2017/10/12.
 */
public class WeChat {

    private Integer wid;//唯一自增ID

    private Integer uid;//发讯人

    private String message;//发讯内容

    private Integer sTime;//发讯时间

    private String likeIds;//点赞的UIDS串

    private String fileId;//附件ID串

    private String fileName;//附件名字

    private String app;//此条消息来自于哪个模块

    private Integer appId;//关联业务模块的数据ID

    private String topics;//话题的ID串

    private String topicsName;//话题的名称

    private String atUIds;//@人员的UID串

    private String messageUnt;//内容unicode存储

    private List<Attachment> attachment;

    private Integer isLike;
    private Integer likeNum;
    private String time;
    private String userName;
    private String userAvatar;
    private Integer commentNum;
    private Integer userSex;
    private String userPrivName;
    private String deptName;
    private Integer isSend;
    private String locateInformation;

    public Integer getIsSend() {
        return isSend;
    }

    public void setIsSend(Integer isSend) {
        this.isSend = isSend;
    }

    public Integer getUserSex() {
        return userSex;
    }
    public void setUserSex(Integer userSex) {
        this.userSex = userSex;
    }
    public String getUserPrivName() {
        return userPrivName;
    }
    public void setUserPrivName(String userPrivName) {
        this.userPrivName = userPrivName;
    }

    public String getDeptName() {
        return deptName;
    }
    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }



    public Integer getIsLike() {
        return isLike;
    }
    public void setIsLike(Integer isLike) {
        this.isLike = isLike;
    }

    public Integer getLikeNum() {
        return likeNum;
    }

    public void setLikeNum(Integer likeNum) {
        this.likeNum = likeNum;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
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

    public String getLikeIds() {
        return likeIds;
    }

    public void setLikeIds(String likeIds) {
        this.likeIds = likeIds == null ? null : likeIds.trim();
    }

    public String getFileId() {
        return fileId;
    }

    public void setFileId(String fileId) {
        this.fileId = fileId == null ? null : fileId.trim();
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public String getApp() {
        return app;
    }

    public void setApp(String app) {
        this.app = app == null ? null : app.trim();
    }

    public Integer getAppId() {
        return appId;
    }

    public void setAppId(Integer appId) {
        this.appId = appId ;
    }

    public String getTopics() {
        return topics;
    }

    public void setTopics(String topics) {
        this.topics = topics == null ? null : topics.trim();
    }

    public String getTopicsName() {
        return topicsName;
    }

    public void setTopicsName(String topicsName) {
        this.topicsName = topicsName == null ? null : topicsName.trim();
    }

    public String getAtUIds() {
        return atUIds;
    }

    public void setAtUIds(String atUIds) {
        this.atUIds = atUIds == null ? null : atUIds.trim();
    }

    public String getMessageUnt() {
        return messageUnt;
    }

    public void setMessageUnt(String messageUnt) {
        this.messageUnt = messageUnt;
    }

    public List<Attachment> getAttachment() {
        return attachment ;
    }

    public void setAttachment(List<Attachment> attachment) {
        this.attachment = attachment;
    }

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

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    public String getLocateInformation() {
        return locateInformation;
    }

    public void setLocateInformation(String locateInformation) {
        this.locateInformation = locateInformation;
    }
}
