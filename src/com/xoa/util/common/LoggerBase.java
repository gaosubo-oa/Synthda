package com.xoa.util.common;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * 
 * @作者 韩东堂
 * @创建日期 2017-4-24 上午11:37:27 
 * @类介绍 日志信息基类用于扩展
 * @构造参数 无
 *
 */
public abstract class LoggerBase {
	
   public final static int LOG_TYPE_WARN=0x11;	//类型标识
   public final static int LOG_TYPE_ERROR=0x12;	//类型标识
   public final static int LOG_TYPE_INFO=0x13;	//类型标识
//   public static int LOG_TYPE_WARN=0x11;	
   protected Logger log = LogManager.getLogger();
   protected String className;  //信息收集类名
   protected String methodName; //信息收集方法名
   protected String fileName; //信息收集文件名
   protected Integer linNumber; //信息收集记录行数
   
    /**\
     * 
     * @作者 韩东堂
     * @创建日期 2017-4-24 上午11:39:17 
     * @方法介绍  初始化log
     * @参数说明 @param type
     * @return
     */
    void loadLogger(int type) {
    	/*switch (type) {
		case LOG_TYPE_WARN:
			log = Logger.getLogger("warn");
			break;
		case LOG_TYPE_ERROR:
			log = Logger.getLogger("error");  
			break;
		case LOG_TYPE_INFO:
			log = Logger.getLogger("info");  
			break;
		default:
			log = Logger.getLogger("info");  
			break;
		}*/
		log = LogManager.getLogger();
    	StackTraceElement[] stacks = (new Throwable()).getStackTrace(); 
    	setClassName(stacks[2].getClassName());
    	setMethodName(stacks[2].getMethodName());
    	setFileName(stacks[2].getFileName());
    	setLinNumber(stacks[2].getLineNumber());
   }
    
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Integer getLinNumber() {
		return linNumber;
	}
	public void setLinNumber(Integer linNumber) {
		this.linNumber = linNumber;
	}  
      
}
