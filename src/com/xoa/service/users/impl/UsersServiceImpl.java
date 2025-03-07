package com.xoa.service.users.impl;

import com.alibaba.fastjson.JSONObject;
import com.ibatis.common.resources.Resources;
import com.xoa.dao.IMUser.IMUsersMapper;
import com.xoa.dao.appoauser.AppOaUserMapper;
import com.xoa.dao.attend.AttendSetMapper;
import com.xoa.dao.attendance.AttendScheduleMapper;
import com.xoa.dao.attendance.UserDutyMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.dingdingManage.UserDDMapMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.hierarchical.HierarchicalGlobalMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.organization.DeptMapper;
import com.xoa.dao.organization.PersonMapper;
import com.xoa.dao.portals.PortalsMapper;
import com.xoa.dao.position.PositionManagementMapper;
import com.xoa.dao.qiyeWeixin.UserWeixinqyMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.thirdSysConfig.ThirdSysConfigMapper;
import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.users.*;
import com.xoa.model.appoauser.AppOaUser;
import com.xoa.model.attend.AttendSet;
import com.xoa.model.attendance.AttendScheduleWithBLOBs;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.dingdingManage.UserDDMap;
import com.xoa.model.duties.UserPost;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.position.UserJob;
import com.xoa.model.qiyeWeixin.UserWeixinqy;
import com.xoa.model.securityApproval.SecurityApprovalWithBLOBs;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.unitmanagement.UnitManage;
import com.xoa.model.users.*;
import com.xoa.service.IMUser.IMUsersService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.department.impl.DepartmentServiceImpl;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.securityApproval.SecurityLogService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.dataSource.Verification;
import com.xoa.util.encrypt.EncryptSalt;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.ibatis.exceptions.TooManyResultsException;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import seamoonotp.seamoonapi;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.ParseException;
import java.util.*;
import java.util.stream.Collectors;

import static com.xoa.util.FileUploadUtil.allowUpload;


/**
 * 创建作者:
 * 创建日期:   2017年4月18日 下午6:29:38
 * 类介绍  :    用户service接口实现类
 * 构造参数:
 */
@Service
public class UsersServiceImpl implements UsersService {

    private final String one = "1";

    @Resource
    SystemInfoService systemInfoService;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private SyslogMapper syslogMapper;
    @Resource
    private UsersPrivService usersPrivService;
    @Resource
    private OrgManageMapper orgManageMapper;
    @Resource
    private UserExtMapper userExtMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UserPrivMapper userPrivMapper;
    @Resource
    private ModulePrivMapper modulePrivMapper;
    @Resource
    private UserFunctionMapper userFunctionMapper;

    @Resource
    private AttendSetMapper attendSetMapper;
    @Resource
    private SysInterfaceMapper sysInterfaceMapper;

    @Resource
    private DutiesManagementMapper managementMapper;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;
    @Resource
    private UnitManageMapper unitManageMapper;

    @Resource
    OrgManageService orgManageService;

    @Resource
    private UserExt2Mapper userExt2Mapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private DepartmentServiceImpl departmentServiceImpl;

    @Resource
    private IMUsersService imUsersService;

    @Autowired
    private AttendScheduleMapper attendScheduleMapper;

    @Autowired
    private UserDutyMapper userDutyMapper;


    @Autowired
    private UserWeixinqyMapper userWeixinqyMapper;

    @Autowired
    private UserDDMapMapper userDDMapMapper;

    @Autowired
    private AppOaUserMapper appOaUserMapper;

    @Autowired
    private HierarchicalGlobalMapper hierarchicalGlobalMapper;
    @Autowired
    private PositionManagementMapper positionManagementMapper;

    @Autowired
    private UserDeptOrderMapper userDeptOrderMapper;

    @Resource
    private DutiesManagementMapper dutiesManagementMapper;

    @Autowired
    private PortalsMapper portalsMapper;

    @Resource
    private EnclosureService enclosureService;

    @Autowired
    ThirdSysConfigMapper thirdSysConfigMapper;

    @Autowired
    DeptMapper deptMapper;

    @Autowired
    PersonMapper personMapper;

    @Resource
    private IMUsersMapper imUsersMapper;
    @Resource
    private SmsService smsService;
    @Resource
    private Sms2PrivService sms2PrivService;


    @Resource
    private ModulePrivService modulePrivService;

    @Resource
    private SecurityApprovalService securityApprovalService;

    @Resource
    private SecurityLogService securityLogService;


    /**
     * 创建作者:
     * 创建日期:   2017年4月18日 下午4:44:24
     * 方法介绍:   添加用户
     * 参数说明:   @param user  用户信息
     *
     * @return void   无
     */
    @Override
    @Transactional
    public ToJson<Users> addUser(Users user, UserExt userExt, ModulePriv modulePriv, HttpServletRequest request) {
        ToJson<Users> tojson = new ToJson<Users>();
        UserFunction userFunction = new UserFunction();

        //检查用户ID或用户名是否重复
        if(!StringUtils.checkNull(user.getUserId()) || !StringUtils.checkNull(user.getByname())){
            List<Users> users = usersMapper.selectUsersByNameAndUserId(user.getByname(), user.getUserId());
            if(users.size() > 0){
                tojson.setMsg("存在相同用户ID或用户名的用户，请修改");
                return tojson;
            }
        }

        //开启了三员管理，新增用户时不允许填写用户的密级和管理范围，需要三员中的系统安全保密员进行审批定级和指定管理范围
        SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
        if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
            modulePriv = null;
            user.setUserSecrecy(null);
            user.setPostPriv(null);
            user.setPostDept(null);

            //新建的用户审核通过前禁止登录，审核通过再设置允许
            user.setNotLogin(1);
            user.setNotMobileLogin(1);
        }

        //增加用户名头尾空格处理
        user.setByname(user.getByname().trim());

        String pwd = user.getPassword();
        // 查询是否有重复用户名用户(项目很多用户没有用户名，byname字段为空，做非空判断)
        if(!StringUtils.checkNull(user.getByname())) {
            Users usersByuserId = usersMapper.getUsersBybyname(user.getByname());
     /*   if (usersByuserId != null && usersByuserId.getByname().equals(user.getByname())) {
            tojson.setObject(usersByuserId);
            tojson.setMsg("此用户名已存在，请修改");
            tojson.setFlag(1);
            return tojson;
        }*/
            //注释上面  因为mysql不区分大小写，用户的byname大小写区分
            if (usersByuserId != null) {
                tojson.setObject(usersByuserId);
                tojson.setMsg("此用户名已存在，请修改");
                tojson.setFlag(1);
                return tojson;
            }
        }

        //如果用户多于使用限制就不添加
        boolean userToMany = false;
        if (request != null) {
            if (request.getSession() == null) {
                userToMany = false;
            } else {
                userToMany = false;
            }
        }

        //新增时定义变量  用于同步密码使用
        String syncPassword=null;
        if (user != null) {
            syncPassword=user.getPassword();
            if (userToMany) {
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            // 设置默认值
            if (user.getUserNo() == null) {
                user.setUserNo((int) 10);
            }
            if (null == user.getTheme() || 0 == user.getTheme()) {
                List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
                user.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            }
            user.setMenuImage("0");
            user.setShowRss("1");
            user.setLimitLogin("0");
            user.setSecretLevel(0);
            if (StringUtils.checkNull(user.getMytableLeft())) {
                user.setMytableLeft("ALL");
            }
            if (StringUtils.checkNull(user.getMytableRight())) {
                user.setMytableRight("ALL");
            }
            // 加密密码
            if (user.getPassword() != null) {
                String password = user.getPassword();
                password = getEncryptString(password.trim());
                user.setPassword(password);
            }

            // 添加用户姓名索引
            if (!StringUtils.checkNull(user.getUserName())) {
                String fistSpell = PinYinUtil.getFirstSpell(user.getUserName());
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < fistSpell.length(); i++) {
                    sb.append(fistSpell.charAt(i) + "*");
                }
                user.setUserNameIndex(sb.toString());
            }

            // 设置用户的角色名称和序号
            if (user.getUserPriv() != null) {
                UserPriv userPriv = userPrivMapper.selectByPrimaryKey(user.getUserPriv());
                if (userPriv != null) {
                    user.setUserPrivNo(userPriv.getPrivNo());
                    user.setUserPrivName(userPriv.getPrivName());
                    if (userPriv.getFuncIdStr() != null) {
                        userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
                    } else {
                        userFunction.setUserFunCidStr("1,");
                    }
                }
            }
            if (!StringUtils.checkNull(user.getUserPrivOther())) {
                String[] strings = user.getUserPrivOther().split(",");
                StringBuffer privaNoBuffer = new StringBuffer();
                StringBuffer privaNameBuffer = new StringBuffer();
                StringBuffer funcIdStrBuffer = new StringBuffer();
                for (int i = 0; i < strings.length; i++) {
                    UserPriv userPriv = userPrivMapper.selectByPrimaryKey(Integer.parseInt(strings[i]));
                    if (userPriv != null) {
                        privaNoBuffer.append(userPriv.getUserPriv() + ",");
                        privaNameBuffer.append(userPriv.getPrivName() + ",");
                        if (userPriv.getFuncIdStr() != null) {
                            funcIdStrBuffer.append(userPriv.getFuncIdStr());
                        }
                    }
                }
                user.setUserPrivOther(String.valueOf(privaNoBuffer));
                user.setUserPrivOtherName(String.valueOf(privaNameBuffer));
                userFunction.setUserFunCidStr(userFunction.getUserFunCidStr() + String.valueOf(funcIdStrBuffer));

            }


            // 设置头像
            user.setAvatar(user.getSex());
        }

        Users nowUser = null;
        if (request != null) {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        }

