package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesAttendanceJob;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/11/30
 * 说明   ：   月考勤数据（薪岗）子表
 */
public interface WagesAttendanceJobMapper {
    int addAttendanceJob(WagesAttendanceJob wagesAttendanceJob);

    int deleteAttendanceJob(Integer attendJobId);

    int updateAttendanceJob(WagesAttendanceJob wagesAttendanceJob);

    List<WagesAttendanceJob> selectAllAttendanceJob(Map<String, Object> map);

    WagesAttendanceJob selectOneByAttendTypeId(@Param("attendTypeId") Integer attendTypeId);

    int deleteAttendanceJobByAttendanceTypeId(@Param("attendTypeId") Integer attendTypeId);
}
