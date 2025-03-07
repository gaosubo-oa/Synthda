package com.xoa.util;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

public class checkMysql {  



     public static String url =
     "jdbc:mysql://192.168.0.17:3306/*****_orders";
     public static String user = "root";
     public static String password = "gaosubo3000";
    public static void main(String[] args) throws ClassNotFoundException,  
            IOException, SQLException, ParseException {  

         /*String createBrandDatabase = "create table "
         + "userbrandtime"  
         +  
         "(uid int(10) unsigned NOT NULL,brand_ids int(10) unsigned NOT NULL,timestamp int(10) unsigned NOT NULL,primary key(uid,brand_ids))"  
         + " DEFAULT CHARSET=utf8";  
         String checkTable="show tables like \"userbrandtime\"";  
         try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection con = (Connection) DriverManager.getConnection(url,
         user, password);
         Statement stmt = (Statement) con.createStatement();
           
         ResultSet resultSet=stmt.executeQuery(checkTable);  
         if (resultSet.next()) {  
//            System.out.println("table exist!");
        }else{  
//                 if(stmt.executeUpdate(createBrandDatabase)==0)
//         System.out.println("create table success!");
        }  
      
         } finally {  
          
         }  */

    }  
}  