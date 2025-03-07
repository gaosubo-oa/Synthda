package com.xoa.dao.wages_manage;


import com.xoa.model.wages_manage.WagesEmployeeSalary;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WagesEmployeeSalaryMapper {
    int deleteById(Integer salaryId);

    int insert(WagesEmployeeSalary wagesEmployeeSalary);

    WagesEmployeeSalary selectById(Integer salaryId);

    List<WagesEmployeeSalary> selectAll(Map<String, Object> map);

    int update(WagesEmployeeSalary wagesEmployeeSalary);

    WagesEmployeeSalary selectOne(Map<String, Object> map);

    List<WagesEmployeeSalary> selectEmployeeSalary(@Param("userId") String userId);

    int updateSal();
}
