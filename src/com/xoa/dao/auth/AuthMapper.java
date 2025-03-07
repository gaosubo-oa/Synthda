package com.xoa.dao.auth;

import java.util.List;

/**
 * Created by 韩东堂 on 2017/6/7.
 */
public interface AuthMapper {
    List<String>  getDeptName(String deptIds);
    List<String>  getRoleName(String roleIds);
    List<String>  getUserName(String userIds);
}
