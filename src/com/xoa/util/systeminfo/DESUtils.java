package com.xoa.util.systeminfo;

import javax.crypto.*;
import javax.crypto.spec.DESKeySpec;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Random;

/**
 * @创建作者: 韩成冰
 * @创建日期: 2017/6/28 13:11
 * @类介绍: 加密工具类
 * @构造参数: 无
 **/
public class DESUtils {


    //加密密钥，后期可以根据不同的公司，设置不同的秘钥，注意xoa中是这个，要是改变，都要变
    public static final String MY_KEY = "gaosuboisnumber1";// "gaosuboisnumber1";
    public static final String NEW_KEY2020 = "8oa.cngaosubo123";

    //算法名称
    public static final String KEY_ALGORITHM = "DES";
    //算法名称/加密模式/填充方式
    //DES共有四种工作模式-->>ECB：电子密码本模式、CBC：加密分组链接模式、CFB：加密反馈模式、OFB：输出反馈模式
    public static final String CIPHER_ALGORITHM = "DES/ECB/NoPadding";

    /**
     * 生成密钥key对象
     * param KeyStr 密钥字符串
     *
     * @return 密钥对象
     * @throws InvalidKeyException
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     * @throws Exception
     */
    private static SecretKey keyGenerator(String keyStr) throws Exception {
        byte input[] = HexString2Bytes(keyStr);
        DESKeySpec desKey = new DESKeySpec(input);
        //创建一个密匙工厂，然后用它把DESKeySpec转换成
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
        SecretKey securekey = keyFactory.generateSecret(desKey);
        return securekey;
    }

    private static int parse(char c) {
        if (c >= 'a') return (c - 'a' + 10) & 0x0f;
        if (c >= 'A') return (c - 'A' + 10) & 0x0f;
        return (c - '0') & 0x0f;
    }

