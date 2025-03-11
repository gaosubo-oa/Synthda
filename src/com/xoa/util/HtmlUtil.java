package com.xoa.util;

import com.xoa.util.common.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zlf
 * @version 1.0
 * //java的html解析器jsoup.jar解析html工具类，参考lr编写代码整理成此工具类
 */
public class HtmlUtil {
    /**
     * 传入html解析成Document实例对象
     * @param htmlModel html
     * @return 表单文本对象
     */
    public static Document getDom(String htmlModel){
        Document document = null;
        if(!StringUtils.checkNull(htmlModel)){
            //解析html
            document= Jsoup.parse(htmlModel);
        }
        return document;
    }

    /**
     * 传入html和对象表单上标题title（汉字）获取指定对象表单上的name属性（DATA_?）
     * @param document 文本对象
     * @param str 传入表单上汉字
     * @return 返回表单对象上name属性
     */
    public static String getDocumentName(Document document,String str){
        //默认表单上title属性无重复
        String name=null;
        if(!StringUtils.checkNull(str)){
            Elements elements = document.select("[title="+str+"]");
            if(elements.size()>0) {
                name = elements.get(0).attr("name");
            }
        }
        return name;
    }

    /**
     * 传入html和对象表单上name属性（DATA_?）获取指定对象表单上的标题title（汉字） 不支持name重复
     * @param document 表单文本对象
     * @param str   表单name属性
     * @return  返回表单对应汉字
     */
    public static String getDocumentTitle(Document document,String str){
        //默认表单上name属性无重复
        Elements elements = document.select("[name="+str+"]");
        String title=null;
        if(elements.size()>0) {
            title = elements.get(0).attr("title");
        }
        return title;
    }


    /**
     * 传入html和对象表单上name属性（DATA_?）获取指定对象表单上的dataType 不支持name重复
     * @param document 表单文本对象
     * @param str   表单name属性
     * @return  返回表单对应dataType
     */
    public static String getDocumentDataType(Document document,String str){
        //默认表单上name属性无重复
        Elements elements = document.select("[name="+str+"]");
        String dataType=null;
        if(elements.size()>0) {
            dataType = elements.get(0).attr("data-type");
        }
        return dataType;
    }


    /**
     * @创建作者:李然 Lr
     * @方法描述：返回所有字段，data_xx
     * @创建时间：10:08 2019/6/03
     **/
    public static List<String> getAllData(Document d) {
        Elements e = d.select("[name^=DATA_]");
        if(e.size()==0){
            e=d.select("[name^='data_']");
        }
        String v;
        List <String> vs = new ArrayList<>();
        if (e.size() > 0) {
            for (int i = 0; i < e.size(); i++) {
                v = e.get(i).attr("name");
                vs.add(v);
            }
        }
        return vs;
    }

    /**
     * 获取表单上所有字段名称
     * @param document  文本对象模型
     * @return
     */
    public static List<String> getAllDocumentName(Document document) {
        Elements e = document.select("[title]");
        String v;
        List <String> vs = new ArrayList<>();
        if (e.size() > 0) {
            for (int i = 0; i < e.size(); i++) {
                v = e.get(i).attr("title");
                vs.add(v);
            }
        }
        return vs;
    }

    public static Map<String,Object> getAllDocument(String htmlModel) {
        Document document = HtmlUtil.getDom(htmlModel);
        Map<String,Object> map = new HashMap<String, Object>();
        Elements e = document.select("[title]");
        String v;
        String d;
        List <String> vs = new ArrayList<>();
        if (e.size() > 0) {
            for (int i = 0; i < e.size(); i++) {
                d=e.get(i).attr("name");
                v = e.get(i).attr("title");
                map.put(d,v);
            }
        }
        return map;
    }
}
