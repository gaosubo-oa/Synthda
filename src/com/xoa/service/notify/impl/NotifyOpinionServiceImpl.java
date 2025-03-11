package com.xoa.service.notify.impl;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.notify.NotifyOpinionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.notify.Notify;
import com.xoa.model.notify.NotifyOpinionWithBLOBs;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.notify.NotifyOpinionService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanMap;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.util.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Service
public class NotifyOpinionServiceImpl implements NotifyOpinionService {

    @Resource
    private SysParaMapper sysParaMapper;

    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private UsersService usersService;

    @Resource
    private NotifyOpinionMapper notifyOpinionMapper;

    @Resource
    private NotifyMapper notifyMapper;

    @Resource
    private SmsService smsService;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private UsersMapper usersMapper;
    /**
     * 新增公文反馈
     */
    @Override
    public ToJson addOpinion(NotifyOpinionWithBLOBs notifyOpinion) {
        ToJson toJson = new ToJson(1,"err");

        //重名附件限制，限制提交时不允许上传重名的附件，否则会导致批量下载时无法下载
        if(!StringUtils.checkNull(notifyOpinion.getAttachmentName())){
            String[] attachmentNames = notifyOpinion.getAttachmentName().split("\\*");
            Set<String> attach = new HashSet<>();
            for (String attachmentName : attachmentNames) {
                attach.add(attachmentName);
            }
            if(attach.size() != attachmentNames.length){
                toJson.setMsg(I18nUtils.getMessage("notice.th.duplicateAttachmentNames"));
                return toJson;
            }
        }

        notifyOpinion.setState("0");
        notifyOpinion.setInuputTime(new Date());
        Notify notify = notifyMapper.getNotifyByNotifyId(notifyOpinion.getNotyId());
        notify.setOpinUsers(notify.getOpinUsers()+notifyOpinion.getUserId()+",");
        int i = 0;
        if(notifyMapper.updateNotify(notify)>0){
            //根据公告id和userId查询当前用户是否已经提交了此公告的反馈，已经提交过的更新
            NotifyOpinionWithBLOBs notifyOpinionWithBLOBs = notifyOpinionMapper.selectByNotyId(notifyOpinion.getNotyId(), notifyOpinion.getUserId());
            if(!Objects.isNull(notifyOpinionWithBLOBs) && !Objects.isNull(notifyOpinionWithBLOBs.getOpId())){
                notifyOpinion.setOpId(notifyOpinionWithBLOBs.getOpId());
                i = notifyOpinionMapper.updateByPrimaryKeySelective(notifyOpinion);
            }else {
                i = notifyOpinionMapper.insertSelective(notifyOpinion);
            }
        }
        if(i>0){
            toJson.setFlag(0);
            toJson.setMsg("true");
        }
        return toJson;
    }

    /**
     * 查找
     * @param notiId
     * @param userId
     * @return
     */
    @Override
    public NotifyOpinionWithBLOBs selectByNotiId(int notiId ,String userId,String sqlType) {
        NotifyOpinionWithBLOBs notifyOpinionWithBLOBs = notifyOpinionMapper.selectByNotyId(notiId , userId);
        if(notifyOpinionWithBLOBs != null){
            notifyOpinionWithBLOBs.setAttachmentList(GetAttachmentListUtil.returnAttachment(notifyOpinionWithBLOBs.getAttachmentName(), notifyOpinionWithBLOBs.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_NOTIFY));
        }
        return notifyOpinionWithBLOBs;
    }

    /**
     * 修改
     * @param notifyOpinion
     * @return
     */
    @Override
    public int updateOpinion(NotifyOpinionWithBLOBs notifyOpinion) {
        if("1".equals(notifyOpinion.getState())){
            notifyOpinion.setUpdateTime(new Date());
            notifyOpinion.setState("2");
            Notify notify = notifyMapper.getNotifyByNotifyId(notifyOpinion.getNotyId());
            notify.setOpinUsers(notify.getOpinUsers()+notifyOpinion.getUserId()+",");
            if(notifyMapper.updateNotify(notify)>0){
                notifyOpinion.getAttachmentId();
                notifyOpinion.getAttachmentName();
                return notifyOpinionMapper.updateByPrimaryKeySelective(notifyOpinion);
            }else{
                return 0;
            }
        }else {
            return 0;
        }
    }

