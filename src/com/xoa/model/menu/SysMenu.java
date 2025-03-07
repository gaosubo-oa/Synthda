package com.xoa.model.menu;

import java.util.List;


/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:24:22
 * 类介绍  :   一级菜单
 * 构造参数:   无
 *
 */
public class SysMenu {
	/**
	 * 菜单ID
	 */
	private String id;
	/**
	 * 菜单名称
	 */
	private String name;
	/**
	 * 菜单名称
	 */
	private String name1;
	/**
	 * 菜单名称
	 */
	private String name2;
	/**
	 * 菜单名称
	 */
	private String name3;
	/**
	 * 菜单名称
	 */
	private String name4;
	/**vioooitkk
	 * 菜单名称
	 */
	private String name5;
	


	/**
	 * 菜单图片名
	 */
	private String img;
	/**
	 * 国际版多语言菜单名称
	 */
	private String ext;
	/**
	 * 对应二级菜单
	 */
	private List<SysFunction> child;

	//菜单待办数量
	private int messageNum;

	//新主菜单分类代码
	private String newId;

	public int getMessageNum() {
		return messageNum;
	}

	public void setMessageNum(int messageNum) {
		this.messageNum = messageNum;
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

	
	public String getImg() {
		return img;
	}

	
	public void setImg(String img) {
		this.img = img;
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


	public String getName5()
	{
		return name5;
	}


	public void setName5(String name5)
	{
		this.name5 = name5;
	}

	public String getNewId() {
		return newId;
	}

	public void setNewId(String newId) {
		this.newId = newId;
	}
}