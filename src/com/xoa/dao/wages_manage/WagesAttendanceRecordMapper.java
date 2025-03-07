package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesAttendanceRecord;

import java.util.List;
import java.util.Map;

public interface WagesAttendanceRecordMapper {
    int addAttendanceRecord(WagesAttendanceRecord wagesAttendanceRecord);

    int deleteAttendanceRecordById(Integer attendanceRecordId);

    int updateAttendanceRecord(WagesAttendanceRecord wagesAttendanceRecord);

    List<WagesAttendanceRecord> selectAllAttendanceRecord(Map<String, Object> map);

    WagesAttendanceRecord selectById(Integer attendanceRecordId);

    List<WagesAttendanceRecord> selectAll();
}
