package com.xoa.util;

public class LoginState {
    public static final  String LOGINLOCKERR = "100040 ";//登录失败，您的账号已被系统锁定，请1分钟后重试（错误代码：100040）
    public static final  String LOGINPASSWORDERR = "100010 ";//用户名或密码错误（错误代码：100010）
    public static final  String LOGINERR = "100030";//登录失败，用户权限表数据缺失（错误代码：100030）
    public static final  String LOGINSESSIONERR = "403 ";//认证信息已过期，请重新登录（错误代码：403）
    public static final  String LOGINOUTERR = "100050 ";//登录失败，用户禁止登录（错误代码：100050）
    public static final  String LOGINUSERNAMEERR = "1050 ";//用户名或用户不存在
    public static final  String LOGINTIMEOUT = "100035";//登录失败，用户软件试用版已过期（错误代码：100035）
    public static final  String LOGINTIME = "100060";//允许登陆OA用户达到上限，请联系管理员！（错误代码：100060）

}
