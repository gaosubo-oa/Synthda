package com.xoa.util;

import com.xoa.util.encrypt.EncryptSalt;
import org.apache.commons.codec.Charsets;
import org.apache.commons.codec.binary.Hex;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * MD5加密解密工具类
 * <p>
 * 
 * @ClassName : PassWordUtils
 *            </p>
 *            <p>
 * @Description : TODO
 *              </p>
 *              <p>
 * @Author : HuaZai
 *         </p>
 *         <p>
 * @ContactInformation : 1461522031@qq.com/huazai6789@aliyun.com
 *                     </p>
 *                     <p>
 * @Date : 2017年12月26日 下午2:44:14
 *       </p>
 * 
 *       <p>
 * @Version : V1.0.0
 *          </p>
 *
 */
public class MD5Utils {

	/**
	 * 普通MD5加密 01
	 * <p>
	 * 
	 * @Title : getStrMD5
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月26日 下午2:49:44
	 *       </p>
	 */
	public static String getStrMD5(String inStr) {
		// 获取MD5实例
		MessageDigest md5 = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			System.out.println(e.toString());
			return "";
		}

		// 将加密字符串转换为字符数组
		char[] charArray = inStr.toCharArray();
		byte[] byteArray = new byte[charArray.length];

		// 开始加密
		for (int i = 0; i < charArray.length; i++)
			byteArray[i] = (byte) charArray[i];
		byte[] digest = md5.digest(byteArray);
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < digest.length; i++) {
			int var = digest[i] & 0xff;
			if (var < 16)
				sb.append("0");
			sb.append(Integer.toHexString(var));
		}
		return sb.toString();
	}

	/**
	 * 普通MD5加密 02
	 * <p>
	 * 
	 * @Title : getStrrMD5
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月27日 上午11:18:39
	 *       </p>
	 */
	public static String getStrrMD5(String password) {

		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
		try {
			byte strTemp[] = password.getBytes("UTF-8");
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte md[] = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 15];
				str[k++] = hexDigits[byte0 & 15];
			}

			return new String(str);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * MD5双重解密
	 * <p>
	 * 
	 * @Title : getconvertMD5
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月26日 下午3:34:17
	 *       </p>
	 */
	public static String getconvertMD5(String inStr) {
		char[] charArray = inStr.toCharArray();
		for (int i = 0; i < charArray.length; i++) {
			charArray[i] = (char) (charArray[i] ^ 't');
		}
		String str = String.valueOf(charArray);
		return str;
	}

	/**
	 * 使用Apache的Hex类实现Hex(16进制字符串和)和字节数组的互转
	 * <p>
	 * 
	 * @Title : md5Hex
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月27日 上午11:28:25
	 *       </p>
	 */
	@SuppressWarnings("unused")
	private static String md5Hex(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] digest = md.digest(str.getBytes());
			return new String(new Hex().encode(digest));
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString());
			return "";
		}
	}

	/**
	 * 加盐MD5加密
	 * <p>
	 * 
	 * @Title : getSaltMD5
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月27日 上午11:21:00
	 *       </p>
	 */
	public static String getSaltMD5(String password) {
		// 生成一个16位的随机数
		Random random = new Random();
		StringBuilder sBuilder = new StringBuilder(16);
		sBuilder.append(random.nextInt(99999999)).append(random.nextInt(99999999));
		int len = sBuilder.length();
		if (len < 16) {
			for (int i = 0; i < 16 - len; i++) {
				sBuilder.append("0");
			}
		}
		// 生成最终的加密盐
		String Salt = sBuilder.toString();
		password = md5Hex(password + Salt);
		char[] cs = new char[48];
		for (int i = 0; i < 48; i += 3) {
			cs[i] = password.charAt(i / 3 * 2);
			char c = Salt.charAt(i / 3);
			cs[i + 1] = c;
			cs[i + 2] = password.charAt(i / 3 * 2 + 1);
		}
		return String.valueOf(cs);
	}

	/**
	 * 验证加盐后是否和原文一致
	 * <p>
	 * 
	 * @Title : verifyMD5
	 *        </p>
	 *        <p>
	 * @Description : TODO
	 *              </p>
	 *              <p>
	 * @Author : HuaZai
	 *         </p>
	 *         <p>
	 * @Date : 2017年12月27日 下午2:22:22
	 *       </p>
	 */
	public static boolean getSaltverifyMD5(String password, String md5str) {
		char[] cs1 = new char[32];
		char[] cs2 = new char[16];
		for (int i = 0; i < 48; i += 3) {
			cs1[i / 3 * 2] = md5str.charAt(i);
			cs1[i / 3 * 2 + 1] = md5str.charAt(i + 2);
			cs2[i / 3] = md5str.charAt(i + 1);
		}
		String Salt = new String(cs2);
		return md5Hex(password + Salt).equals(String.valueOf(cs1));
	}
	public static String md5Crypt(byte[] keyBytes, String salt) {
		return md5Crypt(keyBytes, salt, "$1$");
	}

	public static String md5Crypt(byte[] keyBytes, String salt, String prefix) {
		int keyLen = keyBytes.length;
		String saltString;
		if (salt == null) {
			saltString = getRandomSalt(8);
		} else {
			Pattern p = Pattern.compile("^" + prefix.replace("$", "\\$") + "([\\.\\/a-zA-Z0-9]{1,8}).*");
			Matcher m = p.matcher(salt);
			if (m == null || !m.find()) {
				throw new IllegalArgumentException("Invalid salt value: " + salt);
			}

			saltString = m.group(1);
		}

		byte[] saltBytes = saltString.getBytes(Charsets.UTF_8);
		MessageDigest ctx = getMd5Digest();
		ctx.update(keyBytes);
		ctx.update(prefix.getBytes(Charsets.UTF_8));
		ctx.update(saltBytes);
		MessageDigest ctx1 = getMd5Digest();
		ctx1.update(keyBytes);
		ctx1.update(saltBytes);
		ctx1.update(keyBytes);
		byte[] finalb = ctx1.digest();

		int ii;
		for(ii = keyLen; ii > 0; ii -= 16) {
			ctx.update(finalb, 0, ii > 16 ? 16 : ii);
		}

		Arrays.fill(finalb, (byte)0);
		ii = keyLen;

		for(boolean var10 = false; ii > 0; ii >>= 1) {
			if ((ii & 1) == 1) {
				ctx.update(finalb[0]);
			} else {
				ctx.update(keyBytes[0]);
			}
		}

		StringBuilder passwd = new StringBuilder(prefix + saltString + "$");
		finalb = ctx.digest();

		for(int i = 0; i < 1000; ++i) {
			ctx1 = getMd5Digest();
			if ((i & 1) != 0) {
				ctx1.update(keyBytes);
			} else {
				ctx1.update(finalb, 0, 16);
			}

			if (i % 3 != 0) {
				ctx1.update(saltBytes);
			}

			if (i % 7 != 0) {
				ctx1.update(keyBytes);
			}

			if ((i & 1) != 0) {
				ctx1.update(finalb, 0, 16);
			} else {
				ctx1.update(keyBytes);
			}

			finalb = ctx1.digest();
		}

		b64from24bit(finalb[0], finalb[6], finalb[12], 4, passwd);
		b64from24bit(finalb[1], finalb[7], finalb[13], 4, passwd);
		b64from24bit(finalb[2], finalb[8], finalb[14], 4, passwd);
		b64from24bit(finalb[3], finalb[9], finalb[15], 4, passwd);
		b64from24bit(finalb[4], finalb[10], finalb[5], 4, passwd);
		b64from24bit((byte)0, (byte)0, finalb[11], 2, passwd);
		ctx.reset();
		ctx1.reset();
		Arrays.fill(keyBytes, (byte)0);
		Arrays.fill(saltBytes, (byte)0);
		Arrays.fill(finalb, (byte)0);
		return passwd.toString();
	}

	static final String B64T = "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

	static void b64from24bit(byte b2, byte b1, byte b0, int outLen, StringBuilder buffer) {
		int w = b2 << 16 & 16777215 | b1 << 8 & '\uffff' | b0 & 255;

		for(int var6 = outLen; var6-- > 0; w >>= 6) {
			buffer.append("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".charAt(w & 63));
		}

	}

	static String getRandomSalt(int num) {
		StringBuilder saltString = new StringBuilder();

		for(int i = 1; i <= num; ++i) {
			saltString.append("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".charAt((new Random()).nextInt("./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".length())));
		}

		return saltString.toString();
	}

	public static MessageDigest getMd5Digest() {
		return getDigest("MD5");
	}

	public static MessageDigest getDigest(String algorithm) {
		try {
			return MessageDigest.getInstance(algorithm);
		} catch (NoSuchAlgorithmException var2) {
			throw new IllegalArgumentException(var2);
		}
	}

	public static String getEncryptString(String password) {

		String md5WithSalt = null;
		//非空字符串
		if (password != null && !"".equals(password.trim())) {
			md5WithSalt = md5Crypt(password.trim().getBytes(), "$1$".concat(EncryptSalt.getRandomSalt(12)));
		}
		//“”字符串加密要得到tVHbkPWW57Hw.作为加密后结果
		if (password != null && "".equals(password.trim())) {
			md5WithSalt = "tVHbkPWW57Hw.";
		}
		return md5WithSalt;
	}

    //下述为封装的两个md5和aes组合进行使用加密密钥对指定数据加密和解密的接口（含key）
    private static final String defaultCharset = "UTF-8";
    private static final String KEY_AES = "AES";
    private static final String KEY_MD5 = "MD5";

    private static MessageDigest md5Digest;

    static {
        try {
            md5Digest = MessageDigest.getInstance(KEY_MD5);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
    }

    /**
     * 加密
     *
     * @param data
     * @param key
     * @return
     */
    public static String encrypt(String data, String key) {
        return doAES(data, key, Cipher.ENCRYPT_MODE);
    }

    /**
     * 解密
     *
     * @param data
     * @param key
     * @return
     */
    public static String decrypt(String data, String key) {
        return doAES(data, key, Cipher.DECRYPT_MODE);
    }


    private static String doAES(String data, String key, int mode) {
        try {
            boolean encrypt = mode == Cipher.ENCRYPT_MODE;
            byte[] content;
            //true 加密内容 false 解密内容
            if (encrypt) {
                content = data.getBytes(defaultCharset);
            } else {
                content = parseHexStr2Byte(data);
            }
            SecretKeySpec keySpec = new SecretKeySpec(md5Digest.digest(key.getBytes(defaultCharset)), KEY_AES);//构造一个密钥
            Cipher cipher = Cipher.getInstance(KEY_AES);// 创建密码器
            cipher.init(mode, keySpec);// 初始化
            byte[] result = cipher.doFinal(content);//加密或解密
            if (encrypt) {
                return parseByte2HexStr(result);
            } else {
                return new String(result, defaultCharset);
            }
        } catch (Exception e) {
        }
        return null;
    }


    public static String parseByte2HexStr(byte buf[]) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < buf.length; i++) {
            String hex = Integer.toHexString(buf[i] & 0xFF);
            if (hex.length() == 1) {
                hex = '0' + hex;
            }
            sb.append(hex.toUpperCase());
        }
        return sb.toString();
    }

    /**
     *  * 将16进制转换为二进制
     *  *
     *  * @param hexStr
     *  * @return
     *  
     */
    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1) {
            return null;
        }
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

	/**
	 * 获取文件md5值
	 */
	public static String getFileMd5Code(String filePath) {
		try {
			InputStream fis = new FileInputStream(filePath);
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] buffer = new byte[1024];
			int length = -1;
			while ((length = fis.read(buffer, 0, 1024)) != -1) {
				md.update(buffer, 0, length);
			}
			fis.close();
			//转换并返回包含16个元素字节数组,返回数值范围为-128到127
			byte[] md5Bytes = md.digest();
			BigInteger bigInt = new BigInteger(1, md5Bytes);
			return bigInt.toString(16);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * 获取文件md5值
	 */
	public static String getFileMd5Code(File file) {
		try {
			InputStream fis = new FileInputStream(file);
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] buffer = new byte[1024];
			int length = -1;
			while ((length = fis.read(buffer, 0, 1024)) != -1) {
				md.update(buffer, 0, length);
			}
			fis.close();
			//转换并返回包含16个元素字节数组,返回数值范围为-128到127
			byte[] md5Bytes = md.digest();
			BigInteger bigInt = new BigInteger(1, md5Bytes);
			return bigInt.toString(16);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}



}
