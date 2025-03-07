package com.xoa.dao.knowledge;

import com.xoa.model.knowledge.KnowledgeCustomerUselog;

import java.util.List;
import java.util.Map;

public interface KnowledgeCustomerUselogMapper {
    int deleteByPrimaryKey(Integer logId);

    int insert(KnowledgeCustomerUselog record);

    int insertSelective(KnowledgeCustomerUselog record);

    KnowledgeCustomerUselog selectByPrimaryKey(Integer logId);

    int updateByPrimaryKeySelective(KnowledgeCustomerUselog record);

    int updateByPrimaryKey(KnowledgeCustomerUselog record);

    List<KnowledgeCustomerUselog> selectByUserId(Map map);
}