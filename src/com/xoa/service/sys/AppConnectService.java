package com.xoa.service.sys;

import com.xoa.model.sys.Connect;
import com.xoa.model.sys.ConnectUser;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AppConnectService {

    ToJson<Connect> selectAllAppConnect(String page, String pageSize);

    ToJson<Connect> insertAllAppConnect(Connect connect);

    ToJson<Connect> updateAllAppConnect(Connect connect);

    ToJson<Connect> deleteAllAppConnect(Integer aid);

    ToJson<ConnectUser> selectAllAppUserConnect(String page, String pageSize);

    ToJson<ConnectUser> insertAllAppUserConnect(ConnectUser connectUser);

    ToJson<ConnectUser> updateAllAppUserConnect(ConnectUser connectUser);

    ToJson<ConnectUser> deleteAllAppUserConnect(String auid);

    ToJson<Object> AppConnectLogin(String app_id, String appName, String access_token, String redirect_uri, String user_id, HttpServletResponse response, HttpServletRequest request);

    ToJson<Object> AppConnectLogin2(String app_id, String appName, String access_token, String user_id, HttpServletResponse response, HttpServletRequest request, String user_md5);

    ToJson<Object> getAccessToken();

    ToJson<Object> getXunGeng(HttpServletRequest request, HttpServletResponse response);

}
