package com.xoa.service.email.impl;

import com.xoa.dao.censor.CensorModuleMapper;
import com.xoa.dao.censor.CensorWordsMapper;
import com.xoa.dao.common.AppLogMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.email.EmailBoxMapper;
import com.xoa.dao.email.EmailMapper;
import com.xoa.dao.email.WebmailMapper;
import com.xoa.dao.email.emailSet.EmailSetMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.approveEmail.service.impl.ApproveEmailServiceImpl;
import com.xoa.model.censor.CensorModule;
import com.xoa.model.censor.CensorWords;
import com.xoa.model.common.AppLog;
import com.xoa.model.common.AppLogExample;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailBoxModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.email.EmailService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.email.EmailUtil;
import com.xoa.util.page.PageParams;
import net.sf.json.JSONObject;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.HtmlUtils;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:54:20
 * 类介绍  :   邮件业务层实现类
 * 构造参数:
 */
@Service
public class EmailServiceImpl implements EmailService {

    private final Integer TO_USER_INFO = 0x11;//收件人信息
    private final Integer COPY_USER_FINO = 0x12;//抄送人信息
    private final Integer SERC_USER_FINO = 0x13;//抄送人信息


    @Resource
    private EmailBodyMapper emailBodyMapper;


    @Resource
    private EmailMapper emailMapper;

    @Resource
    private EmailBoxMapper emailBoxMapper;

    @Resource
    private UsersService usersService;

    @Resource
    private WebmailMapper webmailMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private SmsService smsService;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Resource
    private Sms2PrivService sms2PrivService;
    @Resource
    private EmailSetMapper emailSetMapper;
    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private CensorModuleMapper censorModuleMapper;

    @Resource
    private CensorWordsMapper censorWordsMapper;

    @Resource
    private AppLogMapper appLogMapper;

    @Resource
    private ApproveEmailServiceImpl approveEmailService;

    @Resource
    private UserExtMapper userExtMapper;

    @Resource
    private DepartmentService departmentService;
    /**
     * 创建作者: 高亚峰
     * 创建说明  处理邮件附件不为空且主题为空的情况
     *
     * @param emailBody
     * @return
     */
    public EmailBodyModel returnSubject(HttpServletRequest request, EmailBodyModel emailBody) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        if (StringUtils.checkNull(emailBody.getSubject())) {
            if (!StringUtils.checkNull(emailBody.getAttachmentName())) {
                String newStr = emailBody.getAttachmentName();
                String[] split = newStr.split("\\*");
                //格式xxxx.xx
                if (!StringUtils.checkNull(split[0])) {
                    String s = split[0];
                    int i = s.lastIndexOf(".");
                    if (i != -1) {
                        String substring = s.substring(0, i);
                        emailBody.setSubject(substring);
                    }
                }
            } else {
                if (locale.equals("zh_CN")) {
                    emailBody.setSubject("【无主题】");
                } else if (locale.equals("en_US")) {
                    emailBody.setSubject("【No Subject】");
                } else if (locale.equals("zh_TW")) {
                    emailBody.setSubject("【無主題】");
                }
            }
        }
        return emailBody;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:47:08
     * 方法介绍:   创建邮件并发送
     * 参数说明:   @param emailBody  邮件内容实体类
     * 参数说明:   @param email 邮件状态实体类
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @SuppressWarnings("all")
    @Override
    @Transactional
    public ToJson<EmailBodyModel> sendEmail(EmailBodyModel emailBody, EmailModel email, String sqlType, String remind, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            // 发送邮件 html内容乱码问题修改
            emailBody.setContent(HtmlUtils.htmlUnescape(emailBody.getContent()));

            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
            emailBody.setSendFlag("1");
            //获取邮件是否需要进行审核
            EmailBodyModel emailBodyModel = approveEmailService.setApproveAndSms(emailBody, users);
            if ("1".equals(emailBodyModel.getApproveFlag())) {
                toJson.setFlag(0);
                toJson.setMsg("needAdmin");
                return toJson;
            }
            if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                // 包含外部邮件发送
                toJson = this.returnSendWebEmail(emailBody, email, sqlType, request);
            } else {
                //处理下没主题且有附件的
                emailBody = returnSubject(request, emailBody);
                emailBodyMapper.save(emailBody);
                toJson = this.returnEmail(emailBody, email, remind, request);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("errorSendEmail");
            L.e("email sendEmail:" + e);
        }
        return toJson;
    }

    @Override
    @Transactional
    public ToJson<EmailBodyModel> sendEmailCross(EmailBodyModel emailBody, EmailModel email, String sqlType, String remind, HttpServletRequest request, String senduserid) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
            emailBody.setSendFlag("1");
            //获取邮件是否需要进行审核
//            EmailBodyModel emailBodyModel=setApproveAndSms(emailBody,users);
//            if ("1".equals(emailBodyModel.getApproveFlag())){
//                toJson.setFlag(0);
//                toJson.setMsg("needAdmin");
//                return toJson;
//            }


            //处理下没主题且有附件的
            emailBody = returnSubject(request, emailBody);
            emailBodyMapper.save(emailBody);
            toJson = this.returnEmail(emailBody, email, remind, request);

        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("errorSendEmail");
            L.e("email sendEmail:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:47:26
     * 方法介绍:   草稿箱
     * 参数说明:   @param emailBody 邮件内容实体类
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailBodyModel> saveEmail(EmailBodyModel emailBody) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
            emailBody.setSendFlag("0");
            if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                toJson = this.returnSaveWebEmail(emailBody);
            } else {
                //草稿箱单独修改
                if (StringUtils.checkNull(emailBody.getSubject())) {
                    if (!StringUtils.checkNull(emailBody.getAttachmentName())) {
                        String newStr = emailBody.getAttachmentName();
                        String[] split = newStr.split("\\*");
                        //格式xxxx.xx
                        if (!StringUtils.checkNull(split[0])) {
                            String s = split[0];
                            int i = s.lastIndexOf(".");
                            if (i != -1) {
                                String substring = s.substring(0, i);
                                emailBody.setSubject(substring);
                            }
                        }
                    }
                }
                emailBodyMapper.save(emailBody);
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("errorSendEmail");
            L.e("email saveEmail:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:48:04
     * 方法介绍:   全部查询邮件
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return List<EmailBodyModel>
     */
    @SuppressWarnings("all")
    @Override
    public ToJson<EmailBodyModel> selectEmail(Map<String, Object> maps, Integer page,
                                              Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.selectObjcet(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            if (!ToMap.isEmpty()) {
                emailBody.setToId2(ToMap.keySet().iterator().next());
                emailBody.setToName(ToMap.get(emailBody.getToId2()));
            }

            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));

            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:48:31
     * 方法介绍:   根据ID删除草稿箱邮件
     * 参数说明:   @param bodyId 邮件Id
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return void
     */
    @Override
    public void deleteByID(Integer bodyId) {
        emailBodyMapper.deleteDrafts(bodyId);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:51:42
     * 方法介绍:   草稿箱查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return List<EmailBodyModel>
     */
    @Override
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> listDrafts(Map<String, Object> maps, Integer page,
                                             Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.listDrafts(maps);

        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));
        Map<String, Object> map3 = new HashedMap();
        map3.put("fromId", maps.get("fromId"));
        Map<String, Object> map4 = new HashedMap();
        map4.put("fromId", maps.get("fromId"));
        List<EmailBodyModel> inboxs = emailBodyMapper.selectInbox(map2);
        List<EmailBodyModel> outemails = emailBodyMapper.listSendEmail(map3);
        List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map4);

        for (EmailBodyModel emailBody : listEmai) {
            emailBody.setToName(usersService.getUserNameById(emailBody.getToId2()));
            if (usersService.getUserNameById(emailBody.getCopyToId()) != null) {
                emailBody.setCopyName(usersService.getUserNameById(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (usersService.getUserNameById(emailBody.getSecretToId()) != null) {
                emailBody.setSecretToName(usersService.getUserNameById(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));

            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }

            list.add(emailBody);
        }
        tojson.setDraftsCount(pageParams.getTotal());
        tojson.setHairboxCount(outemails.size());
        tojson.setInboxCount(inboxs.size());
        tojson.setWasteCount(wastes.size());
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:52:01
     * 方法介绍:   已发送查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return List<EmailBodyModel>
     */
    @Override
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> listSendEmail(Map<String, Object> maps,
                                                Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);

        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));
        Map<String, Object> map3 = new HashedMap();
        map3.put("fromId", maps.get("fromId"));
        Map<String, Object> map4 = new HashedMap();
        map4.put("fromId", maps.get("fromId"));
        List<EmailBodyModel> inboxs = emailBodyMapper.selectInbox(map2);
        List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
        List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map4);

        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.listSendEmail(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            if (ToMap.size() != 0) {
                emailBody.setToId2(ToMap.keySet().iterator().next());
                emailBody.setToName(ToMap.get(emailBody.getToId2()));
            } else {
                emailBody.setToId2("");
                emailBody.setToName("");
            }


            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));

            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            list.add(emailBody);
        }
        tojson.setDraftsCount(drafts.size());
        tojson.setHairboxCount(pageParams.getTotal());
        tojson.setInboxCount(inboxs.size());
        tojson.setWasteCount(wastes.size());
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:52:30
     * 方法介绍:   废纸篓查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return List<EmailBodyModel>
     */
    @Override
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> listWastePaperbasket(Map<String, Object> maps,
                                                       Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);

        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);

        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));


        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();

        List<EmailBodyModel> listEmai = emailBodyMapper.listWastePaperbasket(maps);

        List<EmailBodyModel> inboxs = emailBodyMapper.selectInbox(map2);
        List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
        List<EmailBodyModel> listHairbox = emailBodyMapper.listSendEmail(map2);


        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            list.add(emailBody);
        }

        tojson.setDraftsCount(drafts.size());
        tojson.setHairboxCount(listHairbox.size());
        tojson.setInboxCount(inboxs.size());

        tojson.setWasteCount(pageParams.getTotal());

        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:52:59
     * 方法介绍:   已发送查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     * 作废
     * 参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return List<EmailBodyModel>
     */
    @Override
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> selectEmailBody(Map<String, Object> maps,
                                                  Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.listqueryEmailBody(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:48:55
     * 方法介绍:   根据ID查询一条邮件
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     *
     * @return EmailBodyModel
     */
    @Override
    public EmailBodyModel queryById(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String flag=request.getParameter("flag");
        String sjxflg=request.getParameter("sjxflg");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users nowLoginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);


        if (maps.get("emailId") != null) {
            maps.remove("bodyId");
        }

        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        EmailBodyModel emailBody = null;
        //归档查询
        if (maps.get("copyTime") != null) {
            String loginDateSouse = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")); // 数据是1001 1002 1003 这种格式
            //切换的库
            if(!"1000".equals(loginDateSouse)){
                maps.put("dbSource","td_oa_archive"+loginDateSouse);
            } else {
                maps.put("dbSource","td_oa_archive");
            }

            try {
                emailBody = emailBodyMapper.queryArchiveById(maps);//根据id查询邮件
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // 切换回当前库 ☺ ☺
                ContextHolder.setConsumerType(sqlType);
            }
            //归档查询后补充用户信息
            Users byUserId = usersMapper.getByUserId(emailBody.getFromId());//发件人userid 根据userid获取信息

            if(byUserId == null){
                byUserId = new Users();
                byUserId.setUserName(emailBody.getFromId());//根据发件人userid设置用户姓名
                byUserId.setAvatar("0");//设置自定义小头像
            }else{
                Department deptById = departmentMapper.getDeptById(byUserId.getDeptId());//根据部门id获取部门
                emailBody.setDeptId(byUserId.getDeptId());
                emailBody.setDeptName(deptById.getDeptName());
            }
            emailBody.setUsers(byUserId);//一对多(传users对象)
        }else{
            emailBody = emailBodyMapper.queryById(maps);//根本id查询邮件
            if(emailBody.getUsers()==null){
                Users users=new Users();
                users.setUserName(I18nUtils.getMessage("email.th.theSenderDoesNotExist"));
                emailBody.setUsers(users);
            }

        }
        Users byUserId1 = usersMapper.getByUserId(emailBody.getFromId());//发件人userid 根据userid获取信息

        //收件人 toid2收件人USER_ID串
        String indexStr = StringUtils.getIndexStr(emailBody.getToId2(), ",", emailBody.getToId2().split(",").length);//获取fmt字符串 出现第n次之前的字符串
        Map<String, String> ToMap = this.getEmailUserName(indexStr);//姓名处理
//判断tomap有内容
        if (!ToMap.isEmpty()) {
            emailBody.setToId2(emailBody.getToId2());
            emailBody.setToName(ToMap.get(indexStr));
        }
        //带状态的收件人
        putInfoWithFlag(emailBody, TO_USER_INFO, emailBody.getToId2());

        //抄送人
        Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());//抄送人userid字符串 k:返回姓名拼音字符串 v:姓名汉字字符串

        //带状态的抄送人
        putInfoWithFlag(emailBody, COPY_USER_FINO, emailBody.getCopyToId());
        //密送人
        String[] split=emailBody.getSecretToId().split(",");
        Map<String, String> secretMap=null;
        for (String s : split) {
            if(s.equals(nowLoginUser.getUserId())){
                 secretMap = this.getEmailUserName(nowLoginUser.getUserId());
                //带状态的密送人
                putInfoWithFlag(emailBody, SERC_USER_FINO, emailBody.getSecretToId());
            }
        }


        if (!copyMap.isEmpty()) {
            emailBody.setCopyToId(copyMap.keySet().iterator().next());
            emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));//设置抄送人姓名
        } else {
            emailBody.setCopyName("");
        }
        if (secretMap!=null){
            emailBody.setSecretToId(secretMap.keySet().iterator().next());
            emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
        }else {
            emailBody.setSecretToName("");
        }
        emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
        emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
        emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
        //getAttachmentName附件文件名串
        if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
            emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
        } else {
            emailBody.setAttachmentName("");
            emailBody.setAttachmentId("");
        }
        return emailBody;
    }
