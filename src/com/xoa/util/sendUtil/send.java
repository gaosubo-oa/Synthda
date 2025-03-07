package com.xoa.util.sendUtil;


import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.service.smsDelivery.Sms2PrivService;
import com.xoa.util.common.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.UUID;

@Component
public class send {

    @Autowired
    private Sms2PrivService sms2PrivService;

    private static send send;

    public void setSms2PrivService(Sms2PrivService sms2PrivService) {
        this.sms2PrivService = sms2PrivService;
    }

    @PostConstruct
    public void init() {
        send = this;
        send.sms2PrivService = this.sms2PrivService;

    }


    /**
     * 发送短信
     *
     * @param username	    用户名
     * @param pwd			密码
     * @param mobileString	电话号码字符串，中间用英文逗号间隔
     * @param contextString	内容字符串
     * @param sign			签名
     * @param time_content  追加发送时间，可为空，为空为及时发送
     * @param extend_2		扩展码，必须为数字 可为空
     * @return
     * @throws Exception
     */
    public static String doPost(StringBuffer mobileString, StringBuffer contextString,String protocol, String host,String port,
                                String username,String pwd,String content_field,
                                String code,String mobile,String time_content,String sign, String signValue, String signPosition,
                                String extend_1,String extend_2,String extend_3,String extend_4,String extend_5,String startTime
                                ) throws Exception {
        StringBuffer param = new StringBuffer();
        //protocol+"://"+host+"/"+port+"?"
        param.append(protocol).append("://").append(host).append("/").append(port).append("?");
        param.append(username);
        param.append("&").append(pwd);
        param.append("&").append(mobile).append("=").append(mobileString);


        String sendContext = null;
        String sendSignValue = null;
        // 转码
        if ("0".equals(extend_5)) {
            sendContext = contextString.toString();
            sendSignValue = signValue;
        } else if ("1".equals(extend_5)) {
            if ("0".equals(code)) {
                sendContext = URLEncoder.encode(contextString.toString(), "GBK");
                sendSignValue = URLEncoder.encode(signValue.toString(), "GBK");
            } else if ("1".equals(code)) {
                sendContext = URLEncoder.encode(contextString.toString(), "UTF-8");
                sendSignValue = URLEncoder.encode(signValue, "UTF-8");
            }
        }

        // 发送内容与签名的拼接
        String signName = null;
        if (!"sign=".equals(sign)){
            signName = sign.split("=")[0];
        }

        if (StringUtils.checkNull(signName)) {
            // 没签名参数名的，可以在内容中的开头添加 或者 结尾添加
            if ("1".equals(signPosition)) {
                param.append("&").append(content_field).append("=").append(sendSignValue).append(sendContext);
            } else if ("2".equals(signPosition)) {
                param.append("&").append(content_field).append("=").append(sendContext).append(sendSignValue);
            }
        } else {
            // 有签名参数名的 不在内容中添加
            param.append("&").append(signName).append("=").append(sendSignValue);
            param.append("&").append(content_field).append("=").append(sendContext);
        }

//        if("1".equals(code)){
//            code="utf-8";
//        }else if("0".equals(code)){
//            code="GBK";
//        }

        if(startTime == null){
            startTime="";
        }

        if(!StringUtils.checkNull(time_content)){
            param.append("&").append(time_content).append("="+startTime);
        }

        if(!StringUtils.checkNull(extend_1)){
            param.append("&").append(extend_1);
        }
        if(!StringUtils.checkNull(extend_2)){
            param.append("&").append(extend_2);
        }
        if(!StringUtils.checkNull(extend_3)){
            param.append("&").append(extend_3);
        }
        if(!StringUtils.checkNull(extend_4)){
            param.append("&").append(extend_4);
        }

        HttpURLConnection httpconn = null;
        String resultBuffer = "";
        try {
            URL localURL = new URL(param.toString());
            //在你发起Http请求之前设置一下属性
//        InetSocketAddress addr = new InetSocketAddress("127.0.0.1",8888);
//        Proxy proxy = new Proxy(Proxy.Type.HTTP, addr); // http 代理
            httpconn = (HttpURLConnection) localURL.openConnection();
            /*URLConnection connection = localURL.openConnection();
            httpconn = (HttpURLConnection)connection;*/
            BufferedReader rd = new BufferedReader(new InputStreamReader(httpconn.getInputStream()));
            resultBuffer = rd.readLine();
            rd.close();
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            if(httpconn!=null){
                httpconn.disconnect();
                httpconn=null;
            }

        }
        return resultBuffer.toString();



        /*httpURLConnection.setDoOutput(true);
        httpURLConnection.setDoInput(true);
        httpURLConnection.setRequestMethod("POST");
        httpURLConnection.setRequestProperty("Accept-Charset",code);
        httpURLConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        httpURLConnection.setRequestProperty("Content-Length", String.valueOf(param.length()));

        OutputStream outputStream = null;
        OutputStreamWriter outputStreamWriter = null;
        InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader reader = null;
        String resultBuffer = "";

        try {
            *//*URL url = new URL(param.toString());
            httpURLConnection = (HttpURLConnection) url.openConnection();*//*
            BufferedReader rd = new BufferedReader(new InputStreamReader(httpURLConnection.getInputStream()));
            resultBuffer = rd.readLine();
            rd.close();
        } catch (MalformedURLException e) {
// TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
// TODO Auto-generated catch block
            e.printStackTrace();
        } finally{
            if(httpURLConnection!=null){
                httpURLConnection.disconnect();
                httpURLConnection=null;
            }

        }
        return resultBuffer.toString();*/
    }


