package com.xoa.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class ReflectionUtils {

    public static Map<String, Object> getFileds(Object object, String temp) {
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            Field[] fields = object.getClass().getDeclaredFields();
            String[] s = temp.split(",");

            for (int i = 0; i < fields.length; i++) {
                String name = fields[i].getName();
                for (int j = 0; j < s.length; j++) {
                    if (name.equals(s[j])) {
                        String type = fields[i].getGenericType().toString(); // 获取属性的类型
                        //属性首字母大写，方便get和set方法
                        name = name.substring(0, 1).toUpperCase() + name.substring(1);
                        Method m = object.getClass().getMethod("get" + name);
                        Object value=null;
                        if (type.equals("class java.lang.String")) {
                            value = (String) m.invoke(object); // 调用getter方法获取属性值
                        }else if(type.equals("class java.lang.Integer")||type.equals("int")){
                            value = (Integer) m.invoke(object);
                        }
                        map.put(fields[i].getName(), value);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;

    }
}
