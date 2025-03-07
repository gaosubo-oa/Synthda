package com.xoa.util;

public class Utility {

    /**
     * 处理\ " '
     *
     * @param srcStr
     * @return
     * @throws Exception
     */
    public static String encodeSpecialJson(String srcStr) {
        if (srcStr == null) {
            return "";
        }
        return srcStr.replace("\r\n", "").replace("\n", "").replace("\r", "");
    }

}
