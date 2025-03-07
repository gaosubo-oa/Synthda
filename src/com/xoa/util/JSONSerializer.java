package com.xoa.util;

import com.alibaba.fastjson.JSON;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;

/**
 * 
 * 创建作者:   张勇
 * 创建日期:   2017-4-20 上午11:16:36
 * 类介绍  :   JSON初始化
 * 构造参数:   
 *
 */
public class JSONSerializer {
	 private static final String DEFAULT_CHARSET_NAME = "UTF-8";

	 /**
	  * 
	  * 创建作者:   张勇
	  * 创建日期:   2017-4-20 上午11:16:46
	  * 方法介绍:   对象转换为json
	  * 参数说明:   @param object
	  * 参数说明:   @return
	  * @return     String
	  */
     public static <T> String serialize(T object) {
         return JSON.toJSONString(object);
     }

     /**
      * 
      * 创建作者:   张勇
      * 创建日期:   2017-4-20 上午11:16:58
      * 方法介绍:   获取json中的对象
      * 参数说明:   @param string
      * 参数说明:   @param clz
      * 参数说明:   @return
      * @return     T
      */
     public static <T> T deserialize(String string, Class<T> clz) {
         return JSON.parseObject(string, clz);
     }

     /**
      * 
      * 创建作者:   张勇
      * 创建日期:   2017-4-20 上午11:17:12
      * 方法介绍:   路径的类转换为对象
      * 参数说明:   @param path
      * 参数说明:   @param clz
      * 参数说明:   @return
      * 参数说明:   @throws IOException
      * @return     T
      */
     public static <T> T load(Path path, Class<T> clz) throws IOException {
         return deserialize(
                 new String(Files.readAllBytes(path), DEFAULT_CHARSET_NAME), clz);
     }

     /**
      * 
      * 创建作者:   张勇
      * 创建日期:   2017-4-20 上午11:17:23
      * 方法介绍:   对象保存为文件
      * 参数说明:   @param path
      * 参数说明:   @param object
      * 参数说明:   @throws IOException
      * @return     void
      */
     public static <T> void save(Path path, T object) throws IOException {
         if (Files.notExists(path.getParent())) {
             Files.createDirectories(path.getParent());
         }
         Files.write(path,
                 serialize(object).getBytes(DEFAULT_CHARSET_NAME),
                 StandardOpenOption.WRITE,
                 StandardOpenOption.CREATE,
                 StandardOpenOption.TRUNCATE_EXISTING);
     }
     
     public static void main(String[] args) {
//         System.out.println(serialize(Object));
     }
     
}
