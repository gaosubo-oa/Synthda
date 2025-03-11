package com.xoa.service.sys.impl;

import com.itextpdf.io.IOException;
import com.xoa.dao.casConfig.CasConfigMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.dingdingManage.UserDDMapMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.dao.qiyeWeixin.UserWeixinqyMapper;
import com.xoa.dao.sys.ConnectMapper;
import com.xoa.dao.sys.ConnectUserMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.weLink.UserWeLinkMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.sys.Connect;
import com.xoa.model.sys.ConnectUser;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.sys.AppConnectService;
import com.xoa.service.sys.InterFaceService;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.LoginState;
import com.xoa.util.ToJson;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.MachineCode;
import com.xoa.util.page.PageParams;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.*;

@Service
public class AppConnectServiceImpl implements AppConnectService {
    @Autowired
    ConnectMapper connectMapper;
    @Autowired
    ConnectUserMapper connectUserMapper;

    @Resource
    private UsersService usersService;
    @Resource
    private OrgManageService orgManageService;
    @Value("${app_login_path_php}")
    private String url;
    private String charset = "utf-8";
    @Autowired
    UserFunctionMapper userFunctionMapper;
    @Resource
    private SysInterfaceMapper sysInterfaceMapper;
    @Resource
    private SysLogService sysLogService;
    @Autowired
    private SysParaMapper sysParaMapper;
    @Autowired
    private OrgManageMapper orgManageMapper;
    @Autowired
    private UserExtMapper userExtMapper;
    @Resource
    private SyslogMapper syslogMapper;

    @Resource
    SysParaService sysParaService;
    @Resource
    SystemInfoService systemInfoService;
    @Resource
    UsersMapper usersMapper;
    @Resource
    InterFaceService interfaceService;
    @Resource
    private CasConfigMapper casConfigMapper;
    @Resource
    private UserWeixinqyMapper userWeixinqyMapper;
    @Resource
    private UserDDMapMapper userDDMapMapper;
    @Resource
    private UserWeLinkMapper userWeLinkMapper;
    @Autowired
    private AttachmentMapper attachmentMapper;


