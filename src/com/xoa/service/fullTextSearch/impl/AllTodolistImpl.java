package com.xoa.service.fullTextSearch.impl;

import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.voteTitle.VoteTitleMapper;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.Users;
import com.xoa.service.email.EmailService;
import com.xoa.service.fullTextSearch.AllTodolistService;
import com.xoa.service.notify.NotifyService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UsersService;
import com.xoa.service.worldnews.NewService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2018/3/15.
 */
@Service
public class AllTodolistImpl implements AllTodolistService {

        @Resource
        private EmailService emailService;

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
        SmsBodyMapper  smsBodyMapper;
        @Resource
        SysParaService sysParaService;
        @Resource
        UserFunctionService userFunctionService;

/*
        @Override
        public AllDaiban list(String userId, String sqlType, HttpServletRequest request) throws Exception {
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            Map<String, Object> maps = new HashMap<String, Object>();
            maps.put("fromId", userId);
            Users usersByuserId = usersMapper.findUsersByuserId(userId);
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
            List<AllTodoList> list = new ArrayList<AllTodoList>();
            List<AllTodoList> list1 = new ArrayList<AllTodoList>();
            List<AllTodoList> list2 = new ArrayList<AllTodoList>();
            List<AllTodoList> list3 = new ArrayList<AllTodoList>();
            List<AllTodoList> list5 = new ArrayList<AllTodoList>();
            List<AllTodoList> list6 = new ArrayList<AllTodoList>();
            AllDaiban dba = new AllDaiban();
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
                    AllTodoList td = new AllTodoList();
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
            ToJson<Notify> ln = notifyService.unreadNotify(maps, 1, 10, false, userId, sqlType);
            List<Notify> l = ln.getObj();
            if (l != null && l.size() > 0) {
                for (Notify no : l) {
                    AllTodoList td = new AllTodoList();
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
            ToJson<News> news = newService.unreadNews(maps, 1, 10, false, userId, sqlType);

            List<News> newsList = news.getObj();
            if (newsList != null && newsList.size() > 0) {
                for (News newsOne : newsList) {
                    AllTodoList td = new AllTodoList();
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

            ToJson<FlowRunPrcs> toJson = flowRunPrcsService.selectObject(maps, 1, 10, false);
            List<FlowRunPrcs> listFlowRunPrcs = toJson.getObj();
            if (listFlowRunPrcs != null && listFlowRunPrcs.size() > 0) {
                for (FlowRunPrcs flowRunPrcs : listFlowRunPrcs) {
                    FlowRun flowRun = flowRunService.find(flowRunPrcs.getRunId());
                    AllTodoList td = new AllTodoList();
                    String userId2 = flowRunPrcs.getUserId();
                    Users u = usersService.findUsersByuserId(userId2);
                    td.setUid(u.getUid());
                    td.setAvater(u.getAvatar());
                    td.setContent(request.getScheme() + "://" + request.getServerName() + ":" +
                            request.getServerPort() + "/workflow/work/workform?flowId=" + flowRun.getFlowId() + "&flowStep=" + flowRunPrcs.getPrcsId() + "&runId=" + flowRunPrcs.getRunId() + "&prcsId=" + flowRunPrcs.getFlowPrcs() + "");
                    td.setFromName(flowRun.getRunName());
                    td.setImg("/img/workflow/daibanliucheng.png");
                    td.setQid(flowRunPrcs.getId());
                    td.setReadflag(flowRunPrcs.getPrcsFlag());
                    td.setType("willdo");
                    td.setRunId(flowRunPrcs.getRunId());
                    td.setFlowId(flowRun.getFlowId());

                    td.setTime(flowRunPrcs.getCreateTime().substring(0, flowRunPrcs.getPrcsTime().length() - 2));
                    td.setDeleteFlag("");
                    td.setUserName(u.getUserName());
                    td.setIsAttach("0");
                    td.setFromId(u.getUserId());
                    td.setFromUid(u.getUid());
                    list2.add(td);
                }
            }
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("documentType", 0);
            param.put("page", 0);
            param.put("pageSize", 5);
            param.put("userId", users.getUserId());
            param.put("prcsFlag", 1);

            List<DocumentModelFlowRunPrcs> datas = documentModelMapper.selWillDocSendOrReceive(param);
            if (datas != null && datas.size() > 0) {
                for (DocumentModelFlowRunPrcs documentModelOverRun : datas) {
                    AllTodoList td = new AllTodoList();
                    String userId2 = documentModelOverRun.getCreater();
                    Users u = usersService.findUsersByuserId(userId2);
                    td.setUid(u.getUid());
                    td.setAvater(u.getAvatar());
                    td.setContent(request.getScheme() + "://" + request.getServerName() + ":" +
                            request.getServerPort() + "/workflow/work/workform?flowId=" + documentModelOverRun.getFlowId() + "&flowStep=" + documentModelOverRun.getRealPrcsId() + "&runId=" + documentModelOverRun.getRunId() + "&prcsId=" + documentModelOverRun.getStep() + "");
                    td.setFromName(documentModelOverRun.getTitle()==null?"":documentModelOverRun.getTitle());
                    td.setQid(documentModelOverRun.getId());
                    td.setReadflag(documentModelOverRun.getRealPrcsId().toString());
                    td.setType("doctment");
                    td.setImg("/img/workflow/doctment.png");
                    td.setRunId(documentModelOverRun.getRunId());
                    td.setFlowId(documentModelOverRun.getFlowId());
                    td.setTime(documentModelOverRun.getCreateTime().substring(0,documentModelOverRun.getCreateTime().length()-2));
                    td.setDeleteFlag("");
                    td.setUserName(u.getUserName());
                    td.setIsAttach("0");
                    td.setFromId(u.getUserId());
                    td.setFromUid(u.getUid());
                    list5.add(td);
                }
            }
            list6=touPiaoDaiBanTongJi(request, users);
            dba.setTotal(total);
            dba.setEmail(list);
            dba.setNotify(list1);
            dba.setWorkFlow(list2);
            dba.setNewsList(list3);
            dba.setDocumentList(list5);
            dba.setToupiao(list6);
            return dba;

        }


        @Override
        public AllDaiban readList(String userId, String sqlType, HttpServletRequest request) throws Exception {
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
            List<AllTodoList> list = new ArrayList<AllTodoList>();
            List<AllTodoList> list1 = new ArrayList<AllTodoList>();
            List<AllTodoList> list2 = new ArrayList<AllTodoList>();
            List<AllTodoList> list3 = new ArrayList<AllTodoList>();
            AllDaiban dba = new AllDaiban();
            InetAddress address = this.getCurrentIp();
            ToJson<EmailBodyModel> tojson = emailService.selectInboxIsReadList(maps, 1, 10, false, sqlType);
            List<EmailBodyModel> le = tojson.getObj();
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            if (le != null && le.size() > 0) {
                for (EmailBodyModel em : le) {
                    //发件人userId
                    String userId2 = em.getFromId();
                    Users u = usersService.findUsersByuserId(userId2);
                    AllTodoList td = new AllTodoList();
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
            ToJson<Notify> ln = notifyService.readNotify(maps, 1, 10, false, userId, sqlType);
            List<Notify> l = ln.getObj();
            if (l != null && l.size() > 0) {
                for (Notify no : l) {
                    AllTodoList td = new AllTodoList();
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
                    AllTodoList td = new AllTodoList();
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

            ToJson<FlowRunPrcs> toJson = flowRunPrcsService.selectEnd(maps, 1, 10, false);
            List<FlowRunPrcs> listFlowRunPrcs = toJson.getObj();
            if (listFlowRunPrcs != null && listFlowRunPrcs.size() > 0) {
                for (FlowRunPrcs flowRunPrcs : listFlowRunPrcs) {
                    FlowRun flowRun = flowRunService.find(flowRunPrcs.getRunId());
                    AllTodoList td = new AllTodoList();
                    String userId2 = flowRunPrcs.getUserId();
                    Users u = usersService.findUsersByuserId(userId2);
                    td.setUid(u.getUid());
                    td.setAvater(u.getAvatar());
                    td.setContent(request.getScheme() + "://" + request.getServerName() + ":" +
                            request.getServerPort() + "/workflow/work/workform?flowId=" + flowRun.getFlowId() + "&flowStep=" + flowRunPrcs.getPrcsId() + "&runId=" + flowRunPrcs.getRunId() + "&prcsId=" + flowRunPrcs.getPrcsFlag() + "");
                    td.setFromName(flowRun.getRunName());
                    td.setImg("/img/workflow/daibanliucheng.png");
                    td.setQid(flowRunPrcs.getId());
                    td.setReadflag(flowRunPrcs.getPrcsFlag());
                    td.setType("willdo");

                    td.setTime(flowRunPrcs.getPrcsTime().substring(0, flowRunPrcs.getPrcsTime().length() - 2));
                    td.setDeleteFlag("");
                    td.setUserName(u.getUserName());
                    td.setIsAttach("0");
                    td.setFromId(u.getUserId());
                    td.setFromUid(u.getUid());
                    list2.add(td);
                }
            }

            dba.setEmail(list);
            dba.setNotify(list1);
            dba.setWorkFlow(list2);
            dba.setNewsList(list3);
            return dba;
        }

        @Override
        public AllDaiban readTotal(String userId, String sqlType, HttpServletRequest request, String superfluity) throws Exception {
            AllDaiban dba = new AllDaiban();
            Integer total = 0;
            if ("1".equals(superfluity)) {
                Map<String,Object> map=new HashMap<String,Object>();
                map.put("userId",userId);
                map.put("flag","0");
                List<SmsBodyExtend>  smsBodyExtendList=smsBodyMapper.SmsListByType(map);
                total = smsBodyExtendList.size();
            } else {
                Map<String,Object> map=new HashMap<String,Object>();
                map.put("userId",userId);
                map.put("flag","1");
                List<SmsBodyExtend>  smsBodyExtendList=smsBodyMapper.SmsListByType(map);
                total = smsBodyExtendList.size();
            }


            dba.setTotal(total);
            return dba;
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
         */
/*   Map<String, Object> Objmaps = new HashMap<String, Object>();
            Objmaps.put("userId", usersByuserId.getUserId());
            Objmaps.put("flag","1");
            Objmaps.put("type","2");
            List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
            String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
             smsMapper.updateSmsByIds("0",toBeStored);*//*

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
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","2");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);
            } else if (NOTIFY.equals(classification)) {
                ToJson<Notify> ln = notifyService.unreadNotify(maps, 1, 10, false, userId, sqlType);
                List<Notify> notifies = ln.getObj();

                for (Notify notify : notifies) {
                    maps.put("notifyId", notify.getNotifyId());
                    Notify notifyOne = notifyService.queryById(maps, 1, 20, false, userId, sqlType, "2");

                }
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","1");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);
            } else if (NEWS.equals(classification)) {
                ToJson<News> news = newService.unreadNews(maps, 1, 10, false, userId, sqlType);
                List<News> newsList = news.getObj();
                for (News news1 : newsList) {
                    maps.put("newsId", news1.getNewsId());
                    News news2 = newService.queryById(maps, 1, 5, false,
                            userId, sqlType, "2");
                }
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","14");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);

            } else if (WORKFLOW.equals(classification)) {
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","7");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);
            }else if (TOPIAO.equals(classification)) {
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","11");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);
            }else if (DOCTMENT.equals(classification)) {
                Map<String, Object> Objmaps = new HashMap<String, Object>();
                Objmaps.put("userId", usersByuserId.getUserId());
                Objmaps.put("flag","1");
                Objmaps.put("type","70");
                List<String>  smsBodyExtends=  smsBodyMapper.SmsListMsgByType(Objmaps);
                String[] toBeStored = smsBodyExtends.toArray(new String[smsBodyExtends.size()]);
                smsMapper.updateSmsByIds("0",toBeStored);
            }
            baseWrapper.setStatus(true);
            baseWrapper.setFlag(true);
            baseWrapper.setMsg("ok");
            baseWrapper.setData("ok");

            return baseWrapper;
        }

        // ID 常量
        private final static String EMAIL = "email";
        private final static String NOTIFY = "notify";
        private final static String NEWS = "news";
        private final static String WORKFLOW = "willdo";
        private final static String DOCTMENT = "doctment";
        private final static String TOPIAO = "toupiao";


        @Override
        public AllDaiban delete(Integer qid, String type) {
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
*/


