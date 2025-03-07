package com.xoa.service.wechat.WeChatCommentReply.impl;

import com.xoa.dao.wechat.WeChatCommentReplyMapper;
import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatCommentReply;
import com.xoa.service.wechat.WeChatCommentReply.WeChatCommentReplyService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by gsb on 2017/10/13.
 */
@Service
public class WeChatCommentReplyServiceImpl implements WeChatCommentReplyService{
    @Resource
    private WeChatCommentReplyMapper weChatCommentReplyMapper;

    //转化
    public static String emojiConvert1(String str)
            throws UnsupportedEncodingException {

        String patternString = "([\\x{10000}-\\x{10ffff}\ud800-\udfff])";

        Pattern pattern = Pattern.compile(patternString);

        Matcher matcher = pattern.matcher(str);

        StringBuffer sb = new StringBuffer();
        while(matcher.find()) {
            try {
                matcher.appendReplacement(
                        sb,
                        "[["
                                + URLEncoder.encode(matcher.group(1),
                                "UTF-8") + "]]");
            } catch(UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        matcher.appendTail(sb);
//        LOG.debug("emojiConvert " + str + " to " + sb.toString()
//                + ", len：" + sb.length());
        return sb.toString();
    }
    //还原
    public static String emojiRecovery2(String str)
            throws UnsupportedEncodingException {
        String patternString = "\\[\\[(.*?)\\]\\]";

        Pattern pattern = Pattern.compile(patternString);
        Matcher matcher = pattern.matcher(str);

        StringBuffer sb = new StringBuffer();
        while(matcher.find()) {
            try {
                matcher.appendReplacement(sb,
                        URLDecoder.decode(matcher.group(1), "UTF-8"));

            } catch(UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        matcher.appendTail(sb);
//        LOG.debug("emojiRecovery " + str + " to " + sb.toString());
        return sb.toString();
    }

    public ToJson<WeChatCommentReply> insertWeChatCommentReply(WeChatCommentReply weChatCommentReply, Users user){
        ToJson<WeChatCommentReply> json = new ToJson<WeChatCommentReply>();
        try {
            int uid = user.getUid();
            String currentTime = String.valueOf(new Date().getTime()/1000);
            int time =Integer.valueOf(currentTime);
            weChatCommentReply.setUid(uid);
            weChatCommentReply.setrTime(time);
            String message = emojiConvert1(weChatCommentReply.getMessage());
            weChatCommentReply.setMessage(message);
            weChatCommentReplyMapper.insertWeChatCommentReply(weChatCommentReply);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    public ToJson<WeChatCommentReply>  selectWeChatCommentReply(Integer wid,Integer cid){
        ToJson<WeChatCommentReply> json = new ToJson<WeChatCommentReply>();
        try {
            List<WeChatCommentReply> weChatCommentReplyList = weChatCommentReplyMapper.selectWeChatCommentReply(wid,cid);
            json.setObj(weChatCommentReplyList);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    public ToJson<WeChatCommentReply> deleteByPrimaryKey(Integer rid){
        ToJson<WeChatCommentReply> json = new ToJson<WeChatCommentReply>();
        try {
            weChatCommentReplyMapper.deleteByPrimaryKey(rid);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
}
