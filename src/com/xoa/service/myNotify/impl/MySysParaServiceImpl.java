package com.xoa.service.myNotify.impl;

import com.alibaba.fastjson.JSONArray;
import com.xoa.controller.myNotify.MyNotifyConfig;
import com.xoa.dao.common.SecureRuleMapper;
import com.xoa.dao.myNotify.MySysParaMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SecureRule;
import com.xoa.model.common.SysPara;
import com.xoa.model.myNotify.MySysPara;
import com.xoa.model.users.Users;
import com.xoa.service.myNotify.MySysParaService;
import com.xoa.service.syspara.SysParaService;
import com.xoa.util.AjaxJson;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
public class MySysParaServiceImpl implements MySysParaService {

	@Resource
	private MySysParaMapper mySysParaMapper;
	@Resource
	private UsersMapper usersMapper;
	@Resource
	private SecureRuleMapper secureRuleMapper;
    /**
     *
     * <p>Title: getIeTitle</p>
     * <p>Description: </p>
     * @return
     * @author(作者):  张丽军
     * @see SysParaService#getIeTitle()
     */
	@Override
	public List<MySysPara> getIeTitle() {

		return mySysParaMapper.getIeTitle();
	}

	/**
	 *
	 * <p>Title: getIeTitle</p>
	 * <p>Description: </p>
	 * @return
	 * @author(作者):  张丽军
	 * @see SysParaService#getIeTitle()
	 */
	@Override
	public List<MySysPara> getVersion(String specifyTable) {

		return mySysParaMapper.getVersion();
	}
	/**
	 *
	 * <p>Title: getIeTitle</p>
	 * <p>Description: </p>
	 * @return
	 * @author(作者):  张丽军
	 * @see SysParaService#getIeTitle()
	 */
	@Override
	public List<MySysPara> getVersionIos(String specifyTable) {

		return mySysParaMapper.getVersionIos();
	}

	@Override
	public MySysPara getSelectPassword(String specifyTable) {
		return mySysParaMapper.getSelectPassword();
	}

	@Override
	public Map<String,String>  selectSysPCAI(HttpServletRequest request,String specifyTable) {
		Map<String,String> list = new HashMap<>();
		MySysPara sysPara1 = mySysParaMapper.selectSysPCAI(request);
		MySysPara sysPara2 = mySysParaMapper.selectSysPCAI2(request);
		MySysPara sysPara3 = mySysParaMapper.selectSysPCAI3(request);

		list.put(sysPara1.getParaName(),sysPara1.getParaValue());
		list.put(sysPara2.getParaName(),sysPara2.getParaValue());
		list.put(sysPara3.getParaName(),sysPara3.getParaValue());


		return list;
	}

	@Override
	public ToJson  selectProjectId(HttpServletRequest request,String specifyTable) {
		ToJson toJson = new ToJson(1,"err");
		MySysPara sysPara = mySysParaMapper.querySysPara("MYPROJECT");
		if(sysPara != null && !StringUtils.checkNull(sysPara.getParaValue())){
			toJson.setFlag(0);
			toJson.setObject(sysPara.getParaValue());
		}
		return toJson;
	}

