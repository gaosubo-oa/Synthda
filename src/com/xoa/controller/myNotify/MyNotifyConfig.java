package com.xoa.controller.myNotify;


import com.xoa.model.myNotify.MyNotify;
import com.xoa.util.ToJson;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 *自定义公告模块 全局配置文件
 */
@Controller
@Scope(value = "prototype")
@RequestMapping("/myNotifyConfig")
public class MyNotifyConfig {

    @ResponseBody
    @RequestMapping(value = "/getNotifyType")
    public ToJson getNotifyType(String noticeType){



        ToJson<MyNotify> json = new ToJson<MyNotify>(1, "error");
        try {
            String mynotice_name=null;//模块名
            String mynotice_table=null;//模块表名
            String mynotice_sms_type=null; //消息类型
            String mynotice_type=null;//公告类型
            String mynotice_log_type=null;//日志类型

            /**
             * 界面标题
             */
            String mynotice_menu1_name=null;//公告通知
            String mynotice_menu2_name=null;//公告通知管理
            String mynotice_menu3_name=null;//公告通知审批
            String mynotice_menu4_name=null;//公告通知设置
            String mynotice_type_name=null;//公告通知类型

            /**
             * 设置数据的保存sys_para表
             */
            String  mynotice_type_approval=null;//需要审核的类型
            String mynotice_top_dates=null;//公告置顶时间(天数)
            String mynotice_approval_users=null;//指定可审批公告人员
            String mynotice_notapproval_users=null;//不经审批发公告人员

            Map map=new HashMap();
            if(noticeType.equals("1")) {
                mynotice_name = "领导讲话";    //模块名
                mynotice_table = "jt_ldjh";  //模块表名
                mynotice_sms_type = "93";  //消息类型
                mynotice_type = "jt_ldjh";  //公告类型
                mynotice_log_type="36";  //日志类型
                //界面标题
                mynotice_menu1_name = "领导讲话";
                mynotice_menu2_name = "领导讲话管理";
                mynotice_menu3_name = "领导讲话审批";
                mynotice_menu4_name = "领导讲话设置";
                mynotice_type_name = "领导讲话类型";

                //设置数据的保存sys_para表
                mynotice_type_approval = "mynotice_type_approval1";//公告类型
                mynotice_top_dates = "mynotice_top_dates1";//公告置顶时间(天数)
                mynotice_approval_users = "mynotice_approval_users1";//指定可审批公告人员
                mynotice_notapproval_users = "mynotice_notapproval_users1";//不经审批发公告人员

            }

            if(noticeType.equals("2")) {
                mynotice_name="企业文化";    //模块名
                mynotice_table="qywh";  //模块表名
                mynotice_sms_type="84";  //消息类型
                mynotice_log_type="27";  //日志类型
                mynotice_type ="qywh";  //公告类型

               //界面标题
                mynotice_menu1_name="企业文化";
                mynotice_menu2_name="企业文化管理";
                mynotice_menu3_name="企业文化审批";
                mynotice_menu4_name="企业文化设置";
                mynotice_type_name="企业文化类型";

                //设置数据的保存sys_para表
                mynotice_type_approval = "mynotice_type_approval2";//公告审核类型
                mynotice_top_dates = "mynotice_top_dates2"; //公告置顶时间(天数)
                mynotice_approval_users = "mynotice_approval_users2";//指定可审批公告人员
                mynotice_notapproval_users = "mynotice_notapproval_users2";//不经审批发公告人员
            }

            if(noticeType.equals("3")) {
                mynotice_name="工作动态";    //模块名
                mynotice_table="gzdt";  //模块表名
                mynotice_sms_type="";  //消息类型
                mynotice_log_type="";  //日志类型
                mynotice_type ="gzdt";  //公告类型

                //界面标题
                mynotice_menu1_name="工作动态";
                mynotice_menu2_name="工作动态管理";
                mynotice_menu3_name="工作动态审批";
                mynotice_menu4_name="工作动态设置";
                mynotice_type_name="工作动态类型";

                //设置数据的保存sys_para表
                mynotice_type_approval = "mynotice_type_approval3";//公告审核类型
                mynotice_top_dates = "mynotice_top_dates3"; //公告置顶时间(天数)
                mynotice_approval_users = "mynotice_approval_users3";//指定可审批公告人员
                mynotice_notapproval_users = "mynotice_notapproval_users3";//不经审批发公告人员
            }

            if(noticeType.equals("4")) {
                mynotice_name="业绩考核";    //模块名
                mynotice_table="yjkh";  //模块表名
                mynotice_sms_type="";  //消息类型
                mynotice_log_type="";  //日志类型
                mynotice_type ="yjkh";  //公告类型

                //界面标题
                mynotice_menu1_name="业绩考核";
                mynotice_menu2_name="业绩考核管理";
                mynotice_menu3_name="业绩考核审批";
                mynotice_menu4_name="业绩考核设置";
                mynotice_type_name="业绩考核类型";

                //设置数据的保存sys_para表
                mynotice_type_approval = "mynotice_type_approval4";//公告审核类型
                mynotice_top_dates = "mynotice_top_dates4"; //公告置顶时间(天数)
                mynotice_approval_users = "mynotice_approval_users4";//指定可审批公告人员
                mynotice_notapproval_users = "mynotice_notapproval_users4";//不经审批发公告人员
            }

            map.put("mynotice_name",mynotice_name);
            map.put("mynotice_type_log",mynotice_log_type);
            map.put("mynotice_table",mynotice_table);
            map.put("mynotice_type_sms",mynotice_sms_type);
            map.put("mynotice_type",mynotice_type);
            //界面标题
            map.put("mynotice_menu1_name", mynotice_menu1_name);
            map.put("mynotice_menu2_name",mynotice_menu2_name);
            map.put("mynotice_menu3_name",mynotice_menu3_name);
            map.put("mynotice_menu4_name",mynotice_menu4_name);
            map.put("mynotice_type_name",mynotice_type_name);
            //设置数据的保存sys_para表
            map.put("mynotice_type_approval",mynotice_type_approval);
           // map.put("mynotice_type_name1",mynotice_type_approval);
            map.put("mynotice_top_dates",mynotice_top_dates);
            map.put("mynotice_approval_users",mynotice_approval_users);
            map.put("mynotice_notapproval_users",mynotice_notapproval_users);


            json.setData(map);
            json.setMsg("ok");
            json.setFlag(0);
        } catch (Exception e) {
            json.setMsg(e.getMessage());

        }
        return json;

    }
}
