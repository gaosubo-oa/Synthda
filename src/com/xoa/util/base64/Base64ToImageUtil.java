package com.xoa.util.base64;

import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Decoder;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.commons.codec.binary.Base64;


/**
 * Created by Administrator on 2019/7/10.
 */
public class Base64ToImageUtil {


    public static MultipartFile base64MutipartFile(String imgStr) {
        try {
            String[] baseStr = imgStr.split(",");
            BASE64Decoder base64Decoder = new BASE64Decoder();
            byte[] b = new byte[0];
            b = base64Decoder.decodeBuffer(baseStr[1]);
            for (int i = 0; i < b.length; ++i) {
                if (b[i] < 0) {
                    b[i] += 256;
                }
            }
            return new BASE64DecodedMultipartFile(b, baseStr[0]);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * @作者 廉立深
     * @日期 2021/2/19
     * @说明 base64转附件
     **/
    public static void base64ToFile(String base64, String fileName, String savePath,Base64FileListener listener) {
        File file = null;
        //创建文件目录
        String filePath = savePath;
        File dir = new File(filePath);
        if (!dir.exists() && !dir.isDirectory()) {
            dir.mkdirs();
        }
        BufferedOutputStream bos = null;
        FileOutputStream fos = null;
        try {
            byte[] bytes = Base64.decodeBase64(base64);
            file=new File(filePath + fileName);
            fos = new java.io.FileOutputStream(file);
            bos = new BufferedOutputStream(fos);
            bos.write(bytes);
        }
        catch (Exception e) {
            e.printStackTrace();
            listener.ResponseString(e.getMessage());
        }
        finally {
            if (bos != null) {
                try {
                    bos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    listener.ResponseString(e.getMessage());
                }
            }
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                    listener.ResponseString(e.getMessage());
                }
            }
        }
        listener.ResponseFile(file);
    }

}
