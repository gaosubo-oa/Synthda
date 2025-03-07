package com.xoa.controller.message;

import com.xoa.model.message.Message;
import com.xoa.service.message.MessageService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 微讯
 * 2018.8.13
 */
@RequestMapping("/wx")
@Controller
public class MessageController {
    @Autowired
    private MessageService messageService;

    /**
     * 查询未确认微讯
     * @return
     */
    @RequestMapping("/wqr")
    @ResponseBody
    public ToJson<Message> getStatusWQR(HttpServletRequest request,Integer page,Integer pageSize,boolean useFlag){
        return messageService.getStatusWQR(request,page,pageSize,useFlag);
    }
    /**
     * 删除微讯
     * @return
     */
    @RequestMapping("/delMessage")
    @ResponseBody
    public  ToJson delMessage(HttpServletRequest request,Message message){
        return messageService.delMessage(request,message);
    }

    /**
     * 新增微讯  发送微讯
     * @param message
     * @return
     */
    @RequestMapping("/addMessage")
    @ResponseBody
    public ToJson addMessage(HttpServletRequest request,Message message){
        return messageService.addMessage(request,message);
    }

    /**
     * 查询微讯聊天记录
     * @return
     */
    @RequestMapping("/getMessageInfo")
    @ResponseBody
    public ToJson<Message> getMessageInfo(HttpServletRequest request,Message message,Integer page,Integer pageSize,boolean useFlag){
        return messageService.getMessageInfo(request,message,page,pageSize,useFlag);
    }

    /**
     * 点击回复
     * @param msgId
     * @return
     */
    @RequestMapping("/clickReply")
    @ResponseBody
    public ToJson clickReply(String msgId){
        return messageService.clickReply(msgId);
    }

    /**
     * 查询 导出
     * @return
     */
    @RequestMapping("/selectMessage")
    @ResponseBody
    public ToJson<Message> selectMessage(HttpServletRequest request, HttpServletResponse response, Message message, String export, Integer page, Integer pageSize, boolean useFlag){
        return messageService.selectMessage(request,response,message,export,page,pageSize,useFlag);
    }

    /**
     * 根据主键查询 message
     * @return
     */
    @RequestMapping("/details")
    @ResponseBody
    public ToJson getMessageInfo(String msgId){
        return messageService.getMessage(msgId);
    }
}
