package com.xoa.dao.officesupplies;

import com.xoa.model.officesupplies.OfficeTranshistory;
import com.xoa.model.officesupplies.OfficeTranshistoryExample;
import com.xoa.model.officesupplies.OfficeTranshistoryWithBLOBs;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface OfficeTranshistoryMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int countByExample(OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int deleteByExample(OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int deleteByPrimaryKey(Integer transId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int insert(OfficeTranshistoryWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int insertSelective(OfficeTranshistoryWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    List<OfficeTranshistoryWithBLOBs> selectByExampleWithBLOBs(OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    List<OfficeTranshistory> selectByExample(OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    OfficeTranshistoryWithBLOBs selectByPrimaryKey(Integer transId);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByExampleSelective(@Param("record") OfficeTranshistoryWithBLOBs record, @Param("example") OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByExampleWithBLOBs(@Param("record") OfficeTranshistoryWithBLOBs record, @Param("example") OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByExample(@Param("record") OfficeTranshistory record, @Param("example") OfficeTranshistoryExample example);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByPrimaryKeySelective(OfficeTranshistoryWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByPrimaryKeyWithBLOBs(OfficeTranshistoryWithBLOBs record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table office_transhistory
     *
     * @mbggenerated
     */
    int updateByPrimaryKey(OfficeTranshistory record);

    List<OfficeTranshistoryWithBLOBs> getMyHistory(Map map);
    List<OfficeTranshistoryWithBLOBs> getMyHistorys(Map map);
    List<OfficeTranshistoryWithBLOBs> getMyHistoryss(String deptManager);
    OfficeTranshistoryWithBLOBs selectDetailed(Integer transId);
    int updateGetSubmitStatus(OfficeTranshistoryWithBLOBs officeTranshistory);
    OfficeTranshistory selectByBorrower(String borrower);
    int updateGetSubmitList(OfficeTranshistory officeTranshistory);
    int countMyHistory(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据当前登录人查询待批申请
     * 参数说明:   @param currentUser 当前登录人
     * 返回值说明:
     */
    List<OfficeTranshistoryWithBLOBs> selTranshistoryByState(String currentUser);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   修改审批状态
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    int upTransHistoryState (OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月8日 下午15:47:00
     * 方法介绍:   根据条件进行办公用品发放查询（可分页）
     * 参数说明:   @param
     * 返回值说明:
     */
    List<OfficeTranshistoryWithBLOBs> selGrantByCond(Map<String,Object> map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   根据条件进行办公用品发放数量查询
     * 参数说明:   @param
     * 返回值说明:
     */
    int selGrantCountByCond(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   修改发放状态
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    int upGrantStatus (@Param("grantStatus") String grantStatus,@Param("transId") String transId);



    int  upReturnStatus(@Param("returnStatus") String returnStatus,@Param("transId") String transId);
    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月9日 下午15:47:00
     * 方法介绍:   办公用品查询
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    List<OfficeTranshistoryWithBLOBs> selTranshistoryByCond(Map map);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日维护办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    List<OfficeTranshistoryWithBLOBs> selMaintain(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查询今日代登记办公用品列表（操作员是当前登录人）
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    List<OfficeTranshistoryWithBLOBs> selInstead(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查看当前登录是否是审批人
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    int isApproval(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年10月10日 下午15:47:00
     * 方法介绍:   查看当前登录是否是发放人
     * 参数说明:   @param officeTranshistoryWithBLOBs
     * 返回值说明:
     */
    int isGrant(OfficeTranshistoryWithBLOBs officeTranshistoryWithBLOBs);

    String getManagerByTransId(int transId);
    /**
     * 创建作者:   李阳
     * 创建日期:   2018年7月31日
     * 方法介绍:   查询领用物品
     */
    List<OfficeTranshistoryWithBLOBs> getTranshistoryById(String borrower);

    List<OfficeTranshistoryWithBLOBs>  selectShopList(Map map);

    int  selectShopListCount();

    List<OfficeTranshistoryWithBLOBs>  selectByTransIds(@Param("transIds") String transIds[]);
    int updateReturn(@Param("proStock") Integer proStock,@Param("proId") Integer proId);
    List<OfficeTranshistoryWithBLOBs> warehousingStatistics(Map<String, Object> paraMap);

    List<OfficeTranshistoryWithBLOBs> settlementStatistics(Map<String, Object> paraMap);

    List<OfficeTranshistoryWithBLOBs> maintainStatistics(Map<String, Object> paraMap);

    Integer selectScheduledReceipt(@Param("proId") Integer proId, @Param("lastInventoryDate") String lastInventoryDate, @Param("currentTime") String currentTime);

    Integer selectOutboundQuantity(@Param("proId") Integer proId, @Param("lastInventoryDate") String lastInventoryDate, @Param("currentTime") String currentTime);
}