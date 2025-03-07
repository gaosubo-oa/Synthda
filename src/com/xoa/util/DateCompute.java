package com.xoa.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by gsb on 2017/6/27.
 */
public class DateCompute {
    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-6-26 下午7:05:44
     * 方法介绍:   根据当前日期获取星期几
     * 参数说明:   @param dt
     * 参数说明:   @return
     *
     * @return String
     */
    public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        //若一周第一天为星期天，则-1
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        return weekDays[w];
    }

    /**
     * 左春晖
     * 判断当前日期是星期几
     *
     * @param
     * @return dayForWeek 判断结果
     * @Exception 发生异常
     */
    public static String dateToWeek(String datetime) {
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance(); // 获得一个日历
        Date datet = null;
        try {
            datet = f.parse(datetime);
            cal.setTime(datet);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1; // 指示一个星期中的某天。
        if (w < 0)
            w = 0;
        return weekDays[w];
    }

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-6-27 下午2:20:25
     * 方法介绍:   获取两个日期之间的所有日期（yyyy-MM-dd）
     * 注释部分：这里是获取两个日期之间的所有日期（不包涵start和end）
     * 参数说明:   @param start
     * 参数说明:   @param end
     * 参数说明:   @return
     *
     * @return List<Date>
     */
    public static List<Date> getBetweenDates(Date start, Date end) {
        List<Date> result = new ArrayList<Date>();
        Calendar tempStart = Calendar.getInstance();
        tempStart.setTime(start);
           /* Calendar tempEnd = Calendar.getInstance();
           tempStart.add(Calendar.DAY_OF_YEAR, 1);
           tempEnd.setTime(end);
           while (tempStart.before(tempEnd)) {
               result.add(tempStart.getTime());
               tempStart.add(Calendar.DAY_OF_YEAR, 1);
           }*/
        while (start.getTime() <= end.getTime()) {
            result.add(tempStart.getTime());
            tempStart.add(Calendar.DAY_OF_YEAR, 1);
            start = tempStart.getTime();
        }
        return result;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-12 下午15:19:25
     * 方法介绍:   获取本周日期的区间（周一到周日）
     *
     * @return String
     */
    public static String getWeekInterval() {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        // 判断要计算的日期是否是周日，如果是则减一天计算周六的，否则会出问题，计算到下一周去了
        int dayWeek = cal.get(Calendar.DAY_OF_WEEK);// 获得当前日期是一个星期的第几天
        if (1 == dayWeek) {
            cal.add(Calendar.DAY_OF_MONTH, -1);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        // 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
        cal.setFirstDayOfWeek(Calendar.MONDAY);
        // 获得当前日期是一个星期的第几天
        int day = cal.get(Calendar.DAY_OF_WEEK);
        // 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
        cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
        String imptimeBegin = sdf.format(cal.getTime());
        cal.add(Calendar.DATE, 6);
        String imptimeEnd = sdf.format(cal.getTime());
        return imptimeBegin + "," + imptimeEnd;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-12 下午15:26:25
     * 方法介绍:   获取本月日期的区间
     *
     * @return String
     */
    public static String getMonthInterval() {
        //获取当前月的日期区间
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        Date theDate = calendar.getTime();
        // 上个月第一天
        GregorianCalendar gcLast = (GregorianCalendar) Calendar.getInstance();
        gcLast.setTime(theDate);
        gcLast.set(Calendar.DAY_OF_MONTH, 1);
        String day_first = df.format(gcLast.getTime());
        StringBuffer str = new StringBuffer().append(day_first);
        day_first = str.toString();
        // 上个月最后一天
        calendar.add(Calendar.MONTH, 1); // 加一个月
        calendar.set(Calendar.DATE, 1); // 设置为该月第一天
        calendar.add(Calendar.DATE, -1); // 再减一天即为上个月最后一天
        String day_last = df.format(calendar.getTime());
        StringBuffer endStr = new StringBuffer().append(day_last);
        day_last = endStr.toString();
        return day_first + "," + day_last;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-19 下午11:58:25
     * 方法介绍:   给定一个日期，获取给定日期所在月的第一天和最后一天
     *
     * @return String
     */
    public static String getMonthTime(String datadate) {
        String day_last = null;
        String day_first = null;
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            date = df.parse(datadate);
            //创建日历
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            calendar.add(Calendar.MONTH, 1);    //加一个月
            calendar.set(Calendar.DATE, 1);     //设置为该月第一天
            calendar.add(Calendar.DATE, -1);    //再减一天即为上个月最后一天
            day_last = df.format(calendar.getTime());

            date = df.parse(datadate);
            //创建日历
            calendar.setTime(date);
            calendar.set(Calendar.DAY_OF_MONTH, 1);
            day_first = df.format(calendar.getTime());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return day_first + "," + day_last;
    }


    public static Integer getLastMonthDay(String datadate) throws ParseException {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM");
        Date date1 = df.parse(datadate);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date1);
        int first1 = calendar.getActualMinimum(calendar.DAY_OF_MONTH);    //获取本月最小天数
        int last1 = calendar.getActualMaximum(calendar.DAY_OF_MONTH);    //获取本月最大天数
        return last1;
    }

    /**
     * 左春晖
     * 根据年和月获取这一个月的所有工作日列表
     *
     * @param year  某一个月
     * @param month 某一年
     * @return
     */
    public List<String> getDates(int year, int month) {
        List<String> dates = new ArrayList<String>();

        //获取日历对象
        Calendar cal = Calendar.getInstance();
        //制定年月日
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DATE, 1);


        while (cal.get(Calendar.YEAR) == year && cal.get(Calendar.MONTH) < month) {
            int day = cal.get(Calendar.DAY_OF_WEEK);

            if (!(day == Calendar.SUNDAY || day == Calendar.SATURDAY)) {

                dates.add(new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime().clone()));
            }
            cal.add(Calendar.DATE, 1);
        }
        return dates;

    }

    public static List<String> getDate(int year, int month) {
        List<String> dates = new ArrayList<String>();
        //获取日历对象
        Calendar cal = Calendar.getInstance();
        //制定年月日
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.DATE, 1);
//        int year1 = cal.get(Calendar.YEAR);//年份
//        int month = cal.get(Calendar.MONTH) + 1;//月份
        int day = cal.getActualMaximum(Calendar.DATE);
        for (int i = 1; i <= day; i++) {
            String aDate = String.valueOf(year) + "-" + month + "-" + i;
            dates.add(aDate);
        }
        return dates;
    }

    /**
     * 获取给定月份的所有日期
     *
     * @return
     */

    //该方法是获取当前月的所有日期
    public static List getDayListOfMonth() {
        List list = new ArrayList();
        Calendar aCalendar = Calendar.getInstance();
        int year = aCalendar.get(Calendar.YEAR);//年份
        int month = aCalendar.get(Calendar.MONTH) + 1;//月份
        int day = aCalendar.getActualMaximum(Calendar.DATE);
        for (int i = 1; i <= day; i++) {
            String aDate = String.valueOf(year) + "-" + month + "-" + i;
            list.add(aDate);
        }
        return list;
    }

    /**
     * 计算两个日期的时间差
     *
     * @param nowTime
     * @param workTime
     * @return
     */
    public static int workAge(Date nowTime, Date workTime) {
        int year = 0;
        //当前时间的年月日
        Calendar cal = Calendar.getInstance();
        cal.setTime(nowTime);
        int nowYear = cal.get(Calendar.YEAR);
        int nowMonth = cal.get(Calendar.MONTH);
        int nowDay = cal.get(Calendar.DAY_OF_MONTH);

        //开始工作时间的年月日
        cal.setTime(workTime);
        int workYear = cal.get(Calendar.YEAR);
        int workMonth = cal.get(Calendar.MONTH);
        int workDay = cal.get(Calendar.DAY_OF_MONTH);

        year = nowYear - workYear; //得到年差
        //若目前月数少于开始工作时间的月数，年差-1
        if (nowMonth == workMonth) {
            //当月数相等时，判断日数，若当月的日数小于开始工作时间的日数，年差-1
            if (nowDay > workDay) {
                year = year + 1;
            }
        } else if (nowMonth > workMonth) {
            year = year + 1;
        }
        return year;
    }

    //根据出生日期求出年龄
    public static int getAge(Date birthDay) {
        Calendar cal = Calendar.getInstance();
        if (cal.before(birthDay)) { //出生日期晚于当前时间，无法计算
            throw new IllegalArgumentException(
                    "The birthDay is before Now.It's unbelievable!");
        }
        int yearNow = cal.get(Calendar.YEAR);  //当前年份
        int monthNow = cal.get(Calendar.MONTH);  //当前月份
        int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH); //当前日期
        cal.setTime(birthDay);
        int yearBirth = cal.get(Calendar.YEAR);
        int monthBirth = cal.get(Calendar.MONTH);
        int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);
        int age = yearNow - yearBirth;   //计算整岁数
        if (monthNow <= monthBirth) {
            if (monthNow == monthBirth) {
                if (dayOfMonthNow < dayOfMonthBirth) age--;//当前日期在生日之前，年龄减一
            } else {
                age--;//当前月份在生日之前，年龄减一
            }
        }
        return age;
    }

    /**
     * 将日期信息转换成今天、明天、后天、星期
     *
     * @param date
     * @return
     */
    public static String getDateDetail(String date) {
        Calendar today = Calendar.getInstance();
        Calendar target = Calendar.getInstance();
        SimpleDateFormat df = new SimpleDateFormat(
                "yyyy-MM-dd HH:mm:ss");

        try {
            today.setTime(new Date());
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            target.setTime(df.parse(date));
            int hour = target.get(Calendar.HOUR_OF_DAY);
            int minute = target.get(Calendar.MINUTE);
            date = hour + ":" + (minute < 10 ? ("0" + minute) : (minute + ""));

        /*    target.set(Calendar.HOUR_OF_DAY, 0);
            target.set(Calendar.MINUTE, 0);
            target.set(Calendar.SECOND, 0);*/
        } catch (ParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
        long intervalMilli = target.getTimeInMillis() - today.getTimeInMillis();
        int xcts = (int) (intervalMilli / (24 * 60 * 60 * 1000));
        date = showDateDetail(xcts) == null ? null : showDateDetail(xcts) + date;
        return date;

    }

    /**
     * 将日期差显示为日期或者星期
     *
     * @param xcts
     * @return
     */
    private static String showDateDetail(int xcts) {
        switch (xcts) {
            case 0:
                return TODAY;
            case 1:
                return TOMORROW;
            case 2:
                return AFTER_TOMORROW;
            case -1:
                return YESTERDAY;
            case -2:
                return BEFORE_YESTERDAY;
            default:
                return null;
               /* int dayForWeek = 0;
                dayForWeek = target.get(Calendar.DAY_OF_WEEK);
                switch(dayForWeek){
                    case 1: return SUNDAY;
                    case 2: return MONDAY;
                    case 3: return TUESDAY;
                    case 4: return WEDNESDAY;
                    case 5: return THURSDAY;
                    case 6: return FRIDAY;
                    case 7: return SATURDAY;
                    default:return null;
                }*/

        }
    }


    /**
     * 日期
     */
    public static final String TODAY = "今天";
    public static final String YESTERDAY = "昨天";
    public static final String TOMORROW = "明天";
    public static final String BEFORE_YESTERDAY = "前天";
    public static final String AFTER_TOMORROW = "后天";
/*    public static final String SUNDAY = "星期日";
    public static final String MONDAY = "星期一";
    public static final String TUESDAY = "星期二";
    public static final String WEDNESDAY = "星期三";
    public static final String THURSDAY = "星期四";
    public static final String FRIDAY = "星期五";
    public static final String SATURDAY = "星期六";*/
public static List<String> getMonthBetween(String minDate, String maxDate) throws ParseException {
    ArrayList<String> result = new ArrayList<String>();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");//格式化为年月

    Calendar min = Calendar.getInstance();
    Calendar max = Calendar.getInstance();

    min.setTime(sdf.parse(minDate));
    min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);

    max.setTime(sdf.parse(maxDate));
    max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);

    Calendar curr = min;
    while (curr.before(max)) {
        result.add(sdf.format(curr.getTime()));
        curr.add(Calendar.MONTH, 1);
    }

    return result;
}

}
