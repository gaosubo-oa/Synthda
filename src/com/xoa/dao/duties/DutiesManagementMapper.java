package com.xoa.dao.duties;

import com.xoa.model.duties.UserPost;

import java.util.List;

public interface DutiesManagementMapper {

    //通过postId查询信息
  UserPost getUserPostId(Integer postId);

  UserPost getUserPostByPostName(String postName);
    //查询所有UserPost表数据
    List<UserPost>  selectUserPostList(UserPost userPost);

    //修改UserPost表数据
      int  updateUserPost(UserPost userPost);

    //删除表数据通过
      int deleteUserPost(Integer postId);

      //添加表数据
     int  addUserPost(UserPost userPost);






}
