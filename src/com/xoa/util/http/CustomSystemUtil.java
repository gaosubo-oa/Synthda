package com.xoa.util.http;

import javax.servlet.ServletRequest;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

/**
 * @author 左春晖  获取外网  内网  IP地址
 * @date 2018/7/20 14:37
 * @desc
 */
public class CustomSystemUtil {
    public static String INTRANET_IP = getIntranetIp(); // 内网IP
    public static String INTERNET_IP = getInternetIp(); // 外网IP
    private static ServletRequest request;

    private CustomSystemUtil(){}

//    public static void main(String[] args) throws Exception {
//        System.out.println("本机的外网IP是："+CustomSystemUtil.getInternetIp());
//        System.out.println("本机的内网IP是："+CustomSystemUtil.getIntranetIp());
//        HttpServletRequest httpRequest=(HttpServletRequest)request;
//        String strBackUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + httpRequest.getContextPath()
//                + httpRequest.getServletPath() + "?" + (httpRequest.getQueryString());
//        System.out.println("strBackUrl: " + strBackUrl);
//    }
    /**
     * 获得内网IP
     * @return 内网IP
     */
    private static String getIntranetIp(){
        try{
            return InetAddress.getLocalHost().getHostAddress();
        } catch(Exception e){
            throw new RuntimeException(e);
        }
    }

    /**
     * 获得外网IP
     * @return 外网IP
     */
    private static String getInternetIp(){
        try{
            Enumeration<NetworkInterface> networks = NetworkInterface.getNetworkInterfaces();
            InetAddress ip = null;
            Enumeration<InetAddress> addrs;
            while (networks.hasMoreElements())
            {
                addrs = networks.nextElement().getInetAddresses();
                while (addrs.hasMoreElements())
                {
                    ip = addrs.nextElement();
                    if (ip != null
                            && ip instanceof Inet4Address
                            && ip.isSiteLocalAddress()
                            && !ip.getHostAddress().equals(INTRANET_IP))
                    {
                        return ip.getHostAddress();
                    }
                }
            }
            // 如果没有外网IP，就返回内网IP
            return INTRANET_IP;
        } catch(Exception e){
            throw new RuntimeException(e);
        }
    }
}
