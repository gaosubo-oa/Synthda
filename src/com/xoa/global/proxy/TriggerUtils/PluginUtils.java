package com.xoa.global.proxy.TriggerUtils;

import com.xoa.global.proxy.CommonPlugin;
import com.xoa.global.proxy.ProxyHandle;
import com.xoa.global.proxy.SpringContextUtil;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.lang.reflect.Proxy;
import java.util.HashMap;
import java.util.Map;

public class PluginUtils {

    public static Map<String,Object> run(final String clazzName, final String company, final Object ...agrs){
        Map<String,Object> resultMap =  new HashMap<>();

        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        RequestContextHolder.setRequestAttributes(servletRequestAttributes,true);

        try{
            Class clazz = Class.forName(clazzName.trim());
            ApplicationContext ac = SpringContextUtil.getApplicationContext();

            CommonPlugin a=(CommonPlugin) Proxy.newProxyInstance(CommonPlugin.class.getClassLoader(),
                    new Class[]{CommonPlugin.class},
                    new ProxyHandle(ac.getBean(clazz)));

            resultMap = a.doRun(company, agrs);

        }catch (Exception e){
            e.printStackTrace();
            resultMap.put("msg","插件执行异常"+e);
        }

        return resultMap;

    }
}
