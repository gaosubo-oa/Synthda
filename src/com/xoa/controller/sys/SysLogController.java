package com.xoa.controller.sys;


import com.xoa.model.common.SysCode;
import com.xoa.model.common.Syslog;
import com.xoa.model.users.Users;
import com.xoa.service.common.SysCodeService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/25 20:15
 * @类介绍: 系统日志
 * @构造参数: 无
 **/

@Controller
@RequestMapping("/sys")
public class SysLogController {
    @Resource
    private SysLogService sysLogService;
    @Resource
    private SysCodeService sysCodeService;

    @Resource
    private UsersService userService;

    /**
     * @创建作者: 王曰岂
     * @创建日期: 2017/5/31 14:57
     * @函数介绍: 无
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    @RequestMapping("/journal")
    public String journal(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        return "app/sys/journal";
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/27 9:58
     * @函数介绍: 查询日志概况
     * @参数说明: @param request
     * @return: Json
     **/
    @ResponseBody
    @RequestMapping(value = "/getLogMessage", produces = {"application/json;charset=UTF-8"})
    public ToJson<Map> getLogMessage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Map> tojson = new ToJson<Map>(0, "");
        HashMap<String, Long> logMap = new HashMap<String, Long>();

        try {
            sysLogService.getLogMessage(logMap);
            if (logMap.size() == 6) {
                tojson.setMsg("ok");
                tojson.setFlag(0);
                tojson.setObject(logMap);
            }
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }

