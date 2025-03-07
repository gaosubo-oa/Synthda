package com.xoa.dao.organization;

import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface DeptMapper {


    @Select("select DEPT_ID as deptId,DEPT_NAME as deptName,DEPT_NO as deptNo,DEPT_PARENT as deptParent from department where DEPT_PARENT=#{deptId} order by dept_no")
    public List<Map<String,Object>> list(Integer deptId);

    @Select("select DEPT_ID as deptId,DEPT_NAME as deptName,DEPT_NO as deptNo,DEPT_PARENT as deptParent from department where DEPT_ID=#{deptId}")
    public Map<String,Object> get(Integer deptId);


}
