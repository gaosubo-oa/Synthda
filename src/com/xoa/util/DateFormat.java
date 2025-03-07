package com.xoa.util;

import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.*;
import java.util.zip.DataFormatException;

/**
 *
 * 创建作者: 张勇 创建日期: 2017-4-20 上午11:13:34 类介绍 : 日期格式化转换 构造参数:
 *
 */
public class DateFormat {
	private static SimpleDateFormat wyq = new SimpleDateFormat(
			"HH:mm:ss");
	private static SimpleDateFormat wyq1 = new SimpleDateFormat(
			"HH:mm:ss");
	private static SimpleDateFormat wyq2 = new SimpleDateFormat(
			"yyyy年MM月dd日");
	private static SimpleDateFormat sdf1 = new SimpleDateFormat(

			"yyyy-MM-dd");

	private static SimpleDateFormat sdf = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat sdf_hour = new SimpleDateFormat("HH:mm");
	private static SimpleDateFormat sdf_mouth = new SimpleDateFormat(
			"MM月dd日 HH:mm");
	private static SimpleDateFormat sdf_year = new SimpleDateFormat(
			"yyyy年MM月dd日 HH:mm");
	private static SimpleDateFormat sdf_week = new SimpleDateFormat(
			"EEEE");

	private static SimpleDateFormat hm = new SimpleDateFormat(
			"HH:mm");
//	private static SimpleDateFormat sdf_get_y_m_d = new SimpleDateFormat(
//			"yyyy-MM-dd");
//
//	private static SimpleDateFormat sdf_year = new SimpleDateFormat(
//			"yyyy年MM月dd日 HH:mm");

	private static final Long THREE_MINUTE_TIME = 1000 * 3 * 60L;
	private static final Long ONE_HOUR_TIME = 1000 * 3600L;
	private static final Long ONE_DAY_TIME = 1000 * 3600 * 24L;
	private static final Long TWO_DAY_TIME = 1000 * 3600 * 24 * 2L;



	/**
	 * 判断时间格式 格式必须为“YYYY-MM-dd”
	 * 2004-2-30 是无效的
	 * 2003-2-29 是无效的
	 * @param sDate
	 * @return
	 */
	public static boolean isLegalDate(String sDate) {
		int legalLen = 10;
		if ((sDate == null) || (sDate.length() != legalLen)) {
			return false;
		}
		try {
			Date date = sdf1.parse(sDate);
			return sDate.equals(sdf1.format(date));
		} catch (Exception e) {
			return false;
		}
	}


	/**
	 * 根据自定义格式，格式化时间
	 * @param formatStr
	 * @param date  Date或 String类型 yyyy-MM-dd HH:mm:ss
	 * @return
	 * @throws DataFormatException
	 */
	public static String getFormatByUse(String formatStr,Object date) throws DataFormatException{
		if(date instanceof String){
			date =DateFormat.getDate((String)date);
		}

		SimpleDateFormat format = new SimpleDateFormat(
				formatStr);
		return format.format(date);
	}


	/**
	 *
	 * 创建作者: 张勇 创建日期: 2017-4-20 上午11:13:34 类介绍 : 字符串转换为时间戳 构造参数: @param time
	 * 需转换时间
	 *
	 * @return: Integer 时间戳
	 *
	 */
	public static Integer getTime(String time) {
		String re_time = null;
		Date d;
		Integer result = 0;
		try {
			if(StringUtils.checkNull(time)||StringUtils.checkNull(time.trim())||time.contains("1970")){
				return result;
			}
			d = sdf.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			re_time = str.substring(0, 10);
			if(!StringUtils.checkNull(re_time)&&Long.parseLong(re_time)>2147483647){
				return result;
			}
			result = Integer.parseInt(re_time);
		} catch (ParseException e) {
			e.printStackTrace();
			return result;
		}
		return result;
	}


