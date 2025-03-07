package com.xoa.service.sms.impl;


import cn.jiguang.common.ClientConfig;
import cn.jpush.api.JPushClient;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Message;
import cn.jpush.api.push.model.Options;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.audience.AudienceTarget;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosAlert;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;
import com.huawei.push.android.BadgeNotification;
import com.huawei.push.android.ClickAction;
import com.huawei.push.exception.HuaweiMesssagingException;
import com.huawei.push.message.AndroidConfig;
import com.huawei.push.messaging.HuaweiApp;
import com.huawei.push.messaging.HuaweiCredential;
import com.huawei.push.messaging.HuaweiMessaging;
import com.huawei.push.messaging.HuaweiOption;
import com.oppo.push.server.Target;
import com.xiaomi.xmpush.server.Constants;
import com.xiaomi.xmpush.server.Sender;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.voteItem.VoteItemMapper;
import com.xoa.dev.qywx.service.QywxService;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.notify.Notify;
import com.xoa.model.sms.*;
import com.xoa.model.users.Users;
import com.xoa.model.voteItem.VoteItem;
import com.xoa.service.sms.SmsService;
import com.xoa.service.todoList.TodolistService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.MachineCode;
import com.xoa.util.page.PageParams;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.MessageFormat;
import java.util.*;

/**
 * @作者：张航宁
 * @时间：2017/7/28
 * @介绍：实现类
 * @参数：
 */
@Service
public class SmsServiceImpl implements SmsService {

    @Resource
    private SmsMapper smsMapper;
    @Resource
    private SmsBodyMapper smsBodyMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private SysCodeMapper sysCodeMapper;
    @Resource
    private HttpServletRequest request;
    @Resource
    private NotifyMapper notifyMapper;
    @Resource
    private VoteItemMapper voteItemMapper;
    @Autowired
    private SysParaMapper sysParaMapper;
    @Resource
    private QywxService qywxService;

    @Autowired
    private TodolistService todolistService;
    @Resource
    private VivoPush vivoPush;
    @Resource
    private OppoPush oppoPush;
    @Resource
    private MeiZuPush meiZuPush;

    @Value("${xg_push_msg_android_key}")
    String androidKey;
    @Value("${xg_push_msg_android_sercetkey}")
    String androidSercetKey;
    @Value("${xg_push_msg_ios_key}")
    String iosKey;
    @Value("${xg_push_msg_ios_sercetkey}")
    String iosSercetKey;

    @Value("${xg_push_msg_ios_store_key}")
    String iosStoreKey;
    @Value("${xg_push_msg_ios_store_sercetkey}")
    String iosStoreSercetKey;

    @Value("${j_push_msg_key}")
    String JGKey;
    @Value("${j_push_msg_sercetkey}")
    String JGSercetKey;
    @Value("${j_push_msg_production}")
    boolean JGProduction;

    @Value("${j_push_msg_ios_store_key}")
    String JGIosStoreKey;
    @Value("${j_push_msg_ios_store_sercetkey}")
    String JGIosStoreSercetKey;

    @Value("${App_Id_Huawei_Key}")
    String AppIdKey;
    @Value("${SecretKey}")
    String SecretKey;
    @Value("${Huawei_badge_class}")
    String Huawei_badge_class;

    @Value("${APP_ID}")
    String APPIdXiaomi;
    @Value("${APP_KEY}")
    String APPKeyXiaomi;
    @Value("${Xiaomi_badge_class}")
    String Xiaomi_badge_class;
    @Value("${AppSecretXiaomi}")
    String AppSecretXiaomi;

    @Value("${App_Id_Vivo}")
    String AppIdVivo;
    @Value("${App_Key_Vivo}")
    String AppKeyVivo;
    @Value("${AppSecretVivo}")
    String AppSecretVivo;

    @Value("${App_Id_Huawei_Key}")
    public String appId;// = "100221479";

    @Value("${SecretKey}")
    public String appSecret;
    @Autowired
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    //用户在华为开发者联盟申请的appId和appSecret（会员中心->应用管理，点击应用名称的链接）
    //private static String appSecret = "1ef4fa0d6b7cc6b06f4153579b478856";
    //private static String appId = "100221479";

    /**
     * 获取认证Token的URL
     */
    private static String tokenUrl = "https://login.cloud.huawei.com/oauth2/v2/token";
    /**
     * 应用级消息下发API
     */
    // 华为旧版推送接口
    //private static String apiUrl = "https://api.push.hicloud.com/pushsend.do";
    private static  String apiUrl = "https://push-api.cloud.huawei.com/v1/100221479/messages:send";
    private static String accessToken;//下发通知消息的认证Token
    private static long tokenExpiredTime;  //accessToken的过期时间


