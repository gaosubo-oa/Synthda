package com.xoa.service.calendar;

import com.xoa.model.calender.Calendar;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;
import com.yirong.exchange.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface CalendarService {
	public List<Calendar> getschedule(int calTime,int endTime, String userId);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月4日 下午5:24:26
	 * 方法介绍:   根据userId 查询日程安排
	 * 参数说明:   @param Map<String, Object> maps 用户userId和当天时间戳
	 * 参数说明:   @return
	 * @return     List<Calendar>  返回日程安排
	 */
	public List<Calendar> getscheduleBycId(String userId) ;
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年6月12日 下午5:24:26
	 * 方法介绍:   根据userId 和当前时间查询日程安排
	 * 参数说明:	userId 当前用户userId
	 * 参数说明:	calTime 当前时间
	 * 参数说明:   @return
	 * @return     List<Calendar>  返回日程安排
	 */
	public List<Calendar> getscheduleBycId(String userId,String calTime);
	
	 /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:46:54
     * 方法介绍:   新增日程安排
     * 参数说明:   @param record 日程安排
     * 参数说明:   @return
     * @return     int 插入条数
     */
	public void insertSelective(Calendar record,HttpServletRequest request);
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月5日 下午6:17:56
	 * 方法介绍:   根据calId删除日程安排
	 * 参数说明:   @param calId 主键
	 * @return     void 无
	 */
	public void delete(int calId,HttpServletRequest request);
	
	/**
	 * 创建作者:   张龙飞
	 * 创建日期:   2017年5月8日 下午5:41:36
	 * 方法介绍:   修改
	 * 参数说明:   @param calendar
	 * @return     void  无
	 */
	public int update(Calendar calendar);
	
	public List<Calendar> getscheduleByDay(String userId,String calTime);

	public List<Calendar> getAllschedule(String userId) ;

	/**
	 * 创建作者:   张丽军
	 * 创建日期:   2017年7月5日 下午5:24:26
	 * 方法介绍:   根据deptId 查询日程安排
	 * 参数说明:   @param Map<String, Object> maps 部门deptId
	 * 参数说明:   @return
	 * @return     List<Calendar>  返回日程安排
	 */
    public List<Calendar> getAllscheduleinfo(Integer deptId);


	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月19日 下午13:57:26
	 * 方法介绍:   根据userId 和当前时间查询日程安排，查询参与者和所属者的日程安排
	 * 参数说明:	userId 当前用户userId
	 * 参数说明:	calTime 当前时间
	 * 参数说明:   @return
	 * @return     List<Calendar>  返回日程安排
	 */
	public List<Calendar> getscheduleByTakerAndOwner(HttpServletRequest request,String userId,Calendar calendar);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月20日 下午13:08:18
	 * 方法介绍:   查询整个日程安排信息
	 * 参数说明:   @param calendar
	 * @return     List
	 */
	public ToJson<Calendar> getScheduleByUserIdAndType(HttpServletRequest request);

	/**
	 * 创建作者:   牛江丽
	 * 创建日期:   2017年7月20日 下午13:08:18
	 * 方法介绍:   用户日程安排查询，根据时间和部门进行查询
	 * 参数说明:   @param calendar
	 * @return     List
	 */
	public ToJson<Calendar> getAllScheduleByDeptIdAndDate(HttpServletRequest request,String userId,String deptId);

	public   List<Calendar> rChSelect();

	/**
	 * @作者: 张航宁
	 * @时间: 2019/8/22
	 * @说明: 根据id查看详情
	 */
	ToJson<Calendar> selCalenderById(Integer calId);

	/**
	 * 创建作者: 刘建
	 * 创建日期: 2020-08-03 10:34
	 * 方法介绍: 查询领导日程
	 * @param logUserId
	 * @param userId
	 * @return java.util.List<com.xoa.model.calender.Calendar>
	 */
	List<Calendar> getLeaderSchedule(String logUserId, String userId, Users users);

	/**
	 * 创建作者: 刘建
	 * 创建日期: 2020-08-03 10:34
	 * 方法介绍: 按照月查询领导日程
	 * @param logUserId
	 * @param userId
	 * @return java.util.List<com.xoa.model.calender.Calendar>
	 */
	List<Calendar> getLeaderScheduleMonth( String logUserId,String userId,String calTime,String type);
}
