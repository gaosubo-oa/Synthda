package com.xoa.util.budgetUtil;

import com.xoa.util.common.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by lenovo on 2018/7/9.
 */
public class DateSubString {

    private static SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");


    public static String getYearMouth(String date) {
        String result = null;
        if(!StringUtils.checkNull(date)) {
            if(date.length()>10) {
                result = date.substring(0, 19);
            } else {
                return date;
            }
        }
        return result;
    }


    public static String StringChange(Date date) {
        return  sdf1.format(date);
    }
}