    // 从十六进制字符串到字节数组转换
    public static byte[] HexString2Bytes(String hexstr) {
        byte[] b = new byte[hexstr.length() / 2];
        int j = 0;
        for (int i = 0; i < b.length; i++) {
            char c0 = hexstr.charAt(j++);
            char c1 = hexstr.charAt(j++);
            b[i] = (byte) ((parse(c0) << 4) | parse(c1));
        }
        return b;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/27 16:55
     * @函数介绍: 加密非中文，加密数据getByte（）.length必须是8的倍数，解决这个问题，在后面添加若干垃圾数据，解密是排除。
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/

    public static String myEncrypt(String data, String key) throws Exception {


        //记录垃圾数据的个数（可能是1-7），个数拼接到加密后字符的开头
        int count = 0;
        while (data.getBytes().length % 8 != 0) {
            data = data + "0";
            count++;

        }
        Key deskey = keyGenerator(key);
        // 实例化Cipher对象，它用于完成实际的加密操作
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        SecureRandom random = new SecureRandom();
        // 初始化Cipher对象，设置为加密模式
        cipher.init(Cipher.ENCRYPT_MODE, deskey, random);
        byte[] results = cipher.doFinal(data.getBytes());
        // 该部分是为了与加解密在线测试网站（http://tripledes.online-domain-tools.com/）的十六进制结果进行核对
        for (int i = 0; i < results.length; i++) {

        }

        // 执行加密操作。加密后的结果通常都会用Base64编码进行传输
        return count + Base64.encodeBase64String(results);
    }

    /**
     * 加密数据
     *
     * @param data 待加密数据
     * @param key  密钥
     * @return 加密后的数据
     */
    public static String encrypt(String data, String key) throws Exception {


        Key deskey = keyGenerator(key);
        // 实例化Cipher对象，它用于完成实际的加密操作
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        SecureRandom random = new SecureRandom();
        // 初始化Cipher对象，设置为加密模式
        cipher.init(Cipher.ENCRYPT_MODE, deskey, random);
        try {
            // 为了防止解密时报javax.crypto.IllegalBlockSizeException: Input length must be multiple of 8 when decrypting with padded cipher异常，
            // 不能把加密后的字节数组直接转换成字符串
            byte[] results = cipher.doFinal(data.trim().getBytes());
            // 该部分是为了与加解密在线测试网站（http://tripledes.online-domain-tools.com/）的十六进制结果进行核对
            // 执行加密操作。加密后的结果通常都会用Base64编码进行传输
            return Base64.encodeBase64String(results);
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
            throw new Exception("IllegalBlockSizeException", e);
        } catch (BadPaddingException e) {
            e.printStackTrace();
            throw new Exception("BadPaddingException", e);
        }

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/27 17:10
     * @函数介绍: 由于加密要保证msg.getByte().length为8，所以会追加垃圾字符，解密要排除垃圾字符。
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    public static String myDecrypt(String data, String key) throws Exception {

        //去掉加密的垃圾字符，第一个n和后面的n个，
        String num = data.substring(0, 1);
        //去掉首字符。
        data = data.substring(1, data.length());
        Key deskey = keyGenerator(key);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        //初始化Cipher对象，设置为解密模式
        cipher.init(Cipher.DECRYPT_MODE, deskey);
        // 执行解密操作
        String msg = new String(cipher.doFinal(Base64.decodeBase64(data)));
        //排除追加垃圾数据
        String publicMsg = new String(cipher.doFinal(Base64.decodeBase64(data)));
        //去掉结尾的垃圾字符
        publicMsg = publicMsg.substring(0, publicMsg.length() - Integer.parseInt(num));

        return publicMsg;

    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 11:47
     * @函数介绍: 简单得到公司中文的byte, 简单处理。
     * @参数说明: @param paramname paramintroduce
     * @return: XXType(value introduce)
     **/
    public static String chineseCrpt(String chineseStr) {
        byte[] bytes = chineseStr.getBytes();
        StringBuffer sb = new StringBuffer();
        for (byte aByte : bytes) {
            sb.append(aByte).append(",");
        }
        String s1 = sb.toString();


        return s1;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 11:49
     * @函数介绍: 简单解密中文，中文是公司名加密要求不高。
     * @参数说明: chineseStr
     * @return: 加密后的中文
     **/
    public static String chineseDec(String chineseStr) {
        String[] stringArr = chineseStr.split(",");
        byte[] mybytes = new byte[stringArr.length];
        for (int i = 0; i < stringArr.length; i++) {

            byte b = (byte) Integer.parseInt(stringArr[i]);
            mybytes[i] = b;
        }
        String str = "";
        try{
            str = new String(mybytes,"GBK");
        }catch (Exception e){
            e.printStackTrace();
        }

        return str;
    }

    public static String finalEncry(String chineseStr, String notchineseStr, String macode) {
        String noChinesePwd = null;
        try {
            noChinesePwd = myEncrypt(notchineseStr, MY_KEY);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String chinesePwd = chineseCrpt(chineseStr);

        //16位机器码，中文公司，分隔符，信息加密
        String finalCrptStr = MY_KEY + chinesePwd + "@123456789qwertyuiopasdfghjklzxcvbnm,.-@" + noChinesePwd;

        return finalCrptStr;
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 15:13
     * @函数介绍: 随机产生16位字符
     * @参数说明: @param 无
     * @return: String
     **/
    public static String get16Char() {
        String str = new String("0123456789QWERTYUIOPLKJHGFDSAZXCVBNM");
        Random random = new Random();
        int i = random.nextInt(36);
        char[] chars = str.toCharArray();

        StringBuffer sb = new StringBuffer();
        for (int j = 0; j < 16; j++) {
            sb.append(chars[i]);
        }
        return sb.toString();
    }

    public static String finalDec(String pwd) {
        String[] allPwd = pwd.split("\\@123456789qwertyuiopasdfghjklzxcvbnm,\\.-\\@");
        String chinesePwd = allPwd[0];
        String nochinesePwd = allPwd[1];

        String mykey = pwd.substring(0, 16);
        chinesePwd = chinesePwd.substring(16, chinesePwd.length());
        String chineseMsg = chineseDec(chinesePwd);
        String noChineseMsg = null;

        try {
            noChineseMsg = myDecrypt(nochinesePwd, NEW_KEY2020);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String finalMsgStr = chineseMsg + noChineseMsg;
        return finalMsgStr;
    }

    /**
     * 解密数据
     *
     * @param data 待解密数据
     * @param key  密钥
     * @return 解密后的数据
     *
     */
    public static String decrypt(String data, String key) throws Exception {
        Key deskey = keyGenerator(key);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        //初始化Cipher对象，设置为解密模式
        cipher.init(Cipher.DECRYPT_MODE, deskey);
        // 执行解密操作
        return new String(cipher.doFinal(Base64.decodeBase64(data)));
    }

    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/6/28 11:51
     * @函数介绍: 测试非中文加密
     * @参数说明:
     * @return:
     **/
    public static void main(String[] args) throws Exception {
        String source = "x公司";
       // System.out.println("原文: " + source);
        String key = "A1B2C3D4E5F60708";
        String encryptData = myEncrypt(source, key);
       // System.out.println("加密后: " + encryptData);
        String decryptData = myDecrypt("gaosuboisnumber1120", key);
       // System.out.println("解密后: " + decryptData);
        String[] split = decryptData.split(",");
    }
}