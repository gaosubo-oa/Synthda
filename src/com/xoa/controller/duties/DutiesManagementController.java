package com.xoa.controller.duties;

import com.xoa.model.duties.UserPost;
import com.xoa.service.duties.DutiesManagementService;
import com.xoa.util.ToJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/duties")
public class DutiesManagementController {

    @Autowired
    DutiesManagementService dutiesManagementService;
   //通过postId获取数据
    @RequestMapping("/getUserPostId")
    public ToJson<UserPost> getUserPostId(HttpServletRequest request, Integer postId){

        ToJson<UserPost> toJson=dutiesManagementService.getUserPostId(request,postId);

        return  toJson;


    }
    //查询所有数据
    @RequestMapping("/selectUserPostList")
    public ToJson<UserPost> selectUserPostList(UserPost userPost, HttpServletRequest request){

        ToJson<UserPost> toJson=dutiesManagementService.selectUserPostList(userPost,request);

        return  toJson;

    }
    //修改数据
    @RequestMapping("/updateUserPost")
    public ToJson<UserPost> updateUserPost(UserPost userPost){

        ToJson<UserPost> toJson=dutiesManagementService.updateUserPost(userPost);

        return  toJson;

    }

    //删除数据 （postId）
     @RequestMapping("/deleteUserPost")
    public ToJson<UserPost> deleteUserPost(Integer postId){

        ToJson<UserPost> toJson=dutiesManagementService.deleteUserPost(postId);

        return  toJson;

    }

     //添加数据  及保存
    @RequestMapping("/addUserPost")
    public ToJson<UserPost> addUserPost(UserPost userPost){

        ToJson<UserPost> toJson=dutiesManagementService.addUserPost(userPost);

        return  toJson;

    }


}
