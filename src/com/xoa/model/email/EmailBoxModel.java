package com.xoa.model.email;

import java.io.Serializable;

/**
 *
 * 创建作者:   张勇
 * 创建日期:   2017-5-15 上午10:19:20
 * 类介绍  :   其他邮件
 * 构造参数:
 *
 */
public class EmailBoxModel implements Serializable{
	private static final long serialVersionUID =1076969159692234636L;

    /**
     * 自增唯一ID
     */
    private Integer boxId;

    /**
     * 邮件箱排序号
     */
    private Integer boxNo;

    /**
     * 邮件箱名称
     */
    private String boxName;

    /**
     * 邮件箱所有者USER_ID
     */
    private String userId;

    /**
     * 每页显示的记录条数
     */
    private String defaultCount;

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:29
     * 方法介绍:   自增唯一ID
     * 参数说明:
     * @return
     */
    public Integer getBoxId() {
        return boxId == null ? 0:boxId;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:30
     * 方法介绍:   自增唯一ID
     * 参数说明:
     * @return
     */
    public void setBoxId(Integer boxId) {
        this.boxId = boxId;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:30
     * 方法介绍:   邮件箱排序号
     * 参数说明:
     * @return
     */
    public Integer getBoxNo() {
        return boxNo;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:30
     * 方法介绍:   邮件箱排序号
     * 参数说明:
     * @return
     */
    public void setBoxNo(Integer boxNo) {
        this.boxNo = boxNo;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:30
     * 方法介绍:   邮件箱名称
     * 参数说明:   
     * @return     
     */
    public String getBoxName() {
        return boxName == null ? "" : boxName.trim();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:31
     * 方法介绍:   邮件箱名称
     * 参数说明:
     * @return
     */
    public void setBoxName(String boxName) {
        this.boxName = boxName ;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:32
     * 方法介绍:   邮件箱所有者USER_ID
     * 参数说明:
     * @return
     */
    public String getUserId() {
        return userId == null ? "" : userId.trim();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:33
     * 方法介绍:   邮件箱所有者USER_ID
     * 参数说明:
     * @return
     */
    public void setUserId(String userId) {
        this.userId = userId ;
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:33
     * 方法介绍:   每页显示的记录条数
     * 参数说明:
     * @return
     */
    public String getDefaultCount() {
        return defaultCount  == null ? "" : defaultCount.trim();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/5/15 10:33
     * 方法介绍:   每页显示的记录条数
     * 参数说明:
     * @return
     */
    public void setDefaultCount(String defaultCount) {
        this.defaultCount = defaultCount;
    }
}