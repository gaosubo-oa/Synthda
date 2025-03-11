package com.xoa.dao.knowledge;

import com.xoa.model.knowledge.KnowledgeRoleColumn;

import java.util.List;
import java.util.Map;

public interface KnowledgeRoleColumnMapper {
    int deleteByPrimaryKey(Integer roleId);

    int insert(KnowledgeRoleColumn record);

    int insertSelective(KnowledgeRoleColumn record);

    KnowledgeRoleColumn selectByPrimaryKey(Integer roleId);

    int updateByPrimaryKeySelective(KnowledgeRoleColumn record);

    int updateByPrimaryKey(KnowledgeRoleColumn record);

    //根据条件查询知识库-客户信息数据
    List<KnowledgeRoleColumn> selectAllByParam(Map map);
}