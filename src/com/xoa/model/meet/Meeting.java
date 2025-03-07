package com.xoa.model.meet;

import com.xoa.model.enclosure.Attachment;

import java.util.List;

public class Meeting {
    private Integer sid;//自增id

    private String createTime;//新建时间

    private String  createQrcodeTime;//生成二维码时间

    private String signInTime;//会议打卡时间

    public String getSignInTime() {
        return signInTime;
    }

    public void setSignInTime(String signInTime) {
        this.signInTime = signInTime;
    }

    public String getCreateQrcodeTime() {
        return createQrcodeTime;
    }

    public void setCreateQrcodeTime(String createQrcodeTime) {
        this.createQrcodeTime = createQrcodeTime;
    }

    private String endTime;

    private Integer isWriteCalednar;//是否写入日程安排,0：不写入，1：写入

    private String meetName;//会议名称

    private Integer resendHour;//提醒设置：提前几个小时提醒

    private Integer resendMinute;//提前分钟小时提醒

    private Integer resendSeveral;//提醒设置：提醒几次

    private String sms2Remind;//手机短信提醒出席人员,0：不提醒，1：提醒

    private String smsRemind;//是否内部短信通知出席人员，使用内部短信提醒，选中为1，不选中为0

    private String startTime;

    private Integer status;//会议状态 1-待批 2-已批准 3-进行中 4-未批准 5-已结束

    private String statusName;

    private String subject;//会议主题

    private Integer managerId;//审批管理员\

    private String managerName;//审批管理员名字

    private String manageUserId;

    private Integer meetRoomId;//所属会议室的id

    private String meetRoomName;//所属会议室的id

    private Integer uid;//申请人

    private String userId;

    private String userName;//申请人姓名

    private Integer recorderId;//会议纪要员

    private String recorderName;//会议纪要员名字

    private String recorderUserId;

    private String isuploadsummary;//会议纪要状态

    private String currentTime;//当前时间

    private Integer pendingCount;//待审批数量

    private Integer cyclePendingCount;//周期性会议待审批数量

    private Integer approvedCount;//已批准数量

    private Integer processingCount;//进行中数量

    private Integer notApprovedCount;//未批准数量

    private Integer overCount;//已结束数量

    private String attachmentId;//会议附件Id

    private String attachmentName;//会议附件名字

    private String summaryAttachmentId;//会议纪要附件ID

    private String summaryAttachmentName;//会议纪要附件名字

    private List summaryAttachmentList;//会议纪要附件集合

    private String mProposer;// 通达会议表中的申请人字段，用来进行通达数据升级后同步uid

    private String mManager;// 通达会议表中的管理员字段，用来进行通达数据升级后同步uid
    private String mobileNo;

    //不批准意见
    private String reason;

    //是否是视频会议(0否,1是)
    private String videoConfFlag;

    //服务端会议室ID
    private String videoConfId;

    //MEET_CODE会议验证码
    private String meetCode;

    private String cycle;

    private Integer cycleNo;

    private String approveName;

    //因好几个字段 都没在实体加   现在加上2021、6、30 李金昊
    private String sendName;

    private String toScope;

    private String toEmail;
    //附件集合
    List<Attachment> attachmentList;

    private String serviceUser;

    private String serviceUserUserId;

    private String serviceUserName;

    private String photoId;//会议照片ID串

    private String photoName;//会议照片名称串

    private List photoList;

    private String videoId;//会议录像ID串

    private String videoName;//会议录像名称串

    private List videoList;

    private String recordId;//会议录音ID串

    private String recordName;//会议录音名称串

    private List recordList;

    private List minutesList;

    private String registerPhotoId;//会议打卡总照片ID串

    private String registerPhotoName;//会议纪总照片名称串

    private List registerPhotoList;

    private String handwritingSignYn;//是否开启手写打卡(0-不开启、1-开启)

    private String agendaId;

    private String agendaName;

    private List agendaList;

    public String getPhotoId() {
        return photoId;
    }

