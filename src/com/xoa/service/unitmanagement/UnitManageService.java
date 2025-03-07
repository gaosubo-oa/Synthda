package com.xoa.service.unitmanagement;

import com.xoa.model.unitmanagement.UnitManage;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @author zlx
 * @version 1.0
 *
 */
public interface UnitManageService {
	/**
     * 单位管理查询，并返回对象
     * 
     */
	public  UnitManage  showUnitManage(String sqlType, HttpServletRequest request);
   /**
    * 单位管理保存
    * 
    */
	public void addUnitManage(UnitManage unitManage);
	
   public void update(UnitManage unitManage,String sqlType, HttpServletRequest request);
}
