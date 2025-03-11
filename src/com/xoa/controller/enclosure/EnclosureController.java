package com.xoa.controller.enclosure;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.global.component.OnlyOfficeCodeManager;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.enclosure.OnlyOfficeHistoryWithBLOBs;
import com.xoa.model.users.OrgManage;
import com.xoa.model.users.Users;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.base64.Base64ToImageUtil;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.file.WordHtml;
import com.xoa.util.file2Img.File2Img;
import com.xoa.util.office.OfficePluginManager;
import org.artofsolving.jodconverter.OfficeDocumentConverter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月19日 下午12:56:00
 * 类介绍  :    附件
 * 构造参数:   无
 */
@Controller
@SuppressWarnings("all")
public class EnclosureController {


    @Autowired
    private EnclosureService enclosureService;

    @Autowired
    private SysTasksService sysTasksService;

    @Autowired
    private OrgManageMapper orgManageMapper;


    @Autowired
    private SysParaMapper sysParaMapper;

    /**
     * 作者 廉立深
     * 日期 2020/9/25
     * 方法介绍  批量下载接口  zip
     * 参数 [request, resp, aId：aId串, module：模块名, zipName：zip包名称]
     * 返回 void
     **/
    @RequestMapping("/getZipFilename")
    private void getZipFilename(HttpServletRequest request,HttpServletResponse resp,String[] aId , String module, String zipName) throws IOException {
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        String company = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionId);

        // 头文件
        resp.reset();
        zipName = java.net.URLEncoder.encode(zipName , "UTF-8");
        resp.setContentType("application/vnd.ms-excel;charset=UTF-8");
        resp.setHeader("Content-Disposition", "attachment;filename=" + zipName + ".zip");

