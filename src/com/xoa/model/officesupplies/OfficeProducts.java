package com.xoa.model.officesupplies;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.util.Date;

public class OfficeProducts {
    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_ID
     *
     * @mbggenerated
     */
    private Integer proId;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_NAME
     *
     * @mbggenerated
     */
    private String proName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.OFFICE_PROTYPE
     *
     * @mbggenerated
     */
    private String officeProtype;

    private String officeProtypeName;//类别名称

    private String officeDepositoryId;


    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_CODE
     *
     * @mbggenerated
     */
    private String proCode;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_UNIT
     *
     * @mbggenerated
     */
    private String proUnit;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_PRICE
     *
     * @mbggenerated
     */
    private BigDecimal proPrice;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_LOWSTOCK
     *
     * @mbggenerated
     */
    private Integer proLowstock;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_MAXSTOCK
     *
     * @mbggenerated
     */
    private Integer proMaxstock;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_STOCK
     *
     * @mbggenerated
     */
    private Integer proStock;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_CREATOR
     *
     * @mbggenerated
     */
    private String proCreator;

    private String proCreatorName;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.PRO_ORDER
     *
     * @mbggenerated
     */
    private String proOrder;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.OFFICE_PRODUCT_TYPE
     *
     * @mbggenerated
     */
    private Integer officeProductType;

    /**
     * This field was generated by MyBatis Generator.
     * This field corresponds to the database column office_products.ALLOCATION
     *
     * @mbggenerated
     */
    private Integer allocation;

    private String proKeeper;//调度员

    private String depositoryId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date lastInventoryDate; // 上期盘点时间

    private Integer oldBalance; // 上期结余

    private Integer scheduledReceipt; // 入库量

    private Integer outboundQuantity; // 出库量

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_ID
     *
     * @return the value of office_products.PRO_ID
     *
     * @mbggenerated
     */
    public Integer getProId() {
        return proId;
    }

    public String getOfficeDepositoryId() {
        return officeDepositoryId==null?"":officeDepositoryId;
    }

