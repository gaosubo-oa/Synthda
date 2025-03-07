package com.xoa.model.daiban;

import com.xoa.model.sms.SmsBodyExtend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DaiBanModel {

    private List<SmsBodyExtend> ehrAgency=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> email=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> notify=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> workFlow=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> newsList=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend>  documentList=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> toupiao=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> supervisions=new ArrayList<>();

    private List<SmsBodyExtend> meeting=new ArrayList<>();

    private List<SmsBodyExtend> calendars=new ArrayList<>();

    private List<SmsBodyExtend> diarys=new ArrayList<>();

    private List<SmsBodyExtend> publicFiles=new ArrayList<>();

    private List<SmsBodyExtend> schedules=new ArrayList<>();

    private List<SmsBodyExtend> netDisk=new ArrayList<>();

    private List<SmsBodyExtend> zhiBan=new ArrayList<>();

    private List<SmsBodyExtend> bangong=new ArrayList<>();

    private Map<String,TodoListModel> map=new HashMap<>();

    private List<SmsBodyExtend> bbsBoard = new ArrayList<>();

    private List<SmsBodyExtend> remind = new ArrayList<>();

    private List<SmsBodyExtend> crashDispAtch=new ArrayList<SmsBodyExtend>();

    private List<SmsBodyExtend> cheliang = new ArrayList<>();

    private List<SmsBodyExtend> taskManage =  new ArrayList<>();

    private List<SmsBodyExtend> hstMeeting = new ArrayList<>();

    private List<SmsBodyExtend> bbscomment = new ArrayList<>();

    private List<SmsBodyExtend> asset = new ArrayList<>();

    private List<SmsBodyExtend> contractremind = new ArrayList<>();

    private List<SmsBodyExtend> institutioncontent = new ArrayList<>();

    private List<SmsBodyExtend> dutypoliceusers = new ArrayList<>();

    private List<SmsBodyExtend> jhtmeeting = new ArrayList<>();

    private List<SmsBodyExtend> planManage = new ArrayList<>();

    //资格证书
    private List<SmsBodyExtend> crmcertificate = new ArrayList<>();


    private List<SmsBodyExtend> towork = new ArrayList<>();

    public List<SmsBodyExtend> getTowork() {
        return towork;
    }

    public void setTowork(List<SmsBodyExtend> towork) {
        this.towork = towork;
    }

    // 考核
    private List<SmsBodyExtend> assessments = new ArrayList<>();

    public List<SmsBodyExtend> getEhrAgency() {
        return ehrAgency;
    }

    public void setEhrAgency(List<SmsBodyExtend> ehrAgency) {
        this.ehrAgency = ehrAgency;
    }

    //党建
    private List<SmsBodyExtend> partyMember=new ArrayList<SmsBodyExtend>();

    //证照管理
    private List<SmsBodyExtend> hrStaffLicense =  new ArrayList();

    private List<SmsBodyExtend> integralManager =  new ArrayList();

    private List<SmsBodyExtend> passwordManager =  new ArrayList();

    private List<SmsBodyExtend> wagesManager=new ArrayList<>();
    private List<SmsBodyExtend> attendanceManager=new ArrayList<>();
    private List<SmsBodyExtend> sysType = new ArrayList<>();

    private List<SmsBodyExtend> rapidZhuo = new ArrayList<>();
    public List<SmsBodyExtend> getAttendanceManager() {
        return attendanceManager;
    }

    public void setAttendanceManager(List<SmsBodyExtend> attendanceManager) {
        this.attendanceManager = attendanceManager;
    }

    public List<SmsBodyExtend> getSysType() {
        return sysType;
    }

    public void setSysType(List<SmsBodyExtend> sysType) {
        this.sysType = sysType;
    }

    public List<SmsBodyExtend> getWagesManager() {
        return wagesManager;
    }

    public void setWagesManager(List<SmsBodyExtend> wagesManager) {
        this.wagesManager = wagesManager;
    }

    private List<SmsBodyExtend> hrStaffCare =  new ArrayList();

    public List<SmsBodyExtend> getHrStaffCare() {
        return hrStaffCare;
    }

    public void setHrStaffCare(List<SmsBodyExtend> hrStaffCare) {
        this.hrStaffCare = hrStaffCare;
    }

    public List<SmsBodyExtend> getPasswordManager() {
        return passwordManager;
    }

    public void setPasswordManager(List<SmsBodyExtend> passwordManager) {
        this.passwordManager = passwordManager;
    }

    public List<SmsBodyExtend> getIntegralManager() {
        return integralManager;
    }

    public void setIntegralManager(List<SmsBodyExtend> integralManager) {
        this.integralManager = integralManager;
    }

    public List<SmsBodyExtend> getHrStaffLicense() {
        return hrStaffLicense;
    }

    public void setHrStaffLicense(List<SmsBodyExtend> hrStaffLicense) {
        this.hrStaffLicense = hrStaffLicense;
    }

    public List<SmsBodyExtend> getPartyMember() {
        return partyMember;
    }

    public void setPartyMember(List<SmsBodyExtend> partyMember) {
        this.partyMember = partyMember;
    }

    public List<SmsBodyExtend> getAssessments() {
        return assessments;
    }

    public void setAssessments(List<SmsBodyExtend> assessments) {
        this.assessments = assessments;
    }

    public List<SmsBodyExtend> getCrmcertificate() {
        return crmcertificate;
    }

    public void setCrmcertificate(List<SmsBodyExtend> crmcertificate) {
        this.crmcertificate = crmcertificate;
    }

    public List<SmsBodyExtend> getJhtmeeting() {
        return jhtmeeting;
    }

    public void setJhtmeeting(List<SmsBodyExtend> jhtmeeting) {
        this.jhtmeeting = jhtmeeting;
    }

    public List<SmsBodyExtend> getDutypoliceusers() {
        return dutypoliceusers;
    }

    public void setDutypoliceusers(List<SmsBodyExtend> dutypoliceusers) {
        this.dutypoliceusers = dutypoliceusers;
    }

    public List<SmsBodyExtend> getInstitutioncontent() {
        return institutioncontent;
    }

    public void setInstitutioncontent(List<SmsBodyExtend> institutioncontent) {
        this.institutioncontent = institutioncontent;
    }

    public List<SmsBodyExtend> getContractremind() {
        return contractremind;
    }

    public void setContractremind(List<SmsBodyExtend> contractremind) {
        this.contractremind = contractremind;
    }

    public List<SmsBodyExtend> getAsset() {
        return asset;
    }

    public void setAsset(List<SmsBodyExtend> asset) {
        this.asset = asset;
    }

    public List<SmsBodyExtend> getBbscomment() {
        return bbscomment;
    }

    public void setBbscomment(List<SmsBodyExtend> bbscomment) {
        this.bbscomment = bbscomment;
    }

    public List<SmsBodyExtend> getHstMeeting() {
        return hstMeeting;
    }

    public void setHstMeeting(List<SmsBodyExtend> hstMeeting) {
        this.hstMeeting = hstMeeting;
    }

    public List<SmsBodyExtend> getBbsBoard() {
        return bbsBoard;
    }

    public List<SmsBodyExtend> getCheliang() {
        return cheliang;
    }

    public void setCheliang(List<SmsBodyExtend> cheliang) {
        this.cheliang = cheliang;
    }

    public void setBbsBoard(List<SmsBodyExtend> bbsBoard) {
        this.bbsBoard = bbsBoard;
    }

    public List<SmsBodyExtend> getEmail() {
        return email;
    }

    public void setEmail(List<SmsBodyExtend> email) {
        this.email = email;
    }

    public List<SmsBodyExtend> getNotify() {
        return notify;
    }

    public void setNotify(List<SmsBodyExtend> notify) {
        this.notify = notify;
    }

    public List<SmsBodyExtend> getWorkFlow() {
        return workFlow;
    }

    public void setWorkFlow(List<SmsBodyExtend> workFlow) {
        this.workFlow = workFlow;
    }

    public List<SmsBodyExtend> getNewsList() {
        return newsList;
    }

    public void setNewsList(List<SmsBodyExtend> newsList) {
        this.newsList = newsList;
    }

    public List<SmsBodyExtend> getDocumentList() {
        return documentList;
    }

    public void setDocumentList(List<SmsBodyExtend> documentList) {
        this.documentList = documentList;
    }

    public List<SmsBodyExtend> getToupiao() {
        return toupiao;
    }

    public void setToupiao(List<SmsBodyExtend> toupiao) {
        this.toupiao = toupiao;
    }

    public List<SmsBodyExtend> getSupervisions() {
        return supervisions;
    }

    public void setSupervisions(List<SmsBodyExtend> supervisions) {
        this.supervisions = supervisions;
    }

    public List<SmsBodyExtend> getMeeting() {
        return meeting;
    }

    public void setMeeting(List<SmsBodyExtend> meeting) {
        this.meeting = meeting;
    }

    public List<SmsBodyExtend> getCalendars() {
        return calendars;
    }

    public void setCalendars(List<SmsBodyExtend> calendars) {
        this.calendars = calendars;
    }

    public List<SmsBodyExtend> getDiarys() {
        return diarys;
    }

    public void setDiarys(List<SmsBodyExtend> diarys) {
        this.diarys = diarys;
    }

    public List<SmsBodyExtend> getPublicFiles() {
        return publicFiles;
    }

    public void setPublicFiles(List<SmsBodyExtend> publicFiles) {
        this.publicFiles = publicFiles;
    }

    public List<SmsBodyExtend> getSchedules() {
        return schedules;
    }

    public void setSchedules(List<SmsBodyExtend> schedules) {
        this.schedules = schedules;
    }

    public List<SmsBodyExtend> getNetDisk() {
        return netDisk;
    }

    public void setNetDisk(List<SmsBodyExtend> netDisk) {
        this.netDisk = netDisk;
    }

    public Map<String, TodoListModel> getMap() {
        return map;
    }

    public void setMap(Map<String, TodoListModel> map) {
        this.map = map;
    }

    List<SmsBodyExtend> emailPlus;
    public void setEmailPlus(List<SmsBodyExtend> emailPlus) {
        this.emailPlus = emailPlus;
    }

    public List<SmsBodyExtend> getEmailPlus() {
        return emailPlus;
    }

    public List<SmsBodyExtend> getZhiBan() {
        return zhiBan;
    }

    public void setZhiBan(List<SmsBodyExtend> zhiBan) {
        this.zhiBan = zhiBan;
    }
    public List<SmsBodyExtend> getBangong() {
        return bangong;
    }

    public void setBangong(List<SmsBodyExtend> bangong) {
        this.bangong = bangong;
    }
    private List<SmsBodyExtend> dispatcher;

    public List<SmsBodyExtend> getDispatcher() {
        return dispatcher;
    }

    public void setDispatcher(List<SmsBodyExtend> dispatcher) {
        this.dispatcher = dispatcher;
    }

    private List<SmsBodyExtend> thirdSystem;

    public List<SmsBodyExtend> getThirdSystem() {
        return thirdSystem;
    }

    public void setThirdSystem(List<SmsBodyExtend> thirdSystem) {
        this.thirdSystem = thirdSystem;
    }

    List<SmsBodyExtend> addPlanApproval;

    public void setAddPlanApproval(List<SmsBodyExtend> addPlanApproval) {
        this.addPlanApproval = addPlanApproval;
    }

    public List<SmsBodyExtend> getAddPlanApproval() {
        return addPlanApproval;
    }

    public List<SmsBodyExtend> getCrashDispAtch() {
        return crashDispAtch;
    }

    public void setCrashDispAtch(List<SmsBodyExtend> crashDispAtch) {
        this.crashDispAtch = crashDispAtch;
    }

    public List<SmsBodyExtend> getRemind() {
        return remind;
    }

    public void setRemind(List<SmsBodyExtend> remind) {
        this.remind = remind;
    }

    public List<SmsBodyExtend> getTaskManage() {
        return taskManage;
    }

    public void setTaskManage(List<SmsBodyExtend> taskManage) {
        this.taskManage = taskManage;
    }

    public List<SmsBodyExtend> getPlanManage() {
        return planManage;
    }

    public void setPlanManage(List<SmsBodyExtend> planManage) {
        this.planManage = planManage;
    }

    public List<SmsBodyExtend> getRapidZhuo() {
        return rapidZhuo;
    }

    public void setRapidZhuo(List<SmsBodyExtend> rapidZhuo) {
        this.rapidZhuo = rapidZhuo;
    }
}
