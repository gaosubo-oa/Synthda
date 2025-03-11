package com.xoa.model.users;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class UserFunction implements Serializable {
	
	/**
	 * 对应user表的UID
	 */
	private int uid;
	/**
	 * 对应user表的USER_ID
	 */
	private String userId;
	/**
	 * 用户菜单ID串
	 */
	private String userFunCidStr;

	// 更新时间
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Date updateTime;
	
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserFunCidStr() {
		return userFunCidStr;
	}
	public void setUserFunCidStr(String userFunCidStr) {
		this.userFunCidStr = userFunCidStr;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
}
