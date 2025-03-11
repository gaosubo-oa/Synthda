package com.xoa.service.users;

import com.xoa.model.users.UserGroup;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;


/**
 * 创建作者:   牛江丽
 * 创建日期:   2017年7月4日 下午13:03:57
 * 类介绍  :    自定义用户组service层接口
 * 构造参数:   
 *
 */
public interface UserGroupService {
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月4日 下午13:05:00
	 * 方法介绍:  添加自定义用户组
	 * 参数说明:   @param userGroup
	 * 参数说明:   @return int 添加行数
	 */
	public  ToJson<UserGroup> insertUserGroup(UserGroup userGroup);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月4日 下午13:07:00
	 * 方法介绍:  根据groupId修改自定义用户组
	 * 参数说明:   @param groupId
	 * 参数说明:   @return int 修改行数
	 */
	public ToJson<UserGroup> updateUserGroup(UserGroup userGroup);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月4日 下午13:05:00
	 * 方法介绍:  查询所有自定义用户组
	 * 参数说明:   @return List<UserGroup>
	 */
	public ToJson<UserGroup> getAllUserGroup();

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月4日 下午13:10:00
	 * 方法介绍:  根据groupId删除自定义用户组信息
	 * 参数说明:   @param groupId
	 * 参数说明:   @return int 删除行数
	 */
	public ToJson<UserGroup> delUserGroupByGroupId(String groupId);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月7日 下午12:58:00
	 * 方法介绍:  根据groupId查询自定义用户组
	 * 参数说明:   @param groupId
	 * 参数说明:   @return UserGroup
	 */
	public ToJson<UserGroup> getUserGroupByGroupId(String groupId);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月7日 下午12:58:00
	 * 方法介绍:  根据groupId查询自定义用户组
	 * 参数说明:   @param groupId
	 * 参数说明:   @return UserGroup
	 */
	public ToJson<Users> getUsersByGroupId(String groupId,HttpServletRequest request);

	public ToJson<Users> getUsersByGroupIdBai(HttpServletRequest request,String groupId);


//用户自定义组
	public  ToJson<UserGroup> insertUserGroup1(UserGroup userGroup);
	public ToJson<UserGroup> getAllUserGroup1(HttpServletRequest request);
	public ToJson<Integer> delUserGroupByGroupIdAll(String groupId);


}




