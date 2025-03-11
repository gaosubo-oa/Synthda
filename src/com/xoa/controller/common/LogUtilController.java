package com.xoa.controller.common;

import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;



/**
 * 日志
 * 
 * @author gaosubo
 * @version 1.0
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/diary_")
public class LogUtilController {


	/**
	 * 日志
	 * 
	 * @return
	 */
	@RequestMapping("/index")

	public String inboxPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/diary/index";
	}

	/**
	 * 写日志
	 * 
	 * @return
	 */
	@RequestMapping("/addbox")
	public String addboxPage(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/diary/writeMail";
	}
	/**
	 * 根据ID删除一条邮件`
	 */
	

}
