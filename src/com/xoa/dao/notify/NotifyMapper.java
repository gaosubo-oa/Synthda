package com.xoa.dao.notify;

import com.xoa.dao.base.BaseMapper;
import com.xoa.model.department.Department;
import com.xoa.model.notify.Notify;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;


/**
 *
 * 创建作者:   张丽军
 * 创建日期:   2017-4-19 上午11:39:21
 * 类介绍  :   公告接口类
 * 构造参数:   无
 *
 */
public interface NotifyMapper extends BaseMapper<Notify>{

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:39:53
	 * 方法介绍:   条件公告信息查询并返回
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	List<Notify> selectNotify(Map<String,Object> maps);

	List<Notify> querySubject(Map<String,Object> map);
	List<String> queryFile(Map<String,Object> map);
	Integer selectCountNumNotify(Map<String,Object>maps);

	List<Notify> selectCountNotify(Map<String,Object> maps);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:40:09
	 * 方法介绍:   条件公告管理信息查询并返回
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	public List<Notify> selectNotifyManage(Map<String, Object> maps);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:40:09
	 * 方法介绍:   条件公告管理信息查询并返回
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	public Integer selectCountNotifyManage(Map<String, Object> maps);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:40:18
	 * 方法介绍:   未读信息
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	public List<Notify> unreadNotify(Map<String, Object> maps);

	List<Notify> unreadNotifyPlus(Map<String, Object> maps);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:40:18
	 * 方法介绍:   已读信息
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     List<Notify>
	 */
	public List<Notify> readNotify(Map<String, Object> maps);
	public List<Notify> readNotifyPlus(Map<String, Object> maps);
	/**
	 *
	 * @Title: getNotifyById
	 * @Description: 根据ID获取对象
	 * @author(作者):   张丽军
	 * @date(日期):        2017-4-18 上午9:34:56
	 * @param: @param id
	 * @param: @return
	 * @return: List<Notify>
	 * @throws
	 */
	List<Notify> getNotifyById(String id);

	Notify getNotifyById(Integer id);



	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:41:09
	 * 方法介绍:   公告详情信息
	 * 参数说明:   @param maps
	 * 参数说明:   @return
	 * @return     Notify
	 */
	public Notify detailedNotify(Map<String, Object> maps);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:41:35
	 * 方法介绍:   新增公告信息
	 * 参数说明:   @param notify
	 * @return     void
	 */
	int addNotify (Notify notify);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午10:29:05
	 * 方法介绍:   更新一条信息
	 * 参数说明:   @param notify
	 * @return     void
	 */
	void updateReaders(Notify notify);
	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:42:49
	 * 方法介绍:   更新公告信息
	 * 参数说明:   @param notify
	 * @return     void
	 */
	int  updateNotify (Notify notify);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:42:49
	 * 方法介绍:   更新公告信息
	 * 参数说明:   @param notify
	 * @return     void
	 */
	int  newUpdateNotify (Notify notify);

	int updatePublish(Notify notify);

	/**
	 *
	 * 创建作者:   张丽军
	 * 创建日期:   2017-4-19 上午11:43:11
	 * 方法介绍:   根据ID删除一条公告信息
	 * 参数说明:   @param notifyId
	 * @return     void
	 */
	public void deleteById(@Param("notifyId") Integer notifyId);


	void deleteByids(String [] ids);

	int updateByIds(@Param("top") String top,@Param("ids") String [] ids);

	/**
	 *
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:40:00
	 * 方法介绍:   查询出发布公告的所有部门
	 * 参数说明:   @param notify
	 * @return     Department
	 */
	public List<Department> getNotifyGroupFromDept(Map<String, Object> map);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据发布公告的部门查询出该部门中发布公告的人数
	 * 参数说明:   @param fromDept发布部门
	 * @return     int  查询出来的数量
	 */
	public int getCountByFromDept(Notify notify);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:48:00
	 * 方法介绍:   根据发布公告的部门查询出该部门中发布公告的用户
	 * 参数说明:   @param notify
	 * @return    Notify
	 */
	public List<Notify> getNotifyByFromDept(Notify notify);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据发布公告的部门和发布公告的用户查询出发布公告的数量
	 * 参数说明:   @param notify
	 * @return    int
	 */
	public int getCountByFromIdAndDept(Notify notify);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据发布公告的部门和发布公告的用户查询出所发布的公告
	 * 参数说明:   @param notify
	 * @return    Notify
	 */
	public List<Notify> getNotifyByFromIdAndDept(Notify notify);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017-7-11 下午13:45:00
	 * 方法介绍:   根据公告id进行查询公告
	 * 参数说明:   @param notifyId
	 * @return    Notify
	 */
	public Notify getNotifyByNotifyId(Integer notifyId);

	/**
	 * @author:杨超
	 * @函数说明：按照类型统计通知信息
	 * @创建时间: 2017/08/15
	 */

	public List<Notify> selectByType();

	/**
	 * @Description: 根据公告类型查询已审批公告信息
	 * @author:  刘新婷
	 * @date:  2017-11-21
	 * @param typeId
	 * @param start
	 * @param size
	 * @return
	 */
	public List<Notify> selectApprovedNotifyByTypeId(Map<String,Object> map);

	/**
	 * @Description: 根据公告类型查询待审批公告信息
	 * @author:  刘新婷
	 * @date:  2017-11-22
	 * @param typeId
	 * @param start
	 * @param size
	 * @return
	 */
	public List<Notify> selectPendingNotifyByTypeId(Map<String,Object> map);

	 List<Notify> selectNotifyEndTime(@Param("dateTime") String dateTime);

	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2018年3月15日 下午17:32:22
	 * 方法介绍:   根据subject进行模糊查询公告通知信息
	 * 参数说明:   @param subject
	 * 参数说明:
	 *
	 */
    List<Notify> queryNotifyBySubject(String trim);

    int updateTop(Notify notify);

    List<Notify> queryPublishTop(Map<String,Object>map);

	int updatePublishByBeginDate(Notify notify);

	int updatePublishBySendTime(Notify notify);

	int updatePublishByEndDate(Notify notify);

	int  updateNotifyStatus(Notify notify);

	int newUpdateTop(Notify notify);

    List<Notify> getAll();

    void updateDate(Notify notify);

    List<Notify> selectNotifyOverTime(Map<String, Object> maps);

	void updateNotifys(Notify notify);

	Notify selectById(Integer notifyId);

	List<Notify> selectTop();
}