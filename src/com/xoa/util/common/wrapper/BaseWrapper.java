package com.xoa.util.common.wrapper;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.xoa.util.common.StringUtils;

import java.util.Date;

/**
 * 
 * @作者 韩东堂
 * @创建日期 2017-4-24 下午3:28:59
 * @类介绍 基本包装类
 * @构造参数 无 或者带必要参数
 * 
 */
public class BaseWrapper {
	boolean status;
	boolean flag;
	String msg;
	Date time; 
	Object data;
	String code;
	Integer totleNum;
	int totle;
	Object obj;

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public int getTotle() {
		return totle;
	}

	public void setTotle(int totle) {
		this.totle = totle;
	}

	public BaseWrapper() {
		super();
		this.time = new Date();
		this.status=true;
		
	}
	public BaseWrapper(boolean status, boolean flag, String msg,Object data) {
		super();
		this.status = status;
		this.flag = flag;
		this.msg = msg;
		this.time = new Date();
		this.data=data;
	}

	public void setTrue(){
		this.status = true;
		this.flag = true;
		this.msg = "ok";
		this.setCode("0");
	}

	public boolean isStatus() {
		return status;
	}


	public String getCode() {
		return code==null?"0":code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}
	public boolean getStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		if(!StringUtils.checkNull(msg)){
			if(msg.contains("成功")){
				msg = "success";
			} else if (msg.contains("失败") || msg.contains("不正确") ){
				msg = "fail";
			} else if (msg.contains("异常")){
				msg = "err";
			}
		}
		this.msg = msg;
	}

	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public Date getTime() {
		if (time == null) {
			time = new Date();
		}
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getTotleNum() {
		return totleNum;
	}

	public void setTotleNum(Integer totleNum) {
		this.totleNum = totleNum;
	}

	public String toJsonString(){
		return JSON.toJSONString(this);
	}


}
