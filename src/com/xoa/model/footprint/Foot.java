package com.xoa.model.footprint;

import com.xoa.model.department.Department;
import com.xoa.model.users.Users;

import java.io.Serializable;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/8 10:42
 * @类介绍: 我的足迹
 * @构造参数: 无
 **/
public class Foot implements Serializable {
    /**
     * 自增ID
     */
    private Integer id;

    /**
     * 用户ID
     */
    private Integer uid;

    /**
     * 创建时间
     */
    private Integer createTime;

    /**
     * 地址
     */
    private String location;

    /**
     * 经度
     */
    private String lng;

    /**
     * 纬度
     */
    private String lat;

    /**
     * 标记
     */
    private Integer isNew;

    /**
     * 更新时间
     */
    private Integer updateTime;

    /**
     * 用户
     */
    private Users users;

    private String longitude;
    private String lantitude;

    /**
     *部门
     */
    private Department department;

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Integer createTime) {
        this.createTime = createTime;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location == null ? null : location.trim();
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng == null ? null : lng.trim();
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat == null ? null : lat.trim();
    }

    public Integer getIsNew() {
        return isNew;
    }

    public void setIsNew(Integer isNew) {
        this.isNew = isNew;
    }

    public Integer getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Integer updateTime) {
        this.updateTime = updateTime;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLantitude() {
        return lantitude;
    }

    public void setLantitude(String lantitude) {
        this.lantitude = lantitude;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }
}