package com.xoa.util.common;

import com.alibaba.fastjson.JSONArray;

/**
 * 
 * @作者 韩东堂
 * @创建日期 2017-4-24 上午11:27:48 
 * @类介绍 测试日志类
 * @构造参数  单例内部处理
 *
 */
public class L extends LoggerBase {
	private volatile static L lloader;
	private  long  startTime=System.currentTimeMillis();//开始时间
	public static L getInstance() {
		if (lloader == null) {
			synchronized (L.class) {
				if (lloader == null) {
					lloader = new L();
				}
			}
		}
		return lloader;
	}
	/**
	 * 
	 * @作者 韩东堂
	 * @创建日期 2017-4-24 上午11:33:30 
	 * @方法介绍 打印警告信息
	 * @参数说明 @param msgs 自己输入的记录信息
	 * @return 无
	 */
	public static void w(Object... msgs) {
		// TODO Auto-generated method stub
		// super.log.info(arg0);
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_WARN);
		lloader.log.warn(lloader.subString(msgs));
	}
	/**
	 *
	 * @作者 韩东堂
	 * @创建日期 2017-4-24 上午11:33:30
	 * @方法介绍 打印警告信息
	 * @参数说明 @param msgs 自己输入的记录信息
	 * @return 无
	 */
	public static void d(Object... msgs) {
		// TODO Auto-generated method stub
		// super.log.info(arg0);
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_WARN);
		lloader.log.debug(lloader.subString(msgs));
	}
    /**
     * 
     * @作者 韩东堂
     * @创建日期 2017-4-24 上午11:34:59 
     * @方法介绍 打印异常信息
     * @参数说明 @param msgs 自己输入的记录信息
     * @return
     */
	public static void e(Object... msgs) {
		// TODO Auto-generated method stub
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_ERROR);
		lloader.log.error(lloader.subString(msgs));
	}

	/**
	 * 
	 * @作者 韩东堂
	 * @创建日期 2017-4-24 上午11:34:19 
	 * @方法介绍 打印普通信息
	 * @参数说明 @param msgs 自己输入的记录信息
	 * @return 无
	 */
	public static void a(Object... msgs) {
		// TODO Auto-generated method stub
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_INFO);
		lloader.log.info(lloader.subString(msgs));
	}

    /**
     * 
     * @作者 韩东堂
     * @创建日期 2017-4-24 上午11:35:28 
     * @方法介绍  打印普通信息
     * @参数说明 @param msgs 自己输入的记录信息
     * @return 无
     */
	public static void i(Object... msgs) {
		// TODO Auto-generated method stub
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_INFO);
		lloader.log.info(lloader.subString(msgs));
	}

	public static void s(Object... msgs){
		L	lloader =L.getInstance();
		lloader.loadLogger(LOG_TYPE_INFO);
		lloader.log.info(lloader.subSysUrl(msgs));
	}


	public String subSysUrl(Object... msgs){
		StringBuffer sbBuffer = new StringBuffer("system log :");
		for (Object msg : msgs) {
			sbBuffer.append(JSONArray.toJSON(msg) + "\n ");
		}
		return sbBuffer.toString();
	}


	/**
	 * 
	 * @作者 韩东堂
	 * @创建日期 2017-4-24 上午11:36:04 
	 * @方法介绍  内部字符串处理
	 * @参数说明 @param msgs  信息
	 * @参数说明 @return String 拼接过的信息
	 * @return
	 */
	private  String subString(Object... obj) {
		
	
		
		StringBuffer sbBuffer = new StringBuffer(
				"------------日志信息开始-------------");
		sbBuffer.append("\r\n");
		sbBuffer.append("file:" + getFileName());
		sbBuffer.append("\r\n");
		sbBuffer.append("class:  at " + getClassName() + "(" + getClassName().substring(getClassName().lastIndexOf(".") + 1, getClassName().length()) + ".java:1)");
		sbBuffer.append("\r\n");
		sbBuffer.append("method:" + getMethodName());
		sbBuffer.append("\r\n");
		sbBuffer.append("line:  at " + getLinNumber()+" "+getClassName()+"(" + getClassName().substring(getClassName().lastIndexOf(".") + 1, getClassName().length()) + ".java:"+getLinNumber()+")");
		sbBuffer.append("\r\n");
		sbBuffer.append("your write info is:");
		sbBuffer.append("\r\n");
		for (Object msg : obj) {
				sbBuffer.append(JSONArray.toJSON(msg) + " ");
		}
		sbBuffer.append("\n [执行：");
		long endTime = System.currentTimeMillis();
		sbBuffer.append(endTime-startTime);
		sbBuffer.append("\tms] \n");
		sbBuffer.append("------------日志信息结束-------------");
		return sbBuffer.toString();
	}
 
}
