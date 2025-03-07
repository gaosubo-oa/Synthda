package com.xoa.dao.notes;

import com.xoa.model.notes.Notes;
import com.xoa.model.users.Users;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/10/9.
 */
@Component
public interface NotesMapper {

    int insertNotes(Notes notes);

    List<Notes> selectNotes(Integer uid);

    List<Notes> selectNotesPagination(Map<String, Object> map);

    Notes selectNewNote(Integer uid);

    Notes selectNotesByPrimaryKey(Integer noteId);

    int deleteByPrimaryKey(Integer noteId);

    int updateByPrimaryKey(Notes notes);

    // 根据辅助部门字符串数组查用户
    List<Users> getUsersByAssistedDeptIds(String[] assistedDeptIds);


    // 根据辅助部门字符串数组查用户
    List<Users> getUsersByAssistedPrivIds(String[] assistedDeptIds);


}