	@Override
	public ToJson<Object> selectByParaName(String paraName,String specifyTable) {
		ToJson toJson = new ToJson(1,"err");
		MySysPara sysPara = mySysParaMapper.querySysPara(paraName);
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
	 * @see SysParaService#getIeTitle1()
	 */
	@Override
	public List<MySysPara> getIeTitle1() {

		return mySysParaMapper.getIeTitle1();
	}


    /**
     *
     * <p>Title: updateSysPara</p>
     * <p>Description: </p>
     * @param sysPara
     * @author(作者):  张丽军
     * @see SysParaService#updateSysPara(SysPara)
     */
	@Override
	public void updateSysPara(MySysPara sysPara,String specifyTable) {

		try {
			/**
			 * 根据前端传入的参数获得要操作的模块表名
			 */
			MyNotifyConfig myNotifyConfig = new MyNotifyConfig();
			ToJson notifyType = myNotifyConfig.getNotifyType(specifyTable);
			Map data = (Map) notifyType.getData();
			//String tableName = (String) data.get("mynotice_table");//模块表名
			String mynoticeDates = (String) data.get("mynotice_top_dates");
			sysPara.setParaName(mynoticeDates);

			MySysPara mySysPara = mySysParaMapper.selectByParaName(sysPara);
			if(mySysPara!=null){
				int i = mySysParaMapper.updateSysPara(sysPara);
				System.out.println(111);
			}else {
				mySysParaMapper.insertSysPara(sysPara);
			}
		}catch (Exception e){
			System.out.println(e);
		}


	}

	@Override
	public ToJson updateSysParaPlus(MySysPara sysPara,String specifyTable) {
		ToJson json = new ToJson();
		int i = mySysParaMapper.updateSysPara(sysPara);
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
	 * @see SysParaService#updateSysPara1(SysPara)
	 */
	@Override
	public void updateSysPara1(MySysPara sysPara,String specifyTable) {

		mySysParaMapper.updateSysPara1(sysPara);

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
    public List<MySysPara> getTheSysParam(String paraName,String specifyTable) {

        return mySysParaMapper.getTheSysParam(paraName);
    }

	@Override
	public ToJson<MySysPara> getUserName(String paraName,String specifyTable) {
		ToJson<MySysPara> json =new ToJson<MySysPara>();
		try {
			MySysPara sysPara	= mySysParaMapper.querySysPara(paraName);
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
	public ToJson<Object> editSysPara(String usersIds,String specifyTable) {
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
			MySysPara sysPara =new MySysPara();
			sysPara.setParaName("MEETING_MANAGER_TYPE");
			sysPara.setParaValue(paraValue.toString());
			this.updateSysPara(sysPara,specifyTable);
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
	public boolean checkIsHaveSecure(Users users, Integer type,String specifyTable) {
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
		MySysPara sysPara = mySysParaMapper.querySysPara("SECURE_SWITCH");
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
	public ToJson<Object> getStatus(String specifyTable) {
		ToJson<Object> json =new ToJson<Object>(1,"err");
		MySysPara status = mySysParaMapper.getStatus();
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
	public ToJson<MySysPara> eduSetParam(String firstDate,String secondDate,String initPwd,String specifyTable){
		ToJson<MySysPara> json =new ToJson<MySysPara>(1,"error");
		try{
			MySysPara sysPara=new MySysPara();
			sysPara.setParaName("SUMMER_VACATION_END");
			sysPara.setParaValue(firstDate);
			mySysParaMapper.updateSysPara(sysPara);
			sysPara.setParaName("WINTER_VACATION_END");
			sysPara.setParaValue(secondDate);
			mySysParaMapper.updateSysPara(sysPara);
			sysPara.setParaName("EDU_DEFAULT_PASSWORD");
			sysPara.setParaValue(initPwd);
			mySysParaMapper.updateSysPara(sysPara);
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
	public AjaxJson selEduParam(String specifyTable){
		AjaxJson ajaxJson=new AjaxJson();
		ajaxJson.setFlag(false);
		ajaxJson.setMsg("error");
		try {
			Map<String,Object> map=new HashMap();
			List<MySysPara> sysParaList=mySysParaMapper.selEduParam();
			for(MySysPara sysPara:sysParaList){
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
	public ToJson<Object> editOperator(String usersIds,String specifyTable) {
		ToJson<Object> json =new ToJson<Object>();
		try {
			MySysPara sysPara =new MySysPara();
			sysPara.setParaName("OPERATOR_NAME");
			sysPara.setParaValue(usersIds);
			this.updateSysPara(sysPara,specifyTable);
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
	public ToJson<MySysPara> getOperator(String paraName,String specifyTable) {
		ToJson<MySysPara> json =new ToJson<MySysPara>();
		try {
			MySysPara sysPara	= mySysParaMapper.querySysPara(paraName);
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
	 * @param
	 * @return
	 */
	public ToJson<Object> setSysPara(MySysPara sysPara,String specifyTable) {//免签人员用到NO_DUTY_USER，可以多处使用
		ToJson<Object> json =new ToJson<Object>();
		try {
			MySysPara para=mySysParaMapper.querySysPara(sysPara.getParaName());
			int count=0;
			if(para==null){
				count+=mySysParaMapper.insertSysPara(sysPara);
			}else{
				count+=mySysParaMapper.updateSysPara(sysPara);
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
	public MySysPara getSecGraphic(String specifyTable){
		return mySysParaMapper.getSecGraphic();
	}

	@Override
	public ToJson<Object> selectDemo(MySysPara sysPara,String specifyTable) {
		ToJson<Object> json =new ToJson<Object>(1,"err");
		try {

			MySysPara para=mySysParaMapper.querySysPara(sysPara.getParaName());
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
	public ToJson<Object> checkDemo(String specifyTable) {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			MySysPara para=mySysParaMapper.querySysPara("IS_CHECK_DEMO");
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
	public ToJson<Object> updatePersonnelSelectionRange(MySysPara sysPara,String specifyTable) {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			int count =mySysParaMapper.updateSysPara(sysPara);
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
	public ToJson<Object> queryOrgScope(String specifyTable) {
		ToJson<Object> json =new ToJson<>(0,"ok");
		try {
			MySysPara sysPara = mySysParaMapper.querySysPara("ORG_SCOPE");
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

}
