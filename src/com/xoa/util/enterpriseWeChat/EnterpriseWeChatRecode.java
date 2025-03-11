package com.xoa.util.enterpriseWeChat;
/**
 * Created by 桂静文 on 2018/4/2.
 * 企业微信获取错误返回码
 */
public class EnterpriseWeChatRecode {

    public static String getErrorRecode(Integer recode) {
        String result = "";
        switch (recode) {
            case -1:
                result = "系统繁忙";
                break;
            case 0:
                result = "请求成功";
                break;
            case 40001:
                result = "不合法的secret参数";
                break;
            case 40003:
                result = "无效的UserID";
                break;
            case 40004:
                result = "不合法的媒体文件类型";
                break;
            case 40005:
                result = "不合法的type参数";
                break;
            case 40006:
                result = "不合法的文件大小";
                break;
            case 40007:
                result = "不合法的media_id参数";
                break;
            case 40008:
                result = "不合法的msgtype参数";
                break;
            case 40013:
                result = "不合法的CorpID";
                break;
            case 40014:
                result = "不合法的access_token";
                break;
            case 40016:
                result = "不合法的按钮个数";
                break;
            case 40017:
                result = "不合法的按钮类型";
                break;
            case 40018:
                result = "不合法的按钮名字长度";
                break;
            case 40019:
                result = "不合法的按钮KEY长度";
                break;
            case 40020:
                result = "不合法的按钮URL长度";
                break;
            case 40022:
                result = "不合法的子菜单级数";
                break;
            case 40023:
                result = "不合法的子菜单按钮个数";
                break;
            case 40024:
                result = "不合法的子菜单按钮类型";
                break;
            case 40025:
                result = "不合法的子菜单按钮名字长度";
                break;
            case 40026:
                result = "不合法的子菜单按钮KEY长度";
                break;
            case 40027:
                result = "不合法的子菜单按钮URL长度";
                break;
            case 40029:
                result = "不合法的oauth_code";
                break;
            case 40031:
                result = "不合法的UserID列表";
                break;
            case 40032:
                result = "不合法的UserID列表长度";
                break;
            case 40033:
                result = "不合法的请求字符";
                break;
            case 40035:
                result = "不合法的参数";
                break;
            case 40050:
                result = "chatid不存在";
                break;
            case 40056:
                result = "不合法的agentid";
                break;
            case 40057:
                result = "不合法的callbackurl或者callbackurl验证失败";
                break;
            case 40058:
                result = "不合法的参数";
                break;
            case 40059:
                result = "不合法的上报地理位置标志位";
                break;
            case 40063:
                result = "参数为空";
                break;
            case 40066:
                result = "不合法的部门列表";
                break;
            case 40073:
                result = "不合法的openid";
                break;
            case 40074:
                result = "news消息不支持保密消息类型";
                break;
            case 40077:
                result = "不合法的pre_auth_code参数";
                break;
            case 40078:
                result = "不合法的auth_code参数";
                break;
            case 40080:
                result = "不合法的suite_secret";
                break;
            case 40082:
                result = "不合法的suite_token";
                break;
            case 40083:
                result = "不合法的suite_id";
                break;
            case 40084:
                result = "不合法的permanent_code参数";
                break;
            case 40085:
                result = "不合法的的suite_ticket参数";
                break;
            case 40086:
                result = "不合法的第三方应用appid";
                break;
            case 40088:
                result = "jobid不存在";
                break;
            case 40089:
                result = "批量任务的结果已清理";
                break;
            case 40091:
                result = "secret不合法";
                break;
            case 40093:
                result = "不合法的jsapi_ticket参数";
                break;
            case 40094:
                result = "不合法的URL";
                break;
            case 41001:
                result = "缺少access_token参数";
                break;
            case 41002:
                result = "缺少corpid参数";
                break;
            case 41004:
                result = "缺少secret参数";
                break;
            case 41006:
                result = "缺少media_id参数";
                break;
            case 41008:
                result = "缺少auth code参数";
                break;
            case 41009:
                result = "缺少userid参数";
                break;
            case 41010:
                result = "缺少url参数";
                break;
            case 41011:
                result = "缺少agentid参数";
                break;
            case 41033:
                result = "缺少 description 参数";
                break;
            case 41016:
                result = "缺少title参数";
                break;
            case 41019:
                result = "缺少 department 参数";
                break;
            case 41017:
                result = "缺少tagid参数";
                break;
            case 41021:
                result = "缺少suite_id参数";
                break;
            case 41025:
                result = "缺少permanent_code参数";
                break;
            case 42001:
                result = "access_token已过期";
                break;
            case 42007:
                result = "pre_auth_code已过期";
                break;
            case 42009:
                result = "suite_access_token已过期";
                break;
            case 43004:
                result = "指定的userid未绑定微信或未关注微信插件";
                break;
            case 44001:
                result = "多媒体文件为空";
                break;
            case 44004:
                result = "文本消息content参数为空";
                break;
            case 45001:
                result = "多媒体文件大小超过限制";
                break;
            case 45002:
                result = "消息内容大小超过限制";
                break;
            case 45004:
                result = "应用description参数长度不符合系统限制";
                break;
            case 45008:
                result = "图文消息的文章数量不符合系统限制";
                break;
            case 45009:
                result = "接口调用超过限制";
                break;
            case 45022:
                result = "应用name参数长度不符合系统限制";
                break;
            case 45024:
                result = "帐号数量超过上限";
                break;
            case 45026:
                result = "触发删除用户数的保护";
                break;
            case 45032:
                result = "图文消息author参数长度超过限制";
                break;
            case 45033:
                result = "接口并发调用超过限制";
                break;
            case 46003:
                result = "菜单未设置";
                break;
            case 46004:
                result = "指定的用户不存在";
                break;
            case 48002:
                result = "API接口无权限调用";
                break;
            case 48003:
                result = "不合法的suite_id";
                break;
            case 48004:
                result = "授权关系无效";
                break;
            case 48005:
                result = "API接口已废弃";
                break;
            case 50001:
                result = "redirect_url未登记可信域名";
                break;
            case 50002:
                result = "成员不在权限范围";
                break;
            case 50003:
                result = "应用已禁用";
                break;
            case 60001:
                result = "部门长度不符合限制";
                break;
            case 60003:
                result = "部门ID不存在";
                break;
            case 60004:
                result = "父部门不存在";
                break;
            case 60005:
                result = "部门下存在成员";
                break;
            case 60006:
                result = "部门下存在子部门";
                break;
            case 60007:
                result = "不允许删除根部门";
                break;
            case 60008:
                result = "部门已存在";
                break;
            case 60009:
                result = "部门名称含有非法字符";
                break;
            case 60010:
                result = "部门存在循环关系";
                break;
            case 60011:
                result = "指定的成员/部门/标签参数无权限";
                break;
            case 60012:
                result = "不允许删除默认应用";
                break;
            case 60020:
                result = "访问ip不在白名单之中";
                break;
            case 60028:
                result = "不允许修改第三方应用的主页 URL";
                break;
            case 60102:
                result = "UserID已存在";
                break;
            case 60103:
                result = "手机号码不合法";
                break;
            case 60104:
                result = "手机号码已存在";
                break;
            case 60105:
                result = "邮箱不合法";
                break;
            case 60106:
                result = "邮箱已存在";
                break;
            case 60107:
                result = "微信号不合法";
                break;
            case 60110:
                result = "用户所属部门数量超过限制";
                break;
            case 60111:
                result = "UserID不存在";
                break;
            case 60112:
                result = "成员name参数不合法";
                break;
            case 60123:
                result = "无效的部门id";
                break;
            case 60124:
                result = "无效的父部门id";
                break;
            case 60125:
                result = "非法部门名字";
                break;
            case 60127:
                result = "缺少department参数";
                break;
            case 60129:
                result = "成员手机和邮箱都为空";
                break;
            case 80001:
                result = "可信域名不正确，或者无ICP备案";
                break;
            case 81002:
                result = "部门最多15层";
                break;
            case 82002:
                result = "不合法的PartyID列表长度";
                break;
            case 82003:
                result = "不合法的TagID列表长度";
                break;
            case 84019:
                result = "缺少templateid参数";
                break;
            case 84020:
                result = "templateid不存在";
                break;
            case 84021:
                result = "缺少register_code参数";
                break;
            case 84022:
                result = "无效的register_code参数";
                break;
            case 84023:
                result = "不允许调用设置通讯录同步完成接口";
                break;
            case 84024:
                result = "无注册信息";
                break;
            case 84025:
                result = "不符合的state参数";
                break;
            case 85002:
                result = "包含不合法的词语";
                break;
            case 85004:
                result = "每企业每个月设置的可信域名不可超过20个";
                break;
            case 86001:
                result = "参数 chatid 不合法";
                break;
            case 86003:
                result = "参数 chatid 不存在";
                break;
            case 86004:
                result = "参数 群名不合法";
                break;
            case 86005:
                result = "参数 群主不合法";
                break;
            case 86006:
                result = "群成员数过多或过少";
                break;
            case 86007:
                result = "不合法的群成员";
                break;
            case 86008:
                result = "非法操作非自己创建的群";
                break;
            case 86216:
                result = "存在非法会话成员ID";
                break;
            case 86217:
                result = "会话发送者不在会话成员列表中";
                break;
            case 86220:
                result = "指定的会话参数不合法";
                break;
            case 91040:
                result = "获取ticket的类型无效";
                break;
            case 301002:
                result = "无权限操作指定的应用";
                break;
            case 301005:
                result = "不允许删除创建者";
                break;
            case 301012:
                result = "参数 position 不合法";
                break;
            case 301013:
                result = "参数 telephone 不合法";
                break;
            case 301014:
                result = "参数 english_name 不合法";
                break;
            case 301015:
                result = "参数 mediaid 不合法";
                break;
            case 301021:
                result = "参数 userid 无效";
                break;
            case 301023:
                result = "useridlist非法或超过限额";
                break;
            case 301036:
                result = "不允许更新该用户的userid";
                break;
            case 302004:
                result = "组织架构不合法（1不是一棵树，2 多个一样的partyid，" + "3 partyid空，4 partyid name 空，" +
                        "5 同一个父节点下有两个子节点 部门名字一样 " + "可能是以上情况，请一一排查）";
                break;
            case 302005:
                result = "批量导入系统失败，请重新尝试导入";
                break;
            case 302006:
                result = "批量导入任务的文件中partyid有重复";
                break;
            case 302007:
                result = "批量导入任务的文件中，同一个部门下有两个子部门名字一样";
                break;
            case 2000002:
                result = "CorpId参数无效";
                break;
            default:
                result = "0";
        }
        return result;
    }

}
