package com.xoa.service.users.impl;

import com.xoa.dao.users.UserGroupMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.users.UserGroup;
import com.xoa.model.users.Users;
import com.xoa.service.IMUser.IMUsersService;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.users.UserGroupService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017年7月4日 下午13:22:17
 * 类介绍  :    自定义用户组
 * 构造参数:    无
 */
@Service
public class UserGroupServiceImpl implements UserGroupService {
    @Resource
    private UserGroupMapper userGroupMapper;

    @Resource
    private UsersService usersService;
    @Autowired
    private IMUsersService imUsersService;
    @Resource
    private UsersMapper usersMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private UserPrivMapper userPrivMapper;
    @Resource
    private ModulePrivService modulePrivService;
    @Resource
    private SecurityApprovalService securityApprovalService;

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  添加自定义用户组
     * 参数说明:   @param userGroup
     * 参数说明:   @return int 添加行数
     */
    @Transactional
    @Override
    public  ToJson<UserGroup> insertUserGroup(UserGroup userGroup){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        int count=0;
        try{
            if(userGroup!=null){
                userGroup.setUserStr("");
                userGroup.setLimits("0");
               count= userGroupMapper.insertUserGroup(userGroup);
            }
            if(count!=0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl insertUserGroup:"+e);
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:07:00
     * 方法介绍:  根据groupId修改自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return int 修改行数
     */
    @Transactional
    @Override
    public ToJson<UserGroup> updateUserGroup(UserGroup userGroup){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        int count=0;
        try{
            if(userGroup!=null){
                count= userGroupMapper.updateUserGroup(userGroup);
            }
            if(count!=0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl updateUserGroup:"+e);
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  查询所有自定义用户组
     * 参数说明:   @return List<UserGroup>
     */
    @Override
    public  ToJson<UserGroup> getAllUserGroup(){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        int count=0;
        try{
            String limits = "0";
                json.setMsg("ok");
                List<UserGroup> userGroupList=userGroupMapper.getAllUserGroup(limits,null);
                if(userGroupList!=null&&userGroupList.size()>0){
                    json.setObj(userGroupList);
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl getAllUserGroup:"+e);
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:10:00
     * 方法介绍:  根据groupId删除自定义用户组信息
     * 参数说明:   @param groupId
     * 参数说明:   @return int 删除行数
     */
    @Transactional
    @Override
    public ToJson<UserGroup> delUserGroupByGroupId(String  groupId){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        int count=0;
        try{
            if(!StringUtils.checkNull(groupId)){
                count= userGroupMapper.delUserGroupByGroupId(groupId);
            }
            if(count!=0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl delUserGroupByGroupId:"+e);
        }
        return  json;
    }

    @Override
    public ToJson<Users> getUsersByGroupId(String groupId,HttpServletRequest request) {
        ToJson<Users> json =new ToJson<Users>(1,"err");
        List<String> userIds = new ArrayList<>();
        boolean isNull=true;
        if ( request.getAttribute("allUserId")!=null&&request.getAttribute("isNull")!=null){
            userIds = (List<String>) request.getAttribute("allUserId");
            isNull= (boolean) request.getAttribute("isNull");
        }
        try {
            UserGroup userGroupByGroupId = userGroupMapper.getUserGroupByGroupId(groupId);
            List<Users> users =new ArrayList<Users>();
            if(userGroupByGroupId!=null){
                if(!StringUtils.checkNull(userGroupByGroupId.getUserStr())){
                    String[] split = userGroupByGroupId.getUserStr().split(",");
                    List<String> list = new ArrayList(Arrays.asList(split));
                    if (userIds.size()>0){
                        list .retainAll(userIds);
                    }else if (userIds.size()==0&&!isNull){
//                    判断用户所在部门是否在受限部门范围内，不在就返回空
                        json.setObj(users);
                        return json;
                    }
                    if (list.size()>0&&userIds.size()>0&&!isNull){
                        users = usersMapper.getUsersByUserIdsOrder(list.toArray(new String[list.size()]));
                    }
//                    流程限制部门与个人所属部门无交集不显示个人分组
                    else if (list.size()==0&&userIds.size()>0&&!isNull){
                        users = new ArrayList<Users>();
                    }
//                    流程限制部门为空则显示出所有个人分组
                    else if (list.size()>0&&isNull){
                        users = usersMapper.getUsersByUserIdsOrder(list.toArray(new String[list.size()]));
                    }
                    else {
                        users = usersService.getUserByuserId(userGroupByGroupId.getUserStr());
                    }
                }
            }
            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(users);
        }catch (Exception e){
           json.setFlag(1);
           json.setMsg(e.getMessage());
           e.printStackTrace();
        }
        return  json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月7日 下午12:58:00
     * 方法介绍:  根据groupId查询自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return UserGroup
     */
    public ToJson<UserGroup> getUserGroupByGroupId(String groupId){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        UserGroup userGroup=new UserGroup();
        try{
            if(!StringUtils.checkNull(groupId)){
                userGroup=userGroupMapper.getUserGroupByGroupId(groupId);
                StringBuffer userNameStr=new StringBuffer();
                if(userGroup!=null){
                    if(!StringUtils.checkNull(userGroup.getUserStr())){
                        List<Users> usersList=usersService.getUserByuserId(userGroup.getUserStr());
                            for(Users users:usersList){
                                if(users!=null){
                                    if(!StringUtils.checkNull(users.getUserName())){
                                        userNameStr.append(users.getUserName()+",");
                                    }
                                }
                            }
                        userGroup.setUserName(userNameStr.toString());
                    }
                }
                json.setObject(userGroup);
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl getUserGroupByGroupId:"+e);
        }
        return  json;
    }
    @Override
    public ToJson<Users> getUsersByGroupIdBai(HttpServletRequest request,String groupId) {
        ToJson<Users> json =new ToJson<Users>(1,"err");
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            String moduleId = request.getParameter("moduleId");
            Map<String, Object> map = modulePrivService.getModulePriv(user, moduleId);

            map.put("privIds", user.getUserPriv());
            map.put("userIds",user.getUserId());
            map.put("deptIdss",user.getDeptId());
            map.put("jobId",request.getParameter("jobId")); //岗位
            map.put("postId",request.getParameter("postId")); //职务

            List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(user, true, true);
            int[] deptIds = new int[departmentByClassifyOrg.size()];
            for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                deptIds[i] = departmentByClassifyOrg.get(i).getDeptId();
            }
            map.put("deptIds", deptIds);
            UserGroup userGroupByGroupId = userGroupMapper.getUserGroupByGroupId(groupId);
            List<Users> users =new ArrayList<Users>();
            StringBuffer usersStr=new StringBuffer();
            if(userGroupByGroupId!=null){
                if(!StringUtils.checkNull(userGroupByGroupId.getUserStr())){
                    String[] temp = userGroupByGroupId.getUserStr().split(",");
                    for(int i = 0;i<temp.length;i++) {
                        if (!"".equals(temp[i].trim())) {
                            Users users1 = usersMapper.getUsersByuserId(temp[i]);
                            if (users1 != null) {
                                usersStr.append(users1.getUserId()).append(",");
                            }
                        }
                    }
                    map.put("userIds",usersStr.toString());
                    users = imUsersService.getUserByuserIdBai(map);
                    for (Users u:users){
                        String userPrivOtherName = "";
                        StringBuffer sb =new StringBuffer();//返回辅助部门
                        if (!StringUtils.checkNull(u.getUserPrivOther())){
                            String[] split1 = u.getUserPrivOther().split(",");
                            if(split1.length>3){
                                for (int j=0;j<3;j++){
                                    String s1 = split1[j];
                                    sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                }
                                userPrivOtherName = sb.toString();
                                if(",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                                userPrivOtherName+="……";
                            }else{
                                for (String s1:split1){
                                    sb.append(userPrivMapper.getPrivNameByPrivId(Integer.parseInt(s1))+",");
                                }
                                userPrivOtherName = sb.toString();
                                if(",".equals(userPrivOtherName.substring(userPrivOtherName.length()-1,userPrivOtherName.length()))){
                                    userPrivOtherName = userPrivOtherName.substring(0,userPrivOtherName.length()-1);
                                }
                            }
                        }
                        u.setUserPrivOtherName(userPrivOtherName);
                    }
                }
            }
            //返回结果中去除三员角色的用户和系统超级管理员、与内容密级不符的用户
            securityApprovalService.removeSecrecyUsers(users,null);

            json.setMsg("ok");
            json.setFlag(0);
            json.setObject(users);
        }catch (Exception e){
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return  json;
    }



    //添加用户自定义组
    @Transactional
    @Override
    public  ToJson<UserGroup> insertUserGroup1(UserGroup userGroup){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        int count=0;
        try{
            if(userGroup!=null){
                userGroup.setUserStr("");
                userGroup.setLimits("1");
                count= userGroupMapper.insertUserGroup(userGroup);
            }
            if(count!=0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            e.printStackTrace();
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl insertUserGroup:"+e);
        }
        return  json;
    }

    @Override
    public  ToJson<UserGroup> getAllUserGroup1(HttpServletRequest request){
        ToJson<UserGroup> json = new ToJson<UserGroup>(1, "error");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users sessionUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userId = sessionUser.getUserId();
        try{
            String limits = "1";
            StringBuffer usersStr=new StringBuffer();
            List<UserGroup> userGroupList=userGroupMapper.getAllUserGroup(limits,userId);
            if(userGroupList!=null&&userGroupList.size()>0){
                for (UserGroup ue:userGroupList) {
                    String userIds = ue.getUserStr();
                    String[] temp = userIds.split(",");
                        for (int i = 0; i < temp.length; i++) {
                           if(!"".equals(temp[i].trim())) {
                                Users users = usersMapper.getUsersByuserId(temp[i]);
                                if (users != null) {
                                    usersStr.append(users.getUserId()).append(",");
                                }
                            }
                        }
                    String userNames = usersService.getUserNameById(usersStr.toString());
                    ue.setUserName(userNames);
                }


                json.setObj(userGroupList);
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl getAllUserGroup:"+e);
        }
        return  json;
    }

    @Transactional
    @Override
    public ToJson<Integer> delUserGroupByGroupIdAll(String  groupId){
        ToJson<Integer> json = new ToJson<Integer>(1, "error");
        int count=0;
        try{
            if(!StringUtils.checkNull(groupId)){
                String[] split = groupId.split(",");
                count= userGroupMapper.deleteUserGroupAll(split);
            }
            if(count!=0){
                json.setMsg("ok");
                json.setFlag(0);
            }
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("UserGroupServiceImpl delUserGroupByGroupId:"+e);
        }
        return  json;
    }
}


