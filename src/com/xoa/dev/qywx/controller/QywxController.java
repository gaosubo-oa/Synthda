package com.xoa.dev.qywx.controller;

import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.dev.qywx.util.QywxUtil;
import com.xoa.model.qiyeWeixin.QiyeWeixinConfig;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.InterFaceService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.aes.AesException;
import com.xoa.util.aes.SHA1;
import com.xoa.util.aes.WXBizMsgCrypt;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import net.sf.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@Scope(value = "prototype")
@RequestMapping("/ewx")
public class QywxController {

    @Resource
    private QywxService qywxService;

    @Resource
    InterFaceService interfaceService;

    @Resource
    OrgManageMapper orgManageMapper;


    @RequestMapping("/index")//主页导航
    public String templateManager(Model model, HttpServletRequest request) {
        this.setCompany(request);
        List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
        if (interfaceModelList != null && interfaceModelList.size() > 0) {
            model.addAttribute("LogoImg", interfaceModelList.get(0).getJudgeAttachmentUrl());
            model.addAttribute("bannerFont", interfaceModelList.get(0).getBannerFont());
            model.addAttribute("bannerText", interfaceModelList.get(0).getBannerText());
        } else {
            model.addAttribute("LogoImg", null);
        }
        return "app/ewx/index";
    }

    // 登录页面
    @RequestMapping("/m/main")
    public String mmain() {
        return "app/ewx/main";
    }

    @RequestMapping("/oneIndex")//主页
    public String oneIndex(Model model, HttpServletRequest request) {
        this.setCompany(request);
        List<InterfaceModel> interfaceModelList = interfaceService.getInterfaceInfo(request);
        if (interfaceModelList != null && interfaceModelList.size() > 0 ) {
            model.addAttribute("LogoImg", interfaceModelList.get(0).getJudgeAttachmentUrl());
            model.addAttribute("bannerFont", interfaceModelList.get(0).getBannerFont());
            model.addAttribute("bannerText", interfaceModelList.get(0).getBannerText());
        } else {
            model.addAttribute("LogoImg", null);
        }
        return "app/ewx/oneIndex";
    }

