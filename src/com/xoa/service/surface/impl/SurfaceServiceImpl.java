package com.xoa.service.surface.impl;

import com.xoa.dao.surface.SurfaceMapper;
import com.xoa.model.surface.Surface;
import com.xoa.service.surface.SurfaceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * @ClassName (类名):  SurfaceServiceImpl
 * @Description(简述): 界面设置的实现类
 * @author(作者):      张丽军
 * @date(日期):        2017-5-4 下午3:50:43
 *
 */
@Service
public class SurfaceServiceImpl   implements SurfaceService {
	
	@Resource
	private SurfaceMapper surfaceMapper;
    /**
     * 
     * <p>Title: updateSurf</p>
     * <p>Description:修改界面实现类接口 </p>
     * @param surface
     * @author(作者):  张丽军
     * @see com.xoa.service.surface.SurfaceService#updateSurf(com.xoa.model.surface.Surface)
     */
	@Override
	public void updateSurf(Surface surface) {
		
		surfaceMapper.updateSurf(surface);
		
	}
    /**
     * 
     * <p>Title: getIeTitle</p>
     * <p>Description:查询界面实现接口 </p>
     * @return
     * @author(作者):  张丽军
     * @see com.xoa.service.surface.SurfaceService#getIeTitle()
     */
	@Override
	public List<Surface> getIeTitle() {
		
		return surfaceMapper.getIeTitle();
	}

}
