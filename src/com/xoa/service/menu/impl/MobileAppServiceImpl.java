package com.xoa.service.menu.impl;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.menu.MobileAppMapper;
import com.xoa.dao.menu.SysFunctionMapper;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.Users;
import com.xoa.service.menu.MobileAppService;
import com.xoa.service.users.UserFunctionService;
import com.xoa.service.users.UsersService;
import com.xoa.util.Constant;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

    /**
     * 
     * 创建作者:   王曰岐
     * 创建日期:   2017-4-18 下午6:24:33
     * 类介绍  :    APP端菜单Service实现类
     * 构造参数:   无
     *
     */
@SuppressWarnings("all")
@Service
public class MobileAppServiceImpl implements MobileAppService {

	@Resource 
	private MobileAppMapper mobileAppMapper;//APP菜单DAO
	
	@Resource 
	private SysParaMapper sysParaMapper;//APP权限DAO

	@Resource
	private UsersService usersService;
		@Resource
		private UserFunctionService userFunctionService;
		@Resource
		private SysFunctionMapper sysFunctionMapper;


		/**
	 * 
	 * 创建作者:   王曰岐
	 * 创建日期:   2017-4-18 下午6:25:43
	 * 方法介绍:   得到APP端菜单集合
	 * 参数说明:   @return
	 * @return     List  返回菜单集合List
	 */
	@Override
	public List getMobileAppList(HttpServletRequest request) {

		//1、获取当前登录用户权限
		Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
		Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
		Integer uid = users.getUid();
/*
        //users里没有这个属性，要查询出来
        String userPriv = usersService.getUserPrivByuId(uid);*/

		//用户菜单权限=该用户所具有权限，不考虑角色表
		//该用户所具有权限
		String userFunctionStr = userFunctionService.getUserFunctionStrById(uid);
		String[] funcIds = userFunctionStr.split(",");


		String  ids=sysParaMapper.getSysPara();
		String[] firstIds = ids.split(",");
		List<String>  a11=new ArrayList<String>();
		for (int o = 0; o < firstIds.length; o++) {
			for( int k = 0; k < funcIds.length; k++) {
				if(firstIds[o].equals(funcIds[k])){
					a11.add(firstIds[o]);
				}
             }

		}
	//	String[] twoIds = ids.substring(ids.indexOf("|")+1, ids.length()).split(",");
		List<SysFunction> mList= sysFunctionMapper.getAll();
		List<List> mList1=new ArrayList<List>();
		List<SysFunction> list1 = new ArrayList<SysFunction>();

		//List<MobileApp> list2 = new ArrayList<MobileApp>();
		for (int j = 0; j < a11.size(); j++) {
			for (int i=0; i<mList.size(); i++) {
				//System.out.println(mList.get(j).getfId());
				if (mList.get(i).getfId().toString().equals(a11.get(j))) {
					list1.add(mList.get(i));
					break; 
				}
			}
		}
		Iterator<SysFunction> it = list1.iterator();
		while(it.hasNext()){
			SysFunction x = it.next();
			if(x.getName().contains(Constant.mobileFunction)){
				it.remove();
			}
		}
	/*	for (int j = 0; j < twoIds.length; j++) {
			for (int i=j; i<mList.size(); i++) {  
				System.out.println(mList.get(j).getAppId());
				if (mList.get(i).getAppId().toString().equals(twoIds[j])) {
					list2.add(mList.get(i));
					break; 
				}
			}
			
		}*/
	Object local = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
	String locale="zh_CN";
	if(local == null){
		locale="zh_CN";
	}else {
		locale=local.toString();
	}

	  if(list1!=null&&list1.size()>0){
         for(SysFunction sysFunction:list1){
			 if (locale.equals("zh_CN")) {
				 sysFunction.setName(sysFunction.getName());
			 } else if (locale.equals("en_US")) {
				 sysFunction.setName(sysFunction.getName1());
			 } else if (locale.equals("zh_TW")) {
				 sysFunction.setName(sysFunction.getName2());
			 }

		 }
     	}
		mList1.add(list1);
		/*if (list2.size()>0) {
			mList1.add(list2);
		}*/
		return list1;
	}

}
