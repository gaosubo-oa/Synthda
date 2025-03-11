package com.xoa.model.diary;

/**
 * 
 * 创建作者:   牛江丽
 * 创建日期:   2017-7-6 上午11:30:29
 * 类介绍  :    工作日志操作信息表实体类
 * 构造参数:   
 *
 */
public class DiaryTop {
    private Integer topId;//自增唯一ID
    private Integer diaCate;//操作分类：1.置顶
    private Integer diaId;//日志ID
    private String userId;//用户ID串

    public void setTopId(Integer topId) {
        this.topId = topId;
    }

    public void setDiaCate(Integer diaCate) {
        this.diaCate = diaCate;
    }

    public void setDiaId(Integer diaId) {
        this.diaId = diaId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getTopId() {
        return topId;
    }

    public Integer getDiaCate() {
        return diaCate;
    }

    public Integer getDiaId() {
        return diaId;
    }

    public String getUserId() {
        return userId;
    }
}