        return tojson;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/26 10:09
     * @函数介绍: 查询最近的10条日志
     * @参数说明: @param request HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getTenLog", produces = {"application/json;charset=UTF-8"})
    public ToJson<Syslog> getTenLog(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Syslog> tojson = new ToJson<Syslog>(0, "");
        try {

            List<Syslog> list = sysLogService.getTenLog();
            tojson.setObject(list);
            tojson.setMsg("ok");
            tojson.setFlag(0);
        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
        return tojson;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/27 12:45
     * @函数介绍: 统计每月/每天日志记录
     * @参数说明: @param String year
     * @参数说明: @param String month
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getEachMouthLogData", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> getEachMouthLogData(String year, String month, HttpServletRequest request,HttpServletResponse response,Integer export) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> tojson = new ToJson<Object>(0, "");
        //ArrayList<Object> monthDayData = new ArrayList<Object>();

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<Object> monthDataList = sysLogService.getEachMouthLogData(year);
            List<Object> dayDataList = sysLogService.getEachDayLogData(year, month);
            map.put("monthData", monthDataList);
            map.put("dayData", dayDataList);
       if (export!=null&&export==1){
           HSSFWorkbook hssfWorkbook=new HSSFWorkbook();
           List<List> lists=new ArrayList<>();

           List<List> lists1=new ArrayList<>();
           String description=year+"年度按月访问数据";
           String description1=month+"月份按日访问数据";
           List<String> strings = Arrays.asList("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月");
           List<String> strings1 = Arrays.asList("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31");
           List<String> strings2 = strings.subList(0,((List) monthDataList.get(1)).size());
           lists.add(strings2);
           lists.add((List) monthDataList.get(1));
           lists.add((List) monthDataList.get(0));

           List<String> strings3 = strings1.subList(0,((List) dayDataList.get(1)).size());
           lists1.add(strings3);
           lists1.add((List) dayDataList.get(1));
           lists1.add((List) dayDataList.get(0));
           try {
               hssfWorkbook=ExcelUtil.createSheet(hssfWorkbook,description, new String[]{"单位/月", "百分比","访问数"},lists);
               hssfWorkbook=ExcelUtil.createSheet(hssfWorkbook,description1,new String[]{"单位/日", "百分比","访问数"},lists1);
               ServletOutputStream out = response.getOutputStream();
               String filename = "年度数据.xls";
               filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
               response.setContentType("application/vnd.ms-excel;charset=UTF-8");
               response.setHeader("content-disposition", "attachment;filename=" + filename);
               hssfWorkbook.write(out);
               out.close();
           } catch (Exception e) {
               e.printStackTrace();
           }
       }
            tojson.setObject(map);
            tojson.setMsg("OK");
            tojson.setFlag(0);
        } catch (ClassCastException e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
        return tojson;

    }



    /**
     * @创建作者: 张丽军
     * @创建日期: 2019/4/16 16:45
     * @函数介绍: 统计每月/每周用户活跃数
     * @参数说明: @param String year
     * @参数说明: @param String month
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getEachMouthDay", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> getEachMouthDay( HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> tojson = new ToJson<Object>(0, "");

        Map<String, Object> map = new HashMap<String, Object>();
        try {
            double monthUsers = sysLogService.getEachMouth();
            int daysUsers = sysLogService.getEachDay();
            double dateUsers = sysLogService.getEachDate(monthUsers);
            map.put("monthUsers", monthUsers);
            map.put("daysUsers", daysUsers);
            map.put("dateUsers", dateUsers);

            tojson.setObject(map);
            tojson.setMsg("OK");
            tojson.setFlag(0);
        } catch (ClassCastException e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }
        return tojson;

    }





    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/27 10:40
     * @函数介绍: 获取记录日志的年（前端要判断是否开始结束都是一年）
     * @参数说明: @param HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getYear", produces = {"application/json;charset=UTF-8"})
    public ToJson<Integer> getYear(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Integer> tojson = new ToJson<Integer>(0, "");
        try {
            List<Integer> yearList = sysLogService.getYear();

            tojson.setObj(yearList);
            tojson.setMsg("ok");
            tojson.setFlag(0);

        } catch (Exception e) {
            tojson.setFlag(1);
            tojson.setMsg("err");
        }

        return tojson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/27 11:03
     * @函数介绍: 获取月份
     * @参数说明: @param HttpServletRequest String
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getMonth", produces = {"application/json;charset=UTF-8"})
    public ToJson<Integer> getMonth(HttpServletRequest request, String year) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Integer> toJson = new ToJson<Integer>(0, "");
        try {
            Integer endMonth = sysLogService.getMonth(year);
            toJson.setMsg("OK");
            toJson.setFlag(0);
            toJson.setObject(endMonth);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 9:47
     * @函数介绍: 时段统计
     * @参数说明: @param HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getHourLog", produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> getHourLog(HttpServletRequest request,Integer export,HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        List<Object> hourDataList = new ArrayList<Object>();

        ToJson<Object> toJson = new ToJson<Object>(0, "");
        try {
            hourDataList = sysLogService.getHourLog();
            if (export!=null&&export==1){
                HSSFWorkbook hssfWorkbook=new HSSFWorkbook();
                List<List> lists=new ArrayList<>();
                List<String> strings = Arrays.asList("0","1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23");
                List<String> strings1 = strings.subList(0,((List) hourDataList.get(1)).size());
                lists.add(strings1);
                lists.add((List) hourDataList.get(1));
                lists.add((List) hourDataList.get(0));
                try {
                    hssfWorkbook=ExcelUtil.createSheet(hssfWorkbook,"总访问量小时分布数据", new String[]{"单位/时", "百分比","访问数"},lists);
                    ServletOutputStream out = response.getOutputStream();
                    String filename = "时段统计.xls";
                    filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                    response.setHeader("content-disposition", "attachment;filename=" + filename);
                    hssfWorkbook.write(out);
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            toJson.setMsg("OK");
            toJson.setFlag(0);
            toJson.setObj(hourDataList);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 9:48
     * @函数介绍: 获取日志所有类型
     * @参数说明: @param HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getLogType", produces = {"application/json;charset=UTF-8"})
    public ToJson<SysCode> getLogType(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<SysCode> toJson = new ToJson<SysCode>(0, "");

        try {
            List<SysCode> logTypeList = sysCodeService.getLogType();
            toJson.setMsg("OK");
            toJson.setFlag(0);
            toJson.setObj(logTypeList);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 9:49
     * @函数介绍: 日志管理
     * param type      日志类型id
     * param uid       多个用户的id数组
     * param startTime 日志开始时间
     * param endTime   日志结束时间
     * param syslog    属性中的ip,备注
     * param request
     * return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/logManage", produces = {"application/json;charset=UTF-8"})
    public ToJson<Syslog> findLogManage(HttpServletRequest request,
                                        @RequestParam(value = "sum", required = false) Integer sum,
                                        @RequestParam(value = "type", required = false) Integer type,
                                        @RequestParam(value = "uid", required = false) String uid,
                                        @RequestParam(value = "ip", required = false) String ip,
                                        @RequestParam(value = "remark", required = false) String remark,
                                        @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "startTime", required = false) String startTime,
                                        @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "endTime", required = false) String endTime
    ) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Syslog> toJson = new ToJson<Syslog>(0, "");
        //查询成功
        List<Syslog> syslogList;
        try {
            Syslog syslog=new Syslog();
            if (!StringUtils.checkNull(remark)){
                syslog.setRemark(remark);
            }
            if (!StringUtils.checkNull(ip)){
                syslog.setIp(ip);
            }
            syslogList = sysLogService.logManage(type, uid, startTime, endTime, syslog);
            List<Syslog> syslogList1 = new ArrayList<Syslog>();

            if(sum!=null && sum < 2000 ){
                int s = sum <= syslogList.size() ?  sum: syslogList.size();
                for (int i = 0; i < s; i++) {
                    syslogList1.add(syslogList.get(i));
                }
                toJson.setObj(syslogList1);
            } else {
                toJson.setObj(syslogList);
            }
            toJson.setMsg("OK");
            toJson.setFlag(0);

        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 10:36
     * @函数介绍: 删除日志
     * param type      日志类型id
     * param uid       多个用户的id数组
     * param startTime 日志开始时间
     * param endTime   日志结束时间
     * param syslog    属性中的ip,备注
     * param request
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/deleteSyslog", produces = {"application/json;charset=UTF-8"})
    public ToJson<Syslog> deleteSyslog(HttpServletRequest request,
                                       @RequestParam(value = "type", required = false) Integer type,
                                       @RequestParam(value = "uid", required = false) String uid,
                                       @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "startTime", required = false) Date startTime,
                                       @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "endTime", required = false) Date endTime,
                                       @RequestParam(value = "syslog", required = false) Syslog syslog) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Syslog> toJson = new ToJson<Syslog>(0, "");

        try {
            sysLogService.deleteSyslog(type, uid, startTime, endTime, syslog);
            toJson.setMsg("OK");
            toJson.setFlag(0);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 10:36
     * @函数介绍: 导出日志
     * param type      日志类型id
     * param uid       多个用户的id数组
     * param startTime 日志开始时间
     * param endTime   日志结束时间
     * param syslog    属性中的ip,备注
     * param request
     * @return: json
     **/
    @RequestMapping(value = "/exportLogXls", produces = {"application/json;charset=UTF-8"})
    public String exportLogXls(HttpServletRequest request, HttpServletResponse response,
                               @RequestParam(value = "type", required = false) Integer type,
                               @RequestParam(value = "uid", required = false) String uid,
                               @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "startTime", required = false) String startTime,
                               @DateTimeFormat(pattern = "yyyy-MM-dd hh:mm:ss") @RequestParam(value = "endTime", required = false) String endTime,
                               @RequestParam(value = "syslog", required = false) Syslog syslog) throws Exception {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        // 查询所有的分区数据
        List<Syslog> syslogList = sysLogService.logManage(type, uid, startTime, endTime, syslog);
        // 将list集合中的数据写到一个Excel文件中
        HSSFWorkbook workbook = new HSSFWorkbook();// 创建一个Excel文件，当前这个文件在内存中
        HSSFSheet sheet = workbook.createSheet("日志数据");// 创建一个sheet页
        HSSFRow headRow = sheet.createRow(0);// 创建标题行
        headRow.createCell(0).setCellValue("用户姓名");
        headRow.createCell(1).setCellValue("时间");
        headRow.createCell(2).setCellValue("IP地址");
        headRow.createCell(3).setCellValue("ip所在地");
        headRow.createCell(4).setCellValue("日志类型");
        headRow.createCell(5).setCellValue("备注");

        for (Syslog log : syslogList) {// 循环list，将数据写到Excel文件中
            HSSFRow dataRow = sheet.createRow(sheet.getLastRowNum() + 1);

            //根据用户的id找的用户的name，每条数据都要查询一次，
            // 以后可以把user的id和name匹配到一个map，每次遍历匹配，来优化
            String userName = userService.getUserNameById(log.getUserId());
            dataRow.createCell(0).setCellValue(userName);

            SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd hh:MM:ss");
            String timeString = sdfTime.format(log.getTime());

            dataRow.createCell(1).setCellValue(timeString);

            dataRow.createCell(2).setCellValue(log.getIp());
            dataRow.createCell(3).setCellValue(log.getIpLocation());
            dataRow.createCell(4).setCellValue(log.getTypeName());
            dataRow.createCell(5).setCellValue(log.getRemark());

        }

        // 文件下载：一个流（输出流）、两个头
        ServletOutputStream out = response.getOutputStream();

        String filename = "系统日志.xls";
        filename = FileUtils.encodeDownloadFilename(filename,
                request.getHeader("user-agent"));
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("content-disposition",
                "attachment;filename=" + filename);
        workbook.write(out);

        return null;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 19:23
     * @函数介绍: 根据多个id, (id之间用逗号分隔, 删除日志)
     * @参数说明: @param ids
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/deleteLogByIds")
    public ToJson<Object> deleteLogByIds(HttpServletRequest request, String ids) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> toJson = new ToJson<Object>(0, "");

        try {
            sysLogService.deleteLogByIds(ids);
            toJson.setMsg("OK");
            toJson.setFlag(0);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;

    }

    @RequestMapping(value = "/deleteAllLog")
    public ToJson<Object> deleteAllLog(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Object> toJson = new ToJson<Object>(0, "");
        try {
            sysLogService.deleteAllLog();
            toJson.setMsg("OK");
            toJson.setFlag(0);
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/6 10:50
     * @函数介绍: 获取某账号的登录日志
     * @参数说明: @param request
     * @return: void
     **/
    @ResponseBody
    @RequestMapping(value = "/getUserLoginLogs", produces = {"application/json;charset=UTF-8"})
    public ToJson<Syslog> getCountLoginLogs(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Syslog> json = new ToJson<Syslog>(0, null);

        try {

            List<Syslog> syslogList = sysLogService.getUserLoginLogs(request);
            json.setFlag(0);
            json.setMsg("ok");
            json.setObj(syslogList);
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/12 16:57
     * @函数介绍: 查询最近用户批量设置日志（10条）
     * @参数说明: @param request
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getTenBatchSetLog")
    public ToJson<Syslog> getTenBatchSetLog(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Syslog> json = new ToJson<Syslog>(0, null);
        List<Syslog> sysLogList = null;
        try {

            sysLogList = sysLogService.getTenBatchSetLog();
            for (Syslog s:sysLogList) {
                Users usersByuserId = userService.findUsersByuserId(s.getUserId());
                s.setUserName(usersByuserId.getUserName());
                s.setTypeName(sysCodeService.getLogNameByNo("19"));
            }
            json.setFlag(0);
            json.setMsg("ok");
            json.setObj(sysLogList);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }

        return json;
    }

    /**
     * @创建作者: 牛江丽
     * @创建日期: 2017/8/28 15:40
     * @函数介绍: 获取修改登录密码的日志
     * @参数说明: @param request
     * @return: void
     **/
    @ResponseBody
    @RequestMapping(value = "/getModifyPwdLog", produces = {"application/json;charset=UTF-8"})
    public ToJson<Syslog> getModifyPwdLog(HttpServletRequest request) {
       return sysLogService.getModifyPwdLog(request);
    }

    // 获取升级脚本log列表
    @ResponseBody
    @RequestMapping("getVersionLogs")
    public ToJson<Map<String,Object>> getVersionLogs(){
        return sysLogService.getVersionLogs();
    }

    // 下载升级脚本log列表
    @ResponseBody
    @RequestMapping("downloadVersionLog")
    public String downloadVersionLog(HttpServletRequest request,HttpServletResponse response,String fileName){

        String sqlType = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        if(fileName.contains("..")){
            return null;
        }

        StringBuilder path = FileUploadUtil.getUploadHead().append(System.getProperty("file.separator")).
                append(sqlType).append(System.getProperty("file.separator")).
                append("versionSqlLog").append(System.getProperty("file.separator")).append(fileName);

        try {
            response.setHeader("Content-disposition",
                    String.format("attachment; filename=\"%s\"", fileName));
            InputStream inputStream = null;
            OutputStream os = null;
            File file = null;
            try {
                boolean bol = false;
                file = new File(path.toString());
                // 如果文件不存在
                if (!file.exists()) {
                    file = new File(path + ".xoafile");
                    bol = true;
                    if (!file.exists()) {
                        request.setAttribute("message", Constant.exesit);
                        return Constant.exesit.toString();
                    }
                }
                os = response.getOutputStream();
                if (bol) {
                    byte[] abc = AESUtil.download(file, sqlType, bol);
                    os.write(abc, 0, abc.length);
                } else {
                    inputStream = new FileInputStream(file);
                    byte[] b = new byte[2048];
                    int length;
                    while ((length = inputStream.read(b)) > 0) {
                        os.write(b, 0, length);
                    }
                }
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } finally {
                // 这里主要关闭。
                if (os != null) {
                    os.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return null;
    }



}




