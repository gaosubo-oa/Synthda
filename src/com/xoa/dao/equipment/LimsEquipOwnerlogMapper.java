package com.xoa.dao.equipment;

import com.xoa.model.equipment.LimsEquipOwnerlog;
import com.xoa.model.equipment.LimsEquipOwnerlogExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LimsEquipOwnerlogMapper {

    List<LimsEquipOwnerlog> transferData(Map map);
    int transferDataCount(Map map);
    //查询设备接收列表
    List<LimsEquipOwnerlog> selectRceInfo(Map map);
    //检验是否存在重复提交
    List<LimsEquipOwnerlog> checkChooseEquip(Map map);
    //根据审批状态查询信息
    List<LimsEquipOwnerlog> selectOwnerLog(Map map);
    //删除申请信息
    int delBylogId(Map map);
    //修改申请状态
    int updStatus(Map map);

    int contInfo(Map map);

    List<LimsEquipOwnerlog> AdminastorList(Map map);
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int countByExample(LimsEquipOwnerlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int deleteByExample(LimsEquipOwnerlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer ownerlogId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int insert(LimsEquipOwnerlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int insertSelective(LimsEquipOwnerlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    List<LimsEquipOwnerlog> selectByExample(LimsEquipOwnerlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    LimsEquipOwnerlog selectByPrimaryKey(Integer ownerlogId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") LimsEquipOwnerlog record, @Param("example") LimsEquipOwnerlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") LimsEquipOwnerlog record, @Param("example") LimsEquipOwnerlogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(LimsEquipOwnerlog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_ownerlog
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(LimsEquipOwnerlog record);
}