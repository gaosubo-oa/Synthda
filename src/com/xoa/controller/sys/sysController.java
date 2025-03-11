package com.xoa.controller.sys;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SecureLogMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.model.common.SecureLog;
import com.xoa.model.common.SysPara;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.sms.SmsService;
import com.xoa.service.sys.InterFaceService;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.syspara.SysParaNotifyService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import org.json.JSONException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.util.*;

/**
 * 
 * 创建作者:   朱振宇
 * 创建日期:   2017-4-27 上午11:42:15
 * 类介绍:     系统设置页面
 * 构造参数: 
 *
 */
@Controller
@RequestMapping("/sys")
public class sysController {


	@Resource
	private SysParaMapper sysParaMapper;
	@Resource
	private SecureLogMapper secureLogMapper;
	@Resource
	private UsersService usersService;
	@Resource
	UsersPrivService usersPrivService;
	@Resource
	SysParaNotifyService sysParaNotifyService;
	@Resource
	InterFaceService interFaceService;

	@Resource
	SystemInfoService systemInfoService;
	@Resource
	private OrgManageService orgManageService;
	@Resource
	private SmsService smsService;


	@RequestMapping("/organizational")
	public String companyInfo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/Organizational";
	}
	@RequestMapping("/statusBar")
	public String statusBar(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/statusBar";
	}
	@RequestMapping("/sysInfo")
	public String sysInfo(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		//消除事务提醒
		Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
		smsService.setSmsFileRead(null,"0","/sys/sysInfo",users);
		return "app/sys/sysInfo";
	}
	@RequestMapping("/interfaceSettings")
	public String interfaceSettings(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/interfaceSettings";
	}
	//设置自定义字段
	@RequestMapping("/customField")
	public String customField(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/customField";
	}
	//登录界面模板预览
	@RequestMapping("/loginMouldPreview")
	public String loginMouldPreview(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
		ContextHolder.setConsumerType("xoa" + loginDateSouse);
		String selected = request.getParameter("selected");
		if(StringUtils.checkNull(selected)){
			return "login/default/index";
		}
		switch (Integer.parseInt(selected)) {
			case 1:
				return "login/default/index1";
			case 2:
				return "login/default/index2";
			case 3:
				return "login/default/index3";
			case 4:
				return "login/default/index4";
			case 5:
				return "login/default/index5";
			case 6:
				return "login/default/index6";
			case 7:
				return "login/default/index7";
			case 8:
				return "login/default/index8";
			case 9:
				return "login/default/index9";
			case 10:
				return "login/default/index10";
			case 11:
				return "login/default/index11";
			case 12:
				return "login/default/index12";
			case 13:
				return "login/default/index13";
			case 14:
				return "login/default/index14";
			case 15:
				return "login/default/index15";
			case 16:
				return "login/default/index16";
			case 17:
				return "login/default/index17";
			case 18:
				return "login/default/index18";
			case 19:
				return "login/default/index19";
			case 20:
				return "index22";
			case 25:
				return "index24";// 教育
			case 30: //计家EPM登录主题
				return "login/default/index30";
			default:
				return "login/default/index2";
		}
	}
	@RequestMapping("/menuSetting")
	public String menuSetting(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/menuSetting";
	}

	@RequestMapping("/signActivation")
	public String signActivation(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/signActivation";
	}

	@RequestMapping("/userInfor")
	public String userInfor(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/userInfor";
	}
	@RequestMapping("/userDetails")
	public String userDetails(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/userDetails";
	}
	@RequestMapping("/userDetailsPlus")
	public String userDetailsPlus(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/userDetailsPlus";
	}
	@RequestMapping("/underdevelopment")
	public String underdevelopment(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/underdevelopment";
	}
	@RequestMapping("/secure_rule")
	public String secure_rule(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/secure_rule";
	}
	@RequestMapping("/secureIndex")
	public String secureIndex(HttpServletRequest request,Map<String,Object> map) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
		String sy=SessionUtils.getSessionInfo(request.getSession(),"sysuperPwd",String.class,redisSessionCookie);
		if(StringUtils.checkNull(sy)){
			map.put("sign",0);
			if (users.getUserId().equals(Constant.syser)){
				return "app/sys/secureIndex";
			}else {
				return "app/common/development";
			}
		}else{
			map.put("sign",1);
			if (users.getUserId().equals(Constant.syser)){
				return "app/sys/secureIndex";
			}else {
				return "app/common/development";
			}
		}
	}
	@RequestMapping("/checkauthmoudle")
	@ResponseBody
	public AjaxJson checkAuthMoudle(HttpServletRequest request,String moustr) {
		AjaxJson ajaxJson = new AjaxJson();

		try{
			Map checkresult = systemInfoService.checkModule(request,moustr);
			ajaxJson.setObj(checkresult);
			ajaxJson.setFlag(true);
			ajaxJson.setMsg("OK");
		}catch (Exception e){
			ajaxJson.setFlag(false);
			ajaxJson.setMsg(e.toString());
		}


		return ajaxJson;
	}
	@RequestMapping("/getauthmoudle")
	@ResponseBody
	public AjaxJson getAuthMoudle(HttpServletRequest request,String moustr) {
		AjaxJson ajaxJson = new AjaxJson();


		String checkresult = systemInfoService.getAuthModule(request);
		try{
			ajaxJson.setObj(checkresult);
			ajaxJson.setFlag(true);
			ajaxJson.setMsg("OK");
		}catch (Exception e){
			ajaxJson.setFlag(false);
			ajaxJson.setMsg(e.toString());
		}


		return ajaxJson;
	}

	@RequestMapping("/checkpwd")
	@ResponseBody
	public AjaxJson checkpwd(HttpServletRequest request,String password,Map<String,Object> map) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			Cookie redisSessionCookie = new Cookie("redisSessionId",request.getSession().getId());
			SysPara sysPara = sysParaMapper.querySysPara("SECURE_SUPER_PASS");
			String sypwd = sysPara.getParaValue();
			if (StringUtils.checkNull(password)){
				if (sypwd.equals("tVHbkPWW57Hw.")){
					SessionUtils.putSession(request.getSession(), "sysuperPwd", sypwd,redisSessionCookie);
					ajaxJson.setMsg("OK");
					ajaxJson.setFlag(true);
					return ajaxJson;
				}
			}
			String md5Password = MD5Utils.md5Crypt(password.getBytes(), sypwd);
			if (sypwd.equals(md5Password)) {
				if (password==""){
					password="OK";
				}
				SessionUtils.putSession(request.getSession(), "sysuperPwd", password,redisSessionCookie);
				ajaxJson.setMsg("OK");
				ajaxJson.setFlag(true);
				return ajaxJson;
			}
			ajaxJson.setFlag(false);
			ajaxJson.setMsg("false");
		}catch (Exception e){
			e.printStackTrace();
			ajaxJson.setFlag(false);
			ajaxJson.setMsg("false");
		}
		return ajaxJson;
	}

	@RequestMapping("/secureRule")
	public String secureRule(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/secureRule";
	}
	@RequestMapping("/secureManager")
	public String secureManager(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
		return "app/sys/secureManager";
	}

	@RequestMapping("/getSecureRule")
	public String getSecureRule(){
		return "app/sys/seIndex2";
	}

	@RequestMapping("/secureIndex1")
	public String secure1(HttpServletRequest request) {
		return "app/sys/seIndex";
	}

	@RequestMapping("/secureIndex3")
	public String secure3(HttpServletRequest request) {
		return "app/sys/index3";
	}

	@RequestMapping("/setSuperPwd")
	public String setSuperPwd(HttpServletRequest request) {
		return "app/sys/setSysSuperPassword";
	}

	//职责页面
	@RequestMapping("/responsibilities")
	public String responsibilities(HttpServletRequest request) {
		return "app/sys/jobResponsibilities/responsibilities";
	}

	//职责显示页面
	@RequestMapping("/responsibilitiesDetails")
	public String responsibilitiesDetails(HttpServletRequest request) {
		return "app/sys/jobResponsibilities/responsibilitiesDetails";
	}
	//任务中心设置页面
	@RequestMapping("/taskCenterSettings")
	public String taskCenterSettings(HttpServletRequest request) {
		return "app/sys/jobResponsibilities/taskCenterSettings";
	}
	@RequestMapping("/savesy")
	@ResponseBody
	public AjaxJson savesy(HttpServletRequest request,String swith, String syser, String safer, String auditor, String userPriv){
		AjaxJson ajaxJson = new AjaxJson();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("swith",swith);
		jsonObject.put("syser",syser);
		jsonObject.put("safer",safer);
		jsonObject.put("auditor",auditor);
		jsonObject.put("userPriv",userPriv);
		String secureSwitch = jsonObject.toString();
		SysPara sysPara = new SysPara();
		sysPara.setParaName("SECURE_SWITCH");
		sysPara.setParaValue(secureSwitch);
		try {
			sysParaMapper.updateSysPara(sysPara);
			SecureLog secureLog =new SecureLog();
			if(swith.equals("1")){
				String remark="启用三员安全管理";
				secureLog.setRemark(remark);
			}
			if(swith.equals("0")){
				String remark="关闭三员安全管理";
				secureLog.setRemark(remark);
			}
			Date date =new Date();
			long time = date.getTime();
			int i1 = Math.abs((int)time);
			secureLog.setLogTime(i1);
			secureLog.setIp(IpAddr.getIpAddress(request));
			//从session中获取当前登录人的信息
			Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
			Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
			Integer uid = users.getUid();
			secureLog.setUid(uid);
			int i2 = secureLogMapper.insertSelective(secureLog);
			ajaxJson.setFlag(true);
			ajaxJson.setMsg("true");


		}catch (Exception e){
			e.printStackTrace();
			ajaxJson.setFlag(false);
			ajaxJson.setMsg(e.getMessage());
		}
		return ajaxJson;
	}

	@RequestMapping("/checkSy")
	@ResponseBody
	public AjaxJson checkSy(HttpServletRequest request){
		AjaxJson ajaxJson = new AjaxJson();
		SysPara sysPara = sysParaMapper.querySysPara("SECURE_SWITCH");
		String paraValue = sysPara.getParaValue();
		Map<String, Object> param = new HashMap();
		JSONArray json = new JSONArray();
		param = json.parseObject(paraValue, Map.class);
		String swith = (String) param.get("swith");
		String syser = (String) param.get("syser");
		String safer = (String) param.get("safer");
		String auditor = (String) param.get("auditor");
		String userPriv = (String) param.get("userPriv");
		List<Users> syserList = usersService.getUserByuId(syser);
		List<Users> saferList = usersService.getUserByuId(safer);
		List<Users> auditorList = usersService.getUserByuId(auditor);
		Map<String ,Object> map = new HashMap<String, Object>();
		map.put("syser",syserList);
		map.put("safer",saferList);
		map.put("auditor",auditorList);
		map.put("switch",swith);
		map.put("userPriv",userPriv);
		ajaxJson.setAttributes(map);
		return ajaxJson;
	}
	
	/**
	 * 创建作者:   季佳伟
	 * 创建日期:   2017年8月17日 下午15:19:05
	 * 方法介绍:   查询超级密码是否正确
	 * 参数说明:   @param password
	 * 参数说明:   @return
	 */
	@RequestMapping("/checkSuperPwd")
	@ResponseBody
	public AjaxJson checkSuperPwd(String password, HttpServletRequest request) {
		AjaxJson ajaxJson = new AjaxJson();
		try{
			SysPara sysPara = sysParaMapper.querySysPara("SECURE_SUPER_PASS");
			String paraValue = sysPara.getParaValue();
			String md5Password = MD5Utils.md5Crypt(password.getBytes(), paraValue);
			if (paraValue.equals(md5Password)){
				ajaxJson.setFlag(false);
				ajaxJson.setMsg("OK");
			}else {
				ajaxJson.setFlag(true);
				ajaxJson.setMsg("false");
			}
		}catch (Exception e){
			e.printStackTrace();
			ajaxJson.setMsg(e.getMessage());
			ajaxJson.setFlag(false);
		}
		return ajaxJson;
	}


	/**
	 * 创建作者:   季佳伟
	 * 创建日期:   2017年8月17日 下午15:19:05
	 * 方法介绍:   更新超级密码
	 * 参数说明:   @param password
	 * 参数说明:   @return
	 */
	@RequestMapping("/updateSuperPwd")
	@ResponseBody
	public AjaxJson updateSuperPwd(String password, HttpServletRequest request) {
		AjaxJson ajaxJson = new AjaxJson();
		try{
			Cookie redisSessionCookie = new Cookie("redisSessionId",request.getSession().getId());
			SysPara sysPara =new SysPara();
			sysPara.setParaName("SECURE_SUPER_PASS");
			sysPara.setParaValue(usersService.getEncryptString(password.trim()));
			SessionUtils.putSession(request.getSession(), "sysuperPwd", "",redisSessionCookie);
			sysParaMapper.updateSysPara(sysPara);
			ajaxJson.setFlag(true);
			ajaxJson.setMsg("OK");
		}catch (Exception e){
			e.printStackTrace();
			ajaxJson.setMsg(e.getMessage());
			ajaxJson.setFlag(false);
		}
		return ajaxJson;
	}

	/**
	 * @Description: 编辑公告通知设置接口
	 * @author:  刘新婷
	 * @date:  2017-11-20
	 * @param singls
	 * @param manager
	 * @param edit
	 * @param userIds
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/editNotify")
	public ToJson<Object> editNotify(String singls,String manager,String edit,String userIds,String exceptionUserIds){
		return sysParaNotifyService.editNotify(singls,manager,edit,userIds,exceptionUserIds);
	}

	/**
	 * @Description: 查询公告通知设置接口
	 * @author:  刘新婷
	 * @date:  2017-11-20
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/selectNotify")
	public ToJson<Object> selectNotify(){
		return sysParaNotifyService.selectNotify();
	}

	/**
	 * @Description: 查询本部门主管人员和指定可审批公告人员接口
	 * @author:  刘新婷
	 * @date:  2017-11-21
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getDeptManagers")
	public ToJson<Object> getDeptManagers(HttpServletRequest request){
		return sysParaNotifyService.getDeptManagers(request);
	}

	/**
	 * @Description: 根据公告类型查询已审批公告接口
	 * @author:  刘新婷
	 * @date:  2017-11-21
	 * @param typeId
	 * @param start
	 * @param size
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getApprovedNotifyList")
	public ToJson<Notify> getApprovedNotifyList(String typeId,Integer start,Integer size,
												@RequestParam("page") Integer page,
												@RequestParam("pageSize") Integer pageSize,
												@RequestParam("useFlag") Boolean useFlag,HttpServletRequest request){
		return sysParaNotifyService.getApprovedNotifyList(typeId,start,size,page,pageSize,useFlag,request);
	}

	/**
	 * @Description: 根据公告类型查询待审批公告接口
	 * @author:  刘新婷
	 * @date:  2017-11-22
	 * @param typeId
	 * @param start
	 * @param size
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getPendingNotifyList")
	public ToJson<Notify> getPendingNotifyList(String typeId, Integer start, Integer size,
											   @RequestParam("page") Integer page,
											   @RequestParam("pageSize") Integer pageSize,
											   @RequestParam("useFlag") Boolean useFlag,HttpServletRequest request){
		return sysParaNotifyService.getPendingNotifyList(typeId,start,size,page,pageSize,useFlag,request);
	}

	/**
	 * @Description: 获取公告类型接口
	 * @author:  刘新婷
	 * @date:  2017-11-24
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getNotifyTypeList")
	public ToJson<Object> getNotifyTypeList(HttpServletRequest request){
		return sysParaNotifyService.getNotifyTypeList(request);
	}

	@ResponseBody
	@RequestMapping("/getNotifyCode")
	public  ToJson<Object> getNotifyCode( HttpServletRequest request){
		return sysParaNotifyService.getNotifyCode(request);
	}



	@ResponseBody
	@RequestMapping("/pushMessage")
	public BaseWrapper pushMessage(String userId, String app, HttpServletRequest request, String title, String content) throws JSONException {
		return interFaceService.pushMessage(userId,app,request,title,content);
	}


	@ResponseBody
	@RequestMapping("/getProject")
	public BaseWrapper getProject(String userId, String app, HttpServletRequest request, String title, String content) throws JSONException {
		BaseWrapper baseWrapper = new BaseWrapper();
		baseWrapper.setObj(sysParaMapper.querySysPara("MYPROJECT").getParaValue());
		baseWrapper.setFlag(true);
		return baseWrapper;
	}

	/**
	 * 分公司登录窗口
	 * @return 登录窗口
	 */
	@RequestMapping(value = "/getCompanyAll", method = RequestMethod.GET)
	@ResponseBody
	public ToJson<OrgManage> logins(HttpServletRequest request, String locales) {
		String serverName = request.getServerName();
		String sqlType = "xoa1001";
		ContextHolder.setConsumerType(sqlType);
		if (locales == null) {
			locales = "en_US";
		}
		return orgManageService.queryId2(locales, serverName);
	}
}
