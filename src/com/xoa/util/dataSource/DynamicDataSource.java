package com.xoa.util.dataSource;

import com.alibaba.druid.pool.DruidAbstractDataSource;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-26 下午5:39:00
 * 类介绍  :   获取数据源类型
 * 构造参数:   
 *
 */
public class DynamicDataSource extends AbstractRoutingDataSource {

    @Override
    protected Object determineCurrentLookupKey() {
        return ContextHolder.getConsumerType();
    }

    /**
     * 获取当前连接的数据库信息
     */
    public DruidAbstractDataSource getDataSource() {
        return (DruidAbstractDataSource)determineTargetDataSource();
    }

}
