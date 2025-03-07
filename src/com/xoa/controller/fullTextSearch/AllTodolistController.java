package com.xoa.controller.fullTextSearch;

import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.Users;
import com.xoa.service.email.EmailService;
import com.xoa.service.fullTextSearch.AllTodolistService;
import com.xoa.service.notify.NotifyService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2018/3/15.
 */
@Controller
public class AllTodolistController {

        @Resource
        private AllTodolistService allTodolistService;

        @Resource
        private EmailService emailService;

        @Resource
        private NotifyService notifyService;
        /**
         * 创建作者:   张龙飞
         * 创建日期:   2017年6月23日 下午5:02:21
         * 方法介绍:   根据userId 查询待办
         * 参数说明:   @param request 请求
         * 参数说明:   @param userId 用户Id
         * 参数说明:   @return
         * @return     返回待办信息
         */
       /* @ResponseBody
        @RequestMapping(value = "/todoList/list",produces = {"application/json;charset=UTF-8"})
        public ToJson<AllDaiban> list(HttpServletRequest request,
                                      @RequestParam(value = "userId",required = false)String userId) {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
            ToJson<AllDaiban> json=new ToJson<AllDaiban>(0, null);
            try {
                String sqlType="xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse");
                if(!StringUtils.checkNull(userId)){
                    AllDaiban db=allTodolistService.list(userId,sqlType,request);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }else{
                    Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                    AllDaiban db=allTodolistService.list(String.valueOf(user.getUserId()),sqlType,request);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }
            } catch (Exception e) {
                json.setMsg(e.getMessage());
            }
            return json;
        }


        @ResponseBody
        @RequestMapping(value = "/todoList/readList",produces = {"application/json;charset=UTF-8"})
        public ToJson<AllDaiban> readList(HttpServletRequest request,
                                       @RequestParam(value = "userId",required = false)String userId) {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
            ToJson<AllDaiban> json=new ToJson<AllDaiban>(0, null);
            try {
                String sqlType="xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse");
                if(!StringUtils.checkNull(userId)){
                    AllDaiban db=allTodolistService.readList(userId,sqlType,request);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }else{
                    Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                    AllDaiban db=allTodolistService.readList(String.valueOf(user.getUserId()),sqlType,request);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }
            } catch (Exception e) {
                json.setMsg(e.getMessage());
            }
            return json;
        }
        @ResponseBody
        @RequestMapping(value = "/todoList/readHaveList",produces = {"application/json;charset=UTF-8"})
        public BaseWrapper readHaveList(String classification, HttpServletRequest request,
                                        @RequestParam(value = "userId",required = false)String userId) throws Exception {

            String sqlType="xoa" + (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if(!StringUtils.checkNull(userId)){
                return  allTodolistService.readHaveList(classification,userId,sqlType,request);
            }else{
                Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                return  allTodolistService.readHaveList(classification,user.getUserId(),sqlType,request);
            }
        }

        @ResponseBody
        @RequestMapping(value = "/todoList/readTotal",produces = {"application/json;charset=UTF-8"})
        public ToJson<AllDaiban> readTotal(HttpServletRequest request,
                                        @RequestParam(value = "userId",required = false)String userId,
                                        String superfluity) {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
            ToJson<AllDaiban> json=new ToJson<AllDaiban>(0, null);
            try {
                String sqlType="xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse");
                if(!StringUtils.checkNull(userId)){
                    AllDaiban db=allTodolistService.readTotal(userId,sqlType,request,superfluity);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }else{
                    Users	user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                    AllDaiban db=allTodolistService.readTotal(String.valueOf(user.getUserId()),sqlType,request,superfluity);
                    json.setObject(db);
                    json.setMsg("OK");
                    json.setFlag(0);
                }
            } catch (Exception e) {
                json.setMsg(e.getMessage());
            }
            return json;
        }


        @ResponseBody
        @RequestMapping(value = "/todoList/delete",produces = {"application/json;charset=UTF-8"})
        public ToJson<AllDaiban> delete(HttpServletRequest request,Integer qid,String type,String deleteFlag) {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
            ToJson<AllDaiban> json=new ToJson<AllDaiban>(0, null);
            try {
                if(type.equals("email")){
                    String returnRes = emailService.deleteInEmail(qid, deleteFlag);
                }
                if(type.equals("notify")){
                    notifyService.delete(qid);
                }
                if (json.getObj().size()>0) {
                    json.setFlag(0);
                    json.setMsg("ok");
                } else {
                    json.setFlag(1);
                    json.setMsg("error");
                }
            } catch (Exception e) {
                json.setMsg(e.getMessage());
            }
            return json;
        }

        *//**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午10:35:22
         * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
         * 参数说明:   @param  userId
         * 参数说明:
         * @return List<SUsers>  返回用户信息
         *//*
        @ResponseBody
        @RequestMapping(value = "/todoList/queryCountByUserId")
        public ToJson<Users> queryCountByUserId(String userName){
            if(StringUtils.checkNull(userName)){
                userName="";
            }
            return  allTodolistService.queryCountByUserId(userName.trim());
        }


        *//**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:29:22
         * 方法介绍:   根据子菜单名称进行模糊查询
         * 参数说明:   @param funName
         * 参数说明:
         * @return ToJson
         *//*
        @ResponseBody
        @RequestMapping(value = "/todoList/getSysFunctionByName")
        public ToJson<SysFunction> getSysFunctionByName(String funName,HttpServletRequest request){
            return allTodolistService.getSysFunctionByName(funName.trim(),request);
        }
        *//**
         * 创建作者:   牛江丽
         * 创建日期:   2017年6月27日 下午14:30:12
         * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
         * 参数说明:   @param funName
         * 参数说明:
         * @return ToJson
         *//*
        @ResponseBody
        @RequestMapping(value = "/todoList/getCountSysFunctionByName")
        public ToJson<SysFunction> getCountSysFunctionByName(String funName){
            return allTodolistService.getCountSysFunctionByName(funName.trim());
        }
        @ResponseBody
        @RequestMapping(value = "/todoList/smsListByType")
        public BaseWrapper SmsListByType(String userId, HttpServletRequest request, String type){
            return  allTodolistService.smsListByType(userId,request,type);
        }
        @ResponseBody
        @RequestMapping(value = "/todoList/getUserFunctionByUserId")
        public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request){
            return  allTodolistService.getUserFunctionByUserId(userId,request);
        }

        @ResponseBody
        @RequestMapping(value = "/todoList/getWillDocSendOrReceive")
        public BaseWrapper getWillDocSendOrReceive(String userId,String documentType, HttpServletRequest request){
            return  allTodolistService.getWillDocSendOrReceive(userId,documentType,request);
        }*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据userName进行模糊查询
         * 参数说明:   @param userName
         * 参数说明:
         *
         * @return List<SUsers>  返回用户信息
         */
        @ResponseBody
        @RequestMapping(value = "/AllTodoList/queryUserByUserId")
        public ToJson<Users> queryUserByUserId(String userName,HttpServletRequest request){
            if(StringUtils.checkNull(userName)){
                userName="";
            }
            return  allTodolistService.queryUserByUserId(userName.trim(),request);
        }

