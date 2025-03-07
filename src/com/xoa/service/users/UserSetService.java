package com.xoa.service.users;

import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

public interface UserSetService {

    /**
     * 保存用户设置
     * @param userId 用户ID（必填）
     * @param setItem 设置项（必填）
     * @param setValue 设置值
     * @return
     */
    ToJson saveUserSet(HttpServletRequest request, String userId, String setItem, String setValue);


    /**
     * 读取用户设置
     * @param request
     * @param userId  用户ID（必填）
     * @param setItem 设置项
     * @return
     */
    ToJson readUserSet(HttpServletRequest request, String userId, String setItem);
}
