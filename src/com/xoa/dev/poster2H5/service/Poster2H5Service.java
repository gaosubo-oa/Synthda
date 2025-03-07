package com.xoa.dev.poster2H5.service;

import com.xoa.dev.poster2H5.model.Poster2H5;
import com.xoa.dev.posterH5.model.PosterH5;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.util.ToJson;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.entity.ContentType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.WritableRaster;
import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.ResourceBundle;

/**
 * 创建作者: 李彦洁
 * 创建日期: 2022/3/4 17:15
 * 类介绍:
 **/
@Service
public class Poster2H5Service {

    @Resource
    private EnclosureService enclosureService;

    public static String name1; // 第一行文本
    public static String name2; // 第二行文本

    // 海报生成
    public ToJson posterGenerate(HttpServletRequest request, Poster2H5 poster2H5){
        ToJson toJson = new ToJson(1,"error");

        String company = "xoa1001";
        String module = "poster2";

        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
        String filepath = "";
        String fontPath = request.getSession().getServletContext().getRealPath("");
        if (os.toLowerCase().startsWith("win")) {
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
                filepath = fontPath + "/ui/fonts";
            }
            sb.append(uploadPath);
            buffer = buffer.append(rb.getString("upload.win"));

        } else {
            sb = sb.append(rb.getString("upload.linux"));
            buffer = buffer.append(rb.getString("upload.linux"));
            filepath = fontPath + "/ui/fonts";
        }

        //存储路径
        String copyPath = "";
        request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        if (com.xoa.util.common.StringUtils.checkNull(sb.toString())) {
            String a = request.getRealPath("");
            sb.append(a);
            buffer.append(a);
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator"));
            buffer.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator"));
            copyPath = buffer.toString();
        } else {
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator"));
            buffer.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator"));
            copyPath = buffer.toString();
        }

        /*// 获取字体路径
        StringBuffer sbf = new StringBuffer();
        String root = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
        String str2 = "";
        if (root.indexOf("/xoa") != -1) {
            //获取字符串的长度
            int length = root.length();
            //返回指定字符在此字符串中第一次出现处的索引
            int index = root.indexOf("/xoa");
            //从指定位置开始到指定位置结束截取字符串
            str2 = root.substring(0, index);
        }
        sbf = sbf.append(str2 + "/xoa");
        String filepath = sbf + "/WebRoot/ui/fonts";*/

