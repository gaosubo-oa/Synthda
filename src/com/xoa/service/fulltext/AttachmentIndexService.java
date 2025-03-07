package com.xoa.service.fulltext;

import com.xoa.dao.calendar.CalendarMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.diary.DiaryModelMapper;
import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.fulltext.AttachmentIndexMapper;
import com.xoa.dao.fulltext.AttachmentIndexPrivMapper;
import com.xoa.dao.im.ImMessageMapper;
import com.xoa.dao.im.ImRoomMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.worldnews.NewsMapper;
import com.xoa.model.calender.Calendar;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.diary.DiaryModel;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.fulltext.AttachmentIndexPriv;
import com.xoa.model.fulltext.AttachmentIndexSwitch;
import com.xoa.model.im.ImMessage;
import com.xoa.model.im.ImRoom;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.Users;
import com.xoa.model.worldnews.News;
import com.xoa.service.department.DepartmentService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.HtmlUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.jieba.jieba;
import com.xoa.util.page.PageParams;
import net.sf.json.JSONObject;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class AttachmentIndexService {

    @Resource
    private AttachmentIndexPrivMapper attachmentIndexPrivMapper;
    @Resource
    private AttachmentIndexMapper attachmentIndexMapper;
    @Resource
    private EmailBodyMapper emailBodyMapper;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private ImRoomMapper roomDao;

    @Resource
    private DiaryModelMapper diaryModelMapper;

    @Resource
    private NotifyMapper notifyMapper;
    @Resource
    private NewsMapper newsMapper;
    @Resource
    private ImMessageMapper imMessageMapper;
    @Resource
    private CalendarMapper calendarMapper;

    @Resource
    private UsersMapper usersMapper;
    @Resource
    private DepartmentService departmentService;

    private static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public void fileContent() {
        List<SysPara> sysParas = sysParaMapper.selectAttach();
        AttachmentIndexSwitch attachmentIndexSwitch = new AttachmentIndexSwitch();
        if (sysParas.size() > 0) {
            for (SysPara sysPara : sysParas) {
                String paraName = sysPara.getParaName();
                if (paraName.equals("ALLDOC_INDEX_YN")) {
                    attachmentIndexSwitch.setAlldocIndexYn(sysPara.getParaValue());
                }
                if (paraName.equals("ALLDOC_INDEX_DOTIME")) {
                    String paraValue = sysPara.getParaValue();
                    attachmentIndexSwitch.setAlldocIndexDotime(paraValue);
                    JSONObject jsonObject = JSONObject.fromObject(paraValue);
                }
                if (paraName.equals("ALLDOC_INDEX_FILENUM")) {
                    attachmentIndexSwitch.setAlldocIndexFileNum(sysPara.getParaValue());
                }
                if (paraName.equals("ALLDOC_INDEX_FILETYPE")) {
                    String paraValue = sysPara.getParaValue();
                    attachmentIndexSwitch.setAlldocIndexFileType(paraValue);
                    JSONObject jsonObject = JSONObject.fromObject(paraValue);
                    String word_index = (String) jsonObject.get("WORD_INDEX");
                    String excle_index = (String) jsonObject.get("EXCLE_INDEX");
                    String ppt_index = (String) jsonObject.get("PPT_INDEX");
                    String pdf_index = (String) jsonObject.get("PDF_INDEX");
                    String html_index = (String) jsonObject.get("HTML_INDEX");
                    String txt_index = (String) jsonObject.get("TXT_INDEX");
                    attachmentIndexSwitch.setWordIndex(word_index);
                    attachmentIndexSwitch.setExcleIndex(excle_index);
                    attachmentIndexSwitch.setPptIndex(ppt_index);
                    attachmentIndexSwitch.setPdfIndex(pdf_index);
                    attachmentIndexSwitch.setHtmlIndex(html_index);
                    attachmentIndexSwitch.setTxtIndex(txt_index);
                }
            }
        }

        if (attachmentIndexSwitch != null) {


        }
    }


    public ToJson selectModule(HttpServletRequest request) {
        ToJson json = new ToJson();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            List<AttachmentIndexPriv> modules = attachmentIndexPrivMapper.selectManagerName(users.getUserId());
            json.setObj(modules);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    //邮件查询接口
    public ToJson selectBySubject(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        map.put("moduleId", 1);
        PageParams pageParams = new PageParams();
        try {

            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            List<Attachment> attachmentIndices = null;
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", strings);
            }
            if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
                map.put("fromId", users.getUserId());
                List<String> attachIds = emailBodyMapper.queryFile(map);
                List<String> aIds = getAIds(attachIds);
                if (aIds != null && aIds.size() > 0) {
                    map.put("aIds", aIds);
                    attachmentIndices = attachmentIndexMapper.selectByStr(map);
                }

            } else {
                attachmentIndices = attachmentIndexMapper.selectByStr(map);
            }

            List<String> collect = new ArrayList<>();
            if (attachmentIndices != null) {
                collect = attachmentIndices.stream().map(Attachment -> Attachment.getAid() + "@" + Attachment.getYm() + "_" + Attachment.getAttachId()).collect(Collectors.toList());
            }
            if (collect != null && collect.size() > 0) {
                map.put("attachIds", collect);
            }
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<EmailBodyModel> querys = emailBodyMapper.querys(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (EmailBodyModel query : querys) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", query.getSubject());
                mod.put("content", Html2Text(query.getContent()));
                mod.put("img", "/img/menu/Email.png");
                mod.put("url", "/email/details?id=" + query.getEmailList().get(0).getEmailId());
                Integer sendTime = query.getSendTime();
                long lcc_time = Long.valueOf(sendTime);
                String s = DateFormat.getDateStrTime(sendTime);
                String format = dateFormat.format(new Date(lcc_time * 1000L));
                mod.put("createTime", "时间: " + format);
                List<Attachment> existences = isExistence(query.getAttachmentId(), attachmentIndices, "email", loginDateSouse, subject);
                if (existences != null && existences.size() > 0) {
                    mod.put("attach", existences);
                }
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setObject(strings);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }
        return json;
    }


    //工作日志
    public ToJson selectDiary(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        map.put("moduleId", 6);
        PageParams pageParams = new PageParams();

        try {
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }
            List<Attachment> attachmentIndices = null;
            if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
                map.put("userId", users.getUserId());
                List<String> attachIds = diaryModelMapper.queryFile(map);
                List<String> aIds = getAIds(attachIds);

                if (aIds != null && aIds.size() > 0) {
                    map.put("aIds", aIds);
                    attachmentIndices = attachmentIndexMapper.selectByStr(map);
                }
            } else {
                attachmentIndices = attachmentIndexMapper.selectByStr(map);
            }
            List<String> collect = new ArrayList<>();
            if (attachmentIndices != null) {
                collect = attachmentIndices.stream().map(Attachment -> Attachment.getAid() + "@" + Attachment.getYm() + "_" + Attachment.getAttachId()).collect(Collectors.toList());
            }
            if (collect != null && collect.size() > 0) {
                map.put("attachIds", collect);
            }
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<DiaryModel> diaryModels = diaryModelMapper.querySubject(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (DiaryModel diaryModel : diaryModels) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", diaryModel.getSubject());
                mod.put("content", diaryModel.getContent());
                mod.put("img", "/img/menu/WorkLog.png");
//                mod.put("profile", content(diaryModel.getContent()));
                mod.put("url", "/diary/logCheck?diaId=" + diaryModel.getDiaId());
                String temp = "";
                if (!StringUtils.checkNull(diaryModel.getDiaTime())) {
                    temp = diaryModel.getDiaTime().substring(0, 19);
                }
                mod.put("createTime", "时间: " + temp);
                List<Attachment> existences = isExistence(diaryModel.getAttachmentId(), attachmentIndices, "diary", loginDateSouse, subject);
                if (existences != null && existences.size() > 0) {
                    mod.put("attach", existences);
                }
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }

    //日程
    public ToJson selectCalendar(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        PageParams pageParams = new PageParams();
        if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
            map.put("userId", users.getUserId());
        }
        try {
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }

            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<Calendar> calendars = calendarMapper.selectBySubject(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (Calendar calendar : calendars) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", "日程");
                mod.put("content", calendar.getContent());
                mod.put("img", "/img/menu/Schedule.png");
//                mod.put("profile", content(calendar.getContent()));
                mod.put("url", "");
                String s = DateFormat.getStrDate(calendar.getAddTime());
                mod.put("createTime", "时间: " + s);
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (IOException e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }


    //公告通知
    public ToJson selectNotice(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        map.put("moduleId", 4);
        PageParams pageParams = new PageParams();

        try {
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }
            List<Attachment> attachmentIndices = null;
            if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
                map.put("userId", users.getUserId());
                map.put("privId", users.getUserPriv());
                map.put("deptId", users.getDeptId());
                List<String> attachIds = notifyMapper.queryFile(map);
                List<String> aIds = getAIds(attachIds);

                if (aIds != null && aIds.size() > 0) {
                    map.put("aIds", aIds);
                    attachmentIndices = attachmentIndexMapper.selectByStr(map);
                }
            } else {
                attachmentIndices = attachmentIndexMapper.selectByStr(map);
            }
            List<String> collect = new ArrayList<>();
            if (attachmentIndices != null) {
                collect = attachmentIndices.stream().map(Attachment -> Attachment.getAid() + "@" + Attachment.getYm() + "_" + Attachment.getAttachId()).collect(Collectors.toList());
            }
            if (collect != null && collect.size() > 0) {
                map.put("attachIds", collect);
            }
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<Notify> notifies = notifyMapper.querySubject(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (Notify notifie : notifies) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", notifie.getSubject());
                mod.put("content", Html2Text(notifie.getContent()));
                mod.put("img", "/img/menu/Notice.png");
//                mod.put("profile", content(notifie.getContent()));
                mod.put("url", "/notice/detail?notifyId=" + notifie.getNotifyId());
                Date sendTime = notifie.getSendTime();
                String format = dateFormat.format(sendTime);
                mod.put("createTime", "时间: " + format);
                List<Attachment> existences = isExistence(notifie.getAttachmentId(), attachmentIndices, "notify", loginDateSouse, subject);
                if (existences != null && existences.size() > 0) {
                    mod.put("attach", existences);
                }
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }

    //新闻
    public ToJson selectNews(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        map.put("moduleId", 5);
        PageParams pageParams = new PageParams();

        try {
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }
            List<Attachment> attachmentIndices = null;
            if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
                map.put("userId", users.getUserId());
                map.put("privId", users.getUserPriv());
                map.put("deptId", users.getDeptId());
                List<String> attachIds = newsMapper.queryFile(map);
                List<String> aIds = getAIds(attachIds);
                if (aIds != null && aIds.size() > 0) {
                    map.put("aIds", aIds);
                    attachmentIndices = attachmentIndexMapper.selectByStr(map);
                }
            } else {
                attachmentIndices = attachmentIndexMapper.selectByStr(map);
            }

            List<String> collect = new ArrayList<>();
            if (attachmentIndices != null) {
                collect = attachmentIndices.stream().map(Attachment -> Attachment.getAid() + "@" + Attachment.getYm() + "_" + Attachment.getAttachId()).collect(Collectors.toList());
            }
            if (collect != null && collect.size() > 0) {
                map.put("attachIds", collect);
            }
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<News> news = newsMapper.querySubject(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (News new1 : news) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", new1.getSubject());
                mod.put("content", Html2Text(new1.getContent()));
//                mod.put("profile", content(new1.getContent()));
                mod.put("img", "/img/menu/News.png");
                mod.put("url", "/news/detail?newsId=" + new1.getNewsId());
                Date sendTime = new1.getNewsTime();
                String s = DateFormat.getStrDate(sendTime);
                mod.put("createTime", "时间: " + s);
                List<Attachment> existences = isExistence(new1.getAttachmentId(), attachmentIndices, "news", loginDateSouse, subject);
                if (existences != null && existences.size() > 0) {
                    mod.put("attach", existences);
                }
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }


    //人事档案
    public ToJson selectHr(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        return json;
    }

    //即时通讯
    public ToJson selectIm(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        map.put("subject", subject);
        map.put("moduleId", 26);
        map.put("req", request);
        PageParams pageParams = new PageParams();

        try {
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }
            List<Attachment> attachmentIndices = null;
            if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
                map.put("userId", users.getUid());
                map.put("privId", users.getUserPriv());
                map.put("deptId", users.getDeptId());
                List<String> aIds = imMessageMapper.queryFile(map);
                if (aIds != null && aIds.size() > 0) {
                    map.put("aIds", aIds);
                    attachmentIndices = attachmentIndexMapper.selectByStr(map);
                }
            } else {
                attachmentIndices = attachmentIndexMapper.selectByStr(map);
            }

            List<String> collect = new ArrayList<>();
            if (attachmentIndices != null) {
                collect = attachmentIndices.stream().map(Attachment -> Attachment.getAid() + "@" + Attachment.getYm() + "_" + Attachment.getAttachId()).collect(Collectors.toList());
            }
            if (collect != null && collect.size() > 0) {
                map.put("attachIds", collect);
            }
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<ImMessage> imMessages = imMessageMapper.querySubject(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (ImMessage imMessage : imMessages) {
                Map<String, Object> mod = new HashMap<>();
                if (imMessage.getMsgType().equals("1")) {
                    Map<String, Object> paramMap = new HashMap<>();
                    paramMap.put("uid", users.getUid());
                    paramMap.put("roomOf", imMessage.getToUid());
                    ImRoom room = roomDao.selRoomByRoomOfUid(paramMap);
                    if (room != null) {
                        mod.put("subject", room.getRnamr());
                    } else {
                        mod.put("subject", "该用户不存在！");
                    }
                } else {
                    Users toUser = usersMapper.getUserByUid(Integer.valueOf(imMessage.getToUid()));
                    if (toUser != null) {
                        mod.put("subject", toUser.getUserName());
                    } else {
                        mod.put("subject", "该用户不存在！");
                    }
                }


                mod.put("content", imMessage.getContent());
//                mod.put("profile", imMessage.getContent());
                mod.put("img", "/img/menu/addressbook.png");
                String stime = "1";
                if (!StringUtils.checkNull(imMessage.getStime())) {
                    stime = imMessage.getStime().substring(0, 10);
                }
                Integer sendTime = Integer.valueOf(stime);
                long lcc_time = Long.valueOf(sendTime);
                String s = DateFormat.getDateStrTime(sendTime);
                String format = dateFormat.format(new Date(lcc_time * 1000L));
                mod.put("createTime", "时间: " + format);
                mod.put("url", "");
                List<Attachment> existences = isExistence(imMessage.getFileId(), attachmentIndices, "news", loginDateSouse, subject);
                if (existences != null && existences.size() > 0) {
                    mod.put("attach", existences);
                }
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }

    //人员
    public ToJson selectUser(HttpServletRequest request, String subject, String flag, Integer page, Integer pageSize, boolean useFlag) {
        ToJson json = new ToJson();
        if (StringUtils.checkNull(subject)) {
            json.setFlag(1);
            json.setMsg("请输入");
            return json;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String loginDateSouse = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);
        Map<String, Object> map = new HashMap<>();
        PageParams pageParams = new PageParams();
        if (StringUtils.checkNull(flag) || !flag.equals("ALL")) {
            map.put("userId", users.getUserId());
        }
        if ((users.getUserPriv() != null && !users.getUserPriv().equals(1)) || (users.getUserPrivOther() != null && Arrays.asList(users.getUserPrivOther().split(",")).contains("1"))) {
            List<Department> dept = departmentService.getUseDepartmentByUser(users);
            List<Integer> collect = dept.stream().map(Department::getDeptId).collect(Collectors.toList());
            if (collect != null) {
                map.put("deptIds", collect);
            }
        }
        try {
            StringBuffer newStr = new StringBuffer();
            char[] stringArr = subject.toCharArray();
            for (char s : stringArr) {
                newStr.append(s + "_");
            }
            map.put("userName", subject);
            map.put("newStr", newStr.toString());
            Set<String> strings = new HashSet<>();
            strings.add(subject);
            jieba jieba = new jieba();
            Map<String, Integer> getStr = jieba.getStr(subject);
            if (getStr != null && getStr.size() > 0) {
                strings.addAll(getStr.keySet());
                map.put("strs", getStr.keySet());
            }

            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            List<Users> users1 = usersMapper.queryUserByUserIds(map);
            List<Map<String, Object>> list = new ArrayList<>();
            for (Users user : users1) {
                Map<String, Object> mod = new HashMap<>();
                mod.put("subject", user.getUserName());
                mod.put("content", "角色:" + user.getUserPrivName() + "<br/>部门:" + user.getDeptName());
                mod.put("img", "/img/main_img/nantouxiang.png");
//                mod.put("profile", "角色:" + user.getUserPrivName() + "<br/>部门:" + user.getDeptName());
                mod.put("url", "/sys/userDetails?uid=" + user.getUid());
                mod.put("createTime", "性别:" + user.getSexName());
                list.add(mod);
            }
            json.setTotleNum(pageParams.getTotal());
            json.setObj(list);
            json.setFlag(0);
            json.setObject(strings);
            json.setMsg("ok");
        } catch (IOException e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
        }

        return json;
    }

    // 去掉 html 标签
    private String Html2Text(String inputString) {


        String htmlStr = inputString.replaceAll("<div", "&nbsp; <div"); //含html标签的字符串
        String textStr = "";
        Pattern p_script;
        Matcher m_script;
        Pattern p_style;
        Matcher m_style;
        Pattern p_html;
        Matcher m_html;
        try {
            String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>"; //定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script> }
            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; //定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style> }
            String regEx_html = "<[^>]+>"; //定义HTML标签的正则表达式
            p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
            m_script = p_script.matcher(htmlStr);
            htmlStr = m_script.replaceAll(""); //过滤script标签
            p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
            m_style = p_style.matcher(htmlStr);
            htmlStr = m_style.replaceAll(""); //过滤style标签
            p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
            m_html = p_html.matcher(htmlStr);
            htmlStr = m_html.replaceAll(""); //过滤html标签
            textStr = htmlStr;
        } catch (Exception e) {
            return null;
        }
        return textStr;//返回文本字符串
    }

    private String content(String str) {
        if (StringUtils.checkNull(str)) {
            return "";
        }
        str = Html2Text(str);
        StringBuffer sb = new StringBuffer();
        try {
            if (str.length() > 200) {
                sb.append(str, 0, 200);
            } else
                return str;
        } catch (Exception e) {
            return "拆分文字报错";
        }
        return sb.toString();
    }


    //获取附件
    private List<Attachment> isExistence(String str, List<Attachment> attachments, String module, String sqlType, String subject) throws Exception {
        List<Attachment> list = new ArrayList<>();
        if (str == null || attachments == null || attachments.size() == 0) {
            return list;
        }
        String[] split = str.split(",");
        for (String s : split) {
            if (!StringUtils.checkNull(s)) {
                String aId = s.split("@")[0];
                Optional<Attachment> first = attachments.stream().filter(A -> A.getAid().toString().equals(aId)).findFirst();
                if (first.isPresent()) {
                    Attachment attachment = first.get();
                    if (attachment != null) {
                        attachment.setAttUrl("AID=" + attachment.getAid() + "&MODULE=" + module + "&COMPANY=" + sqlType + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId() + "&ATTACHMENT_NAME=" + attachment.getAttachName());
                        StringBuffer id = new StringBuffer();
                        StringBuffer name = new StringBuffer();
                        if (attachment.getAttachName().indexOf(subject) != -1) {
                            attachment.setAttachName(attachment.getAttachName() + "(文件名包含 " + subject + ")");
                        } else {
                            attachment.setAttachName(attachment.getAttachName() + "(内容包含 " + subject + ")");
                        }
                        int aid = attachment.getAid();
                        String attachId = attachment.getAttachId();
                        String ym = attachment.getYm();
                        String attachName = attachment.getAttachName();
                        String all = aid + "@" + ym + "_" + attachId;
                        id.append(all).append(",");
                        name.append(attachName).append("*");
                        attachment.setId(id.toString());
                        attachment.setName(name.toString());
                        list.add(attachment);
                    }
                }
            }

        }
        return list;
    }

    //获取附件AID集合
    private List<String> getAIds(List<String> attachIds) {
        List<String> aIds = new ArrayList<>();
        for (String attachId : attachIds) {
            if (!StringUtils.checkNull(attachId)) {
                String[] split = attachId.split(",");
                for (String s : split) {
                    if (!StringUtils.checkNull(s)) {
                        aIds.add(s.split("@")[0]);
                    }
                }
            }
        }
        return aIds;
    }



    //获取流程表单附件
    private List<String> getContainList(List<String> list1, List<String> list2) {
        List<String> contain = new ArrayList<>();
        if (list1==null||list1.size()==0){
            return contain;
        }
        List<String> stringList = new ArrayList<>();
        for (String str : list2) {
            if (!StringUtils.checkNull(str)&&str.contains("AID")&&str.contains("&MODULE")) {
                String[] split = str.split(",");
                for (String s : split) {
                    String s1 = s.split("&MODULE")[0];
                    String s2 = s1.split("=")[1];
                    stringList.add(s2);
                }
            }
        }
        List<String> aIds = getAIds(list1);

        Map<String, Integer> m = new HashMap<>(aIds.size() + stringList.size());

        List<String> max = aIds;
        List<String> min = stringList;
        if (stringList.size() > aIds.size()) {
            max = stringList;
            min = aIds;
        }
        for (String s : max) {
            m.put(s, 1);
        }
        for (String s : min) {
            Integer i = m.get(s);
            if (i != null) {
                m.put(s, ++i);
                continue;
            }
        }
        for (Map.Entry<String, Integer> entry : m.entrySet()) {
            if (entry.getValue() != 1) {
                contain.add(entry.getKey());
            }
        }
        return contain;
    }

}