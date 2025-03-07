package com.xoa.util;

//import org.apache.poi.ss.formula.functions.T;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

public class TimeFunc<T> {
    public List format_time_diff(Collection<T> dataset, String work_deadline, String work_start, String work_end){
        Iterator<T> it = dataset.iterator();
        int index = 0;
        while (it.hasNext()){
            Date deadlineDate = null;
            Date startDate = null;
            Date endDate = null;
            T t = (T) it.next();
            Field deadlineField = null;
            Field endField = null;
            Field stateField = null;
            // 利用反射，根据javabean属性的先后顺序，动态调用getXxx()方法得到属性值
            Field[] fields = t.getClass().getDeclaredFields();
            for (int i = 0; i < fields.length; i++){
                Field field = fields[i];
                String fieldName = field.getName();
                String getMethodName = "get" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
                //String setMethodName = "set" + fieldName.substring(0, 1).toUpperCase() + fieldName.substring(1);
                try {
                    @SuppressWarnings("rawtypes")
                    Class tCls = t.getClass();
                    Method getMethod = tCls.getMethod(getMethodName, new Class[]{});
                    Object value = getMethod.invoke(t, new Object[]{});

                    if(fieldName.toLowerCase().equals(work_deadline.toLowerCase())) {
                        deadlineDate = DateFormat.getDate(value.toString());
                        deadlineField = field;
                    }
                    if(fieldName.toLowerCase().equals(work_start.toLowerCase())) {
                        startDate = DateFormat.getDate(value.toString());
                        endField = field;
                    }
                    if(value!=null){
                        if(fieldName.toLowerCase().equals(work_end.toLowerCase())) {
                            endDate = DateFormat.getDate(value.toString());
                            stateField = field;
                        }
                    }





                    if(i == fields.length - 1) {
                        if(endDate!=null){

                        }
                        String deadlineStr = dateDiff(startDate, deadlineDate, endDate, "yyyy-MM-dd HH:mm:ss", "b");
                        String startStr = dateDiff(startDate, deadlineDate, endDate, "yyyy-MM-dd HH:mm:ss", "j");
                        String endStr = dateDiff(startDate, deadlineDate, endDate, "yyyy-MM-dd HH:mm:ss", "s");

                        String setMethodName1 = "set" + work_deadline.substring(0, 1).toUpperCase() + work_deadline.substring(1);
                        String setMethodName2 = "set" + work_start.substring(0, 1).toUpperCase() + work_start.substring(1);
                        String setMethodName3 = "set" + work_end.substring(0, 1).toUpperCase() + work_end.substring(1);

                        if(deadlineStr!=null&& deadlineStr.length() != 0){
                            Method setMethod1 = tCls.getMethod(setMethodName1, new Class[]{deadlineField.getType()});
                            setMethod1.invoke(t,new Object[]{deadlineStr});
                        }
                        if(endStr!=null&& endStr.length() != 0){
                            Method setMethod3 = tCls.getMethod(setMethodName3, new Class[]{endField.getType()});
                            setMethod3.invoke(t,new Object[]{endStr});
                        }
                        if(startStr!=null&& startStr.length() != 0){
                            Method setMethod2 = tCls.getMethod(setMethodName2, new Class[]{stateField.getType()});
                            setMethod2.invoke(t,new Object[]{startStr});
                        }


                    }

                } catch (SecurityException e) {
                    e.printStackTrace();
                } catch (NoSuchMethodException e) {
                    e.printStackTrace();
                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                } catch (InvocationTargetException e) {
                    e.printStackTrace();
                } finally {
                    // 清理资源
                }
            }
        }
            return (List)dataset;
    }

    private String dateDiff(Date startTime, Date statetime, Date endTime,String format, String str) {
        //"yyyy-MM-dd HH:mm:ss"
        Date currentTime=new Date();
        SimpleDateFormat formatter = new SimpleDateFormat(format);
        String dateString = formatter.format(currentTime);

        String valueStr="";

        long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
        long nh = 1000 * 60 * 60;// 一小时的毫秒数
        long nm = 1000 * 60;// 一分钟的毫秒数
        long ns = 1000;// 一秒钟的毫秒数
        long diff;
        long day = 0;
        long hour = 0;
        long min = 0;
        long sec = 0;
        // 获得两个时间的毫秒时间差异
        if(str.equalsIgnoreCase("b")){
            if(endTime!=null && startTime!=null){
                //已办结
                diff = endTime.getTime() - startTime.getTime();
                if(diff > 0){
                    //按时办结
                    day = diff / nd;// 计算差多少天
                    hour = diff % nd / nh + day * 24;// 计算差多少小时
                    min = diff % nd % nh / nm + day * 24 * 60;// 计算差多少分钟
                    sec = diff % nd % nh % nm / ns;// 计算差多少秒
                    // 输出结果
                    valueStr = "剩余" +day + "天" + (hour - day * 24) + "小时" + (min - day * 24 * 60) + "分钟" + sec + "秒";
                } else{
                    //超时办结
                    diff = currentTime.getTime() - endTime.getTime();
                    day = diff / nd;// 计算差多少天
                    hour = diff % nd / nh + day * 24;// 计算差多少小时
                    min = diff % nd % nh / nm + day * 24 * 60;// 计算差多少分钟
                    sec = diff % nd % nh % nm / ns;// 计算差多少秒
                    // 输出结果
                    valueStr = "超出" + day + "天" + (hour - day * 24) + "小时" + (min - day * 24 * 60) + "分钟" + sec + "秒";
                }
            }else{
                //办理中

            }
        }
        if(str.equalsIgnoreCase("j")){
            if(endTime!=null) {
                diff = currentTime.getTime() - endTime.getTime();
                if (diff > 0) {
                    day = diff / nd;// 计算差多少天
                    hour = diff % nd / nh + day * 24;// 计算差多少小时
                    min = diff % nd % nh / nm + day * 24 * 60;// 计算差多少分钟
                    sec = diff % nd % nh % nm / ns;// 计算差多少秒
                    // 输出结果
                    valueStr = "超出" + day + "天" + (hour - day * 24) + "小时" + (min - day * 24 * 60) + "分钟" + sec + "秒";
                } else {
                    valueStr = "没有时限";
                }
            }
        }
        if(str.equalsIgnoreCase("s")){
            if(endTime!=null) {
                //已办结
                if(endTime.getTime()>statetime.getTime()){
                    //超时
                    valueStr = "已超时办结";
                }else{
                    //
                    valueStr = "已按时办结";
                }
            }else{
                //办理中
                if(currentTime.getTime()>statetime.getTime()){
                    //超时
                    valueStr = "已超时办理中";
                }else{
                    //
                    valueStr = "办理中";
                }
            }
        }

        return valueStr;
    }

}
