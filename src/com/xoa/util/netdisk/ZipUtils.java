package com.xoa.util.netdisk;

import com.xoa.util.CookiesUtil;
import com.xoa.util.aes.AESUtil;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * Created by 韩东堂 on 2017/7/5.
 */
public class ZipUtils {
    public static void doCompress(String srcFile, String zipFile) throws Exception {
        doCompress(new File(srcFile), new File(zipFile));
    }

    /**
     * 文件压缩
     * @param srcFile  目录或者单个文件
     * @param destFile 压缩后的ZIP文件
     */
    public static void doCompress(File srcFile, File destFile) throws Exception {
        ZipOutputStream out = new ZipOutputStream(new FileOutputStream(destFile));
        if(srcFile.isDirectory()){
            File[] files = srcFile.listFiles();
            for(File file : files){
                doCompress(file, out);
            }
        }else {
            doCompress(srcFile, out);
        }
    }

    public static void doCompress(String pathname, ZipOutputStream out) throws IOException {
        doCompress(new File(pathname), out);
    }

    public static void doCompress(File file, ZipOutputStream out) throws IOException{
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String sqlType = (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
        if( file.exists() ){
            String fileName = file.getName();
            boolean bol =false;
            //批量下载处理加密文件
            if("xoafile".equals(fileName.substring(fileName.lastIndexOf(".")+1))){
                fileName = fileName.substring(0,fileName.lastIndexOf(".xoafile"));
                fileName = fileName.substring(0,fileName.lastIndexOf(".")) +"(加密文件)"+ fileName.substring(fileName.lastIndexOf("."));
                bol=true;
            }
            FileInputStream fis = null;
            InputStream inputStream = null;
            try{
                fis = new FileInputStream(file);
                out.putNextEntry(new ZipEntry(fileName));
                if (bol) {
                    byte[] abc = AESUtil.download(file, sqlType, bol);
                    out.write(abc, 0, abc.length);
                }else {
                    inputStream = new FileInputStream(file);
                    byte[] b = new byte[2048];
                    int length;
                    while ((length = inputStream.read(b)) > 0) {
                        out.write(b, 0, length);
                    }
                }
                out.flush();
            }catch ( Exception e){
                e.printStackTrace();
            }finally {
                if(fis!=null){
                    fis.close();
                }
                if(inputStream!=null){
                    inputStream.close();
                }
                if(out!=null){
                    out.closeEntry();
                }
            }
        }
    }

    /**
     * @作者：张航宁
     * @时间：2017/7/26
     * @介绍：压缩文件
     * @参数：
     */
    public static void zip(String inName, String outName){
        if(inName.contains("..")){
            return;
        }
        if(outName.contains("..")){
            return;
        }
        File file = new File(inName);
        int length = (int) file.length();
        byte[] b = new byte[length];
        try {
            InputStream in = new FileInputStream(file);
            in.read(b );
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(new File(outName)));
            zout.setLevel(9);
            ZipEntry zipEntry = new ZipEntry(file.getName());
            zout.putNextEntry(zipEntry);
            zout.write(b);
            zout.finish();
            zout.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * 作者: 张航宁
     * 日期: 2018/9/6
     * 参数: files 要压缩的文件数组 path 压缩后输出的压缩包地址
     * 说明: 
     */
    public static void zipFiles(List<File> files, String path){
        if(path.contains("..")){
            return;
        }
        byte[] buf=new byte[1024];
        try{
            ZipOutputStream out = new ZipOutputStream(new FileOutputStream(new File(path)));
            for(int i=0,length=files.size();i<length;i++){
                FileInputStream in=new FileInputStream(files.get(i));
                out.putNextEntry(new ZipEntry(files.get(i).getName()));
                int len;
                while((len=in.read(buf))>0){
                    out.write(buf,0,len);
                }
                out.closeEntry();
                in.close();
            }
            out.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    public static double getM(double k){ // 该参数表示kb的值
        double m;
        m = k / 1024.0;
        return m; //返回kb转换之后的M值
    }

    public static double getKB(double b){ // 该参数表示b的值
        double kb;
        kb = b / 1024.0;
        return kb; //返回b转换之后的KB值
    }


    /**
     * 打包下载
     *
     */
    public static void downFile(HttpServletResponse resp, ArrayList<String> filePathList) throws ServletException,IOException {
        // 头文件
        resp.setContentType("APPLICATION/OCTET-STREAM");
        resp.setHeader("Content-Disposition",
                "attachment; filename=" + getZipFilename());

        // 压缩文件
        ZipOutputStream zos = new ZipOutputStream(resp.getOutputStream());
        // --拼装
        ArrayList<File> fileList = new ArrayList<File>();
        for (int i = 0; i < filePathList.size(); i++) {
            File file = new File(filePathList.get(i));
            fileList.add(file);
        }
        File[] files = fileList.toArray(new File[fileList.size()]);
        // --打包
        zipFile(files, "", zos);

        zos.flush();
        zos.close();
    }

    /**
     * 打包文件
     *
     * @param subs
     *            文件数组
     * @param baseName
     *            自定义名字
     * @param zos
     *            输出流
     * @throws IOException
     */
    public static void zipFile(File[] subs, String baseName, ZipOutputStream zos) throws IOException {
        for (int i = 0; i < subs.length; i++) {
            File f = subs[i];
            zos.putNextEntry(new ZipEntry( f.getName() ));
            FileInputStream fis = new FileInputStream(f);
            byte[] buffer = new byte[1024];
            int r = 0;
            while ((r = fis.read(buffer)) != -1) {
                zos.write(buffer, 0, r);
            }
            fis.close();
        }
    }

    /**
     * 压缩包名字
     *
     * @return
     */
    public static String getZipFilename() {
        Date date = new Date();
        String s = date.getTime() + ".zip";
        return s;
    }

}
