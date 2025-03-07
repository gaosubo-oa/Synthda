package com.xoa.util;

import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.util.common.StringUtils;
import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.dom4j.*;

import java.io.*;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * 视频会议工具类
 */
public class PostVideoUrl {



    //获取用户登录认证
    public static String userpost(String videourl,String companyId){
        if (!StringUtils.checkNull(companyId)) {
            //获取用户登录认证
            Map map2 = new HashMap();
            Map maplemeeting = new HashMap();
            maplemeeting.put("req_type", "1");
            maplemeeting.put("org_id", companyId);
            maplemeeting.put("user", "admin"); //暂时弄成admin,后期修改其他用户
            maplemeeting.put("pass", "21232f297a57a5a743894a0e4a801fc3");
            map2.put("lemeeting", maplemeeting);
            String s = PostVideoUrl.map2Xml(map2);
            return respost(videourl, s);
        }
        return "";
    }

    //获取登录会议参数
    public static String postprepareLoginConf(String videourl,String userpost,String videoConfId){
        if (!StringUtils.checkNull(userpost)){
            Map<String, Object> stringObjectMap = PostVideoUrl.xmlToMap(userpost);
            //获取登录会议参数
            Map map2 = new HashMap();
            Map maplemeeting = new HashMap();
            maplemeeting.put("req_type", "3");
            maplemeeting.put("token", stringObjectMap.get("token"));
            maplemeeting.put("conf_id", videoConfId);
            map2.put("lemeeting", maplemeeting);
            String s2 = PostVideoUrl.map2Xml(map2);
            return respost(videourl, s2);
        }
        return "";
    }

    //返回视频会议信息
    public static void content(MeetingWithBLOBs meeting, Users user, String PostprepareLoginConf){
        Map<String, Object> prepareLoginConf = PostVideoUrl.xmlToMap(PostprepareLoginConf!=null ? PostprepareLoginConf:"");
        //传递map
        Map content = new HashMap();
        content.put("j", prepareLoginConf.get("server_address"));
        content.put("roid", prepareLoginConf.get("org_id"));
        content.put("rid", prepareLoginConf.get("conf_id"));
        content.put("rp", "d41d8cd98f00b204e9800998ecf8427e");
        content.put("rmd", "1");
        content.put("aoid", prepareLoginConf.get("org_id"));
        content.put("a", user.getUserId());
        content.put("n", user.getUserName());
        content.put("sId",meeting.getSid());
        meeting.setVideoContent(content);
    }


    /**
     * (调用)
     * 使用JDK加密md5方式 (toUpperCase()方法转为大写，默认为小写)
     * @param plainText
     * @return String
     */
    public static String md5(String plainText) {
        //定义一个字节数组
        byte[] secretBytes = null;
        try {
            // 生成一个MD5加密计算摘要
            MessageDigest md = MessageDigest.getInstance("MD5");
            //对字符串进行加密
            md.update(plainText.getBytes());
            //获得加密后的数据
            secretBytes = md.digest();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("没有md5这个算法！");
        }
        //将加密后的数据转换为16进制数字
        String md5code = new BigInteger(1, secretBytes).toString(16);
        // 如果生成数字未满32位，需要前面补0
        for (int i = 0; i < 32 - md5code.length(); i++) {
            md5code = "0" + md5code;
        }
        return md5code;
    }

