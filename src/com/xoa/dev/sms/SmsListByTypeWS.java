package com.xoa.dev.sms;


import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 * @作者 廉立深
 * @创建日期 12:05 2019/10/23
 * @类介绍 代办事项
 */
@WebService
public interface SmsListByTypeWS {

    //事务提醒
    @WebMethod
    String smsListByType(String userId,String type,String selKey);

    //
}