    public void setCompany(HttpServletRequest request) {
        ContextHolder.setConsumerType("xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("company")) {
                    ContextHolder.setConsumerType("xoa" + cookie.getValue());
                }
                // get the cookie name
                // get the cookie value
            }
        }
    }

    @RequestMapping("/importPartPeople")//事务提醒
    public String importPartPeople() {
        return "app/wechatManage/OAPartUserTOWx/importPartPeople";
    }

    @RequestMapping("/repository")//事务提醒
    public String repository() {
        return "app/ewx/repository";
    }

    // 我的
    @RequestMapping("/mine")
    public String mine() {
        return "app/ewx/mine";
    }

    //邮件列表
    @RequestMapping("/emailList")
    public String emailList() {
        return "app/ewx/email/emailList";
    }

    //写邮件
    @RequestMapping("/addEmail")
    public String addEmail() {
        return "app/ewx/email/addEmail";
    }

    //邮件详情
    @RequestMapping("/emailDetail")
    public String emailDetail() {
        return "app/ewx/email/emailDetail";
    }

    //回复邮件
    @RequestMapping("/replyEmail")
    public String replyEmail() {
        return "app/ewx/email/replyEmail";
    }

    //转发邮件
    @RequestMapping("/turnEmail")
    public String turnEmail() {
        return "app/ewx/email/turnEmail";
    }

    //公告列表
    @RequestMapping("/noticeList")
    public String noticeList() {
        return "app/ewx/notice/noticeList";
    }


    //企业动态
    @RequestMapping("/trends")
    public String trends() {
        return "app/ewx/trends/index";
    }

    //公告详情
    @RequestMapping("/noticeDetail")
    public String noticeDetail() {
        return "app/ewx/notice/noticeDetail";
    }

    //日程安排
    @RequestMapping("/calendar")
    public String calendar() {
        return "app/ewx/calendar/calendar";
    }

    //日程安排
    @RequestMapping("/addSchedule")
    public String addSchedule() {
        return "app/ewx/calendar/addSchedule";
    }

    //日程安排
    @RequestMapping("/calendarDetails")
    public String calendarDetails() {
        return "app/ewx/calendar/calendarDetails";
    }

    //个人文件柜
    @RequestMapping("/fileIndex")
    public String fileIndex() {
        return "app/ewx/file/fileIndex";
    }

    @RequestMapping("/fileDetail")
    public String fileDetail() {
        return "app/ewx/file/fileDetail";
    }
    //    工作日志
    @RequestMapping("/diaryIndex")
    public String diaryIndex() {
        return "app/ewx/diary/diaryIndex";
    }
    //    工作日志
    @RequestMapping("/reportStatis")
    public String reportStatis() {
        return "app/ewx/diary/reportStatis";
    }
    @RequestMapping("/iStartedList")
    public String iStartedList() {
        return "app/ewx/diary/iStartedList";
    }
    @RequestMapping("/diaryCreate")
    public String diaryCreate() {
        return "app/ewx/diary/diaryCreate";
    }
    @RequestMapping("/shareList")
    public String shareList() {
        return "app/ewx/diary/shareList";
    }
    @RequestMapping("/diaryCount")
    public String diaryCount() {
        return "app/ewx/diary/diaryCount";
    }
    @RequestMapping("/countList")
    public String countList() {
        return "app/ewx/diary/countList";
    }
    @RequestMapping("/consult")
    public String consult() {
        return "app/ewx/diary/consult";
    }
    @RequestMapping("/comment")
    public String comment() {
        return "app/ewx/diary/comment";
    }
    @RequestMapping("/diaryList")
    public String diaryList() {
        return "app/ewx/diary/diaryList";
    }
    @RequestMapping("/logList")
    public String logList() {
        return "app/ewx/diary/logList";
    }
    @RequestMapping("/myBranch")
    public String myBranch() {
        return "app/ewx/diary/myBranch";
    }
    @RequestMapping("/logQuery")
    public String logQuery() {
        return "app/ewx/diary/logQuery";
    }

    // 新闻列表
    @RequestMapping("/newsList")
    public String newsList() {
        return "app/ewx/news/newsList";
    }

    // 新闻详情
    @RequestMapping("/newsDetail")
    public String newsDetail() {
        return "app/ewx/news/newsDetail";
    }


    //通讯簿
    @RequestMapping("/addressBook")
    public String addressBook() {
        return "app/ewx/addressBook/addressBook";
    }

    //通讯簿(部门人员)
    @RequestMapping("/deptPerson")
    public String deptPerson() {
        return "app/ewx/addressBook/deptPerson";
    }

    //通讯簿(个人资料)
    @RequestMapping("/Persondata")
    public String Persondata() {
        return "app/ewx/addressBook/Persondata";
    }

    //通讯簿内搜索
    @RequestMapping("/addressBookSearch")
    public String addressBookSearch() {
        return "app/ewx/addressBook/addressBookSearch";
    }




    // 车辆申请列表
    @RequestMapping("/carList")
    public String carList() {
        return "app/ewx/car/carList";
    }

    // 车辆详情
    @RequestMapping("/carDetail")
    public String carDetail() {
        return "app/ewx/car/carDetail";
    }

    // 车辆新建
    @RequestMapping("/carAdd")
    public String carAdd() {
        return "app/ewx/car/carAdd";
    }

    // 车辆申请审批列表
    @RequestMapping("/carApprovalList")
    public String carApprovalList() {
        return "app/ewx/car/carApprovalList";
    }

    // 车辆审批详情
    @RequestMapping("/carApprovalDetail")
    public String carApprovalDetail() {
        return "app/ewx/car/carApprovalDetail";
    }



    // 会议申请列表
    @RequestMapping("/meetingList")
    public String meetingList() {
        return "app/ewx/meeting/meetingList";
    }

    // 会议详情
    @RequestMapping("/meetingDetail")
    public String meetingDetail() {
        return "app/ewx/meeting/meetingDetail";
    }

    // 会议新建
    @RequestMapping("/meetingAdd")
    public String meetingAdd() {
        return "app/ewx/meeting/meetingAdd";
    }

    // 会议申请审批列表
    @RequestMapping("/meetingApprovalList")
    public String meetingApprovalList() {
        return "app/ewx/meeting/meetingApprovalList";
    }

    // 会议审批详情
    @RequestMapping("/meetingApprovalDetail")
    public String meetingApprovalDetail() {
        return "app/ewx/meeting/meetingApprovalDetail";
    }

    // 考勤
    @RequestMapping("/attend")
    public String attend() {
        return "app/ewx/attend/attend";
    }

    // 考勤
    @RequestMapping("/signIn")
    public String signIn() {
        return "app/ewx/attend/signIn";
    }

    // 考勤打卡页面
    @RequestMapping("/attendAdd")
    public String attendAdd() {
        return "app/ewx/attend/attendAdd";
    }

    // 考勤统计页面
    @RequestMapping("/attendStatistics")
    public String AttendStatistics() {
        return "app/ewx/attend/attendStatistics";
    }

    // 考勤统计详情
    @RequestMapping("/attendStatisticsDetail")
    public String AttendStatisticsDetail() {
        return "app/ewx/attend/attendStatisticsDetail";
    }

    // 考勤统计按日期查看详情
    @RequestMapping("/attendStatisticsDayDetail")
    public String AttendStatisticsDayDetail() {
        return "app/ewx/attend/attendStatisticsDayDetail";
    }

    // 新增领导日程安排
    @RequestMapping("/leadAddSchedule")
    public String leadAddSchedule() {
        return "app/ewx/leadCalendar/leadAddSchedule";
    }

    // 领导日程安排查询
    @RequestMapping("/leadCalendar")
    public String leadCalendar() {
        return "app/ewx/leadCalendar/leadCalendar";
    }

    // 领导日程安排详情
    @RequestMapping("/leadCalendarDetails")
    public String leadCalendarDetails() {
        return "app/ewx/leadCalendar/leadCalendarDetails";
    }

    // 公文首页
    @RequestMapping("/FrontOfficial")
    public String FrontOfficial() {
        return "app/ewx/document/FrontOfficial";
    }
    // 待办发文
    @RequestMapping("/toDoPost")
    public String toDoPost() {
        return "app/ewx/document/toDoPost";
    }
    // 办结发文
    @RequestMapping("/issueCompletion")
    public String issueCompletion() {
        return "app/ewx/document/issueCompletion";
    }

    // 待办收文
    @RequestMapping("/toDoReceiving")
    public String toDoReceiving() {
        return "app/ewx/document/toDoReceiving";
    }

    // 待办收文
    @RequestMapping("/finisheCompletion")
    public String finisheCompletion() {
        return "app/ewx/document/finisheCompletion";
    }

    // 公文的主界面
    @RequestMapping("/documentIndex")
    public String documentIndex() {
        return "app/ewx/document/index";
    }

    // 公文的主界面
    @RequestMapping("/dealt")
    public String dealt() {
        return "app/ewx/document/dealt";
    }


    @RequestMapping("/toReadFile")
    public String toReadFile() {
        return "app/ewx/PendingMatters/PendingMatters";
    }
    @RequestMapping("/PendingRead")
    public String PendingRead() {
        return "app/ewx/PendingMatters/PendingRead";
    }
    @ResponseBody
    @RequestMapping(value="/corerb", produces="text/html;charset=UTF-8")
    public String mailApproval(HttpServletRequest request) {
        // 微信加密签名
        String msg_signature = request.getParameter("msg_signature");
             // 时间戳
        String timestamp = request.getParameter("timestamp");
             // 随机数
        String nonce = request.getParameter("nonce");
           // 随机字符串
        String echostr = request.getParameter("echostr");

        System.out.println("request=" + request.getRequestURL());
        System.out.println("msg_signature=" + msg_signature);
        System.out.println("echostr=" + echostr);
        String result = null;
        try {
            QiyeWeixinConfig config = qywxService.getConfig();
            WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(QywxUtil.token, QywxUtil.encodingAESKey, config.getCorpid());
            result = wxcpt.VerifyURL(msg_signature, timestamp, nonce, echostr);
        } catch (AesException e) {
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/getjsapiticket")
    @ResponseBody
    public ToJson getJsapiTicket(HttpServletRequest request,String url,String menuUrl){
        ToJson tojson = new ToJson();
        String accesstoken ="";
        String nonceStr = "Gsubo";
        String jsapiticket ="";
        Long timestamp = new Date().getTime();
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("url",url);
        param.put("timestamp",timestamp);

        try {

            if(!StringUtils.checkNull(url)&&url.contains("openType")){
                String decode = URLDecoder.decode(url.substring(url.lastIndexOf("?") + 1));
                String[] split = decode.split("&");
                for (int i = 0; i < split.length; i++) {
                    if(split[i].contains("menuUrl")){
                        if(split[i].split("=").length==2&&!StringUtils.checkNull(split[i].split("=")[1])){
                            menuUrl = split[i].split("=")[1];
                        }
                    }
                }
            }

            String loginId = "1001";
            List<OrgManage> org = orgManageMapper.queryId();
            if (org != null && org.size() > 0) {
                loginId = org.get(0).getOid().toString().trim();
            }
            ContextHolder.setConsumerType("xoa" + loginId);

            if(!StringUtils.checkNull(menuUrl)){
                jsapiticket = qywxService.getJsapiTicket(menuUrl);
                accesstoken = qywxService.getAccessToken(menuUrl);
            } else {
                jsapiticket = qywxService.getJsapiTicket();
                accesstoken = qywxService.getAccessToken();
            }

            QiyeWeixinConfig config = qywxService.getConfig();

            String signature = SHA1.getSHA1("jsapi_ticket="+jsapiticket+"&noncestr="+nonceStr+"&timestamp="+timestamp+"&url="+url);

            param.put("nonceStr",nonceStr);
            param.put("accesstoken",accesstoken);
            param.put("signature",signature);
            param.put("appId",config.getCorpid()); //wwae94f826b76e2f47
            param.put("oaUrl",config.getOaUrl());
            param.put("apiDomain",config.getApiDomain());
            param.put("menuUrl",menuUrl);

            if(!StringUtils.checkNull(menuUrl)){
                param.put("agentid",qywxService.getConfig(menuUrl).getAgentId());
            } else {
                param.put("agentid",config.getAgentid());
            }

            tojson.setObject(param);
            tojson.setFlag(0);
        } catch (AesException e) {
            e.printStackTrace();
        }
        return tojson;

    }

    @RequestMapping("/getjsapiticketbyagent")
    @ResponseBody
    public ToJson getJsapiTicketByagent(HttpServletRequest request,String url){
        ToJson tojson = new ToJson();
        String accesstoken ="";
        String nonceStr = "zzy";
        String jsapiticket ="";
        Long timestamp = new Date().getTime();
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("url",url);
        param.put("timestamp",timestamp);

        try {
            jsapiticket = qywxService.getJsapiTicketByagent();
            accesstoken = qywxService.getAccessToken();
            QiyeWeixinConfig config = qywxService.getConfig();

            String signature = SHA1.getSHA1("jsapi_ticket="+jsapiticket+"&noncestr="+nonceStr+"&timestamp="+timestamp+"&url="+url);

            param.put("nonceStr",nonceStr);
            param.put("accesstoken",accesstoken);
            param.put("signature",signature);
            param.put("appId",config.getCorpid());
            tojson.setObject(param);
            tojson.setFlag(0);
        } catch (AesException e) {
            e.printStackTrace();
        }
        return tojson;

    }
    @RequestMapping("/getWxUserByCode")
    @ResponseBody
    public JSONObject getWxUserByCode(HttpServletRequest request, HttpServletResponse response, String code){
        JSONObject userinfo = null;
        try {
            userinfo = qywxService.getWxUserByCode(code,request.getParameter("menuUrl"));
            CookiesUtil.setCookie(response, "thirdAssessToken", code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userinfo;

    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取suiteTicket 用于接收企业微信服务器推送的suiteTicket
     */
    @ResponseBody
    @RequestMapping("/receiveSuiteTicket")
    public void receiveSuiteTicket(String SuiteId,String InfoType,String TimeStamp,String SuiteTicket){
        qywxService.receiveSuiteTicket(SuiteId, InfoType, TimeStamp, SuiteTicket);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 第三方应用登陆验证接口
     */
    @ResponseBody
    @RequestMapping("/OAuth2Login")
    public JSONObject OAuth2Login(String code){
        return qywxService.OAuth2Login(code);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取企业微信中的部门信息 id为部门id 填写获取指定部门 不填写获取全部部门
     */
    @ResponseBody
    @RequestMapping("/getDepartments")
    public BaseWrapper getDepartments(String id){
        BaseWrapper baseWrapper = new BaseWrapper();
        JSONObject jsonObject = qywxService.getDepartments(id);
        if((Integer)jsonObject.get("errcode")==0){
            baseWrapper.setData(jsonObject.get("department"));
            baseWrapper.setFlag(true);
        }else{
            baseWrapper.setFlag(false);
            baseWrapper.setMsg("调用企业微信接口，获取部门数据失败");
            baseWrapper.setData(jsonObject);
        }
        return baseWrapper;
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取指定id部门下的用户信息 不填写获取全部部门下的用户信息(即获取全部信息
     */
    @ResponseBody
    @RequestMapping("/getUsersByDept")
    public BaseWrapper getUsersByDept(String id) {
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setData(qywxService.getUsersByDept(id));
        baseWrapper.setFlag(true);
        return baseWrapper;
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/6/25
     * @说明: 查询所有用户和绑定状态
     */
    @ResponseBody
    @RequestMapping("/selUsersWithBindType")
    public BaseWrapper selUsersWithBindType(String deptId){
       return qywxService.selUsersWithBindType(deptId);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取企业微信中的用户数据id 绑定OA中的用户
     */
    @ResponseBody
    @RequestMapping("/bind")
    public BaseWrapper bind(String openId,String userId){
        return qywxService.bind(openId,userId);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/25
     * @说明: 解除绑定
     */
    @ResponseBody
    @RequestMapping("/removeBind")
    public BaseWrapper removeBind(String openId,String userId){
        return qywxService.removeBind(openId, userId);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/8/1
     * @说明: 连接测试
     */
    @ResponseBody
    @RequestMapping("/testConnect")
    public BaseWrapper testConnect(){
        return qywxService.testConnect();
    }

    /**
     * 测试推送接口
     * @return
     */
  /*  @ResponseBody
    @RequestMapping("/testsendMsg")
    public BaseWrapper testsendMsg(){
        List<String> list=new ArrayList();
        list.add("admin");
        return qywxService.sendMsg(list,"测试我是标题1","内容1","/DutyPoliceUsers/dutyDetails?dutyId=25",false);
    }*/

    /**
     * @接口说明: 企业微信同步组织接口
     * @日期: 2020/3/18
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("/WxDeptToOA")
    public Boolean WxDeptToOA(){
        qywxService.WxDeptToOA();
        return true;
    }

    /**
     * @接口说明: 企业微信同步用户信息
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("/WxUserToOA")
    public Boolean WxUserToOA(HttpServletRequest request){
        qywxService.WxUserToOA(request);
        return true;
    }

    /**
     * @接口说明: 企业微信同步用户信息
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("/WxAllToOA")
    public Boolean WxAllToOA(HttpServletRequest request){
        qywxService.WxDeptToOA();
        qywxService.WxUserToOA(request);
        return true;
    }

    /**
     * @接口说明: 通过手机号判读唯一性 来进行人员批量绑定
     * @日期: 2020/9/24
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("mobileBindOAUser")
    private BaseWrapper mobileBindOAUser(){
        return qywxService.mobileBindOAUser();
    }

    /**
     * @接口说明: oa部门同步到企业微信组织架构
     * @日期: 2020/12/25
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("oaDeptToWX")
    private BaseWrapper oaDeptToWX(){
        return qywxService.oaDeptToWX();
    }

    /**
     * @接口说明: oa用户同步到企业微信组织架构
     * @日期: 2020/12/25
     * @作者: 张航宁
     */
    @ResponseBody
    @RequestMapping("oaUserToWX")
    private BaseWrapper oaUserToWX(){
        return qywxService.oaUserToWX();
    }

    /**
     * @接口说明: 选择人员同步到企业微信组织架构（跟上面接口逻辑一致，但根据选择的用户或者部门来同步，不是全量同步）
     * @日期: 2022年7月1日
     */
    @ResponseBody
    @RequestMapping("chooseOAUserToWX")
    private BaseWrapper chooseOAUserToWX(HttpServletRequest request,String deptIds,String userIds){
        return qywxService.chooseOAUserToWX(request,deptIds,userIds);
    }

    /**
     * @接口说明: 单个用户同步接口撰写
     * @日期: 2022年7月1日
     */
    @ResponseBody
    @RequestMapping("wxUserToOASingle")
    private BaseWrapper wxUserToOASingle(HttpServletRequest request,String wxUserIds,Integer oaDeptId){
        return qywxService.wxUserToOASingle(request, wxUserIds, oaDeptId);
    }


    /**
     * @接口说明: 获取用户企业微信头像
     * @日期:
     */
    @ResponseBody
    @RequestMapping("getHeadPortrait")
    private BaseWrapper getHeadPortrait(HttpServletRequest request, String userIds){
        return qywxService.getHeadPortrait(request, userIds);
    }
}


