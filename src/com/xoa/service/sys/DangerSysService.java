package com.xoa.service.sys;

import com.xoa.dao.menu.SysMenuMapper;
import com.xoa.dao.sms.SmsBodyMapper;
import com.xoa.dao.sys.DangerSysMapper;
import com.xoa.model.users.Users;
import com.xoa.util.CookiesUtil;
import com.xoa.util.common.session.SessionUtils;
import com.xoa.util.common.wrapper.BaseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 韩东堂 on 2017/7/4.
 */
@Service
public class DangerSysService {

  @Autowired
    DangerSysMapper mapper;
//    邮件、公告、新闻、日程、日志、工作流
  @Resource
  SysMenuMapper sysMenuMapper;// 父类菜单DAO
    @Autowired
    SmsBodyMapper smsBodyMapper;

    public BaseWrapper truncateTable(HttpServletRequest request, String[] menuId){
        BaseWrapper wrapper=new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");
       Users user= SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);
       if(user==null||!user.getUserId().equals("admin")){
           wrapper.setFlag(false);
           wrapper.setStatus(true);
           wrapper.setMsg("您没有权限");
           return wrapper;
       }
        try{
            String smsType = "";
           for(String id:menuId){
               if(id.equals("0116")){
                   //清除公告
                   mapper.truncateTable("notify");
                   smsType = "1";
               }
               if(id.equals("0117")){
                   //清除新闻
                   mapper.truncateTable("news");
                   mapper.truncateTable("news_comment");
                   smsType = "14";
               }
               if(id.equals("0101")){
                   //清除邮件
                   mapper.truncateTable("email");
                   mapper.truncateTable("email_body");
                   mapper.truncateTable("webmail");
                   mapper.truncateTable("webmail_body");
                   smsType = "2";

               }
               if(id.equals("2016")){
                   //清除日程
                   mapper.truncateTable("calendar");
                   smsType = "5";
               }
               if(id.equals("0128")){
                   //工作日志
                   mapper.truncateTable("diary");
                   mapper.truncateTable("diary_comment");
                   mapper.truncateTable("diary_comment_reply");
                   mapper.truncateTable("diary_share");
                   mapper.truncateTable("diary_top");
                   smsType = "13";
               }

               if(id.equals("0136")){
                   //个人文件柜
                  List<Integer> contentIds= mapper.getFileContentBySortType(4);
                   List<Integer> contentIdss=mapper.getFileContentBySortZero();
                   contentIds.addAll(contentIdss);
                   mapper.deleteFileContent(contentIds);
                   mapper.deleteFileBox(4);
                   smsType = "22";
               }
               if(id.equals("3001")){
                  //公共文件柜
                   List<Integer> contentIds=  mapper.getFileContentBySortType(5);
                   mapper.deleteFileContent(contentIds);
                   mapper.deleteFileBox(5);
                   smsType = "16";
               }

               //删除对应模块的事务提醒数据
               smsBodyMapper.deletSmsBodyByBodyIds(smsType);

           }

//            //清除日志
//            mapper.truncateTable("sys_log");
//            //清除工作流
//            mapper.truncateTable("flow_timer");
//            mapper.truncateTable("flow_sort");
//            mapper.truncateTable("flow_trigger");
//            mapper.truncateTable("flow_type");
//            mapper.truncateTable("flow_run_prcs");
//            mapper.truncateTable("flow_run_feedback");
//            mapper.truncateTable("flow_run_attach");
//            mapper.truncateTable("flow_run");
//            mapper.truncateTable("flow_query_tpl");
//            mapper.truncateTable("flow_process");
//            mapper.truncateTable("flow_priv");
//            mapper.truncateTable("flow_print_tpl");
//            mapper.truncateTable("flow_plugin");
//            mapper.truncateTable("flow_form_type");
//            mapper.truncateTable("form_sort");
//            mapper.truncateTable("flow_form_version");

//            Map delayInfo =new HashMap();
//            mapper.deleteUsers();
            wrapper.setFlag(true);
            wrapper.setStatus(true);
            wrapper.setMsg("操作成功");
        }catch (Exception e){
            e.printStackTrace();
            wrapper.setMsg("操作失败");
            wrapper.setFlag(false);
            wrapper.setStatus(true);
        }
        return wrapper;
    }

