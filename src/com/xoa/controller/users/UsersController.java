package com.xoa.controller.users;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.syspara.SysParaService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.ImgUpUtils;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import org.apache.http.entity.ContentType;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.util.*;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:42:39
 * 类介绍  :    用户
 * 构造参数:    无
 */
@Controller
public class UsersController {

    @Resource
    private UsersService usersService;

    @Resource
    SysParaService sysParaService;

    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SyslogMapper syslogMapper;
    @Resource
    SystemInfoService systemInfoService;

    @Resource
    ModulePrivMapper modulePrivMapper;
    @Resource
    private UserFunctionMapper userFunctionMapper;
    @Resource
    private UsersMapper usersMapper;

    @Autowired
    private DutiesManagementMapper dutiesManagementMapper;

    @Autowired
    UserDeptOrderMapper userDeptOrderMapper;

    @Resource
    DepartmentService departmentService;
    @Resource
    UsersPrivService usersPrivService;
    @Resource
    DepartmentMapper departmentMapper;
    @Resource
    UserExtMapper userExtMapper;
    @Resource
    private SmsService smsService;
    @Resource
    private ModulePrivService modulePrivService;


    @RequestMapping("/addUsers")
    public String addUser(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        if (!sysParaService.checkIsHaveSecure(user,8)){
            return "app/common/development";
        }
        return "app/sys/addUser";
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年4月18日 下午6:42:39
     * 类介绍  :    用户
     * 构造参数:    无
     */
    @RequestMapping("/controlpanel/theme")
    public String theme() {
        return "/app/url/theme";
    }

    //未分配部门人员页面
    @RequestMapping("/sys/noDeptPeople")
    public String noDeptPeople() {
        return "/app/sys/noDeptPeople";
    }

    @RequestMapping("/controlpanel/personInfor")
    public String personInfo(Model model, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users= SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
        if(!StringUtils.checkNull(users.getUserId())){
            model.addAttribute("userId",users.getUserId());
        }else{
            model.addAttribute("userId","");
        }
        return "/app/url/personInfor";
    }


    @RequestMapping("/controlpanel/count")
    public String count() {
        return "/app/url/count";
    }

    @RequestMapping("/controlpanel/modifyInfo")
    public String modifyInfo(HttpServletRequest request) {
        //消除事务提醒
        String bodyId=request.getParameter("bodyId");
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        smsService.setSmsFileRead(bodyId,"90","/controlpanel/modifyInfo",users);
        return "/app/url/modifyInfo";
    }

    @RequestMapping("/user/goQueryExportUsers")
    public String goQueryExportUsers(){
        return "app/user/queryExportUsers";
    }

    @RequestMapping("/user/goImportUsers")
    public String goImportUsers(){
        return "app/user/importUsers";
    }

    @RequestMapping("/user/goEditUserBatch")
    public String goEditUserBatch(){
        return "app/user/editUserBatch";
    }

    @RequestMapping("/user/goImportEduUsers")
    public String goImportEduUsers(){
        return "app/user/importEduUsers";
    }

    @RequestMapping("/user/passwordCard")
    public String passwordCard(){
        return "app/user/passwordCard";
    }

    /**
     * 创建作者:
     * 创建日期:   2017年4月18日 下午6:43:04
     * 方法介绍:   添加用户
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/addUser", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> addUser(Users user, UserExt userExt, @RequestParam(required = false) String deptIds, @RequestParam(required = false) String privIds, @RequestParam(required = false) String userIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ModulePriv modulePriv = null;
        if (!StringUtils.checkNull(deptIds) || !StringUtils.checkNull(privIds) || !StringUtils.checkNull(userIds)) {
            modulePriv = new ModulePriv();
            modulePriv.setDeptId(deptIds);
            modulePriv.setPrivId(privIds);
            modulePriv.setUserId(userIds);
        }
        return usersService.addUser(user, userExt, modulePriv, request);
    }

    /**
     * 创建作者:
     * 创建日期:   2017年4月18日 下午6:53:11
     * 方法介绍:   修改用户
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/editUser", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> editUser(Users user, UserExt userExt, @RequestParam(required = false) String deptIds, @RequestParam(required = false) String privIds, @RequestParam(required = false) String userIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ModulePriv modulePriv = null;
    /*    if (!StringUtils.checkNull(deptIds) || !StringUtils.checkNull(privIds) || !StringUtils.checkNull(userIds)) {
            modulePriv = new ModulePriv();
            modulePriv.setDeptId(deptIds);
            modulePriv.setPrivId(privIds);
            modulePriv.setUserId(user.getUserId());
        }*/
        modulePriv = new ModulePriv();
        modulePriv.setDeptId(deptIds);
        modulePriv.setPrivId(privIds);
        modulePriv.setUserId(userIds);
        Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        //判断用户信息
        if(user!=null){
            //判断PC端如果传入的uid为0的话，默认获取当前登录人的uid
            if(user.getUid()==null||user.getUid()==0){
                user.setUid(sessionInfo.getUid());
            }
        }
        String loginId = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        user.setLoginId(loginId);
        return usersService.editUser(request,user, userExt, modulePriv);
    }


