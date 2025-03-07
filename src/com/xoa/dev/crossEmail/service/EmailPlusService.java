package com.xoa.dev.crossEmail.service;

import com.xoa.dao.censor.CensorModuleMapper;
import com.xoa.dao.censor.CensorWordsMapper;
import com.xoa.dao.common.AppLogMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.email.EmailBoxMapper;
import com.xoa.dao.email.WebmailMapper;
import com.xoa.dao.email.emailSet.EmailSetMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.crossEmail.dao.EmailBodyplusMapper;
import com.xoa.dev.crossEmail.dao.EmailPlusMapper;
import com.xoa.dev.crossEmail.model.EmailBodyPlusModel;
import com.xoa.dev.crossEmail.model.EmailPlusModel;
import com.xoa.model.censor.CensorModule;
import com.xoa.model.censor.CensorWords;
import com.xoa.model.common.AppLog;
import com.xoa.model.common.AppLogExample;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.email.EmailBoxModel;
import com.xoa.model.email.Webmail;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.users.Users;
import com.xoa.service.ThreadSerivice.ThreadService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.email.EmailUtil;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

/**
 * Created by gsb on 2018/6/8.
 */
@Service
public class EmailPlusService {

    private final Integer TO_USER_INFO = 0x11;//收件人信息
    private final Integer COPY_USER_FINO = 0x12;//抄送人信息
    private final Integer SERC_USER_FINO = 0x13;//抄送人信息


    @Resource
    private EmailBodyplusMapper emailBodyPlusMapper;


    @Resource
    private EmailPlusMapper emailPlusMapper;

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
    ThreadService threadService;
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
    /** 创建作者: 高亚峰
     *  创建说明  处理邮件附件不为空且主题为空的情况
     * @param emailBody
     * @return
     */
    public EmailBodyPlusModel returnSubject(EmailBodyPlusModel emailBody){
        if(StringUtils.checkNull(emailBody.getSubject())){
            if(!StringUtils.checkNull(emailBody.getAttachmentName())){
                String newStr =emailBody.getAttachmentName();
                String[] split = newStr.split("\\*");
                //格式xxxx.xx
                if(!StringUtils.checkNull(split[0])){
                    String s = split[0];
                    int i = s.lastIndexOf(".");
                    if(i!=-1){
                        String substring = s.substring(0, i);
                        emailBody.setSubject(substring);
                    }
                }
            }else{
                emailBody.setSubject("【无主题】");
            }
        }
        return emailBody;
    }

