package com.xoa.util.sendmsg;

import com.xoa.dao.smsSettings.SmsSettingsMapper;
import com.xoa.model.smsSettings.SmsSettings;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;


/**
 * @author B-wy:
 * @version 创建时间：2017年6月8日 上午10:25:06 类说明 emc-发送工具类
 */
@Component
public class MessageUtil {

	@Autowired
	SmsSettingsMapper smsSettingsMapper;

	private static String serviceUrl = "";
	/**
	 * 接入端帐号
	 */
	private static String accountID = "";

	/**
	 * 接入端密钥
	 */
	private static String accountKey = "";

	public static Map channelCodeToId;

	public static Map channelCodeToName;

	/**
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param channelCode
	 *            渠道编码
	 * @param netIds
	 *            内部人员IDS
	 * @param outAddresses
	 *            外部人员接收帐号
	 * @param isCron
	 *            是否定时 1=定时, 0=不定时
	 * @param sendTime
	 *            发送时间 定时时必填
	 * @return
	 */
	public static String sendmsg(String title, String content, String channelCode, List netIds,
								 List outAddresses, int isCron, String sendTime,SmsSettings smsSettings) {
		Map result = new HashMap();

		if(channelCodeToId == null || channelCodeToId.get(channelCode) == null ){
			initChannelInfo(smsSettings);
		}
		String channelId = channelCodeToId.get(channelCode).toString();

		if(channelId == null){
			result.put("errcode", "40014");
			result.put("msg", "接入端没有此渠道的发送权限");
			return result.toString();
		}


		JSONObject dataJson = new JSONObject();
		dataJson.put("channels", channelCode);
		dataJson.put("channelIds", channelId);
		dataJson.put("title", title);
		dataJson.put("content", content);
		dataJson.put("intReceiver", netIds);
		// 外部联系人,此处填入对应的渠道接收信息
		/*JSONObject extReceivers = new JSONObject();
		extReceivers.put(channelCode, outAddresses);*/
		dataJson.put("extReceiver", outAddresses);
		dataJson.put("isCron", "" + isCron);
		HttpPost httpPost = null;
		try {
			httpPost = new HttpPost(serviceUrl+ smsSettings.getPort() + "?accountID="+accountID + "&accountKey=" + accountKey + "&msgJson=" +  getEncode(dataJson.toString()) );
			CloseableHttpClient client = HttpClients.createDefault();

			httpPost.setHeader(new BasicHeader("Content-Type", "application/json;charset=UTF-8"));

			CloseableHttpResponse response = client.execute(httpPost);
			return EntityUtils.toString(response.getEntity());
		} catch(Exception e){
			e.printStackTrace();
		}finally {
			if (httpPost != null){
				httpPost.releaseConnection();
			}
		}

		return null;
	}


	/**
	 * 刷新接入端可用渠道信息`0
	 */
	public static void initChannelInfo(SmsSettings smsSettings) {
		if(channelCodeToId == null){
			channelCodeToId = new HashMap();
		}
		if(channelCodeToName == null){
			channelCodeToName = new HashMap();
		}
		serviceUrl=smsSettings.getProtocol()+"://"+smsSettings.getHost();
		accountID=smsSettings.getUsername();
		accountKey=smsSettings.getPwd();

		String url = serviceUrl + "/restful/get_channels";
		Map data = new HashMap();
		data.put("accountID", accountID);
		data.put("accountKey", accountKey);
		HttpClientUtils client = new HttpClientUtils();
		JSONObject obj = client.httpGet(url, data);
		// 是否成功
		if (obj.getInt("errcode") == 0) {
			// 成功
			JSONObject res = obj.getJSONObject("data");

			// 获取手机渠道信息

			Set keys = res.keySet();
			Iterator tempKeys = keys.iterator();

			while(tempKeys.hasNext()) {
				String key = tempKeys.next().toString();
				JSONArray tempArray = res.getJSONArray(key);
				for (int i = 0; i < tempArray.size(); i++) {
					JSONObject temp = tempArray.getJSONObject(i);
					// 判断通道是否可用
					if (temp.getString("status").equals("0")) {
						channelCodeToId.put(key, temp.getString("id"));
						channelCodeToName.put(key, temp.getString("channelName"));
						break;
					}
				}
			}
		}
	}

	public static String getEncode(String needEncodeStr) throws UnsupportedEncodingException {

		String encodeStr = URLEncoder.encode(needEncodeStr, "utf-8");
		String[] uppercase = new String[0XFF + 1];
		String[] lowercase = new String[0XFF + 1];
		for (int i = 0; i <= 0XFF; i++) {
			uppercase[i] = "%" + String.format("%02x", i);
			lowercase[i] = uppercase[i];
			uppercase[i] = uppercase[i].toUpperCase();
		}
		return org.apache.commons.lang3.StringUtils.replaceEach(encodeStr, uppercase, lowercase);
	}


}
