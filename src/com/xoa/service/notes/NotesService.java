package com.xoa.service.notes;

import com.xoa.model.notes.Notes;
import com.xoa.model.users.Users;
import com.xoa.util.ToJson;

import java.util.Map;

/**
 * Created by gsb on 2017/10/9.
 */
public interface NotesService {
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-9 下午2:30:17
     * 方法介绍：添加便签
     * 参数说明：
     */
    public ToJson<Notes> insertNotes(Notes notes, Users user);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:10:17
     * 方法介绍：根据所属用户UID查询便签
     * 参数说明：
     */
    public ToJson<Notes> selectNotes(Users user);

    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:10:17
     * 方法介绍：根据所属用户UID查询便签
     * 参数说明：
     */
    public ToJson<Notes> selectNotesPagination(Users user, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-11 下午1:10:17
     * 方法介绍：根据所属用户UID查询新增的便签
     * 参数说明：
     */
    public ToJson<Notes> selectNewNote(Users user);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:40:17
     * 方法介绍：根据主键查询便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> selectNotesByPrimaryKey(Integer noteId);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:00:17
     * 方法介绍：根据主键删除便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> deleteByPrimaryKey(Integer noteId);
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:30:17
     * 方法介绍：根据主键修改便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> updateByPrimaryKey(Notes notes);

}
