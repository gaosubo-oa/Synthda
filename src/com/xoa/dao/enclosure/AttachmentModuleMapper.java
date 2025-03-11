package com.xoa.dao.enclosure;

import com.xoa.model.enclosure.AttachmentModule;

public interface AttachmentModuleMapper {
    int deleteByPrimaryKey(Byte moduleId);

    int insert(AttachmentModule record);

    int insertSelective(AttachmentModule record);

    AttachmentModule selectByPrimaryKey(Integer moduleId);

    int updateByPrimaryKeySelective(AttachmentModule record);

    int updateByPrimaryKey(AttachmentModule record);
}