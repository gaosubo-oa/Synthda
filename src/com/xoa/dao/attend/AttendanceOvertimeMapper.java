package com.xoa.dao.attend;

import com.xoa.model.attend.AttendanceOvertime;
import com.xoa.model.attend.AttendanceOvertimeFlowRunPrcs;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AttendanceOvertimeMapper {

    List<AttendanceOvertime> queryAttendanceOvertime(@Param("userId") String userId,@Param("date") String date);

     AttendanceOvertime  selectAttendanceOvertime(@Param("userId") String userId,@Param("date") String date);

    /**
     * 添加
     * @param attendanceOvertime
     * @return
     */
     int  insertSelective(AttendanceOvertime attendanceOvertime);

    /**
     * 修改
     * @param attendanceOvertime
     * @return
     */
     int updateByExampleSelective(AttendanceOvertime attendanceOvertime);

    List<AttendanceOvertime> queryAttendanceOvertimeByUserId(String userId);

    List<AttendanceOvertimeFlowRunPrcs> queryAllAttendanceOvertime(Map<String, Object> objectMap);

    List<AttendanceOvertime> selectAttendanceOvertimeList(@Param("userId") String userId,
                                                 @Param("beginDate")String beginDate,
                                                 @Param("endDate") String endDate);

    int deleteAttendanceOvertimeById(Integer overtimeId);

    List<AttendanceOvertime> selectAttendanceOvertimeByUserId(@Param("userId")String userId);

    List<AttendanceOvertime> selAttendanceOvertimeByUserId(@Param("userId")String userId);

    List<AttendanceOvertime> getAttendanceOvertimeListByMap(Map map);

}