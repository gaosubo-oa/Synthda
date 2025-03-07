package com.xoa.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.Map;

public class ResponseWithHttpClient {
	private static MultiThreadedHttpConnectionManager manager = new MultiThreadedHttpConnectionManager();
	private static int connectionTimeOut = 20000;//设置连接超时的时间
	private static int socketTimeOut = 10000;//设置读取数据超时的时间
	private static int MaxtotalConnections = 40;//总的连接数
	private static int MaxConnectionsPerHost = 35;//每个host最大的连接数
	
	private static boolean mark = false;
	
	public static void SetPara(){
		manager.getParams().setConnectionTimeout(connectionTimeOut);
		manager.getParams().setSoTimeout(socketTimeOut);
		manager.getParams().setDefaultMaxConnectionsPerHost(MaxConnectionsPerHost);
		manager.getParams().setMaxTotalConnections(MaxtotalConnections);
		mark = true;
	}
	public static String getResponseWithHttpClient(String url,String encode){
		HttpClient client = new HttpClient(manager);
		if(mark){
			ResponseWithHttpClient.SetPara();
		}
		
		PostMethod postMethod = new PostMethod(url);
		
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,encode);
		
		String result = null;
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = null;
		try {
			client.executeMethod(postMethod);
			
			reader =  new BufferedReader(new InputStreamReader(postMethod.getResponseBodyAsStream(),postMethod.getResponseCharSet()));
			String inputLine = null;
			while((inputLine=reader.readLine())!=null){
				buffer.append(inputLine);
			}
			
			result = buffer.toString();
			result = ResponseWithHttpClient.ConverterStringCode(buffer.toString(), postMethod.getResponseCharSet(), encode);
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "";
		}finally{
			try {
				postMethod.releaseConnection();
				reader.close();
			} catch (IOException e) {
			}
			return result;
		}
		
	}
	/**
	 * 发送post请求 
	 * @param url 地址
	 * @param encode 默认utf-8
 	 * @param content {"username":"haha"}
	 * @return 
	 */
	public static String getResponseWithHttpClient(String url,String encode,Map<String, String> content){
		HttpClient client = new HttpClient(manager);
		if(mark){
			ResponseWithHttpClient.SetPara();
		}
		
		PostMethod postMethod = new PostMethod(url);
		//传参数
		if(content!=null&&content.size()>0){
			int index=0;
			NameValuePair[] nvArray = new NameValuePair[content.size()];
			for (Map.Entry<String, String> entry : content.entrySet()) {
				//System.out.println("key= " + entry.getKey() + " and value= " + entry.getValue());
				nvArray[index]=new NameValuePair(entry.getKey(), entry.getValue());
				index++;
			}	
			postMethod.setRequestBody(nvArray);
		}
		//
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,encode);
		
		String result = null;
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = null;
		try {
			client.executeMethod(postMethod);
			
			reader =  new BufferedReader(new InputStreamReader(postMethod.getResponseBodyAsStream(),postMethod.getResponseCharSet()));
			String inputLine = null;
			while((inputLine=reader.readLine())!=null){
				buffer.append(inputLine);
			}
			
			result = buffer.toString();
			result = ResponseWithHttpClient.ConverterStringCode(buffer.toString(), postMethod.getResponseCharSet(), encode);
			
		} catch (Exception e) {
			e.printStackTrace();
			result = "";
		}finally{
			try {
				postMethod.releaseConnection();
				reader.close();
			} catch (IOException e) {
			}
			return result;
		}
		
	}	
	private static String ConverterStringCode(String source,
			String srcEncode, String destEncode) {
		if (source != null) {
			try {
				return new String(source.getBytes(srcEncode), destEncode);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return "";
			}
		} else {
			return "";
		}
	}
	
}
