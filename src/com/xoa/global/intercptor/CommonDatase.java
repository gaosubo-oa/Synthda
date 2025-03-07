package com.xoa.global.intercptor;

import com.xoa.service.common.SysCodeService;
import com.xoa.service.common.UpdateProperty;
import com.xoa.util.quartz.QuartzInit;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ResourceBundle;

/**
 * Created by gaoyafeng on 2017/11/15.
 */
public class CommonDatase implements InitializingBean {

    private static String dbMysql = "com.mysql.cj.jdbc.Driver";
    private static String dbOracle = "oracle.jdbc.driver.OracleDriver";
    private static String dbDM = "dm.jdbc.driver.DmDriver";
    private static String dbKB = "com.kingbase8.Driver";
    private static String currentDB = "";

    @Autowired
    SysCodeService sysCodeService;
    @Autowired
    UpdateProperty updateProperty;
    @Autowired
    QuartzInit quartzInit;
    @Override
    public void afterPropertiesSet() throws Exception {

        ResourceBundle rb =  ResourceBundle.getBundle("jdbc-sql");

        if(dbOracle.equals(rb.getString("driverClassName"))){
            currentDB="Oracle";
        }else if(dbMysql.equals(rb.getString("driverClassName"))){
            currentDB="Mysql";
        }else if(dbDM.equals(rb.getString("driverClassName"))){
            currentDB="DM";
        }else if (dbKB.equals(rb.getString("driverClassName"))){
            currentDB="Kingbase";
        }

        sysCodeService.updateResource();
        updateProperty.updatePro();
        quartzInit.afterPropertiesSet();

    }
    public static String getCurrentDB(){
        if("".equals(currentDB)){
            ResourceBundle rb =  ResourceBundle.getBundle("jdbc-sql");

            if(dbOracle.equals(rb.getString("driverClassName"))){
                currentDB="Oracle";
            }else if(dbMysql.equals(rb.getString("driverClassName"))){
                currentDB="Mysql";
            }else if(dbDM.equals(rb.getString("driverClassName"))){
                currentDB="DM";
            }else if (dbKB.equals(rb.getString("driverClassName"))){
                currentDB="Kingbase";
            }
        }
        return currentDB;
    }
}
