package com.xoa.model.sms;

public class SmsBodyIO {
    // 消息类型
    private String smsType;
    // 消息类型名称
    private String smsTypeName;
    //图片路径
    private String smsTypeIcon;
    //未读数量
    private Integer smsCount;
    // 发送人名称
    private String fromName;
    // 短信内容
    private String content;
    // 字符串型发送时间（主要对应导出）
    private String sendTimeStr;
    // 相关url
    private String remindUrl;

    public String getSmsType() {
        return smsType;
    }

    public void setSmsType(String smsType) {
        this.smsType = smsType;
    }

    public String getSmsTypeName() {
        return smsTypeName;
    }

    public void setSmsTypeName(String smsTypeName) {
        this.smsTypeName = smsTypeName;
    }

    public String getSmsTypeIcon() {
        return smsTypeIcon;
    }

    public void setSmsTypeIcon(String smsTypeIcon) {
        this.smsTypeIcon = smsTypeIcon;
    }

    public Integer getSmsCount() {
        return smsCount;
    }

    public void setSmsCount(Integer smsCount) {
        this.smsCount = smsCount;
    }

    public String getFromName() {
        return fromName;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSendTimeStr() {
        return sendTimeStr;
    }

    public void setSendTimeStr(String sendTimeStr) {
        this.sendTimeStr = sendTimeStr;
    }

    public String getRemindUrl() {
        return remindUrl;
    }

    public void setRemindUrl(String remindUrl) {
        this.remindUrl = remindUrl;
    }
}
