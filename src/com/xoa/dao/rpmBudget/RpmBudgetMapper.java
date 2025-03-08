package com.xoa.dao.rpmBudget;

import com.xoa.model.rpmBudget.RpmBudget;
import com.xoa.model.rpmBudget.RpmBudgetExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RpmBudgetMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int countByExample(RpmBudgetExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int deleteByExample(RpmBudgetExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer budgetId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int insert(RpmBudget record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int insertSelective(RpmBudget record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    List<RpmBudget> selectByExample(RpmBudgetExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    RpmBudget selectByPrimaryKey(Integer budgetId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") RpmBudget record, @Param("example") RpmBudgetExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") RpmBudget record, @Param("example") RpmBudgetExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(RpmBudget record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table rpm_budget
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(RpmBudget record);

    int deleBudget(Integer topicId);

    List<RpmBudget> selectById(Integer topicId);
}