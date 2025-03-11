package com.xoa.util;

import dm.jdbc.util.StringUtil;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

@Component
public class SpringTool implements ApplicationContextAware {
    private static ApplicationContext applicationContext = null;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        if (SpringTool.applicationContext == null) {
            SpringTool.applicationContext = applicationContext;
        }
    }

    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    public static Object getBean(String name) {
        return getApplicationContext().getBean(name);
    }

    /**李善澳
     * 两对象之间的拷贝(在目标对象中存在的所有set方法，如果在源对象中存在对应的get方法，不管源对象的get方法的返回值是否为null,都进行拷贝)
     * 仅拷贝方法名及方法返回类型完全一样的属性值
     * @param desc     目标对象
     * @param orig     源对象
     * @param excludeFields     源对象
     * @param isCopyNull     为null的属性是否拷贝(true拷贝null属性;false不拷贝null属性)
     * @param excludeFields 不拷贝的field（多个用逗号隔开）
     */
    public static void copyPropertiesNotForce(Object desc, Object orig,String excludeFields, boolean isCopyNull) {
        Class<?> origClass = orig.getClass();
        Class<?> descClass = desc.getClass();

        Method[] descMethods = descClass.getMethods();
        Method[] origMethods = origClass.getMethods();

        boolean needExclude = false;                    //是否需要过滤部分字段
        if(!StringUtil.isEmpty(excludeFields)){
            needExclude = true;
            excludeFields = "," + excludeFields.toLowerCase() + ",";
        }

        Map<String,Method> methodMap = new HashMap<String,Method>();
        for (int i = 0; i < origMethods.length; i++) {
            Method method = origMethods[i];
            String methodName = method.getName();
            if (!methodName.equals("getClass")
                    && methodName.startsWith("get")
                    && (method.getParameterTypes() == null || method
                    .getParameterTypes().length == 0)) {
                if(needExclude && excludeFields.indexOf(methodName.substring(3).toLowerCase()) > -1){
                    continue;
                }
                methodMap.put(methodName, method);
            }
        }
        for (int i = 0; i < descMethods.length; i++) {
            Method method = descMethods[i];
            String methodName = method.getName();
            if (!methodName.equals("getClass")
                    && methodName.startsWith("get")
                    && (method.getParameterTypes() == null || method
                    .getParameterTypes().length == 0)) {
                if (methodMap.containsKey(methodName)) {
                    Method origMethod = (Method) methodMap.get(methodName);
                    try {
                        if (method.getReturnType().equals(
                                origMethod.getReturnType())) {
                            Object returnObj = origMethod.invoke(orig, null);
                            if(!isCopyNull && returnObj == null){
                                continue;
                            }

                            String field = methodName.substring(3);
                            String setMethodName = "set" + field;
                            Method setMethod = descClass.getMethod(
                                    setMethodName, new Class[] { method
                                            .getReturnType() });
                            setMethod.invoke(desc, new Object[] { returnObj });
                        }
                    } catch (IllegalArgumentException e) {
                        e.printStackTrace();
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    } catch (SecurityException e) {
                        e.printStackTrace();
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
