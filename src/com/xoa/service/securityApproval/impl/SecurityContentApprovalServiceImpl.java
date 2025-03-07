package com.xoa.service.securityApproval.impl;

import com.xoa.controller.affair.AffairConteoller;
import com.xoa.controller.notify.NotifyController;
import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.common.SysParaMapper;
import com.xoa.dao.common.SyslogMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.securityApproval.SecurityContentApprovalMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sms.SmsMapper;
import com.xoa.dao.users.UsersMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.common.SysPara;
import com.xoa.model.common.Syslog;
import com.xoa.model.department.Department;
import com.xoa.model.securityApproval.SecurityContentApproval;
import com.xoa.model.securityApproval.SecurityContentApprovalExample;
import com.xoa.model.sms.SmsBody;
import com.xoa.model.users.Users;
import com.xoa.service.securityApproval.SecurityContentApprovalService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
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
import java.util.*;
import java.util.stream.Collectors;

/**
 * ClassName: SecurityContentApprovalServiceImpl <br/>
 * Description: <br/>
 * date: 2023/3/29 12:58<br/>
 *
 * @author 郑山河<br />
 * @since JDK 11
 */
@Service
public class SecurityContentApprovalServiceImpl implements SecurityContentApprovalService {

    @Resource
    private SecurityContentApprovalMapper securityContentApprovalMapper;

    @Resource
    private SysParaMapper sysParaMapper;

    @Resource
    private DepartmentMapper departmentMapper;

    @Resource
    private SysCodeMapper sysCodeMapper;

    @Resource
    private UsersMapper usersMapper;

    @Resource
    private SmsMapper smsMapper;

    @Resource
    private SmsBodyMapper smsBodyMapper;

    @Resource
    private SyslogMapper syslogMapper;

