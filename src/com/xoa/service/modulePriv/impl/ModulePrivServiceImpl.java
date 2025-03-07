package com.xoa.service.modulePriv.impl;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   张航宁
 * 创建日期:   2017-07-05
 * 类介绍  :   用户权限接口实现类
 * 构造参数:   无
 */
@Service
public class ModulePrivServiceImpl implements ModulePrivService {

    @Resource
    private ModulePrivMapper modulePrivMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UserPrivMapper userPrivMapper;

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   保存方法
     *
     * @return ToJson<ModulePriv>
     */
    @Override
    @Transactional
    public ToJson<ModulePriv> saveModulePriv(ModulePriv modulePriv, String applyModules, String applyDepts, String applyPrivs) {
        ToJson json = new ToJson();
        try {
            // 判断范围是否为空 任意一项为空 就为不限制权限
            if (modulePriv.getDeptId() == null || modulePriv.getPrivId() == null) {
                modulePrivMapper.deleteModulePriv(modulePriv);
                // 判断是否应用到其他模块中
                if (!StringUtils.checkNull(applyModules)) {
                    String[] moduleIds = applyModules.split(",");
                    for (String moduleId : moduleIds) {
                        modulePriv.setModuleId(Integer.valueOf(moduleId));
                        modulePrivMapper.deleteModulePriv(modulePriv);
                    }
                }
                // 判断是否将此模块的权限应用到其他的用户上
                if (!StringUtils.checkNull(applyDepts) && !StringUtils.checkNull(applyPrivs)) {
                    String[] deptIds = applyDepts.split(",");
                    String[] privIds = applyPrivs.split(",");
                    List<Users> usersByDeptAndPriv = usersMapper.getUsersByDeptAndPriv(deptIds, privIds);
                    if (usersByDeptAndPriv != null && usersByDeptAndPriv.size() > 0) {
                        StringBuffer sb = new StringBuffer();
                        for (Users entity : usersByDeptAndPriv) {
                            sb.append(entity.getUid() + ",");
                        }
                        modulePrivMapper.deleteModulePrivs(sb.toString().split(","), modulePriv.getModuleId());
                    }
                }
            } else {
                ModulePriv modulePrivSingle = modulePrivMapper.getModulePrivSingle(modulePriv);
                if (modulePrivSingle != null) {
                    modulePrivMapper.updateModulePriv(modulePriv);
                } else {
                    modulePrivMapper.addModulePriv(modulePriv);
                }
                // 判断是否应用到其他模块中
                if (!StringUtils.checkNull(applyModules)) {
                    String[] moduleIds = applyModules.split(",");
                    for (String moduleId : moduleIds) {
                        modulePriv.setModuleId(Integer.valueOf(moduleId));
                        ModulePriv modulePrivSingle2 = modulePrivMapper.getModulePrivSingle(modulePriv);
                        if (modulePrivSingle2 != null) {
                            modulePrivMapper.updateModulePriv(modulePriv);
                        } else {
                            modulePrivMapper.addModulePriv(modulePriv);
                        }
                    }
                }
                // 判断是否将此模块的权限应用到其他的用户上
                if (!StringUtils.checkNull(applyDepts) && !StringUtils.checkNull(applyPrivs)) {
                    String[] deptIds = applyDepts.split(",");
                    String[] privIds = applyPrivs.split(",");
                    List<Users> usersByDeptAndPriv = usersMapper.getUsersByDeptAndPriv(deptIds, privIds);
                    for (Users entity : usersByDeptAndPriv) {
                        modulePriv.setUid(entity.getUid());
                        ModulePriv modulePrivSingle3 = modulePrivMapper.getModulePrivSingle(modulePriv);
                        if (modulePrivSingle3 != null) {
                            modulePrivMapper.updateModulePriv(modulePriv);
                        } else {
                            modulePrivMapper.addModulePriv(modulePriv);
                        }
                    }
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
     * 创建日期:   2017年7月6日
     * 方法介绍:   更新方法
     *
     * @return ToJson<ModulePriv>
     */
    @Override
    @Transactional
    public ToJson<ModulePriv> updateModulePriv(ModulePriv modulePriv) {
        ToJson json = new ToJson();
        try {
            if (modulePriv.getDeptId() == null || modulePriv.getPrivId() == null) {
                modulePrivMapper.deleteModulePriv(modulePriv);
                json.setMsg("ok");
                json.setFlag(0);
            } else {
                modulePrivMapper.updateModulePriv(modulePriv);
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg("err");
            json.setFlag(1);
            L.e("ModulePrivServiceImpl updateModulePriv:" + e);
        }
        return json;
    }

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid删除
     *
     * @return ToJson<ModulePriv>
     */
    @Override
    public ToJson<ModulePriv> deleteModulePriv(ModulePriv modulePriv) {
        ToJson json = new ToJson();
        try {
            modulePrivMapper.deleteModulePriv(modulePriv);
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
     * 创建日期:   2017年7月6日
     * 方法介绍:   根据uid和moduleid查询单个实体
     *
     * @return ToJson<ModulePriv>
     */
    @Override
    public ToJson<ModulePriv> getModulePrivSingle(ModulePriv modulePriv) {
        ToJson<ModulePriv> json = new ToJson<ModulePriv>();
        try {
            ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);

            json.setObject(modulePrivByUid);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 查询可设置管理范围的模块列表
     * @param request
     * @return
     */
    @Override
    public ToJson<ModulePriv> queryModules(HttpServletRequest request) {

        ToJson<ModulePriv> json = new ToJson<ModulePriv>();

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        json.setObject(getModulePrivList(request));
        json.setFlag(0);
        json.setMsg("ok");
        return json;
    }


    private List<ModulePriv> getModulePrivList(HttpServletRequest request){
        //需求不存到表，写死在代码中，目前9个模块(去除8，管理简报模块),moduleId固定不要修改，兼容老数据
        List<ModulePriv> result = new ArrayList<ModulePriv>();
        result.add(new ModulePriv(1,"在线人员","可以看到所选范围的所有在线人员，为空则不限制"));
        result.add(new ModulePriv(2,"全部人员","可以看到所选范围的所有人员，为空则不限制"));
        result.add(new ModulePriv(3,"日程安排查询","可以看到所选范围内人员的日程安排，为空则只能看到自己管理范围内的比自己角色低的用户的日程安排"));
        result.add(new ModulePriv(4,"工作日志查询","可以看到所选范围内人员的工作日志，为空则只能看到自己管理范围内的比自己角色低的用户的工作日志"));
        result.add(new ModulePriv(5,"公告通知发布","可以向所选范围内的用户发布公告，为空则不限制"));
        result.add(new ModulePriv(6,"新闻发布","可以向所选范围内的用户发布新闻，为空则不限制"));
        result.add(new ModulePriv(7,"投票发布","可以统计所选范围内的用户的日志数量等工作情况"));
        result.add(new ModulePriv(9,"人事档案管理","可以管理所选范围内的用户的人事档案信息"));
        result.add(new ModulePriv(10,"人事档案查询","可以查询统计所选范围内的用户的人事档案信息"));
        result.add(new ModulePriv(11,"用户管理","可以管理所选范围内的用户的用户管理信息"));
        //result.add(new ModulePriv(12,"审计日志",""));ModuleId=12为审计日志
        return result;
    }


    /**
     * 根据uid和moduleid查询单个模块管理范围
     * @param modulePriv
     * @return
     */
    @Override
    public ToJson<ModulePriv> queryModulePrivSingle(HttpServletRequest request,ModulePriv modulePriv) {
        ToJson<ModulePriv> json = new ToJson<ModulePriv>();
        try {
            ModulePriv modulePrivByUid = modulePrivMapper.getModulePrivSingle(modulePriv);

            if(Objects.isNull(modulePrivByUid)){
                json.setFlag(0);
                return json;
            }

            //查询其他管理范围模块
            if (!Objects.isNull(modulePrivByUid)){
                List<ModulePriv> modulePrivList = getModulePrivList(request);
                List<ModulePriv> other = modulePrivList.stream().filter(m -> !modulePrivByUid.getModuleId().equals(m.getModuleId())).collect(Collectors.toList());
                modulePrivByUid.setOtherModulePrivs(other);
            }

            //根据id串查询指定部门名称、
            if(!StringUtils.checkNull(modulePrivByUid.getDeptId())){
                List<Department> departments = departmentMapper.selDeptByIds(modulePrivByUid.getDeptId().split(","));
                String deptNames = departments.stream().map(Department::getDeptName).collect(Collectors.joining(","));
                modulePrivByUid.setDeptName(deptNames);
            }
            //指定角色名称、
            if(!StringUtils.checkNull(modulePrivByUid.getPrivId())){
                List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(modulePrivByUid.getPrivId().split(","));
                String privNames = userPrivByIds.stream().map(UserPriv::getPrivName).collect(Collectors.joining(","));
                modulePrivByUid.setPrivName(privNames);
            }
            //指定人员名称
            if(!StringUtils.checkNull(modulePrivByUid.getUserId())){
                List<Users> usersByUserIds = usersMapper.getUsersByUserIds(modulePrivByUid.getUserId().split(","));
                String userNames = usersByUserIds.stream().map(Users::getUserName).collect(Collectors.joining(","));
                modulePrivByUid.setUserName(userNames);
            }

            json.setObject(modulePrivByUid);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 查询部门管理范围
     * @param users 用户信息
     * @param moduleId 模块id
     * @return 有权限的部门id
     */
    public String[] getModuleDeptIds(Users users,Integer moduleId){

        //moduleId不为空，根据模块id和用户uid查询用户是否设置了模块管理范围
        ModulePriv modulePriv = null;
        if(!Objects.isNull(users.getUid()) && !Objects.isNull(moduleId)) {
            ModulePriv module = new ModulePriv();
            module.setUid(users.getUid());
            module.setModuleId(moduleId);
            modulePriv = modulePrivMapper.getModulePrivSingle(module);

            //设置了模块管理范围将范围类型和指定部门set到总范围上方便后续判断
            if(!Objects.isNull(modulePriv)){
                users.setPostPriv(modulePriv.getDeptPriv());
                users.setPostDept(modulePriv.getDeptId());
            }
        }

        //设置了模块管理范围优先使用模块管理范围的设置(deptPriv  人员范围（无-空字符串、本部门-0、全体-1、指定部门-2、指定人员-3、本人-4）这个接口只考虑部门情况，所以指定人员和本人不判断)
        switch (users.getPostPriv()){
            case "0":
                //本部门
                Department deptById = departmentMapper.getDeptById(users.getDeptId());
                List<Department> deptList = departmentMapper.getBydeptNo(deptById.getDeptNo());
                return deptList.stream().map(Department::getDeptId).map(String::valueOf).collect(Collectors.joining(",")).split(",");
            case "1":
                //全体
                return null;
            case "2":
                //指定部门
                return users.getPostDept().split(",");
            default:
                return null;
        }
    }


    /**
     * 查询角色管理范围
     * @param users 用户信息
     * @param moduleId 模块id
     * @return 有权限的角色id
     *//*
    public String[] getModulePrivIds(Users users,Integer moduleId){

        //moduleId为空，不限制,可以选择所有角色
        if(Objects.isNull(moduleId)){
            return null;
        }

        ModulePriv module = new ModulePriv();
        module.setUid(users.getUid());
        module.setModuleId(moduleId);
        ModulePriv modulePriv = modulePrivMapper.getModulePrivSingle(module);

        //未查询到模块管理范围，不限制
        if(Objects.isNull(modulePriv)){
            return null;
        }

        //设置了模块管理范围，根据人员角色类型判断（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
        switch (modulePriv.getRolePriv()){
            case "0":
                //低角色的用户
                userPrivMapper.
                return deptList.stream().map(Department::getDeptId).map(String::valueOf).collect(Collectors.joining(",")).split(",");
            case "1":
                //同角色和低角色的用户
                return null;
            case "2":
                //所有角色的用户
                return users.getPostDept().split(",");
            case "3":
                //指定角色的用户
                return users.getPostDept().split(",");
            default:
                return null;
        }
    }*/


    /**
     * 查询部门管理范围
     * @param users 用户信息
     * @param moduleId 模块id
     * @return 有权限的部门id
     */
    public Map<String,Object> getModulePriv(Users users, String moduleId){

        Map<String,Object> result = new HashMap<>();
        if(Objects.isNull(users) || Objects.isNull(users.getUid()) || StringUtils.checkNull(moduleId)){
            return result;
        }

        //用户管理模块，系统管理员角色不限制管理范围
        if("11".equals(moduleId) && 1 == users.getUserPriv()){
            return result;
        }

        //根据模块id和用户uid查询用户是否设置了模块管理范围
        ModulePriv module = new ModulePriv();
        module.setUid(users.getUid());
        module.setModuleId(Integer.valueOf(moduleId));
        ModulePriv modulePriv = modulePrivMapper.getModulePrivSingle(module);

        //根据moduleId查询为空，说明没有加设置这个模块的管理范围，查询全局管理范围（moduleId=0）
        if(Objects.isNull(modulePriv)){
            module.setModuleId(0);
            modulePriv = modulePrivMapper.getModulePrivSingle(module);
        }

        //设置了模块管理范围将范围类型和指定部门set到总范围上方便后续判断
        if(!Objects.isNull(modulePriv)){
            users.setPostPriv(modulePriv.getDeptPriv());
            users.setPostDept(modulePriv.getDeptId());
        }

        //设置了模块管理范围优先使用模块管理范围的设置(deptPriv  人员范围（无-空字符串、本部门-0、全体-1、指定部门-2、指定人员-3、本人-4）)
        if(!StringUtils.checkNull(users.getPostPriv())) {
            switch (users.getPostPriv()) {
                case "0":
                    //本部门
                /*Department deptById = departmentMapper.getDeptById(users.getDeptId());
                result.put("moduleDeptNo",deptById.getDeptNo());*/

                    Department deptById = departmentMapper.getDeptById(users.getDeptId());
                    List<Department> deptList = departmentMapper.getBydeptNo(deptById.getDeptNo());
                    result.put("moduleDeptIds", deptList.stream().map(Department::getDeptId).map(String::valueOf).collect(Collectors.joining(",")).split(","));
                    break;
                case "1":
                    //全体
                    break;
                case "2":
                    //指定部门
                    result.put("moduleDeptIds", users.getPostDept().split(","));
                    break;
                case "3":
                    //指定人员
                    result.put("moduleUserIds", modulePriv.getUserId().split(","));
                    break;
                case "4":
                    //本人
                    result.put("moduleUserIds", users.getUserId().split(","));
                    break;
                default:
                    break;
            }
        }

        //设置了模块管理范围，根据人员角色类型判断（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
        if(!Objects.isNull(modulePriv)) {
            //人员角色范围（无-空字符串、低角色的用户-0、同角色和低角色的用户-1、所有角色的用户-2、指定角色的用户-3）
            UserPriv userPriv = userPrivMapper.getUserPriv(users.getUserPriv());
            switch (modulePriv.getRolePriv()) {
                case "0":
                    result.put("moduleRolePrivNo",userPriv.getPrivNo());
                    break;
                case "1":
                    result.put("moduleRolePrivNo",userPriv.getPrivNo() - 1);
                    break;
                case "3":
                    result.put("moduleRolePrivIds",modulePriv.getPrivId().split(","));
                    break;
                default:
                    break;
            }
        }
        return result;
    }
}
