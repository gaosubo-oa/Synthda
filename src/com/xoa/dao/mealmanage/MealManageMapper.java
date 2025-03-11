package com.xoa.dao.mealmanage;

import com.xoa.model.mealmanage.MealManage;

import java.util.List;
import java.util.Map;

public interface MealManageMapper {

    //根据ID删除
    int deleteByPrimaryKey(Integer mealId);

    //添加
    int insertSelective(MealManage record);

    //根据ID查询
    MealManage selectByPrimaryKey(Integer mealId);

    //修改
    int updateByPrimaryKeySelective(MealManage record);

    //条件查询
    List<MealManage> getMealMap(Map map);

    //统计早餐  中餐
    MealManage getCount(Map map);
}