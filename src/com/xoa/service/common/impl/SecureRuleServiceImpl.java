package com.xoa.service.common.impl;

import com.xoa.dao.common.SecureLogMapper;
import com.xoa.dao.common.SecureRuleMapper;
import com.xoa.model.common.SecureLog;
import com.xoa.model.common.SecureRule;
import com.xoa.model.users.Users;
import com.xoa.service.common.SecureRuleService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.IpAddr;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.util.Date;
import java.util.List;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/12 10:03
 * 类介绍  :   三员安全管理
 * 构造参数:
 */
@Service
public class SecureRuleServiceImpl implements SecureRuleService {

   @Resource
   private SecureRuleMapper secureRuleMapper;
   @Resource
   private SecureLogMapper secureLogMapper;

    @Override
    public ToJson<SecureRule> getAllSecureRule() {
        ToJson<SecureRule> json =new ToJson<SecureRule>(1,"err");
        try {
            List<SecureRule> allSecureRule = secureRuleMapper.getAllSecureRule();
            //判断不为空
            if(allSecureRule!=null){
            for(SecureRule secureRule:allSecureRule){
                if(secureRule!=null && secureRule.getRulePriv()!=null){
                    //操作权限(1-系统管理员,2-安全员,3-审计员)
                    if(secureRule.getRulePriv()==1){
                     secureRule.setRulePrivName("系统管理员");
                    }
                    else if(secureRule.getRulePriv()==2){
                        secureRule.setRulePrivName("安全员");
                    }
                   else if(secureRule.getRulePriv()==3){
                        secureRule.setRulePrivName("审计员");
                    }
                    else{
                        secureRule.setRulePrivName("");
                    }
                }
            }
            }
            json.setObj(allSecureRule);
            json.setFlag(0);
            json.setMsg("ok");

        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> editSecureRule(HttpServletRequest request,SecureRule secureRule) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            int i = secureRuleMapper.updateByPrimaryKeySelective(secureRule);
            SecureLog secureLog =new SecureLog();
            if(secureRule.getRuleId()!=null){
                short i1 = secureRule.getRuleId().shortValue();
                secureLog.setRuleId(i1);
            }
            //从session中获取当前登录人的信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Integer uid = users.getUid();
            secureLog.setUid(uid);
            Date date =new Date();
            long time = date.getTime();
            int i1 = Math.abs((int)time);
            secureLog.setLogTime(i1);
            secureLog.setRemark("修改"+secureRule.getRuleDesc());
            secureLog.setIp(IpAddr.getIpAddress(request));
            int i2 = secureLogMapper.insertSelective(secureLog);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<SecureRule> getSecureById(String ruleId) {
        ToJson<SecureRule> json =new ToJson<SecureRule>(1,"err");
        try {
            if(ruleId!=null){
                SecureRule secureById = secureRuleMapper.getSecureById(Integer.valueOf(ruleId));
                if(secureById!=null){
                    json.setFlag(0);
                    json.setMsg("ok");
                    json.setObject(secureById);
                }else{
                    json.setFlag(0);
                    json.setMsg("ok");
                    json.setObject("");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<SecureRule>  getAllInfoSecureRule(){
        ToJson<SecureRule> json = new ToJson<SecureRule>(1,"err" );
        try{
            List<SecureRule> allInfoSecureRule = secureRuleMapper.getAllSecureRule();
            if(allInfoSecureRule!=null){
                for(SecureRule secureRule:allInfoSecureRule){
                    System.out.println(secureRule);
                }
            }
            json.setObj(allInfoSecureRule);
            json.setFlag(0);
            json.setMsg("ok");
        }catch(Exception e){
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }
}
