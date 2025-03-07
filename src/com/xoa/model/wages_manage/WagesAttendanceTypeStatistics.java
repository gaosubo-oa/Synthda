package com.xoa.model.wages_manage;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/12/2
 * 说明   ：   考勤类型统计
 */
public class WagesAttendanceTypeStatistics {
    private String typeCode;//考勤类型
    private Integer attendanceTypeCount;//考勤类型数量

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public Integer getAttendanceTypeCount() {
        return attendanceTypeCount;
    }

    public void setAttendanceTypeCount(Integer attendanceTypeCount) {
        this.attendanceTypeCount = attendanceTypeCount;
    }
}
