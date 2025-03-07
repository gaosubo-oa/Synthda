package com.xoa.controller.meeting;

import com.xoa.model.meet.MeetingAttendConfirm;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.service.meeting.MeetSummaryService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/28 11:19
 * 类介绍  :   会议纪要
 * 构造参数:
 */
@Controller
@RequestMapping("/MeetSummary")
public class MeetingSummaryController {

    @Resource
    private MeetSummaryService meetSummaryService;
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午13:30:41
     * 方法介绍:   会议纪要信息展示
     * 参数说明:   request
     * @return    ToJson
     */

    @RequestMapping("/getAllInfo")
    @ResponseBody
    public ToJson<MeetingWithBLOBs> getAllInfo(Integer page, Integer pageSize, boolean useFlag, HttpServletRequest request){
        return meetSummaryService.getAllInfo(page,pageSize,useFlag,request);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午14:30:41
     * 方法介绍:   会议纪要信息查询
     * 参数说明:   request
     * @return    ToJson
     */
    @RequestMapping("/getMeetSummarydetail")
    @ResponseBody
    public ToJson<MeetingWithBLOBs> getMeetSummarydetail(HttpServletRequest request,String sid){
        return meetSummaryService.getMeetSummarydetail(request, sid);
    };
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月31日 下午14:40:41
     * 方法介绍:   编辑会议纪要
     * 参数说明:   request
     * @return    ToJson
     */
    @RequestMapping("/editMeetSummarydetail")
    @ResponseBody
    public ToJson<Object> editMeetSummarydetail(HttpServletRequest request,MeetingWithBLOBs meetingWithBLOBs){
        return meetSummaryService.editMeetSummarydetail(request,meetingWithBLOBs);
    }

    /**
     * 方法介绍:   手写签到
     * 参数说明:   request
     * @return    ToJson
     */
    @RequestMapping("/addSign")
    @ResponseBody
    public ToJson<Object> addSign(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm){
        return meetSummaryService.addSign(request,meetingAttendConfirm);
    }

    /**
     * 方法介绍:   会议笔记
     * 参数说明:   request
     * @return    ToJson
     */
    @RequestMapping("/meetNotes")
    @ResponseBody
    public ToJson<Object> meetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm){
        return meetSummaryService.meetNotes(request,meetingAttendConfirm);
    }

    /**
     * 方法介绍:   会议笔记签到更新接口
     * 参数说明:   request
     * @return    ToJson
     */
    @RequestMapping("/updateMeetNotes")
    @ResponseBody
    public ToJson<Object> updateMeetNotes(HttpServletRequest request, MeetingAttendConfirm meetingAttendConfirm){
        return meetSummaryService.updateMeetNotes(request,meetingAttendConfirm);
    }
}
