package com.xoa.util.sso;


import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

/**
 * 
 * 单点登录加密解密工具类
 * 
 */

public class CASEncrypt {
	//private static final String PASSWORD_CRYPT_KEY = "00000000";

	// private final static String DES = "DES";
	// private static final byte[] desKey;

	/**
	 * 解密数据
	 * @param value
	 * @param key
	 */
	public static String decrypt(String value, String key) throws Exception {
		byte[] bytesrc = convertHexString(value);
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
		DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));
		cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
		byte[] retByte = cipher.doFinal(bytesrc);
		return java.net.URLDecoder.decode(new String(retByte, "UTF-8"),"utf-8");
	}
	
	/**
	 * 加密数据
	 * @param value
	 * @param key
	 * @return
	 */
	public static String encrypt(String value, String key) {
		String result = "";
		try {
			value = java.net.URLEncoder.encode(value, "utf-8");
			result = toHexString(encryptByte(value, key))
					.toUpperCase();
		} catch (Exception ex) {
			ex.printStackTrace();
			return "";
		}
		return result;
	}

	public static byte[] encryptByte(String message, String key) throws Exception {
		Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");

		DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));

		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey secretKey = keyFactory.generateSecret(desKeySpec);
		IvParameterSpec iv = new IvParameterSpec(key.getBytes("UTF-8"));
		cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);

		return cipher.doFinal(message.getBytes("UTF-8"));
	}

	public static byte[] convertHexString(String ss) {
		byte digest[] = new byte[ss.length() / 2];
		for (int i = 0; i < digest.length; i++) {
			String byteString = ss.substring(2 * i, 2 * i + 2);
			int byteValue = Integer.parseInt(byteString, 16);
			digest[i] = (byte) byteValue;
		}
		return digest;
	}

	public static String toHexString(byte b[]) {
		StringBuffer hexString = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			String plainText = Integer.toHexString(0xff & b[i]);
			if (plainText.length() < 2)
				plainText = "0" + plainText;
			hexString.append(plainText);
		}
		return hexString.toString();
	}

	/*public static void main(String[] args) throws Exception {
		String key = "00000000";
		String value = "002586";
		String a = encrypt(value, key);
		System.out.println("加密后的数据为:" + a);
		System.out.println("解密后的数据为：" + decrypt(a, key));

		String s = "{\"policeno\":\"000001\",\"loginname\":\"sadmin\",\"idcard\":\"12345678901234568\",\"name\":\"张三\",\"orgcode\":\"340000000000\",\"orgname\":\"安徽省公安厅\",\"operateip\":\"10.10.10.10\",\"operatetime\":\"20140625010101\",\"requestsysid\":\"00000001\",\"responsesysid\":\"00000000\",\"serviceid\":\"S00000000000\"}";
		String ss = encrypt(s, key);

		String testStr = "796DD62E92B69FA53E6C6A27C989B25D06C1E237BB29AC9A2ADE444F44FC3CC3E9B9ACE4661BC869FEB7FBB90902B00929749481400987D37F78A47202721297E65BEA6501ECEEB6030A61A796A2DB4A8D2A8D97944A28A6FAAEB59CD839E4E95577C7E0ED1403F83B55A5F4274EAC0451191173B5BFA68FA6FAE3B404D30028555301455AAA4819DC4883EA7544D73DC3C1C970E6130EBAF9296D13ECEBF24B560C07D4F5D797783A69053338BACC178959D43069221C68513F4ADEDBF243F14449089545CAA104D63690EC253B436FB657C68EFEFA755C69ACDC90353CC7725DBE22EAB01D34FE99FB99D818EF36BE454667713F2D0128A284FF59BA76E10FFF3B983F5697D8DC3ECA70722B4243FB4118D62A34DB85585E20125381BC1F54CB075ACE82DFCDD37D6ACAFB32931DDEF07DE8569C78950F76D2774A962A95B60313885876F84D24E1E7ECBC1F95C6D8C69A729997C63855F5A28D9ECAA27CB981CBEE0E3C9DD3FB55EEDB39429BE8B2376A3292120EE7351EC49291D578C2A0C4A9F5B13246C26E";
		String decrypt = decrypt(testStr, key);
		System.out.println("解密："+ decrypt);

		JSONObject ssoUser = JSONObject.fromObject(decrypt);
		System.out.println(ssoUser.getString("policeno"));
	}*/
}
