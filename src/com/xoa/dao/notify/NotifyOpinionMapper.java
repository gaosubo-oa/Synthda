package com.xoa.dao.notify;

import com.xoa.model.notify.NotifyOpinion;
import com.xoa.model.notify.NotifyOpinionExample;
import com.xoa.model.notify.NotifyOpinionWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NotifyOpinionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int countByExample(NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int deleteByExample(NotifyOpinionExample example);

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
    int insert(NotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int insertSelective(NotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    List<NotifyOpinionWithBLOBs> selectByExampleWithBLOBs(NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    List<NotifyOpinion> selectByExample(NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    NotifyOpinionWithBLOBs selectByPrimaryKey(Integer opId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") NotifyOpinionWithBLOBs record, @Param("example") NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") NotifyOpinionWithBLOBs record, @Param("example") NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") NotifyOpinion record, @Param("example") NotifyOpinionExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(NotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(NotifyOpinionWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table notify_opinion
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(NotifyOpinion record);

    NotifyOpinionWithBLOBs selectByNotyId(@Param("notyId") Integer notyId , @Param("userId") String userId);

    List<NotifyOpinionWithBLOBs> selectByNotyIds(@Param("notyId") Integer notyId , @Param("userIds") String[] userIds);


    List<NotifyOpinionWithBLOBs>  selectByNotyIdList(@Param("notyId") Integer notyId);

}