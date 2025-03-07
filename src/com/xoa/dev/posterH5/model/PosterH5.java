package com.xoa.dev.posterH5.model;

import com.xoa.model.enclosure.Attachment;

import java.awt.*;
import java.util.List;

/**
 * 创建作者: 李彦洁
 * 创建日期: 2022/3/2 11:22
 * 类介绍:
 **/
public class PosterH5 {
    private String companyName;  // 单位名称
    private String booth;  // 展位
    private String introduce;// 业务介绍

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
}
