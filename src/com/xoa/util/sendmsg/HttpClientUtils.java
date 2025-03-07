package com.xoa.util.sendmsg;

import net.sf.json.JSONObject;
import org.apache.http.*;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.params.ConnManagerParams;
import org.apache.http.conn.params.ConnPerRouteBean;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import java.net.URLDecoder;
import java.util.*;
import java.util.Map.Entry;


public class HttpClientUtils {
	private static HttpClient client;

	private static final String APPLICATION_JSON = "application/json";

	private static final String CONTENT_TYPE_TEXT_JSON = "text/json";
	/**
	 * 定义client使用的字符集
	 */
	private final static String CHARSET = HTTP.UTF_8;

	/**
	 * 最大连接数
	 */
	public final static int MAX_TOTAL_CONNECTIONS = 400;

	/**
	 * 获取连接的最大等待时间
	 */
	public final static int HTTP_CLIENT_WAIT_TIMEOUT = 10000;

	/**
	 * 每个路由最大连接数
	 */
	public final static int MAX_ROUTE_CONNECTIONS = 200;

	/**
	 * 连接超时时间
	 */
	public final static int CONNECT_TIMEOUT = 40000;

	/**
	 * 读取超时时间
	 */
	public final static int READ_TIMEOUT =8000;

	static {
		if (client == null) {
			HttpParams params = new BasicHttpParams();
			ConnManagerParams.setMaxTotalConnections(params, MAX_TOTAL_CONNECTIONS);
			HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
			HttpProtocolParams.setContentCharset(params, CHARSET);
			HttpProtocolParams.setUseExpectContinue(params, true);
			ConnManagerParams.setTimeout(params, HTTP_CLIENT_WAIT_TIMEOUT);
			HttpConnectionParams.setConnectionTimeout(params, CONNECT_TIMEOUT);
			HttpConnectionParams.setSoTimeout(params, READ_TIMEOUT);
			ConnPerRouteBean connPerRoute = new ConnPerRouteBean(MAX_ROUTE_CONNECTIONS);
			ConnManagerParams.setMaxConnectionsPerRoute(params, connPerRoute);

			SchemeRegistry schReg = new SchemeRegistry();
			schReg.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
			schReg.register(new Scheme("https", SSLSocketFactory.getSocketFactory(), 443));

			ClientConnectionManager conMgr = new ThreadSafeClientConnManager(params, schReg);

			client = new DefaultHttpClient(conMgr, params);
		}
	}

	public HttpClient getClient(){
		return client;
	}
	/**
	 * httpPost
	 * 
	 * @param url
	 *            路径
	 * @param mapParam
	 *            参数
	 * @return
	 */
	public JSONObject httpPost(String url, Map paramMap) {
		return httpPost(url, paramMap, false);
	}

	/**
	 * post请求
	 * 
	 * @param url
	 *            url地址
	 * @param mapParam
	 *            参数
	 * @param noNeedResponse
	 *            不需要返回结果
	 * @return
	 */
	public JSONObject httpPost(String url, Map paramMap, boolean noNeedResponse) {
		// post请求返回结果
		JSONObject jsonResult = null;
		HttpPost httpPost = null;
		try {
			httpPost = new HttpPost(url);
			//List<NameValuePair> params = new ArrayList<NameValuePair>();
			JSONObject json = JSONObject.fromObject(paramMap);
			String postData = json.toString();
			// String encoderJson = URLEncoder.encode(postData, HTTP.UTF_8);

			httpPost.addHeader(HTTP.CONTENT_TYPE, APPLICATION_JSON);

			StringEntity se = new StringEntity(postData, "utf-8");
			se.setContentType(CONTENT_TYPE_TEXT_JSON);
			se.setContentEncoding("UTF-8");
			se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE, APPLICATION_JSON));
			httpPost.setEntity(se);
			HttpResponse result = client.execute(httpPost);
			url = URLDecoder.decode(url, "UTF-8");
			/** 请求发送成功，并得到响应 **/
			if (result.getStatusLine().getStatusCode() == 200) {
				String str = "";
				try {
					/** 读取服务器返回过来的json字符串数据 **/
					str = EntityUtils.toString(result.getEntity());
					
					if (noNeedResponse) {
						return null;
					}
					/** 把json字符串转换成json对象 **/
					jsonResult = JSONObject.fromObject(str);
				} catch (Exception e) {
					e.printStackTrace();
//					logger.error(e.getMessage(), e);
				}
			}else{
				throw new Exception("请求失败, 失败CODE:" + String.valueOf(result.getStatusLine().getStatusCode()));
//				logger.error("请求失败, 失败CODE:{}", String.valueOf(result.getStatusLine().getStatusCode()));
			}
		} catch (Exception e) {
			httpPost.abort();
			e.printStackTrace();
//			logger.error(e.getMessage(), e);
		} finally {
			httpPost.releaseConnection();
		}
		return jsonResult;
	}
	
	
	public JSONObject httpGet(String url, Map paramMap){
		List params = new ArrayList();
		
		HttpGet request = null;
	    try {
	    	
	    	Set temps = paramMap.entrySet();
	    	Iterator tempKeys = temps.iterator();
			
			while(tempKeys.hasNext()) {
				Entry entry = (Entry) tempKeys.next();
	    		 params.add(new BasicNameValuePair((String) entry.getKey(), String.valueOf(entry.getValue())));
			}
	    	
	    	String paramStr = EntityUtils.toString(new UrlEncodedFormEntity(params, Consts.UTF_8));
	    	request = new HttpGet(url+"?"+paramStr);
			HttpResponse response = client.execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				JSONObject obj = JSONObject.fromObject(responseResult);
				return obj;
			}else{
				throw new Exception("请求失败, 失败CODE:" + String.valueOf(response.getStatusLine().getStatusCode()));
//				logger.error("请求失败, 失败CODE:{}", String.valueOf(response.getStatusLine().getStatusCode()));
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
//			logger.error(e.getMessage(), e);
		} finally {
			if (request != null) {
				request.releaseConnection();
			}
		}
		return null;
	}
	
	
}
