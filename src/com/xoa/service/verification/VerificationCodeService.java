package com.xoa.service.verification;


import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;

public interface VerificationCodeService {
    //短信接收验证码
    public ToJson smsNoCode(HttpServletRequest request, String Mobile,String byname);

    //修改OA用户登录密码
    public ToJson editPwd(HttpServletRequest request, String newPwd,String Mobile,String byname,String numberStr) ;

    //检查验证码是否一致
    public ToJson inspectCode (HttpServletRequest request, String numberStr,String Mobile,String byname) ;
}