package com.xoa.util.dataSource;

import com.ibatis.common.resources.Resources;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.*;
import java.util.*;

/**
 * Created by liuqian on 2018/1/11.
 */
public class Verification {

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月11日 下午16:32:00
     * 方法介绍:   验证是否存在某表
     * 参数说明:   tableName 表名
     * 返回值说明:  true 表示已经存在 false不存在
     */
      public static   boolean  CheckIsExistTable(Connection connection,String driver,String url,String username,String password,String tableName){
          Boolean flag=false;
          try {
              Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
              Class.forName(driver);//加载驱动
              String sql = "SHOW TABLES LIKE "+"'"+tableName+"'";

                  Statement st = connection.createStatement();
                  ResultSet rs = st.executeQuery(sql);//执行SQL语句
                  while(rs.next()){
                      flag =true;
                  }
                  rs.close();
                  st.close();
          } catch (Exception e) {
              // TODO Auto-generated catch block
              e.printStackTrace();
          }
          return flag;
      }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月11日 下午16:32:00
     * 方法介绍:   验证某表是否存在某字段
     * 参数说明:   tableName 表名  ，fieldName  字段名
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistfield(Connection connection,String driver,String url,String username,String password,String tableName,String fieldName){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "show columns from "+tableName+" like "+"'"+fieldName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   主菜单ID检查函数（SYS_MENU）
     * 参数说明:   menuId  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistMenu(Connection connection,String driver,String url,String username,String password,String menuId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_menu WHERE MENU_ID ="+"'"+menuId+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
       return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   子菜单ID检查函数（SYS_FUNCTION）
     * 参数说明:   functionId  子菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistFunction(Connection connection,String driver,String url,String username,String password,String functionId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_function WHERE FUNC_ID ="+functionId;
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午13:32:00
     * 方法介绍:   检测某表索引函数
     * 参数说明:   functionId  子菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public  static boolean  CheckIsExistIndex(Connection connection,String driver,String url,String username,String password,String tableName,String fieldName){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SHOW INDEX FROM "+tableName+" WHERE column_name LIKE"+"'"+fieldName+"'";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午14:32:00
     * 方法介绍:   系统代码检查函数
     * 参数说明:   functionId  子菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public  static boolean  CheckIsExistCode(Connection connection,String driver,String url,String username,String password,String codeNo,String parentNo){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_code WHERE CODE_NO ="+"'"+codeNo+"'"+" and PARENT_NO ="+"'"+parentNo+"'";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午14:32:00
     * 方法介绍:   系统代码检查函数
     * 参数说明:   functionId  子菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public  static boolean  CheckCode(Connection connection,String driver,String url,String username,String password,String codeId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_code WHERE CODE_ID ="+"'"+codeId+"'";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证sysParam表是否存在某字段
     * 参数说明:   paramName key值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistParam(Connection connection,String driver,String url,String username,String password,String paramName){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_para WHERE  PARA_NAME ="+"'"+paramName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证flow_trigger表是否存在数据
     * 参数说明:   id ID值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistThing(Connection connection,String driver,String url,String username,String password,String id){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM flow_trigger WHERE ID ="+id;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证user_priv表是否存在数据
     * 参数说明:   userPriv ID值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistUserPriv(Connection connection,String driver,String url,String username,String password,String userPriv){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM user_priv WHERE USER_PRIV ="+userPriv;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证user_function表是否存在数据
     * 参数说明:   uid uid值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistUserFunction(Connection connection,String driver,String url,String username,String password,String uid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM user_function WHERE uid ="+uid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证kg_relation_keysign表是否存在数据
     * 参数说明:   relation_Id 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistKgSign(Connection connection,String driver,String url,String username,String password,String relation_Id){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM kg_relation_keysign WHERE RELATION_ID ="+relation_Id;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证kg_relation_keyuser表是否存在数据
     * 参数说明:   key_UserId 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistKgkeyUser(Connection connection,String driver,String url,String username,String password,String key_UserId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM kg_relation_keyuser WHERE KEY_USER_ID ="+key_UserId;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证kg_signature表是否存在数据
     * 参数说明:   SignNature_ID 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistkgSignature(Connection connection,String driver,String url,String username,String password,String SignNature_ID){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM kg_signature WHERE SIGNATURE_ID ="+SignNature_ID;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证kg_signkey表是否存在数据
     * 参数说明:   signKey_Id 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistkgSignKey(Connection connection,String driver,String url,String username,String password,String signKey_Id){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM kg_signkey WHERE SIGNKEY_ID ="+signKey_Id;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证info_center表是否存在数据
     * 参数说明:   infoId 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistInfoCenter(Connection connection,String driver,String url,String username,String password,String infoId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM info_center WHERE INFO_ID ="+infoId;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证widget表是否存在数据
     * 参数说明:   infoId 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistWidget(Connection connection,String driver,String url,String username,String password,String id){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM widget WHERE ID ="+id;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证sys_para
     * 参数说明:   paraName  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistSysPara(Connection connection,String driver,String url,String username,String password,String paraName){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_para WHERE PARA_NAME ="+"'"+paraName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    public   static boolean  CheckIsExistSysParaAndNotNull(Connection connection,String driver,String url,String username,String password,String paraName){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM sys_para WHERE PARA_NAME ="+"'"+paraName+"' and PARA_VALUE is not null and PARA_VALUE!='';";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证user
     * 参数说明:   uid  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistUser(Connection connection,String driver,String url,String username,String password,String uid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM user WHERE uid ="+"'"+uid+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证portals
     * 参数说明:   portals_id  主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistPor(Connection connection,String driver,String url,String username,String password,String portalsId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM portals WHERE portals_id ="+"'"+portalsId+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午14:32:00
     * 方法介绍:   部门检查函数
     * 参数说明:   deptId  子菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public  static boolean  CheckIsExistDepartment(Connection connection,String driver,String url,String username,String password,String deptId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM department WHERE DEPT_ID ="+"'"+deptId+"'";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证user_priv表是否存在数据
     * 参数说明:   userPriv ID值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCAccountinfo(Connection connection,String driver,String url,String username,String password,String cAccountinfo){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM c_accountinfo WHERE USER_ID ='"+cAccountinfo+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证user_priv表是否存在数据
     * 参数说明:   userPriv ID值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCAccountinfoByPersonId(Connection connection,String driver,String url,String username,String password,String cAccountinfo){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM c_accountinfo WHERE PERSON_ID ='"+cAccountinfo+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证censor_module
     * 参数说明:   MODULE_ID  主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsCensor(Connection connection,String driver,String url,String username,String password,String moduleId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM censor_module WHERE MODULE_ID ="+"'"+moduleId+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证定时任务表
     * 参数说明:   MODULE_ID  主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistTimeMan(Connection connection,String driver,String url,String username,String password,String timeId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM timed_task_management WHERE TTM_ID ="+"'"+timeId+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证censor_module
     * 参数说明:   MODULE_ID  主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistTimeManRecord(Connection connection,String driver,String url,String username,String password,String ttrId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM timed_task_record WHERE TTR_ID ="+"'"+ttrId+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证openfire库ofprotity表是否存在某字段
     * 参数说明:   paramName key值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistOpenFire(Connection connection,String driver,String url,String username,String password,String name){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM ofproperty WHERE  name ="+"'"+name+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }



    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月17日 下午16:32:00
     * 方法介绍:   验证某表是否存在数据
     * 参数说明:   id ID值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public static boolean CheckIsExist(Connection connection,String driver,String table,String columns,String id){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM "+ table +" WHERE "+ columns +"="+id;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年11月28日 下午16:32:00
     * 方法介绍:   验证department表是否存在数据
     * 参数说明:   DEPT_ID 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistDept(Connection connection,String driver,String url,String username,String password,String deptId){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM department WHERE DEPT_ID ="+deptId;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   张丽军
     * 创建日期:   2018年11月28日 下午16:32:00
     * 方法介绍:   验证department表是否存在数据
     * 参数说明:   DEPT_ID 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistDept1(Connection connection,String driver,String url,String username,String password,String deptParent){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM department WHERE DEPT_PARENT ="+deptParent;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   刘建
     * 创建日期:   2019年07月14日 下午13:32:00
     * 方法介绍:   验证表字段长度是否符合规定
     * 参数说明:   table 表名
     * 返回值说明:  true 符合 false 不符合
     */
    public   static boolean  CheckIsExistUserLength(Connection connection,String driver,String url,String table,String field ,String length){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT CHARACTER_MAXIMUM_LENGTH FROM `information_schema`.`COLUMNS` WHERE `TABLE_NAME`='"+table+"' AND `TABLE_SCHEMA`= '"+url+"' AND `COLUMN_NAME`='"+field+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                if(length.equals(rs.getString(1))){
                    flag =true;
                }
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistAttend_set(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from attend_set where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static  List<Map<String,Object>> CheckIsExistSql(HttpServletRequest request, Connection conn, String driver, String url, String username, String password, String sql, String runId) {
        ToJson<Users> toJson = new ToJson<>();
        List<Map<String,Object>> results=new ArrayList<Map<String,Object>>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users(),redisSessionId);
        HashMap itemMap =  new HashMap();
        itemMap.put("[SYS_USER_ID]",users.getUserId());
        itemMap.put("[SYS_DEPT_ID]",users.getDeptId());
        itemMap.put("[SYS_PRIV_ID]",users.getUserPriv());
        itemMap.put("[SYS_PRIV_NO]",users.getUserPrivNo());
        itemMap.put("[SYS_RUN_ID]",runId);

        Iterator<Map.Entry<String, Object>> it = itemMap.entrySet().iterator();

        while(it.hasNext()) {
            Map.Entry<String, Object> entry = it.next();
            if (sql.indexOf(entry.getKey()) > -1) {
                sql = sql.replace(String.valueOf(entry.getKey()), String.valueOf(entry.getValue()));
            }

        }
        Statement st=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动

            st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            ResultSetMetaData rsmd = rs.getMetaData();
            int count = rsmd.getColumnCount();

            List<String> colNameList=new ArrayList<String>();
            for(int i=0;i<count;i++){
                colNameList.add(rsmd.getColumnName(i+1));
            }
            while(rs.next()) {
                for (int i = 0; i < count; i++) {
                    Map map = new HashMap<String, Object>();
                    String key = colNameList.get(i);
                    Object value = rs.getString(colNameList.get(i));
                    map.put(key, value);
                    results.add(map);
                }
            }
            toJson.setFlag(0);
          /*  while(rs.next()){
                maps.put(rs.getString());
                String name = rs.getString(1);
                toJson.setFlag(0);
                toJson.setObject(name);
            }*/
            rs.close();
            st.close();
        } catch (IOException e) {

            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {

            e.printStackTrace();
        }

        return results;
//        try {
//            String sqlNew ="";
//            //表示当前用户的用户ID
//            String a = "`[SYS_USER_ID]`";
//            String b = "`[SYS_DEPT_ID]`";
//            String c = "`[SYS_PRIV_ID]`";
//            String d = "`[SYS_PRIV_NO]`";
//            if(sql!=null&&sql!=""){
//
//                boolean status = sql.contains(a);
//                boolean status1 = sql.contains(b);
//                boolean status2 = sql.contains(c);
//                boolean status3 = sql.contains(d);
//                if(status) {
//                    //包含
//                    //方法1、自带函数解决(把SYS_USER_ID替换成userId)
//
//                    sqlNew=sql.replace(a,"'"+userId+"'");
//
//                    Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
//                    Class.forName(driver);//加载驱动
//                    String sqlE = sqlNew;
//
//                    Statement st = conn.createStatement();
//                    ResultSet rs = st.executeQuery(sqlNew);//执行SQL语句
//                    while(rs.next()){
//                        String name = rs.getString(1);
//                        toJson.setFlag(0);
//                        toJson.setObject(name);
//                    }
//                    rs.close();
//                    st.close();
//                } else{
//                   //不包含
//                    toJson.setFlag(1);
//                }
//
//                if(status1) {
//                    //包含
//                    //方法1、自带函数解决(SYS_DEPT_ID替换成deptId)
//                    if(sql.contains(b)){
//                        sql=sql.replaceAll(b,"'"+String.valueOf(deptId)+"'");
//                    }
//                    Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
//                    Class.forName(driver);//加载驱动
//                    String sqlE = sql;
//
//                    Statement st = conn.createStatement();
//                    ResultSet rs = st.executeQuery(sqlE);//执行SQL语句
//                    while(rs.next()){
//                        String name = rs.getString(1);
//                        toJson.setFlag(0);
//                        toJson.setObject(name);
//                    }
//                    rs.close();
//                    st.close();
//                } else{
//                    //不包含
//                    toJson.setFlag(1);
//                }
//
//                if(status2) {
//                    //包含
//                    //方法1、自带函数解决(SYS_PRIV_ID替换成privId)
//                    if(sql.contains(c)){
//                        sql=sql.replaceAll(c,"'"+String.valueOf(privId)+"'");
//                    }
//                    Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
//                    Class.forName(driver);//加载驱动
//                    String sqlE = sql;
//
//                    Statement st = conn.createStatement();
//                    ResultSet rs = st.executeQuery(sqlE);//执行SQL语句
//                   // StringBuffer suf = new StringBuffer();
//                    while(rs.next()){
//                      /*  suf.append(rs.getString(1));
//                        suf.append(",");*/
//                        String name = rs.getString(1);
//                        toJson.setFlag(0);
//                        toJson.setObject(name);
//                    }
//                    rs.close();
//                    st.close();
//                } else{
//                    //不包含
//                    toJson.setFlag(1);
//                }
//
//
//                if(status3) {
//                    //包含
//                    //方法1、自带函数解决(SYS_PRIV_NO替换成privNo)
//                    if(sql.contains(d)){
//                        sql=sql.replaceAll(d,String.valueOf(privId));
//                    }
//                    Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
//                    Class.forName(driver);//加载驱动
//                    String sqlE = sql;
//
//                    Statement st = conn.createStatement();
//                    ResultSet rs = st.executeQuery(sqlE);//执行SQL语句
//                    while(rs.next()){
//                        String name = rs.getString(1);
//                        toJson.setFlag(0);
//                        toJson.setObject(name);
//                    }
//                    rs.close();
//                    st.close();
//                } else{
//                    //不包含
//                    toJson.setFlag(1);
//                }
//            }
//
//        } catch (Exception e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }


    }

    public static boolean CheckIsExistCp_asset_type(Connection conn, String driver, String url, String username, String password, String typeId) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM cp_asset_type WHERE TYPE_ID ="+typeId;

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistPortals(Connection conn, String driver, String url, String username, String password, String portalsId) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM portals WHERE portals_id ="+portalsId;

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistPortalsCRM(Connection conn, String driver, String url, String username, String password, String portalId ,String portalName) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM `portals` WHERE `portals_id` ="+portalId +" and `portal_name` ="+"'"+portalName+"'";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    public static boolean CheckIsExistweixin(Connection conn, String driver, String url, String username, String password, String funcId) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM `sys_function` WHERE `FUNC_ID` ="+funcId;
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCms_site_info(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from cms_site_info where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCms_channel_info(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from cms_channel_info where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCms_chnldoc(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from cms_chnldoc where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCms_document_info(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from cms_document_info where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   张丽军
     * 创建日期:   2019年3月26日 下午16:32:00
     * 方法介绍:   验证attend_set表是否存在数据
     * 参数说明:   sid 主键值
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistCms_site_template(Connection connection,String driver,String url,String username,String password,String sid){
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "select * from cms_site_template where sid ="+sid;

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证sys_para
     * 参数说明:   paraName  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistFlow_form_type(Connection connection,String driver,String url,String username,String password,String formName){
        boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM flow_form_type WHERE FORM_NAME ="+"'"+formName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证sys_para
     * 参数说明:   paraName  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static boolean  CheckIsExistForm_sort(Connection connection,String driver,String url,String username,String password,String formName){
        boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String sql = "SELECT * FROM form_sort WHERE SORT_NAME ="+"'"+formName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);//执行SQL语句
            while(rs.next()){
                flag =true;
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }


    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证sys_para
     * 参数说明:   paraName  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static String  CheckIsExistFlow_form_type1(Connection connection,String driver,String url,String username,String password,String formName){
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "SELECT * FROM flow_form_type WHERE FORM_NAME ="+"'"+formName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("FORM_ID");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    /**
     * 创建作者:   高亚峰
     * 创建日期:   2018年1月12日 下午12:32:00
     * 方法介绍:   验证sys_para
     * 参数说明:   paraName  主菜单主键
     * 返回值说明:  true 表示已经存在 false不存在
     */
    public   static String  CheckIsExistFlow_sort(Connection connection,String driver,String url,String username,String password,String sortName){
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "SELECT * FROM flow_sort WHERE SORT_NAME ="+"'"+sortName+"'";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("SORT_ID");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistll(Connection conn, String driver, String url, String username, String password) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "show index from sms_body where Key_name='BODY_ID' ";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                ResultSetMetaData rsm = rs.getMetaData();
                //ResultSetMetaData 接口创建一个对象，可使用该对象找出 ResultSet 中的各列的类型和属性。
                int size=rsm.getColumnCount();                           //每行列数
                HashMap  row = new HashMap();
                for (int j = 1; j <=size; j++)
                {
                    row.put(rsm.getColumnLabel(j), rs.getObject(j));
                }
                if(size>0){
                    flag= true;}

            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
    public static boolean CheckIsExistlk(Connection conn, String driver, String url, String username, String password) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "show index from sms_body where Key_name='REMIND_URL'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                ResultSetMetaData rsm = rs.getMetaData();
                //ResultSetMetaData 接口创建一个对象，可使用该对象找出 ResultSet 中的各列的类型和属性。
                int size=rsm.getColumnCount();                           //每行列数
                HashMap  row = new HashMap();
                for (int j = 1; j <=size; j++)
                {
                    row.put(rsm.getColumnLabel(j), rs.getObject(j));
                }
                if(size>0){
                    flag= true;}
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistly(Connection conn, String driver, String url, String username, String password) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "show index from im_message where Key_name='UUID'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                ResultSetMetaData rsm = rs.getMetaData();
                //ResultSetMetaData 接口创建一个对象，可使用该对象找出 ResultSet 中的各列的类型和属性。
                int size=rsm.getColumnCount();                           //每行列数
                HashMap  row = new HashMap();
                for (int j = 1; j <=size; j++)
                {
                    row.put(rsm.getColumnLabel(j), rs.getObject(j));
                }
                if(size>0){
                    flag= true;}
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistlh(Connection conn, String driver, String url, String username, String password) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "show index from im_message where Key_name='FROM_UID'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                ResultSetMetaData rsm = rs.getMetaData();
                //ResultSetMetaData 接口创建一个对象，可使用该对象找出 ResultSet 中的各列的类型和属性。
                int size=rsm.getColumnCount();                           //每行列数
                HashMap  row = new HashMap();
                for (int j = 1; j <=size; j++)
                {
                    row.put(rsm.getColumnLabel(j), rs.getObject(j));
                }
                if(size>0){
                    flag= true;}
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean CheckIsExistlt(Connection conn, String driver, String url, String username, String password) {
        Boolean flag=false;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "show index from im_message where Key_name='TO_UID'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                ResultSetMetaData rsm = rs.getMetaData();
                //ResultSetMetaData 接口创建一个对象，可使用该对象找出 ResultSet 中的各列的类型和属性。
                int size=rsm.getColumnCount();                           //每行列数
                HashMap  row = new HashMap();
                for (int j = 1; j <=size; j++)
                {
                    row.put(rsm.getColumnLabel(j), rs.getObject(j));
                }
                if(size>0){
                    flag= true;}
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static String CheckIsExistForm_sort1(Connection conn, String driver, String url, String username, String password, String formName) {
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "SELECT * FROM form_sort WHERE SORT_NAME ="+"'"+formName+"'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("SORT_ID");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static String CheckIsExistFlow_type_id(Connection conn, String driver, String url, String username, String password, String formName) {
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "SELECT * FROM flow_type WHERE FLOW_NAME ="+"'"+formName+"'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("FLOW_ID");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static String CheckIsExistFlow_hook_id(Connection conn, String driver, String url, String username, String password, String formName) {
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "SELECT * FROM flow_hook WHERE flow_id ="+"'"+formName+"'";

            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("hid");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }

    public static String  getFlowSortNo(Connection connection,String driver,String url,String username,String password){
        String flag=null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            Class.forName(driver);//加载驱动
            String formId = "select max(SORT_NO) as a  from flow_sort ";

            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(formId);//执行SQL语句
            while(rs.next()){
                flag =rs.getString("a");
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return flag;
    }
}
