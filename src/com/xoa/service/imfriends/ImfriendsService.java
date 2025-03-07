package com.xoa.service.imfriends;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.imfriends.ImfriendsMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.imfriends.Imfriends;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.sms.SmsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ImfriendsService {
    @Autowired
    private ImfriendsMapper imfriendsMapper;

    @Autowired
    private SysParaMapper sysParaMapper;

    @Autowired
    private SmsService smsService;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private SmsBodyMapper smsBodyMapper;


    //添加好友接口
    public ToJson addFriend(HttpServletRequest request, String fuids, String message){
        ToJson toJson=new ToJson();
        try{
            //添加好友
            //当前用户id为中间表uid
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            //判断当前用户和要申请为好友的用户是不是好友
            List<Imfriends> ulist=imfriendsMapper.getImfriendsByuid(user.getUserId());

            List<Imfriends> fulist=imfriendsMapper.getImfriendsByfuid(user.getUserId());

            //fuids处理
            String fuidStr[]=fuids.split(",");
            for(String fuid:fuidStr){
                boolean flag=PdFriends(fuid,ulist,fulist);
                //当不是好友时发起申请
                if(!flag){
                    //存入可操作id
                    StringBuffer sb=new StringBuffer();
                    sb.append(fuid);
                    Imfriends imfriends=new Imfriends();
                    imfriends.setUid(user.getUserId());
                    imfriends.setFuid(fuid);
                    imfriends.setMessage(message);
                    imfriends.setPass(0);
                    imfriendsMapper.insertSelective(imfriends);
                    //添加事务提醒
                    //向sms_body插入提醒数据
                    SmsBody smsBody = new SmsBody();
                    smsBody.setFromId(user.getUserId());
                    smsBody.setSmsType("26");
                    smsBody.setContent(user.getUserName()+" 请求添加你为好友");
                    smsBody.setSendTime((int)(System.currentTimeMillis() / 1000));
                    smsBody.setRemindUrl("/imfriends/geImfriendsByIdPage?frdId="+imfriends.getFrdId());
                    if(sb.toString().length()>=1){
                        smsService.saveSms(smsBody, sb.toString(), "1", "0", "", "", "");
                    }

                }
            }

            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }
        return toJson;
    }

    //判断当前用户和要申请为好友的用户是不是好友返回flase为不是好友
    public boolean PdFriends(String fuid, List<Imfriends> ulist, List<Imfriends> fulist){
        Boolean flag=false;

        for(Imfriends imfriends:ulist){
            if(fuid.equals(imfriends.getFuid())){
                flag=true;
            }
        }

        for(Imfriends imfriends:fulist){
            if(fuid.equals(imfriends.getUid())){
                flag=true;
            }
        }

        return flag;
    }

    // 通过主键查询数据
    public ToJson geImfriendsById(HttpServletRequest request, String frdId){
        ToJson toJson=new ToJson();
        try{
            Imfriends imfriends=imfriendsMapper.getImfriendsByfrdId(Integer.parseInt(frdId));
            //判断获取
            List list=new ArrayList();
            list.add(imfriends.getUid());
            List<Users> users=usersMapper.selectImFriend(list);
           imfriends.setAvatar(users.get(0).getAvatar());
           imfriends.setUid(users.get(0).getUserId());
           imfriends.setUserName(users.get(0).getUserName());
            toJson.setObject(imfriends);
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    //更改状态
    public ToJson updateImfriendsPassByFrdId(HttpServletRequest request, String frdId, String pass){
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson toJson=new ToJson();
        try{
            Imfriends imfriends=new Imfriends();
            imfriends.setFrdId(Integer.parseInt(frdId));
            imfriends.setPass(Integer.parseInt(pass));
            imfriendsMapper.updateByPrimaryKey(imfriends);
            //消掉事务提醒
            String remindUrl="/imfriends/geImfriendsByIdPage?frdId="+imfriends.getFrdId();
            String userId = user.getUserId();
            //根据路径查询出sms_body中的body_id
            SmsBody smsBody=smsBodyMapper.selectByRemindUrl(remindUrl);
            if(smsBody!=null){
                smsService.updateRemindFlag(request,"0",smsBody.getBodyId()+",");
            }
            //生成一条提示同意的事务
            SmsBody sms = new SmsBody();
            sms.setFromId(user.getUserId());
            sms.setSmsType("27");
            if("1".equals(pass)){
                sms.setContent(user.getUserName()+" 通过您的好友申请");
            }else if("0".equals(pass)){
                sms.setContent(user.getUserName()+" 拒绝您的好友申请");
            }
            sms.setSendTime((int)(System.currentTimeMillis() / 1000));
            sms.setRemindUrl("$geImfriendsTz");
            Imfriends imfriends1=imfriendsMapper.getImfriendsByfrdId(imfriends.getFrdId());
            StringBuffer sb=new StringBuffer();
            sb.append(imfriends1.getUid());
            if(sb.toString().length()>1){
                smsService.saveSms(sms, sb.toString(), "1", "0", "", "", "");
            }
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    //得到好友列表
    public ToJson getList(HttpServletRequest request, String userName){
        ToJson toJson=new ToJson();
        try{
            //得到所有关系
            List resultlist=new ArrayList();
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            Map<String, String> map = new HashMap<>();
            map.put("uid", user.getUserId());
            map.put("fuid", user.getUserId());
            List<Imfriends> list = imfriendsMapper.selectImfriendsList(map);
            List uidList=new ArrayList();
           //判断是搜索
            if(StringUtils.checkNull(userName)){
                //只展示列表不搜索
                userName="";
                //展示用户信息
                for(Imfriends imfriends:list){
                    if(user.getUserId().equals(imfriends.getUid())){
                        uidList.add(imfriends.getFuid());
                    }
                    if(user.getUserId().equals(imfriends.getFuid())){
                        uidList.add(imfriends.getUid());
                    }
                }
                if(uidList.size()>0) {
                    resultlist = usersMapper.selectImFriend(uidList);
                }
            }else {
                //查询
                char [] stringArr = userName.toCharArray();
                StringBuffer newStr=new StringBuffer();
                for(char s:stringArr){
                    newStr.append(s+"_");
                }
                Map<String,Object> soumap =new HashedMap();
                soumap.put("userName",userName);
                soumap.put("newStr",newStr.toString());
                List<Users> userList = usersMapper.queryUserByUserIds(soumap);

                for(Users users:userList){
                    for(Imfriends imfriends:list){
                        if(users.getUserId().equals(imfriends.getUid())|| users.getUserId().equals(imfriends.getFuid())){
                            resultlist.add(users);
                        }
                    }
                }
            }
            toJson.setObj(resultlist);
            toJson.setFlag(1);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(0);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    public ToJson getUserName(HttpServletRequest request){
        ToJson toJson=new ToJson();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            toJson.setObject(user.getUserName());
            toJson.setMsg("true");
            toJson.setFlag(0);
        }catch (Exception e){
            toJson.setMsg(e.getMessage());
            toJson.setFlag(1);
        }
        return toJson;
    }

    public ToJson getWyzFriends(HttpServletRequest request){
        ToJson toJson=new ToJson();
        try{
            //获取当前用户userId
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
            //查询未通过验证的用户
            Map map=new HashMap();
            map.put("uid",user.getUserId());
            map.put("fuid",user.getUserId());
            List<Imfriends> list=imfriendsMapper.selectImfriendsWyz(map);
            List<String> uidList=new ArrayList();
            List<String> qcList=new ArrayList();
            for(Imfriends imfriends:list){
                if(user.getUserId().equals(imfriends.getUid())){
                    uidList.add(imfriends.getFuid());
                }
                if(user.getUserId().equals(imfriends.getFuid())){
                    uidList.add(imfriends.getUid());
                }
            }
            //去重
            qcList.add(uidList.get(0));
            for(String s:uidList){
                if(!qcList.contains(s)){
                    qcList.add(s);
                }
            }
            //判断未验证消息中是否已有成为好友
            //获取是好友的列表
            List<Imfriends> hylist = imfriendsMapper.selectImfriendsList(map);
            List<String> hList=new ArrayList<>();
            for(Imfriends imfriends:hylist){
                if(user.getUserId().equals(imfriends.getUid())){
                    hList.add(imfriends.getFuid());
                }
                if(user.getUserId().equals(imfriends.getFuid())){
                    hList.add(imfriends.getUid());
                }
            }
            //判断如果是好友则不是未验证好友
            for(String h:hList){
                if(qcList.contains(h)){
                    qcList.remove(h);
                }
            }
            List resultlist= usersMapper.selectImFriend(qcList);

            toJson.setObj(resultlist);
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }
    public ToJson getIsFriends(HttpServletRequest request){
        ToJson toJson=new ToJson();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user= SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            List<SysPara> sysPara=sysParaMapper.getTheSysParam("ISIMFRIENDS");
            String value="";
            //pc端页面判断相反直接改了接口
            if("0".equals(sysPara.get(0).getParaValue())){
                value="1";
            }else if("1".equals(sysPara.get(0).getParaValue())){
                value="0";
            }
            toJson.setObject(value);
            toJson.setFlag(0);
            toJson.setMsg("true");
        }catch (Exception e){
            toJson.setFlag(1);
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

}
