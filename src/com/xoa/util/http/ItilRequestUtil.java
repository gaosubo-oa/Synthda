package com.xoa.util.http;

import com.xoa.util.JsonToProptyOrMapAndList;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpParams;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/28 19:11
 * 类介绍  :   客户端Client工具类
 * 构造参数:
 */
public class ItilRequestUtil {

    public ItilRequestUtil(){
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/28 20:00
     * 方法介绍:   POST调用Client接口公共类
     * 参数说明:  userToString  json格式的请求参数
     * 参数说明:  apiUrl api接口地址
     * @return
     */
    public static String httpRequestPost(String userToString, String apiUrl)throws Exception{
        HttpClient httpClient = new DefaultHttpClient();
        //设置连接等待超时
        int SO_TIMEOUT = 60*1000;
        HttpParams params = new BasicHttpParams();
        params.setIntParameter(CoreConnectionPNames.SO_TIMEOUT,SO_TIMEOUT);
        HttpPost httpPost = new  HttpPost(apiUrl);
        StringEntity stringEntity = new StringEntity(userToString, Charset.forName("UTF-8"));
        httpPost.setHeader("Content-Type", "application/json");
        httpPost.setHeader("accept","application/json");
        httpPost.setEntity(stringEntity);
        HttpResponse response = httpClient.execute(httpPost);
        HttpEntity entity = response.getEntity();
        Integer stats = response.getStatusLine().getStatusCode();
        StringBuffer sb = new StringBuffer();
        if(stats == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent(), "utf-8"));//防止乱码
            String buffer = "";
            while ((buffer = reader.readLine()) != null) {
                sb.append(buffer);
            }
            reader.close();
            httpPost.releaseConnection();
            httpClient.getConnectionManager().shutdown();
            String nmae = sb.toString();
        }else{
            sb.append("{\"flag\":false,\"msg\":\""+stats+"\",\"obj\":[]}");
        }
        return sb.toString();
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/28 20:14
     * 方法介绍:   GET调用Client接口公共类
     * 参数说明:   json字符串格式的返回结果 其中ReturnCode为true表示请求成功
     * @return
     */
    public static String httpRequestGet(HashMap<String, Object> content, String apiUrl)throws Exception{
        HttpClient httpClient = new DefaultHttpClient();
        //设置连接等待超时
        int SO_TIMEOUT = 60*1000;
        HttpParams params = new BasicHttpParams();
        params.setIntParameter(CoreConnectionPNames.SO_TIMEOUT,SO_TIMEOUT);
        HttpGet httpGet = new HttpGet(apiUrl);
        httpGet.setHeader("Content-Type", "application/json");
        httpGet.setHeader("accept","application/json");
        HttpResponse response = httpClient.execute( httpGet);
        HttpEntity entity = response.getEntity();
        Integer stats = response.getStatusLine().getStatusCode();
        StringBuffer sb = new StringBuffer();
        //判断状态码
        if (stats == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent()));
            String buffer = "";
            while ((buffer = reader.readLine()) != null) {
                sb.append(buffer);
            }
            reader.close();
            httpGet.releaseConnection();
            httpClient.getConnectionManager().shutdown();
        }else{
            sb.append("{\"flag\":false,\"msg\":\""+stats+"\",\"obj\":[]}");
        }
        return sb.toString();
    }


    public static void main(String[] args) throws Exception {

        String url="http://127.0.0.1:8090/webService/webServiceTigger";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String userToString = "{\"format\":\"0\",\"fromId\":\"admin\",\"sendTime\":\""+sdf.format(new Date())+"\",\"subject\":\"法律咨询 2017-06-28 15:57:21\",\"content\":\"测试接口是否可行\",\"toId2\":\"\",\"flowId\":\"96\",\"flowPrcs\":\"1\"}";
        String obj =  ItilRequestUtil.httpRequestPost(userToString, url);
        Map<String,Object> map = JsonToProptyOrMapAndList.returnMaps(obj);
    }
}
