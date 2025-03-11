package com.xoa.global.Xss;


import com.xoa.util.common.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * 
 * 创建时间：2017年10月24日 下午1:34:04
 * @author zlf
 * @version 1.0
 * 文件名称：XssFilter.java
 * 类说明：Xss跨脚本攻击过滤器
 */
public class XssFilter implements Filter {

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain) throws IOException, ServletException {
       String servletPath = ((HttpServletRequest) request).getServletPath()  ;    //请求页面或其他地址
        String contentType = request.getContentType();
        boolean check = true;
        //过滤接口集合
        String url[] = { "/form/"
                };
        int length = url.length;
        for (int i=0;i<length;i++){
            if (servletPath.contains(url[i])){
                chain.doFilter(request , response);
                check = false;
                break;
            }
        }
        if (check){
            if (!StringUtils.checkNull(contentType) && contentType.contains("application/json")) {
                chain.doFilter(new XSSBodyRequestWrapper((HttpServletRequest) request), response);
            }else {
                chain.doFilter(new XssHttpServletRequestWrapper((HttpServletRequest) request), response);
            }
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {

    }

}