package com.xoa.global.intercptor;

import com.xoa.util.common.L;
import com.xoa.util.redis.JedisUtil;
import com.xoa.util.redis.RedisHttpSession;
import com.xoa.util.redis.RedisSessionUtil;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.ResourceBundle;

/**
 * Created by 韩东堂on 2017/6/27.
 */
public class CommonSessionContext {
    private static CommonSessionContext instance;
    private HashMap mymap;
    private ResourceBundle rb = ResourceBundle.getBundle("redis");
    private boolean redisUse;
    private JedisUtil jedisUtil;
    private JedisUtil.Strings strings;

    private CommonSessionContext() {
        mymap = new HashMap();
        redisUse = Boolean.parseBoolean(rb.getString("redis.use"));
        jedisUtil = new JedisUtil();
        strings = jedisUtil.new Strings();
    }

    public static CommonSessionContext getInstance() {
        if (instance == null) {
            synchronized (CommonSessionContext.class){
                if(instance == null){
                    instance = new CommonSessionContext();
                }
            }
        }
        return instance;
    }

    public synchronized void AddSession(HttpSession session) {
        if (session != null) {
            mymap.put(session.getId(), session);
        }
    }

    public synchronized void DelSession(HttpSession session) {
        L.s("run remove session");
        if (session != null) {
            mymap.remove(session.getId());
        }
    }

    public synchronized HttpSession getSession(String session_id) {
        if (session_id == null)
            return null;
        if(redisUse){
            RedisHttpSession redisHttpSession = new RedisHttpSession();
            HashMap userSessionInfo = RedisSessionUtil.getUserSessionInfo(session_id, strings);
            if(userSessionInfo!=null){
                redisHttpSession.setId(session_id);
                redisHttpSession.setAttribute("loginDateSouse",userSessionInfo.get("loginDateSouse"));
                redisHttpSession.setAttribute("InterfaceModel",userSessionInfo.get("InterfaceModel"));
                return redisHttpSession;
            }else{
                return null;
            }
        }
        return (HttpSession) mymap.get(session_id);
    }
}
