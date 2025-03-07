package com.xoa.controller.email;

import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.AppLog;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailBoxModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.service.email.EmailService;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.util.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.mail.internet.MimeUtility;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.zip.Adler32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:32:14
 * 类介绍  :   邮件
 * 构造参数:
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/email")
public class EmailController {


    @Resource
    private EmailService emailService;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private UserExtMapper userExtMapper;

    @Resource
    private SmsService smsService;

    @Resource
    Sms2PrivService sms2PrivService;

    @Autowired
    private EnclosureService enclosureService;

    @Resource
    private SysTasksService sysTasksService;

    //    邮件审批
    @RequestMapping("/mailApproval")
    public String mailApproval(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String bodyId = request.getParameter("bodyId");
        if (!StringUtils.checkNull(bodyId)) {
            smsService.setSmsReadStatus(request, Integer.valueOf(bodyId));
        }
        return "app/email/mailApproval";
    }


    @RequestMapping("/transfer")
    public String transfer(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/transfer";
    }

    @RequestMapping("/internetEmailList")
    public String internetEmailList() {
        return "app/email/internetEmailList";
    }

    @RequestMapping("/internetEmailInfo")
    public String internetEmailInfo() {
        return "app/email/internetEmailInfo";
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
    @RequestMapping(value = "/sendEmail", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public @ResponseBody
    ToJson<EmailBodyModel> insertEmailBody(
            EmailBodyModel emailBodyModel,
            @RequestParam(value = "sendFlag", required = false) String sendFlag,
            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);

        // 工作流 内部邮件提醒参数
        List<Users> users = new ArrayList<>();
        String mailTo =  request.getParameter("mailTo");
        String mailToDept = request.getParameter("mailToDept");
        String mailToPriv = request.getParameter("mailToPriv");
        if(!StringUtils.checkNull(mailToDept)){
            users = usersMapper.selectUserByDeptIds(mailToDept.split(","));
        }
        if(!StringUtils.checkNull(mailToPriv)){
            users.addAll(usersMapper.getUsersByPrivIds(mailToPriv.split(",")));
        }
        if(!StringUtils.checkNull(mailTo)){
            if(!mailTo.endsWith(","))
                mailTo+=",";
        } else {
            mailTo = "";
        }
        // 拼接所有发送人
        for (Users user : users) {
            mailTo+= user.getUserId() + ",";
        }


        emailBodyModel.setToId2(mailTo+emailBodyModel.getToId2());
        String toID = emailBodyModel.getToId2().trim()
                + emailBodyModel.getCopyToId().trim()
                + emailBodyModel.getSecretToId().trim();

        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        UserExt userExt = userExtMapper.selUserExtByUserId(user.getUserId());
        //UserExt userExt = userExtMapper.selUserExtByUserId("116");
        String emailRecentLinkman = userExt.getEmailRecentLinkman();


        // 去重 规则改变 暂时注释
        /*for (String emailRecentLinkmanId:split){
            for (String toId:toID2){
                if(emailRecentLinkmanId.equals(toId)){
                    emailRecentLinkman = emailRecentLinkman.replace(toId+",","");
                }
            }
        }*/
        if (toID != null && !toID.equals("")) {
            if (!toID.substring(toID.length() - 1).equals(",")) {
                toID += ",";
            }
        }
        emailRecentLinkman = toID + emailRecentLinkman;
        if (emailRecentLinkman.length() > 200) {
            emailRecentLinkman = emailRecentLinkman.substring(0, 200);
        }
        userExt.setEmailRecentLinkman(emailRecentLinkman);
        userExtMapper.updateUserExtByUid(userExt);

        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBodyModel.setFromId(userId);
        }
        if (emailBodyModel.getToId2().equals("")) {
            emailBodyModel.setToId2(user.getUserId());
        }

        try {
            //发送邮件时判断附件大小设置邮件SIZE
            List<Attachment> attachments = GetAttachmentListUtils.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId()
                    , sqlType, GetAttachmentListUtils.MODULE_EMAIL);
            String changeSizes = attachments.stream().map(Attachment::getSize).collect(Collectors.joining(","));
            Long emailSize = FileUtility.computingCapacity(0L, changeSizes, 1);
            emailBodyModel.setSize(emailSize);
        }catch (Exception e){
            e.printStackTrace();
        }

