package com.xoa.dao.position;

import com.xoa.model.position.UserJob;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PositionManagementMapper {

    //通过jobId查询数据
     UserJob   getUserjobId(Integer jobId);
    //岗位查询信息接口
    List<UserJob>  selectUserJobList(UserJob userJob);
    //岗位信息修改
    int updateUserJob(UserJob userJob);
    //通过JOB_ID删除岗位信息
    int deleteUserJob(Integer jobId);
    //插入数据
    int addUserJob(UserJob userJob);

    //分页计数
    int getcount();


    String getJobNameByIds(@Param("jobIds")String[] jobIds);

}
