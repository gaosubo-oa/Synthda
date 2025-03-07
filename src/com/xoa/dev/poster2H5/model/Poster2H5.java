package com.xoa.dev.poster2H5.model;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * 创建作者: 李彦洁
 * 创建日期: 2022/3/4 14:17
 * 类介绍:
 **/
public class Poster2H5 {
    private String companyName;  // 单位名称
    private String booth;  // 展位
    private String introduce;// 业务介绍

    private String forumTime; // 论坛时间
    private String forumTimeSlot; // 论坛时间段
    private String forumPlace;// 论坛地点
    private String forumName; // 论坛名称

    private int forumState; // 论坛状态  0: 不选中  1: 选中

    private String attachmentId; // 附件id
    private String attachmentName; // 附件名称
    private String attachmentSuffix; // 附件后缀
    private Integer attachmentSize; // 附件大小
    private String attachmentPath; // 附件路径

    private String posterUrl; // 生成海报的路径

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getBooth() {
        return booth;
    }

    public void setBooth(String booth) {
        this.booth = booth;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public String getForumTime() {
        return forumTime;
    }

    public void setForumTime(String forumTime) {
        this.forumTime = forumTime;
    }

    public String getForumPlace() {
        return forumPlace;
    }

    public void setForumPlace(String forumPlace) {
        this.forumPlace = forumPlace;
    }

    public String getForumName() {
        return forumName;
    }

    public void setForumName(String forumName) {
        this.forumName = forumName;
    }

    public String getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getAttachmentSuffix() {
        return attachmentSuffix;
    }

    public void setAttachmentSuffix(String attachmentSuffix) {
        this.attachmentSuffix = attachmentSuffix;
    }

    public Integer getAttachmentSize() {
        return attachmentSize;
    }

    public void setAttachmentSize(Integer attachmentSize) {
        this.attachmentSize = attachmentSize;
    }

    public String getAttachmentPath() {
        return attachmentPath;
    }

    public void setAttachmentPath(String attachmentPath) {
        this.attachmentPath = attachmentPath;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public String getForumTimeSlot() {
        return forumTimeSlot;
    }

    public void setForumTimeSlot(String forumTimeSlot) {
        this.forumTimeSlot = forumTimeSlot;
    }

    public int getForumState() {
        return forumState;
    }

    public void setForumState(int forumState) {
        this.forumState = forumState;
    }
}
