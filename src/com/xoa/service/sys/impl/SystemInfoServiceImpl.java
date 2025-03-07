package com.xoa.service.sys.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.version.VersionMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.users.OrgManageService;
import com.xoa.service.users.UsersService;
import com.xoa.util.I18nUtils;
import com.xoa.util.common.StringUtils;
import com.xoa.util.ipUtil.MachineCode;
import com.xoa.util.systeminfo.DESUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ContextLoader;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/5/31 19:26
 * @类介绍: 系统信息
 * @构造参数: 无
 **/
@Service
public class SystemInfoServiceImpl implements SystemInfoService {
    @Resource
    private UnitManageMapper unitManageMapper;
    @Resource
    private UsersService usersService;
    @Resource
    private OrgManageService orgManageService;

    @Resource
    private SysParaMapper sysParaMapper;
    @Autowired
    private VersionMapper versionMapper;

    @Value("${xoa_softName}")
    String softName;
    @Value("${xoa_cpright}")
    String cpright;
    @Value("${xoa_weblocation}")
    String weblocation;
    //加密密钥，后期可以根据不同的公司，设置不同的秘钥，注意生成授权文件中的是这个，要是改变，都要变
    public static final String MY_KEY = "";
    public static final String NEW_KEY2020 = "";
    //系统版本 修改系统版本年份 请同时修改 Register.java中的注册文件名称
    public static final String softVersion = "2023.06.01.1";
    //版本号
    public static final String softVersionNO = "1.7";
    public static String webPort = "8080";
    public static String dbName = "Mysql";
    public static String dbVersion = "5.6";
    public static final String timezone = "中国标准时间 (8 GMT)";
    public static String isSoftAuth = "未授权";
    public static String useCom = "5";
    public static String dbMysql = "com.mysql.cj.jdbc.Driver";
    public static String dbOracle = "oracle.jdbc.driver.OracleDriver";
    public static String dbDM = "dm.jdbc.driver.DmDriver";
    public static String dbKB = "com.kingbase8.Driver";


