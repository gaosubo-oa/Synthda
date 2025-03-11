<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" type="text/css" href="/css/main/theme7/cont.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/m_reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/diary/calendar1.css"/>
    <link rel="stylesheet" href="/css/main/intranetRed.css?20201106.1">
    <link rel="stylesheet" href="/css/main/theme7/intranetRed.css?20201106.1">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/diary/calendar1.js/"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/main_js/intranetRed.js?20220118.1"></script>
    <title><fmt:message code="main.th.Intranet"/></title><%--内网门户--%>
    <style>
        body{
            overflow: auto;
        }
        .buttommai-main li.clearfix:hover{
            background: #e9f3ff;
        }
        .buttommai-main li{
            height: 46px;
        }
        .lef{
            height: 46px;
        }
        .lef img{
            margin-top: 3px;
        }
        .lef a{
            height: 23px;
            line-height: 23px!important;

        }
        .flowBtn , .reveiveBtn , .sendBtn, .emailBtn, .newBtn, .ReadFileBtn{
            height: 20px;
            border-radius: 4px;
            line-height: 20px;
            margin: 4px;
            padding: 0;
            background: #ffffff;
            cursor: pointer;
            font-size: 8pt;
            color: #dd2e2c;
            border: #dd2e2c 1px solid;
            display: inline-block;
            width: 34px;
            text-align: center;
        }
        .btnSelect{
            background: #dd2e2c;
            color: #fff!important;
        }
        .mores {
            font-size: 10pt;
        }
        .more{
            top: 10px;
            right: 10px;
        }
        .pbg{
            height: 28px;
        }
        .chedule_li div {
            float: left;
            margin-top: 7px;
            text-align: left;
        }
        .chedule_li img {
            margin-top: 4px;
        }
        .buttommai-main{
            position: relative;
            height: auto;
        }
        #news li {
            padding: 0 5px;
            width: auto;
        }
        .richeng_title {
            width: 43%;
            line-height: 28px;
            margin-left: 4px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 11pt;
        }
        .new_title {
            color: #1b5e8d;
        }
        .every_times {
            width: 48%;
            line-height: 27px;
            color: #919191;
            text-align: right!important;
        }
        .buttommai-main li {
            cursor: pointer;
        }
        .e_img img, .d_img img, .n_img img{
            width: 38px;
            margin-left: 4px;
            margin-top: 3px;
        }
        .e_word, .d_word, .n_word{
            margin-left: 4%;
            width: 80%;
        }
        .buttommain{
            height: 310px;
        }
        .every_logo {
            height: 117px;
        }
        #huiyi .lef,#toReadFile .lef{
            width: 90%;
        }
        .topmainLeft,.topmainRight{
            float: left;
            width: 40%;
            height: 100%;
        }
        .topmainCenter{
            float: left;
            width: 20%;
            height: 100%;
        }
        .e_time{
            line-height: 17px;
        }
        .e_name{
            width: 50%;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            line-height: 17px;
        }
        .r-top h4{
            line-height: 25px;
        }
        .every_logo img {
            margin-top: 16%;
            width: 75px;
        }
    </style>
