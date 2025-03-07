package com.xoa.service.sys;

import com.xoa.dao.sys.SysDataBaseMapper;
import com.xoa.model.users.Users;
import com.xoa.util.Constant;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ExportSQLUtil;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SysDataBaseService {

    @Autowired
    private SysDataBaseMapper sysDataBaseMapper;

    /**
     * 作者: 张航宁
     * 日期: 2020/02/24
     * 说明: 查询数据库中的所有表
     */
    public BaseWrapper selTables(HttpServletRequest request) {
        BaseWrapper baseWrapper = new BaseWrapper();
        // 权限验证 是否是管理员账号
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if(user.getUserPriv()!=1){
            baseWrapper.setFlag(false);
            baseWrapper.setCode("0");
            baseWrapper.setMsg("没有权限");
            return baseWrapper;
        }
        String loginDateSouse = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        String searchValue = request.getParameter("searchValue");

        List<Map<String, Object>> maps = sysDataBaseMapper.selSysTables(loginDateSouse,searchValue);
        //去除敏感数据表
        List<String> tableName = Arrays.asList("user,user_function,user_priv".split(","));
        maps = maps.stream().filter(m -> !tableName.contains(m.get("tableName").toString().toLowerCase())).collect(Collectors.toList());

        baseWrapper.setData(maps);
        baseWrapper.setFlag(true);
        baseWrapper.setCode("0");
        return baseWrapper;
    }



    /**
     * 作者: 张航宁
     * 日期: 2020/02/24
     * 说明: 导出指定的表 tables为表名拼接字符串 如 user,user_ext  dataType 为导出类型 0只导出表结构 1同时导出数据
     */
    public void exportTables(HttpServletRequest request, HttpServletResponse response, String tables, String exportType) throws IOException {
        String loginDateSouse = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        if(!StringUtils.checkNull(tables)){

            String[] tabArr = tables.split(",");

            //去除敏感数据表
            List<String> tableName = Arrays.asList("user,user_function,user_priv".split(","));
            tabArr = Arrays.asList(tabArr).stream()
                    .filter(s -> !tableName.contains(s.toLowerCase())).collect(Collectors.joining(",")).split(",");
            if(tabArr.length == 0 || StringUtils.checkNull(tabArr[0])){
                return;
            }

            // 文件存储头
            StringBuilder uploadHead = FileUploadUtil.getUploadHead();

            // 当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());

            // 组织
            String company = "xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

            // 时间戳数字串
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));

            // 文件存储路径
            StringBuilder filePath = uploadHead.append(System.getProperty("file.separator")).
                    append(company).append(System.getProperty("file.separator")).
                    append("sysDataBase").append(System.getProperty("file.separator")).
                    append(ym).append(System.getProperty("file.separator"));

            // 生成文件目录
            new File(filePath.toString()).mkdirs();

            // 创建sql附件
            String fullFilePath = filePath.append(attachID).append(".").append(tabArr[0]).append(".sql").toString();
            ExportSQLUtil.createFile(fullFilePath, tabArr,loginDateSouse,exportType);


            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet-stream");
            String userAgent = request.getHeader("User-Agent").toUpperCase();
            if (!MobileCheck.isMobileDevice(userAgent)) {

                response.setHeader("Content-disposition",
                        String.format("attachment; filename=\"%s\"", tabArr[0] + ".sql"));

                InputStream inputStream = null;
                OutputStream os = null;
                File file = null;
                try {
                    boolean bol = false;
                    file = new File(fullFilePath);
                    // 如果文件不存在
                    if (!file.exists()) {
                        file = new File(filePath + ".xoafile");
                        bol = true;
                        if (!file.exists()) {
                            request.setAttribute("message", Constant.exesit);
                        }
                    }
                    os = response.getOutputStream();
                    if (bol) {
                        byte[] abc = AESUtil.download(file, loginDateSouse, bol);
                        os.write(abc, 0, abc.length);
                    } else {
                        inputStream = new FileInputStream(file);
                        byte[] b = new byte[2048];
                        int length;
                        while ((length = inputStream.read(b)) > 0) {
                            os.write(b, 0, length);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    // 这里主要关闭。
                    if (os != null) {
                        os.close();
                    }
                    if (inputStream != null) {
                        inputStream.close();
                    }
                }
            }

        }
    }
}
