package com.xoa.util.common.wrapper;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;
import java.util.List;


public  class BaseWrappers<T> {
	boolean status;
	boolean flag;
	String msg;
	Date time;
	Object object;
	List<T> datas;
	String useTime;


	Integer total;
	
	public BaseWrappers()
	{
		time =new Date();
	}
	
	
	public BaseWrappers(boolean status, boolean flag, String msg,
			List<T> datas) {
		super();
		this.status = status;
		this.flag = flag;
		this.msg = msg;
		this.time = new Date();
		this.datas = datas;
	}
	public boolean isStatus() {
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
		this.msg = msg;
	}
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	public Date getTime() {
		if(time==null){
			time=new Date();
		}
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public List<T> getDatas() {
		return datas;
	}
	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

	public String getUseTime() {
		return useTime;
	}

	public void setUseTime(String useTime) {
		this.useTime = useTime;
	}
}
