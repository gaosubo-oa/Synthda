package com.xoa.controller.voteTitle;

import com.xoa.model.users.Users;
import com.xoa.model.voteTitle.VoteTitle;
import com.xoa.service.sms.SmsService;
import com.xoa.service.voteTitle.IVoteTitleService;
import com.xoa.util.AjaxJson;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * <p>
 * 投票基本信息表 前端控制器
 * </p>
 *
 * @author 张丽军
 * @since 2017-09-16
 */
@Controller
@RequestMapping("/vote/manage")
public class VoteTitleController {

    @Autowired
    IVoteTitleService voteTitleService;

    @Autowired
    SmsService smsService;

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月16日
     * 方法介绍:   查询投票管理列表
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/getVoteTitleList")
    public ToJson<VoteTitle> getVoteTitleList(HttpServletRequest request, VoteTitle voteTitle, Map<String, Object> maps,
                                              @RequestParam(value="page",required = false) Integer page,
                                              @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                              @RequestParam(value = "useFlag", required = false)boolean useFlag){
        return voteTitleService.getVoteTitleList(request,voteTitle,maps,page,pageSize,useFlag);
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return
     */
    @RequestMapping("/vote")
    public String vote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/index";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  新建子投票
     */
    @RequestMapping("/voteChild")
    public String voteChild(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/voteChild";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  管理投票列表
     */
    @RequestMapping("/voteList")
    public String voteList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/voteList";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  新建投票
     */
    @RequestMapping("/newVote")
    public String newVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/newVote";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  修改投票
     */
    @RequestMapping("/updateVote")
    public String updateVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/viteItem";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  编辑投票
     */
    @RequestMapping("/editVote")
    public String editVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/voteEdit";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  修改子投票
     */
    @RequestMapping("/editChildVote")
    public String editChildVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/editChildVote";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  投票界面主页面映射
     */
    @RequestMapping("/voteIndex")
    public String voteIndex(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteList/index";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  投票界面已发布投票映射
     */
    @RequestMapping("/publishVote")
    public String publishVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteList/publishVote";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  投票界面未发布投票映射
     */
    @RequestMapping("/unPublishVote")
    public String unPublishVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteList/unPublishVote";
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  投票结果映射
     */
    @RequestMapping("/voteResult")
    public String voteResult(HttpServletRequest request) {
        String resultId = request.getParameter("resultId");
        String type = request.getParameter("type");
        if (type.equals("0")){
            return "app/vote/voteTitle/voteResult";
        }
        boolean isCheck = voteTitleService.checkEndTime(resultId);
        if(isCheck){
            return "app/vote/voteTitle/voteResult";
        }
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        boolean isVote = voteTitleService.isVotite(resultId,user);

        //消除提醒
        String  remingUrl="/vote/manage/voteResult?resultId="+resultId+"&type=1";
        smsService.updatequerySmsByType("11",user.getUserId(),remingUrl);


        if (!isVote){
            //投票前的页面
            return "app/vote/voteList/readVote";
        }else {
            //投票后查看结果的页面
            return "app/vote/voteTitle/voteResult";
        }
    }

    /**
     * 创建作者:   杨璞
     * 创建日期:   2017年9月18日
     * 方法介绍:   页面跳转连接
     * @return  进行投票映射
     */
    @RequestMapping("/readVote")
    public String readVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteList/readVote";
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月22日
     * 方法介绍:   页面跳转连接
     * @return   新建子投票
     */
    @RequestMapping("/newChildVote")
    public String newChildVote(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/vote/voteTitle/newChildVote";
    }



    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月16日
     * 方法介绍:   新建投票
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/newVoteTitle")
    public ToJson<VoteTitle> newVoteTitle(HttpServletRequest request,VoteTitle voteTitle){
        return voteTitleService.newVoteTitle(request,voteTitle);
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月16日
     * 方法介绍:   修改投票
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateVoteTitle")
    public ToJson<VoteTitle> updateVoteTitle(HttpServletRequest request,VoteTitle voteTitle){
        return voteTitleService.updateVoteTitle(request,voteTitle);
    }
    /**
     * 创建作者:   王辰
     * 创建日期:   2020-10-23
     * 方法介绍:   修改投票并且清空投票数据
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/clearSave")
    public ToJson<VoteTitle> clearSave(HttpServletRequest request,VoteTitle voteTitle){
        return voteTitleService.clearSave(request,voteTitle);
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   管理子投票列表(点击有子投票时)
     * @param request
     * @param voteTitle
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getChildVoteList")
    public ToJson<VoteTitle> getChildVoteList(HttpServletRequest request,VoteTitle voteTitle,Integer voteId){
        return voteTitleService.getChildVoteList(request,voteTitle,voteId);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年10月17日
     * 方法介绍:   管理投票列表(直接点击投票项目时)
     * @param request
     * @param voteTitle
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getOptionVoteList")
    public ToJson<VoteTitle> getOptionVoteList(HttpServletRequest request,VoteTitle voteTitle,Integer voteId){
        return voteTitleService.getOptionVoteList(request,voteTitle,voteId);
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   新建子投票
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/addChildVoteTitle")
    public ToJson<VoteTitle> addChildVoteTitle(HttpServletRequest request,VoteTitle voteTitle){
        return voteTitleService.addChildVoteTitle(request,voteTitle);
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:  根据voteId获取子投票详情
     * @param request
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getChildDetail")
    public ToJson<VoteTitle> getChilddetail(HttpServletRequest request,Integer voteId){
        return voteTitleService.getChilddetail(request,voteId);
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:  删除子投票
     * @param request
     * @param voteIds
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteByVoteId")
    public ToJson<VoteTitle> deleteByVoteId(HttpServletRequest request,String[] voteIds){
        return voteTitleService.deleteByVoteId(request,voteIds);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月18日
     * 方法介绍:   投票列表中投票结果
     * @param request
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/getVoteDataByVoteId")
    public ToJson<VoteTitle> getVoteDataByVoteId(HttpServletRequest request, HttpServletResponse response, String export,Integer voteId){
        return voteTitleService.getVoteDataByVoteId(request,response,export,voteId);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月19日
     * 方法介绍:   投票查询（已发布）
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/searchVoteTitleList")
    public ToJson<VoteTitle> searchVoteTitleList(HttpServletRequest request,VoteTitle voteTitle,Map<String, Object> maps,
                                                 @RequestParam(value="page",required = false) Integer page,
                                                 @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                                 @RequestParam(value = "useFlag", required = false)boolean useFlag){
        return voteTitleService.searchVoteTitleList(request,voteTitle,maps,page,pageSize,useFlag);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年9月19日
     * 方法介绍:   投票统计终止查询信息
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/getVoteTitleCount")
    public ToJson<VoteTitle> getVoteTitleCount(HttpServletRequest request,VoteTitle voteTitle,Map<String, Object> maps,
                                               @RequestParam(value="page",required = false) Integer page,
                                               @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                               @RequestParam(value = "useFlag", required = false)boolean useFlag){
        return voteTitleService.getVoteTitleCount(request,voteTitle,maps,page,pageSize,useFlag);
    }

    /**
     * 创建作者:   zlf
     * 创建日期:   2017年10月15日
     * 方法介绍:   添加一条投票信息
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/addVoteTitle")
    public AjaxJson addVoteTitle(HttpServletRequest request,VoteTitle voteTitle, String options, Integer voteId,String userName){
        return voteTitleService.addVoteTitle(request,voteTitle,options,voteId,userName);
    }


    /**
     * 创建作者:   未知
     * 创建日期:   2017年10月16日
     * 方法介绍:   投票发布修改
     * @param request
     * @param voteId
     * @return
     */
    @ResponseBody
    @RequestMapping("/statusUpdate")
    public AjaxJson statusUpdate(HttpServletRequest request,Integer voteId){
        return voteTitleService.statusUpdate(request,voteId);
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年11月9日
     * 方法介绍:   投票查询（已发布）移动端接口
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/getPublishVoteTitleList")
    public ToJson<VoteTitle> getPublishVoteTitleList(HttpServletRequest request,VoteTitle voteTitle,Map<String, Object> maps,
                                                 @RequestParam(value="page",required = false) Integer page,
                                                 @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                                 @RequestParam(value = "useFlag", required = false)boolean useFlag){
        return voteTitleService.getPublishVoteTitleList(request,voteTitle,maps,page,pageSize,useFlag);
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年11月9日
     * 方法介绍:   投票统计终止查询信息(移动端接口)
     * @param request
     * @param voteTitle
     * @return
     */
    @ResponseBody
    @RequestMapping("/getPublishVoteTitleCount")
    public ToJson<VoteTitle> getPublishVoteTitleCount(HttpServletRequest request,VoteTitle voteTitle,Map<String, Object> maps,
                                               @RequestParam(value="page",required = false) Integer page,
                                               @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                               @RequestParam(value = "useFlag", required = false)boolean useFlag){
        return voteTitleService.getPublishVoteTitleCount(request,voteTitle,maps,page,pageSize,useFlag);
    }
}
