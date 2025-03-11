package com.xoa.controller.users;

import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.UserFunction;
import com.xoa.service.users.UserFunctionService;
import com.xoa.util.ToJson;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


@Controller
@Scope(value="prototype")
public class UserFunctionController {
	
	@Resource
	private UserFunctionService  userFunctionService;

	@RequestMapping("/checkPriv")
	@ResponseBody
	public ToJson<SysFunction> checkPriv(HttpServletRequest request , @RequestParam("funcId") String funcId){
		ToJson toJson = new ToJson(1,"err");
		try {
			toJson.setObject(userFunctionService.checkPriv(request, funcId));
			toJson.setFlag(0);
			toJson.setMsg("ok");
		}catch (Exception e){
			e.printStackTrace();
		}
		return  toJson;
	}

	@ResponseBody
	@RequestMapping("userFunciton/getMenuByUid")
	public ToJson<UserFunction> getMenuByUid(Integer uid){
		ToJson<UserFunction> json = new ToJson<>();
		json.setObject(userFunctionService.getMenuByUserId(uid));
		json.setFlag(0);
		json.setMsg("ok");
		return json;
	}


	/*	@RequestMapping("/showGetMenu")
	@ResponseBody
	public ToJson<SysFunction>  getMenu(){
		ToJson<SysFunction> sysList=userFunctionService.getMenu(1);
   return  sysList;
	}*/
	
	/*@RequestMapping("/showUser2")
	@ResponseBody
	public String show(){
		ToJson<SysFunction> sysList=userFunctionService.getMenu(63);
		Map<String, String> map = new HashMap<String, String>();
		//map.put("showmenus", JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss"));
		return JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss");
		
	}*/
	/*@RequestMapping("/showUser4")
	@ResponseBody
	public String dep(){
		ToJson<Department> sysList=userFunctionService.getDep();
		Map<String, String> map = new HashMap<String, String>();
		map.put("showmenus", JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss"));
		return JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss");
		
	}
	@RequestMapping("/showUser5")
	@ResponseBody
	public String getUserAll(){
		ToJson<Users> sysList=userFunctionService.getUser(12);
		Map<String, String> map = new HashMap<String, String>();
		map.put("showmenus", JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss"));
		return JSON.toJSONStringWithDateFormat(sysList, "yyyy-MM-dd HH:mm:ss");
		
	}*/

}
