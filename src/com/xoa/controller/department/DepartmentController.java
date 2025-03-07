package com.xoa.controller.department;

import com.alibaba.fastjson.JSONObject;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.unitmanagement.UnitManageMapper;
import com.xoa.dao.users.UserDeptOrderMapper;
import com.xoa.dao.users.UserPrivTypeMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.department.DepartmentVO;
import com.xoa.model.securityApproval.SecurityApprovalWithBLOBs;
import com.xoa.model.unitmanagement.UnitManage;
import com.xoa.model.users.*;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.modulePriv.ModulePrivService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.securityApproval.SecurityLogService;
import com.xoa.service.sys.impl.SystemInfoServiceImpl;
import com.xoa.service.users.UsersService;
import com.xoa.util.*;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import com.xoa.util.dataSource.ContextHolder;
import com.xoa.util.ipUtil.IpAddr;
import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.InetAddress;
import java.util.*;
import java.util.stream.Collectors;


/**
 * 创建作者:   张龙飞
 * 创建日期:   2017年4月19日 上午9:21:53
 * 类介绍  :    部门控制器
 * 构造参数:    无
 */
@Controller
@RequestMapping("/department")
@SuppressWarnings("all")
public class DepartmentController {

    @Resource
    private DepartmentService departmentService;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private SyslogMapper syslogMapper;
    @Resource
    private UsersService usersService;

    @Resource
    private UnitManageMapper unitManageMapper;

    @Resource
    UserDeptOrderMapper userDeptOrderMapper;

    @Resource
    UsersMapper usersMapper;

    @Resource
    DepartmentMapper departmentMapper;

    @Resource
    private UserPrivTypeMapper userPrivTypeMapper;

    @Resource
    private ModulePrivService modulePrivService;

    @Resource
    private SecurityApprovalService securityApprovalService;

    @Resource
    private SecurityLogService securityLogService;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @RequestMapping("/xiufu")
    public String xiufu() {
        return "app/department/xiufu";
    }

    @RequestMapping("/deptQuery")
    public String deptQuery() {
        return "app/department/deptQuery";
    }

    @RequestMapping("/deptListShow")
    public String deptListShow() {
        return "app/department/deptListShow";
    }

    @RequestMapping("/newDeptManagement")
    public String companyInfo(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        return "app/sys/new_deptManagement";
    }

    @RequestMapping("/batchSetDept")
    public String batchSetDept() {
        return "app/department/batchSetDept";
    }
    @RequestMapping("/AuxiliaryDepartment")
    public String AuxiliaryDepartment() {
        return "app/department/AuxiliaryDepartment";
    }
    @RequestMapping("/upDeptRank")
    public String upDeptRank() {
        return "app/department/upDeptRank";
    }

    @RequestMapping("/exportOrImport")
    public String toExportOrImport(){
        return "app/department/exportOrImport";
    }

