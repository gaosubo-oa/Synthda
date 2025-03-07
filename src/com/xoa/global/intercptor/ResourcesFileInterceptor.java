package com.xoa.global.intercptor;

import com.xoa.util.common.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResourcesFileInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception {
        String url = httpServletRequest.getRequestURI();
        if(url.startsWith(httpServletRequest.getContextPath())){
            url = url.substring(httpServletRequest.getContextPath().length());
        }
        httpServletRequest.getParameter("file");
        //不在拦截范围内，放行（后续此处可根据需要扩展）
        if(!url.contains("/lib/ofdViewer/showofd/showofd.html")){
            return true;
        }
        //在拦截范围内，验证（file只允许访问/download接口）
        String file = httpServletRequest.getParameter("file");
        if(StringUtils.checkNull(file) || !file.startsWith("/download?")){
            return false;
        }
        return true;
    }
}
