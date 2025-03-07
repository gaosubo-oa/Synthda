package com.xoa.service.wechat.WeChatComment.impl;

import com.xoa.dao.users.UsersMapper;
import com.xoa.dao.wechat.WeChatCommentMapper;
import com.xoa.dao.wechat.WeChatCommentReplyMapper;
import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatComment;
import com.xoa.model.wechat.WeChatCommentReply;
import com.xoa.service.wechat.WeChatComment.WeChatCommentService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by gsb on 2017/10/13.
 */
@Service
public class WeChatCommentServiceImpl implements WeChatCommentService{
    @Resource
    private WeChatCommentMapper weChatCommentMapper;
    @Resource
    private WeChatCommentReplyMapper weChatCommentReplyMapper;
    @Resource
    private UsersMapper usersMapper;

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
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:30:17
     * 方法介绍：添加微讯评论
     * 参数说明：
     */
    public ToJson<WeChatComment> insertWeChatComment(WeChatComment weChatComment, Users user){
        ToJson<WeChatComment> json = new ToJson<WeChatComment>();
        try {
            int uid = user.getUid();
            String currentTime = String.valueOf(new Date().getTime()/1000);
            int time =Integer.valueOf(currentTime);
            weChatComment.setUid(uid);
            weChatComment.setsTime(time);
            String message = emojiConvert1(weChatComment.getMessage());
            weChatComment.setMessage(message);
            weChatCommentMapper.insertWeChatComment(weChatComment);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");

        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午13:30:17
     * 方法介绍：根据微讯ID 查询微讯评论
     * 参数说明：
     */
    public ToJson<WeChatComment> selectWeChatCommentByWID(Integer wid, Map<String,Object> maps, Integer page,
                                                          Integer pageSize, boolean useFlag){
        ToJson<WeChatComment> json = new ToJson<WeChatComment>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        WeChatComment selectWeChatComment = new WeChatComment();
        selectWeChatComment.setWid(wid);
        maps.put("weChatComment",selectWeChatComment);
        try {
            List<WeChatComment> weChatCommentList = weChatCommentMapper.selectWeChatCommentByWIDPage(maps);
            if (weChatCommentList.size() != 0){
                for(WeChatComment weChatComment : weChatCommentList){
                    List<WeChatCommentReply> weChatCommentReplyList = weChatCommentReplyMapper.selectWeChatCommentReply(wid,weChatComment.getCid());
                    if(weChatCommentReplyList.size() != 0 ){
                        for (WeChatCommentReply weChatCommentReply : weChatCommentReplyList){
                            Users tUser = usersMapper.selectUserByUId(weChatCommentReply.getTid());
                            weChatCommentReply.setToName(tUser.getUserName());
                            weChatCommentReply.setToAvatar(tUser.getAvatar());
                            Users user = usersMapper.selectUserByUId(weChatCommentReply.getUid());
                            weChatCommentReply.setUserName(user.getUserName());
                            weChatCommentReply.setUserAvatar(user.getAvatar());
                            int rTime = weChatCommentReply.getrTime();
                            SimpleDateFormat sformat =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            long lTime = new Long(rTime*1000L);
                            Date date = new Date(lTime);
                            String newTime = sformat.format(date);
                            weChatCommentReply.setTime(newTime);
                            String rMessage = emojiRecovery2(weChatCommentReply.getMessage());
                            weChatCommentReply.setMessage(rMessage);
                        }
                        weChatComment.setWeChatCommentReplyList(weChatCommentReplyList);

                    }else {
                        weChatComment.setWeChatCommentReplyList(weChatCommentReplyList);
                    }
                    Users user = usersMapper.selectUserByUId(weChatComment.getUid());
                    weChatComment.setUserName(user.getUserName());
                    weChatComment.setUserAvatar(user.getAvatar());
                    int rTime = weChatComment.getsTime();
                    SimpleDateFormat sformat =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    long lTime = new Long(rTime*1000L);
                    Date date = new Date(lTime);
                    String newTime = sformat.format(date);
                    weChatComment.setTime(newTime);
                    String cMessage = emojiRecovery2(weChatComment.getMessage());
                    weChatComment.setMessage(cMessage);
                }
            }

            json.setObj(weChatCommentList);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    public ToJson<WeChatComment> deleteByPrimaryKey(Integer cid){
        ToJson<WeChatComment> json = new ToJson<WeChatComment>();
        try {
            weChatCommentMapper.deleteByPrimaryKey(cid);
            List<WeChatCommentReply> weChatCommentReplyList = weChatCommentReplyMapper.selectWeChatCommentReplyByCID(cid);
            if(weChatCommentReplyList.size() != 0) {
                weChatCommentReplyMapper.deleteWeChatCommentReplyByCID(cid);
            }
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
