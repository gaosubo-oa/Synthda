package com.xoa.util.aes;

import com.ibatis.common.resources.Resources;
import com.xoa.util.common.StringUtils;
import com.xoa.util.dataSource.DataSourceInit;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Properties;

@Component
public class AESUtil {

    private static final String KEY_AES = "AES";

    private static String getEncryKEY(String dataBase) throws Exception {
        Properties props = Resources.getResourceAsProperties("jdbc-sql.properties");
        String driver = props.getProperty("driverClassName");
        dataBase = dataBase.substring(dataBase.length()-4);
        String url,username,password = "";
        if(props.getProperty("driverClassName").contains("kingbase8")){
            url = props.getProperty("KingBase8.url" + dataBase);
            username = props.getProperty("KingBase8.username" + dataBase);
            password = props.getProperty("KingBase8.password" + dataBase);
        }else {
            url = props.getProperty("url" + dataBase);
            username = props.getProperty("uname" + dataBase);
            password = props.getProperty("password" + dataBase);
        }
        Class.forName("com.mysql.cj.jdbc.Driver");
        String sql = "SELECT PARA_NAME,PARA_VALUE FROM sys_para WHERE PARA_NAME = 'KEY_ENCRYPTION'";
        Connection conn = DriverManager.getConnection(url, username, password);

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        String KRY="";
        while(rs.next()){
            KRY=rs.getString("PARA_VALUE");
        }
        conn.close();
        return KRY;
    }


