package com.xoa.model.sms;

public class SmsBodyExtend extends  SmsBody {
    private String avater;//头像
    private String img;//图片
    private Integer qid;//主键id
    private Integer readflag;//真实步骤ID
    private String type;//类型
    private String time;//时间
    private String userName;//用户姓名
    private String subject;//内容
    private Integer fromUid;//发送人Uid
    private String fromName;//发送人UserId
    private Integer uid;//用户id
    private Integer flowId;//流程id
    private Integer runId;//runId
    private Integer step;//流程步骤
    private String handleType;//办理状态（待办已办）
    private String sex;
    private String prcsId; // 流程步骤
    private String flowPrcs; // 流程设计器中的设计步骤
    private String feedback; // 是否允许会签
    private String signlock; // 会签意见可见性(0-总是可见,1-本步骤经办人之间不可见,2-针对其他步骤不可见
    private String feedSecretType; // 是否允许密送 0不允许 1允许
    private String feedbackPriv;    //传阅是否允许填写会签意见（0否,1是）

    public String getFeedSecretType() {
        return feedSecretType;
    }

    public void setFeedSecretType(String feedSecretType) {
        this.feedSecretType = feedSecretType;
    }

    public String getPrcsId() {
        return prcsId;
    }

    public void setPrcsId(String prcsId) {
        this.prcsId = prcsId;
    }

    public String getFlowPrcs() {
        return flowPrcs;
    }

    public void setFlowPrcs(String flowPrcs) {
        this.flowPrcs = flowPrcs;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getSignlock() {
        return signlock;
    }

    public void setSignlock(String signlock) {
        this.signlock = signlock;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getHandleType() {
        return handleType;
    }

    public void setHandleType(String handleType) {
        this.handleType = handleType;
    }

    public Integer getReadflag() {
        return readflag;
    }

    public void setReadflag(Integer readflag) {
        this.readflag = readflag;
    }

    public String getAvater() {
        return avater;
    }

    public void setAvater(String avater) {
        this.avater = avater;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getQid() {
        return qid;
    }

    public void setQid(Integer qid) {
        this.qid = qid;
    }



    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }



    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Integer getFromUid() {
        return fromUid;
    }

    public void setFromUid(Integer fromUid) {
        this.fromUid = fromUid;
    }

    @Override
    public String getFromName() {
        return fromName;
    }

    @Override
    public void setFromName(String fromName) {
        this.fromName = fromName;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getFlowId() {
        return flowId;
    }

    public void setFlowId(Integer flowId) {
        this.flowId = flowId;
    }

    public Integer getRunId() {
        return runId;
    }

    public void setRunId(Integer runId) {
        this.runId = runId;
    }

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    public String getFeedbackPriv() {
        return feedbackPriv;
    }

    public void setFeedbackPriv(String feedbackPriv) {
        this.feedbackPriv = feedbackPriv;
    }
}
