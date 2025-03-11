package com.xoa.model.wages_manage;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/11/26
 * 说明   ：   考勤类型
 */
public class WagesAttendanceRecord {
    private Integer attendanceRecordId;//自增
    private String attendanceRecordClassify;//考勤分类(SYS_CODE)
    private String attendanceRecordType;//考勤类型(类型名称)
    private String typeCode;//类型代号
    private String formula;//计算公式
    private String remarks;//备注
    private String attendanceRecordClassifyName;//考勤分类名称

    public Integer getAttendanceRecordId() {
        return attendanceRecordId;
    }

    public void setAttendanceRecordId(Integer attendanceRecordId) {
        this.attendanceRecordId = attendanceRecordId;
    }

    public String getAttendanceRecordClassify() {
        return attendanceRecordClassify;
    }

    public void setAttendanceRecordClassify(String attendanceRecordClassify) {
        this.attendanceRecordClassify = attendanceRecordClassify;
    }

    public String getAttendanceRecordType() {
        return attendanceRecordType;
    }

    public void setAttendanceRecordType(String attendanceRecordType) {
        this.attendanceRecordType = attendanceRecordType;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getFormula() {
        return formula;
    }

    public void setFormula(String formula) {
        this.formula = formula;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public String getAttendanceRecordClassifyName() {
        return attendanceRecordClassifyName;
    }

    public void setAttendanceRecordClassifyName(String attendanceRecordClassifyName) {
        this.attendanceRecordClassifyName = attendanceRecordClassifyName;
    }
}
