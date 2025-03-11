package com.xoa.controller.spirit;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.daiban.Daiban;
import com.xoa.model.users.Users;
import com.xoa.service.sys.SysLogService;
import com.xoa.service.todoList.TodolistService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 创建作者: 、 创建日期: 2017年4月18日 下午6:42:39 类介绍 : 用户 构造参数:
 *
 */
@Controller
@RequestMapping("/spirit")
public class SpiritController {
	private  final String one="1";

	@Resource
	private UsersService usersService;
	@Resource
	private SysParaMapper sysParaMapper;
	@Resource
	private TodolistService todolistService;
	@Resource
	private SmsBodyMapper smsBodyMapper;
	@Resource
	private SysLogService sysLogService;

	/*
	 * @RequestMapping("/zzz") //URL的/index public String login1() { return
	 * "app/spirit/main"; }
	 */

	@RequestMapping("/login")
	// URL的/index
	public String login(HttpServletRequest request,String company,Model model) {
		request.getSession().setAttribute("loginDateSouse", company);
		L.w(company);
		String a =(String)SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		L.w(a);
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users users=SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
		String ip = "";
		String gimHost = "";
		SysPara sysParaHost = sysParaMapper.querySysPara("IM_HOST");
		//根据商量先获取数据库IM_STUTES的字段是1则返回手动配置的IP地址 是0的情况下让手机端自己获取ip和端口,返回为空
		SysPara sysParaStutes = sysParaMapper.querySysPara("IM_STUTES");
		SysPara sysParaPort = sysParaMapper.querySysPara("IM_PORT");

		if(sysParaStutes!=null&&!StringUtils.checkNull(sysParaStutes.getParaValue()).booleanValue()){
			if(one.equals(sysParaStutes.getParaValue())){
				ip=sysParaHost.getParaValue();
				gimHost=sysParaPort.getParaValue();
			}
		}
		model.addAttribute("users",users);
		model.addAttribute("gim_ip",ip);
		model.addAttribute("gim_port",gimHost);



		return "app/spirit/login/login";
	}

	@RequestMapping("/main")
	// URL的/index
	public String main(Model model, HttpServletRequest request) {
		Set arg = new HashSet<String>();
		arg.add("paraName");
		arg.add("paraValue");
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users users=SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);

