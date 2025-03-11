package com.xoa.service.message.impl;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.message.MessageMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.message.Message;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.message.MessageService;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.page.PageParams;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 微讯
 * 2018.8.13
 */
@Service
public class MessageServiceImpl implements MessageService {

    @Resource
    private MessageMapper messageMapper;  //注入Mybatis

    @Resource
    private UsersMapper usersMapper;
    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Resource
    private SysCodeMapper sysCodeMapper;
    @Resource
    private SmsService smsService;
    public final static String notifyDatetime = "1970-01-01"; //数据库最小时间
    @Override
    public ToJson<Message> getStatusWQR(HttpServletRequest request,Integer page,Integer pageSize,boolean useFlag) {
        ToJson<Message> json=new ToJson<Message>();
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        PageParams pages=new PageParams();
        pages.setPage(page);
        pages.setPageSize(pageSize);
        pages.setUseFlag(useFlag);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page",pages);
        try{
            //获取当前登录人的信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            if(users!=null){
                List<Message> list=messageMapper.getStatusWQR(map,users.getUid().toString());
                if(list.size()>0){
                    for(Message mes:list){
                        if(mes.getSendTime()!=null){  //时间戳转时间
                            String sendTimes=DateFormat.getStrDateTime(mes.getSendTime());
                            mes.setSendTimes(sdf.parse(sendTimes));
                        }
                    }
                    json.setTotleNum(messageMapper.getStatusWQRCount(users.getUid().toString()));
                    json.setObj(list);
                    json.setMsg("true");
                }else{
                    json.setMsg("没有未确认微讯");
            }
                json.setFlag(0);
            }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson delMessage(HttpServletRequest request,Message message) {
        ToJson json=new ToJson();
        int line=0;
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            if(message.getMsgId()!=null){
                String [] msgIds=message.getMsgId().toString().split(",");
                List<Message> list=messageMapper.messageList(msgIds); //查询要删除的微讯
                if(list.size()>0){
                    //获取当前登录人的信息
                    Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                    Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                    for(Message mes:list){
                        if(mes.getToUid().equals(users.getUid())){ //收件人刪除
                            message.setDelInt(1);
                        }else if(mes.getFromUid().equals(users.getUid())){ //发件人删除
                            message.setDelInt(2);
                        }else{
                            message.setDelInt(0);
                        }
                        if(mes.getBeginTime()!=null){ //开始时间转时间戳
                            String beginTime=sdf.format(mes.getBeginTime());
                            mes.setBeginInt(DateFormat.getDateTime(beginTime));
                        }
                        if(mes.getEndTime()!=null){ //结束时间转时间戳
                            String endTime=sdf.format(mes.getEndTime());
                            mes.setEndInt(DateFormat.getDateTime(endTime));
                        }
                        line+=messageMapper.delMessage(message); //执行删除
                    }
                }
            }
            if(line>0){
                json.setFlag(0);
                json.setMsg("true");
            }else {
                json.setMsg("微讯不存在");
            }
        }catch (Exception e){
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson addMessage(HttpServletRequest request,Message message) {
        ToJson json=new ToJson();
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        int line=0;
        try{
            if(message!=null){
                if(message.getFromUid()==null){ //发件人
                    //获取当前登录人的信息
                    Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                    Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
                    message.setFromUid(users.getUid());
                    message.setFromName(users.getUserId());
                }
                if(message.getUserId()!=null){ //收件人
                    String []id=message.getUserId().split(",");
                    for(int i=0;i<id.length;i++){
                        Users user=usersMapper.findUsersByuserId(id[i]);  //根据 userId 找 UID
                        if(user!=null){
                            message.setToUid(user.getUid());
                        }
                    }
                }
                if(message.getSendTimes()!=null){ //发送时间转时间戳
                    String sendTimes=sdf.format(message.getSendTimes());
                    message.setSendTime(DateFormat.getDateTime(sendTimes));
                }else{                            //没有设置发送时间，默认为当前时间
                    String sj=sdf.format(new Date());
                    message.setSendTime(DateFormat.getDateTime(sj));
                }
                line+=messageMapper.addMessage(message);

            }
            if(line>0){
                addAffairs(message,message.getMsgId(),message.getUserId(),request); //事务提醒 参数 对象，查找信息内容，要提醒的人
                json.setFlag(0);
                json.setMsg("true");
            }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Message> getMessageInfo(HttpServletRequest request,Message message,Integer page,Integer pageSize,boolean useFlag) {
        ToJson<Message> json=new ToJson<Message>();
        PageParams pages=new PageParams();
        pages.setPage(page);
        pages.setPageSize(pageSize);
        pages.setUseFlag(useFlag);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page",pages);
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
                //获取当前登录人的信息
                Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            if(users!=null) {   //发件人
                    message.setFromUid(users.getUid());
                }
            if(message.getUserName()!=null && !message.getUserName().isEmpty()){ //收件人
               Users users1=usersMapper.getUsersByuserId(message.getUserName());
               if(users1!=null){
                   message.setUserId(users1.getUid().toString());
               }
            }
            if(message.getUserId()!=null & message.getFromUid()!=null){
            map.put("message",message);
            List<Message> list=messageMapper.getMessageInfo(map);
            if(list.size()>0){
                for(int i=0;i<list.size();i++){
                    //时间戳转为时间
                    if(list.get(i).getSendTime()!=null){
                        String sendTime=DateFormat.getStrTime(list.get(i).getSendTime());
                        list.get(i).setSendTimes(sdf.parse(sendTime));
                    }
                }
                json.setTotleNum(messageMapper.getMessageInfoCount(map));
                json.setObj(list);
                json.setFlag(0);
                json.setMsg("true");
            }else{
                json.setMsg("微讯记录为空");
            }
            }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson clickReply(String msgId) {
        ToJson json=new ToJson();
        try{
            if(msgId!=null){
                String fromId=messageMapper.clickReply(msgId);
                if(fromId!=null &&!fromId.isEmpty()){
                    Users users=usersMapper.SimplefindUserByuid(Integer.parseInt(fromId));
                    if(users!=null){
                        json.setObject(users.getUserName());
                        json.setMsg("true");
                        json.setFlag(0);
                    }
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<Message> selectMessage(HttpServletRequest request,HttpServletResponse response, Message message, String export,Integer page,Integer pageSize,boolean useFlag) {
        ToJson<Message> json=new ToJson<Message>();
        PageParams pages=new PageParams();
        pages.setPage(page);
        pages.setPageSize(pageSize);
        pages.setUseFlag(useFlag);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("page",pages);
        //设置要获取到什么样的时间
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            if(export==null){
                export="0";
            }
            if(message!=null){
                if(message.getOrderById()!=null){
                    if(message.getOrderById().equals("1")){
                        message.setOrderByName("DESC");
                    }
                    if(message.getOrderById().equals("2")){
                        message.setOrderByName("ASC");
                    }
                }
                if(message.getStrId()!=null){
                    if(message.getStrId().equals("1")){
                        message.setStrName("sendTime");
                    }
                    if(message.getStrId().equals("2")){
                        message.setStrName("content");
                    }
                }
                if(message.getBeginTime()!=null){
                    String beginTime=sdf.format(message.getBeginTime());
                    message.setBeginInt(DateFormat.getDateTime(beginTime));
                }
                if(message.getEndTime()!=null){
                    String endTime=sdf.format(message.getEndTime());
                    message.setEndInt(DateFormat.getDateTime(endTime));
                }
                map.put("message",message);
            }
            List<Message> list=messageMapper.selectMessage(map);
            if(list.size()>0){
                for(Message mes:list){
                    //时间戳转为时间
                    if(mes.getSendTime()!=null){
                        String sendTime=DateFormat.getStrTime(mes.getSendTime());
                        mes.setSendTimes(sdf.parse(sendTime));
                    }
                    if(mes.getMsgType()!=null){
                        if(mes.getMsgType().equals("1")){
                            mes.setTypeName("微讯网页消息");
                        }
                        if(mes.getMsgType().equals("2")){
                            mes.setTypeName("及时通讯离线消息");
                        }
                        if(mes.getMsgType().equals("3")){
                            mes.setTypeName("微讯移动版(Android)");
                        }
                        if(mes.getMsgType().equals("4")){
                            mes.setTypeName("微讯移动版(iPhone)");
                        }
                        if(mes.getMsgType().equals("5")){
                            mes.setTypeName("邮件微讯");
                        }else{
                            mes.setTypeName("微讯网页消息");
                        }
                    }
                    if(mes.getRemindFlag().equals("1")){
                        mes.setRemindName("是");
                    }else if(mes.getRemindFlag().equals("0")){
                        mes.setRemindName("已读");
                    }else{
                        mes.setRemindName("否");
                    }
                    if(mes.getFromUid()!=null){
                        Users users=usersMapper.getByUid(mes.getFromUid());
                        if(users!=null){
                            mes.setFromName(users.getUserName());
                        }
                    }
                    if(mes.getToUid()!=null){
                        Users users=usersMapper.getByUid(mes.getToUid());
                        if(users!=null){
                            mes.setUserName(users.getUserName());
                        }
                    }
                }
                json.setTotleNum(messageMapper.selectMessageCount(map));
                json.setObj(list);
                json.setMsg("true");
                json.setFlag(1);
            }else{
                json.setMsg("微讯记录为空");
            }
            if(export.equals("1")) {  //导出.
                if (list != null) {
                    for(Message mes:list){
                        if(mes.getSendTime()!=null){
                            mes.setExportTime(DateFormat.getStrTime(mes.getSendTime()));
                        }
                    }
                    HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("微讯", 6);
                    String[] secondTitles = {"微讯类型", "发件人", "收件人", "内容", "发送时间", "提醒"};
                    HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                    String[] beanProperty = {"typeName", "fromName", "userName", "content", "exportTime", "remindName"};
                    HSSFWorkbook workbook = null;
                    workbook = ExcelUtil.exportExcelData(workbook2, list, beanProperty);
                    response.setContentType("text/html;charser=UTF-8");
                    ServletOutputStream out = response.getOutputStream();
                    String filename = "微讯.xls";//考虑多语言
                    filename = FileUtils.encodeDownloadFilename(filename,
                            request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("content-disposition",
                            "attachment;filename=" + filename);
                    workbook.write(out);
                    out.flush();
                    out.close();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(0);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson getMessage(String msgId) {
        ToJson json=new ToJson();
        try{
              Message message=messageMapper.getMessage(msgId);
              if(message!=null){
                  json.setMsg("true");
                  json.setFlag(0);
              }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }

    @Async
    public void addAffairs(Message message, final Integer mesId, final String todoId, HttpServletRequest request) {
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final String userName = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users()).getUserName();
        final Message mess = message;
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(mess.getFromName());
                smsBody.setContent("微讯消息！主题："+mess.getContent() );
                smsBody.setSendTime(mess.getSendTime());
                SysCode sysCode = new SysCode();
                sysCode.setCodeName("公告通知");
               sysCode.setParentNo("SMS_REMIND");
                if (sysCodeMapper.getCodeNoByNameAndParentNo(sysCode) != null) {
                    smsBody.setSmsType(sysCodeMapper.getCodeNoByNameAndParentNo(sysCode).getCodeNo());
                }
                smsBody.setRemindUrl("wx/details?msgId=" + mesId);
                String title = userName + "：请查收我的微讯！";
                String context = "主题:" + mess.getContent();
                smsService.saveSms(smsBody, todoId, "1", "1", title, context, sqlType);
            }
        });

    }

}
