package com.xoa.controller.sys;

import com.xoa.model.users.Users;
import com.xoa.service.sys.SysDataBaseService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("sysDataBase")
public class SysDataBaseController {

    @RequestMapping("index")
    public String index(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if(user.getUserPriv()==1){
            return "app/sys/sysDataBase";
        } else {
            return "app/sys/sysDataBaseNoPriv";
        }
    }

    @Autowired
    private SysDataBaseService sysDataBaseService;


    @ResponseBody
    @RequestMapping("selTables")
    private BaseWrapper selTables(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if(user.getUserPriv()==1){
            return sysDataBaseService.selTables(request);
        }
        return null;
    }



    /**
     * 作者: 张航宁
     * 日期: 2020/02/24
     * 说明: 导出指定的表 tables为表名拼接字符串 如 user,user_ext  dataType 为导出类型 0只导出表结构 1同时导出数据
     */
    @ResponseBody
    @RequestMapping("exportTables")
    private void exportTables(HttpServletRequest request, HttpServletResponse response, String tables, String exportType) throws IOException {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if(user.getUserPriv()==1)
            sysDataBaseService.exportTables(request, response, tables, exportType);
    }


}