    /**
     * 退回
     * @return
     */
    @Override
    public int returnOpinion(HttpServletRequest request,int notifyId ,String userId,String returnComments) {
        String [] strings = userId.split(",");
        List<NotifyOpinionWithBLOBs> notifyOpinionWithBLOBsList = notifyOpinionMapper.selectByNotyIds(notifyId , strings);
        Notify notify = notifyMapper.getNotifyByNotifyId(notifyId);
        String toIds = "";
        for(NotifyOpinionWithBLOBs notifyOpinionWithBLOBs: notifyOpinionWithBLOBsList){
            if("0".equals(notifyOpinionWithBLOBs.getState()) || "2".equals(notifyOpinionWithBLOBs.getState())){
                notifyOpinionWithBLOBs.setState("1");
                notifyOpinionWithBLOBs.setReturnComments(returnComments);
                if(notifyOpinionMapper.updateByPrimaryKeySelective(notifyOpinionWithBLOBs)>= 1){
                    toIds = toIds + notifyOpinionWithBLOBs.getUserId() + ",";
                    notify.setOpinUsers(notify.getOpinUsers().replace(notifyOpinionWithBLOBs.getUserId()+",",""));
                }
            }
        }

        if(!StringUtils.checkNull(toIds)) {
            //添加事务提醒
            String finalToIds = toIds;
            threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    String tuisong=request.getParameter("tuisong");
                    String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    ContextHolder.setConsumerType("xoa" + sqlType);
                    String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(notify.getFromId());
                    SysCode sysCode = new SysCode();
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName("公告通知");
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName("Notice");
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName("公告通知");
                    }
                    sysCode.setParentNo("SMS_REMIND");
                    if (!StringUtils.checkNull(notify.getAttachmentId()) && !StringUtils.checkNull(notify.getAttachmentName())) {
                        smsBody.setIsAttach("1");
                    }
                    if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                        smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                    }
                    smsBody.setEditFlag("1");
                    smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
                    String title = "";
                    smsBody.setRemindUrl("/notice/detailOpinion?notifyId=" + notify.getNotifyId());
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent("您的公告回执情况被退回，请重新填写公告回执情况！标题：" + notify.getSubject());
                        title = "您的公告回执被退回";
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent("Your announcement receipt status has been returned. Please fill in the announcement receipt status again! Title：" + notify.getSubject());
                        title = "Your announcement receipt has been returned";
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent("您的公告回執情況被退回，請重新填寫公告回執情況！標題：" + notify.getSubject());
                        title = "您的公告回執被退回";
                    }

                    String typeName = "";
                    if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                        String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                        if (!StringUtils.checkNull(name11)) {
                            typeName = name11;
                        }
                    }
                    String context = "";
                    if (typeName.equals("")) {
                        context = notify.getSubject();
                    } else {
                        context = typeName + ":" + notify.getSubject();
                    }
                    smsService.saveSms(smsBody, finalToIds, "1", tuisong, title, context, sqlType);
                }
            });
        }

        return notifyMapper.updateNotify(notify);
    }

    /**
     * 查阅信息
     * @param notyId
     * @return
     */
    @Override
    public List<NotifyOpinionWithBLOBs> selectByNotiIdList(HttpServletRequest request ,int notyId) {

        String module= "notify";
        String company = "xoa"+(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        List<NotifyOpinionWithBLOBs> list = notifyOpinionMapper.selectByNotyIdList(notyId);

        Notify notify = notifyMapper.getNotifyByNotifyId(notyId);
        /**
         * 重写Set去重规则
         */
        Comparator<Users> use = new Comparator <Users> (){
            @Override
            public int compare(Users o1, Users o2) {
                return o1.getUid().compareTo(o2.getUid());
            }
        };
        /**
         * 发布人员
         */
        String[] userIdList=notify.getUserId().split(",");
        Set<Users> userArray=new TreeSet<>(use);

        for(String userId:userIdList){
            if(!StringUtils.checkNull(userId)){
                userArray.add(usersMapper.SimplefindUsersByuserId(userId));
            }}

        /**
         * 部门人员
         */
        List<Users> deptList=new ArrayList();
        if(!StringUtils.checkNull(notify.getToId())){
            if("ALL_DEPT".trim().equals(notify.getToId())){
                List<Department>  deptListArr=departmentMapper.getAllDepartment();
                StringBuilder stringBuilder=new StringBuilder();
                for(Department department:deptListArr){
                    stringBuilder.append(department.getDeptId());
                    stringBuilder.append(",");
                }
                deptList=usersService.getUserByDeptIds(stringBuilder.toString(),1);
            }else {
                deptList=usersService.getUserByDeptIds(notify.getToId(),5);
            }
        }
        //角色人员
        List<Users> privList=new ArrayList();
        if(!StringUtils.checkNull(notify.getPrivId())){
            privList=usersService.getUserByDeptIds(notify.getPrivId(),6);
        }
        //已填报人员
        List<Users> opinUserArray=new ArrayList();

        for(NotifyOpinionWithBLOBs notifyOpinionWithBLOBs:list){
            if(notifyOpinionWithBLOBs != null){
                Map map = new LinkedHashMap();
                Map map2 = new LinkedHashMap();

                BeanMap beanMap = BeanMap.create(notifyOpinionWithBLOBs);
                for (Object key : beanMap.keySet()) {
                    map.put(key.toString(), beanMap.get(key));
                }

                String[] strings = notify.getOpinionFields().split("-");
                for(int i = 0 ;i<10 ;i++){
                    if( i <strings.length){
                        strings[i] = "".equals(strings[i]) ? "无标题":strings[i];
                        map2.put(strings[i] , map.get("field"+(i+1))!=null ? map.get("field"+(i+1)) : "" );

                        map.put("field"+(i+1),map.get("field"+(i+1))!=null ? map.get("field"+(i+1)) : "");
                        map.put("field"+(i+1),(strings[i]+":"+map.get("field"+(i+1))));
                    }else if(map.get("field"+(i+1))!=null){
                        map.put("field"+(i+1), "");
                    }
                }

                map.put("mapTo2",map2);

                BeanMap beanRrstMap = BeanMap.create(notifyOpinionWithBLOBs);
                beanRrstMap.putAll(map);
                opinUserArray.add(usersMapper.getByUserId(notifyOpinionWithBLOBs.getUserId()));
                notifyOpinionWithBLOBs.setAttachmentList(GetAttachmentListUtil.returnAttachment(notifyOpinionWithBLOBs.getAttachmentName(),notifyOpinionWithBLOBs.getAttachmentId(),company,module));
                notifyOpinionWithBLOBs.setFromName(usersMapper.getByUserId(notify.getFromId()).getUserName());
                notifyOpinionWithBLOBs.setEndTime(notify.getSendTime());

                if(notifyOpinionWithBLOBs.getState()!=null ){
                    switch (notifyOpinionWithBLOBs.getState()){
                        case "0":
                            notifyOpinionWithBLOBs.setStateStr(I18nUtils.getMessage("notice.th.alreadyFilledIn"));
                            break;
                        case "1":
                            notifyOpinionWithBLOBs.setStateStr(I18nUtils.getMessage("document.th.Returned"));
                            break;
                        case "2":
                            notifyOpinionWithBLOBs.setStateStr(I18nUtils.getMessage("notice.th.alreadyFilledOutAgain"));
                            break;
                    }
                }

                //时间
                if (notifyOpinionWithBLOBs.getEndTime() != null ){
                    notifyOpinionWithBLOBs.setEndTimeStr(DateFormat.getStrDate(notifyOpinionWithBLOBs.getEndTime()));
                }
                if (notifyOpinionWithBLOBs.getInuputTime() != null ){
                    notifyOpinionWithBLOBs.setInputTimeStr(DateFormat.getStrDate(notifyOpinionWithBLOBs.getInuputTime()));
                }
                if (notifyOpinionWithBLOBs.getUpdateTime() != null ){
                    notifyOpinionWithBLOBs.setUpdateTimeStr(DateFormat.getStrDate(notifyOpinionWithBLOBs.getUpdateTime()));

                }
            }
        }
        userArray.addAll(deptList);
        userArray.addAll(privList);
        if(userArray.size()==1){
            userArray.clear();
        }else{
            userArray.removeAll(opinUserArray);
        }
        this.removeQuit(userArray);//移除离职部门的人员
        String userName = usersMapper.getByUserId(notify.getFromId()).getUserName();
        for(Users user :userArray){
            NotifyOpinionWithBLOBs notifyOpinionWithBLOBs = new NotifyOpinionWithBLOBs();
            notifyOpinionWithBLOBs.setUserName(user.getUserName());
            notifyOpinionWithBLOBs.setDeptName(user.getDeptName());
            notifyOpinionWithBLOBs.setUserId(user.getUserId());
            notifyOpinionWithBLOBs.setStateStr(I18nUtils.getMessage("notice.th.notFilledIn"));
            notifyOpinionWithBLOBs.setFromName(userName);
            notifyOpinionWithBLOBs.setEndTime(notify.getSendTime());
            notifyOpinionWithBLOBs.setEndTimeStr( notify.getSendTime() != null ?  DateFormat.getStrDate(notify.getSendTime()) : "");
            list.add(notifyOpinionWithBLOBs);
        }
        return list;
    }

    private void removeQuit(Set<Users> userArray) {
        Iterator<Users> its = userArray.iterator();
        while (its.hasNext()){
            Users list = its.next();
            if (list.getDeptId().equals(0)){
                its.remove();
            }
        }
    }

    @Override
    public ToJson urgeOpin(HttpServletRequest request,int notifyId ,String userIds) {
        ToJson toJson = new ToJson(1,"err");
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        final String tuisong=request.getParameter("tuisong");
        final Notify notify = notifyMapper.getNotifyByNotifyId(notifyId);
        final StringBuilder usersBuilder = new StringBuilder() ;

        //已填报人员
        String[] opinUserIdList = notify.getOpinUsers().split(",");
        List<Users> opinUserArray = new ArrayList();
        for (String userId : opinUserIdList) {
            if (!StringUtils.checkNull(userId)) {
                opinUserArray.add(usersMapper.getByUserId(userId));
            }
        }

        /**
         * 重写Set去重规则
         */
        Comparator<Users> use = new Comparator<Users>() {
            @Override
            public int compare(Users o1, Users o2) {
                return o1.getUid().compareTo(o2.getUid());
            }
        };
        Set<Users> userArray = new TreeSet<>(use);
        if(userIds!= null && userIds.split(",").length>=1){
            String [] strings = userIds.split(",");
            userArray.addAll(usersMapper.getUsersByUserIds(strings));
        }else {

            /**
             * 发布人员
             */
            String[] userIdList = notify.getUserId().split(",");

            for (String userId : userIdList) {
                if (!StringUtils.checkNull(userId)) {
                    userArray.add(usersMapper.getByUserId(userId));
                }
            }

            /**
             * 部门人员
             */
            List<Users> deptList = new ArrayList();
            if (!StringUtils.checkNull(notify.getToId())) {
                if ("ALL_DEPT".trim().equals(notify.getToId())) {
                    List<Department> deptListArr = departmentMapper.getAllDepartment();
                    StringBuilder stringBuilder = new StringBuilder();
                    for (Department department : deptListArr) {
                        stringBuilder.append(department.getDeptId());
                        stringBuilder.append(",");
                    }
                    deptList = usersService.getUserByDeptIds(stringBuilder.toString(), 1);
                } else {
                    deptList = usersService.getUserByDeptIds(notify.getToId(), 5);
                }
            }
            //角色人员
            List<Users> privList = new ArrayList();
            if (!StringUtils.checkNull(notify.getPrivId())) {
                privList = usersService.getUserByDeptIds(notify.getPrivId(), 6);
            }
            userArray.addAll(deptList);
            userArray.addAll(privList);
        }
        if(userArray.size()<=1){
            userArray.clear();
        }else{
            userArray.removeAll(opinUserArray);
        }
        for (Users users : userArray) {
            usersBuilder.append(users.getUserId()).append(",");
        }

        toJson.setObject(userArray);
        toJson.setFlag(0);
        toJson.setMsg("true");
        //选择人员
        threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa"+sqlType);
                SmsBody smsBody=new SmsBody();
                smsBody.setFromId(notify.getFromId());
                Integer sendTime=0;
                if(notify.getSendTime()!=null){
                    try {
                        sendTime= DateFormatUtils.getNowDateTime(DateFormatUtils.formatDate(notify.getSendTime()));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
                smsBody.setSendTime(sendTime);
                SysCode sysCode=new SysCode();
                if (locale.equals("zh_CN")) {
                    sysCode.setCodeName("公告反馈通知");
                } else if (locale.equals("en_US")) {
                    sysCode.setCodeName("Announcement Feedback Notice");
                } else if (locale.equals("zh_TW")) {
                    sysCode.setCodeName("公告反饋通知");
                }
                sysCode.setParentNo("SMS_REMIND");
                if(!StringUtils.checkNull(notify.getAttachmentId())&&!StringUtils.checkNull(notify.getAttachmentName())){
                    smsBody.setIsAttach("1");
                }
                if(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode)!=null){
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                boolean bol = false;
                SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
                if(myproject != null && !StringUtils.checkNull(myproject.getParaValue())
                        && "dazu".equals(myproject.getParaValue())){
                    bol=true;
                }
                String title = "";
                smsBody.setRemindUrl("/notice/detailOpin?notifyId=" + notify.getNotifyId());
                if (locale.equals("zh_CN")) {
                    smsBody.setContent("请填写公告反馈内容！标题：" + notify.getSubject());
                    title = bol ? notify.getSubject() : "您有新的公告通知";
                } else if (locale.equals("en_US")) {
                    smsBody.setContent("Please fill in the content of the announcement feedback! Title：" + notify.getSubject());
                    title = bol ? notify.getSubject() : "You have a new announcement";
                } else if (locale.equals("zh_TW")) {
                    smsBody.setContent("請填寫公告反饋內容！標題：" + notify.getSubject());
                    title = bol ? notify.getSubject() : "您有新的公告通知";
                }

                String typeName="";
                if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                    String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                    if (!StringUtils.checkNull(name11)) {
                        typeName=name11;
                    }
                }
                smsBody.setEditFlag("1");
                String context ="";
                if(typeName.equals("")){
                    context=notify.getSubject();
                }else {
                    context=typeName+":"+notify.getSubject();
                }
                smsService.saveSms(smsBody,usersBuilder.toString(),"1",tuisong,title,context,sqlType);
            }
        });
        return toJson;
    }

    /**
     * 公告反馈导出
     * @param request
     * @param response
     * @param notifyId
     * @return
     */
    @Override
    public ToJson outputNotifyOpins(HttpServletRequest request, HttpServletResponse response, int notifyId) {
        String locale = (String) request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        I18nUtils.setLocale(locale);
        try {
//                查询公告
            Notify notify = notifyMapper.getNotifyByNotifyId(notifyId);
//                反馈标题
            String [] strings = notify.getOpinionFields().split("-");
//                反馈内容
            List<NotifyOpinionWithBLOBs>  notifyOpinionWithBLOBsList =  this.selectByNotiIdList(request,notifyId);
            for(NotifyOpinionWithBLOBs notifyOpinionWithBLOBs: notifyOpinionWithBLOBsList){
                if(notifyOpinionWithBLOBs.getState()!=null ){
                    if(notifyOpinionWithBLOBs.getUpdateTime()!=null){
                        notifyOpinionWithBLOBs.setUpdateTimeStr(DateFormat.getStrDate(notifyOpinionWithBLOBs.getUpdateTime()));
                    }
                    notifyOpinionWithBLOBs.setInputTimeStr(DateFormat.getStrDate(notifyOpinionWithBLOBs.getInuputTime()));

                    Map map = new HashMap();
                    BeanMap beanMap = BeanMap.create(notifyOpinionWithBLOBs);
                    for (Object key : beanMap.keySet()) {
                        map.put(key.toString(), beanMap.get(key));
                    }
                    for(int i = 0 ;i<10 ;i++){
                        if( i <strings.length){
                            strings[i] = "".equals(strings[i]) ? "无标题":strings[i];
                            map.put("field"+(i+1),map.get("field"+(i+1))!=null ? map.get("field"+(i+1)) : "");
                            if(map.get("field"+(i+1)).toString().split(strings[i]+":") != null &&
                                    map.get("field"+(i+1)).toString().split(strings[i]+":").length >= 2){
                                String newField = map.get("field"+(i+1)).toString().split(strings[i]+":")[1];
                                map.put("field"+(i+1),newField);
                            }else{
                                map.put("field"+(i+1),"");
                            }
                        }else if(map.get("field"+(i+1))!=null){
                            map.put("field"+(i+1), "");
                        }
                    }
                    BeanMap beanRrstMap = BeanMap.create(notifyOpinionWithBLOBs);
                    beanRrstMap.putAll(map);
                }
                notifyOpinionWithBLOBs.setEndTimeStr(DateFormat.getStrDate(notify.getSendTime()));

            }

            String[] secondTitlesone = {I18nUtils.getMessage("notice.th.state"), I18nUtils.getMessage("notice.th.publisher"),
                    I18nUtils.getMessage("notice.th.taskReleaseTime"), I18nUtils.getMessage("notice.th.filler"), I18nUtils.getMessage("notice.th.fillingDepartment")};
            String[] secondTitlestwo = {I18nUtils.getMessage("notice.th.fillingTime"), I18nUtils.getMessage("notice.th.modificationTime"), I18nUtils.getMessage("workflow.th.AttachmentName")};
            String[] secondTitlesEnd= new String[secondTitlesone.length+secondTitlestwo.length+strings.length];

            System.arraycopy(secondTitlesone, 0, secondTitlesEnd, 0, secondTitlesone.length);
            System.arraycopy(strings, 0, secondTitlesEnd, secondTitlesone.length, strings.length);
            System.arraycopy(secondTitlestwo, 0, secondTitlesEnd, secondTitlesone.length+strings.length, secondTitlestwo.length);

            String[] beanPropertyone = {"stateStr","fromName","endTimeStr", "userName", "deptName"};
            String[] beanPropertytow = {"inputTimeStr", "updateTimeStr", "attachmentName"};
            String[] beanPropertyend = new String[secondTitlesEnd.length];
            System.arraycopy(beanPropertyone, 0, beanPropertyend, 0, beanPropertyone.length);
            for(int i= 0 ;i<strings.length;i++){
                beanPropertyend[i+beanPropertyone.length] = "field"+(i+1);
            }
            System.arraycopy(beanPropertytow, 0, beanPropertyend, beanPropertyone.length+strings.length, beanPropertytow.length);

            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead(I18nUtils.getMessage("notice.th.exportOfAnnouncementReceiptInformation"), (secondTitlesEnd.length));

            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitlesEnd);

            HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, notifyOpinionWithBLOBsList, beanPropertyend);
            ServletOutputStream out = response.getOutputStream();

            String filename = I18nUtils.getMessage("notice.th.exportOfAnnouncementReceiptInformation") + ".xls";
            filename = FileUtils.encodeDownloadFilename(filename,
                    request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition",
                    "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 批量下载附件
     * @param request
     * @param response
     * @param notifyId
     * @return
     */
    @Override
    public ToJson downLoadZipAttachment(HttpServletRequest request, HttpServletResponse response, int notifyId)  {
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sbf = new StringBuffer();
        if(osName.toLowerCase().startsWith("win")){
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
                sbf = sbf.append(str2 +"/xoa");
            }
            sbf.append(uploadPath);
        }else{
            sbf=sbf.append(rb.getString("upload.linux"));
        }
        String module= "notify";
        String company = "xoa"+(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        try (ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream());){
            Notify notify = notifyMapper.selectById(notifyId);
            if (notify != null){
                if (!StringUtils.checkNull(notify.getFromId())){
                    Users users = usersMapper.getUsersByuserId(notify.getFromId());
                    if (users != null){
                        notify.setFromDeptStr(users.getUserName());
                    }
                }
            }
            String fromDeptStr = URLEncoder.encode(notify.getFromDeptStr(), "UTF-8");
            String subject = URLEncoder.encode(notify.getSubject(), "UTF-8");
            String zipNameOut = fromDeptStr + subject + ".zip";
            response.setCharacterEncoding("UTF-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", zipNameOut));
            List<NotifyOpinionWithBLOBs> list = notifyOpinionMapper.selectByNotyIdList(notifyId);
            for(NotifyOpinionWithBLOBs notifyOpinionWithBLOBs : list) {
                List<Attachment> attachmentList = GetAttachmentListUtil.returnAttachment(notifyOpinionWithBLOBs.getAttachmentName(), notifyOpinionWithBLOBs.getAttachmentId(), company, module);
                String zipName = notifyOpinionWithBLOBs.getDeptName() + "-" + notifyOpinionWithBLOBs.getUserName() + File.separator;// 定义压缩包名称 用户名-部门名称
                if (attachmentList != null && attachmentList.size() > 0) {
                    for (Attachment attachment : attachmentList) {
                        String ym = attachment.getYm();
                        String attachmentId = attachment.getAttachId();
                        String attachmentName = attachment.getAttachName();
                        StringBuilder sb = new StringBuilder(sbf);
                        if (StringUtils.checkNull(sb.toString())) {
                            String a = request.getRealPath("");
                            sb.append(a);
                            sb.append(System.getProperty("file.separator")).
                                    append(company).append(System.getProperty("file.separator")).
                                    append(module).append(System.getProperty("file.separator")).append(ym).
                                    append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
                        } else {
                            sb.append(System.getProperty("file.separator")).
                                    append(company).append(System.getProperty("file.separator")).
                                    append(module).append(System.getProperty("file.separator")).append(ym).
                                    append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
                        }

                        String path = sb.toString();
//                    是否是加密文件
                        boolean bol = false;
                        File file = new File(path);
                        if (!file.exists()) {
                            file = new File(path + ".xoafile");
                            bol = true;
                        }
                        if (file.exists()) {
                            ZipEntry ze = new ZipEntry(zipName + attachmentName);
                            zipOutputStream.putNextEntry(ze);
                            byte[] abc = AESUtil.download(file, company, bol);
                            zipOutputStream.write(abc, 0, abc.length);
                            zipOutputStream.flush();
                        }
                    }
                }
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


        return null;
    }


    /**
     * 写入压缩包
     * file
     * parentPath
     */
    public void writeZip(File file, String parentPath, ZipOutputStream zos) {
        if (file.exists()) { // 需要压缩的文件夹是否存在

            if (file.isDirectory()) {// 是文件夹

                parentPath += file.getName() + File.separator; // 文件夹名称 + "/"

                File[] files = file.listFiles(); // 获取文件夹下的文件夹或文件
                if (files.length != 0) {
                    for (File f : files) {
                        writeZip(f, parentPath, zos);
                    }
                } else { // 空目录则创建当前目录
                    try {
                        zos.putNextEntry(new ZipEntry(parentPath));
                    } catch (IOException e) {
                        e.getStackTrace();
                    }
                }
            } else { //是文件
                FileInputStream fis = null;
                try {
                    fis = new FileInputStream(file);

                    String nameStr = parentPath + file.getName();

                    ZipEntry ze = new ZipEntry(nameStr);
                    zos.putNextEntry(ze);

                    byte[] content = new byte[1024];
                    int len;
                    while ((len = fis.read(content)) != -1) {
                        zos.write(content, 0, len);
                        zos.flush();
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

    }


}