    public void setOfficeDepositoryId(String officeDepositoryId) {
        this.officeDepositoryId = officeDepositoryId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_ID
     *
     * @param proId the value for office_products.PRO_ID
     *
     * @mbggenerated
     */



    public void setProId(Integer proId) {
        this.proId = proId;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_NAME
     *
     * @return the value of office_products.PRO_NAME
     *
     * @mbggenerated
     */
    public String getProName() {
        return proName;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_NAME
     *
     * @param proName the value for office_products.PRO_NAME
     *
     * @mbggenerated
     */
    public void setProName(String proName) {
        this.proName = proName == null ? null : proName.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.OFFICE_PROTYPE
     *
     * @return the value of office_products.OFFICE_PROTYPE
     *
     * @mbggenerated
     */
    public String getOfficeProtype() {
        return officeProtype;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.OFFICE_PROTYPE
     *
     * @param officeProtype the value for office_products.OFFICE_PROTYPE
     *
     * @mbggenerated
     */
    public void setOfficeProtype(String officeProtype) {
        this.officeProtype = officeProtype == null ? null : officeProtype.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_CODE
     *
     * @return the value of office_products.PRO_CODE
     *
     * @mbggenerated
     */
    public String getProCode() {
        return proCode;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_CODE
     *
     * @param proCode the value for office_products.PRO_CODE
     *
     * @mbggenerated
     */
    public void setProCode(String proCode) {
        this.proCode = proCode == null ? null : proCode.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_UNIT
     *
     * @return the value of office_products.PRO_UNIT
     *
     * @mbggenerated
     */
    public String getProUnit() {
        return proUnit==null?"":proUnit;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_UNIT
     *
     * @param proUnit the value for office_products.PRO_UNIT
     *
     * @mbggenerated
     */
    public void setProUnit(String proUnit) {
        this.proUnit = proUnit == null ? null : proUnit.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_PRICE
     *
     * @return the value of office_products.PRO_PRICE
     *
     * @mbggenerated
     */
    public BigDecimal getProPrice() {
        return proPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_PRICE
     *
     * @param proPrice the value for office_products.PRO_PRICE
     *
     * @mbggenerated
     */
    public void setProPrice(BigDecimal proPrice) {
        this.proPrice = proPrice;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_LOWSTOCK
     *
     * @return the value of office_products.PRO_LOWSTOCK
     *
     * @mbggenerated
     */
    public Integer getProLowstock() {
        return proLowstock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_LOWSTOCK
     *
     * @param proLowstock the value for office_products.PRO_LOWSTOCK
     *
     * @mbggenerated
     */
    public void setProLowstock(Integer proLowstock) {
        this.proLowstock = proLowstock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_MAXSTOCK
     *
     * @return the value of office_products.PRO_MAXSTOCK
     *
     * @mbggenerated
     */
    public Integer getProMaxstock() {
        return proMaxstock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_MAXSTOCK
     *
     * @param proMaxstock the value for office_products.PRO_MAXSTOCK
     *
     * @mbggenerated
     */
    public void setProMaxstock(Integer proMaxstock) {
        this.proMaxstock = proMaxstock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_STOCK
     *
     * @return the value of office_products.PRO_STOCK
     *
     * @mbggenerated
     */
    public Integer getProStock() {
        return proStock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_STOCK
     *
     * @param proStock the value for office_products.PRO_STOCK
     *
     * @mbggenerated
     */
    public void setProStock(Integer proStock) {
        this.proStock = proStock;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_CREATOR
     *
     * @return the value of office_products.PRO_CREATOR
     *
     * @mbggenerated
     */
    public String getProCreator() {
        return proCreator;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_CREATOR
     *
     * @param proCreator the value for office_products.PRO_CREATOR
     *
     * @mbggenerated
     */
    public void setProCreator(String proCreator) {
        this.proCreator = proCreator == null ? null : proCreator.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.PRO_ORDER
     *
     * @return the value of office_products.PRO_ORDER
     *
     * @mbggenerated
     */
    public String getProOrder() {
        return proOrder;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.PRO_ORDER
     *
     * @param proOrder the value for office_products.PRO_ORDER
     *
     * @mbggenerated
     */
    public void setProOrder(String proOrder) {
        this.proOrder = proOrder == null ? null : proOrder.trim();
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.OFFICE_PRODUCT_TYPE
     *
     * @return the value of office_products.OFFICE_PRODUCT_TYPE
     *
     * @mbggenerated
     */
    public Integer getOfficeProductType() {
        return officeProductType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.OFFICE_PRODUCT_TYPE
     *
     * @param officeProductType the value for office_products.OFFICE_PRODUCT_TYPE
     *
     * @mbggenerated
     */
    public void setOfficeProductType(Integer officeProductType) {
        this.officeProductType = officeProductType;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method returns the value of the database column office_products.ALLOCATION
     *
     * @return the value of office_products.ALLOCATION
     *
     * @mbggenerated
     */
    public Integer getAllocation() {
        return allocation;
    }

    /**
     * This method was generated by MyBatis Generator.
     * This method sets the value of the database column office_products.ALLOCATION
     *
     * @param allocation the value for office_products.ALLOCATION
     *
     * @mbggenerated
     */
    public void setAllocation(Integer allocation) {
        this.allocation = allocation;
    }

    public String getProCreatorName() {
        return proCreatorName==null?"":proCreatorName;
    }

    public void setProCreatorName(String proCreatorName) {
        this.proCreatorName = proCreatorName;
    }

    public String getOfficeProtypeName() {
        return officeProtypeName;
    }

    public void setOfficeProtypeName(String officeProtypeName) {
        this.officeProtypeName = officeProtypeName;
    }

    public String getProKeeper() {
        return proKeeper;
    }

    public void setProKeeper(String proKeeper) {
        this.proKeeper = proKeeper;
    }

    public String getDepositoryId() {
        return depositoryId;
    }

    public void setDepositoryId(String depositoryId) {
        this.depositoryId = depositoryId;
    }

    public Date getLastInventoryDate() {
        return lastInventoryDate;
    }

    public void setLastInventoryDate(Date lastInventoryDate) {
        this.lastInventoryDate = lastInventoryDate;
    }

    public Integer getOldBalance() {
        return oldBalance;
    }

    public void setOldBalance(Integer oldBalance) {
        this.oldBalance = oldBalance;
    }

    public Integer getScheduledReceipt() {
        return scheduledReceipt;
    }

    public void setScheduledReceipt(Integer scheduledReceipt) {
        this.scheduledReceipt = scheduledReceipt;
    }

    public Integer getOutboundQuantity() {
        return outboundQuantity;
    }

    public void setOutboundQuantity(Integer outboundQuantity) {
        this.outboundQuantity = outboundQuantity;
    }
}