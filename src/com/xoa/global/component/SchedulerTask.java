package com.xoa.global.component;

import com.xoa.util.scheduler.DefaultSchedulingConfigurer;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.scheduling.config.TriggerTask;
import org.springframework.scheduling.support.CronTrigger;

import javax.annotation.Resource;

public class SchedulerTask implements InitializingBean {

    @Resource
    private DefaultSchedulingConfigurer defaultSchedulingConfigurer;

    @Override
    public void afterPropertiesSet(){
        new Thread() {
            public void run()
            {

                try
                {
                    // 等待任务调度初始化完成
                    while (!defaultSchedulingConfigurer.inited())
                    {
                        Thread.sleep(2000);
                    }
                }
                catch (InterruptedException e)
                {
                    e.printStackTrace();
                }
                timingTask();
            }
        }.start();
    }


    /**
     * @接口说明: 定时任务
     * @日期: 2019/12/12
     * @作者: 张航宁
     */
    public void timingTask(){

        defaultSchedulingConfigurer.addTriggerTask("timing_task3", new TriggerTask(new Runnable() {
            @Override
            public void run()
            {
                // 定时任务执行方法区域

            }
        }, new CronTrigger("0 0 23 * * ?"))); // 同步考勤机每天晚上23时执行




    }

}
