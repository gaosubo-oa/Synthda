package com.xoa.dao.equipment;


import com.xoa.model.equipment.LimsDeptLocation;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface LimsDeptLocationMapper {

    int countSort(Integer pid);

    int countChild(Integer id);

    List<LimsDeptLocation> sortList(Map map);

    List<LimsDeptLocation> findParentLocation(Integer deptId);

    List<LimsDeptLocation> findChildLocation(Integer pid);

    int deleteByPrimaryKey(Integer id);

    int insert(LimsDeptLocation record);

    int insertSelective(LimsDeptLocation record);

    LimsDeptLocation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(LimsDeptLocation record);

    int updateByPrimaryKey(LimsDeptLocation record);

    List<LimsDeptLocation> findLocationName(@Param("deptId") Integer deptId, @Param("positionName") String positionName);

   List<LimsDeptLocation> selectAllLocation();
}