package com.xoa.dao.myNotify;

import com.xoa.model.myNotify.MyNotifyOpinion;
import com.xoa.model.myNotify.MyNotifyOpinionExample;
import com.xoa.model.myNotify.MyNotifyOpinionWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MyNotifyOpinionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int countByExample(MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int deleteByExample(MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer opId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int insert(MyNotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int insertSelective(MyNotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    List<MyNotifyOpinionWithBLOBs> selectByExampleWithBLOBs(MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    List<MyNotifyOpinion> selectByExample(MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    MyNotifyOpinionWithBLOBs selectByPrimaryKey(Integer opId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") MyNotifyOpinionWithBLOBs record, @Param("example") MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") MyNotifyOpinionWithBLOBs record, @Param("example") MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") MyNotifyOpinion record, @Param("example") MyNotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(MyNotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(MyNotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(MyNotifyOpinion record);

    MyNotifyOpinionWithBLOBs selectByNotyId(@Param("notyId") Integer notyId, @Param("userId") String userId);

    List<MyNotifyOpinionWithBLOBs> selectByNotyIds(@Param("notyId") Integer notyId, @Param("userIds") String[] userIds);


    List<MyNotifyOpinionWithBLOBs>  selectByNotyIdList(@Param("notyId") Integer notyId);

}