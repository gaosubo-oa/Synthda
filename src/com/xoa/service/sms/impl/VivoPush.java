package com.xoa.service.sms.impl;

import com.vivo.push.sdk.notofication.Message;
import com.vivo.push.sdk.notofication.Result;
import com.vivo.push.sdk.notofication.TargetMessage;
import com.vivo.push.sdk.server.Sender;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms.SmsBodyExtend;
import com.xoa.model.users.Users;
import com.xoa.util.common.StringUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;
import java.util.Set;

@Service
public class VivoPush {

    @Resource
    private SmsServiceImpl smsService;
    @Resource
    private SmsBodyMapper smsBodyMapper;
    @Resource
    private UsersMapper usersMapper;
    @Value("${App_Id_Vivo}")
    Integer AppIdVivo;
    @Value("${App_Key_Vivo}")
    String AppKeyVivo;
    @Value("${AppSecretVivo}")
    String AppSecretVivo;
    @Value("${Vivo_badge_class}")
    String Vivo_badge_class;
    public   void singeSendOne(Set<String> vivoSet, String title, String context, SmsBody smsBody) throws Exception {
        // 如果标题为空 设置默认标题
        if(StringUtils.checkNull(title)){
            title = "消息提醒";
        }
        if(StringUtils.checkNull(context)){
            context = "";
        }
        String regId = org.apache.commons.lang3.StringUtils.join(vivoSet.toArray());
        Sender sender = new     Sender(AppSecretVivo);//实例化Sender
      //  sender.initPool(20,10);//设置连接池参数，可选项
        Result tokenResult =   sender.getToken(AppIdVivo,AppKeyVivo);//发送鉴权请求
        String token=tokenResult.getAuthToken();
        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        SmsBodyExtend smsBodyExtend =this.selBodyAndUserInfo(smsBody.getBodyId());
        Map map=new HashedMap();
        map.put("remindUrl",remindUrl);
        map.put("smsType",smsType);
      String avater=smsBodyExtend.getAvater();
        map.put("bodyId",String.valueOf(smsBodyExtend.getBodyId()));
        map.put("flowId",String.valueOf(smsBodyExtend.getFlowId()));
        String fromId=String.valueOf(smsBodyExtend.getFromId());
       String flowPrs=String.valueOf(smsBodyExtend.getFlowPrcs());
        map.put("prcesId",String.valueOf(smsBodyExtend.getPrcsId()));
       String userName=smsBodyExtend.getUserName();
       String feedback=smsBodyExtend.getFeedback();
        map.put("qid",String.valueOf(smsBodyExtend.getQid()));
        map.put("runId",String.valueOf(smsBodyExtend.getRunId()));
      String signlock=smsBodyExtend.getSignlock();

        map.put("content",smsBodyExtend.getContent());
       map.put("feedSecretType",String.valueOf(smsBodyExtend.getFeedSecretType()));
        map.put("handleType",smsBodyExtend.getHandleType()+":"+avater+":"+fromId+":"+flowPrs+":"+
                userName+":"+feedback+":"+signlock);
        Message singleMessage     = new Message.Builder()//构建单推消息体
        //该测试手机设备订阅推送所得的regid，且已添加为测试设备
                .regId(regId)
                .notifyType(4)
                .title(title)
                .content(context)
                .timeToLive(86400)
                .classification(1)
                .skipType(1)
                //.skipContent("intent://com.vivo.pushtest/detail?#Intent;scheme=vpushscheme;launchFlags=0x14000000;component=com.gsb.xtongda/.activity.LogoActivity;action=android.intent.action.MAIN;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.skipContent("intent://com.vivo.push.notifysdk/detail?#Intent;scheme=vpushscheme;component=com.gsb.xtongda/.activity.LogoActivity;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.skipContent("intent://com.vivo.push.notifysdk/detail?#Intent;scheme=vpushscheme;component=com.gsb.xtongda/.activity.LogoActivity;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.skipContent("intent://com.gsb.xtongda/deeplink?#Intent;scheme=pushscheme;component=com.gsb.xtongda/.activity.MainTabActivity;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.skipContent("intent://com.gsb.xtongda/deeplink?#Intent;scheme=pushscheme;component=com.gsb.xtongda/.activity.LogoActivity;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.skipContent("intent://com.gsb.xtongda/deeplink?#Intent;scheme=pushscheme;component=com.gsb.xtongda/.activity.MainTabActivity;end")
                .clientCustomMap(map)
                .requestId(String.valueOf(System.currentTimeMillis()))
                .pushMode(0)
                .build();
        sender.setAuthToken(token);
        Result result =     sender.sendSingle(singleMessage);//发送单推请求
        result.getResult();//获取服务器返回的状态码，0成功，非0失败
        result.getDesc();//获取服务器返回的调用情况文字描述
    }
    public   void singeSend(Set<String> vivoSet, String title, String context, SmsBody smsBody) throws Exception {
        // 如果标题为空 设置默认标题
        if(StringUtils.checkNull(title)){
            title = "消息提醒";
        }
        if(StringUtils.checkNull(context)){
            context = "";
        }
        Sender sender = new     Sender(AppSecretVivo);//实例化Sender
        //  sender.initPool(20,10);//设置连接池参数，可选项
        Result tokenResult =   sender.getToken(AppIdVivo,AppKeyVivo);//发送鉴权请求
        String token=tokenResult.getAuthToken();
        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        SmsBodyExtend smsBodyExtend =this.selBodyAndUserInfo(smsBody.getBodyId());
        Map map=new HashedMap();
        map.put("remindUrl",remindUrl);
        map.put("smsType",smsType);
        String avater=smsBodyExtend.getAvater();
        map.put("bodyId",String.valueOf(smsBodyExtend.getBodyId()));
        map.put("flowId",String.valueOf(smsBodyExtend.getFlowId()));
        String fromId=String.valueOf(smsBodyExtend.getFromId());
        String flowPrs=String.valueOf(smsBodyExtend.getFlowPrcs());
        map.put("prcesId",String.valueOf(smsBodyExtend.getPrcsId()));
        String userName=smsBodyExtend.getUserName();
        String feedback=smsBodyExtend.getFeedback();
        map.put("qid",String.valueOf(smsBodyExtend.getQid()));
        map.put("runId",String.valueOf(smsBodyExtend.getRunId()));
        String signlock=smsBodyExtend.getSignlock();

        map.put("content",smsBodyExtend.getContent());
        map.put("feedSecretType",String.valueOf(smsBodyExtend.getFeedSecretType()));
        map.put("handleType",smsBodyExtend.getHandleType()+":"+avater+":"+fromId+":"+flowPrs+":"+
                userName+":"+feedback+":"+signlock);
        Message singleMessage     = new Message.Builder()//构建单推消息体
                .notifyType(4)
                .title(title)
                .content(context)
                .timeToLive(86400)
                .classification(1)
                .skipType(1)
                .clientCustomMap(map)
                .requestId(String.valueOf(System.currentTimeMillis()))
                .pushMode(0)
                .build();
        sender.setAuthToken(token);
        Result result =sender. saveListPayLoad(singleMessage);//发送单推请求
        result.getResult();//获取服务器返回的状态码，0成功，非0失败
        result.getDesc();//获取服务器返回的调用情况文字描述
        String taskId=result.getTaskId();
        TargetMessage targetMessage = new   TargetMessage.Builder()
                .regIds(vivoSet)
                .requestId(String.valueOf(System.currentTimeMillis()))
                .taskId(taskId)
                .build();
        com.vivo.push.sdk.notofication.Result result1 =sender.sendToList(targetMessage);
        result1.getResult();
    }
    public SmsBodyExtend selBodyAndUserInfo(Integer bodyId){
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
        return smsBodyExtend;
    }
}
