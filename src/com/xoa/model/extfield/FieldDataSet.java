package com.xoa.model.extfield;

/**
 * ClassName: FieldDataSet <br/>
 * Description: <br/>
 * date: 2022/12/2 14:51<br/>
 *
 * @author 郑山河<br />
 * @since JDK 11
 */
public class FieldDataSet {
    private String tabName;//表名
    private String fieldNo;//字段编号
    private String identyId;//关联唯一id
    private String itemData;//字段数据
    private String fieldName;//字段名
    private Integer orderNo;//排序号
    private String stype;//字段类型（单行文本框T，多行文本框MT，下拉菜单S，	单选框R，复选框C）
    private String stypeName;//字段类型名称
    private String codeType;//代码类别（1-系统代码，2-自定义选项）
    private String typeName;//代码名称串
    private String typeValue;//代码值串
    private String typeCode;//代码对应的系统代码值
    private String isQuery;//是否做为查询字段
    private String isGroup;//是否做为排序字段

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

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public Integer getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(Integer orderNo) {
        this.orderNo = orderNo;
    }

    public String getStype() {
        return stype;
    }

    public void setStype(String stype) {
        this.stype = stype;
    }

    public String getStypeName() {
        return stypeName;
    }

    public void setStypeName(String stypeName) {
        this.stypeName = stypeName;
    }

    public String getCodeType() {
        return codeType;
    }

    public void setCodeType(String codeType) {
        this.codeType = codeType;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeValue() {
        return typeValue;
    }

    public void setTypeValue(String typeValue) {
        this.typeValue = typeValue;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getIsQuery() {
        return isQuery;
    }

    public void setIsQuery(String isQuery) {
        this.isQuery = isQuery;
    }

    public String getIsGroup() {
        return isGroup;
    }

    public void setIsGroup(String isGroup) {
        this.isGroup = isGroup;
    }
}