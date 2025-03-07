package com.xoa.service.widget.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hikvision.artemis.sdk.util.HttpUtils;
import com.xoa.dao.calendar.CalendarMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.diary.DiaryModelMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.todayCarNo.TodayCarNoMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.widget.WeatherMapper;
import com.xoa.dao.widget.WidgetModuleMapper;
import com.xoa.dao.widget.WidgetSetMapper;
import com.xoa.model.AI.AISetting;
import com.xoa.model.calender.Calendar;
import com.xoa.model.calender.CalendarAll;
import com.xoa.model.common.SysPara;
import com.xoa.model.diary.DiaryModel;
import com.xoa.model.diary.DiaryWidgetVO;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailBodyWidgetVO;
import com.xoa.model.email.EmailModel;
import com.xoa.model.notify.Notify;
import com.xoa.model.notify.NotifyWidgetVO;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.Users;
import com.xoa.model.weather.OneDayWeatherInf;
import com.xoa.model.weather.WeatherInf;
import com.xoa.model.widget.Weather;
import com.xoa.model.widget.WidgetDataModel;
import com.xoa.model.widget.WidgetModel;
import com.xoa.model.widget.WidgetSetModel;
import com.xoa.model.worldnews.News;
import com.xoa.model.worldnews.NewsWidgetVO;
import com.xoa.service.email.EmailService;
import com.xoa.service.notify.NotifyService;
import com.xoa.service.sys.InterFaceService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UsersService;
import com.xoa.service.widget.WidgetService;
import com.xoa.service.worldnews.NewService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.PinYinUtil;
import com.xoa.util.ToJson;
import com.xoa.util.WeatherUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 作者：张航宁
 * 创建日期：2017-07-13
 */
@Service
public class WidgetServiceImpl implements WidgetService {

    @Resource
    private EmailService emailService;
    @Resource
    private NotifyService notifyService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private NewService newService;
    // 日志
    @Resource
    private DiaryModelMapper diaryModelMapper;
    // 日程
    @Resource
    private CalendarMapper calendarMapper;

    @Resource
    private WidgetModuleMapper widgetModuleMapper;

    @Resource
    private WeatherMapper weatherMapper;

    @Resource
    private WidgetSetMapper widgetSetMapper;


    @Resource
    private UsersMapper usersMapper;
    @Resource
    UsersService usersService;

    @Resource
    InterFaceService interfaceService;

    @Autowired
    TodayCarNoMapper todayCarNoMapper;


    @Autowired
    private UserFunctionService userFunctionService;

    @Resource
    private SysInterfaceMapper sysInterfaceMapper;

    @Value("${CUNZHEN_AppCode}")
    String AppCode;

