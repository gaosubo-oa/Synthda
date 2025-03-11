package com.xoa.util.enterpriseWeChat;
/**
 * Created by 桂静文 on 2018/3/22.
 * 企业微信接口地址
 */
public class EnterpriseWeChatUrl {
    //获取信息
    public static String WECHAT_CONNECT_TEST = "https://qyapi.weixin.qq.com/cgi-bin/gettoken";
    public static String WECHAT_CODE_GETUSER = "https://qyapi.weixin.qq.com/cgi-bin/user/getuserinfo";
    public static String WECHAT_GET_PROVIDER = "https://qyapi.weixin.qq.com/cgi-bin/service/get_provider_token";

    //部门管理
    public static String WECHAT_DEPT_LIST = "https://qyapi.weixin.qq.com/cgi-bin/department/list";
    public static String WECHAT_CREATE_DEPT = "https://qyapi.weixin.qq.com/cgi-bin/department/create";
    public static String WECHAT_UPDATE_DEPT = "https://qyapi.weixin.qq.com/cgi-bin/department/update";
    public static String WECHAT_DELETE_DEPT = "https://qyapi.weixin.qq.com/cgi-bin/department/delete";

    //用户管理
    public static String WECHAT_USER_LIST = "https://qyapi.weixin.qq.com/cgi-bin/user/list";
    public static String WECHAT_USER_SIMPLE_LIST = "https://qyapi.weixin.qq.com/cgi-bin/user/simplelist";
    public static String WECHAT_CREATE_USER = "https://qyapi.weixin.qq.com/cgi-bin/user/create";
    public static String WECHAT_UPDATE_USER = "https://qyapi.weixin.qq.com/cgi-bin/user/update";
    public static String WECHAT_GET_USER = "https://qyapi.weixin.qq.com/cgi-bin/user/get";
    public static String WECHAT_GET_LOGIN_INFO = "https://qyapi.weixin.qq.com/cgi-bin/service/get_login_info";

    //微应用
    public static String WECHATQY_APP_XOA = "http://www.tongda3000.com";

    //上传附件
    public static String WECHAT_UPLOAD = "https://qyapi.weixin.qq.com/cgi-bin/media/upload";

    //微信推送服务
    public static String WECHAT_NOTICE_GET_TOKEN = "https://api.weixin.qq.com/cgi-bin/token";
    public static String WECHAT_NOTICE_SEND = "https://api.weixin.qq.com/cgi-bin/message/template/send";
    public static String WECHAT_GET_OPENID="https://api.weixin.qq.com/sns/oauth2/access_token";
}
