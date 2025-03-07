package com.xoa.service.contactPerson;

import com.xoa.dao.email.EmailBodyMapper;
import com.xoa.dao.users.UserExtMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.users.UserExt;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by 李显 on 2017/12/11.
 * 常用联系人查询
 */
@Service
public class ContactPersonService {
    @Autowired
    public EmailBodyMapper emailBodyMapperl;

    @Autowired
    public UsersMapper usersMapper;

    @Resource
    public UserExtMapper userExtMapper;

    public ToJson<Users> serchContactPerson(HttpServletRequest request){
        ToJson<Users> toJson=new ToJson<Users>();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            UserExt userExt = userExtMapper.selUserExtByUserId(user.getUserId());
            String emailRecentLinkman = userExt.getEmailRecentLinkman();
            String[] split = emailRecentLinkman.split(",");
            List<Users> list=new ArrayList<Users>();
            Map<String,Integer> map = new HashMap<String,Integer>();
            // 常用联系人计数
            for (String userId:split) {
                if(map.get(userId)==null){
                    map.put(userId,1);
                }else{
                    map.put(userId,map.get(userId)+1);
                }
            }

            // 排序常用联系人
            List<Map.Entry<String, Integer>> list2 = new ArrayList<Map.Entry<String, Integer>>(map.entrySet());
            Collections.sort(list2, new Comparator<Map.Entry<String, Integer>>() {
                public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                    return (o2.getValue() - o1.getValue());
                }
            });

            for (int i=0,length=list2.size();i<length;i++){
                if(i<4){
                    Map.Entry<String, Integer> entry = list2.get(i);
                    Users usersByuserId = usersMapper.getUsersByuserId(entry.getKey());
                    list.add(usersByuserId);
                }else{
                    break;
                }
            }
            toJson.setObj(list);
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
        }catch (Exception e){
            e.printStackTrace();
            toJson.setFlag(1);
            toJson.setMsg("查询失败");
        }
        return toJson;
    }


}
