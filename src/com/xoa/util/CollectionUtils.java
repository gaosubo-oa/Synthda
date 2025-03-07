package com.xoa.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

import java.util.*;

public class CollectionUtils {
    /**
     * 显实定义私有构造函数
     */
    private CollectionUtils(){};

    /**
     * 工作流表单数据转换
     * @param map
     * @return
     */
    public static String mapToString(Map<String,Object> map){
        if(map==null){
            return null;
        }
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> m = null;
        Iterator<Map.Entry<String,Object>> entries = map.entrySet().iterator();
        while (entries.hasNext()) {
            Map.Entry<String,Object> entry = entries.next();
            m = new LinkedHashMap<String, Object>();
            if (entry.getKey().toUpperCase().contains("DATA_")){
                m.put("key",entry.getKey());
                m.put("value",entry.getValue());
                list.add(m);
            }
        }
        String jsonString = JSON.toJSONString(list);
        return jsonString;
    }

    /**
     * json字符串转换map数组(适用于工作流)
     * @author zlf
     * @param jsonString
     * @return
     */
    public static  List<Map<String, String>> JsonStr2MapList( String jsonString)
    {
        List<Map<String,String>> mapList = new ArrayList<Map<String,String>>();
        if(jsonString==null || "".equals(jsonString)){
            return mapList;
        }
         mapList = JSONArray.parseObject(jsonString, List.class);
        Iterator iterator = mapList.iterator();
        while(iterator.hasNext()){
            Map<String,String> map = (Map<String, String>) iterator.next();
            //去除前台传入不符合规定的异常数据
            if (map.size() != 2 || (String) map.get("key") == "") {
                iterator.remove();
            }
        }
        return mapList;
    }





}
