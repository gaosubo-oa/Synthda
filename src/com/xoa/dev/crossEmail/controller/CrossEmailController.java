package com.xoa.dev.crossEmail.controller;

import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.crossEmail.dao.EmailPlusMapper;
import com.xoa.dev.crossEmail.model.EmailBodyPlusModel;
import com.xoa.dev.crossEmail.model.EmailPlusModel;
import com.xoa.dev.crossEmail.service.EmailPlusService;
import com.xoa.model.common.AppLog;
import com.xoa.model.email.EmailBoxModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@Scope(value = "prototype")
@RequestMapping("/emailPlus")
public class CrossEmailController {


    @Resource
    private EmailPlusService emailPlusService;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private UserExtMapper userExtMapper;

    @Resource
    private SmsService smsService;
    @Resource
    EmailPlusMapper emailPlusMapper;

    //    邮件审批
    @RequestMapping("/mailApproval")
    public String mailApproval(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String bodyId=request.getParameter("bodyId");
        if(!StringUtils.checkNull(bodyId)){
            smsService.setSmsReadStatus(request,Integer.valueOf(bodyId));
        }
        return "app/email/mailApproval";
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:33:59
     * 方法介绍:   发送邮件并保存
     * 参数说明:	   @param emailBodyModel 邮件参数对象
     * 参数说明:	   @param sendFlag 是否为草稿箱发送 （0：是）
     * 参数说明:   @return
     * method = RequestMethod.POST,
     *
     * @return String
     */
    @RequestMapping(value = "/sendEmail", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> insertEmailBody(
            EmailBodyPlusModel emailBodyModel,String sql,
            @RequestParam(value = "sendFlag", required = false) String sendFlag,
            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        //ContextHolder.setConsumerType(sqlType);

        String toID = emailBodyModel.getToId2().trim()
                + emailBodyModel.getCopyToId().trim()
                + emailBodyModel.getSecretToId().trim();
        String[] toID2 = toID.split(",");

        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        UserExt userExt = user.getUserExt();
        String emailRecentLinkman = userExt.getEmailRecentLinkman();
        // 去重 规则改变 暂时注释
        /*for (String emailRecentLinkmanId:split){
            for (String toId:toID2){
                if(emailRecentLinkmanId.equals(toId)){
                    emailRecentLinkman = emailRecentLinkman.replace(toId+",","");
                }
            }
        }*/

        if(!toID.substring(toID.length()-1).equals(",")){
            toID+=",";
        }
        emailRecentLinkman = toID+emailRecentLinkman;
        if(emailRecentLinkman.length()>200){
            emailRecentLinkman = emailRecentLinkman.substring(0,200);
        }
        userExt.setEmailRecentLinkman(emailRecentLinkman);
        userExtMapper.updateUserExtByUid(userExt);

        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            emailBodyModel.setFromId(userId);
            emailBodyModel.setFromName1(user.getUserName());
            if(!sqlType.equals("xoa" + sql)){
                emailBodyModel.setAvatar(user.getAvatar());
                emailBodyModel.setSex(user.getSex());
                emailBodyModel.setSexName(user.getSexName());
                emailBodyModel.setUserPrivName(user.getUserPrivName());
            }
        }
        if ("0".equals(sendFlag)) {
            emailBodyModel.setSendFlag("1");
            return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
        } else {
            return emailPlusService.sendEmail(emailBodyModel, new EmailPlusModel(), sqlType, remind, request,sql);
        }
    }

    /**
     * 创建作者:      张勇
     * 创建日期:      2017-4-18 下午2:11:13
     * 类介绍:       保存或修改草稿箱
     * 方法介绍:   发送邮件并保存
     * 参数说明:	   @param emailBodyModel 邮件参数对象
     * method = RequestMethod.POST,
     * 参数说明:      @return
     */
    @RequestMapping(value = "/saveEmail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public @ResponseBody
    ToJson<EmailBodyPlusModel> saveEmailBody(
            EmailBodyPlusModel emailBodyModel,String sql,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            emailBodyModel.setFromId(userId);
            if(!sqlType.equals("xoa" + sql)){
                emailBodyModel.setFromName1(user.getUserName());
                emailBodyModel.setAvatar(user.getAvatar());
                emailBodyModel.setSex(user.getSex());
                emailBodyModel.setSexName(user.getSexName());
                emailBodyModel.setUserPrivName(user.getUserPrivName());
            }
        }
        if (emailBodyModel.getBodyId() == null) {
            return emailPlusService.saveEmail(emailBodyModel,sqlType,sql);
        } else {
            emailBodyModel.setSendFlag("0");
            return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
        }
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:35:16
     * 方法介绍:   查询列表
     * 参数说明:   @param  request inbox 收件箱 drafts 草稿箱 outbox 发件箱 recycle 废纸篓 noRead 未读
     * 参数说明:   @return json
     * 参数说明:   @throws Exception
     *
     * @return String
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/showEmail", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> queryEmail(HttpServletRequest request, @RequestParam("flag") String flag,
                                      @RequestParam("page") Integer page, @RequestParam("pageSize") Integer pageSize,
                                      @RequestParam("useFlag") boolean useFlag,
                                      @RequestParam(value = "userID", required = false) String userFrom, @RequestParam(value = "startDate", required = false) String startDate,
                                      @RequestParam(value = "endDate", required = false) String endDate, @RequestParam(value = "subject", required = false) String subject,
                                      @RequestParam(value = "content", required = false) String content, @RequestParam(value = "attachmentName", required = false) String attachmentName,
                                      @RequestParam(value = "readFlag", required = false) String readFlag, @RequestParam(value = "fromUserId", required = false) String fromUserId,
                                      @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                      @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail, String queryField) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
//        String flag = ServletRequestUtils.getStringParameter(request, "flag");
//        Integer page = ServletRequestUtils.getIntParameter(request, "page");
//        Integer pageSize = ServletRequestUtils.getIntParameter(request,
//                "pageSize");
//        boolean useFlag = ServletRequestUtils.getBooleanParameter(request,
//                "useFlag");
//        String userFrom = ServletRequestUtils.getStringParameter(request,
//                "userID");
//        String startDate = ServletRequestUtils.getStringParameter(request, "startDate");
//        String endDate = ServletRequestUtils.getStringParameter(request, "endDate");
//        String subject = ServletRequestUtils.getStringParameter(request, "subject");
//        String content = ServletRequestUtils.getStringParameter(request, "content");
//        String attachmentName = ServletRequestUtils.getStringParameter(request, "attachmentName");
//        String readFlag = ServletRequestUtils.getStringParameter(request,"readFlag");
//        String fromUserId = ServletRequestUtils.getStringParameter(request,"fromUserId");
//        String orderByName = ServletRequestUtils.getStringParameter(request,"orderByName");
//        String orderWhere = ServletRequestUtils.getStringParameter(request,"orderWhere");
        String userId = "";
       /* Users users = usersMapper.getUserByUserName(fromUserId);*///王曰岐注销
        if (StringUtils.checkNull(userFrom)) {
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
        } else {
            userId = userFrom.trim();
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        if (!StringUtils.checkNull(subject)) {
            maps.put("subject", "%" + subject + "%");
        }
        if (!StringUtils.checkNull(content)) {
            maps.put("content", "%" + content + "%");
        }
        if (!StringUtils.checkNull(attachmentName)) {
            maps.put("attachmentName", "%" + attachmentName + "%");
        } else {
            maps.put("attachmentName", "");
        }
        if (!StringUtils.checkNull(startDate)) {
            maps.put("startTime", DateFormat.getTime(startDate));
        }
        if (!StringUtils.checkNull(endDate)) {
            maps.put("endTime", DateFormat.getTime(endDate));
        }
        if (!StringUtils.checkNull(searchCriteria)) {
            maps.put("searchCriteria", "%" + searchCriteria + "%");
        }
        maps.put("isWebmail", isWebmail);
        maps.put("queryField", queryField);
        maps.put("orderByName", returnMapValue().get(orderByName));
        maps.put("orderWhere", returnMapValue().get(orderWhere));
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        if (flag.trim().equals("inbox")) {
            maps.put("readFlag", readFlag);
            maps.put("fromUserId", fromUserId);
            tojson = emailPlusService.selectInbox(request,maps, page, pageSize, useFlag, sqlType);
        } else if (flag.trim().equals("drafts")) {
            tojson = emailPlusService.listDrafts(maps, page, pageSize, useFlag, sqlType);
        } else if (flag.trim().equals("outbox")) {
            tojson = emailPlusService.listSendEmail(maps, page, pageSize, useFlag, sqlType);
        } else if (flag.trim().equals("recycle")) {
            tojson = emailPlusService.listWastePaperbasket(maps, page, pageSize,
                    useFlag, sqlType);
        } else if (flag.trim().equals("noRead")) {
            tojson = emailPlusService.selectIsRead(maps, page, pageSize, useFlag, sqlType);
        } else {
            tojson = emailPlusService.selectEmail(maps, page, pageSize, useFlag, sqlType);
        }
        if (tojson.getObj().size() > 0) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            if(flag.trim().equals("drafts")){
                tojson.setFlag(0);
                tojson.setMsg("ok");
            }else{
                tojson.setFlag(1);
                tojson.setMsg("error");
            }
        }
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:35:48
     * 方法介绍:   根据ID查询内容
     * 参数说明:   @param request HTTP请求
     * 参数说明:   @return Json
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    @RequestMapping(value = "/queryByID", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> queryByID(HttpServletRequest request, @RequestParam(value = "emailId", required = false) Integer emailId, @RequestParam("flag") String flag, @RequestParam(value = "bodyId", required = false) Integer bodyId) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("emailId", emailId);
        maps.put("bodyId", bodyId);
        EmailBodyPlusModel emailBody = emailPlusService.queryById(maps, 1, 5, false, sqlType);
        if (!emailBody.getFromId().equals(users.getUserId())) {
            if (!emailBody.getToId2().contains(users.getUserId())) {
                if (!emailBody.getCopyToId().contains(users.getUserId())) {
                    if (!emailBody.getSecretToId().contains(users.getUserId())) {
                        tojson.setFlag(1);
                        tojson.setMsg("没有看权限");
                        return tojson;
                    }
                }
            }
        }

        if (!flag.trim().equals("isRead")) {
            if (emailBody.getBodyId() != null) {
                tojson.setFlag(0);
                tojson.setMsg("ok");
                tojson.setObject(emailBody);
            } else {
                tojson.setFlag(1);
                tojson.setMsg("errorQueryByID");
            }
        } else {
            EmailPlusModel email = new EmailPlusModel();
            email.setEmailId(emailId);
            email.setReadFlag("1");

            //插入 邮件已读时间等信息到 app_log表

            AppLog appLog=new AppLog();
            appLog.setUserId(users.getUid()+"");
            appLog.setTime(new Date());
            appLog.setModule("1");//模块1：电子邮件
            appLog.setType("1"); //type 1 暂时存放1
            appLog.setOppId(emailId+""); //操作记录的id,这里设置为emailId
            appLog.setRemark("备注");
            emailPlusService.saveAppLog4Email(appLog);

            emailPlusService.updateIsRead(email);
            emailBody = emailPlusService.queryById(maps, 1, 5, false, sqlType);
            tojson.setFlag(0);
            tojson.setMsg("ok");
            tojson.setObject(emailBody);
        }
        return tojson;
    }




    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:35:16
     * 方法介绍:   删除列表
     * 参数说明:   @param  request inbox 收件箱  outbox 发件箱 recycle 废纸篓
     * 参数说明:   @return json
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    @RequestMapping(value = "/deleteEmail", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> deleteEmail(@RequestParam("flag") String flag, @RequestParam(value = "deleteFlag", required = false) String deleteFlag,
                                       @RequestParam(value = "emailID", required = false) Integer emailId,
                                       @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags,
                                       @RequestParam(value = "deleteFlags[]", required = false) String[] deleteFlags, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        String returnRes = "";
        if (requestFlags != null) {
            if (flag.trim().equals("inbox")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailPlusService.deleteInEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            } else if (flag.trim().equals("outbox")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailPlusService.deleteOutEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            } else if (flag.trim().equals("recycle")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailPlusService.deleteRecycleEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            }
        } else {
            if (flag.trim().equals("inbox")) {
                returnRes = emailPlusService.deleteInEmail(emailId, deleteFlag);
            } else if (flag.trim().equals("outbox")) {
                returnRes = emailPlusService.deleteOutEmail(emailId, deleteFlag);
            } else if (flag.trim().equals("recycle")) {
                returnRes = emailPlusService.deleteRecycleEmail(emailId, deleteFlag);
            }
        }
//		else if (flag.trim().equals("drafts")) {
//			emailPlusService.deleteRecycleEmail(emailBodyModel, deleteFlag);
//		}
        if (returnRes.equals("0")) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            tojson.setFlag(1);
            tojson.setMsg("error");
        }
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:35:16
     * 方法介绍:   草稿箱删除
     * 参数说明:   @param  bodyId 邮箱内容ID
     * 参数说明:   @return json
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    @RequestMapping(value = "/deleteDraftsEmail", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> deleteDraftsEmail(@RequestParam(value = "bodyId", required = false) Integer bodyId,
                                             @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags,
                                             HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        try {
            ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>(0, "ok");
            if (requestFlags != null) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    emailPlusService.deleteByID(Integer.valueOf(requestFlags[i]));
                }
            } else {
                emailPlusService.deleteByID(bodyId);
            }
            return tojson;
        } catch (Exception e) {
            ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>(1, "error");
            return tojson;
        }
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/3 14:29
     * 方法介绍:
     * 参数说明:  参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/messageEmail", produces = {"application/json;charset=UTF-8"})
    public String queryByIdFwRw(HttpServletRequest request,
                                @RequestParam(value = "emailId", required = false) Integer emailId,
                                @RequestParam(value = "bodyId", required = false) Integer bodyId) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
//		String sqlType = "xoa1001";
        Map<String, Object> maps = new HashMap<String, Object>();
        if (emailId != null) {
            maps.put("emailId", emailId);
        } else {
            maps.put("bodyId", bodyId);
        }
        request.setAttribute("fwRwEmail", emailPlusService.queryByIdCss(maps, 1, 5, false, sqlType,request));
        return "app/email/messageEmail";
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:33:59
     * 方法介绍:   回复或转发
     * 参数说明:	   @param emailBodyModel 邮件参数对象
     * 参数说明:	   @param emailId  获取收件箱ID参数
     * 参数说明:	   @param sendFlag 是否为草稿箱发送 （0：是）
     * 参数说明:   @return
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    @RequestMapping(value = "/sendMessageEmail", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> fwRwEmailBody(
            @RequestParam(value = "emailId") Integer emailId,
            @RequestParam(value = "flag", required = false) String flag,
            @RequestParam(value = "sendFlag", required = false) String sendFlag,
            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
            EmailBodyPlusModel emailBodyModel,
            String sql,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            emailBodyModel.setFromId(userId);
            emailBodyModel.setFromName1(user.getUserName());
            if(!sqlType.equals("xoa" + sql)){
                emailBodyModel.setAvatar(user.getAvatar());
                emailBodyModel.setSex(user.getSex());
                emailBodyModel.setSexName(user.getSexName());
                emailBodyModel.setUserPrivName(user.getUserPrivName());
            }
        }
//        if(emailId != null && emailId>0) {
        if (emailId > 0 && !StringUtils.checkNull(emailId.toString())) {
            maps.put("emailId", emailId);
        } else {
            maps.put("bodyId", emailBodyModel.getBodyId());
        }
        if (StringUtils.checkNull(flag)) {
            String fwRwEmail = emailPlusService.queryByIdCss(maps, 1, 5, false, sqlType,request);
            if ("0".equals(sendFlag)) {
                emailBodyModel.setSendFlag("1");
                emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
                return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
            } else {
                emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
                return emailPlusService.sendEmail(emailBodyModel, new EmailPlusModel(), sqlType, remind, request,sql);
            }
        } else {
            if ("0".equals(sendFlag)) {
                emailBodyModel.setSendFlag("1");
                return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
            } else {
                return emailPlusService.sendEmail(emailBodyModel, new EmailPlusModel(), sqlType, remind, request,sql);
            }
        }
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:33:59
     * 方法介绍:   回复、转发保存或修改到草稿
     * 参数说明:	   @param emailId 原邮件id
     * 参数说明:	   @param emailBodyModel 新邮件参数
     * 参数说明:   @return
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    @RequestMapping(value = "/saveMessageEmail", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> fwRwSaveEmailBody(
            @RequestParam(value = "emailId") Integer emailId,String sql,
            @RequestParam(value = "flag", required = false) String flag,
            EmailBodyPlusModel emailBodyModel,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (emailId > 0 && !StringUtils.checkNull(emailId.toString())) {
            maps.put("emailId", emailId);
        } else {
            maps.put("bodyId", emailBodyModel.getBodyId());
        }
        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            emailBodyModel.setFromId(userId);
            if(!sqlType.equals("xoa" + sql)){
                emailBodyModel.setFromName1(user.getUserName());
                emailBodyModel.setAvatar(user.getAvatar());
                emailBodyModel.setSex(user.getSex());
                emailBodyModel.setSexName(user.getSexName());
                emailBodyModel.setUserPrivName(user.getUserPrivName());
            }
        }
        String flagName = emailBodyModel.getBodyId() + "";
        if (StringUtils.checkNull(flag)) {
            String fwRwEmail = emailPlusService.queryByIdCss(maps, 1, 5, false, sqlType,request);
            emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
            if ("null".equals(flagName)) {
                return emailPlusService.saveEmail(emailBodyModel,sqlType,sql);
            } else {
                emailBodyModel.setSendFlag("0");
                return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
            }
        } else {
            if ("null".equals(flagName)) {
                return emailPlusService.saveEmail(emailBodyModel,sqlType,sql);
            } else {
                emailBodyModel.setSendFlag("0");
                return emailPlusService.draftsSendEmail(emailBodyModel, new EmailPlusModel(), sqlType, request);
            }
        }

    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/17 12:31
     * 方法介绍:   新建其他邮件文件夹
     * 参数说明:
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/saveEmailBox", method = RequestMethod.POST, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBoxModel> saveEmailBox(HttpServletRequest request, EmailBoxModel emailBoxModel) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailBoxModel.getUserId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            emailBoxModel.setUserId(userId);
        }
        return emailPlusService.saveEmailBox(emailBoxModel);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/17 12:35
     * 方法介绍:   把收件箱邮件转移到其他邮件文件夹中
     * 参数说明:
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/updateEmailBox", method = RequestMethod.POST, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailPlusModel> updateEmailBox(HttpServletRequest request, EmailPlusModel emailModel,
                                      @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailModel.getToId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            emailModel.setToId(userId);
        }
        ToJson toJson = new ToJson();
        if (requestFlags != null) {
            for (int i = 0, len = requestFlags.length; i < len; i++) {
                emailModel.setEmailId(Integer.valueOf(requestFlags[i]));
                toJson = emailPlusService.updateEmailBox(emailModel);
            }
            return toJson;
        } else {
            return emailPlusService.updateEmailBox(emailModel);
        }
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/17 12:36
     * 方法介绍:   查询所有其他邮件文件夹
     * 参数说明:
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/showEmailBox", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBoxModel> showEmailBox(HttpServletRequest request,
                                       @RequestParam(value = "page") Integer page, @RequestParam(value = "pageSize") Integer pageSize,
                                       @RequestParam(value = "useFlag") boolean useFlag,
                                       @RequestParam(value = "userId", required = false) String userId) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(userId)) {
//			userId = (String)request.getSession().getAttribute("userId");
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            maps.put("userId", userId);
        } else {
            userId = userId.trim();
            maps.put("userId", userId);
        }
        return emailPlusService.showEmailBox(maps, page, pageSize, useFlag);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 11:09
     * 方法介绍:   其他邮箱中的邮件列表
     * 参数说明:
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/selectBoxEmail", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> selectBoxEmail(HttpServletRequest request,
                                          @RequestParam(value = "page") Integer page, @RequestParam(value = "pageSize") Integer pageSize,
                                          @RequestParam(value = "useFlag") boolean useFlag,
                                          @RequestParam(value = "toId", required = false) String toId, @RequestParam(value = "boxId") Integer boxId,
                                          @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                          @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(toId)) {
            toId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            maps.put("fromId", toId);
        } else {
            toId = toId.trim();
            maps.put("fromId", toId);
        }
        maps.put("boxId", boxId);
        if (!StringUtils.checkNull(searchCriteria)) {
            maps.put("searchCriteria", "%" + searchCriteria + "%");
        }
        maps.put("isWebmail", isWebmail);
        maps.put("orderByName", returnMapValue().get(orderByName));
        maps.put("orderWhere", returnMapValue().get(orderWhere));
        return emailPlusService.selectBoxEmail(maps, page, pageSize, useFlag, sqlType);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 11:25
     * 方法介绍:   其他邮件删除
     * 参数说明:
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/deleteBoxEmail", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> deleteBoxEmail(HttpServletRequest request,
                                          @RequestParam(value = "page") Integer page, @RequestParam(value = "pageSize") Integer pageSize,
                                          @RequestParam(value = "useFlag") boolean useFlag,
                                          @RequestParam(value = "fromId", required = false) String fromId, @RequestParam(value = "boxId") Integer boxId) {
//		fromId  收件人用户
//		boxId
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(fromId)) {
            String toId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            maps.put("fromId", toId);
        } else {
            maps.put("fromId", fromId.trim());
        }
        maps.put("boxId", boxId);
        return emailPlusService.deleteBoxEmail(maps, page, pageSize, useFlag);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 11:28
     * 方法介绍:   其他邮件文件夹名字和序号修改
     * 参数说明: 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @RequestMapping(value = "/updateEmailBoxName", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBoxModel> updeateEmailBoxName(HttpServletRequest request, EmailBoxModel emailBoxModel) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailBoxModel.getUserId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
            emailBoxModel.setUserId(userId);
        }
        return emailPlusService.updeateEmailBoxName(emailBoxModel);
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:39:24
     * 方法介绍:   为null时转换为""
     * 参数说明:   @param value 需转换字符串
     * 参数说明:   @return Json
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return String
     */
    public static String returnValue(String value) {
        if (value != null) {
            return value;
        } else {
            return "";
        }
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 19:44
     * 方法介绍:   新建外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @RequestMapping(value = "/saveWebMail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public @ResponseBody
    ToJson<Webmail> saveWebMail(Webmail webmail, HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(webmail.getUserId())) {
            webmail.setUserId(SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId());
        }
        return emailPlusService.saveWebMail(webmail);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 19:45
     * 方法介绍:   修改外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @RequestMapping(value = "/updateWebMail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public @ResponseBody
    ToJson<Webmail> updateWebMail(Webmail webmail, HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(webmail.getUserId())) {
            webmail.setUserId(SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId());
        }
        return emailPlusService.updateWebMail(webmail);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 19:47
     * 方法介绍:   删除外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @RequestMapping(value = "/deleteWebMail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public @ResponseBody
    ToJson<Webmail> deleteWebMail(@RequestParam("mailId") Integer mailId, HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        return emailPlusService.deleteWebMail(mailId);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 16:01
     * 方法介绍:   单条外部邮件详细查询
     * 参数说明:
     *
     * @return
     */
    @RequestMapping(value = "/selectOneWebMail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public @ResponseBody
    ToJson<Webmail> selectOneWebMail(
            @RequestParam("userId") String userId, @RequestParam("mailId") Integer mailId, HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(userId)) {
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
        }
        return emailPlusService.selectOneWebMail(userId, mailId);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 12:02
     * 方法介绍:   根据用户user_id查询外部邮箱列表
     * 参数说明:
     *
     * @return
     */
    @RequestMapping(value = "/selectUserWebMail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public @ResponseBody
    ToJson selectUserWebMail(HttpServletRequest request, @RequestParam("userId") String userId) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(userId)) {
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
        }
        return emailPlusService.selectUserWebMail(userId);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:38:04
     * 方法介绍:   多条件查询邮件
     * 参数说明:   @return Json
     * 参数说明:   @throws Exception
     * 作废
     *
     * @return String
     */
    @RequestMapping(value = "/querylistEmailBody", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> querylistEmailBody(HttpServletRequest request) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        // maps.put("startTime",starttime);
        // maps.put("endTime", endtime);
        maps.put("readFlag", 1);
        maps.put("boxId", 0);
        maps.put("userName", "李佳");
        maps.put("sign", "");
        maps.put("keyword", "通知");
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        tojson = emailPlusService.selectEmailBody(maps, 1, 10, true, sqlType);
        if (tojson.getObj().size() > 0) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
            Map<String, String> map = new HashMap<String, String>();
        } else {
            tojson.setFlag(1);
            tojson.setMsg("error");
        }
        return tojson;
    }

    /**
     * 作者: 张航宁
     * 日期: 2017/12/19
     * 说明: 撤回邮件 (设置撤回状态)
     */
    @ResponseBody
    @RequestMapping("/updateEmailWithdraw")
    public ToJson<EmailPlusModel> updateEmailWithdraw(Integer bodyId) {
        return emailPlusService.updateEmailWithdraw(bodyId);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/5 15:02
     * 方法介绍:   倒序查询排序及条件
     * 参数说明:
     *
     * @return
     */
    public static Map<String, String> returnMapValue() {
        Map<String, String> maps = new HashMap<String, String>();
        maps.put("0", "ASC"); //升序
        maps.put("1", "DESC");//降序

        maps.put("2", "eb.SEND_TIME");//日期
        maps.put("3", "eb.FROM_ID");//发件人
        maps.put("4", "e.READ_FLAG");//是否已读
        maps.put("5", "e.SIGN");//星标
        maps.put("6", "eb.ATTACHMENT_ID");//附件
        return maps;
    }


    @RequestMapping("/inboxup")
    public String inboxUp(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/inboxup";
    }

    @RequestMapping("/addbox")
    public String writeMail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/addbox";
    }

    @RequestMapping("/index")
    public String emailIndex(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/index";
    }

    @RequestMapping("/mailQuery")
    public String mailQuery(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/mailQuery";
    }

    @RequestMapping("/development")
    public String develOpment(HttpServletRequest request)
            throws Exception {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/common/development";
    }

    @RequestMapping("/writeEmail")
    public String writeEmail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/writeMail";
    }

    @RequestMapping("/writeMail2")
    public String writeMail2(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/writeMail2";
    }

    @RequestMapping("/details")
    public String details(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);


        return "app/emailPlus/details";
    }

    @RequestMapping("/manageMail")
    public String manageMail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/manageMail";
    }

    /**
     * 收件箱横版展示页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/inBoxUp")
    public String inBoxUp(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/inboxup";
    }

    /**
     * 邮件列表展示页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/emailList")
    public String emailList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/emailList";
    }

    /**
     * 邮件主页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/emailIndex")
    public String index2(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/index2";
    }

    /**
     * 邮件统计页面
     *
     * @param request
     * @return
     */
    @RequestMapping("/eamilStatis")
    public String eamilStatis(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/eamilStatis";
    }

    /**
     * 邮件统计详情列表
     *
     * @param request
     * @return
     */
    @RequestMapping("/eamilStatisDetailList")
    public String eamilStatisDetailList(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/eamilStatisDetailList";
    }

    /**
     * 邮件详情信息
     *
     * @param request
     * @return
     */
    @RequestMapping("/eamilDetailByOne")
    public String eamilDetailByOne(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/eamilDetailByOne";
    }

    @RequestMapping("/emptyFolder")
    public String emptyFolder(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/emptyFolder";
    }

//    @RequestMapping("addwebbox")
//    public String addwebbox(HttpServletRequest request) {
//        ContextHolder.setConsumerType("xoa" + (String) request.getSession().getAttribute(
//                "loginDateSouse"));
//        return  "app/email/addwebbox";
//    }

    @RequestMapping("/getEmailReadDetail")
    @ResponseBody
    public BaseWrappers getEmailReadDetail(Integer bodyId, String userIds) {
        return emailPlusService.getEmailReadDetail(bodyId, userIds);
    }

    @RequestMapping("/emailReadDetail")
    public String pageEmailReadDetail(Model model, Integer bodyId, String userIds) {
        model.addAttribute("bodyId", bodyId);
        model.addAttribute("userIds", userIds);
        return "app/emailPlus/readDetails";
    }

    /**
     * 创建作者：张丽军
     * 创建时间：2017-12-19  下午14：00
     * 方法介绍：邮件统计
     *
     * @param request
     * @param sendTime
     * @param toId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/selectCount", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailBodyPlusModel> selectCount(HttpServletRequest request, String sendTime, Integer toId) {
        return emailPlusService.selectCount(request, sendTime, toId);
    }

    /**
     * 创建作者：张丽军
     * 创建时间：2017-12-19  下午14：00
     * 方法介绍：邮件详情列表
     *
     * @param request
     * @param sendTime
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/selectListByMoths", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailBodyPlusModel> selectListByMoths(HttpServletRequest request, String sendTime) {
        return emailPlusService.selectListByMoths(request, sendTime);
    }

    /**
     * 创建作者：张丽军
     * 创建时间：2017-12-19  下午14：00
     * 方法介绍：查看详情根据id
     *
     * @param request
     * @param bodyId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/selectDetailById", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailBodyPlusModel> selectDetailById(HttpServletRequest request, Integer bodyId) {
        return emailPlusService.selectDetailById(request, bodyId);
    }

    //H5微应用
    //邮件列表
    @RequestMapping("/emailh5")
    public String emailh5() {
        return "/app/emailPlus/m/emailh5";
    }
    //写邮件
    @RequestMapping("/addMailh5")
    public String addMailh5() {
        return "/app/emailPlus/m/add_mailh5";
    }
    //邮件详情
    @RequestMapping("/detailh5")
    public String detailh5() {
        return "/app/emailPlus/m/detailh5";
    }
    //转发邮件
    @RequestMapping("/turnMailh5")
    public String turnMailh5() {
        return "/app/emailPlus/m/turn_mailh5";
    }
    //选择人员
    @RequestMapping("/emailPoph5")
    public String emailPoph5() {
        return "/app/emailPlus/m/emailPoph5";
    }
    //回复邮件
    @RequestMapping("/replyMailh5")
    public String replyMailh5() {
        return "/app/emailPlus/m/replyMailh5";
    }


    @RequestMapping("/emailSet")
    public String EmailSet(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/emailSet";
    }

    @RequestMapping("/addEmailSet1")
    public String EmailSet1(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/addEmailSet";
    }

    @ResponseBody
    @RequestMapping(value = "/addEmailSet", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailSet> addEmailSet(HttpServletRequest request,EmailSet emailSet){

        return emailPlusService.addEmailSet(request,emailSet);
    }

    @ResponseBody
    @RequestMapping("/delEmailSet")
    public ToJson<EmailSet> delEmailSetById(HttpServletRequest request,int essId){
        return emailPlusService.delEmailSetById(request,essId);
    }

    @ResponseBody
    @RequestMapping("/updateEmailSet")
    public ToJson<EmailSet> updateEmailSet(HttpServletRequest request,EmailSet emailSet){
        return emailPlusService.updateEmailSetById(request,emailSet);
    }

    @ResponseBody
    @RequestMapping("/selEmailSet")
    public ToJson<EmailSet> selEmailSet(HttpServletRequest request){
        return emailPlusService.selEmailSet(request);
    }

    /**
     * 创建作者：李燃
     * 创建时间：2018-04-26  下午15:19
     * 方法介绍：邮件审批模块

     */
    @RequestMapping("/emailCheck")
    public String emailCheck(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/emailPlus/emailCheck";
    }

    /**
     * 邮件设置反显，根据部门进行反显
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/selEmailSetByDept")
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request,int essId){
        return emailPlusService.selEmailSetByDept(request,essId);
    }

    /**
     * 查询需要进行一般审批的邮件
     * @return
     */
    @ResponseBody
    @RequestMapping("/selExamEmail")
    public ToJson<EmailBodyPlusModel> selExamEmail(HttpServletRequest request){
        return emailPlusService.selExamEmail(request);
    }

    /**
     * 审批邮件
     * flag:1-一般邮件审批，2-过滤词审批
     * @return
     */
    @ResponseBody
    @RequestMapping("/examEmail")
    public ToJson<EmailBodyPlusModel> examEmail(EmailBodyPlusModel emailBodyModel,Integer flag,HttpServletRequest request){
        return emailPlusService.examEmail(emailBodyModel,flag,request);
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     * @return
     */
    @ResponseBody
    @RequestMapping("/selwordExamEmail")
    public ToJson<EmailBodyPlusModel> selWordExamEmail(HttpServletRequest request){
        return emailPlusService.selWordExamEmail(request);
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-4-20 上午10:35:16
     * 方法介绍:   查询列表
     * 参数说明:   @param  request inbox 收件箱 drafts 草稿箱 outbox 发件箱 recycle 废纸篓 noRead 未读
     * 参数说明:   @return json
     * 参数说明:   @throws Exception
     *
     * @return String
     */
    @SuppressWarnings("all")
    @RequestMapping(value = "/newShowEmail", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyPlusModel> newShowEmail(HttpServletRequest request, @RequestParam("flag") String flag,
                                        @RequestParam("page") Integer page, @RequestParam("pageSize") Integer pageSize,
                                        @RequestParam("useFlag") boolean useFlag,
                                        @RequestParam(value = "userID", required = false) String userFrom, @RequestParam(value = "startDate", required = false) String startDate,
                                        @RequestParam(value = "endDate", required = false) String endDate, @RequestParam(value = "subject", required = false) String subject,
                                        @RequestParam(value = "content", required = false) String content, @RequestParam(value = "attachmentName", required = false) String attachmentName,
                                        @RequestParam(value = "readFlag", required = false) String readFlag, @RequestParam(value = "fromUserId", required = false) String fromUserId,
                                        @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                        @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail, String queryField) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        String userId = "";
        if (StringUtils.checkNull(userFrom)) {
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserId();
        } else {
            userId = userFrom.trim();
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId", userId);
        if (!StringUtils.checkNull(subject)) {
            maps.put("subject", "%" + subject + "%");
        }
        if (!StringUtils.checkNull(content)) {
            maps.put("content", "%" + content + "%");
        }
        if (!StringUtils.checkNull(attachmentName)) {
            maps.put("attachmentName", "%" + attachmentName + "%");
        } else {
            maps.put("attachmentName", "");
        }
        if (!StringUtils.checkNull(startDate)) {
            maps.put("startTime", DateFormat.getTime(startDate));
        }
        if (!StringUtils.checkNull(endDate)) {
            maps.put("endTime", DateFormat.getTime(endDate));
        }
        if (!StringUtils.checkNull(searchCriteria)) {
            maps.put("searchCriteria", "%" + searchCriteria + "%");
        }
        maps.put("isWebmail", isWebmail);
        maps.put("queryField", queryField);
        maps.put("orderByName", returnMapValue().get(orderByName));
        maps.put("orderWhere", returnMapValue().get(orderWhere));
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();

        tojson=emailPlusService.selectNewShowEmail(flag,request,maps, page, pageSize, useFlag, sqlType);
        if (tojson.getObj().size() > 0) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            if(flag.trim().equals("drafts")){
                tojson.setFlag(0);
                tojson.setMsg("ok");
            }else{
                tojson.setFlag(1);
                tojson.setMsg("error");
            }
        }
        return tojson;
    }

}


