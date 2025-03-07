package com.xoa.util.dataSource;

import com.ibatis.common.resources.Resources;
import com.xoa.util.common.StringUtils;

import java.util.Properties;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-26 下午5:38:23
 * 类介绍  :    分线程连接数据源
 * 构造参数:   
 *
 */
public class ContextHolder {
//    public static final String mysqlDataSources1="mysqlDataSources";
//    public static final String mysqlDataSources="mysqlDataSources1";
//    public static final String oracleDataSources="oracleDataSources";



    private static final ThreadLocal<String> context = new ThreadLocal<String>();

    public static void setConsumerType(String consumerType){

        boolean setFlag = false;
        // 增加人大金仓切库判断
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            if(!StringUtils.checkNull(consumerType)){
                String driver = props.getProperty("driverClassName");
                String sqlType = consumerType.substring(consumerType.length() - 4);
                //判断库是否存在
                if(DataSourceInit.orgIds.contains(sqlType)){
                    setFlag = true;
                }
                if("com.kingbase8.Driver".equals(driver)){
                    // 切掉1001或者10xx 之前的字符串 拼接到 xoaKB上
                    consumerType = "xoaKB" + sqlType;
                } else if ("dm.jdbc.driver.DmDriver".equals(driver)){
                    // 切掉1001或者10xx 之前的字符串 拼接到 XOA上
                    consumerType = "XOA" + sqlType;
                }

            }
        }catch (Exception e){
            e.printStackTrace();
        }
        if(setFlag) {
            context.set(consumerType);
        }
    }

    public static String getConsumerType(){
        return context.get();
    }

    public static void clearConsumerType(){
        context.remove();
    }

}
