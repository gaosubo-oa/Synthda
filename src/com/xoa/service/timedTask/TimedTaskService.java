package com.xoa.service.timedTask;

import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

/**
 * 定时任务接口类
 * Created by 郅浩宇 on 2018/8/14
 */
@Service
public interface TimedTaskService {

    //列表查询
    ToJson selectQuery(Boolean useFlag,Integer page,Integer pageSize);

    //修改设置前查询
    ToJson updateSettingsSelect(Integer taskId);

    //修改设置
    ToJson updateSettings(Integer interval,String execTime,String useFlag,Integer taskId);

    //立即执行
    ToJson executeNow(Integer taskId, String taskCode);
}
