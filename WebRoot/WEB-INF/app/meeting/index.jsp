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

    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
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
            margin-top: 5px;
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
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?20220814"/>
    <script>
        // 更新会议状态
        $.ajax({url:'/meeting/updateStatus', async:true});
    </script>
</head>
<body style="font-family: 微软雅黑;box-sizing: border-box; width: 100%;height: 600px">
<div class="head w clearfix">
    <ul class="index_head">
        <li id="meetingApply" onclick="listByStatus(0)"><span class="one headli"><fmt:message code="meet.th.ConferenceApplication"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="PAMeeting" onclick="listByStatus(1)"><span class="headli"><fmt:message code="meet.th.Meeting"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="ApMeeting" onclick="listByStatus(2)"><span class="headli"><fmt:message code="meet.th.Approved"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="HaveMeeting" onclick="listByStatus(3)"><span class="headli"><fmt:message code="meet.th.InSession"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="NotMeeting" onclick="listByStatus(4)"><span class="headli" style="margin-top: 4px;"><fmt:message code="meet.th.NotApprovedMeeting"/></span><img src="../img/twoth.png" alt=""/></li>
        <li id="MeetingRoomUsage"><span class="headli" style="margin-top: 4px;"><fmt:message code="meet.th.MeetingRoomUsage"/></span></li>
    </ul>
    <div class="colorClass">
        <button type="button" id="Import"><fmt:message code="global.lang.import"/></button>
        <a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>
        <span><fmt:message code="meet.th.PendingApproval"/></span>
        <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>
        <span><fmt:message code="meet.th.Ratified"/></span>
        <a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>
        <span><fmt:message code="meet.th.HaveHand"/></span>
        <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>
        <span><fmt:message code="meet.th.unratified"/></span>
        <a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>
        <span style="margin-right: 24px"><fmt:message code="meet.th.IsOver"/></span>
    </div>
</div>
<div class="meentingDate" id="meentingDate" style="display: block;overflow-y: auto;padding: 0 18px 20px;box-sizing: border-box;">
    <div class="mainList"></div>
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
            <th width="11%" style="text-align:center"><fmt:message code="meet.th.ConferenceCode"/></th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.ApplicationTime"/></th>
            <th width="13%" style="text-align:center"><fmt:message code="sup.th.startTime"/></th>
            <th width="13%" style="text-align:center"><fmt:message code="meet.th.EndTime"/></th>
            <th width="9%" style="text-align:center"><fmt:message code="meet.th.ConferenceRoom"/></th>
            <th width="6%" style="text-align:center"><fmt:message code="sup.th.Applicant"/></th>
            <th width="9%" style="text-align:center"><fmt:message code="sup.th.ContactNumber"/></th>
            <th width="15%" style="text-align:center"><fmt:message code="notice.th.operation"/></th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div id="dbgz_page" class="M-box3 fr" style="margin-right: 5%;margin-top: 1%"></div>
</div>
<div class="divIframeTwo" style="width: 100%;height: 100%;display: none;">
    <iframe src="" id="iframeTwo" style="width: 100%;height: 100%;" frameborder="0"></iframe>
