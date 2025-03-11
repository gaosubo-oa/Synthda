package com.xoa.util.common;

/**
 * Created by 韩东堂 on 2017/6/27.
 */
public class MobileCheck {
    public static boolean  isMobileDevice(String requestHeader){
        /**
         * android : 所有android设备
         * mac os : iphone ipad
         * windows phone:Nokia等windows系统的手机
         */
        String[] deviceArray = new String[]{"android","windows phone","nokia", "sony", "ericsson", "mot", "samsung", "htc", "sgh", "lg", "sharp", "sie-"
                ,"philips", "panasonic", "alcatel", "lenovo", "iphone", "ipod", "ipad","blackberry", "meizu",
                "android", "netfront", "symbian", "ucweb", "windowsce", "palm", "operamini",
                "operamobi", "opera mobi", "openwave", "nexusone", "cldc", "midp", "wap", "mobile"};
        if(requestHeader == null)
            return false;
        requestHeader = requestHeader.toLowerCase();
        for(int i=0;i<deviceArray.length;i++){
            if(requestHeader.indexOf(deviceArray[i])>0){
                return true;
            }
        }
        return false;
    }
}
