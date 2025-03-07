package com.xoa.global.intercptor;


import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.redis.JedisUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Aspect
@Component
public class InterfaceLockAspect {

    private static ResourceBundle rb = ResourceBundle.getBundle("redis");
    private static boolean redisUse;
    private static JedisUtil jedisUtil;
    private static JedisUtil.Strings strings;

    static {
        redisUse = Boolean.parseBoolean(rb.getString("redis.use"));
        jedisUtil = new JedisUtil();
        strings = jedisUtil.new Strings();
    }

    private static final Cache<String, String> interfaceLockCache = CacheBuilder.newBuilder()
            //最大缓存1000个
            .maximumSize(1000)
            //设置2秒后过期
            .expireAfterWrite(2, TimeUnit.SECONDS)
            .build();

    /**
     * 切入点
     */
    @Pointcut("@annotation(com.xoa.global.intercptor.InterfaceLock)")
    public void pt() {
    }

    @Around("pt()")
    public Object around(ProceedingJoinPoint joinPoint) throws Throwable {

        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        assert attributes != null;
        HttpServletRequest request = attributes.getRequest();

        //获取方法上的注解
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method method = methodSignature.getMethod();
        InterfaceLock interfaceLock = method.getAnnotation(InterfaceLock.class);

        //根据接口上的注解的参数名称来获取参数值
        Object[] args = joinPoint.getArgs();
        String[] parameterNames = methodSignature.getParameterNames();

        //需要增加到唯一标识中的字段
        Object keyParaName = null;

        //需要判断是否为空的参数名称
        boolean executeFlag = true;
        Map<String,String> filterParaMap = new HashMap<>();
        String[] filterParaNames = interfaceLock.filterParaName().split(",");
        String[] filterParaValues = interfaceLock.filterParaValue().split(",");
        if(filterParaNames.length > 0 && filterParaNames.length == filterParaValues.length){
            for (int i = 0; i < filterParaNames.length; i++) {
                filterParaMap.put(filterParaNames[i], "nullStr".equals(filterParaValues[i]) ? "" : filterParaValues[i]);
            }
        }
        for (int i = 0; i < parameterNames.length; i++) {

            //判断实际参数值是否等于设置的参数值,有一个不等于的就不执行后续的锁
            if(filterParaMap.containsKey(parameterNames[i]) && !filterParaMap.get(parameterNames[i]).equals(args[i])){
                executeFlag = false;
            }

            if(interfaceLock.keyParaName().equals(parameterNames[i])){
                keyParaName = args[i];
            }
        }

        if(executeFlag) {

            //获取当前用户
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            //唯一标识，使用 用户userId+注解上需要增加到唯一标识中的字段+请求地址
            StringBuffer bufferKey = new StringBuffer();
            if (!Objects.isNull(user)) {
                bufferKey.append(user.getUserId() + "-");
            }
            if (!Objects.isNull(keyParaName)) {
                bufferKey.append(user.getUserId() + "-");
            }
            bufferKey.append(request.getServletPath());
            String key = bufferKey.toString();

            // 如果缓存中有这个唯一标识key视为重复提交
            if (redisUse) {

                //开启了redis，就使用redis缓存，判断redis中是否存在当前key
                if (!StringUtils.checkNull(strings.get(key))) {
                    //TODO 改造为根据接口返回类型来定义返回结果
                    //Class<?> returnType = method.getReturnType();
                    ToJson toJson = new ToJson();
                    toJson.setMsg("请勿重复提交或者操作过于频繁！");
                    return toJson;
                }

                //不存在则缓存当前key并设置过期时间2秒
                strings.setEx(key, interfaceLock.seconds(), "LOCK");
            } else {

                //单机环境，就使用本地缓存
                if (!StringUtils.checkNull(interfaceLockCache.getIfPresent(key))) {
                    ToJson toJson = new ToJson();
                    toJson.setMsg("请勿重复提交或者操作过于频繁！");
                    return toJson;
                }

                //不存在则加入到本地缓存
                interfaceLockCache.put(key, "LOCK");
            }
        }
        return joinPoint.proceed();
    }

}