    /**
     * 作者：张航宁
     * 获取widget门户信息
     *
     * @param request
     * @param cityName
     * @return
     */
    @Override
    public ToJson<WidgetSetModel> getWidgetToDoMsg(HttpServletRequest request, String cityName, String district) {
        ToJson<WidgetSetModel> json = new ToJson<WidgetSetModel>();
        List<WidgetDataModel> dataList = new ArrayList<WidgetDataModel>();
        WidgetSetModel widgetSetModel = null;
        PageParams pageParams = new PageParams();
        pageParams.setPage(1);
        pageParams.setPageSize(5);
        pageParams.setUseFlag(true);
        try {
            // 获取当前登录用户信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            // 获取当前语言
            String local = getNowLanguage(request);

            boolean bol = false;
            SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
            if (myproject != null && !StringUtils.checkNull(myproject.getParaValue())
                    && "dazu".equals(myproject.getParaValue())) {
                bol = true;
            }

            widgetSetModel = widgetSetMapper.getWidgetSetByUid(user.getUid());
            // 判断是否存在数据  如果不存在就插入一条新的数据
            if (widgetSetModel == null) {
                widgetSetModel = new WidgetSetModel();
                widgetSetModel.setUid(user.getUid());
                widgetSetModel.setBg("8");
                widgetSetModel.setModuleIds("1,2,4,5,");
                widgetSetModel.setType("1");
                widgetSetMapper.saveWidgetSet(widgetSetModel);
            }
            List<String> moduleIds = null;
            if (widgetSetModel != null && !StringUtils.checkNull(widgetSetModel.getModuleIds())) {
                moduleIds = Arrays.asList(widgetSetModel.getModuleIds().split(","));
            }
            if (moduleIds != null && moduleIds.size() > 0) {
                // 条件集合
                Map<String, Object> maps = new HashMap<String, Object>();
                maps.put("pageParams", pageParams);
                maps.put("fromId", user.getUserId());
                maps.put("userId", user.getUserId());
                maps.put("name", user.getUserId());
                maps.put("userPriv", user.getUserPriv());
                maps.put("deptId", user.getDeptId());
                for (String id : moduleIds) {
                    switch (Integer.valueOf(id)) {
                        case WEATHER_ID:
                            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
                            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
                            if (Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())) {
                                // 查询天气信息 cityName
                                if (!StringUtils.checkNull(cityName)) {
                                    WidgetDataModel<OneDayWeatherInf> widgetDataModel = new WidgetDataModel<OneDayWeatherInf>();
                                    OneDayWeatherInf oneDayWeatherInf = null;
                                    try {
                                        WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(cityName, district);
                                        if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                                            oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                                        } else {
                                            // 06 27根据高总指示 修改为不提供默认天气
                                            oneDayWeatherInf = new OneDayWeatherInf();
                                        }
                                        if (!StringUtils.checkNull(oneDayWeatherInf.getWeather())) {
                                            String weather = PinYinUtil.getPingYin(oneDayWeatherInf.getWeather());
                                            oneDayWeatherInf.setPicture("/img/weather/" + weather + ".png");
                                        }
                                        // 设置尾号
                                        //setWeiHao(oneDayWeatherInf);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    widgetDataModel.setData("weather");
                                    if (local.equals("zh_CN")) {
                                        widgetDataModel.setName("天气");
                                    } else if (local.equals("zh_tw")) {
                                        widgetDataModel.setName("天氣");
                                    } else if (local.equals("en_US")) {
                                        widgetDataModel.setName("Weather");
                                    }
                                    List<OneDayWeatherInf> oneDayWeatherInfs = new ArrayList<>();
                                    oneDayWeatherInfs.add(oneDayWeatherInf);
                                    //widgetDataModel.setData_info(oneDayWeatherInfs);
                                    widgetDataModel.setObject(oneDayWeatherInf);
                                    dataList.add(widgetDataModel);
                                }
                            }
                            break;
                        case EMAIL_ID:
                            // 查询邮件
                            maps.put("fromId", user.getUserId());
                            String sqlType = "xoa" + (String) request.getSession().getAttribute(
                                    "loginDateSouse");
                            List<EmailBodyModel> emailBodyModels = new ArrayList<EmailBodyModel>();
                            try {
                                ToJson<EmailBodyModel> emailBodyModelToJson = emailService.selectInbox(request, maps, 1, 5, true, sqlType);
                                emailBodyModels = emailBodyModelToJson.getObj();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (emailBodyModels != null) {
                                if (emailBodyModels.size() > 0) {
                                    for (EmailBodyModel e : emailBodyModels) {
                                        if (e.getUsers() == null) {
                                            e.setUsers(new Users());
                                        }
                                    }
                                }
                                WidgetDataModel<EmailBodyModel> widgetDataModel = new WidgetDataModel<EmailBodyModel>();
                                widgetDataModel.setData("email");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("邮件");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("郵件");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("E-mail");
                                }
                                widgetDataModel.setImg("/img/widget/email.png");
                                widgetDataModel.setData_info(emailBodyModels);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case NOTIFY_ID:
                            // 查询公告
                            maps.remove("fromId");
                            List<Notify> notifies = new ArrayList<Notify>();
                            try {
                                ToJson<Notify> json1 = notifyService.selectNotifyManage(maps, 1, 5, true, user.getUserId(), null);
                                notifies = json1.getObj();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (notifies != null) {
                                WidgetDataModel<Notify> widgetDataModel = new WidgetDataModel<Notify>();
                                widgetDataModel.setData("notify");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName(bol ? "公告通知" : "公告");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName(bol ? "公告通知" : "公告");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Notice");
                                }
                                widgetDataModel.setImg("/img/widget/notify.png");
                                widgetDataModel.setData_info(notifies);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case NEWS_ID:
                            // 查询新闻
                            List<News> news = new ArrayList<News>();
                            try {
                                ToJson<News> newsToJson = newService.selectNewsManage(maps, 1, 5, true, user.getUserId(), null);
                                news = newsToJson.getObj();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (news != null) {
                                WidgetDataModel<News> widgetDataModel = new WidgetDataModel<News>();
                                widgetDataModel.setData("news");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("新闻");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("新聞");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("News");
                                }
                                widgetDataModel.setImg("/img/widget/news.png");
                                widgetDataModel.setData_info(news);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case DIARY_ID:
                            // 日志
                            List<DiaryModel> diaryList = new ArrayList<DiaryModel>();
                            try {
                                diaryList = diaryModelMapper.getDiarySelf(maps);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (dataList != null) {
                                WidgetDataModel<DiaryModel> widgetDataModel = new WidgetDataModel<DiaryModel>();
                                widgetDataModel.setData("diary");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("日志");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("日誌");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Diary");
                                }
                                widgetDataModel.setImg("/img/widget/diary.png");
                                widgetDataModel.setData_info(diaryList);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case CALENDAR_ID:
                            // 查询当天日程
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                            cal.set(java.util.Calendar.SECOND, 0);
                            cal.set(java.util.Calendar.MINUTE, 0);
                            cal.set(java.util.Calendar.MILLISECOND, 0);
                            int calTime = (int) (cal.getTimeInMillis() / 1000);
                            maps.put("calTime", calTime);
                            List<Calendar> calendarList = calendarMapper.getscheduleBycId(maps);
                            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                            List<Calendar> listAll = new ArrayList<Calendar>();
                            Calendar Allcal = new Calendar();
                            List<CalendarAll> list1 = new ArrayList<CalendarAll>();
                            String data = format.format(new Date());
                            for (int j = 0; j < calendarList.size(); j++) {
                                Calendar calendar = calendarList.get(j);
                                CalendarAll ca = new CalendarAll();
                                int cT = calendar.getCalTime();
                                int eT = calendar.getEndTime();
                                Long ct = (long) (cT * 1000L);
                                Long et = (long) (eT * 1000L);
                                String s = f.format(ct);
                                String e = f.format(et);
                                calendar.setStim(s);
                                calendar.setEtim(e);
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
                            Allcal.setCalData(data);
                            Allcal.setCalMessage(list1);
                            listAll.add(Allcal);

                            if (calendarList != null) {
                                WidgetDataModel<Calendar> widgetDataModel = new WidgetDataModel<Calendar>();
                                widgetDataModel.setData("calendar");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("日程");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("日程");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Schedule");
                                }
                                widgetDataModel.setImg("/img/widget/calendar.png");
                                widgetDataModel.setData_info(listAll);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case FLOWRUNPRCS_ID:

                            break;
                        case DOCTMENT_ID:

                            break;
                        case NEWFILE_ID:
                            break;
                    }
                }
            }
            widgetSetModel.setData(dataList);
            widgetSetModel.setCount(widgetModuleMapper.getAllCount());
            json.setObject(widgetSetModel);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<WidgetSetModel> getWeather(HttpServletRequest request, String cityName, String district) {
        ToJson<WidgetSetModel> json = new ToJson<WidgetSetModel>();
        List<WidgetDataModel> dataList = new ArrayList<WidgetDataModel>();
        OneDayWeatherInf oneDayWeatherInf = null;
        WidgetSetModel widgetSetModel = null;
        try {
            // 获取当前登录用户信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            WidgetDataModel<OneDayWeatherInf> widgetDataModel = new WidgetDataModel<OneDayWeatherInf>();
            // 获取当前语言
            String local = getNowLanguage(request);
            widgetSetModel = widgetSetMapper.getWidgetSetByUid(user.getUid());
            // 判断是否存在数据  如果不存在就插入一条新的数据
            if (widgetSetModel == null) {
                widgetSetModel = new WidgetSetModel();
                widgetSetModel.setUid(user.getUid());
                widgetSetModel.setBg("8");
                widgetSetModel.setModuleIds("1,2,4,5,");
                widgetSetModel.setType("1");
                widgetSetMapper.saveWidgetSet(widgetSetModel);
            }
            List<String> moduleIds = null;
            if (widgetSetModel != null && !StringUtils.checkNull(widgetSetModel.getModuleIds())) {
                moduleIds = Arrays.asList(widgetSetModel.getModuleIds().split(","));
            }

            if (moduleIds != null && moduleIds.size() > 0) {
                for (String id : moduleIds) {
                    switch (Integer.valueOf(id)) {
                        case WEATHER_ID:
                            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
                            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
                            if (Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())) {
                                // 查询天气信息 cityName
                                if (!StringUtils.checkNull(cityName)) {
                                    Weather weather1 = weatherMapper.selLocationWeather(district);
                                    if (weather1 == null) {
                                        weather1 = weatherMapper.selLocationWeather(cityName);
                                    }
                                    if (weather1 != null && weather1.getWid() > 0) {
                                        Weather weatherObject = weather1;
                                        //访问时间
                                        String endTimeStr = String.valueOf(weatherObject.getDatecomen());
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        String end = sdf.format(weatherObject.getDatecomen());
                                        //当前时间
                                        Date date = new Date();
                                        String startTimeStr = String.valueOf(date);
                                        String start = sdf.format(date);

                                        long nd = 1000 * 24 * 60 * 60;//一天的毫秒数
                                        long nh = 1000 * 60 * 60;//一小时的毫秒数
                                        long nm = 1000 * 60;//一分钟的毫秒数
                                        // long ns = 1000;//一秒钟的毫秒数long
                                        //获得两个时间的毫秒时间差异
                                        long diff = 0;
                                        diff = sdf.parse(start).getTime() - sdf.parse(end).getTime();
                                        // long day = diff/nd;//计算差多少天
                                        //long hour = diff%nd/nh;//计算差多少小时
                                        long min = diff % nd % nh / nm;//计算差多少分钟

                                        if (min <= 10) {
                                            widgetDataModel.setObject(weatherObject);
                                            dataList.add(widgetDataModel);
                                            Weather weatherModel = new Weather();
                                            weatherModel.setDate(weatherObject.getDate());
                                            weatherModel.setDatecomen(new Date());
                                            weatherModel.setLocation(weatherObject.getLocation());
                                            weatherModel.setPicture(weatherObject.getPicture());
                                            weatherModel.setPmtwopointfive(String.valueOf(weatherObject.getPmtwopointfive()));
                                            weatherModel.setTemperturenow(weatherObject.getTemperturenow());
                                            weatherModel.setTempertureOfDay(weatherObject.getTempertureOfDay());
                                            weatherModel.setWeek(weatherObject.getWeek());
                                            weatherModel.setWeather(weatherObject.getWeather());
                                            weatherModel.setWeihao(weatherObject.getWeihao());
                                            weatherModel.setWind(weatherObject.getWind());
                                            weatherMapper.insertWeather(weatherModel);
                                            break;
                                        } else {
                                            try {
                                                WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(cityName, district);
                                                if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                                                    oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                                                } else {
                                                    // 06 27根据高总指示 修改为不提供默认天气
                                                    oneDayWeatherInf = new OneDayWeatherInf();
                                                    oneDayWeatherInf.setAqi("10");
                                                }
                                                if (!StringUtils.checkNull(oneDayWeatherInf.getWeather())) {
                                                    String weather = PinYinUtil.getPingYin(oneDayWeatherInf.getWeather());
                                                    oneDayWeatherInf.setPicture("/img/weather/" + weather + ".png");
                                                }
                                                // 设置尾号
                                                //setWeiHao(oneDayWeatherInf);
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                            widgetDataModel.setData("weather");
                                            if (local.equals("zh_CN")) {
                                                widgetDataModel.setName("天气");
                                            } else if (local.equals("zh_tw")) {
                                                widgetDataModel.setName("天氣");
                                            } else if (local.equals("en_US")) {
                                                widgetDataModel.setName("Weather");
                                            }
                                            widgetDataModel.setObject(oneDayWeatherInf);
                                            dataList.add(widgetDataModel);
                                            Weather weatherModel = new Weather();
                                            weatherModel.setDate(oneDayWeatherInf.getDate());
                                            weatherModel.setDatecomen(new Date());
                                            weatherModel.setLocation(oneDayWeatherInf.getLocation());
                                            weatherModel.setPicture(oneDayWeatherInf.getPicture());
                                            weatherModel.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                                            weatherModel.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                                            weatherModel.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                                            weatherModel.setWeek(oneDayWeatherInf.getWeek());
                                            weatherModel.setWeather(oneDayWeatherInf.getWeather());
                                            weatherModel.setWeihao(oneDayWeatherInf.getWeihao());
                                            weatherModel.setWind(oneDayWeatherInf.getWind());
                                            weatherMapper.insertWeather(weatherModel);

                                        }
                                        break;
                                    } else {
                                        try {
                                            WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(cityName, district);
                                            if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                                                oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                                            } else {
                                                // 06 27根据高总指示 修改为不提供默认天气
                                                oneDayWeatherInf = new OneDayWeatherInf();
                                                oneDayWeatherInf.setAqi("10");
                                            }
                                            if (!StringUtils.checkNull(oneDayWeatherInf.getWeather())) {
                                                String weather = PinYinUtil.getPingYin(oneDayWeatherInf.getWeather());
                                                oneDayWeatherInf.setPicture("/img/weather/" + weather + ".png");
                                            }
                                            // 设置尾号
                                            //setWeiHao(oneDayWeatherInf);
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                        widgetDataModel.setData("weather");
                                        if (local.equals("zh_CN")) {
                                            widgetDataModel.setName("天气");
                                        } else if (local.equals("zh_tw")) {
                                            widgetDataModel.setName("天氣");
                                        } else if (local.equals("en_US")) {
                                            widgetDataModel.setName("Weather");
                                        }
                                        widgetDataModel.setObject(oneDayWeatherInf);
                                        dataList.add(widgetDataModel);
                                        Weather weatherModel = new Weather();
                                        weatherModel.setDate(oneDayWeatherInf.getDate());
                                        weatherModel.setDatecomen(new Date());
                                        weatherModel.setLocation(oneDayWeatherInf.getLocation());
                                        weatherModel.setPicture(oneDayWeatherInf.getPicture());
                                        weatherModel.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                                        weatherModel.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                                        weatherModel.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                                        weatherModel.setWeek(oneDayWeatherInf.getWeek());
                                        weatherModel.setWeather(oneDayWeatherInf.getWeather());
                                        weatherModel.setWeihao(oneDayWeatherInf.getWeihao());
                                        weatherModel.setWind(oneDayWeatherInf.getWind());
                                        weatherMapper.insertWeather(weatherModel);
                                    }
                                    break;
                                }
                            }

                            break;
                    }
                }

                widgetSetModel.setData(dataList);
                widgetSetModel.setCount(widgetModuleMapper.getAllCount());
                json.setObject(widgetSetModel);
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<OneDayWeatherInf> getWeatherNew(HttpServletRequest request, String cityName, String district) {
        ToJson<OneDayWeatherInf> json = new ToJson<OneDayWeatherInf>();
        OneDayWeatherInf oneDayWeatherInf = null;
        try {
            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
            if (Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())) {
                try {
                    // 调用天气接口API
                    WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(cityName, district);
                    // 如果该地区调用失败返回null 就使用北京的天气
                    if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                        oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                    } else {
                        oneDayWeatherInf = new OneDayWeatherInf();
                        oneDayWeatherInf.setAqi("10");
                    }
                    // 设置尾号
                    //setWeiHao(oneDayWeatherInf);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (oneDayWeatherInf != null) {
                    json.setObject(oneDayWeatherInf);
                    // 查询是否已经有缓存天气
                    Weather weather = weatherMapper.selLocationWeather(oneDayWeatherInf.getLocation());

                    // 如果没有进行插入 然后缓存
                    if (weather == null) {
                        Weather weatherModel = new Weather();
                        weatherModel.setDate(oneDayWeatherInf.getDate());
                        weatherModel.setDatecomen(new Date());
                        weatherModel.setLocation(oneDayWeatherInf.getLocation());
                        weatherModel.setPicture(oneDayWeatherInf.getPicture());
                        weatherModel.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                        weatherModel.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                        weatherModel.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                        weatherModel.setWeek(oneDayWeatherInf.getWeek());
                        weatherModel.setWeather(oneDayWeatherInf.getWeather());
                        weatherModel.setWeihao(oneDayWeatherInf.getWeihao());
                        weatherModel.setWind(oneDayWeatherInf.getWind());
                        weatherMapper.insertWeather(weatherModel);
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String end = sdf.format(weather.getDatecomen());
                        //当前时间
                        Date date = new Date();
                        String startTimeStr = String.valueOf(date);
                        String start = sdf.format(date);

                        long nd = 1000 * 24 * 60 * 60;//一天的毫秒数
                        long nh = 1000 * 60 * 60;//一小时的毫秒数
                        long nm = 1000 * 60;//一分钟的毫秒数
                        // long ns = 1000;//一秒钟的毫秒数long
                        //获得两个时间的毫秒时间差异
                        long diff = 0;
                        diff = sdf.parse(start).getTime() - sdf.parse(end).getTime();
                        // long day = diff/nd;//计算差多少天
                        //long hour = diff%nd/nh;//计算差多少小时
                        long min = diff % nd % nh / nm;//计算差多少分钟

                        if (min >= 10) {
                            weather.setDate(oneDayWeatherInf.getDate());
                            weather.setDatecomen(new Date());
                            weather.setLocation(oneDayWeatherInf.getLocation());
                            weather.setPicture(oneDayWeatherInf.getPicture());
                            weather.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                            weather.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                            weather.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                            weather.setWeek(oneDayWeatherInf.getWeek());
                            weather.setWeather(oneDayWeatherInf.getWeather());
                            weather.setWeihao(oneDayWeatherInf.getWeihao());
                            weather.setWind(oneDayWeatherInf.getWind());
                            weatherMapper.updateByPrimaryKey(weather);
                        }

                    }
                } else { // 此处判断的是当聚合api接口调用失败的时候 使用缓存数据
                    Weather weather = weatherMapper.selLocationWeather(district);
                    if (weather == null) {
                        weather = weatherMapper.selLocationWeather(cityName);
                    }
                    json.setObject(weather);
                }
            }

            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<OneDayWeatherInf> getWeatherNews(HttpServletRequest request) {
        ToJson<OneDayWeatherInf> json = new ToJson<OneDayWeatherInf>();
        OneDayWeatherInf oneDayWeatherInf = null;
        try {
            String b = IpAddr.getIpAddr(request);
            String host = "https://cz88geoaliyun.cz88.net";
            String path = "/search/ip/geo";
            String method = "POST";
            String appcode = AppCode;
            Map<String, String> headers = new HashMap<String, String>();
            //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
            headers.put("Authorization", "APPCODE " + appcode);
            //根据API的要求，定义相对应的Content-Type
            headers.put("Content-Type", "application/json; charset=UTF-8");
            Map<String, String> querys = new HashMap<String, String>();
            querys.put("ip", b);
            String bodys = "";


            HttpResponse response = HttpUtils.doPost(host, path, method, headers, querys, bodys);

            JSONObject responseJson = JSON.parseObject(EntityUtils.toString(response.getEntity()));

            JSONObject data = responseJson.getJSONObject("data");
            String districts = data.getString("districts");
            String city = data.getString("city");

            //县级与区级未知情况下处理
            if(districts.equals("未知")){
                districts="";
            }
            //市级未知情况下
            if(city.equals("未知")){
                city="北京";
            }

            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
            if(Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())) {
                try {
                    // 调用天气接口API
                    WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(city, districts);
                    // 如果该地区调用失败返回null 就使用北京的天气
                    if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                        oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                    } else {
                        oneDayWeatherInf = new OneDayWeatherInf();
                        oneDayWeatherInf.setAqi("10");
                    }
                    // 设置尾号
                    //setWeiHao(oneDayWeatherInf);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                if (oneDayWeatherInf != null) {
                    json.setObject(oneDayWeatherInf);
                    // 查询是否已经有缓存天气
                    Weather weather = weatherMapper.selLocationWeather(oneDayWeatherInf.getLocation());

                    // 如果没有进行插入 然后缓存
                    if (weather == null) {
                        Weather weatherModel = new Weather();
                        weatherModel.setDate(oneDayWeatherInf.getDate());
                        weatherModel.setDatecomen(new Date());
                        weatherModel.setLocation(oneDayWeatherInf.getLocation());
                        weatherModel.setPicture(oneDayWeatherInf.getPicture());
                        weatherModel.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                        weatherModel.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                        weatherModel.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                        weatherModel.setWeek(oneDayWeatherInf.getWeek());
                        weatherModel.setWeather(oneDayWeatherInf.getWeather());
                        weatherModel.setWeihao(oneDayWeatherInf.getWeihao());
                        weatherModel.setWind(oneDayWeatherInf.getWind());
                        weatherMapper.insertWeather(weatherModel);
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String end = sdf.format(weather.getDatecomen());
                        //当前时间
                        Date date = new Date();
                        String startTimeStr = String.valueOf(date);
                        String start = sdf.format(date);

                        long nd = 1000 * 24 * 60 * 60;//一天的毫秒数
                        long nh = 1000 * 60 * 60;//一小时的毫秒数
                        long nm = 1000 * 60;//一分钟的毫秒数
                        // long ns = 1000;//一秒钟的毫秒数long
                        //获得两个时间的毫秒时间差异
                        long diff = 0;
                        diff = sdf.parse(start).getTime() - sdf.parse(end).getTime();
                        // long day = diff/nd;//计算差多少天
                        //long hour = diff%nd/nh;//计算差多少小时
                        long min = diff % nd % nh / nm;//计算差多少分钟

                        if (min >= 10) {
                            weather.setDate(oneDayWeatherInf.getDate());
                            weather.setDatecomen(new Date());
                            weather.setLocation(oneDayWeatherInf.getLocation());
                            weather.setPicture(oneDayWeatherInf.getPicture());
                            weather.setPmtwopointfive(String.valueOf(oneDayWeatherInf.getPmTwoPointFive()));
                            weather.setTemperturenow(oneDayWeatherInf.getTempertureNow());
                            weather.setTempertureOfDay(oneDayWeatherInf.getTempertureOfDay());
                            weather.setWeek(oneDayWeatherInf.getWeek());
                            weather.setWeather(oneDayWeatherInf.getWeather());
                            weather.setWeihao(oneDayWeatherInf.getWeihao());
                            weather.setWind(oneDayWeatherInf.getWind());
                            weatherMapper.updateByPrimaryKey(weather);
                        }

                    }
                } else { // 此处判断的是当聚合api接口调用失败的时候 使用缓存数据
                    Weather weather = weatherMapper.selLocationWeather(districts);
                    if (weather == null) {
                        weather = weatherMapper.selLocationWeather(city);
                    }
                    json.setObject(weather);
                }
            }

            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<WidgetSetModel> getWidgetMsg(HttpServletRequest request) {
        ToJson<WidgetSetModel> json = new ToJson<WidgetSetModel>();
        List<WidgetDataModel> dataList = new ArrayList<WidgetDataModel>();
        WidgetSetModel widgetSetModel = null;
        PageParams pageParams = new PageParams();
        pageParams.setPage(1);
        pageParams.setPageSize(5);
        pageParams.setUseFlag(true);
        try {
            // 获取当前登录用户信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            // 获取当前语言
            String local = getNowLanguage(request);

            boolean bol = false;
            SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
            if (myproject != null && !StringUtils.checkNull(myproject.getParaValue()) && "dazu".equals(myproject.getParaValue())) {
                bol = true;
            }

            String cityName = request.getParameter("cityName");
            String district = request.getParameter("district");
            widgetSetModel = widgetSetMapper.getWidgetSetByUid(user.getUid());
            // 判断是否存在数据  如果不存在就插入一条新的数据，默认新增只有天气和小卓
            if (widgetSetModel == null) {
                //修改为如果不存在，默认新增widget中开启的小部件
                List<WidgetModel> widgetModels = widgetModuleMapper.selectWidgetByIsOn("1");
                String moduleIds = widgetModels.stream().map(WidgetModel::getId).map(String::valueOf).collect(Collectors.joining(","));
                widgetSetModel = new WidgetSetModel();
                widgetSetModel.setUid(user.getUid());
                widgetSetModel.setBg("8");
                widgetSetModel.setModuleIds(moduleIds);
                widgetSetModel.setType("1");
                widgetSetMapper.saveWidgetSet(widgetSetModel);
            }
            List<InterfaceModel> interfaceModelList = sysInterfaceMapper.getInterfaceInfo();
            if (interfaceModelList.get(0).getWeatherCity().equals("1")) {
                String str = widgetSetModel.getModuleIds();
                if ("1,".equals(str.substring(0, 2))) {
                    widgetSetModel.setModuleIds(str.substring(2));
                } else {
                    widgetSetModel.setModuleIds(str.replace(",1,", ""));
                }
            }
            List<String> moduleIds = null;
            if (widgetSetModel != null && !StringUtils.checkNull(widgetSetModel.getModuleIds())) {
                moduleIds = Arrays.asList(widgetSetModel.getModuleIds().split(","));
            }

            //对widget权限做控制，没有菜单权限就没有widget
            List<String> strings = Arrays.asList(userFunctionPriv(user.getUid()));
            List<String> off = new ArrayList<>();
            if (moduleIds != null && moduleIds.size() > 0) {

                // 条件集合
                Map<String, Object> maps = new HashMap<String, Object>();
                maps.put("pageParams", pageParams);
                maps.put("fromId", user.getUserId());
                maps.put("userId", user.getUserId());
                maps.put("name", user.getUserId());
                maps.put("userPriv", user.getUserPriv());
                maps.put("deptId", user.getDeptId());
                for (String id : moduleIds) {
                    if (!strings.contains(id)) {
                        continue;
                    }
                    off.add(id);
                    switch (Integer.valueOf(id)) {
                        case WEATHER_ID:
                            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
                            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
                            if (Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())) {
                                // 查询天气信息 cityName
                                if (!StringUtils.checkNull(cityName)) {
                                    WidgetDataModel<OneDayWeatherInf> widgetDataModel = new WidgetDataModel<OneDayWeatherInf>();
                                    OneDayWeatherInf oneDayWeatherInf = null;
                                    try {
                                        WeatherInf weatherInf = WeatherUtil.resolveWeatherInf(cityName, district);
                                        if (weatherInf != null && weatherInf.getWeatherInfs() != null && weatherInf.getWeatherInfs().length != 0) {
                                            oneDayWeatherInf = weatherInf.getWeatherInfs()[0];
                                        } else {
                                            // 06 27根据高总指示 修改为不提供默认天气
                                            oneDayWeatherInf = new OneDayWeatherInf();
                                            oneDayWeatherInf.setAqi("10");
                                        }
                                        if (!StringUtils.checkNull(oneDayWeatherInf.getWeather())) {
                                            String weather = PinYinUtil.getPingYin(oneDayWeatherInf.getWeather());
                                            oneDayWeatherInf.setPicture("/img/weather/" + weather + ".png");
                                        }
                                        // 设置尾号
                                        //setWeiHao(oneDayWeatherInf);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                        WeatherInf weatherInf = new WeatherInf();
                                        oneDayWeatherInf = new OneDayWeatherInf();

                                        weatherInf.setColdAdvise("");
                                        weatherInf.setDressAdvise("");
                                        weatherInf.setWashCarAdvise("");
                                        weatherInf.setSportsAdvise("");
                                        weatherInf.setUltravioletRaysAdvise("");

                                        oneDayWeatherInf.setAqi("10");
                                        OneDayWeatherInf[] oneDayWeatherInfs = new OneDayWeatherInf[1];
                                        oneDayWeatherInfs[0] = oneDayWeatherInf;
                                        weatherInf.setWeatherInfs(oneDayWeatherInfs);
                                    }
                                    widgetDataModel.setData("weather");
                                    if (local.equals("zh_CN")) {
                                        widgetDataModel.setName("天气");
                                    } else if (local.equals("zh_tw")) {
                                        widgetDataModel.setName("天氣");
                                    } else if (local.equals("en_US")) {
                                        widgetDataModel.setName("Weather");
                                    }
                                    List<OneDayWeatherInf> oneDayWeatherInfs = new ArrayList<>();
                                    oneDayWeatherInfs.add(oneDayWeatherInf);
                                    widgetDataModel.setData_info(oneDayWeatherInfs);
                                    dataList.add(widgetDataModel);
                                }
                            }
                            break;
                        case EMAIL_ID:
                            // 查询邮件
                            maps.put("fromId", user.getUserId());
                            String sqlType = "xoa" + (String) request.getSession().getAttribute(
                                    "loginDateSouse");
                            List<EmailBodyModel> emailBodyModels = new ArrayList<EmailBodyModel>();
                            try {
                                ToJson<EmailBodyModel> emailBodyModelToJson = emailService.selectInbox(request, maps, 1, 5, true, sqlType);
                                emailBodyModels = emailBodyModelToJson.getObj();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (emailBodyModels != null) {
                                List<EmailBodyWidgetVO> result = new ArrayList<>();
                                if (emailBodyModels.size() > 0) {
                                    for (EmailBodyModel e : emailBodyModels) {
                                        result.add(JSONObject.parseObject(JSONObject.toJSONString(e), EmailBodyWidgetVO.class));
                                    }
                                }
                                WidgetDataModel<EmailBodyWidgetVO> widgetDataModel = new WidgetDataModel<EmailBodyWidgetVO>();
                                widgetDataModel.setData("email");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("邮件");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("郵件");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("E-mail");
                                }
                                widgetDataModel.setImg("/img/widget/email.png");
                                widgetDataModel.setData_info(result);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case NOTIFY_ID:
                            // 查询公告
                            maps.remove("fromId");
                            List<NotifyWidgetVO> notifyResult = new ArrayList<>();
                            try {
                                ToJson<Notify> json1 = notifyService.selectNotifyManage(maps, 1, 5, true, user.getUserId(), null);
                                for (Notify notify : json1.getObj()) {
                                    notifyResult.add(JSONObject.parseObject(JSONObject.toJSONString(notify), NotifyWidgetVO.class));
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (notifyResult != null) {
                                WidgetDataModel<NotifyWidgetVO> widgetDataModel = new WidgetDataModel<NotifyWidgetVO>();
                                widgetDataModel.setData("notify");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName(bol ? "公告通知" : "公告");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName(bol ? "公告通知" : "公告");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Notice");
                                }
                                widgetDataModel.setImg("/img/widget/notify.png");
                                widgetDataModel.setData_info(notifyResult);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case NEWS_ID:
                            // 查询新闻
                            List<NewsWidgetVO> newsResult = new ArrayList<>();
                            try {
                                ToJson<News> newsToJson = newService.selectNewsManage(maps, 1, 5, true, user.getUserId(), null);
                                for (News news1 : newsToJson.getObj()) {
                                    if (news1.getTop().equals("1")) {
                                        String subject = news1.getTypeName();
                                        news1.setTypeName("[置顶]" + subject);
                                    }
                                    newsResult.add(JSONObject.parseObject(JSONObject.toJSONString(news1), NewsWidgetVO.class));
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (newsResult != null) {
                                WidgetDataModel<NewsWidgetVO> widgetDataModel = new WidgetDataModel<NewsWidgetVO>();
                                widgetDataModel.setData("news");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("新闻");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("新聞");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("News");
                                }
                                widgetDataModel.setImg("/img/widget/news.png");
                                widgetDataModel.setData_info(newsResult);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case DIARY_ID:
                            // 日志
                            maps.put("diaType", "1");
                            List<DiaryWidgetVO> diaryResult = new ArrayList<>();
                            try {
                                List<DiaryModel> diaryList = diaryModelMapper.getDiarySelf(maps);
                                if (diaryList != null && diaryList.size() > 0) {
                                    for (DiaryModel diaryModel : diaryList) {
                                        if (!StringUtils.checkNull(diaryModel.getUserId())) {
                                            Users users = usersMapper.SimplefindUsersByuserId(diaryModel.getUserId());
                                            diaryModel.setUid(users.getUid());
                                            diaryModel.setUserName(users.getUserName());
                                            diaryModel.setAvatar(users.getAvatar());
                                            diaryModel.setSex(users.getSex());
                                        }
                                        diaryResult.add(JSONObject.parseObject(JSONObject.toJSONString(diaryModel), DiaryWidgetVO.class));
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (dataList != null) {
                                WidgetDataModel<DiaryWidgetVO> widgetDataModel = new WidgetDataModel<DiaryWidgetVO>();
                                widgetDataModel.setData("diary");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("日志");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("日誌");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Diary");
                                }
                                widgetDataModel.setImg("/img/widget/diary.png");
                                widgetDataModel.setData_info(diaryResult);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case CALENDAR_ID:
                            // 查询当天日程
                            List<Calendar> calendarList = new ArrayList<Calendar>();
                            List<Calendar> listAll = new ArrayList<Calendar>();
                            try {
                                java.util.Calendar cal = java.util.Calendar.getInstance();
                                cal.set(java.util.Calendar.HOUR_OF_DAY, 0);
                                cal.set(java.util.Calendar.SECOND, 0);
                                cal.set(java.util.Calendar.MINUTE, 0);
                                cal.set(java.util.Calendar.MILLISECOND, 0);
                                int calTime = (int) (cal.getTimeInMillis() / 1000);
                                maps.put("starTime", calTime);
                                calendarList = calendarMapper.getscheduleBycId(maps);
                                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                                SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                Calendar Allcal = new Calendar();
                                List<CalendarAll> list1 = new ArrayList<CalendarAll>();
                                String data = format.format(new Date());
                                for (int j = 0; j < calendarList.size(); j++) {
                                    Calendar calendar = calendarList.get(j);
                                    CalendarAll ca = new CalendarAll();
                                    int cT = calendar.getCalTime();
                                    int eT = calendar.getEndTime();
                                    Long ct = (long) (cT * 1000L);
                                    Long et = (long) (eT * 1000L);
                                    String s = f.format(ct);
                                    String e = f.format(et);
                                    calendar.setStim(s);
                                    calendar.setEtim(e);
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
                                    Users users = usersMapper.findUsersByuserId(calendar.getUserId());
                                    if (users != null) {
                                        ca.setUid(users.getUid());
                                    } else {
                                        ca.setUid(null);
                                    }
                                    list1.add(ca);
                                }
                                Allcal.setCalData(data);
                                Allcal.setCalMessage(list1);
                                listAll.add(Allcal);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            if (calendarList != null) {
                                WidgetDataModel<Calendar> widgetDataModel = new WidgetDataModel<Calendar>();
                                widgetDataModel.setData("calendar");
                                if (local.equals("zh_CN")) {
                                    widgetDataModel.setName("日程");
                                } else if (local.equals("zh_tw")) {
                                    widgetDataModel.setName("日程");
                                } else if (local.equals("en_US")) {
                                    widgetDataModel.setName("Schedule");
                                }
                                widgetDataModel.setImg("/img/widget/calendar.png");
                                widgetDataModel.setData_info(listAll);
                                dataList.add(widgetDataModel);
                            }
                            break;
                        case FLOWRUNPRCS_ID:
                            break;
                        case DOCTMENT_ID:
                            break;

                        case NEWFILE_ID:
                            break;
                        /**
                         * 待阅事项 isRead - 0 待阅 - 1 已阅
                         */
                        case TOBEREAD_ID:
                            break;
                        case XiaoZhuo_ID:
                            break;
                        case PLAN_EXECUTION_ID:
                            break;
                        case PLAN_REVIEW:
                            break;
                    }
                }

            }
            List<WidgetModel> allModel = widgetModuleMapper.getModelByIds(strings);


            widgetSetModel.setData(dataList);
            widgetSetModel.setCount(allModel.size() - off.size());
            json.setObject(widgetSetModel);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：获取widget信息
     * @参数：request
     */
    @Override
    public ToJson<WidgetSetModel> getUserSetByUid(HttpServletRequest request) {
        ToJson<WidgetSetModel> json = new ToJson<WidgetSetModel>();
        try {
            // 获取当前登录用户信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            // 获取当前语言
            String local = getNowLanguage(request);

            List<String> idst = new ArrayList<>();

            // 获取当前登录用户的信息
            WidgetSetModel dataByUid = widgetSetMapper.getWidgetSetByUid(user.getUid());
            //获取有权限的菜单
            List<String> strings = Arrays.asList(userFunctionPriv(user.getUid()));
            for (String s : dataByUid.getModuleIds().split(",")) {
                if (strings.contains(s)) {
                    idst.add(s);
                }
            }

            if (idst.isEmpty()) {
                idst.add("-1");
            }

            // 获取用户正在使用的模块信息
            List<WidgetModel> on_module = widgetModuleMapper.getModelByIds(idst);

            // 获取所有模块信息
            List<WidgetModel> allModel = widgetModuleMapper.getModelByIds(strings);
            // 取差 得到未使用的模块信息
            allModel.removeAll(on_module);

            // 遍历获取得到未启用模块的图片信息
            for (WidgetModel widgetModel : allModel) {
                widgetModel.setAid(null);
                widgetModel.setTid(null);
                widgetModel.setNo(null);
                widgetModel.setIsOn(null);
                widgetModel.setIsSet(null);
                setImg(widgetModel);
                setLanguage(local, widgetModel);
            }
            dataByUid.setOff(allModel);

            // 遍历获取得到已启用的模块信息
            for (WidgetModel widgetModel : on_module) {
                widgetModel.setAid(null);
                widgetModel.setTid(null);
                widgetModel.setNo(null);
                widgetModel.setIsOn(null);
                widgetModel.setIsSet(null);
                setImg(widgetModel);
                setLanguage(local, widgetModel);
            }
            dataByUid.setOn(on_module);


            dataByUid.setId(null);
            dataByUid.setType(null);
            dataByUid.setModuleIds(null);
            json.setObject(dataByUid);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
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

    private void setLanguage(String local, WidgetModel widgetModel) {
        boolean bol = false;
        SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
        if (myproject != null && !StringUtils.checkNull(myproject.getParaValue()) && "dazu".equals(myproject.getParaValue())) {
            bol = true;
        }
        if (widgetModel.getName().equals("天气")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("天氣");
            } else if (local.equals("en_US")) {
                widgetModel.setName("Weather");
            }
        } else if (widgetModel.getName().equals("邮件")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("郵件");
            } else if (local.equals("en_US")) {
                widgetModel.setName("E-mail");
            }
        } else if (widgetModel.getName().equals("公告")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName(bol ? "公告通知" : "公告");
            } else if (local.equals("en_US")) {
                widgetModel.setName("Notice");
            }
        } else if (widgetModel.getName().equals("新闻")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("新聞");
            } else if (local.equals("en_US")) {
                widgetModel.setName("News");
            }
        } else if (widgetModel.getName().equals("日志")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("日誌");
            } else if (local.equals("en_US")) {
                widgetModel.setName("Diary");
            }
        } else if (widgetModel.getName().equals("日程")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("日程");
            } else if (local.equals("en_US")) {
                widgetModel.setName("Schedule");
            }
        } else if (widgetModel.getName().equals("工作流待办")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName(bol ? "工作事項待辦" : "工作流待辦");
            } else if (local.equals("en_US")) {
                widgetModel.setName("Workflow");
            }
        } else if (widgetModel.getName().equals("待办公文")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("待办公文");
            } else if (local.equals("en_US")) {
                widgetModel.setName("officialdocument");
            }
        } else if (widgetModel.getName().equals("最新文件")) {
            if (local.equals("zh_tw")) {
                widgetModel.setName("最新文件");
            } else if (local.equals("en_US")) {
                widgetModel.setName("newDocument");
            }
        }
    }


    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：widget编辑后的保存
     * @参数：
     */
    @Override
    public ToJson<WidgetSetModel> editWidgetSetModel(HttpServletRequest request, WidgetSetModel widgetSetModel) {
        ToJson<WidgetSetModel> json = new ToJson<WidgetSetModel>();
        try {
            // 获取当前登录用户信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            widgetSetModel.setUid(user.getUid());
            widgetSetMapper.updateWidgetSet(widgetSetModel);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<WidgetModel> selAllWidgetModel() {
        ToJson<WidgetModel> json = new ToJson<>();
        List<WidgetModel> allModel = widgetModuleMapper.getAllModel();
        json.setObj(allModel);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<WidgetSetModel> updateAllWidgetSet(WidgetSetModel widgetSetModel) {
        ToJson<WidgetSetModel> json = new ToJson<>(1, "err");
        try {

            //全部关闭
            widgetModuleMapper.updateWidgetIsOnByIds("0", null);
            //根据传值开启
            widgetModuleMapper.updateWidgetIsOnByIds("1", widgetSetModel.getModuleIds().split(","));
            int i = widgetSetMapper.updateAllWidgetSet(widgetSetModel);
            if (i > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    // ID 常量
    private final static int WEATHER_ID = 1;
    private final static int CALENDAR_ID = 2;
    private final static int DIARY_ID = 3;
    private final static int EMAIL_ID = 4;
    private final static int NOTIFY_ID = 5;
    private final static int FLOWRUNPRCS_ID = 6;
    private final static int NEWS_ID = 7;
    private final static int DOCTMENT_ID = 8;
    private final static int TOBEREAD_ID = 9;
    private final static int XiaoZhuo_ID = 10;
    private final static int NEWFILE_ID = 11;
    private final static int PLAN_EXECUTION_ID = 12;
    private final static int PLAN_REVIEW = 13;

    // 设置图片信息
    private static void setImg(WidgetModel widgetModel) {
        switch (widgetModel.getId()) {
            case WEATHER_ID:
                widgetModel.setImg("/img/widget/weather.png");
                break;
            case CALENDAR_ID:
                widgetModel.setImg("/img/widget/calendar.png");
                break;
            case DIARY_ID:
                widgetModel.setImg("/img/widget/diary.png");
                break;
            case EMAIL_ID:
                widgetModel.setImg("/img/widget/email.png");
                break;
            case NOTIFY_ID:
                widgetModel.setImg("/img/widget/notify.png");
                break;
            case FLOWRUNPRCS_ID:
                widgetModel.setImg("/img/widget/flowRunPrcs.png");
                break;
            case NEWS_ID:
                widgetModel.setImg("/img/widget/news.png");
                break;
            case DOCTMENT_ID:
                widgetModel.setImg("/img/widget/doctment.png");
                break;
            case XiaoZhuo_ID:
                widgetModel.setImg("/img/widget/XiaoZhuoLogo.png");
                break;
            case PLAN_EXECUTION_ID:
                widgetModel.setImg("/img/widget/doctment.png");
                break;

        }
    }

    /**
     * @作者 廉立深
     * @日期 2021/2/20
     * @说明 根据uId获取 WidgetId
     **/
    private String[] userFunctionPriv(Integer uId) {
        List<String> returnList = new ArrayList<>();
        returnList.add("1"); // 天气
        returnList.add("10"); // 小卓
        String[] split = userFunctionService.getUserFunctionStrById(uId).split(",");
        for (String fId : split) {
            switch (fId) {
                case "8":
                    returnList.add("2"); //日程
                    break;
                case "9":
                    returnList.add("3"); //日志
                    break;
                case "1":
                    returnList.add("4"); //邮件
                    break;
                case "4":
                    returnList.add("5"); //公告
                    break;
                case "5":
                    returnList.add("6"); //工作流待办
                    break;
                case "147":
                    returnList.add("7"); //新闻
                    break;
                case "3001":
                case "3006":
                    returnList.add("8"); //公文
                    returnList.add("11"); //最新文件
                    break;
                case "3032":
                    returnList.add("9"); //待阅
                    break;
                /*case "8":
                    returnList.add("12"); //计划填报
                    break;*/
            }
        }
        return returnList.toArray(new String[returnList.size()]);
    }

    // 设置尾号
    /*private void setWeiHao(OneDayWeatherInf oneDayWeatherInf) {
        oneDayWeatherInf.setWeihao("");
        if(!StringUtils.checkNull(oneDayWeatherInf.getLocation())){
            String cityName = oneDayWeatherInf.getLocation().replace("市","");
            if(!StringUtils.checkNull(oneDayWeatherInf.getCityName())){
                cityName = oneDayWeatherInf.getCityName().replace("市","");
            }
            if(WeatherUtil.xianHaoCityMap.get(cityName)!=null){
                TodayCarNo todayCarNo = todayCarNoMapper.selByCityAndDate(cityName, DateFormat.getDatestr(new Date()));
                if(todayCarNo!=null){
                    oneDayWeatherInf.setWeihao(todayCarNo.getRestrictionNum());
                } else {
                    todayCarNo = WeatherUtil.getWeiHaoInform(cityName);
                    if(todayCarNo!=null){
                        todayCarNoMapper.insertSelective(todayCarNo);
                        oneDayWeatherInf.setWeihao(todayCarNo.getRestrictionNum());
                    }
                }
            }
        }

    }*/


}
