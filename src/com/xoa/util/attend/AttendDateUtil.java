package com.xoa.util.attend;

import com.xoa.util.DateFormat;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class AttendDateUtil {
    /**
     * 获取日期所属月份的所有日期
     */
    public static List<String> getMonthMaxDay(String date) {
        Integer year = Integer.valueOf(date.substring(0, 4));
        Integer month = Integer.valueOf(date.substring(5, 7));
        List<String> fullDayList = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        cal.clear();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        int count = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int j = 1; j <= count; j++) {
            fullDayList.add(DateFormat.getDatestr(cal.getTime()));
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return fullDayList;
    }

    /**
     * 获取日期所属月份的所有日期
     */
    public static List<Date> getMonthDateMaxDay(String date) {
        Integer year = Integer.valueOf(date.substring(0, 4));
        Integer month = Integer.valueOf(date.substring(5, 7));
        List<Date> fullDayList = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        cal.clear();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        int count = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int j = 1; j <= count; j++) {
            fullDayList.add(cal.getTime());
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return fullDayList;
    }


    /**
     * 获取当前日期日期所属月份的日期  1号  截止今日
     */
    public static List<String> getMonthMaxDay() {
        List<String> fullDayList = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        int count = cal.get(Calendar.DATE);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        for (int j = 1; j <= count; j++) {
            fullDayList.add(DateFormat.getDatestr(cal.getTime()));
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return fullDayList;
    }

    /**
     * 获取当前日期日期所属月份的日期  1号  截止今日
     */
    public static List<Date> getMonthDateMaxDay() {
        List<Date> fullDayList = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        int count = cal.get(Calendar.DATE);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        for (int j = 1; j <= count; j++) {
            fullDayList.add(cal.getTime());
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }
        return fullDayList;
    }


    /**
     * 获取两个日期之间的所有日期(包含开始结束)
     */
    public static List<String> getDays(String startTime, String endTime) {
        // 返回的日期集合
        List<String> days = new ArrayList<String>();
        Date start = DateFormat.DateToStr(startTime);
        Date end = DateFormat.DateToStr(endTime);

        Calendar tempStart = Calendar.getInstance();
        tempStart.setTime(start);

        Calendar tempEnd = Calendar.getInstance();
        tempEnd.setTime(end);
        tempEnd.add(Calendar.DATE, +1);// 日期加1(包含结束)
        while (tempStart.before(tempEnd)) {
            days.add(DateFormat.getDatestr(tempStart.getTime()));
            tempStart.add(Calendar.DAY_OF_YEAR, 1);
        }
        return days;
    }

    /**
     * 获取两个日期之间的所有日期(包含开始结束)
     */
    public static List<Date> getDateDays(String startTime, String endTime) {
        // 返回的日期集合
        List<Date> days = new ArrayList<Date>();
        Date start = DateFormat.DateToStr(startTime);
        Date end = DateFormat.DateToStr(endTime);

        Calendar tempStart = Calendar.getInstance();
        tempStart.setTime(start);

        Calendar tempEnd = Calendar.getInstance();
        tempEnd.setTime(end);
        tempEnd.add(Calendar.DATE, +1);// 日期加1(包含结束)
        while (tempStart.before(tempEnd)) {
            days.add(tempStart.getTime());
            tempStart.add(Calendar.DAY_OF_YEAR, 1);
        }
        return days;
    }

    /**
     * 获取两个日期之间的所有日期(包含开始结束)
     */
    public static List<String> getDays(Date startTime, Date endTime) {
        // 返回的日期集合
        List<String> days = new ArrayList<String>();
        Calendar tempStart = Calendar.getInstance();
        tempStart.setTime(startTime);

        Calendar tempEnd = Calendar.getInstance();
        tempEnd.setTime(endTime);
        tempEnd.add(Calendar.DATE, +1);// 日期加1(包含结束)
        while (tempStart.before(tempEnd)) {
            days.add(DateFormat.getDatestr(tempStart.getTime()));
            tempStart.add(Calendar.DAY_OF_YEAR, 1);
        }
        return days;
    }

    /**
     * 将秒转换成时间格式 时分秒
     */
    public static String secToTime(int secondAll) {
        if (secondAll != 0) {
            Integer hour = 0;//时
            Integer minute = 0;//分
            Integer second = 0;//秒
            //先获取秒
            second = secondAll % 60;
            //获取总分钟
            Integer minuteAll = (secondAll - second) / 60;
            //获取小时
            hour = minuteAll / 60;
            //获取分钟
            minute = minuteAll % 60;
            String time = hour + "小时" + minute + "分钟" + second + "秒";
            return time;
        }
        return "0小时0分0秒";
    }


    /**
     * 获取2个时间之间的总秒数
     */
    public static Integer getSecond(String startDate, String startEnd) {
        if (startDate.contains(":") && startEnd.contains(":")) {
            String[] start = startDate.split(":");
            String[] end = startEnd.split(":");
            if (start.length == 3 && end.length == 3) {
                Integer startSecond1 = Integer.parseInt(start[0]) * 60 * 60;
                Integer startSecond2 = Integer.parseInt(start[1]) * 60;
                Integer startSecond3 = Integer.parseInt(start[2]);
                Integer endSecond1 = Integer.parseInt(end[0]) * 60 * 60;
                Integer endSecond2 = Integer.parseInt(end[1]) * 60;
                Integer endSecond3 = Integer.parseInt(end[2]);
                Integer seconde = ((endSecond1 + endSecond2 + endSecond3) - (startSecond1 + startSecond2 + startSecond3));
                return seconde;
            }
        }
        return 0;
    }

    /**
     * 获取日期对应的星期
     */
    public static int getWeekByData(String date) {
        try {
            Calendar calendar = Calendar.getInstance();
            Date date1 = DateFormat.getDates(date);
            calendar.setTime(date1);
            int i = calendar.get(Calendar.DAY_OF_WEEK);
            if (i == 1) {
                return 7;
            } else {
                return i - 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取当前时间后一天
     */
    public static Date getNextDate(Date date){
        Date beginDate=DateFormat.getDates(DateFormat.getDatestr(new Date()));
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(beginDate);
        calendar.add(calendar.DATE,1);
        beginDate=calendar.getTime();
        beginDate =  date.getTime() >= beginDate.getTime() ? date : beginDate;
        return beginDate;
    }
    /**
     * 获取当前时间后一天
     */
    public static Date getNextDate(){
        Date beginDate=DateFormat.getDates(DateFormat.getDatestr(new Date()));
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(beginDate);
        calendar.add(calendar.DATE,1);
        return beginDate;
    }

    /**
     * 计算两个时间类型的差值(返回秒)
     */
    public static Integer computationTime(String startTime,String endTime,String pattern){
        Integer result = 0;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        try {
            Date startDate = simpleDateFormat.parse(startTime);
            long startLong = startDate.getTime();

            Date endDate = simpleDateFormat.parse(endTime);
            long endLong = endDate.getTime();
            result = Math.toIntExact((endLong - startLong) / 1000);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return result;
    }
    /**
     * 计算当前时间是否在两个时间段内(HH:mm:ss)
     */
    public static boolean CalTimeRange(String startTime,String endTime){
       Date date = new Date();
       String NowDateYmd = DateFormat.getDatestr(date);
        Date startDate = DateFormat.getDate(NowDateYmd + " " + startTime);
        Date endDate = DateFormat.getDate(NowDateYmd + " " + endTime);
        return date.after(startDate) && date.before(endDate);
    }
}
