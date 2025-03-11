package com.xoa.global.commonAOP;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class SessionAttributeAOP {

    @Pointcut("execution(* javax.servlet.http.HttpSession.getAttribute(..))")
    public void getAttribute() {
    }


    @Before("getAttribute()")
    public void getAttributeBefore() {
        System.out.println("before getAttributeBefore");
    }

    @AfterReturning("getAttribute()")
    public void getAttributeAfterReturn() {
        System.out.println("after 12321321323213 getAttributeAfterReturn");
    }





}
