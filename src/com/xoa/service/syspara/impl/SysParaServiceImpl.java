package com.xoa.service.syspara.impl;

import com.alibaba.fastjson.JSONArray;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.xoa.dao.common.SecureRuleMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SecureRule;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.syspara.SysParaService;
import com.xoa.util.AjaxJson;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;


@Service
public class SysParaServiceImpl  implements SysParaService{
	
	@Resource
	private SysParaMapper sysParaMapper;
	@Resource
	private UsersMapper usersMapper;
	@Resource
	private SecureRuleMapper secureRuleMapper;
	@Resource
	private UserPrivMapper userPrivMapper;
	@Resource
	private DepartmentMapper departmentMapper;

    /**
     * 
     * <p>Title: getIeTitle</p>
     * <p>Description: </p>
     * @return
     * @author(作者):  张丽军
     * @see com.xoa.service.syspara.SysParaService#getIeTitle()
     */
	@Override
	public List<SysPara> getIeTitle() {
		
		return sysParaMapper.getIeTitle();
	}

	/**
	 *
	 * <p>Title: getIeTitle</p>
	 * <p>Description: </p>
	 * @return
	 * @author(作者):  张丽军
	 * @see com.xoa.service.syspara.SysParaService#getIeTitle()
	 */
	@Override
	public List<SysPara> getVersion() {

		return sysParaMapper.getVersion();
	}
	/**
	 *
	 * <p>Title: getIeTitle</p>
	 * <p>Description: </p>
	 * @return
	 * @author(作者):  张丽军
	 * @see com.xoa.service.syspara.SysParaService#getIeTitle()
	 */
	@Override
	public List<SysPara> getVersionIos() {

		return sysParaMapper.getVersionIos();
	}

	@Override
	public SysPara getSelectPassword() {
		return sysParaMapper.getSelectPassword();
	}

	@Override
	public Map<String,String>  selectSysPCAI(HttpServletRequest request) {
		Map<String,String> list = new HashMap<>();
		SysPara sysPara1 = sysParaMapper.selectSysPCAI(request);
		SysPara sysPara2 = sysParaMapper.selectSysPCAI2(request);
		SysPara sysPara3 = sysParaMapper.selectSysPCAI3(request);

		list.put(sysPara1.getParaName(),sysPara1.getParaValue());
		list.put(sysPara2.getParaName(),sysPara2.getParaValue());
		list.put(sysPara3.getParaName(),sysPara3.getParaValue());


		return list;
	}

	@Override
	public ToJson  selectProjectId(HttpServletRequest request) {
		ToJson toJson = new ToJson(1,"err");
		try {
			SysPara sysPara = sysParaMapper.querySysPara("MYPROJECT");
			if(sysPara != null && !StringUtils.checkNull(sysPara.getParaValue())){
				toJson.setObject(sysPara.getParaValue());
			}
			toJson.setFlag(0);
			toJson.setMsg("OK");
		}catch (Exception e){
			toJson.setMsg(e.getMessage());
		}
		return toJson;
	}

	@Override
	public ToJson<Object> selectByParaName(String paraName) {
		ToJson toJson = new ToJson(1,"err");
		SysPara sysPara = sysParaMapper.querySysPara(paraName);
		if(sysPara != null){
			toJson.setFlag(0);
			toJson.setMsg("ok");
			toJson.setObject(sysPara.getParaValue());
		}
		return toJson;
	}

	/**
	 * 
	 * <p>Title: getIeTitle1</p>
	 * <p>Description: </p>
	 * @return
	 * @author(作者):  张丽军
	 * @see com.xoa.service.syspara.SysParaService#getIeTitle1()
	 */
	@Override
	public List<SysPara> getIeTitle1() {
		
		return sysParaMapper.getIeTitle1();
	}


    /**
     * 
     * <p>Title: updateSysPara</p>
     * <p>Description: </p>
     * @param sysPara
     * @author(作者):  张丽军
     * @see com.xoa.service.syspara.SysParaService#updateSysPara(com.xoa.model.common.SysPara)
     */
	@Override
	public void updateSysPara(SysPara sysPara) {
		
		sysParaMapper.updateSysPara(sysPara);
		
	}