    @Override
    public ToJson<Connect> selectAllAppConnect(String page, String pageSize) {
        ToJson<Connect> toJson=new ToJson<Connect>(1, "error");
        Map<String,Object> map=new HashMap<>();
        PageParams pageParams=new PageParams();
     /*   pageParams.setPageSize(Integer.parseInt(pageSize));
        pageParams.setPage(Integer.parseInt(page));*/
        pageParams.setUseFlag(true);
        Integer integer = connectMapper.selectAllCount(map);
        //map.put("page", pageParams);
        try {
            List<Connect> connects = connectMapper.selectAll(map);
            toJson.setObject(connects);
            toJson.setTotleNum(integer);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Connect> insertAllAppConnect(Connect connect) {
        ToJson<Connect> toJson=new ToJson<Connect>(1, "error");
        try {
            Map<String,Object> map=new HashMap<>();
            List<Connect> connects = connectMapper.selectAll(map);
            for (Connect connect1:connects){
                if (connect1.getAppId().equals(connect.getAppId())){
                    toJson.setMsg("此应用内部ID已经存在");
                    toJson.setFlag(0);
                    return toJson;
                }
            }
            int insert = connectMapper.insert(connect);

            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Connect> updateAllAppConnect(Connect connect) {
        ToJson<Connect> toJson=new ToJson<Connect>(1, "error");
        try {
            int insert = connectMapper.updateByPrimaryKeySelective(connect);
            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Connect> deleteAllAppConnect(Integer aid) {
        ToJson<Connect> toJson=new ToJson<Connect>(1, "error");
        try {
            int insert = connectMapper.deleteByPrimaryKey(aid);
            List<ConnectUser> connectUsers = connectUserMapper.selectConnectUserByAid(aid);
            if (connectUsers!=null){
                for (ConnectUser connectUser:connectUsers){
                    int i = connectUserMapper.deleteByPrimaryKey(connectUser.getAuid());

                }
            }

            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<ConnectUser> selectAllAppUserConnect(String page, String pageSize) {

        ToJson<ConnectUser> toJson=new ToJson<ConnectUser>(1, "error");
        Map<String,Object> map=new HashMap<>();
        PageParams pageParams=new PageParams();
        pageParams.setPageSize(Integer.parseInt(pageSize));
        pageParams.setPage(Integer.parseInt(page));
        pageParams.setUseFlag(true);
        Integer integer = connectUserMapper.selectAllCount(map);
        map.put("page", pageParams);
        try {
            List<ConnectUser> connects = connectUserMapper.selectAll(map);
            for (ConnectUser connectUser:connects){
                if (!StringUtils.checkNull(connectUser.getAuid()+"")){
                    Connect connect = connectMapper.selectByPrimaryKey(connectUser.getAid());
                    connectUser.setAppName(connect.getAppName());
                }
                if (!StringUtils.checkNull(connectUser.getUserId())){
                    Users byUserId = usersMapper.getByUserId(connectUser.getUserId());
                    connectUser.setUserName(byUserId.getUserName());
                    connectUser.setUserId(byUserId.getByname());
                }

            }
            toJson.setObject(connects);
            toJson.setTotleNum(integer);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<ConnectUser> insertAllAppUserConnect(ConnectUser connectUser) {
        ToJson<ConnectUser> toJson=new ToJson<ConnectUser>(1, "error");
        try {
            int insert = connectUserMapper.insert(connectUser);
            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<ConnectUser> updateAllAppUserConnect(ConnectUser connectUser) {
        ToJson<ConnectUser> toJson=new ToJson<ConnectUser>(1, "error");
        try {
            int insert = connectUserMapper.updateByPrimaryKeySelective(connectUser);
            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<ConnectUser> deleteAllAppUserConnect(String auid) {
        ToJson<ConnectUser> toJson=new ToJson<ConnectUser>(1, "error");
        try {
            int insert = connectUserMapper.deleteByPrimaryKey(Integer.parseInt(auid));

            if (insert > 0) {
                toJson.setMsg("ok");
                toJson.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Object> AppConnectLogin(String app_id, String appName, String access_token, String redirect_uri, String user_id
            , HttpServletResponse response, HttpServletRequest request) {
        ToJson<Object> toJson=new ToJson<Object>(1, "error");
        try {
            if (!StringUtils.checkNull(app_id)){
                Connect connect = connectMapper.selectAppConnectByAppId(app_id);
                if (!StringUtils.checkNull(access_token)){
                    if (access_token.equals(connect.getAccessToken())){
                        List<ConnectUser> connectUsers = connectUserMapper.selectConnectUserByAid(connect.getAid());
                        int i=0;
                        for (ConnectUser connectUser:connectUsers){
                            Users usersByuserId = usersService.getUsersByuserId(connectUser.getUserId());
                            if (connectUser.getAppUser().equals(user_id)||usersByuserId.getUserId().equals(user_id)||usersByuserId.getByname().equals(user_id)){
                                i++;
                                String userId = connectUser.getUserId();
                                ToJson<Users> usersToJson = this.jsnopLoginEnter2(userId, null, null, null, null, request
                                        , response);

                                String msg = usersToJson.getMsg();
                                if (StringUtils.checkNull(msg)){
                                    toJson.setMsg("jessionId 生成失败");
                                    toJson.setFlag(1);
                                    return toJson;
                                }
                                try {
                                    if (StringUtils.checkNull(redirect_uri)){
                                        toJson.setMsg("您需要访问的路径不能为空");
                                        toJson.setFlag(1);
                                        return toJson;
                                    }
                                    redirect_uri = URLDecoder.decode(redirect_uri, "UTF-8");

                              /*       if (redirect_uri.contains("flowId")){
                                        //ToJson<FlowFast> flowFastToJson = wfeFlowRunInfo.workFastAdd(user, fflowId, fflowStep, fprcsId, "", request, sqlType, frunName, null);
                                        *//*if (flowFastToJson.isFlag()) {
                                            FlowFast fast = (FlowFast) flowFastToJson.getObject();
                                            Integer runId = fast.getFlowRun().getRunId(); //xin
                                            Integer flowId = fast.getFlowRun().getFlowId();
                                        }*//*
                                    }
                                        String sqlType = "xoa" + (String) request.getSession().getAttribute(
                                                "loginDateSouse"); //当前库*/


                                    Users user = usersMapper.getByUserId(userId);
                                    List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
                                    if (0 == user.getTheme()) {
                                        user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
                                    }
                                    String theme = "theme" + user.getTheme();
                                    Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                                    SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);
                                    String[] split = redirect_uri.split("\\?");
                                    String url;
                                    if (split.length>1){
                                        url=redirect_uri+"&JSESSIONID1="+msg;

                                    }else{
                                        url=redirect_uri+"?JSESSIONID1="+msg;

                                    }

                                    String urlIndex = url.substring(0,url.indexOf("?"));
                                    String parameter = url.substring(url.indexOf("?") + 1);
                                    String[] strings = parameter.split("&");
                                    int c=0;
                                    StringBuffer stringBuffer=new StringBuffer();
                                    for (String s:strings){
                                        String[] string = s.split("=", 2);
                                        if (string.length!=1){
                                            if (c==0){
                                                stringBuffer.append(urlIndex+"?"+string[0]+"="+java.net.URLEncoder.encode(string[1], "UTF-8"));
                                            }else {
                                                stringBuffer.append("&"+string[0]+"="+java.net.URLEncoder.encode(string[1], "UTF-8"));
                                            }
                                            c++;
                                        }else {
                                            stringBuffer.append(java.net.URLEncoder.encode("&"+string[0],"UTF-8"));
                                        }

                                    }
                                    response.sendRedirect(stringBuffer.toString());

                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                    } catch (IOException e) {
                                        e.printStackTrace();
                                    }
                                }
                               /* String[] split = resultString.split("\"object\":");
                                String s = split[1];
                                String[] split = resultString.split("\"object\":");
                                String s = split[1];*/
                                toJson.setMsg("ok");
                                toJson.setFlag(0);
                                //toJson.setObject(resultString);

                                return toJson;
                                //"/appConnect/selectAllAppConnect";

                            }
                        }
                        if (i==0){
                            Users userByName = usersMapper.findUserByName(user_id);
                            if(userByName==null){
                                userByName = usersMapper.getByUserId(user_id);
                            }
                            ToJson<Users> usersToJson = this.jsnopLoginEnter2(userByName.getUserId(), null, null, null, null, request
                                    , response);

                            String msg = usersToJson.getMsg();
                            if (StringUtils.checkNull(msg)){
                                toJson.setMsg("jessionId 生成失败");
                                toJson.setFlag(1);
                                return toJson;
                            }
                            try {
                                if (StringUtils.checkNull(redirect_uri)){
                                    toJson.setMsg("您需要访问的路径不能为空");
                                    toJson.setFlag(1);
                                    return toJson;
                                }
                                redirect_uri = URLDecoder.decode(redirect_uri, "UTF-8");

                              /*       if (redirect_uri.contains("flowId")){
                                        //ToJson<FlowFast> flowFastToJson = wfeFlowRunInfo.workFastAdd(user, fflowId, fflowStep, fprcsId, "", request, sqlType, frunName, null);
                                        *//*if (flowFastToJson.isFlag()) {
                                            FlowFast fast = (FlowFast) flowFastToJson.getObject();
                                            Integer runId = fast.getFlowRun().getRunId(); //xin
                                            Integer flowId = fast.getFlowRun().getFlowId();
                                        }*//*
                                    }
                                        String sqlType = "xoa" + (String) request.getSession().getAttribute(
                                                "loginDateSouse"); //当前库*/


                                Users user = usersMapper.getByUserId(userByName.getUserId());
                                List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
                                if ("0" .equals(user.getTheme())) {
                                    user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
                                }
                                String theme = "theme" + user.getTheme();
                                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                                SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);
                                String[] split = redirect_uri.split("\\?");
                                String url;
                                if (split.length>1){
                                    url=redirect_uri+"&JSESSIONID1="+msg;

                                }else{
                                    url=redirect_uri+"?JSESSIONID1="+msg;

                                }

                                String urlIndex = url.substring(0,url.indexOf("?"));
                                String parameter = url.substring(url.indexOf("?") + 1);
                                String[] strings = parameter.split("&");
                                int c=0;
                                StringBuffer stringBuffer=new StringBuffer();
                                for (String s:strings){
                                    String[] string = s.split("=", 2);
                                    if (string.length!=1){
                                        if (c==0){
                                            stringBuffer.append(urlIndex+"?"+string[0]+"="+java.net.URLEncoder.encode(string[1], "UTF-8"));
                                        }else {
                                            stringBuffer.append("&"+string[0]+"="+java.net.URLEncoder.encode(string[1], "UTF-8"));
                                        }
                                        c++;
                                    }else {
                                        stringBuffer.append(java.net.URLEncoder.encode("&"+string[0],"UTF-8"));
                                    }
                                }
                                response.sendRedirect(stringBuffer.toString());
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                               /* String[] split = resultString.split("\"object\":");
                                String s = split[1];
                                String[] split = resultString.split("\"object\":");
                                String s = split[1];*/
                            toJson.setMsg("ok");
                            toJson.setFlag(0);
                            //toJson.setObject(resultString);

                            return toJson;
                        }
                    }else{
                        toJson.setMsg("您的accessToken输入错误");
                        toJson.setFlag(1);
                        return toJson;
                    }
                }else {
                    toJson.setMsg("您的accessToken不能为空");
                    toJson.setFlag(1);
                    return toJson;
                }
            }else{
                toJson.setMsg("您的应用内部ID为空");
                toJson.setFlag(1);
                return toJson;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Object> AppConnectLogin2(String app_id, String appName, String access_token, String user_id
            , HttpServletResponse response, HttpServletRequest request, String user_md5) {
        ToJson<Object> toJson=new ToJson<Object>(1, "error");
        try {
            if (!StringUtils.checkNull(app_id)){
                Connect connect = connectMapper.selectAppConnectByAppId(app_id);
                if (!StringUtils.checkNull(access_token)){
                    if (access_token.equals(connect.getAccessToken())){
                        //必须保持16位//
                        SysPara oaConnectKey = sysParaMapper.querySysPara("OA_CONNECT_KEY");
                        if(Objects.isNull(oaConnectKey)){
                            toJson.setMsg("KEY IS NULL");
                            toJson.setFlag(1);
                            return toJson;
                        }
                        //String key="XOA2020AESKEY001";
                        //user_md5="/0bxOi0spLPW01MaUc+vgQ==";
                        //byte[] contentByte=user_md5.getBytes();
                        // byte[] resultByte=AESUtils.Encrypt(contentByte, key);
                        //String encoded = Base64.encodeBase64String(contentByte);
                        byte[] decoded = Base64.decodeBase64(user_md5);
                        byte[] base64ResultByte= AESUtil.Decrypt(decoded, oaConnectKey.getParaValue());
                        String s = new String(base64ResultByte,"UTF-8");

                        Users users = usersMapper.selectUserAllInfoByNameAndUserId(user_id);
                        if (!Objects.isNull(users) && !StringUtils.checkNull(users.getByname())) {
                            user_id = users.getByname();
                        }

                        Boolean isPassWordRight = false;
                        //开启了域登录验证，并且userMap中存在用户映射，走域验证，否则执行OA正常验证
                        isPassWordRight = usersService.checkPassWordUser(user_id, users.getPassword(),s);

                        if (isPassWordRight){
                            Users userInfo = new Users();
                            userInfo.setUserId(users.getUserId());
                            userInfo.setByname(users.getByname());
                            userInfo.setUserName(users.getUserName());
                            userInfo.setNotLogin(users.getNotLogin());
                            userInfo.setDeptId(users.getDeptId());
                            Users usersMapperByUid = usersMapper.getByUid(users.getUid());
                            userInfo.setDeptName(Objects.isNull(usersMapperByUid) ? "" : usersMapperByUid.getDeptName());

                            toJson.setData(userInfo);
                            toJson.setMsg("密码正确");
                            toJson.setFlag(0);
                            return toJson;
                        }else {
                            toJson.setMsg("密码错误");
                            toJson.setFlag(1);
                            return toJson;
                        }

                    }else{
                        toJson.setMsg("您的accessToken输入错误");
                        toJson.setFlag(1);
                        return toJson;
                    }
                }else {
                    toJson.setMsg("您的accessToken不能为空");
                    toJson.setFlag(1);
                    return toJson;
                }
            }else{
                toJson.setMsg("您的应用内部ID为空");
                toJson.setFlag(1);
                return toJson;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }
    @Override
    public ToJson<Object> getAccessToken() {

        String uuid = getUUID();
        ToJson<Object> toJson=new ToJson<Object>(1, "error");
        toJson.setMsg("ok");
        toJson.setFlag(0);
        toJson.setObject(uuid);
        return toJson;
    }

    @Override
    public ToJson<Object> getXunGeng(HttpServletRequest request, HttpServletResponse response) {



        return null;
    }


    public static String getUUID() {
        UUID uuid = UUID.randomUUID();
        String str = uuid.toString();
        // 去掉"-"符号
        String temp = str.substring(0, 8) + str.substring(9, 13) + str.substring(14, 18) + str.substring(19, 23) + str.substring(24);
        return temp;
    }
    //获得指定数量的UUID
    public static String[] getUUID(int number) {
        if (number < 1) {
            return null;
        }
        String[] ss = new String[number];
        for (int i = 0; i < number; i++) {
            ss[i] = getUUID();
        }
        return ss;
    }



    public ToJson<Users> jsnopLoginEnter2(@RequestParam("username") String username,
                                          @RequestParam("password") String password, String loginId, String userAgent, String locales,
                                          HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min

        CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
        Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());

        boolean jsonP = false;
        String cb = request.getParameter("callback");
      /*  if (cb != null) {
            jsonP = true;
            response.setContentType("text/javascript");
        } else {
            response.setContentType("application/x-json");
        }
        PrintWriter out = null;
        out = response.getWriter();
        if (jsonP) {
            out.write(cb + "(");
        }*/

        if (StringUtils.checkNull(loginId)) {
            loginId = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(loginId)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                }
            }
        }
        SessionUtils.putSession(request.getSession(), "loginDateSouse", loginId, redisSessionCookie);
        SessionUtils.putSession(request.getSession(), "LOCALE_SESSION_ATTRIBUTE_NAME", locales, redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>(0, null);
        if (StringUtils.checkNull(username)) {
            json.setFlag(1);
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setMsg("用户名或用户不存在");
            // 这里主要关闭。
            return  json;
        }
        ContextHolder.setConsumerType("xoa" + loginId);
        Users user = usersMapper.getByUserId(username);
        if (user == null) {
            request.getSession().setAttribute("message", "errOne");
            json.setMsg("用户名或用户不存在");
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setFlag(1);
            return  json;

        }
        String httpOrgCreateTestRtn = "ok\n\n";
        Boolean isPassWordRight = true;
        if (httpOrgCreateTestRtn.trim().equals("ok")) {

            if (MobileCheck.isMobileDevice(request.getHeader("user-agent"))) {
                if (user.getNotMobileLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    return  json;
                }
            } else {
                if (user.getNotLogin() == 1) {
                    request.getSession().setAttribute("message", "禁止登录");
                    json.setMsg("用户禁止登录");
                    json.setCode(LoginState.LOGINOUTERR);
                    json.setFlag(1);
                    return  json;
                }
            }
            SessionUtils.putSession(request.getSession(), user, redisSessionCookie);
            Map<String, Object> params = new HashMap<String, Object>();
            String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
            /*params.put("paraName", user.getPara().getParaName());
            params.put("paraValue", user.getPara().getParaValue());
            params.put("functionIdStr", functionIdStr);*/


            json.setMsg(request.getSession().getId());
            json.setToken(request.getSession().getId());

            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            if (0 == user.getTheme()) {
                user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            }
            String theme = "theme" + user.getTheme();
//            SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);
            params.put("InterfaceModel", theme);
            // SessionUtils.putSession(request.getSession(), params, redisSessionCookie);

            if (StringUtils.checkNull(interfaceModels.get(0).getIeTitle())) {
                user.setInterfaceTitle("");
            } else {
                user.setInterfaceTitle(interfaceModels.get(0).getIeTitle());
            }

            user.setAppPropulsionId(this.getMachineCode12());
            json.setObject(user);
            json.setFlag(0);
            user.setLastVisitTime(new Date());
            usersService.updateLoginTime(user);

        } else if (httpOrgCreateTestRtn.trim().equals("err")) {
            usersService.insetErrLog(username);
            request.getSession().setAttribute("message", "errOne");
            json.setMsg(" 用户名或密码错误");
            json.setCode(LoginState.LOGINPASSWORDERR);
            json.setFlag(1);
            return  json;
        }
        return  json;

    }

    public String getMachineCode12() {
        String machineCode = null;
        try {
            SysPara para = sysParaMapper.querySysPara("PUSH_MNO");
            if (para != null && !StringUtils.checkNull(para.getParaValue())) {
                machineCode = para.getParaValue().substring(0, 12);
            } else {
                machineCode = MachineCode.get16CharMacs() == null ? "" : MachineCode.get16CharMacs().get(0);
                SysPara sysPara = new SysPara();
                sysPara.setParaName("PUSH_MNO");
                String jiqima = MachineCode.get16CharMacsType().get(0);
                sysPara.setParaValue(jiqima);
                if (para == null) {
                    sysParaMapper.insertSysPara(sysPara);
                } else {
                    if (StringUtils.checkNull(para.getParaValue())) {
                        sysParaMapper.updateSysPara(sysPara);
                    }
                }

            }
        } catch (Exception e) {
        }
        return machineCode;
    }
    private static String getHeader() {
        String auth = "5417481440" + ":" + "s1gtU@t";
        byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        String authHeader = "Basic " + new String(encodedAuth);
        return authHeader;
    }
}




