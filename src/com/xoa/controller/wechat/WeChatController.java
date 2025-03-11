package com.xoa.controller.wechat;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.LikeUser;
import com.xoa.model.wechat.WeChat;
import com.xoa.service.wechat.weChat.WeChatService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by gsb on 2017/10/12.
 */
@Controller
@RequestMapping("/weChat")
public class WeChatController {
    @Resource
    private WeChatService weChatService;

    @RequestMapping("/index")
    public String index(){
        return "app/weChat/index";
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午9:46:17
     * 方法介绍：添加一条微讯信息
     * 参数说明：
     */
    @RequestMapping("/insertWeChat")
    @ResponseBody
    public ToJson<WeChat> insertWeChat(WeChat weChat,  HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return weChatService.insertWeChat(weChat,user);
    }
    /**
     * 创建作者:   季佳伟
     * 创建日期:   2017年10月13日 上午09:48:12
     * 方法介绍:   查询所有微讯  并分页
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     */
    @RequestMapping("/selectWeChat")
    @ResponseBody
    public ToJson<WeChat> selectWeChat(Map<String,Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag,HttpServletRequest request){
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return weChatService.selectWeChat(maps, page, pageSize, useFlag,sqlType,user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:46:17
     * 方法介绍：根据主键修改微讯
     * 参数说明：
     */
    @RequestMapping("/updateWeChatByPrimaryKey")
    @ResponseBody
    public ToJson<WeChat> updateWeChatByPrimaryKey(Integer wid,HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return weChatService.updateWeChatByPrimaryKey(wid,user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-16 上午11:46:17
     * 方法介绍：根据主键查询微讯
     * 参数说明：
     */
    @RequestMapping("/selectWeChatByPrimaryKey")
    @ResponseBody
    public ToJson<WeChat> selectWeChatByPrimaryKey(Integer wid ,HttpServletRequest request){
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        return weChatService.selectWeChatByPrimaryKey(wid,sqlType);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-16 上午11:46:17
     * 方法介绍：根据主键删除微讯及相关的评论 回复  数据
     * 参数说明：
     */
    @RequestMapping("/deleteByPrimaryKey")
    @ResponseBody
    public ToJson<WeChat> deleteByPrimaryKey(Integer wid){
        return weChatService.deleteByPrimaryKey(wid);
    }
    @RequestMapping("/getLikeUser")
    @ResponseBody
    public ToJson<LikeUser> getLikeUser(Integer wid){
        return weChatService.getLikeUser(wid);
    }


}
