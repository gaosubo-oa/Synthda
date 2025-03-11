package com.xoa.util.sysUserPush;

import com.tencent.xinge.*;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class SysUserPush {

    //单个设备下发透传消息
    public JSONObject demoPushSingleDeviceMessage(String token,Message messagea) {
//        Message message = new Message();
//        message.setTitle("title");
//        message.setContent("content");
            messagea.setType(Message.TYPE_MESSAGE);
//        message.setExpireTime(86400);
        JSONObject ret = xinge.pushSingleDevice(token, messagea);
        return ret;
    }


    //单个设备下发通知消息
    public JSONObject demoPushSingleDeviceNotification(String token,Message messagea) {
        JSONObject ret = xinge.pushSingleDevice(token, messagea);
        return ret;
    }

    //单个设备下发通知Intent
    //setIntent()的内容需要使用intent.toUri(Intent.URI_INTENT_SCHEME)方法来得到序列化后的Intent(自定义参数也包含在Intent内）
    //终端收到后可通过intent.parseUri()来反序列化得到Intent
    public JSONObject demoPushSingleDeviceNotificationIntent(String token,Message messagea) {
        JSONObject ret = xinge.pushSingleDevice(token, messagea);
        return ret;
    }

    //单个设备静默通知(iOS7以上)
    public JSONObject demoPushSingleDeviceMessageIOS(String token,MessageIOS messageIOS) {
        MessageIOS remoteMessageIOS = new MessageIOS();
        remoteMessageIOS.setType(MessageIOS.TYPE_REMOTE_NOTIFICATION);
        return xinge.pushSingleDevice(token, messageIOS, XingeApp.IOSENV_PROD);
    }

    //单个设备下发通知消息iOS
    public JSONObject demoPushSingleDeviceNotificationIOS(TimeInterval acceptTime1,Map<String, Object> custom,String token) {
        MessageIOS messageIOS=new MessageIOS();
        messageIOS.addAcceptTime(acceptTime1);
        custom.put("key1", "value1");
        custom.put("key2", 2);
        messageIOS.setCustom(custom);
        JSONObject ret = xinge.pushSingleDevice(token, messageIOS, XingeApp.IOSENV_PROD);
        return ret;
    }

    //下发单个账号
    public JSONObject demoPushSingleAccount(String account, Message message) {
        message.setType(Message.TYPE_MESSAGE);
        JSONObject ret = xinge.pushSingleAccount(0, account, message);
        return ret;
    }

    //下发多个账号
    public JSONObject demoPushAccountList( List<String> accountList,Message message) {
        message.setType(Message.TYPE_MESSAGE);
        JSONObject ret = xinge.pushAccountList(0, accountList, message);
        return ret;
    }

    //下发IOS单个账号
    public JSONObject demoPushSingleAccountIOS(String account,MessageIOS messageios,TimeInterval acceptTime1) {
        messageios.addAcceptTime(acceptTime1);
        JSONObject ret = xinge.pushSingleAccount(0, account, messageios, XingeApp.IOSENV_PROD);
        return ret;
    }

    //下发IOS多个账号
    public JSONObject demoPushAccountListIOS(List<String> accountList,MessageIOS messageIos) {
        JSONObject ret = xinge.pushAccountList(0, accountList, messageIos, XingeApp.IOSENV_PROD);
        return ret;
    }

    //下发所有设备
    public JSONObject demoPushAllDevice(Message message) {
        JSONObject ret = xinge.pushAllDevice(0, message);
        return ret;
    }

    //下发标签选中设备
    public JSONObject demoPushTags( List<String> tagList,Message message) {
        JSONObject ret = xinge.pushTags(0, tagList, "OR", message);
        return ret;
    }

    //大批量下发给帐号 // iOS 请构造MessageIOS消息
    public JSONObject demoPushAccountListMultiple(Message message) throws JSONException {
        message.setType(Message.TYPE_NOTIFICATION);

        JSONObject ret = xinge.createMultipush(message);
        if (ret.getInt("ret_code") != 0)
            return ret;
        else {
            JSONObject result = new JSONObject();

            List<String> accountList1 = new ArrayList<String>();
            accountList1.add("joelliu1");
            accountList1.add("joelliu2");
            // ...
            result.append("all", xinge.pushAccountListMultiple(ret.getJSONObject("result").getLong("push_id"), accountList1));

            List<String> accountList2 = new ArrayList<String>();
            accountList2.add("joelliu3");
            accountList2.add("joelliu4");
            // ...
            result.append("all", xinge.pushAccountListMultiple(ret.getJSONObject("result").getLong("push_id"), accountList2));
            return result;
        }
    }

    //大批量下发给设备 // iOS 请构造MessageIOS消息
    public JSONObject demoPushDeviceListMultiple()  throws JSONException{
        Message message = new Message();
        message.setExpireTime(86400);
        message.setTitle("title");
        message.setContent("content");
        message.setType(Message.TYPE_NOTIFICATION);

        JSONObject ret = xinge.createMultipush(message);
        if (ret.getInt("ret_code") != 0)
            return ret;
        else {
            JSONObject result = new JSONObject();

            List<String> deviceList1 = new ArrayList<String>();
            deviceList1.add("joelliu1");
            deviceList1.add("joelliu2");
            // ...
            result.append("all", xinge.pushDeviceListMultiple(ret.getJSONObject("result").getLong("push_id"), deviceList1));

            List<String> deviceList2 = new ArrayList<String>();
            deviceList2.add("joelliu3");
            deviceList2.add("joelliu4");
            // ...
            result.append("all", xinge.pushDeviceListMultiple(ret.getJSONObject("result").getLong("push_id"), deviceList2));
            return result;
        }
    }

    //查询消息推送状态
    public JSONObject demoQueryPushStatus(List<String> pushIdList) {
        JSONObject ret = xinge.queryPushStatus(pushIdList);
        return ret;
    }

    //查询设备数量
    public JSONObject demoQueryDeviceCount() {
        JSONObject ret = xinge.queryDeviceCount();
        return ret;
    }

    //查询标签
    public JSONObject demoQueryTags() {
        JSONObject ret = xinge.queryTags();
        return ret;
    }

    //查询某个tag下token的数量
    public JSONObject demoQueryTagTokenNum(String tag) {
        JSONObject ret = xinge.queryTagTokenNum(tag);
        return ret;
    }

    //查询某个token的标签
    public JSONObject demoQueryTokenTags(String token) {
        JSONObject ret = xinge.queryTokenTags(token);
        return ret;
    }

    //取消定时任务
    public JSONObject demoCancelTimingPush(String pushld) {
        JSONObject ret = xinge.cancelTimingPush(pushld);
        return ret;
    }

    // 设置标签
    public JSONObject demoBatchSetTag( List<TagTokenPair> pairs) {
        // 切记把这里的示例tag和示例token修改为你的真实tag和真实token
//        pairs.add(new TagTokenPair("tag1", "token00000000000000000000000000000000001"));
//        pairs.add(new TagTokenPair("tag2", "token00000000000000000000000000000000001"));
        JSONObject ret = xinge.BatchSetTag(pairs);
        return ret;
    }

    // 删除标签
    public JSONObject demoBatchDelTag(List<TagTokenPair> pairs) {
        // 切记把这里的示例tag和示例token修改为你的真实tag和真实token
//        pairs.add(new TagTokenPair("tag1", "token00000000000000000000000000000000001"));
//        pairs.add(new TagTokenPair("tag2", "token00000000000000000000000000000000001"));
        JSONObject ret = xinge.BatchDelTag(pairs);
        return ret;
    }
    //查询某个token的信息
    public JSONObject demoQueryInfoOfToken(String token) {
        JSONObject ret = xinge.queryInfoOfToken(token);
        return ret;
    }

    //查询某个account绑定的token
    public JSONObject demoQueryTokensOfAccount(String nickName) {
        JSONObject ret = xinge.queryTokensOfAccount(nickName);
        return ret;
    }

    //删除某个account绑定的token
    public JSONObject demoDeleteTokenOfAccount(String nickName,String token) {
        JSONObject ret = xinge.deleteTokenOfAccount(nickName, token);
        return ret;
    }

    //删除某个account绑定的所有token
    public JSONObject demoDeleteAllTokensOfAccount(String nickName) {
        JSONObject ret = xinge.deleteAllTokensOfAccount(nickName);
        return ret;
    }

//    public void buildMesssges() {
//        message1 = new Message();
//        message1.setType(Message.TYPE_NOTIFICATION);
//        Style style = new Style(1);
//        style = new Style(3, 1, 0, 1, 0);
//        ClickAction action = new ClickAction();
//        action.setActionType(ClickAction.TYPE_URL);
//        action.setUrl("http://xg.qq.com");
//        Map<String, Object> custom = new HashMap<String, Object>();
//        custom.put("key1", "value1");
//        custom.put("key2", 2);
//        message1.setTitle("title");
//        message1.setContent("大小");
//        message1.setStyle(style);
//        message1.setAction(action);
//        message1.setCustom(custom);
//        TimeInterval acceptTime1 = new TimeInterval(0, 0, 23, 59);
//        message1.addAcceptTime(acceptTime1);
//
//        message2 = new Message();
//        message2.setType(Message.TYPE_NOTIFICATION);
//        message2.setTitle("title");
//        message2.setContent("通知点击执行Intent测试");
//        style = new Style(1);
//        action = new ClickAction();
//        action.setActionType(ClickAction.TYPE_INTENT);
//        action.setIntent("intent:10086#Intent;scheme=tel;action=android.intent.action.DIAL;S.key=value;end");
//        message2.setStyle(style);
//        message2.setAction(action);
//
//        messageIOS = new MessageIOS();
//        messageIOS.setType(MessageIOS.TYPE_APNS_NOTIFICATION);
//        messageIOS.setExpireTime(86400);
//        messageIOS.setAlert("ios test");
//        messageIOS.setBadge(1);
//        messageIOS.setCategory("INVITE_CATEGORY");
//        messageIOS.setSound("beep.wav");
//    }

//    public SysUserPush() {
//        XingeApp xinge = new XingeApp(000, "secret_key");
//        buildMesssges();
//    }

    private XingeApp xinge;
    private Message message1;
}
