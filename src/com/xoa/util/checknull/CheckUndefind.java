package com.xoa.util.checknull;

import java.lang.reflect.Field;

/**
 * Created by 李显 on 2017/12/5.
 * 用于去除表单undefind
 */
public class CheckUndefind {
    public static void checknull(Object obj) throws Exception {
        boolean s1=false;
        
        int num=0;
        for (Field f : obj.getClass().getDeclaredFields()) {
            f.setAccessible(true);
            if (f.get(obj) == null) {
                s1=f.getType().getName().equals("String");
                if(s1) {
                    f.set(obj, "");
                }
                s1=false;
            }
        }
    }

}
