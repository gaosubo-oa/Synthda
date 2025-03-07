package com.xoa.dao.attendance.attendanceway;

public interface AttendanceWayMapper {
    //获取考勤方式字段
    public String getDutyMachine();
    //修改考勤方式
    public int updateDutyMachine(String dutyMachine);

}
