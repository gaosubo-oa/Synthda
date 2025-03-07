package com.xoa.util.sendmsg;

import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

/** 
* @author B-wy: 
* @version 创建时间：2017年10月25日 下午3:40:48 
* 类说明 
*/
public class EducationTest {
	
	private static int maxThread = 20;
	
	private static String url = "http://www.icourse163.org";
	
	private static String appId = "5a40b1a76cae958a68b34c7865b79cb0";
	
	private static String appSecret = "78bfab214afd0ac34af6f70c0aea87d4";
	
	private static String aesKey = "17fd21bf3018f092f5284f2519532ff7";
	
	private static AtomicLong anonce = new AtomicLong(0);
	
	public static void main(String[] args) throws ClientProtocolException, IOException {
		//post();
		
		//post_20();
		long timeStamp = new Date().getTime();
		long nonce = 111;
		String signature = appSecret + nonce + timeStamp;
		
//		getCourses(appSecret + nonce + timeStamp, nonce, timeStamp);
		timeStamp++;
		String termId = "1206183205";
		getTermInfos(appSecret + nonce + timeStamp, nonce, timeStamp, termId);
//		getMoocCourses(signature, nonce, timeStamp);
		timeStamp++;
		
		// 获取课程章节
		getCourseInfos(appSecret + nonce + timeStamp, nonce, timeStamp, termId);
		timeStamp++;
		
//		getVedioSigntures(appSecret + nonce + timeStamp, nonce, timeStamp);
	}
	
	private static String getCourses(String signature, long nonce, long timeStamp){
		String getUrl = url + "/open/courses?appId=" + appId + "&signature="+ getSha1(signature)+"&format=json&nonce="+nonce
				+"&pageIndex=1&pageSize=100&timestamp=" + timeStamp;
		HttpGet request = null;
		try {
			request = new HttpGet(getUrl);
			HttpResponse response = new HttpClientUtils().getClient().execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				//System.out.println(responseResult);
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
		} finally {
			if (request != null) {
				request.releaseConnection();
			}

		}
		return null;
	}
	
	private static String getMoocCourses(String signature, long nonce, long timeStamp){
		String getUrl = url + "/open/courses/allmooc?appId=" + appId + "&signature="+ getSha1(signature)+"&format=json&nonce="+nonce
				+"&pageIndex=1&pageSize=100&timestamp=" + timeStamp;
		HttpGet request = null;
		try {
			request = new HttpGet(getUrl);
			HttpResponse response = new HttpClientUtils().getClient().execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				//System.out.println(responseResult);
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
		} finally {
			if (request != null) {
				request.releaseConnection();
			}

		}
		return null;
	}
	
	private static String getTermInfos(String signature, long nonce, long timeStamp, String termId){
		String getUrl = url + "/open/terms/"+termId+"?appId=" + appId + "&signature="+ getSha1(signature)+"&format=json&nonce="+nonce
				+"&timestamp=" + timeStamp + "";
		//System.out.println(getUrl);
		HttpGet request = null;
		try {
			request = new HttpGet(getUrl);
			HttpResponse response = new HttpClientUtils().getClient().execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				//System.out.println(responseResult);
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
		} finally {
			if (request != null) {
				request.releaseConnection();
			}

		}
		return null;
	}
	
	private static String getCourseInfos(String signature, long nonce, long timeStamp, String termId){
		String getUrl = url + "/open/term/chapter?appId=" + appId + "&signature="+ getSha1(signature)+"&format=json&nonce="+nonce
				+"&timestamp=" + timeStamp + "&termId=" + termId;
		//System.out.println(getUrl);
		HttpGet request = null;
		try {
			request = new HttpGet(getUrl);
			HttpResponse response = new HttpClientUtils().getClient().execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				//System.out.println("获取课程章节:" + responseResult);
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
		} finally {
			if (request != null) {
				request.releaseConnection();
			}

		}
		return null;
	}
	
	private static String getVedioSigntures(String signature, long nonce, long timeStamp){
		String getUrl = "http://www.icourse163.org/open/term/video?appId="+appId+"&timestamp="+timeStamp+"&vedioId=1214469463&nonce="+nonce+"&signature="+
				getSha1(signature)+"&termId=1206080228&format=json";
//		String getUrl = url + "/open/term/video?appId="+appId+"&signature="+getSha1(signature)+""
//				+ "&format=json&nonce="+nonce+"&timestamp="+timeStamp+"&termId=1206080228&videoId=1214469463";
		//System.out.println(getUrl);
		HttpGet request = null;
		try {
			request = new HttpGet(getUrl);
			HttpResponse response = new HttpClientUtils().getClient().execute(request);
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				HttpEntity httpEntity = response.getEntity();
				String responseResult = EntityUtils.toString(httpEntity);
				//System.out.println(responseResult);
			}
		} catch (Exception e) {
			request.abort();
			e.printStackTrace();
		} finally {
			if (request != null) {
				request.releaseConnection();
			}

		}
		return null;
	}
	
	private static String loginTo163(){
		String loginUrl = url + "/api/account/login2site.do?appId="+appId+"&value="
				+ "aes(json(appId+loginId+nickName+realName+email+studentNo+schoolName+schoolRole+timestamp+nonce+notifyUrl+errorUrl))";
		JSONObject json = new JSONObject();
//		json.put("appId", );
//		json.put("loginId", );
//		json.put("appId", );
//		json.put("appId", );
//		json.put("appId", );
		return null;
	}
	

	public static String getSha1(String str) {

		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			MessageDigest mdTemp = MessageDigest.getInstance("SHA1");
			mdTemp.update(str.getBytes("UTF-8"));
			byte[] md = mdTemp.digest();
			int j = md.length;
			char buf[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				buf[k++] = hexDigits[byte0 >>> 4 & 0xf];
				buf[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(buf);
		} catch (Exception e) {
			return null;
		}
	}

	
	public static void post() throws ClientProtocolException, IOException{
		JSONObject dataJson = new JSONObject();
		// 手机号填入=ydxy-mobile, 邮件填入email
		dataJson.put("channels", "email");
		dataJson.put("channelIds", "b0847a94-a056-4c6f-8d3b-363e2c742f16");
		dataJson.put("title", "hello world!!");
		dataJson.put("content", "你好,世界!!");
//		dataJson.put("typecode", "1");
		dataJson.put("intReceiver", Arrays.asList(new String[]{"62435cbc-c6ca-45a1-9888-690830aba769"}));
		// 外部联系人,此处填入对应的渠道接收信息
		dataJson.put("extReceiver", new ArrayList());
		dataJson.put("isCron", "" + 0);
		
		HttpPost httpPost = new HttpPost("http://192.168.1.233:8888/restful/v1/sendmsg");
		
		CloseableHttpClient client = HttpClients.createDefault();
		
		List params = new ArrayList();
		params.add(new BasicNameValuePair("accountID", "2"));
		params.add(new BasicNameValuePair("accountKey", "nndCiXd86WL5726Q7331J92P8f"));
		params.add(new BasicNameValuePair("msgJson", dataJson.toString()));
		
		HttpEntity httpEntity = new UrlEncodedFormEntity(params, "UTF-8");
		httpPost.setEntity(httpEntity);
		CloseableHttpResponse response = client.execute(httpPost);
		//System.out.println(EntityUtils.toString(response.getEntity()));
	}
}
