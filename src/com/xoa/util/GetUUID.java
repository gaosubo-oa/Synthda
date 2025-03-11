package com.xoa.util;

import java.util.UUID;

public class GetUUID {


	public static String getUuid(){
		UUID  uuidString=UUID.randomUUID();
		return uuidString.toString().replace("-", "");
	}

	/**
	 * 得到32位的uuid
	 *
	 * @return
	 */
	public static String getUUID32() {
		return UUID.randomUUID().toString().replace("-", "").toLowerCase();
	}

	/**
	 * 得到指定数量的UUID，以数组的形式返回
	 *
	 * @param num
	 * @return
	 */
	public static String[] getUUID(int num) {
		if (num <= 0)
			return null;
		String[] uuidArr = new String[num];
		for (int i = 0; i < uuidArr.length; i++) {
			uuidArr[i] = getUUID32();
		}
		return uuidArr;
	}


	public static String[] chars = new String[] { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o",
			"p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U",
			"V", "W", "X", "Y", "Z" };

	/**
	 * 生成16位UUId
	 *
	 * @return
	 */
	public static  String generateUuid16() {
		StringBuffer shortBuffer = new StringBuffer();
		String uuid = UUID.randomUUID().toString().replace("-", "");
		for (int i = 0; i < 16; i++) {
			String str = uuid.substring(i * 2, i * 2 + 2);
			int x = Integer.parseInt(str, 16);
			shortBuffer.append(chars[x % 0x3E]);
		}
		return shortBuffer.toString();

	}


}
