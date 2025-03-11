package com.xoa.util;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;


/**
 * 随机生成英文加数字字符串并且加上日期
 */
public class RandomGenerator {
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    public static String generateRandomString(int length) {
        StringBuilder builder = new StringBuilder();

        while (builder.length() < length) {
            int index = new Random().nextInt(CHARACTERS.length());
            builder.append(CHARACTERS.charAt(index));
        }

        return builder.toString();
    }

    public static String generateUniqueString(int length) {
        String code = "";
            code = generateRandomString(length);
        return code + "-" + generateDateSuffix();
    }


    private static String generateDateSuffix() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        return dateFormat.format(new Date());
    }
}