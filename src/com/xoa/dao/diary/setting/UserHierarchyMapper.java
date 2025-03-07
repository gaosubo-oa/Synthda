package com.xoa.dao.diary.setting;

import com.xoa.model.diary.setting.UserHierarchy;

import java.util.List;
import java.util.Map;

public interface UserHierarchyMapper {

	UserHierarchy selectUserHierarchyByUserId(String userId);

    int updateUserHierarchyById(UserHierarchy userHierarchy1);

    int addUserHierarchy(UserHierarchy userHierarchy);

    int updateUserHierarchyByUserId(UserHierarchy userHierarchy2);

    UserHierarchy selectUserHierarchyById(Integer id);

    int deleteUserHierarchyById(Integer id);

    List<UserHierarchy> selectAllUserHierarchy(Map<String, Object> map);
}