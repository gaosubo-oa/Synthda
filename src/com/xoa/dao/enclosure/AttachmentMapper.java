package com.xoa.dao.enclosure;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.users.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AttachmentMapper {
    int deleteByPrimaryKey(Integer aid);

    void insert(Attachment record);

    int insertSelective(Attachment record);

    Attachment selectByPrimaryKey(Integer aid);

    void updateByPrimaryKeySelective(Attachment record);

    void updateByPrimaryKey(Attachment record);
    

    Attachment findByAttachId(int attachId);
    

    Attachment findByAttachId(Integer aId);

    Attachment findByAttachId1(int attachId);


    Attachment findByLast();

    Integer viewDetailsByUser(@Param("user") Users user,@Param("runId") Integer runId);

    Integer viewDetailsByRunId(@Param("runId") Integer runId,
                               @Param("userId") String userId);

    int delete(Attachment record);

    int update(@Param("id") String id,@Param("attachid") String attachId);

    List<Attachment> selectAttachment();

    List<Attachment> selectByAttachment(@Param("attachids") String[] attachids);

    Attachment selectOneBySearch(Map<String,Object> map);

    List<Attachment> selectByAids(@Param("aids") String[] aids);
}