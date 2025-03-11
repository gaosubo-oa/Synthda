package com.xoa.service.taskCenter.impl;

import com.alibaba.fastjson.JSONArray;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.menu.SysMenuMapper;
import com.xoa.dao.taskCenter.TaskCenterMapper;
import com.xoa.dao.users.UserPrivateSetMapper;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.menu.SysMenu;
import com.xoa.model.taskCenter.TaskCenter;
import com.xoa.model.users.UserPrivateSet;
import com.xoa.model.users.Users;
import com.xoa.service.taskCenter.TaskCenterService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TaskCenterServiceImpl implements TaskCenterService {

    @Autowired
    private TaskCenterMapper taskCenterMapper;
    @Resource
    private SysMenuMapper sysMenuMapper;// 父类菜单DAO
    @Resource
    private SysFunctionMapper sysFunctionMapper;// 子类菜单DAO
    @Resource
    private UserPrivateSetMapper userPrivateSetMapper;

    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Autowired
    private UsersService usersService;

    //获取当前登陆人所有待办数据接口
    @Override
    public ToJson getTaskCenters(PageParams pageParams, HttpServletRequest request, TaskCenter taskCenter) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            //0为待办超时   1为已办超时
            String timeOut = request.getParameter("timeOut");
            Map<String, Object> map = new HashMap<>();
            //当前登陆人
            map.put("userId", users.getUserId());
            //分页
            map.put("page", (pageParams.getPage() - 1) * pageParams.getPageSize());
            map.put("pageSize", pageParams.getPageSize());
            //任务状态
            map.put("taskStatus", StringUtils.checkNull(taskCenter.getTaskStatus()) ? null : taskCenter.getTaskStatus());
            //根据菜单查询数据
            map.put("funcId", taskCenter.getFuncId() == null ? null : taskCenter.getFuncId());
            //任务状态
            map.put("timeOut", StringUtils.checkNull(timeOut) ? null : timeOut);
            //获取需要显示菜单
            UserPrivateSet userPrivateSet = new UserPrivateSet();
            userPrivateSet.setUid(users.getUid());
            userPrivateSet.setUserId(users.getUserId());
            //检索个人信息设置信息
            UserPrivateSet userPrivateSetOwn = userPrivateSetMapper.getDataByUserAndModule(users.getUserId(), "02");
            //获取全局信息
            UserPrivateSet userPrivateSetDataBase = userPrivateSetMapper.getGlobalData();
            JSONArray jsonArray = new JSONArray();
            Map mapJson = jsonArray.parseObject(userPrivateSetDataBase.getTaskSet(), Map.class);//将字符串解析为map对象
            //必选模块
            String displayValue = mapJson.get("displayValue").toString();
            if (userPrivateSetOwn != null) {//有设置内容
                //displayValue是必选值
                String[] both = (String[]) ArrayUtils.addAll(userPrivateSetOwn.getTaskSet().split(","), displayValue.split(","));
                map.put("funIds", both);
            } else {
                map.put("funIds", displayValue.toString().split(","));
            }
            List<TaskCenter> taskCenters = taskCenterMapper.getTaskCenters(map);
            for (TaskCenter task : taskCenters) {
                SysFunction sysFunctionByFid = sysFunctionMapper.getSysFunctionByFid(task.getFuncId());
                //所属功能分类
                if (sysFunctionByFid != null) {
                    task.setFuncName(sysFunctionByFid.getName());
                }
                //发送人
                if (!StringUtils.checkNull(task.getFromUser())) {
                    task.setFromUserName(usersService.getUserNameById(task.getFromUser()));
                }
            }
            json.setFlag(0);
            json.setData(taskCenters);
            json.setTotleNum(taskCenterMapper.getTaskCentersCount(map));
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    //获取菜单待办数量
    @Override
    public ToJson getAllDataCount(HttpServletRequest request) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            UserPrivateSet userPrivateSet = new UserPrivateSet();
            userPrivateSet.setUid(users.getUid());
            userPrivateSet.setUserId(users.getUserId());
            //检索个人信息设置信息
            UserPrivateSet userPrivateSetOwn = userPrivateSetMapper.getDataByUserAndModule(users.getUserId(), "02");
            //获取全局信息
            UserPrivateSet userPrivateSetDataBase = userPrivateSetMapper.getGlobalData();
            JSONArray jsonArray = new JSONArray();
            Map mapJson = jsonArray.parseObject(userPrivateSetDataBase.getTaskSet(), Map.class);//将字符串解析为map对象
            //必选模块
            String displayValue = mapJson.get("displayValue").toString();
            Map<String, Object> map = new HashMap<>();

            if (userPrivateSetOwn != null) {//有设置内容
                //displayValue是必选值
                String[] both = (String[]) ArrayUtils.addAll(userPrivateSetOwn.getTaskSet().split(","), displayValue.split(","));
                map.put("funIds", both);
            } else {
                map.put("funIds", displayValue.toString().split(","));
            }
            //当前登陆人
            map.put("userId", users.getUserId());
            map.put("taskStatus", "0");
            List<SysMenu> sysMenus = new ArrayList<>();
            List<SysFunction> sysFunctions = new ArrayList<>();
            //获取所有待办数据
            List<TaskCenter> taskCenters = taskCenterMapper.analysisByMonthAndMenu(map);
            for (TaskCenter task : taskCenters) {
                //封装数据至二级菜单实体类
                SysFunction sysFunctionByFid = sysFunctionMapper.getSysFunctionByFid(task.getFuncId());
                sysFunctionByFid.setMessageNum(task.getDataCount());
                sysFunctions.add(sysFunctionByFid);
                sysMenus.addAll(sysMenuMapper.getTheFirstMenu(sysFunctionByFid.getId().substring(0, 2)));
            }
            //去除重复一级菜单
            List<SysMenu> distinctList = sysMenus.stream().collect(Collectors.collectingAndThen(
                    Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysMenu::getId))), ArrayList::new));
            for (SysMenu sys : distinctList) {
                //将待办数量进行计数并放置子级
                List<SysFunction> tasks = new ArrayList<>();
                int msgCount = 0;
                for (SysFunction task : sysFunctions) {
                    if (String.valueOf(task.getId()).startsWith(sys.getId())) {
                        tasks.add(task);
                        msgCount += task.getMessageNum();
                    }
                }
                sys.setMessageNum(msgCount);
                sys.setChild(tasks);
            }
            json.setFlag(0);
            json.setData(distinctList);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    //按月统计任务数量接口--公司均办理量与个人办理量对比
    @Override
    public ToJson analysisByMonth(HttpServletRequest request) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            List<String> lastMonths = getLastMonths(6);
            Map<String, Object> returnMap = new HashMap<>();
            analysisByMonthPrescription(request);
            for (String date : lastMonths) {
                Map<String, Object> map = new HashMap<>();
                //当前登陆人
                map.put("userId", users.getUserId());
                Date monthBeginTime = DateFormat.getMonthBeginTime(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]));
                Date monthEndTime = DateFormat.getMonthEndTime(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]));
                map.put("monthBeginTime", monthBeginTime);
                map.put("monthEndTime", monthEndTime);
                //个人完成数量
                int personalMonthCount = taskCenterMapper.getpersonalMonthCount(map);

                //整体完成量
                int globalMonthCount = taskCenterMapper.getGlobalMonthCount(map);

                Map<String, Object> monthMap = new HashMap<>();
                monthMap.put("globalMonthCount", globalMonthCount);
                monthMap.put("personalMonthCount", personalMonthCount);
                returnMap.put(date, monthMap);
            }
            json.setFlag(0);
            json.setData(returnMap);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    //按月统计任务数量接口--公司均办理时效与个人办理时效对比
    @Override
    public ToJson analysisByMonthPrescription(HttpServletRequest request) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            List<String> lastMonths = getLastMonths(6);
            Map<String, Object> returnMap = new HashMap<>();
            for (String date : lastMonths) {
                Map<String, Object> map = new HashMap<>();

                Date monthBeginTime = DateFormat.getMonthBeginTime(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]));
                Date monthEndTime = DateFormat.getMonthEndTime(Integer.parseInt(date.split("-")[0]), Integer.parseInt(date.split("-")[1]));
                map.put("monthBeginTime", monthBeginTime);
                map.put("monthEndTime", monthEndTime);
                //公司级平均时效（小时）
                double globalMonthCount = taskCenterMapper.getpersonalMonthPrescription(map);
                //当前登陆人
                map.put("userId", users.getUserId());
                //个人平均时效（小时）
                double personalMonthCount = taskCenterMapper.getpersonalMonthPrescription(map);

                Map<String, Object> monthMap = new HashMap<>();
                monthMap.put("globalMonth", globalMonthCount);
                monthMap.put("personalMonth", personalMonthCount);
                returnMap.put(date, monthMap);
            }
            json.setFlag(0);
            json.setData(returnMap);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    //获取指定月份的数据统计分析，（单个月中的不同业务模块分析）
    @Override
    public ToJson analysisByMonthAndMenu(HttpServletRequest request) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Map<String, Object> map = new HashMap<>();
            String year = request.getParameter("year");
            String month = request.getParameter("month");
            //当前登陆人
            map.put("userId", users.getUserId());
            Date monthBeginTime = DateFormat.getMonthBeginTime(Integer.parseInt(year), Integer.parseInt(month));
            Date monthEndTime = DateFormat.getMonthEndTime(Integer.parseInt(year), Integer.parseInt(month));
            map.put("monthBeginTime", monthBeginTime);
            map.put("monthEndTime", monthEndTime);
            map.put("userId", users.getUserId());
            map.put("taskStatus", "1");
            Map<String, Object> returnMap = new HashMap<>();
            List<TaskCenter> taskCenters = taskCenterMapper.analysisByMonthAndMenu(map);
            for (TaskCenter task : taskCenters) {
                SysFunction sysFunctionByFid = sysFunctionMapper.getSysFunctionByFid(task.getFuncId());
                if (sysFunctionByFid != null) {
                    returnMap.put(sysFunctionByFid.getName(), task.getDataCount());
                }
            }
            json.setFlag(0);
            json.setData(returnMap);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    //获取当前月的前几个月份
    public static List<String> getLastMonths(int size) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        List<String> list = new ArrayList(size);
        for (int i = 0; i < size; i++) {
            c.setTime(new Date());
            c.add(Calendar.MONTH, -i);
            Date m = c.getTime();
            list.add(sdf.format(m));
        }
        Collections.reverse(list);
        return list;
    }

    //任务中心-公共推送接口
    public void addTaskCenter(final TaskCenter taskCenter, final String code) {//code值是有各个业务块传输的值。　code为内置funcId值
     /*   if (StringUtils.checkNull(code)) {
            return;
        }
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                //校验code值有没有开启全局推送
                UserPrivateSet globalData = userPrivateSetMapper.getGlobalData();
                if (globalData != null && !StringUtils.checkNull(globalData.getTaskSet())) {
                    JSONArray jsonArray = new JSONArray();
                    Map map = jsonArray.parseObject(globalData.getTaskSet(), Map.class);//将字符串解析为map对象
                    String displayValue = map.get("displayValue").toString();
                    if (!StringUtils.checkNull(displayValue) && Arrays.asList(displayValue.split(",")).contains(code)) {//不为空则进行检索
                        taskCenter.setFuncId(Integer.parseInt(code));
                        taskCenter.setTaskStatus("0");
                        taskCenter.setDoStatus("0");
                        for (String userId : taskCenter.getUserId().split(",")) {
                            taskCenter.setUserId(userId);
                            taskCenterMapper.insert(taskCenter);
                        }
                    }
                }
            }
        });*/
    }


    //任务中心-公共取消消除任务接口
    //需传：funcId菜单id，userId用户id，doUrl需消除的url
    public void finishTaskCenter(final TaskCenter taskCenter, final String code) {
       /* if (StringUtils.checkNull(code)) {
            return;
        }
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                taskCenter.setEndTime(new Date());
                taskCenterMapper.removeTaskCenter(taskCenter);
            }
        });
*/
    }
}
