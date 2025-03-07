package com.xoa.service.common.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.util.FileUploadUtil;
import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

public class ExecSqlFile {

    public Boolean execSqlFileByMysql(Integer oid, String dataversion,String webVersion) throws Exception {
        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
        String url = props.getProperty("url" + oid);

        String driver = props.getProperty("driverClassName");
        String username = props.getProperty("uname" + oid);
        String password = props.getProperty("password" + oid);
        Class.forName(driver).newInstance();
        Connection conn = (Connection) DriverManager.getConnection(url, username, password);

        String basePath = this.getClass().getClassLoader().getResource(".").getPath() + System.getProperty("file.separator") + "config" + System.getProperty("file.separator") + "upgrade";
        File f = new File(basePath);
        String[] fileNames = f.list();
        String NowdataVersion = dataversion.replaceAll("\\.", "");
        webVersion = webVersion.replaceAll("\\.", "");
        String sqlFilePath = null;
        try {
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
            ScriptRunner runner = new ScriptRunner(conn);
            //下面配置不要随意更改，否则会出现各种问题
            runner.setAutoCommit(true); //自动提交
            runner.setFullLineDelimiter(false);
            runner.setDelimiter(";"); //每条命令间的分隔符
            runner.setSendFullScript(false); //方式一：true则获取整个脚本并执行； 方式二：false则按照自定义的分隔符每行执行
            /*
             * setStopOnError参数作用：遇见错误是否停止；
             * （1）false，遇见错误不会停止，会继续执行，会打印异常信息，并不会抛出异常，当前方法无法捕捉异常无法进行回滚操作，
             * 无法保证在一个事务内执行；
             * （2）true，遇见错误会停止执行，打印并抛出异常，捕捉异常，并进行回滚，保证在一个事务内执行；
             */
            runner.setStopOnError(true);
            //如果又多个sql文件，可以写多个runner.runScript(xxx),
            String fileNameSub = null;
            for (String fileName : fileNames) {
                fileNameSub=fileName.substring(0,fileName.lastIndexOf("."));
                if (fileName.startsWith("update") && Integer.parseInt(fileNameSub.split("update")[1]+"1") > Integer.parseInt(NowdataVersion)
                        && Integer.parseInt(fileNameSub.split("update")[1]+"1") <= Integer.parseInt(webVersion)) {
                    sqlFilePath = basePath+System.getProperty("file.separator") +fileName;
                    StringBuilder logPath = FileUploadUtil.getUploadHead().append(System.getProperty("file.separator")).
                            append("xoa").append(oid).append(System.getProperty("file.separator")).
                            append("versionSqlLog").append(System.getProperty("file.separator")).
                            append(fileNameSub.split("update")[1]).append(".txt");

                    File logFile = new File(logPath.toString());
                    if(!logFile.getParentFile().exists()){
                        logFile.getParentFile().mkdirs();
                    }
                    //设置是否输出日志
                    runner.setErrorLogWriter(new PrintWriter(logPath.toString()));
                    // 执行sql文件
                    runner.runScript(new InputStreamReader(new FileInputStream(sqlFilePath), "utf-8"));

                    if(logFile.length()>0){
                        return false;
                    }
                }
            }
            conn.close();
        } catch (Exception e) {
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }

        return true;
    }

}
