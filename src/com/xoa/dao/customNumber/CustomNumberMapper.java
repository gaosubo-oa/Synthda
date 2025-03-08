package com.xoa.dao.customNumber;

import com.xoa.model.customNumber.CustomNumber;
import com.xoa.model.customNumber.CustomNumberExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CustomNumberMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int countByExample(CustomNumberExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int deleteByExample(CustomNumberExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int insert(CustomNumber record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int insertSelective(CustomNumber record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    List<CustomNumber> selectByExample(CustomNumberExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    CustomNumber selectByPrimaryKey(Integer uuid);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") CustomNumber record, @Param("example") CustomNumberExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") CustomNumber record, @Param("example") CustomNumberExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(CustomNumber record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table custom_number
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(CustomNumber record);
}