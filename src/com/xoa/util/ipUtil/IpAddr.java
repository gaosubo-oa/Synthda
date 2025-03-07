package com.xoa.util.ipUtil;

import javax.servlet.http.HttpServletRequest;
import java.net.*;
import java.util.Enumeration;

import static com.xoa.util.CusAccessObjectUtil.INTRANET_IP;

/**
 *
 * 创建作者: 张勇 创建日期: 2017-4-28 上午10:35:34 类介绍 : 通过请求获取用户IP地址 构造参数:
 *
 */
public class IpAddr {


    /**
     *
     * @作者 张勇
     * @创建日期 2017-4-28 上午10:35:34
     * @方法介绍 根据用户获取ip地址
     * @参数说明 @param request
     * @参数说明 @return
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        // 多次反向代理后会有多个ip值，第一个ip才是真实ip
        if( ip.indexOf(",")!=-1 ){
            ip = ip.split(",")[0];
        }
        if (ip.equals("0:0:0:0:0:0:0:1")) {
            ip = "127.0.0.1";
        }
        return ip;
    }

    /**
     * @作者 张勇
     * @创建日期 2017-4-28 上午10:35:34
     * @方法介绍 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址;
     * @参数说明 @param request
     * @参数说明 @return
     * @return
     */
    public static String getIpAddress(HttpServletRequest request) {
        // 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址
        String ip =  request.getRemoteAddr();
       /* if (LOG.isInfoEnabled()) {
            LOG.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
        }*/
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
           // if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("Proxy-Client-IP");
              /*  if (LOG.isInfoEnabled()) {
                    LOG.info("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);
                }*/
          //  }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("WL-Proxy-Client-IP");
               /* if (LOG.isInfoEnabled()) {
                    LOG.info("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);
                }*/
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_CLIENT_IP");
                /*if (LOG.isInfoEnabled()) {
                    LOG.info("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);
                }*/
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");
              /*  if (LOG.isInfoEnabled()) {
                    LOG.info("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);
                }*/
            }
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                ip = request.getHeader("X-Forwarded-For");
               /* if (LOG.isInfoEnabled()) {
                    LOG.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
                }*/
            }
        } else if (ip.length() > 15) {
            String[] ips = ip.split(",");
            for (int index = 0; index < ips.length; index++) {
                String strIp = (String) ips[index];
                if (!("unknown".equalsIgnoreCase(strIp))) {
                    ip = strIp;
                    break;
                }
            }
        }
        return ip;
    }


    public static boolean isIps(HttpServletRequest req, String ipd) {
        boolean flag = false;
        String[] Ips = ipd.split(",");
        for (int i = 0; i < Ips.length; i++) {
            String startIp = Ips[i] + ".0.0.0";
            String endIp = Ips[i] + ".255.255.255";
            String ip = IpAddr.getIpAddress(req);
//            String ip = "192.0.0.10";
            if (isValidRange(startIp, endIp, ip)){
                return true;
            }
        }
        return flag;
    }

    //验证IP是否在某段IP内
    public static boolean isValidRange(String ipStart, String ipEnd, String ipToCheck) {
        try {
            long ipLo = ipTolong(InetAddress.getByName(ipStart));
            long ipHi = ipTolong(InetAddress.getByName(ipEnd));
            long ipcheck = ipTolong(InetAddress.getByName(ipToCheck));
            return (ipcheck > ipLo && ipcheck < ipHi);
        } catch (UnknownHostException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static long ipTolong(InetAddress ip) {
        long result = 0;
        byte[] ipAdds = ip.getAddress();
        for (byte b : ipAdds) {
            result <<= 8;
            result |= b & 0xff;
        }
        return result;
    }

    public static InetAddress getCurrentIp() {
        try {
            Enumeration<NetworkInterface> networkInterfaces = NetworkInterface.getNetworkInterfaces();
            while (networkInterfaces.hasMoreElements()) {
                NetworkInterface ni = (NetworkInterface) networkInterfaces.nextElement();
                Enumeration<InetAddress> nias = ni.getInetAddresses();
                while (nias.hasMoreElements()) {
                    InetAddress ia = (InetAddress) nias.nextElement();
                    if (!ia.isLinkLocalAddress() && !ia.isLoopbackAddress() && ia instanceof Inet4Address) {
                        return ia;
                    }
                }
            }
        } catch (SocketException e) {
        }
        return null;
    }


    /**
     * 获得外网IP
     * @return 外网IP
     */
    public static String getInternetIp(){
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


    public static String getV4IP(){
     /*   String ip = "";
        String chinaz = "http://ip.chinaz.com";

        StringBuilder inputLine = new StringBuilder();
        String read = "";
        URL url = null;
        HttpURLConnection urlConnection = null;
        BufferedReader in = null;
        try {
            url = new URL(chinaz);
            urlConnection = (HttpURLConnection) url.openConnection();
            in = new BufferedReader( new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
            while((read=in.readLine())!=null){
                inputLine.append(read+"\r\n");
            }
            //System.out.println(inputLine.toString());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally{
            if(in!=null){
                try {
                    in.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }


        Pattern p = Pattern.compile("\\<dd class\\=\"fz24\">(.*?)\\<\\/dd>");
        Matcher m = p.matcher(inputLine.toString());
        if(m.find()){
            String ipstr = m.group(1);
            ip = ipstr;
            //System.out.println(ipstr);
        }
        return ip;*/


        String localip = null;// 本地IP，如果没有配置外网IP则返回它
        String netip = null;// 外网IP

        Enumeration<NetworkInterface> netInterfaces = null;
        try {
            netInterfaces = NetworkInterface.getNetworkInterfaces();
        } catch (SocketException e) {
            e.printStackTrace();
        }
        InetAddress ip = null;
        boolean finded = false;// 是否找到外网IP
        while (netInterfaces.hasMoreElements() && !finded) {
            NetworkInterface ni = netInterfaces.nextElement();
            Enumeration<InetAddress> address = ni.getInetAddresses();
            while (address.hasMoreElements()) {
                ip = address.nextElement();
                if (!ip.isSiteLocalAddress() && !ip.isLoopbackAddress() && ip.getHostAddress().indexOf(":") == -1) {// 外网IP
                    netip = ip.getHostAddress();
                    finded = true;
                    break;
                } else if (ip.isSiteLocalAddress() && !ip.isLoopbackAddress()
                        && ip.getHostAddress().indexOf(":") == -1) {// 内网IP
                    localip = ip.getHostAddress();
                }
            }
        }

        if (netip != null && !"".equals(netip)) {
            return netip;
        } else {
            return localip;
        }

}
}
