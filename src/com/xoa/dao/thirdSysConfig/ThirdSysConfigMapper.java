package com.xoa.dao.thirdSysConfig;

import com.xoa.model.thirdSysConfig.ThirdSysConfig;
import com.xoa.model.thirdSysConfig.ThirdSysConfigExample;
import com.xoa.model.thirdSysConfig.ThirdSysConfigWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ThirdSysConfigMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int countByExample(ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int deleteByExample(ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer sysId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int insert(ThirdSysConfigWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int insertSelective(ThirdSysConfigWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    List<ThirdSysConfigWithBLOBs> selectByExampleWithBLOBs(ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    List<ThirdSysConfig> selectByExample(ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    ThirdSysConfigWithBLOBs selectByPrimaryKey(Integer sysId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") ThirdSysConfigWithBLOBs record, @Param("example") ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") ThirdSysConfigWithBLOBs record, @Param("example") ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") ThirdSysConfig record, @Param("example") ThirdSysConfigExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(ThirdSysConfigWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(ThirdSysConfigWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table third_sys_config
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(ThirdSysConfig record);

    //根据系统名称获取数据
    ThirdSysConfigWithBLOBs selectBySysName(@Param("sysName") String sysName);

    // 查询配置数据
    ThirdSysConfigWithBLOBs getThirdSysConfig(@Param("para1") String para1, @Param("para2") String para2);
}