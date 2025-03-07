package com.xoa.dao.widget;

import com.xoa.model.widget.WidgetModel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by gsb on 2017/7/19.
 */
public interface WidgetModuleMapper {


    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：获取所有的模型
     * @参数：无
     */
    public List<WidgetModel> getAllModel();

    /**
     * @作者：张航宁
     * @时间：2017/7/20
     * @介绍：根据ids字符串来获取数据
     * @参数：ids
     */
    public List<WidgetModel> getModelByIds(@Param(value = "ids") List<String> ids);

    /**
     * @作者：张航宁
     * @时间：2017/7/20
     * @介绍：获取所有的模块总数
     * @参数：无
     */
    public Integer getAllCount();

    /**
     * @作者：hwx
     * @时间：2022年3月28日
     * @介绍：根据id串开启或关闭小部件
     * @参数：isOn 1开启0关闭
     */
    int updateWidgetIsOnByIds(@Param(value = "isOn")String isOn,@Param(value = "ids")String[] ids);

    /**
     * @作者：hwx
     * @时间：2022年3月28日
     * @介绍：查询所有开启的小部件
     */
    List<WidgetModel> selectWidgetByIsOn(String isOn);
}