		model.addAllAttributes(SessionUtils.getSessionInfo(
				request.getSession(), arg,redisSessionCookie));
//		List<InterfaceModel> interfaceModels=  sysInterfaceMapper.getInterfaceInfo();
//		if(0==users.getTheme()){
//			users.setTheme((byte)Integer.parseInt(interfaceModels.get(0).getTheme()));
//		}
//		String theme="theme"+users.getTheme();
//		SessionUtils.putSession(request.getSession(), "InterfaceModel", theme);
//		if(StringUtils.checkNull(interfaceModels.get(0).getIeTitle())){
//			users.setInterfaceTitle("");
//		}else {
//			users.setInterfaceTitle(interfaceModels.get(0).getIeTitle());
//		}
		model.addAttribute("users",users);
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/mains";
	}

	@RequestMapping("/menu")
	// URL的/index
	public String menu(HttpServletRequest request) {
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		Users users=SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
		Users user = usersService.getByUid(users.getUid());
		if("tVHbkPWW57Hw.".equals(user.getPassword())){
			List<SysPara> sysParas = sysParaMapper.listSysPara();
			for (SysPara sysPara : sysParas) {
				if("SEC_INIT_PASS_SHOW".equals(sysPara.getParaName())
						&& "1".equals(sysPara.getParaValue().trim())){
					return "app/spirit/editPw";
				}
			}
		}
		return "app/spirit/menu";
	}

	@RequestMapping("/dh")
	// URL的/index
	public String dh(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/dh";
	}

	@RequestMapping("/thingReminder")
	// URL的/index
	public String thingReminder(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/thingReminder";
	}


	@RequestMapping("/groupChat")
	// URL的/index
	public String groupChat(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/groupChat";
	}


	@RequestMapping("/newGroupChat")
	// 新建群聊
	public String newGroupChat(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/newGroupChat";
	}


	@RequestMapping("/groupChatLog")
	// 新建群聊
	public String groupChatLog(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/groupChatLog";
	}



	@RequestMapping("/group")
	// URL的/index
	public String group(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/group";
	}

	@RequestMapping("/countersign")
	// URL的/index
	public String countersign(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/countersign";
	}

	@RequestMapping("/newgroup")
	// URL的/index
	public String newgroup(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/newgroup";
	}

	@RequestMapping("/editgroup")
	// URL的/index
	public String editgroup(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/editgroup";
	}

	@RequestMapping("/managegroup")
	// URL的/index
	public String managegroup(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/managegroup";
	}

	@RequestMapping("/managegroupchat")
	// URL的/index //管理群组页面
	public String managegroupchat(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/manageGroupChat";
	}

	@RequestMapping("/bq")
	// URL的/index
	public String note(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/note";
	}

	@RequestMapping("/oaganization")
	// URL的/index
	public String oaganization(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/zz";
	}
	@RequestMapping("/zz")
	// URL的/index
	public String zz(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/zz";
	}


	@RequestMapping("/willDoCounts")
	@ResponseBody
	public BaseWrapper getToDolistCounts(String userId, String companyId,HttpServletRequest request){
		/*String sqlType = "xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		ContextHolder.setConsumerType(sqlType);
		Users users =SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users());*/

		ContextHolder.setConsumerType(companyId);
		BaseWrapper wrappers =new BaseWrapper();
		wrappers.setFlag(false);
		wrappers.setStatus(true);
		if(StringUtils.checkNull(userId)){
			wrappers.setMsg("无效的用户信息");
			return wrappers;
		}
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");

		if("undefined".equals(userId)&&StringUtils.checkNull(companyId)){

			userId=SessionUtils.getSessionInfo(request.getSession(),"userId",String.class,redisSessionCookie);
			companyId=(String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
		}
		try{
			String sqlType="xoa"+companyId;
			Daiban db=todolistService.list(userId,sqlType,request);
			SessionUtils.putSession(request.getSession(), "userId", userId,redisSessionCookie);
			if(db!=null){
				Integer email =db.getEmail()==null?0:db.getEmail().size();
				Integer notify =db.getNotify()==null?0:db.getNotify().size();
				Integer workFlow=db.getWorkFlow()==null?0:db.getWorkFlow().size();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("toId", userId);
				map.put("remindFlag", "3");
				Integer smsBodyCountByMap = smsBodyMapper.getSmsBodyCountByMap(map);
				Map<String,Object> result =new HashMap<String,Object>();
				result.put("email",email);
				result.put("willDo",notify+workFlow);
				result.put("willDo",notify+workFlow);
				result.put("smsDo",smsBodyCountByMap);
				wrappers.setData(result);
				wrappers.setFlag(true);
			}
		}catch (Exception e){
			//e.printStackTrace();
			wrappers.setFlag(false);
			wrappers.setMsg(e.getMessage());
		}

		return wrappers;
	}
	@RequestMapping("/messageList")
	public String messageList(HttpServletRequest request,Model model){
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
		Users u=	SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
		if(u!=null&&u.getUid()!=null){
			model.addAttribute("uId",u.getUid());
		}
		return "app/spirit/messagelist";
	}
	@RequestMapping("/searchBox")
	// URL的/index
	public String search(HttpServletRequest request) {
		ContextHolder.setConsumerType("xoa"
				+ (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")));
		return "app/spirit/search";
	}



	@RequestMapping("/chatRecord")
	public String chatRecord() {
		return "app/spirit/chatRecord";
	}


	@RequestMapping("/webChatRecord")
	public String webChatRecord() {
		return "app/spirit/webChatRecord";
	}

	@RequestMapping("/webChatRecordWeb")
	public String webChatRecordWeb() {
		return "app/spirit/webChatRecordWeb";
	}

	@RequestMapping("/getFriendList")
	public String getFriendList(){
		return "app/spirit/friendList";
	}


	@RequestMapping("/getAddfriend")
	public String getAddfriend(){
		return "app/spirit/Addfriend";
	}
}