    /**
     * 创建作者:
     * 创建日期:   2017年4月18日 下午6:53:11
     * 方法介绍:   修改用户
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/editPersonCon", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> editPersonCon(Users user, UserExt userExt, @RequestParam(required = false) String deptIds, @RequestParam(required = false) String privIds, @RequestParam(required = false) String userIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        //判断用户信息
        if(user!=null){
            //判断PC端如果传入的uid为0的话，默认获取当前登录人的uid
            if(user.getUid()==null||user.getUid()==0){
                user.setUid(sessionInfo.getUid());
            }
        }
        String loginId = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        user.setLoginId(loginId);
        userExt.setUid(user.getUid());
        userExtMapper.updateUserExtByUid(userExt);
        return usersService.edit(user);
    }

    /**
     * 张丽军
     * 判断人数是否上线，是否可以新建
     * @param uids
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/userCountPer")
    public ToJson<Users> userCountPer(String uids, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try{
            //判断是否可以新建邮件
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            String realPath = request.getSession().getServletContext().getRealPath("/");
            Map<String, String> m = systemInfoService.getSystemInfo(realPath, locale, request);
            int oaUserLimit=0;
            m.put("oaUserLimit","不限制");
            if("不限制".equals(m.get("oaUserLimit"))){
                json.setFlag(0);
            }else{
                //授权人数
                oaUserLimit = Integer.parseInt(m.get("oaUserLimit"));
                //允许登录用户数
                int canLoginUser = usersMapper.getLoginUserCount();
                if (canLoginUser > oaUserLimit) {
                    json.setCode(LoginState.LOGINTIME);
                    json.setMsg("允许登陆OA用户达到上限，新建邮件失败！");
                    json.setFlag(1);
                }else {
                    json.setFlag(0);
                }
            }

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:
     * 创建日期:   2017年5月22日 下午5:08:37
     * 方法介绍:   修改用户信息
     * 参数说明:   @param user 用户信息
     * 参数说明:   @param imageFile 头像
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     * 参数说明:   @throws IllegalStateException
     * 参数说明:   @throws IOException
     *
     * @return ToJson<Users>
     */
    @ResponseBody
    @RequestMapping(value = "/user/edit")
    public ToJson<Users> edit(
            Users user,
            @RequestParam(value = "userExt", required = false) UserExt userExt,
            @RequestParam(value = "imgFile", required = false) MultipartFile imageFile
            , HttpServletRequest request) throws IllegalStateException, IOException {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String resourcePath = "ui"+System.getProperty("file.separator")+"img"+System.getProperty("file.separator")+"user";
        if (imageFile != null) {
            if (FileUploadUtil.allowUpload(imageFile.getContentType())) {
                String fileName = FileUploadUtil.rename(imageFile.getOriginalFilename());
                File dir = new File(realPath + resourcePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File file = new File(dir, fileName);
                imageFile.transferTo(file);
                //小头像
                String fileName128 = FileUploadUtil.rename(fileName, "s");
                //大头像
                FileUploadUtil.zipImageFile(file.getAbsolutePath(), 128, 128, 1, fileName128, dir.getAbsolutePath());

                //手机端详情的头像
                user.setAvatar(fileName128);
                user.setAvatar128(fileName);
            }
        }
        return usersService.editUser(request,user, userExt, null);
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:53:19
     * 方法介绍:   删除用户
     * 参数说明:   @param user  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users> 返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/deleteUser")
    public ToJson<Users> deletesUser(String uids, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            usersService.deleteUser(uids,request);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:53:27
     * 方法介绍:   根据uid查询用户
     * 参数说明:   @param uid  用户uid号
     * 参数说明:   @param isSys  是否跳过通讯录权限验证，isSys="true"跳过验证
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/findUserByuid", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public ToJson<Users> findUserByuid(@RequestParam(name = "uid", required = false, defaultValue = "0")Integer uid, HttpServletRequest request,String isSys) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            if(uid==0){
                uid=sessionInfo.getUid();
            }

            Users nowLoginUser = usersService.findUserByuid(sessionInfo.getUid());
            if(uid==1&&nowLoginUser.getUserPriv()!=1){
                json.setMsg("无权限");
                return json;
            }
            Users users = usersService.findUserByuid(uid);
            users.setLastVisitIp("");
            users.setPassword("");
            if(null!=users.getPostId()) {
                try {//设置职务
                    users.setPostName(dutiesManagementMapper.getUserPostId(users.getPostId()).getPostName());
                } catch (Exception e) {
                    //e.printStackTrace();
                }
            }
            users.setLongDepName(departmentService.longDepNames(users.getDeptId()));

            if(!uid.equals(nowLoginUser.getUid())&&(StringUtils.checkNull(isSys)||!"true".equals(isSys))){ //210624修改，当前登录人查看信息不限制通讯录权限
                //getFatherDept 查询用户的顶级部门 判断是否又通讯录权限如果有放出
                if (StringUtils.checkNull(nowLoginUser.getDeptYj())){
                    users.setMobilNo("");
                    users.setBirthday(null);
                    users.setBirthdayStr("");
                    users.setTelNoDept("");
                    users.setEmail("");
                    users.setOicqNo("");
                }
                else {
                    String[] split = nowLoginUser.getDeptYj().split(",");
                    Department fatherDept = departmentService.getFatherDept(users.getDeptId());
                    if (fatherDept != null && !Arrays.asList(split).contains(fatherDept.getDeptId().toString())){
                        users.setMobilNo("");
                        users.setBirthday(null);
                        users.setBirthdayStr("");
                        users.setTelNoDept("");
                        users.setEmail("");
                        users.setOicqNo("");
                    }
                }
            }


            json.setObject(users);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:53:27
     * 方法介绍:   根据userId查询用户
     * 参数说明:   @param uid  用户uid号
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/findUserByuserId", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public ToJson<Users> findUserByuserId(String userId, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);

        try {
            if(StringUtils.checkNull(userId)){
                Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
                userId=user.getUserId();
                Users users = usersService.findUsersByuserId(userId);
                json.setObject(users);
                json.setMsg("OK");
                json.setFlag(0);
            }else {
                Users users = usersService.findUsersByuserId(userId);
                if (users == null) {
                    json.setMsg("err");
                    json.setFlag(1);
                } else {
            /*if (StringUtils.checkNull(users.getBirthday())) {
                users.setBirthday("");
            }*/
                    json.setObject(users);
                    json.setMsg("OK");
                    json.setFlag(0);
                }
            }

        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:53:36
     * 方法介绍:   获取所有用户
     * 参数说明:   @param maps  封装集合对象
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面数据大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return String  返回所有用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getAlluser", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getAllUser(Map<String, Object> maps, Integer page,
                                    Integer pageSize, boolean useFlag,String userName,String deptId,String notLogin, String userIds) {
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            maps.put("notLogin",notLogin);
            maps.put("userName",userName);
            maps.put("deptId",deptId);
            if (!StringUtils.checkNull(userIds)){
                maps.put("userIds",userIds.split(","));
            }
            List<Users> list = usersService.getAlluser(maps, page, pageSize, useFlag);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
    } catch (Exception e) {
        json.setMsg(e.getMessage());
//            System.out.println(e.getMessage());
    }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午6:53:43
     * 方法介绍:   根据多条件查询部门
     * 参数说明:   @param users  用户信息
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getDeptByMany", method = RequestMethod.POST)
    public ToJson<Users> getDeptByMany(Users users, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            List<Users> list = usersService.getUserByMany(users);
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
     * 创建日期:   2017年4月20日 下午7:16:57
     * 方法介绍:   获取用户信息以及部门名称信息
     * 参数说明:   @param maps  集合
     * 参数说明:   @param page  当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     *
     * @return ToJson<Users>  返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getUserAndDept", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getUserAndDept(Map<String, Object> maps, Integer page,
                                        Integer pageSize, boolean useFlag, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            List<Users> list = usersService.getUserAndDept(maps, page, pageSize, useFlag);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());

        }
        return json;
    }

