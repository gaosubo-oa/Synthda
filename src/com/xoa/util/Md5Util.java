package com.xoa.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @author 左春晖
 * @date 2018/9/7 15:37
 * @desc
 */
public class Md5Util {
    private static char[] hexDigits = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

    public Md5Util() {
    }

    public static String getMd5String(byte[] data) {
        byte[] digest = getMd5ByteArray(data);
        int j = digest.length;
        char[] str = new char[j * 2];
        int k = 0;

        for(int i = 0; i < j; ++i) {
            byte byte0 = digest[i];
            str[k++] = hexDigits[byte0 >>> 4 & 15];
            str[k++] = hexDigits[byte0 & 15];
        }

        return new String(str);
    }

    public static String getMd5String(String str) {
        return getMd5String(str.getBytes());
    }

    public static byte[] getMd5ByteArray(byte[] data) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            return md5.digest(data);
        } catch (NoSuchAlgorithmException var2) {
            var2.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        System.out.println(getMd5String("12345620150430125900".getBytes()));
    }

}
