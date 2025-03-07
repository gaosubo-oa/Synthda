package com.xoa.service.notes.impl;

import com.xoa.dao.notes.NotesMapper;
import com.xoa.model.notes.Notes;
import com.xoa.model.users.Users;
import com.xoa.service.notes.NotesService;
import com.xoa.util.ToJson;
import com.xoa.util.page.PageParams;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by gsb on 2017/10/9.
 */
@Service
public class NotesServiceImpl implements NotesService{

    @Resource
    private NotesMapper notesMapper;
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-9 下午2:30:17
     * 方法介绍：添加便签
     * 参数说明：
     */
    @Override
    public ToJson<Notes> insertNotes(Notes notes, Users user){
        ToJson<Notes> json = new ToJson<Notes>();
        try {
            int uId = user.getUid();
            notes.setUid(uId);
            String currentTime = String.valueOf(new Date().getTime()/1000);
            int time =Integer.valueOf(currentTime);
            //Integer createTime = IntCreateTime;
            notes.setCreateTime(time);
            notes.setEditTime(time);
            notes.setShowFlag("1");
            notesMapper.insertNotes(notes);
            json.setFlag(0);
            json.setMsg("ok");
          }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:10:17
     * 方法介绍：根据所属用户UID查询便签
     * 参数说明：
     */
    public ToJson<Notes> selectNotes(Users user){
        ToJson<Notes> json = new ToJson<Notes>();
        try{
            int uid = user.getUid();
            List<Notes> notesList = notesMapper.selectNotes(uid);
           json.setObj(notesList);
           json.setFlag(0);
           json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-10 下午5:10:17
     * 方法介绍：查询便签 并分页
     * 参数说明：
     */
    public ToJson<Notes> selectNotesPagination(Users user, Map<String, Object> maps, Integer page, Integer pageSize, boolean useFlag){
        ToJson<Notes> json = new ToJson<Notes>();
        PageParams pageParams = new PageParams();
        pageParams.setPage(page);
        pageParams.setPageSize(pageSize);
        pageParams.setUseFlag(useFlag);
        maps.put("page", pageParams);
        int uid = user.getUid();
        Notes notes = new Notes();
        notes.setUid(uid);
        maps.put("notes",notes);
        try{

            List<Notes> notesList = notesMapper.selectNotesPagination(maps);
            json.setTotleNum(pageParams.getTotal());
            json.setObj(notesList);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-11 下午1:10:17
     * 方法介绍：根据所属用户UID查询新增的便签
     * 参数说明：
     */
    public ToJson<Notes> selectNewNote(Users user){
        ToJson<Notes> json = new ToJson<Notes>();
        try{
            int uid = user.getUid();
            Notes notes = notesMapper.selectNewNote(uid);
            json.setObject(notes);
            json.setFlag(0);
            json.setMsg("ok");

        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:40:17
     * 方法介绍：根据主键查询便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> selectNotesByPrimaryKey(Integer noteId){
        ToJson<Notes> json = new ToJson<Notes>();
        try {
            Notes notes = notesMapper.selectNotesByPrimaryKey(noteId);
            json.setObject(notes);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:00:17
     * 方法介绍：根据主键删除便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> deleteByPrimaryKey(Integer noteId){
        ToJson<Notes> json = new ToJson<Notes>();
        try {
            notesMapper.deleteByPrimaryKey(noteId);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:30:17
     * 方法介绍：根据主键修改便签
     * 参数说明：noteId：主键
     */
    public ToJson<Notes> updateByPrimaryKey(Notes notes){
        ToJson<Notes> json = new ToJson<Notes>();
        try{
            String currentTime = String.valueOf(new Date().getTime()/1000);
            int time =Integer.valueOf(currentTime);
            notes.setEditTime(time);
            notesMapper.updateByPrimaryKey(notes);
            json.setFlag(0);
            json.setMsg("ok");
        }catch (Exception e){
            e.printStackTrace();
            json.setFlag(1);
            json.setMsg("err");
        }
        return json;
    }

}
