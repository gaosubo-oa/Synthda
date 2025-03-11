package com.xoa.service.syspara.impl;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.notify.NotifyMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.department.Department;
import com.xoa.model.notify.Notify;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.department.impl.DepartmentServiceImpl;
import com.xoa.service.syspara.SysParaNotifyService;
import com.xoa.service.users.UsersPrivService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.DateFormatUtils;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName :  SysParaNotifyServiceImpl
 * @Description: 公告审批模块接口实现类
 * @author:      刘新婷
 * @date:        2017-11-20
 */
@Service
public class SysParaNotifyServiceImpl implements SysParaNotifyService {
    @Resource
    SysParaMapper sysParaMapper;
    @Resource
    DepartmentMapper departmentMapper;
    @Resource
    UsersMapper usersMapper;
    @Resource
    NotifyMapper notifyMapper;
    @Resource
    UsersService  usersService;
    @Resource
    DepartmentService  departmentService;
    @Resource
    UsersPrivService  usersPrivService;
    @Resource
    SysCodeMapper sysCodeMapper;
    @Resource
    DepartmentServiceImpl departmentServiceImpl;


    /**
     * @Description: 编辑公告通知设置业务实现方法
     * @author:  刘新婷
     * @date:  2017-11-20
     * @param singls
     * @param manager
     * @param edit
     * @param userIds
     * @return
     */
    public ToJson<Object> editNotify(String singls,String manager,String edit,String userIds,String exceptionUserIds){
        ToJson<Object> json =new ToJson<Object>();
        try {
            SysPara sysPara = new SysPara();
            sysPara.setParaName("NOTIFY_AUDITING_SINGLE_NEW");
            sysPara.setParaValue(singls);
            sysParaMapper.updateSysPara(sysPara);
            sysPara.setParaName("NOTIFY_AUDITING_MANAGER");
            sysPara.setParaValue(manager);
            sysParaMapper.updateSysPara(sysPara);
            sysPara.setParaName("NOTIFY_AUDITING_EDIT");
            sysPara.setParaValue(edit);
            sysParaMapper.updateSysPara(sysPara);
            sysPara.setParaName("NOTIFY_AUDITING_ALL");
            sysPara.setParaValue(userIds);
            sysParaMapper.updateSysPara(sysPara);
            sysPara.setParaName("NOTIFY_AUDITING_EXCEPTION");
            sysPara.setParaValue(exceptionUserIds);
            sysParaMapper.updateSysPara(sysPara);

            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @Description: 查询公告通知设置业务实现方法
     * @author:  刘新婷
     * @date:  2017-11-20
     * @return
     */
    public ToJson<Object> selectNotify(){
        ToJson<Object> json =new ToJson<Object>();
        try {
            List<SysCode> codeList = sysCodeMapper.getNotifyType();
            List<SysPara> sysParaList = sysParaMapper.selectNotify();
            List<Object> allList = new LinkedList<>();
            String userIds = null;
            String userIds2 = null;

            String[] ss = {"NOTIFY_AUDITING_EDIT", "NOTIFY_AUDITING_MANAGER", "NOTIFY_AUDITING_SINGLE_NEW", "NOTIFY_AUDITING_ALL", "NOTIFY_AUDITING_EXCEPTION"};
            for (String st : ss){
                for(SysPara sysPara : sysParaList) {
                    Map<String, Object> map = new LinkedHashMap<String, Object>();
                    if (sysPara.getParaName().equals(st)){
                        if(sysPara.getParaName().equals("NOTIFY_AUDITING_EDIT")){
                            map.put("edit",sysPara.getParaValue());
                            allList.add(map);
                        }
                        if(sysPara.getParaName().equals("NOTIFY_AUDITING_MANAGER")){
                            map.put("manager",sysPara.getParaValue());
                            allList.add(map);
                        }
                        if(sysPara.getParaName().equals("NOTIFY_AUDITING_SINGLE_NEW")){
                            String[] singls = sysPara.getParaValue().split(",");
                            Integer[] singlArr = new Integer[singls.length];
                            singlArr[0]=  Integer.valueOf(singls[0].split("-")[1]);
                            for(int i=0;i<codeList.size();i++){
                                Integer res=0;
                                for(String s:singls){
                                    String[] singleArr = s.split("-");
                                    if(codeList.get(i).getCodeNo().equals(singleArr[0])){
                                        res= Integer.valueOf(singleArr[1]);
                                    }
                                }
                                singlArr[i+1]=res;
                            }
                            map.put("singls",singlArr);
                            allList.add(map);
                        }

                        if(sysPara.getParaName().equals("NOTIFY_AUDITING_ALL")){
                            userIds = sysPara.getParaValue();
                        }
                        if(sysPara.getParaName().equals("NOTIFY_AUDITING_EXCEPTION")){
                            userIds2 = sysPara.getParaValue();
                        }
                    }
                }
            }


            if(!StringUtils.checkNull(userIds)){
                String[] uerIdArr = userIds.split(",");
                List<Users> usersList = usersMapper.getUserByUserIds(uerIdArr);
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("bookPriv",usersList);
                allList.add(map);
                /*for(Users user : usersList){
                    Map<String,Object> userMap = new LinkedHashMap<String,Object>();
                    userMap.put("uId",user.getUid());
                    userMap.put("userId",user.getUserId());
                    userMap.put("userName",user.getUserName());
                    userMap.put("deptId",user.getDeptId());
                    allList.add(userMap);
                }*/
            }else {
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("bookPriv",new ArrayList<Users>());
                allList.add(map);
            }
            if(!StringUtils.checkNull(userIds2)){
                String[] uerIdArr = userIds2.split(",");
                List<Users> usersList = usersMapper.getUserByUserIds(uerIdArr);
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("bookPriv2",usersList);
                allList.add(map);
            }else {
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("bookPriv2",new ArrayList<Users>());
                allList.add(map);
            }
            json.setObj(allList);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @Description: 查询本部门主管人员和指定可审批公告人员业务处理方法
     * @author:  刘新婷
     * @date:  2017-11-21
     * @return
     */
    public ToJson<Object> getDeptManagers(HttpServletRequest request){
        ToJson<Object> json =new ToJson<Object>();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            List<Object> deptManagerList = new ArrayList<Object>();

            Department dept = departmentMapper.getFatherDept(user.getDeptId());
            String managerIds = dept.getManager();

            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                //当前用户是本部门主管，获取部门审批人
                if(!StringUtils.checkNull(managerIds) && Arrays.asList(managerIds.split(",")).contains(user.getUserId())){
                    managerIds = dept.getDeptApprover();
                }
            }

            String[] managerIdArr = managerIds.split(",");

            if(StringUtils.checkNull(managerIds)){
                managerIdArr=null;
            } else {
                List<Users> usersList = usersMapper.getUsersByUserIds(managerIdArr);
                if (!CollectionUtils.isEmpty(usersList)) {
                    for (int i = 0; i < usersList.size(); i++) {
                        managerIdArr[i] = String.valueOf(usersList.get(i).getUid());
                    }
                }
            }

            String autidingUserIds = sysParaMapper.getAutidingUsers();
            String[] autidingUserIdArr = autidingUserIds.split(",");
            if(StringUtils.checkNull(autidingUserIds)){
                autidingUserIdArr=null;
            } else {
                //获取当前用户所在的分支机构
                Department department = departmentServiceImpl.queryDeptParent(user.getDeptId());
                if (department != null) {
                    //是分支机构用户，则需要过滤审批人
                    List<Department> resultList = new ArrayList<>();
                    resultList.add(department);
                    //获取全部下级部门
                    departmentServiceImpl.getAllChDept(department, resultList, department.getIsSubOrg());

                    String[] deptIds = resultList.stream().map(Department::getDeptId).distinct().map(String::valueOf).collect(Collectors.joining(",")).split(",");
                    if (autidingUserIdArr.length > 0 && deptIds.length > 0) {
                        //过滤审批人
                        List<Users> usersList = usersMapper.getAuditingUsers(autidingUserIdArr, deptIds);
                        autidingUserIdArr = usersList.stream().map(Users::getUserId).collect(Collectors.joining(",")).split(",");
                    }
                }
            }

            //判断是否根据当前登陆人所在部门查询
            String deptId = request.getParameter("deptId");
            List<Users> usersList;
            if (StringUtils.checkNull(deptId)){
                 usersList = usersMapper.getUserByUids(managerIdArr,autidingUserIdArr);
            }else{
                 usersList = usersMapper.getUserByUidsDeptId(managerIdArr,autidingUserIdArr,String.valueOf(user.getDeptId()));
            }


            for(Users users : usersList){
                Map<String,Object> userMap = new LinkedHashMap<String,Object>();
                userMap.put("uid",users.getUid());
                userMap.put("userName",users.getUserName());
                userMap.put("userId",users.getUserId());
                userMap.put("deptId",users.getDeptId());
                deptManagerList.add(userMap);
            }
            json.setObj(deptManagerList);
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @Description: 根据公告类型查询已审批公告业务处理实现方法
     * @author:  刘新婷
     * @date:  2017-11-21
     * @param typeId
     * @param start
     * @param size
     * @return
     */
    public static String notifyDatetime = "1970-01-01 08:00:00";
   @Override
    public ToJson<Notify> getApprovedNotifyList(String typeId,Integer start,Integer size,Integer page,Integer pageSize,Boolean useFlag,HttpServletRequest request){
        ToJson<Notify> json =new ToJson<Notify>();
       Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
       Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        try{
            Map<String,Object> maps=new HashMap<String,Object> ();
            PageParams pageParams = new PageParams();
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            maps.put("page", pageParams);
            maps.put("typeId", typeId);
            maps.put("start", start);
            maps.put("size", size);
            maps.put("auditer",sessionInfo.getUserId());
            List<Notify> notifyList = notifyMapper.selectApprovedNotifyByTypeId(maps);
            SysPara sysPara = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            for(Notify notify:notifyList){
                if ("1".equals(sysPara.getParaValue())) {
                    if (notify.getContentSecrecy() != null) {
                        SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", notify.getContentSecrecy());
                        if (sysCode != null) {
                            notify.setContentSecrecy("【"+sysCode.getCodeName()+"】");
                        }else {
                            notify.setContentSecrecy("");
                        }
                    }else {
                        notify.setContentSecrecy("");
                    }
                }else {
                    notify.setContentSecrecy("");
                }
                    //有效时间的开始时间
                Integer beginDate = notify.getBeginDate();
                Date date =new Date();
                String strDate1 = DateFormatUtils.formatDate(date);
                //当前时间
                Integer nowDate = DateFormatUtils.getNowDateTime(strDate1);
                    if(nowDate-beginDate<0){
                        notify.setPublish("4");
                    }
                //把生效中到期的改为失效
                Integer endTime = notify.getEndDate();
                if(endTime!=null&&endTime!=0){
                    //结束时间
                    Date date1 =new Date();
                    String strDate2 = DateFormatUtils.formatDate(date1);
                    //当前时间
                    Integer nowDate2 = DateFormatUtils.getNowDateTime(strDate2);
                    if(endTime-nowDate2<0){
                        notify.setPublish("5");
                    }
                }

                if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                        notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                    } else {
                        notify.setBegin("");
                    }
                } else {
                    notify.setBegin("");
                }
                if (notify.getEndDate() != null && !"".equals(notify.getEndDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                        notify.setEnd(DateFormat.getStrDateTime(notify.getEndDate()));
                    } else {
                        notify.setEnd("");
                    }
                } else {
                    notify.setEnd("");
                }

                String usename=usersMapper.getUsernameByUserId(notify.getFromId());
                notify.setName(usename);
                if(notify.getTypeId()!=null&&!notify.getTypeId().equals("")){
                    String  name11=sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                    if(StringUtils.checkNull(name11)){
                        notify.setTypeName("");
                    }else{
                        notify.setTypeName(name11);
                    }

                }else{
                    notify.setTypeName("");
                }
                StringBuffer s=new StringBuffer();
                StringBuffer s1=new StringBuffer();
                StringBuffer s2=new StringBuffer();


                String depId = notify.getToId();

                if(!StringUtils.checkNull(depId)){

                    String  depName= departmentService.getDeptNameByDeptId(depId,",");
                    if(!"ALL_DEPT".trim().equals(notify.getToId())){
                        notify.setDeprange(depName+",");
                    }else{
                        notify.setDeprange(depName);
                    }


                }

                String userId = notify.getUserId();
                if(!StringUtils.checkNull(userId)){
                    String  userName= usersService.getUserNameById(userId);
                    notify.setUserrange(userName+",");
                }

                String roleId = notify.getPrivId();
                if(!StringUtils.checkNull(roleId)){
                    String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
                    notify.setRolerange(roleName+",");
                }

            }
           // List<Object> list = new ArrayList<Object>();
         //   list.add(notifyList);
            json.setObj(notifyList);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @Description: 根据公告类型查询已审批公告业务处理实现方法
     * @author:  刘新婷
     * @date:  2017-11-21
     * @param typeId
     * @param start
     * @param size
     * @return
     */
    @Override
    public ToJson<Notify> getPendingNotifyList(String typeId,Integer start,Integer size,Integer page,Integer pageSize,Boolean useFlag,HttpServletRequest request){
        ToJson<Notify> json =new ToJson<Notify>();
        try{
            Map<String,Object> maps=new HashMap<String,Object> ();
            PageParams pageParams = new PageParams();
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            Users sessionInfo = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            pageParams.setUseFlag(useFlag);
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            maps.put("page", pageParams);
            maps.put("typeId", typeId);
            maps.put("start", start);
            maps.put("size", size);
            maps.put("auditer",sessionInfo.getUserId());
            List<Object> list = new ArrayList<Object>();
            SysPara sysPara = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            List<Notify> notifyList = notifyMapper.selectPendingNotifyByTypeId(maps);
            for(Notify notify:notifyList){
                if ("1".equals(sysPara.getParaValue())) {
                    if (notify.getContentSecrecy() != null) {
                        SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", notify.getContentSecrecy());
                        if (sysCode != null) {
                            notify.setContentSecrecy("【" + sysCode.getCodeName() + "】");
                        }else {
                            notify.setContentSecrecy("");
                        }
                    } else {
                        notify.setContentSecrecy("");
                    }
                }else {
                    notify.setContentSecrecy("");
                }
                if (notify.getBeginDate() != null && !"".equals(notify.getBeginDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getBeginDate()))) {
                        notify.setBegin(DateFormat.getStrDateTime(notify.getBeginDate()));
                    } else {
                        notify.setBegin("");
                    }
                } else {
                    notify.setBegin("");
                }
                if (notify.getEndDate() != null && !"".equals(notify.getEndDate())) {
                    if (!notifyDatetime.equals(DateFormat.getStrTime(notify.getEndDate()))) {
                        notify.setEnd(DateFormat.getStrDateTime(notify.getEndDate()));
                    } else {
                        notify.setEnd("");
                    }
                } else {
                    notify.setEnd("");
                }
                String usename=usersMapper.getUsernameByUserId(notify.getFromId());
                notify.setName(usename);
                //查询发布类型
                if(notify.getTypeId()!=null&&!notify.getTypeId().equals("")){
                    String  name11=sysCodeMapper.getNotifyNameByNo(notify.getTypeId());
                    if(StringUtils.checkNull(name11)){
                        notify.setTypeName("");
                    }else{
                        notify.setTypeName(name11);
                    }

                }else{
                    notify.setTypeName("");
                }
                StringBuffer s=new StringBuffer();
                StringBuffer s1=new StringBuffer();
                StringBuffer s2=new StringBuffer();


                //按部门查询返回的范围
                String depId = notify.getToId();
                if(!StringUtils.checkNull(depId) && !"".equals(depId)){

                    String  depName= departmentService.getDeptNameByDeptId(depId,",");
                    if(!"ALL_DEPT".trim().equals(notify.getToId())){
                        notify.setDeprange(depName+",");
                    }else{
                        notify.setDeprange(depName);
                    }


                }

                //按人员查询返回范围
                String userId = notify.getUserId();
                if(!StringUtils.checkNull(userId) && !"".equals(userId)){
                    String  userName= usersService.getUserNameById(userId);
                    notify.setUserrange(userName+",");
                }

                //按角色查询返回范围
                String roleId = notify.getPrivId();
                if(!StringUtils.checkNull(roleId) && !"".equals(roleId)){
                    String  roleName= usersPrivService.getPrivNameByPrivId(roleId,",");
                    notify.setRolerange(roleName+",");
                }

            }
            String isEdit = sysParaMapper.getEditFlag();
            Map<String,Object> map = new LinkedHashMap<String,Object>();
             map.put("isEdit",isEdit);
             list.add(map);
             list.add(notifyList);
             json.setObj(notifyList);
            json.setTotleNum(pageParams.getTotal());
             json.setFlag(0);
            json.setMsg("ok");
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }

    /**
     * @Description: 获取公告类型业务处理实现
     * @author:  刘新婷
     * @date:  2017-11-24
     * @return
     */
    @Override
    public ToJson<Object> getNotifyTypeList(HttpServletRequest request){
        ToJson<Object> json =new ToJson<Object>();
        try{
            Object locale = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            String userId = SessionUtils.getSessionInfo(request.getSession(), "userId", String.class,redisSessionCookie);
            //TYPE-0,01-0,02-1,03-1,04-0,05-0,
            SysPara exceptionUserIds = sysParaMapper.querySysPara("NOTIFY_AUDITING_EXCEPTION");
            String paraValue = "";
            if(exceptionUserIds!=null&&!StringUtils.checkNull(exceptionUserIds.getParaValue())){
                paraValue = exceptionUserIds.getParaValue();
            }
            List<SysCode> codeList = sysCodeMapper.getNotifyType();
            String[] singleNewsArr = sysParaMapper.selectNotifySingleNew().split(",");
            List<Object> allCodeList = new ArrayList<Object>();
            Map<String,Object> AllTypeMap = new LinkedHashMap<String,Object>();
            String isEdit="0";
            String AllType = "0";
            for(SysCode code : codeList){
                Map<String,Object> map = new LinkedHashMap<String,Object>();
                for(int i = 0; i < singleNewsArr.length; i++){
                    String[] singleArr = singleNewsArr[i].split("-");
                    if("TYPE".equals(singleArr[0])){
                        AllTypeMap.put("AllType","AllType");
                        AllTypeMap.put("isEdit",singleArr[1]);
                        if(!StringUtils.checkNull(paraValue)){
                            if (paraValue.indexOf(","+userId+",")>0||userId.equals(paraValue.substring(0, paraValue.indexOf(',')))) {
                                AllTypeMap.put("isEdit",0);
                            }
                        }
                    }
                    if(code.getCodeNo().equals(singleArr[0])){
                        map.put("codeId",code.getCodeId());
                        map.put("codeNo",code.getCodeNo());
                        if (locale.equals("zh_CN")) {
                            map.put("codeName",code.getCodeName());
                        } else if (locale.equals("en_US")) {
                            map.put("codeName",code.getCodeName1());
                        } else if (locale.equals("zh_TW")) {
                            map.put("codeName",code.getCodeName2());
                        }
                        map.put("isEdit",singleArr[1]);
                        if(!StringUtils.checkNull(paraValue)){
                            if (paraValue.indexOf(","+userId+",")>0||userId.equals(paraValue.substring(0, paraValue.indexOf(',')))) {
                                map.put("isEdit",0);
                            }
                        }
                        allCodeList.add(map);
                    }
                    else{
                        isEdit="1";
                    }
                }
            }


            json.setObj(allCodeList);
            json.setObject(AllTypeMap);
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
    public ToJson<Object> getNotifyCode( HttpServletRequest request) {
        ToJson<Object> json =new ToJson<Object>();
        try{
            List<SysCode> codeList = sysCodeMapper.getNotifyType();
            List<Object> allCodeList = new ArrayList<Object>();
            String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
            Map<String,Object> AllTypeMap = new LinkedHashMap<String,Object>();
            String isEdit="0";
            StringBuffer sb =new StringBuffer("TYPE-0,");
            for (SysCode code : codeList) {
                sb.append(code.getCodeNo() + "-" + 0);
                sb.append(",");
                Map<String, Object> map = new LinkedHashMap<String, Object>();
                map.put("codeId", code.getCodeId());
                map.put("codeNo", code.getCodeNo());
                if (locale.equals("zh_CN")) {
                    map.put("codeName", code.getCodeName());
                } else if (locale.equals("en_US")) {
                    map.put("codeName", code.getCodeName1());
                } else if (locale.equals("zh_TW")) {
                    map.put("codeName", code.getCodeName2());
                }
                map.put("isEdit", 0);
                allCodeList.add(map);
            }
            AllTypeMap.put("AllType","AllType");
            AllTypeMap.put("isEdit",isEdit);
            json.setObj(allCodeList);
            json.setObject(AllTypeMap);
            json.setFlag(0);
            json.setMsg(sb.toString());
        } catch (Exception e) {
            json.setFlag(1);
            json.setMsg("err");
            e.printStackTrace();
        }
        return json;
    }
}