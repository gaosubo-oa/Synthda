package com.xoa.dao.users;

import com.xoa.model.users.CAccountinfo;
import com.xoa.model.users.CAccountinfoExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CAccountinfoMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int countByExample(CAccountinfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int deleteByExample(CAccountinfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(String personId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int insert(CAccountinfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int insertSelective(CAccountinfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    List<CAccountinfo> selectByExample(CAccountinfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    CAccountinfo selectByPrimaryKey(String personId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") CAccountinfo record, @Param("example") CAccountinfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") CAccountinfo record, @Param("example") CAccountinfoExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(CAccountinfo record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table c_accountinfo
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(CAccountinfo record);
}