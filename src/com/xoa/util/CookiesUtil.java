package com.xoa.util;

import com.xoa.util.common.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

public class CookiesUtil {
    static   Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();

    /**
     * 根据名字获取cookie
     *
     * @param request
     * @param name    cookie名字
     * @return
     */
    public static Cookie getCookieByName(HttpServletRequest request, String name) {
        if(!StringUtils.checkNull(name)){
            Cookie[] cookies = request.getCookies();
            if(cookies!=null){
                for (int i=0,length=cookies.length;i<length;i++){
                    if(name.equals(cookies[i].getName())){
                        return cookies[i];
                    }
                }
            }
        }
        return null;
    }

    /**
     * 将cookie封装到Map里面
     *
     * @param request
     * @return
     */
    public static Map<String, Cookie> ReadCookieMap(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();
        if (null != cookies) {
            for (Cookie cookie : cookies) {
                cookieMap.put(cookie.getName(), cookie);
            }
        }
        return cookieMap;
    }

    /**
     * 保存Cookies
     *
     * @param response servlet请求
     * @param value    保存值
     * @author jxf
     */
    public static void  setCookie(HttpServletResponse response, String name, String value) {
        // new一个Cookie对象,键值对为参数
        Cookie cookie = null;
        // 如果cookie的值中含有中文时，需要对cookie进行编码，不然会产生乱码
        try {
        cookie = new Cookie(URLEncoder.encode(name, "utf-8"),
                URLEncoder.encode(value, "utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        // tomcat下多应用共享
        cookie.setPath("/");
        cookie.setMaxAge(1440 * 60);
        // 将Cookie添加到Response中,使之生效
        response.addCookie(cookie); // addCookie后，如果已经存在相同名字的cookie，则最新的覆盖旧的cookie

    }
}