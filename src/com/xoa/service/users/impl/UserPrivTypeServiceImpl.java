package com.xoa.service.users.impl;


import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UserPrivTypeMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.UserPrivType;
import com.xoa.model.users.UserPrivTypeExample;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.department.impl.DepartmentServiceImpl;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.users.UserPrivTypeService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import io.netty.util.internal.StringUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.omg.PortableInterceptor.INACTIVE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   hwx
 * 创建日期:   2022年2月15日
 * 类介绍  :   角色类型接口实现类
 */
@Service
public class UserPrivTypeServiceImpl implements UserPrivTypeService {


    @Resource
    private UserPrivTypeMapper userPrivTypeMapper;
    @Resource
    private UserPrivMapper userPrivMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UsersPrivService usersPrivService;
    @Resource
    private DepartmentService departmentService;
    @Resource
    private DepartmentServiceImpl departmentServiceImpl;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private ModulePrivService modulePrivService;
    @Resource
    private SysParaMapper sysParaMapper;
    @Resource
    private SecurityApprovalService securityApprovalService;

    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   添加角色类型
     * 参数说明:   @param userPrivType  角色类型
     * @return   ToJson<UserPrivType>
     */
    @Override
    public ToJson<UserPrivType> addUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {

        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {
            if(Objects.isNull(userPrivType) || StringUtils.checkNull(userPrivType.getPrivTypeName())
                    || Objects.isNull(userPrivType.getPrivTypeNo())){
                toJson.setMsg("角色类型参数为空");
                return toJson;
            }

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            Users managePriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_OPS_PRIV");//系统运维管理员
            if(Objects.isNull(users) || (users.getUserPriv() != 1 && !users.getUserId().equals(managePriv.getUserId()))){
                toJson.setMsg("无权限添加");
                return toJson;
            }

            int count = userPrivTypeMapper.insertSelective(userPrivType);

            if(count > 0){
                toJson.setFlag(0);
                toJson.setMsg("角色类型添加成功");
            }
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.addUserPrivType:",e);
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id删除角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return   ToJson<UserPrivType>
     */
    @Override
    public ToJson<UserPrivType> delUserPrivType(HttpServletRequest request, Integer privTypeId) {

        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {
            if(Objects.isNull(privTypeId)){
                toJson.setMsg("角色类型id为空");
                return toJson;
            }

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            Users managePriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_OPS_PRIV");//系统运维管理员
            if(Objects.isNull(users) || (users.getUserPriv() != 1 && !users.getUserId().equals(managePriv.getUserId()))){
                toJson.setMsg("无权限删除");
                return toJson;
            }

            //查询分类下是否还有角色，有角色不允许删除
            List<UserPriv> userPrivs = userPrivMapper.selectUserPrivByTypeId(privTypeId);
            if(!Objects.isNull(userPrivs) && userPrivs.size() > 0){
                toJson.setMsg("角色类型下存在角色，不允许删除");
                return toJson;
            }

            int count = userPrivTypeMapper.deleteByPrimaryKey(privTypeId);

            if(count > 0){
                toJson.setFlag(0);
                toJson.setMsg("角色类型删除成功");
            }
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.delUserPrivType:",e);
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   修改角色类型
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    @Override
    public ToJson<UserPrivType> updateUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {

        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {

            if(Objects.isNull(userPrivType) || Objects.isNull(userPrivType.getPrivTypeId())){
                toJson.setMsg("角色类型参数为空");
                return toJson;
            }

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            Users managePriv = securityApprovalService.selectSysSecurityUser("SYSECURITY_OPS_PRIV");//系统运维管理员
            if(Objects.isNull(users) || (users.getUserPriv() != 1 && !users.getUserId().equals(managePriv.getUserId()))){
                toJson.setMsg("无权限修改");
                return toJson;
            }

            int count = userPrivTypeMapper.updateByPrimaryKeySelective(userPrivType);

            if(count > 0){
                toJson.setFlag(0);
                toJson.setMsg("角色类型修改成功");
            }
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.updateUserPrivType:",e);
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   查询角色类型列表
     * 参数说明:   @param userPrivType  角色类型信息
     * @return ToJson<UserPrivType>
     */
    @Override
    public ToJson<UserPrivType> queryUserPrivType(HttpServletRequest request, UserPrivType userPrivType) {
        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        //把逻辑单独写一个方法 queryUserPrivTypeFun
        List<UserPrivType> userPrivTypes = queryUserPrivTypeFun();
        toJson.setFlag(0);
        toJson.setObj(userPrivTypes);
        toJson.setMsg("查询成功");
        return toJson;
    }



    @Override
    public ToJson<UserPrivType> queryUserPrivTypeNew(HttpServletRequest request, UserPrivType userPrivType, String deptId) {

        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {

            Department department = departmentMapper.selectByDeptId(Integer.valueOf(deptId));
            List<UserPrivType> userPrivTypes = new ArrayList<>();
            if (!StringUtil.isNullOrEmpty(department.getPrivTypes()) && !department.getPrivTypes().equals("") && !department.getPrivTypes().equals(",")){
                HashMap<String, Object> map = new HashMap<>();
                map.put("orderByClause", "PRIV_TYPE_NO");
                map.put("privTypes", department.getPrivTypes());
                userPrivTypes.addAll(userPrivTypeMapper.selectByExampleNew(map));
                toJson.setFlag(0);
                toJson.setObj(userPrivTypes);
                toJson.setMsg("查询成功");
            }else {
                UserPrivTypeExample example = new UserPrivTypeExample();
                UserPrivTypeExample.Criteria criteria = example.createCriteria();
                example.setOrderByClause("PRIV_TYPE_NO");
                //列表中默认第一条为未分类
                UserPrivType privType = new UserPrivType();
                privType.setPrivTypeId(0);
                privType.setPrivTypeNo(0);
                privType.setPrivTypeName("未分类");
                userPrivTypes.add(privType);

                userPrivTypes.addAll(userPrivTypeMapper.selectByExample(example));
                toJson.setFlag(0);
                toJson.setObj(userPrivTypes);
                toJson.setMsg("查询成功");
            }

        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.queryUserPrivType:",e);
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表
     * 参数说明:   @param typeId  角色类型id
     * @return ToJson<UserPriv>
     */
    @Override
    public ToJson<UserPriv> queryUserPrivByTypeId(HttpServletRequest request, Integer privTypeId) {

        ToJson<UserPriv> toJson = new ToJson(1, "error");
        try {

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            //角色类型id 查询没有所有没有分类的角色列表
            if(Objects.isNull(privTypeId)){
                privTypeId = 0;
            }

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> maps = modulePrivService.getModulePriv(users, moduleId);
            maps.put("privTypeId",privTypeId);

            //获取用户角色和辅助角色中权限最大的一个角色序号
            String userPrivIds = "";
            if (!StringUtils.checkNull(users.getUserPrivOther())) {
                userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
            } else {
                userPrivIds = String.valueOf(users.getUserPriv());
            }
            String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
            List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
            List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
            UserPriv userRole = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
            //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
            if (userPrivAdmin.size()== 0 && userRole.getPrivType() == 0) {
                maps.put("privNoS", userRole.getPrivNo());
                maps.put("privType", userRole.getPrivType());
            }

            List<UserPriv> userPrivs = userPrivMapper.selectUserPrivByMaps(maps);

            if(Objects.isNull(userPrivs) || userPrivs.size() == 0){
                toJson.setFlag(0);
                toJson.setMsg("无数据");
                return toJson;
            }

            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            //securityApprovalService.removeSecrecyUsers(null,userPrivs);

            String privIds = userPrivs.stream().map(UserPriv::getUserPriv).map(String::valueOf).collect(Collectors.joining(","));

            //查出所有部门
            //List<Department> departmentList = departmentMapper.getDatagrid();

            //主角色用户 根据角色Id查出所有用户
            List<Users> usersByPrivIds = usersMapper.getUsersByPrivIdsAndPrivOtherIds(privIds.split(","));

            userPrivs.forEach(userPriv -> {

                //全部主角色用户计数器
                int alltheMainRoleallUsersCount=0;
                //全部禁止登陆用户计数器
                int allnoLoginUsersCount=0;
                //全部辅助角色用户计数器
                int allauxiliaryRoleUserCount=0;

                for (Users user : usersByPrivIds) {
                    boolean allnoLoginUsersFlag = true;
                    if (userPriv.getUserPriv().equals(user.getUserPriv())) {
                        alltheMainRoleallUsersCount++;
                        if (user.getNotLogin() == 1) {
                            allnoLoginUsersCount++;
                            //同一个用户这里增加过计数器，下面的判断中就不增加了
                            allnoLoginUsersFlag = false;
                        }
                    }
                    if (!StringUtils.checkNull(user.getUserPrivOther()) && Arrays.asList(user.getUserPrivOther().split(",")).contains(userPriv.getUserPriv().toString())) {
                        allauxiliaryRoleUserCount++;
                        if (allnoLoginUsersFlag && user.getNotLogin() == 1) {
                            allnoLoginUsersCount++;
                        }
                    }
                }

                userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
            });

            toJson.setFlag(0);
            toJson.setObj(userPrivs);
            toJson.setMsg("查询成功");
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.queryUserPrivByTypeId:",e);
            e.printStackTrace();
        }
        return toJson;
    }

    @Override
    public ToJson<UserPriv> queryUserPrivByTypeIdNew(HttpServletRequest request, Integer privTypeId, Integer number, String deptId) {

        ToJson<UserPriv> toJson = new ToJson(1, "error");
        try {
            Department department = new Department();
            if (!StringUtils.checkNull(deptId)){
                department = departmentMapper.selectByDeptId(Integer.valueOf(deptId));
            }
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            //角色类型id 查询没有所有没有分类的角色列表
            if(Objects.isNull(privTypeId)){
                privTypeId = 0;
            }

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> maps = modulePrivService.getModulePriv(users, moduleId);
            maps.put("privTypeId",privTypeId);

            //获取用户角色和辅助角色中权限最大的一个角色序号
            String userPrivIds = users.getUserPriv() + "," + users.getUserPrivOther();
            String[] userPrivIdArr = Arrays.asList(userPrivIds.split(",")).stream().filter(up -> !StringUtils.checkNull(up)).toArray(String[]::new);
            List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(userPrivIdArr);
            List<UserPriv> userPrivAdmin = userPrivByIds.stream().filter(up -> up.getPrivType() == 1).collect(Collectors.toList());
            UserPriv userRole = null;
            if (!CollectionUtils.isEmpty(userPrivByIds)){
                userRole = userPrivByIds.stream().min(Comparator.comparing(UserPriv::getPrivNo)).get();
            }
            //判断用户的角色集中是否含有OA管理员角色，是则不增加限制
            if (userPrivAdmin.size() == 0 && userRole != null && userRole.getPrivType() == 0) {
                maps.put("privNoS", userRole.getPrivNo());
                maps.put("privType", userRole.getPrivType());
            }
            if (StringUtil.isNullOrEmpty(department.getPrivTypes()) || department.getPrivTypes().equals("")){
                maps.put("privMaxNo", number);
            }

            List<UserPriv> userPrivs = userPrivMapper.selectUserPrivByMaps(maps);

            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(null,userPrivs);

            if(Objects.isNull(userPrivs) || userPrivs.size() == 0){
                toJson.setFlag(0);
                toJson.setMsg("无数据");
                return toJson;
            }

            String privIds = userPrivs.stream().map(UserPriv::getUserPriv).map(String::valueOf).collect(Collectors.joining(","));

            //查出所有部门
            //List<Department> departmentList = departmentMapper.getDatagrid();

            //主角色用户 根据角色Id查出所有用户
            List<Users> usersByPrivIds = usersMapper.getUsersByPrivIdsAndPrivOtherIds(privIds.split(","));

            userPrivs.forEach(userPriv -> {

                //全部主角色用户计数器
                int alltheMainRoleallUsersCount=0;
                //全部禁止登陆用户计数器
                int allnoLoginUsersCount=0;
                //全部辅助角色用户计数器
                int allauxiliaryRoleUserCount=0;

                for (Users user : usersByPrivIds) {
                    boolean allnoLoginUsersFlag = true;
                    if (userPriv.getUserPriv().equals(user.getUserPriv())) {
                        alltheMainRoleallUsersCount++;
                        if (user.getNotLogin() == 1) {
                            allnoLoginUsersCount++;
                            //同一个用户这里增加过计数器，下面的判断中就不增加了
                            allnoLoginUsersFlag = false;
                        }
                    }
                    if (!StringUtils.checkNull(user.getUserPrivOther()) && Arrays.asList(user.getUserPrivOther().split(",")).contains(userPriv.getUserPriv().toString())) {
                        allauxiliaryRoleUserCount++;
                        if (allnoLoginUsersFlag && user.getNotLogin() == 1) {
                            allnoLoginUsersCount++;
                        }
                    }
                }

                userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
            });
            toJson.setFlag(0);
            toJson.setObj(userPrivs);
            toJson.setMsg("查询成功");
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.queryUserPrivByTypeId:",e);
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据id查询角色类型
     * 参数说明:   @param privTypeId  角色类型id
     * @return ToJson<UserPrivType>
     */
    @Override
    public ToJson<UserPrivType> selUserPrivType(HttpServletRequest request, Integer privTypeId) {
        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {
            if(Objects.isNull(privTypeId)){
                toJson.setMsg("角色类型id为空");
                return toJson;
            }

            UserPrivType userPrivType = userPrivTypeMapper.selectByPrimaryKey(privTypeId);

            toJson.setObject(userPrivType);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            return toJson;
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selUserPrivType:",e);
        }
        return toJson;
    }


    @Override
    public ToJson<UserPrivType> queryUserPrivTypeById(HttpServletRequest request, Integer privTypeId) {
        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {
            if(Objects.isNull(privTypeId)){
                toJson.setMsg("角色类型id为空");
                return toJson;
            }

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            List<Integer> typeIds = checkPrivTypeIdByDept(users);

            if(Objects.isNull(typeIds) || typeIds.size() == 0 || !typeIds.contains(privTypeId)) {
                toJson.setFlag(0);
                toJson.setMsg("无权限查询此角色分类");
                return toJson;
            }

            UserPrivType userPrivType = userPrivTypeMapper.selectByPrimaryKey(privTypeId);

            toJson.setObject(userPrivType);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            return toJson;
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.queryUserPrivTypeById:",e);
        }
        return toJson;
    }


    @Override
    public ToJson<UserPrivType> selUserPrivTypeByDept(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        ToJson<UserPrivType> toJson = new ToJson(1, "error");
        try {

            List<Integer> list = checkPrivTypeIdByDept(users);

            if(Objects.isNull(list) || list.size() == 0){
                toJson.setMsg("无角色类型数据");
                return toJson;
            }
            UserPrivTypeExample userPrivTypeExample = new UserPrivTypeExample();
            UserPrivTypeExample.Criteria criteria = userPrivTypeExample.createCriteria();
            criteria.andPrivTypeIdIn(list);
            List<UserPrivType> userPrivTypes = userPrivTypeMapper.selectByExampleWithBLOBs(userPrivTypeExample);

            toJson.setObj(userPrivTypes);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selUserPrivTypeByDept:",e);
        }
        return toJson;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月15日
     * 方法介绍:   根据角色类型id查询对应的角色列表
     * 参数说明:   @param typeId  角色类型id
     * @return ToJson<UserPriv>
     */
    @Override
    public ToJson<UserPriv> queryUserPrivByTypeIdAndDept(HttpServletRequest request, Integer privTypeId) {

        ToJson<UserPriv> toJson = new ToJson(1, "error");
        try {

            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            //角色类型id 查询没有所有没有分类的角色列表
            if(Objects.isNull(privTypeId)){
                toJson.setMsg("参数错误");
                toJson.setFlag(0);
                return toJson;
            }

            List<Integer> list = checkPrivTypeIdByDept(users);
            if (!list.contains(privTypeId)) {
                toJson.setMsg("无数据");
                toJson.setFlag(0);
                return toJson;
            }

            List<UserPriv> userPrivs = userPrivMapper.selectUserPrivByTypeId(privTypeId);
            userPrivs.forEach(userPriv -> {
                Map<String,Integer> map1= usersPrivService.getUsersByUserPriv(userPriv.getUserPriv()+"");
                //全部主角色用户计数器
                int alltheMainRoleallUsersCount=map1.get("alltheMainRoleallUsersCount");;
                //全部禁止登陆用户计数器
                int allnoLoginUsersCount=map1.get("allnoLoginUsersCount");
                //全部辅助角色用户计数器
                int allauxiliaryRoleUserCount=map1.get("allauxiliaryRoleUserCount");

                userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
            });
            toJson.setFlag(0);
            toJson.setObj(userPrivs);
            toJson.setMsg("查询成功");
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            L.e("UserPrivTypeServiceImpl.queryUserPrivByTypeIdAndDept:",e);
        }
        return toJson;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/28
     * 方法介绍: 根据当前用户，管理的分支机构，查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    @Override
    public ToJson<UserPrivType> selectUserPrivTypeByOrgAdmin(HttpServletRequest request) {
        ToJson<UserPrivType> json = new ToJson<>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        try {
            //获取当前用户，管理的分支机构
            Map<String, Object> map = new HashMap<>();
            map.put("uid", users.getUid());
            List<Department> departmentList = departmentMapper.getClassifyOrgByAdmin(map);

            if (!CollectionUtils.isEmpty(departmentList)) {
                List<Integer> privTypeIds = new ArrayList<>();
                for (Department department : departmentList) {
                    if (!StringUtils.checkNull(department.getPrivTypes())) {
                        privTypeIds.addAll(Arrays.stream(department.getPrivTypes().split(",")).map(Integer::valueOf).collect(Collectors.toList()));
                    }
                }

                if (!CollectionUtils.isEmpty(privTypeIds)) {
                    //获取当前用户，管理的分支机构，设置的角色分类
                    map.clear();
                    map.put("privTypeIds", privTypeIds);
                    List<UserPrivType> list = userPrivTypeMapper.queryAllUserPrivType(map);

                    if (!CollectionUtils.isEmpty(list)) {
                        json.setFlag(0);
                        json.setMsg("查询成功");
                        json.setObj(list);
                    } else {
                        json.setFlag(0);
                        json.setMsg("暂无数据");
                    }
                } else {
                    json.setFlag(0);
                    json.setMsg("暂无数据");
                }
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selectUserPrivTypeByOrgAdmin:", e);
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/4
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，查询所有角色。 高级查询（根据角色分类ID）
     * 参数说明: [request, privTypeId]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @Override
    public ToJson<UserPriv> queryAllUserPriv(HttpServletRequest request, Integer privTypeId) {
        ToJson<UserPriv> json = new ToJson<>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            //获取当前用户，管理的分支机构
            Map<String, Object> map = new HashMap<>();
            map.put("uid", users.getUid());
            List<Department> departmentList = departmentMapper.getClassifyOrgByAdmin(map);

            if (!CollectionUtils.isEmpty(departmentList)) {
                List<Integer> privTypeIds = new ArrayList<>();
                for (Department department : departmentList) {
                    if (!StringUtils.checkNull(department.getPrivTypes())) {
                        privTypeIds.addAll(Arrays.stream(department.getPrivTypes().split(",")).map(Integer::valueOf).collect(Collectors.toList()));
                    }
                }

                //获取当前用户，管理的分支机构，设置的角色分类
                map.clear();
                map.put("privTypeIds", privTypeIds);
                map.put("privTypeId", privTypeId);
                List<UserPrivType> userPrivTypes = userPrivTypeMapper.queryAllUserPrivType(map);

                if (!CollectionUtils.isEmpty(userPrivTypes)) {
                    Set<Integer> privTypeIdSet = userPrivTypes.stream().map(UserPrivType::getPrivTypeId).collect(Collectors.toSet());
                    List<UserPriv> userPrivList = userPrivMapper.selectUserPrivByTypeIds(privTypeIdSet);
                    if (!CollectionUtils.isEmpty(userPrivList)){
                        userPrivList.forEach(userPriv -> {
                            Map<String,Integer> map1= usersPrivService.getUsersByUserPriv(userPriv.getUserPriv()+"");
                            //全部主角色用户计数器
                            int alltheMainRoleallUsersCount=map1.get("alltheMainRoleallUsersCount");;
                            //全部禁止登陆用户计数器
                            int allnoLoginUsersCount=map1.get("allnoLoginUsersCount");
                            //全部辅助角色用户计数器
                            int allauxiliaryRoleUserCount=map1.get("allauxiliaryRoleUserCount");

                            userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
                        });

                        json.setFlag(0);
                        json.setMsg("ok");
                        json.setObj(userPrivList);
                    } else {
                        json.setFlag(0);
                        json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
                    }
                } else {
                    json.setFlag(0);
                    json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
                }
            } else {
                json.setFlag(0);
                json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
            }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selUserPrivTypeByDept:",e);
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/11/29
     * 方法介绍: 根据当前用户分级机构设置的角色类型范围的角色，通过角色名称模糊查询角色
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @Override
    public ToJson<UserPriv> queryUserPrivByPrivName(HttpServletRequest request, String privName) {
        ToJson<UserPriv> json = new ToJson<>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            //获取当前用户，管理的分支机构
            Map<String, Object> map = new HashMap<>();
            map.put("uid", users.getUid());
            List<Department> departmentList = departmentMapper.getClassifyOrgByAdmin(map);

            if (!CollectionUtils.isEmpty(departmentList)) {
                List<Integer> privTypeIds = new ArrayList<>();
                for (Department department : departmentList) {
                    if (!StringUtils.checkNull(department.getPrivTypes())) {
                        privTypeIds.addAll(Arrays.stream(department.getPrivTypes().split(",")).map(Integer::valueOf).collect(Collectors.toList()));
                    }
                }

                //获取当前用户，管理的分支机构，设置的角色分类
                map.clear();
                map.put("privTypeIds", privTypeIds);
                List<UserPrivType> userPrivTypes = userPrivTypeMapper.queryAllUserPrivType(map);

                if (!CollectionUtils.isEmpty(userPrivTypes)) {
                    Map<String, Object> hashMap = new HashMap<>();
                    hashMap.put("userPrivTypes", userPrivTypes.stream().map(UserPrivType::getPrivTypeId).collect(Collectors.toList()));
                    if (!StringUtils.checkNull(privName)) {
                        hashMap.put("privName", privName);
                    }
                    List<UserPriv> userPrivList = userPrivMapper.queryUserPrivByPrivName(hashMap);
                    if (!CollectionUtils.isEmpty(userPrivList)){
                        userPrivList.forEach(userPriv -> {
                            Map<String,Integer> map1= usersPrivService.getUsersByUserPriv(userPriv.getUserPriv()+"");
                            //全部主角色用户计数器
                            int alltheMainRoleallUsersCount=map1.get("alltheMainRoleallUsersCount");;
                            //全部禁止登陆用户计数器
                            int allnoLoginUsersCount=map1.get("allnoLoginUsersCount");
                            //全部辅助角色用户计数器
                            int allauxiliaryRoleUserCount=map1.get("allauxiliaryRoleUserCount");

                            userPriv.setShowCount(alltheMainRoleallUsersCount+"("+allnoLoginUsersCount+")/"+allauxiliaryRoleUserCount);
                        });

                        json.setFlag(0);
                        json.setMsg("ok");
                        json.setObj(userPrivList);
                    } else {
                        json.setFlag(0);
                        json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
                    }
                } else {
                    json.setFlag(0);
                    json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
                }
            } else {
                json.setFlag(0);
                json.setMsg("请在分支机构设置中，设置您所属的分支机构的可管理角色分类！");
            }
        }catch (Exception e){
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selUserPrivTypeByDept:",e);
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/1/12
     * 方法介绍: 根据当前用户所在的分支机构查询角色分类
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPrivType>
     **/
    @Override
    public ToJson<UserPrivType> selectUserPrivTypeByClassifyOrg(HttpServletRequest request) {
        ToJson<UserPrivType> json = new ToJson<>(1, "error");
        List<UserPrivType> list = selectUserPrivTypeByClassifyOrgFun(request);
        if (!CollectionUtils.isEmpty(list)) {
            json.setFlag(0);
            json.setMsg("ok");
            json.setObj(list);
        } else {
            json.setFlag(0);
            json.setMsg("暂无数据");
        }
        return json;
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导入
     * 参数说明: [request, privName]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @Override
    public ToJson<UserPriv> inputUserPriv(HttpServletRequest request, MultipartFile file) {
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

                    // 获取当前登录人管理范围内的角色分类
                    List<String> privTypeNameList = new ArrayList<>();
                    List<UserPrivType> userPrivTypeList = selectUserPrivTypeByOrgAdmin(request).getObj();
                    if (!CollectionUtils.isEmpty(userPrivTypeList)) {
                        privTypeNameList = userPrivTypeList.stream().map(UserPrivType::getPrivTypeName).collect(Collectors.toList());
                    }

                    for (int i = 2; i <= lastRowNum; i++) {
                        rowObj = sheetObj.getRow(i);
                        if (rowObj != null) {
                            Cell c0 = rowObj.getCell(0);//角色排序号
                            Cell c1 = rowObj.getCell(1);//角色名称
                            Cell c2 = rowObj.getCell(2);//权限模块
                            Cell c3 = rowObj.getCell(3);//角色分类

                            // 判断填入的角色分类是否在管理范围内
                            if (privTypeNameList.contains(c3.getStringCellValue())) {
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
                                        if (c3 != null) {
                                            String privTypeName = c3.getStringCellValue();
                                            UserPrivType userPrivType = userPrivTypeMapper.selectByPrivTypeName(privTypeName);
                                            if (userPrivType != null && userPrivType.getPrivTypeId() != null) {
                                                userPriv.setPrivTypeId(userPrivType.getPrivTypeId());
                                            }
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
                            } else {
                                fail++;
                                temp.setPrivTypeId(1);
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
     * 创建作者: 金帅强
     * 创建时间: 2022/12/26
     * 方法介绍: 分支机构 角色权限信息导出
     * 参数说明: [request, response]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @Override
    public ToJson<UserPriv> outputUserPriv(HttpServletRequest request, HttpServletResponse response) {
        ToJson<UserPriv> json = new ToJson<UserPriv>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try {
            //根据当前用户分级机构查询角色类型
            List<Integer> list = checkPrivTypeIdByDept(users);
            if(Objects.isNull(list) || list.size() == 0){
                json.setMsg("无角色类型数据");
                return json;
            }
            UserPrivTypeExample userPrivTypeExample = new UserPrivTypeExample();
            UserPrivTypeExample.Criteria criteria = userPrivTypeExample.createCriteria();
            criteria.andPrivTypeIdIn(list);
            List<UserPrivType> userPrivTypes = userPrivTypeMapper.selectByExampleWithBLOBs(userPrivTypeExample);

            if (!CollectionUtils.isEmpty(userPrivTypes)) {
                Set<Integer> privTypeIds = userPrivTypes.stream().map(UserPrivType::getPrivTypeId).collect(Collectors.toSet());
                List<UserPriv> userPrivList = userPrivMapper.selectUserPrivByTypeIds(privTypeIds);

                Map<String,HashMap<String,String>> map = usersPrivService.getFunIdAndFunName();
                //优化后的归档
                for (UserPriv userPriv : userPrivList) {
                    StringBuffer tempStr = new StringBuffer();
                    String[] funcIdArray = userPriv.getFuncIdStr().split(",");
                    Map ma1p;
                    for (String funcId : funcIdArray) {
                        if(!StringUtils.checkNull(funcId)){
                            ma1p = map.get(funcId);
                            if(ma1p!=null){
                                tempStr.append(ma1p.get("FUNC_NAME") + ",");
                            }
                        }
                    }
                    userPriv.setFuncIdStr(tempStr.toString());
                }

                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("分支机构角色权限信息导出", 9);
                String[] secondTitles = {"角色排序号", "角色名称", "权限模块", "角色分类"};
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);

                String[] beanProperty = {"privNo", "privName", "funcIdStr", "privTypeName"};
                HSSFWorkbook workbook = ExcelUtil.exportExcelData(workbook2, userPrivList, beanProperty);
                ServletOutputStream out = response.getOutputStream();

                String filename = "分支机构角色权限信息导出.xls"; //考虑多语言
                filename = FileUtils.encodeDownloadFilename(filename,
                        request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("content-disposition",
                        "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
                json.setFlag(0);
                json.setMsg("OK");
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("UserPrivController outputUserPriv:" + e);
        }
        return json;
    }


    @Override
    public List<Integer> checkPrivTypeIdByDept(Users users){
        List<Integer> list = new ArrayList<>();
        List<Department> classifyOrg = departmentService.getDepartmentByClassifyOrg(users, true, true);
        if(Objects.isNull(classifyOrg) || classifyOrg.size() == 0){
            return list;
        }

        //提取部门中的所有角色分类id串并去重
        Set<Integer> privTypes = Arrays.stream(classifyOrg.stream()
                .map(Department::getPrivTypes).filter(types -> !StringUtils.checkNull(types))
                .collect(Collectors.joining("")).split(",")).mapToInt(Integer::valueOf).boxed().collect(Collectors.toSet());

        if(Objects.isNull(privTypes) || privTypes.size() == 0){
            return list;
        }
        list.addAll(privTypes);
        return list;
    }


    @Override
    public List<Integer> getPrivTypeFuncIds(Users users){

        //定义返回结果集
        List<Integer> privTypeFuncIds = new ArrayList<>();

        //获取所有有权限的角色分类id
        List<Integer> list = checkPrivTypeIdByDept(users);

        //无角色分类id返回 0 菜单id
        if(Objects.isNull(list) || list.size() == 0){
            privTypeFuncIds.add(0);
            return privTypeFuncIds;
        }

        //根据角色分类id查询对应的角色分类列表
        UserPrivTypeExample userPrivTypeExample = new UserPrivTypeExample();
        UserPrivTypeExample.Criteria criteria = userPrivTypeExample.createCriteria();
        criteria.andPrivTypeIdIn(list);
        List<UserPrivType> userPrivTypes = userPrivTypeMapper.selectByExampleWithBLOBs(userPrivTypeExample);

        //获取角色分类中的所有菜单id串并去重
        StringBuffer funcIdStr = new StringBuffer();
        for (UserPrivType userPrivType : userPrivTypes) {

            String funcId = userPrivType.getFuncIdStr();
            //包含无菜单id串的角色分类，则表示不限制,返回空结果集（拥有所有菜单id权限）
            if(StringUtils.checkNull(funcId)){
                return privTypeFuncIds;
            }

            //去重角色分类的菜单id串
            if(!funcId.endsWith(",")) {
                funcId = funcId + ",";
            }
            funcIdStr.append(funcId);
        }
        String[] funcIds = funcIdStr.toString().split(",");
        Set<Integer> ids = new HashSet<>();
        for (int i = 0; i < funcIds.length; i++) {
            if(!StringUtils.checkNull(funcIds[i])){
                ids.add(Integer.valueOf(funcIds[i]));
            }
        }
        privTypeFuncIds.addAll(ids);
        return privTypeFuncIds;
    }


    /**
     * 创建作者:   hwx
     * 创建日期:   2022年2月22日
     * 方法介绍:   返回集合为null，则用户是系统管理员，
     *           返回集合为非null但集合为空，则用户没有能查的角色类型
     *           返回集合有值，使用返回的值做过滤查询条件
     *
     * 参数说明:   @param users
     * @return List<Integer>
     */
    private List<Integer> checkPrivTypeId(Users users){

        List<Integer> result = null;

        //系统管理员能查看全部分类，其他用户根据部门以及辅助部门来查询 下面的角色分类id串
        if(users.getUserPriv() != 1){

            result = new ArrayList<>();
            String privTypeIds = "";
            if(!Objects.isNull(users.getUserPriv())){
                String deptIds = users.getDeptId() + "," + users.getDeptIdOther();
                List<Department> departments = departmentMapper.selDeptByIds(deptIds.split(","));

                //拼接部门的全部分类id
                for (Department department : departments) {
                    privTypeIds += department.getPrivTypes();
                }
            }

            if(!StringUtils.checkNull(privTypeIds)){
                result = Arrays.asList(privTypeIds.split(",")).
                        stream().map(id -> Integer.parseInt(id.trim())).collect(Collectors.toList());
            }
        }

        return result;
    }

    //查询角色类型列表
    public List<UserPrivType> queryUserPrivTypeFun() {
        List<UserPrivType> userPrivTypes = new ArrayList<>();
        try {

            /*Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            List<Integer> typeIds = checkPrivTypeId(users);

            if(!Objects.isNull(typeIds) && typeIds.size() <= 0){
                toJson.setFlag(0);
                toJson.setMsg("部门下无角色分类");
                return toJson;
            }*/

            UserPrivTypeExample example = new UserPrivTypeExample();
            UserPrivTypeExample.Criteria criteria = example.createCriteria();
            example.setOrderByClause("PRIV_TYPE_NO");

            /*if(!Objects.isNull(typeIds) && typeIds.size() > 0) {
                //作为条件传入
                criteria.andPrivTypeIdIn(typeIds);
            }*/


            //列表中默认第一条为未分类
            UserPrivType privType = new UserPrivType();
            privType.setPrivTypeId(0);
            privType.setPrivTypeNo(0);
            privType.setPrivTypeName("未分类");
            userPrivTypes.add(privType);

            userPrivTypes.addAll(userPrivTypeMapper.selectByExample(example));
        }catch (Exception e){
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.queryUserPrivTypeFun:",e);
        }
        return userPrivTypes;
    }

    //根据当前用户所在的分支机构查询角色分类
    public List<UserPrivType> selectUserPrivTypeByClassifyOrgFun(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        List<UserPrivType> resultList = new ArrayList<>();
        try {
            //是否开启分级机构设置
            String sysPara = sysParaMapper.querySysPara("ORG_SCOPE").getParaValue();
            if (!StringUtils.checkNull(sysPara) && sysPara.equals("1")) {
                //开启，根据当前用户所在的分支机构查询角色分类
                //获取当前用户所在的分支机构
                Department department = departmentServiceImpl.queryDeptParent(users.getDeptId());
                if (department != null) {
                    if (!StringUtils.checkNull(department.getPrivTypes())) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("privTypeIds", Arrays.asList(department.getPrivTypes().split(",")));
                        resultList = userPrivTypeMapper.queryAllUserPrivType(map);
                    }
                } else {
                    //不是分支机构用户，则返回所有角色分类
                    resultList = queryUserPrivTypeFun();
                }
            } else {
                //没有开启，返回所有角色分类
                //使用 queryUserPrivTypeFun 方法逻辑
                resultList = queryUserPrivTypeFun();
            }
        } catch (Exception e) {
            e.printStackTrace();
            L.e("UserPrivTypeServiceImpl.selectUserPrivTypeByClassifyOrgFun:", e);
        }
        return resultList;
    }
}