    /**
     * 转换返回值类型为UTF-8格式.
     * @param is
     * @return
     */
    public static String convertStreamToString(InputStream is) {
        StringBuilder sb1 = new StringBuilder();
        byte[] bytes = new byte[4096];
        int size = 0;

        try {
            while ((size = is.read(bytes)) > 0) {
                String str = new String(bytes, 0, size, "UTF-8");
                sb1.append(str);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb1.toString();
    }


    /**
     *李阳
     * 2018.10.15
     * 恩施 短信
     * @param Phone   接短信手机号
     * @param ecpId  发短信手机号
     * @param message 短信内容
     * @param byName  验证发信人是否有发送权限
     * @param overName 验证收信人是否有收的权限
     * @throws ClientProtocolException
     * @throws IOException
     */
    private static RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(5000).setConnectTimeout(3000).build();


    public static void sms(String Phone, String ecpId, String message, String byName, String overName, SmsSettings smsSettings) throws ClientProtocolException,
            IOException {

        String accountSid = ""; // 开发者账号 accountSid，需要替换为开发者真正的值
        String token = ""; // 开发者账号的token，需要替换为开发者真正的值
        String appId = ""; //应用appId，需要替换为开发者真正的值


        String str=send.sms2PrivService.checked(byName,overName);
        if(str.equals("没有发送权限")){
            return;
        }
        if(str.equals("没有被提醒权限")){
            return;
        }
        /**
         * accountSid token appId
         * 切勿修改
        */
        //String accountSid = "5a754f1e-a824-4bbe-9db1-e53924cdeb4f"; // 开发者账号 accountSid，需要替换为开发者真正的值
        //String token = "354d67c9-ceec-4858-94ed-84868b814b83"; // 开发者账号的token，需要替换为开发者真正的值
        //String appId = "38508485-0183-4fda-9410-e2dc9edce599"; //应用appId，需要替换为开发者真正的值

        accountSid = smsSettings.getUsername();
        token = smsSettings.getPwd();
        appId = smsSettings.getContentField();

        CloseableHttpClient client = SSLClientUtils.createSSLInsecureClient();

        String url = smsSettings.getProtocol()+"://"+smsSettings.getHost()+ smsSettings.getPort()+accountSid+ smsSettings.getExtend1();  //短信接口


        RequestBuilder requestBuilder = RequestBuilder.post().setUri(url);
        requestBuilder.setConfig(requestConfig);
        long ts = System.currentTimeMillis();
        requestBuilder.addHeader("ts", ts + "");
        requestBuilder.addHeader("apiId", UUID.randomUUID().toString());
        requestBuilder.addHeader("accountSid", accountSid);
        requestBuilder.addHeader("sign",
                EncryptUtils.md5(accountSid + token + ts));

        requestBuilder.addParameter("ecpId", ecpId);  // 发起者手机
        requestBuilder.addParameter("destinationPhone", Phone); // 接受者手机
        requestBuilder.addParameter("appId", appId);
        requestBuilder.addParameter("message", message); //短信内容
        requestBuilder.setEntity(new StringEntity("","UTF-8"));
        HttpUriRequest req = requestBuilder.build();

        CloseableHttpResponse resp = client.execute(req);
        int statusCode = resp.getStatusLine().getStatusCode();
        if (statusCode != 200) {
            throw new RuntimeException("HTTP响应错误，statusCode:" + statusCode);
        }
        HttpEntity entity = resp.getEntity();
        if (entity != null) {
            String result = EntityUtils.toString(entity, "utf-8");
        }
        EntityUtils.consume(entity);
    }


}

