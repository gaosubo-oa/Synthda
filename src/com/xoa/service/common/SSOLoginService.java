package com.xoa.service.common;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.thirdSysConfig.ThirdSysConfigMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.UserOnline;
import com.xoa.model.users.Users;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormatUtils;
import com.xoa.util.LoginState;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.sso.CASUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SSOLoginService {

    @Autowired
    UserFunctionMapper userFunctionMapper;
    @Autowired
    private SysInterfaceMapper sysInterfaceMapper;
    @Autowired
    private SysLogService sysLogService;
    @Autowired
    private OrgManageMapper orgManageMapper;
    @Autowired
    private SysParaMapper sysParaMapper;

    @Autowired
    private UsersService usersService;
    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private UserPrivMapper userPrivMapper;
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private ThirdSysConfigMapper thirdSysConfigMapper;

    private String casHost =null;

    private String lastOAtargeturl = "";

    public Map<String,Object> userCountMap =new HashedMap();


    public ToJson<Users> ssoLoginEnter(HttpServletRequest request, HttpServletResponse response, String loginId, String username, String OAtargeturl) throws Exception {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
        response.addHeader("Access-Control-Max-Age", "1800");//30 min

        String userAgent = request.getParameter("userAgent");
        String serverName = request.getServerName();
        String targetUrl = request.getScheme() + "://" + serverName;
        String pushToken = request.getParameter("pushToken");
        int port = request.getServerPort();
        if (80!=port && 443!=port) {//默认端口，不加在跳转路径下
            targetUrl += ":" + request.getServerPort();
        }
        CASUtils casUtils = new CASUtils();
        HttpSession session = request.getSession();

        OAtargeturl = StringUtils.checkNull(OAtargeturl) ? "/main":OAtargeturl;
        if(casUtils.isLogin(session)) {
            response.sendRedirect(targetUrl + OAtargeturl);
        }else {

            CookiesUtil.setCookie(response, "redisSessionId", request.getSession().getId());
            Cookie redisSessionCookie = new Cookie("redisSessionId", request.getSession().getId());
            if (StringUtils.checkNull(loginId)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                }
            }


            ToJson<Users> json = new ToJson<Users>(0, null);
            if (StringUtils.checkNull(username)) {
                json.setFlag(1);
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setMsg("用户名或用户不存在");
                return json;
            }
            ContextHolder.setConsumerType("xoa" + loginId);
            Users user = usersMapper.selectUserAllInfoByName(username);
            if (user == null) {
               /* request.getSession().setAttribute("message", "errOne");
                json.setMsg("用户名或用户不存在");
                json.setCode(LoginState.LOGINPASSWORDERR);
                json.setFlag(1);*/
                response.sendRedirect(targetUrl + "/defaultIndexErrCas");
                return json;

            }

            List<SysPara> list = sysParaMapper.selectAll();
            String pd = "";
            String xts = "";
            String cz = "";
            for (SysPara sysPara : list) {
                if ("SEC_RETRY_BAN".equals(sysPara.getParaName())) {
                    pd = sysPara.getParaValue();
                }
                if ("SEC_RETRY_TIMES".equals(sysPara.getParaName())) {
                    xts = sysPara.getParaValue();
                }
                if ("SEC_BAN_TIME".equals(sysPara.getParaName())) {
                    cz = sysPara.getParaValue();
                }
            }


            //获取当前用户的登录日志
            ToJson<Syslog> modifyPwdLog = sysLogService.getLoginLog(request);
            if (user.getLastVisitTime() != null) {
                user.setLastVisitTime(new Date());
                usersService.updateLoginTime(user);
            } else {
                //判断他的size小于等于1，因为在查用户user信息时写入log日志的，因此第一次登录size为1
                if (modifyPwdLog.getObj() == null || modifyPwdLog.getObj().size() <= 1) {
                    json.setCode("FirstLogin");
                } else {
                    user.setLastVisitTime(new Date());
                    usersService.updateLoginTime(user);
                }
            }

            if (StringUtils.checkNull(loginId)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    loginId = org.get(0).getOid().toString().trim();
                }
            }
            user.setCompanyId(loginId);
            //判断用户头像
            if (StringUtils.checkNull(user.getAvatar())) {
                if (!StringUtils.checkNull(user.getSex())) {
                    user.setAvatar(user.getSex());
                } else {
                    user.setAvatar("0");
                }

            } else {
                if (user.getAvatar().equals("0") || user.getAvatar().equals("1")) {
                    if (!StringUtils.checkNull(user.getSex())) {
                        user.setAvatar(user.getSex());
                    } else {
                        user.setAvatar("0");
                    }
                } else {
                    //判断用户头像是否找得到
                    String classpath = this.getClass().getResource("/").getPath();
                    String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/img/user/");
                    File file_avtor = new File(webappRoot + user.getAvatar());
                    if (!file_avtor.exists()) {
                        user.setAvatar(user.getSex());
                    }
                }
            }
            json.setObject(user);
            json.setFlag(0);

            //通过userId查询用户是否存在于静态map中
            UserOnline userOnline = (UserOnline) userCountMap.get(user.getUserId());
            //如果不存在
            if (userOnline == null) {
                //声明一个新的用户在线数据
                UserOnline userOnlineInfo = new UserOnline();
                try {
                    String format = DateFormatUtils.formatDate(new Date());
                    Integer nowTime = DateFormatUtils.getNowDateTime(format);
                    userOnlineInfo.setClient(2);
                    userOnlineInfo.setPCtime(nowTime);
                    userOnlineInfo.setPCsid(request.getSession().getId());
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            } else {//如果存在
                if (!userOnline.getPCsid().equals("")) {
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnline.setPCtime(nowTime);
                        userCountMap.put(user.getUserId(), userOnline);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } else {
                    try {
                        String format = DateFormatUtils.formatDate(new Date());
                        Integer nowTime = DateFormatUtils.getNowDateTime(format);
                        userOnline.setPCtime(nowTime);
                        userOnline.setPCsid(request.getSession().getId());
                        userCountMap.put(user.getUserId(), userOnline);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                }
            }

            Map<String, Object> params = new HashMap<String, Object>();
            params.put("paraName", "IM_WINDOW_CAPTION");
            params.put("paraValue", user.getPara().getParaValue());
            params.put("loginDateSouse", loginId);//组织id
            params.put("LOCALE_SESSION_ATTRIBUTE_NAME", "zh_CN");//语言


            String functionIdStr = userFunctionMapper.getUserFuncIdStr(user.getUserId());
            params.put("functionIdStr", functionIdStr);

            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            if (0 == user.getTheme() || null == user.getTheme()) {
                user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            }

            String theme = "theme" + user.getTheme();
            params.put("InterfaceModel", theme);
            params.put("uid", user.getUid());
            params.put("userId", user.getUserId());
            params.put("userPriv", user.getUserPriv());
            SessionUtils.putSession(request.getSession(), params, redisSessionCookie);
            SessionUtils.putSession(request.getSession(), user, redisSessionCookie);
            String mobileType=request.getParameter("mobileType");
            if(!StringUtils.checkNull(userAgent)&&("android".equalsIgnoreCase(userAgent)||"ios".equalsIgnoreCase(userAgent))){
                if (user != null) {
                    user.setIcqNo(pushToken == null ? "" : pushToken);
                    user.setMobileType(mobileType==null ? "":mobileType);
                    usersMapper.updateIcqNo(user);
                }
                return json;
            }
            lastOAtargeturl = "";
            response.sendRedirect(targetUrl + OAtargeturl);
        }
        return null;
    }

}
