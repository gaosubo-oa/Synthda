package com.xoa.controller.todoList;

import com.xoa.model.daiban.Daiban;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.Users;
import com.xoa.service.email.EmailService;
import com.xoa.service.notify.NotifyService;
import com.xoa.service.todoList.TodolistService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
public class TodolistController {

	@Resource
	private TodolistService todolistService;
	
	@Resource
	private EmailService emailService;

	@Resource
	private NotifyService notifyService;
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月23日 下午5:02:21
	 * 方法介绍:   根据userId 查询待办
	 * 参数说明:   @param request 请求
	 * 参数说明:   @param userId 用户Id
	 * 参数说明:   @return
	 * @return     返回待办信息
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/list",produces = {"application/json;charset=UTF-8"})
    public ToJson<Daiban> list(HttpServletRequest request,
							   @RequestParam(value = "userId",required = false)String userId) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Daiban> json=new ToJson<Daiban>(0, null);
		try {
			String sqlType="xoa" + (String) request.getSession().getAttribute(
					"loginDateSouse");
			if(!StringUtils.checkNull(userId)){
				Daiban db=todolistService.list(userId,sqlType,request);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}else{
				Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
				Daiban db=todolistService.list(String.valueOf(user.getUserId()),sqlType,request);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}
		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}
        return json;
    }


	@ResponseBody
	@RequestMapping(value = "/todoList/readList",produces = {"application/json;charset=UTF-8"})
	public ToJson<Daiban> readList(HttpServletRequest request,
							   @RequestParam(value = "userId",required = false)String userId) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Daiban> json=new ToJson<Daiban>(0, null);
		try {
			String sqlType="xoa" + (String) request.getSession().getAttribute(
					"loginDateSouse");
			if(!StringUtils.checkNull(userId)){
				Daiban db=todolistService.readList(userId,sqlType,request);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}else{
				Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
				Daiban db=todolistService.readList(String.valueOf(user.getUserId()),sqlType,request);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}
		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/todoList/readHaveList",produces = {"application/json;charset=UTF-8"})
	public BaseWrapper readHaveList(String classification, HttpServletRequest request,@RequestParam(value = "userId",required = false)String userId)
			throws Exception {
			String sqlType="xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
			if(!StringUtils.checkNull(userId)){
			     return  todolistService.readHaveList(classification,userId,sqlType,request);
			}else{
				Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
				Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
				return  todolistService.readHaveList(classification,user.getUserId(),sqlType,request);
			}
		}

	@ResponseBody
	@RequestMapping(value = "/todoList/readTotal",produces = {"application/json;charset=UTF-8"})
	public ToJson<Daiban> readTotal(HttpServletRequest request,
								   @RequestParam(value = "userId",required = false)String userId,
									String superfluity) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Daiban> json=new ToJson<Daiban>(0, null);
		try {
			String sqlType="xoa" + (String) request.getSession().getAttribute(
					"loginDateSouse");
			if(!StringUtils.checkNull(userId)){
				Daiban db=todolistService.readTotal(userId,sqlType,request,superfluity);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}else{
			Users	user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
				Daiban db=todolistService.readTotal(String.valueOf(user.getUserId()),sqlType,request,superfluity);
				json.setObject(db);
				json.setMsg("OK");
				json.setFlag(0);
			}
		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}
		return json;
	}


	
	@ResponseBody
	@RequestMapping(value = "/todoList/delete",produces = {"application/json;charset=UTF-8"})
    public ToJson<Daiban> delete(HttpServletRequest request,Integer qid,String type,String deleteFlag) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		ToJson<Daiban> json=new ToJson<Daiban>(0, null);
		try {
			if(type.equals("email")){
			String returnRes = emailService.deleteInEmail(qid, deleteFlag);	
			}
			if(type.equals("notify")){
				notifyService.delete(qid);
			}
			if (json.getObj().size()>0) {
				json.setFlag(0);
				json.setMsg("ok");
			} else {
				json.setFlag(1);
				json.setMsg("error");
			}
		} catch (Exception e) {
			json.setMsg(e.getMessage());
		}
        return json;
    }


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:32:22
	 * 方法介绍:   根据userId进行模糊查询
	 * 参数说明:   @param userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/queryUserByUserId")
	public ToJson<Users> queryUserByUserId(String userName,HttpServletRequest request){
		if(StringUtils.checkNull(userName)){
			userName="";
		}
		return  todolistService.queryUserByUserId(userName.trim(),request);
	}

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:35:22
	 * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
	 * 参数说明:   @param  userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/queryCountByUserId")
	public ToJson<Users> queryCountByUserId(String userName){
		if(StringUtils.checkNull(userName)){
			userName="";
		}
		return  todolistService.queryCountByUserId(userName.trim());
	}


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:29:22
	 * 方法介绍:   根据子菜单名称进行模糊查询
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return ToJson
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/getSysFunctionByName")
	public ToJson<SysFunction> getSysFunctionByName(String funName,HttpServletRequest request){
		return todolistService.getSysFunctionByName(funName.trim(),request);
	}
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:30:12
	 * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return ToJson
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/getCountSysFunctionByName")
	public ToJson<SysFunction> getCountSysFunctionByName(String funName){
		return todolistService.getCountSysFunctionByName(funName.trim());
	}
	//事务提醒
	@ResponseBody
	@RequestMapping(value = "/todoList/smsListByType")
	public BaseWrapper SmsListByType(String userId, HttpServletRequest request, String type){
		return  todolistService.smsListByType(userId,request,type);
	}
	@ResponseBody
	@RequestMapping(value = "/todoList/getUserFunctionByUserId")
	public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request){
		return  todolistService.getUserFunctionByUserId(userId,request);
	}

	@ResponseBody
	@RequestMapping(value = "/todoList/getWillDocSendOrReceive")
	public BaseWrapper getWillDocSendOrReceive(String userId,String documentType, HttpServletRequest request){
		return  todolistService.getWillDocSendOrReceive(userId,documentType,request);
	}

	/**
	 * PC端事务提醒
	 * @param userId
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/smsListByTypeByPC")
	public BaseWrapper smsListByTypeByPC(@RequestParam(value = "userId", required = false) String userId, HttpServletRequest request){
		return todolistService.smsListByTypeByPC(userId,request);
	}

	/**
	 * PC端事务提醒数量
	 * @param userId
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/todoList/smsListCountByPC")
	public BaseWrapper smsListCountByPC(String userId, HttpServletRequest request){
		return todolistService.smsListCountByPC(userId,request);
	}
}
