package com.xoa.util.quartz;

import com.xoa.util.common.StringUtils;
import org.quartz.CronExpression;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by 刘建 on 2020/7/9 16:51
 * cron 表达式工具类
 */
public class CronExpUtil {

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-12 8:36
     * 方法介绍: 校验 cron 格式是否正确
     *
     * @param cronExpression
     * @return boolean
     */
    public static boolean isValid(String cronExpression) {
        if (StringUtils.checkNull(cronExpression))
            return false;
        return CronExpression.isValidExpression(cronExpression);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-12 8:37
     * 方法介绍: 根据 cron 表达式获取下一次执行时间
     *
     * @param cronExpression
     * @return java.util.Date
     */
    public static Date getNextExecution(String cronExpression) {
        try {
            CronExpression cron = new CronExpression(cronExpression);
            return cron.getNextValidTimeAfter(new Date(System.currentTimeMillis()));
        } catch (ParseException e) {
            throw new IllegalArgumentException(e.getMessage());
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-12 8:43
     * 方法介绍: 生成间隔执行Cron表达式
     *
     * @param num  数值
     * @param unit 单位：s-秒，m-分，h-小时，d-天，mon-月
     * @return java.lang.String
     */
    public static String timeToCronErval(int num, String unit) {
        switch (unit) {
            case "s":
                return "0/" + num + " * * * * ?";
            case "m":
                return "0 0/" + num + " * * * ?";
            case "h":
                return "0 0 0/" + num + " * * ?";
            case "d":
                return "0 0 0 1/" + num + " * ?";
            case "mon":
                return "0 0 0 0 1/" + num + " ?";
            default:
                return "";
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-28 15:49
     * 方法介绍:
     * @param date 时间
     * @param num 间隔（日）
     * @return java.lang.String
     */
    public static String timeDayToCron(Date date, int num) {
        if (date != null) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("ss mm HH");
            String format = simpleDateFormat.format(date);
            return format + " 1/" + num + " * ?";
        } else {
            return "";
        }
    }


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-28 15:47
     * 方法介绍: 按周提醒（第几周的周几提醒）
     *
     * @param day 天
     * @param date 时间
     * @param num  周次（1-7）
     * @return java.lang.String
     */
    public static String timeWeeksToCron(int day,Date date, int num) {
        if (date != null) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("ss mm HH");
            String format = simpleDateFormat.format(date);
            return format + " ? * " + num + "/" + day;
        } else {
            return "";
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-28 15:45
     * 方法介绍:  定点执行按月间隔
     *
     * @param day  日期
     * @param date 时间
     * @param num  间隔（月）
     * @return java.lang.String
     */
    public static String timeMonToCron(Integer day, Date date, int num) {
        if (date != null) {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("ss mm HH");
            String format = simpleDateFormat.format(date);
            return format + " " + day + " 1/" + num + " ?";
        } else {
            return "";
        }
    }


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-12 8:42
     * 方法介绍: 将cronExpression转换成中文
     *
     * @param cronExp
     * @return java.lang.String
     */
    public static String translateToChinese(String cronExp) {
        if (cronExp == null || cronExp.length() < 1) {
            return "cron表达式为空";
        }
        Pattern p = Pattern.compile("\\s+");
        Matcher m = p.matcher(cronExp);
        cronExp = m.replaceAll(" ");
        CronExpression exp = null;

        if (!isValid(cronExp))
            return "corn表达式不正确";
        String[] tmpCorns = cronExp.split(" ");
        StringBuffer sBuffer = new StringBuffer();
        if (tmpCorns.length == 6) {
            //解析月
            if (!tmpCorns[4].equals("*")) {
                sBuffer.append(tmpCorns[4]).append("月");
            } else {
                sBuffer.append("每月");
            }
            //解析周
            if (!tmpCorns[5].equals("*") && !tmpCorns[5].equals("?")) {
                char[] tmpArray = tmpCorns[5].toCharArray();
                for (char tmp : tmpArray) {
                    switch (tmp) {
                        case '1':
                            sBuffer.append("星期天");
                            break;
                        case '2':
                            sBuffer.append("星期一");
                            break;
                        case '3':
                            sBuffer.append("星期二");
                            break;
                        case '4':
                            sBuffer.append("星期三");
                            break;
                        case '5':
                            sBuffer.append("星期四");
                            break;
                        case '6':
                            sBuffer.append("星期五");
                            break;
                        case '7':
                            sBuffer.append("星期六");
                            break;
                        case '-':
                            sBuffer.append("至");
                            break;
                        default:
                            sBuffer.append(tmp);
                            break;
                    }
                }
            }

            //解析日
            if (!tmpCorns[3].equals("?")) {
                if (!tmpCorns[3].equals("*")) {
                    sBuffer.append(tmpCorns[3]).append("日");
                } else {
                    sBuffer.append("每日");
                }
            }

            //解析时
            if (!tmpCorns[2].equals("*")) {
                sBuffer.append(tmpCorns[2]).append("时");
            } else {
                sBuffer.append("每时");
            }

            //解析分
            if (!tmpCorns[1].equals("*")) {
                sBuffer.append(tmpCorns[1]).append("分");
            } else {
                sBuffer.append("每分");
            }

            //解析秒
            if (!tmpCorns[0].equals("*")) {
                sBuffer.append(tmpCorns[0]).append("秒");
            } else {
                sBuffer.append("每秒");
            }
        }

        return sBuffer.toString();

    }

    /**
     * 作者 廉立深
     * 日期 2020/8/26
     * 方法介绍  将时间转为  Cron表达式
     * 参数 [date : 时间]
     * 返回 java.lang.String
     **/
    public static String getCron(Date  date){
        String dateFormat="ss mm HH dd MM ? yyyy";
        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
        String formatTimeStr = null;
        if (date != null ) {
            formatTimeStr = sdf.format(date);
        }
        return formatTimeStr;
    }

}
