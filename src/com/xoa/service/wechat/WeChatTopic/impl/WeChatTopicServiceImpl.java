package com.xoa.service.wechat.WeChatTopic.impl;

import com.xoa.dao.wechat.WeChatTopicMapper;
import com.xoa.model.wechat.WeChatTopic;
import com.xoa.service.wechat.WeChatTopic.WeChatTopicService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by gsb on 2017/10/13.
 */
@Service
public class WeChatTopicServiceImpl implements WeChatTopicService {
    @Resource
    private WeChatTopicMapper weChatTopicMapper;

    public ToJson<WeChatTopic> selectAllWeChatTopic(){
        ToJson<WeChatTopic> json = new ToJson<WeChatTopic>();
        try {
            List<WeChatTopic> weChatTopicList = weChatTopicMapper.selectAllWeChatTopic();
            json.setObj(weChatTopicList);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");

        }
        return json;
    }
    public ToJson<WeChatTopic> updateWeChatTopic(WeChatTopic weChatTopic){
        ToJson<WeChatTopic> json = new ToJson<WeChatTopic>();
        try {
            weChatTopicMapper.updateWeChatTopic(weChatTopic);
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
