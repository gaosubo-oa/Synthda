package com.xoa.service.users.impl;

import com.ibatis.common.resources.Resources;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.version.VersionMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.users.OrgManage;
import com.xoa.service.sys.SystemInfoService;
import com.xoa.service.users.OrgManageService;
import com.xoa.util.CodeUtil;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.dataSource.DataSourceInit;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.*;

/**
 * 创建作者: 韩成冰
 * 创建日期: 2017/5/22 14:12
 * 类介绍: 对Orgmanage操作
 * 构造参数: 无
 **/
@Transactional
@Service
public class OrgManageServiceImpl implements OrgManageService {
    @Resource
    private UnitManageMapper unitManageMapper;
    @Resource
    private OrgManageMapper orgManageMapper;
    @Resource
    private SystemInfoService systemInfoService;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private DataSourceInit dataSourceInit;

    @Resource
    private VersionMapper versionMapper;

    @Resource
    ThreadPoolTaskExecutor threadPoolTaskExecutor;

    @Override
    public ToJson<OrgManage> queryId(String locale) {
        ToJson<OrgManage> toJson = new ToJson<OrgManage>(0, "");
        List<OrgManage> org = orgManageMapper.queryId();
        if (org != null && org.size() > 0) {
            /* for (OrgManage orgManage:org){
                 if ("en_US".equals(locale)) {
                     orgManage.setName(orgManage.getEnName());
                 }
                 if ("zh_TW".equals(locale)) {
                     orgManage.setName(orgManage.getFtName());
                 }

             }*/
            //    if ()
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(org);

        } else {
            toJson.setFlag(1);
            toJson.setMsg("err");

        }

        return toJson;
    }

    /**
     * @param locale
     * @return
     */

    public ToJson<OrgManage> queryId2(String locale, String serverName) {
        ToJson<OrgManage> toJson = new ToJson<OrgManage>(0, "");
        List<OrgManage> org = orgManageMapper.queryId();
        List<OrgManage> orgs = new ArrayList<>();
        SysPara sysParaCloudOa = sysParaMapper.querySysPara("CLOUD_OA");
        if (org != null && org.size() > 0) {

            if ("oa.8oa.cn".equals(serverName)) {
                for (OrgManage orgManage : org) {
                    if ("1001".equals(orgManage.getOid() + "")) {
                        orgs.add(orgManage);
                    }
                }
            } else if (sysParaCloudOa!=null) {
                String s = null;
                int a = 0;
                String[] split = serverName.split("\\.");
                s = split[0];
                if (s.length() == 4) {
                    a = Integer.parseInt(s);
                }
                for (OrgManage orgManage : org) {
                    if (a == orgManage.getOid()) {
                        orgs.add(orgManage);
                    }
                }
            } else {
                for (OrgManage orgManage : org) {
                    orgs.add(orgManage);
                }
            }
            toJson.setCode(CodeUtil.getCode(orgs.get(0).getOid()));
            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObj(orgs);

        } else {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }

        return toJson;
    }



    /**
     * 创建作者:  韩成冰
     * 创建日期:  2017/5/22 14:14
     * 函数介绍:  获取所有OrgManage
     * 参数说明:  无
     *
     * @return: List<OrgManage>(OrgManage 的List集合)
     **/
    @Override
    public List<OrgManage> getOrgManage() {

        List<OrgManage> orgManageList = orgManageMapper.getOrgManage();
        return orgManageList;
    }

    /**
     * 创建作者:  韩成冰
     * 创建日期:  2017/5/22 14:15
     * 函数介绍:  根据oid查询某个OrgManage
     * 参数说明:  @param
     *
     * @return: OrgManage
     **/
    @Override
    public OrgManage getOrgManageById(Integer oid) {

        return orgManageMapper.getOrgManageById(oid);
    }

