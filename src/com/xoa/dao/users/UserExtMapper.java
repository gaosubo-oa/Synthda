package com.xoa.dao.users;


import com.xoa.model.users.UserExt;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserExtMapper {

    String getUserFuncIdStr(String userId);

    void updateUserFuncIdStr(Map<String, String> hashMap);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月22
     * 方法介绍:   添加用户信息的其他选项信息
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     */
    void addUserExt(UserExt userExt);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月22
     * 方法介绍:   修改用户信息的其他选项信息
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     */
    int updateUserExtByUid(UserExt userExt);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年6月26
     * 方法介绍:   删除用户信息的其他选项信息
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     */
    void deleteUserExtByUids(String[] udis);

    UserExt queryUserExt(@Param("uid") Integer uid);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年7月4日
     * 方法介绍:   根据uids更新信息
     */
    void updateUserExtByUids(@Param("uids") List<String> uids, @Param("userExt") UserExt userExt);

    //更新计划管理运营驾驶舱自定义设置
    void updatePlanCockpitSet(UserExt userExt);

    //获取计划管理运营驾驶舱自定义设置
    UserExt getPlanCockpitSet(UserExt userExt);

    UserExt queryUserExtByByName(String byname);

    UserExt selUserExtByUserId(String userId);

    void updateUserExtByuidlogin(UserExt userExt);

    UserExt getDutyType(String pin);

    void updateEmploymentTypeByUid(UserExt userExt);

    List<UserExt> checkUser(Map map);

    void updateFlowFavorites(UserExt userExt);

    Integer selectFolderCapacityByUserId(String userId);

    Integer selectEmailCapacityByUserId(String userId);
}