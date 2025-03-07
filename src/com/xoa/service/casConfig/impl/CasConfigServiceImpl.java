package com.xoa.service.casConfig.impl;

import com.xoa.dao.casConfig.CasConfigMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.casConfig.CasConfig;
import com.xoa.model.users.Users;
import com.xoa.service.casConfig.CasConfigService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Service
public class CasConfigServiceImpl implements CasConfigService {

    @Autowired
    private CasConfigMapper casConfigMapper;
    @Autowired
    private UsersMapper usersMapper;

    /**
    * @创建作者:李然  Lr
    * @方法描述：保存cas配置
    * @创建时间：14:01 2019/6/20
    **/
    @Override
    public ToJson save(HttpServletRequest request, CasConfig casConfig) {
        ToJson toJson=new ToJson(1,"err");
        if(casConfig!=null){
            Cookie redisSessionCookie1 = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie1);
            if(users!=null){
                CasConfig casConfigDb=casConfigMapper.selectOneCas();
                casConfig.setCasTime(new Date());
                casConfig.setCasUser(users.getUserId());
                Integer result=null;
                if(casConfigDb==null){
                    //代表此时数据库中还没有cas配置，需要新建
                    casConfig.setCasStatus("0");
                    result=casConfigMapper.insert(casConfig);
                }else{
                    //代表数据库中已经有了一条cas配置，需要修改
                    casConfig.setCasId(casConfigDb.getCasId());
                    result=casConfigMapper.updateByPrimaryKeySelective(casConfig);
                }
                if(result>0){
                    toJson.setMsg("保存成功");
                    toJson.setFlag(0);
                }
            }else{
                toJson.setMsg("登录用户失效");
            }
        }
        return toJson;
    }

    /**
    * @创建作者:李然  Lr
    * @方法描述：回显cas数据
    * @创建时间：16:23 2019/6/20
    **/
    @Override
    public ToJson showCas(HttpServletRequest request) {
        ToJson toJson=new ToJson(1,"err");
        CasConfig casConfig=casConfigMapper.selectOneCas();
        if(casConfig!=null){
            casConfig.setCasUser(usersMapper.getUsernameByUserId(casConfig.getCasUser()));
            casConfig.setCasTimeStr(DateFormat.getStrDate(casConfig.getCasTime()));
            toJson.setObject(casConfig);
            toJson.setFlag(0);
        }
        return toJson;
    }
}
