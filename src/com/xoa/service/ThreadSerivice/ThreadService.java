package com.xoa.service.ThreadSerivice;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.meet.MeetingRoomMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.meet.MeetingRoomWithBLOBs;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.notify.Notify;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms2.Sms2Priv;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.model.worldnews.News;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.DateFormatUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;



@Service
public class ThreadService {

    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Resource
    private UsersService usersService;
    @Resource
    private SysCodeMapper sysCodeMapper;
    @Resource
    private SmsService smsService;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private MeetingRoomMapper meetingRoomMapper;
    @Resource
    private Sms2PrivService sms2PrivService;
    @Resource
    private QywxService qywxService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private UserExtMapper userExtMapper;

  //事物提醒
    public  void addNotify(final Notify notify, final String tuisong, final String re, final String sqlType,final String flag, Object locale){//flag=1，一般公告提醒，flag=2，审批公告提醒
        if(StringUtils.checkNull(re)||"0".equals(re)){
            return;
        }
         //选择人员
        threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa"+sqlType);
                SmsBody smsBody=new SmsBody();
                smsBody.setFromId(notify.getFromId());
              /*  smsBody.setSendTime((int) (notify.getSendTime().getTime()/1000));*/
                Integer sendTime=0;
                if(notify.getSendTime()!=null){
                    try {
                        sendTime= DateFormatUtils.getNowDateTime(DateFormatUtils.formatDate(notify.getSendTime()));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
                boolean bol = false;
                SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
                if (myproject != null && !StringUtils.checkNull(myproject.getParaValue())
                        && "dazu".equals(myproject.getParaValue())) {
                    bol = true;
                }
                //公告发送时间先
               /* smsBody.setSendTime(sendTime>=beginTime?sendTime:beginTime);*/
               smsBody.setSendTime(sendTime);
                SysCode sysCode=new SysCode();
                if (locale.equals("zh_CN")) {
                    sysCode.setCodeName("公告通知");
                } else if (locale.equals("en_US")) {
                    sysCode.setCodeName("Announcement Notice");
                } else if (locale.equals("zh_TW")) {
                    sysCode.setCodeName("公告通知");
                }
                sysCode.setParentNo("SMS_REMIND");
                if(!StringUtils.checkNull(notify.getAttachmentId())&&!StringUtils.checkNull(notify.getAttachmentName())){
                    smsBody.setIsAttach("1");
                }
                if(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode)!=null){
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                String title="";
                StringBuffer userStr=new StringBuffer();
                if("1".equals(flag)){
                    String[] userIdList=notify.getUserId().split(",");
                    List<String> userArray=new ArrayList();
                    for(String userId:userIdList){
                        userArray.add(userId);
                    }
                    //部门人员
                    List<Users> deptList=new ArrayList();
                    if(!StringUtils.checkNull(notify.getToId())){
                        if("ALL_DEPT".trim().equals(notify.getToId())){
                            List<Department>  deptListArr=departmentMapper.getAllDepartment();
                            StringBuffer stringBuffer=new StringBuffer();
                            for(Department department:deptListArr){
                                stringBuffer.append(department.getDeptId());
                                stringBuffer.append(",");
                            }
                            deptList=usersService.getUserByDeptIds(stringBuffer.toString(),1);
                        }else {
                            deptList=usersService.getUserByDeptIds(notify.getToId(),5);
                        }

                    }
                    List<String> deptArray=new ArrayList();
                    for(Users users:deptList){
                        deptArray.add(users.getUserId());
                    }
                    //角色人员
                    List<Users> privList=new ArrayList();
                    if(!StringUtils.checkNull(notify.getPrivId())){
                        privList=usersService.getUserByDeptIds(notify.getPrivId(),6);
                    }
                    List<String> privArray=new ArrayList();
                    for(Users users:privList){
                        privArray.add(users.getUserId());
                    }

                    //删除重复的数据
                    for(String userId:userArray){
                        int f1=0;
                        for(String deptUser:deptArray){
                            if(userId.equals(deptUser)){
                                f1=1;
                                break;
                            }
                        }
                        if(f1==0){
                            deptArray.add(userId);
                        }
                    }
                    for(String temp1:deptArray){
                        int f2=0;
                        for(String privUser:privArray){
                            if(temp1.equals(privUser)){
                                f2=1;
                                break;
                            }
                        }
                        if(f2==0){
                            privArray.add(temp1);
                        }
                    }
                    for(String tempUser:privArray){
                        userStr.append(tempUser+",");
                    }
                    // 检查人员类型
                    if (!StringUtils.checkNull(notify.getUserType())){
                        userStr = checkUser(userStr.toString(),notify.getUserType());
                    }
                    smsBody.setRemindUrl("/notice/detail?notifyId="+notify.getNotifyId());
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent(bol ? notify.getSubject() : "请查看公告通知！标题：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "您有新的公告通知";
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent(bol ? notify.getSubject() : "Please check the announcements and notices！Title：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "You have new announcements and notices";
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent(bol ? notify.getSubject() : "請查看公告通知！標題：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "您有新的公告通知";
                    }
                }
                if("2".equals(flag)){
                    userStr.append(notify.getAuditer());
                    smsBody.setRemindUrl("/notice/appprove?notifyId="+notify.getNotifyId());
                    if (locale.equals("zh_CN")) {
                        smsBody.setContent(bol ? notify.getSubject() : "请审批我的公告！标题：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "您有公告需要审批";
                    } else if (locale.equals("en_US")) {
                        smsBody.setContent(bol ? notify.getSubject() : "Please approve my announcement！Title：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "You have an announcement that needs to be approved";
                    } else if (locale.equals("zh_TW")) {
                        smsBody.setContent(bol ? notify.getSubject() : "請審批我的公告！標題：" + notify.getSubject());
                        title = bol ? notify.getSubject() : "您有公告需要審批";
                    }
                }
                String typeName="";
                if (notify.getTypeId() != null && !notify.getTypeId().equals("")) {
                    String name11 = sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                    if (StringUtils.checkNull(name11)) {
                    } else {
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
                smsService.saveSms(smsBody,userStr.toString(),re,tuisong,title,context,sqlType);
                qywxService.sendMsg(Arrays.asList(userStr.toString().split(",")),title,context,"/ewx/noticeDetail?notifyId="+notify.getNotifyId(),false);
            }
        });

    }

    private StringBuffer checkUser(String toString, String userType) {
        Map map = new HashMap();
        map.put("userIds",toString.split(","));
        map.put("userType",userType.split(","));
        StringBuffer sb = new StringBuffer();
        List<UserExt> userExts = null;
        try {
            userExts = userExtMapper.checkUser(map);
        }catch (Exception e){
            e.printStackTrace();
        }

        for (UserExt user:userExts){
            sb.append(user.getUserId()+",");
        }
        return sb;
    }

    public  void addNew(final News news, final String remind, final String tuisong,final String sqlType, Object locale){
        if(StringUtils.checkNull(remind)||"0".equals(remind)){
            return;
        }
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                //选择人员
                ContextHolder.setConsumerType("xoa"+sqlType);
                String[] userIdList=news.getUserId().split(",");
                List<String> userArray=new ArrayList();
                for(String userId:userIdList){
                    userArray.add(userId);
                }
                //部门人员
                List<Users> deptList=new ArrayList<>();
                if("ALL_DEPT".trim().equals(news.getToId())){
                    List<Department>  deptListArr=departmentMapper.getAllDepartment();
                    StringBuffer stringBuffer=new StringBuffer();
                    for(Department department:deptListArr){
                        stringBuffer.append(department.getDeptId());
                        stringBuffer.append(",");
                    }
                    deptList=usersService.getUserByDeptIds(stringBuffer.toString(),1);
                }else {
                    deptList=usersService.getUserByDeptIds(news.getToId(),5);
                }
                List<String> deptArray=new ArrayList();
                if(deptList!=null){
                    for(Users users:deptList){
                        if (!"".equals(users.getUserId())&&(users.getUserId())!=null){
                            deptArray.add(users.getUserId());
                        }
                    }
                }

                //角色人员
                List<Users> privList=new ArrayList();
                if(!StringUtils.checkNull(news.getPrivId())){
                    privList=usersService.getUserByDeptIds(news.getPrivId(),6);
                }
                List<String> privArray=new ArrayList();
                for(Users users:privList){
                    privArray.add(users.getUserId());
                }
                //删除重复的数据
                for(String userId:userArray){
                    int f1=0;
                    for(String deptUser:deptArray){
                        if(userId.equals(deptUser)){
                            f1=1;
                            break;
                        }
                    }
                    if(f1==0){
                        deptArray.add(userId);
                    }
                }
                for(String temp1:deptArray){
                    int f2=0;
                    for(String privUser:privArray){
                        if(temp1.equals(privUser)){
                            f2=1;
                            break;
                        }
                    }
                    if(f2==0){
                        privArray.add(temp1);
                    }
                }
                StringBuffer userStr=new StringBuffer();
                for(String tempUser:privArray){
                    userStr.append(tempUser+",");
                }
                SmsBody smsBody=new SmsBody();
                smsBody.setFromId(news.getProvider());
                smsBody.setSendTime(DateFormat.getTime(DateFormat.getStrDate(news.getNewsTime())));
                SysCode sysCode=new SysCode();
                sysCode.setParentNo("SMS_REMIND");
                if (locale.equals("zh_CN")) {
                    smsBody.setContent("请查看新闻！标题："+news.getSubject());
                    sysCode.setCodeName("新闻");
                } else if (locale.equals("en_US")) {
                    smsBody.setContent("Please check the news！Title："+news.getSubject());
                    sysCode.setCodeName("news");
                } else if (locale.equals("zh_TW")) {
                    smsBody.setContent("請查看新聞！標題："+news.getSubject());
                    sysCode.setCodeName("新聞");
                }

                if(!StringUtils.checkNull(news.getAttachmentId())&&!StringUtils.checkNull(news.getAttachmentName())){
                    smsBody.setIsAttach("1");
                }
                if(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode)!=null){
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                String title = "您有新的新闻消息";
                String typeName = "无类型";
                if (locale.equals("en_US")) {
                    title = "You have new news";
                    typeName = "No type";
                } else if (locale.equals("zh_TW")) {
                    title = "您有新的新聞消息";
                    typeName = "無類型";
                }
                if (news.getTypeId() != null && !news.getTypeId().equals("")) {
                    String name11 = sysCodeMapper.getNewsNameByNo(news.getTypeId());
                    if (StringUtils.checkNull(name11)) {
                    } else {
                        typeName=name11;
                    }
                }
                String context=typeName+":"+news.getSubject();

                smsBody.setRemindUrl("/news/detail?newsId="+news.getNewsId());
                smsService.saveSms(smsBody,userStr.toString(),remind,tuisong,title,context,sqlType);

                // 企业微信推送
                qywxService.sendMsg(Arrays.asList(userStr.toString().split(",")),title,context,"/ewx/newsDetail?dataType=&newsId="+news.getNewsId(),false);
            }
        });

}

    public void addAffairs(News news, String remind2, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        String userName = users.getUserName();
        ContextHolder.setConsumerType("xoa" + sqlType);
        SmsBody smsBody = new SmsBody();
        smsBody.setFromId(users.getUserId());
        smsBody.setContent("请审批我的新闻！主题：" + news.getSubject());
        smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
        SysCode sysCode = new SysCode();
        sysCode.setCodeName("新闻");
        sysCode.setParentNo("SMS_REMIND");
        if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
            smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
        }
        String toUserId=news.getAuditer();
        smsBody.setRemindUrl("/news/doAuditing");
        String title = userName + "：请审批我的新闻";
        String context = "新闻标题:" + news.getSubject();
        smsService.saveSms(smsBody, toUserId, "1", "1", title, context, sqlType);
    }


    public  void add0pflagNewWorkFastAdd( final Users users, final int flowId, final int prcsId, final String flowPrcs, final String id,final String tableName,final String tabId,final String  sqlType ){
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType(sqlType);
                String smsUrl = "/workflow/work/workform?opflag=0&flowId=" + flowId + "&flowStep=" + prcsId + "&runId=" + id + "&prcsId="+flowPrcs;
                //主办人提交消除事物提醒
                if ("document".equals(tableName)) {
                    smsUrl = "/workflow/work/workform?opflag=0&flowId=" + flowId + "&flowStep=" + prcsId + "&tableName=" + tableName + "&tabId=" + tabId + "&runId=" + id + "&prcsId=" + flowPrcs + "&isNomalType=false";
                    smsService.updatequerySmsByType("70", users.getUserId(), smsUrl.trim());
                } else if("budget".equals(tableName)){
                    smsUrl+="&tableName=budget";
                    smsService.updatequerySmsByType("7", users.getUserId(), smsUrl.trim());
                } else {
                    smsService.updatequerySmsByType("7", users.getUserId(), smsUrl.trim());
                }
            }
        });



    }
    public  void addMeeting(final Users users,final MeetingWithBLOBs attendEdd,final String  sqlType){
         this.threadPoolTaskExecutor.execute(new Runnable() {
             @Override
             public void run() {
                 ContextHolder.setConsumerType(sqlType);
                 Users users1=usersService.findUserByuid(attendEdd.getUid());
                 SmsBody smsBody=new SmsBody();
                 smsBody.setFromId(users1.getUserId());
                 smsBody.setContent(attendEdd.getMeetDesc());
                 smsBody.setSendTime((int) (DateFormat.getDate(attendEdd.getCreateTime()).getTime()/1000));
                 SysCode sysCode=new SysCode();
                 sysCode.setCodeName("会议申请");
                 sysCode.setParentNo("SMS_REMIND");
                 if(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode)!=null){
                     smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                 }
                 smsBody.setRemindUrl("/meeting/detail?meetingId="+attendEdd.getSid());
                 MeetingRoomWithBLOBs meetingRoom = meetingRoomMapper.selectByPrimaryKey(attendEdd.getMeetRoomId());
                 String title="会议通知";
                 String context="请于"+DateFormat.getDatestrTimes(DateFormat.getDate(attendEdd.getStartTime()))+"到"+meetingRoom.getMrName()+"参加会议";
               String[] str=  attendEdd.getAttendee().split(",");
               StringBuffer stringBuffer=new StringBuffer();
               for(int i=0;i<str.length;i++){
                  if(usersService.findUserByuid(Integer.parseInt(str[i]))!=null){
                      stringBuffer.append(usersService.findUserByuid(Integer.parseInt(str[i])).getUserId());
                      stringBuffer.append(",");
                  }
               }


             /*   smsService.saveSms(smsBody,stringBuffer.toString(),"1","1",title,context,sqlType);*/
             }
         });

    }
 public  void addNotifyMessageSendering(final Notify notify,final HttpServletRequest request){
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                ContextHolder.setConsumerType("xoa" + sqlType);
                boolean bol = false;
                    SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
                    if(myproject != null && !StringUtils.checkNull(myproject.getParaValue())
                            && "dazu".equals(myproject.getParaValue())){
                        bol=true;
                    }
                if(!StringUtils.checkNull(notify.getHowRenind())){
                    String[] s = notify.getHowRenind().split(",");
                    for(String s1 :s){
                        if("1".equals(s1)){
                            Sms2Priv sms2Priv = new Sms2Priv();
                            sms2Priv.setUserId(notify.getUserId());
                            sms2Priv.setToId(notify.getToId());
                            sms2Priv.setPrivId(notify.getPrivId());
                            StringBuffer contextString  = new StringBuffer(bol ? "" : "请查看公告通知！标题："+notify.getSubject());
                            sms2PrivService.selSenderMobile(notify.getSmsDefault(),sms2Priv,contextString,request);
                        }
                    }
                }
            }

        });

    }



    public static String FormetFileSize(long fileS) {//转换文件大小
        DecimalFormat df = new DecimalFormat("#.00");
        String fileSizeString = "";
        if(fileS==0){
            return "0.00B";
        }
        if (fileS < 1024) {
            fileSizeString = df.format((double) fileS) + "B";
        } else if (fileS < 1048576) {
            fileSizeString = df.format((double) fileS / 1024) + "KB";
        } else if (fileS < 1073741824) {
            fileSizeString = df.format((double) fileS / 1048576) + "M";
        } else {
            fileSizeString = df.format((double) fileS / 1073741824) + "G";
        }
        return fileSizeString;
    }
    //取得文件大小
    public static long getFileSizes(File f) {
        long s=0;
        if (f.exists()) {
            try (FileInputStream fis = new FileInputStream(f)){
            s= fis.available();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            //System.out.println("文件不存在");
        }
        return s;
    }
    //获取文件名
    public static String getFileName(String filePath) {
        String fileName="";
        //读取配置文件
        ResourceBundle rb =  ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb=new StringBuffer();
        if(osName.toLowerCase().startsWith("win")){
            String [] fileItems=filePath.split("\\\\");
            fileName=fileItems[fileItems.length-1];
        }else{
            String [] fileItems=filePath.split("/");
            fileName=fileItems[fileItems.length-1];
        }

        return fileName;
    }
    //获取文件类型
    public static String getFileType(String fileName) {
        return fileName.substring(fileName.lastIndexOf(".")+1).toUpperCase();
    }
}