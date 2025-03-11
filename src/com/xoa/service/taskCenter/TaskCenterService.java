package com.xoa.service.taskCenter;

import com.xoa.model.taskCenter.TaskCenter;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;


@Service
public interface TaskCenterService {
    //获取当前登陆人所有待办数据接口
    ToJson getTaskCenters(PageParams pageParams, HttpServletRequest request, TaskCenter taskCenter);

    //获取菜单待办数量
    public ToJson getAllDataCount(HttpServletRequest request);

    //按月统计任务数量接口（近六个月的任务量总数数量分析）
    public ToJson analysisByMonth(HttpServletRequest request);

    //获取当前月份的数据统计分析，（单个月中的不同业务模块分析）
    public ToJson analysisByMonthAndMenu(HttpServletRequest request);

    //按月统计任务数量接口--公司均办理时效与个人办理时效对比
    public ToJson analysisByMonthPrescription(HttpServletRequest request);
}
