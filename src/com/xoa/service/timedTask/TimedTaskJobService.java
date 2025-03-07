package com.xoa.service.timedTask;

import com.xoa.model.timedTask.TimedTask;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
 * 定时任务接口类
 * Created by liujian on 2020/7/11
 */
@Service
public interface TimedTaskJobService {

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:42
     * 方法介绍: 查询所有任务
     */
    ToJson<TimedTask> selectAll(Boolean useFlag, Integer page, Integer pageSize);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:52
     * 方法介绍: 主键查询任务
     */
    ToJson findTimedTaskById(Integer taskId);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:57
     * 方法介绍: 编辑任务（只能是关闭状态的任务）
     */
    ToJson editTimedTask(TimedTask timedTask);


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:57
     * 方法介绍: 编辑任务(可以更改执行中的任务，但是不能修改任务名称、同步状态、执行类和方法)
     */
    ToJson editTimedRunTask(TimedTask timedTask);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:58
     * 方法介绍: 立即执行任务
     */
    ToJson executeNow(HttpServletRequest request,Integer taskId);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:58
     * 方法介绍: 启动/停止任务
     */
    ToJson taskSwitch(Integer taskId,String type);

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:58
     * 方法介绍: 查询任务执行记录
     */
    ToJson<TimedTaskRecord> findTimedTaskRecord(Integer taskId , boolean useFlag, Integer page, Integer pageSize );

    // 新建接口
    ToJson<TimedTask> insertTimedTask(TimedTask timedTask);

    // 删除接口
    ToJson<TimedTask> deleteTimedTask(String taskIds);
}
