package com.xoa.controller.meeting;

import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/27 12:32
 * 类介绍  :    新闻模块映射
 * 构造参数:
 */
@RequestMapping("/MeetingCommon")
@Controller
public class MeetingCommonController {
    @Resource
    SmsService smsService;

    @RequestMapping("/MeetingRoomUsage")
    public String MeetingRoomUsage(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/MeetingRoomUsage";
    }
    //会议申请
    @RequestMapping("/MeetingApply")
    public String meetingApply(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/index";
    }
    //会议查询
    @RequestMapping("/selectMeeting")
    public String selectMeeting(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/query";
    }
    //我的会议
    @RequestMapping("/selectMyMeeting")
    public String selectMyMeeting(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/myMeeting";
    }
    //会议纪要
    @RequestMapping("/selectMeetingMinutes")
    public String selectMeetingMinutes(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/summary/index";
    }
    //会议管理
    @RequestMapping("/selectMeetingMange")
    public String selectMeetingMange(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String flag=request.getParameter("flag");
        if(!StringUtils.checkNull(flag)){
            String url="/MeetingCommon/selectMeetingMange?flag="+flag;
            smsService.setRead(request,url);
        }
        return "app/meeting/leader/index";
    }
    //会议设备管理
    @RequestMapping("/MeetingDeviceMange")
    public String MeetingDeviceMange(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/equipment/index";
    }
    //会议室管理
    @RequestMapping("/MeetingRoom")
    public String MeetingRoom(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/room/index";
    }

    //会议管理员设置
    @RequestMapping("/MeetingMange")
    public String MeetingMange(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/meeting/leader/setLeader";
    }

    /**
     *
     * 微应用页面映射
     * @return
     */
    //会议管理页面
    @RequestMapping("/meetingManagementh5")
    public String meetingManagement() {
        return "app/meeting/m/meetingManagementh5";
    }

    //会议管理页面
    @RequestMapping("/myMeetingh5")
    public String myMeeting() {
        return "app/meeting/m/myMeetingh5";
    }


    //会议申请-普陀教育
    @RequestMapping("/PTMeetingApply")
    public String PTMeetingApply(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "/app/meeting/PuTuo/index";
    }

    //会议管理
    @RequestMapping("/PTselectMeetingMange")
    public String PTselectMeetingMange(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String flag=request.getParameter("flag");
        if(!StringUtils.checkNull(flag)){
            String url="/MeetingCommon/selectMeetingMange?flag="+flag;
            smsService.setRead(request,url);
        }
        return "/app/meeting/PuTuo/leader";
    }

    //我的会议h5页面映射
    @RequestMapping("/HSTmyMeetingH5")
    public String myMeetingh5(HttpServletRequest request) {
        return "/app/HSTmeeting/myMeetingh5";
    }
}
