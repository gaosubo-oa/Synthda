package com.xoa.dao.email;

import com.xoa.model.email.EmailTagModel;

public interface EmailTagMapper {
    int deleteByPrimaryKey(Integer tagId);

    int insert(EmailTagModel record);

    int insertSelective(EmailTagModel record);

    EmailTagModel selectByPrimaryKey(Integer tagId);

    int updateByPrimaryKeySelective(EmailTagModel record);

    int updateByPrimaryKey(EmailTagModel record);
}