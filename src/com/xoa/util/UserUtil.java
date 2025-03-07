package com.xoa.util;

import com.xoa.model.users.Users;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @作者 李然
 * @创建日期 13:04 2019/7/20
 * @类介绍 获取当前登录人
 *
 */
public class UserUtil {
    /**
    * 创建作者:   李 然
    * 创建日期:   13:05 2019/7/20
    * 方法介绍:   获取当前登陆人
    * 参数说明:   * @param request
    * @return     com.xoa.model.users.Users
    */
    public static Users getUser(HttpServletRequest request){
        Cookie redisSessionCookie1 = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie1);
        return users;
    }

    /**
    * 创建作者:   李 然
    * 创建日期:   10:23 2019/9/18
    * 方法介绍:   获取当前登陆人  不需要传参数
    * 参数说明:   * @param request
    * @return     com.xoa.model.users.Users
    */
    public static Users getUser(){
        HttpServletRequest request= ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest();
        Cookie redisSessionCookie1 = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie1);
        return users;
    }
}
