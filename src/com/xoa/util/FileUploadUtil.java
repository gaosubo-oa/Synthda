package com.xoa.util;

import com.ibatis.common.resources.Resources;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.common.StringUtils;
import com.xoa.util.dataSource.DataSourceInit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.channels.FileChannel;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.*;
import java.util.regex.Pattern;

/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年5月22日 上午11:08:15
 * 类介绍  :   	 文件上传工具类
 * 构造参数:
 */
public class FileUploadUtil {
    public static final List<String> ALLOW_TYPES = Arrays.asList(
            "image/jpg", "image/jpeg", "image/png", "image/gif","image/x-icon"
    );

    public static final List<String> PICTURE_TYPES = Arrays.asList(
            "jpg","jpeg","png","gif","x-icon"
    );

    @Autowired
    private SysTasksService sysTasksService;

    //文件重命名
    public static String rename(String fileName) {
        int i = fileName.lastIndexOf(".");
        String str = fileName.substring(i);
        //return new DateTest().getTime()+""+ new Random().nextInt(99999999) +str;
        return Math.abs((int) System.currentTimeMillis()) + str;
    }

    //自定义重命名
    public static String rename(String fileName, String freeName) {
        int i = fileName.lastIndexOf(".");
        String str = fileName.substring(0, i);
        String str1 = fileName.substring(i);
        //return new DateTest().getTime()+""+ new Random().nextInt(99999999) +str;
        return str + freeName + str1;
    }


    //校验文件类型是否是被允许的
    public static boolean allowUpload(String postfix) {
        return ALLOW_TYPES.contains(postfix);
    }

    /**
     * 验证文件是否是图片类型
     * @param fileName
     * @return
     */
    public static boolean checkFilePicture(String fileName) {
        if (!StringUtils.checkNull(fileName.trim())) {
            // 获取文件后缀
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
            //判断是否以这种后缀开头的文件
            if (PICTURE_TYPES.stream().anyMatch(s -> suffix.trim().toLowerCase().equals(s))) {
                return true;
            }
        }
        return false;
    }

    //返回附件信息
    public static Object[] reAttachment(List<Attachment> list) {
        StringBuffer id = new StringBuffer();
        StringBuffer name = new StringBuffer();
        for (Attachment attachment : list) {
            int aid = attachment.getAid();
            String attachId = attachment.getAttachId();
            String ym = attachment.getYm();
            String attachName = attachment.getAttachName();
            String all = aid + "@" + ym + "_" + attachId;
            id.append(all).append(",");
            name.append(attachName).append("*");
        }
        Object[] o = new Object[2];
        o[0] = id.toString();
        o[1] = name.toString();
        return o;
    }


    //返回附件信息
    public static Object[] reAttachmentAll(List<Attachment> list) {
        StringBuffer id = new StringBuffer();
        StringBuffer name = new StringBuffer();
        for (Attachment attachment : list) {
            int aid = attachment.getAid();
            String attachId = attachment.getAttachId();
            String ym = attachment.getYm();
            String attachName = attachment.getAttachName();
            String fileSize = attachment.getFileSize();
            String time = attachment.getTime();
            String all = aid + "@" + ym + "_" + attachId + "*" + fileSize + "|" + time;
            id.append(all).append(",");
            name.append(attachName).append("*");
        }
        Object[] o = new Object[2];
        o[0] = id.toString();
        o[1] = name.toString();
        return o;
    }


