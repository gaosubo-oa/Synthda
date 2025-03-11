package com.xoa.util.dingding;

/**
 * Created by 张雨 on 2018/2/7.
 * 钉钉接口地址
 */
public class DingDingUrl {

    //获取信息
    public static String DINGDING_CONNECT_TEST = "https://oapi.dingtalk.com/gettoken";
    public static String DINGDING_CODE_GETUSER = "https://oapi.dingtalk.com/user/getuserinfo";

    //部门管理
    public static String DINGDING_DEPT_LIST = "https://oapi.dingtalk.com/department/list";
    public static String DINGDING_CREATE_DEPT = "https://oapi.dingtalk.com/department/create";
    public static String DINGDING_UPDATE_DEPT = "https://oapi.dingtalk.com/department/update";
    public static String DINGDING_DELETE_DEPT = "https://oapi.dingtalk.com/department/delete";

    //用户管理
    public static String DINGDING_USER_LIST = "https://oapi.dingtalk.com/user/list";
    public static String DINGDING_USER_SIMPLE_LIST = "https://oapi.dingtalk.com/user/simplelist";
    public static String DINGDING_CREATE_USER = "https://oapi.dingtalk.com/user/create";
    public static String DINGDING_UPDATE_USER = "https://oapi.dingtalk.com/user/update";
    public static String DINGDING_GET_USER = "https://oapi.dingtalk.com/user/get";

    //微应用
    public static String DINGDINGQY_APP_XOA = "http://www.tongda3000.com";
}