        /**
         * 创建作者:   张丽军
         * 创建日期:   2018年3月15日 下午17:32:22
         * 方法介绍:   根据subject进行模糊查询内部邮件信息
         * 参数说明:   @param subject
         * 参数说明:
         *
         */
        @ResponseBody
        @RequestMapping(value = "/AllTodoList/queryEmailBySubject")
        public ToJson<EmailBodyModel> queryEmailBySubject(String subject){
            if(StringUtils.checkNull(subject)){
                subject="";
            }
            return  allTodolistService.queryEmailBySubject(subject.trim());
        }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年3月15日 下午17:32:22
     * 方法介绍:   根据subject进行模糊查询公告通知信息
     * 参数说明:   @param subject
     * 参数说明:
     *
     */
    @ResponseBody
    @RequestMapping(value = "/AllTodoList/queryNotifyBySubject")
    public ToJson<Notify> queryNotifyBySubject(String subject){
        if(StringUtils.checkNull(subject)){
            subject="";
        }
        return  allTodolistService.queryNotifyBySubject(subject.trim());
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年3月15日 下午17:32:22
     * 方法介绍:   根据name进行模糊查询通讯簿信息
     * 参数说明:   @param name
     * 参数说明:
     *
     */

    /**
     * 创建作者:   张丽军
     * 创建日期:   2018/3/19 10:29
     * 方法介绍:   全局搜索工作流查询所有工作
     * 参数说明:
     *
     * @return
     */
/*
    @RequestMapping(value = "/AllTodoList/selectAllFlow", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<FlowRunPrcs> selectAll(FlowRunPrcs flowRunPrcs, HttpServletRequest request,
                                  @RequestParam(value = "page", required = false) Integer page,
                                  @RequestParam(value = "pageSize", required = false) Integer pageSize,
                                  @RequestParam(value = "useFlag", required = false) boolean useFlag
    ) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(flowRunPrcs.getUserId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            maps.put("userId", userId);
        } else {
            maps.put("userId", flowRunPrcs.getUserId());
        }
        if(!StringUtils.checkNull(flowRunPrcs.getMyworkconditions())){
            maps.put("myworkconditions",flowRunPrcs.getMyworkconditions());
        }
        return allTodolistService.getWfeFlowRunPrcs().selectAll(maps, page, pageSize, useFlag);
    }
*/


}