        // 原背景图路径
//        String backgroundUrl1 = sb +"/back1.png";
//        String backgroundUrl2 = sb +"/back2.png";
//        String backgroundUrl3 = sb +"/back3.png";
        String backgroundUrl1 = sb +"/";
        String backgroundUrl2 = sb +"/";
        String backgroundUrl3 = sb +"/";
        try {
//            File file1 = new File(backgroundUrl1);
//            File file2 = new File(backgroundUrl2);
//            File file3 = new File(backgroundUrl3);
            MockMultipartFile file1 = new MockMultipartFile("back1.png",new FileInputStream(new File(backgroundUrl1+"back1.png")));
            MockMultipartFile file2 = new MockMultipartFile("back2.png",new FileInputStream(new File(backgroundUrl2+"back2.png")));
            MockMultipartFile file3 = new MockMultipartFile("back3.png",new FileInputStream(new File(backgroundUrl3+"back3.png")));
            // 得到图片的缓冲区
            BufferedImage bufferedImage1 = ImageIO.read(file1.getInputStream());
            BufferedImage bufferedImage2 = ImageIO.read(file2.getInputStream());
            BufferedImage bufferedImage3 = ImageIO.read(file3.getInputStream());
            // 得到背景图的宽
            int with1 = bufferedImage1.getWidth();
            int with2 = bufferedImage2.getWidth();
            int with3 = bufferedImage3.getWidth();
            // 以本地图片为模板
            Graphics2D g1 = bufferedImage1.createGraphics();
            Graphics2D g2 = bufferedImage2.createGraphics();
            Graphics2D g3 = bufferedImage3.createGraphics();
            // 抗锯齿
            g1.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g3.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

            // 判断用户只填写了展位
            if (!StringUtils.isEmpty(poster2H5.getBooth()) && poster2H5.getForumState() == 0){
                // 单位名称
                if (!StringUtils.isEmpty(poster2H5.getCompanyName())){
                    g1.setColor(new Color(95,94,95));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,90);
                    g1.setFont(font);
                    FontMetrics fm = g1.getFontMetrics(font);
                    int companyNameWidth = fm.stringWidth(poster2H5.getCompanyName());
                    if (companyNameWidth <= 1160){
                        g1.drawString(poster2H5.getCompanyName(),(with1 - companyNameWidth) / 2,900);
                    }else {
                        drawStringAutoLineFeed(g1,poster2H5.getCompanyName(), 1160,(with1 - companyNameWidth) / 2, 900);
                        g1.drawString(name1,(with1 - fm.stringWidth(name1)) / 2, 900);
                        g1.drawString(name2,(with1 - fm.stringWidth(name2)) / 2, 1000);
                    }
                }
                //展位
                String booth = "";
                if(!StringUtils.isEmpty(poster2H5.getBooth())){
                    g1.setColor(new Color(18,45,136));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Bold.ttf",Font.BOLD,130);
                    g1.setFont(font);
                    FontMetrics fm = g1.getFontMetrics(font);
                    int boothWidth = fm.stringWidth(poster2H5.getBooth());
                    int boothX = (with1 - boothWidth) / 2;
                    g1.drawString(poster2H5.getBooth(),boothX + 130, 1290);
                }
                // 单位图片
                if (!StringUtils.isEmpty(poster2H5.getAttachmentPath())){
                    // 获取到单位图片
                    reSize(new File(poster2H5.getAttachmentPath()),new File(poster2H5.getAttachmentPath()),1000,600,true);
                    File logoFile = new File(poster2H5.getAttachmentPath());
                    BufferedImage getUrlImage = ImageIO.read(logoFile);
                    if (with1 > getUrlImage.getWidth()){
                        int getUrlImageX = (with1 - getUrlImage.getWidth()) / 2;
                        g1.drawImage(getUrlImage,getUrlImageX, 1550,null);
                    }else {
                        toJson.setFlag(1);
                        toJson.setMsg("您上传的图片宽度太大!");
                    }
                }
                // 获取文件名
                String fileName = file1.getName();
                String fileName1 = "";
                if ((fileName != null) && (fileName.length() > 0)) {
                    int dot = fileName.lastIndexOf('.');
                    if ((dot >-1) && (dot < (fileName.length() - 1))) {
                        fileName1 = fileName.substring(0,dot);
                    }
                }
                // 获取文件后缀
                String ext = "."+fileName.substring(fileName.lastIndexOf(".")+1);
                // 获取时间字符串
                String dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());
                String myPosterGenerateUrl = copyPath + fileName1 + dateTimeFormatter + ext;
                FileOutputStream posterPath = new FileOutputStream(myPosterGenerateUrl);
                poster2H5.setPosterUrl(myPosterGenerateUrl);
                // 生成之后并保存
                ImageIO.write(bufferedImage1, "PNG", posterPath);
                File newFile = new File(myPosterGenerateUrl);
                FileInputStream inputStream = new FileInputStream(newFile);
                MultipartFile multipartFile = new MockMultipartFile(file1.getName(), file1.getName(),
                        ContentType.APPLICATION_OCTET_STREAM.toString(), inputStream);
                Attachment attachment = enclosureService.upload1(multipartFile, company, module);

