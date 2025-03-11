package com.xoa.controller.wechat;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatCommentReply;
import com.xoa.service.wechat.WeChatCommentReply.WeChatCommentReplyService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2017/10/13.
 */
@Controller
@RequestMapping("/weChatCommentReply")
public class WeChatCommentReplyController {
    @Resource
    private WeChatCommentReplyService weChatCommentReplyService;

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午14:10:17
     * 方法介绍：添加微讯评论回复
     * 参数说明：
     */
    @RequestMapping("/insertWeChatCommentReply")
    @ResponseBody
    public ToJson<WeChatCommentReply> insertWeChatCommentReply(WeChatCommentReply weChatCommentReply, HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return  weChatCommentReplyService.insertWeChatCommentReply(weChatCommentReply,user);

    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午14:15:17
     * 方法介绍：根据微讯ID 微讯评论ID 查询微讯评论回复
     * 参数说明：
     */
    @RequestMapping("/selectWeChatCommentReply")
    @ResponseBody
    public ToJson<WeChatCommentReply>  selectWeChatCommentReply(Integer wid,Integer cid){
        return weChatCommentReplyService.selectWeChatCommentReply(wid,cid);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-23 下午15:15:17
     * 方法介绍：根据回复表ID 删除回复内容
     * 参数说明：
     */
    @RequestMapping("/deleteByPrimaryKey")
    @ResponseBody
    public ToJson<WeChatCommentReply> deleteByPrimaryKey(Integer rid){
        return weChatCommentReplyService.deleteByPrimaryKey(rid);
    }
}
