package com.xoa.controller.sys;

import com.xoa.dao.sys.SysLogMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.Syslog;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import java.util.regex.Pattern;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/31 18:01
 * @类介绍: 系统参数类
 * @构造参数: 无
 **/
@Controller
@RequestMapping("sys")
public class SystemInfoController {

    @Resource
    private SystemInfoService systemInfoService;
    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SysInterfaceMapper sysInterfaceMapper;

    @Autowired
    private SysLogMapper sysLogMapper;

    @Resource
    private UserFunctionService userFunctionService;

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 19:54
     * @函数介绍: 获取系统信息
     * @参数说明: @param request
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/getSysMessage")
    public ToJson<Object> getSysMessage(HttpSession session ,HttpServletRequest request) {


        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        ToJson<Object> toJson = new ToJson<Object>(0, "");

        try {

            String realPath = request.getSession().getServletContext().getRealPath("/");
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, locale,request);

            if(map==null){
                toJson.setObject(systemInfoService.getSystemInfoDefault(realPath, locale,request));
                toJson.setMsg(I18nUtils.getMessage("main.th.notRegistered"));
                return toJson;
            }

            //当前用户是否拥有系统信息菜单权限，拥有权限可返回系统信息
            if(user!=null&&user.getUserId()!=null){
                if(!userFunctionService.checkPriv(request, "38")){
                    //无权限返回必要信息
                    Map<String, String> authMap = new HashMap<>();
                    authMap.put("isSoftAuth",map.get("isSoftAuth"));

                    toJson.setObject(authMap);
                    toJson.setMsg("OK");
                    toJson.setFlag(0);
                    return toJson;
                }
            }

            toJson.setObject(map);
            toJson.setMsg("OK");
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("err");
        }

