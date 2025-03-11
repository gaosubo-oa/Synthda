package com.xoa.dao.sys;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SysDataBaseMapper {

    // 获取系统中的表数据
    // tableSchema = 库名 如xoa1001
    List<Map<String,Object>> selSysTables(@Param("tableSchema") String tableSchema,@Param("searchValue")  String searchValue);
}
