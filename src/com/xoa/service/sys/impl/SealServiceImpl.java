package com.xoa.service.sys.impl;

import com.dianju.sign.DSign;
import com.xoa.dao.sys.SealMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.enclosure.Attachment;
import com.xoa.model.sys.Seal;
import com.xoa.model.sys.SealLog;
import com.xoa.model.sys.SealWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.sys.SealLogService;
import com.xoa.service.sys.SealService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.util.*;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/8/17 16:31
 * 类介绍  :   印章管理
 * 构造参数:
 */
@Service
public class SealServiceImpl implements SealService {

    @Resource
    private SealMapper sealMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private SealLogService sealLogService;

    @Override
    public ToJson<Object> addSealObject( HttpServletRequest request,SealWithBLOBs sealWithBLOBs) {
        ToJson<Object> json =new ToJson<Object>(1,"err");

        //从session中获取当前登录人的信息
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userId = users.getUserId();
        sealWithBLOBs.setUserStr(userId+",");
        if(sealWithBLOBs.getSealId()==null){
            sealWithBLOBs.setSealId("");
        }
        if(sealWithBLOBs.getDeptId()==null){
            sealWithBLOBs.setDeptId("");
        }
        if(sealWithBLOBs.getSealName()==null){
            sealWithBLOBs.setSealName("");
        }
        if(sealWithBLOBs.getCertStr()==null){
            sealWithBLOBs.setCertStr("");
        }
        if(sealWithBLOBs.getUserStr()==null){
            sealWithBLOBs.setUserStr("");
        }
        if(sealWithBLOBs.getSealData()==null){
            sealWithBLOBs.setSealData("");
        }
        Date date =new Date();
        sealWithBLOBs.setCreateTime(date);
        try{
            int i = sealMapper.insertSelective(sealWithBLOBs);
            SealLog sealLog =new SealLog();
            sealLog.setsId(sealWithBLOBs.getSealId());
            sealLog.setUserId(userId);
            sealLog.setLogTime(date);
            sealLog.setLogType("makeseal");
            sealLog.setResult("制章成功");
            sealLog.setIpAdd(IpAddr.getIpAddress(request));
            int i1 = sealLogService.addSealLog(sealLog);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }
        }
        catch (Exception e){
            json.setFlag(1);
            json.setMsg("err");
           e.getMessage();
        }

