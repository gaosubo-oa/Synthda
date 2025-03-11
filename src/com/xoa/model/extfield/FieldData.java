package com.xoa.model.extfield;
/**
 *  自定义字段数据类
 */
public class FieldData {
    private String tabName;//表名
    private String fieldNo;//字段编号
    private String identyId;//关联唯一id
    private String itemData;//字段数据

    public String getTabName() {
        return tabName;
    }

    public void setTabName(String tabName) {
        this.tabName = tabName;
    }

    public String getFieldNo() {
        return fieldNo;
    }

    public void setFieldNo(String fieldNo) {
        this.fieldNo = fieldNo;
    }

    public String getIdentyId() {
        return identyId;
    }

    public void setIdentyId(String identyId) {
        this.identyId = identyId;
    }

    public String getItemData() {
        return itemData;
    }

    public void setItemData(String itemData) {
        this.itemData = itemData;
    }
}
