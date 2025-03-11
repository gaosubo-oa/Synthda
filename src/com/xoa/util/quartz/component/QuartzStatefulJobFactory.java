package com.xoa.util.quartz.component;

import com.xoa.util.quartz.model.SchedulerJob;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import static com.xoa.util.quartz.component.Invok.invokMethod;

/**
 * Created by 刘建 on 2020/7/10 15:09
 * 有状态的任务
 */
@DisallowConcurrentExecution
public class QuartzStatefulJobFactory implements Job {

    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        //业务逻辑
        SchedulerJob scheduleJob = (SchedulerJob) jobExecutionContext.getMergedJobDataMap().get("scheduleJob");
        invokMethod(scheduleJob);
    }

}