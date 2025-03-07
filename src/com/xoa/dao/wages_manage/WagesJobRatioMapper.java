package com.xoa.dao.wages_manage;

import com.xoa.model.wages_manage.WagesJobRatio;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 创建作者:   金帅强
 * 创建时间:   2021/11/30
 * 说明   ：   月考勤数据（薪岗比例）子表
 */
public interface WagesJobRatioMapper {
    int addJobRatio(WagesJobRatio wagesJobRatio);

    int deleteJobRatio(Integer jobRatioId);

    int updateJobRatio(WagesJobRatio wagesJobRatio);

    List<WagesJobRatio> selectAllJobRatio(Map<String, Object> map);

    WagesJobRatio selectRatioByAttendTypeId(@Param("attendTypeId") Integer attendTypeId);

    int deleteJobRatioByAttendanceTypeId(@Param("attendTypeId") Integer attendTypeId);
}
