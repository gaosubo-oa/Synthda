package com.xoa.dao.sys;

import com.xoa.model.sys.TableStatistics;

/**
 * @author 左春晖
 * @date 2018/7/4 15:52
 * @desc
 */

public interface TableStatisticsMapper {

    TableStatistics select(String tablename);

}
