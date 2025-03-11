package com.xoa.util;

import java.sql.*;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

/**
 * 分线程从数据库查询数据
 */
public class ThredQuery implements Runnable  {

    private Connection c = null;
    private ResultSet rs = null;
    private PreparedStatement preparedStatement = null;
    private Vector<Hashtable<String, Object>> vhso = new Vector<>();
    private String connstr; //链接
    private String sql; //sql语句
    private String root; //账户
    private String pwd; //密码
    private String forName; //默认mysaql 驱动

    private Map map;  //参数

    //传入数据库链接，和要执行的sql,和数据库密码
    public ThredQuery(String forName,String connstr, String sql,String root,String pwd,Map map) {
        this.forName=forName;
        this.connstr = connstr;
        this.sql = sql;
        this.root = root;
        this.pwd = pwd;
        this.map = map;
    }

    @Override
    public void run() {
        try {
            Class.forName(forName);
            c = DriverManager.getConnection(connstr, root, pwd);
            preparedStatement = c.prepareStatement(sql);

            Iterator<Map.Entry<Integer, Integer>> it = map.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry<Integer, Integer> entry = it.next();
                Integer key = entry.getKey();
                String value = String.valueOf(entry.getValue());
                preparedStatement.setString( key , value);
            }

            rs = preparedStatement.executeQuery();
            ResultSetMetaData md = rs.getMetaData(); //获得结果集结构信息,元数据
            int columnCount = md.getColumnCount();   //获得列数
            while (rs.next()) {
                Hashtable<String, Object> hso = new Hashtable<>();
                for (int i = 1; i <= columnCount; i++) {
                    Object object = rs.getObject(i);
                    if (object!=null){
                        hso.put(md.getColumnName(i), rs.getObject(i));
                    }
                }
                this.vhso.add(hso);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public Map getMap() {
        return map;
    }

    public void setMap(Map map) {
        this.map = map;
    }

    public Connection getC() {
        return c;
    }

    public void setC(Connection c) {
        this.c = c;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }

    public PreparedStatement getPreparedStatement() {
        return preparedStatement;
    }

    public void setPreparedStatement(PreparedStatement preparedStatement) {
        this.preparedStatement = preparedStatement;
    }

    public Vector<Hashtable<String, Object>> getVhso() {
        return vhso;
    }

    public void setVhso(Vector<Hashtable<String, Object>> vhso) {
        this.vhso = vhso;
    }

    public String getConnstr() {
        return connstr;
    }

    public void setConnstr(String connstr) {
        this.connstr = connstr;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getRoot() {
        return root;
    }

    public void setRoot(String root) {
        this.root = root;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getForName() {
        return forName;
    }

    public void setForName(String forName) {
        this.forName = forName;
    }
}
