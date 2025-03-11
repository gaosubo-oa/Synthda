package com.xoa.util.sendUtil;

import com.alibaba.fastjson.JSON;
import com.xoa.util.sendsmsyjt.*;
import org.apache.axis.MessageContext;
import org.apache.axis.transport.http.HTTPConstants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.xml.rpc.ServiceException;
import java.net.MalformedURLException;
import java.net.URL;
import java.rmi.RemoteException;
import java.text.DecimalFormat;
import java.util.UUID;

/**
 * Hello world!
 *
 */
public class SendYjt {
	protected static final Log log = LogFactory.getLog(SendYjt.class);

	public String sendSms(String url, String user, String pwd, String phone, String msg) {
		WebServiceLocator locator = new WebServiceLocator();
		WebServiceSoapStub stub;
		MTPacks mtPacks = getMtpack(phone,msg) ;
		long begin =System.currentTimeMillis() ,end =System.currentTimeMillis() ;
		try {
			stub = (WebServiceSoapStub) locator.getWebServiceSoap(new URL(url));
			stub._setProperty(MessageContext.HTTP_TRANSPORT_VERSION, HTTPConstants.HEADER_PROTOCOL_V11);
			GsmsResponse resp =  stub.post(user ,pwd ,mtPacks );
			end =System.currentTimeMillis() ;
			log.info(String.format(" user =%s  ,pwd =%s  ,mtPacks =%s  , resp=%s ", user ,pwd ,JSON.toJSONString(mtPacks), JSON.toJSONString(resp) ));

			return "0";
		} catch (MalformedURLException e) {
			log.error(mtPacks.getBatchID()     + "--  err " + e.getMessage());
			e.printStackTrace();
			return "1";
		} catch (ServiceException e) { 
			log.error(mtPacks.getBatchID()     + "--  err " + e.getMessage());
			e.printStackTrace();
			return "1";
		} catch (RemoteException e) { 
			log.error(mtPacks.getBatchID()     + "--  err " + e.getMessage());
			e.printStackTrace();
			return "1";
		}catch (Exception e) { 
			log.error(mtPacks.getBatchID()     + "--  err " + e.getMessage());
			e.printStackTrace();
			return "1";
		}
	}

	private static int getRandom(int min, int max) {
		double value = (Math.random() * (max - min) + min);
		DecimalFormat df = new DecimalFormat("##");
		value = Double.parseDouble(df.format(value));
		return (int) value;
	}

	private static MTPacks getMtpack(String mobile,String msg ) {
		MTPacks pack = new MTPacks();
		pack.setBatchID(UUID.randomUUID().toString());
		pack.setUuid(pack.getBatchID());
		pack.setSendType(0);
		pack.setMsgType(1);
		pack.setBatchName("协尔的工具测试批次" + System.currentTimeMillis());
		pack.setRemark("test");
		pack.setCustomNum("1");
		int i = 1;// 150;
		MessageData[] msgs = new MessageData[i];
		msgs[0] = new MessageData();
		msgs[0].setPhone(mobile);
		msgs[0].setContent(msg); 
		if(log.isDebugEnabled()) log.debug("批次号="+pack.getBatchID()+",发送号码="+mobile+",Content="+msg);
		pack.setMsgs(msgs);
		pack.setMedias(null);
		return pack;
	}	
}
