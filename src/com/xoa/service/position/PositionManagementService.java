package com.xoa.service.position;

import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.position.PositionManagementMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.position.UserJob;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.StringUtils;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;

@Service
public class PositionManagementService {

    @Autowired
    PositionManagementMapper positionManagementMapper;
    @Autowired
    SysCodeMapper sysCodeMapper;
    @Autowired
    DepartmentMapper departmentMapper;


    public ToJson<UserJob> selectUserJobList(HttpServletRequest request,UserJob userJob){
        ToJson<UserJob> toJson=new ToJson<UserJob>(1,"error");
          /*  PageParams params=new PageParams();*/
           /* params.setPage(page);
            params.setPageSize(pageSize);
            params.setUseFlag(userFlag);
            map.put("page",params);*/
        List<UserJob> list=positionManagementMapper.selectUserJobList(userJob);
        /*//分页总条数
         int getcount=0;
         getcount=positionManagementMapper.getcount();*/
        String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");

        for(UserJob userJob1:list){
            SysCode sysCode=sysCodeMapper.getSingleCode("function",String.valueOf(userJob1.getType()));
            if(sysCode!=null){
                userJob1.setTypeName(sysCode.getCodeName());
                if (locale.equals("zh_CN")) {
                    userJob1.setTypeName(sysCode.getCodeName());
                } else if (locale.equals("en_US")) {
                    userJob1.setTypeName(sysCode.getCodeName1());
                } else if (locale.equals("zh_TW")) {
                    userJob1.setTypeName(sysCode.getCodeName2());
                }
            }else {
                userJob1.setTypeName("");
            }
            if(!Objects.isNull(userJob1.getDeptId())){
                Department mapperDeptById= departmentMapper.getDeptById(userJob1.getDeptId());
                if (mapperDeptById!=null){
                    userJob1.setDeptName(mapperDeptById.getDeptName());
                }else{
                    userJob1.setDeptName("");
                }
            }else{
                userJob1.setDeptName("全体部门");
            }

        }
        if(list!=null){
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            toJson.setObj(list);
        }else{
            toJson.setFlag(1);
            toJson.setMsg("列表为空");
        }

        return  toJson;

    }


    //修改
    public ToJson<UserJob> updateUserJob(UserJob userJob){
            ToJson<UserJob> toJson=new ToJson<UserJob>(1,"error");
            int a=positionManagementMapper.updateUserJob(userJob);
            if(a>0){

                toJson.setFlag(0);
                toJson.setMsg("修改成功");
            }else{
                toJson.setFlag(1);
                toJson.setMsg("修改失败");
            }
        return toJson;
    }
    //通过jobId删除岗位信息

    public ToJson<UserJob> deleteUserJob(Integer jobId){
        ToJson<UserJob> toJson=new ToJson<UserJob>(1,"error");
        int a=positionManagementMapper.deleteUserJob(jobId);
        if(a>0){
            toJson.setFlag(0);
            toJson.setMsg("删除成功");
        }else{

            toJson.setFlag(1);
            toJson.setMsg("删除失败");
        }

        return toJson;

    }


    //插入岗位信息

    public ToJson<UserJob> addUserJob(UserJob userJob){

        ToJson<UserJob> toJson=new ToJson<UserJob>(1,"error");
        int a=positionManagementMapper.addUserJob(userJob);
        if(a>0){
            toJson.setFlag(0);
            toJson.setMsg("插入成功");
        }else{
            toJson.setFlag(1);
            toJson.setMsg("插入失败");
                }
        return  toJson;
    }
     //通过jobId获取数据
    public ToJson<UserJob> getUserjobId(HttpServletRequest request, Integer jobId){
      ToJson<UserJob> toJson=new ToJson<UserJob>(1,"error");
     UserJob list=positionManagementMapper.getUserjobId(jobId);

      if(list!=null){
        SysCode sysCode=sysCodeMapper.getSingleCode("function",String.valueOf(list.getType()));
        if(sysCode!=null){
            list.setTypeName(sysCode.getCodeName());
         }else {
             list.setTypeName("");
         }

         //岗位附件
          String sqlType = "xoa"
                  + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
          ContextHolder.setConsumerType(sqlType);

          if (!StringUtils.checkNull(list.getAttachmentName())&&!StringUtils.checkNull(list.getAttachmentId())) {
              list.setAttachment(GetAttachmentListUtil.returnAttachment(list.getAttachmentName(), list.getAttachmentId(), sqlType, GetAttachmentListUtil.MODULE_USERJOB));
          }
          if (list.getDeptId() != null) {
              Department mapperDeptById= departmentMapper.getDeptById(list.getDeptId());
              if (mapperDeptById!=null){
                  list.setDeptName(mapperDeptById.getDeptName());
              }else{
                  list.setDeptName("");
              }
          }
     }


     if(list!=null){
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            toJson.setObject(list);
        }else {
           toJson.setFlag(1);
           toJson.setMsg("查询数据为空");
        }

        return toJson;
    }

}
