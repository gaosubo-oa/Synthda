package com.xoa.dao.trainingPlan;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xoa.model.trainingPlan.EduTrainingPlan;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
  * 培训计划 Mapper 接口
 * </p>
 *
 * @author ZLF
 * @since 2017-09-07
 */
public interface EduTrainingPlanMapper extends BaseMapper<EduTrainingPlan> {

     EduTrainingPlan getTraindetailById(int trainId);

    List<EduTrainingPlan> getAll(Map<String, Object> map);

     void editTrain(EduTrainingPlan eduTrainingPlan);

     void deleteObject(@Param("planIds") String[] planIds);

     void deleteObjectById(String planId);

     int addTrain(EduTrainingPlan eduTrainingPlan);

     List<EduTrainingPlan> queryTrain(Map<String, Object> map);

     int getCount();

     List<EduTrainingPlan> getEduTrainByStatus(Map<String, Object> map);

     void editEduTrainByStatus(EduTrainingPlan eduTrainingPlan);

     List<EduTrainingPlan>QueryPlan(Map<String, Object> map);

     List<EduTrainingPlan>QueryPlanStatus(Map<String, Object> map);

     List<EduTrainingPlan>getMinePlanByStatus(Map<String, Object> map);

    List<EduTrainingPlan> getAllPlan();

    List<EduTrainingPlan> getAllPlanTrue();


}