package com.xoa.util;

import com.alibaba.fastjson.JSON;
import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.util.systeminfo.Base64;
import net.sf.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class YunMasUtile {


    public static String LoginGo(String  mobiles, String content, SmsSettings smsSettings) throws Exception {
        //姝ｅ紡URL
        String Url = smsSettings.getProtocol() + "://" + smsSettings.getHost() + smsSettings.getPort();
        String Sent_Result = "";
        String success = "";
        String msgGroup = "";
        String rspcod = "";

        Sent_Result = YunMasUtile.SentSms(Url, GetSmsParam(mobiles,content,smsSettings));
        //System.out.println("发送结果" + Sent_Result);
        return Sent_Result;
    }

    // SmsParam
    public static String GetSmsParam(String  mobiles,String content, SmsSettings smsSettings) throws Exception {
//
        Submit submit = new Submit();
        submit.setEcName(smsSettings.getExtend1());
        submit.setApId(smsSettings.getUsername());
        submit.setSecretKey(smsSettings.getPwd());
        submit.setMobiles(mobiles);
        submit.setSign(smsSettings.getSignValue());
        submit.setContent(content);
        submit.setAddSerial("");
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.append(submit.getEcName());
        stringBuffer.append(submit.getApId());
        stringBuffer.append(submit.getSecretKey());
        stringBuffer.append(submit.getMobiles());
        stringBuffer.append(submit.getContent());
        stringBuffer.append(submit.getSign());
        stringBuffer.append(submit.getAddSerial());


        String selfMac = encryptToMD5(stringBuffer.toString());
//		System.out.println("selfMac:"+selfMac);
        submit.setMAC(selfMac);
        String param = JSON.toJSONString(submit);
       // System.out.println("param:"+param);

        //Base64鍔犲瘑
        String encode = Base64.encodeBase64String(param.getBytes("UTF-8"));
//		String  encode=java.util.Base64.getEncoder().encodeToString(param.getBytes(StandardCharsets.UTF_8));

       // System.out.println("base64加密后encode:"+encode);

        return encode;
    }



    // sentSms
    public static String SentSms(String Url, String Param) {
        String s_SentSms = sendPost(Url, Param);

        //System.out.println("发送"+s_SentSms);
        return s_SentSms;

    }

    // 发送
    public static String sendPost(String url, String param) {
//		PrintWriter out = null;
        OutputStreamWriter out = null;

        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            URLConnection conn = realUrl.openConnection();
            conn.setRequestProperty("accept", "*/*");
            conn.setRequestProperty("contentType","utf-8");
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)");
            conn.setDoOutput(true);
            conn.setDoInput(true);

//			out = new PrintWriter(conn.getOutputStream());
//			out.print(param);
//			out.flush();

            out = new OutputStreamWriter(conn.getOutputStream());
            out.write(param);
            out.flush();


            in = new BufferedReader(
                    new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                result += "\n" + line;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    // MD5加密
    public static String encryptToMD5(String password) {
        byte[] digesta = null;
        String result = null;
        try {


            MessageDigest mdi = MessageDigest.getInstance("MD5");

            mdi.update(password.getBytes("utf-8"));

            digesta = mdi.digest();
//			System.out.println("md5"+digesta);
            result = byteToHex(digesta);
        } catch (NoSuchAlgorithmException e) {

        } catch (UnsupportedEncodingException e) {

            e.printStackTrace();
        }
        return result;
    }

    public static String byteToHex(byte[] pwd) {
        StringBuilder hs = new StringBuilder("");
        String temp = "";
        for (int i = 0; i < pwd.length; i++) {
            temp = Integer.toHexString(pwd[i] & 0XFF);
            if (temp.length() == 1) {
                hs.append("0").append(temp);
            } else {
                hs.append(temp);
            }
        }
        return hs.toString().toLowerCase();
    }

    public static String jsonToBean(String data, String tittle) {
        // System.out.println("data:"+data);
        // System.out.println("tittle:"+tittle);
        try {
            JSONObject json = JSONObject.fromObject(data);
            String result = json.getString(tittle);
            return result;
        } catch (Exception e) {
            return "Json解析失败";
        }
    }
}

class Submit{
    String ecName;
    String apId;
    String secretKey;
    String mobiles;
    String content;
    String sign;
    String addSerial;
    String MAC;
    public String getEcName() {
        return ecName;
    }
    public void setEcName(String ecName) {
        this.ecName = ecName;
    }
    public String getApId() {
        return apId;
    }
    public void setApId(String apId) {
        this.apId = apId;
    }
    public String getSecretKey() {
        return secretKey;
    }
    public void setSecretKey(String secretKey) {
        this.secretKey = secretKey;
    }
    public String getMobiles() {
        return mobiles;
    }
    public void setMobiles(String mobiles) {
        this.mobiles = mobiles;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getSign() {
        return sign;
    }
    public void setSign(String sign) {
        this.sign = sign;
    }
    public String getAddSerial() {
        return addSerial;
    }
    public void setAddSerial(String addSerial) {
        this.addSerial = addSerial;
    }
    public String getMAC() {
        return MAC;
    }
    public void setMAC(String mAC) {
        MAC = mAC;
    }

}