    @Override
    public ToJson selectByUserId(HttpServletRequest request,Integer page,Integer pageSize) {
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users());
        ToJson toJson=new ToJson(1,"err");
        PageParams pageParams=new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(true);
        Map<String,Object> map=new HashMap<>();
        map.put("pageParams",pageParams);
        try {
            //模块数据是否显示密级字段
            SysPara sysPara = sysParaMapper.querySysPara("IS_SHOW_SECRET");
            if(!Objects.isNull(sysPara) && sysPara.getParaValue().equals("1")) {
                map.put("userId", users.getUserId());
                //获取审核状态，为空默认获取待审核状态
                String approvalStatus = request.getParameter("approvalStatus");
                List<SecurityContentApproval> securityContentApprovals = new ArrayList<>();
                if(StringUtils.checkNull(approvalStatus) || "0".equals(approvalStatus)){
                    map.put("approvalStatus", "0");
                    securityContentApprovals = securityContentApprovalMapper.selectByApproverUserId(map);
                }else {
                    securityContentApprovals = securityContentApprovalMapper.selectByRealApproverUserId(map);
                }

                if(securityContentApprovals.size() == 0){
                    toJson.setMsg("OK");
                    toJson.setFlag(0);
                    return toJson;
                }

                //查询内容密级系统代码
                List<SysCode> contentSecrecy = sysCodeMapper.getChildCode("CONTENT_SECRECY");
                Map<String, String> sysCodeMaps = contentSecrecy.stream().collect(Collectors.toMap(SysCode::getCodeNo,SysCode::getCodeName));

                //获取操作人
                String[] operationUserIdArr = securityContentApprovals.stream().map(SecurityContentApproval::getOperationUserId)
                        .filter(operationUserId -> !StringUtils.checkNull(operationUserId)).collect(Collectors.joining(",")).split(",");
                Map<String, String> operationUserMap = usersMapper.getUsersByUserIds(operationUserIdArr).stream().collect(Collectors.toMap(Users::getUserId, Users::getUserName));

                for (SecurityContentApproval securityContentApproval : securityContentApprovals) {
                    if(!StringUtils.checkNull(securityContentApproval.getOperationUserId())){
                        securityContentApproval.setOperationUserId(operationUserMap.get(securityContentApproval.getOperationUserId()));
                    }
                    if(securityContentApproval.getContentSecrecy()!=null){
                        securityContentApproval.setContentSecrecy(sysCodeMaps.containsKey(securityContentApproval.getContentSecrecy()) ? sysCodeMaps.get(securityContentApproval.getContentSecrecy()) : "");
                    }
                    if(securityContentApproval.getOperationType()!=null){
                       if("0".equals(securityContentApproval.getOperationType())){
                           securityContentApproval.setOperationType("新建");
                       }else if("1".equals(securityContentApproval.getOperationType())){
                           securityContentApproval.setOperationType("编辑");
                       }else if("2".equals(securityContentApproval.getOperationType())){
                           securityContentApproval.setOperationType("删除");
                       }
                    }

                    //获取流程传阅的传阅人名称
                    if("flow_run_read".equals(securityContentApproval.getModuleTable())){
                        securityContentApproval.setDataSubject("流程传阅人：" + usersMapper.getUsersByUserIds(securityContentApproval.getDataSubject().split(",")).stream().map(Users::getUserName).collect(Collectors.joining(",")));
                    }
                }
                toJson.setMsg("OK");
                toJson.setFlag(0);
                toJson.setObj(securityContentApprovals);
                toJson.setTotleNum(pageParams.getTotal());
            }else {
                toJson.setFlag(0);
                toJson.setMsg("OK");
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }

    /**
     * 添加安全内容审批表数据
     * @param moduleTable 模块主表表名
     * @param recordId  主表记录ID
     * @param moduleName  模块名
     * @param dataSubject  数据标题
     * @param dataUrl  数据详情URL
     * @param operationType  操作类型:0新建，1编辑，2删除
     * @param contentSecrecy  密级：系统代码
     * @param request
     * @return
     */
    public int insert(String moduleTable,String recordId,String moduleName,String dataSubject,String dataUrl, String operationType,String contentSecrecy,HttpServletRequest request){

        SecurityContentApproval securityContentApproval=new SecurityContentApproval(moduleTable,recordId,moduleName,dataSubject,dataUrl,operationType,contentSecrecy);
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users());

        //根据moduleTable、recordId、operationType、approvalStatus查询是否存在未审批的数据
        SecurityContentApprovalExample example = new SecurityContentApprovalExample();
        example.createCriteria().andModuleTableEqualTo(moduleTable).andRecordIdEqualTo(recordId)
                .andOperationTypeEqualTo(operationType).andApprovalStatusEqualTo("0");
        List<SecurityContentApproval> securityContentApprovals = securityContentApprovalMapper.selectByExampleWithBLOBs(example);
        if(!Objects.isNull(securityContentApprovals) && securityContentApprovals.size() > 0){
            return 0;
        }

        //操作时间
        securityContentApproval.setOperationTime(new Date());
        //操作人
        securityContentApproval.setOperationUserId(users.getUserId());
        //待审核
        if (!StringUtils.checkNull(moduleTable) && "cms_document_info".equals(moduleTable)) {
            // cms文档管理，新建文档，不要直接待审批，点击发布后再审批
            securityContentApproval.setApprovalStatus("");
        } else {
            securityContentApproval.setApprovalStatus("0");
        }


        //查询当前用户部门，获取当前用户的部门部门主管（部门负责人）和部门审核人
        Department department = departmentMapper.selectByDeptId(users.getDeptId());
        if(!Objects.isNull(department) && (!StringUtils.checkNull(department.getManager()) || !StringUtils.checkNull(department.getDeptApprover()))){
            //拼装可审核人USER_ID串
            String[] managerArr = department.getManager().split(",");
            if(managerArr != null && Arrays.asList(managerArr).contains(users.getUserId())){
                //当前用户是部门主管，由部门审核人审核
                securityContentApproval.setApproverUserId(department.getDeptApprover());
            }else {
                //部门主管（部门负责人）和部门审核人
                securityContentApproval.setApproverUserId(Arrays.asList((department.getManager() + "," + department.getDeptApprover()).split(","))
                        .stream().filter(a -> !StringUtils.checkNull(a)).collect(Collectors.joining(",")));
            }
        }
        int i = securityContentApprovalMapper.insertSelective(securityContentApproval);

        //TODO 添加事务提醒


        //添加系统日志
        try {
            Syslog syslog = new Syslog();
            syslog.setUserId(users.getUserId());
            syslog.setType(57);
            syslog.setTypeName("提交内容发布审批");
            syslog.setTime(securityContentApproval.getOperationTime());
            // 设置ip
            syslog.setIp(IpAddr.getIpAddress(request));
            SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", contentSecrecy);
            String operationTypeStr;
            switch (operationType){
                case "0":
                    operationTypeStr = "新建";
                    break;
                case "1":
                    operationTypeStr = "编辑";
                    break;
                case "2":
                    operationTypeStr = "删除";
                    break;
                default:
                    operationTypeStr = "";
            }
            syslog.setRemark("操作类型：" + operationTypeStr + "，提交用户："+users.getUserName() + "，内容模块：" + moduleName + "，内容标题：" + dataSubject + "，内容密级：" + sysCode.getCodeName() + "，模块主表：" + moduleTable + "，主表记录" + recordId);
            syslogMapper.save(syslog);
        }catch (Exception e){
            e.printStackTrace();
        }
        return i;
    }


