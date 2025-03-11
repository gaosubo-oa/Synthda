package com.xoa.util;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.beanutils.converters.DateConverter;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

/**
 * Created by 杨超 on 2017/10/9.
 * 把提交的参数直接转换成model
 */
public class ServletUtil {
    public static void requestParamsCopyToObject(HttpServletRequest request, Object target){
        //防止日期为空报错
        ConvertUtils.register(new DateConverter(null), java.util.Date.class);
        Map params = request.getParameterMap();
        try {
            BeanUtils.copyProperties(target, params);
        } catch (IllegalAccessException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
