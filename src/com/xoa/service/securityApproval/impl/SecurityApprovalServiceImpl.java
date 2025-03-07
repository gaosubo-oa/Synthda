package com.xoa.service.securityApproval.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.securityApproval.SecurityApprovalMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.securityApproval.SecurityApprovalWithBLOBs;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.UserPriv;
import com.xoa.model.users.Users;
import com.xoa.service.department.DepartmentService;
import com.xoa.service.securityApproval.SecurityApprovalService;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.service.sms.SmsService;
import com.xoa.service.users.UsersService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.DateFormat;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.L;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.ipUtil.IpAddr;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class SecurityApprovalServiceImpl implements SecurityApprovalService {

    @Resource
    private SecurityApprovalMapper securityApprovalMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SmsService smsService;

    @Resource
    private UsersService usersService;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private DepartmentService departmentService;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private SyslogMapper syslogMapper;

    @Resource
    private SecurityContentApprovalService securityContentApprovalService;

    /**
     * 新增一条安全审批数据
     * @param moduleTable  模块主表
     * @param recordId  关联模块主表中ID
     * @param operationUserId  操作人USER_ID
     * @param operationContent  操作内容，记录操作人员填写的需要审批的操作内容，json格式
     * @param operationType  操作类型，用于标记进行哪种操作:0表示新建，1表示编辑，2表示删除
     * @param operationReason  操作原因
     * @param attachmentId  附件ID串
     * @param attachmentName  附件文件名串
     * @param approverUserId  审批人USER_ID
     * @return
     */
    public SecurityApprovalWithBLOBs insertSelective(String moduleTable, Integer recordId, String operationUserId,String operationContent,
                                                     String operationType,String operationReason,String attachmentId,String attachmentName,
                                                     String approverUserId){
        try {
            SecurityApprovalWithBLOBs securityApproval = new SecurityApprovalWithBLOBs();
            securityApproval.setOperationContent(operationContent);
            securityApproval.setOperationReason(operationReason);
            securityApproval.setAttachmentId(attachmentId);
            securityApproval.setAttachmentName(attachmentName);
            securityApproval.setModuleTable(moduleTable);
            securityApproval.setRecordId(recordId);
            securityApproval.setOperationUserId(operationUserId);
            securityApproval.setOperationTime(new Date());
            securityApproval.setOperationType(operationType);
            securityApproval.setApproverUserId(approverUserId);
            if("2".equals(operationType)) {
                //用户、部门只限于系统安全保密员删除，所以不必再审批，直接将审批状态设置为通过
                securityApproval.setApprovalStatus("1");
            }else {
                securityApproval.setApprovalStatus("0");
            }
            securityApprovalMapper.insertSelective(securityApproval);
            return securityApproval;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 查询三员用户（系统安全管理员，系统安全保密员，系统安全审计员）
     * @param paraName 三员对应的系统参数名称（系统安全管理员-SYSECURITY_MANAGE_PRIV，系统安全保密员-SYSECURITY_SECRECY_PRIV，系统安全审计员-SYSECURITY_AUDIT_PRIV）
     * @return
     */
    @Override
    public Users selectSysSecurityUser(String paraName) {
        try{
            SysPara secrecyPriv = sysParaMapper.querySysPara(paraName);
            if(!Objects.isNull(secrecyPriv) && !StringUtils.checkNull(secrecyPriv.getParaValue())) {
                List<Users> users = usersMapper.getUsersByUserPriv(secrecyPriv.getParaValue());
                return users.get(0);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 查询需要保密员审批用户
     * @return
     */
    @Override
    public List<SecurityApprovalWithBLOBs> selectApproveUser(Map<String,Object> param) {
        return securityApprovalMapper.selectApproveUser(param);
    }


    /**
     * 保密员审批用户
     * @param request
     * @param approvalStatus 审批状态，标记审批是否通过，1为通过，2为拒绝
     * @param approvalOpinion 审批意见
     * @param operationContent 操作内容
     * @return
     */
    @Override
    public ToJson approveUser(HttpServletRequest request, Integer spId, String approvalStatus, String approvalOpinion,String operationContent) {
        ToJson toJson = new ToJson();
        toJson.setFlag(1);
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
            Users nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            if(!"1".equals(approvalStatus) && !"2".equals(approvalStatus)){
                toJson.setMsg("审批状态错误");
                return toJson;
            }

            //查询系统安全保密员
            Users sysSecurityUser = this.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
            if(!sysSecurityUser.getUserId().equals(nowUser.getUserId())){
                toJson.setMsg("非保密员，无审批权限");
                return toJson;
            }

            SecurityApprovalWithBLOBs approvalWithBLOBs = securityApprovalMapper.selectByPrimaryKey(spId);
            if(Objects.isNull(approvalWithBLOBs) || !"0".equals(approvalWithBLOBs.getApprovalStatus())){
                toJson.setMsg("审批不存在或审批状态错误");
                return toJson;
            }

            Map<String, String> params = JSONObject.parseObject(operationContent, new TypeReference<Map<String, String>>(){});
            Users users = new Users();
            if("user".equals(approvalWithBLOBs.getModuleTable())){
                users.setUid(approvalWithBLOBs.getRecordId());
                users.setUserSecrecy(params.get("userSecrecy"));
                users.setPostPriv(params.get("postPriv"));
                users.setPostDept(params.get("postDept"));
            }

            Department department = new Department();
            if("department".equals(approvalWithBLOBs.getModuleTable())){
                Department deptById = departmentMapper.getDeptById(approvalWithBLOBs.getRecordId());
                if(Objects.isNull(deptById)){
                    toJson.setMsg("部门不存在");
                    return toJson;
                }

                String manager = StringUtils.checkNull(params.get("manager")) ? deptById.getManager() : params.get("manager");
                String deptApprover = StringUtils.checkNull(params.get("deptApprover")) ? deptById.getDeptApprover() : params.get("deptApprover");
                if(!StringUtils.checkNull(manager) && !StringUtils.checkNull(deptApprover)){
                    //判断部门主管和部门审核人不能是同一个人，部门负责人和部门审核人只可以单选，不可以选多个人，部门审批人的密级不能低于部门负责人密级
                    String[] managerArr = manager.split(",");
                    String[] deptApproverArr = deptApprover.split(",");
                    if(managerArr.length > 1 || deptApproverArr.length > 1){
                        toJson.setMsg("部门负责人和部门审核人不能设置多个人");
                        return toJson;
                    }

                    if(managerArr[0].trim().equals(deptApproverArr[0].trim())){
                        toJson.setMsg("部门负责人和部门审核人不能相同");
                        return toJson;
                    }

                    List<SysCode> childCode = sysCodeMapper.getChildCode("USER_SECRECY");
                    Map<String, String> secrecyMap = childCode.stream().collect(Collectors.toMap(SysCode::getCodeNo, SysCode::getCodeOrder));
                    if(Integer.valueOf(secrecyMap.get(usersMapper.seleById(deptApproverArr[0]).getUserSecrecy())) < Integer.valueOf(secrecyMap.get(usersMapper.seleById(managerArr[0]).getUserSecrecy()))){
                        toJson.setMsg("部门审批人的密级不能低于部门负责人密级");
                        return toJson;
                    }
                }

                department.setManager(manager);
                department.setDeptApprover(deptApprover);
                department.setDeptId(approvalWithBLOBs.getRecordId());

            }

            Syslog syslog = new Syslog();
            syslog.setUserId(nowUser.getUserId());

            SmsBody smsBody = new SmsBody();
            smsBody.setContent("变更未同意！");
            smsBody.setTitle("变更未同意！");
            //审批状态为通过，回填审批数据
            if("1".equals(approvalStatus)){
                if("user".equals(approvalWithBLOBs.getModuleTable())){
                    //新建用户审核通过设置用户允许登录
                    if("0".equals(approvalWithBLOBs.getOperationType())){
                        users.setNotLogin(0);
                        users.setNotMobileLogin(0);
                    }
                    usersMapper.editUserSecrecy(users);
                    smsBody.setContent("用户变更已同意！");
                    smsBody.setTitle("用户变更已同意！");

                    syslog.setType(59);
                    syslog.setTypeName("人员审批");
                }

                if("department".equals(approvalWithBLOBs.getModuleTable())){
                    departmentMapper.editDeptSecrecy(department);
                    smsBody.setContent("部门变更已同意！");
                    smsBody.setTitle("部门变更已同意！");

                    syslog.setType(60);
                    syslog.setTypeName("部门审批");
                }
            }else {
                //审批状态为未通过，判断是否是新建操作，未通过删除新建的部门和用户
                if("0".equals(approvalWithBLOBs.getOperationType())){
                    if("user".equals(approvalWithBLOBs.getModuleTable())){
                        usersService.deleteUser(approvalWithBLOBs.getRecordId().toString(),request);

                        syslog.setType(59);
                        syslog.setTypeName("人员审批");
                    }
                    if("department".equals(approvalWithBLOBs.getModuleTable())){
                        departmentService.deleteDept(approvalWithBLOBs.getRecordId());

                        syslog.setType(60);
                        syslog.setTypeName("部门审批");
                    }
                }
            }

            //修改审批状态
            SecurityApprovalWithBLOBs record = new SecurityApprovalWithBLOBs();
            record.setSpId(spId);
            record.setApprovalStatus(approvalStatus);
            record.setApprovalOpinion(approvalOpinion);
            record.setApprovalTime(new Date());
            record.setApproverUserId(nowUser.getUserId());
            record.setOperationContent(operationContent);
            securityApprovalMapper.updateByPrimaryKeySelective(record);

            //通知操作用户
            smsBody.setFromId(nowUser.getUserId());
            smsBody.setSendTime(DateFormat.getTime(DateFormat.getCurrentTime()));
            smsBody.setSmsType("0");
            if("user".equals(approvalWithBLOBs.getModuleTable())){
                smsBody.setRemindUrl("/addUsers?" + approvalWithBLOBs.getRecordId());
            }
            if("department".equals(approvalWithBLOBs.getModuleTable())){
                smsBody.setRemindUrl("/common/deptManagement");
            }
            if(!StringUtils.checkNull(smsBody.getRemindUrl())) {
                smsService.saveSms(smsBody, approvalWithBLOBs.getOperationUserId(), "1", "1", smsBody.getTitle(), smsBody.getContent(), sqlType);
            }

            //添加系统日志
            try {
                syslog.setTime(record.getApprovalTime());
                // 设置ip
                syslog.setIp(IpAddr.getIpAddress(request));
                syslog.setRemark("审批结果：" + ("1".equals(approvalStatus)? "通过":"未通过") + "，审批用户："+nowUser.getUserName());
                syslogMapper.save(syslog);
            }catch (Exception e){
                e.printStackTrace();
            }

            toJson.setMsg("success");
            toJson.setFlag(0);
            toJson.setTurn(true);
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }

    /**
     * 查询三员角色
     * @return
     */
    @Override
    public List<String> querySecrecyUserPriv() {
        List<String> list = new ArrayList<>();
        try {
            //根据PARA_NAME列表查询
            List<String> item = new ArrayList<>();
            item.add("SYSECURITY_MANAGE_PRIV");
            item.add("SYSECURITY_SECRECY_PRIV");
            item.add("SYSECURITY_AUDIT_PRIV");
            List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);
            if(!Objects.isNull(sysParaList) && sysParaList.size() > 0) {
                String collect = sysParaList.stream().map(SysPara::getParaValue).collect(Collectors.joining(","));
                Collections.addAll(list, collect.split(","));
                return list;
            }
        } catch (Exception e) {
            L.e("SysParaServiceImpl.querySecrecySysPara：",e);
        }
        return list;
    }


    /**
     * 返回结果中去除三员角色的用户和系统超级管理员
     * @param usersList 用户列表
     * @param privList 角色列表
     */
    @Override
    public void removeSecrecyUsers(List<Users> usersList,List<UserPriv> privList) {
        //查询是否开启三员安全管理，开启后用户和角色管理中查询接口不允许返回三员相关用户(内置超级管理员除外)
        HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
        if(nowUser.getUserPriv() != 1 && !Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
            //是否需要屏蔽
            String moduleId = request.getParameter("moduleId");
            //查询三员角色，包含在内的去除
            List<String> secrecyUserPriv = new ArrayList<>();
            //根据PARA_NAME列表查询
            List<String> item = new ArrayList<>();
            item.add("SYSECURITY_MANAGE_PRIV");
            item.add("SYSECURITY_SECRECY_PRIV");
            item.add("SYSECURITY_AUDIT_PRIV");
            item.add("SYSECURITY_OPS_PRIV");
            List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);
            if(!Objects.isNull(sysParaList) && sysParaList.size() > 0) {
                for (SysPara sysPara : sysParaList) {
                    secrecyUserPriv.add(sysPara.getParaValue());
                    //保密员可以选择管理员和审计员,审计员可以选择管理员和保密员
                    if(!StringUtils.checkNull(moduleId) && "12".equals(moduleId) && nowUser.getUserPriv().toString().equals(sysPara.getParaValue())
                            && ("SYSECURITY_SECRECY_PRIV".equals(sysPara.getParaName()) || "SYSECURITY_AUDIT_PRIV".equals(sysPara.getParaName()))){
                        secrecyUserPriv.clear();
                        secrecyUserPriv.add(sysPara.getParaValue());
                        break;
                    }
                }
            }

            //系统超级管理员
            secrecyUserPriv.add("1");

            if(!Objects.isNull(usersList) && usersList.size() > 0){
                usersList.removeIf(u -> u != null && secrecyUserPriv.contains(u.getUserPriv().toString()));
            }
            if(!Objects.isNull(privList) && privList.size() > 0){
                privList.removeIf(p -> p != null && secrecyUserPriv.contains(p.getUserPriv().toString()));
            }

            //如果接口中传了内容密级参数，根据内容密级筛选能查看此内容的人员
            if(!StringUtils.checkNull(request.getParameter("contentSecrecy"))){
                String codeNo = sysCodeMapper.getByName("CONTENT_SECRECY", request.getParameter("contentSecrecy")).getCodeNo();
                List<String> restrictionList = securityContentApprovalService.securityRestrictionByContent(request, nowUser, codeNo);
                usersList.removeIf(u -> !restrictionList.contains(u.getUserSecrecy()));
            }
        }
    }


    /**
     * 返回结果中去除指定的部门
     * @param departmentList 部门列表
     */
    @Override
    public void removeSecrecyDept(List<Department> departmentList) {
        //查询是否开启三员安全管理，开启后用户和角色管理中查询接口不允许返回三员相关用户(内置超级管理员除外)
        HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
        if(!"admin".equals(nowUser.getUserId()) && !Objects.isNull(sanyuan) && "0".equals(sanyuan.getParaValue())) {
            departmentList.removeIf(d -> d != null && "999".equals(d.getDeptNo()));
        }
    }


    /**
     * 重置三员管理员的密码
     * @param request
     * @param approveUser 三员系统代码
     * @param password 需要重置的密码
     * @return
     */
    @Override
    public ToJson updateApproveUserPass(HttpServletRequest request, String approveUser, String password) {
        ToJson toJson = new ToJson();
        try{
            Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
            String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
            Users nowUser = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);

            //判断当前用户是审计员还是保密员
            Users secrecyPriv = this.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");//保密员
            Users auditPriv = this.selectSysSecurityUser("SYSECURITY_AUDIT_PRIV");//审计员
            Users managePriv = this.selectSysSecurityUser("SYSECURITY_MANAGE_PRIV");//管理员

            Syslog sysLog = new Syslog();
            boolean flag = false;
            //保密员重置 审计员 的密码
            if("AUDIT".equals(approveUser) && nowUser.getUserId().equals(secrecyPriv.getUserId())){
                sysLog.setRemark("系统安全保密员重置系统安全审计员登录密码");
                auditPriv.setPassword(password);
                usersService.updatePassword(auditPriv);
                flag = true;
            }

            //审计员重置 保密员 的密码
            if("SECRECY".equals(approveUser) && nowUser.getUserId().equals(auditPriv.getUserId())){
                sysLog.setRemark("系统安全审计员重置系统安全保密员登录密码");
                secrecyPriv.setPassword(password);
                usersService.updatePassword(secrecyPriv);
                flag = true;
            }

            //审计员重置 管理员 的密码
            if("MANAGE".equals(approveUser) && nowUser.getUserId().equals(auditPriv.getUserId())){
                sysLog.setRemark("系统安全审计员重置系统安全管理员登录密码");
                managePriv.setPassword(password);
                usersService.updatePassword(managePriv);
                flag = true;
            }

            if(flag) {
                toJson.setMsg("success");
                toJson.setFlag(0);
                //记录修改密码日志
                sysLog.setUserId(nowUser.getUserId());
                sysLog.setType(14);
                sysLog.setTypeName("修改登录密码");
                sysLog.setTime(new Date(System.currentTimeMillis()));
                sysLog.setRemark(sysLog.getRemark() + " 说明原因：" + request.getParameter("reason") + "，附件ID：" + request.getParameter("attachmentId") + "，附件名称：" + request.getParameter("attachmentName"));
                sysLog.setIp(IpAddr.getIpAddress(request));
                sysLog.setClientType(1);
                sysLog.setClientVersion(request.getParameter("clientVersion"));
                syslogMapper.save(sysLog);
            }else {
                toJson.setMsg("无权限");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return toJson;
    }


    /**
     * 查询需要系统安全保密员审批的用户信息
     * @param request
     * @return
     */
    @Override
    public ToJson queryApproveData(HttpServletRequest request,String approvalStatus,String moduleTable,Integer page,Integer pageSize,Boolean useFlag) {
        ToJson json = new ToJson();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users use = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(), redisSessionCookie);
        String sqlType = SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, redisSessionCookie);
        try {
            //查询是否开启三员管理（0是，1否）
            SysPara sanyuan = sysParaMapper.querySysPara("IS_OPEN_SANYUAN");
            if(Objects.isNull(sanyuan) || "1".equals(sanyuan.getParaValue())) {
                json.setMsg("未开启三员管理");
                return json;
            }

            //判断是否是保密员
            Users sysSecurityUser = this.selectSysSecurityUser("SYSECURITY_SECRECY_PRIV");
            if(!sysSecurityUser.getUserId().equals(use.getUserId())){
                json.setMsg("无权限查询");
                return json;
            }

            Map<String,Object> param = new HashMap<>();
            //分页
            PageParams pageParams = new PageParams();
            pageParams.setPage(page);
            pageParams.setPageSize(pageSize);
            pageParams.setUseFlag(useFlag);
            param.put("page", pageParams);

            param.put("approvalStatus",StringUtils.checkNull(approvalStatus) ? null : approvalStatus);
            param.put("moduleTable",moduleTable);
            List<SecurityApprovalWithBLOBs> securityApprovalWithBLOBs = this.selectApproveUser(param);
            if(!Objects.isNull(securityApprovalWithBLOBs) && securityApprovalWithBLOBs.size() > 0){
                //查询人员密级
                for (SecurityApprovalWithBLOBs securityApprovalWithBLOB : securityApprovalWithBLOBs) {
                    //解析操作内容
                    if (!StringUtils.checkNull(securityApprovalWithBLOB.getOperationContent())) {

                        Map map = JSON.parseObject(securityApprovalWithBLOB.getOperationContent(), Map.class);
                        if("user".equals(moduleTable)) {
                            Users user = null;
                            if(Objects.isNull(securityApprovalWithBLOB.getUsers())){
                                user = new Users();
                            }else {
                                user = securityApprovalWithBLOB.getUsers();
                            }
                            if (map.containsKey("userSecrecy") && !Objects.isNull(map.get("userSecrecy"))) {
                                user.setUserSecrecy(map.get("userSecrecy").toString());
                            }
                            if (map.containsKey("postPriv") && !Objects.isNull(map.get("postPriv"))) {
                                user.setPostPriv(map.get("postPriv").toString());
                            }
                            if (map.containsKey("postDept") && !StringUtils.checkNull(map.get("postDept").toString())) {
                                user.setPostDept(map.get("postDept").toString());
                                List<Department> deptPNameByUserIds = departmentMapper.getDParentNameByIds(user.getPostDept().split(","));
                                user.setPostDeptName(deptPNameByUserIds.stream().map(Department::getDeptName).collect(Collectors.joining(",")));
                            }
                            securityApprovalWithBLOB.setUsers(user);
                        }

                        if("department".equals(moduleTable)) {
                            Department department = null;
                            if(Objects.isNull(securityApprovalWithBLOB.getDepartment())){
                                department = new Department();
                            }else {
                                department = securityApprovalWithBLOB.getDepartment();
                            }
                            if (map.containsKey("manager") && !Objects.isNull(map.get("manager"))) {
                                department.setManager(map.get("manager").toString());
                                department.setManagerStr(usersService.getUserNameById(department.getManager()));
                            }
                            if (map.containsKey("deptApprover") && !Objects.isNull(map.get("deptApprover"))) {
                                department.setDeptApprover(map.get("deptApprover").toString());
                                department.setDeptApproverName(usersService.getUserNameById(department.getDeptApprover()));
                            }
                            securityApprovalWithBLOB.setDepartment(department);
                        }
                    }

                    if(!StringUtils.checkNull(securityApprovalWithBLOB.getAttachmentId()) && !StringUtils.checkNull(securityApprovalWithBLOB.getAttachmentName())){
                        securityApprovalWithBLOB.setAttachmentList(GetAttachmentListUtil.returnAttachment(securityApprovalWithBLOB.getAttachmentName(), securityApprovalWithBLOB.getAttachmentId(), "xoa" + sqlType, GetAttachmentListUtil.MODULE_SYS));
                    }
                }
            }

            json.setMsg("success");
            json.setObj(securityApprovalWithBLOBs);
            json.setTotleNum(pageParams.getTotal());
            json.setFlag(0);
        }catch (Exception e){
            e.printStackTrace();
        }
        return json;
    }


    /**
     * 查询未审批的用户或部门信息
     * @param approvalStatus 审批状态，标记审批是否通过，0为未审批，1为通过，2为拒绝
     * @param moduleTable  模块主表
     * @param recordId 关联模块主表中ID
     * @return
     */
    @Override
    public List<SecurityApprovalWithBLOBs> queryNotApprove(String approvalStatus, String moduleTable, String recordId) {
        //查询修改的用户是否存在保密员未审批的变更
        Map<String,Object> aproveParam = new HashMap<>();
        aproveParam.put("approvalStatus",approvalStatus);
        aproveParam.put("moduleTable",moduleTable);
        aproveParam.put("recordId",recordId);
        return this.selectApproveUser(aproveParam);
    }


    /**
     * 判断用户是否属于涉密系统管理员（超级管理员、系统安全保密员、系统安全审计员、系统安全管理员、系统运维管理员）
     * @param user
     * @return 0否 1是
     */
    @Override
    public Integer checkIsSecrecyAdm(Users user) {
        try{
            if(Objects.isNull(user) || Objects.isNull(user.getUserPriv())){
                return 0;
            }
            //根据PARA_NAME列表查询
            List<String> item = new ArrayList<>();
            List<String> secrecyUserPriv = new ArrayList<>();
            //超级管理员
            secrecyUserPriv.add("1");
            //系统安全管理员
            item.add("SYSECURITY_MANAGE_PRIV");
            //系统安全保密员
            item.add("SYSECURITY_SECRECY_PRIV");
            //系统安全审计员
            item.add("SYSECURITY_AUDIT_PRIV");
            //系统运维管理员
            item.add("SYSECURITY_OPS_PRIV");
            List<SysPara> sysParaList = sysParaMapper.getSysParaList(item);
            if(!Objects.isNull(sysParaList) && sysParaList.size() > 0) {
                secrecyUserPriv.addAll(sysParaList.stream().map(SysPara::getParaValue).filter(s -> !StringUtils.checkNull(s)).collect(Collectors.toList()));
            }
            return secrecyUserPriv.contains(user.getUserPriv().toString()) ? 1 : 0;
        }catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
