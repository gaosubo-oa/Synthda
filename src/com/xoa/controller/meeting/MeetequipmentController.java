package com.xoa.controller.meeting;

import com.xoa.model.common.Syslog;
import com.xoa.model.meet.MeetingEquuipment;
import com.xoa.model.users.Users;
import com.xoa.service.meeting.MeetEquuipmentService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.users.UsersService;
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
 * 创建日期:   2017/7/28 13:43
 * 类介绍  :   会议设备管理
 * 构造参数:
 */
@Controller
@RequestMapping("/Meetequipment")
public class MeetequipmentController {

    @Resource
    private MeetEquuipmentService meetEquuipmentService;
    @Resource
    private UsersService usersService;

    @Resource
    private SysLogService sysLogService;


    //返回前台当前登录人cp端不能获取需要后台返回
    @RequestMapping("/getuser")
    @ResponseBody
    public ToJson getuser(HttpServletRequest request){
        ToJson toJson=new ToJson(1,"err");
        try {
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            Users usersByuserId = usersService.findUsersByuserId(users.getUserId());
            toJson.setObject(usersByuserId);
            toJson.setCode("0");
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setObject(e);
        }
        return toJson;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午13:40:41
     * 方法介绍:   查询所有会议设备
     * 参数说明:   map 分页参数
     * @return    ToJson<MeetingEquuipment>
     */
    @RequestMapping("/getAllEquiet")
    @ResponseBody
    public ToJson<MeetingEquuipment> getAllEquiet(Integer page,Integer pageSize,boolean useFlag){
    return meetEquuipmentService.getAllEquip(page,pageSize,useFlag);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午14:14:41
     * 方法介绍:   查询会议设备详细信息BySId
     * 参数说明:    Sid 自动自增的唯一字段
     * @return    ToJson<MeetingEquuipment>
     */
    @RequestMapping("/getdetailEquiet")
    @ResponseBody
    public ToJson<MeetingEquuipment> getdetailEquiet(String Sid){
        return meetEquuipmentService.getdetailEquiet(Sid);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午14:50:41
     * 方法介绍:   更新会议设备的名称
     * 参数说明:    MeetingEquuipment 需要修改的参数
     * @return    ToJson<MeetingEquuipment>
     */
    @RequestMapping("/updateEquiet")
    @ResponseBody
    public ToJson<Object> updateEquiet(HttpServletRequest request,MeetingEquuipment meetingEquuipment){

        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",会议设备修改");
        sysLogService.saveLog(syslog,request);

    return meetEquuipmentService.updateEquiet(request,meetingEquuipment);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午15:00:41
     * 方法介绍:   批量删除会议设备
     * 参数说明:   Sid 自动自增的唯一字段
     * @return    ToJson<Object>
     */
    @RequestMapping("/deleteEquiets")
    @ResponseBody
    public ToJson<Object> deleteEquiets(HttpServletRequest request,String Sids){

        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(55); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",会议设备删除");
        sysLogService.saveLog(syslog,request);

        return meetEquuipmentService.deleteEquiets(request,Sids);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月28日 下午15:00:41
     * 方法介绍:   添加会议设备
     * 参数说明:   MeetingEquuipment 需要添加的参数
     * @return    ToJson<Object>
     */
    @RequestMapping("/addEquiets")
    @ResponseBody
    public ToJson<Object> addEquiet(HttpServletRequest request,MeetingEquuipment meetingEquuipment){
        return meetEquuipmentService.addEquiet(request,meetingEquuipment);
    }


}
