package com.xoa.model.sys;

/**
 * @author 左春晖
 * @date 2018/7/4 15:08
 * @desc
 *
 * 用于数据库表的信息查询实体类
 */
public class TableStatistics {

    private int  Rows;

    private int Datalength;

    private int Indexlength;

    private String Name;

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public int getRows() {
        return Rows;
    }

    public void setRows(int rows) {
        Rows = rows;
    }

    public int getDatalength() {
        return Datalength;
    }

    public void setDatalength(int datalength) {
        Datalength = datalength;
    }

    public int getIndexlength() {
        return Indexlength;
    }

    public void setIndexlength(int indexlength) {
        Indexlength = indexlength;
    }
}

