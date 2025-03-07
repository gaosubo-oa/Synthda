package com.xoa.dao.widget;

import com.xoa.model.widget.WidgetSetModel;
import org.apache.ibatis.annotations.Param;

/**
 * Created by gsb on 2017/7/19.
 */
public interface WidgetSetMapper {

    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：根据uid获取数据
     * @参数：无
     */
    public WidgetSetModel getWidgetSetByUid(@Param(value = "uid") Integer uid);

    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：保存widget
     * @参数：WidgetSetModel
     */
    public void saveWidgetSet(WidgetSetModel widgetSetModel);

    /**
     * @作者：张航宁
     * @时间：2017/7/19
     * @介绍：更新widget门户
     * @参数：WidgetSetModel
     */
    public void updateWidgetSet(WidgetSetModel widgetSetModel);

    // 批量设置所有人的widget
    int updateAllWidgetSet(WidgetSetModel widgetSetModel);
}
