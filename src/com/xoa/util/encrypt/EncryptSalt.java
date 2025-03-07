package com.xoa.util.encrypt;

import java.util.Random;

/**
*@创建作者:     韩成冰
*@创建日期:     2017/6/7 10:39
*@类介绍:        用于获取一个随机字符串，用于Md5Crypt.md5Crypt（）加密使用
*@构造参数:        无
**/
public class EncryptSalt {

    static final String B64T = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";


    static void b64from24bit(byte b2, byte b1, byte b0, int outLen, StringBuilder buffer) {
        int w = b2 << 16 & 16777215 | b1 << 8 & '\uffff' | b0 & 255;

        for(int var6 = outLen; var6-- > 0; w >>= 6) {
            buffer.append("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".charAt(w & 63));
        }

    }

   public static String getRandomSalt(int num) {
        StringBuilder saltString = new StringBuilder();

        for(int i = 1; i <= num; ++i) {
            saltString.append("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".charAt((new Random()).nextInt("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".length())));
        }

        return saltString.toString();
    }

    public static void b64from24bit(int b2, int b1, byte b0, int outLen, StringBuilder passwd) {
    }
}