</div>
<script>
    $(document).on('click', '#MeetingRoomUsage', function () {
        // window.location.href='/MeetingCommon/MeetingRoomUsage'
        $('#iframeTwo').attr('src','/MeetingCommon/MeetingRoomUsage')
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

    $(document).on('click', '#selectUser', function () {//选人员控件(申请人)
        user_id = 'userDuser';
        $.popWindow("../../common/selectUser?0");
    });
    $(document).on('click', '#selectRecorder', function () {//选人员控件（纪要员）
        user_id = 'recoderDuser';
        $.popWindow("../../common/selectUser?0");
    });
    $(document).on('click', '#selectAttendee', function () {//选人员控件（出席内部人员）
        user_id = 'attendeeDuser';
        $.popWindow("../../common/selectUser");
    });
    $(document).on('click', '#addServiceUser', function () {//选人员控件（前台会议服务人员）
        user_id = 'serviceUser';
        $.popWindow("../../common/selectUser");
    });
    $(document).on('click', '#clearUser', function () { //清空人员(申请人)
        $('#userDuser').attr('user_id', '');
        $('#userDuser').attr('dataid', '');
        $('#userDuser').val('');
    });
    $(document).on('click', '#clearRecoder', function () { //清空人员（纪要员）
        $('#recoderDuser').attr('user_id', '');
        $('#recoderDuser').attr('dataid', '');
        $('#recoderDuser').val('');
    });
    $(document).on('click', '#clearAttendee', function () { //清空人员（出席内部人员）
        $('#attendeeDuser').attr('user_id', '');
        $('#attendeeDuser').attr('dataid', '');
        $('#attendeeDuser').val('');
    });
    $(document).on('click', '#clearServiceUser', function () { //清空人员（出席内部人员）
        $('#serviceUser').attr('user_id', '');
        $('#serviceUser').attr('dataid', '');
        $('#serviceUser').val('');
    });

    // 删除附件
    $(document).on('click', '.deImgs', function () {
        var data = $(this).parents('.dech').attr('deUrl');
        var dome = $(this).parents('.dech');
        deleteChatment(data, dome);
    })

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

    //初始化申请管理员下拉列表
    $(function () {
        autoIDheight('meentingDate', 46);
        // windowReload();
        $('.mainList').fullCalendar({
            header: {
                left: 'prev,next,today',
                center: 'title',
                right: 'month,agendaWeek'
            },
            buttonText: {
                today: '<fmt:message code="meet.th.JumpthDay" />'
            },
            lang: 'zh-cn',
            editable: true,
            events: function (start, end, timezone, callback) {
                var date = this.getDate().format('YYYY-MM');
                $.ajax({
                    url: '/meeting/queryMeeting',
                    dataType: 'json',
                    data: {
                        date: date
                    },
                    success: function (res) { // 获取当前月的数据
                        var datas = res.obj;
                        var events = [];
                        var TColor = '';
                        var BColor = '';
                        for (var i = 0; i < datas.length; i++) {
                            var arr = datas[i].startTime.split(' ');
                            if (datas[i].status == 1) {
                                BColor = 'rgb(58, 135, 173)';
                            } else if (datas[i].status == 2) {
                                BColor = 'rgb(105, 240, 164)';
                            } else if (datas[i].status == 3) {
                                BColor = 'rgb(255, 136, 124)';
                            } else if (datas[i].status == 4) {
                                BColor = 'rgb(245, 181, 46)';
                            } else if (datas[i].status == 5) {
                                BColor = 'rgb(219, 173, 255)';
                            }
                            events.push({
                                id: datas[i].sid,
                                title: arr[1] + '  ' + datas[i].meetName,
                                start: arr[0], // will be parsed
                                textColor: '#fff',
                                backgroundColor: BColor
                            });
                        }
                        $('#meentingDate')[0].scrollTop = $('.fc-header-title')[0].offsetTop + $('.fc-header').height()
                        callback(events);

                    }
                });
            },
            dayClick: function (date, allDay, jsEvent, view) {
                //查是否有权限使用提醒
                var timestamp = Date.parse(new Date());
                var timer = parseInt(timestamp) + 7200000;
                var startTime = new Date(timestamp).Format('hh:mm:ss');
                var endTime = new Date(timer).Format('hh:mm:ss');
                var dayMonth = new Date().getMonth()+1;
                var dayDate = new Date().getDate();
                var clickDate=allDay.currentTarget.dataset.date;
                var clickMonth=clickDate.split('-')[1];
                var clickDay =clickDate.split('-')[2]
                if(dayMonth<clickMonth){}
                else if(dayMonth=clickMonth){
                    if(clickDay<dayDate){
                        layer.msg('<fmt:message code="meeting.selectNotExpiredTime" />',{icon: 0})
                        return false
                    }}
                else{
                    layer.msg('<fmt:message code="meeting.selectNotExpiredTime" />',{icon: 0})
                    return false
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.ConferenceApplication" />', 'background-color:#2b7fe0;color:#fff;'],
                    // area: ['600px', '460px'],
                    area: ['830px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="div_table" style="">' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="workflow.th.name" />：</span>' +
                        '<span><input type="text" style="width: 70%;margin-left:5px;" id="meetName" name="typeName" class="inputTd meetName test_null" value="" /></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="email.th.main" />：</span>' +
                        '<span><input type="text" style="width: 70%;margin-left:5px;" id="subject" name="typeName" class="inputTd subject test_null" value="" /></span>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span>' +
                        '<span>' +
                        '<div class="inPole" style="width: 70%;">' +
                        '<textarea name="txt" dataid="" class="userName test_null onlyOne" id="userDuser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>' +
                        // '<span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span>' +
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meeting.contactPhone" />：</span>' +
                        '<span><input type="text" style="width: 70%;margin-left:5px;" id="mobileNo" name="typeName" maxlength="11" class="inputTd mobileNo test_null" value="" /></span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span>' +
                        '<span>' +
                        '<div class="inPole" style="width:70%;"><textarea name="txt" dataid="" class="recorderName onlyOne" id="recoderDuser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span>' +
                        '</div>' +
                        '</span>' +
                        '</div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meeting.isCyclicTransaction" />：</span> ' +
                        '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="1"><fmt:message code="global.yes" /></span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="0"><fmt:message code="global.no" /></span></div>' +
                        '<div class="div_tr" id="time_div1" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议日期：</span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.from" /></span><span><input type="text" style="width: 140px;" name="cycleStartDate" id="cycleStartDate" class="inputTd startTime test_null" value="' + date._i + '" /></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span><input type="text" style="width: 140px;" name="cycleEndDate" class="endTime test_null" id="cycleEndDate" value="' + date._i + '"  /></span>' +
                        '</div>' +
                        '<div class="div_tr time_div0" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议时间：</span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.from" /></span><span><input type="text" style="width: 140px;" name="cycleStartTime" id="cycleStartTime" class="inputTd startTime test_null" value="08:30:00"  /></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span><input type="text" style="width: 140px;" name="cycleEndTime" class="endTime test_null" id="cycleEndTime" value="09:00:00" /></span>' +
                        '</div>' +
                        '<div class="div_tr time_div0" style="display:none">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="application_config.application_week" />：</span>' +
                        '<span id="WEEKEND0" class="WEEKEND" style="display:none"><input type="checkbox" name="W7" value="1" num="7"><fmt:message code="application_config.sunday" /></span>\n' +
                        '<span id="WEEKEND1" class="WEEKEND" style="display:none"><input type="checkbox" name="W1" value="1" num="1"><fmt:message code="application_config.monday" /></span>\n' +
                        '<span id="WEEKEND2" class="WEEKEND" style="display:none"><input type="checkbox" name="W2" value="1" num="2"><fmt:message code="application_config.tuesday" /></span>\n' +
                        '<span id="WEEKEND3" class="WEEKEND" style="display:none"><input type="checkbox" name="W3" value="1" num="3"><fmt:message code="application_config.wednesday" /></span>\n' +
                        '<span id="WEEKEND4" class="WEEKEND" style="display:none"><input type="checkbox" name="W4" value="1" num="4"><fmt:message code="application_config.thursday" /></span>\n' +
                        '<span id="WEEKEND5" class="WEEKEND" style="display:none"><input type="checkbox" name="W5" value="1" num="5"><fmt:message code="application_config.friday" /></span>\n' +
                        '<span id="WEEKEND6" class="WEEKEND" style="display:none"><input type="checkbox" name="W6" value="1" num="6"><fmt:message code="application_config.saturday" /></span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span>' +
                        '<span><select style="width: 42%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span>' +
                        '<span style="margin-left: 10px"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span>' +
                        '<span style="margin-left: 10px"><a href="javascript:;" class="useSituation"><fmt:message code="meeting.conferenceRoomUsage" /></a></span>' +
                        '</div>' +
                        '<div class="div_tr" id="time_div2">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.from" /></span><span><input type="text" style="width: 150px; height: 40px;" name="typeName" id="beginTime" class="inputTd startTime test_null" autocomplete="off"/></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                        '<span><input type="text" style="width: 150px; height: 40px;" name="typeName" class="endTime test_null" id="endTime" autocomplete="off"/></span>' +
                        '</div>' +
                        '<div class="div_tr time_div0">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;"></span><fmt:message code="meeting.signInTime" />：</span>' +
                        '<span style="margin-left: 5px;"><input type="text" style="width: 140px;margin-left: 0 0 0 10px;" name="signInTime" id="signInTime" class="inputTd  test_null"/></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="meeting.signInTimeRange" /></span>' +
                        '</div>' +
                        '<div class="div_tr isVideo"><span class="span_td"><fmt:message code="meeting.isVideoConference" />：</span> ' +
                        '<span><input style="height:auto;margin-top: 2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1" ><fmt:message code="global.yes" /></span>' +
                        '<span style="margin-left: 10px;"><input style="height:auto;margin-top: 2px;vertical-align: text-top;"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" ><fmt:message code="global.no" /></span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ApprovalAdministrator" />：</span>' +
                        '<span><select style="width: 42%;" name="typeName" class="managerId test_null" id="managerId"></select></span>' +
                        '</div>' +
                        '<div class="div_tr">' +
                        '<span class="span_td"><fmt:message code="meet.th.external" />:</span><span><div class="inPole" style="width:70%;"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 84%;min-height:58px;resize: vertical;"></textarea></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.internal" />:</span><span><div class="inPole" style="width:70%;">' +
                        '<textarea name="txt" class="attendee test_null" id="attendeeDuser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>' +
                        '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        /*前台会议服务人员*/
                        ' <div class="div_tr"><span class="span_td" style="width:125px"><fmt:message code="meeting.frontDeskServiceStaff" />:</span><span>\n' +
                        '            <div class="inPole" style="width:70%;">\n' +
                        '                <textarea name="serviceUser" id="serviceUser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>\n' +
                        '                <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addServiceUser">\n' +
                        '                        <fmt:message code="global.lang.add" /></a></span><span class="add_img"\n' +
                        '                    style="margin-left: 6px"><a href="javascript:;" id="clearServiceUser">\n' +
                        '                        <fmt:message code="global.lang.empty" /></a></span></div>\n' +
                        '        </span>\n' +
                        '    </div>\n' +
                        '    <div class="div_tr">\n' +
                        '        <span class="span_td" style="width:125px">\n' +
                        '            <fmt:message code="meet.th.ConferenceRoomEquipment" />：</span>\n' +
                        '            <span>\n' +
                        '            <div class="inPole" style="width:70%;"><textarea name="txt" id="equipmentId" class="equipmentId"   equipmentId="" disabled style="resize:none;width: 84%;min-height:60px;">\n' +
                        '            </textarea>\n' +
                        '        </span>\n' +
                        '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addEquipment" class="addEquipment">\n' +
                        '                <fmt:message code="global.lang.add" /></a></span>\n' +
                        '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="clearEquipment"     class="clearEquipment">\n' +
                        '                <fmt:message code="global.lang.empty" /></a></div></span></div>\n' +
                        '    <div class="div_tr"><span class="span_td">\n' +
                        '            <fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" checked="true" id="isWriteCalendar" class="isWriteCalendar"></span><span>\n' +
                        '            <fmt:message code="meet.th.Yes" /></span></div>\n' +
                        '    <div class="div_tr" id="reminds"><span class="span_td">\n' +
                        '            <fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind"  class="smsRemind"></span><span style="margin-right: 10px;"><fmt:message code="meeting.transactionNotice" /></span>\n' +
                        '            <span><input type="checkbox"\n' +
                        '                id="sms2Remind" class="sms2Remind"></span><span>\n' +
                        '            <fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;">\n' +
                        '            <fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour"   id="resendHour" class="resendHour"><span>\n' +
                        '            <fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute"   id="resendMinute"><span>\n' +
                        '            <fmt:message code="meet.th.Reminder" /></span></div>\n' +
                        //是否开启手写打卡
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meeting.isHandwritingSign" />：</span> ' +
                        '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" name="handwritingSignYn" class="handwritingSignYn" value="1"><fmt:message code="global.yes" /></span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="handwritingSignYn" class="handwritingSignYn" value="0"><fmt:message code="global.no" /></span></div>' +
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label"><fmt:message code="meeting.agendaAttachment" />:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '    </div>\n' +
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label"><fmt:message code="meeting.attachment" />:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '    </div>\n' +
                        '    <div class="div_tr">\n' +
                        '        <span class="span_td">\n' +
                        '            <fmt:message code="meet.th.ConferenceDescription" />：</span><span>\n' +
                        '            <div class="inPole" style="width: 70%;">\n' +
                        '                <textarea name="meetDesc" id="meetDesc" class="meetDesc" value=""  style="width: 84%;min-height:60px;resize: vertical;">     </textarea>\n' +
                        '        </div>\n' +
                        '        </span>\n' +
                        '    </div>\n' +
                        '    </div>',
                    success: function () {

                        fileuploadFn('#fileupload', $('#fileAll'));
                        // 会议议程附件
                        fileuploadFn('#fileuploadAgenda', $('#fileAllAgenda'));
                        //判断是否显示视频会议
                        $.ajax({
                            type: 'get',
                            url: '/ShowDownLoadQrCode',
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag) {
                                    if (res.object != '0') {
                                        $('#meetRoomId option:last').remove()
                                        $('.isVideo').hide()
                                    }
                                }
                            }
                        })

                        laydate.render({
                            elem: '#signInTime'
                            , type: 'datetime'
                            ,trigger:'click'
                            ,format:'yyyy-MM-dd HH:mm:ss'
                        });
                        laydate.render({
                            elem: '#beginTime'
                            , type: 'datetime'
                            , value: date._i + ' 09:00:00'
                            , trigger:'click'
                            ,format:'yyyy-MM-dd HH:mm:ss'
                            , done: function (value, date) {
                                var ddYest = dateYest()
                                if (value <= ddYest) {

                                    $.layerMsg({content: '申请时间的开始时间请选择今天以后的时间!', icon: 0})
                                }
                            }
                        });
                        laydate.render({
                            elem: '#endTime'
                            , type: 'datetime'
                            , value: date._i + ' 00:00:00'
                            ,format:'yyyy-MM-dd HH:mm:ss'
                            , trigger:'click'
                            , done: function (value, date, endDate) {
                                //判断会议室是否被占用
                                $.get('/meeting/judgeMeeting', {
                                    meetRoomId: $('#meetRoomId').val(),
                                    startTime: $('#beginTime').val(),
                                    endTime: value
                                }, function (res) {
                                    if (res.code == 1) {
                                        $.layerMsg({content: res.msg, icon: 0})
                                        return false
                                    }
                                })
                            }
                        });
                        laydate.render({
                            elem: '#cycleStartDate'
                            ,trigger:'click'
                            ,format:'yyyy-MM-dd'
                            , done: function (value, date) {
                                week_select()
                            }
                        });
                        laydate.render({
                            elem: '#cycleEndDate'
                            ,trigger:'click'
                            ,format:'yyyy-MM-dd'
                            , done: function (value, date) {
                                week_select()
                            }
                        });
                        //时间选择器
                        laydate.render({
                            elem: '#cycleStartTime'
                            , type: 'datetime'
                            ,trigger:'click'
                            ,format:'HH:mm:ss'
                        });
                        laydate.render({
                            elem: '#cycleEndTime'
                            , type: 'datetime'
                            , trigger:'click'
                            ,format:'HH:mm:ss'
                        });
                        $.ajax({
                            url: '/Meetequipment/getuser',
                            type: 'get',
                            dataType: 'json',
                            success: function (res) {
                                $('#userDuser').attr('user_id', res.object.userId + ',');
                                $('#userDuser').attr('dataid', res.object.uid + ',');
                                $('#userDuser').val(res.object.userName + ',');
                                //自动获取当前登录人手机号
                                $('.mobileNo').val(res.object.mobilNo)

                                //会议纪要员默认为申请人
                                $('#recoderDuser').attr('user_id', res.object.userId + ',');
                                $('#recoderDuser').attr('dataid', res.object.uid + ',');
                                $('#recoderDuser').val(res.object.userName + ',');
                            }
                        })

                        $('input[name="isCycle"]').on("click",function () {
                            if ($(this).val() == '1') {
                                $('#time_div2').css("display", "none")
                                //隐藏后移除必填类
                                $('#beginTime').removeClass('test_null')
                                $('#endTime').removeClass('test_null')
                                $('#time_div1').css("display", "block")
                                $('.time_div0').css("display", "block")

                                week_select()

                            } else {
                                $('#time_div2').css("display", "block")
                                //显示后添加必填类
                                $('#beginTime').addClass('test_null')
                                $('#endTime').addClass('test_null')
                                $('#time_div1').css("display", "none")
                                $('.time_div0').css("display", "none")

                            }
                        });
                        //会议室
                        initMeetRoom();
                        $('#meetRoomId').on("change",function () {
                            var opvalue = $(this).val();
                            if (opvalue === '0') {
                                $("input[name='isVideo']").each(function (index, item) {
                                    $(this).prop("disabled", true);
                                    if (index === 0) {
                                        $(this).prop("checked", true);
                                    }
                                });
                            } else {
                                //initManager($(this).val());
                                $("input[name='isVideo']").each(function () {
                                    $(this).prop("disabled", false);
                                });
                                initManager(opvalue)
                            }
                        });
                        if (!$('#meetRoomId').val()) {
                            layer.msg('<fmt:message code="meeting.noAvailableRoom.contactAdmin" />', {icon: 0});
                            return false
                        }
                        initManager($('#meetRoomId').val());

                        //点击会议室名称显示会议室详情
                        $('.meetRoomDetail').on("click",function () {
                            var ismeetRoom = $('#meetRoomId').val();
                            if (ismeetRoom === '0') {
                                $.layerMsg({content: "暂无会议室详情", icon: 2});
                                return false;
                            }
                            $.ajax({
                                url: '/meetingRoom/getMeetRoomBySid',
                                type: 'get',
                                dataType: 'json',
                                data: {
                                    sid: $(".meetRoomId").val()
                                },
                                success: function (obj) {
                                    if (obj.flag == true) {
                                        var data = obj.object;
                                        var meetList = data.meetingWithBLOBs;
                                        var str = '<div class="table"><table style="margin:auto;">' +
                                            '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>' + data.mrName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>' + data.mrDesc + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>' + data.managetnames + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>' + data.meetroomdeptName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>' + data.meetroompersonName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>' + data.mrCapacity + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>' + data.mrDevice + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>' + data.mrPlace + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                            '<td>' +
                                            '<table>' +
                                            '<tr>' +
                                            '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                            '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                            '<td><fmt:message code="sup.th.startTime" /></td>' +
                                            '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                            '<td><fmt:message code="notice.th.state" /></td>' +
                                            '<tr>';
                                        for (var i = 0; i < meetList.length; i++) {
                                            str += '<tr>' +
                                                '<td>' + meetList[i].meetName + '</td>' +
                                                '<td>' + meetList[i].userName + '</td>' +
                                                '<td>' + meetList[i].startTime + '</td>' +
                                                '<td>' + meetList[i].endTime + '</td>' +
                                                '<td>' + meetList[i].statusName + '</td>' +
                                                '<td>' + meetList[i].statusName + '</td>' +
                                                '</tr>'
                                        }
                                        str += '</table></td></tr>' +
                                            '</table></div>';
                                        layer.open({
                                            type: 1,
                                            title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                            area: ['900', '460px'],
                                            offset: ['60px', '200px'],
                                            shadeClose: true, //点击遮罩关闭
                                            btn: ['<fmt:message code="global.lang.close" />'],
                                            content: str
                                        })
                                    } else {
                                        $.layerMsg({content: "暂无会议室详情", icon: 2});
                                    }
                                }
                            })
                        })

                        $('.useSituation').on("click",function (){
                            layer.open({
                                type: 1,
                                title:'<fmt:message code="meeting.conferenceRoomUsage" />',
                                content:
                                    '<div id="fullCandar">'+
                                    '<div class="leftBtn">'+
                                    '<span class="leftBtnOne"></span>'+
                                    ' <span class="leftBtnTwo"><fmt:message code="notice.th.Today" /></span>'+
                                    '<span class="leftBtnThr"></span>'+
                                    ' </div>'+
                                    ' <div class="fullTime">'+
                                    '<span class="spanTime"><input type="text" class="layui-input" id="timeChoose"></span>'+
                                    '</div>'+
                                    '<div class="colorClass">'+
                                    '<a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>'+
                                    ' <span><fmt:message code="meet.th.PendingApproval" /></span>'+
                                    ' <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>'+
                                    '<span><fmt:message code="meet.th.Ratified" /></span>'+
                                    '<a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>'+
                                    '<span><fmt:message code="meet.th.HaveHand" /></span>'+
                                    ' <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>'+
                                    '<span><fmt:message code="meet.th.unratified" /></span>'+
                                    '<a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>'+
                                    '<span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>'+
                                    ' </div>'+
                                    '</div>'+
                                    '<div class="div_room" style="padding-left: 20px;box-sizing: border-box;"></div>',
                                area:['100%','100%'],
                                offset:'auto',
                                btnAlign: 'c',
                                success:function(){
                                    var chooseTime = ''

                                    //时间增加按钮
                                    $('.leftBtnThr').on("click",function(){
                                        var chooseTime = $("#timeChoose").val();
                                        var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() + 86400000));
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(encodeURI(timeStr));
                                    })

                                    $('.leftBtnTwo').on("click",function(){
                                        var timeStr = new Date().toLocaleString('zh', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\//g, '-')
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(timeStr);
                                    })
                                    //时间减少按钮
                                    $('.leftBtnOne').on("click",function(){
                                        var chooseTime = $("#timeChoose").val();
                                        var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() - 86400000));
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(timeStr);
                                    })
                                    laydate.render({
                                        elem: '#timeChoose', //指定元素
                                        value:new Date(),
                                        done: function(value, date, endDate){ // 选择完毕的回调
                                            chooseTime = value
                                            getAllRoom(value)
                                        }
                                    });
                                    var timeStr = dateHandling();
                                    getAllRoom(timeStr);
                                }
                            })
                        })
                        //是否有权限使用事务、短信提醒
                        $.ajax({
                            type: 'get',
                            url: '/smsRemind/getRemindFlag',
                            dataType: 'json',
                            data: {
                                type: 8
                            },
                            success: function (res) {
                                if (res.flag) {
                                    if (res.obj.length > 0) {
                                        var data = res.obj[0];
                                        // 是否默事务提醒认发送
                                        if (data.isRemind == '0') {
                                            $('.smsRemind').prop("checked", false);
                                        } else if (data.isRemind == '1') {
                                            $('.smsRemind').prop("checked", true);
                                        }
                                        // 是否手机短信默认提醒
                                        if (data.isIphone == '0') {
                                            $('.sms2Remind').prop("checked", false);
                                        } else if (data.isIphone == '1') {
                                            $('.sms2Remind').prop("checked", true);
                                        }
                                        // 是否允许发送事务提醒
                                        if (data.isCan == '0') {
                                            $('#reminds').hide();
                                            $('.smsRemind').prop("checked", false);
                                            $('.sms2Remind').prop("checked", false);
                                            // $('.remind').parent('tr').hide();

                                        }

                                    }
                                }
                            }
                        })
                    },
                    yes: function (index) {
                        var array = $(".test_null");
                        var attendId = '';
                        var attendName = '';
                        for (var i = 0; i < $('.onlyOne').length; i++) {
                            if ($('.onlyOne').eq(i).val().split(',').length > 2) {
                                $.layerMsg({
                                    content: $('.onlyOne').eq(i).parent().parent().prev().text().substr(0, $('.onlyOne').eq(i).parent().parent().prev().text().length - 1) + '只能选一个！',
                                    icon: 2
                                }, function () {
                                });
                                return;
                            }
                        }

                        var isWriteCalednar = 0;
                        if ($('#isWriteCalendar').is(':checked')) {
                            isWriteCalednar = 1;
                        }
                        var smsRemind = 0;

                        if ($('#smsRemind').is(':checked')) {
                            smsRemind = 1;
                        }
                        var sms2Remind = 0;
                        if ($('#sms2Remind').is(':checked')) {
                            sms2Remind = 1;
                        }
                        var recoder = $(".recorderName").attr("dataid");
                        if (recoder != "") {
                            var recorderId = recoder.substr(0, recoder.length - 1);
                        }
                        var uidId = $(".userName").attr("dataid");
                        if (uidId != "") {
                            var uid = uidId.substr(0, uidId.length - 1);
                        }

                        var attendId = '';
                        var attendName = '';
                        for (var i = 0; i < $('#fileAll .dech').length; i++) {
                            attendId += $('#fileAll .dech').eq(i).find('input').val();
                            attendName += $('#fileAll a').eq(i).attr('name');
                        }
                        // 会议议程附件
                        var attendAgendaId = '';
                        var attendAgendaName = '';
                        for (var i = 0; i < $('#fileAllAgenda .dech').length; i++) {
                            attendAgendaId += $('#fileAllAgenda .dech').eq(i).find('input').val();
                            attendAgendaName += $('#fileAllAgenda a').eq(i).attr('name');
                        }


                        if ($('#meetName').val() == "") {
                            $.layerMsg({content: '名称不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#subject').val() == "") {
                            $.layerMsg({content: '主题不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#userDuser').val() == "") {
                            $.layerMsg({content: '请添加申请人', icon: 2});
                            return false;
                        }
                        if ($('#mobileNo').val() == "") {
                            $.layerMsg({content: '联系电话不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#attendeeDuser').val() == "") {
                            $.layerMsg({content: '请添加出席人员（内部）', icon: 2});
                            return false;
                        }
                        var cycleStartDate = $('#cycleStartDate').val();
                        var cycleEndDate = $('#cycleEndDate').val();
                        var cycleStartTime = $('#cycleStartTime').val();
                        var cycleEndTime = $('#cycleEndTime').val();
                        var signInTime=$("#signInTime").val();
                        var cycleWeek = '';
                        if ($('.isCycle:checked').val() == '0') {
                            cycleStartDate = '', cycleEndDate = '', cycleStartTime = '', cycleEndTime = '';
                        } else {
                            var $thisweek = $('.WEEKEND input[type=checkbox]:checked');
                            for (var i = 0; i < $thisweek.length; i++) {
                                if (i == $thisweek.length - 1) {
                                    cycleWeek += $thisweek.eq(i).attr('num');
                                } else {
                                    cycleWeek += $thisweek.eq(i).attr('num') + ',';
                                }
                            }
                        }


                        var paraData = {
                            mobileNo: $('.mobileNo').val(),
                            cycle: $('.isCycle:checked').val(),
                            cycleStartDate: cycleStartDate,
                            cycleEndDate: cycleEndDate,
                            cycleStartTime: cycleStartTime,
                            cycleEndTime: cycleEndTime,
                            cycleWeek: cycleWeek,
                            meetName: $(".meetName").val(),
                            subject: $(".subject").val(),
                            uid: uid,
                            recorderId: recorderId,
                            startTime: $("#beginTime").val(),
                            endTime: $("#endTime").val(),
                            attendeeOut: $(".attendeeOut").val(),
                            attendee: $(".attendee").attr("dataid"),
                            isWriteCalednar: isWriteCalednar,
                            smsRemind: smsRemind,
                            sms2Remind: sms2Remind,
                            resendHour: $(".resendHour").val(),
                            resendMinute: $(".resendMinute").val(),
                            meetDesc: $(".meetDesc").val(),
                            managerId: $("#managerId").val(),
                            meetRoomId: $("#meetRoomId").val(),
                            equipmentNames: $(".equipmentId").val(),
                            equipmentIds: $(".equipmentId").attr("equipmentId"),
                            attachmentId: attendId,
                            signInTime:signInTime,
                            attachmentName: attendName,
                            agendaId: attendAgendaId,
                            agendaName: attendAgendaName,
                            videoConfFlag: $('.isVideo:checked').val(),
                            serviceUser: $("#serviceUser").attr("dataid"),
                            handwritingSignYn: $('.handwritingSignYn:checked').val(),
                        }
                        //开始时间必须大于当前时间
                        if ($('#time_div2').css('display') != 'none') {
                            var ddYest = dateYest()
                            if ($("#beginTime").val() <= ddYest) {
                                $.layerMsg({content: '申请时间的开始时间请选择今天以后的时间!', icon: 0})
                                return;
                            }
                            if (new Date($("#beginTime").text()) < new Date()) {
                                $.layerMsg({content: "开始时间必须大于当前时间", icon: 2}, function () {
                                });
                                return;
                            }
                            //结束时间必须大于开始时间
                            if ($("#beginTime").val() > $("#endTime").val()) {
                                $.layerMsg({content: "结束时间必须大于开始时间", icon: 2}, function () {
                                });
                                return;
                            }
                            if($("#beginTime").val()==$("#endTime").val()){
                                $.layerMsg({content: "开始时间和结束时间不能相同", icon: 2}, function () {
                                });
                                return;
                            }
                        }
                        $.ajax({
                            url: '/meeting/insertMeeting',
                            type: 'post',
                            dataType: 'json',
                            data: paraData,
                            success: function (obj) {
                                debugger
                                if (obj.flag) {
                                    if (obj.msg == "申请成功") {
                                        console.log('--------------')
                                        console.log($('.mobileNo').val())
                                        $.layerMsg({content: '<fmt:message code="sup.th.SuccessfulApplication" />！', icon: 1}, function () {

                                            //更新列表
                                            listByStatus(queryStatus);
                                        })
                                        location.reload();
                                        layer.close(index);
                                    }debugger
                                } else {
                                    alert('<fmt:message code="meet.th.Occupied" />');
                                }
                            }
                        })
                    }
                });
                $('#uploadinputimg').fileupload({
                    dataType: 'json',
                    done: function (e, data) {
                        if (data.result.obj != '') {
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl + '"><a href="/download?' + encodeURI(data[i].attUrl) + '" NAME="' + data[i].attachName + '*"><img style="margin-right:5px;vertical-align: text-bottom;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.Attachment').append(str);
                        } else {
                            //alert('添加附件大小不能为空!');
                            layer.alert('添加附件大小不能为空!', {}, function () {
                                layer.closeAll();
                            });
                        }
                    }
                });

                //查询所有办公设备
                var equipStr = '';
                $.ajax({
                    url: '/Meetequipment/getAllEquiet',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        var data = obj.obj;
                        for (var i = 0; i < data.length; i++) {
                            equipStr += '<tr><td class="equipClick" equipmentid="' + data[i].sid + '">' + data[i].equipmentName + '</td></tr>';
                        }
                    }
                })
                //选择办公设备控件
                $(".addEquipment").on("click",function () {
                    layer.open({
                        type: 1,
                        title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['300px', '500px'],
                        offset: ['30px', '400px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.ok" />'],
                        content: '<table class="equip">' +
                            '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>' +
                            '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>' +
                            '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>' +
                            equipStr +
                            '</table>',
                        success: function () {
                            $(".equipClick").on("click",function () {
                                $(this).toggleClass('equipSpan');
                            })
                            $("#addAll").on("click",function () {
                                $(".equipClick").addClass('equipSpan');
                            })
                            $("#delAll").on("click",function () {
                                $(".equipClick").removeClass('equipSpan');
                            })
                        },
                        yes: function (index) {
                            var equipSpanArray = $(".equipSpan");
                            var equipId = "";
                            var equipName = "";
                            for (var i = 0; i < equipSpanArray.length; i++) {
                                equipName += $(equipSpanArray[i]).html() + ",";
                                equipId += $(equipSpanArray[i]).attr("equipmentid") + ",";
                            }
                            $(".equipmentId").attr("equipmentId", equipId);
                            $(".equipmentId").val(equipName);
                            layer.close(index);
                        }

                    })
                })
                $(".clearEquipment").on("click",function () {
                    $(".equipmentId").attr("equipmentId", "");
                    $(".equipmentId").val("");
                })


                function getAllRoom(timeStr,){
                    var boxLoad = loading = layer.load(1, {
                        shade: [0.8,'#fff'],
                    });
                    $.ajax({
                        type:'get',
                        url:'/meetingRoom/getUserRoomCondition',
                        dataType:'json',
                        data:{currentDate:timeStr},
                        success:function(res){
                            layer.close(boxLoad);
                            var data=res.obj;
                            var tableStr='';
                            if(data.length>0){
                                tableStr = "<table class='TableBlock_page' width='100%'  style='margin-top:20px'><tbody id='listTbody'>";
                                tableStr = tableStr + "<tr class='TableHeader' id='tbl_header'>"
                                    + "<td width='200px' class='oneTd' style='text-align: left;padding: 10px;'><fmt:message code="meet.th.ConferenceRoomName-time" /></td>";
                                for(var i = 0;i<24 ; i++){
                                    tableStr = tableStr  + "<td width='28px'style='padding: 10px 0;text-align: left;' id='HOUR_"+i+"'>" + i + "</td>";
                                }
                                tableStr = tableStr +"</tr>";
                                for (var j=0;j<data.length;j++){
                                    tableStr = tableStr + "<tr class=''>"
                                        + "<td width='200px' align='left' class='TableData' style='text-align: left;padding: 0 0 0 10px;'>" + data[j].mrName + "</td>";
                                    tableStr = tableStr  + "<td width='' align='' colspan='24' name='MEET_ROOM_TD' id='MEET_ROOM_" + data[j].sid  +"' style='position: relative;height: 50px;'></td>";
                                    tableStr = tableStr + "</tr>";
                                }
                                tableStr = tableStr + "<tbody></table>";
                            }else{
                                tableStr='<div style="width: 100%;height: 60px;text-align: center;line-height: 60px;font-size: 16px;border:#ccc 1px solid;"><fmt:message code="meet.th.NoConferenceRoom" /></div>'
                            }
                            $(".div_room").html(tableStr);

                            $("td[name='MEET_ROOM_TD']").empty();
                            var widthTd=$("td[name='MEET_ROOM_TD']").width();
                            var presonWidth=parseInt(widthTd/24);

                            for(var i=0;i<data.length;i++){
                                var dataChild=data[i].meetingWithBLOBs;
                                var str='';
                                if(dataChild.length>0){
                                    for(var j=0;j<dataChild.length;j++){
                                        var starTime=dataChild[j].startTime.substr(11,5);  //显示的开始时间
                                        var starFen=dataChild[j].startTime.substr(14,2);  //开始时间的分钟
                                        var endTime=dataChild[j].endTime.substr(11,5);  //显示的结束时间
                                        var offsetL=parseInt(dataChild[j].startTime.substr(11,2));  //开始时间的小时
                                        var endFen=dataChild[j].endTime.substr(14,2);   //结束时间的分钟
                                        var endHour=dataChild[j].endTime.substr(11,2);   //结束时间的小时
                                        if(endFen>30){
                                            endHour=parseInt(endHour)+1;  //如果分钟大于30 ，小时自动+1
                                        }
                                        var borderC='';
                                        if(dataChild[j].status == 1){
                                            borderC='rgb(58, 135, 173)';
                                        }else if(dataChild[j].status == 2){
                                            borderC='rgb(105, 240, 164)';
                                        }else if(dataChild[j].status == 3){
                                            borderC='rgb(255, 136, 124)';
                                        }else if(dataChild[j].status == 4){
                                            borderC='rgb(245, 181, 46)';
                                        }else if(dataChild[j].status == 5){
                                            borderC='rgb(219, 173, 255)';
                                        }
                                        var left=($('#HOUR_0').width() * offsetL ) + ((starFen/60) * $('#HOUR_0').width())
                                        var width=($('#HOUR_0').width() * (endHour - offsetL) )- ((starFen/60) * $('#HOUR_0').width())
                                        str+='<div id="xiangqing" sid="' +dataChild[j].sid+ '" style="width: '+width+'px;float: left;position: absolute;left: '+left+'px;top: 5px;' +
                                            'border:'+borderC+' 1px solid;border-left-width: 5px;border-radius: 5px;margin-left: 5px;">' +
                                            '<div style="text-align: left;">'+starTime+'<br>'+endTime+'</div>' +
                                            '</div>';
                                    }
                                }
                                $('#MEET_ROOM_'+data[i].sid).append(str);
                                $("#xiangqing").unbind("click").bind("click",function(e){
                                    $.ajax({
                                        url: '/meeting/queryMeetingById',
                                        type: 'get',
                                        dataType: 'jsonp',
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

                                            var fileStr = '';
                                            if (data.agendaList && data.agendaList.length > 0) {
                                                for (var i = 0; i < data.agendaList.length; i++) {
                                                    fileStr += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.agendaList[i].attUrl + '">' + data.agendaList[i].attachName + '</a></div>'
                                                }
                                            } else {
                                                fileStr = '';
                                            }

                                            layer.open({
                                                type: 1,
                                                title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                                area: ['600px', '500px'],
                                                shadeClose: true, //点击遮罩关闭
                                                content: '<div class="table"><table style="margin:auto;">' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meeting.contactPhone" />：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span><fmt:message code="global.from" /> &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meeting.frontDeskServiceStaff" />：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meeting.agendaAttachment" />：</span></td><td><span><div class="inPole">' + fileStr + '</div></span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.MySignin" />：</span></td><td><span>' + data.myAttend + '</span></td><tr>' +
                                                    '</table></div>',
                                                success: function () {
                                                    $('.table td').css({
                                                        "overflow": "hidden",
                                                        "text-overflow": "ellipsis",
                                                        "white-space": "nowrap",
                                                        "padding": 0,
                                                        "height": "auto"
                                                    });
                                                    if (data.status == 1 || data.status == 4) {
                                                        $(".layui-layer-btn0").css("display", "none")
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
                                            })}
                                    })
                                })

                            }
                        }
                    })
                }

                $(window).resize( function  () {
                    //当浏览器大小变化时
                        var timeStr = $("#timeChoose").val();
                        getAllRoom(timeStr)
                });



            },
            eventClick: function (calEvent) {
                var sid = calEvent.id;
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.Editorial" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['830px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="div_table" style="margin-left: 15px;">' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 70%;margin-left:5px;" id="meetName" name="typeName" class="inputTd meetName test_null" value="" /></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="email.th.main" />：</span><span><input type="text" style="width: 70%;margin-left:5px;" id="subject" name="typeName" class="inputTd subject test_null" value="" /></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole" style="width: 70%"><textarea  name="txt" class="userName test_null onlyOne" id="userDuser" user_id="" dataid="" value="" disabled style="width: 84%;min-height:60px;resize: none"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meeting.contactPhone" />：</span><span><input type="text" style="width: 70%;margin-left:5px;" maxlength="11" id="mobileNo" name="typeName" class="inputTd mobileNo test_null" value="" /></span></div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole" style="width: 70%;"><textarea name="txt" class="recorderName onlyOne" id="recoderDuser" user_id="" dataid="" value="" disabled style="width: 84%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select style="width: 42%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="margin-left: 10px;"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span><span style="margin-left: 10px"><a href="javascript:;" class="useSituation"><fmt:message code="meeting.conferenceRoomUsage" /></a></span></div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span><span style="margin:0 5px;"><fmt:message code="global.from" /></span><span><input type="text" style="width: 140px;" name="typeName" class="inputTd startTime test_null" value="" /></span><span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span><span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="" /></span></div>' +
                        '<div class="div_tr time_div0">' +
                        '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;"></span><fmt:message code="meeting.signInTime" />：</span>' +
                        '<span style="margin-left: 5px;"><input type="text" style="width: 140px;margin-left: 0 0 0 10px;" name="signInTime" id="signInTime" class="inputTd  test_null"/></span>' +
                        '<span style="margin:0 5px;"><fmt:message code="meeting.signInTimeRange" />/span>' +
                        '</div>' +
                        '<div class="div_tr isVideo"><span class="span_td"><fmt:message code="meeting.isVideoConference" />：</span> ' +
                        '<span><input style="height:auto;margin-top: 2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1" ><fmt:message code="global.yes" /></span>' +
                        '<span style="margin-left: 10px;"><input style="height:auto;margin-top: 2px;vertical-align: text-top;"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" ><fmt:message code="global.no" /></span>' +
                        '</div>' +
                        '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select style="width: 40%;" name="typeName" class="managerId test_null" id="managerId"></select><input type="hidden" id="isOld"></span></div>' +
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole" style="width:70%;"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 84%;min-height:58px;resize:vertical"></textarea></div></span></div>' +
                        '<div class="div_tr"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole" style="width:70%;"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="width: 84%;min-height:60px;resize: none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                        /*前台会议服务人员*/
                        ' <div class="div_tr"><span class="span_td" style="width:125px"><fmt:message code="meeting.frontDeskServiceStaff" />:</span><span>\n' +
                        '            <div class="inPole" style="width:70%;">\n' +
                        '                <textarea name="serviceUser" id="serviceUser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>\n' +
                        '                <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addServiceUser">\n' +
                        '                        <fmt:message code="global.lang.add" /></a></span><span class="add_img"\n' +
                        '                    style="margin-left: 6px"><a href="javascript:;" id="clearServiceUser">\n' +
                        '                        <fmt:message code="global.lang.empty" /></a></span></div>\n' +
                        '        </span>\n' +
                        '    </div>\n' +
                        '    <div class="div_tr">\n' +
                        '        <span class="span_td" style="width:125px">\n' +
                        '            <fmt:message code="meet.th.ConferenceRoomEquipment" />：</span>\n' +
                        '            <span>\n' +
                        '            <div class="inPole" style="width:70%;"><textarea name="txt" id="equipmentId" class="equipmentId"   equipmentId="" disabled style="resize:none;width: 84%;min-height:60px;">\n' +
                        '            </textarea>\n' +
                        '        </span>\n' +
                        '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addEquipment" class="addEquipment">\n' +
                        '                <fmt:message code="global.lang.add" /></a></span>\n' +
                        '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="clearEquipment"     class="clearEquipment">\n' +
                        '                <fmt:message code="global.lang.empty" /></a></div></span></div>\n' +
                        '    <div class="div_tr"><span class="span_td">\n' +
                        '            <fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" checked="true" id="isWriteCalendar" class="isWriteCalendar"></span><span>\n' +
                        '            <fmt:message code="meet.th.Yes" /></span></div>\n' +
                        '    <div class="div_tr" id="reminds"><span class="span_td">\n' +
                        '            <fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind"  class="smsRemind"></span><span style="margin-right: 10px;"><fmt:message code="meeting.transactionNotice" /></span>\n' +
                        '            <span><input type="checkbox"\n' +
                        '                id="sms2Remind" class="sms2Remind"></span><span>\n' +
                        '            <fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;">\n' +
                        '            <fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour"   id="resendHour" class="resendHour"><span>\n' +
                        '            <fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute"   id="resendMinute"><span>\n' +
                        '            <fmt:message code="meet.th.Reminder" /></span></div>\n' +
                        //会议议程附件
                        '<div class="div_tr"><span class="span_td"><fmt:message code="meeting.isHandwritingSign" />：</span> ' +
                        '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" name="handwritingSignYn" class="handwritingSignYn" value="1"><fmt:message code="global.yes" /></span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="handwritingSignYn" class="handwritingSignYn" value="0"><fmt:message code="global.no" /></span></div>' +
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label"><fmt:message code="meeting.agendaAttachment" />:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '    </div>\n' +
                        '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                        '<div class="layui-row">' +
                        '<div class="layui-col-xs12">' +
                        '<div class="layui-form-item layui-form-text">\n' +
                        '    <label class="layui-form-label"><fmt:message code="meeting.attachment" />:</label>\n' +
                        '<div class="layui-input-block" style="padding-top: 9px">\n' +
                        '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                        '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                        '                <img src="../img/mg11.png" alt="">\n' +
                        '                <span>添加附件</span>\n' +
                        '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                        '            </a>\n' +
                        '        </div>' +
                        '  </div>' +
                        '</div>' +
                        '</div>' +
                        '    </div>\n' +
                        '    <div class="div_tr">\n' +
                        '        <span class="span_td">\n' +
                        '            <fmt:message code="meet.th.ConferenceDescription" />：</span><span>\n' +
                        '            <div class="inPole" style="width: 70%;">\n' +
                        '                <textarea name="meetDesc" id="meetDesc" class="meetDesc" value=""  style="width: 84%;min-height:60px;resize: vertical;">     </textarea>\n' +
                        '        </div>\n' +
                        '        </span>\n' +
                        '    </div>\n' +
                        '    </div>',
                    success: function () {

                        laydate.render({
                            elem: '.startTime'
                            , type: 'datetime'
                            ,trigger: 'click' //采用click弹出
                            ,format:'yyyy-MM-dd HH:mm:ss'
                        });
                        laydate.render({
                            elem: '.endTime'
                            ,trigger: 'click' //采用click弹出
                            , type: 'datetime'
                            ,format:'yyyy-MM-dd HH:mm:ss'
                        });
                        fileuploadFn('#fileupload', $('#fileAll'));
                        // 会议议程附件
                        fileuploadFn('#fileuploadAgenda', $('#fileAllAgenda'));
                        //判断是否显示视频会议
                        $.ajax({
                            type: 'get',
                            url: '/ShowDownLoadQrCode',
                            dataType: 'json',
                            success: function (res) {
                                if (res.flag) {
                                    if (res.object != '0') {
                                        $('#meetRoomId option:last').remove()
                                        $('.isVideo').hide()
                                    }
                                }
                            }
                        });
                        //会议室选择下拉初始化
                        initMeetRoom();
                        $('#meetRoomId').on("change",function () {
                            var opvalue = $(this).val();
                            if (opvalue === '0') {
                                $("input[name='isVideo']").each(function (index, item) {
                                    $(this).prop("disabled", true);
                                    if (index === 0) {
                                        $(this).prop("checked", true);
                                    }
                                });
                            } else {
                                //initManager($(this).val());
                                $("input[name='isVideo']").each(function () {
                                    $(this).prop("disabled", false);
                                });
                                initManager(opvalue)
                            }
                        })
                        //审批管理员
                        initManager($('#meetRoomId').val());
                        //回显接口
                        $.ajax({
                            url: '/meeting/queryMeetingById',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                sid: sid
                            },
                            success: function (obj) {
                                var data = obj.object;
                                var str = '';

                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    var attachmentList = data.attachmentList
                                    if (attachmentList != undefined && attachmentList.length > 0) {
                                        for (var i = 0; i < attachmentList.length; i++) {
                                            str += '<div class="dech" deUrl="' + attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId + ',"></div>'
                                        }
                                    } else {
                                        str = '';
                                    }
                                    $('#fileAll').html(str)
                                }
                                // 会议议程附件
                                if (data.agendaList && data.agendaList.length > 0) {
                                    var agendaStr = '';
                                    var attachmentList = data.agendaList
                                    if (attachmentList != undefined && attachmentList.length > 0) {
                                        for (var i = 0; i < attachmentList.length; i++) {
                                            agendaStr += '<div class="dech" deUrl="' + attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId + ',"></div>'
                                        }
                                    } else {
                                        agendaStr = '';
                                    }
                                    $('#fileAllAgenda').html(agendaStr)
                                }

                                if (data.status != 1) {
                                    $('input').attr('disabled', 'disabled')
                                    $('textarea').attr('disabled', 'disabled')
                                    $('select').attr('disabled', 'disabled')
                                    $('.add_img').hide()
                                    $('input[type=file]').attr('disabled', 'disabled')
                                } else {
                                    $('input').removeAttr('disabled')
                                    $('textarea').removeAttr('disabled')
                                    $('select').removeAttr('disabled')
                                    $('.add_img').show()
                                    $('input[type=file]').removeAttr('disabled')
                                }
                                $(".meetName").val(data.meetName);
                                $(".mobileNo").val(data.mobileNo);
                                $(".subject").val(data.subject);
                                $(".userName").val(data.userName);
                                $("#signInTime").val(data.signInTime);
                                $(".userName").attr("dataid", data.uid);
                                $(".userName").attr("user_id", data.userId);
                                $(".recorderName").val(data.recorderName);
                                $(".recorderName").attr("dataid", data.recorderId);
                                $(".recorderName").attr("user_id", data.recorderUserId);
                                $(".startTime").val(data.startTime);
                                $(".endTime").val(data.endTime);
                                $(".attendeeOut").val(data.attendeeOut);
                                $(".attendee").val(data.attendeeName);
                                $(".attendee").attr("dataid", data.attendee);
                                $(".attendee").attr("user_id", data.attendeeUserId);
                                /*$(".equipmentId").val()*/
                                if (data.isWriteCalednar == 1) {
                                    $(".isWriteCalendar").attr("checked", true);
                                }
                                /*回显前台会议服务人员*/
                                $("#serviceUser").val(data.serviceUserName);
                                $("#serviceUser").attr("dataid", data.serviceUser);
                                $("#serviceUser").attr("user_id", data.serviceUserUserId);
                                if (data.smsRemind == 1) {
                                    $(".smsRemind").attr("checked", true)
                                }
                                if (data.sms2Remind == 1) {
                                    $(".sms2Remind").attr("checked", true);
                                }
                                $(".resendHour").val(data.resendHour);
                                $(".resendMinute").val(data.resendMinute);
                                $(".meetDesc").val(data.meetDesc);
                                //会议室
                                $("#meetRoomId").val(data.meetRoomId);
                                initManager($('#meetRoomId').val());
                                $("input[name='isVideo']").each(function (index, item) {
                                    if (data.meetRoomId === 0) {
                                        $(this).prop("disabled", true);
                                        if (index === 0) {
                                            $(this).prop("checked", true);
                                        }
                                    } else {
                                        if (Number(data.videoConfFlag) === index) {
                                            $(this).prop("checked", false);
                                        } else {
                                            $(this).prop("checked", true);

                                        }
                                    }
                                });

                                //审批管理员
                                $("#managerId").val(data.managerId);
                                $('#isOld').val(data.managerId)
                                //initManager(data.meetRoomId,data.managerId);
                                /* var str1='<option value="'+data.managerId+'">'+data.managerName+'</option>';
                                         $("#managerId").html("");
                                         $("#managerId").html(str1);
                                         $("#managerId").val(data.managerId);

                                         $(".equipmentId").val(data.equipmentNames);
                                         $(".equipmentId").attr("equipmentId",data.equipmentIds);
                                         $('.Attachment').append(str);*/

                                laydate.render({
                                    elem: '.startTime'
                                    , type: 'datetime'
                                    , trigger:'click'
                                });
                                laydate.render({
                                    elem: '.endTime'
                                    , type: 'datetime'
                                    , trigger:'click'
                                    , done: function (value, date, endDate) {
                                        //判断会议室是否被占用
                                        $.get('/meeting/judgeMeeting', {
                                            meetRoomId: $('#meetRoomId').val(),
                                            startTime: $('.startTime').val(),
                                            endTime: value
                                        }, function (res) {
                                            if (res.code == 1) {
                                                $.layerMsg({content: res.msg, icon: 0})
                                                return false
                                            }
                                        })
                                    }
                                });

                                //回显是否手写打卡
                                if (data.handwritingSignYn == '0') {
                                    $("[name='handwritingSignYn'][value='0']").attr("checked", "checked")
                                } else {
                                    $("[name='handwritingSignYn'][value='1']").attr("checked", "checked")
                                }
                            }
                        });
                        //点击会议室名称显示会议室详情
                        $('.meetRoomDetail').on("click",function () {
                            var ismeetRoom = $('#meetRoomId').val();
                            if (ismeetRoom === '0') {
                                $.layerMsg({content: "暂无会议室详情", icon: 2});
                                return false;
                            }

                            $.ajax({
                                url: '/meetingRoom/getMeetRoomBySid',
                                type: 'get',
                                dataType: 'json',
                                data: {
                                    sid: $(".meetRoomId").val()
                                },
                                success: function (obj) {
                                    if (obj.flag) {
                                        var data = obj.object;
                                        var meetList = data.meetingWithBLOBs;
                                        var str = '<div class="table"><table style="margin:auto;">' +
                                            '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>' + data.mrName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>' + data.mrDesc + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>' + data.managetnames + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>' + data.meetroomdeptName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>' + data.meetroompersonName + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>' + data.mrCapacity + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>' + data.mrDevice + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>' + data.mrPlace + '</span></td></tr>' +
                                            '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                            '<td>' +
                                            '<table>' +
                                            '<tr>' +
                                            '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                            '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                            '<td><fmt:message code="sup.th.startTime" /></td>' +
                                            '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                            '<td><fmt:message code="notice.th.state" /></td>' +
                                            '<tr>';
                                        for (var i = 0; i < meetList.length; i++) {
                                            str += '<tr>' +
                                                '<td>' + meetList[i].meetName + '</td>' +
                                                '<td>' + meetList[i].userName + '</td>' +
                                                '<td>' + meetList[i].startTime + '</td>' +
                                                '<td>' + meetList[i].endTime + '</td>' +
                                                '<td>' + meetList[i].statusName + '</td>' +
                                                '</tr>'
                                        }
                                        str += '</table></td></tr>' +
                                            '</table></div>';
                                        layer.open({
                                            type: 1,
                                            title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                            area: ['900', '500px'],
                                            shadeClose: true, //点击遮罩关闭
                                            btn: ['<fmt:message code="global.lang.close" />'],
                                            content: str
                                        })
                                    } else {
                                        $.layerMsg({content: "暂无会议室详情", icon: 2}, function () {
                                        });
                                    }
                                }
                            })


                        })
                        $('.useSituation').on("click",function (){
                            layer.open({
                                type: 1,
                                title:'<fmt:message code="meeting.conferenceRoomUsage" />',
                                content:
                                    '<div id="fullCandar">'+
                                    ' <div class="leftBtn">'+
                                    ' <span class="leftBtnOne"></span>'+
                                    ' <span class="leftBtnTwo"><fmt:message code="notice.th.Today" /></span>'+
                                    '  <span class="leftBtnThr"></span>'+
                                    ' </div>'+
                                    ' <div class="fullTime">'+
                                    '  <span class="spanTime"><input type="text" class="layui-input" id="timeChoose"></span>'+
                                    ' </div>'+
                                    ' <div class="colorClass">'+
                                    ' <a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>'+
                                    ' <span><fmt:message code="meet.th.PendingApproval" /></span>'+
                                    ' <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>'+
                                    '  <span><fmt:message code="meet.th.Ratified" /></span>'+
                                    '   <a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>'+
                                    '   <span><fmt:message code="meet.th.HaveHand" /></span>'+
                                    '   <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>'+
                                    '  <span><fmt:message code="meet.th.unratified" /></span>'+
                                    '  <a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>'+
                                    '  <span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>'+
                                    ' </div>'+
                                    '   </div>'+
                                    ' <div class="div_room" style="padding-left: 20px;box-sizing: border-box;"></div>',
                                area:['100%','100%'],
                                offset:'auto',
                                btnAlign: 'c',
                                success:function(){
                                    var chooseTime = ''

                                    //时间增加按钮
                                    $('.leftBtnThr').on("click",function(){
                                        var chooseTime = $("#timeChoose").val();
                                        var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() + 86400000));
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(timeStr);
                                    })

                                    $('.leftBtnTwo').on("click",function(){
                                        var timeStr = new Date().toLocaleString('zh', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\//g, '-')
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(timeStr);
                                    })
                                    //时间减少按钮
                                    $('.leftBtnOne').on("click",function(){
                                        var chooseTime = $("#timeChoose").val();
                                        var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() - 86400000));
                                        laydate.render({
                                            elem: '#timeChoose', //指定元素
                                            value:timeStr,
                                            done: function(value, date, endDate){ // 选择完毕的回调
                                                chooseTime = value
                                                getAllRoom(value)
                                            }
                                        });
                                        getAllRoom(timeStr);
                                    })
                                    laydate.render({
                                        elem: '#timeChoose', //指定元素
                                        value:new Date(),
                                        done: function(value, date, endDate){ // 选择完毕的回调
                                            chooseTime = value
                                            getAllRoom(value)
                                        }
                                    });
                                    var timeStr = dateHandling();
                                    getAllRoom(timeStr);
                                    function getAllRoom(timeStr){
                                        var boxLoad = loading = layer.load(1, {
                                            shade: [0.8,'#fff'],
                                        });
                                        $.ajax({
                                            type:'get',
                                            url:'/meetingRoom/getUserRoomCondition',
                                            dataType:'json',
                                            data:{currentDate:timeStr},
                                            success:function(res){
                                                layer.close(boxLoad);
                                                var data=res.obj;
                                                var tableStr='';
                                                if(data.length>0){
                                                    tableStr = "<table class='TableBlock_page' width='100%'  style='margin-top:20px'><tbody id='listTbody'>";
                                                    tableStr = tableStr + "<tr class='TableHeader' id='tbl_header'>"
                                                        + "<td width='200px' class='oneTd' style='text-align: left;padding: 10px;'><fmt:message code="meet.th.ConferenceRoomName-time" /></td>";
                                                    for(var i = 0;i<24 ; i++){
                                                        tableStr = tableStr  + "<td width='28px'style='padding: 10px 0;text-align: left;' id='HOUR_"+i+"'>" + i + "</td>";
                                                    }
                                                    tableStr = tableStr +"</tr>";
                                                    for (var j=0;j<data.length;j++){
                                                        tableStr = tableStr + "<tr class=''>"
                                                            + "<td width='200px' align='left' class='TableData' style='text-align: left;padding: 0 0 0 10px;'>" + data[j].mrName + "</td>";
                                                        tableStr = tableStr  + "<td width='' align='' colspan='24' name='MEET_ROOM_TD' id='MEET_ROOM_" + data[j].sid  +"' style='position: relative;height: 50px;'></td>";
                                                        tableStr = tableStr + "</tr>";
                                                    }
                                                    tableStr = tableStr + "<tbody></table>";
                                                }else{
                                                    tableStr='<div style="width: 100%;height: 60px;text-align: center;line-height: 60px;font-size: 16px;border:#ccc 1px solid;"><fmt:message code="meet.th.NoConferenceRoom" /></div>'
                                                }
                                                $(".div_room").html(tableStr);

                                                $("td[name='MEET_ROOM_TD']").empty();
                                                var widthTd=$("td[name='MEET_ROOM_TD']").width();
                                                var presonWidth=parseInt(widthTd/24);

                                                for(var i=0;i<data.length;i++){
                                                    var dataChild=data[i].meetingWithBLOBs;
                                                    var str='';
                                                    if(dataChild.length>0){
                                                        for(var j=0;j<dataChild.length;j++){
                                                            var starTime=dataChild[j].startTime.substr(11,5);  //显示的开始时间
                                                            var starFen=dataChild[j].startTime.substr(14,2);  //开始时间的分钟
                                                            var endTime=dataChild[j].endTime.substr(11,5);  //显示的结束时间
                                                            var offsetL=parseInt(dataChild[j].startTime.substr(11,2));  //开始时间的小时
                                                            var endFen=dataChild[j].endTime.substr(14,2);   //结束时间的分钟
                                                            var endHour=dataChild[j].endTime.substr(11,2);   //结束时间的小时
                                                            if(endFen>30){
                                                                endHour=parseInt(endHour)+1;  //如果分钟大于30 ，小时自动+1
                                                            }
                                                            var borderC='';
                                                            if(dataChild[j].status == 1){
                                                                borderC='rgb(58, 135, 173)';
                                                            }else if(dataChild[j].status == 2){
                                                                borderC='rgb(105, 240, 164)';
                                                            }else if(dataChild[j].status == 3){
                                                                borderC='rgb(255, 136, 124)';
                                                            }else if(dataChild[j].status == 4){
                                                                borderC='rgb(245, 181, 46)';
                                                            }else if(dataChild[j].status == 5){
                                                                borderC='rgb(219, 173, 255)';
                                                            }
                                                            var left=($('#HOUR_0').width() * offsetL ) + ((starFen/60) * $('#HOUR_0').width())
                                                            var width=($('#HOUR_0').width() * (endHour - offsetL) )- ((starFen/60) * $('#HOUR_0').width())
                                                            str+='<div id="xiangqing" sid="' +dataChild[j].sid+ '" style="width: '+width+'px;float: left;position: absolute;left: '+left+'px;top: 5px;' +
                                                                'border:'+borderC+' 1px solid;border-left-width: 5px;border-radius: 5px;margin-left: 5px;">' +
                                                                '<div style="text-align: left;">'+starTime+'<br>'+endTime+'</div>' +
                                                                '</div>';
                                                        }
                                                    }
                                                    $('#MEET_ROOM_'+data[i].sid).append(str);
                                                    $("#xiangqing").unbind("click").bind("click",function(e){
                                                        $.ajax({
                                                            url: '/meeting/queryMeetingById',
                                                            type: 'get',
                                                            dataType: 'jsonp',
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

                                                                var fileStr = '';
                                                                if (data.agendaList && data.agendaList.length > 0) {
                                                                    for (var i = 0; i < data.agendaList.length; i++) {
                                                                        fileStr += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.agendaList[i].attUrl + '">' + data.agendaList[i].attachName + '</a></div>'
                                                                    }
                                                                } else {
                                                                    fileStr = '';
                                                                }

                                                                layer.open({
                                                                    type: 1,
                                                                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                                                    area: ['600px', '500px'],
                                                                    shadeClose: true, //点击遮罩关闭
                                                                    content: '<div class="table"><table style="margin:auto;">' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meeting.contactPhone" />：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span><fmt:message code="global.from" /> &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                                                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meeting.frontDeskServiceStaff" />：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meeting.agendaAttachment" />：</span></td><td><span><div class="inPole">' + fileStr + '</div></span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                                                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.MySignin" />：</span></td><td><span>' + data.myAttend + '</span></td><tr>' +
                                                                        '</table></div>',
                                                                    success: function () {
                                                                        $('.table td').css({
                                                                            "overflow": "hidden",
                                                                            "text-overflow": "ellipsis",
                                                                            "white-space": "nowrap",
                                                                            "padding": 0,
                                                                            "height": "auto"
                                                                        });
                                                                        if (data.status == 1 || data.status == 4) {
                                                                            $(".layui-layer-btn0").css("display", "none")
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
                                                                })}
                                                        })
                                                    })
                                                }
                                            }
                                        })
                                    }
                                }
                            })
                        })

                    },
                    yes: function (index) {
                        var array = $(".test_null");
                        var attendId = '';
                        var attendName = '';
                        for (var i = 0; i < $('.onlyOne').length; i++) {
                            if ($('.onlyOne').eq(i).val().split(',').length > 2) {
                                $.layerMsg({
                                    content: $('.onlyOne').eq(i).parent().parent().prev().text().substr(0, $('.onlyOne').eq(i).parent().parent().prev().text().length - 1) + '只能选一个！',
                                    icon: 2
                                }, function () {
                                });
                                return;
                            }
                        }
                        var isWriteCalednar = 0;
                        var attendId = '';
                        var attendName = '';
                        if ($('#isWriteCalendar').is(':checked')) {
                            isWriteCalednar = 1;
                        }
                        var smsRemind = 0;

                        if ($('#smsRemind').is(':checked')) {
                            smsRemind = 1;
                        }
                        var sms2Remind = 0;
                        if ($('#sms2Remind').is(':checked')) {
                            sms2Remind = 1;
                        }
                        var recorderId = $(".recorderName").attr("dataid");
                        if (recorderId != "" && recorderId.indexOf(",") >= 0) {
                            recorderId = recorderId.substr(0, recorderId.length - 1);
                        }
                        var uid = $(".userName").attr("dataid");
                        if (uid != "" && uid.indexOf(",") >= 0) {
                            uid = uid.substr(0, uid.length - 1);
                        }

                        var attendId = '';
                        var attendName = '';
                        for (var i = 0; i < $('#fileAll .dech').length; i++) {
                            attendId += $('#fileAll .dech').eq(i).find('input').val();
                            attendName += $('#fileAll a').eq(i).attr('name');
                        }
                        if ($('#meetName').val() == "") {
                            $.layerMsg({content: '名称不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#subject').val() == "") {
                            $.layerMsg({content: '主题不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#userDuser').val() == "") {
                            $.layerMsg({content: '请添加申请人', icon: 2});
                            return false;
                        }
                        if ($('#mobileNo').val() == "") {
                            $.layerMsg({content: '联系电话不能为空！', icon: 2});
                            return false;
                        }
                        if ($('#attendeeDuser').val() == "") {
                            $.layerMsg({content: '请添加出席人员（内部）', icon: 2});
                            return false;
                        }
                        // 会议议程附件
                        var attendAgendaId = '';
                        var attendAgendaName = '';
                        for (var i = 0; i < $('#fileAllAgenda .dech').length; i++) {
                            attendAgendaId += $('#fileAllAgenda .dech').eq(i).find('input').val();
                            attendAgendaName += $('#fileAllAgenda a').eq(i).attr('name');
                        }

                        var paraData = {
                            sid: sid,
                            meetName: $(".meetName").val(),
                            mobileNo: $(".mobileNo").val(),
                            subject: $(".subject").val(),
                            uid: uid,
                            recorderId: recorderId,
                            startTime: $(".startTime").val(),
                            endTime: $(".endTime").val(),
                            attendeeOut: $(".attendeeOut").val(),
                            attendee: $(".attendee").attr("dataid"),
                            isWriteCalednar: isWriteCalednar,
                            smsRemind: smsRemind,
                            sms2Remind: sms2Remind,
                            resendHour: $(".resendHour").val(),
                            resendMinute: $(".resendMinute").val(),
                            meetDesc: $(".meetDesc").val(),
                            managerId: $("#managerId").val(),
                            meetRoomId: $("#meetRoomId").val(),
                            equipmentNames: $(".equipmentId").val(),
                            equipmentIds: $(".equipmentId").attr("equipmentId"),
                            attachmentId: attendId,
                            attachmentName: attendName,
                            agendaId: attendAgendaId,
                            signInTime:$("#signInTime").val(),
                            agendaName: attendAgendaName,
                            videoConfFlag: $('.isVideo:checked').val(),
                            serviceUser: $("#serviceUser").attr("dataid"),
                            handwritingSignYn: $('.handwritingSignYn:checked').val(),
                        }
                        if ($('#isOld').val() != $("#managerId").val()) {
                            paraData.Status = 1
                        } else {
                            paraData.Status = 0
                        }

                        $.ajax({
                            url: '/meeting/updateMeetingById',
                            type: 'get',
                            dataType: 'json',
                            data: paraData,
                            success: function (obj) {
                                if (obj.flag) {
                                    $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1}, function () {
                                        //更新列表
                                        listByStatus(queryStatus);
                                    })
                                    location.reload();
                                    layer.close(index);
                                }
                            }
                        })
                        layer.close(index);
                    }

                });
                $('#uploadinputimg').fileupload({
                    dataType: 'json',
                    done: function (e, data) {
                        if (data.result.obj != '') {
                            var data = data.result.obj;
                            var str = '';
                            var str1 = '';
                            for (var i = 0; i < data.length; i++) {
                                str += '<div class="dech" deUrl="' + data[i].attUrl + '"><a href="/download?' + encodeURI(data[i].attUrl) + '" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                            }
                            $('.Attachment').append(str);
                        } else {
                            //alert('添加附件大小不能为空!');
                            layer.alert('添加附件大小不能为空!', {}, function () {
                                layer.closeAll();
                            });
                        }
                    }
                });
                //查询所有办公设备
                var equipStr = '';
                $.ajax({
                    url: '/Meetequipment/getAllEquiet',
                    type: 'get',
                    dataType: 'json',
                    success: function (obj) {
                        var data = obj.obj;
                        for (var i = 0; i < data.length; i++) {
                            equipStr += '<tr><td class="equipClick" equipmentid="' + data[i].sid + '">' + data[i].equipmentName + '</td></tr>';
                        }
                    }
                })
                //选择办公设备控件
                $(".addEquipment").on("click",function () {
                    layer.open({
                        type: 1,
                        title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                        area: ['300px', '500px'],
                        shadeClose: true, //点击遮罩关闭
                        btn: ['<fmt:message code="global.lang.ok" />'],
                        content: '<table class="equip">' +
                            '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>' +
                            '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>' +
                            '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>' +
                            equipStr +
                            '</table>',
                        success: function () {
                            $(".equipClick").on("click",function () {
                                $(this).toggleClass('equipSpan');
                            })
                            $("#addAll").on("click",function () {
                                $(".equipClick").addClass('equipSpan');
                            })
                            $("#delAll").on("click",function () {
                                $(".equipClick").removeClass('equipSpan');
                            })
                        },
                        yes: function (index) {
                            var equipSpanArray = $(".equipSpan");
                            var equipId = "";
                            var equipName = "";
                            for (var i = 0; i < equipSpanArray.length; i++) {
                                equipName += $(equipSpanArray[i]).html() + ",";
                                equipId += $(equipSpanArray[i]).attr("equipmentid") + ",";
                            }
                            $(".equipmentId").attr("equipmentId", equipId);
                            $(".equipmentId").val(equipName);
                            layer.close(index);
                        }

                    })
                })
                $(".clearEquipment").on("click",function () {
                    $(".equipmentId").attr("equipmentId", "");
                    $(".equipmentId").val("");
                })
            }
        });
    })

    //初始化会议室下拉列表
    function initMeetRoom() {
        $.ajax({
            url: '../../meetingRoom/getAllMeetRoom',
            type: 'get',
            async: false,
            dataType: 'json',
            success: function (obj) {
                var data = obj.obj;
                var str = "";
                var firstRoomId;
                if (!data.length) {
                    // $('#meetRoomId').attr('noRoom','true')
                    return false
                }
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].sid + '">' + data[i].mrName + '</option>';
                    if (i == 0) {
                        firstRoomId = data[i].sid;
                    }
                }
                if (str === '') {
                    $("input[name='isVideo']").each(function (index, item) {
                        $(this).prop("disabled", true);
                        if (index === 0) {
                            $(this).prop("checked", true);
                        }
                    });
                }
                str += "<option value='0'>视频会议</option>";
                $(".meetRoomId").html(str);
                //initManager(firstRoomId);

            }
        });
    }

    //审批管理员
    function initManager(roomId, managerId) {
        $.ajax({
            url: '/meeting/getManagers',
            type: 'get',
            dataType: 'json',
            async: false,
            data: {
                paraName: "MEETING_MANAGER_TYPE",
                roomId: roomId
            },
            success: function (obj) {
                var data = obj.object;
                var managerArray = data.usersList;
                var str = "";
                for (var i = 0; i < managerArray.length; i++) {
                    if (managerId == undefined) {
                        str += '<option value="' + managerArray[i].uid + '">' + managerArray[i].userName + '</option>';
                    } else if (managerId == managerArray[i].uid) {
                        str += '<option value="' + managerArray[i].uid + '" selected>' + managerArray[i].userName + '</option>';
                    }
                }
                $(".managerId").html(str);
            }
        });
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
        //修改会议
        $('.pagediv').on('click', '.editData', function (event) {
            var sid = $(this).attr("sid");

            event.stopPropagation();
            layer.open({
                type: 1,
                title: ['<fmt:message code="meet.th.ModifyInformation" />', 'background-color:#2b7fe0;color:#fff;'],
                area: ['830px', '500px'],
                shadeClose: true, //点击遮罩关闭
                btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
                content: '<div class="div_table" style="margin-left: 15px;">' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 70%;margin-left: 5px;" id="meetName" name="typeName" class="inputTd meetName test_null" value="" /></span></div>' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="email.th.main" />：</span><span><input type="text" style="width: 70%;margin-left: 5px;" id="subject" name="typeName" class="inputTd subject test_null" value="" /></span></div>' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="userName test_null onlyOne" id="userDuser" user_id="" dataid="" value="" disabled style="width: 84%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="meeting.contactPhone" />：</span><span><input type="text" style="width: 70%;margin-left: 5px;" maxlength="11" id="mobileNo" name="typeName" class="inputTd mobileNo test_null" value="" /></span></div>' +
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="recorderName onlyOne" id="recoderDuser" user_id="" dataid="" value="" disabled style="width: 84%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select style="width: 43%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="margin-left: 10px;"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span><span style="margin-left: 10px"><a href="javascript:;" class="useSituation"><fmt:message code="meeting.conferenceRoomUsage" /></a></span></div>' +

                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span><span style="margin:0 5px;"><fmt:message code="global.from" /></span><span><input type="text" style="width: 140px;" name="typeName" class="inputTd startTime test_null" value="" /></span><span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span><span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="" /></span></div>' +
                    '<div class="div_tr time_div0">' +
                    '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;"></span><fmt:message code="meeting.signInTime" />：</span>' +
                    '<span style="margin-left: 5px;"><input type="text" style="width: 140px;margin-left: 0 0 0 10px;" name="signInTime" id="signInTime" class="inputTd  test_null"/></span>' +
                    '<span style="margin:0 5px;"><fmt:message code="meeting.signInTimeRange" /></span>' +
                    '</div>' +
                    '<div class="div_tr isVideo"><span class="span_td"><fmt:message code="meeting.isVideoConference" />：</span> ' +
                    '<span style="margin-right: 10px;"><input style="height:auto;margin-top:2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1"><fmt:message code="global.yes" /></span>' +
                    '<span><input style="height:auto;margin-top:2px;vertical-align: text-top;" type="radio" checked="true" name="isVideo" class="isVideo" value="0"><fmt:message code="global.no" /></span>' +
                    '</div>' +
                    '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select style="width: 43%;" name="typeName" class="managerId test_null" id="managerId"></select><input type="hidden" id="isOld"></span></div>' +
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole" style="width: 70%"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 84%;min-height:58px;resize:vertical"></textarea></div></span></div>' +

                    '<div class="div_tr"><span style="color: #FF0000;margin-right: 5px;font-size: 16px; vertical-align: middle;">*</span><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole" style="width: 70%"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="width: 84%;min-height:60px;resize:none;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                    /*前台会议服务人员*/
                    ' <div class="div_tr"><span class="span_td" style="width:125px"><fmt:message code="meeting.frontDeskServiceStaff" />:</span><span>\n' +
                    '            <div class="inPole" style="width:70%;">\n' +
                    '                <textarea name="serviceUser" id="serviceUser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>\n' +
                    '                <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addServiceUser">\n' +
                    '                        <fmt:message code="global.lang.add" /></a></span><span class="add_img"\n' +
                    '                    style="margin-left: 6px"><a href="javascript:;" id="clearServiceUser">\n' +
                    '                        <fmt:message code="global.lang.empty" /></a></span></div>\n' +
                    '        </span>\n' +
                    '    </div>\n' +
                    '    <div class="div_tr">\n' +
                    '        <span class="span_td" style="width:125px">\n' +
                    '            <fmt:message code="meet.th.ConferenceRoomEquipment" />：</span>\n' +
                    '            <span>\n' +
                    '            <div class="inPole" style="width:70%;"><textarea name="txt" id="equipmentId" class="equipmentId"   equipmentId="" disabled style="resize:none;width: 84%;min-height:60px;">\n' +
                    '            </textarea>\n' +
                    '        </span>\n' +
                    '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addEquipment" class="addEquipment">\n' +
                    '                <fmt:message code="global.lang.add" /></a></span>\n' +
                    '        <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="clearEquipment"     class="clearEquipment">\n' +
                    '                <fmt:message code="global.lang.empty" /></a></div></span></div>\n' +
                    '    <div class="div_tr"><span class="span_td">\n' +
                    '            <fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" checked="true" id="isWriteCalendar" class="isWriteCalendar"></span><span>\n' +
                    '            <fmt:message code="meet.th.Yes" /></span></div>\n' +
                    '    <div class="div_tr" id="reminds"><span class="span_td">\n' +
                    '            <fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind"  class="smsRemind"></span><span style="margin-right: 10px;"><fmt:message code="meeting.transactionNotice" /></span>\n' +
                    '            <span><input type="checkbox"\n' +
                    '                id="sms2Remind" class="sms2Remind"></span><span>\n' +
                    '            <fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;">\n' +
                    '            <fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour"   id="resendHour" class="resendHour"><span>\n' +
                    '            <fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute"   id="resendMinute"><span>\n' +
                    '            <fmt:message code="meet.th.Reminder" /></span></div>\n' +
                    //是否开启手写打卡
                    '<div class="div_tr"><span class="span_td"><fmt:message code="meeting.isHandwritingSign" />：</span> ' +
                    '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" name="handwritingSignYn" class="handwritingSignYn" value="1"><fmt:message code="global.yes" /></span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="handwritingSignYn" class="handwritingSignYn" value="0"><fmt:message code="global.no" /></span></div>' +
                    '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs12">' +
                    '<div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label"><fmt:message code="meeting.agendaAttachment" />:</label>\n' +
                    '<div class="layui-input-block" style="padding-top: 9px">\n' +
                    '            <div id="fileAllAgenda" style="text-align: left;"></div>\n' +
                    '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '                <img src="../img/mg11.png" alt="">\n' +
                    '                <span>添加附件</span>\n' +
                    '                <input type="file" multiple id="fileuploadAgenda" data-url="../upload?module=meeting" name="file">\n' +
                    '            </a>\n' +
                    '        </div>' +
                    '  </div>' +
                    '</div>' +
                    '</div>' +
                    '    </div>\n' +
                    '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                    '<div class="layui-row">' +
                    '<div class="layui-col-xs12">' +
                    '<div class="layui-form-item layui-form-text">\n' +
                    '    <label class="layui-form-label"><fmt:message code="meeting.attachment" />:</label>\n' +
                    '<div class="layui-input-block" style="padding-top: 9px">\n' +
                    '            <div id="fileAll" style="    text-align: left;"></div>\n' +
                    '            <a href="javascript:;" class="openFile" style="float: left;position:relative">\n' +
                    '                <img src="../img/mg11.png" alt="">\n' +
                    '                <span>添加附件</span>\n' +
                    '                <input type="file" multiple id="fileupload" data-url="../upload?module=meeting" name="file">\n' +
                    '            </a>\n' +
                    '        </div>' +
                    '  </div>' +
                    '</div>' +
                    '</div>' +
                    '    </div>\n' +
                    '    <div class="div_tr">\n' +
                    '        <span class="span_td">\n' +
                    '            <fmt:message code="meet.th.ConferenceDescription" />：</span><span>\n' +
                    '            <div class="inPole" style="width: 70%;">\n' +
                    '                <textarea name="meetDesc" id="meetDesc" class="meetDesc" value=""  style="width: 84%;min-height:60px;resize: vertical;">     </textarea>\n' +
                    '        </div>\n' +
                    '        </span>\n' +
                    '    </div>\n' +
                    '    </div>',
                success: function () {

                    laydate.render({
                        elem: '.startTime'
                        , trigger:'click'
                        , type: 'datetime'
                        ,format:'yyyy-MM-dd HH:mm:ss'
                    });
                    laydate.render({
                        elem: '.endTime'
                        , trigger: 'click'
                        , type: 'datetime'
                        ,format:'yyyy-MM-dd HH:mm:ss'
                    })
                    fileuploadFn('#fileupload', $('#fileAll'));
                    // 会议议程附件
                    fileuploadFn('#fileuploadAgenda', $('#fileAllAgenda'));
                    //判断是否显示视频会议
                    $.ajax({
                        type: 'get',
                        url: '/ShowDownLoadQrCode',
                        dataType: 'json',
                        success: function (res) {
                            if (res.flag) {
                                if (res.object != '0') {
                                    $('#meetRoomId option:last').remove()
                                    $('.isVideo').hide()
                                }
                            }
                        }
                    });

                    //会议室
                    initMeetRoom();
                    $('#meetRoomId').on("change",function () {
                        var opvalue = $(this).val();
                        if (opvalue === '0') {
                            $("input[name='isVideo']").each(function (index, item) {
                                $(this).prop("disabled", true);
                                if (index === 0) {
                                    $(this).prop("checked", true);
                                }
                            });
                        } else {
                            //initManager($(this).val());
                            $("input[name='isVideo']").each(function () {
                                $(this).prop("disabled", false);
                            });
                            initManager(opvalue);
                        }
                    });

                    //审批管理员
                    initManager($('#meetRoomId').val());

                    //回显
                    $.ajax({
                        url: '/meeting/queryMeetingById',
                        type: 'get',
                        dataType: 'json',
                        data: {
                            sid: sid
                        },
                        success: function (obj) {
                            var data = obj.object;
                            var str = '';

                            if (data.attachmentList && data.attachmentList.length > 0) {
                                var attachmentList = data.attachmentList
                                if (attachmentList != undefined && attachmentList.length > 0) {
                                    for (var i = 0; i < attachmentList.length; i++) {
                                        str += '<div class="dech" deUrl="' + attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId + ',"></div>'
                                    }
                                } else {
                                    str = '';
                                }
                                $('#fileAll').html(str)
                            }
                            // 会议议程附件
                            if (data.agendaList && data.agendaList.length > 0) {
                                var agendaStr = '';
                                var attachmentList = data.agendaList
                                if (attachmentList != undefined && attachmentList.length > 0) {
                                    for (var i = 0; i < attachmentList.length; i++) {
                                        agendaStr += '<div class="dech" deUrl="' + attachmentList[i].attUrl + '"><a href="/download?' + attachmentList[i].attUrl + '" NAME="' + attachmentList[i].attachName + '*"><img style="margin-right:10px;" src="/img/attachment_icon.png"/>' + attachmentList[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="/img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + attachmentList[i].aid + '@' + attachmentList[i].ym + '_' + attachmentList[i].attachId + ',"></div>'
                                    }
                                } else {
                                    agendaStr = '';
                                }
                                $('#fileAllAgenda').html(agendaStr)
                            }

                            $(".meetName").val(data.meetName);
                            $(".mobileNo").val(data.mobileNo);
                            $(".subject").val(data.subject);
                            $(".userName").val(data.userName);
                            $(".userName").attr("dataid", data.uid);
                            $(".userName").attr("user_id", data.userId);
                            $(".recorderName").val(data.recorderName);
                            $(".recorderName").attr("dataid", data.recorderId);
                            $(".recorderName").attr("user_id", data.recorderUserId);
                            $(".startTime").val(data.startTime);
                            $(".endTime").val(data.endTime);
                            laydate.render({
                                elem: '.startTime'
                                , type: 'datetime'
                                ,trigger:'click'
                            });
                            laydate.render({
                                elem: '.endTime'
                                , type: 'datetime'
                                ,trigger:'click'
                                , done: function (value, date, endDate) {
                                    //判断会议室是否被占用
                                    $.get('/meeting/judgeMeeting', {
                                        meetRoomId: $('#meetRoomId').val(),
                                        startTime: $('.startTime').val(),
                                        endTime: value
                                    }, function (res) {
                                        if (res.code == 1) {
                                            $.layerMsg({content: res.msg, icon: 0})
                                            return false
                                        }
                                    })
                                }
                            });
                            $(".attendeeOut").val(data.attendeeOut);
                            $(".attendee").val(data.attendeeName);
                            $(".attendee").attr("dataid", data.attendee);
                            $(".attendee").attr("user_id", data.attendeeUserId);
                            if (data.isWriteCalednar == 1) {
                                $(".isWriteCalendar").attr("checked", true);
                            }
                            /*回显前台会议服务人员*/
                            $("#serviceUser").val(data.serviceUserName);
                            $("#serviceUser").attr("dataid", data.serviceUser);
                            $("#serviceUser").attr("user_id", data.serviceUserUserId);
                            if (data.smsRemind == 1) {
                                $(".smsRemind").attr("checked", true)
                            }
                            if (data.sms2Remind == 1) {
                                $(".sms2Remind").attr("checked", true);
                            }
                            $(".resendHour").val(data.resendHour);
                            $(".resendMinute").val(data.resendMinute);
                            $(".meetDesc").val(data.meetDesc);
                            //会议室
                            $("#meetRoomId").val(data.meetRoomId);
                            initManager($('#meetRoomId').val());
                            $("input[name='isVideo']").each(function (index, item) {
                                if (data.meetRoomId === 0) {
                                    $(this).prop("disabled", true);
                                    if (index === 0) {
                                        $(this).prop("checked", true);
                                    }
                                } else {
                                    if (Number(data.videoConfFlag) === index) {
                                        $(this).prop("checked", false);
                                    } else {
                                        $(this).prop("checked", true);

                                    }
                                }
                            });
                            //审批管理员
                            $("#managerId").val(data.managerId);
                            $('#isOld').val(data.managerId)


                            $(".equipmentId").val(data.equipmentNames);
                            $(".equipmentId").attr("equipmentId", data.equipmentIds);
                            $('.Attachment').append(str);

                            //回显是否手写打卡
                            if (data.handwritingSignYn == '0') {
                                $("[name='handwritingSignYn'][value='0']").attr("checked", "checked")
                            } else {
                                $("[name='handwritingSignYn'][value='1']").attr("checked", "checked")
                            }
                        }
                    });

                    //点击会议室名称显示会议室详情
                    $('.meetRoomDetail').on("click",function () {

                        var ismeetRoom = $('#meetRoomId').val();
                        if (ismeetRoom === '0') {
                            $.layerMsg({content: "暂无会议室详情", icon: 2});
                            return false;
                        }

                        $.ajax({
                            url: '/meetingRoom/getMeetRoomBySid',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                sid: $(".meetRoomId").val()
                            },
                            success: function (obj) {
                                if (obj.flag) {
                                    var data = obj.object;
                                    var meetList = data.meetingWithBLOBs;
                                    var str = '<div class="table"><table style="margin:auto;">' +
                                        '<tr><td width="20%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomName" />：</span></td><td><span>' + data.mrName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomDescription" />：</span></td><td><span>' + data.mrDesc + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.MeetingRoomManager" />：</span></td><td><span>' + data.managetnames + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicatioAuthority" />：</span></td><td><span>' + data.meetroomdeptName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.Application" />：</span></td><td><span>' + data.meetroompersonName + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.NumbeAccommodated" />：</span></td><td><span>' + data.mrCapacity + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.EquipmentStatus" />：</span></td><td><span>' + data.mrDevice + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="depatement.th.address" />：</span></td><td><span>' + data.mrPlace + '</span></td></tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApplicationRecord" />：</span></td>' +
                                        '<td>' +
                                        '<table>' +
                                        '<tr>' +
                                        '<td><fmt:message code="meet.th.ConferenceName" /></td>' +
                                        '<td><fmt:message code="sup.th.Applicant" /></td>' +
                                        '<td><fmt:message code="sup.th.startTime" /></td>' +
                                        '<td><fmt:message code="meet.th.EndTime" /></td>' +
                                        '<td><fmt:message code="notice.th.state" /></td>' +
                                        '<tr>';
                                    for (var i = 0; i < meetList.length; i++) {
                                        str += '<tr>' +
                                            '<td>' + meetList[i].meetName + '</td>' +
                                            '<td>' + meetList[i].userName + '</td>' +
                                            '<td>' + meetList[i].startTime + '</td>' +
                                            '<td>' + meetList[i].endTime + '</td>' +
                                            '<td>' + meetList[i].statusName + '</td>' +
                                            '</tr>'
                                    }
                                    str += '</table></td></tr>' +
                                        '</table></div>';
                                    layer.open({
                                        type: 1,
                                        title: ['<fmt:message code="meet.th.SeeDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                        area: ['900', '500px'],
                                        shadeClose: true, //点击遮罩关闭
                                        btn: ['<fmt:message code="global.lang.close" />'],
                                        content: str
                                    })
                                } else {
                                    $.layerMsg({content: "暂无会议室详情", icon: 2}, function () {
                                    });
                                }
                            }
                        })
                    })
                    $('.useSituation').on("click",function (){
                        layer.open({
                            type: 1,
                            title:'<fmt:message code="meeting.conferenceRoomUsage" />',
                            content:
                                '<div id="fullCandar">'+
                                ' <div class="leftBtn">'+
                                ' <span class="leftBtnOne"></span>'+
                                ' <span class="leftBtnTwo"><fmt:message code="notice.th.Today" /></span>'+
                                '  <span class="leftBtnThr"></span>'+
                                ' </div>'+
                                ' <div class="fullTime">'+
                                '  <span class="spanTime"><input type="text" class="layui-input" id="timeChoose"></span>'+
                                ' </div>'+
                                ' <div class="colorClass">'+
                                ' <a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>'+
                                ' <span><fmt:message code="meet.th.PendingApproval" /></span>'+
                                ' <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>'+
                                '  <span><fmt:message code="meet.th.Ratified" /></span>'+
                                '   <a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>'+
                                '   <span><fmt:message code="meet.th.HaveHand" /></span>'+
                                '   <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>'+
                                '  <span><fmt:message code="meet.th.unratified" /></span>'+
                                '  <a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>'+
                                '  <span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>'+
                                ' </div>'+
                                '   </div>'+
                                ' <div class="div_room" style="padding-left: 20px;box-sizing: border-box;"></div>',
                            area:['100%','100%'],
                            offset:'auto',
                            btnAlign: 'c',
                            success:function(){
                                var chooseTime = ''

                                //时间增加按钮
                                $('.leftBtnThr').on("click",function(){
                                    var chooseTime = $("#timeChoose").val();
                                    var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() + 86400000));
                                    laydate.render({
                                        elem: '#timeChoose', //指定元素
                                        value:timeStr,
                                        done: function(value, date, endDate){ // 选择完毕的回调
                                            chooseTime = value
                                            getAllRoom(value)
                                        }
                                    });
                                    getAllRoom(timeStr);
                                })

                                $('.leftBtnTwo').on("click",function(){
                                    var timeStr = new Date().toLocaleString('zh', { year: 'numeric', month: '2-digit', day: '2-digit' }).replace(/\//g, '-')
                                    laydate.render({
                                        elem: '#timeChoose', //指定元素
                                        value:timeStr,
                                        done: function(value, date, endDate){ // 选择完毕的回调
                                            chooseTime = value
                                            getAllRoom(value)
                                        }
                                    });
                                    getAllRoom(timeStr);
                                })
                                //时间减少按钮
                                $('.leftBtnOne').on("click",function(){
                                    var chooseTime = $("#timeChoose").val();
                                    var timeStr = dateHandling(new Date(new Date(chooseTime).getTime() - 86400000));
                                    laydate.render({
                                        elem: '#timeChoose', //指定元素
                                        value:timeStr,
                                        done: function(value, date, endDate){ // 选择完毕的回调
                                            chooseTime = value
                                            getAllRoom(value)
                                        }
                                    });
                                    getAllRoom(timeStr);
                                })
                                laydate.render({
                                    elem: '#timeChoose', //指定元素
                                    value:new Date(),
                                    done: function(value, date, endDate){ // 选择完毕的回调
                                        chooseTime = value
                                        getAllRoom(value)
                                    }
                                });
                                var timeStr = dateHandling();
                                getAllRoom(timeStr);
                                function getAllRoom(timeStr){
                                    var boxLoad = loading = layer.load(1, {
                                        shade: [0.8,'#fff'],
                                    });
                                    $.ajax({
                                        type:'get',
                                        url:'/meetingRoom/getUserRoomCondition',
                                        dataType:'json',
                                        data:{currentDate:timeStr},
                                        success:function(res){
                                            layer.close(boxLoad);
                                            var data=res.obj;
                                            var tableStr='';
                                            if(data.length>0){
                                                tableStr = "<table class='TableBlock_page' width='100%'  style='margin-top:20px'><tbody id='listTbody'>";
                                                tableStr = tableStr + "<tr class='TableHeader' id='tbl_header'>"
                                                    + "<td width='200px' class='oneTd' style='text-align: left;padding: 10px;'><fmt:message code="meet.th.ConferenceRoomName-time" /></td>";
                                                for(var i = 0;i<24 ; i++){
                                                    tableStr = tableStr  + "<td width='28px'style='padding: 10px 0;text-align: left;' id='HOUR_"+i+"'>" + i + "</td>";
                                                }
                                                tableStr = tableStr +"</tr>";
                                                for (var j=0;j<data.length;j++){
                                                    tableStr = tableStr + "<tr class=''>"
                                                        + "<td width='200px' align='left' class='TableData' style='text-align: left;padding: 0 0 0 10px;'>" + data[j].mrName + "</td>";
                                                    tableStr = tableStr  + "<td width='' align='' colspan='24' name='MEET_ROOM_TD' id='MEET_ROOM_" + data[j].sid  +"' style='position: relative;height: 50px;'></td>";
                                                    tableStr = tableStr + "</tr>";
                                                }
                                                tableStr = tableStr + "<tbody></table>";
                                            }else{
                                                tableStr='<div style="width: 100%;height: 60px;text-align: center;line-height: 60px;font-size: 16px;border:#ccc 1px solid;"><fmt:message code="meet.th.NoConferenceRoom" /></div>'
                                            }
                                            $(".div_room").html(tableStr);

                                            $("td[name='MEET_ROOM_TD']").empty();
                                            var widthTd=$("td[name='MEET_ROOM_TD']").width();
                                            var presonWidth=parseInt(widthTd/24);

                                            for(var i=0;i<data.length;i++){
                                                var dataChild=data[i].meetingWithBLOBs;
                                                var str='';
                                                if(dataChild.length>0){
                                                    for(var j=0;j<dataChild.length;j++){
                                                        var starTime=dataChild[j].startTime.substr(11,5);  //显示的开始时间
                                                        var starFen=dataChild[j].startTime.substr(14,2);  //开始时间的分钟
                                                        var endTime=dataChild[j].endTime.substr(11,5);  //显示的结束时间
                                                        var offsetL=parseInt(dataChild[j].startTime.substr(11,2));  //开始时间的小时
                                                        var endFen=dataChild[j].endTime.substr(14,2);   //结束时间的分钟
                                                        var endHour=dataChild[j].endTime.substr(11,2);   //结束时间的小时
                                                        if(endFen>30){
                                                            endHour=parseInt(endHour)+1;  //如果分钟大于30 ，小时自动+1
                                                        }
                                                        var borderC='';
                                                        if(dataChild[j].status == 1){
                                                            borderC='rgb(58, 135, 173)';
                                                        }else if(dataChild[j].status == 2){
                                                            borderC='rgb(105, 240, 164)';
                                                        }else if(dataChild[j].status == 3){
                                                            borderC='rgb(255, 136, 124)';
                                                        }else if(dataChild[j].status == 4){
                                                            borderC='rgb(245, 181, 46)';
                                                        }else if(dataChild[j].status == 5){
                                                            borderC='rgb(219, 173, 255)';
                                                        }
                                                        var left=($('#HOUR_0').width() * offsetL ) + ((starFen/60) * $('#HOUR_0').width())
                                                        var width=($('#HOUR_0').width() * (endHour - offsetL) )- ((starFen/60) * $('#HOUR_0').width())
                                                        str+='<div id="xiangqing" sid="' +dataChild[j].sid+ '" style="width: '+width+'px;float: left;position: absolute;left: '+left+'px;top: 5px;' +
                                                            'border:'+borderC+' 1px solid;border-left-width: 5px;border-radius: 5px;margin-left: 5px;">' +
                                                            '<div style="text-align: left;">'+starTime+'<br>'+endTime+'</div>' +
                                                            '</div>';
                                                    }
                                                }
                                                $('#MEET_ROOM_'+data[i].sid).append(str);
                                                $("#xiangqing").unbind("click").bind("click",function(e){
                                                    $.ajax({
                                                        url: '/meeting/queryMeetingById',
                                                        type: 'get',
                                                        dataType: 'jsonp',
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

                                                            var fileStr = '';
                                                            if (data.agendaList && data.agendaList.length > 0) {
                                                                for (var i = 0; i < data.agendaList.length; i++) {
                                                                    fileStr += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.agendaList[i].attUrl + '">' + data.agendaList[i].attachName + '</a></div>'
                                                                }
                                                            } else {
                                                                fileStr = '';
                                                            }

                                                            layer.open({
                                                                type: 1,
                                                                title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                                                area: ['600px', '500px'],
                                                                shadeClose: true, //点击遮罩关闭
                                                                content: '<div class="table"><table style="margin:auto;">' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meeting.contactPhone" />：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span><fmt:message code="global.from" /> &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                                                                    '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meeting.frontDeskServiceStaff" />：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meeting.agendaAttachment" />：</span></td><td><span><div class="inPole">' + fileStr + '</div></span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</div></span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                                                                    '<tr><td><span class="span_td"><fmt:message code="meet.th.MySignin" />：</span></td><td><span>' + data.myAttend + '</span></td><tr>' +
                                                                    '</table></div>',
                                                                success: function () {
                                                                    $('.table td').css({
                                                                        "overflow": "hidden",
                                                                        "text-overflow": "ellipsis",
                                                                        "white-space": "nowrap",
                                                                        "padding": 0,
                                                                        "height": "auto"
                                                                    });
                                                                    if (data.status == 1 || data.status == 4) {
                                                                        $(".layui-layer-btn0").css("display", "none")
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
                                                            })}
                                                    })
                                                })
                                            }
                                        }
                                    })
                                }
                            }
                        })
                    })
                },
                yes: function (index) {
                    var array = $(".test_null");
                    var attendId = '';
                    var attendName = '';
                    for (var i = 0; i < $('.onlyOne').length; i++) {
                        if ($('.onlyOne').eq(i).val().split(',').length > 2) {
                            $.layerMsg({
                                content: $('.onlyOne').eq(i).parent().parent().prev().text().substr(0, $('.onlyOne').eq(i).parent().parent().prev().text().length - 1) + '只能选一个！',
                                icon: 2
                            }, function () {
                            });
                            return;
                        }
                    }
                    var isWriteCalednar = 0;
                    var attendId = '';
                    var attendName = '';
                    if ($('#isWriteCalendar').is(':checked')) {
                        isWriteCalednar = 1;
                    }
                    var smsRemind = 0;

                    if ($('#smsRemind').is(':checked')) {
                        smsRemind = 1;
                    }
                    var sms2Remind = 0;
                    if ($('#sms2Remind').is(':checked')) {
                        sms2Remind = 1;
                    }
                    var recorderId = $(".recorderName").attr("dataid");
                    if (recorderId != "" && recorderId.indexOf(",") >= 0) {
                        recorderId = recorderId.substr(0, recorderId.length - 1);
                    }
                    var uid = $(".userName").attr("dataid");
                    if (uid != "" && uid.indexOf(",") >= 0) {
                        uid = uid.substr(0, uid.length - 1);
                    }
                    for (var i = 0; i < $('.Attachment .inHidden').length; i++) {
                        attendId += $('.Attachment .inHidden').eq(i).val();
                    }
                    for (var i = 0; i < $('.Attachment .inHidden').length; i++) {
                        attendName += $('.Attachment a').eq(i).attr('NAME');
                    }
                    // 会议议程附件
                    var attendAgendaId = '';
                    var attendAgendaName = '';
                    for (var i = 0; i < $('#fileAllAgenda .dech').length; i++) {
                        attendAgendaId += $('#fileAllAgenda .dech').eq(i).find('input').val();
                        attendAgendaName += $('#fileAllAgenda a').eq(i).attr('name');
                    }
                    if ($('#meetName').val() == "") {
                        $.layerMsg({content: '名称不能为空！', icon: 2});
                        return false;
                    }
                    if ($('#subject').val() == "") {
                        $.layerMsg({content: '主题不能为空！', icon: 2});
                        return false;
                    }
                    if ($('#userDuser').val() == "") {
                        $.layerMsg({content: '请添加申请人', icon: 2});
                        return false;
                    }
                    if ($('#mobileNo').val() == "") {
                        $.layerMsg({content: '联系电话不能为空！', icon: 2});
                        return false;
                    }
                    if ($('#attendeeDuser').val() == "") {
                        $.layerMsg({content: '请添加出席人员（内部）', icon: 2});
                        return false;
                    }
                    var paraData = {
                        sid: sid,
                        meetName: $(".meetName").val(),
                        mobileNo: $(".mobileNo").val(),
                        subject: $(".subject").val(),
                        uid: uid,
                        recorderId: recorderId,
                        startTime: $(".startTime").val(),
                        endTime: $(".endTime").val(),
                        attendeeOut: $(".attendeeOut").val(),
                        attendee: $(".attendee").attr("dataid"),
                        isWriteCalednar: isWriteCalednar,
                        smsRemind: smsRemind,
                        sms2Remind: sms2Remind,
                        resendHour: $(".resendHour").val(),
                        resendMinute: $(".resendMinute").val(),
                        meetDesc: $(".meetDesc").val(),
                        managerId: $("#managerId").val(),
                        meetRoomId: $("#meetRoomId").val(),
                        equipmentNames: $(".equipmentId").val(),
                        equipmentIds: $(".equipmentId").attr("equipmentId"),
                        attachmentId: attendId,
                        attachmentName: attendName,
                        signInTime:$("#signInTime").val(),
                        agendaId: attendAgendaId,
                        agendaName: attendAgendaName,
                        videoConfFlag: $('.isVideo:checked').val(),
                        serviceUser: $("#serviceUser").attr("dataid"),
                        handwritingSignYn: $('.handwritingSignYn:checked').val(),
                    }
                    if ($('#isOld').val() != $("#managerId").val()) {
                        paraData.Status = 1
                    } else {
                        paraData.Status = 0
                    }

                    $.ajax({
                        url: '/meeting/updateMeetingById',
                        type: 'get',
                        dataType: 'json',
                        data: paraData,
                        success: function (obj) {
                            if (obj.flag) {
                                $.layerMsg({content: '<fmt:message code="depatement.th.Modifysuccessfully" />！', icon: 1}, function () {
                                    //更新列表
                                    listByStatus(queryStatus);
                                })
                                layer.close(index);
                            }
                        }
                    })
                }
            });
            $('#uploadinputimg').fileupload({
                dataType: 'json',
                done: function (e, data) {
                    if (data.result.obj != '') {
                        var data = data.result.obj;
                        var str = '';
                        var str1 = '';
                        for (var i = 0; i < data.length; i++) {
                            str += '<div class="dech" deUrl="' + data[i].attUrl + '"><a href="/download?' + encodeURI(data[i].attUrl) + '" NAME="' + data[i].attachName + '*"><img style="margin-right:10px;" src="../img/attachment_icon.png"/>' + data[i].attachName + '</a><img class="deImgs" style="margin-left:5px;cursor: pointer;" src="../img/file/icon_deletecha_03.png"/><input type="hidden" class="inHidden" value="' + data[i].aid + '@' + data[i].ym + '_' + data[i].attachId + ',"></div>';
                        }
                        $('.Attachment').append(str);
                    } else {
                        layer.alert('添加附件大小不能为空!', {}, function () {
                            layer.closeAll();
                        });
                    }
                }
            });

            //查询所有办公设备
            var equipStr = '';
            $.ajax({
                url: '/Meetequipment/getAllEquiet',
                type: 'get',
                dataType: 'json',
                success: function (obj) {
                    var data = obj.obj;
                    for (var i = 0; i < data.length; i++) {
                        equipStr += '<tr><td class="equipClick" equipmentid="' + data[i].sid + '">' + data[i].equipmentName + '</td></tr>';
                    }
                }
            })
            //选择办公设备控件
            $(".addEquipment").on("click",function () {
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SelectDevice" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['300px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['<fmt:message code="global.lang.ok" />'],
                    content: '<table class="equip">' +
                        '<tr><td><span><fmt:message code="meet.th.SelectDevice" /></span></td></tr>' +
                        '<tr><td id="addAll"><span><fmt:message code="meet.th.addAll" /></span></td></tr>' +
                        '<tr><td id="delAll"><span><fmt:message code="meet.th.DeleteAll" /></span></td></tr>' +
                        equipStr +
                        '</table>',
                    success: function () {
                        $(".equipClick").on("click",function () {
                            $(this).toggleClass('equipSpan');
                        })
                        $("#addAll").on("click",function () {
                            $(".equipClick").addClass('equipSpan');
                        })
                        $("#delAll").on("click",function () {
                            $(".equipClick").removeClass('equipSpan');
                        })
                    },
                    yes: function (index) {
                        var equipSpanArray = $(".equipSpan");
                        var equipId = "";
                        var equipName = "";
                        for (var i = 0; i < equipSpanArray.length; i++) {
                            equipName += $(equipSpanArray[i]).html() + ",";
                            equipId += $(equipSpanArray[i]).attr("equipmentid") + ",";
                        }
                        $(".equipmentId").attr("equipmentId", equipId);
                        $(".equipmentId").val(equipName);
                        layer.close(index);
                    }

                })
            })
            $(".clearEquipment").on("click",function () {
                $(".equipmentId").attr("equipmentId", "");
                $(".equipmentId").val("");
            })
        })
        $('#meetingApply').on("click",function () {
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('.divIframeTwo').hide();
            $('.meentingDate').show();
            $('#already').hide();
            $('.colorClass').show();
        })
        $('#PAMeeting').on("click",function () {
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#ApMeeting').on("click",function () {
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#HaveMeeting').on("click",function () {
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#NotMeeting').on("click",function () {
            $('.divIframeTwo').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('#already').show();
            $('.meentingDate').hide();
            $('.colorClass').hide();
        })
        $('#MeetingRoomUsage').on("click",function () {
            $('.pagediv').hide();
            $(this).find('.headli').addClass('one').end().siblings().find('.headli').removeClass('one');
            $('.meentingDate').hide();
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
            paraData = {}
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
                        area: ['830px', '400px'], //宽高
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
                        area: ['830px', '400px'], //宽高
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
                    area: ['830px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['打印', '<fmt:message code="global.lang.close" />'],
                    content: '<div class="table"><table style="margin:auto;" class="detailTable">' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meeting.contactPhone" />：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span><fmt:message code="global.from" /> &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                        '<tr><td><span class="span_td"><fmt:message code="meeting.frontDeskServiceStaff" />：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
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
