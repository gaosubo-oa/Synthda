package com.xoa.model.common;

/**
 * 
 * 创建作者:   张丽军
 * 创建日期:   2017-4-19 下午4:12:53
 * 类介绍  :   移动端
 * 构造参数:   无
 *
 */
public class    SysCode {
	/**
	 * 代码ID
	 */
    private Integer codeId;
    /**
     * 代码编号
     */
    private String codeNo;
    /**
     * 代码名称
     */
    private String codeName;

    /**
     *代码名称1
     */
    private String codeName1;

    public String getCodeName1() {
        return codeName1;
    }

    public void setCodeName1(String codeName1) {
        this.codeName1 = codeName1;
    }

    public String getCodeName3() {
        return codeName3;
    }

    public void setCodeName3(String codeName3) {
        this.codeName3 = codeName3;
    }

    public String getCodeName4() {
        return codeName4;
    }

    public void setCodeName4(String codeName4) {
        this.codeName4 = codeName4;
    }

    public String getCodeName2() {
        return codeName2;
    }

    public void setCodeName2(String codeName2) {
        this.codeName2 = codeName2;
    }

    /**

     *代码名称2
     */
    private String codeName2;
    /**
     *代码名称3
     */
    private String codeName3;
    /**
     *代码名称4
     */
    private String codeName4;
    /**
     *代码名称5
     */
    private String codeName5;
    /**
     *代码名称6
     */
    private String codeName6;
    /**
     * 排序号
     */
    private String codeOrder;
    /**
     * 代码主分类
     */
    private String parentNo;
    /**
     * 代码标记(0-不能删除,1-可删除)
     */
    private String codeFlag;
    /**
     * 国际版多语言代码名称
     */
    private String codeExt;

    /**
     * 模块添加事务提醒
     */
    private String isRemind;

    public String getIsRemind() {
        return isRemind;
    }

    public void setIsRemind(String isRemind) {
        this.isRemind = isRemind;
    }

    public String isIphone;
    public String isCan;

    public String getIsIphone() {
        return isIphone;
    }

    public void setIsIphone(String isIphone) {
        this.isIphone = isIphone;
    }

    public String getIsCan() {
        return isCan;
    }

    public void setIsCan(String isCan) {
        this.isCan = isCan;
    }

    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:18:17
     * 方法介绍:   获取代码ID
     * 参数说明:   @return
     * @return     Integer
     */
    public Integer getCodeId() {
        return codeId;
    }
   /**
    * 
    * 创建作者:   张丽军
    * 创建日期:   2017-4-19 下午4:18:51
    * 方法介绍:   设置代码ID
    * 参数说明:   @param codeId
    * @return     void
    */
    public void setCodeId(Integer codeId) {
        this.codeId = codeId;
    }
    /**
     * 
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:19:12
     * 方法介绍:   获取代码编号
     * 参数说明:   @return
     * @return     String
     */
    public String getCodeNo() {
        return codeNo;
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:19:55
     * 方法介绍:   设置代码编号
     * 参数说明:   @param codeNo
     * @return     void
     */
    public void setCodeNo(String codeNo) {
        this.codeNo = codeNo == null ? null : codeNo.trim();
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:20:23
     * 方法介绍:   获取代码名称
     * 参数说明:   @return
     * @return     String
     */
    public String getCodeName() {
        return codeName;
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:20:50
     * 方法介绍:   设置代码名称
     * 参数说明:   @param codeName
     * @return     void
     */
    public void setCodeName(String codeName) {
        this.codeName = codeName == null ? null : codeName.trim();
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:21:41
     * 方法介绍:   获取排序号 
     * 参数说明:   @return
     * @return     String
     */
    public String getCodeOrder() {
        return codeOrder;
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:22:18
     * 方法介绍:   设置排序号
     * 参数说明:   @param codeOrder
     * @return     void
     */
    public void setCodeOrder(String codeOrder) {
        this.codeOrder = codeOrder == null ? null : codeOrder.trim();
    }
    /**
     * 
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:22:33
     * 方法介绍:   获取代码主分页
     * 参数说明:   @return
     * @return     String
     */
    public String getParentNo() {
        return parentNo;
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:23:39
     * 方法介绍:   设置代码主分页
     * 参数说明:   @param parentNo
     * @return     void
     */
    public void setParentNo(String parentNo) {
        this.parentNo = parentNo == null ? null : parentNo.trim();
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:24:05
     * 方法介绍:   获取代码标记(0-不能删除,1-可删除)
     * 参数说明:   @return
     * @return     String
     */
    public String getCodeFlag() {
        return codeFlag;
    }
     /**
      * 
      * 创建作者:   张丽军
      * 创建日期:   2017-4-19 下午4:24:31
      * 方法介绍:   设置代码标记(0-不能删除,1-可删除)
      * 参数说明:   @param codeFlag
      * @return     void
      */
    public void setCodeFlag(String codeFlag) {
        this.codeFlag = codeFlag == null ? null : codeFlag.trim();
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:24:48
     * 方法介绍:   获取国际版多语言代码名称
     * 参数说明:   @return
     * @return     String
     */
    public String getCodeExt() {
        return codeExt;
    }
    /**
     * 
     * 创建作者:   张丽军
     * 创建日期:   2017-4-19 下午4:25:11
     * 方法介绍:   设置国际版多语言代码名称
     * 参数说明:   @param codeExt
     * @return     void
     */
    public void setCodeExt(String codeExt) {
        this.codeExt = codeExt == null ? null : codeExt.trim();
    }
}