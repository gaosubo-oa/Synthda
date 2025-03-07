package com.xoa.service.portals.impl;

import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.diary.DiaryModelMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.dao.modulePriv.ModulePrivMapper;
import com.xoa.dao.portals.PortalsMapper;
import com.xoa.dao.position.PositionManagementMapper;
import com.xoa.dao.users.UserFunctionMapper;
import com.xoa.dao.users.UserPrivMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.diary.DiaryModel;
import com.xoa.model.portals.Portals;
import com.xoa.model.portals.PortalsUser;
import com.xoa.model.position.UserJob;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.portals.PortalsService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2018/2/28.
 */
@Service
public class PortalsServiceImpl implements PortalsService {

    @Autowired
    private PortalsMapper portalsMapper;

    @Autowired
    private UsersMapper usersMapper;

    @Autowired
    private UserPrivMapper userPrivMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private DiaryModelMapper diaryModelMapper;

    @Autowired
    private SysParaMapper sysParaMapper;

    @Autowired
    private UserFunctionMapper userFunctionMapper;

    @Resource
    private ModulePrivMapper modulePrivMapper;

    @Autowired
    private DutiesManagementMapper dutiesManagementMapper;
    @Autowired
    private PositionManagementMapper positionManagementMapper;


    @Override
    public ToJson<Portals> addPortals(Portals portals) {
        ToJson<Portals> json = new ToJson<Portals>();
        try{
            if(portals.getModuleId()!=null || "null".equals(portals.getModuleId())){
                portals.setModuleId(portals.getModuleId());
            }
            if(!StringUtils.checkNull(portals.getSiteModuleId())){
                portals.setModuleId(portals.getSiteModuleId());
            }
            portalsMapper.insertSelective(portals);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Portals> updatePortals(HttpServletRequest request ,Portals portals) {
        String add=request.getParameter("add");
        String del=request.getParameter("del");
        ToJson<Portals> json = new ToJson<Portals>();
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
        try{
            if(!StringUtils.checkNull(portals.getSiteModuleId())){
                portals.setModuleId(portals.getSiteModuleId());
            }
            if(!StringUtils.checkNull(portals.getPortalsShow())) {
                if (Arrays.asList(portals.getPortalsShow().split(",")).contains("17")) {
                    Map<String, String> map = new HashMap<>();
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (!Arrays.asList(userFuncIdStr.split(",")).contains("0c")) {
                            userFuncIdStr = userFuncIdStr + "0c,";
                            map.put("userFuncIdStr", userFuncIdStr);
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                } else {
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (Arrays.asList(userFuncIdStr.split(",")).contains("0c")) {
                            Map<String, String> map = new HashMap<>();
                            int i = userFuncIdStr.indexOf("0c");
                            StringBuffer stringBuffer = new StringBuffer();
                            stringBuffer.append(userFuncIdStr);
                            stringBuffer.delete(i, i + 3);
                            map.put("userFuncIdStr", stringBuffer.toString());
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                }
                if (Arrays.asList(portals.getPortalsShow().split(",")).contains("18")) {
                    Map<String, String> map = new HashMap<>();
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (!Arrays.asList(userFuncIdStr.split(",")).contains("0d")) {
                            userFuncIdStr = userFuncIdStr + "0d,";
                            map.put("userFuncIdStr", userFuncIdStr);
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                } else {
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (Arrays.asList(userFuncIdStr.split(",")).contains("0d")) {
                            Map<String, String> map = new HashMap<>();
                            int i = userFuncIdStr.indexOf("0d");
                            StringBuffer stringBuffer = new StringBuffer();
                            stringBuffer.append(userFuncIdStr);
                            stringBuffer.delete(i, i + 3);
                            map.put("userFuncIdStr", stringBuffer.toString());
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                }
                if (Arrays.asList(portals.getPortalsShow().split(",")).contains("19")) {
                    Map<String, String> map = new HashMap<>();
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (!Arrays.asList(userFuncIdStr.split(",")).contains("0e")) {
                            userFuncIdStr = userFuncIdStr + "0e,";
                            map.put("userFuncIdStr", userFuncIdStr);
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                } else {
                    List<Users> all = usersMapper.selectAllUsersWithFunctionStr();
                    all.forEach(item -> {
                        String userFuncIdStr = item.getFuncIdStr();
                        if (Arrays.asList(userFuncIdStr.split(",")).contains("0e")) {
                            Map<String, String> map = new HashMap<>();
                            int i = userFuncIdStr.indexOf("0e");
                            StringBuffer stringBuffer = new StringBuffer();
                            stringBuffer.append(userFuncIdStr);
                            stringBuffer.delete(i, i + 3);
                            map.put("userFuncIdStr", stringBuffer.toString());
                            map.put("userId", item.getUserId());
                            userFunctionMapper.updateUserFuncIdStr(map);
                        }
                    });
                }
            }
            portalsMapper.updateByPrimaryKeySelective(portals);
            List<Users> list=usersMapper.getAll();
            if(!StringUtils.checkNull(add)){
                for (Users users1 : list) {
                    if(!users1.getMytableLeft().equals("ALL")){
                        String mytableLeft= users1.getMytableLeft();
                        String[] split = add.split(",");
                        //循环判断已存在的门户模块位置不动，新增加的模块位置放在最后
                        for (String tableLeft : split) {
                            String left = tableLeft + ",";
                            if(!mytableLeft.contains(left)){
                                mytableLeft += left;
                            }
                        }
                        users1.setMytableLeft(mytableLeft);
                        usersMapper.updateMyTableLefts(users1);
                    }
                }
            }
            if(!StringUtils.checkNull(del)){
                    for (Users users1 : list) {
                        if(!users1.getMytableLeft().equals("ALL")){
                            String[] split = del.split(",");
                            String mytableLeft = users1.getMytableLeft();
                            //循环判断存在的门户模块位置删除，其余位置不动
                            for (String tableLeft : split) {
                                String left = tableLeft + ",";
                                if(mytableLeft.contains(left)){
                                    mytableLeft = mytableLeft.replaceAll(left,"");
                                }
                            }
                            users1.setMytableLeft(mytableLeft);
                            usersMapper.updateMyTableLefts(users1);
                        }
                }
            }
            //修改完门户表后  进行  修改用户表的 MYTABLE_LEFT 字段
            //因为已经修改  我的门户内容设置  所以用户的自定义排序失去了意义
           // usersMapper.updateMyTableLeft();

            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Portals> selPortals(PageParams pageParams, Portals portals) {
        ToJson<Portals> json = new ToJson<Portals>();
        try{
            Map<String,Object> map = new HashMap<String,Object>();
            //map.put("page",pageParams);

            List<Portals> portals1 = portalsMapper.selPortals(map);

            json.setObj(portals1);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Portals> deletePortals(String PortalsIds) {
        ToJson<Portals> json = new ToJson<Portals>();
        try{
            String[] split = PortalsIds.split(",");
            portalsMapper.deletePortalsByIds(split);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Portals> selPortalsById(Integer portalsId) {
        ToJson<Portals> json = new ToJson<Portals>();
        try{
            Portals portals = portalsMapper.selPortalsById(portalsId);
            if(portals.getAccessPriv()!=null&&portals.getAccessPriv().equals(1)){
                // 获取授权用户信息
                String accessPrivUser = portals.getAccessPrivUser();
                if(!StringUtils.checkNull(accessPrivUser)){
                    List<Users> usersByUserIds = usersMapper.getUsersByUserIds(accessPrivUser.split(","));
                    portals.setPrivUser(usersByUserIds);
                }
                // 获取授权角色信息
                String accessPrivPriv = portals.getAccessPrivPriv();
                if(!StringUtils.checkNull(accessPrivPriv)){
                    List<UserPriv> userPrivByIds = userPrivMapper.getUserPrivByIds(accessPrivPriv.split(","));
                    portals.setPrivPriv(userPrivByIds);
                }
                // 获取授权部门信息
                String accessPrivDept = portals.getAccessPrivDept();
                if(!StringUtils.checkNull(accessPrivDept)){
                    List<Department> departments = departmentMapper.selDeptByIds(accessPrivDept.split(","));
                    portals.setPrivDept(departments);
                }
            }
            json.setObject(portals);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<PortalsUser> selPortalsUser(HttpServletRequest request) {
        ToJson<PortalsUser> json = new ToJson<PortalsUser>();
        try {
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            sessionInfo = usersMapper.findUsersByuserId(sessionInfo.getUserId());
            if(sessionInfo == null){
                json.setMsg("用户信息查询为空");
                json.setFlag(1);
                return json;
            }
            PortalsUser portalsUser = new PortalsUser();
            portalsUser.setUserId(sessionInfo.getUserId());
            portalsUser.setUserName(sessionInfo.getUserName());
            portalsUser.setUserPrivName(sessionInfo.getUserPrivName());
            portalsUser.setPostName(sessionInfo.getPostName());
            portalsUser.setSex(sessionInfo.getSex());
            StringBuffer userPrivOtherName = new StringBuffer();
            //获取岗位名称
            if (sessionInfo.getJobId() != null && sessionInfo.getJobId() != 0) {
                UserJob userJob = positionManagementMapper.getUserjobId(sessionInfo.getJobId());
                portalsUser.setJobName(userJob != null?userJob.getJobName():"");
            }
            if (!StringUtils.checkNull(sessionInfo.getUserPrivOther())) {
                List<UserPriv> privNameByIds = modulePrivMapper.getPrivNameByIds(sessionInfo.getUserPrivOther().split(","));
                if (privNameByIds != null) {
                    for (int i=0;i<privNameByIds.size();i++) {
                        if(i==(privNameByIds.size()-1)){
                            userPrivOtherName.append(privNameByIds.get(i).getPrivName());
                        }else {
                            userPrivOtherName.append(privNameByIds.get(i).getPrivName() + ",");
                        }
                    }
                    portalsUser.setUserPrivOtherName(userPrivOtherName.toString());
                }
                userPrivOtherName.setLength(0);
            }
            try {
                if(StringUtils.checkNull(portalsUser.getPostName()) && sessionInfo.getPostId()!=null){//职务
                    String postName = dutiesManagementMapper.getUserPostId(sessionInfo.getPostId()).getPostName();
                    portalsUser.setPostName(!StringUtils.checkNull(postName) ? postName : "");
                }else{
                    portalsUser.setPostName("");
                }
            }catch (Exception e){
                //e.printStackTrace();
            }
            try {
                portalsUser.setDeptId(sessionInfo.getDeptId().toString());
                portalsUser.setDeptName(sessionInfo.getDeptName());
            }catch (Exception e){
                e.printStackTrace();
            }


            if(!StringUtils.checkNull(sessionInfo.getAvatar())){
                portalsUser.setAvatar(sessionInfo.getAvatar());
            } else {
                portalsUser.setAvatar(sessionInfo.getSex());
            }

            // 获取最新日志信息
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("userId",sessionInfo.getUserId());
            PageParams pageParams = new PageParams();
            pageParams.setPage(1);
            pageParams.setPageSize(1);
            map.put("page",pageParams);
            List<DiaryModel> diarySelf = diaryModelMapper.getDiarySelf(map);
            if(diarySelf!=null&&diarySelf.size()>0){
                DiaryModel diaryModel = diarySelf.get(0);
                portalsUser.setDiary(diaryModel);
            }

            map.remove("page");

            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);

            map.put("beginDate",today.getTime());

            today.set(Calendar.HOUR_OF_DAY, 23);
            today.set(Calendar.MINUTE, 59);
            today.set(Calendar.SECOND, 59);
            today.set(Calendar.MILLISECOND, 999);

            map.put("endDate",today.getTime());

            boolean currentUserWorkLogPer=false;
            boolean currentUserSchedulePer=false;
            boolean currentUserControlCenterPer=false;
            boolean currentUserMyWorkPer=false;
            boolean currentUserEmailPer=false;
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

            String userId = (String) users.getUserId();
            String str=  userFunctionMapper.getUserFuncIdStr(userId);

             // String str=(String) request.getSession().getAttribute("functionIdStr");
              String strArr[]=str.split(",");

              if (strArr!=null&&strArr.length>0){
                  for(String s:strArr){
                      // 9   工作日志
                      if ("9".equals(s)){
                          currentUserWorkLogPer=true;
                      }
                      // 11 控制面板
                      if ("11".equals(s)){
                          currentUserControlCenterPer=true;
                      }
                      // 5   我的工作
                      if ("5".equals(s)){
                          currentUserMyWorkPer=true;
                      }
                      //  8  日程安排
                      if ("8".equals(s)){
                          currentUserSchedulePer=true;
                      }
                      //  1 电子邮件
                      if ("1".equals(s)){
                          currentUserEmailPer=true;
                      }

                  }
              }


            Map<String,Boolean> map11=new HashMap<>();
            map11.put("currentUserWorkLogPer",currentUserWorkLogPer);
            map11.put("currentUserSchedulePer",currentUserSchedulePer);
            map11.put("currentUserControlCenterPer",currentUserControlCenterPer);
            map11.put("currentUserMyWorkPer",currentUserMyWorkPer);
            map11.put("currentUserEmailPer",currentUserEmailPer);


            json.setObj1(map11);
            json.setObject(portalsUser);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

    @Override
    public ToJson<Portals> selIndexPortals(HttpServletRequest request) {
        ToJson<Portals> json = new ToJson<Portals>();
        try{
            Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionId);
            Users users = usersMapper.getUserId(sessionInfo.getUserId());
            Map<String,Object> map = new HashMap<String,Object>();
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            if(users!=null){
                // 根据权限查询门户信息
                List<String> accessPrivDepts = new ArrayList<>();
                accessPrivDepts.add(users.getDeptId().toString());
                if(!StringUtils.checkNull(users.getDeptIdOther())){
                    accessPrivDepts.addAll(Arrays.asList(users.getDeptIdOther().split(",")));
                }

                List<String> accessPrivPrivs = new ArrayList<>();
                accessPrivPrivs.add(users.getUserPriv().toString());
                if(!StringUtils.checkNull(users.getUserPrivOther())){
                    accessPrivPrivs.addAll(Arrays.asList(users.getUserPrivOther().split(",")));
                }

                map.put("accessPrivDepts", accessPrivDepts);
                map.put("accessPrivPrivs", accessPrivPrivs);
                map.put("accessPrivUser", users.getUserId());
            }
            List<Portals> portals1 = portalsMapper.selPortals(map);


            Iterator<Portals> it = portals1.iterator();
            while (it.hasNext()){
                Portals s = (Portals) it.next();
                if (0==s.getUseFlag()){
                    it.remove();
                }
                if(locale!=null) {
                    if (locale.equals("zh_CN")) {
                        s.setPortalName(s.getPortalName());
                    } else if (locale.equals("en_US")) {
                        s.setPortalName(s.getPortalName1());
                    }
                }else {s.setPortalName(s.getPortalName());}
            }

            // 获取轮播时间
            Portals portals = new Portals();
            List<SysPara> portals_time = sysParaMapper.getTheSysParam("PORTALS_TIME");
            if(portals_time!=null&&portals_time.size()>0){
                SysPara sysPara = portals_time.get(0);
                if(sysPara!=null){
                    portals.setSlideShowTime(sysPara.getParaValue());
                }else{
                    portals.setSlideShowTime("0");
                }
            }

            json.setObject(portals);
            json.setObj(portals1);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }

    @Override
    public ToJson<Portals> updatePersonal(String myTableRight,Integer portalsId) {
        ToJson<Portals> json = new ToJson<Portals>();
        Portals portals = portalsMapper.selectByPrimaryKey(portalsId);
        try{
            if(StringUtils.checkNull(myTableRight)){
                json.setFlag(0);
                json.setMsg("success");
                json.setData(portals.getPortalsManage().split(","));
                return json;
            }else {
                portals.setPortalsManage(myTableRight);
                int num = portalsMapper.updateByPrimaryKey(portals);
                if(num>0){
                    json.setFlag(0);
                    json.setMsg("success");
                }
            }
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err:"+e.getMessage());
        }
        return json;
    }
}
