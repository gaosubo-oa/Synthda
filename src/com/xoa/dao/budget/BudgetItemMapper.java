package com.xoa.dao.budget;

import com.xoa.model.budget.BudgetItem;
import com.xoa.model.budget.BudgetItemExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BudgetItemMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int countByExample(BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int deleteByExample(BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer budgetId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int insert(BudgetItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int insertSelective(BudgetItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    List<BudgetItem> selectByExampleWithBLOBs(BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    List<BudgetItem> selectByExample(BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    BudgetItem selectByPrimaryKey(Integer budgetId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") BudgetItem record, @Param("example") BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") BudgetItem record, @Param("example") BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") BudgetItem record, @Param("example") BudgetItemExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(BudgetItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(BudgetItem record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table budget_item
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(BudgetItem record);

    int updatefhByPrimaryKey(Integer budgetId);

    int updateDelByPrimaryKey(Integer budgetId);

    int updateByPrimaryKeySelective1(BudgetItem record);

    int upBudgetItemById(BudgetItem budgetItem);

    int updateDelByPrimaryKey(BudgetItem bugetItem);

    List<BudgetItem> selAllBudget(Map<String, Object> map);

    List<BudgetItem> selAllBudget1();

    List<BudgetItem> selDelAllBudget(Map<String, Object> map);

    BudgetItem selBudgetItemById(Integer budgetId);

    BudgetItem selBudgetItemById1(@Param("budgetId") Integer budgetId);

    BudgetItem selAllXmBudgetItem(Integer budgetId);

    List<BudgetItem> selStatement(Map<String, Object> map);

    int selStatementCount(Map<String, Object> map);

    // 预算执行台账列表查询
    List<BudgetItem> selStatement1(Map<String, Object> map);

    List<BudgetItem> getStatement(Map<String, Object> map);

    List<BudgetItem> selAllStatement();

    String selRunName(Integer runId);

    String selOneLineNo(String budgetItem);

    int delAttachById1(Integer budgetId);

    int upItemMoney(BudgetItem b);

    BudgetItem selByName(String name);

    /**
     * 作者: 张航宁
     * 日期: 2018/9/6
     * 说明: 查询项目统计信息
     */
    List<BudgetItem> selStatistics(Map<String, Object> map);

    List<BudgetItem> getStatistics(Map<String, Object> map);

    String selLastBudgetNo();

    // 根据执行人的userId查他的deptId
    Integer getDeptIdByUserId(String executor);

    Integer getDeptIdByUsername(String executor);

    String getDeptNameByDeptId(int deptId);

}