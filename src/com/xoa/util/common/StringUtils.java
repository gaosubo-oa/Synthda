package com.xoa.util.common;


import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.apache.commons.lang3.StringUtils.isEmpty;

/**
 * 
 * @作者 韩东堂
 * @创建日期 2017-4-24 下午4:01:18
 * @类介绍 字符串常用工具类
 * @构造参数 无
 * 
 */
public class StringUtils {
    
	/**
	 * 
	 * @作者 韩东堂
	 * @创建日期 2017-4-24 下午5:36:35 
	 * @方法介绍  检查元素是否为空
	 * @参数说明 @param callBack 外部比较器，通用于所有类型
	 * @参数说明 @param args 参数，前一位是待比较信息，后一位是为空时的错误信息（必须是成对出现）
	 * @参数说明 @return 返回null证明类型安全，不为null有字段为空
	 * @return
	 */
	public static String checkNullUtils(CheckCallBack callBack, Object... args) {
		if (args == null || args.length == 0) {
			L.e("be sure you param is not null");
			throw new RuntimeException("be sure you param is not null");
		}

		if (args.length % 2 != 0) {
			L.e("params must be pair");
			throw new RuntimeException("params must be pair");
		}

		for (int i = 0; i < args.length - 1; i += 2) {
			if (callBack.isNull(args)) {
				return args[i + 1].toString();
			}
			;
			if (args[i] == null) {
				return args[i + 1].toString();
			}
		}
		return null;
	}
	 
	public static Boolean checkNull(String str){
		if(str==null) return true;
		if("".equals(str.trim())||str.trim().length()==0) return true;
	    return false;
	}
	/**
	 * 创建人：刘景龙
	 * 创建时间：2022-01-25 14:52
	 * 方法介绍：判断字符串是否为数字 为数字返回true
	 * 参数说明：
	 */
	public static boolean checkNumber(final CharSequence cs) {
		// 判断是否为空，如果为空则返回false
		if (isEmpty(cs)) {
			return false;
		}
		// 通过 length() 方法计算cs传入进来的字符串的长度，并将字符串长度存放到sz中
		final int sz = cs.length();
		// 通过字符串长度循环
		for (int i = 0; i < sz; i++) {
			// 判断每一个字符是否为数字，如果其中有一个字符不满足，则返回false
			if (!Character.isDigit(cs.charAt(i))) {
				return false;
			}
		}
		// 验证全部通过则返回true
		return true;
	}
	/**
	 * 下划线转驼峰法
	 * @param line 源字符串
	 * @param smallCamel 大小驼峰,是否为小驼峰
	 * @return 转换后的字符串
	 */
	public static String underline2Camel(String line,boolean smallCamel){
		if(line==null||"".equals(line)){
			return "";
		}
		StringBuffer sb=new StringBuffer();
		Pattern pattern=Pattern.compile("([A-Za-z\\d]+)(_)?");
		Matcher matcher=pattern.matcher(line);
		while(matcher.find()){
			String word=matcher.group();
			sb.append(smallCamel&&matcher.start()==0?Character.toLowerCase(word.charAt(0)):Character.toUpperCase(word.charAt(0)));
			int index=word.lastIndexOf('_');
			if(index>0){
				sb.append(word.substring(1, index).toLowerCase());
			}else{
				sb.append(word.substring(1).toLowerCase());
			}
		}
		return sb.toString();
	}
	/**
	 * 驼峰法转下划线
	 * @param line 源字符串
	 * @return 转换后的字符串
	 */
	public static String camel2Underline(String line){
		if(line==null||"".equals(line)){
			return "";
		}
		line=String.valueOf(line.charAt(0)).toUpperCase().concat(line.substring(1));
		StringBuffer sb=new StringBuffer();
		Pattern pattern=Pattern.compile("[A-Z]([a-z\\d]+)?");
		Matcher matcher=pattern.matcher(line);
		while(matcher.find()){
			String word=matcher.group();
			sb.append(word.toUpperCase());
			sb.append(matcher.end()==line.length()?"":"_");
		}
		return sb.toString();
	}

	/**
	 * 字符串转int工具
	 * @Author 杨超
	 */

	public static int getInteger(Object o,int def){
		//把Object转成String
		String s = getString(o);
		//切割小数点
		int print = s.indexOf(".");
		if(print != -1){
			s = s.substring(0,print);
		}
		if(!"".equals(s)){
			try{
				return Integer.valueOf(s);
			}catch (Exception e){
				return def;
			}
		}
		return def;
	}


	public static String getString(Object o){
		if( o == null ){
			return "";
		}
		return String.valueOf(o);
	}


