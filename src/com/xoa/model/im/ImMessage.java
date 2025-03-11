package com.xoa.model.im;


public class ImMessage{
	

    private Integer imid;//自增唯一ID

    private String fromUid;//发消息人云办公UID
    private String toUid;//发消息人云办公UID
    private String ofFrom;//OF发消息人
    private String ofTo;//OF收消息人
    private String thumbnailUrl;//
    private String stime;//发送时间
    private String atime;//入库时间
    private String type;//消息类型  DEFAULT 'text'
    private String dflag;//'删除标记（0未删除，1已删除）
    private String msgType;//会话类型（1单聊，2群聊）
    private String uuid;
    private String content;//纯文本消息内容
    private String fileId;//附件ID串
    private String fileName;//附件文件名串
    private String realUrl;
    private String toUserName;
    private String FromUserName;


    public String getToUserName() {
        return toUserName;
    }

    public void setToUserName(String toUserName) {
        this.toUserName = toUserName;
    }

    public String getFromUserName() {
        return FromUserName;
    }

    public void setFromUserName(String fromUserName) {
        FromUserName = fromUserName;
    }

    public String getRealUrl() {
        return realUrl;
    }

    public void setRealUrl(String realUrl) {
        this.realUrl = realUrl;
    }

    public String getContent() {
        return content;
    }

     public void setContent(String content) {
        this.content = content == null ? null : content.trim();
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
    public Integer getImid() {
        return imid;
    }

    public void setImid(Integer imid) {
        this.imid = imid;
    }

    public String getFromUid() {
        return fromUid;
    }

    public void setFromUid(String fromUid) {
        this.fromUid = fromUid == null ? null : fromUid.trim();
    }

    public String getToUid() {
        return toUid;
    }

    public void setToUid(String toUid) {
        this.toUid = toUid == null ? null : toUid.trim();
    }

    public String getOfFrom() {
        return ofFrom;
    }

    public void setOfFrom(String ofFrom) {
        this.ofFrom = ofFrom == null ? null : ofFrom.trim();
    }

    public String getOfTo() {
        return ofTo;
    }

    public void setOfTo(String ofTo) {
        this.ofTo = ofTo == null ? null : ofTo.trim();
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl == null ? null : thumbnailUrl.trim();
    }

    public String getStime() {
        return stime;
    }

    public void setStime(String stime) {
        this.stime = stime == null ? null : stime.trim();
    }

    public String getAtime() {
        return atime;
    }

    public void setAtime(String atime) {
        this.atime = atime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getDflag() {
        return dflag;
    }

    public void setDflag(String dflag) {
        this.dflag = dflag == null ? null : dflag.trim();
    }

    public String getMsgType() {
        return msgType;
    }

    public void setMsgType(String msgType) {
        this.msgType = msgType == null ? null : msgType.trim();
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid == null ? null : uuid.trim();
    }
}