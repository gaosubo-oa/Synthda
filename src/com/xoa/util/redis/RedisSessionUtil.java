package com.xoa.util.redis;

import com.xoa.model.users.Users;
import com.xoa.util.common.session.SessionException;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2018/5/31.
 */
public class RedisSessionUtil {

    public static HashMap getUserSessionInfo(String sessionId, JedisUtil.Strings strings) {
        if (sessionId == null) {
            throw new SessionException("session is null");
        }
        byte[] usermapByte = strings.get(SerializeUtil.serialize(sessionId));
        if (usermapByte != null) {
            strings.setEx(SerializeUtil.serialize(sessionId),1800, usermapByte);
            HashMap usersMap = (HashMap) SerializeUtil.unserialize(usermapByte);
            return usersMap;
        }


        return null;
    }

    public static HashMap setUserSessionInfo(String sessionId, JedisUtil.Strings strings, Map userSessionInfo) {
        if (sessionId == null) {
            throw new SessionException("session is null");
        }

        HashMap usersMap = (HashMap) SerializeUtil.unserialize(strings.get(SerializeUtil.serialize(sessionId)));
        if (usersMap != null) {
            strings.setEx(SerializeUtil.serialize(sessionId),1800, SerializeUtil.serialize(userSessionInfo));

        }
        return usersMap;
    }


    public static void initUserSession(String sessionId, JedisUtil.Strings strings, Users user) {
        if (sessionId == null)
            return;

        try {
            if (strings.get(SerializeUtil.serialize(sessionId)) == null) {
                HashMap userSessionInfo = new HashMap();
                Field[] fields = Class.forName(user.getClass().getName()).getDeclaredFields();
                for (int i = 0; i < fields.length; i++) {
                    fields[i].setAccessible(true);
                    if( fields[i].get(user)!= null){
                        userSessionInfo.put(fields[i].getName(),fields[i].get(user) );
                    }
                }
                strings.setEx(SerializeUtil.serialize(sessionId),1800, SerializeUtil.serialize(userSessionInfo));
            } else {
                HashMap userSessionInfo = (HashMap) SerializeUtil.unserialize(strings.get(SerializeUtil.serialize(sessionId)));
                Field[] fields = Class.forName(user.getClass().getName()).getDeclaredFields();
                for (int i = 0; i < fields.length; i++) {
                    fields[i].setAccessible(true);
                    if( fields[i].get(user)!= null){
                        userSessionInfo.put(fields[i].getName(),fields[i].get(user) );
                    }
                }
                strings.setEx(SerializeUtil.serialize(sessionId),1800, SerializeUtil.serialize(userSessionInfo));
            }
        }catch (Exception e){
            e.printStackTrace();
            throw new SessionException("session is null");
        }
    }


    public static void initObjectSession(String sessionId, JedisUtil.Strings strings, Object value, String key) {
        if (sessionId == null)
            return;

        byte[] bytes = strings.get(SerializeUtil.serialize(sessionId));
        if (bytes == null) {
            HashMap userSessionInfo = new HashMap();
            userSessionInfo.put(key, value);
            strings.setEx(SerializeUtil.serialize(sessionId),1800, SerializeUtil.serialize(userSessionInfo));
        } else {
            HashMap userSessionInfo = (HashMap) SerializeUtil.unserialize(bytes);
            userSessionInfo.put(key, value);
            strings.setEx(SerializeUtil.serialize(sessionId),1800, SerializeUtil.serialize(userSessionInfo));
        }

    }

}