        // 压缩文件
        ZipOutputStream zos = new ZipOutputStream(resp.getOutputStream());
        BufferedOutputStream bos = new BufferedOutputStream(zos);

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        try {
            //拼装
            for ( String aid : aId ) {

                Attachment attachment = enclosureService.selectByAid(Integer.parseInt(aid));

                String attachmentName = attachment.getAttachName();
                String ym = attachment.getYm();
                String attachmentId = attachment.getAttachId();
                System.setProperty("sun.jnu.encoding", "UTF-8");
                System.setProperty("file.encoding", "UTF-8");

                String osName = System.getProperty("os.name");
                int codeLength = attachmentName.getBytes("UTF-8").length;
                String type = attachmentName.substring(attachmentName.lastIndexOf("."));
                // 判断是否文件名过长 并且是Linux 进行加密名称
                // 或者系统设置中 设置了加密
                if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                    String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                    String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                    String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                    if(trim.length()>100){
                        attachmentName=(trim).substring(0,100)+type;
                    } else {
                        attachmentName = trim+type;
                    }

                    // 判断是否存在加密附件 如果不存在的话 有可能是开启加密之前生成的附件

                    StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(company, module, ym);

                    String filePath = fullUploadPath.toString() + attachmentId + "." + attachmentName;

                    File file = new File(filePath + ".xoafile");

                    if(!file.exists()){
                        attachmentName = attachment.getAttachName();
                    }

                }

                //读取配置文件
                ResourceBundle rb = ResourceBundle.getBundle("upload");
                StringBuffer sb = new StringBuffer();
                StringBuffer buffer = new StringBuffer();
                if (osName.toLowerCase().startsWith("win")) {
                    //判断路径是否是相对路径，如果是的话，加上运行的路径
                    String uploadPath = rb.getString("upload.win");
                    if (uploadPath.indexOf(":") == -1) {
                        //获取运行时的路径
                        String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                        //获取截取后的路径
                        String str2 = "";
                        if (basePath.indexOf("/xoa") != -1) {
                            //获取字符串的长度
                            int length = basePath.length();
                            //返回指定字符在此字符串中第一次出现处的索引
                            int index = basePath.indexOf("/xoa");
                            //从指定位置开始到指定位置结束截取字符串
                            str2 = basePath.substring(0, index);
                        }
                        sb = sb.append(str2 + "/xoa");
                    }
                    sb.append(uploadPath);
                    buffer = buffer.append(rb.getString("upload.win"));
                } else {
                    sb = sb.append(rb.getString("upload.linux"));
                    buffer = buffer.append(rb.getString("upload.linux"));
                }

                // Linux大写文件名兼容问题修改
                if(!osName.toLowerCase().startsWith("win")){
                    attachmentName = attachmentName.substring(0,attachmentName.lastIndexOf("."))+(attachmentName.substring(attachmentName.lastIndexOf(".")).toLowerCase());
                }


                if (StringUtils.checkNull(sb.toString())) {
                    String a = request.getRealPath("");
                    sb.append(a);
                    sb.append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                            append(module).append(System.getProperty("file.separator")).append(ym).
                            append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
                } else {
                    sb.append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                            append(module).append(System.getProperty("file.separator")).append(ym).
                            append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
                }

                File file = new File( sb.toString() );

                // 如果文件不存在
                if (!file.exists()) {
                    file = new File(sb.toString() + ".xoafile");
                    if (!file.exists()) {
                        request.setAttribute("message", Constant.exesit);
                        continue;
                    }
                }

                // --打包
                BufferedInputStream  bis  = new BufferedInputStream( new FileInputStream( file ) );
                zos.putNextEntry(new ZipEntry( attachment.getAttachName() ));
                byte[] byteBuffer = new byte[1024];
                int r = 0;
                while ((r = bis.read(byteBuffer)) != -1) {
                    bos.write(byteBuffer, 0, r);
                }
                bis.close();
                bos.flush();
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            bos.close();
            zos.close();
        }
    }



    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月2日 上午11:12:17
     * 方法介绍:
     * 参数说明:   @param files 文件
     * 参数说明:   @param module 模块名
     * 参数说明:   @param company 公司名
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     *
     * @return ToJson<Attachment> 返回附件信息
     */
    @RequestMapping(value = "/upload", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    void upload(@RequestParam("file") MultipartFile[] files, String module,
                @RequestParam(value = "company", required = false) String company,
                HttpServletRequest request, HttpServletResponse response) {
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        if(!StringUtils.checkNull(module)&&module.contains("..")){
            return;
        }

        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa" + company);
            } else {
                if("mysql".equals(FileUploadUtil.getDriver())){
                    sb.append("xoa" +company);
                } else if ("kingbase8".equals(FileUploadUtil.getDriver())){
                    sb.append("xoaKB" +company);
                } else if ("dm".equals(FileUploadUtil.getDriver())){
                    sb.append("xoaDM" +company);
                }
            }
        } else {
            if(company.contains("..")){
                return;
            }
            sb.append(company);
        }
        response.setHeader("content-type", "text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        try (ServletOutputStream out = response.getOutputStream();
             OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");) {
          /*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*/
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                    break;
                }
                //验证图片是否是脚本等不符合上传要求的文件
                a=!FileUploadUtil.checkFile(file.getOriginalFilename());
                //部分模块要限制验证只能上传图片
                if("interface".equals(module)){
                    a=!FileUploadUtil.checkFilePicture(file.getOriginalFilename());
                }
            }
            if (a) {
                json.setFlag(1);
                json.setMsg("上传文件有误，请修正");
            } else {
                List<Attachment> list = enclosureService.upload(files, sb.toString(), module);
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }


            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return;
    }

    @RequestMapping(value = "/uploadEnterprise", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    ToJson<Attachment> uploadEnterprise(@RequestParam("file") MultipartFile[] files, String module,
                                        @RequestParam(value = "company", required = false) String company,
                                        HttpServletRequest request, HttpServletResponse response) {
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!FileUploadUtil.checkFile(file.getOriginalFilename())){
                return null;
            }
        }

        List<Attachment> list = new ArrayList<>();
        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa" + company);
            } else {
                sb.append("xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        response.setHeader("content-type", "text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        try (ServletOutputStream out = response.getOutputStream();
             OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");) {
          /*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*/
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                }
            }
            if (a) {
                json.setFlag(1);
                json.setMsg("The file size is 0");
            } else {
                list = enclosureService.upload(files, sb.toString(), module);
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }

            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年5月2日 上午11:12:17
     * 方法介绍:   附件上传
     * 参数说明:   @param files 文件
     * 参数说明:   @param module 模块名
     * 参数说明:   @param company 公司名
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     *
     * @return ToJson<Attachment> 返回附件信息
     */
    @RequestMapping(value = "/uploadPlus", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    void uploadPlus(@RequestParam("file") MultipartFile[] files, String module,
                    @RequestParam(value = "company", required = false) String company,
                    HttpServletRequest request, HttpServletResponse response, String sql) {
        // ToJson<Attachment> attachmentToJson = uploadEnterprise(files, module, company, request, response);
        //company="xoa"+sql;
        // upload(files,module,company,request,response);
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!FileUploadUtil.checkFile(file.getOriginalFilename())){
                return ;
            }
        }

        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa" + company);
            } else {
                sb.append("xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }

        response.setHeader("content-type", "text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        try (ServletOutputStream out = response.getOutputStream();
             OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");) {
          /*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*/
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                }
            }
            if (a) {
                json.setFlag(1);
                json.setMsg("The file size is 0");
            } else {
                List<Attachment> list = enclosureService.uploadenterprise(files, sb.toString(), module, sql);
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }


            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return;
        /*ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)){
                List<OrgManage> org=orgManageMapper.queryId();
                if (org!=null&&org.size()>0){
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa"+company);
            }else {
                sb.append("xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        try {
          *//*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*//*
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a=true;
                }
            }
            if (a){
                json.setFlag(1);
                json.setMsg("The file size is 0");
            }else {
                List<Attachment> list = enclosureService.upload(files, sb.toString(), module);
                if(!sb.equals("xoa" + sql)){
                    List<Attachment> list1 = enclosureService.upload(files, "xoa" + sql, module);
                    json.setObj(list1);
                }
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }

            response.setHeader("content-type", "text/html;charset=utf-8");
            response.setCharacterEncoding("utf-8");
            ServletOutputStream out = response.getOutputStream();
            OutputStreamWriter ow = new OutputStreamWriter(out,"UTF-8");

            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return;*/
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月30日 上午9:52:41
     * 方法介绍:   下载
     * 参数说明:   @param aid 附件信息主键
     * 参数说明:   @param module 模块名
     * 参数说明:   @param ym 年月
     * 参数说明:   @param attachmentId 附件id
     * 参数说明:   @param attachmenrName 附件名字
     * 参数说明:   @param company 公司
     * 参数说明:   @param response 响应
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     *
     * @return String 返回
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/download")
    public String download(@RequestParam(value = "AID", required = false) Integer aid,
                           @RequestParam("MODULE") String module,
                           @RequestParam("YM") String ym,
                           @RequestParam("ATTACHMENT_ID") String attachmentId,
                           //@RequestParam(value = "ATTACHMENT_NAME",required = false) String attachmentName ,
                           @RequestParam("COMPANY") String company,
                           String isOld,
                           HttpServletResponse response,
                           HttpServletRequest request) throws Exception {

        if (company.contains("null") || StringUtils.checkNull(company)) {
            List<OrgManage> org = orgManageMapper.queryId();
            if (org != null && org.size() > 0) {
                company = "xoa" + org.get(0).getOid().toString().trim();
            }
        }

        ContextHolder.setConsumerType(company);
        String attachmentName = "";
        String realAttachName = "";
        System.setProperty("sun.jnu.encoding", "UTF-8");
        System.setProperty("file.encoding", "UTF-8");
        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));

        if (!"1".equals(isOld) || (aid != null && aid != 0)) {
            Attachment attachment = enclosureService.selectByAid(aid);
            if (attachment != null) {
                attachmentName = attachment.getAttachFile();
                realAttachName = attachment.getAttachName();
            }
        } else {
            String attachmentName1 = request.getParameter("ATTACHMENT_NAME");
            Map<String,Object> paraMap = new HashMap<>();
            paraMap.put("attachId",attachmentId);
            paraMap.put("ym",ym);
            Attachment attachment = enclosureService.selectOneBySearch(paraMap);
            if(attachment!=null){
                attachmentName1 = attachment.getAttachName();
            }
            String aName = "";
            if (attachmentName1.substring(attachmentName1.length() - 1, attachmentName1.length()).equals("*")) {
                aName = attachmentName1.substring(0, request.getParameter("ATTACHMENT_NAME").length() - 1);
            } else {
                aName = attachmentName1;
            }
            if(StringUtils.checkNull(aName)){
                return "附件名为空，无法查询到附件信息！";
            }
            attachmentName = URLDecoder.decode(aName, "UTF-8");
            realAttachName = attachmentName;
        }

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        String osName = System.getProperty("os.name");
        int codeLength = realAttachName.getBytes("UTF-8").length;
        String type = realAttachName.substring(realAttachName.lastIndexOf("."));
        // 判断是否文件名过长 并且是Linux 进行加密名称
        // 或者系统设置中 设置了加密
        if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
            String s = (new BASE64Encoder()).encodeBuffer((realAttachName.substring(0, realAttachName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
            String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
            String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
            if(trim.length()>100){
                attachmentName=(trim).substring(0,100)+type;
            } else {
                attachmentName = trim+type;
            }



            // 判断是否存在加密附件 如果不存在的话 有可能是开启加密之前生成的附件

            StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(company, module, ym);

            String filePath = fullUploadPath.toString() + attachmentId + "." + attachmentName;

            File file = new File(filePath + ".xoafile");

            if(!file.exists()){
                attachmentName = realAttachName;
            }

        }

        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
            buffer = buffer.append(rb.getString("upload.win"));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
            buffer = buffer.append(rb.getString("upload.linux"));
        }

        // Linux大写文件名兼容问题修改
        if(!osName.toLowerCase().startsWith("win")){
            attachmentName = attachmentName.substring(0,attachmentName.lastIndexOf("."))+(attachmentName.substring(attachmentName.lastIndexOf(".")).toLowerCase());
        }

        if (StringUtils.checkNull(sb.toString())) {
            String a = request.getRealPath("");
            sb.append(a);
            sb.append(System.getProperty("file.separator")).
                    append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym).
                    append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
        } else {
            sb.append(System.getProperty("file.separator")).
                    append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym).
                    append(System.getProperty("file.separator")).append(attachmentId).append(".").append(attachmentName);
        }
        String path = sb.toString();
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        String userAgent = request.getHeader("User-Agent").toUpperCase();

        if (!MobileCheck.isMobileDevice(userAgent)) {
            if (userAgent.contains("MSIE") || userAgent.contains("TRIDENT") || userAgent.contains("EDGE")) {
                realAttachName = URLEncoder.encode(realAttachName, "utf-8");
                realAttachName = realAttachName.replace("+", "%20");    //IE下载文件名空格变+号问题
            } else {
                realAttachName = new String(realAttachName.getBytes("UTF-8"), "ISO-8859-1");
            }
        } else {
            if (userAgent.contains("MSIE") || userAgent.contains("TRIDENT") || userAgent.contains("EDGE")) {
                realAttachName = URLEncoder.encode(realAttachName, "utf-8");
                realAttachName = realAttachName.replace("+", "%20");    //IE下载文件名空格变+号问题
            } else {
                realAttachName = new String(realAttachName.getBytes("UTF-8"), "ISO-8859-1");
            }
        }

        response.setHeader("Content-disposition",
                String.format("attachment; filename=\"%s\"", realAttachName));
        InputStream inputStream = null;
        OutputStream os = null;
        File file = null;
        try {
            boolean bol = false;
            file = new File(path);
            // 如果文件不存在
            if (!file.exists()) {
                file = new File(path + ".xoafile");
                bol = true;
                if (!file.exists()) {
                    request.setAttribute("message", Constant.exesit);
                    return Constant.exesit.toString();
                }
            }
            os = response.getOutputStream();
            if (bol) {
                byte[] abc = AESUtil.download(file, sqlType, bol);
                os.write(abc, 0, abc.length);
            } else {
                inputStream = new FileInputStream(file);
                byte[] b = new byte[2048];
                int length;
                while ((length = inputStream.read(b)) > 0) {
                    os.write(b, 0, length);
                }
            }
        } catch (FileNotFoundException e) {
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
        return null;
    }


    @RequestMapping(value = {"/uploadCover"}, produces = {"application/json;charset=UTF-8"})
    public String uploadCover(@RequestParam("file") MultipartFile files,
                              @RequestParam("AID") String aid,
                              @RequestParam("MODULE") String module,
                              @RequestParam("YM") String ym,
                              @RequestParam("ATTACHMENT_ID") String attachmentId,
                              @RequestParam("ATTACHMENT_NAME") String attachmentName,
                              @RequestParam("COMPANY") String company,
                              HttpServletResponse response,
                              HttpServletRequest request) throws UnsupportedEncodingException {

        if(!FileUploadUtil.checkFile(files.getOriginalFilename())){
            return "文件类型错误";
        }

        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding("UTF-8");
        }

        ContextHolder.setConsumerType(company);
        System.setProperty("sun.jnu.encoding", "UTF-8");

        if (!StringUtils.checkNull(aid)) {
            Attachment attachment = enclosureService.selectByAid(Integer.parseInt(aid));
            if (attachment != null) {
                attachmentName = attachment.getAttachName();
            }
        } else {
            String attachmentName1 = request.getParameter("ATTACHMENT_NAME");
            String aName = "";
            if (attachmentName1.substring(attachmentName1.length() - 1, attachmentName1.length()).equals("*")) {
                aName = attachmentName1.substring(0, request.getParameter("ATTACHMENT_NAME").length() - 1);
            } else {
                aName = attachmentName1;
            }
            attachmentName = URLDecoder.decode(aName, "UTF-8");
        }


        //读取配置文件
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
            buffer = buffer.append(rb.getString("upload.win"));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
            buffer = buffer.append(rb.getString("upload.linux"));
        }
        //String basePath="D:"+System.getProperty("file.separator");
        String userAgent = request.getHeader("user-agent").toLowerCase();


        //String fileName = new String(files.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
        /*if (userAgent.contains("msie") || userAgent.contains("like gecko") ) {
			 // win10 ie edge 浏览器 和其他系统的ie
			 attachmentName = new String(attachmentName.getBytes("UTF-8"), "iso-8859-1");
		 }*/