    public void setPhotoId(String photoId) {
        this.photoId = photoId;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getVideoName() {
        return videoName;
    }

    public void setVideoName(String videoName) {
        this.videoName = videoName;
    }

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getRecordName() {
        return recordName;
    }

    public void setRecordName(String recordName) {
        this.recordName = recordName;
    }

    public String getRegisterPhotoId() {
        return registerPhotoId;
    }

    public void setRegisterPhotoId(String registerPhotoId) {
        this.registerPhotoId = registerPhotoId;
    }

    public String getRegisterPhotoName() {
        return registerPhotoName;
    }

    public void setRegisterPhotoName(String registerPhotoName) {
        this.registerPhotoName = registerPhotoName;
    }

    public String getHandwritingSignYn() {
        return handwritingSignYn;
    }

    public void setHandwritingSignYn(String handwritingSignYn) {
        this.handwritingSignYn = handwritingSignYn;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getMeetCode() {
        return meetCode;
    }

    public void setMeetCode(String meetCode) {
        this.meetCode = meetCode;
    }

    public String getVideoConfId() {
        return videoConfId;
    }

    public void setVideoConfId(String videoConfId) {
        this.videoConfId = videoConfId;
    }

    public String getVideoConfFlag() {
        return videoConfFlag;
    }

    public void setVideoConfFlag(String videoConfFlag) {
        this.videoConfFlag = videoConfFlag;
    }

    public String getMobileNo() {
        return mobileNo ==null?"":mobileNo;
    }

    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    public String getCycle() {
        return cycle;
    }

    public void setCycle(String cycle) {
        this.cycle = cycle;
    }

    public Integer getCycleNo() {
        return cycleNo;
    }

    public void setCycleNo(Integer cycleNo) {
        this.cycleNo = cycleNo;
    }

    public Integer getCyclePendingCount() {
        return cyclePendingCount;
    }

    public void setCyclePendingCount(Integer cyclePendingCount) {
        this.cyclePendingCount = cyclePendingCount;
    }

    public String getmManager() {
        return mManager;
    }

    public void setmManager(String mManager) {
        this.mManager = mManager;
    }

    public String getmProposer() {
        return mProposer;
    }

    public void setmProposer(String mProposer) {
        this.mProposer = mProposer;
    }

    public List<Attachment> getAttachmentList() {
        return attachmentList;
    }

    public void setAttachmentList(List<Attachment> attachmentList) {
        this.attachmentList = attachmentList;
    }


    public String getAttachmentId() {
        return attachmentId==null?"":attachmentId;
    }

    public void setAttachmentId(String attachmentId) {
        this.attachmentId = attachmentId;
    }

    public String getAttachmentName() {
        return attachmentName==null?"":attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public String getManagerName() {
        return managerName==null?"":managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public void setRecorderName(String recorderName) {
        this.recorderName = recorderName;
    }

    public String getRecorderName() {
        return recorderName==null?"":recorderName;
    }

    public String getCurrentTime() {
        return currentTime;
    }

    public void setCurrentTime(String currentTime) {
        this.currentTime = currentTime;
    }

    public String getStatusName() {
        return statusName==null?"":statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getMeetRoomName() {
        return meetRoomName==null?"":meetRoomName;
    }

    public void setMeetRoomName(String meetRoomName) {
        this.meetRoomName = meetRoomName;
    }

    public String getUserName() {
        return userName==null?"":userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getCreateTime() {

        return createTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public String getStartTime() {
        return startTime;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getIsWriteCalednar() {
        return isWriteCalednar;
    }

    public void setIsWriteCalednar(Integer isWriteCalednar) {
        this.isWriteCalednar = isWriteCalednar;
    }

    public String getMeetName() {
        return meetName;
    }

    public void setMeetName(String meetName) {
        this.meetName = meetName == null ? null : meetName.trim();
    }

    public Integer getResendHour() {
        return resendHour==null?0:resendHour;
    }

    public void setResendHour(Integer resendHour) {
        this.resendHour = resendHour;
    }

    public Integer getResendMinute() {
        return resendMinute==null?0:resendMinute;
    }

    public void setResendMinute(Integer resendMinute) {
        if(resendMinute==null){
            this.resendMinute=0;
        }else{
            this.resendMinute = resendMinute;
        }
    }

    public Integer getResendSeveral() {
        return resendSeveral==null?0:resendSeveral;
    }

    public void setResendSeveral(Integer resendSeveral) {
        if(resendSeveral==null){
            this.resendSeveral=0;
        }else{
            this.resendSeveral = resendSeveral;
        }
    }

    public String getSms2Remind() {
        return sms2Remind;
    }

    public void setSms2Remind(String sms2Remind) {
        this.sms2Remind = sms2Remind == null ? null : sms2Remind.trim();
    }

    public String getSmsRemind() {
        return smsRemind;
    }

    public void setSmsRemind(String smsRemind) {
        this.smsRemind = smsRemind == null ? null : smsRemind.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject == null ? null : subject.trim();
    }

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }

    public Integer getMeetRoomId() {
        return meetRoomId;
    }

    public void setMeetRoomId(Integer meetRoomId) {
        this.meetRoomId = meetRoomId;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getRecorderId() {
        return recorderId;
    }

    public void setRecorderId(Integer recorderId) {
        this.recorderId = recorderId;
    }

    public String getIsuploadsummary() {
        return isuploadsummary;
    }

    public void setIsuploadsummary(String isuploadsummary) {
        this.isuploadsummary = isuploadsummary == null ? null : isuploadsummary.trim();
    }

    public Integer getPendingCount() {
        return pendingCount;
    }

    public Integer getApprovedCount() {
        return approvedCount;
    }

    public Integer getProcessingCount() {
        return processingCount;
    }

    public Integer getNotApprovedCount() {
        return notApprovedCount;
    }

    public Integer getOverCount() {
        return overCount;
    }

    public void setPendingCount(Integer pendingCount) {
        this.pendingCount = pendingCount;
    }

    public void setApprovedCount(Integer approvedCount) {
        this.approvedCount = approvedCount;
    }

    public void setProcessingCount(Integer processingCount) {
        this.processingCount = processingCount;
    }

    public void setNotApprovedCount(Integer notApprovedCount) {
        this.notApprovedCount = notApprovedCount;
    }

    public void setOverCount(Integer overCount) {
        this.overCount = overCount;
    }

    public String getApproveName() {
        return approveName;
    }

    public void setApproveName(String approveName) {
        this.approveName = approveName;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getManageUserId() {
        return manageUserId;
    }

    public void setManageUserId(String manageUserId) {
        this.manageUserId = manageUserId;
    }

    public String getRecorderUserId() {
        return recorderUserId;
    }

    public void setRecorderUserId(String recorderUserId) {
        this.recorderUserId = recorderUserId;
    }

    public String getSummaryAttachmentId() {
        return summaryAttachmentId;
    }

    public void setSummaryAttachmentId(String summaryAttachmentId) {
        this.summaryAttachmentId = summaryAttachmentId;
    }

    public String getSummaryAttachmentName() {
        return summaryAttachmentName;
    }

    public void setSummaryAttachmentName(String summaryAttachmentName) {
        this.summaryAttachmentName = summaryAttachmentName;
    }

    public List getSummaryAttachmentList() {
        return summaryAttachmentList;
    }

    public void setSummaryAttachmentList(List summaryAttachmentList) {
        this.summaryAttachmentList = summaryAttachmentList;
    }

    public String getServiceUser() {
        return serviceUser;
    }

    public void setServiceUser(String serviceUser) {
        this.serviceUser = serviceUser;
    }

    public String getServiceUserUserId() {
        return serviceUserUserId;
    }

    public void setServiceUserUserId(String serviceUserUserId) {
        this.serviceUserUserId = serviceUserUserId;
    }

    public String getServiceUserName() {
        return serviceUserName;
    }

    public void setServiceUserName(String serviceUserName) {
        this.serviceUserName = serviceUserName;
    }

    public List getPhotoList() {
        return photoList;
    }

    public void setPhotoList(List photoList) {
        this.photoList = photoList;
    }

    public List getVideoList() {
        return videoList;
    }

    public void setVideoList(List videoList) {
        this.videoList = videoList;
    }

    public List getRecordList() {
        return recordList;
    }

    public void setRecordList(List recordList) {
        this.recordList = recordList;
    }

    public List getMinutesList() {
        return minutesList;
    }

    public void setMinutesList(List minutesList) {
        this.minutesList = minutesList;
    }

    public List getRegisterPhotoList() {
        return registerPhotoList;
    }

    public void setRegisterPhotoList(List registerPhotoList) {
        this.registerPhotoList = registerPhotoList;
    }

    public String getSendName() {
        return sendName;
    }

    public void setSendName(String sendName) {
        this.sendName = sendName;
    }

    public String getToScope() {
        return toScope;
    }

    public void setToScope(String toScope) {
        this.toScope = toScope;
    }

    public String getToEmail() {
        return toEmail;
    }

    public void setToEmail(String toEmail) {
        this.toEmail = toEmail;
    }

    public String getAgendaId() {
        return agendaId;
    }

    public void setAgendaId(String agendaId) {
        this.agendaId = agendaId;
    }

    public String getAgendaName() {
        return agendaName;
    }

    public void setAgendaName(String agendaName) {
        this.agendaName = agendaName;
    }

    public List getAgendaList() {
        return agendaList;
    }

    public void setAgendaList(List agendaList) {
        this.agendaList = agendaList;
    }
}