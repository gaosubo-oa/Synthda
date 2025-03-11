package com.xoa.dev.posterH5.service;

import com.xoa.dev.posterH5.model.PosterH5;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.util.Constant;
import com.xoa.util.FileUploadUtil;
import com.xoa.util.ToJson;
import com.xoa.util.aes.AESUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.entity.ContentType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
 * 创建日期: 2022/3/2 10:48
 * 类介绍:
 **/
@Service
public class PosterH5Service {


    @Resource
    private EnclosureService enclosureService;

    public static String name1; // 第一行文本
    public static String name2; // 第二行文本

    // 数字医学海报生成
    public ToJson posterGenerate(HttpServletRequest request, PosterH5 posterH5){
        ToJson toJson = new ToJson(1,"error");

        String company = "xoa1001";
        String module = "poster";

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

        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
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
                    append(module).append(System.getProperty("file.separator")).append(ym);
            buffer.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            copyPath = buffer.toString();
        } else {
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            buffer.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            copyPath = buffer.toString();
        }

        // 原背景图路径
        String backgroundUrl = sb +"/poster.png";
        try {
            File file = new File(backgroundUrl);
            // 得到图片的缓冲区
            BufferedImage bufferedImage = ImageIO.read(file);
            int with = bufferedImage.getWidth();
            int height = bufferedImage.getHeight();
            // 以本地图片为模板
            Graphics2D graphics2D = bufferedImage.createGraphics();
            // 抗锯齿
            graphics2D.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            // 单位名称
            if (!StringUtils.isEmpty(posterH5.getCompanyName())){
                graphics2D.setColor(new Color(0,0,0));
                Font font = new Font("黑体",Font.BOLD,34);
                graphics2D.setFont(font);
                FontMetrics fm = graphics2D.getFontMetrics(font);
                int companyNameWidth = fm.stringWidth(posterH5.getCompanyName());
                if (companyNameWidth <= 532){
                    graphics2D.drawString(posterH5.getCompanyName(),(with - companyNameWidth) / 2,310);
                }else {
                    drawStringAutoLineFeed(graphics2D,posterH5.getCompanyName(), 570,(with - companyNameWidth) / 2, 280);
                    graphics2D.drawString(name1,(with - fm.stringWidth(name1)) / 2, 285);
                    graphics2D.drawString(name2,(with - fm.stringWidth(name2)) / 2, 335);
                }
            }
            //展位
            if(!StringUtils.isEmpty(posterH5.getBooth())){
                graphics2D.setColor(new Color(209,65,7));
                Font font = new Font("黑体",Font.BOLD,46);
                graphics2D.setFont(font);
                FontMetrics fm = graphics2D.getFontMetrics(font);
                int boothWidth = fm.stringWidth("诚邀您莅临" + posterH5.getBooth() + "展位");
                int boothX = (with - boothWidth) / 2;
                graphics2D.drawString("诚邀您莅临"+posterH5.getBooth()+"展位",boothX, 420);
            }
            // 单位图片
            if (!StringUtils.isEmpty(posterH5.getAttachmentPath())){
                // 获取到单位图片
                reSize(new File(posterH5.getAttachmentPath()),new File(posterH5.getAttachmentPath()),300,200,true);
                File logoFile = new File(posterH5.getAttachmentPath());
                BufferedImage getUrlImage = ImageIO.read(logoFile);
                if (with > getUrlImage.getWidth()){
                    int getUrlImageX = (with - getUrlImage.getWidth()) / 2;
                    graphics2D.drawImage(getUrlImage,getUrlImageX, 480,null);
                }else {
                    toJson.setFlag(1);
                    toJson.setMsg("您上传的图片宽度太大!");
                }
            }

            // 业务介绍
            if(!StringUtils.isEmpty(posterH5.getIntroduce())){
                graphics2D.setColor(new Color(0,0,0));
                Font font = new Font("黑体",Font.BOLD,28);
                graphics2D.setFont(font);
                FontMetrics fm = graphics2D.getFontMetrics(font);
                int introduceWidth = fm.stringWidth(posterH5.getIntroduce());
                if (introduceWidth <= 532){
                    graphics2D.drawString(posterH5.getIntroduce(),(with - introduceWidth) / 2,680);
                }else {
                    drawStringAutoLineFeed(graphics2D,posterH5.getIntroduce(), 570,(with - introduceWidth) / 2, 660);
                    graphics2D.drawString(name1,(with - fm.stringWidth(name1)) / 2, 635);
                    graphics2D.drawString(name2,(with - fm.stringWidth(name2)) / 2, 685);
                }
            }
            // 获取文件名
            String fileName = file.getName();
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
            FileOutputStream posterPath = new FileOutputStream(copyPath + fileName1 + dateTimeFormatter + ext);
            String myPosterGenerateUrl = copyPath + fileName1 + dateTimeFormatter + ext;
            posterH5.setPosterUrl(myPosterGenerateUrl);
            // 生成之后并保存
            ImageIO.write(bufferedImage, "PNG", posterPath);

            File newFile = new File(myPosterGenerateUrl);
            FileInputStream inputStream = new FileInputStream(newFile);
            MultipartFile multipartFile = new MockMultipartFile(file.getName(), file.getName(),
                    ContentType.APPLICATION_OCTET_STREAM.toString(), inputStream);
            Attachment attachment = enclosureService.upload1(multipartFile, company, module);

            toJson.setFlag(0);
            toJson.setMsg("ok");
            toJson.setObject(attachment);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/3 11:32
     * 方法介绍:   公司logo图片上传
     * 参数说明:   @param file:
     * 返回值说明: ToJson
     */
    public ToJson upload(MultipartFile file){
        ToJson toJson = new ToJson(1,"error");
        try {
            String company = "xoa1001";
            String module = "poster";

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

            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
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
                        append(module).append(System.getProperty("file.separator")).append(ym);
                buffer.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator")).append(ym);
                copyPath = buffer.toString();
            } else {
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator")).append(ym);
                buffer.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator")).append(ym);
                copyPath = buffer.toString();
            }
            PosterH5 posterH5 = new PosterH5();
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
            posterH5.setAttachmentName(newFileName);
            posterH5.setAttachmentSuffix(ext);
            posterH5.setAttachmentPath(copyPath + "/" + newFileName);
            String size = file.getSize() + "";
            posterH5.setAttachmentSize(Integer.valueOf(size));

            if (!filePath.getParentFile().exists()){
                filePath.getParentFile().mkdirs();
            }
            file.transferTo(filePath);
            toJson.setFlag(0);
            toJson.setMsg("上传成功");
            toJson.setData(posterH5);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/4 15:08
     * 方法介绍:    IO流读取图片
     * 参数说明:   @param imgUrl:
     * @param response:
     * 返回值说明: void
     */
    public ToJson IoReadImage(String imgUrl, HttpServletResponse response) throws IOException {
        ToJson toJson = new ToJson(1,"error");
        ServletOutputStream out = null;
        FileInputStream ips = null;
        try {
            //获取图片存放路径
            String imgPath = imgUrl;
            ips = new FileInputStream(new File(imgPath));
            String type = imgUrl.substring(imgUrl.indexOf(".")+1);
            if(!FileUploadUtil.checkFilePicture(type)){
                return null;
            }
            if (type.equals("png")){
                response.setContentType("image/png");
            }
            if (type.equals("jpeg")){
                response.setContentType("image/jpeg");
            }
            out = response.getOutputStream();
            //读取文件流
            int len = 0;
            byte[] buffer = new byte[1024 * 10];
            while ((len = ips.read(buffer)) != -1){
                out.write(buffer,0,len);
            }
            out.flush();
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }finally {
            out.close();
            ips.close();
        }
        return toJson;
    }

    /**
     * 创建作者:   李彦洁
     * 创建日期:   2022/3/3 16:58
     * 方法介绍:   等比例缩放图片
     * 参数说明:   @param srcImg     原图片
     * @param destImg    目标位置
     *           @param width      期望宽
     * @param height     期望高
     * @param equalScale 是否等比例缩放
     * @return
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
     * 创建日期:   2022/3/3 16:59
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
     * 创建日期:   2022/3/2 17:49
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
