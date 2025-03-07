package com.xoa.controller.sys;

import com.xoa.model.sys.Connect;
import com.xoa.model.sys.ConnectUser;
import com.xoa.service.sys.AppConnectService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Controller
@RequestMapping("/connect")
public class AppConnectController {

    @Autowired
    AppConnectService appConnectService;

    @RequestMapping("/selectConnect")
    public String selectConnect() {
        return "/app/sys/AppConnect";
    }

    @RequestMapping("/selectConnect1")
    public String selectConnect1() {
        return "/app/sys/AppConnect1";
    }


    /**
     * 查找全部第三方应用信息
     * @param page
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping("/selectAllAppConnect")
    public ToJson<Connect> selectAllAppConnect(String page, String pageSize){
        return appConnectService.selectAllAppConnect(page,pageSize);
    }

    /**
     * 添加第三方应用信息
     * @param connect
     * @return
     */
    @ResponseBody
    @RequestMapping("/insertAllAppConnect")
    public ToJson<Connect> insertAllAppConnect(Connect connect){
        return appConnectService.insertAllAppConnect(connect);
    }

    /**
     * 修改第三方应用信息
     * @param connect
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateAllAppConnect")
    public ToJson<Connect> updateAllAppConnect(Connect connect){
        return appConnectService.updateAllAppConnect(connect);
    }
    /**
     * 删除第三方应用信息
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteAllAppConnect")
    public ToJson<Connect> deleteAllAppConnect(Integer aid){
        return appConnectService.deleteAllAppConnect(aid);
    }


    /**
     * 查找全部用户映射数据
     * @param page
     * @param limit
     * @return
     */
    @ResponseBody
    @RequestMapping("/selectAllAppUserConnect")
    public ToJson<ConnectUser> selectAllAppUserConnect(String page, String limit){
        return appConnectService.selectAllAppUserConnect(page,limit);
    }

    /**
     * 添加用户映射数据
     * @param connectUser
     * @return
     */
    @ResponseBody
    @RequestMapping("/insertAllAppUserConnect")
    public ToJson<ConnectUser> insertAllAppUserConnect(ConnectUser connectUser){
        return appConnectService.insertAllAppUserConnect(connectUser);
    }

    /**
     * 修改用户映射数据
     * @param connectUser
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateAllAppUserConnect")
    public ToJson<ConnectUser> updateAllAppUserConnect(ConnectUser connectUser){
        return appConnectService.updateAllAppUserConnect(connectUser);
    }

    /**
     * 删除用户映射数据
     * @param auid
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteAllAppUserConnect")
    public ToJson<ConnectUser> deleteAllAppUserConnect(String auid){
        return appConnectService.deleteAllAppUserConnect(auid);
    }


    @ResponseBody
    @RequestMapping("/syslogin")
    public ToJson<Object> AppConnectLogin(String app_id, String appName, String access_token, String redirect_uri, String user_id, HttpServletResponse response, HttpServletRequest request){
        return appConnectService.AppConnectLogin(app_id,appName,access_token,redirect_uri,user_id,response,request);
    }

    @ResponseBody
    @RequestMapping("/syslogin2")
    public ToJson<Object> AppConnectLogin2(String app_id, String appName, String access_token, String user_id, String user_md5, HttpServletResponse response, HttpServletRequest request){
        return appConnectService.AppConnectLogin2(app_id,appName,access_token,user_id,response,request,user_md5);
    }

    @ResponseBody
    @RequestMapping("/getAccessToken")
    public ToJson<Object> getAccessToken(){
        return appConnectService.getAccessToken();
    }

    @ResponseBody
    @RequestMapping("/getXunGeng")
    public ToJson<Object> getXunGeng(HttpServletRequest request, HttpServletResponse response){
        return appConnectService.getXunGeng(request,response);
    }

}
