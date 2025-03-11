package com.xoa.util;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

//  使用jdbc的方式使用事务，反正因为多数据源导致事务失效的临时处理方案
public class JdbcTxUtil {

    public static final String FILE_PATH = "jdbc-sql.properties";
    //     使用jdbc完成事务功能！！
    public static boolean useTx(List<String> sqls, List<Object> prePare){
        PreparedStatement statement =null;
        Connection connection=null;
        boolean flag=false;
        String url1001 = JdbcTxUtil.getValue("url1001");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); //加载驱动
            connection=DriverManager.getConnection(JdbcTxUtil.getValue("url1001"),
                    JdbcTxUtil.getValue("uname1001"), JdbcTxUtil.getValue("password1001"));
            connection.setAutoCommit(false);  //相当于 set autocommit=0;

            for (String sql : sqls) {
                statement =connection.prepareStatement(sql);
                for (int i = 0; i < prePare.size(); i++) {
                    List<Object> objects = (List<Object>) prePare.get(i);
                    for (int i1 = 0; i1 < objects.size(); i1++) {
                        witchObject(objects.get(i1),statement,i1+1);
                    }

                }
                int i = statement.executeUpdate();
                if (i>0){
                    flag=true;
                }
            }
            connection.commit();  //executeBatch()语句若不出错，提交事务。
        } catch (Exception e) {
            try {
                //如果在创建连接对象过程中爆发异常，connection就会为null。若不加if语句，就会出现空指针异常。
                if(connection!=null) {
                    connection.rollback(); //executeBatch()语句若出错，回滚，两个SQL语句执行不成功。
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        }finally {
            try {
                if (statement!=null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (connection!=null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return flag;
        }
    }


    public static void witchObject(Object object,PreparedStatement statement,int i) throws SQLException {
        if (object instanceof String){
            statement.setString(i, String.valueOf(object));
        }else if (object instanceof Integer){
            statement.setInt(i, (Integer) object);
        }else if (object instanceof Float){
            statement.setFloat(i, (Float) object);
        }else if (object instanceof BigDecimal){
            statement.setBigDecimal(i, (BigDecimal) object);
        }else if (object instanceof Date){
            statement.setDate(i, (java.sql.Date) object);
        }else if(object instanceof Long){
            statement.setLong(i, (Long) object);
        }
    }

    //通过key直接获取对应的值
    public static String getValue(String key)
    {
        Properties properties = new Properties();
        try
        {
            properties.load(JdbcTxUtil.class.getClassLoader().getResourceAsStream(FILE_PATH));
        }
        catch (IOException e)
        {
            throw new RuntimeException("File Read Failed...", e);
        }
        return properties.getProperty(key);
    }


}