        if ("0".equals(sendFlag)) {
            emailBodyModel.setSendFlag("1");
            return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
        } else {
            return emailService.sendEmail(emailBodyModel, new EmailModel(), sqlType, remind, request);
        }

    }

    @RequestMapping(value = "/sendEmailCross", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public @ResponseBody
    ToJson<EmailBodyModel> sendEmailCross(
            EmailBodyModel emailBodyModel, String senduserid,
            @RequestParam(value = "sendFlag", required = false) String sendFlag,
            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
            HttpServletRequest request, String xoa) {
        ToJson<EmailBodyModel> sendEmailCross = new ToJson<EmailBodyModel>();

        String sqlType = "xoa" + xoa;
        String[] strArray = xoa.split(",");
        for (int i = 0; i < strArray.length; i++) {
            sqlType = "xoa" + strArray[i];
            ContextHolder.setConsumerType(sqlType);


            String toID = emailBodyModel.getToId2().trim()
                    + emailBodyModel.getCopyToId().trim()
                    + emailBodyModel.getSecretToId().trim();
            String[] toID2 = toID.split(",");
//        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
//        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            UserExt userExt = userExtMapper.selUserExtByUserId(senduserid);
            String emailRecentLinkman = userExt.getEmailRecentLinkman();
            // 去重 规则改变 暂时注释
        /*for (String emailRecentLinkmanId:split){
            for (String toId:toID2){
                if(emailRecentLinkmanId.equals(toId)){
                    emailRecentLinkman = emailRecentLinkman.replace(toId+",","");
                }
            }
        }*/
            if (toID != null && !toID.equals("")) {
                if (!toID.substring(toID.length() - 1).equals(",")) {
                    toID += ",";
                }
            }
            emailRecentLinkman = toID + emailRecentLinkman;
            if (emailRecentLinkman.length() > 200) {
                emailRecentLinkman = emailRecentLinkman.substring(0, 200);
            }
            userExt.setEmailRecentLinkman(emailRecentLinkman);
            userExtMapper.updateUserExtByUid(userExt);

            if (StringUtils.checkNull(emailBodyModel.getFromId())) {
//            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId).getUserId();
                emailBodyModel.setFromId(senduserid);
            }
            if (emailBodyModel.getToId2().equals("")) {
                emailBodyModel.setToId2(senduserid);
            }
            if ("0".equals(sendFlag)) {
                emailBodyModel.setSendFlag("1");
                return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
            } else {
                String[] strArray1 = emailBodyModel.getToId2().split(",");
                for (int j = 0; j < strArray1.length; j++) {
                    emailBodyModel.setToId2(strArray1[j]);
                    sendEmailCross = emailService.sendEmailCross(emailBodyModel, new EmailModel(), sqlType, remind, request, senduserid);
                    break;
                }

            }
        }
        return sendEmailCross;
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
    ToJson<EmailBodyModel> saveEmailBody(
            EmailBodyModel emailBodyModel,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBodyModel.setFromId(userId);
        }
        if (emailBodyModel.getBodyId() == null) {

            return emailService.saveEmail(emailBodyModel);
        } else {
            emailBodyModel.setSendFlag("0");
            return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
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
    @RequestMapping("/showEmail")
    public @ResponseBody
    ToJson<EmailBodyModel> queryEmail(HttpServletRequest request, HttpServletResponse response,
                                      String flag, Integer page, Integer pageSize, boolean useFlag,
                                      @RequestParam(value = "userID", required = false) String userFrom, @RequestParam(value = "startDate", required = false) String startDate,
                                      @RequestParam(value = "endDate", required = false) String endDate, @RequestParam(value = "subject", required = false) String subject,
                                      @RequestParam(value = "content", required = false) String content, @RequestParam(value = "attachmentName", required = false) String attachmentName,
                                      @RequestParam(value = "readFlag", required = false) String readFlag, @RequestParam(value = "fromUserId", required = false) String fromUserId,
                                      @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                      @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail,
                                      @RequestParam(value = "copyTime", required = false) String copyTime, @RequestParam(value = "toId2", required = false) String toId2, String queryField,
                                      String bodyIds) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("fromId",userId);
        if(!StringUtils.checkNull(fromUserId)){
            maps.put("toId", fromUserId);
        }
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
        if (!StringUtils.checkNull(bodyIds)) {
            maps.put("bodyIds", Arrays.asList(bodyIds.split(",")));
        }
        maps.put("isWebmail", isWebmail);
        maps.put("queryField", queryField);
        maps.put("orderByName", returnMapValue().get(orderByName));
        maps.put("orderWhere", returnMapValue().get(orderWhere));
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        if (copyTime == null || copyTime.equals("")) {  //普通邮件箱查询
            if (flag.trim().equals("inbox")) {
                maps.put("readFlag", readFlag);
                maps.put("fromUserId", fromUserId);
                tojson = emailService.selectInbox(request, maps, page, pageSize, useFlag, sqlType);
            } else if (flag.trim().equals("drafts")) {
                tojson = emailService.listDrafts(maps, page, pageSize, useFlag, sqlType);
            } else if (flag.trim().equals("outbox")) {
                maps.put("toId2", toId2);
                tojson = emailService.listSendEmail(maps, page, pageSize, useFlag, sqlType);
            } else if (flag.trim().equals("recycle")) {
                tojson = emailService.listWastePaperbasket(maps, page, pageSize, useFlag, sqlType);
            } else if (flag.trim().equals("noRead")) {
                tojson = emailService.selectIsRead(maps, page, pageSize, useFlag, sqlType);
            } else {
                tojson = emailService.selectEmail(maps, page, pageSize, useFlag, sqlType);
            }
        } else {  //归档邮件箱查询
            maps.put("readFlag", readFlag);
            maps.put("fromUserId", fromUserId);
            maps.put("toId2", toId2);
            tojson = emailService.gdSelect(maps, request, flag.trim(), page, pageSize, useFlag, copyTime.trim());
        }
        if (tojson.getObj().size() > 0) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            if (flag.trim().equals("drafts")) {
                tojson.setFlag(0);
                tojson.setMsg("ok");
            } else {
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
    ToJson<EmailBodyModel> queryByID(HttpServletRequest request, @RequestParam(value = "emailId", required = false) Integer emailId, @RequestParam("flag") String flag, @RequestParam(value = "bodyId", required = false) Integer bodyId, @RequestParam(value = "copyTime", required = false) Integer copyTime) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("emailId", emailId);
        maps.put("bodyId", bodyId);
        maps.put("copyTime", copyTime);
        try {
            EmailBodyModel emailBody = emailService.queryById(maps, 1, 5, false, sqlType);
            List<EmailModel> emailList = emailBody.getEmailList();
                for (EmailModel emailModel : emailList) {
                    if (users.getUserId().equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())) {
                        emailBody.setAttachment(new ArrayList<Attachment>());
                        emailBody.setAttachmentName("");
                        emailBody.setAttachmentId("");
                        emailBody.setContent(I18nUtils.getMessage("email.th.theEmailHasBeenRecalled"));
                    }
                }
            if (!emailBody.getFromId().equals(users.getUserId())) {
                if (!emailBody.getToId2().contains(users.getUserId())) {
                    if (!emailBody.getCopyToId().contains(users.getUserId())) {
                        if (!emailBody.getSecretToId().contains(users.getUserId())) {
                            tojson.setFlag(1);
                            tojson.setMsg(I18nUtils.getMessage("email.th.noViewingPermission"));
                            return tojson;
                        }
                    }
                }
            }
            if (flag.equals("copy")) {
                List<Attachment> attachmentList = emailBody.getAttachment();
                Attachment attach = null;
                Attachment attachment = null;
                List<Attachment> listCopy = new ArrayList<Attachment>();
                for (int i = 0; i < attachmentList.size(); i++) {
                    attach = attachmentList.get(i);
                    String path = this.getPath(attach.getYm(), sqlType, GetAttachmentListUtil.MODULE_EMAIL, attach.getAttachId(), attach.getAttachName());
                    File file = new File(path);
                    String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                    //当前年月
                    String ym = new SimpleDateFormat("yyMM").format(new Date());
                    String destPath = this.getPath(ym, sqlType, GetAttachmentListUtil.MODULE_EMAIL, attachID, attach.getAttachName());
                    File dest = new File(destPath);

                    if (file.exists()){
                    FileUploadUtil.copyFileUsingFileChannels(file, dest);
                    }
                    String fileSize = Convert.convertFileSize(file.length());
                    Integer isImg = 3;
                    //获取后缀名
                    String type = attach.getAttachName().substring(attach.getAttachName().indexOf(".") + 1);
                    String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                    List<String> imageTyepLists = Arrays.asList(imagType);
                    if (imageTyepLists.contains(type)) {
                        isImg = 0;
                    } else {
                        isImg = 1;
                    }
                    //获得模块名
                    int moduleID = 0;
                    for (ModuleEnum em : ModuleEnum.values()) {
                        if (em.getName().equals(GetAttachmentListUtil.MODULE_EMAIL)) {
                            moduleID = em.getIndex();
                        }
                    }
                    attachment = new Attachment();
                    attachment.setAttachId(attachID);
                    attachment.setModule(moduleID);
                    attachment.setAttachFile(attach.getAttachName());
                    attachment.setAttachName(attach.getAttachName());
                    attachment.setYm(ym);
                    attachment.setAttachSign(new Long(0));
                    attachment.setDelFlag(0);
                    attachment.setPosition(2);
                    attachment.setIsImage(isImg);
                    attachment.setSize(fileSize);
                    attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                    enclosureService.saveAttachment(attachment);
                    String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + GetAttachmentListUtil.MODULE_EMAIL + "&COMPANY=" + sqlType + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                            "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
                    attachment.setAttUrl(attUrl);
                    listCopy.add(attachment);
                }
                Object[] o = FileUploadUtil.reAttachment(listCopy);
                emailBody.setAttachmentId(o[0].toString());
                emailBody.setAttachmentName(o[1].toString());
                emailBody.setAttachment(listCopy);
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
                EmailModel email = new EmailModel();
                email.setEmailId(emailId);
                email.setReadFlag("1");
                //插入 邮件已读时间等信息到 app_log表
                AppLog appLog = new AppLog();
                appLog.setUserId(users.getUid() + "");
                appLog.setTime(new Date());
                appLog.setModule("1");//模块1：电子邮件
                appLog.setType("1"); //type 1 暂时存放1
                appLog.setOppId(emailId + ""); //操作记录的id,这里设置为emailId
                appLog.setRemark(I18nUtils.getMessage("system_setting.remark"));
                emailService.saveAppLog4Email(appLog);
                //归档查询 不用  修改邮件状态
                if (copyTime == null) {
                    emailService.updateIsRead(email);
                }
                emailBody = emailService.queryById(maps, 1, 5, false, sqlType);
                List<EmailModel> emailList2 = emailBody.getEmailList();
                for (EmailModel emailModel : emailList2) {
                    if (users.getUserId().equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())) {
                        emailBody.setAttachment(new ArrayList<Attachment>());
                        emailBody.setAttachmentName("");
                        emailBody.setAttachmentId("");
                        emailBody.setContent(I18nUtils.getMessage("email.th.theEmailHasBeenRecalled"));
                    }
                }
                tojson.setFlag(0);
                tojson.setMsg("ok");
                tojson.setObject(emailBody);
            }
        } catch (Exception e) {
            e.printStackTrace();
            tojson.setMsg("" + e);
            return tojson;
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
    @RequestMapping(value = "/queryByCountID", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<EmailBodyModel> queryByCountID(HttpServletRequest request, @RequestParam(value = "emailId", required = false) Integer emailId, @RequestParam("flag") String flag, @RequestParam(value = "bodyId", required = false) Integer bodyId) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("emailId", emailId);
        maps.put("bodyId", bodyId);
        EmailBodyModel emailBody = emailService.queryByCountID(maps, 1, 5, false, sqlType);
        List<EmailModel> emailList = emailBody.getEmailList();
        for (EmailModel emailModel : emailList) {
            if (users.getUserId().equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())) {
                emailBody.setAttachment(new ArrayList<Attachment>());
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
                emailBody.setContent(I18nUtils.getMessage("email.th.theEmailHasBeenRecalled"));
            }
        }
        if (!emailBody.getFromId().equals(users.getUserId())) {
            if (!emailBody.getToId2().contains(users.getUserId())) {
                if (!emailBody.getCopyToId().contains(users.getUserId())) {
                    if (!emailBody.getSecretToId().contains(users.getUserId())) {
                        tojson.setFlag(1);
                        tojson.setMsg(I18nUtils.getMessage("email.th.noViewingPermission"));
                        return tojson;
                    }
                }
            }
        }
        if (flag.equals("copy")) {
            List<Attachment> attachmentList = emailBody.getAttachment();
            Attachment attach = null;
            Attachment attachment = null;
            List<Attachment> listCopy = new ArrayList<Attachment>();
            for (int i = 0; i < attachmentList.size(); i++) {
                attach = attachmentList.get(i);
                String path = this.getPath(attach.getYm(), sqlType, GetAttachmentListUtil.MODULE_EMAIL, attach.getAttachId(), attach.getAttachName());
                File file = new File(path);
                String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                String newFileName = attachID + "." + attachmentList.get(i).getAttachName().toString();
                //当前年月
                String ym = new SimpleDateFormat("yyMM").format(new Date());
                String destPath = this.getPath(ym, sqlType, GetAttachmentListUtil.MODULE_EMAIL, attachID, attach.getAttachName());
                File dest = new File(destPath);
                FileUploadUtil.copyFileUsingFileChannels(file, dest);
                Integer isImg = 3;
                //获取后缀名
                String type = attach.getAttachName().substring(attach.getAttachName().indexOf(".") + 1);
                String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                List<String> imageTyepLists = Arrays.asList(imagType);
                if (imageTyepLists.contains(type)) {
                    isImg = 0;
                } else {
                    isImg = 1;
                }
                //获得模块名
                int moduleID = 0;
                for (ModuleEnum em : ModuleEnum.values()) {
                    if (em.getName().equals(GetAttachmentListUtil.MODULE_EMAIL)) {
                        moduleID = em.getIndex();
                    }
                }

                attachment = new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(attach.getAttachName());
                attachment.setAttachName(attach.getAttachName());
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachment.setIsImage(isImg);
                //String url = path + System.getProperty("file.separator") + newFileName;
                //attachment.setUrl(url);
                attachment.setSize(attach.getSize());
                attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                enclosureService.saveAttachment(attachment);
                String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + GetAttachmentListUtil.MODULE_EMAIL + "&COMPANY=" + sqlType + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                        "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
                attachment.setAttUrl(attUrl);
                listCopy.add(attachment);
            }
            Object[] o = FileUploadUtil.reAttachment(listCopy);
            emailBody.setAttachmentId(o[0].toString());
            emailBody.setAttachmentName(o[1].toString());
            emailBody.setAttachment(listCopy);
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
            EmailModel email = new EmailModel();
            email.setEmailId(emailId);
            email.setReadFlag("1");

            //插入 邮件已读时间等信息到 app_log表

            AppLog appLog = new AppLog();
            appLog.setUserId(users.getUid() + "");
            appLog.setTime(new Date());
            appLog.setModule("1");//模块1：电子邮件
            appLog.setType("1"); //type 1 暂时存放1
            appLog.setOppId(emailId + ""); //操作记录的id,这里设置为emailId
            appLog.setRemark(I18nUtils.getMessage("system_setting.remark"));
            emailService.saveAppLog4Email(appLog);

            emailService.updateIsRead(email);
            emailBody = emailService.queryById(maps, 1, 5, false, sqlType);
            List<EmailModel> emailList2 = emailBody.getEmailList();
            for (EmailModel emailModel : emailList2) {
                if (users.getUserId().equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())) {
                    emailBody.setAttachment(new ArrayList<Attachment>());
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                    emailBody.setContent(I18nUtils.getMessage("email.th.theEmailHasBeenRecalled"));
                }
            }
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
    ToJson<EmailBodyModel> deleteEmail(@RequestParam("flag") String flag, @RequestParam(value = "deleteFlag", required = false) String deleteFlag,
                                       @RequestParam(value = "emailID", required = false) Integer emailId,
                                       @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags,
                                       @RequestParam(value = "deleteFlags[]", required = false) String[] deleteFlags, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        String returnRes = "";
        if (requestFlags != null) {
            if (flag.trim().equals("inbox")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailService.deleteInEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            } else if (flag.trim().equals("outbox")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailService.deleteOutEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            } else if (flag.trim().equals("recycle")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailService.deleteRecycleEmail(Integer.valueOf(requestFlags[i]), deleteFlags[i]);
                }
            }else if (flag.trim().equals("drafts")) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    returnRes = emailService.deleteDraftsEmail(Integer.valueOf(requestFlags[i]));
                }
            }
        } else {
            if (flag.trim().equals("inbox")) {
                returnRes = emailService.deleteInEmail(emailId, deleteFlag);
            } else if (flag.trim().equals("outbox")) {
                returnRes = emailService.deleteOutEmail(emailId, deleteFlag);
            } else if (flag.trim().equals("recycle")) {
                returnRes = emailService.deleteRecycleEmail(emailId, deleteFlag);
            }
        }
//		else if (flag.trim().equals("drafts")) {
//			emailService.deleteRecycleEmail(emailBodyModel, deleteFlag);
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


    //刘旭辉一键清空
    @ResponseBody
    @RequestMapping("/deleteRecycleEmails")
    public ToJson<EmailModel> deleteRecycleEmails(HttpServletRequest request){
        return  emailService.deleteRecycleEmails(request);
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
    ToJson<EmailBodyModel> deleteDraftsEmail(@RequestParam(value = "bodyId", required = false) Integer bodyId,
                                             @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags,
                                             HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        try {
            ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>(0, "ok");
            if (requestFlags != null) {
                for (int i = 0, len = requestFlags.length; i < len; i++) {
                    emailService.deleteByID(Integer.valueOf(requestFlags[i]));
                }
            } else {
                emailService.deleteByID(bodyId);
            }
            return tojson;
        } catch (Exception e) {
            ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>(1, "error");
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
    @RequestMapping(value = "/messageEmailCount", produces = {"application/json;charset=UTF-8"})
    public String messageEmailCount(HttpServletRequest request,
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
        request.setAttribute("fwRwEmail", emailService.queryByIdCssCount(maps, 1, 5, false, sqlType, request));
        return "app/email/messageEmail";
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
        request.setAttribute("fwRwEmail", emailService.queryByIdCss(maps, 1, 5, false, sqlType, request));
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
    ToJson<EmailBodyModel> fwRwEmailBody(
            @RequestParam(value = "emailId") Integer emailId,
            @RequestParam(value = "flag", required = false) String flag,
            @RequestParam(value = "sendFlag", required = false) String sendFlag,
            @RequestParam(value = "remind", required = false, defaultValue = "0") String remind,
            EmailBodyModel emailBodyModel,
            HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(emailBodyModel.getFromId())) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBodyModel.setFromId(userId);
        }
//        if(emailId != null && emailId>0) {
        if (emailId > 0 && !StringUtils.checkNull(emailId.toString())) {
            maps.put("emailId", emailId);
        } else {
            maps.put("bodyId", emailBodyModel.getBodyId());
        }
        if (StringUtils.checkNull(flag)) {
            String fwRwEmail = emailService.queryByIdCss(maps, 1, 5, false, sqlType, request);
            if ("0".equals(sendFlag)) {
                emailBodyModel.setSendFlag("1");
                emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
                return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
            } else {
                emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
                return emailService.sendEmail(emailBodyModel, new EmailModel(), sqlType, remind, request);
            }
        } else {
            if ("0".equals(sendFlag)) {
                emailBodyModel.setSendFlag("1");
                return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
            } else {
                return emailService.sendEmail(emailBodyModel, new EmailModel(), sqlType, remind, request);
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
    ToJson<EmailBodyModel> fwRwSaveEmailBody(
            @RequestParam(value = "emailId") Integer emailId,
            @RequestParam(value = "flag", required = false) String flag,
            EmailBodyModel emailBodyModel,
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBodyModel.setFromId(userId);
        }
        String flagName = emailBodyModel.getBodyId() + "";
        if (StringUtils.checkNull(flag)) {
            String fwRwEmail = emailService.queryByIdCss(maps, 1, 5, false, sqlType, request);
            emailBodyModel.setContent(emailBodyModel.getContent() + fwRwEmail);
            if ("null".equals(flagName)) {
                return emailService.saveEmail(emailBodyModel);
            } else {
                emailBodyModel.setSendFlag("0");
                return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
            }
        } else {
            if ("null".equals(flagName)) {
                return emailService.saveEmail(emailBodyModel);
            } else {
                emailBodyModel.setSendFlag("0");
                return emailService.draftsSendEmail(emailBodyModel, new EmailModel(), sqlType, request);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBoxModel.setUserId(userId);
        }
        return emailService.saveEmailBox(emailBoxModel);
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
    ToJson<EmailModel> updateEmailBox(HttpServletRequest request, EmailModel emailModel,
                                      @RequestParam(value = "requestFlags[]", required = false) String[] requestFlags) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if (StringUtils.checkNull(emailModel.getToId())) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailModel.setToId(userId);
        }
        ToJson toJson = new ToJson();
        if (requestFlags != null) {
            for (int i = 0, len = requestFlags.length; i < len; i++) {
                emailModel.setEmailId(Integer.valueOf(requestFlags[i]));
                toJson = emailService.updateEmailBox(emailModel);
            }
            return toJson;
        } else {
            return emailService.updateEmailBox(emailModel);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            maps.put("userId", userId);
        } else {
            userId = userId.trim();
            maps.put("userId", userId);
        }
        return emailService.showEmailBox(maps, page, pageSize, useFlag);
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
    ToJson<EmailBodyModel> selectBoxEmail(HttpServletRequest request,
                                          @RequestParam(value = "page") Integer page, @RequestParam(value = "pageSize") Integer pageSize,
                                          @RequestParam(value = "useFlag") boolean useFlag,
                                          @RequestParam(value = "toId", required = false) String toId, @RequestParam(value = "boxId") Integer boxId,
                                          @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                          @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(toId)) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            toId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
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
        return emailService.selectBoxEmail(maps, page, pageSize, useFlag, sqlType);
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
    ToJson<EmailBodyModel> deleteBoxEmail(HttpServletRequest request,
                                          @RequestParam(value = "page") Integer page, @RequestParam(value = "pageSize") Integer pageSize,
                                          @RequestParam(value = "useFlag") boolean useFlag,
                                          @RequestParam(value = "fromId", required = false) String fromId, @RequestParam(value = "boxId") Integer boxId) {
//		fromId  收件人用户
//		boxId
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Map<String, Object> maps = new HashMap<String, Object>();
        if (StringUtils.checkNull(fromId)) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String toId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            maps.put("fromId", toId);
        } else {
            maps.put("fromId", fromId.trim());
        }
        maps.put("boxId", boxId);
        return emailService.deleteBoxEmail(maps, page, pageSize, useFlag);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
            emailBoxModel.setUserId(userId);
        }
        return emailService.updeateEmailBoxName(emailBoxModel);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            webmail.setUserId(SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId());
        }
        return emailService.saveWebMail(webmail);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            webmail.setUserId(SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId());
        }
        return emailService.updateWebMail(webmail);
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
        return emailService.deleteWebMail(mailId);
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
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
        }
        return emailService.selectOneWebMail(userId, mailId);
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
    ToJson selectUserWebMail(HttpServletRequest request) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
        return emailService.selectUserWebMail(userId);
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
    ToJson<EmailBodyModel> querylistEmailBody(HttpServletRequest request) throws Exception {
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
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        tojson = emailService.selectEmailBody(maps, 1, 10, true, sqlType);
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
    public ToJson<EmailModel> updateEmailWithdraw(Integer bodyId) {
        return emailService.updateEmailWithdraw(bodyId);
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
        return "app/email/inboxup";
    }

    @RequestMapping("/addbox")
    public String writeMail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        //查询邮件限制
        return "app/email/addbox";
    }

    @RequestMapping("/index")
    public String emailIndex(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/index";
    }

    @RequestMapping("/mailQuery")
    public String mailQuery(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/mailQuery";
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
        return "app/email/writeMail";
    }


    @RequestMapping("/writeMailDetail")
    public String writeMailDetail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/writeEmail";
    }


    @RequestMapping("/emailDetail")
    public String emailDetail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/m/emailDetail";
    }


    @RequestMapping("/writeMail2")
    public String writeMail2(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/writeMail2";
    }

    @RequestMapping("/details")
    public String details(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);


        return "app/email/details";
    }

    @RequestMapping("/manageMail")
    public String manageMail(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/manageMail";
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
        return "app/email/inboxup";
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
        return "app/email/emailList";
    }
