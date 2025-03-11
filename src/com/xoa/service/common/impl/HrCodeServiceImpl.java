package com.xoa.service.common.impl;


import com.ibatis.common.jdbc.ScriptRunner;
import com.ibatis.common.resources.Resources;
import com.xoa.dao.common.HrCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.strstatus.StrstatusMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.dao.version.VersionMapper;
import com.xoa.model.common.HrCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.strstatus.Strstatus;
import com.xoa.model.users.OrgManage;
import com.xoa.model.version.Version;
import com.xoa.service.common.HrCodeService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.users.OrgManageService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DBPropertiesUtils;
import com.xoa.util.ExcelUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.log.FileUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.Verification;
import net.sf.json.JSONObject;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.*;

/**
 *
 * 创建作者:   张丽军
 * 创建日期:   2018/7/23.
 * 类介绍  :
 * 构造参数:   无
 *
 */
@Service
public class HrCodeServiceImpl implements HrCodeService{

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
     * @参数说明: @param HrCode
     * @参数说明: @param oldCodeNo 未修改时的oid
     * @return: boolean  true表示已经存在，false表示可以使用
     */
    @Override
    @Transactional
    public ToJson editisCodeNoExits(HrCode hrCode, String oldCodeNo) {
        ToJson toJson = new ToJson(1, "error");
        try {
            List<HrCode> hrCodesList;

            //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
            if (hrCode != null && ("".equals(hrCode.getParentNo()) || hrCode.getParentNo() == null)) {
                hrCodesList = hrCodeMapper.isSysCodeNoExits(hrCode);
            } else {
                if (hrCode != null) {
                    if (hrCode.getParentNo().equals("NOTIFY")) {
                        String singleNewsArr = sysParaMapper.selectNotifySingleNew();
                        if (singleNewsArr.contains(oldCodeNo + "-")) {
                            int oldPos = singleNewsArr.indexOf(oldCodeNo + "-");
                            String headStr = singleNewsArr.substring(0, oldPos);
                            String bodyStr = singleNewsArr.substring(oldPos, singleNewsArr.length());
                            int bodyStartPos = bodyStr.indexOf(",");
                            String tailStr = bodyStr.substring(bodyStartPos + 1, bodyStr.length());
                            singleNewsArr = headStr.concat(tailStr);
                        }
                        String newSysPara = singleNewsArr.concat(hrCode.getCodeNo() + "-0,");
                        SysPara sysPara = new SysPara();
                        sysPara.setParaName("NOTIFY_AUDITING_SINGLE_NEW");
                        sysPara.setParaValue(newSysPara);
                        sysParaMapper.updateSysPara(sysPara);
                    }
                }
                hrCodesList = hrCodeMapper.isChildCodeNoExits(hrCode);
            }

            if (hrCodesList != null && hrCodesList.size() == 1) {
                if (oldCodeNo != null) {

                    String dbCodeNo = hrCodesList.get(0).getCodeNo();

                    if (oldCodeNo.equals(dbCodeNo)) {
                        toJson.setFlag(1);
                        toJson.setMsg("ok");
                        return toJson;
                    }

                }
            }

            if (hrCodesList != null && hrCodesList.size() >= 1) {
                toJson.setFlag(0);
                toJson.setMsg("ok");
            }
        } catch (Exception e) {
            toJson.setFlag(1);
            toJson.setMsg("err");
            L.e("HrCodeServiceImpleditisCodeNoExits：" + e);
        }

        //该CODE_NO号已经被用了

        return toJson;
    }

    @Resource
    private HrCodeMapper hrCodeMapper;
    @Resource
    private OrgManageMapper orgManageMapper;

