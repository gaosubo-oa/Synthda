<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><fmt:message code="meet.th.ConferenceApplication" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/fullcalendar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <style>
        .header {
            font-weight: bold;
            margin: 10px;
            font-size: 20px;
        }

        .main {
            width: 50%;
            margin: 0 auto;
            background-color: #fff;
        }

        .main .box {
            width: 100%;
            padding: 20px 30px;
        }
        .main .box p{
            width: 92%;
        }
        .main .box p span {
            color: rgb(42, 88, 140);
            font-weight: bold;
        }
        .header img{
            width: 20px;
            height: 20px;
            vertical-align: middle;
        }

    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background-color:#eee;">
<div class="header">
    <img src="/img/commonTheme/theme1/icon_myMeeting.png" alt=""> 会议通知详情
</div>
<div class="main">
    <div class="box">

    </div>
</div>
</body>

</html>
<script>

    //拉起视频会议客户端
    function GetDataSet(obj){
        $.post('/meeting/readMeeting',{meetingId:obj.sId,attendFlag:1},function (res) {
            if(res.flag){
                //layer.msg('打卡成功');
            }
        });

        var url = "http://127.0.0.1:2900";
        var content = '<?xml version="1.0" encoding="UTF-8" ?>' +
            '<lemeeting>' +
            '<req_type>10001</req_type>' +
            '<login_param>' +
            '-j="'+obj.j+'" -roid='+obj.roid+' -rid='+obj.rid+' -rp="'+obj.rp+'" -aoid='+obj.aoid+' -a="'+obj.a+'" -n="'+obj.n+'" -rmd=1  -ccvt=1 -mpc=100 -mvsc=100 -mipcdc=100 -srf=1 -msfs=4000' +
            '</login_param>' +
            '</lemeeting>';
        var request = null;
        if (window.XMLHttpRequest) {
            request = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            request = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if(request){
            // 防止缓存&& DECODE
            request.open("POST", url, false);//true异步false同步
            //定义传输的文件HTTP头信息
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.send(content);
        }

    }

    $(function () {
        var nid = $.getQueryString('meetingId');
        var bodyId= $.getQueryString('bodyId');
        if(bodyId !=undefined){
            $.ajax({
                type: "post",
                url: "/meeting/queryMeetingById",
                dataType: 'json',
                data: {sid:nid,bodyId:bodyId},
                success: function (res) {
                    var data = res.object;
                    var p='<p style="    overflow-wrap: anywhere;"><span>名称：</span>'+data.meetName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>主题：</span>'+data.subject+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>申请人：</span>'+data.userName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议要员：</span>'+data.recorderName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>申请时间：</span>从 '+data.startTime+' 至 '+data.endTime+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议室：</span>'+data.meetRoomName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>审批管理员：</span>'+data.managerName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>出席人员（外部）：</span>'+data.attendeeOut+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>出席人员（内部）：</span>'+data.attendeeName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>前台会议服务人员：</span>'+(data.serviceUserName || '')+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议室设备：</span>'+data.equipmentNames+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>附件：</span>'+data.attachmentName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议描述：</span>'+data.meetDesc+'</p>'+
                        function (){
                            if (data.videoContent!=undefined && data.videoConfFlag==="1"){
                                return '<p>' +
                                    '<span>是否参加会议：</span>' +
                                    '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data.videoContent).replace(/"/g, '&quot;')+')">点击参加视频会议</a>'+
                                    '</p>';
                            }
                            return ''
                        }()+
                        function (){
                            if (data.reason!=undefined){
                                return '<p>' +
                                    '<span>未批准意见：</span>' +
                                    data.reason +
                                    '</p>';
                            }
                            return ''
                        }();
                    $('.box').html(p);
                }
            })
        }else {
            $.ajax({
                type: "post",
                url: "/meeting/queryMeetingById",
                dataType: 'json',
                data: {sid:nid},
                success: function (res) {
                    var data = res.object;
                    var p='<p style="    overflow-wrap: anywhere;"><span>名称：</span>'+data.meetName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>主题：</span>'+data.subject+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>申请人：</span>'+data.userName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议要员：</span>'+data.recorderName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>申请时间：</span>从 '+data.startTime+' 至 '+data.endTime+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议室：</span>'+data.meetRoomName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>审批管理员：</span>'+data.managerName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>出席人员（外部）：</span>'+data.attendeeOut+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>出席人员（内部）：</span>'+data.attendeeName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>前台会议服务人员：</span>'+(data.serviceUserName || '')+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议室设备：</span>'+data.equipmentNames+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>附件：</span>'+data.attachmentName+'</p>'+
                        '<p style="    overflow-wrap: anywhere;"><span>会议描述：</span>'+data.meetDesc+'</p>'+
                        function (){
                            if (data.videoContent!=undefined && data.videoConfFlag==="1"){
                                return '<p>' +
                                    '<span>是否参加会议：</span>' +
                                    '<a href="javascript:;" onclick="GetDataSet('+JSON.stringify(data.videoContent).replace(/"/g, '&quot;')+')">点击参加视频会议</a>'+
                                    '</p>';
                            }
                            return ''
                        }()+
                        function (){
                            if (data.reason!=undefined){
                                return '<p>' +
                                    '<span>未批准意见：</span>' +
                                    data.reason +
                                    '</p>';
                            }
                            return ''
                        }();
                    $('.box').html(p);
                }
            })
        }
    })
</script>