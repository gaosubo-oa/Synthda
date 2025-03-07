package com.xoa.global.timedTask;

import com.alibaba.druid.pool.DruidAbstractDataSource;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.util.common.StringUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.dataSource.DynamicDataSource;
import com.xoa.util.quartz.component.MyTaskException;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.File;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by 刘建 on 2020/7/12 15:30
 * 定时任务-备份数据库
 */
@Component
public class BakupDataBase {

    @Value("${upload.win}")
    private String savePath_win;

    @Value("${upload.linux}")
    private String savePath_linux;

    /**
     * 地址
     */
    private String host;

    /**
     * 端口号
     */
    private String port;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 数据库密码
     */
    private String passWord;

    /**
     * 数据库名称
     */
    private String databaseName;

    /**
     * 数据库安装路径
     */
    private String mysqlpath;

    /**
     * 备份路径
     */
    private String sqlBakPath;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @Resource
    private SysParaMapper sysParaMapper;


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-13 17:10
     * 方法介绍: 备份数据库
     *
     * @return java.lang.Integer
     */
    public void bakupDataBase() throws MyTaskException {
        String err = "";
//        1.获取当前登录的数据库信息
        SqlSession sqlSession = sqlSessionFactory.openSession();
        Connection connection = sqlSession.getConnection();
        Configuration configuration = sqlSession.getConfiguration();
        DynamicDataSource dynamicDataSource = (DynamicDataSource) configuration.getEnvironment().getDataSource();
        DruidAbstractDataSource druidAbstractDataSource = dynamicDataSource.getDataSource();
        databaseName = ContextHolder.getConsumerType();
        userName = druidAbstractDataSource.getUsername();
        passWord = druidAbstractDataSource.getPassword();
        String jdbcUrl = druidAbstractDataSource.getRawJdbcUrl();
        jdbcUrl = jdbcUrl.substring(13);
        jdbcUrl = jdbcUrl.substring(0,jdbcUrl.indexOf("/"));
        String[] hostPort = jdbcUrl.split(":");
        host = hostPort[0];
        port = hostPort[1];

//        2.获取数据库安装路径
        mysqlpath = getMysqlPath();

//        3.获取备份路径  路径改为attach/bak/xoa1001
        String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String bakupPath = getBakupPath().append( File.separator + "bak" + File.separator + databaseName +File.separator + dateStr+File.separator).toString();


      /*  SysPara sysPara = sysParaMapper.querySysPara("DATABASE_BACKUP_PATH");
        if(sysPara != null && !StringUtils.checkNull(sysPara.getParaValue())){
            bakupPath = sysPara.getParaValue();
            if("/".equals(bakupPath.substring(bakupPath.length()-1)) || "\\".equals(bakupPath.substring(bakupPath.length()-1))){
                bakupPath = bakupPath.substring(0,bakupPath.length()-1);
            }
            bakupPath+=File.separator +dateStr+File.separator;
        }else{
            bakupPath = getBakupPath().append(File.separator +databaseName+File.separator+"bakData"+File.separator +dateStr+File.separator).toString();
        }*/

        File bakupFile = new File(bakupPath);
        if (!bakupFile.exists()) {
            bakupFile.mkdirs();
        }
        sqlBakPath = bakupPath;
//        4.获取数据库全部表名
        List<String> tableNameByCon = getTableNameByCon(connection);
//        5.备份数据库
        for(String str :tableNameByCon){
            boolean b = exportTableTool(str);
            if(!b){
                err+=","+str;
            }
        }
        if(!StringUtils.checkNull(err)){
            throw new MyTaskException(err);
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-16 16:14
     * 方法介绍: 备份数据库
     */
    public boolean exportTableTool(String tableName) {
        try {
            File backupath = new File(sqlBakPath);
            if (!backupath.exists()) {
                backupath.mkdir();
            }
            StringBuffer sb = new StringBuffer();
            sb.append(mysqlpath);
            sb.append("mysqldump ");
            sb.append("--opt ");
            sb.append("-h ");
            sb.append(host);
            sb.append(" ");
            sb.append("-P");
            sb.append(port);
            sb.append(" ");
            sb.append("--user=");
            sb.append(userName);
            sb.append(" ");
            sb.append("--password=");
            sb.append(passWord);
            sb.append(" ");
            sb.append("--lock-all-tables=true ");
            sb.append("--result-file=");
            sb.append(sqlBakPath);
            sb.append(tableName + ".sql");
            sb.append(" ");
            sb.append("--default-character-set=utf8 ");
            sb.append(databaseName);
            sb.append(" ");
            sb.append(tableName);
            Runtime cmd = Runtime.getRuntime();
            Process p = cmd.exec(sb.toString());
            return p.waitFor() == 0 ? true : false;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-16 15:53
     * 方法介绍: 获取附件存放路径
     *
     * @return java.lang.String
     */
    public StringBuffer getXoaPath() {
        String osName = System.getProperty("os.name").toLowerCase();
        //安装路径
        StringBuffer stringBuffer = new StringBuffer("");
        if (osName.startsWith("win")) {
            if (savePath_win.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(1, index);
                }
                stringBuffer.append(str2 + "/xoa");
            }
        }
        return stringBuffer;
    }


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-16 15:49
     * 方法介绍: 获取数据库安装路径
     * @return java.lang.String
     */
    public String getMysqlPath() {
        StringBuffer bakupPath = getXoaPath();
        String osName = System.getProperty("os.name").toLowerCase();
        if (osName.startsWith("linux")) {
            bakupPath.append(File.separator+"usr"+File.separator+"local"+File.separator+"xoa");
        }
        return bakupPath.append(File.separator + "mysql" + File.separator + "bin" + File.separator ).toString();
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-16 15:49
     * 方法介绍: 获取附件路径
     * @return java.lang.String
     */
    public StringBuffer getBakupPath() {
        StringBuffer bakupPath = getXoaPath();
        String osName = System.getProperty("os.name").toLowerCase();
        if (osName.startsWith("win")) {
            bakupPath.append(savePath_win);
        } else {
            bakupPath.append(savePath_linux);
        }
        return bakupPath;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-07-16 18:24
     * 方法介绍: 获取全部表名
     * @param con
     * @return java.util.List<java.lang.String>
     */
    public static List<String> getTableNameByCon(Connection con) {
        List<String> tableNames = new ArrayList();
        try {
            DatabaseMetaData meta = con.getMetaData();
            ResultSet rs = meta.getTables(null, null, null, null);
            while (rs.next()) {
                tableNames.add(rs.getString("TABLE_NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tableNames;
    }

}
