package com.xoa.dao.equipment;

import com.xoa.model.equipment.LimsEquipEventlog;
import com.xoa.model.equipment.LimsEquipEventlogExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LimsEquipEventlogMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int countByExample(LimsEquipEventlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int deleteByExample(LimsEquipEventlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer eventLogId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int insert(LimsEquipEventlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int insertSelective(LimsEquipEventlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    List<LimsEquipEventlog> selectByExample(LimsEquipEventlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    LimsEquipEventlog selectByPrimaryKey(Integer eventLogId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") LimsEquipEventlog record, @Param("example") LimsEquipEventlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") LimsEquipEventlog record, @Param("example") LimsEquipEventlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(LimsEquipEventlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_eventlog
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(LimsEquipEventlog record);

    List<LimsEquipEventlog> selectAll(Map map);

    LimsEquipEventlog selectLastByEventId(Integer eventId);

    List<LimsEquipEventlog> queryAll(Map map);
}