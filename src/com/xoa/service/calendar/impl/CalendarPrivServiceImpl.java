package com.xoa.service.calendar.impl;

import com.xoa.dao.calendarLeaderPriv.CalendarLeaderPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.calendarLeaderPriv.CalendarLeaderPriv;
import com.xoa.model.users.Users;
import com.xoa.service.calendar.CalendarPrivService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by 刘建 on 2020/7/30 11:24
 */
@Service
public class CalendarPrivServiceImpl  implements CalendarPrivService {

    @Resource
    CalendarLeaderPrivMapper calendarLeaderPrivMapper;

    @Resource
    UsersMapper usersMapper;

    @Override
    public ToJson<CalendarLeaderPriv> saveCalendarPriv(CalendarLeaderPriv calendarLeaderPriv) {
        ToJson toJson = new ToJson(1,"err");
        try {
            int i = calendarLeaderPrivMapper.insertSelective(calendarLeaderPriv);
            if(i>0){
                toJson.setFlag(0);
                toJson.setMsg("true");
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<CalendarLeaderPriv> delCalendarPriv(Integer privId) {
        ToJson toJson = new ToJson(1,"err");
        try {
            int i = calendarLeaderPrivMapper.deleteByPrimaryKey(privId);
            if(i>0){
                toJson.setFlag(0);
                toJson.setMsg("true");
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<CalendarLeaderPriv> editCalendarPriv(CalendarLeaderPriv calendarLeaderPriv) {
        ToJson toJson = new ToJson(1,"err");
        try {
            int i = calendarLeaderPrivMapper.updateByPrimaryKeySelective(calendarLeaderPriv);
            if(i>0){
                toJson.setFlag(0);
                toJson.setMsg("true");
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<CalendarLeaderPriv> selAllCalendarPriv(boolean useFlag ,Integer page, Integer pageSize) {
        ToJson toJson = new ToJson(1,"err");
        try {
            Map map = new HashMap();
            PageParams pageParams = new PageParams( useFlag , page, pageSize);
            map.put("page",pageParams);
            List<CalendarLeaderPriv> calendarLeaderPrivs = calendarLeaderPrivMapper.selectAll(map);
            if(calendarLeaderPrivs.size()>0) {
                for (CalendarLeaderPriv calendarLeaderPriv : calendarLeaderPrivs) {
                    if (calendarLeaderPriv != null) {
                        if (!StringUtils.checkNull(calendarLeaderPriv.getManagers())) {
                            String[] managers = calendarLeaderPriv.getManagers().split(",");
                            StringBuffer managerName = new StringBuffer();
                            for (String manager : managers) {
                                if (!StringUtils.checkNull(manager)) {
                                    if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(manager))) {
                                        managerName.append(usersMapper.getUsernameByUserId(manager) + ",");
                                    }
                                }
                            }
                            calendarLeaderPriv.setManagerNames(managerName.toString());
                        }
                        if (!StringUtils.checkNull(calendarLeaderPriv.getQueryPrivUsers())) {
                            String[] queryPriv = calendarLeaderPriv.getQueryPrivUsers().split(",");
                            StringBuffer queryName = new StringBuffer();
                            for (String query : queryPriv) {
                                if (!StringUtils.checkNull(query)) {
                                    if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(query))) {
                                        queryName.append(usersMapper.getUsernameByUserId(query) + ",");
                                    }
                                }
                            }
                            calendarLeaderPriv.setQueryPrivNames(queryName.toString());
                        }
                        if (!StringUtils.checkNull(calendarLeaderPriv.getEditPrivUsers())) {
                            String[] editPriv = calendarLeaderPriv.getEditPrivUsers().split(",");
                            StringBuffer editName = new StringBuffer();
                            for (String edit : editPriv) {
                                if (!StringUtils.checkNull(edit)) {
                                    if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(edit))) {
                                        editName.append(usersMapper.getUsernameByUserId(edit) + ",");
                                    }
                                }
                            }
                            calendarLeaderPriv.setEditPrivNames(editName.toString());
                        }
                    }
                }
                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObj(calendarLeaderPrivs);
                toJson.setTotleNum(pageParams.getTotal());
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<CalendarLeaderPriv> findCalendarPriv(Integer privId) {
        ToJson toJson = new ToJson(1,"err");
        try {
            CalendarLeaderPriv calendarLeaderPriv = calendarLeaderPrivMapper.selectByPrimaryKey(privId);
            if(calendarLeaderPriv != null){
                if (!StringUtils.checkNull(calendarLeaderPriv.getManagers())) {
                    String[] managers = calendarLeaderPriv.getManagers().split(",");
                    StringBuffer managerName = new StringBuffer();
                    for (String manager : managers) {
                        if (!StringUtils.checkNull(manager)) {
                            if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(manager))) {
                                managerName.append(usersMapper.getUsernameByUserId(manager) + ",");
                            }
                        }
                    }
                    calendarLeaderPriv.setManagerNames(managerName.toString());
                }
                if (!StringUtils.checkNull(calendarLeaderPriv.getQueryPrivUsers())) {
                    String[] queryPriv = calendarLeaderPriv.getQueryPrivUsers().split(",");
                    StringBuffer queryName = new StringBuffer();
                    for (String query : queryPriv) {
                        if (!StringUtils.checkNull(query)) {
                            if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(query))) {
                                queryName.append(usersMapper.getUsernameByUserId(query) + ",");
                            }
                        }
                    }
                    calendarLeaderPriv.setQueryPrivNames(queryName.toString());
                }
                if (!StringUtils.checkNull(calendarLeaderPriv.getEditPrivUsers())) {
                    String[] editPriv = calendarLeaderPriv.getEditPrivUsers().split(",");
                    StringBuffer editName = new StringBuffer();
                    for (String edit : editPriv) {
                        if (!StringUtils.checkNull(edit)) {
                            if (!StringUtils.checkNull(usersMapper.getUsernameByUserId(edit))) {
                                editName.append(usersMapper.getUsernameByUserId(edit) + ",");
                            }
                        }
                    }
                    calendarLeaderPriv.setEditPrivNames(editName.toString());
                }

                toJson.setFlag(0);
                toJson.setMsg("true");
                toJson.setObject(calendarLeaderPriv);
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    @Override
    public ToJson<CalendarLeaderPriv> getLeader(HttpServletRequest request) {
        ToJson toJson = new ToJson(1,"err");
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        Set<String> set = new HashSet();
        Map<String ,String> userMap = new HashMap();
        try {
            List<CalendarLeaderPriv> calendarLeaderPrivs = calendarLeaderPrivMapper.selectLeader(users.getUserId());
            for(CalendarLeaderPriv calendarLeaderPriv :calendarLeaderPrivs){
                String managers = calendarLeaderPriv.getManagers();
                if(!StringUtils.checkNull(managers)){
                    String[] split = managers.split(",");
                    for(String userId :split){
                        set.add(userId);
                    }
                }
            }
            if (set.size()>0) {
                for (String userId : set) {
                    String usernameByUserId = usersMapper.getUsernameByUserId(userId);
                    if (!StringUtils.checkNull(usernameByUserId)) {
                        userMap.put(userId,usernameByUserId);
                    }
                }
            }
            toJson.setFlag(0);
            toJson.setMsg("true");
            toJson.setObject(userMap);
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }
}
