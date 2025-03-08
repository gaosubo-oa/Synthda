package com.xoa.dao.equipment;

import com.xoa.model.equipment.Equipment;
import com.xoa.model.equipment.LimsEquipExperience;
import com.xoa.model.equipment.LimsEquipExperienceExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface LimsEquipExperienceMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int countByExample(LimsEquipExperienceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int deleteByExample(LimsEquipExperienceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer experId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int insert(LimsEquipExperience record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int insertSelective(LimsEquipExperience record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    List<LimsEquipExperience> selectByExample(LimsEquipExperienceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    LimsEquipExperience selectByPrimaryKey(Integer experId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") LimsEquipExperience record, @Param("example") LimsEquipExperienceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") LimsEquipExperience record, @Param("example") LimsEquipExperienceExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(LimsEquipExperience record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table lims_equip_experience
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(LimsEquipExperience record);

    /*
     *分页查询所有经验库
     * param map
     * return List<LimsEquipExperience>
     */
    List<LimsEquipExperience> selectAllEquipmentExperience(Map map);

    //查询所有经验库
    List<LimsEquipExperience> selectAllExperience();

    //查询experience所有数据总数 根据ExperId查询
    int countAllExperience();

    //通过experId查询
    LimsEquipExperience selectEquipmentByExperId(int experId);

    //通过选择的字段名以及输入的值模糊查询
    List<LimsEquipExperience> selectEquipExperienceByName(Map<String, String> map);

    //通过experId删除数据
    int delExperienceByExperId(int experId);

    //根据条件筛选经验库
    List<LimsEquipExperience> selectExperienceByCondition(Map map);

    //添加经验库
    int addExperience(LimsEquipExperience equipExperience);


    //根据equipNo查询Equip信息
    Equipment getEquipByNo(String equipNo);

    //根据下拉字段和值模糊查询--统计数量count
    int getCountByField(Map<String, String> map);

    //根据设备id统计数量
    int getCountByEquipId(int equipId);

    //修改经验库
    int editExperience(LimsEquipExperience limsEquipExperience);

    //根据设备编号查询经验库
    List<LimsEquipExperience> getEquipByEquipId(int equipId);

    //返回最大Id查找出的经验代码
    String getLastExperNo();

    //根据设备类型查询经验哭
    List<LimsEquipExperience>  getExperienceByEquipType(Map map);
}