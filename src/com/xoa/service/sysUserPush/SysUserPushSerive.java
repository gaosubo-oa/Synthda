package com.xoa.service.sysUserPush;

import com.tencent.xinge.XingeApp;
import com.xoa.util.ToJson;
import com.xoa.util.sysUserPush.SysUserPush;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * 消息推送
 */

public class SysUserPushSerive extends  SysUserPush{
//    /**
//     * 创建人：陈志才
//     * 创建时间：2017-11-13
//     * 方法说明：单个设备下发透传消息
//     * @param token
//     * @param messagea
//     * @return
//     */
//        public JSONObject demoPushSingleDeviceMessage(String token,Message messagea){
//                return sysUserPush.demoPushSingleDeviceMessage(token,messagea);
//        }
//
//    /**
//     * 创建人：陈志才
//     * 创建时间：2017-11-13
//     * 方法说明：单个设备下发通知消息
//     * @param token
//     * @param messagea
//     * @return
//     */
//        public JSONObject demoPushSingleDeviceNotification(String token,Message messagea){
//                return sysUserPush.demoPushSingleDeviceNotification(token,messagea);
//        }
//
    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     * 安卓端简易推送(单个设备)
     */
    public  JSONObject pushTokenAndroid(int accessId,String secretKey,String title,String content,String token){
             return  XingeApp.pushTokenAndroid(accessId,secretKey,title,content,token);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     * 安卓端简易推送(单个账号)
     * @param accessId  用户ID
     * @param secretKey 用户密匙
     * @param title      标题
     * @param content    内容
     * @param account    接收账号
     * @return
     */
    public JSONObject pushAccountAndroid(long  accessId, String  secretKey, String title, String content, String account){
            return XingeApp.pushAccountAndroid(accessId,secretKey,title,content,account);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     * 安卓端简易推送(多个个账号)
     * @param accessId  用户ID
     * @param secretKey 用户密匙
     * @param title      标题
     * @param content    内容
     * @param account    接收账号数组
     */
    public ToJson pushAccountAndroidSum(Long  accessId, String  secretKey, String title, String content, String []account) throws Exception{
            ToJson json=new ToJson();
            int countYes=0,countNo=0,count=0;
            for(int i=0;i<account.length;i++){
                JSONObject jsonObject= XingeApp.pushAccountAndroid(accessId,secretKey,title,content,account[i]);
                if(jsonObject.get("ret_code").equals("0")){
                    countYes++;
                }else {
                    countNo++;
                }
            }
                count=account.length;
             Map[] map = new Map[3];
             map[1]=new HashMap();
             map[1].put("countYes",countYes);
             map[2]=new HashMap();
             map[2].put("countNo",countNo);
             map[3]=new HashMap();
             map[3].put("count",count);
                json.setObject(map);
        return json;
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     * 安卓端简易推送(全部设备)
     * @param accessId  用户ID
     * @param secretKey 用户密匙
     * @param title      标题
     * @param content    内容
     * @return
     */
    public JSONObject pushAllAndroid(int  accessId, String  secretKey, String  title, String content){
        return XingeApp.pushAllAndroid(accessId,secretKey,title,content);
    }

    /**
     *  创建人：陈志才
     *  创建时间：2017-11-13
     *  推送选中的设备
     * @param accessId  用户ID
     * @param secretKey 用户密匙
     * @param title      标题
     * @param content 消息内容
     * @param tag  接收消息的设备标
     * @return
     */
    public  JSONObject pushTagAndroid(int accessId,String secretKey,String title,String content,String tag){
        return  XingeApp.pushTagAndroid(accessId,secretKey,title,content,tag);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     * IOS平台推送消息给单个设备
     * @param accessId
     * @param secretKey
     * @param content
     * @param token
     * @param environment  （1/2 生产模式/开发模式）
     * @return
     */
    public  JSONObject pushTokenIos(int accessId,String secretKey,String content,String
            token,int environment){
            return XingeApp.pushTokenIos(accessId,secretKey,content,token,environment);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     *  IOS平台推送消息给单个账号
     * @param accessId    目标ID
     * @param secretKey   密匙
     * @param content   消息内容
     * @param account   接收消息账号
     * @param environment （1/2 生产模式/开发模式）
     * @return
     */
    public  JSONObject pushAccountIos(long accessId,String secretKey,String content,String
            account,int environment){
        return XingeApp.pushAccountIos(accessId,secretKey,content,account,environment);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     *  IOS平台推送消息给所有设备
     * @param accessId
     * @param secretKey
     * @param content
     * @param environment
     * @return
     */
    public  JSONObject pushAllIos(int accessId,String secretKey,String content,int
            environment){
        return  XingeApp.pushAllIos(accessId,secretKey,content,environment);
    }

    /**
     * 创建人：陈志才
     * 创建时间：2017-11-13
     *  IOS平台推送消息给标签选中设备
     * @param accessId
     * @param secretKey
     * @param content
     * @param tag
     * @param environment
     * @return
     */
    public  JSONObject pushTagIos(int accessId,String secretKey,String content,String tag,int
            environment){
        return  XingeApp.pushTagIos(accessId,secretKey,content,tag,environment);
    }
}
