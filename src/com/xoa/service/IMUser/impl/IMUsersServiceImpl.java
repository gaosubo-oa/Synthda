package com.xoa.service.IMUser.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.controller.login.loginController;
import com.xoa.dao.IMUser.IMUsersMapper;
import com.xoa.dao.attend.AttendSetMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.sys.SysInterfaceMapper;
import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.users.*;
import com.xoa.model.attend.AttendSet;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.sys.InterfaceModel;
import com.xoa.model.unitmanagement.UnitManage;
import com.xoa.model.users.*;
import com.xoa.service.IMUser.IMUsersService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.dataSource.Verification;
import com.xoa.util.encrypt.EncryptSalt;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.ibatis.exceptions.TooManyResultsException;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.xoa.util.FileUploadUtil.allowUpload;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月18日 下午6:29:38
 * 类介绍  :    用户service接口实现类
 * 构造参数:
 */
@Service
public class IMUsersServiceImpl implements IMUsersService {

    private final String one = "1";

    @Autowired
    private UsersMapper usersMapper;

    @Resource
    SystemInfoService systemInfoService;
    @Resource
    private IMUsersMapper imUsersMapper;
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
    private SysParaMapper sysParaMapper;

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
    private DepartmentService departmentService;

    @Resource
    private UserDeptOrderMapper userDeptOrderMapper;

    @Resource
    private ModulePrivService modulePrivService;

    @Resource
    private SecurityApprovalService securityApprovalService;


