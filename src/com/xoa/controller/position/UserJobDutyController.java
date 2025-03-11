package com.xoa.controller.position;

import com.xoa.model.position.UserJobDutyHistoryWithBLOBs;
import com.xoa.model.position.UserJobDutyWithBLOBs;
import com.xoa.service.position.UserJobDutyService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author 李善澳
 * @Date 2021-01-15 15:17
 * @Dnnotation:
 */
@RestController
@RequestMapping("/userJobDuty")
public class UserJobDutyController {
    @Autowired
    UserJobDutyService userJobDutyService;
    //新增
    @RequestMapping("/addUserJobDuty")
    public ToJson<UserJobDutyWithBLOBs> addUserJobDuty(HttpServletRequest request, UserJobDutyWithBLOBs userJob) {
        return userJobDutyService.addUserJobDuty(request, userJob);
    }

    //修改
    @RequestMapping("/updateUserJobDuty")
    public ToJson<UserJobDutyWithBLOBs> updateUserJobDuty(HttpServletRequest request, UserJobDutyWithBLOBs userJob) {
        return userJobDutyService.updateUserJobDuty(request, userJob);
    }

    //删除
    @RequestMapping("/delUserJobDuty")
    public ToJson<UserJobDutyWithBLOBs> delUserJobDuty(HttpServletRequest request, int dutyId) {
        return userJobDutyService.delUserJobDuty(request, dutyId);
    }

    //获取树结构
    @RequestMapping("/getUserJobDutyTree")
    public ToJson<UserJobDutyWithBLOBs> getUserJobDutyTree(HttpServletRequest request,String dutyType, String dutyName) {
        return userJobDutyService.getUserJobDutyTree(request,dutyType,dutyName);
    }

    //根据主职责主键获取职责历史版本
    @RequestMapping("/getUserJobDutyHistory")
    public ToJson<UserJobDutyHistoryWithBLOBs> getUserJobDutyHistory(HttpServletRequest request, int dutyId, PageParams pageParams) {
        return userJobDutyService.getUserJobDutyHistory(request, dutyId, pageParams);
    }

    //展示7层级职责数结构
    @RequestMapping("/shouJobDuty")
    public ToJson<UserJobDutyHistoryWithBLOBs> shouJobDuty(HttpServletRequest request) {
        return userJobDutyService.shouJobDuty(request);
    }
}
