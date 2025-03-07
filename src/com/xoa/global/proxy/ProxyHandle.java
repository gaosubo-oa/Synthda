package com.xoa.global.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

/**
 * Created by pfl on 2017/7/29.
 */
public class ProxyHandle implements InvocationHandler {

    private Object proxied;

    public ProxyHandle( Object proxied )
    {
        this.proxied = proxied;
    }
    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        return method.invoke(proxied,args);
    }
}
