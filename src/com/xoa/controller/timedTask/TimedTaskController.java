package com.xoa.controller.timedTask;

import com.xoa.service.timedTask.TimedTaskService;
import com.xoa.util.ToJson;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * 定时任务控制类
 * Created by 郅浩宇 on 2018/8/14
 */
@RestController
@RequestMapping("/timedTask")
public class TimedTaskController {

    @Resource
    private TimedTaskService timedTaskService;

    /**
     * 列表查询
     * @param useFlag
     * @param page
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping("/selectQuery")
    public ToJson selectQuery(Boolean useFlag,Integer page,Integer pageSize){
        return timedTaskService.selectQuery(useFlag,page,pageSize);
    }

    /**
     * 修改设置前查询
     * @param taskId
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateSettingsSelect")
    public ToJson updateSettingsSelect(Integer taskId){
        return timedTaskService.updateSettingsSelect(taskId);
    }

    /**
     * 修改设置
     * @param interval
     * @param execTime
     * @param useFlag
     * @param taskId
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateSettings")
    public ToJson updateSettings(Integer interval,String execTime,String useFlag,Integer taskId){
        return timedTaskService.updateSettings(interval,execTime,useFlag,taskId);
    }

    /**
     * 立即执行
     * @param taskId
     * @param taskCode
     * @return
     */
    @ResponseBody
    @RequestMapping("/executeNow")
    public ToJson executeNow(Integer taskId, String taskCode){
        return timedTaskService.executeNow(taskId,taskCode);


    }
}
