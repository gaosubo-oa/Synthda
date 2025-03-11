package com.xoa.service.securityApproval;

import com.xoa.model.securityApproval.SecurityContentApproval;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * ClassName: securityContentApprovalService <br/>
 * Description: <br/>
 * date: 2023/3/29 12:54<br/>
 *
 * @author 郑山河<br />
 * @since JDK 11
 */
public interface SecurityContentApprovalService {
     /**
      * 根据当前登录人权限查询数据
      * @author 郑山河
      * @param request
      * @return
      */
     ToJson selectByUserId(HttpServletRequest request,Integer page,Integer pageSize);

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
     int insert(String moduleTable,String recordId,String moduleName,String dataSubject,String dataUrl, String operationType,String contentSecrecy,HttpServletRequest request);
     /**
      * 更新数据
      * @author 郑山河
      * @param request
      * @return
      */
     ToJson update(HttpServletRequest request, SecurityContentApproval securityContentApproval);

     /**
      * 获取当前用户的人员密级所能查看的内容密级
      * @return
      */
     List<String> securityRestriction();

     /**
      * 获取指定用户的人员密级所能查看的内容密级
      * @param request
      * @param user
      * @return
      */
     List<String> securityRestrictionByUser(HttpServletRequest request,Users user);

     /**
      * 获取指定内容密级后能查看的人员密级
      * @param request
      * @param contentSecrecy
      * @return
      */
     List<String> securityRestrictionByContent(HttpServletRequest request,Users user,String contentSecrecy);

     /**
      * 根据模块主表和主表记录ID查询内容
      * @param moduleTable
      * @param recordId
      * @return
      */
     SecurityContentApproval selectContentSecrecyByModuleTable(String moduleTable,String recordId);
}
