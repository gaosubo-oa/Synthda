package com.xoa.controller.duties.dutiesjsp;

import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2018/1/6 0006.
 */

@Controller
@RequestMapping("/duties")
public class DutiesJspController {
  //jsp
    @RequestMapping("/dutiesjsp")
    public String companyInfo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/sys/duties";
    }
}
