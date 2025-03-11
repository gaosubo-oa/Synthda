package com.xoa.util.quartz;

import com.xoa.dao.timedTask.TimedTaskMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.model.timedTask.TimedTask;
import com.xoa.util.common.L;
import com.xoa.util.quartz.component.Invok;
import com.xoa.util.quartz.model.SchedulerJob;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 刘建 on 2020/7/10 16:10
 * 初始化定时任务
 */
@Component
public class QuartzInit {

    @Resource
    private OrgManageMapper orgManageMapper;

    @Resource
    TimedTaskMapper timedTaskMapper;

    @Autowired
    QuartzService quartzService;

    public void afterPropertiesSet() {
        System.out.println("初始化定时任务");
        try {

            //之所以注视掉  是因为 线程不安全  会修改 session 中的库
            /*List<OrgManage> list = orgManageMapper.queryId();
            if(list != null){
                for(OrgManage orgManage:list){
                    Integer oid = orgManage.getOid();
                    if(oid != null){
                        String sqlType = "xoa"+oid;
                        ContextHolder.setConsumerType(sqlType);
                        List<TimedTask> timedTasks = timedTaskMapper.selectOpenAll();
                        for(TimedTask timedTask :timedTasks){
                            // 如果是备份数据库就是 直接添加容器
                            SchedulerJob schedulerJob = TaskUtils.copyTimedTaskBean(timedTask,sqlType);

                            if (timedTask.getTaskId() == 1){
                                if(schedulerJob != null){
                                    quartzService.addTimerJob(schedulerJob);
                                }else{
                                    //任务转换失败设置任务为关闭状态
                                    timedTaskMapper.shutDownTimedTask(timedTask.getTaskId());
                                }
                            }else{
                                schedulerJob.setJobData(oid.toString());
                                Invok.invokMethod(schedulerJob);
                            }
                        }
                    }
                }
            }*/

            String sqlType = "xoa1001";
            List<TimedTask> timedTasks = timedTaskMapper.selectOpenAll();
            for(TimedTask timedTask :timedTasks){
                try {
                    // 如果是备份数据库就是 直接添加容器
                    SchedulerJob schedulerJob = TaskUtils.copyTimedTaskBean(timedTask,sqlType);
                    if(schedulerJob != null){
                        quartzService.addTimerJob(schedulerJob);
                    }else{
                        //任务转换失败设置任务为关闭状态
                        timedTaskMapper.shutDownTimedTask(timedTask.getTaskId());
                    }
                }catch (Exception e){
                    e.printStackTrace();
                    L.e(timedTask.getTaskName() + "定时任务任务初始化失败，err : " + e.getMessage());
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