</head>
<body>
<div class="buttommain" style="margin-top: 0;height: 370px;">
    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >新闻</span><%--待办收文--%>
        </div>
        <div class="more" onclick="parent.getMenuOpen(this)" style="display: inline-block"  menu_tid="0117" data-url="news/index">
            <h2 style="display: none">新闻</h2>
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>></a></span><%--更多--%>
        </div>
        <ul class="buttommai-main" id="news">

        </ul>
    </div>



    <div class="buttommaincontent">
        <div class="pbg">
            <span class="titleleft" >待阅事宜</span><%--待办发文--%>
        </div>
        <span class="dai ReadFileBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 119px;">待阅</span>
        <span class="yiban ReadFileBtn" datatype="1" style="position: absolute;top: 5px;right: 70px;">已阅</span>
        <div class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0110" data-url="ToBeReadController/toReadFile">
            <h2 style="display: none">待阅事宜</h2>
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>></a></span><%--更多--%>
        </div>
        <ul class="buttommai-main" id="toReadFile">

        </ul>
    </div>



    <div class="topmainright" style="margin: 0;">
        <div class="r-bot">
            <div class="pbg">
                <span class="titleleft" ><fmt:message code="calendar.th.myCalendar"/></span><%--我的日程--%>
                <div class="fr"  onclick="parent.getMenuOpen(this)" menu_tid="0124" data-url="calendar">
                    <a class="fr" href="javascript:void(0)"
                       style="color: #bc0f14;font-size: 14px;margin-right: 14px;">
                        <fmt:message code="calendar.th.addCalendar"/><%--新增日程--%>
                    </a>
                    <h2 class="hide"><fmt:message code="calendar.th.manageCalendar"/></h2><%--日程管理--%>
                </div>

            </div>
        </div>

        <div class="r-top">
            <h3 style="padding-top: 0"></h3>
            <h4></h4>
        </div>
        <div class="r-bot">

            <div id="ca">

            </div>
            <ul class="topmainright-main" style="overflow: hidden;display: none">

            </ul>

        </div>
    </div>
</div>

<div class="buttommain">
    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >收文</span><%--待办收文--%>
        </div>
        <span class="dai reveiveBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 119px;">待办</span>
        <span class="yiban reveiveBtn" datatype="1" style="position: absolute;top: 5px;right: 70px;">已办</span>
        <div class="more" onclick="parent.getMenuOpen(this)" style="display: inline-block"  menu_tid="650505" data-url="document/recv/backlog">
            <h2 style="display: none">待办收文</h2>
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/></a></span><%--更多--%>
        </div>
        <ul class="buttommai-main" id="witgw">

        </ul>
    </div>



    <div class="buttommaincontent">
        <div class="pbg">
            <span class="titleleft" >发文</span><%--待办发文--%>
        </div>
        <span class="dai sendBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 119px;">待办</span>
        <span class="yiban sendBtn" datatype="1" style="position: absolute;top: 5px;right: 70px;">已办</span>
        <div class="more" onclick="parent.getMenuOpen(this)"  menu_tid="650105" data-url="document/send/backlog">
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/></a></span><%--更多--%>
            <h2 style="display: none">待办发文</h2>
        </div>
        <ul class="buttommai-main" id="dbsend">

        </ul>
    </div>



    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >工作流</span><%--待批会议--%>
        </div>
        <span class="dai flowBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 119px;">待办</span>
        <span class="yiban flowBtn" datatype="1" style="position: absolute;top: 5px;right: 70px;">已办</span>
        <div class="more">
            <div  style="display: inline-block;" onclick="parent.getMenuOpen(this)"  menu_tid="1020" data-url="workflow/list"><a class="mores" style="cursor: pointer"><fmt:message code="email.th.more"/>>></a> <h2 style="display: none">我的工作</h2></div><%--更多--%>
        </div>
        <ul class="buttommai-main" id="huiyi">

        </ul>
    </div>
</div>

