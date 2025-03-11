package com.xoa.dao.wechat;

import com.xoa.model.wechat.WeChat;

import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/10/12.
 */
public interface WeChatMapper {

    int insertWeChat(WeChat weChat);

    List<WeChat> selectWeChat(Map<String, Object> map);

    int updateWeChatByPrimaryKey(WeChat weChat);

    WeChat selectWeChatByPrimaryKey(Integer wid);

    int deleteByPrimaryKey(Integer wid);


}