    public static String zipImageFile(String oldFile, int width, int height,
                                      float quality, String smallIcon, String dirurl) {
        if (oldFile == null) {
            return null;
        }
        String newImage = null;
        try {
            /**对服务器上的临时文件进行处理 */
            Image srcFile = ImageIO.read(new File(oldFile));
            /** 宽,高设定 */
            BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(srcFile, 0, 0, width, height, null);
            /** 压缩后的文件名 */
            newImage = dirurl + System.getProperty("file.separator") + smallIcon;
//             File newImageFile =new File(dirurl,smallIcon);
            File file = new File(newImage);
            if (file.exists()) {
                return "";
            }
            /** 压缩之后临时存放位置 */
            FileOutputStream out = new FileOutputStream(newImage);
//             JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
//             JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);
//             /** 压缩质量 */
//             jep.setQuality(quality, true);
//             encoder.encode(tag, jep);
            ImageIO.write(tag, "jpeg", out);
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return newImage;

    }

    public static String writeFile(String fileName, InputStream is) {
        if (fileName == null || fileName.trim().length() == 0) {
            return null;
        }
        try {
            /** 首先保存到临时文件 */
            FileOutputStream fos = new FileOutputStream(fileName);
            byte[] readBytes = new byte[512];// 缓冲大小
            int readed = 0;
            while ((readed = is.read(readBytes)) > 0) {
                fos.write(readBytes, 0, readed);

            }

            fos.close();

            is.close();

        } catch (FileNotFoundException e) {

            e.printStackTrace();
        } catch (IOException e) {

            e.printStackTrace();
        }

        return fileName;

    }

    public static void saveMinPhoto(String srcURL, String deskURL, double comBase,

                                    double scale) throws Exception {
        File srcFile = new java.io.File(srcURL);
        Image src = ImageIO.read(srcFile);
        int srcHeight = src.getHeight(null);
        int srcWidth = src.getWidth(null);
        int deskHeight = 0;// 缩略图高
        int deskWidth = 0;// 缩略图宽
        double srcScale = (double) srcHeight / srcWidth;
        /**缩略图宽高算法*/
        if ((double) srcHeight > comBase || (double) srcWidth > comBase) {
            if (srcScale >= scale || 1 / srcScale > scale) {
                if (srcScale >= scale) {
                    deskHeight = (int) comBase;
                    deskWidth = srcWidth * deskHeight / srcHeight;
                } else {
                    deskWidth = (int) comBase;
                    deskHeight = srcHeight * deskWidth / srcWidth;
                }
            } else {
                if ((double) srcHeight > comBase) {
                    deskHeight = (int) comBase;
                    deskWidth = srcWidth * deskHeight / srcHeight;
                } else {
                    deskWidth = (int) comBase;
                    deskHeight = srcHeight * deskWidth / srcWidth;
                }
            }
        } else {
            deskHeight = srcHeight;
            deskWidth = srcWidth;
        }
        BufferedImage tag = new BufferedImage(deskWidth, deskHeight, BufferedImage.TYPE_3BYTE_BGR);
        tag.getGraphics().drawImage(src, 0, 0, deskWidth, deskHeight, null); //绘制缩小后的图
        File file = new File(deskURL);
        if (!file.exists()) {
            file.createNewFile();
        }

        FileOutputStream deskImage = new FileOutputStream(deskURL); //输出到文件流
        ImageIO.write(tag, "jpeg", deskImage);
        deskImage.close();
    }

    public static String getRootPath() {
        String classPath = FileUploadUtil.class.getClassLoader().getResource("/").getPath();
        String rootPath = "";
        //windows下
        if ("\\".equals(File.separator)) {
            rootPath = classPath.substring(1, classPath.indexOf("/WEB-INF/classes"));
            rootPath = rootPath.replace("/", "\\");
        }
        //linux下
        if ("/".equals(File.separator)) {
            rootPath = classPath.substring(0, classPath.indexOf("/WEB-INF/classes"));
            rootPath = rootPath.replace("\\", "/");
        }
        return rootPath;
    }


    public static List<Attachment> findAtachment(String attachmId, String attachmName, String company) {
        List<Attachment> json = new ArrayList<Attachment>();
        //定义用于存储附件信息的集合
        List<Attachment> attachmentList = new ArrayList<Attachment>();
        if (!StringUtils.checkNull(attachmId) || !StringUtils.checkNull(attachmName)) {
          /*  String attachmentId[] = attachmId.split(",");
            String attachmenName[] = attachmName.split("\\*");*/
            String[] attachmentId = attachmId.split(",");
            String[] attachmenName = attachmName.split("\\*");

            for (int i = 0; i < attachmentId.length; i++) {
                String aid = attachmentId[i].substring(0, attachmentId[i].indexOf('@'));
                String ym = attachmentId[i].substring(attachmentId[i].indexOf('@') + 1, attachmentId[i].indexOf('_'));
                String attachId;
                String fileSize = "";
                String time = "";
                if (attachmentId[i].contains("*")) {
                    attachId = attachmentId[i].substring(attachmentId[i].indexOf('_') + 1, attachmentId[i].indexOf('*'));
                    fileSize = attachmentId[i].substring(attachmentId[i].indexOf('*') + 1, attachmentId[i].indexOf('|'));
                    time = attachmentId[i].substring(attachmentId[i].indexOf('|') + 1, attachmentId[i].length());
                } else {
                    attachId = attachmentId[i].substring(attachmentId[i].indexOf('_') + 1, attachmentId[i].length());
                }
                  /*  String attachId = attachmentId[i].substring(attachmentId[i].indexOf('_') + 1, attachmentId[i].indexOf('*'));
                    String fileSize = attachmentId[i].substring(attachmentId[i].indexOf('*') + 1, attachmentId[i].indexOf('|'));
                    String time = attachmentId[i].substring(attachmentId[i].indexOf('|') + 1, attachmentId[i].length());*/
                  if(i<=attachmenName.length-1){
                      String attachName = attachmenName[i];
                      Attachment attachment = new Attachment();
                      String attUrl = "AID=" + aid + "&" + "MODULE=" + ModuleEnum.WORKFLOW.getName() + "&" + "COMPANY=" + company + "&" +
                              "YM=" + ym + "&" + "ATTACHMENT_ID=" + attachId + "&" + "ATTACHMENT_NAME=" + attachName;
                      attachment.setAid(Integer.parseInt(aid));
                      attachment.setYm(ym);
                      attachment.setAttachId(attachId);
                      attachment.setAttachName(attachName);
                      attachment.setAttUrl(attUrl);
                      attachment.setFileSize(fileSize);
                      attachment.setTime(time);
                      attachmentList.add(attachment);
                  }
            }
        }
        return attachmentList;
    }


    public  String getPath(Attachment attachment, String company, String module) {
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

//                append("attach").
//                append(System.getProperty("file.separator")).


        //---------------------------------判断是否为Linux开始-------------------------------------



        String attachmentName = attachment.getAttachName();
        try {
            // 查询是否加密
            boolean encryption = sysTasksService.isEncryption();

            int codeLength = attachmentName.getBytes("UTF-8").length;
            String type = attachmentName.substring(attachmentName.lastIndexOf("."));
            if((codeLength>230&&osName.toLowerCase().startsWith("linu"))||encryption){//判断
                String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0,attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                String regEx=("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                if(trim.length()>100){
                    attachmentName=(trim).substring(0,100)+type;
                } else {
                    attachmentName = trim+type;
                }
            }
        }catch (Exception e){

        }


        //---------------------------------判断是否为Linux结束 -------------------------------------


        sb.append(System.getProperty("file.separator")).append(company).append(System.getProperty("file.separator")).
                append(module).append(System.getProperty("file.separator")).append(attachment.getYm()).
                append(System.getProperty("file.separator")).append(attachment.getAttachId()).append(".").append(attachmentName);
        return sb.toString();

    }
    /**
     * <p>Title: copyFileUsingFileChannels</p>
     * <p>Description: 文件拷贝</p>
     *
     * @param source
     * @param dest
     * @throws IOException
     */
    public synchronized static void copyFileUsingFileChannels(File source, File dest) throws IOException {
        String destUrl = dest.getParent();
        File file = new File(destUrl);
        if (!file.exists()) {
            file.mkdirs();
        }
        try(FileChannel inputChannel = new FileInputStream(source).getChannel();
            FileChannel outputChannel = new FileOutputStream(dest).getChannel()) {
            outputChannel.transferFrom(inputChannel, 0, inputChannel.size());
        }
    }


    public  List<Attachment> cppyFile(List<Attachment> copyList, String company, String module)  {
        List<Attachment> destList = new ArrayList<Attachment>();
        Attachment destAttch = null;
        for (int i = 0, size = copyList.size(); i < size; i++) {
            String path = getPath(copyList.get(i), company, module);
            File source = new File(path);
            destAttch = new Attachment();
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
            String sourceFileName = copyList.get(i).getAttachName();
            //String destFileName = Integer.toString(attachID) + "." + sourceFileName;
            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            destAttch.setAttachId(attachID);
            destAttch.setYm(ym);
            destAttch.setAttachName(copyList.get(i).getAttachName());

            //获得模块名
            int moduleID = 0;
            for (ModuleEnum em : ModuleEnum.values()) {
                if (em.getName().equals(GetAttachmentListUtil.MODULE_EMAIL)) {
                    moduleID = em.getIndex();
                }
            }

            destAttch.setAttachId(attachID);
            destAttch.setModule(moduleID);
            destAttch.setAttachFile(sourceFileName);
            destAttch.setAttachName(sourceFileName);
            destAttch.setYm(ym);
            destAttch.setAttachSign(new Long(0));
            destAttch.setDelFlag(0);
            destAttch.setPosition(2);
            //destAttch.setIsImage(3);
            destAttch.setSize(copyList.get(i).getSize());
            destAttch.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            String destPath = getPath(destAttch, company, module);
            File dest = new File(destPath);
            try{
                FileUploadUtil.copyFileUsingFileChannels(source, dest);
            }catch (IOException e){

            }
            destList.add(destAttch);
        }
        return destList;

    }
    //复制公文到工作流
    public  List<Attachment> cppyFiles(List<Attachment> copyList, String company, String module)  {
        List<Attachment> destList = new ArrayList<Attachment>();
        Attachment destAttch = null;
        for (int i = 0, size = copyList.size(); i < size; i++) {
            String path = getPath(copyList.get(i), company, module);
            File source = new File(path);
            destAttch = new Attachment();
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
            String sourceFileName = copyList.get(i).getAttachName();
            //String destFileName = Integer.toString(attachID) + "." + sourceFileName;
            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            destAttch.setAttachId(attachID);
            destAttch.setYm(ym);
            destAttch.setAttachName(copyList.get(i).getAttachName());

            //获得模块名
            int moduleID = 2;
            for (ModuleEnum em : ModuleEnum.values()) {
                if (em.getName().equals(GetAttachmentListUtil.MODULE_WORKFLOW)) {
                    moduleID = em.getIndex();
                }
            }

            destAttch.setAttachId(attachID);
            destAttch.setModule(moduleID);
            destAttch.setAttachFile(sourceFileName);
            destAttch.setAttachName(sourceFileName);
            destAttch.setYm(ym);
            destAttch.setAttachSign(new Long(0));
            destAttch.setDelFlag(0);
            destAttch.setPosition(2);
            //destAttch.setIsImage(3);
            destAttch.setSize(copyList.get(i).getSize());
            destAttch.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            String modules = "workflow";
            String destPath = getPath(destAttch, company, modules);
            File dest = new File(destPath);
            try{
                FileUploadUtil.copyFileUsingFileChannels(source, dest);
            }catch (IOException e){

            }
            destList.add(destAttch);
        }
        return destList;

    }

    public  List<Attachment> copyFile(List<Attachment> copyList, String company, String module)  {
        List<Attachment> destList = new ArrayList<Attachment>();
        Attachment destAttch = null;
        for (int i = 0, size = copyList.size(); i < size; i++) {
            String path = getPath(copyList.get(i), company, module);
            File source = new File(path);
            destAttch = new Attachment();
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
            String sourceFileName = copyList.get(i).getAttachName();
            //String destFileName = Integer.toString(attachID) + "." + sourceFileName;
            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            destAttch.setAttachId(attachID);
            destAttch.setYm(ym);
            destAttch.setAttachName(copyList.get(i).getAttachName());

            //获得模块名
            int moduleID = 17;
            for (ModuleEnum em : ModuleEnum.values()) {
                if (em.getName().equals(GetAttachmentListUtil.MODULE_ROLL_MANAGE)) {
                    moduleID = em.getIndex();
                }
            }

            destAttch.setAttachId(attachID);
            destAttch.setModule(moduleID);
            destAttch.setAttachFile(sourceFileName);
            destAttch.setAttachName(sourceFileName);
            destAttch.setYm(ym);
            destAttch.setAttachSign(new Long(0));
            destAttch.setDelFlag(0);
            destAttch.setPosition(2);
            //destAttch.setIsImage(3);
            destAttch.setSize(copyList.get(i).getSize());
            destAttch.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            String modules = "roll_manage";
            String destPath = getPath(destAttch, company, modules);
            File dest = new File(destPath);
            try{
                FileUploadUtil.copyFileUsingFileChannels(source, dest);
            }catch (IOException e){

            }
            destList.add(destAttch);
        }
        return destList;

    }
    // 从model 复制文件到 model 以后公用
    public  List<Attachment> copyFiles(List<Attachment> copyList, String company, String module,String ToModule)  {
        List<Attachment> destList = new ArrayList<Attachment>();
        Attachment destAttch = null;
        for (int i = 0, size = copyList.size(); i < size; i++) {
            String path = getPath(copyList.get(i), company, module);
            File source = new File(path);
            destAttch = new Attachment();
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
            String sourceFileName = copyList.get(i).getAttachName();
            //String destFileName = Integer.toString(attachID) + "." + sourceFileName;
            //当前年月
            String ym = new SimpleDateFormat("yyMM").format(new Date());
            destAttch.setAttachId(attachID);
            destAttch.setYm(ym);
            destAttch.setAttachName(copyList.get(i).getAttachName());

            //获得模块名
            int moduleID = 17;
            for (ModuleEnum em : ModuleEnum.values()) {
                if (em.getName().equals(GetAttachmentListUtil.MODULE_ROLL_MANAGE)) {
                    moduleID = em.getIndex();
                }
            }

            destAttch.setAttachId(attachID);
            destAttch.setModule(moduleID);
            destAttch.setAttachFile(sourceFileName);
            destAttch.setAttachName(sourceFileName);
            destAttch.setYm(ym);
            destAttch.setAttachSign(new Long(0));
            destAttch.setDelFlag(0);
            destAttch.setPosition(2);
            //destAttch.setIsImage(3);
            destAttch.setSize(copyList.get(i).getSize());
            destAttch.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            String modules = ToModule;
            String destPath = getPath(destAttch, company, modules);
            File dest = new File(destPath);
            try{
                FileUploadUtil.copyFileUsingFileChannels(source, dest);
            }catch (IOException e){

            }
            destList.add(destAttch);
        }
        return destList;

    }

    // 获取上传路径头部信息 /xoa/attach
    public static StringBuilder getUploadHead(){
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuilder uploadHead = new StringBuilder();

        if (os.toLowerCase().startsWith("win")) {
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if (uploadPath.indexOf(":") == -1) {
                //获取运行时的路径
                String basePath = FileUploadUtil.class.getClassLoader().getResource(".").getPath() + File.pathSeparator;
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
                uploadHead = uploadHead.append(str2 + "/xoa");
            }
            uploadHead.append(uploadPath);
            // 针对windows 在最前面添加盘符
            if(uploadHead.indexOf(":")==-1){
                String diskSymbol = new File("").getAbsolutePath().substring(0, 2);
                uploadHead.insert(0,diskSymbol);
            }
        } else {
            uploadHead = uploadHead.append(rb.getString("upload.linux"));
        }

        return uploadHead;
    }

    // 获取上传全路径
    public static StringBuilder getFullUploadPath(String company,String module,String ym){
        // 文件存储头
        StringBuilder uploadHead = getUploadHead();

        if(!StringUtils.checkNull(company)&&company.contains("..")){
            return null;
        }

        //查询是否kingbase环境
        String driver = FileUploadUtil.getDriver();
        if("kingbase8".equals(driver) && !company.contains("KB")){
            company = company.replace("xoa","xoaKB");
        }

        if(!StringUtils.checkNull(module)&&module.contains("..")){
            return null;
        }

        // 当前年月
        if(StringUtils.checkNull(ym)){
            ym = new SimpleDateFormat("yyMM").format(new Date());
        }

        // 文件存储路径
        StringBuilder filePath = uploadHead.append(System.getProperty("file.separator")).
                append(company).append(System.getProperty("file.separator")).
                append(module).append(System.getProperty("file.separator")).
                append(ym).append(System.getProperty("file.separator"));

        return filePath;
    }

    public static String replacePath(String path){
        return path.replace("../","").replace("..\\","");
    }

    public static boolean checkFile(String fileName) {
        if (!"".equals(fileName.trim())) {
            //设置不允许上传文件类型
            String suffixList = "jsp,jspx,js,css,java,class,php,go,py,html,htm,exe";
            // 获取文件后缀
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
            if(StringUtils.checkNull(suffix)){
                return false;
            }
            //判断是否以这种后缀开头的文件
            if (Arrays.asList(suffixList.split(",")).stream().anyMatch(s -> suffix.trim().toLowerCase().startsWith(s))) {
                return false;
            }
        }
        return true;
    }

    /**
     * MultipartFile 转 File
     *
     * @param multipartFile
     * @throws Exception
     */
    public static File MultipartFileToFile(MultipartFile multipartFile) {

        File file = null;
        //判断是否为null
        if (multipartFile==null || multipartFile.getSize() <= 0) {
            return file;
        }
        //MultipartFile转换为File
        InputStream ins = null;
        OutputStream os = null;
        try {
            ins = multipartFile.getInputStream();
            file = new File(multipartFile.getOriginalFilename());
            os = new FileOutputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = ins.read(buffer, 0, 8192)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if(os != null){
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(ins != null){
                try {
                    ins.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return file;
    }

    public static String getEncryptionName(String attachmentId,String attachmentName,String company,String module,String ym,Boolean encryption) {

        try {
            //查询是否kingbase环境
            String driver = FileUploadUtil.getDriver();
            if("kingbase8".equals(driver) && !company.contains("KB")){
                company = company.replace("xoa","xoaKB");
            }

            String osName = System.getProperty("osName");
            int codeLength = attachmentName.getBytes("UTF-8").length;
            String type = attachmentName.substring(attachmentName.lastIndexOf("."));
            if ((codeLength > 230 && osName.toLowerCase().startsWith("linu") )|| encryption) {//判断
                String realAttachmentName = attachmentName;
                String s = (new BASE64Encoder()).encodeBuffer((attachmentName.substring(0, attachmentName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                String regEx = ("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                if(trim.length()>100){
                    attachmentName=(trim).substring(0,100)+type;
                } else {
                    attachmentName = trim+type;
                }

                // 判断是否存在加密附件 如果不存在的话 有可能是开启加密之前生成的附件

                StringBuilder fullUploadPath = getFullUploadPath(company, module, ym);

                String filePath = fullUploadPath.toString() + attachmentId + "." + attachmentName;

                File file = new File(filePath + ".xoafile");

                if(!file.exists()){
                    attachmentName = realAttachmentName;
                }else {
                    attachmentName = attachmentName + ".xoafile";
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return attachmentName;
    }

    public static String getDriver(){
        try {
            Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");

            String driver = props.getProperty("driverClassName");

            if("com.kingbase8.Driver".equals(driver)){
                // 切掉1001或者10xx 之前的字符串 拼接到 xoaKB上
                return "kingbase8";
            } else if ("dm.jdbc.driver.DmDriver".equals(driver)){
                // 切掉1001或者10xx 之前的字符串 拼接到 XOA上
                return "dm";
            }

        }catch (Exception e){
            e.printStackTrace();
            return "mysql";
        }
        return "mysql";
    }



}