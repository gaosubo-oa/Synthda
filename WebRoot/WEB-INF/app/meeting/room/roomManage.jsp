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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><fmt:message code="meet.th.ConferenceApplication"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/index.css?20220814">
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery-ui.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/fullcalendar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script src="/js/base/base.js?20190927.1"></script>
    <script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/ajaxupload.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.form.min.js"></script>
    <script src="/js/jquery/jquery.jqprint-0.3.js"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .equip tbody td {
            text-align: center;
        }

        .equipSpan {
            background-color: #00a2d4;
        }

        .equip {
            width: 77%;
            margin: 20px auto;
        }

        table tbody td {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            padding: 0;
        }

        .head .headli {
            width: 94px;
        }

        .pagediv {
            margin: 0 auto !important;
            padding-top: 45px;
        }

        .table tr td:first-of-type {
            text-align:left;
        }

        .layui-layer-btn {
            text-align: center !important;
        }

        .layui-laydate-content td, .layui-laydate-content th {
            font-size: 14px;
            line-height: normal;
        }

        .fc-day-number {
            font-weight: 700
        }

        .typeBtn {
            float: right;
            margin: 5px 5px;
            width: 60px;
            height: 28px;
            line-height: 38px;
            color: #fff;
            border: 1px solid #ebebeb;
            outline: none;
            font-size: 14px;
            border-radius: 5px;
            line-height: 28px;
            cursor: pointer;
        }

        .M-box3 .active {
            margin: 0px 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            background: #2b7fe0;
            font-size: 12px;
            border: 1px solid #2b7fe0;
            color: #fff;
            text-align: center;
            display: inline-block;
        }

        .M-box3 a {
            margin: 0 3px;
            width: 29px;
            height: 29px;
            line-height: 29px;
            font-size: 12px;
            display: inline-block;
            text-align: center;
            background: #fff;
            border: 1px solid #ebebeb;
            color: #bdbdbd;
            text-decoration: none;
        }

        .jump-ipt {
            float: left;
            width: 30px;
            height: 30px;
        }

        .span_td {
            width: 130px;
            text-align: right;
        }

        .table {
            width: 90%;
            margin: 10px auto;
        }

        .div_tr input {
            text-indent: 5px;
        }

        .one {
            border-radius: 20px !important;
        }

        .fc-header-left, .fc-header-right {
            padding: 10px 18px !important;
            box-sizing: border-box;
        }

        .fc-header-left .fc-button, .fc-header-right .fc-button {
            margin-bottom: 0;
        }

        .div_tr {
            margin: 0;
            padding: 10px;
        }

        input[type=file] {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 18px;
            z-index: 99;
            opacity: 0;
        }

        .btn {
            background-color: white;
            background: #009688;
            border: 0;
            color: #fff;
            width: 100px;
            height: 40px;
            font-size: 16px;
            display: block;
            margin: 0 auto 20px auto;
        }

        #Import {
            margin-left: 10px;
            height: 28px;
            line-height: 28px;
            padding: 0 10px;
            font-size: 12px;
            border: none;
            border-radius: 2px;
            cursor: pointer;
            background-color: #009688;
            color: #fff;
            white-space: nowrap;
            text-align: center;
            width: 70px;
        }


        .leftBtn{
            float: left;
            margin-bottom: 6px;
        }
        .leftBtn span{
            display: block;
            float: left;
            margin-left: 20px;
            width: 30px;
            height: 30px;
            background-color: #e5f5fc;
            border: 1px solid #abd5eb;
            border-radius: 4px;
            cursor: pointer;
        }
        .leftBtnTwo{
            width: 60px !important;
            line-height: 30px;
            text-align: center;
            font-size: 14px;
        }
        .leftBtnOne{
            background: url("../img/meeting/icon_prev_03.png") no-repeat center;
        }
        .leftBtnThr{
            background: url("../img/meeting/icon_next_03.png") no-repeat center;
        }
        .fullTime{
            float: left;
            width: 40%;
            margin: 0 auto;
            height: 30px;
            text-align: center;
            line-height: 30px;
            font-size: 14px;
        }
        .colorClass {
            float: right;
            margin-right: 3%;
            margin-top: 8px;
        }
        .colorClass a {
            display: inline-block;
            width: 22px;
            height: 20px;
            vertical-align: middle;
        }

        #fullCandar{
            padding-top: 10px;
        }

        #timeChoose{
            width: 200px;
            margin: 0 auto;
            height: 120%;
        }
        .head .headli{
            width: 100px;
        }
        .index_head li img{border: 0;vertical-align: middle;width: 2px;margin-left: 10px;}
        .laydate-btns-time{
            height: 26px;
            border-radius: 2px;
            width: 100px;
            text-align: center;
            font-size: 15px!important;
            color: #f5f5f5;
            background: #058d3e;
            margin-left: -10px;
        }
        .laydate-btns-time:hover{
            color: rgb(95, 184, 120);;
        }

        * {
            font-family: "Microsoft Yahei" !important;
        }

        .header {
            padding-top: 35px;
            height: 78px;
            margin: 20px;
        }

        .header span {
            float: none;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
        }

        .layui-table-cell{
            text-align: center!important;
            line-height: 38px !important;
        }

        .head {
            position: fixed;
            margin-top: -20px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?20220814"/>
    <script>
        // 更新会议状态
        $.ajax({url:'/meeting/updateStatus', async:turn});
    </script>
</head>
<body style="font-family: 微软雅黑; box-sizing: border-box; width: 100%; height: 600px; overflow: scroll;">
<div class="head w clearfix">
    <ul class="index_head">
        <li id="meetingApply" onclick="listByStatus(0)"><span class="one headli"><fmt:message code="meet.th.ConferenceApplication"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="PAMeeting" onclick="listByStatus(1)"><span class="headli"><fmt:message code="meet.th.Meeting"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="ApMeeting" onclick="listByStatus(2)"><span class="headli"><fmt:message code="meet.th.Approved"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="HaveMeeting" onclick="listByStatus(3)"><span class="headli"><fmt:message code="meet.th.InSession"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="NotMeeting" onclick="listByStatus(4)"><span class="headli" style="margin-top: 4px;"><fmt:message code="meet.th.NotApprovedMeeting"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="MeetingRoomUsage"><span class="headli" style="margin-top: 4px;">会议室使用情况</span></li>
    </ul>
    <div class="colorClass">
        <button type="button" id="Import">导入</button>
    </div>
</div>
<div class="header">
    <div class="title">
        <img src="/img/mycount.png"><span style="font-size: 22px;">会议室列表</span>
        <hr style="background-color: black"/>
    </div>
    <%--    表格--%>
    <div class="tab">
        <table class="layui-hide" id="test" lay-filter="test"></table>
    </div>
</div>
<div class="pagediv" id="already" style="margin: 0 auto;width: 97%;display: none;margin-top: 10px;">
    <div class="headTop" style="z-index: 999;">
        <div class="headImg">
            <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_apply.png" alt="">
        </div>
        <div class="divTitle">
            <fmt:message code="meet.th.ConferenceApplication"/>
        </div>
    </div>
    <table>
        <thead>
        <tr>
            <th width="11%" style="text-align:center"><fmt:message code="meet.th.ConferenceName"/></th>
            <th width="11%" style="text-align:center"><fmt:message code="meet.th.ConferenceTitle"/></th>
            <th width="11%" style="text-align:center">会议验证码</th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.ApplicationTime"/></th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.startTime"/></th>
            <th width="13%" style="text-align:center"><fmt:message code="meet.th.EndTime"/></th>
            <th width="9%" style="text-align:center"><fmt:message code="meet.th.ConferenceRoom"/></th>
            <th width="6%" style="text-align:center"><fmt:message code="sup.th.Applicant"/></th>
            <th width="9%" style="text-align:center">联系电话</th>
            <th width="15%" style="text-align:center"><fmt:message code="notice.th.operation"/></th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%"></div>
</div>
<div class="divIframeTwo" style="width: 100%;height: 100%;display: none;">
    <iframe src="" id="iframeTwo" style="width: 100%;height: 100%;margin-top: 40px;" frameborder="0"></iframe>
</div>
<script>
    layui.use(['form','table','layer','laydate'],function() {
        const table = layui.table;
        var tableInfo = table.render({
            elem:"#test",
            url:"/meetingRoom/getAllMeetRoom",
            page:true,
            limit: 20,
            limits:[20,30,40,50],
            where: {
                useFlag: true,
                pageSize: 20
            },
            request: {
                pageName: 'page',
                limitName: 'pageSize'
            },
            parseData:function(res) {
                return {
                    "code": res.flag?0:400,
                    "msg": res.msg,
                    "count": res.totleNum,
                    "data": res.obj
                }
            },
            cols:[[
                {field:"mrName",title:"名称",align:"center"},
                {field:"mrCapacity",title:"可容纳人数"},
                {field:"mrDevice",title:"设备情况"},
                {field:"mrPlace",title:'所在地点',},
                {field:"mrDesc",title:'会议室描述',},
                {field:"managetnames",title:'会议室管理员',},
                {title:'操作',templet:function(d) {
                        return '<button  class="layui-btn layui-btn-xs layui-btn-normal" id="shenqing" meetRoomId="'+d.sid+'">申请</button>'
                    }},
            ]]

        })
        $(document).on("click", "#shenqing",function () {
            window.open("/meeting/meetingReserve?meetRoomId=" + $(this).attr("meetRoomId"));
        })
    })

    $(document).on('click', '#MeetingRoomUsage', function () {
        // window.location.href='/MeetingCommon/MeetingRoomUsage'
        $('#iframeTwo').attr('src','/meeting/meetingReserve?usage=false')
        $('.divIframeTwo').css('display','block')
    });

    //点击导入按钮
    $(document).on('click', '#Import', function () {
        layer.open({
            type: 1,
            title: ['数据导入'],
            area: ['600px', '350px'],
            shadeClose: true, //点击遮罩关闭
            content: '<div style="display: block;" id="uploadfile">' +
                '     <form id="ajaxform" method="post" enctype ="multipart/form-data">' +
                '        <div style="text-align: center">' +
                '          <div style="font-size: 20px;">' +
                '              <button type="button" class="layui-btn" id="test1" style=" display: block; margin: 25px auto; ">\n' +
                '                 <i class="layui-icon">&#xe67c;</i>上传附件\n' +
                '              </button>' +
                '             <a style="color: #03a9f4"  href="/file/meeting/会议管理导入模板.xls">下载导入模板</a>' +
                '          </div>' +
                '          <hr style="height: 2px;margin-top: 50px;"/>' +
                '          <div><span style="color: #03a9f4;">特别提示：在执行导入数据前,请先备份数据库</span></div>' +
                '        </div>' +
                '     </from>' +
                '</div>' +
                '<div style="display: none; padding: 20px; background-color: #F2F2F2;" id="uploadmsg">' +
                '</div>',
            success: function () {
                layui.use('upload', function () {
                    var upload = layui.upload;
                    //执行实例
                    var uploadInst = upload.render({
                        elem: '#test1' //绑定元素
                        , url: '/meeting/meetingImport' //上传接口
                        , accept: 'file'
                        , before: function (obj) {
                            layer.load();
                        }
                        , done: function (res, index, upload) {
                            //上传完毕回调
                            if (res.flag) {
                                $('#uploadfile').hide();
                                $('#uploadmsg').show();

                                var obj = res.obj;
                                for (var i = 0; i < obj.length; i++) {
                                    var row = obj[i].row;
                                    var msg = obj[i].msg;
                                    var str = '<div class="layui-card">\n' +
                                        '  <div class="layui-card-header"> 第<span style="color: red;">' + row + '</span>行</div>\n' +
                                        '  <div class="layui-card-body">' + msg.msg + '  </div>\n' +
                                        '</div>';
                                    $('#uploadmsg').append(str);
                                }
                            } else {
                                layer.msg(res.msg);
                            }
                            layer.closeAll('loading');
                        }
                        , error: function () {
                            //请求异常回调layer
                            layer.msg('异常');
                            layer.closeAll('loading');
                        }
                    });
                })
            }
        });

    });

    //拉起视频会议客户端
    function GetDataSet(obj) {
        //进行打卡
        $.post('/meeting/readMeeting', {meetingId: obj.sId, attendFlag: 1}, function (res) {
            if (res.flag) {
                //layer.msg('打卡成功');
            }
        });

        var url = "http://127.0.0.1:2900";
        var content = '<?xml version="1.0" encoding="UTF-8" ?>' +
            '<lemeeting>' +
            '<req_type>10001</req_type>' +
            '<login_param>' +
            '-j="' + obj.j + '" -roid=' + obj.roid + ' -rid=' + obj.rid + ' -rp="' + obj.rp + '" -aoid=' + obj.aoid + ' -a="' + obj.a + '" -n="' + obj.n + '" -rmd=1  -ccvt=1 -mpc=100 -mvsc=100 -mipcdc=100 -srf=1 -msfs=4000' +
            '</login_param>' +
            '</lemeeting>';
        var request = null;
        if (window.XMLHttpRequest) {
            request = new XMLHttpRequest();
        } else if (window.ActiveXObject) {
            request = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if (request) {
            // 防止缓存&& DECODE
            request.open("POST", url, false);//true异步false同步
            //定义传输的文件HTTP头信息
            request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            request.send(content);
        }
    }

    function DateNextDay(d2) {
        //slice返回一个数组
        var str = d2.slice(5) + "-" + d2.slice(0, 4);
        var d = new Date(str);
        var d3 = new Date(d.getFullYear(), d.getMonth(), d.getDate() + 1);
        var month = returnMonth(d3.getMonth());
        var day = d3.getDate();
        day = day < 10 ? "0" + day : day;
        var str2 = d3.getFullYear() + "-" + month + "-" + day;
        return str2;
    }

    function returnMonth(num) {
        var str = "";
        switch (num) {
            case 0:
                str = "01";
                break;
            case 1:
                str = "02";
                break;
            case 2:
                str = "03";
                break;
            case 3:
                str = "04";
                break;
            case 4:
                str = "05";
                break;
            case 5:
                str = "06";
                break;
            case 6:
                str = "07";
                break;
            case 7:
                str = "08";
                break;
            case 8:
                str = "09";
                break;
            case 9:
                str = "10";
                break;
            case 10:
                str = "11";
                break;
            case 11:
                str = "12";
                break;
        }
        return str;
    }

    function week_select() {
        $('.WEEKEND').hide();

        var x = $('#cycleStartDate').val();
        y = x.replace(/-/, ",");
        y = y.replace(/-/, "/");
        y = new Date(y);

        var z = $('#cycleEndDate').val();
        r = z.replace(/-/, ",");
        r = r.replace(/-/, "/");
        r = new Date(r);

        a = r - y;
        a = a / 24 / 60 / 60 / 1000 + 1;

        if (a > 6) {
            $('.WEEKEND').css('display', '');
        } else {
            for (var i = x; i <= z; i = DateNextDay(i)) {
                i = i.replace(/-/, ",");
                i = i.replace(/-/, "/");
                v = new Date(i);
                s = v.getDay();
                if (/^[-]?\d+$/.test(s)) {
                    w = "WEEKEND" + s;
                    document.getElementById(w).style.display = "";
                }
            }
        }
    }

    $(function () {
        $('#meetingApply').click(function () {
            $('.head').css('margin-top', '-20px');
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('.divIframeTwo').hide();
            $('.header').show();
            $('#already').hide();
            $('.colorClass').show();
        })
        $('#PAMeeting').click(function () {
            $('.head').css('margin-top', '0px');
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.header').hide();
            $('.colorClass').hide();
        })
        $('#ApMeeting').click(function () {
            $('.head').css('margin-top', '0px');
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.header').hide();
            $('.colorClass').hide();
        })
        $('#HaveMeeting').click(function () {
            $('.head').css('margin-top', '0px');
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.header').hide();
            $('.colorClass').hide();
        })
        $('#NotMeeting').click(function () {
            $('.head').css('margin-top', '0px');
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.header').hide();
            $('.colorClass').hide();
        })
        $('#MeetingRoomUsage').click(function () {
            $('.head').css('margin-top', '0px');
            $('.pagediv').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('.header').hide();
            $('.colorClass').hide();
        })
    })

    //点击各个状态后显示的列表
    function listByStatus(status) {
        // 更新会议状态
        $.ajax({url:'/meeting/updateStatus', async:false});
        var paraData;
        queryStatus = status;
        if (status == 0) {
            window.location.href = "/meetingRoom/roomManage";
        } else {
            paraData = {
                uid: $.cookie('uid'),
                status: status,
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true
            }
        }

        var ajaxPageLe = {
            data: paraData,
            page: function () {
                var me = this;

                $.ajax({
                    url: '/meeting/queryMeeting',
                    type: 'get',
                    dataType: 'json',
                    data: me.data,
                    success: function (obj) {
                        var data = obj.obj;
                        var str = "";
                        for (var i = 0; i < data.length; i++) {
                            str += '<tr>' +
                                '<td style="text-align: center" width="11%" title="' + data[i].meetName + '"><a class="meetingDetail" href="javascript:void(0)" sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
                                '<td style="text-align:center" width="11%" title="' + data[i].subject + '">' + data[i].subject + '</td>' +
                                '<td style="text-align:center" width="11%" title="' + data[i].meetCode + '">' + function () {
                                    if (data[i].meetCode != undefined && data[i].meetCode != '') {
                                        return data[i].meetCode;
                                    }
                                    return "无";
                                }() + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].createTime + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].startTime + '</td>' +
                                '<td style="text-align:center" width="13%">' + data[i].endTime + '</td>' +
                                '<td style="text-align:center" width="9%">' + data[i].meetRoomName + '</td>' +
                                '<td style="text-align:center" width="6%">' + data[i].userName + '</td>' +
                                '<td style="text-align:center" width="9%">' + function () {
                                    if (data[i].mobileNo == undefined) {
                                        return ''
                                    } else {
                                        return data[i].mobileNo
                                    }
                                }() + '</td>';

                            if (status == 1 || status == 4) {
                                str += '<td style="text-align:center" width="15%">' +
                                    '<a href="javascript:;" style="" class="editData" sid="' + data[i].sid + '"><fmt:message code="depatement.th.modify" /></a>&nbsp;&nbsp;' +
                                    '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a></td>' +
                                    '</tr>';
                            }
                            if (status == 2) {
                                str += '<td style="text-align:center" width="15%"><a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;&nbsp;' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;&nbsp;' +
                                    function () {
                                        if (data[i].videoContent != undefined && data[i].videoConfFlag === "1") {
                                            return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a>';
                                        }
                                        return ''
                                    }() +
                                    '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a>'
                                '</td>' +
                                '</tr>';
                            }
                            if (status == 3) {
                                str += '<td width="15%" style="text-align:center"><a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>&nbsp;&nbsp;' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>&nbsp;&nbsp;' +
                                    function () {
                                        if (data[i].videoContent != undefined && data[i].videoConfFlag === "1") {
                                            return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a>';
                                        }
                                        return ''
                                    }() +
                                    '</tr>';
                            }
                        }
                        $("#already tbody").html(str);
                        me.pageTwo(obj.totleNum, me.data.pageSize, me.data.page)
                    }
                });
            },
            pageTwo: function (totalData, pageSize, indexs) {
                var mes = this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: indexs || 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
        ajaxPageLe.page();
    }

    //参会情况和签阅情况
    function attendState(meetingId, join) {
        if (join == 1) {//参会情况
            $.ajax({
                url: '/meeting/queryAttendConfirm',
                type: 'get',
                dataType: 'json',
                data: {
                    meetingId: meetingId
                },
                success: function (obj) {
                    var data = obj.obj;
                    layer.open({
                        type: 1,
                        offset: '80px',
                        area: ['800px', '400px'], //宽高
                        title: "<fmt:message code="meet.th.ViewParticipants" />",
                        closeBtn: 1,
                        content:
                            '<div class="mainRight attendContent"><div class="pagediv" style="margin: 0 auto;width: 97%;" id="showList">' +
                            '<table><thead>' +
                            '<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th><fmt:message code="meet.th.AttendanceStatus" /></th><th><fmt:message code="meet.th.ConfirmationTime" /></th><th><fmt:message code="hr.th.Explain" /></th></tr>' +
                            '</thead>' +
                            '<tbody></tbody>' +
                            '</table>' +
                            '</div></div>',
                        btn: ['<fmt:message code="global.lang.close" />'],
                        success: function () {
                            $(".attendContent tbody").html("");
                            var str = "";
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr><td>' + (i + 1) + '</td>' + '<td>' + data[i].attendeeName + '</td>' + '<td>' + data[i].deptName + '</td>' +
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].attendFlagStr + '</td>' + '<td>' + data[i].createTime + '</td>' + '<td>' + data[i].remark + '</td>' +
                                    '</tr>';
                            }
                            $(".attendContent tbody").html(str);
                        }
                    })
                }
            });
        } else {//签阅情况
            $.ajax({
                url: '/meeting/queryAttendConfirm',
                type: 'get',
                dataType: 'json',
                data: {
                    meetingId: meetingId
                },
                success: function (obj) {
                    var data = obj.obj;
                    layer.open({
                        type: 1,
                        offset: '80px',
                        area: ['800px', '400px'], //宽高
                        title: "<fmt:message code="meet.th.CheckMeeting" />",
                        closeBtn: 1,
                        content: '<div class="mainRight attendContent"><div class="pagediv" style="margin: 0 auto;width: 97%;" id="showList">' +
                            '<table><thead>' +
                            '<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th><fmt:message code="meet.th.ReadStatus" /></th><th><fmt:message code="meet.th.TimeRead" /></th></tr>' +
                            '</thead>' +
                            '<tbody></tbody>' +
                            '</table>' +
                            '</div></div>',
                        btn: ['<fmt:message code="global.lang.close" />'],
                        success: function () {
                            $(".attendContent tbody").html("");
                            var str = "";
                            for (var i = 0; i < data.length; i++) {
                                str += '<tr><td>' + (i + 1) + '</td>' + '<td>' + data[i].attendeeName + '</td>' + '<td>' + data[i].deptName + '</td>' +
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].readFlagStr + '</td>' + '<td>' + data[i].readingTime + '</td>' +
                                    '</tr>';
                            }
                            $(".attendContent tbody").html(str);
                        }
                    })
                }
            });
        }
    }

    //删除会议
    function delMeeting(sid) {
        $.layerConfirm({title: '<fmt:message code="meet.th.DeleteSession" />', content: '<fmt:message code="meet.th.DeterminesRecovered" />！', icon: 0}, function () {
            $.ajax({
                url: '/meeting/delMeetingById',
                type: 'get',
                dataType: 'json',
                data: {
                    sid: sid
                },
                success: function (obj) {
                    $.layerMsg({content: '<fmt:message code="workflow.th.delsucess" />！', icon: 1}, function () {
                        //更新列表
                        listByStatus(queryStatus)
                        //更新数量
                        //各个状态的数量显示
                        $.ajax({
                            url: '/meeting/queryCountByStatus',
                            type: 'get',
                            dataType: 'json',
                            success: function (obj) {
                                var data = obj.object;
                                $("#pendingCount").html(data.pendingCount);
                                $("#approvedCount").html(data.approvedCount);
                                $("#processingCount").html(data.processingCount);
                                $("#notApprovedCount").html(data.notApprovedCount);
                                $("#overCount").html(data.overCount);
                            }
                        });
                    })
                }
            });
        })
    }

    //附件删除
    function deleteChatment(data, element) {
        layer.confirm('<fmt:message code="sup.th.Delete" />？', {
            btn: ['<fmt:message code="global.lang.ok" />', '<fmt:message code="depatement.th.quxiao" />'], //按钮
            title: "<fmt:message code="notice.th.DeleteFile" />"
        }, function () {
            //确定删除，调接口
            $.ajax({
                type: 'get',
                url: '../delete',
                dataType: 'json',
                data: data,
                success: function (res) {
                    if (res.flag == true) {
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                        element.remove();
                    } else {
                        layer.msg('<fmt:message code="lang.th.deleSucess" />', {icon: 6});
                    }
                }
            });
        }, function (index) {
            layer.close(index);
        });
    }

    $('.pagediv').on('click', '.meetingDetail', function (event) {
        $.ajax({
            url: '/meeting/queryMeetingById',
            type: 'get',
            dataType: 'json',
            data: {
                sid: $(this).attr("sid")
            },
            success: function (obj) {
                var data = obj.object;
                var str = '';
                if (data.attachmentList && data.attachmentList.length > 0) {
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        str += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.attachmentList[i].attUrl + '">' + data.attachmentList[i].attachName + '</a></div>'
                    }
                } else {
                    str = '';
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['800px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['打印', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="table"><table style="margin:auto;" class="detailTable">' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td">联系电话：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                        '<tr><td><span class="span_td">前台会议服务人员：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                        '</table></div>',
                    success: function () {

                        laydate.render({
                            elem: '.startTime'
                            ,trigger: 'click' //采用click弹出
                        });
                        laydate.render({
                            elem: '.endTime'
                            ,trigger: 'click' //采用click弹出
                        });
                        $('.table td').css({
                            "overflow": "hidden",
                            "text-overflow": "ellipsis",
                            "white-space": "nowrap",
                            "padding": 0,
                        });
                        for (var i = 0; i < $('.table tr').length; i++) {
                            $('.table tr').eq(i).find('td').eq(0).css('text-align', 'right');
                        }
                    },
                    yes: function () {
                        $('.table').jqprint({
                            debug: false,
                            importCSS: true,
                            printContainer: true,
                            operaSupport: false
                        });
                    }
                })
            }
        })
    })

    //获取昨天时间最晚时间
    function dateYest() {
        var time = new Date();
        time.setTime(time.getTime() - 24 * 60 * 60 * 1000);
        var mon = time.getMonth() + 1
        var da = time.getDate()
        if (mon < 10) mon = "0" + mon;
        if (da < 10) da = "0" + da;
        var date = time.getFullYear() + "-" + mon + "-" + da + ' ' + '23:59:59'
        return date
    }

    //附件上传 方法
    var timer = null;
    function fileuploadFn(formId, element) {
        $(formId).fileupload({
            dataType: 'json',
            progressall: function (e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $('#progress .bar').css('width', progress + '%');
                $('.barText').html(progress + '%');
                if (progress >= 100) {  //判断滚动条到100%清除定时器
                    timer = setTimeout(function () {
                        $('#progress .bar').css('width', 0 + '%');
                        $('.barText').html('');
                    }, 2000);
                }
            },
            done: function (e, data) {
                if (data.result.obj != undefined) {
                    if (data.result.obj != '') {
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            var gs = data[i].attachName.substring(data[i].attachName.lastIndexOf('.') + 1)
                            if (gs == 'doc' || gs == 'docx' || gs == 'xls' || gs == 'xlsx' || gs == 'ppt' || gs == 'pptx') { //只能上传后缀为这些的
                                var fileExtension = data[i].attachName.substring(data[i].attachName.lastIndexOf(".") + 1, data[i].attachName.length);//截取附件文件后缀
                                var attName = encodeURI(data[i].attachName).replace(/\+/g, "%2b").replace(/\@/g, "%40").replace(/\#/g, "%23").replace(/\&/g, "%26").replace(/\//g, "%2F").replace(/\?/g, "%3F").replace(/\￥/g, "%ef%bf%a5").replace(/\$/g, "%24").replace(/\！/g, "%ef%bc%81").replace(/\（/g, "%ef%bc%88").replace(/\）/g, "%ef%bc%89").replace(/\…/g, "%e2%80%a6%e2%80%a6");
                                var fileExtensionName = attName.substring(0, attName.lastIndexOf("."));
                                var deUrl = data[i].attUrl.split('&ATTACHMENT_NAME=')[0] + "&ATTACHMENT_NAME=" + fileExtensionName + "." + fileExtension + "&FILESIZE=" + data[i].size;
                                str += '<div class="dech" deUrl="' + deUrl + '"><a href="/download?' + encodeURI(deUrl) + '" NAME="' + data[i].attachName + '*" style="text-decoration:none;margin-left:5px;"><img src="/img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            } else {
                                str += '';
                                layer.alert('只能上传word、excel、ppt文件!', {}, function (index) {
                                    layer.close(index);
                                });
                            }
                        }
                        element.append(str);
                    } else {
                        layer.alert('添加附件大小不能为空!', {}, function (index) {
                            // layer.closeAll();
                            layer.close(index)
                        });
                    }
                }
            }
        });
    }
    function dateHandling(date){
        if (date == null){
            date = new Date();
        }

        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();

        return year + "-" + month + "-" + day;
    }
</script>
</body>
</html>
