package com.xoa.dao.equipment;

import com.xoa.model.equipment.EquipmentCapys;

import java.util.List;
import java.util.Map;

public interface EquipmentCapysMapper {

    List<EquipmentCapys> selectCapysToModelJson(Map map);

    List<EquipmentCapys> selectAll();

    List<EquipmentCapys> selectByCapyId(Integer capyId);

    List<EquipmentCapys> selectByEquipId(Integer equipId);
    List<EquipmentCapys> selectByEquipIdandtypeCode(Map map);


    int countEquipmentBcapyId(Integer capyId);

    int countEquipmentByEquipId(Integer equipId);


    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    int deleteByEquipIdAndCapyId(Map map);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    int insert(EquipmentCapys record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    int insertSelective(EquipmentCapys record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    EquipmentCapys selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(EquipmentCapys record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_capys
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(EquipmentCapys record);
}