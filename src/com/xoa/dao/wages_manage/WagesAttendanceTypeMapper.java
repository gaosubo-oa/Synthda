package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesAttendanceType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WagesAttendanceTypeMapper {
    List<WagesAttendanceType> selectByUserId(Map<String, Object> map);

    int updateConfirm(Integer attendTypeId);

    int insert(WagesAttendanceType wagesAttendanceType);

    int insertAll(List<WagesAttendanceType> wagesAttendanceTypeList);

    List<WagesAttendanceType> selectAllAttendanceDate(Map<String, Object> map);

    List<WagesAttendanceType> selectAllYear(Map<String, Object> map);

    WagesAttendanceType selectOneByAttendTypeId(@Param("attendTypeId") Integer attendTypeId);

    int deleteAttendanceType(@Param("attendTypeId") Integer attendTypeId);

    int updateAttendanceType(WagesAttendanceType wagesAttendanceType);

    int insertSelective(WagesAttendanceType wagesAttendanceType);

    int deleteByDate(@Param("theYear") String theYear,@Param("theMonth") String theMonth);

}
