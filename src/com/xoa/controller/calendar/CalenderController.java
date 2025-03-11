package com.xoa.controller.calendar;

import com.xoa.dao.affair.AffairMapper;
import com.xoa.dao.calendar.CalendarMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.securityApproval.SecurityContentApprovalMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.affair.AffairWithBLOBs;
import com.xoa.model.calender.Calendar;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.diary.DiaryModel;
import com.xoa.model.securityApproval.SecurityContentApproval;
import com.xoa.model.users.Users;
import com.xoa.service.calendar.CalendarService;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class CalenderController {

    @Autowired
    private CalendarService calendarService;

    @Autowired
    SmsService smsService;

    @Autowired
    SysParaService sysParaService;

    @Resource
    AffairMapper affairMapper;

    @Resource
   private UsersMapper usersMapper;

    @Resource
    UsersService usersService;

    @Resource
    private SysLogService sysLogService;

    @Resource
    private SecurityContentApprovalService securityContentApprovalService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SecurityContentApprovalMapper securityContentApprovalMapper;
    @Resource
    private CalendarMapper calendarMapper;

    public final String Zero = "0";
    public final String Ones = "1";
    public final String Two = "2";
    public final String Three = "3";
    public final String Four = "4";
    public final String Five = "5";
    public final String Six = "6";

    //日程安排-普陀教育
    @RequestMapping("/schedule/eduIndex")
    public String eduIndex() {
        return "app/calendar/eduIndex";
    }

    //日程安排映射
    @RequestMapping("/schedule/index")
    public String index(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //简洁版消除事务提醒，根据bodyID,事务提醒消除以后要批量都修改成这样的
        String bodyId = request.getParameter("bodyId");
        if (!StringUtils.checkNull(bodyId)) {
            smsService.setSmsReadByBodyId(request, Integer.valueOf(bodyId));
        }
        return "app/calendar/index";
    }

    //领导日程
    @RequestMapping("/schedule/leadership")
    public String leadership() {
        return "app/calendar/leadership";
    }

    @RequestMapping("/schedule/query")
    public String ScheduleInquiry(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/calendar/query";
    }

    @RequestMapping("/schedule/info")
    public String info(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/calendar/info";
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:28:10
     * 方法介绍:   根据日程安排的起始和结束时间查询日程
     * 参数说明:   @param request 请求
     * 参数说明:   @param calTime 起始时间
     * 参数说明:   @param endime 结束时间
     * 参数说明:   @return
     *
     * @return ToJson<Calendar>  返回日程安排
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getschedule", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getschedule(HttpServletRequest request, String calTime, String endTime,
                                        @RequestParam(value = "userId", required = false) String userId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            if (StringUtils.checkNull(userId)) {
                userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie).getUserId();
            }
            List<Calendar> list = calendarService.getschedule(Integer.parseInt(calTime), Integer.parseInt(endTime), userId);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:02:21
     * 方法介绍:   根据userId 查询日程安排
     * 参数说明:   @param request 请求
     * 参数说明:   @param userId 用户Id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getscheduleBycId", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getscheduleBycId(HttpServletRequest request, String userId,
                                             @RequestParam(value = "time", required = false) String calTime) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            List<Calendar> list = new ArrayList<Calendar>();
            if (!StringUtils.checkNull(calTime)) {
                list = calendarService.getscheduleBycId(userId, calTime);
            } else {
                list = calendarService.getscheduleBycId(userId);
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:02:21
     * 方法介绍:   根据userId 查询日程安排
     * 参数说明:   @param request 请求
     * 参数说明:   @param userId 用户Id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getAllschedule", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getAllschedule(HttpServletRequest request, String userId) {
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            List<Calendar> list = calendarService.getAllschedule(userId);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setMsg("fasle");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年7月5日 下午5:02:21
     * 方法介绍:   根据deptId查询日程安排
     * 参数说明:   @param request 请求
     * 参数说明:   @param deptId 部门Id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getAllscheduleinfo", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getAllscheduleinfo(HttpServletRequest request, Integer deptId) {
        ToJson<Calendar> json = new ToJson<Calendar>(1, "error");
        try {
            List<Calendar> list = calendarService.getAllscheduleinfo(deptId);
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月12日 上午10:47:22
     * 方法介绍:   获取当天的日程安排
     * 参数说明:   @param request 请求
     * 参数说明:   @param userId 用户id
     * 参数说明:   @param time 当天时间
     * 参数说明:   @return
     *
     * @return ToJson<Calendar>
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getscheduleByDay", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getscheduleByDay(HttpServletRequest request, String userId, String time) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            List<Calendar> list = calendarService.getscheduleByDay(userId, time);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午6:10:50
     * 方法介绍:   添加日程
     * 参数说明:   @param request 请求
     * 参数说明:   @param calType 事务类型
     * 参数说明:   @param content 事物内容
     * 参数说明:   @param calTime 开始时间
     * 参数说明:   @param endTime 结束时间
     * 参数说明:   @param userId 用户id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回日程信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/addCalender", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> addCalender(HttpServletRequest request,
                                        @RequestParam("calType") String calType,
                                        @RequestParam("content") String content,
                                        @RequestParam("calTime") String calTime,
                                        @RequestParam("endTime") String endTime,
                                        @RequestParam("userId") String userId,
                                        @RequestParam("calLevel") String calLevel,
                                        @RequestParam(value = "owner", required = false, defaultValue = "") String owner,
                                        @RequestParam(value = "taker", required = false, defaultValue = "") String taker,
                                        @RequestParam(value = "beforeDay", required = false, defaultValue = "0") String beforeDay,
                                        @RequestParam(value = "beforeHour", required = false, defaultValue = "0") String beforeHour,
                                        @RequestParam(value = "beforeMin", required = false, defaultValue = "0") String beforeMin,
                                        @RequestParam(value = "contentSecrecy", required = false, defaultValue = "") String contentSecrecy) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            Calendar c = new Calendar();
            c.setUserId(userId);
            Users usernameByUserId = usersService.getUsersByuserId(userId);
            if (usernameByUserId !=null ){
                c.setUserName(usernameByUserId.getUserName());
            }
            c.setEndTime(Integer.parseInt(endTime));
            c.setCalTime(Integer.parseInt(calTime));
            c.setContent(content);
            c.setCalType(calType);
            c.setCalLevel(calLevel);
            c.setManagerId("");
            c.setOverStatus("");
            c.setBeforeRemaind(beforeDay + "|" + beforeHour + "|" + beforeMin);
            c.setAddTime(new Date());
            c.setOwner(owner);
            c.setTaker(taker);
            c.setAllday(0);
            c.setFromModule(0);
            c.setUrl("");
            c.setmId(1);
            c.setResId(1);
            c.setContentSecrecy(contentSecrecy);
            calendarService.insertSelective(c, request);
            json.setObject(c);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月5日 下午6:21:28
     * 方法介绍:   根据主键删除
     * 参数说明:   @param request 请求
     * 参数说明:   @param calId 主键
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/delete", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> delete(HttpServletRequest request, String calId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);

        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {

            if(!"1".equals(request.getAttribute("approvalStatus"))) {
                //判断是否开启数据模块标密，增加删除审批
                SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
                if(!Objects.isNull(isShowSecret) && "1".equals(isShowSecret.getParaValue())){
                    Calendar calendar = calendarMapper.selCalendarById(Integer.valueOf(calId));
                    if(!Objects.isNull(calendar)) {
                        securityContentApprovalService.insert("calendar", calendar.getCalId().toString(), I18nUtils.getMessage("main.schedule"), calendar.getContent(), "", "2"
                                , securityContentApprovalService.selectContentSecrecyByModuleTable("calendar", calendar.getCalId().toString()).getContentSecrecy(), request);
                        json.setCode("100066");
                        json.setMsg(I18nUtils.getMessage("notice.th.noticeDeleteByIdsPrompt"));
                        return json;
                    }
                }
            }

            calendarService.delete(Integer.parseInt(calId), request);

            //添加日志
            Syslog syslog = new Syslog();
            syslog.setUserId(user.getUserId());
            syslog.setType(56); //sys_code
            syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+"," + I18nUtils.getMessage("global.lang.delete"));
            sysLogService.saveLog(syslog,request);

            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月8日 下午4:17:59
     * 方法介绍:   编辑日程
     * 参数说明:   @param request 请求
     * 参数说明:   @param calType 类型
     * 参数说明:   @param content 内容
     * 参数说明:   @param calTime 开始时间
     * 参数说明:   @param endTime 结束时间
     * 参数说明:   @param userId 用户id
     * 参数说明:   @param calLevel 优先级
     * 参数说明:   @param calId 主键
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 日程信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/editCalender", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> editCalender(HttpServletRequest request,
                                         @RequestParam("calType") String calType,
                                         @RequestParam("content") String content,
                                         @RequestParam("calTime") String calTime,
                                         @RequestParam("endTime") String endTime,
                                         @RequestParam("userId") String userId,
                                         @RequestParam("calLevel") String calLevel,
                                         @RequestParam("calId") String calId,
                                         @RequestParam(value = "owner", required = false) String owner,
                                         @RequestParam(value = "taker", required = false) String taker,
                                         @RequestParam(value = "beforeDay", required = false, defaultValue = "0") String beforeDay,
                                         @RequestParam(value = "beforeHour", required = false, defaultValue = "0") String beforeHour,
                                         @RequestParam(value = "beforeMin", required = false, defaultValue = "0") String beforeMin,
                                         @RequestParam(value = "contentSecrecy", required = false, defaultValue = "") String contentSecrecy
    ) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            Calendar c = new Calendar();
            c.setUserId(userId);
            Users usernameByUserId = usersService.getUsersByuserId(userId);
            if (usernameByUserId !=null ){
                c.setUserName(usernameByUserId.getUserName());
            }
            c.setEndTime(Integer.parseInt(endTime));
            c.setCalTime(Integer.parseInt(calTime));
            c.setContent(content);
            c.setCalType(calType);
            c.setCalLevel(calLevel);
            c.setCalId(Integer.parseInt(calId));
            c.setOwner(owner);
            c.setTaker(taker);
            c.setContentSecrecy(contentSecrecy);
            c.setBeforeRemaind(beforeDay + "|" + beforeHour + "|" + beforeMin);
            int count = calendarService.update(c);
            SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                // 修改内容安全审核数据
                SecurityContentApproval securityContentApproval = securityContentApprovalMapper.selectByModuleTableAndRecordId("calendar", calId);
                securityContentApproval.setDataSubject(c.getContent());// 数据标题
                securityContentApproval.setOperationUserId(user.getUserId());// 操作人USER_ID
                securityContentApproval.setOperationTime(new Date());// 操作时间
                securityContentApproval.setOperationType("1");// 操作类型:0新建，1编辑，2删除
                securityContentApproval.setContentSecrecy(contentSecrecy);// 密级：系统代码
                securityContentApprovalService.update(request, securityContentApproval);
            }

            //添加日志
            Syslog syslog = new Syslog();
            syslog.setUserId(user.getUserId());
            syslog.setType(56); //sys_code
            syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+"," + I18nUtils.getMessage("depatement.th.modify"));
            sysLogService.saveLog(syslog,request);

            if (count > 0) {
                json.setObject(c);
                json.setMsg("OK");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午6:10:50
     * 方法介绍:   添加日程
     * 参数说明:   @param request 请求
     * 参数说明:   @param calType 事务类型
     * 参数说明:   @param content 事物内容
     * 参数说明:   @param calTime 开始时间
     * 参数说明:   @param endTime 结束时间
     * 参数说明:   @param userId 用户id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回日程信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/addMCalender", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> addMCalender(HttpServletRequest request,
                                         @RequestParam("calType") String calType,
                                         @RequestParam("content") String content,
                                         @RequestParam("calTime") String calTime,
                                         @RequestParam("endTime") String endTime,
                                         @RequestParam("userId") String userId,
                                         @RequestParam("calLevel") String calLevel
    ) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(1, "err");
        List<Calendar> list = new ArrayList<Calendar>();
        try {
            String[] calTypes = calType.split("\\*");
            String[] contents = content.split("\\*");
            String[] calTimes = calTime.split("\\*");
            String[] endTimes = endTime.split("\\*");
            String[] userIds = userId.split("\\*");
            String[] calLevels = calLevel.split("\\*");
            for (int i = 0; i < calTypes.length; i++) {
                Calendar c = new Calendar();
                c.setUserId(userIds[i]);
                Users usernameByUserId = usersService.getUsersByuserId(userIds[i]);
                if (usernameByUserId !=null ){
                    c.setUserName(usernameByUserId.getUserName());
                }
                c.setEndTime(Integer.parseInt(endTimes[i]));
                c.setCalTime(Integer.parseInt(calTimes[i]));
                c.setContent(contents[i]);
                c.setCalType(calTypes[i]);
                c.setCalLevel(calLevels[i]);
                c.setManagerId("");
                c.setOverStatus("");
                c.setBeforeRemaind("");
                c.setAddTime(new Date());
                c.setOwner("");
                c.setTaker("");
                c.setAllday(0);
                c.setFromModule(0);
                c.setUrl("");
                c.setmId(1);
                c.setResId(1);
                calendarService.insertSelective(c, request);
                list.add(c);
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月19日 下午15:19:21
     * 方法介绍:   根据userId 查询日程安排，包含参与者和所属者
     * 参数说明:   @param request 请求
     * 参数说明:   @param userId 用户Id
     * 参数说明:   @return
     *
     * @return ToJson<Calendar> 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getscheduleByTakerAndOwner", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getscheduleByTakerAndOwner(HttpServletRequest request, Calendar calen) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<Calendar> json = new ToJson<Calendar>(1, "error");
        try {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie).getUserId();
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userId", userId);
            if (calen != null) {
                map.put("calType", calen.getCalType());
            }
            List<Users> usersList = usersMapper.getAll();
            request.getSession().setAttribute("users",usersList);
            // 判断是否开启 系统参数：模块数据显示密级字段
            SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                map.put("isShowSecret", true);
                map.put("scaOperationUserId", users.getUserId());
                map.put("securityRestriction",securityContentApprovalService.securityRestriction());
            }
            List<AffairWithBLOBs> list1 = affairMapper.selectAll(map);
            List<Calendar> list = calendarService.getscheduleByTakerAndOwner(request,userId, calen);

            //（提醒类型(2-按日提醒,3-按周提醒,4-按月提醒,5按年提醒,6-按工作日提醒)
            for (AffairWithBLOBs affairWithBLOBs : list1) {
                Calendar calendars = new Calendar();
                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                Date d = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                String strDate = sdf.format(d);
                switch (affairWithBLOBs.getType()) {
                    //按日提醒
                    case Two:
                        List<String> listz = DateCompute.getDayListOfMonth();
                        List<Integer> daylist = new ArrayList<Integer>();
                        for (String datess : listz) {
                            Integer day = DateFormat.getDateTime(datess);
                            daylist.add(day);
                        }
                        if (affairWithBLOBs.getEndTime() == 0) {
                            Integer startTime = 0;
                            //为0择不限制
                            for (Integer Day1 : daylist) {
                                if (Day1 >= affairWithBLOBs.getBeginTime()) {
                                    startTime = Day1;
                                    break;
                                }
                            }
                            Calendar calendar = new Calendar();
                            calendar.setUserId(affairWithBLOBs.getUserId());
                            Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                            if (usernameByUserId !=null ){
                                calendar.setUserName(usernameByUserId.getUserName());
                            }
                            calendar.setCalId(affairWithBLOBs.getAffId());
                            calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                            calendar.setCalTime(startTime);
                            //已经是Integer类型最大值
                            calendar.setEndTime(2147483647);
                            calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                            calendar.setType(affairWithBLOBs.getType());//
                            calendar.setContent(affairWithBLOBs.getContent());
                            calendar.setTaker(affairWithBLOBs.getTaker());
                            calendar.setAddTime(affairWithBLOBs.getAddTime());
                            if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                if(affairWithBLOBs.getContentSecrecy()!=null){
                                    calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                }
                            }
                            calendar.setCalLevel("2");
                            calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                            calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                            int cT1 = calendar.getCalTime();
                            int eT1 = calendar.getEndTime();
                            Long ct1 = (long) (cT1 * 1000L);
                            Long et1 = (long) (eT1 * 1000L);
                            String s1 = f.format(ct1);
                            String e1 = f.format(et1);
                            calendar.setStim(s1);
                            calendar.setEtim(e1);
                            if (!StringUtils.checkNull(calen.getCalLevel())) {
                                if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                    list.add(calendar);
                                }
                            } else {
                                list.add(calendar);
                            }
                        } else {
                            for (Integer Day1 : daylist) {
                                if (Day1 >= affairWithBLOBs.getBeginTime() && Day1 <= affairWithBLOBs.getEndTime()) {
                                    Calendar calendar = new Calendar();
                                    calendar.setUserId(affairWithBLOBs.getUserId());
                                    Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                    if (usernameByUserId !=null ){
                                        calendar.setUserName(usernameByUserId.getUserName());
                                    }
                                    calendar.setCalId(affairWithBLOBs.getAffId());
                                    calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                                    calendar.setCalTime(Day1);
                                    calendar.setEndTime(Day1);
                                    calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                                    calendar.setType(affairWithBLOBs.getType());//
                                    calendar.setContent(affairWithBLOBs.getContent());
                                    calendar.setTaker(affairWithBLOBs.getTaker());
                                    calendar.setAddTime(affairWithBLOBs.getAddTime());
                                    if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                        if(affairWithBLOBs.getContentSecrecy()!=null){
                                            calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                        }
                                    }
                                    calendar.setCalLevel("2");
                                    calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                    calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                    calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                    int cT1 = calendar.getCalTime();
                                    int eT1 = calendar.getEndTime();
                                    Long ct1 = (long) (cT1 * 1000L);
                                    Long et1 = (long) (eT1 * 1000L);
                                    String s1 = f.format(ct1);
                                    String e1 = f.format(et1);
                                    calendar.setStim(s1);
                                    calendar.setEtim(e1);
                                    if (!StringUtils.checkNull(calen.getCalLevel())) {
                                        if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                            list.add(calendar);
                                        }
                                    } else {
                                        list.add(calendar);
                                    }
                                }
                            }
                        }
                        break;
                    //按周提醒
                    case Three:
                        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                        sdf1.setLenient(false);
                        SimpleDateFormat sdf2 = new SimpleDateFormat("EEE");
                        List<Integer> list2 = new LinkedList<>();//与添加时间相同的星期的4个日期。
                        String weekDays = DateCompute.dateToWeek(DateFormat.getStrDateTime(affairWithBLOBs.getBeginTime()));
                        for (int i = 1; i < (DateCompute.getLastMonthDay(strDate)) + 1; i++) {
                            Date date = sdf1.parse(strDate + "-" + i);
                            String s1 = sdf1.format(date);
                            String s2 = sdf2.format(date);
                            if (s2.equals(weekDays)) {
                                list2.add(DateFormat.getDateTime(s1));
                            }
                        }
                        if (affairWithBLOBs.getEndTime() == 0) {
                            for (Integer Day : list2) {
                                if (Day >= affairWithBLOBs.getBeginTime()) {
                                    Calendar calendar = new Calendar();
                                    calendar.setUserId(affairWithBLOBs.getUserId());
                                    Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                    if (usernameByUserId !=null ){
                                        calendar.setUserName(usernameByUserId.getUserName());
                                    }
                                    calendar.setCalId(affairWithBLOBs.getAffId());
                                    calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                                    calendar.setCalTime(Day);
                                    calendar.setEndTime(Day);
                                    calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                                    calendar.setType(affairWithBLOBs.getType());//
                                    calendar.setContent(affairWithBLOBs.getContent());
                                    calendar.setTaker(affairWithBLOBs.getTaker());
                                    calendar.setAddTime(affairWithBLOBs.getAddTime());
                                    if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                        if(affairWithBLOBs.getContentSecrecy()!=null){
                                            calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                        }
                                    }
                                    calendar.setCalLevel("2");
                                    calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                    calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                    int cT = calendar.getCalTime();
                                    int eT = calendar.getEndTime();
                                    Long ct = (long) (cT * 1000L);
                                    Long et = (long) (eT * 1000L);
                                    String s = f.format(ct);
                                    String e = f.format(et);
                                    calendar.setStim(s);
                                    calendar.setEtim(e);
                                    if (!StringUtils.checkNull(calen.getCalLevel())) {
                                        if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                            list.add(calendar);
                                        }
                                    } else {
                                        list.add(calendar);
                                    }
                                }
                            }
                        } else {
                            for (Integer Day : list2) {
                                if (Day >= affairWithBLOBs.getBeginTime() && Day <= affairWithBLOBs.getEndTime()) {
                                    Calendar calendar = new Calendar();
                                    calendar.setUserId(affairWithBLOBs.getUserId());
                                    Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                    if (usernameByUserId !=null ){
                                        calendar.setUserName(usernameByUserId.getUserName());
                                    }
                                    calendar.setCalId(affairWithBLOBs.getAffId());
                                    calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                                    calendar.setCalTime(Day);
                                    calendar.setEndTime(Day);
                                    calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                                    calendar.setType(affairWithBLOBs.getType());//
                                    calendar.setContent(affairWithBLOBs.getContent());
                                    calendar.setTaker(affairWithBLOBs.getTaker());
                                    if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                        if(affairWithBLOBs.getContentSecrecy()!=null){
                                            calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                        }
                                    }
                                    calendar.setAddTime(affairWithBLOBs.getAddTime());
                                    calendar.setCalLevel("2");
                                    calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                    calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                    int cT = calendar.getCalTime();
                                    int eT = calendar.getEndTime();
                                    Long ct = (long) (cT * 1000L);
                                    Long et = (long) (eT * 1000L);
                                    String s = f.format(ct);
                                    String e = f.format(et);
                                    calendar.setStim(s);
                                    calendar.setEtim(e);
                                    if (!StringUtils.checkNull(calen.getCalLevel())) {
                                        if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                            list.add(calendar);
                                        }
                                    } else {
                                        list.add(calendar);
                                    }
                                }
                            }
                        }
                        break;
                    //按月提醒
                    case Four:
                        String str = DateFormat.getDateStrTime(affairWithBLOBs.getBeginTime());//数据库中的存入时间
                        Date d1 = new SimpleDateFormat("yyyy-MM-dd").parse(str);
                        SimpleDateFormat str1 = new SimpleDateFormat("dd");
                        String str2 = str1.format(d1);//取出按月提醒的日数dd。
                        //String newDate = "2018-07"+"-"+str2;
                        String newDate = strDate + "-" + str2;
                        if (affairWithBLOBs.getEndTime() == 0) {
                            calendars.setUserId(affairWithBLOBs.getUserId());
                            Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                            if (usernameByUserId !=null ){
                                calendars.setUserName(usernameByUserId.getUserName());
                            }
                            calendars.setCalId(affairWithBLOBs.getAffId());
                            calendars.setRemindTime(affairWithBLOBs.getRemindTime());
                            //calendars.setCalTime(affairWithBLOBs.getBeginTime());
                            calendars.setCalTime(DateFormat.getDateTime(newDate));
                            calendars.setEndTime(DateFormat.getDateTime(newDate));
                            calendars.setCalType(affairWithBLOBs.getCalType());//事务类型
                            calendars.setType(affairWithBLOBs.getType());//
                            calendars.setContent(affairWithBLOBs.getContent());
                            if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                if(affairWithBLOBs.getContentSecrecy()!=null){
                                    calendars.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                }
                            }
                            calendars.setTaker(affairWithBLOBs.getTaker());
                            calendars.setAddTime(affairWithBLOBs.getAddTime());
                            calendars.setCalLevel("2");
                            calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                            calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                            int cT = calendars.getCalTime();
                            int eT = calendars.getEndTime();
                            Long ct = (long) (cT * 1000L);
                            Long et = (long) (eT * 1000L);
                            String s = f.format(ct);
                            String e = f.format(et);
                            calendars.setStim(s);
                            calendars.setEtim(e);
                            if (!StringUtils.checkNull(calen.getCalLevel())) {
                                if (calen.getCalLevel().equals(calendars.getCalLevel())) {
                                    list.add(calendars);
                                }
                            } else {
                                list.add(calendars);
                            }
                        } else {
                            if (DateFormat.getDateTime(newDate) <= affairWithBLOBs.getEndTime()) {
                                calendars.setUserId(affairWithBLOBs.getUserId());
                                calendars.setUserId(affairWithBLOBs.getUserId());
                                Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                if (usernameByUserId !=null ){
                                    calendars.setUserName(usernameByUserId.getUserName());
                                }
                                calendars.setCalId(affairWithBLOBs.getAffId());
                                calendars.setRemindTime(affairWithBLOBs.getRemindTime());
                                //calendars.setCalTime(affairWithBLOBs.getBeginTime());
                                calendars.setCalTime(DateFormat.getDateTime(newDate));
                                calendars.setEndTime(DateFormat.getDateTime(newDate));
                                calendars.setCalType(affairWithBLOBs.getCalType());//事务类型
                                calendars.setType(affairWithBLOBs.getType());//
                                calendars.setContent(affairWithBLOBs.getContent());
                                calendars.setTaker(affairWithBLOBs.getTaker());
                                calendars.setAddTime(affairWithBLOBs.getAddTime());
                                if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                    if(affairWithBLOBs.getContentSecrecy()!=null){
                                        calendars.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                    }
                                }
                                calendars.setCalLevel("2");
                                calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                int cT = calendars.getCalTime();
                                int eT = calendars.getEndTime();
                                Long ct = (long) (cT * 1000L);
                                Long et = (long) (eT * 1000L);
                                String s = f.format(ct);
                                String e = f.format(et);
                                calendars.setStim(s);
                                calendars.setEtim(e);
                                if (!StringUtils.checkNull(calen.getCalLevel())) {
                                    if (calen.getCalLevel().equals(calendars.getCalLevel())) {
                                        list.add(calendars);
                                    }
                                } else {
                                    list.add(calendars);
                                }
                            }
                        }
                        break;

                    //按年提醒
                    case Five:
                        break;
                    //按工作日提醒
                    case Six:
                        List<Integer> daylists = new ArrayList<Integer>();
                        List<String> dates = new ArrayList<String>();
                        String[] strings = strDate.split("-");
                        int year = Integer.valueOf(strings[0]);
                        int month = Integer.valueOf(strings[1]);
                        //获取日历对象
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        //制定年月日
                        cal.set(java.util.Calendar.YEAR, year);
                        cal.set(java.util.Calendar.MONTH, month - 1);
                        cal.set(java.util.Calendar.DATE, 1);
                        while (cal.get(java.util.Calendar.YEAR) == year && cal.get(java.util.Calendar.MONTH) < month) {
                            int day = cal.get(java.util.Calendar.DAY_OF_WEEK);
                            if (!(day == java.util.Calendar.SUNDAY || day == java.util.Calendar.SATURDAY)) {
                                dates.add(new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime().clone()));
                            }
                            cal.add(java.util.Calendar.DATE, 1);
                        }
                        for (String datess : dates) {
                            Integer day = DateFormat.getDateTime(datess);
                            daylists.add(day);
                        }
                        if (affairWithBLOBs.getEndTime() == 0) {
                            for (Integer Day1 : daylists) {
                                if (Day1 >= affairWithBLOBs.getBeginTime()) {
                                    Calendar calendar = new Calendar();
                                    calendar.setUserId(affairWithBLOBs.getUserId());
                                    calendars.setUserId(affairWithBLOBs.getUserId());
                                    Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                    if (usernameByUserId !=null ){
                                        calendars.setUserName(usernameByUserId.getUserName());
                                    }
                                    calendar.setCalId(affairWithBLOBs.getAffId());
                                    calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                                    calendar.setCalTime(Day1);
                                    calendar.setEndTime(Day1);
                                    calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                                    calendar.setType(affairWithBLOBs.getType());//
                                    calendar.setContent(affairWithBLOBs.getContent());
                                    calendar.setTaker(affairWithBLOBs.getTaker());
                                    calendar.setAddTime(affairWithBLOBs.getAddTime());
                                    calendar.setCalLevel("2");
                                    calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                    if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                        if(affairWithBLOBs.getContentSecrecy()!=null){
                                            calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                        }
                                    }
                                    calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                    int cT1 = calendar.getCalTime();
                                    int eT1 = calendar.getEndTime();
                                    Long ct1 = (long) (cT1 * 1000L);
                                    Long et1 = (long) (eT1 * 1000L);
                                    String s1 = f.format(ct1);
                                    String e1 = f.format(et1);
                                    calendar.setStim(s1);
                                    calendar.setEtim(e1);
                                    if (!StringUtils.checkNull(calen.getCalLevel())) {
                                        if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                            list.add(calendar);
                                        }
                                    } else {
                                        list.add(calendar);
                                    }
                                }
                            }
                        } else {
                            for (Integer Day1 : daylists) {
                                if (Day1 >= affairWithBLOBs.getBeginTime() && Day1 <= affairWithBLOBs.getEndTime()) {
                                    Calendar calendar = new Calendar();
                                    calendar.setUserId(affairWithBLOBs.getUserId());
                                    calendars.setUserId(affairWithBLOBs.getUserId());
                                    Users usernameByUserId = usersService.getUsersByuserId(affairWithBLOBs.getUserId());
                                    if (usernameByUserId !=null ){
                                        calendars.setUserName(usernameByUserId.getUserName());
                                    }
                                    calendar.setCalId(affairWithBLOBs.getAffId());
                                    calendar.setRemindTime(affairWithBLOBs.getRemindTime());
                                    calendar.setCalTime(Day1);
                                    calendar.setEndTime(Day1);
                                    calendar.setCalType(affairWithBLOBs.getCalType());//事务类型
                                    calendar.setType(affairWithBLOBs.getType());//
                                    calendar.setContent(affairWithBLOBs.getContent());
                                    calendar.setTaker(affairWithBLOBs.getTaker());
                                    calendar.setAddTime(affairWithBLOBs.getAddTime());
                                    calendar.setCalLevel("2");
                                    calendars.setStim(DateFormat.getDatestrTimes(affairWithBLOBs.getBeginTimeTime()));
                                    calendars.setEtim(DateFormat.getDatestrTimes(affairWithBLOBs.getEndTimeTime()));
                                    if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
                                        if(affairWithBLOBs.getContentSecrecy()!=null){
                                            calendar.setContentSecrecy(affairWithBLOBs.getContentSecrecy());
                                        }
                                    }
                                    int cT1 = calendar.getCalTime();
                                    int eT1 = calendar.getEndTime();
                                    Long ct1 = (long) (cT1 * 1000L);
                                    Long et1 = (long) (eT1 * 1000L);
                                    String s1 = f.format(ct1);
                                    String e1 = f.format(et1);
                                    calendar.setStim(s1);
                                    calendar.setEtim(e1);
                                    if (!StringUtils.checkNull(calen.getCalLevel())) {
                                        if (calen.getCalLevel().equals(calendar.getCalLevel())) {
                                            list.add(calendar);
                                        }
                                    } else {
                                        list.add(calendar);
                                    }
                                }
                            }
                        }
                        break;
                }
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月20日 下午13:08:18
     * 方法介绍:   查询整个日程安排信息
     * 参数说明:   @param calendar
     *
     * @return List
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getAllSchedule", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getScheduleByUserIdAndType(HttpServletRequest request) {
        return calendarService.getScheduleByUserIdAndType(request);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月20日 下午13:08:18
     * 方法介绍:   用户日程安排查询，根据时间和部门进行查询
     * 参数说明:   @param calendar
     *
     * @return List
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getAllScheduleByDeptIdAndDate", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getAllScheduleByDeptIdAndDate(HttpServletRequest request,String userId, String deptId) {
        return calendarService.getAllScheduleByDeptIdAndDate(request,userId, deptId);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/8/22
     * @说明: 根据calId查看日志详情接口
     */
    @ResponseBody
    @RequestMapping("/schedule/selCalenderById")
    public ToJson<Calendar> selCalenderById(Integer calId) {
        return calendarService.selCalenderById(calId);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 17:08
     * 方法介绍: 查询领导日程（不包含周期性事务和自己的）
     * @param request
     * @return com.xoa.util.ToJson<com.xoa.model.calender.Calendar>
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getLeaderSchedule", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getLeaderSchedule(HttpServletRequest request, String userId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            List<Calendar> list = calendarService.getLeaderSchedule(users.getUserId(),userId,users);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-30 17:08
     * 方法介绍: 查询领导日程（按月和天）type = day , type =month
     * @param request
     * @return com.xoa.util.ToJson<com.xoa.model.calender.Calendar>
     */
    @ResponseBody
    @RequestMapping(value = "/schedule/getLeaderScheduleMonth", produces = {"application/json;charset=UTF-8"})
    public ToJson<Calendar> getLeaderScheduleMonth(HttpServletRequest request, String userId
    ,@RequestParam(value = "time", required = false) String calTime
    ,@RequestParam(value = "type", required = false) String type) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Calendar> json = new ToJson<Calendar>(0, null);
        try {
            List<Calendar> list = calendarService.getLeaderScheduleMonth(users.getUserId(),userId,calTime,type);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }



    //H5微应用
    @RequestMapping("/calender/calendarh5")
    public String calendarh5() {
        return "/app/calendar/m/calendarh5";
    }

    //新建日程
    @RequestMapping("/calender/addScheduleh5")
    public String addScheduleh5() {
        return "/app/calendar/m/addScheduleh5";
    }

    //日程详情
    @RequestMapping("/calender/calendarDetails")
    public String calendarDetails() {
        return "/app/calendar/m/calendarDetails";
    }
}

