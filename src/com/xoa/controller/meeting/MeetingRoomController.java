package com.xoa.controller.meeting;

import com.xoa.model.common.Syslog;
import com.xoa.model.meet.MeetingRoomWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.meeting.MeetRoomService;
import com.xoa.service.sys.SysLogService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/29 9:58
 * 类介绍  :   会议室管理模块
 * 构造参数:   无
 */

@RequestMapping("/meetingRoom")
@Controller
public class MeetingRoomController {
    @Resource
    private MeetRoomService meetRoomService;

    @Resource
    private SysLogService sysLogService;

    @RequestMapping("/roomManage")
    public String roomManage(HttpServletRequest request) {
        return "app/meeting/room/roomManage";
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:  查询会议室相关信息
     * 参数说明:   map 分页参数
     * @return    HrStaffContract
     */
    @RequestMapping("/getAllMeetRoomInfo")
    @ResponseBody
    public ToJson<MeetingRoomWithBLOBs> getAllMeetRoomInfo(Integer page, Integer pageSize, boolean useFlag){
     return meetRoomService.getAllMeetRoomInfo(page,pageSize,useFlag);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:  查询会议室详情
     * 参数说明:   sid 自动自增的id
     * @return    MeetingRoomWithBLOBs
     */
    @RequestMapping("/getMeetRoomBySid")
    @ResponseBody
    public ToJson<MeetingRoomWithBLOBs> getMeetRoomBySid(HttpServletRequest request,String sid){
         return meetRoomService.getMeetRoomBySid(request,sid);
    };
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午12:01:41
     * 方法介绍:    删除会议室
     * 参数说明:   sid 自动自增的id
     * @return
     */
    @RequestMapping("/deleteMeetRoomBySid")
    @ResponseBody
    public ToJson<Object> deleteMeetRoomBySid(HttpServletRequest request,String sid){

        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",会议室删除");
        sysLogService.saveLog(syslog,request);

          return  meetRoomService.deleteMeetRoomBySid(request,sid);
    };
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午15:01:41
     * 方法介绍:    添加会议室
     * 参数说明:  meetingRoomWithBLOBs 传的参数
     * @return
     */
    @RequestMapping("/addMeetRoom")
    @ResponseBody
    public ToJson<Object> addMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs){
        return meetRoomService.addMeetRoom( request,meetingRoomWithBLOBs);
    };
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月29日 下午16:01:41
     * 方法介绍:    编辑会议室
     * 参数说明:  meetingRoomWithBLOBs 传的参数 
     * @return
     */
    @RequestMapping("/editMeetRoom")
    @ResponseBody
    public ToJson<Object> editMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",会议室修改");
        sysLogService.saveLog(syslog,request);

        return meetRoomService.editMeetRoom(request,meetingRoomWithBLOBs);
    };
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年8月1日 上午10:29:41
     * 方法介绍:   查询当前登录人的所有可以使用的会议室
     * 参数说明:    resquest
     * @return    Tojson
     */
    @RequestMapping("/getAllMeetRoom")
    @ResponseBody
    public  ToJson<MeetingRoomWithBLOBs> getAllMeetRoom(HttpServletRequest request, Integer page, Integer pageSize, boolean useFlag){
        return  meetRoomService.getAllMeetRoom(request, page, pageSize, useFlag);
    }

    /**
     * 各个会议室使用情况
     * 参数：currentDate 要查询的日期
     */
    @RequestMapping("/getUserRoomCondition")
    @ResponseBody
    public ToJson<MeetingRoomWithBLOBs> getUserRoomCondition(String currentDate){
        return meetRoomService.getUserRoomCondition(currentDate);
    }
}
