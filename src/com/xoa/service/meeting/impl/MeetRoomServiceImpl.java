package com.xoa.service.meeting.impl;

import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.meet.MeetingMapper;
import com.xoa.dao.meet.MeetingRoomMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.department.Department;
import com.xoa.model.meet.MeetingRoomWithBLOBs;
import com.xoa.model.meet.MeetingWithBLOBs;
import com.xoa.model.users.Users;
import com.xoa.service.meeting.MeetRoomService;
import com.xoa.service.meeting.MeetingService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.apache.commons.beanutils.ConvertUtils;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 创建作者:   高亚峰
 * 创建日期:   2017/7/29 12:58
 * 类介绍  :   会议室管理模块
 * 构造参数:
 */
@Service
public class MeetRoomServiceImpl implements MeetRoomService {
    @Resource
    private MeetingRoomMapper meetingRoomMapper;
    @Resource
    private DepartmentMapper departmentMapper;
    @Resource
    private UsersMapper usersMapper;
    @Resource
    private MeetingMapper meetingMapper;

    @Resource
    private MeetingService meetingService;

    @Override
    public ToJson<MeetingRoomWithBLOBs> getAllMeetRoomInfo(Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingRoomWithBLOBs> json =new ToJson<MeetingRoomWithBLOBs>();
        Map<String,Object> map =new HashMap<String,Object>();
        PageParams pageParams =new PageParams();
        pageParams.setUseFlag(useFlag);
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        map.put("page", pageParams);

        try {
            //获取会议信息
            List<MeetingRoomWithBLOBs> allMeetRoomInfo = meetingRoomMapper.getAllMeetRoomInfo(map);

            //获取所有涉及到的用户信息
            Map<String,String> userMap = new HashMap();
            String managerIds = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getManagerids).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String meetRoomPerson = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getMeetroomperson).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String userIds = (managerIds + "," + meetRoomPerson).replaceAll(",,",",");
            if(!StringUtils.checkNull(userIds) && !userIds.equals(",")) {
                List<Users> users = usersMapper.getUsersByUids(userIds.split(","));
                for (Users user : users) {
                    userMap.put(user.getUid().toString(), user.getUserName());
                }
            }

