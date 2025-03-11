package com.xoa.util.http;

import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.*;
import java.util.Map.Entry;


/*
 * 利用HttpClient进行post请求的工具类 
 */
public class HttpClientUtil {

    public static String doPost(String url, Map<String, String> map, String charset) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            httpPost.setConfig(RequestConfig.custom().setConnectTimeout(180000).build());// 设置超时时间为3分钟
            L.w("url is", url, "and param is ", map);
            //设置参数  
            JSONObject jsonObject = new JSONObject();
            Iterator iterator = map.entrySet().iterator();
            while (iterator.hasNext()) {
                Entry<String, String> elem = (Entry<String, String>) iterator.next();
                jsonObject.put(elem.getKey(), elem.getValue());
            }
            if (!StringUtils.checkNull(jsonObject.toString())) {
                StringEntity stringEntity = new StringEntity(jsonObject.toString(),"utf-8");
                stringEntity.setContentType("application/json");
                stringEntity.setContentEncoding("utf-8");
                httpPost.setEntity(stringEntity);
            }
            httpPost.addHeader("Content-type","application/json; charset=utf-8");
            httpPost.setHeader("Accept", "application/json");
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, charset);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            L.w("response exception", ex);
        }
        return result;
    }

    public static String doPostWithJSONObject(String url, JSONObject jsonObject, String charset) {
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            if (!StringUtils.checkNull(jsonObject.toString())) {
                StringEntity stringEntity = new StringEntity(jsonObject.toString(),"utf-8");
                stringEntity.setContentType("application/json");
                stringEntity.setContentEncoding("utf-8");
                httpPost.setEntity(stringEntity);
            }
            httpPost.addHeader("Content-type","application/json; charset=utf-8");
            httpPost.setHeader("Accept", "application/json");
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, charset);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            L.w("response exception", ex);
        }
        return result;
    }


    public static JSONObject httpGet(String url) {
        //get请求返回结果
        JSONObject jsonResult = null;
        try {
            DefaultHttpClient client = new DefaultHttpClient();
            //发送get请求
            HttpGet request = new HttpGet(url);
            HttpResponse response = client.execute(request);

            /**请求发送成功，并得到响应**/
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(response.getEntity());
                /**把json字符串转换成json对象**/
                jsonResult = JSONObject.fromObject(strResult);
                url = URLDecoder.decode(url, "UTF-8");
            } else {
                L.w("get请求提交失败:" + url);
            }
        } catch (IOException e) {
            L.w("get请求提交失败:" + url);
        }
        return jsonResult;
    }

    public static JSONObject httpGetWithHeads(String url,Map<String,String> headsMap) {
        //get请求返回结果
        JSONObject jsonResult = null;
        try {
            DefaultHttpClient client = new DefaultHttpClient();
            //发送get请求
            HttpGet httpGet = new HttpGet(url);
            for (String key:headsMap.keySet()) {
                httpGet.addHeader(key,headsMap.get(key));
            }
            HttpResponse response = client.execute(httpGet);

            /**请求发送成功，并得到响应**/
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(response.getEntity());
                /**把json字符串转换成json对象**/
                jsonResult = JSONObject.fromObject(strResult);
                url = URLDecoder.decode(url, "UTF-8");
            } else {
                L.w("get请求提交失败:" + url);
            }
        } catch (IOException e) {
            L.w("get请求提交失败:" + url);
        }
        return jsonResult;
    }

    public static JSONObject httpPostWithHeads(String url,Map<String,String> headsMap,Map<String,String> param) {
        //get请求返回结果
        JSONObject jsonResult = null;
        try {
            DefaultHttpClient client = new DefaultHttpClient();
            //发送get请求
            HttpPost httpPost = new HttpPost(url);
            for (String key:headsMap.keySet()) {
                httpPost.addHeader(key,headsMap.get(key));
            }

            //设置参数
            JSONObject jsonObject = new JSONObject();
            Iterator iterator = param.entrySet().iterator();
            while (iterator.hasNext()) {
                Entry<String, String> elem = (Entry<String, String>) iterator.next();
                jsonObject.put(elem.getKey(), elem.getValue());
            }
            if (!StringUtils.checkNull(jsonObject.toString())) {
                StringEntity stringEntity = new StringEntity(jsonObject.toString(),"utf-8");
                stringEntity.setContentType("application/json");
                stringEntity.setContentEncoding("utf-8");
                httpPost.setEntity(stringEntity);
            }

            HttpResponse response = client.execute(httpPost);

            /**请求发送成功，并得到响应**/
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                /**读取服务器返回过来的json字符串数据**/
                String strResult = EntityUtils.toString(response.getEntity());
                /**把json字符串转换成json对象**/
                jsonResult = JSONObject.fromObject(strResult);
                url = URLDecoder.decode(url, "UTF-8");
            } else {
                L.w("get请求提交失败:" + url);
            }
        } catch (IOException e) {
            L.w("get请求提交失败:" + url);
        }
        return jsonResult;
    }

    /**
     * @作者 廉立深
     * @时间 2020-07-31
     * @方法介绍  发送post请求 按照key - value形式    net.sf.json.JSONObject包冲突了   所以复制一份改为用Gson包
     */
    public static String doGsonPost(String url, Map<String, String> map, String charset) {
        if(StringUtils.checkNull(url)){
            return "";
        }
        HttpClient httpClient = null;
        HttpPost httpPost = null;
        String result = null;
        try {
            httpClient = new SSLClient();
            httpPost = new HttpPost(url);
            L.w("url is", url, "and param is ", map);

            //设置参数
            List<BasicNameValuePair> params = new ArrayList<BasicNameValuePair>();
            Iterator iterator = map.entrySet().iterator();
            while (iterator.hasNext()) {
                Entry<String, String> elem = (Entry<String, String>) iterator.next();
                params.add(new BasicNameValuePair(elem.getKey(), elem.getValue()));
            }

            if (!params.isEmpty()) {
                UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(params,"UTF-8");
                formEntity.setContentType("application/x-www-form-urlencoded");
                formEntity.setContentEncoding("utf-8");
                httpPost.setEntity(formEntity);
            }
            httpPost.addHeader("Content-type","application/x-www-form-urlencoded; charset=utf-8");
            httpPost.setHeader("Accept", "application/json");
            HttpResponse response = httpClient.execute(httpPost);
            if (response != null) {
                HttpEntity resEntity = response.getEntity();
                if (resEntity != null) {
                    result = EntityUtils.toString(resEntity, charset);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            L.w("response exception", ex);
        }
        return result;
    }


    /**
     * 从网络Url中下载文件
     *
     * @param urlStr
     * @param fileName
     * @param savePath
     * @throws IOException
     */
    public static File downLoadFromUrl(String urlStr, String fileName, String savePath) {
        File file = null;
        try {
            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            //设置超时间为3秒
            conn.setConnectTimeout(3 * 1000);
            //防止屏蔽程序抓取而返回403错误
            conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

            //得到输入流
            InputStream inputStream = conn.getInputStream();
            //获取自己数组
            byte[] getData = readInputStream(inputStream);

            //文件保存位置
            File saveDir = new File(savePath);
            if (!saveDir.exists()) {
                saveDir.mkdirs();
            }
            if(StringUtils.checkNull(fileName)){
                file = saveDir;
            } else {
                file = new File(saveDir + File.separator + fileName);
            }
            FileOutputStream fos = new FileOutputStream(file);
            fos.write(getData);
            if (fos != null) {
                fos.flush();
                fos.close();
            }
            if (inputStream != null) {
                inputStream.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return file;
    }

    public static JSONObject uploadFile(Map<String,String> paraMap) throws Exception {

        HttpClient httpClient = HttpClientBuilder.create().build();
        MultipartEntityBuilder meb = MultipartEntityBuilder.create();
        HttpPost httpPost = new HttpPost("");

        ContentType strContent = ContentType.create("application/zip", Charset.forName("UTF-8"));

        Set<String> strings = paraMap.keySet();
        strings.forEach((String key)->{
            if("url".equals(key)){
                httpPost.setURI(URI.create(paraMap.get(key)));// 请求地址
            } else if("filePath".equals(key)){
                meb.addBinaryBody("file", new File(paraMap.get(key)));// 文件路径
            } else {
                meb.addTextBody(key, paraMap.get(key), strContent);// 其他参数
            }
        });


        HttpEntity httpEntity = meb.build();
        httpPost.setEntity(httpEntity);

        try {
            StringBuilder sb = new StringBuilder();
            String line;
            HttpResponse httpResponse = httpClient.execute(httpPost);
            InputStream inputStream = httpResponse.getEntity().getContent();
            BufferedReader br = new BufferedReader(new InputStreamReader(inputStream,"UTF-8"));
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            return JSONObject.fromObject(sb.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 从输入流中获取字节数组
     *
     * @param inputStream
     * @return
     * @throws IOException
     */
    public static byte[] readInputStream(InputStream inputStream) throws IOException {
        byte[] buffer = new byte[1024];
        int len = 0;
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        while ((len = inputStream.read(buffer)) != -1) {
            bos.write(buffer, 0, len);
        }
        bos.close();
        return bos.toByteArray();
    }

} 
