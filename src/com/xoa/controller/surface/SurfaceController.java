package com.xoa.controller.surface;

import com.xoa.model.surface.Surface;
import com.xoa.service.surface.SurfaceService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 
 * @ClassName (类名):  SurfaceController
 * @Description(简述): 界面设置逻辑层
 * @author(作者):      张丽军
 * @date(日期):        2017-5-4 下午2:51:38
 *
 */

@Controller
@RequestMapping("/surface")
public class SurfaceController {

	
	@Resource
	private SurfaceService surfaceService;
	/**
	 * 
	 * @Title: selectSurf
	 * @Description: 界面信息查询
	 * @author(作者): 张丽军
	 * @param: @param request
	 * @param: @return   
	 * @return: ToJson<Surface>   
	 * @throws
	 */
	@ResponseBody
	@RequestMapping(value="/selectSurf",produces = {"application/json;charset=UTF-8"})
	public ToJson<Surface> selectSurf(HttpServletRequest request){
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Surface> tojson=new ToJson<Surface>(0,"");
		try{
			List<Surface> list=surfaceService.getIeTitle();
			tojson.setObject(list);
			tojson.setMsg("ok");
			tojson.setFlag(0);
		}catch (Exception e) {
			tojson.setMsg(e.getMessage());
		}
		return tojson;
		
		 
	}
	/**
	 * 
	 * @Title: updateSurf
	 * @Description: 界面信息修改
	 * @author(作者): 张丽军
	 * @param: @param surface
	 * @param: @param request
	 * @param: @return   
	 * @return: ToJson<Surface>   
	 * @throws
	 */
	@RequestMapping(value="/updateSurf",method=RequestMethod.POST)
	@ResponseBody
	public ToJson<Surface> updateSurf(Surface surface,HttpServletRequest request){
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Surface> tojson=new ToJson<Surface>(0,"");
		try{
			surfaceService.updateSurf(surface);
			tojson.setObject(surface);
			tojson.setMsg("ok");
			tojson.setFlag(0);
		}catch(Exception e){
			tojson.setMsg(e.getMessage());
		}
		return tojson;
	}

	

}
