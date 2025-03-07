package com.xoa.service.smsDelivery;

import com.xoa.model.sms2.Sms2Priv;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;


public interface Sms2PrivService {

    ToJson<Sms2Priv> selectSms2Priv();

    ToJson upSms2Priv(Sms2Priv sms2Priv);

//    ToJson<Sms2Priv> selectModule();

    ToJson<Sms2Priv> selectRemindPriv();

    ToJson upRemindPriv(Sms2Priv sms2Priv);

    ToJson<Sms2Priv> selectSms2RemindPriv();

    ToJson upselectSms2RemindPriv(Sms2Priv sms2Priv);

    ToJson<Sms2Priv> selectModuleOrder();

    ToJson<Sms2Priv> selectSmsRemind();

    ToJson upSmsRemindSet(Sms2Priv sms2Priv);

    ToJson selectSender(String name);

    ToJson smsSender(StringBuffer mobileString, StringBuffer contextString,Sms2Priv sms2Priv,HttpServletRequest request);

    ToJson selSenderMobile(String smsDefault,Sms2Priv sms2Priv,StringBuffer contextString, HttpServletRequest request);

    ToJson<Sms2Priv> selOutPriv();

    ToJson upOutPriv(Sms2Priv sms2Priv);

    ToJson outToSelf(Sms2Priv sms2Priv);

    ToJson<Sms2Priv> selectSmS2Priv();

    ToJson smsSenders(StringBuffer contextString,String privArray);

    //通过手机号发送短信
    ToJson smsSenderMobiles(StringBuffer contextString,String mobileArray);

    ToJson selectSms2(String sysCode,HttpServletRequest request);

//    ToJson smsSenderss(StringBuffer contextString,String privArray);

    String checked(String byName,String overName);


}