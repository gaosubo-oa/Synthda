package com.xoa.service.duties;


import com.xoa.dao.common.SysCodeMapper;
import com.xoa.dao.department.DepartmentMapper;
import com.xoa.dao.duties.DutiesManagementMapper;
import com.xoa.model.common.SysCode;
import com.xoa.model.department.Department;
import com.xoa.model.duties.UserPost;
import com.xoa.service.notify.NotifyService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.GetAttachmentListUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.dataSource.ContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Service
public class DutiesManagementService {


    @Autowired
    DutiesManagementMapper dutiesManagementMapper;
    @Autowired
    SysCodeMapper sysCodeMapper;
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    NotifyService notifyService;
    //通过postId查询
    public ToJson<UserPost> getUserPostId(HttpServletRequest request, Integer postId){
        ToJson<UserPost> toJson=new ToJson<UserPost>(1,"error");
        UserPost list=dutiesManagementMapper.getUserPostId(postId);

        //SysCode系统代码表
        if(list!=null){
            SysCode sysCode= sysCodeMapper.getSingleCode("function",String.valueOf(list.getType()));
            if(sysCode!=null){
                list.setTypeName(sysCode.getCodeName());
            }else{
                list.setTypeName("");
            }
            //职务附件
            String sqlType = "xoa"
                    + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
            ContextHolder.setConsumerType(sqlType);
            if (list.getAttachmentName()!=null&&list.getAttachmentId()!=null) {
                list.setAttachment(GetAttachmentListUtil.returnAttachment(list.getAttachmentName(),
                        list.getAttachmentId(),
                        sqlType, GetAttachmentListUtil.MODULE_USERPOST));
            }

            Department department=departmentMapper.getDeptById(list.getDeptId());
            if(department!=null){
                list.setDeptName(department.getDeptName());
            }else{

                list.setDeptName("");
            }
        }

        if(list!=null){
            toJson.setFlag(0);
            toJson.setMsg("查询成功");
            toJson.setObject(list);
        }else{
            toJson.setFlag(1);
            toJson.setMsg("没有数据");
        }

           return  toJson;
    }
    //查询所有数据
   public ToJson<UserPost> selectUserPostList(UserPost userPost, HttpServletRequest request){
         ToJson<UserPost> toJson=new ToJson<UserPost>(1,"error");
       String locale = (String)request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
         List<UserPost>  list=dutiesManagementMapper.selectUserPostList(userPost);

         for(UserPost userPost1:list){
             SysCode sysCode=sysCodeMapper.getSingleCode("function",String.valueOf(userPost1.getType()));
         if(sysCode!=null){
               userPost1.setTypeName(sysCode.getCodeName());
             if (locale.equals("zh_CN")) {
                 userPost1.setTypeName(sysCode.getCodeName());
             } else if (locale.equals("en_US")) {
                 userPost1.setTypeName(sysCode.getCodeName1());
             } else if (locale.equals("zh_TW")) {
                 userPost1.setTypeName(sysCode.getCodeName2());
             }
         }else{

             userPost1.setTypeName("");
         }
           /*  String sqlType = "xoa"
                     + (String) SessionUtils.getSessionInfo(request.getSession(), "loginDateSouse", String.class, CookiesUtil.getCookieByName(request, "redisSessionId"));
             ContextHolder.setConsumerType(sqlType);
             if (userPost1.getAttachmentName()!=null&&userPost1.getAttachmentId()!=null) {
                 userPost1.setAttachment(GetAttachmentListUtil.returnAttachment(userPost1.getAttachmentName(),
                         userPost1.getAttachmentId(),
                         sqlType,GetAttachmentListUtil.FU_JIAN));
             }
*/

         Department department=departmentMapper.getDeptById(userPost1.getDeptId());
         if(department!=null){

             userPost1.setDeptName(department.getDeptName());
         }else{
             userPost1.setTypeName("");
         }

         }



         if(list!=null){


             toJson.setFlag(0);
             toJson.setMsg("查询成功");
             toJson.setObj(list);
         }else{
             toJson.setFlag(1);
             toJson.setMsg("查询数据为空");

         }

        return toJson;
   }

  //修改
   public ToJson<UserPost> updateUserPost(UserPost userPost){
       ToJson<UserPost> toJson=new ToJson<UserPost>(1,"error");
       int a=dutiesManagementMapper.updateUserPost(userPost);
       if(a>0){
           toJson.setFlag(0);
           toJson.setMsg("修改成功");
       }else{
           toJson.setFlag(1);
           toJson.setMsg("修改失败");
       }
       return toJson;
   }


   //通过postId删除
    public ToJson<UserPost> deleteUserPost(Integer postId){
        ToJson<UserPost> toJson=new ToJson<UserPost>(1,"error");
        int a=dutiesManagementMapper.deleteUserPost(postId);
        if(a>0){
            toJson.setFlag(0);
            toJson.setMsg("删除成功");
        }else{
            toJson.setFlag(1);
            toJson.setMsg("删除失败");
        }
        return toJson;
    }
     //添加  保存
    public ToJson<UserPost> addUserPost(UserPost userPost){
        ToJson<UserPost> toJson=new ToJson<UserPost>(1,"error");
        int a=dutiesManagementMapper.addUserPost(userPost);
        if(a>0){
            toJson.setFlag(0);
            toJson.setMsg("添加成功");
        }else{
            toJson.setFlag(1);
            toJson.setMsg("添加失败");
        }
        return toJson;
    }

}