    /**
     * (调用)
     * 发送xml数据请求到server端
     * @param url xml请求数据地址
     * @param xmlString 发送的xml数据流
     * @return null发送失败，否则返回响应内容
     */
    public static String respost(String url, String xmlString){
        //关闭
        System.setProperty("org.apache.commons.logging.Log", "org.apache.commons.logging.impl.SimpleLog");
        System.setProperty("org.apache.commons.logging.simplelog.showdatetime", "true");
        System.setProperty("org.apache.commons.logging.simplelog.log.org.apache.commons.httpclient", "stdout");

        //创建httpclient工具对象
        HttpClient client = new HttpClient();

        //创建post请求方法
        PostMethod myPost = new PostMethod(url);

        client.getParams().setParameter(HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler(0,false));
        //连接超时
        client.getHttpConnectionManager().getParams().setConnectionTimeout(3000);
        //获取数据超时
        client.getHttpConnectionManager().getParams().setSoTimeout(2000);

        String responseString = null;
        try{
            //设置请求头部类型
            myPost.setRequestHeader("Content-Type","text/xml");
            myPost.setRequestHeader("charset","utf-8");

            //设置请求体，即xml文本内容，注：这里写了两种方式，一种是直接获取xml内容字符串，一种是读取xml文件以流的形式
            myPost.setRequestBody(xmlString);
            myPost.setRequestEntity(new StringRequestEntity(xmlString,"text/xml","utf-8"));

            //读取xml文件以流的形式
            /*InputStream body=this.getClass().getResourceAsStream("/"+xmlFileName);
            myPost.setRequestBody(body);*/

            int statusCode = client.executeMethod(myPost);
            if(statusCode == HttpStatus.SC_OK){
                BufferedInputStream bis = new BufferedInputStream(myPost.getResponseBodyAsStream());
                byte[] bytes = new byte[1024];
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                int count = 0;
                while((count = bis.read(bytes))!= -1){
                    bos.write(bytes, 0, count);
                }
                byte[] strByte = bos.toByteArray();
                responseString = new String(strByte,0,strByte.length,"utf-8");
                bos.close();
                bis.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        myPost.releaseConnection();
        return responseString;
    }


    /**
     * 用传统的URI类进行请求
     * @param urlStr
     */
    public static void testPost(String urlStr) {
        try {
            URL url = new URL(urlStr);
            URLConnection con = url.openConnection();
            con.setDoOutput(true);
            //con.setRequestProperty("Pragma:","no-cache");
            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "text/xml");

            OutputStreamWriter out = new OutputStreamWriter(con.getOutputStream());
            String xmlInfo = getXmlInfo(new HashMap<>());
            out.write(new String(xmlInfo.getBytes("UTF-8")));
            out.flush();
            out.close();
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String line = "";
            for (line = br.readLine(); line != null; line = br.readLine()) {
                System.out.println("----------"+line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //单层map转xml
    private static String getXmlInfo(Map<String,Object> map) {
        StringBuilder sb = new StringBuilder();
        sb.append("<?xml version='1.0' encoding='UTF-8'?>");
        sb.append("<lemeeting>");
        for (Map.Entry<String, Object> entry : map.entrySet()){
            sb.append("<"+entry.getKey()+">"+entry.getValue()+"</"+entry.getKey()+">");
        }
        sb.append("</lemeeting>");
        return sb.toString();
    }

    //单层map转xml
    private static String getXmlStr(Map<String,Object> map) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<String, Object> entry : map.entrySet()){
            sb.append("<"+entry.getKey()+">"+entry.getValue()+"</"+entry.getKey()+">");
        }
        return sb.toString();
    }


    /**
     * (调用)
     * xml字符串转为map集合
     * @param xmlStr
     * @return
     */
    public static Map<String, Object> xmlToMap(String xmlStr){
        List<Map<String, String>> resultList = iterateWholeXML(xmlStr);
        Map<String, Object> retMap = new HashMap<String, Object>();
        for (int i = 0; i < resultList.size(); i++) {
            Map<String,Object> map = (Map)resultList.get(i);

            for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
                String key = (String) iterator.next();
                retMap.put(key, map.get(key));

            }
        }
        return retMap;
    }

    /**
     * 递归解析任意的xml 遍历每个节点和属性
     *
     * @param xmlStr
     */
    private static List<Map<String, String>> iterateWholeXML(String xmlStr) {

        List<Map<String, String>> list = new ArrayList();

        try {
            Document document = DocumentHelper.parseText(xmlStr);
            Element root = document.getRootElement();
            recursiveNode(root, list);
            return list;
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 递归遍历所有的节点获得对应的值
     *
     * @param
     */
    private static void recursiveNode(Element root, List<Map<String, String>> list) {

        // 遍历根结点的所有孩子节点
        HashMap<String, String> map = new HashMap();
        for (Iterator iter = root.elementIterator(); iter.hasNext();) {
            Element element = (Element) iter.next();
            if (element == null)
                continue;
            // 获取属性和它的值
            for (Iterator attrs = element.attributeIterator(); attrs.hasNext();) {
                Attribute attr = (Attribute) attrs.next();
                if (attr == null)
                    continue;
                String attrName = attr.getName();
                String attrValue = attr.getValue();

                map.put(attrName, attrValue);
            }
            // 如果有PCDATA，则直接提出
            if (element.isTextOnly()) {
                String innerName = element.getName();
                String innerValue = element.getText();
                map.put(innerName, innerValue);
                list.add(map);
            } else {
                // 递归调用
                recursiveNode(element, list);
            }
        }
    }


    /**
     * (调用)
     * map转换xml字符
     * @param paramMap
     * @return
     */
    public static String map2Xml(Map<String, Object> paramMap) {
        synchronized (PostVideoUrl.class) {
            StringBuilder strBuilder = new StringBuilder();
            strBuilder.append("<?xml version='1.0' encoding='UTF-8' ?>");
            Set<String> objSet = paramMap.keySet();
            for (String key : objSet) {
                if (key == null) {
                    continue;
                }
                strBuilder.append("<").append(key).append(">");
                Object value = paramMap.get(key);
                strBuilder.append(convert(value));
                strBuilder.append("</").append(key).append(">");
            }
            return strBuilder.toString();
        }
    }

    public static String convert(Map map) {
        StringBuilder strBuilder = new StringBuilder();
        for (Object o : map.keySet()) {
            strBuilder.append("<").append(o).append(">");
            strBuilder.append(convert(map.get(o)));
            strBuilder.append("</").append(o).append(">");
        }
        return strBuilder.toString();
    }

    public static String convert(Collection<?> objects) {
        StringBuilder strBuilder = new StringBuilder("");
        for (Object obj : objects) {
            strBuilder.append("<").append(obj).append(">");
            strBuilder.append(convert(obj));
            strBuilder.append("</").append(obj).append(">");
        }
        return strBuilder.toString();
    }

    /**
     * 描述：递归进行转换
     * Created by zjw on 2018-12-11 11:21:37
     *
     * @param object
     * @return String
     */
    public static String convert(Object object) {
        if (object instanceof Map) {
            return convert((Map)object);
        }
        if (object instanceof Collection) {
            return convert((Collection<?>) object);
        }
        StringBuilder strBuilder = new StringBuilder();
        if (isObject(object)) {
            Class<?> clz = object.getClass();
            Field[] fields = clz.getDeclaredFields();

            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();
                Object value;
                try {
                    value = field.get(object);
                } catch (IllegalArgumentException | IllegalAccessException e) {
                    continue;
                }
                strBuilder.append("<").append(fieldName).append("\">");
                if (isObject(value)) {
                    strBuilder.append(convert(value));
                } else {
                    strBuilder.append(value.toString());
                }
                strBuilder.append("</").append(fieldName).append(">");
            }
        } else if (object == null) {
            strBuilder.append("null");
        } else {
            strBuilder.append(object.toString());
        }
        return strBuilder.toString();
    }

    /**
     * 描述：判断是否是对象
     * Created by zjw on 2018-12-11 11:20:48
     *
     * @param obj
     * @return boolean
     */
    private static boolean isObject(Object obj) {
        if (obj == null) return false;
        if (obj instanceof String) return false;
        if (obj instanceof Integer) return false;
        if (obj instanceof Double) return false;
        if (obj instanceof Float) return false;
        if (obj instanceof Byte) return false;
        if (obj instanceof Long) return false;
        if (obj instanceof Character) return false;
        if (obj instanceof Short) return false;
        return !(obj instanceof Boolean);
    }

}