//        String path = sb.toString() + System.getProperty("file.separator") + "attach" + System.getProperty("file.separator") + company +
//                System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym + System.getProperty("file.separator") + attachmentId + "." + attachmentName;

        //---------------------------------判断是否为Linux开始-------------------------------------

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        try {
            int codeLength = attachmentName.getBytes("UTF-8").length;
            String type = attachmentName.substring(attachmentName.lastIndexOf("."));
            // 判断是否文件名过长 并且是Linux 进行加密名称
            // 或者系统设置中 设置了加密
            if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                String realAttachmentName = attachmentName;
                String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                if(trim.length()>100){
                    attachmentName=(trim).substring(0,100)+type;
                } else {
                    attachmentName = trim+type;
                }

                StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(company, module, ym);

                String filePath = fullUploadPath.toString() + attachmentId + "." + attachmentName;

                File file = new File(filePath + ".xoafile");

                if(!file.exists()){
                    attachmentName = realAttachmentName;
                }
            }
        } catch (Exception e) {

        }


        //---------------------------------判断是否为Linux结束-------------------------------------

        String pathWithoutName = sb.toString() + System.getProperty("file.separator") + company +
                System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym ;

        String path = pathWithoutName + System.getProperty("file.separator") + attachmentId + "." + attachmentName;

        // 判断是否开启文件加密，开启加密后补充文件名称
        if (encryption) {
            path += ".xoafile";
        }

        try {
            File file = new File(path);
            // 如果文件存在
            if (file.exists()) {
                FileUploadUtil fileUploadUtil = new FileUploadUtil();
                /*try {
                    String ids = request.getParameter("id");//公文主键id
                    DocumentModelWithBLOBs documentModelWithBLOBs = documentMapper.selectById(Integer.parseInt(ids));
                    if (files.getSize() == 0 || files.getSize() < 10000) {
                        //复制正文 防止丢失  新建docx 0字节   doc 9kb
                        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

                        List<Attachment> act = new ArrayList<>();
                        Attachment attachment = enclosureService.selectByAid(Integer.parseInt(aid));
                        act.add(attachment);
                        List<Attachment> sonAttach = fileUploadUtil.copyFiles(act, company, "document", "document");
                        for (Attachment att : sonAttach) {
                            enclosureService.saveAttachment(att);
                        }
                        Object[] o = FileUploadUtil.reAttachment(sonAttach);
                        FlowRunLog log = new FlowRunLog();
                        log.setUserId(user.getUserId());
                        //log.setTime(new Date());
                        log.setType(Constant.TYPE22);
                        log.setContent("可能上传空的文件，，attachmentId=====" + o[0].toString().split(",")[0] + "attachmentName==" + o[1].toString().split("\\*")[0]);
                        log.setUid(user.getUid());
                        int i = flowRunLogMapper.insertSelective(log);
                    }
                    long length = file.length();//服务器文件
                    if (length > files.getSize()) {
                        // 新上传文件  比原件小  保存日志
                        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
                        List<Attachment> act = new ArrayList<>();
                        Attachment attachment = enclosureService.selectByAid(Integer.parseInt(aid));
                        File filess = new File(path+String.valueOf(new Date())+".bak");
                        fileUploadUtil.copyFileUsingFileChannels(file,filess);
                        act.add(attachment);
                        List<Attachment> sonAttach = fileUploadUtil.copyFiles(act, company, "document", "document");
                        for (Attachment att : sonAttach) {
                            enclosureService.saveAttachment(att);
                        }
                        Object[] o = FileUploadUtil.reAttachment(sonAttach);
                        FlowRunLog log = new FlowRunLog();
                        log.setRunId(documentModelWithBLOBs.getRunId());
                        log.setUserId(user.getUserId());
                        log.setRunId(documentModelWithBLOBs.getRunId());
                        log.setType(Constant.TYPE22);
                        log.setContent("新文件比原文件小，，attachmentId=====" + o[0].toString().split(",")[0] + "attachmentName==" + o[1].toString().split("\\*")[0]);
                        log.setUid(user.getUid());
                        int i = flowRunLogMapper.insertSelective(log);
                    }
                }catch (Exception e){

                }*/
                //备份原文件。文件名为：1111.doc.时间戳.bak
                File filess = new File(path + "." + String.valueOf(new Date().getTime()) + ".bak");
                fileUploadUtil.copyFileUsingFileChannels(file, filess);
                file.delete();
                //转存文件
                // 判断是否加密
                if (encryption) {
                    AESUtil.encryption(files, pathWithoutName, attachmentId + "." +attachmentName, company);
                } else {
                    files.transferTo(file);
                }
            }
            //复制正文--文件存档
            String id = request.getParameter("id");//公文主键id
            Attachment attachment = enclosureService.selectByAid(Integer.parseInt(aid));
            if (!StringUtils.checkNull(id)&&attachment != null) {
                attachmentName = attachment.getAttachName();

                String saveType = request.getParameter("saveType");//判断是否需要复制文件
                if (!StringUtils.checkNull(saveType)) {
                }
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月30日 上午9:52:22
     * 方法介绍:   删除
     * 参数说明:   @param aid 附件主键
     * 参数说明:   @param module 模块
     * 参数说明:   @param ym 年月
     * 参数说明:   @param attachmentId 附件id
     * 参数说明:   @param attachmenrName 附件名字
     * 参数说明:   @param company 公司
     * 参数说明:   @param response 响应
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     *
     * @return boolean 是否成功
     */
    @RequestMapping(value = {"/delete"}, produces = {"application/json;charset=UTF-8"})
    @ResponseBody
    public ToJson delete(@RequestParam("AID") String aid,
                         @RequestParam("MODULE") String module,
                         @RequestParam("YM") String ym,
                         @RequestParam("ATTACHMENT_ID") String attachmentId,
                         @RequestParam("ATTACHMENT_NAME") String attachmentName,
                         @RequestParam("COMPANY") String company,
                         HttpServletResponse response,
                         HttpServletRequest request) {
        return enclosureService.delete(aid, module, ym, attachmentId, attachmentName, company, response, request);
    }


    /**
     * 删除单个文件
     *
     * @param fileName 要删除的文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public static boolean deleteFile(String fileName) {
        File file = new File(fileName);
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
//                System.out.println("删除单个文件" + fileName + "成功！");
                return true;
            } else {
//                System.out.println("删除单个文件" + fileName + "失败！");
                return false;
            }
        } else {
//            System.out.println("删除单个文件失败：" + fileName + "不存在！");
            return false;
        }
    }

    @RequestMapping(value = {"/xs"}, produces = {"application/json;charset=UTF-8"})
    public void loadImage(@RequestParam("AID") int aid,
                          @RequestParam("MODULE") String module,
                          @RequestParam("YM") String ym,
                          @RequestParam("ATTACHMENT_ID") String attachmentId,
                          @RequestParam("ATTACHMENT_NAME") String attachmentName,
                          @RequestParam("COMPANY") String company,
                          HttpServletResponse response,
                          HttpServletRequest request) throws Exception {

        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        if (company.contains("null") || StringUtils.checkNull(company)) {
            List<OrgManage> org = orgManageMapper.queryId();
            if (org != null && org.size() > 0) {
                company = "xoa" + org.get(0).getOid().toString().trim();
            }
        }

        ContextHolder.setConsumerType(company);

        if (aid != 0) {
            Attachment attachment = enclosureService.selectByAid(aid);
            if (attachment != null) {
                attachmentName = attachment.getAttachName();
            }

        } else {
            if (!MobileCheck.isMobileDevice(request.getHeader("user-agent"))) {
                //lr改动
                //attachmentName = URLEncoder.encode(attachmentName,"UTF-8");
                //attachmentName = attachmentName.replaceAll("%(?![0-9a-fA-F]{2})", "%25");
                attachmentName = URLDecoder.decode(attachmentName, "utf-8");
            }
        }
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        if (osName.toLowerCase().startsWith("win")) {
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if (basePath.indexOf("/xoa") != -1) {
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2 = basePath.substring(0, index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
            buffer = buffer.append(rb.getString("upload.win"));
        } else {
            sb = sb.append(rb.getString("upload.linux"));
            buffer = buffer.append(rb.getString("upload.linux"));
        }

        if (attachmentName.substring(attachmentName.length() - 1, attachmentName.length()).equals("*")) {
            attachmentName = attachmentName.substring(0, request.getParameter("ATTACHMENT_NAME").length() - 1);
        }

        // 处理Linux系统下  大写后缀文件上传上去后 变小写 预览不到的问题
        if (!osName.toLowerCase().startsWith("win")) {
            attachmentName = attachmentName.substring(0,attachmentName.lastIndexOf(".") + 1)+attachmentName.substring(attachmentName.lastIndexOf(".") + 1).toLowerCase();
        }


        //---------------------------------判断是否为Linux开始-------------------------------------

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        try {
            int codeLength = attachmentName.getBytes("UTF-8").length;
            String type = attachmentName.substring(attachmentName.lastIndexOf("."));
            // 判断是否文件名过长 并且是Linux 进行加密名称
            // 或者系统设置中 设置了加密
            if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                String realAttachmentName = attachmentName;
                String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                if(trim.length()>100){
                    attachmentName=(trim).substring(0,100)+type;
                } else {
                    attachmentName = trim+type;
                }

                StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(company, module, ym);

                String filePath = fullUploadPath.toString() + attachmentId + "." + attachmentName;

                File file = new File(filePath + ".xoafile");

                if(!file.exists()){
                    attachmentName = realAttachmentName;
                }
            }
        } catch (Exception e) {

        }


        //---------------------------------判断是否为Linux结束-------------------------------------


        //String basePath="D:"+System.getProperty("file.separator");
//        String path = sb.toString() + System.getProperty("file.separator") + "attach" + System.getProperty("file.separator") + company +
//                System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym + System.getProperty("file.separator") + attachmentId + "." + attachmentName;
        String path = sb.toString() + System.getProperty("file.separator") + company +
                System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym + System.getProperty("file.separator") + attachmentId + "." + attachmentName;

        FileInputStream inputStream = null;
        OutputStream os = null;
        File file = null;
        try {
            boolean bol = false;
            file = new File(path);
            // 如果文件不存在
            if (!file.exists()) {
                file = new File(path + ".xoafile");
                bol = true;
                if (!file.exists()) {
                    request.setAttribute("message", Constant.exesit);
                    return;
                }
            }
            //预览txt中文乱码问题
            String suffixType = attachmentName.substring(attachmentName.lastIndexOf(".")+1);
            if("txt".equals(suffixType.toLowerCase())){
                response.setContentType("text/plain;charset=UTF-8");
            } else if ("png".equals(suffixType.toLowerCase())){
                response.setContentType("image/png;charset=UTF-8");
            } else if ("jpg".equals(suffixType.toLowerCase())){
                response.setContentType("image/jpeg;charset=UTF-8");
            } else if ("gif".equals(suffixType.toLowerCase())){
                response.setContentType("image/gif;charset=UTF-8");
            } else if ("pdf".equals(suffixType.toLowerCase())){
                response.setContentType("application/pdf;charset=UTF-8");
            } else if ("bmp".equals(suffixType.toLowerCase())){
                response.setContentType("application/x-bmp;charset=UTF-8");
            }
            os = response.getOutputStream();
            byte[] abc = AESUtil.download(file, sqlType, bol);
            os.write(abc, 0, abc.length);


        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
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


    /**
     * 作者: 张航宁
     * 日期: 2018/1/23
     * 说明: 根据AID查询附件信息
     */
    @ResponseBody
    @RequestMapping("attachment/findByAid")
    public ToJson<Attachment> findByAttachId(int aid, String module, HttpServletRequest request) {
        return enclosureService.selectByPrimaryKey(aid, module, request);
    }

    @ResponseBody
    @RequestMapping("attachment/findByAids")
    public ToJson<Attachment> findByAIds(String aids, HttpServletRequest request) {
        return enclosureService.findByAIds(aids, request);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/7/10
     * @说明: Base64上传
     */
    @ResponseBody
    @RequestMapping("/uploadBase64")
    public void uploadBase64(@RequestParam("fileStr") String fileStr, String module,
                             @RequestParam(value = "company", required = false) String company,
                             HttpServletRequest request, HttpServletResponse response, String fileName) {
        MultipartFile[] files = new MultipartFile[1];
        files[0] = Base64ToImageUtil.base64MutipartFile(fileStr);
        uploadScan(files, module, company, request, response, fileName);
    }

    @ResponseBody
    @RequestMapping("wordToHtmlPrivew")
    public BaseWrapper wordToHtml(String module,
                                  @RequestParam(value = "company", required = false) String company,
                                  Integer aid,
                                  HttpServletRequest request, HttpServletResponse response){
        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder sb = new StringBuilder();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa").append(company);
            } else {
                if("mysql".equals(FileUploadUtil.getDriver())){
                    sb.append("xoa" +company);
                } else if ("kingbase8".equals(FileUploadUtil.getDriver())){
                    sb.append("xoaKB" +company);
                } else if ("dm".equals(FileUploadUtil.getDriver())){
                    sb.append("xoaDM" +company);
                }
            }
        } else {
            sb.append(company);
        }
        if(sb.length()>4){
            company = sb.toString();
        }
        try {
            Attachment attachment = enclosureService.selectByAid(aid);
            if(attachment==null){
                baseWrapper.setMsg("附件不存在");
                baseWrapper.setFlag(false);
                baseWrapper.setStatus(false);
                return baseWrapper;
            }


            StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(sb.toString(), module,attachment.getYm());

            // 查询是否加密
            boolean encryption = sysTasksService.isEncryption();
            String attachmentName = attachment.getAttachName();

            String osName = System.getProperty("os.name");

            // 处理Linux系统下  大写后缀文件上传上去后 变小写 预览不到的问题
            if (!osName.toLowerCase().startsWith("win")) {
                attachmentName = attachmentName.substring(0,attachmentName.lastIndexOf(".") + 1)+attachmentName.substring(attachmentName.lastIndexOf(".") + 1).toLowerCase();
            }


            File tempFile = null;
            try {
                
                int codeLength = attachmentName.getBytes("UTF-8").length;
                String type = attachmentName.substring(attachmentName.lastIndexOf("."));
                // 判断是否文件名过长 并且是Linux 进行加密名称
                // 或者系统设置中 设置了加密
                if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                    String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                    String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                    String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                    if(trim.length()>100){
                        attachmentName=(trim).substring(0,100)+type;
                    } else {
                        attachmentName = trim+type;
                    }
                    String filePath = fullUploadPath.toString() + attachment.getAttachId() + "." + attachmentName;
                    File file = new File(filePath + ".xoafile");
                    // 判断是否存在加密附件 如果不存在的话 有可能是开启加密之前生成的附件
                    if(file.exists()){
                        byte[] download = AESUtil.download(file, "xoa" + company, true);
                        tempFile = new File(filePath);
                        FileOutputStream fileOutputStream = new FileOutputStream(tempFile);
                        BufferedOutputStream out = new BufferedOutputStream(fileOutputStream);
                        out.write(download);
                        out.close();
                        fileOutputStream.close();
                    } else {
                        attachmentName = attachment.getAttachName();
                    }
                }
            } catch (Exception e) {

            }
            
            resultMap.put("attachName", attachment.getAttachName());
            resultMap.put("size",attachment.getSize());

            fullUploadPath.append(attachment.getAttachId()).append(".").append(attachmentName);
            String htmlWordContent = null;
            boolean usePoiFlag = true;
            SysPara word_to_html_open = sysParaMapper.querySysPara("WORD_TO_HTML_OPEN");
            SysPara outside_address = sysParaMapper.querySysPara("OUTSIDE_ADDRESS");
            SysPara word_to_html_address = sysParaMapper.querySysPara("WORD_TO_HTML_ADDRESS");
            if(outside_address==null||StringUtils.checkNull(outside_address.getParaValue())){
                outside_address = new SysPara();
                outside_address.setParaValue("");
            } else if(word_to_html_address!=null&&!StringUtils.checkNull(word_to_html_address.getParaValue())
                    &&(word_to_html_address.getParaValue().contains("127.0.0.1")||word_to_html_address.getParaValue().contains("localhost"))){
                outside_address.setParaValue("");
            }
            if(System.getProperty("os.name").toLowerCase().startsWith("win")||(word_to_html_open!=null&&"1".equals(word_to_html_open.getParaValue()))){
                try{
                    // 生成html文件
                    String htmlFilePath = fullUploadPath.substring(0,fullUploadPath.lastIndexOf("."))+".html";
                    JacobUtil.wordToHtml(fullUploadPath.toString(),htmlFilePath);
                    // 转换成document 用来操作img
                    Document htmlDocument = Jsoup.parse(new File(htmlFilePath),"GBK");
                    Elements img = htmlDocument.getElementsByTag("img");
                    for (int i = 0; i < img.size(); i++) {
                        Element element = img.get(i);
                        // /xs?AID=6534&MODULE=interface&COMPANY=xoa1001&YM=2004&ATTACHMENT_ID=1004120885&ATTACHMENT_NAME=JD.png

                        String imgName = element.attr("src").substring(element.attr("src").indexOf(".")+1);
                        element.attr("src",outside_address.getParaValue()+"/ueditor/xsFilesImg?AID=0&YM="+attachment.getYm()+"&COMPANY="+company+"&MODULE="+module+"&ATTACHMENT_ID="+attachment.getAttachId()+"&ATTACHMENT_NAME="+imgName);
                    }
                    htmlWordContent = htmlDocument.toString();
                    usePoiFlag = false;
                    baseWrapper.setMsg("Jacob转换");
                }catch (Exception e){
                    System.out.println("Jacob异常信息：");
                    e.printStackTrace();
                } finally {
                    if(usePoiFlag){
                        htmlWordContent = poi2Html(module, company, fullUploadPath, outside_address);
                        resultMap.put("htmlWordContent",htmlWordContent);
                        baseWrapper.setData(resultMap);
                        baseWrapper.setFlag(true);
                        baseWrapper.setStatus(true);
                        baseWrapper.setMsg("Jacob插件转换异常，使用poi插件转换");

                        // 删除解密后的临时文件
                        if(tempFile!=null&&tempFile.exists()&&tempFile.length()>0){
                            boolean delete = tempFile.delete();
                        }

                        return baseWrapper;
                    }
                }
            } else {
                baseWrapper.setMsg("poi转换");
                htmlWordContent = poi2Html(module, company, fullUploadPath, outside_address);
            }

            resultMap.put("htmlWordContent",htmlWordContent);
            baseWrapper.setData(resultMap);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);

            // 删除解密后的临时文件
            if(tempFile!=null&&tempFile.exists()&&tempFile.length()>0){
                tempFile.delete();
            }


        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setMsg("服务器异常："+e.getMessage());
            baseWrapper.setFlag(false);
            baseWrapper.setStatus(false);
        }
        return baseWrapper;
    }

    @ResponseBody
    @RequestMapping("pdfToImgPrivew")
    public BaseWrapper pdfToImgPrivew(String module,
                                      @RequestParam(value = "company", required = false) String company,
                                      Integer aid,
                                      HttpServletRequest request, HttpServletResponse response){

        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder sb = new StringBuilder();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa").append(company);
            } else {
                sb.append("xoa").append((String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        if(sb.length()>4){
            company = sb.toString();
        }
        try {
            Attachment attachment = enclosureService.selectByAid(aid);
            if(attachment==null){
                baseWrapper.setMsg("附件不存在");
                baseWrapper.setFlag(false);
                baseWrapper.setStatus(false);
                return baseWrapper;
            }

            StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(sb.toString(), module,attachment.getYm());
            fullUploadPath.append(attachment.getAttachId()).append(".").append(attachment.getAttachName());
            String htmlWordContent = null;
            boolean usePoiFlag = true;
            SysPara outside_address = sysParaMapper.querySysPara("OUTSIDE_ADDRESS");
            if(outside_address==null||StringUtils.checkNull(outside_address.getParaValue())){
                outside_address = new SysPara();
                outside_address.setParaValue("");
            }

            String attUrl = "xs?AID=0&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId()+
                    "&FILESIZE=0&ATTACHMENT_NAME=";

            List<String> imgUrls = File2Img.pdf2jpg(fullUploadPath.toString(), attachment.getAttachName(), attUrl);


            resultMap.put("attachName",attachment.getAttachName());
            resultMap.put("size",attachment.getSize());
            resultMap.put("imgList",imgUrls);
            baseWrapper.setData(resultMap);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);


        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setMsg("服务器异常："+e.getMessage());
            baseWrapper.setFlag(false);
            baseWrapper.setStatus(false);
        }
        return baseWrapper;
    }

    @Autowired
    private OfficePluginManager officePluginManager;

    // excel 预览
    @ResponseBody
    @RequestMapping("excelPreview")
    public BaseWrapper excelPreview(String module,
                                      @RequestParam(value = "company", required = false) String company,
                                      Integer aid,
                                      HttpServletRequest request, HttpServletResponse response){

        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder sb = new StringBuilder();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa").append(company);
            } else {
                sb.append("xoa").append((String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        if(sb.length()>4){
            company = sb.toString();
        }
        try {
            Attachment attachment = enclosureService.selectByAid(aid);
            if(attachment==null){
                baseWrapper.setMsg("附件不存在");
                baseWrapper.setFlag(false);
                baseWrapper.setStatus(false);
                return baseWrapper;
            }

            StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(sb.toString(), module,attachment.getYm());

            // 查询是否加密
            boolean encryption = sysTasksService.isEncryption();
            String attachmentName = attachment.getAttachName();

            String osName = System.getProperty("os.name");

            // 处理Linux系统下  大写后缀文件上传上去后 变小写 预览不到的问题
            if (!osName.toLowerCase().startsWith("win")) {
                attachmentName = attachmentName.substring(0,attachmentName.lastIndexOf(".") + 1)+attachmentName.substring(attachmentName.lastIndexOf(".") + 1).toLowerCase();
            }


            File tempFile = null;
            try {

                int codeLength = attachmentName.getBytes("UTF-8").length;
                String type = attachmentName.substring(attachmentName.lastIndexOf("."));
                // 判断是否文件名过长 并且是Linux 进行加密名称
                // 或者系统设置中 设置了加密
                if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                    String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                    String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                    String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                    if(trim.length()>100){
                        attachmentName=(trim).substring(0,100)+type;
                    } else {
                        attachmentName = trim+type;
                    }
                    String filePath = fullUploadPath.toString() + attachment.getAttachId() + "." + attachmentName;
                    File file = new File(filePath + ".xoafile");
                    // 判断是否存在加密附件 如果不存在的话 有可能是开启加密之前生成的附件
                    if(file.exists()){
                        byte[] download = AESUtil.download(file, "xoa" + company, true);
                        tempFile = new File(filePath);
                        FileOutputStream fileOutputStream = new FileOutputStream(tempFile);
                        BufferedOutputStream out = new BufferedOutputStream(fileOutputStream);
                        out.write(download);
                        out.close();
                        fileOutputStream.close();
                    } else {
                        attachmentName = attachment.getAttachName();
                    }

                }
            } catch (Exception e) {

            }

            resultMap.put("attachName",attachment.getAttachName());
            resultMap.put("size",attachment.getSize());

            fullUploadPath.append(attachment.getAttachId()).append(".").append(attachmentName);
            String htmlContent = null;
            boolean usePoiFlag = true;
            SysPara outside_address = sysParaMapper.querySysPara("OUTSIDE_ADDRESS");
            if(outside_address==null||StringUtils.checkNull(outside_address.getParaValue())){
                outside_address = new SysPara();
                outside_address.setParaValue("");
            }

            OfficeDocumentConverter converter = officePluginManager.getDocumentConverter();
            String inputFilePath = fullUploadPath.toString();
            String outputFilePath =  FileUploadUtil.getFullUploadPath(sb.toString(), "cache",attachment.getYm())
                    .append(attachment.getAttachId()).append(".").append(attachment.getAid()).append(".html").toString();
            if (null != inputFilePath) {
                File inputFile = new File(inputFilePath);
                File outputFile = new File(outputFilePath);

                // 判断需要预览的文件是否存在
                if (inputFile.exists()) {
                    // 需要预览的文件存在，生成预览文件
                    // 预览应该每次重新生成文件，无需判断是否已存在预览文件
                    converter.convert(inputFile, outputFile);
                }

                if(outputFile.exists()){
                    Document htmlDocument = null;
                    if(osName.toLowerCase().startsWith("win")){
                        htmlDocument = Jsoup.parse(outputFile, "GBK");
                    } else {
                        htmlDocument = Jsoup.parse(outputFile,"UTF-8");
                    }
                    if(htmlDocument!=null){
                        Elements imgs = htmlDocument.getElementsByTag("img");
                        for (Element img:imgs) {
                            String imgName = img.attr("src");
                            imgName = imgName.replace(attachment.getAttachId()+".","");
                            String attUrl = "/xs?AID=0&MODULE=cache&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId()+
                                    "&FILESIZE=0&ATTACHMENT_NAME="+imgName;
                            img.attr("src",attUrl);
                        }
                    }
                    htmlContent = htmlDocument.toString();
                }
            }

            resultMap.put("htmlContent",htmlContent);

            baseWrapper.setData(resultMap);
            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);

            // 删除解密后的临时文件
            if(tempFile!=null&&tempFile.exists()&&tempFile.length()>0){
                boolean delete = tempFile.delete();
            }

        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setMsg("服务器异常："+e.getMessage());
            baseWrapper.setFlag(false);
            baseWrapper.setStatus(false);
        }
        return baseWrapper;
    }

    @ResponseBody
    @RequestMapping("pptPreview")
    public BaseWrapper pptPreview(String module,
                                    @RequestParam(value = "company", required = false) String company,
                                    Integer aid,
                                    HttpServletRequest request, HttpServletResponse response){

        BaseWrapper baseWrapper = new BaseWrapper();
        Map<String,Object> resultMap = new HashMap<>();
        StringBuilder sb = new StringBuilder();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa").append(company);
            } else {
                sb.append("xoa").append((String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        if(sb.length()>4){
            company = sb.toString();
        }
        try {
            Attachment attachment = enclosureService.selectByAid(aid);
            if(attachment==null){
                baseWrapper.setMsg("附件不存在");
                baseWrapper.setFlag(false);
                baseWrapper.setStatus(false);
                return baseWrapper;
            }

            resultMap.put("attachName",attachment.getAttachName());
            resultMap.put("size",attachment.getSize());

            StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(sb.toString(), module,attachment.getYm());
            fullUploadPath.append(attachment.getAttachId()).append(".").append(attachment.getAttachName());

            OfficeDocumentConverter converter = officePluginManager.getDocumentConverter();
            String inputFilePath = fullUploadPath.toString();
            String outputFilePath =  FileUploadUtil.getFullUploadPath(sb.toString(), "cache",attachment.getYm())
                    .append(attachment.getAttachId()).append(".").append(attachment.getAid()).append(".pdf").toString();
            if (null != inputFilePath) {
                File inputFile = new File(inputFilePath);
                File outputFile = new File(outputFilePath);

                if (inputFile.exists()&&!outputFile.exists()) {
                    converter.convert(inputFile, outputFile);
                }
                if(outputFile.exists()){
                    String attUrl = "xs?AID=0&MODULE=cache&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId()+
                            "&FILESIZE=0&ATTACHMENT_NAME=";

                    List<String> imgUrls = File2Img.pdf2jpg(outputFilePath, attachment.getAid()+".pdf", attUrl);

                    resultMap.put("imgList",imgUrls);
                    baseWrapper.setData(resultMap);
                }
            }


            baseWrapper.setFlag(true);
            baseWrapper.setStatus(true);

        } catch (Exception e) {
            e.printStackTrace();
            baseWrapper.setMsg("服务器异常："+e.getMessage());
            baseWrapper.setFlag(false);
            baseWrapper.setStatus(false);
        }
        return baseWrapper;
    }


    private String poi2Html(String module, String company, StringBuilder fullUploadPath, SysPara outside_address) {
        String htmlWordContent;
        Map htmlMap = WordHtml.wordToHtml(company, module, fullUploadPath.toString());
        ArrayList<Attachment> attendList = (ArrayList<Attachment>) htmlMap.get("attendList");
        String strs = (String) htmlMap.get("content");
        for (Attachment attachment:attendList) {
            String key = attachment.getAttachId();
            enclosureService.saveAttachment(attachment);
            String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId()+
                    "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize() + "\"";
            String url = "<img src=\""+ outside_address.getParaValue()+"/xs?" + attUrl +
                    "title=\"\" " +
                    "_src=\"/xs?" + attUrl +
                    "alt=\"\"/>";
            strs = strs.replace("<img>" + key + "</img>", url);
        }

        strs = strs.replace("<span style=\"font-size", "<span style=\"font-family:&#39;方正仿宋_GBK&#39;;font-size");
        strs = strs.replace("border-bottom:thin solid red;border-left:thin solid black;border-right:thin solid black;border-top:thin solid black;", "");
        strs = strs.replace("<div style=\"width:", "<div style=\"")
                .replace("font-family:Calibri","font-family:方正仿宋_GBK");

        Document htmlDocument = Jsoup.parse(strs);
        Elements X3Element = htmlDocument.getElementsByClass("X3");
        for (int i = 0; i < X3Element.size(); i++) {
            Element element = X3Element.get(i);
            if(element.tagName().equals("span")){
                element.text(element.text().replace(".%","."));
            }
        }
        htmlWordContent = htmlDocument.toString();

        return htmlWordContent;
    }

    public void uploadScan(@RequestParam("file") MultipartFile[] files, String module,
                           @RequestParam(value = "company", required = false) String company,
                           HttpServletRequest request, HttpServletResponse response, String fileNmae) {
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        if((!StringUtils.checkNull(company)&&company.contains(".."))||(!StringUtils.checkNull(module)&&module.contains(".."))){
            return;
        }

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!FileUploadUtil.checkFile(file.getOriginalFilename())){
                return ;
            }
        }


        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa" + company);
            } else {
                sb.append("xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        response.setHeader("content-type", "text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        try (ServletOutputStream out = response.getOutputStream();
             OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");) {
          /*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*/
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                }
            }
            if (a) {
                json.setFlag(1);
                json.setMsg("The file size is 0");
            } else {
                List<Attachment> list = enclosureService.uploadScan(files, sb.toString(), module, fileNmae);
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }


            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return;
    }

    public static void writer(HttpServletResponse response, String str) {
        try (PrintWriter out = response.getWriter();) {
            //设置页面不缓存
            response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setCharacterEncoding("UTF-8");
            out.print(str);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    //ie预览PDF
    @RequestMapping("pdfPreview")
    public String pdfPreView(HttpServletRequest request) {
        return "app/common/PdfPreView";
    }

    //上传视频
    @RequestMapping(value = "/uploadVideo", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    void uploadVideo(@RequestParam("file") MultipartFile[] files, String module,
                     @RequestParam(value = "company", required = false) String company,
                     HttpServletRequest request, HttpServletResponse response) {
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!FileUploadUtil.checkFile(file.getOriginalFilename())){
                return ;
            }
        }

        StringBuffer sb = new StringBuffer();
        if (StringUtils.checkNull(company)) {
            company = (String) request.getSession().getAttribute(
                    "loginDateSouse");
            if (StringUtils.checkNull(company)) {
                List<OrgManage> org = orgManageMapper.queryId();
                if (org != null && org.size() > 0) {
                    company = org.get(0).getOid().toString().trim();
                }
                sb.append("xoa" + company);
            } else {
                sb.append("xoa" + (String) request.getSession().getAttribute(
                        "loginDateSouse"));
            }
        } else {
            sb.append(company);
        }
        try {
          /*  System.setProperty("sun.jnu.encoding","UTF-8");
            System.setProperty("file.encoding","UTF-8");*/
            boolean a = false;
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                }
            }
            if (a) {
                json.setFlag(1);
                json.setMsg("The file size is 0");
            } else {
                List<Attachment> list = enclosureService.upload2(files, sb.toString(), module);
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);
            }

            response.setHeader("content-type", "text/html;charset=utf-8");
            response.setCharacterEncoding("utf-8");
            ServletOutputStream out = response.getOutputStream();
            OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");

            ow.write(JSONObject.toJSONString(json));
            ow.flush();
            ow.close();
            //response.setContentType("application/json");
            //writer(response, JSONObject.toJSONString(json));
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return;
    }

    @Autowired
    OnlyOfficeCodeManager onlyOfficeCodeManager;

    // onlyOffice 下载密钥生成接口
    @ResponseBody
    @RequestMapping("onlyOfficeCode")
    public BaseWrapper onlyOfficeCode(HttpServletRequest request){
        return onlyOfficeCodeManager.onlyOfficeCode(request);
    }


    // onlyOffice 下载显示接口
    @RequestMapping("onlyOfficeDownload")
    public String onlyOfficeDownload(@RequestParam(value = "AID", required = false) Integer aid,
                           @RequestParam("MODULE") String module,
                           @RequestParam("YM") String ym,
                           @RequestParam("ATTACHMENT_ID") String attachmentId,
                           @RequestParam("COMPANY") String company,
                           String isOld,
                           String code,
                           HttpServletResponse response,
                           HttpServletRequest request) throws Exception {

        if(onlyOfficeCodeManager.hasCode(code)){
            onlyOfficeCodeManager.removeCode(code);
            return download(aid, module, ym, attachmentId, company, isOld, response, request);
        }
        return null;
    }

    // onlyOffice 回调保存接口
    @RequestMapping(path = "/onlyOfficeCallBack", method = {RequestMethod.POST, RequestMethod.GET})
    public void onlyOfficeCallBack(HttpServletRequest request, HttpServletResponse response,
                                   @RequestParam(value = "AID", required = false) Integer aid,
                                   @RequestParam("MODULE") String module,
                                   @RequestParam("YM") String ym,
                                   @RequestParam("ATTACHMENT_ID") String attachmentId,
                                   @RequestParam("COMPANY") String company) throws IOException {
        PrintWriter writer = response.getWriter();
        Scanner scanner = new Scanner(request.getInputStream()).useDelimiter("\\A");
        String body = scanner.hasNext() ? scanner.next() : "";
        JSONObject jsonObj = JSONObject.parseObject(body);


        if(aid!=null&&aid<=0){
            writer.write("{\"error\":1}");
        }

        String status = jsonObj.getString("status");

        if("6".equals(status)||"2".equals(status)){
            // status 状态
            /* 0 - 找不到带有密钥标识符的文档，
            * 1 - 正在编辑文档，
            * 2 - 文件已准备好保存，
            * 3 - 发生了文档保存错误，
            * 4 - 文件关闭，没有变化，
            * 6 - 正在编辑文档，但保存当前文档状态，
            * 7 - 强制保存文档时发生错误。
             */

            try {

                Attachment attachment = enclosureService.selectByAid(aid);

                StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(company, module, ym);


                String filePath = fullUploadPath.append(attachment.getAttachId()).append(".").append(attachment.getAttachName()).toString();

                jsonObj.put("attachmentInfo",attachment);
                jsonObj.put("infoExt",request.getParameter("infoExt"));
                // 将文件下载到本地进行保存 同时保存历史记录
                boolean b = onlyOfficeCodeManager.onlyOfficeFileSave(jsonObj ,filePath);

                if(!b){
                    writer.write("{\"error\":1}");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        writer.write("{\"error\":0}");
    }

    @ResponseBody
    @RequestMapping("getOnlyOfficeFileHistroy")
    public BaseWrapper getOnlyOfficeFileHistroy(Integer aid){
        BaseWrapper baseWrapper = new BaseWrapper();

        List<OnlyOfficeHistoryWithBLOBs> fileHistory = onlyOfficeCodeManager.getFileHistory(aid);

        baseWrapper.setData(fileHistory);
        baseWrapper.setTrue();
        return baseWrapper;
    }




}
	