        /**
         * 创建作者:   张丽军
         * 创建日期:   2017年6月27日 下午10:32:22
         * 方法介绍:   根据userId进行模糊查询
         * 参数说明:   @param userId
         * 参数说明:
         *
         * @return List<SUsers>  返回用户信息
         */
        @Override
        public ToJson<Users> queryUserByUserId(String userName,HttpServletRequest request) {
            return usersService.queryUserByUserId(userName,request);
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
       /* @Override
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
        }*/

        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:29:22
         * 方法介绍:   根据子菜单名称进行模糊查询
         * 参数说明:   @param funName
         * 参数说明:
         *
         * @return List<SysFunction>  返回子菜单信息
         */
       /* @Override
        public ToJson<SysFunction> getSysFunctionByName(String funName,HttpServletRequest request) {
            ToJson<SysFunction> json = new ToJson<SysFunction>(1, "error");
            if (StringUtils.checkNull(funName)) {
                json.setMsg("查询不能为空");
                return json;
            }


            try {
                //1、获取当前登录用户权限
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                Integer uid = users.getUid();
                //用户菜单权限=该用户所具有权限，不考虑角色表
                //该用户所具有权限
                String userFunctionStr = userFunctionService.getUserFunctionStrById(uid);
                String[] funcIds = userFunctionStr.split(",");
                List<SysFunction> sys = sysFunctionMapper.getSysFunctionByName(funName);
                List<SysFunction>  a11=new ArrayList<SysFunction>();
                for (int o = 0; o < sys.size(); o++) {
                    for( int k = 0; k < funcIds.length; k++) {
                        if(String.valueOf(sys.get(o).getfId()).equals(funcIds[k])){
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
        }*/

        /**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:30:12
         * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
         * 参数说明:   @param funName
         * 参数说明:
         *
         * @return List<SysFunction>  查询数
         */
     /*   @Override
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
*/



        /*
         * 将时间戳转换为时间
         */
    /*    public static String stampToDate(String s) {
            String res;
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            long lt = new Long(s);
            Date date = new Date(lt * 1000L);
            res = simpleDateFormat.format(date);
            return res;
        }
*/
        /*
         * 将时间转换为时间戳
         */
    /*    public static Long dateToStamp(String s) throws ParseException {
            String res;
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date date = simpleDateFormat.parse(s);
            long ts = date.getTime();
            return ts;
        }

        public  List touPiaoDaiBanTongJi(HttpServletRequest request,Users users) throws Exception {
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
                    AllTodoList td = new AllTodoList();
                    String userId2 = map1.get("toId").toString();
                    Users u = usersService.findUsersByuserId(map1.get("fromId") + "");
                    td.setUid(u.getUid());
                    td.setAvater(u.getAvatar());
                    td.setContent( String.valueOf(map1.get("remindUrl")));
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
                    String date1 = AllTodolistImpl.stampToDate(td.getTime());
                    String date2 = simpleDateFormat.format(dates);
                    //查询投票终止时间
                    if(td.getVoteId()!=0){
                        VoteTitle voteTitle=voteTitleMapper.voteSelectOne(td.getVoteId());
                        if(voteTitle!=null) {
                            Long t1 = AllTodolistImpl.dateToStamp(voteTitle.getEndDate());
                            Long t2 = AllTodolistImpl.dateToStamp(date2);
                            if (t1 >= t2) {
                                td.setTime(voteTitle.getSendTime());
                                td.setContent("/vote/manage/voteResult?resultId="+voteTitle.getVoteId()+"&type=1");
                                list6.add(td);
                            }
                        }
                    }
                }
            }
            return  list6;
        }
        // ID 常量
  *//*  private final static int CALENDAR_ID = 2;*//*
        private final static int VOTELTEM_ID = 11;
        private final static int EMAIL_ID = 2;
        private final static int NOTIFY_ID = 1;
        private final static int FLOWRUNPRCS_ID = 7;
        private final static int NEWS_ID = 14;
        private final static int DOCTMENT_ID = 70;
        @Override
        public BaseWrapper smsListByType(String userId, HttpServletRequest request, String type) {

            BaseWrapper baseWrapper=new BaseWrapper();
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            if(StringUtils.checkNull(userId)){
                userId=user.getUserId();
            }
            AllDaiBanModel daiBanModel=new AllDaiBanModel();
            List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("userId",userId);
            map.put("flag","1");
            List<SmsBodyExtend>  smsBodyExtendList=smsBodyMapper.SmsListByType(map);
            Iterator iter = smsBodyExtendList.iterator();
            while(iter.hasNext()){
                SmsBodyExtend smsBodyExtend = (SmsBodyExtend)iter.next();
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
                        smsBodyExtend.setImg("/img/workflow/daibanliucheng.png");
                        smsBodyExtend.setType("willdo");
                        String size4 = smsBodyExtend.getRemindUrl();
                        if (size4.contains("workformPreView")) {
                            smsBodyExtend.setHandleType("0");
                        }else {
                            smsBodyExtend.setHandleType("1");
                        }
                        String[] aStrings4 = size4.split("&");
                        for (int i = 0; i < aStrings4.length; i++) {
                            if (aStrings4[i].contains("flowId")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setFlowId(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("flowStep")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setReadflag(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("runId")) {
                                String[] s = aStrings4[i].split("=");
                                Integer runId=Integer.parseInt(s[1]);
                                FlowRun flowRun= flowRunService.find(runId);
                                Users users =  usersMapper.findUsersByuserId(flowRun.getBeginUser());
                                smsBodyExtend.setUserName(users.getUserName());
                                smsBodyExtend.setUid(users.getUid());
                                smsBodyExtend.setAvater(users.getAvatar());
                                smsBodyExtend.setRunId(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("prcsId")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setStep(Integer.parseInt(s[1]));
                                continue;
                            }

                        }
                        list2.add(smsBodyExtend);
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
                        smsBodyExtend.setImg("/img/workflow/doctment.png");
                        smsBodyExtend.setType("doctment");
                        String size5 = smsBodyExtend.getRemindUrl();
                        if (size5.contains("workformPreView")) {
                            smsBodyExtend.setHandleType("0");
                        }else {
                            smsBodyExtend.setHandleType("1");
                        }
                        String[] aStrings5 = size5.split("&");
                        for (int i = 0; i < aStrings5.length; i++) {
                            if (aStrings5[i].contains("flowId")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setFlowId(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("flowStep")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setReadflag(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("runId")) {
                                String[] s = aStrings5[i].split("=");
                                Integer runId=Integer.parseInt(s[1]);
                                FlowRun flowRun= flowRunService.find(runId);
                                Users users =  usersMapper.findUsersByuserId(flowRun.getBeginUser());
                                smsBodyExtend.setUserName(users.getUserName());
                                smsBodyExtend.setUid(users.getUid());
                                smsBodyExtend.setAvater(users.getAvatar());
                                smsBodyExtend.setRunId(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("prcsId")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setStep(Integer.parseInt(s[1]));
                                continue;
                            }
                        }
                        list4.add(smsBodyExtend);
                        break;
                    case VOTELTEM_ID:
                        smsBodyExtend.setImg("/img/workflow/publish.png");
                        smsBodyExtend.setType("toupiao");
                        String size6 = smsBodyExtend.getRemindUrl();
                        String[] aStrings6 = size6.split("\\?");
                        for (int i = 0; i < aStrings6.length; i++) {
                            if (aStrings6[i].contains("resultId")) {
                                String[] s = aStrings6[i].split("=");
                                String[] s1=s[i].split("&");
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
            daiBanModel.setNotify(list1);
            daiBanModel.setWorkFlow(list2);
            daiBanModel.setToupiao(list5);
            baseWrapper.setData(daiBanModel);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
            return baseWrapper;
        }

        @Override
        public BaseWrapper getWillDocSendOrReceive(String userId,String documentType, HttpServletRequest request) {

            BaseWrapper baseWrapper = new BaseWrapper();
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            if (StringUtils.checkNull(userId)) {
                userId = user.getUserId();
            }
            AllDaiBanModel daiBanModel = new AllDaiBanModel();
            List<SmsBodyExtend> documentList = new ArrayList<SmsBodyExtend>();

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            map.put("smsType","70");
            map.put("flag", "1");
            List<SmsBodyExtend>  smsBodyExtendList=smsBodyMapper.getWillDocSendOrReceive(map);
            Iterator iter = smsBodyExtendList.iterator();
            while(iter.hasNext()){
                SmsBodyExtend smsBodyExtend = (SmsBodyExtend)iter.next();
                smsBodyExtend.setFromUid(user.getUid());
                smsBodyExtend.setFromName(user.getUserName());
                smsBodyExtend.setImg("/img/workflow/doctment.png");
                smsBodyExtend.setType("doctment");
                String size = smsBodyExtend.getRemindUrl();
                if (size.contains("workformPreView")) {
                    smsBodyExtend.setHandleType("0");
                }else {
                    smsBodyExtend.setHandleType("1");
                }
                String[] aStrings = size.split("&");
                String type = "";
                for (int i = 0; i < aStrings.length; i++) {
                    if (aStrings[i].contains("flowId")) {
                        String[] s = aStrings[i].split("=");
                        smsBodyExtend.setFlowId(Integer.parseInt(s[1]));
                        continue;
                    } else if (aStrings[i].contains("flowStep")) {
                        String[] s = aStrings[i].split("=");
                        smsBodyExtend.setReadflag(Integer.parseInt(s[1]));
                        continue;
                    } else if (aStrings[i].contains("runId")) {
                        String[] s = aStrings[i].split("=");
                        smsBodyExtend.setRunId(Integer.parseInt(s[1]));
                        continue;
                    } else if (aStrings[i].contains("prcsId")) {
                        String[] s = aStrings[i].split("=");
                        smsBodyExtend.setStep(Integer.parseInt(s[1]));
                        continue;
                    }else if (aStrings[i].contains("tabId")) {
                        String[] s = aStrings[i].split("=");
                        DocumentModelWithBLOBs documentModelWithBLOBs = documentModelMapper.selectByPrimaryKey(Integer.parseInt(s[1]));
                        type = documentModelWithBLOBs.getDocumentType();
                        continue;
                    }
                }
                if(!"".equals(type) && documentType.equals(type)){
                    documentList.add(smsBodyExtend);
                }
            }
            baseWrapper.setData(documentList);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);
            return baseWrapper;
        }


        @Override
        public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request) {
            BaseWrapper baseWrapper=new BaseWrapper();
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            if(StringUtils.checkNull(userId)){
                userId=user.getUserId();
            }
            List<AllTodoListModel> todoListModels=new ArrayList<AllTodoListModel>();
            List<SysFunction> sysFunctions=  sysFunctionMapper.getUserFunctionByUserId(userId);
            // 获取当前语言
            String local = getNowLanguage(request);

            for(SysFunction sysFunction:sysFunctions){
                AllTodoListModel todoListModel=new AllTodoListModel();
                if("email".equals(sysFunction.getUrl())){
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
                }else if("notes/index".equals(sysFunction.getUrl())){
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
                }else if("diary/show".equals(sysFunction.getUrl())){
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
                }else if("calendar".equals(sysFunction.getUrl())){
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
                }else if("attendance/personal".equals(sysFunction.getUrl())){
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
                    AllTodoListModel todoListModel1=new AllTodoListModel();
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

            BaseWrapper baseWrapper=new BaseWrapper();
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            if(StringUtils.checkNull(userId)){
                userId=user.getUserId();
            }
            AllDaiBanModel daiBanModel=new AllDaiBanModel();
            List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list2 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list3 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list4 = new ArrayList<SmsBodyExtend>();
            List<SmsBodyExtend> list5 = new ArrayList<SmsBodyExtend>();
            Map<String,Object> map=new HashMap<String,Object>();
            map.put("userId",userId);
            List<SmsBodyExtend>  smsBodyExtendList=smsBodyMapper.SmsListByType(map);
            Iterator iter = smsBodyExtendList.iterator();
            while(iter.hasNext()){
                SmsBodyExtend smsBodyExtend = (SmsBodyExtend)iter.next();
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
                        smsBodyExtend.setImg("/img/workflow/daibanliucheng.png");
                        smsBodyExtend.setType("willdo");
                        String size4 = smsBodyExtend.getRemindUrl();
                        if (size4.contains("workformPreView")) {
                            smsBodyExtend.setHandleType("0");
                        }else {
                            smsBodyExtend.setHandleType("1");
                        }
                        String[] aStrings4 = size4.split("&");
                        for (int i = 0; i < aStrings4.length; i++) {
                            if (aStrings4[i].contains("flowId")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setFlowId(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("flowStep")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setReadflag(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("runId")) {
                                String[] s = aStrings4[i].split("=");
                                Integer runId=Integer.parseInt(s[1]);
                                FlowRun flowRun= flowRunService.find(runId);
                                Users users =  usersMapper.findUsersByuserId(flowRun.getBeginUser());
                                smsBodyExtend.setUserName(users.getUserName());
                                smsBodyExtend.setUid(users.getUid());
                                smsBodyExtend.setAvater(users.getAvatar());
                                smsBodyExtend.setRunId(Integer.parseInt(s[1]));
                                continue;
                            }else  if (aStrings4[i].contains("prcsId")) {
                                String[] s = aStrings4[i].split("=");
                                smsBodyExtend.setStep(Integer.parseInt(s[1]));
                                continue;
                            }

                        }
                        list2.add(smsBodyExtend);
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
                        smsBodyExtend.setImg("/img/workflow/doctment.png");
                        smsBodyExtend.setType("doctment");
                        String size5 = smsBodyExtend.getRemindUrl();
                        if (size5.contains("workformPreView")) {
                            smsBodyExtend.setHandleType("0");
                        }else {
                            smsBodyExtend.setHandleType("1");
                        }
                        String[] aStrings5 = size5.split("&");
                        for (int i = 0; i < aStrings5.length; i++) {
                            if (aStrings5[i].contains("flowId")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setFlowId(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("flowStep")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setReadflag(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("runId")) {
                                String[] s = aStrings5[i].split("=");
                                Integer runId=Integer.parseInt(s[1]);
                                FlowRun flowRun= flowRunService.find(runId);
                                Users users =  usersMapper.findUsersByuserId(flowRun.getBeginUser());
                                smsBodyExtend.setUserName(users.getUserName());
                                smsBodyExtend.setUid(users.getUid());
                                smsBodyExtend.setAvater(users.getAvatar());
                                smsBodyExtend.setRunId(Integer.parseInt(s[1]));
                                continue;
                            } else if (aStrings5[i].contains("prcsId")) {
                                String[] s = aStrings5[i].split("=");
                                smsBodyExtend.setStep(Integer.parseInt(s[1]));
                                continue;
                            }
                        }
                        list4.add(smsBodyExtend);
                        break;
                    case VOTELTEM_ID:
                        smsBodyExtend.setImg("/img/workflow/publish.png");
                        smsBodyExtend.setType("toupiao");
                        String size6 = smsBodyExtend.getRemindUrl();
                        String[] aStrings6 = size6.split("\\?");
                        for (int i = 0; i < aStrings6.length; i++) {
                            if (aStrings6[i].contains("resultId")) {
                                String[] s = aStrings6[i].split("=");
                                String[] s1=s[i].split("&");
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
            daiBanModel.setNotify(list1);
            daiBanModel.setWorkFlow(list2);
            daiBanModel.setToupiao(list5);
            baseWrapper.setData(daiBanModel);
            return baseWrapper;
        }

        private String getNowLanguage(HttpServletRequest request) {
            Object localObj = SessionUtils.getSessionInfo(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", Object.class);
            String local = "";
            if (localObj != null) {
                if (StringUtils.checkNull(localObj.toString())) {
                    local = "zh_CN";
                    SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", "zh_CN");
                } else {
                    local = localObj.toString();
                }
            } else {
                local = "zh_CN";
                SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", "zh_CN");
            }
            return local;
        }
*/


        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据subject进行模糊查询内部邮件信息
         * 参数说明:   @param subject
         * 参数说明:
         *
         */
        @Override
        public ToJson<EmailBodyModel> queryEmailBySubject(String trim) {
            return emailService.queryEmailBySubject(trim);
        }

        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据subject进行模糊查询公告通知信息
         * 参数说明:   @param subject
         * 参数说明:
         *
         */
        @Override
        public ToJson<Notify> queryNotifyBySubject(String trim) {
                return notifyService.queryNotifyBySubject(trim);
        }



}