    //闵行用到的学校管理
    @RequestMapping("/schoolManagement")
    public String schoolManagement(HttpServletRequest request) {
        return "app/sys/schoolManagement";
    }
    @RequestMapping("/schoolDeptManagement")
    public String schoolDeptManagement(HttpServletRequest request) {
        return "app/sys/school_deptManagement";
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:20:25
     * 方法介绍:   添加部门
     * 参数说明:   @param department  部门信息
     * 参数说明:   @return
     *
     * @return ToJson<Department> 返回部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/addDept", method = RequestMethod.POST)
    public ToJson<Department> addDept(Department department, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(users.getUserId() + "");
        sysLog.setType(3);
        sysLog.setTypeName("添加部门");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = request.getParameter("userAgent");
        if ("iOS".equals(userAgent)) {
            //添加客户端类型
            sysLog.setClientType(3);
            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("android".equals(userAgent)) {
            sysLog.setClientType(4);
            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("pc".equals(userAgent)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            String clientVersion = request.getParameter("clientVersion");
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }
        try {
            if (!departmentService.checkDep(department,0)){
                json.setMsg(Constant.depExesit);
                json.setFlag(1);
                return json;
            }
            Department departParent = null;
            if (department.getDeptParent()!=0){
                 departParent = departmentService.getDeptById(department.getDeptParent());
                department.setDeptNo(departParent.getDeptNo()+department.getDeptNo());
            }else {
                List<Department> listByNo = departmentService.getDepByNo(department.getDeptNo());
                if (listByNo.size()>0){
                    json.setMsg(Constant.depExesit);
                    json.setFlag(1);
                    return json;
                }
                department.setDeptNo(department.getDeptNo());
            }
            boolean bol = false;
            //开启了三员管理，新增部门时不允许填写部门的负责人（部门主管）和部门审核人，需要三员中的系统安全保密员进行审批
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                department.setManager(null);
                department.setDeptApprover(null);
            }

            departmentService.insertDept(department);
            Department dep = departmentService.getDeptById(department.getDeptId());
            sysLog.setRemark(dep.getDeptName()+",DEPT_ID="+department.getDeptId()+",DEPT_PARENT="+dep.getDeptParent());
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())){
                //查询保密员
                Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                //创建一条审批数据
                securityApprovalService.insertSelective("department", department.getDeptId(), users.getUserId(), "", "0", "", null,null,sysSecurityUser.getUserId());
            }

            try{
                String deptGuid = request.getParameter("deptGuid");
                String deptDn = request.getParameter("deptDn");
            }catch (Exception e){
                e.printStackTrace();
            }

            json.setObject(department);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg("err");
            json.setFlag(1);
            e.printStackTrace();
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:20:42
     * 方法介绍:   删除部门
     * 参数说明:   @param department 部门信息
     * 参数说明:   @return
     *
     * @return ToJson<Department> 返回显示信息
     */
    @Transactional
    @ResponseBody
    @RequestMapping(value = "/deletedept", method = RequestMethod.GET)
    public ToJson<Department> deletedept(Department department, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(users.getUserId() + "");
        sysLog.setType(5);
        sysLog.setTypeName("删除部门");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = request.getParameter("userAgent");
        if ("iOS".equals(userAgent)) {
            //添加客户端类型
            sysLog.setClientType(3);
            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("android".equals(userAgent)) {
            sysLog.setClientType(4);
            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("pc".equals(userAgent)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            String clientVersion = request.getParameter("clientVersion");
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }
        try {

            //查询是否开启三员管理，开启后只有保密员可以删除部门
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
                //判断是否是保密员
                Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                if(!sysSecurityUser.getUserId().equals(users.getUserId())){
                    json.setMsg("无权限删除部门");
                    json.setFlag(1);
                    return json;
                }
            }

            Department dep = departmentService.getDeptById(department.getDeptId());
            StringBuffer depName = new StringBuffer();
            StringBuffer depId = new StringBuffer();
            StringBuffer depPer = new StringBuffer();
            depName.append(dep.getDeptName());
            depId.append(dep.getDeptId());
            depPer.append(dep.getDeptParent());
            List<Department> list = departmentService.getChDeptByNo(dep.getDeptNo());
            Users admin = usersService.findUserByName("admin", request);
            for (Department d : list) {
                List<Users> l = usersService.getUsersByDeptId(d.getDeptId());
                if (l.size() > 0) {
                    json.setFlag(1);
                    json.setMsg(Constant.deleteMessage);
                    return json;
                }
                for (Users u : l){
                    if (u.getUserId().equals(admin.getUserId())){
                        json.setFlag(1);
                        json.setMsg(Constant.deleteMessage);
                        return json;
                    }
                }
            }
            boolean bol = false;
            for (Department d : list) {

                departmentService.deleteDept(d.getDeptId());
            }
            sysLog.setRemark(depName.toString()+",DEPT_ID="+depId.toString()+",DEPT_PARENT="+depPer.toString());
            //记录删除原因和线下审批单的附件
            if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
                String attachmentId = request.getParameter("attachmentId");
                String attachmentName = request.getParameter("attachmentName");
                String operationReason = request.getParameter("operationReason");
                sysLog.setRemark(depName.toString()+",DEPT_ID="+depId.toString()+",DEPT_PARENT="+depPer.toString() +
                        "，删除原因：" + operationReason + "，附件ID：" + attachmentId + "，附件名称：" + attachmentName);
            }
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            json.setFlag(0);
            json.setMsg("true");
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            json.setFlag(1);
            json.setMsg("false");
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月19日 下午3:20:56
     * 方法介绍:   根据部门id获取部门
     * 参数说明:   @param deptid  部门id名称
     * 参数说明:   @return
     *
     * @return String 返回单个部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/getDeptById", method = RequestMethod.GET)
    public ToJson<Department> getDeptByid(int deptId, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);

        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            Department department = departmentService.getDeptById(deptId);

            if(!StringUtils.checkNull(department.getManager())){
                String managerName=usersService.getUserNameById(department.getManager());
                if(!StringUtils.checkNull(managerName)){
                    department.setManagerStr(managerName);
                }
            }
            if(!StringUtils.checkNull(department.getAssistantId())){
                String assistantStr=usersService.getUserNameById(department.getAssistantId());
                if(!StringUtils.checkNull(assistantStr)){
                    department.setAssistantStr(assistantStr);
                }
            }
            if(!StringUtils.checkNull(department.getLeader1())){
                String leader1Name=usersService.getUserNameById(department.getLeader1());
                if(!StringUtils.checkNull(leader1Name)){
                    department.setLeader1Name(leader1Name);
                }
            }
            if(!StringUtils.checkNull(department.getLeader2())){
                String leader2Name=usersService.getUserNameById(department.getLeader2());
                if(!StringUtils.checkNull(leader2Name)){
                    department.setLeader2Name(leader2Name);
                }
            }

            if(!StringUtils.checkNull(department.getDeptApprover())){
                String deptApproverName = usersService.getUserNameById(department.getDeptApprover());
                if(!StringUtils.checkNull(deptApproverName)){
                    department.setDeptApproverName(deptApproverName);
                }
            }

            if(!StringUtils.checkNull(department.getPrivTypes())){
                String[] privTypeIds = department.getPrivTypes().split(",");

                if(privTypeIds.length > 0) {
                    List<Integer> result = Arrays.asList(privTypeIds).stream().map(id -> Integer.parseInt(id.trim())).collect(Collectors.toList());
                    UserPrivTypeExample example = new UserPrivTypeExample();
                    UserPrivTypeExample.Criteria criteria = example.createCriteria();
                    criteria.andPrivTypeIdIn(result);
                    List<UserPrivType> userPrivTypes = userPrivTypeMapper.selectByExample(example);
                    department.setPrivTypeNames(userPrivTypes.stream().map(UserPrivType::getPrivTypeName).collect(Collectors.joining(",")));
                }
            }

            String assistantId = department.getAssistantId();
            // 用字符链接id和名称
            department.setAssistantId(usersService.getUserNameById(assistantId) + "&" + assistantId);
            String manager = department.getManager();
            department.setManager(usersService.getUserNameById(manager) + "&" + manager);
            String leader1 = department.getLeader1();
            department.setLeader1(usersService.getUserNameById(leader1) + "&" + leader1);
            String leader2 = department.getLeader2();
            department.setLeader2(usersService.getUserNameById(leader2) + "&" + leader2);
            if(!StringUtils.checkNull(department.getClassifyOrgAdmin())){
                //传值是id传，所以需要分割一下逗号
                String[] temp = department.getClassifyOrgAdmin().split(",");
                StringBuffer userIds = new StringBuffer();
                StringBuffer userNames = new StringBuffer();
                for (int i = 0; i < temp.length; i++) {
                    if (!StringUtils.checkNull(temp[i])) {
                        Users users1 = usersMapper.findUserByuid(Integer.parseInt(temp[i]));
                        if (users1 != null) {
                            userIds.append(users1.getUserId()).append(",");
                            userNames.append(users1.getUserName()).append(",");
                        }
                    }
                }
                department.setClassifyOrgAdminUserId(userIds.toString());
                department.setClassifyOrgAdminName(userNames.toString());
            }
            if(department.getDeptParentName().equals("离职")){
                department.setDeptParentName("");
            }

            json.setObject(department);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
           // System.out.println(e);
        }
        return json;
    }

    /**
     * 闵行学校管理用到的部门查询接口  根据部门id获取部门
     * @param deptId
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getschoolDeptById", method = RequestMethod.GET)
    public ToJson<Department> getschoolDeptById(int deptId, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            if (deptId==-1){
                //获取当前登录人
                Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
                deptId=users.getDeptId();
            }
            Map<String, Object> department = departmentService.getDeptMapById(deptId);

            if(!StringUtils.checkNull((String) department.get("MANAGER"))){
                String managerName=usersService.getUserNameById((String) department.get("MANAGER"));
                if(!StringUtils.checkNull(managerName)){
                    department.put("managerName",managerName);
                }
            }
            if(!StringUtils.checkNull((String) department.get("ASSISTANT_ID"))){
                String assistantStr=usersService.getUserNameById((String) department.get("ASSISTANT_ID"));
                if(!StringUtils.checkNull(assistantStr)){
                    department.put("assistantStr",assistantStr);
                }
            }
            if(!StringUtils.checkNull((String) department.get("LEADER1"))){
                String leader1Name=usersService.getUserNameById((String) department.get("LEADER1"));
                if(!StringUtils.checkNull(leader1Name)){
                    department.put("leader1Name",leader1Name);
                }
            }
            if(!StringUtils.checkNull((String) department.get("LEADER2"))){
                String leader2Name=usersService.getUserNameById((String) department.get("LEADER2"));
                if(!StringUtils.checkNull(leader2Name)){
                    department.put("leader2Name",leader2Name);
                }
            }

            String assistantId = (String) department.get("ASSISTANT_ID");
            // 用字符链接id和名称
            department.put("ASSISTANT_ID",usersService.getUserNameById(assistantId) + "&" + assistantId);
            String manager = (String) department.get("MANAGER");
            department.put("MANAGER",usersService.getUserNameById(manager) + "&" + manager);
            String leader1 = (String) department.get("LEADER1");
            department.put("LEADER1",usersService.getUserNameById(leader1) + "&" + leader1);
            String leader2 = (String) department.get("LEADER2");
            department.put("LEADER2",usersService.getUserNameById(leader2) + "&" + leader2);
            /*if(!StringUtils.checkNull(department.getClassifyOrgAdmin())){
                //传值是id传，所以需要分割一下逗号
                String[] temp = department.getClassifyOrgAdmin().split(",");
                for (int i = 0; i < temp.length; i++) {
                    if (!StringUtils.checkNull(temp[i])) {
                        String orgAminName = usersService.findUsersByuid(temp[i]);
                        if (!StringUtils.checkNull(orgAminName)) {
                            department.setClassifyOrgAdminName(orgAminName);
                        }
                    }
                }
            }
            if(department.getDeptParentName().equals("离职")){
                department.setDeptParentName("");
            }*/
            json.setObject(department);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:21:17
     * 方法介绍:   获取所有部门信息
     * 参数说明:   @return
     *
     * @return String  返回所有部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/getAlldept", produces = {"application/json;charset=UTF-8"})
    public ToJson getAlldept(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson json = new ToJson(1, null);
        try {
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            List<Department> list = departmentService.getDepartmentByClassifyOrg(users,true,true);

            //取指定条数部门数据
            String pageSize = request.getParameter("pageSize");
            if(!StringUtils.checkNull(pageSize)){
                Integer dataSize = Integer.valueOf(pageSize);
                if(list.size() > dataSize){
                    list = list.subList(0,dataSize);
                }
            }

            //只返回必要属性
            String resultFlag = request.getParameter("resultFlag");
            if(!StringUtils.checkNull(resultFlag)) {
                List<DepartmentVO> dataList = new ArrayList<>();
                for (Department t : list) {
                    DepartmentVO departmentVO = new DepartmentVO();
                    departmentVO.setDeptId(t.getDeptId());
                    departmentVO.setDeptNo(t.getDeptNo());
                    departmentVO.setDeptName(t.getDeptName());
                    departmentVO.setDeptParent(t.getDeptParent());
                    departmentVO.setIsOrg(t.getIsOrg());
                    departmentVO.setLeaf(t.getIsLeaf());
                    departmentVO.setDeptDisplay(t.getDeptDisplay());
                    departmentVO.setIsHaveCh("0");
                    dataList.add(departmentVO);
                }
                json.setObj(dataList);
            }else {
                String managers = list.stream().map(Department::getManager).filter(m -> !StringUtils.checkNull(m)).collect(Collectors.joining(","));
                if (!StringUtils.checkNull(managers)) {
                    List<Users> usersByUserIds = usersMapper.getUsersByUserIds(managers.split(","));
                    Map<String, String> userIdMap = new HashMap<>();
                    for (Users usersByUserId : usersByUserIds) {
                        userIdMap.put(usersByUserId.getUserId(), usersByUserId.getUserName());
                    }

                    for (Department department : list) {
                        if (department.getManager() != null) {
                            StringBuffer manageStr = new StringBuffer();
                            String[] getManagerStr = department.getManager().split(",");
                            for (String s : getManagerStr) {
                                String managerName = userIdMap.get(s);
                                if (managerName != null) {
                                    manageStr.append(managerName + ",");
                                }
                            }
                            department.setManagerStr(manageStr.toString());
                        }
                    }
                }
                json.setObj(list);
            }
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
            e.printStackTrace();
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:21:32
     * 方法介绍:   修改部门信息
     * 参数说明:   @param department  部门信息
     * 参数说明:   @return
     *
     * @return ToJson<Department>   返回显示信息
     */
    @ResponseBody
    @RequestMapping(value = "/editDept", method = RequestMethod.POST)
    public ToJson<Department> editDept(Department department, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        if(!Objects.isNull(department.getDeptParent()) && department.getDeptParent() == department.getDeptId()){
            json.setFlag(1);
            json.setMsg("上级部门不能为当前部门");
            return json;
        }
        Department department1 = departmentService.getDeptById(department.getDeptId());
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(users.getUserId() + "");
        sysLog.setType(4);
        sysLog.setTypeName("编辑部门");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = request.getParameter("userAgent");
        if ("iOS".equals(userAgent)) {
            //添加客户端类型
            sysLog.setClientType(3);
            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("android".equals(userAgent)) {
            sysLog.setClientType(4);
            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("pc".equals(userAgent)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            String clientVersion = request.getParameter("clientVersion");
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }
        try {
            //将部门置为失效部门时需要判断部门下是否存在用户，存在用户不能置为失效部门
            if(department.getDeptDisplay() !=null && department.getDeptDisplay() == 0){
                List<Department> list = departmentService.getChDeptByNo(department1.getDeptNo());
                for (Department d : list) {
                    List<Users> l = usersService.getUsersByDeptId(d.getDeptId());
                    if (l.size() > 0) {
                        json.setFlag(1);
                        json.setMsg("该部门下有人员，请处理后置为失效部门");
                        return json;
                    }
                }
            }

            if (!departmentService.checkDep(department,1)){
                json.setMsg(Constant.depExesit);
                json.setFlag(1);
                return json;
            }
            boolean bol = false;

            //检查部门的负责人（部门主管）和部门审核人是否被修改
            if(!(department1.getManager() + "").equals(department.getManager() + "") || !(department1.getDeptApprover() + "").equals(department.getDeptApprover() + "")){
                //查询是否开启三员管理
                SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
                if(!Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
                    String manager = StringUtils.checkNull(department.getManager()) ? department1.getManager() : department.getManager();
                    String deptApprover = StringUtils.checkNull(department.getDeptApprover()) ? department1.getDeptApprover() : department.getDeptApprover();
                    if(!StringUtils.checkNull(manager) && !StringUtils.checkNull(deptApprover)){
                        //判断部门主管和部门审核人不能是同一个人，部门负责人和部门审核人只可以单选，不可以选多个人，部门审批人的密级不能低于部门负责人密级
                        String[] managerArr = manager.split(",");
                        String[] deptApproverArr = deptApprover.split(",");
                        if(managerArr.length > 1 || deptApproverArr.length > 1){
                            json.setFlag(1);
                            json.setMsg("部门负责人和部门审核人不能设置多个人");
                            return json;
                        }

                        if(managerArr[0].trim().equals(deptApproverArr[0].trim())){
                            json.setFlag(1);
                            json.setMsg("部门负责人和部门审核人不能相同");
                            return json;
                        }

                        List<SysCode> childCode = sysCodeMapper.getChildCode("USER_SECRECY");
                        Map<String, String> secrecyMap = childCode.stream().collect(Collectors.toMap(SysCode::getCodeNo, SysCode::getCodeOrder));
                        if(Integer.valueOf(secrecyMap.get(usersMapper.seleById(deptApproverArr[0]).getUserSecrecy())) < Integer.valueOf(secrecyMap.get(usersMapper.seleById(managerArr[0]).getUserSecrecy()))){
                            json.setFlag(1);
                            json.setMsg("部门审批人的密级不能低于部门负责人密级");
                            return json;
                        }
                    }

                    //查询修改的用户是否存在保密员未审批的变更
                    List<SecurityApprovalWithBLOBs> securityApprovalWithBLOBs = securityApprovalService.queryNotApprove("0","department",department.getDeptId().toString());
                    if(securityApprovalWithBLOBs.size() > 0){
                        json.setFlag(1);
                        json.setMsg("部门存在未审批的变更，审批后可修改");
                        return json;
                    }

                    JSONObject jsonObject = new JSONObject();
                    if(!(department1.getManager() + "").equals(department.getManager() + "")) {
                        jsonObject.put("manager", department.getManager());
                    }
                    if(!(department1.getDeptApprover() + "").equals(department.getDeptApprover() + "")) {
                        jsonObject.put("deptApprover", department.getDeptApprover());
                    }
                    //查询保密员
                    Users sysSecurityUser = securityApprovalService.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
                    //创建一条审批数据
                    String attachmentId = request.getParameter("attachmentId");
                    String attachmentName = request.getParameter("attachmentName");
                    String operationReason = request.getParameter("operationReason");
                    securityApprovalService.insertSelective("department", department1.getDeptId(), users.getUserId(), jsonObject.toJSONString(), "1", operationReason, attachmentId, attachmentName, sysSecurityUser.getUserId());
                    //待审批的信息，审批过后更新，此时还使用原来的值不更新
                    department.setManager(department1.getManager());
                    department.setDeptApprover(department1.getDeptApprover());
                }
            }

            departmentService.editDept(department);
            sysLog.setRemark(department1.getDeptName()+",DEPT_ID="+department1.getDeptId()+",DEPT_PARENT="+department1.getDeptParent());
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);

            try{
                String deptGuid = request.getParameter("deptGuid");
                String deptDn = request.getParameter("deptDn");
            }catch (Exception e){
                e.printStackTrace();
            }
            json.setObject(department);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 闵行的编辑学校管理
     * @param department
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/editschoolDept", method = RequestMethod.POST)
    public ToJson<Department> editschoolDept(String jsonStr, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        Map map=new HashedMap();
        Map<String,Object> maps =json!=null ? (Map) com.alibaba.fastjson.JSON.parse(jsonStr) : new HashMap();
        if ((!StringUtils.checkNull((String) maps.get("DEPT_ID")) && (maps.get("DEPT_ID").toString().equals("-1")))){
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            maps.put("DEPT_ID",users.getDeptId().toString());
        }

        for (Map.Entry<String,Object> map1:maps.entrySet()) {
            if (!StringUtils.checkNull(map1.getValue().toString())){
                map.put(map1.getKey(),map1.getValue());
            }
        }

        Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        Map<String,Object> department1 = departmentService.getDeptMapById(Integer.parseInt((String)maps.get("DEPT_ID")));
        //加入操作日志处理
        Syslog sysLog = new Syslog();
        sysLog.setUserId(users.getUserId() + "");
        sysLog.setType(4);
        sysLog.setTypeName("编辑部门");
        sysLog.setIp(IpAddr.getIpAddress(request));
        sysLog.setRemark("");
        String userAgent = request.getParameter("userAgent");
        if ("iOS".equals(userAgent)) {
            //添加客户端类型
            sysLog.setClientType(3);
            SysPara Version = sysParaMapper.querySysPara("APP_IOS_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("android".equals(userAgent)) {
            sysLog.setClientType(4);
            SysPara Version = sysParaMapper.querySysPara("APP_Android_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else if ("pc".equals(userAgent)) {
            sysLog.setClientType(2);
            SysPara Version = sysParaMapper.querySysPara("APP_PC_Version");
            sysLog.setClientVersion(Version.getParaValue());
        } else {
            sysLog.setClientType(1);
            String clientVersion = request.getParameter("clientVersion");
            if (clientVersion != null && clientVersion.length() > 0) {
                sysLog.setClientVersion(clientVersion);
            } else {
                sysLog.setClientVersion(SystemInfoServiceImpl.softVersion);
            }
        }
        try {
            departmentService.editDeptMap(map);
            sysLog.setRemark(department1.get("DEPT_NAME")+",DEPT_ID="+department1.get("DEPT_ID"));
            sysLog.setTime(new Date(System.currentTimeMillis()));
            syslogMapper.save(sysLog);
            json.setObject(map);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月18日 下午8:21:55
     * 方法介绍:   多条件查询部门信息
     * 参数说明:   @param department 部门信息
     * 参数说明:   @return
     *
     * @return ToJson<Department> 返回符合条件部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/getDeptByMany", method = RequestMethod.POST)
    public ToJson<Department> getDeptByMany(Department department, HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            List<Department> list = departmentService.getDeptByMany(department);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     *
     * @param department
     * @param request
     * @return minhang
     */
    @ResponseBody
    @RequestMapping(value = "/getDeptByManyMap", method = RequestMethod.POST)
    public ToJson<Department> getDeptByManyMap(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson json = new ToJson(0, null);
        try {
            Map map = new HashMap();
            map.put("ORGAN_FULLNAME",request.getParameter("ORGAN_FULLNAME"));
            map.put("ORGAN_NUM",request.getParameter("ORGAN_NUM"));
            map.put("UNIFIED_CREDIT_CODE",request.getParameter("UNIFIED_CREDIT_CODE"));
            List<Map<String,Object>> list = departmentService.getDeptByManyMap(map);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月20日 下午6:14:43
     * 方法介绍:   获取下级部门
     * 参数说明:   @param request 请求
     * 参数说明:   @param maps  存储分页对象
     * 参数说明:   @param page 当前页
     * 参数说明:   @param pageSize 页面数
     * 参数说明:   @param useFlag  是否启用分页插件
     * 参数说明:   @return
     *
     * @return String  返回下级部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/getChDeptfq", produces = {"application/json;charset=UTF-8"})
    public ToJson getChDept(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson json = new ToJson<Department>(0, null);
        try {
            Users users = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
            request.setCharacterEncoding("UTF-8");
            int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));

            String moduleId = request.getParameter("moduleId");
            Map<String,Object> map = modulePrivService.getModulePriv(users,moduleId);

            if(deptId == 0){
                String resultFlag = request.getParameter("resultFlag");
                if(!StringUtils.checkNull(resultFlag) && "simple".equals(resultFlag)){
                    List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(users, true, true);
                    List<DepartmentVO> dataList = new ArrayList<>();
                    List<DepartmentVO> resultList = new ArrayList<>();
                    Map<Integer, DepartmentVO> tmpMap = new HashMap<>(departmentByClassifyOrg.size());
                    for (Department t : departmentByClassifyOrg) {
                        DepartmentVO departmentVO = new DepartmentVO();
                        departmentVO.setDeptId(t.getDeptId());
                        departmentVO.setDeptNo(t.getDeptNo());
                        departmentVO.setDeptName(t.getDeptName());
                        departmentVO.setDeptParent(t.getDeptParent());
                        departmentVO.setIsOrg(t.getIsOrg());
                        departmentVO.setLeaf(t.getIsLeaf());
                        departmentVO.setDeptDisplay(t.getDeptDisplay());
                        departmentVO.setIsHaveCh("0");
                        dataList.add(departmentVO);
                        tmpMap.put(t.getDeptId(), departmentVO);
                    }
                    for (DepartmentVO department : dataList) {
                        DepartmentVO tmap = tmpMap.get(department.getDeptParent());
                        if (tmap != null && department.getDeptParent() != 0) {
                            if (null == tmap.getChild()) {
                                tmap.setChild(new ArrayList<>());
                            }
                            tmap.setIsHaveCh("1");
                            tmap.getChild().add(department);
                        } else {
                            resultList.add(department);
                        }
                    }
                    json.setObj(resultList);
                    json.setMsg("OK");
                    json.setFlag(0);
                    return json;
                }

                //是否是通讯薄页面调用
                String isAddress = request.getParameter("isAddress");
                List<String> addressDepartmentList = new ArrayList<>();
                Users addressUsers = usersMapper.findUsersByuserId(users.getUserId());
                if (!StringUtils.checkNull(isAddress) && "1".equals(isAddress) && !StringUtils.checkNull(addressUsers.getDeptYj()) && addressUsers.getDeptYj().split(",").length > 0) {
                    addressDepartmentList = Arrays.asList(addressUsers.getDeptYj().split(","));
                }

                List<Department> departmentByClassifyOrg = departmentService.getDepartmentByClassifyOrg(users, false, true);
                for (int i = 0; i < departmentByClassifyOrg.size(); i++) {
                    Department department = departmentByClassifyOrg.get(i);
                    if(department.getChild()!=null&&department.getChild().size()>0){
                        department.setIsHaveCh("1");
                    } else{
                        List<Department> chDept = departmentService.getChDept(department.getDeptId());
                        if (chDept.size() != 0) {
                            department.setIsHaveCh("1");
                        } else {
                            department.setIsHaveCh("0");
                        }
                    }
                }

                //通讯录查看权限过滤
                if (!CollectionUtils.isEmpty(addressDepartmentList)) {
                    List<Department> departments = new ArrayList<>();
                    for (Department department : departmentByClassifyOrg) {
                        if (addressDepartmentList.contains(department.getDeptId().toString())) {
                            departments.add(department);
                        }
                    }
                    departmentByClassifyOrg = departments;
                }

                String order = null;// 人员部门排序
                try {
                    order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
                }catch (Exception e){

                }
                try {
                    if ("1".equals(order)) {
                        for (Department list5 : departmentByClassifyOrg) {   //对的排序  先获得这个用户在在该部门排序号
                            if(!StringUtils.checkNull(list5.getUserId())){
                                list5.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(list5.getUserId(), deptId).getOrderNo());
                            }
                        }
                        if(departmentByClassifyOrg!=null)
                            Collections.sort(departmentByClassifyOrg, (Department a, Department b) -> a.getUserDeptNo() - b.getUserDeptNo());
                        //可以看到集合已经按升序排列完毕,如果需要降序排列，则将Lambda表达式改为(Student a,Student b) -> b.getAge() - a.getAge()即可;
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }

                json.setObj(departmentByClassifyOrg);
                json.setMsg("OK");
                json.setFlag(0);
                return json;
            }

            map.put("deptId",deptId);
            List<Users> l = usersMapper.getUsersByDeptIdAndModule(map);

            //查询是否开启三员安全管理，开启后用户管理和角色管理中查询接口不允许返回三员相关用户和角色
            securityApprovalService.removeSecrecyUsers(l,null);

            String order = null;// 人员部门排序
            try {
                order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
            }catch (Exception e){

            }
            try {
                if ("1".equals(order)) {
                    for (Users users1 : l) {   //对的排序  先获得这个用户在在该部门排序号
                        if (!StringUtils.checkNull(users1.getUserId())) {
                            //users1.setUserDeptNo(userDeptOrderMapper.selectUserAndDept(users1.getUserId(), u.getDeptId()).getOrderNo());
                            //规避没有这个排序的用户会报错给一个默认排序10
                            UserDeptOrder userDeptOrder = userDeptOrderMapper.selectUserAndDept(users1.getUserId(), deptId);
                            Integer userDeptNo = Objects.isNull(userDeptOrder) || Objects.isNull(userDeptOrder.getOrderNo()) ? 10 : userDeptOrder.getOrderNo();
                            users1.setUserDeptNo(userDeptNo);
                        }
                    }
                    Collections.sort(l, (Users a, Users b) -> a.getUserDeptNo() - b.getUserDeptNo());
                }
            }catch (Exception e){
                e.printStackTrace();
            }

            String deptDisplay = request.getParameter("deptDisplay");
            map.put("deptDisplay",StringUtils.checkNull(deptDisplay) ? 1 : null);
            List<Department> list = departmentService.getChDept(map);
            List<Department> list2 = new ArrayList<Department>();
            for (Department dep : list) {
                if(dep.getDeptParent()!=null&&dep.getDeptParent()>0){
                    Department department = departmentService.getDeptById(dep.getDeptParent());
                    dep.setDeptParentName(department.getDeptName());
                }
                List<Department> list1 = new ArrayList<Department>();
                map.put("deptId", dep.getDeptId());
                list1 = departmentService.getChDept(map);
                if (list1.size() != 0) {
                    dep.setIsHaveCh("1");
                } else {
                    dep.setIsHaveCh("0");
                }
                list2.add(dep);
            }

            int classifyCount=departmentService.selClaNumByParentId(deptId);
            if(classifyCount>0){
                json.setTotleNum(1);
            }else{
                json.setTotleNum(0);
            }

            json.setObject(l);
            json.setObj(list2);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            e.printStackTrace();
            json.setMsg(e.getMessage());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/getChDeptfqPlus", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> getChDeptfqPlus(HttpServletRequest request,String OID) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            if(OID!=null||"".equals(OID)){
                ContextHolder.setConsumerType("xoa" +OID);
            }
            request.setCharacterEncoding("UTF-8");
            int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));
            List<Department> list = departmentService.getChDept(deptId);
            List<Department> list2 = new ArrayList<Department>();
            for (Department dep : list) {
                if(dep.getDeptParent()!=null&&dep.getDeptParent()>0){
                    Department department = departmentService.getDeptById(dep.getDeptParent());
                    dep.setDeptParentName(department.getDeptName());
                }
                List<Department> list1 = new ArrayList<Department>();
                list1 = departmentService.getChDept(dep.getDeptId());
                if (list1.size() != 0) {
                    dep.setIsHaveCh("1");
                } else {
                    dep.setIsHaveCh("0");
                }
                list2.add(dep);
            }
            List<Users> l = usersService.getUsersByDeptId(deptId);

            int classifyCount=departmentService.selClaNumByParentId(deptId);
            if(classifyCount>0){
                json.setTotleNum(1);
            }else{
                json.setTotleNum(0);
            }
            json.setObject(l);
            json.setObj(list2);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }finally {
        loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月21日 下午2:52:46
     * 方法介绍:   获得多部门名
     * 参数说明:   @param request 请求
     * 参数说明:   @return
     *
     * @return String 返回长部门名
     */
    @ResponseBody
    @RequestMapping(value = "/getFatherDept", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> getFatherDept(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            request.setCharacterEncoding("UTF-8");
            int deptParent = Integer.parseInt(new String(request.getParameter("deptParent").getBytes("ISO-8859-1"), "UTF-8"));
            List<Department> list = new ArrayList<Department>();
            list = departmentService.getFatherDept(deptParent, list);
            StringBuffer sb = new StringBuffer();
            for (int i = list.size() - 1; i >= 0; i--) {
                sb.append(list.get(i).getDeptName());
                if (i > 0) {
                    sb.append("/");
                }
            }
            json.setObject(sb);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());

        }
        return json;
    }

    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月24日 下午8:58:05
     * 方法介绍:   根据部门排序号获得部门信息接口
     * 参数说明:   @param request 请求
     * 参数说明:   @param maps 集合
     * 参数说明:   @param page 当前页面
     * 参数说明:   @param pageSize 页面大小
     * 参数说明:   @param useFlag 是否开启分页
     * 参数说明:   @return
     *
     * @return String  返回部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/getChDeptByNo", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> getChDeptByNo(HttpServletRequest request, Map<String, Object> maps, Integer page,
                                            Integer pageSize, boolean useFlag) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            request.setCharacterEncoding("UTF-8");
            String deptNo = new String(request.getParameter("deptNo").getBytes("ISO-8859-1"), "UTF-8");
            maps.put("deptNo", deptNo);
            List<Department> list = new ArrayList<Department>();
            list = departmentService.getChDeptByNo(deptNo);
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 创建作者:   张龙飞
     * 创建日期:   2017年4月25日 下午2:12:15
     * 方法介绍:   获取当前部门下子部门与部门人员
     * 参数说明:   @param request
     * 参数说明:   @return
     *
     * @return String
     */
    @ResponseBody
    @RequestMapping(value = "/getChDept", produces = {"application/json;charset=UTF-8"})
    public AjaxJson getChDeptUser(HttpServletRequest request) {
        AjaxJson ajaxJson = new AjaxJson();
        try {
            int count =0;
            String deptId = request.getParameter("deptId");
            if (StringUtils.checkNull(deptId)){
                List<Department> list = departmentService.getDepartmentByParet();
                for (Department department : list){
                    int a = departmentService.getCountChDeptUser(department.getDeptNo());
                    count = count+a;
                    List<Department>  list2 = departmentService.getChDept(department.getDeptId());
                    if (list2.size() != 0) {
                        department.setIsHaveCh("1");
                    } else {
                        department.setIsHaveCh("0");
                    }
                }
                ajaxJson.setObj(list);
                ajaxJson.setTotleNum(count);
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("Initialize query");
                Map<String,Object> map=new HashedMap();
                map.put("claNum",0);
                ajaxJson.setAttributes(map);
                return ajaxJson;
            }
            //int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));
            List<Department> list = departmentService.getChDeptUser(Integer.parseInt(deptId));
            Department dep = departmentService.getDeptById(Integer.parseInt(deptId));
             count = departmentService.getCountChDeptUser(dep.getDeptNo());
             for (Department department : list){
                 List<Department>  l = departmentService.getChDept(dep.getDeptId());
                 if (l.size() != 0) {
                     department.setIsHaveCh("1");
                 } else {
                     department.setIsHaveCh("0");
                 }
             }
                Map<String,Object> map=new HashedMap();
                int classifyCount=departmentService.selClaNumByParentId(Integer.valueOf(deptId));
                if(classifyCount>0){
                    map.put("claNum",1);
                }else{
                    map.put("claNum",0);
                }
            ajaxJson.setAttributes(map);
            ajaxJson.setTotleNum(count);
            ajaxJson.setObj(list);
            ajaxJson.setMsg("OK");
            ajaxJson.setFlag(true);
        } catch (Exception e) {
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(e.getMessage());
        }
        return ajaxJson;
    }


    @ResponseBody
    @RequestMapping(value = "/getChDeptPlus", produces = {"application/json;charset=UTF-8"})
    public AjaxJson getChDeptUserPlus(HttpServletRequest request,String OID) {
        AjaxJson ajaxJson = new AjaxJson();

        try {
            if(OID!=null||"".equals(OID)){
                ContextHolder.setConsumerType("xoa" +OID);
            }

            int count =0;
            String deptId = request.getParameter("deptId");
            if (StringUtils.checkNull(deptId)){
                List<Department> list = departmentService.getDepartmentByParet();
                for (Department department : list){
                    int a = departmentService.getCountChDeptUser(department.getDeptNo());
                    count = count+a;
                    List<Department>  list2 = departmentService.getChDept(department.getDeptId());
                    if (list2.size() != 0) {
                        department.setIsHaveCh("1");
                    } else {
                        department.setIsHaveCh("0");
                    }
                }
                ajaxJson.setObj(list);
                ajaxJson.setTotleNum(count);
                ajaxJson.setFlag(true);
                ajaxJson.setMsg("Initialize query");
                Map<String,Object> map=new HashedMap();
                map.put("claNum",0);
                ajaxJson.setAttributes(map);
                return ajaxJson;
            }
            //int deptId = Integer.parseInt(new String(request.getParameter("deptId").getBytes("ISO-8859-1"), "UTF-8"));
            List<Department> list = departmentService.getChDeptUser(Integer.parseInt(deptId));
            Department dep = departmentService.getDeptById(Integer.parseInt(deptId));
            count = departmentService.getCountChDeptUser(dep.getDeptNo());
            for (Department department : list){
                List<Department>  l = departmentService.getChDept(dep.getDeptId());
                if (l.size() != 0) {
                    department.setIsHaveCh("1");
                } else {
                    department.setIsHaveCh("0");
                }
            }
            Map<String,Object> map=new HashedMap();
            int classifyCount=departmentService.selClaNumByParentId(Integer.valueOf(deptId));
            if(classifyCount>0){
                map.put("claNum",1);
            }else{
                map.put("claNum",0);
            }
            ajaxJson.setAttributes(map);
            ajaxJson.setTotleNum(count);
            ajaxJson.setObj(list);
            ajaxJson.setMsg("OK");
            ajaxJson.setFlag(true);
        } catch (Exception e) {
            ajaxJson.setFlag(false);
            ajaxJson.setMsg(e.getMessage());
        }finally {
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        }
        return ajaxJson;
    }


    @ResponseBody
    @RequestMapping(value = "/listDept", produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> listDept(HttpServletRequest request) {
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        String loginDateSouse = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        ContextHolder.setConsumerType("xoa" + loginDateSouse);
        ToJson<Department> json = new ToJson<Department>(0, null);
        try {
            List<Department> list = departmentService.listDept();
            for (int i=0;i<list.size();i++){
                Department department = list.get(i);
                String deptNo = department.getDeptNo();
                int count = deptNo.length()/3;
                StringBuffer sb = new StringBuffer();
                sb.append(".").append(org.apache.commons.lang3.StringUtils.repeat(" ", count)).append("|-").append(department.getDeptName());
                String depName = sb.toString();
                department.setDeptName(depName);
            }
            json.setObj(list);
            json.setMsg("OK");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());
        }
        return json;
    }


    /**
     * 部门列表-树111
     * @return
     */
       /* @RequestMapping(value = "/dep", method = RequestMethod.GET, produces = { "application/json;charset=UTF-8" })
	    public  @ResponseBody String treegrid(HttpServletResponse response) {
	        List<Department> menuList = DepartmentService.getDep();
	        System.out.println(menuList.size());
	       String json = createTreeJson(menuList);
	        return JSON.toJSONStringWithDateFormat(json, "yyyy-MM-dd HH:mm:ss");
	    }*/


    ////////////////////////////////////////////////////////////////////////////////////////////
    /**
     * 创建一颗树，以json字符串形式返回
     * @param list 原始数据列表
     * @return 树
     */
	/* private String createTreeJson(List<Department> list){
		  JSONArray rootArray = new JSONArray();
		  for (Department dept : list) {
			  if (dept.getDeptParent()==0) {//有父节点
				  
				  JSONObject rootObj = createBranch(list, dept);
				  rootArray.add(rootObj);
			}
			
		}
		 
		return rootArray.toString();
		 
		 
		 
	 }*/


    /**
     * 递归创建分支节点Json对象
     * @param list 创建树的原始数据
     * @param deptParent 当前节点
     * @return 当前节点与该节点的子节点json对象
     */
	 /* private JSONObject createBranch(List<Department> list, Department deptParent) {
		     
	         * 将javabean对象解析成为JSON对象
	         
		  JSONObject currentObj = JSONObject.fromObject(deptParent);
		  JSONArray childArray = new JSONArray();
		    
	         * 循环遍历原始数据列表，判断列表中某对象的父id值是否等于当前节点的id值，
	         * 如果相等，进入递归创建新节点的子节点，直至无子节点时，返回节点，并将该
	         * 节点放入当前节点的子节点列表中
	         
		  for (Department department : list) {
			if ((department.getDeptParent() == 0)&&
					(department.getDeptParent().compareTo(deptParent.getDeptId()) == 0)) {
				JSONObject childObj= createBranch(list, department);
				childArray.add(childObj);
			}
		}
		    
	         * 判断当前子节点数组是否为空，不为空将子节点数组加入children字段中
	         
		  if (!childArray.isEmpty()) {
	            currentObj.put("children", childArray);
	        }
		  return currentObj;
	  
	  }*/


    /**
     * @创建作者: 韩成冰
     * @创建日期: 2017/5/30 7:59
     * @函数介绍: 查询所有部门，子部门存储在父部门的list属性集合中
     * @参数说明: @param HttpServletRequest request
     * @return: Json
     **/
    @ResponseBody
    @RequestMapping("/getFatherChildDep")
    public ToJson<Department> getFatherChildDept(HttpServletRequest request) {


        ToJson<Department> toJson = new ToJson<Department>(0, "");
        try {
            List<Department> depList = departmentService.getFatherChildDept();
            toJson.setMsg("OK");
            toJson.setFlag(0);
            toJson.setObject(depList);
        } catch (Exception e) {
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年6月27日 下午14:30:12
     * 方法介绍:   根据子菜单名称进行模糊查询获取符合的数量
     * 参数说明:   @param funName
     * 参数说明:
     *
     * @return ToJson
     */
    @ResponseBody
    @RequestMapping(value = "/batchUpdateDeptById")
    public ToJson<Department> batchUpdateDeptById(String departments) {
        return departmentService.batchUpdateDeptById(departments);
    }


    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月3日 下午19:21:05
     * 方法介绍:   修正部门级次（排序号）
     * 参数说明:   @param departments
     * @return ToJson
     */
    @ResponseBody
    @RequestMapping(value = "/updateDeptNo")
    public ToJson<Department>  updateDeptNo(){
        int deptParent=0;
        String deptParentNo="";
        ToJson<Department> json = new ToJson<Department>(1, "error");
        int count=0;
        try{
            departmentService.updateDeptNo(deptParent,deptParentNo);
            json.setMsg("ok");
            json.setFlag(0);
        }catch(Exception e){
            json.setMsg(e.getMessage());
            L.e("DepartmentController updateDeptNo:"+e);
        }
        return  json;
    }
    //只为移动端提供！！！
    @ResponseBody
    @RequestMapping(value = "/AllDept", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public ToJson<Department> listDept() {
        ToJson<Department> json = new ToJson<Department>();
        try {
            //获取单位信息
            UnitManage unitManage = unitManageMapper.showUnitManage();
            Department department = new Department();
            department.setDeptId(0);
            department.setDeptName(unitManage.getUnitName());
            department.setDeptNo("");
            List<Department> depList = departmentService.listDept();
            List<Department> returnList = new ArrayList<Department>();
            returnList.add(department);
            returnList.addAll(depList);
            json.setObj(returnList);
            json.setFlag(0);
            json.setMsg("true");
        } catch (Exception e) {
            json.setMsg("false");
            json.setFlag(1);
        }
        return json;
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午10:30:30
     * 方法介绍:   部门信息导出
     */
    @ResponseBody
    @RequestMapping("/outputDepartment")
    public  ToJson<Department> outputDepartment(HttpServletRequest request, HttpServletResponse response){
        return departmentService.outputDepartment(request,response);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月5日 下午10:57:33
     * 方法介绍:   部门信息导入
     */
    @ResponseBody
    @RequestMapping("/inputDepartment")
    public  ToJson<Department> inputDepartment(HttpServletRequest request, HttpServletResponse response, MultipartFile file, HttpSession session){
        return departmentService.importDepartment(request,response,file);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年7月4日 下午18:00:05
     * 方法介绍:   获取所有部门信息
     * @return List<Department>
     */
    @ResponseBody
    @RequestMapping("/getAllDepartment")
    public ToJson<Department> getAllDepartment(){
        return departmentService.getAllDepartment();
    }

    @ResponseBody
    @RequestMapping("/getAllDeptAndUsers")
    public void getAllDeptAndUsers(HttpServletRequest request, HttpServletResponse response){
        departmentService.getAllDepartAndUsers(request,response);
    }


    @ResponseBody
    @RequestMapping("/importDepartment")
    public ToJson<Department> importDepartment(HttpServletRequest request,HttpServletResponse response,MultipartFile file){
        return departmentService.importDepartment(request,response,file);
    }


    /**
     * 根据父部门查询其子部门编号是否重复
     * @param deptParent
     * @return
     */
    @ResponseBody
    @RequestMapping("/selDeptNoByDeptParent")
    public ToJson<Department> selDeptNoByDeptParent(String deptParent,String deptNo,int editFlag,String proDeptNo){
        return departmentService.selDeptNoByDeptParent(deptParent,deptNo,editFlag,proDeptNo);
    }

    /**
     * 创建作者:   牛江丽
     * 创建日期:   2017年11月4日 下午10:22:51
     * 方法介绍:   获取根据部门名称模糊查询
     * 参数说明:   @return
     * @return     List<Department> 返回部门信息
     */
    @ResponseBody
    @RequestMapping("/selByLikeDeptName")
    public ToJson<Department> selByLikeDeptName(String deptName) {
        return departmentService.selByLikeDeptName(deptName);
    }

    /**
     * 部门搜索控件（分级机构下）
     * 王禹萌
     * 2019/3/7
     * @param deptName
     * @param deptNo
     * @return
     */
    @ResponseBody
    @RequestMapping("/selByLikeDeptNameAndDeptNo")
    public ToJson<Department> selByLikeDeptNameAndDeptNo(String deptName,String deptNo) {
        return departmentService.selByLikeDeptNameAndDeptNo(deptName,deptNo);
    }

    @ResponseBody
    @RequestMapping("/UsersByUidCorrection")
    public BaseWrapper UsersByUidCorrection(){
       return  usersService.UsersByUidCorrection();
    }

    /**
     * 牛江丽，获取所有子部门
     */
    @ResponseBody
    @RequestMapping("/getAllChildDept")
    public ToJson<Department>  getAllChildDept(Integer deptId){
        return departmentService.getAllChildDept(deptId);
    }
    @ResponseBody
    @RequestMapping("/getDepartmentYj")
    public ToJson<Department> getDepartmentYj(){
        return departmentService.getDepartmentYj();
    }

    @RequestMapping("/setting")
    public String setting(){
        return "app/department/smsNavbar";
    }
    @RequestMapping("/addSetting")
    public String addSetting(){
        return "app/department/newsms";
    }
    @RequestMapping("/infoSetting")
    public String infoSetting(){
        return "app/department/smsManager";
    }

    @RequestMapping("/infoList")
    @ResponseBody
    public ToJson<Department> infoList(){
        return departmentService.settingInfoList();
    }
    @RequestMapping("/infoAdd")
    @ResponseBody
    public ToJson infoAdd(@RequestParam(value = "deptId") String deptId,
                          @RequestParam(value = "smsGateAccount")String smsGateAccount){
        return  departmentService.settingAdd(deptId,smsGateAccount);
    }
    @RequestMapping("/infoDel")
    @ResponseBody
    public ToJson infoDel(@RequestParam(value = "deptId") String deptId){
        return  departmentService.settingDel(deptId);
    }

    @ResponseBody
    @RequestMapping(value = "/userDeptOrder")//可能不用
    public LimsJson<Department> userDeptOrder(Integer userId){
        return departmentService.userDeptOrder(userId);
    }
    @ResponseBody
    @RequestMapping(value = "/userUpdata")//更新所有人员排序号 /department
    public LimsJson<Department> userUpdata(){//把user里的数据全部同步到userdeptorder
        return departmentService.userUpdata();
    }

    @ResponseBody
    @RequestMapping(value = "/deptOrder")//获取人员所有排序号
    public LimsJson<UserDeptOrder> deptOrder(String userId){
        return departmentService.deptOrder(userId);
    }

    @ResponseBody
    @RequestMapping(value = "/updeptOrder")//更新排序号
    public LimsJson<UserDeptOrder> updeptOrder(String userDeptOrders){
        return departmentService.updeptOrder(userDeptOrders);
    }

    @ResponseBody
    @RequestMapping(value = "/order")//判断是否开启部门独立排序
    public ToJson<UserDeptOrder> order(){
        ToJson<UserDeptOrder> json = new ToJson<UserDeptOrder>(1, "error");
        String order = null;
        try {
            order = sysParaMapper.querySysPara("USER_DEPT_ORDER").getParaValue();//防止有的产品没有USER_DEPT_ORDER这个值
        }catch (Exception e){
            json.setMsg(e.getMessage());
            json.setFlag(1);
            json.setCode("0");
        }
        if ("1".equals(order)){
            json.setFlag(0);
            json.setMsg("开启部门独立排序");
            json.setCode("1");
        }else {
            json.setFlag(0);
            json.setMsg("不开启部门独立排序");
            json.setCode("0");
        }
        return json;
    }
    @ResponseBody
    @RequestMapping(value = "/selectUnallocated")//查询是否存在未分配部门
    public ToJson<Department> selectUnallocated(){
        return  departmentService.selectUnallocated();
    }
    //将部门设置未未分配部门
    @ResponseBody
    @RequestMapping(value = "/updateDept")
    public ToJson updateDept(Integer deptId){
        return  departmentService.updateDept(deptId);
    }
    // 重置个人的
    @ResponseBody
    @RequestMapping(value = "/resetUserId")
    public ToJson resetUserId(String userId){
        ToJson json = new ToJson(1, "error");
        userDeptOrderMapper.deleteUser(userId);
        Users user = usersMapper.findUsersByuserId(userId);
        String[] split = (user.getDeptId()+","+user.getDeptIdOther()).split(",");
        List<Department> departmentList= departmentMapper.userDeptOrder(split);
        for (Department department:departmentList){
            UserDeptOrder userDeptOrder = new UserDeptOrder();
            userDeptOrder.setDeptId(department.getDeptId());
            userDeptOrder.setUserId(user.getUserId());
            userDeptOrder.setOrderNo(user.getUserNo());
            userDeptOrder.setPostId(user.getPostId());
            UserDeptOrder userDeptOrder1 = userDeptOrderMapper.selectUserAndDept(user.getUserId(), department.getDeptId());
            if (userDeptOrder1==null){// 防止部门 和辅助部门设置同一个
                userDeptOrderMapper.insertSelective(userDeptOrder);
            }
        }
        json.setMsg("用户部门排序已重置！");
        json.setFlag(0);
        return  json;
    }
    /**
     *获取顶级部门 一级部门
     * 李金昊
     */
    @ResponseBody
    @RequestMapping("/getDeptTop")
    public ToJson getDeptTop(HttpServletRequest request){
        return  departmentService.getDeptTop(request);
    }

    /**
     * 李金昊，获取所有部门下子部门（包含本部门）
     */
    @ResponseBody
    @RequestMapping("/getChildDept")
    public ToJson getChildDept(HttpServletRequest request,Integer deptId){
        return departmentService.getChildDept(request,deptId);
    }

    /**
     * 创建作者: 金帅强 
     * 创建时间: 2022/10/11
     * 方法介绍: 查询本部门的所有上级
     * 参数说明: [request, deptId]
     * 返回值说明: com.xoa.util.ToJson
     **/
    @ResponseBody
    @RequestMapping("/selectDepartmentTop")
    public ToJson<Department> selectDepartmentTop(Integer deptId){
        return departmentService.selectDepartmentTop(deptId);
    }
    

    /**
     * description: 导出部门数据
     * create time: 2020-08-27 17:38
     * @return
     */
    @ResponseBody
    @RequestMapping("/exportDeptInfo")
    public ToJson exportDeptInfo(HttpServletRequest request,HttpServletResponse response){
        return departmentService.exportDeptInfo(request,response);
    }




    /**
     * 批量增加/删除用户辅助部门
     * @param userId
     * @param deptIds
     * @param sign sign:1表示添加  0表示删除
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateOtherDeptByUserIds")
    public ToJson<UserPriv> updateOtherDeptByUserIds(String userId, String deptIds, int sign) {
        if (sign == 1) {
            return departmentService.addOtherDeptByUserIds(userId, deptIds);
        } else {
            return departmentService.deleteOtherDeptByUserIds(userId, deptIds);
        }
    }

    /**
     * 创建作者: 金帅强
     * 创建时间: 2023/2/27
     * 方法介绍: 获取用户的部门使用权限
     * 参数说明: [request]
     * 返回值说明: com.xoa.util.ToJson<com.xoa.model.users.UserPriv>
     **/
    @ResponseBody
    @RequestMapping("/getUseDepartmentByUser")
    public ToJson<Department> getUseDepartmentByUser(HttpServletRequest request) {
        return departmentService.getUseDepartmentByUser(request);
    }



    @ResponseBody
    @RequestMapping(value = "/selectDeptOther")
    public ToJson selectDeptOther(HttpServletRequest request, String userId) {
        return departmentService.selectDeptOther(request, userId);
    }
}
