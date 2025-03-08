package com.xoa.dao.kg;

import com.xoa.kg.model.KgRelationKeyUser;
import com.xoa.kg.model.KgRelationKeyUserExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface KgRelationKeyUserMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int countByExample(KgRelationKeyUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int deleteByExample(KgRelationKeyUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer keyUserId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int insert(KgRelationKeyUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int insertSelective(KgRelationKeyUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    List<KgRelationKeyUser> selectByExample(KgRelationKeyUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    KgRelationKeyUser selectByPrimaryKey(Integer keyUserId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") KgRelationKeyUser record, @Param("example") KgRelationKeyUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") KgRelationKeyUser record, @Param("example") KgRelationKeyUserExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(KgRelationKeyUser record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table kg_relation_keyuser
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(KgRelationKeyUser record);
}