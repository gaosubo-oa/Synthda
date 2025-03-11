package com.xoa.dao.fulltext;

import com.xoa.model.enclosure.Attachment;
import com.xoa.model.fulltext.AttachmentIndex;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface AttachmentIndexMapper {
    /**
     * 创建人：马东辉
     * 创建时间：2022/4/1
     * 方法介绍：查询全部索引
     * 参数说明：
     */
    List<AttachmentIndex> selectAll();
    /**
     * 创建人：马东辉
     * 创建时间：2022/4/1
     * 方法介绍：查询索引条数
     * 参数说明：
     */
    Map<String,Object>  selectIndexCount();
    /**
     * 创建人：马东辉
     * 创建时间：2022/4/1
     * 方法介绍：查询全部附件条数
     * 参数说明：
     */
    Map<String,Object>  selectAttCount();

    /**
     * 创建人：马东辉
     * 创建时间：2022/4/1
     * 方法介绍：查询全部附件条数
     * 参数说明：
     */
    List<Attachment> selectByStr(Map<String, Object> map);

    List<Integer> selectPriv(Map<String, Object> map);

    List<Integer> selectManager(Map<String, Object> map);

    List<Attachment>  selectAttach(Map<String, Object> map);


    void insert(AttachmentIndex attachmentIndex);

   Integer resetting();

}
