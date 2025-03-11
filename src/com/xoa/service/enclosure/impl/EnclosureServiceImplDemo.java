package com.xoa.service.enclosure.impl;

import com.xoa.dao.enclosure.AttachmentMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.service.enclosure.EnclosureServiceDemo;
import com.xoa.util.ModuleEnum;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by 刘佩峰 on 2017/6/15.
 */
  //单文件上传
@Service
public class EnclosureServiceImplDemo implements EnclosureServiceDemo {
    @Resource
    AttachmentMapper attachmentMapper;
    @Override
    public Attachment upload(File file, String company, String module) throws UnsupportedEncodingException {

          //读取properties文件的  rb.getString("aa")来获取update.properties文件在的aa属性的值
        ResourceBundle rb =  ResourceBundle.getBundle("upload");
        String os = System.getProperty("os.name");
        StringBuffer sb=new StringBuffer();
            StringBuffer buffer=new StringBuffer();
        if(os.toLowerCase().startsWith("win")){
            //sb=sb.append(rb.getString("upload.win"));
            //判断路径是否是相对路径，如果是的话，加上运行的路径
            String uploadPath = rb.getString("upload.win");
            if(uploadPath.indexOf(":")==-1){
                //获取运行时的路径
                String basePath = this.getClass().getClassLoader().getResource(".").getPath()+ File.pathSeparator;
                //获取截取后的路径
                String str2 = "";
                if(basePath.indexOf("/xoa")!=-1){
                    //获取字符串的长度
                    int length = basePath.length();
                    //返回指定字符在此字符串中第一次出现处的索引
                    int index = basePath.indexOf("/xoa");
                    //从指定位置开始到指定位置结束截取字符串
                    str2=basePath.substring(0,index);
                }
                sb = sb.append(str2 + "/xoa");
            }
            sb.append(uploadPath);
            buffer=buffer.append(rb.getString("upload.win"));
        }else{
            sb=sb.append(rb.getString("upload.linux"));
            buffer=buffer.append(rb.getString("upload.linux"));
        }
        List<Attachment> list = new ArrayList<Attachment>();
        //当前年月
        String ym = new SimpleDateFormat("yyMM").format(new Date());
        //存储路径
        String path=sb.toString()+System.getProperty("file.separator")+"attach"+System.getProperty("file.separator")+
                company+System.getProperty("file.separator") +module+ System.getProperty("file.separator") +ym;
        Attachment attachment=new Attachment();

            if(file.exists()){

                // 获得原始文件名
               String fileName=file.getName();
                //String fileName = new String(file.getOriginalFilename().getBytes("gbk"),"utf-8");
                String attachID=String.valueOf(Math.abs((int) System.currentTimeMillis()));
                StringBuffer s=new StringBuffer();
                if(os.toLowerCase().startsWith("win")){
                    s=s.append(fileName);
                }else{
                    s=s.append(new String(fileName.getBytes(),"UTF-8"));
                }
                String newFileName=attachID+"."+fileName.toString();
                //String newFileName=new String(sf.getBytes(),"UTF-8");
                if (!file.exists()) {
                    try{
                        if(!new File(path, newFileName).exists()){
                            new File(path, newFileName).mkdirs();
                        }
                        // 转存文件
                       //file.transferTo(new File(path,newFileName));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                File f=new File(path+newFileName);
                f.renameTo(new File(newFileName));
                Integer isImg=3;
                //获取后缀名
                String type=fileName.substring(fileName.indexOf(".") + 1);
                String[] imagType={"jpg","png","bmp","gif","JPG","PNG","BMP","GIF"};
                List<String> imageTyepLists=Arrays.asList(imagType);
                if(imageTyepLists.contains(type)){
                    isImg=0;
                }else{
                    isImg=1;
                }
                //获得模块名
                int moduleID=0;
                for(ModuleEnum em:ModuleEnum.values()){
                    if(em.getName().equals(module.trim())){
                        moduleID=em.getIndex();
                    }
                }
                //int moduleID=com.xoa.util.ModuleEnum.EMAIL.getIndex();
                attachment=new Attachment();
                attachment.setAttachId(attachID);
                attachment.setModule(moduleID);
                attachment.setAttachFile(fileName);
                attachment.setAttachName(fileName);
                attachment.setYm(ym);
                attachment.setAttachSign(new Long(0));
                attachment.setDelFlag(0);
                attachment.setPosition(2);
                attachmentMapper.insertSelective(attachment);
                attachment=findByLast();
                String attUrl="AID="+attachment.getAid()+"&"+"MODULE="+module+"&"+"COMPANY="+company+"&"+"YM="+attachment.getYm()+"&"+"ATTACHMENT_ID="+attachment.getAttachId()+"&"+"ATTACHMENT_NAME="+attachment.getAttachName();
                attachment.setAttUrl(attUrl);
                String url=path+System.getProperty("file.separator")+file.getName().trim();
                attachment.setUrl(url);
                attachment.setIsImage(isImg);

            }
        return  attachment;

    }


    public Attachment findByLast() {
        Attachment att = attachmentMapper.findByLast();
        return att;
    }
}