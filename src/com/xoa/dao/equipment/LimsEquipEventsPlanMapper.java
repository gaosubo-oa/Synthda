package com.xoa.dao.equipment;

import com.xoa.model.equipment.LimsEquipEventsPlan;
import com.xoa.model.equipment.LimsEquipEventsPlanExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LimsEquipEventsPlanMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int countByExample(LimsEquipEventsPlanExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int deleteByExample(LimsEquipEventsPlanExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer eventId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int insert(LimsEquipEventsPlan record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int insertSelective(LimsEquipEventsPlan record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    List<LimsEquipEventsPlan> selectByExample(LimsEquipEventsPlanExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    LimsEquipEventsPlan selectByPrimaryKey(Integer eventId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") LimsEquipEventsPlan record, @Param("example") LimsEquipEventsPlanExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") LimsEquipEventsPlan record, @Param("example") LimsEquipEventsPlanExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(LimsEquipEventsPlan record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_events_plan
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(LimsEquipEventsPlan record);
    /** 创建作者:   王穗穗
     * 创建日期:   11:40 2019/9/7
     * 方法介绍:   获取设备属于检定校准信息
     */
    LimsEquipEventsPlan geteventExpire(Map map);

    int deleteByIds(@Param("ids") String[] ids);

    int updateByIds(Map map);

    List<LimsEquipEventsPlan> selectAll(Map map);

    Integer selectCount(Map map);

    List<LimsEquipEventsPlan> queryAll(String eventType);

    LimsEquipEventsPlan geteventExpireEET(Map map);
}