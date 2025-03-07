package com.xoa.controller.JHTMeeting;

import com.xoa.model.JHTMeeting.JHTMeetingWithBLOBs;
import com.xoa.service.JHTMeeting.JHTMeetingService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/JHTMeeting")
public class JHTMeetingController {



    @Autowired
    private JHTMeetingService jhtMeetingService;

    @Resource
    private SmsService smsService;

    @RequestMapping("/index")
    public String index(HttpServletRequest request){
        String bodyId = request.getParameter("bodyId");
        if (!StringUtils.checkNull(bodyId)) {
            smsService.setSmsReadStatus(request, Integer.valueOf(bodyId));
        }
        return "/app/meeting/cloudVideo/index";
    }

    @RequestMapping("/approval")
    public String approval(){
        return "/app/meeting/cloudVideo/approval";
    }
    //即会通视频
    @RequestMapping("/staVideo")
    public String staVideo(){
        return "/app/meeting/cloudVideo/staVideo";
    }

    //移动端即会通
    @RequestMapping("/indexH5")
    public String indexH5(){
        return "/app/meeting/cloudVideoH5/indexH5";
    }
    //即会通审批
    @RequestMapping("/approvalH5")
    public String approvalH5(){
        return "/app/meeting/cloudVideoH5/approvalH5";
    }
    @RequestMapping("/staVideoH5")
    public String staVideoH5(){
        return "/app/meeting/cloudVideoH5/staVideoH5";
    }

    @RequestMapping("/newAdd")
    public String newAdd(HttpServletRequest request) {
        return "/app/meeting/cloudVideoH5/newAdd";
    }

    @RequestMapping("/details")
    public String details(HttpServletRequest request) {
        return "/app/meeting/cloudVideoH5/details";
    }

    //即会通审批下详情查看
    @RequestMapping("/approvalDetH5")
    public String approvalDetH5(HttpServletRequest request) {
        return "/app/meeting/cloudVideoH5/approvalDetH5";
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  即会通查询接口
     */
    @RequestMapping("/findJHTMeeting")
    @ResponseBody
    public ToJson findJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs,Integer page,Integer limit){
        return jhtMeetingService.findJHTMeeting(request,jhtMeetingWithBLOBs,page,limit);
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  根据ID查询
     */
    @RequestMapping("/findByMeetingId")
    @ResponseBody
    public ToJson findByMeetingId(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs){
        return jhtMeetingService.findByMeetingId(request,jhtMeetingWithBLOBs);
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  编辑接口
     */
    @RequestMapping("/editJHTMeeting")
    @ResponseBody
    public ToJson editJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs,String isop){
        return jhtMeetingService.editJHTMeeting(request,jhtMeetingWithBLOBs,isop);
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  删除接口
     */
    @RequestMapping("/delJHTMeeting")
    @ResponseBody
    public ToJson delJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs){
        return jhtMeetingService.delJHTMeeting(request,jhtMeetingWithBLOBs);
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  新增接口
     */
    @RequestMapping("/insertJHTMeeting")
    @ResponseBody
    public ToJson insertJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs){
        return jhtMeetingService.insertJHTMeeting(request,jhtMeetingWithBLOBs);
    }
}
