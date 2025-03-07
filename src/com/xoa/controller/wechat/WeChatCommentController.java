package com.xoa.controller.wechat;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatComment;
import com.xoa.service.wechat.WeChatComment.WeChatCommentService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by gsb on 2017/10/13.
 */
@Controller
@RequestMapping("/weChatComment")
public class WeChatCommentController {

    @Resource
    private WeChatCommentService weChatCommentService;

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:30:17
     * 方法介绍：添加微讯评论
     * 参数说明：
     */
    @RequestMapping("/insertWeChatComment")
    @ResponseBody
    public ToJson<WeChatComment> insertWeChatComment(WeChatComment weChatComment, HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return weChatCommentService.insertWeChatComment(weChatComment,user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午13:30:17
     * 方法介绍：根据微讯ID 查询微讯评论
     * 参数说明：
     */
    @RequestMapping("/selectWeChatCommentByWID")
    @ResponseBody
    public ToJson<WeChatComment> selectWeChatCommentByWID(Integer wid, Map<String,Object> maps, Integer page,
                                                          Integer pageSize, boolean useFlag,HttpServletRequest request){
        return weChatCommentService.selectWeChatCommentByWID(wid,maps, page, pageSize, useFlag);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-23 下午14:30:17
     * 方法介绍：根据评论表主键ID 删除评论及对该评论的回复
     * 参数说明：
     */
    @RequestMapping("/deleteByPrimaryKey")
    @ResponseBody
    public ToJson<WeChatComment> deleteByPrimaryKey(Integer cid,HttpServletRequest request){
        return weChatCommentService.deleteByPrimaryKey(cid);
    }
}
