package com.xoa.util.quartz.Listener;

import com.xoa.dao.timedTask.TimedTaskMapper;
import com.xoa.dao.timedTask.TimedTaskRecordMapper;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.util.SpringTool;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.quartz.component.MyTaskException;
import com.xoa.util.quartz.model.SchedulerJob;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.JobListener;

/**
 * Created by 刘建 on 2020/7/9 16:45
 * 任务监听器
 */
public class MailJobListener implements JobListener {

    public static final String LISTENER_NAME = "JobListener";

    private TimedTaskRecordMapper timedTaskRecordMapper;

    private TimedTaskMapper timedTaskMapper;

    @Override
    public String getName() {
        return LISTENER_NAME;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 19:49
     * 方法介绍: 任务停止时 更新任务状态 及 任务执行记录状态，时间
     */
    @Override
    public void jobExecutionVetoed(JobExecutionContext context) {
        //待完善
        System.out.println("停止任务");
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 19:55
     * 方法介绍: 任务执行前添加执行记录
     *
     * @param context
     * @return void
     */
    @Override
    public void jobToBeExecuted(JobExecutionContext context) {
        if (timedTaskRecordMapper == null) {
            timedTaskRecordMapper = (TimedTaskRecordMapper) SpringTool.getBean("timedTaskRecordMapper");
        }
        if (timedTaskMapper == null) {
            timedTaskMapper = (TimedTaskMapper) SpringTool.getBean("timedTaskMapper");
        }
        //切库
        String sqlType = context.getJobDetail().getKey().getGroup();
        ContextHolder.setConsumerType(sqlType);
        SchedulerJob scheduleJob = (SchedulerJob) context.getMergedJobDataMap().get("scheduleJob");
        TimedTaskRecord timedTaskRecord = new TimedTaskRecord();
        timedTaskRecord.setTaskId(scheduleJob.getJobId());
        timedTaskRecord.setUserId(scheduleJob.getUserId());
        timedTaskRecord.setResult("0");
        timedTaskRecord.setResultLog("");
        int i = timedTaskRecordMapper.insertSelective(timedTaskRecord);
        if (i > 0) {
            scheduleJob.setUserId(null);
            scheduleJob.setLastRecordId(timedTaskRecord.getTreId());
        }

    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 19:49
     * 方法介绍: 任务执行结束后
     * 1.方法调用失败（类不存在，方法不存在，入参错误），立即停止当前任务的执行
     * 2.任务内失败（任务实现类 错误），依据Code判断是否 记录为成功
     * 3.更新任务状态 及 任务执行记录状态，完成时间
     */
    @Override
    public void jobWasExecuted(JobExecutionContext context, JobExecutionException jobException) {
        SchedulerJob scheduleJob = (SchedulerJob) context.getMergedJobDataMap().get("scheduleJob");
        //是否执行成功
        boolean success = true;
        String msg = "";
        if (jobException != null) {
            if (jobException instanceof MyTaskException) {
                //执行的任务方法体异常
                MyTaskException myTaskException = (MyTaskException) jobException;
                success = myTaskException.isSuccess();
            } else {
                //方法调用失败
                success = false;
            }
            //是否继续执行
            boolean conti = success ? true : scheduleJob.isErrContinueYn() ? true : false;
            if (!conti) {
                //终止任务
                jobException.setUnscheduleAllTriggers(true);
                timedTaskMapper.shutDownTimedTask(scheduleJob.getJobId());
            }
            msg = jobException.getMessage() + "\n" + jobException.getCause();
        }
        String sqlType = context.getJobDetail().getKey().getGroup();
        ContextHolder.setConsumerType(sqlType);
        //修改任务记录状态
        timedTaskRecordMapper.updateResultBytreId(scheduleJob.getLastRecordId(), success ? "1" : "2", msg);
        //更新最后一次执行时间
        timedTaskMapper.updateLstTime(scheduleJob.getJobId());
    }
}
