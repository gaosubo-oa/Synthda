package com.xoa.util.quartz;

import com.xoa.model.timedTask.TimedTask;
import com.xoa.util.common.StringUtils;
import com.xoa.util.quartz.model.SchedulerJob;

/**
 * Created by 刘建 on 2020/7/10 14:48
 * 任务工具类
 */
public class TaskUtils {

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 19:31
     * 方法介绍: 转换 任务实体类
     */
    public static SchedulerJob copyTimedTaskBean(TimedTask timedTask, String sqlType) {
        if (!checkTimedTask(timedTask))
            return null;
        SchedulerJob schedulerJob = new SchedulerJob();
        schedulerJob.setJobId(timedTask.getTaskId());
        schedulerJob.setJobName(sqlType+":taskId-"+timedTask.getTaskId()+" "+timedTask.getTaskName());
        schedulerJob.setJobGroup(sqlType);
        schedulerJob.setDescription(timedTask.getTaskDescription());
        schedulerJob.setClassName(timedTask.getClassPath());
        schedulerJob.setSync(!"1".equals(timedTask.getSyncYn()) ? true : false);
        schedulerJob.setErrContinueYn("1".equals(timedTask.getErrContinueYn()) ? true : false);
        schedulerJob.setCronExpression(timedTask.getCron());
        schedulerJob.setTriggerName(sqlType+":taskId-"+timedTask.getTaskId()+" "+timedTask.getTaskName());
        schedulerJob.setTriggerGroup(sqlType);
        String methodName = timedTask.getMethodName();
        schedulerJob.setMethodName(methodName);
        if(!StringUtils.checkNull(methodName)&&methodName.contains("(")){
            schedulerJob.setJobData(methodName.substring(methodName.indexOf("(")+1,methodName.indexOf(")")));
        }
        return schedulerJob;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-12 8:52
     * 方法介绍: 校验任务
     *
     * @param timedTask
     * @return boolean
     */
    public static boolean checkTimedTask(TimedTask timedTask) {
        //校验任务参数
        if (timedTask == null || timedTask.getTaskId() == null || StringUtils.checkNull(timedTask.getTaskName()) || StringUtils.checkNull(timedTask.getClassPath().trim())
                || StringUtils.checkNull(timedTask.getMethodName()) || !CronExpUtil.isValid(timedTask.getCron())) {
            return false;
        }
        return true;
    }


}
