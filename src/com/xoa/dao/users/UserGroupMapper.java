package com.xoa.dao.users;

import com.xoa.model.users.UserGroup;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserGroupMapper {
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  添加自定义用户组
     * 参数说明:   @param userGroup
     * 参数说明:   @return int 添加行数
     */
    int insertUserGroup(UserGroup userGroup);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:07:00
     * 方法介绍:  根据groupId修改自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return int 修改行数
     */
    int updateUserGroup(UserGroup userGroup);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:05:00
     * 方法介绍:  查询所有自定义用户组
     * 参数说明:   @return List<UserGroup>
     */
    List<UserGroup> getAllUserGroup(@Param("limits") String limits,@Param("userId") String userId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午13:10:00
     * 方法介绍:  根据groupId删除自定义用户组信息
     * 参数说明:   @param groupId
     * 参数说明:   @return int 删除行数
     */
    int delUserGroupByGroupId(String groupId);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月7日 下午12:58:00
     * 方法介绍:  根据groupId查询自定义用户组
     * 参数说明:   @param groupId
     * 参数说明:   @return UserGroup
     */
    UserGroup getUserGroupByGroupId(String groupId);

    int deleteUserGroupAll(@Param("groupId") String[] groupId);


}