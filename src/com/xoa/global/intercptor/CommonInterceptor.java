package com.xoa.global.intercptor;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.casConfig.CasConfigMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.casConfig.CasConfig;
import com.xoa.model.common.SysPara;
import com.xoa.model.users.Users;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.LoginState;
import com.xoa.util.common.L;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

/**
 * Created by 王曰岐 on 2017/5/19.
 */
@Component
public class CommonInterceptor implements HandlerInterceptor {


    @Autowired
    CommonFunctionMemory commonFunctionMemory;
    @Autowired
    SystemInfoServiceImpl systemInfoService;
    @Autowired
    SysParaMapper sysParaMapper;
    @Resource
    private CasConfigMapper casConfigMapper;

    @Autowired
    private UserFunctionMapper userFunctionMapper;

    @Autowired
    private SysFunctionMapper sysFunctionMapper;

    @Autowired
    private UsersMapper usersMapper;


    private List<String> ignoreUrls;

    private String loginUrl;

    private String welcomUrl;

    private String redirectUrl;

    private String mainUrl;

    public String getMainUrl() {
        return mainUrl;
    }

    public void setMainUrl(String mainUrl) {
        this.mainUrl = mainUrl;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
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

    public List<String> getIgnoreUrls() {
        return ignoreUrls;
    }

    public void setIgnoreUrls(List<String> ignoreUrls) {
        this.ignoreUrls = ignoreUrls;
    }

    private static String USER_MANGER = "33";

    private static String DEPT_MANGER = "31";

    private static String PRIV_MANGER = "32";

    private static String BRANCH_USER_MANGER = "2010";

    private static String BRANCH_DEPT_MANGER = "2009";

    private static String FILE_CAB_SETTING = "36";

    private static String SANYUAN_MANGER = "630";

    private static DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object handler) throws Exception {
//        L.s(httpServletRequest.getRequestURL());
        // 判断是否为文件上传请求
        if (httpServletRequest instanceof MultipartHttpServletRequest) {
            if (!Multipart(httpServletRequest)) {
                httpServletResponse.reset();
                httpServletResponse.setCharacterEncoding("UTF-8");
                httpServletResponse.setContentType("application/json;charset=UTF-8");
                PrintWriter pw = httpServletResponse.getWriter();
                pw.write(JSONObject.toJSONString("{\"flag\":false,\"msg\":\"非法上传文件！\"}"));
                return false;
            }
        }
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(httpServletRequest.getSession(), "loginDateSouse", String.class, redisSessionCookie);

        if(!StringUtils.checkNull(loginDateSouse)){
            ContextHolder.setConsumerType("xoa" + loginDateSouse);
        }


        ResourceBundle rb = ResourceBundle.getBundle("redis");
        boolean redisUse = Boolean.parseBoolean(rb.getString("redis.use"));
        Cookie redisSessionId = null;
        if (redisUse) {
            redisSessionId = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
        } else {
            redisSessionId = CookiesUtil.getCookieByName(httpServletRequest, "JSESSIONID1");
        }
        String visitUrl = httpServletRequest.getRequestURI();
        String[] array = visitUrl.split("/");
        String temp = "";
        for (int i = 0; i < array.length; i++) {
            if (!StringUtils.checkNull(array[i])) {
                temp = temp + "/" + array[i];
            }
        }
        if (StringUtils.checkNull(temp)) {
            visitUrl = "/";
        } else {
            visitUrl = temp;
        }

        Map a = httpServletRequest.getParameterMap();
        long startTime = System.currentTimeMillis();
        httpServletRequest.setAttribute("startTime", startTime);
        if (handler instanceof HandlerMethod) {
            HandlerMethod h = (HandlerMethod) handler;
            CommonRequestModel model = new CommonRequestModel();
            model.setUrl(visitUrl);
            model.setVisitTime(dateTimeFormatter.format(LocalDateTime.now()));
            model.setController(h.getBean().getClass().getName());
            model.setMethod(h.getMethod().getName());
//        model.setParamsStr(getParamString(httpServletRequest.getParameterMap()));
//        model.setParams(httpServletRequest.getParameterMap());
            L.s(model);
        }

        if (visitUrl.equals(redirectUrl)) {
            ContextHolder.setConsumerType("");
            return true;
        }
        L.s(loginUrl, "loginUrlloginUrl", visitUrl);
        if (visitUrl.equals(welcomUrl)) {
            ContextHolder.setConsumerType("");
            //Cookie redisSessionCookie = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
            SessionUtils.cleanUserSession(httpServletRequest.getSession(), redisSessionCookie);
            httpServletRequest.getSession().invalidate();//让SESSION失效
            Cookie[] cookies = httpServletRequest.getCookies();
            if (cookies != null) {
                for (Cookie c : cookies) {
                    if ("company".equals(c.getName()) || "historyCompany".equals(c.getName())){
                        Cookie cookie = new Cookie("historyCompany",c.getValue());
                        c.setMaxAge(0);
                        c.setPath("/");
                        httpServletResponse.addCookie(c);
                        httpServletResponse.addCookie(cookie);

                    }else{
                        c.setMaxAge(0);
                        c.setPath("/");
                        httpServletResponse.addCookie(c);
                    }

                }
            }
            return true;
        }

        //判断如果url在忽略列表直接放行
        if (ignoreUrls.contains(visitUrl)) {
            return true;
        }

        // 判断是否是单点登录的接口地址
        CasConfig casConfig1 = casConfigMapper.selectOneCas();
        if (casConfig1 != null && !StringUtils.checkNull(casConfig1.getCasInterface()) && visitUrl.contains(casConfig1.getCasInterface())) {
            return true;
        }

        //cms需要加判断是否登录时可访问
        //贾志敏
        //判断是否是cms
        if (visitUrl.contains("/cmsPub/portal")) {
            //得到是否能需要登录
            List<SysPara> sysParas = sysParaMapper.getTheSysParam("CMS_IFLOGIN");
            if (sysParas.size() > 0) {
                SysPara sysPara = sysParas.get(0);
                if ("0".equals(sysPara.getParaValue())) {
                    //不需要登录
                    return true;
                }
            }
        }

        if (visitUrl.contains("/sys/sysInfo")) {
            //得到是否能需要登录
            String checkRegister = SessionUtils.getSessionInfo(httpServletRequest.getSession(), "checkRegister", String.class, redisSessionId);
            //不需要登录
            if ("1".equals(checkRegister)) {
                return true;
            }
            Object locale = httpServletRequest.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            String realPath = httpServletRequest.getSession().getServletContext().getRealPath("/");
            Map<String, String> m = systemInfoService.getSystemInfo(realPath, locale, httpServletRequest);

            ////授权人数
            int oaUserLimit = 20;

            //允许登录用户数
            int canLoginUser = usersMapper.getLoginUserCount();
            if (canLoginUser > oaUserLimit) {
                //不需要登录
                return true;
            }

            if(m==null){
                return true;
            }
        }

        if (visitUrl.equals(loginUrl)) {
            String loginId = "default";
            if (MobileCheck.isMobileDevice(httpServletRequest.getHeader("user-agent"))) {
                httpServletRequest.getSession().invalidate();//让SESSION失效
                //Cookie redisSessionCookie = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
                SessionUtils.cleanUserSession(httpServletRequest.getSession(), redisSessionCookie);
            }
            Map<String, String[]> param = httpServletRequest.getParameterMap();
            if (param == null || param.get("loginId") == null) {
//                throw new InterceptorException("请配置数据源信息 ：param: loginId=?");
            } else {
                String[] value = param.get("loginId");
                if (value != null && value.length == 1) {
                    loginId = value[0];
                } else {
                    loginId = Arrays.toString(value);
                }
            }
            String dbsource = "xoa" + loginId;
            L.w("数据库切换到：", dbsource);
            ContextHolder.setConsumerType(dbsource);
            return true;
        }

        String testIds = httpServletRequest.getParameter("JSESSIONID1");

        //String testId= httpServletRequest.getHeader("JSESSIONID1");
        L.s("0=||================>testId");
        //L.s(testId);
        Cookie[] cookies = httpServletRequest.getCookies();
        L.s("0=||================>sessionTest");
        Users user = null;
        //String functionIdStr =  userFunctionMapper.getUserFuncIdStr(user.getUserId());
        String functionIdStr = httpServletRequest.getSession().getAttribute("functionIdStr") == null ? null : httpServletRequest.getSession().getAttribute("functionIdStr").toString();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                L.s(cookie);
                CommonSessionContext myContext = CommonSessionContext.getInstance();
                HttpSession session = null;
                if (MobileCheck.isMobileDevice(httpServletRequest.getHeader("user-agent"))) {
                    if (cookie.getName().contains("redisSessionId")) {
                        if (redisUse) {
                            String sessionId = cookie.getValue();
                            L.s(sessionId);
                            session = myContext.getSession(sessionId);
                            testIds = sessionId;
                        }
                    } else if (cookie.getName().contains("JSESSIONID")) {
                        String sessionId = cookie.getValue();
                        L.s(sessionId);
                        session = myContext.getSession(sessionId);
                    }
                } else {
                    if (cookie.getName().contains("redisSessionId")) {
                        if (redisUse) {
                            String sessionId = cookie.getValue();
                            L.s(sessionId);
                            session = myContext.getSession(sessionId);
                            testIds = sessionId;
                        }
                    } else if (cookie.getName().contains("JSESSIONID1")) {
                        String sessionId = cookie.getValue();
                        session = myContext.getSession(sessionId);
                        L.s(sessionId);
                    }
                }

                if (session != null) {
                    HttpSession sessionNow = httpServletRequest.getSession();
                    ContextHolder.setConsumerType("xoa" + (String) session.getAttribute(
                            "loginDateSouse"));
                   // Cookie redisSessionCookie = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
                    Map userinfo = SessionUtils.getAllSessionInfoBykey(session, redisSessionCookie);
                   /* user = new Users();
                    user.setUid(2);*/
                    user = SessionUtils.getSessionInfo(session, Users.class, new Users(), redisSessionCookie);

//                    functionIdStr=  SessionUtils.getSessionInfo(session, "functionIdStr",String.class,redisSessionCookie);
                    SessionUtils.putSession(sessionNow, userinfo, redisSessionId);
                    Map<String, Object> params = new HashMap<String, Object>();
                    params.put("functionIdStr", functionIdStr);
                    params.put("loginDateSouse", (String) session.getAttribute("loginDateSouse"));
                    params.put("InterfaceModel", (String) session.getAttribute("InterfaceModel"));

                    SessionUtils.putSession(sessionNow, params, redisSessionId);
                }

            }
        }

        if (!StringUtils.checkNull(testIds)) {
            HttpSession session = null;
            CommonSessionContext myContext = CommonSessionContext.getInstance();
            session = myContext.getSession(testIds);
            if (session != null) {
                HttpSession sessionNow = httpServletRequest.getSession();
                ContextHolder.setConsumerType("xoa" + (String) session.getAttribute(
                        "loginDateSouse"));
                //Cookie redisSessionCookie = CookiesUtil.getCookieByName(httpServletRequest, "redisSessionId");
                Map userinfo = SessionUtils.getAllSessionInfoBykey(session, redisSessionCookie);
                SessionUtils.putSession(sessionNow, userinfo, redisSessionId);

                user = SessionUtils.getSessionInfo(session, Users.class, new Users(), redisSessionCookie);
//                functionIdStr=  SessionUtils.getSessionInfo(session, "functionIdStr",String.class,redisSessionCookie);
//                SessionUtils.putSession(sessionNow,user,redisSessionId);

                SessionUtils.putSession(sessionNow, "functionIdStr", (String) session.getAttribute(
                        "functionIdStr"), redisSessionId);
                SessionUtils.putSession(sessionNow, "loginDateSouse", (String) session.getAttribute(
                        "loginDateSouse"), redisSessionId);
                SessionUtils.putSession(sessionNow, "InterfaceModel", (String) session.getAttribute(
                        "InterfaceModel"), redisSessionId);
            }
        }
        if (user != null && user.getUid() != null) {

            //用户权限接口集合
            String userUrl[] = {"/user/addUser", "/user/editUser", "/user/deleteUser", "/common/userManagement", "/addUsers", "/queryExportUsers"};
            //部门权限接口集合
            String deptUrl[] = {"/department/addDept", "/department/deletedept", "/department/editDept", "/common/deptManagement"};
            //角色权限接口集合
            String privUrl[] = {"/userPriv/addUser", "/userPriv/deletePriv", "/userPriv/updateUser", "/userPriv/deleteUserPriv",
                    "/userPriv/updateUserPrivfuncIdStr", "/userPriv/updateUserFunByUID", "/inputUserPriv",
                    "/roleAuthorization", "/adjustTheRole", "/modifyThePermissions", "/theAuxiliaryRole", "/superPassword"};
            //公共文件柜设置
            //String fileSetting[] = {"/newFilePub/tempHome","/newFilePub/setFileSortAuth","/newFilePub/setAllFileSortAuth"};

            if (!StringUtils.checkNull(functionIdStr)) {
                boolean flag = true;
                String[] funcIds = functionIdStr.split(",");
                for (int i = 0; i < userUrl.length; i++) {
                    if (visitUrl.equals(userUrl[i])) {
                        if (Arrays.asList(funcIds).contains(USER_MANGER)) {
                            return true;
                        }
                        if (Arrays.asList(funcIds).contains(BRANCH_USER_MANGER)) {
                            return true;
                        }
                        if (Arrays.asList(funcIds).contains(SANYUAN_MANGER)) {
                            return true;
                        }
                        flag = false;
                    }
                }
                for (int i = 0; i < deptUrl.length; i++) {
                    if (visitUrl.equals(deptUrl[i])) {
                        if (Arrays.asList(funcIds).contains(DEPT_MANGER)) {
                            return true;
                        }
                        if (Arrays.asList(funcIds).contains(BRANCH_DEPT_MANGER)) {
                            return true;
                        }
                        if (Arrays.asList(funcIds).contains(SANYUAN_MANGER)) {
                            return true;
                        }
                        flag = false;
                    }
                }
                for (int i = 0; i < privUrl.length; i++) {
                    if (visitUrl.equals(privUrl[i])) {
                        if (Arrays.asList(funcIds).contains(PRIV_MANGER)) {
                            return true;
                        }
                        flag = false;
                    }
                }
                if (flag) {
                        return checkPriv(visitUrl,Arrays.asList(funcIds));
                }
            } else {
                //判断是否在请求权限接口
                List<String> authUrlList = new ArrayList(Arrays.asList(userUrl));
                authUrlList.addAll(Arrays.asList(deptUrl));
                authUrlList.addAll(Arrays.asList(privUrl));
                for (String authUrl : authUrlList) {
                    if(visitUrl.contains(authUrl)){
                        httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + redirectUrl + "?imageType=" + LoginState.LOGINSESSIONERR);
                        return false;
                    }
                }
                return true;
            }
        }

        //4、非法请求 即这些请求需要登录后才能访问
        //重定向到登录页面
        if (!MobileCheck.isMobileDevice(httpServletRequest.getHeader("user-agent"))) {
            if (casConfig1 != null && casConfig1.getCasStatus().equals("1")) {

            } else {
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + redirectUrl + "?imageType=" + LoginState.LOGINSESSIONERR);
            }
        } else {
            httpServletResponse.sendError(403, httpServletRequest.getContextPath() + welcomUrl);
        }
        return false;
    }

    private boolean checkTimeOut(String useEndDate, String endLecDateStr, String isAuthStr, String usercount) {
        try {
            //判断是否注册
            if (isAuthStr.equals("true")) {
                Date now = new Date();
                if (StringUtils.checkNull(endLecDateStr)) {
                    return true;
                } else {
                    if ("永久使用".equals(endLecDateStr)) {
                        return false;
                    } else {
                        Date timeOut = DateFormat.DateToStr(endLecDateStr);
                        if (timeOut.getTime() < now.getTime()) {
                            return true;
                        }
                    }
                }
                if (StringUtils.checkNull(useEndDate)) {
                    return true;
                } else if (useEndDate.equals("0000-00-00")) {
                    return false;
                } else {
                    Date timeOut = DateFormat.DateToStr(useEndDate);
                    if (timeOut.getTime() < now.getTime()) {
                        return true;
                    }
                }
            } else {
                //先去判断用户数是否是30
                if (usercount.equals("30")) {
                    return false;
                }
                Date now = new Date();
                //如果用户数大于50人的话，判断试用是否到期
                if (StringUtils.checkNull(useEndDate)) {
                    return true;
                } else if (useEndDate.equals("0000-00-00")) {
                    return false;
                } else {
                    Date timeOut = DateFormat.DateToStr(useEndDate);
                    if (timeOut.getTime() < now.getTime()) {
                        return true;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    private String getParamString(Map<String, String[]> map) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, String[]> e : map.entrySet()) {
            sb.append(e.getKey()).append("=");
            String[] value = e.getValue();
            if (value != null && value.length == 1) {
                sb.append(value[0]).append("\t");
            } else {
                sb.append(Arrays.toString(value)).append("\t");
            }
        }
        return sb.toString();
    }

    /**
     * 上传文件拦截
     *
     * @param request
     * @return
     */
    private boolean Multipart(HttpServletRequest request) {
        boolean flag = true;
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> files = multipartRequest.getFileMap();
        Iterator<String> iterator = files.keySet().iterator();
        //对多部件请求资源进行遍历
        while (iterator.hasNext()) {
            String formKey = (String) iterator.next();
            MultipartFile multipartFile = multipartRequest.getFile(formKey);
            String filename = multipartFile.getOriginalFilename();
            //判断是否为限制文件类型
            if (!checkFile(filename)) {
                flag = false;
            }
        }
        return flag;
    }

    /**
     * 判断是否为允许的上传文件类型,true表示允许
     */
    private boolean checkFile(String fileName) {
        if (!"".equals(fileName.trim())) {
            //设置不允许上传文件类型
            String suffixList = "jsp,jspx,js,css,java,class,php";
            // 获取文件后缀
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
            if(StringUtils.checkNull(suffix)){
                return false;
            }
            //判断是否以这种后缀开头的文件
            if (Arrays.asList(suffixList.split(",")).stream().anyMatch(s -> suffix.trim().toLowerCase().startsWith(s))) {
                return false;
            }
        }
        return true;
    }

    public boolean checkPriv(String url,List<String> funcIds){
        if (url.startsWith("/")){
            url=url.substring(1);
        }
        List<String> list =sysFunctionMapper.getFuncIdByUrl(url);
        if (list==null || list.size()==0){
            return true;
        }
        if (list.size()==1){
            if (funcIds.contains(list.get(0))){
                return true;
            }else{
                return false;
            }
        }
        return true;


    }
}
