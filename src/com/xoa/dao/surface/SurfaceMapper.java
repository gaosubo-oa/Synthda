package com.xoa.dao.surface;

import com.xoa.model.surface.Surface;

import java.util.List;

/**
 * 
 * @ClassName (类名):  SurfaceMapper
 * @Description(简述): Dao方法
 * @author(作者):      张丽军
 * @date(日期):        2017-5-4 下午5:03:33
 *
 */

public interface SurfaceMapper {
	
	
	
	/**
	 * 界面信息修改方法
	 * @param surface
	 */
	public void updateSurf(Surface surface);
	
	
	/**
	 * 界面信息查询方法
	 * @return
	 */
	public List<Surface> getIeTitle(); 
    
}