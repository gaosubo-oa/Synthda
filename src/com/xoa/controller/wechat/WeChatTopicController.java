package com.xoa.controller.wechat;

import com.xoa.model.wechat.WeChatTopic;
import com.xoa.service.wechat.WeChatTopic.WeChatTopicService;
import com.xoa.util.ToJson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by gsb on 2017/10/13.
 */
@Controller
@RequestMapping("/weChatTopic")
public class WeChatTopicController {
    @Resource
    private WeChatTopicService weChatTopicService;

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午14:36:17
     * 方法介绍：查询所有社区话题
     * 参数说明：
     */
    @RequestMapping("/selectAllWeChatTopic")
    @ResponseBody
    public ToJson<WeChatTopic> selectAllWeChatTopic(HttpServletRequest request){
        return weChatTopicService.selectAllWeChatTopic();
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-13 下午14:36:17
     * 方法介绍：修改社区话题
     * 参数说明：
     */
    @RequestMapping("/updateWeChatTopic")
    @ResponseBody
    public ToJson<WeChatTopic> updateWeChatTopic(WeChatTopic weChatTopic){
        return weChatTopicService.updateWeChatTopic(weChatTopic);
    }
}
