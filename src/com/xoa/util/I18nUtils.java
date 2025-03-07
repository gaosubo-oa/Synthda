package com.xoa.util;

import java.text.MessageFormat;
import java.util.Locale;
import java.util.ResourceBundle;

public class I18nUtils {

    private static Locale currentLocale;
    private static ResourceBundle resourceBundle;

// 默认语言为系统语言   --- 设置默认语言报错先注释
//    static {
//        setLocale(Locale.getDefault());
//    }

    /**
     * 设置语言环境
     *
     * @param locale 指定的Locale对象（如Locale.ENGLISH，Locale.CHINA等）
     */
    public static void setLocale(String locale) {
        Locale locale1 = null;
            if ("zh_CN".equals(locale)) {
                locale1=Locale.SIMPLIFIED_CHINESE;
            } else if ("en_US".equals(locale)) {
                locale1=Locale.US;
            } else if ("zh_TW".equals(locale)) {
                locale1=Locale.TRADITIONAL_CHINESE;
            }else if("ja_JP".equals(locale)){
                locale1=Locale.JAPAN;
            }else {
                locale1=Locale.US;
            }
        if (currentLocale == null||currentLocale!=locale1||resourceBundle==null) {
            currentLocale = locale1;
            resourceBundle = ResourceBundle.getBundle("config/i18properties/message", currentLocale);
        }
    }

    /**
     * 根据key获取对应语言环境的文本
     *
     * @param key 资源文件中的key
     * @return 对应语言的文本
     */
    public static String getMessage(String key) {
        try {
            return resourceBundle.getString(key);
        } catch (Exception e) {
            return "Key not found: " + key;
        }
    }

    /**
     * 根据key获取对应语言环境的文本并进行格式化
     *
     * @param key    资源文件中的key
     * @param params 替换文本中的占位符的参数
     * @return 格式化后的文本
     */
    public static String getMessage(String key, Object... params) {
        try {
            String message = resourceBundle.getString(key);
            return MessageFormat.format(message, params);
        } catch (Exception e) {
            return "Key not found or formatting error: " + key;
        }
    }

    /**
     * 获取当前的Locale
     *
     * @return 当前语言环境
     */
    public static Locale getCurrentLocale() {
        return currentLocale;
    }
    
    /**
     * 获取当前使用的资源文件
     *
     * @return 当前的ResourceBundle
     */
    public static ResourceBundle getResourceBundle() {
        return resourceBundle;
    }
}
