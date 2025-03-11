package com.xoa.service.timedTask.impl;

import com.xoa.dao.timedTask.TimedTaskMapper;
import com.xoa.dao.timedTask.TimedTaskRecordMapper;
import com.xoa.model.timedTask.TimedTask;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.model.users.Users;
import com.xoa.service.timedTask.TimedTaskJobService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import com.xoa.util.quartz.CronExpUtil;
import com.xoa.util.quartz.QuartzService;
import com.xoa.util.quartz.TaskUtils;
import com.xoa.util.quartz.model.SchedulerJob;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 定时任务接口实现类
 * Created by liujian on 2020/7/11
 */
@Service
public class TimedTaskJobServiceImpl implements TimedTaskJobService {

    @Autowired
    private QuartzService quartzService;

    @Resource
    private TimedTaskMapper timedTaskMapper;

    @Resource
    private TimedTaskRecordMapper timedTaskRecordMapper;

    @Override
    public ToJson<TimedTask> selectAll(Boolean useFlag, Integer page, Integer pageSize) {
        ToJson<TimedTask> toJson = new ToJson(1, "err");
        try {
            Map map = new HashMap<>();
            PageParams pageParams = new PageParams(useFlag, page, pageSize);
            map.put("page", pageParams);
            //查询
            List<TimedTask> list = timedTaskMapper.selectAll(map);
            if (list != null) {
                for (TimedTask timedTask : list) {
                    timedTask.setCronStr(CronExpUtil.translateToChinese(timedTask.getCron()));
                }
                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObj(list);
                toJson.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson findTimedTaskById(Integer taskId) {
        ToJson toJson = new ToJson(1, "err");
        try {
            TimedTask timedTask = timedTaskMapper.selectTaskRecord(taskId);
            if (timedTask != null) {
                timedTask.setCronStr(CronExpUtil.translateToChinese(timedTask.getCron()));
                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObject(timedTask);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson editTimedTask(TimedTask timedTask) {
        ToJson toJson = new ToJson(1, "err");
        try {
            TimedTask task = timedTaskMapper.selectByPrimaryKey(timedTask.getTaskId());
            if (task != null) {
                if (!"1".equals(task.getStatus())) {
                    if (chechEditTask(timedTask)) {
                        int i = timedTaskMapper.updateByPrimaryKeySelective(timedTask);
                        if (i > 0) {
                            toJson.setFlag(0);
                            toJson.setMsg("true");
                        }
                    } else {
                        toJson.setMsg("cron 表达式错误");
                    }
                } else {
                    toJson.setMsg("开启状态的任务不能编辑");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson editTimedRunTask(TimedTask timedTask) {
        ToJson toJson = new ToJson(1, "err");
        String sqlType = ContextHolder.getConsumerType();
        try {
            if (chechEditTask(timedTask)) {
                int i = timedTaskMapper.updateRunCronById(timedTask);
                if (i > 0) {
                    timedTask = timedTaskMapper.selectByPrimaryKey(timedTask.getTaskId());
                    SchedulerJob schedulerJob = TaskUtils.copyTimedTaskBean(timedTask, sqlType);
                    if (schedulerJob != null) {
                        quartzService.updateTimerJob(schedulerJob);
                        toJson.setFlag(0);
                        toJson.setMsg("true");
                    }
                }
            } else {
                toJson.setMsg("cron 表达式错误");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson executeNow(HttpServletRequest request, Integer taskId) {
        ToJson toJson = new ToJson(1, "任务不存在");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        String sqlType = ContextHolder.getConsumerType();
        try {
            TimedTask timedTask = timedTaskMapper.selectByPrimaryKey(taskId);
            if (timedTask != null) {
                SchedulerJob schedulerJob = TaskUtils.copyTimedTaskBean(timedTask, sqlType);
                if (schedulerJob != null) {
                    schedulerJob.setUserId(users.getUserId());
                    if ("1".equals(timedTask.getStatus())) {
                        quartzService.runTimerJob(schedulerJob);
                    } else {
                        quartzService.runDownTimerJob(schedulerJob);
                    }
                    toJson.setFlag(0);
                    toJson.setMsg("执行成功");
                }else{
                    toJson.setMsg("任务参数错误");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson taskSwitch(Integer taskId, String type) {
        ToJson toJson = new ToJson(1, "任务不存在或参数错误");
        String sqlType = ContextHolder.getConsumerType();
        try {
            TimedTask timedTask = timedTaskMapper.selectByPrimaryKey(taskId);
            SchedulerJob schedulerJob = TaskUtils.copyTimedTaskBean(timedTask, sqlType);
            if (schedulerJob != null) {
                String state = quartzService.selectTimerJobState(schedulerJob);
                if ("1".equals(type)) {//开启
                    if ("1".equals(timedTask.getStatus())) {//已开启
                        if ("NONE".equals(state)) {
                            try {
                                quartzService.addTimerJob(schedulerJob);
                            } catch (Exception e) {
                                timedTaskMapper.shutDownTimedTask(taskId);
                                toJson.setMsg("任务开启失败");
                            }
                        } else {
                            toJson.setMsg("任务已经是开启状态");
                        }
                    } else {
                        int i = timedTaskMapper.openTimedTask(taskId);
                        if (i > 0) {
                            try {
                                quartzService.addTimerJob(schedulerJob);
                                toJson.setMsg("任务开启成功");
                            } catch (Exception e) {
                                timedTaskMapper.shutDownTimedTask(taskId);
                                toJson.setMsg("任务开启失败");
                            }
                        }
                    }
                } else {//关闭
                    quartzService.deleteTimerJob(schedulerJob);
                    timedTaskMapper.shutDownTimedTask(taskId);
                    toJson.setMsg("任务已关闭");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson findTimedTaskRecord(Integer taskId, boolean useFlag, Integer page, Integer pageSize) {
        ToJson<TimedTaskRecord> toJson = new ToJson(1, "err");
        try {
            Map map = new HashMap<>();
            PageParams pageParams = new PageParams(useFlag, page, pageSize);
            map.put("page", pageParams);
            map.put("taskId", taskId);
            List<TimedTaskRecord> list = timedTaskRecordMapper.selectByTaskId(map);
            if (list != null) {
                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObj(list);
                toJson.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<TimedTask> insertTimedTask(TimedTask timedTask) {
        ToJson<TimedTask> json = new ToJson<>();
        if(!chechEditTask(timedTask)){
            json.setMsg("cron 表达式错误");
            return json;
        }
        timedTask.setIsSystemTask(2);
        timedTaskMapper.insertSelective(timedTask);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<TimedTask> deleteTimedTask(String taskIds) {
        ToJson<TimedTask> json = new ToJson<>();
        if(!StringUtils.checkNull(taskIds)){
            String[] split = taskIds.split(",");
            if(split.length>0)
                timedTaskMapper.deleteUserTimeTask(split);
        }
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 16:09
     * 方法介绍: 生成任务是cron 表达式
     *
     * @return boolean
     */
    private boolean chechEditTask(TimedTask timedTask) {
        String taskType = timedTask.getTaskType();
        Integer nextTime = timedTask.getIntervalTime();
        String intervalType = timedTask.getIntervalType();
        if(nextTime != null) {
            switch (taskType) {
                //间隔执行
                case "0":
                    switch (intervalType) {
                        case "0":
                            if (nextTime > 0 && nextTime < 12 * 60) {
                                timedTask.setCron(CronExpUtil.timeToCronErval(nextTime, "m"));
                            }
                            break;
                        case "1":
                            if (nextTime > 0 && nextTime < 7 * 24) {
                                timedTask.setCron(CronExpUtil.timeToCronErval(nextTime, "h"));
                            }
                            break;
                    }
                    break;
                //定点执行
                case "1":
                    Integer day = timedTask.getExecutionDate();
                    switch (intervalType) {
                        case "2":
                            if (nextTime > 0 && nextTime < 365) {
                                timedTask.setCron(CronExpUtil.timeDayToCron(timedTask.getExecutionTime(), nextTime));
                            }
                            break;
                        case "3":
                            if ((nextTime > 0 && nextTime <= 4) && (day > 0 && day <= 7) ) {
                                timedTask.setCron(CronExpUtil.timeWeeksToCron(day,timedTask.getExecutionTime(), nextTime));
                            }
                            break;
                        case "4":
                            if (nextTime > 0 && nextTime < 12) {
                                timedTask.setCron(CronExpUtil.timeMonToCron(day,timedTask.getExecutionTime(), nextTime));
                            }
                            break;
                    }
                    break;
            }
        }
        return CronExpUtil.isValid(timedTask.getCron());
    }

}
