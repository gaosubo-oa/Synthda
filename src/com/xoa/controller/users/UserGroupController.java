package com.xoa.controller.users;

import com.xoa.model.users.UserGroup;
import com.xoa.model.users.Users;
import com.xoa.service.users.UserGroupService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

/**
 * 创建作者:   牛江丽
 * 创建日期:   2017年7月4日 下午13:36:02
 * 类介绍  :    自定义用户组
 * 构造参数:   无
 */
@Controller
@RequestMapping(value="/usergroup")
public class UserGroupController {


    @Resource
    UserGroupService userGroupService;

    @RequestMapping("/userGroup")
    public String  userGroup(){
        return  "app/department/userGroup";
    }

    @RequestMapping("/addUserGroup")
    public String  addUserGroup(){
        return  "app/department/addUserGroup";
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  添加自定义用户组
     * 参数说明:   @param userGroup
     * 参数说明:   @return int 添加行数
     */
    @ResponseBody
    @RequestMapping(value = "/insertUserGroup")
    public ToJson<UserGroup> insertUserGroup(UserGroup userGroup,HttpServletRequest request){
        if(userGroup!=null){
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            userGroup.setUserId(user.getUserId());
        }
        return userGroupService.insertUserGroup(userGroup);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:07:00
     * 方法介绍:  根据groupId修改自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return int 修改行数
     */
    @ResponseBody
    @RequestMapping(value = "/updateUserGroup")
    public ToJson<UserGroup> updateUserGroup(UserGroup userGroup){
        return userGroupService.updateUserGroup(userGroup);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  查询所有自定义用户组
     * 参数说明:   @return List<UserGroup>
     */
    @ResponseBody
    @RequestMapping(value = "/getAllUserGroup")
    public ToJson<UserGroup> getAllUserGroup(){
        return userGroupService.getAllUserGroup();
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:10:00
     * 方法介绍:  根据groupId删除自定义用户组信息
     * 参数说明:   @param groupId
     * 参数说明:   @return int 删除行数
     */
    @ResponseBody
    @RequestMapping(value = "/delUserGroupByGroupId")
    public ToJson<UserGroup> delUserGroupByGroupId(String groupId){
        return userGroupService.delUserGroupByGroupId(groupId);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月7日 下午12:58:00
     * 方法介绍:  根据groupId查询自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return UserGroup
     */
    @ResponseBody
    @RequestMapping(value = "/getUserGroupByGroupId")
    public ToJson<UserGroup> getUserGroupByGroupId(String groupId){
        return userGroupService.getUserGroupByGroupId(groupId);
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017年7月13日 下午14:46:00
     * 方法介绍:   根据组查人
     * 参数说明:   @return List<Users>
     */
    @ResponseBody
    @RequestMapping(value = "/getUsersByGroupId")
    public ToJson<Users> getUsersByGroupId(String groupId,HttpServletRequest request){
        return userGroupService.getUsersByGroupId(groupId,request);
    }


    //用户自定义组
    @ResponseBody
    @RequestMapping(value = "/insertUserGroup1")
    public ToJson<UserGroup> insertUserGroup1(UserGroup userGroup,HttpServletRequest request){
        if(userGroup!=null){
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            userGroup.setUserId(user.getUserId());
        }
        return userGroupService.insertUserGroup1(userGroup);
    }

    @ResponseBody
    @RequestMapping(value = "/getAllUserGroup1")
    public ToJson<UserGroup> getAllUserGroup1(HttpServletRequest request){
        return userGroupService.getAllUserGroup1(request);
    }

    @ResponseBody
    @RequestMapping(value = "/delUserGroupByGroupIdAll")
    public ToJson<Integer> delUserGroupByGroupIdAll(String groupId){
        return userGroupService.delUserGroupByGroupIdAll(groupId);
    }


}
