package com.xoa.dao.calendar;

import com.xoa.model.calender.Calendar;

import java.util.List;
import java.util.Map;

 /**
 * 创建作者:   张龙飞
 * 创建日期:   2017年5月5日 下午6:19:35
 * 类介绍  :   
 * 构造参数:   
 *
 */
public interface CalendarMapper {
	
	
    int insert(Calendar record);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:46:54
     * 方法介绍:   新增日程安排
     * 参数说明:   @param record 日程安排
     * 参数说明:   @return
     * @return     void 无
     */
    void insertSelective(Calendar record);
    
    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:24:08
     * 方法介绍:   根据日程安排的起始和结束时间查询日程
     * 参数说明:   @param maps 起始和结束时间
     * 参数说明:   @return
     * @return     List<Calendar> 返回日程安排
     */
    List<Calendar> getschedule(Map<String, Object> maps);
    
    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 下午5:24:15
     * 方法介绍:   根据userId 查询日程安排
     * 参数说明:   @param userId 用户userId
     * 参数说明:   @return
     * @return     List<Calendar> 返回日程安排
     */
    List<Calendar> getscheduleBycId(Map<String, Object> maps);
    
    
    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月5日 下午6:19:39
     * 方法介绍:   根据calId删除
     * 参数说明:   @param calId
     * @return     void 无
     */
    void delete(int calId);

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月8日 下午6:09:18
     * 方法介绍:   修改
     * 参数说明:   @param calendar
     * @return     void 无
     */
    int update(Calendar calendar);
    
    List<Calendar> getscheduleByDay(Map<String, Object> maps);


     List<Calendar> getAllschedule(Map<String, Object> maps);

     List<Calendar> getAllscheduleinfo(Map<String,Object> maps);

     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据userId 和当前时间查询日程安排，查询参与者和所属者的日程安排
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getscheduleByTakerAndOwner(Map<String,Object> maps);
     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据userId 和当前时间查询日程安排，查询参与者和所属者的日程安排(今天)
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getscheduleByTakerAndOwnerDay(Map<String,Object> maps);
     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据userId 和当前时间查询日程安排（今天）
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getscheduleByUserIdDay(Map<String,Object> maps);


     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据userId 和当前时间查询日程安排（月）
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getscheduleByUserId(Map<String,Object> maps);

     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据userId获取所有的日程安排
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getAllScheduleByUserId(Map<String,Object> maps);


     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   根据参与者和所属者获取所有的日程安排
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getAllScheduleByTakerAndOwner(Map<String,Object> maps);

     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月19日 下午14:45:18
      * 方法介绍:   查询整个日程安排信息
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getScheduleByUserIdAndType(String userId);

     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月20日 下午13:08:18
      * 方法介绍:   用户日程安排查询，根据所属者着和参与者进行查询
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> queryAllScheduleByTakerAndOwner(Map<String,Object> maps);

     /**
      * 创建作者:   牛江丽
      * 创建日期:   2017年7月20日 下午13:08:18
      * 方法介绍:   用户日程安排查询，当admin为所属者或者参与者的查询
      * 参数说明:   @param calendar
      * @return     List
      */
     List<Calendar> getAllScheduleByAdmin(String userId);

     /**
      * 查询满足日程安排时间
      * @param
      * @return
      */
     List<Calendar> rChSelect();


     Calendar selCalendarById(int calId);


     List<Calendar>  getscheduleBycIds(Map<String,Object>map);

     List<Calendar>  selectBySubject(Map<String,Object>map);
 }