    /**
     * 创建作者:   王曰岐
     * 创建日期:   2017-5-2 下午2:40:40
     * 方法介绍:   根据代码主分类查找信息
     * 参数说明:   @param parentNo
     * 参数说明:   @return
     *
     * @return HrCode
     */
    @Override
    public ToJson<HrCode> getSysCode(String parentNo) {
        ToJson<HrCode> codeJson = new ToJson<HrCode>();
        try{
            List<HrCode> code = hrCodeMapper.getSysCode(parentNo);
            codeJson.setObj(code);
            codeJson.setFlag(0);
            codeJson.setMsg("ok");
        }catch (Exception e){
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
     * @return List<HrCode>
     */
    @Override
    public List<HrCode> getAllSysCode() {
        List<HrCode> list = hrCodeMapper.getAllSysCode();
        return list;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月4日 上午10:06:41
     * 方法介绍:   更新系统代码设置表
     * 参数说明:   @param HrCode 系统代码设置表
     *
     * @return void 无
     */
    @Override
    public void update(HrCode hrCode) {


     /*   Boolean codeNoExits = isCodeNoExits(HrCode);
        Boolean codeOrderExits = isCodeOrderExits(HrCode);
        if (!codeNoExits && !codeOrderExits) {*/
/*
          if(HrCode.getParentNo()==""){
               if(!isCodeNoExits(HrCode)){
                   hrCodeMapper.update(HrCode);
               }
           }
           else{
               if(!ChildisCodeNoExits(HrCode)){
                   hrCodeMapper.update(HrCode);
               }
           }*/
        hrCodeMapper.update(hrCode);
    }


    //}

    @Override
    public List<HrCode> getLogType() {
        String[] type = {"登录日志", "登录密码错误", "退出系统"};
        List<HrCode> hrCodeList = hrCodeMapper.getLogType("PARENT_NO");
        Iterator<HrCode> it = hrCodeList.iterator();
        while (it.hasNext()) {
            HrCode hrCode = it.next();
            if (Arrays.asList(type).contains(hrCode.getCodeName())) {
                continue;
            }
            it.remove();
        }


        return hrCodeList;
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
        String logTypeName = hrCodeMapper.getLogNameByNo(codeNo);

        return logTypeName;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 13:25
     * @函数介绍: 删除日志
     * @参数说明: @param HrCode HrCode
     * @return: void
     */
    @Override
    public void deleteSysCode(HrCode hrCode) {
        //判断一下是不是主代码
        String codeByCodeId = hrCodeMapper.getCodeByCodeId(hrCode.getCodeId());
        //主代码parent_No为“”
        if ("".equals(codeByCodeId)) {
            hrCodeMapper.delete(hrCode);
        } else {
            hrCodeMapper.deleteChild(hrCode);
        }
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 13:41
     * @函数介绍: 增加代码主分类
     * @参数说明: @param HrCode
     * @return: void
     */
    @Override
    public void addSysMainCode(HrCode hrCode) {

      /*  //HrCode的ext属性不为空
        if (HrCode != null && !codeNoExits) {
            //这个多语言字段不用，数据库不能为空，所以赋值为“”*/
        hrCode.setCodeExt("");
        hrCodeMapper.addSysMainCode(hrCode);


    }

    /**
     * @param hrCode
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:16
     * @函数介绍: 判断系统代码排序是否存在
     * @参数说明: @param HrCode
     * @return: Boolean
     */
    @Override
    public Boolean isCodeOrderExits(HrCode hrCode) {
        List<HrCode> hrCodesList;
        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (hrCode != null && ("".equals(hrCode.getParentNo()) || hrCode.getParentNo() == null)) {
            hrCodesList = hrCodeMapper.isSysCodeNoExits(hrCode);
        } else {
            hrCodesList = hrCodeMapper.isChildCodeOrderExits(hrCode);

        }

        //该排序号已经被用了
        if (hrCodesList != null && hrCodesList.size() > 0) {
            return true;

        }
        return false;
    }


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:31
     * @函数介绍: 判断系统代码CODE_NO是否存在
     * @参数说明: @param HrCode
     * @return: boolean
     */
    @Override
    public Boolean isCodeNoExits(HrCode hrCode) {
        List<HrCode> hrCodesList;

        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (hrCode != null && ("".equals(hrCode.getParentNo()) || hrCode.getParentNo() == null)) {
            hrCodesList = hrCodeMapper.isSysCodeNoExits(hrCode);
          /*  if (HrCodesList != null && HrCodesList.size() == 1) {
                if (HrCodesList.get(0).getParentNo() != null &&
                        !HrCodesList.get(0).getParentNo().equals(HrCode.getCodeNo())) {
                    return true;
                } else {
                    return false;
                }
            }*/

        } else {
            hrCodesList = hrCodeMapper.isChildCodeNoExits(hrCode);

        }
        //该CODE_NO号已经被用了
        if (hrCodesList != null && hrCodesList.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/27 20:36
     * @函数介绍: 判断系统代码更新时CODE_NO是否存在
     * @参数说明: @param HrCode
     * @return: boolean
     */
    @Override
    public Boolean iseditCodeNoExits(HrCode hrCode) {
        List<HrCode> hrCodesList;

        //一级二级分开考虑,因为二级的两个字段都重复才重复，一级有一个字段重复就重复
        if (hrCode != null && ("".equals(hrCode.getParentNo()) || hrCode.getParentNo() == null)) {
            hrCodesList = hrCodeMapper.iseditSysCodeNoExits(hrCode);
            if (hrCodesList != null && hrCodesList.size() == 1) {
                if (hrCodesList.get(0).getParentNo() != null &&
                        !hrCodesList.get(0).getParentNo().equals(hrCode.getCodeNo())) {
                    return true;
                } else {
                    return false;
                }
            }

        } else {
            hrCodesList = hrCodeMapper.isChildCodeNoExits(hrCode);

        }
        //该CODE_NO号已经被用了
        if (hrCodesList != null && hrCodesList.size() > 0) {
            return true;
        }
        return false;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 11:09
     * @函数介绍: 判断系统子代码CODE_NO是否存在
     * @参数说明: @param HrCode
     * @return: boolean
     */
    @Override
    public Boolean ChildisCodeNoExits(HrCode hrCode) {
        boolean flag;
        List<HrCode> childCodeNoExits = hrCodeMapper.isChildCodeNoExits(hrCode);
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
     * @参数说明: @param HrCode
     * @return: void
     */
    @Override
    public void addChildSysCode(HrCode hrCode) {


        Boolean codeNoExits = isCodeNoExits(hrCode);
        Boolean codeOrderExits = isCodeOrderExits(hrCode);
        if (hrCode != null) {
            if (hrCode.getParentNo().equals("NOTIFY")) {
                String singleNewsArr = sysParaMapper.selectNotifySingleNew();
                String newSysPara = singleNewsArr.concat(hrCode.getCodeNo() + "-0,");
                SysPara sysPara = new SysPara();
                sysPara.setParaName("NOTIFY_AUDITING_SINGLE_NEW");
                sysPara.setParaValue(newSysPara);
                sysParaMapper.updateSysPara(sysPara);
            }
        }
        //HrCode的ext属性不为空
        if (hrCode != null && hrCode.getParentNo() != null && !codeNoExits && !codeOrderExits) {
            //这个多语言字段不用，数据库不能为空，所以赋值为“”
            hrCode.setCodeExt("");
            hrCode.setCodeFlag("1");
            hrCodeMapper.addSysChildCode(hrCode);
        }
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/3 14:45
     * @函数介绍: 查询子代码
     * @参数说明: @param HrCode
     * @return: List<HrCode></HrCode>
     */
    @Override
    public List<HrCode> getChildSysCode(HrCode hrCode) {

        if (hrCode != null && hrCode.getParentNo() != null) {
            return hrCodeMapper.getSysCode(hrCode.getParentNo());
        }

        return null;
    }

    /**
     * @创建作者: 高亚峰
     * @创建日期: 2017/6/20 14:45
     * @函数介绍: 查询系统编码相同的对象
     * @参数说明: @param HrCode
     * @return: List<HrCode></HrCode>
     **/

    @Override
    public HrCode getCodeByCodeNo(HrCode hrCode) {
        return hrCodeMapper.getCodeByCodeNo(hrCode);
    }

    @Override
    public ToJson<List<HrCode>> getErrSysCode() {
        //声明一个空list存放正确的系统代码 主类和子类
        List<HrCode> list = new ArrayList<HrCode>();
        //声明一个空的list来存放错误代码
        List<HrCode> errlist = new ArrayList<HrCode>();
        ToJson<List<HrCode>> json = new ToJson<List<HrCode>>();

        try {
            //查询出所有的主代码
            List<HrCode> mainCode = hrCodeMapper.getMainCode();
            //遍历主代码得到子代码
            for (HrCode hrCode : mainCode) {
                list.add(hrCode);
                List<HrCode> childCode = hrCodeMapper.getChildCode(hrCode.getCodeNo());
                //遍历子代码
                for (HrCode hrCode1 : childCode) {
                    list.add(hrCode1);
                }
            }

            StringBuffer sb = new StringBuffer();
            //得到数据库所有代码
            List<HrCode> allCode = hrCodeMapper.getAllCode();
            for (HrCode hrCode : list) {
                Integer codeId = hrCode.getCodeId();
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
    public ToJson<HrCode> getErrInfo(String CodeId) {
        ToJson<HrCode> json = new ToJson<HrCode>();
        try {
            if (CodeId != null) {
                HrCode codeByCodeId = hrCodeMapper.getCodeByCodeIds(Integer.valueOf(CodeId));
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
    public ToJson<HrCode> deleteErrCode(String CodeId) {
        ToJson<HrCode> json = new ToJson<HrCode>();
        if (CodeId != null) {
            try {
                hrCodeMapper.deleteErrCode(Integer.valueOf(CodeId));
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
    public ToJson<List<HrCode>> getAllCode() {
        ToJson<List<HrCode>> json = new ToJson<List<HrCode>>();
        List<HrCode> list = new ArrayList<HrCode>();
        try {
            //查询出所有的主代码
            List<HrCode> mainCode = hrCodeMapper.getMainCode();
            //遍历主代码得到子代码
            for (HrCode HrCode : mainCode) {
                list.add(HrCode);
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
    public JSONObject DropDownBoxs(String[] CodeId) {
        JSONObject jsonObject = null;
        List<HrCode> list = new ArrayList<HrCode>();
        Map<String, Object> map = new HashMap<String, Object>();
        ;
        try {
            for (String s : CodeId) {
                List<HrCode> hrCode = hrCodeMapper.getSysCode(s);
                map.put(s, hrCode);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        jsonObject = JSONObject.fromObject(map);
        return jsonObject;
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
    public ToJson<Object> editDabase(HttpServletRequest request,HttpServletResponse response) {
        ToJson<Object> json = new ToJson<Object>(1, "err");
        String classpath = this.getClass().getResource("/").getPath();
        String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/update/");
        StringBuffer stringBuffer =new StringBuffer();
        String urltd_oa=new String();
        String unametd_oa=new String();
        String passwordtd_oa=new String();
        String proRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
        try {
            File file1 = new File(proRoot+"jdbc.txt");
            //判断文件是否存在
            if(file1.isFile() && file1.exists()){

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file1));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i=1;
                while((lineTxt = bufferedReader.readLine()) != null){
                    if(i==1){
                        urltd_oa=lineTxt;
                    }
                    else if(i==2){
                        unametd_oa=lineTxt;
                    }else{
                        passwordtd_oa=lineTxt;
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
            File file1 = new File(webappRoot+"jdbc.txt");
            String urltd_oa=new String();
            String unametd_oa=new String();
            String passwordtd_oa=new String();
            //判断文件是否存在
            if(file1.isFile() && file1.exists()){

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file1));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i=1;
                while((lineTxt = bufferedReader.readLine()) != null){
                    if(i==1){
                        urltd_oa=lineTxt;
                    }
                    else if(i==2){
                        unametd_oa=lineTxt;
                    }else{
                        passwordtd_oa=lineTxt;
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
            File file = new File(webappRoot+"jdbc.txt");
            String urltd_oa=new String();
            String unametd_oa=new String();
            String passwordtd_oa=new String();
            //判断文件是否存在
            if(file.isFile() && file.exists()){

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i=1;
                while((lineTxt = bufferedReader.readLine()) != null){
                    if(i==1){
                        urltd_oa=lineTxt;
                    }
                    else if(i==2){
                        unametd_oa=lineTxt;
                    }else{
                        passwordtd_oa=lineTxt;
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
        if(dataVersion.equals("8.15.160722")){
            flag=false;
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
        try {
            String webVersion = SystemInfoServiceImpl.softVersion;
            //数据库中的版本
            String dataversion = versionMapper.selectVer();
            boolean flag = this.isAppNewVersion(webVersion, dataversion);
            //如果为true，则说明需要更新
            if (flag == true) {
                //遍历数据库
                ToJson<OrgManage> zh_cn = orgManageService.queryId("zh_CN");
                List<OrgManage> obj = zh_cn.getObj();
                int size = obj.size();
                for (int i = 0; i < size; i++) {
                    //只做第一个数据库
                    if (i < 1) {
                        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
                        String url = props.getProperty("url" + obj.get(i).getOid());
                        String driver = props.getProperty("driverClassName");
                        String username = props.getProperty("uname" + obj.get(i).getOid());
                        String password = props.getProperty("password" + obj.get(i).getOid());
                        Class.forName(driver).newInstance();
                        Connection conn = (Connection) DriverManager.getConnection(url, username, password);

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
                        /**
                         *  添加字段的作用: 更新PC端版本号
                         */
                        boolean isExistPara_2 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_PC_Version");
                        if (isExistPara_2 == true) {
                            String sql = "DELETE FROM sys_para where PARA_NAME = 'APP_PC_Version';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                            sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('APP_PC_Version', '2018.07.17.1');";
                            st.executeUpdate(sql);
                        }
                        /**
                         *  添加字段的作用: 更新Android端版本号
                         */
                        boolean isExistPara_3 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_Android_Version");
                        if (isExistPara_3 == true) {
                            String sql = "UPDATE `sys_para` SET `PARA_NAME`='APP_Android_Version', `PARA_VALUE`='2018.07.17.1' WHERE (`PARA_NAME`='APP_Android_Version');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句

                        }
                        /**
                         *  添加字段的作用: 更新IOS端版本号
                         */
                        boolean isExistPara_4 = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "APP_IOS_Version");
                        if (isExistPara_4 == true) {
                            String sql = "UPDATE `sys_para` SET `PARA_NAME`='APP_IOS_Version', `PARA_VALUE`='2018.07.17.1' WHERE (`PARA_NAME`='APP_IOS_Version');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句

                        }
                        /**
                         *  添加字段的作用: 创建office_transhistory表
                         */
                        boolean isExistTable_1=Verification.CheckIsExistTable(conn, driver, url, username, password,"office_transhistory");
                        if(isExistTable_1==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `office_transhistory` (\n" +
                                    "  `TRANS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `PRO_ID` int(11) DEFAULT '0' COMMENT '办公用品ID',\n" +
                                    "  `BORROWER` varchar(20) DEFAULT NULL COMMENT '申请人',\n" +
                                    "  `TRANS_FLAG` varchar(20) DEFAULT '' COMMENT '登记类型',\n" +
                                    "  `TRANS_QTY` int(11) DEFAULT '0' COMMENT '申请时的数量',\n" +
                                    "  `PRICE` decimal(10,2) DEFAULT '0.00' COMMENT '物品价格',\n" +
                                    "  `REMARK` text COMMENT '备注',\n" +
                                    "  `TRANS_DATE` date DEFAULT '0000-00-00' COMMENT '申请时间',\n" +
                                    "  `OPERATOR` varchar(20) DEFAULT '' COMMENT '操作员',\n" +
                                    "  `TRANS_STATE` varchar(20) DEFAULT '' COMMENT '申请的状态标志(01-待部门审批人审批,02-待库管理员审批,1-同意,21-部门审批驳回，22-库管员驳回)',\n" +
                                    "  `FACT_QTY` int(11) DEFAULT '0' COMMENT '实际的申请数量',\n" +
                                    "  `REASON` text COMMENT '不同意理由',\n" +
                                    "  `COMPANY` varchar(20) DEFAULT NULL COMMENT '厂家',\n" +
                                    "  `BAND` varchar(20) DEFAULT NULL COMMENT '品牌',\n" +
                                    "  `CYCLE_NO` int(11) DEFAULT '0' COMMENT '批量申请的ID',\n" +
                                    "  `CYCLE` char(1) DEFAULT NULL COMMENT '批量申请标记',\n" +
                                    "  `DEPT_ID` int(11) DEFAULT NULL COMMENT '部门ID',\n" +
                                    "  `PRO_KEEPER` varchar(20) DEFAULT NULL COMMENT '物品调度员',\n" +
                                    "  `GRANTOR` varchar(20) DEFAULT NULL COMMENT '发放物品的操作员',\n" +
                                    "  `GRANT_STATUS` char(1) DEFAULT '0' COMMENT '物品发放处理状态(0-未处理,1-已处理)',\n" +
                                    "  `DEPT_MANAGER` varchar(200) DEFAULT NULL COMMENT '部门审批人',\n" +
                                    "  `DEPT_STATUS` int(1) DEFAULT '1' COMMENT '部门审批状态标志',\n" +
                                    "  `RETURN_STATUS` int(1) DEFAULT '0' COMMENT '归还状态',\n" +
                                    "  `RETURN_DATE` date DEFAULT '0000-00-00' COMMENT '归还时间',\n" +
                                    "  `RETURN_REASON` text COMMENT '归还不同意理由',\n" +
                                    "  PRIMARY KEY (`TRANS_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='物品登记申请记录表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                  /*  *
                     *  添加字段的作用: 创建office_depository表
                     */
                        boolean isExistTable_2=Verification.CheckIsExistTable(conn, driver, url, username, password,"office_depository");
                        if(isExistTable_2==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `office_depository`(\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `DEPOSITORY_NAME` varchar(200) DEFAULT NULL COMMENT '库名称',\n" +
                                    "  `OFFICE_TYPE_ID` text COMMENT '物品类表ID',\n" +
                                    "  `DEPT_ID` text COMMENT '所属部门',\n" +
                                    "  `MANAGER` text COMMENT '仓库管理员',\n" +
                                    "  `PRO_KEEPER` text COMMENT '物品调度员',\n" +
                                    "  `PRIV_ID` varchar(50) DEFAULT NULL,\n" +
                                    "  `RETURN_STATUS` int(1) DEFAULT '0' COMMENT '归还状态',\n" +
                                    "  `RETURN_DATE` date DEFAULT '0000-00-00' COMMENT '归还时间',\n" +
                                    "  `RETURN_REASON` text COMMENT '归还不同意理由',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='物品库表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                 /*   *
                     *  添加字段的作用: 创建office_products表
                     */
                        boolean isExistTable_3=Verification.CheckIsExistTable(conn, driver, url, username, password,"office_products");
                        if(isExistTable_3==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `office_products`(\n" +
                                    "  `PRO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `PRO_NAME` varchar(200) DEFAULT '' COMMENT '办公用品名称',\n" +
                                    "  `PRO_DESC` text COMMENT '办公用品描述',\n" +
                                    "  `OFFICE_PROTYPE` varchar(20) DEFAULT '' COMMENT '物品所属类别ID',\n" +
                                    "  `PRO_CODE` varchar(20) DEFAULT '' COMMENT '办公用品编码',\n" +
                                    "  `PRO_UNIT` varchar(20) DEFAULT '' COMMENT '计量单位',\n" +
                                    "  `PRO_PRICE` decimal(10,2) DEFAULT '0.00' COMMENT '单价',\n" +
                                    "  `PRO_SUPPLIER` text COMMENT '供应商',\n" +
                                    "  `PRO_LOWSTOCK` int(11) DEFAULT '0' COMMENT '最低警戒库存',\n" +
                                    "  `PRO_MAXSTOCK` int(11) DEFAULT '0' COMMENT '最高警戒库存',\n" +
                                    "  `PRO_STOCK` int(11) DEFAULT '0' COMMENT '当前库存',\n" +
                                    "  `PRO_DEPT` text COMMENT '登记权限部门',\n" +
                                    "  `PRO_MANAGER` text COMMENT '登记权限用户',\n" +
                                    "  `PRO_CREATOR` varchar(20) DEFAULT '' COMMENT '创建人',\n" +
                                    "  `PRO_AUDITER` text COMMENT '审批权限用户',\n" +
                                    "  `PRO_ORDER` varchar(2) DEFAULT NULL COMMENT '排序号',\n" +
                                    "  `ATTACHMENT_ID` text COMMENT '附件ID串',\n" +
                                    "  `ATTACHMENT_NAME` text COMMENT '附件名称串',\n" +
                                    "  `OFFICE_PRODUCT_TYPE` int(11) DEFAULT '2' COMMENT '办公用品类型(1-领用, 2-借用)',\n" +
                                    "  `ALLOCATION` tinyint(1) DEFAULT '0' COMMENT '调拨属性',\n" +
                                    "  PRIMARY KEY (`PRO_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='物品信息表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                /*    *
                     *  添加字段的作用: 创建office_type表
                     */
                        boolean isExistTable_4=Verification.CheckIsExistTable(conn, driver, url, username, password,"office_type");
                        if(isExistTable_4==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `office_type` (\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `TYPE_NAME` varchar(200) DEFAULT '' COMMENT '类别名称',\n" +
                                    "  `TYPE_ORDER` varchar(200) DEFAULT '' COMMENT '排序号',\n" +
                                    "  `TYPE_PARENT_ID` int(10) unsigned DEFAULT '0' COMMENT '父类型ID',\n" +
                                    "  `TYPE_DEPOSITORY` int(10) unsigned DEFAULT '1' COMMENT '所属库的库ID',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='物品类别表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                /*    *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "126");
                        if(isExistFunction_1==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('126', '6060', '办公用品', 'Office Supplies', '辦公用品', NULL, NULL, NULL, '@officeSupplies', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "179");
                        if(isExistFunction_2==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('179', '606001', '办公用品申领', 'Office supplies', '辦公用品申領', NULL, NULL, NULL, 'officetransHistory/OfficeProductApplyIndex', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "607");
                        if(isExistFunction_3==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('607', '606002', '办公用品审批', 'Office supplies approval', '辦公用品審批', NULL, NULL, NULL, 'officetransHistory/approvalIndex', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "539");
                        if(isExistFunction_4==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('539', '606003', '办公用品发放', 'Office supplies', '辦公用品發放', NULL, NULL, NULL, 'officetransHistory/productRelease', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "238");
                        if(isExistFunction_5==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('238', '606006', '办公用品库管理', 'Office supplies library management', '辦公用品庫管理', NULL, NULL, NULL, 'officeDepository/index', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_6 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "128");
                        if(isExistFunction_6==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('128', '606007', '办公用品库存管理', 'Office supplies inventory management', '辦公用品庫存管理', NULL, NULL, NULL, 'officetransHistory/stockIndex', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "131");
                        if(isExistFunction_7==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`) VALUES ('131', '1030', '工作查询', 'Job query', '工作査詢', NULL, NULL, NULL, 'workflow/query', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield = Verification.CheckIsExistfield(conn, driver, url, username, password, "unit", "UNIT_ID");
                        if(checkIsExistfield==false){
                            String sql="alter table unit add column UNIT_ID  int not null auto_increment primary key comment '主键' first;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 修改表类型
                     */
                        boolean checkIsExistTable = Verification.CheckIsExistTable(conn, driver, url, username, password, "flow_form_type");
                        if(checkIsExistTable==true){
                            String sql="alter table flow_form_type convert to character set utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        } //添加字段

               /*     *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sys_function", "ISOPEN_NEW");
                        if(checkIsExistfield_2==false){
                            String sql="ALTER TABLE sys_function add ISOPEN_NEW varchar(10) null;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "57");
                        if(isExistFunction_8==false){
                            String sql="INSERT INTO `sys_function` VALUES ('57', 'z008', '行政办公设置', 'Administrative office setting', '行政辦公設定', null, null, null, '@system', '', null);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_9 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "196");
                        if(isExistFunction_9==false){
                            String sql="INSERT INTO `sys_function` VALUES ('196', '2008', '公告通知审批', 'Approval of notice', '公告通知審批', null, null, null, 'notify/auditing', '', null);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
              /*      *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_10 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "197");
                        if(isExistFunction_10==false){
                            String sql="INSERT INTO `sys_function` VALUES ('197', 'z00830', '公告通知设置', 'Setting of notice', '公告通知設定', null, null, null, 'system/notify', '', null);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "POST");
                        if(checkIsExistfield_1==false){
                            String sql="alter table `user` add POST varchar(255) comment'岗位';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "AVATAR_128");
                        if(checkIsExistfield_3==false){
                            String sql="alter table `user` add AVATAR_128 varchar(255) comment'128头像';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_4 = Verification.CheckIsExistfield(conn, driver, url, username, password, "email", "withdraw_flag");
                        if(checkIsExistfield_4==false){
                            String sql="alter table `email` add withdraw_flag  varchar(1) default 0 comment'撤回状态（0-未撤回，1-撤回)';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_5 = Verification.CheckIsExistfield(conn, driver, url, username, password, "sms_body", "IS_ATTACH");
                        if(checkIsExistfield_5==false){
                            String sql="alter table `sms_body` add IS_ATTACH varchar(255) comment'附件标识';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加字段
                     */
                        boolean checkIsExistfield_6 = Verification.CheckIsExistfield(conn, driver, url, username, password, "im_message", "REAL_URL");
                        if(checkIsExistfield_6==false){
                            String sql="alter table `im_message` add REAL_URL varchar(255) comment'真实路径';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_11 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2043");
                        if(isExistFunction_11==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2043', '5010', '足迹查询', 'Footprint query', '足迹査詢', NULL, NULL, NULL, 'footprint/index', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_12 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2044");
                        if(isExistFunction_12==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2044', '0139', '消息历史记录', 'Chat record', '消息歷史記錄', NULL, NULL, NULL, 'spirit/webChatRecord', '', NULL);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 创建im_chatlist表
                     */
                        boolean isExistTable_5=Verification.CheckIsExistTable(conn, driver, url, username, password,"im_chatlist");
                        if(isExistTable_5==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `im_chatlist` (\n" +
                                    "  `LIST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '云办公用户UID',\n" +
                                    "  `FROM_UID` varchar(255) DEFAULT NULL COMMENT '云办公发消息人UID',\n" +
                                    "  `TO_UID` varchar(255) DEFAULT NULL COMMENT '云办公接收消息人UID',\n" +
                                    "  `OF_FROM` varchar(255) DEFAULT NULL COMMENT 'OF发消息人UID',\n" +
                                    "  `OF_TO` varchar(255) DEFAULT NULL COMMENT 'OF收消息人UID',\n" +
                                    "  `LAST_TIME` varchar(255) DEFAULT NULL COMMENT '最后消息时间',\n" +
                                    "  `LAST_ATIME` varchar(255) DEFAULT NULL COMMENT '入库时间',\n" +
                                    "  `LAST_CONTENT` text COMMENT '最后消息内容',\n" +
                                    "  `LAST_FILE_ID` varchar(255) DEFAULT NULL,\n" +
                                    "  `LAST_FILE_NAME` varchar(255) DEFAULT NULL,\n" +
                                    "  `LAST_THUMBNAIL_URL` varchar(255) DEFAULT NULL,\n" +
                                    "  `TYPE` varchar(255) DEFAULT NULL,\n" +
                                    "  `MSG_TYPE` char(1) DEFAULT '1' COMMENT '会话类型（0单聊，1群聊）',\n" +
                                    "  `UID_IGNORE` varchar(255) DEFAULT NULL COMMENT '会话列表忽略标记',\n" +
                                    "  `UUID` varchar(255) DEFAULT NULL,\n" +
                                    "  `msg_free` varchar(255) DEFAULT NULL,\n" +
                                    "  PRIMARY KEY (`LIST_ID`),\n" +
                                    "  KEY `LAST_TIME` (`LAST_TIME`),\n" +
                                    "  KEY `FROM_UID` (`FROM_UID`),\n" +
                                    "  KEY `TO_UID` (`TO_UID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8 COMMENT='会话列表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean isExistFunction_13 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3023");
                        if(isExistFunction_13==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3023', '2001', '邮件统计', 'Mail statistics', '\\r\\n邮件统计\\r\\n郵件統計', NULL, NULL, NULL, 'email/eamilStatis', '', NULL);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 添加字段
                     */
                        boolean isExistfield = Verification.CheckIsExistfield(conn, driver, url, username, password, "interface", "ATTACHMENT_ID3");
                        if(isExistfield==false){
                            String sql="alter table `interface` add ATTACHMENT_ID3 text comment'app界面附件';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 添加字段
                     */
                        boolean isExistfield_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "interface", "ATTACHMENT_NAME3");
                        if(isExistfield_1==false){
                            String sql="alter table `interface` add ATTACHMENT_NAME3 text comment'app界面附件';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 添加字段
                     */
                        boolean isExistfield_2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "interface", "ATTACHMENT_ID4");
                        if(isExistfield_2==false){
                            String sql="alter table `interface` add ATTACHMENT_ID4 text comment'apps首页附件';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加字段
                     */
                        boolean isExistfield_3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "interface", "ATTACHMENT_NAME4");
                        if(isExistfield_3==false){
                            String sql="alter table `interface` add ATTACHMENT_NAME4 text comment'apps首页附件';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2005");
                        if(checkIsExistFunction==true){
                            String sql="update sys_function set MENU_ID ='0138' where FUNC_ID=2005;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2031");
                        if(checkIsExistFunction_1==true){
                            String sql="update sys_function set MENU_ID ='2030' where FUNC_ID=2031;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2032");
                        if(checkIsExistFunction_2==true){
                            String sql="update sys_function set MENU_ID ='203001' where FUNC_ID=2032;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2033");
                        if(checkIsExistFunction_3==true){
                            String sql="update sys_function set MENU_ID ='203002' where FUNC_ID=2033;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2034");
                        if(checkIsExistFunction_4==true){
                            String sql="update sys_function set MENU_ID ='203003' where FUNC_ID=2034;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2024");
                        if(checkIsExistFunction_5==true){
                            String sql="update sys_function set MENU_ID ='2020' where FUNC_ID=2024;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_6 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2025");
                        if(checkIsExistFunction_6==true){
                            String sql="update sys_function set MENU_ID ='202001' where FUNC_ID=2025;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2026");
                        if(checkIsExistFunction_7==true){
                            String sql="update sys_function set MENU_ID ='202002' where FUNC_ID=2026;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2013");
                        if(checkIsExistFunction_8==true){
                            String sql="update sys_function set MENU_ID ='2040' where FUNC_ID=2013;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_9 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2014");
                        if(checkIsExistFunction_9==true){
                            String sql="update sys_function set MENU_ID ='204001' where FUNC_ID=2014;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_10 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2015");
                        if(checkIsExistFunction_10==true){
                            String sql="update sys_function set MENU_ID ='204002' where FUNC_ID=2015;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_11 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2040");
                        if(checkIsExistFunction_11==true){
                            String sql="update sys_function set MENU_ID ='6065' where FUNC_ID=2040;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_12 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2041");
                        if(checkIsExistFunction_12==true){
                            String sql="update sys_function set MENU_ID ='606501' where FUNC_ID=2041;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean checkIsExistFunction_13 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3022");
                        if(checkIsExistFunction_13==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3022', '1040', '工作监控', 'Work monitoring', '工作監控', NULL, NULL, NULL, 'workflow/workMonitoring', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加主菜单
                     */
                        boolean isExistMenu = Verification.CheckIsExistMenu(conn, driver, url, username, password, "70");
                        if(isExistMenu==false){
                            String sql="INSERT INTO `sys_menu` (`MENU_ID`, `MENU_NAME`, `MENU_NAME1`, `MENU_NAME2`, `MENU_NAME3`, `MENU_NAME4`, `MENU_NAME5`, `MENU_EXT`, `IMAGE`) VALUES ('70', '档案管理', 'file management', '檔案管理', '', '', '', '', 'resource');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean existFunction_4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3024");
                        if(existFunction_4==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3024', '7001', '卷库管理', '\\r\\nLibrary management', '卷庫管理', NULL, NULL, NULL, 'rmsRollRoom/manage', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean existFunction = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3026");
                        if(existFunction==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3026', '7002', '案卷管理', NULL, NULL, NULL, NULL, NULL, 'rmsRoll/index', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean existFunction_1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3027");
                        if(existFunction_1==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3027', '7003', '文件管理', NULL, NULL, NULL, NULL, NULL, 'rmsFile/index', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 添加菜单
                     */
                        boolean existFunction_2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3028");
                        if(existFunction_2==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3028', '7004', '档案销毁', NULL, NULL, NULL, NULL, NULL, 'rmsFile/toDestroyed', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  添加字段的作用: 创建rms_file表
                     */
                        boolean isExistTable=Verification.CheckIsExistTable(conn, driver, url, username, password,"rms_file");
                        if(isExistTable==false){
                            String sql="CREATE TABLE IF NOT EXISTS `rms_file` (\n" +
                                    "  `FILE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                    "  `ROLL_ID` int(11) NOT NULL DEFAULT '0' COMMENT '对应RMS_ROLL表ROLL_ID',\n" +
                                    "  `ADD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '添加人',\n" +
                                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',\n" +
                                    "  `DEL_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '删除人',\n" +
                                    "  `DEL_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',\n" +
                                    "  `MOD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '修改人',\n" +
                                    "  `MOD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',\n" +
                                    "  `CONFIRM_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '预留',\n" +
                                    "  `FILE_CODE` varchar(200) NOT NULL DEFAULT '' COMMENT '文件号',\n" +
                                    "  `FILE_TITLE` varchar(200) NOT NULL DEFAULT '' COMMENT '文件标题',\n" +
                                    "  `FILE_TITLE0` varchar(200) NOT NULL DEFAULT '' COMMENT '文件辅标题',\n" +
                                    "  `FILE_SUBJECT` varchar(200) NOT NULL DEFAULT '' COMMENT '文件主题词',\n" +
                                    "  `SEND_UNIT` varchar(200) NOT NULL DEFAULT '' COMMENT '发文单位',\n" +
                                    "  `SEND_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '发文日期',\n" +
                                    "  `SECRET` varchar(200) NOT NULL DEFAULT '' COMMENT '密级(1-普密,4-秘密,3-机密,2-绝密)',\n" +
                                    "  `URGENCY` varchar(200) NOT NULL DEFAULT '' COMMENT '紧急等级(1-员工类型,2-普级)',\n" +
                                    "  `FILE_KIND` varchar(200) NOT NULL DEFAULT '' COMMENT '公文类别(1-A,2-B,3-C,4-D)',\n" +
                                    "  `FILE_TYPE` varchar(200) NOT NULL DEFAULT '' COMMENT '文件分类(1-公文,2-资料)',\n" +
                                    "  `FILE_PAGE` varchar(20) NOT NULL DEFAULT '' COMMENT '文件页数',\n" +
                                    "  `PRINT_PAGE` varchar(20) NOT NULL DEFAULT '' COMMENT '打印页数',\n" +
                                    "  `BORROW` char(1) NOT NULL DEFAULT '0' COMMENT '借阅审批(0-否,1-是)',\n" +
                                    "  `REMARK` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                    "  `ATTACHMENT_ID` text NOT NULL COMMENT '附件ID',\n" +
                                    "  `ATTACHMENT_NAME` text NOT NULL COMMENT '附件名称',\n" +
                                    "  `BORROW_STATUS` char(1) NOT NULL DEFAULT '0' COMMENT '预留',\n" +
                                    "  `CONFIRM_STATUS` char(1) NOT NULL DEFAULT '0' COMMENT '预留',\n" +
                                    "  `DOWNLOAD_YN` int(1) NOT NULL DEFAULT '1' COMMENT '预留',\n" +
                                    "  `ISAUDIT` char(1) NOT NULL DEFAULT '1' COMMENT '查看附件是否需要审批(0-否,1-是)',\n" +
                                    "  `DOWNLOAD` int(1) NOT NULL DEFAULT '1' COMMENT '允许下载Office附件(0-否,1-是)',\n" +
                                    "  `PRINT` int(1) NOT NULL DEFAULT '1' COMMENT '允许打印Office附件(0-否,1-是)',\n" +
                                    "  PRIMARY KEY (`FILE_ID`),\n" +
                                    "  KEY `ROLL_ID` (`ROLL_ID`),\n" +
                                    "  KEY `ADD_USER` (`ADD_USER`),\n" +
                                    "  KEY `DEL_USER` (`DEL_USER`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='文件管理';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                 /*   *
                     *  添加字段的作用: 创建rms_lend表
                     */
                        boolean isExistTable_10=Verification.CheckIsExistTable(conn, driver, url, username, password,"rms_lend");
                        if(isExistTable_10==false){
                            String sql="CREATE TABLE IF NOT EXISTS `rms_lend` (\n" +
                                    "  `LEND_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                    "  `FILE_ID` int(11) NOT NULL DEFAULT '0' COMMENT '对应RMS_FILE表FILE_ID',\n" +
                                    "  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '借阅人',\n" +
                                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',\n" +
                                    "  `LEND_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '申请时间',\n" +
                                    "  `RETURN_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '归还时间',\n" +
                                    "  `ALLOW_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '审批时间',\n" +
                                    "  `ALLOW` char(1) NOT NULL DEFAULT '0' COMMENT '允许状态(0-待批准借阅,1-已批准借阅,2-未批准借阅,3-已归还借阅)',\n" +
                                    "  `APPROVE` varchar(254) NOT NULL COMMENT '借阅人',\n" +
                                    "  `DELETE_FLAG` char(1) NOT NULL DEFAULT '0' COMMENT '删除状态(0-未删除,1-已删除)',\n" +
                                    "  `OPERATOR` varchar(254) NOT NULL COMMENT '审批人',\n" +
                                    "  PRIMARY KEY (`LEND_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='文件借阅';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                  /*  *
                     *  添加字段的作用: 创建rms_roll表
                     */
                        boolean isExistTable_11=Verification.CheckIsExistTable(conn, driver, url, username, password,"rms_roll");
                        if(isExistTable_11==false){
                            String sql="CREATE TABLE IF NOT EXISTS `rms_roll` (\n" +
                                    "  `ROLL_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                    "  `ROOM_ID` int(11) NOT NULL DEFAULT '0' COMMENT '对应RMS_ROLL_ROOM表ROOM_ID',\n" +
                                    "  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '部门ID',\n" +
                                    "  `ROLL_CODE` varchar(200) NOT NULL DEFAULT '' COMMENT '案卷号',\n" +
                                    "  `ROLL_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '案卷名称',\n" +
                                    "  `YEARS` varchar(100) NOT NULL DEFAULT '' COMMENT '归卷年代',\n" +
                                    "  `BEGIN_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '起始日期',\n" +
                                    "  `END_DATE` date NOT NULL DEFAULT '0000-00-00' COMMENT '终止日期',\n" +
                                    "  `DEADLINE` varchar(100) NOT NULL DEFAULT '' COMMENT '保管期限',\n" +
                                    "  `SECRET` varchar(200) NOT NULL DEFAULT '' COMMENT '案卷密级(1-普密,4-秘密,3-机密,2-绝密)',\n" +
                                    "  `CATEGORY_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '全宗号',\n" +
                                    "  `CATALOG_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '目录号',\n" +
                                    "  `ARCHIVE_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '档案馆号',\n" +
                                    "  `BOX_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '保险箱号',\n" +
                                    "  `MICRO_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '缩微号',\n" +
                                    "  `CERTIFICATE_KIND` varchar(200) NOT NULL DEFAULT '' COMMENT '凭证类别(1-XXX1,2-XXX2)',\n" +
                                    "  `CERTIFICATE_START` varchar(200) NOT NULL DEFAULT '' COMMENT '起始凭证编号',\n" +
                                    "  `CERTIFICATE_END` varchar(200) NOT NULL DEFAULT '' COMMENT '截至凭证编号',\n" +
                                    "  `ROLL_PAGE` varchar(200) NOT NULL DEFAULT '' COMMENT '页数',\n" +
                                    "  `BORROW` char(1) NOT NULL DEFAULT '0' COMMENT '借阅审批(0-否,1-是)',\n" +
                                    "  `REMARK` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                    "  `MANAGE_USER` text NOT NULL COMMENT '预留',\n" +
                                    "  `READ_USER` text NOT NULL COMMENT '预留',\n" +
                                    "  `ADD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '添加人',\n" +
                                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',\n" +
                                    "  `DEL_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '删除人',\n" +
                                    "  `DEL_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',\n" +
                                    "  `MOD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '修改人',\n" +
                                    "  `STATUS` char(1) NOT NULL DEFAULT '0' COMMENT '案卷状态(0-未封卷,1-已封卷)',\n" +
                                    "  `MOD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',\n" +
                                    "  `BZJG` varchar(254) NOT NULL COMMENT '预留',\n" +
                                    "  `MANAGER` varchar(254) NOT NULL COMMENT '案卷管理员',\n" +
                                    "  `EDIT_DEPT` varchar(200) NOT NULL COMMENT '编制机构',\n" +
                                    "  PRIMARY KEY (`ROLL_ID`),\n" +
                                    "  KEY `ROOM_ID` (`ROOM_ID`),\n" +
                                    "  KEY `MANAGER` (`MANAGER`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='案卷表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                 /*   *
                     *  添加字段的作用: 创建rms_roll_room表
                     */
                        boolean isExistTable_12=Verification.CheckIsExistTable(conn, driver, url, username, password,"rms_roll_room");
                        if(isExistTable_12==false){
                            String sql="CREATE TABLE IF NOT EXISTS `rms_roll_room` (\n" +
                                    "  `ROOM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',\n" +
                                    "  `DEPT_ID` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门',\n" +
                                    "  `ROOM_CODE` varchar(200) NOT NULL DEFAULT '' COMMENT '卷库号',\n" +
                                    "  `ROOM_NAME` varchar(200) NOT NULL DEFAULT '' COMMENT '卷库名称',\n" +
                                    "  `CATEGORY_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '全宗号',\n" +
                                    "  `CATALOG_NO` varchar(100) NOT NULL DEFAULT '' COMMENT '目录号',\n" +
                                    "  `REMARK` varchar(200) NOT NULL DEFAULT '' COMMENT '备注',\n" +
                                    "  `MANAGE_USER` text NOT NULL COMMENT '卷库管理员',\n" +
                                    "  `ADD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '添加人',\n" +
                                    "  `ADD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '添加时间',\n" +
                                    "  `DEL_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '删除人',\n" +
                                    "  `DEL_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '删除时间',\n" +
                                    "  `MOD_USER` varchar(20) NOT NULL DEFAULT '' COMMENT '修改人',\n" +
                                    "  `MOD_TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '修改时间',\n" +
                                    "  `VIEW_DEPT_ID` text COMMENT '卷库内文件的借阅范围',\n" +
                                    "  PRIMARY KEY (`ROOM_ID`),\n" +
                                    "  UNIQUE KEY `ROOM_ID` (`ROOM_ID`),\n" +
                                    "  KEY `ROOM_ID_2` (`ROOM_ID`,`ROOM_CODE`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=gbk COMMENT='卷库表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                        boolean checkIsExistfield1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "seal", "DEPT_ID");
                        if(checkIsExistfield1==true){
                            String sql ="alter table seal modify DEPT_ID  varchar(255);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                   /* *
                     *  添加字段的作用: 修改字段类型
                     */
                        boolean existfield = Verification.CheckIsExistfield(conn, driver, url, username, password, "im_room", "RNAMR");
                        if(existfield==true){
                            String sql ="ALTER TABLE im_room MODIFY COLUMN RNAMR text;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                        boolean existfield_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "im_room", "RMEMBER_UID");
                        if(existfield_1==true){
                            String sql ="ALTER TABLE im_room MODIFY COLUMN RMEMBER_UID text;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                        boolean existfield_2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "POST_ID");
                        if(existfield_2==false){
                            String sql ="alter table `user` add POST_ID int(255) comment'职务ID 对应user_post表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                        boolean existfield_3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user", "JOB_ID");
                        if(existfield_3==false){
                            String sql ="alter table `user` add JOB_ID int(11) comment'岗位ID 对应user_job表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                  /*  *
                     *  添加字段的作用: 修改推送消息
                     */
                        boolean isExistThing = Verification.CheckIsExistThing(conn, driver, url, username, password, "340");
                        boolean isExistThing_1 = Verification.CheckIsExistThing(conn, driver, url, username, password, "341");
                        boolean isExistThing_2 = Verification.CheckIsExistThing(conn, driver, url, username, password, "342");
                        boolean isExistThing_3 = Verification.CheckIsExistThing(conn, driver, url, username, password, "343");
                        if(isExistThing==true&&isExistThing_1==true&&isExistThing_2==true&&isExistThing_3==true){
                            String sql ="UPDATE flow_trigger SET `PLUGIN`=0 WHERE ID=340 OR ID=341 OR ID=342 OR ID=343;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                        boolean existUserPriv = Verification.CheckIsExistUserPriv(conn, driver, url, username, password, "1");
                        if(existUserPriv==true){
                            String sql ="update `user_priv` set FUNC_ID_STR='1,4,147,148,7,8,9,16,2011,2005,2044,11,130,5,131,3022,134,37,135,136,2002,2003,3023,24,196,105,119,80,2024,2025,2026,2031,2032,2033,2034,2013,2014,2015,43,17,18,19,15,36,76,77,27,60,481,502,504,505,503,26,506,508,2043,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,2040,2041,90,91,92,93,94,95,96,118,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3024,3026,3027,3028,3017,3018,3019,3020,56,2001,30,31,33,32,3029,3030,2007,2008,2009,2010,57,197,78,2047,178,104,121,99,2042,2004,626,38,' where USER_PRIV ='1';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }
                        boolean isExistUserFunction = Verification.CheckIsExistUserFunction(conn, driver, url, username, password, "1");
                        if(isExistUserFunction==true){
                            String sql ="UPDATE `user_function` SET `user_func_id_str`='1,4,147,148,7,8,9,16,2011,2005,2044,11,130,5,131,3022,134,37,135,136,2002,2003,3023,24,196,105,119,80,2024,2025,2026,2031,2032,2033,2034,2013,2014,2015,43,17,18,19,15,36,76,77,27,60,481,502,504,505,503,26,506,508,2043,85,86,2006,88,87,138,89,222,137,126,179,607,539,127,238,128,2040,2041,90,91,92,93,94,95,96,118,3001,3002,3003,3004,3005,3006,3007,3008,3009,3010,3011,3012,3013,3014,3015,3016,3024,3026,3027,3028,3017,3018,3019,3020,56,2001,30,31,33,32,3029,3030,2007,2008,2009,2010,57,197,78,2047,178,104,121,99,2042,2004,626,38,' WHERE `uid`='1';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为1;
                        }

               /*     *
                     *  添加字段的作用: 记录附件大小字段
                     */
                        boolean checkIsExistAttend = Verification.CheckIsExistfield(conn, driver, url, username, password, "attachment", "SIZE");
                        if(checkIsExistAttend==false){
                            String sql="alter table `attachment` add SIZE varchar(255) comment'附件大小';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
/*                    *
                     *  作用: 创建htmldocument表
                     */
                        boolean existTable=Verification.CheckIsExistTable(conn, driver, url, username, password,"htmldocument");
                        if(existTable==false){
                            String sql="CREATE TABLE IF NOT EXISTS `htmldocument` (\n" +
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
                        boolean existTable_1=Verification.CheckIsExistTable(conn, driver, url, username, password,"htmlhistory");
                        if(existTable_1==false){
                            String sql="CREATE TABLE IF NOT EXISTS `htmlhistory` (\n" +
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
                     *  作用: 创建htmlhistory表
                     */
                        boolean existTable_2=Verification.CheckIsExistTable(conn, driver, url, username, password,"htmlsignature");
                        if(existTable_2==false){
                            String sql="CREATE TABLE IF NOT EXISTS `htmlsignature` (\n" +
                                    "  `DocumentID` varchar(254) DEFAULT NULL,\n" +
                                    "  `Signature` text,\n" +
                                    "  `SignatureID` varchar(64) DEFAULT NULL\n" +
                                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                /*    *
                     *  作用: 创建htmlhistory表
                     */
                        boolean existTable_3=Verification.CheckIsExistTable(conn, driver, url, username, password,"htmlsignature");
                        if(existTable_3==false){
                            String sql="CREATE TABLE IF NOT EXISTS `htmlsignature` (\n" +
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
                        boolean existTable_4=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_relation_keysign");
                        if(existTable_4==false){

                            String sql= "CREATE TABLE IF NOT EXISTS `kg_relation_keysign` (\n" +
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
                        if(b==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('1', '1', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_1 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "1");
                        if(check_1==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('1', '1', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 添加数据
                     */
                        boolean check_2 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "2");
                        if(check_2==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('2', '1', '2');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
              /*      *
                     *  作用: 添加数据
                     */
                        boolean check_3 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "3");
                        if(check_3==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('3', '1', '3');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_4 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "4");
                        if(check_4==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('4', '1', '5');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean check_5 = Verification.CheckIsExistKgSign(conn, driver, url, username, password, "5");
                        if(check_5==false){
                            String sql="INSERT INTO `kg_relation_keysign` VALUES ('5', '2', '4');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 创建kg_relation_keyuser表
                     */
                        boolean existTable_5=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_relation_keyuser");
                        if(existTable_5==false){
                            String sql="CREATE TABLE IF NOT EXISTS `kg_relation_keyuser` (\n" +
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
                        if(check_6==false){
                            String sql="INSERT INTO `kg_relation_keyuser` VALUES ('1', '1', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  作用: 添加数据
                     */
                        boolean check_7 = Verification.CheckIsExistKgkeyUser(conn, driver, url, username, password, "2");
                        if(check_7==false){
                            String sql="INSERT INTO `kg_relation_keyuser` VALUES ('2', '1', '2');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 创建kg_relation_keyuser表
                     */
                        boolean existTable_6=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_signature");
                        if(existTable_6==false){
                            String sql= "CREATE TABLE IF NOT EXISTS `kg_signature` (\n" +
                                    "  `SIGNATURE_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,\n" +
                                    "  `SIGNATURE_NAME` varchar(255) DEFAULT NULL COMMENT '签章名称',\n" +
                                    "  `SIGNATURE_KGID` varchar(255) DEFAULT NULL COMMENT '金格签章id',\n" +
                                    "  `SIGNATURE_STATUS` int(4) DEFAULT '0' COMMENT '使用状态 0正常 -1禁制使用',\n" +
                                    "  PRIMARY KEY (`SIGNATURE_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_8 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "1");
                        if(check_8==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('1', '金格演示公章', 'BCxhL9mkEgv2dFTcpQHz8uUtNiqIXG35+rYJj1lfeb/KO4=yaWV0DSAPnw67oZsRM', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用: 添加数据
                     */
                        boolean check_12 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "2");
                        if(check_12==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('2', '金格演示合同章', 'M=dUfvWPYlTLAOt70V9p1x5nRFm2aizZc3b/w+8SGhXj6JEoIQyNHCkrsguDeqB4K', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean check_9 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "3");
                        if(check_9==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('3', '金格科技私章1X2.24', '0myIz5atpgOPbM8wYqiLWnAuBJXDrSjE9U376VFkT=KxeRhf+vosNC1Gc4/HdZQl2', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_10 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "4");
                        if(check_10==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('4', '金格演示发票专用章', '0wAeTICLvyhqi1KJkOgsarYNQ5BUGEmSV8Z23P94lfno=M6pjFDdxuz+/cX7bHWRt', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_11 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "5");
                        if(check_11==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('5', '金格演示合同章1', '8x2=rAUbHvF3/4dQDaptogRz70mfMI6LNCsnKV9SqYiPWXZE1euhyTkj+JOwlGB5c', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 创建kg_relation_keyuser表
                     */
                        boolean existTable_7=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_signkey");
                        if(existTable_7==false){
                            String sql= "CREATE TABLE IF NOT EXISTS `kg_signkey` (\n" +
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
                        if(check_13==false){
                            String sql="INSERT INTO `kg_signkey` VALUES ('1', '测试盘1', 'C84CF78C359E757E', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 添加数据
                     */
                        boolean check_14 = Verification.CheckIsExistkgSignKey(conn, driver, url, username, password, "2");
                        if(check_14==false){
                            String sql="INSERT INTO `kg_signkey` VALUES ('2', '测试盘2', '44871127553E5D00', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

               /*     *
                     *  添加字段的作用: 修改一下用户字段的大小
                     */
                        boolean existfield1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "user_ext", "EMAIL_RECENT_LINKMAN");
                        if(existfield1==true){
                            String sql="ALTER TABLE user_ext  MODIFY COLUMN EMAIL_RECENT_LINKMAN mediumtext NOT NULL;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *   2018-1-26
                     *  作用: 创建info_center表
                     */
                        boolean infoCenterOrder=Verification.CheckIsExistTable(conn, driver, url, username, password,"info_center");
                        if(infoCenterOrder==false){
                            String sql="CREATE TABLE IF NOT EXISTS `info_center` (\n" +
                                    "  `INFO_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',\n" +
                                    "  `INFO_NO` int(11) NOT NULL DEFAULT '0' COMMENT '默认应用序号',\n" +
                                    "  `INFO_NAME1` varchar(50) NOT NULL COMMENT '应用名称（简体中文）',\n" +
                                    "  `INFO_NAME2` varchar(50) NOT NULL COMMENT '应用名称（英文）',\n" +
                                    "  `INFO_NAME3` varchar(50) NOT NULL COMMENT '应用名称（繁体中文）',\n" +
                                    "  `INFO_NAME4` varchar(50) NOT NULL COMMENT '应用名称',\n" +
                                    "  `INFO_NAME5` varchar(50) NOT NULL COMMENT '应用名称',\n" +
                                    "  `INFO_FUNC_ID` int(11) NOT NULL DEFAULT '0' COMMENT '对应的FUNC_ID',\n" +
                                    "  PRIMARY KEY (`INFO_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='首页信息表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 添加数据
                     */
                        boolean infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"1");
                        if(infoCenter==false){
                            String sql="INSERT INTO `info_center` VALUES ('1', '1', '公告通知', 'Notice', '公告通知', '', '', '4');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean infoCenter2=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"2");
                        if(infoCenter2==false){
                            String sql="INSERT INTO `info_center` VALUES ('2', '2', '新闻', 'News', '新聞', '', '', '147');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean infoCenter3=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"3");
                        if(infoCenter3==false){
                            String sql="INSERT INTO `info_center` VALUES ('3', '3', '邮件箱', 'Email', '郵件箱', '', '', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 添加数据
                     */
                        boolean infoCenter4=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"4");
                        if(infoCenter4==false){
                            String sql="INSERT INTO `info_center` VALUES ('4', '4', '待办流程', 'Backlog process', '待辦流程', '', '', '5');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  作用:添加数据
                     */
                        boolean infoCenter5=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"5");
                        if(infoCenter5==false){
                            String sql="INSERT INTO `info_center` VALUES ('5', '5', '日程安排', 'Schedule', '日程安排', '', '', '8');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  作用: 添加字段
                     */
                        boolean infoCenter6=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"6");
                        if(infoCenter6==false){
                            String sql="INSERT INTO `info_center` VALUES ('6', '6', '常用功能', 'Common function', '常用功能', '', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用:添加数据
                     */
                        boolean infoCenter7=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"7");
                        if(infoCenter7==false){
                            String sql="INSERT INTO `info_center` VALUES ('7', '7', '日志', 'Log', '日誌', '', '', '9');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用:添加数据
                     */
                        boolean infoCenter8=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"8");
                        if(infoCenter8==false){
                            String sql="INSERT INTO `info_center` VALUES ('8', '8', '文件柜', 'File Cabinet', '文件櫃', '', '', '15');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用:添加数据
                     */
                        boolean infoCenter9=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"9");
                        if(infoCenter9==false){
                            String sql="INSERT INTO `info_center` VALUES ('9', '9', '网络硬盘', 'Network Disk', '網絡硬盤', '', '', '76');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 删除索引
                     */
                        boolean b1 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_out", "LEADER_ID");
                        if(b1==true){
                            String sql="DROP INDEX LEADER_ID ON attend_out;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 修改字段类型
                     */

                        boolean existInfoCenter = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_out", "LEADER_ID");
                        if(existInfoCenter==true){
                            String sql="ALTER TABLE attend_out  MODIFY COLUMN LEADER_ID text NOT NULL;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 删除所以索引
                     */

                        boolean b2 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_leave", "LEADER_ID");
                        if(b2==true){
                            String sql="DROP INDEX LEADER_ID ON attend_leave;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用: 修改字段类型
                     */

                        boolean existInfoCenter2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_leave", "LEADER_ID");
                        if(existInfoCenter2==true){
                            String sql="ALTER TABLE attend_leave  MODIFY COLUMN LEADER_ID text NOT NULL;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                 /*   *
                     *  作用: 修改字段类型
                     */

                        boolean existInfoCenter3 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attend_evection", "LEADER_ID");
                        if(existInfoCenter3==true){
                            String sql="ALTER TABLE attend_evection  MODIFY COLUMN LEADER_ID text NOT NULL;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                  /*  *
                     *  作用: 添加数据
                     */
                        boolean widget=Verification.CheckIsExistWidget(conn, driver, url, username, password,"8");
                        if(widget==false){
                            String sql="INSERT INTO `widget` (`ID`, `NAME`, `AID`, `TID`, `DATA`, `IS_SET`, `IS_ON`, `NO`) VALUES ('8', '公文', '0', '0', 'document', '1', '1', '7');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用: 更新数据
                     */
                        boolean user_1=Verification.CheckIsExistUser(conn, driver, url, username, password,"1");
                        if(user_1==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =1;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 更新数据
                     */
                        boolean user_2=Verification.CheckIsExistUser(conn, driver, url, username, password,"106");
                        if(user_2==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =106;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 更新数据
                     */
                        boolean user_3=Verification.CheckIsExistUser(conn, driver, url, username, password,"107");
                        if(user_3==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =107;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
              /*      *
                     *  作用: 更新数据
                     */
                        boolean user_4=Verification.CheckIsExistUser(conn, driver, url, username, password,"108");
                        if(user_4==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =108;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
             /*       *
                     *  作用: 更新数据
                     */
                        boolean user_5=Verification.CheckIsExistUser(conn, driver, url, username, password,"109");
                        if(user_5==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =109;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
              /*      *
                     *  作用: 更新数据
                     */
                        boolean user_6=Verification.CheckIsExistUser(conn, driver, url, username, password,"110");
                        if(user_6==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =110;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用: 更新数据
                     */
                        boolean user_7=Verification.CheckIsExistUser(conn, driver, url, username, password,"111");
                        if(user_7==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =111;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 更新数据
                     */
                        boolean user_8=Verification.CheckIsExistUser(conn, driver, url, username, password,"112");
                        if(user_8==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =112;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用: 更新数据
                     */
                        boolean user_9=Verification.CheckIsExistUser(conn, driver, url, username, password,"113");
                        if(user_9==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =113;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 更新数据
*/                    boolean user_10=Verification.CheckIsExistUser(conn, driver, url, username, password,"114");
                        if(user_10==true){
                            String sql="UPDATE user SET NOT_MOBILE_LOGIN  = 0 WHERE UID =114;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据 版本号 2018.01.26.1之后
                         */
                        boolean isExistFunction = Verification.CheckIsExistFunction(conn, driver, url, username, password, "56");
                        if (isExistFunction == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@unitsetup' WHERE FUNC_ID =56;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据
                         */
                        boolean isExistFunction1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "57");
                        if (isExistFunction1 == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@officesetting' WHERE FUNC_ID =57;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据
                         */
                        boolean existFunction1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "134");
                        if (existFunction1 == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@workflowsetting' WHERE FUNC_ID =134;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据
                         */
                        boolean existFunction2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2007");
                        if (existFunction2 == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@mechanismsetting' WHERE FUNC_ID =2007;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据
                         */
                        boolean existFunction3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3006");
                        if (existFunction3 == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@receiptmanagement' WHERE FUNC_ID =3006;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单数据
                         */
                        boolean existFunction5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "502");
                        if (existFunction5 == true) {
                            String sql = "UPDATE sys_function SET FUNC_CODE ='@hr/training/plan' WHERE FUNC_ID =502;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-1-26
                         *  作用: 创建app_log表
                         */
                        boolean table = Verification.CheckIsExistTable(conn, driver, url, username, password, "app_log");
                        if (table == false) {
                            String sql = "CREATE TABLE IF NOT EXISTS `app_log` (\n" +
                                    "  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `USER_ID` varchar(20) NOT NULL DEFAULT '' COMMENT 'OA用户名',\n" +
                                    "  `TIME` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '操作时间',\n" +
                                    "  `MODULE` varchar(10) NOT NULL DEFAULT '' COMMENT '模块id',\n" +
                                    "  `OPP_ID` varchar(20) NOT NULL DEFAULT '' COMMENT '操作记录的id',\n" +
                                    "  `TYPE` varchar(10) NOT NULL DEFAULT '' COMMENT '操作类型',\n" +
                                    "  `REMARK` mediumtext NOT NULL COMMENT '备注',\n" +
                                    "  PRIMARY KEY (`LOG_ID`),\n" +
                                    "  KEY `MODULE_OPP_USER_TYPE` (`MODULE`,`OPP_ID`,`USER_ID`,`TYPE`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1301 DEFAULT CHARSET=gbk COMMENT='各模块操作日志表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-1-26
                         *  作用: 添加职务、岗位下拉框
                         */
                        boolean isExistCode = Verification.CheckIsExistCode(conn, driver, url, username, password, "function", "");
                        if (isExistCode == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('function', '职能', NULL, NULL, NULL, NULL, NULL, NULL, '01', '', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-1-26
                         *  作用: 添加职务、岗位下拉框
                         */
                        boolean isExistCode1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "1", "function");
                        if (isExistCode1 == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('1', '管理', NULL, NULL, NULL, NULL, NULL, NULL, '01', 'function', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-1-26
                         *  作用: 添加职务、岗位下拉框
                         */
                        boolean isExistCode2 = Verification.CheckIsExistCode(conn, driver, url, username, password, "2", "function");
                        if (isExistCode2 == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('2', '技术', NULL, NULL, NULL, NULL, NULL, NULL, '02', 'function', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-1-26
                         *  作用: 添加职务、岗位下拉框
                         */
                        boolean isExistCode3 = Verification.CheckIsExistCode(conn, driver, url, username, password, "3", "function");
                        if (isExistCode3 == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('3', '行政', NULL, NULL, NULL, NULL, NULL, NULL, '03', 'function', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 添加岗位菜单
                         */
                        boolean existFunctionfu = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3029");
                        if (existFunctionfu == false) {
                            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3029', 'z00411', '岗位管理', 'post management', '崗位管理', NULL, NULL, NULL, 'sys/getPostmanagement', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 添加职务菜单
                         */
                        boolean existFunction4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3030");
                        if (existFunction4 == false) {
                            String sql = "INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('3030', 'z00412', '职务管理', 'Job management', '職務管理', NULL, NULL, NULL, 'duties/dutiesjsp', '', NULL);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**   2018-1-26
                         *  作用: 创建职务表
                         */
                        boolean isExistTablez = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_post");
                        if (isExistTablez == false) {
                            String sql = "CREATE TABLE IF NOT EXISTS `user_post` (\n" +
                                    "  `POST_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                    "  `POST_NAME` varchar(255) DEFAULT NULL COMMENT '职务名称',\n" +
                                    "  `TYPE` int(11) DEFAULT NULL COMMENT '职务类型',\n" +
                                    "  `LEVEL` varchar(255) DEFAULT NULL COMMENT '职务级别',\n" +
                                    "  `POST_NO` varchar(255) DEFAULT NULL COMMENT '职务编号',\n" +
                                    "  `DEPT_ID` int(11) DEFAULT NULL COMMENT '所属部门',\n" +
                                    "  `DUTY` varchar(255) DEFAULT NULL COMMENT '职责',\n" +
                                    "  `DESCRIPTION` text COMMENT '职务描述',\n" +
                                    "  `ATTACHMENT_ID` varchar(255) DEFAULT NULL COMMENT '附件id',\n" +
                                    "  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL COMMENT '附件名称',\n" +
                                    "  PRIMARY KEY (`POST_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-2-1
                         *  作用: 创建职务表
                         */
                        boolean isExistJob = Verification.CheckIsExistTable(conn, driver, url, username, password, "user_job");
                        if (isExistJob == false) {
                            String sql = "CREATE TABLE IF NOT EXISTS `user_job` (\n" +
                                    "  `JOB_ID` int(11) NOT NULL AUTO_INCREMENT,\n" +
                                    "  `JOB_NAME` varchar(255) DEFAULT NULL,\n" +
                                    "  `TYPE` int(11) DEFAULT NULL,\n" +
                                    "  `LEVEL` varchar(255) DEFAULT NULL,\n" +
                                    "  `JOB_NO` varchar(255) DEFAULT NULL,\n" +
                                    "  `DEPT_ID` int(11) DEFAULT NULL,\n" +
                                    "  `JOB_PLAN` varchar(255) DEFAULT NULL,\n" +
                                    "  `DUTY` varchar(255) DEFAULT NULL,\n" +
                                    "  `DESCRIPTION` text,\n" +
                                    "  `ATTACHMENT_ID` varchar(255) DEFAULT NULL,\n" +
                                    "  `ATTACHMENT_NAME` varchar(255) DEFAULT NULL,\n" +
                                    "  PRIMARY KEY (`JOB_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;\n";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *//**   2018-1-26
                         *  作用: 加班申请
                         *//*
                    boolean existCode = Verification.CheckIsExistCode(conn, driver, url, username, password, "141", "KQQJTYPE");
                    if (existCode == false) {
                        String sql = "INSERT INTO `sys_code` VALUES ('976', '141', '加班申请', null, null, null, null, null, null, '141', 'KQQJTYPE', '0', '');";
                        Statement st = conn.createStatement();
                        st.executeUpdate(sql);//执行SQL语句
                    }*/

                        boolean existCode = Verification.CheckCode(conn, driver, url, username, password, "976");
                        if (existCode == false) {
                            String sql = "INSERT INTO `sys_code` VALUES ('976', '141', '加班申请', null, null, null, null, null, null, '141', 'KQQJTYPE', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }


                        /**
                         *  作用: 更新菜单重复funcName1
                         */
                        boolean function = Verification.CheckIsExistFunction(conn, driver, url, username, password, "539");
                        if (function == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME1='Office Distribution' WHERE FUNC_ID =539;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单重复funcName1
                         */
                        boolean checkIsExistFunctionq = Verification.CheckIsExistFunction(conn, driver, url, username, password, "179");
                        if (checkIsExistFunctionq == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME1='Office supplies application' WHERE FUNC_ID =179;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单重复funcName1
                         */
                        boolean checkIsExistFunction1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3026");
                        if (checkIsExistFunction1 == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME1='supervision of the record',FUNC_NAME2='案卷管理' WHERE FUNC_ID =3026;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单重复funcName1
                         */
                        boolean checkIsExistFunction2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3027");
                        if (checkIsExistFunction2 == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME1='file management',FUNC_NAME2='文件管理' WHERE FUNC_ID =3027;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单重复funcName1
                         */
                        boolean checkIsExistFunction3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3028");
                        if (checkIsExistFunction3 == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME1='Archives destruction',FUNC_NAME2='檔案銷毀' WHERE FUNC_ID =3028;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 更新菜单重复funcName3
                         */
                        boolean checkIsExistFunction4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "3023");
                        if (checkIsExistFunction4 == true) {
                            String sql = "UPDATE sys_function SET FUNC_NAME2='郵件統計' WHERE FUNC_ID =3023;";
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

                        /**
                         * 2018-02-06  高亚峰
                         *  作用:  添加字段的作用: 添加IM解散群字段
                         */
                        boolean IMexist = Verification.CheckIsExistfield(conn, driver, url, username, password, "im_room", "ROOM_STATUS");
                        if (IMexist == false) {
                            String sql = "alter table im_room add ROOM_STATUS int default 0 comment '群状态（0：正常，-1：群解散）';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**
                         * 2018-02-07  高亚峰
                         *  作用:  添加字段的作用: 限制文件柜大小
                         */
                        boolean spaceLimit = Verification.CheckIsExistfield(conn, driver, url, username, password, "file_sort", "SPACE_LIMIT");
                        if (spaceLimit == false) {
                            String sql = "alter table file_sort add SPACE_LIMIT int(11)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-02-07  高亚峰
                         *  作用:  添加字段的作用: 限制文件大小
                         */
                        boolean fileSort = Verification.CheckIsExistfield(conn, driver, url, username, password, "file_content", "FILE_SIZE");
                        if (fileSort == false) {
                            String sql = "alter table file_content add FILE_SIZE varchar(255) DEFAULT NULL COMMENT '文件大小'";
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
                        boolean drop_table=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_signature");
                        if (drop_table == true) {
                            String sql = "DROP TABLE IF EXISTS `kg_signature`;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**    2018-02-07 高亚峰
                         *  作用:  创建kg_relation_keyuser表
                         */
                        boolean create_table=Verification.CheckIsExistTable(conn, driver, url, username, password,"kg_signature");
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
                        if(insert==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('1', '金格演示公章', '北京高速波科技有限公司', 'BCxhL9mkEgv2dFTcpQHz8uUtNiqIXG35+rYJj1lfeb/KO4=yaWV0DSAPnw67oZsRM', '-1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                               /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_1 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "2");
                        if(insert_1==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('2', '金格演示合同章', '北京高速波科技有限公司', 'M=dUfvWPYlTLAOt70V9p1x5nRFm2aizZc3b/w+8SGhXj6JEoIQyNHCkrsguDeqB4K', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                    /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_2 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "3");
                        if(insert_2==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('3', '金格科技私章1X2.24', '北京高速波科技有限公司', '0myIz5atpgOPbM8wYqiLWnAuBJXDrSjE9U376VFkT=KxeRhf+vosNC1Gc4/HdZQl2', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                    /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_3 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "4");
                        if(insert_3==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('4', '金格演示发票专用章', '北京高速波科技有限公司', '0wAeTICLvyhqi1KJkOgsarYNQ5BUGEmSV8Z23P94lfno=M6pjFDdxuz+/cX7bHWRt', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                    /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_4 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "5");
                        if(insert_4==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('5', '金格演示合同章1', '北京高速波科技有限公司', '8x2=rAUbHvF3/4dQDaptogRz70mfMI6LNCsnKV9SqYiPWXZE1euhyTkj+JOwlGB5c', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                    /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_5 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "6");
                        if(insert_5==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('6', '心通达演示公章', '北京高速波科技有限公司', '3KLmcTy0VR5FjgoAWeb7YBO24C1JsU8iqfzrQ9dNanu=MG/Sxk6ZwhtDEHXvlP+Ip', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_6 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "7");
                        if(insert_6==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('7', '心通达演示发票专用章', '北京高速波科技有限公司', 'PFxBSYkjo80hi4H15=mfzdM97bX6GK3URc/+ENOnDAqQIvsTtaJZLwuyeglrWCVp2', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /*   2018-02-07 高亚峰
                     *  作用: 添加kg_relation_keyuser表数据
                     */
                        boolean insert_7 = Verification.CheckIsExistkgSignature(conn, driver, url, username, password, "8");
                        if(insert_7==false){
                            String sql="INSERT INTO `kg_signature` VALUES ('8', '心通达演示合同章', '北京高速波科技有限公司', 'xytDQgAwfJ23=GvXWd1jShRl7BEeMib0+No/4UK9aT8CpcHm6VsOkqIuP5nLFYrzZ', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-02-07   高亚峰
                         *  作用: 更新sys_code
                         */
                        boolean Code = Verification.CheckIsExistCode(conn, driver, url, username, password, "01", "NOTIFY");
                        if(Code==true){
                            String sql="UPDATE `sys_code` SET`CODE_NO`='02', `CODE_ORDER`='02' WHERE `CODE_ID`='545';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-02-07  高亚峰
                         *  作用: 更新sys_code
                         */
                        boolean Code_1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "02", "NOTIFY");
                        if(Code_1==true){
                            String sql="UPDATE `sys_code` SET`CODE_NO`='01', `CODE_ORDER`='01' WHERE `CODE_ID`='546';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-02-07  高亚峰
                         *  作用: 更新sys_menu
                         */
                        boolean sys_menu = Verification.CheckIsExistMenu(conn, driver, url, username, password, "70");
                        if(sys_menu==true){
                            String sql="UPDATE `sys_menu` SET`IMAGE`='record' WHERE `MENU_ID`='70';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                             /*   *
                     *  作用: 添加数据
                     */
                        boolean num_1infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"1");
                        if(num_1infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='1', `INFO_NO`='1', `INFO_NAME1`='公告通知', `INFO_NAME2`='Notice', `INFO_NAME3`='公告通知', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='4' WHERE (`INFO_ID`='1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean num_2infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"2");
                        if(num_2infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='2', `INFO_NO`='2', `INFO_NAME1`='新闻', `INFO_NAME2`='News', `INFO_NAME3`='新聞', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='147' WHERE (`INFO_ID`='2');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                  /*  *
                     *  作用: 添加数据
                     */
                        boolean num_3infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"3");
                        if(num_3infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='3', `INFO_NO`='3', `INFO_NAME1`='邮件箱', `INFO_NAME2`='Email', `INFO_NAME3`='郵件箱', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='1' WHERE (`INFO_ID`='3');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用: 添加数据
                     */
                        boolean num_4infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"4");
                        if(num_4infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='4', `INFO_NO`='4', `INFO_NAME1`='待办流程', `INFO_NAME2`='Backlog process', `INFO_NAME3`='待辦流程', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='5' WHERE (`INFO_ID`='4');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  作用:添加数据
                     */
                        boolean num_5infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"5");
                        if(num_5infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='5', `INFO_NO`='5', `INFO_NAME1`='日程安排', `INFO_NAME2`='Schedule', `INFO_NAME3`='日程安排', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='8' WHERE (`INFO_ID`='5');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
               /*     *
                     *  作用: 添加字段
                     */
                        boolean num_6infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"6");
                        if(num_6infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='6', `INFO_NO`='6', `INFO_NAME1`='常用功能', `INFO_NAME2`='Common function', `INFO_NAME3`='常用功能', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='0' WHERE (`INFO_ID`='6');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                 /*   *
                     *  作用:添加数据
                     */
                        boolean num_7infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"7");
                        if(num_7infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='7', `INFO_NO`='7', `INFO_NAME1`='日志', `INFO_NAME2`='Log', `INFO_NAME3`='日誌', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='9' WHERE (`INFO_ID`='7');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                /*    *
                     *  作用:添加数据
                     */
                        boolean num_8infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"8");
                        if(num_8infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='8', `INFO_NO`='8', `INFO_NAME1`='文件柜', `INFO_NAME2`='File Cabinet', `INFO_NAME3`='文件櫃', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='15' WHERE (`INFO_ID`='8');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                   /* *
                     *  作用:添加数据
                     */
                        boolean num_9infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"9");
                        if(num_9infoCenter==true){
                            String sql="UPDATE `info_center` SET `INFO_ID`='9', `INFO_NO`='9', `INFO_NAME1`='网络硬盘', `INFO_NAME2`='Network Disk', `INFO_NAME3`='網絡硬盤', `INFO_NAME4`='', `INFO_NAME5`='', `INFO_FUNC_ID`='76' WHERE (`INFO_ID`='9');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /* *
                     *  作用:添加数据
                     */
                        boolean num_10infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"10");
                        if(num_10infoCenter==false){
                            String sql="INSERT INTO `info_center` (`INFO_ID`, `INFO_NO`, `INFO_NAME1`, `INFO_NAME2`, `INFO_NAME3`, `INFO_NAME4`, `INFO_NAME5`, `INFO_FUNC_ID`) VALUES ('10', '10', '会议通知', 'Meeting notice', '會議通知', '', '', '-1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /* *
                     *  作用:添加数据
                     */
                        boolean num_11infoCenter=Verification.CheckIsExistInfoCenter(conn, driver, url, username, password,"11");
                        if(num_11infoCenter==false){
                            String sql="INSERT INTO `info_center` VALUES ('11', '11', '待办公文', 'To do document', '待辦公文', '', '', '3003');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-02-07  高亚峰
                         *  作用: 修改活动类别数据类型
                         */
                        boolean checkIsExistfield2 = Verification.CheckIsExistfield(conn, driver, url, username, password, "schedule", "schedule_type");
                        if(checkIsExistfield2==true){
                            String sql="ALTER TABLE `schedule`MODIFY COLUMN `schedule_type`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '活动类别' AFTER `create_time`;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                           /*  2018-02-28 高亚峰
                     *  修改表名称
                     */
                        boolean checkIsExistportals=Verification.CheckIsExistTable(conn, driver, url, username, password,"portals1");
                        if(checkIsExistportals==false){
                            String sql="alter table portals rename portals1";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /*  2018-02-28 高亚峰
                     *      创建表portals
                     */
                        boolean checkIsExistportals2=Verification.CheckIsExistTable(conn, driver, url, username, password,"portals");
                        if(checkIsExistportals2==false){
                            String sql="CREATE TABLE IF NOT EXISTS `portals` (\n" +
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
                                    "  PRIMARY KEY (`portals_id`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-03-01  高亚峰
                         *  作用: 修改活动类别数据类型
                         */
                        boolean checkIsExistPriv = Verification.CheckIsExistfield(conn, driver, url, username, password, "portals", "access_priv");
                        if(checkIsExistPriv==false){
                            String sql="alter table `portals` add access_priv int(1) DEFAULT '0' comment'是否授权（0所有人1指定授权）'";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-03-01  高亚峰
                         *  作用: 修改活动类别数据类型
                         */
                        boolean CheckIsExistPara = Verification.CheckIsExistParam(conn, driver, url, username, password,  "PORTALS_TIME");
                        if(CheckIsExistPara==false){
                            String sql="INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('PORTALS_TIME', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-3-2  高亚峰
                         *  作用:  添加字段的作用: 修改办公用品字段类型
                         */
                        boolean IsExistfiled = Verification.CheckIsExistfield(conn, driver, url, username, password, "office_products", "PRO_ORDER");
                        if (IsExistfiled == true) {
                            String sql = "ALTER TABLE office_products  MODIFY COLUMN PRO_ORDER VARCHAR(11)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-3-2  高亚峰
                         *  作用:  添加字段的作用: 修改培训预算字段
                         */
                        boolean IsExistfiled_1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "edu_training_plan", "T_BCWS");
                        if (IsExistfiled_1 == true) {
                            String sql = "ALTER TABLE edu_training_plan  MODIFY COLUMN T_BCWS decimal(65)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-3-5  高亚峰
                         *  作用:  添加字段的作用: 自增por内置数据
                         */
                     /*   boolean por_1 = Verification.CheckIsExistPor(conn, driver, url, username, password, "1");
                        if (por_1 == false) {
                            String sql = "INSERT INTO `portals` VALUES ('1', '1', '内网门户', '0', '', '', '1', '', '', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
                        /**
                         * 2018-3-5  高亚峰
                         *  作用:  添加字段的作用: 自增por内置数据
                         */
                        boolean por_2 = Verification.CheckIsExistPor(conn, driver, url, username, password, "2");
                        if (por_2 == false) {
                            String sql = "INSERT INTO `portals` VALUES ('2', '2', '工作门户', '0', '', '', '1', '', '', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-3-5  高亚峰
                         *  作用:  添加字段的作用: 自增por内置数据
                         */
                        boolean por_3 = Verification.CheckIsExistPor(conn, driver, url, username, password, "3");
                        if (por_3 == false) {
                            String sql = "INSERT INTO `portals` VALUES ('3', '3', '应用门户', '0', '', '', '1', '', '', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         * 2018-3-5  高亚峰
                         *  作用:  添加字段的作用: 自增por内置数据
                         */
                   /*     boolean por_4 = Verification.CheckIsExistPor(conn, driver, url, username, password, "4");
                        if (por_4 == false) {
                            String sql = "INSERT INTO `portals` VALUES ('4', '4', '管理门户', '0', '', '', '1', '', '', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }*/
                        /** 2018-03-05  高亚峰
                         *  作用: 增加二级菜单数据
                         */
                        boolean function1 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2042");
                        if (function1 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('2042', 'z070', '短信设置', 'SMS settings', '簡訊設定', '', '', '', 'smsSettings/index', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /** 2018-03-05  高亚峰
                         *  作用: 增加二级菜单数据
                         */
                        boolean function2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2047");
                        if (function2 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('2047', 'z032', '门户设置', 'Portal settings', '門戶設定', null, null, null, 'portals/index', '', '0')";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  2018-03-14 高亚峰
                     *      创建表document_org
                     */
                        boolean table_exist=Verification.CheckIsExistTable(conn, driver, url, username, password,"document_org");
                        if(table_exist == false){
                            String sql="CREATE TABLE IF NOT EXISTS `document_org` (\n" +
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
                        }

                              /*   *
                     *  添加字段的作用: 创建sms_settings表
                     *  创建日期：2018-03-15
                     */
                        boolean isExistTable_6=Verification.CheckIsExistTable(conn, driver, url, username, password,"sms_settings");
                        if(isExistTable_6==false){
                            String sql="CREATE TABLE IF NOT EXISTS `sms_settings` (\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',\n" +
                                    "  `NAME` varchar(255) DEFAULT NULL COMMENT '网关名称',\n" +
                                    "  `PROTOCOL` varchar(255) DEFAULT NULL COMMENT '协议',\n" +
                                    "  `HOST` varchar(255) DEFAULT NULL COMMENT '主机',\n" +
                                    "  `PORT` varchar(255) DEFAULT '' COMMENT '接口',\n" +
                                    "  `USERNAME` varchar(255) DEFAULT '' COMMENT '账号参数名',\n" +
                                    "  `PWD` varchar(255) DEFAULT NULL COMMENT '密码参数名',\n" +
                                    "  `CONTENT_FIELD` varchar(255) DEFAULT NULL COMMENT '内容字段参数名',\n" +
                                    "  `CODE` varchar(255) DEFAULT NULL COMMENT '内容编码参数名',\n" +
                                    "  `MOBILE` varchar(255) DEFAULT NULL COMMENT '接收号码参数名',\n" +
                                    "  `TIME_CONTENT` varchar(20) DEFAULT NULL,\n" +
                                    "  `SIGN` varchar(255) DEFAULT NULL COMMENT '签名参数名',\n" +
                                    "  `LOCATION` varchar(100) DEFAULT NULL COMMENT '签名位置',\n" +
                                    "  `EXTEND_1` varchar(255) DEFAULT '' COMMENT '扩展参数1:',\n" +
                                    "  `EXTEND_2` varchar(255) DEFAULT NULL COMMENT '扩展参数2:',\n" +
                                    "  `EXTEND_3` varchar(255) DEFAULT NULL COMMENT '扩展参数3',\n" +
                                    "  `EXTEND_4` varchar(255) DEFAULT NULL COMMENT '扩展参数4',\n" +
                                    "  `EXTEND_5` varchar(255) DEFAULT NULL COMMENT '扩展参数5',\n" +
                                    "  `STATE` varchar(100) DEFAULT '' COMMENT '状态',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                         /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_1 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "OP_FLAG");
                        if(index_1==false){
                            String sql="ALTER TABLE `flow_run_prcs` ADD INDEX OP_FLAG (`OP_FLAG`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                            /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_2 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "TIME_OUT_FLAG");
                        if(index_2==false){
                            String sql="ALTER TABLE `flow_run_prcs` ADD INDEX TIME_OUT_FLAG (`TIME_OUT_FLAG`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                            /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_3 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "CHILD_RUN");
                        if(index_3==false){
                            String sql="ALTER TABLE `flow_run_prcs` ADD INDEX CHILD_RUN (`CHILD_RUN`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                            /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_4 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run_prcs", "TIME_OUT");
                        if(index_4==false){
                            String sql="ALTER TABLE `flow_run_prcs` ADD INDEX TIME_OUT (`TIME_OUT`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_5 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "file_sort", "SORT_TYPE");
                        if(index_5==false){
                            String sql="ALTER TABLE `file_sort` ADD INDEX SORT_TYPE (`SORT_TYPE`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_6 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "flow_run", "DEL_FLAG");
                        if(index_6==false){
                            String sql="ALTER TABLE `flow_run` ADD INDEX DEL_FLAG (`DEL_FLAG`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_7 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "user", "DEPT_ID_OTHER");
                        if(index_7==false){
                            String sql="ALTER TABLE `user` ADD INDEX DEPT_ID_OTHER (`DEPT_ID_OTHER`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_8 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "file_content", "CREATER");
                        if(index_8==false){
                            String sql="ALTER TABLE `file_content` ADD INDEX CREATER (`CREATER`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_9 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "email", "READ_FLAG");
                        if(index_9==false){
                            String sql="ALTER TABLE `email` ADD INDEX READ_FLAG (`READ_FLAG`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_10 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_config", "DUTY_TYPE");
                        if(index_10==false){
                            String sql="ALTER TABLE `attend_config` ADD INDEX DUTY_TYPE (`DUTY_TYPE`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                   /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_11 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend", "UID");
                        if(index_11==false){
                            String sql="ALTER TABLE `attend` ADD INDEX UID (`UID`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                                   /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_12 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend", "DATE");
                        if(index_12==false){
                            String sql="ALTER TABLE `attend` ADD INDEX DATE (`DATE`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                                    /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_20 = Verification.CheckIsExistfield(conn, driver, url, username, password, "attendance_overtime", "RUN_ID");
                        if(index_20==false){
                            String sql="alter table `attendance_overtime` add RUN_ID int(11) comment'流程实例ID';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }




                        /**
                         *  作用: 增加索引
                         *  创建日期:2018-03-16
                         *  创建者：高亚峰
                         */
                        boolean index_13 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attendance_overtime", "RUN_ID");
                        if(index_13==false){
                            String sql="ALTER TABLE `attendance_overtime` ADD INDEX RUN_ID (`RUN_ID`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_14 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attendance_overtime", "ALLOW");
                        if(index_14==false){
                            String sql="ALTER TABLE `attendance_overtime` ADD INDEX ALLOW (`ALLOW`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_15 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "news", "PUBLISH");
                        if(index_15==false){
                            String sql="ALTER TABLE `news` ADD INDEX PUBLISH (`PUBLISH`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_16 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_evection", "RUN_ID");
                        if(index_16==false){
                            String sql="ALTER TABLE `attend_evection` ADD INDEX RUN_ID (`RUN_ID`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_17 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_evection", "ALLOW");
                        if(index_17==false){
                            String sql="ALTER TABLE `attend_evection` ADD INDEX ALLOW (`ALLOW`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_18 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_leave", "RUN_ID");
                        if(index_18==false){
                            String sql="ALTER TABLE `attend_leave` ADD INDEX RUN_ID (`RUN_ID`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_19 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_leave", "ALLOW");
                        if(index_19==false){
                            String sql="ALTER TABLE `attend_leave` ADD INDEX ALLOW (`ALLOW`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_30 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_out", "RUN_ID");
                        if(index_30==false){
                            String sql="ALTER TABLE `attend_out` ADD INDEX RUN_ID (`RUN_ID`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                           /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean index_21 = Verification.CheckIsExistIndex(conn, driver, url, username, password, "attend_out", "ALLOW");
                        if(index_21==false){
                            String sql="ALTER TABLE `attend_out` ADD INDEX ALLOW (`ALLOW`)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                              /*  *
                     *  作用: 增加索引
                     *  创建日期:2018-03-16
                     *  创建者：高亚峰
                     */
                        boolean isExistfield1  = Verification.CheckIsExistfield(conn, driver, url, username, password, "department","DEPT_CODE");
                        if(isExistfield1==false){
                            String sql="ALTER TABLE department ADD DEPT_CODE VARCHAR(255) comment '部门编码'";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }




                         /*   *
                     *  添加字段的作用: 教育项目-创建school_roll_info学籍表
                     */
                        boolean isExistTable_7=Verification.CheckIsExistTable(conn, driver, url, username, password,"school_roll_info");
                        if(isExistTable_7==false){
                            String sql="CREATE TABLE IF NOT EXISTS `school_roll_info` (\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                    "  `SCHOOL_ID` varchar(255) DEFAULT NULL COMMENT '学校标识码',\n" +
                                    "  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',\n" +
                                    "  `SEX` varchar(255) DEFAULT NULL COMMENT '性别',\n" +
                                    "  `BRITH` date DEFAULT NULL COMMENT '出生日期',\n" +
                                    "  `DISTRICT_NO` varchar(255) DEFAULT NULL COMMENT '出生地行政区划代码',\n" +
                                    "  `ORIGIN` varchar(255) DEFAULT NULL COMMENT '籍贯',\n" +
                                    "  `NATION` varchar(255) DEFAULT NULL COMMENT '民族',\n" +
                                    "  `NATIONALITY` varchar(255) DEFAULT NULL COMMENT '国籍/地区',\n" +
                                    "  `CARD_TYPE` varchar(255) DEFAULT NULL COMMENT '身份证件类型',\n" +
                                    "  `REGION` varchar(255) DEFAULT NULL COMMENT '港澳台侨外',\n" +
                                    "  `HEALTH` varchar(255) DEFAULT NULL COMMENT '健康状况',\n" +
                                    "  `POLITICAL` varchar(255) DEFAULT NULL COMMENT '政治面貌',\n" +
                                    "  `CARD_ID` varchar(255) DEFAULT NULL COMMENT '身份证件号',\n" +
                                    "  `REGISTRATION` varchar(255) DEFAULT NULL COMMENT '户口性质',\n" +
                                    "  `REGISTR_DISTRICT` varchar(255) DEFAULT NULL COMMENT '户口所在地行政区划',\n" +
                                    "  `CLASS_ID` varchar(255) DEFAULT NULL COMMENT '班号',\n" +
                                    "  `ENTRANCE_DATE` date DEFAULT NULL COMMENT '入学年月',\n" +
                                    "  `ENTRANCE_WAY` varchar(255) DEFAULT NULL COMMENT '入学方式',\n" +
                                    "  `STUDY_WAY` varchar(255) DEFAULT NULL COMMENT '就读方式',\n" +
                                    "  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '现住址',\n" +
                                    "  `MAIL_ADDRESS` varchar(255) DEFAULT NULL COMMENT '通信地址',\n" +
                                    "  `HOMR_ADDRESS` varchar(255) DEFAULT NULL COMMENT '家庭地址',\n" +
                                    "  `PHONE` varchar(255) DEFAULT NULL COMMENT '联系电话',\n" +
                                    "  `POSTAL_CODE` varchar(255) DEFAULT NULL COMMENT '邮政编码',\n" +
                                    "  `ONLY_CHILD` varchar(255) DEFAULT NULL COMMENT '是否独生子女',\n" +
                                    "  `PRE_EDUCATION` varchar(255) DEFAULT NULL COMMENT '是否受过学前教育',\n" +
                                    "  `LEFT_CHILD` varchar(255) DEFAULT NULL COMMENT '是否留守儿童',\n" +
                                    "  `APPLIED_FUND` varchar(255) DEFAULT NULL COMMENT '是否需要申请资助',\n" +
                                    "  `SUPPLEMENT` varchar(255) DEFAULT NULL COMMENT '是否享受一补',\n" +
                                    "  `ORPHAN` varchar(255) DEFAULT NULL COMMENT '是否孤儿',\n" +
                                    "  `MARTYRS_CHILD` varchar(255) DEFAULT NULL COMMENT '是否烈士或优抚子女',\n" +
                                    "  `GO_DISTANCE` varchar(255) DEFAULT NULL COMMENT '上下学距离',\n" +
                                    "  `GO_WAY` varchar(255) DEFAULT NULL COMMENT '上下学方式',\n" +
                                    "  `TAKE_BUS` varchar(255) DEFAULT NULL COMMENT '是否需要乘坐校车',\n" +
                                    "  `PRE_NAME` varchar(255) DEFAULT NULL COMMENT '曾用名',\n" +
                                    "  `CARD_VALI_DATE` varchar(255) DEFAULT NULL COMMENT '身份证件有效期',\n" +
                                    "  `BLOOD_TYPE` varchar(255) DEFAULT NULL COMMENT '血型',\n" +
                                    "  `SPECIALTY` varchar(255) DEFAULT NULL COMMENT '特长',\n" +
                                    "  `AUXILIARY_NUM` varchar(255) DEFAULT NULL COMMENT '学籍辅号',\n" +
                                    "  `STU_NO` varchar(255) DEFAULT NULL COMMENT '班内学号',\n" +
                                    "  `STU_SOURCE` varchar(255) DEFAULT NULL COMMENT '学生来源',\n" +
                                    "  `E_MAIL` varchar(255) DEFAULT NULL COMMENT '电子信箱',\n" +
                                    "  `HOME_PAGE` varchar(255) DEFAULT NULL COMMENT '主页地址',\n" +
                                    "  `DISABILITY_TYPE` varchar(255) DEFAULT NULL COMMENT '残疾类型',\n" +
                                    "  `GOVERN_DEGREE` varchar(255) DEFAULT NULL COMMENT '是否由政府购买学位',\n" +
                                    "  `REGULAR_STUDY` varchar(255) DEFAULT NULL COMMENT '随班就读',\n" +
                                    "  `HIDDEN` varchar(255) DEFAULT NULL COMMENT '隐藏',\n" +
                                    "  `MEMBER1_NAME` varchar(255) DEFAULT NULL COMMENT '成员1姓名',\n" +
                                    "  `MEMBER1_RELATION` varchar(255) DEFAULT NULL COMMENT '成员1关系',\n" +
                                    "  `MEMBER1_RELATION_DESC` varchar(255) DEFAULT NULL COMMENT '成员1关系说明',\n" +
                                    "  `MEMBER1_ADDRESS` varchar(255) DEFAULT NULL COMMENT '成员1现住址',\n" +
                                    "  `MEMBER1_DISTRICT` varchar(255) DEFAULT NULL COMMENT '成员1户口所在地行政区划',\n" +
                                    "  `MEMBER1_PHONE` varchar(255) DEFAULT NULL COMMENT '成员1联系电话',\n" +
                                    "  `MEMBER1_KEEPER` varchar(255) DEFAULT NULL COMMENT '成员1是否监护人',\n" +
                                    "  `MEMBER1_CARD_TYPE` varchar(255) DEFAULT NULL COMMENT '成员1身份证件类型',\n" +
                                    "  `MEMBER1_CARD_ID` varchar(255) DEFAULT NULL COMMENT '成员1身份证件号',\n" +
                                    "  `MEMBER1_NATION` varchar(255) DEFAULT NULL COMMENT '成员1民族',\n" +
                                    "  `MEMBER1_WORKPLACE` varchar(255) DEFAULT NULL COMMENT '成员1工作单位',\n" +
                                    "  `MEMBER1_POST` varchar(255) DEFAULT NULL COMMENT '成员1职务',\n" +
                                    "  `MEMBER2_NAME` varchar(255) DEFAULT NULL COMMENT '成员2姓名',\n" +
                                    "  `MEMBER2_RELATION` varchar(255) DEFAULT NULL COMMENT '成员2关系',\n" +
                                    "  `MEMBER2_RELATION_DESC` varchar(255) DEFAULT NULL COMMENT '成员2关系说明',\n" +
                                    "  `MEMBER2_ADDRESS` varchar(255) DEFAULT NULL COMMENT '成员2现住址',\n" +
                                    "  `MEMBER2_DISTRICT` varchar(255) DEFAULT NULL COMMENT '成员2户口所在地行政区划',\n" +
                                    "  `MEMBER2_PHONE` varchar(255) DEFAULT NULL COMMENT '成员2联系电话',\n" +
                                    "  `MEMBER2_KEEPER` varchar(255) DEFAULT NULL COMMENT '成员2是否监护人',\n" +
                                    "  `MEMBER2_CARD_TYPE` varchar(255) DEFAULT NULL COMMENT '成员2身份证件类型',\n" +
                                    "  `MEMBER2_CARD_ID` varchar(255) DEFAULT NULL COMMENT '成员2身份证件号',\n" +
                                    "  `MEMBER2_NATION` varchar(255) DEFAULT NULL COMMENT '成员2民族',\n" +
                                    "  `MEMBER2_WORKPLACE` varchar(255) DEFAULT NULL COMMENT '成员2工作单位',\n" +
                                    "  `MEMBER2_POST` varchar(255) DEFAULT NULL COMMENT '成员2职务',\n" +
                                    "  `MIGRANT_CHILD` varchar(255) DEFAULT NULL COMMENT '是否进城务工人员随迁子女',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='学籍信息';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                               /*   *
                     *  添加字段的作用: 教育项目-创建teacher_info教师信息表
                     */
                        boolean isExistTable_8=Verification.CheckIsExistTable(conn, driver, url, username, password,"teacher_info");
                        if(isExistTable_8==false){
                            String sql="CREATE TABLE IF NOT EXISTS `teacher_info` (\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增递减',\n" +
                                    "  `NAME` varchar(255) DEFAULT NULL COMMENT '姓名',\n" +
                                    "  `PRE_NAME` varchar(255) DEFAULT NULL COMMENT '曾用名',\n" +
                                    "  `NATION` varchar(255) DEFAULT NULL COMMENT '民族',\n" +
                                    "  `SEX` char(11) DEFAULT NULL COMMENT '性别',\n" +
                                    "  `ID_CARD_TYPE` varchar(255) DEFAULT NULL COMMENT '身份证件类型',\n" +
                                    "  `ID_CARD` varchar(255) DEFAULT NULL COMMENT '身份证号',\n" +
                                    "  `SSXX` varchar(255) DEFAULT NULL COMMENT '所属学校',\n" +
                                    "  `SSXX_NO` varchar(255) DEFAULT NULL COMMENT '学校标识码',\n" +
                                    "  `JOB_STARTIME` date DEFAULT NULL COMMENT '参加工作时间',\n" +
                                    "  `POLITICAL` varchar(255) DEFAULT NULL COMMENT '政治面貌',\n" +
                                    "  `POHNE` varchar(255) DEFAULT NULL COMMENT '联系电话',\n" +
                                    "  `POST_CATE` varchar(255) DEFAULT NULL COMMENT '岗位分类',\n" +
                                    "  `POST` varchar(255) DEFAULT NULL COMMENT '岗位学段',\n" +
                                    "  `BIRTH` date DEFAULT NULL COMMENT '出生日期',\n" +
                                    "  `ORIGIN` varchar(255) DEFAULT NULL COMMENT '户口所在地',\n" +
                                    "  `ADDRESS` varchar(255) DEFAULT NULL COMMENT '家庭地址',\n" +
                                    "  `POSTAL_ADDRESS` varchar(255) DEFAULT NULL COMMENT '通讯地址',\n" +
                                    "  `EMAIL` varchar(255) DEFAULT NULL COMMENT '电子邮箱',\n" +
                                    "  `IS_INSERIES` char(11) DEFAULT NULL COMMENT '是否在编（0是1否）',\n" +
                                    "  `IS_INPOST` char(11) DEFAULT NULL COMMENT '是否在岗（0是1否）',\n" +
                                    "  `HEIGHEST_DEGREE` varchar(255) DEFAULT NULL COMMENT '最高学位',\n" +
                                    "  `HEIGHEST_DEGREE_NAME` varchar(255) DEFAULT NULL COMMENT '最高学位名称',\n" +
                                    "  `HEIGHEST_EDU` varchar(255) DEFAULT NULL COMMENT '最高学历',\n" +
                                    "  `HEIGHEST_EDU_MAJOR` varchar(255) DEFAULT NULL COMMENT '最高学历专业',\n" +
                                    "  `MAJOR_DATE` date DEFAULT NULL COMMENT '最高学历获得时间',\n" +
                                    "  `MAJOR_EDU_SCHOOL` varchar(255) DEFAULT NULL COMMENT '最高学历毕业院校',\n" +
                                    "  `FIRST_EDU` varchar(255) DEFAULT NULL COMMENT '第一学历',\n" +
                                    "  `FIRST_EDU_MAJOR` varchar(255) DEFAULT NULL COMMENT '第一学历专业',\n" +
                                    "  `FIRST_EDU_DATE` date DEFAULT NULL COMMENT '第一学历获得日期',\n" +
                                    "  `FIRST_EDU_SCHOOL` varchar(255) DEFAULT NULL COMMENT '第一学历毕业院校',\n" +
                                    "  `TEACHER_BOOK_TYPE` varchar(255) DEFAULT NULL COMMENT '教师资格证书类型',\n" +
                                    "  `TEACHER_BOOK_NO` varchar(255) DEFAULT NULL COMMENT '教师资格证书编号',\n" +
                                    "  `GET_HSKBOOK_GRADE` varchar(255) DEFAULT NULL COMMENT '取得HSK证书等级',\n" +
                                    "  `HSKBOOK_DATE` date DEFAULT NULL COMMENT 'HSK证书获得日期',\n" +
                                    "  `GET_MHKBOOK_GRADE` varchar(255) DEFAULT NULL COMMENT '取得MHK证书等级',\n" +
                                    "  `MHKBOOK_DATE` date DEFAULT NULL COMMENT 'MHK证书获得日期',\n" +
                                    "  `PUTONGHUA_LEVEL` varchar(255) DEFAULT NULL COMMENT '普通话证书水平等级',\n" +
                                    "  `PUTONGHUA_DATE` date DEFAULT NULL COMMENT '普通话证书获得日期',\n" +
                                    "  `START_TEACHING_DATE` date DEFAULT NULL COMMENT '开始任教日期',\n" +
                                    "  `POST_EMEPLOY_TECHNICAL` varchar(255) DEFAULT NULL COMMENT '岗位聘任技术职务',\n" +
                                    "  `PROFESSIONAL_POST` varchar(255) DEFAULT NULL COMMENT '岗位专业技术职务',\n" +
                                    "  `TEACHING_SECTION` varchar(255) DEFAULT NULL COMMENT '现任主要教学段',\n" +
                                    "  `TEACHING_GRADE` varchar(255) DEFAULT NULL COMMENT '现任主要年级',\n" +
                                    "  `TEACHING_SUBJECT` varchar(255) DEFAULT NULL COMMENT '现任主要教学科',\n" +
                                    "  `NOTEACH_REASION` varchar(255) DEFAULT NULL COMMENT '专任教师不任课原因',\n" +
                                    "  `TEACH_LANGUAGE` varchar(255) DEFAULT NULL COMMENT '现任教语言',\n" +
                                    "  `IS_NATIONTEACHER` char(11) DEFAULT NULL COMMENT '是否为民语普通班授课教师（0是1否）',\n" +
                                    "  `IS_CHINESETEACHER` char(11) DEFAULT NULL COMMENT '是否汉语普通班授课教师（0是1否）',\n" +
                                    "  `IS_DOUBLETEACHER` char(11) DEFAULT NULL COMMENT '是否双语教师',\n" +
                                    "  `DOUBLE_TEACH_MODEL` varchar(255) DEFAULT NULL COMMENT '双语授课模式',\n" +
                                    "  `IS_ABILITY` char(11) DEFAULT NULL COMMENT '是否具备国家通用语言授课能力',\n" +
                                    "  `IS_ETHNIC_TEACHER` char(11) DEFAULT NULL COMMENT '是否为少数民族母语教师',\n" +
                                    "  `IS_SPECIALLEVEL_TEACHER` char(11) DEFAULT NULL COMMENT '是否为特岗教师',\n" +
                                    "  `IS_SPECIAL_TRAIN` char(11) DEFAULT NULL COMMENT '是否受过特教专业培训',\n" +
                                    "  `SITUATION` varchar(255) DEFAULT NULL COMMENT '港澳台情况',\n" +
                                    "  `IS_BACKONE_TEACHER` char(11) DEFAULT NULL COMMENT '是否是县级及以上骨干教师',\n" +
                                    "  `STAFF_INCREASE` varchar(255) DEFAULT NULL COMMENT '教职工变动（增加）',\n" +
                                    "  `STAFF_DECREASE` varchar(255) DEFAULT NULL COMMENT '教职工变动（减少)',\n" +
                                    "  `PERSON_CODE` varchar(255) DEFAULT NULL COMMENT '个人标识码',\n" +
                                    "  `STAFF_NUMBER` varchar(255) DEFAULT NULL COMMENT '教职工号',\n" +
                                    "  `NATION_AREA` varchar(255) DEFAULT NULL COMMENT '国籍/地区',\n" +
                                    "  `BIRTH_AREA` varchar(255) DEFAULT NULL COMMENT '出生地',\n" +
                                    "  `MARITAL_STATUS` varchar(255) DEFAULT NULL COMMENT '婚姻状态',\n" +
                                    "  `HEALTH` varchar(255) DEFAULT NULL COMMENT '健康状况',\n" +
                                    "  `JOIN_SCHOOL_TIME` date DEFAULT NULL COMMENT '进入学校时间',\n" +
                                    "  `STAFF_SOURCE` varchar(255) DEFAULT NULL COMMENT '教职工来源',\n" +
                                    "  `STAFF_TYPE` varchar(255) DEFAULT NULL COMMENT '教职工类别',\n" +
                                    "  `HUMAN_FORM` varchar(255) DEFAULT NULL COMMENT '用人形式',\n" +
                                    "  `CONTRACT_SIGN` varchar(255) DEFAULT NULL COMMENT '签订合同情况',\n" +
                                    "  `NOW_POST_LEVEL` varchar(255) DEFAULT NULL COMMENT '现任岗位等级',\n" +
                                    "  `IS_FULLTIME_GRD` char(11) DEFAULT NULL COMMENT '是否全日制毕业',\n" +
                                    "  `IS_SPECIAL_EDU_BOOK` char(11) DEFAULT NULL COMMENT '是否有特殊教育从业证书',\n" +
                                    "  `APPLICATION_ABILITY` varchar(255) DEFAULT NULL COMMENT '信息技术应用能力',\n" +
                                    "  `IS_FREE_STUDENT` char(11) DEFAULT NULL COMMENT '是否是免费（公费）师范生',\n" +
                                    "  `IS_PART_EDU` char(11) DEFAULT NULL COMMENT '是否参加基层教育',\n" +
                                    "  `PART_EDU_STARTIME` date DEFAULT NULL COMMENT '参加基层服务项目起始时间',\n" +
                                    "  `PART_EDU_ENDTIME` date DEFAULT NULL COMMENT '参加基层服务项目结束时间',\n" +
                                    "  `IS_SPECIALPOST_TEACHER` char(11) DEFAULT NULL COMMENT '是否是特级教师',\n" +
                                    "  `IS_HEART_HEALTH_TEACH` char(11) DEFAULT NULL COMMENT '是否是心里健康教师',\n" +
                                    "  `PERSON_STATUS` varchar(255) DEFAULT NULL COMMENT '人员状态',\n" +
                                    "  `CREATE_TIME` date DEFAULT NULL COMMENT '创建时间',\n" +
                                    "  `UPDATE_TIME` date DEFAULT NULL COMMENT '更新时间',\n" +
                                    "  `NOW_BUSINESS` varchar(255) DEFAULT NULL COMMENT '当前业务',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                               /*   *
                     *  添加字段的作用: 教育项目-创建school_priv教师信息表
                     */
                        boolean isExistTable_9=Verification.CheckIsExistTable(conn, driver, url, username, password,"school_priv");
                        if(isExistTable_9==false){
                            String sql="CREATE TABLE IF NOT EXISTS `school_priv` (\n" +
                                    "  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',\n" +
                                    "  `PERSON_UID` varchar(255) DEFAULT NULL COMMENT '人员uid',\n" +
                                    "  `SHCOOL_NUM` varchar(255) DEFAULT NULL COMMENT '所管学校标识码',\n" +
                                    "  `MODULAR_ID` varchar(255) DEFAULT NULL COMMENT '模块id(1代表教师权限，2代表学籍查询权限，3代表学籍管理权限)',\n" +
                                    "  PRIMARY KEY (`ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='教育权限表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加二级菜单数据-学籍管理
                         */
                        boolean function3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5005");
                        if (function3 == false) {
                            String sql = "INSERT INTO `sys_function`  VALUES ('5005', 'c035', '学籍管理', NULL, NULL, NULL, NULL, NULL, '@xjgl', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-学籍信息查询
                         */
                        boolean function4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5007");
                        if (function4 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5007', 'c03501', '学籍信息查询', NULL, NULL, NULL, NULL, NULL, 'schoolRoll/schoolQuery', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-学籍信息管理
                         */
                        boolean function5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5008");
                        if (function5 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5008', 'c03503', '学籍信息管理', NULL, NULL, NULL, NULL, NULL, 'schoolRoll/index', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 22018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-权限设置
                         */
                        boolean function6 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5009");
                        if (function6 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5009', 'c03505', '权限设置', NULL, NULL, NULL, NULL, NULL, 'schoolRoll/schoolSeting', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 22018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-权限设置
                         */
                        boolean function7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5016");
                        if (function7 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5016', 'c03504', '学籍变更', NULL, NULL, NULL, NULL, NULL, 'schoolRoll/rollindex', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加二级菜单数据-人事管理
                         */
                        boolean function8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5006");
                        if (function8 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5006', 'c038', '人事管理', NULL, NULL, NULL, NULL, NULL, '@rsgl', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-教师信息查询
                         */
                        boolean function9 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5010");
                        if (function9 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5010', 'c03801', '教师信息查询', NULL, NULL, NULL, NULL, NULL, 'teachering/teacherQuery', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-教师信息管理
                         */
                        boolean function10 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5011");
                        if (function10 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5011', 'c03802', '教师信息管理', NULL, NULL, NULL, NULL, NULL, 'teachering/index', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 2018-03-16  牛江丽
                         *  作用: 增加三级菜单数据-权限设置
                         */
                        boolean function11 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "5012");
                        if (function11 == false) {
                            String sql = "INSERT INTO `sys_function` VALUES ('5012', 'c03803', '权限设置', NULL, NULL, NULL, NULL, NULL, 'teachering/teacherSeting', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                           /*   *
                     *  添加字段的作用: 报表设置表
                     */
                        boolean table_exist1=Verification.CheckIsExistTable(conn, driver, url, username, password,"senior_re_cat");
                        if(table_exist1==false){
                            String sql="CREATE TABLE IF NOT EXISTS `senior_re_cat` (\n" +
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
                        boolean isExistTable_13=Verification.CheckIsExistTable(conn, driver, url, username, password,"hr_staff_contract");
                        if(isExistTable_13==false){
                            String sql="CREATE TABLE IF NOT EXISTS `hr_staff_contract` (\n" +
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
                     /* *
                     *  添加表: 社区信息表wechat
                     */
                        boolean isExistTable_14=Verification.CheckIsExistTable(conn, driver, url, username, password,"wechat");
                        if(isExistTable_14==false){
                            String sql="CREATE TABLE IF NOT EXISTS `wechat` (\n" +
                                    "  `WID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '发讯人',\n" +
                                    "  `MESSAGE` text CHARACTER SET utf8 NOT NULL COMMENT '发讯内容',\n" +
                                    "  `STIME` int(10) NOT NULL COMMENT '发讯时间',\n" +
                                    "  `LIKE_IDS` varchar(5000) CHARACTER SET gbk DEFAULT '' COMMENT '点赞的UIDS串',\n" +
                                    "  `FILE_ID` text CHARACTER SET gbk COMMENT '附件ID串',\n" +
                                    "  `FILE_NAME` text CHARACTER SET gbk COMMENT '附件名字',\n" +
                                    "  `APP` varchar(50) CHARACTER SET gbk DEFAULT 'wechat' COMMENT '此条消息来自于哪个模块',\n" +
                                    "  `APP_ID` int(11) DEFAULT NULL COMMENT '关联业务模块的数据ID',\n" +
                                    "  `TOPICS` varchar(255) CHARACTER SET gbk DEFAULT NULL COMMENT '话题的ID串',\n" +
                                    "  `TOPICS_NAME` varchar(1000) CHARACTER SET gbk DEFAULT NULL COMMENT '话题的名称',\n" +
                                    "  `AT_UIDS` varchar(2000) CHARACTER SET gbk DEFAULT NULL COMMENT '@人员的UID串',\n" +
                                    "  `MESSAGE_UNI` text CHARACTER SET gbk,\n" +
                                    "  PRIMARY KEY (`WID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='微讯信息表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                     /* *
                     *  添加表: 社区评论表
                     */
                        boolean isExistTable_15=Verification.CheckIsExistTable(conn, driver, url, username, password,"wechat_comment");
                        if(isExistTable_15==false){
                            String sql="CREATE TABLE IF NOT EXISTS `wechat_comment` (\n" +
                                    "  `CID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `WID` int(11) unsigned NOT NULL COMMENT '微博ID',\n" +
                                    "  `UID` int(11) NOT NULL COMMENT '点评用户的UID',\n" +
                                    "  `MESSAGE` text CHARACTER SET utf8 NOT NULL COMMENT '点评内容 ',\n" +
                                    "  `STIME` int(11) NOT NULL COMMENT '点评保存时间',\n" +
                                    "  `MESSAGE_UNI` text COMMENT '内容unicode存储',\n" +
                                    "  PRIMARY KEY (`CID`),\n" +
                                    "  KEY `USER_ID` (`UID`),\n" +
                                    "  KEY `ID_TIME` (`WID`,`STIME`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT COMMENT='微讯评论表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                      /* *
                     *  添加表: 社区评论回复表
                     */
                        boolean isExistTable_16=Verification.CheckIsExistTable(conn, driver, url, username, password,"wechat_comment_reply");
                        if(isExistTable_16==false){
                            String sql="CREATE TABLE IF NOT EXISTS `wechat_comment_reply` (\n" +
                                    "  `RID` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `MESSAGE` text NOT NULL COMMENT '回复内容',\n" +
                                    "  `RTIME` int(11) NOT NULL COMMENT '回复时间',\n" +
                                    "  `UID` int(11) NOT NULL COMMENT '回复人',\n" +
                                    "  `CID` int(11) unsigned NOT NULL COMMENT '评论ID',\n" +
                                    "  `TID` int(11) NOT NULL COMMENT '评论的对象',\n" +
                                    "  `WID` int(11) NOT NULL COMMENT '微讯ID',\n" +
                                    "  `MESSAGE_UNI` text COMMENT '内容unicode存储',\n" +
                                    "  PRIMARY KEY (`RID`),\n" +
                                    "  KEY `ID_TIME` (`CID`,`RTIME`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=gbk ROW_FORMAT=COMPACT COMMENT='微讯评论回复表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                       /* *
                     *  添加表:社区话题表
                     */
                        boolean isExistTable_17=Verification.CheckIsExistTable(conn, driver, url, username, password,"wechat_topic");
                        if(isExistTable_17==false){
                            String sql="CREATE TABLE IF NOT EXISTS `wechat_topic` (\n" +
                                    "  `TOPIC_ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '话题自增ID',\n" +
                                    "  `TOPIC_NAME` varchar(255) NOT NULL DEFAULT '' COMMENT '话题名称',\n" +
                                    "  `TAKER_UIDS` varchar(2000) NOT NULL DEFAULT '' COMMENT '参与该话题的UID串',\n" +
                                    "  `COUNT` int(10) NOT NULL COMMENT '话题次数',\n" +
                                    "  PRIMARY KEY (`TOPIC_ID`)\n" +
                                    ") ENGINE=InnoDB DEFAULT CHARSET=gbk COMMENT='社区话题表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                        /** 作者：高亚峰
                         * 添加表:邮件设置表
                         */
                        boolean isExistTable_18=Verification.CheckIsExistTable(conn, driver, url, username, password,"email_set");
                        if(isExistTable_18==false){
                            String sql="CREATE TABLE IF NOT EXISTS `email_set` (\n" +
                                    "  `ESS_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '邮件发送设置ID',\n" +
                                    "  `DEPT_ID` int(11) NOT NULL COMMENT '部门ID',\n" +
                                    "  `USER_ID` varchar(20) NOT NULL COMMENT '用户ID',\n" +
                                    "  `ISOPEN` int(11) NOT NULL COMMENT '是否启用',\n" +
                                    "  `REMARK` varchar(255) DEFAULT NULL COMMENT '备注',\n" +
                                    "  PRIMARY KEY (`ESS_ID`)\n" +
                                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8;";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                        /**   2018-04-16  郭心雨
                         *  作用: 添加登录验证码是否开启参数
                         */
                        boolean SEC_GRAPHICPara = Verification.CheckIsExistParam(conn, driver, url, username, password,  "SEC_GRAPHIC");
                        if(SEC_GRAPHICPara==false){
                            String sql="INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('SEC_GRAPHIC', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        //添加字段
                        boolean userExtTable = Verification.CheckIsExistfield(conn, driver, url, username, password, "USER_EXT","LOGIN_RESTRICTION");
                        if(userExtTable==false){
                            String sql="alter table USER_EXT add LOGIN_RESTRICTION VARCHAR(225) DEFAULT '0'";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        //添加字段
                        boolean userExtTable1 = Verification.CheckIsExistfield(conn, driver, url, username, password, "USER_EXT","LOGIN_TIME");
                        if(userExtTable1==false){
                            String sql="alter table USER_EXT add LOGIN_TIME VARCHAR(225)";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-05-8  高亚峰
                         *  作用: 邮件审核功能字段
                         */
                        boolean email_body = Verification.CheckIsExistfield(conn, driver, url, username, password, "email_body","EXAM_FLAG");
                        if(email_body==false){
                            String sql="alter table email_body add EXAM_FLAG VARCHAR(10) COMMENT '一般审核状态（0-未审核，1-审核通过，2-未审核通过，3-无需审核）';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-05-8  高亚峰
                         *  作用: 邮件审核功能字段
                         */
                        boolean email_bodyfiled = Verification.CheckIsExistfield(conn, driver, url, username, password, "email_body","WORD_FLAG");
                        if(email_bodyfiled==false){
                            String sql="alter table email_body add WORD_FLAG VARCHAR(10) COMMENT '过滤词审核（0-未审核，1-审核通过，2-未审核通过，3-无需审核）';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /** 作者：高亚峰 2018-05-08
                         * 添加表:邮件设置表
                         */
                        boolean isExistTableaccount=Verification.CheckIsExistTable(conn, driver, url, username, password,"c_accountinfo");
                        if(isExistTableaccount==false){
                            String sql="CREATE TABLE IF NOT EXISTS `c_accountinfo` (\n" +
                                    "  `PERSON_ID` varchar(255) NOT NULL COMMENT '用户主键',\n" +
                                    "  `USER_ID` varchar(32) NOT NULL COMMENT '用户组织id_userId',\n" +
                                    "  `ACCOUNT` varchar(100) NOT NULL COMMENT '用户账号',\n" +
                                    "  `PASSWORD` varchar(200) NOT NULL COMMENT '用户密码 MD5加密',\n" +
                                    "  `NAME` varchar(100) DEFAULT NULL COMMENT '用户姓名',\n" +
                                    "  `ID_CARD_NO` varchar(200) DEFAULT NULL COMMENT '证件号码',\n" +
                                    "  `CRED_TYPE` char(2) DEFAULT NULL COMMENT '证件类型 0:身份证 1:护照 2：军人证 3：其他',\n" +
                                    "  `GENDER` char(1) DEFAULT NULL COMMENT '性别 0：女 1：男 2：保密',\n" +
                                    "  `USER_TYPE` varchar(2) DEFAULT NULL COMMENT '用户类型 学生：0 老师：1 家长：2 机构：3 学校：4 学校工作人员：5  机构工作人员：6 社会学习者：7 专家：8 其他：9',\n" +
                                    "  `PHONE_NUMBERS` varchar(20) DEFAULT NULL COMMENT '电话号码',\n" +
                                    "  `EMAILS` varchar(100) DEFAULT NULL COMMENT '电子邮件',\n" +
                                    "  `DATE_OF_BIRTH` datetime DEFAULT NULL COMMENT '出生日期',\n" +
                                    "  `REGI_TIME` datetime DEFAULT NULL COMMENT '注册时间',\n" +
                                    "  `STATUS` varchar(2) DEFAULT NULL COMMENT '状态 -1：删除 0：正常 1：未激活 2：注销',\n" +
                                    "  `OPERATION` varchar(2) DEFAULT NULL COMMENT '更新操作 01：新增 02：修改 99：删除',\n" +
                                    "  `REMARK` varchar(200) DEFAULT NULL COMMENT '更新备注',\n" +
                                    "  `ORG_ID` varchar(32) DEFAULT NULL COMMENT '所属组织id',\n" +
                                    "  PRIMARY KEY (`PERSON_ID`)\n" +
                                    ") ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户中间表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                          /*  *//**
                         *  添加者：高亚峰
                         *  添加日期：2018-5-10
                         *  添加字段的作用: 邮件设置
                         */
                        boolean isExistPara_Email = Verification.CheckIsExistSysPara(conn, driver, url, username, password, "EMAIL_EXAM");
                        if (isExistPara_Email == false) {
                            String sql = "INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('EMAIL_EXAM', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句    //插入DDL语句返回值为1;
                            //如果需要执行多个则用&&符判断
                        }
                        /*  2018-05-15 高亚峰
                     *      创建表censor_data
                     */
                        boolean checkIsExistcenData=Verification.CheckIsExistTable(conn, driver, url, username, password,"censor_data");
                        if(checkIsExistcenData==false){
                            String sql="CREATE TABLE IF NOT EXISTS `censor_data` (\n" +
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

                         /*  2018-05-15 高亚峰
                     *      创建表censor_data
                     */
                        boolean checkIsExistcenMouble=Verification.CheckIsExistTable(conn, driver, url, username, password,"censor_module");
                        if(checkIsExistcenMouble==false){
                            String sql="CREATE TABLE IF NOT EXISTS `censor_module` (\n" +
                                    "  `MODULE_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一自增ID',\n" +
                                    "  `MODULE_CODE` varchar(20) NOT NULL DEFAULT '' COMMENT '模块代码',\n" +
                                    "  `USE_FLAG` char(1) NOT NULL DEFAULT '1' COMMENT '启用过滤(1-启用,0-不启用)',\n" +
                                    "  `CHECK_USER` text NOT NULL COMMENT '审核人员',\n" +
                                    "  `SMS_REMIND` varchar(20) NOT NULL DEFAULT '1' COMMENT '内部短信提醒标识',\n" +
                                    "  `SMS2_REMIND` varchar(20) NOT NULL DEFAULT '0' COMMENT '手机短信提醒标识',\n" +
                                    "  `BANNED_HINT` varchar(255) NOT NULL DEFAULT '' COMMENT '禁止提示',\n" +
                                    "  `MOD_HINT` varchar(255) NOT NULL DEFAULT '' COMMENT '审核提示',\n" +
                                    "  `FILTER_HINT` varchar(255) NOT NULL DEFAULT '' COMMENT '过滤提示',\n" +
                                    "  PRIMARY KEY (`MODULE_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='敏感词语过滤模块表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                             /*  2018-05-15 高亚峰
                     *      创建表censor_data
                     */
                        boolean checkIsExistcenWords=Verification.CheckIsExistTable(conn, driver, url, username, password,"censor_words");
                        if(checkIsExistcenWords==false){
                            String sql="CREATE TABLE IF NOT EXISTS `censor_words` (\n" +
                                    "  `WORD_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增唯一ID',\n" +
                                    "  `UID` int(11) NOT NULL DEFAULT '0' COMMENT '添加人',\n" +
                                    "  `FIND` varchar(255) NOT NULL DEFAULT '' COMMENT '不良词语',\n" +
                                    "  `REPLACEMENT` varchar(255) NOT NULL DEFAULT '' COMMENT '替换词语',\n" +
                                    "  PRIMARY KEY (`WORD_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='敏感词语定义表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**   2018-05-16  高亚峰
                         *  作用: 添加附件字段
                         */
                        boolean supFedField = Verification.CheckIsExistfield(conn, driver, url, username, password, "sup_feed_back","ATTACHMENT_ID");
                        if(supFedField==false){
                            String sql="alter table sup_feed_back add ATTACHMENT_ID VARCHAR(225);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**   2018-05-16  高亚峰
                         *  作用: 添加附件字段
                         */
                        boolean supFedNameField = Verification.CheckIsExistfield(conn, driver, url, username, password, "sup_feed_back","ATTACHMENT_NAME");
                        if(supFedNameField==false){
                            String sql="alter table sup_feed_back add ATTACHMENT_NAME VARCHAR(225);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**  2018-05-16  高亚峰
                         *添加字段的作用: 添加菜单
                         */
                        boolean functionField = Verification.CheckIsExistFunction(conn, driver, url, username, password, "113");
                        if(functionField==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('113', 'z080', '系统参数设置', 'system parameter setting', '系統參數設置', NULL, NULL, NULL, 'sysTasks/sysTaskIndex', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-05-16  高亚峰
                         *添加字段的作用: 添加菜单
                         */
                        boolean functionField2 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2051");
                        if(functionField2==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2051', 'z009', '通讯管理', 'Instant messaging management', '通訊管理', '', '', '', '@chat', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-05-16  高亚峰
                         *添加字段的作用: 添加菜单
                         */
                        boolean functionField3 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2052");
                        if(functionField3==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2052', 'z00901', '邮件管理', 'Mail management', '郵件管理', '', '', '', 'email/emailSet', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-05-16  高亚峰
                         *添加字段的作用: 添加菜单
                         */
                        boolean functionField4 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2054");
                        if(functionField4==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2054', 'z00903', '词语过滤管理', 'Word filtering management', '詞語過濾管理', '', '', '', 'censor/management', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-05-16  高亚峰
                         *添加字段的作用: 添加菜单
                         */
                        boolean functionField5 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2055");
                        if(functionField5==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2055', '2002', '邮件审核', 'Mail audit', '郵件稽核', NULL, NULL, NULL, 'email/mailApproval', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**  2018-5-16  高亚峰
                         *  作用: 添加督办
                         */
                        boolean codeField = Verification.CheckIsExistCode(conn, driver, url, username, password, "71", "SMS_REMIND");
                        if (codeField == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('71', '督办', NULL, NULL, NULL, NULL, NULL, NULL, '71', 'SMS_REMIND', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-5-16 高亚峰
                         *  作用: 添加会议
                         */
                        boolean codeField1 = Verification.CheckIsExistCode(conn, driver, url, username, password, "72", "SMS_REMIND");
                        if (codeField1 == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('72', '会议', NULL, NULL, NULL, NULL, NULL, NULL, '72', 'SMS_REMIND', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**  2018-5-16  高亚峰
                         *  作用: 插入过滤词设置默认数据
                         */
                        boolean checkIsCensor = Verification.CheckIsCensor(conn, driver, url, username, password,  "1");
                        if (checkIsCensor == false) {
                            String sql = "INSERT INTO `censor_module` (`MODULE_ID`, `MODULE_CODE`, `USE_FLAG`, `CHECK_USER`, `SMS_REMIND`, `SMS2_REMIND`, `BANNED_HINT`, `MOD_HINT`, `FILTER_HINT`) VALUES ('1', '0101', '0', 'admin,', '1', '0', '', '', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 添加分级机构字段
                         *  创建日期:2018-03-16
                         *  创建者：高亚峰
                         */
                        boolean isExistDepartment  = Verification.CheckIsExistfield(conn, driver, url, username, password, "department","ClASSIFY_ORG");
                        if(isExistDepartment==false){
                            String sql="ALTER TABLE department ADD ClASSIFY_ORG int(11) comment '分级机构(0-不是，1-是)'";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**
                         *  作用: 添加分级机构字段
                         *  创建日期:2018-03-16
                         *  创建者：高亚峰
                         */
                        boolean isExistDepartmentFiled  = Verification.CheckIsExistfield(conn, driver, url, username, password, "department","ClASSIFY_ORG_ADMIN");
                        if(isExistDepartmentFiled==false){
                            String sql="ALTER TABLE department ADD ClASSIFY_ORG_ADMIN VARCHAR(255) comment '分级机构的管理员(uid)'";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  创建者：  高亚峰
                         * 添加表的作用: 定时任务
                         * 添加时间：2018-05-23
                         */
                        boolean isExistTask=Verification.CheckIsExistTable(conn, driver, url, username, password,"timed_task_management");
                        if(isExistTask==false){
                            String sql="CREATE TABLE IF NOT EXISTS `timed_task_management` (\n" +
                                    "  `TTM_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '定时任务管理ID',\n" +
                                    "  `TASK_NAME` varchar(255) DEFAULT NULL COMMENT '任务名称',\n" +
                                    "  `TASK_ DESCRIPTION` varchar(255) DEFAULT NULL COMMENT '任务描述',\n" +
                                    "  `TYPE_MET` int(11) DEFAULT NULL COMMENT '定时任务(1),定点任务(2)',\n" +
                                    "  `TASK_TYPE` int(11) DEFAULT NULL COMMENT '任务类型(模块中的系统代码设置类型)',\n" +
                                    "  `EXECUTE` int(11) DEFAULT NULL COMMENT '是否执行(1执行，0不执行)',\n" +
                                    "  `INTWEVAL_TIME` varchar(255) DEFAULT NULL COMMENT '定时执行间隔时间(分钟)/定点间隔执行时间天',\n" +
                                    "  `EXECUTION_TIMEAT` varchar(20) DEFAULT NULL COMMENT '定时任务执行时间',\n" +
                                    "  PRIMARY KEY (`TTM_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='--------------------定时任务管理表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }

                        /**  创建者：  高亚峰
                         *   添加表的作用: 定时任务
                         *   添加时间：2018-05-23
                         */
                        boolean isExistTask2=Verification.CheckIsExistTable(conn, driver, url, username, password,"timed_task_record");
                        if(isExistTask2==false){
                            String sql="CREATE TABLE IF NOT EXISTS `timed_task_record` (\n" +
                                    "  `TTR_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务记录ID',\n" +
                                    "  `TTM_ID` int(11) NOT NULL COMMENT '定时任务管理ID',\n" +
                                    "  `USER_ID` varchar(255) DEFAULT NULL COMMENT '执行人ID',\n" +
                                    "  `EXECUTION_TIME` varchar(20) DEFAULT NULL COMMENT '任务执行时间',\n" +
                                    "  `RESULT` int(11) DEFAULT NULL COMMENT '执行结果(0执行成功，1执行失败)',\n" +
                                    "  `LISHI_TIME` varchar(20) DEFAULT NULL COMMENT '上次执行时间',\n" +
                                    "  PRIMARY KEY (`TTR_ID`)\n" +
                                    ") ENGINE=InnoDB AUTO_INCREMENT=1879 DEFAULT CHARSET=utf8 COMMENT='----------定时任务执行记录表';";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句   //DDL语句返回值为0;
                        }
                        /**  创建者：  高亚峰
                         *   添加表的作用: 系统代码
                         *   添加时间：2018-06-1
                         */
                        boolean existCode_SMS = Verification.CheckIsExistCode(conn, driver, url, username, password, "23","SMS_REMIND");
                        if (existCode_SMS == false) {
                            String sql = "INSERT INTO `sys_code` (`CODE_NO`, `CODE_NAME`, `CODE_NAME1`, `CODE_NAME2`, `CODE_NAME3`, `CODE_NAME4`, `CODE_NAME5`, `CODE_NAME6`, `CODE_ORDER`, `PARENT_NO`, `CODE_FLAG`, `CODE_EXT`) VALUES ('23', '领导活动安排', NULL, NULL, NULL, NULL, NULL, NULL, '23', 'SMS_REMIND', '0', '');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  创建者：  高亚峰
                         *   添加表的作用: 文件柜容量
                         *   添加时间：2018-06-1
                         */
                        boolean existFiled= Verification.CheckIsExistfield(conn, driver, url, username, password, "file_sort","SPACE_USE");
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
                        boolean isExistDemo  = Verification.CheckIsExistParam(conn, driver, url, username, password, "IS_CHECK_DEMO");
                        if(isExistDemo==false){
                            String sql="INSERT INTO `sys_para` (`PARA_NAME`, `PARA_VALUE`) VALUES ('IS_CHECK_DEMO', '1');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }

                        /**
                         *  作用: 工资表
                         *  创建日期:2018-07-05
                         *  创建者：高亚峰
                         */
                        boolean isExistBonus  = Verification.CheckIsExistTable(conn, driver, url, username, password,"bonus");
                        if(isExistBonus==false){
                            String sql="CREATE TABLE IF NOT EXISTS  `bonus` (\n" +
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
                        boolean isExistBonmsg  = Verification.CheckIsExistTable(conn, driver, url, username, password,"bonusmsg");
                        if(isExistBonmsg==false){
                            String sql="CREATE TABLE IF NOT EXISTS `bonusmsg` (\n" +
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
                        if(functionField6==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2045', '0130', '工资查询', 'Salary management', '薪水査詢', NULL, NULL, NULL, 'salary/lclb', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-07-05  高亚峰
                         *添加字段的作用: 添加工资管理菜单
                         */
                        boolean functionField7 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "2056");
                        if(functionField7==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('2056', '501101', '工资管理', 'Wage Manage', '薪水管理', NULL, NULL, NULL, 'personSalary/personLclb', '', '0');";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-07-05  高亚峰
                         *添加字段的作用: 添加工资管理菜单
                         */
                        boolean functionField8 = Verification.CheckIsExistFunction(conn, driver, url, username, password, "55");
                        if(functionField8==false){
                            String sql="INSERT INTO `sys_function` (`FUNC_ID`, `MENU_ID`, `FUNC_NAME`, `FUNC_NAME1`, `FUNC_NAME2`, `FUNC_NAME3`, `FUNC_NAME4`, `FUNC_NAME5`, `FUNC_CODE`, `FUNC_EXT`, `ISOPEN_NEW`) VALUES ('55', '5011', '薪酬管理', 'Salary Manage', '薪酬管理', NULL, NULL, NULL, '@hr', '', NULL);";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  创建者：  高亚峰
                         *   添加表的作用: 固定资产维修交接明细表
                         *   添加时间：2018-07-17
                         */
                        boolean edu_transfer=Verification.CheckIsExistTable(conn, driver, url, username, password,"edu_transfer");
                        if(edu_transfer==false){
                            String sql="CREATE TABLE IF NOT EXISTS `edu_transfer` (\n" +
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
                        boolean edu_maintain=Verification.CheckIsExistTable(conn, driver, url, username, password,"edu_maintain");
                        if(edu_maintain==false){
                            String sql="CREATE TABLE IF NOT EXISTS `edu_maintain` (\n" +
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
                        boolean att_id  = Verification.CheckIsExistfield(conn, driver, url, username, password, "timeline","attment_id");
                        if(att_id==false){
                            String sql="ALTER table `timeline` ADD attment_id VARCHAR (255) DEFAULT NULL";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }
                        /**  2018-07-17  高亚峰
                         *添加字段的作用: 修改大事记字段
                         */
                        boolean att_name  = Verification.CheckIsExistfield(conn, driver, url, username, password, "timeline","attment_name");
                        if(att_name==false){
                            String sql="ALTER table `timeline` ADD attment_name VARCHAR (255) DEFAULT NULL";
                            Statement st = conn.createStatement();
                            st.executeUpdate(sql);//执行SQL语句
                        }


                        //最后修改一下数据库版本号
                        Version version = new Version();
                        version.setVer(SystemInfoServiceImpl.softVersion);
                        versionMapper.editVer(version);

                        //释放资源
                        conn.close();
                    }
                }
            }
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg(e.getMessage());
            e.printStackTrace();
            L.e("updateResourceLog:" + e);
        }

        return json;
    }

    @Override
    public void downLog(HttpServletResponse response,HttpServletRequest request) {
        try {
            String classpath = this.getClass().getResource("/").getPath();
            String webappRoot = classpath.replaceAll("WEB-INF/classes/", "ui/file/properties/");
            File file = new File(webappRoot+"jdbc.txt");
            String urltd_oa=new String();
            String unametd_oa=new String();
            String passwordtd_oa=new String();
            //判断文件是否存在
            if(file.isFile() && file.exists()){

                InputStreamReader read = new InputStreamReader(
                        new FileInputStream(file));//考虑到编码格式
                BufferedReader bufferedReader = new BufferedReader(read);
                String lineTxt = null;
                int i=1;
                while((lineTxt = bufferedReader.readLine()) != null){
                    if(i==1){
                        urltd_oa=lineTxt;
                    }
                    else if(i==2){
                        unametd_oa=lineTxt;
                    }else{
                        passwordtd_oa=lineTxt;
                    }
                    i++;
                }
                read.close();
            }
            int i=1;
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
            String url = urltd_oa;
            String driver = props.getProperty("driverClassName");
            String username = unametd_oa;
            String password = passwordtd_oa;
            Class.forName(driver).newInstance();
            Connection conn = (Connection) DriverManager.getConnection(url, username, password);
            Statement st = conn.createStatement();
            String sql_2="select * from str_status where STATE =1";
            ResultSet rs = st.executeQuery(sql_2);//执行SQL语句
            List<Strstatus> strstatus =new ArrayList<Strstatus>();
            Object object1 =new Object();
            Object object2 =new Object();
            while(rs.next()){
                Strstatus strstatus1 =new Strstatus();
                object2 = rs.getObject(4);
                strstatus1.setId(i);
                strstatus1.setStringSql(object2.toString());
                strstatus.add(strstatus1);
                i++;
            }
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
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}
