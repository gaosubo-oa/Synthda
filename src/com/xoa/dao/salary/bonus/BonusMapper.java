package com.xoa.dao.salary.bonus;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BonusMapper {
    //添加
    int insertHead(Map<String, Object> map);
    //查询奖金、工资全部表头
    List<Map> queryBonusAll(@Param("wageDifference")String wageDifference,@Param("headId")String headId,@Param("uId")Integer uId);
    //删除
    int deleteBMs(Map map);
}