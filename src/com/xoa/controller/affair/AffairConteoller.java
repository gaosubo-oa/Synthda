package com.xoa.controller.affair;

import com.xoa.dao.affair.AffairMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.model.affair.AffairWithBLOBs;
import com.xoa.model.calender.Calendar;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.users.Users;
import com.xoa.service.affair.AffairServiceImpl;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
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
import java.util.Objects;

/**
 * @author 左春晖
 *               周期性事务控制层
 *@date 2018/6/6 10:29
 * @desc
 */
@Controller
@RequestMapping("/Affair")
public class AffairConteoller {

   @Resource
   private  AffairServiceImpl affairService;

    @Resource
    private SysLogService sysLogService;

    @Resource
    private AffairMapper affairMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private SecurityContentApprovalService securityContentApprovalService;

    //添加
    @ResponseBody
    @RequestMapping("/insertAffair")//  /Affair/insertAffair
    public ToJson insertSelective(HttpServletRequest request,AffairWithBLOBs affairWithBLOBs,String smsRemind){
        return affairService.insertAffair(request,affairWithBLOBs,smsRemind);}
    //修改
    @ResponseBody
    @RequestMapping("/updateAffair")//  /Affair/updateAffair
    public ToJson updateByExampleSelective(HttpServletRequest request ,AffairWithBLOBs affairWithBLOBs, String smsRemind){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(56); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",周期性事务修改");
        sysLogService.saveLog(syslog,request);

        return affairService.updateAffair(request,affairWithBLOBs ,smsRemind);
    }
    //删除
    @ResponseBody
    @RequestMapping("/deleteAffair")//  /Affair/deleteAffair
    public ToJson deleteByPrimaryKey(HttpServletRequest request,Integer affId){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

        if(!"1".equals(request.getAttribute("approvalStatus"))) {
            //判断是否开启数据模块标密，增加删除审批
            SysPara isShowSecret = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if(!Objects.isNull(isShowSecret) && "1".equals(isShowSecret.getParaValue())){
                AffairWithBLOBs affairWithBLOBs = affairMapper.selectByPrimaryKey(affId);
                if(!Objects.isNull(affairWithBLOBs)){
                    securityContentApprovalService.insert("affair", affairWithBLOBs.getAffId().toString(), "日程安排-周期性事务", affairWithBLOBs.getContent(), "", "2"
                            , securityContentApprovalService.selectContentSecrecyByModuleTable("affair", affairWithBLOBs.getAffId().toString()).getContentSecrecy(), request);
                    ToJson json = new ToJson();
                    json.setFlag(0);
                    json.setCode("100066");
                    json.setMsg("进入删除审批，审批通过后删除");
                    return json;
                }
            }
        }

        //添加日志
        Syslog syslog = new Syslog();
        syslog.setUserId(user.getUserId());
        syslog.setType(56); //sys_code
        syslog.setRemark("[" + user.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId()+",周期性事务删除");
        sysLogService.saveLog(syslog,request);

        return affairService.delete(request,affId);
    }

    //查询
    @ResponseBody
    @RequestMapping("/selectAffair")//  /Affair/selectAffair
    public ToJson select(HttpServletRequest request,AffairWithBLOBs affairWithBLOBs,Integer page, Integer pageSize,boolean useFlag){
        return affairService.select( request,affairWithBLOBs,page,pageSize,useFlag);}
}