                toJson.setFlag(0);
                toJson.setMsg("ok");
                toJson.setObject(attachment);

            }
            // 判断用户填写了展位并且填写了论坛
            else if (!StringUtils.isEmpty(poster2H5.getBooth()) && poster2H5.getForumState() == 1){
                // 单位名称
                if (!StringUtils.isEmpty(poster2H5.getCompanyName())){
                    g3.setColor(new Color(95,94,95));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,90);
                    g3.setFont(font);
                    FontMetrics fm = g3.getFontMetrics(font);
                    int companyNameWidth = fm.stringWidth(poster2H5.getCompanyName());
                    if (companyNameWidth <= 1160){
                        g3.drawString(poster2H5.getCompanyName(),(with3 - companyNameWidth) / 2,900);
                    }else {
                        drawStringAutoLineFeed(g3,poster2H5.getCompanyName(), 1160,(with3 - companyNameWidth) / 2, 900);
                        g3.drawString(name1,(with3 - fm.stringWidth(name1)) / 2, 900);
                        g3.drawString(name2,(with3 - fm.stringWidth(name2)) / 2, 1000);
                    }
                }
                //展位
                if (!StringUtils.isEmpty(poster2H5.getBooth())){
                    g3.setColor(new Color(18,45,136));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Bold.ttf",Font.BOLD,100);
                    g3.setFont(font);
                    FontMetrics fm = g3.getFontMetrics(font);
                    int boothWidth = fm.stringWidth(poster2H5.getBooth());
                    g3.drawString(poster2H5.getBooth(),(with1 - boothWidth) / 2 + 130, 1214);
                }
                // 论坛时间和地点
                if (!StringUtils.isEmpty(poster2H5.getForumTime()) && !StringUtils.isEmpty(poster2H5.getForumTimeSlot()) && !StringUtils.isEmpty(poster2H5.getForumPlace())){
                    g3.setColor(new Color(95,94,95));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,70);
                    g3.setFont(font);
                    FontMetrics fm = g3.getFontMetrics(font);
                    int timeAndPlaceWidth = fm.stringWidth(poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace());
                    if (timeAndPlaceWidth <= 1000 ){
                        g3.drawString(poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace(),(with3 - timeAndPlaceWidth) / 2, 1310);
                    }else {
                        drawStringAutoLineFeed(g3,poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace(), 1000,(with3 - timeAndPlaceWidth) / 2, 1300);
                        g3.drawString(name1,(with3 - fm.stringWidth(name1)) / 2, 1320);
                        g3.drawString(name2,(with3 - fm.stringWidth(name2)) / 2, 1390);
                    }
                }
                // 论坛名称
                if (!StringUtils.isEmpty(poster2H5.getForumName())){
                    g3.setColor(new Color(18,45,136));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,70);
                    g3.setFont(font);
                    FontMetrics fm = g3.getFontMetrics(font);
                    int forumNameWidth = fm.stringWidth(poster2H5.getForumName());
                    if (forumNameWidth <= 1000){
                        g3.drawString(poster2H5.getForumName(),(with3 - forumNameWidth) / 2, 1600);
                    }else {
                        drawStringAutoLineFeed(g3,poster2H5.getForumName(), 1000,(with3 - forumNameWidth) / 2, 1600);
                        g3.drawString(name1,(with3 - fm.stringWidth(name1)) / 2, 1600);
                        g3.drawString(name2,(with3 - fm.stringWidth(name2)) / 2, 1700);
                    }
                }
                // 单位图片
                if (!StringUtils.isEmpty(poster2H5.getAttachmentPath())){
                    // 获取到单位图片
                    reSize(new File(poster2H5.getAttachmentPath()),new File(poster2H5.getAttachmentPath()),1000,430,true);
                    File logoFile = new File(poster2H5.getAttachmentPath());
                    BufferedImage getUrlImage = ImageIO.read(logoFile);
                    if (with3 > getUrlImage.getWidth()){
                        int getUrlImageX = (with3 - getUrlImage.getWidth()) / 2;
                        g3.drawImage(getUrlImage,getUrlImageX, 1800,null);
                    }else {
                        toJson.setFlag(1);
                        toJson.setMsg("您上传的图片宽度太大!");
                    }
                }
                // 获取文件名
                String fileName = file3.getName();
                String fileName1 = "";
                if ((fileName != null) && (fileName.length() > 0)) {
                    int dot = fileName.lastIndexOf('.');
                    if ((dot >-1) && (dot < (fileName.length() - 1))) {
                        fileName1 = fileName.substring(0,dot);
                    }
                }
                // 获取文件后缀
                String ext = "."+fileName.substring(fileName.lastIndexOf(".")+1);
                // 获取时间字符串
                String dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());
                String myPosterGenerateUrl = copyPath + fileName1 + dateTimeFormatter + ext;
                FileOutputStream posterPath = new FileOutputStream(myPosterGenerateUrl);
                poster2H5.setPosterUrl(myPosterGenerateUrl);
                // 生成之后并保存
                ImageIO.write(bufferedImage3, "PNG", posterPath);
                File newFile = new File(myPosterGenerateUrl);
                FileInputStream inputStream = new FileInputStream(newFile);
                MultipartFile multipartFile = new MockMultipartFile(file3.getName(), file3.getName(),
                        ContentType.APPLICATION_OCTET_STREAM.toString(), inputStream);
                Attachment attachment = enclosureService.upload1(multipartFile, company, module);

                toJson.setFlag(0);
                toJson.setMsg("ok");
                toJson.setObject(attachment);
            }
            // 判断用户只填写了论坛
            else if (StringUtils.isEmpty(poster2H5.getBooth()) && poster2H5.getForumState() == 1){
                // 单位名称
                if (!StringUtils.isEmpty(poster2H5.getCompanyName())){
                    g2.setColor(new Color(95,94,95));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,90);
                    g2.setFont(font);
                    FontMetrics fm = g2.getFontMetrics(font);
                    int companyNameWidth = fm.stringWidth(poster2H5.getCompanyName());
                    if (companyNameWidth <= 1160){
                        g2.drawString(poster2H5.getCompanyName(),(with2 - companyNameWidth) / 2,900);
                    }else {
                        drawStringAutoLineFeed(g2,poster2H5.getCompanyName(), 1160,(with2 - companyNameWidth) / 2, 900);
                        g2.drawString(name1,(with2 - fm.stringWidth(name1)) / 2, 900);
                        g2.drawString(name2,(with2 - fm.stringWidth(name2)) / 2, 1000);
                    }
                }
                // 论坛时间和地点
                if (!StringUtils.isEmpty(poster2H5.getForumTime()) && !StringUtils.isEmpty(poster2H5.getForumTimeSlot()) && !StringUtils.isEmpty(poster2H5.getForumPlace())){
                    g2.setColor(new Color(95,94,95));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,70);
                    g2.setFont(font);
                    FontMetrics fm = g2.getFontMetrics(font);
                    int timeAndPlaceWidth = fm.stringWidth(poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace());
                    if (timeAndPlaceWidth <= 900 ){
                        g2.drawString(poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace(),(with2 - timeAndPlaceWidth) / 2, 1300);
                    }else {
                        drawStringAutoLineFeed(g2,poster2H5.getForumTime() + "-" + poster2H5.getForumTimeSlot() + "-" + poster2H5.getForumPlace(), 900,(with2 - timeAndPlaceWidth) / 2, 1300);
                        g2.drawString(name1,(with2 - fm.stringWidth(name1)) / 2, 1300);
                        g2.drawString(name2,(with2 - fm.stringWidth(name2)) / 2, 1390);
                    }
                }
                // 论坛名称
                if (!StringUtils.isEmpty(poster2H5.getForumName())){
                    g2.setColor(new Color(18,45,136));
                    Font font = getSelfDefinedFont(filepath+"/HarmonyOS_Sans_SC_Regular.ttf",Font.PLAIN,70);
                    g2.setFont(font);
                    FontMetrics fm = g2.getFontMetrics(font);
                    int forumNameWidth = fm.stringWidth(poster2H5.getForumName());
                    if (forumNameWidth <= 1000){
                        g2.drawString(poster2H5.getForumName(),(with2 - forumNameWidth) / 2, 1600);
                    }else {
                        drawStringAutoLineFeed(g2,poster2H5.getForumName(), 1000,(with2 - forumNameWidth) / 2, 1600);
                        g2.drawString(name1,(with2 - fm.stringWidth(name1)) / 2, 1600);
                        g2.drawString(name2,(with2 - fm.stringWidth(name2)) / 2, 1700);
                    }
                }
                // 单位图片
                if (!StringUtils.isEmpty(poster2H5.getAttachmentPath())){
                    // 获取到单位图片
                    reSize(new File(poster2H5.getAttachmentPath()),new File(poster2H5.getAttachmentPath()),1000,430,true);
                    File logoFile = new File(poster2H5.getAttachmentPath());
                    BufferedImage getUrlImage = ImageIO.read(logoFile);
                    if (with2 > getUrlImage.getWidth()){
                        int getUrlImageX = (with2 - getUrlImage.getWidth()) / 2;
                        g2.drawImage(getUrlImage,getUrlImageX, 1800,null);
                    }else {
                        toJson.setFlag(1);
                        toJson.setMsg("您上传的图片宽度太大!");
                    }
                }
                // 获取文件名
                String fileName = file2.getName();
                String fileName1 = "";
                if ((fileName != null) && (fileName.length() > 0)) {
                    int dot = fileName.lastIndexOf('.');
                    if ((dot >-1) && (dot < (fileName.length() - 1))) {
                        fileName1 = fileName.substring(0,dot);
                    }
                }
                // 获取文件后缀
                String ext = "."+fileName.substring(fileName.lastIndexOf(".")+1);
                // 获取时间字符串
                String dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());
                String myPosterGenerateUrl = copyPath + fileName1 + dateTimeFormatter + ext;
                FileOutputStream posterPath = new FileOutputStream(myPosterGenerateUrl);
                poster2H5.setPosterUrl(myPosterGenerateUrl);
                // 生成之后并保存
                ImageIO.write(bufferedImage2, "PNG", posterPath);
                File newFile = new File(myPosterGenerateUrl);
                FileInputStream inputStream = new FileInputStream(newFile);
                MultipartFile multipartFile = new MockMultipartFile(file2.getName(), file2.getName(),
                        ContentType.APPLICATION_OCTET_STREAM.toString(), inputStream);
                Attachment attachment = enclosureService.upload1(multipartFile, company, module);

                toJson.setFlag(0);
                toJson.setMsg("ok");
                toJson.setObject(attachment);
            }
            else if (StringUtils.isEmpty(poster2H5.getBooth()) && poster2H5.getForumState() == 0 ){
                toJson.setFlag(1);
                toJson.setMsg("展位号和论坛内容同时为空时, 无法生成海报!");
            }
            else {
                toJson.setFlag(1);
                toJson.setMsg("生成图片失败!");
            }


        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 16:02
     * 方法介绍:   公司logo图片上传
     * 参数说明:   @param file:
     * 返回值说明: ToJson
     */
    public ToJson upload(MultipartFile file){
        ToJson toJson = new ToJson(1,"error");
        try {
            String company = "xoa1001";
            String module = "poster2";

            ResourceBundle rb = ResourceBundle.getBundle("upload");
            String os = System.getProperty("os.name");
            StringBuffer sb = new StringBuffer();
            StringBuffer buffer = new StringBuffer();

            if (os.toLowerCase().startsWith("win")) {
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

            //存储路径
            String copyPath = "";
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            if (com.xoa.util.common.StringUtils.checkNull(sb.toString())) {
                String a = request.getRealPath("");
                sb.append(a);
                buffer.append(a);
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator"));
                buffer.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator"));
                copyPath = buffer.toString();
            } else {
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator"));
                buffer.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator"));
                copyPath = buffer.toString();
            }
            Poster2H5 poster2 = new Poster2H5();
            // 文件夹
            File imgFolder = new File(copyPath);
            // 获取文件名字
            String fileName = file.getOriginalFilename();
            String fileName1 = "";
            if ((fileName != null) && (fileName.length() > 0)) {
                int dot = fileName.lastIndexOf('.');
                if ((dot >-1) && (dot < (fileName.length() - 1))) {
                    fileName1 = fileName.substring(0,dot);
                }
            }
            // 获取文件后缀
            String ext = "."+fileName.substring(fileName.lastIndexOf(".")+1);
            // 获取时间字符串
            String dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());
            // 生成新的文件名
            String newFileName = fileName1 + dateTimeFormatter + ext;
            // 创建文件
            File filePath = new File(imgFolder,newFileName);

            // 给对象赋值
            poster2.setAttachmentName(newFileName);
            poster2.setAttachmentSuffix(ext);
            poster2.setAttachmentPath(copyPath + "/" + newFileName);
            String size = file.getSize() + "";
            poster2.setAttachmentSize(Integer.valueOf(size));

            if (!filePath.getParentFile().exists()){
                filePath.getParentFile().mkdirs();
            }
            file.transferTo(filePath);
            toJson.setFlag(0);
            toJson.setMsg("上传成功");
            toJson.setData(poster2);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 11:13
     * 方法介绍:   等比例缩放图片
     * 参数说明:   @param srcImg: 原图片
     * @param destImg: 目标位置
     * @param width: 期望宽
     * @param height: 期望高
     * @param equalScale:  是否等比例缩放
     * 返回值说明: void
     */
    public static void reSize(File srcImg, File destImg, int width,
                              int height, boolean equalScale) {
        String type = getImageType(srcImg);
        if (type == null) {
            return;
        }
        if (width < 0 || height < 0) {
            return;
        }

        BufferedImage srcImage = null;
        try {
            srcImage = ImageIO.read(srcImg);
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }
        if (srcImage != null) {
            // targetW，targetH分别表示目标长和宽
            BufferedImage target = null;
            double sx = (double) width / srcImage.getWidth();
            double sy = (double) height / srcImage.getHeight();
            // 等比缩放
            if (equalScale) {
                if (sx > sy) {
                    sx = sy;
                    width = (int) (sx * srcImage.getWidth());
                } else {
                    sy = sx;
                    height = (int) (sy * srcImage.getHeight());
                }
            }
            ColorModel cm = srcImage.getColorModel();
            WritableRaster raster = cm.createCompatibleWritableRaster(width, height);
            boolean alphaPremultiplied = cm.isAlphaPremultiplied();

            target = new BufferedImage(cm, raster, alphaPremultiplied, null);
            Graphics2D g = target.createGraphics();
            // smoother than exlax:
            g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g.drawRenderedImage(srcImage, AffineTransform.getScaleInstance(sx, sy));
            g.dispose();
            // 将转换后的图片保存
            try {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(target, type, baos);
                FileOutputStream fos = new FileOutputStream(destImg);
                fos.write(baos.toByteArray());
                fos.flush();
                fos.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return;
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/10 14:34
     * 方法介绍:   引入外部字体文件路径
     * 参数说明:   @param filepath:  字体文件的路径
     *          @param style:  风格
     *          @param size:  大小
     * 返回值说明: Font
     */
    private static Font getSelfDefinedFont(String filepath ,int style,float size){
        Font font = null;
        File file = new File(filepath);
        try{
            font = Font.createFont(Font.TRUETYPE_FONT, file);
            font = font.deriveFont(style, size);
        }catch (FontFormatException e){
            return null;
        }catch (FileNotFoundException e){
            return null;
        }catch (IOException e){
            return null;
        }
        return font;
    }


    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 11:14
     * 方法介绍:   获取文件后缀不带.
     * 参数说明:   @param file:
     * 返回值说明: String
     */
    private static String getImageType(File file) {
        if (file != null && file.exists() && file.isFile()) {
            String fileName = file.getName();
            int index = fileName.lastIndexOf(".");
            if (index != -1 && index < fileName.length() - 1) {
                return fileName.substring(index + 1);
            }
        }
        return null;
    }

    private static int drawStringAutoLineFeed(Graphics g, String strContent, int rowWidth, int x, int y) {
        String[] split = strContent.split("\n");
        int total = 0;
        for (String str : split) {
            int height = drawStringAutoLine(g, str, rowWidth, x, y);
            total += height;
            y += height;
        }
        return total;
    }


    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/7 11:14
     * 方法介绍:   根据指定宽度自动换行
     * 参数说明:
     * 返回值说明: int
     */
    private static int drawStringAutoLine(Graphics g, String strContent, int rowWidth, int x, int y) {
        // 获取字符串 字符的总宽度
        int strWidth = getStringLength(g, strContent);
        // 获取字符高度
        int strHeight = getStringHeight(g);
        // 字符串总个数
        int rows = 0;
        if (strWidth > rowWidth) {
            int rowStrNum = getRowStrNum(strContent.length(), rowWidth, strWidth);
            rows = getRows(strWidth, rowWidth);
            String temp = "";
            for (int i = 0; i < rows; i++) {
                // 获取各行的String
                if (i == rows - 1) {
                    // 最后一行
                    name2 = strContent.substring(i * rowStrNum, strContent.length());
                } else {
                    name1 = strContent.substring(i * rowStrNum, i * rowStrNum + rowStrNum);
                }
                if (i > 0) {
                    // 第一行不需要增加字符高度，以后的每一行在换行的时候都需要增加字符高度
                    y = y + strHeight;
                }
//                g.drawString(temp, x, y);
            }
        } /*else {
            // 直接绘制
            g.drawString(strContent, x, y);
        }*/
        return strHeight * rows;
    }

    private static int getStringLength(Graphics g, String str) {
        char[] strChar = str.toCharArray();
        return g.getFontMetrics().charsWidth(strChar, 0, str.length());
    }

    // 字符高度
    private static int getStringHeight(Graphics g) {
        return g.getFontMetrics().getHeight();
    }

    // 每一行字符的个数
    private static int getRowStrNum(int strNum, int rowWidth, int strWidth) {
        int rowsNum = 0;
        rowsNum = (rowWidth * strNum) / strWidth;
        return rowsNum;
    }

    // 字符行数
    private static int getRows(int strWidth, int rowWidth) {
        int rows = 0;
        if (strWidth % rowWidth > 0) {
            rows = strWidth / rowWidth + 1;
        } else {
            rows = strWidth / rowWidth;
        }
        return rows;
    }

}