        return json;
    }

    @Override
    public ToJson<Object> editSealObject(HttpServletRequest request,SealWithBLOBs seal) {
        ToJson<Object> json = new ToJson<Object>(1,"err");

        try{
            Date date =new Date();
            int i = sealMapper.updateByPrimaryKeySelective(seal);
            //从session中获取当前登录人的信息
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            String userId = users.getUserId();
            SealLog sealLog =new SealLog();
            SealWithBLOBs sealById = sealMapper.getSealById(Integer.valueOf(seal.getId()));
            sealLog.setsId(sealById.getSealId());
            sealLog.setUserId(userId);
            sealLog.setLogTime(date);
            sealLog.setLogType("setseal");
            //处理授权人信息
            StringBuffer sb =new StringBuffer();
            if(seal.getUserStr()!=null && seal.getUserStr()!=""){
                String userStr = seal.getUserStr();
                String[] split = userStr.split(",");
                for(String s:split){
                    Users usersByuserId = usersMapper.getUsersByuserId(s);
                    sb.append(usersByuserId.getUserName()+",");
                }
                seal.setUserName(sb.toString());
            }else{
                seal.setUserName("");
            }
            sealLog.setResult("授权给:"+seal.getUserName());
            sealLog.setIpAdd(IpAddr.getIpAddress(request));
            int i1 = sealLogService.addSealLog(sealLog);
            if(i>0){
                json.setFlag(0);
                json.setMsg("ok");
            }
        }catch (Exception e){
            e.getMessage();
        }
        return json;
    }

    @Override
    public List<SealWithBLOBs> getSealByUser(HttpServletRequest request) {
        List<SealWithBLOBs> sealByUser=new ArrayList<SealWithBLOBs>();
        //从session中获取当前登录人的信息
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userId = users.getUserId();
        if(userId!=null){
             sealByUser = sealMapper.getSealByUser(userId);
        }
        for(SealWithBLOBs sealWithBLOBs:sealByUser){
            //附件处理
            List<Attachment> attachmentList=new ArrayList<Attachment>();
            if(sealWithBLOBs.getAttachmentName()!=null&&!"".equals(sealWithBLOBs.getAttachmentName())){
                attachmentList= GetAttachmentListUtil.returnAttachment(sealWithBLOBs.getAttachmentName(),sealWithBLOBs.getAttachmentId(),"xoa" + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId")),GetAttachmentListUtil.MODULE_SEAL);
            }
            if(attachmentList!=null){
                for(Attachment attachment:attachmentList){
                    sealWithBLOBs.setUrl(attachment.getAttUrl());
                    sealWithBLOBs.setName(attachment.getAttachName());
                }
            }
        }
        return sealByUser;
    }

    @Override
    public ToJson<SealWithBLOBs> getAllSealInfo(HttpServletRequest request,SealWithBLOBs sealWithBLOBs,String startTime,String endTime) {
        ToJson<SealWithBLOBs> json =new ToJson<SealWithBLOBs>(1,"err");
        //从session中获取当前登录人的信息
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userId = users.getUserId();
        if(StringUtils.checkNull(userId)){
            return json;
        }
        try {
            Map<String,Object> map =new HashMap<String,Object>();
            map.put("sealWithBLOBs",sealWithBLOBs);
            map.put("startTime",startTime);
            map.put("endTime",endTime);
            map.put("userId",users.getUserPriv()!=1?userId:"");//角色不为OA管理员，根据权限设置
            //lr增加分页功能
            PageParams page=null;
            try {
                String pageSize=request.getParameter("pageSize");
                String useFlag=request.getParameter("useFlag");
                String pageIndex=request.getParameter("page");
                if(!StringUtils.checkNull(pageSize)&&!StringUtils.checkNull(useFlag)&&!StringUtils.checkNull(pageIndex)){
                    Boolean useflag=Boolean.valueOf(useFlag);
                    if(useflag){
                        page=new PageParams();
                        page.setUseFlag(useflag);
                        page.setPageSize(Integer.valueOf(pageSize));
                        page.setPage(Integer.valueOf(pageIndex));
                        map.put("page",page);
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
            List<SealWithBLOBs> allSealInfo = sealMapper.getAllSealInfo(map);
            for(SealWithBLOBs sealWithBLOBs1:allSealInfo){
                StringBuffer sb =new StringBuffer();
                if(sealWithBLOBs1.getUserStr()!=null && sealWithBLOBs1.getUserStr()!=""){
                    String userStr = sealWithBLOBs1.getUserStr();
                    String[] split = userStr.split(",");
                    for(String s:split){
                        Users usersByuserId = usersMapper.getUsersByuserId(s);
                        if(usersByuserId != null){
                            sb.append(usersByuserId.getUserName()+",");
                        }
                    }
                    sealWithBLOBs1.setUserName(sb.toString());
                }else{
                    sealWithBLOBs1.setUserName("");
                }
            }
            if(page!=null){
                json.setTotleNum(page.getTotal());
            }
            json.setFlag(0);
            json.setObj(allSealInfo);
            json.setMsg("ok");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;

    }

    @Override
    public ToJson<SealWithBLOBs> getSealById(String id) {
        ToJson<SealWithBLOBs> json =new ToJson<SealWithBLOBs>(1,"err");
        try {
            if(id!=null){
                StringBuffer sb =new StringBuffer();
                SealWithBLOBs sealById = sealMapper.getSealById(Integer.valueOf(id));
                if(sealById.getUserStr()!=null && sealById.getUserStr()!=""){
                    String[] split = sealById.getUserStr().split(",");
                    for(String s:split) {
                        Users usersByuserId = usersMapper.getUsersByuserId(s);
                        if(usersByuserId != null) {
                            sb.append(usersByuserId.getUserName() + ",");
                        }
                    }
                    sealById.setUserName(sb.toString());
                }else{
                    sealById.setUserName(sb.toString());
                }
                json.setObject(sealById);
                json.setFlag(0);
                json.setMsg("ok");
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return json;

    }

    @Override
    public ToJson<Object> deleteSeal(HttpServletRequest request,String[] ids) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            for(String s :ids){
                //从session中获取当前登录人的信息
                Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
                String userId = users.getUserId();
                Date date= new Date();
                SealLog sealLog =new SealLog();
                if(s!=null && s!="") {
                    SealWithBLOBs sealById = sealMapper.getSealById(Integer.valueOf(s));
                    sealLog.setsId(sealById.getSealId());
                }else{
                    sealLog.setsId("");
                }
                sealLog.setUserId(userId);
                sealLog.setLogTime(date);
                sealLog.setLogType("deleteseal");
                sealLog.setResult("删除成功");
                sealLog.setIpAdd(IpAddr.getIpAddress(request));
                int i1 = sealLogService.addSealLog(sealLog);
            }
            sealMapper.deleteSeal(ids);
            json.setFlag(0);
            json.setMsg("ok");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> getSealIdById(HttpServletRequest request, String id) {
        ToJson<Object> json =new ToJson<Object>(1,"err");
        try {
            Seal sealLogBySealId = sealMapper.getSealLogBySealIdLastOne(id);
            String sealId_1="0001";
            if(sealLogBySealId!=null){
                String sealId = sealLogBySealId.getSealId();
                //截取前半段字符
                String s=sealId.substring(0,sealId.length()-3);
                //截取后半段字符
                String s2=sealId.substring(sealId.length()-3,sealId.length());
                Integer integer = Integer.valueOf(s2);
                integer+=1;
                String s1 = integer.toString();
                if(s1.length()==1){
                s2="000"+integer;
                sealId_1=s2;
                }else if(s1.length()==2){
                    s2="00"+integer;
                    sealId_1=s2;
                }
                else if(s1.length()==3){
                    s2="0"+integer;
                    sealId_1=s2;
                }
                else if(s1.length()==4){
                    s2=integer.toString();
                    sealId_1=s2;
                }
            }
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(sealId_1);
        } catch (Exception e) {
            e.printStackTrace();
        }
         return json;
    }

    @Override
    public ToJson<SealWithBLOBs> getSealBySealId(HttpServletRequest request, String sealId) {
        ToJson<SealWithBLOBs> json =new ToJson<SealWithBLOBs>(1,"err");
        try {
            Seal sealLogBySealId = sealMapper.getSealLogBySealId(sealId);
            json.setFlag(0);
            json.setMsg("ok");
            json.setObject(sealLogBySealId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public String querySealById(HttpServletRequest request, Integer sealId) {
        if(sealId == null){
            return "0";
        }
        SealWithBLOBs seal = sealMapper.getSealById(sealId);
        if(seal != null && !StringUtils.checkNull(seal.getSealData())){
            return "STRDATA:"+seal.getSealData();
        }
        return "1";
    }

    @Override
    public String parseAllSeal(String sealData) {
        if(StringUtils.checkNull(sealData)){
            return "0";
        }
        DSign dSign = new DSign();
        //设置印章、签字数据
        dSign.setStoreData(sealData);
        //设置印章或者签名绑定的数据
        dSign.SetSealSignData("", "");
        //验证解析签章数据返回xml以便移动终端显示印章
        String seal = dSign.parseAllSeal(false);
        if(!"<Seals />".equals(seal) && !StringUtils.checkNull(seal)) {
            return seal;
        }
        return "1";
    }

    @Override
    public String parseAppSeal(HttpServletRequest request, String sealData,Integer sealW,Integer sealH,String sealName,String sealPosition,String sealX,String sealY,String oriData) {
        //从session中获取当前登录人的信息
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userName = users.getUserName();
        if(StringUtils.checkNull(sealData) || StringUtils.checkNull(userName)){
            return "0";
        }
        DSign dSign = new DSign();
        String seal = dSign.addSealByPic(sealData, sealW, sealH, userName, sealName, sealPosition, sealX, sealY, oriData);
        if(!"<Seals />".equals(seal) && !StringUtils.checkNull(seal)) {
            return seal;
        }
        return "1";
    }

    @Override
    public String parseSealToWebsign(HttpServletRequest request, String sealData, String psw, String sealName, String sealPosition, String sealX, String sealY, String oriData) {
        //从session中获取当前登录人的信息
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        String userName = users.getUserName();
        if(StringUtils.checkNull(sealData) || StringUtils.checkNull(userName)){
            return "0";
        }
        DSign dSign = new DSign();
        String addSeal = dSign.addSeal(sealData, psw, userName, sealName, sealPosition, sealX, sealY, oriData);
        return parseAllSeal(addSeal)+"<xoawebsign>"+addSeal+"</xoawebsign>";
    }

    /**
    * @创建作者:李然  Lr
    * @方法描述：修改印章，修改对应日志
    * @创建时间：16:45 2019/6/23
    **/
    @Override
    public synchronized ToJson<Object> updateSeal(HttpServletRequest request, SealWithBLOBs seal, SealLog sealLog) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        ToJson toJson=new ToJson(1,"err");
        try {
            Integer sealResult=sealMapper.updateByPrimaryKeySelective(seal);
            sealLog.setsId(seal.getSealId());
            sealLog.setUserId(users.getUserId());
            sealLog.setLogTime(new Date());
            sealLog.setIpAdd(IpAddr.getIpAddress(request));
            Integer sealLogResult = sealLogService.addSealLog(sealLog);
            if(sealResult>0){
                toJson.setMsg("ok");
                toJson.setFlag(0);
                if(sealLogResult<1){
                    toJson.setMsg("插入日志失败");
                }
            }else{
                toJson.setMsg("未检测到此印章");
            }
        } catch (Exception e) {
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }
}
