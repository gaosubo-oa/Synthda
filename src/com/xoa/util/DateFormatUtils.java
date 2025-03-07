package com.xoa.util;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by gyf on 2018/6/14.
 */
public class DateFormatUtils {
    private static final String date_format = "yyyy-MM-dd HH:mm:ss";
    private static ThreadLocal<DateFormat> threadLocal = new ThreadLocal<DateFormat>();

    public static DateFormat getDateFormat()
    {
        DateFormat df = threadLocal.get();
        if(df==null){
            df = new SimpleDateFormat(date_format);
            threadLocal.set(df);
        }
        return df;
    }

    public static String formatDate(Date date) throws ParseException {
        return getDateFormat().format(date);
    }

    public static Date parse(String strDate) throws ParseException {
        return getDateFormat().parse(strDate);
    }
    public static Integer getNowDateTime(String time) throws ParseException {
              String re_time = null;
              Date parse = getDateFormat().parse(time);
            long l = parse.getTime();
            String str = String.valueOf(l);
            re_time = str.substring(0, 10);
        return Integer.parseInt(re_time);
    }

    /*
     * 创建作者:   廉立深
     * 创建日期:   11:22 2019/11/5
     * 方法介绍:  判断time是否在from，to之间
     * 参数说明:   [time:时间, from:开始时间, to:结束时间]
     * @return     boolean
     */
    public static boolean belongCalendar(Date time, Date from, Date to) {
        Calendar date = Calendar.getInstance();
        date.setTime(time);

        Calendar after = Calendar.getInstance();
        after.setTime(from);

        Calendar before = Calendar.getInstance();
        before.setTime(to);

        if (date.after(after) && date.before(before)) {
            return true;
        } else {
            return false;
        }
    }
}