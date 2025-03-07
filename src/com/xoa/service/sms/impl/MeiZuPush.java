package com.xoa.service.sms.impl;

import com.meizu.push.sdk.server.IFlymePush;
import com.meizu.push.sdk.server.constant.ResultPack;
import com.meizu.push.sdk.server.model.push.PushResult;
import com.meizu.push.sdk.server.model.push.VarnishedMessage;
import com.xoa.model.sms.SmsBody;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class MeiZuPush {
    @Resource
    private SmsServiceImpl smsService;
    @Value("${App_Id_MeiZu}")
    long App_Id_MeiZu;
    @Value("${AppSecretMeiZu}")
    String AppSecretMeiZu;
    public void testVarnishedMessagePushByAlias(List<String> mzList, String context, String title, SmsBody smsBody) throws Exception {
        IFlymePush push = new IFlymePush(AppSecretMeiZu);
        String remindUrl = smsBody.getRemindUrl();
        String smsType = smsBody.getSmsType();
        String s=smsService.selBodyAndUserInfo(smsBody.getBodyId());
        VarnishedMessage message = new VarnishedMessage.Builder()
                 .appId(App_Id_MeiZu)
                .title(title)
                .content(context)
               //.noticeExpandType(1)
                //.noticeExpandContent("")
                .clickType(2)//打开url页面
                .url("intent:#Intent;launchFlags=0x14000000;component=com.gsb.xtongda/.activity.LogoActivity;action=android.intent.action.MAIN;S.smsType="+smsType+";S.remindUrl="+remindUrl+";"+s+";end")
                //.parameters(JSON.parseObject(""))透传参数
                //.offLine(true)
                .validTime(12)
                //.isFixDisplay(true)
                //.fixDisplayTime()
                //.suspend(true)
               //.clearNoticeBar(true)
                //.vibrate(true)
                //.lights(true)
                //.sound(true)
                .build();
        ResultPack<PushResult> result = push.pushMessageByAlias(message,mzList);
        result.code();
        result.comment();


    }
}
