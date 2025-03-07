package com.xoa.controller.notes;

import com.xoa.model.notes.Notes;
import com.xoa.model.users.Users;
import com.xoa.service.notes.NotesService;
import com.xoa.util.CookiesUtil;
import com.xoa.util.ToJson;
import com.xoa.util.common.session.SessionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by gsb on 2017/10/9.
 */
@Controller
@RequestMapping("/Notes")
public class NotesController {

    @Resource
    private NotesService notesService;

    @RequestMapping("/index")
    public String address() {
        return "app/notes/index";
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-9 下午2:30:17
     * 方法介绍：添加便签
     * 参数说明：
     */
    @RequestMapping("/insertNotes")
    @ResponseBody
    public ToJson<Notes> insertNotes(Notes notes, HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        return notesService.insertNotes(notes,user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:10:17
     * 方法介绍：查询所有便签
     * 参数说明：
     */
    @RequestMapping("/selectNotes")
    @ResponseBody
    public ToJson<Notes> selectNotes(HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        return notesService.selectNotes(user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-10 下午5:10:17
     * 方法介绍：查询便签 并分页
     * 参数说明：
     */
    @RequestMapping("/selectNotesPagination")
    @ResponseBody
    public ToJson<Notes> selectNotesPagination(HttpServletRequest request, Map<String, Object> maps,
                                               @RequestParam(value="page",required = false) Integer page,
                                               @RequestParam(value = "pageSize", required = false)Integer pageSize,
                                               @RequestParam(value = "useFlag", required = false)boolean useFlag){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        return notesService.selectNotesPagination(user,maps, page, pageSize, useFlag);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-11 下午1:10:17
     * 方法介绍：根据所属用户UID查询新增的便签
     * 参数说明：
     */
    @RequestMapping("/selectNewNote")
    @ResponseBody
    public ToJson<Notes> selectNewNote(HttpServletRequest request){
        Cookie redisSessionId = CookiesUtil.getCookieByName(request,"redisSessionId");
        Users user = SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionId);
        return notesService.selectNewNote(user);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午3:40:17
     * 方法介绍：根据主键查询便签
     * 参数说明：noteId：主键
     */
    @RequestMapping("/selectNotesByPrimaryKey")
    @ResponseBody
    public ToJson<Notes> selectNotesByPrimaryKey(Integer noteId){
        return notesService.selectNotesByPrimaryKey(noteId);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:00:17
     * 方法介绍：根据主键删除便签
     * 参数说明：noteId：主键
     */
    @RequestMapping("/deleteByPrimaryKey")
    @ResponseBody
    public ToJson<Notes> deleteByPrimaryKey(Integer noteId){
        return notesService.deleteByPrimaryKey(noteId);
    }
    /**
     * 创建人：季佳伟
     * 创建时间：2017-10-09 下午4:30:17
     * 方法介绍：根据主键修改便签
     * 参数说明：noteId：主键
     */
    @RequestMapping("/updateByPrimaryKey")
    @ResponseBody
    public ToJson<Notes> updateByPrimaryKey(Notes notes){
        return notesService.updateByPrimaryKey(notes);
    }

}
