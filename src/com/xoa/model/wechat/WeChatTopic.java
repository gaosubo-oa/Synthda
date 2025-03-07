package com.xoa.model.wechat;

/**
 * Created by gsb on 2017/10/12.
 */
public class WeChatTopic {

    private Integer topicId;//话题自增ID

    private String topicName;//话题名称

    private String takerUIds;//参与该话题的UID串

    private Integer count;//话题次数

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public String getTakerUIds() {
        return takerUIds;
    }

    public void setTakerUIds(String takerUIds) {
        this.takerUIds = takerUIds;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }
}
