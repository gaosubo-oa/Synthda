package com.xoa.dao.menu;

import com.xoa.model.menu.MobileApp;

import java.util.List;

/**
 * 
 * 创建作者:   王曰岐
 * 创建日期:   2017-4-19 下午3:26:01
 * 类介绍  :   移动端菜单DAO
 * 构造参数:   无
 *
 */
public interface MobileAppMapper {
	
   
	/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-19 下午3:26:20
	 * 方法介绍:   获得全部移动端菜单
	 * 参数说明:   @return
	 * @return     List<MobileApp>  菜单List
	 */
	
	public List<MobileApp> getMobileAppList();
}