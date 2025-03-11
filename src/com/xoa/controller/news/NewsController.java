package com.xoa.controller.news;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.worldnews.NewsMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.model.worldnews.News;
import com.xoa.model.worldnews.NewsComment;
import com.xoa.service.sms.SmsService;
import com.xoa.service.worldnews.NewService;
import com.xoa.service.worldnews.NewsCommentService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope(value = "prototype")
@RequestMapping("/news")
/**
 *
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:51:46
 * 类介绍  :    新闻控制器
 * 构造参数:    无
 *
 */
public class NewsController {

    @Resource
    private NewService newService;
    @Resource
    private NewsCommentService newsCommentService;

    @Resource
    private SmsService smsService;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private NewsMapper newsMapper;

    private String err = "err";
    private String ok = "ok";

    /**
     * 新闻显示页面
     *
     * @return
     */
    @RequestMapping("/index")
    public String clickNews(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/center";
    }

    /**
     * 新闻显示页面
     *
     * @return
     */
    @RequestMapping("/findDetail")
    public String findDetail(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/find_detail";
    }

    /**
     * 创建作者: 朱振宇 创建日期: 2017-4-25 上午9:36:04 方法介绍: 新闻详情页面 参数说明: @return
     *
     * @return String
     */
    @RequestMapping("/detail")
    public String News(HttpServletRequest request, String newsId) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        String visitUrl = request.getRequestURI();
        visitUrl += "?newsId=" + newsId;
        smsService.setRead(request, visitUrl);
        return "/app/news/newsDetail";
    }

    /**
     * 创建作者: 朱振宇 创建日期: 2017-4-25 上午9:36:22 方法介绍: 新闻管理页面 参数说明: @return
     *
     * @return String
     */
    @RequestMapping("/manage")
    public String sendNews(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/newsManage";
    }

    @RequestMapping("/newsPreview")
    public String newsPreview(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/newsPreview";
    }

    @RequestMapping(value = "/newsManage", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody ToJson<News> showManage(
            @RequestParam(value = "fromId", required = false) String fromId,
            @RequestParam(value = "typeId", required = false) String typeId,
            @RequestParam(value = "subject", required = false) String subject,
            @RequestParam(value = "newsTime", required = false) String newsTime,
            @RequestParam(value = "nTime", required = false) String nTime,
            @RequestParam(value = "lastEditTime", required = false) String lastEditTime,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "read", required = false) String read,
            //关键词查询传参
            @RequestParam(value = "keyword",required = false) String keyword,
            @RequestParam("page") Integer page,
            @RequestParam("pageSize") Integer pageSize,
            @RequestParam("useFlag") Boolean useFlag,
            HttpServletRequest request, HttpServletResponse response,String queryField ) {
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if ("0".equals(typeId)) {
            typeId = null;
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String deptIdOther = users.getDeptIdOther();
        String userPrivOther = users.getUserPrivOther();
        String userId = null;
        String userPriv = null;
        String deptId = null;
        if (users != null && users.getUserId() != null) {
            userId = users.getUserId();
            userPriv = users.getUserPriv() + "";
            deptId = users.getDeptId() + "";
        }
        String provider = "";
        String name = users.getUserId();
        if (!"".equals(fromId) && fromId != null) {
            provider = fromId.substring(0, fromId.length() - 1);
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        if(!"".equals(newsTime)&&newsTime!=null){
            maps.put("newsTime", newsTime+" 00:00:00");
            if("".equals(lastEditTime)||lastEditTime==null){
                maps.put("lastEditTime", newsTime+" 23:59:59");
            }else{
                maps.put("lastEditTime", lastEditTime);
            }
        }
        maps.put("deptIdOther",deptIdOther);
        maps.put("userPrivOther",userPrivOther);
        maps.put("typeId", typeId);
        maps.put("subject", subject);
        maps.put("nTime", nTime);
        maps.put("content", content);
        maps.put("userId", userId);
        maps.put("userPriv", userPriv);
        maps.put("deptId", deptId);
        maps.put("name", name);
        maps.put("provider", provider);
        maps.put("user", users);
        maps.put("queryField", queryField);
        maps.put("keyword",keyword);

        ////判断是否是我的门户页面，标识
        String ismyOA = request.getParameter("ismyOA");
        if (!StringUtils.checkNull(ismyOA) && ismyOA.equals("true")){
            maps.put("ismyOA",ismyOA);
        }

        ToJson<News> returnReslt = new ToJson<News>(0, "");
        try {
            if ("0".equals(read)) {
                ToJson<News> tojson = newService.unreadNews(maps, page, pageSize, useFlag,
                        name, sqlType);
                if (tojson.getObj().size() > 0) {
                    tojson.setFlag(0);
                    tojson.setMsg(ok);
                    returnReslt = tojson;
                } else {
                    returnReslt = tojson;
                }
            } else if ("1".equals(read)) {
                ToJson<News> tojson1 = newService.readNews(maps, page, pageSize, useFlag,
                        name, sqlType);
                if (tojson1.getObj().size() > 0) {
                    tojson1.setFlag(0);
                    tojson1.setMsg(ok);
                    returnReslt = tojson1;
                } else {
                    returnReslt = tojson1;
                }
            } else {
                ToJson<News> tojson2 = newService.selectNewsManage(maps, page, pageSize, useFlag,
                        name, sqlType);
                if (tojson2.getObj().size() > 0) {
                    tojson2.setFlag(0);
                    tojson2.setMsg(ok);
                    returnReslt = tojson2;
                } else {
                    returnReslt = tojson2;
                }
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return returnReslt;
    }


    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:53:28 方法介绍: 新闻信息展示 参数说明: @param format
     * 参数说明: @param typeId 参数说明: @param subject 参数说明: @param newsTime 参数说明: @param
     * lastEditTime 参数说明: @param keyword 参数说明: @param page 参数说明: @param pageSize
     * 参数说明: @param useFlag 参数说明: @return
     *
     * @return String
     */
    @RequestMapping(value = "/newsShow", method = RequestMethod.GET)
    public @ResponseBody
    ToJson showNews(
            @RequestParam(value = "format", required = false) String format,
            @RequestParam(value = "typeId", required = false) String typeId,
            @RequestParam(value = "top", required = false) String top,
            @RequestParam(value = "publish", required = false) String publish,
            @RequestParam(value = "clickCount", required = false) String clickCount,
            @RequestParam(value = "click", required = false) String click,
            @RequestParam(value = "subject", required = false) String subject,
            @RequestParam(value = "newsTime", required = false) String newsTime,
            @RequestParam(value = "nTime", required = false) String nTime,
            @RequestParam(value = "lastEditTime", required = false) String lastEditTime,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam("page") Integer page,
            @RequestParam("pageSize") Integer pageSize,
            @RequestParam("useFlag") Boolean useFlag, String auditerStatus,
            HttpServletRequest request, HttpServletResponse response, String exportId, String changeId) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        if ("0".equals(typeId)) {
            typeId = null;
        }
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("format", format);
        maps.put("typeId", typeId);
        maps.put("subject", subject);
        maps.put("newsTime", newsTime);
        maps.put("nTime", nTime);
        maps.put("lastEditTime", lastEditTime);
        maps.put("content", content);
        maps.put("top", top);
        maps.put("publish", publish);
        maps.put("clickCount", clickCount);
        maps.put("click", click);
        maps.put("changeId", changeId);
        maps.put("auditerStatus",auditerStatus);
        ToJson<News> returnReslt = new ToJson(0, "");
        try {
            ToJson<News> tojson = newService.selectNews(maps, page, pageSize, useFlag, users);
            if ("1".equals(exportId)) {
                returnReslt = tojson;
                String sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();
                returnReslt.setObj1("1".equals(users.getUserPriv()) ?1 : (!StringUtils.checkNull(sysPara) && sysPara.equals("0")) ? 1 : users.getUserPriv());
            } else if ("2".equals(exportId)) {
                ServletOutputStream out = null;
                try {
                    List<News> notifyList = tojson.getObj();
                    //处理html代码
                    for (News news : notifyList){
                        news.setContent(StringUtils.Html2Text(news.getContent()));
                    }
                    HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("新闻信息导出", 9);
                    String[] secondTitles = {"发布人", "发布日期", "新闻类型", "新闻标题", "新闻内容", "评论"};
                    if (locale.equals("en_US")) {
                        workbook1 = ExcelUtil.makeExcelHead("新闻信息导出", 9);
                        secondTitles = new String[]{"Publisher", "Publication date", "News Type", "News title", "News content", "Comment"};
                    } else if (locale.equals("zh_TW")) {
                        workbook1 = ExcelUtil.makeExcelHead("新闻信息导出", 9);
                        secondTitles = new String[]{"發布人", "發布日期", "新聞類型", "新聞標題", "新聞內容", "評論"};
                    }
                    HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);

                    // String[] beanProperty = {user.getDep().getDeptName(),"userName","userPrivName", "roleAuxiliaryName","online","sex","online","telNoDept","telNoDept","departmentPhone","email"};
                    String[] beanProperty = {"providerName", "newsDateTime", "typeName", "subject", "content", "anonymityYn"};

                    HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, notifyList, beanProperty);
                     out = response.getOutputStream();

                    String filename = "新闻信息导出.xls";
                    if (locale.equals("en_US")) {
                        filename = "Export of News Information.xls";
                    } else if (locale.equals("zh_TW")) {
                        filename = "新聞資訊導出.xls";
                    }
                    filename = FileUtils.encodeDownloadFilename(filename,
                            request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("content-disposition",
                            "attachment;filename=" + filename);
                    workbook.write(out);

                } catch (IOException e) {
                    e.printStackTrace();
                }finally{
                    out.close();
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            L.e("NewsMessage:" + e);
        }

        return returnReslt;
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:54:51 方法介绍: 添加新闻 参数说明: @return
     *
     * @return String
     */
    @RequestMapping(value = "/sendNews")
    public @ResponseBody
    ToJson<News> insertNews(News news, @RequestParam("newTime") String newTime,
                            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
                            HttpServletRequest request,String remind2) {
        String tuisong=request.getParameter("tuisong"); //推送标识
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users name = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        news.setProvider(name.getUserId());
        news.setNewsTime(DateFormat.getDate(newTime));
        Date curDate = new Date(System.currentTimeMillis());//获取当前时间
        news.setLastEditTime(curDate);
        byte[] srtbyte = news.getContent().getBytes();
        news.setCompressContent(srtbyte);
        ToJson<News> newsToJson = new ToJson<News>();
        if (StringUtils.checkNull(news.getFormat())){//防止新建时新闻格式没传值  新建不成功 0-普通格式,1-MHT格式,2-超链接)
            news.setFormat("0");
        }
        if (StringUtils.checkNull(news.getFormat())) {
            newsToJson.setFlag(1);
            newsToJson.setMsg("err");
            return newsToJson;
        }
        if (StringUtils.checkNull(news.getContent())) {
            newsToJson.setFlag(1);
            newsToJson.setMsg("err");
            return newsToJson;
        }
        try {
            News news1 = newService.sendNews(news, remind, tuisong, request);
            newsToJson.setObject(news1.getNewsId());//新建时返回新建的新闻
            newsToJson.setFlag(0);
            newsToJson.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            L.e("sendNews:" + e);
        }
        return newsToJson;
    }

    private void addAffairs(News news, String remind2,HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String userName = users.getUserName();
        ContextHolder.setConsumerType("xoa" + sqlType);
        SmsBody smsBody = new SmsBody();
        smsBody.setFromId(users.getUserId());
        smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
        SysCode sysCode = new SysCode();
        if (locale.equals("zh_CN")) {
            smsBody.setContent("请审批我的新闻！主题：" + news.getSubject());
            sysCode.setCodeName("新闻");
        } else if (locale.equals("en_US")) {
            smsBody.setContent("Please approve my news！Subject：" + news.getSubject());
            sysCode.setCodeName("news");
        } else if (locale.equals("zh_TW")) {
            smsBody.setContent("請審批我的新聞！主題：" + news.getSubject());
            sysCode.setCodeName("新聞");
        }
        sysCode.setParentNo("SMS_REMIND");
        if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
            smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
        }
        String toUserId=news.getAuditer();
        smsBody.setRemindUrl("/news/doAuditing");
        String title = userName + "：请审批我的新闻";
        String context = "新闻标题:" + news.getSubject();
        if (locale.equals("en_US")) {
            title = userName + "：Please approve my news";
            context = "News title:" + news.getSubject();
        } else if (locale.equals("zh_TW")) {
            title = userName + "：請審批我的新聞";
            context = "新聞標題:" + news.getSubject();
        }
        smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:55:20 方法介绍: 修改新闻 参数说明: @return
     *
     * @return String
     */
    @RequestMapping(value = "/updateNews", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<News> updateNews(News news, HttpServletRequest request,
                            @RequestParam("newsId") Integer newsId,
                            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
                            String newTime,
                            @RequestParam(name = "lastTime", required = false) String lastTime,
                            @RequestParam(name = "editPublish", required = false,defaultValue = "0") String editPublish) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        ToJson<News> newsToJson = new ToJson<News>();
        news.setNewsId(newsId);
        String tuisong=request.getParameter("tuisong");//推送标识

        if (!StringUtils.checkNull(newTime)) {
            news.setNewsTime(DateFormat.getDate(newTime));
        }

        news.setClickCount(0);

        String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
        }catch (Exception e){

        }
        if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
            remind = "0";
            newsMapper.updateNew(news);
            String remind2 ="1";
            addAffairs(news,remind2,request);
        }


        try {
           if(editPublish.equals("0")){
               newService.updateNews(news, remind,tuisong,request);
           }else if(editPublish.equals("3")){
               newService.updateNewsReades(news, remind,tuisong,request);
           } else{
               newService.updatePublish(news, remind,tuisong,request);
           }
            newsToJson.setFlag(0);
            newsToJson.setMsg("ok");

        } catch (Exception e) {
            L.e("sendNews:" + e);

        }
        return newsToJson;
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:55:40 方法介绍: 根据ID删除新闻 参数说明: @param newsId
     * 参数说明: @return
     *
     * @return String
     */
    @RequestMapping(value = "/deleteNews", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<News> deleteNews(@RequestParam("newsId") Integer newsId,
                            HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));

        ToJson<News> toJson = new ToJson<News>(0, "");
        try {
            toJson.setMsg(ok);
            newService.deleteByPrimaryKey(newsId);
            toJson.setFlag(0);
            toJson.setMsg("ok");

        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");

        }
        return toJson;
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:56:10 方法介绍: 根据ID详情新闻 参数说明: @param newsId
     * 参数说明: @param request 参数说明: @return
     *
     * @return String
     */
    @RequestMapping(value = "/getOneById", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<News> queryNews(@RequestParam("newsId") Integer newsId, @RequestParam(name = "changId", required = false) String changId,
                           HttpServletRequest request) {
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String userId = null;
        String userPriv = null;
        String deptId = null;
        String deptIdOther = null;
        String userPrivOther = null;
        if (users != null && users.getUserId() != null) {
            userId = users.getUserId();
            userPriv = users.getUserPriv() + "";
            deptId = users.getDeptId() + "";
            deptIdOther = users.getDeptIdOther();
            userPrivOther = users.getUserPrivOther();
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("newsId", newsId);
		maps.put("userId", userId);
		maps.put("userPriv", userPriv);
		maps.put("deptId", deptId);
		maps.put("deptIdOther",deptIdOther);
		maps.put("userPrivOther",userPrivOther);
        ToJson<News> toJson = new ToJson<News>(0, "");
        Users name = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        try {
            News news = newService.queryById(maps, 1, 5, false,name.getUserId(), sqlType, changId);
            toJson.setMsg(ok);
            toJson.setObject(news);
            return toJson;
        } catch (Exception e) {
            toJson.setMsg(err);
            L.e("ERROR:" + e);
            return toJson;
        }
    }

    @RequestMapping("/deleteByIds")
    public @ResponseBody
    ToJson<News> deleteByIds(@RequestParam("newsIds[]") String[] newsIds) {

        return newService.deleteByids(newsIds);

    }

    @RequestMapping("/updateByIds")
    public @ResponseBody
    ToJson<News> updateByIds(@RequestParam("newsIds[]") String[] newsIds, String top, String publish) {
        return newService.updayeByids(newsIds, top, publish);
    }

    @RequestMapping("/querySituation")
    public @ResponseBody
    ToJson<News> querySituation(String newsId) {

        return newService.ConsultTheSituationNew(newsId);
    }

    /**
     * 创建作者: 王曰岐 创建日期: 2017-4-19 下午3:56:32 方法介绍: 为null时转换为"" 参数说明: @param value
     * 参数说明: @return
     *
     * @return String
     */
    public static String returnValue(String value) {
        if (!StringUtils.checkNull(value)) {
            return value;
        } else {
            return "";
        }
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 10:53
     * @函数介绍: 新闻评论接口
     * @参数说明: Comment
     * @return: Tojson
     */
    @RequestMapping("/AddNewsComment")
    @ResponseBody
    public ToJson<NewsComment> AddNewsComment(HttpServletRequest request, NewsComment newsComment) {
        ToJson<NewsComment> json = new ToJson<NewsComment>();
        try {
            Date date = new Date();
            newsComment.setRe_time(date);
            newsCommentService.addNewsComment(request, newsComment);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 10:53
     * @函数介绍: 新闻查询接口
     * @参数说明:
     * @return: Tojson
     */
    @RequestMapping("/getNewsCommentInfo")
    @ResponseBody
    public ToJson<NewsComment> getNewsCommentInfo(HttpServletRequest request, String news_id) {
        ToJson<NewsComment> json = new ToJson<NewsComment>();
        try {
            List<NewsComment> newsCommentInfo = newsCommentService.getNewsCommentInfo(request, news_id);
            json.setFlag(0);
            json.setMsg("ok");
            json.setObj(newsCommentInfo);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
            json.setObj(null);
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 13:53
     * @函数介绍: 新闻转发界面
     * @参数说明: request
     * @return: Tojson
     */
    @RequestMapping("/comment")
    public String NewsComment(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/comment";
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 13:53
     * @函数介绍: 新闻添加转发页面
     * @参数说明: request
     * @return: Tojson
     */
    @RequestMapping("/replyComment")
    public String replyComment(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "/app/news/replyComment";
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 13:53
     * @函数介绍: 新闻获取当前用户名
     * @return: Tojson
     */
    @RequestMapping("/getUser")
    @ResponseBody
    public ToJson<Users> getUser(HttpServletRequest request) {
        return newsCommentService.getUser(request);
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/05 20:33
     * @函数介绍: 查询某条评论的回复数
     * @参数说明：COMMENT_ID 评论id
     * @return: Tojson
     */
    @RequestMapping("/getCount")
    @ResponseBody
    public ToJson<Object> getCount(String parent_id) {
        ToJson<Object> json = new ToJson<Object>();
        try {
            int count = newsCommentService.getCount(parent_id);
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(count);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            json.setObject(0);
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 10:13
     * @函数介绍: 删除某条评论
     * @参数说明：COMMENT_ID 评论id
     * @return: Tojson
     **/
    @RequestMapping("/deleteComment")
    @ResponseBody
    public ToJson<NewsComment> deleteComment(String comment_id, HttpServletRequest request) {
        ToJson<NewsComment> json = new ToJson<NewsComment>();
        try {
            String string = newsCommentService.deleteComment(comment_id, request);
            json.setMsg(string);
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/7/06 10:13
     * @函数介绍: 查询某条新闻的评论数
     * @参数说明：news_id 新闻id
     * @return: json
     **/
    @RequestMapping("/getNewsCount")
    @ResponseBody
    public ToJson<Object> getNewsCount(String news_id) {
        ToJson<Object> json = new ToJson<Object>();
        try {
            int newsCount = newsCommentService.getNewsCount(news_id);
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(newsCount);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(0);
        }
        return json;
    }

    /**
     * 作者: 杨超
     * 函数说明: 根据类型统计新闻数量
     * 时间: 2018-08-18
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/getNewCountByType")
    public BaseWrapper getNewCountByType(HttpServletRequest request, String type) {
        return newService.getNewCountByType(request, type);
    }

    //H5微应用
    //新闻列表
    @RequestMapping("/newsh5")
    public String newsh5() {
        return "/app/news/m/newsh5";
    }
    //新闻列表
    @RequestMapping("/newsdetailh5")
    public String newsdetailh5() {
        return "/app/news/m/newsdetailh5";
    }


    @ResponseBody
    @RequestMapping("/getXzNews")
    public ToJson getXzNews(HttpServletRequest request){
        return newService.getXzNews(request);
    }
	
	 /**
     * 创建者: 张丽军
     * 创建日期：2019/02/11
     * 方法介绍: 解决升级问题
     */
    @ResponseBody
    @RequestMapping("/updateDate")
    //解决升级问题（部分数据会出现不支持HTML格式，后台统一处理一下数据格式）
    public ToJson<News> updateDate(HttpServletRequest request){
        return newService.updateDate(request);
    }

    @ResponseBody
    @RequestMapping("/openNews")
    //是否开启了新闻审批
    public ToJson<SysPara> openNews(HttpServletRequest request){
        ToJson<SysPara> json = new ToJson<SysPara>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("NEWS_AUDITING_YN").getParaValue();//防止有的产品没有NEWS_AUDITING_YN这个值
        }catch (Exception e){
            json.setMsg(I18nUtils.getMessage("new.th.noNewsApprovalEnabledOrNot"));
            json.setFlag(1);
        }
        if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
            json.setMsg(I18nUtils.getMessage("new.th.enableNewsApproval"));
            json.setFlag(0);
            json.setCode("1");
        }else{
            json.setMsg(I18nUtils.getMessage("new.th.doNotEnableNewsApproval"));
            json.setFlag(0);
            json.setCode("0");
        }
        return json;
    }

    @ResponseBody
    @RequestMapping("/selectNewsAuditers")
    public ToJson<SysPara> newsAuditers(HttpServletRequest request){
        ToJson<SysPara> json = new ToJson<SysPara>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String newsAuditers = null;
        try {
            newsAuditers = sysParaMapper.querySysPara("NEWS_AUDITERS").getParaValue();//获取新闻审批人员
            String[] split = newsAuditers.split(",");
            List<Users> ManagerId = usersMapper.getUsersByUserIds(split);
            json.setObj1(ManagerId);
        }catch (Exception e){
            json.setMsg(I18nUtils.getMessage("new.th.noNewsApprovalEnabledOrNot"));
            json.setFlag(1);
        }
            json.setMsg(I18nUtils.getMessage("new.th.enableNewsApproval"));
            json.setFlag(0);
            json.setCode("1");
        return json;
    }
    @ResponseBody
    @RequestMapping("/upNewsAuditers")
    public ToJson<SysPara> upNewsAuditers(HttpServletRequest request,String userId,String YN){
        ToJson<SysPara> json = new ToJson<SysPara>();
        SysPara sysPara = new SysPara();
        try {
            if (!StringUtils.checkNull(YN)){
                sysPara.setParaName("NEWS_AUDITING_YN");
                sysPara.setParaValue(YN);
                sysParaMapper.updateSysPara(sysPara);
            }

                sysPara.setParaName("NEWS_AUDITERS");
                sysPara.setParaValue(userId);
                sysParaMapper.updateSysPara(sysPara);

            json.setMsg("");
            json.setFlag(0);
            json.setCode("1");
        }catch (Exception e){
            json.setMsg("");
            json.setFlag(0);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping("/getNewStatus")
    public ToJson<News> getNewStatus(HttpServletRequest request,String auditerStatus, Integer page, Integer pageSize,Boolean useFlag) {//待审批新闻
        return newService.getNewStatus(request,auditerStatus,page,pageSize,useFlag);
    }

    @RequestMapping("/setAuditing")
    public String newsVerify() {
        return "/app/sys/newsVerify";
    }

    @RequestMapping("/doAuditing")
    public String newApprove() {
        return "/app/news/newApprove";
    }

    @ResponseBody
    @RequestMapping("/upNewStatus")
    public ToJson<News> upNewStatus(HttpServletRequest request, String auditerStatus, String newsId, String publish) {//待审批新闻
        return newService.upNewStatus(request,auditerStatus,newsId,publish);
    }

    /**
     *
     * @param
     * @param request
     * 只是单纯的更新新闻
     * @return
     */
    @RequestMapping("/upNews")
    @ResponseBody
    public ToJson<NewsComment> upNews(News news, HttpServletRequest request) {
        ToJson<NewsComment> json = new ToJson<NewsComment>();
        try {
            newsMapper.updateNew(news);
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    //一键已读新闻
    @RequestMapping("/readNews")
    @ResponseBody
    public ToJson readNews(HttpServletRequest request) {
        return newService.readNews(request);
    }


    //根据新闻主键更新新闻内容
    @ResponseBody
    @RequestMapping("/updateContent")
    public ToJson<News> updateContent(News news,HttpServletRequest request) {
        return newService.updateContent(news,request);
    }

    //统计所有新闻题目，作者，摄影作者，日期，字数，图片数量等数量并导出excel
    @ResponseBody
    @RequestMapping("/showAllCountByHtml")
    public ToJson<News> showAllCountByHtml(HttpServletRequest request, HttpServletResponse response) {
        return newService.showAllCountByHtml(request,response);
    }
}
