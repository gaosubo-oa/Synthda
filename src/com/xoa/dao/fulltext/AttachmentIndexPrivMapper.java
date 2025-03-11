package com.xoa.dao.fulltext;

import com.xoa.model.fulltext.AttachmentIndexPriv;

import java.util.List;

public interface AttachmentIndexPrivMapper {
    List<AttachmentIndexPriv>  selectAll();
    AttachmentIndexPriv selectByModuleId(Integer moduleId);
    Integer insert(AttachmentIndexPriv record);
    Integer update(AttachmentIndexPriv record);
    List<AttachmentIndexPriv> selectManagerName(String userId);
}
