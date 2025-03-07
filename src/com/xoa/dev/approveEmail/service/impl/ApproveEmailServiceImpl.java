package com.xoa.dev.approveEmail.service.impl;

import com.xoa.dao.censor.CensorModuleMapper;
import com.xoa.dao.censor.CensorWordsMapper;
import com.xoa.dao.common.AppLogMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.email.EmailMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.approveEmail.dao.ApproveEmailMapper;
import com.xoa.dev.approveEmail.model.EmailSet2;
import com.xoa.dev.approveEmail.service.ApproveEmailService;
import com.xoa.model.censor.CensorModule;
import com.xoa.model.censor.CensorWords;
import com.xoa.model.common.AppLog;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.email.EmailBodyModel;
import com.xoa.model.email.EmailModel;
import com.xoa.model.email.emailSet.EmailSet;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.users.Users;
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
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午10:54:20
 * 类介绍  :   邮件业务层实现类
 * 构造参数:
 */
@Service
public class ApproveEmailServiceImpl implements ApproveEmailService {

    private final Integer TO_USER_INFO = 0x11;//收件人信息
    private final Integer COPY_USER_FINO = 0x12;//抄送人信息
    private final Integer SERC_USER_FINO = 0x13;//抄送人信息


    @Resource
    private EmailBodyMapper emailBodyMapper;



    @Resource
    private EmailMapper emailMapper;

