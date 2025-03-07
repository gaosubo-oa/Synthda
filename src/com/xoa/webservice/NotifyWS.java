package com.xoa.webservice;

import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface NotifyWS {

    /**
     * @接口说明: 获取公告信息
     * @日期: 2020/1/9
     * @作者: 张航宁
     */
    String getNotify(@WebParam(name = "lastTime") String lastTime, @WebParam(name = "page") String page, @WebParam(name = "pageSize") String pageSize,@WebParam(name = "selKey")String selKey);

    /**
     * @接口说明: 根据公告id获取
     * @日期: 2020/1/9
     * @作者: 张航宁
     */
    String getNotifyById(@WebParam(name = "notifyId") String notifyId,@WebParam(name = "selKey")String selKey);

}
