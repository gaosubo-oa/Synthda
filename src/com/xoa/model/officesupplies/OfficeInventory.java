package com.xoa.model.officesupplies;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;
import java.util.List;

public class OfficeInventory {
    private Integer inventoryId; // 物品库存盘点唯一自增ID

    private String inventoryName; // 盘点名称

    private String inventoryDimension; // 盘点维度

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date inventoryDate; // 盘点时间

    private String inventoryDateStr; // 盘点时间字符串

    private String inventoryOperator; // 盘点操作员

    private String inventoryOperatorName; // 盘点操作员姓名

    private String officeInventoryInfoJson; // 物品库存盘点记录json

    private List<OfficeInventoryInfo> officeInventoryInfoList; // 物品库存盘点记录list

    private String isExport; // 是否导出

    public Integer getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }

    public String getInventoryName() {
        return inventoryName;
    }

    public void setInventoryName(String inventoryName) {
        this.inventoryName = inventoryName;
    }

    public String getInventoryDimension() {
        return inventoryDimension;
    }

    public void setInventoryDimension(String inventoryDimension) {
        this.inventoryDimension = inventoryDimension;
    }

    public Date getInventoryDate() {
        return inventoryDate;
    }

    public void setInventoryDate(Date inventoryDate) {
        this.inventoryDate = inventoryDate;
    }

    public String getInventoryOperator() {
        return inventoryOperator;
    }

    public void setInventoryOperator(String inventoryOperator) {
        this.inventoryOperator = inventoryOperator;
    }

    public String getOfficeInventoryInfoJson() {
        return officeInventoryInfoJson;
    }

    public void setOfficeInventoryInfoJson(String officeInventoryInfoJson) {
        this.officeInventoryInfoJson = officeInventoryInfoJson;
    }

    public String getInventoryOperatorName() {
        return inventoryOperatorName;
    }

    public void setInventoryOperatorName(String inventoryOperatorName) {
        this.inventoryOperatorName = inventoryOperatorName;
    }

    public List<OfficeInventoryInfo> getOfficeInventoryInfoList() {
        return officeInventoryInfoList;
    }

    public void setOfficeInventoryInfoList(List<OfficeInventoryInfo> officeInventoryInfoList) {
        this.officeInventoryInfoList = officeInventoryInfoList;
    }

    public String getIsExport() {
        return isExport;
    }

    public void setIsExport(String isExport) {
        this.isExport = isExport;
    }

    public String getInventoryDateStr() {
        return inventoryDateStr;
    }

    public void setInventoryDateStr(String inventoryDateStr) {
        this.inventoryDateStr = inventoryDateStr;
    }
}