	/**
	 *  获取fmt字符串 出现第n次之前的字符串
	 * @param str
	 * @param fmt
	 * @param n
	 * @return
	 */
	public static String getIndexStr(String str, String fmt, int n) {
		int i = 0;
		int s = 0;
		while (i++ < n) {
			s = str.indexOf(fmt, s + 1);
			if (s == -1) {
				return str;
			}
		}
		return str.substring(0, s);
	}

	/**
	 * 去重，1,2,2,3 得到1,2,3
	 * @return
	 */
	public static String getRemoveStr(String str){
		if(!StringUtils.checkNull(str)){
			String[] userArr=str.split(",");
			List<String> list = new ArrayList<>();
			list.add(userArr[0]);
			for(int i=1;i<userArr.length;i++){
				if(list.toString().indexOf(userArr[i]) == -1){
					list.add(userArr[i]);
				}
			}
			str="";
			for(String temp:list){
				str+=temp+",";
			}
		}
		return str;
	}

	// 根据分页获取 拼接字符串中的数据
	// page 从1开始 即1是第一页 pageSize 为大小
	public static List<String> getPageStr(Integer page,Integer pageSize,String str,String regex){
		List<String> result = new ArrayList<>();

		if(page>0){
			page = page - 1;
		}
		// 计算开始下标和结束下标
		Integer start = page * pageSize;
		Integer end = (page +1) * pageSize;

		// 根据拆分字符 拆分拼接字符串
		String[] split = str.split(regex);

		// 判断整体大小是否小于起始节点 如果小于就直接返回空的集合
		if(split.length<start){
			return result;
		}

		// 判断是否小于结束下标节点 如果小于就进行置换
		if(split.length<end){
			end = split.length;
		}

		// 循环放置
		for (int i = start; i < end; i++) {
			result.add(split[i]);
		}

		return result;
	}


	/**
	 * 过滤HTML标签输出文本
	 *
	 * @param inputString 原字符串
	 * @return 过滤后字符串
	 */
	public static String Html2Text(String inputString) {
		if (org.springframework.util.StringUtils.isEmpty(inputString)) {
			return "";
		}

		// 含html标签的字符串
		String htmlStr = inputString.trim();
		String textStr = "";
		Pattern p_script;
		Matcher m_script;
		Pattern p_style;
		Matcher m_style;
		Pattern p_html;
		Matcher m_html;
		Pattern p_space;
		Matcher m_space;
		Pattern p_escape;
		Matcher m_escape;

		try {
			// 定义script的正则表达式{或<script[^>]*?>[\\s\\S]*?<\\/script>
			String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>";

			// 定义style的正则表达式{或<style[^>]*?>[\\s\\S]*?<\\/style>
			String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>";

			// 定义HTML标签的正则表达式
			String regEx_html = "<[^>]+>";

			// 定义空格回车换行符
			String regEx_space = "\\s*|\t|\r|\n";

			// 定义转义字符
			String regEx_escape = "&.{2,6}?;";

			// 过滤script标签
			p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
			m_script = p_script.matcher(htmlStr);
			htmlStr = m_script.replaceAll("");

			// 过滤style标签
			p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
			m_style = p_style.matcher(htmlStr);
			htmlStr = m_style.replaceAll("");

			// 过滤html标签
			p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
			m_html = p_html.matcher(htmlStr);
			htmlStr = m_html.replaceAll("");

			// 过滤空格回车标签
			p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);
			m_space = p_space.matcher(htmlStr);
			htmlStr = m_space.replaceAll("");

			// 过滤转义字符
			p_escape = Pattern.compile(regEx_escape, Pattern.CASE_INSENSITIVE);
			m_escape = p_escape.matcher(htmlStr);
			htmlStr = m_escape.replaceAll("");

			textStr = htmlStr;

		} catch (Exception e) {
			L.e("StringUtils Html2Text:" + e);
		}

		// 返回文本字符串
		return textStr;
	}


	// 根据设定长度 length 输出字符串数组
	public static String[] stringToStringArray(String str, int length) {
		//检查参数是否合法
		if (checkNull(str)) {
			return null;
		}

		if (length <= 0) {
			return null;
		}
		int n = (str.length() + length - 1) / length; //获取整个字符串可以被切割成字符子串的个数
		String[] split = new String[n];
		for (int i = 0; i < n; i++) {
			if (i < (n - 1)) {
				split[i] = str.substring(i * length, (i + 1) * length);
			} else {
				split[i] = str.substring(i * length);
			}
		}
		return split;
	}

	// 获取url中的参数的值
	public static String getParamByUrl(String url, String name) {
		url += "&";
		String pattern = "(\\?|&){1}#{0,1}" + name + "=[a-zA-Z0-9]*(&{1})";
		Pattern r = Pattern.compile(pattern);
		Matcher matcher = r.matcher(url);
		if (matcher.find()) {
			return matcher.group(0).split("=")[1].replace("&", "");
		} else {
			return "";
		}
	}


}
