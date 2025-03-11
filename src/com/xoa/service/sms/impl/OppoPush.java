package com.xoa.service.sms.impl;


import com.alibaba.fastjson.JSONObject;
import com.oppo.push.server.Notification;
import com.oppo.push.server.Result;
import com.oppo.push.server.Sender;
import com.oppo.push.server.Target;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sms.SmsBodyExtend;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Map;

@Service
public class OppoPush {
    @Resource
    private SmsServiceImpl smsService;
    @Resource VivoPush vivoPush;
    @Value("${App_Key_Oppo}")
    String App_Key_Oppo;
    @Value("${AppSecretOppo}")
    String AppSecretOppo;
    @Value("${App_Id_Oppo}")
    String App_Id_Oppo;
    @Value("${MasterSecret}")
    String MasterSecret;
    public void getNotifications(Map<Target,Notification> opMap) throws Exception {
        Sender sender = new Sender(App_Key_Oppo, MasterSecret);
       // Target target = Target.build(registerId); //创建发送对象
        Result result = sender.unicastBatchNotification(opMap);//发送单推消息
        result.getReason();
    }
    public Notification getNotification(String context, String title, SmsBody smsBody){
        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        SmsBodyExtend smsBodyExtend =vivoPush.selBodyAndUserInfo(smsBody.getBodyId());
        Map map=new HashedMap();
        map.put("remindUrl",String.valueOf(remindUrl));
        map.put("smsType",String.valueOf(smsType));
        map.put("bodyId",String.valueOf(smsBodyExtend.getBodyId()));
        map.put("flowId",String.valueOf(smsBodyExtend.getFlowId()));
        map.put("prcesId",String.valueOf(smsBodyExtend.getPrcsId()));
        map.put("qid",String.valueOf(smsBodyExtend.getQid()));
        map.put("runId",String.valueOf(smsBodyExtend.getRunId()));
        map.put("content",String.valueOf(smsBodyExtend.getContent()));
        map.put("feedSecretType",String.valueOf(smsBodyExtend.getFeedSecretType()));
        map.put("handleType",String.valueOf(smsBodyExtend.getHandleType()));
        map.put("avater",String.valueOf(smsBodyExtend.getAvater()));
        map.put("fromId",String.valueOf(smsBodyExtend.getFromId()));
        map.put("flowPrs",String.valueOf(smsBodyExtend.getFlowPrcs()));
        map.put("userName",String.valueOf(smsBodyExtend.getUserName()));
        map.put("feedback",String.valueOf(smsBodyExtend.getFeedback()));
        map.put("signlock",String.valueOf(smsBodyExtend.getSignlock()));
        JSONObject json = new JSONObject(map);
        Notification notification = new Notification();
        notification.setTitle(title);
        notification.setContent(context);
// App开发者自定义消息Id，OPPO推送平台根据此ID做去重处理，对于广播推送相同appMessageId只会保存一次，对于单推相同appMessageId只会推送一次
        //notification.setAppMessageId(UUID.randomUUID().toString());
// 应用接收消息到达回执的回调URL，字数限制200以内，中英文均以一个计算
        //notification.setCallBackUrl("http://www.test.com");
// App开发者自定义回执参数，字数限制50以内，中英文均以一个计算
        // notification.setCallBackParameter("");
// 点击动作类型0，启动应用；1，打开应用内页（activity的intent action）；2，打开网页；4，打开应用内页（activity）；【非必填，默认值为0】;5,Intent scheme URL
        notification.setClickActionType(4);
// 应用内页地址【click_action_type为1或4时必填，长度500】
        notification.setClickActionActivity("com.gsb.xtongda.activity.LogoActivity");
// 动作参//数，打开应用内页或网页时传递给应用或网页【JSON格式，非必填】，字符数不能超过4K，示例：{"key1":"value1","key2":"value2"}
        notification.setActionParameters(json.toString());
// 离线消息的存活时间(time_to_live) (单位：秒), 【off_line值为true时，必填，最长3天】
        notification.setShowTimeType(0);
        notification.setOffLineTtl(86400);
        int max=10000000,min=1;
        int ran2 = (int) (Math.random()*(max-min)+min);
        notification.setNotifyId(ran2);
        return notification;
    }
}
