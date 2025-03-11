package com.xoa.util.common;

import com.alibaba.fastjson.JSONObject;
import org.phprpc.util.AssocArray;
import org.phprpc.util.Cast;
import org.phprpc.util.PHPSerializer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by pfl on 2017/9/27.
 */
public class PHPSerializerUtils {
    /**
     * 将php序列化数据，转化成JSON数据（通达代码兼容）
     * @param phpStr
     * @return
     */
    public static String unSerializer(String phpStr){
        PHPSerializer p = new PHPSerializer();
        String result=null;
        Map<String,AssocArray> map=null;
        if(StringUtils.checkNull(phpStr)){
            return null;
        }
        try {
            AssocArray array = (AssocArray) p.unserialize(phpStr.getBytes());
            map =  array.toHashMap();
            if(map==null||map.size()==0){
                return phpStr;
            }
            Map<String,Object> resultMap=new HashMap<String,Object>();
            for(Map.Entry<String,AssocArray> entry:map.entrySet()){
                List<String> list =new ArrayList<>();
                entry.getKey();
                AssocArray arrayValue=  entry.getValue();
                for (int i = 0; i < array.size(); i++) {
                    String t = (String) Cast.cast(arrayValue.get(i), String.class);
                    list.add(t);
                }
                resultMap.put(entry.getKey(),list);
            }
            JSONObject jsonObject =new JSONObject(resultMap);
            result=jsonObject.toJSONString();
        }catch (Exception e){
            e.printStackTrace();
//            System.out.println("反序列化PHPmap: " + phpStr + " 失败！！！" );
        }
        return result;
    }

}
