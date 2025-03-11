package com.xoa.util.quartz.component;

import com.xoa.util.SpringTool;
import com.xoa.util.quartz.model.SchedulerJob;
import org.apache.commons.lang3.StringUtils;
import org.quartz.JobExecutionException;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * Created by 刘建 on 2020/7/11 19:34
 */
public class Invok {

    /**
     * 通过反射调用schedulerJob中定义的方法
     *
     * @param schedulerJob
     */
    @SuppressWarnings("unchecked")
    public static void invokMethod(SchedulerJob schedulerJob) throws JobExecutionException {
        Object obj = null;
        Class clazz = null;
        // 1.获取bean
        if (StringUtils.isNotBlank(schedulerJob.getClassName())) {
            //判断执行类是否时全路径，不是的话自动拼接
            if (schedulerJob.getClassName().indexOf("com.xoa") < 0) {
                schedulerJob.setClassName("com.xoa.global.timedTask." + schedulerJob.getClassName());
            }
            try {
                String className = schedulerJob.getClassName();
                String BeanName = className.substring(className.lastIndexOf(".") + 1);
                char[] chars = BeanName.toCharArray();
                chars[0] += 32;
                BeanName = String.valueOf(chars);
                boolean bol = SpringTool.getApplicationContext().containsBean(BeanName);
                if (bol) {
                    obj = SpringTool.getBean(BeanName);
                    clazz = obj.getClass();
                } else {
                    clazz = Class.forName(className);
                    obj = clazz.newInstance();
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                throw new JobExecutionException("启动失败,任务实现类[" + schedulerJob.getClassName() + "] 不存在", e);
            } catch (ReflectiveOperationException e) {
                e.printStackTrace();
                throw new JobExecutionException("启动失败,任务实现类[" + schedulerJob.getClassName() + "] 无法实例化", e);
            }
        }

        Method method = null;
        // 2.获取方法
        try {
            if (StringUtils.isBlank(schedulerJob.getJobData())) {
                method = clazz.getDeclaredMethod(schedulerJob.getMethodName());
            } else {
                method = clazz.getDeclaredMethod(schedulerJob.getMethodName(), new Class[]{String.class});
            }
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            throw new JobExecutionException(" 启动失败，任务方法名:[" + schedulerJob.getMethodName() + "] 设置错误!", e);
        }
        if (method != null) {
            try {
                if (StringUtils.isBlank(schedulerJob.getJobData())) {
                    method.invoke(obj);
                } else {
                    method.invoke(obj, schedulerJob.getJobData());
                }
            } catch (IllegalAccessException e) {
                throw new JobExecutionException("启动失败 [" + schedulerJob.getClassName() + "." + schedulerJob.getMethodName() + "] 方法参数设置错误", e);
            } catch (InvocationTargetException e) {
                //获取执行方法的异常
                Throwable targetEx = e.getTargetException();
                if (targetEx != null) {
                    throw new MyTaskException(targetEx);
                }
            }
        }
    }
}
