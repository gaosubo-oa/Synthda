package com.xoa.controller.menu;

import com.xoa.service.menu.SelectMenuService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrappers;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by liu on 2017/6/20.
 * 作者：刘佩峰
 * 时间：2017/6/20
 */
@Controller
@Scope(value = "prototype")
public class SelectMenuController {

    @Resource
    private SelectMenuService selectMenuService;
    private int flag;
    private String err = "err";
    private String ok = "ok";


    @ResponseBody
    @RequestMapping(value = "/showNewMenu", method = RequestMethod.GET, produces= {"application/json;charset=UTF-8"})
    public BaseWrappers showNew(HttpServletRequest request, HttpServletResponse response) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");


        return selectMenuService.getAll(locale);
    }
}
