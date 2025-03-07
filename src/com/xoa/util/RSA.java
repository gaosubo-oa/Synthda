package com.xoa.util;

import javax.crypto.Cipher;
import java.io.ByteArrayOutputStream;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
 
 
/**
 * RSA非对称加密算法工具类
 *
 * @author lixk
 */
 
public class RSA {
    //非对称密钥算法
    private static final String KEY_ALGORITHM = "RSA";
    //密钥长度，在512到65536位之间，建议不要太长，否则速度很慢，生成的加密数据很长
    private static final int KEY_SIZE = 512;
    //字符编码
    private static final String CHARSET = "UTF-8";
 
    /**
     * 生成密钥对
     *
     * @return KeyPair 密钥对
     */
    public static KeyPair getKeyPair() throws Exception {
        return getKeyPair(null);
    }
 
    /**
     * 生成密钥对
     * @param password 生成密钥对的密码
     * @return
     * @throws Exception
     */
    public static KeyPair getKeyPair(String password) throws Exception {
        //实例化密钥生成器
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(KEY_ALGORITHM);
        //初始化密钥生成器
        if(password == null){
            keyPairGenerator.initialize(KEY_SIZE);
        }else {
            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
            secureRandom.setSeed(password.getBytes(CHARSET));
            keyPairGenerator.initialize(KEY_SIZE, secureRandom);
        }
        //生成密钥对
        return keyPairGenerator.generateKeyPair();
    }
 
    /**
     * 取得私钥
     *
     * @param keyPair 密钥对
     * @return byte[] 私钥
     */
    public static byte[] getPrivateKeyBytes(KeyPair keyPair) {
        return keyPair.getPrivate().getEncoded();
    }
 
    /**
     * 取得Base64编码的私钥
     *
     * @param keyPair 密钥对
     * @return String Base64编码的私钥
     */
    public static String getPrivateKey(KeyPair keyPair) {
        return Base64.getEncoder().encodeToString(getPrivateKeyBytes(keyPair));
    }
 
    /**
     * 取得公钥
     *
     * @param keyPair 密钥对
     * @return byte[] 公钥
     */
    public static byte[] getPublicKeyBytes(KeyPair keyPair) {
        return keyPair.getPublic().getEncoded();
    }
 
    /**
     * 取得Base64编码的公钥
     *
     * @param keyPair 密钥对
     * @return String Base64编码的公钥
     */
    public static String getPublicKey(KeyPair keyPair) {
        return Base64.getEncoder().encodeToString(getPublicKeyBytes(keyPair));
    }
 
