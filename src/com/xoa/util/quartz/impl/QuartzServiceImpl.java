package com.xoa.util.quartz.impl;

import com.xoa.dao.timedTask.TimedTaskMapper;
import com.xoa.dao.timedTask.TimedTaskRecordMapper;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.quartz.Listener.MailJobListener;
import com.xoa.util.quartz.QuartzService;
import com.xoa.util.quartz.component.MyTaskException;
import com.xoa.util.quartz.model.SchedulerJob;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

import static com.xoa.util.quartz.component.Invok.invokMethod;

/**
 * Created by 刘建 on 2020/7/9 16:04
 */
@Service
public class QuartzServiceImpl implements QuartzService {

    @Autowired
    private Scheduler scheduler;

    @Resource
    private TimedTaskRecordMapper timedTaskRecordMapper;

    @Resource
    private TimedTaskMapper timedTaskMapper;


    @Override
    public void addTimerJob(SchedulerJob job) {
        try {
            JobDetail jobDetail = JobBuilder
                    .newJob((Class<? extends Job>) Class.forName(job.getSyncClass()))
                    // 指定执行类
                    .withIdentity(job.getJobName(), job.getJobGroup())
                    // 指定name和group
                    .requestRecovery().withDescription(job.getDescription())
                    .build();
            // 创建表达式调度构建器
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
                    .cronSchedule(job.getCronExpression());
            // 创建触发器
            CronTrigger cronTrigger = TriggerBuilder.newTrigger()
                    .withIdentity(job.getTriggerName(), job.getTriggerGroup())
                    .withSchedule(cronScheduleBuilder).build();
            jobDetail.getJobDataMap().put("scheduleJob", job);
            //增加Job监听全局监听
            scheduler.getListenerManager().addJobListener(new MailJobListener());
            //加入调度器
            scheduler.scheduleJob(jobDetail, cronTrigger);
            scheduler.start();
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:21
     * 方法介绍: （开启状态下的任务）立即执行任务
     */
    @Override
    public void runTimerJob(SchedulerJob job) {
        try {
            JobKey jobKey = JobKey.jobKey(job.getJobName(), job.getJobGroup());
            //SchedulerJob scheduleJob = (SchedulerJob) scheduler.getJobDetail(jobKey).getJobDataMap().get("scheduleJob");
            JobDetail jobDetail = scheduler.getJobDetail(jobKey);
            if(null != jobDetail){
                JobDataMap jobDataMap = jobDetail.getJobDataMap();
                SchedulerJob scheduleJob = (SchedulerJob) jobDataMap.get("scheduleJob");
                scheduleJob.setUserId(job.getUserId());
            }
            scheduler.triggerJob(jobKey);
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:21
     * 方法介绍: （关闭状态下的任务）立即执行任务
     */
    @Override
    public void runDownTimerJob(SchedulerJob job) {
        Thread thread = new Thread(new Runnable() {
            public void run() {
                //切库
                ContextHolder.setConsumerType(job.getJobGroup());
                //是否执行成功
                boolean success = true;
                String msg = "";
                //执行前记录
                TimedTaskRecord timedTaskRecord = new TimedTaskRecord();
                timedTaskRecord.setTaskId(job.getJobId());
                timedTaskRecord.setUserId(job.getUserId());
                timedTaskRecord.setResult("0");
                timedTaskRecord.setResultLog("");
                timedTaskRecordMapper.insertSelective(timedTaskRecord);
                try {
                    invokMethod(job);
                } catch (JobExecutionException jobException) {
                    if (jobException instanceof MyTaskException) {
                        //执行的任务方法体异常
                        MyTaskException myTaskException = (MyTaskException) jobException;
                        success = myTaskException.isSuccess();
                    } else {
                        //方法调用失败
                        success = false;
                    }
                    msg = jobException.getMessage() + "\n" + jobException.getCause();
                } finally {
                    //修改任务记录状态
                    timedTaskRecordMapper.updateResultBytreId(timedTaskRecord.getTreId(), success ? "1" : "2", msg);
                    //更新最后一次执行时间
                    timedTaskMapper.updateLstTime(job.getJobId());
                }
            }
        });
        thread.start();
    }


    @Override
    public void updateTimerJob(SchedulerJob job) {
        try {
            TriggerKey triggerKey = new TriggerKey(job.getTriggerName(),
                    job.getTriggerGroup());
            CronTrigger cronTrigger = (CronTrigger) scheduler
                    .getTrigger(triggerKey);
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder
                    .cronSchedule(job.getCronExpression());
            // 重新构件表达式
            CronTrigger trigger = cronTrigger.getTriggerBuilder()
                    .withIdentity(triggerKey).withSchedule(cronScheduleBuilder)
                    .build();
            scheduler.rescheduleJob(triggerKey, trigger);
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void pauseTimerJob(SchedulerJob job) {
        try {
            scheduler.pauseJob(JobKey.jobKey(job.getJobName(), job.getJobGroup()));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void resumeTimerJob(SchedulerJob job) {
        try {
            scheduler.resumeJob(JobKey.jobKey(job.getJobName(), job.getJobGroup()));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteTimerJob(SchedulerJob job) {
        try {
            scheduler.deleteJob(JobKey.jobKey(job.getJobName(), job.getJobGroup()));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    @Override
    public String selectTimerJobState(SchedulerJob job) {
        //WAITING:等待  PAUSED:暂停  ACQUIRED:正常执行
        //BLOCKED:阻塞  ERROR:错误
        String state = "";
        TriggerKey triggerKey = new TriggerKey(job.getTriggerName(), job.getTriggerGroup());
        try {
            state = scheduler.getTriggerState(triggerKey).name();
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
        return state;
    }

}