<div class="buttommain" style="    margin-bottom: 15px;">
    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >公告</span><%--待办收文--%>
        </div>
        <span class="dai newBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 160px;">全部</span>
        <span class="yiban newBtn" datatype="1" style="position: absolute;top: 5px;right: 70px;width: 80px;" data-bool="00">重点工作通报</span>
        <div class="more" onclick="parent.getMenuOpen(this)" style="display: inline-block"  menu_tid="0116" data-url="notice/allNotifications">
            <h2 style="display: none">公告通知</h2>
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>></a></span><%--更多--%>
        </div>
        <ul class="buttommai-main" id="new">

        </ul>
    </div>



    <div class="buttommaincontent">
        <div class="pbg">
            <span class="titleleft" >邮件</span><%--待办发文--%>
        </div>
        <span class="all emailBtn btnSelect" datatype="0" style="position: absolute;top: 5px;right: 160px;">全部</span>
        <span class="dai emailBtn" datatype="1" style="position: absolute;top: 5px;right: 115px;">未读</span>
        <span class="yiban emailBtn" datatype="2" style="position: absolute;top: 5px;right: 70px;">已读</span>
        <div class="more" onclick="parent.getMenuOpen(this)"  menu_tid="0101" data-url="email/index">
            <span><a class="mores" style="cursor: pointer" ><fmt:message code="email.th.more"/>>></a></span><%--更多--%>
            <h2 style="display: none">电子邮件</h2>
        </div>
        <ul class="buttommai-main emailall" id="email" style="height: 87%;overflow: auto">

        </ul>
        <ul class="buttommai-main no_read" style="display:none;">
        </ul>
        <ul class="buttommai-main read" style="display:none;">
        </ul>
    </div>



    <div class="buttommainleft">
        <div class="pbg">
            <span class="titleleft" >常用应用</span><%--待批会议--%>
        </div>

        <ul class="buttommai-main" id="application">

        </ul>
    </div>
</div>

