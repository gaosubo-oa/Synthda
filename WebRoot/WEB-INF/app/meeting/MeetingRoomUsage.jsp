<%--
  Created by IntelliJ IDEA.
  User: 86188
  Date: 2022/8/14
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<title><fmt:message code="meet.th.ConferenceApplication"/></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="stylesheet" href="/css/meeting/index.css?20220814">
<link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.css"/>
<link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.print.css"/>
<link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
<link rel="stylesheet" href="/lib/pagination/style/pagination.css">
<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

<script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
<head>
    <title>会议室使用情况</title>
    <style>
        body{
            box-sizing: border-box;
        }
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
            text-align: right;
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
            padding-top: 15px;
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
    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?20220814"/>
<script>
    // 更新会议状态
    $.ajax({url:'/meeting/updateStatus', async:false});
</script>
<body style="font-family: 微软雅黑;" onresize="myFunction()">
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

<div id="fullCandar">
    <div class="leftBtn">
        <span class="leftBtnOne"></span>
        <span class="leftBtnTwo"><fmt:message code="notice.th.Today" /></span>
        <span class="leftBtnThr"></span>
    </div>
    <div class="fullTime">
        <span class="spanTime"><input type="text" class="layui-input" id="timeChoose"></span>
    </div>
    <div class="colorClass">
        <a href="javascript:;" style="background-color: rgb(58, 135, 173);"></a>
        <span><fmt:message code="meet.th.PendingApproval" /></span>
        <a href="javascript:;" style="background-color: rgb(105, 240, 164);"></a>
        <span><fmt:message code="meet.th.Ratified" /></span>
        <a href="javascript:;" style="background-color: rgb(255, 136, 124);"></a>
        <span><fmt:message code="meet.th.HaveHand" /></span>
        <a href="javascript:;" style="background-color: rgb(245, 181, 46);"></a>
        <span><fmt:message code="meet.th.unratified" /></span>
        <a href="javascript:;" style="background-color: rgb(219, 173, 255);"></a>
        <span style="margin-right: 24px"><fmt:message code="meet.th.IsOver" /></span>
    </div>
</div>
<div class="div_room" style="padding-left: 20px;box-sizing: border-box;"></div>`,

<script>

    //今天按钮
    $(function (){


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
                                        '<tr><td width="30%"><span class="span_td">联系电话：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                                        '<tr><td width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                                        '<tr><td><span class="span_td">前台会议服务人员：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                                        '<tr><td><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                                        '<tr><td><span class="span_td">会议议程附件：</span></td><td><span><div class="inPole">' + fileStr + '</div></span></td><tr>' +
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
        $(window).on("resize", function  () {
            //当浏览器大小变化时
            var timeStr = $("#timeChoose").val();
            getAllRoom(timeStr)
        });
    function myFunction() {
        var timeStr = $("#timeChoose").val();
        getAllRoom(timeStr)
    }

    function dateHandling(date){
        if (date == null){
            date = new Date();
        }

        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();

        if (month < 10){
            month = "0" + month;
        }
        if (day < 10){
            day = "0" + day;
        }

        return year + "-" + month + "-" + day;
    }
    })

</script>
</body>
</html>
