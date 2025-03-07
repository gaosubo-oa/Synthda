package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesAttendancePriv;

import java.util.List;
import java.util.Map;

public interface WagesAttendancePrivMapper {
    int addAttendancePriv(WagesAttendancePriv wagesAttendancePriv);

    int deleteAttendancePriv(Integer attendancePriv);

    int updateAttendancePriv(WagesAttendancePriv wagesAttendancePriv);

    List<WagesAttendancePriv> selectAllAttendancePriv(Map<String, Object> map);

}