    //服务器路径
    public static String serverPath = "";
    //正式授权信息说明文字
    public static final String reloadAuthorizationstr = "正式授权信息" +
            "（正式授权信息，需校验组织机构名称、机器码和软件序列号，务必与授权文件中的信息一致）";


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 19:27
     * @函数介绍: 获取系统信息
     * @参数说明: @param 无
     * @return: Map<String, String>
     **/
    public Map<String, String> getSystemInfo(String path, Object locale, HttpServletRequest request) throws ParseException {
        I18nUtils.setLocale((String) locale);
        ResourceBundle rb = ResourceBundle.getBundle("jdbc-sql");

        if (dbOracle.equals(rb.getString("driverClassName"))) {
            dbName = "Oracle";
        } else if (dbMysql.equals(rb.getString("driverClassName"))) {
            dbName = "Mysql";
        } else if (dbDM.equals(rb.getString("driverClassName"))) {
            dbName = "DM";
        } else if (dbKB.equals(rb.getString("driverClassName"))) {
            dbName = "Kingbase";
            dbVersion = "V8R3";
        }
        if(request!=null){
            webPort = String.valueOf(request.getLocalPort());
        }
        Map<String, String> map = new HashMap<String, String>();
        //版权所有
        map.put("cpright", cpright);
        //官方网站
        map.put("weblocation", weblocation);
        //WEB端口
        map.put("webPort", webPort);
        ServletContext servletContext = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        String serverInfo = servletContext.getServerInfo();
        //WEB服务器
        map.put("webServer", serverInfo);
        //数据库名
        map.put("dbName", dbName);
        //数据库版本
        map.put("dbVersion", dbVersion);
        //语言
        if (locale == null) {
            map.put("language", "zh_CN");
        } else {
            map.put("language", locale.toString());
        }

        //时区
        map.put("timezone", timezone);

        //已用单位数
        List<OrgManage> orgManageList = orgManageService.getOrgManage();

        if (orgManageList != null) {
            useCom = orgManageList.size() + "";
        }
        //使用单位数
        map.put("useCom", useCom);


        //软件版本
        map.put("softVersion", softVersion);

        //数据库中的版本
        String dataversion = versionMapper.selectVer();

        map.put("dataversion", dataversion);

        // map.put("softVersionNO", softVersionNO);
        //操作系统
        map.put("operationSystem", getOperationSystem());

        //map.put("serverPath", serverPath);

        //jdk版本


        map.put("jdkVersion", getJdkVersion());
        //  map.put("machineCode", MachineUtil.get16Machine());
        //查询用户数
        int usercount = usersService.getUserCount();
        //允许登录用户数
        int canLoginUser = usersService.getCanLoginUser();
        int notLoginUser = usercount - canLoginUser;
        //用户情况
        map.put("userInfo", I18nUtils.getMessage("main.th.totalNumberOfUsersInfo1") + usercount + I18nUtils.getMessage("main.th.totalNumberOfUsersInfo2") + canLoginUser + I18nUtils.getMessage("main.th.totalNumberOfUsersInfo3") + notLoginUser + ")");


        map.put("reloadAuthorizationstr", reloadAuthorizationstr);
        //授权信息
        Map<String, String> infoMap = getAuthInfo(path);
        if (infoMap==null||infoMap.size()==0){
            return null;
        }

        //注册日期
        String lecDateStr = infoMap.get("lecDateStr");
        //服务截止日期
        map.put("endLecDateStr", infoMap.get("endDay"));

        if ("true".equals(infoMap.get("isAuthStr"))) {
            map.put("softName", getSoftName(true));
            //软件序列号
            map.put("softSerialNo", infoMap.get("sn_no"));
            String sn_no = infoMap.get("sn_no");
            String newStr = new String();
            if (!StringUtils.checkNull(sn_no)) {
                Calendar date = Calendar.getInstance();
                String year = String.valueOf(date.get(Calendar.YEAR));
                int len = sn_no.indexOf(year);
            }
            //根据序列号增加软件名称
            if (StringUtils.checkNull(newStr)) {
                map.put("softNoName", I18nUtils.getMessage("sysInfo.th.communityEdition"));
            } else {
                map.put("softNoName", newStr);
            }
        } else {
            map.put("softName", getSoftName(false));
            map.put("softNoName", I18nUtils.getMessage("sysInfo.th.communityEdition"));
            map.put("freeCompany", "1");
            //软件序列号
            map.put("softSerialNo", I18nUtils.getMessage("event.th.nothing"));

        }

        //授权单位数
        map.put("company_num", infoMap.get("company_num"));
        //授权单位
        map.put("authorizationUnit", infoMap.get("company"));
        //  map.put("orgName", infoMap.get("company"));
        //先去判断软件是否注册
        if ("true".equals(infoMap.get("isAuthStr"))) {
            //授权用户数
            map.put("oaUserLimit", infoMap.get("users"));
        } else {
            map.put("oaUserLimit", "30");
        }


        //机器码16位
        String machineCode = this.getMachineCode16();;
        map.put("authorizationCode", machineCode);

        //安装日期
        map.put("installDate", infoMap.get("installDate"));


        //是否授权（注册）
        String isAuthStr = infoMap.get("isAuthStr");
        if ("true".equals(isAuthStr)) {
            map.put("isSoftAuth", I18nUtils.getMessage("sysInfo.th.registered"));

        } else {
            map.put("isSoftAuth", I18nUtils.getMessage("sysInfo.th.notRegisteredSmallAndMicroEnterpriseEdition"));
            map.put("endLecDateStr", null);
        }


        if (map.get("isSoftAuth").contains(I18nUtils.getMessage("sysInfo.th.smallAndMicroEnterpriseEdition"))) {
            //注册日期
            map.put("lecDateStr", I18nUtils.getMessage("event.th.nothing"));
        } else {
            //注册日期
            map.put("lecDateStr", infoMap.get("lecDateStr"));
        }
        //版本
        map.put("edition", infoMap.get("edition"));
        //模块权限
        map.put("module", infoMap.get("module"));
        return map;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 16:37
     * @函数介绍: 获取操作系统信息
     * @参数说明: 无
     * @return: String
     **/
    public String getOperationSystem() {

        Properties prop = System.getProperties();
        String osName = (String) prop.get("os.name");
        /*if (osName.startsWith("Windows") || osName.startsWith("windows")) {
            osName = "Windows";
        }*/
        return osName; //operationSystem;
    }


    public String getJdkVersion() {
        return System.getProperty("java.version");
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/26 16:36
     * @函数介绍: 从授权文件中获取授权信息, 根据授权与否设置不同。
     * 授权文件里的信息解密后用逗号隔开。依次是
     * 公司名，企业数，授权人数，授权开始时间，授权结束时间，软件序列号，机器码，授权使用时间。
     * xxx公司,5,30,2017-06-28,2017-08-31,xoa17-12345678-1234,L1HF52F003PAAAAA,30
     * @参数说明: @param 无
     * @return: Map<String, String></String,>
     **/
    public Map<String, String> getAuthInfo(String path) {

        Map<String, String> hashMap = null;
        try {
            hashMap = new HashMap<String, String>();
            //安装时间
            File file1 = new File(path.concat("/authfiles/temp"));
            long lastModified1 = file1.lastModified();
            Date installDate1 = new Date(lastModified1);
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
            String installDateStr = sdf1.format(installDate1);
            hashMap.put("installDate", installDateStr);

            hashMap.put("isAuthStr", "true");
            //永久使用
            hashMap.put("endDay", "2040-01-01");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return hashMap;
    }

    public Map<String, String> getEndLecDate(HttpServletRequest request) throws ParseException {
        Map<String, String> map = new HashMap<String, String>();


        Map<String, String> authInfoMap = getAuthInfo(request);
        String endLecDateStr = authInfoMap.get("endLecDateStr");


        String lecDateStr = authInfoMap.get("lecDateStr");
        //用户数
        String users = authInfoMap.get("users");
        lecDateStr = lecDateStr + " 00:00:00";
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date startDate1 = sdf2.parse(lecDateStr);
        Long addTime = 365 * 24 * 60 * 60 * 1000L;
        Long time = startDate1.getTime() + addTime;
        Date endDate = new Date(time);
        String endDateStr = sdf2.format(endDate);
        endDateStr = endDateStr.substring(0, 10);


        String isAuthStr = authInfoMap.get("isAuthStr");
        String useEndDate;
        if ("true".equals(isAuthStr)) {
            //永久使用
            useEndDate = "0000-00-00";
        } else {


        }
        //使用截止日期
        if ("true".equals(isAuthStr)) {
            //永久使用为null
            map.put("useEndDate", "0000-00-00");
        } else {

            String installDateStr = authInfoMap.get("installDate");
            installDateStr = installDateStr + " 00:00:00";
            SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date startDate = sdf1.parse(installDateStr);
            String tryDay = authInfoMap.get("tryDay");

            //默认给个值。
            int trydayTime = 30;
            try {
                trydayTime = Integer.parseInt(tryDay);
            } catch (Exception e) {
            }

            Long addTime1 = trydayTime * 24 * 60 * 60 * 1000L;
            Long time1 = startDate.getTime() + addTime1;
            Date endDate1 = new Date(time1);
            String endDateStr1 = sdf1.format(endDate1);
            useEndDate = endDateStr1.substring(0, 10);
            map.put("useEndDate", useEndDate);

        }

        map.put("endLecDateStr", authInfoMap.get("endDay"));
        map.put("isAuthStr", isAuthStr);
        //用户数
        map.put("usercount", users);
        return map;
    }

    @Override
    public Map<String, String> getAPPMessage() {
        Map<String, String> maps = new HashMap<String, String>();
        SysPara sysPara = sysParaMapper.querySysPara("APP_Android_Version");
        SysPara sysPara1 = sysParaMapper.querySysPara("APP_IOS_Version");
        SysPara sysPcVesison = sysParaMapper.querySysPara("APP_PC_Version");
        SysPara sysPcUrl = sysParaMapper.querySysPara("APP_PC_DownUrl");
        maps.put("softVersionAndroidNO", sysPara.getParaValue());
        maps.put("softVersionIOSNO", sysPara1.getParaValue());
        maps.put("filePath", "file/apk/android/Xoa.apk");
        maps.put("softVersionPCNO", sysPcVesison.getParaValue());
        maps.put("pcfilePath", sysPcUrl.getParaValue());
        return maps;
    }

    @Override
    public Map<String, String> getAuthorization(HttpServletRequest request) {
        Map<String, String> maps = getAuthInfo(request);

        return maps;
    }

    //校验授权模块 1,2,3
    @Override
    public Map checkModule(HttpServletRequest request, String moustr) {
        Map moudleMap = new HashedMap();
        Map resMap = new HashedMap();
        int count = 0;
        String authMoudle = getAuthInfo(request).get("module");
        if (moustr.indexOf(",") > -1 && !StringUtils.checkNull(moustr)) {

            String[] mouArr = moustr.split(",");
            for (String mou : mouArr) {
                if (!StringUtils.checkNull(mou) && authMoudle.indexOf(mou) > -1) {

                    moudleMap.put(mou, true);
                } else {
                    count++;
                    moudleMap.put(mou, false);
                }
            }
        } else if (!StringUtils.checkNull(moustr)) {
            if (!StringUtils.checkNull(moustr) && authMoudle.indexOf(moustr) > -1) {

                moudleMap.put(moustr, true);
            } else {
                count++;
                moudleMap.put(moustr, false);
            }

        } else {
            count++;
        }
        resMap.put("detail", moudleMap);

        resMap.put("result", count == 0 ? true : false);
        return resMap;
    }

    @Override
    public String getAuthModule(HttpServletRequest request) {
        Map authinfo = getAuthInfo(request);
        String moudleStr = "";
        try {
            moudleStr = (String) authinfo.get("module");
        } catch (Exception e) {
            moudleStr = "";
        }
        return moudleStr;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/29 11:29
     * @函数介绍: 验证本机的机器码和给的机器吗是否一致
     * @参数说明: @param authMachineCode
     * @return: boolean ,true 表示一致
     */
    @Override
    public boolean checkMachineCode(String authMachineCode) throws Exception {

        //机器码16位 因为发现注册机生成的机器码后四位和产品生成机器码的后四位方法竟然很奇葩的不一致，故添加AAAA
        String machineCode = "";
        String encrypt = DESUtils.encrypt(machineCode, NEW_KEY2020);
        //获取本机机器码，拼接或追加的16位,网卡不同对应不同的mac地址。
        if (encrypt != null && encrypt.equals(DESUtils.encrypt(authMachineCode, NEW_KEY2020))) {
            return true;
        }
        return false;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/29 18:17
     * @函数介绍: 获取用户人数
     * @参数说明: 无
     * @return: boolean
     **/
    @Override
    public int getAuthUser(HttpServletRequest request) {

        String realPath = request.getSession().getServletContext().getRealPath("/");

        Map<String, String> authInfo = getAuthInfo(realPath);

        try{
            if("不限制".equals(authInfo.get("users"))){
                return 999999999;
            } else {
                return Integer.parseInt(authInfo.get("users"));
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public int getOrgManage(HttpServletRequest request) {
        StringBuffer sb = new StringBuffer();
        String realPath = request.getSession().getServletContext().getRealPath("/");

        File file = new File(realPath.concat("/authfiles/xoa2020.dat"));
        if (file == null) {
            file = new File(realPath.concat("/authfiles/lec.txt"));
        }
        //BufferedReader br = null;
        Map<String, String> hashMap = null;
        try (FileReader fileReader = new FileReader(file);
             BufferedReader br = new BufferedReader(fileReader);) {

            String s;
            while ((s = br.readLine()) != null) {
                sb.append(s);
            }



            String decryptData = DESUtils.finalDec(sb.toString());

            String[] infoArr = decryptData.split(",");

            String userCount = infoArr[1];


            //0表示不限制，
            if (Integer.parseInt(userCount) == 0) {
                return 99999999;
            }
            return Integer.parseInt(userCount);

        } catch (Exception e) {
            e.printStackTrace();
        }


        return 0;
    }

    public String getSoftName(boolean isAuth) {
        return softName;
    }

    /**
     * @创建作者: zhanglijun
     * @创建日期: 2019/4/17 20:32
     * @函数介绍: 计算两个时间之间的天数，比如处理2017-5-27:22:22:22 到2017-5-28:22:22:22之间是2天。
     * @参数说明: @param startDay 日志开始的时间
     * @return: int
     **/
    public int getDay(Date startDay) throws ParseException {

        int totalDay = 0;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String startDayStr = sdf.format(startDay);
        Date startDate = sdf.parse(startDayStr);
        long startSeconds = startDate.getTime();
        String c = String.valueOf(startSeconds);
        c = c.substring(0, c.length() - 3);
        startSeconds = Long.valueOf(c);

        Date date = new Date();
        SimpleDateFormat sdfs = new SimpleDateFormat("yyyy-MM-dd");
        String endTodayStr = sdfs.format(date);
        Date endDate = sdfs.parse(endTodayStr);
        long endSeconds = endDate.getTime();
        String v = String.valueOf(endSeconds);
        v = v.substring(0, v.length() - 3);
        endSeconds = Long.valueOf(v);
        totalDay = (int) (startSeconds - endSeconds);

        return totalDay;
    }

    //TEST  lr  注册
    public Map<String, String> getAuthInfo(HttpServletRequest request) {
        String path = request.getSession().getServletContext().getRealPath("/");
        return getAuthInfo(path);
    }


    public String getMachineCode16(){
        //机器码16位
        String machineCode = null;
        ResultSet rs = null;
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = props.getProperty("url1001");

            String driver = props.getProperty("driverClassName");
            String username = props.getProperty("uname1001");
            String password = props.getProperty("password1001");

            // 增加人大金仓判断
            if("com.kingbase8.Driver".equals(props.getProperty("driverClassName"))){
                username = props.getProperty("KingBase8.username1001");
                password = props.getProperty("KingBase8.password1001");
                url = props.getProperty("KingBase8.url1001");
            } else if ("dm.jdbc.driver.DmDriver".equals(props.getProperty("driverClassName"))){
                username = props.getProperty("xoa.dameng.username1001");
                password = props.getProperty("xoa.dameng.password1001");
                url = props.getProperty("xoa.dameng.url1001");
            }
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);

            String sql = " SELECT * " +
                    "      FROM sys_para " +
                    "      where PARA_NAME='PUSH_MNO' and PARA_VALUE is not null;";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);//执行SQL语句
            if (rs.next()) {
                machineCode = rs.getString("PARA_VALUE");
            } else {
                machineCode = MachineCode.get16CharMacsType() == null ? "" : MachineCode.get16CharMacsType().get(0);
                SysPara sysPara = new SysPara();
                sysPara.setParaName("PUSH_MNO");
                sysPara.setParaValue(machineCode);
                sysParaMapper.insertSysPara(sysPara);
            }

        }catch (Exception e){

        }
        return machineCode;
    }

    @Override
    public Map<String, String> getSystemInfoDefault(String path, Object locale, HttpServletRequest request) {
        I18nUtils.setLocale((String) locale);
        ResourceBundle rb = ResourceBundle.getBundle("jdbc-sql");

        if (dbOracle.equals(rb.getString("driverClassName"))) {
            dbName = "Oracle";
        } else if (dbMysql.equals(rb.getString("driverClassName"))) {
            dbName = "Mysql";
        } else if (dbDM.equals(rb.getString("driverClassName"))) {
            dbName = "DM";
        } else if (dbKB.equals(rb.getString("driverClassName"))) {
            dbName = "Kingbase";
            dbVersion = "V8R3";
        }
        if(request!=null){
            webPort = String.valueOf(request.getLocalPort());
        }
        Map<String, String> map = new HashMap<String, String>();
        //版权所有
        map.put("cpright", cpright);
        //官方网站
        map.put("weblocation", weblocation);
        //WEB端口
        map.put("webPort", webPort);
        ServletContext servletContext = ContextLoader.getCurrentWebApplicationContext().getServletContext();
        String serverInfo = servletContext.getServerInfo();
        //WEB服务器
        map.put("webServer", serverInfo);
        //数据库名
        map.put("dbName", dbName);
        //数据库版本
        map.put("dbVersion", dbVersion);
        //语言
        if (locale == null) {
            map.put("language", "zh_CN");
        } else {
            map.put("language", locale.toString());
        }

        //时区
        map.put("timezone", timezone);

        //已用单位数
        List<OrgManage> orgManageList = orgManageService.getOrgManage();

        if (orgManageList != null) {
            useCom = orgManageList.size() + "";
        }
        //使用单位数
        map.put("useCom", useCom);


        //软件版本
        map.put("softVersion", softVersion);

        //数据库中的版本
        String dataversion = versionMapper.selectVer();

        map.put("dataversion", dataversion);

        // map.put("softVersionNO", softVersionNO);
        //操作系统
        map.put("operationSystem", getOperationSystem());

        //map.put("serverPath", serverPath);

        //jdk版本


        map.put("jdkVersion", getJdkVersion());
        //  map.put("machineCode", MachineUtil.get16Machine());
        //查询用户数
        int usercount = usersService.getUserCount();
        //允许登录用户数
        int canLoginUser = usersService.getCanLoginUser();
        int notLoginUser = usercount - canLoginUser;
        //用户情况
        map.put("userInfo", I18nUtils.getMessage("main.th.totalNumberOfUsersInfo1") + usercount + I18nUtils.getMessage("main.th.totalNumberOfUsersInfo2") + canLoginUser + I18nUtils.getMessage("main.th.totalNumberOfUsersInfo3") + notLoginUser + ")");


        map.put("reloadAuthorizationstr", reloadAuthorizationstr);


        return map;
    }

    /**
     * 获取授权信息加密串
     * @param pwd
     * @return
     */
    public static String newDec(String pwd) {
        String[] allPwd = pwd.split("\\@123456789qwertyuiopasdfghjklzxcvbnm,\\.-\\@");
        String nochinesePwd = allPwd[1];
        String noChineseMsg = null;

        try {
            noChineseMsg =DESUtils.myDecrypt(nochinesePwd, NEW_KEY2020);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return noChineseMsg;
    }


}