    /**
     * 字符串加密
     * @param src
     * @param key
     * @return
     * @throws Exception
     */
    public static String encrypt(String src, String key) throws Exception {

        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, KEY_AES);
        Cipher cipher = Cipher.getInstance(KEY_AES);
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(src.getBytes());
        return byte2hex(encrypted);
    }

    /**
     * 字节加密
     * @param src
     * @param key
     * @return
     * @throws Exception
     */
    public static byte[] encrypt(byte[] src , String key) throws Exception {

        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, KEY_AES);
        Cipher cipher = Cipher.getInstance(KEY_AES);
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        return cipher.doFinal(src);
    }

    /**
     * 字符串解密
     * @param src
     * @param key
     * @return
     * @throws Exception
     */
    public static String decrypt(String src, String key) throws Exception {
        if (key == null || key.length() != 16) {
            throw new Exception("key不满足条件");
        }
        byte[] raw = key.getBytes();
        SecretKeySpec skeySpec = new SecretKeySpec(raw, KEY_AES);
        Cipher cipher = Cipher.getInstance(KEY_AES);
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] encrypted1 = hex2byte(src);
        byte[] original = cipher.doFinal(encrypted1);
        return new String(original);
    }

    /**
     * 字节解密
     * @param src
     * @param key
     * @return
     * @throws Exception
     */
    public static byte[] decrypt(byte[] src, String key) throws Exception {
        if (key == null || key.length() != 16) {
            throw new Exception("key不满足条件");
        }
        byte[] raw=key.getBytes();
        SecretKeySpec keySpec=new SecretKeySpec(raw, KEY_AES);
        Cipher cipher=Cipher.getInstance(KEY_AES);
        cipher.init(Cipher.DECRYPT_MODE, keySpec);
        return cipher.doFinal(src);
    }


    private static byte[] hex2byte(String strhex) {
        if (strhex == null) {
            return null;
        }
        int l = strhex.length();
        if (l % 2 == 1) {
            return null;
        }
        byte[] b = new byte[l / 2];
        for (int i = 0; i != l / 2; i++) {
            b[i] = (byte) Integer.parseInt(strhex.substring(i * 2, i * 2 + 2),
                    16);
        }
        return b;
    }

    private static String byte2hex(byte[] b) {
        StringBuilder hs = new StringBuilder();
        String stmp = "";
        for (int n = 0; n < b.length; n++) {
            stmp = (Integer.toHexString(b[n] & 0XFF));
            if (stmp.length() == 1) {
                hs.append("0").append(stmp);
            } else {
                hs.append(stmp);
            }
        }
        return hs.toString().toUpperCase();
    }

    /**
     * 文件加密
     * @param sourceFile
     * @param newPath
     * @param newName
     * @param dataBase
     * @return
     */
    public static File encryption (MultipartFile sourceFile , String newPath, String newName, String dataBase ) {
        InputStream in = null;
        BufferedOutputStream out=null;
        File out1file=null;
        try {
            String key = getEncryKEY(dataBase);
            in= sourceFile.getInputStream();
            //获取流文件
            List<byte[]> list =readword(in,4096);
            //对第一个数组加密
            byte[] encr =list.get(0);
            byte[] encryp = encrypt(encr,key);
            String stbyte  = String.format("%08d", encryp.length);
            String str2 ="XOAFILE1"+stbyte;
            //加密前缀转byte[]  headbyte 前缀加密
            byte[] bstrbb = encrypt(str2.getBytes(),key);
            //拼接加密头和秘文
            byte[] over = new byte[encryp.length+bstrbb.length];
            System.arraycopy(bstrbb,0,over,0,bstrbb.length);
            System.arraycopy(encryp,0,over,bstrbb.length,encryp.length);
            //加密后的数组替换第一个原文数组；
            list.set(0,over);
            out1file =new File (newPath,newName+".xoafile");
            out = new BufferedOutputStream(new FileOutputStream(out1file));
            for (byte[] a : list) {
                out.write(a, 0, a.length);
            }
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(out!=null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(in!=null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return out1file;
    }

    /**
     * 解密下载
     * @param sourceFile
     * @param dataBase
     */
    public static byte[] Decrypt(File sourceFile ,String dataBase){
        BufferedInputStream in = null;
        try
        {
            String key = getEncryKEY(dataBase);
            in = new BufferedInputStream(new FileInputStream(sourceFile));
            byte[] bytes = new byte[(int) sourceFile.length()];
            //读取加密文件
            in.read(bytes);
            //取出加密头并且解密
            byte [] headbyte = new byte[32];
            System.arraycopy(bytes,0,headbyte,0,32);
            // headbyte 前缀解密
            byte[] aaa = decrypt(headbyte,key);
            String str = new String(aaa);
            //解密加密头后获取加密数组长度
            int length= Integer.parseInt(str.substring(8,16));
            //取出加密数组
            byte [] abyte = new byte[length];
            System.arraycopy(bytes,32,abyte,0,length);
            //解密数组
            byte[] bbb = decrypt(abyte,key);
            //获取未加密的数组
            byte[] ccc = new byte[bytes.length-length-32];
            System.arraycopy(bytes,32+length,ccc,0,bytes.length-length-32);
            //拼接在一起
            byte[] over = new byte[bbb.length+ccc.length];
            System.arraycopy(bbb,0,over,0,bbb.length);
            System.arraycopy(ccc,0,over,bbb.length,ccc.length);
            return over;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    /**
     * 下载文件
     * @param sourceFile
     * @param dataBase
     * @return
     */
    public static byte[] download(File sourceFile ,String dataBase,boolean bol){
        byte[] b =null;
        if(!bol){
            InputStream in = null;
            try {
                in = new FileInputStream(sourceFile);
                b = new byte[(int) sourceFile.length()];
                in.read(b);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if(in!=null){
                    try {
                        in.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
            return b;
        }
        return Decrypt(sourceFile,dataBase);
    }







    /**
     * 获取字节流文件
     * @return
     */
    public static List<byte[]> readword(InputStream fileInputStream ,int size) {
        List<byte[]> list = new ArrayList<>();
        BufferedInputStream in = null;
        try {
            //读取文件(缓存字节流)
            in = new BufferedInputStream(fileInputStream);
            //一次性取多少字节
            byte[] bytes = new byte[size];
            //接受读取的内容(n就代表的相关数据，只不过是数字的形式)
            int n=-1;
            while ((n = in.read(bytes, 0, bytes.length)) != -1) {
                byte[] b =new byte[n];
                System.arraycopy(bytes,0,b,0,n);
                list.add(b);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if(in!=null){
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }


    //登陆时的aes算法解密过程
    public static String decryptToLogin(String sSrc, String sKey, String IV) throws Exception {

        // 判断Key是否正确
        if (sKey == null) {
            System.out.print("Key为空null");
            return null;
        }
        // 判断Key是否为16位
        if (sKey.length() != 16) {
            System.out.print("Key长度不是16位");
            return null;
        }
        byte[] raw = sKey.getBytes("ASCII");

        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
        IvParameterSpec iv = new IvParameterSpec(IV.getBytes());
        cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
        byte[] encrypted1 = com.xoa.util.systeminfo.Base64.decodeBase64(sSrc);//先用bAES64解密
        try {
            byte[] original = cipher.doFinal(encrypted1);
            String originalString = new String(original);
            return originalString;
        } catch (Exception e) {
            return null;
        }
    }
    //实际的加密解密操作
    private static byte[] Operation(byte[] src,String key,int mode) throws Exception{
        if (key==null) {
            System.out.println("Key不能为空");
            return null;
        }
        if (key.length()!=16) {
            System.out.println("Key需要16位长度");
            return null;
        }

        byte[] raw=key.getBytes("utf-8");
        SecretKeySpec keySpec=new SecretKeySpec(raw, "AES");
        Cipher cipher=Cipher.getInstance("AES/ECB/PKCS5Padding");
        cipher.init(mode, keySpec);
        byte[] encrypted=cipher.doFinal(src);
        return encrypted;
    }

    public static byte[] Encrypt(byte[] src,String key) throws Exception{
        return Operation(src, key, Cipher.ENCRYPT_MODE);
    }

    public static byte[] Decrypt(byte[] src,String key) throws Exception{
        return Operation(src, key, Cipher.DECRYPT_MODE);
    }


}
