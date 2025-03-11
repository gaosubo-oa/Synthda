package com.xoa.dao.wages_manage;




import com.xoa.model.wages_manage.WagesSalaryData;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WagesSalaryDataMapper {
    int deleteById(Integer salaryDataId);

    int insert(WagesSalaryData wagesSalaryData);

    WagesSalaryData selectById(Integer salaryDataId);

    List<WagesSalaryData> selectAll(Map<String, Object> map);

    int update(WagesSalaryData wagesSalaryData);

    int insertSelective(WagesSalaryData record);

    List<WagesSalaryData> selectPastAssessmentRetained(Map<String, String> map);

    void deleteByAttendanceType(Map<String, Object> map);
    int deleteByDate(@Param("theYear") String theYear, @Param("theMonth") String theMonth);
}
