package com.xoa.model.sms;

import com.xoa.util.DateFormat;

import java.util.List;

public class SmsBody {
    // 主键
    private Integer bodyId;
    // 发送人id
    private String fromId;
    // 发送人名称
    private String fromName;
    // 消息类型
    private String smsType;
    // 消息类型名称
    private String smsTypeName;
    // 发送时间
    private Integer sendTime;
    // 字符串型发送时间（主要对应导出）
    private String sendTimeStr;
    // 相关url
    private String remindUrl;
    // 短信内容
    private String content;
    // 收信人
    private String toId;
    // 收信人名称
    private String toName;
    //接收标记(0-已阅读,1-未阅读,2-未阅读已弹出)
    private String remindFlag;
    // 是否提醒
    private String remindStr;
    //删除标记(0-没删除,1-收信人删除,2-发信人删除)
    private String deleteFlag;

    private String title;//主题

    private String editFlag;
    private Integer smsId;

    public Integer getSmsId() {
        return smsId;
    }

    public void setSmsId(Integer smsId) {
        this.smsId = smsId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    private List<Sms> smsList;
    private String isAttach;//是否有附件

    public String getIsAttach() {
        return isAttach==null?"0":isAttach;
    }

    public void setIsAttach(String isAttach) {
        this.isAttach = isAttach;
    }

    public SmsBody() {
    }


    public Integer getBodyId() {
        return bodyId;
    }

    public void setBodyId(Integer bodyId) {
        this.bodyId = bodyId;
    }

    public String getFromId() {
        return fromId;
    }

    public void setFromId(String fromId) {
        this.fromId = fromId == null ? null : fromId.trim();
    }

    public String getSmsType() {
        return smsType==null?"":smsType;
    }

    public void setSmsType(String smsType) {
        this.smsType = smsType == null ? null : smsType.trim();
    }

    public Integer getSendTime() {
        return sendTime;
    }

    public void setSendTime(Integer sendTime) {
        this.sendTime = sendTime;
    }

    public String getRemindUrl() {
        return remindUrl;
    }

    public void setRemindUrl(String remindUrl) {
        this.remindUrl = remindUrl == null ? null : remindUrl.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getFromName() {
        return fromName;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public String getToId() {
        return toId;
    }

    public void setToId(String toId) {
        this.toId = toId;
    }

    public String getToName() {
        return toName;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }

    public List<Sms> getSmsList() {
        return smsList;
    }

    public void setSmsList(List<Sms> smsList) {
        this.smsList = smsList;
    }

    public String getRemindFlag() {
        return remindFlag;
    }

    public void setRemindFlag(String remindFlag) {
        this.remindFlag = remindFlag;
    }

    public String getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public String getSmsTypeName() {
        return smsTypeName;
    }

    public void setSmsTypeName(String smsTypeName) {
        this.smsTypeName = smsTypeName;
    }

    public String getSendTimeStr() {
        sendTimeStr = DateFormat.getDateStrTime(sendTime);
        return sendTimeStr;
    }

    public void setSendTimeStr(String sendTimeStr) {
        this.sendTimeStr = sendTimeStr;
    }

    public String getRemindStr() {
        if(remindFlag!=null){
            return remindFlag.equals("0")?"否":"是";
        }else{
            return "是";
        }

    }

    public void setRemindStr(String remindStr) {
        this.remindStr = remindStr;
    }

    public SmsBody(String fromId,  String smsType, Integer sendTime, String remindUrl, String content) {
        this.fromId = fromId;
        this.smsType = smsType;
        this.sendTime = sendTime;
        this.remindUrl = remindUrl;
        this.content = content;
    }

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }
}