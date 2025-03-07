package com.xoa.model.menu;

import java.util.List;


/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:24:10
 * 类介绍  :   子类菜单实体类
 * 构造参数:   
 *
 */
public class SysFunction {
	/**
	 * 子类菜单ID
	 */
	private Integer fId;
	/**
	 * 子菜单项代码
	 */
	private String id;
	/**
	 * 子菜单名称
	 */
	private String name;
	/**
	 * 子菜单名称
	 */
	private String name1;
	/**
	 * 子菜单名称
	 */
	private String name2;
	/**
	 * 子菜单名称
	 */
	private String name3;
	/**
	 * 子菜单名称
	 */
	private String name4;
	/**
	 * 子菜单名称
	 */
	private String name5;
	


	/**
	 * 子菜单模块路径
	 */
	private String url;
	/**
	 * 国际版多语言菜单名称
	 */
	private String ext;
	/**
	 * 对应二级菜单
	 */
	private List<SysFunction> child;

	/**
	 * 是否打开新窗口
	 */
	private String isopenNew;

	/**
	 * 1开启/0关闭(传递加密后的用户信息)
	 */
	private String sendUser;

	/**
	 * 密钥
	 */
	private String sendKey;
	/**
	 * 是否在app中显示本菜单
	 */
	private int isShowFunc;

	//菜单待办数量
	private int messageNum;


	public int getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
	}

	public int getIsShowFunc() {
		return isShowFunc;
	}

	public void setIsShowFunc(int isShowFunc) {
		this.isShowFunc = isShowFunc;
	}

	public String getSendUser() {
		return sendUser;
	}

	public void setSendUser(String sendUser) {
		this.sendUser = sendUser;
	}

	public String getSendKey() {
		return sendKey;
	}

	public void setSendKey(String sendKey) {
		this.sendKey = sendKey;
	}

	public Integer getfId() {
		return fId;
	}

	
	public void setfId(Integer fId) {
		this.fId = fId;
	}

	
	public String getId() {
		return id;
	}

	
	public void setId(String id) {
		this.id = id;
	}

	
	public String getName() {
		return name;
	}

	
	public void setName(String name) {
		this.name = name;
	}

	
	public String getUrl() {
		return url;
	}

	
	public void setUrl(String url) {
		this.url = url;
	}

	
	public String getExt() {
		return ext;
	}

	
	public void setExt(String ext) {
		this.ext = ext;
	}

	
	public List<SysFunction> getChild() {
		return child;
	}

	
	public void setChild(List<SysFunction> child) {
		this.child = child;
	}
	
	public String getName1() {
		return name1;
	}


	public void setName1(String name1) {
		this.name1 = name1;
	}


	public String getName2() {
		return name2;
	}


	public void setName2(String name2) {
		this.name2 = name2;
	}


	public String getName3() {
		return name3;
	}


	public void setName3(String name3) {
		this.name3 = name3;
	}


	public String getName4() {
		return name4;
	}


	public void setName4(String name4) {
		this.name4 = name4;
	}


	public String getName5() {
		return name5;
	}


	public void setName5(String name5) {
		this.name5 = name5;
	}

	public String getIsopenNew() {
		return isopenNew==null?"0":isopenNew;
	}

	public void setIsopenNew(String isopenNew) {
		this.isopenNew = isopenNew;
	}
}