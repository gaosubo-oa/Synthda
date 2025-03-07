package com.xoa.util.channel;


import com.xoa.dao.smsSettings.SmsSettingsMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.smsSettings.SmsSettings;
import com.xoa.util.channel.httpclient.SDKHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.net.URLEncoder;
import java.util.List;

/**
 *
 * @项目名称：EmayClientForHttpV1.0?
 * @类描述：??
 * @创建人：HL.W??
 * @创建时间：2015-9-9 下午5:29:46??
 * @修改人：HL.W??
 * @修改时间：2015-9-9 下午5:29:46??
 * @修改备注：
 */
@Controller
public class SDKClientTest {

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private UserExtMapper userExtMapper;

    @Resource
    SmsSettingsMapper smsSettingsMapper;
    public  String SendMsg(List<String> mobleList,String model1,String contextString) throws Exception {

        return null;
    }
}
