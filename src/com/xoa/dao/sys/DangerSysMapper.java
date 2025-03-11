package com.xoa.dao.sys;

import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by pfl on 2017/7/4.
 */
public interface DangerSysMapper {
    void truncateTable(@Param("tableName") String tableName);

    void deleteUsers();

    List<Integer> getFileContentBySortType(@Param("sortType")Integer sortType);
    List<Integer> getFileContentBySortZero();

    int deleteFileContent(List<Integer> contentIds);

    int deleteFileBox(@Param("sortType")Integer sortType);
}
