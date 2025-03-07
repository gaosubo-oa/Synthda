package com.xoa.global.Xss;

import com.xoa.util.xss.ValidJSONUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {


    private String body;
    private static String[] NO_CHECK_PARAMETER_NAME_LIST = new String[]{};

    private static String[] NO_CHECK_URL_LIST = new String[]{};

    private static List<Pattern> NO_CHECK_URL_PATTERN_LIST = Arrays.stream(NO_CHECK_URL_LIST).map(item -> Pattern.compile(item)).collect(Collectors.toList());

    private static Set<String> notAllowedKeyWords = new HashSet<String>(0);

    static {
        String key = "and|exec|insert|select|delete|update|count|chr|mid|master|truncate|char|declare|or";
        String[] keyStr = key.split("\\|");
        for (String str : keyStr) {
            notAllowedKeyWords.add(str);
        }
    }


    public XssHttpServletRequestWrapper(HttpServletRequest request) {
        super(request);
    }

    @Override
    public String getQueryString() {
        return StringEscapeUtils.escapeHtml4(super.getQueryString());
    }

    @Override
    public Object getAttribute(String name) {
        return super.getAttribute(name);
    }

    /**
     * 重写父类方法
     */
    @Override
    public String getHeader(String name) {
        String value = super.getHeader(name);
        return stripXSS(name, value);
    }

    /**
     * 重写父类方法
     */
    @Override
    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);
        return stripXSS(parameter, value);
    }

    /**
     * 重写父类方法
     */
    @Override
    public String[] getParameterValues(String parameter) {
        String path = super.getServletPath();
        String[] values = super.getParameterValues(parameter);

        // 排除没有请求参数和无需校验的路径
        if (values == null || enableNoCheckURL(NO_CHECK_URL_PATTERN_LIST, path)) {
            return values;
        }

        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = stripXSS(parameter, values[i]);
        }
        return encodedValues;
    }

    /**
     * 过滤参数
     *
     * @param value     参数值
     * @param parameter 参数name名
     * @return
     */
    private String stripXSS(String parameter, String value) {
        String newValue = value;

        if (newValue != null && enableNoCheckParameter(parameter)) {
            // 判断是ue编辑器的参数 如果是的话 直接返回
            if(value.contains("是ue编辑参数的判断字符【暂时未和前端定义】")){
                return newValue;
            }

            // 判断是否存在 ../
            if (!ValidJSONUtils.isJSONValid(newValue)
                    && ("module".equals(parameter) || "company".equals(parameter) || "ym".equals(parameter) || "attachId".equals(parameter) || "attachName".equals(parameter) )
                    && (value.contains("../") || value.contains("..\\") || value.contains("./") || value.contains(".\\"))) {
                //spring的HtmlUtils进行转义
                newValue = "路径错误，不允许使用../格式路径";
            }

            // 判断是否是json格式的参数 不是的话 进行转义防止xss攻击
            newValue = XSSBodyRequestWrapper.stripXSS(newValue);
            //newValue = XssFilterUtil.stripXss(value);
            if (!ValidJSONUtils.isJSONValid(newValue) && (value.contains("<script") || value.contains("alert") || value.contains("console") || value.contains("src") || value.contains("ontoggle"))) {
                //spring的HtmlUtils进行转义
                newValue = HtmlUtils.htmlEscape(value).replaceAll("script","").replaceAll("alert","").replaceAll("console","").replaceAll("ontoggle","");
            }

            // 判断字段中 是否包含sql关键字 防止sql注入
            if (!ValidJSONUtils.isJSONValid(newValue)&&(value.toLowerCase(Locale.ROOT).contains("insert ")||value.toLowerCase(Locale.ROOT).contains("update ")
                    ||value.toLowerCase(Locale.ROOT).contains("delete ")||value.toLowerCase(Locale.ROOT).contains("updatexml")
                    ||value.toLowerCase(Locale.ROOT).contains("database()")||value.toLowerCase(Locale.ROOT).contains("0x7e")
                    ||value.toLowerCase(Locale.ROOT).contains("sleep(")||value.toLowerCase(Locale.ROOT).contains("concat(")
                    ||value.toLowerCase(Locale.ROOT).contains("char(")
            )) {
                // 设置值为空
                newValue = "";
            }

            // 暂时先注释掉转义json格式参数的操作 以免影响接口 需要的时候 可以打开
            /*else {
                //spring的HtmlUtils进行转义
                newValue = HtmlUtils.htmlEscape(value);
            }*/
        }
        return newValue;
    }

    /**
     * 判断name是否应该拦截
     *
     * @param parameter 参数名
     * @return 不拦截返回true，拦截返回false
     */

    private boolean enableNoCheckParameter(String parameter) {
        for (String parameters : NO_CHECK_PARAMETER_NAME_LIST) {
            if (parameter.equals(parameters)) {
                return false;
            }
        }
        return true;
    }

    /**
     * 判断传入的uri是否满足patter
     *
     * @param exclusionPatterns
     * @param uri
     * @return
     */
    public static boolean enableNoCheckURL(List<Pattern> exclusionPatterns, String uri) {
        if (exclusionPatterns != null) {
            uri = uri.trim();
            for (Pattern exclusionPattern : exclusionPatterns) {
                if (isWildCardMatched(uri, exclusionPattern)) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 对指定的文本进行模糊匹配，支持* 和?，不区分大小写
     *
     * @param text    要进行模糊匹配的文本
     * @param pattern 模糊匹配表达式
     * @return
     */
    public static boolean isWildCardMatched(String text, Pattern pattern) {
        Matcher m = pattern.matcher(text);
        return m.matches();
    }

    public static String getBodyString(ServletRequest request) {

        BufferedReader br = null;
        StringBuilder sb = new StringBuilder("");
        try {
            br = request.getReader();
            String str;
            while ((str = br.readLine()) != null) {
                sb.append(str);
            }
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (null != br) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }


    /**
     * 将容易引起xss漏洞的半角字符直接替换成全角字符 在保证不删除数据的情况下保存
     *
     * @param value
     * @return 过滤后的值
     */
    private static String xssEncode(String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("<","&lt;");
        value = value.replaceAll(">","&gt;");
        value = value.replaceAll("'","&apos;");
        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
        value = value.replaceAll("(?i)<script.*?>.*?<script.*?>", "");
        value = value.replaceAll("(?i)<script.*?>.*?</script.*?>", "");
        value = value.replaceAll("(?i)<.*?javascript:.*?>.*?</.*?>", "");
        value = value.replaceAll("(?i)<.*?\\s+on.*?>.*?</.*?>", "");
//        value = value.replaceAll("[<>{}\\[\\];\\&]","");
        return value;
    }


    public boolean checkSqlKeyWords(String value) {
        String paramValue = value;
        for (String keyword : notAllowedKeyWords) {
            if (paramValue.length() > keyword.length() + 4
                    && (paramValue.contains(" " + keyword) || paramValue.contains(keyword + " ") || paramValue.contains(" " + keyword + " "))) {
                return true;
            }
        }
        return false;
    }
}  