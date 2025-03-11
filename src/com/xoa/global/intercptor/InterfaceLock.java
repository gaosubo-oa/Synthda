package com.xoa.global.intercptor;


import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface InterfaceLock {

    /**
      * 锁过期的时间（注解未设置默认2秒）
      * */
    int seconds() default 2;
    /**
      * 锁的位置
      * */
    String location() default "";
    /**
      * 要扫描的参数位置
      * */
    int argIndex() default 0;
    /**
     * 需要增加到唯一标识中的字段
     * */
    String keyParaName() default "";
    /**
      * 参数名称串，以英文逗号分隔，暂时没啥用
      *
    String paraName() default "";*/
    /**
     * 需要判断参数值的参数名称串(以英文逗号分隔,只支持参数值为字符串的参数)
     * */
    String filterParaName() default "";
    /**
     * 需要判断的参数值串，实际接口参数值不等于设置的参数值时，不锁接口，(以英文逗号分隔)
     * 个数需要和filterParaName个数一致，空字符串值为nullStr
     * */
    String filterParaValue() default "";
}
