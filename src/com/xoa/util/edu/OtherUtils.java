package com.xoa.util.edu;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by ZhiHaoyu
 */
public class OtherUtils {

    //把字符串转换成整型数组
    public static Integer[] toIntArray(String string){
        Integer[] intArray = new Integer[0];
        try {
            String[] array = string.split(",");
            intArray = new Integer[array.length];
            for (int i = 0;i < array.length;i++){
                intArray[i] = Integer.valueOf(array[i]);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return intArray;
    }

    //日期格式化
    private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
    public static String dateToString(Date date){
        return simpleDateFormat.format(date);
    }
    public static Date stringToDate(String string){
        Date date = new Date();
        try {
            date = simpleDateFormat.parse(string);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

}
