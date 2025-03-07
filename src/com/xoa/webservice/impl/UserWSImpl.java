package com.xoa.webservice.impl;

import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.users.UsersService;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.edu.ConstantsInfo;
import com.xoa.util.edu.WrapperUtil;
import com.xoa.webservice.UserWS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Service
public class UserWSImpl implements UserWS {

    @Autowired
    private UsersService usersService;

    @Autowired
    DepartmentService departmentService;

    @Override
    public BaseWrapper insert(String orgId, Users user, UserExt userExt) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(user == null || orgId.isEmpty()){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        Users userByName = usersService.findUserByName(user.getByname(), null);
        if(userByName != null){
            return update(orgId,user,userExt);
        }
        ModulePriv modulePriv = null;
        try{
            List<Department> deptList = departmentService.getDepByCode(user.getDeptId().toString());
            if(deptList.size() > 0){
                int deptid =  deptList.get(0).getDeptId();
                user.setDeptId(deptid);

                if (!StringUtils.checkNull(user.getDeptId().toString()) || !StringUtils.checkNull(user.getUserId())) {
                    modulePriv = new ModulePriv();
                    modulePriv.setDeptId(user.getDeptId().toString());
                    if(user.getUserPriv() != null){
                        modulePriv.setPrivId("1");//管理员角色
                    }else {
                        modulePriv.setPrivId("101");//教师角色
                    }
                    modulePriv.setUserId(user.getUserId());
                }
                HttpServletRequest ss = null;
                String userid = user.getUserId();
                if(user.getUserPriv() != null){
                    user.setUserPriv(1);//管理员角色
                }else {
                    user.setUserPriv(101);//教师角色
                }
                user.setTheme(0);
                ToJson<Users> userJson =  usersService.addUser(user, userExt, modulePriv, ss);

                if(userJson.isFlag()){
                    Users u = (Users) userJson.getObject();
                    u.setUserId(userid);
                    usersService.editUser(ss,u, userExt, modulePriv);
                    WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.ADD_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
                    return baseWrapper;
                }
            }

            WrapperUtil.setError(baseWrapper, ConstantsInfo.ADD_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }catch (Exception e){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.ADD_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }

    }

    @Override
    public BaseWrapper delete(String orgId, String userid) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(userid.isEmpty() || orgId.isEmpty()){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        try {
            HttpServletRequest ss = null;
            String uid ;
            List<Users> u = usersService.getUserByuserId(userid);
            if(u.size() > 0){
                uid = u.get(0).getUid().toString();
                usersService.deleteUser(uid,ss);
            }

            WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.DELETE_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
            return baseWrapper;
        } catch (Exception e) {
            WrapperUtil.setError(baseWrapper, ConstantsInfo.DELETE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
    }

    @Override
    public BaseWrapper update(String orgId, Users user, UserExt userExt) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if(user == null || userExt == null || orgId.isEmpty()){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.REQUEST_DATA_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }
        if(!orgId.isEmpty()){
            ContextHolder.setConsumerType("xoa"+orgId);
        }
        Users userByName = usersService.findUserByName(user.getByname(), null);
        if(userByName == null){
            return insert(orgId,user,userExt);
        }
        ModulePriv modulePriv = null;
        HttpServletRequest ss = null;
        try{
            List<Department> deptList = departmentService.getDepByCode(user.getDeptId().toString());
            if(deptList.size() > 0) {
                if(!StringUtils.checkNull(user.getDeptIdOther())){
                    String[] strings = user.getDeptIdOther().split(",");
                    if(strings.length > 0) {
                        String deptOther = "";
                        for (String str : strings) {
                            List<Department> list = departmentService.getDepByCode(str);
                            deptOther += list.get(0).getDeptId()+",";
                        }
                        user.setDeptIdOther(deptOther);
                    }
                }
                int deptid = deptList.get(0).getDeptId();
                user.setDeptId(deptid);
                //判断用户信息
                List<Users> u = usersService.getUserByuserId(user.getUserId());
                if(u.size() > 0) {
                    user.setUid(u.get(0).getUid());
                }
//                if (!StringUtils.checkNull(user.getDeptId().toString()) || !StringUtils.checkNull(user.getUserId())) {
//                    modulePriv = new ModulePriv();
//                    modulePriv.setDeptId(user.getDeptId().toString());
//                    if(user.getUserPriv() != null) {
//                        modulePriv.setPrivId("1");
//                    }else {
//                        modulePriv.setPrivId("101");
//                    }
//                    modulePriv.setUserId(user.getUserId());
//                }
//                if(user.getUserPriv() != null){
//                    user.setUserPriv(1);//管理员角色
//                }else {
//                    user.setUserPriv(101);//教师角色
//                }
           /* Cookie redisSessionCookie = CookiesUtil.getCookieByName(ss, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(ss.getSession(), Users.class, new Users(),redisSessionCookie);*/
                user.setUserPriv(userByName.getUserPriv());
                usersService.editUser(ss,user, userExt, modulePriv);
                WrapperUtil.setSuccess(baseWrapper, ConstantsInfo.UPDATE_SUCCESS_MSG, ConstantsInfo.REQUEST_SUCCESS_CODE,null);
                return baseWrapper;
            }

            WrapperUtil.setError(baseWrapper, ConstantsInfo.UPDATE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }catch (Exception E){
            WrapperUtil.setError(baseWrapper, ConstantsInfo.UPDATE_ERROR_MSG, ConstantsInfo.REQUEST_ERROR_CODE);
            return baseWrapper;
        }


    }

}