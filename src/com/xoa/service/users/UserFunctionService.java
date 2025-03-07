package com.xoa.service.users;


import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.UserFunction;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserFunctionService {


    public ToJson<SysFunction> getMenu(int uid);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/1 16:50
     * @函数介绍: 根据function功能id查询有此功能的用户（名）
     * @参数说明: @param String fid
     * @return: List<UserFunction></UserFunction>
     **/
    List<String> getUserNameByFuncId(String fid);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 14:09
     * @函数介绍: 增加用户的某个菜单权限
     * @参数说明: String fid ,对应sys_function表的id
     * @参数说明: String uids , 对应user表的user_id，多个用逗号分隔
     * @return: void
     **/
    void updateAuthUser(String fid, String uids);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/2 15:26
     * @函数介绍: 删除用户的某项菜单权限（对应user_ext和user_function表）
     * @参数说明: fid 某个某个功能的id, 对应sys_function的id
     * @参数说明: uids 用户的userId多个用逗号分隔。
     * @return: void
     **/
    void deleteAuthUser(String fid, String uids);

	/*@DynDatasource
    public ToJson<Department> getDep();*/
	
	/*@DynDatasource
	public ToJson<Users> getUser(int uid);*/




	/**
	 * @创建作者: 高亚峰
	 * @创建日期: 2017/6/20 12：45
	 * @函数介绍: 根据UID查询对应的菜单数据
	 * @参数说明: uid  user对应的id
	 * @return: UserFunction对象
	 * */
	UserFunction getMenuByUserId(int uid);


    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 12：45
     * @函数介绍: 查询用户权限
     * @参数说明: userID
     * @return: String 菜单id
     * @param userId*/
    String getUserFunctionStr(String userId);

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/22 10:08
     * @函数介绍: 根据用户id查询该用户权限
     * @参数说明: @param uid 用户id
     * @return: String
     **/
    String getUserFunctionStrById(Integer uid);

    boolean checkPriv(HttpServletRequest request , String funcId);
}
