package com.xoa.dao.sys;

import com.xoa.model.sys.SealLog;
import com.xoa.model.sys.SealLogExample;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SealLogMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int countByExample(SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int deleteByExample(SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer logId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int insert(SealLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int insertSelective(SealLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    List<SealLog> selectByExampleWithBLOBs(SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    List<SealLog> selectByExample(SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    SealLog selectByPrimaryKey(Integer logId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") SealLog record, @Param("example") SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") SealLog record, @Param("example") SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") SealLog record, @Param("example") SealLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(SealLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(SealLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table seal_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(SealLog record);

    List<SealLog> getAllSealLogInfo(Map<String,Object> map);

    List<SealLog> selectAllSealLogInfo(Map<String,Object> map);

    void deleteSealLog(String [] ids);

    SealLog selectNoMd5Log(@Param("attachmentId")String attachmentId, @Param("attachmentName")String attachmentName);

    SealLog selectLastMd5LogOne(@Param("attachmentId")String attachmentId, @Param("attachmentName")String attachmentName);

    SealLog selectByMd5(@Param("attachmentMd5")String attachmentMd5);

}