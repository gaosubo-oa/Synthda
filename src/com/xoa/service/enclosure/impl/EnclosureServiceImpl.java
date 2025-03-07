package com.xoa.service.enclosure.impl;

import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import com.xoa.service.enclosure.EnclosureService;
import com.xoa.service.sys.SysTasksService;
import com.xoa.util.*;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

/**
 * @author gsb
 */
@Service
public class EnclosureServiceImpl implements EnclosureService {
    @Resource
    AttachmentMapper attachmentMapper;

    @Autowired
    EmailBodyMapper emailBodyMapper;
    @Autowired
    SysTasksService sysTasksService;
    @Override
    public void saveAttachment(Attachment attachment) {
        attachmentMapper.insertSelective(attachment);

    }


    @Override
    public Attachment findByAttachId(Integer aid) {
        Attachment a = attachmentMapper.findByAttachId(aid);
        return a;
    }

    @Override
    public Attachment findByAttachId1(Integer attachId) {
        Attachment a = attachmentMapper.findByAttachId1(attachId);
        return a;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午6:57:35
     * 方法介绍:   查找最后的附件信息
     * 参数说明:   @return
     *
     * @return Attachment 附件信息
     */
    @Override
    public Attachment findByLast() {
        Attachment att = attachmentMapper.findByLast();
        return att;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午6:56:58
     * 方法介绍:   上传接口
     * 参数说明:   @param files 上传文件
     * 参数说明:   @param company 公司名
     * 参数说明:   @param module 模块名
     * 参数说明:   @return
     *
     * @return List<Attachment>  附件信息集合
     */
    @Override
    //多文件上传
    public List<Attachment> uploadReturn(MultipartFile[] files, String company, String module, String fNmae) {
        if (files.length == 0) {
            return null;
        }

        // 判断是否包括非法路径
        if(!StringUtils.checkNull(module)&&module.contains("..")){
            return null;
        }

        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
		/*if(os.toLowerCase().startsWith("win")){
			sb=sb.append(rb.getString("upload.win"));
		}else{
			sb=sb.append(rb.getString("upload.linux"));
		}*/
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
        List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        String sqlType = "1001";
        if(!StringUtils.checkNull(company)){
            sqlType = company.trim().replace("xoa","");
        }

        //查询是否kingbase环境
        String driver = FileUploadUtil.getDriver();
        if("kingbase8".equals(driver) && !company.contains("KB")){
            company = company.replace("xoa","xoaKB");
        }

        if (StringUtils.checkNull(sb.toString())) {
            if(RequestContextHolder.getRequestAttributes()!=null){
                HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
                sqlType = (String) request.getSession().getAttribute(
                        "loginDateSouse");
                String a = request.getRealPath("");
                sb.append(a);
                sb.append(System.getProperty("file.separator")).
                        //append(System.getProperty("file.separator")).
                                append(company).append(System.getProperty("file.separator")).
                        append(module).append(System.getProperty("file.separator")).append(ym);
            }
        } else {
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
        }
        String path = sb.toString();
        Attachment attachment = new Attachment();

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            Long filesize = file.getSize();
            String base64Code = null;
            if (!file.isEmpty()) {
                // 获得原始文件名
                String originalFilename = file.getOriginalFilename();
                // 把文件名中的特殊符号 调整为_ 防止报错 无法保存文件
                originalFilename = originalFilename.replaceAll("\\||\\?|\\<|\\>|\\/|\\\\|\\*|\\:","_");
                //判断字节的长度是否大于255&&操作系统为linux，成立则将附件名称转成MD5加密
                try {
                    int length = originalFilename.getBytes("UTF-8").length;
                    // 判断是否文件名过长 并且是Linux 进行加密名称
                    // 或者系统设置中 设置了加密
                    if((length>230&&os.toLowerCase().startsWith("linu"))||encryption){//
                        String type = originalFilename.substring(originalFilename.lastIndexOf("."));
                        String s = (new BASE64Encoder()).encodeBuffer((originalFilename.substring(0,originalFilename.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                        String regEx=("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                        String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                        if(trim.length()>100){
                            base64Code=(trim).substring(0,100)+type;
                        } else {
                            base64Code = trim+type;
                        }
                    }
                }catch (Exception e){

                }
                String fileName =null;
                if(!StringUtils.checkNull(base64Code)){
                    fileName= StringUtils.checkNull(fNmae) ? base64Code.trim() : fNmae;
                }else{
                    fileName = StringUtils.checkNull(fNmae) ? originalFilename.trim() : fNmae;
                }
			/*	String [] split= fileName.split("\\.");
				StringBuffer stringBuffer=new StringBuffer();
				if (split.length==3) {
					int x = 0;
					for (String s1 : split) {
						if (x == 1) {
							stringBuffer.append(s1);
						}
						if (x >1){
							stringBuffer.append("." + s1);
						}
						x++;
					}


					if (x == 3) {
						fileName = new String(stringBuffer);
						attachment.setAttachName(fileName);
					}

				}*/
                //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");

                //将文件名转为小写的后缀（fileName）为生成到服务器上的名称
                fileName =(fileName.substring(0,fileName.lastIndexOf("."))+(fileName.substring(fileName.lastIndexOf("."))).toLowerCase());


                String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                // 判断是否存在了相同的attachId
                Attachment byAttachId1 = findByAttachId1(Integer.valueOf(attachID));
                // 如果存在的话 重新获取attachId
                if(byAttachId1!=null){
                    attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                }
                StringBuffer s = new StringBuffer();
                if (os.toLowerCase().startsWith("win")) {
                    s = s.append(fileName);
                } else {
                    try {
                        s = s.append(new String(fileName.getBytes(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
                String newFileName = attachID + "." + fileName.toString();
                //String newFileName=new String(sf.getBytes(),"UTF-8");
                if (!file.isEmpty()) {
                    try {
                        if (!new File(path).exists()) {
                            new File(path).mkdirs();
                        }
                        //判断附件是否需要加密
                        if (encryption) {
                            AESUtil.encryption(file, path, newFileName, sqlType);
                        } else {
                            file.transferTo(new File(path, newFileName));
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                File f = new File(path + newFileName);
                f.renameTo(new File(newFileName));
                Integer isImg = 3;
                //获取后缀名
                String type = fileName.substring(fileName.lastIndexOf(".") + 1);
                String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                List<String> imageTyepLists = Arrays.asList(imagType);
                if (imageTyepLists.contains(type)) {
                    isImg = 0;
                } else {
                    isImg = 1;
                }
                //获得模块名
                int moduleID = 0;
                for (ModuleEnum em : ModuleEnum.values()) {
                    if (em.getName().equals(module.trim())) {
                        moduleID = em.getIndex();
                    }
                }

                attachment = new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(fileName);
                attachment.setAttachName(originalFilename);
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachment.setIsImage(isImg);
                //String url = path + System.getProperty("file.separator") + newFileName;
                //attachment.setUrl(url);
                attachment.setFileSize(Convert.convertFileSize(filesize));
                attachment.setSize(Convert.convertFileSize(filesize));
                attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                list.add(attachment);
                try {
                    Thread.sleep(17);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    @Override
    public List<Attachment> upload2(MultipartFile[] files, String company, String module) throws UnsupportedEncodingException {
        List<Attachment> list = new ArrayList<>();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            String name = file.getOriginalFilename();
            if (".mp4".equals(name.substring(name.indexOf("."), name.length()))
                    || ".rmvb".equals(name.substring(name.indexOf("."), name.length()))
                    || ".avi".equals(name.substring(name.indexOf("."), name.length()))
                    || ".ifo".equals(name.substring(name.indexOf("."), name.length()))
                    || ".wmv".equals(name.substring(name.indexOf("."), name.length()))) {
                list = this.uploadReturnVideo(files, company, module);

            } else {
                list = this.uploadReturn2(files, company, module);

            }
        }

        List<Attachment> attachmentList = new ArrayList<Attachment>();
        String attUrl = "";
        for (Attachment attachment : list) {
            attachment.setSize(attachment.getFileSize());
            this.saveAttachment(attachment);
            if (".mp4".equals(attachment.getAttachName().substring(attachment.getAttachName().indexOf("."), attachment.getAttachName().length()))
                    || ".rmvb".equals(attachment.getAttachName().substring(attachment.getAttachName().indexOf("."), attachment.getAttachName().length()))
                    || ".avi".equals(attachment.getAttachName().substring(attachment.getAttachName().indexOf("."), attachment.getAttachName().length()))
                    || ".ifo".equals(attachment.getAttachName().substring(attachment.getAttachName().indexOf("."), attachment.getAttachName().length()))
                    || ".wmv".equals(attachment.getAttachName().substring(attachment.getAttachName().indexOf("."), attachment.getAttachName().length()))

            ) {
                attUrl = "/img/video/" + attachment.getAttachId() + "." + attachment.getAttachName();
            } else {
                attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                        "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
            }


            attachment.setAid(attachment.getAid());
            attachment.setAttUrl(attUrl);
            attachmentList.add(attachment);
        }
        return attachmentList;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月26日 下午6:56:58
     * 方法介绍:   上传接口
     * 参数说明:   @param files 上传文件
     * 参数说明:   @param company 公司名
     * 参数说明:   @param module 模块名
     * 参数说明:   @return
     *
     * @return List<Attachment>  附件信息集合
     */
    @Override
    //单文件上传
    public Attachment uploadReturn1(MultipartFile files, String company, String module) {
        if (files.isEmpty() == true) {
            return null;
        }
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
        //List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        String copyPath = "";
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        if (StringUtils.checkNull(sb.toString())) {
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
        String path = sb.toString();
        Attachment attachment = new Attachment();
        MultipartFile file = files;
        Long filesize = files.getSize();
        if (!file.isEmpty()) {
            // 获得原始文件名
            String fileName = file.getOriginalFilename().trim();
            //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");
            String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
            StringBuffer s = new StringBuffer();
            if (os.toLowerCase().startsWith("win")) {
                s = s.append(fileName);
            } else {
                try {
                    s = s.append(new String(fileName.getBytes(), "UTF-8"));
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
            }

            String newFileName = attachID + "." + fileName.toString();
            //String newFileName=new String(sf.getBytes(),"UTF-8");
            if (!file.isEmpty()) {
                try {
                    if (!new File(path).exists()) {
                        new File(path).mkdirs();
                    }
                    // 转存文件
                    //file.transferTo(new File(path, newFileName));
                    // 转存文件
                    File file1 = new File(path, newFileName);
                    file.transferTo(file1);
                    File dir = new File(copyPath);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }
                    //File file = WebFileUtils.createFileByUrl(url, "jpg");
                    FileInputStream inputStream = new FileInputStream(file1);
                    MultipartFile multipartFile = new MockMultipartFile(file1.getName(), inputStream);
                    multipartFile.transferTo(new File(copyPath, newFileName));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            //转存需要判断文件是否为加密文件(修改文件名)
            String state = fileName.substring(fileName.lastIndexOf(".") + 1);
            if ("xoafile".equals(state)) {
                fileName = fileName.substring(0, fileName.lastIndexOf("xoafile") - 1);
            }

            File f = new File(path + newFileName);
            f.renameTo(new File(newFileName));
            Integer isImg = 3;
            //获取后缀名
            String type = fileName.substring(fileName.lastIndexOf(".") + 1);
            String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
            List<String> imageTyepLists = Arrays.asList(imagType);
            if (imageTyepLists.contains(type)) {
                isImg = 0;
            } else {
                isImg = 1;
            }
            //获得模块名
            int moduleID = 0;
            for (ModuleEnum em : ModuleEnum.values()) {
                if (em.getName().equals(module.trim())) {
                    moduleID = em.getIndex();
                }
            }

            attachment = new Attachment();
            attachment.setAttachId(attachID);
            attachment.setModule(moduleID);
            attachment.setAttachFile(fileName);
            attachment.setAttachName(fileName);
            attachment.setYm(ym);
            attachment.setAttachSign(new Long(0));
            attachment.setDelFlag(0);
            attachment.setPosition(2);
            attachment.setIsImage(isImg);
            //String url = path + System.getProperty("file.separator") + newFileName;
            //attachment.setUrl(url);
            attachment.setFileSize(Convert.convertFileSize(filesize));
            attachment.setSize(Convert.convertFileSize(filesize));
            attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            try {
                Thread.sleep(17);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }


        return attachment;
    }

    @Override
    //多文件上传
    public List<Attachment> uploadReturnenterprise(MultipartFile[] files, String company, String module, String sql) {
        if (files.length == 0) {
            return null;
        }
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
		/*if(os.toLowerCase().startsWith("win")){
			sb=sb.append(rb.getString("upload.win"));
			buffer=buffer.append(rb.getString("upload.win"));
		}else{
			sb=sb.append(rb.getString("upload.linux"));
			buffer=buffer.append(rb.getString("upload.linux"));
		}*/
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
        List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String copyPath = "";
        if (StringUtils.checkNull(sb.toString())) {
            String a = request.getRealPath("");
            sb.append(a);
            buffer.append(a);
            sb.append(System.getProperty("file.separator")).
//					append("attach").
//					append(System.getProperty("file.separator")).
        append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            buffer.append(System.getProperty("file.separator")).
//					append("attach").
//					append(System.getProperty("file.separator")).
        append("xoa" + sql).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            copyPath = buffer.toString();
        } else {

            sb.append(System.getProperty("file.separator")).
//					append("attach").
//					append(System.getProperty("file.separator")).
        append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            buffer.append(System.getProperty("file.separator")).
//					append("attach").
//					append(System.getProperty("file.separator")).
        append("xoa" + sql).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
            copyPath = buffer.toString();
        }
        String path = sb.toString();
        Attachment attachment = new Attachment();

        // 查询是否加密
        boolean encryption = sysTasksService.isEncryption();

        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            Long filesize = file.getSize();
            if (!file.isEmpty()) {
                // 获得原始文件名
                String fileName = file.getOriginalFilename().trim();

                //---------------------------------判断开始---------------------------
                //判断字节的长度是否大于255&&操作系统为linux，成立则将附件名称转成MD5加密
                try {
                    int length = fileName.getBytes("UTF-8").length;
                    // 判断是否文件名过长 并且是Linux 进行加密名称
                    // 或者系统设置中 设置了加密
                    if((length>230&&os.toLowerCase().startsWith("linu"))||encryption){//
                        String type = fileName.substring(fileName.lastIndexOf("."));
                        String s = (new BASE64Encoder()).encodeBuffer((fileName.substring(0,fileName.lastIndexOf("."))).getBytes(StandardCharsets.UTF_8));
                        String regEx=("[\\s\\\\/:\\*\\?\\\"<>\\|]");
                        String trim = Pattern.compile(regEx).matcher(s).replaceAll("").trim();
                        if(trim.length()>100){
                            fileName=(trim).substring(0,100)+type;
                        } else {
                            fileName = trim+type;
                        }
                    }
                }catch (Exception e){

                }


                //---------------------------------判断结束---------------------------




                //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");
                String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                StringBuffer s = new StringBuffer();
                if (os.toLowerCase().startsWith("win")) {
                    s = s.append(fileName);
                } else {
                    try {
                        s = s.append(new String(fileName.getBytes(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
                String newFileName = attachID + "." + fileName.toString();
                //String newFileName=new String(sf.getBytes(),"UTF-8");
                if (!file.isEmpty()) {
                    try {
                        if (!new File(path, newFileName).exists()) {
                            new File(path, newFileName).mkdirs();
                            //new File(path,newFileName).createNewFile();
                        }
                        // 转存文件
                        File file1 = new File(path, newFileName);
                        file.transferTo(file1);
                        File dir = new File(copyPath);
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }
                        //File file = WebFileUtils.createFileByUrl(url, "jpg");
                        FileInputStream inputStream = new FileInputStream(file1);
                        MultipartFile multipartFile = new MockMultipartFile(file1.getName(), inputStream);
                        multipartFile.transferTo(new File(copyPath, newFileName));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                File f = new File(path + newFileName);
                f.renameTo(new File(newFileName));

//

                Integer isImg = 3;
                //获取后缀名
                String type = fileName.substring(fileName.indexOf(".") + 1);
                String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                List<String> imageTyepLists = Arrays.asList(imagType);
                if (imageTyepLists.contains(type)) {
                    isImg = 0;
                } else {
                    isImg = 1;
                }
                //获得模块名
                int moduleID = 0;
                for (ModuleEnum em : ModuleEnum.values()) {
                    if (em.getName().equals(module.trim())) {
                        moduleID = em.getIndex();
                    }
                }

                attachment = new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(file.getOriginalFilename().trim());
                attachment.setAttachName(file.getOriginalFilename().trim());
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachment.setIsImage(isImg);
                //String url = path + System.getProperty("file.separator") + newFileName;
                //attachment.setUrl(url);
                attachment.setFileSize(Convert.convertFileSize(filesize));
                attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                list.add(attachment);
                try {
                    Thread.sleep(17);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }


    @Override
    public String attachmenturl(Attachment att, String company, String module) {
        String attUrl = "AID=" + att.getAid() + "&" + "MODULE=" + module + "&" + "YM=" + att.getYm() + "&" + "ATTACHMENT_ID=" + att.getAttachId() + "&" + "ATTACHMENT_NAME=" + att.getAttachName();
        return attUrl;
    }

    @Override
    public List<Attachment> upload(MultipartFile[] files, String company, String module) throws UnsupportedEncodingException {
        // 判断是否是非法文件
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            if(!FileUploadUtil.checkFile(file.getOriginalFilename())){
                return null;
            }
        }

        List<Attachment> list = this.uploadReturn(files, company, module, null);
        List<Attachment> attachmentList = new ArrayList<Attachment>();
        for (Attachment attachment : list) {
            attachment.setSize(attachment.getFileSize());
            this.saveAttachment(attachment);
            String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                    "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
            attachment.setAid(attachment.getAid());
            attachment.setAttUrl(attUrl);
            attachmentList.add(attachment);
        }
        return attachmentList;
    }


    @Override
    public Attachment upload1(MultipartFile files, String company, String module) throws UnsupportedEncodingException {
        Attachment list = this.uploadReturn1(files, company, module);
        Attachment attachmentList = new Attachment();

        list.setSize(list.getFileSize());
        this.saveAttachment(list);
        String attUrl = "AID=" + list.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + list.getYm() + "&ATTACHMENT_ID=" + list.getAttachId().toString() +
                "&ATTACHMENT_NAME=" + list.getAttachName() + "&FILESIZE=" + list.getFileSize();
        list.setAid(list.getAid());
        list.setAttUrl(attUrl);
        //attachmentList.add(attachment);

        return list;
    }

    @Override
    public List<Attachment> uploadenterprise(MultipartFile[] files, String company, String module, String sql) throws UnsupportedEncodingException {
        List<Attachment> list = this.uploadReturnenterprise(files, company, module, sql);
        List<Attachment> attachmentList = new ArrayList<Attachment>();
        List<Attachment> attachmentList2 = new ArrayList<Attachment>();
        //ContextHolder.setConsumerType(sql);
        for (int i = 0; i < list.size(); i++) {
            Attachment attachment = list.get(i);
            //attachment.setAttachId(attachments.get(i).getAttachId());
            attachment.setSize(attachment.getFileSize());
            this.saveAttachment(attachment);
            String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                    "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
            attachment.setAid(attachment.getAid());
            attachment.setAttUrl(attUrl);
            attachmentList.add(attachment);
        }
        ContextHolder.setConsumerType("xoa" + sql);
        for (int i = 0; i < list.size(); i++) {
            Attachment attachment = list.get(i);
            //attachment.setAttachId(attachments.get(i).getAttachId());
            attachment.setSize(attachment.getFileSize());
            attachment.setAid(null);
            this.saveAttachment(attachment);
            String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                    "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
            attachment.setAid(attachment.getAid());
            attachment.setAttUrl(attUrl);
            attachmentList2.add(attachment);
        }
        return attachmentList;
    }

    @Override
    public ToJson delete(@RequestParam("AID") String aid,
                         @RequestParam("MODULE") String module,
                         @RequestParam("YM") String ym,
                         @RequestParam("ATTACHMENT_ID") String attachmentId,
                         @RequestParam("ATTACHMENT_NAME") String attachmentName,
                         @RequestParam("COMPANY") String company,
                         HttpServletResponse response,
                         HttpServletRequest request) {
        ToJson toJson = new ToJson(1,"err");
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String userId = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie).getUserId();
        try{
            if (osName.toLowerCase().startsWith("win")) {
                //判断路径是否是相对路径，如果是的话，加上运行的路径
                String uploadPath = rb.getString("upload.win");
                if (uploadPath.indexOf(":") == -1) {
                    //获取运行时的路径
                    String basePath = this.getClass().getClassLoader().getResource(".").getPath() + File.pathSeparator;
                    //获取截取后的路径
                    String str2 = "";
                    if (basePath.indexOf("/xoa") != -1) {
                        //返回指定字符在此字符串中第一次出现处的索引
                        int index = basePath.indexOf("/xoa");
                        //从指定位置开始到指定位置结束截取字符串
                        str2 = basePath.substring(0, index);
                    }
                    sb = sb.append(str2 + "/xoa");
                }
                sb.append(uploadPath);
            } else {
                sb = sb.append(rb.getString("upload.linux"));
            }
           //---------------------------------判断是否为Linux开始-------------------------------------

            // 查询是否加密
            boolean encryption = sysTasksService.isEncryption();


            attachmentName = FileUploadUtil.getEncryptionName(attachmentId, attachmentName, company, module, ym, encryption);

            //---------------------------------判断是否为Linux结束-------------------------------------
            // 根据aid查询附件信息获取附件名称
            String beforeAttachmentName = attachmentName;// 存前端传的参数attachmentName
            if (!StringUtils.checkNull(aid)) {
                Attachment attachment = attachmentMapper.selectByPrimaryKey(Integer.valueOf(aid));
                if (attachment != null && !StringUtils.checkNull(attachment.getAttachFile())) {
                    attachmentName = attachment.getAttachFile();
                }
            }
            String path = sb + System.getProperty("file.separator") + company +
                    System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym + System.getProperty("file.separator") + attachmentId + "." + attachmentName;
            boolean flag = false;
            boolean flag1 = false;
            File file = null;
            file = new File(path);
            if (!file.exists()) {
                // 如果不存在，使用前端传的参数attachmentName 再拼接路径
                path = sb + System.getProperty("file.separator") + company +
                        System.getProperty("file.separator") + module + System.getProperty("file.separator") + ym + System.getProperty("file.separator") + attachmentId + "." + beforeAttachmentName;
                file = new File(path);
            }
            if (!file.exists()) {
                // 把后缀名转换成小写 查看是否存在
                // （打捞局项目Linux系统中出现上传的文件是大写的后缀，但是存储在系统中是小写的后缀）
                file = new File(path.substring(0,path.lastIndexOf("."))+path.substring(path.lastIndexOf(".")).toLowerCase());
                // 如果不存在 查看是否是加密文件
                if(!file.exists()){
                    file = new File(path += ".xoafile");
                }
            }
            File newfile = new File(path + "." + Constant.delete);
            if (file.exists()) {// 路径为文件且不为空则进行删除
                //附件邮件模块限制
                Map<String, Object> map = new HashMap<>();
                map.put("attachmentId", attachmentId);
                map.put("attachmentName", attachmentName);
                List<String> list = emailBodyMapper.getPrivAttachment(map);
                for (int i = 0, leg = list.size(); i < leg; i++) {
                    String fromId = list.get(i);
                    if (fromId.equals(userId)) {
                        flag1 = true;
                    }
                }
                if (list == null || list.size() == 0 || flag1 == true) {
                    Attachment attachment = new Attachment();
                    attachment.setAid(Integer.parseInt(aid));
                    attachment.setAttachId(attachmentId);
                    attachment.setAttachName(attachmentName);
                    attachmentMapper.delete(attachment);
                    file.renameTo(newfile);
                    flag = true;
                }
            }
            if (flag == true) {
                toJson.setFlag(0);
                toJson.setMsg("OK");
            }
        }catch (Exception e) {
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<Attachment> selectByPrimaryKey(Integer aid, String module, HttpServletRequest request) {
        ToJson<Attachment> json = new ToJson<Attachment>();
        String company = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class);
        try {
            Attachment attachment = attachmentMapper.selectByPrimaryKey(aid);
            String attUrl = "AID=" + attachment.getAid() + "&" + "MODULE=" + module + "&" + "COMPANY=" + company + "&" + "YM=" + attachment.getYm() + "&" + "ATTACHMENT_ID=" + attachment.getAttachId() + "&" +
                    "ATTACHMENT_NAME=" + attachment.getAttachName() + "&" + "FILESIZE=" + attachment.getSize();
            attachment.setAttUrl(attUrl);
            json.setObject(attachment);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson<Attachment> findByAIds(String aids, HttpServletRequest request) {
        ToJson<Attachment> json = new ToJson<Attachment>();
        String company = "xoa" + SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class);
        try {
            String module = request.getParameter("module");
            List<Attachment> attachments = attachmentMapper.selectByAids(aids.split(","));
            for (Attachment attachment : attachments) {
                String attUrl = "AID=" + attachment.getAid() + "&" + "MODULE=" + module + "&" + "COMPANY=" + company + "&" + "YM=" + attachment.getYm() + "&" + "ATTACHMENT_ID=" + attachment.getAttachId() + "&" +
                        "ATTACHMENT_NAME=" + attachment.getAttachName() + "&" + "FILESIZE=" + attachment.getSize();
                attachment.setAttUrl(attUrl);
            }
            json.setObject(attachments);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }


    @Override
    public Attachment selectByAid(Integer aid) {
        return attachmentMapper.selectByPrimaryKey(aid);
    }


    @Override
    public List<Attachment> uploadScan(MultipartFile[] files, String company, String module, String fileNmae) throws UnsupportedEncodingException {
        List<Attachment> list = this.uploadReturn(files, company, module, fileNmae);
        List<Attachment> attachmentList = new ArrayList<Attachment>();
        //查询是否kingbase环境
        String driver = FileUploadUtil.getDriver();
        if("kingbase8".equals(driver) && !company.contains("KB")){
            company = company.replace("xoa","xoaKB");
        }
        for (Attachment attachment : list) {
            attachment.setSize(attachment.getFileSize());
            this.saveAttachment(attachment);
            String attUrl = "AID=" + attachment.getAid().toString() + "&MODULE=" + module + "&COMPANY=" + company + "&YM=" + attachment.getYm() + "&ATTACHMENT_ID=" + attachment.getAttachId().toString() +
                    "&ATTACHMENT_NAME=" + attachment.getAttachName() + "&FILESIZE=" + attachment.getFileSize();
            attachment.setAid(attachment.getAid());
            attachment.setAttUrl(attUrl);
            attachmentList.add(attachment);
        }
        return attachmentList;
    }

    @Override
    //多文件上传
    public List<Attachment> uploadReturnVideo(MultipartFile[] files, String company, String module) {
        if (files.length == 0) {
            return null;
        }
        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
		/*if(os.toLowerCase().startsWith("win")){
			sb=sb.append(rb.getString("upload.win"));
		}else{
			sb=sb.append(rb.getString("upload.linux"));
		}*/
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
        List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        if (StringUtils.checkNull(sb.toString())) {
            String a = request.getRealPath("");
            sb.append(a);
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
        } else {
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
        }
        String path = request.getRealPath("") + "/ui/img/video";
        Attachment attachment = new Attachment();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];
            Long filesize = file.getSize();
            if (!file.isEmpty()) {
                // 获得原始文件名
                String fileName = file.getOriginalFilename().trim();

                //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");
                String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                StringBuffer s = new StringBuffer();
                if (os.toLowerCase().startsWith("win")) {
                    s = s.append(fileName);
                } else {
                    try {
                        s = s.append(new String(fileName.getBytes(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
                String newFileName = attachID + "." + fileName.toString();
                //String newFileName=new String(sf.getBytes(),"UTF-8");
                if (!file.isEmpty()) {
                    try {
                        if (!new File(path).exists()) {
                            new File(path).mkdirs();
                        }
                        // 转存文件
                        file.transferTo(new File(path, newFileName));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                //String filePath = "/img/video" + newFileName;
                /*File f = new File(path + newFileName);*/
                //File f = new File(filePath);
                //f.renameTo(new File(filePath));
                Integer isImg = 3;
                //获取后缀名
                String type = fileName.substring(fileName.indexOf(".") + 1);
                String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                List<String> imageTyepLists = Arrays.asList(imagType);
                if (imageTyepLists.contains(type)) {
                    isImg = 0;
                } else {
                    isImg = 1;
                }
                //获得模块名
                int moduleID = 0;
                for (ModuleEnum em : ModuleEnum.values()) {
                    if (em.getName().equals(module.trim())) {
                        moduleID = em.getIndex();
                    }
                }

                attachment = new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(fileName);
                attachment.setAttachName(fileName);
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachment.setIsImage(isImg);
                //String url = path + System.getProperty("file.separator") + newFileName;
                //attachment.setUrl(url);
                attachment.setFileSize(Convert.convertFileSize(filesize));
                attachment.setSize(Convert.convertFileSize(filesize));
                attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                list.add(attachment);
                try {
                    Thread.sleep(17);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    @Override
    //多文件上传
    public List<Attachment> uploadReturn2(MultipartFile[] files, String company, String module) {
        if (files.length == 0) {
            return null;
        }

        ResourceBundle rb = ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        StringBuffer buffer = new StringBuffer();
		/*if(os.toLowerCase().startsWith("win")){
			sb=sb.append(rb.getString("upload.win"));
		}else{
			sb=sb.append(rb.getString("upload.linux"));
		}*/
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
        List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"))
        ;
        if (StringUtils.checkNull(sb.toString())) {
            String a = request.getRealPath("");
            sb.append(a);
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
        } else {
            sb.append(System.getProperty("file.separator")).
                    //append(System.getProperty("file.separator")).
                            append(company).append(System.getProperty("file.separator")).
                    append(module).append(System.getProperty("file.separator")).append(ym);
        }
        String path = sb.toString();
        Attachment attachment = new Attachment();
        for (int i = 0; i < files.length; i++) {
            MultipartFile file = files[i];

            Long filesize = file.getSize();
            if (!file.isEmpty()) {
                // 获得原始文件名
                String fileName = file.getOriginalFilename().trim();
                //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");
                String attachID = String.valueOf(Math.abs((int) System.currentTimeMillis()));
                StringBuffer s = new StringBuffer();
                if (os.toLowerCase().startsWith("win")) {
                    s = s.append(fileName);
                } else {
                    try {
                        s = s.append(new String(fileName.getBytes(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                }
                String newFileName = attachID + "." + fileName.toString();
                //String newFileName=new String(sf.getBytes(),"UTF-8");
                if (!file.isEmpty()) {
                    try {
                        if (!new File(path).exists()) {
                            new File(path).mkdirs();
                        }
                        //判断附件是否需要加密
                        if (sysTasksService.isEncryption()) {
                            AESUtil.encryption(file, path, newFileName, sqlType);
                        } else {
                            file.transferTo(new File(path, newFileName));
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                File f = new File(path + newFileName);
                f.renameTo(new File(newFileName));
                Integer isImg = 3;
                //获取后缀名

                String type = fileName.substring(fileName.indexOf(".") + 1);
                String[] imagType = {"jpg", "png", "bmp", "gif", "JPG", "PNG", "BMP", "GIF"};
                List<String> imageTyepLists = Arrays.asList(imagType);
                if (imageTyepLists.contains(type)) {
                    isImg = 0;
                } else {
                    isImg = 1;
                }
                //获得模块名
                int moduleID = 0;
                for (ModuleEnum em : ModuleEnum.values()) {
                    if (em.getName().equals(module.trim())) {
                        moduleID = em.getIndex();
                    }
                }

                attachment = new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(fileName);
                attachment.setAttachName(fileName);
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachment.setIsImage(isImg);
                //String url = path + System.getProperty("file.separator") + newFileName;
                //attachment.setUrl(url);
                attachment.setFileSize(Convert.convertFileSize(filesize));
                attachment.setSize(Convert.convertFileSize(filesize));
                attachment.setTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                list.add(attachment);
                try {
                    Thread.sleep(17);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }

    @Override
    public Attachment selectOneBySearch(Map<String, Object> paraMap){
        return attachmentMapper.selectOneBySearch(paraMap);
    }


    public String getCompany(String company){
        String driver = FileUploadUtil.getDriver();
        if("kingbase8".equals(driver) && !company.contains("KB")){
            company = company.replace("xoa","xoaKB");
        }
        return company;
    }

}
