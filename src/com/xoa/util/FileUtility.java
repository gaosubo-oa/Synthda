package com.xoa.util;

import com.xoa.util.common.StringUtils;
import com.xoa.util.netdisk.ZipUtils;

import java.io.*;
import java.math.BigDecimal;

public class FileUtility {

    /**
     * 把输出流输出到文件中
     *
     * @param out     文件输出流
     * @param content 要写入的内容
     * @param charSet 字符编码
     */
    public static void outStream2File(OutputStream out, String content, String charSet) {
        if (out == null) {
            return;
        }
        OutputStreamWriter writer = null;
        try {
            //判断是否是一个合法的编码
            if (charSet == null || "".equals(charSet)) {
                writer = new OutputStreamWriter(out);
            } else {
                writer = new OutputStreamWriter(out, charSet);
            }
            //将内容写入文件
            writer.write(content);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static void string2File(String filePath, String content) {
        string2File(filePath, content, "utf-8");
    }

    /**
     * 根据文件路劲获取输出流，将内容写入文件
     * @param filePath 文件路径
     * @param content 待写入内容
     * @param charSet 字符编码
     */
    public static void string2File(String filePath, String content, String charSet) {
        OutputStream out = null;
        File f = new File(filePath);
        try {
            //如果父文件路径不存在，则创建
            if (!f.getParentFile().exists()) {
                f.getParentFile().mkdirs();
            }
            //如果当前文件不存在，创建文件
            if (!f.exists()) {
                f.createNewFile();
            }
            //验证文件是否可写
            if(!f.canWrite()){
                f.setWritable(true);
            }

            //拿到文件的输出流
            out = new FileOutputStream(f);
            outStream2File(out,content,charSet);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            closeStream(out);
        }
    }

    public static String file2String(String filePath){
        return file2String(filePath,"utf-8");
    }

    public static String file2String(String filePath,String charSet){
        String content = "";
        try {
            content = new String(file2Bytes(filePath),charSet);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return content;
    }


    /**
     * 把文件内容读取到字节数组中
     * @param filePath 文件路径
     * @return
     */
    public static byte[] file2Bytes(String filePath){
        InputStream in = null;
        try{
            File f = new File(filePath);
            if(!f.exists()){
                return null;
            }
            in = new FileInputStream(f);
            int fileLength = (int) f.length();
            byte[] b = new byte[fileLength];
            in.read(b,0,fileLength);
            return b;
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            closeStream(in);
        }
        return null;
    }


    //文件重命名
    public static boolean fileRename(String filePath,String newName) throws Exception {
        File f = new File(filePath);
        //判断文件是否存在
        if(!f.exists()){
            throw new Exception("文件不存在，重命名失败");
        }
        String parentPath = f.getParent();
        File newFile = new File(parentPath,newName);
        if(!f.renameTo(newFile)){
            throw new Exception("重命名失败");
        }
        return true;
    }

    //文件删除
    public static boolean fileDelete(String filePath){
        File f = new File(filePath);
        if(f.exists()){
            //如果文件存在 删除
            return f.delete();
        }
        //文件不存在之间返回true
        return true;
    }



    //输出流关闭工具类
    public static void closeStream(OutputStream  o){
        if(o!=null){
            try {
                o.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //输入流关闭工具类
    public static void closeStream(InputStream  in){
        if(in!=null){
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 计算容量
     * @param originalSize  原始容量
     * @param changeSizes 变动的容量
     * @param flag 1：添加，2：删除
     * @return
     */
    public static double getCapacity(double originalSize,String changeSizes,int flag){
        double size =0;
        if (!StringUtils.checkNull(changeSizes)) {
            String[] changeSizeArr=changeSizes.split(",");
            for(String changeSize:changeSizeArr){
                if (changeSize.indexOf("MB") != -1) {
                    String file = changeSize.replace("MB", "");
                    size += Double.valueOf(file);
                } else if (changeSize.indexOf("KB") != -1) {
                    String file = changeSize.replace("KB", "");
                    size = ZipUtils.getM(Double.valueOf(file));
                    BigDecimal b = new BigDecimal(size);
                    size += b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                } else if (changeSize.indexOf("B") != -1) {
                    String file = changeSize.replace("B", "");
                    double kbSize = ZipUtils.getKB(Double.valueOf(file));
                    size = ZipUtils.getM(kbSize);
                    BigDecimal b = new BigDecimal(size);
                    size += b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
                }
            }
            if(flag==1){
                originalSize+=size;
            }
            if(flag==2){
                originalSize-=size;
            }
        }
        return originalSize;
    }


    /**
     * 计算容量。全部转为B
     * @param originalSize  原始容量
     * @param changeSizes 变动的容量
     * @param flag 1：添加，2：删除
     * @return
     */
    public static Long computingCapacity(Long originalSize,String changeSizes,int flag){
        long size = 0L;
        BigDecimal initDecimal = new BigDecimal(1024);
        if (!StringUtils.checkNull(changeSizes)) {
            String[] changeSizeArr=changeSizes.split(",");
            for(String changeSize:changeSizeArr){
                if (changeSize.contains("GB")) {
                    String file = changeSize.replace("GB", "");
                    BigDecimal fileDecimal = new BigDecimal(file.trim());
                    size += fileDecimal.multiply(initDecimal).multiply(initDecimal).multiply(initDecimal).longValue();
                } else if (changeSize.contains("MB")) {
                    String file = changeSize.replace("MB", "");
                    BigDecimal fileDecimal = new BigDecimal(file.trim());
                    size += fileDecimal.multiply(initDecimal).multiply(initDecimal).longValue();
                } else if (changeSize.contains("KB")) {
                    String file = changeSize.replace("KB", "");
                    BigDecimal fileDecimal = new BigDecimal(file.trim());
                    size += fileDecimal.multiply(initDecimal).longValue();
                } else if (changeSize.contains("B")) {
                    String file = changeSize.replace("B", "");
                    size += Long.parseLong(file.trim());
                }
            }
            if(flag==1){
                originalSize+=size;
            }
            if(flag==2){
                originalSize-=size;
            }
        }
        return originalSize;
    }
}
