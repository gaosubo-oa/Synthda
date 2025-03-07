package com.xoa.service.wechat.WeChatCommentReply;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatCommentReply;
import com.xoa.util.ToJson;

/**
 * Created by gsb on 2017/10/13.
 */
public interface WeChatCommentReplyService {

    public ToJson<WeChatCommentReply> insertWeChatCommentReply(WeChatCommentReply weChatCommentReply, Users user);

    public ToJson<WeChatCommentReply>  selectWeChatCommentReply(Integer wid, Integer cid);

    public ToJson<WeChatCommentReply> deleteByPrimaryKey(Integer rid);
}
