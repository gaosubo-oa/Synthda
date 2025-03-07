package com.xoa.util.quartz;

import com.xoa.util.quartz.model.SchedulerJob;

/**
 * Created by 刘建 on 2020/7/9 16:03
 * 任务接口
 */
public interface QuartzService {
    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:24
     * 方法介绍: 添加一个任务
     */
    public void addTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:21
     * 方法介绍: （开启状态下的任务）立即执行任务
     */
    public void runTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:21
     * 方法介绍: （关闭状态下的任务）立即执行任务
     */
    public void runDownTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:26
     * 方法介绍: 更改任务cron表达式
     */
    public void updateTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:27
     * 方法介绍: 暂停任务
     */
    public void pauseTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:27
     * 方法介绍: 唤醒任务
     */
    public void resumeTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:27
     * 方法介绍: 删除任务
     * @param job
     * @return void
     */
    public void deleteTimerJob(SchedulerJob job);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 14:35
     * 方法介绍: 查询当前任务状态
     */
    public String selectTimerJobState(SchedulerJob job);

}
