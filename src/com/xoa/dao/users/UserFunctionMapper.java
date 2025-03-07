package com.xoa.dao.users;

import com.xoa.model.users.UserFunction;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserFunctionMapper {
	
	public List<UserFunction> getDatagrid();
	
	public UserFunction  getMenuByUserId(int uid);

    List<UserFunction> getUserByFuncId(String fid);

    String getUserFuncIdStr(String userId);

    void updateUserFuncIdStr(Map<String, String> hashMap);

    void insertUserFun(UserFunction userFunction);

    void deleteUserFun(String[] uids);

    void updateUserFun(UserFunction userFunction);

    /**
     * 创建作者:   张航宁
     * 创建日期:   2017年月4日
     * 方法介绍:   批量修改用户权限信息
     */
    void updateUserFunByUids(@Param(value = "uids")List<String> uids, @Param(value = "userFunction") UserFunction userFunction);

    int addByUserId(@Param("uid")int uid,@Param("userId")String userId, @Param("userFunCidStr") String userFunCidStr);

    int updateByUserId(@Param("userId")String userId, @Param("userFunCidStr") String userFunCidStr);


    String getUid(@Param("userId")String userId);
    //判断用户是否包含某个菜单
    int getIsUserFunction(@Param("userId") String userId,@Param("userFuncIdStr")String userFuncIdStr);

    UserFunction selectByUid(int uid);

    int updateByUid(@Param("uid")Integer uid, @Param("userFunCidStr") String userFunCidStr);

}