        return toJson;
    }


    /**
     * @创建作者: 张丽军
     * @创建日期: 2019/4/18 16:48
     * @函数介绍: 写入信息生成授权文件
     * @参数说明:
     * @return: json
     **/
    @RequestMapping(value = "/importLec")
    @ResponseBody
    public ToJson<Object> importLec(String fileString, HttpServletRequest request) throws Exception {
        ToJson<Object> toJson = new ToJson<Object>(0, "");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try {
            //判断字符串为不为空
            if (fileString != null && !fileString.equals("")) {
                //fileString =  java.net.URLDecoder.decode(fileString,"UTF-8");
                //新文件
                File newFile = new File(realPath.concat("/authfiles/xoa2019.dat"));

                //将字符串写入新文件
                try (FileWriter writer = new FileWriter(newFile);){
                    String str = fileString.substring(0,7);
                    if(str.equals("gaosubo")==true){

                        writer.write(fileString);
                    }else{
                        String fileString0 = "gaosuboisnumber1-79,-79,-66,-87,-68,-81,-51,-59,-41,-36,-71,-85,-53,-66,@123456789qwertyuiopasdfghjklzxcvbnm,.-@39amKearhtfuLiwH0EN/Wbey4dpcyuO5+wqjucCioXR2ZyxsQOkxm8Aa9X1P2bO2jYbPhcNdvcSIpgSgIKzDHSedVLxeiqVF/";

                        writer.write(fileString0);
                    }
                    writer.flush();
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            toJson.setFlag(0);
            toJson.setMsg("文件写入成功");

        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }





    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 15:48
     * @函数介绍: 上传授权文件
     * @参数说明:
     * @return: json
     **/
    @RequestMapping(value = "/uploadLec")
    @ResponseBody
    public ToJson<Object> editItemSubmit(MultipartFile lecFile, HttpServletRequest request) throws Exception {
        ToJson<Object> toJson = new ToJson<Object>(0, "");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        boolean isMatch = Pattern.matches(".*dat.*", lecFile.getOriginalFilename());
             if(!isMatch){
                 toJson.setFlag(1);
                 toJson.setMsg("err");
                 return toJson;
             }

        String realPath = request.getSession().getServletContext().getRealPath("/");

        try {
            //实现上传图片
            if (lecFile != null && lecFile.getOriginalFilename() != null
                    && !lecFile.getOriginalFilename().equals("")) {

                //新文件
                File newFile = new File(realPath.concat("/authfiles/xoa2020.dat"));
                //将内存中的文件内容写入磁盘上
                lecFile.transferTo(newFile);
            }
            toJson.setFlag(0);
            toJson.setMsg("授权成功");

        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");

        }

        return toJson;
    }
        @RequestMapping(value = "/getAPPMessage")
    @ResponseBody
    public ToJson<Object> getAPPMessage(HttpServletRequest request){
        Map<String, String> map=systemInfoService.getAPPMessage();


        ToJson<Object> toJson = new ToJson<Object>(0, "");

        toJson.setMsg("OK");
        toJson.setFlag(0);
        toJson.setObject(map);

    return toJson;
    }

    @ResponseBody
    @RequestMapping("/isLoginRole")
    public ToJson<Object> isLoginRole(HttpServletRequest request, HttpServletResponse response){
        ToJson<Object> json = new ToJson<Object>(0, "");

        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try{
            Map<String, String> m = systemInfoService.getSystemInfo(realPath, locale, request);
            int oaUserLimit=0;
            if(m!=null){
                if("不限制".equals(m.get("oaUserLimit"))){

                }else{
                    //授权人数
                    oaUserLimit = Integer.parseInt(m.get("oaUserLimit"));
                }
            }
            Map<String,String> endLecDate= systemInfoService.getEndLecDate(request);
            String  useEndDate=  endLecDate.get("useEndDate");
            String  endLecDateStr=   endLecDate.get("endLecDateStr");
            String isAuthStr=endLecDate.get("isAuthStr");
            String usercount = endLecDate.get("usercount");
            L.s(useEndDate,"0=||===========>",endLecDateStr);
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            String msg = "";
            if(user.getUserId()!=null){
                json.setTurn(true);
            }else{
                msg= I18nUtils.getMessage("main.th.theCurrentUserIsNotLoggedIn");
                json.setMsg(msg);
                InterfaceModel template = sysInterfaceMapper.getTemplate();
                json.setObject(template.getTemplate());
                json.setTurn(false);
            }
            //允许登录用户数
            int canLoginUser = usersMapper.getLoginUserCount();
            if(oaUserLimit!=0){
                if (canLoginUser > oaUserLimit) {
                    json.setCode(LoginState.LOGINTIME);
                    msg=I18nUtils.getMessage("main.th.theUserHasReachedTheUpperLimit");
                    json.setMsg(msg);
                    json.setTurn(true);
                    return json;
                }
            }
            if(checkTimeOut(useEndDate,endLecDateStr,isAuthStr,usercount)){//验证到期{
                if(MobileCheck.isMobileDevice(request.getHeader("user-agent"))){
                }else{
                    SessionUtils.putSession(request.getSession(), "checkRegister", "1", redisSessionCookie);
                    msg=I18nUtils.getMessage("main.th.becomeDue");
                    json.setMsg(msg);
                    json.setTurn(true);
                }
            }


        }catch (Exception e){
            e.printStackTrace();
        }
        return  json;
    }

    // 获取未注册版本 剩余天数
    @ResponseBody
    @RequestMapping("/noRegisterInfo")
    public ToJson<Object> noRegisterInfo(HttpServletRequest request){
        ToJson<Object> json = new ToJson<>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            json.setObject(99999999);
            json.setMsg("已注册");
            // 判断是否是管理员 如果是的话 检查磁盘空间
            if(user.getUserPriv()==1){
                File diskPartition  = null;
                String osName = System.getProperty("os.name");
                if(osName.startsWith("win")){
                    diskPartition = new File(System.getProperty("user.dir").substring(0,2));
                } else {
                    diskPartition = new File("/");
                }
                json.setData(diskPartition.getUsableSpace()/1024/1024);
            }
            json.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return json;
    }

    private boolean checkTimeOut(String useEndDate, String endLecDateStr,String isAuthStr,String usercount) {
        try{
            //判断是否注册
            if(isAuthStr.equals("true")){
                Date now =new Date();
                if(StringUtils.checkNull(endLecDateStr)){
                    return true;
                }else{
                    if("2040-01-01".equals(endLecDateStr)){
                        return false;
                    }else {
                        Date timeOut= DateFormat.DateToStr(endLecDateStr);
                        if(timeOut.getTime()<now.getTime()){
                            return true;
                        }
                    }
                }
                if(StringUtils.checkNull(useEndDate)){
                    return true;
                }else if(useEndDate.equals("0000-00-00")){
                    return false;
                }else{
                    Date timeOut= DateFormat.DateToStr(useEndDate);
                    if(timeOut.getTime()<now.getTime()){
                        return true;
                    }
                }
            }else{
                //先去判断用户数是否是30
                if(usercount.equals("30")){
                    return  false;
                }
                Date now =new Date();
                //如果用户数大于50人的话，判断试用是否到期
                if(StringUtils.checkNull(useEndDate)){
                    return true;
                }else if(useEndDate.equals("0000-00-00")){
                    return false;
                }else{
                    Date timeOut= DateFormat.DateToStr(useEndDate);
                    if(timeOut.getTime()<now.getTime()){
                        return true;
                    }
                }
            }

        }catch (Exception e){
            e.printStackTrace();
            return true;
        }
        return false;
    }



}