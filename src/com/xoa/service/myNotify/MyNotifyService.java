package com.xoa.service.myNotify;

import com.xoa.model.common.AppLog;
import com.xoa.model.department.Department;
import com.xoa.model.myNotify.MyNotify;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import com.xoa.util.common.wrapper.BaseWrapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * 创建作者:   张丽军
 * 创建日期:   2017-4-18 下午11:58:21
 * 类介绍  :   公告接口
 * 构造参数:   无
 *
 */
public interface MyNotifyService {

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-18 下午11:59:41
	 * 方法介绍:   查询公告信息
	 * 参数说明:   @param maps  map条件参数
	 * 参数说明:   @param page  当前页
	 * 参数说明:   @param pageSize  每页显示条数
	 * 参数说明:   @param useFlag   是否开启分页插件
	 * 参数说明:   @param name
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<Notify>
	 */

	public ToJson<MyNotify>  selectNotify(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, Users users, String specifyTable) throws Exception;


	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午12:03:43
	 * 方法介绍:   查询公告管理信息
	 * 参数说明:   @param maps
	 * 参数说明:   @param page
	 * 参数说明:   @param pageSize
	 * 参数说明:   @param useFlag
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<Notify>
	 */
	public ToJson<MyNotify> selectNotifyManage(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType,String specifyTable) throws Exception;
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午12:03:54
	 * 方法介绍:   未读信息
	 * 参数说明:   @param maps
	 * 参数说明:   @param page
	 * 参数说明:   @param pageSize
	 * 参数说明:   @param useFlag
	 * 参数说明:   @param name
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<Notify>
	 */
	public ToJson<MyNotify>  unreadNotify(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType,String specifyTable) throws Exception;
	public ToJson<MyNotify>  unreadNotifyPlus(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType,String specifyTable) throws Exception;
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午12:03:54
	 * 方法介绍:   已读信息
	 * 参数说明:   @param maps
	 * 参数说明:   @param page
	 * 参数说明:   @param pageSize
	 * 参数说明:   @param useFlag
	 * 参数说明:   @param name
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     List<Notify>
	 */
	public ToJson<MyNotify>  readNotify(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType,String specifyTable) throws Exception;
	public ToJson<MyNotify>  readNotifyPlus(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType,String specifyTable) throws Exception;
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:48:39
	 * 方法介绍:   根据ID获取公告信息
	 * 参数说明:   @param id
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	public List<MyNotify> getNotifyById(String id,String specifyTable);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:49:31
	 * 方法介绍:   更新公告信息
	 * 参数说明:   @param
	 * @return     void
	 */
	public  void updateNotify(MyNotify notify, String remind, String tuisong, HttpServletRequest request, String approve,String specifyTable);


	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:49:31
	 * 方法介绍:   更新公告信息
	 * 参数说明:   @param
	 * @return     void
	 */
	public  void upNewdateNotify(MyNotify notify, String remind, String tuisong, HttpServletRequest request, String approve,String specifyTable);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:51:03
	 * 方法介绍:   根据ID获取一条公告信息
	 * 参数说明:   @param id
	 * 参数说明:   @return
	 * @return     Notify
	 */
	public MyNotify getNotifyById(Integer id,String specifyTable);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:51:20
	 * 方法介绍:   新增公告信息
	 * 参数说明:   @param notify
	 * @return     void
	 */
	public  int addNotify(MyNotify notify, String remind, String tuisong, HttpServletRequest request, String approveRemind,String specifyTable);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:51:31
	 * 方法介绍:   删除公告信息
	 * 参数说明:   @param notifyId
	 * @return     void
	 */
	public void delete(Integer notifyId,String specifyTable);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:51:50
	 * 方法介绍:   根据ID查找公告详情
	 * 参数说明:   @param maps
	 * 参数说明:   @param page
	 * 参数说明:   @param pageSize
	 * 参数说明:   @param useFlag
	 * 参数说明:   @param name
	 * 参数说明:   @return
	 * 参数说明:   @throws Exception
	 * @return     Notify
	 */
	public MyNotify queryById(Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag, String name, String sqlType, String changId,String specifyTable) throws Exception;


	public ToJson<MyNotify> deleteByids(String[] newsId,String specifyTable);

	void  queryDeleteByStaleDated();

	public ToJson<MyNotify> updateByids(String[] newsId, String top,String specifyTable);

	public ToJson<MyNotify> ConsultTheSituationNotify(String newsId, HttpServletRequest request,String specifyTable);

	/**
	 *
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:40:00
	 * 方法介绍:   查询出发布公告的所有部门
	 * 参数说明:   @param notify
	 * @return     Department
	 */
	public ToJson<Department> getNotifyGroupFromDept(MyNotify notify,String specifyTable);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:48:00
	 * 方法介绍:   根据发布公告的部门查询出该部门中发布公告的用户
	 * 参数说明:   @param notify
	 * @return    MyNotify
	 */
	public ToJson<MyNotify> getNotifyByFromDept(MyNotify notify,String specifyTable);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据发布公告的部门和发布公告的用户查询出所发布的公告
	 * 参数说明:   @param notify
	 * @return    MyNotify
	 */
	public ToJson<MyNotify> getNotifyByFromIdAndDept(MyNotify notify,String specifyTable);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据公告id进行查询公告
	 * 参数说明:   @param notifyId
	 * @return    Notify
	 */
	public ToJson<MyNotify> getNotifyByNotifyId(Integer notifyId,String specifyTable);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月12日 下午11:16:00
	 * 方法介绍:   公告统计信息导出
	 */
	public  ToJson<MyNotify> outputNotify(int step, MyNotify notify, HttpServletRequest request, HttpServletResponse response,String specifyTable);
	/**
	 * @author:杨超
	 * @函数说明：按照类型统计通知信息
	 * @创建时间: 2017/08/15
	 */
	public BaseWrapper selectByType(String specifyTable);

	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2018年3月15日 下午17:32:22
	 * 方法介绍:   根据subject进行模糊查询公告通知信息
	 * 参数说明:   @param subject
	 * 参数说明:
	 *
	 */
	ToJson<MyNotify> queryNotifyBySubject(String trim,String specifyTable);


	public  int saveApplog4Notify(AppLog appLog,String specifyTable);

	/**
	 * @author:杨超
	 * @函数说明：按照类型统计通知信息
	 * @创建时间: 2017/08/15
	 */
	public ToJson updateTopstatus(MyNotify notify, HttpServletRequest request,String specifyTable);

	//解决升级问题（部分数据会出现不支持HTML格式，后台统一处理一下数据格式）
	ToJson<MyNotify> updateDate(HttpServletRequest request,String specifyTable);

	ToJson<MyNotify> selectNotifyOverTime(Map<String, Object> maps, Integer page, Integer pageSize, Boolean useFlag, Integer userPriv, String userId,String specifyTable);

	//公告一键已读
	public ToJson readNotify(HttpServletRequest request,String specifyTable);

	//办公门户待批公告
	public ToJson approveNotify(HttpServletRequest request,String specifyTable);

    void updateTop(String specifyTable);
}
