package com.xoa.service.wechat.WeChatTopic;

import com.xoa.model.wechat.WeChatTopic;
import com.xoa.util.ToJson;

/**
 * Created by gsb on 2017/10/13.
 */
public interface WeChatTopicService {

    public ToJson<WeChatTopic> selectAllWeChatTopic();

    public ToJson<WeChatTopic> updateWeChatTopic(WeChatTopic weChatTopic);
}
