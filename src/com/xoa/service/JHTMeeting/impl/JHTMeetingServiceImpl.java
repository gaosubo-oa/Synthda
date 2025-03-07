package com.xoa.service.JHTMeeting.impl;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.xoa.dao.JHTMeeting.JHTMeetingMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.model.JHTMeeting.JHTMeetingWithBLOBs;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.JHTMeeting.JHTMeetingService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.http.HttpClientUtil;
import com.xoa.util.page.PageParams;
import org.apache.http.HttpEntity;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Service
public class JHTMeetingServiceImpl implements JHTMeetingService {

    @Autowired
    private JHTMeetingMapper jhtMeetingMapper;

    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private SysParaService sysParaService;

    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private SmsService smsService;

    private static final String hostmeeting = "http://mware.liveuc.net/ameeting/hostmeeting";

    //删除接口
    private static final String deletemeeting = "http://mware.liveuc.net/ameeting/deletemeeting";

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  查询接口
     */
    @Override
    public ToJson findJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs,Integer page,Integer limit) {
        ToJson toJson = new ToJson(1,"false");
        Map map = new HashMap();
        try {
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(limit);
            pageParams.setUseFlag(true);
            map.put("pageParams",pageParams);
        }catch (Exception e){
            e.printStackTrace();
        }
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

            //我的申请
            if (!StringUtils.checkNull(jhtMeetingWithBLOBs.getUserId())){
                map.put("userId",user.getUserId());
            }

            //我参与的
            if (!StringUtils.checkNull(jhtMeetingWithBLOBs.getHostUserId()) && !StringUtils.checkNull(jhtMeetingWithBLOBs.getSummaryUserId()) && !StringUtils.checkNull(jhtMeetingWithBLOBs.getUserIds())){
                map.put("hostUserId",user.getUserId());
                map.put("summaryUserId",user.getUserId());
                map.put("userIds",user.getUserId());
                map.put("meetStatus","2");
                map.put("deptId",user.getDeptId());
            }

            //审批人
            if (!StringUtils.checkNull(jhtMeetingWithBLOBs.getManagerId())){
                map.put("managerId",user.getUserId());
                map.put("meetStatus","1");
            }


            List<JHTMeetingWithBLOBs> jhtMeetingWithBLOBs1 = jhtMeetingMapper.findJHTMeeting(map);
            for (JHTMeetingWithBLOBs jhtMeeting:jhtMeetingWithBLOBs1) {

                //审批人
                if (!StringUtils.checkNull(jhtMeeting.getManagerId())){
                    jhtMeeting.setManagerName(usersService.getUserNameById(jhtMeeting.getManagerId()));
                }

                //申请人
                if (!StringUtils.checkNull(jhtMeeting.getUserId())){
                    jhtMeeting.setUserName(usersService.getUserNameById(jhtMeeting.getUserId()));
                }

                //主持人
                if (!StringUtils.checkNull(jhtMeeting.getHostUserId())){
                    jhtMeeting.setHostUserName(usersService.getUserNameById(jhtMeeting.getHostUserId()));
                }

                //会议纪要员
                if (!StringUtils.checkNull(jhtMeeting.getSummaryUserId())){
                    jhtMeeting.setSummaryUserName(usersService.getUserNameById(jhtMeeting.getSummaryUserId()));
                }

                //参会人员
                if (!StringUtils.checkNull(jhtMeeting.getUserIds())){
                    jhtMeeting.setUserIdNames(usersService.getUserNameById(jhtMeeting.getUserIds()));
                }

                //所属部门
                if (!StringUtils.checkNull(jhtMeeting.getDeptId())){
                    jhtMeeting.setDeptName(departmentService.getDpNameById(jhtMeeting.getDeptId()));
                }

                //附件
                if (!StringUtils.checkNull(jhtMeeting.getAttachmentName()) && !StringUtils.checkNull(jhtMeeting.getAttachmentId())){
                    List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(jhtMeeting.getAttachmentName(), jhtMeeting.getAttachmentId(), sqlType, "jhtmeeting");
                    jhtMeeting.setAttachmentList(attachments);
                }

            }

            toJson.setObj(jhtMeetingWithBLOBs1);
            PageParams pageParams = (PageParams) map.get("pageParams");
            toJson.setTotleNum(pageParams.getTotal());
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  根据ID查询接口
     */
    @Override
    public ToJson findByMeetingId(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs) {
        ToJson toJson = new ToJson(1,"false");
        try {
            String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));


            JHTMeetingWithBLOBs jhtMeeting = jhtMeetingMapper.selectByPrimaryKey(jhtMeetingWithBLOBs.getMeetingId());
            if ( jhtMeeting!=null ){
                //审批人
                if (!StringUtils.checkNull(jhtMeeting.getManagerId())){
                    jhtMeeting.setManagerName(usersService.getUserNameById(jhtMeeting.getManagerId()));
                }

                //申请人
                if (!StringUtils.checkNull(jhtMeeting.getUserId())){
                    jhtMeeting.setUserName(usersService.getUserNameById(jhtMeeting.getUserId()));
                }

                //主持人
                if (!StringUtils.checkNull(jhtMeeting.getHostUserId())){
                    jhtMeeting.setHostUserName(usersService.getUserNameById(jhtMeeting.getHostUserId()));
                }

                //会议纪要员
                if (!StringUtils.checkNull(jhtMeeting.getSummaryUserId())){
                    jhtMeeting.setSummaryUserName(usersService.getUserNameById(jhtMeeting.getSummaryUserId()));
                }

                //参会人员
                if (!StringUtils.checkNull(jhtMeeting.getUserIds())){
                    jhtMeeting.setUserIdNames(usersService.getUserNameById(jhtMeeting.getUserIds()));
                }

                //所属部门
                if (!StringUtils.checkNull(jhtMeeting.getDeptId())){
                    jhtMeeting.setDeptName(departmentService.getDpNameById(jhtMeeting.getDeptId()));
                }

                //附件
                if (!StringUtils.checkNull(jhtMeeting.getAttachmentName()) && !StringUtils.checkNull(jhtMeeting.getAttachmentId())){
                    List<Attachment> attachments = GetAttachmentListUtil.returnAttachment(jhtMeeting.getAttachmentName(), jhtMeeting.getAttachmentId(), sqlType, "jhtmeeting");
                    jhtMeeting.setAttachmentList(attachments);
                }
            }
            toJson.setObject(jhtMeeting);
            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  编辑接口
     */
    @Override
    public ToJson editJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs, String isop) {
        ToJson toJson = new ToJson(1,"false");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

            if (!StringUtils.checkNull(isop) && isop.equals("1")){

                List<SysPara> theSysParam = sysParaService.getTheSysParam("WD_MEETING");
                if (!theSysParam.isEmpty()) {
                    String paraValue = theSysParam.get(0).getParaValue();
                    JsonObject jsonObject = (JsonObject) new JsonParser().parse(paraValue);
                    switch (jsonObject.get("jhtType").getAsString()) {
                        case "iactive":
                            JsonObject iactive = jsonObject.get("iactive").getAsJsonObject();
                            Map mapData = new HashMap();
                            mapData.put("method","900014");

                            mapData.put("AUTH_UID",iactive.get("authUid").getAsString());
                            mapData.put("AUTH_PASS",iactive.get("authPass").getAsString());

                            mapData.put("IA_ROOMID",jhtMeetingWithBLOBs.getRoomId());

                            mapData.put("IA_ROOMNAME",jhtMeetingWithBLOBs.getMeetName());
                            mapData.put("IA_R_REMARK",jhtMeetingWithBLOBs.getMeetName());
                            mapData.put("IA_R_IS_VALID","1");
                            mapData.put("IA_R_IS_PUBLIC","1");
                            mapData.put("MAXUSER",jhtMeetingWithBLOBs.getMaxUser().toString());
                            mapData.put("IA_R_ANONYMOUS","1");
                            mapData.put("APP","2");
                            mapData.put("IA_R_PWD_NORMAL",jhtMeetingWithBLOBs.getRoomPwd());
                            mapData.put("START_VALID_DATE",DateFormat.getStrDate(jhtMeetingWithBLOBs.getStartTime()));
                            mapData.put("END_VALID_DATE",DateFormat.getStrDate(jhtMeetingWithBLOBs.getEndTime()));
                            mapData.put("IA_CREATID",user.getUid()); //user.getUid()
                            mapData.put("IA_MEETING_PERIOD",jhtMeetingWithBLOBs.getRoomTimeLimit());
                            mapData.put("IA_R_MESSAGE","10");
                            mapData.put("BANDWIDTH","100");
                            mapData.put("MAX_VIDEO_COUNT","24");
                            mapData.put("MAX_VOICE_COUNT","10");
                            mapData.put("LAYOUT","10");
                            mapData.put("LAYOUTURL","www.baidu.com");
//                            mapData.put("DEPT_ID",user.getDeptId());
                            mapData.put("DEPT_ID",33);
                            mapData.put("IS_FLASH_LIVE","1");
                            mapData.put("ROOM_TYPE","1");

                            Map map = new HashMap();
                            map.put("data",new Gson().toJson(mapData,Map.class));
                            String iactiveres = HttpClientUtil.doGsonPost(iactive.get("url").getAsString(), map, "UTF-8");
                            Map maps1 = (Map)JSON.parse(iactiveres);
                            if ( (Integer)maps1.get("ret") > 0) {
                                jhtMeetingMapper.updateByPrimaryKeySelective(jhtMeetingWithBLOBs);
                            }
                            break;
                        case "liveuc":
                            String liveucres = wdLiveucPost(jsonObject.get("liveuc").getAsJsonObject(),jhtMeetingWithBLOBs,"1");
                            Map maps2 = (Map)JSON.parse(liveucres);
                            if ((Integer)maps2.get("ret") == 0){
                                jhtMeetingMapper.updateByPrimaryKeySelective(jhtMeetingWithBLOBs);
                            }
                            break;
                    }
                }

            }else{
                jhtMeetingMapper.updateByPrimaryKeySelective(jhtMeetingWithBLOBs);
            }


            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  删除接口
     */
    @Override
    public ToJson delJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs) {
        ToJson toJson = new ToJson(1,"false");
        try {
            int i = -1;

            List<SysPara> theSysParam = sysParaService.getTheSysParam("WD_MEETING");
            if (!theSysParam.isEmpty()) {
                String paraValue = theSysParam.get(0).getParaValue();
                JsonObject jsonObject = (JsonObject) new JsonParser().parse(paraValue);
                switch (jsonObject.get("jhtType").getAsString()) {
                    case "iactive":
                        JsonObject iactive = jsonObject.get("iactive").getAsJsonObject();

                        Map mapData = new HashMap();
                        mapData.put("method","900019");

                        mapData.put("AUTH_UID",iactive.get("authUid").getAsString());
                        mapData.put("AUTH_PASS",iactive.get("authPass").getAsString());

                        mapData.put("IA_ROOMID",jhtMeetingWithBLOBs.getRoomId());


                        Map map = new HashMap();
                        map.put("data",new Gson().toJson(mapData,Map.class));
                        String iactiveres = HttpClientUtil.doGsonPost(iactive.get("url").getAsString(), map, "UTF-8");
                        Map maps1 = (Map)JSON.parse(iactiveres);
                        i = (Integer)maps1.get("ret");
                        break;
                    case "liveuc":
                        String liveucres = wdLiveucPost(jsonObject.get("liveuc").getAsJsonObject(),jhtMeetingWithBLOBs,"2");
                        Map maps2 = (Map)JSON.parse(liveucres);
                        i = (Integer)maps2.get("ret");
                        break;
                }
            }

            if (i >= 0){
                jhtMeetingMapper.deleteByPrimaryKey(jhtMeetingWithBLOBs.getMeetingId());
            }

            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-28
     * @方法介绍  新增接口
     */
    @Override
    public ToJson insertJHTMeeting(HttpServletRequest request, JHTMeetingWithBLOBs jhtMeetingWithBLOBs) {
        ToJson toJson = new ToJson(1,"false");
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);

            //申请人   申请时间
            jhtMeetingWithBLOBs.setUserId(user.getUserId());
            jhtMeetingWithBLOBs.setProposerTime(new Date());

            int i = -1;

            //查询系统参数  判断是 网动公共版（liveuc）还是私有版（iactive）
            List<SysPara> theSysParam = sysParaService.getTheSysParam("WD_MEETING");
            if (!theSysParam.isEmpty()) {
                String paraValue = theSysParam.get(0).getParaValue();
                JsonObject jsonObject = (JsonObject) new JsonParser().parse(paraValue);
                switch (jsonObject.get("jhtType").getAsString()) {
                    case "iactive":
                        JsonObject iactive = jsonObject.get("iactive").getAsJsonObject();

                        //查询用户
                        Map mapData2 = new HashMap();
                        mapData2.put("method","90003");

                        mapData2.put("AUTH_UID",iactive.get("authUid").getAsString());
                        mapData2.put("AUTH_PASS",iactive.get("authPass").getAsString());

                        mapData2.put("IA_USERNAME",iactive.get("authUid").getAsString());

                        Map map2 = new HashMap();
                        map2.put("data",new Gson().toJson(mapData2,Map.class));
                        String iactiveUser = HttpClientUtil.doGsonPost(iactive.get("url").getAsString(), map2, "UTF-8");
                        Map iactiveUserMap = (Map)JSON.parse(iactiveUser);
                        JsonObject arrMould = (JsonObject) new JsonParser().parse(iactiveUserMap.get("arr_mould").toString());

                        //创建会议室
                        Map mapData = new HashMap();
                        mapData.put("method","900102");

                        mapData.put("AUTH_UID",iactive.get("authUid").getAsString());
                        mapData.put("AUTH_PASS",iactive.get("authPass").getAsString());

                        mapData.put("IA_ROOMNAME",jhtMeetingWithBLOBs.getMeetName());
                        mapData.put("IA_R_REMARK",jhtMeetingWithBLOBs.getMeetName());
                        mapData.put("IA_R_IS_VALID","1");
                        mapData.put("IA_R_IS_PUBLIC","1");
                        mapData.put("MAXUSER",jhtMeetingWithBLOBs.getMaxUser().toString());
                        mapData.put("IA_R_ANONYMOUS","1");
                        mapData.put("APP","2");
                        mapData.put("IA_R_PWD_NORMAL",jhtMeetingWithBLOBs.getRoomPwd());
                        mapData.put("START_VALID_DATE",DateFormat.getStrDate(jhtMeetingWithBLOBs.getStartTime()));
                        mapData.put("END_VALID_DATE",DateFormat.getStrDate(jhtMeetingWithBLOBs.getEndTime()));
                        mapData.put("IA_CREATID",arrMould.get("IA_USERID").getAsString());  //创建人为uId
                        mapData.put("IA_MEETING_PERIOD",jhtMeetingWithBLOBs.getRoomTimeLimit());
                        mapData.put("IA_R_MESSAGE","10");
                        mapData.put("BANDWIDTH","100");
                        mapData.put("MAX_VIDEO_COUNT","24");
                        mapData.put("MAX_VOICE_COUNT","10");
                        mapData.put("LAYOUT","10");
                        mapData.put("LAYOUTURL","www.baidu.com");
//                        mapData.put("DEPT_ID",arrMould.get("deptid").getAsString());
                        mapData.put("DEPT_ID","33");
                        mapData.put("IS_FLASH_LIVE","1");
                        mapData.put("ROOM_TYPE","1");



                        Map map = new HashMap();
                        map.put("data",new Gson().toJson(mapData,Map.class));
                        String iactiveres = HttpClientUtil.doGsonPost(iactive.get("url").getAsString(), map, "UTF-8");
                        Map maps1 = (Map)JSON.parse(iactiveres);
                        i = (Integer)maps1.get("ret");
                        if ( i > 0) {
                            jhtMeetingWithBLOBs.setRoomId(maps1.get("ret").toString());
                        }
                        break;
                    case "liveuc":
                        String liveucres = wdLiveucPost(jsonObject.get("liveuc").getAsJsonObject(), jhtMeetingWithBLOBs, "1");
                        Map maps2 = (Map)JSON.parse(liveucres);
                        i = (Integer)maps2.get("ret");
                        if (i == 0){
                            //会议室
                            jhtMeetingWithBLOBs.setRoomId(maps2.get("ret").toString());
                        }
                        break;
                }

            }

            if (i >= 0){
                //新增接口
                int i1 = jhtMeetingMapper.insertSelective(jhtMeetingWithBLOBs);

                //判断是否提醒
                if ( i1 > 0  && !StringUtils.checkNull(jhtMeetingWithBLOBs.getIsAttend())  && jhtMeetingWithBLOBs.getIsAttend().equals("1")){
                    ContentReminder(request,jhtMeetingWithBLOBs,jhtMeetingWithBLOBs.getUserIds());
                }
            }

            toJson.setFlag(0);
            toJson.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-31
     * @方法介绍  网动公有版请求接口  jsonObject:企业号  jhtMeetingWithBLOBs：传递参数  isOp：1新增编辑  2删除
     */
    private String wdLiveucPost(JsonObject liveuc,JHTMeetingWithBLOBs jhtMeetingWithBLOBs,String isOp){
        Map<String,String> map = new HashMap();

        map.put("app","imm");

        //网动预先分配的账号
        map.put("orgid",liveuc.get("liveucID").getAsString());
        map.put("orgAdminUsername",liveuc.get("liveucAdminUsername").getAsString());
        map.put("orgAdminPassword",liveuc.get("liveucAdminPassword").getAsString());

        HttpPost post = null;
        switch (isOp){
            case "1":   //新增编辑
                //主持人
                map.put("hostUsername",jhtMeetingWithBLOBs.getHostUserId());
                map.put("hostPassword","0000");
                map.put("hostNickname",usersService.getUserNameById(jhtMeetingWithBLOBs.getHostUserId()));

                //会议室
                map.put("roomid",jhtMeetingWithBLOBs.getRoomId());   //0创建，其他则会修改会议室
                map.put("roomName",jhtMeetingWithBLOBs.getMeetName());
                map.put("roomPassword",jhtMeetingWithBLOBs.getRoomPwd());
                map.put("roomTimeLimit",jhtMeetingWithBLOBs.getRoomTimeLimit());

                //会议 开始 结束 时间
                map.put("startTime", DateFormat.getStrDate(jhtMeetingWithBLOBs.getStartTime()));
                map.put("endTime", DateFormat.getStrDate(jhtMeetingWithBLOBs.getEndTime()));

                //最大连接数
                map.put("maxUser",jhtMeetingWithBLOBs.getMaxUser().toString());

                //发送请求
                post = new HttpPost(hostmeeting);

                break;
            case "2":  //删除
                map.put("roomid",jhtMeetingWithBLOBs.getRoomId());
                //发送请求
                post = new HttpPost(deletemeeting);
                break;
        }

        //创建参数集合
        List<BasicNameValuePair> list = new ArrayList<BasicNameValuePair>();
        for (Map.Entry<String,String> map1:map.entrySet()) {
            list.add(new BasicNameValuePair(map1.getKey(), map1.getValue()));
        }

        try {
            //把参数放入请求对象，，post发送的参数list，指定格式
            post.setEntity(new UrlEncodedFormEntity(list, "UTF-8"));

            //添加请求头参数
            Integer time = DateFormat.getTime(DateFormat.getStrDate(new Date()));
            post.addHeader("timestamp",time.toString());

            CloseableHttpClient client = HttpClients.createDefault();
            //启动执行请求，并获得返回值
            CloseableHttpResponse response = client.execute(post);
            //得到返回的entity对象
            HttpEntity entity = response.getEntity();
            //把实体对象转换为string
            return EntityUtils.toString(entity, "UTF-8");

        }catch (Exception e){
            e.printStackTrace();
        }

        return "";
    }

    @Async
    public void ContentReminder(HttpServletRequest request, final JHTMeetingWithBLOBs jhtMeetingWithBLOBs , final String todoId){
        final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        final Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
        this.threadPoolTaskExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ContextHolder.setConsumerType("xoa" + sqlType);
                SmsBody smsBody = new SmsBody();
                smsBody.setFromId(jhtMeetingWithBLOBs.getUserId());
                smsBody.setContent("即会通视频会议！主题：" + jhtMeetingWithBLOBs.getMeetName());
                Date date = new Date();
                long dateLong = date.getTime()/1000;
                String strDate = String.valueOf(dateLong);
                Integer dateInt = Integer.valueOf(strDate.trim());
                smsBody.setSendTime(dateInt);
                smsBody.setIsAttach("0"); //无附件
                smsBody.setRemindUrl("/JHTMeeting/index");

                SysCode sysCode = new SysCode();
                sysCode.setCodeName("即会通视频会议");
                sysCode.setParentNo("SMS_REMIND");
                SysCode codeNoByNameAndParentNo = sysCodeMapper.getCodeNoByNameAndParentNo(sysCode);
                if (codeNoByNameAndParentNo != null) {
                    smsBody.setSmsType(codeNoByNameAndParentNo.getCodeNo());
                }

                String title = user.getUserName() + "：有提醒！";
                String context = "主题:"+jhtMeetingWithBLOBs.getMeetName();
                smsService.saveSms(smsBody, todoId, "1", "1", title, context, sqlType);
            }
        });
    }
}
