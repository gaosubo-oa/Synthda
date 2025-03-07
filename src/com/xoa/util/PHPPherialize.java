package com.xoa.util;

import de.ailis.pherialize.MixedArray;
import de.ailis.pherialize.Pherialize;

import java.util.*;

/**
* @创建作者:李然  Lr
* @方法描述：将php序列化的数组反序列化。
* @创建时间：13:23 2018/8/1

**/
public class PHPPherialize {

    private static final String zn="[\\u4e00-\\u9fa5]+";

    //返回一个键值数组
    public static List getListByData(String data){
        String db=data;
        MixedArray list;
        try {
            data =shiftPHP(data);
            list = Pherialize.unserialize(data).toArray();
        } catch (Exception e) {
            list=Pherialize.unserialize(db).toArray();
            e.printStackTrace();
        }
        List list2=new ArrayList();
        for(int i = 0; i<= list.size(); i++) {
            if(list.get(i)!=null) {
                String cc=list.get(i).toString().substring(1, list.get(i).toString().length() - 1);
                list2.add(cc);
            }

        }
        return list2;
    }

    //反序列化PHP存入的序列化数组
    public static String shiftPHP(String str){
        StringBuilder cn=new StringBuilder(str);
        int strSize=0;//参数的大小
        int begin;//起始的冒号
        int end;//终止冒号
        int i=0;
        for(i=0;i<cn.length();i++){
            //获取第一次出现双""的位置i
            if(cn.charAt(i)=='"'){
                for(int j=i+1;j<cn.length();j++){
                    //获取第二次冒号出现的位置j
                    if(cn.charAt(j)=='"'){
                        if(j==(i+1)){i=j+1;break;}
                        else{
                            //parameter为""之间的参数
                            String parameter = cn.substring(i+1, j);
                            strSize=strTypeSize(parameter);
                            for(int c=i-1;c>0;c--){
                                //找到第一个：因为是倒序查找，所以第一个找到的反而是end
                                if(cn.charAt(c)==':'){
                                    end=c;
                                    //end已经是：了，所以要从end的前一位开始遍历
                                    for(int d=end-1;d>0;d--){
                                        //begin
                                        if(cn.charAt(d)==':'){
                                            begin=d;
                                            cn=cn.replace(begin+1, end, strSize+"");
                                            i=j+1;
                                            break;
                                        }
                                    }
                                    break;
                                }

                            }
                        }
                        break;
                    }
                }
            }
        }

        return cn.toString();
    }

    //判断一个字符是否是中文
    public static boolean isChinese(char c) {
        return c >= 0x4E00 &&  c <= 0x9FA5;// 根据字节码判断
    }

    //""之间的字符串的长度
    public static Integer strTypeSize(String str){
        int strSize=0;
        for(int i=0;i<str.length();i++){
            if(isChinese(str.charAt(i))){
                strSize=strSize+3;
            }else{
                strSize++;
            }
        }
        return strSize;
    }

}