//    public BaseWrappers getShouldDelMenu(HttpServletRequest request) {
//        BaseWrappers wrapper =new BaseWrappers();
//        wrapper.setStatus(true);
//        Object localeObj = request.getSession().getAttribute("LOCALE_SESSION_ATTRIBUTE_NAME");
//        String locale =null;
//        if (localeObj == null) {
//            locale="zh_CN";
//        }else{
//            locale=localeObj.toString();
//        }
//        List<SysMenu> list = sysMenuMapper.getDatagrid();
//        if(list==null){
//            wrapper.setFlag(true);
//            wrapper.setDatas(null);
//            wrapper.setMsg("没有数据");
//            return wrapper;
//        }
//        for (SysMenu sysMenu : list) {
//            if (locale.equals("zh_CN")) {
//                sysMenu.setName(sysMenu.getName());
//            } else if (locale.equals("en_US")) {
//                sysMenu.setName(sysMenu.getName1());
//            } else if (locale.equals("zh_TW")) {
//                sysMenu.setName(sysMenu.getName2());
//            }
//            List<SysFunction> list1 = null;
//            if (sysMenu.getId() != null) {
//
//                list1 = sysFunctionMapper.getDatagrid(sysMenu
//                        .getId().concat("__"));
//            }
//            for (SysFunction sysFunction : list1) {
//                if (locale.equals("zh_CN")) {
//                    sysFunction.setName(sysFunction.getName());
//                } else if (locale.equals("en_US")) {
//                    sysFunction.setName(sysFunction.getName1());
//                } else if (locale.equals("zh_TW")) {
//                    sysFunction.setName(sysFunction.getName2());
//                }
//                List<SysFunction> list2 = null;
//                if (sysFunction.getId() != null) {
//
//                    list2 = sysFunctionMapper
//                            .childMenu(sysFunction.getId().concat("__"));
//                }
//                for (SysFunction sysFunction2 : list2) {
//                    if (locale.equals("zh_CN")) {
//                        sysFunction2.setName(sysFunction2.getName());
//                    } else if (locale.equals("en_US")) {
//                        sysFunction2.setName(sysFunction2.getName1());
//                    } else if (locale.equals("zh_TW")) {
//                        sysFunction2.setName(sysFunction2.getName2());
//                    }
//
//                }
//
//                //某二级菜单有三级菜单,把有三级菜单的二级菜单fid拼接为字符串，用，前后分隔。
//                if (list2.size() > 0) {
//                    sb.append(",").append(sysFunction.getfId()).append(",");
//                }
//                sysFunction.setChild(list2);
//
//            }
//            sysMenu.setChild(list1);
//        }
//        wrapper.setMsg("请求成功");
//        wrapper.setFlag(true);
//        wrapper.setDatas(list);
//        return wrapper;
//    }




    public BaseWrapper truncateTablePlagiarize(HttpServletRequest request, String[] menuId){
        BaseWrapper wrapper=new BaseWrapper();
        Cookie redisSessionCookie = CookiesUtil.getCookieByName(request, "redisSessionId");

        Users user= SessionUtils.getSessionInfo(request.getSession(),Users.class,new Users(),redisSessionCookie);

        try{
            for(String id:menuId) {
                if (id.equals("0116")) {
                    //清除公告
                    mapper.truncateTable("notify");
                }
                if (id.equals("0117")) {
                    //清除新闻
                    mapper.truncateTable("news");
                    mapper.truncateTable("news_comment");
                }
            }
            wrapper.setFlag(true);
            wrapper.setStatus(true);
            wrapper.setMsg("操作成功");
        }catch (Exception e){
            e.printStackTrace();
            wrapper.setMsg("操作失败");
            wrapper.setFlag(false);
            wrapper.setStatus(true);
        }
        return wrapper;
    }
}
