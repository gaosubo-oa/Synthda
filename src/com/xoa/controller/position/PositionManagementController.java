package com.xoa.controller.position;

import com.xoa.model.position.UserJob;
import com.xoa.service.position.PositionManagementService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/position")
public class PositionManagementController {
    @Autowired
    PositionManagementService positionManagementService;


    @RequestMapping("/selectUserJob")
    public ToJson<UserJob> selectUserJob(HttpServletRequest request, UserJob userJob){
        ToJson<UserJob> toJson=positionManagementService.selectUserJobList(request,userJob);
        return toJson;
    }
    //岗位信息修改
    @RequestMapping("/updateUserJob")
    public ToJson<UserJob> updateUserJob(UserJob userJob){

        ToJson<UserJob> toJson=positionManagementService.updateUserJob(userJob);

        return toJson;

    }
    //通过jobId岗位信息删除
     @RequestMapping("/deleteUserJob")
     public ToJson<UserJob> deleteUserJob(Integer jobId){
      ToJson<UserJob> toJson=positionManagementService.deleteUserJob(jobId);
        return toJson;
    }

    //插入岗位信息
    @RequestMapping("/addUserJob")
    public ToJson<UserJob> addUserJob(UserJob userJob){

         ToJson<UserJob> toJson=positionManagementService.addUserJob(userJob);

         return  toJson;
    }


    //通过jobId获取数据
    @RequestMapping("/getUserjobId")
    public ToJson<UserJob> getUserjobId (HttpServletRequest request, Integer jobId) {

        ToJson<UserJob> toJson=positionManagementService.getUserjobId(request,jobId);


         return  toJson;
    }
}

