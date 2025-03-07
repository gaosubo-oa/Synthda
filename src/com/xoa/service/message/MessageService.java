package com.xoa.service.message;

import com.xoa.model.message.Message;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微讯
 * 2018.8.13
 */
public interface MessageService {

    ToJson<Message> getStatusWQR(HttpServletRequest request,Integer page,Integer pageSize,boolean useFlag);
    ToJson delMessage(HttpServletRequest request,Message message);
    ToJson addMessage(HttpServletRequest request,Message message);
    ToJson<Message> getMessageInfo(HttpServletRequest request,Message message,Integer page,Integer pageSize,boolean useFlag);
    ToJson clickReply(String msgId);
    ToJson<Message> selectMessage(HttpServletRequest request,HttpServletResponse response, Message message, String export,Integer page,Integer pageSize,boolean useFlag);
    ToJson getMessage(String msgId);
}