    @Override
    public ToJson update(HttpServletRequest request, SecurityContentApproval securityContentApproval) {
        ToJson toJson=new ToJson(1,"err");
        Users users= SessionUtils.getSessionInfo(request.getSession(), Users.class,new Users());
        try {
            if(StringUtils.checkNull(securityContentApproval.getApprovalStatus())){
                toJson.setMsg("审核状态为空");
                return toJson;
            }
            SecurityContentApproval approval = securityContentApprovalMapper.selectByPrimaryKey(securityContentApproval.getSpcId());
            if(Objects.isNull(approval)){
                toJson.setFlag(0);
                toJson.setMsg("审核数据为空");
            }

            //判断审批内容的操作类型是否是删除类型，审批状态是否是同意
            if("2".equals(approval.getOperationType()) && "1".equals(securityContentApproval.getApprovalStatus())){
                this.deleteSecurityContent(request,approval);
            }

            //实际审核人
            securityContentApproval.setRealApproverUserId(users.getUserId());
            //审核时间
            securityContentApproval.setApprovalTime(new Date());
            //更新审核状态
            int i = securityContentApprovalMapper.updateByPrimaryKeySelective(securityContentApproval);
            if(i!=0){
                toJson.setFlag(0);
                toJson.setMsg("更新成功");
            }
            //修改事务提醒状态
            if("1".equals(securityContentApproval.getApprovalStatus())){
                //审核通过将事务提醒状态改为未删除
                this.updateSmsDeleteFlag(approval.getDataUrl(),"0");
            }else {
                //审核未通过将事务提醒状态改为收信人和发信人都已删除
                this.updateSmsDeleteFlag(approval.getDataUrl(),"4");
            }

            //添加系统日志
            try {
                Syslog syslog = new Syslog();
                syslog.setUserId(users.getUserId());
                syslog.setType(58);
                syslog.setTypeName("内容发布审批");
                syslog.setTime(securityContentApproval.getApprovalTime());
                // 设置ip
                syslog.setIp(IpAddr.getIpAddress(request));
                SysCode sysCode = sysCodeMapper.getSingleCode("CONTENT_SECRECY", approval.getContentSecrecy());
                String operationTypeStr;
                switch (approval.getOperationType()){
                    case "0":
                        operationTypeStr = "新建";
                        break;
                    case "1":
                        operationTypeStr = "编辑";
                        break;
                    case "2":
                        operationTypeStr = "删除";
                        break;
                    default:
                        operationTypeStr = "";
                }
                syslog.setRemark("审批结果：" + ("1".equals(securityContentApproval.getApprovalStatus())? "通过":"未通过") + "，审批操作类型：" + operationTypeStr + "，审批用户："+users.getUserName()
                        + "，审批内容模块：" + approval.getModuleName() + "，审批内容标题：" + approval.getDataSubject() + "，审批内容密级：" + sysCode.getCodeName() + "，审批模块主表：" + approval.getModuleTable() + "，审批主表记录" + approval.getRecordId());
                syslogMapper.save(syslog);
            }catch (Exception e){
                e.printStackTrace();
            }
        }catch (Exception e){
            e.printStackTrace();
            toJson.setMsg(e.getMessage());
        }
        return toJson;
    }


