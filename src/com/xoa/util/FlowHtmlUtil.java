package com.xoa.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.TypeReference;
import com.xoa.util.common.StringUtils;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 创建作者: 刘建
 * 创建日期: 2020-06-22 15:19
 * 方法介绍: 表单工具类
 */
public class FlowHtmlUtil {

    public static void main(String[] args) {
        String htmlContent = "";
        Map map = new HashMap();
        String asd = getAttachment(htmlContent, map);
        System.out.println(asd);
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 15:22
     * 方法介绍: 为表单填充数据
     * @param htmlContent 表单html
     * @param map  表单值
     * @return java.lang.String
     */
    public static String setDocumentData(String htmlContent, Map<String, Object> map) {
        Document document = HtmlUtil.getDom(htmlContent);
        Elements elements = document.getElementsByClass("form_item");
        for (Element element : elements) {
            String dataType = element.attr("data-type");
            String name = element.attr("name");
            String dataNameVal = (String) map.get(name);
            if (!StringUtils.checkNull(dataNameVal)) {
                switch (dataType) {
                    case "text":
                        element.attr("value", dataNameVal);
                        break;
                    case "textarea":
                        element.text(dataNameVal);
                        break;
                }
            }
        }
        return document.html();
    }


    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 15:24
     * 方法介绍: 获取表单的中的附件信息
     * @param htmlContent
     * @param map
     * @return java.lang.String
     */
    public static String getAttachment(String htmlContent, Map map) {
        String formAttachment = "";
        Document document = HtmlUtil.getDom(htmlContent);
        Elements elements = document.getElementsByClass("form_item");
        for (Element element : elements) {
            String dataType = element.attr("data-type");
            String dataNameVal = element.attr("name");
            if (!StringUtils.checkNull(dataNameVal) && "fileupload".equals(dataType)) {
                formAttachment += "*" + map.get(dataNameVal);
            }
        }
        if(formAttachment.length()>1){
            formAttachment = formAttachment.substring(1);
        }
        return formAttachment;
    }

    /**
     * 创建作者: 刘建
     * 创建日期: 2020-06-22 14:53
     * 方法介绍: 提取表单数据
     * @param modifydata
     * @param fromdate
     * @param maps
     * @param num
     * @return java.util.Map<java.lang.Object,java.lang.Object>
     */
    public static Map<Object, Object> queryTriggerField(String modifydata, String fromdate, String maps, Integer num) {
        String[] a = maps.split(",");
        Map<String, Object> map = new HashMap<String, Object>();
        for (int i = 0; i < a.length; i++) {
            String i1 = a[i];
            String i2[] = i1.split("=>");
            String i3 = i2[0];
            String i4 = i2[1];
            map.put(i3, i4);
        }
        JSONArray json = new JSONArray();
        Map<String, Object> from = json.parseObject(
                fromdate, new TypeReference<Map<String, Object>>() {
                });

        List<Map<String, Object>> modify = json.parseObject(modifydata, List.class);
        Map<Object, Object> analysis = new HashMap<Object, Object>();
        Map<Object, Object> returnMap = new HashMap<Object, Object>();
        for (Map<String, Object> mapmodify : modify) {
            for (Map.Entry<String, Object> entry1 : from.entrySet()) {
                if (mapmodify.get("key").equals(entry1.getValue())) {
                    analysis.put(entry1.getKey(), mapmodify.get("value"));
                }
            }
        }

        if ("1".equals(num)) {
            for (Map.Entry<Object, Object> entry : analysis.entrySet()) {
                for (Map.Entry<String, Object> entry1 : map.entrySet()) {
                    if (entry.getKey().equals(entry1.getValue())) {
                        returnMap.put(entry1.getKey(), entry.getValue());
                    }
                }
            }
        }
        for (Map.Entry<Object, Object> entry : analysis.entrySet()) {
            for (Map.Entry<String, Object> entry1 : map.entrySet()) {
                if (entry.getKey().equals(entry1.getKey())) {
                    returnMap.put(entry1.getValue(), entry.getValue());
                }
            }
        }
        return returnMap;
    }

}
