package com.xoa.model.enclosure;

import java.util.Objects;

/**
 * 附件信息表
 */
public class Attachment {
	/**
	 * 自增唯一Id
	 */
    private Integer aid;
    /**
	 * 位置
	 */
    private Integer position;
    /**
	 * 对应attachment_module表中模块的module_id号
	 */
    private Integer module;
    /**
	 * 年月
	 */
    private String ym;
    /**
  	 * 附件id
  	 */
    private String attachId;
    /**
  	 * 附件文件
  	 */
    private String attachFile;
    /**
  	 * 附件名称
  	 */
    private String attachName;
    /**
  	 * 标记
  	 */
    private Long attachSign;
    /**
  	 * 删除标记(0-未删除,1-已删除)
  	 */
    private Integer delFlag;
    
    private String attUrl;
    
    private String url;
    /**
  	 * 是否是图片(0-是,1-不是)
  	 */
   
    private Integer isImage;
    //上传时间
    private String time;

    private String attStrId;
    private String attStrName;

    private String path;
    private String size;

    private String id;

    private String name;

    // md5码
    private String attachmentMd5;

    // 历史md5码
    private String attachmentMd5Log;

    // 是否被编辑了 0没有 1编辑
    private String modifyType;

    // 上传人
    private String userName;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAttachmentMd5() {
        return attachmentMd5;
    }

    public void setAttachmentMd5(String attachmentMd5) {
        this.attachmentMd5 = attachmentMd5;
    }

    public String getAttachmentMd5Log() {
        return attachmentMd5Log;
    }

    public void setAttachmentMd5Log(String attachmentMd5Log) {
        this.attachmentMd5Log = attachmentMd5Log;
    }

    public String getModifyType() {
        return modifyType;
    }

    public void setModifyType(String modifyType) {
        this.modifyType = modifyType;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSize() {
        return size==null?"":size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getAttStrName() {
        return attStrName;
    }

    public void setAttStrName(String attStrName) {
        this.attStrName = attStrName;
    }

    public Attachment() {

    }

    public String getAttStrId() {
        return attStrId;
    }

    public void setAttStrId(String attStrId) {
        this.attStrId = attStrId;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public Integer getIsImage() {
		return isImage;
	}

	public void setIsImage(Integer isImage) {
		this.isImage = isImage;
	}

	public String getAttUrl() {
		return attUrl;
	}

	public void setAttUrl(String attUrl) {
		this.attUrl = attUrl;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public Integer getModule() {
        return module;
    }

    public void setModule(Integer module) {
        this.module = module;
    }

    public String getYm() {
        return ym;
    }

    public void setYm(String ym) {
        this.ym = ym == null ? null : ym.trim();
    }

    public String getAttachId() {
        return attachId;
    }

    public void setAttachId(String attachId) {
        this.attachId = attachId;
    }

    public String getAttachFile() {
        return attachFile;
    }

    public void setAttachFile(String attachFile) {
        this.attachFile = attachFile == null ? null : attachFile.trim();
    }

    public String getAttachName() {
        return attachName;
    }

    public void setAttachName(String attachName) {
        this.attachName = attachName == null ? null : attachName.trim();
    }

    public Long getAttachSign() {
        return attachSign;
    }

    public void setAttachSign(Long attachSign) {
        this.attachSign = attachSign;
    }

    public Integer getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(Integer delFlag) {
        this.delFlag = delFlag;
    }



    //im返回专用
    private String fileSize;
    private String  thumbnailSize;

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getThumbnailSize() {
		return thumbnailSize;
	}

	public void setThumbnailSize(String thumbnailSize) {
		this.thumbnailSize = thumbnailSize;
	}

    String ATTACH_PRIV;
    public void setATTACH_PRIV(String ATTACH_PRIV) {
        this.ATTACH_PRIV = ATTACH_PRIV;
    }

    public String getATTACH_PRIV() {
        return ATTACH_PRIV;
    }

    //附件类型（一键下载附件时使用）
    private  String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}