package com.xoa.global.commonAOP;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class TestAOP {

    @Pointcut("execution(* com.xoa.controller.work.WorkController.nextwork(..))")
    public void nextwork() {
    }


    @Before("nextwork()")
    public void nextworkBefore() {
        System.out.println("before nextworkBefore");
    }

    @AfterReturning("nextwork()")
    public void nextworkAfterReturn() {
        System.out.println("after 12321321323213 nextworkAfterReturn");
    }





}
