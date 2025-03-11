package com.xoa.controller.timedTask;

import com.xoa.model.timedTask.TimedTask;
import com.xoa.model.timedTask.TimedTaskRecord;
import com.xoa.service.timedTask.TimedTaskJobService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 定时任务控制类
 * Created by liujian on 2020/7/11
 */
@Controller
@RequestMapping("/timedTaskJob")
public class TimedTaskJobController {

    @Resource
    private TimedTaskJobService timedTaskJobService;

    /**
     * 定时任务管理映射
     */
    @RequestMapping("/imedTaskManagement")
    public String imedTaskManagement() {
        return "app/timedTaskManagement/timePointTask";
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:50
     * 方法介绍: 查询所有任务
     * @param useFlag 是否开启分页
     * @param page 页码
     * @param pageSize 每页条数
     * @return com.xoa.util.ToJson<com.xoa.model.timedTask.TimedTask>
     */
    @ResponseBody
    @RequestMapping("/selectAll")
    public ToJson<TimedTask> selectAll(@RequestParam(defaultValue="false") boolean useFlag, Integer page, Integer pageSize){
        return timedTaskJobService.selectAll(useFlag,page,pageSize);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:51
     * 方法介绍: 主键查询 定时任务
     * @param taskId 主键ID
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/findTimedTaskById")
    public ToJson findTimedTaskById(Integer taskId){
        return timedTaskJobService.findTimedTaskById(taskId);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:54
     * 方法介绍: 编辑任务（只能是关闭状态的任务）
     * @param timedTask
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/editTimedTask")
    public ToJson editTimedTask(TimedTask timedTask){
        return timedTaskJobService.editTimedTask(timedTask);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:54
     * 方法介绍: 编辑任务(可以更改执行中的任务，但是不能修改任务名称、同步状态、执行类和方法)
     * @param timedTask
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/editTimedRunTask")
    public ToJson editTimedRunTask(TimedTask timedTask){
        return timedTaskJobService.editTimedRunTask(timedTask);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:59
     * 方法介绍: 立即执行任务
     * @param request
     * @param taskId
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/executeNow")
    public ToJson executeNow(HttpServletRequest request, Integer taskId){
        return timedTaskJobService.executeNow(request,taskId);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:59
     * 方法介绍: 启动/停止任务
     * @param taskId 任务Id
     * @param type (0-关闭，1-开启)
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/taskSwitch")
    public ToJson taskSwitch(Integer taskId ,String type){
        return timedTaskJobService.taskSwitch(taskId,type);
    }


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-11 15:59
     * 方法介绍: 查询任务执行记录
     * @param taskId 任务Id
     * @return com.xoa.util.ToJson
     */
    @ResponseBody
    @RequestMapping("/findTimedTaskRecord")
    public ToJson<TimedTaskRecord> findTimedTaskRecord(Integer taskId , @RequestParam(defaultValue="false") boolean useFlag, Integer page, Integer pageSize ){
        return timedTaskJobService.findTimedTaskRecord(taskId,useFlag,page,pageSize);
    }

    @ResponseBody
    @RequestMapping("addTimeTask")
    ToJson<TimedTask> addTimeTask(TimedTask timedTask){
        return timedTaskJobService.insertTimedTask(timedTask);
    }

    // 删除接口
    @ResponseBody
    @RequestMapping("deleteTimedTask")
    ToJson<TimedTask> deleteTimedTask(String taskIds){
        return timedTaskJobService.deleteTimedTask(taskIds);
    }


}
