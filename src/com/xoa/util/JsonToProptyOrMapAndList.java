package com.xoa.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import java.util.List;
import java.util.Map;

/**
 * 创建作者:   张勇
 * 创建日期:   2017/6/28 14:50
 * 类介绍  :
 * 构造参数:
 */
public class JsonToProptyOrMapAndList {

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/28 14:51
     * 方法介绍:   获取前台json数据转换为List<Map>型
     * 参数说明:   propty 获取json数据 传递类型：[{},{}.....]
     *  @return
     */
    public static List<Map<String,Object>> protyString(String propty){
        return JSON.parseObject(propty, new TypeReference<List<Map<String, Object>>>(){});
    }

    /**
     * 创建作者:   张勇
     * 创建日期:   2017/6/28 14:51
     * 方法介绍:   获取前台json数据转换为Map<String,Object>型
     * 参数说明:  propty 获取json数据 传递类型：{k:v,k:v.....}
     * @return
     */
    public  static Map<String,Object> returnMaps(String porpty){
        return JSON.parseObject(porpty, Map.class);
    }

}
