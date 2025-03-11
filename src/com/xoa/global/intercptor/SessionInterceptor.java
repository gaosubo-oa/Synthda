package com.xoa.global.intercptor;

import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * Created by pfl on 2017/12/8.
 */
public class SessionInterceptor implements HandlerInterceptor {

    private String loginUrl;
    private String loginUrlV1;

    private String welcomUrl;

    private String redirectUrl;

    private String mainUrl;

    public String getLoginUrlV1() {
        return loginUrlV1;
    }

    public void setLoginUrlV1(String loginUrlV1) {
        this.loginUrlV1 = loginUrlV1;
    }

    public String getLoginUrl() {
        return loginUrl;
    }

    public void setLoginUrl(String loginUrl) {
        this.loginUrl = loginUrl;
    }

    public String getWelcomUrl() {
        return welcomUrl;
    }

    public void setWelcomUrl(String welcomUrl) {
        this.welcomUrl = welcomUrl;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    public String getMainUrl() {
        return mainUrl;
    }

    public void setMainUrl(String mainUrl) {
        this.mainUrl = mainUrl;
    }

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        String visitUrl = httpServletRequest.getRequestURI();
        if(httpServletRequest.getSession().getMaxInactiveInterval() > 0 && !Objects.isNull(httpServletRequest.getSession().getAttribute("expiryTimeSet"))) {
            // 获取当前时间
            long now = System.currentTimeMillis();
            // 获取最大不活动时间间隔
            long maxInactiveInterval = httpServletRequest.getSession().getMaxInactiveInterval() * 1000;
            //TODO 判断需要过滤处理的接口，做成配置，测试先写死
            if (visitUrl.contains("/smsListByType") || visitUrl.contains("/getOnlineCount") || visitUrl.contains("/getSysMessage")
                    || visitUrl.contains("/selectProjectId")) {
                // 获取最近一次设置的失效时间
                Object expiryTime = httpServletRequest.getSession().getAttribute("expiryTime");

                // 计算 session 还有多长时间失效（以秒为单位）
                Integer exact;
                if (expiryTime == null) {
                    // 获取session 的创建时间
                    long creationTime = httpServletRequest.getSession().getCreationTime();
                    long timeToExpire = creationTime + maxInactiveInterval - now;
                    exact = Math.toIntExact(timeToExpire / 1000);
                } else {
                    exact = Math.toIntExact(((long) expiryTime - now) / 1000);
                }
                if (exact > 0) {
                    httpServletRequest.getSession().setMaxInactiveInterval(exact);
                }
                System.out.println("preHandlepreHandle====" + httpServletRequest.getSession().getMaxInactiveInterval());
            } else {
                Integer expiryTimeSet = (Integer) httpServletRequest.getSession().getAttribute("expiryTimeSet");
                httpServletRequest.getSession().setMaxInactiveInterval(expiryTimeSet / 1000);
                long newExpiryTime = now + expiryTimeSet;
                httpServletRequest.getSession().setAttribute("expiryTime", newExpiryTime);
            }
        }

        Cookie redisSessionId = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
        if (visitUrl.equals(loginUrl) || visitUrl.equals(loginUrlV1)) {
            ContextHolder.setConsumerType("");
            httpServletRequest.getSession().invalidate();//让SESSION失效
            SessionUtils.cleanUserSession(httpServletRequest.getSession(),redisSessionId);
            return true;
        }
        Users user = null;
        String testIds = httpServletRequest.getParameter("JSESSIONID1");
        if (!StringUtils.checkNull(testIds)) {
            HttpSession session = null;
            CommonSessionContext myContext = CommonSessionContext.getInstance();
            session = myContext.getSession(testIds);
            if (session != null) {
                HttpSession sessionNow = httpServletRequest.getSession();
                ContextHolder.setConsumerType("xoa" + (String) session.getAttribute(
                        "loginDateSouse"));
                user = SessionUtils.getSessionInfo(session, Users.class, new Users(),redisSessionId);
                SessionUtils.putSession(sessionNow, user,redisSessionId);
                SessionUtils.putSession(sessionNow, "loginDateSouse", (String) session.getAttribute(
                        "loginDateSouse"),redisSessionId);
                SessionUtils.putSession(sessionNow, "InterfaceModel", (String) session.getAttribute(
                        "InterfaceModel"),redisSessionId);
            }
        }
        if (user == null || user.getUid() == null) {
        } else {
            return true;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        String ids=  httpServletRequest.getParameter("JSESSIONID1");
        httpServletRequest.setAttribute("JSESSIONID1", ids);
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
