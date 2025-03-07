package com.xoa.util.sso;

import edu.yale.its.tp.cas.client.IContextInit;

import javax.servlet.FilterChain;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


public class PwegSsoUtil implements IContextInit{


    public String getTranslatorUser(String userName)
    {
        return userName;
    }

    public void initContext(ServletRequest request, ServletResponse response, FilterChain fc, String userName)
    {
        ((HttpServletRequest)request).getSession().setAttribute("userName", userName);
    }
}