    public List<String> securityRestriction() {
        //获取登录用户
        HttpServletRequest request = ((ServletRequestAttributes) (RequestContextHolder.currentRequestAttributes())).getRequest();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(), Users.class, new Users(),redisSessionCookie);
        return securityRestrictionByUser(request,user);
    }


    public List<String> securityRestrictionByUser(HttpServletRequest request,Users user) {
        //获取登录用户
        List<String> restrictionList = new ArrayList<>();
        if("admin".equals(user.getUserId())){
            restrictionList.add("PUBLIC_SECRECY");
            restrictionList.add("INSIDE_SECRECY");
            restrictionList.add("SECRET_SECRECY");
            restrictionList.add("CONFIDENTIAL_SECRECY");
            return restrictionList;
        }

        if(StringUtils.checkNull(user.getUserSecrecy())){
            user = usersMapper.seleById(user.getUserId());
            if(StringUtils.checkNull(user.getUserSecrecy())){
                restrictionList.add("noSecrecy");
                return restrictionList;
            }
        }

        //TODO 判断系统密级：公开、内部级、秘密级、机密级、绝密级；先临时只考虑机密级的对应关系
        switch (user.getUserSecrecy().trim()) {
            case "INSIDE_SECRECY" :  //人员密级：内部
                restrictionList.add("PUBLIC_SECRECY");
                restrictionList.add("INSIDE_SECRECY");
                break;
            case "ORDINARY_SECRECY" :  //人员密级：一般
                restrictionList.add("PUBLIC_SECRECY");
                restrictionList.add("INSIDE_SECRECY");
                restrictionList.add("SECRET_SECRECY");
                break;
            case "IMPORTANT_SECRECY" :  //人员密级：重要
                restrictionList.add("PUBLIC_SECRECY");
                restrictionList.add("INSIDE_SECRECY");
                restrictionList.add("SECRET_SECRECY");
                restrictionList.add("CONFIDENTIAL_SECRECY");
                break;
            case "CORE_SECRECY" :  //人员密级：核心
                restrictionList.add("PUBLIC_SECRECY");
                restrictionList.add("INSIDE_SECRECY");
                restrictionList.add("SECRET_SECRECY");
                restrictionList.add("CONFIDENTIAL_SECRECY");
                break;
            default:
                break;
        }
        return restrictionList;
    }


    public List<String> securityRestrictionByContent(HttpServletRequest request,Users user,String contentSecrecy) {
        //获取登录用户
        List<String> restrictionList = new ArrayList<>();
        if("admin".equals(user.getUserId())){
            return restrictionList;
        }

        //TODO 判断系统密级：公开、内部级、秘密级、机密级、绝密级；先临时只考虑机密级的对应关系
        switch (contentSecrecy) {
            case "PUBLIC_SECRECY" :  //内容密级：公开
                restrictionList.add("INSIDE_SECRECY");
                restrictionList.add("ORDINARY_SECRECY");
                restrictionList.add("IMPORTANT_SECRECY");
                restrictionList.add("CORE_SECRECY");
                break;
            case "INSIDE_SECRECY" :  //内容密级：内部
                restrictionList.add("INSIDE_SECRECY");
                restrictionList.add("ORDINARY_SECRECY");
                restrictionList.add("IMPORTANT_SECRECY");
                restrictionList.add("CORE_SECRECY");
                break;
            case "SECRET_SECRECY" :  //内容密级：秘密
                restrictionList.add("ORDINARY_SECRECY");
                restrictionList.add("IMPORTANT_SECRECY");
                restrictionList.add("CORE_SECRECY");
                break;
            case "CONFIDENTIAL_SECRECY" :  //内容密级：机密
                restrictionList.add("IMPORTANT_SECRECY");
                restrictionList.add("CORE_SECRECY");
                break;
            default:
                break;
        }
        return restrictionList;
    }

    /**
     * 根据模块主表和主表记录ID查询内容
     * @param moduleTable
     * @param recordId
     * @return
     */
    @Override
    public SecurityContentApproval selectContentSecrecyByModuleTable(String moduleTable, String recordId) {
        SecurityContentApproval securityContentApproval = securityContentApprovalMapper.selectByModuleTableAndRecordId(moduleTable, recordId);
        return Objects.isNull(securityContentApproval) ? new SecurityContentApproval() : securityContentApproval;
    }

    private void updateSmsDeleteFlag(String remindUrl,String deleteFlag){
        try {
            if (StringUtils.checkNull(remindUrl) || !remindUrl.contains("/workflow/work/workformPreView")) {
                return;
            }
            //根据remindUrl查询bodyId
            SmsBody smsBody = smsBodyMapper.selectBodyIdByRemindUrl(remindUrl);
            if (Objects.isNull(smsBody) || Objects.isNull(smsBody.getBodyId())) {
                return;
            }
            Map<String, Object> map = new HashMap<>();
            map.put("bodyId", smsBody.getBodyId());
            map.put("deleteFlag", deleteFlag);
            smsMapper.updateSmsDeleteFlag(map);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Resource
    private AffairConteoller affairConteoller;
    @Resource
    private NotifyController notifyController;

    private void deleteSecurityContent(HttpServletRequest request,SecurityContentApproval approval) {
        //跳过各模块删除接口中增加删除审批的标识
        request.setAttribute("approvalStatus","1");
        request.setAttribute("approvalFlagUserId",approval.getOperationUserId());
        switch (approval.getModuleTable()){
            case "affair":
                affairConteoller.deleteByPrimaryKey(request,Integer.valueOf(approval.getRecordId()));
                break;

            case "notify":
                notifyController.deleteById(Integer.valueOf(approval.getRecordId()),request);
                break;

            case "flow_run":

                break;

            default:
                break;
        }

    }

}
