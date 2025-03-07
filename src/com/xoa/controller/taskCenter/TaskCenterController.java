package com.xoa.controller.taskCenter;


import com.xoa.model.taskCenter.TaskCenter;
import com.xoa.service.taskCenter.TaskCenterService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/taskCenter")
public class TaskCenterController {
    @Autowired
    private TaskCenterService taskCenterService;


    @RequestMapping("/missionCentre")
    public String Index() {
        return "app/main/customMenu/missionCentre";
    }

    //获取当前登陆人所有待办数据接口
    @ResponseBody
    @RequestMapping("/getTaskCenters")
    public ToJson getTaskCenters(PageParams pageParams, HttpServletRequest request, TaskCenter taskCenter) {
        return taskCenterService.getTaskCenters(pageParams, request, taskCenter);
    }

    //获取菜单待办数量
    @ResponseBody
    @RequestMapping("/getAllDataCount")
    public ToJson getAllDataCount(HttpServletRequest request) {
        return taskCenterService.getAllDataCount(request);
    }

    //按月统计任务数量接口（近六个月的任务量总数数量分析）
    @ResponseBody
    @RequestMapping("/analysisByMonth")
    public ToJson analysisByMonth(HttpServletRequest request) {
        return taskCenterService.analysisByMonth(request);
    }
    //按月统计任务办理时效接口（近六个月的任务办理时效分析）
    @ResponseBody
    @RequestMapping("/analysisByMonthPrescription")
    public ToJson analysisByMonthPrescription(HttpServletRequest request) {
        return taskCenterService.analysisByMonthPrescription(request);
    }

    //获取当前月份的数据统计分析，（单个月中的不同业务模块分析）
    @ResponseBody
    @RequestMapping("/analysisByMonthAndMenu")
    public ToJson analysisByMonthAndMenu(HttpServletRequest request) {
        return taskCenterService.analysisByMonthAndMenu(request);
    }
}


















