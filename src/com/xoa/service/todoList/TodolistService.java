package com.xoa.service.todoList;

import com.xoa.model.daiban.Daiban;
import com.xoa.model.menu.SysFunction;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.servlet.http.HttpServletRequest;

public interface TodolistService {
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月23日 下午5:02:21
	 * 方法介绍:   根据userId 查询待办
	 * 参数说明:   @param userId 用户Id
	 * 参数说明    @param sqlType
	 * 参数说明:   @return
	 * @return     返回待办信息
	 */
	public Daiban list(String userId, String sqlType, HttpServletRequest request)throws Exception;
	/**
	 * 创建作者:   王曰岐
	 * 创建日期:   2017年6月23日 下午5:02:21
	 * 方法介绍:   根据userId 查询待办
	 * 参数说明:   @param userId 用户Id
	 * 参数说明    @param sqlType
	 * 参数说明:   @return
	 * @return     返回已办信息
	 */

	public Daiban readList(String userId, String sqlType, HttpServletRequest request)throws Exception;


	public Daiban readTotal(String userId, String sqlType, HttpServletRequest request,String superfluity)throws Exception;


	public BaseWrapper readHaveMsgList(String classification,String userId, String sqlType, HttpServletRequest request) throws Exception;


	public BaseWrapper readHaveList(String classification,String userId, String sqlType, HttpServletRequest request) throws Exception;

	
	public Daiban delete(Integer qid,String type);


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:32:22
	 * 方法介绍:   根据userId进行模糊查询
	 * 参数说明:   @param userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public ToJson<Users> queryUserByUserId(String userName,HttpServletRequest request);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午10:35:22
	 * 方法介绍:   根据userId进行模糊查询,查询出符合条件的数量
	 * 参数说明:   @param  userId
	 * 参数说明:
	 * @return List<SUsers>  返回用户信息
	 */
	public ToJson<Users> queryCountByUserId(String userName);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:29:22
	 * 方法介绍:   根据子菜单名称进行模糊查询
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return List<SysFunction>  返回子菜单信息
	 */
	public ToJson<SysFunction> getSysFunctionByName(String funName,HttpServletRequest request);
	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年6月27日 下午14:30:12
	 * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
	 * 参数说明:   @param funName
	 * 参数说明:
	 * @return List<SysFunction>  查询数
	 */
	public ToJson<SysFunction> getCountSysFunctionByName(String funName);
	public BaseWrapper smsListByType(String userId, HttpServletRequest request, String type);

	public BaseWrapper getUserFunctionByUserId(String userId, HttpServletRequest request);

	public BaseWrapper getWillDocSendOrReceive(String userId,String documentType, HttpServletRequest request);

	/**
	 * PC端事务提醒
	 * @param userId
	 * @param request
	 * @return
	 */
	public BaseWrapper smsListByTypeByPC(String userId, HttpServletRequest request);

	/**
	 * PC端事务提醒数量
	 * @param userId
	 * @param request
	 * @return
	 */
	public BaseWrapper smsListCountByPC(String userId, HttpServletRequest request);

    BaseWrapper smsListByPowerChina(String userId, HttpServletRequest request, String type);

    Daiban readPowerChina(String userId, String sqlType, HttpServletRequest request, String superfluity) throws Exception;
}