    @Resource
    private UsersService usersService;

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
    private ApproveEmailMapper approveEmailMapper;
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
//                emailModel.setToName(usersService.getUserNameById(emailModel.getToId()));
                emailModel.setToName(returnEmailMap.get(emailModel.getToId()));
            }
            list.add(emailModel);
        }
        return list;
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
                    emailMapper.save(email);
                   if("3".equals(emailBody.getExamFlag())&&"3".equals(emailBody.getWordFlag())){
                       addAffairs(emailBody, email.getEmailId(), email.getToId(), request);
                   }
                }
                /*String toIds=StringUtils.getRemoveStr(toID);*/
                if(!"3".equals(emailBody.getExamFlag())|| !"3".equals(emailBody.getWordFlag())){
                    addAffairsApprove(emailBody,request);
                }
                //短信发送(判断三段是否有权限发送短信)
                json = sms2PrivService.selectSms2("2", request);
                Sms2Priv sms2Priv = new Sms2Priv();
                sms2Priv.setUserId(toID);

                StringBuffer uId = new StringBuffer();
                if(json!=null){
                    if(json.getCode().equals("1")){
                        if ("0".equals(emailBody.getSmsDefault()) && !"".equals(emailBody.getSubject())) {

                       /*if(emailBodyModel.getContent().contains("p")){
                           //html转换成文本
                           final Document document = Jsoup.parse(emailBodyModel.getContent());
                           final Document.OutputSettings outputSettings = new Document.OutputSettings().prettyPrint(false);
                           document.outputSettings(outputSettings);
                           document.select("br").append("\\n");
                           document.select("p").prepend("\\n");
                           document.select("p").append("\\n");
                           final String newHtml = document.html().replaceAll("\\\\n", "\n");
                           final String plainText = Jsoup.clean(newHtml, "", Whitelist.none(), outputSettings);
                           final String result = StringEscapeUtils.unescapeHtml(plainText.trim());

                           String [] art = result.split("--发自");
                       }*/

                            //添加人员，通过userId查询uid
                            StringBuffer contextString  = new StringBuffer("电子邮件："+ emailBody.getSubject());
                            if (toID != null) {
                                String[] str = toID.split(",");
                                for (int k = 0; k < str.length; k++) {
                                    if (!StringUtils.checkNull(str[k])) {
                                        Users users = usersMapper.getUsersByuserId(str[k]);
                                        uId.append(users.getUid()+",");
                                    }
                                }
                                //emailBodyModel.setToId2(uId);
                            }
                            SysPara sysPara = sysParaMapper.querySysPara("MOBILE_SMS_SET");
                            if ("0".equals(sysPara.getParaValue())) {
                                sms2PrivService.smsSenders(contextString, uId.toString());
                            }/* else if (sysPara.getParaValue().equals("1")) {

                                String[] uids = uId.toString().split(",");
                                Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                                Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
                                Department department = departmentMapper.getFatherDept(user.getDeptId());
                                for (String uid : uids) {
                                    Users users = usersMapper.getUsersByUid(Integer.valueOf(uid));
                                    try {
                                        send.sms(users.getMobilNo(), department.getSmsGateAccount(), contextString.toString(), user.getUserId(), users.getUserId());
                                    } catch (Exception e) {

                                    }
                                }
                            }*/
                            //sms2PrivService.smsSenders(contextString, uId.toString());
                        }

                    }
                   /* StringBuffer contextString = new StringBuffer(emailBody.getSubject());
                    sms2PrivService.selSenderMobile(emailBody.getSmsDefault(), sms2Priv, contextString, request);*/
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
    /*    //返回拼音字符串
        StringBuffer sName = new StringBuffer();
        String[] temp = userIds.split(",");
        int length = temp.length;
        if(length>3){
           length = 3;
       }
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
        }*/
     /*  String userNameById = usersService.getUserNameById(userIds);*/
     //优化调用数据库次数
        List<Users> userByuserId = usersService.getUserByuserId(userIds);
        for(Users u:userByuserId){
            sb.append(u.getUserName()+",");
        }
        String newStr =new String();
        if(!StringUtils.checkNull(sb.toString())){
            newStr=sb.toString().substring(0,sb.toString().length()-1);
        }else{
            newStr=sb.toString();
        }
        maps.put(userIds, newStr);
        return maps;
    }

    /**
     * 给邮件添加提醒事务
     *
     * @param emailBodyModel
     */
    @Async
    public void addAffairs(EmailBodyModel emailBodyModel, final Integer emailId, final String todoId, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        final String userName = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId).getUserName();
        final EmailBodyModel emailBodyModelf = emailBodyModel;
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
                smsBody.setRemindUrl("email/emailDetail?id=" + emailId);
                String title = userName + "：请查收我的邮件！";
                String context = "主题:" + emailBodyModelf.getSubject();
                smsService.saveSms(smsBody, todoId, "1", "1", title, context, sqlType);
            }
        });

    }

    /**
     * 邮件审批设置，使用一对多进行存储
     * @param request
     * @param emailSet2
     * @return
     */
    @Override
    @Transactional
    public ToJson<EmailSet2> addEmailSet(HttpServletRequest request, EmailSet2 emailSet2) {
        ToJson<EmailSet2> json = new ToJson<EmailSet2>(1,"error");
        try {
            if(emailSet2.getExcludeUserId()==null||emailSet2.getExcludeUserId().length()<=  0){
                emailSet2.setExcludeUserId("null");
            }
                int count = approveEmailMapper.insert(emailSet2);
                json.setFlag(0);
                json.setMsg("ok");
            //}


        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }

    @Override
    public ToJson<EmailSet2> delEmailSetById(HttpServletRequest request,int essId) {
        ToJson<EmailSet2> json = new ToJson<>(1, "error");
        try {
            int count = approveEmailMapper.deleteByPrimaryKey(essId);
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
    public ToJson<EmailSet2> updateEmailSetById(HttpServletRequest request, EmailSet2 emailSet) {
        ToJson<EmailSet2> json = new ToJson<>(1, "error");
        try{
            if(emailSet.getExcludeUserId()==null||emailSet.getExcludeUserId().length()<=  0){
                emailSet.setExcludeUserId("null");
            }

                    int count = approveEmailMapper.updateByPrimaryKeySelective(emailSet);
                    json.setMsg("ok");
                    json.setFlag(0);


        } catch (Exception e) {
            json.setMsg("error");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<EmailSet2> selEmailSet(HttpServletRequest request) {
        ToJson<EmailSet2> json = new ToJson<>(1, "error");
        try {
            List<EmailSet2> list=approveEmailMapper.selectEmailSet();
            SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
            for(EmailSet2 emailSet:list){
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
                if(!StringUtils.checkNull(emailSet.getExcludeUserId())){
                    String[] userIdArr=emailSet.getExcludeUserId().split(",");
                    StringBuffer sb=new StringBuffer();
                    List<Users> usersList=usersMapper.getUsersByUserIds(userIdArr);
                    for(Users user:usersList){
                        if(user!=null && !StringUtils.checkNull(user.getUserName())){
                            sb.append(user.getUserName()+",");
                        }
                    }
                    emailSet.setExcludeUserName(sb.toString());
                }


                if(!StringUtils.checkNull(emailSet.getDeptId())){
                    String[] deptIdArr=emailSet.getDeptId().split(",");
                    StringBuffer sb=new StringBuffer();
                    List<Department> departmentsList=departmentMapper.selDeptByIds(deptIdArr);
                    Department departments=new Department();
                    for(Department department:departmentsList){
                        if(department!=null && !StringUtils.checkNull(department.getDeptName())){
                            sb.append(department.getDeptName()+",");
                        }
                    }
                    emailSet.setDeptName(sb.toString());
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
    @Override
    public ToJson<EmailSet> selEmailSetByDept(HttpServletRequest request, int essId) {
        ToJson<EmailSet> json = new ToJson<>(1, "error");
        try {
            EmailSet2 emailSet=approveEmailMapper.selectByPrimaryKey(essId);
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
                StringBuffer sb2=new StringBuffer();
                String[] excludeUserIdArr=emailSet.getExcludeUserId().split(",");
                List<Users> excludeUsersList=usersMapper.getUsersByUserIds(excludeUserIdArr);
                for(Users user:excludeUsersList){
                    if(user!=null && !StringUtils.checkNull(user.getUserName())){
                        sb2.append(user.getUserName()+",");
                    }
                }
                emailSet.setExcludeUserName(sb2.toString());
                if(!StringUtils.checkNull(emailSet.getDeptId())){
                    String[] deptIdArr=emailSet.getDeptId().split(",");
                    StringBuffer sb3=new StringBuffer();
                    List<Department> departmentsList=departmentMapper.selDeptByIds(deptIdArr);
                    Department departments=new Department();
                    for(Department department:departmentsList){
                        if(department!=null && !StringUtils.checkNull(department.getDeptName())){
                            sb3.append(department.getDeptName()+",");
                        }
                    }
                    emailSet.setDeptName(sb3.toString());
                }

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
     * 查询需要进行审批的邮件(一般审核)
     * @return
     */
    public ToJson<EmailBodyModel> selExamEmail(HttpServletRequest request){
        ToJson<EmailBodyModel> toJson=new ToJson<>(1,"error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Set<EmailBodyModel> resultList=new HashSet<>();
            List<EmailBodyModel> resultList2=new ArrayList<>();
            //获取邮件审批状态
            SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
            //查询出需要进行审批的邮件
            List<EmailBodyModel> list=emailBodyMapper.selExamEmail();
            List<EmailSet2> emailSetList=approveEmailMapper.selectEmailSet();
            for(EmailBodyModel emailBodyModel:list) {
                for (EmailSet2 emailSet : emailSetList) {
                    //List<String> userIdList = Arrays.asList(emailSet.getExcludeUserId().split(","));
                 //   if ((emailBodyModel.getDeptId().intValue() == Integer.valueOf(emailSet.getDeptId()).intValue())) {
                        List<String> deptIdList = Arrays.asList(emailSet.getDeptId().split(","));
                        List<String> userIdList = Arrays.asList(emailSet.getUserId().split(","));
                    Users deptIdByDeptName = usersMapper.getUsersByuserId(emailBodyModel.getFromId());
                    for (String s : deptIdList) {
                                if (s.equals(deptIdByDeptName.getDeptId()+"")){
                                    if (userIdList.contains(user.getUserId())){
                                        resultList.add(emailBodyModel);
                                    }
                                }
                            }
         //           }
                }
                //resultList.add(emailBodyModel);

            }
            for(EmailBodyModel emailBodyModel:resultList){
                //如果收件人不为空
                resultList2.add(emailBodyModel);
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

            Collections.sort(resultList2, new Comparator<EmailBodyModel>() {
                @Override
                public int compare(EmailBodyModel o1, EmailBodyModel o2) {
                    int flag = o1.getSendTime().compareTo(o2.getSendTime());
                    return flag;
                }
            });


            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(resultList2);
        }catch(Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     * 查询需要进行审批的邮件(过滤词审核)
     * @return
     */
    public ToJson<EmailBodyModel> selWordExamEmail(HttpServletRequest request){
        ToJson<EmailBodyModel> toJson=new ToJson<>(1,"error");
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            CensorModule censorModule=censorModuleMapper.getCenModuleByCode("0101");
           /* if(censorModule!=null && !StringUtils.checkNull(censorModule.getCheckUser()) && "1".equals(censorModule.getUseFlag())){*/
            if(censorModule!=null && !StringUtils.checkNull(censorModule.getCheckUser())){
                List<String> userIdList=Arrays.asList(censorModule.getCheckUser().split(","));
                if(userIdList.contains(user.getUserId())){
                    List<EmailBodyModel> resultList=emailBodyMapper.selWordExamEmail();
                    for(EmailBodyModel emailBodyModel:resultList){
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
    public ToJson<EmailBodyModel> examEmail(EmailBodyModel emailBodyModel,Integer flag,HttpServletRequest request){
        ToJson<EmailBodyModel> toJson=new ToJson<>(1,"error");
        int count=0;
        try{
            /*int count=emailBodyMapper.updateExamFlag(emailBodyModel);*/
            //一般审批
            if(flag==1){
                count=emailBodyMapper.updateExamFlag(emailBodyModel);
            }
            //过滤词审批
            if(flag==2){
                Map<String,Object> map=new HashMap<>();
                map.put("bodyId",emailBodyModel.getBodyId());
                EmailBodyModel temp=emailBodyMapper.queryByBodyId(map);
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
                count=emailBodyMapper.updateWordFlag(temp);
            }




            Map<String,Object> map=new HashMap<>();
            map.put("bodyId",emailBodyModel.getBodyId());
            EmailBodyModel emailBodyTemp=emailBodyMapper.queryByBodyId(map);


            //审核通过后添加事务提醒
            if(("3".equals(emailBodyTemp.getExamFlag())||"1".equals(emailBodyTemp.getExamFlag()))&&("3".equals(emailBodyTemp.getWordFlag()) ||"1".equals(emailBodyTemp.getWordFlag()))){
                List<EmailModel> list=emailMapper.selectByBodyId(map);
                for(EmailModel email:list){
                    addAffairs(emailBodyTemp, email.getEmailId(), email.getToId(), request);
                }
                //消除邮件审批提醒
                smsService.setSmsReadAll("2","/email/mailApproval?id="+emailBodyTemp.getBodyId());
            }else{
                //修改审批事务提醒的状态
                Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                smsService.setSmsRead("2","/email/mailApproval?id="+emailBodyTemp.getBodyId(),users);
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

    @Override
    public int saveAppLog4Email(AppLog appLog) {
        return appLogMapper.insert(appLog);
    }

    @Override
    public ToJson<EmailBodyModel> selectNewShowEmail(String flag,HttpServletRequest request,Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String sqlType) {
        ToJson<EmailBodyModel> tojson = new ToJson<EmailBodyModel>();
        List<EmailBodyModel> list = new ArrayList<EmailBodyModel>();
        PageParams pageParams = new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
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
                String userId=(String) maps.get("fromId");
               List<EmailModel> emailList =emailBody.getEmailList();
                for (EmailModel emailModel :emailList) {
                    if(userId.equals(emailModel.getToId()) && "1".equals(emailModel.getWithdrawFlag())){
                        emailBody.setAttachment(new ArrayList<Attachment>());
                        emailBody.setAttachmentName("");
                        emailBody.setAttachmentId("");
                        emailBody.setContent("邮件已撤回");
                    }
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
            List<EmailBodyModel> outemails = emailBodyMapper.listSendEmail(map2);
            List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map2);
            Integer noReadCount = emailBodyMapper.getNoReadCount(map2);
            tojson.setNoReadCount(noReadCount);
            tojson.setInboxCount(pageParams.getTotal());
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(outemails.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());


        } else if (flag.trim().equals("drafts")) {

            list = emailBodyMapper.listDrafts(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyModel> inbox = emailBodyMapper.selectInbox(map2);
            List<EmailBodyModel> outemails = emailBodyMapper.listSendEmail(map2);
            List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map2);
            Integer noReadCount = emailBodyMapper.getNoReadCount(map2);
            tojson.setNoReadCount(noReadCount);
            tojson.setDraftsCount(pageParams.getTotal());
            tojson.setHairboxCount(outemails.size());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());




            list = emailBodyMapper.listDrafts(maps);
        } else if (flag.trim().equals("outbox")) {
            list = emailBodyMapper.listSendEmail(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
                if(!StringUtils.checkNull(emailBody.getToId2())){
                    List<Users> usersByBynamesOrder = usersMapper.getUsersByUserIdsOrder(emailBody.getToId2().split(","));
                    StringBuilder sb = new StringBuilder();
                    for (int i= 0,length=usersByBynamesOrder.size();i<length;i++){
                        sb.append(usersByBynamesOrder.get(i).getUserName()).append(",");
                    }
                    emailBody.setToName(sb.toString());
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyModel> inbox = emailBodyMapper.selectInbox(map2);
            List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
            List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map2);
            Integer noReadCount = emailBodyMapper.getNoReadCount(map2);
            tojson.setNoReadCount(noReadCount);
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(pageParams.getTotal());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());
        } else if (flag.trim().equals("recycle")) {
            list = emailBodyMapper.listWastePaperbasket(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashedMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyModel> inbox = emailBodyMapper.selectInbox(map2);
            List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
            List<EmailBodyModel> listHairbox = emailBodyMapper.listSendEmail(map2);
            Integer noReadCount = emailBodyMapper.getNoReadCount(map2);
            tojson.setNoReadCount(noReadCount);
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(listHairbox.size());
            tojson.setInboxCount(inbox.size());
            tojson.setWasteCount(pageParams.getTotal());
            tojson.setTotleNum(pageParams.getTotal());
        } else if (flag.trim().equals("noRead")) {
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
			
        }else if("inboxNoRead".equals(flag.trim())){
            maps.put("readFlag","0");
            list = emailBodyMapper.selectInboxNoRead(maps);
            for (EmailBodyModel emailBody : list) {

                if (!StringUtils.checkNull(emailBody.getAttachmentName()) && !StringUtils.checkNull(emailBody.getAttachmentId())) {
                    emailBody.setAttachment(GetAttachmentListUtil.returnAttachment(emailBody.getAttachmentName(), emailBody.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_EMAIL));
                } else {
                    emailBody.setAttachmentName("");
                    emailBody.setAttachmentId("");
                }
            }

            Map<String,Object> map2 =new HashMap();
            map2.put("fromId", maps.get("fromId"));
            List<EmailBodyModel> drafts = emailBodyMapper.listDrafts(map2);
            List<EmailBodyModel> outemails = emailBodyMapper.listSendEmail(map2);
            List<EmailBodyModel> wastes = emailBodyMapper.listWastePaperbasket(map2);
            List<EmailBodyModel> inbox = emailBodyMapper.selectInbox(map2);
            tojson.setInboxCount(inbox.size());
            tojson.setNoReadCount(pageParams.getTotal());
            tojson.setDraftsCount(drafts.size());
            tojson.setHairboxCount(outemails.size());
            tojson.setWasteCount(wastes.size());
            tojson.setTotleNum(pageParams.getTotal());
        } else {
            List<EmailBodyModel> newArrlist =new ArrayList<EmailBodyModel>();
           list= emailBodyMapper.selectObjcet(maps);
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
            list =newArrlist;
            tojson.setTotleNum(pageParams.getTotal());
        }
        tojson.setObj(list);
        return tojson;
    }

    /**
     * 判断邮件是否需要进行审核，需要审核的添加事务提醒
     * @return
     */
    public EmailBodyModel setApproveAndSms(EmailBodyModel emailBody,Users user){
        List<EmailBodyModel> resultList=new ArrayList<>();
        //获取邮件审批状态
        //查询出需要进行审批的邮件
        //List<EmailBodyModel> list=emailBodyMapper.selExamEmail();
        List<EmailSet2> emailSetList=approveEmailMapper.selectEmailSet();

        List<String> toId2 = Arrays.asList(emailBody.getToId2().split(","));
        for(EmailSet2 emailSet:emailSetList){
                List<String> userIdList=Arrays.asList(emailSet.getExcludeUserId().split(","));
                List<String> deptIdList = Arrays.asList(emailSet.getDeptId().split(","));

                //if((emailBodyModel.getDeptId().intValue()==Integer.valueOf(emailSet.getDeptId()).intValue()) && userIdList.contains(user.getUserId())){
                if (!("null").equals(emailSet.getExcludeUserId())){
                    if(userIdList.contains(user.getUserId())){
                        emailBody.setExamFlag("3");
                    }else{
                        for (String s:deptIdList){
                            if (s.equals(user.getDeptId()+"")&& Integer.parseInt(emailSet.getSendAmount())<toId2.size()) {
                                emailBody.setExamFlag("0");
                            }
                        }
                    }
                }else {
                    for (String s:deptIdList){
                        if (s.equals(user.getDeptId()+"")&& Integer.parseInt(emailSet.getSendAmount())<toId2.size()) {
                            emailBody.setExamFlag("0");
                        }
                    }
                }
                }



       if(emailBody.getExamFlag()==null) {
            emailBody.setExamFlag("3");
        }


        //获取邮件是否需要进行审核
        /*SysPara sysPara=sysParaMapper.querySysPara("EMAIL_EXAM");
        switch (sysPara.getParaValue()){
            case "1"://无需审核
                emailBody.setExamFlag("3");
                break;
            case "2"://需要进行审核
                EmailSet2 emailSet=emailSetMapper.selUserByDeptId(user.getDeptId());
                if(emailSet==null || StringUtils.checkNull(emailSet.getUserId())){
                   emailBody.setApproveFlag("1");//需要进行设置管理员
                }
                emailBody.setExamFlag("0");
                break;
            case "3"://跨部门审核
                String toId=emailBody.getToId2()+emailBody.getCopyToId()+emailBody.getSecretToId();
                boolean result=isSentDiffDept(toId,user);
                if(result){//需要进行跨部门审核
                    EmailSet2 emailSet1=emailSetMapper.selUserByDeptId(user.getDeptId());
                    if(emailSet1==null || StringUtils.checkNull(emailSet1.getUserId())){
                        emailBody.setApproveFlag("1");//需要进行设置管理员
                    }
                    emailBody.setExamFlag("0");
                }else{
                    emailBody.setExamFlag("3");
                }

                break;
        }*/
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
    public void addAffairsApprove(final EmailBodyModel emailBodyModel, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        final Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        final EmailBodyModel emailBodyModelf = emailBodyModel;
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
                if("0".equals(emailBodyModel.getExamFlag())) {//需要一般审批的人员
                    List<EmailSet2> emailSet2s = approveEmailMapper.selectEmailSet();
                    StringBuilder sb = new StringBuilder();
                    for (EmailSet2 emailSet2 : emailSet2s) {
                        List<String> deptIdList = Arrays.asList(emailSet2.getDeptId().split(","));
                        for (String s : deptIdList) {
                            if (s.equals(users.getDeptId()+"")) {
                                    if (sb.length() > 0) {//该步即不会第一位有逗号，也防止最后一位拼接逗号！
                                        sb.append(",");
                                        sb.append(emailSet2.getUserId());
                                    }else {
                                        sb.append(emailSet2.getUserId());
                                    }
                            }
                        }
                    }
                    toUserId=sb.toString();
                    toUserId=StringUtils.getRemoveStr(toUserId);
                    smsBody.setRemindUrl("/email/mailApproval?id="+emailBodyModel.getBodyId());//flag未用，方便拼接
                    String title = users.getUserName() + "：请审批我的邮件！";
                    String context = "主题:" + emailBodyModelf.getSubject();
                    smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
                }
                if ("0".equals(emailBodyModel.getWordFlag())){//需要进行过滤词审批的人员
                    CensorModule censorModule=censorModuleMapper.getCenModuleByCode("0101");
                    toUserId+=censorModule.getCheckUser();
                    toUserId=StringUtils.getRemoveStr(toUserId);
                    smsBody.setRemindUrl("/email/mailApproval?id="+emailBodyModel.getBodyId());//flag未用，方便拼接
                    String title = users.getUserName() + "：请审批我的邮件！";
                    String context = "主题:" + emailBodyModelf.getSubject();
                    smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
                }

            }
        });

    }


}
