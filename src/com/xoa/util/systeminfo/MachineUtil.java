package com.xoa.util.systeminfo;

import com.xoa.util.ipUtil.MachineCode;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class MachineUtil {
    //加密密钥，后期可以根据不同的公司，设置不同的秘钥，注意xoa中是这个，要是改变，都要变
    public static final String MY_KEY = "";

    public static void main(String[] args) throws Exception {
        String macId = getMacId();
//        System.out.println(macId);
//        System.out.println("获得服务器的MAC地址:" + getMacId());
//        System.out.println("获得服务器的MAC地址(多网卡):" + getMacIds());
//        System.out.println("处理后的的MAC地址（未加密）：" + get16CharMacs());
//        System.out.println("处理后的的MAC地址（加密）：" + getEncryptMacCode());

    }


    /**
     * 此方法描述的是：获得服务器的MAC地址
     *
     * @author: zhangyang33@sinopharm.com
     * @version: 2014年9月5日 下午1:27:25
     */
    public static String getMacId() {
        String macId = "";
        InetAddress ip = null;
        NetworkInterface ni = null;
        try {
            boolean bFindIP = false;
            Enumeration<NetworkInterface> netInterfaces = (Enumeration<NetworkInterface>) NetworkInterface
                    .getNetworkInterfaces();
            while (netInterfaces.hasMoreElements()) {
                if (bFindIP) {
                    break;
                }
                ni = (NetworkInterface) netInterfaces
                        .nextElement();
                // ----------特定情况，可以考虑用ni.getName判断
                // 遍历所有ip
                Enumeration<InetAddress> ips = ni.getInetAddresses();
                while (ips.hasMoreElements()) {
                    ip = (InetAddress) ips.nextElement();
                    if (!ip.isLoopbackAddress() // 非127.0.0.1
                            && ip.getHostAddress().matches(
                            "(\\d{1,3}\\.){3}\\d{1,3}")) {
                        bFindIP = true;
                        break;
                    }
                }
            }
        } catch (Exception e) {
            //OutUtil.error(IpUtil.class, e.getMessage());
        }
        if (null != ip) {
            try {
                macId = getMacFromBytes(ni.getHardwareAddress());
            } catch (SocketException e) {
                //OutUtil.error(IpUtil.class, e.getMessage());
            }
        }
        return macId;
    }

    /**
     * 此方法描述的是：获得服务器的MAC地址(多网卡)
     *
     * @author: zhangyang33@sinopharm.com
     * @version: 2014年9月5日 下午1:27:25
     */
    public static List<String> getMacIds() {
        InetAddress ip = null;
        NetworkInterface ni = null;
        List<String> macList = new ArrayList<String>();
        try {
            Enumeration<NetworkInterface> netInterfaces = (Enumeration<NetworkInterface>) NetworkInterface
                    .getNetworkInterfaces();
            while (netInterfaces.hasMoreElements()) {
                ni = (NetworkInterface) netInterfaces
                        .nextElement();
                // ----------特定情况，可以考虑用ni.getName判断
                // 遍历所有ip
                Enumeration<InetAddress> ips = ni.getInetAddresses();
                while (ips.hasMoreElements()) {
                    ip = (InetAddress) ips.nextElement();
                    if (!ip.isLoopbackAddress() // 非127.0.0.1
                            && ip.getHostAddress().matches(
                            "(\\d{1,3}\\.){3}\\d{1,3}")) {
                        macList.add(getMacFromBytes(ni.getHardwareAddress()));
                    }
                }
            }
        } catch (Exception e) {
            //OutUtil.error(IpUtil.class, e.getMessage());
        }
        return macList;
    }

    private static String getMacFromBytes(byte[] bytes) {
        StringBuffer mac = new StringBuffer();
        byte currentByte;
        boolean first = false;
        for (byte b : bytes) {
            if (first) {
                mac.append("-");
            }
            currentByte = (byte) ((b & 240) >> 4);
            mac.append(Integer.toHexString(currentByte));
            currentByte = (byte) (b & 15);
            mac.append(Integer.toHexString(currentByte));
            first = true;
        }
        return mac.toString().toUpperCase();
    }

    public static List<String> get16CharMacs() {
        List<String> list16Macs = new ArrayList<String>();

        List<String> macIds = getMacIds();
        for (String macId : macIds) {
            StringBuffer sb = new StringBuffer();
            char[] chars = macId.toCharArray();
            //取大小写字母及数字
            for (char aChar : chars) {
                if ((48 <= aChar && aChar <= 57) ||
                        (65 <= aChar && aChar <= 90) ||
                        (97 <= aChar && aChar <= 122)) {
                    sb.append(aChar);
                }
            }
            //保证16位
            while (sb !=null && !com.xoa.util.common.StringUtils.checkNull(sb.toString()) && sb.length() < 16) {
                String  a1=sb.substring(0,1);
                String  a2=sb.substring(2,3);
                String  a3=sb.substring(4,5);
                String  a4=sb.substring(6,7);
                sb.append(a1);
                sb.append(a2);
                sb.append(a3);
                sb.append(a4);
            }
            if (sb.length() > 16) {
                sb.substring(0, 16);
            }
            list16Macs.add(sb.toString());

        }

        return list16Macs;
    }

    public static List<String> getEncryptMacCode() throws Exception {
        List<String> charMacs = MachineCode.get16CharMacsType();
        List<String> macCodeEncryptList = new ArrayList<String>();
        for (String charMac : charMacs) {
            String encrypt = DESUtils.encrypt(charMac, MY_KEY);

            macCodeEncryptList.add(encrypt);
        }

        return macCodeEncryptList;

    }
}