    /**
     * 移动端邮件公告等选人控件(分级机构)
     * 王禹萌
     * 2019/1/10
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/getUserYDD", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getUserAndDept(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return usersService.getUserAndDept(user,request);
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月20日 下午2:28:22
     * 方法介绍:   根据（用户姓名、角色、部门）查询用户信息接口
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
    @RequestMapping(value = "/user/getBySearch", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getBySearch(HttpServletRequest request, Map<String, Object> maps) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            request.setCharacterEncoding("UTF-8");
            String search = request.getParameter("search");
            //String search=URLEncoder.encode(request.getParameter("search"),"utf-8");
            maps = new HashMap<String, Object>();
            maps.put("byName", search);
            maps.put("userId", search);
            maps.put("userName", search);
            maps.put("userPrivName", search);
            maps.put("deptName", search);
            List<Users> list = usersService.getBySearch(maps);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            //System.out.println(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 上午11:49:11
     * 方法介绍:   根据部门id获取所有用户
     * 参数说明:   @param request 请求
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize 页面大小
     * 参数说明:   @param useFlag 是否开启分页
     * 参数说明:   @return
     *
     * @return String  返回部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getByDeptId", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getByDeptId(HttpServletRequest request, Map<String, Object> maps, Integer page,
                                     Integer pageSize, boolean useFlag) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            request.setCharacterEncoding("UTF-8");
            int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));
            maps = new HashMap<String, Object>();
            maps.put("deptId", deptId);
            List<Users> list = usersService.getByDeptId(maps, page, pageSize, useFlag);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            //System.out.println(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月25日 上午10:17:54
     * 方法介绍:   根据uid查询用户姓名、部门、角色信息
     * 参数说明:   @param uid  用户uid
     * 参数说明:   @return
     *
     * @return String 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getByUid", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getByUid(Integer uid, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            Users user = usersService.getByUid(uid);
            json.setObject(user);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
           // System.out.println(e.getMessage());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/user/getUserNameById", method = RequestMethod.GET)
    public ToJson<Users> getUserNameById(String userIds, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        //loger.debug("ID"+user.getUid());
        try {
            String userName = usersService.getUserNameById(userIds);
            json.setObject(userName);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    @RequestMapping(value = "/user/xsu", method = RequestMethod.GET)
    public String xs(HttpServletRequest request) {


        return "app/test/xs";

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 9:37
     * @函数介绍: 根据User的角色或部门id, 查询用户，其他条件可在serverce层扩展 【已修改，现在查询结果不包括禁止登录用户】
     * @参数说明: @param Users
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getUserByCondition")
    public ToJson<Users> getUserByCondition(HttpServletRequest request, Users users) {

        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            //处理头像问题
            String realPath = request.getSession().getServletContext().getRealPath("/"); //获取项目路径

            List<Users> userList1 = usersService.getUsersByCondition(users);
            for(Users entity1:userList1){

                if((!StringUtils.checkNull(entity1.getAvatar())  && !entity1.getAvatar().equals("0") && !entity1.getAvatar().equals("1"))
                          && (!StringUtils.checkNull(entity1.getAvatar128())  && !entity1.getAvatar128().equals("0") && !entity1.getAvatar128().equals("1"))){
                    //小头像不为空，大头像不为空，判断小头像长宽是否超过128
                    String avatarPath=realPath+"ui"+System.getProperty("file.separator")
                            +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                            +entity1.getAvatar();
                    File file=new File(avatarPath);
                    if (file.exists()) {
                        FileInputStream fileInputStream=new FileInputStream(file);
                        BufferedImage sourceImg = ImageIO.read(fileInputStream);
                        if ((sourceImg.getWidth()!=128) && (sourceImg.getHeight()!=128)){
                            //重新修改小头像
                            MultipartFile multipartFile = new MockMultipartFile(
                                    file.getName(),
                                    file.getName(),
                                    ContentType.APPLICATION_OCTET_STREAM.toString(),
                                    new FileInputStream(file));
                            //上传图片并进行修改数据库数据
                            String fileName = FileUploadUtil.rename(multipartFile.getOriginalFilename());
                            File dir = new File(realPath + "ui/img/user");
                            if (dir.exists()) {
                                File realfile = new File(dir, fileName);
                                multipartFile.transferTo(realfile);
                                String fileName128 = FileUploadUtil.rename(fileName, "s");
                                FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, fileName128, dir.getAbsolutePath());
                                Users users1 = new Users();
                                users1.setAvatar(fileName128);
                                users1.setAvatar128(fileName);
                                users1.setUid(entity1.getUid());
                                usersMapper.editUser(users1);
                            }
                        }
                    }
                }else if ((StringUtils.checkNull(entity1.getAvatar128()))
                        &&(!StringUtils.checkNull(entity1.getAvatar())  && !entity1.getAvatar().equals("0") && !entity1.getAvatar().equals("1"))){
                    Users users2 = new Users();
                    users2.setUid(entity1.getUid());

                    //大头像等于空,小头像不为空
                    String avatarPath=realPath+"ui"+System.getProperty("file.separator")
                            +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                            +entity1.getAvatar();
                    File file=new File(avatarPath);
                    if (file.exists()) {
                        BufferedImage sourceImg = ImageIO.read(new FileInputStream(file));
                        if ((sourceImg.getWidth()!=128) && (sourceImg.getHeight()!=128)){
                            //重新修改小头像
                            MultipartFile multipartFile = new MockMultipartFile(
                                    file.getName(),
                                    file.getName(),
                                    ContentType.APPLICATION_OCTET_STREAM.toString(),
                                    new FileInputStream(file));
                            //上传图片并进行修改数据库数据
                            String fileName = FileUploadUtil.rename(multipartFile.getOriginalFilename());
                            File dir = new File(realPath + "ui/img/user");
                            if (dir.exists()) {
                                File realfile = new File(dir, fileName);
                                multipartFile.transferTo(realfile);
                                String fileName128 = FileUploadUtil.rename(fileName, "s");
                                FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, fileName128, dir.getAbsolutePath());

                                users2.setAvatar(fileName128);
                                users2.setAvatar128(fileName);
                            }
                        }else{
                            File dir = new File(realPath + "ui/img/user");
                            if (dir.exists()) {
                                //进行字符替换
                                String sImg = entity1.getAvatar().replace("s", "");
                                File realfile = new File(dir, sImg);
                                FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, entity1.getAvatar(), dir.getAbsolutePath());
                                users2.setAvatar128(sImg);
                            }
                        }
                        usersMapper.editUser(users2);
                    }
                }else if ((StringUtils.checkNull(entity1.getAvatar()))
                        &&(!StringUtils.checkNull(entity1.getAvatar128())  && !entity1.getAvatar128().equals("0") && !entity1.getAvatar128().equals("1"))){
                    //小头像为空，大头像不为空
                    String avatarPath2=realPath+"ui"+System.getProperty("file.separator")
                            +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                            +entity1.getAvatar128();
                    File file2=new File(avatarPath2);
                    MultipartFile multipartFile = new MockMultipartFile(
                            file2.getName(),
                            file2.getName(),
                            ContentType.APPLICATION_OCTET_STREAM.toString(),
                            new FileInputStream(file2));
                    File dir = new File(realPath + "ui/img/user");
                    if (dir.exists()) {
                        String fileName128 = FileUploadUtil.rename(entity1.getAvatar128(), "s");
                        //压缩完保存图片
                        File realfile = new File(dir, entity1.getAvatar128());
                        multipartFile.transferTo(realfile);

                        Users users3 = new Users();
                        users3.setAvatar(fileName128);
                        users3.setUid(entity1.getUid());
                        usersMapper.editUser(users3);
                    }
                }
            }

            List<Users> userList = usersService.getUsersByCondition(users);
            for(Users entity:userList){
                if(!StringUtils.checkNull(entity.getAvatar( ))){
                    if(!"0".equals(entity.getAvatar()) && !"1".equals(entity.getAvatar())){
                        String avatarPath=realPath+"ui"+System.getProperty("file.separator")
                                +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                                +entity.getAvatar();
                        File file=new File(avatarPath);
                        if(!file.exists()){
                            if(!StringUtils.checkNull(entity.getSex())){
                                entity.setAvatar(entity.getSex());
                            }else{
                                entity.setAvatar("0");
                            }
                        }
                    }
                }else{
                    if(!StringUtils.checkNull(entity.getSex())){
                        entity.setAvatar(entity.getSex());
                    }else{
                        entity.setAvatar("0");
                    }
                }

            }

            // 人员部门排序
            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            }catch (Exception e){

            }
            try {
                if ("1".equals(order)) {
                    for (Users users1 : userList) {   //对的排序  先获得这个用户在在该部门排序号
                        if (!StringUtils.checkNull(users1.getUserId()) && null != users.getDeptId()){
                            users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), users.getDeptId()).getOrderNo());
                        }
                    }
                    Collections.sort(userList, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            }catch (Exception e){
                e.printStackTrace();
            }

            json.setObject(userList);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/7/27
     * 说明: 根据User的角色或部门id, 查询用户 用于用户管理模块树结构遍历 查询所有用户
     */
    @ResponseBody
    @RequestMapping(value = "/getUserByConditionExt")
    public ToJson<Users> getUserByConditionExt(HttpServletRequest request, Integer deptId,Integer userPriv) {

        ToJson<Users> json = new ToJson<Users>(0, null);
        try {

            List<Users> userList = usersService.getUserByConditionExt(deptId,userPriv);
            for(Users entity:userList){
                //处理头像问题
                String realPath = request.getSession().getServletContext().getRealPath("/");//获取项目路径
                if(!StringUtils.checkNull(entity.getAvatar())){
                    if(!"0".equals(entity.getAvatar())&&!"1".equals(entity.getAvatar())){
                        String avatarPath=realPath+"ui"+System.getProperty("file.separator")
                                +"img"+System.getProperty("file.separator")+"user"+System.getProperty("file.separator")
                                +entity.getAvatar();
                        File file=new File(avatarPath);
                        if(!file.exists()){
                            if(!StringUtils.checkNull(entity.getSex())){
                                entity.setAvatar(entity.getSex());
                            }else{
                                entity.setAvatar("0");
                            }
                        }
                    }
                }else{
                    if(!StringUtils.checkNull(entity.getSex())){
                        entity.setAvatar(entity.getSex());
                    }else{
                        entity.setAvatar("0");
                    }
                }

            }
            json.setObject(userList);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 11:07
     * @函数介绍: 查询在线用户
     * @参数说明: HttpServletRequest
     * @return: json
     **/
    @ResponseBody
    @RequestMapping("/getUserOnline")
    public ToJson<Users> getUserOnline(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<Users> json = new ToJson<Users>(0, null);
        try {

            List<Users> userList = usersService.getUsersOnline();
            json.setObject(userList);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;

    }

    @ResponseBody
    @RequestMapping("/getUserbyCondition")
    public ToJson<Users> getUserbyCondition(
            @RequestParam(value = "userId", required = false,defaultValue = "") String userId,
            @RequestParam(value = "userName", required = false,defaultValue = "") String userName,
            @RequestParam(value = "sex", required = false,defaultValue = "") String sex,
            @RequestParam(value = "deptId", required = false,defaultValue = "") String deptId,
            @RequestParam(value = "userPrivNo", required = false,defaultValue = "") String userPrivNo,
            @RequestParam("choice") String choice,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
        if ("-1".equals(deptId)) {
            deptId = "";
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("userId", userId);
        maps.put("userName", userName);
        maps.put("sex", sex);
        maps.put("deptId", deptId);
        maps.put("userPrivNo", userPrivNo);
        ToJson<Users> usersJson = new ToJson<Users>();
        List<Users> userToJson = null;
        try{
            userToJson = usersService.getUserbyCondition(maps);
        }catch (Exception e){
            e.printStackTrace();
        }
        if ("1".equals(choice)) {
            if (userToJson.size() > 0) {
                usersJson.setFlag(0);
                usersJson.setMsg("ok");
                usersJson.setObj(userToJson);
            } else {
                usersJson.setFlag(1);
                usersJson.setMsg("err");
            }
        } else if ("2".equals(choice)) {
            try {
                for(Users users:userToJson){
                    users.setSex("0".equals(users.getSex())?"男":"女");
                }
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("用户信息导出", 9);
             /*   String[] secondTitles = {"用户名","密码",     "部门",      "姓名",    "性别",      "角色",            "用户排序号",     "管理范围",    "手机",      "IP",     "工作电话",  "工作传真",  "家庭地址",   "邮编",  "家庭电话","电子邮件","QQ","MSN"};*/
                String[] secondTitles = {"部门","角色", "姓名",  "在线时长",  "性别", "工作电话",  "手机",  "电子邮件"};

                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
/*
                String[] beanProperty = {"byname","passWord", "deptName","userName", "sex", "roleAuxiliaryName",     "userNo",   "postPriv",     "mobilNo","bindIp", "telNoDept","faxNoDept","addHome","postNoHome",  "telNoHome","email","oicqNo","msn"};
*/
                String[] beanProperty = {"deptName","userPrivName", "userName","online", "sex","telNoDept", "mobilNo","email"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, userToJson, beanProperty);
                ServletOutputStream out = response.getOutputStream();

                String filename = "用户信息导出.xls";
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            usersJson.setFlag(1);
            usersJson.setMsg("err");
        }

        return usersJson;
    }

    /**
     * 跨企业部门管理查询接口
     * @param userId
     * @param userName
     * @param sex
     * @param deptId
     * @param userPrivNo
     * @param choice
     * @param sql
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @ResponseBody
    @RequestMapping("/getUserbyCondition1")
    public ToJson<Users> getUserbyCondition1(
            @RequestParam(value = "userId", required = false,defaultValue = "") String userId,
            @RequestParam(value = "userName", required = false,defaultValue = "") String userName,
            @RequestParam(value = "sex", required = false,defaultValue = "") String sex,
            @RequestParam(value = "deptId", required = false,defaultValue = "") String deptId,
            @RequestParam(value = "userPrivNo", required = false,defaultValue = "") String userPrivNo,
            @RequestParam("choice") String choice,String sql,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        String sqlType = "xoa"+ sql;
        ContextHolder.setConsumerType(sqlType);
        if ("-1".equals(deptId)) {
            deptId = "";
        }
        Map<String, Object> maps = new HashMap<String, Object>();
        maps.put("userId", userId);
        maps.put("userName", userName);
        maps.put("sex", sex);
        maps.put("deptId", deptId);
        maps.put("userPrivNo", userPrivNo);
        ToJson<Users> usersJson = new ToJson<Users>();
        List<Users> userToJson = null;
        try{
            userToJson = usersService.getUserbyCondition(maps);
        }catch (Exception e){
            e.printStackTrace();
        }
        if ("1".equals(choice)) {
            if (userToJson.size() > 0) {
                usersJson.setFlag(0);
                usersJson.setMsg("ok");
                usersJson.setObj(userToJson);
            } else {
                usersJson.setFlag(1);
                usersJson.setMsg("err");
            }
        } else if ("2".equals(choice)) {
            try {
                for(Users users:userToJson){
                    users.setSex("0".equals(users.getSex())?"男":"女");
                }
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("用户信息导出", 9);
             /*   String[] secondTitles = {"用户名","密码",     "部门",      "姓名",    "性别",      "角色",            "用户排序号",     "管理范围",    "手机",      "IP",     "工作电话",  "工作传真",  "家庭地址",   "邮编",  "家庭电话","电子邮件","QQ","MSN"};*/
                String[] secondTitles = {"部门","角色", "姓名",  "在线时长",  "性别", "工作电话",  "手机",  "电子邮件"};

                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
/*
                String[] beanProperty = {"byname","passWord", "deptName","userName", "sex", "roleAuxiliaryName",     "userNo",   "postPriv",     "mobilNo","bindIp", "telNoDept","faxNoDept","addHome","postNoHome",  "telNoHome","email","oicqNo","msn"};
*/
                String[] beanProperty = {"deptName","userPrivName", "userName","online", "sex","telNoDept", "mobilNo","email"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, userToJson, beanProperty);
                ServletOutputStream out = response.getOutputStream();

                String filename = "用户信息导出.xls";
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            usersJson.setFlag(1);
            usersJson.setMsg("err");
        }

        return usersJson;
    }
    /**
     * 根据deptId查询所属部门的所有员工信息
     *
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "user/getUsersByDeptId")
    public ToJson<Users> getUsersByDeptId(HttpServletRequest request,String deptId) {
        ToJson<Users> json = new ToJson<Users>();
        List<Users> usersList=new ArrayList<Users>();
        try {
            if(StringUtils.checkNull(deptId)){
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
                usersList = usersService.getUsersByDeptId(users.getDeptId());
            }else{
                usersList = usersService.getUsersByDeptId(Integer.valueOf(deptId));
            }

            String order = null;
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            }catch (Exception e){

            }

            try {
                if ("1".equals(order)) {
                    for (Users users1 : usersList) {   //对的排序  先获得这个用户在在该部门排序号
                        if (!StringUtils.checkNull(users1.getUserId())) {
                            users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), Integer.parseInt(deptId)).getOrderNo());
                        }
                    }
                    Collections.sort(usersList, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                    //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                }
            }catch (Exception e){
                e.printStackTrace();
            }

            json.setObj(usersList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-08-03 14:14
     * 方法介绍: 根据部门ID 查询用户信息（只查询角色排序号大于自己的）
     * @param request
     * @param deptId
     * @return com.xoa.util.ToJson<com.xoa.model.users.Users>
     */
    @ResponseBody
    @RequestMapping(value = "user/getUsersNoByDeptId")
    public ToJson<Users> getUsersNoByDeptId(HttpServletRequest request,Integer deptId) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>(1,"err");
        try {
            if(deptId == null){
                deptId = users.getDeptId();
            }
            List<Users> usersList = usersService.getUsersNoByDeptId(Integer.valueOf(users.getUserPrivNo()),deptId);
            json.setObj(usersList);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
           e.printStackTrace();
           json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   获取空密码用户信息
     * 参数说明:   @param uid
     */
    @ResponseBody
    @RequestMapping(value = "user/getNullPwUsers")
    public ToJson<Users> getNullPwUsers(@RequestParam(value = "deptId", required = false) Integer deptId) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            List<Users> nullPwUsers = usersService.getNullPwUsers(deptId);
            json.setObj(nullPwUsers);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20
     * 方法介绍:   根据部门id和是否允许登陆获取所有用户
     * 参数说明:   @param request 请求
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize 页面大小
     * 参数说明:   @param useFlag 是否开启分页
     * 参数说明:   @return
     *
     * @return String  返回是否允许登陆的用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/getUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getByNotLogin(HttpServletRequest request, Integer deptId ,String notLogin , Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag) {
        ToJson<Users> json = new ToJson<Users>(0, null);
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
        String userFunctionStr = userFunctionMapper.getUserFuncIdStr(users.getUserId());
        String [] f = userFunctionStr.split(",");
        if (!Arrays.asList(f).contains("33")){
            json.setFlag(1);
            json.setMsg("越权");
            return json;
        }

        try {
            maps = new HashMap<String, Object>();
            if (deptId != null) {
                maps.put("deptId", deptId);
            }
            if (notLogin != null && notLogin != "" ) {
                maps.put("notLogin", notLogin);
            }
            List<Users> list = usersService.getByDeptId(maps, page, pageSize, useFlag);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
//            System.out.println(e.getMessage());
        }
        return json;
    }

    /**
     * 根据部门Id查询部门下所有人员
     * 王禹萌
     * 2017-07-25 11：08
     * @param request
     * @param maps
     * @param page
     * @param pageSize
     * @param useFlag
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/getAllByDeptId", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getAllByDeptId(HttpServletRequest request, Map<String, Object> maps, Integer page,
                                        Integer pageSize, boolean useFlag) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            request.setCharacterEncoding("UTF-8");
            int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));
            maps = new HashMap<String, Object>();
            maps.put("deptId", deptId);
            //
            List<Users> list = usersService.getAllByDeptId(maps, page, pageSize, useFlag);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
//            System.out.println(e.getMessage());
        }
        return json;

    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   清空密码
     * 参数说明:   @param uid
     */
    @ResponseBody
    @RequestMapping(value = "user/clearPassword")
    public ToJson<Users> clearPassword(String uids,HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(users.getUserId() + "");
        sysLog.setType(11);
        sysLog.setTypeName("admin清空密码");
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
        try {
            usersService.clearPassword(uids);
            if (!StringUtils.checkNull(uids)) {
                String[] split = uids.split(",");
                for(int i = 0 ;i<split.length;i++) {
                    Users users1 = usersMapper.getUserByUid(Integer.valueOf(split[i]));
                    sysLog.setRemark("["+users1.getDeptName()+"],"+users1.getUserName()+","+users1.getUserId());
                    sysLog.setTime(new Date(System.currentTimeMillis()));
                    syslogMapper.save(sysLog);
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   清空在线时长
     * 参数说明:   @param uid
     */
    @ResponseBody
    @RequestMapping(value = "user/clearOnLine")
    public ToJson<Users> clearOnLine(String uids) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            usersService.clearOnLine(uids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   设置禁止登陆
     * 参数说明:   @param uid
     */
    @ResponseBody
    @RequestMapping(value = "user/setNotLogin")
    public ToJson<Users> setNotLogin(String uids) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            usersService.setNotLogin(uids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   批量修改部门
     * 参数说明:   @param uids
     * 参数说明:   @param deptId
     */
    @ResponseBody
    @RequestMapping(value = "user/editUsersDeptId")
    public ToJson<Users> editUsersDeptId(Integer deptId, String uids, Integer nowDeptId,HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            ToJson toJson = usersService.editUsersDetId(deptId, uids, nowDeptId,request);
            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("修改失败");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2021年3月16日
     * 方法介绍:   设置允许登陆
     * 参数说明:   @param uid
     */
    @ResponseBody
    @RequestMapping(value = "user/setAllowLogin")
    public ToJson<Users> setAllowLogin(String uids) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            usersService.setAllowLogin(uids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   根据uids获取多个用户信息
     * 参数说明:   @param uids
     */
    @ResponseBody
    @RequestMapping(value = "user/getUsersByUids")
    public ToJson<Users> getUsersByUids(String uids) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            List<Users> usersByUids = usersService.getUsersByUids(uids);
            json.setObj(usersByUids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年6月20日
     * 方法介绍:   保存界面设置信息
     * 参数说明:
     * 参数说明:   @return
     *
     * @return String 返回界面信息
     */

    @ResponseBody
    @RequestMapping(value = "users/addAndApplicationUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> addAndApplicationUsers(HttpServletRequest request, Users users) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            usersService.updateUserTheme(users, request);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2017年6月20日
     * 方法介绍:   查询界面设置信息
     * 参数说明:
     * 参数说明:   @return
     *
     * @return String 返回界面信息
     */
    @ResponseBody
    @RequestMapping(value = "/users/showInformation")
    public ToJson<Users> selectList(HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(1, "error");
        try {
            Users users = new Users();
            List<Users> list = usersService.selectList(users);
            if (list.size() > 0) {
                json.setObj(list);
                json.setMsg("ok");
                json.setFlag(0);
            } else {
                json.setMsg("没有数据！");
                json.setFlag(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 17:54
     * @函数介绍: 修改密码
     * @参数说明: @param paramname paramintroduce
     * @return: json
     **/

    @RequestMapping(value = "/editPwd")
    @ResponseBody
    public ToJson<Object> editPwd(HttpServletRequest request, Users user, String newPwd) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Object> json = new ToJson<Object>(0, null);

        String msg = null;
        try {

            msg = usersService.editPwd(request, user, newPwd);

            if ("ok".equals(msg)) {
                user.setLastVisitTime(new Date());
                usersService.updateLoginTime(user);
                json.setMsg("ok");
                json.setFlag(0);
            } else if ("原密码错误".equals(msg)) {
                json.setFlag(1);
                json.setMsg(msg);
            }
        } catch (Exception e) {
            json.setMsg("1");
            json.setMsg("修改失败");
            L.e("user editPwd:" + e);
        }
        return json;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 19:00
     * @函数介绍: 获取当前用户的用户名
     * @参数说明: @param void
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/getLoginUser")
    public ToJson<String> getLoginUser(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<String> json = new ToJson<String>(0, null);

        String msg = null;
        try {
            Users user = usersService.getLoginUser(request);
            if(user!=null){
                json.setMsg("ok");
                json.setFlag(0);
                json.setObject(user);
            }
            // 获取当前用户的白名单对应的名字
            ModulePriv modulePriv = modulePrivMapper.selectWhiteListNameByUid(user.getUid());
            user.setModulePriv(modulePriv);

            // 获取当前用户的个人文件柜的容量限制
            UserExt userExt = new UserExt();
            Integer olderCapacity = userExtMapper.selectFolderCapacityByUserId(user.getUserId());

            userExt.setFolderCapacity(olderCapacity);
            user.setUserExt(userExt);
            user.setDeptName(departmentMapper.getDeptNameById(user.getDeptId()));//前端反映有的电脑不返回部门名称，故查询一次
            /*json.setMsg("ok");
            json.setFlag(0);
            json.setObject(user.getUserId());*/
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("user getLoginUser:" + e);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/getUsersByuserId")
    public ToJson<String> getUsersByuserId(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<String> json = new ToJson<String>(0, null);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        String msg = null;
        try {

            Users user = usersService.getUsersByuserId(users.getUserId());
            if(user!=null){
                json.setMsg("ok");
                json.setFlag(0);
                json.setObject(user);
            }
            /*json.setMsg("ok");
            json.setFlag(0);
            json.setObject(user.getUserId());*/
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("user getUsersByuserId:" + e);
        }
        return json;
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/6/30
     * @函数介绍: 查询新增加的用户
     * @参数说明: 无
     **/
    @ResponseBody
    @RequestMapping(value = "user/getNewUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> getNewUsers(String deptNo) {
        return usersService.getNewUsers(deptNo);
    }

    /**
     * @创建作者: 张航宁
     * @创建日期: 2017/7/1
     * @函数介绍: 查询单个用户
     * @参数说明: 无
     **/
    @ResponseBody
    @RequestMapping(value = "/user/getUserByuid", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.GET)
    public ToJson<Users> getUserByuid(int uid, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);
        String sqlType = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        int uuid = user.getUid();

        try {
            Users users = null;
            if(String.valueOf(uid).equals("-1")){
                 users = usersService.getUserByUid(uuid,sqlType);
            }else {
                 users = usersService.getUserByUid(uid,sqlType);
            }

            /*if (StringUtils.checkNull(users.getBirthday())) {
                users.setBirthday("");
            }*/
            json.setObject(users);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/7/3 13:56
     * @函数介绍: 获取登录用户主题
     * @参数说明: @param request
     * @return: json
     **/
    @ResponseBody
    @RequestMapping(value = "/users/getUserTheme", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public ToJson<Users> getUserTheme(HttpServletRequest request) {

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Users> json = new ToJson<Users>(0, null);

        String msg = null;
        try {

            Users user = usersService.getLoginUserTheme(request);
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(user);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            L.e("user getUserTheme:" + e);
        }
        return json;

    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月4日
     * 方法介绍:   查询和导出接口
     * 参数说明:   @param  user,sortType,isExport
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/queryExportUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> queryExportUsers(HttpServletRequest request, HttpServletResponse response, Users user, String sortType, String isExport ,String notLogin,
                                           Integer page, Integer pageSize,
                                          @RequestParam(name = "useFlag", required = false, defaultValue = "false") Boolean useFlag,String deptNo,
                                          @RequestParam(name = "type",required = false, defaultValue = "2") Integer type) {
        //2019-12-24 增加type参数，用于区分 分级机构-分级机构用户管理和组织机构设置-用户管理的用户查询或导出
        return usersService.queryExportUsers(request, response, user, sortType, isExport,notLogin,page,pageSize,useFlag,deptNo,type);
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月4日
     * 方法介绍:   插入和导入接口
     * 参数说明:   @param  file
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/insertImportUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> insertImportUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file,String ifUpdate, String psWord, String userPriv) {
        return usersService.insertImportUsers(request, response, session, file,ifUpdate, psWord, userPriv);
    }


    /**
     * 创建作者:   zlf
     * 创建日期:   2017年7月4日
     * 方法介绍:   插入和导入教育局用户信息接口（由航宁接口修改）
     * 参数说明:   @param  file
     * 参数说明:
     *
     * @return ToJson 返回用户信息
     */
    @ResponseBody
    @RequestMapping(value = "/user/insertImportUsersByEdu", produces = {"application/json;charset=UTF-8"})
    public AjaxJson insertImportUsersByEdu(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file, String ifUpdate, String pw, String userPriv,
                                           @RequestParam(value="rule", required =false) String rule) {
        return usersService.insertImportUsersByEdu(request, response, session, file,ifUpdate, pw, userPriv, rule);
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
    @ResponseBody
    @RequestMapping(value = "/user/editUserBatch", produces = {"application/json;charset=UTF-8"}, method = RequestMethod.POST)
    public ToJson<Users> editUserBatch(Users user, UserExt userExt,
                                       @RequestParam(required = false) String modulePrivIds,
                                       @RequestParam(required = false) String privIds,
                                       @RequestParam(required = false) String deptIds,
                                       @RequestParam(required = false) String uids,
                                       HttpServletRequest request) {

        return usersService.editUserBatch(user, userExt, modulePrivIds,privIds,deptIds,uids,request);
    }

    @ResponseBody
    @RequestMapping(value = "/user/singleSearch", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> singleSearch(HttpServletRequest request,String searchData){
        return usersService.singleSearch(searchData);
    }

    @ResponseBody
    @RequestMapping(value="/user/getAnalysis",produces = {"application/json;charset=UTF-8"})
    public ToJson<Object> userAnalysis(String type, HttpServletRequest request){
        return usersService.userAnalysis(type);
    }


    /**
     * 创建作者：牛江丽
     * 方法介绍：修改扩展信息，包括昵称、用户名片图片、讨论区签名档
     * @param request
     * @param users
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/editUserExt")
    public ToJson<Users> editUserExt(HttpServletRequest request,MultipartFile imageFile,Users users,UserExt userExt)throws IllegalStateException, IOException{
        return usersService.editUserExt(request,imageFile,users,userExt);
    }

    @ResponseBody
    @RequestMapping("/user/editUserSign")
    public ToJson editUserSign(HttpServletRequest request,String sign){
        return usersService.editUserSign(request,sign);
    }
    /**
     * 获取当前登陆人及其部门的全部信息
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/userCookie")
    public ToJson userCookie(HttpServletRequest request){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Users> usersToJson=new ToJson<Users>();
        usersToJson.setFlag(0);
        usersToJson.setMsg("ok");
        usersToJson.setObject(users);
        return usersToJson;
    }
    /**
     * 创建作者：季佳伟
     * 方法介绍：根据别名查询用户所有信息
     * @param
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/selectUserAllInfoByName")
    public ToJson<Users> selectUserAllInfoByName(String byname, HttpServletRequest req) {
        ToJson<Users> json = new ToJson<Users>(0, null);
        try {
            String   loginId = (String) req.getSession().getAttribute(
                    "loginDateSouse");
            Users user = usersService.findUserByName(byname,req);
            json.setObject(user);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 用户头像上传
     * @param request
     * @param file
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/upload",method={RequestMethod.POST},produces = {"application/json;charset=UTF-8"})
    public BaseWrapper uploadImg(HttpServletRequest request, MultipartFile file){
        return usersService.uploadImg(request,file);
    }


    @Autowired
    ImgUpUtils imgUpUtils;
    @ResponseBody
    @RequestMapping("/user/imgae/update")
    public BaseWrapper updateImg(HttpServletRequest request){
        return imgUpUtils.updateUserImgaes(request);
    }
    /**
     * 创建作者：韩东堂
     * 方法介绍：修改扩展信息，包括昵称、用户名片图片、讨论区签名档
     * @param request
     * @param users
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/editUserExtNew")
    public ToJson<Users> editUserExtNew(HttpServletRequest request,Users users,UserExt userExt)throws IllegalStateException, IOException{
        return usersService.editUserExtNew(request,users,userExt);
    }

    /**
     * 创建作者：韩东堂
     * 方法介绍：修改扩展信息，包括昵称、用户名片图片、讨论区签名档
     * @param request
     * @param users
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/editNewUserImg")
    public ToJson<Users> editNewUserImg(HttpServletRequest request,Users users,UserExt userExt)throws IllegalStateException, IOException{
        return usersService.editUserImg(request,users,userExt);
    }

    /**
     * 创建作者:  牛江丽
     * 创建日期:   2017-11-22
     * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
     * 参数说明:   @param name
     * 参数说明:   @return List<Users>
     */
    @ResponseBody
    @RequestMapping("/user/getByName")
    public ToJson<Users> getByName(String name){
        return usersService.getByName(name);
    }


    /**
     * 创建作者:  郭富强
     * 创建日期:   2018-1-16
     * 方法介绍:   根据deptId查询当前部门用户姓名
     * 参数说明:   @param name
     * 参数说明:   @return List<String>
     */
    @ResponseBody
    @RequestMapping("/user/getuserNameByDeptId")
    public ToJson getuserNameByDeptId(String deptId){
        if(deptId.endsWith(",")){
            deptId = deptId.substring(0,deptId.length()-1);
        }
        return  usersService.getuserNameByDeptId(Integer.valueOf(deptId));
    }

    @ResponseBody
    @RequestMapping("/user/selectuidByName")
    public ToJson selectuidByName(String userName){
       /* if(deptId.endsWith(",")){
            deptId = deptId.substring(0,deptId.length()-1);
        }*/
        /*return  usersService.getuserNameByDeptId(Integer.valueOf(deptId));*/
        return  usersService.selectuidByName(userName);
    }
    @ResponseBody
    @RequestMapping("/user/getUserDepartmentUserexe")
    public ToJson getUserDepartmentUserexe(String deptId, String dutyType,
                                           String uids ){
       /* if(deptId.endsWith(",")){
            deptId = deptId.substring(0,deptId.length()-1);
        }*/
        /*return  usersService.getuserNameByDeptId(Integer.valueOf(deptId));*/
        return  usersService.getUserDepartmentUserexe(deptId,dutyType,uids);
    }


    @ResponseBody
    @RequestMapping("/user/checkUserCount")
    public BaseWrapper checkUserCount(HttpServletRequest request){
        return  usersService.checkUserCount(request);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/3/26
     * 说明: 修正用户  目前用于修正用户的拼音缩写 如果需要添加其他 请加注释
     */
    @ResponseBody
    @RequestMapping("/user/correctUsers")
    public ToJson<Users> correctUsers(HttpServletRequest request){
        return usersService.correctUsers(request);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/3/26
     * 说明: 用户修正页面
     */
    @RequestMapping("/user/correct")
    public String usersCorrectPage(){
        return "app/user/correct";
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/4/22
     * 说明: 获取密码设置规则
     */
    @ResponseBody
    @RequestMapping("/user/getPwRule")
    public ToJson<Map> getPwRule(){
        return usersService.getPwRule();
    }

    /**
     * 作者: 高亚峰
     * 日期: 2018/4/22
     * 说明: 统计用户在线人数
     */
    @ResponseBody
    @RequestMapping("/user/getOnlineCount")
    public ToJson<Object> getOnlineCount(HttpServletRequest request){
        return usersService.getOnlineCount(request);
    }
    /**
     * 作者: 高亚峰
     * 日期: 2018/4/22
     * 说明: 查看用户在线的数据
     */
    @ResponseBody
    @RequestMapping("/user/getOnlineMap")
    public ToJson<Object> getOnlineMap(HttpServletRequest request){
        return usersService.getOnlineMap(request);
    }
    /**
     * 作者: 高亚峰
     * 日期: 2018/4/22
     * 说明: 查看用户在线的数据
     */
    @ResponseBody
    @RequestMapping("/user/getOnlinePeople")
    public ToJson<Users> getOnlinePeople(HttpServletRequest request){
        return usersService.getOnlinePeople(request);
    }

    /**
     * 作者: 高亚峰
     * 日期: 2018/5/06
     * 说明: 批量修改5/2号之前的用户名密码
     */
    @ResponseBody
    @RequestMapping("/user/updatePassword")
    public ToJson<Object> updatePassword(){
        return usersService.updatePassword();
    }

    /**
     * 作者: 高亚峰
     * 日期: 2018/5/06
     * 说明: 批量修改5/2号之前的用户名密码
     */
    @ResponseBody
    @RequestMapping("/user/updatemobile")
    public ToJson<Users> updatemobile(){
        return usersService.updatemobile();
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/5/16
     * 说明: 获取当前用户所在的部门
     */
    @ResponseBody
    @RequestMapping("/user/selNowUsers")
    public ToJson<Users> selNowUsers(HttpServletRequest request){
        return usersService.selNowUsers(request);
    }

    /**
     * 作者: 高亚峰
     * 日期: 2018/7/10
     * 说明: 获取当前用户以及子部门用户
     */
    @ResponseBody
    @RequestMapping("/user/selNewNowUsers")
    public ToJson<Users> selNewNowUsers(HttpServletRequest request){
        return usersService.selNewNowUsers(request);
    }
    /**
     * 作者: 高亚峰
     * 日期: 2018/7/10
     * 说明: 获取当前部门（以及子部门）下所有的用户
     */
    @ResponseBody
    @RequestMapping("/department/getNewChDept")
    public ToJson<Users> getNewChDept(HttpServletRequest request,Integer deptId){
        return usersService.getNewChDept(request,deptId);
    }
    /**
     * 作者: 高亚峰
     * 日期: 2018/7/10
     * 说明: 根据当前部门下的人员，子部门名称以及下的人员
     */
    @ResponseBody
    @RequestMapping("/department/getNewChAllDept")
    public ToJson<Department> getNewChAllDept(HttpServletRequest request, String deptId){
        return usersService.getNewChAllDept(request,deptId);
    }
    /**
     * 作者: 高亚峰
     * 日期: 2018/7/12
     * 说明: 根据角色查询信息
     */
    @ResponseBody
    @RequestMapping("/user/getUserByUserPriv")
    public ToJson<UserPriv> getUserByUserPriv(HttpServletRequest request, Integer userPriv){
        return usersService.getUserByUserPriv(request,userPriv);
    }

    /**
     * 作者: 张航宁
     * 日期: 2018/5/16
     * 说明: 获取当前用户所在的部门
     */
    @ResponseBody
    @RequestMapping("/user/selNowUsersPlus")
    public ToJson<Users> selNowUsersPlus(HttpServletRequest request,String OID){
        if(OID!=null||"".equals(OID)){
            ContextHolder.setConsumerType("xoa" +OID);
        }
        return usersService.selNowUsers(request);
    }

    /**
     * 作者: 高亚峰
     * 日期: 2018/7/13
     * 说明: 查询是否存在该用户
     */
    @ResponseBody
    @RequestMapping("/user/selectIsExistUser")
    public ToJson<Object> selectIsExistUser(String byname,String uid){
        return usersService.selectIsExistUser(byname,uid);
    }
//通讯录查询
    @ResponseBody
    @RequestMapping(value = "user/queryUsers", produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> queryUsers(HttpServletRequest request, HttpServletResponse response, Users user,Integer page,Integer pageSize,  String isExport) {
        return usersService.queryUsers(request, response,page,pageSize,user, isExport);
    }

    /**
     * 作者: 张丽军
     * 日期: 2018/10/18
     * 说明: 获取服务器的时间
     */
    @ResponseBody
    @RequestMapping("/getDate")
    public ToJson<Users> getDate(HttpServletRequest request){
        return usersService.getDate(request);
    }

    /**
     * 作者: 张航宁
     * 日期: 2019/05/15
     * 说明: 获取当前登陆用户的信息
     */
    @ResponseBody
    @RequestMapping("/user/getNowLoginUser")
    public ToJson<Users> getNowLoginUser(HttpServletRequest request){
        return usersService.getNowLoginUser(request);
    }

    /**
     * 绑定用户动态密码卡信息
     * 张丽军
     * 2019-7-29
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/bindUserInfo",produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> bindUserInfo(HttpServletRequest request,Integer uid,String cardNumber){
        return usersService.bindUserInfo(request,uid,cardNumber);
    }

    /**
     * 批量绑定用户动态密码卡信息
     * 张丽军
     * 2019-7-29
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/imputBindUserInfo",produces = {"application/json;charset=UTF-8"})
    public ToJson<Users> imputBindUserInfo(HttpServletRequest request, HttpServletResponse response, HttpSession session, MultipartFile file){
        return usersService.imputBindUserInfo(request,response,file);
    }
    /*
    查询是否有这个手机号   短信登陆
     */
    @ResponseBody
    @RequestMapping("/selectByMobilNo")//查询合同
    public ToJson<Users> selectByMobilNo(HttpServletRequest request,@RequestParam("mobilNo") String mobilNo){
        return usersService.selectByMobilNo(request,mobilNo);
    }
    /*
    修改密码时判断身份证和电话号
     */
    @ResponseBody
    @RequestMapping("/selectByIdAndMobilNo")//查询合同
    public ToJson<Users> selectByIdAndMobilNo(HttpServletRequest request,@RequestParam("idNumber") String idNumber,@RequestParam("mobilNo") String mobilNo){
        return usersService.selectByIdAndMobilNo(request,idNumber,mobilNo);
    }

    //修改快捷菜单id串
    @ResponseBody
    @RequestMapping(value = "/user/updateshortcut",produces = {"application/json;charset=UTF-8"})
    public void updateshortcut(Users users,HttpServletRequest request){
        usersService.updateshortcut(users, request);
    }


    @ResponseBody
    @RequestMapping(value = "/updateKanBan")
    public ToJson<Users> updateKanBan(String myStatus,HttpServletRequest request){
        return usersService.updateKanBan(myStatus,request);
    }
    @ResponseBody
    @RequestMapping(value = "/selectKanBan")
    public ToJson<Users> selectKanBan(HttpServletRequest request){
        return usersService.selectKanBan(request);
    }

    /**
     * 方法介绍:   重写上面updateUserFunByUid方法（无拦截器）
     */
    @ResponseBody
    @RequestMapping(value = "/user/updateUserFunByUserId")
    public ToJson<UserPriv> updateUserFunByUserId(String userId, String funcIds, int sign) {
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
            L.e("/user/updateUserFunByUserId:" + e);
        }
        return json;
    }

    /**
     * 判断两个人主部门是否一样
     * @param request
     * @param userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/CheckDeptCoincident")
    public String  CheckDeptCoincident(HttpServletRequest request, String userId){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        Users usersByuserId = usersMapper.findUsersByuserId(userId);
        String useFlag = "0";
        if (users.getDeptId().equals(usersByuserId.getDeptId())){
            useFlag = "1";//同一个部门
        }
        return useFlag;
    }

    /**
     * 判断多个人主部门或辅助部门与当前登录人是否一样
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/user/CheckDeptOtherCoincident")
    public String  CheckDeptOtherCoincident(HttpServletRequest request, String userIds){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String useFlag = null;
        StringBuffer sb = new StringBuffer();
        if (!StringUtils.checkNull(userIds)){
            String[] split1 = userIds.split(",");
            for (String userId:split1){
                useFlag = "0";
                Users usersByuserId = usersMapper.findUsersByuserId(userId);
                if (users.getDeptId().equals(usersByuserId.getDeptId())){ // 当前登陆人主部门 与被选择人主部门 i i
                    useFlag = "1";//同一个部门
                }
                if (!StringUtils.checkNull(usersByuserId.getDeptIdOther())) {
                    String[] split = usersByuserId.getDeptIdOther().split(",");
                    for (String list : split) {
                        if (users.getDeptId().equals(Integer.parseInt(list))) { // 当前登陆人主部门 与被选择人辅助部门 i i
                            useFlag = "1";//同一个部门
                        }
                    }
                }
                if(!StringUtils.checkNull(users.getDeptIdOther())){ // 当前登陆人辅助部门 与被选择人主部门
                    String[] split = users.getDeptIdOther().split(",");
                    for (String user:split){
                        if (user.equals(String.valueOf(usersByuserId.getDeptId()))){ // s s
                            useFlag = "1";//同一个部门
                        }
                        if (!StringUtils.checkNull(usersByuserId.getDeptIdOther())) {
                            String[] split2 = usersByuserId.getDeptIdOther().split(",");
                            for (String list : split2) {
                                if (user.equals(list)) { // s s
                                    useFlag = "1";//同一个部门
                                }
                            }
                        }
                    }
                }
                sb.append(useFlag);
            }
        }
        if (sb.toString().contains("0")){
            useFlag = "0";
        }else {
            useFlag = "1";
        }
        return useFlag;
    }
    /**
     * create by:李善澳
     * description: 计划管理运营驾驶舱自定义设置
     * create time: 2020-11-19 16:48
     */
    @ResponseBody
    @RequestMapping(value = "/user/userPlanCockpitSet")
    public ToJson userPlanCockpitSet(HttpServletRequest request, UserExt userExt) {
        return usersService.userPlanCockpitSet(request, userExt);
    }

    @ResponseBody
    @RequestMapping("/department/getUserByDeptName")
    public AjaxJson getUserByDeptName(HttpServletRequest request, String deptIds){
        return usersService.getUserByDeptName(deptIds);
    }

    /**
     * 修改控制面板状态
     */
    @ResponseBody
    @RequestMapping("/userExt/userExtMenuPanel")
    public AjaxJson userExtMenuPanel(HttpServletRequest request, String menuPanel,String emailPanel){
        return usersService.userExtMenuPanel(request,menuPanel,emailPanel);
    }

    /**
     * 批量修改密码
     */
    @ResponseBody
    @RequestMapping("/user/batchUpdatePassWordByUidArray")
    public ToJson batchUpdatePasswordByUidArray(HttpServletRequest request, @RequestParam("uidArray[]") String[] uidArray, String password) {
        return usersService.batchUpdatePasswordByUidArray(request, uidArray, password);
    }
    @ResponseBody
    @RequestMapping("/getBrithDay")
    public ToJson getBrithDay(HttpServletRequest request,String userId){
        return usersService.getBrithDay(request,userId);
    }

    /**
     * 方法介绍:   根据userIds获取多个用户信息
     * 参数说明:   @param userIds
     */
    @ResponseBody
    @RequestMapping(value = "user/getUsersByUserIds")
    public ToJson<Users> getUsersByUserIds(String userIds) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            List<Users> usersByUids = usersService.getUsersByUserIds(userIds);
            json.setObj(usersByUids);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/11
     * 方法介绍: 根据部门ID 获取部门架构（该部门的人员和下属部门）
     * 参数说明: [deptId]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @ResponseBody
    @RequestMapping("/user/getUserStructure")
    public ToJson getUserStructure(Integer deptId){
        return usersService.getUserStructure(deptId);
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/10/11
     * 方法介绍: 根据userIds 获取 userId 和 userName
     * 参数说明: [userIds]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @ResponseBody
    @RequestMapping("/user/regularElection")
    public ToJson regularElection(String userIds){
        return usersService.regularElection(userIds);
    }


    /**
     * 获取是否有修改用户名权限
     * @param request
     * @param user 需要修改用户名的用户
     * @return
     */
    @ResponseBody
    @RequestMapping("/user/queryEditByNameAuth")
    public ToJson queryEditByNameAuth(HttpServletRequest request,Users user){
        return usersService.queryEditByNameAuth(request,user);
    }

}

 

