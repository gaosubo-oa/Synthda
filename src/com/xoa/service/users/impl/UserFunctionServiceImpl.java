package com.xoa.service.users.impl;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.UserFunction;
import com.xoa.model.users.Users;
import com.xoa.service.users.UserFunctionService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class UserFunctionServiceImpl implements UserFunctionService {
    @Resource
    private UserFunctionMapper userFunctionMapper;
    @Resource
    private SysFunctionMapper sysFunctionMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UsersMapper usersMapper;

    @Resource
    private UserExtMapper userExtMapper;

    @Override
    public ToJson<SysFunction> getMenu(int uid) {
        ToJson<SysFunction> toJson = new ToJson<SysFunction>(0, "显示结果");
        String[] strArray = null;
        List<SysFunction> sFunList = sysFunctionMapper.getAll();
        UserFunction uFun = userFunctionMapper.getMenuByUserId(uid);
        strArray = uFun.getUserFunCidStr().split(",");
        List<SysFunction> list1 = new ArrayList<SysFunction>();
        for (int j = 0; j < strArray.length; j++) {
            for (int i = j; i < sFunList.size(); i++) {
                if (sFunList.get(i).getId().toString().equals(strArray[j])) {
                    list1.add(sFunList.get(i));
                    break;
                }
            }

        }
        toJson.setObj(list1);
        return toJson;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 16:50
     * @函数介绍: 根据function功能id查询有此功能的用户（名）
     * @参数说明: @param String fid
     * @return: List<Users></Users>
     */
    @Override
    public List<String> getUserNameByFuncId(String fid) {

        List<String> userNameList = null;
        List<Users> userByFuncId = usersMapper.getUserByFuncId(fid);
        if (userByFuncId != null && userByFuncId.size() > 0) {
            userNameList = userByFuncId.stream().map(Users::getUserName).collect(Collectors.toList());
        }
        return userNameList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 14:09
     * @函数介绍: 增加用户的某个菜单权限，user_ext, user_function两张表都要修改
     * @参数说明: String fid ,对应sys_function表的id
     * @参数说明: String uids , 对应user表的user_id，多个用逗号分隔
     * @return: void
     **/
    @Override
    public void updateAuthUser(String fid, String uids) {
        String[] uidArr = null;
        if (uids != null) {
            uidArr = uids.split(",");
        }

        if (uidArr != null && fid != null) {
            for (String userId : uidArr) {
                String userFuncIdStr = userExtMapper.getUserFuncIdStr(userId);
                if (userFuncIdStr != null && "".equals(userFuncIdStr)) {
                    userFuncIdStr = fid.concat(",");

                } else if (userFuncIdStr != null) {
                    if (!userFuncIdStr.contains(",".concat(fid).concat(",")) && !userFuncIdStr.contains("".concat(fid).concat(","))) {
                        userFuncIdStr = userFuncIdStr.concat(fid).concat(",");
                    }
                } else {
                    userFuncIdStr = "".concat(fid).concat(",");
                }


                if (userFuncIdStr != null) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("userId", userId);
                    map.put("userFuncIdStr", userFuncIdStr);
                    userExtMapper.updateUserFuncIdStr(map);

                }


            }
        }

        if (uidArr != null && fid != null) {
            for (String userId : uidArr) {
                String userFuncIdStr = userFunctionMapper.getUserFuncIdStr(userId);
                if (userFuncIdStr != null && "".equals(userFuncIdStr)) {
                    userFuncIdStr = fid.concat(",");

                } else if (userFuncIdStr != null) {
                    if (!userFuncIdStr.contains(",".concat(fid).concat(",")) && !userFuncIdStr.contains("".concat(fid).concat(","))) {
                        userFuncIdStr = userFuncIdStr.concat(fid).concat(",");
                    } else {
                        userFuncIdStr = userFuncIdStr.concat(fid).concat(",");
                    }
                }


                Map<String, String> map = new HashMap<String, String>();
                map.put("userId", userId);
                map.put("userFuncIdStr", userFuncIdStr);
                userFunctionMapper.updateUserFuncIdStr(map);

            }

        }
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 15:26
     * @函数介绍: 删除用户的某项菜单权限（对应user_ext和user_function表）
     * @参数说明: fid 某个某个功能的id, 对应sys_function的id
     * @参数说明: uids 用户的userId多个用逗号分隔。
     * @return: void
     **/
    @Override
    public void deleteAuthUser(String fid, String uids) {
        String[] uidArr = null;
        if (uids != null) {
            uidArr = uids.split(",");
        }

        if (uidArr != null && fid != null) {
            for (String userId : uidArr) {
                String userFuncIdStr = userFunctionMapper.getUserFuncIdStr(userId);
                if (userFuncIdStr != null && (userFuncIdStr.contains(",".concat(fid).concat(",")) || (userFuncIdStr.contains(fid.concat(","))))) {
                    userFuncIdStr = userFuncIdStr.replace(fid.concat(","), "");
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("userId", userId);
                    map.put("userFuncIdStr", userFuncIdStr);
                    userFunctionMapper.updateUserFuncIdStr(map);
                }
            }

            for (String userId : uidArr) {

                String userFuncIdStr = userExtMapper.getUserFuncIdStr(userId);
                if (userFuncIdStr != null && (userFuncIdStr.contains(",".concat(fid).concat(",")) || (userFuncIdStr.contains(fid.concat(","))))) {
                    Map<String, String> map = new HashMap<String, String>();
                    map.put("userId", userId);
                    //userFuncIdStr = userFuncIdStr.replace(fid.concat(","), "");
                    userFuncIdStr = userFuncIdStr.replace(",","");
                    map.put("userFuncIdStr", userFuncIdStr);
                    userExtMapper.updateUserFuncIdStr(map);
                }
            }
        }


    }

    @Override
    public UserFunction getMenuByUserId(int uid) {
        return userFunctionMapper.getMenuByUserId(uid);
    }

    /**
     * @param userId
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 12：45
     * @函数介绍: 查询用户权限
     * @参数说明: userID
     * @return: String 菜单id
     */
    @Override
    public String getUserFunctionStr(String userId) {

        return userFunctionMapper.getUserFuncIdStr(String.valueOf(userId));

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/22 10:08
     * @函数介绍: 根据用户id查询该用户权限
     * @参数说明: @param uid 用户id
     * @return: String
     */
    @Override
    public String getUserFunctionStrById(Integer uid) {
        if (uid != null) {
            UserFunction userFunction = userFunctionMapper.getMenuByUserId(uid);
            if (userFunction != null && userFunction.getUserFunCidStr() != null) {
                return userFunction.getUserFunCidStr();
            }
        }
        return "";
    }

    /**
     * 作者 廉立深
     * 日期 2020/10/13
     * 方法介绍  判断当前登录人是否包含某个菜单
     * 参数 [request]
     * 返回 java.lang.Boolean
     **/
    @Override
    public boolean checkPriv(HttpServletRequest request , String funcId){
        Cookie redisSessionCookie1 = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie1);
        int isUserFunction = userFunctionMapper.getIsUserFunction(users.getUserId(), funcId);
        if ( isUserFunction > 0 ){
            return true;
        }
        return false;
    }

}


    /*@Override
    public ToJson<Department> getDep() {
		ToJson<Department> toJson=new ToJson<Department>(0,"显示结果");
		List<Department> dep=departmentMapper.getDatagrid();
		toJson.setObj(dep);
		return toJson;
	}*/
    /*@Override
    public ToJson<Users> getUser(int uid) {
		ToJson<Users> toJson=new ToJson<Users>(0,"显示结果");
		List<Users> userList=departmentMapper.getUserAll(uid);
		toJson.setObj(userList);
		return toJson;
	}}*/