//    图片查看
    @RequestMapping("/imgOpen")
    public String imgOpen(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/imgOpen";
    }

    @RequestMapping("/emailInfo")
    public String emailInfo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/emailInfo";
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
        return "app/email/index2";
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
        return "app/email/eamilStatis";
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
        return "app/email/eamilStatisDetailList";
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
        return "app/email/eamilDetailByOne";
    }

    @RequestMapping("/emptyFolder")
    public String emptyFolder(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/emptyFolder";
    }

    //    从文件柜选择附件页面
    @RequestMapping("/formFileCabinet")
    public String formFileCabinet(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/formFileCabinet";
    }

//    @RequestMapping("addwebbox")
//    public String addwebbox(HttpServletRequest request) {
//        ContextHolder.setConsumerType("xoa" + (String) request.getSession().getAttribute(
//                "loginDateSouse"));
//        return  "app/email/addwebbox";
//    }

    @RequestMapping("/getEmailReadDetail")
    @ResponseBody
    public BaseWrappers getEmailReadDetail(Integer bodyId, String userIdsType, String json) {
        return emailService.getEmailReadDetail(bodyId, userIdsType, json);
    }

    @RequestMapping("/emailReadDetail")
    public String pageEmailReadDetail(Model model, Integer bodyId, String userIds) {
        return "app/email/readDetails";
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
    public ToJson<EmailBodyModel> selectCount(HttpServletRequest request, HttpServletResponse response, String sendTime, Integer toId, String export) {
        return emailService.selectCount(request, response, sendTime, toId, export);
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
    public ToJson<EmailBodyModel> selectListByMoths(HttpServletRequest request, String sendTime) {
        return emailService.selectListByMoths(request, sendTime);
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
    public ToJson<EmailBodyModel> selectDetailById(HttpServletRequest request, Integer bodyId) {
        return emailService.selectDetailById(request, bodyId);
    }

    //H5微应用
    //邮件列表
    @RequestMapping("/emailh5")
    public String emailh5() {
        return "/app/email/m/emailh5";
    }

    //写邮件
    @RequestMapping("/addMailh5")
    public String addMailh5() {
        return "/app/email/m/add_mailh5";
    }

    //邮件详情
    @RequestMapping("/detailh5")
    public String detailh5() {
        return "/app/email/m/detailh5";
    }

    //转发邮件
    @RequestMapping("/turnMailh5")
    public String turnMailh5() {
        return "/app/email/m/turn_mailh5";
    }

    //选择人员
    @RequestMapping("/emailPoph5")
    public String emailPoph5() {
        return "/app/email/m/emailPoph5";
    }

    //回复邮件
    @RequestMapping("/replyMailh5")
    public String replyMailh5() {
        return "/app/email/m/replyMailh5";
    }


    @RequestMapping("/emailSet")
    public String EmailSet(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/emailSet";
    }

    @RequestMapping("/addEmailSet1")
    public String EmailSet1(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/email/addEmailSet";
    }

    @ResponseBody
    @RequestMapping(value = "/addEmailSet", produces = {"application/json;charset=UTF-8"})
    public ToJson<EmailSet> addEmailSet(HttpServletRequest request, EmailSet emailSet) {

        return emailService.addEmailSet(request, emailSet);
    }

    @ResponseBody
    @RequestMapping("/delEmailSet")
    public ToJson<EmailSet> delEmailSetById(HttpServletRequest request, int essId) {
        return emailService.delEmailSetById(request, essId);
    }

    @ResponseBody
    @RequestMapping("/updateEmailSet")
    public ToJson<EmailSet> updateEmailSet(HttpServletRequest request, EmailSet emailSet) {
        return emailService.updateEmailSetById(request, emailSet);
    }

    @ResponseBody
    @RequestMapping("/selEmailSet")
    public ToJson<EmailSet> selEmailSet(HttpServletRequest request) {
        return emailService.selEmailSet(request);
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
        return "app/email/emailCheck";
    }

    /**
     * 邮件设置反显，根据部门进行反显
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/selEmailSetByDept")
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request, int essId) {
        return emailService.selEmailSetByDept(request, essId);
    }

    /**
     * 查询需要进行一般审批的邮件
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/selExamEmail")
    public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request) {
        return emailService.selExamEmail(request);
    }

    /**
     * 审批邮件
     * flag:1-一般邮件审批，2-过滤词审批
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/examEmail")
    public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel, Integer flag, HttpServletRequest request) {
        return emailService.examEmail(emailBodyModel, flag, request);
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/selwordExamEmail")
    public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request) {
        return emailService.selWordExamEmail(request);
    }

    /**
     * 电子邮件废纸篓功能恢复邮件
     * 张丽军 2019-10-8
     *
     * @return
     */
    @ResponseBody
    @RequestMapping("/upDateDiu")
    public ToJson<EmailBodyModel> upDateDiu(HttpServletRequest request, String toId, String emailId) {
        return emailService.upDateDiu(request, toId, emailId);
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
    @RequestMapping("/newShowEmail")
    public @ResponseBody
    ToJson<EmailBodyModel> newShowEmail(HttpServletRequest request, HttpServletResponse response,
                                        String flag, Integer page, Integer pageSize, boolean useFlag,
                                        @RequestParam(value = "userID", required = false) String userFrom, @RequestParam(value = "startDate", required = false) String startDate,
                                        @RequestParam(value = "endDate", required = false) String endDate, @RequestParam(value = "subject", required = false) String subject,
                                        @RequestParam(value = "content", required = false) String content, @RequestParam(value = "attachmentName", required = false) String attachmentName,
                                        @RequestParam(value = "readFlag", required = false) String readFlag, @RequestParam(value = "fromUserId", required = false) String fromUserId,
                                        @RequestParam(value = "orderByName", required = false) String orderByName, @RequestParam(value = "orderWhere", required = false) String orderWhere,
                                        @RequestParam(value = "searchCriteria", required = false) String searchCriteria, @RequestParam(value = "isWebmail", required = false) String isWebmail, String queryField,
                                        String bodyIds) throws Exception {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        String userId = "";
        if (StringUtils.checkNull(userFrom)) {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserId();
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
            maps.put("searchEnter", "%" + searchCriteria + "%");
        }
        if (!StringUtils.checkNull(bodyIds)) {
            maps.put("bodyIds", Arrays.asList(bodyIds.split(",")));
        }
        maps.put("isWebmail", isWebmail);
        maps.put("queryField", queryField);
        maps.put("orderByName", returnMapValue().get(orderByName));
        maps.put("orderWhere", returnMapValue().get(orderWhere));
        maps.put("readFlag", readFlag);
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();

        tojson = emailService.selectNewShowEmail(flag, request, maps, page, pageSize, useFlag, sqlType);
        if (tojson.getObj().size() > 0) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            if (flag.trim().equals("drafts")) {
                tojson.setFlag(0);
                tojson.setMsg("ok");
            } else {
                tojson.setFlag(1);
                tojson.setMsg("error");
            }
        }

        return tojson;
    }

    /**
     * 邮件分发页面
     *
     * @return
     */
    @RequestMapping("/SendEmailsHtml")
    public String SendEmailsHtml() {
        return "app/email/newEmail";
    }

    /**
     * 邮件分发
     *
     * @param emailBodyModel 参数
     * @param request
     * @param response
     * @return
     */
    @RequestMapping("/SendEmails")
    @ResponseBody
    public ToJson SendEmails(EmailBodyModel emailBodyModel, HttpServletRequest request, HttpServletResponse response
            , @RequestParam(value = "remind", required = false) String remind
            , @RequestParam(value = "mId", required = false) String mId
            , @RequestParam(value = "mName", required = false) String mName) {
        return emailService.SendEmails(emailBodyModel, request, response, remind, mId, mName);
    }

    /**
     * 查询归档 邮箱名称
     *
     * @return
     */
    @RequestMapping("/getEmailNames")
    @ResponseBody
    public ToJson getEmailNames(HttpServletRequest request) {
        return emailService.getEmailNames(request);
    }


    public String getPath(String ym, String company, String module, String attachId, String attachment) {
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
        } else {
            sb = sb.append(rb.getString("upload.linux"));
        }
        sb.append(System.getProperty("file.separator")).
                append(company).append(System.getProperty("file.separator")).
                append(module).append(System.getProperty("file.separator")).append(ym).
                append(System.getProperty("file.separator")).append(attachId).append(".").append(attachment);
        return sb.toString();

    }

    /**
     * 查询邮箱容量限制
     *
     * @return
     */
    @RequestMapping("/judgeEmailSize")
    @ResponseBody
    public BaseWrapper judgeEmailSize(HttpServletRequest request){
        return emailService.judgeEmailSize(request);
    }

    // 导出邮件
    @ResponseBody
    @RequestMapping("/exportEmail")
    public void exportEmail(HttpServletRequest request, HttpServletResponse response, String method, String flag, String bodyIds, String isExport, String isZip) throws IOException {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        List<EmailBodyModel> list = new ArrayList<>();
        try {
            if ("newShowEmail".equals(method)) {
                list = newShowEmail(request, response, flag, null, null, false, null, null,
                        null, null, null, null, null, null, null,
                        null, null, null, null, bodyIds).getObj();
            } else if ("showEmail".equals(method)) {
                list = queryEmail(request, response, flag, null, null, false, null, null,
                        null, null, null, null, null, null, null,
                        null, null, null, null, null, null, bodyIds).getObj();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 导出邮件
        if (!StringUtils.checkNull(isExport) && "1".equals(isExport)) {
            if (!CollectionUtils.isEmpty(list)) {
                // 处理发件人名称
                Set<String> listUserId = list.stream().map(EmailBodyModel::getFromId).collect(Collectors.toSet());

                // 处理收件人名称
                Set<String> listToId2 = list.stream().map(EmailBodyModel::getToId2).collect(Collectors.toSet());
                for (String toId2 : listToId2) {
                    if (!StringUtils.checkNull(toId2)){
                        listUserId.addAll(Arrays.asList(toId2.split(",")));
                    }
                }

                // 处理抄送人名称
                Set<String> listCopyToId = list.stream().map(EmailBodyModel::getCopyToId).collect(Collectors.toSet());
                for (String copyToId : listCopyToId) {
                    if (!StringUtils.checkNull(copyToId)){
                        listUserId.addAll(Arrays.asList(copyToId.split(",")));
                    }
                }

                List<Users> listUsers = usersMapper.selectUserInfoByUserIdSet(listUserId);

                for (EmailBodyModel emailBodyModel : list) {
                    // 处理发件人名称
                    if (!StringUtils.checkNull(emailBodyModel.getFromId())){
                        boolean isFlag = true;
                        for (Users listUser : listUsers) {
                            if (emailBodyModel.getFromId().equals(listUser.getUserId())){
                                emailBodyModel.setFromName(listUser.getUserName() != null ? listUser.getUserName() : "");
                                isFlag = false;
                            }
                        }
                        if (isFlag){
                            emailBodyModel.setFromName("");
                        }
                    } else {
                        emailBodyModel.setFromName("");
                    }

                    // 处理收件人名称
                    if (!StringUtils.checkNull(emailBodyModel.getToId2())){
                        StringBuffer userName = new StringBuffer();
                        for (String toId2 : emailBodyModel.getToId2().split(",")) {
                            boolean isFlag = true;
                            for (Users listUser : listUsers) {
                                if (toId2.equals(listUser.getUserId())){
                                    userName.append(listUser.getUserName() != null ? listUser.getUserName() : "").append(",");
                                    isFlag = false;
                                }
                            }
                            if (isFlag){
                                userName.append(",");
                            }
                        }
                        emailBodyModel.setToName(userName.toString());
                    } else {
                        emailBodyModel.setToName("");
                    }

                    // 处理抄送人名称
                    if (!StringUtils.checkNull(emailBodyModel.getCopyToId())){
                        StringBuffer userName = new StringBuffer();
                        for (String copyToId : emailBodyModel.getCopyToId().split(",")) {
                            boolean isFlag = true;
                            for (Users listUser : listUsers) {
                                if (copyToId.equals(listUser.getUserId())){
                                    userName.append(listUser.getUserName() != null ? listUser.getUserName() : "").append(",");
                                    isFlag = false;
                                }
                            }
                            if (isFlag){
                                userName.append(",");
                            }
                        }
                        emailBodyModel.setCopyName(userName.toString());
                    } else {
                        emailBodyModel.setCopyName("");
                    }

                    // 重要程度
                    if (!StringUtils.checkNull(emailBodyModel.getImportant())) {
                        if ("1".equals(emailBodyModel.getImportant())) {
                            emailBodyModel.setImportant(I18nUtils.getMessage("workflow.th.important"));
                        } else if ("2".equals(emailBodyModel.getImportant())) {
                            emailBodyModel.setImportant(I18nUtils.getMessage("email.th.extremelyImportant"));
                        } else {
                            emailBodyModel.setImportant(I18nUtils.getMessage("email.th.conmmemail"));
                        }
                    } else {
                        emailBodyModel.setImportant(I18nUtils.getMessage("email.th.conmmemail"));
                    }
                }

                // 是否导出邮件及附件功能
                if (!(!StringUtils.checkNull(isZip) && "1".equals(isZip))) {
                    try {
                        HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("workflow.th.Internalmail"), 9);
                        String[] secondTitles = {I18nUtils.getMessage("email.th.recipients"), I18nUtils.getMessage("email.th.sender"),
                                I18nUtils.getMessage("email.th.carbonCopyRecipients"), I18nUtils.getMessage("email.th.importanceLevel"),
                                I18nUtils.getMessage("email.th.main"), I18nUtils.getMessage("email.th.time"),
                                I18nUtils.getMessage("notice.th.content"), I18nUtils.getMessage("workflow.th.AttachmentName")};
                        HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                        String[] beanProperty = {"toName", "fromName", "copyName", "important", "subject", "sendTimes", "content", "attachmentName"};
                        HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                        OutputStream out = response.getOutputStream();
                        String filename = I18nUtils.getMessage("workflow.th.Internalmail") + ".xls";
                        filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                        response.setHeader("content-disposition", "attachment;filename=" + filename);
                        workbook.write(out);
                        out.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    // 查询是否加密
                    boolean encryption = sysTasksService.isEncryption();
                    String company = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class);

                    String zipName = I18nUtils.getMessage("email.th.OAInternalMail") + "(" + DateFormat.getDatestr(new Date()) + ")" + ".zip";
                    zipName = FileUtils.encodeDownloadFilename(zipName, request.getHeader("user-agent"));
                    // 附件下载且UTF-8编码
                    response.setContentType("application/x-download;charset=UTF-8");
                    // 附件下载中文乱码问题:该方法从浏览器下载中文名正常展示
                    // 设置下载的文件名称
                    response.addHeader("Content-Disposition", "attachment;filename=" + zipName);

                    ServletOutputStream servletOutputStream = response.getOutputStream();
                    ZipOutputStream zipOutputStream = new ZipOutputStream(servletOutputStream);

                    for (EmailBodyModel emailBodyModel : list) {
                        String mailbody = "";
                        mailbody = "Message-ID:" + emailBodyModel.getBodyId() + "\r\n";
                        mailbody = mailbody + "X-FreePOPs-User: " + emailBodyModel.getFromId() + "\r\n";
                        mailbody = mailbody + "X-FreePOPs-Domain: " + emailBodyModel.getFromName() + "\r\n";
                        mailbody = mailbody + "Subject: " + emailBodyModel.getSubject() + "\r\n";
                        mailbody = mailbody + "Date: " + emailBodyModel.getSendTimes() + " \r\n";
                        mailbody = mailbody + "From: " + emailBodyModel.getFromName() + "\r\n";
                        mailbody = mailbody + "To: " + emailBodyModel.getToName() + "\r\n";
                        mailbody = mailbody + "MIME-Version: 1.0\r\n";

                        BASE64Encoder encoder = new BASE64Encoder();

                        byte[] data = emailBodyModel.getContent().getBytes();
                        try {
                            MessageDigest digest = MessageDigest.getInstance("MD5");
                            digest.update(((new Random()).nextInt() + "").getBytes());
                            data = digest.digest();// Get a romdom integer and get it's digest
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        String mainBoundary = "****MAIN_BOUNDARY****" + bytesToHex(data);
                        // Main boundary
                        String subBoundary = "****SUB_BOUNDARY****" + bytesToHex(data);

                        mailbody += "Content-Type: multipart/mixed;\r\n" + "\tboundary=\"" + mainBoundary
                                + "\"\r\n" + "\r\n" + "This is a multi-part message in MIME format.\r\n" + "\r\n"
                                // Above is mail's header
                                + "--" + mainBoundary + "\r\n"
                                // The mail's text body
                                + "Content-Type: multipart/alternative;\r\n" + "\tboundary=\"" + subBoundary + "\"\r\n" + "\r\n" + "--"
                                + subBoundary + "\r\n";
                        mailbody += "Content-Type: text/html;\r\n";
                        mailbody += "\tcharset=\"utf-8\"\r\n" + "Content-Transfer-Encoding: 7bit\r\n" + "\r\n"
                                + emailBodyModel.getContent() + "\r\n" + "\r\n" + "--" + subBoundary + "--\r\n"// End of  sub boundary
                                + "\r\n";
                        // 附件
                        if (!CollectionUtils.isEmpty(emailBodyModel.getAttachment())) {
                            for (Attachment attachment : emailBodyModel.getAttachment()) {
                                String attachName = attachment.getAttachName();
                                Matcher m = Pattern.compile("[\\u4e00-\\u9fa5]").matcher(attachName);
                                try {
                                    if (m.find()) {
                                        attachName = MimeUtility.encodeText(attachName, "gb18030", "B");
                                    } else {
                                        attachName = MimeUtility.encodeText(attachName, "utf-8", "B");
                                    }
                                } catch (Exception e) {
                                    attachName = attachment.getAttachName();
                                    e.printStackTrace();
                                }
                                try {
                                    String path = getPath(attachment.getYm(), company, "email", attachment.getAttachId(), attachment.getAttachName());
                                    if (encryption) {
                                        path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")) + 1) + attachment.getAttachId() + "." + attachment.getAttachFile() + ".xoafile";
                                    }
                                    File file = null;
                                    file = new File(path);
                                    if (!file.exists()) {
                                        // 把后缀名转换成小写 查看是否存在
                                        // （打捞局项目Linux系统中出现上传的文件是大写的后缀，但是存储在系统中是小写的后缀）
                                        file = new File(path.substring(0, path.lastIndexOf(".")) + path.substring(path.lastIndexOf(".")).toLowerCase());
                                        // 如果不存在 查看是否是加密文件
                                        if (!file.exists()) {
                                            file = new File(path += ".xoafile");
                                        }
                                    }
                                    String contentType = MediaTypeFactory.getMediaType(attachName).orElse(MediaType.APPLICATION_OCTET_STREAM).toString();

                                    mailbody += "--" + mainBoundary + "\r\n" + "Content-Type:" + contentType
                                            + ";\r\n" + "\tname=\"" + attachName + "\"\r\n"
                                            + "Content-Transfer-Encoding: base64\r\n" + "Content-Disposition: attachment;\r\n"
                                            + "\tfilename=\"" + attachName + "\"\r\n" + "\r\n"
                                            + encoder.encode(encryption ? AESUtil.Decrypt(file, company) : filetobyte(file)) + "\r\n" + "\r\n";
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }

                        mailbody += "--" + mainBoundary + "--";

                        try (InputStream inputStream = new ByteArrayInputStream(mailbody.getBytes(StandardCharsets.UTF_8))) {
                            zipOutputStream.putNextEntry(new ZipEntry("/" + emailBodyModel.getSubject() + ".eml"));
                            int temp;
                            while ((temp = inputStream.read()) != -1) {
                                //写入输出流中
                                zipOutputStream.write(temp);
                            }
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    // 关闭流
                    zipOutputStream.close();
                }
            }
        }
    }

    /**
     * Byte字节转Hex
     * @param b 字节
     * @return Hex
     */
    public String byteToHex(byte b) {
        String hexString = Integer.toHexString(b & 0xFF);
        //由于十六进制是由0~9、A~F来表示1~16，所以如果Byte转换成Hex后如果是<16,就会是一个字符（比如A=10），通常是使用两个字符来表示16进制位的,
        //假如一个字符的话，遇到字符串11，这到底是1个字节，还是1和1两个字节，容易混淆，如果是补0，那么1和1补充后就是0101，11就表示纯粹的11
        if (hexString.length() < 2)
        {
            hexString = new StringBuilder(String.valueOf(0)).append(hexString).toString();
        }
        return hexString.toUpperCase();
    }

    /**
     * 字节数组转Hex
     * @param bytes 字节数组
     * @return Hex
     */
    public String bytesToHex(byte[] bytes) {
        StringBuffer sb = new StringBuffer();
        if (bytes != null && bytes.length > 0)
        {
            for (int i = 0; i < bytes.length; i++) {
                String hex = byteToHex(bytes[i]);
                sb.append(hex);
            }
        }
        return sb.toString();
    }

    // File转byte[]数组
    public byte[] filetobyte(File file) {
        if (file == null) {
            return null;
        }
        FileInputStream fileInputStream = null;
        ByteArrayOutputStream byteArrayOutputStream = null;
        try {
            fileInputStream = new FileInputStream(file);
            byteArrayOutputStream = new ByteArrayOutputStream();
            byte[] b = new byte[1024];
            int n;
            while ((n = fileInputStream.read(b)) != -1) {
                byteArrayOutputStream.write(b, 0, n);
            }
            return byteArrayOutputStream.toByteArray();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (byteArrayOutputStream != null) {
                try {
                    byteArrayOutputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (fileInputStream != null) {
                try {
                    fileInputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    public String zipFile(List<File> fileList, String outPath, String outFileName) throws IOException {
        // 文件的压缩包路径
        String zipPath = outPath + outFileName;
        // 获取文件压缩包输出流
        try (OutputStream outputStream = new FileOutputStream(zipPath);
             CheckedOutputStream checkedOutputStream = new CheckedOutputStream(outputStream,new Adler32());
             ZipOutputStream zipOut = new ZipOutputStream(checkedOutputStream)){
            for (File file : fileList) {
                // 获取文件输入流
                InputStream fileIn = new FileInputStream(file);
                // 使用 common.io中的IOUtils获取文件字节数组
                byte[] bytes = IOUtils.toByteArray(fileIn);
                // 写入数据并刷新
                zipOut.putNextEntry(new ZipEntry(file.getName()));
                zipOut.write(bytes,0,bytes.length);
                zipOut.flush();
                fileIn.close();
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return zipPath;
    }

}


