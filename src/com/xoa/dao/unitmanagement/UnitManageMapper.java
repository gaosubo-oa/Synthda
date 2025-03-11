package com.xoa.dao.unitmanagement;

import com.xoa.model.unitmanagement.UnitManage;
import org.apache.ibatis.annotations.Param;

public interface UnitManageMapper {
    /**
     * 单位管理查询，并返回对象
     * 
     */
    UnitManage  showUnitManage();
    /**
     * 单位管理保存
     * 
     */
    void  addUnitManage(UnitManage unitManage);
    
    int  update(UnitManage unitManage);

    int  updateUnit(@Param("xoa") String xoa,@Param("name") String unitName ,@Param("unitId") Integer unitId);
   
}