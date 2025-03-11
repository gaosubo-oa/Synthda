package com.xoa.dao.attend;

import com.xoa.model.attend.AttendFlowRunPrcs;
import com.xoa.model.attend.AttendLeave;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AttendLeaveMapper {

    AttendLeave queryAttendLeave(@Param("userId") String userId,@Param("date") String date);

    AttendLeave selectAttendLeave(@Param("userId") String userId,@Param("date") String date);

    List<AttendLeave> selectAttendLeaveModify(@Param("userId") String userId,@Param("date") String date);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017-7-14 下午14:45:00
     * 方法介绍:   查询请假登记
     */
    List<AttendFlowRunPrcs> queryAllAttendLeave(Map<String, Object> objectMap);


    List<AttendLeave> queryAllAttendLeaveFields(Map<String,Object> maps);

    /**
     * 左春晖
     * 导出请假信息
     */
    List<AttendLeave> queryAttendLeaves(Map<String,Object> map);
    /**
     * 添加
     * @param attendLeave
     * @return
     */
    int addAttendLeave(AttendLeave attendLeave);

    /**
     * 修改
     * @param attendLeave
     * @return
     */

    int updateAttendLeave(AttendLeave attendLeave);

    List<AttendFlowRunPrcs> backlogAttendList(Map<String, Object> maps);

    List<AttendFlowRunPrcs> haveDoneAttendList(Map<String, Object> maps);

    List<AttendLeave> getAllByDate(Map<String,Object> Maps);

    List<AttendLeave> selectAttendLeaveByUserId(String userId);

    List<AttendLeave>  getAttendLeaveCount(@Param("year") String year);

    List<AttendLeave> selLeaveByDate(Map<String, Object> maps);

    List<AttendLeave> selectAttendLeaveList(@Param("userId") String userId,
                                            @Param("beginDate")String beginDate,
                                            @Param("endDate") String endDate);

    List<AttendLeave> selAttendLeaveByUserId(String userId);

    //获取当日所属统计
    List<AttendLeave> getAttendLeaveByDateAndUids(Map map);

    //获取已经批准的假期
    List<AttendLeave> getAttendLeaveListByMap(Map map);

    AttendLeave selectAttendByRunId(@Param("runId") Integer runId);

    int deleteAttendKey(@Param("leaveId") Integer leaveId);

}