package com.xoa.util.sso;


import java.nio.charset.Charset;
public class Constants {
    // CAS根地址
    static String CAS_BASE_PATH = "http://218.201.243.209:8085/cas/";

    // 业务系统需要显式使用的端口配置，包括80端口，如果不需要配置显式端口，则配置空字符串""即可
    static String CLIENT_SYSTEM_EXPLICIT_PORT = "";

    // CAS票据验证地址
    static String CAS_VALIDATE_URL = CAS_BASE_PATH + "serviceValidate";

    // CAS登录地址
    static String CAS_LOGIN_URL = CAS_BASE_PATH + "login";

    // CAS注销地址
    static String CAS_LOGOUT_URL = CAS_BASE_PATH + "logout";

    //登录成功默认跳转地址
    static String DEF_TARGET_URI = "BjyzSso/ssoLogin";

    // 业务系统认证集成改造之后的登录URI
    static String SSO_LOGIN_URI = "BjyzSso/ssoLogin";

    // REQUEST中获取需要跳转URL的KEY
    static String TARGET_URL_KEY = "targetUrl";

    // SESSION中判断是否登录的KEY
    static String LOGIN_KEY = "isSupwisdomCasLogin";
    static String LOGIN_USER_KEY = "supwisdomCasLoginUser";

    // REQUEST中获取票据的KEY
    static String TICKET_KEY = "ticket";

    // CAS Server验证成功后需跳转客户端Url的Key
    static String SERVICE_KEY = "service";

    // BASE64编码的前缀
    static String BASE64_PREFIX = "{base64}";

    // 默认编码字符串格式
    static String UTF_8_STR = "UTF-8";

    //默认编码
    static Charset UTF_8 = Charset.forName(UTF_8_STR);
}