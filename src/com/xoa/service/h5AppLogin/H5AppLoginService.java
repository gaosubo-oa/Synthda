package com.xoa.service.h5AppLogin;

import com.alibaba.druid.util.StringUtils;
import com.xoa.controller.login.loginController;
import com.xoa.dao.dingdingManage.UserDDMapMapper;
import com.xoa.dao.enterpriseWeChat.EnterpriseWeChatMapper;
import com.xoa.dao.h5AppLogin.UserLxMapMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.dingdingManage.UserDDMap;
import com.xoa.model.enterpriseWeChat.EnterpriseWeChat;
import com.xoa.model.h5AppLogin.LanXinUser;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dingding.DingDingTool;
import com.xoa.util.dingding.DingDingUrl;
import com.xoa.util.enterpriseWeChat.EnterpriseWeChatUrl;
import com.xoa.util.h5App.H5AppTool;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by 张雨 on 2018/3/5.
 * 微应用单点登录
 */
@Service
public class H5AppLoginService {

//    private Logger logger = Logger.getLogger(H5AppLoginService.class);

    @Autowired
    UserDDMapMapper userDDMapMapper;

    @Autowired
    EnterpriseWeChatMapper enterpriseWeChatMapper;

    @Autowired
    UsersMapper usersMapper;

    @Autowired
    UserLxMapMapper userLxMapMapper;

    @Autowired
    loginController login;

    //钉钉微应用免登码获取用户身份
    public BaseWrapper dingdingLoginH5(HttpServletRequest request, HttpServletResponse response,
                                       String corpId, String corpSecret, String code, String oId) throws JSONException {
        BaseWrapper wrapper = new BaseWrapper();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);

        if(user.getUserId() == null) {
            String dingRequest = "?corpid=" + corpId + "&corpsecret=" + corpSecret;

            //获取access_token
            String result = DingDingTool.dingdingRequestGet(DingDingUrl.DINGDING_CONNECT_TEST, dingRequest);
            org.json.JSONObject jsonObject = new org.json.JSONObject(result);
            String access = jsonObject.getString("access_token");

            //获取用户id
            dingRequest = "?access_token=" + access + "&code=" + code;
            result = DingDingTool.dingdingRequestGet(DingDingUrl.DINGDING_CODE_GETUSER, dingRequest);
            jsonObject = new org.json.JSONObject(result);
            String userid = jsonObject.getString("userid");
            //获取该用户对应的OAId
            //这里oaId报空指针异常，做判断
            UserDDMap userDDMap = userDDMapMapper.getUserDDMapByUserId(userid);
            String oaId = "";
            if(userDDMap == null) {
                wrapper.setMsg("未绑定OA账号，无法登录！");
                return wrapper;
            }

            oaId =userDDMap.getOaUid();
            user = usersMapper.getUserByUid(Integer.parseInt(oaId));
            if(user != null) {
                try {
//                    ToJson<Users> toJson = login.loginEnter(user.getByname(), user.getPassword(), oId, "mobile", null, request, response);
                    ToJson<Users> toJson = login.loginEnter(user.getByname(), "", oId, "mobile", null, request, response, 1);
                    if(!toJson.isFlag()) {
                        wrapper.setMsg("登录失败！");
                        return wrapper;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    wrapper.setMsg(e.getMessage());
                }

                wrapper.setData(SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId));
                wrapper.setFlag(true);
                wrapper.setMsg("success!");
            } else {
                wrapper.setMsg("用户" + oaId + "不存在！");
            }
        } else {
            wrapper.setMsg("已有用户信息！");
            wrapper.setFlag(true);
        }
        return wrapper;
    }

    //蓝信单点登录
    public BaseWrapper lxloginh5api(HttpServletRequest request, HttpServletResponse response, String loginId) {
        BaseWrapper wrapper = new BaseWrapper();
        String OPENPLATFORM_URL = "https://api.lanxin.cn";
        if(null == loginId ||"".equals(loginId)) {
            loginId = "1001";
        }
        //获取corpId和corpSecret
        String code = request.getParameter("code");
        String appid = request.getParameter("appid");
//        logger.info("code:" + code + "appid:" + appid);
        String tokenUrl = OPENPLATFORM_URL + "/sns/oauth2/access_token?code=" + code + "" + "&appid=" + appid + "&grant_type=authorization_code";
        HttpServletResponse httpRes = (HttpServletResponse) response;

        JSONObject tokenJson = new JSONObject();

        try {
            String result = H5AppTool.h5AppRequestGet(tokenUrl, "");
            tokenJson = JSONObject.fromObject(result);
            String phonenum = tokenJson.getString("openid");
//            logger.info("tokenJson:" + tokenJson.toString());
            //根据access_token 获取用户信息
            String userInfoUrl = OPENPLATFORM_URL + "/sns/userinfo?access_token="+tokenJson.getString("access_token")+"&mobile="+phonenum;
            String result1  = H5AppTool.h5AppRequestGet(userInfoUrl, "");
            JSONObject userJson = JSONObject.fromObject(result1);
            //判断是否成功获取用户
            String errcode = userJson.getString("errcode");
            if(StringUtils.equals(errcode, "0")){
                JSONArray openOrgMemberList = userJson.getJSONArray("openOrgMemberList");
                JSONObject userInfo = openOrgMemberList.getJSONObject(0);
                LanXinUser lxUser = (LanXinUser) JSONObject.toBean(userInfo, LanXinUser.class);
                //根据蓝信id查询用户
                Users user = usersMapper.getUserByUid(Integer.parseInt(lxUser.getId()));
                if(user != null) {
                    ToJson<Users> toJson = login.loginEnter(user.getByname(), "", loginId, "mobile", null, request, response, 1);
//                    try {
//                        toJson = login.loginEnter("admin", "", "1001", "mobile", "zh_CN", request, response, 1);
//                    } catch (Exception e) {
//                        e.printStackTrace();
//                    }
                    if(toJson.isFlag()) {
                        wrapper.setData(lxUser);
                        wrapper.setMsg("登录成功！");
                        wrapper.setFlag(true);
                    } else {
                        wrapper.setMsg(toJson.getMsg());
                    }
                } else {
                    wrapper.setMsg("OA中不存在该用户！");
                }
            }else{
                httpRes.sendRedirect("错误处理");
//                logger.info("session 获取失败");
            }

        } catch (Exception e) {
//            httpRes.sendRedirect((new StringBuilder()).append(ConfigData.LOCAL_URL).append("/apps/error/error.html").toString());
            e.printStackTrace();
            wrapper.setMsg(e.getMessage());
            wrapper.setData(tokenJson);
        }
        return wrapper;
    }

}
