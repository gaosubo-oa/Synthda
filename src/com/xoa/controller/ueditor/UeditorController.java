package com.xoa.controller.ueditor;

import com.alibaba.fastjson.JSONObject;
import com.baidu.ueditor.ActionEnter;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.users.OrgManageMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.OrgManage;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.MobileCheck;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.file.WordHtml;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2018/5/22.
 */
@Controller
@RequestMapping("/ueditor")
public class UeditorController {

    @Autowired
    private EnclosureService enclosureService;


    @Autowired
    private OrgManageMapper orgManageMapper;

    @Autowired
    private SysParaMapper sysParaMapper;

    @Autowired
    private SysTasksService sysTasksService;


    // 配置文件统一控制接口
    @RequestMapping("/config")
    public void controller(HttpServletRequest request,HttpServletResponse response) {
        response.setContentType("application/json");
        String rootPath = request.getSession().getServletContext().getRealPath("/")+"ui/lib";
        System.out.println("rootPath:"+ rootPath);
        try {
            String exec = new ActionEnter(request, rootPath).exec();
            PrintWriter writer = response.getWriter();
            writer.write(exec);
            writer.flush();
            writer.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
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
    @RequestMapping(value = "/upload", produces = {"application/json;charset=UTF-8"})
    public @ResponseBody
    void upload(@RequestParam("upfile") MultipartFile[] files, String module,
                @RequestParam(value = "company", required = false) String company,
                HttpServletRequest request, HttpServletResponse response) {
        ToJson<Attachment> json = new ToJson<Attachment>(0, null);
        Map<String, Object> map = new HashMap<String, Object>();

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
                List<Attachment> list = enclosureService.upload(files, sb.toString(), module);
                for (Attachment li : list) {//2020/5/29 返回时去除attachName filesize
                    //AID=110407&MODULE=ueditor&COMPANY=xoa1001&YM=2005&ATTACHMENT_ID=1615625065&ATTACHMENT_NAME=阿斯达克.jpg&FILESIZE=90.9 KB
                    String s1 = li.getAttUrl().split("&ATTACHMENT_NAME=")[0];
                    li.setAttUrl(s1 + "&ATTACHMENT_NAME=");
                }
                json.setObj(list);
                json.setMsg("OK");
                json.setFlag(0);

                if (list != null && list.size() > 0) {
                    map.put("url", "/xs?" + list.get(0).getAttUrl());
                    map.put("state", "SUCCESS");
                    map.put("title", "");
                    map.put("original", "");
                    map.put("attachmentName", list.get(0).getAttachName());
                }
            }

            response.setHeader("content-type", "text/html;charset=utf-8");
            response.setCharacterEncoding("utf-8");
            ServletOutputStream out = response.getOutputStream();
            OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");

            ow.write(JSONObject.toJSONString(map));
            ow.flush();
            ow.close();

        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
            try {
                Map<String,Object> err = new HashMap<String,Object>();
                err.put("state", "FALSE");
                err.put("msg","上传失败！");
                err.put("errMsg",e.getMessage());
                ServletOutputStream out = response.getOutputStream();
                OutputStreamWriter ow = new OutputStreamWriter(out,"UTF-8");
                ow.write(JSONObject.toJSONString(err));
                ow.flush();
                ow.close();
            }catch (Exception q){

            }
        }

        return;
    }

    @RequestMapping(value = {"/xsFilesImg"}, produces = {"application/json;charset=UTF-8"})
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


        //---------------------------------判断是否为Linux开始-------------------------------------



        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        // 获取加密附件名
        attachmentName = FileUploadUtil.getEncryptionName(attachmentId, attachmentName, company, module, ym, encryption);



        //---------------------------------判断是否为Linux结束-------------------------------------

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

    @ResponseBody
    @RequestMapping("wordToHtml")
    public void wordToHtml(@RequestParam("file") MultipartFile[] files, String module,
                           @RequestParam(value = "company", required = false) String company,
                           HttpServletRequest request, HttpServletResponse response){
        Map<String, Object> map = new HashMap<String, Object>();

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
            boolean a = false;
            String fileType = ".doc";
            for (int i = 0; i < files.length; i++) {
                MultipartFile file = files[i];
                if (file.getSize() == 0) {
                    a = true;
                } else {
                    fileType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
                }
            }

            if (a) {
                map.put("state", "FALSE");
                map.put("flag",false);
                map.put("msg","文件大小为0");
            } else {
                String fName = "word2html"+System.currentTimeMillis()+fileType;
                List<Attachment>   list = enclosureService.uploadReturn(files, sb.toString(), module,fName);
                if(list!=null&&list.size()>0){
                    Attachment attachment = list.get(0);
                    StringBuilder fullUploadPath = FileUploadUtil.getFullUploadPath(sb.toString(), module,attachment.getYm());
                    fullUploadPath.append(attachment.getAttachId()).append(".").append(fName);
                    String htmlWordContent = "";
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
                        }catch (Exception e){
                            System.out.println("Jacob异常信息：");
                            e.printStackTrace();

                        } finally {
                            if(usePoiFlag){
                                htmlWordContent = poi2Html(module, company, fullUploadPath, outside_address);
                            }
                        }
                    } else {
                        htmlWordContent = poi2Html(module, company, fullUploadPath, outside_address);
                    }

                    map.put("htmlContent", htmlWordContent);
                }

                if (list != null && list.size() > 0) {
                    map.put("state", "SUCCESS");
                    map.put("flag", true);
                    map.put("title", "");
                    map.put("original", "");
                } else {
                    map.put("state", "FAILED");
                    map.put("flag", false);
                    map.put("title", "");
                    map.put("original", "");
                }

            }

            response.setHeader("content-type", "text/html;charset=utf-8");
            response.setCharacterEncoding("utf-8");
            ServletOutputStream out = response.getOutputStream();
            OutputStreamWriter ow = new OutputStreamWriter(out, "UTF-8");

            ow.write(JSONObject.toJSONString(map));
            ow.flush();
            ow.close();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            try {
                Map<String,Object> err = new HashMap<String,Object>();
                err.put("flag", false);
                err.put("state", "FALSE");
                err.put("msg","上传失败！");
                err.put("errMsg",e.getMessage());
                ServletOutputStream out = response.getOutputStream();
                OutputStreamWriter ow = new OutputStreamWriter(out,"UTF-8");
                ow.write(JSONObject.toJSONString(err));
                ow.flush();
                ow.close();
            }catch (Exception q){

            }
        }
    }

    private String poi2Html(String module, String company, StringBuilder fullUploadPath, SysPara outside_address) {
        String htmlWordContent;
        Map htmlMap = WordHtml.wordToHtml(company, module, fullUploadPath.toString());
        ArrayList<Attachment> attendList = (ArrayList<Attachment>) htmlMap.get("attendList");
        String strs = Objects.isNull(htmlMap.get("content")) ? "" : (String)htmlMap.get("content");
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
        strs = strs.replace("&lt;","<").replace("&gt;",">");
        strs = strs.replace("\"<img","<img").replace("alt=\"\"/>\"","alt=\"\"/>");
        Document htmlDocument = Jsoup.parse(strs);
        Elements X3Element = htmlDocument.getElementsByClass("X3");
        if(X3Element.size()>0){
            for (int i = 0; i < X3Element.size(); i++) {
                Element element = X3Element.get(i);
                if(element.tagName().equals("span")){
                    element.text(element.text().replace(".%","."));
                }
            }
            htmlWordContent = htmlDocument.toString().replace("\"<img","<img").replace("alt=\"\">\"","");
        } else {
            htmlWordContent = strs;
        }

        return htmlWordContent;
    }


}
