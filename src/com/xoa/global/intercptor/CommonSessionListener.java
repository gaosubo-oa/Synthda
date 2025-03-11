package com.xoa.global.intercptor;

import com.xoa.controller.login.loginController;
import com.xoa.model.users.Users;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Created by 韩东堂on 2017/6/27.
 */
public class CommonSessionListener implements HttpSessionListener {
    private CommonSessionContext myc = CommonSessionContext.getInstance();

   @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        myc.AddSession(httpSessionEvent.getSession());
    }
    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
       //这里用户信息时存在cookie中的，这里没有request对象，因为未开启，暂时用session获取，后期需要修改机制。移除在线人数

        HttpSession session = httpSessionEvent.getSession();
        Users sessionInfo = SessionUtils.getSessionInfo(session, Users.class, new Users());
        String userId = sessionInfo.getUserId();
        if(!StringUtils.checkNull(userId)){
            loginController.userCountMap.remove(userId);
        }

        myc.DelSession(session);
    }
}
