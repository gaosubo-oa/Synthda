package com.xoa.service.portal;

import com.xoa.dao.portal.CapacitySiteInfoMapper;
import com.xoa.model.portal.CapacitySiteInfo;
import com.xoa.model.users.Users;
import com.xoa.service.portal.wrapper.PortalWrapper;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CapacitySiteInfoService {
    @Autowired
    private CapacitySiteInfoMapper capacitySiteInfoMapper;

    public PortalWrapper addCapacitySiteInfo(CapacitySiteInfo capacitySiteInfo,HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
              PortalWrapper portalWrapper=new PortalWrapper();
              portalWrapper.setStatus(true);
              capacitySiteInfo.setCrUserid(users.getUid());
              capacitySiteInfo.setCrUsername(users.getUserId());
              capacitySiteInfo.setCrTime(DateFormat.DateToStr(DateFormat.getCurrentTime()));
              capacitySiteInfo.setDetailTpl(0);
             int a=capacitySiteInfoMapper.insertSelective(capacitySiteInfo);
             if(a>0){
                 portalWrapper.setFlag(true);
                 portalWrapper.setMsg("OK");
                 portalWrapper.setData(capacitySiteInfo);
             }else {
                 portalWrapper.setFlag(false);
                 portalWrapper.setMsg("err");
             }
        return  portalWrapper;
    }
    public PortalWrapper updateCapacitySiteInfo(CapacitySiteInfo capacitySiteInfo,HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        PortalWrapper portalWrapper=new PortalWrapper();
        portalWrapper.setStatus(true);
        capacitySiteInfo.setCrUserid(users.getUid());
        capacitySiteInfo.setCrUsername(users.getUserId());
        capacitySiteInfo.setCrTime(DateFormat.DateToStr(DateFormat.getCurrentTime()));
        int a=capacitySiteInfoMapper.updateByPrimaryKeySelective(capacitySiteInfo);
        if(a>0){
            portalWrapper.setFlag(true);
            portalWrapper.setMsg("OK");
            portalWrapper.setData(capacitySiteInfo);
        }else {
            portalWrapper.setFlag(false);
            portalWrapper.setMsg("err");
        }
        return  portalWrapper;
    }


    public BaseWrappers selectCapacitySiteInfoList(HttpServletRequest request,  Integer page, Integer pageSize){
        BaseWrappers baseWrappers=new BaseWrappers();
        Map<String,Object> objectMap=new HashMap<String,Object> ();
        page = (page - 1) * pageSize;
        objectMap.put("page", page);
        objectMap.put("pageSize", pageSize);
      List<CapacitySiteInfo> capacitySiteInfos= capacitySiteInfoMapper.selectList(objectMap);
      Integer total=capacitySiteInfoMapper.selectCount(objectMap);
        baseWrappers.setStatus(true);
        baseWrappers.setFlag(true);
        baseWrappers.setMsg("ok");
        baseWrappers.setDatas(capacitySiteInfos);
        baseWrappers.setTotal(total);
        return  baseWrappers;
    }
    public PortalWrapper queryCapacitySiteInfoOne(Integer sid){
        PortalWrapper portalWrapper=new PortalWrapper();
        portalWrapper.setStatus(true);
        CapacitySiteInfo capacitySiteInfo=capacitySiteInfoMapper.selectByPrimaryKey(sid);
        if(capacitySiteInfo!=null){
            portalWrapper.setData(capacitySiteInfo);
            portalWrapper.setMsg("ok");
            portalWrapper.setFlag(true);

        }else {
            portalWrapper.setMsg("err");
            portalWrapper.setFlag(false);
        }
        return  portalWrapper;
    }
    public PortalWrapper deleteCapacitySiteInfoOne(Integer sid){
        PortalWrapper portalWrapper=new PortalWrapper();
        portalWrapper.setStatus(true);
        Integer capacitySiteInfo=capacitySiteInfoMapper.deleteByPrimaryKey(sid);
        if(capacitySiteInfo>0){
            portalWrapper.setFlag(true);
            portalWrapper.setMsg("OK");
         }else {
            portalWrapper.setFlag(false);
            portalWrapper.setMsg("err");
        }
        return  portalWrapper;
    }

}
