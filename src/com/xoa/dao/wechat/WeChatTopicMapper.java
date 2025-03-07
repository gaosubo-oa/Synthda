package com.xoa.dao.wechat;

import com.xoa.model.wechat.WeChatTopic;

import java.util.List;

/**
 * Created by gsb on 2017/10/12.
 */
public interface WeChatTopicMapper {

    List<WeChatTopic> selectAllWeChatTopic();

    int updateWeChatTopic(WeChatTopic weChatTopic);
}
