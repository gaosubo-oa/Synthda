package com.xoa.service.todoList.impl;

import com.alibaba.fastjson.JSONArray;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.voteTitle.VoteTitleMapper;
import com.xoa.dev.crossEmail.model.EmailBodyPlusModel;
import com.xoa.dev.crossEmail.model.EmailPlusModel;
import com.xoa.dev.crossEmail.service.EmailPlusService;
import com.xoa.model.daiban.*;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.notify.Notify;
import com.xoa.model.sms.SmsBodyExtend;
import com.xoa.model.users.Users;
import com.xoa.model.voteTitle.VoteTitle;
import com.xoa.model.worldnews.News;
import com.xoa.service.email.EmailService;
import com.xoa.service.notify.NotifyService;
import com.xoa.service.todoList.TodolistService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UsersService;
import com.xoa.service.worldnews.NewService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.DateFormatUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.page.PageParams;
import com.xoa.util.sendUtil.HttpSend;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class TodolistImpl implements TodolistService {

    @Resource
    EmailBodyMapper emailBodyMapper;

    @Resource
    private EmailService emailService;
    @Resource
    private EmailPlusService emailPlusService;

    @Resource
    private NotifyService notifyService;

    @Resource
    private UsersService usersService;

    @Resource
    private SysFunctionMapper sysFunctionMapper;

    @Resource
    private UsersMapper usersMapper;
    @Resource
    private VoteTitleMapper voteTitleMapper;
    @Resource
    private NewService newService;
    @Resource
    SmsMapper smsMapper;
    @Resource
    SmsBodyMapper smsBodyMapper;
    @Resource
    UserFunctionService userFunctionService;
    @Resource
    private SysParaMapper sysParaMapper;

    // ID 常量
    private final static String EMAIL = "email";
    private final static String EMAILPLUS = "emailPlus";
    private final static String NOTIFY = "notify";
    private final static String NEWS = "news";
    private final static String WORKFLOW = "willdo";
    private final static String DOCTMENT = "doctment";
    private final static String TOPIAO = "toupiao";
    private final static String NETDISK = "netdisk";
    private final static String FILECONTENT = "publicFile";
    private final static String SUPERVISION = "supervision";
    private final static String MEETING = "meeting";
    private final static String CALENDAR = "calendar";
    private final static String DIARY = "diary";
    private final static String SCHEDULE = "schedule";
    private final static String DISPATCHERID = "dispatcher";
    private final static String THIRDSYSTEMID = "thirdSystem";
    private final static String LEADER_SYSTMID = "leaderSystm";
    private final static String BANGONGSHENID = "bangongshen";
    private final static String ADDPLANAPPROVAL = "addPlanApproval";
    private final static String CRASHDISPATCH = "crashDispatch";
    private final static String BBSCOMMENT = "bbscomment";
    private final static String CONTRACTREMIND = "contractremind";
    private final static String INSTITUTIONCONTENT = "institutioncontent";
    private final static String DUTYPOLICEUSERS = "dutypoliceusers";
    private final static String JHTMEETING = "jhtmeeting";
    private final static String CRMCERTIFICATE = "crmcertificate";
    private final static String HRSTAFFLICENSE = "hrstafflicense";
    private final static String PLANMANAGE = "planManage";
    private final static String INTEGRALMANAGER = "IntegralManager";
    private final static String HRSTAFFCARE = "hrStaffCare";
    private final static String PASSWORDMANAGER = "passwordManager";
    private final static String WAGESMANAGER = "wagesManager";
    private final static String ATTENDANCEMANAGER = "attendanceManager";
    private final static String CARAPPROVAL = "carApproval";
    private final static String KH_ASSESSMENT = "assessment";
    private final static String TASK_MANAGEES = "taskManage";
    private final static String TO_WORK = "towork";
    private final static String RAPID_ZHUO ="rapidZhuo";//速卓审批

    // ID 常量
    private final static int VOTELTEM_ID = 11;
    private final static int EMAIL_ID = 2;
    private final static int NOTIFY_ID = 1;
    private final static int EMAILPLUS_ID = 25;
    private final static int FLOWRUNPRCS_ID = 7;
    private final static int NEWS_ID = 14;
    private final static int DOCTMENT_ID = 70;
    private final static int SUPERVISION_ID = 71;
    private final static int MEETING_ID = 72;
    private final static int CALENDAR_ID = 5;
    private final static int DIARY_ID = 13;
    private final static int PUBLIC_FILE_ID = 16;
    private final static int SCHEDULE_ID = 23;
    private final static int NETDISK_ID = 17;
    private final static int ZNIBANGUANLI = 3;
    private final static int BANGONGSHEN = 24;
    private final static int BBSBOARD_ID = 19;
    private final static int DISPATCHER = 29;
    private final static int THIRD_SYSTEM = 200;
    private final static int LEADER_SYSTM = 27;
    private final static int PLAN_APPROVAL = 64;
    private final static int ADD_PLANAPPROVAL = 83;//培训计划
    private final static int NOTIFY_OPINION = 34;//公告回执提醒
    private final static int CRASH_DISPATCH = 35;//应急救援提醒
    private final static int SMS_REMIND = 12;//提醒计划
    private final static int CAR_REMIND = 9;//车辆使用提醒
    private final static int TASK_MANAGE = 31;//任务管理组任务提醒
    private final static int HSTMEETING_REMIND = 73;//好视通视频会议事务提醒
    private final static int BBS_COMMENT = 20;//讨论区事务提醒
    private final static int ASSET_REMIND = 74;//资产管理事务提醒
    private final static int CONTRACT_REMIND = 75;//合同管理
    private final static int INSTITUTION_CONTENT = 76;//制度管理
    private final static int DUTY_POLICE_USERS = 77;//公安局值班管理
    private final static int JHT_MEETING = 79; //即会通视频会议
    private final static int PLAN_MANAGE = 80; //计划考核
    private final static int CRM_CERTIFICATE = 81; //资格证书
    private final static int ASSESSMENT = 15;//考核
    private final static int PARTYMEMBER = 82;//智慧党建
    private final static int HR_STAFF_LICENSE = 84;//证照管理
    private final static int EHR_AGENCY = 86;//EHR代办
    private final static int INTEGRAL_MANAGER = 88;
    private final static int PASSWORD_MANAGER = 90;//密码管理
    private final static int HR_STAFF_CARE = 89;//员工关怀信息
    private final static int WAGES_MANAGER = 91;//薪资管理
    private final static int ATTENDANCE_MANAGER = 92;//薪资管理
    private final static int SYSTYPE = 0;//系统类型
    private final static int TOWORK = 66;
    private final static int RAPIDZHUO =97;//速卓审批

    @Override
    public Daiban list(String userId, String sqlType, HttpServletRequest request) throws Exception {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        Users usersByuserId = usersMapper.SimplefindUsersByuserId(userId);
        String userId1 = users.getUserId();
        Integer userPriv = users.getUserPriv();
        Integer deptId = users.getDeptId();
        if (usersByuserId != null) {
            userId1 = usersByuserId.getUserId();
            userPriv = usersByuserId.getUserPriv();
            deptId = usersByuserId.getDeptId();
        }
        maps.put("userId", userId1);
        maps.put("name", userId);
        maps.put("userPriv", userPriv);
        maps.put("deptId", deptId);
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(true);
        pageParams.setPage(1);
        pageParams.setPageSize(10);
        maps.put("page", pageParams);
        List<TodoList> list = new ArrayList<TodoList>();
        List<TodoList> list1 = new ArrayList<TodoList>();
        List<TodoList> list11 = new ArrayList<TodoList>();
        List<TodoList> list2 = new ArrayList<TodoList>();
        List<TodoList> list3 = new ArrayList<TodoList>();
        List<TodoList> list5 = new ArrayList<TodoList>();
        List<TodoList> list6 = new ArrayList<TodoList>();
        Daiban db = new Daiban();
        Integer total = 0;
        InetAddress address = this.getCurrentIp();
        ToJson<EmailBodyModel> tojson = emailService.selectInboxIsRead(maps, 1, 10, false, sqlType);
        List<EmailBodyModel> le = tojson.getObj();
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (le != null && le.size() > 0) {
            for (EmailBodyModel em : le) {
                //发件人userId
                String userId2 = em.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                TodoList td = new TodoList();
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(em.getContent());
                td.setFromName(em.getSubject());
                td.setImg("/img/workflow/youjian.png");
                List<EmailModel> lemail = em.getEmailList();
                for (EmailModel e : lemail) {
                    if (e.getToId().equals(userId)) {
                        td.setQid(e.getEmailId());
                        td.setDeleteFlag(e.getDeleteFlag());
                    }
                }
                td.setReadflag(em.getSendFlag());
                td.setType("email");
                Long e = (long) (em.getSendTime() * 1000L);
                String s = f.format(e);
                td.setTime(s);
                td.setUserName(em.getUsers().getUserName());
                td.setIsAttach(em.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(em.getFromId());
                td.setFromUid(u.getUid());
                list.add(td);
            }

        }

        ToJson<EmailBodyPlusModel> tojson1 = emailPlusService.selectInboxIsRead(maps, 1, 10, false, sqlType);
        List<EmailBodyPlusModel> le1 = tojson1.getObj();
        SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (le1 != null && le1.size() > 0) {
            for (EmailBodyPlusModel em : le1) {
                //发件人userId
                String userId2 = em.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                TodoList td = new TodoList();
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(em.getContent());
                td.setFromName(em.getSubject());
                td.setImg("/img/workflow/youjian.png");
                List<EmailPlusModel> lemail = em.getEmailList();
                for (EmailPlusModel e : lemail) {
                    if (e.getToId().equals(userId)) {
                        td.setQid(e.getEmailId());
                        td.setDeleteFlag(e.getDeleteFlag());
                    }
                }
                td.setReadflag(em.getSendFlag());
                td.setType("emailPlus");
                Long e = (long) (em.getSendTime() * 1000L);
                String s = f1.format(e);
                td.setTime(s);
                td.setUserName(em.getUsers().getUserName());
                td.setIsAttach(em.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(em.getFromId());
                td.setFromUid(u.getUid());
                list11.add(td);
            }

        }

        ToJson<Notify> ln = notifyService.unreadNotify(maps, 1, 10, false, userId, sqlType);
        List<Notify> l = ln.getObj();
        if (l != null && l.size() > 0) {
            for (Notify no : l) {
                TodoList td = new TodoList();
                String userId2 = no.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                if (u != null) {
                    td.setUid(u.getUid());
                    td.setAvater(u.getAvatar());
                    td.setContent(no.getContent());
                    td.setFromName(no.getSubject());
                    td.setImg("/img/workflow/notify.png");
                    td.setQid(no.getNotifyId());
                    td.setReadflag(no.getPublish());
                    String notifyType = no.getFormat();
                    td.setType("notify");

                    String s = f.format(no.getSendTime());
                    td.setTime(s);
                    td.setDeleteFlag("");
                    td.setUserName(no.getUsers().getUserName());
                    td.setIsAttach(no.getAttachmentId() == "" ? "0" : "1");
                    td.setFromId(no.getFromId());
                    td.setFromUid(u.getUid());
                    list1.add(td);
                }
            }
        }
        ToJson<News> news = newService.unreadNews(maps, 1, 10, false, userId, sqlType);

        List<News> newsList = news.getObj();
        if (newsList != null && newsList.size() > 0) {
            for (News newsOne : newsList) {
                TodoList td = new TodoList();
                String userId2 = newsOne.getProvider();
                Users u = usersService.findUsersByuserId(userId2);
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(newsOne.getContent());
                td.setFromName(newsOne.getSubject());
                td.setImg("/img/workflow/news.png");
                td.setQid(newsOne.getNewsId());
                td.setReadflag(newsOne.getPublish());
                String notifyType = newsOne.getFormat();
                td.setType("news");

                String s = f.format(newsOne.getNewsTime());
                td.setTime(s);
                td.setDeleteFlag("");
                td.setUserName(newsOne.getUsers().getUserName());
                td.setIsAttach(newsOne.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(newsOne.getProvider());
                td.setFromUid(u.getUid());
                list3.add(td);
            }
        }


        list6 = touPiaoDaiBanTongJi(request, users);
        db.setTotal(total);
        db.setEmail(list);
        db.setNotify(list1);
        db.setEmailPlus(list11);
        db.setWorkFlow(list2);
        db.setNewsList(list3);
        db.setDocumentList(list5);
        db.setToupiao(list6);
        return db;

    }


    @Override
    public Daiban readList(String userId, String sqlType, HttpServletRequest request) throws Exception {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        Users usersByuserId = usersMapper.findUsersByuserId(userId);
        maps.put("userId", usersByuserId.getUserId());
        maps.put("name", userId);
        maps.put("userPriv", usersByuserId.getUserPriv());
        maps.put("deptId", usersByuserId.getDeptId());
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(true);
        pageParams.setPage(1);
        pageParams.setPageSize(10);
        maps.put("page", pageParams);
        List<TodoList> list = new ArrayList<TodoList>();
        List<TodoList> list1 = new ArrayList<TodoList>();
        List<TodoList> list11 = new ArrayList<TodoList>();
        List<TodoList> list2 = new ArrayList<TodoList>();
        List<TodoList> list3 = new ArrayList<TodoList>();
        Daiban db = new Daiban();
        InetAddress address = this.getCurrentIp();
        ToJson<EmailBodyModel> tojson = emailService.selectInboxIsReadList(maps, 1, 10, false, sqlType);
        List<EmailBodyModel> le = tojson.getObj();
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (le != null && le.size() > 0) {
            for (EmailBodyModel em : le) {
                //发件人userId
                String userId2 = em.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                TodoList td = new TodoList();
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(em.getContent());
                td.setFromName(em.getSubject());
                td.setImg("/img/workflow/youjian.png");
                List<EmailModel> lemail = em.getEmailList();
                for (EmailModel e : lemail) {
                    if (e.getToId().equals(userId)) {
                        td.setQid(e.getEmailId());
                        td.setDeleteFlag(e.getDeleteFlag());
                    }
                }
                td.setReadflag(em.getSendFlag());
                td.setType("email");
                Long e = (long) (em.getSendTime() * 1000L);
                String s = f.format(e);
                td.setTime(s);
                td.setUserName(em.getUsers().getUserName());
                td.setIsAttach(em.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(em.getFromId());
                td.setFromUid(u.getUid());
                list.add(td);
            }
        }

        ToJson<EmailBodyPlusModel> tojson1 = emailPlusService.selectInboxIsReadList(maps, 1, 10, false, sqlType);
        List<EmailBodyPlusModel> le1 = tojson1.getObj();
        SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (le1 != null && le1.size() > 0) {
            for (EmailBodyPlusModel em : le1) {
                //发件人userId
                String userId2 = em.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                TodoList td = new TodoList();
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(em.getContent());
                td.setFromName(em.getSubject());
                td.setImg("/img/workflow/youjian.png");
                List<EmailPlusModel> lemail = em.getEmailList();
                for (EmailPlusModel e : lemail) {
                    if (e.getToId().equals(userId)) {
                        td.setQid(e.getEmailId());
                        td.setDeleteFlag(e.getDeleteFlag());
                    }
                }
                td.setReadflag(em.getSendFlag());
                td.setType("email");
                Long e = (long) (em.getSendTime() * 1000L);
                String s = f1.format(e);
                td.setTime(s);
                td.setUserName(em.getUsers().getUserName());
                td.setIsAttach(em.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(em.getFromId());
                td.setFromUid(u.getUid());
                list11.add(td);
            }
        }

        ToJson<Notify> ln = notifyService.readNotify(maps, 1, 10, false, userId, sqlType);
        List<Notify> l = ln.getObj();
        if (l != null && l.size() > 0) {
            for (Notify no : l) {
                TodoList td = new TodoList();
                String userId2 = no.getFromId();
                Users u = usersService.findUsersByuserId(userId2);
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(no.getContent());
                td.setFromName(no.getSubject());
                td.setImg("/img/workflow/notify.png");
                td.setQid(no.getNotifyId());
                td.setReadflag(no.getPublish());
                String notifyType = no.getFormat();
                td.setType("notify");

                String s = f.format(no.getSendTime());
                td.setTime(s);
                td.setDeleteFlag("");
                td.setUserName(no.getUsers().getUserName());
                td.setIsAttach(no.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(no.getFromId());
                td.setFromUid(u.getUid());
                list1.add(td);
            }
        }
        ToJson<News> news = newService.readNews(maps, 1, 10, false, userId, sqlType);

        List<News> newsList = news.getObj();
        if (newsList != null && newsList.size() > 0) {
            for (News newsOne : newsList) {
                TodoList td = new TodoList();
                String userId2 = newsOne.getProvider();
                Users u = usersService.findUsersByuserId(userId2);
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(newsOne.getContent());
                td.setFromName(newsOne.getSubject());
                td.setImg("/img/workflow/news.png");
                td.setQid(newsOne.getNewsId());
                td.setReadflag(newsOne.getPublish());
                String notifyType = newsOne.getFormat();
                td.setType("news");

                String s = f.format(newsOne.getNewsTime());
                td.setTime(s);
                td.setDeleteFlag("");
                td.setUserName(newsOne.getUsers().getUserName());
                td.setIsAttach(newsOne.getAttachmentId() == "" ? "0" : "1");
                td.setFromId(newsOne.getProvider());
                td.setFromUid(u.getUid());
                list3.add(td);
            }
        }



        db.setEmail(list);
        db.setNotify(list1);
        db.setEmailPlus(list11);
        db.setWorkFlow(list2);
        db.setNewsList(list3);
        return db;
    }

    @Override
    public Daiban readTotal(String userId, String sqlType, HttpServletRequest request, String superfluity) throws Exception {
        Daiban db = new Daiban();
        Integer total = 0;
        if ("1".equals(superfluity)) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "0");
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsListByType(map);
            total = smsBodyExtendList.size();
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "1");
            Date date = new Date();
            String s = DateFormatUtils.formatDate(date);
            Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
            map.put("sendTime", nowDateTime);
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsListByType(map);
            total = smsBodyExtendList.size();
        }


        db.setTotal(total);
        return db;
    }


    @Override
    public BaseWrapper readHaveMsgList(String classification, String userId, String sqlType, HttpServletRequest request) throws Exception {
        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        Users usersByuserId = usersMapper.findUsersByuserId(userId);
        maps.put("userId", usersByuserId.getUserId());
        maps.put("name", userId);
        maps.put("userPriv", usersByuserId.getUserPriv());
        maps.put("deptId", usersByuserId.getDeptId());

        if (EMAIL.equals(classification)) {
         /*   Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag","1");
            Objmaps.put("type","2");
            List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
             smsMapper.updateSmsByIds("0",toBeStored);*/
            ToJson<EmailBodyModel> tojson = emailService.selectInboxIsRead(maps, 1, 10, false, sqlType);
            List<EmailBodyModel> emailBodyModels = tojson.getObj();
            for (EmailBodyModel emailBodyModel : emailBodyModels) {
                Map<String, Object> mapss = new HashMap<String, Object>();
                mapss.put("emailId", emailBodyModel.getEmailList().get(0).getEmailId());
                mapss.put("bodyId", emailBodyModel.getBodyId());
                EmailBodyModel emailBody = emailService.queryById(mapss, 1, 5, false, sqlType);
                if (emailBody != null) {
                    EmailModel email = new EmailModel();
                    email.setEmailId(emailBodyModel.getEmailList().get(0).getEmailId());
                    email.setReadFlag("1");
                    emailService.updateIsRead(email);
                }
            }
        } else if (EMAILPLUS.equals(classification)) {
            ToJson<EmailBodyPlusModel> tojson = emailPlusService.selectInboxIsRead(maps, 1, 10, false, sqlType);
            List<EmailBodyPlusModel> emailBodyModels = tojson.getObj();
            for (EmailBodyPlusModel emailBodyModel : emailBodyModels) {
                Map<String, Object> mapss = new HashMap<String, Object>();
                mapss.put("emailId", emailBodyModel.getEmailList().get(0).getEmailId());
                mapss.put("bodyId", emailBodyModel.getBodyId());
                EmailBodyPlusModel emailBody = emailPlusService.queryById(mapss, 1, 5, false, sqlType);
                if (emailBody != null) {
                    EmailPlusModel email = new EmailPlusModel();
                    email.setEmailId(emailBodyModel.getEmailList().get(0).getEmailId());
                    email.setReadFlag("1");
                    emailPlusService.updateIsRead(email);
                }
            }
        } else if (NOTIFY.equals(classification)) {
            ToJson<Notify> ln = notifyService.unreadNotify(maps, 1, 10, false, userId, sqlType);
            List<Notify> notifies = ln.getObj();

            for (Notify notify : notifies) {
                maps.put("notifyId", notify.getNotifyId());
                Notify notifyOne = notifyService.queryById(maps, 1, 20, false, userId, sqlType, "2");

            }
        } else if (NEWS.equals(classification)) {
            ToJson<News> news = newService.unreadNews(maps, 1, 10, false, userId, sqlType);
            List<News> newsList = news.getObj();
            for (News news1 : newsList) {
                maps.put("newsId", news1.getNewsId());
                News news2 = newService.queryById(maps, 1, 5, false,
                        userId, sqlType, "2");
            }

        }
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        baseWrapper.setMsg("ok");
        baseWrapper.setData("ok");

        return baseWrapper;
    }

    @Override
    public BaseWrapper readHaveList(String classification, String userId, String sqlType, HttpServletRequest request) throws Exception {
        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        Users usersByuserId = usersMapper.findUsersByuserId(userId);
        maps.put("userId", usersByuserId.getUserId());
        maps.put("name", userId);
        maps.put("userPriv", usersByuserId.getUserPriv());
        maps.put("deptId", usersByuserId.getDeptId());

        if (EMAIL.equals(classification)) {
            //只是去消除，没必要再去查询一次
            /*ToJson<EmailBodyModel> tojson = emailService.selectInboxIsRead(maps, 1, 10, false, sqlType);
            List<EmailBodyModel> emailBodyModels = tojson.getObj();
            for (EmailBodyModel emailBodyModel : emailBodyModels) {
                Map<String, Object> mapss = new HashMap<String, Object>();
                mapss.put("emailId", emailBodyModel.getEmailList().get(0).getEmailId());
                mapss.put("bodyId", emailBodyModel.getBodyId());
                EmailBodyModel emailBody = emailService.queryById(mapss, 1, 5, false, sqlType);
                if (emailBody != null) {
                    EmailModel email = new EmailModel();
                    email.setEmailId(emailBodyModel.getEmailList().get(0).getEmailId());
                    email.setReadFlag("1");
                    emailService.updateIsRead(email);
                }

            }*/
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "2");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (EMAILPLUS.equals(classification)) {
            //只是去消除，没必要再去查询一次
         /*   ToJson<EmailBodyPlusModel> tojson = emailPlusService.selectInboxIsRead(maps, 1, 10, false, sqlType);
            List<EmailBodyPlusModel> emailBodyModels = tojson.getObj();
            for (EmailBodyPlusModel emailBodyModel : emailBodyModels) {
                Map<String, Object> mapss = new HashMap<String, Object>();
                mapss.put("emailId", emailBodyModel.getEmailList().get(0).getEmailId());
                mapss.put("bodyId", emailBodyModel.getBodyId());
                EmailBodyPlusModel emailBody = emailPlusService.queryById(mapss, 1, 5, false, sqlType);
                if (emailBody != null) {
                    EmailPlusModel email = new EmailPlusModel();
                    email.setEmailId(emailBodyModel.getEmailList().get(0).getEmailId());
                    email.setReadFlag("1");
                    emailPlusService.updateIsRead(email);
                }

            }*/
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "25");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (NOTIFY.equals(classification)) {
            //只是去消除，没必要再去查询一次
         /*   ToJson<Notify> ln = notifyService.unreadNotify(maps, 1, 10, false, userId, sqlType);
            List<Notify> notifies = ln.getObj();

            for (Notify notify : notifies) {
                maps.put("notifyId", notify.getNotifyId());
                Notify notifyOne = notifyService.queryById(maps, 1, 20, false, userId, sqlType, "2");

            }*/
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "1");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            if (smsBodyExtends.size() != 0) {
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0", toBeStored);
            }
        } else if (NEWS.equals(classification)) {
            //只是去消除，没必要再去查询一次
           /* ToJson<News> news = newService.unreadNews(maps, 1, 10, false, userId, sqlType);
            List<News> newsList = news.getObj();
            for (News news1 : newsList) {
                maps.put("newsId", news1.getNewsId());
                News news2 = newService.queryById(maps, 1, 5, false,
                        userId, sqlType, "2");
            }*/
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "14");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);

        } else if (WORKFLOW.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "7");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (TOPIAO.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "11");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (DOCTMENT.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "70");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (NETDISK.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "17");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (FILECONTENT.equals(classification) || "publicFiles".equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "16");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (SUPERVISION.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "71");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (MEETING.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "72");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (CALENDAR.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "5");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (DIARY.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "13");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (SCHEDULE.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "23");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (DISPATCHERID.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "29");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (THIRDSYSTEMID.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "29");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (LEADER_SYSTMID.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "27");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (BANGONGSHENID.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "24");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (ADDPLANAPPROVAL.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "83");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            if (smsBodyExtends.size() != 0) {
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0", toBeStored);
            }
        } else if (CRASHDISPATCH.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "12");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            if (smsBodyExtends.size() != 0) {
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0", toBeStored);
            }
        } else if (BBSCOMMENT.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "20");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (CONTRACTREMIND.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "75");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (INSTITUTIONCONTENT.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "76");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (DUTYPOLICEUSERS.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "77");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (JHTMEETING.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "79");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (CRMCERTIFICATE.equals(classification)) {
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "81");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if ("hstMeeting".equals(classification)) { // 好视通
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "73");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (HRSTAFFLICENSE.equals(classification)) {
            //证照管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "84");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if ("partyMember".equals(classification)) {
            //智慧党建
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "82");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (PLANMANAGE.equals(classification)) {
            //计划审核
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "80");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (INTEGRALMANAGER.equals(classification)) {
            //理论学习管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "88");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (HRSTAFFCARE.equals(classification)) {
            //员工关怀信息
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "89");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (PASSWORDMANAGER.equals(classification)) {
            //密码设置管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "90");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (WAGESMANAGER.equals(classification)) {
            //薪资管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "91");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (ATTENDANCEMANAGER.equals(classification)) {
            //考勤管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "92");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (CARAPPROVAL.equals(classification)) {
            // 车辆管理
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "9");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (KH_ASSESSMENT.equals(classification)) {
            // 绩效考核
            Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag", "1");
            Objmaps.put("type", "15");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);
        } else if (TASK_MANAGEES.equals(classification)) {
            Map<String, Object> objectMap = new HashMap<>();
            objectMap.put("userId", usersByuserId.getUserId());
            objectMap.put("flag", "1");
            objectMap.put("type", "31");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(objectMap);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);

        } else if (TO_WORK.equals(classification)) {
            Map<String, Object> objectMap = new HashMap<>();
            objectMap.put("userId", usersByuserId.getUserId());
            objectMap.put("flag", "1");
            objectMap.put("type", "66");
            List<String> smsBodyExtends = smsBodyMapper.SmsListMsgByType(objectMap);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
            smsMapper.updateSmsByIds("0", toBeStored);

        }

        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);
        baseWrapper.setMsg("ok");
        baseWrapper.setData("ok");
        return baseWrapper;
    }

    @Override
    public Daiban delete(Integer qid, String type) {
        if (type.equals("email")) {

        }
        if (type.equals("notify")) {

        }
        return null;
    }

    public static InetAddress getCurrentIp() {
        try {
            Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
            while (networkInterfaces.hasMoreElements()) {
                NetworkInterface ni = (NetworkInterface) networkInterfaces.nextElement();
                Enumeration<InetAddress> nias = ni.getInetAddresses();
                while (nias.hasMoreElements()) {
                    InetAddress ia = (InetAddress) nias.nextElement();
                    if (!ia.isLinkLocalAddress() && !ia.isLoopbackAddress() && ia instanceof Inet4Address) {
                        return ia;
                    }
                }
            }
        } catch (SocketException e) {
        }
        return null;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午10:32:22
     * 方法介绍:   根据userId进行模糊查询
     * 参数说明:   @param userId
     * 参数说明:
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public ToJson<Users> queryUserByUserId(String userName, HttpServletRequest request) {
        return usersService.queryUserByUserId(userName, request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午10:35:22
     * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
     * 参数说明:   @param  userId
     * 参数说明:
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public ToJson<Users> queryCountByUserId(String userName) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        if (StringUtils.checkNull(userName)) {
            json.setMsg("查询不能为空");
            return json;
        }
        try {
            json.setTotleNum(usersService.queryCountByUserId(userName));
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("TodolistController queryCountByUserId:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午14:29:22
     * 方法介绍:   根据子菜单名称进行模糊查询
     * 参数说明:   @param funName
     * 参数说明:
     *
     * @return List<SysFunction>  返回子菜单信息
     */
    @Override
    public ToJson<SysFunction> getSysFunctionByName(String funName, HttpServletRequest request) {
        ToJson<SysFunction> json = new ToJson<SysFunction>(1, "error");
        if (StringUtils.checkNull(funName)) {
            json.setMsg("查询不能为空");
            return json;
        }


        try {
            //1、获取当前登录用户权限
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            Integer uid = users.getUid();
            //用户菜单权限=该用户所具有权限，不考虑角色表
            //该用户所具有权限
            String userFunctionStr = userFunctionService.getUserFunctionStrById(uid);
            String[] funcIds = userFunctionStr.split(",");
            List<SysFunction> sys = sysFunctionMapper.getSysFunctionByName(funName);
            for (SysFunction sy : sys) {
                if (!StringUtils.checkNull(sy.getName1())) {
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                    File file = new File(basePath.substring(0, basePath.length() - 17) + "ui/img/menu/" + sy.getName1().replaceAll(" +", "") + ".png");
                    if (file.exists()) {
                        sy.setName1(sy.getName1().replaceAll(" +", ""));
                    } else {
                        sy.setName1("");
                    }
                    // sy.setName1(sy.getName1().replaceAll(" +",""));
                }
            }
            List<SysFunction> a11 = new ArrayList<SysFunction>();
            for (int o = 0; o < sys.size(); o++) {
                for (int k = 0; k < funcIds.length; k++) {
                    if (String.valueOf(sys.get(o).getfId()).equals(funcIds[k])) {
                        a11.add(sys.get(o));
                    }
                }

            }


            json.setObj(a11);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("TodolistImpl getSysFunctionByName:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午14:30:12
     * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
     * 参数说明:   @param funName
     * 参数说明:
     *
     * @return List<SysFunction>  查询数
     */
    @Override
    public ToJson<SysFunction> getCountSysFunctionByName(String funName) {
        ToJson<SysFunction> json = new ToJson<SysFunction>(1, "error");
        if (StringUtils.checkNull(funName)) {
            json.setMsg("查询不能为空");
            return json;
        }
        try {
            json.setTotleNum(sysFunctionMapper.getCountSysFunctionByName(funName));
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("TodolistImpl getCountSysFunctionByName:" + e);
        }
        return json;
    }

    /*
     * 将时间戳转换为时间
     */
    public static String stampToDate(String s) {
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        long lt = new Long(s);
        Date date = new Date(lt * 1000L);
        res = simpleDateFormat.format(date);
        return res;
    }

    /*
     * 将时间转换为时间戳
     */
    public static Long dateToStamp(String s) throws ParseException {
        String res;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = simpleDateFormat.parse(s);
        long ts = date.getTime();
        return ts;
    }

    public List touPiaoDaiBanTongJi(HttpServletRequest request, Users users) throws Exception {
        List list6 = new ArrayList();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //查询投票代办
        Map map = new HashMap();
        map.put("smsType", "11");
        map.put("toId", users.getUserId());
        List<Map<String, Object>> toupiao = smsMapper.smsSelectBody(map);
        Date dates = new Date();
        if (toupiao != null && toupiao.size() > 0) {
            for (Map map1 : toupiao) {
                TodoList td = new TodoList();
                String userId2 = map1.get("toId").toString();
                Users u = usersService.findUsersByuserId(map1.get("fromId") + "");
                td.setUid(u.getUid());
                td.setAvater(u.getAvatar());
                td.setContent(String.valueOf(map1.get("remindUrl")));
                td.setFromName(map1.get("content").toString() == null ? "无标题" : map1.get("content").toString());
                td.setImg("/img/workflow/publish.png");
                td.setQid(Integer.valueOf(map1.get("bodyId").toString()));
                //td.setReadflag(documentModelOverRun.getRealPrcsId().toString());
                td.setType("toupiao");
                String toupiaoid = map1.get("remindUrl").toString();
                if (toupiaoid.contains("resultId=")) {
                    toupiaoid = toupiaoid.substring(toupiaoid.indexOf("?resultId=") + 1, toupiaoid.lastIndexOf("&"));
                    toupiaoid = toupiaoid.replace("resultId=", "");
                    td.setVoteId(Integer.valueOf(toupiaoid));
                }
                //td.setFlowId(documentModelOverRun.getFlowId());
                td.setTime(map1.get("sendTime").toString() == null ? "" : map1.get("sendTime").toString());
                td.setDeleteFlag("");
                td.setUserName(u.getUserName());
                td.setIsAttach("0");
                td.setFromId(u.getUserId());
                td.setFromUid(u.getUid());
                //将时间转换
                String date1 = TodolistImpl.stampToDate(td.getTime());
                String date2 = simpleDateFormat.format(dates);
                //查询投票终止时间
                if (td.getVoteId() != 0) {
                    VoteTitle voteTitle = voteTitleMapper.voteSelectOne(td.getVoteId());
                    if (voteTitle != null) {
                        Long t1 = TodolistImpl.dateToStamp(voteTitle.getEndDate());
                        Long t2 = TodolistImpl.dateToStamp(date2);
                        if (t1 >= t2) {
                            td.setTime(voteTitle.getSendTime());
                            td.setContent("/vote/manage/voteResult?resultId=" + voteTitle.getVoteId() + "&type=1");
                            list6.add(td);
                        }
                    }
                }
            }
        }
        return list6;
    }

    @Override
    public BaseWrapper smsListByType(String userId, HttpServletRequest request, String type) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        DaiBanModel daiBanModel = new DaiBanModel();
        List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list6 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list7 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list8 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list9 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list10 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list11 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list12 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list111 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list13 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list14 = new ArrayList<>();
        List<SmsBodyExtend> list15 = new ArrayList<>();
        List<SmsBodyExtend> list16 = new ArrayList<>();
        List<SmsBodyExtend> list17 = new ArrayList<>();
        List<SmsBodyExtend> list18 = new ArrayList<>();
        List<SmsBodyExtend> list19 = new ArrayList<>();
        List<SmsBodyExtend> list20 = new ArrayList<>();
        List<SmsBodyExtend> list21 = new ArrayList<>();
        List<SmsBodyExtend> list22 = new ArrayList<>();//提醒计划
        List<SmsBodyExtend> list23 = new ArrayList<>();
        List<SmsBodyExtend> list24 = new ArrayList<>();
        List<SmsBodyExtend> list25 = new ArrayList<>();
        List<SmsBodyExtend> list26 = new ArrayList<>();
        List<SmsBodyExtend> list27 = new ArrayList<>();
        List<SmsBodyExtend> list28 = new ArrayList<>(); //合同
        List<SmsBodyExtend> list29 = new ArrayList<>(); //制度管理
        List<SmsBodyExtend> list30 = new ArrayList<>(); //公安局值班管理
        List<SmsBodyExtend> list31 = new ArrayList<>(); //即会通视频会议
        List<SmsBodyExtend> list33 = new ArrayList<>(); //计划考核
        List<SmsBodyExtend> list34 = new ArrayList<>(); //资格证书
        List<SmsBodyExtend> list35 = new ArrayList<>(); //考核
        List<SmsBodyExtend> list36 = new ArrayList<>(); //党建
        List<SmsBodyExtend> list37 = new ArrayList<>(); //证照 管理
        List<SmsBodyExtend> list38 = new ArrayList<>(); //EHR代办
        List<SmsBodyExtend> list39 = new ArrayList<>();
        List<SmsBodyExtend> list40 = new ArrayList<>();//密码设置管理
        List<SmsBodyExtend> list41 = new ArrayList<>();//员工关怀信息
        List<SmsBodyExtend> list42 = new ArrayList<>();//薪资确认通知
        List<SmsBodyExtend> list43 = new ArrayList<>();//考勤通知管理
        List<SmsBodyExtend> list44 = new ArrayList<>();//系统类型
        List<SmsBodyExtend> list45  = new ArrayList<>();
        List<SmsBodyExtend> list46  = new ArrayList<>();//速卓审批
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "1");

            // 增加分页限制 限制最多查询1000条
            // 2022.03.20打包发现 如果不增加限制的话 数据库中未读提醒过多 会导致接口卡顿 暂时分页限制
            map.put("page", new PageParams(true, 1, 1000));

            //根据uid刷新最后访问时间
            usersMapper.updateLastVisitTime(user.getUid());

            /*
            //不应该根据 小于当前时间查找
            Date date = new Date();
            try {
                String s = DateFormatUtils.formatDate(date);
                Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
                map.put("remindTime", nowDateTime);
            } catch (ParseException e) {
                e.printStackTrace();
            }*/
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsBaseInfoListByType(map);
            for (SmsBodyExtend smsBodyExtend : smsBodyExtendList) {
                if(!Objects.isNull(smsBodyExtend.getRemindUrl())) {
                    if (!smsBodyExtend.getRemindUrl().contains("?")) {
                        smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "?");
                    }
                    smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                }
                SmsBodyExtend smsBodyExtend1 = smsBodyMapper.selBodyAndUserInfo(smsBodyExtend.getBodyId());
                if (smsBodyExtend1 == null)
                    continue;
                // 设置发送用户信息
                smsBodyExtend.setAvater(smsBodyExtend1.getAvater());
                smsBodyExtend.setUid(smsBodyExtend1.getUid());
                smsBodyExtend.setUserName(smsBodyExtend1.getUserName());
                // 设置body信息
                smsBodyExtend.setFromId(smsBodyExtend1.getFromId());
                smsBodyExtend.setSmsType(smsBodyExtend1.getSmsType());
                smsBodyExtend.setContent(smsBodyExtend1.getContent());
                smsBodyExtend.setSendTime(smsBodyExtend1.getSendTime());
                smsBodyExtend.setRemindUrl(smsBodyExtend1.getRemindUrl());
                smsBodyExtend.setIsAttach(smsBodyExtend1.getIsAttach());

                // 这两行代码不知道是什么意思 from设置为了当前用户的id和name 因为是以前别人写的代码 所以暂时不删除 -张航宁
                smsBodyExtend.setFromUid(user.getUid());
                smsBodyExtend.setFromName(user.getUserName());
                //--------------------
                if (!StringUtils.checkNull(smsBodyExtend.getSmsType())) {
                    switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                        case EMAIL_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("email");
                            String size1 = smsBodyExtend.getRemindUrl();
                            String[] aStrings = size1.split("\\?");
                            for (int i = 0; i < aStrings.length; i++) {
                                if (aStrings[i].contains("id")) {
                                    String[] s = aStrings[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings[i].contains("EMAIL_ID")) {
                                    String[] s = null;
                                    if (aStrings[i].contains("&")) {
                                        String[] str = null;
                                        str = aStrings[i].split("&");
                                        if (str[i].contains("=")) {
                                            s = str[i].split("=");
                                        }
                                    } else {
                                        s = aStrings[i].split("=");
                                    }
                                    break;
                                }
                            }
                            list.add(smsBodyExtend);
                            break;
                        case EMAILPLUS_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("emailPlus");
                            String size11 = smsBodyExtend.getRemindUrl();
                            String[] aStringss = size11.split("\\?");
                            for (int i = 0; i < aStringss.length; i++) {
                                if (aStringss[i].contains("id")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringss[i].contains("EMAILPLUS_ID")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list11.add(smsBodyExtend);
                            break;
                        case NOTIFY_ID:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("notify");
                            String size2 = smsBodyExtend.getRemindUrl();
                            String[] aStrings2 = size2.split("\\?");
                            for (int i = 0; i < aStrings2.length; i++) {
                                if (aStrings2[i].contains("notifyId")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings2[i].contains("NOTIFY_ID")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list1.add(smsBodyExtend);

                            break;
                        case FLOWRUNPRCS_ID:
                            break;
                        case NEWS_ID:
                            smsBodyExtend.setImg("/img/workflow/news.png");
                            smsBodyExtend.setType("news");
                            String size3 = smsBodyExtend.getRemindUrl();
                            String[] aStrings3 = size3.split("\\?");
                            for (int i = 0; i < aStrings3.length; i++) {
                                if (aStrings3[i].contains("newsId")) {
                                    String[] s = aStrings3[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list3.add(smsBodyExtend);
                            break;
                        case DOCTMENT_ID:
                            break;
                        case VOTELTEM_ID:
                            smsBodyExtend.setImg("/img/workflow/publish.png");
                            smsBodyExtend.setType("toupiao");
                            String size6 = smsBodyExtend.getRemindUrl();
                            String[] aStrings6 = size6.split("\\?");
                            for (int i = 0; i < aStrings6.length; i++) {
                                if (aStrings6[i].contains("resultId")) {
                                    String[] s = aStrings6[i].split("=");
                                    String[] s1 = s[i].split("&");
                                    smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                                    break;
                                }
                            }
                            list5.add(smsBodyExtend);
                            break;
                        case SUPERVISION_ID:
                            smsBodyExtend.setImg("/img/supervision/remind.png");
                            smsBodyExtend.setType("supervision");
                            list6.add(smsBodyExtend);
                            break;
                        case MEETING_ID:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("meeting");
                            list7.add(smsBodyExtend);
                            break;
                        case CALENDAR_ID:
                            smsBodyExtend.setImg("/img/calendar/remind.png");
                            smsBodyExtend.setType("calendar");
                            list8.add(smsBodyExtend);
                            break;
                        case DIARY_ID:
                            smsBodyExtend.setImg("/img/diary/remind.png");
                            smsBodyExtend.setType("diary");
                            list9.add(smsBodyExtend);
                            break;
                        case PUBLIC_FILE_ID:
                            smsBodyExtend.setImg("/img/file/publicRemind.png");
                            smsBodyExtend.setType("publicFile");
                            list10.add(smsBodyExtend);
                            break;
                        case SCHEDULE_ID:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("schedule");
                            list111.add(smsBodyExtend);
                            break;
                        case NETDISK_ID:
                            smsBodyExtend.setImg("/img/netdisk/remind.png");
                            smsBodyExtend.setType("netdisk");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                            list12.add(smsBodyExtend);
                            break;
                        case ZNIBANGUANLI:
                            smsBodyExtend.setImg("/img/zhiban2.png");
                            smsBodyExtend.setType("zhibanguanli");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list13.add(smsBodyExtend);
                            break;
                        case BANGONGSHEN:
                            smsBodyExtend.setImg("/img/bangong/bangongyongpinsl_info.png");
                            smsBodyExtend.setType("bangongshen");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list14.add(smsBodyExtend);
                            break;

                        case BBSBOARD_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("bbsBoard");
                            String size111 = smsBodyExtend.getRemindUrl();
                            String[] aStringsss = size111.split("\\?");
                            for (int i = 0; i < aStringsss.length; i++) {
                                if (aStringsss[i].contains("boardId")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringsss[i].contains("BOARD_ID")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list15.add(smsBodyExtend);
                            break;
                        case DISPATCHER:
                            smsBodyExtend.setImg("/img/dispatcher/dispatcher.png");
                            smsBodyExtend.setType("dispatcher");
                            list16.add(smsBodyExtend);
                            break;
                        case THIRD_SYSTEM:
                            smsBodyExtend.setImg("/img/thirdSystem/thirdSystem.png");
                            smsBodyExtend.setType("thirdSystem");
                            list17.add(smsBodyExtend);
                            break;
                        case LEADER_SYSTM:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("leaderSystm");
                            list18.add(smsBodyExtend);
                            break;
                        case PLAN_APPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("planApproval");
                            list19.add(smsBodyExtend);
                            break;
                        case ADD_PLANAPPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("addPlanApproval");
                            list20.add(smsBodyExtend);
                            break;
                        case NOTIFY_OPINION:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("addPlanApproval");
                            list1.add(smsBodyExtend);
                            break;
                        case CRASH_DISPATCH:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("crashDispatch");
                            list21.add(smsBodyExtend);
                            break;
                        case SMS_REMIND:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("crashDispatch");
                            list22.add(smsBodyExtend);
                            break;
                        case CAR_REMIND:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("carApproval");
                            list23.add(smsBodyExtend);
                            break;
                        case TASK_MANAGE:
                            smsBodyExtend.setImg("/img/task/taskremind.png");
                            smsBodyExtend.setType("taskManage");
                            list24.add(smsBodyExtend);
                            break;
                        case HSTMEETING_REMIND:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("hstMeeting");
                            list25.add(smsBodyExtend);
                            break;
                        case BBS_COMMENT:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("bbscomment");
                            list26.add(smsBodyExtend);
                            break;
                        case ASSET_REMIND:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("asset");
                            list27.add(smsBodyExtend);
                            break;
                        case CONTRACT_REMIND:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("contractremind");
                            list28.add(smsBodyExtend);
                            break;
                        case INSTITUTION_CONTENT:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("institutioncontent");
                            list29.add(smsBodyExtend);
                            break;
                        case DUTY_POLICE_USERS:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("dutypoliceusers");
                            list30.add(smsBodyExtend);
                            break;
                        case JHT_MEETING:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("jhtmeeting");
                            list31.add(smsBodyExtend);
                            break;
                        case PLAN_MANAGE:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("planManage");
                            list33.add(smsBodyExtend);//计划考核
                            break;
                        case CRM_CERTIFICATE:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("crmcertificate");
                            list34.add(smsBodyExtend);
                            break;
                        case ASSESSMENT:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("assessment");
                            list35.add(smsBodyExtend);
                            break;
                        case PARTYMEMBER:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("partyMember");
                            long time = new Date().getTime();
                            time = time / 1000;
                            Integer sendTime = smsBodyExtend.getSendTime();
                            if (sendTime < time) {
                                list36.add(smsBodyExtend);
                            }
                            break;
                        case HR_STAFF_LICENSE:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("hrstafflicense");
                            long time84 = new Date().getTime() / 1000;
                            Integer sendTime84 = smsBodyExtend.getSendTime();
                            if (sendTime84 < time84) {
                                list37.add(smsBodyExtend);
                            }
                            break;
                        case EHR_AGENCY:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("ehrAgency");
                            list38.add(smsBodyExtend);
                            break;
                        case INTEGRAL_MANAGER:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("IntegralManager");
                            list39.add(smsBodyExtend);
                            break;
                        case PASSWORD_MANAGER:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("passwordManager");
                            list40.add(smsBodyExtend);
                            break;
                        case HR_STAFF_CARE:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("hrStaffCare");
                            list41.add(smsBodyExtend);
                            break;
                        case WAGES_MANAGER:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("wagesManager");
                            list42.add(smsBodyExtend);
                            break;
                        case ATTENDANCE_MANAGER:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("attendanceManager");
                            list43.add(smsBodyExtend);
                            break;
                        case SYSTYPE:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("systype");
                            list44.add(smsBodyExtend);
                            break;
                        case TOWORK:
                            smsBodyExtend.setImg("/img/task/taskremind.png");
                            smsBodyExtend.setType("towork");
                            list45.add(smsBodyExtend);
                        case RAPIDZHUO:
                            smsBodyExtend.setImg("/img/main_img/app/s0.png");
                            smsBodyExtend.setType("rapidZhuo");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list46.add(smsBodyExtend);
                    }
                }
            }
            daiBanModel.setDocumentList(list4);
            daiBanModel.setEmail(list);
            daiBanModel.setNewsList(list3);
            daiBanModel.setEmailPlus(list11);
            daiBanModel.setNotify(list1);
            daiBanModel.setWorkFlow(list2);
            daiBanModel.setToupiao(list5);
            daiBanModel.setSupervisions(list6);
            daiBanModel.setMeeting(list7);
            daiBanModel.setCalendars(list8);
            daiBanModel.setDiarys(list9);
            daiBanModel.setPublicFiles(list10);
            daiBanModel.setSchedules(list111);
            daiBanModel.setNetDisk(list12);
            daiBanModel.setZhiBan(list13);
            daiBanModel.setBangong(list14);
            daiBanModel.setBbsBoard(list15);
            daiBanModel.setDispatcher(list16);
            daiBanModel.setThirdSystem(list17);
            daiBanModel.setSchedules(list18);
            daiBanModel.setAddPlanApproval(list20);
            daiBanModel.setCrashDispAtch(list21);
            daiBanModel.setRemind(list22);
            daiBanModel.setCheliang(list23);
            daiBanModel.setTaskManage(list24);
            daiBanModel.setHstMeeting(list25);
            daiBanModel.setBbscomment(list26);
            daiBanModel.setAsset(list27);
            daiBanModel.setContractremind(list28);
            daiBanModel.setInstitutioncontent(list29);
            daiBanModel.setDutypoliceusers(list30);
            daiBanModel.setJhtmeeting(list31);
            daiBanModel.setPlanManage(list33);//计划考核
            daiBanModel.setCrmcertificate(list34);//资格证书
            daiBanModel.setAssessments(list35);
            daiBanModel.setPartyMember(list36);
            daiBanModel.setHrStaffLicense(list37);//证照管理
            daiBanModel.setEhrAgency(list38);//ehr代办
            daiBanModel.setIntegralManager(list39);
            daiBanModel.setPasswordManager(list40);//密码管理
            daiBanModel.setHrStaffCare(list41);
            daiBanModel.setWagesManager(list42);//薪资管理
            daiBanModel.setAttendanceManager(list43);
            daiBanModel.setSysType(list44);//系统类型
            daiBanModel.setTowork(list45);
            daiBanModel.setRapidZhuo(list46);

            baseWrapper.setData(daiBanModel);
        } catch (Exception e) {
            e.printStackTrace();
            L.e("smsListByType：" + e.getMessage());
            baseWrapper.setMsg(e.getMessage());
            baseWrapper.setFlag(false);
            return baseWrapper;
        }
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    @Override
    public BaseWrapper getWillDocSendOrReceive(String userId, String documentType, HttpServletRequest request) {

        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        DaiBanModel daiBanModel = new DaiBanModel();
        List<SmsBodyExtend> documentList = new ArrayList<SmsBodyExtend>();

        baseWrapper.setData(documentList);
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    @Override
    public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        List<TodoListModel> todoListModels = new ArrayList<TodoListModel>();
        List<SysFunction> sysFunctions = sysFunctionMapper.getUserFunctionByUserId(userId);
        // 获取当前语言
        String local = getNowLanguage(request);

        for (SysFunction sysFunction : sysFunctions) {
            TodoListModel todoListModel = new TodoListModel();
            if ("email/index".equals(sysFunction.getUrl())) {
                todoListModel.setCode("email");
                todoListModel.setImg("/img/widget/toEmail.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel.setName("发送邮件");
                } else if (local.equals("zh_TW")) {
                    todoListModel.setName("發送郵件");
                } else if (local.equals("en_US")) {
                    todoListModel.setName("Send mail");
                }

                todoListModels.add(todoListModel);
            } else if ("Notes/index".equals(sysFunction.getUrl())) {
                todoListModel.setCode("notes");
                todoListModel.setImg("/img/widget/notes.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel.setName("新建便签");
                } else if (local.equals("zh_TW")) {
                    todoListModel.setName("新建便簽");
                } else if (local.equals("en_US")) {
                    todoListModel.setName("Newly-built note");
                }

                todoListModels.add(todoListModel);
            } else if ("diary/index".equals(sysFunction.getUrl())) {
                todoListModel.setCode("diary");
                todoListModel.setImg("/img/widget/todiary.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel.setName("撰写日志");
                } else if (local.equals("zh_TW")) {
                    todoListModel.setName("撰写日志");
                } else if (local.equals("en_US")) {
                    todoListModel.setName("Write a log");
                }


                todoListModels.add(todoListModel);
            } else if ("schedule/index".equals(sysFunction.getUrl())) {
                todoListModel.setCode("calendar");
                todoListModel.setImg("/img/widget/toCalendar.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel.setName("新建日程");
                } else if (local.equals("zh_TW")) {
                    todoListModel.setName("新建日程");
                } else if (local.equals("en_US")) {
                    todoListModel.setName("New schedule");
                }

                todoListModels.add(todoListModel);
            } else if ("/attendPage/myAttendance".equals(sysFunction.getUrl())) {
                todoListModel.setCode("qingjia");
                todoListModel.setImg("/img/widget/toQingjia.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel.setName("请假申请");
                } else if (local.equals("zh_TW")) {
                    todoListModel.setName("請假申請");
                } else if (local.equals("en_US")) {
                    todoListModel.setName("application for leave");
                }
                todoListModels.add(todoListModel);
                TodoListModel todoListModel1 = new TodoListModel();
                todoListModel1.setCode("jiaban");
                todoListModel1.setImg("/img/widget/toJiaban.png");//图片
                if (local.equals("zh_CN")) {
                    todoListModel1.setName("加班申请");
                } else if (local.equals("zh_TW")) {
                    todoListModel1.setName("加班申請");
                } else if (local.equals("en_US")) {
                    todoListModel1.setName("Over application");
                }

                todoListModels.add(todoListModel1);
            }

        }
        baseWrapper.setData(todoListModels);
        baseWrapper.setStatus(true);
        baseWrapper.setFlag(true);

        return baseWrapper;
    }


    public BaseWrapper smsListByReadType(String userId, HttpServletRequest request, String type) {

        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        DaiBanModel daiBanModel = new DaiBanModel();
        List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list11 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", userId);
        List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsListByType(map);
        Iterator iter = smsBodyExtendList.iterator();
        while (iter.hasNext()) {
            SmsBodyExtend smsBodyExtend = (SmsBodyExtend) iter.next();
            smsBodyExtend.setFromUid(user.getUid());
            smsBodyExtend.setFromName(user.getUserName());
            switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                case EMAIL_ID:
                    smsBodyExtend.setImg("/img/workflow/youjian.png");
                    smsBodyExtend.setType("email");
                    String size1 = smsBodyExtend.getRemindUrl();
                    String[] aStrings = size1.split("\\?");
                    for (int i = 0; i < aStrings.length; i++) {
                        if (aStrings[i].contains("id")) {
                            String[] s = aStrings[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    list.add(smsBodyExtend);
                    break;
                case EMAILPLUS_ID:
                    smsBodyExtend.setImg("/img/workflow/youjian.png");
                    smsBodyExtend.setType("emailPlus");
                    String size11 = smsBodyExtend.getRemindUrl();
                    String[] aStringss = size11.split("\\?");
                    for (int i = 0; i < aStringss.length; i++) {
                        if (aStringss[i].contains("id")) {
                            String[] s = aStringss[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    list11.add(smsBodyExtend);
                    break;
                case NOTIFY_ID:
                    smsBodyExtend.setImg("/img/workflow/notify.png");
                    smsBodyExtend.setType("notify");
                    String size2 = smsBodyExtend.getRemindUrl();
                    String[] aStrings2 = size2.split("\\?");
                    for (int i = 0; i < aStrings2.length; i++) {
                        if (aStrings2[i].contains("notifyId")) {
                            String[] s = aStrings2[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    list1.add(smsBodyExtend);

                    break;
                case FLOWRUNPRCS_ID:
                    break;
                case NEWS_ID:
                    smsBodyExtend.setImg("/img/workflow/news.png");
                    smsBodyExtend.setType("news");
                    String size3 = smsBodyExtend.getRemindUrl();
                    String[] aStrings3 = size3.split("\\?");
                    for (int i = 0; i < aStrings3.length; i++) {
                        if (aStrings3[i].contains("newsId")) {
                            String[] s = aStrings3[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    list3.add(smsBodyExtend);
                    break;
                case DOCTMENT_ID:
                    break;
                case VOTELTEM_ID:
                    smsBodyExtend.setImg("/img/workflow/publish.png");
                    smsBodyExtend.setType("toupiao");
                    String size6 = smsBodyExtend.getRemindUrl();
                    String[] aStrings6 = size6.split("\\?");
                    for (int i = 0; i < aStrings6.length; i++) {
                        if (aStrings6[i].contains("resultId")) {
                            String[] s = aStrings6[i].split("=");
                            String[] s1 = s[i].split("&");
                            smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                            break;
                        }
                    }
                    list5.add(smsBodyExtend);
                    break;

            }
        }
        daiBanModel.setDocumentList(list4);
        daiBanModel.setEmail(list);
        daiBanModel.setNewsList(list3);
        daiBanModel.setEmailPlus(list11);
        daiBanModel.setNotify(list1);
        daiBanModel.setWorkFlow(list2);
        daiBanModel.setToupiao(list5);
        baseWrapper.setData(daiBanModel);
        return baseWrapper;
    }

    private String getNowLanguage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object localObj = SessionUtils.getSessionInfo(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", Object.class, redisSessionCookie);
        String local = "";
        if (localObj != null) {
            if (StringUtils.checkNull(localObj.toString())) {
                local = "zh_CN";
                SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", "zh_CN", redisSessionCookie);
            } else {
                local = localObj.toString();
            }
        } else {
            local = "zh_CN";
            SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", "zh_CN", redisSessionCookie);
        }
        return local;
    }

    /**
     * PC端事务提醒
     *
     * @param userId
     * @param request
     * @return
     */
    @Override
    public BaseWrapper smsListByTypeByPC(String userId, HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setFlag(false);
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            // 查询未确认提醒的
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            if (StringUtils.checkNull(userId)) {
                userId = users.getUserId();
            }
            map.put("userId", userId);
            // 根据2022.1.25日 高总需求 注释掉这两个查询
           /* List<SmsBodyExtend> totalList = smsBodyMapper.selByUnread(map);
            List<SmsBodyExtend> emailList=smsBodyMapper.selByEmail(map);*/
            int totalCount = smsBodyMapper.selByUnreadCount(map);

            map.put("fromId", userId);
            Integer emailCount = emailBodyMapper.getNoReadCount(map);

            DaiBanPC daiBanPC = new DaiBanPC();
            daiBanPC.setEmail(new ArrayList<>());
            daiBanPC.setEmailCount(emailCount);
            daiBanPC.setTotalList(new ArrayList<>());
            daiBanPC.setTotalCount(totalCount);
            baseWrapper.setData(daiBanPC);
            baseWrapper.setFlag(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return baseWrapper;
    }

    /**
     * PC端事务提醒数量
     *
     * @param userId
     * @param request
     * @return
     */
    @Override
    public BaseWrapper smsListCountByPC(String userId, HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setFlag(false);
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            String s = DateFormatUtils.formatDate(new Date(

            ));
            Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
            map.put("sendTime", nowDateTime);
            // 查询未确认提醒的
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            if (StringUtils.checkNull(userId)) {
                userId = users.getUserId();
            }
            map.put("userId", userId);
            int totalCount = smsBodyMapper.selByUnreadCount(map);
            int emailCount = smsBodyMapper.selByEmailCount(map);
            DaiBanPC daiBanPC = new DaiBanPC();
            daiBanPC.setEmailCount(emailCount);
            daiBanPC.setTotalCount(totalCount);
            baseWrapper.setData(daiBanPC);
            baseWrapper.setFlag(true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return baseWrapper;
    }

    @Override
    public BaseWrapper smsListByPowerChina(String userId, HttpServletRequest request, String type) {
        BaseWrapper baseWrapper = new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        DaiBanModel daiBanModel = new DaiBanModel();
        List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list6 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list7 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list8 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list9 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list10 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list11 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list12 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list111 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list13 = new ArrayList<SmsBodyExtend>();
        List<SmsBodyExtend> list14 = new ArrayList<>();
        List<SmsBodyExtend> list15 = new ArrayList<>();
        List<SmsBodyExtend> list16 = new ArrayList<>();
        List<SmsBodyExtend> list17 = new ArrayList<>();
        List<SmsBodyExtend> list18 = new ArrayList<>();
        List<SmsBodyExtend> list19 = new ArrayList<>();
        List<SmsBodyExtend> list20 = new ArrayList<>();
        List<SmsBodyExtend> list21 = new ArrayList<>();
        List<SmsBodyExtend> list22 = new ArrayList<>();//提醒计划
        List<SmsBodyExtend> list23 = new ArrayList<>();
        List<SmsBodyExtend> list24 = new ArrayList<>();
        List<SmsBodyExtend> list25 = new ArrayList<>();
        List<SmsBodyExtend> list26 = new ArrayList<>();
        List<SmsBodyExtend> list27 = new ArrayList<>();

        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "1");
            Date date = new Date();
            try {
                String s = DateFormatUtils.formatDate(date);
                Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
                map.put("remindTime", nowDateTime);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsBaseInfoListByType(map);
            Iterator iter = smsBodyExtendList.iterator();


            while (iter.hasNext()) {
                SmsBodyExtend smsBodyExtend = (SmsBodyExtend) iter.next();
                SmsBodyExtend smsBodyExtend1 = smsBodyMapper.selBodyAndUserInfo(smsBodyExtend.getBodyId());
                if (smsBodyExtend1 == null)
                    continue;

                if(!Objects.isNull(smsBodyExtend.getRemindUrl())) {
                    if (!smsBodyExtend.getRemindUrl().contains("?")) {
                        smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "?");
                    }
                    smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                }
                // 设置发送用户信息
                smsBodyExtend.setAvater(smsBodyExtend1.getAvater());
                smsBodyExtend.setUid(smsBodyExtend1.getUid());
                smsBodyExtend.setUserName(smsBodyExtend1.getUserName());
                // 设置body信息
                smsBodyExtend.setFromId(smsBodyExtend1.getFromId());
                smsBodyExtend.setSmsType(smsBodyExtend1.getSmsType());
                smsBodyExtend.setContent(smsBodyExtend1.getContent());
                smsBodyExtend.setSendTime(smsBodyExtend1.getSendTime());
                smsBodyExtend.setRemindUrl(smsBodyExtend1.getRemindUrl());
                smsBodyExtend.setIsAttach(smsBodyExtend1.getIsAttach());

                // 这两行代码不知道是什么意思 from设置为了当前用户的id和name 因为是以前别人写的代码 所以暂时不删除 -张航宁
                smsBodyExtend.setFromUid(user.getUid());
                smsBodyExtend.setFromName(user.getUserName());
                //--------------------
                if (!StringUtils.checkNull(smsBodyExtend.getSmsType())) {
                    switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                        case EMAIL_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("email");
                            String size1 = smsBodyExtend.getRemindUrl();
                            String[] aStrings = size1.split("\\?");
                            for (int i = 0; i < aStrings.length; i++) {
                                if (aStrings[i].contains("id")) {
                                    String[] s = aStrings[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings[i].contains("EMAIL_ID")) {
                                    String[] s = null;
                                    if (aStrings[i].contains("&")) {
                                        String[] str = null;
                                        str = aStrings[i].split("&");
                                        if (str[i].contains("=")) {
                                            s = str[i].split("=");
                                        }
                                    } else {
                                        s = aStrings[i].split("=");
                                    }
                                    break;
                                }
                            }
                            list.add(smsBodyExtend);
                            break;
                        case EMAILPLUS_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("emailPlus");
                            String size11 = smsBodyExtend.getRemindUrl();
                            String[] aStringss = size11.split("\\?");
                            for (int i = 0; i < aStringss.length; i++) {
                                if (aStringss[i].contains("id")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringss[i].contains("EMAILPLUS_ID")) {
                                    String[] s = aStringss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list11.add(smsBodyExtend);
                            break;
                        case NOTIFY_ID:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("notify");
                            String size2 = smsBodyExtend.getRemindUrl();
                            String[] aStrings2 = size2.split("\\?");
                            for (int i = 0; i < aStrings2.length; i++) {
                                if (aStrings2[i].contains("notifyId")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStrings2[i].contains("NOTIFY_ID")) {
                                    String[] s = aStrings2[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list1.add(smsBodyExtend);

                            break;
                        case FLOWRUNPRCS_ID:
                            break;
                        case NEWS_ID:
                            smsBodyExtend.setImg("/img/workflow/news.png");
                            smsBodyExtend.setType("news");
                            String size3 = smsBodyExtend.getRemindUrl();
                            String[] aStrings3 = size3.split("\\?");
                            for (int i = 0; i < aStrings3.length; i++) {
                                if (aStrings3[i].contains("newsId")) {
                                    String[] s = aStrings3[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list3.add(smsBodyExtend);
                            break;
                        case DOCTMENT_ID:
                            break;
                        case VOTELTEM_ID:
                            smsBodyExtend.setImg("/img/workflow/publish.png");
                            smsBodyExtend.setType("toupiao");
                            String size6 = smsBodyExtend.getRemindUrl();
                            String[] aStrings6 = size6.split("\\?");
                            for (int i = 0; i < aStrings6.length; i++) {
                                if (aStrings6[i].contains("resultId")) {
                                    String[] s = aStrings6[i].split("=");
                                    String[] s1 = s[i].split("&");
                                    smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                                    break;
                                }
                            }
                            list5.add(smsBodyExtend);
                            break;
                        case SUPERVISION_ID:
                            smsBodyExtend.setImg("/img/supervision/remind.png");
                            smsBodyExtend.setType("supervision");
                            list6.add(smsBodyExtend);
                            break;
                        case MEETING_ID:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("meeting");
                            list7.add(smsBodyExtend);
                            break;
                        case CALENDAR_ID:
                            smsBodyExtend.setImg("/img/calendar/remind.png");
                            smsBodyExtend.setType("calendar");
                            list8.add(smsBodyExtend);
                            break;
                        case DIARY_ID:
                            smsBodyExtend.setImg("/img/diary/remind.png");
                            smsBodyExtend.setType("diary");
                            list9.add(smsBodyExtend);
                            break;
                        case PUBLIC_FILE_ID:
                            smsBodyExtend.setImg("/img/file/publicRemind.png");
                            smsBodyExtend.setType("publicFile");
                            list10.add(smsBodyExtend);
                            break;
                        case SCHEDULE_ID:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("schedule");
                            list111.add(smsBodyExtend);
                            break;
                        case NETDISK_ID:
                            smsBodyExtend.setImg("/img/netdisk/remind.png");
                            smsBodyExtend.setType("netdisk");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl() + "&bodyId=" + smsBodyExtend.getBodyId());
                            list12.add(smsBodyExtend);
                            break;
                        case ZNIBANGUANLI:
                            smsBodyExtend.setImg("/img/zhiban2.png");
                            smsBodyExtend.setType("zhibanguanli");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list13.add(smsBodyExtend);
                            break;
                        case BANGONGSHEN:
                            smsBodyExtend.setImg("/img/bangong/bangongyongpinsl_info.png");
                            smsBodyExtend.setType("bangongshen");
                            smsBodyExtend.setRemindUrl(smsBodyExtend.getRemindUrl());
                            list14.add(smsBodyExtend);
                            break;

                        case BBSBOARD_ID:
                            smsBodyExtend.setImg("/img/workflow/youjian.png");
                            smsBodyExtend.setType("bbsBoard");
                            String size111 = smsBodyExtend.getRemindUrl();
                            String[] aStringsss = size111.split("\\?");
                            for (int i = 0; i < aStringsss.length; i++) {
                                if (aStringsss[i].contains("boardId")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                } else if (aStringsss[i].contains("BOARD_ID")) {
                                    String[] s = aStringsss[i].split("=");
                                    smsBodyExtend.setQid(Integer.parseInt(s[1]));
                                    break;
                                }
                            }
                            list15.add(smsBodyExtend);
                            break;
                        case DISPATCHER:
                            smsBodyExtend.setImg("/img/dispatcher/dispatcher.png");
                            smsBodyExtend.setType("dispatcher");
                            list16.add(smsBodyExtend);
                            break;
                        case THIRD_SYSTEM:
                            smsBodyExtend.setImg("/img/thirdSystem/thirdSystem.png");
                            smsBodyExtend.setType("thirdSystem");
                            list17.add(smsBodyExtend);
                            break;
                        case LEADER_SYSTM:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("leaderSystm");
                            list18.add(smsBodyExtend);
                            break;
                        case PLAN_APPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("planApproval");
                            list19.add(smsBodyExtend);
                            break;
                        case ADD_PLANAPPROVAL:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("addPlanApproval");
                            list20.add(smsBodyExtend);
                            break;
                        case NOTIFY_OPINION:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("addPlanApproval");
                            list1.add(smsBodyExtend);
                            break;
                        case CRASH_DISPATCH:
                            smsBodyExtend.setImg("/img/workflow/notify.png");
                            smsBodyExtend.setType("crashDispatch");
                            list21.add(smsBodyExtend);
                            break;
                        case SMS_REMIND:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("crashDispatch");
                            list22.add(smsBodyExtend);
                            break;
                        case CAR_REMIND:
                            smsBodyExtend.setImg("/img/schedule/remind.png");
                            smsBodyExtend.setType("carApproval");
                            list23.add(smsBodyExtend);

                            break;

                        case HSTMEETING_REMIND:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("hstMeeting");
                            list25.add(smsBodyExtend);

                            break;
                        case ASSET_REMIND:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("asset");
                            list27.add(smsBodyExtend);

                            break;
                        case BBS_COMMENT:
                            smsBodyExtend.setImg("/img/meeting/remind.png");
                            smsBodyExtend.setType("bbscomment");
                            list26.add(smsBodyExtend);
                            break;
                        case TASK_MANAGE:
                            smsBodyExtend.setImg("/img/task/taskremind.png");
                            smsBodyExtend.setType("taskManage");
                            list24.add(smsBodyExtend);
                            break;
                    }
                }
            }
            daiBanModel.setDocumentList(list4);// 公文
            //daiBanModel.setEmail(list);
            //daiBanModel.setNewsList(list3);
            //daiBanModel.setEmailPlus(list11);
            daiBanModel.setNotify(list1);// 公告
            daiBanModel.setWorkFlow(list2);// 工作流
            //daiBanModel.setToupiao(list5);
            //daiBanModel.setSupervisions(list6);
            daiBanModel.setMeeting(list7);//会议
            //daiBanModel.setCalendars(list8);
            //daiBanModel.setDiarys(list9);
            //daiBanModel.setPublicFiles(list10);
            //daiBanModel.setSchedules(list111);
//            for (SmsBodyExtend smsBodyExtend:list12) {
//                String[] array = smsBodyExtend.getRemindUrl().split("basePath");
//                String path =array[0]+CheckAll.encryptBasedDes(array[1]);
//                smsBodyExtend.setRemindUrl(path);
//            }
            //daiBanModel.setNetDisk(list12);
            //daiBanModel.setZhiBan(list13);
            //daiBanModel.setBangong(list14);
            //daiBanModel.setBbsBoard(list15);
            //daiBanModel.setDispatcher(list16);
            //daiBanModel.setThirdSystem(list17);
            //daiBanModel.setSchedules(list18);
//            daiBanModel.setPlanApproval(list19);
            //daiBanModel.setAddPlanApproval(list20);
            //daiBanModel.setCrashDispAtch(list21);
            //daiBanModel.setRemind(list22);
            //daiBanModel.setCheliang(list23);
            //daiBanModel.setTaskManage(list24);
            daiBanModel.setHstMeeting(list25);//视频会议
            //daiBanModel.setBbscomment(list26);
            //daiBanModel.setAsset(list27);
            baseWrapper.setData(daiBanModel);
        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setMsg(e.getMessage());
            baseWrapper.setFlag(false);
            return baseWrapper;
        }
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }

    @Override
    public Daiban readPowerChina(String userId, String sqlType, HttpServletRequest request, String superfluity) throws Exception {
        Daiban db = new Daiban();
        Integer total = 0;
        if ("1".equals(superfluity)) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "0");
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.readPowerChina(map);
            total = smsBodyExtendList.size();
        } else {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("flag", "1");
            Date date = new Date();
            String s = DateFormatUtils.formatDate(date);
            Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
            map.put("sendTime", nowDateTime);
            List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.readPowerChina(map);
            total = smsBodyExtendList.size();
        }


        db.setTotal(total);
        return db;
    }


}
