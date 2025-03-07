<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() +"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title></title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <script type="text/javascript" src="/js/xoajq/xoajq1.js">    </script>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/ipanel.css">
    <link rel="stylesheet" type="text/css" href="../css/spirit/menu.css">
    <style>
        .yiji_title{
            font-size: 11pt;
            position: relative;
        }
        .yiji_title .before{
            position: absolute;
            right:5px;
        }
        .yiji_title .after{
            position: absolute;
            right:5px;
        }
        ul{
            margin-left:0px;
        }
        .app_connect ul li .yiji_title{
            padding-left:15px;
            height: 40px;
            line-height: 40px;
            border-bottom: 1px solid #d0dde9;
            border-top: 1px solid #fbfdff;
        }
        .app_connect ul li .yiji_title:hover{
            background: #abd9fe;
        }
        body{
            background: #eaf4fd;
        }
        .common{
            background: #f9fcff;
        }
        .app_connect .common ul li .yiji_title{
            border: none;
            height: 30px;
            line-height: 30px;
        }
        .appname{
            color: #1c3347;
            height: 42px;
            line-height: 42px;
        }
        .head_pic, .dianji{
            margin: 11px 8px;
        }
        .common .appname{
            font-size: 14px;
            height: 30px;
            line-height: 30px;
        }
        .common .head_pic{
            margin: 5px;
        }
        .common .yiji_title .before{
            background: url(../../img/main_img/cc-sq.png) no-repeat center;
        }
        .common .yiji_title .after{
            background:url(../../img/main_img/cc-dk.png) no-repeat center;
        }
        .app_connect{
            overflow-y: auto;
            overflow-x: hidden;
        }
        /*修改滚动轴样式*/
        ::-webkit-scrollbar {
            width: 10px;
        }
        ::-webkit-scrollbar-track {
            background-color: #fff;
        } /* 滚动条的滑轨背景颜色 */

        ::-webkit-scrollbar-thumb {
            background-color: #c0c0c0;
            border-radius:50px;
        } /* 滑块颜色 */

        ::-webkit-scrollbar-button {
            width:0px;
            height:0px;
        } /* 滑轨两头的监听按钮颜色 */

        ::-webkit-scrollbar-corner {
            background-color: #fff;
        } /* 横向滚动条和纵向滚动条相交处尖角的颜色 */
        .footer{
            float: left;
            width: 100%;
            height:30px;
        }
        .bak{
            width: 100%;
            height: 100%;
            position: absolute;
            z-index: 1000;
            background: #d0efc0;
            /*opacity: 0.5;*/
            /*filter:alpha(opacity=50);*/
        }
        html, body, .wrap{
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .wrap{
            height:calc(100% - 30px);
        }
        .wz{
            border-top: 1px solid #b6d1a8;
            color: #111111;
            width: calc(100% - 30px);
            position: absolute;
            z-index: 1001;
            height: 100%;
            padding: 0 15px;
            line-height: 30px;
        }
        .wzspan{
            color: #666666;
            float: right;
        }
        .people{
            font-weight: 600;
            color: #f03908;
        }
    </style>
    <script type="text/javascript" src="../js/spirit/qwebchannel.js"></script>
</head>
<body>
<div class="wrap" id="wrap">
    <div class="app_connect yiji">
        <ul>
            <li></li>
        </ul>
    </div>
</div>
<div class="footer">
    <div class="bak">

    </div>
    <div class="wz" id="wz">
        <img src="/img/main_img/spirit/spirit/smallgreen.png" alt="" style="margin-top: -1px;">
        <span style="margin-left: 2px">在线</span>
        <span class="people">1</span>
        <span>人</span>
        <span class="wzspan"></span>
    </div>
</div>
</body>

<script language="JavaScript">
    function autodivheight(){
        var winHeight = 0;
        var winWidth = 0;
        if (window.innerHeight)
            winHeight = window.innerHeight;
        else if ((document.body) && (document.body.clientHeight))
            winHeight = document.body.clientHeight;
        if (document.documentElement && document.documentElement.clientHeight)
            winHeight = document.documentElement.clientHeight;
        winWidth = document.documentElement.clientWidth;
        document.getElementById("wrap").style.height= winHeight - 30 +"px";
        document.getElementById("wz").style.width= winWidth - 30 +"px";
    }
    autodivheight();
    enter();
    /**********************是否注册**********************************/
    $.get('/sys/getSysMessage',{},function(json){
        if(json.flag){
            if(json.object.isSoftAuth != '<fmt:message code="sysInfo.th.registered" />'){
                $('.wzspan').html('<fmt:message code="main.th.notRegistered" />');
            }else{
                $('.wzspan').html(' ');
            }
        }
    },'json')
    setInterval(function(){
        enter();
    },120000)
    var type = {
        "email":"email_url",
        "notify_show":"notice_url",
        "news_show":"news_url",
        "file_folder_index2.php":"personfile_ur",
        "system_file_folder":"publicfileset_url",
        "diary_show":"joblog_url",
        "news_manage":"newsmanage_url",
        "notify_manage":"noticemanage_url",
        "knowledge_management":"publicfile_url",
        "system_workflow_flow_guide":"designflow_url",
        "system_workflow_flow_form":"designform_url",
        "system_workflow_flow_sort":"typeset_url",
        "system_unit":"unitmanage_url",
        "system_dept":"departmanage_url",
        "system_org_manage":"orgmanage_url",
        "workflow_new":"newworkflow_url",
        "workflow_list":"mywork_url",
        "workflow_query":"query_url",
        "system_user":"usermanage_url",
        "system_status_text":"statusbarset_url",
        "system_interface":"desktopset_url",
        "system_reg_view":"sysinfo_url",
        "system_menu":"menuset_url",
        "system_log":"syslogmanage_url",
        "system_code":"syscodeset_url",
        "info_unit":"unitinfoquery_url",
        "info_dept":"departinfoquery_url",
        "info_user":"userinfoquery_url",
        "calendar":"schedule_url",
        "system_user_priv":"powermanage_url",
        "system_netdisk":"netdiskset_url",
        "document_mine":"mydispatch_url",
        "person_info":"controlpanel_url",
        "system_workflow_self-motion":"autonumset_url",
        "system_workflow_business":"userinterface_url",
        "netdisk":"netdisk_url",
        "calendar_info":"schedulequery_url",
        "deleteDatePage":"cleardata_url",
        "attendance_personal":"sign_url",
        "hr_manage_staff_info" :"personfile_url",
        "hr_manage_staff_contract":"contractmanage_url",
        "document_send_draft":"dispatch_url",
        "document_send_backlog":"waitedispatch_url",
        "document_send_have":"alreadydispatch_url",
        "document_send_mine":"mydispatch_url",
        "meeting_apply":"meetingapply_url",
        "meeting_query":"meetingquery_url",
        "meeting_mymeeting":"mymeeting_url",
        "meeting_summary":"meetingsummary_url",
        "meeting_management":"meetingmanage_url",
        "meeting_equipmentcontrol":"meetingdevice_url",
        "meeting_meetingroom":"meetingroom_url",
        "meeting_admin_settings":"admin_url",
        "supervise_task":"supervisetask_url",
        "supervise_management":"supervisemanage_url",
        "supervise_classify":"supervisetype_url",
        "supervise_statistics":"supervisecount_url",
        "document_recv_register":"indispatch_url",
        "document_recv_backlog":"waiteindispatch_url",
        "document_recv_have":"pastindispatch_url",
        "document_recv_mine":"myindispatch_url",
        "document_query":"docquery_url",
        "document_statistics":"doccount_url",
        "document_supervise":"docsupervise_url",
        "document_setting":"docset_url",
        "sms_index":"affairnotice_url",
        "document_template_setting":'templateset_url',
        "attendance_manage_confirm":"workapproval_url",
        "attendance_manage_query":"workcount_url",
        "system_secure_rule":"safetymanage_url",
    };

    $.ajax({
        url:'/showMenu?Pcflag=pc',
        type:'get',
        dataType:'json',
        success:function(obj){
            if(obj.msg=='ok'){
                var obj=obj.obj;
                var li='';
                if(obj!=''){
                    for(var i=0;i<obj.length;i++){
                        var fchild=obj[i].child;
                        li+='<li ><div class="yiji_title"><span  class="head_pic"><img onerror="imgerror(this,1)" src="/img/main_img/spirit/spirit/'+obj[i].img+'.png" alt="img" /></span><span  id="'+obj[i].id+'" class="appname">'+obj[i].name+'</span><span class="dianji before"></span></div>';
                        if(fchild.length!=0){
                            li+='<div class="erji common"><ul>';
                            for(var j=0;j<fchild.length;j++){
                                var schild=fchild[j].child;
                                if(fchild[j].child!=''){
                                    li+='<li ><div style="padding-left: 36px" class="yiji_title" url="'+fchild[j].url+'" onClick="opennew(this)"><span  class="head_pic"><img src="../img/main_img/smallthree.png" alt="erimg"/></span><span  id="'+fchild[j].id+'"  class="appname">'+fchild[j].name+'</span><span class="dianji before"></span></div><div class="sanji common"><ul>';
                                    for(var z=0;z<schild.length;z++){
                                        li+='<li ><div class="yiji_title" style="padding-left: 56px" url="'+schild[z].url+'" onClick="opennew(this)"><span  class="head_pic"><img src="../img/main_img/hei.png" alt=""/></span><span  id="'+schild[z].id+'"  class="appname">'+schild[z].name+'</span></div></li>';
                                    }
                                    li+='</ul></div>';
                                }else{
                                    li+='<li ><div style="padding-left: 36px" class="yiji_title"  url="'+fchild[j].url+'" onClick="opennew(this)"><span  class="head_pic"><img src="../img/main_img/hei.png" alt=""/></span><span  id="'+fchild[j].id+'"  class="appname">'+fchild[j].name+'</span></div></li>';
                                }
                            }
                            li+='</ul></div>';
                        }
                        li+='</li>';
                    }
                    $(".app_connect ul li").append(li);
                }
            }
        }
    });

    function imgerror(e,opt){
        if(opt){
            var url = '';
            switch (opt){
                case 1://头像
                    url='/img/main_img/spirit/spirit/knowledge.png';
                    break;
                case 2://logo
                    url='';
                    break;
                default:

            }
        }
        $(e).attr('src',url);
    }

    function enter(){
        /**********************在线人数**********************************/
        $.get('/user/getOnlineCount',{},function (json) {
            if(json.flag){
                if(json.object != ''&&json.object != undefined){
                    $('.people').html(json.object);
                }else{
                    $('.people').html(1);
                }
            }
        },'json')
        /**********************事物提醒**********************************/
        /* $.get('/user/getOnlineCount',{},function (json) {
             if(json.flag){
                 var data = json.object;
                 var e = JSON.stringify(data);
                 doQtPer(e)
             }
         },'json')*/
    }
    function opennew(e){
        var url=$(e).attr('url').trim();
        var aurl;
        var id=$(event.currentTarget).find('span.appname').attr('id');
        var name=$(event.currentTarget).find('span.appname').text();
        if(url != ''&&url != '/'&&url != '//'&&url.indexOf('@') == -1){
            if(url.indexOf('http://')!= -1){
                aurl = url;
                parent.fuacQt(aurl,'',name);
            }else{
                aurl = "/"+url;
                parent.fuacQt(aurl,type[url],name);
            }
        }
    }
</script>
<script language="JavaScript">
    $(function(){
        /***应用二三级菜单展示隐藏***/
        $(".app_connect ul").on('click','li .yiji_title',function(){
            if($(this).siblings('div.common').css('display')=='none'){
                $(this).children('span:eq(2)').removeClass('before').addClass('after');
                $(this).siblings('div.common').slideDown(100).children('ul li');
            }else{
                $(this).children('span:eq(2)').removeClass('after').addClass('before');
                $(this).siblings('div.common').slideUp(100);
            }
        });

    });

</script>
</html>