    @Transactional
    public ToJson<EmailBodyPlusModel> sendEmail(EmailBodyPlusModel emailBody, EmailPlusModel email, String sqlType, String remind, HttpServletRequest request,String sql) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
            emailBody.setSendFlag("1");
            //获取邮件是否需要进行审核
            EmailBodyPlusModel emailBodyModel=setApproveAndSms(emailBody,users);
            /*if ("1".equals(emailBodyModel.getApproveFlag())){
                toJson.setFlag(0);
                toJson.setMsg("needAdmin");
                return toJson;
            }*/
            if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                // 包含外部邮件发送
                toJson = this.returnSendWebEmail(emailBody, email, sqlType, request);
             /*   threadService.addEmail(emailBody,email,request);*/
            } else {
                //收件人
                Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
                if (!ToMap.isEmpty()) {
                    emailBody.setToId2(ToMap.keySet().iterator().next());
                    //emailBody.setToId2Name(ToMap.get(emailBody.getToId2()));
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
                    emailBody.setCopyToIdName(copyMap.get(emailBody.getCopyToId()));
                } else {
                    emailBody.setCopyToIdName("");
                }
                if (!secretMap.isEmpty()) {
                    emailBody.setSecretToId(secretMap.keySet().iterator().next());
                    emailBody.setSecretToIdName(secretMap.get(emailBody.getSecretToId()));
                } else {
                    emailBody.setSecretToIdName("");
                }
                //处理下没主题且有附件的
                emailBody = returnSubject(emailBody);
                emailBodyPlusMapper.save(emailBody);
                toJson = this.returnEmail(emailBody, email, remind, request);
                //判断多组织是否是当前库
                if (!sqlType.equals("xoa" + sql)) {
                    ContextHolder.setConsumerType("xoa"+sql);
                    //处理下没主题且有附件的
                    emailBody = returnSubject(emailBody);
                    emailBodyPlusMapper.save(emailBody);
                    toJson = this.returnEmail(emailBody, email, remind, request);
                }
                addAffairsPlus(emailBody, email.getEmailId(), remind, request, sql);
            }
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
    
    @Transactional
    public ToJson<EmailBodyPlusModel> saveEmail(EmailBodyPlusModel emailBody, String sqlType,String sql) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));
            emailBody.setSendFlag("0");
            if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                toJson = this.returnSaveWebEmail(emailBody);
            } else {
                emailBodyPlusMapper.save(emailBody);
                //判断多组织是否是当前库
                if (!sqlType.equals("xoa" + sql)) {
                    ContextHolder.setConsumerType("xoa"+sql);
                    emailBodyPlusMapper.save(emailBody);
                }
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
     * @return List<EmailBodyPlusModel>
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> selectEmail(Map<String, Object> maps, Integer page,
                                              Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectObjcet(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
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

    public void deleteByID(Integer bodyId) {
        emailBodyPlusMapper.deleteDrafts(bodyId);
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
     * @return List<EmailBodyPlusModel>
     */

    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> listDrafts(Map<String, Object> maps, Integer page,
                                             Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.listDrafts(maps);

        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));
        Map<String, Object> map3 = new HashedMap();
        map3.put("fromId", maps.get("fromId"));
        Map<String, Object> map4 = new HashedMap();
        map4.put("fromId", maps.get("fromId"));
        List<EmailBodyPlusModel> inboxs = emailBodyPlusMapper.selectInbox(map2);
        List<EmailBodyPlusModel> outemails = emailBodyPlusMapper.listSendEmail(map3);
        List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map4);

        for (EmailBodyPlusModel emailBody : listEmai) {
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
     * @return List<EmailBodyPlusModel>
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> listSendEmail(Map<String, Object> maps,
                                                Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
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
        List<EmailBodyPlusModel> inboxs = emailBodyPlusMapper.selectInbox(map2);
        List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
        List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map4);

        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.listSendEmail(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
            //收件人
            Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
            if(ToMap.size()!=0){
                emailBody.setToId2(ToMap.keySet().iterator().next());
                emailBody.setToName(ToMap.get(emailBody.getToId2()));
            }else{
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
     * @return List<EmailBodyPlusModel>
     */

    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> listWastePaperbasket(Map<String, Object> maps,
                                                       Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);

        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);

        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));


        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();

        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.listWastePaperbasket(maps);

        List<EmailBodyPlusModel> inboxs = emailBodyPlusMapper.selectInbox(map2);
        List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
        List<EmailBodyPlusModel> listHairbox = emailBodyPlusMapper.listSendEmail(map2);


        for (EmailBodyPlusModel emailBody : listEmai) {
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
     * @return List<EmailBodyPlusModel>
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> selectEmailBody(Map<String, Object> maps,
                                                  Integer page, Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.listqueryEmailBody(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
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
     * @return EmailBodyPlusModel
     */

    public EmailBodyPlusModel queryById(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        if (maps.get("emailId") != null) {
            maps.remove("bodyId");
        }
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        EmailBodyPlusModel emailBody = emailBodyPlusMapper.queryById(maps);
        //收件人
        Map<String, String> ToMap = this.getEmailUserName(emailBody.getToId2());
        if (!ToMap.isEmpty()) {
            emailBody.setToId2(ToMap.keySet().iterator().next());
            emailBody.setToName(ToMap.get(emailBody.getToId2()));
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

    private void putInfoWithFlag(EmailBodyPlusModel emailBody, Integer type, String userIds) {
        if (emailBody != null) {
            if (!StringUtils.checkNull(userIds)) {
                String[] temp = userIds.split(",");
                Map<String, Object> param = new HashMap<String, Object>();
                param.put("userIds", temp);
                param.put("bodyId", emailBody.getBodyId());
                List<EmailPlusModel> datas = emailPlusMapper.selectUserReadFlag(param);
                if (type == TO_USER_INFO) {
                    emailBody.setToUserEmailInfo(datas);
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
     * 创建日期:   2017-4-20 上午10:49:30
     * 方法介绍:   收件箱查询
     * 参数说明:   @param maps 相关条件参数传值
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 每页显示条数
     * 参数说明:   @param useFlag 是否开启分页插件
     * 参数说明:   @return 结果集合
     * 参数说明:   @throws Exception
     *
     * @return List<EmailBodyPlusModel>
     */
    @SuppressWarnings("all")
   
    public ToJson<EmailBodyPlusModel> selectInbox(HttpServletRequest request,Map<String, Object> maps, Integer page,
                                              Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();

        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> emailSize = emailBodyPlusMapper.selectInbox(maps);
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectInbox(maps);
        Map<String, Object> map2 = new HashedMap();
        map2.put("fromId", maps.get("fromId"));
        Map<String, Object> map3 = new HashedMap();
        map3.put("fromId", maps.get("fromId"));
        Map<String, Object> map4 = new HashedMap();
        map4.put("fromId", maps.get("fromId"));
        List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
        List<EmailBodyPlusModel> outemails = emailBodyPlusMapper.listSendEmail(map3);
        List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map4);
        EmailBodyPlusModel emailBodyModel = new EmailBodyPlusModel();
        if (drafts != null) {
            emailBodyModel.setDraftsCount(drafts.size());
        }
        if (outemails != null) {
            emailBodyModel.setHairboxCount(outemails.size());
        }
        for (EmailBodyPlusModel emailBody : listEmai) {
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
            if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
            } else {
                emailBody.setAttachmentName("");
                emailBody.setAttachmentId("");
            }
//            list.add(emailBody);
        }
        // 查询收件箱总数
        Integer integer = emailPlusMapper.selectEmailInboxCount();

        tojson.setDraftsCount(drafts.size());
        tojson.setHairboxCount(outemails.size());
        tojson.setWasteCount(wastes.size());
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        /*if (users.getUserId().equals("admin")){
            tojson.setInboxCount(integer);
            tojson.setTotleNum(integer);
        }
        else{
            tojson.setInboxCount(listEmai.size());
            tojson.setTotleNum(listEmai.size());
        }*/
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
     * @return List<EmailBodyPlusModel>
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> selectIsRead(Map<String, Object> maps, Integer page,
                                               Integer pageSize, boolean useFlag, String sqlType) throws Exception {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectIsRead(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
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

    public void updateIsRead(EmailPlusModel email) {
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("emailId", email.getEmailId());
        EmailPlusModel email1 = emailPlusMapper.queryByEmailOne(email.getEmailId());
        smsService.updatequerySmsByType("25", email1.getToId(), String.valueOf(email1.getEmailId()));
        emailPlusMapper.updateIsRead(email);
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017-4-21 上午11:16:38
     * 方法介绍:   发件箱删除
     * 参数说明:   @param emailBodyModel
     *
     * @return void
     */
    public String deleteOutEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("0") || flag.trim().equals("")) {
                emailBodyPlusMapper.updateOutbox(emailId);
            } else if (flag.trim().equals("3")) {
                emailBodyPlusMapper.updateOutboxs(emailId);
            } else {
                emailBodyPlusMapper.deleteOutbox(emailId);
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
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
    public String deleteInEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("0") || flag.trim().equals("")) {
                emailBodyPlusMapper.updateInbox(emailId);
            } else {
                emailBodyPlusMapper.updateInboxs(emailId);
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
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
    @Transactional
    public String deleteRecycleEmail(Integer emailId, String flag) {
        String returnRes = "0";
        try {
            if (flag.trim().equals("3")) {
                emailBodyPlusMapper.updateRecycle(emailId);
            } else {
                emailBodyPlusMapper.deleteRecycle(emailId);
            }
        } catch (Exception e) {
            returnRes = "1";
            L.e("email deleteRecycleEmail:" + e);
        }
        return returnRes;
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
    public String queryByIdCss(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType, HttpServletRequest request) {
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String shoujianren = "收件人";
        String fajianren = "发件人";
        String chaosongren = "抄送人";
        String misongren = "密送人";
        String fasongshijian = "发送时间";
        String zhuti = "主题";
        if (locale == null) {
        } else {
            if ("en_US".equals(locale.toString())) {
                fajianren = "The sender";
                shoujianren = "The recipient";
                chaosongren = "Cc people";
                misongren = "Close send people";
                fasongshijian = "Send time";
                zhuti = "The theme";
            } else if ("zh_tw".equals(locale.toString())) {
                fajianren = "發件人";
                shoujianren = "收件人";
                chaosongren = "抄送人";
                misongren = "密送人";
                fasongshijian = "發送時間";
                zhuti = "主題";
            }
        }
        EmailBodyPlusModel emailBodyModel = this.queryById(maps, page, pageSize, useFlag, sqlType);
        StringBuffer fwReEmail = new StringBuffer();
        fwReEmail.append("&nbsp;");
        fwReEmail.append("<div style=\"margin: 5px auto; height: 0px; border-bottom-color: rgb(192, 194, 207); border-bottom-width: 1px; border-bottom-style: solid;\">&nbsp;</div>\n");
        fwReEmail.append("<div style=\"background: rgb(237, 246, 219); padding: 5px 15px; font-size: 12px; border-bottom-color: rgb(204, 204, 204); border-bottom-width: 1px; border-bottom-style: solid;\"><span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\"  style=\"float:left\">" + fajianren + "</div>：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getFromName1());
        fwReEmail.append("</span><br />");
        fwReEmail.append("<span style=\"line-height: 16px;\"><b><div class=\"emailInternationalization\" style=\"float:left\">" + shoujianren + "</div>：</b>&nbsp;");
//        fwReEmail.append("<span style=\"line-height: 16px;\"><b><fmt:message code=\"email.th.recipients\" />：</b>&nbsp;");
        fwReEmail.append(emailBodyModel.getToId2Name());
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
    @Transactional
    public ToJson<EmailBodyPlusModel> draftsSendEmail(EmailBodyPlusModel emailBody, EmailPlusModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        try {
            emailBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(new Date())));

            //获取邮件是否需要进行审核
            EmailBodyPlusModel emailBodyModel=setApproveAndSms(emailBody,users);
            if ("1".equals(emailBodyModel.getApproveFlag())){
                toJson.setFlag(0);
                toJson.setMsg("needAdmin");
                return toJson;
            }

            if ("1".equals(emailBody.getSendFlag())) {
                if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                    // 包含外部邮件操作
//                    toJson = this.returnSendWebEmail(emailBody,email);
                    toJson = this.returnUpdateDEmail(emailBody, email, sqlType, request);
                } else {
                    emailBodyPlusMapper.update(emailBody);
                    toJson = this.returnEmail(emailBody, email, "2", request);
                }
            } else {
                // 草稿箱修改
                if (!StringUtils.checkNull(emailBody.getFromWebmail())) {
                    emailBody.setWebmailFlag("0");
                    toJson = this.returnUpdateD(emailBody);
                } else {
                    emailBodyPlusMapper.update(emailBody);
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
     * @return List<EmailPlusModel>
     */
    public List<EmailPlusModel> returnEmail(List<EmailPlusModel> listEmail) {
        List<EmailPlusModel> list = new ArrayList<EmailPlusModel>();
        for (EmailPlusModel emailModel : listEmail) {
            Map<String, String> returnEmailMap = this.getEmailUserName(emailModel.getToId());
            if (!returnEmailMap.isEmpty()) {
                emailModel.setToId(returnEmailMap.keySet().iterator().next());
//                emailModel.setToName(usersService.getUserNameById(emailModel.getToId()));
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

    @Transactional
    public ToJson<EmailPlusModel> updateEmailBox(EmailPlusModel emailModel) {
        ToJson<EmailPlusModel> toJson = new ToJson<EmailPlusModel>();
        try {
            emailPlusMapper.updateEmailBox(emailModel);
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
    public ToJson<EmailBoxModel> showEmailBox(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<EmailBoxModel> toJson = new ToJson<EmailBoxModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBoxModel> list = emailBoxMapper.selectObjcet(maps);

        List<EmailBoxModel> newList =new ArrayList<EmailBoxModel>();
        for(EmailBoxModel emailBoxModel:list){
            String boxName = emailBoxModel.getBoxName();
            if(!boxName.equals("PAGESIZE_OUT")&&!boxName.equals("PAGESIZE_SENT")&&!boxName.equals("PAGESIZE_DEL")&&!boxName.equals("PAGESIZE_WEB")&&!boxName.equals("PAGESIZE_IN0")){
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
    public ToJson<EmailBodyPlusModel> selectBoxEmail(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectBoxEmail(maps);
        Integer len = listEmai.size();
        if (len > 0) {
            for (EmailBodyPlusModel emailBody : listEmai) {
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
//	@Transactional
    public ToJson<EmailBodyPlusModel> deleteBoxEmail(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
//		fromId  收件人用户
//		boxId
        boolean flags = true;
        List<EmailBodyPlusModel> list = emailBodyPlusMapper.selectIsBoxEmail(maps);
        int len = list.size();
        if (len > 0) {
            flags = false;
        } else {
//			删除其他邮件文件
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
            tojson.setMsg("error");
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
    @Transactional
    public ToJson<EmailBoxModel> updeateEmailBoxName(EmailBoxModel emailBoxModel) {
        ToJson<EmailBoxModel> toJson = new ToJson<EmailBoxModel>();
        try {
//            Integer name = emailBoxMapper.selectNameCount(emailBoxModel.getBoxName(),emailBoxModel.getUserId());
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

    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> selectInboxIsRead(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectInboxIsRead(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
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
            list.add(emailBody);
        }
        tojson.setObj(list);
        tojson.setTotleNum(pageParams.getTotal());
        return tojson;
    }


    public ToJson<EmailBodyPlusModel> selectInboxIsReadList(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.selectInboxIsRead(maps);
        for (EmailBodyPlusModel emailBody : listEmai) {
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
    public ToJson<EmailBodyPlusModel> returnUpdateD(EmailBodyPlusModel emailBodyModel) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        try {
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                emailBodyModel.setWebmailFlag("0");
                emailBodyModel.setFromWebmailId(webmails.getMailId());
                emailBodyPlusMapper.update(emailBodyModel);
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
     * 参数说明:
     *
     * @return
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> returnSendWebEmail(EmailBodyPlusModel emailBodyModel, EmailPlusModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
//        long start = System.currentTimeMillis();
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
                    emailBodyPlusMapper.save(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    String toWebId = emailBodyModel.getToWebmail().trim() + emailBodyModel.getSecretToWebmail().trim()
                            + emailBodyModel.getCopyToWebmail().trim();
                    // 判断外部邮箱是否为空
                    if (!StringUtils.checkNull(toWebId)) {
                        email.setToId("__WEBMAIL__" + emailBodyModel.getBodyId());
                        email.setBoxId(0);
                        email.setBodyId(emailBodyModel.getBodyId());
                        emailPlusMapper.save(email);
                    }
                    if (toJson.getMsg().equals("error")) {
                        toJson.setFlag(0);
                        toJson.setMsg("ok_w");
                    }
                } else {
                    emailBodyModel.setWebmailFlag("3");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyPlusMapper.save(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    if (toJson.isFlag()) {
                        toJson.setFlag(1);
                        toJson.setMsg("error_ws");
                    }
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
     * 参数说明:
     *
     * @return
     */
    @SuppressWarnings("all")
    public ToJson<EmailBodyPlusModel> returnUpdateDEmail(EmailBodyPlusModel emailBodyModel, EmailPlusModel email, String sqlType, HttpServletRequest request) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
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
                    emailBodyPlusMapper.update(emailBodyModel);
                    toJson = this.returnEmail(emailBodyModel, email, "2", request);
                    String toWebId = emailBodyModel.getToWebmail().trim() + emailBodyModel.getSecretToWebmail().trim()
                            + emailBodyModel.getCopyToWebmail().trim();
                    // 判断外部邮箱是否为空
                    if (!StringUtils.checkNull(toWebId)) {
                        email.setToId("__WEBMAIL__" + emailBodyModel.getBodyId());
                        email.setBoxId(0);
                        email.setBodyId(emailBodyModel.getBodyId());
                        emailPlusMapper.save(email);
                    }
                    if (toJson.getMsg().equals("error")) {
                        toJson.setFlag(0);
                        toJson.setMsg("ok_w");
                    }
                } else {
                    emailBodyModel.setWebmailFlag("3");
                    emailBodyModel.setFromWebmailId(webmails.getMailId());
                    emailBodyPlusMapper.update(emailBodyModel);
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
     * 参数说明:
     *
     * @return
     */
    public ToJson<EmailBodyPlusModel> returnSaveWebEmail(EmailBodyPlusModel emailBodyModel) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        try {
            Webmail webmails = webmailMapper.selectWebMail(emailBodyModel.getFromWebmail());
            if (webmails != null) {
                emailBodyModel.setWebmailFlag("0");
                emailBodyModel.setFromWebmailId(webmails.getMailId());
                emailBodyPlusMapper.save(emailBodyModel);
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
    public ToJson<EmailBodyPlusModel> returnEmail(EmailBodyPlusModel emailBody, EmailPlusModel email, String remind, HttpServletRequest request) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<EmailBodyPlusModel>();
        try {
            String toID = emailBody.getCopyToId().trim()
                    + emailBody.getToId2().trim()
                    + emailBody.getSecretToId().trim();

            String toId = emailBody.getToId2().trim();
            String copyId = emailBody.getCopyToId().trim();
            String secrteId = emailBody.getSecretToId().trim();
            Set<String> toIdSet = new HashSet<String>();

            if (!StringUtils.checkNull(toID)) {
                String[] toID2 = toID.split(",");
                for (int i = 0, len = toID2.length; i < len; i++) {
                    toIdSet.add(toID2[i]);
                }
                for (String string : toIdSet) {
                    email.setToId(string);
                    email.setBoxId(0);
                    email.setBodyId(emailBody.getBodyId());
                    emailPlusMapper.save(email);
                   /* if("3".equals(emailBody.getExamFlag())&&"3".equals(emailBody.getWordFlag())){
                        addAffairsPlus(emailBody, email.getEmailId(), email.getToId(), request);
                    }else{
                        addAffairsApprove(emailBody,request);
                    }*/
                }
                if ("0".equals(emailBody.getSmsDefault()) && !"".equals(emailBody.getSubject())) {
                    Sms2Priv sms2Priv = new Sms2Priv();
                    sms2Priv.setUserId(toID);
                    StringBuffer contextString = new StringBuffer("[邮件]"+emailBody.getSubject());
                    sms2PrivService.selSenderMobile(emailBody.getSmsDefault(), sms2Priv, contextString, request);
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
     * 参数说明:
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
        //返回拼音字符串
        StringBuffer sName = new StringBuffer();
        String[] temp = userIds.split(",");
        int length = temp.length;
//        if(length>3){
//            length = 3;
//        }
        for (int i = 0; i < length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                String userName = usersMapper.getUsernameByUserId(temp[i]);
                if (!StringUtils.checkNull(userName)) {
                    if (i < length - 1) {
                        sb.append(userName).append(",");
                        sName.append(temp[i]).append(",");
                    } else {
                        sb.append(userName);
                        sName.append(temp[i]);
                    }
                }
            }
        }
        maps.put(userIds, sb.toString());
        return maps;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/7/13 11:51
     * 方法介绍:   根据用户user_id查询外部邮箱列表
     * 参数说明:
     *
     * @return
     */
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
     * 参数说明:
     *
     * @return
     */
    public String[] returnFiles(List<Attachment> list, String sqlType) {
        String[] files = {};
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer stringBuffer = new StringBuffer();
        StringBuffer buffer=new StringBuffer();
        if(osName.toLowerCase().startsWith("win")){
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if(uploadPath.indexOf(":")==-1){
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath()+ File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if(basePath.indexOf("/xoa")!=-1){
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2=basePath.substring(0,index);
                }
                stringBuffer = stringBuffer.append(str2 + "/xoa");
            }
            stringBuffer.append(uploadPath);
            buffer=buffer.append(rb.getString("upload.win"));
        }else{
            stringBuffer=stringBuffer.append(rb.getString("upload.linux"));
            buffer=buffer.append(rb.getString("upload.linux"));
        }
        //String basePath="D:"+System.getProperty("file.separator");
        stringBuffer.append(System.getProperty("file.separator"));
        stringBuffer.append("attach");
        stringBuffer.append(System.getProperty("file.separator"));
        stringBuffer.append(sqlType);
        stringBuffer.append(System.getProperty("file.separator"));
        for (int i = 0, len = list.size(); i < len; i++) {
            StringBuffer sb = new StringBuffer(stringBuffer.toString());
            sb.append(list.get(i).getModule());
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
     * 参数说明:
     *
     * @return
     */
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

    public BaseWrappers getEmailReadDetail(Integer bodyId, String userIds) {
        BaseWrappers baseWrappers = new BaseWrappers();
        if (!StringUtils.checkNull(userIds)) {
            String[] temp = userIds.split(",");
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("userIds", temp);
            param.put("bodyId", bodyId);
            List<EmailPlusModel> datas = emailPlusMapper.selectUserReadFlag1(param);


            for(EmailPlusModel emailModel:datas){

                if(emailModel.getReadFlag().equals("1")) {
                    AppLogExample example = new AppLogExample();
                    AppLogExample.Criteria criteria = example.createCriteria();
                    criteria.andOppIdEqualTo(emailModel.getEmailId() + "");
                    criteria.andUserIdEqualTo(emailModel.getUID());
                    criteria.andModuleEqualTo("1");//module 1:邮件模块
                    AppLog appLog = new AppLog();
                    List<AppLog> list = appLogMapper.selectByExample(example);
                    if(list!=null&&list.size()>0) {
                        appLog = list.get(0);
                        if(appLog!=null && appLog.getTime()!=null){
                            emailModel.setReadTime(DateFormat.getStrDate(appLog.getTime()));
                        }
                        else{
                            emailModel.setReadTime("");
                        }
//                        System.out.printf(appLog.getTime() + "");
                    }else{
                        emailModel.setReadTime("");
                    }
                }

            }
            baseWrappers.setFlag(true);
            baseWrappers.setDatas(datas);
        } else {
            baseWrappers.setFlag(false);
            baseWrappers.setDatas(null);
            baseWrappers.setMsg("用户ID为空");
        }
        return baseWrappers;
    }

    public ToJson<EmailBodyPlusModel> selectCount(HttpServletRequest request, String sendTime, Integer toId) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<>(1, "error");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sendTime", sendTime);
        map.put("toId", toId);
        List<EmailBodyPlusModel> list = emailBodyPlusMapper.selectCount(map);
       /* List<EmailBodyPlusModel> data=new ArrayList<>();

        for(int i=0;i<12;i++){
            EmailBodyPlusModel e = new EmailBodyPlusModel();
            e.setMonths((i+1)+"");
            e.setCount(0);
            for(EmailBodyPlusModel em : list){
                if(em.getMonths().equals((i+1)+"")){
                    data.add(em);
                    break;
                }
            }
            if(data.size()!=i+1){
                data.add(e);
            }
        }*/

        try {
            if (list != null) {
                toJson.setObj(list);
                toJson.setMsg("数据获取成功");
                toJson.setFlag(0);
            }
        } catch (Exception e1) {
            e1.printStackTrace();
            toJson.setMsg(e1.getMessage());
        }
        return toJson;
    }

    public ToJson<EmailBodyPlusModel> selectListByMoths(HttpServletRequest request, String sendTime) {
        String year = request.getParameter("year");
        String userId = request.getParameter("userId");
        ToJson<EmailBodyPlusModel> toJson = new ToJson<>(1, "error");
        try {
            List<EmailBodyPlusModel> list = emailBodyPlusMapper.selectListByMoths(sendTime, year, userId);
            for (EmailBodyPlusModel em : list) {
                if (!StringUtils.checkNull(String.valueOf(em.getSendTime()))) {
                    em.setSendTimes(DateFormat.getDate(DateFormat.getDateStrTime(em.getSendTime())));
                }
                //附件处理
                List<Attachment> attachmentList = new ArrayList<Attachment>();
                if (em.getAttachmentName() != null && !"".equals(em.getAttachmentName())) {
                    attachmentList = GetAttachmentListUtil.returnAttachment(em.getAttachmentName(), em.getAttachmentId(), "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")), GetAttachmentListUtil.MODULE_EMAIL);
                }
                em.setAttachmentList(attachmentList);
            }

            if (list != null) {
                toJson.setObj(list);
                toJson.setMsg("详情列表获取成功");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    public ToJson<EmailBodyPlusModel> selectDetailById(HttpServletRequest request, Integer bodyId) {
        ToJson<EmailBodyPlusModel> toJson = new ToJson<>(1, "error");
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("bodyId", bodyId);
        try {
            EmailBodyPlusModel emailBodyModel = emailBodyPlusMapper.queryByBodyId(maps);

            //带状态的收件人
            putInfoWithFlag(emailBodyModel, TO_USER_INFO, emailBodyModel.getToId2());
            //带状态的抄送人
            putInfoWithFlag(emailBodyModel, COPY_USER_FINO, emailBodyModel.getCopyToId());
            //带状态的密送人
            putInfoWithFlag(emailBodyModel, SERC_USER_FINO, emailBodyModel.getSecretToId());


            emailBodyModel.setSendTimes(DateFormat.getDate(DateFormat.getDateStrTime(emailBodyModel.getSendTime())));
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
                attachmentList = GetAttachmentListUtil.returnAttachment(emailBodyModel.getAttachmentName(), emailBodyModel.getAttachmentId(), "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")), GetAttachmentListUtil.EMAIL_COUNT);
            }
            emailBodyModel.setAttachmentList(attachmentList);
            if (emailBodyModel != null) {
                toJson.setObject(emailBodyModel);
                toJson.setMsg("详情信息获取成功");
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

    public ToJson<EmailPlusModel> updateEmailWithdraw(Integer bodyId) {
        ToJson<EmailPlusModel> json = new ToJson<EmailPlusModel>();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("bodyId", bodyId);
            List<EmailPlusModel> emailModels = emailPlusMapper.selectByBodyId(map);
            List<String> toIds = new ArrayList<String>();
            if (emailModels != null && emailModels.size() > 0) {
                // 循环判断邮件阅读状态
                for (EmailPlusModel emailModel : emailModels) {
                    // 判断已读状态 如果是0 代表未读 可以撤回
                    if (emailModel.getReadFlag().equals("0")) {
                        toIds.add(emailModel.getToId());
                    }
                }
                // 如果收件人中存在未读的 设置该邮件为撤回状态
                if (toIds.size() > 0) {
                    map.put("userIds", toIds);
                    emailPlusMapper.updateEmailWithdraw(map);
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
    public void addAffairs(EmailBodyPlusModel emailBodyModel, final Integer emailId, final String todoId, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final String userName = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserName();
        final EmailBodyPlusModel emailBodyModelf = emailBodyModel;
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(emailBodyModelf.getFromId());
                smsBody.setContent("请查收我的邮件！主题：" + emailBodyModelf.getSubject());
                smsBody.setSendTime(emailBodyModelf.getSendTime());
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("电子邮件");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(emailBodyModelf.getAttachmentId()) && !StringUtils.checkNull(emailBodyModelf.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                smsBody.setRemindUrl("email/details?id=" + emailId);
                String title = userName + "：请查收我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                smsService.saveSms(smsBody, todoId, "1", "1", title, context, sqlType);
            }
        });

    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 创建作者:   张丽军
     * 创建日期:   2018/3/15 15:46
     * 方法介绍:   内部邮箱查询
     * 参数说明:
     *
     * @return
     */
    public ToJson<EmailBodyPlusModel> queryEmailBySubject(String trim) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> listEmai = emailBodyPlusMapper.queryEmailBySubject(trim);

        EmailBodyPlusModel emailBodyModel = new EmailBodyPlusModel();

        for (EmailBodyPlusModel emailBody : listEmai) {
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
//            list.add(emailBody);
        }

        tojson.setObj(listEmai);
        tojson.setObject(emailBodyModel);
        return tojson;
    }

    /**
     * 邮件审批设置，使用一对多进行存储
     * @param request
     * @param emailSet
     * @return
     */
    @Transactional
    public ToJson<EmailSet> addEmailSet(HttpServletRequest request, EmailSet emailSet) {
        ToJson<EmailSet> json = new ToJson<EmailSet>(1,"error");
        try {
            int count=0;
            List<String> deptIdList=new ArrayList<>();
            if(StringUtils.checkNull(emailSet.getEmailExam())){
                json.setMsg("请设置审批类型");
                return json;
            }
            SysPara sysPara=new SysPara();
            sysPara.setParaName("EMAIL_EXAM");
            sysPara.setParaValue(emailSet.getEmailExam());
            sysParaMapper.updateSysPara(sysPara);
            if("1".equals(emailSet.getEmailExam())){
                json.setFlag(0);
                json.setMsg("ok");
                return json;
            }else{
                if(StringUtils.checkNull(emailSet.getDeptId()) || StringUtils.checkNull(emailSet.getUserId())){
                    json.setFlag(0);
                    json.setMsg("ok");
                    return json;
                }
                if(!StringUtils.checkNull(emailSet.getDeptId())){
                    deptIdList=Arrays.asList(emailSet.getDeptId().split(","));//管理员
                }
                for(String deptId:deptIdList){
                    EmailSet temp=emailSetMapper.selUserByDeptId(Integer.valueOf(deptId));
                    emailSet.setDeptId(deptId);
                    if(temp==null){
                        count=emailSetMapper.insertSelective(emailSet);
                    }else{
                        String[] userIdArr=(temp.getUserId()+emailSet.getUserId()).split(",");
                        List<String> list = new ArrayList<String>();
                        for (int i=0; i<userIdArr.length; i++) {
                            if(!list.contains(userIdArr[i])) {
                                list.add(userIdArr[i]);
                            }
                        }
                        StringBuffer sb=new StringBuffer();
                        for(String userId:list){
                            sb.append(userId+",");
                        }
                        temp.setUserId(sb.toString());
                        count=emailSetMapper.updateByPrimaryKeySelective(temp);
                    }
                }
            }
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


    public ToJson<EmailSet> delEmailSetById(HttpServletRequest request,int essId) {
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


    @Transactional
    public ToJson<EmailSet> updateEmailSetById(HttpServletRequest request, EmailSet emailSet) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try{
            int count=emailSetMapper.updateByPrimaryKeySelective(emailSet);
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



    public ToJson<EmailSet> selEmailSet(HttpServletRequest request) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            List<EmailSet> list=emailSetMapper.selectEmailSet();
            SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
            for(EmailSet emailSet:list){
                if(!StringUtils.checkNull(emailSet.getUserId())){
                    String[] userIdArr=emailSet.getUserId().split(",");
                    StringBuffer sb=new StringBuffer();
                    List<Users> usersList=usersMapper.getUsersByUserIds(userIdArr);
                    for(Users user:usersList){
                        if(user!=null && !StringUtils.checkNull(user.getUserName())){
                            sb.append(user.getUserName()+",");
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
     * @param request
     * @return
     */
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request,int essId) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            EmailSet emailSet=emailSetMapper.selectByPrimaryKey(essId);
            if(emailSet!=null && !StringUtils.checkNull(emailSet.getUserId())){
                String[] userIdArr=emailSet.getUserId().split(",");
                StringBuffer sb=new StringBuffer();
                List<Users> usersList=usersMapper.getUsersByUserIds(userIdArr);
                for(Users user:usersList){
                    if(user!=null && !StringUtils.checkNull(user.getUserName())){
                        sb.append(user.getUserName()+",");
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
     * @param toId 收件人userId串
     * @return
     */
    public boolean isSentDiffDept(String toId,Users user){
        try{
            if(StringUtils.checkNull(toId)) {
                return false;
            }
            String[] userIdArray=toId.split(",");
            Map<String,Object> map=new HashMap<>();
            map.put("userIdArray",userIdArray);
            map.put("deptId",user.getDeptId());
            int count=usersMapper.isUserSameDept(map);
            if(count>0){//有外部门人员，需要进行审核
                return true;
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 查询需要进行审批的邮件(一般审核)
     * @return
     */
    public ToJson<EmailBodyPlusModel> selExamEmail(HttpServletRequest request){
        ToJson<EmailBodyPlusModel> toJson=new ToJson<>(1,"error");
        try{
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            List<EmailBodyPlusModel> resultList=new ArrayList<>();
            //获取邮件审批状态
            SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
            //查询出需要进行审批的邮件
            List<EmailBodyPlusModel> list=emailBodyPlusMapper.selExamEmail();
            List<EmailSet> emailSetList=emailSetMapper.selectEmailSet();

            for(EmailBodyPlusModel emailBodyModel:list){
                for(EmailSet emailSet:emailSetList){
                    List<String> userIdList=Arrays.asList(emailSet.getUserId().split(","));
                    if((emailBodyModel.getDeptId().intValue()==Integer.valueOf(emailSet.getDeptId()).intValue()) && userIdList.contains(user.getUserId())){
                        resultList.add(emailBodyModel);
                    }
                }
            }
            for(EmailBodyPlusModel emailBodyModel:resultList){
                if(!StringUtils.checkNull(emailBodyModel.getToId2())){
                    String[] str=emailBodyModel.getToId2().split(",");
                    List<Users> users=usersMapper.getUserByUserIds(str);
                    StringBuffer sb=new StringBuffer();
                    for(Users user1:users){
                        sb.append(user1.getUserName()+",");
                    }
                    emailBodyModel.setToName(sb.toString());
                }
            }
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(resultList);
        }catch(Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     * @return
     */
    public ToJson<EmailBodyPlusModel> selWordExamEmail(HttpServletRequest request){
        ToJson<EmailBodyPlusModel> toJson=new ToJson<>(1,"error");
        try{
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            CensorModule censorModule=censorModuleMapper.getCenModuleByCode("0101");
           /* if(censorModule!=null && !StringUtils.checkNull(censorModule.getCheckUser()) && "1".equals(censorModule.getUseFlag())){*/
            if(censorModule!=null && !StringUtils.checkNull(censorModule.getCheckUser())){
                List<String> userIdList=Arrays.asList(censorModule.getCheckUser().split(","));
                if(userIdList.contains(user.getUserId())){
                    List<EmailBodyPlusModel> resultList=emailBodyPlusMapper.selWordExamEmail();
                    for(EmailBodyPlusModel emailBodyModel:resultList){
                        if(!StringUtils.checkNull(emailBodyModel.getToId2())){
                            String[] str=emailBodyModel.getToId2().split(",");
                            List<Users> users=usersMapper.getUserByUserIds(str);
                            StringBuffer sb=new StringBuffer();
                            for(Users user1:users){
                                sb.append(user1.getUserName()+",");
                            }
                            emailBodyModel.setToName(sb.toString());
                        }
                    }
                    toJson.setObj(resultList);
                }
            }
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }



    /**
     * 审批邮件
     * @return
     */
    public ToJson<EmailBodyPlusModel> examEmail(EmailBodyPlusModel emailBodyModel,Integer flag,HttpServletRequest request){
        ToJson<EmailBodyPlusModel> toJson=new ToJson<>(1,"error");
        int count=0;
        try{
            /*int count=emailBodyPlusMapper.updateExamFlag(EmailBodyPlusModel);*/
            //一般审批
            if(flag==1){
                count=emailBodyPlusMapper.updateExamFlag(emailBodyModel);
            }
            //过滤词审批
            if(flag==2){
                Map<String,Object> map=new HashMap<>();
                map.put("bodyId",emailBodyModel.getBodyId());
                EmailBodyPlusModel temp=emailBodyPlusMapper.queryByBodyId(map);
                if("1".equals(emailBodyModel.getWordFlag())){
                    map.put("censorWords",new CensorWords());
                    List<CensorWords> list=censorWordsMapper.getCensorWords(map);//全查
                    String subject=temp.getSubject();
                    String content=temp.getContent();
                    for(CensorWords censorWords:list){
                        subject=subject.replaceAll(censorWords.getFind(),censorWords.getReplacement());
                        content=content.replaceAll(censorWords.getFind(),censorWords.getReplacement());
                    }
                    temp.setSubject(subject);
                    temp.setContent(content);
                }
                temp.setWordFlag(emailBodyModel.getWordFlag());
                count=emailBodyPlusMapper.updateWordFlag(temp);
            }




            Map<String,Object> map=new HashMap<>();
            map.put("bodyId",emailBodyModel.getBodyId());
            EmailBodyPlusModel emailBodyTemp=emailBodyPlusMapper.queryByBodyId(map);
            //修改审批事务提醒的状态
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
            smsService.setSmsRead("2","/email/mailApproval?id="+emailBodyTemp.getBodyId(),users);

            //审核通过后添加事务提醒
            if(("3".equals(emailBodyTemp.getExamFlag())||"1".equals(emailBodyTemp.getExamFlag()))&&("3".equals(emailBodyTemp.getWordFlag()) ||"1".equals(emailBodyTemp.getWordFlag()))){
                List<EmailPlusModel> list=emailPlusMapper.selectByBodyId(map);
                for(EmailPlusModel email:list){
                    addAffairs(emailBodyTemp, email.getEmailId(), email.getToId(), request);
                }
            }
            if(count>0){
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        }catch(Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    public int saveAppLog4Email(AppLog appLog) {
        return appLogMapper.insert(appLog);
    }

    /**
     * 判断邮件是否需要进行审核，需要审核的添加事务提醒
     * @return
     */
    private EmailBodyPlusModel setApproveAndSms(EmailBodyPlusModel emailBody,Users user){
        //获取邮件是否需要进行审核
        SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
        switch (sysPara.getParaValue()){
            case "1"://无需审核
                emailBody.setExamFlag("3");
                break;
            case "2"://需要进行审核
                EmailSet emailSet=emailSetMapper.selUserByDeptId(user.getDeptId());
                if(emailSet==null || StringUtils.checkNull(emailSet.getUserId())){
                    emailBody.setApproveFlag("1");//需要进行设置管理员
                }
                emailBody.setExamFlag("0");
                break;
            case "3"://跨部门审核
                String toId=emailBody.getToId2()+emailBody.getCopyToId()+emailBody.getSecretToId();
                boolean result=isSentDiffDept(toId,user);
                if(result){//需要进行跨部门审核
                    EmailSet emailSet1=emailSetMapper.selUserByDeptId(user.getDeptId());
                    if(emailSet1==null || StringUtils.checkNull(emailSet1.getUserId())){
                        emailBody.setApproveFlag("1");//需要进行设置管理员
                    }
                    emailBody.setExamFlag("0");
                }else{
                    emailBody.setExamFlag("3");
                }

                break;
        }
        //过滤词替换
        CensorModule censorModule=censorModuleMapper.getCenModuleByCode("0101");
        Map<String,Object> map=new HashMap<>();
        map.put("censorWords",new CensorWords());
        List<CensorWords> censorWordsList=censorWordsMapper.getCensorWords(map);
        //查看邮件主题、内容中是否包含过滤词
        boolean isExist=false;
        for(CensorWords temp:censorWordsList){
            if(emailBody.getSubject().contains(temp.getFind()) || emailBody.getContent().contains(temp.getFind())){
                isExist=true;
                break;
            }
        }
        if(isExist){
            if(censorModule!=null&&"1".equals(censorModule.getUseFlag())){//需要进行审核
                if(StringUtils.checkNull(censorModule.getCheckUser())){
                    emailBody.setApproveFlag("1");//需要进行设置管理员
                }else{
                    emailBody.setWordFlag("0");
                }
            }else{
                emailBody.setWordFlag("3");
            }
        }else{
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
    public void addAffairsApprove(final EmailBodyPlusModel emailBodyModel, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        final EmailBodyPlusModel emailBodyModelf = emailBodyModel;
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(emailBodyModelf.getFromId());
                smsBody.setContent("请审批我的邮件！主题：" + emailBodyModelf.getSubject());
                smsBody.setSendTime(emailBodyModelf.getSendTime());
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("电子邮件");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(emailBodyModelf.getAttachmentId()) && !StringUtils.checkNull(emailBodyModelf.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                String toUserId="";
                if("0".equals(emailBodyModel.getExamFlag())){//需要一般审批的人员
                    EmailSet emailSet=emailSetMapper.selUserByDeptId(users.getDeptId());
                    toUserId=emailSet.getUserId();
                }
                if ("0".equals(emailBodyModel.getWordFlag())){//需要进行过滤词审批的人员
                    CensorModule censorModule=censorModuleMapper.getCenModuleByCode("0101");
                    toUserId+=censorModule.getCheckUser();
                }
                toUserId=StringUtils.getRemoveStr(toUserId);
                smsBody.setRemindUrl("/email/mailApproval?id="+emailBodyModel.getBodyId());//flag未用，方便拼接
                String title = users.getUserName() + "：请审批我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
            }
        });

    }

    public ToJson<EmailBodyPlusModel> selectNewShowEmail(String flag,HttpServletRequest request,Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyPlusModel> tojson = new ToJson<EmailBodyPlusModel>();
        List<EmailBodyPlusModel> list = new ArrayList<EmailBodyPlusModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        maps.put("page", pageParams);
        if (flag.trim().equals("inbox")) {
            list = emailBodyPlusMapper.selectInbox(maps);
            for (EmailBodyPlusModel emailBody : list) {
                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
            List<EmailBodyPlusModel> outemails = emailBodyPlusMapper.listSendEmail(map2);
            List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map2);
            tojson.setInboxCount(pageParams.getTotal());
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(outemails.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());


        } else if (flag.trim().equals("drafts")) {

            list = emailBodyPlusMapper.listDrafts(maps);
            for (EmailBodyPlusModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyPlusModel> inbox = emailBodyPlusMapper.selectInbox(map2);
            List<EmailBodyPlusModel> outemails = emailBodyPlusMapper.listSendEmail(map2);
            List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map2);
            tojson.setDraftsCount(pageParams.getTotal());
            tojson.setHairboxCount(outemails.size());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());




            list = emailBodyPlusMapper.listDrafts(maps);
        } else if (flag.trim().equals("outbox")) {
            list = emailBodyPlusMapper.listSendEmail(maps);
            for (EmailBodyPlusModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyPlusModel> inbox = emailBodyPlusMapper.selectInbox(map2);
            List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
            List<EmailBodyPlusModel> wastes = emailBodyPlusMapper.listWastePaperbasket(map2);
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(pageParams.getTotal());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());
        } else if (flag.trim().equals("recycle")) {
            list = emailBodyPlusMapper.listWastePaperbasket(maps);
            for (EmailBodyPlusModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyPlusModel> inbox = emailBodyPlusMapper.selectInbox(map2);
            List<EmailBodyPlusModel> drafts = emailBodyPlusMapper.listDrafts(map2);
            List<EmailBodyPlusModel> listHairbox = emailBodyPlusMapper.listSendEmail(map2);
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(listHairbox.size());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        } else if (flag.trim().equals("noRead")) {
            list = emailBodyPlusMapper.selectIsRead(maps);
            for (EmailBodyPlusModel emailBody : list) {
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
                list.add(emailBody);
            }
            tojson.setObj(list);
            tojson.setTotleNum(pageParams.getTotal());
        } else {
            List<EmailBodyPlusModel> newArrlist =new ArrayList<EmailBodyPlusModel>();
            list= emailBodyPlusMapper.selectObjcet(maps);
            for (EmailBodyPlusModel emailBody : list) {
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
            list =newArrlist;
            tojson.setTotleNum(pageParams.getTotal());
        }
        tojson.setObj(list);
        return tojson;
    }

    /**
     * 邮件互通 添加事务提醒
     * @param emailBody
     * @param request
     */
    @Async
    public void addAffairsPlus(final EmailBodyPlusModel emailBody,final Integer emailId, String remind, HttpServletRequest request,String sql) {
        final String sqlType = sql;
        final String userName = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserName();
        final EmailBodyPlusModel emailBodyModelf = emailBody;
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa"+sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(emailBodyModelf.getFromId());
                smsBody.setContent("请查收我的邮件！主题：" + emailBodyModelf.getSubject());
                smsBody.setSendTime(emailBodyModelf.getSendTime());
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("邮件互发");
                sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                if (!StringUtils.checkNull(emailBodyModelf.getAttachmentId()) && !StringUtils.checkNull(emailBodyModelf.getAttachmentName())) {
                    smsBody.setIsAttach("1");
                }
                String toUserId="";
                if(!StringUtils.checkNull(emailBody.getToId2())){
                    toUserId=emailBody.getToId2();
                }
                if(!StringUtils.checkNull(emailBody.getCopyToId())){
                    toUserId+=emailBody.getCopyToId();
                }
                if(!StringUtils.checkNull(emailBody.getSecretToId())){
                    toUserId+=emailBody.getSecretToId();
                }
                toUserId=StringUtils.getRemoveStr(toUserId);
                smsBody.setRemindUrl("emailPlus/details?id=" + emailId);
                String title = userName + "：请查收我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                smsService.saveSms(smsBody, toUserId, "1", "1", title, context, "xoa"+sqlType);
            }
        });
    }
}
