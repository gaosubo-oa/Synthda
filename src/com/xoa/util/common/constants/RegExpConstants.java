package com.xoa.util.common.constants;
/**
 * 
 * 创建作者:   杨 胜
 * 创建日期:   2017-6-12 上午11:39:12
 * 类介绍  :    正则表达式常量
 * 构造参数:   
 *
 */
public class RegExpConstants {
	  /**多次使用的话不需要重新编译正则表达式了，对于频繁调用能提高效率*/
     public static final String verifyHtml="\\&[a-zA-Z]{1,10};";
     public static final String verifyHtml2="<[^>]*>";
     public static final String verifyFormat="\\s*|\t|\r|\n";
}
