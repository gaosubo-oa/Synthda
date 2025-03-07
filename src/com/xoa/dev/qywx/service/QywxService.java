package com.xoa.dev.qywx.service;

import com.baomidou.mybatisplus.toolkit.CollectionUtils;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.qiyeWeixin.QiyeWeixinConfigMapper;
import com.xoa.dao.qiyeWeixin.UserWeixinqyMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.dev.qywx.model.QywxUser;
import com.xoa.model.department.Department;
import com.xoa.model.modulePriv.ModulePriv;
import com.xoa.model.qiyeWeixin.QiyeWeixinConfig;
import com.xoa.model.qiyeWeixin.QiyeWeixinSetting;
import com.xoa.model.qiyeWeixin.UserWeixinqy;
import com.xoa.model.qiyeWeixin.UserWeixinqyExample;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.qyweixin.QiyeWeixinService;
import com.xoa.service.users.UsersService;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.http.HttpClientUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.*;


@Service
public class QywxService {


    // 企业微信配置service
    @Autowired
    private QiyeWeixinService qywxConfigService;

    @Autowired
    private UserWeixinqyMapper userWeixinqyMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private QiyeWeixinConfigMapper qiyeWeixinConfigMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private UserPrivMapper userPrivMapper;

    @Autowired
    private UsersService usersService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private QiyeWeixinService qiyeWeixinService;


    // -------------------------变量区---------------------------- //

    // 企业凭证
    private String ACCESS_TOKEN = "";
    // 第三方应用凭证（suite_access_token）
    private String SUITE_ACCESS_TOKEN = "";
    // 第三方应用suite_ticket
    private String SUITE_TICKET = "";

    // 通讯录token
    private String ADDRESS_ACCESS_TOKEN = "";

    // 企业微信设置 两小时刷新一次
    QiyeWeixinConfig qiyeWeixinConfig = null ;

    // accessToken 生成时间（两个小时有效期
    private Long accessToken_TimeLimit = new Date().getTime();
    // suiteAccessToken 生成时间（两个小时有效期
    private Long suiteAccessToken_TimeLimit = new Date().getTime();

    // 存储单个应用的token的map  key是模块的menuId value 存储的token和token过期时间
    private Map<String,Object> tokenMap = new HashMap<>();

    // 存储单个应用的应用设置 key
    private Map<String,Object> configMap = new HashMap<>();




    // -------------------------变量区---------------------------- //


    public String getAccessToken(){
        Long CurTimeLimit = new Date().getTime();
        if(ACCESS_TOKEN == "" || (CurTimeLimit-accessToken_TimeLimit)/1000 >7000){
            QiyeWeixinConfig qiyeWeixinConfig = qiyeWeixinConfigMapper.selectConfig();
            JSONObject res = HttpClientUtil.httpGet(qiyeWeixinConfig.getApiDomain()+"/cgi-bin/gettoken?corpid="+qiyeWeixinConfig.getCorpid()+"&corpsecret="+qiyeWeixinConfig.getCorpsecret());
            if((Integer)res.get("errcode") == 0){
                ACCESS_TOKEN = (String) res.get("access_token");
            }
        }
        return ACCESS_TOKEN;
    }

    public String getAccessToken(String menuUrl){
        String accessToken = "";
        long accessToken_timeLimit=0;
        if(!StringUtils.checkNull(menuUrl)){
            JSONObject jsonObject = (JSONObject) tokenMap.get(menuUrl);
            if(jsonObject!=null){
                accessToken = jsonObject.getString("accessToken");
                accessToken_timeLimit = jsonObject.getLong("accessToken_timeLimit");
            }

            long curTimeLimit = new Date().getTime();
            if((jsonObject==null || StringUtils.checkNull(accessToken) || (curTimeLimit-accessToken_timeLimit)/1000 >7000) && !Objects.isNull(getConfig(menuUrl))){
                jsonObject = new JSONObject();
                JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/gettoken?corpid="+getConfig().getCorpid()+"&corpsecret="+getConfig(menuUrl).getSecret());
                if((Integer)res.get("errcode") == 0){
                    accessToken = (String) res.get("access_token");
                    jsonObject.put("accessToken",accessToken);
                    jsonObject.put("accessToken_timeLimit",curTimeLimit);
                    tokenMap.put(menuUrl,jsonObject);
                }
            }
        }

        return accessToken;
    }