    /**
     * 私钥加密
     *
     * @param data       待加密数据
     * @param privateKey 私钥字节数组
     * @return byte[] 加密数据
     */
    public static byte[] encryptByPrivateKey(byte[] data, byte[] privateKey) throws Exception {
        //实例化密钥工厂
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
        //生成私钥
        PrivateKey key = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKey));
        //数据加密
        Cipher cipher = Cipher.getInstance(KEY_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        return cipher.doFinal(data);
    }
 
    /**
     * 私钥加密
     *
     * @param data       待加密数据
     * @param privateKey Base64编码的私钥
     * @return String Base64编码的加密数据
     */
    public static String encryptByPrivateKey(String data, String privateKey) throws Exception {
        byte[] key = Base64.getDecoder().decode(privateKey);
        return Base64.getEncoder().encodeToString(encryptByPrivateKey(data.getBytes(CHARSET), key));
    }
 
    /**
     * 公钥加密
     *
     * @param data      待加密数据
     * @param publicKey 公钥字节数组
     * @return byte[] 加密数据
     */
    public static byte[] encryptByPublicKey(byte[] data, byte[] publicKey) throws Exception {
        //实例化密钥工厂
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
        //生成公钥
        PublicKey key = keyFactory.generatePublic(new X509EncodedKeySpec(publicKey));
        //数据加密
        Cipher cipher = Cipher.getInstance(KEY_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key);
        return cipher.doFinal(data);
    }
 
    /**
     * 公钥加密
     *
     * @param data      待加密数据
     * @param publicKey Base64编码的公钥
     * @return String Base64编码的加密数据
     */
    public static String encryptByPublicKey(String data, String publicKey) throws Exception {
        byte[] key = Base64.getDecoder().decode(publicKey);
        return Base64.getEncoder().encodeToString(encryptByPublicKey(data.getBytes(CHARSET), key));
    }
 
    /**
     * 私钥解密
     *
     * @param data       待解密数据
     * @param privateKey 私钥字节数组
     * @return byte[] 解密数据
     */
    public static byte[] decryptByPrivateKey(byte[] data, byte[] privateKey) throws Exception {
        //实例化密钥工厂
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
        //生成私钥
        PrivateKey key = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(privateKey));
        //数据解密
        Cipher cipher = Cipher.getInstance(KEY_ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, key);
        return cipher.doFinal(data);
    }
 
    /**
     * 私钥解密
     *
     * @param data       Base64编码的待解密数据
     * @param privateKey Base64编码的私钥
     * @return String 解密数据
     */
    public static String decryptByPrivateKey(String data, String privateKey) throws Exception {
        byte[] key = Base64.getDecoder().decode(privateKey);
        return new String(decryptByPrivateKey(Base64.getDecoder().decode(data), key), CHARSET);
    }
 
    /**
     * 公钥解密
     *
     * @param data      待解密数据
     * @param publicKey 公钥字节数组
     * @return byte[] 解密数据
     */
    public static byte[] decryptByPublicKey(byte[] data, byte[] publicKey) throws Exception {
        //实例化密钥工厂
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGORITHM);
        //产生公钥
        PublicKey key = keyFactory.generatePublic(new X509EncodedKeySpec(publicKey));
        //数据解密
        Cipher cipher = Cipher.getInstance(KEY_ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, key);
        return cipher.doFinal(data);
    }
 
    /**
     * 公钥解密
     *
     * @param data      Base64编码的待解密数据
     * @param publicKey Base64编码的公钥
     * @return String 解密数据
     */
    public static String decryptByPublicKey(String data, String publicKey) throws Exception {
        byte[] key = Base64.getDecoder().decode(publicKey);
        return new String(decryptByPublicKey(Base64.getDecoder().decode(data), key), CHARSET);
    }





    ///// pc客户端加密解密方法


    private static char[] base64EncodeChars = new char[] { 'A', 'B', 'C', 'D',
            'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q',
            'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
            'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
            'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3',
            '4', '5', '6', '7', '8', '9', '+', '/', };

    private static byte[] base64DecodeChars = new byte[] { -1, -1, -1, -1, -1,
            -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
            -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
            -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59,
            60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
            10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1,
            -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
            38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1,
            -1, -1 };

    /**
     * 解密
     * @param str
     * @return
     */
    public static byte[] pcDecode(String str) {
        byte[] data = str.getBytes();
        int len = data.length;
        ByteArrayOutputStream buf = new ByteArrayOutputStream(len);
        int i = 0;
        int b1, b2, b3, b4;

        while (i < len) {
            do {
                b1 = base64DecodeChars[data[i++]];
            } while (i < len && b1 == -1);
            if (b1 == -1) {
                break;
            }

            do {
                b2 = base64DecodeChars[data[i++]];
            } while (i < len && b2 == -1);
            if (b2 == -1) {
                break;
            }
            buf.write((int) ((b1 << 2) | ((b2 & 0x30) >>> 4)));

            do {
                b3 = data[i++];
                if (b3 == 61) {
                    return buf.toByteArray();
                }
                b3 = base64DecodeChars[b3];
            } while (i < len && b3 == -1);
            if (b3 == -1) {
                break;
            }
            buf.write((int) (((b2 & 0x0f) << 4) | ((b3 & 0x3c) >>> 2)));

            do {
                b4 = data[i++];
                if (b4 == 61) {
                    return buf.toByteArray();
                }
                b4 = base64DecodeChars[b4];
            } while (i < len && b4 == -1);
            if (b4 == -1) {
                break;
            }
            buf.write((int) (((b3 & 0x03) << 6) | b4));
        }
        return buf.toByteArray();
    }



    //// pc客户端加密解密方法 结束标签
 
    /**
     * 测试加解密方法
     *
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        //生成密钥对，一般生成之后可以放到配置文件中
        KeyPair keyPair = RSA.getKeyPair();
        //公钥
        String publicKey = RSA.getPublicKey(keyPair);
        //私钥
        String privateKey = RSA.getPrivateKey(keyPair);
 
        System.out.println("公钥：\n" + publicKey);
        System.out.println("私钥：\n" + privateKey);
 
        String data = "RSA 加解密测试!";
        {
            System.out.println("\n===========私钥加密，公钥解密==============");
            String s1 = RSA.encryptByPrivateKey(data, privateKey);
            System.out.println("加密后的数据:" + s1);
            String s2 = RSA.decryptByPublicKey(s1, publicKey);
            System.out.println("解密后的数据:" + s2 + "\n\n");
        }
 
        {
            System.out.println("\n===========公钥加密，私钥解密==============");
            String s1 = RSA.encryptByPublicKey(data, publicKey);
            System.out.println("加密后的数据:" + s1);
            String s2 = RSA.decryptByPrivateKey(s1, privateKey);
            System.out.println("解密后的数据:" + s2 + "\n\n");
        }
 
    }
}
