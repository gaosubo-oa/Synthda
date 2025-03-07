package com.xoa.util.channel.httpclient;

import com.xoa.util.common.L;
import org.apache.commons.httpclient.*;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;

import java.io.*;

public class HttpClientUtil {

    private static HttpClient client = null;

    // 构造单例
    private HttpClientUtil() {

	MultiThreadedHttpConnectionManager httpConnectionManager = new MultiThreadedHttpConnectionManager();
	HttpConnectionManagerParams params = new HttpConnectionManagerParams();
	// 默认连接超时时间
	params.setConnectionTimeout(5000);
	// 默认读取超时时间
	params.setSoTimeout(10000);
	// 默认单个host最大连接数
	params.setDefaultMaxConnectionsPerHost(100);// very important!!
	// 最大总连接数
	params.setMaxTotalConnections(256);// very important!!
	httpConnectionManager.setParams(params);

	client = new HttpClient(httpConnectionManager);

	client.getParams().setConnectionManagerTimeout(3000);
	// client.getParams().setIntParameter("http.socket.timeout", 10000);
	// client.getParams().setIntParameter("http.connection.timeout", 5000);
    }

    private static class ClientUtilInstance {
	private static final HttpClientUtil ClientUtil = new HttpClientUtil();
    }

    public static HttpClientUtil getInstance() {
	return ClientUtilInstance.ClientUtil;
    }

    /**
     * 发送http GET请求，并返回http响应字符串
     * 
     * @param urlstr
     *            完整的请求url字符串
     * @return
     */
    public String doGetRequest(String urlstr) {
	String response = "";

	HttpMethod httpmethod = new GetMethod(urlstr);
	try {
	    int statusCode = client.executeMethod(httpmethod);
	    InputStream _InputStream = null;
	    if (statusCode == HttpStatus.SC_OK) {
		_InputStream = httpmethod.getResponseBodyAsStream();
	    }
	    if (_InputStream != null) {
		response = GetResponseString(_InputStream, "UTF-8");
	    }
	} catch (HttpException e) {
	    L.e("获取响应错误，原因：" + e.getMessage());
	    e.printStackTrace();
	} catch (IOException e) {
	    L.e("获取响应错误，原因1：" + e.getMessage());
	    e.printStackTrace();
	} finally {
	    httpmethod.releaseConnection();

	}
	return response;
    }

    /**
     * 
     * @param _InputStream
     * @param Charset
     * @return
     */
    public String GetResponseString(InputStream _InputStream, String Charset) {
	String response = "";
	try {
	    if (_InputStream != null) {
		StringBuffer buffer = new StringBuffer();
		InputStreamReader isr = new InputStreamReader(_InputStream, Charset);
		Reader in = new BufferedReader(isr);
		int ch;
		while ((ch = in.read()) > -1) {
		    buffer.append((char) ch);
		}
		response = buffer.toString();
		buffer = null;
	    }
	} catch (Exception e) {
	    L.e("获取响应错误，原因：" + e.getMessage());
	    response = response + e.getMessage();
	    e.printStackTrace();
	}
	return response;
    }

    public static void main(String[] args) {
	String url = "http://esms.etonenet.com/sms/mt?spid=3060&sppassword=hbkj3060&das=8618611178949&command=MULTI_MT_REQUEST&sm=a1beccd4b1a6a1bf20cda8b5c0bdd3c8ebcdeab3c9a3a1&dc=15";
	// System.out.println(doGetRequest(url));
    }
}