            //获取所有涉及到的部门信息
            Map<String,String> deptMap = new HashMap();
            String meetRoomDeptIds = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getMeetroomdept).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String deptIds = meetRoomDeptIds.replaceAll("ALL_DEPT,", "").replaceAll("ALL_DEPT", "").replace(",,",",");
            if(!StringUtils.checkNull(deptIds)) {
                List<Department> depts = departmentMapper.selDeptByIds(deptIds.split(","));
                for (Department dept : depts) {
                    deptMap.put(dept.getDeptId().toString(),dept.getDeptName());
                }
            }

            //遍历
            for(MeetingRoomWithBLOBs meetingRoomWithBLOBs:allMeetRoomInfo){
                //设置上会议室地址
                if(meetingRoomWithBLOBs.getMrPlace()==null){
                    meetingRoomWithBLOBs.setMrPlace("");
                }
                //声明一个StringBuffter 用来接收会议管理员姓名
                StringBuffer sbmanagername =new StringBuffer();
                // 得到会议管理员的id
                String managerids = meetingRoomWithBLOBs.getManagerids();
                if(managerids!=null && managerids!=""){
                    String[] split = managerids.split(",");
                    for(String s:split){
                        //String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                        //if(!StringUtils.checkNull(usernameById)){
                        if(!StringUtils.checkNull(userMap.get(s))) {
                            sbmanagername.append(userMap.get(s)+",");
                        }
                    }
                }
                meetingRoomWithBLOBs.setManagetnames(sbmanagername.toString());
                //得到会议人员信息的ID
                String meetroomperson = meetingRoomWithBLOBs.getMeetroomperson();
                //得到会议部门信息的ID
                String meetroomdept = meetingRoomWithBLOBs.getMeetroomdept();
                //设定一个StringBuffer 来接收查出来的名字，用，分割,另一个同理用来接收部门
                StringBuffer sb =new StringBuffer();
                StringBuffer sbdept =new StringBuffer();
               if(meetroomperson!=null && meetroomperson!=""){
                   //拆分ID
                   String[] split = meetroomperson.split(",");
                   for(String s:split){
                       //String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                       //if(!StringUtils.checkNull(usernameById)){
                       if(!StringUtils.checkNull(userMap.get(s))) {
                           sb.append(userMap.get(s)+",");
                       }
                   }
               }
               if(meetroomdept!=null && meetroomdept!="" && !"ALL_DEPT".equals(meetroomdept)){
                   //拆分id
                   String[] split = meetroomdept.split(",");
                   for(String s:split) {
                       //String deptNameByDeptId = departmentMapper.getDeptNameByDeptId(Integer.valueOf(s));
                       //if (!StringUtils.checkNull(deptNameByDeptId)) {
                       if(!StringUtils.checkNull(deptMap.get(s))){
                           sbdept.append(deptMap.get(s) + ",");
                       }
                   }
               }else if("ALL_DEPT".equals(meetroomdept)){
                   sbdept.append("全部部门");
               }
               //给会议信息添加上用户属性
                meetingRoomWithBLOBs.setMeetroompersonName(sb.toString());
               //给会议信息添加上部门属性
               meetingRoomWithBLOBs.setMeetroomdeptName(sbdept.toString());
               if(meetingRoomWithBLOBs.getSid()!=null){
                   MeetingWithBLOBs meetingWithBLOBs=new MeetingWithBLOBs();
                   meetingWithBLOBs.setMeetRoomId(meetingRoomWithBLOBs.getSid());
                   Map<String,Object> meetMap=new HashedMap();
                   meetMap.put("meetingWithBLOBs",meetingWithBLOBs);
                   meetingRoomWithBLOBs.setMeetingWithBLOBs(meetingMapper.queryMeeting(meetMap));
               }
            }
            if (pageParams.getTotal() == null) {
                json.setTotleNum(0);
            } else {
                json.setTotleNum(pageParams.getTotal());
            }
            json.setObj(allMeetRoomInfo);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (NumberFormatException e) {
            json.setMsg("err");
            json.setFlag(1);
            json.setObj(null);
            e.printStackTrace();
        }
       return json;
    }

    @Override
    public ToJson<MeetingRoomWithBLOBs> getMeetRoomBySid(HttpServletRequest request,String sid) {
        ToJson<MeetingRoomWithBLOBs> json =new ToJson<MeetingRoomWithBLOBs>();
        if(sid!=null && sid!=""){
            try {
                MeetingRoomWithBLOBs meetRoomBySid = meetingRoomMapper.getMeetRoomBySid(Integer.valueOf(sid));
                if(meetRoomBySid!=null){
                    //获取关于该会议室中会议的详情
                    MeetingWithBLOBs meetingWithBLOBs=new MeetingWithBLOBs();
                    meetingWithBLOBs.setMeetRoomId(Integer.valueOf(sid));
                    meetRoomBySid.setMeetingWithBLOBs(meetingService.queryMeeting(request, meetingWithBLOBs,1,0,false,null).getObj());

                    //声明一个StringBuffter 用来接收会议管理员姓名
                    StringBuffer sbmanagername =new StringBuffer();
                    // 得到会议管理员的id
                    String managerids = meetRoomBySid.getManagerids();
                    if(managerids!=null && managerids!=""){
                        String[] split = managerids.split(",");
                        for(String s:split){
                            String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                            if(usernameById!=null && usernameById!=""){
                                sbmanagername.append(usernameById+",");
                            }
                        }
                    }

                    meetRoomBySid.setManagetnames(sbmanagername.toString());
                    //得到会议人员信息的ID
                    String meetroomperson = meetRoomBySid.getMeetroomperson();
                    //得到会议部门信息的ID
                    String meetroomdept = meetRoomBySid.getMeetroomdept();
                    //设定一个StringBuffer 来接收查出来的名字，用，分割,另一个同理用来接收部门
                    StringBuffer sb =new StringBuffer();
                    StringBuffer sbdept =new StringBuffer();
                    if(meetroomperson!=null && meetroomperson!=""){
                        //拆分ID
                        String[] split = meetroomperson.split(",");
                        for(String s:split){
                            String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                            if (!StringUtils.checkNull(usernameById)) {
                                sb.append(usernameById + ",");
                            }
                        }
                    }
                    if(meetroomdept!=null && meetroomdept!="" && !"ALL_DEPT".equals(meetroomdept)){
                        //拆分id
                        String[] split = meetroomdept.split(",");
                        for(String s:split){
                            String deptNameByDeptId = departmentMapper.getDeptNameByDeptId(Integer.valueOf(s));
                            if (!StringUtils.checkNull(deptNameByDeptId)) {
                                sbdept.append(deptNameByDeptId + ",");
                            }
                        }
                    }else if("ALL_DEPT".equals(meetroomdept)){
                        sbdept.append("全部部门");
                    }
                    //给会议信息添加上用户属性
                    meetRoomBySid.setMeetroompersonName(sb.toString());
                    //给会议信息添加上部门属性
                    meetRoomBySid.setMeetroomdeptName(sbdept.toString());
                    String ManageridsUserIdStr = "";
                    String MeetroompersonUserIdStr = "";
                    String ManageridsUid = meetRoomBySid.getManagerids();
                    if(ManageridsUid!=null&&!"".equals(ManageridsUid)){
                        String[] uIdStr = ManageridsUid.split(",");
                        for(int i=0;i<uIdStr.length;i++){
                            String s=uIdStr[i];
                            if (!StringUtils.checkNull(s)){
                                Users u = usersMapper.findUserByuid(Integer.valueOf(s));
                                if (u!=null && !StringUtils.checkNull(u.getUserId())){
                                    ManageridsUserIdStr += u.getUserId()+",";
                                }
                            }
                        }
                    }
                    String MeetroompersonUid = meetRoomBySid.getMeetroomperson();
                    if(MeetroompersonUid!=null&&!"".equals(MeetroompersonUid)){
                        String[] MeetUserIdStr = MeetroompersonUid.split(",");
                        for(int i=0;i<MeetUserIdStr.length;i++){
                            Users u = usersMapper.findUserByuid(Integer.valueOf(MeetUserIdStr[i]));
                            if(u !=null ){
                                MeetroompersonUserIdStr+=u.getUserId()+",";
                            }
                        }
                    }
                    meetRoomBySid.setManageridsUserId(ManageridsUserIdStr);
                    meetRoomBySid.setMeetroompersonUserId(MeetroompersonUserIdStr);
                }
                json.setObject(meetRoomBySid);
                json.setFlag(0);
                json.setMsg("ok");
            } catch (NumberFormatException e) {
                json.setObject(null);
                json.setFlag(1);
                json.setMsg("err");
                e.printStackTrace();
            }
        }
        return json;
    }

    @Override
    public ToJson<Object> deleteMeetRoomBySid(HttpServletRequest request,String sid) {
        ToJson<Object> json =new ToJson<Object>();
        if(sid!=null && sid!=""){
            try {
                meetingRoomMapper.deleteMeetRoomBySid(Integer.valueOf(sid));
                json.setFlag(0);
                json.setMsg("ok");
            } catch (NumberFormatException e) {
                json.setFlag(1);
                json.setMsg("err");
                e.printStackTrace();
            }
        }
        return json;
    }

    @Override
    public ToJson<Object> addMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs) {
        ToJson<Object> json =new ToJson<Object>();
        try {
            meetingRoomMapper.insertSelective(meetingRoomWithBLOBs);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<Object> editMeetRoom(HttpServletRequest request,MeetingRoomWithBLOBs meetingRoomWithBLOBs) {
        ToJson<Object> json =new ToJson<Object>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
        try {
            meetingRoomMapper.editMeetRoom(meetingRoomWithBLOBs);

            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public ToJson<MeetingRoomWithBLOBs> getAllMeetRoom(HttpServletRequest request, Integer page, Integer pageSize, boolean useFlag) {
        ToJson<MeetingRoomWithBLOBs> json = new ToJson<MeetingRoomWithBLOBs>(1, "err");
        PageParams pageParams = new PageParams(useFlag, page, pageSize);
        try {
            //从session中获取当前登录人的信息
            Cookie redisSessionId = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionId);
            Integer uid = users.getUid();
            Integer deptId = users.getDeptId();
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("uid", uid);
            map.put("deptId", deptId);
            map.put("page", pageParams);
            List<MeetingRoomWithBLOBs> someMeetRoom = meetingRoomMapper.getSomeMeetRoom(map);
            if (!CollectionUtils.isEmpty(someMeetRoom)) {
                //处理管理员用户名称
                Set<Integer> listUId = new HashSet<>();
                Set<String> listManagerIds = someMeetRoom.stream().map(MeetingRoomWithBLOBs::getManagerids).collect(Collectors.toSet());
                for (String managerids : listManagerIds) {
                    if (!StringUtils.checkNull(managerids)) {
                        listUId.addAll(Arrays.asList((Integer[]) ConvertUtils.convert(managerids.split(","), Integer.class)));
                    }
                }
                List<Users> listUsers = usersMapper.selectUserInfoByUserIdSetByUid(listUId);
                for (MeetingRoomWithBLOBs meetingWithBLOBs : someMeetRoom) {
                    //处理管理员用户名称
                    if (!StringUtils.checkNull(meetingWithBLOBs.getManagerids())) {
                        StringBuffer userName = new StringBuffer();
                        for (String managerid : meetingWithBLOBs.getManagerids().split(",")) {
                            boolean flag = true;
                            for (Users listUser : listUsers) {
                                if (Integer.valueOf(managerid).equals(listUser.getUid())) {
                                    userName.append(listUser.getUserName() != null ? listUser.getUserName() : "").append(",");
                                    flag = false;
                                }
                            }
                            if (flag) {
                                userName.append(",");
                            }
                        }
                        meetingWithBLOBs.setManagetnames(userName.toString());
                    } else {
                        meetingWithBLOBs.setManagerids("");
                        meetingWithBLOBs.setManagetnames("");
                    }

                    if (meetingWithBLOBs.getMrName() == null) {
                        meetingWithBLOBs.setMrName("");
                    }
                }
                json.setFlag(0);
                json.setMsg("ok");
                json.setObj(someMeetRoom);
                json.setTotleNum(pageParams.getTotal());
            } else {
                json.setFlag(0);
                json.setMsg("暂无数据");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 各个会议室使用情况
     * 参数：currentDate 要查询的日期
     */
    @Override
    public ToJson<MeetingRoomWithBLOBs> getUserRoomCondition(String currentDate) {
        ToJson<MeetingRoomWithBLOBs> json =new ToJson<MeetingRoomWithBLOBs>();
        Map<String,Object> map =new HashMap<String,Object>();
        try {
            //获取会议信息
            List<MeetingRoomWithBLOBs> allMeetRoomInfo = meetingRoomMapper.getAllMeetRoomInfo(map);

            //获取所有涉及到的用户信息
            Map<String,String> userMap = new HashMap();
            String managerIds = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getManagerids).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String meetRoomPerson = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getMeetroomperson).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String userIds = (managerIds + "," + meetRoomPerson).replaceAll(",,",",");
            if(!StringUtils.checkNull(userIds)) {
                List<Users> users = usersMapper.getUsersByUids(userIds.split(","));
                for (Users user : users) {
                    userMap.put(user.getUid().toString(), user.getUserName());
                }
            }

            //获取所有涉及到的部门信息
            Map<String,String> deptMap = new HashMap();
            String meetRoomDeptIds = allMeetRoomInfo.stream().map(MeetingRoomWithBLOBs::getMeetroomdept).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.joining(","));
            String[] deptIds = meetRoomDeptIds.replaceAll("ALL_DEPT", "").split(",");
            deptIds = Arrays.stream(deptIds).filter(d -> !StringUtils.checkNull(d)).toArray(String[]::new);
            if(deptIds.length > 0) {
                List<Department> depts = departmentMapper.selDeptByIds(deptIds);
                for (Department dept : depts) {
                    deptMap.put(dept.getDeptId().toString(),dept.getDeptName());
                }
            }

            //遍历
            for(MeetingRoomWithBLOBs meetingRoomWithBLOBs:allMeetRoomInfo){
                //设置上会议室地址
                if(meetingRoomWithBLOBs.getMrPlace()==null){
                    meetingRoomWithBLOBs.setMrPlace("");
                }
                //声明一个StringBuffter 用来接收会议管理员姓名
                StringBuffer sbmanagername =new StringBuffer();
                // 得到会议管理员的id
                String managerids = meetingRoomWithBLOBs.getManagerids();
                if(managerids!=null && managerids!=""){
                    String[] split = managerids.split(",");
                    for(String s:split){
                        //String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                        //if(!StringUtils.checkNull(usernameById)){
                        if(!StringUtils.checkNull(userMap.get(s))){
                            sbmanagername.append(userMap.get(s)+",");
                        }
                    }
                }
                meetingRoomWithBLOBs.setManagetnames(sbmanagername.toString());
                //得到会议人员信息的ID
                String meetroomperson = meetingRoomWithBLOBs.getMeetroomperson();
                //得到会议部门信息的ID
                String meetroomdept = meetingRoomWithBLOBs.getMeetroomdept();
                //设定一个StringBuffer 来接收查出来的名字，用，分割,另一个同理用来接收部门
                StringBuffer sb =new StringBuffer();
                StringBuffer sbdept =new StringBuffer();
                if(meetroomperson!=null && meetroomperson!=""){
                    //拆分ID
                    String[] split = meetroomperson.split(",");
                    for(String s:split){
                        //String usernameById = usersMapper.getUsernameById(Integer.valueOf(s));
                        //if(!StringUtils.checkNull(usernameById)){
                        if(!StringUtils.checkNull(userMap.get(s))){
                            sb.append(userMap.get(s)+",");
                        }
                    }
                }
                if(meetroomdept!=null && meetroomdept!="" && !"ALL_DEPT".equals(meetroomdept)){
                    //拆分id
                    String[] split = meetroomdept.split(",");
                    for(String s:split) {
                        //String deptNameByDeptId = departmentMapper.getDeptNameByDeptId(Integer.valueOf(s));
                        //if (!StringUtils.checkNull(deptNameByDeptId)) {
                        if(!StringUtils.checkNull(deptMap.get(s))){
                            sbdept.append(deptMap.get(s) + ",");
                        }
                    }
                }else if("ALL_DEPT".equals(meetroomdept)){
                    sbdept.append("全部部门");
                }
                //给会议信息添加上用户属性
                meetingRoomWithBLOBs.setMeetroompersonName(sb.toString());
                //给会议信息添加上部门属性
                meetingRoomWithBLOBs.setMeetroomdeptName(sbdept.toString());
                if(meetingRoomWithBLOBs.getSid()!=null){
                    String currentBeginTime=currentDate+" 00:00:00";
                    String currentEndTime=currentDate+" 23:59:59";
                    Map<String,Object> meetMap=new HashedMap();
                    meetMap.put("meetRoomId",meetingRoomWithBLOBs.getSid());
                    meetMap.put("currentBeginTime",currentBeginTime);
                    meetMap.put("currentEndTime",currentEndTime);
                    meetingRoomWithBLOBs.setMeetingWithBLOBs(meetingMapper.queryCurrentRoomUserCondition(meetMap));
                    for(MeetingWithBLOBs meeting:meetingRoomWithBLOBs.getMeetingWithBLOBs()){
                        long currentBegin= DateFormat.getTime(currentBeginTime);
                        long currentEnd= DateFormat.getTime(currentEndTime);
                        long start=DateFormat.getTime(meeting.getStartTime());
                        long end=DateFormat.getTime(meeting.getEndTime());
                        if(start<=currentBegin){
                            meeting.setStartTime(currentBeginTime);
                        }
                        if(end>=currentEnd){
                            meeting.setEndTime(currentEndTime);
                        }
                    }
                }
            }
            json.setObj(allMeetRoomInfo);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (NumberFormatException e) {
            json.setMsg("err");
            json.setFlag(1);
            json.setObj(null);
            e.printStackTrace();
        }
        return json;
    }

    @Override
    public Integer getRoomConditionId(String name) {
        return meetingRoomMapper.getRoomConditionId(name);
    }
}
