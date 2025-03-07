package com.xoa.util.ipUtil;




import com.xoa.util.common.StringUtils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class MachineCode {

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

    public static List<String> get16CharMacs() {
        List<String> list16Macs = new ArrayList<String>();
        String osName = System.getProperty("os.name");
        List<String> macIds=new ArrayList<String>();
        if (osName.toLowerCase().startsWith("win")) {
           String config=  getWindowsMACAddress();
            macIds.add(config);
        }else {
            macIds = getMacIds();
        }
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

            //保证12位
            while (sb.length() < 12) {
                sb.append("A");
            }
            if (sb.length() > 12) {
                sb.substring(0, 12);
            }
            list16Macs.add(sb.toString());

        }

        return list16Macs;
    }
    //机器码返回 保证16
    public static List<String> get16CharMacsType() {
        List<String> list16Macs = new ArrayList<String>();
        String osName = System.getProperty("os.name");
        List<String> macIds=new ArrayList<String>();
        if (osName.toLowerCase().startsWith("win")) {
            String config=  getWindowsMACAddress();
            macIds.add(config);
        }else {
            macIds = getMacIds();
        }
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

            //保证12位

            while (!StringUtils.checkNull(sb.toString())&&sb.length() < 16) {
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


    public static String getWindowsMACAddress() {
        String mac = null;
        BufferedReader bufferedReader = null;
        Process process = null;
        try {
            // windows下的命令，显示信息中包含有mac地址信息
            process = Runtime.getRuntime().exec("ipconfig /all");
            bufferedReader = new BufferedReader(new InputStreamReader(
                    process.getInputStream(),"gbk"));
            String line = null;
            int index = -1;
            while ((line = bufferedReader.readLine()) != null) {

                // 寻找标示字符串[physical
                index = line.toLowerCase().indexOf("physical address");

                if (index >= 0) {// 找到了
                    index = line.indexOf(":");// 寻找":"的位置
                    if (index >= 0) {
                        // 取出mac地址并去除2边空格
                        mac = line.substring(index + 1).trim();
                    }

                }
                index = line.toLowerCase().indexOf("物理地址");
                if (index >= 0) {// 找到了
                    index = line.indexOf(":");// 寻找":"的位置
                    if (index >= 0) {
                        // 取出mac地址并去除2边空格
                        mac = line.substring(index + 1).trim();
                    }
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                if (bufferedReader != null) {
                    bufferedReader.close();
                }
            } catch (IOException e1) {
                e1.printStackTrace();
            }
            bufferedReader = null;
            process = null;
        }

        return mac;
    }

    private static void getLocalMac(InetAddress ia) throws SocketException {
        // TODO Auto-generated method stub
        //获取网卡，获取地址
        byte[] mac = NetworkInterface.getByInetAddress(ia).getHardwareAddress();
        StringBuffer sb = new StringBuffer("");

        for(int i=0; i<mac.length; i++) {
            if(i!=0) {
                sb.append("-");
            }
            //字节转换为整数
            int temp = mac[i]&0xff;
            String str = Integer.toHexString(temp);
            if(str.length()==1) {
                sb.append("0"+str);
            }else {
                sb.append(str);
            }
        }
    }

    public static void main(String[] args) throws UnknownHostException, SocketException {
//      List a=   getMacIds();
    }


}
