package com.xoa.controller.sys;

import com.xoa.model.unitmanagement.UnitManage;
import com.xoa.service.unitmanagement.UnitManageService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
@Scope(value = "prototype")
@RequestMapping("/sys")
public class UnitManagementController {

	@Resource
	private UnitManageService unitManageService;
	@RequestMapping("/companyInfo")
	public String companyInfo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/companyInfo";
	}
	@RequestMapping("/unitInfor")
	public String unitInfor(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/unitInfor";
	}
	/**
	 * 信息展示 返回
	 * 
	 * @return
	 */
	@RequestMapping(value = "/showUnitManage", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody ToJson<UnitManage>showUnitManage(HttpServletRequest request) {
		String sqlType = "xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		ContextHolder.setConsumerType(sqlType);
		ToJson<UnitManage> json=new ToJson<UnitManage>(0, null);
		
		try{
			UnitManage um = unitManageService.showUnitManage(sqlType,request);
			json.setObject(um);
			json.setMsg("OK");
			json.setFlag(0);
		}catch(Exception e){
			e.printStackTrace();
            json.setFlag(1);
			json.setMsg("err");
		}
		return json;
		}

	/**
	 * 保存信息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addUnitMnaage", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody ToJson<UnitManage> addUnitMnaage(UnitManage unitManage,HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);

        ToJson<UnitManage> json=new ToJson<UnitManage>(0, null);

        try{
            unitManageService.addUnitManage(unitManage);
            json.setMsg("OK");
            json.setFlag(0);
        }catch(Exception e){
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

	
	/**
	 * 创建作者:
	 * 创建日期:   2017年5月18日 上午9:28:24
	 * 方法介绍:   修改
	 * 参数说明:   @param unitManage 单位信息  
	 * 参数说明:   @param request 请求
	 * 参数说明:   @return
	 * @return     ToJson<UnitManage> 返回单位信息
	 */
	@ResponseBody
	@RequestMapping(value = "/updateUnit",produces = {"application/json;charset=UTF-8"})
	public ToJson<UnitManage> updateUnit(UnitManage unitManage,HttpServletRequest request){
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		String sqlType = "xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ContextHolder.setConsumerType(sqlType);
		ToJson<UnitManage> json=new ToJson<UnitManage>(0, null);
		try{
			unitManageService.update(unitManage,sqlType, request);
			json.setObject(unitManage);
			json.setMsg("OK");
			json.setFlag(0);
		}catch(Exception e){
            json.setFlag(1);
			json.setMsg("err");
		}
		return json;
		}
	
}
