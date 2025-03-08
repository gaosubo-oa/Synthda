package com.xoa.dao.budget;

import com.xoa.model.budget.BudgetLog;
import com.xoa.model.budget.BudgetLogExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BudgetLogMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int countByExample(BudgetLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int deleteByExample(BudgetLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer logId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int insert(BudgetLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int insertSelective(BudgetLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    List<BudgetLog> selectByExample(BudgetLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    BudgetLog selectByPrimaryKey(Integer logId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") BudgetLog record, @Param("example") BudgetLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") BudgetLog record, @Param("example") BudgetLogExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(BudgetLog record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_log
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(BudgetLog record);

    List<BudgetLog> selBudgetLog(Map<String, Object> map);

    List<BudgetLog> selAllBudgetLog(Map<String, Object> map);


}