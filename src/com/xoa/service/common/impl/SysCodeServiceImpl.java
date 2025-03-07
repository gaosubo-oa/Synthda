package com.xoa.service.common.impl;

import com.ibatis.common.jdbc.ScriptRunner;
import com.ibatis.common.resources.Resources;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.strstatus.StrstatusMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.version.VersionMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.strstatus.Strstatus;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.common.SysCodeService;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.users.OrgManageService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DBPropertiesUtils;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.Verification;
import com.xoa.util.ipUtil.MachineCode;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   王曰岐
 * 创建日期:   2017-5-2 下午2:40:05
 * 类介绍  :    系统代码日志表
 * 构造参数:
 */
@Service
public class SysCodeServiceImpl implements SysCodeService {

    @Resource
    private OrgManageService orgManageService;
    @Resource
    private VersionMapper versionMapper;
    @Resource
    private StrstatusMapper strstatusMapper;

    @Resource
    SysParaMapper sysParaMapper;

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/22 18：10
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param SysCode
     * @参数说明: @param oldCodeNo 未修改时的oid
     * @return: boolean  true表示已经存在，false表示可以使用
     */
    @Override
    @Transactional
    public ToJson editisCodeNoExits(SysCode sysCode, String oldCodeNo) {
        ToJson toJson = new ToJson(1, "error");
        try {
            List<SysCode> sysCodesList;

            //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
            if (sysCode != null && ("".equals(sysCode.getParentNo()) || sysCode.getParentNo() == null)) {
                sysCodesList = sysCodeMapper.isSysCodeNoExits(sysCode);
            } else {
                if (sysCode != null) {
                    if (sysCode.getParentNo().equals("NOTIFY")) {
                        String singleNewsArr = sysParaMapper.selectNotifySingleNew();
                        if (singleNewsArr.contains(oldCodeNo + "-")) {
                            int oldPos = singleNewsArr.indexOf(oldCodeNo + "-");
                            String headStr = singleNewsArr.substring(0, oldPos);
                            String bodyStr = singleNewsArr.substring(oldPos, singleNewsArr.length());
                            int bodyStartPos = bodyStr.indexOf(",");
                            String tailStr = bodyStr.substring(bodyStartPos + 1, bodyStr.length());
                            singleNewsArr = headStr.concat(tailStr);
                        }
                        String newSysPara = singleNewsArr.concat(sysCode.getCodeNo() + "-0,");
                        SysPara sysPara = new SysPara();
                        sysPara.setParaName("NOTIFY_AUDITING_SINGLE_NEW");
                        sysPara.setParaValue(newSysPara);
                        sysParaMapper.updateSysPara(sysPara);
                    }
                }
                sysCodesList = sysCodeMapper.isChildCodeNoExits(sysCode);
            }

            if (sysCodesList != null && sysCodesList.size() == 1) {
                if (oldCodeNo != null) {

                    String dbCodeNo = sysCodesList.get(0).getCodeNo();

                    if (oldCodeNo.equals(dbCodeNo)) {
                        toJson.setFlag(1);
                        toJson.setMsg("ok");
                        return toJson;
                    }

                }
            }

            if (sysCodesList != null && sysCodesList.size() >= 1) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
            L.e("SysCodeServiceImpleditisCodeNoExits：" + e);
        }

        //该CODE_NO号已经被用了

        return toJson;
    }

    @Resource
    private SysCodeMapper sysCodeMapper;
    @Resource
    private OrgManageMapper orgManageMapper;
    @Resource
    private SecurityContentApprovalService securityContentApprovalService;

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-5-2 下午2:40:40
     * 方法介绍:   根据代码主分类查找信息
     * 参数说明:   @param parentNo
     * 参数说明:   @return
     *
     * @return SysCode
     */
    @Override
    public ToJson<SysCode> getSysCode(HttpServletRequest request, String parentNo, String codeName) {
        ToJson<SysCode> codeJson = new ToJson<SysCode>();
        try {
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            Map<String,Object> map = new HashMap<>();
            map.put("parentNo",parentNo);
            map.put("codeName",codeName);

            List<SysCode> code = sysCodeMapper.getCodesByMap(map);
            if (!CollectionUtils.isEmpty(code)) {
                for (SysCode sysCode : code) {
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName(sysCode.getCodeName());
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName(sysCode.getCodeName1());
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName(sysCode.getCodeName2());
                    }
                }
            }

            codeJson.setObj(code);
            codeJson.setFlag(0);
            codeJson.setMsg("ok");
        } catch (Exception e) {
            codeJson.setFlag(1);
            codeJson.setMsg("err");
        }
        return codeJson;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月3日 下午4:50:09
     * 方法介绍:   获取所有系统代码
     * 参数说明:   @return
     *
     * @return List<SysCode>
     */
    @Override
    public List<SysCode> getAllSysCode() {
        List<SysCode> list = sysCodeMapper.getAllSysCode();
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 上午10:06:41
     * 方法介绍:   更新系统代码设置表
     * 参数说明:   @param sysCode 系统代码设置表
     *
     * @return void 无
     */
    @Override
    public void update(SysCode sysCode) {


     /*   Boolean codeNoExits = isCodeNoExits(sysCode);
        Boolean codeOrderExits = isCodeOrderExits(sysCode);
        if (!codeNoExits && !codeOrderExits) {*/
/*
          if(sysCode.getParentNo()==""){
               if(!isCodeNoExits(sysCode)){
                   sysCodeMapper.update(sysCode);
               }
           }
           else{
               if(!ChildisCodeNoExits(sysCode)){
                   sysCodeMapper.update(sysCode);
               }
           }*/
        sysCodeMapper.update(sysCode);
    }


    //}

    @Override
    public List<SysCode> getLogType() {
        String[] type = {"登录日志", "登录密码错误", "退出系统", "添加部门", "编辑部门", "删除部门", "添加用户",
                "编辑用户", "删除用户", "错误用户名", "admin清空密码", "修改登录密码", "公共文件柜", "用户批量设置",
                "编辑角色与权限", "删除角色与权限","手机短信重置密码",
                "公告通知管理","用餐管理","项目申报","单项评选","综合评选","会议申请","日程安排"};
        List<String> strings = Arrays.asList(type);
        List<SysCode> sysCodeList = sysCodeMapper.getLogType("PARENT_NO");
        Iterator<SysCode> it = sysCodeList.iterator();
        while (it.hasNext()) {
            SysCode sysCode = it.next();
            if (strings.contains(sysCode.getCodeName())) {
                continue;
            }
            it.remove();
        }
        return sysCodeList;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/31 16:49
     * @函数介绍: 根据日志的NO, 查询日志TYPENa
     * @参数说明: @param String
     * @参数说明:param codeNo
     * @return: String
     */
    @Override
    public String getLogNameByNo(String codeNo) {
        String logTypeName = sysCodeMapper.getLogNameByNo(codeNo);

        return logTypeName;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 13:25
     * @函数介绍: 删除日志
     * @参数说明: @param SysCode sysCode
     * @return: void
     */
    @Override
    public void deleteSysCode(SysCode sysCode) {
        //判断一下是不是主代码
        String codeByCodeId = sysCodeMapper.getCodeByCodeId(sysCode.getCodeId());
        //主代码parent_No为“”
        if ("".equals(codeByCodeId)) {
            sysCodeMapper.delete(sysCode);
        } else {
            sysCodeMapper.deleteChild(sysCode);
        }
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 13:41
     * @函数介绍: 增加代码主分类
     * @参数说明: @param SysCode
     * @return: void
     */
    @Override
    public void addSysMainCode(SysCode sysCode) {

      /*  //sysCode的ext属性不为空
        if (sysCode != null && !codeNoExits) {
            //这个多语言字段不用，数据库不能为空，所以赋值为“”*/
        sysCode.setCodeExt("");
        sysCodeMapper.addSysMainCode(sysCode);


    }

    /**
     * @param sysCode
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:16
     * @函数介绍: 判断系统代码排序是否存在
     * @参数说明: @param SysCOde
     * @return: Boolean
     */
    @Override
    public Boolean isCodeOrderExits(SysCode sysCode) {
        List<SysCode> sysCodesList;
        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (sysCode != null && ("".equals(sysCode.getParentNo()) || sysCode.getParentNo() == null)) {
            sysCodesList = sysCodeMapper.isSysCodeOrderExits(sysCode);
        } else {
            sysCodesList = sysCodeMapper.isChildCodeOrderExits(sysCode);

        }

        //该排序号已经被用了
        if (sysCodesList != null && sysCodesList.size() > 0) {
            return true;

        }
        return false;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:31
     * @函数介绍: 判断系统代码CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     */
    @Override
    public Boolean isCodeNoExits(SysCode sysCode) {
        List<SysCode> sysCodesList;

        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (sysCode != null && ("".equals(sysCode.getParentNo()) || sysCode.getParentNo() == null)) {
            sysCodesList = sysCodeMapper.isSysCodeNoExits(sysCode);
          /*  if (sysCodesList != null && sysCodesList.size() == 1) {
                if (sysCodesList.get(0).getParentNo() != null &&
                        !sysCodesList.get(0).getParentNo().equals(sysCode.getCodeNo())) {
                    return true;
                } else {
                    return false;
                }
            }*/

        } else {
            sysCodesList = sysCodeMapper.isChildCodeNoExits(sysCode);

        }
        //该CODE_NO号已经被用了
        if (sysCodesList != null && sysCodesList.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/27 20:36
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     */
    @Override
    public Boolean iseditCodeNoExits(SysCode sysCode) {
        List<SysCode> sysCodesList;

        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (sysCode != null && ("".equals(sysCode.getParentNo()) || sysCode.getParentNo() == null)) {
            sysCodesList = sysCodeMapper.iseditSysCodeNoExits(sysCode);
            if (sysCodesList != null && sysCodesList.size() == 1) {
                if (sysCodesList.get(0).getParentNo() != null &&
                        !sysCodesList.get(0).getParentNo().equals(sysCode.getCodeNo())) {
                    return true;
                } else {
                    return false;
                }
            }

        } else {
            sysCodesList = sysCodeMapper.isChildCodeNoExits(sysCode);

        }
        //该CODE_NO号已经被用了
        if (sysCodesList != null && sysCodesList.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 11:09
     * @函数介绍: 判断系统子代码CODE_NO是否存在
     * @参数说明: @param SysCode
     * @return: boolean
     */
    @Override
    public Boolean ChildisCodeNoExits(SysCode sysCode) {
        boolean flag;
        List<SysCode> childCodeNoExits = sysCodeMapper.isChildCodeNoExits(sysCode);
        if (childCodeNoExits != null && childCodeNoExits.size() > 0) {
            flag = true;
        } else {
            flag = false;
        }
        return flag;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:41
     * @函数介绍: 增加子代码
     * @参数说明: @param SysCode
     * @return: void
     */
    @Override
    public void addChildSysCode(SysCode sysCode) {
        //判断代码是否重复
        Boolean codeNoExits = isCodeNoExits(sysCode);
        //排序可重复
        Boolean codeOrderExits = false;
//        Boolean codeOrderExits = isCodeOrderExits(sysCode);
        if (sysCode != null) {
            if (sysCode.getParentNo().equals("NOTIFY")) {
                String singleNewsArr = sysParaMapper.selectNotifySingleNew();
                String newSysPara = singleNewsArr.concat(sysCode.getCodeNo() + "-0,");
                SysPara sysPara = new SysPara();
                sysPara.setParaName("NOTIFY_AUDITING_SINGLE_NEW");
                sysPara.setParaValue(newSysPara);
                sysParaMapper.updateSysPara(sysPara);
            }
        }
        //sysCode的ext属性不为空
        if (sysCode != null && sysCode.getParentNo() != null && !codeNoExits && !codeOrderExits) {
            //这个多语言字段不用，数据库不能为空，所以赋值为“”
            sysCode.setCodeExt("");
            sysCode.setCodeFlag("1");
            sysCodeMapper.addSysChildCode(sysCode);
        }
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:45
     * @函数介绍: 查询子代码
     * @参数说明: @param SysCode
     * @return: List<SysCode></SysCode>
     */
    @Override
    public List<SysCode> getChildSysCode(SysCode sysCode) {

        if (sysCode != null && sysCode.getParentNo() != null) {
            return sysCodeMapper.getSysCode(sysCode.getParentNo());
        }

        return null;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 14:45
     * @函数介绍: 查询系统编码相同的对象
     * @参数说明: @param SysCode
     * @return: List<SysCode></SysCode>
     **/

    @Override
    public SysCode getCodeByCodeNo(SysCode sysCode) {
        return sysCodeMapper.getCodeByCodeNo(sysCode);
    }

    @Override
    public ToJson<List<SysCode>> getErrSysCode() {
        //声明一个空list存放正确的系统代码 主类和子类
        List<SysCode> list = new ArrayList<SysCode>();
        //声明一个空的list来存放错误代码
        List<SysCode> errlist = new ArrayList<SysCode>();
        ToJson<List<SysCode>> json = new ToJson<List<SysCode>>();

        try {
            //查询出所有的主代码
            List<SysCode> mainCode = sysCodeMapper.getMainCode();
            //遍历主代码得到子代码
            for (SysCode sysCode : mainCode) {
                list.add(sysCode);
                List<SysCode> childCode = sysCodeMapper.getChildCode(sysCode.getCodeNo());
                //遍历子代码
                for (SysCode sysCode1 : childCode) {
                    list.add(sysCode1);
                }
            }

            StringBuffer sb = new StringBuffer();
            //得到数据库所有代码
            List<SysCode> allCode = sysCodeMapper.getAllCode();
            for (SysCode sysCode : list) {
                Integer codeId = sysCode.getCodeId();
                sb.append(",").append(codeId).append(",");
            }

            for (int i = 0; i < allCode.size(); i++) {
                Integer id = allCode.get(i).getCodeId();
                if (!sb.toString().contains("," + id + ",")) {
                    errlist.add(allCode.get(i));
                }
            }

            /* if (errlist != null) {*/
            json.setObject(errlist);
            json.setFlag(0);
            json.setMsg("ok");
/*            } else {
                json.setObject(null);
                json.setFlag(1);
                json.setMsg("No");
            }*/
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-7-4 下午13：28
     * 方法介绍:   系统代码恢复
     *
     * @return json
     */
    @Override
    public ToJson<Object> recoverCode(HttpServletRequest request, String path) {
        //通过session获取到数据库名字
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        ToJson<Object> json = new ToJson<Object>();
        String username = DBPropertiesUtils.getDbMsg(request).get("username");//用户名
        String password = DBPropertiesUtils.getDbMsg(request).get("password");//密码
        String host = DBPropertiesUtils.getDbMsg(request).get("ip");//导入的目标数据库所在的主机
        // String importDatabaseName = "xoa1001";//导入的目标数据库的名称
        //第一步，获取登录命令语句
        //获取项目项目路径
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String Topath = realPath + "\\ui\\lib";
        String loginCommand = new StringBuffer().append("/usr/share/mysql/bin/mysql -u").append(username).append(" -p").append(password).append(" -h").append(host).toString();
        //第二步，获取切换数据库到目标数据库的命令语句
        String switchCommand = new StringBuffer("use ").append(sqlType).toString();
        //第三步，设置编码格式。
        String charsetCommand = new StringBuffer("set names utf8;").toString();
        //第四步，获取导入的命令语句
        String importCommand = new StringBuffer("source ").append(path).toString();
        //需要返回的命令语句数组
        String[] commands = new String[]{loginCommand, switchCommand, charsetCommand, importCommand};
        try {
            Runtime runtime = Runtime.getRuntime();
            Process process = runtime.exec(commands[0]);
            //执行了第一条命令以后已经登录到mysql了，所以之后就是利用mysql的命令窗口
            //进程执行后面的代码
            OutputStream os = process.getOutputStream();
            OutputStreamWriter writer = new OutputStreamWriter(os);
            //执行命令行
            writer.write(commands[1] + "\r\n");
            Thread.sleep(300);
            writer.write(commands[2] + "\r\n");
            Thread.sleep(300);
            writer.write(commands[3]);
            Thread.sleep(300);
            json.setFlag(0);
            json.setMsg("ok");
            writer.flush();
            writer.close();
            os.close();
        } catch (IOException e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            try {
                //删除上传的暂存sql
                File file = new File(path);
                file.delete();
            } catch (Exception e) {

            }

        }

        return json;
    }

    /**
     * 创建作者:   高亚峰
     * 创建日期:   2017-7-4 上午11：28
     * 方法介绍:   系统代码备份
     *
     * @return json
     */
    @Override
    public void exportCode(HttpServletRequest request, HttpServletResponse response) {
        ResourceBundle rb = ResourceBundle.getBundle("jdbc-sql");
        //通过session获取到数据库名字
        String sqlType = "xoa"
                + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        //获取项目项目路径
        String realPath = request.getSession().getServletContext().getRealPath("/");
        String username = DBPropertiesUtils.getDbMsg(request).get("username");//用户名
        String password = DBPropertiesUtils.getDbMsg(request).get("password");//密码
        String host = DBPropertiesUtils.getDbMsg(request).get("ip");//导入的目标数据库所在的主机
        String tablename = "sys_code";//表名
        String exportPath = realPath;//导出路径
        String fileName = "sys_code.sql";
        String path = exportPath + "\\ui\\lib";
        String[] command = new String[]{"/bin/sh ", "-c ", "/usr/bin/mysqldump" + " -h" + host + " -u" + username + " -p" + password, sqlType + " " + tablename + " -r" + exportPath};
        try {
            Process runtimeProcess = Runtime.getRuntime().exec(command);
            int processComplete = runtimeProcess.waitFor();
            File file = new File(exportPath + fileName);
            Thread.sleep(300);
            if (file.exists()) {
                response.setContentType("multipart/form-data");
                ;// 设置强制下载不打开
                response.addHeader("Content-Disposition",
                        "attachment;fileName=" + fileName);// 设置文件名
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                } catch (Exception e) {
                    // TODO: handle exception
                    e.printStackTrace();
                }
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                Thread.sleep(300);
                File file1 = new File(exportPath + fileName);
                Thread.sleep(300);
                if (file1.exists()) {
                    file1.delete();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public ToJson<SysCode> getErrInfo(String CodeId) {
        ToJson<SysCode> json = new ToJson<SysCode>();
        try {
            if (CodeId != null) {
                SysCode codeByCodeId = sysCodeMapper.getCodeByCodeIds(Integer.valueOf(CodeId));
                json.setObject(codeByCodeId);
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson<SysCode> deleteErrCode(String CodeId) {
        ToJson<SysCode> json = new ToJson<SysCode>();
        if (CodeId != null) {
            try {
                sysCodeMapper.deleteErrCode(Integer.valueOf(CodeId));
                json.setFlag(0);
                json.setMsg("ok");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                json.setFlag(1);
                json.setMsg("err");
            }
        }
        return json;
    }

    @Override
    public ToJson<List<SysCode>> getAllCode() {
        ToJson<List<SysCode>> json = new ToJson<List<SysCode>>();
        List<SysCode> list = new ArrayList<SysCode>();
        try {
            //查询出所有的主代码
            List<SysCode> mainCode = sysCodeMapper.getMainCode();
            //遍历主代码得到子代码
            for (SysCode sysCode : mainCode) {
                list.add(sysCode);
            }
            json.setObject(list);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setObject(null);
            json.setMsg("err");
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public Map<String, Object> DropDownBoxs(HttpServletRequest request, String[] CodeId) {
        Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            for (String s : CodeId) {
                List<SysCode> sysCode = sysCodeMapper.getSysCode(s);
                if (locale.equals("en_US")) {
                    for (SysCode code : sysCode) {
                        code.setCodeName(code.getCodeName1());
                    }
                } else if (locale.equals("zh_TW")) {
                    for (SysCode code : sysCode) {
                        code.setCodeName(code.getCodeName2());
                    }
                }
                map.put(s, sysCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public void updatePUSHMHO() {
        SysPara sysPara = new SysPara();
        sysPara.setParaName("PUSH_MNO");
        try {
            ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
            List<OrgManage> obj = zh_cn.getObj();
            int size = obj.size();
            ResultSet rs = null;
            String jiqima = MachineCode.get16CharMacsType().get(0);
            for (int i = 0; i < size; i++) {
                Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
                String url = props.getProperty("url" + obj.get(i).getOid());

                String driver = props.getProperty("driverClassName");
                String username = props.getProperty("uname" + obj.get(i).getOid());
                String password = props.getProperty("password" + obj.get(i).getOid());
                Class.forName(driver).newInstance();
                Connection conn = (Connection) DriverManager.getConnection(url, username, password);

                String sql = " SELECT * " +
                        "      FROM sys_para" +
                        "      where PARA_NAME='PUSH_MNO' and PARA_VALUE is not null;";
                Statement st = conn.createStatement();
                rs = st.executeQuery(sql);//执行SQL语句
                if (rs.next()) {
                    //要跟数据库的列名一样
                    String paraValue = rs.getString("PARA_VALUE");
                    if (!"4CCC6A6247B84C66".equals(paraValue)) {
                        sql = "update sys_para set PARA_VALUE ='" + jiqima + "' where PARA_NAME = 'PUSH_MNO'";
                        st.executeUpdate(sql);//执行SQL语句
                    }

                } else {
                    sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('PUSH_MNO','" + jiqima + "');";
                    st.executeUpdate(sql);//执行SQL语句
                }
            }

        } catch (Exception e) {
            e.printStackTrace();

        }

    }


    @Override
    public ToJson<Object> updateDabase() {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        try {

            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/update/");
            File file = new File(webappRoot);
            //不存在择创建文件夹
            if (!file.exists()) {
                file.mkdir();
            }
            //如何webappRoot是一个目录择返回true
            if (file.isDirectory()) {
                String[] files = file.list();
                if (files.length > 0) {
                    for (int j = 0; j < files.length; j++) {
                        ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
                        List<OrgManage> obj = zh_cn.getObj();
                        int size = obj.size();
                        for (int i = 0; i < size; i++) {
                            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
                            String url = props.getProperty("url" + obj.get(i).getOid());
                            String driver = props.getProperty("driverClassName");
                            String username = props.getProperty("uname" + obj.get(i).getOid());
                            String password = props.getProperty("password" + obj.get(i).getOid());
                            Class.forName(driver).newInstance();
                            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
                            ScriptRunner runner = new ScriptRunner(conn, false, false);
                            runner.setErrorLogWriter(null);
                            runner.setLogWriter(null);
                            runner.runScript(new InputStreamReader(new FileInputStream(webappRoot + "/" + files[j]), "utf-8"));
                        }
                        json.setMsg("ok");
                        json.setFlag(0);
                    }
                } else {
                    json.setMsg("不存在更新文件");
                    json.setFlag(0);
                }
            }


        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> editDabase(HttpServletRequest request, HttpServletResponse response) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        String classpath = this.getClass().getResource("/").getPath();
        String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/update/");
        StringBuffer stringBuffer = new StringBuffer();
        String urltd_oa = new String();
        String unametd_oa = new String();
        String passwordtd_oa = new String();
        String proRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
        try {
            File file1 = new File(proRoot + "jdbc.txt");
            //判断文件是否存在
            if (file1.isFile() && file1.exists()) {

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file1));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i = 1;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    if (i == 1) {
                        urltd_oa = lineTxt;
                    } else if (i == 2) {
                        unametd_oa = lineTxt;
                    } else {
                        passwordtd_oa = lineTxt;
                    }
                    i++;
                }
                read.close();
            }

            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = urltd_oa;
            String driver = props.getProperty("driverClassName");
            String username = unametd_oa;
            String password = passwordtd_oa;
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            //先创建一个表用来记录数据库升级操作
            String crsql = "CREATE TABLE `str_status` (\n" +
                    "  `ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                    "  `CONTENT` varchar(255) DEFAULT NULL COMMENT '汉语表述',\n" +
                    "  `STATE` varchar(255) DEFAULT '0' COMMENT '成功0.错误1',\n" +
                    "  `STRING_SQL` text COMMENT 'SQL',\n" +
                    "  PRIMARY KEY (`ID`)\n" +
                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
            Statement st1 = conn.createStatement();
            st1.executeUpdate(crsql);//执行SQL语句
            File file = new File(webappRoot);
            if (file.isDirectory()) {
                String[] files = file.list();
                if (files.length > 0) {
                    for (int z = 0; z < files.length; z++) {
                        InputStream in = new FileInputStream(webappRoot + "/" + files[z]);
                        HSSFWorkbook excelObj = new HSSFWorkbook(in);
                        HSSFSheet sheetObj = excelObj.getSheetAt(0);
                        Row row = sheetObj.getRow(0);
                        int colNum = row.getPhysicalNumberOfCells();
                        int lastRowNum = sheetObj.getLastRowNum();
                        for (int i = 0; i <= lastRowNum; i++) {
                            row = sheetObj.getRow(i);
                            if (row != null) {
                                for (int j = 0; j < colNum; j++) {
                                    Cell cell = row.getCell(j);
                                    if (cell != null) {
                                        switch (j) {
                                            case 0:
                                                //sql语句
                                                try {
                                                    String sql = cell.getStringCellValue();
                                                    Statement st = conn.createStatement();
                                                    st1.executeUpdate(sql);//执行SQL语句
                                                    String s = sql.replaceAll("\'", "\"");
                                                    String sql_1 = "INSERT INTO `str_status` ( `CONTENT`, `STATE`, `STRING_SQL`) VALUES ( NULL, '0', '" + s + "');";
                                                    st1.executeUpdate(sql_1);//执行SQL语句
                                                    json.setMsg("ok");
                                                    json.setFlag(0);
                                                } catch (SQLException e) {
                                                    json.setMsg("err");
                                                    json.setFlag(1);
                                                    String sql = cell.getStringCellValue();
                                                    Statement st = conn.createStatement();
                                                    String s = sql.replaceAll("\'", "\"");
                                                    String sql_1 = "INSERT INTO `str_status` ( `CONTENT`, `STATE`, `STRING_SQL`) VALUES ( NULL, '1', '" + s + "');";
                                                    st.executeUpdate(sql_1);//执行SQL语句
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
      /*      String sql_2="select * from str_status where STATE =1";
            ResultSet rs = st1.executeQuery(sql_2);//执行SQL语句
            List<Strstatus> strstatus =new ArrayList<Strstatus>();
            Object object1 =new Object();
            Object object2 =new Object();
            while(rs.next()){
                Strstatus strstatus1 =new Strstatus();
                object1 = rs.getObject(1);
                object2 = rs.getObject(4);
                strstatus1.setId((int)object1);
                strstatus1.setStringSql(object2.toString());
                strstatus.add(strstatus1);
            }
            if(strstatus.size()>0){
                HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("异常sql语句", 9);
                String[] secondTitles = {"序号", "异常语句" };
                HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
                String[] beanProperty = {"id","stringSql"};
                HSSFWorkbook workbook = null;
                workbook = ExcelUtil.exportExcelData(workbook2, strstatus, beanProperty);
                OutputStream out = response.getOutputStream();
                String filename = "异常sql语句.xls";
                filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
                response.setContentType("application/vnd.ms-excel;charset=UTF-8");
                response.setHeader("content-disposition", "attachment;filename=" + filename);
                workbook.write(out);
                out.close();
            }*/
            //修改一下OrgMange表的OID
            OrgManage orgManage = new OrgManage();
            orgManage.setOid(1000);
            int i = orgManageMapper.editOid(orgManage);
            //最后修改一下版本号
            String sql = "UPDATE version SET VER= " + "'" + SystemInfoServiceImpl.softVersion + "'";
            st1.execute(sql);
            conn.close();
            st1.close();
            /* rs.close();*/
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson<Object> getObjects() {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        int count = 0;
        int total = 0;
        try {
            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");

            count = 0;
            total = 0;
            File file1 = new File(webappRoot + "jdbc.txt");
            String urltd_oa = new String();
            String unametd_oa = new String();
            String passwordtd_oa = new String();
            //判断文件是否存在
            if (file1.isFile() && file1.exists()) {

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file1));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i = 1;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    if (i == 1) {
                        urltd_oa = lineTxt;
                    } else if (i == 2) {
                        unametd_oa = lineTxt;
                    } else {
                        passwordtd_oa = lineTxt;
                    }
                    i++;
                }
                read.close();
            }
            String Root = classpath.replaceAll("WEB-INF/classes/", "ui/file/update/");
            File file = new File(Root);
            if (file.isDirectory()) {
                String[] files = file.list();
                if (files.length > 0) {
                    for (int z = 0; z < files.length; z++) {
                        try {
                            InputStream in = new FileInputStream(Root + "/" + files[z]);
                            HSSFWorkbook excelObj = null;
                            excelObj = new HSSFWorkbook(in);
                            HSSFSheet sheetObj = excelObj.getSheetAt(0);
                            Row row = sheetObj.getRow(0);
                            int colNum = row.getPhysicalNumberOfCells();
                            int lastRowNum = sheetObj.getLastRowNum();
                            //总数
                            count = lastRowNum + 1;
                            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
                            String url = urltd_oa;
                            String driver = props.getProperty("driverClassName");
                            String username = unametd_oa;
                            String password = passwordtd_oa;
                            Class.forName(driver).newInstance();
                            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
                            String sql = "SELECT  count(*) as count FROM  str_status";
                            Statement st = conn.createStatement();
                            ResultSet resultSet = st.executeQuery(sql);
                            //执行了多少条
                            if (resultSet.next()) {
                                total = Integer.valueOf(resultSet.getString(1));
                            }
                            conn.close();
                            st.close();

                        } catch (Exception e) {
                            json.setFlag(1);
                            json.setMsg(e.getMessage());
                            e.printStackTrace();
                        }

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> map = new HashedMap();
        map.put("count", count);
        map.put("total", total);
        json.setFlag(0);
        json.setObject(map);
        json.setMsg("ok");
        return json;
    }

    @Override
    public ToJson<Object> getObjectdetail() {
        ToJson<Object> json = new ToJson<Object>();
        List<Strstatus> correctList = new ArrayList<Strstatus>();
        List<Strstatus> errorList = new ArrayList<Strstatus>();
        try {
            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
            File file = new File(webappRoot + "jdbc.txt");
            String urltd_oa = new String();
            String unametd_oa = new String();
            String passwordtd_oa = new String();
            //判断文件是否存在
            if (file.isFile() && file.exists()) {

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i = 1;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    if (i == 1) {
                        urltd_oa = lineTxt;
                    } else if (i == 2) {
                        unametd_oa = lineTxt;
                    } else {
                        passwordtd_oa = lineTxt;
                    }
                    i++;
                }
                read.close();
            }
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = urltd_oa;
            String driver = props.getProperty("driverClassName");
            String username = unametd_oa;
            String password = passwordtd_oa;
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            String sql = "SELECT  * FROM  str_status where STATE =0";
            Statement st = conn.createStatement();
            ResultSet resultSet = st.executeQuery(sql);
            //执行了多少条
            while (resultSet.next()) {
                Strstatus strstatus = new Strstatus();
                strstatus.setId(Integer.valueOf(resultSet.getString(1)));
                strstatus.setContent(resultSet.getString(2));
                strstatus.setState(resultSet.getString(3));
                strstatus.setStringSql(resultSet.getString(4));
                correctList.add(strstatus);
            }

            String errsql = "SELECT  * FROM  str_status where STATE =1";
            ResultSet errorresultSet = st.executeQuery(errsql);
            while (errorresultSet.next()) {
                Strstatus strstatus = new Strstatus();
                strstatus.setId(Integer.valueOf(errorresultSet.getString(1)));
                strstatus.setContent(errorresultSet.getString(2));
                strstatus.setState(errorresultSet.getString(3));
                strstatus.setStringSql(errorresultSet.getString(4));
                errorList.add(strstatus);
            }
            errorresultSet.last();
            Map<String, Object> map = new HashedMap();
            map.put("errorList", errorList);
            map.put("correctList", correctList);
            json.setObject(map);
            json.setMsg("ok");
            json.setFlag(0);

        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }

    public List<OrgManage> queryId() {
        List<OrgManage> list = orgManageMapper.queryId();
        return list;
    }

    @Override
    public boolean isAppNewVersion(String webVersion, String dataVersion) {

        boolean flag = false;

        if (webVersion.equals(dataVersion)) {
            flag = false;
            return false;
        }
        if (dataVersion.equals("8.15.160722")) {
            flag = false;
            return false;
        }
        String[] webArray = webVersion.split("\\.");
        String[] dataArray = dataVersion.split("\\.");

        int length = webArray.length < dataArray.length ? webArray.length : dataArray.length;

        for (int i = 0; i < length; i++) {
            if (Integer.parseInt(dataArray[i]) < Integer.parseInt(webArray[i])) {
                flag = true;
                return true;
            } else if (Integer.parseInt(dataArray[i]) > Integer.parseInt(webArray[i])) {
                flag = false;
                return false;
            }
            // 相等 比较下一组值
        }

        return flag;
    }

    @Override
    public ToJson<Object> updateResource() {
        ToJson<Object> json = new ToJson<Object>(0, "ok");
        //读取项目的版本号
        Connection conn = null;
        try {

            this.updatePUSHMHO();
            String webVersion = SystemInfoServiceImpl.softVersion;
            //数据库中的版本
            String dataversion = versionMapper.selectVer();
            boolean flag = this.isAppNewVersion(webVersion, dataversion);
            //如果为true，则说明需要更新
            if (flag) {
                //遍历数据库
                ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
                List<OrgManage> obj = zh_cn.getObj();
                int size = obj.size();
                for (int i = 0; i < size; i++) {
                    //只做第一个数据库
                    if (i < size) {
                        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
                        Integer oid = obj.get(i).getOid();
                        String url = props.getProperty("url" + obj.get(i).getOid());

                        String driver = props.getProperty("driverClassName");
                        String username = props.getProperty("uname" + obj.get(i).getOid());
                        String password = props.getProperty("password" + obj.get(i).getOid());
                        Class.forName(driver).newInstance();
                        conn = (Connection) DriverManager.getConnection(url, username, password);


                        if (Integer.parseInt(dataversion.replaceAll("\\.", "")) <202009281) {

                            //以下是调用函数的规则
                            // Verification.CheckIsExistTable 验证表是否存在
                            // Verification.CheckIsExistfield 验证某表是否存在某字段
                            // Verification.CheckIsExistMenu 验证主菜单ID检查函数（SYS_MENU）
                            // Verification.CheckIsExistFunction 验证子菜单ID检查函数（SYS_FUNCTION）
                            // Verification.CheckIsExistIndex    检测某表索引函数
                            // Verification.CheckIsExistIndex    验证系统代码是否存在
                            // Verification.CheckIsExistParam  验证sysParm是否存在某列


                            //若添加字段请按照规则添加，注释添加者，每个人再添加相继顺序添加即可，
                            // 添加时代码中先调用验证函数，再把sql填入其中即可完成。
                            //最后修改数据库版本号为当前版本号

                            /*  *//**
                             *  添加者：高亚峰
                             *  添加日期：2018-1-12
                             *  添加字段的作用: 更新APP下载地址
                             */
                            boolean isExistPara_1 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_PC_DownUrl");
                            if (isExistPara_1 == true) {
                                String sql = "DELETE FROM sys_para where PARA_NAME = 'APP_PC_DownUrl';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('APP_PC_DownUrl', '/file/pc/ISXoa.exe');";
                                st.executeUpdate(sql);
                                //如果需要执行多个则用&&符判断
                            }



                            //添加字段
                            boolean sys_function261 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_function", "IS_SHOW_FUNC");
                            if (sys_function261 == false) {
                                String sql = "ALTER TABLE sys_function ADD IS_SHOW_FUNC int ( 10 ) DEFAULT '0'  comment '是否在移动端显示该二级菜单0.显示1.不显示';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "BRAND")) {
                                String sql = "ALTER TABLE `hr_staff_info` ADD `BRAND` VARCHAR ( 255 ) DEFAULT NULL COMMENT '品牌';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "CATEGORY")) {
                                String sql = "ALTER TABLE `hr_staff_info` ADD `CATEGORY` varchar(255) DEFAULT NULL COMMENT '品类';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }






                            /* *
                             *  作用:修改字段类型
                             */

                            boolean existInfoCenter25_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "BONUS_ID");
                            if (existInfoCenter25_1 == false) {
                                boolean existInfoCenter25 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "DATA_50");
                                if (existInfoCenter25 == true) {
                                    String sql = "alter table bonusmsg change DATA_50 BONUS_ID VARCHAR(255) DEFAULT NULL;";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }
                            /* *
                             *  作用: 修改字段类型
                             */

                            boolean existInfoCenter26_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "USER_ID");
                            if (existInfoCenter26_1 == false) {
                                boolean existInfoCenter26 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "DATA_51");
                                if (existInfoCenter26 == true) {
                                    String sql = "alter table bonusmsg change DATA_51 USER_ID VARCHAR(255) DEFAULT NULL;";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }
                            //添加字段
                            boolean userExtTable22 = Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "DATA_50");
                            if (userExtTable22 == false) {
                                String sql = " ALTER TABLE bonusmsg ADD DATA_50 VARCHAR(255) DEFAULT NULL;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段  (上传附件大小限制)
                            boolean userExtTable2_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_attach", "ATTACHMENT_ID");
                            if (userExtTable2_1 == true) {
                                String sql = "alter table flow_run_attach modify column ATTACHMENT_ID  VARCHAR(255);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*  2019-3-12 张丽军
                             *      创建表 cp_asset_type
                             */
                            boolean checkIsExistHr_dispatcher = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_dispatcher");
                            if (checkIsExistHr_dispatcher == false) {
                                String sql = "CREATE TABLE `hr_dispatcher`  (\n" +
                                        "  `DISPATCHER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `CREATER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',\n" +
                                        "  `CREATER_TIME` date NULL DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `USER_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人ID',\n" +
                                        "  `USER_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人姓名',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '被调度人部门ID',\n" +
                                        "  `DEPT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人部门名称',\n" +
                                        "  `JOB_POSITION_ID` int(11) NULL DEFAULT NULL COMMENT '被调度人职务ID',\n" +
                                        "  `JOB_POSITION_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人职务名称',\n" +
                                        "  `PROJECT_ID` int(11) NULL DEFAULT NULL COMMENT '被调度人项目ID',\n" +
                                        "  `PROJECT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人项目名称',\n" +
                                        "  `WORK_JOB_ID` int(11) NULL DEFAULT NULL COMMENT '被调度人岗位ID',\n" +
                                        "  `WORK_JOB_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人岗位名称',\n" +
                                        "  `LOCATION_ADDRESS_ID` int(11) NULL DEFAULT NULL COMMENT '被调度人所在位置ID',\n" +
                                        "  `LOCATION_ADDRESS_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被调度人所在位置名称',\n" +
                                        "  `ASSESSMENT` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '考核评价',\n" +
                                        "  `ASSESS_SCORE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考核分数',\n" +
                                        "  `UPDATE_TIME` date NULL DEFAULT NULL COMMENT '最后修改时间',\n" +
                                        "  PRIMARY KEY (`DISPATCHER_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人员调度历史记录表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    *
                             *  添加字段的作用: 添加默认事务提醒菜单
                             */
                            boolean isExistFunction_d = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5020");
                            if (isExistFunction_d == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('5020', 'z090', '事务提醒设置', NULL, NULL, NULL, NULL, NULL, '/smsSettings/remindindex', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**   2019-3-12
                             *  作用:添加字段
                             */
                            boolean isExistCode_ddd = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_code", "IS_CAN");
                            if (isExistCode_ddd == false) {
                                String sql = "ALTER TABLE sys_code ADD COLUMN `IS_CAN` VARCHAR(50) NOT NULL DEFAULT '1' COMMENT '是否允许事务提醒开关 （1-允许，0-不允许）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-12
                             *  作用:添加字段
                             */
                            boolean isExistCode_dad = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_code", "IS_IPHONE");
                            if (isExistCode_dad == false) {
                                String sql = "ALTER TABLE sys_code ADD COLUMN `IS_IPHONE` VARCHAR(50)  NOT NULL DEFAULT '1' COMMENT '手机短信默认提醒（1提醒0不提醒）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-3-12
                             *  作用:添加字段
                             */
                            boolean isExistCode_dsd = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_code", "IS_REMIND");
                            if (isExistCode_dsd == false) {
                                String sql = "ALTER TABLE sys_code ADD COLUMN `IS_REMIND` VARCHAR(50)  CHARACTER SET utf8mb4 NOT NULL DEFAULT '1' COMMENT '事务提醒开关 （1-开，0-关）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "OTHER_DEPT");
                            if (isExistCp_asset_reflect1 == false) {
                                String sql = "ALTER TABLE cp_asset_reflect ADD COLUMN OTHER_DEPT VARCHAR(255) CHARACTER SET utf8 COMMENT '其他部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "BAR_CODE");
                            if (isExistCp_asset_reflect2 == false) {
                                String sql = " ALTER TABLE cp_asset_reflect ADD COLUMN BAR_CODE VARCHAR(255) CHARACTER SET utf8 COMMENT '条形码';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "CAPITAL_LEVEL");
                            if (isExistCp_asset_reflect3 == false) {
                                String sql = "ALTER TABLE cp_asset_reflect ADD COLUMN CAPITAL_LEVEL VARCHAR(255) CHARACTER SET utf8 COMMENT '资产等级';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "MANU_FACTURER");
                            if (isExistCp_asset_reflect4 == false) {
                                String sql = "ALTER TABLE cp_asset_reflect ADD COLUMN MANU_FACTURER VARCHAR(255) CHARACTER SET utf8 COMMENT '制造厂商';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "MANU_DATE");
                            if (isExistCp_asset_reflect5 == false) {
                                String sql = "ALTER TABLE cp_asset_reflect ADD COLUMN MANU_DATE VARCHAR(255) CHARACTER SET utf8 COMMENT '出厂日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "UNIT_ID");
                            if (isExistCp_asset_reflect6 == false) {
                                String sql = " ALTER TABLE cp_asset_reflect ADD COLUMN UNIT_ID VARCHAR(255) CHARACTER SET utf8 COMMENT '计量单位';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "FNAMARK");
                            if (isExistCp_asset_reflect7 == false) {
                                String sql = " ALTER TABLE cp_asset_reflect ADD COLUMN FNAMARK VARCHAR(255) CHARACTER SET utf8 COMMENT '财务编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "ALERT_NUM");
                            if (isExistCp_asset_reflect8 == false) {
                                String sql = " ALTER TABLE cp_asset_reflect ADD COLUMN ALERT_NUM VARCHAR(255) CHARACTER SET utf8 COMMENT '预警数量';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "INVOICE");
                            if (isExistCp_asset_reflect9 == false) {
                                String sql = " ALTER TABLE cp_asset_reflect ADD COLUMN INVOICE VARCHAR(255) CHARACTER SET utf8 COMMENT '发票号码';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "CONTRACT_NO");
                            if (isExistCp_asset_reflect10 == false) {
                                String sql = "ALTER TABLE cp_asset_reflect ADD COLUMN CONTRACT_NO VARCHAR(255) CHARACTER SET utf8 COMMENT '合同号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段  (flow_relation)
                            boolean userExtTableFlow_relation = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation", "FLOW_REL_NAME");
                            if (userExtTableFlow_relation == true) {
                                String sql = "alter table flow_relation modify column FLOW_REL_NAME  VARCHAR(40) null; ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableFlow_relation0 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation", "FLOW_REF_NO");
                            if (userExtTableFlow_relation0 == true) {
                                String sql = "alter table flow_relation modify column FLOW_REF_NO int(11) null; ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段  (flow_relation)
                            boolean userExtTableFlow_relation1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation", "RELATION_STATUS");
                            if (userExtTableFlow_relation1 == true) {
                                String sql = "alter table flow_relation modify column RELATION_STATUS  int(11) null; ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段(flow_relation)
                            boolean userExtTableFlow_relation12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation", "DATA_DIRECTION");
                            if (userExtTableFlow_relation12 == true) {
                                String sql = "alter table flow_relation modify column DATA_DIRECTION  int(11) null;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableFlow_relation13 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation", "FLOW_REL_DESC");
                            if (userExtTableFlow_relation13 == true) {
                                String sql = "alter table flow_relation modify column FLOW_REL_DESC  text null;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-3-14
                             *  作用:添加字段
                             */
                            boolean isExistCuser_group = Verification.CheckIsExistfield(conn, driver, url, username, password, "user_group", "LIMITS");
                            if (isExistCuser_group == false) {
                                String sql = "ALTER TABLE user_group ADD COLUMN LIMITS VARCHAR(2) NOT NULL DEFAULT '0' COMMENT '0,公共自定义组。1,用户自定义组';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "CREATE_USER_ID");
                            if (userExtTableHr_staff_work_experience == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `CREATE_USER_ID` varchar(254) DEFAULT '' COMMENT '创建者用户名';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "CREATE_DEPT_ID");
                            if (userExtTableHr_staff_work_experience1 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `CREATE_DEPT_ID` int(11) DEFAULT NULL COMMENT '创建者部门编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "STAFF_NAME");
                            if (userExtTableHr_staff_work_experience2 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `STAFF_NAME` varchar(254) DEFAULT '' COMMENT '单位员工';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "START_DATE");
                            if (userExtTableHr_staff_work_experience3 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `START_DATE` date DEFAULT '0000-00-00' COMMENT '开始日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "END_DATE");
                            if (userExtTableHr_staff_work_experience4 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `END_DATE` date DEFAULT '0000-00-00' COMMENT '结束日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "WORK_UNIT");
                            if (userExtTableHr_staff_work_experience5 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `WORK_UNIT` text COMMENT '工作单位';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "MOBILE");
                            if (userExtTableHr_staff_work_experience6 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `MOBILE` text COMMENT '行业类别';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "WORK_BRANCH");
                            if (userExtTableHr_staff_work_experience7 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `WORK_BRANCH` varchar(254) DEFAULT '' COMMENT '所在部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "POST_OF_JOB");
                            if (userExtTableHr_staff_work_experience8 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `POST_OF_JOB` varchar(254) DEFAULT '' COMMENT '担任职务';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "WORK_CONTENT");
                            if (userExtTableHr_staff_work_experience9 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `WORK_CONTENT` text COMMENT '工作内容';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "KEY_PERFORMANCE");
                            if (userExtTableHr_staff_work_experience10 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `KEY_PERFORMANCE` text COMMENT '主要业绩';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "REASON_FOR_LEAVING");
                            if (userExtTableHr_staff_work_experience11 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `REASON_FOR_LEAVING` text COMMENT '离职原因';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "WITNESS");
                            if (userExtTableHr_staff_work_experience12 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `WITNESS` varchar(254) DEFAULT '' COMMENT '证明人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience13 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "REMARK");
                            if (userExtTableHr_staff_work_experience13 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `REMARK` text COMMENT '备注';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句

                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience14 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "ATTACHMENT_ID");
                            if (userExtTableHr_staff_work_experience14 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `ATTACHMENT_ID` varchar(254) DEFAULT '' COMMENT '附件编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience15 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "ATTACHMENT_NAME");
                            if (userExtTableHr_staff_work_experience15 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `ATTACHMENT_NAME` varchar(254) DEFAULT '' COMMENT '附件名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience16 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "ADD_TIME");
                            if (userExtTableHr_staff_work_experience16 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `ADD_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_work_experience17 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_work_experience", "LAST_UPDATE_TIME");
                            if (userExtTableHr_staff_work_experience17 == true) {
                                String sql = "ALTER TABLE hr_staff_work_experience MODIFY `LAST_UPDATE_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "CREATE_USER_ID");
                            if (userExtTableHr_staff_incentive1 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `CREATE_USER_ID` varchar(254) DEFAULT NULL COMMENT '创建者用户名';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "CREATE_DEPT_ID");
                            if (userExtTableHr_staff_incentive2 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `CREATE_DEPT_ID` int(11) DEFAULT NULL COMMENT '创建者部门编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "STAFF_NAME");
                            if (userExtTableHr_staff_incentive3 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `STAFF_NAME` text COMMENT '员工姓名';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "INCENTIVE_TIME");
                            if (userExtTableHr_staff_incentive4 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `INCENTIVE_TIME` date DEFAULT '0000-00-00' COMMENT '奖惩日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "INCENTIVE_ITEM");
                            if (userExtTableHr_staff_incentive5 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `INCENTIVE_ITEM` text COMMENT '奖惩项目';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "INCENTIVE_TYPE");
                            if (userExtTableHr_staff_incentive6 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `INCENTIVE_TYPE` varchar(254) DEFAULT NULL COMMENT '奖惩属性';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "SALARY_MONTH");
                            if (userExtTableHr_staff_incentive7 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `SALARY_MONTH` varchar(254) DEFAULT NULL COMMENT '工资月份';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "INCENTIVE_AMOUNT");
                            if (userExtTableHr_staff_incentive8 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `INCENTIVE_AMOUNT` decimal(8,2) DEFAULT NULL COMMENT '奖惩金额';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "ATTACHMENT_ID");
                            if (userExtTableHr_staff_incentive9 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `ATTACHMENT_ID` varchar(225) DEFAULT NULL;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "ATTACHMENT_Name");
                            if (userExtTableHr_staff_incentive10 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `ATTACHMENT_Name` varchar(225) DEFAULT NULL;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "REMARK");
                            if (userExtTableHr_staff_incentive11 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `REMARK` text COMMENT '备注';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "INCENTIVE_DESCRIPTION");
                            if (userExtTableHr_staff_incentive12 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `INCENTIVE_DESCRIPTION` text COMMENT '奖惩说明';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive13 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "ADD_TIME");
                            if (userExtTableHr_staff_incentive13 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `ADD_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '登记时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段  (flow_relation)
                            boolean userExtTableHr_staff_incentive14 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_incentive", "LAST_UPDATE_TIME");
                            if (userExtTableHr_staff_incentive14 == true) {
                                String sql = "ALTER TABLE hr_staff_incentive MODIFY `LAST_UPDATE_TIME` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '最后修改时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistChr_staff_contract = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_contract", "JOB_ID");
                            if (isExistChr_staff_contract == false) {
                                String sql = " ALTER table hr_staff_contract add `JOB_ID` int(11) DEFAULT NULL;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistChr_staff_contract1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_contract", "POST_ID");
                            if (isExistChr_staff_contract1 == false) {
                                String sql = " ALTER table hr_staff_contract add `POST_ID` int(11) DEFAULT NULL;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                        /*    *
                        2019.3.20
                     *  添加字段的作用: 添加菜单
                     */
                            boolean isExistFunction_w = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5021");
                            if (isExistFunction_w == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('5021', '606502', '保管人确认', '', '', NULL, NULL, NULL, 'eduFixAssets/scheduler', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**   2019-3-20
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_q = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "SCHEDULER");
                            if (isExistCp_asset_reflect_q == false) {
                                String sql = " alter table cp_asset_reflect add column SCHEDULER varchar(50) comment '调度人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_w = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "SCHEDULERSTATUS");
                            if (isExistCp_asset_reflect_w == false) {
                                String sql = " alter table cp_asset_reflect add column SCHEDULERSTATUS varchar(50) comment '调度人修改状态';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_z = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "MODIFY_CONTENT");
                            if (isExistCp_asset_reflect_z == false) {
                                String sql = "alter table cp_asset_reflect add column MODIFY_CONTENT text comment '修改内容';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_df = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "NOT_ACCEPT_REASON");
                            if (isExistCp_asset_reflect_df == false) {
                                String sql = " alter table cp_asset_reflect add column NOT_ACCEPT_REASON varchar(255) comment '不接收理由';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_zs = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "ASSETS_NAME_ENGLISH");
                            if (isExistCp_asset_reflect_zs == false) {
                                String sql = " alter table cp_asset_reflect add column ASSETS_NAME_ENGLISH varchar(255) comment '设备名称(英文)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_za = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "DEVICE_CODE");
                            if (isExistCp_asset_reflect_za == false) {
                                String sql = " alter table cp_asset_reflect add column DEVICE_CODE varchar(255) comment '设备代码';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-3-13
                             *  作用:添加字段
                             */
                            boolean isExistCp_asset_reflect_zc = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "DEPRECIATION_METHOD");
                            if (isExistCp_asset_reflect_zc == false) {
                                String sql = " alter table cp_asset_reflect add column DEPRECIATION_METHOD varchar(255) comment '折旧方法';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //修改字段  (cp_asset_reflect)
                            boolean userExtTableCp_asset_reflect = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "ATTACHMENT_NAME");
                            if (userExtTableCp_asset_reflect == true) {
                                String sql = "alter table cp_asset_reflect modify column ATTACHMENT_NAME text;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //修改字段  (cp_asset_reflect)
                            boolean userExtTableCp_asset_reflect_dept = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "DEPT_ID");
                            if (userExtTableCp_asset_reflect_dept == true) {
                                String sql = "ALTER TABLE cp_asset_reflect MODIFY `DEPT_ID` int(11) DEFAULT NULL COMMENT '所属部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //修改字段  (cp_asset_reflect)
                            boolean userExtTableCp_asset_reflect_type = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "TYPE_ID");
                            if (userExtTableCp_asset_reflect_type == true) {
                                String sql = "ALTER TABLE cp_asset_reflect MODIFY `TYPE_ID` int(11) DEFAULT NULL COMMENT '资产类型';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //添加默认考勤
                       /*    *
                        张丽军
                        2018-11-28
                     *  作用: 添加数据（考勤默认数据）
                     */
                            boolean checkIsExisAttend_set = Verification.CheckIsExistAttend_set(conn, driver, url, username, password, "99");
                            if (checkIsExisAttend_set == false) {
                                String sql = "INSERT INTO attend_set (`SID`, `UID`, `TITLE`, `ATIME1_SET`, `ATIME1`, `ATIME2_SET`, `ATIME2`, `ATIME3_SET`, `ATIME3`, `ATIME4_SET`, `ATIME4`, `ATIME5_SET`, `ATIME5`, `ATIME6_SET`, `ATIME6`, `WORKTIME_F`, `WORKTIME_B`, `WORKAFTER_F`, `WORKAFTER_B`, `LOCATION`, `RANGES`, `IS_OUT`, `LOCATION_ON`, `WIFI_ON`, `WIFI_ADDR`, `WIFI_NAME`, `WORKDATE`, `IS_OVERTIME`, `IS_DUTY`, `IS_TRIP`, `IS_LEAVE`, `IS_GO`) VALUES (99, 1, '默认考勤', '1|1', '09:00:00', '1|2', '17:00:00', '0|1', '', '0|1', '', '0|1', '', '0|1', '', '', '', '', '', '', '0', '0', '0', '0', '', '', '', '1', '1', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            //修改字段  (cp_asset_reflect)   以纯需要
                       /* boolean userExtTableFlow_data_224 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_data_224","data_307");
                        if(userExtTableFlow_data_224==true){
                            String sql="alter table flow_data_224 modify column data_307  text not null;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/

                            //修改字段  (cp_asset_reflect)
                       /* boolean userExtTableFlow_data_222 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_data_222","data_307");
                        if(userExtTableFlow_data_222==true){
                            String sql="alter table flow_data_222 modify column data_307  text not null; ";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/

                            //修改字段  (cp_asset_reflect)
                       /* boolean userExtTableFlow_data_223 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_data_223","data_307");
                        if(userExtTableFlow_data_223==true){
                            String sql="alter table flow_data_223 modify column data_307  text not null; ";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/

                            //修改字段  (cp_asset_reflect)
                        /*boolean userExtTableFlow_data_225 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_data_225","data_307");
                        if(userExtTableFlow_data_225==true){
                            String sql="alter table flow_data_225 modify column data_307  text not null; ";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/

                            //修改字段  (cp_asset_reflect)
                      /*  boolean userExtTableFlow_data_226 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_data_226","data_307");
                        if(userExtTableFlow_data_226==true){
                            String sql="alter table flow_data_226 modify column data_307  text not null; ";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
*/

                            /**   2019-4-12
                             *  创建者：张丽军
                             *  作用: 添加密码为空时登录时提示修改密码  这一选项
                             */
                            boolean SEC_INIT_PASS_SHOW = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "SEC_INIT_PASS_SHOW");
                            if (SEC_INIT_PASS_SHOW == false) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('SEC_INIT_PASS_SHOW', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            boolean checkIsExistPortals = Verification.CheckIsExistTable(conn, driver, url, username, password, "portals");
                            if (checkIsExistPortals == false) {
                                String sql = "CREATE TABLE `portals` (\n" +
                                        "  `portals_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',\n" +
                                        "  `portals_no` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `portal_name` varchar(255) DEFAULT NULL COMMENT '门户名称',\n" +
                                        "  `portal_type` int(11) DEFAULT NULL COMMENT '门户类型（0：系统门户；1：自定义门户）',\n" +
                                        "  `portal_link` varchar(255) DEFAULT NULL COMMENT '系统门户关联地址',\n" +
                                        "  `module_id` varchar(255) DEFAULT NULL COMMENT '自定义门户关联id',\n" +
                                        "  `use_flag` int(11) DEFAULT NULL COMMENT '启用标记(0-停用,1-启用)',\n" +
                                        "  `access_priv_dept` varchar(255) DEFAULT NULL COMMENT '授权部门',\n" +
                                        "  `access_priv_priv` varchar(255) DEFAULT NULL COMMENT '授权角色',\n" +
                                        "  `access_priv_user` varchar(255) DEFAULT NULL COMMENT '授权用户',\n" +
                                        "  `access_priv` int(1) DEFAULT '0' COMMENT '是否授权（0所有人1指定授权）',\n" +
                                        "  `portals_show` varchar(255) DEFAULT NULL COMMENT '我的门户模块显示id串',\n" +
                                        "  `portals_menu` varchar(255) DEFAULT NULL COMMENT '应用门户显示菜单串',\n" +
                                        "  `show_num` int(10) DEFAULT '0' COMMENT '排列方式每行几个',\n" +
                                        "  `portals_manage` varchar(255) DEFAULT NULL COMMENT '管理门户模块显示id串',\n" +
                                        "  PRIMARY KEY (`portals_id`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            boolean checkIsExisPortals01 = Verification.CheckIsExistPortals(conn, driver, url, username, password, "1");
                            if (!checkIsExisPortals01) {
                                String sql = "INSERT INTO `portals` VALUES ('1', '1', '我的门户', '0', '', '', '1', '', '', '', '0', '01,02,03,05,04,06,07,08,09,10,', '01,03,02,04,05,06,07,10,08,09,', null, '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            boolean checkIsExisPortals02 = Verification.CheckIsExistPortals(conn, driver, url, username, password, "2");
                            if (!checkIsExisPortals02) {
                                String sql = "INSERT INTO `portals` VALUES ('2', '2', '应用门户', '0', '', '', '1', '', '', '', '0', '0116,0117,0101,0124,0128,0136,3001,1010,1020,3010,208002,208004,208006,', '3010,3001,208002,0117,0136,1010,0101,0124,1020,0116,', '5', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            boolean checkIsExisPortals03 = Verification.CheckIsExistPortals(conn, driver, url, username, password, "3");
                            if (!checkIsExisPortals03) {
                                String sql = "INSERT INTO `portals` VALUES ('3', '3', '管理门户', '0', '', '', '1', '', '', '', '0', null, null, null, '04,01,06,03,05,09,07,08,02,');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-4-12
                             * 张丽军
                             *  作用:添加我的门户模块字段
                             */
                            boolean isExistPortals_show = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "portals_show");
                            if (isExistPortals_show == false) {
                                String sql = " alter table portals add column portals_show varchar(255) DEFAULT NULL comment '我的门户模块显示id串';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-4-12
                             * 张丽军
                             *  作用:添加应用门户显示菜单串字段
                             */
                            boolean isExistPortals_menu = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "portals_menu");
                            if (isExistPortals_menu == false) {
                                String sql = " alter table portals add column portals_menu varchar(255) DEFAULT NULL comment '应用门户显示菜单串';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-4-12
                             * 张丽军
                             *  作用:添加排列方式每行几个字段
                             */
                            boolean isExistShow_num = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "show_num");
                            if (isExistShow_num == false) {
                                String sql = " alter table portals add column show_num int(10) DEFAULT '0' comment '排列方式每行几个';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-4-12
                             * 张丽军
                             *  作用:添加应用门户显示菜单串字段
                             */
                            boolean isExistPortals_manage = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "portals_manage");
                            if (isExistPortals_manage == false) {
                                String sql = " alter table portals add column portals_manage varchar(255) DEFAULT NULL comment '管理门户模块显示id串';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-4-18
                             * 张丽军
                             *  作用:添加公告提醒字段
                             */
                            boolean isExistHOW_RENIND = Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "HOW_RENIND");
                            if (isExistHOW_RENIND == false) {
                                String sql = " ALTER TABLE notify ADD HOW_RENIND VARCHAR ( 20 ) null comment '0.事务提醒1.手机短信提醒';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-4-18 张丽军
                             *      创建表 cp_asset_type
                             */
                            boolean checkIsExistAi_setting = Verification.CheckIsExistTable(conn, driver, url, username, password, "ai_setting");
                            if (checkIsExistAi_setting == false) {
                                String sql = "CREATE TABLE `ai_setting` (\n" +
                                        "  `UID` int(20) NOT NULL COMMENT 'user的主键',\n" +
                                        "  `greet` int(10) DEFAULT NULL COMMENT '启动时自动语音问候(0-是，1-否)',\n" +
                                        "  `approval` int(10) DEFAULT NULL COMMENT '启动时自动语音审批(0-是，1-否)',\n" +
                                        "  `rouse` int(10) DEFAULT NULL COMMENT '语音唤醒(0-是，1-否)',\n" +
                                        "  PRIMARY KEY (`UID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='AI设置';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *
                             *  作用: 添加小卓数据
                             */
                            boolean widget_10 = Verification.CheckIsExistWidget(conn, driver, url, username, password, "10");
                            if (widget_10 == false) {
                                String sql = "INSERT INTO `widget`(`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES (10, '小卓AI', 0, 1, 'XiaoZhuoAI', '1', '1', 10);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *
                             *  作用: 最新文件
                             */
                            boolean widget_11 = Verification.CheckIsExistWidget(conn, driver, url, username, password, "11");
                            if (widget_11 == false) {
                                String sql = "INSERT INTO `widget`(`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES (11, '最新文件', 0, 1, 'NewFile', '1', '1', 11);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*   *
                           张丽军
                           2018-11-28
                     *  修改字段的作用: 修改门户内置数据
                     */
                            boolean checkIsExisPortals = Verification.CheckIsExistPortals(conn, driver, url, username, password, "1");
                            if (checkIsExisPortals == true) {
                                String sql = "UPDATE `portals` SET `portals_id`='1', `portals_no`='1', `portal_name`='我的门户', `portal_type`='0', `portal_link`='', `module_id`='', `use_flag`='1', `access_priv_dept`='', `access_priv_priv`='', `access_priv_user`='', `access_priv`='0', `portals_show`='01,02,03,05,04,06,07,08,09,10,', `portals_menu`='01,03,02,04,05,06,07,10,08,09,', `show_num`=NULL, `portals_manage`='' WHERE (`portals_id`='1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                           /*   *
                           张丽军
                           2018-11-28
                     *  修改字段的作用: 修改门户内置数据
                     */
                            boolean checkIsExisPortal = Verification.CheckIsExistPortals(conn, driver, url, username, password, "2");
                            if (checkIsExisPortal == true) {
                                String sql = "UPDATE `portals` SET `portals_id`='2', `portals_no`='2', `portal_name`='应用门户', `portal_type`='0', `portal_link`='', `module_id`='', `use_flag`='1', `access_priv_dept`='', `access_priv_priv`='', `access_priv_user`='', `access_priv`='0', `portals_show`='0116,0117,0101,0124,0128,0136,3001,1010,1020,3010,208002,208004,208006,', `portals_menu`='3010,3001,208002,0117,0136,1010,0101,0124,1020,0116,', `show_num`='5', `portals_manage`='' WHERE (`portals_id`='2');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                           /*   *
                           张丽军
                           2018-11-28
                     *  修改字段的作用: 修改门户内置数据
                     */
                            boolean checkIsExisPortals_1 = Verification.CheckIsExistPortals(conn, driver, url, username, password, "3");
                            if (checkIsExisPortals_1 == true) {
                                String sql = "UPDATE `portals` SET `portals_id`='3', `portals_no`='3', `portal_name`='管理门户', `portal_type`='0', `portal_link`='', `module_id`='', `use_flag`='1', `access_priv_dept`='', `access_priv_priv`='', `access_priv_user`='', `access_priv`='0', `portals_show`=NULL, `portals_menu`=NULL, `show_num`=NULL, `portals_manage`='04,01,06,03,05,09,07,08,02,' WHERE (`portals_id`='3');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                               /*   *
                           张丽军
                           2018-11-28
                     *  修改字段的作用: 修改门户内置数据
                     */
                            boolean checkIsExisPortals_KF = Verification.CheckIsExistPortalsCRM(conn, driver, url, username, password, "4", "管理门户");
                            if (checkIsExisPortals_KF == true) {
                                String sql = "DELETE  FROM `portals` WHERE `portals_id`='4' and `portal_name`='管理门户'";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_a = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "portals_show");
                            if (isExistCode_a == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '公告', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'portals_show', '1', '/img/main_img/app/0116.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_b = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "portals_show");
                            if (isExistCode_b == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '新闻', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'portals_show', '1', '/img/main_img/app/0117.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_c = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "portals_show");
                            if (isExistCode_c == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '邮件箱', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'portals_show', '1', '/img/main_img/app/0101.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_d = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "portals_show");
                            if (isExistCode_d == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '待办流程', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'portals_show', '1', '/img/main_img/app/dblc.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_e = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "portals_show");
                            if (isExistCode_e == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '待办公文', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'portals_show', '1', '/img/main_img/app/dbgw.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_f = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "portals_show");
                            if (isExistCode_f == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '日程安排', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'portals_show', '1', '/img/main_img/app/0124.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_g = Verification.CheckIsExistCode(conn, driver, url, username, password, "07", "portals_show");
                            if (isExistCode_g == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('07', '常用功能', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'portals_show', '1', '/img/main_img/app/cygn.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_h = Verification.CheckIsExistCode(conn, driver, url, username, password, "08", "portals_show");
                            if (isExistCode_h == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('08', '日志', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'portals_show', '1', '/img/main_img/app/0128.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_j = Verification.CheckIsExistCode(conn, driver, url, username, password, "09", "portals_show");
                            if (isExistCode_j == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('09', '文件柜', NULL, NULL, NULL, NULL, NULL, NULL, '09', 'portals_show', '1', '/img/main_img/app/0136.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_k = Verification.CheckIsExistCode(conn, driver, url, username, password, "10", "portals_show");
                            if (isExistCode_k == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('10', '网络硬盘', NULL, NULL, NULL, NULL, NULL, NULL, '10', 'portals_show', '1', '/img/main_img/app/3010.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_l = Verification.CheckIsExistCode(conn, driver, url, username, password, "11", "portals_show");
                            if (isExistCode_l == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('11', '会议通知', NULL, NULL, NULL, NULL, NULL, NULL, '11', 'portals_show', '1', '/img/main_img/app/hytz.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_o = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "portals_manage");
                            if (isExistCode_o == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '今日考勤统计', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'portals_manage', '1', '/img/main_img/mana/kqtj.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_u = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "portals_manage");
                            if (isExistCode_u == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '员工请假统计', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'portals_manage', '1', '/img/main_img/mana/qjtj.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_y = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "portals_manage");
                            if (isExistCode_y == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '公告发布数统计', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'portals_manage', '1', '/img/main_img/mana/ggfb.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_r = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "portals_manage");
                            if (isExistCode_r == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '新闻发布数统计', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'portals_manage', '1', '/img/main_img/mana/xwtj.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_t = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "portals_manage");
                            if (isExistCode_t == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '工作流统计', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'portals_manage', '1', '/img/main_img/mana/gzltj.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_w = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "portals_manage");
                            if (isExistCode_w == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '员工统计', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'portals_manage', '1', '/img/main_img/mana/ygtj.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_q = Verification.CheckIsExistCode(conn, driver, url, username, password, "07", "portals_manage");
                            if (isExistCode_q == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('07', '员工合同统计', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'portals_manage', '1', '/img/main_img/mana/yght.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_z = Verification.CheckIsExistCode(conn, driver, url, username, password, "08", "portals_manage");
                            if (isExistCode_z == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('08', '合同到期员工', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'portals_manage', '1', '/img/main_img/mana/ygrz.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 添加门户模块名称
                             */
                            boolean isExistCode_x = Verification.CheckIsExistCode(conn, driver, url, username, password, "09", "portals_manage");
                            if (isExistCode_x == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('09', '新入职员工', NULL, NULL, NULL, NULL, NULL, NULL, '09', 'portals_manage', '1', '/img/main_img/mana/htdq.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*     *
                             * 张丽军
                             *  添加字段的作用: 添加字段
                             * 2018-10-17
                             *
                             */
                            boolean checkIsExistfield_qw = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_read", "TABLE_ID");
                            if (checkIsExistfield_qw == false) {
                                String sql = "ALTER TABLE flow_run_read ADD TABLE_ID int ( 40 ) null comment '公文唯一标识ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**
                             * 修改c_accountinfo用户中间表字段类型
                             */
                            boolean checkIsC_accountinfo = Verification.CheckIsExistfield(conn, driver, url, username, password, "c_accountinfo", "USER_TYPE");
                            if (checkIsC_accountinfo == true) {
                                String sql = "alter table c_accountinfo modify column USER_TYPE varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "USER_ID");
                            if (checkIsUser1 == true) {
                                String sql = "alter table user modify column USER_ID varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "BYNAME");
                            if (checkIsUser2 == true) {
                                String sql = "alter table user modify column BYNAME varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "KEY_SN");
                            if (checkIsUser3 == true) {
                                String sql = "alter table user modify column KEY_SN varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "SECURE_KEY_SN");
                            if (checkIsUser4 == true) {
                                String sql = "alter table user modify column SECURE_KEY_SN varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "USER_PRIV_NAME");
                            if (checkIsUser5 == true) {
                                String sql = "alter table user modify column USER_PRIV_NAME varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "AVATAR");
                            if (checkIsUser6 == true) {
                                String sql = "alter table user modify column AVATAR varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "PORTAL");
                            if (checkIsUser7 == true) {
                                String sql = "alter table user modify column PORTAL varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "LAST_VISIT_IP");
                            if (checkIsUser8 == true) {
                                String sql = "alter table user modify column LAST_VISIT_IP varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "MENU_IMAGE");
                            if (checkIsUser9 == true) {
                                String sql = "alter table user modify column MENU_IMAGE varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }
                            /**
                             * 修改user用户表字段类型
                             */
                            boolean checkIsUser10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "PHOTO");
                            if (checkIsUser10 == true) {
                                String sql = "alter table user modify column PHOTO varchar(50);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }

                         /* *
                         作者：张丽军
                         时间：2019.4.23
                     *  作用: 更新user表登录时长数据
                     */
                            boolean user_online = Verification.CheckIsExistUser(conn, driver, url, username, password, "1");
                            if (user_online == true) {
                                String sql = "UPDATE `user` SET `ONLINE`='0' WHERE (`UID`='1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //添加字段
                   /*     boolean sys_function262 = Verification.CheckIsExistfield(conn, driver, url, username, password, "timed_task_management", "CLASS_PATH");
                        if (sys_function262 == false) {
                            String sql = "alter table timed_task_management add CLASS_PATH  varchar(255) comment '定时任务执行文件';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
                            //添加字段
                      /*  boolean sys_function263 = Verification.CheckIsExistfield(conn, driver, url, username, password, "timed_task_management", "TASK_ DESCRIPTION");
                        if (sys_function263 == false) {
                            String sql = "ALTER TABLE `timed_task_management` modify COLUMN TASK_DESCRIPTION VARCHAR (255) COMMENT '任务描述'; ";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
                            /**   2018-1-26
                             *  作用: 添加角色编辑与权限
                             */
                            boolean isExistCode_21 = Verification.CheckIsExistCode(conn, driver, url, username, password, "20", "SYS_LOG");
                            if (isExistCode_21 == false) {
                                String sql = "INSERT INTO `sys_code` ( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('20', '编辑角色与权限', 'EDIT_PRIV_ORLE', '', '', '', '', '', '20', 'SYS_LOG', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2018-1-26
                             *  作用: 添加角色编辑与权限
                             */
                            boolean isExistCode_22 = Verification.CheckIsExistCode(conn, driver, url, username, password, "21", "SYS_LOG");
                            if (isExistCode_22 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('21', '删除角色与权限', 'DELETE_PRIV_ORLE', '', '', '', '', '', '21', 'SYS_LOG', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**
                             * 2019-05-16
                             * 作用:单位表添加税号
                             */
                            boolean checkIsExistfield_tax_number = Verification.CheckIsExistfield(conn, driver, url, username, password, "unit", "TAX_NUMBER");
                            if (!checkIsExistfield_tax_number) {
                                String sql = "ALTER TABLE unit ADD TAX_NUMBER VARCHAR (100) COMMENT '税号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: 天气表
                             *   添加时间：2019-05-21
                             */
                            boolean weather = Verification.CheckIsExistTable(conn, driver, url, username, password, "weather");
                            if (weather == false) {
                                String sql = " CREATE TABLE `weather` (\n" +
                                        "  `wid` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',\n" +
                                        "  `date` varchar(255) DEFAULT NULL COMMENT '显示天气时间',\n" +
                                        "  `dateComen` datetime DEFAULT NULL COMMENT '访问天气的时间',\n" +
                                        "  `location` varchar(255) DEFAULT NULL COMMENT '城市位置',\n" +
                                        "  `weather` varchar(255) DEFAULT NULL COMMENT '天气（阴晴多云等）',\n" +
                                        "  `pmTwoPointFive` varchar(255) DEFAULT NULL,\n" +
                                        "  `tempertureNow` varchar(255) DEFAULT NULL,\n" +
                                        "  `tempertureOfDay` longtext,\n" +
                                        "  `week` varchar(255) DEFAULT NULL,\n" +
                                        "  `wind` varchar(255) DEFAULT NULL,\n" +
                                        "  `weihao` varchar(255) DEFAULT NULL,\n" +
                                        "  `picture` varchar(255) DEFAULT NULL,\n" +
                                        "                        PRIMARY KEY (`wid`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='weather 天气表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加索引
                             *   添加时间：2019-05-22
                             */
                            boolean sms_body_online = Verification.CheckIsExistTable(conn, driver, url, username, password, "sms_body");
                            if (sms_body_online == true) {
                                boolean ll = Verification.CheckIsExistll(conn, driver, url, username, password);
                                if (ll == false) {
                                    String sql = "ALTER TABLE `sms_body` ADD INDEX BODY_ID  (`BODY_ID`);";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }

                            /**  创建者：  张丽军
                             *   添加索引
                             *   添加时间：2019-05-22
                             */
                            boolean sms_body_onl = Verification.CheckIsExistTable(conn, driver, url, username, password, "sms_body");
                            if (sms_body_onl == true) {
                                boolean lk = Verification.CheckIsExistlk(conn, driver, url, username, password);
                                if (lk == false) {
                                    String sql = "ALTER TABLE `sms_body` ADD INDEX REMIND_URL (`REMIND_URL`);";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                                }
                            }

                          /*  *
                          张丽军
                          2019.6.11
                     *  作用: 删除索引
                     */
                            boolean INDEX1 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "im_message", "FROM_UID");
                            if (INDEX1 == true) {
                                boolean lh = Verification.CheckIsExistlh(conn, driver, url, username, password);
                                if (lh == true) {
                                    String sql = "ALTER TABLE im_message DROP INDEX FROM_UID;";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }

                         /*  *
                          张丽军
                          2019.6.11
                     *  作用: 删除索引
                     */
                            boolean INDEX2 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "im_message", "TO_UID");
                            if (INDEX2 == true) {
                                boolean lt = Verification.CheckIsExistlt(conn, driver, url, username, password);
                                if (lt == true) {
                                    String sql = "ALTER TABLE im_message DROP INDEX TO_UID;";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }
                         /*  *
                          张丽军
                          2019.6.11
                     *  作用: 删除索引
                     */
                            boolean INDEX3 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "im_message", "UUID");
                            if (INDEX3 == true) {
                                boolean ly = Verification.CheckIsExistly(conn, driver, url, username, password);
                                if (ly == true) {
                                    String sql = "ALTER TABLE im_message DROP INDEX UUID;";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句

                                }
                            }

                            /* *
                             *张丽军  2019.6.18
                             *  添加字段的作用: 添加字段（是否允许手机端新建该流程 0-否 1-是）
                             */
                            boolean checkIsExistfield_121 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "MOBILE_NEW_TYPE");
                            if (checkIsExistfield_121 == false) {
                                String sql = "ALTER TABLE flow_type ADD MOBILE_NEW_TYPE VARCHAR (10) DEFAULT '1' COMMENT '是否允许手机端新建该流程 0-否 1-是';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目信息表
                             *   添加时间：2019-06-18
                             */
                            boolean cms_channel_info = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_channel_info");
                            if (cms_channel_info == false) {
                                String sql = " CREATE TABLE `cms_channel_info` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',\n" +
                                        "  `CHNL_IDENTITY` varchar(255) DEFAULT NULL COMMENT '栏目标识',\n" +
                                        "  `CHNL_NAME` varchar(255) DEFAULT NULL,\n" +
                                        "  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `CR_USERID` int(11) DEFAULT NULL COMMENT '创建用户uid',\n" +
                                        "  `CR_USERNAME` varchar(255) DEFAULT NULL COMMENT '创建用户userId',\n" +
                                        "  `DEL_FLAG` int(11) DEFAULT '0' COMMENT '删除标记',\n" +
                                        "  `DETAIL_TPL` int(11) DEFAULT NULL COMMENT '细则模板',\n" +
                                        "  `FOLDER` varchar(255) DEFAULT NULL COMMENT '存储位置',\n" +
                                        "  `INDEX_TPL` int(11) DEFAULT NULL COMMENT '首页模板',\n" +
                                        "  `PARENT_CHNL` int(11) DEFAULT NULL COMMENT '父级栏目id',\n" +
                                        "  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',\n" +
                                        "  `SITE_ID` int(11) DEFAULT NULL COMMENT '站点id',\n" +
                                        "  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `STATUS` int(11) DEFAULT NULL COMMENT '发布状态',\n" +
                                        "  `PAGE_SIZE` int(11) DEFAULT '0' COMMENT '分页大小',\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='cms栏目信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            /**   2019-6-18
                             *  作用: 添加职务、岗位下拉框
                             */
                            boolean isExistCodea = Verification.CheckIsExistCode(conn, driver, url, username, password, "BUDGETTYPE", "FLOWTYPE");
                            if (isExistCodea == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('BUDGETTYPE', '预算', NULL, NULL, NULL, NULL, NULL, NULL, '3', 'FLOWTYPE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-18
                             *  作用: 添加职务、岗位下拉框
                             */
                            boolean isExistCodeb = Verification.CheckIsExistCode(conn, driver, url, username, password, "BUDGETTYPE", "");
                            if (isExistCodeb == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('BUDGETTYPE', '预算分类', NULL, NULL, NULL, NULL, NULL, NULL, '1', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-18
                             *  作用: 添加职务、岗位下拉框
                             */
                            boolean isExistCodec = Verification.CheckIsExistCode(conn, driver, url, username, password, "BUDGETTYPE01", "BUDGETTYPE");
                            if (isExistCodec == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('BUDGETTYPE01', '普通预算', NULL, NULL, NULL, NULL, NULL, NULL, '1', 'BUDGETTYPE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctiona = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2207");
                            if (isExistFunctiona == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2207','8001', '站点管理', NULL, NULL, NULL, NULL, NULL, 'site/sites', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionb = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2208");
                            if (isExistFunctionb == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2208','8003', '栏目管理', NULL, NULL, NULL, NULL, NULL, 'site/columnManagement', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionc = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2209");
                            if (isExistFunctionc == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2209','8004', '文档管理', NULL, NULL, NULL, NULL, NULL, 'site/documentManagement', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* * 2019-6-18
                             *  添加字段的作用: 添加CMS主菜单
                             */
                            boolean isExistMenu1 = Verification.CheckIsExistMenu(conn, driver, url, username, password, "80");
                            if (isExistMenu1 == false) {
                                String sql = "INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('80', 'CMS门户内容管理', 'cms', '', '', '', '', '', 'record');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**2020-9-14
                             * 修改cms菜单名称
                             */
                            if (Verification.CheckIsExistMenu(conn, driver, url, username, password, "80")) {
                                String sql = "update sys_menu set menu_name ='CMS门户管理' where MENU_ID ='80';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* * 2019-6-18
                             *  添加字段的作用: 添加CRM主菜单
                             */
                            boolean isExistMenu2 = Verification.CheckIsExistMenu(conn, driver, url, username, password, "75");
                            if (isExistMenu2 == false) {
                                String sql = "INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('75', 'CRM客户管理', 'crm', '', '', '', '', '', 'mytable');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* * 2019-6-18
                             *  添加字段的作用: 添加预算管理主菜单
                             */
                            boolean isExistMenu3 = Verification.CheckIsExistMenu(conn, driver, url, username, password, "85");
                            if (isExistMenu3 == false) {
                                String sql = "INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('85', '预算管理', 'budget management', '預算管理', '', '', '', '', 'budgetitem');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单预算报表
                             */
                            boolean isExistFunctionc62 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2212");
                            if (isExistFunctionc62 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2212', '8503', '预算报表', NULL, NULL, NULL, NULL, NULL, 'budget/budgetaryStatistics', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单预算报表
                             */
                            boolean isExistFunctionc64 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2210");
                            if (isExistFunctionc64 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2210', '8501', '预算项目管理', NULL, NULL, NULL, NULL, NULL, 'budget/budgetItemManage', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单预算报表
                             */
                            boolean isExistFunctionc65 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2213");
                            if (isExistFunctionc65 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2213', '8505', '文件管理', NULL, NULL, NULL, NULL, NULL, 'budget/budgetManagement', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单预算报表
                             */
                            boolean isExistFunctionc66 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2211");
                            if (isExistFunctionc66 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2211', '8502', '预算执行台账', NULL, NULL, NULL, NULL, NULL, 'budget/budgetTaiZhang', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单预算报表
                             */
                            boolean isExistFunctionc67 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2214");
                            if (isExistFunctionc67 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2214', '8506', '预算权限设置', NULL, NULL, NULL, NULL, NULL, '/budget/budgeSetting', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-18
                             *  添加字段的作用: 添加菜单单点登录
                             */
                            boolean isExistFunctionc68 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2215");
                            if (isExistFunctionc68 == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2215', 'z072', '单点登录设置', NULL, NULL, NULL, NULL, NULL, '/xoaCas/newCas', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目信息表
                             *   添加时间：2019-06-18
                             */
                            boolean budget_file = Verification.CheckIsExistTable(conn, driver, url, username, password, "budget_file");
                            if (budget_file == false) {
                                String sql = " CREATE TABLE `budget_file` (\n" +
                                        "  `id` int(11) NOT NULL,\n" +
                                        "  `budget_process_id` int(11) DEFAULT NULL,\n" +
                                        "  `ATTACHMENT_ID` varchar(255) DEFAULT NULL,\n" +
                                        "  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`id`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目信息表
                             *   添加时间：2019-06-18
                             */
                            boolean budget_item = Verification.CheckIsExistTable(conn, driver, url, username, password, "budget_item");
                            if (budget_item == false) {
                                String sql = " CREATE TABLE `budget_item` (\n" +
                                        "  `Budget_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '预算项目Id',\n" +
                                        "  `budget_item_name` varchar(255) DEFAULT NULL COMMENT '预算项目名称',\n" +
                                        "  `budget_item_no` varchar(255) DEFAULT NULL COMMENT '项目排序号',\n" +
                                        "  `budget_item_begindate` date DEFAULT NULL COMMENT '项目开始时间',\n" +
                                        "  `budget_item_enddate` date DEFAULT NULL COMMENT '项目结束时间',\n" +
                                        "  `year` varchar(4) DEFAULT NULL COMMENT '年度',\n" +
                                        "  `Input_time` datetime DEFAULT NULL COMMENT '录入时间',\n" +
                                        "  `dept_id` int(255) DEFAULT NULL COMMENT '所属部门',\n" +
                                        "  `Line_No` varchar(255) DEFAULT NULL COMMENT '额度号',\n" +
                                        "  `Prive_item` varchar(255) DEFAULT NULL COMMENT '上级项目',\n" +
                                        "  `Item_money` varchar(255) DEFAULT NULL COMMENT '项目金额',\n" +
                                        "  `Item_manager` varchar(255) DEFAULT NULL COMMENT '项目负责人',\n" +
                                        "  `Item_executer` varchar(255) DEFAULT NULL COMMENT '项目执行人',\n" +
                                        "  `Item_desc` varchar(255) DEFAULT NULL COMMENT '项目描述',\n" +
                                        "  `Attachment_name` text COMMENT '附件名',\n" +
                                        "  `Attachment_id` text COMMENT '附件id',\n" +
                                        "  `user_id` varchar(255) DEFAULT NULL COMMENT '填报人姓名',\n" +
                                        "  `user_phone` varchar(255) DEFAULT NULL COMMENT '填报人电话',\n" +
                                        "  `status` varchar(255) DEFAULT NULL COMMENT '状态',\n" +
                                        "  `quota_classify` varchar(255) DEFAULT NULL COMMENT '指标分类',\n" +
                                        "  `remaining_amount` varchar(255) DEFAULT NULL COMMENT '剩余金额',\n" +
                                        "  `del_flag` int(1) DEFAULT '0' COMMENT '记录是否删除',\n" +
                                        "  `all_advance` int(11) DEFAULT NULL COMMENT '预支出金额',\n" +
                                        "  PRIMARY KEY (`Budget_id`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目信息表
                             *   添加时间：2019-06-18
                             */
                            boolean budget_log = Verification.CheckIsExistTable(conn, driver, url, username, password, "budget_log");
                            if (budget_log == false) {
                                String sql = " CREATE TABLE `budget_log` (\n" +
                                        "  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `Budget_id` int(11) DEFAULT NULL,\n" +
                                        "  `USER_ID` varchar(255) NOT NULL,\n" +
                                        "  `TIME` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,\n" +
                                        "  `IP` varchar(255) NOT NULL,\n" +
                                        "  `TYPE` varchar(255) DEFAULT NULL,\n" +
                                        "  `REMARK` varchar(255) NOT NULL,\n" +
                                        "  `budget_item_name` varchar(255) DEFAULT NULL,\n" +
                                        "  `budget_input_time` datetime DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`LOG_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目信息表
                             *   添加时间：2019-06-18
                             */
                            boolean budgeting_process = Verification.CheckIsExistTable(conn, driver, url, username, password, "budgeting_process");
                            if (budgeting_process == false) {
                                String sql = " CREATE TABLE `budgeting_process` (\n" +
                                        "  `run_id` int(11) DEFAULT NULL COMMENT '流程实例ID',\n" +
                                        "  `Budget_process_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                        "  `applicant` varchar(255) NOT NULL COMMENT '申请人',\n" +
                                        "  `dept_id` int(255) DEFAULT NULL COMMENT '申请部门',\n" +
                                        "  `application_date` datetime DEFAULT NULL COMMENT '申请日期',\n" +
                                        "  `per_pay` varchar(150) DEFAULT NULL COMMENT '支付方式（0-现金1-公务卡2-支票3-电汇4-银行卡转账）',\n" +
                                        "  `is_per` varchar(150) DEFAULT NULL COMMENT '是否预算（0-是1-否）',\n" +
                                        "  `fixed_assets` varchar(255) DEFAULT NULL COMMENT '固定资产',\n" +
                                        "  `Budget_item_name` varchar(255) DEFAULT NULL COMMENT '项目名称',\n" +
                                        "  `Budget_id` int(50) DEFAULT NULL COMMENT '项目id',\n" +
                                        "  `payment` varchar(255) DEFAULT NULL COMMENT '款额',\n" +
                                        "  `is_payment` varchar(255) DEFAULT NULL COMMENT '可用金额',\n" +
                                        "  `line_no` varchar(255) DEFAULT NULL COMMENT '额度号',\n" +
                                        "  `instructions` varchar(255) DEFAULT NULL COMMENT '用途说明',\n" +
                                        "  `schedule_of` varchar(255) DEFAULT NULL COMMENT '明细表',\n" +
                                        "  `department_head` varchar(255) DEFAULT NULL COMMENT '部门主管意见',\n" +
                                        "  `school_supervisor_opinion` varchar(255) DEFAULT NULL COMMENT '校级主管意见',\n" +
                                        "  `is_opinion` varchar(11) DEFAULT NULL COMMENT '校级主管是否同意（0-同意1不同意）',\n" +
                                        "  `accounting_advice` varchar(255) DEFAULT NULL COMMENT '会计意见',\n" +
                                        "  `is_break_up` varchar(11) DEFAULT NULL COMMENT '是否拆分（0-是1-否）',\n" +
                                        "  `treasurer_signature` varchar(150) DEFAULT NULL COMMENT '财务主管签字',\n" +
                                        "  `treasurer_opinion` varchar(255) DEFAULT NULL COMMENT '财务主管意见',\n" +
                                        "  `break_up_plan` varchar(255) DEFAULT NULL COMMENT '拆分计划',\n" +
                                        "  `headmaster_signature` varchar(150) DEFAULT NULL COMMENT '校长签字',\n" +
                                        "  `headmaster_opinion` varchar(255) DEFAULT NULL COMMENT '校长意见',\n" +
                                        "  `actual_expenditure` varchar(150) DEFAULT NULL COMMENT '实际支出金额',\n" +
                                        "  `amount_words` varchar(150) DEFAULT NULL COMMENT '大写金额',\n" +
                                        "  `cashier_opinion` varchar(255) DEFAULT NULL COMMENT '出纳确认支出意见',\n" +
                                        "  `allow` char(1) NOT NULL DEFAULT '' COMMENT '审批状态(0—待审批,1—已批准,2—未批准)',\n" +
                                        "  `register_ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',\n" +
                                        "  `del_flag` int(1) unsigned zerofill DEFAULT NULL COMMENT '记录是否删除',\n" +
                                        "  `zip_attachment_id` varchar(255) DEFAULT NULL COMMENT '压缩后的附件id',\n" +
                                        "  `zip_attachment_name` varchar(255) DEFAULT NULL COMMENT '压缩后的部门name',\n" +
                                        "  `advance` int(11) DEFAULT '0' COMMENT '预算金额',\n" +
                                        "  `all_advance` int(11) DEFAULT NULL COMMENT '预支出金额',\n" +
                                        "  PRIMARY KEY (`Budget_process_id`) USING BTREE,\n" +
                                        "  UNIQUE KEY `id` (`Budget_process_id`) USING BTREE,\n" +
                                        "  KEY `applicant` (`applicant`) USING BTREE,\n" +
                                        "  KEY `run_id` (`run_id`) USING BTREE,\n" +
                                        "  KEY `allow` (`allow`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='预算执行流程';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_channel_info = Verification.CheckIsExistCms_channel_info(conn, driver, url, username, password, "1");
                            if (checkIsCms_channel_info == false) {
                                String sql = "INSERT INTO `cms_channel_info` VALUES ('1', 'firstnews', '最新要闻', '2018-08-13 10:20:23', '1', 'admin', '0', '3', 'firstnews', '2', '0', '', '1', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_channel_info1 = Verification.CheckIsExistCms_channel_info(conn, driver, url, username, password, "2");
                            if (checkIsCms_channel_info1 == false) {
                                String sql = "INSERT INTO `cms_channel_info` VALUES ('2', 'govermentpub', '政务公开', '2018-08-13 10:19:41', '1', 'admin', '0', '3', 'main1', '2', '0', '', '1', '2', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_channel_info2 = Verification.CheckIsExistCms_channel_info(conn, driver, url, username, password, "3");
                            if (checkIsCms_channel_info2 == false) {
                                String sql = "INSERT INTO `cms_channel_info` VALUES ('3', 'hudong', '政民互动', '2018-08-13 10:21:09', '1', 'admin', '0', '3', 'hotnote', '2', '0', '', '1', '3', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_channel_info3 = Verification.CheckIsExistCms_channel_info(conn, driver, url, username, password, "4");
                            if (checkIsCms_channel_info3 == false) {
                                String sql = "INSERT INTO `cms_channel_info` VALUES ('4', 'fuwu', '政务服务', '2018-08-13 10:21:40', '1', 'admin', '0', '3', 'abortus', '2', '0', '', '1', '4', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_channel_info4 = Verification.CheckIsExistCms_channel_info(conn, driver, url, username, password, "5");
                            if (checkIsCms_channel_info4 == false) {
                                String sql = "INSERT INTO `cms_channel_info` VALUES ('5', 'fagui', '政策法规', '2019-06-04 13:53:15', '1', 'admin', '0', '3', 'fagui', '2', '0', '', '1', '5', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目文档关联表
                             *   添加时间：2019-06-19
                             */
                            boolean cms_chnldoc = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_chnldoc");
                            if (cms_chnldoc == false) {
                                String sql = " CREATE TABLE `cms_chnldoc` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `CHNL_ID` int(11) DEFAULT NULL COMMENT '栏目id',\n" +
                                        "  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `DEL_FLAG` int(11) DEFAULT '0' COMMENT '删除标记',\n" +
                                        "  `DOC_ID` int(11) DEFAULT NULL COMMENT '文档id',\n" +
                                        "  `PATH` varchar(255) DEFAULT NULL COMMENT '路径',\n" +
                                        "  `PUB_TIME` datetime DEFAULT NULL COMMENT '发布时间',\n" +
                                        "  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `TOP_` int(11) DEFAULT NULL COMMENT '置顶标记',\n" +
                                        "  `TYPE` int(11) DEFAULT NULL COMMENT '文档类型',\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='cms栏目文档关联表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_chnldoc）
                     */
                            boolean checkIsCms_chnldoc = Verification.CheckIsExistCms_chnldoc(conn, driver, url, username, password, "1");
                            if (checkIsCms_chnldoc == false) {
                                String sql = "INSERT INTO `cms_chnldoc` VALUES ('1', '2', '2019-06-20 10:00:00', '0', '1', '', null, '1', '0', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_chnldoc1 = Verification.CheckIsExistCms_chnldoc(conn, driver, url, username, password, "2");
                            if (checkIsCms_chnldoc1 == false) {
                                String sql = "INSERT INTO `cms_chnldoc` VALUES ('2', '5', '2019-06-20 10:00:00', '0', '2', null, null, '1', '0', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_chnldoc2 = Verification.CheckIsExistCms_chnldoc(conn, driver, url, username, password, "3");
                            if (checkIsCms_chnldoc2 == false) {
                                String sql = "INSERT INTO `cms_chnldoc` VALUES ('3', '3', '2019-06-20 10:00:00', '0', '3', '', null, '1', '0', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_chnldoc3 = Verification.CheckIsExistCms_chnldoc(conn, driver, url, username, password, "4");
                            if (checkIsCms_chnldoc3 == false) {
                                String sql = "INSERT INTO `cms_chnldoc` VALUES ('4', '4', '2019-06-20 10:00:00', '0', '4', '', null, '1', '0', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_channel_info）
                     */
                            boolean checkIsCms_chnldoc4 = Verification.CheckIsExistCms_chnldoc(conn, driver, url, username, password, "5");
                            if (checkIsCms_chnldoc4 == false) {
                                String sql = "INSERT INTO `cms_chnldoc` VALUES ('5', '1', '2019-06-20 10:00:00', '0', '5', '', null, '1', '0', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目文档关联表
                             *   添加时间：2019-06-19
                             */
                            boolean cms_document_category = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_document_category");
                            if (cms_document_category == false) {
                                String sql = " CREATE TABLE `cms_document_category` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `PRIV_` int(11) DEFAULT NULL,\n" +
                                        "  `CAT_NAME_` varchar(255) DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: cms文档信息表
                             *   添加时间：2019-06-19
                             */
                            boolean cms_document_info = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_document_info");
                            if (cms_document_info == false) {
                                String sql = " CREATE TABLE `cms_document_info` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `ABSTRACTS` varchar(255) DEFAULT NULL COMMENT '摘要',\n" +
                                        "  `AUTHOR` varchar(255) DEFAULT NULL COMMENT '作者',\n" +
                                        "  `CHNL_ID` int(11) DEFAULT NULL COMMENT '栏目id',\n" +
                                        "  `CONTENT` longtext COMMENT '文本内容',\n" +
                                        "  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `CR_USERID` int(11) DEFAULT NULL COMMENT '创建人uid',\n" +
                                        "  `CR_USERNAME` varchar(255) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `DOC_TITLE` varchar(255) DEFAULT NULL COMMENT '文档标题',\n" +
                                        "  `HTML_CONTENT` longtext COMMENT '文档html内容',\n" +
                                        "  `KEY_WORDS` varchar(255) DEFAULT NULL COMMENT '关键字',\n" +
                                        "  `MAIN_TITLE` varchar(255) DEFAULT NULL COMMENT '主标题',\n" +
                                        "  `PUB_TIME` datetime DEFAULT NULL COMMENT '发布时间',\n" +
                                        "  `SOURCE` varchar(255) DEFAULT NULL COMMENT '来源',\n" +
                                        "  `STATUS` int(11) DEFAULT NULL,\n" +
                                        "  `SUB_TITLE` varchar(255) DEFAULT NULL,\n" +
                                        "  `WRITE_TIME` datetime DEFAULT NULL,\n" +
                                        "  `THUMBNAIL_` int(11) DEFAULT '0',\n" +
                                        "  `CATEGORY_` int(11) DEFAULT '0',\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='cms文档信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_document_info）
                     */
                            boolean checkIsCms_document_info = Verification.CheckIsExistCms_document_info(conn, driver, url, username, password, "1");
                            if (checkIsCms_document_info == false) {
                                String sql = "INSERT INTO `cms_document_info` VALUES ('1', '职业技能提升行动方案', '', '2', '总体要求。以新时代中国特色社会主义思想为指导，全面贯彻党的十九大和十九届二中、三中全会精神，把职业技能培训作为保持就业稳定、缓解结构性就业矛盾的关键举措，作为经济转型升级和高质量发展的重要支撑。坚持需求导向，服务经济社会发展，适应人民群众就业创业需要，大力推行终身职业技能培训制度，面向职工、就业重点群体、建档立卡贫困劳动力（以下简称贫困劳动力）等城乡各类劳动者，大规模开展职业技能培训，加快建设知识型、技能型、创新型劳动者大军。', '2019-06-20 10:00:00', '1', '系统管理员', '职业技能提升行动方案（2019—2021年）', '<p>总体要求。以习近平新时代中国特色社会主义思想为指导，全面贯彻党的十九大和十九届二中、三中全会精神，把职业技能培训作为保持就业稳定、缓解结构性就业矛盾的关键举措，作为经济转型升级和高质量发展的重要支撑。坚持需求导向，服务经济社会发展，适应人民群众就业创业需要，大力推行终身职业技能培训制度，面向职工、就业重点群体、建档立卡贫困劳动力（以下简称贫困劳动力）等城乡各类劳动者，大规模开展职业技能培训，加快建设知识型、技能型、创新型劳动者大军。<br/></p>', '职业技能', '职业技能提升行动方案（2019—2021年）', null, '', '1', '职业技能提升行动方案（2019—2021年）', '2019-06-20 10:09:57', '0', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_document_info）
                     */
                            boolean checkIsCms_document_info1 = Verification.CheckIsExistCms_document_info(conn, driver, url, username, password, "2");
                            if (checkIsCms_document_info1 == false) {
                                String sql = "INSERT INTO `cms_document_info` VALUES ('2', '国务院关于在线政务服务的若干规定', '', '5', '为了全面提升政务服务规范化、便利化水平，为企业和群众(以下称行政相对人)提供高效、便捷的政务服务，优化营商环境，制定本规定。    国家加快建设全国一体化在线政务服务平台(以下简称一体化在线平台)，推进各地区、各部门政务服务平台规范化、标准化、集约化建设和互联互通，推动实现政务服务事项全国标准统一、全流程网上办理，促进政务服务跨地区、跨部门、跨层级数据共享和业务协同，并依托一体化在线平台推进政务服务线上线下深度融合。    一体化在线平台由国家政务服务平台、国务院有关部门政务服务平台和各地区政务服务平台组成。', '2019-06-20 10:00:00', '1', '系统管理员', '国务院关于在线政务服务的若干规定', '<p>&nbsp;&nbsp;&nbsp;&nbsp;为了全面提升政务服务规范化、便利化水平，为企业和群众(以下称行政相对人)提供高效、便捷的政务服务，优化营商环境，制定本规定。<br/>&nbsp;&nbsp;&nbsp;&nbsp;国家加快建设全国一体化在线政务服务平台(以下简称一体化在线平台)，推进各地区、各部门政务服务平台规范化、标准化、集约化建设和互联互通，推动实现政务服务事项全国标准统一、全流程网上办理，促进政务服务跨地区、跨部门、跨层级数据共享和业务协同，并依托一体化在线平台推进政务服务线上线下深度融合。<br/>&nbsp;&nbsp;&nbsp;&nbsp;一体化在线平台由国家政务服务平台、国务院有关部门政务服务平台和各地区政务服务平台组成。</p>', '在线政务服务 规定', '国务院关于在线政务服务的若干规定', null, '', '1', '国务院关于在线政务服务的若干规定', '2019-06-19 14:10:56', '0', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_document_info）
                     */
                            boolean checkIsCms_document_info2 = Verification.CheckIsExistCms_document_info(conn, driver, url, username, password, "3");
                            if (checkIsCms_document_info2 == false) {
                                String sql = "INSERT INTO `cms_document_info` VALUES ('3', '建议杨柳树更换树种', '', '3', '建议内容：杨柳絮太多，不戴口罩无法正常外出，本来是一年外出最好的季节，现在杨柳絮漫天飞，还记得几年前蟹岛杨柳絮引起几十辆大巴车着火的事情，真心觉得应该换一些其他树种，希望能够得到政府部门关注答复：亲爱的用户：    城区主要飘的是杨树和柳树两种植物的飞絮。杨树和柳树是北京园林绿化的主要乡土树种，上世纪80年代以前种植，是园林绿化的骨干树种，为生态环境建设做出了卓越贡献。由于历史的原因，飞絮杨柳树现有存量仍然较大，随着树龄年限的增长，这些杨柳树都已进入繁殖成熟期，由此造成了近年来京城春季飞絮的问题。 对于春季大量杨柳飞絮造成的环境问题，园林绿化部门一直在研究探索治理措施，一是在新建项目中杜绝使用杨柳雌株；二是积极开展杨柳树新品种选育，选育既速生又无飞絮的杨柳树优良新品种。三是更新改造树种结构。结合城市建设和农业结构调整中涉及的园林绿化更新改造工程，对现有杨柳树雌株逐步进行改造，伐除杨柳树雌株，减少飞絮总量，替换树种为抗逆性强、色彩丰富、绿期较长的乡土长寿树种。四是在飞絮期间，采取树木适度修剪、高压喷水、地面湿化和及时清扫的方式控制飞絮。五是建议日常生活中做好防护，出行及时佩戴口罩等。 感谢您对我市园林绿化工作的关注和支持。', '2019-06-20 10:00:00', '1', '系统管理员', '建议杨柳树更换树种', '<p>建议内容：<br/><br/></p><p>杨柳絮太多，不戴口罩无法正常外出，本来是一年外出最好的季节，现在杨柳絮漫天飞，还记得几年前蟹岛杨柳絮引起几十辆大巴车着火的事情，真心觉得应该换一些其他树种，希望能够得到政府部门关注</p><p><br/></p><p>答复：<br/><br/>亲爱的用户：<br/>&nbsp;&nbsp;&nbsp;&nbsp;城区主要飘的是杨树和柳树两种植物的飞絮。杨树和柳树是北京园林绿化的主要乡土树种，上世纪80年代以前种植，是园林绿化的骨干树种，为生态环境建设做出了卓越贡献。由于历史的原因，飞絮杨柳树现有存量仍然较大，随着树龄年限的增长，这些杨柳树都已进入繁殖成熟期，由此造成了近年来京城春季飞絮的问题。&nbsp;<br/>对于春季大量杨柳飞絮造成的环境问题，园林绿化部门一直在研究探索治理措施，一是在新建项目中杜绝使用杨柳雌株；二是积极开展杨柳树新品种选育，选育既速生又无飞絮的杨柳树优良新品种。三是更新改造树种结构。结合城市建设和农业结构调整中涉及的园林绿化更新改造工程，对现有杨柳树雌株逐步进行改造，伐除杨柳树雌株，减少飞絮总量，替换树种为抗逆性强、色彩丰富、绿期较长的乡土长寿树种。四是在飞絮期间，采取树木适度修剪、高压喷水、地面湿化和及时清扫的方式控制飞絮。五是建议日常生活中做好防护，出行及时佩戴口罩等。&nbsp;<br/>感谢您对我市园林绿化工作的关注和支持。</p>', '柳絮', '建议杨柳树更换树种', null, '', '1', '建议杨柳树更换树种', '2019-06-19 14:12:40', '0', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_document_info）
                     */
                            boolean checkIsCms_document_info3 = Verification.CheckIsExistCms_document_info(conn, driver, url, username, password, "4");
                            if (checkIsCms_document_info3 == false) {
                                String sql = "INSERT INTO `cms_document_info` VALUES ('4', '我国推行车辆购置税信息联网', '', '4', '目前，群众购车登记需要先到税务网点缴税、开具车辆购置税完税证明纸质凭证，再到车管所办理登记，缴税登记多头往返，不经济、不方便，纸质凭证还存在丢失、污损等风险。    为进一步深化“放管服”改革，在试点基础上，公安部与国家税务总局共同部署全面推行应用车辆购置税电子完税信息办理车辆登记业务，为群众买车缴税、登记上牌提供便捷高效服务。', '2019-06-20 10:00:00', '1', '系统管理员', '我国推行车辆购置税信息联网', '&nbsp;&nbsp;&nbsp;&nbsp;目前，群众购车登记需要先到税务网点缴税、开具车辆购置税完税证明纸质凭证，再到车管所办理登记，缴税登记多头往返，不经济、不方便，纸质凭证还存在丢失、污损等风险。<br/>&nbsp;&nbsp;&nbsp;&nbsp;为进一步深化“放管服”改革，在试点基础上，公安部与国家税务总局共同部署全面推行应用车辆购置税电子完税信息办理车辆登记业务，为群众买车缴税、登记上牌提供便捷高效服务。', '车辆购置税', '我国推行车辆购置税信息联网', null, '', '1', '我国推行车辆购置税信息联网', '2019-06-19 14:13:23', '0', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_document_info）
                     */
                            boolean checkIsCms_document_info4 = Verification.CheckIsExistCms_document_info(conn, driver, url, username, password, "5");
                            if (checkIsCms_document_info4 == false) {
                                String sql = "INSERT INTO `cms_document_info` VALUES ('5', '全国土壤污染防治部际协调小组会议召开', '', '1', '加强土壤污染防治是深入贯彻落实习近平生态文明思想的具体行动，是落实以人民为中心发展思想的内在要求，是打好打胜污染防治攻坚战的重要方面。我们要不断提高政治站位，增强“四个意识”，坚定“四个自信”，做到“两个维护”.    “土十条”实施以来，在党中央、国务院的坚强领导下，在各地区、各部门、各方面的共同努力下，土壤污染调查等基础工作取得重要进展，法规标准体系基本建立，农用地分类管理逐步推进，建设用地准入管理机制基本形成，未污染土壤保护得到强化，污染源监管工作不断加强，土壤污染治理与修复有序推进，科技研发力度不断加大，政府主导的治理体系初步构建，土壤污染防治责任不断夯实，为进一步推进土壤污染防治工作奠定了坚实基础。', '2019-06-20 10:00:00', '1', '系统管理员', '全国土壤污染防治部际协调小组会议召开', '<p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=\\\"color: rgb(64, 64, 64); font-family: &quot;Microsoft YaHei&quot;, SimSun; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\\\">加强土壤污染防治是深入贯彻落实习近平生态文明思想的具体行动，是落实以人民为中心发展思想的内在要求，是打好打胜污染防治攻坚战的重要方面。我们要不断提高政治站位，增强“四个意识”，坚定“四个自信”，做到“两个维护”.</span></p><p><span style=\\\"color: rgb(64, 64, 64); font-family: &quot;Microsoft YaHei&quot;, SimSun; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\\\">&nbsp;&nbsp;&nbsp;&nbsp;<span style=\\\"color: rgb(64, 64, 64); font-family: &quot;Microsoft YaHei&quot;, SimSun; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\\\">“土十条”实施以来，在党中央、国务院的坚强领导下，在各地区、各部门、各方面的共同努力下，土壤污染调查等基础工作取得重要进展，法规标准体系基本建立，农用地分类管理逐步推进，建设用地准入管理机制基本形成，未污染土壤保护得到强化，污染源监管工作不断加强，土壤污染治理与修复有序推进，科技研发力度不断加大，政府主导的治理体系初步构建，土壤污染防治责任不断夯实，为进一步推进土壤污染防治工作奠定了坚实基础。</span></span></p>', '土壤污染防治', '全国土壤污染防治部际协调小组会议召开', null, '', '1', '全国土壤污染防治部际协调小组会议召开', '2019-06-19 14:17:59', '0', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目文档关联表
                             *   添加时间：2019-06-19
                             */
                            boolean cms_site_info = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_site_info");
                            if (cms_site_info == false) {
                                String sql = " CREATE TABLE `cms_site_info` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',\n" +
                                        "  `CR_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `CR_USERID` int(11) DEFAULT NULL COMMENT '创建人uid',\n" +
                                        "  `CR_USERNAME` varchar(255) DEFAULT NULL COMMENT '创建人userid',\n" +
                                        "  `DETAIL_TPL` int(11) DEFAULT NULL COMMENT '细则模板',\n" +
                                        "  `FOLDER` varchar(255) DEFAULT NULL COMMENT '存储位置',\n" +
                                        "  `INDEX_TPL` int(11) DEFAULT NULL COMMENT '首页模板',\n" +
                                        "  `PUB_PATH` varchar(255) DEFAULT NULL COMMENT '发布地址',\n" +
                                        "  `PUB_STATUS` int(11) DEFAULT NULL COMMENT '发布状态',\n" +
                                        "  `SITE_IDENTITY` varchar(255) DEFAULT NULL COMMENT '站点标识',\n" +
                                        "  `SITE_NAME` varchar(255) DEFAULT NULL COMMENT '站点名称',\n" +
                                        "  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `PUB_FILE_EXT` varchar(255) DEFAULT 'html' COMMENT '发布文件后缀名',\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                         /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_site_info）
                     */
                            boolean checkIsCms_site_info = Verification.CheckIsExistCms_site_info(conn, driver, url, username, password, "1");
                            if (checkIsCms_site_info == false) {
                                String sql = "INSERT INTO `cms_site_info` VALUES ('1', '2019-06-20 10:00:00', '1', '系统管理员', '10', '', '1', null, '1', 'government', '滨海市政务门户', '1', 'html');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: cms栏目文档关联表
                             *   添加时间：2019-06-19
                             */
                            boolean cms_site_template = Verification.CheckIsExistTable(conn, driver, url, username, password, "cms_site_template");
                            if (cms_site_template == false) {
                                String sql = " CREATE TABLE `cms_site_template` (\n" +
                                        "  `SID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `SITE_ID` int(11) DEFAULT NULL,\n" +
                                        "  `TPL_DESC` varchar(255) DEFAULT NULL COMMENT '模板描述',\n" +
                                        "  `TPL_FILE_NAME` varchar(255) DEFAULT NULL COMMENT '模板文件名称',\n" +
                                        "  `TPL_NAME` varchar(255) DEFAULT NULL COMMENT '模板名称',\n" +
                                        "  PRIMARY KEY (`SID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_site_template）
                     */
                            boolean cms_site_template3 = Verification.CheckIsExistCms_site_template(conn, driver, url, username, password, "1");
                            if (cms_site_template3 == false) {
                                String sql = "INSERT INTO `cms_site_template` VALUES ('1', '1', '首页概览', 'index.html', '门户首页');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_site_template）
                     */
                            boolean cms_site_template1 = Verification.CheckIsExistCms_site_template(conn, driver, url, username, password, "2");
                            if (cms_site_template1 == false) {
                                String sql = "INSERT INTO `cms_site_template` VALUES ('2', '1', '栏目模板', 'newsIndex.html', '栏目模板');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                          /*    *
                        张丽军
                        2019-6-19
                     *  作用: 添加数据（cms_site_template）
                     */
                            boolean cms_site_template2 = Verification.CheckIsExistCms_site_template(conn, driver, url, username, password, "3");
                            if (cms_site_template2 == false) {
                                String sql = "INSERT INTO `cms_site_template` VALUES ('3', '1', '文章详情', 'detail.html', '文章详情');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: 供应商管理表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_supplier = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_supplier");
                            if (crm_supplier == false) {
                                String sql = " CREATE TABLE `crm_supplier` (\n" +
                                        "  `SUPPLIER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商管理表唯一自增主键',\n" +
                                        "  `SUPPLIER_NAME` varchar(100) NOT NULL COMMENT '供应商名称',\n" +
                                        "  `PHONE` varchar(40) DEFAULT NULL COMMENT '供应商电话',\n" +
                                        "  `FAX` varchar(40) DEFAULT NULL COMMENT '传真号码',\n" +
                                        "  `WEBSITE` varchar(100) DEFAULT NULL COMMENT '供应商网址',\n" +
                                        "  `ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '邮政编码',\n" +
                                        "  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子邮箱',\n" +
                                        "  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '供应商地址',\n" +
                                        "  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',\n" +
                                        "  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',\n" +
                                        "  `REGISTER_BANK` varchar(100) DEFAULT NULL COMMENT '开户行',\n" +
                                        "  `BANK_ACCOUNT` varchar(100) DEFAULT NULL COMMENT '银行账号',\n" +
                                        "  `ACCOUNT_NAME` varchar(100) DEFAULT NULL COMMENT '户名',\n" +
                                        "  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`SUPPLIER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: 销售合同表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_contract = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_contract");
                            if (crm_contract == false) {
                                String sql = " CREATE TABLE `crm_contract` (\n" +
                                        "  `CONTRACT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售合同表唯一自增主键',\n" +
                                        "  `CONTRACT_NO` varchar(40) DEFAULT NULL COMMENT '合同编号',\n" +
                                        "  `CONTRACT_NAME` varchar(40) NOT NULL COMMENT '合同名称',\n" +
                                        "  `CUSTOMER_ID` int(11) unsigned DEFAULT NULL COMMENT '所属客户，关联客户信息表主键',\n" +
                                        "  `TYPE` char(10) DEFAULT NULL COMMENT '合同类型|系统代码表：01-产品销售；02-服务；03-合作；04-代理；05-其他；',\n" +
                                        "  `STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '合同状态：0-执行中;1-结束;2-意外终止;',\n" +
                                        "  `TOTAL` decimal(10,0) DEFAULT NULL COMMENT '总金额',\n" +
                                        "  `TOTAL_CAPS` varchar(40) DEFAULT NULL COMMENT '总金额大写',\n" +
                                        "  `RECEIVED_MONEY` decimal(10,0) DEFAULT NULL COMMENT '已收款',\n" +
                                        "  `PAY_WAY` char(10) DEFAULT NULL COMMENT '支付方式|系统代码表：01-现金；02-转账；03-支票；04-支付宝；05-微信；06-其他；',\n" +
                                        "  `START_TIME` datetime DEFAULT NULL COMMENT '开始时间',\n" +
                                        "  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',\n" +
                                        "  `VALID_TIME` datetime DEFAULT NULL COMMENT '合同有效期',\n" +
                                        "  `REMIND_EXPIRE` tinyint(3) unsigned DEFAULT NULL COMMENT '到期事务提醒：0-否；1-是；',\n" +
                                        "  `REMIND_EXPIRE_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '到期短信提醒：0-否；1-是；',\n" +
                                        "  `RECIEVE_TIME` datetime DEFAULT NULL COMMENT '收款时间',\n" +
                                        "  `DELIVER_TIME` datetime DEFAULT NULL COMMENT '交付时间',\n" +
                                        "  `REMIND_RECIEVE` tinyint(3) unsigned DEFAULT NULL COMMENT '收款事务提醒：0-否；1-是；',\n" +
                                        "  `REMIND_RECIEVE_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '收款短信提醒：0-否；1-是；',\n" +
                                        "  `REMIND_DELIVER` tinyint(3) unsigned DEFAULT NULL COMMENT '交付事务提醒：0-否；1-是；',\n" +
                                        "  `REMIND_DELIVER_SMS` tinyint(3) unsigned DEFAULT NULL COMMENT '交付短信提醒：0-否；1-是；',\n" +
                                        "  `CONTENT` varchar(1000) DEFAULT NULL COMMENT '合同内容',\n" +
                                        "  `FIST_PARTY_SIGN_TIME` datetime DEFAULT NULL COMMENT '甲方签约时间',\n" +
                                        "  `FIST_PARTY` varchar(40) DEFAULT NULL COMMENT '甲方',\n" +
                                        "  `SECOND_PARTY_SIGN_TIME` datetime DEFAULT NULL COMMENT '乙方签约时间',\n" +
                                        "  `SECOND_PARTY` varchar(40) DEFAULT NULL COMMENT '乙方',\n" +
                                        "  `ITEM` varchar(100) DEFAULT NULL COMMENT '项目，关联项目模块',\n" +
                                        "  `APPROVAL_STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '审批状态：0-待审批;1-已通过;2-已驳回;',\n" +
                                        "  `APPROVAL_USER` varchar(40) DEFAULT NULL COMMENT '审批人 userId',\n" +
                                        "  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审批时间',\n" +
                                        "  `APPROVAL_ADVICE` varchar(500) DEFAULT NULL COMMENT '审批意见',\n" +
                                        "  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(    3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`CONTRACT_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: 客户信息表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_customer = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_customer");
                            if (crm_customer == false) {
                                String sql = " CREATE TABLE `crm_customer` (\n" +
                                        "  `CUSTOMER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户信息表唯一自增主键',\n" +
                                        "  `CUSTOMER_NO` varchar(100) DEFAULT NULL COMMENT '客户编号',\n" +
                                        "  `CUSTOMER_NAME` varchar(100) NOT NULL COMMENT '客户名称',\n" +
                                        "  `CUSTOMER_MANAGER` varchar(40) DEFAULT NULL COMMENT '客户经理',\n" +
                                        "  `CUSTOMER_TYPE` char(10) DEFAULT NULL COMMENT '客户类型|系统代码表：\\r\\n1 潜在客户 2正式客户 3重要客户\\r\\n',\n" +
                                        "  `CUSTOMER_STATUS` char(10) DEFAULT NULL COMMENT '客户状态|系统代码表：\\r\\n01初步接触 02客户拜访 03需求沟通  04方案报价  05 商务谈判 06签约成功06业务暂缓\\r\\n',\n" +
                                        "  `CUSTOMER_FROM` char(10) DEFAULT NULL COMMENT '客户来源|系统代码表：\\r\\n01广告推广 02会议营销 03客户介绍 04网上搜索 05渠道拓展 06伙伴介绍 07独立开发 08社群营销\\r\\n',\n" +
                                        "  `CUSTOMER_LEVEL` char(10) DEFAULT NULL COMMENT '客户级别|系统代码表：\\r\\n01 A类重要客户  02 B类普通客户  03 C类一般客户 04  D类不重要客户\\r\\n',\n" +
                                        "  `CUSTOMER_INDUSTRY` char(10) DEFAULT NULL COMMENT '客户行业|系统代码表：\\r\\n01 农、林、牧、渔业 02 采矿业 03 制造业 04 电力、燃气及水的生产和供应业 05 建筑业 06 交通运输、仓储和邮政业 07 信息传输、计算机服务和软件业 08 批发和零售业 09 住宿和餐饮业 10 金融业 11 房地产业 12 租赁和商务服务业 13 科学研究、技术服务和地质勘查业 14 水利、环境和公共设施管理业 15 居民服务和其他服务业 \\r\\n16 教育 17 卫生和社会工作 18 文化、体育和娱乐业 19 公共管理、社会保障和社会组织 20 国际组织 21 政务机关、事业单位\\r\\n',\n" +
                                        "  `LEGAL_PERSON` varchar(40) DEFAULT NULL COMMENT '企业法人',\n" +
                                        "  `SCALE` char(10) DEFAULT NULL COMMENT '公司规模|系统代码表：\\r\\n01微型(10人以下) 02小型(10-100人) 03中型(500-1000人) 04中小型(100-500人) 05大型(1000人以上)\\r\\n',\n" +
                                        "  `ANNUAL_SALES` varchar(50) DEFAULT NULL COMMENT '年销售额',\n" +
                                        "  `INTRODUCTION` text COMMENT '企业介绍',\n" +
                                        "  `EXPECT_PRICE` varchar(50) DEFAULT NULL COMMENT '预计成交金额',\n" +
                                        "  `EXPECT_TIME` datetime DEFAULT NULL COMMENT '预计成交日期',\n" +
                                        "  `FAX` varchar(200) DEFAULT NULL COMMENT '传真号码',\n" +
                                        "  `WEBSITE` varchar(200) DEFAULT NULL COMMENT '公司网址',\n" +
                                        "  `ZIP_CODE` varchar(50) DEFAULT NULL COMMENT '邮政编码',\n" +
                                        "  `EMAIL` varchar(200) DEFAULT NULL COMMENT '电子邮箱',\n" +
                                        "  `ADDRESS` varchar(200) DEFAULT NULL COMMENT '公司地址',\n" +
                                        "  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',\n" +
                                        "  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',\n" +
                                        "  `LNG` varchar(20) DEFAULT NULL COMMENT '经度，用于地图选点',\n" +
                                        "  `LAT` varchar(20) DEFAULT NULL COMMENT '纬度，用于地图选点',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATED_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` char(10) DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` text COMMENT '允许查看人员：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`CUSTOMER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: 客户跟进表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_follow = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_follow");
                            if (crm_follow == false) {
                                String sql = " CREATE TABLE `crm_follow` (\n" +
                                        "  `FOLLOW_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户跟进表唯一自增主键',\n" +
                                        "  `FOLLOW_NO` varchar(100) DEFAULT NULL COMMENT '客户跟进编号',\n" +
                                        "  `CUSTOMER_ID` int(11) unsigned NOT NULL COMMENT '客户id，关联客户信息表主键',\n" +
                                        "  `FOLLOW_TYPE` char(10) DEFAULT NULL COMMENT '跟进方式|系统代码表:01-电话；02-短信；03-微信；04-QQ；05-会面；',\n" +
                                        "  `FOLLOW_TIME` datetime DEFAULT NULL COMMENT '跟进时间',\n" +
                                        "  `FOLLOW_SITUATION` varchar(500) DEFAULT NULL COMMENT '跟进情况',\n" +
                                        "  `PICTURE` varchar(200) DEFAULT NULL COMMENT '跟进图片',\n" +
                                        "  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '跟进地点',\n" +
                                        "  `LNG` varchar(20) DEFAULT NULL COMMENT '经度，用于地图选点',\n" +
                                        "  `LAT` varchar(20) DEFAULT NULL COMMENT '纬度，用于地图选点',\n" +
                                        "  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',\n" +
                                        "  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',\n" +
                                        "  `FEEDBACK` varchar(500) DEFAULT NULL COMMENT '需求反馈',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`FOLLOW_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: 客户联系人表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_linkman = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_linkman");
                            if (crm_linkman == false) {
                                String sql = " CREATE TABLE `crm_linkman` (\n" +
                                        "  `LINKMAN_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '客户联系人表唯一自增主键',\n" +
                                        "  `LINKMAN_NAME` varchar(20) NOT NULL COMMENT '联系人姓名',\n" +
                                        "  `CUSTOMER_ID` int(11) DEFAULT NULL COMMENT '所属客户，关联客户信息表主键',\n" +
                                        "  `IS_MAJOR` tinyint(3) unsigned DEFAULT NULL COMMENT '是否主联系人：0-否；1-是；',\n" +
                                        "  `JOB` varchar(20) DEFAULT NULL COMMENT '联系人职务',\n" +
                                        "  `DEPARTMENT` varchar(20) DEFAULT NULL COMMENT '联系人部门',\n" +
                                        "  `SEX` tinyint(3) unsigned DEFAULT '0' COMMENT '联系人性别：0-未知;1-男;2-女;(默认未知)',\n" +
                                        "  `CALL` varchar(20) DEFAULT NULL COMMENT '联系人称呼',\n" +
                                        "  `TITLE` varchar(40) DEFAULT NULL COMMENT '联系人头衔',\n" +
                                        "  `HOBBY` varchar(200) DEFAULT NULL COMMENT '联系人爱好',\n" +
                                        "  `BIRTHDAY` datetime DEFAULT NULL COMMENT '联系人出生日期',\n" +
                                        "  `FIRST_CONTACT` char(10) DEFAULT NULL COMMENT '首选联系方式|系统代码表：\\r\\n01电话联系 02邮件联系 03微信联系 04 QQ联系 05短信联系\\r\\n',\n" +
                                        "  `MOBILE` varchar(20) DEFAULT NULL COMMENT '联系人手机',\n" +
                                        "  `EMAIL` varchar(40) DEFAULT NULL COMMENT '联系人邮箱',\n" +
                                        "  `WECHAT` varchar(40) DEFAULT NULL COMMENT '联系人微信',\n" +
                                        "  `QQ` varchar(20) DEFAULT NULL COMMENT '联系人qq',\n" +
                                        "  `COMPANY_PHONE` varchar(20) DEFAULT NULL COMMENT '联系人公司电话',\n" +
                                        "  `FAMILY_PHONE` varchar(20) DEFAULT NULL COMMENT '联系人家庭电话',\n" +
                                        "  `COMPANY_ADDRESS` varchar(100) DEFAULT NULL COMMENT '联系人公司地址',\n" +
                                        "  `FAMILY_ADDRESS` varchar(100) DEFAULT NULL COMMENT '联系人家庭住址',\n" +
                                        "  `COMPANY_ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '联系人公司邮编',\n" +
                                        "  `FAMILY_ZIP_CODE` varchar(20) DEFAULT NULL COMMENT '联系人家庭邮编',\n" +
                                        "  `RELATIONSHIP` varchar(40) DEFAULT NULL COMMENT '角色关系',\n" +
                                        "  `FRIENDSHIP` varchar(20) DEFAULT NULL COMMENT '亲密程度',\n" +
                                        "  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `PHOTO` varchar(200) DEFAULT NULL COMMENT '照片',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`LINKMAN_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: 销售订单表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_order = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_order");
                            if (crm_order == false) {
                                String sql = " CREATE TABLE `crm_order` (\n" +
                                        "  `ORDER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '销售订单表唯一自增主键',\n" +
                                        "  `ORDER_NO` varchar(40) DEFAULT NULL COMMENT '订单编号',\n" +
                                        "  `CUSTOMER_ID` int(11) unsigned DEFAULT NULL COMMENT '客户ID，关联客户信息表主键',\n" +
                                        "  `ORDER_NAME` varchar(40) NOT NULL COMMENT '订单名称',\n" +
                                        "  `STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '订单状态：0-下单;1-发货;2-完成;',\n" +
                                        "  `TYPE` tinyint(3) unsigned DEFAULT NULL COMMENT '订单类型：0-订货单;1-发货单;2-收货单;',\n" +
                                        "  `TOTAL` decimal(10,0) DEFAULT NULL COMMENT '订单总金额',\n" +
                                        "  `MONETARY_UNIT` char(10) DEFAULT NULL COMMENT '货币单位|系统代码表：01-人民币；02-美元；03-欧元；04-英镑；05-日元；06-港币；07-台币；08-新加坡币；',\n" +
                                        "  `PAY_WAY` char(10) DEFAULT NULL COMMENT '付款方式|系统代码表：01-现金；02-转账；03-支票；04-支付宝；05-微信；06-其他；',\n" +
                                        "  `ORDER_TIME` datetime DEFAULT NULL COMMENT '下单时间',\n" +
                                        "  `FINISH_TIME` datetime DEFAULT NULL COMMENT '结单时间',\n" +
                                        "  `ITEM` varchar(100) DEFAULT NULL COMMENT '项目，关联项目模块',\n" +
                                        "  `CONTRACT_ID` int(11) unsigned DEFAULT NULL COMMENT '合同ID，关联销售合同表主键',\n" +
                                        "  `APPROVAL_STATUS` tinyint(3) unsigned DEFAULT NULL COMMENT '审批状态：0-待审批;1-已通过;2-已驳回;',\n" +
                                        "  `APPROVAL_USER` varchar(40) DEFAULT NULL COMMENT '审批人 userId',\n" +
                                        "  `APPROVAL_TIME` datetime DEFAULT NULL COMMENT '审批时间',\n" +
                                        "  `APPROVAL_ADVICE` varchar(500) DEFAULT NULL COMMENT '审批意见',\n" +
                                        "  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId：当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  `PRODUCT_ID` int(11) DEFAULT NULL COMMENT '产品id',\n" +
                                        "  PRIMARY KEY (`ORDER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /**  创建者：  张丽军
                             *   添加表的作用: 产品信息表
                             *   添加时间：2019-06-19
                             */
                            boolean crm_product = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_product");
                            if (crm_product == false) {
                                String sql = " CREATE TABLE `crm_product` (\n" +
                                        "  `PRODUCT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '产品信息表[唯一自增主键]',\n" +
                                        "  `PRODUCT_NAME` varchar(40) NOT NULL COMMENT '产品名称',\n" +
                                        "  `SUPPLIER_ID` int(11) unsigned DEFAULT NULL COMMENT '产品供应商表[关联供应商管理表主键]',\n" +
                                        "  `TYPE` varchar(40) DEFAULT NULL COMMENT '产品类型',\n" +
                                        "  `COST` decimal(10,2) DEFAULT NULL COMMENT '成本价',\n" +
                                        "  `PRICE` decimal(10,2) DEFAULT NULL COMMENT '销售价',\n" +
                                        "  `METERING_UNIT` char(10) DEFAULT NULL COMMENT '计量单位',\n" +
                                        "  `MONETARY_UNIT` char(10) DEFAULT NULL COMMENT '货币单位|系统代码表：01-人民币；02-美元；03-欧元；04-英镑；05-日元；06-港币；07-台币；08-新加坡币；',\n" +
                                        "  `STOCK` int(11) DEFAULT NULL COMMENT '产品库存',\n" +
                                        "  `SPECIFICATION` varchar(40) DEFAULT NULL COMMENT '规格型号',\n" +
                                        "  `REMARK` varchar(500) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `PHOTO` varchar(200) DEFAULT NULL COMMENT '照片',\n" +
                                        "  `ATTACHMENT_ID` varchar(200) DEFAULT NULL COMMENT '附件 id',\n" +
                                        "  `ATTACHMENT_NAME` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `IS_DELETED` tinyint(3) unsigned DEFAULT '0' COMMENT '删除标志：1-已删除;0-未删除(默认未删除)',\n" +
                                        "  `DELETE_USER` varchar(40) DEFAULT NULL COMMENT '删除人 userId',\n" +
                                        "  `DELETE_TIME` datetime DEFAULT NULL COMMENT '删除时间',\n" +
                                        "  `CREATOR` varchar(40) DEFAULT NULL COMMENT '创建人userId',\n" +
                                        "  `UPDATOR` varchar(40) DEFAULT NULL COMMENT '更新人userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `VIEW_PRIV` tinyint(3) unsigned DEFAULT '0' COMMENT '查看权限：默认0表示仅本人，1表示全部，2表示指定范围人员',\n" +
                                        "  `VIEW_USER` varchar(1000) DEFAULT NULL COMMENT '允许查看人员userId，当 VIEW_PRIV=2时，设置本字段，为用户ID的逗号分隔串',\n" +
                                        "  PRIMARY KEY (`PRODUCT_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='产品信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            /*    * 2019-6-19
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionR = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2204");
                            if (isExistFunctionR == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2204', '7504', '供应商管理', NULL, NULL, NULL, NULL, NULL, '/supplier/showSupplier', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*    * 2019-6-19
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionR1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2205");
                            if (isExistFunctionR1 == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2205', '7505', '客户合同管理', NULL, NULL, NULL, NULL, NULL, '/crmContract/index', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-19
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionR2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2203");
                            if (isExistFunctionR2 == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2203', '7503', '产品管理', NULL, NULL, NULL, NULL, NULL, '/product/showProduct', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-19
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionR3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2201");
                            if (isExistFunctionR3 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2201', '7501', '销售工作台', NULL, NULL, NULL, NULL, NULL, '/customer/salesWorkbench', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-6-19
                             *  添加字段的作用: 添加菜单
                             */
                            boolean isExistFunctionR4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2202");
                            if (isExistFunctionR4 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2202', '7502', '订单管理', NULL, NULL, NULL, NULL, NULL, '/order/orderIndex', '', '0', '0', NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用: 添加客户合同
                             */
                            boolean isExistCodeR = Verification.CheckIsExistCode(conn, driver, url, username, password, "HR_STAFF_CONTRACT2", "");
                            if (isExistCodeR == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('HR_STAFF_CONTRACT2', '合同类型', NULL, NULL, NULL, NULL, NULL, NULL, '100', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "HR_STAFF_CONTRACT2");
                            if (isExistCodeR1 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '产品销售', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'HR_STAFF_CONTRACT2', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR2 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "HR_STAFF_CONTRACT2");
                            if (isExistCodeR2 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '业务销售', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'HR_STAFF_CONTRACT2', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR3 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "HR_STAFF_CONTRACT2");
                            if (isExistCodeR3 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '售后服务', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'HR_STAFF_CONTRACT2', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR4 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "HR_STAFF_CONTRACT2");
                            if (isExistCodeR4 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '代理分销', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'HR_STAFF_CONTRACT2', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR5 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "HR_STAFF_CONTRACT2");
                            if (isExistCodeR5 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '其他', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'HR_STAFF_CONTRACT2', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR6 = Verification.CheckIsExistCode(conn, driver, url, username, password, "CUSTOMER_STATUS", "");
                            if (isExistCodeR6 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('CUSTOMER_STATUS', '客户状态', NULL, NULL, NULL, NULL, NULL, NULL, '08', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR7 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "CUSTOMER_STATUS");
                            if (isExistCodeR7 == false) {
                                String sql = "INSERT INTO `sys_code` ( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '初步接触', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR8 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "CUSTOMER_STATUS");
                            if (isExistCodeR8 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '客户拜访', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR9 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "CUSTOMER_STATUS");
                            if (isExistCodeR9 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '需求沟通', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR10 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "CUSTOMER_STATUS");
                            if (isExistCodeR10 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '方案报价', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR11 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "CUSTOMER_STATUS");
                            if (isExistCodeR11 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '商务谈判', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR12 = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "CUSTOMER_STATUS");
                            if (isExistCodeR12 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '签约成功', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'CUSTOMER_STATUS', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR13 = Verification.CheckIsExistCode(conn, driver, url, username, password, "CUSTOMERSOURCE", "");
                            if (isExistCodeR13 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('CUSTOMERSOURCE', '客户来源', NULL, NULL, NULL, NULL, NULL, NULL, '09', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR14 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "CUSTOMERSOURCE");
                            if (isExistCodeR14 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '广告推广', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR15 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "CUSTOMERSOURCE");
                            if (isExistCodeR15 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '会议营销', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR16 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "CUSTOMERSOURCE");
                            if (isExistCodeR16 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '客户介绍', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR17 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "CUSTOMERSOURCE");
                            if (isExistCodeR17 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '网上搜索', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR18 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "CUSTOMERSOURCE");
                            if (isExistCodeR18 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '渠道拓展', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR19 = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "CUSTOMERSOURCE");
                            if (isExistCodeR19 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '伙伴介绍', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR20 = Verification.CheckIsExistCode(conn, driver, url, username, password, "07", "CUSTOMERSOURCE");
                            if (isExistCodeR20 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('07', '独立开发', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR21 = Verification.CheckIsExistCode(conn, driver, url, username, password, "08", "CUSTOMERSOURCE");
                            if (isExistCodeR21 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('08', '社群营销', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'CUSTOMERSOURCE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR22 = Verification.CheckIsExistCode(conn, driver, url, username, password, "CUSTOMERLEVEL", "");
                            if (isExistCodeR22 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('CUSTOMERLEVEL', '客户级别', NULL, NULL, NULL, NULL, NULL, NULL, '07', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR23 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "CUSTOMERLEVEL");
                            if (isExistCodeR23 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', 'A(重要客户)', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'CUSTOMERLEVEL', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR24 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "CUSTOMERLEVEL");
                            if (isExistCodeR24 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', 'B(普通客户)', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'CUSTOMERLEVEL', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR25 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "CUSTOMERLEVEL");
                            if (isExistCodeR25 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', 'C(一般客户)', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'CUSTOMERLEVEL', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR26 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "CUSTOMERLEVEL");
                            if (isExistCodeR26 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', 'D(不重要客户)', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'CUSTOMERLEVEL', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR27 = Verification.CheckIsExistCode(conn, driver, url, username, password, "CUSTOMERINDUSTRY", "");
                            if (isExistCodeR27 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('CUSTOMERINDUSTRY', '客户行业', NULL, NULL, NULL, NULL, NULL, NULL, '11', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR28 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "CUSTOMERINDUSTRY");
                            if (isExistCodeR28 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '农、林、牧、渔业', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR29 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "CUSTOMERINDUSTRY");
                            if (isExistCodeR29 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '采矿业', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR30 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "CUSTOMERINDUSTRY");
                            if (isExistCodeR30 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '制造业', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR31 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "CUSTOMERINDUSTRY");
                            if (isExistCodeR31 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '电力、燃气及水的生产和供应业', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR32 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "CUSTOMERINDUSTRY");
                            if (isExistCodeR32 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '建筑业', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR33 = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "CUSTOMERINDUSTRY");
                            if (isExistCodeR33 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '交通运输、仓储和邮政业', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR34 = Verification.CheckIsExistCode(conn, driver, url, username, password, "07", "CUSTOMERINDUSTRY");
                            if (isExistCodeR34 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('07', '信息传输、计算机服务和软件业', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR35 = Verification.CheckIsExistCode(conn, driver, url, username, password, "08", "CUSTOMERINDUSTRY");
                            if (isExistCodeR35 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('08', '批发和零售业', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR36 = Verification.CheckIsExistCode(conn, driver, url, username, password, "09", "CUSTOMERINDUSTRY");
                            if (isExistCodeR36 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('09', '住宿和餐饮业', NULL, NULL, NULL, NULL, NULL, NULL, '09', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR37 = Verification.CheckIsExistCode(conn, driver, url, username, password, "10", "CUSTOMERINDUSTRY");
                            if (isExistCodeR37 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('10', '金融业', NULL, NULL, NULL, NULL, NULL, NULL, '10', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR38 = Verification.CheckIsExistCode(conn, driver, url, username, password, "11", "CUSTOMERINDUSTRY");
                            if (isExistCodeR38 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('11', '房地产业', NULL, NULL, NULL, NULL, NULL, NULL, '11', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR39 = Verification.CheckIsExistCode(conn, driver, url, username, password, "12", "CUSTOMERINDUSTRY");
                            if (isExistCodeR39 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('12', '租赁和商务服务业', NULL, NULL, NULL, NULL, NULL, NULL, '12', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR40 = Verification.CheckIsExistCode(conn, driver, url, username, password, "13", "CUSTOMERINDUSTRY");
                            if (isExistCodeR40 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('13', '科学研究、技术服务和地质勘查业', NULL, NULL, NULL, NULL, NULL, NULL, '13', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR41 = Verification.CheckIsExistCode(conn, driver, url, username, password, "14", "CUSTOMERINDUSTRY");
                            if (isExistCodeR41 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('14', '水利、环境和公共设施管理业', NULL, NULL, NULL, NULL, NULL, NULL, '14', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR42 = Verification.CheckIsExistCode(conn, driver, url, username, password, "15", "CUSTOMERINDUSTRY");
                            if (isExistCodeR42 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('15', '居民服务和其他服务业', NULL, NULL, NULL, NULL, NULL, NULL, '15', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR43 = Verification.CheckIsExistCode(conn, driver, url, username, password, "16", "CUSTOMERINDUSTRY");
                            if (isExistCodeR43 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('16', '教育', NULL, NULL, NULL, NULL, NULL, NULL, '16', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR44 = Verification.CheckIsExistCode(conn, driver, url, username, password, "17", "CUSTOMERINDUSTRY");
                            if (isExistCodeR44 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('17', '卫生和社会工作', NULL, NULL, NULL, NULL, NULL, NULL, '17', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR45 = Verification.CheckIsExistCode(conn, driver, url, username, password, "18", "CUSTOMERINDUSTRY");
                            if (isExistCodeR45 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('18', '文化、体育和娱乐业', NULL, NULL, NULL, NULL, NULL, NULL, '18', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR46 = Verification.CheckIsExistCode(conn, driver, url, username, password, "19", "CUSTOMERINDUSTRY");
                            if (isExistCodeR46 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('19', '公共管理、社会保障和社会组织', NULL, NULL, NULL, NULL, NULL, NULL, '19', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR47 = Verification.CheckIsExistCode(conn, driver, url, username, password, "20", "CUSTOMERINDUSTRY");
                            if (isExistCodeR47 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('20', '国际组织', NULL, NULL, NULL, NULL, NULL, NULL, '20', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR48 = Verification.CheckIsExistCode(conn, driver, url, username, password, "21", "CUSTOMERINDUSTRY");
                            if (isExistCodeR48 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('21', '政务机关、事业单位', NULL, NULL, NULL, NULL, NULL, NULL, '21', 'CUSTOMERINDUSTRY', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR49 = Verification.CheckIsExistCode(conn, driver, url, username, password, "MONETARYUNIT", "");
                            if (isExistCodeR49 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('MONETARYUNIT', '货币单位', NULL, NULL, NULL, NULL, NULL, NULL, '13', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR50 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "MONETARYUNIT");
                            if (isExistCodeR50 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '人民币', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR51 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "MONETARYUNIT");
                            if (isExistCodeR51 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '美元', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR52 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "MONETARYUNIT");
                            if (isExistCodeR52 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '欧元', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR53 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "MONETARYUNIT");
                            if (isExistCodeR53 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '英镑', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR54 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "MONETARYUNIT");
                            if (isExistCodeR54 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '日元', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR55 = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "MONETARYUNIT");
                            if (isExistCodeR55 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '港币', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR56 = Verification.CheckIsExistCode(conn, driver, url, username, password, "07", "MONETARYUNIT");
                            if (isExistCodeR56 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('07', '台币', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR57 = Verification.CheckIsExistCode(conn, driver, url, username, password, "08", "MONETARYUNIT");
                            if (isExistCodeR57 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('08', '新加坡币', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'MONETARYUNIT', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR58 = Verification.CheckIsExistCode(conn, driver, url, username, password, "PAYMENTMETHOD", "");
                            if (isExistCodeR58 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('PAYMENTMETHOD', '付款方式', NULL, NULL, NULL, NULL, NULL, NULL, '12', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR59 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "PAYMENTMETHOD");
                            if (isExistCodeR59 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '现金', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR60 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "PAYMENTMETHOD");
                            if (isExistCodeR60 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '转账', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR61 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "PAYMENTMETHOD");
                            if (isExistCodeR61 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '支票', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR62 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "PAYMENTMETHOD");
                            if (isExistCodeR62 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', '支付宝', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR63 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "PAYMENTMETHOD");
                            if (isExistCodeR63 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '微信', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR64 = Verification.CheckIsExistCode(conn, driver, url, username, password, "06", "PAYMENTMETHOD");
                            if (isExistCodeR64 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('06', '其他', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'PAYMENTMETHOD', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR65 = Verification.CheckIsExistCode(conn, driver, url, username, password, "FOLLOWUPMODE", "");
                            if (isExistCodeR65 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('FOLLOWUPMODE', '跟进方式', NULL, NULL, NULL, NULL, NULL, NULL, '10', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR66 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "FOLLOWUPMODE");
                            if (isExistCodeR66 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '电话', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'FOLLOWUPMODE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR67 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "FOLLOWUPMODE");
                            if (isExistCodeR67 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '短信', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'FOLLOWUPMODE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR68 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "FOLLOWUPMODE");
                            if (isExistCodeR68 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '微信', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'FOLLOWUPMODE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR69 = Verification.CheckIsExistCode(conn, driver, url, username, password, "04", "FOLLOWUPMODE");
                            if (isExistCodeR69 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('04', 'QQ', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'FOLLOWUPMODE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-6-19
                             *  作用:添加客户合同
                             */
                            boolean isExistCodeR70 = Verification.CheckIsExistCode(conn, driver, url, username, password, "05", "FOLLOWUPMODE");
                            if (isExistCodeR70 == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('05', '会面', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'FOLLOWUPMODE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-06-21  张丽军
                             *  作用: 更新sys_menu修改菜单id
                             */
                            boolean sys_menu1 = Verification.CheckIsExistMenu(conn, driver, url, username, password, "q0");
                            if (sys_menu1 == true) {
                                String sql = "UPDATE `sys_menu` SET MENU_ID = '73' WHERE MENU_ID = 'q0';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   20198-6-21
                             *  创建者：张丽军
                             *  作用: 修改菜单
                             */
                            boolean functionSys = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3017");
                            if (functionSys == true) {
                                String sql = "UPDATE `sys_function` SET MENU_ID = '7301' WHERE FUNC_ID = '3017';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   20198-6-21
                             *  创建者：张丽军
                             *  作用: 修改菜单
                             */
                            boolean functionSys1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3018");
                            if (functionSys1 == true) {
                                String sql = "UPDATE `sys_function` SET MENU_ID = '7302' WHERE FUNC_ID = '3018';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   20198-6-21
                             *  创建者：张丽军
                             *  作用: 修改菜单
                             */
                            boolean functionSys2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3019");
                            if (functionSys2 == true) {
                                String sql = "UPDATE `sys_function` SET MENU_ID = '7303' WHERE FUNC_ID = '3019';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   20198-6-21
                             *  创建者：张丽军
                             *  作用: 修改菜单
                             */
                            boolean functionSys3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3020");
                            if (functionSys3 == true) {
                                String sql = "UPDATE `sys_function` SET MENU_ID = '7304' WHERE FUNC_ID = '3020';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**  创建者：  张丽军
                             *   添加表的作用: 产品信息表
                             *   添加时间：2019-06-19
                             */
                            boolean budget_process_log = Verification.CheckIsExistTable(conn, driver, url, username, password, "budget_process_log");
                            if (budget_process_log == false) {
                                String sql = " CREATE TABLE `budget_process_log` (\n" +
                                        "  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `RUN_ID` int(11) DEFAULT NULL COMMENT '流程id   关联 flow_run',\n" +
                                        "  `UID` int(11) DEFAULT NULL COMMENT '当前步骤经办人',\n" +
                                        "  `LOG_TIME` datetime DEFAULT NULL COMMENT '日志记录时间',\n" +
                                        "  `PRCS_ID` int(11) DEFAULT NULL COMMENT '当前所属步骤,关联flow_run_prcs表FLOW_PRCS字段',\n" +
                                        "  `BUDGET_ID` int(11) DEFAULT NULL COMMENT '项目id（关联项目表）',\n" +
                                        "  `MONEY` varchar(255) DEFAULT NULL COMMENT 'MONEY   金额',\n" +
                                        "  `LOG_TYPE` int(11) DEFAULT NULL COMMENT '状态（0-无  1-加   2-减）',\n" +
                                        "  `LOG_DESC` varchar(255) DEFAULT NULL COMMENT '说明',\n" +
                                        "  PRIMARY KEY (`LOG_ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            /*  2019-06-25 张丽军
                             *      创建表 cas_config
                             */
                            boolean checkIsExistCas_config = Verification.CheckIsExistTable(conn, driver, url, username, password, "cas_config");
                            if (checkIsExistCas_config == false) {
                                String sql = "CREATE TABLE `cas_config` (\n" +
                                        "  `CAS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `CAS_NAME` varchar(255) NOT NULL COMMENT '单点登录名称',\n" +
                                        "  `CAS_ADDRESS` varchar(255) NOT NULL COMMENT '单点登录服务器地址',\n" +
                                        "  `CAS_STATUS` char(1) NOT NULL DEFAULT '0' COMMENT '单点登录是否开启（0-关闭    1开启）',\n" +
                                        "  `CAS_TIME` datetime NOT NULL COMMENT '最后一次保存日期',\n" +
                                        "  `CAS_USER` varchar(255) NOT NULL COMMENT '最后一次保存人员',\n" +
                                        "  `CAS_LOGIN_ORG` varchar(255) NOT NULL COMMENT '登录OA组织  （例如：1001、1002 ）',\n" +
                                        "  PRIMARY KEY (`CAS_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*  2019-06-25 张丽军
                             *      创建表 cas_config
                             */
                            boolean checkIsExistflow_plugin = Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_plugin");
                            if (checkIsExistflow_plugin == false) {
                                String sql = "CREATE TABLE `flow_plugin` (\n" +
                                        "  `flow_plugin_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '插件自增id',\n" +
                                        "  `flow_plugin_name` varchar(22) NOT NULL COMMENT '插件名称',\n" +
                                        "  `flow_plugin_instructions` varchar(150) DEFAULT NULL COMMENT '3、插件说明',\n" +
                                        "  `flow_plugin_perform` varchar(32) NOT NULL COMMENT '执行类型',\n" +
                                        "  `flow_plugin_model` varchar(32) DEFAULT NULL COMMENT '模块名',\n" +
                                        "  `flow_plugin_method` varchar(255) DEFAULT NULL COMMENT '方法',\n" +
                                        "  `flow_plugin_service` varchar(64) DEFAULT NULL COMMENT 'service类名',\n" +
                                        "  `flow_plugin_create_date` int(10) DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `flow_plugin_update_date` int(10) DEFAULT NULL COMMENT '修改时间',\n" +
                                        "  `flow_plugin_create_user` varchar(16) DEFAULT NULL COMMENT '插件创建人',\n" +
                                        "  `flow_plugin_update_user` varchar(16) DEFAULT NULL COMMENT '插件修改人',\n" +
                                        "  `flow_plugin_update_count` int(6) DEFAULT NULL COMMENT '插件修改次数',\n" +
                                        "  `flow_plugin_flag` int(1) NOT NULL DEFAULT '0' COMMENT '内部、外部插件标识符(0-内置 1-对外接口获取数据 2-数据推送对方接口)',\n" +
                                        "  PRIMARY KEY (`flow_plugin_id`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }




                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-06-25
                             *  添加字段的作用: 预算流程
                             */

                            if (this.isAppNewVersion("2019.12.30.1", dataversion)) {

                                boolean flow_form_type = Verification.CheckIsExistFlow_form_type(conn, driver, url, username, password, "预算表单190620");
                                if (flow_form_type == false) {
                                    boolean form_sort = Verification.CheckIsExistForm_sort(conn, driver, url, username, password, "预算管理190620");
                                    if (!form_sort) {
                                        String sql111 = "INSERT INTO `form_sort` (`SORT_NO`, `SORT_NAME`, `SORT_PARENT`, `HAVE_CHILD`, `DEPT_ID`) VALUES ('0', '预算管理190620', '0', '0', '0');";
                                        Statement st = conn.createStatement();
                                        st.executeUpdate(sql111);//执行SQL语句
                                    }
                                    String form_sort1 = Verification.CheckIsExistForm_sort1(conn, driver, url, username, password, "预算管理190620");
                                    if (form_sort1 == null) {
                                        return null;
                                    }
                                    String sql = "INSERT INTO `flow_form_type` (`FORM_NAME`, `PRINT_MODEL`, `PRINT_MODEL_SHORT`, `DEPT_ID`, `SCRIPT`, `CSS`, `ITEM_MAX`, `FORM_SORT`, `is_new`) VALUES ('预算表单190620', '<script src=\"/js/workflow/plugin/twoLittle/main.js\"></script><p><br/></p><p><strong style=\\\"color: rgb(54, 96, 146); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 24px;\\\"><br/></strong></p><p style=\\\"text-align: center; white-space: normal;\\\"><strong style=\\\"color: rgb(54, 96, 146); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 24px;\\\">预算执行申请单</strong><br/></p><table width=\\\"100%\\\" align=\\\"center\\\" class=\\\"td-min-height\\\" style=\\\"border: 2px solid rgb(0, 0, 0); border-image: none; width: 1101px; height: 30px;\\\" border=\\\"2\\\" interlaced=\\\"disabled\\\" data-sort=\\\"sortDisabled\\\"><tbody><tr class=\\\"firstRow\\\"><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; width: 160px; height: 30px; background-color: rgb(219, 238, 243);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">申请人</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; background-color: rgb(255, 255, 255);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp;&nbsp;<input name=\\\"DATA_90\\\" title=\\\"申请人\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_90\\\" style=\\\"width: 180px; height: 20px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\"/></span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; background-color: rgb(219, 238, 243);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\\\">申请部门</span></span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\\\">&nbsp;&nbsp;<input name=\\\"DATA_91\\\" title=\\\"申请部门\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_91\\\" style=\\\"width: 180px; height: 20px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_DEPTNAME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\"/></span>&nbsp;</p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 35px; background-color: rgb(219, 238, 243);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">申请时间</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\\\">&nbsp;&nbsp;<input name=\\\"DATA_214\\\" title=\\\"申请时间\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_214\\\" style=\\\"width: 180px; height: 20px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\"/></span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all; background-color: rgb(219, 238, 243);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\\\">支付方式</span></span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp;&nbsp;<select name=\\\"DATA_96\\\" title=\\\"支付方式\\\" class=\\\"form_item\\\" id=\\\"DATA_96\\\" style=\\\"width: 180px;\\\" size=\\\"1\\\" orgwidth=\\\"180\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option value=\\\"支票\\\">支票</option><option value=\\\"电汇\\\">电汇</option><option value=\\\"公务卡\\\">公务卡</option><option value=\\\"银行卡转账\\\">银行卡转账</option><option value=\\\"现金\\\">现金</option></select></span><span style=\\\"font-size: 14px;\\\">&nbsp;</span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 35px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px; white-space: normal; background-color: rgb(219, 238, 243);\\\">用途</span></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p><span style=\\\"font-size: 14px;\\\">&nbsp;</span><input name=\\\"DATA_280\\\" title=\\\"用途简述\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_280\\\" style=\\\"width: 600px; height: 20px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"20\\\" orgwidth=\\\"600\\\" orgfontsize=\\\"14\\\" data-type=\\\"text\\\" orgalign=\\\"left\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 30px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">是否预算</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_102\\\" title=\\\"是否预算\\\" class=\\\"form_item\\\" id=\\\"DATA_102\\\" style=\\\"width: 150px;\\\" size=\\\"1\\\" orgwidth=\\\"150\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"请选择\\\">请选择</option><option value=\\\"预算内\\\">预算内</option><option value=\\\"临时支出\\\">临时支出</option></select></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">固定资产</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;&nbsp;</span><input name=\\\"DATA_258\\\" title=\\\"固定资产有无\\\" class=\\\"form_item\\\" id=\\\"DATA_258\\\" type=\\\"radio\\\" data-type=\\\"radio\\\" classname=\\\"radio\\\" orgchecked=\\\"\\\" radio_field=\\\"有`无`\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 30px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\\\">预支出额度名称</span>&nbsp;</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><input name=\\\"DATA_213\\\" title=\\\"项目ID\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_213\\\" style=\\\"width: 0px; text-align: left; display: none;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"\\\" orgwidth=\\\"20\\\" orgfontsize=\\\"\\\" data-type=\\\"text\\\" orgalign=\\\"left\\\"/><span style=\\\"font-size: 14px;\\\">&nbsp;</span><input name=\\\"DATA_211\\\" title=\\\"项目名称\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_211\\\" style=\\\"width: 300px; text-align: left;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"\\\" orgwidth=\\\"150\\\" orgfontsize=\\\"\\\" data-type=\\\"text\\\" orgalign=\\\"left\\\"/><span style=\\\"font-size: 14px;\\\">&nbsp;<span style=\\\"background: rgb(47, 92, 143); padding: 5px; border-radius: 5px; color: rgb(255, 255, 255); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; display: inline-block;\\\" onclick=\\\"xmkj($(this),0)\\\">&nbsp;添加额度&nbsp;</span>&nbsp; &nbsp;<span style=\\\"background: rgb(47, 92, 143); padding: 5px; border-radius: 5px; color: rgb(255, 255, 255); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; display: inline-block;\\\" onclick=\\\"xmxq($(this),0)\\\">&nbsp;额度详情 </span> &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 30px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\\\">可用金额</span>&nbsp;&nbsp;</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><input name=\\\"DATA_218\\\" title=\\\"大写可用金额\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_218\\\" style=\\\"width: 180px; height: 20px; text-align: left; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" data-type=\\\"text\\\" orghidden=\\\"0\\\" orgalign=\\\"left\\\"/></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;;\\\">额度号</span></span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><input name=\\\"DATA_220\\\" title=\\\"额度号\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_220\\\" style=\\\"width: 180px; height: 20px; text-align: left; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" data-type=\\\"text\\\" orghidden=\\\"0\\\" orgalign=\\\"left\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 30px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp;本次支出款额</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; &nbsp;<input name=\\\"DATA_246\\\" title=\\\"款额\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_246\\\" style=\\\"width: 180px; height: 20px; text-align: left; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"20\\\" orgwidth=\\\"180\\\" orgfontsize=\\\"14\\\" data-type=\\\"text\\\" orghidden=\\\"0\\\" orgalign=\\\"left\\\"/>&nbsp; &nbsp;&nbsp;</span><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">大写：</span><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; white-space: normal; background-color: rgb(219, 238, 243);\\\"><input name=\\\"DATA_228\\\" title=\\\"大写\\\" class=\\\"form_item CALC\\\" id=\\\"DATA_228\\\" style=\\\"width: 200px; height: 20px; font-size: 14px; white-space: normal;\\\" type=\\\"text\\\" size=\\\"1\\\" readonly=\\\"readonly\\\" value=\\\"RMB(款额)\\\" orgheight=\\\"20\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" data-type=\\\"calculation\\\" orghidden=\\\"0\\\" prec=\\\"2\\\" formula=\\\"RMB(款额)\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 50px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 1.5em;\\\"><strong><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">合&nbsp; &nbsp; &nbsp;同</span></strong></p><p style=\\\"line-height: 1.5em;\\\"><span style=\\\"color: rgb(192, 0, 0); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 11px;\\\">3万以上需提交合同</span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 1.5em;\\\"><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-size: 14px; text-align: -webkit-center; white-space: normal;\\\"></span><img name=\\\"DATA_231\\\" src=\\\"/img/icon_uploadimg.png\\\" class=\\\"form_item fileupload\\\" data-type=\\\"fileupload\\\" style=\\\"cursor: pointer;\\\" title=\\\"合同\\\" id=\\\"DATA_231\\\" width=\\\"35\\\" height=\\\"35\\\"/>&nbsp;</span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 1.5em;\\\"><strong><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">会议纪要</span></strong></p><p style=\\\"line-height: 1.5em;\\\"><span style=\\\"font-family: 微软雅黑, Microsoft YaHei;\\\"><span style=\\\"color: rgb(192, 0, 0); font-size: 11px;\\\">大于10万提交</span></span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 1.5em;\\\"><span style=\\\"font-size: 14px;\\\"><img name=\\\"DATA_232\\\" src=\\\"/img/icon_uploadimg.png\\\" class=\\\"form_item fileupload\\\" data-type=\\\"fileupload\\\" style=\\\"cursor: pointer;\\\" title=\\\"会议纪要\\\" id=\\\"DATA_232\\\" width=\\\"35\\\" height=\\\"35\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all; background-color: rgb(219, 238, 243);\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">用途说明</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><textarea name=\\\"DATA_36\\\" title=\\\"用途说明\\\" class=\\\"form_item\\\" id=\\\"DATA_36\\\" style=\\\"width: 640px; height: 59px; font-size: 14px; margin: 0px;\\\" orgheight=\\\"60\\\" orgwidth=\\\"800\\\" orgfontsize=\\\"14\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea>&nbsp;<img name=\\\"DATA_286\\\" src=\\\"/img/fileupload.png\\\" class=\\\"form_item fileupload\\\" data-type=\\\"fileupload\\\" style=\\\"cursor: pointer; margin: 0 5px;\\\" align=\\\"absmiddle\\\" title=\\\"用途说明附件\\\" id=\\\"DATA_286\\\" width=\\\"50\\\" height=\\\"50\\\"/></p><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px; background-color: transparent;\\\">&nbsp;<span style=\\\"font-size: 12px; background-color: transparent;vertical-align:top\\\">收款单位：<textarea name=\\\"DATA_284\\\" id=\\\"DATA_284\\\" class=\\\"form_item\\\" data-type=\\\"textarea\\\" title=\\\"收款单位\\\" value=\\\"收款单位  开户行 账号\\\" rich=\\\"0\\\" orgfontsize=\\\"\\\" orgwidth=\\\"500\\\" orgheight=\\\"40\\\" style=\\\"width: 500px; height: 40px;\\\">收款单位 &nbsp;开户行 账号</textarea></span></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 30px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">明细表</span></p></td><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p style=\\\"line-height: 3em;\\\"><input name=\\\"DATA_222\\\" title=\\\"明细表\\\" class=\\\"form_item listing\\\" id=\\\"DATA_222\\\" type=\\\"text\\\" data-type=\\\"listing\\\" lv_cal=\\\"````[3]*[4]``\\\" lv_coltype=\\\"text`text`text`text`text`radio`\\\" lv_sum=\\\"0`0`0`0`1`0\\\" lv_colvalue=\\\"`````是,否`\\\" lv_size=\\\"200`100`100`100`100`150`\\\" lv_title=\\\"名称 型号`单位`单价`数量`合计`固定资产`\\\" lv_field=\\\"mc`dw`dj`sl`hj`zc`\\\" datafrom=\\\"outData\\\" default_cols=\\\"\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 35px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"color: rgb(0, 0, 0); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">部门主管审批</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 30px;\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_269\\\" title=\\\"部门主管审批是否同意\\\" class=\\\"form_item\\\" id=\\\"DATA_269\\\" style=\\\"width: 80px;\\\" size=\\\"1\\\" orgwidth=\\\"80\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"同意\\\">同意</option><option value=\\\"不同意\\\">不同意</option></select>&nbsp;<span style=\\\"font-size: 14px; white-space: normal;\\\">&nbsp;</span><span style=\\\"white-space: normal;\\\"></span><textarea name=\\\"DATA_129\\\" title=\\\"部门主管审批\\\" class=\\\"form_item\\\" id=\\\"DATA_129\\\" style=\\\"margin: 0px; width: 236px; height: 10px; font-size: 14px;\\\" orgheight=\\\"35\\\" orgwidth=\\\"300\\\" orgfontsize=\\\"14\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea><span style=\\\"font-size: 14px; white-space: normal;\\\">&nbsp;</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 30px;\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 签字：<input name=\\\"DATA_270\\\" title=\\\"部门主管签字\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_270\\\" style=\\\"width: 200px; height: 30px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"30\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\" orgsqllist=\\\"\\\" orgsql=\\\"\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 35px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">校级主管审批</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_184\\\" title=\\\"校级主管是否同意\\\" class=\\\"form_item\\\" id=\\\"DATA_184\\\" style=\\\"width: 80px;\\\" size=\\\"1\\\" orgwidth=\\\"80\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"同意\\\">同意</option><option value=\\\"不同意\\\">不同意</option></select><span style=\\\"font-size: 14px; white-space: normal;\\\">&nbsp;&nbsp;</span><textarea name=\\\"DATA_185\\\" title=\\\"校级主管审批意见\\\" class=\\\"form_item\\\" id=\\\"DATA_185\\\" style=\\\"margin: 0px; width: 240px; height: 19px; font-size: 16px;\\\" orgheight=\\\"40\\\" orgwidth=\\\"600\\\" orgfontsize=\\\"16\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 签字：<input name=\\\"DATA_274\\\" title=\\\"校级主管签字\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_274\\\" style=\\\"width: 200px; height: 30px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"30\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\" orgsqllist=\\\"\\\" orgsql=\\\"\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); height: 45px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">会计审批</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_276\\\" title=\\\"会计审批意见\\\" class=\\\"form_item\\\" id=\\\"DATA_276\\\" style=\\\"width: 80px;\\\" size=\\\"1\\\" orgwidth=\\\"80\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"同意\\\">同意</option><option value=\\\"不同意\\\">不同意</option></select><span style=\\\"font-family: 微软雅黑; font-size: 14px;\\\">&nbsp;是否拆分：<select name=\\\"DATA_186\\\" title=\\\"是否拆分\\\" class=\\\"form_item\\\" id=\\\"DATA_186\\\" style=\\\"width: 100px;\\\" size=\\\"1\\\" orgwidth=\\\"100\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"\\\">&nbsp;</option><option value=\\\"是\\\">是</option><option value=\\\"否\\\">否</option></select></span><span style=\\\"font-size: 14px;\\\">&nbsp;</span><textarea name=\\\"DATA_142\\\" title=\\\"会计\\\" class=\\\"form_item\\\" id=\\\"DATA_142\\\" style=\\\"margin: 0px; width: 172px; height: 10px; font-size: 16px;\\\" orgheight=\\\"40\\\" orgwidth=\\\"400\\\" orgfontsize=\\\"16\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea><span style=\\\"font-size: 14px; background-color: transparent;\\\">&nbsp;</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp;&nbsp;<span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\\\">签字：</span><input name=\\\"DATA_278\\\" title=\\\"会计签字\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_278\\\" style=\\\"width: 200px; height: 30px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"30\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\" orgsqllist=\\\"\\\" orgsql=\\\"\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0); background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">支出拆分计划</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border-color: rgb(0, 0, 0);\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p>&nbsp;<input name=\\\"DATA_225\\\" title=\\\"项目拆分\\\" class=\\\"form_item listing\\\" id=\\\"DATA_225\\\" type=\\\"text\\\" data-type=\\\"listing\\\" lv_cal=\\\"``````[4]-[5]-[6]```\\\" lv_coltype=\\\"text`text`text`text`text`text`text`text`text`\\\" lv_sum=\\\"0`0`0`0`0`0`0`1`0\\\" lv_colvalue=\\\"`````````\\\" lv_size=\\\"50`80`60`75`80`85`80`80`0`\\\" lv_title=\\\"额度号`项目名称`负责人`预算总额`项目已支出`项目预支出`可用金额`拆分金额``\\\" lv_field=\\\"ed`xm`fz`ys`yz`yzc`ky`cf`xmId`\\\" datafrom=\\\"outData\\\" default_cols=\\\"\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 35px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">财务主管审批</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_241\\\" title=\\\"财务主管审批是否同意\\\" class=\\\"form_item\\\" id=\\\"DATA_241\\\" style=\\\"width: 80px;\\\" size=\\\"1\\\" orgwidth=\\\"80\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"同意\\\">同意</option><option value=\\\"不同意\\\">不同意</option></select><span style=\\\"font-size: 14px; white-space: normal;\\\">&nbsp;&nbsp;</span><textarea name=\\\"DATA_193\\\" title=\\\"财务主管审批意见\\\" class=\\\"form_item\\\" id=\\\"DATA_193\\\" style=\\\"margin: 0px; width: 246px; height: 20px; font-size: 14px;\\\" orgheight=\\\"40\\\" orgwidth=\\\"600\\\" orgfontsize=\\\"14\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; -ms-word-break: break-all;\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 签字：</span><input name=\\\"DATA_201\\\" title=\\\"财务主管签字\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_201\\\" style=\\\"width: 200px; height: 30px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"30\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\" orgsqllist=\\\"\\\" orgsql=\\\"\\\"/></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; height: 35px; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">校长审批</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px;\\\">&nbsp;</span><select name=\\\"DATA_242\\\" title=\\\"校长审批是否同意\\\" class=\\\"form_item\\\" id=\\\"DATA_242\\\" style=\\\"width: 80px;\\\" size=\\\"1\\\" orgwidth=\\\"80\\\" data-type=\\\"select\\\" fieldflow=\\\"0\\\" plugins=\\\"select\\\"><option selected=\\\"selected\\\" value=\\\"同意\\\">同意</option><option value=\\\"不同意\\\">不同意</option></select><span style=\\\"font-size: 14px; white-space: normal;\\\">&nbsp;&nbsp;</span><span style=\\\"white-space: normal;\\\"></span><textarea name=\\\"DATA_195\\\" title=\\\"校长审批意见\\\" class=\\\"form_item\\\" id=\\\"DATA_195\\\" style=\\\"margin: 0px; width: 247px; height: 16px; font-size: 14px;\\\" orgheight=\\\"35\\\" orgwidth=\\\"300\\\" orgfontsize=\\\"14\\\" data-type=\\\"textarea\\\" rich=\\\"0\\\" value=\\\"\\\"></textarea></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 签字：<input name=\\\"DATA_208\\\" title=\\\"校长签字\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_208\\\" style=\\\"width: 200px; height: 30px; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgheight=\\\"30\\\" orgwidth=\\\"200\\\" orgfontsize=\\\"14\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERNAME_DATETIME\\\" data-type=\\\"macros\\\" orghidden=\\\"0\\\" orgsqllist=\\\"\\\" orgsql=\\\"\\\"/></span></p></td></tr><tr><td align=\\\"center\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none; background-color: rgb(219, 238, 243);\\\" rowspan=\\\"2\\\" colspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">出纳确认支出</span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"2\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 实际支出金额：</span><input name=\\\"DATA_204\\\" title=\\\"实际支出金额\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_204\\\" style=\\\"width: 100px; height: 30px; text-align: left; font-size: 14px;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"30\\\" orgwidth=\\\"100\\\" orgfontsize=\\\"14\\\" data-type=\\\"text\\\" orgalign=\\\"left\\\"/><span style=\\\"font-size: 14px;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px;\\\">元</span>&nbsp;</span><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px; background-color: rgb(247, 250, 255);\\\">大写：</span><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; background-color: rgb(247, 250, 255);\\\"><input name=\\\"DATA_229\\\" title=\\\"大写2\\\" class=\\\"form_item CALC\\\" id=\\\"DATA_229\\\" style=\\\"width: 130px;\\\" type=\\\"text\\\" readonly=\\\"readonly\\\" value=\\\"RMB(实际支出金额)\\\" orgheight=\\\"\\\" orgwidth=\\\"130\\\" orgfontsize=\\\"\\\" data-type=\\\"calculation\\\" prec=\\\"4\\\" formula=\\\"RMB(实际支出金额)\\\"/></span></p></td><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 14px;\\\">&nbsp; 支票号：<input name=\\\"DATA_282\\\" title=\\\"支票号\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_282\\\" style=\\\"width: 150px; text-align: left;\\\" type=\\\"text\\\" value=\\\"\\\" orgheight=\\\"\\\" orgwidth=\\\"150\\\" orgfontsize=\\\"\\\" data-type=\\\"text\\\" orgalign=\\\"left\\\"/></span><span style=\\\"font-size: 14px;\\\">&nbsp;</span></p></td></tr><tr><td align=\\\"left\\\" valign=\\\"middle\\\" style=\\\"border: 1px solid rgb(0, 0, 0); border-image: none;\\\" rowspan=\\\"1\\\" colspan=\\\"3\\\"><p style=\\\"line-height: 3em;\\\"><span style=\\\"font-size: 14px; background-color: transparent;\\\">&nbsp;</span><input name=\\\"DATA_227\\\" title=\\\"项目拆分结果\\\" class=\\\"form_item listing\\\" id=\\\"DATA_227\\\" type=\\\"text\\\" data-type=\\\"listing\\\" lv_cal=\\\"``````[4]-[5]-[6]```\\\" lv_coltype=\\\"text`text`text`text`text`text`text`text`text`\\\" lv_sum=\\\"0`0`0`0`0`0`0`1`0\\\" lv_colvalue=\\\"`````````\\\" lv_size=\\\"50`80`60`75`80`85`80`80`0`\\\" lv_title=\\\"额度号`项目名称`负责人`预算总额`项目已支出`项目预支出`可用金额`拆分金额``\\\" lv_field=\\\"ed`xm`fzr`ys`yz`yzc`ky`cf`xmId`\\\" datafrom=\\\"outData\\\" default_cols=\\\"\\\"/><br/></p></td></tr></tbody></table><p></p><p></p><p><input name=\\\"DATA_233\\\" title=\\\"用户id控件\\\" class=\\\"AUTO  form_item\\\" id=\\\"DATA_233\\\" style=\\\"width: 150px; visibility: hidden;\\\" type=\\\"text\\\" value=\\\"{macros}\\\" orgwidth=\\\"150\\\" orghide=\\\"0\\\" datafld=\\\"SYS_USERID\\\" data-type=\\\"macros\\\"/>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<input name=\\\"DATA_234\\\" title=\\\"部门ID\\\" align=\\\"left\\\" class=\\\"form_item\\\" id=\\\"DATA_234\\\" style=\\\"width: 150px; text-align: left;\\\" type=\\\"hidden\\\" value=\\\"\\\" orgheight=\\\"\\\" orgwidth=\\\"150\\\" orgfontsize=\\\"\\\" data-type=\\\"hidden\\\" orgalign=\\\"left\\\"/><span style=\\\"background: rgb(47, 92, 143); padding: 5px; border-radius: 5px; color: rgb(255, 255, 255); font-family: 微软雅黑, &quot;Microsoft YaHei&quot;; font-size: 16px; margin-right: 18%; float: right; display: inline-block;\\\" onclick=\\\"ckrz($(this))\\\">&nbsp;查看日志 </span></p><script>function getCookie(name){\\n   var strcookie = document.cookie;\\n  console.log(strcookie);\\n   var arrcookie = strcookie.split(\\\"; \\\");\\n  \\n   for ( var i = 0; i < arrcookie.length; i++) {\\n    var arr = arrcookie[i].split(\\\"=\\\");\\n    if (arr[0] == name){\\n      return arr[1];\\n    }\\n   }\\n    return \\\"\\\";\\n}\\n $(\\'#DATA_234\\').val(getCookie(\\'deptId\\'))</script><style>.uploadImg{\\n    width:130px!important;\\n    margin-left: -50px;\\n  }\\n  .imgfileBox img{\\n    margin:0 40px!important;\\n  }</style>', '', '0', '', '', '0', " + form_sort1 + ", '0');";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                    if (sql != null) {
                                        String formId = Verification.CheckIsExistFlow_form_type1(conn, driver, url, username, password, "预算表单190620");
                                        if (formId != null) {
                                            String sql1 = "INSERT INTO `flow_sort` (`SORT_NO`, `SORT_NAME`, `DEPT_ID`, `SORT_PARENT`, `HAVE_CHILD`, `SORT_MAIN_TYPE`, `SORT_DETAIL_TYPE`) VALUES ('0', '预算管理', '0', '0', '0', 'BUDGETTYPE', 'BUDGETTYPE01');";
                                            st.executeUpdate(sql1);//执行SQL语句
                                            if (sql1 != null) {
                                                String sortId = Verification.CheckIsExistFlow_sort(conn, driver, url, username, password, "预算管理");
                                                if (sortId != null) {
                                                    String sql2 = "INSERT INTO `flow_type` (`FLOW_NAME`, `FORM_ID`, `FLOW_DOC`, `FLOW_TYPE`, `MANAGE_USER`, `FLOW_NO`, `FLOW_SORT`, `AUTO_NAME`, `AUTO_NUM`, `AUTO_LEN`, `QUERY_USER`, `FLOW_DESC`, `AUTO_EDIT`, `NEW_USER`, `QUERY_ITEM`, `COMMENT_PRIV`, `DEPT_ID`, `FREE_PRESET`, `FREE_OTHER`, `QUERY_USER_DEPT`, `MANAGE_USER_DEPT`, `EDIT_PRIV`, `LIST_FLDS_STR`, `ALLOW_PRE_SET`, `FORCE_PRE_SET`, `MODEL_ID`, `MODEL_NAME`, `ATTACHMENT_ID`, `ATTACHMENT_NAME`, `VIEW_USER`, `VIEW_DEPT`, `VIEW_ROLE`, `VIEW_PRIV`, `IS_VERSION`, `FLOW_ACTION`, `AUTO_NUM_YEAR`, `AUTO_NUM_MONTH`, `AUTO_NUM_TIME`, `NEW_TYPE`, `MOBILE_NEW_TYPE`) VALUES ('预算流程190620', " + formId + ", '1', '1', '', '1', " + sortId + ", '---{U}{Y}年{M}月{D}日', '1626', '6', '', '', '1', '', '', '3', '1', '1', '1', '', '', '', '', '0', '2', '', '', '', '', '', '', '', '0', '0', '3', '0', '0', '0002-11-30 00:00:00', '0,1', '1');";
                                                    st.executeUpdate(sql2);//执行SQL语句
                                                    String flowId = Verification.CheckIsExistFlow_type_id(conn, driver, url, username, password, "预算流程190620");

                                                    if (flowId != null) {

                                                        String sql3 = "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '1', '0', '当事人申请', 'liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,', '[A@],申请人,申请部门,申请时间,支付方式,用途简述,是否预算,固定资产有无,项目ID,项目名称,额度号,款额,大写,合同,用途说明,用途说明附件,收款单位,明细表,用户id控件,部门ID,[B@]', '', '支付方式,是否预算,项目ID,项目名称,款额,大写,', '', '', '2,', '76', '339', '', '', '', '', '\"款额\">=\"30000\"\n\"合同\"!=\"\"\n\"款额\"<\"30000\"\n', '0', '', '([1] AND [2]) OR [3]', '1', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '2', '', '1', '0', '1', '0', '1,2,3,4,5,', '0', '3万元以上项目需要提交合同', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql4 = "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '2', '0', '部门主管', 'liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,', '[A@],合同,会议纪要,部门主管审批是否同意,部门主管审批,部门主管签字', '', 'DATA_129,', '', '', '3,1,', '355', '83', '', '', '', '', '\"款额\">=\"100000\"\n\"会议纪要\"!=\"\"\n\"款额\"<\"100000\"\n', '0', '', '([1] AND [2]) OR [3]', '2', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '10万元以上项目请联系办公室上传会议纪要后方可转交！', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql5 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '3', '0', '校级主管', 'liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,', '[A@],校级主管是否同意,校级主管审批意见,校级主管签字', '', 'DATA_184,DATA_185,', '', '', '4,1,', '378', '174', '', '', '', '', '', '0', '', '', '4', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql6 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '4', '0', '会计审核支付', 'liuyang,wangqiang,wangfang,720,wangfang,lihua,wangli,723,724,720,wangli,baixue,lijie,320,318,312,316,324,322,313,317,323,321,319,admin,314,717,121,721,722,', '[A@],合同,会议纪要,会计审批意见,是否拆分,会计签字,会计,项目拆分', '', 'DATA_142,', '', '', '5,1,', '362', '270', '', '', '', '', '', '0', '', '', '0', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql7 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '5', '0', '财务主管审批', '', '[A@],合同,会议纪要,财务主管审批是否同意,财务主管签字,财务主管审批意见', '', 'DATA_201,DATA_193,', '', '2,3,5,7,9,11,4,6,8,10,12,1,13,', '6,7,1,', '369', '347', '', '', '', '', '', '0', '', '', '0', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql8 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '6', '0', '校长审批', '', '[A@],合同,会议纪要,校长审批是否同意,校长签字,校长审批意见', '', 'DATA_208,DATA_195,', '', '2,3,5,7,9,11,4,6,8,10,12,1,13,', '7,1,', '372', '464', '', '', '', '', '', '0', '', '', '0', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql9 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '7', '0', '出纳接收并与发起人预约时间', '', '[A@],合同,会议纪要,财务主管审批是否同意,财务主管审批意见,实际支出金额,大写2,支票号,项目拆分结果', '', 'DATA_204,DATA_205,DATA_206,', '', '2,3,5,7,9,11,4,6,8,10,12,1,13,', '9,0,', '503', '405', '', '', '', '', '', '0', '', '', '0', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql10 =
                                                                "INSERT INTO `flow_process` (`FLOW_ID`, `PRCS_ID`, `PRCS_TYPE`, `PRCS_NAME`, `PRCS_USER`, `PRCS_ITEM`, `HIDDEN_ITEM`, `REQUIRED_ITEM`, `PRCS_DEPT`, `PRCS_PRIV`, `PRCS_TO`, `SET_LEFT`, `SET_TOP`, `PLUGIN`, `PLUGIN_SAVE`, `PRCS_ITEM_AUTO`, `PRCS_IN`, `PRCS_OUT`, `FEEDBACK`, `PRCS_IN_SET`, `PRCS_OUT_SET`, `AUTO_TYPE`, `AUTO_DEPT`, `AUTO_USER_OP`, `AUTO_USER`, `AUTO_USER_OP_RETURN`, `AUTO_USER_RETURN`, `USER_FILTER`, `USER_FILTER_PRCS_PRIV`, `USER_FILTER_PRCS_PRIV_OTHER`, `USER_FILTER_PRCS_DEPT`, `USER_FILTER_PRCS_DEPT_OTHER`, `TIME_OUT`, `TIME_OUT_MODIFY`, `TIME_OUT_ATTEND`, `SIGNLOOK`, `TOP_DEFAULT`, `USER_LOCK`, `MAIL_TO`, `MAIL_TO_DEPT`, `MAIL_TO_PRIV`, `SYNC_DEAL`, `SYNC_DEAL_CHECK`, `TURN_PRIV`, `CHILD_FLOW`, `GATHER_NODE`, `ALLOW_BACK`, `ATTACH_PRIV`, `AUTO_BASE_USER`, `CONDITION_DESC`, `RELATION_IN`, `RELATION_OUT`, `REMIND_FLAG`, `DISP_AIP`, `TIME_OUT_TYPE`, `ATTACH_EDIT_PRIV`, `ATTACH_EDIT_PRIV_ONLINE`, `ATTACH_MACRO_MARK`, `CONTROL_MODE`, `LIST_COLUMN_PRIV`, `VIEW_PRIV`, `FILEUPLOAD_PRIV`, `IMGUPLOAD_PRIV`, `SIGN_TYPE`, `COUNTERSIGN`, `WORKINGDAYS_TYPE`, `DOCUMENT_EDIT_PRIV`, `DOCUMENT_EDIT_PRIV_DETAIL`) VALUES ('" + flowId + "', '9', '0', '固定财产登记', '', '[A@],合同,会议纪要', '', '', '', '2,3,5,7,9,11,4,6,8,10,12,1,13,', '0,', '670', '406', '', '', '', '', '', '0', '', '', '0', '', '', '', '', '', '0', '', '', '', '', '', '0', '0', '0', '0', '1', '', '', '', '0', '', '1', '0', '0', '0', '4,5,', '0', '', '', '', '0', '0', '0', '1', '0', '0', '', '', '0', '', '', '0', '0', '0', '0', '0');";
                                                        String sql11 =
                                                                "INSERT INTO `flow_plugin` (`flow_plugin_name`, `flow_plugin_instructions`, `flow_plugin_perform`, `flow_plugin_model`, `flow_plugin_method`, `flow_plugin_service`, `flow_plugin_create_date`, `flow_plugin_update_date`, `flow_plugin_create_user`, `flow_plugin_update_user`, `flow_plugin_update_count`, `flow_plugin_flag`) VALUES ('预算压缩附件', '用户设置后，可以讲流程附件，表单附件，以及表单压缩', 'BEFORE_BACKEND', 'BudgetCompressTrigger', 'updateAttachmentByRunId(budgetingProcess);', '@Resource BudgetingProcessMapper budgetingProcessMapper', '1537518116', NULL, 'admin', NULL, '1', '0');";
                                                        String sql12 =
                                                                "INSERT INTO `flow_hook` (`flow_id`, `hname`, `hdesc`, `hmodule`, `plugin`, `status`, `map`, `condition`, `condition_set`, `system`, `order_id`, `data_direction`) VALUES ('" + flowId + "', '预算', '', 'budgeting_process', '', '0', '用户id控件=>applicant,部门ID=>dept_id,申请时间=>application_date,支付方式=>per_pay,是否预算=>is_per,固定资产有无=>fixed_assets,项目ID=>budget_id,项目名称=>budget_item_name,大写可用金额=>is_payment,额度号=>line_no,款额=>payment,用途说明=>instructions,明细表=>schedule_of,部门主管审批=>department_head,校级主管是否同意=>is_opinion,会计审批意见=>accounting_advice,是否拆分=>is_break_up,会计签字=>treasurer_signature,财务主管审批意见=>treasurer_opinion,项目拆分=>break_up_plan,校长签字=>headmaster_signature,校长审批意见=>headmaster_opinion,实际支出金额=>actual_expenditure,大写2=>amount_words,项目拆分结果=>cashier_opinion,', '', '', '1', '1', '2');";

                                                        st.executeUpdate(sql3);//执行SQL语句
                                                        st.executeUpdate(sql4);//执行SQL语句
                                                        st.executeUpdate(sql5);//执行SQL语句
                                                        st.executeUpdate(sql6);//执行SQL语句
                                                        st.executeUpdate(sql7);//执行SQL语句
                                                        st.executeUpdate(sql8);//执行SQL语句
                                                        st.executeUpdate(sql9);//执行SQL语句
                                                        st.executeUpdate(sql10);//执行SQL语句
                                                        st.executeUpdate(sql11);//执行SQL语句
                                                        st.executeUpdate(sql12);//执行SQL语句

                                                        String hookId = Verification.CheckIsExistFlow_hook_id(conn, driver, url, username, password, "" + flowId);
                                                        String sql13 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '1', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql14 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '2', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql15 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '3', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql16 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '4', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql17 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '5', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql18 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '6', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql19 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '7', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');\n";
                                                        String sql20 =
                                                                "INSERT INTO `flow_trigger` (`NAME`, `FLOW_ID`, `FLOW_PRCS`, `PLUGIN_TYPE`, `PLUGIN_WAY`, `PLUGIN`, `ACTIVED`, `SORT_ID`, `DESCRIPTION`, `BUSINESS_LOGIC_ID`, `ISGLOBAL`) VALUES ('预算压缩和计算金额', '" + flowId + "', '9', 'TURN', 'BEFORE_FRONTEND', '0', '1', '1', '', '" + hookId + "', '1');";


                                                        st.executeUpdate(sql13);//执行SQL语句
                                                        st.executeUpdate(sql14);//执行SQL语句
                                                        st.executeUpdate(sql15);//执行SQL语句
                                                        st.executeUpdate(sql16);//执行SQL语句
                                                        st.executeUpdate(sql17);//执行SQL语句
                                                        st.executeUpdate(sql18);//执行SQL语句
                                                        st.executeUpdate(sql19);//执行SQL语句
                                                        st.executeUpdate(sql20);//执行SQL语句


                                                    }
                                                }
                                            }

                                        }
                                    }
                                }
                            }

                            //添加字段(用户签字图片)   2019-07-10 张丽军
                            boolean user1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "SIGN_IMAGE_ID");
                            if (user1 == false) {
                                String sql = "ALTER TABLE `user` ADD `SIGN_IMAGE_ID` varchar(255) DEFAULT NULL COMMENT '用户签名ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //添加字段(用户签字图片)   2019-07-10 张丽军
                            boolean user2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "SIGN_IMAGE_NAME");
                            if (user1 == false) {
                                String sql = "ALTER TABLE `user` ADD `SIGN_IMAGE_NAME` varchar(255) DEFAULT NULL COMMENT '用户签名ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*  2019-07-10 张丽军
                             *      创建表 user_weixinqy 企业微信
                             */
                            boolean user_weixinqy = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_weixinqy");
                            if (user_weixinqy == false) {
                                String sql = "CREATE TABLE `user_weixinqy` (\n" +
                                        "  `user_id` varchar(40) NOT NULL COMMENT 'oa用户userid',\n" +
                                        "  `open_id` varchar(40) NOT NULL COMMENT '企业微信用户id',\n" +
                                        "  `deviceId` varchar(40) NOT NULL COMMENT '企业微信设备id',\n" +
                                        "  `is_sys` tinyint(3) unsigned NOT NULL COMMENT '是否为管理员',\n" +
                                        "  KEY `user_id` (`user_id`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='微信用户表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**
                             * 张丽军
                             * user表ICQ_NO字段长度修改
                             */
                            boolean checkIsUserICQ_NO = Verification.CheckIsExistUserLength(conn, driver, "xoa" + obj.get(i).getOid(), "user", "ICQ_NO", "255");
                            if (checkIsUserICQ_NO == false) {
                                String sql = "alter table user modify ICQ_NO VARCHAR(255);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-07-23  zhanglijun
                             *  作用: 修改投票开始时间类型
                             */
                            boolean checkIsExistTime = Verification.CheckIsExistfield(conn, driver, url, username, password, "vote_title", "END_DATE");
                            if (checkIsExistTime == true) {
                                String sql = "alter table vote_title modify column`END_DATE` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '投票结束时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /**   2019-07-23  zhanglijun
                             *  作用: 修改投票开始时间类型
                             */
                            boolean checkIsExistTime1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "vote_title", "BEGIN_DATE");
                            if (checkIsExistTime1 == true) {
                                String sql = "alter table vote_title modify column`BEGIN_DATE` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '投票开始时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-07-26 张丽军
                             *      创建表 secure_key 动态密码卡信息
                             */
                            boolean secure_key = Verification.CheckIsExistTable(conn, driver, url, username, password, "secure_key");
                            if (secure_key == false) {
                                String sql = "CREATE TABLE `secure_key` (\n" +
                                        "  `KEY_SN` varchar(20) NOT NULL COMMENT '动态密码卡卡号',\n" +
                                        "  `KEY_INFO` text NOT NULL COMMENT '动态密码卡数据',\n" +
                                        "  PRIMARY KEY (`KEY_SN`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=gbk COMMENT='动态密码卡信息';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*  2019-08-07 张丽军
                             *      创建表 qiyeweixin_config 企业微信绑定信息
                             */
                            boolean qiyeweixin_config = Verification.CheckIsExistTable(conn, driver, url, username, password, "qiyeweixin_config");
                            if (qiyeweixin_config == false) {
                                String sql = "CREATE TABLE `qiyeweixin_config` (\n" +
                                        "  `corpid` varchar(255) NOT NULL DEFAULT '' COMMENT '服务商CorpID',\n" +
                                        "  `provider_secret` varchar(255) DEFAULT '' COMMENT '服务商密钥',\n" +
                                        "  `suite_id` varchar(255) DEFAULT '' COMMENT '应用id',\n" +
                                        "  `suite_secret` varchar(255) DEFAULT '' COMMENT '应用secret',\n" +
                                        "  `suite_ticket_url` varchar(255) DEFAULT '' COMMENT '企业微信后台推送ticket的url',\n" +
                                        "  `permanent_code` text COMMENT '企业微信永久授权码,最长为512字节',\n" +
                                        "  `corpsecret` varchar(255) DEFAULT '' COMMENT '应用的凭证密钥',\n" +
                                        "  PRIMARY KEY (`corpid`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**  2019-08-07  zhanglijun
                             *  作用: 应用的凭证密钥
                             */
                            boolean qiyeweixin_config1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "qiyeweixin_config", "corpsecret");
                            if (qiyeweixin_config1 == false) {
                                String sql = "ALTER TABLE qiyeweixin_config ADD corpsecret VARCHAR(255) DEFAULT '' COMMENT '应用的凭证密钥';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-08-07
                             *  添加字段的作用: 附件加密
                             */
                            boolean sys_para_f = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "AES_ENCRYPTION");
                            if (sys_para_f == false) {
                                String sql = "INSERT INTO `sys_para`  (PARA_NAME ,PARA_VALUE) VALUES ('AES_ENCRYPTION','1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-08-07
                             *  添加字段的作用: 附件加密
                             */
                            boolean sys_para_m = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "KEY_ENCRYPTION");
                            if (sys_para_m == false) {
                                String sql = "INSERT INTO `sys_para`  (PARA_NAME ,PARA_VALUE) VALUES ('KEY_ENCRYPTION','');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            /**  2019-08-07  zhanglijun
                             *  作用: 移动端表单字段排序信息
                             */
                            boolean flow_form_type4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_form_type", "MOBILE_DATA_SORT");
                            if (flow_form_type4 == false) {
                                String sql = " alter table flow_form_type add `MOBILE_DATA_SORT` text COMMENT '移动端表单字段排序信息';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**  2019-08-07  zhanglijun
                             *  作用: 是否在新窗口打开
                             */
                            boolean portals = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "new_window");
                            if (portals == false) {
                                String sql = " alter table portals add `new_window` VARCHAR(50) DEFAULT '0' COMMENT '是否在新窗口打开';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-08-07
                             *  添加字段的作用: 附件加密
                             */
                            boolean sys_para_s = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "BACKUPS_KEY_ENCRYPTION");
                            if (sys_para_s == false) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('BACKUPS_KEY_ENCRYPTION', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            /**   2019-8-19
                             *  作用: 添加归档信息
                             */
                            boolean isExistCodeGUI = Verification.CheckIsExistCode(conn, driver, url, username, password, "RMS_FILE_TYPE", "");
                            if (isExistCodeGUI == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('RMS_FILE_TYPE', '档案文件分类', NULL, NULL, NULL, NULL, NULL, NULL, '100', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-8-19
                             *  作用: 添加归档信息
                             */
                            boolean isExistCodeGU = Verification.CheckIsExistCode(conn, driver, url, username, password, "1", "RMS_FILE_TYPE");
                            if (isExistCodeGU == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('1', '公文', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'RMS_FILE_TYPE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-8-19
                             *  作用: 添加归档信息
                             */
                            boolean isExistCodeG = Verification.CheckIsExistCode(conn, driver, url, username, password, "2", "RMS_FILE_TYPE");
                            if (isExistCodeG == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('2', '资料', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'RMS_FILE_TYPE', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                              /*   *
                           张丽军
                           2019-08-22
                     *  修改字段的作用: 删除企业号设置菜单
                     */
                            boolean checkIsExisPortals_weixin = Verification.CheckIsExistweixin(conn, driver, url, username, password, "71");
                            if (checkIsExisPortals_weixin == true) {
                                String sql = "DELETE  FROM `sys_function` WHERE `FUNC_ID`='71';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-8-19
                             *  添加字段的作用: 添加企业微信设置菜单
                             */
                            boolean isExistFunctionqy = Verification.CheckIsExistFunction(conn, driver, url, username, password, "301");
                            if (isExistFunctionqy == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (301, 'z012', '企业微信设置', 'Enterprise Wechat Settings', '企業微信設定', NULL, NULL, NULL, 'qiyeWeixin/enterpriseSetting', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-8-19
                             *  添加字段的作用: 添加钉钉设置菜单
                             */
                            boolean isExistFunctiondd = Verification.CheckIsExistFunction(conn, driver, url, username, password, "302");
                            if (isExistFunctiondd == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (302, 'z013', '钉钉设置', 'Nail setting', '釘釘設定', '', '', '', 'dingdingManage/getIndex', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*    * 2019-8-21
                             *  添加字段的作用: CRM设置菜单
                             */
                            boolean isExistFunctionCRM = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2206");
                            if (isExistFunctionCRM == false) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2206, '7506', 'CRM设置', NULL, NULL, NULL, NULL, NULL, '/crmManager/index', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-08-21 张丽军
                             *      创建表 crm_manager crm主管设置
                             */
                            boolean crm_manager = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_manager");
                            if (crm_manager == false) {
                                String sql = "CREATE TABLE `crm_manager`  (\n" +
                                        "  `MID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `MANAGER_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管id',\n" +
                                        "  `SALES_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '下属id',\n" +
                                        "  PRIMARY KEY (`MID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-08-21 张丽军
                             *      创建表 crm_manager crm权限设置
                             */
                            boolean crm_role = Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_role");
                            if (crm_role == false) {
                                String sql = "CREATE TABLE `crm_role`  (\n" +
                                        "  `RID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EDIT_USER` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '编辑权限',\n" +
                                        "  `DEL_USER` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '删除权限',\n" +
                                        "  PRIMARY KEY (`RID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-08-21 张丽军
                             *      创建表 crm_manager 薪资设置
                             */
                            boolean bonus_priv = Verification.CheckIsExistTable(conn, driver, url, username, password, "bonus_priv");
                            if (bonus_priv == false) {
                                String sql = "CREATE TABLE `bonus_priv`  (\n" +
                                        "  `ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `MANAGER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主管',\n" +
                                        "  `EMPLOYEE` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '员工',\n" +
                                        "  PRIMARY KEY (`ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //兼容通达会议数据

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "SECRET_TO_ID");
                            if (meeting1 == false) {
                                String sql = "alter table meeting add SECRET_TO_ID text COMMENT '查看人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "PRIV_ID");
                            if (meeting2 == false) {
                                String sql = "alter table meeting add PRIV_ID text COMMENT '查看角色';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "TO_ID");
                            if (meeting3 == false) {
                                String sql = "alter table meeting add TO_ID text  COMMENT '查看部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "CYCLE");
                            if (meeting4 == false) {
                                String sql = "alter table meeting add CYCLE char(1)  DEFAULT '' COMMENT '周期性会议标记';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "CYCLE_NO");
                            if (meeting5 == false) {
                                String sql = "alter table meeting add CYCLE_NO int(11)  DEFAULT '0' COMMENT '周期性会议ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "M_FACT_ATTENDEE");
                            if (meeting6 == false) {
                                String sql = "alter table meeting add M_FACT_ATTENDEE text  COMMENT '实际参会人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting7 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "REASON");
                            if (meeting7 == false) {
                                String sql = "alter table meeting add REASON text   COMMENT '不批准原因';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting8 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "APPROVE_NAME");
                            if (meeting8 == false) {
                                String sql = "alter table meeting add APPROVE_NAME varchar(10)  DEFAULT '' COMMENT '审批人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting9 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "SEND_NAME");
                            if (meeting9 == false) {
                                String sql = "alter table meeting add SEND_NAME  varchar(10)  DEFAULT '' COMMENT '发送人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting10 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "TO_SCOPE");
                            if (meeting10 == false) {
                                String sql = "alter table meeting add TO_SCOPE char(1)  DEFAULT '1' COMMENT '是否提醒查看范围';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "TO_EMAIL");
                            if (meeting == false) {
                                String sql = "alter table meeting add TO_EMAIL char(1) DEFAULT '1' COMMENT '是否发送电子邮件提醒';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting33 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "M_PROPOSER");
                            if (meeting33 == false) {
                                String sql = "alter table meeting add M_PROPOSER varchar(10) COMMENT '通达会议表中的申请人字段，用来进行通达数据升级后同步uid';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting34 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "M_PROPOSER");
                            if (meeting34 == false) {
                                String sql = "alter table meeting add M_MANAGER varchar(20) DEFAULT '' COMMENT '通达会议表中的管理员字段，用来进行通达数据升级后同步uid';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting11 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "SMS2_REMIND");
                            if (meeting11 == true) {
                                String sql = "ALTER TABLE meeting CHANGE SMS2_REMIND SMS2_REMIND char(20) COLLATE utf8_bin DEFAULT NULL COMMENT '手机短信提醒出席人员,0：不提醒，1：提醒';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting12 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "SMS_REMIND");
                            if (meeting12 == true) {
                                String sql = "ALTER TABLE meeting CHANGE SMS_REMIND SMS_REMIND char(20) COLLATE utf8_bin DEFAULT NULL COMMENT '是否内部短信通知出席人员，使用内部短信提醒，选中为1，不选中为0';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting_equuipment = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_equuipment", "GROUP_YN");
                            if (meeting_equuipment == false) {
                                String sql = "alter table meeting_equuipment add GROUP_YN int(1)  DEFAULT '0' COMMENT '同类设备(0-没有,1-有)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting_room = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_room", "APPLY_WEEKDAYS");
                            if (meeting_room == false) {
                                String sql = "alter table meeting_room add APPLY_WEEKDAYS varchar(30) DEFAULT '1,2,3,4,5' COMMENT '允许申请的星期设置';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting_room21 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_room", "OPERATOR");
                            if (meeting_room21 == false) {
                                String sql = "alter table meeting_room add OPERATOR text COMMENT '通达会议室表中的管理员字段，用来进行通达数据升级后同步uid';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting_room22 = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_room", "SECRET_TO_ID");
                            if (meeting_room22 == false) {
                                String sql = "alter table meeting_room add SECRET_TO_ID text  COMMENT '通达会议室表中的申请人员字段，用来进行通达数据升级后同步uid';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-9-23
                             *  添加字段的作用: 预算设置
                             */
                            boolean sys_para_fl = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "BUDGET_EDIT_PRIV");
                            if (sys_para_fl == false) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('BUDGET_EDIT_PRIV', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            /*  *//**
                             *  添加者：张丽军
                             *  添加日期：2019-9-23
                             *  添加字段的作用: 预算设置
                             */
                            boolean sys_para_fla = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "BUDGET_EDIT_USER");
                            if (sys_para_fla == false) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('BUDGET_EDIT_USER', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            /*  2019-11-13 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean oa_source_used = Verification.CheckIsExistTable(conn, driver, url, username, password, "bonus_priv");
                            if (oa_source_used == false) {
                                String sql = "CREATE TABLE `oa_source_used`  (\n" +
                                        "  `SOURCEID` int(11) NOT NULL,\n" +
                                        "  `APPLY_DATE` datetime NOT NULL,\n" +
                                        "  `USER_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,\n" +
                                        "  PRIMARY KEY (`SOURCEID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean meeting_no = Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "MOBILE_NO");
                            if (meeting_no == false) {
                                String sql = "alter table meeting add MOBILE_NO varchar(255)  DEFAULT '' COMMENT '联系电话';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean vote_item = Verification.CheckIsExistfield(conn, driver, url, username, password, "vote_item", "ANONYMOUS");
                            if (vote_item == false) {
                                String sql = "alter table vote_item add ANONYMOUS text COMMENT '匿名名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean isopen = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "isopen");
                            if (isopen == true) {
                                String sql = "ALTER TABLE  EMAIL_SET DROP COLUMN isopen;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean SEND_AMOUNT = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "SEND_AMOUNT");
                            if (SEND_AMOUNT == false) {
                                String sql = "ALTER TABLE  EMAIL_SET ADD SEND_AMOUNT int(11)   COMMENT '群发数量';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean EXCLUDE_USER_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "EXCLUDE_USER_ID");
                            if (EXCLUDE_USER_ID == false) {
                                String sql = "ALTER TABLE  EMAIL_SET ADD EXCLUDE_USER_ID text   COMMENT '排除人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean ESS_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "ESS_ID");
                            if (ESS_ID == true) {
                                String sql = "ALTER TABLE  EMAIL_SET modify column ESS_ID int(11)  COMMENT '邮件审核设置ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean DEPT_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "DEPT_ID");
                            if (DEPT_ID == true) {
                                String sql = "ALTER TABLE  EMAIL_SET modify column DEPT_ID text  COMMENT '所属部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.9.9
                             *  添加字段的作用: 添加字段（修改会议表字段）
                             */
                            boolean USER_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "EMAIL_SET", "USER_ID");
                            if (USER_ID == true) {
                                String sql = "ALTER TABLE  EMAIL_SET modify column USER_ID text  COMMENT '审核人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.13
                             *  添加字段的作用: 添加字段（是否开启公告反馈）
                             */
                            boolean IS_OPIN = Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "IS_OPIN");
                            if (IS_OPIN == false) {
                                String sql = "alter table notify add IS_OPIN char(10) DEFAULT '0' COMMENT '是否开启公告反馈';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.13
                             *  添加字段的作用: 添加字段（开启栏位（1-2-3-4.....））
                             */
                            boolean OPINION_FIELDS = Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "OPINION_FIELDS");
                            if (OPINION_FIELDS == false) {
                                String sql = "alter table notify add OPINION_FIELDS varchar(255) DEFAULT NULL COMMENT '开启栏位（1-2-3-4.....）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.13
                             *  添加字段的作用: 添加字段（已反馈人员ID串）
                             */
                            boolean OPIN_USERS = Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "OPIN_USERS");
                            if (OPIN_USERS == false) {
                                String sql = "alter table notify add OPIN_USERS text NOT NULL COMMENT '已反馈人员ID串';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-12-13
                             *  作用: 公告反馈通知
                             */
                            boolean isExistCodeSMS_REMIND = Verification.CheckIsExistCode(conn, driver, url, username, password, "34", "SMS_REMIND");
                            if (isExistCodeSMS_REMIND == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( '34', '公告反馈通知', '', '', '', '', '', '', '02', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*  *
                             *  作用: 增加索引
                             *  创建日期:2019-12-17
                             *  创建者：张丽军
                             */
                            boolean I_CREATER = Verification.CheckIsExistIndex(conn, driver, url, username, password, "document", "creater");
                            if (I_CREATER == false) {
                                String sql = "ALTER  TABLE  `document`  ADD  INDEX `I_CREATER` (`creater`);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  *
                             *  作用: 增加索引
                             *  创建日期:2019-12-17
                             *  创建者：张丽军
                             */
                            boolean I_RNN_ID = Verification.CheckIsExistIndex(conn, driver, url, username, password, "document", "run_id");
                            if (I_RNN_ID == false) {
                                String sql = " ALTER  TABLE  `document`  ADD  INDEX `I_RNN_ID` (`run_id`);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-12-23 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean notify_opinion = Verification.CheckIsExistTable(conn, driver, url, username, password, "notify_opinion");
                            if (notify_opinion == false) {
                                String sql = "CREATE TABLE `notify_opinion` (\n" +
                                        "  `OP_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `NOTY_ID` int(11) NOT NULL COMMENT '公告ID',\n" +
                                        "  `USER_ID` varchar(200) NOT NULL COMMENT '填报用户USER_ID',\n" +
                                        "  `STATE` char(10) DEFAULT NULL COMMENT '退回状态（0-正常，1-已退回未修改，2-修改完成重新提交）',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称串',\n" +
                                        "  `FIELD1` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD2` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD3` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD4` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD5` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD6` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD7` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD8` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD9` varchar(255) DEFAULT NULL,\n" +
                                        "  `FIELD10` varchar(255) DEFAULT NULL,\n" +
                                        "  `INUPUT_TIME` datetime NOT NULL COMMENT '添加时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '修改时间',\n" +
                                        "  PRIMARY KEY (`OP_ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='公告反馈填报表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2019-12-23
                             *  作用: 救援任务通知
                             */
                            boolean isExistCodeNOTI = Verification.CheckIsExistCode(conn, driver, url, username, password, "35", "SMS_REMIND");
                            if (isExistCodeNOTI == false) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( '35', '救援任务通知', '', '', '', '', '', '', '02', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.23
                             *  添加字段的作用: 添加字段（已反馈人员ID串）
                             */
                            boolean PARENT_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_type", "PARENT_ID");
                            if (PARENT_ID == false) {
                                String sql = "ALTER TABLE `cp_asset_type` add  `PARENT_ID` int(11) DEFAULT NULL COMMENT '父级id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *张丽军  2019.12.23
                             *  添加字段的作用: 添加字段（已反馈人员ID串）
                             */
                            boolean USER_TYPE = Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "USER_TYPE");
                            if (USER_TYPE == false) {
                                String sql = "ALTER TABLE `hr_staff_info` add  `USER_TYPE` char(20) DEFAULT '0' COMMENT '是否应急救援人员  0 否 1 是';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *张丽军  2019.12.23
                             *  添加字段的作用: 添加字段（已反馈人员ID串）
                             */
                            boolean RESCUE_TYPE = Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "RESCUE_TYPE");
                            if (RESCUE_TYPE == false) {
                                String sql = "ALTER TABLE `cp_asset_reflect` add  `RESCUE_TYPE` char(20) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '是否应急设备 0否 1是';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-12-23 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean cp_asset_dispatch = Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_asset_dispatch");
                            if (cp_asset_dispatch == false) {
                                String sql = "CREATE TABLE `cp_asset_dispatch` (\n" +
                                        "  `DISP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `DISP_USER_ID` varchar(50) DEFAULT NULL COMMENT '调度人',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '调度时间',\n" +
                                        "  `COVER_USER_ID` varchar(50) DEFAULT NULL COMMENT '被调度人员ID',\n" +
                                        "  `COVER_ASSET_ID` varchar(50) DEFAULT NULL COMMENT '被调拨资产ID',\n" +
                                        "  `DISP_TYPE` char(10) DEFAULT NULL COMMENT '调度类型（1-人员，2-资产）',\n" +
                                        "  `DISP_REMARK` varchar(255) DEFAULT NULL COMMENT '调度备注',\n" +
                                        "  `CRAS_ID` int(11) DEFAULT NULL COMMENT '被调度的救援事件ID',\n" +
                                        "  `COVER_CRAS_ID` int(11) DEFAULT NULL COMMENT '调度到的救援事件ID',\n" +
                                        "  PRIMARY KEY (`DISP_ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='应急救援调度表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /*  2019-12-23 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean crash_dispatch = Verification.CheckIsExistTable(conn, driver, url, username, password, "crash_dispatch");
                            if (crash_dispatch == false) {
                                String sql = "CREATE TABLE `crash_dispatch` (\n" +
                                        "  `CRAS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `PARE_ID` int(11) DEFAULT NULL COMMENT '所属救援事件Id',\n" +
                                        "  `EVENT_NAME` varchar(250) DEFAULT NULL COMMENT '子任务名称',\n" +
                                        "  `HAPPEN_TIME` datetime DEFAULT NULL COMMENT '子任务发生时间',\n" +
                                        "  `HAPPEN_PLACE` varchar(250) DEFAULT NULL COMMENT '子任务发生地点',\n" +
                                        "  `EVENT_DESCRIBE` text COMMENT '任务描述',\n" +
                                        "  `RESCUE_USER` text COMMENT '应急领导小组',\n" +
                                        "  `RESCUE_EQUIPMENT` text COMMENT '参与救援设备',\n" +
                                        "  `RESCUE_USER_NAME` text COMMENT '应急领导小组人员名称',\n" +
                                        "  `RESCUE_EQUIPMENT_NAME` text COMMENT '参与救援设备名称',\n" +
                                        "  `EVENT_STATE` char(11) DEFAULT '0' COMMENT '事件状态 0 未开始 1 进行中 2 已结束',\n" +
                                        "  `RESCUE_PERSONS` text COMMENT '参与救援人员',\n" +
                                        "  `RESCUE_PERSONS_NAME` text COMMENT '参与救援人员名称',\n" +
                                        "  `REACTION_USER` text COMMENT '应急反应执行小组',\n" +
                                        "  `REACTION_USER_NAME` text COMMENT '应急反应执行小组名称',\n" +
                                        "  `CONFIRM_USER` varchar(50) DEFAULT NULL COMMENT '人员确认人',\n" +
                                        "  `CONFIRM_TIME` datetime DEFAULT NULL COMMENT '最后一次人员确认时间',\n" +
                                        "  PRIMARY KEY (`CRAS_ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='应急救援任务表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*  2019-12-23 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean crash_dispatch_parent = Verification.CheckIsExistTable(conn, driver, url, username, password, "crash_dispatch_parent");
                            if (crash_dispatch_parent == false) {
                                String sql = "CREATE TABLE `crash_dispatch_parent` (\n" +
                                        "  `CRAS_PARE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `EVENT_NAME` varchar(250) DEFAULT NULL COMMENT '事件名称',\n" +
                                        "  `HAPPEN_TIME` datetime DEFAULT NULL COMMENT '发生时间',\n" +
                                        "  `HAPPEN_PLACE` varchar(250) DEFAULT NULL COMMENT '发生地点',\n" +
                                        "  `EVENT_DESCRIBE` text COMMENT '事件描述',\n" +
                                        "  `RESCUE_USER` text COMMENT '应急领导小组',\n" +
                                        "  `RESCUE_USER_NAME` text COMMENT '应急领导小组人员名称',\n" +
                                        "  `EVENT_STATE` char(10) DEFAULT '0' COMMENT '事件状态 0 未开始 1 进行中 2 已结束',\n" +
                                        "  `RELEASR_TIME` datetime DEFAULT NULL COMMENT '发布时间',\n" +
                                        "  `END_TIME` datetime DEFAULT NULL COMMENT '事件结束时间',\n" +
                                        "  `REACTION_USER` text COMMENT '应急反应执行小组',\n" +
                                        "  `REACTION_USER_NAME` text COMMENT '应急反应执行小组名称',\n" +
                                        "  PRIMARY KEY (`CRAS_PARE_ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='应急救援主表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-12-23 张丽军
                             *      创建表 oa_source_used 资源申请记录
                             */
                            boolean cp_asset_group = Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_asset_group");
                            if (cp_asset_group == false) {
                                String sql = "CREATE TABLE `cp_asset_group` (\n" +
                                        "  `group_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '分组id',\n" +
                                        "  `group_name` varchar(255) DEFAULT NULL COMMENT '分组名称',\n" +
                                        "  `asset_ids` text COMMENT '关联cp_asset_reflect表的ids',\n" +
                                        "  PRIMARY KEY (`group_id`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='资产分组表，救援调度设备分组';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*  2019-12-23 张丽军
                             *      创建表 hr_evaluate 资源申请记录
                             */
                            boolean hr_evaluate = Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_evaluate");
                            if (hr_evaluate == false) {
                                String sql = "CREATE TABLE `hr_evaluate` (\n" +
                                        "  `EV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',\n" +
                                        "  `USER_ID` varchar(255) NOT NULL COMMENT '被评价人',\n" +
                                        "  `EV_LEVEL` char(10) NOT NULL COMMENT '综合评价(1优秀，2一般，3黑名单)',\n" +
                                        "  `EV_SKILL` int(11) NOT NULL COMMENT '工作技能',\n" +
                                        "  `EV_ATTITUDE` int(11) NOT NULL COMMENT '工作态度',\n" +
                                        "  `PROJECT` varchar(255) NOT NULL COMMENT '所在项目',\n" +
                                        "  `EV_DETAIL` text NOT NULL COMMENT '详细评价',\n" +
                                        "  `EV_USER` varchar(255) NOT NULL COMMENT '评价人',\n" +
                                        "  `EV_TIME` datetime NOT NULL COMMENT '评价时间',\n" +
                                        "  PRIMARY KEY (`EV_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='人员评价表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.23
                             *  添加字段的作用: 添加字段（最低售价）
                             */
                            boolean PRODUCT_LOWPRICE = Verification.CheckIsExistfield(conn, driver, url, username, password, "crm_product", "PRODUCT_LOWPRICE");
                            if (PRODUCT_LOWPRICE == false) {
                                String sql = "ALTER TABLE crm_product ADD COLUMN PRODUCT_LOWPRICE DOUBLE DEFAULT NULL COMMENT '最低售价';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.13
                             *  添加字段的作用: 添加字段（企业微信中的应用id）
                             */
                            boolean qiyeweixin_config3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "qiyeweixin_config", "agentid");
                            if (qiyeweixin_config3 == false) {
                                String sql = "alter table qiyeweixin_config add agentid varchar(255)  DEFAULT '' COMMENT '企业微信中的应用id(agentid)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            /* *
                             *张丽军  2019.12.13
                             *  添加字段的作用: 添加字段（OA的访问地址）
                             */
                            boolean qiyeweixin_config2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "qiyeweixin_config", "oa_url");
                            if (qiyeweixin_config2 == false) {
                                String sql = "alter table qiyeweixin_config add oa_url varchar(255)  DEFAULT '' COMMENT 'OA的访问地址';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.27
                             *  添加字段的作用: 添加字段（應急調度）
                             */
                            boolean isExistMenu95 = Verification.CheckIsExistMenu(conn, driver, url, username, password, "95");
                            if (isExistMenu95 == false) {
                                String sql = "INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('95', '应急调度', 'Emergency Dispatch', '應急調度', '', '', '', '', 'record');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.27
                             *  添加字段的作用: 添加字段（应急调度管理）
                             */
                            boolean isExistFunction2216 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2216");
                            if (isExistFunction2216 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2216', '9503', '应急调度管理', NULL, NULL, NULL, NULL, NULL, '/crash/intRescueDispatch', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *张丽军  2019.12.27
                             *  添加字段的作用: 添加字段（设备分组管理）
                             */
                            boolean isExistFunction2217 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2217");
                            if (isExistFunction2217 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2217', '9506', '设备分组管理', NULL, NULL, NULL, NULL, NULL, '/assetGroup/index', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /* *
                             *liujian  2019.12.30
                             *  添加字段的作用: 添加字段（人员评价管理）
                             */
                            boolean isExistFunction493 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "493");
                            if (isExistFunction493 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('493', '5013', '人员评价管理', NULL, NULL, NULL, NULL, NULL, '', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *liujian  2019.12.30
                             *  添加字段的作用: 添加字段（人员评价）
                             */
                            boolean isExistFunction494 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "494");
                            if (isExistFunction494 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('494', '501301', '人员评价', NULL, NULL, NULL, NULL, NULL, '/hrEvaluate/staffEvaluation', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /* *
                             *liujian  2019.12.30
                             *  添加字段的作用: 添加字段（查看评价）
                             */
                            boolean isExistFunction495 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "495");
                            if (isExistFunction495 == false) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('495', '501302', '查看评价', NULL, NULL, NULL, NULL, NULL, '/hrEvaluate/evaluationView', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**   2019-12-27
                             *  作用: 救援任务通知
                             */
                            boolean isExiststaffType = Verification.CheckIsExistCode(conn, driver, url, username, password, "staffType", "");
                            if (isExiststaffType == false) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('staffType', '员工类型', NULL, NULL, NULL, NULL, NULL, NULL, '12', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 项目名称
                             */
                            boolean isExistCode01 = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "staffType");
                            if (isExistCode01 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('01', '技术开发', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'staffType', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 项目名称
                             */
                            boolean isExistCode02 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "staffType");
                            if (isExistCode02 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('02', '技术支持', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'staffType', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**   2018-1-26
                             *  作用: 项目名称
                             */
                            boolean isExistCode03 = Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "staffType");
                            if (isExistCode03 == false) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('03', '销售', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'staffType', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "hierarchical_global", "GLOBAL_PERSON")) {
                                String sql = "ALTER TABLE hierarchical_global MODIFY COLUMN GLOBAL_PERSON text DEFAULT NULL ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "hierarchical_global", "GLOBAL_DEPT")) {
                                String sql = "ALTER TABLE hierarchical_global MODIFY COLUMN GLOBAL_DEPT text DEFAULT NULL";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "hierarchical_global", "GLOBAL_PRIV")) {
                                String sql = "ALTER TABLE hierarchical_global MODIFY COLUMN GLOBAL_PRIV text DEFAULT NULL";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*     *
                             *   添加字段应用关联表关联id
                             */
                            boolean RELATION_ID = Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "RELATION_ID");
                            if (RELATION_ID == false) {
                                String sql = "ALTER TABLE flow_process ADD `RELATION_ID` int(11) DEFAULT NULL COMMENT '应用关联表关联id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*
                             *  添加菜单  资产管理-资产申请
                             */
                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2072")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`,`FUNC_NAME`,`FUNC_NAME1`,`FUNC_NAME2`,`FUNC_NAME3`,`FUNC_NAME4`,`FUNC_NAME5`,`FUNC_CODE`,`FUNC_EXT`,`ISOPEN_NEW`,`SEND_USER`,`SEND_KEY`,`IS_SHOW_FUNC`)VALUES(2072,'606503','资产申请',NULL,NULL,NULL,NULL,NULL,'/eduFixAssets/fixAssetsApply','',NULL,NULL,NULL,0); ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*   *
                             *  添加菜单  资产管理-资产审批
                             */
                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2073")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`,`FUNC_NAME`,`FUNC_NAME1`,`FUNC_NAME2`,`FUNC_NAME3`,`FUNC_NAME4`,`FUNC_NAME5`,`FUNC_CODE`,`FUNC_EXT`,`ISOPEN_NEW`,`SEND_USER`,`SEND_KEY`,`IS_SHOW_FUNC`)VALUES(2073,'606504','资产审批',NULL,NULL,NULL,NULL,NULL,'/eduFixAssets/cpfixAssetsApprove','',NULL,NULL,NULL,0); ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*   *
                             *  添加菜单  资产管理-资产盘点
                             */
                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2074")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`,`FUNC_NAME`,`FUNC_NAME1`,`FUNC_NAME2`,`FUNC_NAME3`,`FUNC_NAME4`,`FUNC_NAME5`,`FUNC_CODE`,`FUNC_EXT`,`ISOPEN_NEW`,`SEND_USER`,`SEND_KEY`,`IS_SHOW_FUNC`)VALUES(2074,'606505','资产盘点',NULL,NULL,NULL,NULL,NULL,'/eduFixAssets/cpfixAssetsInventory','',NULL,NULL,NULL,0);  ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*   *
                             *  添加菜单  资产管理-资产清单
                             */
                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2075")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`,`FUNC_NAME`,`FUNC_NAME1`,`FUNC_NAME2`,`FUNC_NAME3`,`FUNC_NAME4`,`FUNC_NAME5`,`FUNC_CODE`,`FUNC_EXT`,`ISOPEN_NEW`,`SEND_USER`,`SEND_KEY`,`IS_SHOW_FUNC`)VALUES(2075,'606506','资产清单',NULL,NULL,NULL,NULL,NULL,'/eduFixAssets/cpfixAssetsList','',NULL,NULL,NULL,0);   ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /*   *
                             *  添加菜单  资产管理-资产汇总
                             */
                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2076")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`,`FUNC_NAME`,`FUNC_NAME1`,`FUNC_NAME2`,`FUNC_NAME3`,`FUNC_NAME4`,`FUNC_NAME5`,`FUNC_CODE`,`FUNC_EXT`,`ISOPEN_NEW`,`SEND_USER`,`SEND_KEY`,`IS_SHOW_FUNC`)VALUES(2076,'606507','资产汇总',NULL,NULL,NULL,NULL,NULL,'/eduFixAssets/cpfixAssetsCollection','',NULL,NULL,NULL,0);   ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**
                             * 修改菜单 保管人确认为资产登记
                             */

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "5021")) {
                                String sql = "update `sys_function` set `FUNC_NAME`='资产登记' where `FUNC_ID`='5021';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /*     *
                             *   是否开启正文
                             */

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "document_flag")) {
                                String sql = "ALTER TABLE  flow_type ADD document_flag char(10)  COMMENT '是否开启正文 0-否 1-是';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }



                            /*     *
                             *   是否开启版式文件
                             */

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "document_layout")) {
                                String sql = "ALTER TABLE  flow_type ADD document_layout char(10)  COMMENT '正文版式文件格式pdf和aip 1-pdf  2-aip';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            /**
                             * 修改菜单 电子文件设置
                             */

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "3014")) {
                                String sql = "update sys_function set menu_id = 'z011',func_name= '电子文件设置' where func_id= 3014;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**
                             * 修改菜单 模板管理
                             */

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "3015")) {
                                String sql = "update sys_function set menu_id = 'z01101',func_name= '模板管理' where func_id= 3015;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            /**
                             * 修改菜单 签章
                             */

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "3016")) {
                                String sql = "update sys_function set menu_id = 'z01103' where func_id= 3016;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                               /*    *
                        张丽军
                        2018-11-28
                     *  作用: 添加数据（部门添加离职部门）
                     */
                            boolean checkIsExisDept_0 = Verification.CheckIsExistDept1(conn, driver, url, username, password, "99999999");
                            if (checkIsExisDept_0 == false) {
                                boolean f = Verification.CheckIsExistDept(conn, driver, url, username, password, "0");
                                if (f == false) {
                                    String sql = "INSERT INTO `department` (`DEPT_ID`, `DEPT_NAME`, `TEL_NO`, `FAX_NO`, `DEPT_ADDRESS`, `DEPT_NO`, `DEPT_PARENT`, `MANAGER`, `ASSISTANT_ID`, `LEADER1`, `LEADER2`, `DEPT_FUNC`, `IS_ORG`, `ORG_ADMIN`, `DEPT_EMAIL_AUDITS_IDS`, `WEIXIN_DEPT_ID`, `DINGDING_DEPT_ID`, `G_DEPT`, `ClASSIFY_ORG`, `ClASSIFY_ORG_ADMIN`, `DEPT_CODE`, `SMS_GATE_ACCOUNT`, `SMS_GATE_PASSWORD`) VALUES ('0', '离职', '', '', ' ', '0', '99999999', ' ', ' ', ' ', ' ', ' ', '0', ' ', '', '0', '0', '0', '0', ' ', '', '', '');";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }

                           /*   *
                           张丽军
                           2018-11-28
                     *  修改字段的作用: 修改主键ID
                     */
                            boolean checkIsExisDept = Verification.CheckIsExistDept1(conn, driver, url, username, password, "99999999");
                            if (checkIsExisDept == true) {
                                String sql = "UPDATE department SET DEPT_ID = 0 where DEPT_PARENT = 99999999; ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //公文
                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "DOC_EXCHANGE_UNIT_TYPE", "")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES " +
                                        "('DOC_EXCHANGE_UNIT_TYPE', '公文交换单位类型', NULL, NULL, NULL, NULL, NULL, NULL, '', '', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistParam(conn, driver, url, username, password, "OFFICE_EDIT")) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('OFFICE_EDIT', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "TEMPLATE_ID")) {
                                String sql = "ALTER TABLE flow_type ADD `TEMPLATE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '默认公文模板ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "template", "ATTACHMENT_ID")) {
                                String sql = "ALTER TABLE template ADD `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '模板文件ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "template", "ATTACHMENT_NAME")) {
                                String sql = "ALTER TABLE template ADD `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '模板文件名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "OPERATION_BUTTON")) {
                                String sql = "ALTER TABLE flow_process ADD `OPERATION_BUTTON` varchar(255) DEFAULT NULL COMMENT '关联操作设置（flow_operation表）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "document_flag")) {
                                String sql = "ALTER TABLE  flow_type ADD document_flag char(10)  COMMENT '是否开启正文 0-否 1-是';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "document_layout")) {
                                String sql = "ALTER TABLE  flow_type ADD document_layout char(10)  COMMENT '正文版式文件格式pdf和aip 1-pdf  2-aip';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3033")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('3033', '6510', '来文接收', NULL, NULL, NULL, NULL, NULL, 'document/receive', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "3031")) {
                                String sql = "UPDATE `sys_function` SET FUNC_NAME='公文设置',FUNC_CODE='document/documentset' where FUNC_ID='3031';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3034")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('3034', '6512', '下发公文', NULL, NULL, NULL, NULL, NULL, '/documentOrg/issue', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "514")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('514', '109073', '关联操作设置', NULL, NULL, NULL, NULL, NULL, 'operation/index', '', '0', '0', NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "document_exchange_set")) {
                                String sql = "CREATE TABLE `document_exchange_set` (\n" +
                                        "  `EXCHANGE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `EXCHANGE_TYPE` char(5) DEFAULT '0' COMMENT '交换类型(内部交换-0，外部交换-1)',\n" +
                                        "  `UNIT_TYPE` varchar(255) DEFAULT NULL COMMENT '单位类型(SYS_CODE表）',\n" +
                                        "  `FROM_UNIT` varchar(255) DEFAULT NULL COMMENT '发文单位名',\n" +
                                        "  `RECEIVE_UNIT` varchar(255) DEFAULT NULL COMMENT '收文单位名',\n" +
                                        "  `EXCHANGE_DEPT_ID` int(11) DEFAULT NULL,\n" +
                                        "  `EXCHANGE_USER_ID` text COMMENT '部门对应用户',\n" +
                                        "  `DOCUMENT_PRIV` varchar(50) DEFAULT '1' COMMENT '权限(收文-1，发文-2)',\n" +
                                        "  `CREATE_USER_ID` varchar(255) DEFAULT NULL COMMENT '创建人',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `PARENT_DEPT` varchar(10) DEFAULT NULL COMMENT '上级部门ID',\n" +
                                        "  `CHILD_DEPTS` text COMMENT '下级部门ID串',\n" +
                                        "  PRIMARY KEY (`EXCHANGE_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='公文交换表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_operation")) {
                                String sql = "CREATE TABLE `flow_operation` (\n" +
                                        "  `OP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `OP_NO` varchar(255) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `OP_NAME` varchar(255) DEFAULT NULL COMMENT '操作项名称',\n" +
                                        "  `USE_FUNC` varchar(255) DEFAULT NULL COMMENT '调用程序的方法',\n" +
                                        "  `PIC_NAME` varchar(255) DEFAULT NULL COMMENT '图标',\n" +
                                        "  PRIMARY KEY (`OP_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='关联操作设置';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;

                                sql = "INSERT INTO `flow_operation` (`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES ('1', '1', '公文分发', 'documentExchangeReceive/insertDocumentReceive', 'conditionsSet');\n" +
                                        "INSERT INTO `flow_operation` (`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES ('2', '2', '公文补发', 'documentExchangeReceive/insertDocumentReceive', 'conditionsSet');\n" +
                                        "INSERT INTO `flow_operation` (`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES ('3', '5', '查询分发情况', 'documentExchangeReceive/selectByRunId', 'requiredFields');\n" +
                                        "INSERT INTO `flow_operation` (`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES ('8', '6', '工作交办', '/flowAssign/saveWork', 'conditionsSet');\n" +
                                        "INSERT INTO `flow_operation` (`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES ('13', '13', '内部分发', '', 'conditionsSet');";
                                st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "document_exchange_receive")) {
                                String sql = "CREATE TABLE `document_exchange_receive` (\n" +
                                        "  `RECEIVE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增字段',\n" +
                                        "  `DOC_TITLE` varchar(255) DEFAULT NULL COMMENT '文件标题',\n" +
                                        "  `FROM_UNIT` varchar(255) DEFAULT NULL COMMENT '来文单位',\n" +
                                        "  `DOC_NO` varchar(255) DEFAULT NULL COMMENT '文件字号',\n" +
                                        "  `FROM_RUN_ID` int(11) DEFAULT NULL COMMENT '发文流程RUN_ID',\n" +
                                        "  `FROM_TIME` datetime DEFAULT NULL COMMENT '来文时间',\n" +
                                        "  `RECEIVE_STATUS` char(5) DEFAULT '0' COMMENT '签收状态（待签收-0，已签收-1）',\n" +
                                        "  `RECEIVE_DEPT_ID` int(11) DEFAULT NULL COMMENT '收文部门DEPT_ID',\n" +
                                        "  `RECEIVE_UNIT` varchar(255) DEFAULT NULL COMMENT '收文单位',\n" +
                                        "  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '收文时间',\n" +
                                        "  `RECEIVE_USER` varchar(255) DEFAULT NULL COMMENT '登记人',\n" +
                                        "  `RECEIVE_RUN_ID` int(11) DEFAULT NULL COMMENT '收文流程RUN_ID',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称串',\n" +
                                        "  `ATTACHMENT_ID2` text COMMENT '正文ID',\n" +
                                        "  `ATTACHMENT_NAME2` text COMMENT '正文名称',\n" +
                                        "  PRIMARY KEY (`RECEIVE_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='来文接收表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "document_exchange_receive", "RECEIVE_STATUS")) {
                                String sql = "ALTER TABLE `document_exchange_receive` MODIFY COLUMN `RECEIVE_STATUS` char(5) NULL DEFAULT '0' COMMENT '签收状态（待签收-0，已签收-1,已收回-2)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "RELATION_ID")) {
                                String sql = "ALTER TABLE flow_process ADD `RELATION_ID` int(11) DEFAULT NULL COMMENT '应用关联表关联id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "139")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('139', '601009', '视频会议设置', NULL, NULL, NULL, NULL, NULL, 'video/videoIndex', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "VIDEO_CONF_ID")) {
                                String sql = "alter table meeting add `VIDEO_CONF_ID` char(100) comment '服务端视频会议室Id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "VIDEO_CONF_FLAG")) {
                                String sql = "alter table meeting add VIDEO_CONF_FLAG char(10) comment '是否是视频会议(0否,1是)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "video_conf")) {
                                String sql = "CREATE TABLE `video_conf` (\n" +
                                        "  `ID` int(1) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `SERVER` varchar(50) NOT NULL COMMENT '地址ip',\n" +
                                        "  `PORT` varchar(50) NOT NULL COMMENT '端口',\n" +
                                        "  `COMPANY_ID` varchar(50) NOT NULL COMMENT '企业ID',\n" +
                                        "  PRIMARY KEY (`ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频会议设置';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "MEET_CODE")) {
                                String sql = "ALTER TABLE  `meeting` add `MEET_CODE` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '参会验证码';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "515")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('515', '109075', '常用意见设置', NULL, NULL, NULL, NULL, NULL, '/flowOpinion/opinionSetting', '', NULL, NULL, NULL, '0');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_opinion")) {
                                String sql = "CREATE TABLE `flow_opinion` (\n" +
                                        "  `OPINION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `OPINION_CONTENT` text COMMENT '意见模板内容',\n" +
                                        "  `CREATE_USER` varchar(50) DEFAULT NULL COMMENT '所属人',\n" +
                                        "  `OPINION_TYPE` varchar(10) DEFAULT NULL COMMENT '意见类型(0-公共，1个人)',\n" +
                                        "  PRIMARY KEY (`OPINION_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='常用意见管理表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_assign")) {
                                String sql = "CREATE TABLE `flow_assign` (\n" +
                                        "  `ASSIGN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `RUN_ID` int(11) DEFAULT NULL COMMENT '流水号',\n" +
                                        "  `PRCS_ID` int(11) DEFAULT NULL COMMENT '流程实例步骤ID',\n" +
                                        "  `FLOW_PRCS` int(11) DEFAULT NULL COMMENT '步骤ID[设计流程中的步骤号]',\n" +
                                        "  `PRCS_NAME` varchar(200) DEFAULT NULL COMMENT '步骤名称',\n" +
                                        "  `ASSIGN_USER` varchar(50) DEFAULT NULL COMMENT '交办人',\n" +
                                        "  `ASSIGN_TIME` datetime DEFAULT NULL COMMENT '交办时间',\n" +
                                        "  `ASSIGN_TASK` text COMMENT '交办任务',\n" +
                                        "  `SING_YN` varchar(10) DEFAULT '0' COMMENT '是否允许填写会签意见(0不允许，1允许)',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '交办附件ID窜',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '交办附件NAME窜',\n" +
                                        "  `HANDLE_HOUR` varchar(20) DEFAULT NULL COMMENT '办理小时数',\n" +
                                        "  `HANDLE_USER` varchar(50) DEFAULT NULL COMMENT '办理人',\n" +
                                        "  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '任务接收时间',\n" +
                                        "  `TASK_FEEDBACK` text COMMENT '办理汇报',\n" +
                                        "  `FD_ATTACHMENT_ID` text COMMENT '办理附件ID窜',\n" +
                                        "  `FD_ATTACHMENT_NAME` text COMMENT '办理附件NAME窜',\n" +
                                        "  `PARENT_ASSIGN_ID` int(255) DEFAULT '0' COMMENT '上一级任务ID',\n" +
                                        "  `HANDLE_STATUS` int(10) DEFAULT '0' COMMENT '办理状态(0未接收，1办理中，2办结)',\n" +
                                        "  PRIMARY KEY (`ASSIGN_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程交办表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3035")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('3035', '7005', '借阅管理', NULL, NULL, NULL, NULL, NULL, '/RmsLendController/paperManage', '', '0', NULL, NULL, '0');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3036")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('3036', '7006', '档案查阅', NULL, NULL, NULL, NULL, NULL, '/rmsRoll/consult', '', NULL, NULL, NULL, '0');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "rms_lend", "TYPE")) {
                                String sql = "ALTER TABLE  rms_lend ADD  `TYPE` varchar(10) NOT NULL COMMENT '状态(0-数据来源于文件管理 ，1-数据来源于案卷管理)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "crm_manager", "MANAGER_ID")) {
                                String sql = "ALTER TABLE crm_manager modify column MANAGER_ID text COMMENT '主管用户名串';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "AUTO_ARCHIVE_SET")) {
                                String sql = "ALTER TABLE  flow_process ADD AUTO_ARCHIVE_SET text COMMENT '归档设置';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "TIME_AUTO_TURN")) {
                                String sql = "ALTER TABLE flow_process ADD TIME_AUTO_TURN varchar(10) DEFAULT '0' COMMENT '超时自动转交(0-不自动转,1-自动转)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "sys_rule_id")) {
                                String sql = "ALTER TABLE document ADD `sys_rule_id` int(11) DEFAULT '0' COMMENT '自动编号规则ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "SYS_RULE_YN")) {
                                String sql = "ALTER TABLE flow_type ADD `SYS_RULE_YN` char(10) DEFAULT '0' COMMENT '是否允许选择文号类型(0-不允许,1-允许)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "cas_config", "CAS_INTERFACE")) {
                                String sql = "ALTER TABLE cas_config ADD `CAS_INTERFACE` varchar(255) DEFAULT NULL COMMENT '心通达OA单点登录接口地址(如GsuboSso/ssoLogin),过滤器不拦截';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "vehicle", "V_DRIVER")) {
                                String sql = "ALTER TABLE vehicle modify column V_DRIVER varchar(255);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "user_welink")) {
                                String sql = "CREATE TABLE `user_welink` (\n" +
                                        "  `OA_USER_ID` varchar(255) DEFAULT NULL COMMENT 'OA中用户的USER_ID',\n" +
                                        "  `WL_USER_ID` varchar(255) DEFAULT NULL COMMENT 'WeLink中的用户的USER_ID'\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OA用户和WeLink用户绑定表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "WELINK_APPID")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('WELINK_APPID', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "WELINK_APPSECRET")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('WELINK_APPSECRET', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1
                            }


                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "12", "portals_show")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( '12', '待阅事宜', NULL, NULL, NULL, NULL, NULL, NULL, '12', 'portals_show', '1', '/img/main_img/app/dysy.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "rms_file", "ATTACHMENT_ID2")) {
                                String sql = "ALTER TABLE rms_file ADD `ATTACHMENT_ID2` text COMMENT '文件正文ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "rms_file", "ATTACHMENT_NAME2")) {
                                String sql = "ALTER TABLE rms_file  ADD `ATTACHMENT_NAME2` text COMMENT '文件正文名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_rule", "PRIV_USER")) {
                                String sql = "ALTER TABLE sys_rule ADD PRIV_USER  text DEFAULT NULL COMMENT '授权人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_rule", "PRIV_DEPT")) {
                                String sql = "ALTER TABLE sys_rule ADD PRIV_DEPT  text DEFAULT NULL COMMENT '授权部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_rule", "PRIV_ROLE")) {
                                String sql = "ALTER TABLE sys_rule ADD PRIV_ROLE  text DEFAULT NULL COMMENT '授权角色';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "rep_data")) {
                                String sql = "CREATE TABLE `rep_data` (\n" +
                                        "  `FLOW_ID` int(11) NOT NULL,\n" +
                                        "  `FIELD_ID` int(11) NOT NULL COMMENT '报表字段Id',\n" +
                                        "  `DATA` varchar(255) DEFAULT NULL COMMENT '填报信息'\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='填报数据表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "rep_field")) {
                                String sql = "CREATE TABLE `rep_field` (\n" +
                                        "  `FIELD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `REP_TABLE_ID` int(11) NOT NULL COMMENT '报表Id',\n" +
                                        "  `FILED_NO` int(11) DEFAULT NULL COMMENT '字段排序号',\n" +
                                        "  `FIELD_NAME` varchar(255) NOT NULL COMMENT '字段名称',\n" +
                                        "  `FIELD_GROUP` varchar(255) DEFAULT NULL COMMENT '字段所属分组',\n" +
                                        "  `FIELD_TYPE` varchar(10) DEFAULT '1' COMMENT '字段类型 1单行文本 2单行数字  3多行文本  4日期 5单选 6 多选',\n" +
                                        "  `FIELD_CONTENT` text COMMENT '选项内容(多选项，“/” 分隔，例：男/女/未知)',\n" +
                                        "  `FIELD_DESC` varchar(255) DEFAULT NULL COMMENT '字段说明',\n" +
                                        "  `FIELD_SIZE` int(11) DEFAULT NULL COMMENT '字段长度（空为不限制长度）',\n" +
                                        "  `ISMUST` char(10) NOT NULL DEFAULT '0' COMMENT '是否必填字段（0-非必填，1-必填字段）默认非必填',\n" +
                                        "  `ISGROUP` char(10) NOT NULL DEFAULT '0' COMMENT '是否分组统计字段（0-否，1-是） 默认否，分组统计字段需要进行分组小计',\n" +
                                        "  `READONLY` char(10) DEFAULT '0' COMMENT '是否只读属性0-否，1-是',\n" +
                                        "  PRIMARY KEY (`FIELD_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='报表字段表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "rep_flow")) {
                                String sql = "CREATE TABLE `rep_flow` (\n" +
                                        "  `FLOW_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `REP_TABLE_ID` int(11) DEFAULT NULL COMMENT '所属报表Id',\n" +
                                        "  `USER_ID` varchar(255) DEFAULT NULL COMMENT '填写人USER_ID',\n" +
                                        "  `FLOW_TIME` datetime DEFAULT NULL COMMENT '填报时间',\n" +
                                        "  PRIMARY KEY (`FLOW_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='填报信息表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "rep_report")) {
                                String sql = "CREATE TABLE `rep_report` (\n" +
                                        "  `FLOW_ID` int(11) NOT NULL COMMENT '主键',\n" +
                                        "  `REP_TABLE_ID` int(11) NOT NULL COMMENT '报表ID',\n" +
                                        "  `FLOW_DATE` date NOT NULL COMMENT '报表日期，联合报表ID即可删除当日此报表数据',\n" +
                                        "  `SCHOOL_ID` int(11) NOT NULL COMMENT '学校ID，取当前用户的一级部门ID，用于与部门表联合查询学校编码、学校名称、学校类型等信息',\n" +
                                        "  `DATA1` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA2` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA3` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA4` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA5` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA6` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA7` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA8` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA9` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA10` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA11` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA12` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA13` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA14` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA15` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA16` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA17` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA18` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA19` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA20` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA21` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA22` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA23` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA24` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA25` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA26` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA27` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA28` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA29` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA30` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA31` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA32` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA33` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA34` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA35` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA36` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA37` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA38` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA39` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA40` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA41` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA42` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA43` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA44` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA45` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA46` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA47` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA48` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA49` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  `DATA50` varchar(255) DEFAULT NULL COMMENT '数值',\n" +
                                        "  PRIMARY KEY (`FLOW_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汇总统计表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "rep_table")) {
                                String sql = "CREATE TABLE `rep_table` (\n" +
                                        "  `REP_TABLE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `REP_TABLE_NAME` varchar(255) NOT NULL COMMENT '报表名称',\n" +
                                        "  `VIEW_USER_ID` text COMMENT '查阅权限（用户）',\n" +
                                        "  `VIEW_PRIV_ID` text COMMENT '查阅权限（角色）',\n" +
                                        "  `VIEW_DEPT_ID` text COMMENT '查阅权限（部门）',\n" +
                                        "  `MANAGE_USER_ID` text COMMENT '管理权限(人员)',\n" +
                                        "  `MANAGE_PRIV_ID` text COMMENT '管理权限(角色)',\n" +
                                        "  `MANAGE_DEPT_ID` text COMMENT '管理权限(部门)',\n" +
                                        "  `SORT_NO` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `CLOSING_TIME` datetime DEFAULT NULL COMMENT '填报截止时间',\n" +
                                        "  `STATUS` varchar(10) NOT NULL DEFAULT '0' COMMENT '报表状态（0-未启用，1-进行中，2-已停止,3-已删除）',\n" +
                                        "  PRIMARY KEY (`REP_TABLE_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='数据上报报表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "83")) {
                                String sql = "INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('83', '数据报表', 'Data report', '数据报表', '', '', '', '', 'record');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2270")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2270', '8305', '数据上报', NULL, NULL, NULL, NULL, NULL, '/repData/dataReport', '', '0', NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2271")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2271', '8310', '数据汇总查询', '', '', '', '', '', '/repField/dataSummary', '', '0', '', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2272")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('2272', '8315', '报表设置', '', '', '', '', '', '/repField/epidemic', '', '0', '', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "qiyeweixin_config", "API_DOMAIN")) {
                                String sql = "ALTER TABLE qiyeweixin_config ADD API_DOMAIN  VARCHAR ( 255 ) DEFAULT '' COMMENT '企业微信API接口域名';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "522")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (522, '0510', '我的考试', NULL, NULL, NULL, NULL, NULL, '/course/myexam', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "519")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (519, '500620', '试题目录管理', NULL, NULL, NULL, NULL, NULL, 'tbExamList/tryDirectory', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "518")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (518, '500615', '试卷目录管理', NULL, NULL, NULL, NULL, NULL, 'tbExamList/testPaper', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "517")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (517, '500610', '试题管理', NULL, NULL, NULL, NULL, NULL, 'tbExamList/index', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "516")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (516, '500605', '试卷管理', NULL, NULL, NULL, NULL, NULL, 'tbExamList/testIndex', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "520")) {
                                String sql = "INSERT INTO  `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (520, '500625', '考试统计管理', NULL, NULL, NULL, NULL, NULL, 'tbExamList/testStatistics', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "05")) {
                                String sql = "INSERT INTO  `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('05', '我的培训', 'My Training', '我的培訓', '', '', '', '', 'knowledge');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "521")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (521, '0505', '我的课程', NULL, NULL, NULL, NULL, NULL, '/train/myCourse', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "523")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (523, '5006', '考试管理', NULL, NULL, NULL, NULL, NULL, '@tbExamList', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "510")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (510, '500507', '培训课程管理', NULL, NULL, NULL, NULL, NULL, '/train/index', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_feedback")) {
                                String sql = "CREATE TABLE `task_feedback` (\n" +
                                        "  `FEEDBACK_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `FEEDBACK_CONTENT` text NOT NULL COMMENT '反馈内容',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',\n" +
                                        "  `TASK_ID` int(11) NOT NULL COMMENT '任务ID',\n" +
                                        "  `PARENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '父级反馈ID',\n" +
                                        "  `CREATE_TIME` datetime NOT NULL COMMENT '创建日期',\n" +
                                        "  PRIMARY KEY (`FEEDBACK_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_manage")) {
                                String sql = "CREATE TABLE `task_manage` (\n" +
                                        "  `TASK_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `TASK_NAME` varchar(200) NOT NULL COMMENT '任务名',\n" +
                                        "  `TASK_DESC` text COMMENT '任务描述',\n" +
                                        "  `IMPORTANT_LEVEL` int(11) NOT NULL DEFAULT '0' COMMENT '重要级别,0普通1重要2紧急',\n" +
                                        "  `TYPE_ID` int(11) NOT NULL COMMENT '任务类别ID',\n" +
                                        "  `CREATE_USER` varchar(50) NOT NULL COMMENT '创建人',\n" +
                                        "  `MANAGE_USER` varchar(50) NOT NULL COMMENT '负责人',\n" +
                                        "  `TASK_STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '任务状态,0进行中1已完成',\n" +
                                        "  `CREATE_DATE` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `START_DATE` datetime DEFAULT NULL COMMENT '开始日期',\n" +
                                        "  `END_DATE` datetime DEFAULT NULL COMMENT '结束日期',\n" +
                                        "  `PARENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '父级任务ID,0为顶级',\n" +
                                        "  `PROGRESS` int(11) NOT NULL DEFAULT '0' COMMENT '任务进度百分比',\n" +
                                        "  `TASK_GRADE` int(11) DEFAULT '0' COMMENT '评分',\n" +
                                        "  `COMPLETE_DATE` datetime DEFAULT NULL COMMENT '完成日期',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称串',\n" +
                                        "  PRIMARY KEY (`TASK_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_order")) {
                                String sql = "CREATE TABLE `task_order` (\n" +
                                        "  `ORDER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `TASK_ID` int(11) NOT NULL COMMENT '任务类别名称',\n" +
                                        "  `PARENT_ID` int(11) NOT NULL COMMENT '任务父ID，方便同步移除子任务',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',\n" +
                                        "  `SORT_ID` int(11) NOT NULL COMMENT '排序ID',\n" +
                                        "  PRIMARY KEY (`ORDER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_reminds")) {
                                String sql = "CREATE TABLE `task_reminds` (\n" +
                                        "  `REMINDS_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `TASK_ID` int(11) NOT NULL COMMENT '任务ID',\n" +
                                        "  `REMIND_TYPE` int(11) NOT NULL COMMENT '提醒类型1 不提醒 2 自定义提醒 3 截止提醒 4 开始提醒 5 一次提醒 提前X天X时 6 重复提醒 提前X天每隔X天',\n" +
                                        "  `REMIND_DAY` int(11) NOT NULL COMMENT '提前*天',\n" +
                                        "  `REMIND_HOUR` int(11) NOT NULL COMMENT '一次提醒： X时发送，重复提醒：每隔X天',\n" +
                                        "  `REMIND_TIME` datetime NOT NULL COMMENT '推送时间',\n" +
                                        "  PRIMARY KEY (`REMINDS_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_tag")) {
                                String sql = "CREATE TABLE `task_tag` (\n" +
                                        "  `TAG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签id',\n" +
                                        "  `TAG_NAME` varchar(100) DEFAULT NULL COMMENT '标签名',\n" +
                                        "  `TAG_REMARK` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`TAG_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_type")) {
                                String sql = "CREATE TABLE `task_type` (\n" +
                                        "  `TYPE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `TYPE_NAME` varchar(80) NOT NULL COMMENT '任务类别名称',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',\n" +
                                        "  `TYPE_NO` int(11) NOT NULL COMMENT '排序ID',\n" +
                                        "  PRIMARY KEY (`TYPE_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "task_user")) {
                                String sql = "CREATE TABLE `task_user` (\n" +
                                        "  `TASK_USER_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',\n" +
                                        "  `TASK_ID` int(11) NOT NULL COMMENT '任务ID',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL COMMENT '用户ID',\n" +
                                        "  `TASK_RELATION` char(10) NOT NULL COMMENT '1参与任务2关注3分享',\n" +
                                        "  PRIMARY KEY (`TASK_USER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "taskcenter")) {
                                String sql = "CREATE TABLE `taskcenter` (\n" +
                                        "  `TCID` int(11) NOT NULL COMMENT '自增唯一ID',\n" +
                                        "  `CATAGORY` varchar(15) NOT NULL COMMENT '任务类型',\n" +
                                        "  `SOURCEID` int(11) NOT NULL COMMENT '任务的来源ID',\n" +
                                        "  `USER_ID` varchar(20) NOT NULL COMMENT '所属用户',\n" +
                                        "  `TAKER` text NOT NULL COMMENT '参与用户',\n" +
                                        "  `BEGIN_TIME` int(10) NOT NULL COMMENT '开始时间',\n" +
                                        "  `END_TIME` int(10) NOT NULL COMMENT '结束时间',\n" +
                                        "  `CONTENT` text NOT NULL COMMENT '主要内容',\n" +
                                        "  `STATUS` varchar(8) NOT NULL COMMENT '任务状态',\n" +
                                        "  `DELAY_TIME` int(10) NOT NULL COMMENT '推迟到的时间',\n" +
                                        "  `IGNORE_FLAG` int(1) NOT NULL COMMENT '忽略标志(0-未忽略,1-已忽略,2-已删除)',\n" +
                                        "  `DELAY_ADD_TIME` int(10) NOT NULL COMMENT '推迟时间',\n" +
                                        "  PRIMARY KEY (`TCID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='任务中心信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "WELINK_DEPT")) {
                                String sql = "ALTER TABLE department ADD WELINK_DEPT VARCHAR ( 255 ) DEFAULT '' COMMENT 'welink的deptcode(即id)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "WEIXIN_DEPT_ID")) {
                                String sql = "ALTER TABLE department modify column WEIXIN_DEPT_ID varchar(225) DEFAULT '' COMMENT  '关联企业微信的部门id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "DINGDING_DEPT_ID")) {
                                String sql = "ALTER TABLE department modify column DINGDING_DEPT_ID varchar(225) DEFAULT '' COMMENT  '关联钉钉的部门id';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "terp_server", "DB_DATABASE_NAME")) {
                                String sql = "alter table terp_server add DB_DATABASE_NAME varchar(200) comment '数据源名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "terp_server", "DB_DATABASE_CHARSET")) {
                                String sql = "alter table terp_server add DB_DATABASE_CHARSET varchar(20) comment '字符格式';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "data_src", "d_nmarking")) {
                                String sql = " alter table data_src add d_nmarking text comment '标记数据源查询字段';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "data_src", "d_nmarkingdesc")) {
                                String sql = " alter table data_src add d_nmarkingdesc text comment '数据源查询字段描述';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "data_src", "d_module_name")) {
                                String sql = "alter table data_src add d_module_name varchar(100) comment '区分平台';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "PWEG_HR_SYN_TIME")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('PWEG_HR_SYN_TIME', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }


                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "34")) {
                                String sql = "DELETE  FROM `sys_function` WHERE `FUNC_ID`='34';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "34")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('34', '3025', '讨论区设置', NULL, NULL, NULL, NULL, NULL, 'system/bbs/index', '', NULL, NULL, NULL, '0');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "62")) {
                                String sql = "DELETE  FROM `sys_function` WHERE `FUNC_ID`='62';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "62")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('62', '3020', '讨论区', NULL, NULL, NULL, NULL, NULL, 'bbs/index', '', NULL, NULL, NULL, '0');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "bbs_board")) {
                                String sql = "CREATE TABLE `bbs_board` (\n" +
                                        "  `BOARD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '讨论区ID',\n" +
                                        "  `BOARD_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '讨论区名称',\n" +
                                        "  `ANONYMITY_YN` char(1) NOT NULL DEFAULT '' COMMENT '发帖设置 (0-禁止匿名,1-允许匿名,2-禁止发帖)',\n" +
                                        "  `WELCOME_TEXT` varchar(200) NOT NULL DEFAULT '' COMMENT '讨论区简介',\n" +
                                        "  `BOARD_HOSTER` text NOT NULL COMMENT '版主',\n" +
                                        "  `DEPT_ID` text NOT NULL COMMENT '开放部门',\n" +
                                        "  `PRIV_ID` text NOT NULL COMMENT '开放角色',\n" +
                                        "  `USER_ID` text NOT NULL COMMENT '开放人员',\n" +
                                        "  `BOARD_NO` int(11) NOT NULL DEFAULT '0' COMMENT '排序号',\n" +
                                        "  `CATEGORY` text NOT NULL COMMENT '帖子类别',\n" +
                                        "  `LOCK_DAYS_BEFORE` int(3) NOT NULL COMMENT '权限限制',\n" +
                                        "  `PARENT_ID` int(11) NOT NULL COMMENT '上级讨论区ID',\n" +
                                        "  `NEED_CHECK` int(1) NOT NULL COMMENT '审核标志(1-需要审核 ,0-不需要审核)',\n" +
                                        "  PRIMARY KEY (`BOARD_ID`) USING BTREE,\n" +
                                        "  KEY `BOARD_NO` (`BOARD_NO`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='讨论区定义表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "bbs_comment")) {
                                String sql = "CREATE TABLE `bbs_comment` (\n" +
                                        "  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                        "  `BOARD_ID` int(11) NOT NULL DEFAULT '0' COMMENT '讨论区ID',\n" +
                                        "  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '发帖人',\n" +
                                        "  `AUTHOR_NAME` varchar(50) NOT NULL DEFAULT '' COMMENT '匿名名称',\n" +
                                        "  `TYPE` varchar(50) NOT NULL COMMENT '帖子类别',\n" +
                                        "  `SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '主题',\n" +
                                        "  `CONTENT` mediumtext NOT NULL COMMENT '发帖内容',\n" +
                                        "  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称串',\n" +
                                        "  `SUBMIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '发布时间',\n" +
                                        "  `REPLY_CONT` int(11) NOT NULL DEFAULT '0' COMMENT '回复次数',\n" +
                                        "  `READ_CONT` int(11) NOT NULL DEFAULT '0' COMMENT '阅读次数',\n" +
                                        "  `PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '被回复的帖子COMMENT_ID',\n" +
                                        "  `OLD_SUBMIT_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '原始发帖时间',\n" +
                                        "  `TOP` varchar(20) NOT NULL DEFAULT '0' COMMENT '置顶标记',\n" +
                                        "  `JING` varchar(20) NOT NULL DEFAULT '0' COMMENT '加精标记',\n" +
                                        "  `READEDER` text NOT NULL COMMENT '阅读者',\n" +
                                        "  `SIGNED_YN` char(1) NOT NULL DEFAULT '0' COMMENT '发帖加上签名档',\n" +
                                        "  `LOCK_YN` int(11) NOT NULL DEFAULT '0' COMMENT '锁帖标记',\n" +
                                        "  `UPDATE_PERSON` varchar(254) NOT NULL COMMENT '修改人',\n" +
                                        "  `UPDATE_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',\n" +
                                        "  `SHOW_YN` int(1) NOT NULL DEFAULT '0' COMMENT '是否屏蔽',\n" +
                                        "  `IS_CHECK` int(1) NOT NULL DEFAULT '9' COMMENT '是否需要审核',\n" +
                                        "  `TO_ID_STR1` varchar(300) NOT NULL COMMENT '短信提醒人',\n" +
                                        "  `TO_ID_STR2` varchar(300) NOT NULL COMMENT '手机提醒人',\n" +
                                        "  `FROM_USER` varchar(200) NOT NULL COMMENT '发信人',\n" +
                                        "  `AUTHOR_NAME_TMEP` int(1) NOT NULL COMMENT '署名标记 (1-署名,2-昵称)',\n" +
                                        "  `NICK_NAME` varchar(200) NOT NULL COMMENT '昵称',\n" +
                                        "  PRIMARY KEY (`COMMENT_ID`) USING BTREE,\n" +
                                        "  KEY `Author_id` (`USER_ID`) USING BTREE,\n" +
                                        "  KEY `PID` (`BOARD_ID`) USING BTREE,\n" +
                                        "  KEY `SUBMIT_TIME` (`SUBMIT_TIME`) USING BTREE,\n" +
                                        "  KEY `PARENT` (`PARENT`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='讨论区发帖表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_assets_applys")) {
                                String sql = "CREATE TABLE `cp_assets_applys` (\n" +
                                        "  `apply_id` int(11) NOT NULL COMMENT '主键自增id',\n" +
                                        "  `bill` varchar(50) NOT NULL COMMENT '申请单据号',\n" +
                                        "  `assets_id` varchar(50) NOT NULL COMMENT '选择资产(资产id)',\n" +
                                        "  `assets_type` int(11) NOT NULL COMMENT '所属分类',\n" +
                                        "  `apply_type` char(10) NOT NULL COMMENT '申请类型(apply,repair,retiring)',\n" +
                                        "  `run_id` int(11) DEFAULT NULL COMMENT '关联流程',\n" +
                                        "  `status` char(10) DEFAULT NULL COMMENT '当前状态',\n" +
                                        "  `remark` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `apply_user` varchar(50) DEFAULT NULL COMMENT '申报人(退库操作员)',\n" +
                                        "  `managers` varchar(255) DEFAULT NULL COMMENT '管理员',\n" +
                                        "  `receive_at` datetime DEFAULT NULL COMMENT '领用日期(资产申请使用)',\n" +
                                        "  `return_at` datetime DEFAULT NULL COMMENT '归还日期(资产申请使用)',\n" +
                                        "  `real_return_at` datetime DEFAULT NULL COMMENT '实际归还日期(资产申请使用)',\n" +
                                        "  `approver` varchar(50) DEFAULT NULL COMMENT '审批人',\n" +
                                        "  `return_approver` varchar(50) DEFAULT NULL COMMENT '归还审批人',\n" +
                                        "  `operator` varchar(50) DEFAULT NULL COMMENT '维护操作员',\n" +
                                        "  `approvel_time` datetime DEFAULT NULL COMMENT '审批时间',\n" +
                                        "  `approval_opinion` varchar(255) DEFAULT NULL COMMENT '审批意见',\n" +
                                        "  `repair_fee` decimal(10,2) DEFAULT NULL COMMENT '维护花费',\n" +
                                        "  PRIMARY KEY (`apply_id`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产申请';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_assets_inventory")) {
                                String sql = "CREATE TABLE `cp_assets_inventory` (\n" +
                                        "  `inventory_id` varchar(50) NOT NULL COMMENT '主键自增id',\n" +
                                        "  `inventory_name` varchar(50) NOT NULL COMMENT '盘点名称',\n" +
                                        "  `apply_user` varchar(255) DEFAULT NULL COMMENT '当前领用用户',\n" +
                                        "  `start_at` datetime DEFAULT NULL COMMENT '资产登记时间开始',\n" +
                                        "  `end_at` datetime DEFAULT NULL COMMENT '资产登记时间结束',\n" +
                                        "  `assets_type` char(10) DEFAULT NULL COMMENT '所属分类',\n" +
                                        "  `managers` varchar(255) DEFAULT NULL COMMENT '管理员',\n" +
                                        "  `operator` varchar(50) DEFAULT NULL COMMENT '盘点操作人',\n" +
                                        "  `inventory_time` datetime DEFAULT NULL COMMENT '盘点生成时间',\n" +
                                        "  `run_id` int(11) DEFAULT NULL COMMENT '关联流程',\n" +
                                        "  PRIMARY KEY (`inventory_id`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资产盘点';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cp_assets_inventory_records")) {
                                String sql = "CREATE TABLE `cp_assets_inventory_records` (\n" +
                                        "  `records_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增id',\n" +
                                        "  `inventory_id` varchar(50) DEFAULT NULL COMMENT '盘点库id',\n" +
                                        "  `assets_id` varchar(50) DEFAULT NULL COMMENT '外联资产主键id',\n" +
                                        "  `assets_name` varchar(255) DEFAULT NULL COMMENT '资产名称',\n" +
                                        "  `assets_code` varchar(50) DEFAULT NULL COMMENT '资产编码',\n" +
                                        "  `product_at` datetime DEFAULT NULL COMMENT '生产时间',\n" +
                                        "  `price` decimal(10,2) DEFAULT NULL COMMENT '产品价格',\n" +
                                        "  `assets_type` char(10) DEFAULT NULL COMMENT '所属分类',\n" +
                                        "  `user_time` int(11) DEFAULT NULL COMMENT '使用时间',\n" +
                                        "  `apply_user` varchar(50) DEFAULT NULL COMMENT '当前领用用户',\n" +
                                        "  `managers` text COMMENT '管理员',\n" +
                                        "  `records_status` char(10) DEFAULT NULL COMMENT '当前状态',\n" +
                                        "  `is_inventory` char(10) DEFAULT NULL COMMENT '是否已经盘点(1-已盘点,2-未盘点)',\n" +
                                        "  `create_time` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  PRIMARY KEY (`records_id`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='盘点清单';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hst_meeting")) {
                                String sql = "CREATE TABLE `hst_meeting` (\n" +
                                        "  `MEETING_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `MEET_NAME` varchar(255) NOT NULL COMMENT '会议名称',\n" +
                                        "  `SUBJECT` varchar(255) NOT NULL COMMENT '会议主题',\n" +
                                        "  `MEET_DESC` text NOT NULL COMMENT '会议描述',\n" +
                                        "  `START_TIME` datetime NOT NULL COMMENT '会议开始时间',\n" +
                                        "  `END_TIME` datetime NOT NULL COMMENT '会议结束时间',\n" +
                                        "  `USER_IDS` text NOT NULL COMMENT '出席人员',\n" +
                                        "  `ROOM_ID` int(11) NOT NULL COMMENT '会议室主键',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '申请人',\n" +
                                        "  `PROPOSER_TIME` datetime NOT NULL COMMENT '申请时间',\n" +
                                        "  `MANAGER_ID` varchar(50) NOT NULL COMMENT '审批人',\n" +
                                        "  `MANAGER_TIME` datetime NOT NULL COMMENT '审批时间',\n" +
                                        "  `MEET_STATUS` char(10) NOT NULL DEFAULT '1' COMMENT '会议状态(1-待批 2-已批准 3-进行中 4-未批准 5-已结束)',\n" +
                                        "  `ATTACHMENT_ID` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '会议附件ID',\n" +
                                        "  `ATTACHMENT_NAME` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '会议附件NAME',\n" +
                                        "  `REASON` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '不批准原因',\n" +
                                        "  `ADVANCE_MIN` int(11) DEFAULT 0 COMMENT '提前进入会议时间（分钟)',\n" +
                                        "  PRIMARY KEY (`MEETING_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频会议会议详情表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hst_room")) {
                                String sql = "CREATE TABLE `hst_room` (\n" +
                                        "  `ROOM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `ROOM_NAME` varchar(255) NOT NULL COMMENT '会议室名称',\n" +
                                        "  `USER_IDS` text NOT NULL COMMENT '开放使用人员',\n" +
                                        "  `DEPT_IDS` text NOT NULL COMMENT '开放使用部门',\n" +
                                        "  `PRIV_IDS` text NOT NULL COMMENT '开放使用角色',\n" +
                                        "  `ROOM_NO` varchar(255) NOT NULL COMMENT '会议室号',\n" +
                                        "  `ROOM_PWD` varchar(255) NOT NULL COMMENT '会议室密码',\n" +
                                        "  `SERVER_ADDR` varchar(255) NOT NULL COMMENT '服务器地址',\n" +
                                        "  `ROOM_MANAGER` text NOT NULL COMMENT '会议室管理员',\n" +
                                        "  PRIMARY KEY (`ROOM_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='视频会议会议室表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "document_out_config")) {
                                String sql = "CREATE TABLE `document_out_config` (\n" +
                                        "  `CONFIG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `OUT_SYS_URL` varchar(255) NOT NULL COMMENT '外部系统URL',\n" +
                                        "  `OUT_SYS_USER` varchar(255) NOT NULL COMMENT '外部系统账号',\n" +
                                        "  `OUT_SYS_PWD` varchar(255) NOT NULL COMMENT '外部系统密码',\n" +
                                        "  PRIMARY KEY (`CONFIG_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外部公文集成参数配置表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run", "RELATION_RUN_IDS")) {
                                String sql = "ALTER TABLE flow_run ADD `RELATION_RUN_IDS` text COMMENT '主办人添加的关联流程工作';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "73", "SMS_REMIND")) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('73', '视频会议', NULL, NULL, NULL, NULL, NULL, NULL, '73', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "DOCUMENT_EXCHANGE_OUTUNIT", "")) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('DOCUMENT_EXCHANGE_OUTUNIT', '公文交换外部单位类型', NULL, NULL, NULL, NULL, NULL, NULL, '100', '', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "STARS")) {
                                String sql = "ALTER TABLE `hr_staff_info` ADD `STARS` varchar(254) DEFAULT '' NOT NULL COMMENT '打星';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_info", "HONOUR")) {
                                String sql = "ALTER TABLE `hr_staff_info` ADD `HONOUR` varchar(254) DEFAULT '' NOT NULL COMMENT '荣誉职称评定';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "document_exchange_outunit")) {
                                String sql = "CREATE TABLE `document_exchange_outunit` (\n" +
                                        "  `OU_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `OU_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '外部单位类别',\n" +
                                        "  `OUNIT_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '接收单位名称',\n" +
                                        "  `DEPT_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '接收单位部门',\n" +
                                        "  `DOC_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '来文类型(1-上级来文，2-下级来文，3-其他来文)',\n" +
                                        "  `DELIVERY_TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '主送/抄送(1-主送，2-抄送)',\n" +
                                        "  `OUNIT_DESC` text NOT NULL COMMENT '外部单位说明',\n" +
                                        "  PRIMARY KEY (`OU_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='外部单位管理表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "55")) {
                                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('55', '财务管理', '', '財務管理', '', '', '', '', 'revenue');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "408")) {
                                String sql = "INSERT INTO `sys_function` ( `FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC` ) VALUES('408' , '5515', '收支管理', '', '收支管理', NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0 );";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "409")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('409' ,'551501', '收支记录', '', '收支記錄', NULL, NULL, NULL, 'incomeexpense/record', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "411")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('411' ,'551510', '计划管理', '', '計劃管理', NULL, NULL, NULL, 'incomeexpense/plan', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "410")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('410' ,'551505', '收支统计', '', '收支統計', NULL, NULL, NULL, 'incomeexpense/stat', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "412")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('412' ,'551515', '计划类别', '', '類別管理', NULL, NULL, NULL, 'incomeexpense/plan/types', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "129")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('129', '606009', '办公用品采购清单', 'shopping list', '', '', '', '', 'officeDepository/goDepositoryShopList ', '', '', '', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "document_outsend_record")) {
                                String sql = "CREATE TABLE `document_outsend_record` (\n" +
                                        "  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',\n" +
                                        "  `RUN_ID` int(11) NOT NULL COMMENT '向集团发文时对应的runid',\n" +
                                        "  `DOC_UNID` varchar(255) NOT NULL DEFAULT '' COMMENT '已发公文返回的id串',\n" +
                                        "  `OUNIT_NAMES` text NOT NULL COMMENT '接收单位名称',\n" +
                                        "  `DEPT_NAMES` text NOT NULL COMMENT '接收单位部门',\n" +
                                        "  `RECEIVE_STATUS` varchar(50) NOT NULL DEFAULT '' COMMENT '签收状态',\n" +
                                        "  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '接收时间',\n" +
                                        "  `SEND_TYPE` varchar(50) NOT NULL DEFAULT '' COMMENT '发送类型',\n" +
                                        "  `SEND_TIME` datetime NOT NULL COMMENT '发文时间',\n" +
                                        "  `UNIT_UNID` varchar(255) NOT NULL DEFAULT '' COMMENT '单位对应的unid(用于收回操作)',\n" +
                                        "  `REMARK` text COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`RECORD_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='已发公文记录表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "74", "SMS_REMIND")) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('74', '固定资产', NULL, NULL, NULL, NULL, NULL, NULL, '74', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_attachment")) {
                                String sql = "CREATE TABLE `hr_staff_attachment`  (\n" +
                                        "  `USER_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联用户的userId',\n" +
                                        "  `STAFF_ENTRY_ID` int(11) NULL DEFAULT NULL COMMENT '关联hr_staff_entry的id',\n" +
                                        "  `ATTACHMENT_TYPE_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联系统代码表中的人事附件类型（parent_no=HR_ATTACHMENTS）',\n" +
                                        "  `ATTACHMENT_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附件id',\n" +
                                        "  `ATTACHMENT_NAME` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附件名称'\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '人事员工附件表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_entry")) {
                                String sql = "CREATE TABLE `hr_staff_entry`  (\n" +
                                        "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `USER_ID` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID关联人事档案表中USER_ID',\n" +
                                        "  `AUDIT_STATE` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '审核状态 1:申请已提交 2:部门助理审批通过;3:总监审批通过;4.人资审批通过;5.管理员审批通过;6.审核不通过',\n" +
                                        "  `LAST_UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',\n" +
                                        "  `STAFF_NAME` varchar(254) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',\n" +
                                        "  `STAFF_SEX` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别(0-男,1-女)',\n" +
                                        "  `STAFF_NATIONALITY` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '民族',\n" +
                                        "  `STAFF_PHONE` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',\n" +
                                        "  `STAFF_BIRTH` date NULL DEFAULT NULL COMMENT '出生日期',\n" +
                                        "  `HEIGHT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身高',\n" +
                                        "  `STAFF_NATIVE_PLACE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',\n" +
                                        "  `STAFF_POLITICAL_STATUS` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌',\n" +
                                        "  `STAFF_MARITAL_STATUS` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',\n" +
                                        "  `STAFF_CARD_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',\n" +
                                        "  `GRADUATION_SCHOOL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业学校',\n" +
                                        "  `STAFF_HIGHEST_SCHOOL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',\n" +
                                        "  `STAFF_MAJOR` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',\n" +
                                        "  `STAFF_SKILLS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '特长',\n" +
                                        "  `PRESENT_POSITION` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称',\n" +
                                        "  `WORK_JOB` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位',\n" +
                                        "  `HOME_ADDRESS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '家庭地址',\n" +
                                        "  `CATEGORY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品类',\n" +
                                        "  `BRAND` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '品牌',\n" +
                                        "  `DATES_EMPLOYED` date NULL DEFAULT NULL COMMENT '入职京东时间',\n" +
                                        "  `ADOPT_PIN_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '采销姓名',\n" +
                                        "  `VIRTURAL_ERP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '虚拟ERP',\n" +
                                        "  `STAFF_EMAIL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',\n" +
                                        "  `JD_EMAIL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '京东邮箱',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '部门',\n" +
                                        "  `STAFF_DOMICILE_PLACE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户口所在地',\n" +
                                        "  `STAFF_AGE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年龄',\n" +
                                        "  `BLOOD_TYPE` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '血型',\n" +
                                        "  `STAFF_NATIVE_PLACE2` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址',\n" +
                                        "  `PHOTO_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片文件',\n" +
                                        "  `IS_LUNAR` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期是否是农历(0-否,1-是)',\n" +
                                        "  `DATES_BRAND_EMPLOYED` date NULL DEFAULT NULL COMMENT '入职品牌时间',\n" +
                                        "  `OTHER_CONTACT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其它联系方式',\n" +
                                        "  `ATTACHMENT_SECRECY` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '保密附件',\n" +
                                        "  `ATTACHMENT_SECRECY_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '保密附件ID',\n" +
                                        "  `ATTACHMENT_SUPPLIER` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '供应商营业执照复印件附件',\n" +
                                        "  `ATTACHMENT_SUPPLIER_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '供应商营业执照复印件附件ID',\n" +
                                        "  `ATTACHMENT_JDSUPPLIER` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '京东供应商驻场合作协议上传附件',\n" +
                                        "  `ATTACHMENT_JDSUPPLIER_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '京东供应商驻场合作协议上传附件ID',\n" +
                                        "  `ATTACHMENT_ATTORNEY` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '授权委托书上传附件',\n" +
                                        "  `ATTACHMENT_ATTORNEY_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '授权委托书上传附件ID',\n" +
                                        "  `COMPUTER_LEVEL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计算机水平',\n" +
                                        "  `ADOPT_PIN_ID` int(11) NULL DEFAULT NULL COMMENT '采销员uid',\n" +
                                        "  PRIMARY KEY (`ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工入职表' ROW_FORMAT = Compact;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_entry_education")) {
                                String sql = "CREATE TABLE `hr_staff_entry_education`  (\n" +
                                        "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `EID` int(11) NULL DEFAULT NULL COMMENT '入职ID',\n" +
                                        "  `STAFF_SCHOOL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',\n" +
                                        "  `GRADUATION_SCHOOL` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业学校',\n" +
                                        "  `ENTRANCE_DATE` date NULL DEFAULT NULL COMMENT '入学时间',\n" +
                                        "  `GRADUATION_DATE` date NULL DEFAULT NULL COMMENT '毕业时间',\n" +
                                        "  `STAFF_MAJOR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',\n" +
                                        "  `STAFF_DEGREE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学位',\n" +
                                        "  `DID` int(11) NULL DEFAULT NULL COMMENT '档案id',\n" +
                                        "  PRIMARY KEY (`ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_staff_entry_experience")) {
                                String sql = "CREATE TABLE `hr_staff_entry_experience`  (\n" +
                                        "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `EID` int(11) NULL DEFAULT NULL COMMENT '入职ID',\n" +
                                        "  `JOB_BEGINNING` date NULL DEFAULT NULL COMMENT '开始工作时间',\n" +
                                        "  `JOB_END` date NULL DEFAULT NULL COMMENT '结束工作时间',\n" +
                                        "  `WORK_UNIT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作单位',\n" +
                                        "  `WORK_POST` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作岗位',\n" +
                                        "  `WORK_DUTY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '工作职责',\n" +
                                        "  `DID` int(11) NULL DEFAULT NULL COMMENT '档案ID',\n" +
                                        "  PRIMARY KEY (`ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_leave", "AUDIT_STATE")) {
                                String sql = "ALTER  TABLE  `hr_staff_leave`  ADD `AUDIT_STATE` char(50) DEFAULT NULL COMMENT '审核状态,1提交离职申请5.管理员审批完成,6.离职申请退回';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_leave", "BACK_REASON")) {
                                String sql = " ALTER  TABLE  `hr_staff_leave`  ADD `BACK_REASON` text COMMENT '离职退回原因';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_transfer", "AUDIT_STATE")) {
                                String sql = "  ALTER  TABLE  `hr_staff_transfer`  ADD `AUDIT_STATE` char(50) DEFAULT NULL COMMENT '审核状态,1提交调转申请5.管理员审批完成,6.调转申请退回';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "hr_staff_transfer", "BACK_REASON")) {
                                String sql = "    ALTER  TABLE  `hr_staff_transfer`  ADD `BACK_REASON` text COMMENT '调转退回原因';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "inv_warehouse")) {
                                String sql = "CREATE TABLE `inv_warehouse`  (\n" +
                                        "  `WAREHOUSE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库主键ID',\n" +
                                        "  `WAREHOUSE_NO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库编号',\n" +
                                        "  `WAREHOUSE_PERSON` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库负责人',\n" +
                                        "  `WAREHOUSE_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库名称',\n" +
                                        "  `WAREHOUSE_PHONE` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',\n" +
                                        "  `WAREHOUSE_ADRESS` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库地址',\n" +
                                        "  `WAREHOUSE_DEFAULT` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否为默认仓库（1：是；0：否）',\n" +
                                        "  `WAREHOUSE_REMARKS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `PROVINCE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '省',\n" +
                                        "  `CITY` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '市',\n" +
                                        "  `WAREHOUSE_LONG` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库地址经度',\n" +
                                        "  `WAREHOUSE_LAT` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '仓库地址纬度',\n" +
                                        "  PRIMARY KEY (`WAREHOUSE_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '仓库表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "po_commodity_enter")) {
                                String sql = "CREATE TABLE `po_commodity_enter`  (\n" +
                                        "  `ENTER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品入库ID',\n" +
                                        "  `PRODUCT_TYPE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品大类',\n" +
                                        "  `ENTER_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',\n" +
                                        "  `ENTER_SPECS` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品规格',\n" +
                                        "  `ENTER_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',\n" +
                                        "  `ENTER_INPRICE` double NULL DEFAULT NULL COMMENT '入库单价',\n" +
                                        "  `ENTER_NUM` int(100) NULL DEFAULT NULL COMMENT '入库数量',\n" +
                                        "  `ENTER_TOTAL` double NULL DEFAULT NULL COMMENT '合计',\n" +
                                        "  `ENTER_PAID` double NULL DEFAULT NULL COMMENT '已付金额',\n" +
                                        "  `ENTER_ARREARS` double NULL DEFAULT NULL COMMENT '欠款金额',\n" +
                                        "  `SUPPLIER_ID` int(11) NULL DEFAULT NULL COMMENT '供应商ID',\n" +
                                        "  `USER_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入库人',\n" +
                                        "  `ENTER_INDATE` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',\n" +
                                        "  `WAREHOUSE_ID` int(11) NULL DEFAULT NULL COMMENT '仓库id',\n" +
                                        "  `ENTER_WARNING` int(11) NULL DEFAULT NULL COMMENT '库存预警',\n" +
                                        "  `LOWPRICE` double NULL DEFAULT NULL COMMENT '最低售价',\n" +
                                        "  `METERING_UNIT` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计量单位',\n" +
                                        "  `DOCUMENT_NO` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据号',\n" +
                                        "  `REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`ENTER_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购库存表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "po_commodity_out")) {
                                String sql = "CREATE TABLE `po_commodity_out`  (\n" +
                                        "  `RETREAT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品退货ID',\n" +
                                        "  `WAREHOUSE_ID` int(11) NULL DEFAULT NULL COMMENT '仓库id',\n" +
                                        "  `SUPPLIER_ID` int(11) NULL DEFAULT NULL COMMENT '供应商ID',\n" +
                                        "  `ENTER_ID` int(11) NULL DEFAULT NULL COMMENT '入库ID',\n" +
                                        "  `PRODUCT_TYPE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品大类',\n" +
                                        "  `RETREAT_NAME` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品名称',\n" +
                                        "  `RETREAT_SPECS` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品规格',\n" +
                                        "  `RETREAT_CODE` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '商品编码',\n" +
                                        "  `RETREAT_OUTPRICE` double NULL DEFAULT NULL COMMENT '退货单价',\n" +
                                        "  `RETREAT_NUM` int(100) NULL DEFAULT NULL COMMENT '退货数量',\n" +
                                        "  `USER_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '退货人',\n" +
                                        "  `RETREAT_OUTDATE` datetime(0) NULL DEFAULT NULL COMMENT '退货时间',\n" +
                                        "  `METERING_UNIT` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计量单位',\n" +
                                        "  `DOCUMENT_NO` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据号',\n" +
                                        "  `REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `RETREAT_TOTAL` double NULL DEFAULT NULL COMMENT '合计',\n" +
                                        "  PRIMARY KEY (`RETREAT_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '采购退货表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "om_return")) {
                                String sql = "CREATE TABLE `om_return`  (\n" +
                                        "  `RETURN_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售退货ID',\n" +
                                        "  `ENTER_ID` int(11) NULL DEFAULT NULL COMMENT '商品入库ID',\n" +
                                        "  `RETURN_NUM` int(11) NULL DEFAULT NULL COMMENT '退货数量',\n" +
                                        "  `RETURN_PRICE` double NULL DEFAULT NULL COMMENT '退货单价',\n" +
                                        "  `RETURN_TOTAL` double NULL DEFAULT NULL COMMENT '合计',\n" +
                                        "  `CUSTOMER_ID` int(11) NULL DEFAULT NULL COMMENT '客户ID',\n" +
                                        "  `RETURN_DATE` datetime(0) NULL DEFAULT NULL COMMENT '退货日期',\n" +
                                        "  `USER_ID` int(11) NULL DEFAULT NULL COMMENT '退货人',\n" +
                                        "  `WAREHOUSE_ID` int(11) NULL DEFAULT NULL COMMENT '仓库ID',\n" +
                                        "  `RETURN_REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `DOCUMENT_NO` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据号',\n" +
                                        "  PRIMARY KEY (`RETURN_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '销售退货表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "om_shipment")) {
                                String sql = "CREATE TABLE `om_shipment`  (\n" +
                                        "  `SHIPMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '销售出货ID',\n" +
                                        "  `ENTER_ID` int(11) NULL DEFAULT NULL COMMENT '商品入库ID',\n" +
                                        "  `SHIPMENT_NUM` int(100) NULL DEFAULT NULL COMMENT '出货数量',\n" +
                                        "  `SHIPMENT_PRICE` double NULL DEFAULT NULL COMMENT '出货单价',\n" +
                                        "  `SHIPMENT_TOTAL` double NULL DEFAULT NULL COMMENT '总计',\n" +
                                        "  `SHIPMENT_PAID` double NULL DEFAULT NULL COMMENT '已付金额',\n" +
                                        "  `SHIPMENT_ARREARS` double NULL DEFAULT NULL COMMENT '欠款金额',\n" +
                                        "  `CUSTOMER_ID` int(11) NULL DEFAULT NULL COMMENT '客户ID',\n" +
                                        "  `SHIPMENT_DATE` datetime(0) NULL DEFAULT NULL COMMENT '出货日期',\n" +
                                        "  `USER_ID` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出货人',\n" +
                                        "  `WAREHOUSE_ID` int(11) NULL DEFAULT NULL COMMENT '仓库ID',\n" +
                                        "  `SHIPMENT_REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `DOCUMENT_NO` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单据号',\n" +
                                        "  PRIMARY KEY (`SHIPMENT_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '销售出货表' ROW_FORMAT = Compact;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "product_type")) {
                                String sql = "CREATE TABLE `product_type`  (\n" +
                                        "  `PRODUCT_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品类型',\n" +
                                        "  `PRODUCT_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品类型名称',\n" +
                                        "  `PRODUCT_TYPE_NO` int(10) NULL DEFAULT NULL COMMENT '商品类型编号',\n" +
                                        "  `REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`PRODUCT_TYPE_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商品类别表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cus_repayment")) {
                                String sql = "CREATE TABLE `cus_repayment`  (\n" +
                                        "  `REPAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '还款记录主键id',\n" +
                                        "  `REPAYMENT_NO` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '还款记录单号',\n" +
                                        "  `DOCUMENT_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '销售出货单据号',\n" +
                                        "  `REPAYMENT_TIME` datetime(0) NULL DEFAULT NULL COMMENT '还款时间',\n" +
                                        "  `REPAYMENT_AMOUNT` double NULL DEFAULT NULL COMMENT '还款金额',\n" +
                                        "  `USER_ID` int(11) NULL DEFAULT NULL COMMENT '经手人',\n" +
                                        "  `ENTER_ID` int(11) NULL DEFAULT NULL COMMENT '商品入库ID',\n" +
                                        "  `REPAYMENT_REMARK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `CUSTOMER_ID` int(11) NULL DEFAULT NULL COMMENT '客户ID',\n" +
                                        "  PRIMARY KEY (`REPAYMENT_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '客户还款记录表' ROW_FORMAT = Compact;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "76")) {
                                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('76', '进销存管理', '', '', '', '', '', '', 'record');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "480")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (480, '500118', '入职管理', NULL, NULL, NULL, NULL, NULL, '/personManagement/IntroductionManager', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2218")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2218, '7605', '销售单', NULL, NULL, NULL, NULL, NULL, '@', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2219")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2219, '7610', '采购单', NULL, NULL, NULL, NULL, NULL, '@', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2220")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2220, '7615', '收款单', NULL, NULL, NULL, NULL, NULL, '/invWarehouse/collReceipt', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2221")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2221, '7620', '付款单', NULL, NULL, NULL, NULL, NULL, '/invWarehouse/fuReceipt', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2222")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2222, '7625', '商品库存', NULL, NULL, NULL, NULL, NULL, '/invWarehouse/commodityInventory', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2223")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2223, '7630', '仓库管理', NULL, NULL, NULL, NULL, NULL, '/invWarehouse/index', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2224")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2224, '7635', '销售统计', NULL, NULL, NULL, NULL, NULL, '/invWarehouse/salesStatistics', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2225")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2225, '7640', '利润统计', NULL, NULL, NULL, NULL, NULL, '/', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2226")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2226, '760505', '销售出货', NULL, NULL, NULL, NULL, NULL, '/salesShipment/index', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2227")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2227, '760510', '销售退货', NULL, NULL, NULL, NULL, NULL, '/salesReturn/index', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2228")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2228, '761005', '采购进货', NULL, NULL, NULL, NULL, NULL, '/poCommodityEnter/purchaSestock', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2229")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2229, '761010', '采购出货', NULL, NULL, NULL, NULL, NULL, '/poCommodityEnter/purchaseOut', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "401")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('401' ,'5505', '合同管理', '', '合同管理', NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "402")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('402' ,'550501', '我的合同', '', '我的合同', NULL, NULL, NULL, '/contract/mine', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "403")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('403' ,'550505', '合同管理', '', '合同管理', NULL, NULL, NULL, '/contract/manager', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "404")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('404' ,'550510', '合同类型', '', '合同类型', NULL, NULL, NULL, '/contract/type', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "84")) {
                                String sql = "DELETE  FROM `sys_function` WHERE `FUNC_ID`='84';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "84")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`,`MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('84' ,'z067', '数据库管理', '', '数据库管理', NULL, NULL, NULL, '/sysDataBase/index', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistFunction(conn, driver, url, username, password, "255")) {
                                String sql = "DELETE  FROM `sys_function` WHERE `FUNC_ID`='255';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "255")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (255, 'z068', '数据源管理', NULL, NULL, NULL, NULL, NULL, 'TerpServerController/terpserverIndex', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2230")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2230, '764005', '商品利润', '', '', NULL, NULL, NULL, '/invWarehouse/commodityProfit', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2231")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2231, '764010', '客户利润', '', '', NULL, NULL, NULL, '/invWarehouse/customerProfit', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2232")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2232, '764015', '员工销售业绩', '', '', NULL, NULL, NULL, '/invWarehouse/employeeSales', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2233")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2233, '764020', '员工提成', '', '', NULL, NULL, NULL, '/invWarehouse/employeeCommission', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2234")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2234, '764025', '其他收支', '', '', NULL, NULL, NULL, '/invWarehouse/expenditure', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "exa_paper")) {
                                String sql = "CREATE TABLE `exa_paper` (\n" +
                                        "  `p_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试卷id',\n" +
                                        "  `p_name` varchar(255) NOT NULL COMMENT '试卷名称',\n" +
                                        "  `test_id` int(11) NOT NULL COMMENT '所属目录id',\n" +
                                        "  `train_center` varchar(255) NOT NULL COMMENT '培训中心',\n" +
                                        "  `test_format` char(2) NOT NULL COMMENT '组卷方式(0-固定 1-随机试卷）',\n" +
                                        "  `p_problem` text NOT NULL COMMENT '固定试卷：题id|分数 随机试卷：题目类型|目录id|难度|数量|分数,',\n" +
                                        "  `count_scores` varchar(10) DEFAULT NULL COMMENT '总分',\n" +
                                        "  `status` int(1) DEFAULT '0' COMMENT '发布状态0未发布1已发布',\n" +
                                        "  `create_id` int(11) DEFAULT NULL COMMENT '创建人uid',\n" +
                                        "  `create_time` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `course_id` int(11) DEFAULT NULL COMMENT '课程id',\n" +
                                        "  `course_stage` int(11) DEFAULT NULL COMMENT '课程阶段id',\n" +
                                        "  `test_time` varchar(10) DEFAULT NULL COMMENT '试卷限制完成时间（分钟）',\n" +
                                        "  `end_time` datetime DEFAULT NULL COMMENT '试卷截止日期',\n" +
                                        "  `passing_score` varchar(10) DEFAULT '80' COMMENT '及格分数',\n" +
                                        "  `resit_count` int(2) DEFAULT '1' COMMENT '补考次数',\n" +
                                        "  PRIMARY KEY (`p_id`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='试卷表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "exa_questions")) {
                                String sql = "CREATE TABLE `exa_questions` (\n" +
                                        "  `eq_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试题表主键id',\n" +
                                        "  `eq_subject` varchar(50) NOT NULL COMMENT '问题',\n" +
                                        "  `eq_type` char(6) NOT NULL COMMENT '难度类型（1-简单 2-中等 3-困难）',\n" +
                                        "  `eq_joinTime` datetime NOT NULL COMMENT '添加时间',\n" +
                                        "  `sort_id` int(11) NOT NULL COMMENT '试题目录id',\n" +
                                        "  `create_id` int(11) NOT NULL COMMENT '创建人uId',\n" +
                                        "  `eq_status` int(11) NOT NULL COMMENT '题的类型（1-单选2-多选-3判断4-填空-5问答）',\n" +
                                        "  `attachment_id` varchar(200) DEFAULT NULL COMMENT '附件id',\n" +
                                        "  `attachment_name` varchar(200) DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `option` text NOT NULL COMMENT '选项',\n" +
                                        "  `answer` varchar(255) NOT NULL COMMENT '参考答案',\n" +
                                        "  `analysis` varchar(255) DEFAULT NULL COMMENT '解析',\n" +
                                        "  PRIMARY KEY (`eq_id`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='试题表管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "exa_score_sheet")) {
                                String sql = "CREATE TABLE `exa_score_sheet` (\n" +
                                        "  `score_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '考生成绩表主键id',\n" +
                                        "  `uid` int(11) NOT NULL COMMENT '关联用户id',\n" +
                                        "  `p_id` int(11) NOT NULL COMMENT '考试试卷id',\n" +
                                        "  `res_single` text COMMENT '单选',\n" +
                                        "  `res_fill` text COMMENT '填空',\n" +
                                        "  `res_more` text COMMENT '多选',\n" +
                                        "  `res_judge` text COMMENT '判断',\n" +
                                        "  `res_obj` text COMMENT '主观题',\n" +
                                        "  `res_totle` int(10) DEFAULT NULL COMMENT '总分（包括所有客观题和主观题的分数',\n" +
                                        "  `join_time` datetime DEFAULT NULL COMMENT '考试时间',\n" +
                                        "  `count_down` varchar(10) DEFAULT NULL COMMENT '倒计时',\n" +
                                        "  `res_obj_score` int(10) DEFAULT NULL COMMENT '主观题总分数（用于判断是否已经评分，该题为手动评分',\n" +
                                        "  PRIMARY KEY (`score_id`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "exa_sort")) {
                                String sql = "CREATE TABLE `exa_sort` (\n" +
                                        "  `sort_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试题目录id',\n" +
                                        "  `sort_p_name` varchar(255) NOT NULL COMMENT '父级试题目录',\n" +
                                        "  `sort_name` varchar(255) NOT NULL COMMENT '项目目录名称',\n" +
                                        "  `sort_no` int(11) NOT NULL COMMENT '排序',\n" +
                                        "  PRIMARY KEY (`sort_id`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试题目录管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "exa_test")) {
                                String sql = "CREATE TABLE `exa_test` (\n" +
                                        "  `test_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '试卷目录id',\n" +
                                        "  `test_p_name` varchar(255) NOT NULL COMMENT '父级考试目录',\n" +
                                        "  `test_name` varchar(255) NOT NULL COMMENT '项目目录名称',\n" +
                                        "  `test_no` int(11) NOT NULL COMMENT '排序',\n" +
                                        "  PRIMARY KEY (`test_id`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试卷目录管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "examination")) {
                                String sql = "CREATE TABLE `examination` (\n" +
                                        "  `Id` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `RELEASE_HREF` varchar(255) DEFAULT NULL COMMENT '发布考试链接',\n" +
                                        "  `ACHIEVEMENT_HREF` varchar(255) DEFAULT NULL COMMENT '成绩查询链接',\n" +
                                        "  `EXAM_NAME` varchar(50) DEFAULT NULL COMMENT '考试主题',\n" +
                                        "  `COURSE_ID` int(11) DEFAULT NULL COMMENT '考试课程',\n" +
                                        "  `EXAM_USER_ID` text COMMENT '参考人员ids',\n" +
                                        "  `EXAM_USER_NAME` text COMMENT '参考人员名称',\n" +
                                        "  `EXAM_STATE` char(11) DEFAULT NULL COMMENT '状态 0未发布 1已发布',\n" +
                                        "  `EXAM_TIME` datetime DEFAULT NULL COMMENT '考试时间',\n" +
                                        "  `EXAM_ARRANGEMENT` text COMMENT '考试安排',\n" +
                                        "  `END_TIME` datetime DEFAULT NULL COMMENT '考试结束时间',\n" +
                                        "  `TYPE` char(11) DEFAULT NULL COMMENT '考试类型0线上1线下',\n" +
                                        "  `SPACE` varchar(255) DEFAULT NULL COMMENT '考试地点',\n" +
                                        "  PRIMARY KEY (`Id`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='考试管理链接地址表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "tr_course")) {
                                String sql = "CREATE TABLE `tr_course` (\n" +
                                        "  `COURSE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '课程 id',\n" +
                                        "  `COURSE_NAME` varchar(50) DEFAULT NULL COMMENT '课程名称',\n" +
                                        "  `COURSE_TYPE` char(20) DEFAULT NULL COMMENT '课程类型 0 线上 1线下',\n" +
                                        "  `COURSE_STAGE` char(50) DEFAULT NULL COMMENT '课程阶段',\n" +
                                        "  `COURSE_LECTURER` varchar(255) DEFAULT NULL COMMENT '讲师',\n" +
                                        "  `COURSE_INTRODUCE` text COMMENT '课程介绍',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '课程封皮 附件id',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '课程封皮 附件名称',\n" +
                                        "  `ATTACHMENT_ID2` text NOT NULL COMMENT '课程内容 附件id',\n" +
                                        "  `ATTACHMENT_NAME2` text COMMENT '课程内容 附件name',\n" +
                                        "  `VIDEO_ADDRESS` text COMMENT '视频点播地址',\n" +
                                        "  `COURSE_STATE` char(11) DEFAULT '0' COMMENT '状态 0 未发布 1 已发布',\n" +
                                        "  `LEARNING_TIME` int(11) DEFAULT NULL COMMENT '要求学习时长',\n" +
                                        "  `END_TIME` datetime DEFAULT NULL COMMENT '课程学习截止时间',\n" +
                                        "  PRIMARY KEY (`COURSE_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "tr_course_manage")) {
                                String sql = "CREATE TABLE `tr_course_manage` (\n" +
                                        "  `COURSE_MANAGE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',\n" +
                                        "  `USER_ID` varchar(50) DEFAULT NULL COMMENT '人员名称',\n" +
                                        "  `COURSE_ID` int(11) DEFAULT NULL COMMENT '课程名称',\n" +
                                        "  `SIGNUP_TIME` datetime DEFAULT NULL COMMENT '报名时间',\n" +
                                        "  `SIGNIN_TIME` datetime DEFAULT NULL COMMENT '签到时间',\n" +
                                        "  `FRACTION` varchar(50) DEFAULT NULL COMMENT '分数',\n" +
                                        "  `CONTENT` text COMMENT '评估内容',\n" +
                                        "  `SCHEDULE_ID` int(11) DEFAULT NULL COMMENT '排课id',\n" +
                                        "  PRIMARY KEY (`COURSE_MANAGE_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上课管理表(线下报名)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "tr_course_schedule")) {
                                String sql = "CREATE TABLE `tr_course_schedule` (\n" +
                                        "  `SCHEDULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `SCHEDULE_NAME` varchar(255) DEFAULT NULL COMMENT '课程名称',\n" +
                                        "  `ENROLL_TIME` datetime DEFAULT NULL COMMENT '报名开始时间',\n" +
                                        "  `SIGIN_TIME` datetime DEFAULT NULL COMMENT '签到开始时间',\n" +
                                        "  `COURSE_TIME` datetime DEFAULT NULL COMMENT '上课开始时间',\n" +
                                        "  `ASSESS_TIME` datetime DEFAULT NULL COMMENT '评估开始时间',\n" +
                                        "  `ASSESS_DEGREE` varchar(255) DEFAULT NULL COMMENT '评估满意度',\n" +
                                        "  `COURSE_ADDRESS` varchar(255) DEFAULT NULL COMMENT '上课地点',\n" +
                                        "  `CLASS_HOUR` varchar(50) DEFAULT NULL COMMENT '课时',\n" +
                                        "  `IF_EXAMINATION` char(20) DEFAULT NULL COMMENT '是否安排考试 0 是 1 否',\n" +
                                        "  `DEPT_IDS` text COMMENT '按部门选择上课',\n" +
                                        "  `USER_PRIVS` text COMMENT '按角色选择上课',\n" +
                                        "  `USER_IDS` text COMMENT '按人员选择上课',\n" +
                                        "  `COURSE_ID` int(20) DEFAULT NULL COMMENT '父课程id',\n" +
                                        "  `COURSE_STATE` char(20) DEFAULT '0' COMMENT '课程状态 0 未发布 1 已发布',\n" +
                                        "  `ENROLL_TIME1` datetime DEFAULT NULL COMMENT '报名结束时间',\n" +
                                        "  `SIGIN_TIME1` datetime DEFAULT NULL COMMENT '签到结束时间',\n" +
                                        "  `COURSE_TIME1` datetime DEFAULT NULL COMMENT '上课结束时间',\n" +
                                        "  `ASSESS_TIME1` datetime DEFAULT NULL COMMENT '评估结束时间',\n" +
                                        "  `ZCUSER_IDS` text COMMENT '去重后userids',\n" +
                                        "  PRIMARY KEY (`SCHEDULE_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='课程排课表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "tr_course_stage")) {
                                String sql = "CREATE TABLE `tr_course_stage` (\n" +
                                        "  `COURSE_STAGE` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `STAGE_NAME` varchar(255) DEFAULT NULL COMMENT '阶段名称',\n" +
                                        "  `STAGE_PARENT` int(11) DEFAULT '0' COMMENT '阶段父id',\n" +
                                        "  `STAGE_SORT` int(11) DEFAULT '1' COMMENT '阶段排序号',\n" +
                                        "  PRIMARY KEY (`COURSE_STAGE`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='课程阶段表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "tr_study_record")) {
                                String sql = "CREATE TABLE `tr_study_record` (\n" +
                                        "  `STUDY_RECORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `COURSE_ID` int(11) DEFAULT NULL COMMENT '课程名称',\n" +
                                        "  `USER_ID` varchar(50) DEFAULT NULL COMMENT '人员名称',\n" +
                                        "  `STUDY_TIME` int(11) DEFAULT NULL COMMENT '学习时长',\n" +
                                        "  `STUDY_TIME_END` datetime DEFAULT NULL COMMENT '最后一次学习时间',\n" +
                                        "  PRIMARY KEY (`STUDY_RECORD_ID`) USING BTREE,\n" +
                                        "  KEY `I_COURSE_ID` (`COURSE_ID`,`USER_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='课程发布(线上)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract")) {
                                String sql = "CREATE TABLE `contract` (\n" +
                                        "  `CONTRACT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合同id',\n" +
                                        "  `CONTRACT_NO` char(50) NOT NULL DEFAULT '' COMMENT '合同编号',\n" +
                                        "  `TITLE` varchar(255) NOT NULL DEFAULT '' COMMENT '合同标题',\n" +
                                        "  `TYPE_ID` int(11) NOT NULL DEFAULT '1' COMMENT '合同类型',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL DEFAULT '0' COMMENT '跟进人id',\n" +
                                        "  `TARGET_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '合同对象',\n" +
                                        "  `MONEY` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合同金额',\n" +
                                        "  `CONTENT` text COMMENT '合同正文',\n" +
                                        "  `A_USER` varchar(200) NOT NULL DEFAULT '' COMMENT '合同甲方',\n" +
                                        "  `B_USER` varchar(200) NOT NULL DEFAULT '' COMMENT '合同乙方',\n" +
                                        "  `A_ADDRESS` varchar(255) NOT NULL DEFAULT '' COMMENT '甲方地址',\n" +
                                        "  `B_ADDRESS` varchar(255) NOT NULL DEFAULT '' COMMENT '乙方地址',\n" +
                                        "  `A_LINKMAN` varchar(50) NOT NULL DEFAULT '' COMMENT '甲方联系人',\n" +
                                        "  `B_LINKMAN` varchar(50) NOT NULL DEFAULT '' COMMENT '乙方联系人',\n" +
                                        "  `A_PHONE` varchar(50) NOT NULL DEFAULT '' COMMENT '甲方电话',\n" +
                                        "  `B_PHONE` varchar(50) NOT NULL DEFAULT '' COMMENT '乙方电话',\n" +
                                        "  `A_SIGN` varchar(50) NOT NULL DEFAULT '' COMMENT '甲方签字',\n" +
                                        "  `B_SIGN` varchar(200) NOT NULL DEFAULT '' COMMENT '乙方签字',\n" +
                                        "  `A_SIGN_TIME` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '甲方签字时间',\n" +
                                        "  `B_SIGN_TIME` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '乙方签字时间',\n" +
                                        "  `REMARKS` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                                        "  `PARENT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '主合同',\n" +
                                        "  `MONEY_CP` varchar(200) NOT NULL DEFAULT '' COMMENT '大写金额',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件Id',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `SUB_CONTRACT` varchar(200) DEFAULT NULL COMMENT '子合同',\n" +
                                        "  PRIMARY KEY (`CONTRACT_ID`) USING BTREE,\n" +
                                        "  UNIQUE KEY `contract` (`CONTRACT_NO`) USING BTREE COMMENT 'CONTRACT_NO合同编号唯一索引',\n" +
                                        "  KEY `TYPE_ID` (`TYPE_ID`) USING BTREE COMMENT 'TYPE_ID索引'\n" +
                                        ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='合同管理主表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_flow")) {
                                String sql = "CREATE TABLE `contract_flow` (\n" +
                                        "  `CON_FLOW_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合同款项id',\n" +
                                        "  `CON_TRACT_ID` int(11) NOT NULL COMMENT '合同id',\n" +
                                        "  `RUN_ID` text NOT NULL COMMENT '流程id',\n" +
                                        "  `RUN_NAME` varchar(255) NOT NULL COMMENT '流程标题',\n" +
                                        "  PRIMARY KEY (`CON_FLOW_ID`) USING BTREE,\n" +
                                        "  KEY `CONTRACT_ID` (`CON_TRACT_ID`) USING BTREE COMMENT 'CONTRACT_ID索引'\n" +
                                        ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='合同管理_流';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_project")) {
                                String sql = "CREATE TABLE `contract_project` (\n" +
                                        "  `CON_PROJECT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '合同款项id',\n" +
                                        "  `CONTRACT_ID` int(11) NOT NULL COMMENT '合同id',\n" +
                                        "  `PROJECT_TYPE` char(10) NOT NULL COMMENT '款项性质（0表示收入， 1表示支出）',\n" +
                                        "  `MONEY` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '合同金额',\n" +
                                        "  `PAY_WAY` char(10) NOT NULL DEFAULT '0' COMMENT '打款方式',\n" +
                                        "  `PAY_ACCOUNT` varchar(100) NOT NULL DEFAULT '' COMMENT '打款账号',\n" +
                                        "  `PAY_TIME` datetime NOT NULL COMMENT '打款时间',\n" +
                                        "  `RUN_ID` text NOT NULL COMMENT '流程id',\n" +
                                        "  `REMARKS` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                        "  `INVOICE_TIME` datetime NOT NULL COMMENT '开票时间',\n" +
                                        "  `PAY_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '款项类别',\n" +
                                        "  PRIMARY KEY (`CON_PROJECT_ID`,`PAY_ACCOUNT`) USING BTREE,\n" +
                                        "  KEY `CONTRACT_ID` (`CONTRACT_ID`) USING BTREE COMMENT 'CONTRACT_ID索引'\n" +
                                        ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='合同管理 项目';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_remind")) {
                                String sql = "CREATE TABLE `contract_remind` (\n" +
                                        "  `REMIND_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                                        "  `CONTRACT_ID` int(11) NOT NULL COMMENT '合同id',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL COMMENT '提醒用户id',\n" +
                                        "  `REMIND_DATE` date NOT NULL COMMENT '提醒日期',\n" +
                                        "  `CONTENT` text NOT NULL COMMENT '提醒内容',\n" +
                                        "  `REMARKS` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                        "  `REMIND_FLAG` int(11) DEFAULT NULL COMMENT '是否已经提醒  0为提醒  1已提醒',\n" +
                                        "  PRIMARY KEY (`REMIND_ID`) USING BTREE,\n" +
                                        "  KEY `CONTRACT_ID` (`CONTRACT_ID`) USING BTREE COMMENT 'CONTRACT_ID索引'\n" +
                                        ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='合同管理 提醒';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_transport")) {
                                String sql = "CREATE TABLE `contract_transport` (\n" +
                                        "  `TRANSPORT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                                        "  `CONTRACT_ID` int(11) NOT NULL COMMENT '合同id',\n" +
                                        "  `PRODUCT_ID` int(11) NOT NULL COMMENT '产品id',\n" +
                                        "  `SHIPPING_DATE` date NOT NULL COMMENT '发货时间',\n" +
                                        "  `NUMBER` varchar(100) NOT NULL DEFAULT '0' COMMENT '发货数量',\n" +
                                        "  `RUN_ID` text NOT NULL COMMENT '流程id',\n" +
                                        "  `REMARKS` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`TRANSPORT_ID`) USING BTREE\n" +
                                        ") ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='合同管理 运输';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_type")) {
                                String sql = "CREATE TABLE `contract_type` (\n" +
                                        "  `TYPE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                        "  `TYPE_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '类型名称',\n" +
                                        "  `TYPE_NO` int(11) NOT NULL DEFAULT '1' COMMENT '分类序号',\n" +
                                        "  PRIMARY KEY (`TYPE_ID`) USING BTREE\n" +
                                        ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='合同管理 类型';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2307")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2307, '7525', '资质证书管理', NULL, NULL, NULL, NULL, NULL, '/supplier/certification', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "income_expense_plan_type")) {
                                String sql = "CREATE TABLE `income_expense_plan_type` (\n" +
                                        "  `PLAN_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `PLAN_TYPE_NAME` varchar(255) NOT NULL COMMENT '计划类别名称',\n" +
                                        "  `PLAN_TYPE_DESC` text COMMENT '计划类别描述',\n" +
                                        "  PRIMARY KEY (`PLAN_TYPE_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计划类别';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "income_expense_plan")) {
                                String sql = "CREATE TABLE `income_expense_plan` (\n" +
                                        "  `PLAN_ID` int(11)  NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `PLAN_CODE` varchar(255) NOT NULL DEFAULT '' COMMENT '计划编码',\n" +
                                        "  `PLAN_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '计划名称',\n" +
                                        "  `PLAN_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '计划类别',\n" +
                                        "  `PLAN_CYCLE` int(11) DEFAULT '0' COMMENT '计划执行周期',\n" +
                                        "  `PLAN_CYCLE_UNIT` char(10) NOT NULL DEFAULT '1' COMMENT '周期单位(1-天,2-周,3-月,4-年)',\n" +
                                        "  `EXPENSE_BUDGET` decimal(12,2) DEFAULT '0.00' COMMENT '支出预算',\n" +
                                        "  `INCOME_BUDGET` decimal(12,2) DEFAULT '0.00' COMMENT '收入预估',\n" +
                                        "  `REAL_EXPENSE` decimal(13,2) DEFAULT '0.00' COMMENT '总支出',\n" +
                                        "  `REAL_INCOME` decimal(13,2) DEFAULT '0.00' COMMENT '总收入',\n" +
                                        "  `EXPENSE_BUDGET_ALERT` decimal(13,2) NOT NULL DEFAULT '1' COMMENT '支出预算超额提醒',\n" +
                                        "  `PLAN_STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '计划状态（0-未启动，1-进行中，2结束）',\n" +
                                        "  `IS_START` char(10) NOT NULL DEFAULT '0' COMMENT '是否支出超预算（0-否，1-是）',\n" +
                                        "  `BEGIN_TIME` datetime DEFAULT NULL COMMENT '启动时间',\n" +
                                        "  `END_TIME` datetime DEFAULT NULL COMMENT '结束时间',\n" +
                                        "  `ALL_USER` char(10) NOT NULL DEFAULT '1' COMMENT '选择所有用户',\n" +
                                        "  `DEPT_IDS` text COMMENT '部门ID串',\n" +
                                        "  `ROLE_IDS` text COMMENT '角色ID串',\n" +
                                        "  `USER_IDS` text COMMENT '用户ID串',\n" +
                                        "  `CREATOR` varchar(50) NOT NULL COMMENT '创建人',\n" +
                                        "  `ATTACHMENT_ID` text  COMMENT '附件ID',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称',\n" +
                                        "  `PLAN_DESC` text COMMENT '描述',\n" +
                                        "  `PLAN_CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  PRIMARY KEY (`PLAN_ID`),\n" +
                                        "  UNIQUE KEY `INCOME_EXPENSE_PLAN_PLAN_CODE_UNIQUE` (`PLAN_CODE`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='计划管理';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "income_expense_records")) {
                                String sql = "CREATE TABLE `income_expense_records` (\n" +
                                        "  `RECORD_ID` int(11)  NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `PLAN_ID` int(11) NOT NULL COMMENT '收支计划ID',\n" +
                                        "  `EXPENSE` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '支出金额',\n" +
                                        "  `INCOME` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '收入金额',\n" +
                                        "  `RECORD_YEAR` varchar(10) NOT NULL DEFAULT '' COMMENT '年',\n" +
                                        "  `RECORD_QUARTER` varchar(10) NOT NULL DEFAULT '' COMMENT '季节',\n" +
                                        "  `RECORD_MONTH` varchar(10) NOT NULL DEFAULT '' COMMENT '月',\n" +
                                        "  `RECORD_DAY` varchar(10) NOT NULL DEFAULT '' COMMENT '日',\n" +
                                        "  `CREATOR` varchar(50) NOT NULL DEFAULT '' COMMENT '创建人',\n" +
                                        "  `RECORD_TIME` datetime DEFAULT NULL COMMENT '收支产生时间',\n" +
                                        "  `RECORD_DESC` text COMMENT '备注',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称串',\n" +
                                        "  `CREATED_RE_TIME` datetime NULL DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  PRIMARY KEY (`RECORD_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支记录';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "income_expense_stat")) {
                                String sql = "CREATE TABLE `income_expense_stat` (\n" +
                                        "  `PLAN_ID` int(11) NOT NULL COMMENT '计划ID',\n" +
                                        "  `RECORD_ID` int(11) NOT NULL COMMENT '收支记录ID',\n" +
                                        "  `STAT_YEAR` varchar(10) NOT NULL DEFAULT '' COMMENT '年',\n" +
                                        "  `STAT_QUARTER` varchar(10) NOT NULL DEFAULT '' COMMENT '季节',\n" +
                                        "  `STAT_MONTH` varchar(10) NOT NULL DEFAULT '' COMMENT '月',\n" +
                                        "  `STAT_EXPENSE` decimal(13,2) DEFAULT '0.00' COMMENT '支出金额',\n" +
                                        "  `STAT_INCOME` decimal(13,2) DEFAULT '0.00' COMMENT '收入金额',\n" +
                                        "  `STAT_TIMES` int(11) NOT NULL DEFAULT '0' COMMENT '记录个数',\n" +
                                        "  `STAT_RECORD_TIME` datetime NOT NULL COMMENT '创建时间'\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收支统计';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "00", "portals_show")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( '00', '今日看板', NULL, NULL, NULL, NULL, NULL, NULL, '00', 'portals_show', '1', '/img/main_img/app/38.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "0b", "portals_show")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( '0b', '今日看板B', NULL, NULL, NULL, NULL, NULL, NULL, '0b', 'portals_show', '1', '/img/main_img/app/38.png', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7231")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('7231', '2530', '好视通视频会议', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7232")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('7232', '253005', '会议申请', NULL, NULL, NULL, NULL, NULL, '/HSTmeeting/apply ', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7233")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('7233', '253010', '会议审批', NULL, NULL, NULL, NULL, NULL, '/HSTmeeting/approval ', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7234")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('7234', '253015', '我的会议', NULL, NULL, NULL, NULL, NULL, '/hstMeetingRoom/myHstMeeting', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "7235")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('7235', '253020', '会议室设置', NULL, NULL, NULL, NULL, NULL, '/HSTmeeting/meetingSetting', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "08")) {
                                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('08', '任务管理', 'Task Management Team', '任務管理', '', '', '', '', 'system');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "540")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (540, '0805', '我的任务', NULL, NULL, NULL, NULL, NULL, '/task/taskManage', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "541")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (541, '0810', '下属任务', NULL, NULL, NULL, NULL, NULL, '/task/taskSubordinate', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "542")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (542, '0815', '任务分析', NULL, NULL, NULL, NULL, NULL, '/task/taskAnalysis', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "543")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (543, '0802', '任务报表', NULL, NULL, NULL, NULL, NULL, '/task/taskReport', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "ATTEND_TYPE")) {
                                String sql = "ALTER  TABLE `attend_set` add `ATTEND_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '签到类型（0-固定签到，1-弹性工时）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "WORK_START")) {
                                String sql = "ALTER  TABLE `attend_set` add `WORK_START` varchar(20) DEFAULT NULL COMMENT '弹性工作开始时间24小时制';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "WORK_END")) {
                                String sql = "ALTER  TABLE `attend_set` add `WORK_END` varchar(20) DEFAULT NULL COMMENT '弹性工作结束时间24小时制';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "WORK_HOURS")) {
                                String sql = "ALTER  TABLE `attend_set` add `WORK_HOURS` int(10) DEFAULT '8' COMMENT '弹性工时-最小工作小时';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IP_ON")) {
                                String sql = "ALTER  TABLE `attend_set` add `IP_ON` char(10) DEFAULT '0' COMMENT '是否开启IP限制签到 0-关闭，1-开启';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_set", "IP_PARAGRAPH")) {
                                String sql = "ALTER  TABLE `attend_set` add `IP_PARAGRAPH` varchar(50) DEFAULT NULL COMMENT 'IP段（`-`分隔）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_schedule", "OPEN_TIME")) {
                                String sql = "ALTER  TABLE `attend_schedule` add `OPEN_TIME` datetime DEFAULT NULL COMMENT '开启时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "user_duty", "ADD_TYPE")) {
                                String sql = "ALTER  TABLE `user_duty` add `ADD_TYPE` char(10) DEFAULT '1' COMMENT '添加类型（1-排班，2-调休，3-节假日,“-”分割）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_holiday", "USER_ID")) {
                                String sql = "ALTER  TABLE `attend_holiday` add `USER_ID` text COMMENT '人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_holiday", "DEPT_ID")) {
                                String sql = "ALTER  TABLE `attend_holiday` add `DEPT_ID` text COMMENT '部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_holiday", "PRIV_ID")) {
                                String sql = "ALTER  TABLE `attend_holiday` add `PRIV_ID` text COMMENT '角色';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_extrawork", "USER_ID")) {
                                String sql = "ALTER  TABLE `attend_extrawork` add `USER_ID` text COMMENT '人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_extrawork", "DEPT_ID")) {
                                String sql = "ALTER  TABLE `attend_extrawork` add `DEPT_ID` text COMMENT '部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_extrawork", "PRIV_ID")) {
                                String sql = "ALTER  TABLE `attend_extrawork` add `PRIV_ID` text COMMENT '角色';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "88")) {
                                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('88', '党建平台', '', '', '', '', '', '', 'record');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2273")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2273, '8805', '党员活动', NULL, NULL, NULL, NULL, NULL, '/street/partyMember', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2274")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2274, '8810', '政策文件', NULL, NULL, NULL, NULL, NULL, '/street/zhengcewenjian', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2275")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2275, '8815', '组织架构', NULL, NULL, NULL, NULL, NULL, '/street/orgDepartment', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2276")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2276, '8820', '主题教育', NULL, NULL, NULL, NULL, NULL, '/street/subjectTheme', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2277")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2277, '8825', '宣传阵地', NULL, NULL, NULL, NULL, NULL, '/position/managerIndex', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2278")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2278, '8830', '积分管理', NULL, NULL, NULL, NULL, NULL, '', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2279")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2279, '883515', '党建信息发布', NULL, NULL, NULL, NULL, NULL, '/street/InformationDelivery', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2280")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2280, '883010', '党支部初审', NULL, NULL, NULL, NULL, NULL, '/street/partyBranch', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2281")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2281, '883015', '小组评审', NULL, NULL, NULL, NULL, NULL, '/street/group', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2282")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2282, '883020', '年度总分', NULL, NULL, NULL, NULL, NULL, '/street/yearScore', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2283")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2283, '8835', '党建管理', NULL, NULL, NULL, NULL, NULL, '', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2284")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2284, '883505', '党组织机构管理', NULL, NULL, NULL, NULL, NULL, '/street/partyList', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2285")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2285, '883510', '党员信息管理', NULL, NULL, NULL, NULL, NULL, '/street/partyManagement', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2288")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2288, '8840', '个人入党', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2289")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2289, '884005', '入党申请', NULL, NULL, NULL, NULL, NULL, '/partyMember/applicationForm', '', '0', NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2290")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2290, '884010', '思想汇报', NULL, NULL, NULL, NULL, NULL, '/partyMember/partyCheck', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2292")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2292, '884015', '党员个人信息', NULL, NULL, NULL, NULL, NULL, '/partyMember/memberInfo', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2293")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2293, '8845', '入党审核', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2295")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2295, '884505', '积极份子申请审核', NULL, NULL, NULL, NULL, NULL, '/partyMember/auditor', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2296")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2296, '884515', '发展对象审核', NULL, NULL, NULL, NULL, NULL, '/partyMember/progress', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2298")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2298, '884520', '预备党员审核', NULL, NULL, NULL, NULL, NULL, '/partyMember/prepare', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2304")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2304, '884525', '党建基础设置', NULL, NULL, NULL, NULL, NULL, '/partyMember/partyBaseSet', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2299")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2299, '8855', '入党信息查看', NULL, NULL, NULL, NULL, NULL, '@', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2300")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2300, '885510', '查看积极份子', NULL, NULL, NULL, NULL, NULL, '/partyMember/allActivist', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2301")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2301, '885515', '查看发展对象', NULL, NULL, NULL, NULL, NULL, '/partyMember/developObj', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2302")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2302, '885520', '查看预备党员', NULL, NULL, NULL, NULL, NULL, '/partyMember/prePartyMember', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2303")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2303, '885525', '查看党员信息', NULL, NULL, NULL, NULL, NULL, '/partyMember/allMemberInfo', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_room", "MEET_ROOM_PERSON")) {
                                String sql = "  ALTER TABLE `meeting_room` MODIFY COLUMN  `MEET_ROOM_PERSON` text COMMENT '会议室申请人员名字';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonus", "UID")) {
                                String sql = "ALTER  TABLE `bonus` add `UID` int(1) DEFAULT NULL COMMENT '用户uid';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonus", "BONUS_TYPE")) {
                                String sql = "ALTER  TABLE `bonus` add `BONUS_TYPE` char(10) DEFAULT NULL COMMENT '判断工资还是奖金（1：工资，2：奖金）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "BONUS_ID")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `BONUS_ID` varchar(255) DEFAULT NULL COMMENT '存储和bonus表关系，多对一';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "YEARS")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `YEARS` varchar(255) DEFAULT NULL COMMENT '年';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "MONTH")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `MONTH` varchar(255) DEFAULT NULL COMMENT '月';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "USER_ID")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `USER_ID` varchar(255) DEFAULT NULL COMMENT '用户userId';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "USER_NAME")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `USER_NAME` varchar(255) DEFAULT NULL COMMENT '姓名';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting_room", "MEET_ROOM_DEPT")) {
                                String sql = "  ALTER TABLE `meeting_room` MODIFY COLUMN  `MEET_ROOM_DEPT` text COMMENT '会议室申请部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }


                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "info_center", "INFO_FUNC_ID")) {
                                String sql = "  ALTER TABLE `info_center` MODIFY COLUMN  `INFO_FUNC_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '对应的FUNC_ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "info_center", "INFO_NO")) {
                                String sql = " ALTER TABLE `info_center` MODIFY COLUMN  `INFO_NO` varchar(50) NOT NULL DEFAULT '0' COMMENT '默认应用序号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                                sql = "update info_center SET INFO_NO=LPAD(INFO_NO,2,0);";
                                st.executeUpdate(sql);
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "info_center", "ICON_PATH")) {
                                String sql = " ALTER TABLE `info_center` add `ICON_PATH` varchar(200) NOT NULL DEFAULT '' COMMENT '图标';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                                if (Verification.CheckIsExistfield(conn, driver, url, username, password, "info_center", "ICON_PATH")) {
                                    String sql1 = "UPDATE `info_center` SET `INFO_NO` = '01', `INFO_NAME1` = '公告', `INFO_NAME3` = '公告', `ICON_PATH` = '0116.png' WHERE `INFO_ID` = 1;";
                                    String sql2 = "UPDATE `info_center` SET `INFO_NO` = '02', `INFO_NAME1` = '新闻', `ICON_PATH` = '0117.png' WHERE `INFO_ID` = 2;";
                                    String sql3 = "UPDATE `info_center` SET `INFO_NO` = '03', `INFO_NAME1` = '邮件箱', `ICON_PATH` = '0101.png' WHERE `INFO_ID` = 3;";
                                    String sql4 = "UPDATE `info_center` SET `INFO_NO` = '04', `INFO_NAME1` = '待办流程', `ICON_PATH` = 'dblc.png' WHERE `INFO_ID` = 4;";
                                    String sql5 = "UPDATE `info_center` SET `INFO_NO` = '06', `INFO_NAME1` = '日程安排', `ICON_PATH` = 'dbgw.png' WHERE `INFO_ID` = 5;";
                                    String sql6 = "UPDATE `info_center` SET `INFO_NO` = '07', `INFO_NAME1` = '常用功能', `ICON_PATH` = '0124.png' WHERE `INFO_ID` = 6;";
                                    String sql7 = "UPDATE `info_center` SET  `INFO_NO` = '08', `INFO_NAME1` = '日志', `ICON_PATH` = 'cygn.png' WHERE `INFO_ID` = 7;";
                                    String sql8 = "UPDATE `info_center` SET `INFO_NO` = '09', `INFO_NAME1` = '文件柜', `ICON_PATH` = '0128.png' WHERE `INFO_ID` = 8;";
                                    String sql9 = "UPDATE `info_center` SET `INFO_NO` = '10', `INFO_NAME1` = '网络硬盘', `ICON_PATH` = '0136.png' WHERE `INFO_ID` = 9;";
                                    String sql10 = "UPDATE `info_center` SET `INFO_NO` = '11', `INFO_NAME1` = '会议通知', `ICON_PATH` = '3010.png',`INFO_FUNC_ID` = '88' WHERE `INFO_ID` = 10;";
                                    String sql11 = "UPDATE `info_center` SET `INFO_NO` = '05', `INFO_NAME1` = '待办公文', `ICON_PATH` = 'hytz.png' WHERE `INFO_ID` = 11;";
                                    String sql12 = "UPDATE `info_center` SET `INFO_NO` = '12', `INFO_NAME1` = '待阅事宜', `ICON_PATH` = '5.png' WHERE `INFO_ID` = 12;";
                                    String sql13 = "INSERT INTO `info_center`( `INFO_NO`, `INFO_NAME1`, `INFO_NAME2`, `INFO_NAME3`, `INFO_NAME4`, `INFO_NAME5`, `INFO_FUNC_ID`, `ICON_PATH`) VALUES ('00', '今日看板A', 'Kanban today A', '今日看板A', '', '', '00', '38.png');";
                                    String sql14 = "INSERT INTO `info_center`( `INFO_NO`, `INFO_NAME1`, `INFO_NAME2`, `INFO_NAME3`, `INFO_NAME4`, `INFO_NAME5`, `INFO_FUNC_ID`, `ICON_PATH`) VALUES ('0b', '今日看板B', 'Kanban today B', '今日看板B', '', '', '0b', '38.png');";
                                    st.executeUpdate(sql1);
                                    st.executeUpdate(sql2);
                                    st.executeUpdate(sql3);//执行SQL语句
                                    st.executeUpdate(sql4);//执行SQL语句
                                    st.executeUpdate(sql5);//执行SQL语句
                                    st.executeUpdate(sql6);//执行SQL语句
                                    st.executeUpdate(sql7);//执行SQL语句
                                    st.executeUpdate(sql8);//执行SQL语句
                                    st.executeUpdate(sql9);//执行SQL语句
                                    st.executeUpdate(sql10);//执行SQL语句
                                    st.executeUpdate(sql11);//执行SQL语句
                                    st.executeUpdate(sql12);//执行SQL语句;
                                    st.executeUpdate(sql13);//执行SQL语句
                                    st.executeUpdate(sql14);//执行SQL语句;
                                }
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "BP_NO")) {
                                String sql = " ALTER TABLE `user` MODIFY COLUMN  `BP_NO` varchar(50) DEFAULT '' COMMENT '主题颜色';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "user_dept_order")) {
                                String sql = "CREATE TABLE `user_dept_order` (\n" +
                                        "  `ORDER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',\n" +
                                        "  `DEPT_ID` int(11) NOT NULL COMMENT '部门ID',\n" +
                                        "  `ORDER_NO` int(11) NOT NULL DEFAULT '0' COMMENT '在该部门的排序号',\n" +
                                        "  `POST_ID` int(11) NOT NULL DEFAULT '0' COMMENT '在该部门的职务',\n" +
                                        "  PRIMARY KEY (`ORDER_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门独立用户排序表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cus_receipt")) {
                                String sql = "CREATE TABLE `cus_receipt` (\n" +
                                        "  `RECEIPT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '收款单ID',\n" +
                                        "  `CUSTOMER_ID` int(11) DEFAULT NULL COMMENT '往来单位ID',\n" +
                                        "  `ACTIVITY` varchar(255) DEFAULT NULL COMMENT '活动名称',\n" +
                                        "  `ACTIVITY_TYPE` varchar(50) DEFAULT NULL COMMENT '活动类别',\n" +
                                        "  `RECEIPT_PRICE` double DEFAULT NULL COMMENT '收款金额',\n" +
                                        "  `USER_ID` varchar(50) DEFAULT NULL COMMENT '经手人',\n" +
                                        "  `ACTIVITY_TIME` datetime DEFAULT NULL COMMENT '活动时间',\n" +
                                        "  `REMARK` text DEFAULT NULL COMMENT '备注',\n" +
                                        "   `WAREHOUSE_ID`  int(11) DEFAULT NULL COMMENT '仓库ID'," +
                                        "  PRIMARY KEY (`RECEIPT_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='收款表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "cus_payment")) {
                                String sql = "CREATE TABLE `cus_payment` (\n" +
                                        "  `PAYMENT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '付款单ID',\n" +
                                        "  `CUSTOMER_ID` int(11) DEFAULT NULL COMMENT '往来单位ID',\n" +
                                        "  `ACTIVITY` varchar(255) DEFAULT NULL COMMENT '活动名称',\n" +
                                        "  `ACTIVITY_TYPE` varchar(50) DEFAULT NULL COMMENT '活动类别',\n" +
                                        "  `RECEIPT_PRICE` double DEFAULT NULL COMMENT '付款金额',\n" +
                                        "  `USER_ID` varchar(50) DEFAULT NULL COMMENT '经手人',\n" +
                                        "  `ACTIVITY_TIME` datetime DEFAULT NULL COMMENT '活动时间',\n" +
                                        "  `REMARK` text DEFAULT NULL COMMENT '备注',\n" +
                                        "   `WAREHOUSE_ID`  int(11) DEFAULT NULL COMMENT '仓库ID'," +
                                        "  PRIMARY KEY (`PAYMENT_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='付款表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "USER_DEPT_ORDER")) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('USER_DEPT_ORDER', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "NEWS_AUDITING_YN")) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('NEWS_AUDITING_YN', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "NEWS_AUDITERS")) {
                                String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('NEWS_AUDITERS', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                                //如果需要执行多个则用&&符判断
                            }


                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "75", "SMS_REMIND")) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('75', '合同管理', NULL, NULL, NULL, NULL, NULL, NULL, '75', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_run_prcs", "OPADD_USER")) {
                                String sql = "ALTER TABLE `flow_run_prcs` add `OPADD_USER` varchar(50) DEFAULT NULL COMMENT '加签人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "RELATION_WORK_YN")) {
                                String sql = "ALTER TABLE  flow_process ADD `RELATION_WORK_YN` char(10) NOT NULL DEFAULT '0' COMMENT '允许添加关联工作(0-不允许，1-允许)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "AUDITER")) {
                                String sql = "ALTER TABLE `news` add `AUDITER` varchar(50) NOT NULL DEFAULT '' COMMENT '审批人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "AUDITER_TIME")) {
                                String sql = "ALTER TABLE `news` add `AUDITER_TIME` datetime NOT NULL  DEFAULT '0000-00-00 00:00:00' COMMENT '审批时间';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "AUDITER_STATUS")) {
                                String sql = "ALTER TABLE `news` add `AUDITER_STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '审批状态(0-待审批,1-批准，2-不批准)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "257")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('257', 'z00835', '新闻审核设置', NULL, NULL, NULL, NULL, NULL, '/news/setAuditing', '', NULL, NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "258")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('258', '2015', '新闻审核', NULL, NULL, NULL, NULL, NULL, '/news/doAuditing', '', NULL, NULL, NULL, '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "303")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (303, 'z014', '华为Welink设置', NULL, NULL, NULL, NULL, NULL, 'weLink/index', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "QUERY_FIELD")) {
                                String sql = "ALTER TABLE  `flow_type` ADD  `QUERY_FIELD` text COMMENT '查询条件字段定义';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "QUERY_LIST_FIELD")) {
                                String sql = "ALTER TABLE  `flow_type` ADD `QUERY_LIST_FIELD` text COMMENT '查询列表字段定义';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "QUERY_NEW_YN")) {
                                String sql = "ALTER TABLE  `flow_type` ADD `QUERY_NEW_YN` char(10) DEFAULT '0' COMMENT '是否查询界面允许新建';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "413")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (413, '5520', '费用管理', '', '費用管理', NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "414")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (414, '552001', '我的费用', '', '我的費用', NULL, NULL, NULL, 'charge/mine', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "415")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (415, '552005', '部门费用', '', '部門費用', NULL, NULL, NULL, 'charge/list/0/dept', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "416")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (416, '552010', '费用统计', '', '費用統計', NULL, NULL, NULL, 'charge/statistics', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "417")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (417, '552015', '费用设置', '', '費用設置', NULL, NULL, NULL, 'charge/indexSeting', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "77", "SMS_REMIND")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('77', '公安局值班管理', NULL, NULL, NULL, NULL, NULL, NULL, '77', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2082")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2082, '500720', '值班安排', '', '值班安排', NULL, NULL, NULL, 'DutyPoliceUsers/queryDuty', '', '0', NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "charge_list")) {
                                String sql = "CREATE TABLE `charge_list` (\n" +
                                        "  `CHARGE_LIST_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `USER_ID` varchar(50) NOT NULL DEFAULT '' COMMENT '报销用户ID',\n" +
                                        "  `USER_NAME` varchar(100) NOT NULL DEFAULT '' COMMENT '报销用户姓名',\n" +
                                        "  `REASON` text NOT NULL COMMENT '事由',\n" +
                                        "  `PAYMENT_DATE` date NOT NULL COMMENT '报销日期',\n" +
                                        "  `CHARGE_COST` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '报销金额',\n" +
                                        "  `CHARGE_TYPE_PARENTID` int(11) NOT NULL DEFAULT '0' COMMENT '报销科目',\n" +
                                        "  `CHARGE_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '报销子科目',\n" +
                                        "  `CHARGE_UNDERTAKER` char(10) NOT NULL DEFAULT '' COMMENT '费用承担者（1个人，2部门，3公司）',\n" +
                                        "  `CREATOR` varchar(50) NOT NULL DEFAULT '' COMMENT '创建用户',\n" +
                                        "  `CREATOR_QUARTER` char(10) NOT NULL DEFAULT '' COMMENT '创建季度（1第一季度，2第二季度，3第三季度，4第四季度）',\n" +
                                        "  `CREATE_TIME` datetime NOT NULL COMMENT '创建日期',\n" +
                                        "  PRIMARY KEY (`CHARGE_LIST_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='费用信息';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "charge_permission")) {
                                String sql = "CREATE TABLE `charge_permission` (\n" +
                                        "  `CHARGE_PERMISSION_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `MANAGER_TYPE` char(10) NOT NULL DEFAULT '' COMMENT '管理者类型，1-部门，2-角色，3-用户',\n" +
                                        "  `MANAGER_USERS` text COMMENT '管理者',\n" +
                                        "  `MANAGER_USERSNAME` text COMMENT '管理者名称',\n" +
                                        "  `SET_TYPE` char(10) NOT NULL DEFAULT '' COMMENT '查看范围类型，1-全公司，2-部门，3-角色，4-用户',\n" +
                                        "  `MANAGER_AREA` text COMMENT '管理范围',\n" +
                                        "  `MANAGER_AREANAME` text COMMENT '管理范围名称',\n" +
                                        "  `HAS_CHILDREN` char(10) NOT NULL DEFAULT '' COMMENT '包含子部门(1是，2否)',\n" +
                                        "  PRIMARY KEY (`CHARGE_PERMISSION_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限设置';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "charge_setting")) {
                                String sql = "CREATE TABLE `charge_setting` (\n" +
                                        "  `SETTING_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `SET_TYPE` char(10) NOT NULL DEFAULT '' COMMENT '设置对象，2部门，3用户',\n" +
                                        "  `ALERT_METHOD` char(10) NOT NULL DEFAULT '' COMMENT '预警方式（1年，2季度，3月，4自定义周期）',\n" +
                                        "  `ALERT_TYPE` char(10) NOT NULL DEFAULT '' COMMENT '预设金额类型（1总值，2按科目设置）',\n" +
                                        "  `ALERT_VALUE` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '预警金额',\n" +
                                        "  `ALERT_DATA_START` date DEFAULT NULL COMMENT '预警周期 开始日期',\n" +
                                        "  `ALERT_DATA_END` date DEFAULT NULL COMMENT '预警周期 结束日期',\n" +
                                        "  `USER_ID` text COMMENT '报销用户ID',\n" +
                                        "  `USER_NAME` text COMMENT '报销用户名称',\n" +
                                        "  `DEPT_ID` text COMMENT '报销部门ID',\n" +
                                        "  `DEPT_NAME` text COMMENT '报销部门名称',\n" +
                                        "  `CREATED_TIME` datetime NOT NULL COMMENT '创建日期',\n" +
                                        "  PRIMARY KEY (`SETTING_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预警设置';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "charge_type")) {
                                String sql = "CREATE TABLE `charge_type` (\n" +
                                        "  `CHARGE_TYPE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `CHARGE_TYPE_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '费用类型名称',\n" +
                                        "  `CHARGE_TYPE_PARENT` int(11) NOT NULL DEFAULT '0' COMMENT '费用顶级ID（默认为0）',\n" +
                                        "  `CHARGE_TYPE_ORDER` int(11) NOT NULL DEFAULT '0' COMMENT '排序',\n" +
                                        "  `CHARGE_TYPE_VALUE` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '预警金额',\n" +
                                        "  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建日期',\n" +
                                        "  PRIMARY KEY (`CHARGE_TYPE_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='费用类型';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "charge_setting_type")) {
                                String sql = "CREATE TABLE `charge_setting_type` (\n" +
                                        "  `CHARGE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `SETTING_ID` int(11) NOT NULL DEFAULT '0' COMMENT '预警设置ID',\n" +
                                        "  `CHARGE_TYPE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '费用类型ID',\n" +
                                        "  `CHARGE_TYPE_NAME` varchar(255) DEFAULT '' COMMENT '费用类型名称',\n" +
                                        "  `CHARGE_TYPE_VALUE` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '预警金额',\n" +
                                        "  `CREATED_TIME` datetime DEFAULT NULL COMMENT '创建日期',\n" +
                                        "  PRIMARY KEY (`CHARGE_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='费用预警和类型中间表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "GROUP_USER_YN")) {
                                String sql = "ALTER TABLE  flow_type ADD `GROUP_USER_YN` char(10) NOT NULL DEFAULT '0' COMMENT '允许选择经办人时自定义组不受经办权限限制(0-受限，1-不受限)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "NOMAIN_SIGNER_FILE_YN")) {
                                String sql = "ALTER TABLE  flow_process ADD `NOMAIN_SIGNER_FILE_YN` char(10) DEFAULT '1' COMMENT '是否允许本步骤无主办人会签上传、删除附件(含表单附件和图片上传，0-否，1-是)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "cp_asset_reflect", "CPTL_KIND")) {
                                String sql = "alter table cp_asset_reflect alter CPTL_KIND set default '';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "alter table cp_asset_reflect alter KEEPER set default '';";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "alter table cp_asset_reflect alter LOGOUT_TIME set default '';";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "alter table cp_asset_reflect alter BUY_TIME set default '';";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "alter table cp_asset_reflect alter USE_YY set default '';";
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "duty_police_users")) {
                                String sql = "CREATE TABLE `duty_police_users` (\n" +
                                        "  `DUTY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                        "  `DUTY_DATE` date NOT NULL COMMENT '值班日期 ',\n" +
                                        "  `BTREE_USERS` varchar(255) DEFAULT NULL COMMENT '局带班',\n" +
                                        "  `BDUTY_USERS` varchar(255) DEFAULT NULL COMMENT '局值班',\n" +
                                        "  `TTREE_USERS` varchar(255) DEFAULT NULL COMMENT '总站带班',\n" +
                                        "  `TDUTY_USERS` varchar(255) DEFAULT NULL COMMENT '总站值班',\n" +
                                        "  `OPERATING_USERS` varchar(255) DEFAULT NULL COMMENT '操作员',\n" +
                                        "  `PREPARATION_USERS` varchar(255) DEFAULT NULL COMMENT '总站备勤',\n" +
                                        "  `CBIG_USERS` varchar(255) DEFAULT NULL COMMENT '中心值班长',\n" +
                                        "  `CPERSON_USERS` varchar(255) DEFAULT NULL COMMENT '中心值班员',\n" +
                                        "  `CONTENT` text COMMENT '事务内容',\n" +
                                        "  `CREATE_USER` varchar(50) NOT NULL COMMENT '创建用户',\n" +
                                        "  `CREATE_TIME` datetime NOT NULL COMMENT '创建时间',\n" +
                                        "  PRIMARY KEY (`DUTY_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公安值班管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (Verification.CheckIsExistMenu(conn, driver, url, username, password, "10")) {
                                String sql = "update sys_menu set menu_name = '流程中心' where menu_id=10;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExist(conn, driver, "flow_operation", "OP_ID", "14")) {
                                String sql = "INSERT INTO `flow_operation`(`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES (14, '14', '办毕', 'workflow/work/updateFrpByPrcsId', 'conditionsSet');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExist(conn, driver, "flow_operation", "OP_ID", "15")) {
                                String sql = "INSERT INTO `flow_operation`(`OP_ID`, `OP_NO`, `OP_NAME`, `USE_FUNC`, `PIC_NAME`) VALUES (15, '15', '恢复办理', 'workflow/work/updateFrpByPrcsId', 'conditionsSet');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document_exchange_outunit", "ORG_FULL_NAME")) {
                                String sql = "ALTER TABLE  `document_exchange_outunit` ADD COLUMN `ORG_FULL_NAME` varchar(255) NULL COMMENT '单位全称' AFTER `OUNIT_DESC`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "main_origin_file")) {
                                String sql = "ALTER TABLE  document ADD `main_origin_file` varchar(255) DEFAULT NULL COMMENT '原始正文ID'; ";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "main_origin_file_name")) {
                                String sql = "ALTER TABLE  document ADD `main_origin_file_name` varchar(255) DEFAULT NULL COMMENT '原始正文名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "main_clear_file")) {
                                String sql = "ALTER TABLE  document ADD `main_clear_file` varchar(255) DEFAULT NULL COMMENT '清稿正文ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document", "main_clear_file_name")) {
                                String sql = "ALTER TABLE  document ADD `main_clear_file_name` varchar(255) DEFAULT NULL COMMENT '清稿正文名称';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (isAppNewVersion(UpdatesoftVersion, dataversion)) {

                                String sql = "UPDATE `user` SET MYTABLE_LEFT= concat('00,',MYTABLE_LEFT) WHERE MYTABLE_LEFT <> 'ALL' AND MYTABLE_LEFT NOT LIKE concat('%','00,','%');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "update user set theme =20 where uid =1";
                                st.executeUpdate(sql);//执行SQL语句

                                sql = "UPDATE `portals` \n" +
                                        "SET portals_show = concat( '00,', portals_show ) \n" +
                                        "WHERE\n" +
                                        "         portals_id = '1' AND portals_show NOT LIKE concat( '%', '00,', '%' ) \n" +
                                        "        and  portals_show NOT LIKE concat( '%', '0b,', '%' );";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES ( 3, '办公门户', 0, '', '', 1, NULL, '', '', 0, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (4, '公司门户', 0, '', '', 1, NULL, '', '', 0, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES ( 5, '流程门户', 0, '', '', 1, '', '', '', 0, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES ( 6, '公文门户', 0, '', '', 1, '', '', '', 0, ' ', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES ( 7, '知识门户', 0, '', '', 1, NULL, '', '', 0, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`( `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (8, '人力门户', 0, '', '', 1, NULL, '1,', '', 1, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`( `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (9, '营销门户', 0, '', '', 1, NULL, '1,', '', 1, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`(`portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (10, '财务门户', 0, '', '', 1, NULL, '1,', '', 1, '', '', 0, '', '0');";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`( `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (12, '报表门户', 0, '', '', 1, NULL, '1,', '', 1, '', '', 0, '', '0');\n";
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "INSERT INTO `portals`( `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (11, '管理门户', 0, '', '', 1, '', '1,', '', 1, '', '', NULL, '04,01,06,03,05,09,07,08,02,', '0');";
                                st.executeUpdate(sql);//执行SQL语句


                            }

                            if (isAppNewVersion("2020.07.01.1", dataversion)) {
                                if (!Verification.CheckIsExistPor(conn, driver, url, username, password, "42")) {
                                    String sql = "INSERT INTO `portals`(`portals_id`, `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (42, 22, '办公综合门户', 1, '', '/portals/officeIndex', 1, NULL, '', '', 0, '', '', 0, '', '0');";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }

                                if (!Verification.CheckIsExistPor(conn, driver, url, username, password, "43")) {
                                    String sql = "INSERT INTO `portals`(`portals_id`, `portals_no`, `portal_name`, `portal_type`, `portal_link`, `module_id`, `use_flag`, `access_priv_dept`, `access_priv_priv`, `access_priv_user`, `access_priv`, `portals_show`, `portals_menu`, `show_num`, `portals_manage`, `new_window`) VALUES (43, 23, '办公管理门户', 1, '', '/portals/dazueduIndex', 1, '', '1,', '', 0, '', '', 0, '', '0');";
                                    Statement st = conn.createStatement();
                                    st.executeUpdate(sql);//执行SQL语句
                                }
                            }

                            if (Verification.CheckIsExistPor(conn, driver, url, username, password, "40")) {
                                String sql = "DELETE  FROM `portals` WHERE `portals_id`='40' and `portal_name`='办公门户';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            // 初始化user_dept_order 表用于部门内排序
                            String NowdataVersion = dataversion.replaceAll("\\.", "");
                            if (Integer.parseInt(NowdataVersion) < 202004101) {
                                String sql_5 = "TRUNCATE TABLE user_dept_order;" +
                                        "insert into user_dept_order (USER_ID, DEPT_ID, ORDER_NO, POST_ID) \n" +
                                        "SELECT USER_ID, dep.DEPT_ID, IFNULL( USER_NO, '0' ),IFNULL( POST_ID, '0' )\n" +
                                        "FROM department dep\n" +
                                        "LEFT JOIN USER u on (dep.DEPT_ID = u.DEPT_ID or (u.DEPT_ID_OTHER like concat('%,',dep.DEPT_ID,',%') or u.DEPT_ID_OTHER like concat(dep.DEPT_ID,',%')))\n" +
                                        "where  u.USER_ID is not NULL ;";
                                Statement st5 = conn.createStatement();
                                st5.executeUpdate(sql_5);
                            }
                            // 修改日志关联字段（事务表->公告表）
                            if (Integer.parseInt(NowdataVersion) < 202004101) {
                                String sql_2 = "UPDATE app_log al\n" +
                                        "left join sms s  on al.OPP_ID = s.sms_id\n" +
                                        "left join sms_body sb on s.body_id = sb.body_id \n" +
                                        "SET OPP_ID = right(REMIND_URL,LOCATE('=',REVERSE(REMIND_URL))-1)\n" +
                                        "where module=4 and locate('/notice/detail?notifyId=',REMIND_URL)>0 ;";
                                Statement st2 = conn.createStatement();
                                st2.executeUpdate(sql_2);
                            }
                            //初始化所有系统代码项为不可删除/删除系统内置的岗位、职务
                            if (Integer.parseInt(NowdataVersion) < 202005101) {
                                String sql = "update sys_code set CODE_FLAG = 0;" +
                                        "delete from sys_code where CODE_NO = 'WORK_JOB' or PARENT_NO = 'WORK_JOB' or CODE_NO = 'JOB_POSITION' or PARENT_NO = 'JOB_POSITION';";
                                Statement sta = conn.createStatement();
                                sta.executeUpdate(sql);
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "today_car_no")) {
                                String sql = "CREATE TABLE `today_car_no` (\n" +
                                        "  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',\n" +
                                        "  `DATE` date DEFAULT NULL COMMENT '日期',\n" +
                                        "  `CITY` varchar(100) DEFAULT NULL COMMENT '城市',\n" +
                                        "  `RESTRICTION_FLAG` varchar(2) DEFAULT '1' COMMENT '是否限行(0不限行，1限行)',\n" +
                                        "  `RESTRICTION_NUM` varchar(100) DEFAULT NULL COMMENT '限行尾号，空字符不限行。正常限行格式为1,2',\n" +
                                        "  PRIMARY KEY (`ID`)\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='限行尾号表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "TURN_CONTINUE_YN")) {
                                String sql = "ALTER TABLE  flow_process ADD `TURN_CONTINUE_YN` varchar(10) DEFAULT '0'  COMMENT '允许转交后不办结本步骤，可继续办理(0-不允许,1-允许)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document_exchange_outunit", "OUNIT_FULL_NAME")) {
                                String sql = "ALTER TABLE  `document_exchange_outunit` ADD COLUMN `OUNIT_FULL_NAME` varchar(255) NULL COMMENT '单位全称' AFTER `OUNIT_DESC`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document_exchange_outunit", "OUNIT_SHOT_NAME")) {
                                String sql = "ALTER TABLE  `document_exchange_outunit` ADD COLUMN  `OUNIT_SHOT_NAME` varchar(255) NULL COMMENT '单位简称' AFTER `ORG_FULL_NAME`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "NOMAIN_SIGNER_FILE_YN")) {
                                String sql = "ALTER TABLE  flow_process ADD `NOMAIN_SIGNER_FILE_YN` char(10) DEFAULT '1' COMMENT '是否允许本步骤无主办人会签上传、删除附件(含表单附件和图片上传，0-否，1-是)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "PRCS_EXT_FLAG")) {
                                String sql = "ALTER TABLE  flow_process ADD `PRCS_EXT_FLAG` varchar(255) NULL COMMENT '节点扩展属性';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bbs_board", "BBSRECORD_SEE_YN")) {
                                String sql = "ALTER TABLE `bbs_board` ADD `BBSRECORD_SEE_YN` char(10) DEFAULT 0 COMMENT '看帖权限（1-仅本人和版主有权限查看，0-所有人均可查看）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "bonusmsg", "ID_NUMBER")) {
                                String sql = "ALTER  TABLE `bonusmsg` add `ID_NUMBER` varchar(100) DEFAULT NULL COMMENT '身份证号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句

                                String sqlUpdate = "alter table bonusmsg modify column `DATA_4` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_5` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_6` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_7` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_8` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_9` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_10` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_11` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_12` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_13` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_14` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_15` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_16` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_17` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_18` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_19` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_20` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_21` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_22` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_23` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_24` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_25` varchar(255) DEFAULT NULL;\n" +
                                        "alter table bonusmsg modify column `DATA_26` varchar(255) DEFAULT NULL;";
                                Statement stUp = conn.createStatement();
                                stUp.executeUpdate(sqlUpdate);//执行SQL语句

                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_type", "TO_NOTIFY_YN")) {
                                String sql = "ALTER  TABLE `flow_type` add `TO_NOTIFY_YN` char(10) DEFAULT '0' COMMENT '步骤结束后是否自动转发公告（0-否，1-是）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "COUNTERSIGN_AGAIN")) {
                                String sql = "ALTER TABLE flow_process ADD `COUNTERSIGN_AGAIN`  char(1) DEFAULT '0' COMMENT '是否允许增加的经办人加签(0-不允许，1-允许)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3037")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('3037', '6509', '公文收发', NULL, NULL, NULL, NULL, NULL, '/document/documentDispatchReceive', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "309")) {
                                String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES ('309', 'z015', '关联系统设置', NULL, NULL, NULL, NULL, NULL, '/connect/selectConnect', '', '0', '0', '', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "institution_sort")) {
                                String sql = "CREATE TABLE `institution_sort` (\n" +
                                        "  `SORT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `SORT_NO` int(11) DEFAULT NULL COMMENT '分类排序号',\n" +
                                        "  `SORT_NAME` varchar(255) DEFAULT NULL COMMENT '分类名称',\n" +
                                        "  `SORT_PARENT` int(11) DEFAULT NULL COMMENT '上级分类ID',\n" +
                                        "  `SORT_DESC` text COMMENT '分类描述',\n" +
                                        "  `BELONGTO_DEPTS` text COMMENT '分类所属部门',\n" +
                                        "  `VIEW_DEPTS` text COMMENT '制度文件查看部门',\n" +
                                        "  `VIEW_PRIVS` text COMMENT '制度文件查看角色',\n" +
                                        "  `VIEW_USERS` text COMMENT '制度文件查看人员',\n" +
                                        "  PRIMARY KEY (`SORT_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='制度管理分类表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "institution_content")) {
                                String sql = "CREATE TABLE `institution_content` (\n" +
                                        "  `INST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `SORT_ID` int(11) DEFAULT NULL COMMENT '分类ID',\n" +
                                        "  `INST_TYPE` varchar(10) DEFAULT NULL COMMENT '文档类型(1-HTML,2-FILE)',\n" +
                                        "  `INST_NO` int(11) DEFAULT NULL COMMENT '制度排序号',\n" +
                                        "  `INST_NUMBER` varchar(50) DEFAULT NULL COMMENT '制度编号',\n" +
                                        "  `INST_NAME` varchar(255) DEFAULT NULL COMMENT '文档名称',\n" +
                                        "  `INST_CONTENT` text COMMENT '制度内容',\n" +
                                        "  `KEY_WORDS` varchar(255) DEFAULT NULL COMMENT '制度关键字',\n" +
                                        "  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '制度文件ID',\n" +
                                        "  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '制度文件名称',\n" +
                                        "  `FILE_NUM` int(11) DEFAULT NULL COMMENT '附件数',\n" +
                                        "  `INST_STATUS` char(10) DEFAULT NULL COMMENT '使用状态(0-停用,1-正常)',\n" +
                                        "  `VERSION` varchar(10) DEFAULT NULL COMMENT '当前版本',\n" +
                                        "  `APPROVE_STATUS` char(10) DEFAULT NULL COMMENT '审批状态(0-待批,1-已准,2-未准，3-未提交)',\n" +
                                        "  `APPROVAL_USER` varchar(255) DEFAULT NULL COMMENT '审批人',\n" +
                                        "  `READER_NUM` int(11) DEFAULT '0' COMMENT '制度阅读量',\n" +
                                        "  `READER_USERS` text COMMENT '制度阅读人员',\n" +
                                        "  `OWNER_USER` varchar(50) DEFAULT NULL COMMENT '所有者',\n" +
                                        "  `EDIT_TIME` datetime DEFAULT NULL COMMENT '修改时间',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `EDIT_CONTENT` text COMMENT '编修说明',\n" +
                                        "  `HTML_URL` varchar(255) DEFAULT NULL COMMENT 'HTMLURL',\n" +
                                        "  PRIMARY KEY (`INST_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='制度内容表';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "304")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (304, '3018', '制度管理', NULL, NULL, NULL, NULL, NULL, '@', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "305")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (305, '301810', '制度发布', NULL, NULL, NULL, NULL, NULL, '/institution/release', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "306")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (306, '301815', '制度审核', NULL, NULL, NULL, NULL, NULL, '/institution/examine', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "307")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (307, '301820', '制度查阅', NULL, NULL, NULL, NULL, NULL, '/institution/select', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "308")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (308, '301825', '制度分类', NULL, NULL, NULL, NULL, NULL, '/institution/sort', '', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }
                            //关联应用设置表
                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_relation_func")) {
                                String sql = "CREATE TABLE `flow_relation_func` (\n" +
                                        "  `RELATION_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增,关联应用ID',\n" +
                                        "  `FUNC_NAME` varchar(255) NOT NULL COMMENT '关联应用名',\n" +
                                        "  `FUNC_URL` varchar(255) NOT NULL COMMENT '关联应用URL',\n" +
                                        "  `FUNC_DESC` text NOT NULL COMMENT '应用说明',\n" +
                                        "  PRIMARY KEY (`RELATION_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='关联应用设置表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistMenu(conn, driver, url, username, password, "81")) {
                                String sql = "INSERT INTO `sys_menu`(`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('81', '设备管理', 'equipment', '', '', '', '', '', 'record');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3038")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3038, '8105', '设备台账', '', '', '', '', '', '/equipment/indexList', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3039")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3039, '8110', '设备借还', '', '', '', '', '', '@devicesetting', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3040")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3040, '811005', '设备借还申请', '', '', '', '', '', '/EquipBorrow/indexappli', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3041")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3041, '811010', '设备借还管理', '', '', '', '', '', '/EquipBorrow/BorrowManage', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3042")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3042, '8115', '设备报废', '', '', '', '', '', '@devicesetting', '', '0', '', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3043")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3043, '811505', '设备报废申请', '', '', '', '', '', '/equipmentScrapping/showIndex', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3044")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3044, '811510', '设备报废管理', '', '', '', '', '', '/equipmentScrappingManagement/showIndex', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3045")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3045, '8120', '设备转移', '', '', '', '', '', '@devicesetting', '', '0', '', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3046")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3046, '812005', '设备转移申请', '', '', '', '', '', '/equipTransfer/portabilityApplication', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3047")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3047, '812010', '设备转移管理', '', '', '', '', '', '/equipTransfer/index', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3048")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3048, '812015', '设备转移接收', '', '', '', '', '', '/equipTransfer/equipResive', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3049")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3049, '8125', '设备盘点', '', '', '', '', '', '/equipInventory/inventIndex', '', '0', '', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3050")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3050, '8130', '设备维修', '', '', '', '', '', '/equipment/servicing', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3051")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3051, '8135', '经验库', '', '', '', '', '', '/experience/index', '', '0', '', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3052")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3052, '8140', '定期事件', '', '', '', '', '', '/LimsEquipEventsPlan/eventIndex', '', '0', '0', '', 1);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3053")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3053, '8145', '设备参数设置', '', '', '', '', '', '@devicesetting', '', '0', '0', '', 1);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "3054")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (3054, '814505', '设备类型', '', '', '', '', '', '/equipmentType/indexList', '', '0', '0', '', 1);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "RUN_ID")) {
                                String sql = "ALTER TABLE `news` ADD COLUMN `RUN_ID` int(11) DEFAULT 0 COMMENT '新闻审批关联的runId' AFTER `AUDITER_STATUS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            //设备管理
                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_common_code")) {
                                String sql = "CREATE TABLE `lims_common_code`  (\n" +
                                        "  `CODE_TYEP_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `CODE_TYEP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '业务类型编码，自定义类的命名规则 类型名称+秒时间戳',\n" +
                                        "  `CODE_TYEP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型名称',\n" +
                                        "  `PARENT_TYEP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '代码主类型',\n" +
                                        "  `CODE_TYEP_DECS` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '类型描述',\n" +
                                        "  `CODE_SORT` int(11) NOT NULL COMMENT '排序号',\n" +
                                        "  `DELETE_FLAG` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '代码标记(0-不能删除,1-可删除)',\n" +
                                        "  `ADD_USERNAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  `DATA_SOURCE` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据源',\n" +
                                        "  PRIMARY KEY (`CODE_TYEP_ID`) USING BTREE,\n" +
                                        "  UNIQUE INDEX `CODE_TYEP_NO`(`CODE_TYEP_NO`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'LIMS系统代码表' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (this.isAppNewVersion("2020.08.20.2", dataversion)) {
                                String sql = "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_STATUAS', '设备状态', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_INTACT', '完好', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_STOCK', '库存', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_OCCUPY', '占用', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_SERVICE', '维修', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_SCRAPPED', '报废', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_LEND', '借出', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'EQUIP_STATUAS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'PROPERTY_OWNER', '产权归属', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'PROPERTY_OWNER01', '单位A', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'PROPERTY_OWNER', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE', '设备故障分类', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE1', '功能失效', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE2', '性能下降', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE3', '结构损坏', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE4', '电气损坏', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE5', '介质泄露', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE6', '保护失灵', NULL, NULL, NULL, NULL, NULL, NULL, '06', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE7', '制冷系统', NULL, NULL, NULL, NULL, NULL, NULL, '07', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE8', '程序故障', NULL, NULL, NULL, NULL, NULL, NULL, '08', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_FAILURE9', '其他现象', NULL, NULL, NULL, NULL, NULL, NULL, '09', 'EQUIP_FAILURE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_SOURCE_ASSETS', '资产来源', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'SOURCE_ASSETS0', '购入', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_SOURCE_ASSETS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'SOURCE_ASSETS1', '股权合并', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_SOURCE_ASSETS', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_MODE', '设备维修方式', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_MODE1', '更换备件', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_REPAIR_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_MODE2', '现场维修', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_REPAIR_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_MODE3', '返厂维修', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_REPAIR_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RANK', '设备维修等级', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RANK1', '自行维修', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_REPAIR_RANK', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RANK2', '供应商维修', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_REPAIR_RANK', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RANK3', '维修服务商维修', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_REPAIR_RANK', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_VERIFY_MODE', '维修验证方式', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_VERIFY_MODE1', '试运行', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_VERIFY_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_VERIFY_MODE2', '计量/校准', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_VERIFY_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_VERIFY_MODE3', '局部检验', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_VERIFY_MODE', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RESULT', '维修验证结果', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RESULT1', '故障消除', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'EQUIP_REPAIR_RESULT', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RESULT2', '故障依旧', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'EQUIP_REPAIR_RESULT', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'EQUIP_REPAIR_RESULT3', '故障有改善', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'EQUIP_REPAIR_RESULT', '0', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'MEMBER_TYPE', '党员分类', NULL, NULL, NULL, NULL, NULL, NULL, '120', '', '1', ' ', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '01', '老干部党员', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'MEMBER_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '02', '中共党员', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'MEMBER_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '03', '其他党员', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'MEMBER_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'TYPE_OF_ACCOUNT', '动态监管台账', NULL, NULL, NULL, NULL, NULL, NULL, '120', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '01', '第一支队', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'TYPE_OF_ACCOUNT', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '04', '第四支队', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'TYPE_OF_ACCOUNT', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'JFZB_TYPE', '积分管理一级类型', NULL, NULL, NULL, NULL, NULL, NULL, '210', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '001', '常规', NULL, NULL, NULL, NULL, NULL, NULL, '001', 'JFZB_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '002', '加分', NULL, NULL, NULL, NULL, NULL, NULL, '002', 'JFZB_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '003', '减分', NULL, NULL, NULL, NULL, NULL, NULL, '003', 'JFZB_TYPE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'JFZB_TYPE1', '常规标准', NULL, NULL, NULL, NULL, NULL, NULL, '310', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '001', '常规标准1', NULL, NULL, NULL, NULL, NULL, NULL, '001', 'JFZB_TYPE1', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'JFZB_TYPE2', '加分标准', NULL, NULL, NULL, NULL, NULL, NULL, '410', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '001', '加分标准1', NULL, NULL, NULL, NULL, NULL, NULL, '001', 'JFZB_TYPE2', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '002', '常规标准2', NULL, NULL, NULL, NULL, NULL, NULL, '002', 'JFZB_TYPE1', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '002', '加分标准2', NULL, NULL, NULL, NULL, NULL, NULL, '002', 'JFZB_TYPE2', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, 'JFZB_TYPE3', '减分标准', NULL, NULL, NULL, NULL, NULL, NULL, '410', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '001', '减分标准1', NULL, NULL, NULL, NULL, NULL, NULL, '001', 'JFZB_TYPE3', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (NULL, '002', '减分标准2', NULL, NULL, NULL, NULL, NULL, NULL, '002', 'JFZB_TYPE3', '1', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_dept_location")) {
                                String sql = "CREATE TABLE `lims_dept_location` (\n" +
                                        "\t`POSITION_ID` INT ( 11 ) NOT NULL AUTO_INCREMENT,\n" +
                                        "\t`DEPT_ID` INT ( 11 ) DEFAULT NULL COMMENT '所属结算组织',\n" +
                                        "\t`POSITION_CODE` VARCHAR ( 255 ) DEFAULT NULL COMMENT '位置代码',\n" +
                                        "\t`POSITION_PID` INT ( 11 ) DEFAULT '0',\n" +
                                        "\t`POSITION_NAME` VARCHAR ( 255 ) DEFAULT NULL COMMENT '位置名称',\n" +
                                        "\t`MEMO` VARCHAR ( 255 ) DEFAULT NULL COMMENT '备注',\n" +
                                        "\t`LOCAT_SORT` INT ( 11 ) DEFAULT NULL,\n" +
                                        "\t PRIMARY KEY ( `POSITION_ID` ) USING BTREE\n" +
                                        ") ENGINE = INNODB DEFAULT CHARSET = utf8 ROW_FORMAT = COMPACT COMMENT = '部门下的位置，多级位置';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_events_plan")) {
                                String sql = "CREATE TABLE `lims_equip_events_plan`  (\n" +
                                        "  `EVENT_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EQUIP_EVENT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备事件ID 从common_code表中读取字段CODE_TYEP_NO值为EQUIP_EVENT_TYPE的列表，获取并记录CODE_NO值',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型ID',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定资产编号',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `FREQUENCY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '维护频率：每两年 1、每年 2、每月 3、每季度 4、每周 5、每天 6',\n" +
                                        "  `REMIND_DAYS` int(255) NULL DEFAULT NULL COMMENT '提前提醒天数',\n" +
                                        "  `LAST_EXE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '上次执行日期',\n" +
                                        "  `NEST_EXE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '下次到期日期',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '当前登录人所在结算组织',\n" +
                                        "  `UPDATE_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '事件添加人',\n" +
                                        "  `UPDATE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加人姓名',\n" +
                                        "  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '事件添加日期',\n" +
                                        "  `COMPANY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检定校准单位',\n" +
                                        "  `INSPECTFORM` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '送检形式',\n" +
                                        "  PRIMARY KEY (`EVENT_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备定期事件计划' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_capy")) {
                                String sql = "CREATE TABLE `lims_equip_capy`  (\n" +
                                        "  `CAPY_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '与<lims_items>CAPY_IDS有关',\n" +
                                        "  `CAPY_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '能力项名称',\n" +
                                        "  `CAPY_STATUS` int(11) NULL DEFAULT NULL COMMENT '能力状态控制：新建0，已启用1，已作废10',\n" +
                                        "  `UNIT_LIST` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单位集 LIST,与静态表lims_units相关',\n" +
                                        "  `INPUT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '输入类型：数字、文字、日期、下拉、时间、多选',\n" +
                                        "  `OPERAT_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '与设备能力值比较方式，计算方式，运算方式\\r\\n0: >=设备能力值\\r\\n1: <=设备能力值\\r\\n2: 包含设备能力值',\n" +
                                        "  `DATA_SOURCE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源，能力项包含的数据有哪些，JSON格式，比如能力项为“波形”的数据有“半正弦”等',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `TYPE_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备能力类型',\n" +
                                        "  `PROTOCOL_FIELD` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '协议字段，json通讯协议的字段描述，不能重复。',\n" +
                                        "  PRIMARY KEY (`CAPY_ID`) USING BTREE,\n" +
                                        "  UNIQUE INDEX `PROTOCOL_FIELD`(`PROTOCOL_FIELD`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_capy_lims_equip_capy_type_1`(`TYPE_CODE`) USING BTREE" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备能力项，参数项。\\r\\n\\r\\n0: >=设备能力值\\r\\n1: <=设备能力值\\r\\n2: 包含设备能力值' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_event_plan_para")) {
                                String sql = "CREATE TABLE `lims_equip_event_plan_para`  (\n" +
                                        "  `PLAN_PARA_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EVENT_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `PARA_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数名称/指标项',\n" +
                                        "  `INITIAL_VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '测量点',\n" +
                                        "  `ERROR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '允许的误差',\n" +
                                        "  PRIMARY KEY (`PLAN_PARA_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_event_plan_para_lims_equip_events_plan_1`(`EVENT_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定期事件计划参数' ROW_FORMAT = DYNAMIC;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_eventlog")) {
                                String sql = "CREATE TABLE `lims_equip_eventlog`  (\n" +
                                        "  `EVENT_LOG_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EVENT_ID` int(11) NULL DEFAULT NULL COMMENT '虽然做了外键，但不做级联删除，计划删掉时，要保留定期事件执行历史',\n" +
                                        "  `EQUIP_EVENT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备事件ID 从common_code表中读取字段CODE_TYEP_NO值为EQUIP_EVENT_TYPE的列表，获取并记录CODE_NO值',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定资产编号',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `FREQUENCY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检定校准周期/维护频率：每两年、每年、每月、每季度、每周、每天',\n" +
                                        "  `EXE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '检定校准日期，上次执行日期',\n" +
                                        "  `EXPIRE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '下次到期日期',\n" +
                                        "  `COMPANY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检定校准单位',\n" +
                                        "  `CONCLU_RANGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '测量范围确认，1符合，0不符合',\n" +
                                        "  `CERT_NO` int(11) NULL DEFAULT NULL COMMENT '证书编号',\n" +
                                        "  `USED_EQUIP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '使用设备，手动录入',\n" +
                                        "  `CONCLU_INTEGRITY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '项目完整性确认，1符合，0不符合',\n" +
                                        "  `CONCLU_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '确认结论，1 符合，0 不符合，10 误差+不确定度结果超差时增加期间核查',\n" +
                                        "  `CONCLU_USDESIRE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `CONCLU_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '确认人',\n" +
                                        "  `CONCLU_ADDTIME` datetime(0) NULL DEFAULT NULL COMMENT '确认时间',\n" +
                                        "  `AUDITMIND` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核意见，1 符合，0不符合，10 误差+不确定度结果超差时增加期间核查',\n" +
                                        "  `APPROVER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核人员',\n" +
                                        "  `APPROVER_TIME` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号',\n" +
                                        "  `IDENT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标识类别',\n" +
                                        "  `GRANT_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发放人',\n" +
                                        "  `GRANT_TIME` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '发放时间',\n" +
                                        "  `RECEIVE_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `RECEIVE_TIME` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型',\n" +
                                        "  PRIMARY KEY (`EVENT_LOG_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_eventlog_lims_equip_events_plan_1`(`EVENT_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备定期事件结果' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_events_capy")) {
                                String sql = "CREATE TABLE `lims_equip_events_capy`  (\n" +
                                        "  `EVENT_CAPY_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EVENT_LOG_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `PARA_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指标项',\n" +
                                        "  `INITIAL_VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规定值',\n" +
                                        "  `CALIBRATION_VALUE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '检定/校准值',\n" +
                                        "  `UNCERTAINTY` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '不确定度',\n" +
                                        "  `ERROR` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '误差',\n" +
                                        "  `CONCLUSION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '确认结论',\n" +
                                        "  PRIMARY KEY (`EVENT_CAPY_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_events_capy_lims_equip_eventlog_1`(`EVENT_LOG_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '检定校准能力值' ROW_FORMAT = DYNAMIC;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_experience")) {
                                String sql = "CREATE TABLE `lims_equip_experience`  (\n" +
                                        "  `EXPER_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EXPER_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '经验代码',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型',\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型名称',\n" +
                                        "  `FAULT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现象分类/故障类型',\n" +
                                        "  `FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发生部位/故障位置',\n" +
                                        "  `FAULT_DESC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障描述',\n" +
                                        "  `IN_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部检测结果',\n" +
                                        "  `IN_FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部故障定位',\n" +
                                        "  `IN_REASON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部原因分析',\n" +
                                        "  `IN_REPAIR_MEASURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修措施',\n" +
                                        "  `IN_REPAIR_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修方式',\n" +
                                        "  `IN_REPAIR_RANK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修等级',\n" +
                                        "  `IN_PRICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修预算',\n" +
                                        "  `OUT_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部检测结果',\n" +
                                        "  `OUT_FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部故障定位',\n" +
                                        "  `OUT_REASON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部原因分析',\n" +
                                        "  `OUT_REPAIR_MEASURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修措施',\n" +
                                        "  `OUT_REPAIR_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修方式',\n" +
                                        "  `OUT_REPAIR_RANK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修等级',\n" +
                                        "  `OUT_PRICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修预算',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`EXPER_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '维修经验库' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_file")) {
                                String sql = "CREATE TABLE `lims_equip_file`  (\n" +
                                        "  `FILE_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `FILE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL,\n" +
                                        "  `UPDATE_NMAE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `ATTACHMENT_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件ID串',\n" +
                                        "  `ATTACHMENT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件文件名串',\n" +
                                        "  PRIMARY KEY (`FILE_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备附件、文件管理' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_lend")) {
                                String sql = "CREATE TABLE `lims_equip_lend`  (\n" +
                                        "  `LEND_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',\n" +
                                        "  `BORROWER_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借用人',\n" +
                                        "  `BORROWER_DETP_ID` int(11) NULL DEFAULT NULL COMMENT '借入组织ID',\n" +
                                        "  `BORROW_TIME` datetime(0) NULL DEFAULT NULL COMMENT '借用日期',\n" +
                                        "  `LEND_DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '借出组织ID',\n" +
                                        "  `RETURN_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '处理状态；全部归还2、部分归还1、未归还0',\n" +
                                        "  `EXPECT_RETURN_DATE` datetime(0) NULL DEFAULT NULL COMMENT '预计归还日期',\n" +
                                        "  `REMINDER_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提前提醒归还时间',\n" +
                                        "  `BORROWER_OPERATION_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '借用操作人',\n" +
                                        "  `BORROW_OPERATION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '借用操作时间',\n" +
                                        "  `APPROVER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批人',\n" +
                                        "  `APPROVER_TIME` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '审批时间',\n" +
                                        "  `APPROVAL_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批状态：新建0、待批准1、已批准2、未批准3',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号，有流水号的不允许删除',\n" +
                                        "  PRIMARY KEY (`LEND_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备借还单' ROW_FORMAT = DYNAMIC;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_lendlist")) {
                                String sql = "CREATE TABLE `lims_equip_lendlist`  (\n" +
                                        "  `LEND_LIST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',\n" +
                                        "  `LEND_ID` int(11) NULL DEFAULT NULL COMMENT '借还记录ID',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定资产编号',\n" +
                                        "  `RETURN_STATUS` int(11) NULL DEFAULT NULL COMMENT '归还状态；未归还 0、已归还 1',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `RETURN_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归还时间',\n" +
                                        "  `RETURN_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归还人',\n" +
                                        "  `RETURN_OPERATOR_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '归还操作人',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '记录借用前设备的状态，可用于撤回时将设备状态恢复成原始数据；读取equipment表的EQUIP_STATUAS_CODE',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型ID',\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型名称',\n" +
                                        "  PRIMARY KEY (`LEND_LIST_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_lendlist_lims_equipment_1`(`EQUIP_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_lendlist_lims_equip_lend_1`(`LEND_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '借还明细表' ROW_FORMAT = DYNAMIC;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_ownerlist")) {
                                String sql = "CREATE TABLE `lims_equip_ownerlist`  (\n" +
                                        "  `OWNERLIST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',\n" +
                                        "  `OWNERLOG_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产编号',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产状态',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `RECEIVE_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收状态：1已接收，0未接收',\n" +
                                        "  `RECEIVE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '接收时间',\n" +
                                        "  `ORIGINAL_POSITION_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原存放地点',\n" +
                                        "  `ORIGINAL_POSITION_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `NEW_POSITION_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `NEW_POSITION_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '新存放地点',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`OWNERLIST_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_ownerlist_lims_equip_ownerlog_copy_1_1`(`OWNERLOG_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备转移明细' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_ownerlog")) {
                                String sql = "CREATE TABLE `lims_equip_ownerlog`  (\n" +
                                        "  `OWNERLOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录ID',\n" +
                                        "  `TRANSFER_DATE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调拨日期',\n" +
                                        "  `ORIGINAL_DEPT_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原部门',\n" +
                                        "  `ORIGINAL_CUSTODIAN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '原保管人',\n" +
                                        "  `NEW_DEPT_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '新部门',\n" +
                                        "  `NEW_CUSTODIAN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '新保管人',\n" +
                                        "  `APPLICATION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请人',\n" +
                                        "  `APPLICATION_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请时间',\n" +
                                        "  `APPROVER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批准人',\n" +
                                        "  `APPROVER_TIME` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '批准时间',\n" +
                                        "  `APPROVAL_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批状态',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号',\n" +
                                        "  `RECEIVE_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收状态：全部接收2，部分接收1，未接收0',\n" +
                                        "  `RECEIVE_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接收人',\n" +
                                        "  PRIMARY KEY (`OWNERLOG_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产所属记录、调配记录、转移记录' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_parts")) {
                                String sql = "CREATE TABLE `lims_equip_parts`  (\n" +
                                        "  `PART_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EQUIP_ID` int(11) NOT NULL COMMENT '设备ID',\n" +
                                        "  `PART_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号',\n" +
                                        "  `PART_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '配件名称',\n" +
                                        "  `CHANGE_TIMES` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更换周期，更换频次',\n" +
                                        "  `INSTALL_TIME` datetime(0) NULL DEFAULT NULL COMMENT '安装时间',\n" +
                                        "  `NEXT_INSTALL_TIME` datetime(0) NULL DEFAULT NULL COMMENT '下次安装时间',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号规格',\n" +
                                        "  PRIMARY KEY (`PART_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_parts_lims_equipment_1`(`EQUIP_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备配件表' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_reparlog")) {
                                String sql = "CREATE TABLE `lims_equip_reparlog`  (\n" +
                                        "  `REPALOG_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型',\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型名称',\n" +
                                        "  `FAULT_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '现象分类/故障类型',\n" +
                                        "  `FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发生部位/故障位置',\n" +
                                        "  `FAULT_DESC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障描述',\n" +
                                        "  `ATMOSPHERE_TEMP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '温度',\n" +
                                        "  `ATMOSPHERE_HUMI` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '湿度',\n" +
                                        "  `ATMOSPHERE_PRESS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大气压',\n" +
                                        "  `VOLTAGE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供电电压',\n" +
                                        "  `RESISTANCE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接地电阻',\n" +
                                        "  `WATER_PRESSURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '冷却水压',\n" +
                                        "  `WATER_TEMP` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '冷却水温',\n" +
                                        "  `PRESSURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供气气压',\n" +
                                        "  `APPLICATION_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报修时间',\n" +
                                        "  `IN_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部检测结果',\n" +
                                        "  `IN_FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部故障定位',\n" +
                                        "  `IN_REASON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部原因分析',\n" +
                                        "  `IN_REPAIR_MEASURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修措施',\n" +
                                        "  `IN_REPAIR_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修方式',\n" +
                                        "  `IN_REPAIR_RANK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修等级',\n" +
                                        "  `IN_PLAN_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部计划完成时间',\n" +
                                        "  `IN_PRICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部维修预算',\n" +
                                        "  `IN_PERSON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部诊断人员',\n" +
                                        "  `IN_REPAIR_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内部诊断时间',\n" +
                                        "  `OUT_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部检测结果',\n" +
                                        "  `OUT_FAULT_POSITION` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部故障定位',\n" +
                                        "  `OUT_REASON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部原因分析',\n" +
                                        "  `OUT_REPAIR_MEASURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修措施',\n" +
                                        "  `OUT_REPAIR_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修方式',\n" +
                                        "  `OUT_REPAIR_RANK` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修等级',\n" +
                                        "  `OUT_PLAN_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部计划完成时间',\n" +
                                        "  `OUT_PRICE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部维修预算',\n" +
                                        "  `OUT_PERSON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部诊断人员',\n" +
                                        "  `OUT_REPAIR_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外部诊断时间',\n" +
                                        "  `VERIFY_MEASURE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证措施',\n" +
                                        "  `EQUIP_VERIFY_MODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证方式',\n" +
                                        "  `EQUIP_REPAIR_RESULT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证结果',\n" +
                                        "  `REPORT_DONE_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '维修完成时间',\n" +
                                        "  `VERIFY_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证人',\n" +
                                        "  `VERIFY_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '验证时间',\n" +
                                        "  `APPLICANT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '申请人/报修人',\n" +
                                        "  `APPLICANT_TIME` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '申请时间/报修时间',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号',\n" +
                                        "  `REPAIR_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '维修状态，1是报修中，2是维修中，3是验证中，0是已完成',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '报修部门',\n" +
                                        "  PRIMARY KEY (`REPALOG_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备维修记录 日志' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_reparlog_file")) {
                                String sql = "CREATE TABLE `lims_equip_reparlog_file`  (\n" +
                                        "  `FILE_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `REPALOG_ID` int(11) NULL DEFAULT NULL COMMENT '立项内部编号',\n" +
                                        "  `ATTACHMENT_NAME` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '附件名称',\n" +
                                        "  `ATTACHMENT_ID` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文件地址',\n" +
                                        "  `UPDATE_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加人',\n" +
                                        "  `UPDATE_NAME` datetime(0) NULL DEFAULT NULL COMMENT '上传时间',\n" +
                                        "  `FILE_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件类型，故障图片1 ，验证结果2',\n" +
                                        "  PRIMARY KEY (`FILE_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_reparlog_file_lims_equip_reparlog_1`(`REPALOG_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备维修附件' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_scraplist")) {
                                String sql = "CREATE TABLE `lims_equip_scraplist`  (\n" +
                                        "  `SCRAPLIST_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `SCRAPLOG_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产编号',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `SCRAP_DATE` datetime(0) NULL DEFAULT NULL COMMENT '报废时间',\n" +
                                        "  `REPORTER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报废申请人',\n" +
                                        "  `OPERA` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报废申请操作人',\n" +
                                        "  `OPERA_TIME` datetime(0) NULL DEFAULT NULL COMMENT '报废申请操作时间',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号',\n" +
                                        "  PRIMARY KEY (`SCRAPLIST_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_scraplist_lims_equip_scraplog_1`(`SCRAPLOG_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备报废明细' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_scraplog")) {
                                String sql = "CREATE TABLE `lims_equip_scraplog`  (\n" +
                                        "  `SCRAPLOG_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '报废部门',\n" +
                                        "  `APPLICANT` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报废申请人',\n" +
                                        "  `APPLICANT_TIME` datetime(0) NULL DEFAULT NULL COMMENT '报废申请时间',\n" +
                                        "  `APPROVER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批人',\n" +
                                        "  `APPROVER_TIME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批时间',\n" +
                                        "  `APPROVAL_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审批状态',\n" +
                                        "  `SCRAP_REASON` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报废原因',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `WORKFLOW_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '流水号',\n" +
                                        "  PRIMARY KEY (`SCRAPLOG_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备报废单' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_types")) {
                                String sql = "CREATE TABLE `lims_equip_types`  (\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'EQUIPMENT TYPE 设备类型',\n" +
                                        "  `EQUIP_TYPE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备类型名称',\n" +
                                        "  `EQUIP_TYPE_PID` int(11) NULL DEFAULT 0 COMMENT '设备类型父级ID',\n" +
                                        "  `CAPY_IDS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存储能力项ID，以逗号隔开，不做外键关联，在业务层做处理',\n" +
                                        "  `EQUIP_SORT` int(11) NULL DEFAULT 1 COMMENT '排序',\n" +
                                        "  `EQUIP_TYPE_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `REPORT_CODE` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '“测点代码”转义+“试验方向”，转义规则：加速度测点A，位移测点D，力测点F，温度测点T，湿度测点RH，压力测点P，应变测点B',\n" +
                                        "  PRIMARY KEY (`EQUIP_TYPE_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备类型表' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_uselog")) {
                                String sql = "CREATE TABLE `lims_equip_uselog`  (\n" +
                                        "  `USE_LOG_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL COMMENT '设备ID',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产编号',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `OUTBOUND_TYPE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出库类型，借出给个人1，借出到项目2',\n" +
                                        "  `PROJECT_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `PROJECT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `BORROW_TIME` datetime(0) NULL DEFAULT NULL COMMENT '借出时间/开始使用时间',\n" +
                                        "  `RETURN_TIME` datetime(0) NULL DEFAULT NULL COMMENT '归还时间/结束使用时间',\n" +
                                        "  `BORROW_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '使用人',\n" +
                                        "  `BORROW_USER_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `STEPS_EXE_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '细则执行代码，一个立项下，平板选用设备维度是执行细则代码维度，需要区分，不然无法写入结束日期。',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`USE_LOG_ID`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_ID`(`EQUIP_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备使用记录表（仪器仪表与传感器出入库记录）' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equipment")) {
                                String sql = "CREATE TABLE `lims_equipment`  (\n" +
                                        "  `EQUIP_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备ID（内部编号）',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备编号，即固定资产编号，编码规则：每实验室一套编码规则!!',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_TYPE_ID` int(11) NULL DEFAULT NULL COMMENT '设备类型ID',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '所属独立结算组织ID',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备状态，从common_code表中获取的符合code_type_no等于EQUIP_STATUAS获取的code_type_no',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备型号',\n" +
                                        "  `SPEC` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规格',\n" +
                                        "  `ASSETS_COST` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产原值、成本',\n" +
                                        "  `MANUFACTURER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家、制造商',\n" +
                                        "  `SUPPLIER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商',\n" +
                                        "  `PROPERTY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产编号，产权编号,前端手工输入',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号，工厂编号',\n" +
                                        "  `DATE_PRODUC` datetime(0) NULL DEFAULT NULL COMMENT '出厂日期',\n" +
                                        "  `RECORD_DATE` datetime(0) NULL DEFAULT NULL COMMENT '入账时间、资产记录时间',\n" +
                                        "  `POSITION_ID` int(11) NULL DEFAULT NULL COMMENT '位置信息ID',\n" +
                                        "  `PROPERTY_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产权归属ID,从common_code表中获取的符合code_type_no=PROPERTY_OWNER获取的code_type_no',\n" +
                                        "  `SOURCE_ASSETS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产来源：购入、股权合并，从common表读取type_no=SOURCE_ASSETS',\n" +
                                        "  `ACCOUNT_FILE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '财务账套',\n" +
                                        "  `TECHNICAL_PARM` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技术参数',\n" +
                                        "  `SENSITIVITY_X` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '灵敏度：X向传感器灵敏度',\n" +
                                        "  `SENSITIVITY_Y` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '灵敏度：Y向传感器灵敏度',\n" +
                                        "  `SENSITIVITY_Z` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '灵敏度：Z向传感器灵敏度',\n" +
                                        "  `PHY_QUANTI_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '物理量，读取静态表；加速度、速度、位移、力、电压、压力、声强、流量、温度、湿度、角度',\n" +
                                        "  `COUPLING_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '耦合方式，读取静态表，ICP、电荷、AC单端、AC差分、DC单端、DC差分',\n" +
                                        "  `DIRECTION_ID` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方向ID，读取静态表，三向、单向，从common_code表中获取的符合PARENT_TYEP_NO=SENSOR_DIRECTION获取的code_type_no。',\n" +
                                        "  `CLOUD_SN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '云端SN号',\n" +
                                        "  `CUSTODIAN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人（保管人）',\n" +
                                        "  `STAND_MATE_YN` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否是标准物质,用于质量管理1是，0否',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  `USED_DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '当前使用结算组织',\n" +
                                        "  PRIMARY KEY (`EQUIP_ID`) USING BTREE,\n" +
                                        "  INDEX `lims_equipment_ibfk_2`(`DEPT_ID`) USING BTREE,\n" +
                                        "  INDEX `lims_equipment_ibfk_5`(`EQUIP_TYPE_ID`) USING BTREE,\n" +
                                        "  INDEX `lims_equipment_ibfk_6`(`PROPERTY_CODE`) USING BTREE,\n" +
                                        "  INDEX `EQUIP_STATUAS_ID`(`EQUIP_STATUAS_CODE`) USING BTREE,\n" +
                                        "  INDEX `POSITION_ID`(`POSITION_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备表' ROW_FORMAT = COMPACT;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_inve_cont")) {
                                String sql = "CREATE TABLE `lims_equip_inve_cont`  (\n" +
                                        "  `CONT_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `INVE_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `EQUIP_NO_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定资产编号，0为否，1为是',\n" +
                                        "  `DEPT_ID_YN` int(11) NULL DEFAULT NULL COMMENT '所属部门，0为否，1为是',\n" +
                                        "  `EQUIP_STATUAS_CODE_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产状态，0为否，1为是',\n" +
                                        "  `MODEL_NO_YN` int(11) NULL DEFAULT NULL COMMENT '型号，0为否，1为是',\n" +
                                        "  `ASSETS_COST_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产原值，0为否，1为是',\n" +
                                        "  `MANUFACTURER_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',\n" +
                                        "  `SUPPLIER_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商',\n" +
                                        "  `FACTORY_NO_YN` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `POSITION_ID_YN` int(11) NULL DEFAULT NULL COMMENT '存放位置',\n" +
                                        "  PRIMARY KEY (`CONT_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_inve_cont_lims_equip_inve_plan_1`(`INVE_ID`) USING BTREE" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '盘点内容' ROW_FORMAT = DYNAMIC;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_inve_plan")) {
                                String sql = "CREATE TABLE `lims_equip_inve_plan`  (\n" +
                                        "  `INVE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '盘点计划ID',\n" +
                                        "  `INVE_NO` int(11) NULL DEFAULT NULL COMMENT '盘点单号',\n" +
                                        "  `INVE_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盘点名称',\n" +
                                        "  `INVE_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盘点状态：已盘点、待盘点、部分盘点',\n" +
                                        "  `EQUIP_IDS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备IDS',\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL COMMENT '所属组织ID',\n" +
                                        "  `CHECK_TIME_PLAN` datetime(0) NULL DEFAULT NULL COMMENT '计划盘点时间',\n" +
                                        "  `CHECK_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盘点人员',\n" +
                                        "  `LAVE_CHECK` int(11) NULL DEFAULT NULL COMMENT '剩余未盘数',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`INVE_ID`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备盘点计划' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "lims_equip_inventory")) {
                                String sql = "CREATE TABLE `lims_equip_inventory`  (\n" +
                                        "  `DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '明细ID',\n" +
                                        "  `INVE_ID` int(11) NULL DEFAULT NULL COMMENT '盘点单号',\n" +
                                        "  `EQUIP_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `DEPT_ID` int(11) NULL DEFAULT NULL,\n" +
                                        "  `POSITION_ID` int(11) NULL DEFAULT NULL COMMENT '位置',\n" +
                                        "  `EQUIP_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '固定资产编号',\n" +
                                        "  `EQUIP_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '设备名称',\n" +
                                        "  `EQUIP_STATUAS_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产状态',\n" +
                                        "  `MODEL_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '型号',\n" +
                                        "  `CHECK_USER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盘点人',\n" +
                                        "  `CHECK_TIME` datetime(0) NULL DEFAULT NULL COMMENT '盘点时间',\n" +
                                        "  `WHETHER_CHANGES` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否变动',\n" +
                                        "  `ASSETS_COST` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资产原值',\n" +
                                        "  `MANUFACTURER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生厂厂家',\n" +
                                        "  `SUPPLIER` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '供应商',\n" +
                                        "  `FACTORY_NO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出厂编号',\n" +
                                        "  `MEMO` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,\n" +
                                        "  `INVE_STATUS` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盘点状态',\n" +
                                        "  PRIMARY KEY (`DETAIL_ID`) USING BTREE,\n" +
                                        "  INDEX `fk_lims_equip_inventory_lims_equip_inve_plan_1`(`INVE_ID`) USING BTREE \n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '盘点明细表' ROW_FORMAT = COMPACT;\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_process", "PRE_PROCESS")) {
                                String sql = "ALTER TABLE flow_process ADD PRE_PROCESS text COMMENT '前置办理步骤（如经过这些步骤需办结）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "score_flow_users")) {
                                String sql = "CREATE TABLE `score_flow_users` (\n" +
                                        "  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',\n" +
                                        "  `score_flow_id` int(11) NOT NULL COMMENT '关联的score_flow的id',\n" +
                                        "  `user_id` varchar(255) DEFAULT NULL COMMENT '被考核人的用户id',\n" +
                                        "  `priv_type` int(11) DEFAULT NULL COMMENT '角色层级类型（1上级 2平级 3下级）',\n" +
                                        "  `priv_weight` double DEFAULT NULL COMMENT '角色层级权重',\n" +
                                        "  `assessor` varchar(255) DEFAULT NULL COMMENT '考核人的userId',\n" +
                                        "  `assessor_weight` double DEFAULT NULL COMMENT '考核人的权重',\n" +
                                        "  `status` int(1) DEFAULT NULL COMMENT '评测状态(0未完成 1已完成)',\n" +
                                        "  `score` double DEFAULT NULL COMMENT '试卷总评分数',\n" +
                                        "  PRIMARY KEY (`id`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='被考核用户和考核人关联表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_group", "WEIGHT")) {
                                String sql = "ALTER TABLE score_group ADD  `WEIGHT` double DEFAULT NULL COMMENT '权重';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_item", "WEIGHT")) {
                                String sql = "ALTER TABLE score_item ADD  `WEIGHT` double DEFAULT NULL COMMENT '权重';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "A_LINKMAN")) {
                                String sql = "ALTER TABLE  `CONTRACT`  MODIFY COLUMN `A_LINKMAN` VARCHAR(100) COMMENT '甲方负责人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "B_LINKMAN")) {
                                String sql = "ALTER TABLE  `CONTRACT`  MODIFY COLUMN `B_LINKMAN` VARCHAR(100) COMMENT '已方负责人';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "OTHERSIDE_UNIT")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `OTHERSIDE_UNIT` char(10) COMMENT '对方单位（1甲方，2乙方）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "CONTRACT_TYPE")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `CONTRACT_TYPE` VARCHAR(200) COMMENT '合同种类（CODE_NO）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "DEPT_ID")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `DEPT_ID` int(11) COMMENT '所属部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "DATE_COMMENT")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `DATE_COMMENT` DATE COMMENT '授权日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "AUTHORIZED_REPRESENTATIVE")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `AUTHORIZED_REPRESENTATIVE` VARCHAR(100) COMMENT '授权代表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "DURATION_STARTDATE")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `DURATION_STARTDATE` DATE COMMENT '合同工期开始日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "DURATION_ENDDATE")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `DURATION_ENDDATE` DATE COMMENT '合同工期结束日期';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "EXECUTIVE_UNIT")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `EXECUTIVE_UNIT` VARCHAR(200) COMMENT '执行单位(CODE_NO)';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "CONTRACT_APPROVAL")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `CONTRACT_APPROVAL` CHAR(10)  DEFAULT '0' COMMENT '合同评审（0否；1是）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "RISK_ASSESSMENT")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `RISK_ASSESSMENT` CHAR(10) DEFAULT '0' COMMENT '风险评估（0否；1是）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "DO_ADDRESS")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `DO_ADDRESS` VARCHAR(200) COMMENT '合同履行地点';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "CONTRACT", "PAYMENT")) {
                                String sql = "ALTER TABLE  `CONTRACT`  ADD   `PAYMENT` VARCHAR(200) COMMENT '付款方式';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "CONTRACT_TYPE")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (1881, '01', '普通合同', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'CONTRACT_TYPE', '1', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "CONTRACT_TYPE")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (1882, '02', '重大合同', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'CONTRACT_TYPE', '1', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "03", "CONTRACT_TYPE")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_ID`, `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES (1883, '03', '特殊合同', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'CONTRACT_TYPE', '1', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "HTML_URL")) {
                                String sql = "ALTER TABLE institution_content ADD COLUMN `HTML_URL` varchar(255) DEFAULT NULL COMMENT 'HTMLURL';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "FLOW_ID")) {
                                String sql = "ALTER TABLE institution_content ADD COLUMN `FLOW_ID` text COMMENT '关联流程';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "USER_IDS")) {
                                String sql = "ALTER TABLE institution_content ADD COLUMN `USER_IDS` text COMMENT '我的收藏';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_no")) {
                                String sql = "CREATE TABLE `contract_no` (\n" +
                                        "  `CONTRACT_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `CONTRACT_TYPE` char(10) DEFAULT NULL COMMENT '合同类型（1-主合同,2-分包合同）',\n" +
                                        "  `CONTRACT_NAME` varchar(255) DEFAULT NULL COMMENT '合同名称',\n" +
                                        "  `CONTRACT_NO` varchar(100) DEFAULT NULL COMMENT '合同编号',\n" +
                                        "  `DO_UNIT` varchar(200) DEFAULT NULL COMMENT '承办单位(CODE_NO)',\n" +
                                        "  `NO_4` varchar(10) NOT NULL COMMENT '四位顺序号',\n" +
                                        "  `BUSINESS_TYPE` varchar(200) DEFAULT NULL COMMENT '业务分类(CODE_NO)',\n" +
                                        "  `DO2_UNIT` varchar(200) DEFAULT NULL COMMENT '分包单位2(CODE_NO)',\n" +
                                        "  `NO_3` varchar(10) DEFAULT NULL COMMENT '三位顺序号',\n" +
                                        "  `YEAR_MONTH` varchar(10) DEFAULT NULL COMMENT '年月6位',\n" +
                                        "  `USER_ID` varchar(255) DEFAULT NULL COMMENT '取号人',\n" +
                                        "  `NO_TIME` datetime DEFAULT NULL COMMENT '取号时间',\n" +
                                        "  `MAIN_CONTRACT_NO` varchar(100) DEFAULT NULL COMMENT '分包合同的主合同编号',\n" +
                                        "  PRIMARY KEY (`CONTRACT_ID`)\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='合同编号管理';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "contract_no_set")) {
                                String sql = "CREATE TABLE `contract_no_set` (\n" +
                                        "  `SET_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                        "  `NO_YEAR` varchar(10) DEFAULT NULL COMMENT '编号年份',\n" +
                                        "  `NO_CONTER` int(11) DEFAULT NULL COMMENT '编号计数器',\n" +
                                        "  `UNIT_NAME` varchar(255) DEFAULT NULL COMMENT '承办单位',\n" +
                                        "  `UNIT_CODE` varchar(200) DEFAULT NULL COMMENT '单位编号(CODE_NO)',\n" +
                                        "  `UNIT_TYPE` char(10) DEFAULT NULL COMMENT '单位类型(1-打捞局,2-承办单位)',\n" +
                                        "  `MAIN_CONTRACT_NO` varchar(100) DEFAULT NULL COMMENT '主合同编号(每个分包单位基于主合同编号各自编号)',\n" +
                                        "  PRIMARY KEY (`SET_ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='合同编号设置表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5057")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5057, '2012', '合同编号管理', '', '合同編號管理', NULL, NULL, NULL, '@', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5058")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5058, '201205', '合同取号', '', '合同取號', NULL, NULL, NULL, '/ContractNoView/ContractNumber', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5059")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5059, '201210', '编号管理', '', '編號管理', NULL, NULL, NULL, '/ContractNoView/NumberManagement', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5060")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5060, '201215', '编号设置', '', '編號設置', NULL, NULL, NULL, '/ContractNoView/identifier', '', '0', '0', '', 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "78", "SMS_REMIND")) {
                                String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ('78', '报警信息', NULL, NULL, NULL, NULL, NULL, NULL, '78', 'SMS_REMIND', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "NEWS_APPROVAL_TYPE")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('NEWS_APPROVAL_TYPE', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "PRIV1_DELETE_USER")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('PRIV1_DELETE_USER', '0');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                            }

                            if (isAppNewVersion("2020.07.01.2", dataversion)) {
                                String sql = "DROP TABLE IF EXISTS `timed_task_record`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                                sql = "CREATE TABLE `timed_task_record` (\n" +
                                        "  `TRE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务记录ID',\n" +
                                        "  `TASK_ID` int(11) NOT NULL COMMENT '定时任务ID',\n" +
                                        "  `USER_ID` varchar(255) DEFAULT NULL COMMENT '执行人ID(手动执行)',\n" +
                                        "  `EXECUTION_BEGIN_TIME` datetime NOT NULL COMMENT '执行开始时间',\n" +
                                        "  `EXECUTION_END_TIME` datetime DEFAULT NULL COMMENT '执行结束时间',\n" +
                                        "  `RESULT` char(10) NOT NULL DEFAULT '0' COMMENT '执行结果(0执行中，1执行成功，2-执行失败)',\n" +
                                        "  `RESULT_LOG` text COMMENT '执行任务详情(异常日志)',\n" +
                                        "  PRIMARY KEY (`TRE_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='定时任务执行记录表';";
                                st.executeUpdate(sql);//执行SQL语句

                                sql = "DROP TABLE IF EXISTS `timed_task_management`;";
                                st.executeUpdate(sql);//执行SQL语句

                                sql = "DROP TABLE IF EXISTS `timed_task`;" +
                                        "CREATE TABLE `timed_task` (\n" +
                                        "  `TASK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务ID',\n" +
                                        "  `TASK_NAME` varchar(100) NOT NULL COMMENT '任务名称',\n" +
                                        "  `TASK_DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',\n" +
                                        "  `TASK_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '任务类型（0-间隔执行，1-定点执行，2-自定义）',\n" +
                                        "  `SYNC_YN` char(10) NOT NULL DEFAULT '0' COMMENT '是否同步（0-同步，1-异步）',\n" +
                                        "  `STATUS` char(10) NOT NULL DEFAULT '0' COMMENT '任务状态（0-关闭，1-开启）',\n" +
                                        "  `ERR_CONTINUE_YN` char(10) NOT NULL DEFAULT '0' COMMENT '任务失败后是否继续（0-终止任务，1-继续执行）',\n" +
                                        "  `INTERVAL_TYPE` char(10) NOT NULL DEFAULT '0' COMMENT '间隔类型（间隔执行：0-分钟，1-小时）（定点执行：2-天，3-周，4-月）',\n" +
                                        "  `INTERVAL_TIME` int(3) DEFAULT '1' COMMENT '间隔时间（分钟，小时，天，周（1-7），月）',\n" +
                                        "  `EXECUTION_DATE` int(3) DEFAULT NULL COMMENT '执行日期（定点按月执行时生效 1-31）',\n" +
                                        "  `EXECUTION_TIME` time DEFAULT NULL COMMENT '执行时间（定点执行时间）',\n" +
                                        "  `CRON` varchar(255) NOT NULL COMMENT 'cron 表达式',\n" +
                                        "  `CLASS_PATH` varchar(50) NOT NULL COMMENT '任务执行类（className）',\n" +
                                        "  `METHOD_NAME` varchar(50) NOT NULL COMMENT '任务执行方法',\n" +
                                        "  `LAST_TIME` datetime DEFAULT NULL COMMENT '最后一次执行时间',\n" +
                                        "  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',\n" +
                                        "  PRIMARY KEY (`TASK_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时任务表';";
                                st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;


                                sql = "INSERT INTO `timed_task`(`TASK_ID`, `TASK_NAME`, `TASK_DESCRIPTION`, `TASK_TYPE`, `SYNC_YN`, `STATUS`, `ERR_CONTINUE_YN`, `INTERVAL_TYPE`, `INTERVAL_TIME`, `EXECUTION_DATE`, `EXECUTION_TIME`, `CRON`, `CLASS_PATH`, `METHOD_NAME`, `LAST_TIME`, `UPDATE_TIME`) VALUES (1, '备份数据库', '数据库备份', '1', '0', '0', '1', '4', 2, 10, '02:00:00', '00 00 02 10 1/2 ?', 'BakupDataBase', 'bakupDataBase', '2020-07-21 23:03:02', '2020-07-30 16:00:23');";
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "AUTHOR")) {
                                String sql = "ALTER TABLE `news` ADD COLUMN `AUTHOR` varchar(50) DEFAULT '' COMMENT '作者' AFTER `RUN_ID`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "news", "PHOTOGRAPHER")) {
                                String sql = "ALTER TABLE `news` ADD COLUMN `PHOTOGRAPHER` varchar(50) DEFAULT '' COMMENT '摄影' AFTER `AUTHOR`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation_func", "RELATION_PARENT_ID")) {
                                String sql = "ALTER TABLE `flow_relation_func` ADD COLUMN `RELATION_PARENT_ID` int(11) DEFAULT NULL COMMENT '父级ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation_func", "JSON_VALUE")) {
                                String sql = "ALTER TABLE `flow_relation_func` ADD COLUMN `JSON_VALUE` text COMMENT '应用JSON';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "flow_relation_func", "FLOW_FORM_ID")) {
                                String sql = "ALTER TABLE `flow_relation_func` ADD COLUMN `FLOW_FORM_ID` int(11) DEFAULT NULL COMMENT '表单ID';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "DEPT_ABBR_NAME")) {
                                String sql = "ALTER TABLE `department` ADD COLUMN `DEPT_ABBR_NAME` varchar(50) DEFAULT '' COMMENT '部门简称' AFTER `DEPT_NAME`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5023")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5023, '2011', '资源申请与管理', NULL, NULL, NULL, NULL, NULL, '', '', '0', '1', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5025")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5025, '201101', '资源申请与管理', NULL, NULL, NULL, NULL, NULL, 'source/manage', '', '0', '0', '', 1);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5026")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5026, '201102', '周期性资源安排', NULL, NULL, NULL, NULL, NULL, '/source/cyclemanage', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "oa_cyclesource_used")) {
                                String sql = "CREATE TABLE `oa_cyclesource_used` (\n" +
                                        "  `CYCID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                        "  `SOURCEID` int(11) NOT NULL COMMENT '资源ID',\n" +
                                        "  `B_APPLY_TIME` date NOT NULL COMMENT '开始日期',\n" +
                                        "  `E_APPLY_TIME` date NOT NULL COMMENT '结束日期',\n" +
                                        "  `WEEKDAY_SET` varchar(200) NOT NULL COMMENT '使用星期',\n" +
                                        "  `TIME_TITLE` varchar(200) NOT NULL COMMENT '使用时间段',\n" +
                                        "  `REMARK` varchar(400) NOT NULL COMMENT '备注',\n" +
                                        "  `USER_ID` varchar(45) NOT NULL COMMENT '用户USER_ID',\n" +
                                        "  `APPLY_TIME` datetime NOT NULL COMMENT '申请时间',\n" +
                                        "  PRIMARY KEY (`CYCID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='周期性资源信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "oa_source")) {
                                String sql = "CREATE TABLE `oa_source` (\n" +
                                        "  `SOURCEID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',\n" +
                                        "  `SOURCENO` int(11) NOT NULL DEFAULT '0' COMMENT '资源序号',\n" +
                                        "  `SOURCENAME` varchar(255) NOT NULL DEFAULT '' COMMENT '资源名称',\n" +
                                        "  `DAY_LIMIT` varchar(50) NOT NULL DEFAULT '' COMMENT '预约天数',\n" +
                                        "  `WEEKDAY_SET` varchar(50) NOT NULL DEFAULT '' COMMENT '星期设定',\n" +
                                        "  `TIME_TITLE` text NOT NULL COMMENT '时间段',\n" +
                                        "  `MANAGE_USER` text NOT NULL COMMENT '管理员',\n" +
                                        "  `VISIT_USER` text NOT NULL COMMENT '用户权限',\n" +
                                        "  `VISIT_PRIV` text NOT NULL COMMENT '角色权限',\n" +
                                        "  `REMARK` text NOT NULL COMMENT '备注',\n" +
                                        "  PRIMARY KEY (`SOURCEID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='资源信息表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "oa2sso")) {
                                String sql = "CREATE TABLE `oa2sso` (\n" +
                                        "  `ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `GH` varchar(100) DEFAULT NULL,\n" +
                                        "  `USER_ID` varchar(100) DEFAULT NULL,\n" +
                                        "  `USER_NAME` varchar(100) DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`ID`)\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "DATABASE_BACKUP_PATH")) {
                                String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('DATABASE_BACKUP_PATH', '');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "user_ext", "employment_type")) {
                                String sql = "ALTER TABLE `user_ext` ADD COLUMN `employment_type` varchar(10) DEFAULT NULL COMMENT '人员类型（对应sys_code表中的code_no）' AFTER `LOGIN_TIME`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_sort", "VIEW_USER_TYPE")) {
                                String sql = "ALTER TABLE `institution_sort` ADD COLUMN `VIEW_USER_TYPE` varchar(255) DEFAULT NULL COMMENT '制度文档查看人员类别（对应user_ext表中user_type）' AFTER `VIEW_USERS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_sort", "SORT_LEVEL")) {
                                String sql = "ALTER TABLE `institution_sort` ADD COLUMN `SORT_LEVEL` varchar(10) DEFAULT NULL COMMENT '制度分类级别（sys_code表中code_no)' AFTER `VIEW_USER_TYPE`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "INSTITUTION_SORT_LEVEL", "")) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('INSTITUTION_SORT_LEVEL', '制度分类级别', NULL, NULL, NULL, NULL, NULL, NULL, '61', '', '1', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "DRAFT_DEPT")) {
                                String sql = "ALTER TABLE notify ADD DRAFT_DEPT varchar(200) DEFAULT NULL COMMENT '拟稿部门';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "document_exchange_receive", "RETURN_COMMENTS")) {
                                String sql = "ALTER TABLE document_exchange_receive ADD COLUMN RETURN_COMMENTS text DEFAULT NULL COMMENT '退回意见';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "department", "DEPT_TYPE")) {
                                String sql = "ALTER TABLE `department` ADD COLUMN `DEPT_TYPE` char(10) DEFAULT '0' COMMENT '部门类型（sys_code表）' AFTER `DEPT_NAME`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (this.isAppNewVersion("2020.08.20.2", dataversion)) {
                                String sql = "update sys_function set FUNC_CODE= 'email/index' where func_id = 1;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicle/OperatorMange' where func_id = 118;\n" +
                                        "update sys_function set FUNC_CODE= 'emailPlus/index' where func_id = 2057;\n" +
                                        "update sys_function set FUNC_CODE= 'email/eamilStatis' where func_id = 3023;\n" +
                                        "update sys_function set FUNC_CODE= 'notice/allNotifications' where func_id = 4;\n" +
                                        "update sys_function set FUNC_CODE= 'news/index' where func_id = 147;\n" +
                                        "update sys_function set FUNC_CODE= 'newFilePri/personalFileCabinet' where func_id = 16;\n" +
                                        "update sys_function set FUNC_CODE= 'showFileBySort_id' where func_id = 36;\n" +
                                        "update sys_function set FUNC_CODE= 'diary/index' where func_id = 9;\n" +
                                        "update sys_function set FUNC_CODE= 'news/manage' where func_id = 105;\n" +
                                        "update sys_function set FUNC_CODE= 'notice/noticeManagement' where func_id = 24;\n" +
                                        "update sys_function set FUNC_CODE= 'newFilePub/fileCabinetHome' where func_id = 15;\n" +
                                        "update sys_function set FUNC_CODE= 'newFilePub/cabinetSet' where func_id = 36;\n" +
                                        "update sys_function set FUNC_CODE= 'flow/type/index' where func_id = 135;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/formtype/index' where func_id = 37;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/flowclassify/index' where func_id = 136;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/companyInfo' where func_id = 30;\n" +
                                        "update sys_function set FUNC_CODE= 'common/deptManagement' where func_id = 31;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/organizational' where func_id = 2001;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/work/addwork' where func_id = 130;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/work/workList' where func_id = 5;\n" +
                                        "update sys_function set FUNC_CODE= 'common/userManagement' where func_id = 33;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/statusBar' where func_id = 178;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/interfaceSettings' where func_id = 78;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/sysInfo' where func_id = 38;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/menuSetting' where func_id = 104;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/journal' where func_id = 99;\n" +
                                        "update sys_function set FUNC_CODE= 'common/systemCode' where func_id = 121;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/unitInfor' where func_id = 17;\n" +
                                        "update sys_function set FUNC_CODE= 'department/deptQuery' where func_id = 18;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/userInfor' where func_id = 19;\n" +
                                        "update sys_function set FUNC_CODE= 'schedule/index' where func_id = 8;\n" +
                                        "update sys_function set FUNC_CODE= 'roleAuthorization' where func_id = 32;\n" +
                                        "update sys_function set FUNC_CODE= 'netdiskSettings/netdisksetting' where func_id = 77;\n" +
                                        "update sys_function set FUNC_CODE= 'controlpanel/index' where func_id = 11;\n" +
                                        "update sys_function set FUNC_CODE= '/workflow/work/automaticNumbering' where func_id = 2002;\n" +
                                        "update sys_function set FUNC_CODE= '/workflow/work/businessApplications' where func_id = 2003;\n" +
                                        "update sys_function set FUNC_CODE= 'netdiskSettings/networkHardDisk' where func_id = 76;\n" +
                                        "update sys_function set FUNC_CODE= 'schedule/query' where func_id = 80;\n" +
                                        "update sys_function set FUNC_CODE= 'deleteDatePage' where func_id = 2004;\n" +
                                        "update sys_function set FUNC_CODE= '/attendPage/myAttendance' where func_id = 7;\n" +
                                        "update sys_function set FUNC_CODE= 'hr/page/hrindex' where func_id = 60;\n" +
                                        "update sys_function set FUNC_CODE= 'hr/page/contractIndex' where func_id = 481;\n" +
                                        "update sys_function set FUNC_CODE= '/document/draftArticlesOfCommunication' where func_id = 3002;\n" +
                                        "update sys_function set FUNC_CODE= '/document/makeADraft' where func_id = 3003;\n" +
                                        "update sys_function set FUNC_CODE= '/document/IthasBeenDone' where func_id = 3004;\n" +
                                        "update sys_function set FUNC_CODE= '/document/ISentAMessage' where func_id = 3005;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/MeetingApply' where func_id = 86;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/selectMeeting' where func_id = 87;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/selectMyMeeting' where func_id = 2006;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/selectMeetingMinutes' where func_id = 138;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/selectMeetingMange' where func_id = 88;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/MeetingDeviceMange' where func_id = 222;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/MeetingRoom' where func_id = 89;\n" +
                                        "update sys_function set FUNC_CODE= '/MeetingCommon/MeetingMange' where func_id = 137;\n" +
                                        "update sys_function set FUNC_CODE= 'SupervCommon/MySupervision' where func_id = 3017;\n" +
                                        "update sys_function set FUNC_CODE= 'SupervCommon/SupervisionManage' where func_id = 3018;\n" +
                                        "update sys_function set FUNC_CODE= 'SupervCommon/SupervisionType' where func_id = 3019;\n" +
                                        "update sys_function set FUNC_CODE= 'SupervCommon/Supervisionstatistic' where func_id = 3020;\n" +
                                        "update sys_function set FUNC_CODE= 'document/addresseeRegistrationForm' where func_id = 3007;\n" +
                                        "update sys_function set FUNC_CODE= 'document/inAbeyance' where func_id = 3008;\n" +
                                        "update sys_function set FUNC_CODE= 'document/received' where func_id = 3009;\n" +
                                        "update sys_function set FUNC_CODE= 'document/myInReply' where func_id = 3010;\n" +
                                        "update sys_function set FUNC_CODE= 'document/theOfficialDocumentQuery' where func_id = 3011;\n" +
                                        "update sys_function set FUNC_CODE= 'document/theOfficialStatistics' where func_id = 3012;\n" +
                                        "update sys_function set FUNC_CODE= 'document/documentsSupervisor' where func_id = 3013;\n" +
                                        "update sys_function set FUNC_CODE= 'sms/index' where func_id = 2005;\n" +
                                        "update sys_function set FUNC_CODE= 'document/officialDocumentSet' where func_id = 3015;\n" +
                                        "update sys_function set FUNC_CODE= 'attendPage/backlogAttendLeave' where func_id = 506;\n" +
                                        "update sys_function set FUNC_CODE= 'attendPage/attendance' where func_id = 508;\n" +
                                        "update sys_function set FUNC_CODE= 'sys/secureIndex' where func_id = 626;\n" +
                                        "update sys_function set FUNC_CODE= 'flowRunPage/queryFlowRun' where func_id = 131;\n" +
                                        "update sys_function set FUNC_CODE= 'document/SealIndex' where func_id = 3016;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/work/workDelegate' where func_id = 182;\n" +
                                        "update sys_function set FUNC_CODE= 'hierarchical/common/setting' where func_id = 2008;\n" +
                                        "update sys_function set FUNC_CODE= 'hierarchical/common/deptManager' where func_id = 2009;\n" +
                                        "update sys_function set FUNC_CODE= 'hierarchical/common/userManager' where func_id = 2010;\n" +
                                        "update sys_function set FUNC_CODE= 'timeLineConmon/timeLineEvent' where func_id = 2014;\n" +
                                        "update sys_function set FUNC_CODE= 'timeLineConmon/eventManage' where func_id = 2015;\n" +
                                        "update sys_function set FUNC_CODE= 'eduFixAssets/index' where func_id = 2041;\n" +
                                        "update sys_function set FUNC_CODE= 'eduTrainPlan/goIndex' where func_id = 504;\n" +
                                        "update sys_function set FUNC_CODE= 'eduTrainPlan/assessIndex' where func_id = 505;\n" +
                                        "update sys_function set FUNC_CODE= 'workPlan/workPlanQueryIndex' where func_id = 2033;\n" +
                                        "update sys_function set FUNC_CODE= 'workPlan/index' where func_id = 2032;\n" +
                                        "update sys_function set FUNC_CODE= 'workPlan/workPlanTypeSetting' where func_id = 2034;\n" +
                                        "update sys_function set FUNC_CODE= 'record/trainRecord' where func_id = 503;\n" +
                                        "update sys_function set FUNC_CODE= 'vote/manage/vote' where func_id = 119;\n" +
                                        "update sys_function set FUNC_CODE= 'vote/manage/voteIndex' where func_id = 148;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicle/veHicleIndex' where func_id = 96;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicle/veHicleUseageIndex' where func_id = 91;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicleUsage/index' where func_id = 92;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicle/vehicleDeptApproveIndex' where func_id = 95;\n" +
                                        "update sys_function set FUNC_CODE= 'tenance/index' where func_id = 94;\n" +
                                        "update sys_function set FUNC_CODE= 'veHicle/operatorIndex' where func_id = 93;\n" +
                                        "update sys_function set FUNC_CODE= 'address/index' where func_id = 10;\n" +
                                        "update sys_function set FUNC_CODE= 'officeDepository/goDepositoryindex' where func_id = 238;\n" +
                                        "update sys_function set FUNC_CODE= 'leaderschedule/leaderActivity' where func_id = 2025;\n" +
                                        "update sys_function set FUNC_CODE= 'leaderschedule/query' where func_id = 2026;\n" +
                                        "update sys_function set FUNC_CODE= 'Notes/index' where func_id = 2011;\n" +
                                        "update sys_function set FUNC_CODE= 'officeDepository/goDepositoryindex' where func_id = 238;\n" +
                                        "update sys_function set FUNC_CODE= 'officetransHistory/productRelease' where func_id = 539;\n" +
                                        "update sys_function set FUNC_CODE= 'officetransHistory/approvalIndex' where func_id = 607;\n" +
                                        "update sys_function set FUNC_CODE= 'officetransHistory/stockIndex' where func_id = 128;\n" +
                                        "update sys_function set FUNC_CODE= 'officetransHistory/OfficeProductApplyIndex' where func_id = 179;\n" +
                                        "update sys_function set FUNC_CODE= 'officeSupplies/goInfomationHome' where func_id = 127;\n" +
                                        "update sys_function set FUNC_CODE= 'eduSchoolBusiness/eduSchoolIndex' where func_id = 2035;\n" +
                                        "update sys_function set FUNC_CODE= 'eduSchoolBusiness/noticeIndex' where func_id = 12;\n" +
                                        "update sys_function set FUNC_CODE= 'notice/notificAtion' where func_id = 197;\n" +
                                        "update sys_function set FUNC_CODE= 'notice/appprove' where func_id = 196;\n" +
                                        "update sys_function set FUNC_CODE= 'smsSettings/index' where func_id = 2042;\n" +
                                        "update sys_function set FUNC_CODE= 'timedTaskJob/imedTaskManagement' where func_id = 3021;\n" +
                                        "update sys_function set FUNC_CODE= 'workflow/work/workMonitoring' where func_id = 3022;\n" +
                                        "update sys_function set FUNC_CODE= 'spirit/webChatRecord' where func_id = 2044;\n" +
                                        "update sys_function set FUNC_CODE= 'footprint/index' where func_id = 2043;\n" +
                                        "update sys_function set FUNC_CODE= 'rmsRoll/index' where func_id = 3026;\n" +
                                        "update sys_function set FUNC_CODE= 'rmsFile/index' where func_id = 3027;\n" +
                                        "update sys_function set FUNC_CODE= 'rmsFile/toDestroyed' where func_id = 3028;\n" +
                                        "update sys_function set FUNC_CODE= '/salary/lclb' where func_id = 2045;\n" +
                                        "update sys_function set FUNC_CODE= '/sys/getPostmanagement' where func_id = 3029;\n" +
                                        "update sys_function set FUNC_CODE= '/duties/dutiesjsp' where func_id = 3030;\n" +
                                        "update sys_function set FUNC_CODE= '/schoolRoll/schoolQuery' where func_id = 5007;\n" +
                                        "update sys_function set FUNC_CODE= '/schoolRoll/index' where func_id = 5008;\n" +
                                        "update sys_function set FUNC_CODE= '/schoolRoll/mange' where func_id = 5009;\n" +
                                        "update sys_function set FUNC_CODE= '/teachering/teacherQuery' where func_id = 5010;\n" +
                                        "update sys_function set FUNC_CODE= '/teachering/index' where func_id = 5011;\n" +
                                        "update sys_function set FUNC_CODE= '/teachering/teacherSeting' where func_id = 5012;\n" +
                                        "update sys_function set FUNC_CODE= 'sysTasks/sysTaskIndex' where func_id = 113;\n" +
                                        "update sys_function set FUNC_CODE= '/censor/wordFiltering' where func_id = 2054;\n" +
                                        "update sys_function set FUNC_CODE= '/Hr/Incentive/bonpenManagement' where func_id = 482;\n" +
                                        "update sys_function set FUNC_CODE= '/learningExperience/navigationBar' where func_id = 484;\n" +
                                        "update sys_function set FUNC_CODE= 'dutyManagement/pageJumpDutyManagement' where func_id = 2068;\n" +
                                        "update sys_function set FUNC_CODE= '/workflow/work/DiaryIndex' where func_id = 536;\n" +
                                        "update sys_function set FUNC_CODE= '/workflow/work/workDestruction' where func_id = 183;\n" +
                                        "update sys_function set FUNC_CODE= 'hr/manage/staff_labor_skills' where func_id = 486;\n" +
                                        "update sys_function set FUNC_CODE= 'common/hrSystemCode' where func_id = 513;\n" +
                                        "update sys_function set FUNC_CODE= 'infomation/goAddInfomation' where func_id = 2069;\n" +
                                        "update sys_function set FUNC_CODE= 'infomation/HandleIndex' where func_id = 2059;\n" +
                                        "update sys_function set FUNC_CODE= 'infomation/submitQuery' where func_id = 2070;\n" +
                                        "update sys_function set FUNC_CODE= 'infomation/statisticsIndex' where func_id = 2060;\n" +
                                        "update sys_function set FUNC_CODE= 'reportSettings/index' where func_id = 254;\n" +
                                        "update sys_function set FUNC_CODE= '/workflow/work/flowReportMain' where func_id = 256;\n" +
                                        "update sys_function set MENU_ID= '301810' where func_id = 305;\n" +
                                        "update sys_function set MENU_ID= '301815' where func_id = 306;\n" +
                                        "update sys_function set MENU_ID= '301820' where func_id = 307;\n" +
                                        "update sys_function set MENU_ID= '301825' where func_id = 308;\n" +
                                        "update sys_function set MENU_ID= '601009' where func_id = 139;\n" +
                                        "update sys_function set MENU_ID= '7505' where func_id = 2201;\n" +
                                        "update sys_function set MENU_ID= '7510' where func_id = 2202;\n" +
                                        "update sys_function set MENU_ID= '7515' where func_id = 2203;\n" +
                                        "update sys_function set MENU_ID= '7520' where func_id = 2204;\n" +
                                        "update sys_function set MENU_ID= '7530' where func_id = 2205;\n" +
                                        "update sys_function set MENU_ID= '7535' where func_id = 2206;\n" +
                                        "update sys_function set MENU_ID= '760505',FUNC_NAME= '销售出货',FUNC_CODE='/salesShipment/index'  where func_id = 2219;\n" +
                                        "update sys_function set MENU_ID= '760510',FUNC_NAME= '销售退货',FUNC_CODE='/salesReturn/index' where func_id = 2220;\n" +
                                        "update sys_function set MENU_ID= '7610',FUNC_NAME= '采购单' ,FUNC_CODE='@' where func_id = 2221;\n" +
                                        "update sys_function set MENU_ID= '761005',FUNC_NAME= '采购进货',FUNC_CODE='/poCommodityEnter/purchaSestock' where func_id = 2222;\n" +
                                        "update sys_function set MENU_ID= '761010',FUNC_NAME= '采购出货',FUNC_CODE='/poCommodityEnter/purchaseOut' where func_id = 2223;\n" +
                                        "update sys_function set MENU_ID= '7615',FUNC_NAME= '收款单',FUNC_CODE='/invWarehouse/collReceipt' where func_id = 2224;\n" +
                                        "update sys_function set MENU_ID= '7620',FUNC_NAME= '付款单',FUNC_CODE='/invWarehouse/fuReceipt' where func_id = 2225;\n" +
                                        "update sys_function set MENU_ID= '7625',FUNC_NAME= '商品库存',FUNC_CODE='/invWarehouse/commodityInventory' where func_id = 2226;\n" +
                                        "update sys_function set MENU_ID= '7630',FUNC_NAME= '仓库管理' ,FUNC_CODE='/invWarehouse/index' where func_id = 2227;\n" +
                                        "update sys_function set MENU_ID= '7635',FUNC_NAME= '销售统计',FUNC_CODE='/invWarehouse/salesStatistics' where func_id = 2228;\n" +
                                        "update sys_function set MENU_ID= '7640',FUNC_NAME= '利润统计',FUNC_CODE='@' where func_id = 2229;\n" +
                                        "update sys_function set FUNC_NAME= '值班安排' where func_id = 2082;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "VIEW_DEPTS")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `VIEW_DEPTS` text COMMENT '制度文件查看部门' AFTER `USER_IDS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "VIEW_PRIVS")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `VIEW_PRIVS` text COMMENT '制度文件查看角色' AFTER `VIEW_DEPTS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "VIEW_USERS")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `VIEW_USERS` text COMMENT '制度文件查看人员' AFTER `VIEW_PRIVS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "VIEW_USER_TYPE")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `VIEW_USER_TYPE` text COMMENT '制度文档查看人员类别' AFTER `VIEW_USERS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "BELONGTO_DEPTS")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `BELONGTO_DEPTS` varchar(50) DEFAULT NULL COMMENT '所属部门' AFTER `VIEW_USER_TYPE`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_content", "BELONGTO_UNIT")) {
                                String sql = "ALTER TABLE `institution_content` ADD COLUMN `BELONGTO_UNIT` varchar(50) DEFAULT NULL COMMENT '所属单位' AFTER `BELONGTO_DEPTS`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "institution_sort", "VIEW_SCOPE")) {
                                String sql = "ALTER TABLE `institution_sort` ADD COLUMN `VIEW_SCOPE` varchar(10) DEFAULT NULL COMMENT '分类可见范围（sys_code表中code_no)' AFTER `SORT_LEVEL`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "meeting", "SERVICE_USER")) {
                                String sql = "ALTER TABLE meeting ADD COLUMN SERVICE_USER text COMMENT '会议服务人员';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "notify", "USER_TYPE")) {
                                String sql = " ALTER TABLE notify ADD COLUMN USER_TYPE varchar(255) DEFAULT NULL COMMENT '人员类型（用于区分正式员工等）';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "DEPT_TYPE", "")) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('DEPT_TYPE', '部门类型', NULL, NULL, NULL, NULL, NULL, NULL, '62', '', '0', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "INSTITUTION_SORT_SEE", "")) {
                                String sql = "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('INSTITUTION_SORT_SEE', '制度分类可见范围', NULL, NULL, NULL, NULL, NULL, NULL, '62', '', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ( '01', '公司总部', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'INSTITUTION_SORT_SEE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ( '02', '区域总部', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'INSTITUTION_SORT_SEE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ( '03', '总承包部', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'INSTITUTION_SORT_SEE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ( '04', '指定部门', NULL, NULL, NULL, NULL, NULL, NULL, '04', 'INSTITUTION_SORT_SEE', '1', '', '1', '1', '1');\n" +
                                        "INSERT INTO `sys_code`(`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_IPHONE`, `IS_REMIND`) VALUES ('05', '全体部门', NULL, NULL, NULL, NULL, NULL, NULL, '05', 'INSTITUTION_SORT_SEE', '1', '', '1', '1', '1');\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (!Verification.CheckIsExistWidget(conn, driver, url, username, password, "12")) {
                                String sql = "INSERT INTO `widget`(`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES (12, '计划填报', 0, 1, 'PlanExecution', '1', '1', 12);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }


                            if (this.isAppNewVersion("2020.08.20.2", dataversion)) {
                                PlcSql.PlcSql(oid);
                                PartyBulidingSql.PartyBulidingSql(oid);
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "plc_project_info", "BUDGET")) {
                                String sql = "ALTER TABLE plc_project_info ADD COLUMN BUDGET text COMMENT '概算预算';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "guide_goal")) {
                                String sql = "CREATE TABLE `guide_goal`  (\n" +
                                        "  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',\n" +
                                        "  `sup_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '督办名称',\n" +
                                        "  `type_id` int(11) DEFAULT NULL COMMENT '督办类型ID',\n" +
                                        "  `leader_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '责任领导人ID',\n" +
                                        "  `manager_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '主办人ID',\n" +
                                        "  `end_time` datetime(0) DEFAULT NULL COMMENT '结束时间',\n" +
                                        "  `begin_time` datetime(0) DEFAULT NULL COMMENT '开始时间',\n" +
                                        "  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '督办内容',\n" +
                                        "  `creater_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人ID',\n" +
                                        "  `creater_time` datetime(0) DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `status` int(11) DEFAULT NULL COMMENT '督办状态（0-未发布1-代签收2-正常办理中3-逾期办理中4-已暂停5-正常已办结6-逾期已办结）',\n" +
                                        "  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID',\n" +
                                        "  `real_end_time` datetime(0) DEFAULT NULL COMMENT '截止时间',\n" +
                                        "  `dept_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '部门ID',\n" +
                                        "  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '用户ID',\n" +
                                        "  `role_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '角色ID',\n" +
                                        "  `attment_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '附件信息',\n" +
                                        "  `attment_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '附件名称',\n" +
                                        "  `assist_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`sid`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方针目标';\n" +
                                        "\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "guide_goal_back")) {
                                String sql = "CREATE TABLE `guide_goal_back`  (\n" +
                                        "  `sid` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `level_` int(11) DEFAULT NULL,\n" +
                                        "  `sup_id` int(11) DEFAULT NULL,\n" +
                                        "  `creater_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `create_time` datetime(0) DEFAULT NULL,\n" +
                                        "  `ATTACHMENT_ID` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `ATTACHMENT_NAME` varchar(225) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`sid`) USING BTREE\n" +
                                        ") ENGINE = InnoDB  CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方针目标反馈';" +
                                        "\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "guide_goal_back_reply")) {
                                String sql = "CREATE TABLE `guide_goal_back_reply`  (\n" +
                                        "  `sid` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                        "  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `fb_id` int(11) DEFAULT NULL,\n" +
                                        "  `create_time` datetime(0) DEFAULT NULL,\n" +
                                        "  `creater_id` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,\n" +
                                        "  `sup_id` int(11) DEFAULT NULL,\n" +
                                        "  PRIMARY KEY (`sid`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方针目标回复';\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "guide_goal_manage")) {
                                String sql = "CREATE TABLE `guide_goal_manage`  (\n" +
                                        "  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',\n" +
                                        "  `status` int(11) DEFAULT NULL COMMENT '申请状态（0-不同意 1-同意）',\n" +
                                        "  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '督办内容',\n" +
                                        "  `type` int(11) DEFAULT NULL COMMENT '督办类型\\r\\n1-暂停 2-办理 3-办结 4-催办',\n" +
                                        "  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',\n" +
                                        "  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '原因',\n" +
                                        "  `creater_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '创建人ID',\n" +
                                        "  `sup_id` int(11) DEFAULT NULL COMMENT '督办ID',\n" +
                                        "  PRIMARY KEY (`sid`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方针目标管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "guide_goal_type")) {
                                String sql = "CREATE TABLE `guide_goal_type`  (\n" +
                                        "  `sid` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增',\n" +
                                        "  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '分类名称',\n" +
                                        "  `order_num` int(11) DEFAULT NULL COMMENT '排序号',\n" +
                                        "  `parent_id` int(11) DEFAULT NULL COMMENT '父级ID',\n" +
                                        "  `user_id` text CHARACTER SET utf8 COLLATE utf8_general_ci,\n" +
                                        "  PRIMARY KEY (`sid`) USING BTREE\n" +
                                        ") ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '方针目标分类';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "crm_certificate")) {
                                String sql = "CREATE TABLE `crm_certificate` (\n" +
                                        "  `CERT_ID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                        "  `CONTACT_PERSON` varchar(100) DEFAULT NULL COMMENT '联系人（手机）',\n" +
                                        "  `PHONE` varchar(100) DEFAULT NULL COMMENT '联系电话（座机）',\n" +
                                        "  `EMAIL` varchar(100) DEFAULT NULL COMMENT '电子邮箱',\n" +
                                        "  `PROFESSION` varchar(100) DEFAULT NULL COMMENT '相关专业',\n" +
                                        "  `PROVINCE` char(10) DEFAULT NULL COMMENT '所在地区（省），最后一个省可以是海外，值从01-99',\n" +
                                        "  `CITY` char(10) DEFAULT NULL COMMENT '所在地区（市），值从01-99，与省份关联',\n" +
                                        "  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '地址详情',\n" +
                                        "  `LAW_NAME` varchar(100) DEFAULT NULL COMMENT '法人',\n" +
                                        "  `CONTRACT_NO` text COMMENT '合同编号',\n" +
                                        "  `ATTACHMENT_ID` text COMMENT '附件Id(证件照)',\n" +
                                        "  `ATTACHMENT_NAME` text COMMENT '附件名称(证件照)',\n" +
                                        "  `CERT_NO` text COMMENT '证件照编号',\n" +
                                        "  `CERT_NUMBER` text COMMENT '证件号码',\n" +
                                        "  `CERT_NAME` text COMMENT '证件照名称',\n" +
                                        "  `CERT_START_TIME` datetime DEFAULT NULL COMMENT '证件照起始时间',\n" +
                                        "  `CERT_END_TIME` datetime DEFAULT NULL COMMENT '证件照截止时间',\n" +
                                        "  `REMARK` text COMMENT '备注',\n" +
                                        "  `REMIND_TIME` datetime DEFAULT NULL COMMENT '提醒时间（可以提前一个月提醒）',\n" +
                                        "  `SUPPLIER_USER` varchar(100) DEFAULT NULL COMMENT '供应商userId',\n" +
                                        "  `CREATE_TIME` datetime DEFAULT NULL COMMENT '成立时间',\n" +
                                        "  PRIMARY KEY (`CERT_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='资格证书管理';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (Verification.CheckIsExistCode(conn, driver, url, username, password, "BUSINESS_TYPE_CODE", "")) {
                                String sql = "delete from sys_code where CODE_NO='BUSINESS_TYPE_CODE' and CODE_NAME ='业务分类编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "BUSINESS_TYPE_CODE", "")) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( 'BUSINESS_TYPE_CODE', '业务分类编号', NULL, NULL, NULL, NULL, NULL, NULL, '1892', '', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "BUSINESS_TYPE_CODE", "1892")) {
                                String sql = "UPDATE `sys_code` SET `CODE_ORDER` = '1892' ,`PARENT_NO` = '' WHERE `CODE_NO` = 'BUSINESS_TYPE_CODE' and CODE_NAME ='业务分类编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistCode(conn, driver, url, username, password, "CONTRACT_UNIT", "")) {
                                String sql = "delete from sys_code where CODE_NO='CONTRACT_UNIT' and CODE_NAME ='承办单位编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "CONTRACT_UNIT", "")) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( 'CONTRACT_UNIT', '承办单位编号', NULL, NULL, NULL, NULL, NULL, NULL, '1891', '', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "CONTRACT_UNIT", "1891")) {
                                String sql = "UPDATE `sys_code` SET `CODE_ORDER` = '1891' ,`PARENT_NO` = '' WHERE `CODE_NO` = 'CONTRACT_UNIT' and CODE_NAME ='承办单位编号';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistCode(conn, driver, url, username, password, "CONTRACT_TYPE", "")) {
                                String sql = "INSERT INTO `sys_code`( `CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`, `IS_CAN`, `IS_REMIND`, `IS_IPHONE`) VALUES ( 'CONTRACT_TYPE', '合同种类', NULL, NULL, NULL, NULL, NULL, NULL, '90', '', '0', '', '1', '1', '1');";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "exa_questions", "eq_subject")) {
                                String sql = "alter table exa_questions MODIFY `eq_subject` text NOT NULL COMMENT '问题';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "hr_evaluate_priv")) {
                                String sql = "CREATE TABLE `hr_evaluate_priv` (\n" +
                                        "  `PRIV_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',\n" +
                                        "  `VIEW_OR_EVALUATE_USERS` text COMMENT '查看或评价人',\n" +
                                        "  `PRIV_USERS` text COMMENT '被查看或被评价人',\n" +
                                        "  `PRIV_TYPE` varchar(10) DEFAULT NULL COMMENT '类型（1-查看权限，2-评价权限）',\n" +
                                        "  PRIMARY KEY (`PRIV_ID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='评价权限设置表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "496")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (496, '501305', '评价权限设置', NULL, NULL, NULL, NULL, NULL, '/HrEvaluatePriv/index', '', '0', '0', ' ', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "2287")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (2287, '2017', '领导日程', ' ', ' ', NULL, NULL, NULL, '/schedule/leadership', ' ', NULL, NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5061")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5061, '2095', '方针目标管理', NULL, NULL, NULL, NULL, NULL, '@', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5062")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5062, '209505', '方针目标任务', NULL, NULL, NULL, NULL, NULL, 'guideGoal/MyGuideGoal', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5063")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5063, '209510', '方针目标管理', NULL, NULL, NULL, NULL, NULL, 'guideGoal/guideGoalManage', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5064")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5064, '209515', '方针目标分类', NULL, NULL, NULL, NULL, NULL, 'guideGoal/guideGoalType', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5065")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5065, '209520', '方针目标统计', NULL, NULL, NULL, NULL, NULL, 'guideGoal/guideGoalStatistic', '', '0', NULL, NULL, 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (Verification.CheckIsExistfield(conn, driver, url, username, password, "email_set", "ESS_ID")) {
                                String sql = " ALTER TABLE `email_set` MODIFY COLUMN `ESS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮件审核设置ID' FIRST;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5052")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5052, '2090', '图书管理', NULL, NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5053")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5053, '209001', '图书管理信息', NULL, NULL, NULL, NULL, NULL, '/bookInfo/index', '', '0', NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5054")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5054, '209002', '图书查询', NULL, NULL, NULL, NULL, NULL, '/bookManage/index', '', '0', NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5055")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5055, '209003', '借还书管理', NULL, NULL, NULL, NULL, NULL, '/bookManager/index', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "5056")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (5056, '209004', '图书管理设置', NULL, NULL, NULL, NULL, NULL, '/bookType/index', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "537")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (537, '109070', '关联应用设置', NULL, NULL, NULL, NULL, NULL, '/relationFunc/index', '', NULL, NULL, NULL, 0);\n";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistFunction(conn, driver, url, username, password, "310")) {
                                String sql = "INSERT INTO `sys_function`(`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`, `SEND_USER`, `SEND_KEY`, `IS_SHOW_FUNC`) VALUES (310, '301805', '制度中心', NULL, NULL, NULL, NULL, NULL, '/document/Institutional', '', '0', '0', '', 0);";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_users", "ASSESSMENT_ROLE")) {
                                String sql = "ALTER TABLE `score_flow_users` ADD COLUMN `ASSESSMENT_ROLE` text COMMENT '考核角色' AFTER `score`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistfield(conn, driver, url, username, password, "score_flow_users", "SUBMISSION_TIME")) {
                                String sql = "ALTER TABLE `score_flow_users` ADD COLUMN `SUBMISSION_TIME` datetime(0) DEFAULT NULL COMMENT '考核提交时间' AFTER `ASSESSMENT_ROLE`;";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }




                            boolean app_connect_user = Verification.CheckIsExistTable(conn, driver, url, username, password, "app_connect_user");
                            if (app_connect_user == false) {
                                String sql = "CREATE TABLE `app_connect_user` (\n" +
                                        "  `AUID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                        "  `AID` int(11) NOT NULL COMMENT '应用id',\n" +
                                        "  `APP_USER` varchar(255) DEFAULT NULL COMMENT '应用用户名',\n" +
                                        "  `USER_ID` varchar(50) DEFAULT NULL COMMENT 'OA用户名',\n" +
                                        "  PRIMARY KEY (`AUID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户映射表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句
                            }

                            if (!Verification.CheckIsExistTable(conn, driver, url, username, password, "app_connect")) {
                                String sql = "CREATE TABLE `app_connect` (\n" +
                                        "  `AID` int(11) NOT NULL AUTO_INCREMENT COMMENT '第三方应用ID',\n" +
                                        "  `APP_ID` varchar(255) NOT NULL COMMENT '应用内部ID',\n" +
                                        "  `APP_NAME` varchar(255) DEFAULT NULL COMMENT '应用名字',\n" +
                                        "  `ACCESS_TOKEN` varchar(255) NOT NULL COMMENT '调用接口凭证',\n" +
                                        "  `IP1` char(50) DEFAULT NULL COMMENT 'IP段1',\n" +
                                        "  `IP2` char(50) DEFAULT NULL COMMENT 'IP段2',\n" +
                                        "  `APP_DESC` text COMMENT '应用描述',\n" +
                                        "  PRIMARY KEY (`AID`) USING BTREE\n" +
                                        ") ENGINE=InnoDB  DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='第三方应用表';";
                                Statement st = conn.createStatement();
                                st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                            }

                        }

                        if (!Verification.CheckIsExistSysPara(conn, driver, url, username, password, "MYPROJECT")) {
                            String sql = "INSERT INTO `sys_para`(`PARA_NAME`, `PARA_VALUE`) VALUES ('MYPROJECT', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1
                        }

                        //执行新的升级脚本sql
                        ExecSqlFile execSqlFile = new ExecSqlFile();
                        Boolean updateFlag = execSqlFile.execSqlFileByMysql(oid, dataversion, webVersion);
                        // 判断升级脚本是否执行成功
                        if(updateFlag){
                            //执行公共的更新sql 包含移动版和pc端的版本号
                            execPublic(conn,driver,url,username,password);

                            //最后修改一下数据库版本号
                            String sql = "UPDATE version SET VER='" + SystemInfoServiceImpl.softVersion + "';";
                            Statement st = conn.createStatement();
                            int res = st.executeUpdate(sql);//执行SQL语句
                        } else {
                            if(conn!=null){
                                conn.close();
                            }

                            json.setFlag(1);
                            json.setMsg("升级失败，sql存在错误");
                            return json;
                        }

//                        Version version = new Version();
//                        version.setVer(SystemInfoServiceImpl.softVersion);
//                        int res = versionMapper.editVer(version);
                            //释放资源
                        if(conn!=null){
                            conn.close();
                        }


                    }
                }
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("updateResourceLog:" + e);
        }finally {
            try{
                if(conn!=null){
                    conn.close();
                }
            }catch (Exception e){

            }

        }
        return json;
    }

    @Override
    public void downLog(HttpServletResponse response, HttpServletRequest request) {
        try {
            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
            File file = new File(webappRoot + "jdbc.txt");
            String urltd_oa = new String();
            String unametd_oa = new String();
            String passwordtd_oa = new String();
            //判断文件是否存在
            if (file.isFile() && file.exists()) {

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i = 1;
                while ((lineTxt = bufferedReader.readLine()) != null) {
                    if (i == 1) {
                        urltd_oa = lineTxt;
                    } else if (i == 2) {
                        unametd_oa = lineTxt;
                    } else {
                        passwordtd_oa = lineTxt;
                    }
                    i++;
                }
                read.close();
            }
            int i = 1;
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = urltd_oa;
            String driver = props.getProperty("driverClassName");
            String username = unametd_oa;
            String password = passwordtd_oa;
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            Statement st = conn.createStatement();
            String sql_2 = "select * from str_status where STATE =1";
            ResultSet rs = st.executeQuery(sql_2);//执行SQL语句
            List<Strstatus> strstatus = new ArrayList<Strstatus>();
            Object object1 = new Object();
            Object object2 = new Object();
            while (rs.next()) {
                Strstatus strstatus1 = new Strstatus();
                object2 = rs.getObject(4);
                strstatus1.setId(i);
                strstatus1.setStringSql(object2.toString());
                strstatus.add(strstatus1);
                i++;
            }
            HSSFWorkbook workbook1 = ExcelUtil.makeExcelHead("异常sql语句", 9);
            String[] secondTitles = {"序号", "异常语句"};
            HSSFWorkbook workbook2 = ExcelUtil.makeSecondHead(workbook1, secondTitles);
            String[] beanProperty = {"id", "stringSql"};
            HSSFWorkbook workbook = null;
            workbook = ExcelUtil.exportExcelData(workbook2, strstatus, beanProperty);
            OutputStream out = response.getOutputStream();
            String filename = "异常sql语句.xls";
            filename = FileUtils.encodeDownloadFilename(filename, request.getHeader("user-agent"));
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("content-disposition", "attachment;filename=" + filename);
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public ToJson<SysCode> getCodeRemind(HttpServletRequest request) {
        ToJson<SysCode> toJson = new ToJson<>();
        try {
            List<SysCode> list = sysCodeMapper.getCodeRemind();
            if (list != null && list.size() > 0) {
                toJson.setObj(list);
                toJson.setMsg("事务提醒菜单查询成功");
                toJson.setFlag(0);
            }

        } catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg("事务提醒菜单查询失败");
            toJson.setFlag(1);
        }
        return toJson;
    }

    @Override
    public ToJson<SysCode> editServerVersion(HttpServletRequest request, String pcVersion, String AndroidVersion, String iosVersion) {
        ToJson<SysCode> toJson = new ToJson<>(1, "error");
        Map<String, String> versionMap = new HashMap();
        if (!StringUtils.checkNull(pcVersion))
            versionMap.put("APP_PC_Version", pcVersion);

        if (!StringUtils.checkNull(AndroidVersion))
            versionMap.put("APP_Android_Version", AndroidVersion);

        if (!StringUtils.checkNull(iosVersion))
            versionMap.put("APP_IOS_Version", iosVersion);

        if (versionMap.size() > 0) {
            sysCodeMapper.editServerVersion(versionMap);
            toJson.setMsg("ok");
            toJson.setFlag(0);
        }
        return toJson;
    }

    public static final String UpdatesoftVersion = "2020.06.01.1";


    @Override
    public ToJson GetLeaderBox(SysCode sysCode) {
        ToJson toJson = new ToJson(1, "false");
        Map<String, Object> map = new HashMap<>();
        if (!StringUtils.checkNull(sysCode.getCodeName())) {
            map.put("codeName", sysCode.getCodeName());
        }
        if (!StringUtils.checkNull(sysCode.getParentNo())) {
            map.put("parentNo", sysCode.getParentNo());
        }
        try {
            List<SysCode> leaderBox = sysCodeMapper.getLeaderBox(map);
            if (!leaderBox.equals(0)) {
                toJson.setObj(leaderBox);
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            toJson.setFlag(1);
        }
        return toJson;
    }
      //模糊查询
    @Override
    public ToJson<SysCode> searchLike(String codeName) {
        ToJson<SysCode> json = new ToJson<>(1, "error");
        try {
            List<SysCode> sysCodes = sysCodeMapper.selectLike(codeName);
            /*for (int i = sysCodes.size()-1; i>=0; i--) {
                if(!StringUtils.checkNull(sysCodes.get(i).getParentNo())){
                    sysCodes.remove(i);
                }
            }*/
            if (sysCodes.size()>0) {
                json.setObj(sysCodes);
                json.setMsg("ok");
                json.setFlag(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.setFlag(1);
        }
        return json;
    }

    @Override
    public ToJson getCodeValue(String parentNo) {
        ToJson toJson = new ToJson();
        List<SysCode> sysCodeList =  sysCodeMapper.getcodebyparentNo(parentNo);
        toJson.setObject(sysCodeList);
        toJson.setFlag(0);
        return toJson;
    }

    @Override
    public ToJson<SysCode> getContentSecrecy(HttpServletRequest request, String parentNo,String codeName) {
        ToJson<SysCode> codeJson = new ToJson<SysCode>();
        try {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            List<String> list = securityContentApprovalService.securityRestrictionByUser(request,user);
            Map<String,Object> map = new HashMap<>();
            map.put("parentNo",parentNo);
            map.put("codeName",codeName);
            List<SysCode> code = sysCodeMapper.getCodesByMap(map);
            code = code.stream().filter(item -> list.contains(item.getCodeNo())).collect(Collectors.toList());

            if (!CollectionUtils.isEmpty(code)) {
                for (SysCode sysCode : code) {
                    if (locale.equals("zh_CN")) {
                        sysCode.setCodeName(sysCode.getCodeName());
                    } else if (locale.equals("en_US")) {
                        sysCode.setCodeName(sysCode.getCodeName1());
                    } else if (locale.equals("zh_TW")) {
                        sysCode.setCodeName(sysCode.getCodeName2());
                    }
                }
            }

            codeJson.setObj(code);
            codeJson.setFlag(0);
            codeJson.setMsg("ok");
        } catch (Exception e) {
            codeJson.setFlag(1);
            codeJson.setMsg("err");
        }
        return codeJson;
    }

    public void execPublic(Connection conn,String driver,String url,String username,String password)throws Exception{

        /**
         *  添加字段的作用: 更新PC端版本号
         */
        boolean isExistPara_2 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_PC_Version");
        if (isExistPara_2 == true) {
            String sql = "DELETE FROM sys_para where PARA_NAME = 'APP_PC_Version';";
            Statement st = conn.createStatement();
            st.executeUpdate(sql);//执行SQL语句
            sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('APP_PC_Version', '2023.05.25.1');";
            st.executeUpdate(sql);
        }
        /**
         *  添加字段的作用: 更新Android端版本号
         */
        boolean isExistPara_3 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_Android_Version");
        if (isExistPara_3 == true) {
            if (!Verification.CheckIsExistSysParaAndNotNull(conn, driver, url, username, password, "MYPROJECT")) {
                String sql = "UPDATE `sys_para` SET `PARA_NAME`='APP_Android_Version', `PARA_VALUE`='2023.06.01.1' WHERE (`PARA_NAME`='APP_Android_Version');";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

        }
        /**
         *  添加字段的作用: 更新IOS端版本号
         */
        boolean isExistPara_4 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_IOS_Version");
        if (isExistPara_4 == true) {
            if (!Verification.CheckIsExistSysParaAndNotNull(conn, driver, url, username, password, "MYPROJECT")) {
                String sql = "UPDATE `sys_para` SET `PARA_NAME`='APP_IOS_Version', `PARA_VALUE`='2023.05.18' WHERE (`PARA_NAME`='APP_IOS_Version');";
                Statement st = conn.createStatement();
                st.executeUpdate(sql);//执行SQL语句
            }

        }

    }
}