	@Override
	public ToJson updateByParaName(SysPara sysPara) {
		ToJson json=new ToJson();
		sysPara.setParaName("PARTYER_MANAGE_USER");
		try {
			sysParaMapper.updateByParaName(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			e.printStackTrace();
			json.setFlag(1);
			json.setMsg("err");
		}
		return  json;
	}
	/**
	 * 创建人：刘景龙
	 * 创建时间：2021-07-14 10:54
	 * 方法介绍：判断当前用户是不是党群部人员
	 * 参数说明：
	 */
	@Override
	public ToJson selectByParaNames(HttpServletRequest request,String paraName) {
		ToJson json=new ToJson();
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		SysPara sysPara= null;
		try {
			sysPara = sysParaMapper.selectByParaNames("PARTYER_MANAGE_USER");
			if(!StringUtils.checkNull(sysPara.getParaValue())) {
				String[] split = sysPara.getParaValue().split(",");
				for (int i = 0; i < split.length; i++) {
					if (user.getUserId().equals(split[i])) {
						json.setMsg("ok");
						json.setFlag(0);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("err");
			json.setFlag(1);
		}
		return json;
	}
	/**
	 * 创建人：刘景龙
	 * 创建时间：2021-07-14 15:28
	 * 方法介绍：回显党群部姓名
	 * 参数说明：
	 */
	@Override
	public ToJson selectSysParaByParaName(String paraName) {
		StringBuffer sb=new StringBuffer();
			ToJson json=new ToJson();
			try {
				SysPara sysPara=sysParaMapper.selectByParaNames("PARTYER_MANAGE_USER");

				String[] split=sysPara.getParaValue().split(",");
				for(int i=0;i<split.length;i++){
					String name=usersMapper.getUsernameByUserId(split[i]);
					if(name!=null){
						sb.append(name+",");
					}
				}
				if (!StringUtils.checkNull(sb.toString())) {
					sysPara.setUserName(sb.substring(0,sb.length()-1));
				}
				json.setObject(sysPara);
				json.setFlag(0);
				json.setMsg("ok");
			} catch (Exception e) {
				e.printStackTrace();
				json.setFlag(1);
				json.setMsg("err");
			}
			return json;

	}


	@Override
	public ToJson updateSysParaPlus(SysPara sysPara) {
		ToJson json = new ToJson();
		int i = sysParaMapper.updateSysPara(sysPara);
		json.setMsg("ok");
		json.setFlag(0);
		return json;
	}
	/**
	 * 
	 * <p>Title: updateSysPara1</p>
	 * <p>Description: </p>
	 * @param sysPara
	 * @author(作者):  张丽军
	 * @see com.xoa.service.syspara.SysParaService#updateSysPara1(com.xoa.model.common.SysPara)
	 */
	@Override
	public void updateSysPara1(SysPara sysPara) {
		
		sysParaMapper.updateSysPara1(sysPara);
		
	}

    /**
     *
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/23 11:41
     * @函数介绍: 获取sys_para, 前端传入key, 获取对应value
     * @参数说明: @param paraName
     * @return: List<SysPara>
     */
    @Override
    public List<SysPara> getTheSysParam(String paraName) {

        return sysParaMapper.getTheSysParam(paraName);
    }

	@Override
	public ToJson<SysPara> getUserName(String paraName) {
		ToJson<SysPara> json =new ToJson<SysPara>();
		try {
			SysPara sysPara	= sysParaMapper.querySysPara(paraName);
			StringBuffer userName=new StringBuffer();
			StringBuffer userId=new StringBuffer();
			StringBuffer sb =new StringBuffer();
			 List<Users> usersList =new ArrayList<Users>();
			String name="";
		            if(sysPara!=null) {
						if (sysPara.getParaValue() != null) {
							String[] split = sysPara.getParaValue().split(",");
						/*	String [] split1=new String[split.length];*/
							for (String s : split) {
							String	Name = usersMapper.getUsernameById(s);
								Users byUid = usersMapper.getByUid(Integer.valueOf(s));
								String user_Id=byUid.getUserId();
							if(user_Id!=null&&user_Id!=""){
								userId.append(user_Id+",");
							}
								if(Name!=null && Name!=""){
								   Users userByuid = usersMapper.findUserByuid(Integer.valueOf(s));
								   usersList.add(userByuid);
								   sb.append(s+",");
							   userName.append(Name+",");
							   }
							}
						}
					}
					if(userName!=null && userName.toString()!=""){
						 name=userName.toString().substring(0,userName.toString().length()-1);
					}
					if(sb!=null){
						sysPara.setParaValue(sb.toString().substring(0,sb.toString().length()-1));
					}
          if(name!=null){
			  sysPara.setUserName(name.toString());
		  }
		  sysPara.setUserId(userId.toString());
			sysPara.setUsersList(usersList);
            json.setObject(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg("err");
			e.printStackTrace();
		}
        return json;
	}

	@Override
	public ToJson<Object> editSysPara(String usersIds) {
    	ToJson<Object> json =new ToJson<Object>();
		try {
			StringBuffer paraValue =new StringBuffer();
			if(usersIds!=null && usersIds!=""){
                String[] split = usersIds.split(",");
                List<Users> usersByUserIds = usersMapper.getUsersByUserIds(split);
                for(Users users:usersByUserIds){
                    Integer uid = users.getUid();
                    if(uid!=null){
                    paraValue.append(uid+",");
					}
                }
            }
			SysPara sysPara =new SysPara();
			sysPara.setParaName("MEETING_MANAGER_TYPE");
			sysPara.setParaValue(paraValue.toString());
			this.updateSysPara(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg("err");
			e.printStackTrace();
		}
		return json;
	}

	@Override
	public boolean checkIsHaveSecure(Users users, Integer type) {
		//获取所有操作权限
		Map<String, String> m = this.getAllSecureSwitch();
		if (!StringUtils.checkNull(m.get("switch")) && m.get("switch").equals("1")) {
			//获取所有管理规则
			Map<Integer, SecureRule> map = this.getAllSecureRule();
			SecureRule secureRule = map.get(type);
			if (secureRule.getSysRule().equals("1") && secureRule.getUseFlag().equals("1")) {
				//获取操作权限
				String rulePriv = this.getRulePriv(secureRule);
				if (!StringUtils.checkNull(m.get(rulePriv)) && m.get(rulePriv).contains(String.valueOf(users.getUid()))) {
					return true;
				} else {
					return false;
				}
			}
		} else {
			return true;
		}
		return false;
	}

	public Map<Integer,SecureRule> getAllSecureRule(){
		List<SecureRule> list = secureRuleMapper.getAllSecureRule();
		Map<Integer,SecureRule> map = new HashMap<Integer, SecureRule>();
		for (SecureRule secureRule : list){
			map.put(secureRule.getRuleId(),secureRule);
		}
		return map;
	}

	public Map<String,String> getAllSecureSwitch(){
		SysPara sysPara = sysParaMapper.querySysPara("SECURE_SWITCH");
		String paraValue = sysPara.getParaValue();
		Map<String, Object> param = new HashMap();
		JSONArray json = new JSONArray();
		param = json.parseObject(paraValue, Map.class);
		String swith = (String) param.get("swith");
		String syser = (String) param.get("syser");
		String safer = (String) param.get("safer");
		String audutor = (String) param.get("auditor");
		String userPriv = (String) param.get("userPriv");

		Map<String,String> map = new HashMap<String, String>();
		map.put("switch",swith);
		map.put("syser",syser);
		map.put("safer",safer);
		map.put("auditor",audutor);
		map.put("userPriv",userPriv);
		return map;
	}


	public String getRulePriv(SecureRule secureRule){
		//获取操作权限
		Integer rulePriv = secureRule.getRulePriv();
		if (rulePriv==1){
			return "syser";
		}
		if (rulePriv==2){
			return "safer";
		}
		if (rulePriv==3){
			return "auditor";
		}
		return null;
	}


	@Override
	public ToJson<Object> getStatus() {
		ToJson<Object> json =new ToJson<Object>(1,"err");
		SysPara status = sysParaMapper.getStatus();
		if(status!=null){
			String paraValue = status.getParaValue();
			Date date =new Date();
			SimpleDateFormat simpleDateFormat =new SimpleDateFormat("yyyy");
			String startTime = simpleDateFormat.format(date);
			int i = Integer.valueOf(startTime) + 1;
			String time =startTime+"-"+i;
			if(time.equals(paraValue)){
				json.setMsg("今年学生已经生过级");
				json.setFlag(0);
			}
		}
		return json;
	}


	/**
	 * @创建作者: 牛江丽
	 * @创建日期: 2017/9/26 17:19
	 * @函数介绍: 设置教务管理中的参数设置
	 * @参数说明: @param sysPara
	 * @return: json
	 **/
	public ToJson<SysPara> eduSetParam(String firstDate,String secondDate,String initPwd){
		ToJson<SysPara> json =new ToJson<SysPara>(1,"error");
		try{
			SysPara sysPara=new SysPara();
			sysPara.setParaName("SUMMER_VACATION_END");
			sysPara.setParaValue(firstDate);
			sysParaMapper.updateSysPara(sysPara);
			sysPara.setParaName("WINTER_VACATION_END");
			sysPara.setParaValue(secondDate);
			sysParaMapper.updateSysPara(sysPara);
			sysPara.setParaName("EDU_DEFAULT_PASSWORD");
			sysPara.setParaValue(initPwd);
			sysParaMapper.updateSysPara(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		}catch (Exception e){
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * @创建作者: 牛江丽
	 * @创建日期: 2017/9/26 17:19
	 * @函数介绍: 获取教务管理的参数
	 * @参数说明: @param sysPara
	 * @return: json
	 **/
	public AjaxJson selEduParam(){
		AjaxJson ajaxJson=new AjaxJson();
		ajaxJson.setFlag(false);
		ajaxJson.setMsg("error");
		try {
			Map<String,Object> map=new HashMap();
			List<SysPara> sysParaList=sysParaMapper.selEduParam();
			for(SysPara sysPara:sysParaList){
				map.put(sysPara.getParaName(),sysPara.getParaValue());
			}
			ajaxJson.setAttributes(map);
			ajaxJson.setFlag(true);
			ajaxJson.setMsg("ok");
		}catch (Exception e){
			e.printStackTrace();
		}
		return ajaxJson;
	}

	@Override
	public ToJson<Object> editOperator(String usersIds) {
		ToJson<Object> json =new ToJson<Object>();
		try {
			SysPara sysPara =new SysPara();
			sysPara.setParaName("OPERATOR_NAME");
			sysPara.setParaValue(usersIds);
			this.updateSysPara(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg("err");
			e.printStackTrace();
		}
		return json;
	}

	@Override
	public ToJson<SysPara> getOperator(String paraName) {
		ToJson<SysPara> json =new ToJson<SysPara>();
		try {
			SysPara sysPara	= sysParaMapper.querySysPara(paraName);
			StringBuffer userName=new StringBuffer();
			StringBuffer sb =new StringBuffer();
			List<Users> usersList =new ArrayList<Users>();
			String name="";
			if(sysPara!=null) {
				if (sysPara.getParaValue() != null) {
					String[] split = sysPara.getParaValue().split(",");
					for (String s : split) {
						Users byuserId = usersMapper.getUserId(s);
						if(byuserId!=null){
							String userName1 = byuserId.getUserName();
							usersList.add(byuserId);
							if(!StringUtils.checkNull(userName1)){
								sb.append(s+",");
								userName.append(userName1+",");
							}
						}
					}
				}
			}

			if(!StringUtils.checkNull(userName.toString())){
				name=userName.toString().substring(0,userName.toString().length()-1);
				sysPara.setUserName(name);
			}
			if(!StringUtils.checkNull(sb.toString())){
				sysPara.setParaValue(sb.toString().substring(0,sb.toString().length()-1));
			}
			sysPara.setEduUserList(usersList);
			json.setObject(sysPara);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg("err");
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 参数设置，不存在插入，存在更新
	 * @param sysPara
	 * @return
	 */
	public ToJson<Object> setSysPara(SysPara sysPara) {//免签人员用到NO_DUTY_USER，可以多处使用
		ToJson<Object> json =new ToJson<Object>();
		try {
			SysPara para=sysParaMapper.querySysPara(sysPara.getParaName());
			int count=0;
			if(para==null){
				count+=sysParaMapper.insertSysPara(sysPara);
			}else{
				count+=sysParaMapper.updateSysPara(sysPara);
			}
			if(count>0){
				json.setFlag(0);
				json.setMsg("ok");
			}
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg("err");
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 判断是否开启验证码
	 * 郭心雨
	 * @return
	 */
	public SysPara getSecGraphic(){
		return sysParaMapper.getSecGraphic();
	}

	@Override
	public ToJson<Object> selectDemo(SysPara sysPara) {
		ToJson<Object> json =new ToJson<Object>(1,"err");
		try {
			SysPara para=sysParaMapper.querySysPara(sysPara.getParaName());
			json.setFlag(0);
			json.setObject(para);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setMsg(e.getMessage());
			json.setFlag(1);
			e.printStackTrace();
		}
		return json;
	}

	@Override
	public ToJson<Object> checkDemo() {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			SysPara para=sysParaMapper.querySysPara("IS_CHECK_DEMO");
			if(para!=null){
				String paraValue = para.getParaValue();
				if(!StringUtils.checkNull(paraValue)){
					if(paraValue.equals("0")){
                     json.setFlag(1);
                     json.setMsg("err");
					}
				}
			}
		} catch (Exception e) {
			json.setFlag(0);
			json.setMsg(e.getMessage());
			e.printStackTrace();
		}
         return  json;
	}

	@Override
	public ToJson<Object> updatePersonnelSelectionRange(SysPara sysPara) {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			int count =sysParaMapper.updateSysPara(sysPara);
			if(count!=0){
				json.setFlag(1);
				json.setMsg("success");
			}else {
				json.setFlag(0);
				json.setMsg("erro");
			}
		} catch (Exception e) {
			json.setFlag(0);
			json.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return  json;
	}

	@Override
	public ToJson<Object> queryOrgScope() {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			SysPara sysPara = sysParaMapper.querySysPara("ORG_SCOPE");
			if(sysPara!=null){
				json.setObject(sysPara);
				json.setFlag(1);
				json.setMsg("success");
			}else {
				json.setFlag(0);
				json.setMsg("erro");
			}
		} catch (Exception e) {
			json.setFlag(0);
			json.setMsg(e.getMessage());
			e.printStackTrace();
		}
		return  json;
	}

	/**
	* 创建人: 海智
	* 创建时间: 2021-06-10 下午 14:19
	* 方法介绍: 查询NTKO授权信息
	* 参数说明:
	*/
	@Override
	public SysPara selectNtkoLicense() {
		return sysParaMapper.selectNtkoLicense();
	}

	/**
	* 创建人: 海智
	* 创建时间: 2021-06-22 上午 11:03
	* 方法介绍: 查询自定义告示栏
	* 参数说明:
	 * @return
	 */
	@Override
	public ToJson<Object> selectSysParaAtPortal(String title,String content) {
		ToJson toJson = new ToJson();
		try {
			Map<String,String> map=new HashMap<String,String>();
			SysPara noticeName = sysParaMapper.getSysParaPortal(title);
			SysPara noticeValue = sysParaMapper.getSysParaPortal(content);
			map.put("title",noticeName.getParaValue());
			map.put("content",noticeValue.getParaValue());
			toJson.setObject(map);
			toJson.setMsg("ok");
			toJson.setFlag(0);
		} catch (Exception e) {
			e.getMessage();
			toJson.setFlag(1);
			toJson.setMsg("error");
		}
		return toJson;
	}

	/**
	 * 创建人: 海智
	 * 创建时间: 2021-06-24 上午 10:05
	 * 方法介绍: 更新自定义告示栏 三个告示栏同时进行更新操作
	 * 参数说明:
	 */
	@Override
	public ToJson<Object> updateSysParaProtal(String title1, String content1,String title2, String content2,String title3, String content3) {
		ToJson<Object> json = new ToJson<Object>(1, "error");
		String	t1="PORTAL_NOTICE1_TITLE";
		String	t2="PORTAL_NOTICE2_TITLE";
		String	t3="PORTAL_NOTICE3_TITLE";
		String  c1="PORTAL_NOTICE1_CONTENT";
		String  c2="PORTAL_NOTICE2_CONTENT";
		String  c3="PORTAL_NOTICE3_CONTENT";
		try {
			SysPara sysPara1 = new SysPara();
			SysPara sysPara2 = new SysPara();
			SysPara sysPara3 = new SysPara();
			SysPara sysPara4 = new SysPara();
			SysPara sysPara5 = new SysPara();
			SysPara sysPara6 = new SysPara();
			//自定义告示栏1赋值
			sysPara1.setParaName(t1);
			sysPara1.setParaValue(title1);

			sysPara2.setParaName(c1);
			sysPara2.setParaValue(content1);
			//自定义告示栏2赋值
			sysPara3.setParaName(t2);
			sysPara3.setParaValue(title2);

			sysPara4.setParaName(c2);
			sysPara4.setParaValue(content2);
			//自定义告示栏3赋值
			sysPara5.setParaName(t3);
			sysPara5.setParaValue(title3);

			sysPara6.setParaName(c3);
			sysPara6.setParaValue(content3);
			//插入操作
			sysParaMapper.setSysParaProtal(sysPara1);
			sysParaMapper.setSysParaProtal(sysPara2);
			sysParaMapper.setSysParaProtal(sysPara3);
			sysParaMapper.setSysParaProtal(sysPara4);
			sysParaMapper.setSysParaProtal(sysPara5);
			sysParaMapper.setSysParaProtal(sysPara6);
			json.setFlag(0);
			json.setMsg("ok");
		} catch (Exception e) {
			json.setFlag(1);
			json.setMsg(e.getMessage());
			e.printStackTrace();
			json.setMsg("添加失败");
		}
		return json;
	}


	/**
	 * 创建人: hwx
	 * 创建时间:
	 * 方法介绍: 查询三个告示栏的标题和内容
	 * 参数说明:
	 */
	@Override
	public ToJson<Object> querySysParaProtal() {
		ToJson<Object> json = new ToJson<Object>(1, "error");
		String	t1="PORTAL_NOTICE1_TITLE";
		String	t2="PORTAL_NOTICE2_TITLE";
		String	t3="PORTAL_NOTICE3_TITLE";
		String  c1="PORTAL_NOTICE1_CONTENT";
		String  c2="PORTAL_NOTICE2_CONTENT";
		String  c3="PORTAL_NOTICE3_CONTENT";

		try {
			//根据PARA_NAME列表查询
			List<String> item = new ArrayList<>();
			item.add(t1);
			item.add(t2);
			item.add(t3);
			item.add(c1);
			item.add(c2);
			item.add(c3);
			List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);

			//组装成前端展示数据需要的格式
			Map<String,String> resMap1 = new HashMap<>();
			Map<String,String> resMap2 = new HashMap<>();
			Map<String,String> resMap3 = new HashMap<>();
			for (SysPara sysPara : sysParaList) {
				if (t1.equals(sysPara.getParaName())) {
					resMap1.put("title1",sysPara.getParaValue());
				}
				if (t2.equals(sysPara.getParaName())) {
					resMap2.put("title2",sysPara.getParaValue());
				}
				if (t3.equals(sysPara.getParaName())) {
					resMap3.put("title3",sysPara.getParaValue());
				}
				if (c1.equals(sysPara.getParaName())) {
					resMap1.put("content1",sysPara.getParaValue());
				}
				if (c2.equals(sysPara.getParaName())) {
					resMap2.put("content2",sysPara.getParaValue());
				}
				if (c3.equals(sysPara.getParaName())) {
					resMap3.put("content3",sysPara.getParaValue());
				}
			}
			List<Map<String,String>> resList = new ArrayList();
			resList.add(resMap1);
			resList.add(resMap2);
			resList.add(resMap3);
			json.setFlag(0);
			json.setMsg("ok");
			json.setObject(resList);
		} catch (Exception e) {
			L.e("SysParaServiceImpl.querySysParaProtal：",e);

			json.setFlag(1);
			json.setMsg(e.getMessage());
			json.setMsg("查询失败");
		}
		return json;
	}

	@Override
	public ToJson querySecrecySysPara(HttpServletRequest request) {
		ToJson<SysPara> json = new ToJson<SysPara>(1, "error");
		try {
			//根据PARA_NAME列表查询
			List<SysPara> sysParaList = sysParaMapper.querySecrecySysPara();
			for (SysPara sysPara : sysParaList) {
				if(!StringUtils.checkNull(sysPara.getParaValue().trim()) && ("SYSECURITY_MANAGE_PRIV".equals(sysPara.getParaName())
						|| "SYSECURITY_SECRECY_PRIV".equals(sysPara.getParaName()) || ("SYSECURITY_AUDIT_PRIV".equals(sysPara.getParaName())))){
					//根据角色ID查询角色名称
					UserPriv userPriv = userPrivMapper.getUserPriv(Integer.valueOf(sysPara.getParaValue()));
					sysPara.setUserName(userPriv.getPrivName());
				}
			}
			json.setFlag(0);
			json.setMsg("ok");
			json.setObj(sysParaList);
		} catch (Exception e) {
			e.printStackTrace();
			json.setFlag(1);
			json.setMsg(e.getMessage());
			json.setMsg("查询失败");
		}
		return json;
	}

	@Override
	public ToJson updateSecrecySysPara(String jsonStr, HttpServletRequest request) {
		ToJson toJson=new ToJson(1,"error");
		try{
			List<SysPara> list= new Gson().fromJson(jsonStr,new TypeToken<List<SysPara>>(){}.getType());
			//判断是否开启三员管理，开启三员管理需要同时设置三员的角色
			List<SysPara> paras = list.stream().filter(sysPara -> "IS_OPEN_SANYUAN".equals(sysPara.getParaName()) && "0".equals(sysPara.getParaValue())).collect(Collectors.toList());
			if(!Objects.isNull(paras) && paras.size() > 0 ){
				for(SysPara sysPara:list){
					if(("SYSECURITY_MANAGE_PRIV".equals(sysPara.getParaName()) && StringUtils.checkNull(sysPara.getParaValue()))
							|| ("SYSECURITY_SECRECY_PRIV".equals(sysPara.getParaName()) && StringUtils.checkNull(sysPara.getParaValue()))
							|| ("SYSECURITY_AUDIT_PRIV".equals(sysPara.getParaName()) && StringUtils.checkNull(sysPara.getParaValue()))){
						toJson.setMsg("开启三员管理需设置三员");
						return toJson;
					}
				}
			}
			for(SysPara sysPara:list){
				sysParaMapper.updateSysPara(sysPara);
			}
			toJson.setFlag(0);
			toJson.setMsg("ok");
		}catch (Exception e){
			e.printStackTrace();
		}
		return toJson;
	}

	@Override
	public BaseWrapper selAttendSetting() {
		BaseWrapper baseWrapper = new BaseWrapper();
		List<String> query = new ArrayList<>();
		query.add("ATTEND_FREE_USER");
		query.add("ATTEND_FREE_DEPT");
		query.add("ATTEND_FREE_PRIV");
		List<SysPara> sysParaList = sysParaMapper.getSysParaList(query);
		for (SysPara sysPara : sysParaList) {
			if("ATTEND_FREE_USER".equals(sysPara.getParaName())){
				if(!StringUtils.checkNull(sysPara.getParaValue())){
					List<Users> usersByUserIdsOrder = usersMapper.getUsersByUserIdsOrder(sysPara.getParaValue().split(","));
					StringBuilder sb = new StringBuilder();
					for (Users users : usersByUserIdsOrder) {
						sb.append(users.getUserName()).append(",");
					}
					sysPara.setUserName(sb.toString());
				}
			}
			if("ATTEND_FREE_DEPT".equals(sysPara.getParaName())){
				if(!StringUtils.checkNull(sysPara.getParaValue())){
					Map<String,Object> map = new HashMap<>();
					map.put("deptIds",sysPara.getParaValue().substring(0,sysPara.getParaValue().length()-1));
					List<Department> deptNameByIds = departmentMapper.getDeptNameByIds(map);
					StringBuilder sb = new StringBuilder();
					for (Department department : deptNameByIds) {
						sb.append(department.getDeptName()).append(",");
					}
					sysPara.setDeptName(sb.toString());
				}
			}
			if("ATTEND_FREE_PRIV".equals(sysPara.getParaName())){
				if(!StringUtils.checkNull(sysPara.getParaValue())){
					Map<String,Object> map = new HashMap<>();
					map.put("privIds",sysPara.getParaValue().substring(0,sysPara.getParaValue().length()-1));
					List<String> privNameByIds = userPrivMapper.getPrivNameByIds(map);
					StringBuilder sb = new StringBuilder();
					for (String privName : privNameByIds) {
						sb.append(privName).append(",");
					}
					sysPara.setPrivName(sb.toString());
				}
			}
		}
		baseWrapper.setTrue();
		baseWrapper.setData(sysParaList);
		return baseWrapper;
	}

	@Override
	public BaseWrapper updateAttendSetting(String attendFreeUserValue, String attendFreeDeptValue, String attendFreePrivValue) {
		BaseWrapper baseWrapper = new BaseWrapper();
		SysPara sysPara = new SysPara();
		sysPara.setParaName("ATTEND_FREE_USER");
		sysPara.setParaValue(attendFreeUserValue);
		sysParaMapper.updateSysPara(sysPara);
		sysPara.setParaName("ATTEND_FREE_DEPT");
		sysPara.setParaValue(attendFreeDeptValue);
		sysParaMapper.updateSysPara(sysPara);
		sysPara.setParaName("ATTEND_FREE_PRIV");
		sysPara.setParaValue(attendFreePrivValue);
		sysParaMapper.updateSysPara(sysPara);

		baseWrapper.setTrue();
		return baseWrapper;
	}

}