    /**
     * @作者：张航宁
     * @时间：2017/7/28
     * @介绍：保存提醒
     * @参数：
     */
    @Override
    public ToJson<SmsBody> saveSms(final SmsBody smsBody, final String toIds, final String remind, final String tuisong, final String title, final String context, final String sqlType) {

        // SysUserPushSerive sysUserPushSerive=new SysUserPushSerive();
        ToJson<SmsBody> json = new ToJson<SmsBody>();
        SmsBody smsBody1 = new SmsBody();
        Long curTime = System.currentTimeMillis();
        String jixiema = null;
        String[] split = toIds.split(",");
        List<String> list = new ArrayList<>();
        for (int i = 0; i < split.length; i++) {
            for (int j = i + 1; j < split.length; j++) {
                if (split[i] == split[j]) {
                    j = ++i;
                }
            }
            list.add(split[i]);
        }
        /* System.out.println("0=||============>++当前更新时间:"+curTime);*/
        SysPara para = sysParaMapper.querySysPara("PUSH_MNO");
        if (para != null && !StringUtils.checkNull(para.getParaValue())) {
            jixiema = para.getParaValue().substring(0, 12);
        } else {
            jixiema = MachineCode.get16CharMacs() == null ? "" : MachineCode.get16CharMacs().get(0);
        }

        //String jixiema = MachineCode.get16CharMacs().get(0);
        /*System.out.println("0=||===============》推送机器码："+jixiema);*/
        try {
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");

            boolean flag = true;
            SysCode sysCode = sysCodeMapper.getSmsIsRemind(smsBody.getSmsType());
            if (sysCode != null) {
            if (Integer.parseInt(sysCode.getIsCan()) == 1) {
                if (!StringUtils.checkNull(toIds)) {
                    if(!StringUtils.checkNull(remind)){
                    if (remind.equals("1")) {//事务提醒标志
                        int a = 0;
                        if ("1".equals(smsBody.getEditFlag())) {
                            Map<String, Object> map = new HashMap<>();
                            map.put("smsType", smsBody.getSmsType());
                            map.put("remindUrl", smsBody.getRemindUrl());
                            smsBody1 = smsBodyMapper.querySmsBodyCon(map);
                            if (smsBody1 == null) {
                                if (smsBody.getBodyId() != null) {
                                    smsBody.setBodyId(null);
                                }
                                a = smsBodyMapper.insertSelective(smsBody);
                            } else {
                                smsBody.setBodyId(smsBody1.getBodyId());
                                String time = DateFormatUtils.formatDate(new Date());
                                smsBody.setSendTime(DateFormatUtils.getNowDateTime(time));
                                a = smsBodyMapper.updateByPrimaryKeySelective(smsBody);
                            }
                        } else {
                            if (smsBody.getRemindUrl().contains("email/emailDetail?id=")) {
                                String[] splitt = smsBody.getRemindUrl().split("=");
                                String[] split1 = splitt[1].split(",");
                                for (int i = 0; i < split.length; i++) {
                                    String s = split[i];
                                    smsBody.setRemindUrl("email/emailDetail?id=" + split1[i]);
                                    a = smsBodyMapper.insertSelective(smsBody);
                                    Sms sms = new Sms();
                                    sms.setToId(s);
                                    if ("1".equals(smsBody.getEditFlag()) && smsBody1 != null) {
                                        sms.setBodyId(smsBody1.getBodyId());
                                    } else {
                                        sms.setBodyId(smsBody.getBodyId());
                                    }
                                    sms.setRemindFlag("1");
                                    sms.setDeleteFlag("0");
                                    sms.setRemindTime((int) (System.currentTimeMillis() / 1000));
//                                    smsList.add(sms);
                                    Map<String, Object> map = new HashMap<>();
                                    map.put("toId", s);
                                    map.put("bodyId", sms.getBodyId());
                                    Sms temp = smsMapper.selSmsByCon(map);
                                    if (temp == null) {
                                        smsMapper.insertSelective(sms);
                                        // 企业微信推送
                                        qywxService.sendMsg(Collections.singletonList(s), title, context,"/ewx/emailDetail?flag=inbox&emailID="+split1[i], false);
                                    } else {
                                        temp.setRemindFlag("1");
                                        temp.setRemindTime((int) (System.currentTimeMillis() / 1000));
                                        smsMapper.updSmsById(temp);
                                    }
                                    json.setMsg("ok");
                                    if (i < split.length - 1) {
                                        smsBody.setBodyId(null);
                                    }
                                }
                                flag = false;
                            } else if (list.size() > 1) {

                                // String[] splitToId=smsBody.getToId().split(",");
                                for (int i = 0; i < split.length; i++) {
                                    String s = split[i];
                                    smsBody.setToId(split[i]);
                                    a = smsBodyMapper.insertSelective(smsBody);
                                    Sms sms = new Sms();
                                    sms.setToId(s);
                                    if ("1".equals(smsBody.getEditFlag()) && smsBody1 != null) {
                                        sms.setBodyId(smsBody1.getBodyId());
                                    } else {
                                        sms.setBodyId(smsBody.getBodyId());
                                    }
                                    sms.setRemindFlag("1");
                                    sms.setDeleteFlag("0");
                                    if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue()) && smsBody.getRemindUrl().contains("/workflow/work/workformPreView")){
                                        sms.setDeleteFlag("3");
                                    }
                                    sms.setRemindTime((int) (System.currentTimeMillis() / 1000));
//                                    smsList.add(sms);
                                    Map<String, Object> map = new HashMap<>();
                                    map.put("toId", s);
                                    map.put("bodyId", sms.getBodyId());
                                    Sms temp = smsMapper.selSmsByCon(map);
                                    if (temp == null) {
                                        smsMapper.insertSelective(sms);
                                    } else {
                                        temp.setRemindFlag("1");
                                        temp.setRemindTime((int) (System.currentTimeMillis() / 1000));
                                        smsMapper.updSmsById(temp);
                                    }
                                    json.setMsg("ok");
                                    if (i < split.length - 1) {
                                        smsBody.setBodyId(null);
                                    }
                                }
                                flag = false;
                            } else {
                                a = smsBodyMapper.insertSelective(smsBody);
                            }
                        }
                        if (a > 0) {
                           /* String[] split = toIds.split(",");
                            List<String> list = new ArrayList<>();
                            for (int i = 0; i < split.length; i++) {
                                for (int j = i + 1; j < split.length; j++) {
                                    if (split[i] == split[j]) {
                                        j = ++i;
                                    }
                                }
                                list.add(split[i]);
                            }*/
//                            List<Sms> smsList = new ArrayList<Sms>();
                            if (flag) {
                                for (String toId : list) {
                                    Sms sms = new Sms();
                                    sms.setToId(toId);
                                    if ("1".equals(smsBody.getEditFlag()) && smsBody1 != null) {
                                        sms.setBodyId(smsBody1.getBodyId());
                                    } else {
                                        sms.setBodyId(smsBody.getBodyId());
                                    }
                                    sms.setRemindFlag("1");
                                    sms.setDeleteFlag("0");
                                    if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue()) && smsBody.getRemindUrl().contains("/workflow/work/workformPreView")){
                                        sms.setDeleteFlag("3");
                                    }
                                    sms.setRemindTime((int) (System.currentTimeMillis() / 1000));
//                                smsList.add(sms);
                                    Map<String, Object> map = new HashMap<>();
                                    map.put("toId", toId);
                                    map.put("bodyId", sms.getBodyId());
                                    Sms temp = smsMapper.selSmsByCon(map);
                                    if (temp == null) {
                                        smsMapper.insertSelective(sms);
                                    } else {
                                        temp.setRemindFlag("1");
                                        temp.setRemindTime((int) (System.currentTimeMillis() / 1000));
                                        smsMapper.updSmsById(temp);
                                    }
                                    json.setMsg("ok");
                                }
                            }

                            //判断是否关闭消息推送和天气预报等需要连接外网的功能（0-关闭，1-开启）
                            SysPara msgPushSet = sysParaMapper.querySysPara("MSG_PUSH_SET");
                            if(Objects.isNull(msgPushSet) || "1".equals(msgPushSet.getParaValue().trim())){

                                // 手机推送
                                List<String> list2 = new ArrayList<>();
                                for (int i = 0; i < split.length; i++) {
                                    for (int j = i + 1; j < split.length; j++) {
                                        if (split[i] == split[j]) {
                                            j = ++i;
                                        }
                                    }
                                    if (split[i] != null && !split[i].equals("")) {
                                        list2.add(split[i]);
                                    }
                                }
                                String[] arrayResult = (String[]) list2.toArray(new String[list2.size()]);

                                //极光推送list
                                List<String> jgList = new ArrayList<>();
                                // 推送的真实用户id串
                                List<String> jgPushUserIds = new ArrayList<>();

                                //目标设备Token集合
                                com.alibaba.fastjson.JSONArray deviceTokens = new com.alibaba.fastjson.JSONArray();
                                //for (int i = 0,size = toIds.length(); i < size; i++) {
                                List<String> tokens = new ArrayList<String>();
                                List<String> hwList = new ArrayList<>();
                                List<String> xmList = new ArrayList<>();
                                Map<Target, com.oppo.push.server.Notification> opMap = new HashMap();
                                List<String> mzList = new ArrayList<>();
                                Set<String> vivoSet = new HashSet<>();
                                //com.oppo.push.server.Notification notification=oppoPush.getNotification(context,title,smsBody);
                                for (int i1 = 0; i1 < arrayResult.length; i1++) {

                                    //获取推送人的icqNo，即pushtoken
                                    Users userAll = usersMapper.getUsersByuserId(arrayResult[i1]);
                                    if (userAll != null) {
                                        if (!StringUtils.checkNull(userAll.getMobileType())) {
                                            if (userAll.getMobileType().equals("2")) {
                                                String account = jixiema + arrayResult[i1] + sqlType;
                                                xmList.add(account);
                                            } else if (userAll.getMobileType().equals("1")) {
                                                String token = userAll.getIcqNo();
                                                if (StringUtils.checkNull(token)) {
                                                    String account = jixiema + arrayResult[i1] + sqlType;
                                                    jgList.add(account);
                                                    jgPushUserIds.add(arrayResult[i1]);
                                                } else {
                                                    tokens.add(token);
                                                    deviceTokens.add(token);
                                                    hwList.add(token);
                                                    // Daiban db=todolistService.readTotal(userAll.getUserId(),sqlType,request,"");
                                                    // this.testNotificationMessageSend(token, title, context, 1, smsBody);
                                                }
                                            } else if (userAll.getMobileType().equals("3")) {
                                                String registerId = userAll.getIcqNo();
                                                if (StringUtils.checkNull(registerId)) {
                                                    String account = jixiema + arrayResult[i1] + sqlType;
                                                    jgList.add(account);
                                                    jgPushUserIds.add(arrayResult[i1]);
                                                } else {
                                                    com.oppo.push.server.Notification notification = oppoPush.getNotification(context, title, smsBody);
                                                    opMap.put(Target.build(registerId), notification);
                                                }
                                            } else if (userAll.getMobileType().equals("4")) {
                                                String regId = userAll.getIcqNo();
                                                if (StringUtils.checkNull(regId)) {
                                                    String account = jixiema + arrayResult[i1] + sqlType;
                                                    jgList.add(account);
                                                    jgPushUserIds.add(arrayResult[i1]);
                                                } else {
                                                    vivoSet.add(regId);
                                                }

                                            } else if (userAll.getMobileType().equals("5")) {
                                                String account = jixiema + arrayResult[i1] + sqlType;
                                                mzList.add(account);
                                            } else if (userAll.getMobileType().equals("0")) {
                                                String account = jixiema + arrayResult[i1] + sqlType;
                                                jgList.add(account);
                                                jgPushUserIds.add(arrayResult[i1]);
                                            }
                                        } else {
                                            String account = jixiema + arrayResult[i1] + sqlType;
                                            jgList.add(account);
                                            jgPushUserIds.add(arrayResult[i1]);
                                        }

                                        /* else {
                                            String token = userAll.getIcqNo();
                                            //String token = null;
                                            //  String token = toIds[i];
                                            if (StringUtils.checkNull(token)) {
                                                String account = jixiema + arrayResult[i1] + sqlType;
                                                jgList.add(account);
                                                jgPushUserIds.add(arrayResult[i1]);
                                            } else {
                                                tokens.add(token);
                                                deviceTokens.add(token);
                                                // Daiban db=todolistService.readTotal(userAll.getUserId(),sqlType,request,"");
                                                this.testNotificationMessageSend(token, title, context, 1, smsBody);

                                            }
                                        }*/
                                    }
                                }


                                if (hwList.size() > 0) {
                                    this.testNotificationMessageSend(hwList, title, context, 1, smsBody);
                                }
                                if (xmList.size() > 0) {
                                    this.sendMessageToAliases(xmList, title, context, smsBody);
                                }
                                if (opMap.size() > 0) {
                                    oppoPush.getNotifications(opMap);
                                }
                                if (vivoSet.size() > 1) {
                                    vivoPush.singeSend(vivoSet, title, context, smsBody);
                                } else if (vivoSet.size() == 1) {
                                    vivoPush.singeSendOne(vivoSet, title, context, smsBody);
                                }
                                if (mzList.size() > 0) {
                                    meiZuPush.testVarnishedMessagePushByAlias(mzList, context, title, smsBody);
                                }
                                //华为旧版推送(判断是否有新版本的appid和secret密钥\\\\\\\\\\\\\\\\\ 如果没有 用旧版本的推送)
                                if (tokens.size() > 0) {
                                    if (StringUtils.checkNull(AppIdKey) && StringUtils.checkNull(SecretKey)) {
                                        sendPushMessage(title, context, deviceTokens);
                                    }
                                }

                                //2022-05-18修改：极光推送两次，一次通用版，一次IOS商店版
                                if (jgList.size() > 5) {

                                    //极光推送数组(适配推送结构) 4CCC6A6247B8 891 1001
                                    String[] jgArray = jgList.toArray(new String[jgList.size()]);
                                    try {
                                        //极光推送通用版（ios+andriod）
                                        JPushClient jpushClient = new JPushClient(JGSercetKey, JGKey, null, ClientConfig.getInstance());
                                        PushPayload payload = buildPushObject_all_alias_alert(jgArray, title, context, 1, smsBody);
                                        PushResult result = jpushClient.sendPush(payload);
                                    }catch (Exception e){
                                        e.printStackTrace();
                                    }

                                    try {
                                        //极光推送商店版（ios）
                                        JPushClient jpushClientIOS = new JPushClient(JGIosStoreSercetKey, JGIosStoreKey, null, ClientConfig.getInstance());
                                        PushPayload payloadIOS = buildPushObject_all_alias_alert(jgArray, title, context, 1, smsBody);
                                        PushResult resultIOS = jpushClientIOS.sendPush(payloadIOS);
                                    }catch (Exception e){
                                        e.printStackTrace();
                                    }

                                } else if (jgList.size() <= 5 && jgList.size() > 0) { // 判断是否小于5人 如果小于5人 查询出所有人的待办进行设置推送
                                    for (int k = 0; k < jgPushUserIds.size(); k++) {
                                        Map<String, Object> smsCountmap = new HashMap<String, Object>();
                                        // 查询未确认提醒的
                                        smsCountmap.put("toId", jgPushUserIds.get(k));
                                        smsCountmap.put("remindFlag", "3");
                                        Date date = new Date();
                                        String s = DateFormatUtils.formatDate(date);
                                        Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
                                        smsCountmap.put("sendTime", nowDateTime);
                                        Integer smsBodyCountByMap = smsBodyMapper.getSmsBodyCountByMap(smsCountmap);

                                        //极光推送数组(适配推送结构) 4CCC6A6247B8 891 1001
                                        String[] jgArrayNew = new String[1];
                                        jgArrayNew[0] = jgList.get(k);

                                        try {
                                            //极光推送通用版（ios+andriod）
                                            JPushClient jpushClient = new JPushClient(JGSercetKey, JGKey, null, ClientConfig.getInstance());
                                            PushPayload payload = buildPushObject_all_alias_alert(jgArrayNew, title, context, smsBodyCountByMap, smsBody);
                                            PushResult result = jpushClient.sendPush(payload);
                                        } catch (Exception r) {
                                            r.printStackTrace();
                                        }

                                        try {
                                            //极光推送商店版（ios）
                                            JPushClient jpushClientIOS = new JPushClient(JGIosStoreSercetKey, JGIosStoreKey, null, ClientConfig.getInstance());
                                            PushPayload payloadIOS = buildPushObject_all_alias_alert(jgArrayNew, title, context, smsBodyCountByMap, smsBody);
                                            PushResult resultIOS = jpushClientIOS.sendPush(payloadIOS);
                                        } catch (Exception r) {
                                            r.printStackTrace();
                                        }
                                    }
                                }

                            }

                        }
                    }}
                }
            }
        }

        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("error");
        }

        return json;

    }

    /**
     * @作者：张航宁
     * @时间：2017/7/28
     * @介绍：提醒类型查询
     * @参数：queryType 1 未确认提醒 2已接收提醒 3已发送提醒
     */
    @Override
    public ToJson<SmsBody> getSmsBodies(HttpServletRequest request, Integer queryType, Integer page, Integer pageSize) {
        ToJson<SmsBody> json = new ToJson<SmsBody>();
        PageParams pageParams = new PageParams();
        pageParams.setPageSize(pageSize);
        pageParams.setPage(page);
        pageParams.setUseFlag(true);
        String smsType=request.getParameter("smsType");


        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("page", pageParams);
            if(!StringUtils.checkNull(smsType)){
                map.put("smsType", smsType);
            }
            // 查询未确认提醒的
            if (queryType == 1) {
                map.put("toId", sessionUser.getUserId());
                map.put("remindFlag", "3");
            }
            // 查询所有接收到的
            if (queryType == 2) {
                map.put("toId", sessionUser.getUserId());
            }
            // 查询所有发送的
            if (queryType == 3) {
                map.put("fromId", sessionUser.getUserId());
            }
            Date date = new Date();
            String s = DateFormatUtils.formatDate(date);
            Integer nowDateTime = DateFormatUtils.getNowDateTime(s);
            map.put("sendTime", nowDateTime);
            List<SmsBody> smsBodyByMap = smsBodyMapper.getSmsBodyByMap(map);
            if (smsBodyByMap != null && smsBodyByMap.size() > 0) {
                for (SmsBody smsBody : smsBodyByMap) {
                    if (smsBody != null) {
                        if (!StringUtils.checkNull(smsBody.getFromId())) {
                            String usernameByUserId = usersMapper.getUsernameByUserId(smsBody.getFromId());
                            smsBody.setFromName(usernameByUserId);
                        }
                        if (!StringUtils.checkNull(smsBody.getToId())) {
                            String usernameByUserId = usersMapper.getUsernameByUserId(smsBody.getToId());
                            smsBody.setToName(usernameByUserId);
                        }
                        if (!StringUtils.checkNull(smsBody.getSmsType())) {
                            SysCode sms_remind = sysCodeMapper.getSingleCode("SMS_REMIND", smsBody.getSmsType());
                            if (sms_remind != null && sms_remind.getCodeName() != null) {
                                smsBody.setSmsTypeName(sms_remind.getCodeName());
                            } else {
                                smsBody.setSmsTypeName("类型不存在");
                            }

                        }
                    }
                }
            }
            map.remove("page");
            Integer smsBodyCountByMap = smsBodyMapper.getSmsBodyCountByMap(map);
            json.setTotleNum(pageParams.getTotal());
            json.setObj(smsBodyByMap);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    public ToJson classification(HttpServletRequest request,Integer queryType){
        ToJson json = new ToJson();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        List<SysCode> list = sysCodeMapper.getCodeRemind();
        List<SmsBodyIO> smsBodyIOList = new ArrayList<SmsBodyIO>();
        Map<String,Object> map=new HashMap<>();
        if (queryType == 1) {
            map.put("toId", user.getUserId());
            map.put("remindFlag", "3");
        }
        // 查询所有接收到的
        if (queryType == 2) {
            map.put("toId", user.getUserId());
        }
        // 查询所有发送的
        if (queryType == 3) {
            map.put("fromId", user.getUserId());
        }
        for (int i = list.size() - 1; i >= 0; i--) {
            map.put("smsType",list.get(i).getCodeNo());
            List<SmsBody> smsBodyByMap = smsBodyMapper.getSmsBodyByMap(map);
            SmsBodyIO smsBody = new SmsBodyIO();
            if (smsBodyByMap.size() > 0) {
               if(!StringUtils.checkNull(list.get(i).getCodeNo())){
                   if(!smsBodyByMap.get(0).getRemindUrl().contains("?")){
                       smsBodyByMap.get(0).setRemindUrl(smsBodyByMap.get(0).getRemindUrl() + "?");
                   }
                   smsBodyByMap.get(0).setRemindUrl(smsBodyByMap.get(0).getRemindUrl() + "&bodyId=" + smsBodyByMap.get(0).getBodyId());
                   String smsTypeName = list.get(i).getCodeName();
                   if (locale.equals("en_US")) {
                       smsTypeName = list.get(i).getCodeName1();
                   } else if (locale.equals("zh_TW")) {
                       smsTypeName = list.get(i).getCodeName2();
                   }
                   switch (Integer.parseInt(list.get(i).getCodeNo())) {
                       case 0:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 3:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 4:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 6:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 8:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 10:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 21:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 22:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/publicFile.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 23:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 26:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 28:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 29:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 30:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 31:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 34:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_announcement.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 64:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 78:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 2:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 25:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                      /* case 20:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;*/
                       case 14:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/newspaper.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 1:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_announcement.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 7:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName("工作流");
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_backlog.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 18:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 19:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 70:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 11:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/toupiao.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 71:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/duchaduban.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 91:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 92:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 72:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 5:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/richeng.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 13:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 27:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/leaderActiv.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 24:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/bangongyongpinsl.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 16:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/publicFile.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 17:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/networkDisk.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 77:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/zhiban.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 32:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/dispatcher.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 33:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/thirdSystem.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 83:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/thirdSystem.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 35:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 9:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 73:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_email_14.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 81:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 74:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 20:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 75:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 76:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/rizhi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 79:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/huiyi.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 12:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 15:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 82:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/task/taskremind.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 84:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/richeng.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 86:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/sidebar_icon_remind_backlog.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 88:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/study.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 90:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/psd.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 89:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/mine_heart.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                       case 97:
                           smsBody.setSmsType(list.get(i).getCodeNo());
                           smsBody.setSmsTypeName(smsTypeName);
                           smsBody.setSmsTypeIcon("/img/main_img/app/s0.png");
                           smsBody.setSmsCount(smsBodyByMap.size());
                           smsBody.setFromName(usersMapper.seleById(smsBodyByMap.get(0).getFromId()).getUserName());
                           smsBody.setContent(smsBodyByMap.get(0).getContent());
                           smsBody.setSendTimeStr(smsBodyByMap.get(0).getSendTimeStr());
                           smsBody.setRemindUrl(smsBodyByMap.get(0).getRemindUrl());
                           smsBodyIOList.add(smsBody);
                           break;
                   }
               }
            } else {
                list.remove(i);
            }
        }
        json.setData(smsBodyIOList);
        json.setMsg("ok");
        json.setFlag(0);
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新删除状态（即页面中的删除操作）
     * @参数：request
     */
    //之前通过bodyId进行删除(修改状态) 现在用smsId ----刘景龙
    @Override
    public ToJson<Sms> updateDeleteFlag(HttpServletRequest request, String deleteFlag, String smsIds) {
        ToJson<Sms> json = new ToJson<Sms>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String[] bodyIdsArr = null;
            StringBuffer sb1=new StringBuffer();
            StringBuffer sb4=new StringBuffer();
            String[] smsIds1 = null;
            String[] smsIds4 = null;
            List<Sms> smsList=new ArrayList<>();
            Map<String,String> map=new HashMap<>();
            if (!StringUtils.checkNull(smsIds)) {
                bodyIdsArr = smsIds.split(",");
               smsList= smsMapper.selectByBodyIds(bodyIdsArr);
                for (Sms sms : smsList) {
                   if(Integer.valueOf(sms.getDeleteFlag())==0){
                       sb1.append(sms.getSmsId()+",");
                   }else if(Integer.valueOf(sms.getDeleteFlag())==1||Integer.valueOf(sms.getDeleteFlag())==2){
                       sb4.append(sms.getSmsId()+",");
                   }
                }
            }
            if(!StringUtils.checkNull(sb1.toString())){
                smsIds1=sb1.toString().split(",");
                smsMapper.updateDeleteFlag(sessionUser.getUserId(), deleteFlag, smsIds1);
            }
            if(!StringUtils.checkNull(sb4.toString())){
                smsIds4=sb4.toString().split(",");
                smsMapper.updateDeleteFlags(sessionUser.getUserId(), deleteFlag, smsIds4);
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：更新阅读状态
     * @参数：remindFlag bodyIds
     */
    //之前是通过bodyIds进行修改状态 现在用smsIds修改状态-----刘景龙
    @Override
    public ToJson<Sms> updateRemindFlag(HttpServletRequest request, String remindFlag, String smsIds) {
        ToJson<Sms> json = new ToJson<Sms>();
        String smsType=request.getParameter("smsType");
        String queryType=request.getParameter("queryType");
        String bodyIds = request.getParameter("bodyIds");

        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String[] smsIdsArr = null;
            String userId=sessionUser.getUserId();
            StringBuffer sb=new StringBuffer();
            if (!StringUtils.checkNull(smsIds)) {
                smsIdsArr = smsIds.split(",");
                smsMapper.updateRemindFlag(userId, remindFlag,smsIdsArr);
            }else if(!StringUtils.checkNull(smsType)){
                Map<String,Object> map=new HashMap<>();
                //查询所有未确认的
                if (Integer.valueOf(queryType) == 1) {
                    map.put("toId", userId);
                    map.put("remindFlag", "3");
                }
                // 查询所有接收到的
                if (Integer.valueOf(queryType) == 2) {
                    map.put("toId", userId);
                }
                if(!"all".equals(smsType)){
                    map.put("smsType",smsType);
                }
                List<SmsBody> smsBodyList=smsBodyMapper.getSmsBodyByMap(map);
                for (SmsBody smsBody : smsBodyList) {
                    sb.append(smsBody.getSmsId()+",");
                }
                smsIdsArr=sb.toString().split(",");
                smsMapper.updateRemindFlag(userId, remindFlag,smsIdsArr);
            }else if (StringUtils.checkNull(smsIds)){  //页面传参没改为smsIds  用bodyIds进行查询并修改状态  ---马东辉
                if (bodyIds!=null){
                    Map map = new HashMap();
                    map.put("toId", userId);
                    String[] split = bodyIds.split(",");
                    String smsArr= null;
                    for (String s : split) {
                        map.put("bodyId", s);
                        Sms sms = smsMapper.selSmsByCon(map);
                        smsArr = sms +""+ sms.getSmsId()+",";
                        map.remove("bodyId");
                    }
                    smsMapper.updateRemindFlag(userId, remindFlag, smsArr.split(","));
                }

            }
           // smsMapper.updateRemindFlag(sessionUser.getUserId(), remindFlag, bodyIdsArr != null && bodyIdsArr.length == 0 ? null : bodyIdsArr);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有已读
     * @参数：request
     */
    //刘景龙
    @Override
    public ToJson<Sms> deleteByRemind(HttpServletRequest request, String deleteType) {
        ToJson<Sms> json = new ToJson<Sms>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String smsType=request.getParameter("smsType");
            if(!StringUtils.checkNull(smsType)){
                if ("1".equals(deleteType)) {
                    smsMapper.deleteByRemind("1", "0",smsType,null,sessionUser.getUserId());
                    smsMapper.deleteByRemind("4", "2",smsType,null,sessionUser.getUserId());
                } else if ("2".equals(deleteType)) {
                    smsMapper.deleteByRemind("2", "0",smsType,sessionUser.getUserId(),null);
                    smsMapper.deleteByRemind("4", "1",smsType,sessionUser.getUserId(),null);
                }
            }else {
                if ("1".equals(deleteType)) {
                    smsMapper.deleteByRemind("1", "0",null,null,sessionUser.getUserId());
                    smsMapper.deleteByRemind("4", "2",null,null,sessionUser.getUserId());
                } else if ("2".equals(deleteType)) {
                    smsMapper.deleteByRemind("2", "0",null,sessionUser.getUserId(),null);
                    smsMapper.deleteByRemind("4", "1",null,sessionUser.getUserId(),null);
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：删除所有收信人已删除的
     * @参数：request
     */
    @Override
    public ToJson<Sms> deleteByDelFlag(HttpServletRequest request) {
        ToJson<Sms> json = new ToJson<Sms>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String smsType=request.getParameter("smsType");
            if (sessionUser != null && !StringUtils.checkNull(sessionUser.getUserId())) {
                if(!StringUtils.checkNull(smsType)){
                    smsMapper.deleteByDelFlag(sessionUser.getUserId(),smsType);
                }else {
                    smsMapper.deleteByDelFlag(sessionUser.getUserId(),null);
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/2
     * @介绍：设置已读
     * @参数：request bodyId
     */
    @Override
    public ToJson<Sms> setRead(HttpServletRequest request, Integer bodyId) {
        ToJson<Sms> json = new ToJson<Sms>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            if (sessionUser != null && !StringUtils.checkNull(sessionUser.getUserId())) {
                if (bodyId != null && bodyId != 0) {
                    smsMapper.setRead(sessionUser.getUserId(), bodyId);
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * @作者：张航宁
     * @时间：2017/8/3
     * @介绍：多条件查询
     * @参数：orderBy 排序字段 sortType 升序或降序 opeType 查询类型 1是查询 2是导出
     */
    @Override
    public ToJson<SmsBody> querySmsBody(HttpServletRequest request, HttpServletResponse response, String toIds, String fromIds, String smsType, String beginDate, String endDate, String content, String orderBy, String sortType, String opeType, Integer page,
                                        Integer pageSize, boolean useFlag) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<SmsBody> json = new ToJson<SmsBody>();
        Map<String, Object> map = new HashMap<String, Object>();
   /*     PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);*/
        if (page != null && pageSize != null) {
            page = (page - 1) * pageSize;
            map.put("page", page);
            map.put("pageSize", pageSize);
        } else {
            map.put("page", 0);
            map.put("pageSize", 100);
        }

        if(opeType.equals("2")){//导出不限制条数
            map.put("pageSize", null);
        }
        List<SmsBody> smsBodies = new ArrayList<SmsBody>();
        try {

            if (toIds != null) {
                String[] split = toIds.split(",");
                if (split.length > 0 && !"".equals(split[0])) {
                    map.put("toIds", split);
                } else {
                    map.put("toIds", null);
                }
                map.put("deleteFlag", 0);
                if (!"admin".equals(users.getByname())) {
                    String[] fromids = {users.getUserId()};
                    map.put("fromIds", fromids);
                    if (split.length <= 0 && !"".equals(split[0])) {
                        map.put("deleteFlag", 2);
                    }
                }
            }
            if (fromIds != null) {
                String[] split = fromIds.split(",");
                if (split.length > 0 && !"".equals(split[0])) {
                    map.put("fromIds", split);
                } else {
                    map.put("fromIds", null);
                }
                map.put("deleteFlag", 2);
                if (!"admin".equals(users.getByname())) {
                    String[] toids = {users.getUserId()};
                    map.put("toIds", toids);
                    if (split.length <= 0 && !"".equals(split[0])) {
                        map.put("deleteFlag", 0);
                    }
                }
            }


            if (!StringUtils.checkNull(beginDate)) {
                map.put("beginDate", DateFormat.getDateTime(beginDate));
            }
            if (!StringUtils.checkNull(endDate)) {
                map.put("endDate", DateFormat.getDateTime(endDate));
            } else {
                map.put("endDate", System.currentTimeMillis() / 1000);
            }
            if (!StringUtils.checkNull(content)) {
                map.put("content", content);
            }
            if (!StringUtils.checkNull(smsType)) {
                map.put("smsType", smsType);
            }
            if (!StringUtils.checkNull(orderBy)) {
                map.put("orderBy", orderBy);
            }
            if (!StringUtils.checkNull(sortType)) {
                map.put("sortType", sortType);
            }

            smsBodies = smsBodyMapper.querySmsBody(map);
            // 获取发送人或者收信人的名称
            if (smsBodies != null && smsBodies.size() > 0) {
                for (SmsBody smsBody : smsBodies) {
                    if (smsBody != null) {
                        if (!StringUtils.checkNull(smsBody.getFromId())) {
                            String usernameByUserId = usersMapper.getUsernameByUserId(smsBody.getFromId());
                            smsBody.setFromName(usernameByUserId);
                        }
                        if (!StringUtils.checkNull(smsBody.getToId())) {
                            String usernameByUserId = usersMapper.getUsernameByUserId(smsBody.getToId());
                            smsBody.setToName(usernameByUserId);
                        }
                        if (!StringUtils.checkNull(smsBody.getSmsType())) {
                            SysCode sms_remind = sysCodeMapper.getSingleCode("SMS_REMIND", smsBody.getSmsType());
                            if (sms_remind != null && sms_remind.getCodeName() != null) {
                                smsBody.setSmsTypeName(sms_remind.getCodeName());
                            } else {
                                smsBody.setSmsTypeName("类型不存在");
                            }

                        }
                    }
                }
            }
            if ("1".equals(opeType)) {
                json.setObj(smsBodies);
                json.setTotleNum(smsBodyMapper.querySmsBodyCount(map));
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();

            json.setMsg("err");
            json.setFlag(1);
        } finally {
            if ("2".equals(opeType)) {
                try {
                    HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("内部提醒", 4);
                    String[] secondTitles = {"类别", "发送人", "内容", "发送时间", "提醒"};
                    String[] beanProperty = {"smsTypeName", "fromName", "content", "sendTimeStr", "remindStr"};
                    if (toIds != null) {
                        secondTitles[1] = "收信人";
                        beanProperty[1] = "toName";

                    }
                    if (fromIds != null) {
                        secondTitles[1] = "发送人";
                        beanProperty[1] = "fromName";
                    }
                    HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                    HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, smsBodies, beanProperty);
                    String filename = "内部提醒.xls";
                    filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                    response.setContentType("application/vnd.ms-excel");
                    response.setHeader("content-disposition", "attachment;filename=" + filename);
                    ServletOutputStream out = response.getOutputStream();
                    workbook.write(out);
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        }
        return json;
    }

    @Override
    public void setRead(HttpServletRequest request, String url) {
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            if (sessionUser != null && !StringUtils.checkNull(sessionUser.getUserId())) {
                if (!StringUtils.checkNull(url)) {
                    smsMapper.setReadByUrl(sessionUser.getUserId(), url);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
    }

    @Override
    public void updatequerySmsByType(String type, String userId, String id) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("type", type);
        map.put("userId", userId);
        map.put("id", id);
        try {
            List<Sms> smsList = smsMapper.querySmsByType(map);
            if (smsList != null && smsList.size() > 0) {
                for (Sms sms : smsList) {
                    smsMapper.setReadByUrl(sms.getToId(), sms.getUrl());
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void updateEndTimeList(HttpServletRequest request, String userId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userId)) {
            userId = user.getUserId();
        }
        List<Notify> notifies = notifyMapper.selectNotifyEndTime(DateFormat.getCurrentTime2());
        List<VoteItem> voteItems = voteItemMapper.selectVoteEndTime(DateFormat.getCurrentTime2());
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("userId", user.getUserId());
        map.put("flag", "1");
        List<SmsBodyExtend> smsBodyExtendList = smsBodyMapper.SmsListByType(map);
        Iterator iter = smsBodyExtendList.iterator();
        List<SmsBodyExtend> list = new ArrayList<SmsBodyExtend>();//公告未看集合
        List<SmsBodyExtend> list1 = new ArrayList<SmsBodyExtend>();//投票未看集合
        while (iter.hasNext()) {
            SmsBodyExtend smsBodyExtend = (SmsBodyExtend) iter.next();
            switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                case 1://公告
                    String size2 = smsBodyExtend.getRemindUrl();
                    String[] aStrings2 = size2.split("\\?");
                    for (int i = 0; i < aStrings2.length; i++) {
                        if (aStrings2[i].contains("notifyId")) {
                            String[] s = aStrings2[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    list.add(smsBodyExtend);
                    break;
                case 11://投票
                    String size6 = smsBodyExtend.getRemindUrl();
                    String[] aStrings6 = size6.split("\\?");
                    for (int i = 0; i < aStrings6.length; i++) {
                        if (aStrings6[i].contains("resultId")) {
                            String[] s = aStrings6[i].split("=");
                            String[] s1 = s[i].split("&");
                            smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                            break;
                        }
                    }
                    list1.add(smsBodyExtend);
                    break;
            }
        }
        if (notifies != null && notifies.size() > 0) {
            for (Notify notify : notifies) {
                if (list != null && list.size() > 0) {
                    for (int i = 0; i < list.size(); i++) {
                        if (notify.getNotifyId().equals(list.get(i).getQid())) {
                            updatequerySmsByType("1", user.getUserId(), String.valueOf(notify.getNotifyId()));
                        }
                    }
                } else {
                    break;
                }
            }
        }
        if (voteItems != null && voteItems.size() > 0) {
            for (VoteItem voteItems1 : voteItems) {
                if (list != null && list.size() > 0) {
                    for (int i = 0; i < list1.size(); i++) {
                        if (voteItems1.getVoteId().equals(list1.get(i).getQid())) {
                            String remingUrl = "/vote/manage/voteResult?resultId=" + voteItems1.getVoteId() + "&type=1";
                            updatequerySmsByType("11", user.getUserId(), remingUrl);
                        }
                    }
                } else {
                    break;
                }
            }
        }


    }

    @Override
    public void querySmsByTypeUpdateRunId(String type, String runId, Map<String, String> smsMap) {
        Map<String, Object> map = new HashMap<String, Object>();
        //String flowId=smsMap.get("flowId");
        //List<Integer> flowPrcsList=flowProcessMapper.selectShowPrcsId(Integer.parseInt(flowId));
        List<String> urlList = new ArrayList<>();
        String url = "%&runId=" + runId + "&%";
        urlList.add(url);
       /* for(Integer flowPrcs:flowPrcsList){
            String url = "/workflow/work/workform?opflag=1&flowId="+flowId+"&flowStep="+flowPrcs+"&runId="+runId+"%";
            urlList.add(url);
        }*/
        map.put("type", type);
        map.put("urlList", urlList);
        List<String> smsList = smsMapper.querySmsByTypeUpdateRunId(map);
        if (smsList != null && smsList.size() > 0) {
            String[] toBeStored = smsList.toArray(new String[smsList.size()]);
            smsMapper.updateSmsUpdateRunId("1", toBeStored);
        }


    }


    @Override
    public Integer getSmsId(HttpServletRequest request, String visitUrl) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        return smsMapper.getSmsId(sessionUser.getUserId(), visitUrl);
    }

    @Override
    public int getRemidFlagById(int id) {
        SmsExample smsExample = new SmsExample();
        SmsExample.Criteria criteria = smsExample.createCriteria();
        criteria.andSmsIdEqualTo(id);
        String remindflag = smsMapper.selectByExample(smsExample).get(0).getRemindFlag();
        return Integer.parseInt(remindflag);

    }

    /**
     * 将事务提醒未读改为已读
     *
     * @param request
     * @param bodyId
     */
    public void setSmsReadStatus(HttpServletRequest request, Integer bodyId) {
        if (bodyId != null) {
            smsMapper.setRead((String) request.getSession().getAttribute("userId"), bodyId);
        }
    }

    /**
     * 将事务提醒未读改为已读
     *
     * @param request
     * @param bodyId
     */
    public void setSmsReadByBodyId(HttpServletRequest request, Integer bodyId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        SmsBody smsBody = smsBodyMapper.selectSmsBodyByBodyId(bodyId);
        if (smsBody != null) {
            smsMapper.setRead(sessionUser.getUserId(), smsBody.getBodyId());
        }

    }

    public void setSmsRead(String smsType, String remindUrl, Users users) {
        //查询出bodyId
        Map<String, Object> map = new HashMap<>();
        map.put("smsType", smsType);
        map.put("remindUrl", remindUrl);
        SmsBody smsBody = smsBodyMapper.querySmsBodyCon(map);
        //进行修改
        if (smsBody != null) {
            smsMapper.setRead(users.getUserId(), smsBody.getBodyId());
        }
    }

    public void setSmsFileRead(String bodyId, String smsType, String remindUrl, Users users) {
        //查询出bodyId
        Map<String, Object> map = new HashMap<>();
        map.put("bodyId", bodyId);
        map.put("smsType", smsType);
        map.put("remindUrl", remindUrl);
        map.put("userId", users.getUserId());
        List<String> smsIdList = smsBodyMapper.querySmsBodyByUserId(map);
        //进行修改
        if (smsIdList != null && smsIdList.size() > 0) {
            smsMapper.updateSmsByIds("0", smsIdList.stream().toArray(String[]::new));
        }
    }

    public void setSmsReadAll(String smsType, String remindUrl) {
        //查询出bodyId
        Map<String, Object> map = new HashMap<>();
        map.put("smsType", smsType);
        map.put("remindUrl", remindUrl);
        SmsBody smsBody = smsBodyMapper.querySmsBodyCon(map);
        if (smsBody != null) {
            smsMapper.updateSms(smsBody.getBodyId());
        }
    }

    @Override
    public void querySmsByTypeBathchUpdateRunId(String type, String[] runId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("type", type);
        map.put("url", runId);
        List<String> smsList = smsMapper.querySmsByTypeBatchUpdateRunId(map);
        if (smsList != null && smsList.size() > 0) {
            String[] toBeStored = smsList.toArray(new String[smsList.size()]);
            smsMapper.updateSmsBatchUpdateRunId("1", toBeStored);
        }
    }

    public Integer selectSmsId(HttpServletRequest request, String visitUrl) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        return smsMapper.selectSmsId(sessionUser.getUserId(), visitUrl);
    }

    @Override
    public Integer selectSmsId(String toUserId, String url) {
        return smsMapper.selectSmsId(toUserId, url);
    }

    /**
     * 快捷地构建推送对象：所有平台，所有设备，内容为 ALERT 的通知。
     *
     * @return
     */
    public PushPayload buildPushObject_all_all_alert() {
        return PushPayload.alertAll(ALERT);
    }

    /**
     * 构建推送对象：所有平台，推送目标是别名为 "alias1"，通知内容为 ALERT。
     *
     * @return
     */
    public PushPayload buildPushObject_all_alias_alert(String[] account, String alert, String message, Integer badge, SmsBody smsBody) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
                .setAudience(Audience.alias(account))
                // .setNotification(Notification.alert(alert))
                .setNotification(Notification.newBuilder()
                        .addPlatformNotification(AndroidNotification.newBuilder()
                                .setAlert(alert)
                                .setTitle(message)
                                .build())
                        .addPlatformNotification(IosNotification.newBuilder()
                                .setAlert(IosAlert.newBuilder()
                                        .setTitleAndBody(alert, "", message)
                                        .setActionLocKey("PLAY")
                                        .build())
                                .setBadge(badge)
                                .setSound("happy")
                                .addExtra("content-available",1)
                                .addExtra("remindUrl",smsBody.getRemindUrl())
                                .build())
                        .build())
                .setOptions(Options.newBuilder()
                        .setApnsProduction(JGProduction)
                        .build())
                .build();
    }

    /**
     * 构建推送对象：平台是 Android，目标是 tag 为 "tag1" 的设备，内容是 Android 通知 ALERT，并且标题为 TITLE。
     *
     * @return
     */
    public static PushPayload buildPushObject_android_tag_alertWithTitle() {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android())
                .setAudience(Audience.tag("tag1"))
                .setNotification(Notification.android(ALERT, TITLE, null))
                .build();
    }

    /**
     * 构建推送对象：平台是 iOS，推送内容同时包括通知与消息 - 通知信息是 ALERT，角标数字为 5，
     * 通知声音为 "happy"，并且附加字段 from = "JPush"；消息内容是 MSG_CONTENT。通知是 APNs 推送通道的，消息是 JPush 应用内消息通道的。
     * APNs 的推送环境是“生产”（如果不显式设置的话，Library 会默认指定为开发）
     *
     * @return
     */
    public PushPayload buildPushObject_ios(String[] account, String alert, String message) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.ios())
                .setAudience(Audience.alias(account))
                .setNotification(Notification.newBuilder()
                        .addPlatformNotification(IosNotification.newBuilder()
                                .setAlert(IosAlert.newBuilder()
                                        .setTitleAndBody(alert, "", message)
                                        .setActionLocKey("PLAY")
                                        .build())
                                .setBadge(1)
                                .setSound("happy")
                                .build())
                        .build())
                .setOptions(Options.newBuilder()
                        .setApnsProduction(JGProduction)
                        .build())
                .build();
    }


    /**
     * 构建推送对象：平台是 Andorid 与 iOS，推送目标是 （"tag1" 与 "tag2" 的并集）交（"alias1" 与 "alias2" 的并集），
     * 推送内容是 - 内容为 MSG_CONTENT 的消息，并且附加字段 from = JPush。
     *
     * @return
     */
    public static PushPayload buildPushObject_ios_audienceMore_messageWithExtras(String account) {
        return PushPayload.newBuilder()
                .setPlatform(Platform.android_ios())
                .setAudience(Audience.newBuilder()
                        .addAudienceTarget(AudienceTarget.alias(account))
                        .build())
                .setMessage(Message.newBuilder()
                        .setMsgContent(MSG_CONTENT)
                        .addExtra("from", "JPush")
                        .build())
                .build();
    }

    /**
     * 构建推送对象：推送内容包含SMS信息
     */
   /* public static void testSendWithSMS() {
        JPushClient jpushClient = new JPushClient(androidJGSercetKey, androidJGKey );
        try {
            SMS sms = SMS.newBuilder()
                    .setDelayTime(1000)
                    .setTempID(2000)
                    .addPara("Test", 1)
                    .build();
            PushResult result = jpushClient.sendAndroidMessageWithAlias("Test SMS", "test sms", sms, "alias1");

        } catch (APIConnectionException e) {
          *//*  LOG.error("Connection error. Should retry later. ", e);*//*
        } catch (APIRequestException e) {
           *//* LOG.error("Error response from JPush server. Should review and fix it. ", e);
            LOG.info("HTTP Status: " + e.getStatus());
            LOG.info("Error Code: " + e.getErrorCode());
            LOG.info("Error Message: " + e.getErrorMessage());*//*
        }
    }
*/
    public static final String TITLE = "Test from API example";
    public static final String ALERT = "Test from API Example - alert";
    public static final String MSG_CONTENT = "Test from API Example - msgContent";
    public static final String REGISTRATION_ID = "0900e8d85ef";
    public static final String TAG = "tag_api";
    public static long sendCount = 0;
    private static long sendTotalTime = 0;


    /**
     * 华为推送
     */

    /**
     * 获取下发通知消息的认证Token
     */

    //获取下发通知消息的认证Token
    private void refreshToken() throws IOException {
        String msgBody = MessageFormat.format(
                "grant_type=client_credentials&client_secret={0}&client_id={1}",
                URLEncoder.encode(appSecret, "UTF-8"), appId);
        String response = httpPost(tokenUrl, msgBody, 5000, 5000);
        com.alibaba.fastjson.JSONObject obj = com.alibaba.fastjson.JSONObject.parseObject(response);
        accessToken = obj.getString("access_token");
        tokenExpiredTime = System.currentTimeMillis() + obj.getLong("expires_in") - 5 * 60 * 1000;
    }


    //发送Push消息
    public void sendPushMessage(String title, String context, com.alibaba.fastjson.JSONArray deviceTokens) {
//        ToJson<SmsBody> json = new ToJson<SmsBody>();
        try {
            /**判断是否过期如果过期则重新获取token*/
            if (tokenExpiredTime <= System.currentTimeMillis()) {
                refreshToken();
            }

          /* //目标设备Token
           com.alibaba.fastjson.JSONArray  deviceTokens = new com.alibaba.fastjson.JSONArray();

           String[] split = toIds.split(",");
           List<String> list = new ArrayList<>();
           for (int i = 0; i < split.length; i++) {
               for (int j = i + 1; j < split.length; j++) {
                   if (split[i] == split[j]) {
                       j = ++i;
                   }
               }
               if (split[i] != null && !split[i].equals("")) {
                   list.add(split[i]);
               }
           }

           for(String id:list){
               //如果设备token不为空，把设备token添加到deviceTokens
               Users users = usersMapper.selectUserByUserId(id);
               if(users != null && users.getIcqNo() != null){
                   deviceTokens.add(users.getIcqNo());


               }
           }*/
            // deviceTokens.add("MWUBB18316204433300001479500CN01");


            /**发信息*/
            //仅通知栏消息需要设置标题和内容，透传消息key和value为用户自定义
            com.alibaba.fastjson.JSONObject body = new com.alibaba.fastjson.JSONObject();
            body.put("title", title);//发信人
            body.put("content", context);//消息内容体

            /**
             * 消息点击动作参数
             */
            com.alibaba.fastjson.JSONObject param = new com.alibaba.fastjson.JSONObject();
            param.put("appPkgName", "com.huawei.hms.hmsdemo");//定义需要打开的appPkgName

            /**
             * 消息点击动作
             * 定义消息的点击动作，type=1时为自定义动作，即intent。Type= 3为默认动作，打开app。
             */
            com.alibaba.fastjson.JSONObject action = new com.alibaba.fastjson.JSONObject();
            action.put("type", 3);
            action.put("param", param);//消息点击动作参数

            /**
             * push消息定义
             */
            com.alibaba.fastjson.JSONObject msg = new com.alibaba.fastjson.JSONObject();
            msg.put("type", 3);//3: 通知栏消息，异步透传消息请根据接口文档设置
            msg.put("action", action);//消息点击动作
            msg.put("body", body);//通知栏消息body内容

            /**
             * 扩展信息，含BI消息统计，特定展示风格，消息折叠。
             */
            com.alibaba.fastjson.JSONObject ext = new com.alibaba.fastjson.JSONObject();
            //设置消息标签，如果带了这个标签，会在回执中推送给CP用于检测某种类型消息的到达率和状态
            ext.put("biTag", "Trump");
            //自定义推送消息在通知栏的图标,value为一个公网可以访问的URL
            ext.put("icon", "http://8oa.cn/assets/main_img/huawei.jpg");

            /**
             * 华为push消息总结构体
             */
            com.alibaba.fastjson.JSONObject hps = new com.alibaba.fastjson.JSONObject();//华为PUSH消息总结构体
            hps.put("msg", msg);
            hps.put("ext", ext);

            /**
             * 放进总体结构，最高父级hps
             */
            com.alibaba.fastjson.JSONObject payload = new com.alibaba.fastjson.JSONObject();
            payload.put("hps", hps);

            /**
             * 请求发送接口
             */
            String postBody = MessageFormat.format(
                    "access_token={0}&nsp_svc={1}&nsp_ts={2}&device_token_list={3}&payload={4}",
                    URLEncoder.encode(accessToken, "UTF-8"),
                    URLEncoder.encode("openpush.message.api.send", "UTF-8"),
                    URLEncoder.encode(String.valueOf(System.currentTimeMillis() / 1000), "UTF-8"),
                    URLEncoder.encode(deviceTokens.toString(), "UTF-8"),
                    URLEncoder.encode(payload.toString(), "UTF-8"));

            String postUrl = apiUrl + "?nsp_ctx=" + URLEncoder.encode("{\"ver\":\"1\", \"appId\":\"" + appId + "\"}", "UTF-8");
            httpPost(postUrl, postBody, 5000, 5000);
        } catch (Exception e) {
            e.printStackTrace();

        }
    }


    /**
     * 推送
     *
     * @param httpUrl
     * @param data
     * @param connectTimeout
     * @param readTimeout
     * @return
     * @throws IOException
     */
    public static String httpPost(String httpUrl, String data, int connectTimeout, int readTimeout) throws IOException {
        OutputStream outPut = null;
        HttpURLConnection urlConnection = null;
        InputStream in = null;

        try {
            URL url = new URL(httpUrl);
            urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("POST");
            urlConnection.setDoOutput(true);
            urlConnection.setDoInput(true);
            urlConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
            urlConnection.setConnectTimeout(connectTimeout);
            urlConnection.setReadTimeout(readTimeout);
            urlConnection.connect();

            // POST data
            outPut = urlConnection.getOutputStream();
            outPut.write(data.getBytes("UTF-8"));
            outPut.flush();

            // read response
            if (urlConnection.getResponseCode() < 400) {
                in = urlConnection.getInputStream();
            } else {
                in = urlConnection.getErrorStream();
            }

            List<String> lines = IOUtils.readLines(in, urlConnection.getContentEncoding());
            StringBuffer strBuf = new StringBuffer();
            for (String line : lines) {
                strBuf.append(line);
            }
            //System.out.println(strBuf.toString());
            return strBuf.toString();
        } finally {
            IOUtils.closeQuietly(outPut);
            IOUtils.closeQuietly(in);
            if (urlConnection != null) {
                urlConnection.disconnect();
            }
        }
    }

    public void testNotificationMessageSend(List<String> tokens, String title, String body,SmsBody smsBody) throws HuaweiMesssagingException {
        // 如果标题为空 设置默认标题
        if(StringUtils.checkNull(title)){
            title = "消息提醒";
        }
        HuaweiCredential credential = HuaweiCredential.builder()
                .setAppId(AppIdKey)
                .setAppSecret(SecretKey)
                .build();

        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        String category;
        switch (smsType) {
            case "2":
                category = "MAIL";
                break;
            default :
                category = "WORK";
        }

        HuaweiOption option = HuaweiOption.builder()
                .setCredential(credential)
                .build();
        HuaweiApp app = HuaweiApp.initializeApp(option);

        //String token = "1004103023061481981059500600CN01";
        com.huawei.push.message.Notification notification = new com.huawei.push.message.Notification(title, body);
        com.huawei.push.android.ClickAction clickAction = ClickAction.builder()
                .setType(1)
                .setIntent("intent://com.gsb.xtongda/deeplink?#Intent;scheme=pushscheme;launchFlags=0x8000;S.smsType="+smsType+";S.remindUrl="+remindUrl+";end")
                .build();
        com.huawei.push.android.AndroidNotification androidNotification = com.huawei.push.android.AndroidNotification.builder()
                .setTitle(title)
                .setBody(body)
                .setClickAction(clickAction).setIcon("http://8oa.cn/assets/main_img/huawei.jpg")
                .build();

        AndroidConfig androidConfig = AndroidConfig.builder()
                .setCategory(category)
                .setNotification(androidNotification)
                .build();

        com.huawei.push.message.Message message = com.huawei.push.message.Message.builder()
                .setNotification(notification)
                .setAndroidConfig(androidConfig)
                .addAllToken(tokens)
                .build();

        com.huawei.push.reponse.SendResponse responce = HuaweiMessaging.getInstance(app).sendMessage(message, false);
        //app.clearInstancesForTest();
        Assert.assertEquals("Success", responce.getMsg());
    }

    // 华为新版推送
    public void testNotificationMessageSend(List<String> tokens, String title, String body,Integer total,SmsBody smsBody) throws HuaweiMesssagingException {
        // 如果标题为空 设置默认标题
        if(StringUtils.checkNull(title)){
            title = "消息提醒";
        }
        HuaweiCredential credential = HuaweiCredential.builder()
                .setAppId(AppIdKey)
                .setAppSecret(SecretKey)
                .build();

        HuaweiOption option = HuaweiOption.builder()
                .setCredential(credential)
                .build();
        HuaweiApp app = HuaweiApp.initializeApp(option);

        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        String category;
        switch (smsType) {
            case "2":
                category = "MAIL";
                break;
            default :
                category = "WORK";
        }

        String s=this.selBodyAndUserInfo(smsBody.getBodyId());
        //String token = "1004103023061481981059500600CN01";
        com.huawei.push.message.Notification notification = new com.huawei.push.message.Notification(title, body);
        com.huawei.push.android.ClickAction clickAction = ClickAction.builder()
                .setType(1)
                //.setIntent("intent://com.gsb.xtongda/deeplink?#Intent;scheme=pushscheme;launchFlags=0x4000000;S.smsType="+smsType+";S.remindUrl="+remindUrl+";end")
                //.setIntent("intent:#Intent;launchFlags=0x10000000;component=com.gsb.xtongda/.activity.MainTabActivity;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                .setIntent("intent:#Intent;launchFlags=0x14000000;component=com.gsb.xtongda/.activity.LogoActivity;action=android.intent.action.MAIN;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                .build();
        com.huawei.push.android.AndroidNotification androidNotification = com.huawei.push.android.AndroidNotification.builder()
                .setTitle(title)
                .setBody(body)
                .setClickAction(clickAction).setIcon("http://8oa.cn/assets/main_img/huawei.jpg")
                .setBadge(new BadgeNotification(total,Huawei_badge_class))
                .build();

        AndroidConfig androidConfig = AndroidConfig.builder()
                .setCategory(category)
                .setNotification(androidNotification)
                .build();

        com.huawei.push.message.Message message = com.huawei.push.message.Message.builder()
                .setNotification(notification)
                .setAndroidConfig(androidConfig)
                //.addToken(tokens)
                .addAllToken(tokens)
                .build();

        com.huawei.push.reponse.SendResponse responce = HuaweiMessaging.getInstance(app).sendMessage(message, false);
        //app.clearInstancesForTest();
        Assert.assertEquals("Success", responce.getMsg());
    }
    //获取参数拼接返回给移动端（公共方法）
    public String selBodyAndUserInfo(Integer bodyId){
    /*    Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);*/
        SmsBodyExtend smsBodyExtend = smsBodyMapper.selBodyAndUserInfo(bodyId);
        if(!StringUtils.checkNull(smsBodyExtend.getSmsType())){
            switch (Integer.parseInt(smsBodyExtend.getSmsType())) {
                case 2:
                    String size1 = smsBodyExtend.getRemindUrl();
                    String[] aStrings = size1.split("\\?");
                    for (int i = 0; i < aStrings.length; i++) {
                        if (aStrings[i].contains("id")) {
                            String[] s = aStrings[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        } else if (aStrings[i].contains("EMAIL_ID")) {
                            String[] s =null;
                            if(aStrings[i].contains("&")){
                                String[] str = null;
                                str = aStrings[i].split("&");
                                if(str[i].contains("=")){
                                    s = str[i].split("=");
                                }
                            }else{
                                s = aStrings[i].split("=");
                            }
                            break;
                        }
                    }
                    break;
                case 25:
                    String size11 = smsBodyExtend.getRemindUrl();
                    String[] aStringss = size11.split("\\?");
                    for (int i = 0; i < aStringss.length; i++) {
                        if (aStringss[i].contains("id")) {
                            String[] s = aStringss[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        } else if (aStringss[i].contains("EMAILPLUS_ID")) {
                            String[] s = aStringss[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    break;
                case 1:
                    smsBodyExtend.setImg("/img/workflow/notify.png");
                    smsBodyExtend.setType("notify");
                    String size2 = smsBodyExtend.getRemindUrl();
                    String[] aStrings2 = size2.split("\\?");
                    for (int i = 0; i < aStrings2.length; i++) {
                        if (aStrings2[i].contains("notifyId")) {
                            String[] s = aStrings2[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        } else if (aStrings2[i].contains("NOTIFY_ID")) {
                            String[] s = aStrings2[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    break;
                case 7:
                    break;
                case 14:
                    String size3 = smsBodyExtend.getRemindUrl();
                    String[] aStrings3 = size3.split("\\?");
                    for (int i = 0; i < aStrings3.length; i++) {
                        if (aStrings3[i].contains("newsId")) {
                            String[] s = aStrings3[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    break;
                case 70:

                    break;
                case 11:
                    String size6 = smsBodyExtend.getRemindUrl();
                    String[] aStrings6 = size6.split("\\?");
                    for (int i = 0; i < aStrings6.length; i++) {
                        if (aStrings6[i].contains("resultId")) {
                            String[] s = aStrings6[i].split("=");
                            String[] s1 = s[i].split("&");
                            smsBodyExtend.setQid(Integer.parseInt(s1[0]));
                            break;
                        }
                    }
                    break;
                case 19:
                    smsBodyExtend.setImg("/img/workflow/youjian.png");
                    smsBodyExtend.setType("bbsBoard");
                    String size111 = smsBodyExtend.getRemindUrl();
                    String[] aStringsss = size111.split("\\?");
                    for (int i = 0; i < aStringsss.length; i++) {
                        if (aStringsss[i].contains("boardId")) {
                            String[] s = aStringsss[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        } else if (aStringsss[i].contains("BOARD_ID")) {
                            String[] s = aStringsss[i].split("=");
                            smsBodyExtend.setQid(Integer.parseInt(s[1]));
                            break;
                        }
                    }
                    break;
            }
        }
        Integer qie=smsBodyExtend.getQid();
        Integer runId=smsBodyExtend.getRunId();
        Integer flowId=smsBodyExtend.getFlowId();
        String prcesId=smsBodyExtend.getPrcsId();
        String flowPrs=smsBodyExtend.getFlowPrcs();
        String feedback=smsBodyExtend.getFeedback();
        String feedSecretType=smsBodyExtend.getFeedSecretType();
        String fromId=smsBodyExtend.getFromId();
        String signlock=smsBodyExtend.getSignlock();
        String handleType=smsBodyExtend.getHandleType();
        String content=smsBodyExtend.getContent();
        String avater=smsBodyExtend.getAvater();
        String userName=smsBodyExtend.getUserName();
        Integer uid=smsBodyExtend.getUid();
        String s="S.avater="+avater+";" +
        "S.bodyId="+bodyId+";S.flowId="+flowId+";S.fromId="+fromId+";S.flowPrs="+flowPrs+";S.prcesId="+prcesId+";" +
                "S.userName="+userName+";S.feedback="+feedback+";" +
                "S.qid="+qie+";S.runId="+runId+";S.signlock="+signlock+";S.content="+content+";" +
                "S.feedSecretType="+feedSecretType+";S.handleType="+handleType+"";
        return s;
    }
    //小米推送
    private String sendMessageToAliases(List<String> xmList,String context,String title,SmsBody smsBody) throws Exception {
        Constants.useOfficial();
        //Constants.useSandbox();
        Sender sender = new Sender(AppSecretXiaomi);
        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        String s=this.selBodyAndUserInfo(smsBody.getBodyId());
        String messagePayload = "内容";
        /*List<String> aliasList = new ArrayList<String>();
        aliasList.add(account);*/
        int max=10000000,min=1;
        int ran2 = (int) (Math.random()*(max-min)+min);
        com.xiaomi.xmpush.server.Message message = new com.xiaomi.xmpush.server.Message.Builder()
                .title(context)
                .description(title).payload(messagePayload)
                .restrictedPackageName(Xiaomi_badge_class)
                .passThrough(0)
                .extra(Constants.EXTRA_PARAM_NOTIFY_EFFECT, Constants.NOTIFY_ACTIVITY)
                .extra(Constants.EXTRA_PARAM_INTENT_URI, "intent:#Intent;launchFlags=0x14000000;component=com.gsb.xtongda/.activity.LogoActivity;action=android.intent.action.MAIN;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                .notifyType(1)// 使用默认提示音提示
                .notifyId(ran2)
                .build();
        com.xiaomi.xmpush.server.Result result=sender.sendToAlias(message, xmList, 3); //根据aliasList, 发送消息到指定设备上
        return result.toString();
    }
}