<script>

    function tiaozhuan(that) {
        if($(that).hasClass('news')){
            $.popWindow($(that).attr('data-url'),'新闻详情','0','100','1200px','700px');

        }else{
            $.popWindow($(that).attr('data-url'),'公告详情','20','150','1200px','500px')
        }

    }
    function administrivia(me) {//新闻
        $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data:{
                page:'1',
                read:$(me).attr('data-bool'),
                pageSize:'6',
                useFlag:'true'
            },
            dataType: 'json',
            success: function (obj) {
                var li = '';
                var data = obj.obj;
                for (var i = 0; i < data.length; i++) {
                    li += '<li class="clearfix chedule_li news" onclick="tiaozhuan(this)" data-url="/news/detail?newsId='+data[i].newsId+'">' +
                        '<div style="margin-left:12px;">' +
                        '<img src="/img/data_point.png">' +
                        '</div>' +
                        '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                        '<div class="every_times">' +function () {

                            if(data[i].newsDateTime!=undefined){
                                return data[i].newsDateTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            }else {
                                return ''
                            }
                        }()  + '</div>' +
                        '</li>'
                }
                $('#news').html(li);
                if(obj.obj.length==0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</div>';
                    $('#news').html(lis);
                }


            }
        });
    }
    function readFile(element){
        var type = element.attr('datatype');
        $.post('/ToBeReadController/ReadFileIsRead?isReadStr='+type,{pageSize: 6},function(json){
            if(json.flag){
                var datas=json.data;
                var jsonstr='';
                for (var i = 0; i < datas.length; i++) {
                    if(datas[i].sortMainType == '公文'){
                        var url = '/workflow/work/workformPreView?flowId='+datas[i].flowId+'&flowStep=&tabId=&tableName=&runId='+datas[i].runId+'&prcsId=&isNomalType=false&hidden=true&parent=circulate';
                    }else{
                        var url = '/workflow/work/workformPreView?flowId='+datas[i].flowId+'&flowStep=&tabId=&tableName=&runId='+datas[i].runId+'&prcsId=&parent=circulate';
                    }
                    var attr = ' flowId="'+ datas[i].flowId +'" flowStep="'+ datas[i].prcsId +'" prcsId="'+ datas[i].flowPrcs +'" runName="'+ datas[i].runName +'" tableid="'+ datas[i].tableId+'"';
                    jsonstr += '<li class="clearfix chedule_li news" style="position: relative;" onclick="isRead($(this))" data-url="'+ url +'" runId="'+ datas[i].runId +'" '+ attr +'>' +
                        '<div style="margin-left:12px;">' +
                        '<img src="/img/data_point.png">' +
                        '</div>' +
                        '<a><div class="new_title richeng_title" title="' + datas[i].runName + '">' + datas[i].runName + '</div></a>' +
                        '<div class="every_times" style="margin-top: 0!important;">' +function () {
                            if(datas[i].createDate!=undefined){
                                return datas[i].createDate.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            }else {
                                return datas[i].beginTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            }
                        }()  + '</div><div style="position: absolute;right: 0px;top: 15px;color: #919191;">'+ datas[i].userName +'</div>' +
                        '</li>'
                }
                $('#toReadFile').html(jsonstr);
                if(datas.length==0) {
                    var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                        '</li>';
                    $('#toReadFile').html(lis);
                }
            }else {
                var lis = '<li class="no_notice" style="text-align: center;border: none;">' +
                    '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                    '<h2 style="text-align: center;color: #666;font-size: 14px">'+no_Data+'</h2>' +/*暂无数据*/
                    '</li>';
                $('#toReadFile').html(lis);
            }
        },'json')
    }
    function getNowTime() {
//        $.ajax({
//            url: '/getDate',
//            type: 'get',
//            dataType: 'json',
//            success: function (reg) {
                var nowTime =new Date().getTime();
                serverTime = nowTime;
                var date1 = new Date(nowTime).Format('yyyy-MM-dd ');
                var date2 = new Date(nowTime).Format(' hh:mm');
                $('.r-top  h3').text(date2);
                $('.r-top  h4').text(date1);
//
//            }
//        });
    }
    function isRead(element){
        var url = element.attr('data-url');
        if($('.ReadFileBtn.btnSelect').attr('datatype') == 0){
            var runId = element.attr('runId');
            var flowId = element.attr('flowid');
            var flowstep = element.attr('flowstep');
            var prcsid = element.attr('prcsid');
            var runname = element.attr('runname');
            var tableId = element.attr('tableid');
            $.ajax({
                url: '/ToBeReadController/updateFileIsRead',
                type: 'get',
                dataType: 'json',
                data: {
                    updateStr: runId,
                    flowId:flowId,
                    flowStep:flowstep,
                    prcsId:prcsid,
                    runName:runname,
                    tableId:tableId
                },
                success: function (obj) {
                    window.open(url);
                    readFile($('.ReadFileBtn.btnSelect'));
                }
            })
        }else{
            window.open(url)
        }
    }
    function email() {
        //邮件接口
        $.ajax({
            url:'/email/newShowEmail',
            type:'get',
            data:{
                flag:'inbox',
                page:1,
                pageSize:5,
                useFlag:'true',
                // userID:'admin'
            },
            dataType:'json',
            success:function(obj){
                if(obj.flag) {
                    var data = obj.obj;
                    var li = '';
                    var read_li = '';
                    var all_li = '';
                    var email_li = '';
                    for (var i = 0; i < data.length; i++) {
                        for (var j = 0; j < data[i].emailList.length; j++) {
                            if(data[i].users != undefined){
                                var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
                                if (data[i].emailList[j].readFlag == 0) {
                                    var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd  hh:mm:ss');
                                    li += '<li class="clearfix no_read" onclick="tiaozhuan(this)" data-url="/email/details?id=' + data[i].emailList[j].emailId + '"><div class="e_img"><img style="border-radius: 50%" onerror="imgerror(this,1)" src="'+function () {
                                            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                                                return '/img/user/'+data[i].users.avatar;
                                            }
                                            if(data[i].users.sex == 0){
                                                return '/img/user/boy.png';
                                            }
                                            else if(data[i].users.sex == 1){
                                                return '/img/user/girl.png';
                                            }
                                        }()+'"></div><div class="e_word"><h1 class="e_name" data-userId="'+data[i].users.userId+'">' + data[i].users.userName + '</h1>' +
                                        '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
                                        '<a style="color:#1b5e8d;" class="public_title" target="_blank">' +
                                        '<h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" ' +
                                        'class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                                        ''+function () {
                                            if(data[i].attachmentId==''){
                                                return ''
                                            }else {
                                                return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                            }
                                        }()+'</div></li>'
                                } else if (data[i].emailList[j].readFlag == 1) {
                                    var sendTime = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
                                    read_li += '<li class="clearfix" onclick="tiaozhuan(this)" data-url="/email/details?id=' + data[i].emailList[j].emailId + '"><div class="e_img"><img style="border-radius: 50%" onerror="imgerror(this,1)" src="'+function () {
                                            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                                                return '/img/user/'+data[i].users.avatar;
                                            }
                                            if(data[i].users.sex == 0){
                                                return '/img/user/boy.png';
                                            }
                                            else if(data[i].users.sex == 1){
                                                return '/img/user/girl.png';
                                            }
                                        }()+'"></div>' +
                                        '<div class="e_word">' +
                                        '<h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' + data[i].users.userName + '</h1>' +
                                        '<h3 class="e_time">' + sendTime.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3>' +
                                        '<a style="color:#1b5e8d;" class="public_title" target="_blank"><h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                                        ''+function () {
                                            if(data[i].attachmentId==''){
                                                return ''
                                            }else {
                                                return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                            }
                                        }()+'</div></li>'
                                }
                                var sendTimews = new Date((data[i].sendTime) * 1000).Format('yyyy-MM-dd hh:mm:ss');
                                all_li += '<li class="clearfix" onclick="tiaozhuan(this)" data-url="/email/details?id=' + data[i].emailList[j].emailId + '"><div class="e_img">' +
                                    '<img style="border-radius: 50%" onerror="imgerror(this,1)" src="'+function () {
                                        if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
                                            return '/img/user/'+data[i].users.avatar;
                                        }
                                        if(data[i].users.sex == 0){
                                            return '/img/user/boy.png';
                                        }
                                        else if(data[i].users.sex == 1){
                                            return '/img/user/girl.png';
                                        }
                                    }()+'">' +
                                    '</div><div class="e_word"><h1 class="e_name" data-userName="'+data[i].users.userName+'" data-userId="'+data[i].users.userId+'">' +data[i].users.userName + '</h1><h3 class="e_time">' + sendTimews.replace(/\s/g, '<i style="margin-right:10px;"></i>') + '</h3><a style="color:#1b5e8d;" class="public_title" target="_blank"><h2 style="font-size: 8px; color: #1b5e8d;" emil-tid="' + data[i].emailList[j].emailId + '" class="e_title" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
                                    ''+function () {
                                        if(data[i].attachmentId==''){
                                            return ''
                                        }else {
                                            return '<img  class="accessory" src="/img/main_img/accessory.png" alt="">'
                                        }
                                    }()+'</div></li>'

                                email_li += '	<li class="clearfix tixing_one_all" onclick="tiaozhuan(this)" data-url="/email/details?id=' + data[i].emailList[j].emailId + '"><div class="tixing_every"><div class="company">' +
                                    '<img onerror="imgerror(this,1)" src="'+function () {
                                        if(data[i].users.avater != 0&&data[i].users.avater != 1&&data[i].users.avater != ''){
                                            return '/img/user/'+data[i].users.avater;
                                        }
                                        if(data[i].users.sex == 0){
                                            return '/img/user/boy.png';
                                        }
                                        else if(data[i].users.sex == 1){
                                            return '/img/user/girl.png';
                                        }
                                    }()+'" alt=""><h1>' + data[i].emailList[j].toName + '</h1><h2 class="company_time" style="margin-left: 88px;">' + sendTime + '</h2>' +
                                    '</div><a style="color:#1b5e8d;" class="public_title" target="_blank"><h1 class="thing">请查看我的邮件</h1><div class="liushuihao"><h1>主题：</h1><span>' + data[i].subject + '</span></div></a>' +
                                    '</div></li>';
                            }
                        }
                    }
                    $('#email').html(all_li);
                    $('.read').html(read_li);
                    $('.no_read').html(li);
                    if(li==''){
                        var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                            '</div>';
                        $('.no_read').html(lis);
                    }
                    if(all_li=='') {
                        var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                            '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                            '</div>';
                        $('#email').html(lis);
                    }
                }else {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</div>';
                    $('#email').html(lis);
                    $('.read').html(lis);
                    $('.no_read').html(lis);
                }
            }
        })
    }
    function getApplication(element) {
        $.ajax({
            type:'get',
            url:'/getMenu',
            dataType:'json',
            success:function (res) {
                var data=res.obj;
                if(res.obj.length > 0){
                    var str='';
                    if(res.obj.length > 6){
                        for(var i=0;i<6;i++){
                            str+='<div class="every_logo" menu_tid="'+data[i].id+'" onclick="parent.getMenuOpen(this)" data-url="'+data[i].url+'">'+
                                '<img src="/img/main_img/app/' +data[i].id+ '.png">'+
                                '<h2>'+data[i].name+'</h2>'+
                                '</div>'
                        }
                    }else{
                        for(var i=0;i<data.length;i++){
                            str+='<div class="every_logo" menu_tid="'+data[i].id+'" onclick="parent.getMenuOpen(this)" data-url="'+data[i].url+'">'+
                                '<img src="/img/main_img/app/' +data[i].id+ '.png">'+
                                '<h2>'+data[i].name+'</h2>'+
                                '</div>'
                        }
                    }
                    element.html(str);
                }
            }
        })
    }
    function noticeTitleNum(){
        $.get('/code/GetDropDownBox?CodeNos=NOTIFY',function (json) {
            var str='';
            var arr=json.NOTIFY;
            for(var i=0;i<3;i++){
                if(arr[i].codeName == '重点工作通报'){
                    $('.newBtn.yiban').attr('data-bool',arr[i].codeNo);
                }
            }
            newannouncement($('.newBtn.btnSelect'));
        },'json')
    }
    function newannouncement(me){  //公告查询方法
        var obj={
            read:'',
            page:1,
            pageSize:5,
            useFlag:'true',
            typeId:$(me).attr('data-bool')||""
        };
        $.ajax({
            url:"/notice/notifyManage",
            type:'get',
            data:obj,
            dataType:'json',
            success:function(obj) {
                var data = obj.obj;
                var str_li = '';
                for (var i = 0; i < data.length; i++) {
                    str_li += '<li class="clearfix chedule_li news" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                        '<div style="margin-left:12px;">' +
                        '<img src="/img/data_point.png">' +
                        '</div>' +
                        '<a><div class="new_title richeng_title" title="' + data[i].subject + '">' + data[i].subject + '</div></a>' +
                        '<div class="every_times">' +function () {

                            if(data[i].notifyDateTime!=undefined){
                                return data[i].notifyDateTime.replace(/\s/g, '<i style="margin-right:10px;"></i>')
                            }else {
                                return ''
                            }
                        }()  + '</div>' +
                        '</li>'
//                    var strnbsp = function(){
//                        if(data[i].notifyDateTime!=undefined){
//                            return data[i].notifyDateTime.replace(/\s/g, '<i style="margin-right: 10px"></i>')
//                        }else {
//                            return ''
//                        }
//                    }()
//                    str_li += '<li class="clearfix" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '"><div class="n_img"><img onerror="imgerror(this,1)" src="'+function () {
//                            if(data[i].users.avatar != 0&&data[i].users.avatar != 1&&data[i].users.avatar != ''){
//                                return '/img/user/'+data[i].users.avatar;
//                            }
//                            if(data[i].users.sex == 0){
//                                return '/img/user/boy.png';
//                            }
//                            else if(data[i].users.sex == 1){
//                                return '/img/user/girl.png';
//                            }
//                        }()+'"></div><div class="n_word">' +
//                        '<h1 class="n_name">' + data[i].name + '</h1><h3 class="n_time">' +
//                        '<p>' + strnbsp + '</p>' +
//                        '</h3><a  style="color:#000;" class="public_title" target="_blank"><h2 class="n_title" data-tid="' + data[i].notifyId + '" title="' + data[i].subject + '">' + data[i].subject + '</h2></a>' +
//                        ''+function () {
//                            if(data[i].attachmentId==''){
//                                return ''
//                            } else {
//                                return '<img class="n_accessory" src="img/main_img/accessory.png" alt="">'
//                            }
//                        }()+'</div></li>'
                }
                $('#new').html(str_li);
                if(obj.obj.length==0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</div>';
                    $('#new').html(lis);
                }
            }
        })
    }
    var $width=$('#ca').width();
    $('#ca').calendar({
        width: $width,
        height: 180,
        data: [
            {
                date: '2015/12/24',
                value: 'Christmas Eve'
            },
            {
                date: '2015/12/25',
                value: 'Me rry Christmas'
            },
            {
                date: '2016/01/01',
                value: 'Happy New Year'
            }
        ],
        onSelected: function (view, date) {
            richeng(new Date(date.Format('yyyy-MM-dd')).getTime()/1000)
        }
    });

    $(function () {
        getPicApplication();
        administrivia($('[data-bool=""]'))//新闻
        email();
        getApplication($('#application'));
        readFile($('.ReadFileBtn.btnSelect'));
        noticeTitleNum();
        getNowTime();
        setInterval(function () {
            serverTime = serverTime + 1000;
            var nowTime = serverTime;
            var date1 = new Date(nowTime).Format('yyyy-MM-dd');
            var date2 = new Date(nowTime).Format(' hh:mm');
            $('.r-top  h3').text(date2);
            $('.r-top  h4').text(date1);;
        },1000);

        $('#email').on('click','.e_name',function () {
            var userId=$(this).attr('data-userId');
            var userName=$(this).attr('data-userName');
            userName=encodeURI(encodeURI(userName));
            window.open('/email/addbox?userId='+userId+'&userName='+userName);
        })
        $('.ReadFileBtn').click(function(){
            $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
            readFile($(this))
        })
        $('.emailBtn').click(function(){
            var type = $(this).attr('datatype');
            $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
            if(type == '0'){
                $('.emailall').show().siblings('.buttommai-main').hide();
            }else if(type == '1'){
                $('.no_read').show().siblings('.buttommai-main').hide();
            }else if(type == '2'){
                $('.read').show().siblings('.buttommai-main').hide();

            }
        })
        $('.newBtn').click(function(){
            var type = $(this).attr('data-bool')||'';
            $(this).addClass('btnSelect').siblings().removeClass('btnSelect');
            newannouncement($(this))
        })
    })
    function getPicApplication() {
        $.ajax({
            type:'get',
            url:'/getMenu',
            dataType:'json',
            success:function (res) {
                var data=res.obj;
                if(res.obj.length > 0){
                    var str='';
                    if(res.obj.length > 6){
                        for(var i=0;i<6;i++){
                            str+='<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="'+data[i].id+'" data-url="'+data[i].url+'">'+
                                '<img src="/img/main_img/app/' + data[i].id + '.png" alt="">'+
                                '<h4>'+data[i].name+'</h4>'+
                                '<h2 class="hide">'+data[i].name+'</h2>'+
                                '</li>'
                        }
                    }else {
                        for(var i=0;i<data.length;i++){
                            str+='<li class="fl" onclick="parent.getMenuOpen(this)" menu_tid="'+data[i].id+'" data-url="'+data[i].url+'">'+
                                '<img src="/img/main_img/app/' + data[i].id + '.png" alt="">'+
                                '<h4>'+data[i].name+'</h4>'+
                                '<h2 class="hide">'+data[i].name+'</h2>'+
                                '</li>'
                        }
                    }

                    $('.changyongmain').html(str);
                }
            }
        })
    }

</script>
</body>
</html>
