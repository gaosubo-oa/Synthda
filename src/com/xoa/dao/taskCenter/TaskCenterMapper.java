package com.xoa.dao.taskCenter;

import com.xoa.model.taskCenter.TaskCenter;
import com.xoa.model.taskCenter.TaskCenterExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TaskCenterMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int countByExample(TaskCenterExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int deleteByExample(TaskCenterExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer taskId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int insert(TaskCenter record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int insertSelective(TaskCenter record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    List<TaskCenter> selectByExample(TaskCenterExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    TaskCenter selectByPrimaryKey(Integer taskId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") TaskCenter record, @Param("example") TaskCenterExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") TaskCenter record, @Param("example") TaskCenterExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(TaskCenter record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table task_center
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(TaskCenter record);

    //分页获取所有待办数据
    List<TaskCenter> getTaskCenters(Map<String, Object> map);

    //分页获取所有待办数量
    int getTaskCentersCount(Map<String, Object> map);

    //按月统计任务数量接口--全局
   int  getGlobalMonthCount(Map<String, Object> map);

    //按月统计任务数量接口--个人
    int  getpersonalMonthCount(Map<String, Object> map);

    //按月统计任务办理时限接口--全局
    double  getpersonalMonthPrescription(Map<String, Object> map);

    //获取当前月份的数据统计分析，（单个月中的不同业务模块分析）
    List<TaskCenter> analysisByMonthAndMenu(Map<String, Object> map);


    int removeTaskCenter(TaskCenter record);
}