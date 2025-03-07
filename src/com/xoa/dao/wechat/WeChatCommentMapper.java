package com.xoa.dao.wechat;


import com.xoa.model.wechat.WeChatComment;

import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/10/12.
 */
public interface WeChatCommentMapper {

    int insertWeChatComment(WeChatComment weChatComment);

    List<WeChatComment> selectWeChatCommentByWIDPage(Map<String,Object> maps);
    List<WeChatComment> selectWeChatCommentByWID(Integer wid);

    int deleteByPrimaryKey(Integer cid);
    int deleteWeChatCommentByWID(Integer wid);
}