    /**
     * 创建作者:   张龙飞
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


        // 查询是否有重复用户名用户
        Users usersByuserId = imUsersMapper.getUsersBybyname(user.getByname());
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

        //如果用户多于使用限制就不添加
        boolean userToMany;
        if (request.getSession() == null) {
            userToMany = false;
        } else {
            userToMany = isUserToMany(request);
        }

        if (user != null) {
            if (userToMany) {
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            // 设置默认值
            if(user.getUserNo()==null){
                user.setUserNo((int) 10);
            }
            user.setMenuImage("0");
            user.setShowRss("1");
            user.setLimitLogin("0");
            user.setSecretLevel(0);
            if(StringUtils.checkNull(user.getMytableLeft())){
                user.setMytableLeft("ALL");
            }
            if(StringUtils.checkNull(user.getMytableRight())){
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
                        privaNoBuffer.append(userPriv.getUserPriv()+",");
                        privaNameBuffer.append(userPriv.getPrivName()+",");
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

        try {
            if (!StringUtils.checkNull(user.getUserName()) && user.getDeptId() != null && user.getUserPriv() != null) {
                user.setUserId("");
                user.setLastVisitIp("");
                user.setImRange(0);

                imUsersMapper.insert(user);
                user.setUserId(user.getUid().toString());
                imUsersMapper.editUser(user);
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

                //杨岩林改
                if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
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
                //user=imUsersMapper.findUserByuid(user.getUid());
                //添加到中间表数据
                user.setLoginId((String) request.getSession().getAttribute(
                        "loginDateSouse"));
                editCAccountinfo(user);
                tojson.setObject(user);
                tojson.setFlag(0);
                tojson.setMsg("OK");
            } else {
                tojson.setFlag(1);
                tojson.setMsg("新建失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            tojson.setFlag(1);
            tojson.setMsg("新建失败");
        }
        return tojson;

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
    public ToJson<Users> editUser(HttpServletRequest request,Users user, UserExt userExt, ModulePriv modulePriv) {
        ToJson<Users> tojson = new ToJson<Users>();
        UserFunction userFunction = new UserFunction();
        if (user != null) {
            //如果用户多于使用限制就不添加
            boolean userToMany;
            if (request.getSession() == null) {
                userToMany = false;
            } else {
                userToMany = isUserToMany(request);
            }
            if (userToMany) {
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            // 查询是否有重复用户名用户
            if (user.getByname() != null && user.getByname() != "") {
                Users usersByuserId = imUsersMapper.getUsersBybyname(user.getByname());
                if (usersByuserId != null && !usersByuserId.getUid().equals(user.getUid()) && usersByuserId.getByname().equals(user.getByname())) {
                    tojson.setObject(usersByuserId);
                    tojson.setMsg("此用户名已存在，请重新修改");
                    tojson.setFlag(1);
                    return tojson;
                }
            }
            //加密密码
            if (!StringUtils.checkNull(user.getPassword()) && !"tVHbkPWW57Hw.".equals(user.getPassword())) {
                Users byUid = imUsersMapper.getByUid(user.getUid());
                if (byUid.getPassword()==null||!byUid.getPassword().equals(user.getPassword())) {
                    String password = user.getPassword();
                    password = getEncryptString(password.trim());
                    user.setPassword(password);
                }
            }
//            // 判断生日是否为空 如果生日为空白字符 就设置为null
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
                    if (!StringUtils.checkNull(userPriv.getFuncIdStr())) {
                        userFunction.setUserFunCidStr(userPriv.getFuncIdStr());
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
                        privaNoBuffer.append(userPriv.getUserPriv()+",");
                        privaNameBuffer.append(userPriv.getPrivName()+",");
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
            if (user.getDeptId()!=null&&user.getDeptId().equals(0)){
                user.setNotLogin(1);
                user.setNotMobileLogin(1);
            }
            //查询一下之前数据库中是否存在头像
            Users f = imUsersMapper.SimplefindUserByuid(user.getUid());
            if (user.getAvatar()==null){
                //判断之前存在数据库的图片是否为空，如果为空再重新为用户的头像赋为当前的性别图片
                if(f!=null){
                    if(f.getAvatar()==null){
                        user.setAvatar(user.getSex());
                    }
                    //如果之前的头像为0跟1的话，也赋值为当前用户性别的图片
                    if (("0").equals(f.getAvatar())||("1").equals(f.getAvatar())){
                        user.setAvatar(user.getSex());
                    }
                }
            }
            else{
                if (("0").equals(user.getAvatar())||("1").equals(user.getAvatar())){
                    user.setAvatar(user.getSex());
                }
            }

            //旧的修改人事档案的代码，先注掉
//            HrStaffInfo hrStaffInfo =new HrStaffInfo();
//            hrStaffInfo.setBloodType(user.getBloodType());
            if(user.getDeptYj()==null){
                user.setDeptYj("");
            }
            if(!StringUtils.checkNull(user.getMobilNo())){
                user.setMobilNo(user.getMobilNo());
            }else {
                user.setMobilNo("");
            }
            if(!StringUtils.checkNull(user.getRoomNum())){
                user.setRoomNum(user.getRoomNum());
            }else {
                user.setRoomNum("");
            }
            imUsersMapper.editUser(user);

            //修改人事档案中对应的信息
            Users users1 = imUsersMapper.selectUserByUId(user.getUid());
            if(users1 != null) {
                //如果有该人员
                Users users = user;
                users.setUserId(users1.getUserId());
            }

            String loginId=user.getLoginId();
            user = imUsersMapper.selectUserByUId(user.getUid());

            //先去判断是否传入了血型判断
            //如果人事表不存在userId择不会去更新，所以不用去判断是否存在此数据
            //旧的修改人事档案的代码，先注掉
//            hrStaffInfo.setUserId(user.getUserId());
//            if(!StringUtils.checkNull(hrStaffInfo.getBloodType())){
//                int i = hrStaffInfoMapper.updateBloodType(hrStaffInfo);
//            }

            //更新中间表中的数据
            user.setLoginId(loginId);
            editCAccountinfo(user);

            if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
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
                userFunctionMapper.updateUserFun(userFunction);
            }

            user = imUsersMapper.findUserByuid(user.getUid());
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


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午5:44:51
     * 方法介绍:   删除用户
     * 参数说明:   @param uid 用户uid
     *
     * @return void   无
     */
    @Override
    public void deleteUser(String uids,HttpServletRequest request) {
        Integer index = null;
        String[] split = uids.split(",");
        for (int i = 0; i < split.length; i++) {
            if (split[i].equals("1")) {
                index = i;
            }
        }
        if (index != null) {
            split[index] = "a";
        }
        //删除中间表中的数据
        try {
            String loginId = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            List<Users> list=imUsersMapper.getUserByUids(split,null);
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
            Statement st = conn.createStatement();
            for (Users users:list){
                boolean isExistPara_1 = Verification.CheckIsExistCAccountinfo(conn, driver, url, username, password, loginId+"_"+users.getUserId());
                if(isExistPara_1){
                    String sql="delete from c_accountinfo where user_id='"+loginId+"_"+users.getUserId()+"'";
                    st.executeUpdate(sql);//执行SQL语句
                }
            }
            imUsersMapper.deleteUser(split);
            userExtMapper.deleteUserExtByUids(split);
            modulePrivMapper.deleteModulePrivByUids(split);
            userFunctionMapper.deleteUserFun(split);
        }catch (Exception e){
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
        return imUsersMapper.getAlluser(maps);
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
        List<Users> list = imUsersMapper.getUserByMany(user);
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
        return  imUsersMapper.getUserAndDept(maps);
    }
    @Override
    public List<Users> getUserAndDeptBai(Map<String, Object> maps, Integer page,
                                         Integer pageSize, boolean useFlag,Users users) {
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        maps.put("deptIds",users.getDeptId());
        maps.put("privIds",users.getUserPriv());
        maps.put("userIds",users.getUserId());
        return imUsersMapper.getUserAndDeptBai(maps);
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
        Users user = imUsersMapper.findUserByuid(uid);
        if (user != null) {
            StringBuffer sb = new StringBuffer();
            // 查询辅助角色名称信息
            if (!StringUtils.checkNull(user.getUserPrivOther())) {
                List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(user.getUserPrivOther().split(","));
                if (privNameByIds != null) {
                    for (UserPriv entity : privNameByIds) {
                        sb.append(entity.getPrivName() + ",");
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
            if (user.getDutyType() != null) {
                AttendSet attendSet = attendSetMapper.selectAttendSetSid(Integer.valueOf(user.getUserExt().getDutyType()));
                if(attendSet!=null){
                    String dutyTypeName = attendSet.getTitle();
                    user.setDutyTypeName(dutyTypeName);
                    sb.setLength(0);
                }
                user.setDutyTypeName("");
                sb.setLength(0);



            }
            if(user.getPostId()!= null&&user.getPostId()!=0){
                if(managementMapper.getUserPostId(user.getPostId())!=null){
                    String postName=managementMapper.getUserPostId(user.getPostId()).getPostName();
                    user.setPostName(postName);
                }else{
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
                    List<Users> usersByUids = imUsersMapper.getUsersByUids(modulePriv.getUserId().split(","));
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
            if(StringUtils.checkNull(user.getAvatar())){
                if(!StringUtils.checkNull(user.getSex())){
                    user.setAvatar(user.getSex());
                }else{
                    user.setAvatar("0");
                }

            }else{
                if(user.getAvatar().equals("0")||user.getAvatar().equals("1")){
                    if(!StringUtils.checkNull(user.getSex())){
                        user.setAvatar(user.getSex());
                    }else{
                        user.setAvatar("0");
                    }
                }
                else{
                    //判断用户头像是否找得到
                    String classpath = this.getClass().getResource("/").getPath();
                    String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/img/user/");
                    File file_avtor =new File(webappRoot+user.getAvatar());
                    if(!file_avtor.exists()){
                        user.setAvatar(user.getSex());
                    }
                }
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
        Users user = imUsersMapper.findUserByName(byname);
        if (user != null) {
            UnitManage nitManage = unitManageMapper.showUnitManage();
            user.setCompanyName(nitManage.getUnitName());
            if (user.getDeptId() != null) {
                Department dep = departmentMapper.getDeptById(user.getDeptId());
                if (dep != null) {
                    user.setDeptName(dep.getDeptName());

                }
            }

            Syslog sysLog = new Syslog();
            sysLog.setLogId(0);
            sysLog.setUserId(user.getUserId());
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
            sysLog.setTime(new Date());


            sysLog.setIp(ip);
            sysLog.setType(1);
            sysLog.setRemark("");
            user.setImRegisterIp(ip);
            syslogMapper.save(sysLog);
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
    public Users selectUserAllInfoByName(String byname, HttpServletRequest req,String loginId,String userPassword, Integer h5Login) {
        Users user = imUsersMapper.selectUserAllInfoByName(byname);
        if (user != null) {
            Boolean isPassWordRight =  checkPassWordUser(user.getByname(),user.getPassword(),userPassword);
            //如果是蓝信登录，密码设置为正确
            if(null != h5Login&&h5Login == 1) {
                isPassWordRight = true;
            }
            if (isPassWordRight) {
                user.setIsPassWordRight("ok");
            } else {
                user.setIsPassWordRight("err");
                return  user;
            }
            //多组织公司名称 ，不能调用已经注释的，里面只有一个公司,读取公司名称时要切库切到1001，切换之后要切到选择的库

           /* UnitManage nitManage = unitManageMapper.showUnitManage();*/
            OrgManage orgManageById=null;
            if(!StringUtils.checkNull(loginId)){
                ContextHolder.setConsumerType("xoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(loginId));
            }
            //没有传的默认为1001
            else{
                ContextHolder.setConsumerType("xoaxoa1001");
                orgManageById = orgManageMapper.getOrgManageById(Integer.valueOf(1001));
            }
            user.setCompanyName(orgManageById.getName());
            //查询公司名称后要切回来
            ContextHolder.setConsumerType("xoa"+loginId);
            if (user.getDeptId() != null) {
                Department dep = departmentMapper.getDeptById(user.getDeptId());
                if (dep != null) {
                    user.setDeptName(dep.getDeptName());
                }
            }

            Syslog sysLog = new Syslog();
            sysLog.setLogId(0);
            sysLog.setUserId(user.getUserId());
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
            sysLog.setTime(new Date());


            sysLog.setIp(IpAddr.getIpAddress(req));
            sysLog.setType(1);
            String userAgent=    req.getParameter("userAgent");
            if ("iOS".equals(userAgent)){
                sysLog.setRemark("iOS端");
            }else if ("android".equals(userAgent)) {
                sysLog.setRemark("安卓端");
            }else if ("pc".equals(userAgent)) {
                sysLog.setRemark("PC端");
            }else  {
                sysLog.setRemark("网页端");
            }
            StringBuffer url = req.getRequestURL();
            syslogMapper.save(sysLog);

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
        return imUsersMapper.getBySearch(maps);
    }
    @Override
    public List<Users> getBySearchBai(Map<String, Object> maps) {
        return imUsersMapper.getBySearchBai(maps);
    }

    @Override
    public List<Users> getBySearchBaiOrg(Map<String, Object> maps) {

        return imUsersMapper.getBySearchBaiOrg(maps);
    }



    /**
     * 根据部门ID查询部门下所有人员
     * 王禹萌
     * 2018-07-25 11：15
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
        maps.put("deptNo",deptNo);
        List<Users> users = imUsersMapper.getAllByDeptId(maps);
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
        List<Users> users = imUsersMapper.getByDeptId(maps);
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
        Users users = imUsersMapper.getByUid(uid);
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
            Users users = imUsersMapper.getByUid(Integer.parseInt(s[i]));
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
        if (",".equals(String.valueOf(userIds.charAt(userIds.length()-1)))){
            userIds = userIds.substring(0, userIds.length()-1);
        }
        String temp[] = userIds.split(",");
        List<String> userNames = imUsersMapper.getAllNameByUserId(temp);
        int length = userNames.size();
        for (int i =0 ; i<length; i++){
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
        List<String> userPrivNames = imUsersMapper.getAllUPNameByUserId(temp);
        int length = userPrivNames.size();
        for (int i =0 ; i<length; i++){
            if (i < length - 1) {
                sb.append(userPrivNames.get(i)).append(",");
            } else {
                sb.append(userPrivNames.get(i));
            }
        }



        /*String[] temp = userIds.split(",");
        for (int i = 0; i < temp.length; i++) {
            if (!StringUtils.checkNull(temp[i])) {
                Users users = imUsersMapper.findUsersByuserId(temp[i]);
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

        List<Users> usersByUserIds = imUsersMapper.getUsersByUserIdsOrder(temp);

        for (int i = 0,length=usersByUserIds.size(); i < length; i++){
            String userName = usersByUserIds.get(i).getUserName();
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
                String userName = imUsersMapper.getUsernameById(uid[i]);
                return userName;
            } else {
                String userName = imUsersMapper.getUsernameById(uid[i]);
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
        //定义用于拼接角色名称的字符串
        StringBuffer sb = new StringBuffer();

        List<Users> usersByUserIds = imUsersMapper.getUsersByUidsOrder(uids);
        for (int i = 0,length=usersByUserIds.size(); i < length; i++){
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
        List<Users> usersByUserIds = imUsersMapper.getUsersByUidsOrder(uids);
        for (int i = 0,length=usersByUserIds.size(); i < length; i++){
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
        Users users = imUsersMapper.findUsersByuserId(userId);
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

        //根据用户部门id查询
        if (users != null && users.getDeptId() != null) {
            usersList = imUsersMapper.getUserByDeptId(users);
        } else if (users != null && users.getUserPriv() != null) {
            usersList = imUsersMapper.getUserByRoleId(users);
        }

        return usersList;
    }


    /**
     * 作者: 张航宁
     * 日期: 2018/7/27
     * 说明: 根据User的角色或部门id, 查询用户 用于用户管理模块树结构遍历 查询所有用户
     */
    @Override
    public List<Users> getUserByConditionExt(Integer deptId,Integer userPriv){
        List<Users> usersList = new ArrayList<Users>();

        //根据用户部门id查询
        if (deptId != null) {
            usersList = imUsersMapper.getUsersByDeptId(deptId);
        } else if (userPriv != null) {
            usersList = imUsersMapper.getUsersByUserPriv(String.valueOf(userPriv));
        }

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

        return imUsersMapper.getUserOnline();
    }

    @Override
    public List<Users> getUserbyCondition(Map<String, Object> maps) {
        List<Users> usersList = imUsersMapper.getUserbyCondition(maps);
        StringBuffer s2 = new StringBuffer();
        for (Users users : usersList) {
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
    public ToJson<Users> edit(Integer uid, String userName, String sex, Date birthday, String email, String oicqNo,
                              String mobilNo, String telNoDept, String avatar) {
        ToJson<Users> tojson = new ToJson<Users>();
        Users u = new Users();
        u.setUid(uid);
        u.setUserName(userName);
        u.setSex(sex);
        u.setBirthday(birthday);
        u.setEmail(email);
        u.setOicqNo(oicqNo);
        u.setMobilNo(mobilNo);
        u.setTelNoDept(telNoDept);
        u.setAvatar(avatar);
        try {
            imUsersMapper.editUser(u);
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
            List<Users> usersList = imUsersMapper.checkPassWord(userName);

            if (usersList != null && usersList.size() > 0) {

                //如果密码为空，
                if ("tVHbkPWW57Hw.".equals(usersList.get(0).getPassword())) {
                    return true;
                }
            }

        }

        if (userName != null && password != null) {

            List<Users> usersList = imUsersMapper.checkPassWord(userName);

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



    @Override
    public Boolean checkPassWordUser(String userName, String password,String userPassword) {
        //开发阶段，admin登录，不用输密码，所有特殊考虑
        if ("".equals(userPassword.trim())) {
            //如果密码为空，
            if ("tVHbkPWW57Hw.".equals(password)) {
                return true;
            }
        }
        if (userName != null && password != null) {
            try {
                String md5Password = MD5Utils.md5Crypt(userPassword.getBytes(), password);
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
            return imUsersMapper.getUsersByDeptId(deptId);
        } else {
            return null;
        }

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
                        list = imUsersMapper.getdepId(map);
                        if (list!=null &&list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 2:
                        map.put("userPriv", temp[i]);
                        list = imUsersMapper.getdepId(map);
                        //list1 = imUsersMapper.getUserPrivOther(temp[i]);
                        if (list!=null &&list.size() > 0) {
                            l.addAll(list);
                        }
                      /*  if (list1.size() > 0) {
                            l.addAll(list1);
                        }*/
                        break;
                    case 3:
                        map.put("deptIdOther", temp[i]);
                        list = imUsersMapper.getdepId(map);
                        if (list!=null &&list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 4:
                        map.put("userPrivOther", temp[i]);
                        list = imUsersMapper.getdepId(map);
                        if (list!=null &&list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 5://部门和辅助部门
                        map.put("deptIdAll", temp[i]);
                        list = imUsersMapper.getdepId(map);
                        if (list!=null &&list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    case 6://角色和辅助角色
                        map.put("userPrivAll", temp[i]);
                        list = imUsersMapper.getdepId(map);
                        if (list!=null && list.size() > 0) {
                            l.addAll(list);
                        }
                        break;
                    default:
                        break;
                }
               /* if(flag){
                    map.put("deptId",temp[i]);
                    List<Users> list=imUsersMapper.getdepId(map);
                    l.addAll(list);
                }else{
                    map.put("userPriv",temp[i]);
                    List<Users> list=imUsersMapper.getdepId(map);
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
        List<Users> l = imUsersMapper.getUsersByUserIdsOrder(temp);
        return l;
    }

    @Override
    public List<Users> getUserByuserIdBai(Map map) {
        String userIds=(String) map.get("userIds");
        if (StringUtils.checkNull((String) map.get("userIds"))) {
            return null;
        }
        String[] temp = userIds.split(",");
        map.put("temp", temp);
        List<Users> l = imUsersMapper.getUsersByUserIdsOrderBai(map);
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
                Users users = imUsersMapper.getByUid(Integer.parseInt(temp[i]));
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

        return imUsersMapper.getUserPrivByuId(uId);

    }


    @Override
    public List<Users> getNullPwUsers(Integer deptId) {
        return imUsersMapper.getNullPwUsers(deptId);
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
            return imUsersMapper.getPUsersByDeptId(deptId);
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
            return imUsersMapper.getCUsersByDeptId(deptId);
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
            return imUsersMapper.getTUsersByDeptId(deptId);
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
                imUsersMapper.clearPassword(split);
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
                imUsersMapper.clearOnLine(split);
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
                imUsersMapper.setNotLogin(split);
            }
        }
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月20日
     * 方法介绍:   批量修改部门
     * 参数说明:   @param uids
     */
    @Override
    public void editUsersDetId(Integer deptId, String uids) {
        if (!StringUtils.checkNull(uids) && deptId != null) {
            String[] split = uids.split(",");
            if (split != null && split.length > 0) {
                imUsersMapper.editUsersDetId(deptId, split);
            }
        }
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
                return imUsersMapper.getUsersByUids(split);
            } else {
                return null;
            }
        } else {
            return null;
        }
    }

    @Override
    public List<Users> deptHaveUser(String deptNO) {
        return imUsersMapper.deptHaveUser(deptNO);
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

        imUsersMapper.addU(users);
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

        List<Users> list = imUsersMapper.selectList(users);
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
    public ToJson<Users> queryUserByUserId(String userName) {
        ToJson<Users> json = new ToJson<Users>(1, "error");
        if (StringUtils.checkNull(userName)) {
            json.setMsg("查询不能为空");
            return json;
        }
        try {
            List<Users> userList = new ArrayList<Users>();
            if (!StringUtils.checkNull(userName)) {
                StringBuffer newStr= new StringBuffer();
                char [] stringArr = userName.toCharArray();
                for(char s:stringArr){
                    newStr.append(s+"_");
                }
                Map<String,Object> map =new HashedMap();
                map.put("userName",userName);
                map.put("newStr",newStr.toString());
                userList = imUsersMapper.queryUserByUserIds(map);
                // 判断是否缺失头像
                for (Users u:userList) {
                    if (StringUtils.checkNull(u.getAvatar())){
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
            count = imUsersMapper.queryCountByUserId(userName);
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
        return imUsersMapper.getUserCount();

    }

    @Override
    public int getUserCountBySql(String databaseName) {
        int i= imUsersMapper.getUserCountBySql(databaseName);
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
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);


        int uid = users.getUid();
        Users selectUser = imUsersMapper.getUserByUid(uid);
        String encryPwd = getEncryptString(newPwd);
        String uPass = user.getPassword();//用户输入的原密码
        String sPass = selectUser.getPassword();//数据库中存的密码
        if (uPass.equals("")) {
            if (sPass.equals("tVHbkPWW57Hw.")) {
                String lastPassTime = DateFormat.getCurrentTime();
                user.setPassword(encryPwd);
                Map<String, String> map = new HashMap<String, String>();
                map.put("pwd", encryPwd);
                map.put("uid", users.getUserId());
                map.put("lastPassTime", lastPassTime);
                int total = imUsersMapper.updatePwd(map);
                if (total > 0) {
                    //将修改登录密码添加到日志中
                    Syslog syslog = new Syslog();
                    syslog.setUserId(users.getUserId() + "");
                    syslog.setType(14);
                    syslog.setTypeName("修改登录密码");
                    syslog.setRemark("");
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
                String md5Password = MD5Utils.md5Crypt(uPass.getBytes(), sPass);
                if (sPass.equals(md5Password)) {

                    String lastPassTime = DateFormat.getCurrentTime();
                    user.setPassword(encryPwd);
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("pwd", encryPwd);
                    map.put("uid", users.getUserId());
                    map.put("lastPassTime", lastPassTime);
                    int total = imUsersMapper.updatePwd(map);
                    if (total > 0) {
                        //将修改登录密码添加到日志中
                        Syslog syslog = new Syslog();
                        syslog.setUserId(users.getUserId() + "");
                        syslog.setType(14);
                        syslog.setTypeName("修改登录密码");
                        syslog.setRemark("");
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
//         int total=  imUsersMapper.updatePwd(map);
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
            imUsersMapper.updatePwd(map);

        } else {
            return "原密码错误";
        }*/

        return "ok";
    }

    @Override
    public Users getLoginUser(HttpServletRequest request) {
        //1、获取当前登录用户
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        users.getUid();
        users.getUserId();
        users.getByname();
        StringBuffer sb = new StringBuffer();
        Users temp=imUsersMapper.findUsersByuserId(users.getUserId());
        // 查询辅助角色名称信息
        if (temp!=null &&!StringUtils.checkNull(temp.getUserPrivOther())) {
            List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(temp.getUserPrivOther().split(","));
            if (privNameByIds != null) {
                for (UserPriv entity : privNameByIds) {
                    sb.append(entity.getPrivName() + ",");
                }
                users.setUserPrivOtherName(sb.toString());
            }
            sb.setLength(0);
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
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, null,request);
            String isSoftAuth = map.get("isSoftAuth");
            int userCount = imUsersMapper.getLoginUserCount();
            if(!StringUtils.checkNull(isSoftAuth)){
                //先判断是否注册
                if(isSoftAuth.equals("已注册")){
                    if (userCount < authUser) {
                        return false;
                    }

                }
                //中小型企业以及其他企业
                else{
                    authUser=30;
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

    public boolean isUserToMany(HttpServletRequest request,int insertCount) {
        int authUser = systemInfoService.getAuthUser(request);
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try {
            //读取授权文件
            Map<String, String> map = systemInfoService.getSystemInfo(realPath, null,request);
            String isSoftAuth = map.get("isSoftAuth");
            int userCount = imUsersMapper.getLoginUserCount();
            if(!StringUtils.checkNull(isSoftAuth)) {
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
    public ToJson<Users> getNewUsers() {
        ToJson<Users> json = new ToJson<Users>();

        try {
            List<Users> newUsers = imUsersMapper.getNewUsers();
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

        return imUsersMapper.getLoginUserCount();

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
    public Users getUserByUid(int uid) {
        Users user = imUsersMapper.getUserByUid(uid);
        StringBuffer sb = new StringBuffer();
        // 查询辅助角色名称信息
        if (user !=null && !StringUtils.checkNull(user.getUserPrivOther())) {
            List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(user.getUserPrivOther().split(","));
            if (privNameByIds != null) {
                for (UserPriv entity : privNameByIds) {
                    sb.append(entity.getPrivName() + ",");
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
        ModulePriv modulePriv = new ModulePriv();
        modulePriv.setUid(uid);
        modulePriv.setModuleId(0);
        modulePriv = modulePrivMapper.getModulePrivSingle(modulePriv);
        // 查询获取白名单名称数据
        if (modulePriv != null) {
            user.setModulePriv(modulePriv);
            if (!StringUtils.checkNull(modulePriv.getUserId())) {
                List<Users> usersByUids = imUsersMapper.getUsersByUserIds(modulePriv.getUserId().split(","));
                if (usersByUids != null) {
                    StringBuffer ids=new StringBuffer();
                    for (Users entity : usersByUids) {
                        sb.append(entity.getUserName() + ",");
                        ids.append(entity.getUserId()+",");
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
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        loginUser.setMenuType(users.getMenuType());
        loginUser.setTheme(users.getTheme());
        loginUser.setBkground(users.getBkground());
        loginUser.setMenuExpand(users.getMenuExpand());
        loginUser.setPanel(users.getPanel());
        loginUser.setCallSound(users.getCallSound());
        // loginUser.setWeatherCity(users.getWeatherCity());

        imUsersMapper.updateUserTheme(loginUser);
        String theme = "theme" + users.getTheme();
        SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);


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
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        Integer uid = users.getUid();
        Users users1 = imUsersMapper.getUserByUid(uid);
        if (users1 !=null && 0 == users1.getTheme()) {
            List<InterfaceModel> interfaceModels = sysInterfaceMapper.getInterfaceInfo();
            users1.setTheme(Integer.parseInt(interfaceModels.get(0).getTheme()));
        }
        String theme = SessionUtils.getSessionInfo(request.getSession(), "InterfaceModel", String.class,redisSessionCookie);
        SessionUtils.putSession(request.getSession(), "InterfaceModel", theme,redisSessionCookie);

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
    public ToJson<Users> queryExportUsers(HttpServletRequest request, HttpServletResponse response, Users user, String sortType, String isExport, String notLogin, Integer page, Integer pageSize, Boolean useFlag, String deptNo) {
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

            Map<String, Object> map = new HashMap<String, Object>();
            PageParams pageParams = new PageParams();
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            map.put("page", pageParams);
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


            //增加分级机构过滤条件
            if(!(sessionInfouser.getUserPriv()==1) && map.get("deptIda") == null) {
                String deparIds = "";
                List<Department> departs = new ArrayList<>();
                Department orgbyDeptId = getClassifyOrgbyDeptId(sessionInfouser.getDeptId());
                departs.add(orgbyDeptId);
                getChild(departs,orgbyDeptId.getDeptId());
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
            List<Users> users = imUsersMapper.queryExportUsers(map);
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
                if ("tVHbkPWW57Hw.".equals(entity.getPassword())) {
                    entity.setPassword("");
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
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }


    private Department getClassifyOrgbyDeptId(Integer deptId){
        Department classifyOrgbyDeptId = departmentMapper.getClassifyOrgbyDeptId(deptId);
        if(classifyOrgbyDeptId != null && classifyOrgbyDeptId.getClassifyOrg() != 1 && classifyOrgbyDeptId.getDeptParent() != 0){
            classifyOrgbyDeptId = getClassifyOrgbyDeptId(classifyOrgbyDeptId.getDeptParent());
        }
        return classifyOrgbyDeptId;
    }

    private void getChild(List<Department> departs,Integer detpd) {
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
        try {

            if(!StringUtils.checkNull(userPrivName)){
                userPrivName = userPrivName.replace(",","");
            }
            //判读当前系统
            //读取配置文件
            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String osName = System.getProperty("os.name");
            StringBuffer path = new StringBuffer();
            if (osName.toLowerCase().startsWith("win")) {
                path = path.append(rb.getString("upload.win"));
            } else {
                path = path.append(rb.getString("upload.linux"));
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
                    // 判断是否超过用户新建限制
                    boolean userToMany;
                    if (request.getSession() == null) {
                        userToMany = false;
                    } else {
                        userToMany = isUserToMany(request,lastRowNum-1);
                    }
                    if(userToMany){
                        json.setFlag(1);
                        json.setMsg("超过用户限制");
                        return json;
                    }


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
                                            entity.setByname(cell.getStringCellValue());
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
                                            }else {
                                                entity.setAvatar("0");
                                                entity.setSex("0");
                                            }
                                            break;
                                        case 5:
                                            try{
                                                entity.setBirthday(cell.getDateCellValue());
                                            }catch (IllegalStateException e){
                                                String birthdayStr = cell.getStringCellValue();
                                                entity.setBirthday(DateFormat.DateToStr(birthdayStr));
                                            }
                                            break;
                                        case 6:
                                            if (StringUtils.checkNull(cell.getStringCellValue().trim())) {
                                                entity.setUserPrivName(userPrivName);
                                            } else {
                                                entity.setUserPrivName(cell.getStringCellValue().trim());
                                            }
                                            break;
                                        case 7:
                                            entity.setUserNo(Integer.valueOf(StringUtils.checkNull(cell.getStringCellValue()) ? "10" : cell.getStringCellValue().trim()));
                                            break;
                                        case 8:
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
                                        case 9:
                                            entity.setMobilNo(cell.getStringCellValue());
                                            break;
                                        case 10:
                                            entity.setBindIp(cell.getStringCellValue());
                                            break;
                                        case 11:
                                            entity.setTelNoDept(cell.getStringCellValue());
                                            break;
                                        case 12:
                                            entity.setFaxNoDept(cell.getStringCellValue());
                                            break;
                                        case 13:
                                            entity.setAddHome(cell.getStringCellValue());
                                            break;
                                        case 14:
                                            entity.setPostNoHome(cell.getStringCellValue());
                                            break;
                                        case 15:
                                            entity.setTelNoHome(cell.getStringCellValue());
                                            break;
                                        case 16:
                                            entity.setEmail(cell.getStringCellValue());
                                            break;
                                        case 17:
                                            entity.setOicqNo(cell.getStringCellValue());
                                            break;
                                        case 18:
                                            entity.setMsn(cell.getStringCellValue());
                                            break;
                                        case 19:
                                            entity.setIdNumber(cell.getStringCellValue());
                                            break;
                                        case 20:
                                            entity.setTraNumber(cell.getStringCellValue());
                                            break;
                                        case 21:
                                            entity.setSubject(cell.getStringCellValue());
                                            break;
                                    }
                                }else if(j==4){
                                    entity.setAvatar("0");
                                    entity.setSex("0");
                                }
                            }
                        }

                        if (StringUtils.checkNull(entity.getPostPriv())) {
                            entity.setPostPriv("0");
                        }
                        // 判断是否存在相同用户名
                        if(StringUtils.checkNull(ifUpdate) || !"yes".equals(ifUpdate)){
                            Users usersByuserId = imUsersMapper.getUsersBybyname(entity.getByname());
                            if (usersByuserId != null && usersByuserId.getByname().equals(entity.getByname()) ) {
                                entity.setSaveMsg("此用户名已存在，请修改");
                                saveList.add(entity);
                                continue;
                            }
                        }


                        // 加密密码
                        if (entity.getPassword() != null) {
                            entity.setPassword(getEncryptString(entity.getPassword().trim()));
                        }else {
                            if(!StringUtils.checkNull(psWord)){
                                entity.setPassword(getEncryptString(psWord.trim()));
                            }else{
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
                            d.setDeptName(entity.getDeptName());
                            List<String> parentList = departmentMapper.getDeptIdByDeptName(entity.getDeptName());
                            String deptId="";
                            if(parentList.size()==1){
                                deptId=parentList.get(0);
                                if (deptId != null && deptId != "") {
                                    entity.setDeptId(Integer.valueOf(deptId));
                                } else {
                                    entity.setSaveMsg("失败，部门不存在");
                                    saveList.add(entity);
                                    continue;
                                }
                            }else if(parentList.size()<1){
                                entity.setSaveMsg("失败，部门不存在");
                                saveList.add(entity);
                                continue;
                            }else{
                                entity.setSaveMsg("导入失败，部门名称 "+entity.getDeptName()+" 在系统中存在多个");
                                saveList.add(entity);
                                continue;
                            }

                        }
                        // 获取角色信息
                        if (entity.getUserPrivName() != null) {
                            UserPriv userPriv = null;
                            try{
                                userPriv = userPrivMapper.getUserPrivByName(entity.getUserPrivName());
                            }catch (TooManyResultsException exception){
                                List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(entity.getUserPrivName());
                                if(userPrivsByName!=null&&userPrivsByName.size()>0){
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
                            } else if(!StringUtils.checkNull(userPrivName)){
                                UserPriv userPriv2 = null;
                                try{
                                    userPriv2 = userPrivMapper.getUserPrivByName(userPrivName);
                                }catch (TooManyResultsException exception){
                                    List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(userPrivName);
                                    if(userPrivsByName!=null&&userPrivsByName.size()>0){
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
                        entity.setNotLogin(0);
                        entity.setImRange(1);
                        Users userByName = imUsersMapper.findUserByName(entity.getByname());
                        //处理特殊的null,要不登录不成功
                        if(entity.getAvatar()==null){
                            if(entity.getSex().equals("0")||entity.getSex().equals("1")){
                                entity.setAvatar(entity.getSex());
                            }else{
                                entity.setAvatar("");
                            }
                        }
                        if(entity.getTheme()==null){
                            entity.setTheme(0);
                        }
                        if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                            // 更新
                            entity.setUid(userByName.getUid());
                            entity.setUserId(userByName.getUserId());
                            imUsersMapper.editUser(entity);

                            userFunction.setUid(entity.getUid());
                            userFunction.setUserId(entity.getUserId());
                            userFunctionMapper.updateUserFun(userFunction);

                            entity.setSaveMsg("更新成功");
                            saveList.add(entity);
                            ++updateCount;
                        } else if (userByName == null) {
                            // 保存用户
                            entity.setNotViewUser("0");
                            entity.setNotViewTable("0");
                            imUsersMapper.insert(entity);

                            entity.setUserId(entity.getUid().toString());
                            imUsersMapper.editUser(entity);

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
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("数据保存异常");
            json.setFlag(1);
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
            List<Users> usersByUids = imUsersMapper.getUsersByUids(uids.split(","));
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
            List<Users> usersByDeptIds = imUsersMapper.getUsersByDeptIds(deptIdsArr);
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
            List<Users> usersByPrivIds = imUsersMapper.getUsersByPrivIds(privIdsArr);
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
                if(user.getDeptId()!=null&&user.getDeptId().equals(0)){
                    user.setNotLogin(1);
                    user.setNotMobileLogin(1);
                }
                imUsersMapper.editUserBatch(uidsList, user);

                if (userExt != null) {
                    userExtMapper.updateUserExtByUids(uidsList, userExt);
                }

                if (userFunction != null && userFunction.getUserFunCidStr() != null) {
                    userFunctionMapper.updateUserFunByUids(uidsList, userFunction);
                }

                if (modulePriv != null || !StringUtils.checkNull(user.getPostPriv())) {
                    for (String uid : uidsList) {
                        modulePriv.setUid(Integer.valueOf(uid));
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
                Users nowuUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
                Syslog syslog = new Syslog();
                syslog.setUserId(nowuUser.getUserId());
                syslog.setType(19);
                syslog.setTypeName("用户批量设置");
                syslog.setRemark(sb.toString());
                syslog.setIp(IpAddr.getIpAddress(request));
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
        return imUsersMapper.getUsersByuserId(userId);
    }

    /* (non-Javadoc)
     * @see com.xoa.service.users.UsersService#selectFileUserSignerAll()
     */
    @Override
    public List<Users> selectFileUserSignerAll() {
        // TODO Auto-generated method stub
        return imUsersMapper.selectFileUserSignerAll();
    }

    /* (non-Javadoc)
     * @see com.xoa.service.users.UsersService#selectFileUserSigner(java.util.Map)
     */
    @Override
    public List<Users> selectFileUserSigner(Map<String, Object> mapUser) {
        // TODO Auto-generated method stub
        return imUsersMapper.selectFileUserSigner(mapUser);
    }

    @Override
    public ToJson<Users> singleSearch(String searchData) {
        ToJson<Users> json = new ToJson<Users>();
        try {
            if (!StringUtils.checkNull(searchData)) {
                List<Users> users = imUsersMapper.singleSearch(searchData);
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
        List<Users> users = imUsersMapper.getAllInfo();
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
        return imUsersMapper.getUserByUserName(userName);
    }

    @Override
    public void deleteUserByDeptId(String deptId) {
        imUsersMapper.deleteUserByDeptId(deptId);
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
    public ToJson<Users> editUserExt(HttpServletRequest request, MultipartFile imageFile, Users users, UserExt userExt) throws IllegalStateException, IOException {
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
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            users.setUid(usersTemp.getUid());
            //先查询是否已经上传了该头像，如果上传了删除后再上传，否则直接上传
            Users temp = imUsersMapper.findUsersByuserId(usersTemp.getUserId());
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
            int count = imUsersMapper.editUser(users);
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
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        if (!StringUtils.checkNull(users.getUserId())) {
            Users u = new Users();
            u.setUid(users.getUid());
            u.setMyStatus(sign);
            imUsersMapper.editUser(u);
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
                    Users usersByuserId = imUsersMapper.getUsersBybyname(entity.getByname());
                    if (usersByuserId != null && usersByuserId.getByname().equals(entity.getByname())) {
                        imUsersMapper.updateUserByName(entity);
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
                        String deptId="";
                        if(nameList.size()>0){
                            deptId=nameList.get(0);
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
                    Users userByName = imUsersMapper.findUserByName(entity.getByname());
                    if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                        // 更新
                        entity.setUid(userByName.getUid());
                        entity.setUserId(userByName.getUserId());
                        imUsersMapper.editUser(entity);

                        userFunction.setUid(entity.getUid());
                        userFunction.setUserId(entity.getUserId());
                        userFunctionMapper.updateUserFun(userFunction);

                        entity.setSaveMsg("更新成功");
                        saveList.add(entity);
                        ++updateCount;
                    } else if (userByName == null) {
                        if (StringUtils.checkNull(entity.getByname())) {
                            //获取规则生成userId的最大值
                            String maxUserId = imUsersMapper.getMaxUserId();
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
                        imUsersMapper.insert(entity);
                        entity.setUserId(entity.getUid().toString());
                        imUsersMapper.editUser(entity);

                        //entity.setUserId(entity.getUid().toString());
                        // imUsersMapper.editUser(entity);

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
                String maxUserId = imUsersMapper.getMaxUserId();

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
                    // Users usersByIdNumber = imUsersMapper.getUserByIdNumber(IdNumber);
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
                        Users usersByIdNumber = imUsersMapper.getUserByIdNumber(IdNumber);
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
                        String deptId="";
                        if(nameList.size()>0){
                            deptId=nameList.get(0);
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
                    Users userByName = imUsersMapper.importUserByName(user.getByname());
                    if (userByName != null && !StringUtils.checkNull(ifUpdate) && ifUpdate.equals("yes")) {
                        // 更新
                        user.setUid(userByName.getUid());
                        user.setUserId(userByName.getUserId());
                        imUsersMapper.editUser(user);

                        userFunction.setUid(user.getUid());
                        userFunction.setUserId(user.getUserId());
                        userFunctionMapper.updateUserFun(userFunction);

                        user.setSaveMsg("更新成功");
                        saveList.add(user);
                        ++updateCount;
                    } else if (userByName == null) {
                        // 保存用户
                        imUsersMapper.insert(user);

                        user.setUserId(user.getUid().toString());
                        imUsersMapper.editUser(user);

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
        String deptId="";
        if(nameList.size()>0){
            deptId=nameList.get(0);
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
        String maxUserId = imUsersMapper.getMaxUserId();
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
                Users users = imUsersMapper.findUsersByuserId(temp[i]);
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
        List<Users> list = imUsersMapper.getAllPrivUser(map);
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


    public String reAllName(List<Users> list) {
        StringBuffer stringBuffer = new StringBuffer();
        for (Users users : list) {
            stringBuffer.append(users.getUserId()).append(",");
        }
        return stringBuffer.toString();
    }

    @Override
    public void updateLoginTime(Users users) {
        imUsersMapper.updateLoginTime(users);
    }

    @Override
    public List<Users> LoginUserList() {

        return imUsersMapper.LoginUserList();
    }

    @Override
    public BaseWrapper uploadImg(HttpServletRequest request, MultipartFile file) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
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
            String fileName128 = FileUploadUtil.rename(fileName,"s");
            String newImg = FileUploadUtil.zipImageFile(realfile.getAbsolutePath(), 128, 128, 1, fileName128,dir.getAbsolutePath());
            wrapper.setFlag(true);
            wrapper.setData(fileName128);
            wrapper.setMsg(fileName);
//                users.setAvatar(filename128);
//                users.setAvatar128(fileName);
//            users.setUid(usersTemp.getUid());
//            int count = imUsersMapper.editUser(users);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wrapper;
    }

    @Override
    public ToJson<Users> editUserExtNew(HttpServletRequest request, Users users, UserExt userExt) {
        ToJson<Users> toJson = new ToJson<Users>(1, "error");
        try{
            String realPath = request.getSession().getServletContext().getRealPath("/");
            String resourcePath = "ui/img/user";
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users usersTemp = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            users.setUid(usersTemp.getUid());
            //先查询是否已经上传了该头像，如果上传了删除后再上传，否则直接上传
            Users temp = imUsersMapper.findUsersByuserId(usersTemp.getUserId());
            if (temp != null) {
                if (!StringUtils.checkNull(temp.getPhoto())) {
                    File temp1 = new File(realPath + resourcePath + temp.getPhoto());
                    if (temp1.exists()) {
                        temp1.delete();
                    }
                }
            }
            int count = imUsersMapper.editUser(users);
            userExt.setUid(usersTemp.getUid());
            userExt.setUserId(usersTemp.getUserId());
            count += userExtMapper.updateUserExtByUid(userExt);
            if (count > 1) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     * 创建作者:  牛江丽
     * 创建日期:   2017-11-22
     * 方法介绍:   根据用户名字和用户名拼音进行模糊查询
     * 参数说明:   @param name
     * 参数说明:   @return List<Users>
     */
    public ToJson<Users> getByName(String name){
        ToJson<Users> json=new ToJson<>(1,"error");
        try{
            List<Users> list=imUsersMapper.getByName(name);
            json.setObj(list);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
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

        ToJson<Users> toJson=new ToJson<Users>(1,"error");
        List<Users> list=imUsersMapper.getuserNameByDeptId(deptId);
        if(list!=null){

            toJson.setMsg("查询成功");
            toJson.setFlag(0);
            toJson.setObj(list);
        }else{
            toJson.setMsg("数据为空");
            toJson.setFlag(1);
        }




        return toJson;
    }

    @Override
    public ToJson<Integer> selectuidByName(String userName) {
        List<Integer> list=imUsersMapper.selectuidByName(userName);

        ToJson toJson=new ToJson();

        if(list!=null){
            toJson.setMsg("查询成功");
            toJson.setObj(list);
        }

        return toJson;
    }

    @Override
    public ToJson<Users> getUserDepartmentUserexe(String deptId, String dutyType,
                                                  String uids ) {
        ToJson<Users> toJson=new ToJson<Users>(1,"ERROR");
        Map<String,Object> map=new HashMap<String, Object>();
        //部门id
        map.put("deptId", deptId);
        //考勤类型
        map.put("dutyType", dutyType);
        //用户id
        map.put("uid", uids);
        List<Users> list=imUsersMapper.getUserDepartmentUserexe(map);

        if(list!=null){
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            toJson.setObj(list);

        }else {
            toJson.setFlag(1);
            toJson.setMsg("数据为空");

        }

        return null;
    }

    @Override
    public BaseWrapper checkUserCount(HttpServletRequest request) {
        BaseWrapper baseWrapper=new BaseWrapper();
        int authUser = systemInfoService.getAuthUser(request);
        int userCount = getUserCount();
        if (userCount < authUser) {
            baseWrapper.setMsg("用户成功");
            baseWrapper.setFlag(true);
        }else {
            baseWrapper.setMsg("用户新建数量超过限制");
            baseWrapper.setFlag(false);

        }
        return  baseWrapper;
    }

    @Override
    public BaseWrapper UsersByUidCorrection() {
        //获取全部部门
        List<Department> departmentList= departmentMapper.getAllDepartment();
        for(Department department:departmentList){
            if(!StringUtils.checkNull(department.getManager())){
                String uidList1=imUsersMapper.UsersByUidCorrection1(department.getDeptId());
                department.setManager(uidList1);
            }
            if(!StringUtils.checkNull(department.getAssistantId())){
                String uidList2=imUsersMapper.UsersByUidCorrection2(department.getDeptId());
                department.setAssistantId(uidList2);
            }
            if(!StringUtils.checkNull(department.getLeader1())){
                String uidList3=imUsersMapper.UsersByUidCorrection3(department.getDeptId());
                department.setLeader1(uidList3);

            }
            if(!StringUtils.checkNull(department.getLeader2())){
                String uidList4=imUsersMapper.UsersByUidCorrection4(department.getDeptId());
                department.setLeader2(uidList4); }
            departmentMapper.editDept(department);
        }
        BaseWrapper baseWrapper=new BaseWrapper();
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
                    List<Users> allUsers = imUsersMapper.getAlluser(null);
                    for (Users user:allUsers) {
                        String userName = user.getUserName();
                        if(!StringUtils.checkNull(userName.trim())){
                            String firstSpell = PinYinUtil.getFirstSpell(userName);
                            StringBuffer sb = new StringBuffer();
                            for (int j = 0; j < firstSpell.length(); j++) {
                                sb.append(firstSpell.charAt(j) + "*");
                            }
                            if(!sb.toString().equals(user.getUserNameIndex())){
                                user.setUserNameIndex(sb.toString());
                                imUsersMapper.editUser(user);
                            }
                            if(StringUtils.checkNull(user.getUserPrivName())){
                                Integer userPriv = user.getUserPriv();
                                if(userPriv!=null){
                                    UserPriv userPriv1 = userPrivMapper.selectByPrimaryKey(userPriv);
                                    if(userPriv1!=null){
                                        user.setUserPrivNo(userPriv1.getPrivNo());
                                        user.setUserPrivName(userPriv1.getPrivName());
                                        imUsersMapper.editUser(user);
                                    }
                                }
                            }
                        }
                    }
                }
            });
            json.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public List<Users> getUsersByPId(int pId) {
        return imUsersMapper.getUsersByPId(pId);
    }

    @Override
    public ToJson<Map> getPwRule() {
        ToJson<Map> json = new ToJson<>();
        try{
            List<SysPara> theSysParam = sysParaMapper.getTheSysParam("SEC_PASS_MIN");
            List<SysPara> theSysParam1 = sysParaMapper.getTheSysParam("SEC_PASS_MAX");
            Map<String,Object> map = new HashMap<String,Object>();
            if(theSysParam!=null&&theSysParam.size()>0){
                map.put("secPassMin",theSysParam.get(0).getParaValue());
            }
            if(theSysParam1!=null&&theSysParam1.size()>0){
                map.put("secPassMax",theSysParam1.get(0).getParaValue());
            }
            json.setObject(map);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            L.e(e.getMessage());
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Object> getOnlineMap(HttpServletRequest request) {
        ToJson<Object> json =new ToJson<Object>();
        json.setObject(loginController.userCountMap);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }
    @Override
    public ToJson<Users> getOnlinePeople(HttpServletRequest request) {
        List<Users> users =new ArrayList<Users>();
        ToJson<Users> json =new ToJson<Users>();
        //Map<String, Object> userCountMap = loginController.userCountMap;
        List<String> userCountMap = usersMapper.getOnline();
        if(userCountMap!=null){
           /* Iterator it = userCountMap.entrySet().iterator();
            while (it.hasNext()){
                Map.Entry entry = (Map.Entry) it.next();
                String userId = entry.getKey().toString();*/
            for (String userId:userCountMap) {
                Users usersByuserId = imUsersMapper.getUsersByuserId(userId);
                users.add(usersByuserId);
            }
        }

        json.setObj(users);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<Users> getOnlinePeopleBai(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        List<Users> users =new ArrayList<Users>();
        ToJson<Users> json =new ToJson<Users>();
        //Map<String, Object> userCountMap = loginController.userCountMap;
        List<String> userCountMap = usersMapper.getOnline();
        String moduleId = request.getParameter("moduleId");
        Map<String, Object> map = modulePrivService.getModulePriv(sessionInfo, moduleId);
        if(userCountMap!=null){
           /* Iterator it = userCountMap.entrySet().iterator();
            while (it.hasNext()){*/
              /*  Map.Entry entry = (Map.Entry) it.next();
                String userId = entry.getKey().toString();*/
            for (String userId:userCountMap) {
                map.put("userId",userId);
                Users usersByuserId = imUsersMapper.getUsersByuserIdBai(map);
                users.add(usersByuserId);
            }
        }

        json.setObj(users);
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<Object> updatePassword() {
        ToJson<Object> json = new ToJson<Object>(1,"err");
        try {
            List<Users> users = imUsersMapper.selectUserByTime();
            String password ="jinhuijiu";
            String encryPwd = getEncryptString(password);
            StringBuffer stringBuffer =new StringBuffer();
            Map<String,Object> map =new HashedMap();
            for(Users user:users){
                String lastPassTime = DateFormat.getCurrentTime();
                Users  newUser =new Users();
                newUser.setUid(user.getUid());
                stringBuffer.append(user.getUid()+",");
            }
            String uids= stringBuffer.substring(0,stringBuffer.toString().length()-1);
            map.put("password",encryPwd);
            map.put("uids",uids);
            int i = imUsersMapper.batchUpdatePwd(map);
            if(i>0){
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
        ToJson<Users> json =new ToJson<Users>(1,"err");
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
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            List<Users> userByDeptId = imUsersMapper.getUserByDeptId(sessionInfo);
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }

    @Override
    public ToJson<Object> selectIsExistUser(String byname) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        // 查询是否有重复用户名用户
        Users usersByuserId = imUsersMapper.getUsersBybyname(byname);
        if(usersByuserId!=null){
            json.setFlag(0);
            json.setMsg("ok");
            return json;
        }
        return json;
    }

    @Override
    public ToJson<Users> getNewChDept(HttpServletRequest request,Integer deptId) {
        ToJson<Users> json = new ToJson<Users>();
        try{
            //查出全部部门的集合
            List<Department> departmentList =new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer =new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(deptId,stringBuffer,departmentList);
            Department deptById = departmentMapper.getDeptById(deptId);
            List<Users> userByDeptId=new ArrayList<Users>();
            if(!StringUtils.checkNull(deptIds)){
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = removeStr.split(",");
                userByDeptId = imUsersMapper.selectUserByDeptIds(split);
                if(userByDeptId!=null&&userByDeptId.size()>0){
                    for(Users u:userByDeptId){
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                    }
                }
            }
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }

    @Override
    public ToJson<Users> getNewChDeptBai(HttpServletRequest request,Integer deptId) {
        ToJson<Users> json = new ToJson<Users>();
        try{
            //白名单权限
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> map = modulePrivService.getModulePriv(sessionInfo, moduleId);

            map.put("jobId",request.getParameter("jobId")); //岗位
            map.put("postId",request.getParameter("postId")); //职务
            //查出全部部门的集合
            List<Department> departmentList =new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer =new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(deptId,stringBuffer,departmentList);
            Department deptById = departmentMapper.getDeptById(deptId);
            List<Users> userByDeptId=new ArrayList<Users>();
            if(!StringUtils.checkNull(deptIds)){
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = deptId.toString().split(",");
                map.put("deptIds",split);

                String sysPara = null;
                try {
                    sysPara = sysParaMapper.querySysPara("MYPROJECT").getParaValue();//防止有的产品没有myproject这个值
                }catch (Exception e){

                }
                userByDeptId = imUsersMapper.getUserByDept(map);


                String order = null;
                try {
                    order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
                }catch (Exception e){

                }
                try {
                    if ("1".equals(order)) {
                        for (Users users1 : userByDeptId) {   //排序  先获得这个用户在在该部门排序号
                            if (!StringUtils.checkNull(users1.getUserId())) {
                                users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), deptId).getOrderNo());
                            }
                        }
                        Collections.sort(userByDeptId, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                        //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                    }
                }catch (Exception e){
                    //e.printStackTrace();
                }

                if(userByDeptId!=null&&userByDeptId.size()>0){
                    for(Users u:userByDeptId){
                        String userPrivOtherName="";
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                        StringBuffer sb =new StringBuffer();//返回辅助部门
                        if (!StringUtils.checkNull(u.getUserPrivOther())){
                            String[] split1 = u.getUserPrivOther().split(",");
                            if(split1.length>3){
                                for (int j=0;j<3;j++){
                                    String s1 = split1[j];
                                    if (!StringUtils.checkNull(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1)))){
                                        sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                    }
                                }
                                userPrivOtherName = sb.toString();
                                if(!StringUtils.checkNull(userPrivOtherName)&&",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                                userPrivOtherName+="……";
                            }else{
                                for (String s1:split1){
                                    if(!StringUtils.checkNull(s1)&&!"null".equalsIgnoreCase(s1)){
                                        if (!StringUtils.checkNull(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1)))){
                                            sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                        }
                                    }
                                }
                                userPrivOtherName = sb.toString();
                                if(!StringUtils.checkNull(userPrivOtherName)&&",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                            }
                        }
                        u.setUserPrivOtherName(userPrivOtherName);
                    }
                }
            }
            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(userByDeptId,null);
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }


    @Override
    public ToJson<Department> getNewChAllDept(HttpServletRequest request,Integer deptId) {
        ToJson<Department> json = new ToJson<Department>();
        try{
            Department parentDepartment ;
            if(deptId!=null&&!deptId.equals(0)){
                parentDepartment = departmentMapper.getDeptById(deptId);
            }else{
                parentDepartment = new Department();
                parentDepartment.setDeptId(0);
            }

            Department department = NewRecursionSelectDeptUser(parentDepartment);
            json.setObject(department);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }

    @Override
    public ToJson<UserPriv> getUserByUserPriv(HttpServletRequest request, Integer userPriv) {
        ToJson<UserPriv> json = new ToJson<UserPriv>();
        try {
            List<Users> usersByUserPriv = imUsersMapper.getUsersByUserPriv(String.valueOf(userPriv));
            //查询角色
            UserPriv userPrivModel = userPrivMapper.selectByPrimaryKey(userPriv);
            //查询辅助角色用户
            userPrivModel.setUsers(usersByUserPriv);
            List<Users> usersByUSER_priv_other = imUsersMapper.getUsersByUSER_PRIV_OTHER(String.valueOf(userPriv));
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
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            //查出全部部门的集合
            List<Department> departmentList =new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer =new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(sessionInfo.getDeptId(),stringBuffer,departmentList);
            Department deptById = departmentMapper.getDeptById(sessionInfo.getDeptId());
            List<Users> userByDeptId=new ArrayList<Users>();
            if(!StringUtils.checkNull(deptIds)){
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = removeStr.split(",");
                userByDeptId = imUsersMapper.selectUserByDeptIds(split);
                if(userByDeptId!=null&&userByDeptId.size()>0){
                    for(Users u:userByDeptId){
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                    }
                }
            }
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }

    @Override
    public ToJson<Users> selNewNowUsersBai(HttpServletRequest request) {
        ToJson<Users> json = new ToJson<Users>();
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            //白名单权限
            String moduleId = request.getParameter("moduleId");
            Map map = modulePrivService.getModulePriv(sessionInfo, moduleId);
            //查出全部部门的集合
            List<Department> departmentList =new ArrayList<Department>();
            departmentList = departmentMapper.getDatagrid();
            StringBuffer stringBuffer =new StringBuffer();
            //递归
            String deptIds = NewRecursionSelectDept(sessionInfo.getDeptId(),stringBuffer,departmentList);
            Department deptById = departmentMapper.getDeptById(sessionInfo.getDeptId());
            List<Users> userByDeptId=new ArrayList<Users>();
            if(!StringUtils.checkNull(deptIds)){
                String removeStr = StringUtils.getRemoveStr(deptIds);
                String[] split = removeStr.split(",");
                map.put("deptIds",split);
                userByDeptId = imUsersMapper.selectUserByDeptIdsBai(map);
                if(userByDeptId!=null&&userByDeptId.size()>0){
                    for(Users u:userByDeptId){
                        String userPrivOtherName = "";
                        u.setDeptId(deptById.getDeptId());
                        u.setDeptName(deptById.getDeptName());
                        StringBuffer sb =new StringBuffer();
                        if (!StringUtils.checkNull(u.getUserPrivOther())){
                            String[] split1 = u.getUserPrivOther().split(",");
                            if(split1!=null&&split1.length>3){
                                for (int j=0;j<3;j++){
                                    String s1 = split1[j];
                                    sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                }
                                userPrivOtherName = sb.toString();
                                if(!StringUtils.checkNull(userPrivOtherName) && ",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                                userPrivOtherName+="……";
                            }else{
                                for (String s1:split1){
                                    sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                }
                                userPrivOtherName = sb.toString();
                                if(!StringUtils.checkNull(userPrivOtherName) && ",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                            }
                        }
                        u.setUserPrivOtherName(userPrivOtherName);
                    }
                }
            }
            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(userByDeptId,null);
            json.setObj(userByDeptId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            L.e(e);
            json.setFlag(1);
            json.setMsg("err:"+e);
        }
        return json;
    }

    @Override
    public ToJson<Object> getUsersByUserPriv(HttpServletRequest request, String userPriv) {

        ToJson<Object> departmentToJson = new ToJson<Object>();
        List<Department> departmentList = departmentMapper.getDatagrid();
        //主角色用户
        List<Users> users=imUsersMapper.getUsersByUserPriv(userPriv);

        //辅助角色用户
        List<Users> fuzhuusers=imUsersMapper.getUsersByUSER_PRIV_OTHER(userPriv);
        // imUsersMapper.ge

        //全部主角色用户计数器
        int alltheMainRoleallUsersCount=0;
        //全部禁止登陆用户计数器
        int allnoLoginUsersCount=0;
        //全部辅助角色用户计数器
        int allauxiliaryRoleUserCount=0;





        for(Department d:departmentList){

            //遍历主角色用户们
            StringBuilder theMainRoleallUsers=new StringBuilder();
            StringBuilder noLoginUsers=new StringBuilder();

            //部门主角色用户计数器
            int theMainRoleallUsersCount=0;
            //部门禁止登陆用户计数器
            int noLoginUsersCount=0;

            for(Users u:users){
                if(u.getDeptId().intValue()==d.getDeptId().intValue()){
                    theMainRoleallUsers.append(u.getUserName()+",");
                    theMainRoleallUsersCount++;

                    //判断主角色用户们是否是禁止登陆用户
                    // NOT_LOGIN         	禁止登录OA系统(1-禁止,0-不禁止)
                    if(u.getNotLogin()==1){
                        noLoginUsers.append(u.getUserName()+",");
                        noLoginUsersCount++;
                    }
                }


            }
            d.setTheMainRoleallUsers(theMainRoleallUsers.toString());
            d.setNoLoginUsers(noLoginUsers.toString());
            d.setTheMainRoleallUsersCount(theMainRoleallUsersCount);

            //总计数器累计加
            alltheMainRoleallUsersCount=alltheMainRoleallUsersCount+theMainRoleallUsersCount;
            d.setNoLoginUsersCount(noLoginUsersCount);
            allnoLoginUsersCount=allnoLoginUsersCount+ noLoginUsersCount;

            //遍历辅助角色用户
            StringBuilder auxiliaryRoleUser=new StringBuilder();
            //部门辅助角色用户计数器
            int auxiliaryRoleUserCount=0;
            for(Users u:fuzhuusers){
                if(u.getDeptId().intValue()==d.getDeptId().intValue()){
                    auxiliaryRoleUser.append(u.getUserName()+",");
                    auxiliaryRoleUserCount++;
                }
            }
            d.setAuxiliaryRoleUser(auxiliaryRoleUser.toString());
            d.setAuxiliaryRoleUserCount(auxiliaryRoleUserCount);
            //总计数器累加
            allauxiliaryRoleUserCount=allauxiliaryRoleUserCount+auxiliaryRoleUserCount;
        }

        Map map=new HashMap();

        map.put("alltheMainRoleallUsersCount",alltheMainRoleallUsersCount);
        map.put("allnoLoginUsersCount",allnoLoginUsersCount);
        map.put("allauxiliaryRoleUserCount",allauxiliaryRoleUserCount);
        departmentToJson.setObj1(map);
        departmentToJson.setObject(departmentList);
        departmentToJson.setFlag(0);
        departmentToJson.setMsg("ok");
        return departmentToJson;

    }

    @Override
    public ToJson<Object> getOnlineCount(HttpServletRequest request) {
        ToJson<Object> json =new ToJson<>(1,"err");
        try {
            List<UserOnline> list =new ArrayList<UserOnline>();
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

                //与最大差值小于3分钟
                if(nowTime-colre<=180){
                    list.add(userOnline);
                }
                //否则睡眠，随着session注销消失
               /* else{
                    //
                    //超出3分钟了则从userCountMap移除
                    String uid = userOnline.getUid();
                    Users userByUid = imUsersMapper.getUserByUid(Integer.valueOf(uid));
                    if(userByUid!=null){
                        userId=userByUid.getUserId();
                        iterator.remove();
                    }
                }*/
            }
           /* if(!StringUtils.checkNull(userId)){
                loginController.userCountMap.remove(userId);
            }*/
            json.setMsg("ok");
            json.setObject(list.size());
            json.setFlag(0);
            if(list.size()<=1){
                json.setMsg("ok");
                json.setObject(1);
                json.setFlag(0);
            }
        } catch (NumberFormatException e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }

        return json;
    }
    public Integer[] Colres(Integer[] arr){
        for(int i=0;i<arr.length;i++){
            for(int j=0;j<arr.length-i-1;j++){

                if(arr[j]>arr[j+1]){
                    int temp=arr[j];
                    arr[j]=arr[j+1];
                    arr[j+1]=temp;
                }
            }
        }

        return arr;

    }

    private void editCAccountinfo(Users user){
        try {
            String addSql="   insert into c_accountinfo (PERSON_ID, USER_ID, ACCOUNT, \n" +
                    "      PASSWORD, NAME, ID_CARD_NO, \n" +
                    "      CRED_TYPE, GENDER, USER_TYPE, \n" +
                    "      PHONE_NUMBERS, EMAILS, DATE_OF_BIRTH, \n" +
                    "      REGI_TIME, STATUS, OPERATION, \n" +
                    "      REMARK, ORG_ID)\n" +
                    "    values (" +
                    " '"+UUID.randomUUID().toString()+"'," +
                    " '"+(user.getLoginId()+"_"+user.getUserId())+"'," +
                    " '"+user.getByname()+"', " +
                    " '"+user.getPassword()+"'," +
                    " '"+user.getUserName()+"', " +
                    " '"+user.getIdNumber()+"'," +
                    " '0'," +
                    " '"+(!StringUtils.checkNull(user.getSex())&&"1".equals(user.getSex())?"0":"1")+ "'," +
                    " '"+user.getUserPriv().toString()+"'," +
                    " '"+user.getMobilNo()+"'," +
                    " '"+user.getEmail()+"'," +
                    user.getBirthday()+",'" +
                    DateFormat.getCurrentTime()+"', " +
                    "'0'," +
                    " '01'," +
                    " ''," +
                    " '"+user.getLoginId()+"'" +
                    ")";
            String editSql=" update c_accountinfo\n" +
                    "    set PASSWORD = '"+user.getPassword()+"',\n" +
                    "      NAME = '"+user.getUserName()+"',\n" +
                    "      ID_CARD_NO = '"+user.getIdNumber()+"',\n" +
                    "      CRED_TYPE = '0',\n" +
                    "      GENDER = '"+(!StringUtils.checkNull(user.getSex())&&"1".equals(user.getSex())?"0":"1")+"',\n" +
                    "      USER_TYPE = '"+user.getUserPriv().toString()+"',\n" +
                    "      PHONE_NUMBERS = '"+user.getMobilNo()+"',\n" +
                    "      EMAILS = '"+user.getEmail()+"',\n" +
                    "      DATE_OF_BIRTH = "+user.getBirthday()+",\n" +
                    "      STATUS = '0',\n" +
                    "      OPERATION = '02',\n" +
                    "      ORG_ID = '"+user.getLoginId()+"'\n" +
                    "    where USER_ID = '"+(user.getLoginId()+"_"+user.getUserId())+"'";
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
            boolean isExistPara_1 = Verification.CheckIsExistCAccountinfo(conn, driver, url, username, password, user.getLoginId()+"_"+user.getUserId());
            if (isExistPara_1 == true) {
                Statement st = conn.createStatement();
                st.executeUpdate(editSql);//执行SQL语句
            }else{
                Statement st = conn.createStatement();
                st.executeUpdate(addSql);//执行SQL语句
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


    //去重
    public List<Users> reAllUser(List<Users> list){
        Map<Integer, Users> map = new HashMap<Integer, Users>();
        for (Users users : list){
            map.put(users.getUid(), users);
        }
        list = new ArrayList<Users>(map.values());
        return list;
    }

    public List<Users> getAllUser(Map<String, Object> map){
        return imUsersMapper.getAllUser(map);
    }

    public String RecursionSelectDept(int deptId,StringBuffer stringBuffer){
        stringBuffer.append(deptId+",");
        String returnStr =new String();
        List<Department> departments = departmentMapper.selectObjectByParent(deptId);
        if(departments!=null&&departments.size()>0){
            for(Department department:departments){
                stringBuffer.append(department.getDeptId()+",");
                List<Department> departments1 = departmentMapper.selectObjectByParent(department.getDeptId());
                if(departments1!=null&&departments1.size()>0){
                    RecursionSelectDept(department.getDeptId(),stringBuffer);
                }
            }
        }
        if(!StringUtils.checkNull(stringBuffer.toString())){
            returnStr=stringBuffer.toString().substring(0,stringBuffer.toString().length()-1);
        }
        return returnStr;
    }

    public String NewRecursionSelectDept(int deptId,StringBuffer stringBuffer,List<Department>departments){
        stringBuffer.append(deptId+",");
        String returnStr =new String();

        List<Department> childList= new ArrayList<Department>();
        for (Department department:departments){
            if(department.getDeptParent()==deptId){
                stringBuffer.append(department.getDeptId()+",");
                childList.add(department);
            }
        }
        for(Department department:childList){
            NewRecursionSelectDept(department.getDeptId(),stringBuffer,departments);
        }
        if(!StringUtils.checkNull(stringBuffer.toString())){
            returnStr=stringBuffer.toString().substring(0,stringBuffer.toString().length()-1);
        }
        return returnStr;
    }

    public Department NewRecursionSelectDeptUser(Department department){
        List<Department> departmentList = departmentMapper.selectObjectByParent(department.getDeptId());
        Users users =new Users();
        users.setDeptId(department.getDeptId());
        List<Users> userByDeptId = null;
        if(department.getDeptId()!=null&&department.getDeptId()!=0){
            userByDeptId = imUsersMapper.getUserByDeptId(users);
        }else{
            userByDeptId = imUsersMapper.getUserByDeptIdZero(users);
        }
        department.setUsers(userByDeptId);
        if(departmentList!=null&&departmentList.size()>0){
            department.setChild(departmentList);
            for(Department threeDept:departmentList){
                NewRecursionSelectDeptUser(threeDept);
            }
        }
        return department;
    }
    /*@Override
    public ToJson<Users> queryUsers(HttpServletRequest request, HttpServletResponse response, Integer page, Integer pageSize, Users user, String isExport) {
        //redis处理
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users loginUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson<Users> json = new ToJson<Users>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        Map<String, Object> map = new HashMap<String, Object>();
        if(!"yes".equals(isExport)){
            map.put("page",pageParams);
        }
        map.put("userName", user.getUserName());
        map.put("sex", user.getSex());
        map.put("mobilNo", user.getMobilNo());
        map.put("telNoDept", user.getTelNoDept());
        map.put("deptId", user.getDeptId());
        map.put("roomNum", user.getRoomNum());

        try {
            List<Users> usersList=new ArrayList<>();
            //判断是否有查看全部的权限
            boolean sfqx= ifCkqb(loginUser);
            if(sfqx){
                usersList = addressZfwMapper.selectUsersPage(map);
                //部门
                for(Users users:usersList){
                    int dept=users.getDeptId();
                    String deptName=departmentMapper.getDeptNameById(dept);
                    users.setDeptName(deptName);
                }
                json.setObj(usersList);
                json.setTotleNum(addressZfwMapper.countUsersPage(map));
            }else{
                //判断是否有其他参数设置
                if(loginUser.getDeptYj()!=null &&!"".equals(loginUser.getDeptYj())){
                    String qx[]=loginUser.getDeptYj().split(",");
                    List<Integer> deptList=new ArrayList<>();
                    //得到所有子节点
                    for(String q:qx){
                        getAllChileDept(deptList,Integer.parseInt(q));
                    }
                    map.put("deptList",deptList);
                    usersList = addressZfwMapper.selectUsersPage(map);
                    //部门
                    for(Users users:usersList){
                        int dept=users.getDeptId();
                        String deptName=departmentMapper.getDeptNameById(dept);
                        users.setDeptName(deptName);
                    }
                    json.setObj(usersList);
                    json.setTotleNum(addressZfwMapper.countUsersPage(map));
                }else{
                    //用户只能查看本部门一级
                    int deptId=loginUser.getDeptId();
                    List<Integer> list=departmentMapper.getDeptIdByParent(0);
                    deptId=getDeptYJ(deptId,list);
                    List<Integer> deptList=new ArrayList<>();
                    deptList.add(deptId);
                    getAllChileDept(deptList,deptId);
                    map.put("deptList",deptList);
                    usersList = addressZfwMapper.selectUsersPage(map);
                    //部门
                    for(Users users:usersList){
                        int dept=users.getDeptId();
                        String deptName=departmentMapper.getDeptNameById(dept);
                        users.setDeptName(deptName);
                    }
                    json.setObj(usersList);
                    json.setTotleNum(addressZfwMapper.countUsersPage(map));
                }

            }

            json.setFlag(0);
            json.setMsg("ok");
            // 判断是否导出
            if ("yes".equals(isExport)) {
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("人员信息", 9);
                String[] secondTitles = { "姓名", "部门", "工作电话", "房间号", "移动电话", "传真号",};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = { "userName", "deptName",   "telNoHome", "roomNum", "mobilNo", "faxNoDept"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, usersList, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "人员信息导出表.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
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
    }*/

    //判断是否有查看全部的权限
   /* public boolean ifCkqb(Users users){

        boolean flag=false;
        //用户
        HierarchicalGlobal hierarchicalGlobal= addressZfwMapper.selectGPerson();
        //部门
        HierarchicalGlobal hierarchicalGlobal1= addressZfwMapper.selectGDept();
        //角色
        HierarchicalGlobal hierarchicalGlobal2= addressZfwMapper.selectGPriv();
        String globalDept = hierarchicalGlobal1.getGlobalDept();
        String globalPerson = hierarchicalGlobal.getGlobalPerson();
        String globalPriv = hierarchicalGlobal2.getGlobalPriv();
        String[] split = globalPerson.split(",");
        String[] split1 = globalDept.split(",");
        String[] split2 = globalPriv.split(",");
        //人员
        if(split.length!=0&&split!=null) {
            for (String splitstr : split) {
                if (users.getUserId().equals(splitstr)) {
                    flag = true;
                }
            }
        }
        //部门
        if(split1.length!=0&&split1!=null) {
            for (String splitstr : split1) {
                if (users.getDeptId().equals(splitstr)) {
                    flag = true;
                }
            }
        }
        //角色
        if(split2.length!=0&&split2!=null) {
            for (String splitstr : split2) {
                if (users.getUserPriv().equals(splitstr)) {
                    flag = true;
                }
            }
        }

        return flag;
    }
*/
    /**
     * 贾志敏 得到一级部门下所有部门
     *
     * */
    public void getAllChileDept(List<Integer> list,int deptId){
        List<Integer>  listl=departmentMapper.getDeptIdByParent(deptId);
        if(listl.size() >=0) {
            for (Integer de : listl) {
                if(!list.contains(de)){
                    list.add(de);
                    getAllChileDept(list,de);
                }
            }
        }
    }
    @Override
    public ToJson<UserPriv> getUserByUserPrivBai(HttpServletRequest request, Integer userPriv) {
        ToJson<UserPriv> json = new ToJson<UserPriv>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> map = modulePrivService.getModulePriv(user, moduleId);

            //查询角色
            UserPriv userPrivModel = userPrivMapper.selectByPrimaryKey(userPriv);

            //查询主角色的用户
            map.put("userPriv",String.valueOf(userPriv));
            map.put("jobId",request.getParameter("jobId"));
            map.put("postId",request.getParameter("postId"));
            List<Users> usersByUserPriv = imUsersMapper.getUsersByUserPrivBai(map);
            //返回结果中去除三员角色的用户和系统超级管理员、与内容密级不符的用户
            securityApprovalService.removeSecrecyUsers(usersByUserPriv,null);
            userPrivModel.setUsers(usersByUserPriv);

            //查询辅助角色用户
            /*Map map1 = new HashMap();
            map1.put("userPriv",String.valueOf(userPriv));
            map1.put("jobId",request.getParameter("jobId"));
            map1.put("postId",request.getParameter("postId"));*/
            List<Users> usersByUSER_priv_other = imUsersMapper.getUsersByUSER_PRIV_OTHERMAP(map);
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
    public ToJson<Users> queryUserByUserIdBai(HttpServletRequest request,String userName) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        ToJson<Users> json = new ToJson<Users>(1, "error");
        if (StringUtils.checkNull(userName)) {
            json.setMsg("查询不能为空");
            return json;
        }
        try {
            List<Users> userList = new ArrayList<Users>();
            if (!StringUtils.checkNull(userName)) {
                StringBuffer newStr= new StringBuffer();
                char [] stringArr = userName.toCharArray();
                for(char s:stringArr){
                    newStr.append(s+"_");
                }
                String moduleId = request.getParameter("moduleId");
                Map<String, Object> map = modulePrivService.getModulePriv(users, moduleId);
                map.put("userName",userName);
                map.put("newStr",newStr.toString());
                userList = imUsersMapper.queryUserByUserIdsBai(map);
                // 判断是否缺失头像
                for (Users u:userList) {
                    if (StringUtils.checkNull(u.getAvatar())){
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
    @Override
    public ToJson<UserPriv> getUserByUserPrivBaiOrg(HttpServletRequest request, String userPriv,String deptNo) {
        ToJson<UserPriv> json = new ToJson<UserPriv>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
            ContextHolder.setConsumerType("xoa" + loginDateSouse);

            String[] deptNoStr = deptNo.split(",");

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> map = modulePrivService.getModulePriv(user, moduleId);

            map.put("userPriv",userPriv);

            //此参数是以前用于过滤分级机构的人，现在注掉重新过滤
            //map.put("deptNo", deptNoStr);
            if(departmentService.checkOrgFlag(user) == 2) {
                List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(user, true, true);
                int[] deptIds = new int[departmentByClassifyOrg.size()];
                for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                    deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
                }
                map.put("deptIds", deptIds);
            }
            //查询主角色用户
            List<Users> usersByUserPriv = imUsersMapper.getUserByUserPrivBaiOrg(map);

            UserPriv userPrivModel = userPrivMapper.selectByPrimaryKey(Integer.valueOf(userPriv));
            //查询辅助角色用户
            userPrivModel.setUsers(usersByUserPriv);
//            Map<String,Object> userPrivMap = new HashMap();
//            userPrivMap.put("deptNo",deptNoStr);
//            userPrivMap.put("userPriv",userPriv);
//            List<Users> usersByUSER_priv_other = imUsersMapper.getUsersByUSER_PRIV_OTHERORG(userPrivMap);
            List<Users> usersByUSER_priv_other = imUsersMapper.getUserByUserPrivOtherBaiOrg(map);

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
}