package com.xoa.model.officesupplies;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class OfficeInventoryInfo {
    private Integer inventoryInfoId; // 物品库存盘点记录唯一自增ID

    private Integer inventoryId; // 物品库存盘点ID

    private Integer proId; // 物品信息ID

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date lastInventoryDate; // 上期盘点时间

    private String lastInventoryDateStr; // 上期盘点时间字符串

    private Integer oldBalance; // 上期结余

    private Integer scheduledReceipt; // 入库量

    private Integer outboundQuantity; // 出库量

    private Integer bookQuantity; // 账面数量

    private Integer actualDiskCount; // 实际盘点数

    private String inventoryInfoDesc; // 备注

    private String proName; // 办公用品名称

    private String officeProtypeName; // 类别名称

    private String proDesc; // 规格/型号

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JSONField(format = "yyyy-MM-dd")
    private Date inventoryDate; // 盘点时间

    private String isExport; // 是否导出

    public Integer getInventoryInfoId() {
        return inventoryInfoId;
    }

    public void setInventoryInfoId(Integer inventoryInfoId) {
        this.inventoryInfoId = inventoryInfoId;
    }

    public Integer getInventoryId() {
        return inventoryId;
    }

    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }

    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
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

    public Integer getBookQuantity() {
        return bookQuantity;
    }

    public void setBookQuantity(Integer bookQuantity) {
        this.bookQuantity = bookQuantity;
    }

    public Integer getActualDiskCount() {
        return actualDiskCount;
    }

    public void setActualDiskCount(Integer actualDiskCount) {
        this.actualDiskCount = actualDiskCount;
    }

    public String getInventoryInfoDesc() {
        return inventoryInfoDesc;
    }

    public void setInventoryInfoDesc(String inventoryInfoDesc) {
        this.inventoryInfoDesc = inventoryInfoDesc;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProDesc() {
        return proDesc;
    }

    public void setProDesc(String proDesc) {
        this.proDesc = proDesc;
    }

    public String getOfficeProtypeName() {
        return officeProtypeName;
    }

    public void setOfficeProtypeName(String officeProtypeName) {
        this.officeProtypeName = officeProtypeName;
    }

    public Date getInventoryDate() {
        return inventoryDate;
    }

    public void setInventoryDate(Date inventoryDate) {
        this.inventoryDate = inventoryDate;
    }

    public String getIsExport() {
        return isExport;
    }

    public void setIsExport(String isExport) {
        this.isExport = isExport;
    }

    public String getLastInventoryDateStr() {
        return lastInventoryDateStr;
    }

    public void setLastInventoryDateStr(String lastInventoryDateStr) {
        this.lastInventoryDateStr = lastInventoryDateStr;
    }
}
