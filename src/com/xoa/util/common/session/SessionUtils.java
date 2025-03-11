package com.xoa.util.common.session;

import com.xoa.model.users.Users;
import com.xoa.util.common.StringUtils;
import com.xoa.util.redis.JedisUtil;
import com.xoa.util.redis.RedisSessionUtil;
import com.xoa.util.redis.SerializeUtil;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;
import java.util.Map.Entry;

/**
 *
 * @作者 韩东堂
 * @创建日期 2017-4-27 上午11:19:22
 * @类介绍 session工具类
 * @构造参数 无
 *
 */
public class SessionUtils {

	private static ResourceBundle rb = ResourceBundle.getBundle("redis");
	private static boolean redisUse;
	private static JedisUtil jedisUtil;
	private static JedisUtil.Strings strings;

	static {
		redisUse = Boolean.parseBoolean(rb.getString("redis.use"));
		jedisUtil = new JedisUtil();
		strings = jedisUtil.new Strings();
	}
	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午1:09:33
	 * @方法介绍 session 配置类 Map型
	 * @参数说明 @param session
	 * @参数说明 @param params
	 * @return
	 */
	public static void putSession(HttpSession session,
								  Map<String, Object> params,Cookie redisIdCookie) {
		if(redisUse){
			String sessionId = session.getId();
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				sessionId = redisIdCookie.getValue();
			}

			HashMap<Object,Object> userSessionInfo = RedisSessionUtil.getUserSessionInfo(sessionId, strings);
			for (Entry<String, Object> entry : params.entrySet()) {
				userSessionInfo.put(entry.getKey(), entry.getValue());
			}
			RedisSessionUtil.setUserSessionInfo(sessionId,strings,userSessionInfo);
			HashMap<Object,Object> usertest = RedisSessionUtil.getUserSessionInfo(sessionId, strings);


		}else{
			if (session == null)
				throw new SessionException("session is null");
			if (params == null || params.size() == 0)
				return;
			for (Entry<String, Object> entry : params.entrySet()) {
				session.setAttribute(entry.getKey(), entry.getValue());
			}
		}
	}

	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午1:10:19
	 * @方法介绍 session 配置类 Model型
	 * @参数说明 @param session
	 * @参数说明 @param obj
	 * @return
	 */
	public static void putSession(HttpSession session, Object obj,Cookie redisIdCookie) {
		if (redisUse){
			String sessionId = null;
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				sessionId = redisIdCookie.getValue();
			}
			if(obj instanceof Users){
				RedisSessionUtil.initUserSession(sessionId,strings,(Users)obj);
			}else{
				HashMap userSessionInfo = (HashMap) SerializeUtil.unserialize(strings.get(SerializeUtil.serialize(sessionId)));
				try {
					Field[] fields = Class.forName(obj.getClass().getName())
							.getDeclaredFields();
					for (int i = 0; i < fields.length; i++) {
						fields[i].setAccessible(true);
						if( fields[i].get(obj)!= null){
							userSessionInfo.put(fields[i].getName(),fields[i].get(obj) );
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					throw new SessionException("session is null");
				}
				strings.set(SerializeUtil.serialize(sessionId),SerializeUtil.serialize(userSessionInfo));
			}






//			HashMap usersMap = (HashMap) SerializeUtil.unserialize(strings.get(id));
//			HashMap<Object,Object> userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
//			try {
//				Field[] fields = Class.forName(obj.getClass().getName())
//						.getDeclaredFields();
//				for (int i = 0; i < fields.length; i++) {
//					fields[i].setAccessible(true);
//					userSessionInfo.put(fields[i].getName(), fields[i].get(obj));
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//				throw new SessionException("session is null");
//			}
//			HashMap<Object,Object> usersMap = RedisSessionUtil.setUserSessionInfo(id, strings, userSessionInfo);
//			strings.set(SerializeUtil.serialize("usersMap"),SerializeUtil.serialize(usersMap));
		}else{
			if (session == null)
				throw new SessionException("session is null");
			if (obj == null)
				return;
			try {
				Field[] fields = Class.forName(obj.getClass().getName())
						.getDeclaredFields();
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					session.setAttribute(fields[i].getName(), fields[i].get(obj));
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				throw new SessionException("session is null");
			}
		}
	}

	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午1:12:47
	 * @方法介绍 session 配置类 单个型
	 * @参数说明 @param session
	 * @参数说明 @param key
	 * @参数说明 @param value
	 * @return
	 */
	public static void putSession(HttpSession session, String key, Object value,Cookie redisIdCookie) {
//		long startTime = System.currentTimeMillis();
		if(redisUse){
			String sessionId = session.getId();
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				sessionId = redisIdCookie.getValue();
			}
			if (session == null)
				throw new SessionException("session is null");

			HashMap userSessionInfo = RedisSessionUtil.getUserSessionInfo(sessionId,strings);
			if(Objects.isNull(userSessionInfo)){
				RedisSessionUtil.initObjectSession(sessionId,strings,value,key);
			}else {
				userSessionInfo.put(key, value);
				HashMap<Object,Object> hashMap = RedisSessionUtil.setUserSessionInfo(sessionId, strings, userSessionInfo);
				strings.set(SerializeUtil.serialize("usersMap"),SerializeUtil.serialize(hashMap));
			}

//			HashMap<Object,Object> userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
//			userSessionInfo.put(key,value);
//			HashMap<Object,Object> hashMap = RedisSessionUtil.setUserSessionInfo(id, strings, userSessionInfo);
//			strings.set(SerializeUtil.serialize("usersMap"),SerializeUtil.serialize(hashMap));
		}else {
			if (session == null)
				throw new SessionException("session is null");
			if (StringUtils.checkNull(key))
				throw new SessionException("key is null");
			session.setAttribute(key, value);
		}
		if("InterfaceModel".equals(key)){
			session.setAttribute(key, value);
		}
//		long endTime = System.currentTimeMillis();
//		System.out.println("程序运行时间：" + (endTime - startTime) + "ms");    //输出程序运行时间
	}


	/**
	 * 根据单个键值，返回对于的session值
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午3:05:00
	 * @方法介绍
	 * @参数说明 @param session
	 * @参数说明 @param key
	 * @参数说明 @param clazz
	 * @参数说明 @return
	 * @return
	 */
	public static <T> T getSessionInfo(HttpSession session,String key, Class<T> clazz,Cookie redisIdCookie){
		T ret = null;
		if(redisUse){
			String id = null;
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				id = redisIdCookie.getValue();
			}
			if(id != null){
				HashMap userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
				if(!Objects.isNull(userSessionInfo)) {
					Object value = userSessionInfo.get(key);
					if (value != null)
						ret = clazz.cast(value);
				}
			}

		}else{
			Object value=session.getAttribute(key);
			if(value!=null) ret=clazz.cast(value);
		}
		return ret;
	}

	public static <T> T getSessionInfo(HttpSession session,String key, Class<T> clazz){
		T ret = null;
		Object value=session.getAttribute(key);
		if(value!=null) ret=clazz.cast(value);
		return ret;
	}

	public static Map<String, Object> getAllSessionInfoBykey(HttpSession session,Cookie redisIdCookie) {
		String sessionId = session.getId();

		if(redisUse){
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				sessionId = redisIdCookie.getValue();
			}

			Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(sessionId, strings);
			if(userSessionInfo.size() >0){
				return userSessionInfo;
			}
		}else{
			Map<String, Object> map = new HashMap<String, Object>();
			Enumeration enumeration =session.getAttributeNames();//获取session中所有的键值对
			while(enumeration.hasMoreElements()){
				String AddFileName = enumeration.nextElement().toString();//获取session中的键值
				Object value  = session.getAttribute(AddFileName);//根据键值取出session中的值
				map.put(AddFileName,value);

			}
			return map;
		}

		return null;
	}

	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午2:55:28
	 * @方法介绍 根据set数组获取
	 * @参数说明 @param session
	 * @参数说明 @param keys
	 * @参数说明 @return
	 * @return
	 */
	public static Map<String, Object> getSessionInfo(HttpSession session,
													 Set<String> keys,Cookie redisIdCookie) {
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator<String> iterator = keys.iterator();
		if(redisUse){
			String id = session.getId();
			if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				id = redisIdCookie.getValue();
			}
			Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
			while (iterator.hasNext()) {
				String key = iterator.next();
				Object value = userSessionInfo.get(key);
				if(value!=null) map.put(key, value);
			}
		}else{
			while (iterator.hasNext()) {
				String key = iterator.next();
				Object value = session.getAttribute(key);
				if(value!=null) map.put(key, value);
			}
		}
		return map;
	}

	public static <T> T getSessionInfo(HttpSession session, Class<T> clazz,
									   T deffault) {
		T ret = null;
		if (deffault == null)
			return null;
		try {
			Field[] fields = Class.forName(clazz.getName()).getDeclaredFields();
			ret = clazz.cast(deffault);//转换当前类型或其子类下的对象
			if(redisUse){
				Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(session.getId(), strings);
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = userSessionInfo.get(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}else {
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = session.getAttribute(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			//throw new SessionException("session is null");
		}
		return ret;
	}
	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午2:44:18
	 * @方法介绍 根据所给类型返回对于的包装类
	 * @参数说明 @param session
	 * @参数说明 @param clazz
	 * @参数说明 @param deffault
	 * @example getSessionInfo(session,Users.class,new Users);
	 * @参数说明 @return
	 * @return
	 */
	public static <T> T getSessionInfo(HttpSession session, Class<T> clazz,
									   T deffault,Cookie redisIdCookie) {
		T ret = null;
		if (deffault == null)
			return null;
		try {
			Field[] fields = Class.forName(clazz.getName()).getDeclaredFields();
			ret = clazz.cast(deffault);//转换当前类型或其子类下的对象
			if(redisUse){
				String id = session.getId();
				if(redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
					id = redisIdCookie.getValue();
				}
				Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = userSessionInfo.get(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}else {
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = session.getAttribute(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new SessionException("session is null");
		}
		return ret;
	}

	public  static  void cleanUserSession(HttpSession session,Cookie redisIdCookie){
		if(redisUse){
			String sessionId = session.getId();
			if(StringUtils.checkNull(sessionId)&&redisIdCookie!=null&&!StringUtils.checkNull(redisIdCookie.getValue())){
				sessionId = redisIdCookie.getValue();
			}
			if(strings.get(SerializeUtil.serialize(sessionId)) != null){
				strings.sdel(SerializeUtil.serialize(sessionId));
				//RedisSessionUtil.setUserSessionInfo(sessionId,strings,new HashMap());
			}

		}else{
			if(session==null){
				throw new SessionException("session is null");
			}
			//List<String>  stringList= (List<String>) session.getAttributeNames();
			Enumeration<String> enumeration=session.getAttributeNames();
			// 遍历enumeration中的
			while (enumeration.hasMoreElements()) {
				// 获取session键值
				session.removeAttribute(enumeration.nextElement().toString());
			}
		}
	}

	// --------------------------------------------------注释开始---------------------------------------------------------------- //
	// --------------------------------------------------注释开始---------------------------------------------------------------- //
	// --------------------------------------------------注释开始---------------------------------------------------------------- //
	/**
	 * 根据单个键值，返回对于的session值
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午3:05:00
	 * @方法介绍
	 * @参数说明 @param session
	 * @参数说明 @param key
	 * @参数说明 @param clazz
	 * @参数说明 @return
	 * @return
	 *//*
	public static <T> T getSessionInfo(HttpSession session,String key, Class<T> clazz){
		T ret = null;
		if(redisUse&&!"LOCALE_SESSION_ATTRIBUTE_NAME".equals(key)&&!"loginDateSouse".equals(key)){
			String id = session.getId();
			HashMap userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
			Object value = userSessionInfo.get(key);
			if(value!=null)
				ret = clazz.cast(value);
		}else{
			Object value=session.getAttribute(key);
			if(value!=null) ret=clazz.cast(value);
		}
		return ret;
	}



	*//**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午2:55:28
	 * @方法介绍 根据set数组获取
	 * @参数说明 @param session
	 * @参数说明 @param keys
	 * @参数说明 @return
	 * @return
	 *//*
	public static Map<String, Object> getSessionInfo(HttpSession session,
													 Set<String> keys) {
		Map<String, Object> map = new HashMap<String, Object>();
		Iterator<String> iterator = keys.iterator();
		if(redisUse){
			String id = session.getId();
			Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
			while (iterator.hasNext()) {
				String key = iterator.next();
				Object value = userSessionInfo.get(key);
				if(value!=null) map.put(key, value);
			}
		}else{
			while (iterator.hasNext()) {
				String key = iterator.next();
				Object value = session.getAttribute(key);
				if(value!=null) map.put(key, value);
			}
		}
		return map;
	}

	*//**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-27 下午2:44:18
	 * @方法介绍 根据所给类型返回对于的包装类
	 * @参数说明 @param session
	 * @参数说明 @param clazz
	 * @参数说明 @param deffault
	 * @example getSessionInfo(session,Users.class,new Users);
	 * @参数说明 @return
	 * @return
	 *//*
	public static <T> T getSessionInfo(HttpSession session, Class<T> clazz,
									   T deffault) {
		T ret = null;
		if (deffault == null)
			return null;
		try {
			Field[] fields = Class.forName(clazz.getName()).getDeclaredFields();
			ret = clazz.cast(deffault);//转换当前类型或其子类下的对象
			if(redisUse){
				String id = session.getId();
				Map userSessionInfo = RedisSessionUtil.getUserSessionInfo(id, strings);
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = userSessionInfo.get(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}else {
				for (int i = 0; i < fields.length; i++) {
					fields[i].setAccessible(true);
					Method set_Method = clazz.getMethod("set"
									+ getMethodName(fields[i].getName()),
							fields[i].getType());
					set_Method.setAccessible(true);
					Object value = session.getAttribute(fields[i].getName());
					if (value != null) {
						set_Method.invoke(ret, value);
					}
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw new SessionException("session is null");
		}
		return ret;
	}

	public  static  void cleanUserSession(HttpSession session){
		if(redisUse){
			String id = session.getId();
			RedisSessionUtil.setUserSessionInfo(id,strings,new HashMap());
		}else{
			if(session==null){
				throw new SessionException("session is null");
			}
			//List<String>  stringList= (List<String>) session.getAttributeNames();
			Enumeration<String> enumeration=session.getAttributeNames();
			// 遍历enumeration中的
			while (enumeration.hasMoreElements()) {
				// 获取session键值
				session.removeAttribute(enumeration.nextElement().toString());
			}
		}
	}

	// --------------------------------------------------注释结束---------------------------------------------------------------- //
	// --------------------------------------------------注释结束---------------------------------------------------------------- //
	// --------------------------------------------------注释结束---------------------------------------------------------------- //
*/
	// 把一个字符串的第一个字母大写
	public static String getMethodName(String fildeName) {
		if(!StringUtils.checkNull(fildeName)){
			char[] chars = fildeName.toCharArray();
			if (chars.length>0){
				String c = String.valueOf(chars[0]).toUpperCase();
				fildeName = c+fildeName.substring(1);
			}
		}
		return fildeName;
	}

}