    public String getAddressAccessToken(){
        Long CurTimeLimit = new Date().getTime();
        if(ADDRESS_ACCESS_TOKEN == "" || (CurTimeLimit-accessToken_TimeLimit)/1000 >7000){
            QiyeWeixinConfig qiyeWeixinConfig = qiyeWeixinConfigMapper.selectConfig();
            JSONObject res = HttpClientUtil.httpGet(qiyeWeixinConfig.getApiDomain()+"/cgi-bin/gettoken?corpid="+qiyeWeixinConfig.getCorpid()+"&corpsecret="+qiyeWeixinConfig.getAddressSecret());
            if((Integer)res.get("errcode") == 0){
                ADDRESS_ACCESS_TOKEN = (String) res.get("access_token");
            }
        }
        return ADDRESS_ACCESS_TOKEN;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取SUITE_ACCESS_TOKEN 用于第三方应用授权等接口调用
     */
    public String getSuiteAccessToken(){
        // 获取数据库中的配置信息 获取suite_id suite_secret
        BaseWrapper configBaseWrapper = qywxConfigService.getQiyeWeixinConfig();
        QiyeWeixinConfig data = (QiyeWeixinConfig) configBaseWrapper.getData();

        Long CurTimeLimit = new Date().getTime();
        if(SUITE_ACCESS_TOKEN == "" || (CurTimeLimit-suiteAccessToken_TimeLimit)/1000 >7000){
            JSONObject res = HttpClientUtil.httpGet(data.getApiDomain()+"/cgi-bin/service/get_suite_token?suite_id="+data.getSuiteId()+"&suite_secret="+data.getSuiteSecret()+"&suite_ticket="+SUITE_TICKET);
            if((Integer)res.get("errcode") == 0){
                SUITE_ACCESS_TOKEN = (String) res.get("suite_access_token");
            }
        }
        return SUITE_ACCESS_TOKEN;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取suiteTicket 用于接收服务器中推送的suiteTicket
     */
    public void receiveSuiteTicket(String SuiteId,String InfoType,String TimeStamp,String SuiteTicket){

        if(!StringUtils.checkNull(SuiteTicket)){
            SUITE_TICKET = SuiteTicket;
        }

    }

    public JSONObject getWxUserByCode(String code,String menuUrl){
        JSONObject res = null;
        if(!StringUtils.checkNull(code)){
            if(StringUtils.checkNull(menuUrl)){
                res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/user/getuserinfo?access_token="+getAccessToken()+"&code="+code);
            } else {
                res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/user/getuserinfo?access_token="+getAccessToken(menuUrl)+"&code="+code);
            }
        }
        return res;
    }

    public String getJsapiTicket(){
        JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/get_jsapi_ticket?access_token="+getAccessToken());
        if((Integer)res.get("errcode") == 0){
            return (String) res.get("ticket");
        }
        return "";
    }

    public String getJsapiTicket(String menuUrl){
        JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/get_jsapi_ticket?access_token="+getAccessToken(menuUrl));
        if((Integer)res.get("errcode") == 0){
            return (String) res.get("ticket");
        }
        return "";
    }

    public String getJsapiTicketByagent(){
        JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/ticket/get?access_token="+getAccessToken()+"&type=agent_config");
        if((Integer)res.get("errcode") == 0){
            return (String) res.get("ticket");
        }
        return "";
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 企业微信授权登陆 (进行中，未完成，完成后删除这条信息)
     */
    public JSONObject OAuth2Login(String code){
        JSONObject res = null;

        if(!StringUtils.checkNull(code)){

            // 获取suiteAccessToken
            String suiteAccessToken = getSuiteAccessToken();

            // 获取当前登陆用户信息
            res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/service/getuserinfo3rd?access_token="+suiteAccessToken+"&code="+code);

            if((Integer)res.get("errcode")==0){

                return res;
            }
        }

        return res;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取企业微信中的部门信息 id为部门id 填写获取指定部门 不填写获取全部部门
     */
    public JSONObject getDepartments(String id){
        if(id==null||id.equals("0"))
            return HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/department/list?access_token=" + getAccessToken());
        return HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/department/list?access_token=" + getAccessToken() + "&id=" + id);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取指定部门下的用户信息 不填写获取全部部门下的用户信息
     */
    public List<QywxUser> getUsersByDept(String id){
        List<QywxUser> resList = null;

        // 获取部门信息
        JSONObject deptJson = getDepartments(id);
        // 判断部门信息获取是否成功
        if((Integer)deptJson.get("errcode")==0){
            resList = new ArrayList<QywxUser>();

            JSONArray departments = deptJson.getJSONArray("department");

            for (int i=0,size=departments.size();i<size;i++){
                JSONObject department = departments.getJSONObject(i);

                JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/user/simplelist?access_token=" + getAccessToken() + "&department_id=" + department.getString("id"));

                if((Integer)res.get("errcode")==0){
                    JSONArray userlist = res.getJSONArray("userlist");
                    if(userlist.size()>0) {
                        for (int j = 0, size2 = userlist.size(); j < size2; j++) {
                            JSONObject jsonObject = userlist.getJSONObject(j);
                            QywxUser qywxUser = new QywxUser();
                            qywxUser.setUserid(jsonObject.getString("userid"));
                            qywxUser.setName(jsonObject.getString("name"));
                            resList.add(qywxUser);
                        }
                    }
                }
            }

        }

        return resList;
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取指定部门下的用户信息 不填写获取全部部门下的用户信息 详情
     */
    public List<QywxUser> getUsersDetailByDept(String id){
        List<QywxUser> resList = new ArrayList<>();
        JSONObject res = HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/user/list?fetch_child=0&access_token=" + getAccessToken() + "&department_id=" + id);
        if("0".equals(res.getString("errcode"))){
            JSONArray userlist = res.getJSONArray("userlist");
            if(userlist.size()>0) {
                for (int j = 0, size2 = userlist.size(); j < size2; j++) {
                    JSONObject jsonObject = userlist.getJSONObject(j);
                    QywxUser qywxUser = new QywxUser();
                    qywxUser.setUserid(jsonObject.getString("userid"));
                    qywxUser.setName(jsonObject.getString("name"));
                    qywxUser.setGender(jsonObject.has("gender")?jsonObject.getString("gender"):"");
                    qywxUser.setMobile(jsonObject.has("mobile")?jsonObject.getString("mobile"):"");
                    qywxUser.setPosition(jsonObject.has("position")?jsonObject.getString("position"):"");
                    qywxUser.setEmail(jsonObject.has("email")?jsonObject.getString("email"):"");
                    JSONArray departmentJSONArr = jsonObject.getJSONArray("department");
                    String[] department = new String[departmentJSONArr.size()];
                    for (int i = 0; i < departmentJSONArr.size(); i++) {
                        department[i] = departmentJSONArr.get(i).toString();
                    }
                    qywxUser.setDepartment(department);
                    resList.add(qywxUser);
                }
            }
        } else {
            System.out.println("line 261:id:"+id);
            System.out.println("line 262:errcode:"+res.getString("errcode"));
            System.out.println("line 263:errmsg:"+res.getString("errmsg"));
            System.out.println();
        }

        return resList;
    }



    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 根据userid获取企业微信中的用户信息
     */
    public JSONObject getUserByUserid(String userid){
       return  HttpClientUtil.httpGet(getConfig().getApiDomain()+"/cgi-bin/user/get?access_token="+getAccessToken()+"&userid="+userid);
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/25
     * @说明: 查询所有用户和绑定状态
     */
    public BaseWrapper selUsersWithBindType(String deptId){
        BaseWrapper baseWrapper = new BaseWrapper();

        List<QywxUser> usersByDept = getUsersByDept(deptId);

        List<UserWeixinqy> userWeixinqies = userWeixinqyMapper.selAllBindUsers();

        Map<String,String> bindMap = new HashMap<String,String>();

        List<UserWeixinqy> resList = new ArrayList<>();
        for(int i=0,size=userWeixinqies.size();i<size;i++){
            UserWeixinqy userWeixinqy = userWeixinqies.get(i);
            if(userWeixinqy!=null){
                bindMap.put(userWeixinqy.getOpenId(),userWeixinqy.getUserId());
                userWeixinqy.setIfBind("1");
            }
        }

        // 增加验证是否重复的map
        Map<String,Object> repeatMap = new HashMap<>();
        // 循环遍历
        for(int i=0,size=usersByDept.size();i<size;i++){
            QywxUser qywxUser = usersByDept.get(i);
            if(repeatMap.containsKey(qywxUser.getUserid())){
                continue;
            } else {
                repeatMap.put(qywxUser.getUserid(),qywxUser.getUserid());
            }

            // 1.判断是否为空 2.判断企业微信中的用户的userid是否为空 3.判断是否已经是绑定过的用户
            if(qywxUser!=null&&!StringUtils.checkNull(qywxUser.getUserid())&&bindMap.get(qywxUser.getUserid())==null){
                UserWeixinqy userWeixinqy = new UserWeixinqy();
                userWeixinqy.setOpenId(qywxUser.getUserid());
                userWeixinqy.setUserName(qywxUser.getName());
                userWeixinqy.setIfBind("0");
                resList.add(userWeixinqy);
            }else if(qywxUser!=null&&bindMap.get(qywxUser.getUserid())!=null){
                UserWeixinqy userWeixinqy = new UserWeixinqy();
                userWeixinqy.setOpenId(qywxUser.getUserid());
                userWeixinqy.setUserName(qywxUser.getName());
                userWeixinqy.setIfBind("1");
                userWeixinqy.setUserId(bindMap.get(qywxUser.getUserid()));
                String usernameByUserId = usersMapper.getUsernameByUserId(userWeixinqy.getUserId());
                if(!StringUtils.checkNull(usernameByUserId)){
                    userWeixinqy.setBindUserName(usernameByUserId);
                } else {
                    userWeixinqy.setBindUserName("该用户不存在");
                }
                resList.add(userWeixinqy);
            }
        }

        baseWrapper.setData(resList);
        baseWrapper.setFlag(true);
        return baseWrapper;
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/6/24
     * @说明: 获取企业微信中的用户数据id 绑定OA中的用户
     */
    public BaseWrapper bind(String openId,String userId){
        BaseWrapper baseWrapper = new BaseWrapper();

        if(!StringUtils.checkNull(openId)&&!StringUtils.checkNull(userId)){
            // 根据OaUserId判断是否存在 更新信息
            List<UserWeixinqy> userid1 = userWeixinqyMapper.selUsersByUserId(userId);
            if (userid1==null) {
                // 根据openId判断是否存在，更新信息
                List<UserWeixinqy> userWeixinqy = userWeixinqyMapper.selUsersByOpenId(openId);
                // 不存在 进行插入
                if(userWeixinqy==null){
                    UserWeixinqy userWeixinqyModel = new UserWeixinqy();
                    userWeixinqyModel.setUserId(userId);
                    userWeixinqyModel.setOpenId(openId);
                    userWeixinqyModel.setDeviceid("");
                    userWeixinqyModel.setIsSys(0);
                    userWeixinqyMapper.insertSelective(userWeixinqyModel);
                } else {
                    // 存在 进行删除后插入
                    // 删除所有旧数据
                    UserWeixinqyExample example = new UserWeixinqyExample();
                    UserWeixinqyExample.Criteria criteria = example.createCriteria();
                    criteria.andOpenIdEqualTo(openId);
                    userWeixinqyMapper.deleteByExample(example);
                    // 添加新数据
                    UserWeixinqy userWeixinqyModel = new UserWeixinqy();
                    userWeixinqyModel.setUserId(userId);
                    userWeixinqyModel.setOpenId(openId);
                    userWeixinqyModel.setDeviceid("");
                    userWeixinqyModel.setIsSys(0);
                    userWeixinqyMapper.insertSelective(userWeixinqyModel);
                }
            }else{
                // 删除所有旧数据
                UserWeixinqyExample example = new UserWeixinqyExample();
                UserWeixinqyExample.Criteria criteria = example.createCriteria();
                criteria.andUserIdEqualTo(userId);
                userWeixinqyMapper.deleteByExample(example);
                // 添加新数据
                UserWeixinqy userWeixinqyModel = new UserWeixinqy();
                userWeixinqyModel.setUserId(userId);
                userWeixinqyModel.setOpenId(openId);
                userWeixinqyModel.setDeviceid("");
                userWeixinqyModel.setIsSys(0);
                userWeixinqyMapper.insertSelective(userWeixinqyModel);
            }

            baseWrapper.setFlag(true);
            baseWrapper.setMsg("绑定成功");
        }else {
            baseWrapper.setFlag(false);
            baseWrapper.setMsg("绑定失败，openId或者userId为空");
        }

        return baseWrapper;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/6/25
     * @说明: 解除绑定接口
     */
    public BaseWrapper removeBind(String openId,String userId){
        BaseWrapper baseWrapper = new BaseWrapper();
        if(!StringUtils.checkNull(userId)&&!StringUtils.checkNull(openId)){
            userWeixinqyMapper.deleteByOpenIdOrUserId(openId,userId);
            baseWrapper.setMsg("解绑成功");
            baseWrapper.setFlag(true);
        }else{
            baseWrapper.setMsg("openId和userId为空，解绑失败");
            baseWrapper.setFlag(false);
        }

        return baseWrapper;
    }

    /**
     * @作者: 张航宁
     * @时间: 2019/8/1
     * @说明: 连接测试
     */
    public BaseWrapper testConnect(){
        BaseWrapper baseWrapper = new BaseWrapper();
        String accessToken = getAccessToken();
        if(!StringUtils.checkNull(accessToken)){
            baseWrapper.setData(accessToken);
            baseWrapper.setMsg("连接成功");
            baseWrapper.setFlag(true);
        }else{
            baseWrapper.setMsg("连接失败");
            baseWrapper.setFlag(false);
        }
        return baseWrapper;
    }



    /**
     * @作者: 张航宁
     * @时间: 2019/8/7
     * @说明: 获取config信息
     */
    public QiyeWeixinConfig getConfig(){
        if(qiyeWeixinConfig == null || (new Date().getTime()-accessToken_TimeLimit)/1000 >7000){
            qiyeWeixinConfig = qiyeWeixinConfigMapper.selectConfig();
        }
        return qiyeWeixinConfig;
    }

    public QiyeWeixinSetting getConfig(String menuUrl){
        QiyeWeixinSetting qiyeWeixinSetting = null;
        if(!StringUtils.checkNull(menuUrl)){
            JSONObject jsonObject = (JSONObject) configMap.get(menuUrl);
            if(jsonObject == null || (new Date().getTime()-jsonObject.getLong("refreshTime"))/1000 >7000){
                BaseWrapper wxAppSettingByUrl = qiyeWeixinService.getWxAppSettingByUrl(menuUrl);
                if(wxAppSettingByUrl!=null&&wxAppSettingByUrl.isFlag()){
                    qiyeWeixinSetting = (QiyeWeixinSetting) wxAppSettingByUrl.getData();
                    jsonObject = new JSONObject();
                    jsonObject.put("qiyeWeixinSetting",qiyeWeixinSetting);
                    jsonObject.put("refreshTime",new Date().getTime());
                }
            } else {
                qiyeWeixinSetting = (QiyeWeixinSetting) jsonObject.get("qiyeWeixinSetting");
            }
        }
        return qiyeWeixinSetting;
    }


    /**
     * @作者: 张航宁
     * @时间: 2019/12/18
     * @说明: 企业微信应用推送消息接口
     * 为了跳转指定详情页设置为openType为要跳转的url,转码进行跳转
     */
    public BaseWrapper sendMsg(List<String> userIds, String title, String content,String openType, Boolean allType) {
        BaseWrapper baseWrapper = new BaseWrapper();
        baseWrapper.setFlag(false);
        String menuUrl = "";
        String params = "";// 传参
        if(openType.contains("email")){
            menuUrl = "/ewx/emailList";
        } else if(openType.contains("work")){
            menuUrl = "/workflow/work/workflowIndexh5";
        } else if(openType.contains("notify")||openType.contains("notice")){
            menuUrl = "/ewx/noticeList";
        } else if (openType.contains("/newFileContent/getFileDetail")){// 公共文件柜，移动端文件详情页面
            if (openType.contains("?")){
                String[] url = openType.split("\\?", 2);
                menuUrl = url[0];
                params = url[1].replaceAll("=", "~");// =转义为~
            } else {
                menuUrl = openType;
            }
        } else if(openType.contains("file")){ // 个人文件柜
            menuUrl = "/ewx/fileIndex";
        } else if(openType.contains("new")){
            menuUrl = "/ewx/newsList";
        } else if(openType.contains("diary")){
            menuUrl = "/ewx/diaryIndex";
        } else if (openType.contains("/ewx/consult")){// 移动端工作日志详情页面
            if (openType.contains("?")){
                String[] url = openType.split("\\?", 2);
                menuUrl = url[0];
                params = url[1].replaceAll("=", "~");// =转义为~
            } else {
                menuUrl = openType;
            }
        }

        // 企业微信配置
        QiyeWeixinConfig config = getConfig();
        String accessToken = "";
        if(config==null){
            baseWrapper.setMsg("配置信息为空");
            return baseWrapper;
        }else{
            // 判断是否传入了menuUrl 是不是单独应用推送
            if(!StringUtils.checkNull(menuUrl)){
                accessToken = getAccessToken(menuUrl);
                QiyeWeixinSetting config1 = getConfig(menuUrl);
                if(config1!=null){
                    config.setAgentid(config1.getAgentId());
                } else {
                    accessToken = getAccessToken();
                    menuUrl = "";
                }
            } else {
                accessToken = getAccessToken();
                menuUrl = "";
            }
            if(StringUtils.checkNull(accessToken)){
                baseWrapper.setMsg("配置信息有误，连接企业微信失败");
                return baseWrapper;
            }
            if (StringUtils.checkNull(config.getAgentid())){
                baseWrapper.setMsg("没有设置应用id，发送失败");
                return baseWrapper;
            }
        }

        // 推送消息的url
        String url = config.getApiDomain()+"/cgi-bin/message/send?access_token="+accessToken;

        // touser 设置初始化
        StringBuffer touser = new StringBuffer();
        List<UserWeixinqy> userWeixinqies = new ArrayList<>();
        if(allType!=null&&allType){
            touser.append("@all");
        } else {
            // 推送消息人员处理
            userWeixinqies = userWeixinqyMapper.selUsersByUserIds(userIds);
            // 判断是否有值
            if(userWeixinqies==null||userWeixinqies.size()<=0){
                baseWrapper.setMsg("发送人员没有进行企业微信绑定，无法获取企业微信userId进行发送");
                return baseWrapper;
            }
        }

        // 消息具体内容
        JSONObject textCard = new JSONObject();
        textCard.put("title",title);
        textCard.put("description",content);
        textCard.put("btntxt","更多");


        String url2 = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+ config.getCorpid()
                +"&redirect_uri="+ URLEncoder.encode(config.getOaUrl()+"/ewx/m/main?openType="+URLEncoder.encode(openType+"&menuUrl="+menuUrl)+"&params="+params)
                +"&response_type=code&scope=snsapi_base&agentid="+config.getAgentid()
                +"#wechat_redirect";

        if(!config.getApiDomain().contains("qyapi.weixin.qq.com")){
            url2 = config.getApiDomain() + "/connect/oauth2/authorize?appid="+ config.getCorpid()
                    +"&redirect_uri="+ URLEncoder.encode(config.getOaUrl()+"/ewx/m/main?openType="+URLEncoder.encode(openType+"&menuUrl="+menuUrl)+"&params="+params)
                    +"&response_type=code&scope=snsapi_base&agentid="+config.getAgentid()
                    +"#wechat_redirect";
        }

        textCard.put("url",url2);

        //因为企业微信，应用消息，接收消息的成员，成员ID列表（多个接收者用‘|’分隔，最多支持1000个）
        //所以进行判断是否1000，分别处理
        if (!CollectionUtils.isEmpty(userWeixinqies)) {
            //不超过1000
            if (userWeixinqies.size() <= 1000) {
                for (int i = 0; i < userWeixinqies.size(); i++) {
                    UserWeixinqy userWeixinqy = userWeixinqies.get(i);
                    String openId = userWeixinqy.getOpenId();
                    if(!StringUtils.checkNull(openId)){
                        touser.append(openId).append("|");
                    }
                }

                // 基本参数
                Map<String,String> data = new HashMap<>();
                data.put("touser",touser.toString());
                data.put("msgtype","textcard");
                data.put("agentid", config.getAgentid());
                data.put("textcard",textCard.toString());

                JSONObject jsonObject = JSONObject.fromObject(HttpClientUtil.doPost(url, data, "UTF-8"));

                if((Integer)jsonObject.get("errcode")==0){
                    baseWrapper.setFlag(true);
                    baseWrapper.setMsg("发送成功");
                }else{
                    baseWrapper.setMsg("发送失败，errcode："+jsonObject.get("errcode"));
                }

            } else {
                StringBuffer msg = new StringBuffer();
                //超过1000
                int page = 1;
                int pageSize = 1000;
                if (userWeixinqies.size() % 1000 != 0){
                    page = userWeixinqies.size() / 1000 + 1;
                }else {
                    page = userWeixinqies.size() / 1000;
                }
                //按1000，分割人数
                for (int i = 1; i <= page; i++) {
                    touser = new StringBuffer();
                    if (i == page && userWeixinqies.size() % 1000 != 0) {
                        pageSize = userWeixinqies.size() % 1000;
                    }
                    for (int j = 0; j < pageSize; j++) {
                        UserWeixinqy userWeixinqy = userWeixinqies.get(i * 1000 - 1000 + j);
                        String openId = userWeixinqy.getOpenId();
                        if(!StringUtils.checkNull(openId)){
                            touser.append(openId).append("|");
                        }
                    }

                    // 基本参数
                    Map<String,String> data = new HashMap<>();
                    data.put("touser",touser.toString());
                    data.put("msgtype","textcard");
                    data.put("agentid", config.getAgentid());
                    data.put("textcard",textCard.toString());

                    JSONObject jsonObject = JSONObject.fromObject(HttpClientUtil.doPost(url, data, "UTF-8"));

                    if((Integer)jsonObject.get("errcode")==0){
                        baseWrapper.setFlag(true);
                        msg.append("第").append(i).append("次，发送成功！");
                    }else{
                        msg.append("第").append(i).append("次，发送失败，errcode：").append(jsonObject.get("errcode")).append("！");
                    }
                }
                baseWrapper.setMsg(msg.toString());
            }
        }

        return baseWrapper;
    }

    /**
     * @接口说明: 企业微信同步组织接口
     * @日期: 2020/3/18
     * @作者: 张航宁
     */
    public void WxDeptToOA(){
        JSONObject departments = getDepartments("0");
        if(departments!=null&&departments.getString("errcode").equals("0")){
            JSONArray department = departments.getJSONArray("department");
            for (int i = 0; i < department.size(); i++) {
                JSONObject jsonObject = department.getJSONObject(i);
                insertDept(jsonObject);
            }
            departmentService.updateDeptNo(0,"");
        }
    }

    /**
     * @接口说明: 企业微信同步用户信息
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    public void WxUserToOA(HttpServletRequest request){
        // 获取所有部门
        JSONObject departments = getDepartments("0");
        if(departments!=null&&departments.getString("errcode").equals("0")){
            JSONArray department = departments.getJSONArray("department");
            // 循环部门
            for (int i = 0; i < department.size(); i++) {
                JSONObject jsonObject = department.getJSONObject(i);
                String id = jsonObject.getString("id");
                // 根据企业微信的部门id获取部门
                Department departmentWx = departmentMapper.getDeptByWxDeptId(id);
                // 如果部门为空的话 插入部门
                if(departmentWx==null){
                    insertDept(jsonObject);
                    departmentWx = departmentMapper.getDeptByWxDeptId(id);
                    if(departmentWx!=null){
                        insertUser(request, id, departmentWx);
                    }
                } else {
                    // 插入或者更新用户
                    insertUser(request, id, departmentWx);
                }
            }
        }
    }

    /**
     * @接口说明: 插入用户
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    private void insertUser(HttpServletRequest request, String id, Department departmentWx) {
        UserPriv minNoUserPriv = userPrivMapper.getMinNoUserPriv();
        List<QywxUser> qywxUsers = getUsersDetailByDept(id);
        for (QywxUser qywxUser : qywxUsers) {
            Users users = new Users();
            users.setByname(qywxUser.getMobile());// 登录账户名
            users.setUserName(qywxUser.getName());
            users.setDeptId(departmentWx.getDeptId());
            users.setDeptName(departmentWx.getDeptName());
            users.setSex(qywxUser.getGender().equals("1") ? "0" : "1");
            users.setMobilNo(qywxUser.getMobile());
            users.setEmail(qywxUser.getEmail());
            users.setOicqNo(qywxUser.getUserid());
            List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(qywxUser.getPosition().trim());
            if (userPrivsByName != null && userPrivsByName.size() > 0) {
                for (UserPriv userPriv : userPrivsByName) {
                    users.setUserPriv(userPriv.getUserPriv());
                    users.setUserPrivName(userPriv.getPrivName());
                    break;
                }
            } else {
                users.setUserPriv(minNoUserPriv.getUserPriv());
                users.setUserPrivName(minNoUserPriv.getPrivName());
            }
            // 辅助部门
            String[] department = qywxUser.getDepartment();
            StringBuilder deptOther = new StringBuilder();
            for (String wxDeptId:department) {
                Department departmentWxOther = departmentMapper.getDeptByWxDeptId(wxDeptId);
                if(departmentWxOther!=null){
                    deptOther.append(departmentWxOther.getDeptId()).append(",");
                }
            }
            users.setDeptIdOther(deptOther.toString());
            // 设置其他默认信息
            users.setPassword("");
            users.setTheme(6);
            users.setPostPriv("0");
            users.setNotLogin(0);
            // 插入用户
            Users usersBybyname = usersMapper.getUsersBybyname(users.getByname());
            if (usersBybyname == null) {
                ToJson<Users> usersToJson = usersService.addUser(users, new UserExt(), new ModulePriv(), request);
                if (usersToJson.isFlag()) {
                    Users users1 = (Users) usersToJson.getObject();
                    UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByOpenId(qywxUser.getUserid());
                    if (userWeixinqy == null) {
                        userWeixinqy = new UserWeixinqy();
                        userWeixinqy.setOpenId(qywxUser.getUserid());
                        userWeixinqy.setUserId(users1.getUserId());
                        userWeixinqy.setIsSys(0);
                        userWeixinqy.setDeviceid("");
                        userWeixinqyMapper.insertSelective(userWeixinqy);
                    }
                }
            }
        }
    }

    /**
     * @接口说明: 递归插入部门 由低级向上级遍历
     * @日期: 2020/3/19
     * @作者: 张航宁
     */
    private void insertDept(JSONObject jsonObject) {
        String id = jsonObject.getString("id");
        String parentid = jsonObject.getString("parentid");
        String name = jsonObject.getString("name");
        // 查询当前部门
        Department departmentWx = departmentMapper.getDeptByWxDeptId(id);
        // 判断是否存在当前部门
        if(departmentWx==null){
            // 如果不存在 判断他是否是最外级的部门
            if(!"0".equals(parentid)){
                // 不是最外级别的部门 查询他的父级别部门是否存在
                Department departmentWxParent = departmentMapper.getDeptByWxDeptId(parentid);
                // 不存在进行递归向上获取
                if(departmentWxParent==null){
                    JSONObject departments = getDepartments(String.valueOf(parentid));
                    if(departments!=null&&departments.getString("errcode").equals("0")){
                        JSONArray department = departments.getJSONArray("department");
                        for (int i = 0; i < department.size(); i++) {
                            JSONObject jsonObject1 = department.getJSONObject(i);
                            if(jsonObject1.getString("id").equals(parentid)){
                                insertDept(jsonObject1);
                            }
                        }
                    }
                } else {  // 存在执行插入操作
                    departmentWx = new Department();
                    departmentWx.setWeixinDeptId(id);
                    departmentWx.setDeptName(name);
                    departmentWx.setDeptParent(departmentWxParent.getDeptId());
                    departmentMapper.insertDept(departmentWx);
                }
            } else {
                // 插入 departmentWx
                departmentWx = new Department();
                departmentWx.setWeixinDeptId(id);
                departmentWx.setDeptName(name);
                departmentWx.setDeptParent(0);
                departmentMapper.insertDept(departmentWx);
            }
        } else {
            // 如果存在 查看名称是否不同 是否需要进行更新
            if(!StringUtils.checkNull(name)&&!name.equals(departmentWx.getDeptName())){
                departmentWx.setDeptName(name);
                departmentMapper.editDeptWithWx(departmentWx);
            }
        }
    }

    public BaseWrapper mobileBindOAUser(){
        BaseWrapper baseWrapper = new BaseWrapper();
        // 获取所有部门
        JSONObject departments = getDepartments("0");
        if(departments!=null&&departments.getString("errcode").equals("0")){
            JSONArray department = departments.getJSONArray("department");
            // 循环部门
            for (int i = 0; i < department.size(); i++) {
                JSONObject jsonObject = department.getJSONObject(i);
                String id = jsonObject.getString("id");
                List<QywxUser> usersDetailByDept = getUsersDetailByDept(id);
                usersDetailByDept.forEach((qywxUser)->{
                    if(!StringUtils.checkNull(qywxUser.getName())&&!StringUtils.checkNull(qywxUser.getMobile())){
                        Users users = usersMapper.selectByPhoneAndName(qywxUser.getName(), qywxUser.getMobile());
                        if(users!=null&&!StringUtils.checkNull(users.getUserId())){
                            bind(qywxUser.getUserid(),users.getUserId());
                        } else {
                            Users users1 = usersMapper.selectUserAllInfoByName(qywxUser.getMobile());
                            if(users1!=null&&!StringUtils.checkNull(users1.getUserId())){
                                bind(qywxUser.getUserid(),users1.getUserId());
                            } else {
                                List<Users> users2 = usersMapper.queryUserByUserName(qywxUser.getName());
                                if(users2.size()==1){
                                    bind(qywxUser.getUserid(),users2.get(0).getUserId());
                                }
                            }
                        }
                    } else if (!StringUtils.checkNull(qywxUser.getName())){
                        List<Users> users2 = usersMapper.queryUserByUserName(qywxUser.getName());
                        if(users2.size()==1){
                            bind(qywxUser.getUserid(),users2.get(0).getUserId());
                        }
                    }
                });
            }
        }
        baseWrapper.setFlag(true);
        baseWrapper.setStatus(true);
        return baseWrapper;
    }


    // oa部门同步到企业微信接口
    public BaseWrapper oaDeptToWX(){
        BaseWrapper baseWrapper = new BaseWrapper();

        List<Department> deptList = departmentMapper.getDatagrid();

        JSONArray dingDepartments = getDepartments(null).getJSONArray("department");

        for(Department department: deptList) {

            boolean create = true;


            Integer parentid = departmentMapper.getParentEnterpriseWeChatId(department.getDeptId());
            //循环判断部门是否已加入企业微信组织架构
            for(int i = 0; i < dingDepartments.size(); i ++) {
                JSONObject department1 = dingDepartments.getJSONObject(i);

                if(department1.getString("id").equals(department.getWeixinDeptId())) {
                    //id存在则已加入钉钉，无需进行创建操作
                    create = false;
                    if((parentid == null||department1.getInt("parentid") == parentid)
                            &&department1.getString("name").equals(department.getDeptName())) {
                        break;
                    }
                } else if(department1.getString("name").equals(department.getDeptName())) {
                    department.setWeixinDeptId(department1.getString("id"));
                    departmentMapper.editDeptWithWx(department);
                    create = false;
                    break;
                }
            }

            if(create) {
                if(department.getDeptName().equals("离职")){
                    continue;
                }
                // 创建部门
                Map<String,String > newDept = new HashMap<>();

                if(department.getDeptParent()==0) {
                    //父部门id为0说明是根部门，设置钉钉父部门id为1
                    newDept.put("parentid","1");
                } else {
                    //设置父部门的钉钉id到钉钉创建类
                    newDept.put("parentid", String.valueOf(parentid));
                }


                newDept.put("order",department.getDeptNo().substring(department.getDeptNo().length()-3,department.getDeptNo().length()));
                newDept.put("name",department.getDeptName());


                JSONObject result = JSONObject.fromObject(HttpClientUtil.doPost(getConfig().getApiDomain() + "/cgi-bin/department/create?access_token="+getAddressAccessToken(), newDept, "utf-8"));
                if(result!=null&&"0".equals(result.getString("errcode"))){
                    //写入钉钉部门id
                    if(!StringUtils.checkNull(result.getString("id"))){
                        department.setWeixinDeptId(result.getString("id"));
                        departmentMapper.editDeptWithWx(department);
                    }
                }


            }

        }




        baseWrapper.setFlag(true);
        return baseWrapper;
    }

    // oa用户同步到企业微信接口
    public BaseWrapper oaUserToWX(){
        BaseWrapper baseWrapper = new BaseWrapper();

        List<Department> deptList = departmentMapper.getDatagrid();


        for(Department department: deptList) {

            List<Users> usersByDeptId = usersMapper.getUsersByDeptId(department.getDeptId());

            List<QywxUser> usersByDept = getUsersDetailByDept(department.getWeixinDeptId());

            for (int i = 0; i <usersByDeptId.size() ; i++) {
                boolean createFlag = true;
                Users users = usersByDeptId.get(i);
                UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByUserId(users.getUserId());
                if(userWeixinqy==null){
                    for (QywxUser qywxUser:usersByDept) {
                        if(qywxUser.getName().equals(users.getUserName())
                                &&(qywxUser.getMobile().equals(users.getMobilNo())
                                ||qywxUser.getEmail().equals(users.getEmail()))){
                            // 设置不新建 并进行绑定
                            createFlag =false;
                            userWeixinqy = new UserWeixinqy();
                            userWeixinqy.setOpenId(qywxUser.getUserid());
                            userWeixinqy.setUserId(users.getUserId());
                            userWeixinqy.setDeviceid("");
                            userWeixinqy.setIsSys(0);
                            userWeixinqyMapper.insert(userWeixinqy);
                            break;
                        }
                    }
                } else {
                    createFlag = false;
                }

                if(createFlag){
                    Map<String,String> userMap = new HashMap<>();
                    userMap.put("userid",users.getUserId());
                    userMap.put("name",users.getUserName());
                    userMap.put("mobile",users.getMobilNo());
                    userMap.put("email",users.getEmail());
                    userMap.put("department",department.getWeixinDeptId());


                    // 必须要有email或者mobile 一个不为空
                    if(!StringUtils.checkNull(userMap.get("mobile"))||!StringUtils.checkNull(userMap.get("email"))){
                        JSONObject result = JSONObject.fromObject(HttpClientUtil.doPost(getConfig().getApiDomain() +"/cgi-bin/user/create?access_token="+getAddressAccessToken(), userMap, "utf-8"));
                        // 判断是否返回了id
                        if(result!=null&&"0".equals(result.getString("errcode"))&&result.has("id")){
                            //写入钉钉部门id
                            userWeixinqy = new UserWeixinqy();
                            userWeixinqy.setOpenId(result.getString("id"));
                            userWeixinqy.setUserId(users.getUserId());
                            userWeixinqy.setDeviceid("");
                            userWeixinqy.setIsSys(0);
                            userWeixinqyMapper.insert(userWeixinqy);
                        }else {
                            L.e("QywxService.oaUserToWX:" + result.toString());
                        }
                    }

                }
            }
        }

        baseWrapper.setFlag(true);
        return baseWrapper;
    }


    public BaseWrapper chooseOAUserToWX(HttpServletRequest request, String deptIds,String userIds) {
        BaseWrapper baseWrapper = new BaseWrapper();

        if(StringUtils.checkNull(userIds) && StringUtils.checkNull(deptIds)){
            baseWrapper.setMsg("未选择需要同步的用户");
            return baseWrapper;
        }

        try {
            //部门id串参数不为空，根据部门id串同步
            if (!StringUtils.checkNull(deptIds)) {
                List<Department> deptList = departmentMapper.selDeptByIds(deptIds.split(","));
                for (Department department : deptList) {
                    List<Users> usersByDeptId = usersMapper.getUsersByDeptId(department.getDeptId());
                    this.userToWX(usersByDeptId);
                }
            }

            //用户userId串参数不为空，根据用户userId串同步
            if (!StringUtils.checkNull(userIds)) {
                List<Users> usersByDeptId = usersMapper.selUserByIds(userIds.split(","));
                for (Users users : usersByDeptId) {
                    if((users.getMobilNo()==null||users.getMobilNo().equals(""))
                            &&(users.getEmail()==null||users.getEmail().equals(""))
                    ){
                        baseWrapper.setFlag(false);
                        baseWrapper.setMsg("无法同步，请检查 "+users.getUserName()+" 的个人信息缺少手机号或者邮箱");
                        return baseWrapper;
                    }
                }
                this.userToWX(usersByDeptId);
            }
            baseWrapper.setFlag(true);
        }catch (Exception e){
            e.printStackTrace();
            baseWrapper.setFlag(false);
        }
        return baseWrapper;
    }

    private void userToWX(List<Users> usersByDeptId){
        for (int i = 0; i < usersByDeptId.size(); i++) {
            boolean createFlag = true;
            Users users = usersByDeptId.get(i);
            UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByUserId(users.getUserId());

            Department department = departmentMapper.selectByDeptId(users.getDeptId());
            List<QywxUser> usersByDept = getUsersDetailByDept(department.getWeixinDeptId());

            if (userWeixinqy == null) {
                for (QywxUser qywxUser : usersByDept) {
                    if (qywxUser.getName().equals(users.getUserName())
                            && (qywxUser.getMobile().equals(users.getMobilNo())
                            || qywxUser.getEmail().equals(users.getEmail()))) {
                        // 设置不新建 并进行绑定
                        createFlag = false;
                        userWeixinqy = new UserWeixinqy();
                        userWeixinqy.setOpenId(qywxUser.getUserid());
                        userWeixinqy.setUserId(users.getUserId());
                        userWeixinqy.setDeviceid("");
                        userWeixinqy.setIsSys(0);
                        userWeixinqyMapper.insert(userWeixinqy);
                        break;
                    }
                }
            } else {
                createFlag = false;
            }

            if (createFlag) {
                Map<String, String> userMap = new HashMap<>();
                userMap.put("userid", users.getUserId());
                userMap.put("name", users.getUserName());
                userMap.put("mobile", users.getMobilNo());
                userMap.put("email", users.getEmail());
                userMap.put("department", department.getWeixinDeptId());
                userMap.put("position",users.getUserPrivName());

                // 必须要有email或者mobile 一个不为空
                if (!StringUtils.checkNull(userMap.get("mobile")) || !StringUtils.checkNull(userMap.get("email"))) {
                    JSONObject result = JSONObject.fromObject(HttpClientUtil.doPost(getConfig().getApiDomain() + "/cgi-bin/user/create?access_token=" + getAddressAccessToken(), userMap, "utf-8"));
                    // 判断是否返回了id
                    if (result != null && "0".equals(result.getString("errcode")) && result.has("id")) {
                        //写入钉钉部门id
                        userWeixinqy = new UserWeixinqy();
                        userWeixinqy.setOpenId(result.getString("id"));
                        userWeixinqy.setUserId(users.getUserId());
                        userWeixinqy.setDeviceid("");
                        userWeixinqy.setIsSys(0);
                        userWeixinqyMapper.insert(userWeixinqy);
                    }
                }
            }
        }
    }


    public BaseWrapper wxUserToOASingle(HttpServletRequest request,String wxUserIds,Integer oaDeptId){
        BaseWrapper baseWrapper = new BaseWrapper();
        if(!StringUtils.checkNull(wxUserIds)){
            String[] split = wxUserIds.split(",");
            for (String wxUserId : split) {
                JSONObject jsonObject = getUserByUserid(wxUserId);

                Users users = new Users();
                QywxUser qywxUser = new QywxUser();
                qywxUser.setUserid(jsonObject.getString("userid"));
                qywxUser.setName(jsonObject.getString("name"));
                qywxUser.setGender(jsonObject.getString("gender"));
                qywxUser.setMobile(jsonObject.getString("mobile"));
                qywxUser.setPosition(jsonObject.getString("position"));
                qywxUser.setEmail(jsonObject.getString("email"));

                users.setByname(qywxUser.getMobile());// 登录账户名
                users.setUserName(qywxUser.getName());
                String main_department = jsonObject.getString("main_department");
                Department deptByWxDeptId = departmentMapper.getDeptByWxDeptId(main_department);
                if(deptByWxDeptId!=null){
                    users.setDeptId(deptByWxDeptId.getDeptId());// 部门
                }
                //users.setDeptName(departmentWx.getDeptName());
                users.setSex(qywxUser.getGender().equals("1") ? "0" : "1");
                users.setMobilNo(qywxUser.getMobile());
                users.setEmail(qywxUser.getEmail());
                users.setOicqNo(qywxUser.getUserid());
                List<UserPriv> userPrivsByName = userPrivMapper.getUserPrivsByName(qywxUser.getPosition().trim());
                if (userPrivsByName != null && userPrivsByName.size() > 0) {
                    for (UserPriv userPriv : userPrivsByName) {
                        users.setUserPriv(userPriv.getUserPriv());
                        users.setUserPrivName(userPriv.getPrivName());
                        break;
                    }
                } else {
                    UserPriv minNoUserPriv = userPrivMapper.getMinNoUserPriv();
                    users.setUserPriv(minNoUserPriv.getUserPriv());
                    users.setUserPrivName(minNoUserPriv.getPrivName());
                }
                // 辅助部门
                /*String[] department = qywxUser.getDepartment();
                StringBuilder deptOther = new StringBuilder();
                for (String wxDeptId:department) {
                    Department departmentWxOther = departmentMapper.getDeptByWxDeptId(wxDeptId);
                    if(departmentWxOther!=null){
                        deptOther.append(departmentWxOther.getDeptId()).append(",");
                    }
                }
                users.setDeptIdOther(deptOther.toString());*/

                // 设置其他默认信息
                users.setPassword("");
                users.setTheme(6);
                users.setPostPriv("0");
                users.setNotLogin(0);
                // 插入用户
                Users usersBybyname = usersMapper.getUsersBybyname(users.getByname());
                if (usersBybyname == null) {
                    ToJson<Users> usersToJson = usersService.addUser(users, new UserExt(), new ModulePriv(), request);
                    if (usersToJson.isFlag()) {
                        Users users1 = (Users) usersToJson.getObject();
                        UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByOpenId(qywxUser.getUserid());
                        if (userWeixinqy == null) {
                            userWeixinqy = new UserWeixinqy();
                            userWeixinqy.setOpenId(qywxUser.getUserid());
                            userWeixinqy.setUserId(users1.getUserId());
                            userWeixinqy.setIsSys(0);
                            userWeixinqy.setDeviceid("");
                            userWeixinqyMapper.insertSelective(userWeixinqy);
                        }
                    }
                }

            }
        }
        baseWrapper.setTrue();
        return baseWrapper;
    }


    public BaseWrapper getHeadPortrait(HttpServletRequest request, String userIds) {
        BaseWrapper baseWrapper = new BaseWrapper();
        if (!StringUtils.checkNull(userIds)){
            List<String> userIdList = Arrays.asList(userIds.split(","));
            if (!CollectionUtils.isEmpty(userIdList)){
                Map<String, String> result = new HashMap<>();
                for (String userId : userIdList) {
                    if (result.containsKey(userId)){
                        continue;
                    }
                    //头像
                    JSONObject jsonObject = null;
                    if (!StringUtils.checkNull(userId)) {
                        UserWeixinqy userWeixinqy = userWeixinqyMapper.selUserByUserId(userId);
                        jsonObject = HttpClientUtil.httpGet(getConfig().getApiDomain()
                                + "/cgi-bin/user/get" + "?access_token=" + getAccessToken()
                                + "&userid=" + userWeixinqy.getOpenId()
                        );
                    }
                    if (jsonObject != null){
                        String avatar = "";
                        try {
                            avatar = jsonObject.getString("avatar");
                        }catch (Exception e){
                            e.printStackTrace();
                        }
                        result.put(userId, avatar);
                    }
                }
                baseWrapper.setFlag(true);
                baseWrapper.setData(result);
            }
        }
        return baseWrapper;
    }
}
