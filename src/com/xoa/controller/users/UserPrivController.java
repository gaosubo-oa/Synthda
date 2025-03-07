package com.xoa.controller.users;


import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.RoleManager;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.UserPrivType;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.department.impl.DepartmentServiceImpl;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UserPrivTypeService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import org.apache.ibatis.annotations.Param;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.URLDecoder;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:05:02
 * 类介绍  :    用户角色权限表
 * 构造参数:   无
 */
@Controller

public class UserPrivController {

    @Resource
    UsersPrivService usersPrivService;

    @Resource
    UsersService usersService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SyslogMapper syslogMapper;

    @Resource
    SysParaService sysParaService;

    @Resource
    UserPrivMapper userPrivMapper;
    @Resource
    DepartmentService departmentService;

    @Autowired
    UserFunctionMapper userFunctionMapper;

    @Resource
    private UserPrivTypeService userPrivTypeService;

    @Resource
    private ModulePrivMapper modulePrivMapper;

    @Resource
    private DepartmentServiceImpl departmentServiceImpl;

    @Resource
    private SecurityApprovalService securityApprovalService;

    //骆鹏创建的界面
    @RequestMapping("/roleAuthorization")
    public String roleAuthorization(HttpServletRequest request, Map<String, Object> map) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (!sysParaService.checkIsHaveSecure(user, 3)) {
            return "app/common/development";
        }
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            map.put("sign", 0);
            return "app/UserPriv/roleAuthorization";
        } else {
            map.put("sign", 1);
            return "app/UserPriv/roleAuthorization";
        }

    }

    @RequestMapping("/newRole")
    public String newRole(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/newRole";
    }

    @RequestMapping("/adjustTheRole")
    public String adjustTheRole(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/adjustTheRole";
    }

    @RequestMapping("/modifyThePermissions")
    public String modifyThePermissions(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        return "app/UserPriv/modifyThePermissions";
    }

    @RequestMapping("/theAuxiliaryRole")
    public String theAuxiliaryRole(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/theAuxiliaryRole";
    }

    @RequestMapping("/superPassword")
    public String superPassword(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        if (StringUtils.checkNull(ss)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/superPassword";
    }

    @RequestMapping("/theHumanResources")
    public String theHumanResources(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/theHumanResources";
    }
    @RequestMapping("/roleAndClassification")
    public String roleAndClassification(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String ss = SessionUtils.getSessionInfo(request.getSession(), "superPwd", String.class, redisSessionCookie);
        String appType = request.getParameter("appType");
        if (StringUtils.checkNull(ss) && !"1".equals(appType)) {
            return "app/UserPriv/roleAuthorization";
        }
        return "app/UserPriv/roleAndClassification";
    }

    @RequestMapping("/cloning")
    public String cloning() {
        return "app/UserPriv/cloning";
    }

    @RequestMapping("/userPrivImport")
    public String userPrivImport() {
        return "app/UserPriv/userPrivImport";
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:05:22
     * 方法介绍:   添加角色
     * 参数说明:   @param userPriv  用户角色
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>  返回页面显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/addUser", method = RequestMethod.POST)
    public ToJson<UserPriv> addPriv(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            int count = usersPrivService.insertSelective(userPriv);
            if (userPriv.getPrivNo() == null) {
                json.setMsg("角色排序号不能为空");
                json.setFlag(1);
                return json;
            }
            if (StringUtils.checkNull(userPriv.getPrivName())) {
                json.setMsg("角色名称不能为空");
                json.setFlag(1);
                return json;
            }
            if (count == 2) {
                json.setMsg("角色名称不能重复");
                json.setFlag(1);
            } else {
                json.setMsg("新建成功 ");
                json.setFlag(0);
                json.setObject(userPriv);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("新建失败 ");
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:28:46
     * 方法介绍:   删除角色
     * 参数说明:   @param userPriv  用户角色
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>  返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/deletePriv", method = RequestMethod.POST)
    public ToJson<UserPriv> deletePriv(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        try {
            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(21);
            sysLog.setTypeName("删除角色与权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            UserPriv priv = usersPrivService.selectByPrimaryKey(userPriv.getUserPriv());
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            usersPrivService.deleteByPrimaryKey(userPriv.getUserPriv());
            sysLog.setRemark("userPriv：" + userPriv.getUserPriv() + "funcIdStr：" + priv.getFuncIdStr());
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);
            json.setObject(userPriv);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:28:59
     * 方法介绍:   根据角色id查找角色
     * 参数说明:   @param userPriv  用户角色
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>   返回用户角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/findByuserPriv")
    public ToJson<UserPriv> findUserByuserPriv(int userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            UserPriv priv = usersPrivService.selectByPrimaryKey(userPriv);
            json.setObject(priv);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:29:29
     * 方法介绍:   获取所有角色
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag   是否开启分页
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>  返回所有角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getAllPriv", produces = {"application/json;charset=UTF-8"})
    public ToJson<UserPriv> getAllPriv(Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag, HttpServletRequest request, String IsPriv) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        String check = request.getParameter("check");
        String moduleId = request.getParameter("moduleId");
        try {
            List<UserPriv> list = new ArrayList<>();

            if(!StringUtils.checkNull(moduleId)){
                ModulePriv module = new ModulePriv();
                module.setUid(users.getUid());
                module.setModuleId(Integer.valueOf(moduleId));
                ModulePriv modulePriv = modulePrivMapper.getModulePrivSingle(module);

                if(!Objects.isNull(modulePriv)) {
                    //人员角色范围（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
                    UserPriv userPriv = userPrivMapper.getUserPriv(users.getUserPriv());
                    switch (modulePriv.getRolePriv()) {
                        case "0":
                            maps.put("moduleRolePrivNo",userPriv.getPrivNo());
                            break;
                        case "1":
                            maps.put("moduleRolePrivNo",userPriv.getPrivNo() - 1);
                            break;
                        case "3":
                            maps.put("moduleRolePrivIds",modulePriv.getPrivId().split(","));
                            break;
                        default:
                            break;
                    }
                }
            }

            if (!(IsPriv != null && "1".equals(IsPriv.trim()))) {
                int orgFlag = departmentService.checkOrgFlag(users);
                if (orgFlag == 2) {
                    List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(users, true, true);
                    Integer[] deptIds = new Integer[departmentByClassifyOrg.size()];
                    for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                        deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                    }
                    maps.put("deptIds",deptIds);
                    list = userPrivMapper.getPrivNameByDeptIds(maps);
                } else {
                    list = usersPrivService.getAllPriv(maps, page, pageSize, useFlag);
                }
            } else {
                //获取用户角色和辅助角色中权限最大的一个角色序号
                String userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
                String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
                List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
                List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
                UserPriv userPriv = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
                //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
                if (userPrivAdmin.size()== 0 && userPriv.getPrivType() == 0) {
                    maps.put("privNoS", userPriv.getPrivNo());
                    maps.put("privType", userPriv.getPrivType());
                }
                if (!"1".equals(users.getUserPriv().toString()) && !StringUtils.checkNull(check)) {
                    maps.put("check", "1");
                }
                list = usersPrivService.getAllPriv(maps, page, pageSize, useFlag);
            }
            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(null,list);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:29:42
     * 方法介绍:   多条件查找角色
     * 参数说明:   @param userPriv  角色信息
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>  返回角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getPrivByMany")
    public ToJson<UserPriv> getPrivByMany(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            List<UserPriv> list = usersPrivService.getPrivByMany(userPriv);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 10:46
     * @函数介绍: 查询所有
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    @ResponseBody
    @RequestMapping(value = "/getAllUserPriv")
    public ToJson<UserPriv> getAllUserPriv(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            List<UserPriv> list = usersPrivService.getAllUserPriv();
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午11：52：00
     * 方法介绍:   根据privid修改角色信息
     * 参数说明    @param record
     *
     * @return ToJson<UserPriv>  返回所有角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateUser", method = RequestMethod.POST)
    public ToJson<UserPriv> updateUserPriv(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        try {
            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(20);
            sysLog.setTypeName("编辑角色与权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            if (userPriv.getFuncIdStr() == null) {
                if (userPriv.getPrivNo() == null) {
                    json.setMsg("角色排序号不能为空");
                    json.setFlag(1);
                    return json;
                }
                if (StringUtils.checkNull(userPriv.getPrivName())) {
                    json.setMsg("角色名称不能为空");
                    json.setFlag(1);
                    return json;
                }
                int count = usersPrivService.updateUserPriv(userPriv);
                if (count == 2) {
                    json.setMsg("角色名称不能重复");
                    json.setFlag(1);
                } else {
                    sysLog.setRemark("privNo:" + userPriv.getPrivNo() + ",privName:" + userPriv.getPrivName());
                    sysLog.setTime(new Date(System.currentTimeMillis()));
                    syslogMapper.save(sysLog);
                    json.setMsg("修改成功");
                    json.setFlag(0);
                }
            } else {
                int count = usersPrivService.updateUserPriv(userPriv);
                sysLog.setRemark("userPriv:" + userPriv.getUserPriv() + ",funcidStr：" + userPriv.getFuncIdStr());
                sysLog.setTime(new Date(System.currentTimeMillis()));
                syslogMapper.save(sysLog);
                json.setMsg("修改成功");
                json.setFlag(0);
            }
            String functionIdStr = userFunctionMapper.getUserFuncIdStr(users.getUserId());
            SessionUtils.putSession(request.getSession(), "functionIdStr", functionIdStr, redisSessionCookie);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("修改失败");
            L.e("UserPrivController updateUserPriv:" + e);
        }
        return json;
    }


    @RequestMapping("/userPriv/show_users")
    public String show_users(HttpServletRequest request, String userPriv) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        request.setAttribute("userPriv", userPriv);
        String privName = request.getParameter("privName");
        request.setAttribute("privName", privName);
        return "app/UserPriv/show_users";
    }


    @RequestMapping("/userPriv/query_usersbyuserPriv")
    public @ResponseBody
    ToJson<Object> query_usersbyuserPriv(HttpServletRequest request, String userPriv) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return usersService.getUsersByUserPriv(request, userPriv);
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年8月09日 下午2:28:22
     * 方法介绍:   根据（用户姓名、角色、部门）查询用户角色接口
     * 参数说明:   @param request 请求
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag   是否开启分页
     * 参数说明:   @return
     *
     * @return String  返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getBySearch", produces = {"application/json;charset=UTF-8"})
    public ToJson<UserPriv> getBySearch(HttpServletRequest request, Map<String, Object> maps) {
        ToJson<UserPriv> json = new ToJson<UserPriv>();
        try {
            request.setCharacterEncoding("UTF-8");
            //String search = request.getParameter("search");

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            String search= URLDecoder.decode(request.getParameter("search"),"utf-8");
            maps = new HashMap<String, Object>();
            maps.put("privName", search);

            String IsPriv = request.getParameter("IsPriv");
            String check = request.getParameter("check");

            String moduleId = request.getParameter("moduleId");
            if(!StringUtils.checkNull(moduleId)){
                ModulePriv module = new ModulePriv();
                module.setUid(users.getUid());
                module.setModuleId(Integer.valueOf(moduleId));
                ModulePriv modulePriv = modulePrivMapper.getModulePrivSingle(module);

                if(!Objects.isNull(modulePriv)) {
                    //人员角色范围（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
                    UserPriv userPriv = userPrivMapper.getUserPriv(users.getUserPriv());
                    switch (modulePriv.getRolePriv()) {
                        case "0":
                            maps.put("moduleRolePrivNo",userPriv.getPrivNo());
                            break;
                        case "1":
                            maps.put("moduleRolePrivNo",userPriv.getPrivNo() - 1);
                            break;
                        case "3":
                            maps.put("moduleRolePrivIds",modulePriv.getPrivId().split(","));
                            break;
                        default:
                            break;
                    }
                }
            }

            List<UserPriv> list;
            if(IsPriv != null && "1".equals(IsPriv.trim())){
                //获取用户角色和辅助角色中权限最大的一个角色序号
                String userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
                String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
                List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
                List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
                UserPriv userPriv = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
                //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
                if (userPrivAdmin.size()== 0 && userPriv.getPrivType() == 0) {
                    maps.put("privNoS", userPriv.getPrivNo());
                    maps.put("privType", userPriv.getPrivType());
                }
                if (!"1".equals(users.getUserPriv().toString()) && !StringUtils.checkNull(check)) {
                    maps.put("check", "1");
                }
                list = usersPrivService.getPrivBySearch(maps);
            } else {
                list = usersPrivService.getPrivBySearch(maps);
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);

        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午11：52：00
     * 方法介绍:   克隆操作
     * 参数说明    @param record
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/copyUserPriv", method = RequestMethod.POST)
    public ToJson<UserPriv> copyUserPriv(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            usersPrivService.copyUserPriv(userPriv);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            //      e.printStackTrace();
            L.e("UserPrivController copyUserPriv:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午15:19:05
     * 方法介绍:   查询超级密码是否正确
     * 参数说明:   @param password
     * 参数说明:   @return 结果
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/checkSuperPass", method = RequestMethod.POST)
    public ToJson<UserPriv> checkSuperPass(String password, HttpServletRequest request) {
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        int count = 0;
        if (password != null && password != "") {
            count = usersPrivService.checkSuperPass(password);
        }
        try {
            if (count != 0) {
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");

                HttpSession session = request.getSession();
                SessionUtils.putSession(session, "superPwd", password, redisSessionCookie);
//                session.setAttribute("superPwd", password);
                session.setMaxInactiveInterval(600);//获取session最大的不活动的间隔时间，以秒为单位60秒
                json.setMsg("OK");
                json.setFlag(0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController checkSuperPass:" + e);
//                e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月15日 下午16:05:09
     * 方法介绍:   修改超级密码
     * 参数说明:   @param password 修改后的密码
     * 返回值:   @return ToJson
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateSuperPass", method = RequestMethod.POST)
    public ToJson<UserPriv> updateSuperPass(String newPwd, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            usersPrivService.updateSuperPass(newPwd);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            // e.printStackTrace();
            L.e("UserPrivController updateSuperPass:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午17:33:00
     * 方法介绍:   修改角色权限（serPriv 的funcIdStr）
     *
     * @参数说明: String privids 角色id
     * @参数说明: String funcId  权限id
     * 返回值:   @return ToJson
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/deleteUserPriv", method = RequestMethod.POST)
    public ToJson<UserPriv> deleteUserPriv(String privids, String funcIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            usersPrivService.deleteUserPriv(privids, funcIds);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            // e.printStackTrace();
            L.e("UserPrivController deleteUserPriv:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午17:33:00
     * 方法介绍:   修改角色权限（serPriv 的funcIdStr）,数据库原有字段基础上如果存在就不在拼接，否则
     * 参数说明:   @param privids 角色Id，funcIds 权限字符串
     * 参数说明:   @return ToJson
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateUserPrivfuncIdStr", method = RequestMethod.POST)
    public ToJson<UserPriv> updateUserPrivfuncIdStr(String privids, String funcIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            usersPrivService.updateUserPrivfuncIdStr(privids, funcIds);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            //   e.printStackTrace();
            L.e("UserPrivController updateUserPrivfuncIdStr:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月16日 下午19:24:05
     * 方法介绍:   根据id修改排序号
     * 参数说明:   @param privName 角色名称
     * 参数说明:   @return void
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updNoByPrivId", method = RequestMethod.POST)
    public ToJson<UserPriv> updNoByPrivId(UserPriv userPrivs, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return usersPrivService.updNoByPrivId(userPrivs);
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午14:29:10
     * 方法介绍:   给用户添加或删除辅助角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateUserFunByUID")
    public ToJson<UserPriv> updateUserFunByUID(String userId, String funcIds, int sign) {
        //sign:1 表示添加  0 ：表示删除
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            if (sign == 1) {
                return usersPrivService.addUserFunByUID(userId, funcIds);
            } else {
                usersPrivService.deleteUserFunByUID(userId, funcIds);
            }
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            //   e.printStackTrace();
            L.e("UserPrivController updateUserFunByUID:" + e);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/userPriv/selectHavePriv")
    public ToJson selectHavePriv(){
        return usersPrivService.selectHavePriv();
    }

    @ResponseBody
    @RequestMapping(value = "/userPriv/selectHaveDept")
    public ToJson selectHaveDept(HttpServletRequest request){
        return usersPrivService.selectHaveDept(request);
    }

    @ResponseBody
    @RequestMapping(value = "/userPriv/selectPriv")
    public ToJson selectPriv(String userId){
        return usersPrivService.selectPriv(userId);
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午17:55:10
     * 方法介绍:   角色权限信息导出
     */
    @ResponseBody
    @RequestMapping("/outputUserPriv")
    public ToJson<UserPriv> outputUserPriv(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("角色权限信息导出", 9);
            String[] secondTitles = {"角色排序号", "角色名称", "权限模块"};
            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
            UserPriv userPriv = new UserPriv();
            List<UserPriv> userPrivList = usersPrivService.getAllUserPriv();
             Map<String,HashMap<String,String>> map=usersPrivService.getFunIdAndFunName();
             //优化后的归档
            for (UserPriv userPriv1 : userPrivList) {
                StringBuffer tempStr = new StringBuffer();
                String[] funcIdArray = userPriv1.getFuncIdStr().split(",");
                Map ma1p = null;
                for (String funcId : funcIdArray) {
                    if(!StringUtils.checkNull(funcId)){
                        ma1p = map.get(funcId);
                        if(ma1p!=null){
                            tempStr.append(ma1p.get("FUNC_NAME") + ",");
                        }
                    }
//                     hashMap=JSON.parseObject(map.get(funcId),HashMap.class);
                }
                userPriv1.setFuncIdStr(tempStr.toString());
            }
            //之前归档用的foreach循环
           /* for (UserPriv userPriv1 : userPrivList) {
                StringBuffer tempStr = new StringBuffer();
                String[] funcIdArray = userPriv1.getFuncIdStr().split(",");
                for (String funcId : funcIdArray) {
                    String funcStr = usersPrivService.getFunNameByFunId(funcId);
                    if (funcStr != null) {
                        tempStr.append(funcStr + ",");
                    }
                }
                userPriv1.setFuncIdStr(tempStr.toString());
            }*/

            // String[] beanProperty = {user.getDep().getDeptName(),"userName","userPrivName", "roleAuxiliaryName","online","sex","online","telNoDept","telNoDept","departmentPhone","email"};
            String[] beanProperty = {"privNo", "privName", "funcIdStr"};
            HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, userPrivList, beanProperty);
            ServletOutputStream out = response.getOutputStream();

            String filename = "角色权限导出.xls"; //考虑多语言
            filename = FileUtils.encodeDownloadFilename(filename,
                    request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("content-disposition",
                    "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
             e.printStackTrace();
            L.e("UserPrivController outputUserPriv:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月19日 下午17:55:10
     * 方法介绍:   角色权限信息导入
     */
    @ResponseBody
    @RequestMapping("/inputUserPriv")
    public ToJson<UserPriv> inputUserPriv(HttpServletRequest request, HttpServletResponse response, MultipartFile file, HttpSession session) throws Exception {
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            //String name = rb.getString("mysql.driverClassName");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
            StringBuffer buffer = new StringBuffer();
            if (osName.toLowerCase().startsWith("win")) {
                //sb=sb.append(rb.getString("upload.win"));
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if (uploadPath.indexOf(":") == -1) {
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                    //获取截取后的路径
                    String str2 = "";
                    if (basePath.indexOf("/xoa") != -1) {
                        //获取字符串的长度
                        int length = basePath.length();
                        //返回指定字符在此字符串中第一次出现处的索引
                        int index = basePath.indexOf("/xoa");
                        //从指定位置开始到指定位置结束截取字符串
                        str2 = basePath.substring(0, index);
                    }
                    path = path.append(str2 + "/xoa");
                }
                path.append(uploadPath);
                buffer = buffer.append(rb.getString("upload.win"));
            } else {
                path = path.append(rb.getString("upload.linux"));
                buffer = buffer.append(rb.getString("upload.linux"));
            }
//            List<UserPriv> datasList =new ArrayList<UserPriv>();
            UserPriv temp = new UserPriv();
            if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                return json;
            } else {
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString();
                    uuid = uuid.replaceAll("-", "");
                    int pos = fileName.lastIndexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                    File dest = new File(readPath);
                    file.transferTo(dest);
                    //将文件上传成功后进行读取文件
                    //进行读取的路径
                    InputStream in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    Row rowObj = null;
                    int lastRowNum = sheetObj.getLastRowNum();
                    int success = 0;
                    int fail = 0;
                    for (int i = 2; i <= lastRowNum; i++) {
                        rowObj = sheetObj.getRow(i);
                        if (rowObj != null) {
                            Cell c0 = rowObj.getCell(0);
                            Cell c1 = rowObj.getCell(1);
                            Cell c2 = rowObj.getCell(2);
                            String cell0 = "";
                            if (c0 != null) {
                                if (CellType.NUMERIC == c0.getCellType()) {
                                    double d = c0.getNumericCellValue();
                                    cell0 = String.valueOf(d);
                                } else {
                                    cell0 = c0.getStringCellValue();
                                }
                            }
                            if (!StringUtils.checkNull(cell0) && !StringUtils.checkNull(c1.getStringCellValue())) {
                                if (!StringUtils.checkNull(cell0) && !StringUtils.checkNull(c1.getStringCellValue())) {//角色名称和排序号不能为空
                                    //    HSSFCell c3=rowObj.getCell(3);
                                    UserPriv userPriv = new UserPriv();
                                    if (cell0.contains(".")) {
                                        cell0 = cell0.substring(0, cell0.length() - 2);
                                    }
                                    userPriv.setPrivNo(Short.valueOf(cell0));
                                    userPriv.setPrivName(c1.getStringCellValue());
                                    if(c2!=null){
                                        String cell1 = c2.getStringCellValue();
                                        String[] funcStrArray = cell1.split(",");
                                        StringBuffer tempStr = new StringBuffer();
                                        for (String funcStr : funcStrArray) {
                                            List<String> funcIdList = usersPrivService.getFunIdByFunName(funcStr.trim());
                                            if (funcIdList.size() > 0) {
                                                for (String funcId : funcIdList) {
                                                    tempStr.append(funcId + ",");
                                                }
                                            }
                                        }
                                        userPriv.setFuncIdStr(tempStr.toString());
                                    }
                                    int reapName = usersPrivService.insertSelective(userPriv);
                                    if (reapName != 2) {
                                        success++;
                                        continue;
                                    } else {//角色名称重复
                                        fail++;
                                        temp.setReapNameCount(1);
                                        continue;
                                    }
//                                datasList.add(userPriv);
                                } else {
                                    fail++;
                                    temp.setEmptyCount(1);
                                    continue;
                                }
                            }
                        }
                    }
                    temp.setInsertCounts(success);
                    temp.setFailCounts(fail);
                    json.setFlag(0);
                    json.setObject(temp);
                    dest.delete();
                } else {
                    json.setMsg("文件类型不正确！");
                    return json;
                }
            }
        } catch (Exception e) {
            json.setMsg("数据保存异常");
            e.printStackTrace();
            L.e("UserPrivController inputUserPriv:" + e);
        }
        return json;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:48:00
     * 方法介绍:   添加人力资源管理角色规则
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 插入条数
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/insertRoleManager", method = RequestMethod.POST)
    public ToJson<RoleManager> insertRoleManager(RoleManager roleManager) {
        ToJson<RoleManager> json = new ToJson<RoleManager>(1, "error");
        try {
            int result = usersPrivService.insertRoleManager(roleManager);
            if (result != 0) {
                json.setObject(roleManager);
                json.setMsg("OK");
                json.setFlag(0);
            }
        } catch (Exception e) {
            //  e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController insertRoleManager:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:53:00
     * 方法介绍:  根据id进行修改人力资源角色
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 进行修改的条数
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateRoleManager", method = RequestMethod.POST)
    public ToJson<RoleManager> updateRoleManager(RoleManager roleManager) {
        ToJson<RoleManager> json = new ToJson<RoleManager>(1, "error");
        try {
            int result = usersPrivService.updateRoleManager(roleManager);
            if (result != 0) {
                json.setObject(roleManager);
                json.setMsg("OK");
                json.setFlag(0);
            }
        } catch (Exception e) {
            //       e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController updateRoleManager:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午9:58:00
     * 方法介绍:  根据id进行删除人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return int 进行删除的条数
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/deleteRoleManagerById", method = RequestMethod.POST)
    public ToJson<RoleManager> deleteRoleManagerById(int roleManagerId) {
        ToJson<RoleManager> json = new ToJson<RoleManager>(1, "error");
        try {
            int result = usersPrivService.deleteRoleManagerById(roleManagerId);
            if (result != 0) {
                json.setMsg("OK");
                json.setFlag(0);
            }
        } catch (Exception e) {
            //  e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController deleteRoleManagerById:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:17:00
     * 方法介绍:  根据id进行查询人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return RoleManager 查询出来的结果
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getRoleManagerById", method = RequestMethod.POST)
    public ToJson<RoleManager> getRoleManagerById(int roleManagerId) {
        ToJson<RoleManager> json = new ToJson<RoleManager>(1, "error");
        RoleManager roleManager = new RoleManager();
        try {
            roleManager = usersPrivService.getRoleManagerById(roleManagerId);
            json.setObject(roleManager);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            // e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController getRoleManagerById:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月20日 下午10:17:00
     * 方法介绍:  根据id进行查询人力资源角色管理
     * 参数说明:   @param roleManager 人力资源管理信息
     * 参数说明:   @return
     *
     * @return RoleManager 查询出来的结果
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getAllRoleManager")
    public ToJson<RoleManager> getAllRoleManager() {
        ToJson<RoleManager> json = new ToJson<RoleManager>(1, "error");
        RoleManager roleManager = new RoleManager();
        try {
            List<RoleManager> roleManagerList = usersPrivService.getAllRoleManager();
            json.setObj(roleManagerList);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            // e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserPrivController getAllRoleManager:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年10月23日
     * 方法介绍:  根据id进行查询角色名字
     * 参数说明:   @return
     *
     * @return RoleManager 查询出来的结果
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/getUserPrivName")
    public ToJson<UserPriv> getUserPrivName(HttpServletRequest request, int userPriv) {
        return usersPrivService.getUserPrivName(request, userPriv);
    }

    @ResponseBody
    @RequestMapping(value = "/userPriv/getUserPrivsByPrivName")
    public ToJson getUserPrivsByPrivName(String privName) {
        return usersPrivService.selectUserPrivsByPrivName(privName);
    }

    /**
     * 创建日期:   2022年3月28日
     * 方法介绍:   根据privid修改角色信息（增加角色分类限制）
     * 参数说明    @param record
     *
     * @return ToJson<UserPriv>  返回所有角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/updateUserPriv", method = RequestMethod.POST)
    public ToJson<UserPriv> updateUserPrivFilterPrivTypeId(UserPriv userPriv, HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        try {
            //加入操作日志处理
            Syslog sysLog = new Syslog();
            sysLog.setUserId(users.getUserId() + "");
            sysLog.setType(20);
            sysLog.setTypeName("编辑角色与权限");
            sysLog.setIp(IpAddr.getIpAddress(request));
            sysLog.setRemark("");
            String userAgent = request.getParameter("userAgent");
            if ("iOS".equals(userAgent)) {
                //添加客户端类型
                sysLog.setClientType(3);
                SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("android".equals(userAgent)) {
                sysLog.setClientType(4);
                SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else if ("pc".equals(userAgent)) {
                sysLog.setClientType(2);
                SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(Version.getParaValue());
            } else {
                sysLog.setClientType(1);
                String clientVersion = request.getParameter("clientVersion");
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }

            //限制只能修改有权限的角色
            UserPriv priv = usersPrivService.selectByPrimaryKey(userPriv.getUserPriv());
            ToJson<UserPrivType> userPrivTypeToJson = userPrivTypeService.selUserPrivTypeByDept(request);
            if(!userPrivTypeToJson.isFlag() || Objects.isNull(userPrivTypeToJson.getObj())
                    || userPrivTypeToJson.getObj().size() == 0 || !userPrivTypeToJson.getObj().stream().anyMatch(userPrivType -> userPrivType.getPrivTypeId() == priv.getPrivTypeId())){
                json.setFlag(0);
                json.setMsg("无权限修改此角色");
                return json;
            }


            if (userPriv.getFuncIdStr() == null) {

                //分级机构角色管理限制修改角色分类
                userPriv.setPrivTypeId(null);

                if (userPriv.getPrivNo() == null) {
                    json.setMsg("角色排序号不能为空");
                    json.setFlag(1);
                    return json;
                }
                if (StringUtils.checkNull(userPriv.getPrivName())) {
                    json.setMsg("角色名称不能为空");
                    json.setFlag(1);
                    return json;
                }
                int count = usersPrivService.updateUserPriv(userPriv);
                if (count == 2) {
                    json.setMsg("角色名称不能重复");
                    json.setFlag(1);
                } else {
                    sysLog.setRemark("privNo:" + userPriv.getPrivNo() + ",privName:" + userPriv.getPrivName());
                    sysLog.setTime(new Date(System.currentTimeMillis()));
                    syslogMapper.save(sysLog);
                    json.setMsg("修改成功");
                    json.setFlag(0);
                }
            } else {

                List<Integer> funcIds = userPrivTypeService.getPrivTypeFuncIds(users);
                if(funcIds.size() == 1 && funcIds.get(0) == 0){
                    json.setFlag(0);
                    json.setMsg("无角色分类");
                    return json;
                }
                //有限制菜单需要从限制菜单中取，过滤限制菜单之外的菜单id。无限制菜单说明无限制
                if(funcIds.size() > 0){
                    Set<Integer> userFuncIds = Arrays.stream(userPriv.getFuncIdStr().split(",")).mapToInt(Integer::valueOf).boxed().collect(Collectors.toSet());
                    funcIds.retainAll(userFuncIds);
                    userPriv.setFuncIdStr(funcIds.stream().map(String::valueOf).collect(Collectors.joining(",")));
                }

                int count = usersPrivService.updateUserPriv(userPriv);
                sysLog.setRemark("userPriv:" + userPriv.getUserPriv() + ",funcidStr：" + userPriv.getFuncIdStr());
                sysLog.setTime(new Date(System.currentTimeMillis()));
                syslogMapper.save(sysLog);
                json.setMsg("修改成功");
                json.setFlag(0);
            }
            String functionIdStr = userFunctionMapper.getUserFuncIdStr(users.getUserId());
            SessionUtils.putSession(request.getSession(), "functionIdStr", functionIdStr, redisSessionCookie);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("修改失败");
            L.e("UserPrivController updateUserPriv:" + e);
        }
        return json;
    }


    /**
     * 创建日期:   2022年3月29日
     * 方法介绍:   根据角色id查找角色（增加角色分类权限过滤）
     * 参数说明:   @param userPriv  用户角色
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>   返回用户角色
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/queryByuserPriv")
    public ToJson<UserPriv> queryUserByuserPriv(int userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            UserPriv priv = usersPrivService.selectByPrimaryKey(userPriv);
            ToJson<UserPrivType> userPrivTypeToJson = userPrivTypeService.selUserPrivTypeByDept(request);
            if(!userPrivTypeToJson.isFlag() || Objects.isNull(userPrivTypeToJson.getObj())
                    || userPrivTypeToJson.getObj().size() == 0 || !userPrivTypeToJson.getObj().stream().anyMatch(userPrivType -> userPrivType.getPrivTypeId() == priv.getPrivTypeId())){
                json.setFlag(0);
                json.setMsg("无权限查询此角色");
                return json;
            }
            json.setObject(priv);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建日期:   2022年3月29日
     * 方法介绍:   分支机构 添加角色
     * 参数说明:   @param userPriv  用户角色
     * 参数说明:   @return
     *
     * @return ToJson<UserPriv>  返回页面显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/userPriv/addClassifyOrgUserPriv", method = RequestMethod.POST)
    public ToJson<UserPriv> addUserPriv(UserPriv userPriv, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        try {
            if(Objects.isNull(userPriv.getPrivTypeId())){
                json.setMsg("角色分类不能为空");
                json.setFlag(1);
                return json;
            }
            List<Integer> privTypeIdList = userPrivTypeService.checkPrivTypeIdByDept(users);
            if(!privTypeIdList.contains(userPriv.getPrivTypeId())){
                json.setMsg("无权限在此角色分类下新建角色");
                json.setFlag(1);
                return json;
            }
            int count = usersPrivService.insertSelective(userPriv);
            if (userPriv.getPrivNo() == null) {
                json.setMsg("角色排序号不能为空");
                json.setFlag(1);
                return json;
            }
            if (StringUtils.checkNull(userPriv.getPrivName())) {
                json.setMsg("角色名称不能为空");
                json.setFlag(1);
                return json;
            }
            if (count == 2) {
                json.setMsg("角色名称不能重复");
                json.setFlag(1);
            } else {
                json.setMsg("新建成功 ");
                json.setFlag(0);
                json.setObject(userPriv);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("新建失败 ");
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/9/20
     * 方法介绍: 判断当前登陆人是否为中高管，是则日志周报使用 中高管工作日志模板
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping("/userPriv/selectIsZhongGaoGuan")
    public ToJson<UserPriv> selectIsZhongGaoGuan(HttpServletRequest request){
        return usersPrivService.selectIsZhongGaoGuan(request);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/1
     * 方法介绍: 根据角色id获取角色类型菜单id串
     * 参数说明: [request, userPriv]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/userPriv/findUserPrivAndTypeFuncIdStr")
    public ToJson<UserPriv> findUserPrivAndTypeFuncIdStr(HttpServletRequest request, int userPriv) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        try {
            UserPriv priv = usersPrivService.findUserPrivAndTypeFuncIdStr(userPriv);
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(priv);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/13
     * 方法介绍: 根据当前登陆人所在的分支机构
     * 参数说明: [request, maps, page, pageSize, useFlag]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping(value = "/userPriv/getAllPrivByClassifyOrg", produces = {"application/json;charset=UTF-8"})
    public ToJson<UserPriv> getAllPrivByClassifyOrg(HttpServletRequest request, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, null);
        String check = request.getParameter("check");
        String moduleId = request.getParameter("moduleId");
        try {
            List<UserPriv> list = new ArrayList<>();

            String privName = "";
            if (!StringUtils.checkNull(request.getParameter("search"))) {
                privName = URLDecoder.decode(request.getParameter("search"), "utf-8");
            }

            if (!StringUtils.checkNull(moduleId)) {
                ModulePriv module = new ModulePriv();
                module.setUid(users.getUid());
                module.setModuleId(Integer.valueOf(moduleId));
                ModulePriv modulePriv = modulePrivMapper.getModulePrivSingle(module);

                if (!Objects.isNull(modulePriv)) {
                    //人员角色范围（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
                    UserPriv userPriv = userPrivMapper.getUserPriv(users.getUserPriv());
                    switch (modulePriv.getRolePriv()) {
                        case "0":
                            maps.put("moduleRolePrivNo", userPriv.getPrivNo());
                            break;
                        case "1":
                            maps.put("moduleRolePrivNo", userPriv.getPrivNo() - 1);
                            break;
                        case "3":
                            maps.put("moduleRolePrivIds", modulePriv.getPrivId().split(","));
                            break;
                        default:
                            break;
                    }
                }
            }

            //根据当前用户所在的分支机构设置角色分类，查询角色
            //是否开启分级机构设置
            String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
            if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
                //开启，根据当前用户所在的分支机构的角色分类，查询角色
                //获取当前用户所在的分支机构
                Department department = departmentServiceImpl.queryDeptParent(users.getDeptId());
                if (department != null) {
                    if (!StringUtils.checkNull(department.getPrivTypes())) {
                        Set<Integer> privTypeIds = new HashSet<>(Arrays.stream(department.getPrivTypes().split(",")).map(Integer::parseInt).collect(Collectors.toList()));
                        Map<String, Object> map = new HashMap<>();
                        map.put("userPrivTypes", privTypeIds);
                        if (!StringUtils.checkNull(privName)) {
                            map.put("privName", privName);
                        }
                        list = userPrivMapper.queryUserPrivByPrivName(map);
                    }
                } else {
                    //不是分支机构用户，则返回所有角色分类
                    //获取用户角色和辅助角色中权限最大的一个角色序号
                    String userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
                    String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
                    List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
                    List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
                    UserPriv userPriv = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
                    //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
                    if (userPrivAdmin.size() == 0 && userPriv.getPrivType() == 0) {
                        maps.put("privNoS", userPriv.getPrivNo());
                        maps.put("privType", userPriv.getPrivType());
                    }
                    if (!"1".equals(users.getUserPriv().toString()) && !StringUtils.checkNull(check)) {
                        maps.put("check", "1");
                    }
                    if (!StringUtils.checkNull(privName)) {
                        maps.put("privName", privName);
                        list = usersPrivService.getPrivBySearch(maps);
                    } else {
                        list = usersPrivService.getAllPriv(maps, page, pageSize, useFlag);
                    }
                }
            } else {
                //没有开启，返回所有角色
                //获取用户角色和辅助角色中权限最大的一个角色序号
                String userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
                String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
                List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
                List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
                UserPriv userPriv = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
                //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
                if (userPrivAdmin.size() == 0 && userPriv.getPrivType() == 0) {
                    maps.put("privNoS", userPriv.getPrivNo());
                    maps.put("privType", userPriv.getPrivType());
                }
                if (!"1".equals(users.getUserPriv().toString()) && !StringUtils.checkNull(check)) {
                    maps.put("check", "1");
                }
                if (!StringUtils.checkNull(privName)) {
                    maps.put("privName", privName);
                    list = usersPrivService.getPrivBySearch(maps);
                } else {
                    list = usersPrivService.getAllPriv(maps, page, pageSize, useFlag);
                }
            }

            if (!CollectionUtils.isEmpty(list)) {
                //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
                securityApprovalService.removeSecrecyUsers(null,list);

                json.setFlag(0);
                json.setMsg("OK");
                json.setObj(list);
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

}
