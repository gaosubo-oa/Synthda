package com.xoa.dao.footprint;

import com.xoa.model.footprint.FootSet;

import java.util.List;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/12 16:35
 * @类介绍: 足迹设置
 * @构造参数:
 **/
public interface FootSetMapper {


    List<FootSet> getTime();

    void editUpdateTime(String  updateTime);
}
