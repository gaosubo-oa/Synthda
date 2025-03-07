package com.xoa.dao.wechat;

import com.xoa.model.wechat.WeChatCommentReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by gsb on 2017/10/12.
 */
public interface WeChatCommentReplyMapper {

    int insertWeChatCommentReply(WeChatCommentReply weChatCommentReply);

    List<WeChatCommentReply>  selectWeChatCommentReply(@Param(value = "wid") Integer wid, @Param(value = "cid") Integer cid);

    List<WeChatCommentReply> selectWeChatCommentReplyByCID(@Param(value = "cid") Integer cid);

    List<WeChatCommentReply> selectWeChatCommentReplyByWID (@Param(value = "wid") Integer wid);

    int deleteWeChatCommentReplyByCID(Integer cid);

    int deleteWeChatCommentReplyByWID(Integer wid);

    int deleteByPrimaryKey(Integer rid);

}