        //加入操作日志处理
        Syslog sysLog = new Syslog();
        if (nowUser != null) {
            sysLog.setUserId(nowUser.getUserId() + "");
        } else {
            sysLog.setUserId("");
            sysLog.setRemark("未知用户添加");
        }
        sysLog.setType(6);
        sysLog.setTypeName("添加用户");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = "";
        if(request!=null){
            userAgent = request.getParameter("userAgent");
        }
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
            String clientVersion = "";
            if(request!=null){
                clientVersion = request.getParameter("clientVersion");
            }
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }

        try {
            //判断禁止登录用户是否可以添加登录信息
            if (user.getNotLogin() == 1 || user.getNotLogin() == 0) {
                Object locale = null;
                String realPath = null;
                Map<String, String> m = new HashMap<>();
                if(request!=null){
                    locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                    realPath = request.getSession().getServletContext().getRealPath("/");
                    m = systemInfoService.getSystemInfo(realPath, locale, request);
                } else {
                    // request为null的情况为 项目中同步用户的情况 默认不限制
                    m.put("oaUserLimit","不限制");
                }
                int oaUserLimit = 0;

                if ("不限制".equals(m.get("oaUserLimit"))) {
                    if (!StringUtils.checkNull(user.getUserName()) && user.getDeptId() != null && user.getUserPriv() != null) {
                        user.setLastVisitIp("");
                        user.setImRange(0);
                        user.setNotLogin(Objects.isNull(user.getNotLogin()) ? 0 : user.getNotLogin());
                        user.setNotMobileLogin(Objects.isNull(user.getNotMobileLogin()) ? 0 : user.getNotMobileLogin());
                        usersMapper.insert(user);

                        // 是否插入用户部门排序
                        insertOrder(user);

                        Department department = departmentMapper.getDeptById(user.getDeptId());
                        sysLog.setRemark("[" + department.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId());
                        sysLog.setTime(new Date(System.currentTimeMillis()));
                        syslogMapper.save(sysLog);
                        SysPara sysPara = sysParaMapper.querySysPara("OFUSERPWD");
                        if (sysPara != null) {
                            if (sysPara.getParaValue().equals("1")) {
                                UserExt2 userExt2 = new UserExt2();
                                userExt2.setUid(user.getUid());
                                if (pwd != null && !pwd.equals("")) {
                                    userExt2.setPassword(pwd);
                                } else {
                                    userExt2.setPassword("");
                                }
                                userExt2.setUserId(user.getUserId());
                                userExt2Mapper.addUserExt(userExt2);
                            }
                        }
                        userExt.setUid(user.getUid());
                        userExt.setUserId(user.getUserId());
                        userExtMapper.addUserExt(userExt);
                        userFunction.setUid(user.getUid());
                        userFunction.setUserId(user.getUserId());
                        if (!StringUtils.checkNull(userFunction.getUserFunCidStr())) {
                            TreeSet<String> ts = new TreeSet<>();
                            int len1 = userFunction.getUserFunCidStr().split(",").length;
                            String ss[] = userFunction.getUserFunCidStr().split(",");
                            for (int i1 = 0; i1 < len1; i1++) {
                                ts.add(ss[i1] + "");
                            }
                            //2.循环遍历TreeSet
                            Iterator<String> i1 = ts.iterator();
                            StringBuilder sb1 = new StringBuilder();
                            while (i1.hasNext()) {
                                sb1.append(i1.next() + ",");
                            }
                            userFunction.setUserFunCidStr(String.valueOf(sb1));
                        }
                        userFunctionMapper.insertUserFun(userFunction);

                        if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                            //查询保密员
                            Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                            //创建一条审批数据
                            securityApprovalService.insertSelective("user", user.getUid(), nowUser.getUserId(), "", "0", "", null,null,sysSecurityUser.getUserId());
                        }


                        //杨岩林改
                        if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                            modulePriv = new ModulePriv();
                            modulePriv.setUid(user.getUid());
                            modulePriv.setModuleId(0);
                            modulePriv.setDeptPriv(user.getPostPriv());
                            modulePriv.setDeptId(user.getPostDept());
                            // 查询判断是否存在白名单 如果存在就更新 如果不存在就保存
                            ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);
                            if (modulePrivByUid != null) {
                                if (!StringUtils.checkNull(modulePriv.getDeptId()) || !StringUtils.checkNull(modulePriv.getPrivId()) || !StringUtils.checkNull(modulePriv.getUserId())) {
                                    modulePrivMapper.updateModulePriv(modulePriv);
                                }
                            } else {
                                modulePrivMapper.addModulePriv(modulePriv);
                            }
                        }
                        //user=usersMapper.findUserByuid(user.getUid());
                        //添加到中间表数据
                        if (request != null) {
                            user.setLoginId((String) request.getSession().getAttribute(
                                    "loginDateSouse"));
                        } else {
                            user.setLoginId("1001");
                        }
                        tojson.setObject(user);
                        tojson.setFlag(0);
                        tojson.setMsg("OK");
                    } else {
                        tojson.setFlag(1);
                        tojson.setMsg("新建失败");
                    }
                } else {
                    //授权人数
                    oaUserLimit = Integer.parseInt(m.get("oaUserLimit"));
                    //允许登录用户数
                    int canLoginUser = this.getCanLoginUser();
                    if (canLoginUser >= oaUserLimit) {
                        //判断能不能修改成允许登录用户
                        user.setNotLogin(1);
                        user.setNotMobileLogin(1);
                        if (!StringUtils.checkNull(user.getUserName()) && user.getDeptId() != null && user.getUserPriv() != null) {
                            user.setLastVisitIp("");
                            user.setImRange(0);
                            usersMapper.insert(user);
                            // 是否插入用户部门排序
                            insertOrder(user);

                            Department department = departmentMapper.getDeptById(user.getDeptId());
                            sysLog.setRemark("[" + department.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId());
                            sysLog.setTime(new Date(System.currentTimeMillis()));
                            syslogMapper.save(sysLog);
                            SysPara sysPara = sysParaMapper.querySysPara("OFUSERPWD");
                            if (sysPara != null) {
                                if (sysPara.getParaValue().equals("1")) {
                                    UserExt2 userExt2 = new UserExt2();
                                    userExt2.setUid(user.getUid());
                                    if (pwd != null && !pwd.equals("")) {
                                        userExt2.setPassword(pwd);
                                    } else {
                                        userExt2.setPassword("");
                                    }
                                    userExt2.setUserId(user.getUserId());
                                    userExt2Mapper.addUserExt(userExt2);
                                }
                            }
                            userExt.setUid(user.getUid());
                            userExt.setUserId(user.getUserId());
                            userExtMapper.addUserExt(userExt);
                            userFunction.setUid(user.getUid());
                            userFunction.setUserId(user.getUserId());
                            if (!StringUtils.checkNull(userFunction.getUserFunCidStr())) {
                                TreeSet<String> ts = new TreeSet<>();
                                int len1 = userFunction.getUserFunCidStr().split(",").length;
                                String ss[] = userFunction.getUserFunCidStr().split(",");
                                for (int i1 = 0; i1 < len1; i1++) {
                                    ts.add(ss[i1] + "");
                                }
                                //2.循环遍历TreeSet
                                Iterator<String> i1 = ts.iterator();
                                StringBuilder sb1 = new StringBuilder();
                                while (i1.hasNext()) {
                                    sb1.append(i1.next() + ",");
                                }
                                userFunction.setUserFunCidStr(String.valueOf(sb1));
                            }
                            userFunctionMapper.insertUserFun(userFunction);

                            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                                //查询保密员
                                Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                                //创建一条审批数据
                                securityApprovalService.insertSelective("user", user.getUid(), nowUser.getUserId(), "", "0", "", null,null,sysSecurityUser.getUserId());
                            }


                            //杨岩林改
                            if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                                modulePriv = new ModulePriv();
                                modulePriv.setUid(user.getUid());
                                modulePriv.setModuleId(0);
                                modulePriv.setDeptPriv(user.getPostPriv());
                                modulePriv.setDeptId(user.getPostDept());
                                // 查询判断是否存在白名单 如果存在就更新 如果不存在就保存
                                ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);
                                if (modulePrivByUid != null) {
                                    if (!StringUtils.checkNull(modulePriv.getDeptId()) || !StringUtils.checkNull(modulePriv.getPrivId()) || !StringUtils.checkNull(modulePriv.getUserId())) {
                                        modulePrivMapper.updateModulePriv(modulePriv);
                                    }
                                } else {
                                    modulePrivMapper.addModulePriv(modulePriv);
                                }
                            }
                            //user=usersMapper.findUserByuid(user.getUid());
                            //添加到中间表数据
                            if (request != null) {
                                user.setLoginId((String) request.getSession().getAttribute(
                                        "loginDateSouse"));
                            } else {
                                user.setLoginId("1001");
                            }
                            tojson.setObject(user);
                            tojson.setMsg("允许登陆OA用户达到上限，请联系管理员！");
                            tojson.setFlag(0);
                        } else {
                            tojson.setFlag(1);
                            tojson.setMsg("新建失败");
                        }
                    } else {
                        if (!StringUtils.checkNull(user.getUserName()) && user.getDeptId() != null && user.getUserPriv() != null) {
                            user.setLastVisitIp("");
                            user.setImRange(0);
//                            user.setNotLogin((byte) 0);
//                            user.setNotMobileLogin(0);
                            usersMapper.insert(user);

                            Department department = departmentMapper.getDeptById(user.getDeptId());
                            sysLog.setRemark("[" + department.getDeptName() + "]" + user.getUserName() + ",USER_ID=" + user.getUserId());
                            sysLog.setTime(new Date(System.currentTimeMillis()));
                            syslogMapper.save(sysLog);
                            SysPara sysPara = sysParaMapper.querySysPara("OFUSERPWD");
                            if (sysPara != null) {
                                if (sysPara.getParaValue().equals("1")) {
                                    UserExt2 userExt2 = new UserExt2();
                                    userExt2.setUid(user.getUid());
                                    if (pwd != null && !pwd.equals("")) {
                                        userExt2.setPassword(pwd);
                                    } else {
                                        userExt2.setPassword("");
                                    }
                                    userExt2.setUserId(user.getUserId());
                                    userExt2Mapper.addUserExt(userExt2);
                                }
                            }
                            userExt.setUid(user.getUid());
                            userExt.setUserId(user.getUserId());
                            userExtMapper.addUserExt(userExt);
                            userFunction.setUid(user.getUid());
                            userFunction.setUserId(user.getUserId());
                            if (!StringUtils.checkNull(userFunction.getUserFunCidStr())) {
                                TreeSet<String> ts = new TreeSet<>();
                                int len1 = userFunction.getUserFunCidStr().split(",").length;
                                String ss[] = userFunction.getUserFunCidStr().split(",");
                                for (int i1 = 0; i1 < len1; i1++) {
                                    ts.add(ss[i1] + "");
                                }
                                //2.循环遍历TreeSet
                                Iterator<String> i1 = ts.iterator();
                                StringBuilder sb1 = new StringBuilder();
                                while (i1.hasNext()) {
                                    sb1.append(i1.next() + ",");
                                }
                                userFunction.setUserFunCidStr(String.valueOf(sb1));
                            }
                            userFunctionMapper.insertUserFun(userFunction);

                            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                                //查询保密员
                                Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                                //创建一条审批数据
                                securityApprovalService.insertSelective("user", user.getUid(), nowUser.getUserId(), "", "0", "", null,null,sysSecurityUser.getUserId());
                            }

                            //杨岩林改
                            if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                                modulePriv = new ModulePriv();
                                modulePriv.setUid(user.getUid());
                                modulePriv.setModuleId(0);
                                modulePriv.setDeptPriv(user.getPostPriv());
                                modulePriv.setDeptId(user.getPostDept());
                                // 查询判断是否存在白名单 如果存在就更新 如果不存在就保存
                                ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);
                                if (modulePrivByUid != null) {
                                    if (!StringUtils.checkNull(modulePriv.getDeptId()) || !StringUtils.checkNull(modulePriv.getPrivId()) || !StringUtils.checkNull(modulePriv.getUserId())) {
                                        modulePrivMapper.updateModulePriv(modulePriv);
                                    }
                                } else {
                                    modulePrivMapper.addModulePriv(modulePriv);
                                }
                            }
                            //user=usersMapper.findUserByuid(user.getUid());
                            //添加到中间表数据
                            if (request != null) {
                                user.setLoginId((String) request.getSession().getAttribute(
                                        "loginDateSouse"));
                            } else {
                                user.setLoginId("1001");
                            }

                            tojson.setObject(user);
                            tojson.setFlag(0);
                            tojson.setMsg("新建成功");
                        } else {
                            tojson.setFlag(1);
                            if (StringUtils.checkNull(user.getUserName())) {
                                tojson.setMsg("新建失败，姓名不能为空");
                            } else if (user.getDeptId() == null) {
                                tojson.setMsg("新建失败，部门不能为空");
                            } else if (user.getUserPriv() == null) {
                                tojson.setMsg("新建失败，角色不能为空");
                            } else {
                                tojson.setMsg("新建失败");
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            tojson.setFlag(1);
            tojson.setMsg("新建失败");
        }
        return tojson;

    }

    private ToJson insertOrder(Users user) {
        ToJson json = new ToJson(1, "error");
        try {
            UserDeptOrder userDeptOrder = new UserDeptOrder();//新建人员时插入
            userDeptOrder.setDeptId(user.getDeptId());
            userDeptOrder.setUserId(user.getUserId());
            userDeptOrder.setOrderNo(user.getUserNo());
            userDeptOrder.setPostId(user.getPostId());
            UserDeptOrder userDept1 = userDeptOrderMapper.selectUserAndDept(user.getUserId(), user.getDeptId());
            if (userDept1 == null) {// 防止部门 和辅助部门设置同一个
                userDeptOrderMapper.insertSelective(userDeptOrder);
            }
            if (!StringUtils.checkNull(user.getDeptIdOther())) {    //判断是否有其他部门
                String[] split = user.getDeptIdOther().split(",");
                for (int i = 0; i < split.length; i++) {
                    UserDeptOrder userDeptOrders = new UserDeptOrder();//新建人员时插入
                    userDeptOrders.setDeptId(Integer.parseInt(split[i]));
                    userDeptOrders.setUserId(user.getUserId());
                    userDeptOrders.setOrderNo(user.getUserNo());
                    userDeptOrders.setPostId(user.getPostId());
                    UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(user.getUserId(), Integer.parseInt(split[i]));
                    if (userDeptOrder1 == null) {// 防止部门 和辅助部门设置同一个
                        userDeptOrderMapper.insertSelective(userDeptOrders);
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月23日 下午1:39:34
     * 方法介绍:   修改用户
     * 参数说明:   @param user 用户
     * 参数说明:   @return
     *
     * @return ToJson<Users>  用户
     */
    @Override
    @Transactional
    public ToJson<Users> editUser(HttpServletRequest request, Users user, UserExt userExt, ModulePriv modulePriv) {
        ToJson<Users> tojson = new ToJson<Users>();

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users use = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

        UserFunction userFunction = new UserFunction();
        String pwd = user.getPassword();
        Users usersByuserId = usersMapper.findUserByuid(user.getUid());

        //检查用户ID或用户名是否重复
        if(!StringUtils.checkNull(user.getUserId()) || !StringUtils.checkNull(user.getByname())){
            List<Users> users = usersMapper.selectUsersByNameAndUserId(user.getByname(), user.getUserId());
            for (Users u : users) {
                if(!u.getUid().equals(user.getUid())){
                    tojson.setMsg("存在相同用户ID或用户名的用户，请修改");
                    return tojson;
                }
            }
        }

        //检查用户的管理范围和密级是否被修改
        if(!(user.getUserSecrecy() + "").equals(usersByuserId.getUserSecrecy() + "") || !(user.getPostPriv() + "").equals(usersByuserId.getPostPriv() + "")
                || !(user.getPostDept() + "").equals(usersByuserId.getPostDept() + "")){
            //查询是否开启三员管理
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
                //查询修改的用户是否存在保密员未审批的变更
                List<SecurityApprovalWithBLOBs> securityApprovalWithBLOBs = securityApprovalService.queryNotApprove("0","user",user.getUid().toString());
                if(securityApprovalWithBLOBs.size() > 0){
                    tojson.setMsg("用户存在未审批的变更，审批后可修改");
                    return tojson;
                }

                JSONObject jsonObject = new JSONObject();
                jsonObject.put("userSecrecy", user.getUserSecrecy());
                jsonObject.put("postPriv", user.getPostPriv());
                jsonObject.put("postDept", user.getPostDept());
                //查询保密员
                Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                //创建一条审批数据
                String attachmentId = request.getParameter("attachmentId");
                String attachmentName = request.getParameter("attachmentName");
                String operationReason = request.getParameter("operationReason");
                securityApprovalService.insertSelective("user", user.getUid(), use.getUserId(), jsonObject.toJSONString(), "1", operationReason, attachmentId, attachmentName, sysSecurityUser.getUserId());
                //待审批的信息，审批过后更新，此时还使用原来的值不更新
                user.setUserSecrecy(usersByuserId.getUserSecrecy());
                user.setPostPriv(usersByuserId.getPostPriv());
                user.setPostDept(usersByuserId.getPostDept());
            }
        }

        //增加用户名头尾空格处理
        if(!StringUtils.checkNull(user.getByname())) {
            user.setByname(user.getByname().trim());
        }

        //判断用户名是否需要修改
        if(!usersByuserId.getByname().equals(user.getByname())){
            boolean editByNameFlag = false;
            if(!editByNameFlag){
                //用户角色为管理员，允许修改用户名
                if(use.getUserPriv().equals(1)) {
                    editByNameFlag = true;
                }
            }
            if(!editByNameFlag){
                //系统参数设置-是否允许修改用户名
                SysPara editByname = sysParaMapper.querySysPara("EDIT_BYNAME");
                if(!Objects.isNull(editByname) && "1".equals(editByname.getParaValue())){
                    editByNameFlag = true;
                }
            }
            if(!editByNameFlag){
                //是否设置了用户管理模块的管理范围
                String moduleId = request.getParameter("moduleId");
                Map<String, Object> map = modulePrivService.getModulePriv(use, moduleId);
                map.put("userId",usersByuserId.getUserId());
                Users usersByModulePriv = imUsersMapper.getUsersByuserIdBai(map);
                if(!Objects.isNull(usersByModulePriv) && !Objects.isNull(usersByModulePriv.getUid())){
                    editByNameFlag = true;
                }
            }

            //设置不为空并且允许修改判断用户名是否重复
            Users usersBybyname = usersMapper.getUsersBybyname(user.getByname());
            if(!Objects.isNull(usersBybyname)){
                tojson.setMsg("用户名重复，请修改");
                return tojson;
            }

            //不允许修改用户名将字段置为空
            if(!editByNameFlag) {
                user.setByname(null);
            }
        }


        String myProject = null;

        SysPara myproject = sysParaMapper.querySysPara("MYPROJECT");
        if(myproject!=null){
            myProject = myproject.getParaValue();//防止有的产品没有myproject这个值
        }

        // 处理用户辅助角色和辅助部门中的null问题
        if(!StringUtils.checkNull(user.getUserPrivOther())&&user.getUserPrivOther().contains("null")){
            user.setUserPrivOther(user.getUserPrivOther().replace("null",""));
        }
        if(!StringUtils.checkNull(user.getDeptIdOther())&&user.getDeptIdOther().contains("null")){
            user.setDeptIdOther(user.getDeptIdOther().replace("null",""));
        }

        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(use.getUserId() + "");
        sysLog.setType(7);
        sysLog.setTypeName("编辑用户");
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

        String syncPassword=user.getPassword();
        if (user != null) {
            //如果用户多于使用限制就不添加
            boolean userToMany;
            //    if (request.getSession() == null) {
            userToMany = false;
            // } else {
            //  userToMany = isUserToMany(request);
            //   }
            if (userToMany) {
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            // 查询是否有重复用户名用户
           /*if (user.getByname() != null && user.getByname() != "") {
                //判断允许登录用户数是否达到限定用户数上限
                if (1==usersByuserId.getNotLogin()&&0==user.getNotLogin()){
                    try {
                        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                        String realPath = request.getSession().getServletContext().getRealPath("/");
                        Map<String, String> m = systemInfoService.getSystemInfo(realPath, locale, request);
                        int oaUserLimit = Integer.parseInt(m.get("oaUserLimit"));
                        //允许登录用户数
                        int canLoginUser = this.getCanLoginUser();
                        if (canLoginUser >= oaUserLimit) {
                            tojson.setObject(usersByuserId);
                            tojson.setMsg("允许登陆OA用户达到上限，请联系管理员！");
                            tojson.setFlag(1);
                            return tojson;
                        }
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }

                if (usersByuserId != null && !usersByuserId.getUid().equals(user.getUid()) && usersByuserId.getByname().equals(user.getByname())) {
                    tojson.setObject(usersByuserId);
                    tojson.setMsg("此用户名已存在，请重新修改");
                    tojson.setFlag(1);
                    return tojson;
                }
            }*/

            //加密密码
            if (!StringUtils.checkNull(user.getPassword()) && !"tVHbkPWW57Hw.".equals(user.getPassword())) {
                Users byUid = usersMapper.getPassWordByUserId(usersByuserId.getUserId());
                if (byUid.getPassword() == null || !byUid.getPassword().equals(user.getPassword())) {
                    String password = user.getPassword();
                    password = getEncryptString(password.trim());
                    user.setPassword(password);
                }
            }
            // 判断生日是否为空 如果生日为空白字符 就设置为null
//            if(user.getBirthday() == null){
//                user.setBirthday(null);
//            }

            // 添加用户姓名索引
            if (user.getUserName() != null) {
                String fistSpell = PinYinUtil.getFirstSpell(user.getUserName());
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < fistSpell.length(); i++) {
                    sb.append(fistSpell.charAt(i) + "*");
                }
                user.setUserNameIndex(sb.toString());
            }

            // 设置用户的角色名称和序号
            if (user.getUserPriv() != null) {
                UserPriv userPriv = userPrivMapper.selectByPrimaryKey(user.getUserPriv());
                if (userPriv != null) {
                    user.setUserPrivNo(userPriv.getPrivNo());
                    user.setUserPrivName(userPriv.getPrivName());
                    // 设置权限
                    userFunction.setUserFunCidStr(userPriv.getFuncIdStr());

                }
            }
            if (!StringUtils.checkNull(user.getUserPrivOther())) {
                String[] strings = user.getUserPrivOther().split(",");
                StringBuffer privaNoBuffer = new StringBuffer();
                StringBuffer privaNameBuffer = new StringBuffer();
                StringBuffer funcIdStrBuffer = new StringBuffer();
                for (int i = 0; i < strings.length; i++) {
                    UserPriv userPriv = userPrivMapper.selectByPrimaryKey(Integer.parseInt(strings[i]));
                    if (userPriv != null) {
                        privaNoBuffer.append(userPriv.getUserPriv() + ",");
                        privaNameBuffer.append(userPriv.getPrivName() + ",");
                        if (userPriv.getFuncIdStr() != null) {
                            funcIdStrBuffer.append(userPriv.getFuncIdStr());
                        }
                    }
                }
                user.setUserPrivOther(String.valueOf(privaNoBuffer));
                user.setUserPrivOtherName(String.valueOf(privaNameBuffer));
                userFunction.setUserFunCidStr(userFunction.getUserFunCidStr() + String.valueOf(funcIdStrBuffer));

            }
        }
        try {
            if (user.getDeptId() != null && user.getDeptId().equals(0)) {
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            //查询一下之前数据库中是否存在头像
            Users f = usersMapper.SimplefindUserByuid(user.getUid());
            if (user.getAvatar() == null) {
                //判断之前存在数据库的图片是否为空，如果为空再重新为用户的头像赋为当前的性别图片
                if (f != null) {
                    if (f.getAvatar() == null) {
                        user.setAvatar(user.getSex());
                    }
                    //如果之前的头像为0跟1的话，也赋值为当前用户性别的图片
                    if (("0").equals(f.getAvatar()) || ("1").equals(f.getAvatar())) {
                        user.setAvatar(user.getSex());
                    }
                }
            } else {
                if (("0").equals(user.getAvatar()) || ("1").equals(user.getAvatar())) {
                    user.setAvatar(user.getSex());
                }
            }

            //旧的修改人事档案的代码，先注掉
//            HrStaffInfo hrStaffInfo =new HrStaffInfo();
//            hrStaffInfo.setBloodType(user.getBloodType());
            /*if (user.getDeptYj() == null) {
                user.setDeptYj("");
            }*/
            try {
                //lr 增加
                Users oldUser = usersMapper.getByUid(user.getUid());
                examineUser2(oldUser, user);
                // 查看是否修改部门 和辅助部门
                userDeptOrder(oldUser, user);
            } catch (Exception e) {
                e.printStackTrace();
            }

            //判断禁止登录用户是否可以修改登录信息
            if (usersByuserId.getNotLogin() == 1 || usersByuserId.getNotLogin() == 0) {
                Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                String realPath = request.getSession().getServletContext().getRealPath("/");
                Map<String, String> m = systemInfoService.getSystemInfo(realPath, locale, request);
                int oaUserLimit = 0;
                if ("不限制".equals(m.get("oaUserLimit"))) {
                    if(user.getDeptId() != null && user.getDeptId() == 0){
                        String[] uids = new String[1];
                        uids[0] = user.getUid().toString();
                        usersMapper.editUsersLeaveDept(uids);
                    }
                    usersMapper.editUser(user);
                    //解决手机端userExt为null
                    if (userExt != null) {
                        userExt.setUid(usersByuserId.getUid());
                        userExt.setUserId(usersByuserId.getUserId());
                        userExtMapper.updateUserExtByUid(userExt);
                    }
                    String departmentName;
                    if (user.getDeptId() != null) {
                        departmentName = departmentMapper.getDeptById(user.getDeptId()).getDeptName();
                    } else {
                        departmentName = usersMapper.getByUid(user.getUid()).getDeptName();
                    }
                    sysLog.setRemark("[" + departmentName + "]" + user.getUserName() + ",USER_ID=" + usersByuserId.getUserId());
                    sysLog.setTime(new Date(System.currentTimeMillis()));
                    syslogMapper.save(sysLog);
                    tojson.setFlag(0);
                } else {
                    //授权人数
                    oaUserLimit = Integer.parseInt(m.get("oaUserLimit"));
                    //允许登录用户数
                    int canLoginUser = this.getCanLoginUser();
                    if (canLoginUser >= oaUserLimit) {
                        //判断能不能修改成允许登录用户
                        user.setNotLogin(1);
                        if(user.getDeptId() != null && user.getDeptId() == 0){
                            String[] uids = new String[1];
                            uids[0] = user.getUid().toString();
                            usersMapper.editUsersLeaveDept(uids);
                        }
                        usersMapper.editUser(user);
                        //解决手机端userExt为null
                        if (userExt != null) {
                            userExt.setUid(usersByuserId.getUid());
                            userExt.setUserId(usersByuserId.getUserId());
                            userExtMapper.updateUserExtByUid(userExt);
                        }

                        String departmentName;
                        if (user.getDeptId() != null) {
                            departmentName = departmentMapper.getDeptById(user.getDeptId()).getDeptName();
                        } else {
                            departmentName = usersMapper.getByUid(user.getUid()).getDeptName();
                        }
                        sysLog.setRemark("[" + departmentName + "]" + user.getUserName() + ",USER_ID=" + usersByuserId.getUserId());
                        sysLog.setTime(new Date(System.currentTimeMillis()));
                        syslogMapper.save(sysLog);
                        tojson.setObject(usersByuserId);
                        tojson.setMsg("允许登陆OA用户达到上限，请联系管理员！");
                        tojson.setFlag(0);
                    } else {
                        if(user.getDeptId() != null && user.getDeptId() == 0){
                            String[] uids = new String[1];
                            uids[0] = user.getUid().toString();
                            usersMapper.editUsersLeaveDept(uids);
                        }
                        usersMapper.editUser(user);
                        //解决手机端userExt为null
                        if (userExt != null) {
                            userExt.setUid(usersByuserId.getUid());
                            userExt.setUserId(usersByuserId.getUserId());
                            userExtMapper.updateUserExtByUid(userExt);
                        }
                        String departmentName;
                        if (user.getDeptId() != null) {
                            departmentName = departmentMapper.getDeptById(user.getDeptId()).getDeptName();
                        } else {
                            departmentName = usersMapper.getByUid(user.getUid()).getDeptName();
                        }

                        sysLog.setRemark("[" + departmentName + "]" + user.getUserName() + ",USER_ID=" + usersByuserId.getUserId());
                        sysLog.setTime(new Date(System.currentTimeMillis()));
                        syslogMapper.save(sysLog);
                        tojson.setMsg("修改成功");
                        tojson.setFlag(0);
                    }
                }

            }

            //修改人事档案中对应的信息
            Users users1 = usersMapper.selectUserByUId(user.getUid());

            String loginId = user.getLoginId();
            user = usersMapper.selectUserByUId(user.getUid());



            //更新中间表中的数据
            user.setLoginId(loginId);
            editCAccountinfo(user);
            SysPara sysPara = sysParaMapper.querySysPara("OFUSERPWD");
            if (sysPara != null) {
                if (sysPara.getParaValue().equals("1")) {
                    UserExt2 userExt2 = new UserExt2();
                    userExt2.setUid(user.getUid());
                    if (pwd != null && !pwd.equals("")) {
                        userExt2.setPassword(pwd);
                    } else {
                        userExt2.setPassword("");
                    }
                    userExt2.setUserId(user.getUserId());
                    UserExt2 userext = userExt2Mapper.userExt2Info(userExt2);
                    if (userext != null) {
                        userExt2Mapper.editUserExt(userExt2);
                    } else {
                        userExt2Mapper.addUserExt(userExt2);
                    }
                }
            }
            if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                modulePriv = new ModulePriv();
                modulePriv.setUid(user.getUid());
                modulePriv.setModuleId(0);
                modulePriv.setDeptPriv(user.getPostPriv());
                modulePriv.setDeptId(user.getPostDept());
                // 查询判断是否存在白名单 如果存在就更新 如果不存在就保存
                ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);
                if (modulePrivByUid != null) {
                    //  if (!StringUtils.checkNull(modulePriv.getDeptId()) || !StringUtils.checkNull(modulePriv.getPrivId()) || !StringUtils.checkNull(modulePriv.getUserId())) {
                    modulePrivMapper.updateModulePriv(modulePriv);
                    //}
                } else {
                    modulePrivMapper.addModulePriv(modulePriv);
                }
            }
            if (userExt != null) {
                userExt.setUserId(user.getUserId());
                userExtMapper.updateUserExtByUid(userExt);
            }

            userFunction.setUid(user.getUid());
            userFunction.setUserId(user.getUserId());
            if (!StringUtils.checkNull(userFunction.getUserFunCidStr())) {
                TreeSet<String> ts = new TreeSet<>();
                int len1 = userFunction.getUserFunCidStr().split(",").length;
                String ss[] = userFunction.getUserFunCidStr().split(",");
                for (int i1 = 0; i1 < len1; i1++) {
                    ts.add(ss[i1] + "");
                }

                //2.循环遍历TreeSet
                Iterator<String> i1 = ts.iterator();
                StringBuilder sb1 = new StringBuilder();
                while (i1.hasNext()) {
                    sb1.append(i1.next() + ",");
                }
                userFunction.setUserFunCidStr(String.valueOf(sb1));
            }
            userFunctionMapper.updateUserFun(userFunction);


            user = usersMapper.findUserByuid(user.getUid());
            tojson.setObject(user);
            tojson.setFlag(0);
            tojson.setMsg("OK");
        } catch (Exception e) {
            e.printStackTrace();
            tojson.setFlag(1);
            tojson.setMsg("error");
        }
        return tojson;

    }

    public ToJson userDeptOrder(Users oldUser, Users newUser) {
        boolean updateDept = false;
        boolean updateDeptOher = false;
        ToJson json = new ToJson(1, "error");

        try {

            if ( newUser.getDeptId() == null || newUser.getUserNo() == null || newUser.getPostId() == null){
                return json;
            }

            // 查看是否修改了部门
            if (!oldUser.getDeptId().equals(newUser.getDeptId()) || !oldUser.getPostId().equals(newUser.getPostId()) || !oldUser.getUserNo().equals(newUser.getUserNo())) {
                updateDept = true;
            }

            //如果为空设置为空字符串，防止空指针导致不执行下面的代码
            oldUser.setDeptIdOther(oldUser.getDeptIdOther() == null ? "" : oldUser.getDeptIdOther());
            newUser.setDeptIdOther(newUser.getDeptIdOther() == null ? "" : newUser.getDeptIdOther());
            //查看是否修改了辅助部门
            if (!oldUser.getDeptIdOther().equals(newUser.getDeptIdOther()) || !oldUser.getPostId().equals(newUser.getPostId()) || !oldUser.getUserNo().equals(newUser.getUserNo())) {
                updateDeptOher = true;
            }

            if (updateDept) {
                List<UserDeptOrder> userDeptOrder = userDeptOrderMapper.selectUserAndDepts(oldUser.getUserId(), oldUser.getDeptId());
                if (userDeptOrder.size() > 1) {
                    userDeptOrderMapper.deleteByPrimaryKey(userDeptOrder.get(1).getOrderId());
                } else if (userDeptOrder.size() == 0) { //可能为升级脚本问题没有把用户同步过来
                    UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(oldUser.getUserId(), newUser.getDeptId());
                    if (userDeptOrder1 == null) {
                        UserDeptOrder Order = new UserDeptOrder();
                        Order.setDeptId(newUser.getDeptId());
                        Order.setUserId(oldUser.getUserId());
                        Order.setOrderNo(newUser.getUserNo());
                        Order.setPostId(newUser.getPostId());
                        userDeptOrderMapper.insertSelective(Order);
                    }
                }
                userDeptOrder.get(0).setDeptId(newUser.getDeptId());// 只更新主部门  考虑是否与辅助部门重复
                userDeptOrder.get(0).setPostId(newUser.getPostId());//2020/4/28 加上更新职务
                userDeptOrder.get(0).setOrderNo(newUser.getUserNo());//2020/4/28 加上更新排序号
                userDeptOrderMapper.updateByPrimaryKeySelective(userDeptOrder.get(0));
            }
            if (updateDeptOher) {
                List<UserDeptOrder> userDeptOrders = userDeptOrderMapper.selectUser(oldUser.getUserId());//查询当前人所有部门

                List<UserDeptOrder> userDeptOrder = userDeptOrderMapper.selectUserAndDepts(oldUser.getUserId(), newUser.getDeptId());//防止主部门 于 辅助部门重复
                if (userDeptOrder.size() > 1) {
                    userDeptOrderMapper.deleteByPrimaryKey(userDeptOrder.get(1).getOrderId());
                }


                Iterator<UserDeptOrder> its = userDeptOrders.iterator();
                if (userDeptOrder.size() > 0) {
                    while (its.hasNext()) {
                        UserDeptOrder x = its.next();
                        if (x.getDeptId().equals(userDeptOrder.get(0).getDeptId())) {
                            its.remove();
                        }
                    }
                }
                // 新辅助部门
                String[] split = newUser.getDeptIdOther().split(",");
                List<String> shan = Arrays.asList(split);
                List shanchu = new ArrayList(shan);
                /*Iterator<UserDeptOrder> its1 = userDeptOrders.iterator();
                while (its1.hasNext()) {
                    UserDeptOrder x = its1.next();
                    for (String s : split) {
                        if (x.getDeptId().equals(Integer.parseInt(s))) {
                            its1.remove();
                        }
                    }
                }*/
                Iterator<UserDeptOrder> remo = userDeptOrders.iterator();  //移除已有的部门
                while (remo.hasNext()) {
                    UserDeptOrder x = remo.next();
                    for (int i = 0; i < shanchu.size(); i++) {
                        if (!StringUtils.checkNull(shanchu.get(i).toString())) {
                            if (x.getDeptId().equals(Integer.parseInt(shanchu.get(i).toString()))) {
                                shanchu.remove(i);
                            }
                        }
                    }
                }

                for (UserDeptOrder userDeptOrder1 : userDeptOrders) {//没有移除完的，说明是需要删除的
                    userDeptOrderMapper.deleteByPrimaryKey(userDeptOrder1.getOrderId());
                }

                //然后进行更新或新增
                List<UserDeptOrder> userDeptOrders2 = userDeptOrderMapper.selectUser(oldUser.getUserId());//查询当前人所有部门
                UserDeptOrder userDeptOrder2 = userDeptOrderMapper.selectUserAndDept(oldUser.getUserId(), newUser.getDeptId());//查询主部门

                Iterator<UserDeptOrder> it = userDeptOrders2.iterator();  //移除主部门
                while (it.hasNext()) {
                    UserDeptOrder x = it.next();
                    if (x.getDeptId().equals(userDeptOrder2.getDeptId())) {
                        it.remove();
                    }
                }
                List<String> list = Arrays.asList(split);
                List arrList = new ArrayList(list);
                Iterator<UserDeptOrder> hou = userDeptOrders2.iterator();  //移除已有的部门
                while (hou.hasNext()) {
                    UserDeptOrder x = hou.next();
                    for (int i = 0; i < arrList.size(); i++) {
                        if (!StringUtils.checkNull(arrList.get(i).toString())) {
                            if (x.getDeptId().equals(Integer.parseInt(arrList.get(i).toString()))) {
                                arrList.remove(i);
                            }
                        }
                    }
                }
                if (arrList.size() > 0) {
                    for (int i = 0; i < arrList.size(); i++) {
                        if (!StringUtils.checkNull(arrList.get(i).toString())) {
                            UserDeptOrder Order = new UserDeptOrder();
                            Order.setDeptId(Integer.parseInt(arrList.get(i).toString()));
                            Order.setUserId(oldUser.getUserId());
                            Order.setOrderNo(newUser.getUserNo());
                            Order.setPostId(newUser.getPostId());
                            UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(oldUser.getUserId(), Integer.parseInt(arrList.get(i).toString()));
                            if (userDeptOrder1 == null) {
                                userDeptOrderMapper.insertSelective(Order);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    //先查看用户修改了什么
    //TODO  lr 此处待完善，为尽快解决建始问题，先启用下面的examineUser2方法
    public void examineUser(Users oldUser, Users newUser) {
        //有3种情况，分别修改了部门，修改了角色，修改了部门和角色。
        boolean updateDept = false;
        boolean updatePriv = false;
        //查看是否修改了角色
        if (!oldUser.getUserPriv().equals(newUser.getUserPriv())) {
            updatePriv = true;
        }
        if (!oldUser.getDeptId().equals(newUser.getDeptId())) {
            updateDept = true;
        }
        Map map = new HashMap();
        String date = DateFormat.getDatestr(new Date());
        map.put("date", date);
        map.put("status", "1");
        //one 第一种，用户同时修改了角色和部门，此时只需要检索当前用户有没有启动的排班。
        if (updateDept && updatePriv) {
            map.put("userId", newUser.getUserId());


            List<AttendScheduleWithBLOBs> attendScheduleListUser = attendScheduleMapper.getAttendScheduleByMap(map);

        }
        //two 第二种，用户只修改了部门
        else if (updateDept) {

        }
        //three 第三种，用户只修改了角色
        else if (updatePriv) {

        }
    }


    //TODO lr 如果用户修改了部门，并且修改后部门无任何排班数据，判断此用户在当前时间之后是否有启动的排班，如果有。不删除排班
    public void examineUser2(Users oldUser, Users newUser) {
        //有3种情况，分别修改了部门，修改了角色，修改了部门和角色。
        boolean updateDept = false;
        boolean updatePriv = false;
        //查看是否修改了角色
        if (!oldUser.getUserPriv().equals(newUser.getUserPriv())) {
            updatePriv = true;
        }
        //查看是否修改了部门
        if (!oldUser.getDeptId().equals(newUser.getDeptId())) {
            updateDept = true;
        }
        String date = DateFormat.getDatestr(new Date());
        Map<String, Object> map = new HashMap<>();
        map.put("status", "1");
        map.put("date", date);
        //如果修改了部门
        if (updateDept) {
            //查看改后的部门是否是没有排班的
            map.put("deptId", newUser.getDeptId());
            List<AttendScheduleWithBLOBs> attendScheduleList = attendScheduleMapper.getAttendScheduleByMap(map);
            if (attendScheduleList == null || attendScheduleList.size() == 0) {
                //如果此部门没有排班信息
                //查看是否根据用户设置了排班
                Map<String, Object> mapUser = new HashMap<>();
                mapUser.put("status", "1");
                mapUser.put("date", date);
                mapUser.put("userId", oldUser.getUserId());
                List<AttendScheduleWithBLOBs> attendScheduleListUser = attendScheduleMapper.getAttendScheduleByMap(mapUser);
                if (attendScheduleListUser == null || attendScheduleListUser.size() == 0) {
                    //此时代表当前用户在今天之后并没有根据用户进行排班
                    //进而查看用户的角色是否发生改变。如果改变，则直接将用户今天之后的排班删除
                    if (updatePriv) {
                        Map<String, Object> deleteMap = new HashMap<>();
                        deleteMap.put("uid", oldUser.getUid());
                        deleteMap.put("date", date);
                        userDutyMapper.deleteDutyByMap(deleteMap);
                    } else {
                        //如果没变的话，查看角色是否有结束日期是今天之后的排班。没有的话允许删除，有的话不做处理
                        Map<String, Object> mapPriv = new HashMap<>();
                        mapPriv.put("status", "1");
                        mapPriv.put("date", date);
                        mapPriv.put("privId", oldUser.getUserPriv());
                        List<AttendScheduleWithBLOBs> attendScheduleListPriv = attendScheduleMapper.getAttendScheduleByMap(mapPriv);
                        if (attendScheduleListPriv == null || attendScheduleListPriv.size() == 0) {
                            //没有，可以删除
                            Map<String, Object> deleteMap = new HashMap<>();
                            deleteMap.put("uid", oldUser.getUid());
                            deleteMap.put("date", date);
                            userDutyMapper.deleteDutyByMap(deleteMap);
                        }
                    }

                }
            }
        }


    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午5:44:51
     * 方法介绍:   删除用户
     * 参数说明:   @param uid 用户uid
     *
     * @return void   无
     */
    @Override
    public void deleteUser(String uids, HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users use = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

        //查询是否开启三员管理，开启后只有保密员可以删除用户
        SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
        if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
            //判断是否是保密员
            Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
            if(!sysSecurityUser.getUserId().equals(use.getUserId())){
                return;
            }
        }
        Integer index = null;
        String[] split = uids.split(",");
        Users us = new Users();
        StringBuffer userName = new StringBuffer();
        for (int i = 0; i < split.length; i++) {
            us = usersMapper.getUserByUid(Integer.valueOf(split[i]));
            userName.append(us.getDeptName()).append(",");
            if (split[i].equals("1")) {
                index = i;
            }
        }
        if (index != null) {
            split[index] = "a";
        }

        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(use.getUserId() + "");
        sysLog.setType(8);
        sysLog.setTypeName("删除用户");
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

        //删除中间表中的数据
        try {
            String loginId = "1001";
            if (request != null) {
                loginId = (String) request.getSession().getAttribute(
                        "loginDateSouse");
            }

            List<Users> list = usersMapper.getUserByUids(split, null);
            ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
            List<OrgManage> obj = zh_cn.getObj();
            int size = obj.size();
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = props.getProperty("url" + obj.get(0).getOid());
            String driver = props.getProperty("driverClassName");
            String username = props.getProperty("uname" + obj.get(0).getOid());
            String password = props.getProperty("password" + obj.get(0).getOid());
            Class.forName(driver).newInstance();
            Connection conn = DriverManager.getConnection(url, username, password);
            Statement st = conn.createStatement();
            for (Users users : list) {
                boolean isExistPara_1 = Verification.CheckIsExistCAccountinfo(conn, driver, url, username, password, loginId + "_" + users.getUserId());
                if (isExistPara_1) {
                    String sql = "delete from c_accountinfo where user_id='" + loginId + "_" + users.getUserId() + "'";
                    st.executeUpdate(sql);//执行SQL语句
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            List<Users> users = usersMapper.findUserNames(split);
            StringBuffer name = new StringBuffer();
            for (Users users1 : users) {
                name.append(users1.getUserName()).append(",");
                userDeptOrderMapper.deleteUser(users1.getUserId());//删除人员部门排序表
            }
            usersMapper.deleteUser(split);
            userExtMapper.deleteUserExtByUids(split);
            modulePrivMapper.deleteModulePrivByUids(split);
            userFunctionMapper.deleteUserFun(split);
            sysLog.setRemark("[" + userName.toString() + "]" + name.toString() + "UID=" + uids);
            //记录删除原因和线下审批单的附件
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
                String attachmentId = request.getParameter("attachmentId");
                String attachmentName = request.getParameter("attachmentName");
                String operationReason = request.getParameter("operationReason");
                sysLog.setRemark("删除用户：[" + name + "]" + name + "UID=" + uids +
                        "，删除原因：" + operationReason + "，附件ID：" + attachmentId + "，附件名称：" + attachmentName);
            }
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午4:46:36
     * 方法介绍:   获取所有用户
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<Users>  返回用户信息集合
     */
    @Override
    public List<Users> getAlluser(Map<String, Object> maps, Integer page,
                                  Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        return usersMapper.getAlluser(maps);
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午4:46:36
     * 方法介绍:   获取所有用户
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<Users>  返回用户信息集合
     */
    @Override
    public List<Users> getAllPrivOther(Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        return usersMapper.getAllPrivOther(maps);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午4:46:52
     * 方法介绍:   多条件查询
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return List<Users>  返回用户信息
     */
    @Override
    public List<Users> getUserByMany(Users user) {
        List<Users> list = usersMapper.getUserByMany(user);
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午4:18:08
     * 方法介绍:   获取用户信息和部门信息
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag   是否开启分页
     * 参数说明:   @return
     *
     * @return List<Users>   返回用户信息
     */
    @Override
    public List<Users> getUserAndDept(Map<String, Object> maps, Integer page,
                                      Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        return usersMapper.getUserAndDept(maps);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午5:01:06
     * 方法介绍:   格局uid获取用户信息
     * 参数说明:   @param uid  用户uid
     * 参数说明:   @return
     *
     * @return Users   返回用户信息
     */
    @Override
    public Users findUserByuid(int uid) {
        //pc端手机端不知道都去取什么字段。
        Users user = usersMapper.findUserByuid(uid);
        if (user != null) {
            StringBuffer sb = new StringBuffer();
            // 查询辅助角色名称信息
            if (!StringUtils.checkNull(user.getUserPrivOther())) {
                List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(user.getUserPrivOther().split(","));
                if (privNameByIds != null) {
                    for (int i = 0; i < privNameByIds.size(); i++) {
                        if (i == (privNameByIds.size() - 1)) {
                            sb.append(privNameByIds.get(i).getPrivName());
                        } else {
                            sb.append(privNameByIds.get(i).getPrivName() + ",");
                        }
                    }
                    user.setUserPrivOtherName(sb.toString());
                }
                sb.setLength(0);
            }
            // 查询其他部门名称信息
            if (!StringUtils.checkNull(user.getDeptIdOther())) {
                List<Department> deptNameByIds = modulePrivMapper.getDeptNameByIds(user.getDeptIdOther().split(","));
                if (deptNameByIds != null) {
                    for (Department entity : deptNameByIds) {
                        sb.append(entity.getDeptName() + ",");
                    }
                    user.setDeptOtherName(sb.toString());
                }
                sb.setLength(0);
            }

            if (user.getPostId() != null && user.getPostId() != 0) {
                if (managementMapper.getUserPostId(user.getPostId()) != null) {
                    String postName = managementMapper.getUserPostId(user.getPostId()).getPostName();
                    user.setPostName(postName);
                } else {
                    user.setPostName("");
                }

            }
            ModulePriv modulePriv = new ModulePriv();
            modulePriv.setModuleId(0);
            modulePriv.setUid(uid);
            modulePriv = modulePrivMapper.getModulePrivSingle(modulePriv);
            // 查询获取白名单名称数据
            if (modulePriv != null) {
                user.setModulePriv(modulePriv);
                if (!StringUtils.checkNull(modulePriv.getUserId())) {
                    List<Users> usersByUids = usersMapper.getUsersByUids(modulePriv.getUserId().split(","));
                    if (usersByUids != null) {
                        for (Users entity : usersByUids) {
                            sb.append(entity.getUserName() + ",");
                        }
                        modulePriv.setUserName(sb.toString());
                    }
                    sb.setLength(0);
                }
                if (!StringUtils.checkNull(modulePriv.getPrivId())) {
                    List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(modulePriv.getPrivId().split(","));
                    if (privNameByIds != null) {
                        for (UserPriv entity : privNameByIds) {
                            sb.append(entity.getPrivName() + ",");
                        }
                        modulePriv.setPrivName(sb.toString());
                    }
                    sb.setLength(0);
                }
                if (!StringUtils.checkNull(modulePriv.getDeptId())) {
                    List<Department> deptNameByIds = modulePrivMapper.getDeptNameByIds(modulePriv.getDeptId().split(","));
                    if (deptNameByIds != null) {
                        for (Department entity : deptNameByIds) {
                            sb.append(entity.getDeptName() + ",");
                        }
                        modulePriv.setDeptName(sb.toString());
                    }
                    sb.setLength(0);
                }

            }

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

            //hwx 2019-12-25查询岗位，移动端需要
            if (user.getJobId() != null && user.getJobId() != 0) {
                UserJob userJob = positionManagementMapper.getUserjobId(user.getJobId());
                user.setJobName(userJob != null ? userJob.getJobName() : "");
            }

            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                //判断用户是否属于涉密系统管理员
                user.setSecrecyAdm(securityApprovalService.checkIsSecrecyAdm(user));
            }

        }

        return user;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 上午9:48:51
     * 方法介绍:   根据别名获取用户信息
     * 参数说明:   @param byname  用户别名
     * 参数说明:   @return
     *
     * @return Users  返回用户
     */
    @Override
    public Users findUserByName(String byname, HttpServletRequest req) {
        Users user = usersMapper.findUserByName(byname);
        if (user != null) {
            UnitManage nitManage = unitManageMapper.showUnitManage();
            user.setCompanyName(nitManage.getUnitName());
            if (user.getDeptId() != null) {
                Department dep = departmentMapper.getDeptById(user.getDeptId());
                if (dep != null) {
                    user.setDeptName(dep.getDeptName());

                }
            }

            String ip = "";
            SysPara sysParaHost = sysParaMapper.querySysPara("IM_HOST");
            //根据商量先获取数据库IM_STUTES的字段是1则返回手动配置的IP地址 是0的情况下让手机端自己获取ip和端口,返回为空
            SysPara sysParaStutes = sysParaMapper.querySysPara("IM_STUTES");
            SysPara sysParaPort = sysParaMapper.querySysPara("IM_PORT");

            if (sysParaStutes != null && !StringUtils.checkNull(sysParaStutes.getParaValue()).booleanValue()) {
                if (one.equals(sysParaStutes.getParaValue())) {
                    user.setGimPort(sysParaPort.getParaValue());
                    user.setGimHost(sysParaHost.getParaValue());
                    user.setImRegisterIp(sysParaHost.getParaValue());
                } else {
                    user.setGimPort("");
                    user.setGimHost("");
                    user.setImRegisterIp("");
                }

            }

        }


        return user;
    }

    /**
     * 创建作者：季佳伟
     * 方法介绍：根据别名查询用户所有信息
     *
     * @param
     * @param
     * @return
     */
    @Override
    public Users selectUserAllInfoByName(String byname, HttpServletRequest req, String loginId, String userPassword, Integer h5Login, String thirdPartyType) {

        //判断是否开启允许使用用户ID登录
        SysPara sysPara = sysParaMapper.querySysPara("USERID_LOGIN_SET");
        Users user = null;
        if(!Objects.isNull(sysPara) && "0".equals(sysPara.getParaValue())){
            user = usersMapper.selectUserAllInfoByName(byname);
        }else {
            user = usersMapper.selectUserAllInfoByNameAndUserId(byname);
        }
        if (user != null) {
            Boolean isPassWordRight = false;
            SysPara selectLoginSecureKey = sysParaMapper.getSelectLoginSecureKey();
            Users userKeyNo = usersMapper.importUserByName(byname);
            if (selectLoginSecureKey.getParaValue().equals("1") && (!userKeyNo.getSecureKeySn().equals(""))) {
                isPassWordRight = verificationPassword(user.getByname(), userPassword);
            } else {
                //开启了域登录验证，并且userMap中存在用户映射，走域验证，否则执行OA正常验证
                isPassWordRight = checkPassWordUser(user.getByname(), user.getPassword(), userPassword);

            }

            //增加职务和岗位
            Integer postId = user.getPostId();
            if (postId != null) {
                UserPost userPost = dutiesManagementMapper.getUserPostId(postId);
                if (userPost != null) {
                    user.setPostName(userPost.getPostName());
                }
            }
            Integer jobId = user.getJobId();
            if (jobId != null) {
                UserJob userJob = positionManagementMapper.getUserjobId(jobId);
                if (userJob != null) {
                    user.setJobName(userJob.getJobName());
                }
            }
            //如果是蓝信登录，密码设置为正确
           /* if (null != h5Login && h5Login == 1) {
                isPassWordRight = true;
            }*/
            // 判断是否是企业微信或者钉钉登陆 直接设置为true
            // 企业微信
            if (!StringUtils.checkNull(thirdPartyType) && thirdPartyType.equals("1")) {
                UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByUserId(user.getUserId());
                if (userWeixinqy != null && !StringUtils.checkNull(userWeixinqy.getOpenId())) {
                    isPassWordRight = true;
                }
            }
            // 钉钉
            if (!StringUtils.checkNull(thirdPartyType) && thirdPartyType.equals("2")) {
                UserDDMap userDDMap = userDDMapMapper.selUserByOpenId(user.getUserId());
                if (userDDMap != null && !StringUtils.checkNull(userDDMap.getOaUid())) {
                    isPassWordRight = true;
                }
            }

            //万州app登录参数
            if (!StringUtils.checkNull(thirdPartyType) && thirdPartyType.equals("3")) {
                AppOaUser appOaUser = appOaUserMapper.selUserByOpenId(user.getUserId());
                if (appOaUser != null && !StringUtils.checkNull(appOaUser.getUserId())) {
                    isPassWordRight = true;
                }
            }

            if (isPassWordRight) {
                user.setIsPassWordRight("ok");
            } else {
                user.setIsPassWordRight("err");
                return user;
            }

            //多组织公司名称 ，不能调用已经注释的，里面只有一个公司,读取公司名称时要切库切到1001，切换之后要切到选择的库

            /* UnitManage nitManage = unitManageMapper.showUnitManage();*/
            OrgManage orgManageById = null;
            if (!StringUtils.checkNull(loginId)) {
                ContextHolder.setConsumerType("xoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(loginId));
            }
            //没有传的默认为1001
            else {
                ContextHolder.setConsumerType("xoaxoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(1001));
            }
            user.setCompanyName(orgManageById == null ? "" : orgManageById.getName());
            //查询公司名称后要切回来
            ContextHolder.setConsumerType("xoa" + loginId);
            if (user.getDeptId() != null) {
                Department dep = departmentMapper.getDeptById(user.getDeptId());
                if (dep != null) {
                    user.setDeptName(dep.getDeptName());
                }
            }

            Syslog sysLog = new Syslog();
            sysLog.setLogId(0);
            sysLog.setUserId(user.getUserId());
            SysPara sysParaHost = sysParaMapper.querySysPara("IM_HOST");
            //根据商量先获取数据库IM_STUTES的字段是1则返回手动配置的IP地址 是0的情况下让手机端自己获取ip和端口,返回为空
            SysPara sysParaStutes = sysParaMapper.querySysPara("IM_STUTES");
            SysPara sysParaPort = sysParaMapper.querySysPara("IM_PORT");

            if (sysParaStutes != null && !StringUtils.checkNull(sysParaStutes.getParaValue()).booleanValue()) {
                if (one.equals(sysParaStutes.getParaValue())) {
                    user.setGimPort(sysParaPort.getParaValue());
                    user.setGimHost(sysParaHost.getParaValue());
                    user.setImRegisterIp(sysParaHost.getParaValue());
                } else {
                    user.setGimPort("");
                    user.setGimHost("");
                    user.setImRegisterIp("");
                }

            }

            //判断生日
            if ( user.getBirthday() == null && ( !StringUtils.checkNull(user.getIdNumber()) && user.getIdNumber().length() == 18 ) ){
                String y = user.getIdNumber().substring(6, 10);
                String m = user.getIdNumber().substring(10, 12);
                String d = user.getIdNumber().substring(12, 14);
                user.setBirthday(DateFormat.getDates(y + "-" + m + "-" + d ));
            }

            sysLog.setTime(new Date());
            sysLog.setIp(IpAddr.getIpAddress(req));
            sysLog.setType(1);
            String userAgent = req.getParameter("userAgent");
            String clientVersion = req.getParameter("clientVersion");
            if ("iOS".equals(userAgent)) {
                sysLog.setRemark("iOS端" + "(" + req.getParameter("pdd") + ")");
                //添加客户端类型
                sysLog.setClientType(3);
                //SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                sysLog.setClientVersion(clientVersion);
            } else if ("android".equals(userAgent)) {
                sysLog.setRemark("安卓端" + "(" + req.getParameter("pdd") + ")");
                sysLog.setClientType(4);
                //SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                sysLog.setClientVersion(clientVersion);
            } else if ("pc".equals(userAgent)) {
                sysLog.setRemark("PC端");
                sysLog.setClientType(2);
                //SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setRemark("网页端" + "(" + req.getHeader("user-agent") + ")");
                sysLog.setClientType(1);
                if (clientVersion != null && clientVersion.length() > 0) {
                    sysLog.setClientVersion(clientVersion);
                } else {
                    sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
                }
            }
            //添加完字段的
            syslogMapper.save2(sysLog);
        }

        if (user != null) {
            user.setPassword("");
            user.setIdNumber("");
        }
        return user;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 上午10:27:07
     * 方法介绍:   根据输入条件进行查询
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<Users>   返回用户信息
     */
    @Override
    public List<Users> getBySearch(Map<String, Object> maps) {
        return usersMapper.getBySearch(maps);
    }

    /**
     * 根据部门ID查询部门下所有人员
     * 王禹萌
     * 2018-07-25 11：15
     *
     * @param maps
     * @param page
     * @param pageSize
     * @param useFlag
     * @return
     */
    @Override
    public List<Users> getAllByDeptId(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        //先查询该部门的deptNo
        String deptNo = departmentMapper.getAllByDeptId(maps);
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("deptNo", deptNo);
        List<Users> users = usersMapper.getAllByDeptId(maps);
        for (Users entity : users) {
            if ("tVHbkPWW57Hw.".equals(entity.getPassword())) {
                entity.setPassword("");
            }

            if (entity.getLastVisitTime() != null) {
                // 获取闲置时间
                long times = System.currentTimeMillis() - entity.getLastVisitTime().getTime();
                long day = times / (24 * 60 * 60 * 1000);
                long hour = (times / (60 * 60 * 1000) - day * 24);
                long min = ((times / (60 * 1000)) - day * 24 * 60 - hour * 60);

                StringBuffer sb = new StringBuffer();
                if (day > 0) {
                    sb.append(day + "天");
                }
                if (hour > 0) {
                    sb.append(hour + "小时");
                }
                if (min > 0) {
                    sb.append(min + "分");
                }
                entity.setIdleTime(sb.toString());
            } else {
                entity.setIdleTime("未曾登陆");
            }
            if (entity.getDeptId() == 0) {
                entity.setDeptName("离职或外部人员");
            }
        }
        return users;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 上午11:00:05
     * 方法介绍:   根据部门id查询用户信息
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return List<Users>  返回用户信息
     */
    @Override
    public List<Users> getByDeptId(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        List<Users> users = usersMapper.getByDeptId(maps);
        for (Users entity : users) {
            if ("tVHbkPWW57Hw.".equals(entity.getPassword())) {
                entity.setPassword("");
            }

            if (entity.getLastVisitTime() != null) {
                // 获取闲置时间
                long times = System.currentTimeMillis() - entity.getLastVisitTime().getTime();
                long day = times / (24 * 60 * 60 * 1000);
                long hour = (times / (60 * 60 * 1000) - day * 24);
                long min = ((times / (60 * 1000)) - day * 24 * 60 - hour * 60);

                StringBuffer sb = new StringBuffer();
                if (day > 0) {
                    sb.append(day + "天");
                }
                if (hour > 0) {
                    sb.append(hour + "小时");
                }
                if (min > 0) {
                    sb.append(min + "分");
                }
                entity.setIdleTime(sb.toString());
            } else {
                entity.setIdleTime("未曾登陆");
            }
            if (entity.getDeptId() == 0) {
                entity.setDeptName("离职或外部人员");
            }
        }
        return users;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 上午11:00:05
     * 方法介绍:   根据uid查询用户姓名、部门、角色信息
     * 参数说明:   @param uid  用户uid
     * 参数说明:   @return
     *
     * @return Users  返回用户信息
     */
    @Override
    public Users getByUid(int uid) {
        Users users = usersMapper.getByUid(uid);
        return users;
    }

    @Override
    public List<Users> getAllByUid(String uids) {
        if (StringUtils.checkNull(uids)) {
            return new ArrayList<Users>();
        }
        String[] s = uids.split(",");
        List<Users> list = new ArrayList<Users>();
        for (int i = 0; i < s.length; i++) {
            Users users = usersMapper.getByUid(Integer.parseInt(s[i]));
            list.add(users);
        }
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午5:20:05
     * 方法介绍:   根据userId串获取用户姓名
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<String>  返回用户姓名串
     */
    @Override
    public String getUserNameById(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();
        if (",".equals(String.valueOf(userIds.charAt(userIds.length() - 1)))) {
            userIds = userIds.substring(0, userIds.length() - 1);
        }
        String temp[] = userIds.split(",");
        if (temp.length <= 0) {
            return null;
        }
        List<String> userNames = usersMapper.getAllNameByUserId(temp);
        int length = userNames.size();
        for (int i = 0; i < length; i++) {
            if (i < length - 1) {
                sb.append(userNames.get(i)).append(",");
            } else {
                sb.append(userNames.get(i));
            }
        }
        return sb.toString();
    }


    @Override
    public String getUserPrivById(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();

        String[] temp = userIds.split(",");
        List<String> userPrivNames = usersMapper.getAllUPNameByUserId(temp);
        int length = userPrivNames.size();
        for (int i = 0; i < length; i++) {
            if (i < length - 1) {
                sb.append(userPrivNames.get(i)).append(",");
            } else {
                sb.append(userPrivNames.get(i));
            }
        }



        /*String[] temp = userIds.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                Users users = usersMapper.findUsersByuserId(temp[i]);
                if(users!=null){
                if (!StringUtils.checkNull(String.valueOf(users.getUserPrivName()))) {
                    if (i < temp.length - 1) {
                        sb.append(String.valueOf(users.getUserPrivName())).append(",");
                    } else {
                        sb.append(String.valueOf(users.getUserPrivName()));
                    }
                }
            }
            }
        }*/
        return sb.toString();
    }


    @SuppressWarnings("all")
    @Override
    public String getUserNameById(String userIds, String flag) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接用户名称的字符串
        StringBuffer sb = new StringBuffer();
        String[] temp = userIds.split(flag);
        if (temp.length <= 0) {
            return null;
        }
        List<Users> usersByUserIds = usersMapper.getUsersByUserIdsOrder(temp);

        for (int i = 0, length = usersByUserIds.size(); i < length; i++) {
            String userName = usersByUserIds.get(i).getUserName();
            if (i < temp.length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }

        return sb.toString();
    }

    @SuppressWarnings("all")
    @Override
    public String getAllDeptIdsByUserId(String userIds, String flag) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接部门ID的字符串
        StringBuffer sb = new StringBuffer();
        String[] temp = userIds.split(flag);

        List<Users> usersDeptIdsByUserIds = usersMapper.getAllDeptIdsByUserId(temp);

        for (int i = 0, length = usersDeptIdsByUserIds.size(); i < length; i++) {
            Integer userName = usersDeptIdsByUserIds.get(i).getDeptId();
            if (i < temp.length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }

        return sb.toString();
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午5:20:05
     * 方法介绍:   根据uId串获取用户姓名
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return String  返回用户姓名串
     */
    @Override
    public String findUsersByuid(int... uid) {
        if (uid == null) {
            return null;
        }
        //定义用于拼接用户姓名的字符串
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < uid.length; i++) {
            if (uid.length == 1) {
                String userName = usersMapper.getUsernameById(uid[i]);
                return userName;
            } else {
                String userName = usersMapper.getUsernameById(uid[i]);
                if (i < uid.length - 1) {
                    sb.append(userName).append(",");
                } else {
                    sb.append(userName);
                }
            }
        }
        return sb.toString();
    }

    @Override
    public String findUsersByuid(String uids) {
        if (StringUtils.checkNull(uids)) {
            return null;
        }
        if (",".equals(String.valueOf(uids.charAt(uids.length()-1)))){
            uids = uids.substring(0,uids.length()-1);
        }

        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();

        List<Users> usersByUserIds = usersMapper.getUsersByUidsOrder(uids);
        for (int i = 0, length = usersByUserIds.size(); i < length; i++) {
            String userName = usersByUserIds.get(i).getUserName();
            if (i < length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }
        return sb.toString();
    }

    @Override
    public String findUsersByuidReturn(String uids) {
        if (StringUtils.checkNull(uids)) {
            return "";
        }
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();
        List<Users> usersByUserIds = usersMapper.getUsersByUidsOrder(uids);
        for (int i = 0, length = usersByUserIds.size(); i < length; i++) {
            String userName = usersByUserIds.get(i).getUserName();
            if (i < length - 1) {
                sb.append(userName).append(",");
            } else {
                sb.append(userName);
            }
        }
        return sb.toString();
    }

    @Override
    public Users findUsersByuserId(String userId) {
        Users users = usersMapper.findUsersByuserId(userId);
        if(users!=null){
            if (users != null) {
                if (users.getPostId() != null && users.getPostId() != 0) {
                    String postName = managementMapper.getUserPostId(users.getPostId()) == null ? "" : managementMapper.getUserPostId(users.getPostId()).getPostName();
                    users.setPostName(postName);
                }
                //判断用户头像
                if (StringUtils.checkNull(users.getAvatar())) {
                    if (!StringUtils.checkNull(users.getSex())) {
                        users.setAvatar(users.getSex());
                    } else {
                        users.setAvatar("0");
                    }

                } else {
                    if (users.getAvatar().equals("0") || users.getAvatar().equals("1")) {
                        if (!StringUtils.checkNull(users.getSex())) {
                            users.setAvatar(users.getSex());
                        } else {
                            users.setAvatar("0");
                        }
                    } else {
                        //判断用户头像是否找得到
                        String classpath = this.getClass().getResource("/").getPath();
                        String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/img/user/");
                        File file_avtor = new File(webappRoot + users.getAvatar());
                        if (!file_avtor.exists()) {
                            users.setAvatar(users.getSex());
                        }
                    }
                }

            }

            Department department = departmentService.getFatherDept(users.getDeptId());
            if(department!=null){
                users.setParentDeptName(department.getDeptName());
            }
        }else {
            users=new Users();
            users.setUserName("发件人不存在");
        }
        return users;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 9:40
     * @函数介绍: 根据User的角色或部门id, 查询用户，其他条件可在serverce层扩展 【已修改，现在查询结果不包括禁止登录用户】
     * @参数说明: @param Users
     * @return: List<Users></Users>
     */
    @Override
    public List<Users> getUsersByCondition(Users users) {
        List<Users> usersList = new ArrayList<Users>();


        String sysPara = null;
        try {
            sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
        } catch (Exception e) {

        }


        if (users != null && users.getDeptId() != null) {//根据用户部门id查询
            //  usersList = usersMapper.getUsersByDeptId(users);
            usersList = usersMapper.getUsersByDeptId(users.getDeptId());
        } else if (users != null && users.getUserPriv() != null) {
            usersList = usersMapper.getUserByRoleId(users);
        }

        //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
        securityApprovalService.removeSecrecyUsers(usersList,null);

        return usersList;
    }


    /**
     * 作者: 张航宁
     * 日期: 2018/7/27
     * 说明: 根据User的角色或部门id, 查询用户 用于用户管理模块树结构遍历 查询所有用户
     */
    @Override
    public List<Users> getUserByConditionExt(Integer deptId, Integer userPriv) {
        List<Users> usersList = new ArrayList<Users>();

        //根据用户部门id查询
        if (deptId != null) {
            usersList = usersMapper.getUsersByDeptId(deptId);

            // 人员部门排序
            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            } catch (Exception e) {

            }
            try {
                if ("1".equals(order)) {
                    for (Users users1 : usersList) {
                        if (!StringUtils.checkNull(users1.getUserId()) && null != deptId) {
                            //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), deptId).getOrderNo());
                            //规避没有这个排序的用户会报错给一个默认排序10
                            UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), deptId);
                            Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                            users1.setUserDeptNo(userDeptNo);
                        }
                    }
                    Collections.sort(usersList, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        } else if (userPriv != null) {
            usersList = usersMapper.getUsersByUserPriv(String.valueOf(userPriv));
        }

        //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
        securityApprovalService.removeSecrecyUsers(usersList,null);

        return usersList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 11:10
     * @函数介绍: 查询在线用户
     * @参数说明: @param paramname paramintroduce
     * @return: List<User></User>
     **/
    @Override
    public List<Users> getUsersOnline() {

        return usersMapper.getUserOnline();
    }

    @Override
    public List<Users> getUserbyCondition(Map<String, Object> maps) {
        List<Users> usersList = usersMapper.getUserbyCondition(maps);
        StringBuffer s2 = new StringBuffer();
        for (Users users : usersList) {
            if (users.getMobilNo()==null){
                users.setMobilNo("");
            }
            if (users.getEmail()==null){
                users.setEmail("");
            }
            users.setDepartmentPhone(users.getDep().getTelNo());
            if (users.getUserPrivOther() != null && !users.getUserPrivOther().equals("")) {
                String userOther = users.getUserPrivOther();
                String[] strArray2 = userOther.split(",");
                for (int i = 0; i < strArray2.length; i++) {
                    String name3 = usersPrivService.getPrivNameById(Integer.parseInt(strArray2[i]));
                    if (name3 != null) {
                        s2.append(name3);
                        s2.append(",");
                        users.setRoleAuxiliaryName(s2.toString());
                    }
                }

            }

        }
        return usersList;
    }

    @Override
    @Transactional
    public ToJson<Users> edit(Users user) {
        ToJson<Users> tojson = new ToJson<Users>();
        try {
            usersMapper.editUser(user);
            tojson.setFlag(0);
            tojson.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            tojson.setFlag(1);
            tojson.setMsg("false");
        }
        return tojson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/6 21:15
     * @函数介绍: 验证密码是否正确, 为了保证兼容php的加密，发现php项目的MD5加密,加的盐是密文。
     * 比如，密码123，在数据库里的加密是XX,那么加的盐就是XX
     * @参数说明: @param userName 用户名
     * @参数说明: @param password 密码
     * @return: Boolean 密码是否正确
     */
    @Override
    public Boolean checkPassWord(String userName, String password) {
        //开发阶段，admin登录，不用输密码，所有特殊考虑
        if ("".equals(password.trim())) {
            List<Users> usersList = usersMapper.checkPassWord(userName);

            if (usersList != null && usersList.size() > 0) {

                //如果密码为空，
                if ("tVHbkPWW57Hw.".equals(usersList.get(0).getPassword())) {
                    return true;
                }
            }

        }

        if (userName != null && password != null) {

            List<Users> usersList = usersMapper.checkPassWord(userName);

            if (usersList != null && usersList.size() > 0) {

                for (Users users : usersList) {
                    String truePassword1 = users.getPassword();
                    try {
                        String md5Password = MD5Utils.md5Crypt(password.getBytes(), truePassword1);
                        if (md5Password != null && md5Password.equals(truePassword1)) {
                            return true;
                        }
                    } catch (Exception e) {
                        return false;
                    }


                }
            }
        }
        return false;
    }


    /**
     * 动态密码验证
     *
     * @param userName
     * @param password
     * @return
     */
    @Override
    public Boolean verificationPassword(String userName, String password) {
        return false;
    }


    @Override
    public Boolean checkPassWordUser(String userName, String password, String userPassword) {
        //开发阶段，admin登录，不用输密码，所有特殊考虑
        if ("".equals(userPassword.trim())) {
            //如果密码为空，
            if ("tVHbkPWW57Hw.".equals(password)) {
                return true;
            }
        }
        if (userName != null && password != null) {
            try {
                String md5Password = MD5Utils.md5Crypt(userPassword.trim().getBytes(), password);
                if (md5Password != null && md5Password.equals(password)) {
                    return true;
                }
            } catch (Exception e) {
                return false;
            }
        }
        return false;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/7 10:47
     * @函数介绍: 加密一个字符串，MD5加密，EncryptSalt类产生一个字符串作为加盐加密
     * 注意业务需要，空字符串要得到固定的加密结果（tVHbkPWW57Hw.）
     * @参数说明: @param String 要加密的字符串
     * @return: String 加密过后的字符串
     */
    @Override
    public String getEncryptString(String password) {

        String md5WithSalt = null;
        //非空字符串
        if (password != null && !"".equals(password.trim())) {
            md5WithSalt = MD5Utils.md5Crypt(password.trim().getBytes(), "$1$".concat(EncryptSalt.getRandomSalt(12)));
        }
        //“”字符串加密要得到tVHbkPWW57Hw.作为加密后结果
        if (password != null && "".equals(password.trim())) {
            md5WithSalt = "tVHbkPWW57Hw.";
        }
        return md5WithSalt;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月15日
     * 方法介绍:   根据deptId获取该部门下的所有用户信息
     * 参数说明:   @param deptId
     * 参数说明:   @return  List<Users>
     */
    @Override
    public List<Users> getUsersByDeptId(Integer deptId) {
        if (deptId != null) {
            return usersMapper.getUsersByDeptId(deptId);
        } else {
            return null;
        }

    }

    @Override
    public List<Users> getUsersNoByDeptId(Integer userPrivNo, Integer deptId) {
        return usersMapper.getUsersNoByDeptId(userPrivNo, deptId);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午5:20:05
     * 方法介绍:   根据传入参数串获取用户信息
     * 参数说明:   @param conditions 参数
     * 参数说明:   @return
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public List<Users> getUserByDeptIds(String conditions, Integer flag) {
        if (StringUtils.checkNull(conditions)) {
            return null;
        }

        Map<String, Object> map = new HashMap<String, Object>();
        List<Users> l = new ArrayList<Users>();
        String[] temp = conditions.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                List<Users> list = new ArrayList<Users>();
                List<Users> list1 = new ArrayList<Users>();
                switch (flag) {
                    case 1:
                        map.put("deptId", temp[i]);
                        list = usersMapper.getdepId(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 2:
                        map.put("userPriv", temp[i]);
                        list = usersMapper.getdepId(map);
                        //list1 = usersMapper.getUserPrivOther(temp[i]);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                      /*  if (list1.size() > 0) {
                            l.addAll(list1);
                        }*/
                        break;
                    case 3:
                        map.put("deptIdOther", temp[i]);
                        list = usersMapper.getdepId(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 4:
                        map.put("userPrivOther", temp[i]);
                        list = usersMapper.getdepId(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 5://部门和辅助部门
                        map.put("deptIdAll", temp[i]);
                        list = usersMapper.getdepId(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 6://角色和辅助角色
                        map.put("userPrivAll", temp[i]);
                        list = usersMapper.getdepId(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    default:
                        break;
                }
               /* if(flag){
                    map.put("deptId",temp[i]);
                    List<Users> list=usersMapper.getdepId(map);
                    l.addAll(list);
                }else{
                    map.put("userPriv",temp[i]);
                    List<Users> list=usersMapper.getdepId(map);
                    l.addAll(list);
                }*/

            }
        }
        l = this.reAllUser(l);
        return l;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午5:20:05
     * 方法介绍:   根据userId串获取用户信息
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public List<Users> getUserByuserId(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        String[] temp = userIds.split(",");
        List<Users> l = usersMapper.getUsersByUserIdsOrder(temp);
        return l;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午5:20:05
     * 方法介绍:   根据uid串获取用户信息
     * 参数说明:   @param uids  用户uid串
     * 参数说明:   @return
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public List<Users> getUserByuId(String uIds) {
        if (StringUtils.checkNull(uIds)) {
            return null;
        }
        List<Users> l = new ArrayList<Users>();
        String[] temp = uIds.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                Users users = usersMapper.getByUid(Integer.parseInt(temp[i]));
                if (users != null) {
                    l.add(users);
                }
            }
        }
        return l;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/22 13:30
     * @函数介绍: 根据用户ID查询
     * @参数说明: @param String uid
     * @return: String
     */
    @Override
    public String getUserPrivByuId(Integer uId) {

        return usersMapper.getUserPrivByuId(uId);

    }


    @Override
    public List<Users> getNullPwUsers(Integer deptId) {
        return usersMapper.getNullPwUsers(deptId);
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年6月20日
     * 方法介绍:   根据deptId获取该部门上级部门下的所有用户信息
     * 参数说明:   @param deptId
     * 参数说明:   @return  List<Users>
     */
    @Override
    public List<Users> getPUsersByDeptId(Integer deptId) {
        if (deptId != null) {
            return usersMapper.getPUsersByDeptId(deptId);
        } else {
            return null;
        }

    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年6月20日
     * 方法介绍:   根据deptId获取该部门下级部门下的所有用户信息
     * 参数说明:   @param deptId
     * 参数说明:   @return  List<Users>
     */
    @Override
    public List<Users> getCUsersByDeptId(Integer deptId) {
        if (deptId != null) {
            return usersMapper.getCUsersByDeptId(deptId);
        } else {
            return null;
        }

    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年6月20日
     * 方法介绍:   根据deptId获取该部门同级部门下的所有用户信息
     * 参数说明:   @param deptId
     * 参数说明:   @return  List<Users>
     */
    @Override
    public List<Users> getTUsersByDeptId(Integer deptId) {
        if (deptId != null) {
            return usersMapper.getTUsersByDeptId(deptId);
        } else {
            return null;
        }

    }


    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   清空密码
     * 参数说明:   @param uid
     */
    @Override
    public void clearPassword(String uids) {
        if (!StringUtils.checkNull(uids)) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                usersMapper.clearPassword(split);
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   清空在线时间
     * 参数说明:   @param uid
     */
    @Override
    public void clearOnLine(String uids) {
        if (!StringUtils.checkNull(uids)) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                usersMapper.clearOnLine(split);
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   设置禁止登陆
     * 参数说明:   @param uid
     */
    @Override
    public void setNotLogin(String uids) {
        if (!StringUtils.checkNull(uids)) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                usersMapper.setNotLogin(split);
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2021年3月16日
     * 方法介绍:   设置允许登陆
     * 参数说明:   @param uid
     */
    @Override
    public void setAllowLogin(String uids) {
        if (!StringUtils.checkNull(uids)) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                usersMapper.setAllowLogin(split);
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   批量修改部门
     * 参数说明:   @param uids
     *
     * @return
     */
    @Override
    public ToJson editUsersDetId(Integer deptId, String uids, Integer nowDeptId,HttpServletRequest request) {
        ToJson json = new ToJson(1, "error");
        try {
            if (!StringUtils.checkNull(uids) && deptId != null) {
                String[] split = uids.split(",");
                if (split != null && split.length > 0) {
                    //用户修改为离职部门时记录原部门id
                    if(deptId == 0){
                        usersMapper.editUsersLeaveDept(split);
                    }
                    usersMapper.editUsersDetId(deptId, split);
                    StringBuffer toIds = new StringBuffer();
                    for (int i = 0; i < split.length; i++) {
                        // user_dept_order 用户部门排序  防止因为升级原因导致数据不全等等
                        List<UserDeptOrder> userDeptOrder = userDeptOrderMapper.selectUserAndDepts(split[i], deptId);
                        if (userDeptOrder.size() == 0) {//说明移入的部门有相同的人员排序   不进行新增排序
                            List<UserDeptOrder> now = userDeptOrderMapper.selectUserAndDepts(split[i], nowDeptId);
                            if (now.size() > 1) {
                                userDeptOrderMapper.deleteByPrimaryKey(now.get(1).getOrderId());
                            }
                            now.get(0).setDeptId(deptId);
                            userDeptOrderMapper.updateByPrimaryKeySelective(now.get(0));
                        } else {
                            json.setMsg("移入的部门有相同的人员");
                        }

                    }
                    if(!Objects.isNull(toIds)) {
                        String remindType = request.getParameter("remindType");
                        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users());
                        String deptName = departmentMapper.departmentOneSelect(deptId);
                        String title = "部门调换提醒";
                        String context = "您的部门已被调换为"+deptName;
                        // 判断根据什么方式进行提醒 1事务提醒 2短信提醒 3事务和短信同时提醒
                        SmsBody smsBody = new SmsBody("admin", "0", DateFormat.getTime(DateFormat.getCurrentTime()), "/controlpanel/personInfor?type=0", title + context);
                        smsBody.setRemindUrl("/controlpanel/personInfor?type=0");
                        smsBody.setToId(toIds.toString());
                        smsBody.setBodyId(null);
                        if (!StringUtils.checkNull(remindType)) {
                            if ("1".equals(remindType)) {
                                smsService.saveSms(smsBody, users.getUserId(), "1", "1", title, context, sqlType);//存储事物提醒并推送消息
                            } else if ("2".equals(remindType)) {
                                sms2PrivService.smsSenders(new StringBuffer(context), toIds.toString());
                            } else if ("3".equals(remindType)) {
                                smsService.saveSms(smsBody, users.getUserId(), "1", "1", title, context, sqlType);//存储事物提醒并推送消息
                                sms2PrivService.smsSenders(new StringBuffer(context), toIds.toString());
                            }
                        }
                    }


                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   根据id数组获取用户信息
     * 参数说明:   @param uids
     * 参数说明:   @param List<Users>
     */
    @Override
    public List<Users> getUsersByUids(String uids) {
        if (!StringUtils.checkNull(uids)) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                return usersMapper.getUsersByUids(split);
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Users> deptHaveUser(String deptNO) {
        return usersMapper.deptHaveUser(deptNO);
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年6月22日
     * 方法介绍:   添加信息
     * 参数说明:   @param
     * 参数说明:   users
     */

    @Override
    public void addU(Users users) {

        usersMapper.addU(users);
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年6月22日
     * 方法介绍:   查询信息
     * 参数说明:   @param
     * 参数说明:   users
     */

    @Override
    public List<Users> selectList(Users users) {

        List<Users> list = usersMapper.selectList(users);
        return list;
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午10:32:22
     * 方法介绍:   根据userId进行模糊查询
     * 参数说明:   @param userId,userName
     * 参数说明:
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public ToJson<Users> queryUserByUserId(String userName, HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (StringUtils.checkNull(userName)) {
            json.setMsg("查询不能为空");
            return json;
        }
        try {
            List<Users> userList = new ArrayList<Users>();
            if (!StringUtils.checkNull(userName)) {
                StringBuffer newStr = new StringBuffer();
                char[] stringArr = userName.toCharArray();
                for (char s : stringArr) {
                    newStr.append(s + "_");
                }
                Map<String, Object> map = new HashedMap();
                map.put("userName", userName);
                map.put("newStr", newStr.toString());
                if (departmentService.checkOrgFlag(users) == 2) {
                    List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(users, true, true);
                    int[] deptIds = new int[departmentByClassifyOrg.size()];
                    for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                        deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                    }
                    map.put("deptIds", deptIds);
                }
                userList = usersMapper.queryUserByUserIds(map);
                // 判断是否缺失头像
                for (Users u : userList) {
                    if (StringUtils.checkNull(u.getAvatar())) {
                        u.setAvatar(u.getSex());
                    }
                }
            }
            json.setObj(userList);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UsersServiceImpl queryUserByUserId:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午10:35:22
     * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
     * 参数说明:   @param  userId,userName
     * 参数说明:
     *
     * @return List<SUsers>  返回用户信息
     */
    @Override
    public int queryCountByUserId(String userName) {
        int count = 0;
        if (!StringUtils.checkNull(userName)) {
            count = usersMapper.queryCountByUserId(userName);
        }
        return count;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 14:23
     * @函数介绍: 查询用户数
     * @参数说明: 无
     * @return: int
     **/
    @Override
    public int getUserCount() {
        return usersMapper.getUserCount();

    }

    @Override
    public int getUserCountBySql(String databaseName) {
        int i = usersMapper.getUserCountBySql(databaseName);
        return i;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 18:04
     * @函数介绍: 修改密码
     * @参数说明: @param request
     * @参数说明: @param Users
     * @return: XXType(value introduce)
     */
    @Override
    public String editPwd(HttpServletRequest request, Users user, String newPwd) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

        //int uid = users.getUid();
        Users selectUser = usersMapper.getPassWordByUserId(users.getUserId());
        String encryPwd = getEncryptString(newPwd);
        String uPass = user.getPassword();//用户输入的原密码
        String sPass = selectUser.getPassword();//数据库中存的密码
        Boolean editPwdFlag = checkPassWordUser(user.getUserId(), sPass, uPass);
        if (uPass.equals("")) {
            if (editPwdFlag) {
                String lastPassTime = DateFormat.getCurrentTime();
                user.setPassword(encryPwd);
                Map<String, String> map = new HashMap<String, String>();
                map.put("pwd", encryPwd);
                map.put("uid", user.getUserId());
                map.put("lastPassTime", lastPassTime);
                int total = usersMapper.updatePwd(map);
                if (total > 0) {
                    //将修改登录密码添加到日志中
                    Syslog syslog = new Syslog();
                    syslog.setUserId(users.getUserId() + "");
                    syslog.setType(14);
                    syslog.setTypeName("修改登录密码");
                    syslog.setRemark("");
                    String userAgent = request.getParameter("userAgent");
                    if ("iOS".equals(userAgent)) {
                        //添加客户端类型
                        syslog.setClientType(3);
                        SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                        syslog.setClientVersion(Version.getParaValue());
                    } else if ("android".equals(userAgent)) {
                        syslog.setClientType(4);
                        SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                        syslog.setClientVersion(Version.getParaValue());
                    } else if ("pc".equals(userAgent)) {
                        syslog.setClientType(2);
                        SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                        syslog.setClientVersion(Version.getParaValue());
                    } else {
                        syslog.setClientType(1);
                        String clientVersion = request.getParameter("clientVersion");
                        if (clientVersion != null && clientVersion.length() > 0) {
                            syslog.setClientVersion(clientVersion);
                        } else {
                            syslog.setClientVersion(SystemInfoServiceImpl.softVersion);
                        }
                    }
                    syslog.setIp(IpAddr.getIpAddress(request));
                    syslog.setTime(new Date(System.currentTimeMillis()));
                    syslogMapper.save(syslog);
                }

            } else {
                return "原密码错误";
            }

        } else {
            if (sPass.equals("tVHbkPWW57Hw.")) {
                return "原密码错误";
            } else {
                SysPara sysPara = sysParaMapper.querySysPara("OFUSERPWD");
                if (sysPara != null) {
                    if (sysPara.getParaValue().equals("1")) {
                        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
                        Users ur = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
                        UserExt2 userExt2 = new UserExt2();
                        userExt2.setUid(ur.getUid());
                        if (newPwd != null && !newPwd.equals("")) {
                            userExt2.setPassword(newPwd);
                        } else {
                            userExt2.setPassword("");
                        }
                        userExt2.setUserId(ur.getUserId());
                        UserExt2 userext = userExt2Mapper.userExt2Info(userExt2);
                        if (userext != null) {
                            userExt2Mapper.editUserExt(userExt2);
                        } else {
                            userExt2Mapper.addUserExt(userExt2);
                        }
                    }
                }

                if (editPwdFlag) {

                    String lastPassTime = DateFormat.getCurrentTime();
                    user.setPassword(encryPwd);
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("pwd", encryPwd);
                    map.put("uid", users.getUserId());
                    map.put("lastPassTime", lastPassTime);
                    int total = usersMapper.updatePwd(map);
                    if (total > 0) {
                        //将修改登录密码添加到日志中
                        Syslog syslog = new Syslog();
                        syslog.setUserId(users.getUserId() + "");
                        syslog.setType(14);
                        syslog.setTypeName("修改登录密码");
                        syslog.setRemark("");
                        String userAgent = request.getParameter("userAgent");
                        if ("iOS".equals(userAgent)) {
                            //添加客户端类型
                            syslog.setClientType(3);
                            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                            syslog.setClientVersion(Version.getParaValue());
                        } else if ("android".equals(userAgent)) {
                            syslog.setClientType(4);
                            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                            syslog.setClientVersion(Version.getParaValue());
                        } else if ("pc".equals(userAgent)) {
                            syslog.setClientType(2);
                            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                            syslog.setClientVersion(Version.getParaValue());
                        } else {
                            syslog.setClientType(1);
                            String clientVersion = request.getParameter("clientVersion");
                            if (clientVersion != null && clientVersion.length() > 0) {
                                syslog.setClientVersion(clientVersion);
                            } else {
                                syslog.setClientVersion(SystemInfoServiceImpl.softVersion);
                            }
                        }
                        syslog.setIp(IpAddr.getIpAddress(request));
                        syslog.setTime(new Date(System.currentTimeMillis()));
                        syslogMapper.save(syslog);
                    }
                } else {
                    return "原密码错误";
                }
            }

        }
//        if (users != null) {
//            String lastPassTime= DateFormat.getCurrentTime();
//            String encryPwd = getEncryptString(newPwd);
//
//            user.setPassword(encryPwd);
//            Map<String, String> map = new HashMap<String, String>();
//            map.put("pwd", user.getPassword());
//            map.put("uid", users.getUserId());
//            map.put("lastPassTime",lastPassTime);
//         int total=  usersMapper.updatePwd(map);
//         if(total>0){
//             //将修改登录密码添加到日志中
//             Syslog syslog = new Syslog();
//             syslog.setUserId(uid);
//             syslog.setType(14);
//             syslog.setTypeName("修改登录密码");
//             syslog.setRemark("");
//             InetAddress currentIp = IpAddr.getCurrentIp();
//             syslog.setIp(currentIp.toString().substring(1, currentIp.toString().length()));
//             syslog.setTime(new Date(System.currentTimeMillis()));
//             syslogMapper.save(syslog);
//         }
//
//        } else {
//            return "原密码错误";
//        }
        /*Boolean isPwdRight = checkPassWord(uid, pwd);
        if (isPwdRight) {

            String encryPwd = getEncryptString(newPwd);
            users.setPassword(encryPwd);
            Map<String, String> map = new HashMap<String, String>();
            map.put("pwd", users.getPassword());
            map.put("uid", users.getUserId());
            usersMapper.updatePwd(map);

        } else {
            return "原密码错误";
        }*/

        return "ok";
    }

    @Override
    public Users getLoginUser(HttpServletRequest request) {
        //1、获取当前登录用户
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        users.getUid();
        users.getUserId();
        users.getByname();
        StringBuffer sb = new StringBuffer();
        Users temp = usersMapper.findUsersByuserId(users.getUserId());
        users.setDeptYj(temp.getDeptYj());
        // 查询辅助角色名称信息
        if (temp != null && !StringUtils.checkNull(temp.getUserPrivOther())) {
            List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(temp.getUserPrivOther().split(","));
            if (privNameByIds != null) {
                for (UserPriv entity : privNameByIds) {
                    sb.append(entity.getPrivName() + ",");
                }
                users.setUserPrivOtherName(sb.toString());
            }
            sb.setLength(0);
        }

        // 获取当前用户所在的分支机构
        if (users.getBranchDeptId() != null) {
            users.setBranchDeptId(users.getBranchDeptId());
            String deptName = departmentMapper.getDeptNameById(users.getBranchDeptId());
            if (!StringUtils.checkNull(deptName)) {
                users.setBranchDeptName(deptName);
            }

            // 获取当前用户管理的分支机构
            Map<String, Object> map = new HashMap<>();
            map.put("uid", users.getUid());
            List<Department> departmentList = departmentMapper.getClassifyOrgByAdmin(map);
            if (!CollectionUtils.isEmpty(departmentList)) {
                users.setUserManageOrgs(departmentList.stream().map(Department::getDeptId).collect(Collectors.toList()).stream().map(String::valueOf).collect(Collectors.joining(",")));
            } else {
                users.setUserManageOrgs("");
            }

        }

        return users;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/29 18:17
     * @函数介绍: 用户人数是否超过授权
     * @参数说明: 无
     * @return: boolean
     **/
    @Override
    public boolean isUserToMany(HttpServletRequest request) {

        int authUser = systemInfoService.getAuthUser(request);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try {
            //读取授权文件
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, null, request);
            String isSoftAuth = map.get("isSoftAuth");
            int userCount = usersMapper.getLoginUserCount();
            if (!StringUtils.checkNull(isSoftAuth)) {
                //先判断是否注册
                if (isSoftAuth.equals("已注册")) {
                    if (userCount < authUser) {
                        return false;
                    }

                }
                //中小型企业以及其他企业
                else {
                    authUser = 30;
                    if (userCount < authUser) {
                        return false;
                    }
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean isUserToMany(HttpServletRequest request, int insertCount) {
        int authUser = systemInfoService.getAuthUser(request);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try {
            //读取授权文件
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, null, request);
            String isSoftAuth = map.get("isSoftAuth");
            int userCount = usersMapper.getLoginUserCount();
            if (!StringUtils.checkNull(isSoftAuth)) {
                //先判断是否注册
                if (isSoftAuth.equals("已注册")) {
                    if ((userCount + insertCount) <= authUser) {
                        return false;
                    }
                }
                //中小型企业以及其他企业
                else {
                    authUser = 30;
                    if ((userCount + insertCount) <= authUser) {
                        return false;
                    }
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return true;
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/30
     * @函数介绍: 查询新增加的用户
     * @参数说明: 无
     **/
    @Override
    public ToJson<Users> getNewUsers(String deptNo) {
        ToJson<Users> json = new ToJson<Users>();

        try {
            Map map = new HashMap();
            if (!"".equals(deptNo) && deptNo != null) {
                String[] deptNoStr = deptNo.split(",");
                map.put("deptNo", deptNoStr);
            }
            List<Users> newUsers = usersMapper.getNewUsers(map);
            for (Users entity : newUsers) {
                if ("tVHbkPWW57Hw.".equals(entity.getPassword())) {
                    entity.setPassword("");
                }
                if (entity.getLastVisitTime() != null) {
                    // 获取闲置时间
                    long times = System.currentTimeMillis() - entity.getLastVisitTime().getTime();
                    long day = times / (24 * 60 * 60 * 1000);
                    long hour = (times / (60 * 60 * 1000) - day * 24);
                    long min = ((times / (60 * 1000)) - day * 24 * 60 - hour * 60);

                    StringBuffer sb = new StringBuffer();
                    if (day > 0) {
                        sb.append(day + "天");
                    }
                    if (hour > 0) {
                        sb.append(hour + "小时");
                    }
                    if (min > 0) {
                        sb.append(min + "分");
                    }
                    entity.setIdleTime(sb.toString());
                } else {
                    entity.setIdleTime("未曾登陆");
                }
                if (entity.getDeptId() == 0) {
                    entity.setDeptName("离职或外部人员");
                }
            }
            json.setObj(newUsers);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/1 9:34
     * @函数介绍: 获取可以void
     * @return: int
     **/
    @Override
    public int getCanLoginUser() {

        return usersMapper.getLoginUserCount();

    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月1日
     * 方法介绍:   根据uid查询单个接口
     * 参数说明:   @param
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @Override
    public Users getUserByUid(int uid, String sqlType) {
        Users user = usersMapper.getUserByUid(uid);

        // 闵行组织处理 获取组织名
        if(!StringUtils.checkNull(user.getMhOrg())){
            List<OrgManage> orgManages = orgManageMapper.selOrgInIds(Arrays.asList(user.getMhOrg().split(",")));
            StringBuilder orgNames = new StringBuilder();
            orgManages.forEach(org->{
                orgNames.append(org.getName()).append(",");
            });
            user.setMhOrgName(orgNames.toString());
        }

        if (user.getSignImageId() != null && user.getSignImageId() != null) {
            user.setAttachment(GetAttachmentListUtil.returnAttachment(user.getSignImageName(), user.getSignImageId(), sqlType, GetAttachmentListUtil.USER_IMAGE));
        }


        StringBuffer sb = new StringBuffer();
        // 查询辅助角色名称信息
        if (user != null && !StringUtils.checkNull(user.getUserPrivOther())) {
            String[] split = user.getUserPrivOther().split(",");
            for (String s : split) {
                String privNameById = modulePrivMapper.getPrivNameById(s.toString());
                if(!StringUtils.checkNull(privNameById)){
                    sb.append(privNameById).append(",");
                }
            }
            user.setUserPrivOtherName(sb.toString());
            /*List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(user.getUserPrivOther().split(","));
            if (privNameByIds != null) {
                for (UserPriv entity : privNameByIds) {
                    sb.append(entity.getPrivName() + ",");
                }
                user.setUserPrivOtherName(sb.toString());
            }*/
            sb.setLength(0);
        }
        // 查询其他部门名称信息
        if (!StringUtils.checkNull(user.getDeptIdOther())) {
            String[] split = user.getDeptIdOther().split(",");
            for (String s : split) {
                String deptNameById = departmentMapper.getDeptNameById(Integer.parseInt(s));
                if(!StringUtils.checkNull(deptNameById)){
                    sb.append(deptNameById).append(",");
                }

            }
            user.setDeptOtherName(sb.toString());
            /*List<Department> deptNameByIds = modulePrivMapper.getDeptNameByIds(user.getDeptIdOther().split(","));
            if (deptNameByIds != null) {
                for (Department entity : deptNameByIds) {
                    sb.append(departmentMapper.getDeptNameById(entity.getDeptId()) + ",");
                }
                user.setDeptOtherName(sb.toString());
            }*/
            sb.setLength(0);
        }
        ModulePriv modulePriv = new ModulePriv();
        modulePriv.setUid(uid);
        modulePriv.setModuleId(0);
        modulePriv = modulePrivMapper.getModulePrivSingle(modulePriv);
        // 查询获取白名单名称数据
        if (modulePriv != null) {
            user.setModulePriv(modulePriv);
            if (!StringUtils.checkNull(modulePriv.getUserId())) {
                List<Users> usersByUids = usersMapper.getUsersByUserIds(modulePriv.getUserId().split(","));
                if (usersByUids != null) {
                    StringBuffer ids = new StringBuffer();
                    for (Users entity : usersByUids) {
                        sb.append(entity.getUserName() + ",");
                        ids.append(entity.getUserId() + ",");
                    }
                    modulePriv.setUserName(sb.toString());
                    modulePriv.setUserId(ids.toString());
                }
                sb.setLength(0);
            }
            if (!StringUtils.checkNull(modulePriv.getPrivId())) {
                List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(modulePriv.getPrivId().split(","));
                if (privNameByIds != null) {
                    for (UserPriv entity : privNameByIds) {
                        sb.append(entity.getPrivName() + ",");
                    }
                    modulePriv.setPrivName(sb.toString());
                }
                sb.setLength(0);
            }
            if (!StringUtils.checkNull(modulePriv.getDeptId())) {
                List<Department> deptNameByIds = modulePrivMapper.getDeptNameByIds(modulePriv.getDeptId().split(","));
                if (deptNameByIds != null) {
                    for (Department entity : deptNameByIds) {
                        sb.append(entity.getDeptName() + ",");
                    }
                    modulePriv.setDeptName(sb.toString());
                }
                sb.setLength(0);
            }

        }


        return user;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/3 11:11
     * @函数介绍: 修改用户界面主题
     * @参数说明: @param Users, 有menuType，theme，bkground，menuExpand，panel，callSound
     * @参数说明: @param request
     * @return: void
     */
    @Override
    public void updateUserTheme(Users users, HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");

        //获取登录用户
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        loginUser.setMenuType(users.getMenuType());
        loginUser.setTheme(users.getTheme());
        loginUser.setBkground(users.getBkground());
        loginUser.setMenuExpand(users.getMenuExpand());
        loginUser.setPanel(users.getPanel());
        loginUser.setCallSound(users.getCallSound());
        loginUser.setBpNo(users.getBpNo());
        // loginUser.setWeatherCity(users.getWeatherCity());

        usersMapper.updateUserTheme(loginUser);
        if (users.getTheme() != null) {
            String theme = "theme" + users.getTheme();
            SessionUtils.putSession(request.getSession(), "InterfaceModel", theme, redisSessionCookie);
        }


    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/3 14:38
     * @函数介绍: 获取登录用户
     * @参数说明: @param request
     * @return: User
     */
    @Override
    public Users getLoginUserTheme(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        Integer uid = users.getUid();
        Users users1 = usersMapper.getUserByUid(uid);
        if (users1 != null && 0 == users1.getTheme()) {
            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            users1.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
            users1.setBannerText(interfaceModels.get(0).getBannerText());
            users1.setBannerFont(interfaceModels.get(0).getBannerFont());
        }
        String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class, redisSessionCookie);
        SessionUtils.putSession(request.getSession(), "InterfaceModel", theme, redisSessionCookie);

        return users1;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月3日
     * 方法介绍:   查询和导出接口
     * 参数说明:   @param  user,sortType,isExport
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @Override
    public ToJson<Users> queryExportUsers(HttpServletRequest request, HttpServletResponse response, Users user, String sortType, String isExport, String notLogin, Integer page, Integer pageSize, Boolean useFlag, String deptNo, Integer type) {
        ToJson<Users> json = new ToJson<Users>();

        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfouser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String userFunctionStr = userFunctionMapper.getUserFuncIdStr(sessionInfouser.getUserId());
            String[] f = userFunctionStr.split(",");
          /*  if (!Arrays.asList(f).contains("33")){
                json.setFlag(1);
                json.setMsg("越权");
                return json;
            }*/

            String moduleId = request.getParameter("moduleId");
            Map map = modulePrivService.getModulePriv(sessionInfouser, moduleId);
            PageParams pageParams = new PageParams();
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
            map.put("userId", user.getUserId());
            map.put("byname", user.getByname());
            map.put("userName", user.getUserName());
            map.put("mobilNo", user.getMobilNo());
            map.put("sex", user.getSex());
            map.put("postPriv", user.getPostPriv());
            map.put("notViewUser", user.getNotViewUser());
            map.put("notViewTable", user.getNotViewTable());
            map.put("dutyType", user.getDutyType());
            map.put("sortType", sortType);

            if (!StringUtils.checkNull(notLogin)) {
                map.put("notLogin", notLogin);
            }

            if (!StringUtils.checkNull(user.getUserPrivs())) {
                String[] userPrivsArr = user.getUserPrivs().split(",");
                map.put("userPrivs", userPrivsArr);
            }
            String[] deptIdsArr = {};
            if (!StringUtils.checkNull(user.getDeptIds())) {
                if (user.getDeptId() != null && user.getDeptId() != 0) {
                    user.setDeptIds(user.getDeptIds() + user.getDeptId());
                }
                deptIdsArr = user.getDeptIds().split(",");
                map.put("deptIds", deptIdsArr);
                if (deptIdsArr.length > 1) {
                    map.put("deptIda", -1);
                } else if (deptIdsArr.length == 1) {
                    map.put("deptIda", deptIdsArr[0]);
                }
            } else if (user.getDeptId() != null && user.getDeptId() > 0) {
                user.setDeptIds(user.getDeptId() + ",");
                deptIdsArr = user.getDeptIds().split(",");
                map.put("deptIds", deptIdsArr);
                map.put("deptIda", user.getDeptId());
            } else if (user.getDeptId() != null && user.getDeptId().equals(0)) {
                map.put("deptIda", 0);
            }
            if (!"".equals(deptNo) && deptNo != null) {
                String[] deptNoStr = deptNo.split(",");
                map.put("deptNo", deptNoStr);
            }


            //增加分级机构过滤条件(不理解用法暂时去掉)
            if (sessionInfouser.getUserPriv() != 1 && map.get("deptIda") == null && false) {
                String deparIds = "";
                List<Department> departs = new ArrayList<>();
                Department orgbyDeptId = getClassifyOrgbyDeptId(sessionInfouser.getDeptId());
                departs.add(orgbyDeptId);
                getChild(departs, orgbyDeptId.getDeptId());
                if (deptIdsArr.length > 0) {
                    for (int i = deptIdsArr.length - 1; i >= 0; i--) {
                        for (Department depart : departs) {
                            if (depart.getDeptId().equals(deptIdsArr[i])) {
                                deparIds += (deptIdsArr[i] + ",");
                            }
                        }
                    }
                } else {
                    for (Department depart : departs) {
                        deparIds += (depart.getDeptId() + ",");
                    }
                }
                map.put("deptIds", deparIds.split(","));
            }

            //2019-12-09修改为，只能查看属于分级机构的部门。部门不是分级机构则不在此接口的返回数据范围内
            //type参数，用于区分 分级机构-分级机构用户管理和组织机构设置-用户管理的用户查询或导出
            List<Department> departs = new ArrayList<>();
            if (type == 1) {
                //是否开启分级机构设置.如没有直接返回()
                String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
                //if(!(StringUtils.checkNull(sysPara) || sysPara.equals("0"))){//导致分级机构查询查询不了  ORG_SCOPE 1 分级机构   0全体
                if (!(StringUtils.checkNull(sysPara))) {
                    //判断用户的部门以及辅助部门中是否包含不是分级机构的部门，去查询此离部门最近的上级分级机构
                    //拼接用户的部门和辅助部门
                    String deptIds = sessionInfouser.getDeptId() + "," + sessionInfouser.getDeptIdOther();
                    //判断用户的部门和辅助部门中不是分级机构的，就去查询此离部门最近的上级分级机构替换此部门
                    String[] deptIdSplit = deptIds.split(",");
                    for (int i = 0; i < deptIdSplit.length; i++) {
                        if (!StringUtils.checkNull(deptIdSplit[i])) {
                            Department classifyOrgbyDeptId = getClassifyOrgbyDeptId(Integer.valueOf(deptIdSplit[i]));
                            //如果到了最上级依旧不是分级机构，返回空
                            if (classifyOrgbyDeptId.getClassifyOrg() == 0) {
                                //departs = null;
                                continue;
                            }
                            //将此部门添加到返回值中
                            departs.add(classifyOrgbyDeptId);
                            //将此部门的下级部门添加到返回值中
                            //获取deptParent为当前部门的部门
                            List<Department> deptParent = departmentMapper.selectObjectByParent(classifyOrgbyDeptId.getDeptId());
                            departs.addAll(deptParent);
                            getChilds(deptParent, departs);
                        }
                    }
                    if (departs != null && departs.size() > 0) {
                        List<Integer> ids = departs.stream().map(Department::getDeptId).collect(Collectors.toList());
                        map.put("deptIds", ids);
                    }
                } else {
                    departs = null;
                }

            }
            List<Users> users = new ArrayList<>();
            String sysPara = null;
            try {
                sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
            } catch (Exception e) {

            }

                //如果type为1分级机构用户管理，并且departs没有值证明没有分级机构部门，则返回空
                if (!(type == 1 && departs == null)) {
                    users = usersMapper.queryExportUsers(map);
                }


            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(users,null);

            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            } catch (Exception e) {

            }
            if (!StringUtils.checkNull(user.getDeptIds())) {
                try {
                    if ("1".equals(order)) {
                        for (Users users1 : users) {
                            if (!StringUtils.checkNull(users1.getUserId())) {
                                //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), Integer.parseInt(user.getDeptIds().split(",")[0])).getOrderNo());
                                //规避没有这个排序的用户会报错给一个默认排序10
                                UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), Integer.parseInt(user.getDeptIds().split(",")[0]));
                                Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                                users1.setUserDeptNo(userDeptNo);
                            }
                        }
                        Collections.sort(users, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                        //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (map.get("deptIda") != null && "0".equals(map.get("deptIda").toString())) {
                Collections.sort(users, (Users a, Users b) -> {
                    Long l = 0l;
                    if (a.getLastVisitTime() == null && b.getLastVisitTime() != null) {
                        l = 1l;
                    }
                    if (a.getLastVisitTime() != null && b.getLastVisitTime() == null) {
                        l = -1l;
                    }
                    if (a.getLastVisitTime() != null && b.getLastVisitTime() != null) {
                        l = b.getLastVisitTime().getTime() - a.getLastVisitTime().getTime();
                    }
                    int i = l == 0 ? 0 : l > 0 ? 1 : -1;
                    return i;
                });
            }


            //获取辅助部门人员
            // 2019-05-27 当该部门下有多个用户都是辅助部门用户的时候 会报错  而且上面接口已经查了包括辅助部门的用户了 不需要这个接口 暂时注释
            /*if (!StringUtils.checkNull(user.getDeptIds())) {
                String[] deptIdsArr = user.getDeptIds().split(",");
                for (String de : deptIdsArr) {
                    String des = de + ",";
                    List<Users> DEPT_ID_OTHER = usersMapper.deptIdOthers1(des, notLogin);
                    if (DEPT_ID_OTHER != null) {
                        users.addAll(DEPT_ID_OTHER);
                    }
                }
            }*/

            for (Users entity : users) {
                if (StringUtils.checkNull(entity.getPassword()) || "tVHbkPWW57Hw.".equals(entity.getPassword())) {
                    entity.setPassword("");
                } else {
                    entity.setPassword(null);
                }
                if (entity.getPostId() != null && entity.getPostId() != 0) {
                    if (managementMapper.getUserPostId(entity.getPostId()) != null) {
                        String postName = managementMapper.getUserPostId(entity.getPostId()).getPostName();
                        entity.setPostName(postName);
                    } else {
                        entity.setPostName("");
                    }

                }
                // 判断是否是非法的空字符串密码 如果是的话进行密码修正
                else if (checkPassWordUser(entity.getUserName(), entity.getPassword(), "")) {
                    entity.setPassword("");
                    editPwd(request, entity, "");
                    entity.setPassword("");
                }

                if (entity.getLastVisitTime() != null) {
                    // 获取闲置时间
                    long times = System.currentTimeMillis() - entity.getLastVisitTime().getTime();
                    long day = times / (24 * 60 * 60 * 1000);
                    long hour = (times / (60 * 60 * 1000) - day * 24);
                    long min = ((times / (60 * 1000)) - day * 24 * 60 - hour * 60);

                    StringBuffer sb = new StringBuffer();
                    if (day > 0) {
                        sb.append(day + "天");
                    }
                    if (hour > 0) {
                        sb.append(hour + "小时");
                    }
                    if (min > 0) {
                        sb.append(min + "分");
                    }
                    entity.setIdleTime(sb.toString());
                } else {
                    entity.setIdleTime("未曾登录");
                }
                if (entity.getDeptId() == 0) {
                    entity.setDeptName("离职或外部人员");
                }
            }
            if (users != null) {
                json.setTotleNum(pageParams.getTotal());
                json.setObj(users);
                json.setFlag(0);
                json.setMsg("ok");
            } else {
                json.setFlag(1);
                json.setMsg("err");
            }
            // 判断是否导出
            if ("yes".equals(isExport)) {

//                HSSFWorkbook workbook2 = new HSSFWorkbook();
//                workbook2.createSheet();
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("OA用户信息表", 9);
                String[] secondTitles = {"用户名", "密码", "部门", "姓名", "性别", "生日", "角色", "用户排序号", "管理范围", "手机", "IP", "工作电话", "工作传真", "家庭地址", "邮编", "家庭电话", "E-mail", "QQ", "MSN"};
//                HSSFSheet sheet = workbook2.getSheetAt(0);
//                HSSFRow rowField = sheet.createRow(0);
//                for (int i = 0; i < secondTitles.length; i++) {
//                    HSSFCell cell = rowField.createCell(i);
//                    cell.setCellValue(secondTitles[i]);
//                }
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                // String[] beanProperty = {user.getDep().getDeptName(),"userName","userPrivName", "roleAuxiliaryName","online","sex","online","telNoDept","telNoDept","departmentPhone","email"};
                String[] beanProperty = {"byname", "password", "deptName", "userName", "sex", "birthdayStr", "userPrivName", "userNo", "postPriv", "mobilNo", "bindIp", "telNoDept", "faxNoDept", "addHome", "postNoHome", "telNoHome", "email", "oicqNo", "msn"};

                for (Users us : users) {
                    if ("0".equals(us.getSex())) {
                        us.setAvatar("男");
                        us.setSex("男");
                    } else if ("1".equals(us.getSex())) {
                        us.setAvatar("女");
                        us.setSex("女");
                    } else {
                        us.setAvatar("男");
                        us.setSex("男");
                    }
                    us.setDeptName(departmentServiceImpl.longDepNames(us.getDeptId()));
                }
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, users, beanProperty);
                ServletOutputStream out = response.getOutputStream();

                String filename = "OA用户信息表.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    private void getChilds(List<Department> departs, List<Department> data) {
        for (Department d : departs) {
            List<Department> chDept = departmentMapper.getChDept(d.getDeptId());
            if (chDept != null && chDept.size() > 0) {
                data.addAll(chDept);
                getChilds(chDept, data);
            } else {
                continue;
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月3日
     * 方法介绍:   插入和导入接口
     * 参数说明:   @param  file
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @Override
    public ToJson<Users> insertImportUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String psWord, String userPrivName) {
        ToJson<Users> json = new ToJson<Users>();
        int jishu=0;
        File dest = null;

        if (!StringUtils.checkNull(userPrivName)) {
            userPrivName = userPrivName.replace(",", "");
        }
        //判读当前系统
        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer stringBuffer = new StringBuffer();
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
                stringBuffer = stringBuffer.append(str2 + "/xoa");
            }
            stringBuffer.append(uploadPath);
            buffer = buffer.append(rb.getString("upload.win"));
        } else {
            stringBuffer = stringBuffer.append(rb.getString("upload.linux"));
            buffer = buffer.append(rb.getString("upload.linux"));
        }
        // 判断是否为空文件
        if (file.isEmpty()) {
            json.setMsg("请上传文件！");
            json.setFlag(1);
            return json;
        } else {
            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                int pos = fileName.indexOf(".");
                String extName = fileName.substring(pos);
                String newFileName = uuid + extName;
                File pathfile = new File(String.valueOf(stringBuffer));
                if (!pathfile.exists()) {// 如果目录不存在
                    pathfile.mkdirs();// 创建文件夹
                }
                dest = new File(stringBuffer.toString(), newFileName);
                String readPath = stringBuffer.append(System.getProperty("file.separator")).append(newFileName).toString();
                InputStream in = null;
                try {
                    file.transferTo(dest);
                    in = new FileInputStream(readPath);
                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径

                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    HSSFRow row = sheetObj.getRow(0);
                    int colNum = row.getPhysicalNumberOfCells();
                    int lastRowNum = sheetObj.getLastRowNum();
                    // 判断是否超过用户新建限制
                    boolean userToMany;
                    if (request.getSession() == null) {
                        userToMany = false;
                    } else {
                        userToMany = isUserToMany(request, lastRowNum);
                    }
                    /*if (userToMany) {
                        json.setFlag(1);
                        json.setMsg("超过用户限制");
                        return json;
                    }*/

                    List<Users> saveList = new ArrayList<Users>();
                    List<Users> errorList = new ArrayList<Users>();
                    int updateCount = 0;
                    int insertCount = 0;
                    UserFunction userFunction = new UserFunction();
                    Users entity = null;
                    for (int i = 1; i <= lastRowNum; i++) {
                        jishu=i;
                        entity = new Users();
                        row = sheetObj.getRow(i);
                        String value = "";
                        if (row != null) {
                            for (int j = 0; j < colNum; j++) {
                                Cell cell = row.getCell(j);
                                if (cell != null) {
                                    if (j != 5) {
                                        cell.setCellType(CellType.STRING);
                                    }
                                    switch (j) {
                                        case 0:
                                            entity.setByname(cell.getStringCellValue().trim());
                                            break;
                                        case 1:
                                            if (cell.getStringCellValue().trim().equals("")) {
                                                if (!psWord.equals("")) {
                                                    entity.setPassword(psWord);
                                                }
                                            } else {
                                                entity.setPassword(cell.getStringCellValue().trim());
                                            }
                                            break;
                                        case 2:
                                            entity.setDeptName(cell.getStringCellValue());
                                            break;
                                        case 3:
                                            entity.setUserName(cell.getStringCellValue());
                                            break;
                                        case 4:
                                            String sex = cell.getStringCellValue();
                                            if ("男".equals(sex)) {
                                                entity.setAvatar("0");
                                                entity.setSex("0");
                                            } else if ("女".equals(sex)) {
                                                entity.setAvatar("1");
                                                entity.setSex("1");
                                            } else {
                                                entity.setAvatar("0");
                                                entity.setSex("0");
                                            }
                                            break;
                                        case 5:
                                            entity.setIdNumber(cell.getStringCellValue().trim());
                                            break;
                                        case 6:
                                            try {
                                                entity.setBirthday(cell.getDateCellValue());
                                            } catch (IllegalStateException e) {
                                                String birthdayStr = cell.getStringCellValue();
                                                entity.setBirthday(DateFormat.DateToStr(birthdayStr));
                                            }
                                            break;
                                        case 7:
                                            if (StringUtils.checkNull(cell.getStringCellValue().trim())) {
                                                entity.setUserPrivName(userPrivName);
                                            } else {
                                                entity.setUserPrivName(cell.getStringCellValue().trim());
                                            }
                                            break;
                                        case 8:
                                            entity.setUserNo(Integer.valueOf(StringUtils.checkNull(cell.getStringCellValue()) ? "10" : cell.getStringCellValue().trim()));
                                            break;
                                        case 9:
                                            String postPrivName = cell.getStringCellValue();
                                            if (postPrivName != null) {
                                                if ("全体".equals(postPrivName)) {
                                                    entity.setPostPriv("1");
                                                } else {
                                                    entity.setPostPriv("0");
                                                }
                                            } else {
                                                entity.setPostPriv("0");
                                            }
                                            break;
                                        case 10:
                                            entity.setMobilNo(cell.getStringCellValue());
                                            break;
                                        case 11:
                                            entity.setBindIp(cell.getStringCellValue());
                                            break;
                                        case 12:
                                            entity.setTelNoDept(cell.getStringCellValue());
                                            break;
                                        case 13:
                                            entity.setFaxNoDept(cell.getStringCellValue());
                                            break;
                                        case 14:
                                            entity.setAddHome(cell.getStringCellValue());
                                            break;
                                        case 15:
                                            entity.setPostNoHome(cell.getStringCellValue());
                                            break;
                                        case 16:
                                            entity.setTelNoHome(cell.getStringCellValue());
                                            break;
                                        case 17:
                                            entity.setEmail(cell.getStringCellValue());
                                            break;
                                        case 18:
                                            entity.setOicqNo(cell.getStringCellValue());
                                            break;
                                        case 19:
                                            entity.setMsn(cell.getStringCellValue());
                                            break;
                                        case 20:
                                            entity.setIdNumber(cell.getStringCellValue());
                                            break;
                                        case 21:
                                            entity.setTraNumber(cell.getStringCellValue());
                                            break;
                                        case 22:
                                            entity.setSubject(cell.getStringCellValue());
                                            break;
                                    }
                                } else if (j == 4) {
                                    entity.setAvatar("0");
                                    entity.setSex("0");
                                }
                            }
                        }

                        if(!"admin".equals(row.getCell(0).toString())){
                            //去除用户名 和 姓名前后空格
                            if ( !StringUtils.checkNull(entity.getByname()) ){
                                entity.setByname(entity.getByname().trim());
                            }
                            if (!StringUtils.checkNull(entity.getUserName())){
                                entity.setUserName(entity.getUserName().trim());
                            }

                            //判断分级机构导入只导入分级机构的部门用户
                            Object globalDept = request.getAttribute("globalDeptIds");
                            if (globalDept != null) {
                                List<Integer> globalDeptIds = (List<Integer>) globalDept;
                                if (entity.getDeptName() != null) {
                                    List<String> deptId = departmentMapper.getDeptIdByDeptName(entity.getDeptName());
                                    String deptId1 = deptId.get(0);
                                    if (!globalDeptIds.contains(Integer.parseInt(deptId1))) {
                                        continue;
                                    }
                                }
                            }


                            if (StringUtils.checkNull(entity.getPostPriv())) {
                                entity.setPostPriv("0");
                            }
                            // 判断是否存在相同用户名
                            if (StringUtils.checkNull(ifUpdate) || !"yes".equals(ifUpdate)) {
                                Users usersByuserId = usersMapper.getUsersBybyname(entity.getByname());
                                if (usersByuserId != null && usersByuserId.getByname().equals(entity.getByname())) {
                                    entity.setSaveMsg("此用户名已存在，请修改");
                                    saveList.add(entity);
                                    errorList.add(entity);
                                    continue;
                                }
                            }

                            // 判断是否存在相同身份证号
                            if(!StringUtils.checkNull(entity.getIdNumber())){
                                Users usersByIdNumber = usersMapper.getUserByIdNumber(entity.getIdNumber());
                                if (usersByIdNumber != null && !usersByIdNumber.getByname().equals(entity.getByname())) {
                                    entity.setSaveMsg("此身份证号已存在，请修改");
                                    saveList.add(entity);
                                    errorList.add(entity);
                                    continue;
                                }
                            }

                            if (entity.getUserNo() == null) {
                                entity.setUserNo((int) 10);
                            }


                            // 加密密码
                            if (entity.getPassword() != null) {
                                entity.setPassword(getEncryptString(entity.getPassword().trim()));
                            } else {
                                if (!StringUtils.checkNull(psWord)) {
                                    entity.setPassword(getEncryptString(psWord.trim()));
                                } else {
                                    entity.setPassword("tVHbkPWW57Hw.");
                                }
                            }
                            // 添加姓名索引
                            if (entity.getUserName() != null) {
                                String fistSpell = PinYinUtil.getFirstSpell(entity.getUserName());
                                StringBuffer sb = new StringBuffer();
                                for (int j = 0; j < fistSpell.length(); j++) {
                                    sb.append(fistSpell.charAt(j) + "*");
                                }
                                entity.setUserNameIndex(sb.toString());
                            }
                            // 获取部门id
                            if (entity.getDeptName() != null) {
                                Department d = new Department();
                                if ("-1".equals(entity.getDeptName().indexOf("/"))) {
                                    d.setDeptName(entity.getDeptName());
                                } else {
                                    d.setDeptName(entity.getDeptName().substring(entity.getDeptName().lastIndexOf("/") + 1));
                                }

                                List<String> parentList = null;
                                List<String> deptIdByDeptName=null;
                                String fatherDeptIdAndSonDeptName=null;
                                int quFen=0;//区分查询的是一级部门还是二级部门
                                if (-1 == entity.getDeptName().indexOf("/")) {
                                    quFen=1;
                                    parentList = departmentMapper.getDeptIdByDeptName(entity.getDeptName());
                                } else if (-1 != entity.getDeptName().indexOf("直属分/子公司")) {//单独对  直属分/子公司/深圳光明新区水环境治理工程有限公司/合同管理部
                                    quFen=2;
                                    String[] split = entity.getDeptName().split("/");
                                    String[] chuli = new String[split.length - 1];
                                    for (int sj = 0; sj < chuli.length; sj++) {
                                        if (sj == 0) {
                                            chuli[sj] = split[0] + "/" + split[1];
                                        } else {
                                            chuli[sj] = split[sj + 1];
                                        }
                                    }
                                    String deptParentId = null;
                                    for (int z = 0; z < chuli.length; z++) { //通过当前/  0/1/2
                                         deptIdByDeptName = departmentMapper.getDeptIdByDeptName(chuli[z]);
                                         if(deptIdByDeptName.size()<1){
                                             break;
                                         }else {
                                             if (z == 0) {//第一次进来先拿查出来的赋值  上级部门
                                                 deptParentId = deptIdByDeptName.get(0);
                                             }
                                             fatherDeptIdAndSonDeptName = departmentMapper.getFatherDeptIdAndSonDeptName(deptParentId, chuli[z + 1]);
                                             // 第二次及以后拿最近查出来的赋值
                                             deptParentId = fatherDeptIdAndSonDeptName;
                                             if (z + 2 == chuli.length) { //z为0 应该加2才是要结束的length
                                                 // entity.setDeptId(Integer.parseInt(deptParentId));
                                                 break;
                                             }
                                         }
                                    }
                                } else {
                                    quFen=2;
                                    String[] split = entity.getDeptName().split("/");
                                    String deptParentId = null;
                                    for (int z = 0; z < split.length; z++) { //通过当前/  0/1/2
                                        deptIdByDeptName = departmentMapper.getDeptIdByDeptName(split[z]);
                                        if (deptIdByDeptName.size()<1) {
                                            break;
                                        }else {
                                        if (z == 0) {//第一次进来先拿查出来的赋值  上级部门
                                            deptParentId = deptIdByDeptName.get(0);
                                        }
                                        fatherDeptIdAndSonDeptName = departmentMapper.getFatherDeptIdAndSonDeptName(deptParentId, split[z + 1]);
                                        // 第二次及以后拿最近查出来的赋值
                                        deptParentId = fatherDeptIdAndSonDeptName;
                                        if (z + 2 == split.length) {//z为0 应该加2才是要结束的length
                                            // entity.setDeptId(Integer.parseInt(deptParentId));
                                            break;
                                        }
                                    }
                                    }
                                }
                                if(quFen==1){
                                    String deptId = "";
                                    if (parentList == null) {
                                        entity.setSaveMsg("成功加入长部门名称");
                                    } else if (parentList.size() == 1) {
                                        deptId = parentList.get(0);
                                        if (deptId != null && deptId != "") {
                                            entity.setDeptId(Integer.valueOf(deptId));
                                        } else {
                                            entity.setSaveMsg("失败，部门不存在");
                                            saveList.add(entity);
                                            errorList.add(entity);
                                            continue;
                                        }
                                    } else if (parentList.size() < 1) {
                                        entity.setSaveMsg("失败，部门不存在");
                                        saveList.add(entity);
                                        errorList.add(entity);
                                        continue;
                                    } else{
                                        entity.setSaveMsg("导入失败，部门名称 " + entity.getDeptName() + " 在系统中存在多个");
                                        saveList.add(entity);
                                        errorList.add(entity);
                                        continue;
                                    }
                                }
                                if(quFen==2){
                                    if(deptIdByDeptName.size()<1){
                                        entity.setSaveMsg("失败，父部门不存在");
                                        saveList.add(entity);
                                        errorList.add(entity);
                                        continue;
                                    }
                                    if(StringUtils.checkNull(fatherDeptIdAndSonDeptName)){
                                        entity.setSaveMsg("失败，该父部门下 此子部门不存在");
                                        saveList.add(entity);
                                        errorList.add(entity);
                                        continue;
                                    }else {
                                        entity.setSaveMsg("成功加入长部门名称");
                                        entity.setDeptId(Integer.parseInt(fatherDeptIdAndSonDeptName));
                                    }
                                }
                            }
                            // 获取角色信息
                            if (entity.getUserPrivName() != null) {
                                UserPriv userPriv = null;
                                try {
                                    userPriv = userPrivMapper.getUserPrivByName(entity.getUserPrivName());
                                } catch (TooManyResultsException exception) {
                                    List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(entity.getUserPrivName());
                                    if (userPrivsByName != null && userPrivsByName.size() > 0) {
                                        userPriv = userPrivsByName.get(0);
                                    }
                                }
                                if (userPriv != null) {
                                    entity.setUserPriv(userPriv.getUserPriv());
                                    entity.setUserPrivNo(userPriv.getPrivNo());
                                    entity.setUserPrivName(userPriv.getPrivName());
                                    if (userPriv.getFuncIdStr() != null) {
                                        userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
                                    } else {
                                        userFunction.setUserFunCidStr("1,");
                                    }
                                } else if (!StringUtils.checkNull(userPrivName)) {
                                    UserPriv userPriv2 = null;
                                    try {
                                        userPriv2 = userPrivMapper.getUserPrivByName(userPrivName);
                                    } catch (TooManyResultsException exception) {
                                        List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(userPrivName);
                                        if (userPrivsByName != null && userPrivsByName.size() > 0) {
                                            userPriv2 = userPrivsByName.get(0);
                                        }
                                    }
                                    if (userPriv2 != null) {
                                        entity.setUserPriv(userPriv2.getUserPriv());
                                        entity.setUserPrivNo(userPriv2.getPrivNo());
                                        entity.setUserPrivName(userPriv2.getPrivName());
                                        if (userPriv2.getFuncIdStr() != null) {
                                            userFunction.setUserFunCidStr(userPriv2.getFuncIdStr());
                                        } else {
                                            userFunction.setUserFunCidStr("1,");
                                        }
                                    }
                                } else {
                                    List<UserPriv> alluserPriv = userPrivMapper.getAlluserPriv(null);
                                    Collections.sort(alluserPriv, new Comparator<UserPriv>() {
                                        @Override
                                        public int compare(UserPriv o1, UserPriv o2) {
                                            if (o1.getPrivNo() > o2.getPrivNo()) {
                                                return 1;
                                            } else if (o1.getPrivNo() < o2.getPrivNo()) {
                                                return -1;
                                            } else {
                                                return 0;
                                            }
                                        }
                                    });
                                    UserPriv userPriv1 = alluserPriv.get(alluserPriv.size() - 1);
                                    entity.setUserPriv(userPriv1.getUserPriv());
                                    entity.setUserPrivNo(userPriv1.getPrivNo());
                                    entity.setUserPrivName(userPriv1.getPrivName());
                                    if (userPriv1.getFuncIdStr() != null) {
                                        userFunction.setUserFunCidStr(userPriv1.getFuncIdStr());
                                    } else {
                                        userFunction.setUserFunCidStr("1,");
                                    }
                                }
                            }
                            entity.setImRange(1);
                            entity.setNotLogin(0);

                            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
                            String realPath = request.getSession().getServletContext().getRealPath("/");
                            Map<String, String> map = systemInfoService.getSystemInfo(realPath, locale, request);
                            int canLoginUser = getCanLoginUser();
                            if(!"不限制".equals(map.get("oaUserLimit"))){
                                if(canLoginUser>=Integer.parseInt(map.get("oaUserLimit"))){
                                    entity.setNotLogin(1);
                                }
                            }

                            Users userByName = usersMapper.findUserByName(entity.getByname());
                            //处理特殊的null,要不登录不成功
                            if (entity.getAvatar() == null) {
                                if (entity.getSex() != null) {
                                    if (entity.getSex().equals("0") || entity.getSex().equals("1")) {
                                        entity.setAvatar(entity.getSex());
                                    } else {
                                        entity.setAvatar("");
                                    }
                                } else {
                                    entity.setAvatar("");
                                }
                            }
                            if (entity.getTheme() == null) {
                                List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
                                entity.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
                            }
                            if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                                // 更新
                                entity.setUid(userByName.getUid());
                                entity.setUserId(userByName.getUserId());
                                usersMapper.editUser(entity);

                                userFunction.setUid(entity.getUid());
                                userFunction.setUserId(entity.getUserId());
                                userFunctionMapper.updateUserFun(userFunction);

                                try {
                                    //更新user_dept_order
                                    UserDeptOrder userDept1 = userDeptOrderMapper.selectUserAndDept(entity.getUserId(), entity.getDeptId());
                                    userDept1.setDeptId(entity.getDeptId());
                                    userDept1.setOrderNo(entity.getUserNo());
                                    userDeptOrderMapper.updateByPrimaryKeySelective(userDept1);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                                entity.setSaveMsg("更新成功");
                                saveList.add(entity);
                                ++updateCount;
                            } else if (userByName == null) {
                                // 保存用户
                                entity.setNotViewUser("0");
                                entity.setNotViewTable("0");
                                usersMapper.insert(entity);

                                entity.setUserId(entity.getUid().toString());
                                usersMapper.editUser(entity);

                                UserExt userExt = new UserExt();
                                UserExt userExt1 = userExtMapper.queryUserExt(entity.getUid());
                                if (userExt1 == null) {
                                    userExt.setDutyType(entity.getDutyType());
                                    userExt.setUid(entity.getUid());
                                    userExt.setUserId(entity.getUserId());
                                    userExtMapper.addUserExt(userExt);
                                }


                                userFunction.setUid(entity.getUid());
                                userFunction.setUserId(entity.getUserId());
                                String uid = userFunctionMapper.getUid(entity.getUserId());
                                if (!StringUtils.checkNull(uid) && Integer.parseInt(uid) == userFunction.getUid()) {
                                    userFunctionMapper.updateUserFun(userFunction);
                                } else {
                                    userFunctionMapper.insertUserFun(userFunction);
                                }

                                try {
                                    UserDeptOrder userDeptOrders = new UserDeptOrder();//导入人员时插入
                                    userDeptOrders.setDeptId(entity.getDeptId());
                                    userDeptOrders.setUserId(entity.getUserId());
                                    userDeptOrders.setOrderNo(entity.getUserNo());
                                    userDeptOrders.setPostId(entity.getPostId());
                                    UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(entity.getUserId(), entity.getDeptId());
                                    if (userDeptOrder1 == null) {// 防止部门 和辅助部门设置同一个
                                        userDeptOrderMapper.insertSelective(userDeptOrders);
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                                entity.setSaveMsg("保存成功");
                                saveList.add(entity);
                                ++insertCount;
                            }


                    }else {
                            entity.setSaveMsg("无法导入admin");
                            saveList.add(entity);
                            errorList.add(entity);
                        }
                    }
                    if (saveList != null && saveList.size() > 0 && saveList.get(0) != null) {
                        saveList.get(0).setInsertCount(insertCount);
                        saveList.get(0).setUpdateCount(updateCount);
                    }

                    //如果存在失败数据，就生成失败数据文件保存在附件以供导出
                    List<Attachment> list = new ArrayList<>();
                    if(errorList.size() > 0){

                        HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("用户导入错误数据", 9);
                        String[] secondTitles = {"用户名", "密码", "部门", "姓名", "性别", "生日", "角色", "用户排序号", "管理范围", "手机", "IP", "工作电话", "工作传真", "家庭地址", "邮编", "家庭电话", "E-mail", "QQ", "MSN"};

                        HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                        String[] beanProperty = {"byname", "password", "deptName", "userName", "sex", "birthdayStr", "userPrivName", "userNo", "postPriv", "mobilNo", "bindIp", "telNoDept", "faxNoDept", "addHome", "postNoHome", "telNoHome", "email", "oicqNo", "msn"};

                        HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, errorList, beanProperty);

                        String filename = "用户导入失败数据.xls";

                        ByteArrayOutputStream bos=new ByteArrayOutputStream();
                        workbook.write(bos);

                        byte[] barray=bos.toByteArray();
                        InputStream is=new ByteArrayInputStream(barray);
                        MultipartFile mockMultipartFile = new MockMultipartFile(filename,filename,filename,is);
                        String company = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                        MultipartFile[] multipartFiles = new MultipartFile[1];
                        multipartFiles[0] =  mockMultipartFile;
                        list = enclosureService.upload(multipartFiles, company, "user");
                    }

                    // 设置状态并删除文件
                    json.setObj(saveList);
                    json.setObject(list);
                    json.setFlag(0);
                    json.setMsg("ok");
                } catch (Exception e) {
                    e.printStackTrace();
                    json.setMsg(e.getMessage()+"第"+jishu+"数据导入报错");
                    json.setFlag(1);
                } finally {
                    if (in != null) {
                        try {
                            in.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    dest.delete();
                }
            } else {
                json.setMsg("文件类型不正确！");
                json.setFlag(1);
                return json;
            }
        }


        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年月4日
     * 方法介绍:   批量修改用户
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回显示信息
     */
    @Override
    public ToJson<Users> editUserBatch(Users user, UserExt userExt, String modulePrivIds, String privIds, String deptIds, String uids, HttpServletRequest request) {
        ToJson json = new ToJson();
        List<String> uidsList = new ArrayList<String>();
        StringBuffer sb = new StringBuffer();
        if (!StringUtils.checkNull(uids)) {
            uidsList.addAll(Arrays.asList(uids.split(",")));
            List<Users> usersByUids = usersMapper.getUsersByUids(uids.split(","));
            sb.append("人员：");
            for (Users entity : usersByUids) {
                sb.append(entity.getUserName() + ",");
            }
        }

        // 把查询到的uid添加到uid的list集合中
        if (!StringUtils.checkNull(deptIds)) {
            String[] deptIdsArr = deptIds.split(",");
            sb.append(" 部门：");
            for (String did : deptIdsArr) {
                Department deptById = departmentMapper.getDeptById(Integer.parseInt(did));
                sb.append(deptById.getDeptName() + ",");
            }
            Map map = new HashMap();
            map.put("deptIds",deptIdsArr);
            List<Users> usersByDeptIds = imUsersMapper.getUserByDept(map);
            //List<Users> usersByDeptIds = usersMapper.getUsersByDeptIds(deptIdsArr);
            if (usersByDeptIds != null && usersByDeptIds.size() > 0) {
                for (Users entity : usersByDeptIds) {
                    uidsList.add(entity.getUid().toString());
                }
            }
        }
        // 同上
        if (!StringUtils.checkNull(privIds)) {
            String[] privIdsArr = privIds.split(",");
            sb.append(" 角色：");
            for (String pid : privIdsArr) {
                String privNameById = userPrivMapper.getPrivNameById(Integer.valueOf(pid));
                sb.append(privNameById);
            }
            List<Users> usersByPrivIds = usersMapper.getUsersByPrivIds(privIdsArr);
            if (usersByPrivIds != null && usersByPrivIds.size() > 0) {
                for (Users entity : usersByPrivIds) {
                    uidsList.add(entity.getUid().toString());
                }
            }
        }

        UserFunction userFunction = new UserFunction();
        ModulePriv modulePriv = null;
        if (!StringUtils.checkNull(modulePrivIds)) {
            modulePriv = new ModulePriv();
            modulePriv.setPrivId(modulePrivIds);
        }

        if (user != null) {

            //加密密码
            if (user.getPassword() != null && !"tVHbkPWW57Hw.".equals(user.getPassword())) {
                String password = user.getPassword();
                password = getEncryptString(password.trim());
                user.setPassword(password);
            }

            // 设置用户的角色名称和序号
            if (user.getUserPriv() != null) {
                UserPriv userPriv = userPrivMapper.selectByPrimaryKey(user.getUserPriv());
                if (userPriv != null) {
                    user.setUserPrivNo(userPriv.getPrivNo());
                    user.setUserPrivName(userPriv.getPrivName());
                    // 设置权限
                    if (!StringUtils.checkNull(userPriv.getFuncIdStr())) {
                        userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
                    }
                }
            }
            // 处理默认信息
            if (user.getDeptId() != null && user.getDeptId() == -1) {
                user.setDeptId(null);
            }
            if (user.getPostPriv() != null && user.getPostPriv().equals("")) {
                user.setPostPriv(null);
            }
            if (user.getIsLunar() != null && user.getIsLunar().equals("")) {
                user.setIsLunar(null);
            }
            if (user.getMobilNoHidden() != null && user.getMobilNoHidden().equals("")) {
                user.setMobilNoHidden(null);
            }
            if (user.getNotViewTable() != null && user.getNotViewTable().equals("")) {
                user.setNotViewTable(null);
            }
        }
        try {
            if (uidsList != null && uidsList.size() > 0) {
                if (user.getDeptId() != null && user.getDeptId().equals(0)) {
                    user.setNotMobileLogin(1);
                }
                usersMapper.editUserBatch(uidsList, user);

                if (userExt != null) {
                    userExtMapper.updateUserExtByUids(uidsList, userExt);
                }

                if (userFunction != null && userFunction.getUserFunCidStr() != null) {
                    userFunctionMapper.updateUserFunByUids(uidsList, userFunction);
                }

                if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                    modulePriv = new ModulePriv();
                    for (String uid : uidsList) {
                        modulePriv.setUid(user.getUid());
                        modulePriv.setModuleId(0);
                        modulePriv.setDeptPriv(user.getPostPriv());
                        modulePriv.setDeptId(user.getPostDept());
                        // 查询判断是否存在白名单 如果存在就更新 如果不存在就保存新的
                        ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);
                        if (modulePrivByUid != null) {
                            if (!StringUtils.checkNull(modulePriv.getDeptId()) || !StringUtils.checkNull(modulePriv.getPrivId()) || !StringUtils.checkNull(modulePriv.getUserId())) {
                                modulePrivMapper.updateModulePriv(modulePriv);
                            }
                        } else {
                            modulePrivMapper.addModulePriv(modulePriv);
                        }
                    }
                }
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users nowuUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
                Syslog syslog = new Syslog();
                syslog.setUserId(nowuUser.getUserId());
                syslog.setType(19);
                syslog.setTypeName("用户批量设置");
                syslog.setRemark(sb.toString());
                syslog.setIp(IpAddr.getIpAddress(request));
                String userAgent = request.getParameter("userAgent");
                if ("iOS".equals(userAgent)) {
                    //添加客户端类型
                    syslog.setClientType(3);
                    SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else if ("android".equals(userAgent)) {
                    syslog.setClientType(4);
                    SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else if ("pc".equals(userAgent)) {
                    syslog.setClientType(2);
                    SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
                    syslog.setClientVersion(Version.getParaValue());
                } else {
                    syslog.setClientType(1);
                    String clientVersion = request.getParameter("clientVersion");
                    if (clientVersion != null && clientVersion.length() > 0) {
                        syslog.setClientVersion(clientVersion);
                    } else {
                        syslog.setClientVersion(SystemInfoServiceImpl.softVersion);
                    }
                }
                syslog.setTime(new Date(System.currentTimeMillis()));
                syslogMapper.save(syslog);
                json.setFlag(0);
                json.setMsg("OK");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月5日
     * 方法介绍:   根据用户userID查询用户
     * 参数说明:   @param userId
     * 参数说明:   @return
     *
     * @return ToJson<Users>
     */
    @Override
    public Users getUsersByuserId(String userId) {
        Users user = usersMapper.getUsersByuserId(userId);
        if (user != null){

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
        }
        return user;
    }

    /* (non-Javadoc)
     * @see com.xoa.service.users.UsersService#selectFileUserSignerAll()
     */
    @Override
    public List<Users> selectFileUserSignerAll() {
        // TODO Auto-generated method stub
        return usersMapper.selectFileUserSignerAll();
    }

    /* (non-Javadoc)
     * @see com.xoa.service.users.UsersService#selectFileUserSigner(java.util.Map)
     */
    @Override
    public List<Users> selectFileUserSigner(Map<String, Object> mapUser) {
        // TODO Auto-generated method stub
        return usersMapper.selectFileUserSigner(mapUser);
    }

    @Override
    public ToJson<Users> singleSearch(String searchData) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            if (!StringUtils.checkNull(searchData)) {
                List<Users> users = usersMapper.singleSearch(searchData);
                json.setObj(users);
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("ok");
        }
        return json;
    }

    @Override
    public ToJson<Object> userAnalysis(String type) {
        List<Users> users = usersMapper.getAllInfo();
        ToJson<Object> data = new ToJson<>();
        HashMap<String, Integer> analysis = new HashMap<>();
        if ("age".equals(type)) {
            //遍历用户，分析每个用户的年龄
            Date temp = new Date();
            for (Users u : users) {
                Date birthday = u.getBirthday();
                if (birthday != null) {
                    //获取年龄
                    long years = (temp.getTime() - birthday.getTime()) / (1000 * 60 * 60 * 24) / 365;
                    int i = (int) (years) / 5;
                    if (i >= 0 && analysis.containsKey("age" + i * 5)) {
                        analysis.put("age" + i * 5, analysis.get("age" + i * 5) + 1);
                    } else {
                        analysis.put("age" + i * 5, 1);
                    }
                }
            }
            data.setObject(analysis);
            data.setFlag(0);
            return data;
        } else if ("sex".equals(type)) {
            for (Users u : users) {
                String sex = "0".equals(u.getSex()) ? "男" : "女";
                if (sex != "") {
                    if (analysis.containsKey(sex)) {
                        analysis.put(sex, analysis.get(sex) + 1);
                    } else {
                        analysis.put(sex, 1);
                    }
                }
            }
            data.setObject(analysis);
            data.setFlag(0);
            return data;
        } else {
            data.setMsg("参数错误");
        }
        data.setFlag(1);
        return data;
    }

    @Override
    public Users getUserByUserName(String userName) {
        return usersMapper.getUserByUserName(userName);
    }

    @Override
    public void deleteUserByDeptId(String deptId) {
        usersMapper.deleteUserByDeptId(deptId);
    }


    /**
     * 创建作者：牛江丽
     * 方法介绍：修改扩展信息，包括昵称、用户名片图片、讨论区签名档
     *
     * @param request
     * @param users
     * @return
     */
    @Override
    public ToJson<Users> editUserExt(HttpServletRequest request, MultipartFile imageFile, Users users, UserExt userExt) throws IllegalStateException {
        ToJson<Users> toJson = new ToJson<Users>(1, "error");
        try {
            if (imageFile != null) {
                String imageType = imageFile.getContentType();
                boolean b = allowUpload(imageType);
                if (!b) {
                    toJson.setMsg("图片格式不正确");
                    return toJson;
                }
            }
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String resourcePath = "ui/img/user";
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            users.setUid(usersTemp.getUid());
            //先查询是否已经上传了该头像，如果上传了删除后再上传，否则直接上传
            Users temp = usersMapper.findUsersByuserId(usersTemp.getUserId());
            if (temp != null) {
                if (!StringUtils.checkNull(temp.getPhoto())) {
                    File temp1 = new File(realPath + resourcePath + temp.getPhoto());
                    if (temp1.exists()) {
                        temp1.delete();
                    }
                }
            }
            //上传图片并进行修改数据库数据
            if (imageFile != null) {
                if (allowUpload(imageFile.getContentType())) {
                    String fileName = FileUploadUtil.rename(imageFile.getOriginalFilename());
                    File dir = new File(realPath + resourcePath);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    File file = new File(dir, fileName);
                    imageFile.transferTo(file);
                    users.setAvatar(fileName);
                }
            } else {
                users.setAvatar(usersTemp.getSex());
            }
            users.setAvatar128("");
            int count = usersMapper.editUser(users);
            userExt.setUid(usersTemp.getUid());
            userExt.setUserId(usersTemp.getUserId());
            count += userExtMapper.updateUserExtByUid(userExt);
            if (count > 1) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson editUserSign(HttpServletRequest request, String sign) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (!StringUtils.checkNull(users.getUserId())) {
            Users u = new Users();
            u.setUid(users.getUid());
            if (sign != null){
                if (sign.indexOf(".png") != -1)
                    u.setMyStatus(sign);
                else
                    u.setMyStatus(sign + "/signature.png");
            usersMapper.editUser(u);
        }
        }
        ToJson toJson = new ToJson();
        toJson.setFlag(0);
        toJson.setMsg("Ok");
        return toJson;
    }


    /**
     * 创建作者:   zlf
     * 创建日期:   2017年7月3日
     * 方法介绍:   插入和导入接口(修改于航宁所写接口以适应闵行区教育模块)
     * 参数说明:   @param  file
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    public ToJson<Users> insertImportUsersByEdu1(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String pw, String uPrivName) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            //读取配置文件,获取文件要存储的路径
            StringBuffer path = this.getPath();
            // 判断是否为空文件,此段可注释掉，改由前端判定
           /* if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                json.setFlag(1);
                return json;
            } else {*/
            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                String extName = fileName
                        .substring(fileName.lastIndexOf(".") + 1);// 文件后缀
                String newFileName = uuid + extName;//组合成新的文件名
                File dest = new File(path.toString(), newFileName);
                file.transferTo(dest);
                // 将文件上传成功后进行读取文件
                // 进行读取的路径
                String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                InputStream in = new FileInputStream(readPath);
                HSSFWorkbook excelObj = new HSSFWorkbook(in);
                HSSFSheet sheetObj = excelObj.getSheetAt(0);
                Row row = sheetObj.getRow(0);
                int colNum = row.getPhysicalNumberOfCells();
                int lastRowNum = sheetObj.getLastRowNum();
                List<Users> saveList = new ArrayList<Users>();
                int updateCount = 0;
                int insertCount = 0;
                Users entity = null;
                UserFunction userFunction = new UserFunction();
                for (int i = 1; i <= lastRowNum; i++) {
                    entity = new Users();
                    row = sheetObj.getRow(i);
                    if (row != null) {
                        for (int j = 0; j < colNum; j++) {
                            Cell cell = row.getCell(j);
                            if (cell != null) {
                                if (j != 5) {
                                    cell.setCellType(CellType.STRING);
                                }
                                switch (j) {
                                    case 0:
                                        if (cell.getCellType() == CellType.STRING) {
                                            entity.setByname(cell.getStringCellValue().trim());
                                        } else if (cell.getCellType() == CellType.NUMERIC) {
                                            entity.setByname(String.valueOf(cell.getNumericCellValue()).trim());
                                        }
                                        break;
                                    case 1:
                                        if (cell.getStringCellValue().trim().equals("")) {
                                            if (!pw.equals("")) {
                                                entity.setPassword(pw);
                                            }
                                        } else {
                                            entity.setPassword(cell.getStringCellValue().trim());
                                        }
                                        break;
                                    case 2:
                                        entity.setDeptName(cell.getStringCellValue().trim());
                                        break;
                                    case 3:
                                        entity.setUserName(cell.getStringCellValue().trim());
                                        break;
                                    case 4:
                                        String sex = cell.getStringCellValue().trim();
                                        if ("男".equals(sex)) {
                                            entity.setSex("0");
                                            entity.setAvatar("0");
                                        } else if ("女".equals(sex)) {
                                            entity.setSex("1");
                                            entity.setAvatar("1");
                                        }
                                        break;
                                    case 5:
                                        entity.setBirthday(cell.getDateCellValue());
                                        break;
                                    case 6:
                                        if (StringUtils.checkNull(cell.getStringCellValue().trim())) {
                                            entity.setUserPrivName(uPrivName);
                                        } else {
                                            entity.setUserPrivName(cell.getStringCellValue().trim());
                                        }
                                        break;
                                    case 7:
                                        entity.setUserNo(Integer.valueOf(cell.getStringCellValue() == "" ? "10" : cell.getStringCellValue().trim()));
                                        break;
                                    case 8:
                                        String postPrivName = cell.getStringCellValue().trim();
                                        if (postPrivName != null) {
                                            if ("全体".equals(postPrivName)) {
                                                entity.setPostPriv("1");
                                            } else {
                                                entity.setPostPriv("0");
                                            }
                                        } else {
                                            entity.setPostPriv("0");
                                        }
                                        break;
                                    case 9:
                                        entity.setMobilNo(cell.getStringCellValue().trim());
                                        break;
                                    case 10:
                                        entity.setBindIp(cell.getStringCellValue().trim());
                                        break;
                                    case 11:
                                        entity.setTelNoDept(cell.getStringCellValue().trim());
                                        break;
                                    case 12:
                                        entity.setFaxNoDept(cell.getStringCellValue().trim());
                                        break;
                                    case 13:
                                        entity.setAddHome(cell.getStringCellValue().trim());
                                        break;
                                    case 14:
                                        entity.setPostNoHome(cell.getStringCellValue().trim());
                                        break;
                                    case 15:
                                        entity.setTelNoHome(cell.getStringCellValue().trim());
                                        break;
                                    case 16:
                                        entity.setEmail(cell.getStringCellValue().trim());
                                        break;
                                    case 17:
                                        entity.setOicqNo(cell.getStringCellValue().trim());
                                        break;
                                    case 18:
                                        entity.setMsn(cell.getStringCellValue().trim());
                                        break;
                                    case 19:
                                        entity.setIdNumber(cell.getStringCellValue().trim());
                                        break;
                                    case 20:
                                        entity.setTraNumber(cell.getStringCellValue().trim());
                                        break;
                                    case 21:
                                        entity.setSubject(cell.getStringCellValue().trim());
                                        break;
                                }
                            }
                        }
                    }

                    // 判断是否存在相同用户名
                    Users usersByuserId = usersMapper.getUsersBybyname(entity.getByname());
                    if (usersByuserId != null && usersByuserId.getByname().equals(entity.getByname())) {
                        usersMapper.updateUserByName(entity);
                        entity.setSaveMsg("更新成功");
                        saveList.add(entity);
                        ++updateCount;
                    }

                    // 加密密码
                    if (entity.getPassword() != null) {
                        entity.setPassword(getEncryptString(entity.getPassword().trim()));
                    } else {
                        entity.setPassword("tVHbkPWW57Hw.");
                    }
                    // 添加姓名索引
                    if (entity.getUserName() != null) {
                        String fistSpell = PinYinUtil.getFirstSpell(entity.getUserName());
                        StringBuffer sb = new StringBuffer();
                        for (int j = 0; j < fistSpell.length(); j++) {
                            sb.append(fistSpell.charAt(j) + "*");
                        }
                        entity.setUserNameIndex(sb.toString());
                    }
                    // 获取部门id
                    if (entity.getDeptName() != null) {
                        Department d = new Department();
                        d.setDeptName(entity.getDeptName());
                        List<String> nameList = departmentMapper.getDeptIdByDeptName(entity.getDeptName());
                        String deptId = "";
                        if (nameList.size() > 0) {
                            deptId = nameList.get(0);
                        }
                        if (deptId != null && deptId != "") {
                            entity.setDeptId(Integer.valueOf(deptId));
                        } else {
                            entity.setSaveMsg("失败，部门不存在");
                            saveList.add(entity);
                            continue;
                        }
                    }
                    // 获取角色信息
                    if (entity.getUserPrivName() != null) {
                        UserPriv userPriv = userPrivMapper.getUserPrivByName(entity.getUserPrivName());
                        if (userPriv != null) {
                            entity.setUserPriv(userPriv.getUserPriv());
                            entity.setUserPrivNo(userPriv.getPrivNo());
                            if (userPriv.getFuncIdStr() != null) {
                                userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
                            } else {
                                userFunction.setUserFunCidStr("1,");
                            }
                        } else {
                            List<UserPriv> alluserPriv = userPrivMapper.getAlluserPriv(null);
                            Collections.sort(alluserPriv, new Comparator<UserPriv>() {
                                @Override
                                public int compare(UserPriv o1, UserPriv o2) {
                                    if (o1.getPrivNo() > o2.getPrivNo()) {
                                        return 1;
                                    } else if (o1.getPrivNo() < o2.getPrivNo()) {
                                        return -1;
                                    } else {
                                        return 0;
                                    }
                                }
                            });
                            UserPriv userPriv1 = alluserPriv.get(alluserPriv.size() - 1);
                            entity.setUserPriv(userPriv1.getUserPriv());
                            entity.setUserPrivNo(userPriv1.getPrivNo());
                            entity.setUserPrivName(userPriv1.getPrivName());
                            if (userPriv1.getFuncIdStr() != null) {
                                userFunction.setUserFunCidStr(userPriv1.getFuncIdStr());
                            } else {
                                userFunction.setUserFunCidStr("1,");
                            }
                        }
                    }
                    entity.setNotLogin(0);
                    entity.setImRange(1);
                    Users userByName = usersMapper.findUserByName(entity.getByname());
                    if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                        // 更新
                        entity.setUid(userByName.getUid());
                        entity.setUserId(userByName.getUserId());
                        usersMapper.editUser(entity);

                        userFunction.setUid(entity.getUid());
                        userFunction.setUserId(entity.getUserId());
                        userFunctionMapper.updateUserFun(userFunction);

                        entity.setSaveMsg("更新成功");
                        saveList.add(entity);
                        ++updateCount;
                    } else if (userByName == null) {
                        if (StringUtils.checkNull(entity.getByname())) {
                            //获取规则生成userId的最大值
                            String maxUserId = usersMapper.getMaxUserId();
                            //获取流水号
                            String serial = maxUserId.substring(maxUserId.length() - 3);
                            //获取规则
                            String rule = maxUserId.substring(0, maxUserId.length() - 3);
                            int newSerial = Integer.parseInt(serial) + 1;
                            serial = org.apache.commons.lang3.StringUtils.repeat("0", 3 - String.valueOf(newSerial).length()) + newSerial;
                            String userId = rule + serial;
                            entity.setByname(userId);
                        } else {
                            entity.setUserId(entity.getByname());
                        }

                        // 保存用户
                        usersMapper.insert(entity);
                        entity.setUserId(entity.getUid().toString());
                        usersMapper.editUser(entity);

                        //entity.setUserId(entity.getUid().toString());
                        // usersMapper.editUser(entity);

                        UserExt userExt = new UserExt();
                        userExt.setDutyType(entity.getDutyType());
                        userExt.setUid(entity.getUid());
                        userExt.setUserId(entity.getUserId());
                        userExtMapper.addUserExt(userExt);

                        userFunction.setUid(entity.getUid());
                        userFunction.setUserId(entity.getUserId());
                        userFunctionMapper.insertUserFun(userFunction);

                        entity.setSaveMsg("保存成功");
                        saveList.add(entity);
                        ++insertCount;
                    }
                }
                if (saveList != null && saveList.size() > 0 && saveList.get(0) != null) {
                    saveList.get(0).setInsertCount(insertCount);
                    saveList.get(0).setUpdateCount(updateCount);
                }

                // 设置状态并删除文件
                json.setObj(saveList);
                json.setFlag(0);
                json.setMsg("ok");
                dest.delete();
            } else {
                json.setMsg("文件类型不正确！");
                json.setFlag(1);
                return json;
            }

        } catch (Exception e) {
            //读取配置文件,获取文件要存储的路径
            StringBuffer path = this.getPath();
            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                String extName = fileName
                        .substring(fileName.lastIndexOf(".") + 1);// 文件后缀
                String newFileName = uuid + extName;//组合成新的文件名
                File dest = new File(path.toString(), newFileName);
                dest.delete();
            }
            e.printStackTrace();
            json.setMsg("数据保存异常");
            json.setFlag(1);
        }
        return json;
    }

    //判读当前系统,读取配置文件,返回路径
    public StringBuffer getPath() {
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer path = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            path = path.append(rb.getString("upload.win"));
        } else {
            path = path.append(rb.getString("upload.linux"));
        }
        return path;
    }

    @Override
    public void insetErrLog(String userName) {
        Syslog sysLog = new Syslog();
        sysLog.setLogId(0);
        sysLog.setUserId(userName);
        String ip = IpAddr.getInternetIp();
        sysLog.setTime(new Date());
        sysLog.setIp(ip);
        sysLog.setType(2);
        sysLog.setRemark("");
        syslogMapper.save(sysLog);
    }

    @Override
    @Transactional
    public AjaxJson insertImportUsersByEdu(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String pw, String uPrivName, String rule) {

        AjaxJson ajaxJson = new AjaxJson();
        try {
            //读取配置文件,获取文件要存储的路径
            StringBuffer path = this.getPath();
            // 判断是否为空文件,此段可注释掉，改由前端判定
            if (file.isEmpty()) {
                ajaxJson.setMsg("请上传文件！");
                ajaxJson.setFlag(false);
                return ajaxJson;
            }
            String fileName = file.getOriginalFilename();
            if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                //读取Excel数据到List中
                List<Map<String, Object>> list = new ExcelRead().readExcel(file);
                Users user = null;
                //获取规则生成userId的最大值
                String maxUserId = usersMapper.getMaxUserId();

                List<Users> saveList = new ArrayList<Users>();
                UserFunction userFunction = new UserFunction();
                int updateCount = 0;
                int insertCount = 0;
                //list中存的就是excel中的数据，可以根据excel中每一列的值转换成你所需要的值（从0开始），如：
                for (int j = 0; j < list.size(); j++) {
                    user = new Users();
                    Map<String, Object> map = list.get(j);
                    //根据身份证号查询用户
                    String IdNumber = map.get("身份证号").toString();
                    // Users usersByIdNumber = usersMapper.getUserByIdNumber(IdNumber);
                    if (StringUtils.checkNull(map.get("用户名") == null ? null : map.get("用户名").toString())) {
                        //获取流水号
                        String serial = maxUserId.substring(maxUserId.length() - 3);
                        //获取规则
                        String rule1 = maxUserId.substring(0, maxUserId.length() - 3);
                        int newSerial = Integer.parseInt(serial) + 1;
                        serial = org.apache.commons.lang3.StringUtils.repeat("0", 3 - String.valueOf(newSerial).length()) + newSerial;
                        String byName = rule1 + serial;
                        maxUserId = byName;
                        user.setByname(byName);
                        Users usersByIdNumber = usersMapper.getUserByIdNumber(IdNumber);
                        if (usersByIdNumber == null) {
                        } else {
                            user.setByname(usersByIdNumber.getByname());
                        }
                    } else {
                        user.setByname(map.get("用户名").toString());
                    }


                    user.setDeptName(map.get("部门").toString());
                    user.setUserName(map.get("姓名").toString());

                    String sex = map.get("性别").toString().trim();
                    if ("男".equals(sex)) {
                        user.setSex("0");
                        user.setAvatar("0");
                    } else if ("女".equals(sex)) {
                        user.setSex("1");
                        user.setAvatar("1");
                    } else {
                        user.setSaveMsg("失败，性别输入错误！");
                        saveList.add(user);
                        continue;
                    }
                    if (StringUtils.checkNull(map.get("角色").toString().trim())) {
                        user.setUserPrivName(uPrivName);
                    }
                    user.setUserPrivName(map.get("角色").toString().trim());
                    user.setMobilNo(map.get("手机").toString().trim());
                    user.setTelNoDept(map.get("工作电话").toString().trim());
                    user.setEmail(map.get("E-mail").toString().trim());
                    user.setOicqNo(map.get("QQ").toString().trim());
                    user.setIdNumber(map.get("身份证号").toString().trim());
                    user.setTraNumber(map.get("培训编号").toString().trim());
                    user.setSubject(map.get("学科").toString().trim());
                    user.setPassword(pw);

                    // 加密密码
                    if (user.getPassword() != null) {
                        user.setPassword(getEncryptString(user.getPassword().trim()));
                    }
                    // 添加姓名索引
                    if (user.getUserName() != null) {
                        String fistSpell = PinYinUtil.getFirstSpell(user.getUserName());
                        StringBuffer sb = new StringBuffer();
                        for (int k = 0; k < fistSpell.length(); k++) {
                            sb.append(fistSpell.charAt(k) + "*");
                        }
                        user.setUserNameIndex(sb.toString());
                    }


                    // 获取部门id
                    if (user.getDeptName() != null) {
                        Department d = new Department();
                        d.setDeptName(user.getDeptName());
                        List<String> nameList = departmentMapper.getDeptIdByDeptName(user.getDeptName());
                        String deptId = "";
                        if (nameList.size() > 0) {
                            deptId = nameList.get(0);
                        }
                        if (!StringUtils.checkNull(deptId)) {
                            user.setDeptId(Integer.valueOf(deptId));
                        } else {
                            user.setSaveMsg("失败，部门不存在");
                            saveList.add(user);
                            continue;
                        }
                    }
                    // 获取角色信息
                    if (user.getUserPrivName() != null) {
                        UserPriv userPriv = userPrivMapper.getUserPrivByName(user.getUserPrivName());
                        if (userPriv != null) {
                            user.setUserPriv(userPriv.getUserPriv());
                            user.setUserPrivNo(userPriv.getPrivNo());

                            if (userPriv.getFuncIdStr() != null) {
                                userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
                            } else {
                                userFunction.setUserFunCidStr("1,");
                            }
                        } else {
                            user.setSaveMsg("失败，角色不存在");
                            saveList.add(user);
                            continue;
                        }
                    } else {
                        user.setSaveMsg("失败，角色未填写");
                        saveList.add(user);
                        continue;
                    }
                    user.setNotLogin(0);
                    user.setImRange(1);


                    // 判断是否存在相同用户名
                    Users userByName = usersMapper.importUserByName(user.getByname());
                    if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                        // 更新
                        user.setUid(userByName.getUid());
                        user.setUserId(userByName.getUserId());
                        usersMapper.editUser(user);

                        userFunction.setUid(user.getUid());
                        userFunction.setUserId(user.getUserId());
                        userFunctionMapper.updateUserFun(userFunction);

                        user.setSaveMsg("更新成功");
                        saveList.add(user);
                        ++updateCount;
                    } else if (userByName == null) {
                        // 保存用户
                        usersMapper.insert(user);

                        user.setUserId(user.getUid().toString());
                        usersMapper.editUser(user);

                        UserExt userExt = new UserExt();
                        userExt.setDutyType(user.getDutyType());
                        userExt.setUid(user.getUid());
                        userExt.setUserId(user.getUserId());
                        userExtMapper.addUserExt(userExt);

                        userFunction.setUid(user.getUid());
                        userFunction.setUserId(user.getUserId());
                        userFunctionMapper.insertUserFun(userFunction);

                        user.setSaveMsg("保存成功");
                        saveList.add(user);
                        ++insertCount;
                    }
                }

                if (saveList != null && saveList.size() > 0 && saveList.get(0) != null) {
                    saveList.get(0).setInsertCount(insertCount);
                    saveList.get(0).setUpdateCount(updateCount);
                }

                // 设置状态
                ajaxJson.setObj(saveList);
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("ok");
            } else {
                ajaxJson.setMsg("文件类型不正确！");
                ajaxJson.setFlag(false);
                return ajaxJson;
            }
        } catch (Exception e) {
            ajaxJson.setMsg(e.getMessage());
            ajaxJson.setFlag(false);
        }
        return ajaxJson;
    }

    //判断是否存在部门，不存在则创建
    public Department createDep(String deptName) {
        List<String> nameList = departmentMapper.getDeptIdByDeptName(deptName.trim());
        String deptId = "";
        if (nameList.size() > 0) {
            deptId = nameList.get(0);
        }
        Department department = new Department();
        if (StringUtils.checkNull(deptId)) {

            department.setDeptName(deptName);
            departmentMapper.insertDept(department);

        }
        return department;
    }

    //byname生成方法
    public String getByName() {
        //获取规则生成userId的最大值
        String maxUserId = usersMapper.getMaxUserId();
        //获取流水号
        String serial = maxUserId.substring(maxUserId.length() - 3);
        //获取规则
        String rule = maxUserId.substring(0, maxUserId.length() - 3);
        int newSerial = Integer.parseInt(serial) + 1;
        serial = org.apache.commons.lang3.StringUtils.repeat("0", 3 - String.valueOf(newSerial).length()) + newSerial;
        String byName = rule + serial;
        return byName;
    }


    public List<Users> getUsersBydepIds(String deptIds) {
        if (StringUtils.checkNull(deptIds)) {
            return null;
        }
        List<Users> l = new ArrayList<Users>();
        String[] temp = deptIds.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                Users users = usersMapper.findUsersByuserId(temp[i]);
                if (users != null) {
                    l.add(users);
                }
            }
        }
        return l;


    }


    @Override
    public List<Users> reAllPrivUser(String privUser, String privDept, String privRole) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("privUser", privUser);
        map.put("privDept", privDept);
        map.put("privRole", privRole);
        List<Users> list = usersMapper.getAllPrivUser(map);
        return list;

     /*   String[] user = privUser.split(",");
        String[] dept = privDept.split(",");
        String[] role = privRole.split(",");
        List<Users> listUser = this.getUserByuserId(privUser);
        List<Users> listDept = this.getUserByDeptIds(privDept, 1);
        List<Users> listRole = this.getUserByDeptIds(privRole, 2);
        if (listDept!=null && listDept.size()>0){
            listUser.addAll(listDept);
        }
        if (listRole!=null && listRole.size()>0){
            listUser.addAll(listRole);
        }
        Map<String, Users> map = new HashMap<String, Users>();
        List<Users> valueList =new ArrayList<Users>();
        if (listUser!=null && listUser.size()>0){
            for (Users users : listUser) {
                map.put(users.getUserId(), users);
            }
            Collection<Users> valueCollection = map.values();
            valueList = new ArrayList<Users>(valueCollection);
        }
        return valueList;*/
    }


    @Override
    public String reAllName(List<Users> list) {
        StringBuffer stringBuffer = new StringBuffer();
        for (Users users : list) {
            stringBuffer.append(users.getUserId()).append(",");
        }
        return stringBuffer.toString();
    }

    @Override
    public void updateLoginTime(Users users) {
        usersMapper.updateLoginTime(users);
    }

    @Override
    public List<Users> LoginUserList() {

        return usersMapper.LoginUserList();
    }

    @Override
    public BaseWrapper uploadImg(HttpServletRequest request, MultipartFile file) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            if (usersTemp == null || usersTemp.getUid() == null) {
                wrapper.setFlag(false);
                wrapper.setMsg("用户信息不正确");
                return wrapper;
            }
            if (file != null) {
                String imageType = file.getContentType();
                boolean b = allowUpload(imageType);
                if (!b) {
                    wrapper.setFlag(false);
                    wrapper.setMsg("图片格式不正确");
                    return wrapper;
                }
                String fileName = file.getOriginalFilename();

                if (!FileUploadUtil.checkFilePicture(fileName)) {
                    wrapper.setFlag(false);
                    wrapper.setMsg("上传文件后缀名不可用");
                    return wrapper;
                }

            } else {
                wrapper.setFlag(false);
                wrapper.setMsg("图片不存在");
                return wrapper;
            }
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String resourcePath = "ui/img/user";
            Users users = new Users();
            //上传图片并进行修改数据库数据
            String fileName = FileUploadUtil.rename(file.getOriginalFilename());
            File dir = new File(realPath + resourcePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File realfile = new File(dir, fileName);
            file.transferTo(realfile);
            String fileName128 = FileUploadUtil.rename(fileName, "s");
            String newImg = FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, fileName128, dir.getAbsolutePath());

           /* users.setAvatar(fileName128);
            users.setAvatar128(newImg);
            users.setUid(usersTemp.getUid());
            int count = usersMapper.editUser(users);
*/
            wrapper.setFlag(true);
            wrapper.setData(fileName128);
            wrapper.setMsg(fileName);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wrapper;
    }

    @Override
    public ToJson<Users> editUserExtNew(HttpServletRequest request, Users users, UserExt userExt) {
        ToJson<Users> toJson = new ToJson<Users>(1, "error");
        try {
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String resourcePath = "ui/img/user";
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            users.setUid(usersTemp.getUid());
            //先查询是否已经上传了该头像，如果上传了删除后再上传，否则直接上传
            Users temp = usersMapper.findUsersByuserId(usersTemp.getUserId());
            if (temp != null) {
                if (!StringUtils.checkNull(temp.getPhoto())) {
                    File temp1 = new File(realPath + resourcePath + temp.getPhoto());
                    if (temp1.exists()) {
                        temp1.delete();
                    }
                }
            }
            int count = usersMapper.editUser(users);
            userExt.setUid(usersTemp.getUid());
            userExt.setUserId(usersTemp.getUserId());
            count += userExtMapper.updateUserExtByUid(userExt);
            if (count > 1) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }


    @Override
    public ToJson<Users> editUserImg(HttpServletRequest request, Users users, UserExt userExt) {
        ToJson<Users> toJson = new ToJson<Users>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        users.setUid(usersTemp.getUid());
        try {
            int count = usersMapper.editUserImg(users);
            userExt.setUid(usersTemp.getUid());
            userExt.setUserId(usersTemp.getUserId());
            count += userExtMapper.updateUserExtByUid(userExt);
            if (count > 0) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<Users> bindUserInfo(HttpServletRequest request, Integer uid, String cardNumber) {
        ToJson<Users> json = new ToJson<>(1, "error");
        Users users = new Users();
        try {
            if (uid != null) {
                users.setSecureKeySn(cardNumber);
                users.setUid(uid);
                usersMapper.bindUserInfo(users);
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Users> imputBindUserInfo(HttpServletRequest request, HttpServletResponse response, MultipartFile file) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
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
            int success = 0;
            // 判断是否为空文件
            if (file.isEmpty()) {
                json.setMsg("请上传文件！");
                json.setFlag(1);
                return json;
            } else {
                String fileName = file.getOriginalFilename();
                if (fileName.endsWith(".xls") || fileName.endsWith(".xlsx")) {
                    String uuid = UUID.randomUUID().toString().replaceAll("-", "");
                    int pos = fileName.indexOf(".");
                    String extName = fileName.substring(pos);
                    String newFileName = uuid + extName;
                    File dest = new File(path.toString(), newFileName);
                    file.transferTo(dest);
                    // 将文件上传成功后进行读取文件
                    // 进行读取的路径
                    String readPath = path.append(System.getProperty("file.separator")).append(newFileName).toString();
                    InputStream in = new FileInputStream(readPath);
                    HSSFWorkbook excelObj = new HSSFWorkbook(in);
                    HSSFSheet sheetObj = excelObj.getSheetAt(0);
                    HSSFRow row = sheetObj.getRow(0);
                    int colNum = row.getPhysicalNumberOfCells();
                    int lastRowNum = sheetObj.getLastRowNum();

                    Users entity = null;
                    for (int i = 1; i <= lastRowNum; i++) {
                        entity = new Users();
                        row = sheetObj.getRow(i);
                        if (row != null) {
                            for (int j = 0; j < colNum; j++) {
                                Cell cell = row.getCell(j);
                                if (cell != null) {
                                    switch (j) {
                                        case 0:
                                            entity.setByname(cell.getStringCellValue());
                                            Users users = usersMapper.findUserByName(entity.getByname());
                                            entity.setUid(users.getUid());
                                            break;
                                        case 1:
                                            entity.setSecureKeySn(cell.getStringCellValue());
                                            break;
                                    }
                                }
                            }
                            usersMapper.bindUserInfo(entity);
                        }
                    }
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("数据保存异常");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public String getUserNamesByUserIds(String userIds) {
        String[] userArray = userIds.split(",");
        List<Users> usersList = usersMapper.getUsersByUserIds(userArray);
        StringBuilder stringBuilder = new StringBuilder();
        for (Users users : usersList) {
            if (users != null) {
                String userName = users.getUserName();
                stringBuilder.append(userName).append(",");
            }
        }
        return stringBuilder.toString();
    }

    @Override
    public String getUserNamesByUids(String Uids) {
        String[] userArray = Uids.split(",");
        List<Users> usersList = usersMapper.findUserNames(userArray);
        StringBuilder stringBuilder = new StringBuilder();
        for (Users users : usersList) {
            if (users != null) {
                String userName = users.getUserName();
                stringBuilder.append(userName).append(",");
            }
        }
        return stringBuilder.toString();
    }

    /**
     * 创建作者:  牛江丽
     * 创建日期:   2017-11-22
     * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
     * 参数说明:   @param name
     * 参数说明:   @return List<Users>
     */
    @Override
    public ToJson<Users> getByName(String name) {
        ToJson<Users> json = new ToJson<>(1, "error");
        try {
            List<Users> list = usersMapper.getByName(name);
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 创建作者:  郭富强
     * 创建日期:   2018-1-16
     * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
     * 参数说明:   @param name
     * 参数说明:   @return List<String>
     */
    @Override
    public ToJson<Users> getuserNameByDeptId(Integer deptId) {

        ToJson<Users> toJson = new ToJson<Users>(1, "error");
        List<Users> list = usersMapper.getuserNameByDeptId(deptId);
        if (list != null) {

            toJson.setMsg("查询成功");
            toJson.setFlag(0);
            toJson.setObj(list);
        } else {
            toJson.setMsg("数据为空");
            toJson.setFlag(1);
        }


        return toJson;
    }

    @Override
    public ToJson<Integer> selectuidByName(String userName) {
        List<Integer> list = usersMapper.selectuidByName(userName);

        ToJson toJson = new ToJson();

        if (list != null) {
            toJson.setMsg("查询成功");
            toJson.setObj(list);
        }

        return toJson;
    }

    /**
     * @return java.lang.String
     * @Author 廉立深
     * @Description
     * @Date 17:49 2020/5/25
     * @Param [userNames]
     **/
    @Override
    public String fundUserIdByUserName(String userNames) {
        if (StringUtils.checkNull(userNames)) {
            return "";
        }
        String trim = userNames.replaceAll("[\\s\\u00A0]+", "").trim();
        String[] names = trim.split(",");
        String s = usersMapper.fundUserIdByUserName(names);
        if (!StringUtils.checkNull(s)) {
            return s;
        }
        return "";
    }

    @Override
    public ToJson<Users> getUserDepartmentUserexe(String deptId, String dutyType,
                                                  String uids) {
        ToJson<Users> toJson = new ToJson<Users>(1, "ERROR");
        Map<String, Object> map = new HashMap<String, Object>();
        //部门id
        map.put("deptId", deptId);
        //考勤类型
        map.put("dutyType", dutyType);
        //用户id
        map.put("uid", uids);
        List<Users> list = usersMapper.getUserDepartmentUserexe(map);

        if (list != null) {
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            toJson.setObj(list);

        } else {
            toJson.setFlag(1);
            toJson.setMsg("数据为空");

        }

        return null;
    }

    @Override
    public BaseWrapper checkUserCount(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        int authUser = systemInfoService.getAuthUser(request);
        if (authUser == 0) {
            authUser = 30;
        }
        int userCount = getUserCount();
        if (userCount < authUser) {
            baseWrapper.setMsg("用户成功");
            baseWrapper.setFlag(true);
        } else {
            baseWrapper.setMsg("用户新建数量超过限制");
            baseWrapper.setFlag(false);

        }
        return baseWrapper;
    }

    @Override
    public BaseWrapper UsersByUidCorrection() {
        //获取全部部门
        List<Department> departmentList = departmentMapper.getAllDepartment();
        for (Department department : departmentList) {
            if (!StringUtils.checkNull(department.getManager())) {
                String uidList1 = usersMapper.UsersByUidCorrection1(department.getDeptId());
                department.setManager(uidList1);
            }
            if (!StringUtils.checkNull(department.getAssistantId())) {
                String uidList2 = usersMapper.UsersByUidCorrection2(department.getDeptId());
                department.setAssistantId(uidList2);
            }
            if (!StringUtils.checkNull(department.getLeader1())) {
                String uidList3 = usersMapper.UsersByUidCorrection3(department.getDeptId());
                department.setLeader1(uidList3);

            }
            if (!StringUtils.checkNull(department.getLeader2())) {
                String uidList4 = usersMapper.UsersByUidCorrection4(department.getDeptId());
                department.setLeader2(uidList4);
            }
            departmentMapper.editDept(department);
        }
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        baseWrapper.setMsg("ok");

        return baseWrapper;
    }

    @Override
    public ToJson<Users> correctUsers(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    final String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
                    ContextHolder.setConsumerType("xoa" + sqlType);
                    List<Users> allUsers = usersMapper.getAlluser(null);
                    for (Users user : allUsers) {
                        String userName = user.getUserName();
                        if (!StringUtils.checkNull(userName.trim())) {
                            String firstSpell = PinYinUtil.getFirstSpell(userName);
                            StringBuffer sb = new StringBuffer();
                            for (int j = 0; j < firstSpell.length(); j++) {
                                sb.append(firstSpell.charAt(j) + "*");
                            }
                            if (!sb.toString().equals(user.getUserNameIndex())) {
                                user.setUserNameIndex(sb.toString());
                                usersMapper.editUser(user);
                            }
                            if (StringUtils.checkNull(user.getUserPrivName())) {
                                Integer userPriv = user.getUserPriv();
                                if (userPriv != null) {
                                    UserPriv userPriv1 = userPrivMapper.selectByPrimaryKey(userPriv);
                                    if (userPriv1 != null) {
                                        user.setUserPrivNo(userPriv1.getPrivNo());
                                        user.setUserPrivName(userPriv1.getPrivName());
                                        usersMapper.editUser(user);
                                    }
                                }
                            }
                        }
                    }
                }
            });
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public List<Users> getUsersByPId(int pId) {
        return usersMapper.getUsersByPId(pId);
    }

    @Override
    public ToJson<Map> getPwRule() {
        ToJson<Map> json = new ToJson<>();
        try {
            List<SysPara> theSysParam = sysParaMapper.getTheSysParam("SEC_PASS_MIN");
            List<SysPara> theSysParam1 = sysParaMapper.getTheSysParam("SEC_PASS_MAX");
            Map<String, Object> map = new HashMap<String, Object>();
            if (theSysParam != null && theSysParam.size() > 0) {
                map.put("secPassMin", theSysParam.get(0).getParaValue());
            }
            if (theSysParam1 != null && theSysParam1.size() > 0) {
                map.put("secPassMax", theSysParam1.get(0).getParaValue());
            }
            json.setObject(map);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            L.e(e.getMessage());
            json.setFlag(1);
            json.setMsg("err:" + e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Object> getOnlineMap(HttpServletRequest request) {
        ToJson<Object> json = new ToJson<Object>();
        List<String> list = usersMapper.getOnline();
        Map<String, Object> map = new HashMap<String, Object>();
        for (String string : list) {
            map.put(string, string);
        }
        json.setObject(map);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<Users> getOnlinePeople(HttpServletRequest request) {
        List<Users> users = new ArrayList<Users>();
        ToJson<Users> json = new ToJson<Users>();

        // Map<String, Object> userCountMap = loginController.userCountMap;
        //获取在线人员更换为从数据库中查询,返回userID
        // List<String> userCountMap = usersMapper.getOnline();
        Map map = new HashMap();
        map.put("jobId", request.getParameter("jobId")); //岗位
        map.put("postId", request.getParameter("postId")); //职务
        List<String> userCountMap = usersMapper.getOnlineMap(map);

        // 添加分级机构筛选条件，管理员能看到所有，如果设置了分级机构普通用户只能看到本分级机构下的在线的用户
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
//        HierarchicalGlobal globalId = hierarchicalGlobalMapper.selectAllAuth(usersTemp.getUserId(), usersTemp.getDeptId(), usersTemp.getUserPriv());
//        boolean flag = usersTemp.getUserPriv()==1 || globalId != null ? true : false;

        if (userCountMap != null) {
            // Iterator it = userCountMap.entrySet().iterator();
            if (departmentService.checkOrgFlag(usersTemp) != 2) {
                StringBuffer stringBuffer = new StringBuffer();
                for (String userId : userCountMap) {
                   /* Map.Entry entry = (Map.Entry) it.next();
                    String userId = entry.getKey().toString();*/
                   /* Users usersByuserId = usersMapper.getUsersByuserId(userId);
                    users.add(usersByuserId);*/
                    stringBuffer.append(userId).append(",");
                }
                users = this.getUserByuserId(stringBuffer.toString());
            } else {
                List<Department> departs = new ArrayList<>();
                Department classifyOrg = getClassifyOrgbyDeptId(usersTemp.getDeptId());
                departs.add(classifyOrg);
                getChild(departs, classifyOrg.getDeptId());
                for (String userId : userCountMap) {
                   /* Map.Entry entry = (Map.Entry) it.next();
                    String userId = entry.getKey().toString();*/
                    Users usersByuserId = usersMapper.getUsersByuserId(userId);
                    for (Department depart : departs) {
                        if (usersByuserId.getDeptId().equals(depart.getDeptId())) {
                            users.add(usersByuserId);
                        }
                    }
                }
            }
        }
        //返回结果中去除三员角色的用户和系统超级管理员、与内容密级不符的用户
        securityApprovalService.removeSecrecyUsers(users,null);

        json.setObj(users);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    private Department getClassifyOrgbyDeptId(Integer deptId) {
        Department classifyOrgbyDeptId = departmentMapper.getClassifyOrgbyDeptId(deptId);
        if (classifyOrgbyDeptId != null && classifyOrgbyDeptId.getClassifyOrg() != 1 && classifyOrgbyDeptId.getDeptParent() != 0) {
            classifyOrgbyDeptId = getClassifyOrgbyDeptId(classifyOrgbyDeptId.getDeptParent());
        }
        return classifyOrgbyDeptId;
    }

    private void getChild(List<Department> departs, Integer detpd) {
        List<Department> chDept = departmentMapper.selectObjectByParent(detpd);
        if (chDept.size() >= 0) {
            for (Department de : chDept) {
                if (!departs.contains(de)) {
                    departs.add(de);
                    getChild(departs, de.getDeptId());
                }
            }
        }
    }

    @Override
    public ToJson<Object> updatePassword() {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        try {
            List<Users> users = usersMapper.selectUserByTime();
            String password = "jinhuijiu";
            String encryPwd = getEncryptString(password);
            StringBuffer stringBuffer = new StringBuffer();
            Map<String, Object> map = new HashedMap();
            for (Users user : users) {
                String lastPassTime = DateFormat.getCurrentTime();
                Users newUser = new Users();
                newUser.setUid(user.getUid());
                stringBuffer.append(user.getUid() + ",");
            }
            String uids = stringBuffer.substring(0, stringBuffer.toString().length() - 1);
            map.put("password", encryPwd);
            map.put("uids", uids);
            int i = usersMapper.batchUpdatePwd(map);
            if (i > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);

        }

        return json;
    }

    @Override
    public ToJson<Users> updatemobile() {
        ToJson<Users> json = new ToJson<Users>(1, "err");
        try {
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }


        return json;
    }

    @Override
    public ToJson<Users> selNowUsers(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            List<Users> userByDeptId = usersMapper.getUserByDeptId(sessionInfo);
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:" + e);
        }
        return json;
    }

    @Override
    public ToJson<Object> selectIsExistUser(String byname, String uid) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        // 查询是否有重复用户名用户
        Users usersByuserId = usersMapper.getUsersBybyname(byname);
        if (uid != null && uid != "") {
            if (usersByuserId != null) {
                if (String.valueOf(usersByuserId.getUid()).equals(uid)) {
                    json.setFlag(1);
                    json.setMsg("ok");
                } else {
                    json.setFlag(0);
                    json.setMsg("err");
                }
            } else {
                json.setFlag(1);
                json.setMsg("ok");
            }
        } else {
            if (usersByuserId == null) {
                json.setFlag(1);
                json.setMsg("ok");
            } else {
                json.setFlag(0);
                json.setMsg("err");
            }
        }
        return json;
    }

    @Override
    public ToJson<Users> getNewChDept(HttpServletRequest request, Integer deptId) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            //查出全部部门的集合
            List<Department> departmentList = new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer = new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(deptId, stringBuffer, departmentList);
            Department deptById = departmentMapper.getDeptById(deptId);
            List<Users> userByDeptId = new ArrayList<Users>();
            if (!StringUtils.checkNull(deptIds)) {
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = removeStr.split(",");
                //userByDeptId = usersMapper.selectUserByDeptIds(split);
                userByDeptId = usersMapper.selectUserByDeptIdinfo(split);
                if (userByDeptId != null && userByDeptId.size() > 0) {
                    for (Users u : userByDeptId) {
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                    }
                }
            }
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:" + e);
        }
        return json;
    }


    @Override
    public ToJson<Department> getNewChAllDept(HttpServletRequest request, String deptIds) {
        ToJson<Department> json = new ToJson<Department>();
        try {
            List maplist = new ArrayList();
            for (String deptId : deptIds.split(",")) {

                Map<String, Object> map = new HashMap<String, Object>();
                if (deptId != null && !deptId.equals(0)) {
                    map = deptMapper.get(Integer.valueOf(deptId));
                } else {
                    map.put("deptId", 0);
                }

                if (map != null) {
                    map.put("jobId", request.getParameter("jobId")); //岗位
                    map.put("postId", request.getParameter("postId")); //职务
                }

                map = NewRecursionSelectDeptUser1(map);
                maplist.add(map);
            }
            json.setObject(maplist);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:" + e);
        }
        return json;
    }


    public Map<String, Object> NewRecursionSelectDeptUser1(Map<String, Object> department) {

        List<Map<String, Object>> departmentList = deptMapper.list(Integer.parseInt(department.get("deptId").toString()));

        Integer deptId = Integer.parseInt(department.get("deptId").toString());
        String jobId = null;
        String postId = null;
        if (department.get("jobId") != null && department.get("postId") != null) {
            jobId = (String) department.get("jobId");
            postId = (String) department.get("postId");
        }
        List<Users> userByDeptId = usersMapper.findUserByDeptId(deptId, jobId, postId);
        //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
        securityApprovalService.removeSecrecyUsers(userByDeptId,null);
        department.put("users", userByDeptId);
        if (departmentList != null && departmentList.size() > 0) {

            for (Map<String, Object> m : departmentList) {
                m.put("Map", department.get("map"));
                m.put("jobId", jobId); //岗位
                m.put("postId", postId); //职务

                NewRecursionSelectDeptUser1(m);
            }
            department.put("child", departmentList);
            department.put("nodes", departmentList);//前端所需参数添加

        }
        department.put("id",department.get("deptId"));
        department.put("text",department.get("deptName"));
        department.put("pId",department.get("deptParent"));
        return department;
    }

    @Override
    public ToJson<UserPriv> getUserByUserPriv(HttpServletRequest request, Integer userPriv) {
        ToJson<UserPriv> json = new ToJson<UserPriv>();
        try {
            List<Users> usersByUserPriv = usersMapper.getUsersByUserPriv(String.valueOf(userPriv));
            //查询角色
            UserPriv userPrivModel = userPrivMapper.selectByPrimaryKey(userPriv);
            //查询辅助角色用户
            userPrivModel.setUsers(usersByUserPriv);
            List<Users> usersByUSER_priv_other = usersMapper.getUsersByUSER_PRIV_OTHER(String.valueOf(userPriv));
            userPrivModel.setOtherUsers(usersByUSER_priv_other);
            json.setObject(userPrivModel);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;

    }

    @Override
    public ToJson<Users> selNewNowUsers(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            //查出全部部门的集合
            List<Department> departmentList = new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer = new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(sessionInfo.getDeptId(), stringBuffer, departmentList);
            Department deptById = departmentMapper.getDeptById(sessionInfo.getDeptId());
            List<Users> userByDeptId = new ArrayList<Users>();
            if (!StringUtils.checkNull(deptIds)) {
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = removeStr.split(",");
                userByDeptId = usersMapper.selectUserByDeptIds(split);
                if (userByDeptId != null && userByDeptId.size() > 0) {
                    for (Users u : userByDeptId) {
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                    }
                }
            }
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:" + e);
        }
        return json;
    }


    @Override
    public ToJson<Object> getUsersByUserPriv(HttpServletRequest request, String userPriv) {

        ToJson<Object> departmentToJson = new ToJson<Object>();
        List<Department> departmentList = departmentMapper.getDatagrid();
        departmentList = departmentList.stream().filter(d -> d.getDeptId() != 0).collect(Collectors.toList());

        //主角色用户
        List<Users> users = usersMapper.getUsersByUserPriv(userPriv);

        //辅助角色用户
        List<Users> fuzhuusers = usersMapper.getUsersByUSER_PRIV_OTHER(userPriv);
        // usersMapper.ge

        //全部主角色用户计数器
        int alltheMainRoleallUsersCount = 0;
        //全部禁止登陆用户计数器
        int allnoLoginUsersCount = 0;
        //全部辅助角色用户计数器
        int allauxiliaryRoleUserCount = 0;

        for (Department d : departmentList) {
            //遍历主角色用户们
            StringBuilder theMainRoleallUsers = new StringBuilder();
            StringBuilder noLoginUsers = new StringBuilder();

            //部门主角色用户计数器
            int theMainRoleallUsersCount = 0;
            //部门禁止登陆用户计数器
            int noLoginUsersCount = 0;

            for (Users u : users) {
                //排除离职部门人员
                if(u.getDeptId() == 0){
                    continue;
                }

                if (u.getDeptId().equals(d.getDeptId())) {
                    theMainRoleallUsers.append(u.getUserName() + ",");
                    theMainRoleallUsersCount++;

                    //判断主角色用户们是否是禁止登陆用户
                    // NOT_LOGIN         	禁止登录OA系统(1-禁止,0-不禁止)
                    if (u.getNotLogin() == 1) {
                        noLoginUsers.append(u.getUserName() + ",");
                        noLoginUsersCount++;
                    }
                }


            }
            d.setTheMainRoleallUsers(theMainRoleallUsers.toString());
            d.setNoLoginUsers(noLoginUsers.toString());
            d.setTheMainRoleallUsersCount(theMainRoleallUsersCount);

            //总计数器累计加
            alltheMainRoleallUsersCount = alltheMainRoleallUsersCount + theMainRoleallUsersCount;
            d.setNoLoginUsersCount(noLoginUsersCount);
            allnoLoginUsersCount = allnoLoginUsersCount + noLoginUsersCount;

            //遍历辅助角色用户
            StringBuilder auxiliaryRoleUser = new StringBuilder();
            //部门辅助角色用户计数器
            int auxiliaryRoleUserCount = 0;
            for (Users u : fuzhuusers) {
                //排除离职部门人员
                if(u.getDeptId() == 0){
                    continue;
                }

                if (u.getDeptId().intValue() == d.getDeptId().intValue()) {
                    auxiliaryRoleUser.append(u.getUserName() + ",");
                    auxiliaryRoleUserCount++;
                }
            }
            d.setAuxiliaryRoleUser(auxiliaryRoleUser.toString());
            d.setAuxiliaryRoleUserCount(auxiliaryRoleUserCount);
            //总计数器累加
            allauxiliaryRoleUserCount = allauxiliaryRoleUserCount + auxiliaryRoleUserCount;
        }

        Map map = new HashMap();

        map.put("alltheMainRoleallUsersCount", alltheMainRoleallUsersCount);
        map.put("allnoLoginUsersCount", allnoLoginUsersCount);
        map.put("allauxiliaryRoleUserCount", allauxiliaryRoleUserCount);
        departmentToJson.setObj1(map);
        departmentToJson.setObject(departmentList);
        departmentToJson.setFlag(0);
        departmentToJson.setMsg("ok");
        return departmentToJson;

    }

    @Override
    public ToJson<Object> getOnlineCount(HttpServletRequest request) {
        ToJson<Object> json = new ToJson<>(1, "err");
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            //修改用户最后访问时间
            Integer c = usersMapper.updateLastVisitTime(users.getUid());
            //统计在线人数
            Integer count = usersMapper.getOnlineCount();

         /*   List<UserOnline> list =new ArrayList<UserOnline>();
            Map<String, Object> userCountMap = loginController.userCountMap;
            Set<Map.Entry<String, Object>> entries = userCountMap.entrySet();
            Iterator   iterator=entries.iterator();
            String userId="";
            while (iterator.hasNext()){
                userId=new String();
                Map.Entry  mapentry = (Map.Entry) iterator.next();
                UserOnline userOnline =(UserOnline) mapentry.getValue();
                SimpleDateFormat s =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String format = s.format(new Date());
                Integer nowTime = DateFormat.getNowDateTime(format);
                Integer AndroidTime = userOnline.getAndroidtime();
                Integer iostime = userOnline.getIostime();
                Integer pCtime = userOnline.getPCtime();
                Integer webtime = userOnline.getWebtime();
                Integer arr[] =new Integer[4];
                arr[0]=AndroidTime;
                arr[1]=iostime;
                arr[2]=pCtime;
                arr[3]=webtime;
                //冒泡排序一次
                Integer[] colres = Colres(arr);
                //获取到最大的数值
                Integer colre = colres[arr.length - 1];
                list.add(userOnline);*/
            //与最大差值小于3分钟
                /*if(nowTime-colre<=180){
                    list.add(userOnline);
                }*/
            //否则睡眠，随着session注销消失
               /* else{
                    //
                    //超出3分钟了则从userCountMap移除
                    String uid = userOnline.getUid();
                    Users userByUid = usersMapper.getUserByUid(Integer.valueOf(uid));
                    if(userByUid!=null){
                        userId=userByUid.getUserId();
                        iterator.remove();
                    }
                }*/
            //}
            json.setMsg("ok");
            json.setObject(count);
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }

    public Integer[] Colres(Integer[] arr) {
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length - i - 1; j++) {

                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }

        return arr;

    }

    private void editCAccountinfo(Users user) {
        try {
            String loginId =  !StringUtils.checkNull(user.getLoginId()) ? user.getLoginId() : "";

            String addSql = "   insert into c_accountinfo (PERSON_ID, USER_ID, ACCOUNT, \n" +
                    "      PASSWORD, NAME, ID_CARD_NO, \n" +
                    "      CRED_TYPE, GENDER, USER_TYPE, \n" +
                    "      PHONE_NUMBERS, EMAILS, DATE_OF_BIRTH, \n" +
                    "      REGI_TIME, STATUS, OPERATION, \n" +
                    "      REMARK, ORG_ID)\n" +
                    "    values (" +
                    " '" + UUID.randomUUID().toString() + "'," +
                    " '" + (loginId + "_" + user.getUserId()) + "'," +
                    " '" + user.getByname() + "', " +
                    " '" + user.getPassword() + "'," +
                    " '" + user.getUserName() + "', " +
                    " '" + user.getIdNumber() + "'," +
                    " '0'," +
                    " '" + (!StringUtils.checkNull(user.getSex()) && "1".equals(user.getSex()) ? "0" : "1") + "'," +
                    " '" + user.getUserPriv().toString() + "'," +
                    " '" + user.getMobilNo() + "'," +
                    " '" + user.getEmail() + "','" +
                    (Objects.isNull(user.getBirthday()) ? "" : DateFormat.getStrDate(user.getBirthday())) + "','" +
                    DateFormat.getCurrentTime() + "', " +
                    "'0'," +
                    " '01'," +
                    " ''," +
                    " '" + loginId + "'" +
                    ")";
            String editSql = " update c_accountinfo\n" +
                    "    set PASSWORD = '" + user.getPassword() + "',\n" +
                    "      NAME = '" + user.getUserName() + "',\n" +
                    "      ID_CARD_NO = '" + user.getIdNumber() + "',\n" +
                    "      CRED_TYPE = '0',\n" +
                    "      GENDER = '" + (!StringUtils.checkNull(user.getSex()) && "1".equals(user.getSex()) ? "0" : "1") + "',\n" +
                    "      USER_TYPE = '" + user.getUserPriv().toString() + "',\n" +
                    "      PHONE_NUMBERS = '" + user.getMobilNo() + "',\n" +
                    "      EMAILS = '" + user.getEmail() + "',\n" +
                    "      DATE_OF_BIRTH = '" + DateFormat.getStrDate(user.getBirthday()) + "',\n" +
                    "      STATUS = '0',\n" +
                    "      OPERATION = '02',\n" +
                    "      ORG_ID = '" + loginId + "'\n" +
                    "    where USER_ID = '" + (loginId + "_" + loginId) + "'";
            //更新中间表中的数据
            ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
            List<OrgManage> obj = zh_cn.getObj();
            int size = obj.size();
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = props.getProperty("url" + obj.get(0).getOid());
            String driver = props.getProperty("driverClassName");
            String username = props.getProperty("uname" + obj.get(0).getOid());
            String password = props.getProperty("password" + obj.get(0).getOid());
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            boolean isExistPara_1 = Verification.CheckIsExistCAccountinfo(conn, driver, url, username, password, user.getLoginId() + "_" + user.getUserId());
            if (isExistPara_1 == true) {
                Statement st = conn.createStatement();
                st.executeUpdate(editSql);//执行SQL语句
            } else {
                Statement st = conn.createStatement();
                st.executeUpdate(addSql);//执行SQL语句
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //去重
    public List<Users> reAllUser(List<Users> list) {
        Map<Integer, Users> map = new HashMap<Integer, Users>();
        for (Users users : list) {
            map.put(users.getUid(), users);
        }
        list = new ArrayList<Users>(map.values());
        return list;
    }

    @Override
    public List<Users> getAllUser(Map<String, Object> map) {
        List<Users> allUser = usersMapper.getAllUser(map);
        for (Users users : allUser) {
            String userPrivOther = users.getUserPrivOther();
            if(!StringUtils.checkNull(userPrivOther)&&!StringUtils.checkNull(userPrivOther.replace(",",""))){
                List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivOther.split(","));
                StringBuilder sb = new StringBuilder();
                for (UserPriv userPrivById : userPrivByIds) {
                    sb.append(userPrivById.getPrivName()).append(",");
                }
                users.setUserPrivOtherName(sb.toString());
            }
        }
        return allUser;
    }

    @Override
    public List<Users> getAllPrivByProcess(Map<String, Object> map) {
        return usersMapper.getAllPrivByProcess(map);
    }

    @Override
    public List<Users> getUserByProcessPriv(Map<String, Object> map) {
        return usersMapper.getUserByProcessPriv(map);
    }

    public String RecursionSelectDept(int deptId, StringBuffer stringBuffer) {
        stringBuffer.append(deptId + ",");
        String returnStr = new String();
        List<Department> departments = departmentMapper.selectObjectByParent(deptId);
        if (departments != null && departments.size() > 0) {
            for (Department department : departments) {
                stringBuffer.append(department.getDeptId() + ",");
                List<Department> departments1 = departmentMapper.selectObjectByParent(department.getDeptId());
                if (departments1 != null && departments1.size() > 0) {
                    RecursionSelectDept(department.getDeptId(), stringBuffer);
                }
            }
        }
        if (!StringUtils.checkNull(stringBuffer.toString())) {
            returnStr = stringBuffer.toString().substring(0, stringBuffer.toString().length() - 1);
        }
        return returnStr;
    }

    public String NewRecursionSelectDept(int deptId, StringBuffer stringBuffer, List<Department> departments) {
        stringBuffer.append(deptId + ",");
        String returnStr = new String();

        List<Department> childList = new ArrayList<Department>();
        for (Department department : departments) {
            if (department.getDeptParent() == deptId) {
                stringBuffer.append(department.getDeptId() + ",");
                childList.add(department);
            }
        }
        for (Department department : childList) {
            NewRecursionSelectDept(department.getDeptId(), stringBuffer, departments);
        }
        if (!StringUtils.checkNull(stringBuffer.toString())) {
            returnStr = stringBuffer.toString().substring(0, stringBuffer.toString().length() - 1);
        }
        return returnStr;
    }

    public Department NewRecursionSelectDeptUser(Department department) {
        List<Department> departmentList = departmentMapper.selectObjectByParent(department.getDeptId());
        Users users = new Users();
        users.setDeptId(department.getDeptId());
        if (department.getMap() != null && !department.getMap().isEmpty()) {
            String jobId = (String) department.getMap().get("jobId");
            if (!StringUtils.checkNull(jobId)) {
                users.setJobId(Integer.parseInt(jobId));
            }
            String postId = (String) department.getMap().get("postId");
            if (!StringUtils.checkNull(postId)) {
                users.setPostId(Integer.parseInt(postId));
            }
        }
        List<Users> userByDeptId = null;
        if (department.getDeptId() != null && department.getDeptId() != 0) {
            userByDeptId = usersMapper.getUserByDeptId(users);
        } else {
            userByDeptId = usersMapper.getUserByDeptIdZero(users);
        }
        department.setUsers(userByDeptId);
        if (departmentList != null && departmentList.size() > 0) {
            department.setChild(departmentList);
            for (Department threeDept : departmentList) {
                threeDept.setMap(department.getMap());
                NewRecursionSelectDeptUser(threeDept);
            }
        }
        return department;
    }

    @Override
    public ToJson<Users> queryUsers(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, Users user, String isExport) {
        //redis处理
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        Map<String, Object> map = new HashMap<String, Object>();
        if (!"yes".equals(isExport)) {
            map.put("page", pageParams);
        }
        map.put("userName", user.getUserName());
        map.put("sex", user.getSex());
        map.put("mobilNo", user.getMobilNo());
        map.put("telNoDept", user.getTelNoDept());
        map.put("deptId", user.getDeptId());
        map.put("roomNum", user.getRoomNum());

        try {
           /*     List<Users> usersList = new ArrayList<>();
            //判断是否有查看全部的权限
            boolean sfqx = ifCkqb(loginUser);
            if (sfqx) {
                usersList = addressZfwMapper.selectUsersPage(map);
                //部门
                for (Users users : usersList) {
                    int dept = users.getDeptId();
                    String deptName = departmentMapper.getDeptNameById(dept);
                    users.setDeptName(deptName);
                }
                json.setObj(usersList);
                json.setTotleNum(addressZfwMapper.countUsersPage(map));
            } else {
                //判断是否有其他参数设置
                if (loginUser.getDeptYj() != null && !"".equals(loginUser.getDeptYj())) {
                    String qx[] = loginUser.getDeptYj().split(",");
                    List<Integer> deptList = new ArrayList<>();
                    //得到所有子节点
                    for (String q : qx) {
                        getAllChileDept(deptList, Integer.parseInt(q));
                    }
                    map.put("deptList", deptList);
                    usersList = addressZfwMapper.selectUsersPage(map);
                    //部门
                    for (Users users : usersList) {
                        int dept = users.getDeptId();
                        String deptName = departmentMapper.getDeptNameById(dept);
                        users.setDeptName(deptName);
                    }
                    json.setObj(usersList);
                    json.setTotleNum(addressZfwMapper.countUsersPage(map));
                } else {
                    //用户只能查看本部门一级
                    int deptId = loginUser.getDeptId();
                    List<Integer> list = departmentMapper.getDeptIdByParent(0);
                    deptId = getDeptYJ(deptId, list);
                    List<Integer> deptList = new ArrayList<>();
                    deptList.add(deptId);
                    getAllChileDept(deptList, deptId);
                    map.put("deptList", deptList);
                    usersList = addressZfwMapper.selectUsersPage(map);
                    //部门
                    for (Users users : usersList) {
                        int dept = users.getDeptId();
                        String deptName = departmentMapper.getDeptNameById(dept);
                        users.setDeptName(deptName);
                    }
                    json.setObj(usersList);
                    json.setTotleNum(addressZfwMapper.countUsersPage(map));
                }

            }*/

            json.setFlag(0);
            json.setMsg("ok");
            // 判断是否导出
            if ("yes".equals(isExport)) {
       /*         HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("人员信息", 9);
                String[] secondTitles = {"姓名", "部门", "工作电话", "房间号", "移动电话", "传真号",};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"userName", "deptName", "telNoHome", "roomNum", "mobilNo", "faxNoDept"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, usersList, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "人员信息导出表.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();*/

            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 张丽军
     * 获取服务器的时间
     *
     * @param request
     * @return
     */
    @Override
    public ToJson<Users> getDate(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            //Java获取服务器当前日期和时间
            Date dateAndTime = new Date();
            //Java获取服务器当前日期和时间
            //String date=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
            Users users = new Users();
            //users.setNewDate(date);
            users.setFuDate(dateAndTime);
            json.setObject(users.getFuDate());
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    //判断是否有查看全部的权限
  /*  public boolean ifCkqb(Users users) {

        boolean flag = false;
        //用户
        HierarchicalGlobal hierarchicalGlobal = addressZfwMapper.selectGPerson();
        //部门
        HierarchicalGlobal hierarchicalGlobal1 = addressZfwMapper.selectGDept();
        //角色
        HierarchicalGlobal hierarchicalGlobal2 = addressZfwMapper.selectGPriv();
        String globalDept = hierarchicalGlobal1.getGlobalDept();
        String globalPerson = hierarchicalGlobal.getGlobalPerson();
        String globalPriv = hierarchicalGlobal2.getGlobalPriv();
        String[] split = globalPerson.split(",");
        String[] split1 = globalDept.split(",");
        String[] split2 = globalPriv.split(",");
        //人员
        if (split.length != 0 && split != null) {
            for (String splitstr : split) {
                if (users.getUserId().equals(splitstr)) {
                    flag = true;
                }
            }
        }
        //部门
        if (split1.length != 0 && split1 != null) {
            for (String splitstr : split1) {
                if (users.getDeptId().equals(splitstr)) {
                    flag = true;
                }
            }
        }
        //角色
        if (split2.length != 0 && split2 != null) {
            for (String splitstr : split2) {
                if (users.getUserPriv().equals(splitstr)) {
                    flag = true;
                }
            }
        }

        return flag;
    }*/

    /**
     * 贾志敏 得到一级部门下所有部门
     */
    public void getAllChileDept(List<Integer> list, int deptId) {
        List<Integer> listl = departmentMapper.getDeptIdByParent(deptId);
        if (listl.size() >= 0) {
            for (Integer de : listl) {
                if (!list.contains(de)) {
                    list.add(de);
                    getAllChileDept(list, de);
                }
            }
        }
    }
    @Override
    public ToJson<Users> getOnlineByuser() {
        ToJson<Users> json = new ToJson<Users>();
        try {
            List<Users> list = usersMapper.getOnlineByuser();
            json.setObj(list);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("false");
        }
        return json;
    }

    @Override
    public ToJson getUserAndDept(Users u, HttpServletRequest request) {  // 手机端选人时
        //是否是分级机构范围？所有人范围
        ToJson<Users> json = new ToJson<Users>(0, null);
        //SysPara sysPara = sysParaMapper.querySysPara("ORG_SCOPE");
        List<Department> departmentList = new ArrayList<Department>();
        List<Department> departmentResult = new ArrayList<Department>();
        List<Users> usersResult = new ArrayList<Users>();
        int i1 = departmentService.checkOrgFlag(u);
        if ( i1 == 2) {//本分级机构范围
            Users user = usersMapper.getUsersByuserId(u.getUserId());
//            if ("1".equals(user.getUserId())) {
//                return imUsersService.selNewNowUsersBai(request);
//            }
            Integer deptId = user.getDeptId();
            String otherDeptId = user.getDeptIdOther();
            if (!"".equals(otherDeptId) && otherDeptId != null) {
                if (",".equals(otherDeptId.substring(otherDeptId.length() - 1, otherDeptId.length()))) {
                    otherDeptId += deptId;
                } else {
                    otherDeptId += "," + deptId;
                }
            } else if ("".equals(otherDeptId) || otherDeptId == null) {
                otherDeptId = deptId + ",";
            }

            //将部门和辅助部门拼接
            if (!"".equals(otherDeptId) && otherDeptId != null) {
                String[] deptIdStr = otherDeptId.split(",");
                for (int i = 0; i < deptIdStr.length; i++) {
                    //递归查询父部门
                    Department department = departmentService.queryDeptParent(Integer.valueOf(deptIdStr[i]));
                    if (department == null) {
                        List<Department> list = departmentService.getDepartmentByParet();
                        for (Department department1 : list) {
                            int a = departmentService.getCountChDeptUser(department1.getDeptNo());
                            List<Department> list2 = departmentService.getChDept(department1.getDeptId());
                            if (list2.size() != 0) {
                                department1.setIsHaveCh("1");
                            } else {
                                department1.setIsHaveCh("0");
                            }
                        }

                    } else {
                        if (departmentList.size() == 0) {
                            departmentList.add(department);
                        } else {
                            Iterator<Department> it = departmentList.iterator();
                            while (it.hasNext()) {
                                Department d = it.next();
                                //如果部门结果中没有与当前部门有父子部门关系直接加入结果集中
                                int deptParent = department.getDeptParent();
                                int deptID = department.getDeptId();
                                int dID = d.getDeptId();
                                int dParent = d.getDeptParent();
                                if (deptParent != dID && deptID != dParent) {
                                    departmentResult.add(department);
                                }
                                //如果部门结果集中有父部门则取当前子部门的结果，将父部门结果在结果集中删掉
                                if (d.getDeptId() == department.getDeptParent()) {
                                    String dId = department.getDeptId() + "";
                                    if (otherDeptId.indexOf(dId) == -1) {
                                        it.remove();
                                        departmentResult.add(department);
                                    }
                                }
                            }
                            //如果部门中有子部门则不添加新部门结果集
                            for (Department dd : departmentResult) {
                                departmentList.add(dd);
                            }
                            String deptIdString = "";
                            List<Users> usersList = new ArrayList<>();
                            if (departmentList.size() > 0) {
                                for (Department department1 : departmentList) {
                                    ToJson<Users> usersToJson = imUsersService.getNewChDeptBai(request, department1.getDeptId());
                                    List<Users> users = usersToJson.getObj();
                                    for (Users user1 : users) {
                                        usersResult.add(user1);
                                    }
                                }

                                String order = null;
                                try {
                                    order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
                                } catch (Exception e) {

                                }
                                try {
                                    if ("1".equals(order)) {
                                        for (Users users1 : usersResult) {
                                            if (!StringUtils.checkNull(users1.getUserId())) {
                                                //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId()).getOrderNo());
                                                //规避没有这个排序的用户会报错给一个默认排序10
                                                UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId());
                                                Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                                                users1.setUserDeptNo(userDeptNo);
                                            }
                                        }
                                        Collections.sort(usersResult, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                                        //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                                json.setObj(usersResult);
                                json.setFlag(1);
                                json.setMsg("success");
                            }
                        }
                    }
                }
            }
        }
        else { //搜索全部人员
            Map map = new HashMap();
            PageParams pageParams = new PageParams();
            pageParams.setPage(1);
            pageParams.setPageSize(50);
            pageParams.setUseFlag(true);
            map.put("pageParams", pageParams);
            List<Users> users = usersMapper.getAllUserInfo(map);
            for (Users users1 : users) {
                Department deptById = departmentMapper.getDeptById(users1.getDeptId());
                if(deptById!=null){
                    users1.setDeptId(deptById.getDeptId());
                    users1.setDeptName(deptById.getDeptName());
                }
                usersResult.add(users1);
            }

            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            } catch (Exception e) {

            }
            try {
                if ("1".equals(order)) {
                    for (Users users1 : usersResult) {
                        if (!StringUtils.checkNull(users1.getUserId())) {
                            //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId()).getOrderNo());
                            //规避没有这个排序的用户会报错给一个默认排序10
                            UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId());
                            Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                            users1.setUserDeptNo(userDeptNo);
                        }
                    }
                    Collections.sort(usersResult, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            json.setObj(usersResult);
            json.setFlag(1);
            json.setMsg("success");
        }
        if (departmentList.size() > 0) {
            for (Department department1 : departmentList) {
                ToJson<Users> usersToJson = imUsersService.getNewChDeptBai(request, department1.getDeptId());
                List<Users> users = usersToJson.getObj();
                for (Users user1 : users) {
                    usersResult.add(user1);
                }
            }

            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            } catch (Exception e) {

            }
            try {
                if ("1".equals(order)) {
                    for (Users users1 : usersResult) {
                        if (!StringUtils.checkNull(users1.getUserId())) {
                            //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId()).getOrderNo());
                            //规避没有这个排序的用户会报错给一个默认排序10
                            UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId());
                            Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                            users1.setUserDeptNo(userDeptNo);
                        }
                    }
                    Collections.sort(usersResult, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            json.setObj(usersResult);
            json.setFlag(1);
            json.setMsg("success");
        }
        json.setObject(i1);
        return json;
    }

    /**
     * 适用于工作流选人过滤条件
     *
     * @param conditions
     * @param flag
     * @return
     */
    @Override
    public List<Integer> getUidByConditions(String conditions, Integer flag) {
        if (StringUtils.checkNull(conditions)) {
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        List<Integer> l = new ArrayList<Integer>();
        String[] temp = conditions.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                List<Integer> list = null;
                switch (flag) {
                    case 1:
                        map.put("deptId", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 2:
                        map.put("userPriv", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 3:
                        map.put("deptIdOther", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 4:
                        map.put("userPrivOther", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 5://部门和辅助部门
                        map.put("deptIdAll", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 6://角色和辅助角色
                        map.put("userPrivAll", temp[i]);
                        list = usersMapper.getUidByConditions(map);
                        if (list != null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    default:
                        break;
                }
            }
        }
        //去重
        Set<Integer> t = new HashSet<>(l);
        List<Integer> result = new ArrayList<>(t);
        return result;
    }


    /**
     * 作者: 张航宁
     * 日期: 2019/05/15
     * 说明: 获取当前登陆用户的信息
     */
    @Override
    public ToJson<Users> getNowLoginUser(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            String company = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
            if (sessionInfo != null && sessionInfo.getUid() != null) {
                Users byUid = usersMapper.getByUid(sessionInfo.getUid());
                byUid.setCompanyId(company);
                json.setObject(byUid);
            }
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:" + e);
        }

        return json;
    }

    @Override
    public List<Integer> getWorkFlowUid(Map<String, Object> map) {
        return usersMapper.getWorkFlowUid(map);
    }


    @Override
    public List<Users> getWorkFlowUser(Map<String, Object> map) {
        List<Users> workFlowUser = usersMapper.getWorkFlowUser(map);
        return workFlowUser;
    }

    @Override
    public String getUserAvatar(String userIds) {
        if (StringUtils.checkNull(userIds)) {
            return null;
        }
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();
        if (",".equals(String.valueOf(userIds.charAt(userIds.length() - 1)))) {
            userIds = userIds.substring(0, userIds.length() - 1);
        }
        String temp[] = userIds.split(",");
        if (temp.length <= 0) {
            return null;
        }
        List<String> UserAvatar = usersMapper.getUserAvatar(temp);
        int length = UserAvatar.size();
        for (int i = 0; i < length; i++) {
            if (i < length - 1) {
                sb.append(UserAvatar.get(i)).append(",");
            } else {
                sb.append(UserAvatar.get(i));
            }
        }
        return sb.toString();
    }

    @Override
    public ToJson<Users> selectByMobilNo(HttpServletRequest request, String mobilNo) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            int temp = usersMapper.selectByMobilNo(mobilNo);
            if (temp > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            } else {
                json.setMsg("手机号输入有误");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Users> selectByIdAndMobilNo(HttpServletRequest request, String idNumber, String mobilNo) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            int temp = usersMapper.selectByIdAndMobilNo(idNumber, mobilNo);
            if (temp > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            } else {
                json.setMsg("身份证或手机号输入有误");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public void updateshortcut(Users users, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        //获取登录用户
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (users.getShortcut() != null && users.getShortcut() != "") {
            loginUser.setShortcut(users.getShortcut());
        }
        usersMapper.updateshortcut(loginUser);
    }

    @Override
    public ToJson<Users> updateKanBan(String myStatus, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        //获取登录用户
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            Users users = new Users();
            users.setMyStatus(myStatus);
            users.setUid(loginUser.getUid());
            int temp = usersMapper.updateMyStatusByUserId(users);
            if (temp > 0) {
                json.setFlag(0);
                json.setMsg("ok");
            } else {
                json.setMsg("添加失败");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }

    @Override
    public ToJson<Users> selectKanBan(HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        //获取登录用户
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            Users usersByuserId = usersMapper.getUsersByuserId(loginUser.getUserId());
            json.setFlag(0);
            json.setObject(usersByuserId.getMyStatus());
            json.setMsg("ok");

        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }

        return json;
    }

    @Override
    public void updatePassword(Users user) {
        //加密密码
        if (user.getPassword() != null) {
            user.setPassword(getEncryptString(user.getPassword().trim()));
        } else {
            user.setPassword("tVHbkPWW57Hw.");
        }
        Map<String, Object> map = new HashedMap();
        map.put("password", user.getPassword());
        map.put("uids", user.getUid());
        usersMapper.batchUpdatePwd(map);
    }

    @Override
    public List<Users> getUsersByOrgDeptId(Integer deptId) {
        if (deptId != null) {
            return usersMapper.getUsersByOrgDeptId(deptId);
        } else {
            return null;
        }

    }

    //获取未分配部门特殊处理人员
    @Override
    public ToJson<Users> getSpecialUsers(HttpServletRequest request, Integer deptId, Byte notLogin) {
        ToJson<Users> json = new ToJson<Users>();
        Map<String, Object> map = new HashMap<>();
        map.put("deptId", deptId);
        map.put("notLogin", notLogin);
        List<Users> usersByPowerChina = usersMapper.getSpecialUsers(map);
        for (Users entity : usersByPowerChina) {
            if ("tVHbkPWW57Hw.".equals(entity.getPassword())) {
                entity.setPassword("");
            }
            if (entity.getPostId() != null && entity.getPostId() != 0) {
                if (managementMapper.getUserPostId(entity.getPostId()) != null) {
                    String postName = managementMapper.getUserPostId(entity.getPostId()).getPostName();
                    entity.setPostName(postName);
                } else {
                    entity.setPostName("");
                }

            }
            // 判断是否是非法的空字符串密码 如果是的话进行密码修正
            else if (checkPassWordUser(entity.getUserName(), entity.getPassword(), "")) {
                entity.setPassword("");
                editPwd(request, entity, "");
                entity.setPassword("");
            }

            if (entity.getLastVisitTime() != null) {
                // 获取闲置时间
                long times = System.currentTimeMillis() - entity.getLastVisitTime().getTime();
                long day = times / (24 * 60 * 60 * 1000);
                long hour = (times / (60 * 60 * 1000) - day * 24);
                long min = ((times / (60 * 1000)) - day * 24 * 60 - hour * 60);

                StringBuffer sb = new StringBuffer();
                if (day > 0) {
                    sb.append(day + "天");
                }
                if (hour > 0) {
                    sb.append(hour + "小时");
                }
                if (min > 0) {
                    sb.append(min + "分");
                }
                entity.setIdleTime(sb.toString());
            } else {
                entity.setIdleTime("未曾登录");
            }
            if (entity.getDeptId() == 0) {
                entity.setDeptName("离职或外部人员");
            }
            if (entity.getRemark() != null) {
                String[] remark = entity.getRemark().split(",");
                StringBuffer str1 = new StringBuffer();
                for (String str : remark
                ) {
                    String str2 = str.split(":")[0];
                    if (str2.endsWith("empType")) {
                        str1.append(str.split(":")[1]);
                    }
                    if (str2.endsWith("flag")) {
                        str1.append(",部门已变动");
                    }
                }
                entity.setRemark(str1.toString());
            }
            if (!StringUtils.checkNull(String.valueOf(entity.getDeptId()))) {
                entity.setDeptName(departmentMapper.getDeptNameById(entity.getDeptId()));
            }
        }
        json.setObj(usersByPowerChina);
        return json;
    }

    public Users selectCountByDeptId(Integer deptId, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("deptId", deptId);
        map.put("userId", userId);
        Users user = usersMapper.selectCountByDeptId(map);
        return user;
    }

    //自定义门户-自定义显示及排列
    @Override
    public ToJson myTableRight(HttpServletRequest request, String mytableRight) {
        ToJson json = new ToJson();

        return json;
    }
    //计划管理运营驾驶舱自定义设置
    @Override
    public ToJson userPlanCockpitSet(HttpServletRequest request, UserExt userExt) {
        ToJson json = new ToJson();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            //获取登录用户
            Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            userExt.setUserId(loginUser.getUserId());
            if (StringUtils.checkNull(userExt.getPlanCockpitSet())) {
                UserExt planCockpitSet = userExtMapper.getPlanCockpitSet(userExt);
                json.setObject(planCockpitSet);
            } else {
                userExtMapper.updatePlanCockpitSet(userExt);
                json.setObject(userExt);
            }
            json.setFlag(0);
        } catch (Exception e) {
            json.setFlag(1);
        }
        return json;
    }

    public AjaxJson getUserByDeptName(String deptIds) {
        AjaxJson ajaxJson = new AjaxJson();
        List<Department> departmentList = departmentMapper.selDeptByIds(deptIds.split(","));
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        for (Department department : departmentList) {
            String deptNo = department.getDeptNo();
            List<Department> deptChildList = departmentMapper.getBydeptNo(deptNo);
            for (Department d : deptChildList) {
                map = personMapper.getUserByDeptName(d.getDeptName());
                if (map != null && map.size() > 0) {
                    list.add(map);
                }

                //针对普陀区教育学院部门 337
                String substring = d.getDeptNo().substring(0, 3);
                if ("005".equals(substring)){
                    List<Map<String, Object>> userByDeptId = personMapper.getUserByDeptId(String.valueOf(d.getDeptId()));
                    if (!userByDeptId.isEmpty()) {
                        list.addAll(userByDeptId);
                    }
                }

            }
        }
        ajaxJson.setObj(list);
        return ajaxJson;

    }

    /**
     * 修改控制面板状态
     */
    @Override
    public AjaxJson userExtMenuPanel(HttpServletRequest request, String menuPanel,String emailPanel) {
        AjaxJson ajaxJson = new AjaxJson();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        //获取登录用户
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        UserExt userExt = new UserExt();
        userExt.setUid(loginUser.getUid());

        String documentPanel = request.getParameter("documentPanel");

        if (!StringUtils.checkNull(menuPanel)){
            userExt.setMenuPanel(menuPanel);
        }
        else if (!StringUtils.checkNull(emailPanel)){
            userExt.setEmailPanel(emailPanel);

        } else if (!StringUtils.checkNull(documentPanel)){
            userExt.setDocumentPanel(documentPanel);

        }
        userExtMapper.updateUserExtByUid(userExt);
        return ajaxJson;
    }

    /** 根据uidArray批量修改密码 */
    public ToJson batchUpdatePasswordByUidArray(HttpServletRequest request, String[] uidArray, String password) {
        ToJson toJson = new ToJson();
        toJson.setMsg("无权限");
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            String userFuncIdStr = userFunctionMapper.getUserFuncIdStr(nowUser.getUserId());

            // 判断是否包含用户管理菜单和分级机构用户管理菜单
            if(!StringUtils.checkNull(userFuncIdStr)) {
                String[] split = userFuncIdStr.split(",");
                if (Arrays.asList(split).contains("33") || Arrays.asList(split).contains("2010")) {

                    // 密码加密
                    String encryptedPassword = getEncryptString(password);
                    // 准备map参数
                    Map<String, Object> map = new HashMap<>();
                    map.put("uidArray", uidArray);
                    map.put("password", encryptedPassword);
                    // 密码批量修改操作
                    int num = usersMapper.batchUpdatePasswordByUidArray(map);
                    if (num > 0) {
                        toJson.setFlag(0);
                        toJson.setMsg("true");
                    } else {
                        toJson.setFlag(1);
                        toJson.setMsg("没有修改任何数据");
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }
        return toJson;
    }

    /**
     * 创建人：刘景龙
     * 创建时间：2021-09-24 15:49
     * 方法介绍：判断当前登陆人今天是否过生日
     * 参数说明：
     */
    @Override
    public ToJson getBrithDay(HttpServletRequest request,String userId) {
        ToJson json=new ToJson();
         request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        Users users1= null;
        try {
            users1 = usersMapper.findUsersByuserId(users.getUserId());
            Calendar calendar = Calendar.getInstance();
            int month = calendar.get(Calendar.MONTH) + 1;
            int day = calendar.get(Calendar.DATE);
            if(users1.getBirthday()!=null){
                Date date=users1.getBirthday();
                int i=date.getMonth()+1;
                if(i==month&&day==date.getDate()){
                    json.setMsg("ok");
                    json.setFlag(0);
                }else {
                    json.setMsg("err");
                    json.setFlag(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public List<Users> getUsersByUserIds(String userIds) {
        if (!StringUtils.checkNull(userIds)) {
            String[] split = userIds.split(",");
            if (split != null && split.length > 0) {
                List<Users> usersList = usersMapper.getUsersByUserIds(split);
                if(!usersList.isEmpty()){
                    for(Users users : usersList){
                        if(users.getDeptId()!=null){
                            users.setDeptName(departmentMapper.selectById(users.getDeptId()));
                        }
                        if(users.getJobId()!=null){
                            UserJob job = positionManagementMapper.getUserjobId(users.getJobId());
                            if(job!=null){
                                users.setJobName(job.getJobName());
                            }
                        }
                        if(users.getUserPriv()!=null){
                            UserPriv priv = userPrivMapper.selectByPrimaryKey(users.getUserPriv());
                            if(priv!=null)users.setUserPrivName(priv.getPrivName());
                        }
                    }
                }
                return usersList;
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Users> getUserByUserNames(String userNames) {
        if(StringUtils.checkNull(userNames))
            return null;
        String[] userArray = userNames.split(",");
        return  usersMapper.getUsersByUserNamesOrder(userArray);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/11
     * 方法介绍: 根据部门ID 获取部门架构（该部门的人员和下属部门）
     * 参数说明: [deptId]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @Override
    public ToJson getUserStructure(Integer deptId) {
        ToJson json = new ToJson();
        Map<String, Object> map = new HashMap<>();
        //获取人员数据
        if (deptId == null){
            deptId = 0;
        } else {
            List<Users> usersList = usersMapper.getUserStructure(deptId);
            if (!CollectionUtils.isEmpty(usersList)){
                List<Map<String, Object>> uList = new ArrayList<>();
                for (int i = 0; i < usersList.size(); i++) {
                    Map<String, Object> uMap = new HashMap<>();
                    uMap.put("USER_ID", usersList.get(i).getUserId());
                    uMap.put("USER_NAME", usersList.get(i).getUserName());
                    uList.add(uMap);
                }
                map.put("item", uList);
            }
        }

        //获取部门数据
        List<Department> departmentList = departmentMapper.getDepartmentStructure(deptId);
        if (!CollectionUtils.isEmpty(departmentList)){
            List<Map<String, Object>> dList = new ArrayList<>();
            for (int i = 0; i < departmentList.size(); i++) {
                Map<String, Object> dMap = new HashMap<>();
                dMap.put("DEPT_ID", departmentList.get(i).getDeptId());
                dMap.put("DEPT_NAME", departmentList.get(i).getDeptName());
                dList.add(dMap);
            }
            map.put("data", dList);
        }

        json.setFlag(0);
        json.setMsg("ok");
        json.setObject(map);
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/11
     * 方法介绍: 根据userIds 获取 userId 和 userName
     * 参数说明: [userIds]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @Override
    public ToJson regularElection(String userIds) {
        ToJson json = new ToJson();
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        if (!StringUtils.checkNull(userIds)){
            List<Users> usersList = usersMapper.getUsersByUserIdsOrder(userIds.split(","));
            if (!CollectionUtils.isEmpty(usersList)){
                StringBuffer userNames = new StringBuffer();
                for (int i = 0; i < usersList.size(); i++) {
                    Map<String, Object> uMap = new HashMap<>();
                    uMap.put("USER_ID", usersList.get(i).getUserId());
                    uMap.put("USER_NAME", usersList.get(i).getUserName());
                    list.add(uMap);
                    userNames.append(usersList.get(i).getUserName()).append(",");
                }
                map.put("userNames", userNames);
            }
        }
        json.setFlag(0);
        json.setMsg("ok");
        json.setObj(list);
        json.setObject(map);
        return json;
    }

    @Override
    public ToJson queryEditByNameAuth(HttpServletRequest request,Users user) {
        ToJson json = new ToJson();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users use = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        try {
            boolean editByNameFlag = false;
            if (!editByNameFlag) {
                //用户角色为管理员，允许修改用户名
                if (use.getUserPriv().equals(1)) {
                    editByNameFlag = true;
                }
            }
            if (!editByNameFlag) {
                //系统参数设置-是否允许修改用户名
                SysPara editByname = sysParaMapper.querySysPara("EDIT_BYNAME");
                if (!Objects.isNull(editByname) && "1".equals(editByname.getParaValue())) {
                    editByNameFlag = true;
                }
            }
            if (!editByNameFlag) {
                //是否设置了用户管理模块的管理范围
                String moduleId = request.getParameter("moduleId");
                Map<String, Object> map = modulePrivService.getModulePriv(use, moduleId);
                map.put("userId", user.getUserId());
                Users usersByModulePriv = imUsersMapper.getUsersByuserIdBai(map);
                if (!Objects.isNull(usersByModulePriv) && !Objects.isNull(usersByModulePriv.getUid())) {
                    editByNameFlag = true;
                }
            }
            json.setFlag(0);
            json.setTurn(editByNameFlag);
            json.setMsg("success");

        }catch (Exception e){
            json.setMsg("UsersServiceImpl.queryEditByNameAuth" + e.getMessage());
            e.printStackTrace();
        }
        return json;
    }

}