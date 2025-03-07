package com.xoa.service.common.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.util.dataSource.Verification;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

public class HistorySql{
    
    
    public static void historySql(Integer oid) throws Exception {
        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
        String url = props.getProperty("url" + oid);

        String driver = props.getProperty("driverClassName");
        String username = props.getProperty("uname" + oid);
        String password = props.getProperty("password" + oid);
        Class.forName(driver).newInstance();
        Connection conn = (Connection) DriverManager.getConnection(url, username, password);
        /*     *
         *  添加字段的作用: 添加字段
         */
        boolean checkIsExistfield_2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_function", "ISOPEN_NEW");
        if (checkIsExistfield_2 == false) {
            String sql = "ALTER TABLE sys_function add ISOPEN_NEW varchar(10) null;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        //添加字段
        boolean sys_function22 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_function", "SEND_USER");
        if (sys_function22 == false) {
            String sql = "ALTER TABLE sys_function ADD SEND_USER CHAR ( 10 ) comment '1开启/0关闭(传递加密后的用户信息)';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        //添加字段
        boolean sys_function23 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_function", "SEND_KEY");
        if (sys_function23 == false) {
            String sql = "ALTER TABLE sys_function ADD SEND_KEY VARCHAR ( 255 ) comment '密钥';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /*   *
         *  添加字段的作用: 添加菜单
         */
        boolean checkIsExistFunction_12 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2041");
        if (checkIsExistFunction_12 == true) {
            String sql = "update sys_function set MENU_ID ='606501' where FUNC_ID=2041;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  *
         *  添加字段的作用: 修改推送消息
         */
        boolean isExistThing = Verification.CheckIsExistThing(conn, driver, url, username, password, "340");
        boolean isExistThing_1 = Verification.CheckIsExistThing(conn, driver, url, username, password, "341");
        boolean isExistThing_2 = Verification.CheckIsExistThing(conn, driver, url, username, password, "342");
        boolean isExistThing_3 = Verification.CheckIsExistThing(conn, driver, url, username, password, "343");
        if (isExistThing == true && isExistThing_1 == true && isExistThing_2 == true && isExistThing_3 == true) {
            String sql = "UPDATE flow_trigger SET `PLUGIN`=0 WHERE ID=340 OR ID=341 OR ID=342 OR ID=343;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
        }


        /*                    *
         *  作用: 创建htmldocument表
         */
        boolean existTable = Verification.CheckIsExistTable(conn, driver, url, username, password, "htmldocument");
        if (existTable == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `htmldocument` (\n" +
                    "  `AutoNo` int(11) NOT NULL AUTO_INCREMENT,\n" +
                    "  `DocumentID` varchar(50) DEFAULT NULL,\n" +
                    "  `XYBH` varchar(64) DEFAULT NULL,\n" +
                    "  `BMJH` varchar(20) DEFAULT NULL,\n" +
                    "  `JF` varchar(128) DEFAULT NULL,\n" +
                    "  `YF` varchar(128) DEFAULT NULL,\n" +
                    "  `HZNR` text,\n" +
                    "  `QLZR` text,\n" +
                    "  `CPMC` varchar(254) DEFAULT NULL,\n" +
                    "  `DGSL` varchar(254) DEFAULT NULL,\n" +
                    "  `DGRQ` varchar(254) DEFAULT NULL,\n" +
                    "  PRIMARY KEY (`AutoNo`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /*   *
         *  作用: 创建htmlhistory表
         */
        boolean existTable_1 = Verification.CheckIsExistTable(conn, driver, url, username, password, "htmlhistory");
        if (existTable_1 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `htmlhistory` (\n" +
                    "  `AutoNo` int(11) NOT NULL AUTO_INCREMENT,\n" +
                    "  `DocumentID` varchar(50) DEFAULT NULL,\n" +
                    "  `SignatureID` varchar(50) DEFAULT NULL,\n" +
                    "  `SignatureName` varchar(50) DEFAULT NULL,\n" +
                    "  `SignatureUnit` varchar(50) DEFAULT NULL,\n" +
                    "  `SignatureUser` varchar(50) DEFAULT NULL,\n" +
                    "  `KeySN` varchar(50) DEFAULT NULL,\n" +
                    "  `SignatureSN` varchar(200) DEFAULT NULL,\n" +
                    "  `SignatureGUID` varchar(50) DEFAULT NULL,\n" +
                    "  `IP` varchar(50) DEFAULT NULL,\n" +
                    "  `LogType` varchar(20) DEFAULT NULL,\n" +
                    "  `LogTime` varchar(20) DEFAULT NULL,\n" +
                    "  PRIMARY KEY (`AutoNo`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /*   *
         *  作用: htmlsignature
         */
        boolean existTable_2 = Verification.CheckIsExistTable(conn, driver, url, username, password, "htmlsignature");
        if (existTable_2 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `htmlsignature` (\n" +
                    "  `DocumentID` varchar(254) DEFAULT NULL,\n" +
                    "  `Signature` text,\n" +
                    "  `SignatureID` varchar(64) DEFAULT NULL\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /*   *
         *  作用: 创建kg_relation_keysign表
         */
        boolean existTable_4 = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_relation_keysign");
        if (existTable_4 == false) {

            String sql = "CREATE TABLE IF NOT EXISTS `kg_relation_keysign` (\n" +
                    "  `RELATION_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '关系ID'," +
                    "  `KEY_ID` int(11) DEFAULT NULL," +
                    "  `SIGN_ID` int(11) DEFAULT NULL," +
                    "  PRIMARY KEY (`RELATION_ID`)" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /*    *
         *  作用: 添加数据
         */
        boolean b = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "1");
        if (b == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('1', '1', '1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_1 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "1");
        if (check_1 == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('1', '1', '1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   *
         *  作用: 添加数据
         */
        boolean check_2 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "2");
        if (check_2 == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('2', '1', '2');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*      *
         *  作用: 添加数据
         */
        boolean check_3 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "3");
        if (check_3 == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('3', '1', '3');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_4 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "4");
        if (check_4 == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('4', '1', '5');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 添加数据
         */
        boolean check_5 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "5");
        if (check_5 == false) {
            String sql = "INSERT INTO `kg_relation_keysign` VALUES ('5', '2', '4');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }




        /*  *
         *  作用: 创建kg_relation_keyuser表
         */
        boolean existTable_5 = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_relation_keyuser");
        if (existTable_5 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `kg_relation_keyuser` (\n" +
                    "  `KEY_USER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                    "  `USER_ID` int(11) DEFAULT NULL COMMENT '用户UID',\n" +
                    "  `KEY_ID` int(11) DEFAULT NULL COMMENT 'keyId',\n" +
                    "  PRIMARY KEY (`KEY_USER_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /*     *
         *  作用: 添加数据
         */
        boolean check_6 = Verification.CheckIsExistKgkeyUser(conn, driver, url, username, password, "1");
        if (check_6 == false) {
            String sql = "INSERT INTO `kg_relation_keyuser` VALUES ('1', '1', '1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*     *
         *  作用: 添加数据
         */
        boolean check_7 = Verification.CheckIsExistKgkeyUser(conn, driver, url, username, password, "2");
        if (check_7 == false) {
            String sql = "INSERT INTO `kg_relation_keyuser` VALUES ('2', '1', '2');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 创建kg_relation_keyuser表
         */
        boolean existTable_6 = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_signature");
        if (existTable_6 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `kg_signature` (\n" +
                    "  `SIGNATURE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                    "  `SIGNATURE_NAME` varchar(255) DEFAULT NULL COMMENT '签章名称',\n" +
                    "  `SIGNATURE_UNIT` varchar(255) DEFAULT NULL COMMENT '单位名称',\n" +
                    "  `SIGNATURE_KGID` varchar(255) DEFAULT NULL COMMENT '金格签章id',\n" +
                    "  `SIGNATURE_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常，1禁制使用，-1删除',\n" +
                    "  PRIMARY KEY (`SIGNATURE_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_8 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "1");
        if (check_8 == false) {
            String sql = "INSERT INTO `kg_signature` (`SIGNATURE_ID`, `SIGNATURE_NAME`, `SIGNATURE_UNIT`, `SIGNATURE_KGID`, `SIGNATURE_STATUS`) VALUES ('1', '金格演示公章', '北京高速波科技有限公司', 'BCxhL9mkEgv2dFTcpQHz8uUtNiqIXG35+rYJj1lfeb/KO4=yaWV0DSAPnw67oZsRM', '-1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /* *
         *  作用: 添加数据
         */
        boolean check_12 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "2");
        if (check_12 == false) {
            String sql = "INSERT INTO `kg_signature` (`SIGNATURE_ID`, `SIGNATURE_NAME`, `SIGNATURE_UNIT`, `SIGNATURE_KGID`, `SIGNATURE_STATUS`) VALUES ('2', '金格演示合同章', '北京高速波科技有限公司', 'M=dUfvWPYlTLAOt70V9p1x5nRFm2aizZc3b/w+8SGhXj6JEoIQyNHCkrsguDeqB4K', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 添加数据
         */
        boolean check_9 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "3");
        if (check_9 == false) {
            String sql = "INSERT INTO `kg_signature` (`SIGNATURE_ID`, `SIGNATURE_NAME`, `SIGNATURE_UNIT`, `SIGNATURE_KGID`, `SIGNATURE_STATUS`) VALUES ('3', '金格科技私章1X2.24', '北京高速波科技有限公司', '0myIz5atpgOPbM8wYqiLWnAuBJXDrSjE9U376VFkT=KxeRhf+vosNC1Gc4/HdZQl2', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_10 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "4");
        if (check_10 == false) {
            String sql = "INSERT INTO `kg_signature` (`SIGNATURE_ID`, `SIGNATURE_NAME`, `SIGNATURE_UNIT`, `SIGNATURE_KGID`, `SIGNATURE_STATUS`) VALUES ('4', '金格演示发票专用章', '北京高速波科技有限公司', '0wAeTICLvyhqi1KJkOgsarYNQ5BUGEmSV8Z23P94lfno=M6pjFDdxuz+/cX7bHWRt', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_11 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "5");
        if (check_11 == false) {
            String sql = "INSERT INTO `kg_signature` (`SIGNATURE_ID`, `SIGNATURE_NAME`, `SIGNATURE_UNIT`, `SIGNATURE_KGID`, `SIGNATURE_STATUS`) VALUES ('5', '金格演示合同章1', '北京高速波科技有限公司', '8x2=rAUbHvF3/4dQDaptogRz70mfMI6LNCsnKV9SqYiPWXZE1euhyTkj+JOwlGB5c', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /*  *
         *  作用: 创建kg_relation_keyuser表
         */
        boolean existTable_7 = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_signkey");
        if (existTable_7 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `kg_signkey` (\n" +
                    "  `SIGNKEY_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                    "  `SIGNKEY_NAME` varchar(255) DEFAULT NULL COMMENT '名称',\n" +
                    "  `SIGNKEY_KEYSN` varchar(255) DEFAULT NULL COMMENT '金格签章keysn',\n" +
                    "  `SIGNKEY_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常 -1 停止使用',\n" +
                    "  PRIMARY KEY (`SIGNKEY_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /*   *
         *  作用: 添加数据
         */
        boolean check_13 = Verification.CheckIsExistkgSignKey(conn, driver, url, username, password, "1");
        if (check_13 == false) {
            String sql = "INSERT INTO `kg_signkey` VALUES ('1', '测试盘1', 'C84CF78C359E757E', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  作用: 添加数据
         */
        boolean check_14 = Verification.CheckIsExistkgSignKey(conn, driver, url, username, password, "2");
        if (check_14 == false) {
            String sql = "INSERT INTO `kg_signkey` VALUES ('2', '测试盘2', '44871127553E5D00', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*  *
         *  作用: 添加数据
         */
        boolean widget = Verification.CheckIsExistWidget(conn, driver, url, username, password, "8");
        if (widget == false) {
            String sql = "INSERT INTO `widget` (`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES ('8', '公文', '0', '0', 'document', '1', '1', '7');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         *  作用: 更新菜单数据 版本号 2018.01.26.1之后
         */


        boolean existCode = Verification.CheckCode(conn, driver, url, username, password, "976");
        if (existCode == false) {
            String sql = "INSERT INTO `sys_code` VALUES ('976', '141', '加班申请', null, null, null, null, null, null, '141', 'KQQJTYPE', '0', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         *  2018-02-05  季佳伟
         *  作用:  添加字段的作用: 添加user 表字段
         */
        boolean isExistfield_10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "MYTABLE_MID");
        if (isExistfield_10 == false) {
            String sql = "alter table `user` add MYTABLE_MID varchar(200) DEFAULT 'ALL' comment'中间的桌面模块';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         * 2018-02-05  季佳伟
         *  作用:  添加字段的作用: 添加user 表字段
         */
        boolean isExistfield_11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "ID_NUMBER");
        if (isExistfield_11 == false) {
            String sql = "alter table `user` add ID_NUMBER varchar(100) DEFAULT NULL comment'身份证号';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 2018-02-05  季佳伟
         *  作用:  添加字段的作用: 添加user 表字段
         */
        boolean isExistfield_12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "TRA_NUMBER");
        if (isExistfield_12 == false) {
            String sql = "alter table `user` add TRA_NUMBER varchar(100) DEFAULT NULL comment'培训编号';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 2018-02-05  季佳伟
         *  作用:  添加字段的作用: 添加user 表字段
         */
        boolean isExistfield_13 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "SUBJECT");
        if (isExistfield_13 == false) {
            String sql = "alter table `user` add SUBJECT varchar(100) DEFAULT NULL comment'学科';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /** 2018-02-07  高亚峰
         *  作用: 更新二级菜单数据
         */
        boolean sys_function = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3014");
        if (sys_function == true) {
            String sql = "UPDATE sys_function SET FUNC_CODE ='@document/setting' WHERE FUNC_ID =3014;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  2018-02-07 高亚峰
         *  作用:  删除kg_relation_keyuser表
         */
        boolean drop_table = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_signature");
        if (drop_table == true) {
            String sql = "DROP TABLE IF EXISTS `kg_signature`;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**    2018-02-07 高亚峰
         *  作用:  创建kg_relation_keyuser表
         */
        boolean create_table = Verification.CheckIsExistTable(conn, driver, url, username, password, "kg_signature");
        if (create_table == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `kg_signature` (\n" +
                    "  `SIGNATURE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                    "  `SIGNATURE_NAME` varchar(255) DEFAULT NULL COMMENT '签章名称',\n" +
                    "  `SIGNATURE_UNIT` varchar(255) DEFAULT NULL COMMENT '单位名称',\n" +
                    "  `SIGNATURE_KGID` varchar(255) DEFAULT NULL COMMENT '金格签章id',\n" +
                    "  `SIGNATURE_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常，1禁制使用，-1删除',\n" +
                    "  PRIMARY KEY (`SIGNATURE_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "1");
        if (insert == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('1', '金格演示公章', '北京高速波科技有限公司', 'BCxhL9mkEgv2dFTcpQHz8uUtNiqIXG35+rYJj1lfeb/KO4=yaWV0DSAPnw67oZsRM', '-1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_1 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "2");
        if (insert_1 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('2', '金格演示合同章', '北京高速波科技有限公司', 'M=dUfvWPYlTLAOt70V9p1x5nRFm2aizZc3b/w+8SGhXj6JEoIQyNHCkrsguDeqB4K', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_2 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "3");
        if (insert_2 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('3', '金格科技私章1X2.24', '北京高速波科技有限公司', '0myIz5atpgOPbM8wYqiLWnAuBJXDrSjE9U376VFkT=KxeRhf+vosNC1Gc4/HdZQl2', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_3 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "4");
        if (insert_3 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('4', '金格演示发票专用章', '北京高速波科技有限公司', '0wAeTICLvyhqi1KJkOgsarYNQ5BUGEmSV8Z23P94lfno=M6pjFDdxuz+/cX7bHWRt', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_4 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "5");
        if (insert_4 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('5', '金格演示合同章1', '北京高速波科技有限公司', '8x2=rAUbHvF3/4dQDaptogRz70mfMI6LNCsnKV9SqYiPWXZE1euhyTkj+JOwlGB5c', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_5 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "6");
        if (insert_5 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('6', '心通达演示公章', '北京高速波科技有限公司', '3KLmcTy0VR5FjgoAWeb7YBO24C1JsU8iqfzrQ9dNanu=MG/Sxk6ZwhtDEHXvlP+Ip', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_6 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "7");
        if (insert_6 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('7', '心通达演示发票专用章', '北京高速波科技有限公司', 'PFxBSYkjo80hi4H15=mfzdM97bX6GK3URc/+ENOnDAqQIvsTtaJZLwuyeglrWCVp2', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*   2018-02-07 高亚峰
         *  作用: 添加kg_relation_keyuser表数据
         */
        boolean insert_7 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "8");
        if (insert_7 == false) {
            String sql = "INSERT INTO `kg_signature` VALUES ('8', '心通达演示合同章', '北京高速波科技有限公司', 'xytDQgAwfJ23=GvXWd1jShRl7BEeMib0+No/4UK9aT8CpcHm6VsOkqIuP5nLFYrzZ', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /**   2018-02-07  高亚峰
         *  作用: 修改活动类别数据类型
         */
        boolean checkIsExistfield2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "schedule", "schedule_type");
        if (checkIsExistfield2 == true) {
            String sql = "ALTER TABLE `schedule`MODIFY COLUMN `schedule_type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动类别' AFTER `create_time`;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*  2018-02-28 高亚峰
         *  修改表名称
         */
        boolean checkIsExistportals = Verification.CheckIsExistTable(conn, driver, url, username, password, "portals1");
        if (checkIsExistportals == false) {
            String sql = "alter table portals rename portals1";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /** 2018-03-05  高亚峰
         *  作用: 增加二级菜单数据
         */
        boolean function1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2042");
        if (function1 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('2042', 'z070', '短信设置', 'SMS settings', '簡訊設定', '', '', '', 'smsSettings/index', '', '0','','')";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-03-14 高亚峰
         *      创建表document_org
         */
        boolean table_exist = Verification.CheckIsExistTable(conn, driver, url, username, password, "document_org");
        if (table_exist == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `document_org` (\n" +
                    "  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `title` varchar(255) DEFAULT NULL COMMENT '标题',\n" +
                    "  `key_word` varchar(255) DEFAULT NULL COMMENT '主题词',\n" +
                    "  `unit` varchar(255) DEFAULT NULL COMMENT '来文单位/发文单位',\n" +
                    "  `doc_no` varchar(255) DEFAULT NULL COMMENT '文号',\n" +
                    "  `urgency` varchar(255) DEFAULT NULL COMMENT '紧急程度(0急件1特急2加急)',\n" +
                    "  `secrecy` varchar(255) DEFAULT NULL COMMENT '机密等级(0秘密1机密2绝密)',\n" +
                    "  `main_delivery` varchar(255) DEFAULT NULL COMMENT '主送',\n" +
                    "  `copy_delivery` varchar(255) DEFAULT NULL COMMENT '抄送',\n" +
                    "  `deadline` int(11) DEFAULT NULL COMMENT '保存期限',\n" +
                    "  `copies` int(11) DEFAULT NULL COMMENT '份数',\n" +
                    "  `remark` text COMMENT '附注',\n" +
                    "  `creater` varchar(255) DEFAULT NULL COMMENT '发文人',\n" +
                    "  `create_dept` varchar(255) DEFAULT NULL COMMENT '发文部门',\n" +
                    "  `print_dept` varchar(255) DEFAULT NULL COMMENT '印发机关',\n" +
                    "  `print_date` date DEFAULT NULL COMMENT '印发日期',\n" +
                    "  `document_type` varchar(255) DEFAULT NULL COMMENT '公文类型(1收文0发文)',\n" +
                    "  `dispatch_type` varchar(255) DEFAULT NULL COMMENT '公文种类(公告、通告、通知。。。)',\n" +
                    "  `main_file` varchar(255) DEFAULT NULL COMMENT '正文ID',\n" +
                    "  `main_file_name` varchar(255) DEFAULT NULL COMMENT '正文名称',\n" +
                    "  `pages` int(11) DEFAULT NULL COMMENT '正文页数',\n" +
                    "  `content` text COMMENT '正文内容',\n" +
                    "  `main_aip_file` varchar(255) DEFAULT NULL COMMENT '版式正文ID',\n" +
                    "  `main_aip_file_name` varchar(255) DEFAULT NULL COMMENT '版式正文名称',\n" +
                    "  `public_flag` varchar(255) DEFAULT NULL COMMENT '拟公开属性（0不予公开1依申请公开2主动公开）',\n" +
                    "  `print_copies` int(11) DEFAULT NULL COMMENT '打印份数',\n" +
                    "  `print_user` varchar(11) DEFAULT NULL COMMENT '打印人',\n" +
                    "  `flow_id` int(11) DEFAULT NULL COMMENT '流程类型',\n" +
                    "  `run_id` int(11) DEFAULT NULL COMMENT '流水号',\n" +
                    "  `flow_run_name` varchar(255) DEFAULT NULL COMMENT '流程名称',\n" +
                    "  `flow_status` varchar(255) DEFAULT '0' COMMENT '流程状态（办理中0、已结束1）',\n" +
                    "  `flow_prcs` varchar(255) DEFAULT '1' COMMENT '流程步骤（当前处于什么步骤）',\n" +
                    "  `cur_user_id` varchar(255) DEFAULT NULL COMMENT '当前经办人id',\n" +
                    "  `all_user_id` varchar(255) DEFAULT NULL COMMENT '全部经办人id',\n" +
                    "  `transfer_flag` int(1) DEFAULT NULL COMMENT '转交状态(0-未转交 1-已转交)',\n" +
                    "  `org_flag` int(1) DEFAULT NULL COMMENT '是否是上级组织（0-不是上级组织 1-上级组织）',\n" +
                    "  `transfer_org` varchar(255) DEFAULT NULL COMMENT '转交组织',\n" +
                    "  `transfer_user` varchar(255) DEFAULT NULL COMMENT '转交人',\n" +
                    "  `transfer_receive_org` varchar(255) DEFAULT NULL COMMENT '转交后的接收组织',\n" +
                    "  `transfer_receive_user` varchar(255) DEFAULT NULL COMMENT '转交后的接收人',\n" +
                    "  `transfer_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '转交时间',\n" +
                    "  PRIMARY KEY (`id`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_1 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "OP_FLAG");
        if (index_1 == false) {
            String sql = "ALTER TABLE `flow_run_prcs` ADD INDEX OP_FLAG (`OP_FLAG`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_2 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "TIME_OUT_FLAG");
        if (index_2 == false) {
            String sql = "ALTER TABLE `flow_run_prcs` ADD INDEX TIME_OUT_FLAG (`TIME_OUT_FLAG`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_3 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "CHILD_RUN");
        if (index_3 == false) {
            String sql = "ALTER TABLE `flow_run_prcs` ADD INDEX CHILD_RUN (`CHILD_RUN`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_4 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "TIME_OUT");
        if (index_4 == false) {
            String sql = "ALTER TABLE `flow_run_prcs` ADD INDEX TIME_OUT (`TIME_OUT`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_5 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "file_sort", "SORT_TYPE");
        if (index_5 == false) {
            String sql = "ALTER TABLE `file_sort` ADD INDEX SORT_TYPE (`SORT_TYPE`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_6 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run", "DEL_FLAG");
        if (index_6 == false) {
            String sql = "ALTER TABLE `flow_run` ADD INDEX DEL_FLAG (`DEL_FLAG`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_7 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "user", "DEPT_ID_OTHER");
        if (index_7 == false) {
            String sql = "ALTER TABLE `user` ADD INDEX DEPT_ID_OTHER (`DEPT_ID_OTHER`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_8 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "file_content", "CREATER");
        if (index_8 == false) {
            String sql = "ALTER TABLE `file_content` ADD INDEX CREATER (`CREATER`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_9 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "email", "READ_FLAG");
        if (index_9 == false) {
            String sql = "ALTER TABLE `email` ADD INDEX READ_FLAG (`READ_FLAG`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_10 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_config", "DUTY_TYPE");
        if (index_10 == false) {
            String sql = "ALTER TABLE `attend_config` ADD INDEX DUTY_TYPE (`DUTY_TYPE`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_11 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend", "UID");
        if (index_11 == false) {
            String sql = "ALTER TABLE `attend` ADD INDEX UID (`UID`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_12 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend", "DATE");
        if (index_12 == false) {
            String sql = "ALTER TABLE `attend` ADD INDEX DATE (`DATE`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_20 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attendance_overtime", "RUN_ID");
        if (index_20 == false) {
            String sql = "alter table `attendance_overtime` add RUN_ID int(11) comment'流程实例ID';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_13 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attendance_overtime", "RUN_ID");
        if (index_13 == false) {
            String sql = "ALTER TABLE `attendance_overtime` ADD INDEX RUN_ID (`RUN_ID`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_14 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attendance_overtime", "ALLOW");
        if (index_14 == false) {
            String sql = "ALTER TABLE `attendance_overtime` ADD INDEX ALLOW (`ALLOW`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_15 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "news", "PUBLISH");
        if (index_15 == false) {
            String sql = "ALTER TABLE `news` ADD INDEX PUBLISH (`PUBLISH`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_16 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_evection", "RUN_ID");
        if (index_16 == false) {
            String sql = "ALTER TABLE `attend_evection` ADD INDEX RUN_ID (`RUN_ID`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_17 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_evection", "ALLOW");
        if (index_17 == false) {
            String sql = "ALTER TABLE `attend_evection` ADD INDEX ALLOW (`ALLOW`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_18 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_leave", "RUN_ID");
        if (index_18 == false) {
            String sql = "ALTER TABLE `attend_leave` ADD INDEX RUN_ID (`RUN_ID`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_19 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_leave", "ALLOW");
        if (index_19 == false) {
            String sql = "ALTER TABLE `attend_leave` ADD INDEX ALLOW (`ALLOW`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_30 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_out", "RUN_ID");
        if (index_30 == false) {
            String sql = "ALTER TABLE `attend_out` ADD INDEX RUN_ID (`RUN_ID`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *
         *  作用: 增加索引
         *  创建日期:2018-03-16
         *  创建者：高亚峰
         */
        boolean index_21 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_out", "ALLOW");
        if (index_21 == false) {
            String sql = "ALTER TABLE `attend_out` ADD INDEX ALLOW (`ALLOW`)";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*   *
         *  添加字段的作用: 报表设置表
         */
        boolean table_exist1 = Verification.CheckIsExistTable(conn, driver, url, username, password, "senior_re_cat");
        if (table_exist1 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `senior_re_cat` (\n" +
                    "  `SID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                    "  `COLOR` varchar(255) DEFAULT NULL,\n" +
                    "  `CAT_NAME` varchar(255) DEFAULT NULL,\n" +
                    "  `SORT_NO` int(11) DEFAULT NULL,\n" +
                    "  PRIMARY KEY (`SID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /* *
         *  添加表: 产品人力资源-创建hr_staff_contract人力资源合同管理
         */
        boolean isExistTable_13 = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_contract");
        if (isExistTable_13 == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `hr_staff_contract` (\n" +
                    "  `CONTRACT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `STAFF_NAME` varchar(254) NOT NULL COMMENT '姓名',\n" +
                    "  `STAFF_CONTRACT_NO` varchar(254) NOT NULL COMMENT '合同编号',\n" +
                    "  `CONTRACT_TYPE` varchar(254) NOT NULL COMMENT '合同类型',\n" +
                    "  `CONTRACT_SPECIALIZATION` varchar(254) NOT NULL COMMENT '合同属性(1-有固定期限,2-无固定期限)',\n" +
                    "  `MAKE_CONTRACT` date NOT NULL DEFAULT '0000-00-00' COMMENT '合同签订日期',\n" +
                    "  `TRAIL_EFFECTIVE_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '试用生效日期',\n" +
                    "  `PROBATIONARY_PERIOD` varchar(64) NOT NULL COMMENT '试用期限',\n" +
                    "  `TRAIL_OVER_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '试用到期日期',\n" +
                    "  `PASS_OR_NOT` varchar(32) NOT NULL COMMENT '合同是否转正(0-不转正,1-转正)',\n" +
                    "  `PROBATION_END_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '合同转正日期',\n" +
                    "  `PROBATION_EFFECTIVE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '合同生效日期',\n" +
                    "  `ACTIVE_PERIOD` varchar(64) NOT NULL COMMENT '合同期限',\n" +
                    "  `CONTRACT_END_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '合同到期日期',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `REMOVE_OR_NOT` varchar(32) NOT NULL COMMENT '合同是否解除(0-不解除,1-解除)',\n" +
                    "  `CONTRACT_REMOVE_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '合同解除日期',\n" +
                    "  `STATUS` varchar(254) NOT NULL COMMENT '合同状态',\n" +
                    "  `SIGN_TIMES` varchar(254) NOT NULL COMMENT '签约次数',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL COMMENT '附件名称',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  `REMIND_TIME` datetime NOT NULL COMMENT '合同到期提醒时间',\n" +
                    "  `STAFF_USER_NAME` varchar(100) NOT NULL COMMENT '合同的甲方',\n" +
                    "  `REMIND_USER` text NOT NULL COMMENT '提醒人员',\n" +
                    "  `REMIND_TYPE` int(4) NOT NULL COMMENT '提醒方式(0-不提醒,1-事务提醒,2-手机提醒)',\n" +
                    "  `HAS_REMINDED` int(4) NOT NULL COMMENT '是否已经提醒(0-未提醒,1-已提醒)',\n" +
                    "  `RENEW_TIME` varchar(254) NOT NULL DEFAULT '' COMMENT '合同续签时间',\n" +
                    "  `CONTRACT_ENTERPRIES` varchar(254) NOT NULL COMMENT '合同签约公司',\n" +
                    "  `IS_TRIAL` varchar(2) NOT NULL COMMENT '合同是否试用(0-不试用,1-试用)',\n" +
                    "  `IS_RENEW` varchar(2) NOT NULL COMMENT '合同是否续签(0-不续签,1-续签)',\n" +
                    "  `USER_NAME` varchar(254) NOT NULL COMMENT '对应USER表BYNAME',\n" +
                    "  PRIMARY KEY (`CONTRACT_ID`),\n" +
                    "  KEY `STAFF_CONTRACT` (`STAFF_CONTRACT_NO`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人力资源合同管理';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /*  2018-05-15 高亚峰
         *      创建表censor_data
         */
        boolean checkIsExistcenData = Verification.CheckIsExistTable(conn, driver, url, username, password, "censor_data");
        if (checkIsExistcenData == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `censor_data` (\n" +
                    "  `DATA_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                    "  `MODULE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '对应的模块代码',\n" +
                    "  `CENSOR_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '审核标记(0-待审核,1-审核通过,2-审核未通过)',\n" +
                    "  `CHECK_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '审核人',\n" +
                    "  `CHECK_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审核时间',\n" +
                    "  `CONTENT` mediumtext NOT NULL COMMENT '审核意见',\n" +
                    "  PRIMARY KEY (`DATA_ID`),\n" +
                    "  KEY `MODULE_CODE` (`MODULE_CODE`),\n" +
                    "  KEY `CHECK_USER` (`CHECK_USER`),\n" +
                    "  KEY `CHECK_TIME` (`CHECK_TIME`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='敏感词语待审核数据表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  创建者：  高亚峰
         *   添加表的作用: 系统代码
         *   添加时间：2018-06-1
         */
        boolean existCode_SMS = Verification.CheckIsExistCode(conn, driver, url, username, password, "23", "SMS_REMIND");
        if (existCode_SMS == false) {
            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('23', '领导活动安排', NULL, NULL, NULL, NULL, NULL, NULL, '23', 'SMS_REMIND', '0', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 文件柜容量
         *   添加时间：2018-06-1
         */
        boolean existFiled = Verification.CheckIsExistfield(conn, driver, url, username, password, "file_sort", "SPACE_USE");
        if (existFiled == false) {
            String sql = "alter table file_sort add SPACE_USE double DEFAULT '0' COMMENT '已用容量';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         *  作用: 添加是否是演示系统
         *  创建日期:2018-05-30
         *  创建者：高亚峰
         */
        boolean isExistDemo = Verification.CheckIsExistParam(conn, driver, url, username, password, "IS_CHECK_DEMO");
        if (isExistDemo == false) {
            String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('IS_CHECK_DEMO', '1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         *  作用: 工资表
         *  创建日期:2018-07-05
         *  创建者：高亚峰
         */
        boolean isExistBonus = Verification.CheckIsExistTable(conn, driver, url, username, password, "bonus");
        if (isExistBonus == false) {
            String sql = "CREATE TABLE IF NOT EXISTS  `bonus` (\n" +
                    "  `BONUS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '月份id',\n" +
                    "  `HEAD_ID` varchar(255) DEFAULT NULL COMMENT '表头标识信息',\n" +
                    "  `DATA_1` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_2` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_3` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_4` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_5` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_6` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_7` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_8` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_9` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_10` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_11` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_12` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_13` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_14` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_15` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_16` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_17` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_18` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_19` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_20` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_21` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_22` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_23` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_24` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_25` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_26` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_27` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_28` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_29` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_30` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_31` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_32` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_33` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_34` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_35` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_36` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_37` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_38` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_39` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_40` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_41` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_42` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_43` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_44` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_45` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_46` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_47` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_48` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_49` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_50` varchar(255) DEFAULT NULL COMMENT '判断工资还是奖金（1：工资，2：奖金）',\n" +
                    "  PRIMARY KEY (`BONUS_ID`) USING BTREE\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='奖金头部信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         *  作用: 工资表对应表
         *  创建日期:2018-07-05
         *  创建者：高亚峰
         */
        boolean isExistBonmsg = Verification.CheckIsExistTable(conn, driver, url, username, password, "bonusmsg");
        if (isExistBonmsg == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `bonusmsg` (\n" +
                    "  `BONUSMSG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '奖金数据信息',\n" +
                    "  `HEAD` varchar(255) DEFAULT NULL COMMENT '表头',\n" +
                    "  `DATA_1` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_2` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_3` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_4` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_5` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_6` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_7` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_8` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_9` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_10` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_11` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_12` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_13` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_14` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_15` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_16` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_17` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_18` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_19` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_20` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_21` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_22` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_23` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_24` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_25` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_26` float(255,2) DEFAULT NULL,\n" +
                    "  `DATA_27` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_28` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_29` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_30` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_31` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_32` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_33` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_34` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_35` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_36` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_37` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_38` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_39` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_40` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_41` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_42` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_43` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_44` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_45` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_46` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_47` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_48` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_49` varchar(255) DEFAULT NULL,\n" +
                    "  `DATA_50` varchar(255) DEFAULT NULL COMMENT '存储和bonus表关系，多对一',\n" +
                    "  PRIMARY KEY (`BONUSMSG_ID`) USING BTREE\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='奖金数据信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  2018-07-05  高亚峰
         *添加字段的作用: 添加工资菜单
         */
        boolean functionField6 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2045");
        if (functionField6 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('2045', '0130', '工资查询', 'Salary management', '薪水査詢', NULL, NULL, NULL, 'salary/lclb', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-05  高亚峰
         *添加字段的作用: 添加工资管理菜单
         */
        boolean functionField7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2056");
        if (functionField7 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('2056', '501101', '工资管理', 'Wage Manage', '薪水管理', NULL, NULL, NULL, 'personSalary/personLclb', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-05  高亚峰
         *添加字段的作用: 添加工资管理菜单
         */
        boolean functionField8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "55");
        if (functionField8 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('55', '5011', '薪酬管理', 'Salary Manage', '薪酬管理', NULL, NULL, NULL, '@hr', '', NULL,'','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 固定资产维修交接明细表
         *   添加时间：2018-07-17
         */
        boolean edu_transfer = Verification.CheckIsExistTable(conn, driver, url, username, password, "edu_transfer");
        if (edu_transfer == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `edu_transfer` (\n" +
                    "  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                    "  `UID` varchar(255) DEFAULT NULL COMMENT 'UID',\n" +
                    "  `CREATE_TIME` varchar(100) DEFAULT NULL COMMENT '创建时间',\n" +
                    "  `UPDATE_TIME` varchar(10) DEFAULT NULL COMMENT '更新时间',\n" +
                    "  `TITLE` varchar(255) DEFAULT '' COMMENT '标题',\n" +
                    "  `MDID` int(10) unsigned DEFAULT NULL COMMENT '针对从表数据对应的主表数据ID',\n" +
                    "  `IS_FROZEN` char(1) DEFAULT '' COMMENT '锁定',\n" +
                    "  `DEPART` varchar(255) DEFAULT NULL COMMENT '领用部门',\n" +
                    "  `RECIPIENT` varchar(50) DEFAULT NULL COMMENT '领用人',\n" +
                    "  `CONDITIONS` varchar(50) DEFAULT NULL COMMENT '是否归还',\n" +
                    "  `ENDTIME` varchar(50) DEFAULT NULL COMMENT '归还时间',\n" +
                    "  `REMARKS` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='固定资产交接表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 固定资产维修交接明细表
         *   添加时间：2018-07-17
         */
        boolean edu_maintain = Verification.CheckIsExistTable(conn, driver, url, username, password, "edu_maintain");
        if (edu_maintain == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `edu_maintain` (\n" +
                    "  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                    "  `UID` varchar(255) DEFAULT NULL COMMENT 'UID',\n" +
                    "  `CREATE_TIME` varchar(100) DEFAULT NULL COMMENT '创建时间',\n" +
                    "  `UPDATE_TIME` varchar(10) DEFAULT NULL COMMENT '更新时间',\n" +
                    "  `TITLE` varchar(255) DEFAULT '' COMMENT '标题',\n" +
                    "  `MDID` int(10) unsigned DEFAULT NULL COMMENT '针对从表数据对应的主表数据ID',\n" +
                    "  `IS_FROZEN` char(1) DEFAULT '' COMMENT '锁定',\n" +
                    "  `USER` varchar(35) DEFAULT NULL COMMENT '当前使用者',\n" +
                    "  `DESCRIPTION` varchar(50) DEFAULT NULL COMMENT '问题描述',\n" +
                    "  `BUSINESS` varchar(50) DEFAULT NULL COMMENT '维修商家',\n" +
                    "  `CONTACT` varchar(50) DEFAULT NULL COMMENT '商家联系人',\n" +
                    "  `PHONE` varchar(50) DEFAULT NULL COMMENT '商家电话',\n" +
                    "  `ADDRESS` varchar(50) DEFAULT NULL COMMENT '商家地址',\n" +
                    "  `SEND` varchar(50) DEFAULT NULL COMMENT '寄件人',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='固定资产维修表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  2018-07-17  高亚峰
         *添加字段的作用: 修改大事记字段
         */
        boolean att_id = Verification.CheckIsExistfield(conn, driver, url, username, password, "timeline", "attment_id");
        if (att_id == false) {
            String sql = "ALTER table `timeline` ADD attment_id VARCHAR (255) DEFAULT NULL";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-17  高亚峰
         *添加字段的作用: 修改大事记字段
         */
        boolean att_name = Verification.CheckIsExistfield(conn, driver, url, username, password, "timeline", "attment_name");
        if (att_name == false) {
            String sql = "ALTER table `timeline` ADD attment_name VARCHAR (255) DEFAULT NULL";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-23  高亚峰
         *添加字段的作用: 通讯录增加字段
         */
        boolean user_Num = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "ROOM_NUM");
        if (user_Num == false) {
            String sql = "alter table user add COLUMN  ROOM_NUM varchar(225) COMMENT '房间号'";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-23  高亚峰
         *添加字段的作用: 值班管理
         */
        boolean user_Dept = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "DEPT_YJ");
        if (user_Dept == false) {
            String sql = "alter table user add COLUMN  DEPT_YJ varchar(225) COMMENT '一级部门'";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*  *//**
         *  添加者：高亚峰
         *  添加日期：2018-7-27
         *  添加字段的作用: Office在线预览网址
         */
        boolean document_flag = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "DOCUMENT_PREVIEW");
        if (document_flag == false) {
            String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('DOCUMENT_PREVIEW ', 'https://owa-box.vips100.com');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
            //如果需要执行多个则用&&符判断
        }



        /*  *//**
         *  添加者：高亚峰
         *  添加日期：2018-7-27
         *  添加字段的作用: Office在线预览开关
         */
        boolean documentOpen_flag = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "DOCUMENT_PREVIEW_OPEN");
        if (documentOpen_flag == false) {
            String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('DOCUMENT_PREVIEW_OPEN', '1');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
            //如果需要执行多个则用&&符判断
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean adress_flag = Verification.CheckIsExistFunction(conn, driver, url, username, password, "10");
        if (adress_flag == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('10', '0132', '通讯簿', 'address book', '通訊錄', NULL, NULL, NULL, 'address/index', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean resoure_flag = Verification.CheckIsExistFunction(conn, driver, url, username, password, "100");
        if (resoure_flag == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('100', 'z065', '系统资源管理', 'Resource Manage', '\\r\\n\\r\\n系统资源管理\\r\\n\\r\\n系統資源管理', NULL, NULL, NULL, 'disk/system', '', NULL,'','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "122");
        if (flag_2 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('122', '5009', '绩效考核', 'Performance Appraisal', '績效考核', NULL, NULL, NULL, '@score', '', NULL,'','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "123");
        if (flag_3 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('123', '500901', '考核项目设定', 'Check Setting', '考核項目設定', NULL, NULL, NULL, '/ScoreGroupController/scoreGroup', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "124");
        if (flag_4 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('124', '500903', '考核任务管理', 'Task Manage', '考核任務管理', NULL, NULL, NULL, '/ScoreFlowController/scoreFlow', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "125");
        if (flag_5 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('125', '500905', '进行考核', 'Check', '進行考核', NULL, NULL, NULL, '/ScoreGroupController/score', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_6 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "628");
        if (flag_6 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('628', '500904', '被考核人自评', 'Appraise', '被考核人自評', NULL, NULL, NULL, '/ScoreSelfDataController/scoreSelfData', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2057");
        if (flag_7 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('2057', '0102', '邮件互通', 'EmailPlus', '郵件互通', NULL, NULL, NULL, 'emailPlus', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
                        /*boolean flag_8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "71");
                        if (flag_8 == false) {
                            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('71', 'z013', '企业号管理', 'Enterprise Manage', '企業號管理', '', '', '', 'dingdingManage/getIndex', '', '0','','');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_9 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "536");
        if (flag_9 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('536', '109080', '工作流日志', 'Workflow Log', '工作流日誌', '', '', '', 'system/workflow/flow_log', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_10 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "183");
        if (flag_10 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('183', '1060', '工作销毁', 'Work destruction', '工作銷毀', '', '', '', 'workflow/destroy', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_11 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3021");
        if (flag_11 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('3021', 'z074', '定时任务管理', 'Timed task management', '定時任務管理', NULL, NULL, NULL, 'timed/management', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean flag_12 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "509");
        if (flag_12 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('509', '500710', '考勤设置', 'Attendance setting', '考勤設定', '', '', '', 'attendSet/attendManage', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 定时任务
         *   添加时间：2018-07-28
         */
        boolean timed_task = Verification.CheckIsExistTable(conn, driver, url, username, password, "timed_task_record");
        if (timed_task == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `timed_task_record` (\n" +
                    "  `TTR_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务记录ID',\n" +
                    "  `TTM_ID` int(11) NOT NULL COMMENT '定时任务管理ID',\n" +
                    "  `USER_ID` varchar(255) DEFAULT NULL COMMENT '执行人ID',\n" +
                    "  `EXECUTION_TIME` varchar(20) DEFAULT NULL COMMENT '任务执行时间',\n" +
                    "  `RESULT` int(11) DEFAULT NULL COMMENT '执行结果(0执行成功，1执行失败)',\n" +
                    "  `LISHI_TIME` varchar(20) DEFAULT NULL COMMENT '上次执行时间',\n" +
                    "  PRIMARY KEY (`TTR_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='----------定时任务执行记录表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 定时任务
         *   添加时间：2018-07-28
         */
        boolean task_management = Verification.CheckIsExistTable(conn, driver, url, username, password, "timed_task_management");
        if (task_management == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `timed_task_management` (\n" +
                    "  `TTM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '定时任务管理ID',\n" +
                    "  `TASK_NAME` varchar(255) DEFAULT NULL COMMENT '任务名称',\n" +
                    "  `TASK_ DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',\n" +
                    "  `TYPE_MET` int(11) DEFAULT NULL COMMENT '定时任务(1),定点任务(2)',\n" +
                    "  `TASK_TYPE` int(11) DEFAULT NULL COMMENT '任务类型(模块中的系统代码设置类型)',\n" +
                    "  `EXECUTE` int(11) DEFAULT NULL COMMENT '是否执行(1执行，0不执行)',\n" +
                    "  `INTWEVAL_TIME` varchar(255) DEFAULT NULL COMMENT '定时执行间隔时间(分钟)/定点间隔执行时间天',\n" +
                    "  `EXECUTION_TIMEAT` varchar(20) DEFAULT NULL COMMENT '定时任务执行时间',\n" +
                    "  PRIMARY KEY (`TTM_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='--------------------定时任务管理表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 增加定时任务
         */
        boolean timeId = Verification.CheckIsExistTimeMan(conn, driver, url, username, password, "2");
        if (timeId == false) {
            String sql = "INSERT INTO `timed_task_management` (`TTM_ID`, `TASK_NAME`, `TASK_ DESCRIPTION`, `TYPE_MET`, `TASK_TYPE`, `EXECUTE`, `INTWEVAL_TIME`, `EXECUTION_TIMEAT`) VALUES ('2', '数据库备份', '测试', '1', '1', '1', '1440', '1532771450000');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  2018-07-28  高亚峰
         *添加字段的作用: 修改字段类型
         */
        boolean timeRecord_flag = Verification.CheckIsExistfield(conn, driver, url, username, password, "timed_task_record", "EXECUTION_TIME");
        if (timeRecord_flag == true) {
            String sql = "ALTER TABLE timed_task_record MODIFY COLUMN EXECUTION_TIME VARCHAR(20) NOT NULL";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  2018-07-28  高亚峰
         *添加字段的作用: 删除表数据
         */
        boolean timedelteRecord_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "timed_task_record");
        if (timedelteRecord_flag == true) {
            String sql = "DELETE FROM timed_task_record";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  2018-07-28  高亚峰
         *添加字段的作用: 修改字段类型
         */
        boolean time_flag = Verification.CheckIsExistfield(conn, driver, url, username, password, "timed_task_record", "LISHI_TIME");
        if (time_flag == true) {
            String sql = "ALTER TABLE timed_task_record MODIFY COLUMN LISHI_TIME VARCHAR(20) NOT NULL";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**  2018-07-28  高亚峰
         *添加字段的作用: 添加菜单
         */
        boolean timeRecord = Verification.CheckIsExistTimeManRecord(conn, driver, url, username, password, "1");
        if (timeRecord == false) {
            String sql = "INSERT INTO `timed_task_record` (`TTR_ID`, `TTM_ID`, `USER_ID`, `EXECUTION_TIME`, `RESULT`, `LISHI_TIME`) VALUES ('1', '2', '定时任务', '1532767850000', '0', '1532430000002');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 考核指标集
         *   添加时间：2018-07-28
         */
        boolean score_group = Verification.CheckIsExistTable(conn, driver, url, username, password, "score_group");
        if (score_group == false) {
            String sql = "CREATE  TABLE IF NOT EXISTS `score_group` (\n" +
                    "  `GROUP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '考核指标集编号',\n" +
                    "  `GROUP_NAME` text NOT NULL COMMENT '考核指标集名称',\n" +
                    "  `GROUP_DESC` text COMMENT '考核指标集描述',\n" +
                    "  `GROUP_REFER` text COMMENT '考核指标集依据模块',\n" +
                    "  `CREATE_USER_ID` text COMMENT '考核指标集创建人',\n" +
                    "  `TO_ID` text COMMENT '考核指标集适用范围',\n" +
                    "  `PRIV_ID` text COMMENT '考核指标集适用范围',\n" +
                    "  `USER_ID` text COMMENT '考核指标集适用范围',\n" +
                    "  PRIMARY KEY (`GROUP_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='考核指标集';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 考核指标集明细
         *   添加时间：2018-07-28
         */
        boolean score_item = Verification.CheckIsExistTable(conn, driver, url, username, password, "score_item");
        if (score_item == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `score_item` (\n" +
                    "  `ITEM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '指标集明细编号',\n" +
                    "  `GROUP_ID` int(11) DEFAULT '0' COMMENT '指标及明细所属的指标集编号',\n" +
                    "  `ITEM_NAME` varchar(200) DEFAULT '' COMMENT '考核项目名称',\n" +
                    "  `MAX` float DEFAULT '0' COMMENT '考核分数最大值',\n" +
                    "  `MIN` float DEFAULT '0' COMMENT '考核分数最小值',\n" +
                    "  `ITEM_EXPLAIN` varchar(500) DEFAULT NULL COMMENT '考核分值说明',\n" +
                    "  PRIMARY KEY (`ITEM_ID`),\n" +
                    "  KEY `GROUP_ID` (`GROUP_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='考核指标集明细';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 被考核人自评的信息
         *   添加时间：2018-07-28
         */
        boolean score_self_data = Verification.CheckIsExistTable(conn, driver, url, username, password, "score_self_data");
        if (score_self_data == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `score_self_data` (\n" +
                    "  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自动增长',\n" +
                    "  `FLOW_ID` int(11) DEFAULT NULL COMMENT '考核任务的编号',\n" +
                    "  `PARTICIPANT` varchar(20) DEFAULT '' COMMENT '自评人',\n" +
                    "  `SCORE` text COMMENT '自评的分数',\n" +
                    "  `MEMO` text COMMENT '自评的说明',\n" +
                    "  `RANK_DATE` date DEFAULT '0000-00-00' COMMENT '自评的时间',\n" +
                    "  PRIMARY KEY (`SID`),\n" +
                    "  KEY `FLOW_ID` (`FLOW_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='被考核人自评的信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 考核任务
         *   添加时间：2018-07-28
         */
        boolean score_flow = Verification.CheckIsExistTable(conn, driver, url, username, password, "score_flow");
        if (score_flow == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `score_flow` (\n" +
                    "  `FLOW_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '考核任务编号',\n" +
                    "  `GROUP_ID` int(11) DEFAULT '0' COMMENT '考核指标集',\n" +
                    "  `FLOW_TITLE` varchar(200) DEFAULT '' COMMENT '考核任务标题',\n" +
                    "  `FLOW_DESC` text COMMENT '考核任务描述',\n" +
                    "  `FLOW_FLAG` varchar(20) DEFAULT '0' COMMENT '考核任务状态(0-生效,1-终止)',\n" +
                    "  `BEGIN_DATE` date DEFAULT '0000-00-00' COMMENT '考核生效日期',\n" +
                    "  `END_DATE` date DEFAULT '0000-00-00' COMMENT '考核终止日期',\n" +
                    "  `SEND_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '考核任务新建日期',\n" +
                    "  `RANKMAN` text COMMENT '考核人',\n" +
                    "  `PARTICIPANT` text COMMENT '被考核人',\n" +
                    "  `ANONYMITY` varchar(20) DEFAULT '' COMMENT '是否按照管理范围考核(0-否,1-是)',\n" +
                    "  `CREATE_USER_ID` text COMMENT '考核任务创建人',\n" +
                    "  `VIEW_USER_ID` text COMMENT '考核任务查看者',\n" +
                    "  `IS_SELF_ASSESSMENT` int(2) DEFAULT '0' COMMENT '是否需要自评(0-否,1-是)',\n" +
                    "  `IS_KAOHE` int(2) unsigned zerofill DEFAULT NULL COMMENT '是否需要考核(0-否,1-是)',\n" +
                    "  PRIMARY KEY (`FLOW_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='考核任务';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 考核
         *   添加时间：2018-07-28
         */
        boolean score_flow_item = Verification.CheckIsExistTable(conn, driver, url, username, password, "score_flow_item");
        if (score_flow_item == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `score_flow_item` (\n" +
                    "  `SFID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                    "  `FLOW_ID` int(11) DEFAULT NULL COMMENT 'score_flow主键',\n" +
                    "  `GROUP_ID` int(11) DEFAULT NULL COMMENT 'score_group主键',\n" +
                    "  `ITEM_ID` int(11) DEFAULT NULL COMMENT 'score_item主键',\n" +
                    "  `SELF_FLAG` int(11) DEFAULT NULL COMMENT '0是自评1是考核',\n" +
                    "  `GRADE` varchar(255) DEFAULT NULL COMMENT '分数',\n" +
                    "  `EXPLAINS` varchar(255) DEFAULT NULL COMMENT '说明',\n" +
                    "  `EXAMINER` varchar(255) DEFAULT NULL COMMENT '考核人',\n" +
                    "  `EXAMINER_STR` varchar(255) DEFAULT NULL COMMENT '考核人名字',\n" +
                    "  PRIMARY KEY (`SFID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 钉钉对接
         *   添加时间：2018-07-28
         */
        boolean user_dd_map = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_dd_map");
        if (user_dd_map == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `user_dd_map` (\n" +
                    "  `OA_UID` varchar(40) NOT NULL COMMENT 'OA用户UID',\n" +
                    "  `DD_UID` varchar(40) NOT NULL COMMENT '钉钉用户ID',\n" +
                    "  KEY `OA_UID` (`OA_UID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OA与钉钉用户对应表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 邮件互通表
         *   添加时间：2018-07-28
         */
        boolean email_bodyplus = Verification.CheckIsExistTable(conn, driver, url, username, password, "email_bodyplus");
        if (email_bodyplus == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `email_bodyplus` (\n" +
                    "  `BODY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',\n" +
                    "  `FROM_NAME1` varchar(255) DEFAULT NULL COMMENT '发送人姓名',\n" +
                    "  `FROM_ID` varchar(40) CHARACTER SET utf8mb4 NOT NULL COMMENT '发件人USER_ID',\n" +
                    "  `TO_ID2` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '收件人USER_ID串',\n" +
                    "  `COPY_TO_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '抄送人USER_ID串',\n" +
                    "  `SECRET_TO_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '密送人USER_ID串',\n" +
                    "  `SUBJECT` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '邮件主题',\n" +
                    "  `CONTENT` longtext CHARACTER SET utf8mb4 NOT NULL COMMENT '邮件内容',\n" +
                    "  `SEND_TIME` int(10) unsigned NOT NULL COMMENT '发送时间',\n" +
                    "  `ATTACHMENT_ID` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '附件ID串',\n" +
                    "  `ATTACHMENT_NAME` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '附件文件名串',\n" +
                    "  `SEND_FLAG` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '是否已发送(0-未发送,1-已发送)',\n" +
                    "  `SMS_REMIND` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '是否使用短信提醒(0-不提醒,1-提醒)',\n" +
                    "  `IMPORTANT` varchar(10) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '重要程度(空-一般邮件,1-重要,2-非常重要)',\n" +
                    "  `SIZE` bigint(20) NOT NULL DEFAULT '0' COMMENT '邮件大小',\n" +
                    "  `FROM_WEBMAIL_ID` int(11) NOT NULL COMMENT '从自己的哪个外部邮箱ID对应emailbox中id',\n" +
                    "  `FROM_WEBMAIL` varchar(200) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '从自己的哪个外部邮箱向外发送',\n" +
                    "  `TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '外部收件人邮箱串',\n" +
                    "  `COMPRESS_CONTENT` mediumblob NOT NULL COMMENT '压缩后的邮件内容',\n" +
                    "  `WEBMAIL_CONTENT` mediumblob NOT NULL COMMENT '外部邮件内容',\n" +
                    "  `WEBMAIL_FLAG` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '外部邮件标记(0-未发送,1-正在准备发送,2-发送成功,3-发送失败)',\n" +
                    "  `RECV_FROM_NAME` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '接收外部邮箱名称',\n" +
                    "  `RECV_FROM` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '接收外部邮箱ID',\n" +
                    "  `RECV_TO_ID` int(11) NOT NULL COMMENT '发送外部邮件ID',\n" +
                    "  `RECV_TO` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '发送外部邮箱名称',\n" +
                    "  `IS_WEBMAIL` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '是否为外部邮件(0-内部邮件,1-外部邮件)',\n" +
                    "  `IS_WF` char(1) CHARACTER SET utf8mb4 NOT NULL DEFAULT '0' COMMENT '是否同时外发(0-不外发,1-勾选向此人发送外部邮件)',\n" +
                    "  `KEYWORD` varchar(100) CHARACTER SET utf8mb4 NOT NULL COMMENT '内容关键词',\n" +
                    "  `SECRET_LEVEL` int(2) DEFAULT '0' COMMENT '邮件密级等级',\n" +
                    "  `AUDIT_MAN` varchar(100) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' COMMENT '审核人USER_ID',\n" +
                    "  `AUDIT_REMARK` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '审核不通过备注',\n" +
                    "  `COPY_TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '抄送外部邮箱串',\n" +
                    "  `SECRET_TO_WEBMAIL` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '密送外部邮箱串',\n" +
                    "  `PRAISE` mediumtext CHARACTER SET utf8mb4 NOT NULL COMMENT '点赞人user_id串',\n" +
                    "  `EXAM_FLAG` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '一般审核状态（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',\n" +
                    "  `WORD_FLAG` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '过滤词审核（0-未审核，1-审核通过，2-未审核通过，3-无需审核）',\n" +
                    "  `SEX` char(2) DEFAULT NULL COMMENT '性别',\n" +
                    "  `SEX_NAME` varchar(100) DEFAULT NULL COMMENT '性别名称',\n" +
                    "  `AVATAR` varchar(255) DEFAULT NULL COMMENT '头像',\n" +
                    "  `USER_PRIV_NAME` varchar(255) DEFAULT NULL COMMENT '角色',\n" +
                    "  `TO_ID2_NAME` varchar(255) DEFAULT NULL COMMENT '收件人名称',\n" +
                    "  `COPY_TO_ID_NAME` varchar(255) DEFAULT NULL COMMENT '抄送人名称',\n" +
                    "  `SECRET_TO_ID_NAME` varchar(255) DEFAULT NULL COMMENT '密送人名称',\n" +
                    "  PRIMARY KEY (`BODY_ID`),\n" +
                    "  KEY `FROM_ID` (`FROM_ID`) USING BTREE,\n" +
                    "  KEY `SEND_TIME_2` (`SEND_TIME`) USING BTREE,\n" +
                    "  KEY `FROM_WEBMAIL_ID` (`FROM_WEBMAIL_ID`) USING BTREE,\n" +
                    "  KEY `RECV_TO_ID` (`RECV_TO_ID`) USING BTREE,\n" +
                    "  KEY `SEND_FLAG` (`SEND_FLAG`) USING BTREE,\n" +
                    "  KEY `SEND_COUNT` (`FROM_ID`,`SEND_FLAG`) USING BTREE\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  高亚峰
         *   添加表的作用: 邮件互通
         *   添加时间：2018-07-28
         */
        boolean emailplus = Verification.CheckIsExistTable(conn, driver, url, username, password, "emailplus");
        if (emailplus == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `emailplus` (\n" +
                    "  `EMAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',\n" +
                    "  `TO_ID` varchar(40) NOT NULL COMMENT '收件人USER_ID',\n" +
                    "  `READ_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件读取状态(0-未读,1-已读)',\n" +
                    "  `DELETE_FLAG` char(1) NOT NULL DEFAULT '' COMMENT '邮件删除状态',\n" +
                    "  `BOX_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件箱分类ID',\n" +
                    "  `BODY_ID` int(11) NOT NULL DEFAULT '0' COMMENT '邮件体ID',\n" +
                    "  `RECEIPT` char(1) NOT NULL DEFAULT '0' COMMENT '是否请求阅读收条(0-不请求,1-请求)',\n" +
                    "  `IS_F` char(1) NOT NULL COMMENT '是否转发(0-未转发,1-已转发)',\n" +
                    "  `IS_R` char(1) NOT NULL COMMENT '是否回复(0-未回复,1-已回复)',\n" +
                    "  `SIGN` char(1) NOT NULL COMMENT '星标标记(0-无,1-灰,2-绿,3-黄,4-红)',\n" +
                    "  `withdraw_flag` varchar(1) DEFAULT '0' COMMENT '撤回状态（0-未撤回，1-撤回）',\n" +
                    "  UNIQUE KEY `ID` (`EMAIL_ID`) USING BTREE,\n" +
                    "  KEY `BODY_ID` (`BODY_ID`) USING BTREE,\n" +
                    "  KEY `TO_ID` (`TO_ID`) USING BTREE,\n" +
                    "  KEY `USER_BOX` (`BOX_ID`,`TO_ID`) USING BTREE,\n" +
                    "  KEY `READ_FLAG` (`READ_FLAG`) USING BTREE,\n" +
                    "  KEY `EMAIL_DATA` (`BODY_ID`,`BOX_ID`,`TO_ID`,`DELETE_FLAG`) USING BTREE\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 邮件互发
         */
        boolean isExistSmsCode = Verification.CheckIsExistCode(conn, driver, url, username, password, "25", "SMS_REMIND");
        if (isExistSmsCode == false) {
            String sql = "INSERT INTO `sys_code` (`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('1030', '25', '邮件互发', '', '', '', '', '', '', '25', 'SMS_REMIND', '0', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加开关字段
         */
        boolean checkIsExistOpenfield = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IS_OVERTIME");
        if (checkIsExistOpenfield == false) {
            String sql = "ALTER TABLE attend_set ADD IS_OVERTIME CHAR (1) NOT NULL DEFAULT '0' COMMENT '加班开关';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加开关字段
         */
        boolean checkIsExistOpenfield_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IS_DUTY");
        if (checkIsExistOpenfield_1 == false) {
            String sql = "ALTER TABLE attend_set ADD IS_DUTY CHAR (1) NOT NULL DEFAULT '0' COMMENT '值班开关';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加开关字段
         */
        boolean checkIsExistOpenfield_2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IS_TRIP");
        if (checkIsExistOpenfield_2 == false) {
            String sql = "ALTER TABLE attend_set ADD `IS_TRIP` char(1) NOT NULL DEFAULT '0' COMMENT '出差开关';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加开关字段
         */
        boolean checkIsExistOpenfield_3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IS_LEAVE");
        if (checkIsExistOpenfield_3 == false) {
            String sql = "ALTER TABLE attend_set ADD `IS_LEAVE` char(1) NOT NULL DEFAULT '0' COMMENT '请假开关';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加开关字段
         */
        boolean checkIsExistOpenfield_4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IS_GO");
        if (checkIsExistOpenfield_4 == false) {
            String sql = "ALTER TABLE attend_set ADD `IS_GO` char(1) NOT NULL DEFAULT '0' COMMENT '外出开关';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加字段
         */
        boolean checkIsExistOpenfield_5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend", "TYPE");
        if (checkIsExistOpenfield_5 == true) {
            String sql = "alter table attend  modify column TYPE char(2) DEFAULT '0' COMMENT '签到次数';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 值班考勤添加字段
         */
        boolean checkIsExistOpenfield_6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "supervision_type", "user_id");
        if (checkIsExistOpenfield_6 == true) {
            String sql = "ALTER table supervision_type modify column user_id text;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 日志模块
         */
        boolean checkIsExistOpenfield_7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "diary", "SHARE_ALL");
        if (checkIsExistOpenfield_7 == false) {
            String sql = "ALTER table diary ADD SHARE_ALL int(1) NOT NULL DEFAULT '0';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 日志模块
         */
        boolean checkIsExistOpenfield_8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "diary", "SEND_REMIND");
        if (checkIsExistOpenfield_8 == false) {
            String sql = "ALTER table diary ADD SEND_REMIND int(1) NOT NULL DEFAULT '0';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-28
         *  创建者：高亚峰
         *  作用: 日志模块
         */
        boolean checkIsExistOpenfield_9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "diary_comment_reply", "REPLY_COM_ID");
        if (checkIsExistOpenfield_9 == false) {
            String sql = "ALTER table diary_comment_reply ADD REPLY_COM_ID int(11) DEFAULT NULL;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-30
         *  创建者：高亚峰
         *  作用: 固定资产维护
         */
        boolean edu_fix_flag = Verification.CheckIsExistfield(conn, driver, url, username, password, "edu_fixed_assets_mangement", "COMPANYID");
        if (edu_fix_flag == false) {
            String sql = "alter table edu_fixed_assets_mangement add COMPANYID varchar(255) DEFAULT NULL COMMENT '当前企业的 id';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**  创建者：  高亚峰
         *   添加表的作用: 调休表
         *   添加时间：2018-07-30
         */
        boolean extrawork_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "attend_extrawork");
        if (extrawork_flag == false) {
            String sql = "CREATE TABLE IF NOT EXISTS `attend_extrawork` (\n" +
                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '调休上班设置主键自增ID',\n" +
                    "  `EXTRA_WORK_NAME` varchar(64) NOT NULL COMMENT '调休上班名称',\n" +
                    "  `BEGIN_DATE` datetime DEFAULT NULL COMMENT '调休上班开始时间',\n" +
                    "  `END_DATE` datetime DEFAULT NULL COMMENT '调休上班结束时间',\n" +
                    "  PRIMARY KEY (`ID`),\n" +
                    "  KEY `BEGIN_DATE` (`BEGIN_DATE`),\n" +
                    "  KEY `END_DATE` (`END_DATE`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='调休上班设置表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**   2018-7-30
         *  创建者：高亚峰
         *  作用: 固定资产图片
         */
        boolean edu_fix_img = Verification.CheckIsExistfield(conn, driver, url, username, password, "edu_fixed_assets_mangement", "IMAGE");
        if (edu_fix_img == false) {
            String sql = "alter table edu_fixed_assets_mangement modify column IMAGE longtext COMMENT '固定资产图片';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-7-30
         *  创建者：高亚峰
         *  作用: openfire
         */
                      /*  String split[] = url.split("x");
                        String connOpenUrl = url.replace("xoa" + obj.get(i).getOid(), "im");
                        Connection connopen = (Connection) DriverManager.getConnection(connOpenUrl, username, password);
                        boolean im_flag = Verification.CheckIsExistOpenFire(connopen, driver, url, username, password, "xmpp.session.conflict-limit");
                        if (im_flag == true) {
                            String sql = "UPDATE `im`.`ofproperty` SET `name`='xmpp.session.conflict-limit', `propValue`='0' WHERE (`name`='xmpp.session.conflict-limit');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        boolean im_limit = Verification.CheckIsExistOpenFire(connopen, driver, url, username, password, "route.all-resources");
                        if (im_limit == false) {
                            String sql = "INSERT INTO `im`.`ofproperty` (`name`, `propValue`) VALUES ('route.all-resources', 'true');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
        /**   2018-7-30
         *  创建者：高亚峰
         *  作用: 固定资产图片
         */
        boolean out_flag = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "OUTSIDE_ADDRESS");
        if (out_flag == false) {
            String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('OUTSIDE_ADDRESS', 'http://test.xtdoa.com:9010');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function12 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "482");
        if (function12 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('482', '500105', '奖惩管理', 'Reward And Punishment Manage', '獎懲管理', NULL, NULL, NULL, 'hr/manage/staff_incentive', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function13 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "483");
        if (function13 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('483', '500107', '证照管理', 'Certificate Manage', '證照管理', NULL, NULL, NULL, 'hr/manage/staff_license', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function14 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "484");
        if (function14 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('484', '500109', '学习经历', 'Learning Experience\\n', '學習經歷', NULL, NULL, NULL, 'hr/manage/staff_learn_experience', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function15 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "485");
        if (function15 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('485', '500111', '工作经历', 'Work Experience', '工作經歷', NULL, NULL, NULL, 'hr/manage/staff_work_experience', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function16 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "486");
        if (function16 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('486', '500113', '劳动技能', 'Labor Skills', '勞動技能', NULL, NULL, NULL, 'hr/manage/staff_labor_skills', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
                       /* boolean function17 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "487");
                        if(function17==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('487', '500115', '社会关系', 'Social Relations', '社會關係', NULL, NULL, NULL, 'hr/manage/staff_relatives', '', '0','','');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
        /**   2018-8-9
         *  创建者：高亚峰
         *  作用: 增加菜单
         */
        boolean function18 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "488");
        if (function18 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`) VALUES ('488', '500117', '人事调动', 'Personnel Mobilization', '人事調動', NULL, NULL, NULL, 'hr/manage/staff_transfer', '', '0','','');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function19 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "491");
        if (function19 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('491', '500122', '职称评定', 'Title Evaluation', '升等', NULL, NULL, NULL, 'hr/manage/staff_title_evaluation', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function20 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "492");
        if (function20 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('492', '500123', '员工关怀', 'Employee Care', '員工關懷', NULL, NULL, NULL, 'hr/manage/staff_care', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-8-9
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function21 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "513");
        if (function21 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('513', '500160', 'HRMS代码设置', 'HRMS code setting', 'HRMS程式碼設定', NULL, NULL, NULL, 'hr/setting/hr_code', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**  创建者：  张丽军
         *   添加表的作用: 奖惩管理表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_incentive_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_incentive");
        if (hr_staff_incentive_flag == false) {
            String sql = "CREATE TABLE `hr_staff_incentive` (\n" +
                    "  `INCENTIVE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `STAFF_NAME` text NOT NULL COMMENT '员工姓名',\n" +
                    "  `INCENTIVE_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '奖惩日期',\n" +
                    "  `INCENTIVE_ITEM` text NOT NULL COMMENT '奖惩项目',\n" +
                    "  `INCENTIVE_TYPE` varchar(254) NOT NULL COMMENT '奖惩属性',\n" +
                    "  `SALARY_MONTH` varchar(254) NOT NULL COMMENT '工资月份',\n" +
                    "  `INCENTIVE_AMOUNT` decimal(8,2) NOT NULL COMMENT '奖惩金额',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL COMMENT '附件名称',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `INCENTIVE_DESCRIPTION` text NOT NULL COMMENT '奖惩说明',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`INCENTIVE_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人力资源奖惩信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /**  创建者：  张丽军
         *   添加表的作用: 证照管理表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_license_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_license");
        if (hr_staff_license_flag == false) {
            String sql = "CREATE TABLE `hr_staff_license` (\n" +
                    "  `LICENSE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `STAFF_NAME` varchar(254) NOT NULL COMMENT '员工姓名',\n" +
                    "  `LICENSE_TYPE` varchar(254) NOT NULL COMMENT '证照类型',\n" +
                    "  `LICENSE_NO` varchar(254) NOT NULL COMMENT '证照编号',\n" +
                    "  `LICENSE_NAME` varchar(254) NOT NULL COMMENT '证照名称',\n" +
                    "  `NOTIFIED_BODY` varchar(254) NOT NULL COMMENT '发证机构',\n" +
                    "  `GET_LICENSE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '取证日期',\n" +
                    "  `EFFECTIVE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '生效日期',\n" +
                    "  `EXPIRATION_PERIOD` varchar(32) NOT NULL COMMENT '期限限制',\n" +
                    "  `EXPIRE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '到期日期',\n" +
                    "  `STATUS` varchar(254) NOT NULL COMMENT '状态',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL COMMENT '附件名称',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  `REMIND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '提醒时间',\n" +
                    "  `REMIND_USER` text NOT NULL COMMENT '证照到期后的定时提醒人员',\n" +
                    "  `REMIND_TYPE` int(4) NOT NULL COMMENT '提醒类型',\n" +
                    "  `HAS_REMINDED` int(4) NOT NULL COMMENT '是否已经提醒(0-未提醒,1-已经提醒)',\n" +
                    "  PRIMARY KEY (`LICENSE_ID`),\n" +
                    "  KEY `LICENSE` (`LICENSE_NO`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='证照管理信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**  创建者：  张丽军
         *   添加表的作用: 学习经历表
         *   添加时间：2018-08-09
         */
        boolean learning_experience_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "learning_experience");
        if (learning_experience_flag == false) {
            String sql = "CREATE TABLE `learning_experience` (\n" +
                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键 自增id',\n" +
                    "  `USER_ID` varchar(11) NOT NULL COMMENT '单位员工',\n" +
                    "  `PROFESSION` varchar(255) DEFAULT NULL COMMENT '所学专业',\n" +
                    "  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',\n" +
                    "  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',\n" +
                    "  `REGISTER_TIME` datetime DEFAULT NULL COMMENT '登记时间',\n" +
                    "  `LASTMODIFY_TIME` datetime DEFAULT NULL COMMENT '最后修改时间',\n" +
                    "  `ACADEMIC` varchar(255) DEFAULT NULL COMMENT '学历',\n" +
                    "  `DEGREE` varchar(255) DEFAULT NULL COMMENT '学位',\n" +
                    "  `CLASSCADRE` varchar(255) DEFAULT NULL COMMENT '曾任班干',\n" +
                    "  `CERTIFIER` varchar(255) DEFAULT NULL COMMENT '证明人',\n" +
                    "  `UNIVERSITY` text COMMENT '所在院校',\n" +
                    "  `UNIVERSITY_LOCATION` text COMMENT '院校所在地',\n" +
                    "  `HONOR` mediumtext COMMENT '获奖情况',\n" +
                    "  `CERTIFICATE` mediumtext COMMENT '所获证书',\n" +
                    "  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                    "  `ATTACHMENT_ID` mediumtext,\n" +
                    "  `ATTACHMENT_NAME` mediumtext COMMENT '附件名称',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人员的学习经历';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**  创建者：  张丽军
         *   添加表的作用: 工作经历表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_work_experience_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_work_experience");
        if (hr_staff_work_experience_flag == false) {
            String sql = "CREATE TABLE `hr_staff_work_experience` (\n" +
                    "  `W_EXPERIENCE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL DEFAULT '' COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `STAFF_NAME` varchar(254) NOT NULL DEFAULT '' COMMENT '单位员工',\n" +
                    "  `START_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '开始日期',\n" +
                    "  `END_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '结束日期',\n" +
                    "  `WORK_UNIT` text NOT NULL COMMENT '工作单位',\n" +
                    "  `MOBILE` text NOT NULL COMMENT '行业类别',\n" +
                    "  `WORK_BRANCH` varchar(254) NOT NULL DEFAULT '' COMMENT '所在部门',\n" +
                    "  `POST_OF_JOB` varchar(254) NOT NULL DEFAULT '' COMMENT '担任职务',\n" +
                    "  `WORK_CONTENT` text NOT NULL COMMENT '工作内容',\n" +
                    "  `KEY_PERFORMANCE` text NOT NULL COMMENT '主要业绩',\n" +
                    "  `REASON_FOR_LEAVING` text NOT NULL COMMENT '离职原因',\n" +
                    "  `WITNESS` varchar(254) NOT NULL DEFAULT '' COMMENT '证明人',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL DEFAULT '' COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL DEFAULT '' COMMENT '附件名称',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`W_EXPERIENCE_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员的工作经历';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**  创建者：  张丽军
         *   添加表的作用: 劳动技能表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_labor_skills_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_labor_skills");
        if (hr_staff_labor_skills_flag == false) {
            String sql = "CREATE TABLE `hr_staff_labor_skills` (\n" +
                    "  `SKILLS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `STAFF_NAME` varchar(254) NOT NULL COMMENT '员工姓名',\n" +
                    "  `ABILITY_NAME` varchar(254) NOT NULL COMMENT '技能名称',\n" +
                    "  `SPECIAL_WORK` varchar(64) NOT NULL COMMENT '是否是特种作业(0-否,1-是)',\n" +
                    "  `SKILLS_LEVEL` varchar(64) NOT NULL COMMENT '级别',\n" +
                    "  `SKILLS_CERTIFICATE` varchar(254) NOT NULL COMMENT '是否是技能证(0-否,1-是)',\n" +
                    "  `ISSUE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '发证日期',\n" +
                    "  `EXPIRE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '到期日期',\n" +
                    "  `EXPIRES` varchar(254) NOT NULL COMMENT '有效期',\n" +
                    "  `ISSUING_AUTHORITY` text NOT NULL COMMENT '发证机关/单位',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL COMMENT '附件名称',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`SKILLS_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人员劳动技能信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**  创建者：  张丽军
         *   添加表的作用: 社会关系表
         *   添加时间：2018-08-09
         */
        boolean hr_social_relations_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_social_relations");
        if (hr_social_relations_flag == false) {
            String sql = "CREATE TABLE `hr_social_relations` (\n" +
                    "  `SOCIAL_REL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                    "  `STAFF_ROLE` varchar(255) DEFAULT NULL COMMENT '单位员工',\n" +
                    "  `STAFF_NAME` varchar(255) DEFAULT NULL COMMENT '成员姓名',\n" +
                    "  `RELATIONSHIP` varchar(255) DEFAULT NULL COMMENT '与本人关系',\n" +
                    "  `BIRTH_DATE` date DEFAULT NULL COMMENT '出生日期',\n" +
                    "  `POLITICAL_OUTLOOK` varchar(255) DEFAULT NULL COMMENT '政治面貌',\n" +
                    "  `OCCUPATION` varchar(255) DEFAULT NULL COMMENT '职业',\n" +
                    "  `POST` varchar(255) DEFAULT NULL COMMENT '担任职务',\n" +
                    "  `PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话（个人）',\n" +
                    "  `TELEPHONE` varchar(255) DEFAULT NULL COMMENT '联系电话（家庭）',\n" +
                    "  `PHONE_CALL` varchar(255) DEFAULT NULL COMMENT '联系电话（单位）',\n" +
                    "  `WORK_COMPANY` varchar(255) DEFAULT NULL COMMENT '工作单位',\n" +
                    "  `COMPANY_ADDRESS` varchar(255) DEFAULT NULL COMMENT '单位地址',\n" +
                    "  `HOME_ADDRESS` varchar(255) DEFAULT NULL COMMENT '家庭住址',\n" +
                    "  `REMARKS` text COMMENT '备注',\n" +
                    "  `ATTACHMENT_NAME` text COMMENT '附件地址',\n" +
                    "  `ATTACHMENT_ID` text COMMENT '附件ID',\n" +
                    "  PRIMARY KEY (`SOCIAL_REL_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='社会关系';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }

        /**  创建者：  张丽军
         *   添加表的作用: 人事调动表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_transfer_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_transfer");
        if (hr_staff_transfer_flag == false) {
            String sql = "CREATE TABLE `hr_staff_transfer` (\n" +
                    "  `TRANSFER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `TRANSFER_PERSON` varchar(254) NOT NULL COMMENT '调动人员',\n" +
                    "  `TRANSFER_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '调动日期',\n" +
                    "  `TRANSFER_EFFECTIVE_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '调动生效日期',\n" +
                    "  `TRANSFER_TYPE` varchar(64) NOT NULL COMMENT '调动类别',\n" +
                    "  `TRAN_COMPANY_BEFORE` varchar(254) NOT NULL COMMENT '调动前单位',\n" +
                    "  `TRAN_DEPT_BEFORE` varchar(254) NOT NULL COMMENT '调动前部门',\n" +
                    "  `TRAN_POSITION_BEFORE` varchar(254) NOT NULL COMMENT '调动前职务',\n" +
                    "  `TRAN_COMPANY_AFTER` varchar(254) NOT NULL COMMENT '调动后单位',\n" +
                    "  `TRAN_DEPT_AFTER` varchar(254) NOT NULL COMMENT '调动后部门',\n" +
                    "  `TRAN_POSITION_AFTER` varchar(254) NOT NULL COMMENT '调动后职务',\n" +
                    "  `TRAN_REASON` text NOT NULL COMMENT '调动原因',\n" +
                    "  `RESPONSIBLE_PERSON` varchar(254) NOT NULL COMMENT '经办人',\n" +
                    "  `DESPACHO` text NOT NULL COMMENT '批示',\n" +
                    "  `MATERIALS_CONDITION` text NOT NULL COMMENT '调动手续办理',\n" +
                    "  `ATTACHMENT_ID` varchar(254) NOT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) NOT NULL COMMENT '附件名称',\n" +
                    "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`TRANSFER_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人事调动的信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /**  创建者：  张丽军
         *   添加表的作用: 职称评定表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_title_evaluation_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_title_evaluation");
        if (hr_staff_title_evaluation_flag == false) {
            String sql = "CREATE TABLE `hr_staff_title_evaluation` (\n" +
                    "  `EVALUATION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) NOT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) NOT NULL COMMENT '创建者部门编号',\n" +
                    "  `POST_NAME` varchar(64) NOT NULL COMMENT '获取职称',\n" +
                    "  `GET_METHOD` varchar(64) NOT NULL COMMENT '获取方式',\n" +
                    "  `REPORT_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '申报时间',\n" +
                    "  `RECEIVE_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '获取时间',\n" +
                    "  `APPROVE_PERSON` varchar(64) NOT NULL COMMENT '批准人',\n" +
                    "  `APPROVE_NEXT` varchar(254) NOT NULL COMMENT '下次申报职称',\n" +
                    "  `APPROVE_NEXT_TIME` date NOT NULL DEFAULT '0000-00-00' COMMENT '下次申报日期',\n" +
                    "  `REMARK` varchar(254) NOT NULL COMMENT '备注',\n" +
                    "  `EMPLOY_POST` varchar(254) NOT NULL COMMENT '聘用专业技术职务',\n" +
                    "  `START_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '聘用起始日期',\n" +
                    "  `END_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '聘用结束日期',\n" +
                    "  `EMPLOY_COMPANY` varchar(254) NOT NULL COMMENT '聘用单位',\n" +
                    "  `BY_EVALU_STAFFS` varchar(254) NOT NULL COMMENT '评定对象',\n" +
                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`EVALUATION_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='职称评定的信息';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /**  创建者：  张丽军
         *   添加表的作用: 员工关怀表
         *   添加时间：2018-08-09
         */
        boolean hr_staff_care_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_care");
        if (hr_staff_care_flag == false) {
            String sql = "CREATE TABLE `hr_staff_care` (\n" +
                    "  `CARE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                    "  `CREATE_USER_ID` varchar(254) DEFAULT NULL COMMENT '创建者用户名',\n" +
                    "  `CREATE_DEPT_ID` int(11) DEFAULT NULL COMMENT '创建者部门编号',\n" +
                    "  `BY_CARE_STAFFS` text COMMENT '被关怀员工',\n" +
                    "  `CARE_DATE` date DEFAULT '0000-00-00' COMMENT '关怀日期',\n" +
                    "  `CARE_CONTENT` text COMMENT '关怀内容',\n" +
                    "  `PARTICIPANTS` text COMMENT '参与人',\n" +
                    "  `CARE_EFFECTS` text COMMENT '关怀效果',\n" +
                    "  `CARE_FEES` varchar(8) DEFAULT NULL COMMENT '关怀开支费用',\n" +
                    "  `CARE_TYPE` varchar(254) DEFAULT NULL COMMENT '关怀类型',\n" +
                    "  `ATTACHMENT_ID` varchar(254) DEFAULT NULL COMMENT '附件编号',\n" +
                    "  `ATTACHMENT_NAME` varchar(254) DEFAULT NULL COMMENT '附件名称',\n" +
                    "  `ADD_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '新建时间',\n" +
                    "  `LAST_UPDATE_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`CARE_ID`),\n" +
                    "  KEY `USER_ID` (`CREATE_USER_ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='人力资源员工关怀';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }


        /**  创建者：  张丽军
         *   添加表的作用: 人力资源代码表
         *   添加时间：2018-08-09
         */
        boolean hr_code_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_code");
        if (hr_code_flag == false) {
            String sql = "CREATE TABLE `hr_code` (\n" +
                    "  `CODE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '代码自增ID',\n" +
                    "  `CODE_NO` varchar(200) NOT NULL DEFAULT '' COMMENT '代码编号',\n" +
                    "  `CODE_NAME` text NOT NULL COMMENT '代码名称',\n" +
                    "  `CODE_ORDER` varchar(200) NOT NULL DEFAULT '' COMMENT '排序号',\n" +
                    "  `PARENT_NO` varchar(200) NOT NULL DEFAULT '' COMMENT '代码主分类编号',\n" +
                    "  `CODE_FLAG` varchar(20) NOT NULL DEFAULT '1' COMMENT '代码分类是否可以删除的标志(1-可删除,0-不可删除)',\n" +
                    "  PRIMARY KEY (`CODE_ID`),\n" +
                    "  KEY `CODE_NO` (`CODE_NO`),\n" +
                    "  KEY `CODE_ORDER` (`CODE_ORDER`),\n" +
                    "  KEY `PARENT_NO` (`PARENT_NO`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 COMMENT='人力资源HRMS代码设置';" +
                    "INSERT INTO `hr_code` VALUES ('1', 'PRESENT_POSITION', '职称', '1010', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('2', 'STAFF_OCCUPATION', '员工类型', '1010', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('3', 'STAFF_HIGHEST_SCHOOL', '学历', '1010', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('4', 'WORK_STATUS', '在职状态', '1010', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('5', 'STAFF_POLITICAL_STATUS', '政治面貌', '1010', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('6', 'AREA', '地区', '1309', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('7', 'HR_STAFF_CARE', '员工关怀类型', '2030', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('8', 'HR_STAFF_TITLE_EVALUATION', '职称获取方式', '2032', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('9', 'HR_STAFF_LEAVE', '离职类型', '2034', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('10', 'HR_STAFF_REINSTATEMENT', '复职类型', '2036', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('11', 'HR_STAFF_TRANSFER', '人事调动', '2038', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('12', '02', '助理工程师', '1', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('13', '01', '工程师', '2', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('14', '03', '高级工程师', '3', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('15', '07', '职称', '7', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('16', '04', '研高工', '4', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('17', '08', '高级职称', '08', 'PRESENT_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('18', '01', '合同工', '01', 'STAFF_OCCUPATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('19', '02', '正式员工', '02', 'STAFF_OCCUPATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('20', '03', '临时工', '03', 'STAFF_OCCUPATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('21', '9', '博士后', '09', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('22', '8', '博士', '08', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('23', '7', '研究生', '07', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('24', '6', '本科', '06', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('25', '5', '大专', '05', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('26', '4', '中专', '04', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('27', '3', '高中', '03', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('28', '2', '初中', '02', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('29', '1', '小学', '01', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('30', '11', '技校', '11', 'STAFF_HIGHEST_SCHOOL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('31', '01', '在职', '01', 'WORK_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('32', '02', '辞职', '02', 'WORK_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('33', '03', '离休', '03', 'WORK_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('34', '04', '退休', '04', 'WORK_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('35', '05', '借调', '05', 'WORK_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('36', '1', '群众', '01', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('37', '2', '共青团员', '02', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('38', '3', '中共党员', '03', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('39', '4', '中共预备党员', '04', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('40', '5', '民主党派', '05', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('41', '6', '无党派人士', '06', 'STAFF_POLITICAL_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('42', '230000', '黑龙江', '230000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('43', '610000', '陕西', '610000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('44', '620000', '甘肃', '620000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('45', '360000', '江西', '360000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('46', '220000', '吉林', '220000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('47', '210000', '辽宁', '210000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('48', '150000', '内蒙古', '150000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('49', '140000', '山西', '140000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('50', '130000', '河北', '130000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('51', '120000', '天津', '120000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('52', '110000', '北京', '110000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('53', '370000', '山东', '370000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('54', '310000', '上海', '310000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('55', '320000', '江苏', '320000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('56', '330000', '浙江', '330000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('57', '340000', '安徽', '340000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('58', '350000', '福建', '350000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('59', '410000', '河南', '410000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('60', '710000', '台湾', '710000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('61', '810000', '香港', '810000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('62', '820000', '澳门', '820000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('63', '420000', '湖北', '420000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('64', '430000', '湖南', '430000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('65', '440000', '广东', '440000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('66', '450000', '广西', '450000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('67', '460000', '海南', '460000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('68', '500000', '重庆', '500000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('69', '510000', '四川', '510000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('70', '520000', '贵州', '520000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('71', '530000', '云南', '530000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('72', '540000', '西藏', '540000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('73', '630000', '青海', '630000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('74', '640000', '宁夏', '640000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('75', '650000', '新疆', '650000', 'AREA', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('76', '1', '节日关怀', '0', 'HR_STAFF_CARE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('77', '2', '生日关怀', '0', 'HR_STAFF_CARE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('79', '1', '业绩考核', '0', 'HR_STAFF_TITLE_EVALUATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('80', '2', '考试', '0', 'HR_STAFF_TITLE_EVALUATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('81', 'HR_STAFF_RELATIVES', '与本人关系', '2040', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('82', '1', '辞职', '0', 'HR_STAFF_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('83', '2', '离休', '0', 'HR_STAFF_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('84', '5', '姐弟', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('85', '1', '调回', '0', 'HR_STAFF_REINSTATEMENT', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('86', '2', '复员', '0', 'HR_STAFF_REINSTATEMENT', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('87', '4', '母子', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('88', '1', '晋升', '0', 'HR_STAFF_TRANSFER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('89', '2', '平调', '0', 'HR_STAFF_TRANSFER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('90', '3', '降级', '0', 'HR_STAFF_TRANSFER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('91', '4', '其他', '0', 'HR_STAFF_TRANSFER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('92', '1', '兄弟', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('93', '2', '姐妹', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('94', '3', '父子', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('95', '6', '兄妹', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('96', '7', '其他', '0', 'HR_STAFF_RELATIVES', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('97', 'HR_STAFF_LICENSE1', '证照类型', '2042', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('98', '1', '驾驶证', '0', 'HR_STAFF_LICENSE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('99', '2', '健康证', '0', 'HR_STAFF_LICENSE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('100', '3', '暂住证', '0', 'HR_STAFF_LICENSE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('101', '4', '技能证', '0', 'HR_STAFF_LICENSE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('102', '5', '其他', '0', 'HR_STAFF_LICENSE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('103', 'HR_STAFF_LICENSE2', '状态', '2044', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('104', '1', '未生效', '0', 'HR_STAFF_LICENSE2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('105', '2', '生效中', '0', 'HR_STAFF_LICENSE2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('106', '3', '已到期', '0', 'HR_STAFF_LICENSE2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('107', 'HR_STAFF_INCENTIVE1', '项目名称', '2046', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('108', '1', '积极参加工作', '0', 'HR_STAFF_INCENTIVE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('109', '2', '不迟到不早退', '0', 'HR_STAFF_INCENTIVE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('110', '3', '违规操作', '0', 'HR_STAFF_INCENTIVE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('111', '4', '经常迟到早退', '0', 'HR_STAFF_INCENTIVE1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('112', 'HR_STAFF_CONTRACT1', '合同类型', '2046', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('113', '1', '聘用合同', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('114', '2', '实习协议', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('115', '3', '保密协议', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('116', 'HR_STAFF_CONTRACT2', '合同状态', '2048', 'CONTRACT_SPECIALIZATION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('117', '1', '试用中', '0', 'HR_STAFF_CONTRACT2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('118', '2', '已转正', '0', 'HR_STAFF_CONTRACT2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('119', '3', '已解除', '0', 'HR_STAFF_CONTRACT2', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('120', 'PLAN_DITCH', '招聘渠道', '01', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('121', '01', '网络招聘', '0', 'PLAN_DITCH', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('122', '02', '招聘会招聘', '2', 'PLAN_DITCH', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('123', '03', '人才猎头推荐', '3', 'PLAN_DITCH', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('124', 'EMPLOYEE_HIGHEST_DEGREE', '学位', '2054', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('125', '1', '博士后', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('126', '2', '博士', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('127', '3', 'MBA', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('128', '4', '硕士', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('129', '5', '双学士', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('130', '6', '学士', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('131', '7', '无', '0', 'EMPLOYEE_HIGHEST_DEGREE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('132', 'JOB_CATEGORY', '期望工作性质', '2056', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('133', '1', '全职', '0', 'JOB_CATEGORY', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('134', '2', '兼职', '0', 'JOB_CATEGORY', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('135', '3', '临时', '0', 'JOB_CATEGORY', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('136', '4', '实习', '0', 'JOB_CATEGORY', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('137', 'T_COURSE_TYPE', '培训形式', '2058', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('138', '1', '面授', '0', 'T_COURSE_TYPE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('139', '2', '函授', '0', 'T_COURSE_TYPE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('140', '3', '其它', '0', 'T_COURSE_TYPE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('141', 'INSURANCE_STATUS', '员工保险状态', '02', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('142', '1', '未投保', '1', 'INSURANCE_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('143', '2', '已投保', '2', 'INSURANCE_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('144', '3', '超期投保', '3', 'INSURANCE_STATUS', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('145', 'HR_RECRUIT_FILTER', '招聘筛选方式', '02', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('146', '01', '笔试', '1', 'HR_RECRUIT_FILTER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('147', '02', '面试', '2', 'HR_RECRUIT_FILTER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('148', '03', '电话面试', '3', 'HR_RECRUIT_FILTER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('149', '04', '笔试+面试', '4', 'HR_RECRUIT_FILTER', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('150', 'HR_WELFARE_MANAGE', '福利项目', '2060', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('151', '1', '五一劳动节', '0', 'HR_WELFARE_MANAGE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('152', '2', '公司年庆', '0', 'HR_WELFARE_MANAGE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('153', '3', '其它', '0', 'HR_WELFARE_MANAGE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('154', 'POOL_POSITION', '应聘岗位', '2062', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('155', '1', '技术研发', '0', 'POOL_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('156', '2', '技术支持', '0', 'POOL_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('157', '3', '销售', '0', 'POOL_POSITION', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('158', 'POOL_EMPLOYEE_MAJOR', '所学专业', '2064', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('159', '1', '信息安全', '0', 'POOL_EMPLOYEE_MAJOR', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('160', '2', '网络工程', '0', 'POOL_EMPLOYEE_MAJOR', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('161', '3', '通讯工程', '0', 'POOL_EMPLOYEE_MAJOR', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('162', 'HR_STAFF_TYPE', '户口类别', '22', '', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('163', '01', '本市城镇职工', '01', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('164', '02', '外埠城镇职工', '02', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('165', '03', '本市农民工', '03', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('166', '04', '外地农民工', '04', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('167', '05', '本市农村劳动力', '05', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('168', '06', '外埠农村劳动力', '06', 'HR_STAFF_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('169', '3', '退休', '0', 'HR_STAFF_LEAVE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('170', '4', '借调', '0', 'HR_STAFF_LEAVE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('171', 'ATTEND_LEAVE', '请假类型', '01', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('172', '1', '事假', '1', 'ATTEND_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('173', '2', '病假', '2', 'ATTEND_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('174', '3', '年假', '3', 'ATTEND_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('175', '9', '其他', '9', 'ATTEND_LEAVE', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('176', 'WORK_LEVEL', '职称级别', '01', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('177', '01', '初级', '01', 'WORK_LEVEL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('178', '02', '中级', '02', 'WORK_LEVEL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('179', '03', '副高', '03', 'WORK_LEVEL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('180', '04', '正高', '04', 'WORK_LEVEL', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('181', 'INCENTIVE_TYPE', '奖惩属性', '10', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('182', 'REWARD', '奖励', '10', 'INCENTIVE_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('183', 'PUNISHMENT', '惩罚', '20', 'INCENTIVE_TYPE', '1');\n" +
                    "INSERT INTO `hr_code` VALUES ('184', 'HR_ENTERPRISE', '合同签约公司', '30', '', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('185', '4', '录用合同', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('188', '5', '兼职合同', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('189', '6', '借调合同', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('190', '7', '集体合同', '0', 'HR_STAFF_CONTRACT1', '0');\n" +
                    "INSERT INTO `hr_code` VALUES ('191', 'JOBS_STYLE', '岗位类型', '2064', '', '0');\n";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }



        /**  创建者：  张丽军
         *   添加表的作用: 人力资源代码表
         *   添加时间：2018-08-09
         */
        boolean information_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "information");
        if (information_flag == false) {
            String sql = "CREATE TABLE `information` (\n" +
                    "  `ID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                    "  `TITLE` varchar(255) DEFAULT NULL COMMENT '标题',\n" +
                    "  `DEPT_ID` varchar(11) DEFAULT NULL COMMENT '所属部门',\n" +
                    "  `USER_ID` varchar(50) DEFAULT NULL COMMENT '填报人',\n" +
                    "  `MANAGER_ID` varchar(255) DEFAULT NULL COMMENT '审批人',\n" +
                    "  `MANAGER_TYPE` varchar(11) DEFAULT NULL COMMENT '审批方式',\n" +
                    "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '填报时间',\n" +
                    "  `PHONE` varchar(20) DEFAULT NULL COMMENT '联系电话',\n" +
                    "  `DELIVERY_DEPT_ID` varchar(255) DEFAULT NULL COMMENT '报送部门',\n" +
                    "  `IMAGE` varchar(255) DEFAULT NULL COMMENT '图片',\n" +
                    "  `CONTEXT` varchar(255) DEFAULT NULL COMMENT '内容',\n" +
                    "  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '附件ID',\n" +
                    "  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '附件名称',\n" +
                    "  `PUBLISH` char(1) DEFAULT '0' COMMENT '发布标识(0-未转交,1-已转交)',\n" +
                    "  `ISREAD` varchar(10) DEFAULT '0' COMMENT '是否阅读（0否,1是）',\n" +
                    "  `ISCOLLECTION` varchar(10) DEFAULT '0' COMMENT '是否采集（0否,1是）',\n" +
                    "  `SIGN` varchar(10) DEFAULT '0' COMMENT '是否出现修改字段（0否,1是）',\n" +
                    "  `STR2` varchar(255) DEFAULT NULL COMMENT '备用字段2',\n" +
                    "  `ATTACHMENT_ID2` varchar(255) DEFAULT NULL COMMENT '图片附件ID',\n" +
                    "  `ATTACHMENT_NAME2` varchar(255) DEFAULT NULL COMMENT '图片附件名称',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**
         * 张丽军
         *  添加字段的作用: 添加字段
         *  2018-8-10
         */
        boolean checkIsExistfield_7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_group", "TYPE_ID");
        if (checkIsExistfield_7 == false) {
            String sql = "alter table score_group add COLUMN  TYPE_ID varchar(255) DEFAULT '0' COMMENT '类型(0:指标集,1:类型)';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         * 张丽军
         *  添加字段的作用: 添加字段
         *  2018-8-10
         */
        boolean checkIsExistfield_8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_item", "TYPE");
        if (checkIsExistfield_8 == false) {
            String sql = "alter table score_item add COLUMN `TYPE` varchar(255) DEFAULT NULL COMMENT '类型';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 添加字段
         *  2018-8-10
         */
        boolean checkIsExistfield_9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonus", "DATA_51");
        if (checkIsExistfield_9 == false) {
            String sql = "alter table bonus add COLUMN `DATA_51` varchar(255) DEFAULT NULL COMMENT '用户uid';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         * 张丽军
         *  添加字段的作用: 添加字段
         *  2018-8-10
         */
        boolean checkIsExistfield_10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "DATA_51");
        if (checkIsExistfield_10 == false) {
            String sql = "alter table bonusmsg add COLUMN `DATA_51` varchar(255) DEFAULT NULL COMMENT '用户uid';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function22 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "61");
        if (function22 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('61', '500102', '档案查询', 'File Inquiries', '檔案査詢', NULL, NULL, NULL, 'hr/manage/query', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function23 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "120");
        if (function23 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('120', '500125', '人事分析', 'Personnel Analysis', '人事分析', NULL, NULL, NULL, 'hr/manage/staff_analysis', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function24 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "489");
        if (function24 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('489', '500119', '离职管理', 'Leave Manage', '離職管理', NULL, NULL, NULL, '/dimission/navigationBar', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function25 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "490");
        if (function25 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('490', '500121', '复职管理', 'Remission Manage', '複職管理', NULL, NULL, NULL, 'hr/manage/staff_reinstatement', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function26 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "511");
        if (function26 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('511', '500150', '员工自助查询', 'Selfhelp inquiry', '員工自助查詢', NULL, NULL, NULL, 'hr/self_find', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function27 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2058");
        if (function27 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2058', '2019', '信息报送', 'Information Delivery', '資訊報送', NULL, NULL, NULL, '@infoDelivery', '', NULL,'','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function28 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2059");
        if (function28 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2059', '201902', '上报处理', 'Appear Information', '上報資訊', NULL, NULL, NULL, 'infomation/HandleIndex', '', NULL,'','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function29 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2060");
        if (function29 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2060', '201904', '信息统计', 'Information Query', '資訊統計査詢', NULL, NULL, NULL, 'infomation/statisticsIndex', '', NULL,'','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function30 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2069");
        if (function30 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2069', '201901', '新建报送', 'New Delivery', '新建報送', NULL, NULL, NULL, 'infomation/goAddInfomation', '', NULL,'','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function31 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2070");
        if (function31 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2070', '201903', '报送查询', 'Submit Query', '報送査詢', NULL, NULL, NULL, 'infomation/submitQuery', '', NULL,'','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function32 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2068");
        if (function32 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('2068', '500715', '值班管理', 'Duty management', '值班管理', NULL, NULL, NULL, 'dutyManagement/pageJumpDutyManagement', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function33 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "182");
        if (function33 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('182', '1050', '工作委托', 'Work Entrustment', '工作委託', '', '', '', 'workflow/rule', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function34 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "254");
        if (function34 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('254', '109060', '报表设置', 'Design Report', '報表設置', NULL, NULL, NULL, 'system/workflow/flow_report', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 增加菜单
         */
        boolean function35 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "256");
        if (function35 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`,`IS_SHOW_FUNC`) VALUES ('256', '1041', '数据报表', 'Data Report', '資料包表', NULL, NULL, NULL, 'workflow/report', '', '0','','','0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_item", "BEIKAO");
        if (checkIsExistfield_11 == false) {
            String sql = "alter table score_flow_item add BEIKAO varchar(255); ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_item", "BEIKAO_STR");
        if (checkIsExistfield_12 == false) {
            String sql = "alter table score_flow_item add BEIKAO_STR varchar(255); ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_13 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_item", "TYPE_ID");
        if (checkIsExistfield_13 == false) {
            String sql = "alter table score_flow_item add TYPE_ID INT(11); ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_14 = Verification.CheckIsExistfield(conn, driver, url, username, password, "score_group", "TYPE_ID");
        if (checkIsExistfield_14 == false) {
            String sql = "alter table score_group add TYPE_ID varchar(255); ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**  创建者：  张丽军
         *   添加表的作用: 值班管理
         *   添加时间：2018-09-11
         */
        boolean duty_form_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "duty_form");
        if (duty_form_flag == false) {
            String sql = "CREATE TABLE `duty_form`  (\n" +
                    "  `DUTY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '值班表主键',\n" +
                    "  `START_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开始时间',\n" +
                    "  `END_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '结束时间',\n" +
                    "  `WEEK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '星期',\n" +
                    "  `DATE_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日期',\n" +
                    "  `LEADER_CLASS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '带班领导',\n" +
                    "  `DAY_CLASS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班室白班',\n" +
                    "  `NIGHT_CLASS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '值班室夜班',\n" +
                    "  `CHANCE_CLASS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机要室值班',\n" +
                    "  `SECRETARY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文秘室值班',\n" +
                    "  `DRIVE_CLASS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '驾驶员值班',\n" +
                    "  `FORM_ID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发布用户id',\n" +
                    "  `FORM_DEPT` int(11) NULL DEFAULT NULL COMMENT '发布部门id',\n" +
                    "  `TO_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '按部门发布',\n" +
                    "  `PRIV_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '按角色发布',\n" +
                    "  `USER_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '按人员发布',\n" +
                    "  `ATTACHMENT_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附件id串',\n" +
                    "  `ATTACHMENT_NAME` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附件名称串',\n" +
                    "  `DEPT_YJ` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一级部门权限',\n" +
                    "  PRIMARY KEY (`DUTY_ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**  创建者：  张丽军
         *   添加表的作用: 复职管理
         *   添加时间：2018-09-11
         */
        boolean hr_rehab_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_rehab");
        if (hr_rehab_flag == false) {
            String sql = "CREATE TABLE `hr_rehab` (\n" +
                    "  `REHABID` int(11) NOT NULL,\n" +
                    "  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',\n" +
                    "  `POST` varchar(255) DEFAULT NULL COMMENT '担任职务',\n" +
                    "  `APPLY_DATA` date DEFAULT NULL COMMENT '申请日期',\n" +
                    "  `ACTUAL_DATA` date DEFAULT NULL COMMENT '实际复职日期',\n" +
                    "  `FORMALITY` varchar(255) DEFAULT NULL COMMENT '复职手续办理',\n" +
                    "  `REHAB_TYPE` varchar(255) DEFAULT NULL COMMENT '复职类型',\n" +
                    "  `REHAB_DEPT` varchar(255) DEFAULT NULL COMMENT '复职部门',\n" +
                    "  `NI_DATA` date DEFAULT NULL COMMENT '拟复职日期',\n" +
                    "  `WEGSDATA` date DEFAULT NULL COMMENT '工资恢复日期',\n" +
                    "  `EXPLAIN` varchar(255) DEFAULT NULL COMMENT '复职说明',\n" +
                    "  `REMARKS` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                    "  `ENCLOSURE_NAME` varchar(255) DEFAULT NULL COMMENT '附件名字',\n" +
                    "  `ENCLOSURE_ADDRESS` varchar(255) DEFAULT NULL COMMENT '附件地址',\n" +
                    "  `REGISTRATION_DATA` date DEFAULT NULL COMMENT '登记时间',\n" +
                    "  `MODIFY_DATA` date DEFAULT NULL COMMENT '最后修改时间',\n" +
                    "  PRIMARY KEY (`REHABID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='复职管理';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_15 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_log", "CLIENT_TYPE");
        if (checkIsExistfield_15 == false) {
            String sql = "alter table `sys_log` add CLIENT_TYPE tinyint(3) comment \"客户端类型(1：网页端，2：PC客户端，3：IOS端，4：安卓端)\";";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_16 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_log", "CLIENT_VERSION");
        if (checkIsExistfield_16 == false) {
            String sql = "alter table `sys_log` add CLIENT_VERSION varchar(20) comment \"版本号\"; ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 绩效考核
         *  2018-9-11
         */
        boolean checkIsExistfield_17 = Verification.CheckIsExistfield(conn, driver, url, username, password, "rms_file", "RUN_ID");
        if (checkIsExistfield_17 == false) {
            String sql = "alter table `rms_file` add RUN_ID int(11) comment \"流程归档的流程ID\"; ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /** 2018-09-11
         * 张丽军
         *  作用: 好友机制
         */
        boolean CheckIsExistPara_1 = Verification.CheckIsExistParam(conn, driver, url, username, password, "ISIMFRIENDS");
        if (CheckIsExistPara_1 == false) {
            String sql = "insert into sys_para(PARA_NAME,PARA_VALUE) values('ISIMFRIENDS',0);";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 添加好友
         */
        boolean isExistSmsCode_1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "26", "SMS_REMIND");
        if (isExistSmsCode_1 == false) {
            String sql = "insert into sys_code(CODE_NO,CODE_NAME,PARENT_NO,CODE_FLAG,CODE_EXT) values(26,'添加好友','SMS_REMIND',0,'')";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 添加好友
         */
        boolean isExistSmsCode_2 = Verification.CheckIsExistCode(conn, driver, url, username, password, "27", "SMS_REMIND");
        if (isExistSmsCode_2 == false) {
            String sql = "insert into sys_code(CODE_NO,CODE_NAME,PARENT_NO,CODE_FLAG,CODE_EXT) values(27,'添加好友','SMS_REMIND',0,'')";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-9-11
         *  创建者：张丽军
         *  作用: 会议管理
         */
        boolean isExistSmsCode_3 = Verification.CheckIsExistCode(conn, driver, url, username, password, "28", "SMS_REMIND");
        if (isExistSmsCode_3 == false) {
            String sql = "insert into sys_code(CODE_NO,CODE_NAME,PARENT_NO,CODE_FLAG,CODE_EXT) values(28,'会议管理','SMS_REMIND',0,'')";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**  创建者：  张丽军
         *   添加表的作用: 复职管理
         *   添加时间：2018-09-11
         */
        boolean im_friends_flag = Verification.CheckIsExistTable(conn, driver, url, username, password, "im_friends");
        if (im_friends_flag == false) {
            String sql = "CREATE TABLE `im_friends`  (\n" +
                    "  `FRD_ID` int(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                    "  `UID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户UID1',\n" +
                    "  `FUID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户FuID',\n" +
                    "  `MESSAGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证消息',\n" +
                    "  `PASS` int(20) NULL DEFAULT NULL COMMENT '是否为好友的状态',\n" +
                    "  PRIMARY KEY (`FRD_ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
        }
        /**
         * 张丽军
         *  添加字段的作用: 聊天消息
         *  2018-9-11
         */
        boolean checkIsExistfield_18 = Verification.CheckIsExistfield(conn, driver, url, username, password, "im_message", "THUMBNAIL_URL");
        if (checkIsExistfield_18 == true) {
            String sql = " alter table im_message modify column THUMBNAIL_URL text; ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加字段的作用: 工作流修改废弃字段
         *  2018-9-11
         */
        boolean checkIsExistfield_19 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run", "FROM_USER");
        if (checkIsExistfield_19 == true) {
            String sql = " alter table flow_run modify column FROM_USER varchar(20) DEFAULT null; ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**
         * 张丽军
         *  修改字段的作用: 档案查询路径不对
         *  2018-10-17
         */
        boolean checkIsExistFunction_01 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "61");
        if (checkIsExistFunction_01 == true) {
            String sql = "UPDATE sys_function SET `FUNC_CODE`='hr/query/Management' WHERE `FUNC_ID`='61';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**
         * 张丽军
         *  添加菜单作用: 邮件分发
         *  2018-10-17
         */
        boolean functionField_01 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2071");
        if (functionField_01 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2071', '0103', '邮件分发', 'Mail Distribute', '郵件分發', NULL, NULL, NULL, '/email/SendEmailsHtml', '', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**
         * 张丽军
         *  添加sys_para作用
         *  2018-10-17
         */
        boolean isExistPara_01 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "MOBILE_SMS_SET");
        if (isExistPara_01 == false) {
            String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('MOBILE_SMS_SET', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
            //如果需要执行多个则用&&符判断
        }

        /**
         * 张丽军
         *  添加sys_para作用
         *  2018-10-17
         */
        boolean isExistPara_02 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "OFUSERPWD");
        if (isExistPara_02 == false) {
            String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('OFUSERPWD', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
            //如果需要执行多个则用&&符判断
        }

        /*     *
         * 张丽军
         *  添加字段的作用: 添加字段
         * 2018-10-17
         *
         */
        boolean checkIsExistfield_01 = Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "SMS_GATE_ACCOUNT");
        if (checkIsExistfield_01 == false) {
            String sql = "ALTER TABLE department ADD COLUMN SMS_GATE_ACCOUNT VARCHAR(50) DEFAULT NULL COMMENT '账号';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*     *
         *   * 张丽军
         *  添加字段的作用: 添加字段
         * 2018-10-17
         */
        boolean checkIsExistfield_02 = Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "SMS_GATE_PASSWORD");
        if (checkIsExistfield_02 == false) {
            String sql = "ALTER TABLE department ADD COLUMN SMS_GATE_PASSWORD VARCHAR(50) DEFAULT NULL COMMENT '密码';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

                        /* *
                        张丽军
                     *  添加字段的作用: 修改字段类型
                     *  2018-10-19
                     */
        boolean existfield_01 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "ATTACHMENT_ID");
        if (existfield_01 == true) {
            String sql = "alter table hr_staff_incentive MODIFY COLUMN ATTACHMENT_ID VARCHAR(225) DEFAULT NULL;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
        }

                          /* *
                        张丽军
                     *  添加字段的作用: 修改字段类型
                     *  2018-10-19
                     */
        boolean existfield_02 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "ATTACHMENT_Name");
        if (existfield_02 == true) {
            String sql = "alter table hr_staff_incentive MODIFY COLUMN ATTACHMENT_Name VARCHAR(225) DEFAULT NULL;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
        }

        /*  2018-12-6 张丽军
         *      创建表 attend_leave_param
         */
        boolean checkIsExistAttend_leave_param = Verification.CheckIsExistTable(conn, driver, url, username, password, "attend_leave_param");
        if (checkIsExistAttend_leave_param == false) {
            String sql = "CREATE TABLE `attend_leave_param`  (\n" +
                    "  `ALPID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                    "  `WORKING_YEARS` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '工龄',\n" +
                    "  `LEAVE_DAY` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '年假天数',\n" +
                    "  PRIMARY KEY (`ALPID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '年假参数表' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 attend_rule
         */
        boolean checkIsExistAttend_rule = Verification.CheckIsExistTable(conn, driver, url, username, password, "attend_rule");
        if (checkIsExistAttend_rule == false) {
            String sql = "CREATE TABLE `attend_rule`  (\n" +
                    "  `ARID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                    "  `DEPT_ID` text CHARACTER SET gbk COLLATE gbk_chinese_ci NULL COMMENT '部门ID',\n" +
                    "  `OVERTIME_HOUR` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '加班小时数',\n" +
                    "  `OVERTIME_DAY` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '加班兑换天数',\n" +
                    "  `LATE_TYPE` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '迟到类型',\n" +
                    "  `LATE_ONCE` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '迟到次数',\n" +
                    "  `LATE_HOUR` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '迟到时间',\n" +
                    "  `ONE_LATE_HOUR` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '单次迟到分钟为旷工',\n" +
                    "  `ONE_EARLY_HOUR` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '单次迟到早退为旷工',\n" +
                    "  PRIMARY KEY (`ARID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '考勤统计计算规则' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 attend_schedule
         */
        boolean checkIsExistAttend_schedule = Verification.CheckIsExistTable(conn, driver, url, username, password, "attend_schedule");
        if (checkIsExistAttend_schedule == false) {
            String sql = "CREATE TABLE `attend_schedule` (\n" +
                    "  `ASID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                    "  `ASNAME` varchar(50) DEFAULT NULL COMMENT '排班名称',\n" +
                    "  `DEPT_ID` text COMMENT '部门',\n" +
                    "  `PRIV_ID` text COMMENT '角色',\n" +
                    "  `USER_ID` text COMMENT '人员',\n" +
                    "  `STATUS` int(11) unsigned DEFAULT NULL COMMENT '是否启用(0:否1:是)',\n" +
                    "  `DATE_START` date DEFAULT NULL COMMENT '排班开始日期',\n" +
                    "  `DATE_END` date DEFAULT NULL COMMENT '排班结束日期',\n" +
                    "  `YEAR_REPEAT` char(10) DEFAULT NULL COMMENT '是否按年重复(0:否1:是)',\n" +
                    "  `TYPE` char(10) DEFAULT NULL COMMENT '类型(1:固定排班2:弹性工时)',\n" +
                    "  `MONDAY_ID` char(10) DEFAULT NULL COMMENT '周一排班类型ID',\n" +
                    "  `TUESDAY_ID` char(10) DEFAULT NULL COMMENT '周二排班类型ID',\n" +
                    "  `WEDNESDAY_ID` char(10) DEFAULT NULL COMMENT '周三排班类型ID',\n" +
                    "  `THURSDAY_ID` char(10) DEFAULT NULL COMMENT '周四排班类型ID',\n" +
                    "  `FRIDAY_ID` char(10) DEFAULT NULL COMMENT '周五排班类型ID',\n" +
                    "  `SATURDAY_ID` char(10) DEFAULT NULL COMMENT '周六排班类型ID',\n" +
                    "  `SUNDAY_ID` char(10) DEFAULT NULL COMMENT '周日排班类型ID',\n" +
                    "  `WORK_DAY` varchar(50) DEFAULT NULL COMMENT '弹性工时-核心工作日期',\n" +
                    "  `WORK_HOUR` varchar(10) DEFAULT NULL COMMENT '弹性工时-最小工作小时',\n" +
                    "  `WORK_START` char(5) DEFAULT NULL COMMENT '核心工作开始时间',\n" +
                    "  `WORK_END` char(5) DEFAULT NULL COMMENT '核心工作结束时间',\n" +
                    "  `IS_OUT` char(10) DEFAULT NULL COMMENT '允许外勤签到(0:否,1:是)',\n" +
                    "  `SPECIAL_DAY` varchar(300) DEFAULT NULL COMMENT '特殊免签日期',\n" +
                    "  `UID` int(11) DEFAULT NULL COMMENT '创建者',\n" +
                    "  PRIMARY KEY (`ASID`),\n" +
                    "  KEY `type` (`TYPE`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='考勤排班设置列表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /*  2018-12-6 张丽军
         *      创建表 user_duty
         */
        boolean checkIsExistUser_duty = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_duty");
        if (checkIsExistUser_duty == false) {
            String sql = "CREATE TABLE `user_duty`  (\n" +
                    "  `UDID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                    "  `UID` int(11) NULL DEFAULT NULL COMMENT '用户UID',\n" +
                    "  `DUTY_TYPE` int(11) NULL DEFAULT NULL COMMENT '排班ID（1、正常  2、全日   休息无数据）',\n" +
                    "  `DUTY_DATE` date NULL DEFAULT NULL COMMENT '排班日期',\n" +
                    "  PRIMARY KEY (`UDID`) USING BTREE,\n" +
                    "  UNIQUE INDEX `index`(`UID`, `DUTY_DATE`) USING BTREE,\n" +
                    "  INDEX `uid`(`UID`) USING BTREE,\n" +
                    "  INDEX `duty_type`(`DUTY_TYPE`) USING BTREE,\n" +
                    "  INDEX `duty_date`(`DUTY_DATE`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '用户排班表' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 user_duty_backup
         */
        boolean checkIsExistUser_duty_backup = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_duty_backup");
        if (checkIsExistUser_duty_backup == false) {
            String sql = "CREATE TABLE `user_duty_backup`  (\n" +
                    "  `UDBID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                    "  `DUTY_ID` int(11) NULL DEFAULT NULL COMMENT '对应user_duty表中的id',\n" +
                    "  `UID` int(11) NULL DEFAULT NULL COMMENT '对应user_duty表中uid',\n" +
                    "  `DUTY_TYPE` int(11) NULL DEFAULT NULL COMMENT '对应user_duty表中duty_type',\n" +
                    "  `DUTY_DATE` date NULL DEFAULT NULL COMMENT '对应user_duty表中duty_date',\n" +
                    "  PRIMARY KEY (`UDBID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '该表用于操作免签节假日时备份user_duty表中数据' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*   * 2018-12-6 张丽军
         *  添加字段的作用: 修改菜单
         */
        boolean checkIsExistsys_function = Verification.CheckIsExistFunction(conn, driver, url, username, password, "509");
        if (checkIsExistsys_function == true) {
            String sql = "update sys_function SET MENU_ID='500710' ,FUNC_CODE='attendanceWay/attindex',FUNC_NAME1='Attendance setting' WHERE FUNC_ID=509;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*     *
         *  添加字段的作用: 添加字段
         */
        boolean checkIsExistfield_101 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "NEW_TYPE");
        if (checkIsExistfield_101 == false) {
            String sql = "alter table flow_type add COLUMN NEW_TYPE varchar(10) comment '新建的时候可选择快速新建0，新建向导1';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 flow_run_read
         */
        boolean checkIsExistFlow_run_read = Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_run_read");
        if (checkIsExistFlow_run_read == false) {
            String sql = "CREATE TABLE `flow_run_read` (\n" +
                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',\n" +
                    "  `RUN_ID` int(11) NOT NULL COMMENT '流程实例ID',\n" +
                    "  `USER_ID` varchar(40) NOT NULL COMMENT '传阅人',\n" +
                    "  `READ_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '阅读时间',\n" +
                    "  `READ_FLAG` int(11) NOT NULL DEFAULT '0' COMMENT '是否阅读',\n" +
                    "  `CREATE_DATE` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',\n" +
                    "  `PRCS_ID` int(11) NOT NULL COMMENT '实际步骤',\n" +
                    "  `FLOW_PRCS` int(11) NOT NULL COMMENT '设计步骤',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT = '传阅表';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 flow_relation
         */
        boolean checkIsExistFlow_relation = Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_relation");
        if (checkIsExistFlow_relation == false) {
            String sql = "CREATE TABLE `flow_relation`  (\n" +
                    "  `FLOW_REL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID主键',\n" +
                    "  `FLOW_REF_NO` int(11) NOT NULL COMMENT '排序号',\n" +
                    "  `FLOW_ID` int(11) NOT NULL COMMENT '流程ID',\n" +
                    "  `FLOW_REL_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联关系名称',\n" +
                    "  `RELATION_TYPE` int(11) NOT NULL COMMENT '关联类型（1-固定关联卡片2-关联流程）',\n" +
                    "  `RELATION_FLOW_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联字段',\n" +
                    "  `RELATION_STATUS` int(1) NOT NULL DEFAULT 0 COMMENT '关联状态(0-停用,1-必选,可选状态无效)',\n" +
                    "  `FLOW_RANGE` int(255) NULL DEFAULT 0 COMMENT '关联人员范围(0为所有，1为经办)',\n" +
                    "  `TIME_RANGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '时间范围(上月1、上季度2、上年度3、本月4、本季度5、本年6)',\n" +
                    "  `DATA_DIRECTION` int(1) NOT NULL DEFAULT 0 COMMENT '数据方向(0-单向,1-双向)',\n" +
                    "  `FLOW_REL_DESC` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关联描述',\n" +
                    "  `MAPPING` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据关系映射',\n" +
                    "  `MAPPING_DESC` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '中文数据关联映射',\n" +
                    "  PRIMARY KEY (`FLOW_REL_ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '流程关联' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 cp_asset_reflect_transfer
         */
        boolean checkIsExistCp_asset_reflect_transfer = Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_asset_reflect_transfer");
        if (checkIsExistCp_asset_reflect_transfer == false) {
            String sql = "CREATE TABLE `cp_asset_reflect_transfer`  (\n" +
                    "  `ID` int(11) NOT NULL,\n" +
                    "  `FROM_DEPT_ID` int(11) NOT NULL COMMENT '调出单位（部门）',\n" +
                    "  `TO_DEPT_ID` int(11) NOT NULL COMMENT '调入单位（部门）',\n" +
                    "  PRIMARY KEY (`ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '固定资产调拨表' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /*     *张丽军
         *  添加字段的作用: 添加字段
         */
        boolean checkIsExistfield_102 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "LOCATION_ADDRESS");
        if (checkIsExistfield_102 == false) {
            String sql = "ALTER TABLE hr_staff_info ADD COLUMN `LOCATION_ADDRESS` VARCHAR(255) DEFAULT NULL COMMENT '所在位置';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*     *张丽军
         *  添加字段的作用: 添加字段
         */
        boolean checkIsExistfield_103 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "LOCATION_ADDRESS");
        if (checkIsExistfield_103 == false) {
            String sql = "ALTER TABLE hr_staff_info ADD COLUMN `PROJECT_NAME` VARCHAR(255) DEFAULT NULL COMMENT '项目名称';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }




        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode13 = Verification.CheckIsExistCode(conn, driver, url, username, password, "PROJECT_NAME", "");
        if (isExistCode13 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('PROJECT_NAME', '项目名称', NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode14 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "PROJECT_NAME");
        if (isExistCode14 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('01', '项目A', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'PROJECT_NAME', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode15 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "PROJECT_NAME");
        if (isExistCode15 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('02', '项目B', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'PROJECT_NAME', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode16 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "PROJECT_NAME");
        if (isExistCode16 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('03', '项目C', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'PROJECT_NAME', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }



        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode17 = Verification.CheckIsExistCode(conn, driver, url, username, password, "LOCATION_ADDRESS", "");
        if (isExistCode17 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('LOCATION_ADDRESS', '所在位置', NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode18 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "LOCATION_ADDRESS");
        if (isExistCode18 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('01', '海淀', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'LOCATION_ADDRESS', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode19 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "LOCATION_ADDRESS");
        if (isExistCode19 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('02', '朝阳', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'LOCATION_ADDRESS', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**   2018-1-26
         *  作用: 项目名称
         */
        boolean isExistCode20 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "LOCATION_ADDRESS");
        if (isExistCode20 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('03', '昌平', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'LOCATION_ADDRESS', '1', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 cp_asset_reflect
         */
        boolean checkIsExistCp_asset_reflect = Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_asset_reflect");
        if (checkIsExistCp_asset_reflect == false) {
            String sql = "CREATE TABLE `cp_asset_reflect`  (\n" +
                    "  `ID` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '唯一ID',\n" +
                    "  `CPTL_NO` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产编号',\n" +
                    "  `ASSETS_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产名称：手工输入，必填字段；',\n" +
                    "  `TYPE_ID` int(11) NOT NULL DEFAULT 1 COMMENT '资产类型',\n" +
                    "  `FACTORY_NO` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '出厂编号',\n" +
                    "  `DEPT_ID` int(11) NOT NULL DEFAULT 0 COMMENT '所属部门',\n" +
                    "  `CPTL_KIND` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '资产性质',\n" +
                    "  `PRCS_ID` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '增加类型',\n" +
                    "  `DCR_PRCS_ID` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '减少类型',\n" +
                    "  `KEEPER` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '保管人',\n" +
                    "  `FROM_YYMM` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0000-00-00' COMMENT '启用日期',\n" +
                    "  `VALIDITY_TIME` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '有效日期',\n" +
                    "  `DCR_DATE` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0000-00-00' COMMENT '减少日期',\n" +
                    "  `LOGOUT_TIME` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报废日期',\n" +
                    "  `CREATE_TIME` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0000-00-00' COMMENT '创建时间',\n" +
                    "  `IS_ASSETS` int(11) NOT NULL DEFAULT 1 COMMENT '是否为固定资产（0.不是1.是 默认1）',\n" +
                    "  `NUMBER` int(11) NOT NULL DEFAULT 1 COMMENT '数量',\n" +
                    "  `INFO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '品牌—型号',\n" +
                    "  `BUY_TIME` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '购买时间',\n" +
                    "  `CURRRNT_LOCATION` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '目前所在位置',\n" +
                    "  `STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物品状态菜单选项有1-未使用、2-使用、3-损坏、4-丢失、5-报废；',\n" +
                    "  `IS_CERTIFICATE` int(10) NOT NULL DEFAULT 0 COMMENT '是否有证书（1.有0.没有）默认0',\n" +
                    "  `CERTIFICATE_NO` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '如有证书需填写证书编号',\n" +
                    "  `ATTACHMENT_ID` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件证书附件ID',\n" +
                    "  `ATTACHMENT_NAME` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证书附件名称',\n" +
                    "  `IMAGE` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '固定资产图片',\n" +
                    "  `QR_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '根据前面的字段信息自动生成，保存时执行,二维码',\n" +
                    "  `COMPANYID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '当前企业的 id',\n" +
                    "  `CREATER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人：系统自动带出当前人姓名；',\n" +
                    "  `REMARK` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                    "  `CPTL_VAL` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '资产原值',\n" +
                    "  `CPTL_BAL` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00' COMMENT '净残值率',\n" +
                    "  `CPTL_BAL_VAL` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '净残值',\n" +
                    "  `DPCT_YY` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00' COMMENT '折旧年限',\n" +
                    "  `USE_YY` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '使用年限(月)',\n" +
                    "  `SUM_DPCT` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00' COMMENT '累计折旧',\n" +
                    "  `MON_DPCT` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00' COMMENT '折旧额',\n" +
                    "  `MON_DEPR` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.0000' COMMENT '折旧率',\n" +
                    "  `WORTH` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '资产净值',\n" +
                    "  `YY_DPCT` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.00' COMMENT '本年计提折旧',\n" +
                    "  `MON_ACCRUAL` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '已计提月份',\n" +
                    "  `FINISH_FLAG` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '折旧',\n" +
                    "  `TRANSFERID` int(11) NULL DEFAULT NULL COMMENT '调拨ID',\n" +
                    "  PRIMARY KEY (`ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '导入字段信息表' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /**
         * 张丽军
         *  添加菜单作用:待阅事宜菜单
         *  2018-10-17
         */
        boolean functionField_121 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3032");
        if (functionField_121 == false) {
            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3032', '0110', '待阅事宜', 'Questions to Read', '待阅事宜', NULL, NULL, NULL, 'ToBeReadController/toReadFile', '', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*     *
         *  添加字段的作用: 并发相关
         */
        boolean checkIsExistfield_122 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_prcs", "BRANCH_COUNT");
        if (checkIsExistfield_122 == false) {
            String sql = "ALTER table flow_run_prcs  add column  `BRANCH_COUNT` VARCHAR(100) DEFAULT NULL  COMMENT '并发步骤';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*     *
         *  添加字段的作用:公文document表添加创建时间
         */
        boolean checkIsExistfield_123 = Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "create_time");
        if (checkIsExistfield_123 == false) {
            String sql = "alter table document add column create_time datetime comment '创建时间'; ";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  2018-12-6 张丽军
         *      创建表 cp_asset_type
         */
        boolean checkIsExistCp_asset_type = Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_asset_type");
        if (checkIsExistCp_asset_type == false) {
            String sql = "CREATE TABLE `cp_asset_type`  (\n" +
                    "  `TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                    "  `TYPE_NAME` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL DEFAULT '' COMMENT '类别名称',\n" +
                    "  `TYPE_NO` int(11) NOT NULL DEFAULT 0 COMMENT '类别排序号',\n" +
                    "  PRIMARY KEY (`TYPE_ID`) USING BTREE\n" +
                    ") ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '资产类别表' ROW_FORMAT = Compact;";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }




        /*  *
         *  作用: 添加数据待阅
         */
        boolean cp_asset_type_1 = Verification.CheckIsExistCp_asset_type(conn, driver, url, username, password, "1");
        if (cp_asset_type_1 == false) {
            String sql = "INSERT INTO `cp_asset_type` VALUES (1, '电子产品', 1);";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*  *
         *  作用: 添加数据待阅
         */
        boolean cp_asset_type_2 = Verification.CheckIsExistCp_asset_type(conn, driver, url, username, password, "3");
        if (cp_asset_type_2 == false) {
            String sql = "INSERT INTO `cp_asset_type` VALUES (3, '办公设备', 2);";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /* *
         *  作用: 设计步骤
         */

        boolean existInfoCenter23 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_read", "FLOW_PRCS");
        if (existInfoCenter23 == true) {
            String sql = "ALTER table flow_run_read  MODIFY `FLOW_PRCS` VARCHAR(255) not NULL  COMMENT '设计步骤';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /* *
         *  作用: 会签意见类型
         */

        boolean existInfoCenter24 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_feedback", "FEED_FLAG");
        if (existInfoCenter24 == true) {
            String sql = "alter table flow_run_feedback modify column FEED_FLAG varchar(50) NOT NULL DEFAULT '0' COMMENT '会签意见类型(1-点评意见,其他-会签意见)';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*  *
         *  作用: 添加数据待阅
         */
        boolean widget_1 = Verification.CheckIsExistWidget(conn, driver, url, username, password, "9");
        if (widget_1 == false) {
            String sql = "INSERT INTO `widget` (`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES ('9', '待阅', '0', '1', 'waitRead', '1', '1', '9');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /*    *
         *  添加字段的作用: 添加菜单
         */
        boolean isExistFunction_a = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5017");
        if (isExistFunction_a == false) {
            String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES (5017, '5012', '人员调度', 'Salary Manage', '人員調度', NULL, NULL, NULL, '@hr', '', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  添加字段的作用: 添加菜单
         */
        boolean isExistFunction_b = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5018");
        if (isExistFunction_b == false) {
            String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES (5018, '501201', '人员调度', 'Dispatcher', '人員調度', NULL, NULL, NULL, '/hrPersonnelScheduling/peopleSchedulingList', '', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }
        /*    *
         *  添加字段的作用: 添加菜单
         */
        boolean isExistFunction_c = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5019");
        if (isExistFunction_c == false) {
            String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES (5019, '501202', '人员调度查询', 'Dispatcher query', '人員調度查詢', NULL, NULL, NULL, '/hrPersonnelScheduling/peopleSchedulingListQuery', '', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        //添加字段
        boolean userExtTable11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "PROJECT_NAME");
        if (userExtTable11 == false) {
            String sql = "ALTER TABLE `hr_staff_info` ADD `PROJECT_NAME` VARCHAR ( 255 ) DEFAULT NULL COMMENT '项目名称';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        //添加字段
        boolean userExtTable21 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "LOCATION_ADDRESS");
        if (userExtTable21 == false) {
            String sql = "ALTER TABLE `hr_staff_info` ADD `LOCATION_ADDRESS` varchar(255) DEFAULT NULL COMMENT '所在位置';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }

        /**   2018-1-26
         *  作用: 添加职务、岗位下拉框
         */
        boolean isExistCode_1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "29", "SMS_REMIND");
        if (isExistCode_1 == false) {
            String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('29', '人员调度', NULL, NULL, NULL, NULL, NULL, NULL, '29', 'SMS_REMIND', '0', '');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
        }


        /*  *//**
         *  添加者：张丽军
         *  添加日期：2018-5-10
         *  添加字段的作用: 分级机构添加设置
         */
        boolean isExistPara_f = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "ORG_SCOPE");
        if (isExistPara_f == false) {
            String sql = "INSERT INTO sys_para (`PARA_NAME`, `PARA_VALUE`) VALUES ('ORG_SCOPE', '0');";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
            //如果需要执行多个则用&&符判断
        }

    }
    
    
    
    
}