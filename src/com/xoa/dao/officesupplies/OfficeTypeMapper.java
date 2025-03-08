package com.xoa.dao.officesupplies;

import com.xoa.model.officesupplies.OfficeType;
import com.xoa.model.officesupplies.OfficeTypeExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OfficeTypeMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int countByExample(OfficeTypeExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int deleteByExample(OfficeTypeExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int insert(OfficeType record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int insertSelective(OfficeType record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    List<OfficeType> selectByExample(OfficeTypeExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    OfficeType selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") OfficeType record, @Param("example") OfficeTypeExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") OfficeType record, @Param("example") OfficeTypeExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(OfficeType record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_type
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(OfficeType record);

    OfficeType selectByName(String typeName);

    List<OfficeType> selectDownObject(String typeDepository);

    OfficeType selectOffTypeByProType(String officeProtype);

    OfficeType selectByDepositoryIdAndName(@Param("id")String id, @Param("typeName")String typeName);
}