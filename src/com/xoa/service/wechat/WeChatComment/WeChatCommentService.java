package com.xoa.service.wechat.WeChatComment;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.WeChatComment;
import com.xoa.util.ToJson;

import java.util.Map;

/**
 * Created by gsb on 2017/10/13.
 */
public interface WeChatCommentService {

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:30:17
     * 方法介绍：添加微讯评论
     * 参数说明：
     */
    public ToJson<WeChatComment> insertWeChatComment(WeChatComment weChatComment, Users user);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午13:30:17
     * 方法介绍：根据微讯ID 查询微讯评论
     * 参数说明：
     */
    public ToJson<WeChatComment> selectWeChatCommentByWID(Integer wid, Map<String,Object> maps, Integer page,
                                                          Integer pageSize, boolean useFlag);


    public ToJson<WeChatComment> deleteByPrimaryKey(Integer cid);
}
