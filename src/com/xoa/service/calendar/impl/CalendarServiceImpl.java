package com.xoa.service.calendar.impl;

import com.xoa.dao.calendar.CalendarMapper;
import com.xoa.dao.calendarLeaderPriv.CalendarLeaderPrivMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.securityApproval.SecurityContentApprovalMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv;
import com.xoa.model.calender.Calendar;
import com.xoa.model.calender.CalendarAll;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.calendar.CalendarService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateCompute;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class CalendarServiceImpl implements CalendarService {
    @Resource
    private CalendarMapper calendarMapper;
    @Resource
    private UsersMapper usersMapper;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    SysCodeMapper sysCodeMapper;

    @Resource
    SmsService smsService;

    @Resource
    UsersService usersService;

    @Resource
    QywxService qywxService;

    @Resource
    CalendarLeaderPrivMapper calendarLeaderPrivMapper;

    @Resource
    DepartmentService departmentService;

    @Resource
    SecurityContentApprovalService securityContentApprovalService;
    @Resource
    SysParaMapper sysParaMapper;
    @Resource
    SecurityContentApprovalMapper securityContentApprovalMapper;

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:24:08
     * 方法介绍:   根据日程安排的起始和结束时间查询日程
     * 参数说明:   @param calTime 起始时间
     * 参数说明:   @param endTime 结束时间
     * 参数说明:   @return
     *
     * @return List<Calendar> 返回日程安排
     */
    @Override
    public List<Calendar> getschedule(int calTime, int endTime, String userId) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("calTime", calTime);
        maps.put("endTime", endTime);
        maps.put("userId", userId);
        List<Calendar> list = calendarMapper.getschedule(maps);
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for (int j = 0; j < list.size(); j++) {
            Calendar calendar = list.get(j);
            int cT = calendar.getCalTime();
            int eT = calendar.getEndTime();
            Long ct = (long) (cT * 1000L);
            Long et = (long) (eT * 1000L);
            String s = f.format(ct);
            String e = f.format(et);
            calendar.setStim(s);
            calendar.setEtim(e);
        }
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月5日 下午5:24:26
     * 方法介绍:   根据userId 查询日程安排
     * 参数说明:   @param Map<String, Object> maps 用户userId和当天时间戳
     * 参数说明:   @return
     *
     * @return List<Calendar>  返回日程安排
     * @throws Exception
     */
    @Override
    public List<Calendar> getscheduleBycId(String userId) {
        Map<String, Object> maps = new HashMap<String, Object>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date()) + " 00:00:00";
        Integer starTime = DateFormat.getTime(date);
        Integer strTime = 6 * 24 * 60 * 60 * 1000;
        //结束时间
        Integer endTime = starTime + strTime;
        maps.put("userId", userId);
        maps.put("starTime", starTime);
        maps.put("endTime", endTime);
        List<Calendar> list = calendarMapper.getscheduleBycIds(maps);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        List<Calendar> listAll = new ArrayList<Calendar>();
        for (int i = 0; i < 30; i++) {
            Calendar Allcal = new Calendar();
            int pd = starTime + 86400 * i;
            Long t = (long) (pd * 1000L);
            List<CalendarAll> list1 = new ArrayList<CalendarAll>();
            String data = format.format(t);
            for (int j = 0; j < list.size(); j++) {
                Calendar calendar = list.get(j);
                CalendarAll ca = new CalendarAll();
                int cT = calendar.getCalTime();
                int eT = calendar.getEndTime();
                Long ct = (long) (cT * 1000L);
                Long et = (long) (eT * 1000L);
                String s = f.format(ct);
                String e = f.format(et);
                calendar.setStim(s);
                calendar.setEtim(e);
                if (pd <= cT && cT <= pd + 86400 || pd <= eT && pd >= cT) {
                    ca.setAddTime(calendar.getAddTime());
                    ca.setCalId(calendar.getCalId());
                    ca.setCalType(calendar.getCalType());
                    ca.setEndTime(calendar.getEndTime());
                    ca.setContent(calendar.getContent());
                    ca.setCalLevel(calendar.getCalLevel());
                    ca.setCalTime(calendar.getCalTime());
                    ca.setTaker(calendar.getTaker());
                    ca.setStim(calendar.getStim());
                    ca.setEtim(calendar.getEtim());
                    ca.setOwner(calendar.getOwner());
                    list1.add(ca);
                }
            }
            Allcal.setCalData(data);
            Allcal.setCalMessage(list1);
            listAll.add(Allcal);
        }
        return listAll;
    }

    public List<Calendar> getscheduleBycId(String userId, String calTime) {
        List<Calendar> list = new ArrayList<Calendar>();
        List<Calendar> listAll = new ArrayList<Calendar>();
        try {
            Map<String, Object> maps = new HashedMap();
            String monthTime = DateCompute.getMonthTime(calTime);
            String[] split = monthTime.split(",");
            String startTime = split[0] + " 00:00:00";
            String eTime = split[1] + " 23:59:59";
            Integer startTime_1 = DateFormat.getTime(startTime);
            Integer endTime = DateFormat.getTime(eTime);
            maps.put("userId", userId);
            maps.put("starTime", startTime_1);
            maps.put("endTime", endTime);
            list = calendarMapper.getscheduleBycId(maps);
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            for (int i = 0; i < 30; i++) {
                Calendar Allcal = new Calendar();
                int pd = startTime_1 + 86400 * i;
                Long t = (long) (pd * 1000L);
                List<CalendarAll> list1 = new ArrayList<CalendarAll>();
                String data = format.format(t);
                for (int j = 0; j < list.size(); j++) {
                    Calendar calendar = list.get(j);
                    CalendarAll ca = new CalendarAll();
                    int cT = calendar.getCalTime();
                    int eT = calendar.getEndTime();
                    Long ct = (long) (cT * 1000L);
                    Long et = (long) (eT * 1000L);
                    String s = f.format(ct);
                    String e = f.format(et);
                    calendar.setStim(s);
                    calendar.setEtim(e);
                    if (pd <= cT && cT <= pd + 86400 || pd <= eT && pd >= cT) {
                        ca.setAddTime(calendar.getAddTime());
                        ca.setCalId(calendar.getCalId());
                        ca.setCalType(calendar.getCalType());
                        ca.setEndTime(calendar.getEndTime());
                        ca.setContent(calendar.getContent());
                        ca.setCalLevel(calendar.getCalLevel());
                        ca.setCalTime(calendar.getCalTime());
                        ca.setTaker(calendar.getTaker());
                        ca.setStim(calendar.getStim());
                        ca.setEtim(calendar.getEtim());
                        ca.setOwner(calendar.getOwner());
                        list1.add(ca);
                    }
                }
                Allcal.setCalData(data);
                Allcal.setCalMessage(list1);
                listAll.add(Allcal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listAll;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:46:54
     * 方法介绍:   新增日程安排
     * 参数说明:   @param record 日程安排
     * 参数说明:   @return
     *
     * @return
     */
    @Override
    public void insertSelective(Calendar record, HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        calendarMapper.insertSelective(record);
        // 判断是否开启 系统参数：模块数据显示密级字段
        SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
        if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
            // 新增内容安全审核数据
            securityContentApprovalService.insert("calendar", String.valueOf(record.getCalId()), "日程安排", record.getContent(),
                    "", "0", record.getContentSecrecy(), request);
        }
        //添加事务提醒
        addAffairs(record, request);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月5日 下午6:17:56
     * 方法介绍:   根据calId删除日程安排
     * 参数说明:   @param calId 主键
     *
     * @return void 无
     */
    public void delete(int calId, HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        if(!Objects.isNull(request.getAttribute("approvalFlagUserId"))) {
            user.setUserId(request.getAttribute("approvalFlagUserId").toString());
        }
        Calendar calendar = calendarMapper.selCalendarById(calId);
        if (calendar.getUserId().equals(user.getUserId())) {
            calendar.setOverStatus("1");
        }
        String owner = "";
        if (calendar.getOwner().contains("," + user.getUserId() + ",")) {
            owner = calendar.getOwner().replace("," + user.getUserId() + ",", ",");
            calendar.setOwner(owner);
        } else if (calendar.getOwner().startsWith(user.getUserId() + ",")) {
            owner = calendar.getOwner().replace(user.getUserId() + ",", "");
            calendar.setOwner(owner);
        }
        String taker = "";
        if (calendar.getTaker().contains("," + user.getUserId() + ",")) {
            taker = calendar.getTaker().replace("," + user.getUserId() + ",", ",");
            calendar.setTaker(taker);
        } else if (calendar.getTaker().startsWith(user.getUserId() + ",")) {
            taker = calendar.getTaker().replace(user.getUserId() + ",", "");
            calendar.setTaker(taker);
        }
        calendarMapper.update(calendar);//进行更新删除
        //如果，创建者和参与者以及所属者都将该日程删除，则将这个日程彻底删除（更新后，重新查询）
        Calendar calendarNew = calendarMapper.selCalendarById(calId);
        if ( calendarNew.getOverStatus().equals("1") || ( StringUtils.checkNull(calendarNew.getTaker()) && StringUtils.checkNull(calendarNew.getOwner())) ) {
            calendarMapper.delete(calId);
        }
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:46:54
     * 方法介绍:   更新日程安排
     * 参数说明:   @param record 日程安排
     * 参数说明:   @return
     *
     * @return int 插入条数
     */
    @Override
    public int update(Calendar calendar) {
        return calendarMapper.update(calendar);

    }


    @Override
    public List<Calendar> getscheduleByDay(String userId, String calTime) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("userId", userId);
        //calTime当前就是String类型的时间戳，getDateTime方法是String类型的时间，即 "2021-11-22 12:30:56" 这种类型转换成时间戳
        //maps.put("calTime", DateFormat.getDateTime(calTime));
        maps.put("calTime", Integer.valueOf(calTime));
        List<Calendar> list = calendarMapper.getscheduleByDay(maps);
        for (int i = 0; i < list.size(); i++) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Calendar cal = list.get(i);
            int cT = cal.getCalTime();
            int eT = cal.getEndTime();
            Long ct = (long) (cT * 1000L);
            Long et = (long) (eT * 1000L);
            String s = format.format(ct);
            String e = format.format(et);
            cal.setStim(s);
            cal.setEtim(e);
        }
        return list;
    }

    @Override
    public List<Calendar> getAllschedule(String userId) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("userId", userId);
        List<Calendar> list = calendarMapper.getAllschedule(maps);
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for (int j = 0; j < list.size(); j++) {
            Calendar calendar = list.get(j);
            int cT = calendar.getCalTime();
            int eT = calendar.getEndTime();
            Long ct = (long) (cT * 1000L);
            Long et = (long) (eT * 1000L);
            String s = f.format(ct);
            String e = f.format(et);
            calendar.setStim(s);
            calendar.setEtim(e);
        }
        return list;
    }


    @Override
    public List<Calendar> getAllscheduleinfo(Integer deptId) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("deptId", deptId);
        List<Calendar> list = calendarMapper.getAllscheduleinfo(maps);
        return list;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月19日 下午13:57:26
     * 方法介绍:   根据userId 和当前时间查询日程安排，查询参与者和所属者的日程安排(今天)
     * 参数说明:	userId 当前用户userId
     * 参数说明:	calTime 当前时间
     * 参数说明:   @return
     *
     * @return List<Calendar>  返回日程安排
     */
    @Override
    public List<Calendar> getscheduleByTakerAndOwner(HttpServletRequest request,String userId, Calendar cal) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        Map<String, Object> maps = new HashMap<String, Object>();
        String da = DateFormat.getDatestr(new Date());
        long calTime = DateFormat.getDateTime(da);
        maps.put("userId", userId);
        maps.put("calTime", calTime);
        if (cal != null) {
            maps.put("calType", cal.getCalType());
            maps.put("calLevel", cal.getCalLevel());
        }

        // 判断是否开启 系统参数：模块数据显示密级字段
        SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
        if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
            maps.put("isShowSecret", true);
            maps.put("scaOperationUserId", users.getUserId());
            maps.put("securityRestriction",securityContentApprovalService.securityRestriction());
            maps.put("allKey",request.getAttribute("allKey"));
        }
        List<Calendar> list = calendarMapper.getAllScheduleByTakerAndOwner(maps);
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (Calendar calendar : list) {
            int cT = calendar.getCalTime();
            int eT = calendar.getEndTime();
            Long ct = (long) (cT * 1000L);
            Long et = (long) (eT * 1000L);
            String s = f.format(ct);
            String e = f.format(et);
            calendar.setStim(s);
            calendar.setEtim(e);
            List<Users> usersList = (List<Users>) request.getSession().getAttribute("users");
            //创建人姓名
            String userId1 = calendar.getUserId();
            if(!StringUtils.checkNull(userId1)){
                // Users usernameByUserId = usersService.getUsersByuserId(userId1);
                // if (usernameByUserId !=null ){
                //     calendar.setUserName(usernameByUserId.getUserName());
                //     calendar.setDeptName(usernameByUserId.getDeptName());
                // }
                for (Users user : usersList) {
                    if (user.getUserId().equals(userId1)){
                        calendar.setUserName(user.getUserName());
                        calendar.setDeptName(user.getDeptName());
                    }
                }

            }


            //获取参与者和所属者的名称
            //String owner = calendar.getOwner();
            // if (!StringUtils.checkNull(owner)) {
            //     List<Users> userByuserId = usersService.getUserByuserId(owner);
            //     StringBuffer stringBuffer = new StringBuffer();
            //     for (Users users : userByuserId) {
            //         stringBuffer.append(users.getUserName() + ",");
            //     }
            //     calendar.setOwnerName(stringBuffer.toString());
            // }
            String[] owners = calendar.getOwner().split(",");
            StringBuffer stringBuffer = new StringBuffer();
            for (String owner1 : owners) {
                for (Users user : usersList) {
                    if (user.getUserId().equals(owner1)){
                        stringBuffer.append(user.getUserName() + ",");
                    }
                }
            }
            calendar.setOwnerName(stringBuffer.toString());
            //参与者
            // String taker = calendar.getTaker();
            // if (!StringUtils.checkNull(taker)) {
            //     List<Users> userByuserIds = usersService.getUserByuserId(taker);
            //     StringBuffer stringBuffer2 = new StringBuffer();
            //     for (Users users : userByuserIds) {
            //         stringBuffer2.append(users.getUserName() + ",");
            //     }
            //     calendar.setTakeName(stringBuffer2.toString());
            // }
            String[] takers = calendar.getTaker().split(",");
            StringBuffer stringBuffer2 = new StringBuffer();
            for (String taker1 : takers) {
                for (Users user : usersList) {
                    if (user.getUserId().equals(taker1)){
                        stringBuffer2.append(user.getUserName() + ",");
                    }
                }
            }
            calendar.setTakeName(stringBuffer2.toString());
        }
        return list;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月20日 下午13:08:18
     * 方法介绍:   查询整个日程安排信息
     * 参数说明:   @param calendar
     *
     * @return List
     */
    public ToJson<Calendar> getScheduleByUserIdAndType(HttpServletRequest request) {
        ToJson<Calendar> json = new ToJson<Calendar>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            List<Calendar> calendarList = calendarMapper.getAllScheduleByAdmin(user.getUserId());
            List<Calendar> list1 = calendarMapper.getScheduleByUserIdAndType(user.getUserId());
            for (Calendar calendar1 : list1) {
                calendar1.setEdit(true);
                boolean flag = false;//没有
                for (Calendar calendar : calendarList) {
                    if (calendar.getOwner().contains("," + user.getUserId() + ",") || calendar.getOwner().startsWith(user.getUserId() + ",")) {
                        calendar.setEdit(true);
                    }
                    if (calendar.getCalId() == calendar1.getCalId()) {
                        flag = true;
                    }
                }
                if (!flag) {
                    calendarList.add(calendar1);
                }
            }
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            //处理一下参与者和所属者的名字
            for (Calendar calendar : calendarList) {
                int cT = calendar.getCalTime();
                int eT = calendar.getEndTime();
                Long ct = (long) (cT * 1000L);
                Long et = (long) (eT * 1000L);
                String s = f.format(ct);
                String e = f.format(et);
                calendar.setStim(s);
                calendar.setEtim(e);

                //创建人姓名
                String userId1 = calendar.getUserId();
                String usernameByUserId = usersMapper.getUsernameByUserId(userId1);
                calendar.setUserName(usernameByUserId);


                if (!StringUtils.checkNull(calendar.getTaker())) {
                    String[] takerArr = calendar.getTaker().split(",");
                    StringBuffer takeName = new StringBuffer();
                    for (String takerId : takerArr) {
                        if (!StringUtils.checkNull(takerId)) {
                            if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(takerId))) {
                                takeName.append(usersMapper.getUsernameByUserId(takerId) + ",");
                            }
                        }
                    }
                    calendar.setTakeName(takeName.toString());
                }
                if (!StringUtils.checkNull(calendar.getOwner())) {
                    String[] owerArr = calendar.getOwner().split(",");
                    StringBuffer owerName = new StringBuffer();
                    for (String owerId : owerArr) {
                        if (!StringUtils.checkNull(owerId)) {
                            if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(owerId))) {
                                owerName.append(usersMapper.getUsernameByUserId(owerId) + ",");
                            }
                        }
                    }
                    calendar.setOwnerName(owerName.toString());
                }
            }
            json.setObj(calendarList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("CalenderServiceImpl getAllSchedule:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月20日 下午13:08:18
     * 方法介绍:   用户日程安排查询，根据时间和部门进行查询  (用户日程安排查询更改为查询所有用户日程)
     * 参数说明:   @param calendar
     *
     * @return List
     */
    public ToJson<Calendar> getAllScheduleByDeptIdAndDate(HttpServletRequest request, String userId, String deptId) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        ToJson<Calendar> json = new ToJson<Calendar>(1, "error");
        try {
            Set<Calendar> calendarSet = new TreeSet<>(new Comparator<Calendar>() {
                @Override
                public int compare(Calendar o1, Calendar o2) {
                    return o1.getCalId().compareTo(o2.getCalId());
                }
            });
            List<Calendar> calendars = new ArrayList<>();
            Calendar cal = new Calendar();
            cal.setType("1");
            //查询所有用户的信息存入session
            List<Users> usersList = usersMapper.getAll();
            request.getSession().setAttribute("users",usersList);
            request.setAttribute("allKey","allKey");
            // 获取当前用户，管理的分支机构（包含管理范围）
            List<Department> departmentList = departmentService.getDepartmentByClassifyOrg1(user, false);
            if (!org.springframework.util.CollectionUtils.isEmpty(departmentList)) {
                String[] deptIds = departmentList.stream().map(Department::getDeptId).distinct().map(String::valueOf).collect(Collectors.joining(",")).split(",");
                List<Users> users = usersMapper.selectUserByDeptIds(deptIds);
                for (Users users1 : users) {
                    List<Calendar> calendars1 = getscheduleByTakerAndOwner(request,users1.getUserId(), cal);
                    calendars.addAll(calendars1);
                }
            } else {
                if (StringUtils.checkNull(deptId)) {
                    List<Users> users = usersMapper.getUsersNoByDeptId(Integer.valueOf(user.getUserPrivNo()), null);
                    for (Users users1 : users) {
                        List<Calendar> calendars1 = getscheduleByTakerAndOwner(request,users1.getUserId(), cal);
                        calendars.addAll(calendars1);
                    }
                } else {
                    if (StringUtils.checkNull(userId)) {
                        List<Users> users = usersMapper.getUsersNoByDeptId(Integer.valueOf(user.getUserPrivNo()), Integer.valueOf(deptId));
                        for (Users users1 : users) {
                            List<Calendar> calendars1 = getscheduleByTakerAndOwner(request,users1.getUserId(), cal);
                            calendars.addAll(calendars1);
                        }
                    } else {
                        calendars = getscheduleByTakerAndOwner(request,userId, cal);
                    }
                }
            }

            calendarSet.addAll(calendars);
            json.setObj(new ArrayList<>(calendarSet));
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("CalenderServiceImpl getAllScheduleByDeptIdAndDate:" + e);
        }
        return json;
    }

    /**
     * 日程
     *
     * @return
     */
    public List<Calendar> rChSelect() {
        List<Calendar> attendSet = calendarMapper.rChSelect();
        return attendSet;
    }

    @Override
    public ToJson<Calendar> selCalenderById(Integer calId) {
        ToJson<Calendar> json = new ToJson<Calendar>();
        Calendar calendar = calendarMapper.selCalendarById(calId);
        if (!StringUtils.checkNull(calendar.getTaker())) {
            List<Users> users = usersMapper.selUserByIds(calendar.getTaker().split(","));
            StringBuilder takerName = new StringBuilder();
            for (int i = 0; i < users.size(); i++) {
                Users users1 = users.get(i);
                takerName.append(users1.getUserName()).append(",");
            }
            calendar.setTakeName(takerName.toString());
        }
        if (calendar != null) {
            json.setObject(calendar);
            json.setFlag(0);
        }
        return json;
    }

    @Override
    public List<Calendar> getLeaderSchedule(String logUserId, String userId,Users user) {
        //查询用户是否有编辑权限
        boolean bol = false;
        List<CalendarLeaderPriv> calendarLeaderPrivs = calendarLeaderPrivMapper.selectCalendarByManger(userId);
        for (CalendarLeaderPriv calendarLeaderPriv : calendarLeaderPrivs) {
            if (calendarLeaderPriv.getEditPrivUsers().contains("," + logUserId + ",") || calendarLeaderPriv.getEditPrivUsers().startsWith(logUserId + ",")) {
                bol = true;
                break;
            }
        }
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("calType", "1");//领导日程只查询工作事务
        SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
        if (isShowSecret != null && !StringUtils.checkNull(isShowSecret.getParaValue()) &&  "1".equals(isShowSecret.getParaValue())) {
            map.put("isShowSecret", true);
            map.put("scaOperationUserId", user.getUserId());
            map.put("securityRestriction",securityContentApprovalService.securityRestriction());
        }
        //List<Calendar> list1 = calendarMapper.getAllScheduleByUserId(map);
        List<Calendar> list = calendarMapper.getAllScheduleByTakerAndOwner(map);
        /*for (Calendar calendar1 : list1) {
            calendar1.setEdit(true);
            boolean flag = false;
            if (list.size() > 0) {
                for (Calendar calendar : list) {
                    if (calendar.getCalId() == calendar1.getCalId()) {
                        flag = true;
                    }
                }
                if (!flag) {
                    list.add(calendar1);
                }
            } else {
                list.addAll(list1);
            }
        }*/
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for (Calendar calendar : list) {
            int cT = calendar.getCalTime();
            int eT = calendar.getEndTime();
            Long ct = (long) (cT * 1000L);
            Long et = (long) (eT * 1000L);
            String s = f.format(ct);
            String e = f.format(et);
            calendar.setStim(s);
            calendar.setEtim(e);

            //判断是否有编辑权限
            if (bol || calendar.getOwner().contains("," + logUserId + ",") || calendar.getOwner().startsWith(logUserId + ",")) {
                calendar.setEdit(true);
            }

            //创建人姓名
            String userId1 = calendar.getUserId();
            String usernameByUserId = usersMapper.getUsernameByUserId(userId1);
            calendar.setUserName(usernameByUserId);

            //获取参与者和所属者的名称
            String owner = calendar.getOwner();
            if (!StringUtils.checkNull(owner)) {
                List<Users> userByuserId = usersService.getUserByuserId(owner);
                StringBuffer stringBuffer = new StringBuffer();
                for (Users users : userByuserId) {
                    stringBuffer.append(users.getUserName() + ",");
                }
                calendar.setOwnerName(stringBuffer.toString());
            }
            //参与者
            String taker = calendar.getTaker();
            if (!StringUtils.checkNull(taker)) {
                List<Users> userByuserIds = usersService.getUserByuserId(taker);
                StringBuffer stringBuffer2 = new StringBuffer();
                for (Users users : userByuserIds) {
                    stringBuffer2.append(users.getUserName() + ",");
                }
                calendar.setTakeName(stringBuffer2.toString());
            }
        }
        return list;
    }

    @Override
    public List<Calendar> getLeaderScheduleMonth(String logUserId, String userId, String calTime, String type) {
        List<Calendar> listAll = new ArrayList<Calendar>();
        //查询用户是否有编辑权限
        boolean bol = false;
        List<CalendarLeaderPriv> calendarLeaderPrivs = calendarLeaderPrivMapper.selectCalendarByManger(userId);
        for (CalendarLeaderPriv calendarLeaderPriv : calendarLeaderPrivs) {
            if (calendarLeaderPriv.getEditPrivUsers().contains("," + logUserId + ",") || calendarLeaderPriv.getEditPrivUsers().startsWith(logUserId + ",")) {
                bol = true;
                break;
            }
        }
        try {
            if ("day".equals(type)) {
                Map<String, Object> maps = new HashMap<String, Object>();
                maps.put("userId", userId);
                maps.put("calTime", DateFormat.getDateTime(calTime));
                listAll = calendarMapper.getscheduleByDay(maps);
                for (int i = 0; i < listAll.size(); i++) {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    Calendar cal = listAll.get(i);
                    if (bol || cal.getOwner().contains("," + logUserId + ",") || cal.getOwner().startsWith(logUserId + ",")) {
                        cal.setEdit(true);
                    }
                    int cT = cal.getCalTime();
                    int eT = cal.getEndTime();
                    Long ct = (long) (cT * 1000L);
                    Long et = (long) (eT * 1000L);
                    String s = format.format(ct);
                    String e = format.format(et);
                    cal.setStim(s);
                    cal.setEtim(e);
                }
            } else {
                Map<String, Object> maps = new HashedMap();
                Integer startTime = null;
                Integer endTime = null;
                if (StringUtils.checkNull(calTime)) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    String date = sdf.format(new Date()) + " 00:00:00";
                    startTime = DateFormat.getTime(date);
                    Integer strTime = 6 * 24 * 60 * 60 * 1000;
                    endTime = startTime + strTime;
                } else {
                    String monthTime = DateCompute.getMonthTime(calTime);
                    String[] split = monthTime.split(",");
                    String startTimes = split[0] + " 00:00:00";
                    String eTime = split[1] + " 23:59:59";
                    startTime = DateFormat.getTime(startTimes);
                    endTime = DateFormat.getTime(eTime);
                }
                maps.put("calType", "1");//领导日程只查询工作事务
                maps.put("userId", userId);
                maps.put("starTime", startTime);
                maps.put("endTime", endTime);
                List<Calendar> list = calendarMapper.getscheduleBycId(maps);
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                for (int i = 0; i < 30; i++) {
                    Calendar Allcal = new Calendar();
                    int pd = startTime + 86400 * i;
                    Long t = (long) (pd * 1000L);
                    List<CalendarAll> list1 = new ArrayList<CalendarAll>();
                    String data = format.format(t);
                    for (int j = 0; j < list.size(); j++) {
                        Calendar calendar = list.get(j);
                        //判断是否有编辑权限
                        if (bol || calendar.getOwner().contains("," + logUserId + ",") || calendar.getOwner().startsWith(logUserId + ",")) {
                            calendar.setEdit(true);
                        }
                        CalendarAll ca = new CalendarAll();
                        int cT = calendar.getCalTime();
                        int eT = calendar.getEndTime();
                        Long ct = (long) (cT * 1000L);
                        Long et = (long) (eT * 1000L);
                        String s = f.format(ct);
                        String e = f.format(et);
                        calendar.setStim(s);
                        calendar.setEtim(e);
                        if (pd <= cT && cT <= pd + 86400 || pd <= eT && pd >= cT) {
                            ca.setAddTime(calendar.getAddTime());
                            ca.setCalId(calendar.getCalId());
                            ca.setCalType(calendar.getCalType());
                            ca.setEndTime(calendar.getEndTime());
                            ca.setContent(calendar.getContent());
                            ca.setCalLevel(calendar.getCalLevel());
                            ca.setCalTime(calendar.getCalTime());
                            ca.setTaker(calendar.getTaker());
                            ca.setStim(calendar.getStim());
                            ca.setEtim(calendar.getEtim());
                            ca.setOwner(calendar.getOwner());
                            list1.add(ca);
                        }
                    }
                    Allcal.setCalData(data);
                    Allcal.setCalMessage(list1);
                    listAll.add(Allcal);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listAll;
    }

    /**
     * 日程安排 添加事务提醒
     *
     * @param calendar
     * @param request
     */
    @Async
    public void addAffairs(final Calendar calendar, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        final String remind = request.getParameter("remind");
        final String smsRemind = request.getParameter("smsRemind");

        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(calendar.getUserId());
                if (locale.equals("zh_CN")) {
                    smsBody.setContent(" 日程通知！主题：" + calendar.getContent());
                } else if (locale.equals("en_US")) {
                    smsBody.setContent(" Schedule notice！Subject：" + calendar.getContent());
                } else if (locale.equals("zh_TW")) {
                    smsBody.setContent(" 日程通知！主題：" + calendar.getContent());
                }

                String editCalender = calendar.getBeforeRemaind();
                String[] split = editCalender.split("\\|");
                String day = split[0];
                String hour = split[1];
                String min = split[2];
                //算出时间戳值
                int i = 0;
                //天数
                if (!StringUtils.checkNull(day)) {
                    i += Integer.valueOf(day) * 24 * 60 * 60;
                }
                //小时
                if (!StringUtils.checkNull(hour)) {
                    i += Integer.valueOf(hour) * 60 * 60;
                }
                //分钟
                if (!StringUtils.checkNull(min)) {
                    i += Integer.valueOf(min) * 60;
                }
                //提醒时间应该为开始时间减去提前多少时间
                smsBody.setSendTime(calendar.getCalTime() - i);
                SysCode sysCode = new SysCode();
                if (locale.equals("zh_CN")) {
                    sysCode.setCodeName("日程安排");
                } else if (locale.equals("en_US")) {
                    sysCode.setCodeName("Schedule arrangement");
                } else if (locale.equals("zh_TW")) {
                    sysCode.setCodeName("日程安排");
                }
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                String toUserId = "";
                if (!StringUtils.checkNull(calendar.getUserId())) {
                    toUserId += calendar.getUserId() + ",";
                }
                if (!StringUtils.checkNull(calendar.getOwner())) {
                    toUserId += calendar.getOwner();
                }
                if (!StringUtils.checkNull(calendar.getTaker())) {
                    toUserId += calendar.getTaker();
                }
                toUserId = StringUtils.getRemoveStr(toUserId);


                String res = DateFormat.getStrTime(calendar.getCalTime());
                String res2 = DateFormat.getStrTime(calendar.getEndTime());

                try {
                    smsBody.setRemindUrl("/schedule/index?id=" + calendar.getCalId() + "&calLevel=" + calendar.getCalLevel() +
                            "&calTime=" + calendar.getCalTime() + "&calType=" + calendar.getCalType() +
                            "&content=" + URLEncoder.encode(calendar.getContent(), "utf-8") + "&endTime=" + calendar.getEndTime() +
                            "&etim=" + URLEncoder.encode(res2, "utf-8") + "&owner=" + calendar.getOwner() +
                            "&stim=" + URLEncoder.encode(res, "utf-8") + "&taker=" + calendar.getTaker());
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                String title = users.getUserName() + "：日程安排提醒！";
                String context = "主题:" + calendar.getContent();
                if (locale.equals("en_US")) {
                    title = users.getUserName() + "：Schedule reminder！";
                    context = "Subject:" + calendar.getContent();
                } else if (locale.equals("zh_TW")) {
                    title = users.getUserName() + "：日程安排提醒！";
                    context = "主題:" + calendar.getContent();
                }
                smsService.saveSms(smsBody, toUserId, remind, smsRemind, title, context, sqlType);
                qywxService.sendMsg(Arrays.asList(toUserId.split(",")), title, context, "/ewx/calendar", false);
            }
        });

    }
}