	public static Long getTimeLong(String time) {
		String re_time = null;
		Date d;
		try {
			if(StringUtils.checkNull(time)){
				return 0L;
			}
			d = sdf.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			re_time = str.substring(0, 10);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return Long.parseLong(re_time);
	}

	/**
	 * 转换日期为时间戳
	 * @param time
	 * @return
	 */
	public static Integer getDateTime(String time) {
		String re_time = null;
		Date d;
		try {
			if(StringUtils.checkNull(time)){
				return 0;
			}
			d = sdf1.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			re_time = str.substring(0, 10);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(re_time);
	}
	/**
	 * 转换时分秒为时间戳
	 * @param time
	 * @return
	 */
	public static Integer getWYQTime(String time) {
		String re_time = null;
		Date d;
		try {
			if(StringUtils.checkNull(time)){
				return 0;
			}
			d = wyq1.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			re_time = str;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(re_time);
	}



	/**
	 *
	 * 创建作者: 张勇 创建日期: 2017-4-20 上午11:13:34 类介绍 : 将时间戳转为字符串 构造参数: @param time
	 * 需转换时间
	 *
	 * @return: String 时间戳
	 *
	 */
	public static String getStrTime(Integer time) {
		String re_StrTime = null;
		long lcc_time = Long.valueOf(time);
		re_StrTime = sdf.format(new Date(lcc_time * 1000L));
		return re_StrTime;
	}

	public static String getStrTime(Long time) {
		String re_StrTime = null;
		re_StrTime = sdf.format(new Date(time * 1000L));
		return re_StrTime;
	}

	public static String getStrDateTime(Integer time) {
		String re_StrTime = null;
		long lcc_time = Long.valueOf(time);
		re_StrTime = sdf1.format(new Date(lcc_time * 1000L));
		return re_StrTime;
	}

	public static String getStrDateTime(Long time) {
		String re_StrTime = null;
		re_StrTime = sdf1.format(new Date(time * 1000L));
		return re_StrTime;
	}
	/**
	 *
	 * 创建作者: 王曰岐 创建日期: 2017-4-20 上午11:13:34 类介绍 : 将时间戳转为字符串 构造参数: @param time
	 * 将日期转换为时间戳
	 *
	 * @return: String 时间戳
	 *
	 */
	public static String getDateStrTime(Integer time) {
		if(time==null) return null;
		String re_StrTime = null;
		long lcc_time = Long.valueOf(time);
		re_StrTime = sdf.format(new Date(lcc_time * 1000L));
		return re_StrTime;
	}

	public static String getwyqStrTime(Integer time) {
		String re_StrTime = null;
		Long lcc_time =null;
		if (time.toString().length()==13){
			lcc_time = Long.valueOf(time);
		}else{
			lcc_time = Long.valueOf(time * 1000L);
		}
		re_StrTime = wyq1.format(lcc_time);
		return re_StrTime;
	}



	/**
	 *
	 * 创建作者: 张勇 创建日期: 2017-4-20 上午11:13:34 类介绍 : 字符串转换为Date型 构造参数: @param time
	 * 需转换时间
	 *
	 * @return: DateTest date型
	 *
	 */
	public static Date getDate(String time) {
		Date re_time = null;
		try {
			if(StringUtils.checkNull(time)){
				return re_time;
			}
			re_time = sdf.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return re_time;
	}
	public static Date getDates(String time) {
		Date re_time = null;
		try {
			if(StringUtils.checkNull(time)){
				return re_time;
			}
			re_time = sdf1.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return re_time;
	}

	public static Date getDateTimes(String time) {
		Date re_time = null;
		try {
			if(StringUtils.checkNull(time)){
				return re_time;
			}
			re_time = wyq.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return re_time;
	}

	/**
	 *
	 * 创建作者: 张勇 创建日期: 2017-4-20 上午11:13:34 类介绍 : date型转换为String 格式化 构造参数: @param
	 * time 需转换时间
	 *
	 * @return: String 转换为字符串
	 *
	 */
	public static String getStrDate(Date time) {
		String re_StrTime = null;
		re_StrTime = sdf.format(time);
		return re_StrTime;
	}
	/**
	 *
	 * 创建作者:  wyq 创建日期: 2017-4-20 上午11:13:34 类介绍 : date型转换为String 格式化 构造参数: @param
	 * time 需转换时间
	 *
	 * @return: String 转换为字符串
	 *
	 */
	public static String getDatestr(Date time) {
		String re_StrTime = null;
		re_StrTime = sdf1.format(time);
		return re_StrTime;
	}
	/**
	 *
	 * 创建作者:  wyq 创建日期: 2017-4-20 上午11:13:34 类介绍 : date型转换为String 格式化 构造参数: @param
	 * time 需转换时间
	 * 转换成类似（2017年06月01日）
	 * @return: String 转换为字符串
	 *
	 */
	public static String getDatestrTime(Date time) {
		String re_StrTime = null;
		re_StrTime = wyq2.format(time);
		return re_StrTime;
	}

	public static String getDatestrTimes(Date time) {
		String re_StrTime = null;
		re_StrTime = sdf_year.format(time);
		return re_StrTime;
	}

	/**
	 * 转换时分秒
	 * @param time
	 * @return
	 */
	public static String getDatestrSecondTime(Date time) {
		String re_StrTime = null;
		re_StrTime = wyq.format(time);
		return re_StrTime;
	}


	public static Date DateToStr(String str) {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			if(StringUtils.checkNull(str)){
				return date;
			}
			date = format.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}



	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 上午10:24:27 
	 * @方法介绍 格式化时间类
	 * @参数说明 @param obj 时间类型的类 例如 String："2016-12-03 23:11:22" ，DateTest，Integer ,Long 都可以
	 * @参数说明 @return
	 * @return
	 */
	public static String getProbablyDate(Object obj){
		if(obj==null) return null;
		Date nowDate=	new Date();
		Long nowTime = nowDate.getTime();
		Long formatTime =null;
		if (obj instanceof String) {
			//String 转成 DateTest
			String dateStr = (String) obj;

			formatTime = getDate(dateStr).getTime();
		}
		if (obj instanceof Date) {
			//不用转了
			Date date = (Date) obj;
			formatTime=date.getTime();

		}
		if (obj instanceof Integer) {
			//数据库要成1000L
			Integer dateInt = (Integer) obj;
			formatTime=dateInt*1000L;
		}
		if (obj instanceof Long){
			//不用转了
			formatTime =(Long)obj;
		}
		if(formatTime==null) return null;
//		L.w("formatTime is :",formatTime);
		Date formatDate=new Date(formatTime);
		String hourFat= sdf_hour.format(formatTime);
		String mouthFat= sdf_mouth.format(formatTime);
		String yearFat= sdf_year.format(formatTime);
		String ret = null;

		Calendar fotCalendar =Calendar.getInstance();
		fotCalendar.setTime(formatDate);
		int forYear=fotCalendar.get(Calendar.YEAR);
		int forDay=fotCalendar.get(Calendar.DAY_OF_MONTH);
		fotCalendar.setTime(nowDate);
		int nowDay=fotCalendar.get(Calendar.DAY_OF_MONTH);
		int nowYear=fotCalendar.get(Calendar.YEAR);
		L.w("forYear",forYear,"forDay",forDay,"nowDay",nowDay,"nowYear",nowYear);
		if(nowTime-formatTime<=THREE_MINUTE_TIME) {
			ret = "刚刚";
		}
		if(THREE_MINUTE_TIME<nowTime-formatTime&&nowTime-formatTime<=ONE_HOUR_TIME) {
			int minutes = (int) ((nowTime - formatTime)/(1000 * 60));
			ret = minutes+"分钟前";
		}
		if(nowDay-forDay>0){
			if(ONE_DAY_TIME<nowTime-formatTime&&nowTime-formatTime<=TWO_DAY_TIME) {
				ret = "昨天 "+hourFat;
			}
			if(ONE_HOUR_TIME<nowTime-formatTime&&nowTime-formatTime<=ONE_DAY_TIME) {
				ret = "昨天 "+hourFat;
			}
		}else{
			if(ONE_HOUR_TIME<nowTime-formatTime&&nowTime-formatTime<=ONE_DAY_TIME) {
				ret = "今天 "+hourFat;
			}
		}
		if(TWO_DAY_TIME<nowTime-formatTime) {
			ret = mouthFat;
		}
		if(nowYear-forYear>0){
			ret = yearFat;
		}
		return ret;
	}

	/**
	 *
	 * 创建作者: 张勇 创建日期: 2017-6-2 下午16:57:34 类介绍 : 根据时间戳差获取停留时间
	 * time 需转换时间
	 *
	 * @return: String 转换为字符串
	 *
	 */
	public static String returnTime(Integer time){
		long day=time/(24*60*60);
		long hour=(time/(60*60)-day*24);
		long min=((time/(60))-day*24*60-hour*60);
		long s=(time-day*24*60*60-hour*60*60-min*60);
		StringBuffer sb = new StringBuffer();
		if(day>0) {
			sb.append(day);
			sb.append("天");
			sb.append(hour);
			sb.append("小时");
		}else if(hour>0 && hour<24){
			sb.append(hour);
			sb.append("小时");
			sb.append(min);
			sb.append("分");
		}else{
			sb.append(min);
			sb.append("分");
			sb.append(s);
			sb.append("秒");
		}
		return  sb.toString();
	}

	public static String  getCurrentTime(){
		SimpleDateFormat matter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		// 将calendar装换为Date类型
		Date date = calendar.getTime();
		String dateString = matter.format(date);
		return dateString;
	}

	public static String  getCurrentTime2(){
		SimpleDateFormat matter = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		// 将calendar装换为Date类型
		Date date = calendar.getTime();
		String dateString = matter.format(date);
		return dateString;
	}


	/**
	 * 创建作者: 王曰岐 创建日期: 2017-8-1 下午16:57:34 类介绍 : 根据时间戳差获取停留时间 （因为内个自己测试数据有错误，所以新增一版）
	 * @param millisecond
	 * @return
	 */
	public static String parseMillisecone(long millisecond) {
		String time = null;
		try {
			long yushu_day = millisecond % (1000 * 60 * 60 * 24);
			long yushu_hour = (millisecond % (1000 * 60 * 60 * 24))
					% (1000 * 60 * 60);
			long yushu_minute = millisecond % (1000 * 60 * 60 * 24)
					% (1000 * 60 * 60) % (1000 * 60);
			@SuppressWarnings("unused")
			long yushu_second = millisecond % (1000 * 60 * 60 * 24)
					% (1000 * 60 * 60) % (1000 * 60) % 1000;
			if (yushu_day == 0) {
				return (millisecond / (1000 * 60 * 60 * 24)) + "天";
			} else {
				if (yushu_hour == 0) {
					return (millisecond / (1000 * 60 * 60 * 24)) + "天"
							+ (yushu_day / (1000 * 60 * 60)) + "时";
				} else {
					if (yushu_minute == 0) {
						return (millisecond / (1000 * 60 * 60 * 24)) + "天"
								+ (yushu_day / (1000 * 60 * 60)) + "时"
								+ (yushu_hour / (1000 * 60)) + "分";
					} else {
						long i=millisecond / (1000 * 60 * 60 * 24);
						if(i==0){
							return   (yushu_day / (1000 * 60 * 60)) + "时"
									+ (yushu_hour / (1000 * 60)) + "分"
									+ (yushu_minute / 1000) + "秒";
						}else{
							return (millisecond / (1000 * 60 * 60 * 24)) + "天"
									+ (yushu_day / (1000 * 60 * 60)) + "时"
									+ (yushu_hour / (1000 * 60)) + "分" + (yushu_minute / 1000) + "秒";
						}
					}

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return time;
	}

	public static boolean MoreTime(String passWordTime) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = sdf.parse(passWordTime);
		long time = 1*60*1000;//30分钟
		Date afterDate = new Date(now .getTime() + time);//30分钟后的时间
		if(afterDate.getTime()>getDate(getCurrentTime()).getTime()){
			return  false;
		}else {
			return  true;
		}
	}
	/**
	 * 转换日期为时间戳
	 * @param time
	 * @return
	 */
	public static Integer getNowDateTime(String time) {
		String re_time = null;
		Date d;
		try {
			d = sdf.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			re_time = str.substring(0, 10);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(re_time);
	}




	public static Integer getTimeBy(String time) {
		String re_time = null;
		Date d;
		try {
			d = sdf.parse(time);
			long l = d.getTime();
			String str = String.valueOf(l);
			if (str.length()>10)
				re_time = str.substring(0, 10);
			else
				return Integer.parseInt(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return Integer.parseInt(re_time);
	}

	public static String getNowWeek(){
		Date date=new Date();
		String format = sdf_week.format(date);
		if(!StringUtils.checkNull(format))
			return format;
		return "";
	}

	/**
	 * @作者: 张航宁
	 * @时间: 2019/9/16
	 * @说明: 获取当月第一天
	 */
	public static String getMonthStart(int year,int month){
		Calendar cal = Calendar.getInstance();
		//设置年份
		cal.set(Calendar.YEAR, year);
		//设置月份
		cal.set(Calendar.MONTH, month-1);
		//获取某月最小天数
		int firstDay = cal.getMinimum(Calendar.DATE);
		//设置日历中月份的最小天数
		cal.set(Calendar.DAY_OF_MONTH,firstDay);
		// 时
		cal.set(Calendar.HOUR_OF_DAY, 0);
		// 分
		cal.set(Calendar.MINUTE, 0);
		// 秒
		cal.set(Calendar.SECOND, 0);
		// 毫秒
		cal.set(Calendar.MILLISECOND, 0);

		//格式化日期
		return sdf.format(cal.getTime());
	}

	/**
	 * @作者: 张航宁
	 * @时间: 2019/9/16
	 * @说明: 获取当月最后一天
	 */
	public static String getMonthEnd(int year,int month){
		Calendar cal = Calendar.getInstance();
		//设置年份
		cal.set(Calendar.YEAR, year);
		//设置月份
		cal.set(Calendar.MONTH, month-1);
		//获取某月最大天数
		int lastDay = cal.getActualMaximum(Calendar.DATE);
		//设置日历中月份的最大天数
		cal.set(Calendar.DAY_OF_MONTH, lastDay);
		// 设置为第二天
		cal.add(Calendar.DATE, 1);
		// 时
		cal.set(Calendar.HOUR, 0);
		//格式化日期
		return sdf.format(cal.getTime());
	}

	/**
	 * @作者: 张航宁
	 * @时间: 2019/9/20
	 * @说明: 获取指定开始日期和结束日期的所有日期 week为指定的周几
	 */

	public static List<String> getAppointDates(String beginDateStr, String endDateStr , Integer week) {
		List<String> lDate = new ArrayList<String>();

		try {
			Date dBegin = sdf1.parse(beginDateStr);
			Date dEnd = sdf1.parse(endDateStr);

			Calendar calBegin = Calendar.getInstance();
			// 使用给定的 Date 设置此 Calendar 的时间
			calBegin.setTime(dBegin);
			calBegin.add(Calendar.DAY_OF_MONTH,-1);
			Calendar calEnd = Calendar.getInstance();
			// 使用给定的 Date 设置此 Calendar 的时间
			calEnd.setTime(dEnd);
			// 测试此日期是否在指定日期之后
			while (dEnd.after(calBegin.getTime())) {
				// 根据日历的规则，为给定的日历字段添加或减去指定的时间量
				calBegin.add(Calendar.DAY_OF_MONTH, 1);
				if(week!=null&&week!=0){
					if(week == 7) {
						if(calBegin.get(Calendar.DAY_OF_WEEK)==1){
							lDate.add(sdf1.format(calBegin.getTime()));
						}
					} else {
						if(calBegin.get(Calendar.DAY_OF_WEEK)-1==week){
							lDate.add(sdf1.format(calBegin.getTime()));
						}
					}
				} else {
					lDate.add(sdf1.format(calBegin.getTime()));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}


		return lDate;
	}

	/**
	 * 日期增长
	 * @param time
	 * @param dayCount 增长天数
	 * @return
	 */
	public static String timeGrowth(String time, int dayCount){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str="";
		try {
			Date date = sdf.parse(time);
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(date);
			calendar.add(calendar.DATE, dayCount);//
			//把日期往后增加一天.整数往后推,负数往前移动
			date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
			str= sdf.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return str;
	}

	/**
	 * 获取周几
	 * @param dt
	 * @return
	 */
	public static String getWeekOfDate(Date dt) {
		String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
		Calendar cal = Calendar.getInstance();
		cal.setTime(dt);

		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if (w < 0)
			w = 0;

		return weekDays[w];
	}

	/**
	 * @接口说明: 时间戳转换为corn表达式
	 * @日期: 2019/12/11
	 * @作者: 张航宁
	 */
	public String timeToCron(Long timeInMillis){
		StringBuilder corn = new StringBuilder();

		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(timeInMillis);
		// corn 格式 秒 分钟 小时 日 月 星期
		corn.append(calendar.get(Calendar.SECOND)).append(" ") // 秒
				.append(calendar.get(Calendar.MINUTE)).append(" ") // 分钟
				.append(calendar.get(Calendar.HOUR_OF_DAY)).append(" ") // 小时
				.append(calendar.get(Calendar.DATE)).append(" ") // 日
				.append(calendar.get(Calendar.MONTH)+1).append(" ") // 月
				.append("?").append(" "); // 星期

		return corn.toString();
	}


	/**
	 * 获取每周的开始日期、结束日期
	 * @param week  周期  0本周，-1上周，-2上上周，1下周，2下下周；依次类推
	 * @return  返回date[0]开始日期、date[1]结束日期
	 */
	public static Date[] getBeginAndEndOfTheWeek(int week) {
		DateTime dateTime = new DateTime();
		LocalDate date = new LocalDate(dateTime.plusWeeks(week));

		date = date.dayOfWeek().withMinimumValue();
		Date beginDate = date.toDate();
		Date pulusDate1 = date.plusDays(1).toDate();
		Date pulusDate2 = date.plusDays(2).toDate();
		Date pulusDate3 = date.plusDays(3).toDate();
		Date pulusDate4 = date.plusDays(4).toDate();
		Date pulusDate5 = date.plusDays(5).toDate();
		Date endDate = date.plusDays(6).toDate();
		return new Date[]{beginDate,pulusDate1,pulusDate2,pulusDate3,pulusDate4,pulusDate5 , endDate};
	}

		/**
         * 获得近一周的开始时间和结束时间
         * @return
         */
	public static Map<String,Date> getDaySevenRange(){
		Map condition=new HashedMap();
		Calendar calendar = Calendar.getInstance();
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		calendar.set(Calendar.HOUR_OF_DAY,24);
		condition.put("endDate",calendar.getTime());
		calendar.set(Calendar.HOUR_OF_DAY,-168);
		condition.put("startDate",calendar.getTime());
		return condition;
	}

	/**
	 * 获得近一月的开始时间和结束时间
	 * @return
	 */
	public static Map<String,Date> getDayTRange(){
		Map condition=new HashedMap();
		Calendar calendar = Calendar.getInstance();
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		calendar.set(Calendar.HOUR_OF_DAY,24);
		condition.put("endDate",calendar.getTime());
		calendar.set(Calendar.HOUR_OF_DAY,-720);
		condition.put("startDate",calendar.getTime());
		return condition;
	}

	/**
	 * 获得近一年的开始时间和结束时间
	 * @return
	 */
	public static Map<String,Date> getYearTRange(){
		Map condition=new HashedMap();
		Calendar calendar = Calendar.getInstance();
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		calendar.set(Calendar.HOUR_OF_DAY,24);
		condition.put("endDate",calendar.getTime());
		calendar.set(Calendar.HOUR_OF_DAY,-8640);
		condition.put("startDate",calendar.getTime());
		return condition;
	}

	/**
	 * 获得近三个月的（之前时间）和（今天时间）
	 * @return
	 */
	public static Map<String,Date> getThreeDay(){
		Map map=new HashMap();
		Date dNow = new Date();   //当前时间
		Date dBefore = new Date();
		Calendar calendar = Calendar.getInstance(); //得到日历
		calendar.setTime(dNow);//把当前时间赋给日历
		calendar.add(Calendar.MONTH, -3);  //设置为前3月
		dBefore = calendar.getTime();   //得到前3月的时间
		map.put("startDate",dBefore);
		map.put("endDate",dNow);
		return map;
	}
	/**
	 * 当前季度的开始时间，即2012-01-1 00:00:00
	 *
	 * @return
	 */
	public static Date getCurrentQuarterStartTime() {
		Calendar c = Calendar.getInstance();
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3) {
				c.set(Calendar.MONTH, 0);
			} else if (currentMonth >= 4 && currentMonth <= 6){
				c.set(Calendar.MONTH, 3);
			}else if (currentMonth >= 7 && currentMonth <= 9) {
				c.set(Calendar.MONTH, 6);
			}else if (currentMonth >= 10 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 9);
			}
			now = sdf.parse(c.get(Calendar.YEAR) +"-"+ (c.get(Calendar.MONTH)+1) + "-1 00:00:00");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前季度的结束时间，即2012-03-31 23:59:59
	 *
	 * @return
	 */
	public static Date getCurrentQuarterEndTime() {
		Calendar c = Calendar.getInstance();
		int currentMonth = c.get(Calendar.MONTH) + 1;
		Date now = null;
		try {
			if (currentMonth >= 1 && currentMonth <= 3) {
				c.set(Calendar.MONTH, 2);
				c.set(Calendar.DATE, 31);
			} else if (currentMonth >= 4 && currentMonth <= 6) {
				c.set(Calendar.MONTH, 5);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 7 && currentMonth <= 9) {
				c.set(Calendar.MONTH,8);
				c.set(Calendar.DATE, 30);
			} else if (currentMonth >= 10 && currentMonth <= 12) {
				c.set(Calendar.MONTH, 11);
				c.set(Calendar.DATE, 31);
			}

			now = sdf.parse(c.get(Calendar.YEAR) +"-"+ (c.get(Calendar.MONTH)+1) +"-"+ c.get(Calendar.DATE) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}


	/**
	 * 获得本月的开始时间，即2012-01-01 00:00:00
	 *
	 * @return
	 */
	public static Date getCurrentMonthStartTime() {
		Calendar c = Calendar.getInstance();
		Date now = null;
		try {
			c.set(Calendar.DATE, 1);
			now = sdf1.parse(sdf1.format(c.getTime()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前月的结束时间，即2012-01-31 23:59:59
	 *
	 * @return
	 */
	public static Date getCurrentMonthEndTime() {
		Calendar c = Calendar.getInstance();
		Date now = null;
		try {
			c.set(Calendar.DATE, 1);
			c.add(Calendar.MONTH, 1);
			c.add(Calendar.DATE, -1);
			now = sdf.parse(sdf1.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}
	/**
	 * 当前年的开始时间，即2012-01-01 00:00:00
	 *
	 * @return
	 */
	public static Date getCurrentYearStartTime() {
		Calendar c = Calendar.getInstance();
		Date now = null;
		try {
			c.set(Calendar.MONTH, 0);
			c.set(Calendar.DATE, 1);
			now = sdf1.parse(sdf1.format(c.getTime()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}

	/**
	 * 当前年的结束时间，即2012-12-31 23:59:59
	 *
	 * @return
	 */
	public static Date getCurrentYearEndTime() {
		Calendar c = Calendar.getInstance();
		Date now = null;
		try {
			c.set(Calendar.MONTH, 11);
			c.set(Calendar.DATE, 31);
			now = sdf.parse(sdf1.format(c.getTime()) + " 23:59:59");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return now;
	}
	//传入月份获取对应的季度
	public static int getQuarter(int month) {
		if(month == 1 || month == 2 || month == 3){
			return 1;
		}else if(month == 4 || month == 5 || month == 6){
			return  2;
		}else if(month == 7 || month == 8 || month == 9){
			return 3;
		}else{
			return 4;
		}
	}
	/**
	 * 获取某年第一天日期
	 * @param year 年份
	 * @return Date
	 */
	public static Date getYearFirst(int year){
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		Date currYearFirst = calendar.getTime();
		return currYearFirst;
	}

	/**
	 * 获取某年最后一天日期
	 * @param year 年份
	 * @return Date
	 */
	public static Date getYearLast(int year){
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.roll(Calendar.DAY_OF_YEAR, -1);
		Date currYearLast = calendar.getTime();
		return currYearLast;
	}

	//获取指定月份的开始时间
    public static Date getMonthBeginTime(int year, int month) {
        YearMonth yearMonth = YearMonth.of(year, month);
        java.time.LocalDate localDate = yearMonth.atDay(1);
        LocalDateTime startOfDay = localDate.atStartOfDay();
        ZonedDateTime zonedDateTime = startOfDay.atZone(ZoneId.of("Asia/Shanghai"));
        return Date.from(zonedDateTime.toInstant());
    }
    //获取指定月份的结束时间
    public static Date getMonthEndTime(int year, int month) {
        YearMonth yearMonth = YearMonth.of(year, month);
        java.time.LocalDate endOfMonth = yearMonth.atEndOfMonth();
        LocalDateTime localDateTime = endOfMonth.atTime(23, 59, 59, 999);
        ZonedDateTime zonedDateTime = localDateTime.atZone(ZoneId.of("Asia/Shanghai"));
        return Date.from(zonedDateTime.toInstant());
    }

	/**
	 * 得到指定月的天数
	 * */
	public static int getMonthLastDay(int year, int month) {
		Calendar a = Calendar.getInstance();
		a.set(Calendar.YEAR, year);
		a.set(Calendar.MONTH, month - 1);
		a.set(Calendar.DATE, 1);//把日期设置为当月第一天
		a.roll(Calendar.DATE, -1);//日期回滚一天，也就是最后一天
		int maxDate = a.get(Calendar.DATE);
		return maxDate;
	}


	/**
	 *
	 * @param nowTime   当前时间
	 * @param beginTime	开始时间
	 * @param endTime   结束时间
	 * @return
	 * @author hwx   判断当前时间在时间区间内
	 */
	public static boolean isEffectiveDate(Date nowTime, Date beginTime, Date endTime) {
		if (nowTime.getTime() == beginTime.getTime()
				|| nowTime.getTime() == endTime.getTime()) {
			return true;
		}

		Calendar date = Calendar.getInstance();
		date.setTime(nowTime);

		Calendar begin = Calendar.getInstance();
		begin.setTime(beginTime);

		Calendar end = Calendar.getInstance();
		end.setTime(endTime);

		if (date.after(begin) && date.before(end)) {
			return true;
		} else {
			return false;
		}
	}

	public static Date parseHm(String DateStr){
		Date date = null;
		try {
			date = hm.parse(DateStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}

	public static String formatHm(Date time) {
		return hm.format(time);
	}


	// 获取指定日期指定个月后的时间，负数为之前
	public static Date getMonthDay(Date nowTime,int amount)throws ParseException{
		// 获取当前时间
		Calendar calendar = Calendar.getInstance(); //得到日历
		calendar.setTime(nowTime);//把当前时间赋给日历
		calendar.add(calendar.MONTH, amount); //设置为前2月，可根据需求进行修改
		return calendar.getTime();//获取2个月前的时间
	}
}
