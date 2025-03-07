package com.xoa.service.wechat.weChat;

import com.xoa.model.users.Users;
import com.xoa.model.wechat.LikeUser;
import com.xoa.model.wechat.WeChat;
import com.xoa.util.ToJson;

import java.util.Map;

/**
 * Created by gsb on 2017/10/12.
 */
public interface WeChatService {
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午9:46:17
     * 方法介绍：添加一条微讯信息
     * 参数说明：
     */
    public ToJson<WeChat> insertWeChat(WeChat weChat, Users user);
    /**
     * 创建作者:   季佳伟
     * 创建日期:   2017年10月13日 上午09:48:12
     * 方法介绍:   查询所有微讯  并分页
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize  页面大小
     * 参数说明:   @param useFlag  是否开启分页
     * 参数说明:   @return
     */
    public ToJson<WeChat> selectWeChat(Map<String, Object> maps, Integer page,
                                       Integer pageSize, boolean useFlag, String sqlType,Users users);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 上午11:46:17
     * 方法介绍：根据主键修改微讯
     * 参数说明：
     */
    public ToJson<WeChat> updateWeChatByPrimaryKey(Integer wid, Users user);

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-16 上午11:46:17
     * 方法介绍：根据主键查询微讯
     * 参数说明：
     */

   public ToJson<WeChat> selectWeChatByPrimaryKey(Integer wid, String sqlType);

    public ToJson<WeChat> deleteByPrimaryKey(Integer wid);

    public ToJson<LikeUser> getLikeUser(Integer wid);


}