// putInfoWithFlag(emailBody, SERC_USER_FINO, emailBody.getSecretToId());
    private void putInfoWithFlag(EmailBodyModel emailBody, Integer type, String userIds) {
        /*HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String flag=request.getParameter("flag");
        String sjxflg=request.getParameter("sjxflg");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users nowLoginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
*/
        if (emailBody != null) {

            if (!StringUtils.checkNull(userIds)) {
                String[] temp = userIds.split(",");
                Map<String, Object> param = new HashMap<String, Object>();
                param.put("userIds", temp);
                param.put("bodyId", emailBody.getBodyId());
                List<EmailModel> datas = emailMapper.selectUserReadFlag(param);//查看阅读状态

                if (type == TO_USER_INFO) {
                    emailBody.setToUserEmailInfo(datas);//收件人信息状态
                }
                if (type == COPY_USER_FINO) {
                    emailBody.setCopyUserEmailInfo(datas);
                }
                if (type == SERC_USER_FINO) {

                    emailBody.setSercUserEmailInfo(datas);
                }


            }
        }

    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:48:55
     * 方法介绍:   根据ID查询一条邮件
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     *
     * @return EmailBodyModel
     */
    @Override
    public EmailBodyModel queryByCountID(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        if (maps.get("emailId") != null) {
            maps.remove("bodyId");
        }
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        EmailBodyModel emailBody = emailBodyMapper.queryByCountID(maps);
        //收件人
        String indexStr = StringUtils.getIndexStr(emailBody.getToId2(), ",", emailBody.getToId2().split(",").length);
        Map<String, String> ToMap = this.getEmailUserName(indexStr);
        if (!ToMap.isEmpty()) {
            emailBody.setToId2(emailBody.getToId2());
            emailBody.setToName(ToMap.get(indexStr));
        }
        //带状态的收件人
        putInfoWithFlag(emailBody, TO_USER_INFO, emailBody.getToId2());

        //抄送人
        Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());

        //带状态的抄送人
        putInfoWithFlag(emailBody, COPY_USER_FINO, emailBody.getCopyToId());
        //密送人
        Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
        //带状态的密送人
        putInfoWithFlag(emailBody, SERC_USER_FINO, emailBody.getSecretToId());


        if (!copyMap.isEmpty()) {
            emailBody.setCopyToId(copyMap.keySet().iterator().next());
            emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
        } else {
            emailBody.setCopyName("");
        }
        if (!secretMap.isEmpty()) {
            emailBody.setSecretToId(secretMap.keySet().iterator().next());
            emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
        } else {
            emailBody.setSecretToName("");
        }

        emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
        emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
        if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
            emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
        } else {
            emailBody.setAttachmentName("");
            emailBody.setAttachmentId("");
        }
        return emailBody;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:49:30
     * 方法介绍:   收件箱查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     *
     * @return List<EmailBodyModel>
     */
    @SuppressWarnings("all")
    @Override
    public ToJson<EmailBodyModel> selectInbox(HttpServletRequest request, Map<String, Object> maps, Integer page,
                                              Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();

        try {//防止影响正常邮件查询
            this.threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    ContextHolder.setConsumerType("xoa" + sqlType);
                    updateZeroSizeEmail(sqlType);
                }
            });
        } catch (Exception e){
            e.printStackTrace();
        }

        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> emailSize = emailBodyMapper.selectInbox(maps);
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> listEmai = emailBodyMapper.selectInbox(maps);
        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));
        Map<String, Object> map3 = new HashedMap();
        map3.put("fromId", maps.get("fromId"));
        Map<String, Object> map4 = new HashedMap();
        map4.put("fromId", maps.get("fromId"));
        List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
        List<EmailBodyModel> outemails = emailBodyMapper.listSendEmail(map3);
        List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map4);
        EmailBodyModel emailBodyModel = new EmailBodyModel();
        if (drafts != null) {
            emailBodyModel.setDraftsCount(drafts.size());
        }
        if (outemails != null) {
            emailBodyModel.setHairboxCount(outemails.size());
        }
        for (EmailBodyModel emailBody : listEmai) {
            //这些都不需要展示
            //收件人
            String indexStr = StringUtils.getIndexStr(emailBody.getToId2(), ",", 10);
            Map<String, String> ToMap = this.getEmailUserName(indexStr);
            if (emailBody.getToId2().split(",").length > indexStr.split(",").length) {
                emailBody.setToId2(emailBody.getToId2());
                emailBody.setToName(ToMap.get(indexStr) + "...");
            } else {
                emailBody.setToId2(emailBody.getToId2());
                emailBody.setToName(ToMap.get(indexStr));
            }

            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
        }
        // 查询收件箱总数

        tojson.setDraftsCount(drafts.size());
        tojson.setHairboxCount(outemails.size());
        tojson.setWasteCount(wastes.size());
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        tojson.setInboxCount(emailSize.size());
        tojson.setTotleNum(emailSize.size());

        tojson.setObj(listEmai);
        tojson.setObject(emailBodyModel);
        return tojson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:53:42
     * 方法介绍:   未读
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     *
     * @return List<EmailBodyModel>
     */
    @SuppressWarnings("all")
    @Override
    public ToJson<EmailBodyModel> selectIsRead(Map<String, Object> maps, Integer page,
                                               Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.selectIsRead(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-20 上午10:47:44
     * 方法介绍:    未读转为已读
     * 参数说明:   @param email  收件箱参数
     *
     * @return void
     */
    @Override
    public void updateIsRead(EmailModel email) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("emailId", email.getEmailId());
        EmailModel email1 = emailMapper.queryByEmailOne(email.getEmailId());
        smsService.updatequerySmsByType("2", email1.getToId(), String.valueOf(email1.getEmailId()));
        emailMapper.updateIsRead(email);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-21 上午11:16:38
     * 方法介绍:   发件箱删除
     * 参数说明:   @param emailBodyModel
     *
     * @return void
     */
    @Override
    public String deleteOutEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("0") || flag.trim().equals("")) {
                emailBodyMapper.updateOutbox(emailId);
            } else if (flag.trim().equals("3")) {
                emailBodyMapper.updateOutboxs(emailId);
            } else {
                emailBodyMapper.deleteOutbox(emailId);
            }
        } catch (Exception e) {
            returnRes = "1";
            L.e("email deleteOutEmail:" + e);
        }
        return returnRes;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-21 上午11:16:38
     * 方法介绍:   发件箱删除邮件
     * 参数说明:   @param emailBodyModel
     *
     * @return void
     */
    @Override
    public String deleteInEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("0") || flag.trim().equals("")) {
                emailBodyMapper.updateInbox(emailId);
            } else {
                emailBodyMapper.updateInboxs(emailId);
            }
        } catch (Exception e) {
            returnRes = "1";
            L.e("email deleteInEmail:" + e);
        }
        return returnRes;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-21 上午11:16:38
     * 方法介绍:   废纸篓删除邮件
     * 参数说明:   @param emailBodyModel
     *
     * @return void
     */
    @Override
    @Transactional
    public String deleteRecycleEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("3")) {
                emailBodyMapper.updateRecycle(emailId);
            } else {
                emailBodyMapper.deleteRecycle(emailId);
            }
        } catch (Exception e) {
            returnRes = "1";
            L.e("email deleteRecycleEmail:" + e);
        }
        return returnRes;
    }

    @Override
    public String deleteDraftsEmail(Integer emailId) {
        String returnRes = "0";
        try {
                emailBodyMapper.deleteDrafts(emailId);
        } catch (Exception e) {
            returnRes = "1";
            L.e("email deleteRecycleEmail:" + e);
        }
        return returnRes;
    }

    //刘旭辉一键清空
    @Override
    @Transactional
    public ToJson<EmailModel> deleteRecycleEmails(HttpServletRequest request) {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        ToJson<EmailModel> json = new ToJson<>();
        try {
            emailBodyMapper.updateRecycles(users.getUserId());
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            L.e("email deleteRecycleEmails:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-5-9 下午14:20:42
     * 方法介绍:   回复或转发返回信息处理
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 字符串
     */
    @Override
    public String queryByIdCss(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType, HttpServletRequest request) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String shoujianren = I18nUtils.getMessage("email.th.recipients");
        String fajianren = I18nUtils.getMessage("email.th.sender");
        String chaosongren = I18nUtils.getMessage("email.th.carbonCopyRecipients");
        String misongren = I18nUtils.getMessage("email.th.BlindPeople");
        String fasongshijian = I18nUtils.getMessage("mailMonitoring.sendTime");
        String zhuti = I18nUtils.getMessage("email.th.main");
        EmailBodyModel emailBodyModel = this.queryById(maps, page, pageSize, useFlag, sqlType);
        StringBuffer fwReEmail = new StringBuffer();
        fwReEmail.append("&nbsp;");
        fwReEmail.append("<p>&nbsp;</p>");
        fwReEmail.append("<p>&nbsp;</p>");
        fwReEmail.append("<div contenteditable=\"false\">");
        fwReEmail.append("<div style=\"margin: 5px auto; height: 0px; border-bottom-color: rgb(192, 194, 207); border-bottom-width: 1px; border-bottom-style: solid;\">&nbsp;</div>\n");
        fwReEmail.append("<div style=\"background: rgb(237, 246, 219); padding: 5px 15px; font-size: 12px; border-bottom-color: rgb(204, 204, 204); border-bottom-width: 1px; border-bottom-style: solid;\"><span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\"  style=\"float:left\">" + fajianren + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getUsers().getUserName());
        fwReEmail.append("</span><br />");
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + shoujianren + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getToName());
        fwReEmail.append("</span><br />");
        if (emailBodyModel.getCopyName() != "") {
            fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + chaosongren + "</div>：</b>&nbsp;");
            fwReEmail.append(emailBodyModel.getCopyName());
            fwReEmail.append("</span><br />");
        }
        if (emailBodyModel.getSecretToName() != "") {
            fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + misongren + "</div>：</b>&nbsp;");
            fwReEmail.append(emailBodyModel.getSecretToName());
            fwReEmail.append("</span><br />");
        }
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + fasongshijian + "</div>：</b>&nbsp;");
        fwReEmail.append(DateFormat.getStrTime(emailBodyModel.getSendTime()));
        fwReEmail.append("</span><br />");
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + zhuti + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getSubject());
        fwReEmail.append("</span></div>");
        fwReEmail.append(emailBodyModel.getContent());
        fwReEmail.append("</div>");
        return fwReEmail.toString();
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-5-9 下午14:20:42
     * 方法介绍:   回复或转发返回信息处理
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 字符串
     */
    @Override
    public String queryByIdCssCount(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType, HttpServletRequest request) {
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String shoujianren = I18nUtils.getMessage("email.th.recipients");
        String fajianren = I18nUtils.getMessage("email.th.sender");
        String chaosongren = I18nUtils.getMessage("email.th.carbonCopyRecipients");
        String misongren = I18nUtils.getMessage("email.th.BlindPeople");
        String fasongshijian = I18nUtils.getMessage("mailMonitoring.sendTime");
        String zhuti = I18nUtils.getMessage("email.th.main");
        EmailBodyModel emailBodyModel = this.queryByCountID(maps, page, pageSize, useFlag, sqlType);
        StringBuffer fwReEmail = new StringBuffer();
        fwReEmail.append("&nbsp;");
        fwReEmail.append("<p>&nbsp;</p>");
        fwReEmail.append("<p>&nbsp;</p>");
        fwReEmail.append("<div style=\"margin: 5px auto; height: 0px; border-bottom-color: rgb(192, 194, 207); border-bottom-width: 1px; border-bottom-style: solid;\">&nbsp;</div>\n");
        fwReEmail.append("<div style=\"background: rgb(237, 246, 219); padding: 5px 15px; font-size: 12px; border-bottom-color: rgb(204, 204, 204); border-bottom-width: 1px; border-bottom-style: solid;\"><span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\"  style=\"float:left\">" + fajianren + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getUsers().getUserName());
        fwReEmail.append("</span><br />");
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + shoujianren + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getToName());
        fwReEmail.append("</span><br />");
        if (emailBodyModel.getCopyName() != "") {
            fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + chaosongren + "</div>：</b>&nbsp;");
            fwReEmail.append(emailBodyModel.getCopyName());
            fwReEmail.append("</span><br />");
        }
        if (emailBodyModel.getSecretToName() != "") {
            fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + misongren + "</div>：</b>&nbsp;");
            fwReEmail.append(emailBodyModel.getSecretToName());
            fwReEmail.append("</span><br />");
        }
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + fasongshijian + "</div>：</b>&nbsp;");
        fwReEmail.append(DateFormat.getStrTime(emailBodyModel.getSendTime()));
        fwReEmail.append("</span><br />");
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + zhuti + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getSubject());
        fwReEmail.append("</span></div>");
        fwReEmail.append(emailBodyModel.getContent());
        String names = fwReEmail.toString();
        //System.out.println(names);
        return fwReEmail.toString();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 15:35
     * 方法介绍:
     * 参数说明:   发件箱、收件箱内容信息保存
     * 参数说明:   收件人实体类
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailBodyModel> draftsSendEmail(EmailBodyModel emailBody, EmailModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));

            //获取邮件是否需要进行审核
            EmailBodyModel emailBodyModel = setApproveAndSms(emailBody, users);
            if ("1".equals(emailBodyModel.getApproveFlag())) {
                toJson.setFlag(0);
                toJson.setMsg("needAdmin");
                return toJson;
            }

            if ("1".equals(emailBody.getSendFlag())) {
                if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                    // 包含外部邮件操作
                    toJson = this.returnUpdateDEmail(emailBody, email, sqlType, request);
                } else {
                    //处理下没主题且有附件的
                    emailBody = returnSubject(request, emailBody);
                    emailBodyMapper.update(emailBody);
                    toJson = this.returnEmail(emailBody, email, "2", request);
                }
            } else {
                // 草稿箱修改
                if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                    emailBody.setWebmailFlag("0");
                    toJson = this.returnUpdateD(emailBody);
                } else {
                    emailBodyMapper.update(emailBody);
                    toJson.setFlag(0);
                    toJson.setMsg("ok");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("errorSendEmail");
            L.e("email draftsSendEmail:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-27 下午1:54:02
     * 方法介绍:   收件人user_id转换为姓名
     * 参数说明:   @param listEmail
     * 参数说明:   @return
     *
     * @return List<EmailModel>
     */
    public List<EmailModel> returnEmail(List<EmailModel> listEmail) {
        List<EmailModel> list = new ArrayList<EmailModel>();
        for (EmailModel emailModel : listEmail) {
            Map<String, String> returnEmailMap = this.getEmailUserName(emailModel.getToId());
            if (!returnEmailMap.isEmpty()) {
                emailModel.setToId(returnEmailMap.keySet().iterator().next());
                emailModel.setToName(returnEmailMap.get(emailModel.getToId()));
            }
            list.add(emailModel);
        }
        return list;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 16:37
     * 方法介绍:   新建其他邮件文件夹
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailBoxModel> saveEmailBox(EmailBoxModel emailBoxModel) {
        ToJson<EmailBoxModel> toJson = new ToJson<EmailBoxModel>();
        try {
            Integer name = emailBoxMapper.selectNameCount(emailBoxModel.getBoxName(), emailBoxModel.getUserId());
            Integer boxId = emailBoxMapper.selectBoxIdCount(emailBoxModel.getBoxNo(), emailBoxModel.getUserId());
            if (name == 0 && boxId == 0) {
                emailBoxMapper.save(this.returnBoxModel(emailBoxModel));
                toJson.setFlag(0);
                toJson.setMsg("ok");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("repeat");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email saveEmailBox:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 16:39
     * 方法介绍:   把收件箱邮件转移到其他邮件文件夹中
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailModel> updateEmailBox(EmailModel emailModel) {
        ToJson<EmailModel> toJson = new ToJson<EmailModel>();
        try {
//            EmailModel emailModel1 = emailMapper.queryByEmailOne(emailModel.getEmailId());
            emailMapper.updateEmailBox(emailModel);
//            emailMapper.save(emailModel1);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email updateEmailBox:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 16:38
     * 方法介绍:   查询所有其他邮件文件夹
     * 参数说明:
     *
     * @return
     */
    @SuppressWarnings("all")
    @Override
    public ToJson<EmailBoxModel> showEmailBox(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<EmailBoxModel> toJson = new ToJson<EmailBoxModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBoxModel> list = emailBoxMapper.selectObjcet(maps);

        List<EmailBoxModel> newList = new ArrayList<EmailBoxModel>();
        for (EmailBoxModel emailBoxModel : list) {
            String boxName = emailBoxModel.getBoxName();
            if (!boxName.equals("PAGESIZE_OUT") && !boxName.equals("PAGESIZE_SENT") && !boxName.equals("PAGESIZE_DEL") && !boxName.equals("PAGESIZE_WEB") && !boxName.equals("PAGESIZE_IN0")) {
                newList.add(emailBoxModel);
            }
        }
        int len = newList.size();
        if (len < 0) {
            toJson.setFlag(1);
            toJson.setMsg("error");
        } else {
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(newList);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 16:48
     * 方法介绍:   其他邮箱中的邮件列表
     * 参数说明:
     *
     * @return
     */
    @SuppressWarnings("all")
    @Override
    public ToJson<EmailBodyModel> selectBoxEmail(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.selectBoxEmail(maps);
        Integer len = listEmai.size();
        if (len > 0) {
            for (EmailBodyModel emailBody : listEmai) {
                //收件人
                Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
                emailBody.setToId2(ToMap.keySet().iterator().next());
                emailBody.setToName(ToMap.get(emailBody.getToId2()));
                //抄送人
                Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
                //密送人
                Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
                if (!copyMap.isEmpty()) {
                    emailBody.setCopyToId(copyMap.keySet().iterator().next());
                    emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
                } else {
                    emailBody.setCopyName("");
                }
                if (!secretMap.isEmpty()) {
                    emailBody.setSecretToId(secretMap.keySet().iterator().next());
                    emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
                } else {
                    emailBody.setSecretToName("");
                }
                emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
                emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
                emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
                if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                list.add(emailBody);
            }
            tojson.setFlag(0);
            tojson.setMsg("ok");
            tojson.setObj(list);
            tojson.setTotleNum(pageParams.getTotal());
        } else {
            tojson.setFlag(1);
            tojson.setMsg("error");
        }
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 17:00
     * 方法介绍:   删除其他邮件文件夹，并判断该文件夹是否存在邮件
     * 参数说明:
     *
     * @return
     */
    @Override
    public ToJson<EmailBodyModel> deleteBoxEmail(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        boolean flags = true;
        List<EmailBodyModel> list = emailBodyMapper.selectIsBoxEmail(maps);
        int len = list.size();
        if (len > 0) {
            flags = false;
        } else {
            try {
                emailBoxMapper.deleteBox((Integer) maps.get("boxId"));
            } catch (Exception e) {
                flags = false;
            }
        }
        if (flags) {
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } else {
            tojson.setFlag(1);
            tojson.setMsg(I18nUtils.getMessage("email.th.emailExistsUnableToDelete"));
        }
        return tojson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 10:20
     * 方法介绍:   其他邮件文件名和序号修改
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailBoxModel> updeateEmailBoxName(EmailBoxModel emailBoxModel) {
        ToJson<EmailBoxModel> toJson = new ToJson<EmailBoxModel>();
        try {
            Integer box = emailBoxMapper.selectBoxUpdate(emailBoxModel.getBoxNo(), emailBoxModel.getBoxName(), emailBoxModel.getUserId());
            if (box == 0) {
                emailBoxMapper.update(emailBoxModel);
                toJson.setFlag(0);
                toJson.setMsg("ok");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("repeat");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email updeateEmailBoxName:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/19 18:20
     * 方法介绍:   收件箱未读查询
     * 参数说明:
     *
     * @return
     */
    @Override
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> selectInboxIsRead(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.selectInboxIsRead(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    @Override
    public ToJson<EmailBodyModel> selectInboxIsReadList(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.selectInboxIsRead(maps);
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }

    public EmailBoxModel returnBoxModel(EmailBoxModel emailBoxModel) {
        if (StringUtils.checkNull(emailBoxModel.getDefaultCount())) {
            emailBoxModel.setDefaultCount("");
        }
        return emailBoxModel;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 16:44
     * 方法介绍:    新建外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<Webmail> saveWebMail(Webmail webmail) {
        ToJson<Webmail> toJson = new ToJson<Webmail>();
        try {
            webmailMapper.save(webmail);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email saveWebMail:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 16:45
     * 方法介绍:   修改外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<Webmail> updateWebMail(Webmail webmail) {
        ToJson<Webmail> toJson = new ToJson<Webmail>();
        try {
            webmailMapper.update(webmail);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 16:45
     * 方法介绍:   删除外部邮箱关联
     * 参数说明:
     *
     * @return
     */
    @Override
    @Transactional
    public ToJson<Webmail> deleteWebMail(Integer mailId) {
        ToJson<Webmail> toJson = new ToJson<Webmail>();
        try {
            webmailMapper.deleteWebMail(mailId);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/16 20:10
     * 方法介绍:   草稿箱再次保存
     * 参数说明:
     *
     * @return
     */
    public ToJson<EmailBodyModel> returnUpdateD(EmailBodyModel emailBodyModel) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                emailBodyModel.setWebmailFlag("0");
                emailBodyModel.setFromWebmailId(webmails.getMailId());
                emailBodyMapper.update(emailBodyModel);
                toJson.setFlag(0);
                toJson.setMsg("ok");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("error");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email returnSendWebEmail:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/16 19:03
     * 方法介绍:   发送邮件若有外部邮件时处理方法
     *
     * @return
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> returnSendWebEmail(EmailBodyModel emailBodyModel, EmailModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                boolean flag;
                if (!StringUtils.checkNull(emailBodyModel.getAttachmentName())) {
                    //附件
                    List<Attachment> attachment = GetAttachmentListUtil.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL);
                    String[] files = returnFiles(attachment, sqlType);
                    flag = EmailUtil.sendWEmail(webmails, emailBodyModel, files);
                } else {
                    flag = EmailUtil.sendWEmail(webmails, emailBodyModel);
                }
                if (flag) {
                    emailBodyModel.setWebmailFlag("2");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyMapper.save(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    String toWebId = emailBodyModel.getToWebmail().trim() + emailBodyModel.getSecretToWebmail().trim()
                            + emailBodyModel.getCopyToWebmail().trim();
                    // 判断外部邮箱是否为空
                    if (!StringUtils.checkNull(toWebId)) {
                        email.setToId("__WEBMAIL__" + emailBodyModel.getBodyId());
                        email.setBoxId(0);
                        email.setBodyId(emailBodyModel.getBodyId());
                        emailMapper.save(email);
                    }
                    if (toJson.getMsg().equals("error")) {
                        toJson.setFlag(0);
                        toJson.setMsg("ok_w");
                    }
                } else {
                    emailBodyModel.setWebmailFlag("3");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyMapper.save(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                }
            } else {
                toJson.setFlag(1);
                toJson.setMsg("error_w");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email returnSendWebEmail:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/16 19:46
     * 方法介绍:   草稿箱发送邮件
     *
     * @return
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyModel> returnUpdateDEmail(EmailBodyModel emailBodyModel, EmailModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            toJson = this.returnEmail(emailBodyModel, email, "2", request);
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                boolean flag;
                if (!StringUtils.checkNull(emailBodyModel.getAttachmentName())) {
                    //附件
                    List<Attachment> attachment = GetAttachmentListUtil.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL);
                    String[] files = returnFiles(attachment, sqlType);
                    flag = EmailUtil.sendWEmail(webmails, emailBodyModel, files);
                } else {
                    flag = EmailUtil.sendWEmail(webmails, emailBodyModel);
                }
                if (flag) {
                    emailBodyModel.setWebmailFlag("2");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyMapper.update(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    String toWebId = emailBodyModel.getToWebmail().trim() + emailBodyModel.getSecretToWebmail().trim()
                            + emailBodyModel.getCopyToWebmail().trim();
                    // 判断外部邮箱是否为空
                    if (!StringUtils.checkNull(toWebId)) {
                        email.setToId("__WEBMAIL__" + emailBodyModel.getBodyId());
                        email.setBoxId(0);
                        email.setBodyId(emailBodyModel.getBodyId());
                        emailMapper.save(email);
                    }
                    if (toJson.getMsg().equals("error")) {
                        toJson.setFlag(0);
                        toJson.setMsg("ok_w");
                    }
                } else {
                    emailBodyModel.setWebmailFlag("3");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyMapper.update(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                }
            } else {
                toJson.setFlag(1);
                toJson.setMsg("error");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email returnUpdateDEmail:" + e);
        }
        return toJson;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/16 19:20
     * 方法介绍:  外部邮件保存到草稿箱
     *
     * @return
     */
    public ToJson<EmailBodyModel> returnSaveWebEmail(EmailBodyModel emailBodyModel) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        try {
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                emailBodyModel.setWebmailFlag("0");
                emailBodyModel.setFromWebmailId(webmails.getMailId());
                emailBodyMapper.save(emailBodyModel);
                toJson.setFlag(0);
                toJson.setMsg("ok");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("error");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email returnSendWebEmail:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/15 21:02
     * 方法介绍:   保存收件箱内部工具类
     * 参数说明:   参数默认修改为 true，在抛异常时考虑false 需修改
     *
     * @return
     */
    public ToJson<EmailBodyModel> returnEmail(EmailBodyModel emailBody, EmailModel email, String remind, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<EmailBodyModel>();
        ToJson json = new ToJson();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        try {
            String toID = emailBody.getCopyToId().trim()
                    + emailBody.getToId2().trim()
                    + emailBody.getSecretToId().trim();

            String toId = emailBody.getToId2().trim();
            String copyId = emailBody.getCopyToId().trim();
            String secrteId = emailBody.getSecretToId().trim();
            Set<String> toIdSet = new LinkedHashSet<String>();

            if (!StringUtils.checkNull(toID)) {
                String[] toID2 = toID.split(",");
                for (int i = 0, len = toID2.length; i < len; i++) {
                    toIdSet.add(toID2[i]);
                }
                StringBuffer sb=new StringBuffer();
                for (String string : toIdSet) {
                    email.setToId(string);
                    email.setBoxId(0);
                    email.setBodyId(emailBody.getBodyId());
                    emailMapper.save(email);
                    sb.append(email.getEmailId()+",");
                    email.setEmailId(null);
                }
                //之前走循环一次一次调用方法 现在只调用一次-----------刘景龙
                if ("3".equals(emailBody.getExamFlag()) && "3".equals(emailBody.getWordFlag())) {
                    addAffairs(emailBody, sb.toString(), emailBody.getToId2(), request);
                }
                if (!"3".equals(emailBody.getExamFlag()) || !"3".equals(emailBody.getWordFlag())) {
                    approveEmailService.addAffairsApprove(emailBody, request);
                }
                //短信发送(判断三段是否有权限发送短信)
                json = sms2PrivService.selectSms2("2", request);
                Sms2Priv sms2Priv = new Sms2Priv();
                sms2Priv.setUserId(toID);

                StringBuffer uId = new StringBuffer();
                if (json != null) {
                    if (json.getCode().equals("1")) {
                        if ("0".equals(emailBody.getSmsDefault()) && !"".equals(emailBody.getSubject())) {
                            //添加人员，通过userId查询uid
                            if (toID != null) {
                                String[] str = toID.split(",");
                                for (int k = 0; k < str.length; k++) {
                                    if (!StringUtils.checkNull(str[k])) {
                                        Users users = usersMapper.getUsersByuserId(str[k]);
                                        uId.append(users.getUid() + ",");
                                    }
                                }
                            }
                            SysPara sysPara = sysParaMapper.querySysPara("MOBILE_SMS_SET");
                            if ("0".equals(sysPara.getParaValue())) {
                                StringBuffer contextString;
                                if (locale.equals("zh_CN")) {
                                    contextString = new StringBuffer("电子邮件：" + emailBody.getSubject());
                                } else if (locale.equals("en_US")) {
                                    contextString = new StringBuffer("E-mail：" + emailBody.getSubject());
                                } else if (locale.equals("zh_TW")) {
                                    contextString = new StringBuffer("電子郵件：" + emailBody.getSubject());
                                } else {
                                    contextString = new StringBuffer();
                                }
                                // 使用线程发送短信 防止短信超时 导致接口超时 然后前端发送页面卡死
                                this.threadPoolTaskExecutor.execute(() -> sms2PrivService.smsSenders(contextString, uId.toString()));
                            } /*else if (sysPara.getParaValue().equals("1")) {
                                String[] uids = uId.toString().split(",");
                                Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                                Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
                                Department department = departmentMapper.getFatherDept(user.getDeptId());
                                for (String uid : uids) {
                                    Users users = usersMapper.getUsersByUid(Integer.valueOf(uid));
                                    send.sms(users.getMobilNo(), department.getSmsGateAccount(), contextString.toString(), user.getUserId(), users.getUserId());
                                }
                            }*/
                        }
                    }
                }
                toJson.setFlag(0);
                toJson.setMsg("ok");
            } else {
                toJson.setFlag(1);
                toJson.setMsg("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("error");
            L.e("email returnEmail:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/1 10:29
     * 方法介绍:   姓名处理
     *
     * @return k:返回姓名拼音字符串 v:姓名汉字字符串
     */
    public Map<String, String> getEmailUserName(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return new HashMap<String, String>();
        }
        Map<String, String> maps = new HashMap<String, String>();
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();
        List<Users> userByuserId = usersService.getUserByuserId(userIds);
        for (Users u : userByuserId) {
            sb.append(u.getUserName() + ",");
        }
        String newStr = new String();
        if (!StringUtils.checkNull(sb.toString())) {
            newStr = sb.toString().substring(0, sb.toString().length() - 1);
        } else {
            newStr = sb.toString();
        }
        maps.put(userIds, newStr);
        return maps;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 11:51
     * 方法介绍:   根据用户user_id查询外部邮箱列表
     *
     * @return
     */
    @Override
    public ToJson<Webmail> selectUserWebMail(String userId) {
        ToJson<Webmail> toJson = new ToJson<Webmail>(1, "error");
        try {
            toJson.setObj(webmailMapper.selectUserWebMail(userId));
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            L.e("EmailServiceImpl selectUserWebMail:" + e);
        }
        return toJson;
    }


    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 15:46
     * 方法介绍:   外部邮箱附件真实地址获取
     *
     * @return
     */
    public String[] returnFiles(List<Attachment> list, String sqlType) {
        int size = list.size();
        String[] files = new String[size];
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer stringBuffer = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                stringBuffer = stringBuffer.append(str2 + "/xoa");
            }
            stringBuffer.append(uploadPath);
        } else {
            stringBuffer = stringBuffer.append(rb.getString("upload.linux"));
        }
        stringBuffer.append(System.getProperty("file.separator"));
        stringBuffer.append(sqlType);
        stringBuffer.append(System.getProperty("file.separator"));
        for (int i = 0, len = list.size(); i < len; i++) {
            StringBuffer sb = new StringBuffer(stringBuffer.toString());
            sb.append(GetAttachmentListUtil.MODULE_EMAIL);
            sb.append(System.getProperty("file.separator"));
            sb.append(list.get(i).getYm());
            sb.append(System.getProperty("file.separator"));
            sb.append(list.get(i).getAttachId());
            sb.append(".");
            sb.append(list.get(i).getAttachName());
            files[i] = sb.toString();
        }
        return files;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 15:57
     * 方法介绍:   单条外部邮件详细查询
     *
     * @return
     */
    @Override
    @Transactional(readOnly = true)
    public ToJson<Webmail> selectOneWebMail(String userId, Integer mailId) {
        ToJson<Webmail> toJson = new ToJson<Webmail>(1, "error");
        try {
            toJson.setObject(webmailMapper.selectOneWebMail(userId, mailId));
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } catch (Exception e) {
            L.e("EmailServiceImpl selectOneWebMail:" + e);
        }
        return toJson;
    }

    @Override
    public BaseWrappers getEmailReadDetail(Integer bodyId, String userIdsType, String json) {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String flag=request.getParameter("flag");
        String sjxflg=request.getParameter("sjxflg");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users nowLoginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

        BaseWrappers baseWrappers = new BaseWrappers();
        try {

            EmailBodyModel emailBodyModel = emailBodyMapper.selectByBodyId(bodyId);
            String SecretToid=emailBodyModel.getSecretToId();
            String oo="";
            if(!StringUtils.checkNull(SecretToid)){
                String[] split=SecretToid.split(",");
                for(int i=0;i<split.length;i++){
                    if(split[i].equals(nowLoginUser.getUserId())){
                        oo=split[i];
                    }
                }
            }

            String userIds = "";
            if (emailBodyModel != null) {
                if (!StringUtils.checkNull(emailBodyModel.getToId2()) && "toId2".equals(userIdsType)) {
                    userIds = emailBodyModel.getToId2();
                } else if (!StringUtils.checkNull(emailBodyModel.getCopyToId()) && "copyToId" .equals(userIdsType)) {
                    userIds = emailBodyModel.getCopyToId();
                } else if (!StringUtils.checkNull(emailBodyModel.getSecretToId()) && "secretToId".equals(userIdsType)&&"inbox".equals(sjxflg)) {
                    userIds = oo;
                }else if(!StringUtils.checkNull(emailBodyModel.getSecretToId()) && "secretToId".equals(userIdsType)&&"outbox".equals(flag)){
                    userIds = emailBodyModel.getSecretToId();
                }
            }

            if (!StringUtils.checkNull(userIds)) {
                String[] temp = userIds.split(",");
                Map<String, Object> param = new HashMap<String, Object>();
                param.put("userIds", temp);
                param.put("bodyId", bodyId);
                List<EmailModel> datas = emailMapper.selectUserReadFlag1(param);
                for (EmailModel emailModel : datas) {
                    if (emailModel.getReadFlag().equals("1")) {
                        AppLogExample example = new AppLogExample();
                        AppLogExample.Criteria criteria = example.createCriteria();
                        criteria.andOppIdEqualTo(emailModel.getEmailId() + "");
                        criteria.andUserIdEqualTo(emailModel.getUID());
                        criteria.andModuleEqualTo("1");//module 1:邮件模块
                        AppLog appLog = new AppLog();
                        List<AppLog> list = appLogMapper.selectByExample(example);
                        if (list != null && list.size() > 0) {
                            appLog = list.get(0);
                            if (appLog != null && appLog.getTime() != null) {
                                emailModel.setReadTime(DateFormat.getStrDate(appLog.getTime()));
                            } else {
                                emailModel.setReadTime("");
                            }
                        } else {
                            emailModel.setReadTime("");
                        }
                    }
                }
                baseWrappers.setFlag(true);
                baseWrappers.setDatas(datas);
            } else {
                baseWrappers.setFlag(false);
                baseWrappers.setDatas(null);
                baseWrappers.setMsg(I18nUtils.getMessage("email.th.theUserIDIsEmpty"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            baseWrappers.setMsg(e.getMessage());
        }
        return baseWrappers;
    }

    @Override
    public ToJson<EmailBodyModel> selectCount(HttpServletRequest request, HttpServletResponse response, String sendTime, Integer toId, String export) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        Map<String, Object> map = new HashMap<String, Object>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        if (toId == null) {
            toId = user.getDeptId();
        }
        if (toId == -1) {
            toId = null;
        }
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        PageParams pageParams = new PageParams();
        pageParams.setPage(StringUtils.checkNull(page)?1:Integer.valueOf(page));
        pageParams.setPageSize(StringUtils.checkNull(pageSize)?10:Integer.valueOf(pageSize));
        pageParams.setUseFlag(false);
        map.put("page", pageParams);
        map.put("sendTime", sendTime);
        map.put("toId", toId);
        // 获取当前用户，管理的分支机构（包含管理范围）
        List<Department> departmentList = departmentService.getDepartmentByClassifyOrg1(user, false);
        if (!org.springframework.util.CollectionUtils.isEmpty(departmentList)) {
            Set<Integer> deptIds = departmentList.stream().map(Department::getDeptId).collect(Collectors.toSet());
            map.put("deptIds", deptIds);
        }
        List<EmailBodyModel> list = emailBodyMapper.selectCount(map);
        if (list.size()>0) {
            for (EmailBodyModel emailBodyModel : list) {
                if(emailBodyModel.getUsers()==null){
                    Users users = new Users();
                    users.setUserName("");
                    emailBodyModel.setUsers(users);}
                if (emailBodyModel.getCount1() == null) {
                    emailBodyModel.setCount1(0);
                }
                if (emailBodyModel.getCount1() == null) {
                    emailBodyModel.setCount1(0);
                }
                if (emailBodyModel.getCount2() == null) {
                    emailBodyModel.setCount2(0);
                }
                if (emailBodyModel.getCount3() == null) {
                    emailBodyModel.setCount3(0);
                }
                if (emailBodyModel.getCount4() == null) {
                    emailBodyModel.setCount4(0);
                }
                if (emailBodyModel.getCount5() == null) {
                    emailBodyModel.setCount5(0);
                }
                if (emailBodyModel.getCount6() == null) {
                    emailBodyModel.setCount6(0);
                }
                if (emailBodyModel.getCount7() == null) {
                    emailBodyModel.setCount7(0);
                }
                if (emailBodyModel.getCount8() == null) {
                    emailBodyModel.setCount8(0);
                }
                if (emailBodyModel.getCount9() == null) {
                    emailBodyModel.setCount9(0);
                }
                if (emailBodyModel.getCount10() == null) {
                    emailBodyModel.setCount10(0);
                }
                if (emailBodyModel.getCount11() == null) {
                    emailBodyModel.setCount11(0);
                }
                if (emailBodyModel.getCount12() == null) {
                    emailBodyModel.setCount12(0);
                }

            }
        }
        if (export != null && "1".equals(export.trim())) {
            ServletOutputStream out = null;
            try {
                String[] secondTitles = {I18nUtils.getMessage("userManagement.th.department"), I18nUtils.getMessage("userDetails.th.name"),
                        I18nUtils.getMessage("chat.th.1"), I18nUtils.getMessage("chat.th.2"),
                        I18nUtils.getMessage("chat.th.3"), I18nUtils.getMessage("chat.th.4"),
                        I18nUtils.getMessage("chat.th.5"), I18nUtils.getMessage("chat.th.6"),
                        I18nUtils.getMessage("chat.th.7"), I18nUtils.getMessage("chat.th.8"),
                        I18nUtils.getMessage("chat.th.9"), I18nUtils.getMessage("chat.th.10"),
                        I18nUtils.getMessage("chat.th.11"), I18nUtils.getMessage("chat.th.12")};
                HSSFWorkbook workbook = new HSSFWorkbook();
                HSSFCellStyle style = workbook.createCellStyle();
                style.setAlignment(HorizontalAlignment.CENTER);
                style.setVerticalAlignment(VerticalAlignment.CENTER);
                HSSFSheet sheet = workbook.createSheet(I18nUtils.getMessage("adding.th.emailCoun"));
                CellRangeAddress cellRangeAddress = new CellRangeAddress(0, 0, 0, 13);
                CellRangeAddress cellRangeAddress1 = new CellRangeAddress(1, 1, 0, 5);
                CellRangeAddress cellRangeAddress2 = new CellRangeAddress(1, 1, 6, 13);
                sheet.addMergedRegion(cellRangeAddress);
                sheet.addMergedRegion(cellRangeAddress1);
                sheet.addMergedRegion(cellRangeAddress2);
                style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.index);
                style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
                HSSFFont font = workbook.createFont();
                font.setFontHeightInPoints((short) 14);
                font.setBold(true);
                style.setFont(font);
                sheet.createRow(0).createCell(0).setCellStyle(style);
                sheet.getRow(0).getCell(0).setCellValue(I18nUtils.getMessage("email.th.exportOfMailStatistics"));
                HSSFRow rowTwo = sheet.createRow(1);
                rowTwo.createCell(0).setCellStyle(style);
                rowTwo.createCell(6).setCellStyle(style);
                rowTwo.getCell(0).setCellValue(I18nUtils.getMessage("email.th.exportOperator") + "：" + user.getUserName());
                rowTwo.getCell(6).setCellValue(I18nUtils.getMessage("email.th.exportTime") + "：" + DateFormat.getDatestr(new Date()));
                Row R = sheet.createRow(2);
                font.setFontHeightInPoints((short) 10);
                font.setBold(true);
                style.setFont(font);
                for (int i = 0; i < secondTitles.length; i++) {
                    R.createCell(i).setCellStyle(style);
                    R.getCell(i).setCellValue(secondTitles[i]);
                }
                for (int i = 0; i < list.size(); i++) {
                    Row row = sheet.createRow(i + 3);
                    EmailBodyModel emailBodyModel = list.get(i);
                    String username = emailBodyModel.getUsers().getUserName();
                    String deptname = emailBodyModel.getDeptName();
                    row.createCell(0).setCellValue(deptname);
                    row.createCell(1).setCellValue(username);
                    row.createCell(2).setCellValue(emailBodyModel.getCount1());
                    row.createCell(3).setCellValue(emailBodyModel.getCount2());
                    row.createCell(4).setCellValue(emailBodyModel.getCount3());
                    row.createCell(5).setCellValue(emailBodyModel.getCount4());
                    row.createCell(6).setCellValue(emailBodyModel.getCount5());
                    row.createCell(7).setCellValue(emailBodyModel.getCount6());
                    row.createCell(8).setCellValue(emailBodyModel.getCount7());
                    row.createCell(9).setCellValue(emailBodyModel.getCount8());
                    row.createCell(10).setCellValue(emailBodyModel.getCount9());
                    row.createCell(11).setCellValue(emailBodyModel.getCount10());
                    row.createCell(12).setCellValue(emailBodyModel.getCount11());
                    row.createCell(13).setCellValue(emailBodyModel.getCount12());
                }
                out = response.getOutputStream();
                String filename = I18nUtils.getMessage("email.th.exportOfMailStatistics") + ".xls"; //考虑多语言
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                toJson.setMsg("OK");
                toJson.setFlag(0);
                return toJson;
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    out.flush();
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        try {
            if (list != null) {
                toJson.setObj(list);
                toJson.setMsg(I18nUtils.getMessage("email.th.dataRetrievalWasSuccessful"));
                toJson.setFlag(0);
                toJson.setTotleNum(pageParams.getTotal());
            }
        } catch (Exception e1) {
            e1.printStackTrace();
            toJson.setMsg(e1.getMessage());
        }

        return toJson;
    }

    @Override
    public ToJson<EmailBodyModel> selectListByMoths(HttpServletRequest request, String sendTime) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        String year = request.getParameter("year");
        String userId = request.getParameter("userId");
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        try {
            List<EmailBodyModel> list = emailBodyMapper.selectListByMoths(sendTime, year, userId);
            for (EmailBodyModel em : list) {

                //附件处理
                List<Attachment> attachmentList = new ArrayList<Attachment>();
                if (em.getAttachmentName() != null && !"".equals(em.getAttachmentName())) {
                    attachmentList = GetAttachmentListUtil.returnAttachment(em.getAttachmentName(), em.getAttachmentId(), "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")), GetAttachmentListUtil.MODULE_EMAIL);
                }
                em.setAttachmentList(attachmentList);
                em.setSendTimes(DateFormat.getDateStrTime(em.getSendTime()));
            }
            if (list != null) {
                toJson.setObj(list);
                toJson.setMsg(I18nUtils.getMessage("email.th.theDetailsListHasBeenSuccessfullyRetrieved"));
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<EmailBodyModel> selectDetailById(HttpServletRequest request, Integer bodyId) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("bodyId", bodyId);
        try {
            EmailBodyModel emailBodyModel = emailBodyMapper.queryByBodyId(maps);

            //带状态的收件人
            putInfoWithFlag(emailBodyModel, TO_USER_INFO, emailBodyModel.getToId2());
            //带状态的抄送人
            putInfoWithFlag(emailBodyModel, COPY_USER_FINO, emailBodyModel.getCopyToId());
            //带状态的密送人
            putInfoWithFlag(emailBodyModel, SERC_USER_FINO, emailBodyModel.getSecretToId());

            emailBodyModel.setSendTimes(DateFormat.getDateStrTime(emailBodyModel.getSendTime()));
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBodyModel.getToId2());
            if (!ToMap.isEmpty()) {
                emailBodyModel.setToId2(ToMap.keySet().iterator().next());
                emailBodyModel.setToName(ToMap.get(emailBodyModel.getToId2()));
            }
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBodyModel.getCopyToId());

            if (!copyMap.isEmpty()) {
                emailBodyModel.setCopyToId(copyMap.keySet().iterator().next());
                emailBodyModel.setCopyName(copyMap.get(emailBodyModel.getCopyToId()));
            } else {
                emailBodyModel.setCopyName("");
            }
            //附件处理
            List<Attachment> attachmentList = new ArrayList<Attachment>();
            if (emailBodyModel.getAttachmentName() != null && !"".equals(emailBodyModel.getAttachmentName())) {
                attachmentList = GetAttachmentListUtil.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId(), "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")), GetAttachmentListUtil.MODULE_EMAIL);
            }
            emailBodyModel.setAttachmentList(attachmentList);
            if (emailBodyModel != null) {
                toJson.setObject(emailBodyModel);
                toJson.setMsg(I18nUtils.getMessage("email.th.theDetailsListHasBeenSuccessfullyRetrieved"));
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 作者: 张航宁
     * 日期: 2017/12/19
     * 说明: 邮件撤回
     */
    @Override
    public ToJson<EmailModel> updateEmailWithdraw(Integer bodyId) {
        ToJson<EmailModel> json = new ToJson<EmailModel>();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("bodyId", bodyId);
            List<EmailModel> emailModels = emailMapper.selectByBodyId(map);
            List<String> toIds = new ArrayList<String>();
            if (emailModels != null && emailModels.size() > 0) {
                // 循环判断邮件阅读状态
                for (EmailModel emailModel : emailModels) {
                    // 判断已读状态 如果是0 代表未读 可以撤回
                    if (emailModel.getReadFlag().equals("0")) {
                        toIds.add(emailModel.getToId());
                    }
                }
                // 如果收件人中存在未读的 设置该邮件为撤回状态
                if (toIds.size() > 0) {
                    map.put("userIds", toIds);
                    emailMapper.updateEmailWithdraw(map);
                }
            }
            json.setObj(emailModels);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    /**
     * 给邮件添加提醒事务
     *
     * @param emailBodyModel
     */
    @Async
    public void addAffairs(final EmailBodyModel emailBodyModel, final String emailId, final String todoId, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        final String userName = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId).getUserName();
        final EmailBodyModel emailBodyModelf = emailBodyModel;
        final String remind = StringUtils.checkNull(request.getParameter("remind")) ? "0" : request.getParameter("remind");
        if ("0".equals(remind)) {
            return;
        }
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(emailBodyModelf.getFromId());
                smsBody.setSendTime(emailBodyModelf.getSendTime());
                SysCode sysCode = new SysCode();
                if (locale.equals("zh_CN")) {
                    smsBody.setContent("请查收我的邮件！主题：" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("电子邮件");
                } else if (locale.equals("en_US")) {
                    smsBody.setContent("Please check my email！Subject：" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("email");
                } else if (locale.equals("zh_TW")) {
                    smsBody.setContent("請查收我的郵件！主題：" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("電子郵件");
                }
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(emailBodyModelf.getAttachmentId()) && !StringUtils.checkNull(emailBodyModelf.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                smsBody.setRemindUrl("email/emailDetail?id=" + emailId);
                String title = userName + "：请查收我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                if (locale.equals("en_US")) {
                    title = userName + "：Please check my email！";
                    context = "subject:" + emailBodyModelf.getSubject();
                } else if (locale.equals("zh_TW")) {
                    title = userName + "：請查收我的郵件！";
                    context = "主題:" + emailBodyModelf.getSubject();
                }
                smsService.saveSms(smsBody, todoId, "1", "1", title, context, sqlType);
            }
        });
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2018/3/15 15:46
     * 方法介绍:   内部邮箱查询
     *
     * @return
     */
    @Override
    public ToJson<EmailBodyModel> queryEmailBySubject(String trim) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        List<EmailBodyModel> listEmai = emailBodyMapper.queryEmailBySubject(trim);
        EmailBodyModel emailBodyModel = new EmailBodyModel();
        for (EmailBodyModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
            //抄送人
            Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
            //密送人
            Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
            if (!copyMap.isEmpty()) {
                emailBody.setCopyToId(copyMap.keySet().iterator().next());
                emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
            } else {
                emailBody.setCopyName("");
            }
            if (!secretMap.isEmpty()) {
                emailBody.setSecretToId(secretMap.keySet().iterator().next());
                emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
            } else {
                emailBody.setSecretToName("");
            }
            emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
            emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
        }
        tojson.setObj(listEmai);
        tojson.setObject(emailBodyModel);
        return tojson;
    }

    /**
     * 邮件审批设置，使用一对多进行存储
     *
     * @param request
     * @param emailSet
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailSet> addEmailSet(HttpServletRequest request, EmailSet emailSet) {
        ToJson<EmailSet> json = new ToJson<EmailSet>(1, "error");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
            int count = 0;
            List<String> deptIdList = new ArrayList<>();
            if (StringUtils.checkNull(emailSet.getEmailExam())) {
                json.setMsg(I18nUtils.getMessage("email.th.pleaseSetTheApprovalType"));
                return json;
            }
            SysPara sysPara = new SysPara();
            sysPara.setParaName("EMAIL_EXAM");
            sysPara.setParaValue(emailSet.getEmailExam());
            sysParaMapper.updateSysPara(sysPara);
            if ("1".equals(emailSet.getEmailExam())) {
                json.setFlag(0);
                json.setMsg("ok");
                return json;
            } else {
                if (StringUtils.checkNull(emailSet.getDeptId()) || StringUtils.checkNull(emailSet.getUserId())) {
                    json.setFlag(0);
                    json.setMsg("ok");
                    return json;
                }
                if (!StringUtils.checkNull(emailSet.getDeptId())) {
                    deptIdList = Arrays.asList(emailSet.getDeptId().split(","));//管理员
                }
                for (String deptId : deptIdList) {
                    EmailSet temp = emailSetMapper.selUserByDeptId(Integer.valueOf(deptId));
                    emailSet.setDeptId(deptId);
                    if (temp == null) {
                        count = emailSetMapper.insertSelective(emailSet);
                    } else {
                        String[] userIdArr = (temp.getUserId() + emailSet.getUserId()).split(",");
                        List<String> list = new ArrayList<String>();
                        for (int i = 0; i < userIdArr.length; i++) {
                            if (!list.contains(userIdArr[i])) {
                                list.add(userIdArr[i]);
                            }
                        }
                        StringBuffer sb = new StringBuffer();
                        for (String userId : list) {
                            sb.append(userId + ",");
                        }
                        temp.setUserId(sb.toString());
                        count = emailSetMapper.updateByPrimaryKeySelective(temp);
                    }
                }
            }
            if (count > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<EmailSet> delEmailSetById(HttpServletRequest request, int essId) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            int count = emailSetMapper.deleteByPrimaryKey(essId);
            if (count > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    @Transactional
    public ToJson<EmailSet> updateEmailSetById(HttpServletRequest request, EmailSet emailSet) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            int count = emailSetMapper.updateByPrimaryKeySelective(emailSet);
            if (count > 0) {
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<EmailSet> selEmailSet(HttpServletRequest request) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            List<EmailSet> list = emailSetMapper.selectEmailSet();
            SysPara sysPara = sysParaMapper.querySysPara("EMAIL_EXAM");
            for (EmailSet emailSet : list) {
                if (!StringUtils.checkNull(emailSet.getUserId())) {
                    String[] userIdArr = emailSet.getUserId().split(",");
                    StringBuffer sb = new StringBuffer();
                    List<Users> usersList = usersMapper.getUsersByUserIds(userIdArr);
                    for (Users user : usersList) {
                        if (user != null && !StringUtils.checkNull(user.getUserName())) {
                            sb.append(user.getUserName() + ",");
                        }
                    }
                    emailSet.setUserName(sb.toString());
                }
            }
            json.setObj(list);
            json.setObject(sysPara);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 反显，根据部门进行反显
     *
     * @param request
     * @return
     */
    @Override
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request, int essId) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            EmailSet emailSet = emailSetMapper.selectByPrimaryKey(essId);
            if (emailSet != null && !StringUtils.checkNull(emailSet.getUserId())) {
                String[] userIdArr = emailSet.getUserId().split(",");
                StringBuffer sb = new StringBuffer();
                List<Users> usersList = usersMapper.getUsersByUserIds(userIdArr);
                for (Users user : usersList) {
                    if (user != null && !StringUtils.checkNull(user.getUserName())) {
                        sb.append(user.getUserName() + ",");
                    }
                }
                emailSet.setUserName(sb.toString());
            }
            json.setObject(emailSet);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }


    /**
     * 判断收件人、抄送人、密送人和发送人是否在同一个部门中
     *
     * @param toId 收件人userId串
     * @return
     */
    public boolean isSentDiffDept(String toId, Users user) {
        try {
            if (StringUtils.checkNull(toId)) {
                return false;
            }
            String[] userIdArray = toId.split(",");
            Map<String, Object> map = new HashMap<>();
            map.put("userIdArray", userIdArray);
            map.put("deptId", user.getDeptId());
            int count = usersMapper.isUserSameDept(map);
            if (count > 0) {//有外部门人员，需要进行审核
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 查询需要进行审批的邮件(一般审核)
     *
     * @return
     */
    public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            List<EmailBodyModel> resultList = new ArrayList<>();
            //获取邮件审批状态
//            SysPara sysPara = sysParaMapper.querySysPara("EMAIL_EXAM");
            //查询出需要进行审批的邮件
            List<EmailBodyModel> list = emailBodyMapper.selExamEmail();
            List<EmailSet> emailSetList = emailSetMapper.selectEmailSet();
            for (EmailBodyModel emailBodyModel : list) {
                for (EmailSet emailSet : emailSetList) {
                    List<String> userIdList = Arrays.asList(emailSet.getUserId().split(","));
                    if ((emailBodyModel.getDeptId().intValue() == Integer.valueOf(emailSet.getDeptId()).intValue()) && userIdList.contains(user.getUserId())) {
                        resultList.add(emailBodyModel);
                    }
                }
            }
            for (EmailBodyModel emailBodyModel : resultList) {
                if (!StringUtils.checkNull(emailBodyModel.getToId2())) {
                    String[] str = emailBodyModel.getToId2().split(",");
                    List<Users> users = usersMapper.getUserByUserIds(str);
                    StringBuffer sb = new StringBuffer();
                    for (Users user1 : users) {
                        sb.append(user1.getUserName() + ",");
                    }
                    emailBodyModel.setToName(sb.toString());
                }
                emailBodyModel.setSendTimes(DateFormat.getDateStrTime(emailBodyModel.getSendTime()));
            }
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(resultList);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     *
     * @return
     */
    public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            CensorModule censorModule = censorModuleMapper.getCenModuleByCode("0101");
            if (censorModule != null && !StringUtils.checkNull(censorModule.getCheckUser())) {
                List<String> userIdList = Arrays.asList(censorModule.getCheckUser().split(","));
                if (userIdList.contains(user.getUserId())) {
                    List<EmailBodyModel> resultList = emailBodyMapper.selWordExamEmail();
                    for (EmailBodyModel emailBodyModel : resultList) {
                        if (!StringUtils.checkNull(emailBodyModel.getToId2())) {
                            String[] str = emailBodyModel.getToId2().split(",");
                            List<Users> users = usersMapper.getUserByUserIds(str);
                            StringBuffer sb = new StringBuffer();
                            for (Users user1 : users) {
                                sb.append(user1.getUserName() + ",");
                            }
                            emailBodyModel.setToName(sb.toString());
                        }
                        emailBodyModel.setSendTimes(DateFormat.getDateStrTime(emailBodyModel.getSendTime()));

                    }
                    toJson.setObj(resultList);
                }
            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    /**
     * 审批邮件
     */
    public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel, Integer flag, HttpServletRequest request) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "error");
        int count = 0;
        try {
            //一般审批
            if (flag == 1) {
                count = emailBodyMapper.updateExamFlag(emailBodyModel);
            }
            //过滤词审批
            if (flag == 2) {
                Map<String, Object> map = new HashMap<>();
                map.put("bodyId", emailBodyModel.getBodyId());
                EmailBodyModel temp = emailBodyMapper.queryByBodyId(map);
                if ("1".equals(emailBodyModel.getWordFlag())) {
                    map.put("censorWords", new CensorWords());
                    List<CensorWords> list = censorWordsMapper.getCensorWords(map);//全查
                    String subject = temp.getSubject();
                    String content = temp.getContent();
                    for (CensorWords censorWords : list) {
                        subject = subject.replaceAll(censorWords.getFind(), censorWords.getReplacement());
                        content = content.replaceAll(censorWords.getFind(), censorWords.getReplacement());
                    }
                    temp.setSubject(subject);
                    temp.setContent(content);
                }
                temp.setWordFlag(emailBodyModel.getWordFlag());
                count = emailBodyMapper.updateWordFlag(temp);
            }

            Map<String, Object> map = new HashMap<>();
            map.put("bodyId", emailBodyModel.getBodyId());
            EmailBodyModel emailBodyTemp = emailBodyMapper.queryByBodyId(map);

            //审核通过后添加事务提醒
            if (("3".equals(emailBodyTemp.getExamFlag()) || "1".equals(emailBodyTemp.getExamFlag())) && ("3".equals(emailBodyTemp.getWordFlag()) || "1".equals(emailBodyTemp.getWordFlag()))) {
                List<EmailModel> list = emailMapper.selectByBodyId(map);
                StringBuffer emailIdsb=new StringBuffer();
                StringBuffer toIdsb=new StringBuffer();
                for (EmailModel email : list) {
                    emailIdsb.append(email.getEmailId()+",");
                    toIdsb.append(email.getToId()+",");
                }
                if(emailIdsb.length()>0){
                    addAffairs(emailBodyTemp, emailIdsb.toString(), toIdsb.toString(), request);
                }
                //消除邮件审批提醒
                smsService.setSmsReadAll("2", "/email/mailApproval?id=" + emailBodyTemp.getBodyId());
            } else {
                //修改审批事务提醒的状态
                Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
                smsService.setSmsRead("2", "/email/mailApproval?id=" + emailBodyTemp.getBodyId(), users);
            }
            if (count > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public int saveAppLog4Email(AppLog appLog) {
        return appLogMapper.insertSelective(appLog);
    }

    @Override
    public ToJson<EmailBodyModel> selectNewShowEmail(String flag, HttpServletRequest request, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        if(pageSize==null||pageSize==0){
            pageSize=25;
        }
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        if (flag.trim().equals("inbox")) {
            list = emailBodyMapper.selectInbox(maps);
            for (EmailBodyModel emailBody : list) {
                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                String userId = (String) maps.get("fromId");
                List<EmailModel> emailList = emailBody.getEmailList();
                for (EmailModel emailModel : emailList) {
                    if (userId.equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())) {
                        emailBody.setAttachment(new ArrayList<Attachment>());
                        emailBody.setAttachmentName("");
                        emailBody.setAttachmentId("");
                        if (locale.equals("zh_CN")) {
                            emailBody.setContent("邮件已撤回");
                        } else if (locale.equals("en_US")) {
                            emailBody.setContent("The email has been recalled");
                        } else if (locale.equals("zh_TW")) {
                            emailBody.setContent("郵件已撤回");
                        }
                    }
                    //加上未读标识 0 未读
                    if (!StringUtils.checkNull(emailModel.getReadFlag()) && emailModel.getReadFlag().equals("0")){
                        emailBody.setReadFlag("0");
                    }
                }
            }
            Map<String, Object> map2 = new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            tojson.setNoReadCount(emailBodyMapper.getNoReadCount(map2));
            tojson.setDraftsCount(emailBodyMapper.listDraftsCount(map2));
            tojson.setHairboxCount(emailBodyMapper.listSendEmailCount(map2));
            tojson.setWasteCount(emailBodyMapper.listWastePaperbasketCount(map2));
            tojson.setInboxCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        }
        else if (flag.trim().equals("drafts")) {
            list = emailBodyMapper.listDrafts(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }
            Map<String, Object> map2 = new HashedMap();
            map2.put("fromId", maps.get("fromId"));

            tojson.setNoReadCount(emailBodyMapper.getNoReadCount(map2));
            tojson.setHairboxCount(emailBodyMapper.listSendEmailCount(map2));
            tojson.setWasteCount(emailBodyMapper.listWastePaperbasketCount(map2));
            tojson.setInboxCount(emailBodyMapper.selectInboxCount(map2));

            tojson.setDraftsCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
            list = emailBodyMapper.listDrafts(maps);
        }
        else if (flag.trim().equals("outbox")) {
            list = emailBodyMapper.listSendEmail(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                if (!StringUtils.checkNull(emailBody.getToId2())) {
                    String[] toId2s = emailBody.getToId2().split(",");
                    if(toId2s.length > 0){
                        List<Users> usersByBynamesOrder = usersMapper.getUsersByUserIdsOrder(emailBody.getToId2().split(","));
                        StringBuilder sb = new StringBuilder();
                        for (int i = 0, length = usersByBynamesOrder.size(); i < length; i++) {
                            sb.append(usersByBynamesOrder.get(i).getUserName()).append(",");
                        }
                        emailBody.setToName(sb.toString());
                    }
                }
            }
            Map<String, Object> map2 = new HashedMap();
            map2.put("fromId", maps.get("fromId"));

            tojson.setNoReadCount(emailBodyMapper.getNoReadCount(map2));
            tojson.setDraftsCount(emailBodyMapper.listDraftsCount(map2));
            tojson.setInboxCount(emailBodyMapper.selectInboxCount(map2));
            tojson.setWasteCount(emailBodyMapper.listWastePaperbasketCount(map2));

            tojson.setHairboxCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        }
        else if (flag.trim().equals("recycle")) {
            list = emailBodyMapper.listWastePaperbasket(maps);
            for (EmailBodyModel emailBody : list) {
                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }
            Map<String, Object> map2 = new HashedMap();
            map2.put("fromId", maps.get("fromId"));

            tojson.setNoReadCount(emailBodyMapper.getNoReadCount(map2));
            tojson.setDraftsCount(emailBodyMapper.listDraftsCount(map2));
            tojson.setHairboxCount(emailBodyMapper.listSendEmailCount(map2));
            tojson.setInboxCount(emailBodyMapper.selectInboxCount(map2));

            tojson.setWasteCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        }
        else if (flag.trim().equals("noRead")) {
            list = emailBodyMapper.selectIsRead(maps);
            for (EmailBodyModel emailBody : list) {
                //收件人
                Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
                emailBody.setToId2(ToMap.keySet().iterator().next());
                emailBody.setToName(ToMap.get(emailBody.getToId2()));
                //抄送人
                Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
                //密送人
                Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
                if (!copyMap.isEmpty()) {
                    emailBody.setCopyToId(copyMap.keySet().iterator().next());
                    emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
                } else {
                    emailBody.setCopyName("");
                }
                if (!secretMap.isEmpty()) {
                    emailBody.setSecretToId(secretMap.keySet().iterator().next());
                    emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
                } else {
                    emailBody.setSecretToName("");
                }
                emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
                if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
            }
            tojson.setObj(list);
            tojson.setTotleNum(pageParams.getTotal());
        }
        else if ("inboxNoRead".equals(flag.trim())) {
            maps.put("readFlag", "0");
            list = emailBodyMapper.selectInboxNoRead(maps);
            for (EmailBodyModel emailBody : list) {
                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                //加上未读标识 0
                emailBody.setReadFlag("0");
            }
            Map<String, Object> map2 = new HashMap();
            map2.put("fromId", maps.get("fromId"));

            tojson.setInboxCount(emailBodyMapper.selectInboxCount(map2));
            tojson.setDraftsCount(emailBodyMapper.listDraftsCount(map2));
            tojson.setHairboxCount(emailBodyMapper.listSendEmailCount(map2));
            tojson.setWasteCount(emailBodyMapper.listWastePaperbasketCount(map2));
            tojson.setNoReadCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        }
        else {
            List<EmailBodyModel> newArrlist = new ArrayList<EmailBodyModel>();
            list = emailBodyMapper.selectObjcet(maps);
            for (EmailBodyModel emailBody : list) {
                //收件人
                Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
                if (!ToMap.isEmpty()) {
                    emailBody.setToId2(ToMap.keySet().iterator().next());
                    emailBody.setToName(ToMap.get(emailBody.getToId2()));
                }
                //抄送人
                Map<String, String> copyMap = this.getEmailUserName(emailBody.getCopyToId());
                //密送人
                Map<String, String> secretMap = this.getEmailUserName(emailBody.getSecretToId());
                if (!copyMap.isEmpty()) {
                    emailBody.setCopyToId(copyMap.keySet().iterator().next());
                    emailBody.setCopyName(copyMap.get(emailBody.getCopyToId()));
                } else {
                    emailBody.setCopyName("");
                }
                if (!secretMap.isEmpty()) {
                    emailBody.setSecretToId(secretMap.keySet().iterator().next());
                    emailBody.setSecretToName(secretMap.get(emailBody.getSecretToId()));
                } else {
                    emailBody.setSecretToName("");
                }
                emailBody.setEmailList(this.returnEmail(emailBody.getEmailList()));
                emailBody.setProbablyDate(DateFormat.getProbablyDate(emailBody.getSendTime()));
                if (emailBody.getAttachmentName() != null && emailBody.getAttachmentId() != null) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                newArrlist.add(emailBody);
            }
            list = newArrlist;
            tojson.setTotleNum(pageParams.getTotal());
        }
        for (EmailBodyModel emailBody : list) {
            emailBody.setSendTimes(DateFormat.getDateStrTime(emailBody.getSendTime()));
        }
        tojson.setObj(list);
        return tojson;
    }

    /**
     * 判断邮件是否需要进行审核，需要审核的添加事务提醒
     *
     * @return
     */
    private EmailBodyModel setApproveAndSms(EmailBodyModel emailBody, Users user) {
        //获取邮件是否需要进行审核
        SysPara sysPara = sysParaMapper.querySysPara("EMAIL_EXAM");
        switch (sysPara.getParaValue()) {
            case "1"://无需审核
                emailBody.setExamFlag("3");
                break;
            case "2"://需要进行审核
                EmailSet emailSet = emailSetMapper.selUserByDeptId(user.getDeptId());
                if (emailSet == null || StringUtils.checkNull(emailSet.getUserId())) {
                    emailBody.setApproveFlag("1");//需要进行设置管理员
                }
                emailBody.setExamFlag("0");
                break;
            case "3"://跨部门审核
                String toId = emailBody.getToId2() + emailBody.getCopyToId() + emailBody.getSecretToId();
                boolean result = isSentDiffDept(toId, user);
                if (result) {//需要进行跨部门审核
                    EmailSet emailSet1 = emailSetMapper.selUserByDeptId(user.getDeptId());
                    if (emailSet1 == null || StringUtils.checkNull(emailSet1.getUserId())) {
                        emailBody.setApproveFlag("1");//需要进行设置管理员
                    }
                    emailBody.setExamFlag("0");
                } else {
                    emailBody.setExamFlag("3");
                }
                break;
        }
        //过滤词替换
        CensorModule censorModule = censorModuleMapper.getCenModuleByCode("0101");
        Map<String, Object> map = new HashMap<>();
        map.put("censorWords", new CensorWords());
        List<CensorWords> censorWordsList = censorWordsMapper.getCensorWords(map);
        //查看邮件主题、内容中是否包含过滤词
        boolean isExist = false;
        for (CensorWords temp : censorWordsList) {
            if (emailBody.getSubject().contains(temp.getFind()) || emailBody.getContent().contains(temp.getFind())) {
                isExist = true;
                break;
            }
        }
        if (isExist) {
            if (censorModule != null && "1".equals(censorModule.getUseFlag())) {//需要进行审核
                if (StringUtils.checkNull(censorModule.getCheckUser())) {
                    emailBody.setApproveFlag("1");//需要进行设置管理员
                } else {
                    emailBody.setWordFlag("0");
                }
            } else {
                emailBody.setWordFlag("3");
            }
        } else {
            emailBody.setWordFlag("3");
        }
        return emailBody;
    }


    /**
     * 给邮件添加审批提醒事务
     *
     * @param emailBodyModel
     */
    @Async
    public void addAffairsApprove(final EmailBodyModel emailBodyModel, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        final EmailBodyModel emailBodyModelf = emailBodyModel;
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(emailBodyModelf.getFromId());
                smsBody.setSendTime(emailBodyModelf.getSendTime());
                SysCode sysCode = new SysCode();
                if (locale.equals("zh_CN")) {
                    smsBody.setContent("请审批我的邮件！主题：" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("电子邮件");
                } else if (locale.equals("en_US")) {
                    smsBody.setContent("Please approve my email! Subject:" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("email");
                } else if (locale.equals("zh_TW")) {
                    smsBody.setContent("請審批我的郵件！主題：" + emailBodyModelf.getSubject());
                    sysCode.setCodeName("電子郵件");
                }
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(emailBodyModelf.getAttachmentId()) && !StringUtils.checkNull(emailBodyModelf.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                String toUserId = "";
                if ("0".equals(emailBodyModel.getExamFlag())) {//需要一般审批的人员
                    EmailSet emailSet = emailSetMapper.selUserByDeptId(users.getDeptId());
                    toUserId = emailSet.getUserId();
                }
                if ("0".equals(emailBodyModel.getWordFlag())) {//需要进行过滤词审批的人员
                    CensorModule censorModule = censorModuleMapper.getCenModuleByCode("0101");
                    toUserId += censorModule.getCheckUser();
                }
                toUserId = StringUtils.getRemoveStr(toUserId);
                smsBody.setRemindUrl("/email/mailApproval?id=" + emailBodyModel.getBodyId());//flag未用，方便拼接
                String title = users.getUserName() + "：请审批我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                if (locale.equals("en_US")) {
                    title = users.getUserName() + "：Please approve my email！";
                    context = "subject:" + emailBodyModelf.getSubject();
                } else if (locale.equals("zh_TW")) {
                    title = users.getUserName() + "：請審批我的郵件！";
                    context = "主題:" + emailBodyModelf.getSubject();
                }
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
            }
        });
    }

    /**
     * 邮件分发
     *
     * @param emailBodyModel
     * @param request
     * @param response
     * @param remind
     * @param mId
     * @param mName
     * @return
     */
    @Override
    public ToJson SendEmails(EmailBodyModel emailBodyModel, HttpServletRequest request, HttpServletResponse response, String remind, String mId, String mName) {
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ToJson<EmailModel> json = new ToJson<EmailModel>(1, "error");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        List<Attachment> list = GetAttachmentListUtil.returnAttachment(mName, mId, sqlType, "email");
        try {
            //判读当前系统
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer stringBuffer = new StringBuffer();
            if (osName.toLowerCase().startsWith("win")) {
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if (uploadPath.indexOf(":") == -1) {
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath();
                    //获取截取后的路径
                    String str2 = "";
                    if (basePath.indexOf("/xoa") != -1) {
                        //返回指定字符在此字符串中第一次出现处的索引
                        int index = basePath.indexOf("/xoa");
                        //从指定位置开始到指定位置结束截取字符串
                        str2 = basePath.substring(0, index);
                    }
                    stringBuffer = stringBuffer.append(str2 + "/xoa");
                }
                stringBuffer.append(uploadPath);
            } else {
                stringBuffer = stringBuffer.append(rb.getString("upload.linux"));
            }
            // 将文件上传成功后进行读取文件
            // 进行读取的路径
            String readPath = stringBuffer.append(System.getProperty("file.separator")).append(sqlType)
                    .append(System.getProperty("file.separator")).append("email")
                    .append(System.getProperty("file.separator")).append(list.get(0).getYm())
                    .append(System.getProperty("file.separator")).append(list.get(0).getAttachId() + "." + list.get(0).getAttachName()).toString();
            if (osName.toLowerCase().startsWith("win") && readPath.substring(0, 1).equals("/")) {
                readPath = readPath.substring(1);
            }
            InputStream in = new FileInputStream(readPath);
            HSSFWorkbook excelObj = new HSSFWorkbook(in);
            HSSFSheet sheetObj = excelObj.getSheetAt(0);
            Row row = sheetObj.getRow(0);    //开始行数
            int colNum = row.getPhysicalNumberOfCells(); //总列数
            int lastRowNum = sheetObj.getLastRowNum(); //总行数
            String[] attachmentNames = emailBodyModel.getAttachmentName().split("\\u002A"); //附件名称
            String[] attachmentIds = emailBodyModel.getAttachmentId().split(",");     //附件 id
            //将附件 id 和 name 设为空 ★ ★ ★
            emailBodyModel.setAttachmentId("");
            emailBodyModel.setAttachmentName("");
            //接受 Excel 中的附件名称
            String attachmentName = "";
            //存放 Excel 中所有收件人的姓名
            StringBuffer strUsers = new StringBuffer();
            StringBuffer strNames = new StringBuffer();
            StringBuffer strIds = new StringBuffer();
            //存放上传所有附件
            Map<String, Object> map = new HashMap<>();
            //附件存入 map
            for (int n = 0; n < attachmentNames.length; n++) {
                map.put(attachmentNames[n], attachmentIds[n]);
            }
            //读取 Excel
            for (int i = 1; i <= lastRowNum; i++) {
                row = sheetObj.getRow(i);
                if (row != null) {
                    for (int j = 0; j < colNum; j++) {
                        Cell cell = row.getCell(j);
                        if (cell != null) {
                            switch (j) {
                                case 0:
                                    // 用户名
                                    if (row.getCell(j) != null) {
                                        row.getCell(j).setCellType(CellType.STRING);
                                        Users ur = usersMapper.getUsersBybyname(row.getCell(j).getStringCellValue().trim());
                                        if (ur != null) {
                                            emailBodyModel.setToId2(ur.getUserId());
                                            strUsers.append(ur.getUserId() + ",");
                                        }
                                    }
                                    break;
                                case 1:
                                    // 附件名
                                    if (!cell.getStringCellValue().trim().equals("")) {
                                        attachmentName = cell.getStringCellValue().trim();
                                        String attachmentName1 = attachmentName.substring(0,attachmentName.lastIndexOf("."));// 去掉附件后缀
                                        if (!attachmentName1.equals("")) {
                                            for (String key : map.keySet()) {  //遍历key 找附件 name 和 id
                                                if (!key.equals("")) {
                                                    if (attachmentName.equals(key)) {
                                                        emailBodyModel.setAttachmentName(key + "*");
                                                        emailBodyModel.setAttachmentId(map.get(key).toString() + ",");
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    break;
                            }
                        }
                    }
                }
                //插入 email 表
                EmailModel emailModel = new EmailModel();
                //插入 email_body 表 ☹ ☹ ☹
                if (StringUtils.checkNull(emailBodyModel.getFromId())) {
                    emailBodyModel.setFromId(user.getUserId());
                }
                emailBodyModel.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
                emailBodyModel.setSendFlag("1");
                if (StringUtils.checkNull(emailBodyModel.getToId2()) && !StringUtils.checkNull(emailBodyModel.getAttachmentId()) && !StringUtils.checkNull(emailBodyModel.getAttachmentName())) {
                    strIds.append(emailBodyModel.getAttachmentId());
                    strNames.append(emailBodyModel.getAttachmentName());
                } else {
                    emailBodyMapper.save(emailBodyModel);
                    //插入 email 表。  收件人 和 附件 对应 不会出现多个收件人 不处理 ToId2
                    emailModel.setToId(emailBodyModel.getToId2());
                    emailModel.setBoxId(0);
                    emailModel.setBodyId(emailBodyModel.getBodyId());
                    emailMapper.SendEmails(emailModel);
                    //事务提醒 ☀ ☀ ☀
                    if (remind.equals("1")) {
                        addAffairs(emailBodyModel, emailModel.getEmailId().toString(), emailBodyModel.getToId2(), request);
                    }
                    //清空附件和收件人
                    emailBodyModel.setAttachmentName("");
                    emailBodyModel.setAttachmentId("");
                    emailBodyModel.setToId2("");
                }
                if (i == lastRowNum) { //读到最后一行
                    if (!StringUtils.checkNull(strUsers.toString()) && !StringUtils.checkNull(strIds.toString()) && !StringUtils.checkNull(strNames.toString())) {
                        emailBodyModel.setAttachmentId(strIds.toString());
                        emailBodyModel.setAttachmentName(strNames.toString());
                        emailBodyModel.setToId2(strUsers.toString());
                        emailBodyMapper.save(emailBodyModel);
                        //插入 email 表。  email表 是一个收件人一条信息 处理 ToId2
                        emailModel.setBoxId(0);
                        emailModel.setBodyId(emailBodyModel.getBodyId());
                        String[] toIds = emailBodyModel.getToId2().split(",");
                        if (toIds.length > 0) {
                            for (String str : toIds) {
                                emailModel.setToId(str);
                                emailMapper.SendEmails(emailModel);
                            }
                        }
                        emailMapper.SendEmails(emailModel);
                        //事务提醒 ☀ ☀ ☀
                        if (remind.equals("1")) {
                            addAffairs(emailBodyModel, emailModel.getEmailId().toString(), emailBodyModel.getToId2(), request);
                        }
                    }
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(I18nUtils.getMessage("email.th.abnormalDataSaving"));
        }
        return json;
    }

    /**
     * 查询归档库 表名字 ♎ ♎ ♎
     *
     * @param request
     * @return
     */
    @Override
    public ToJson getEmailNames(HttpServletRequest request) {
        ToJson toJson = new ToJson(1, "err");
        try {
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            I18nUtils.setLocale(locale);
            // 获取初始组织
            String loginDateSouse = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")); // 数据是1001 1002 1003 这种格式
            String tableSchame = "td_oa_archive";
            //切换的库
            if(!"1000".equals(loginDateSouse)){
                tableSchame = "td_oa_archive"+loginDateSouse;
            }
            List<String> emailNames = emailBodyMapper.getEmailNames(tableSchame);
            if (emailNames!= null) {
                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObject(emailNames);
            } else {
                toJson.setFlag(0);
                toJson.setMsg(I18nUtils.getMessage("email.th.thereIsNoArchivedInformation"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 归档查询 ✈ ✈ ✈
     *
     * @param maps
     * @return
     */
    public ToJson<EmailBodyModel> gdSelect(Map<String, Object> maps, HttpServletRequest request, String email, Integer page,
                                           Integer pageSize, boolean useFlag, String tableName) {
        ToJson<EmailBodyModel> toJson = new ToJson<>(1, "err");
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        List<EmailBodyModel> list;
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        maps.put("emailId", Integer.parseInt(tableName));
        // 获取初始组织并存放
        String loginDateSouse = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")); // 数据是1001 1002 1003 这种格式
        String firstDBSource = "xoa" + loginDateSouse;
        //切换的库
        if(!"1000".equals(loginDateSouse)){
            maps.put("dbSource","td_oa_archive"+loginDateSouse);
        } else {
            maps.put("dbSource","td_oa_archive");
        }
        try {
            switch (email) {
                case "inbox":  //收件箱
                    list = emailBodyMapper.selectInbox2(maps);
                    toJson.setFlag(0);
                    toJson.setObj(list);
                    break;
                case "drafts": //草稿箱
                    list = emailBodyMapper.listDrafts2(maps);
                    toJson.setFlag(0);
                    toJson.setObj(list);
                    break;
                case "outbox":  //发件箱
                    list = emailBodyMapper.listSendEmail2(maps);
                    toJson.setFlag(0);
                    toJson.setObj(list);
                    break;
                case "recycle": //废纸篓
                    list = emailBodyMapper.listWastePaperbasket2(maps);
                    toJson.setFlag(0);
                    toJson.setObj(list);
                    break;
            }
            toJson.setTotleNum(pageParams.getTotal());
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(I18nUtils.getMessage("email.th.queryError"));
        } finally {
            // 切换回当前库
            ContextHolder.setConsumerType(firstDBSource);
        }
        //归档查询后补充用户信息
        if(toJson.getObj() != null){
            for(EmailBodyModel model :toJson.getObj()){
                Users byUserId = usersMapper.getByUserId(model.getFromId());
                if(byUserId == null){
                    byUserId = new Users();
                    byUserId.setUserName(model.getFromId());
                    byUserId.setAvatar("0");
                }
                model.setUsers(byUserId);
                model.setSendTimes(DateFormat.getDateStrTime(model.getSendTime()));
            }
        }
        return toJson;
    }

    @Override
    public ToJson<EmailBodyModel> upDateDiu(HttpServletRequest request, String toId, String emailId) {
        ToJson<EmailBodyModel> toJson = new ToJson<>();
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        Map<String, Object> map = new HashMap<>();
        int a = 0;
        if (!StringUtils.checkNull(emailId)) {
            String[] str = emailId.split(",");
            for (int i = 0; i < str.length; i++) {
                map.put("toId", toId);
                map.put("emailId", str[i]);
                a = emailMapper.updateDiu(map);
            }
        }
        if (a > 0) {
            toJson.setFlag(0);
            toJson.setMsg(I18nUtils.getMessage("event.th.recoverySuccessful"));
        }
        return toJson;
    }

    @Override
    public BaseWrapper judgeEmailSize(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            I18nUtils.setLocale(locale);

            Integer emailCapacity = userExtMapper.selectEmailCapacityByUserId(user.getUserId());

            Map<String, Object> maps = new HashMap<>();
            maps.put("userId",user.getUserId());
            maps.put("fromId","fromId");
            List<EmailBodyModel> emailBodyModels = new ArrayList<>();
            emailBodyModels.addAll(emailBodyMapper.selectEmailSizeByUserId(maps));
            maps.remove("fromId");
            maps.put("toId","toId");
            emailBodyModels.addAll(emailBodyMapper.selectEmailSizeByUserId(maps));
            Long totalCapacity = FileUtility.computingCapacity(0L, emailBodyModels.stream().mapToLong(EmailBodyModel::getSize).sum() + "B", 1);
            //单位B转换成MB
            Long capacity = totalCapacity / 1024 / 1024;
            JSONObject jsonObject = JSONObject.fromObject("{totalCapacity:" + capacity + ",emailCapacity:"+ emailCapacity + "}");
            baseWrapper.setData(jsonObject);

            // 如果当前用户的容量被设置为0，则不进行比较，视用户为无限容量。
            if (emailCapacity == 0.0) {
                baseWrapper.setStatus(true);
                baseWrapper.setFlag(true);
                baseWrapper.setMsg("true");
                return baseWrapper;
            }

            // 已用容量与设置的容量进行大小比较
            if (capacity < emailCapacity) {
                baseWrapper.setStatus(true);
                baseWrapper.setFlag(true);
                baseWrapper.setMsg("true");
            } else {
                baseWrapper.setStatus(false);
                baseWrapper.setFlag(false);
                baseWrapper.setMsg(I18nUtils.getMessage("email.th.emailCapacityExceedsLimitPrompt"));
            }
        }catch (Exception e){
            baseWrapper.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return baseWrapper;
    }

    //做一个email_body表SIZE字段维护，主要是统计附件大小，查询附件字段有值但SIZE字段为0的计算一下SIZE
    private void updateZeroSizeEmail(String sqlType){
        List<EmailBodyModel> zeroSizeEmail = emailBodyMapper.selectZeroSizeEmail();
        if(!Objects.isNull(zeroSizeEmail) && zeroSizeEmail.size() > 0){
            for (EmailBodyModel emailBodyModel : zeroSizeEmail) {
                List<Attachment> attachments = GetAttachmentListUtils.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId()
                        , sqlType, GetAttachmentListUtils.MODULE_EMAIL);
                String changeSizes = attachments.stream().map(Attachment::getSize).collect(Collectors.joining(","));
                Long emailSize = FileUtility.computingCapacity(0L, changeSizes, 1);
                //如果计算出来的大小仍为0，赋值为1避免后续再被查询出来计算一次
                emailBodyModel.setSize(emailSize > 0 ? emailSize : 1);
                //修改为在循环中处理，
                emailBodyMapper.updateZeroSizeEmail(emailBodyModel);
            }
        }
    }
}
