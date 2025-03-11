package com.xoa.service.surface;

import com.xoa.model.surface.Surface;

import java.util.List;

/**
 * 
 * @ClassName (类名):  SurfaceService
 * @Description(简述): 界面设置的接口
 * @author(作者):      张丽军
 * @date(日期):        2017-5-4 下午3:51:58
 *
 */
public interface SurfaceService {
	
    
	/**
	 * 
	 * @Title: updateSurf
	 * @Description: 修改接口
	 * @author(作者): 张丽军
	 * @param: @param surface   
	 * @return: void   
	 * @throws
	 */
	public void updateSurf(Surface surface);

	
	/**
	 * 
	 * @Title: getIeTitle
	 * @Description: 查询接口
	 * @author(作者): 张丽军
	 * @param: @return   
	 * @return: List<Surface>   
	 * @throws
	 */
	public List<Surface> getIeTitle();


	
}