    /**
     * 创建作者:  韩成冰
     * 创建日期:  2017/5/22 14:17
     * 函数介绍:  修改某个OrgManage
     * 参数说明:  @param OrgManage对象
     *
     * @return: void
     **/
    @Override
    public void editOrgManage(OrgManage orgManage, HttpServletRequest request) {

        int a = orgManageMapper.editOrgManage(orgManage);
        if (a > 0) {
            Map<String, String> stringStringMap = systemInfoService.getAuthorization(request);
            if ("true".equals(stringStringMap.get("isAuthStr"))) {//如果授权成功，则去获取授权文件的信息
                int a1 = unitManageMapper.updateUnit("xoa" + orgManage.getOid(), orgManage.getName(), 1);
            }

        }


    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/24 18:50
     * @函数介绍: 添加分公司
     * @参数说明: @param orgManage
     * @return: void
     **/
    @Override
    public ToJson<OrgManage> addOrgManage(OrgManage orgManage, HttpServletRequest request) {
        ToJson<OrgManage> toJson = new ToJson<OrgManage>();
        int i = systemInfoService.getOrgManage(request);
        List<OrgManage> orgManageList = orgManageMapper.getOrgManage();
        if (orgManageList.size() < i) {
            orgManageMapper.addOrgManage(orgManage);
            dataSourceInit.init();
            toJson.setFlag(0);
            toJson.setMsg("ok");
        } else {
            toJson.setFlag(1);
            toJson.setMsg("err");
        }
        return toJson;
    }

    @Override
    public BaseWrapper checkOrgManage(HttpServletRequest request) {
        BaseWrapper wrapper = new BaseWrapper();
        wrapper.setFlag(false);
        wrapper.setCode("-1");
        wrapper.setMsg("默认调用失败");
        int i = systemInfoService.getOrgManage(request);
        List<OrgManage> orgManageList = orgManageMapper.getOrgManage();
        if (orgManageList == null) {
            wrapper.setFlag(true);
            wrapper.setCode("-11111");
            wrapper.setMsg("没有企业信息");
            return wrapper;
        }
        if (orgManageList.size() >= i) {
            wrapper.setFlag(false);
            wrapper.setCode("8001");
            wrapper.setMsg("企业数达到注册上线，如需增加请联系厂商。");
            return wrapper;
        } else {
            wrapper.setFlag(true);
            wrapper.setCode("8002");
            wrapper.setMsg("可以新增企业。");
            return wrapper;
        }

    }

    @Override
    public ToJson<OrgManage> selOrgManageIsOrg() {
        ToJson<OrgManage> json = new ToJson<OrgManage>();
        List<OrgManage> orgManages = orgManageMapper.selOrgManageIsOrg();
        json.setObj(orgManages);
        json.setFlag(0);
        return json;
    }

    @Override
    public ToJson<OrgManage> selFirstOrg() {
        ToJson<OrgManage> json = new ToJson<OrgManage>();
        OrgManage orgManage = orgManageMapper.selFirstOrg();
        json.setObject(orgManage);
        json.setFlag(0);
        return json;
    }


    /**
     * 根据代理商ID和查询接口密钥查询代理下组织
     * @param request
     * @param agentId 代理商ID
     * @param secretKey 密钥
     * @return
     */
    @Override
    public BaseWrapper queryAgentOrg(HttpServletRequest request, String agentId, String secretKey) {
        BaseWrapper wrapper = new BaseWrapper();
        try {
            ContextHolder.setConsumerType("xoa1001");
            SysPara sysPara = sysParaMapper.selectSysPara("xoa1001","YUNOA_MANAGE_SECRETKEY");
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue()) || !secretKey.equals(sysPara.getParaValue())){
                wrapper.setMsg("未查询到密钥或密钥错误");
                return wrapper;
            }

            List<OrgManage> orgManageByAgentId = new ArrayList<>();
            if("admin".equals(agentId)){
                orgManageByAgentId = orgManageMapper.queryAll();
            }else {
                orgManageByAgentId = orgManageMapper.getOrgManageByAgentId(Integer.valueOf(agentId));
            }

            wrapper.setObj(orgManageByAgentId);
            wrapper.setTrue();
        }catch (Exception e){
            e.printStackTrace();
        }
        return wrapper;
    }


    /**
     * 创建组织
     * @param version      版本信息
     * @param isOrg        是否组织
     * @param enName       英文
     * @param ftName       繁体
     * @param jpName       日文
     * @param krName       韩文
     * @param registTime   开始时间
     * @param endTime      结束时间
     * @param remindTime   提醒时间
     * @param licenseUsers 授权用户数
     * @param licenseSpace 授权存储空间G
     * @param name         单位名称
     * @param agentId      代理商ID
     * @param secretKey    密钥
     * @return
     */
    @Override
    public Integer createAgentOrg(HttpServletRequest request, String version, String isOrg, String enName, String ftName, String jpName, String krName, String registTime, String endTime, String remindTime, Integer licenseUsers, Integer licenseSpace, String name, Integer agentId, String secretKey) {
        try {
            ContextHolder.setConsumerType("xoa1001");
            SysPara sysPara = sysParaMapper.selectSysPara("xoa1001","YUNOA_MANAGE_SECRETKEY");
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue()) || !secretKey.equals(sysPara.getParaValue())){
                L.e("未查询到密钥或密钥错误");
                return 0;
            }

            OrgManage orgManage = new OrgManage();
            orgManage.setEnName(enName);
            orgManage.setFtName(ftName);
            orgManage.setJpName(jpName);
            orgManage.setKrName(krName);
            orgManage.setVersion(versionMapper.selectVer());
            orgManage.setIsOrg(isOrg);
            orgManage.setName(name);
            orgManage.setAgentId(agentId);
            orgManage.setRemindTime(remindTime);
            orgManage.setEndTime(endTime);
            orgManage.setRegistTime(registTime);
            orgManage.setLicenseSpace(licenseSpace);
            orgManage.setLicenseUsers(licenseUsers);
            orgManage.setUsedUsers(10);

            int selective = orgManageMapper.insertSelective(orgManage);
            this.threadPoolTaskExecutor.execute(new Runnable() {
                @Override
                public void run() {
                    //执行创建新组织脚本
                    try {
                        createDBByMysql(orgManage.getOid());
                        dataSourceInit.init();
                        //修改单位名称
                        unitManageMapper.updateUnit("xoa" + orgManage.getOid(), name, 1);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            });
            return 1;
        }catch (Exception e){
            L.e("OrgManageServiceImpl.createAgentOrg" + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Integer updateAgentOrg(HttpServletRequest request, String endTime, String remindTime, Integer licenseUsers, Integer licenseSpace, Integer oid, String secretKey) {
        try {
            ContextHolder.setConsumerType("xoa1001");
            SysPara sysPara = sysParaMapper.selectSysPara("xoa1001","YUNOA_MANAGE_SECRETKEY");
            if(Objects.isNull(sysPara) || StringUtils.checkNull(sysPara.getParaValue()) || !secretKey.equals(sysPara.getParaValue())){
                L.e("未查询到密钥或密钥错误");
                return 0;
            }
            OrgManage orgManage = new OrgManage();
            orgManage.setRemindTime(remindTime);
            orgManage.setEndTime(endTime);
            orgManage.setLicenseSpace(licenseSpace);
            orgManage.setLicenseUsers(licenseUsers);
            orgManage.setOid(oid);
            return orgManageMapper.editOrgManage(orgManage);
        }catch (Exception e){
            L.e("OrgManageServiceImpl.createAgentOrg" + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }


    public Boolean createDBByMysql(Integer oid) throws Exception {

        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
        String url = props.getProperty("url" + oid);
        if(StringUtils.checkNull(url)){
            throw new RuntimeException(oid + "配置缺失");
        }

        String driver = props.getProperty("driverClassName");
        String username = props.getProperty("uname" + oid);
        String password = props.getProperty("password" + oid);
        Class.forName(driver).newInstance();

        // 链接数据库
        Connection dbConn = null;
        Connection tableConn = null;

        try {
            Class.forName(driver);

            // 建库语句
            String dbName = "xoa" + oid;
            String databaseSql = "create database " + dbName + " CHARACTER SET utf8 COLLATE utf8_general_ci";
            dbConn = DriverManager.getConnection(url.split(dbName)[0], username, password);
            // 用于执行静态SQL语句并返回其产生的结果的对象
            Statement smt = dbConn.createStatement();
            // 执行建库语句
            smt.executeUpdate(databaseSql);

            //执行建表语句
            tableConn = DriverManager.getConnection(url, username, password);
            ScriptRunner runner = new ScriptRunner(tableConn);
            //下面配置不要随意更改，否则会出现各种问题
            runner.setAutoCommit(true); //自动提交
            runner.setFullLineDelimiter(false);
            runner.setDelimiter(";"); //每条命令间的分隔符
            runner.setSendFullScript(true); //方式一：true则获取整个脚本并执行； 方式二：false则按照自定义的分隔符每行执行
            /*
             * setStopOnError参数作用：遇见错误是否停止；
             * （1）false，遇见错误不会停止，会继续执行，会打印异常信息，并不会抛出异常，当前方法无法捕捉异常无法进行回滚操作，
             * 无法保证在一个事务内执行；
             * （2）true，遇见错误会停止执行，打印并抛出异常，捕捉异常，并进行回滚，保证在一个事务内执行；
             */
            runner.setStopOnError(true);
            String createTableSqlPath = this.getClass().getClassLoader().getResource(".").getPath() + System.getProperty("file.separator")
                    + "config" + System.getProperty("file.separator") + "org" + System.getProperty("file.separator") + "createOrg.sql";
            StringBuilder logPath = FileUploadUtil.getUploadHead().append(System.getProperty("file.separator")).
                    append("xoa").append(oid).append(System.getProperty("file.separator")).
                    append("createDBLog").append(System.getProperty("file.separator")).
                    append("err-xoa").append(oid).append(".txt");
            File logFile = new File(logPath.toString());
            if(!logFile.getParentFile().exists()){
                logFile.getParentFile().mkdirs();
            }
            //设置是否输出日志
            runner.setErrorLogWriter(new PrintWriter(logPath.toString()));
            // 执行sql文件
            runner.runScript(new InputStreamReader(new FileInputStream(createTableSqlPath), "utf-8"));

            if(logFile.length()>0){
                return false;
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (dbConn != null) {
                dbConn.close();
            }
            if (tableConn != null) {
                tableConn.close();
            }
        }
        return true;
    }
}
