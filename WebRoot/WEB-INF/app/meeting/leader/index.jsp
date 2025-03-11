<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 11:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <title><fmt:message code="meet.th.management"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/meeting/myMeeting.css">
    <link rel="stylesheet" href="/css/meeting/leader.css">
    <%--<link rel="stylesheet" href="/css/meeting/index.css">--%>
    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <link rel="stylesheet" href="/lib/laydate/need/laydate.css">
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">

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

        /*table tbody td{
            overflow: hidden;
            text-overflow:ellipsis;
            white-space: nowrap;
        }*/
        .tdStyle1 {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        input {
            float: none;
        }

        input[type="checkbox"] {
            width: 15px;
            vertical-align: middle;
        }

        .leftBtn {
            float: left;
            margin-bottom: 6px;
        }

        .leftBtn span {
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

        .leftBtnTwo {
            width: 60px !important;
            line-height: 30px;
            text-align: center;
            font-size: 14px;
        }

        .leftBtnOne {
            background: url("../img/meeting/icon_prev_03.png") no-repeat center;
        }

        .leftBtnThr {
            background: url("../img/meeting/icon_next_03.png") no-repeat center;
        }

        .fullTime {
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

        .spanList {
            width: 100px;
        }

        .one {
            color: #fff;
        }

        .div_ul ul .one:hover {
            color: #fff;
        }

        .layui-layer-dialog {
            top: 200px !important;
        }

        .jump-ipt {
            float: left;
            width: 30px;
            height: 30px;
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

        .tabletd {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            padding: 0;
        }

        #timeChoose {
            width: 300px;
            margin: 0 auto;
            height: 100%;
        }

        tr {
            height: 50px;
        }

        table, td, th {
            border: 1px solid #ddd;
            text-align: left;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            table-layout: fixed;
        }

        th, td {
            padding: 5px;
            position: relative;
            user-select: none;
            /*text-overflow: ellipsis;*/
            word-break: break-all;
        }

        .th-sisehandler {
            position: absolute;
            right: -0.5px;
            top: 0;
            z-index: 1;
            width: 5px;
            height: 100%;
            padding-left: 4px;
            cursor: col-resize;
        }

        .th-sisehandler::after {
            content: '';
            display: block;
            width: 10px;
            background-color: #4CAF50; /*演示为了看效果加上的，可以去掉*/
            height: 100%;
        }

        .siselayer {
            position: fixed;
            left: 0;
            top: 0;
            right: 0;
            bottom: 0;
            z-index: 9999;
            background-color: #4445a049; /*演示为了看效果加上的，可以去掉*/
            cursor: col-resize;
        }

        .layui-input, .layui-textarea {
            display: inline-block;
            width: 150px;
        }

        .layui-form-label {
            padding: 0px;
            margin-top: 10px;
        }
        #endTime{
            display: none;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <%--<link rel="stylesheet" href="/css/base.css">--%>
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <%--	<script src="/lib/laydate/laydate.js"></script>--%>
    <script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/lib/qrcode.js"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script src="/js/jquery/jquery.jqprint-0.3.js"></script>

    <script>
        // 更新会议状态
        $.ajax({url: '/meeting/updateStatus', async: false});
    </script>
</head>
<body style="font-family: 微软雅黑;">
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/icon_meetingManagr.png" alt="">
    </div>
    <div class="divTitle">
        <fmt:message code="meet.th.management"/>
    </div>
</div>
<div class="main" style="    margin-top: 48px;height:100%">
    <div class="mainLeft" style="height:100%;width: 13%">
        <div class="div_ul" style="height:100%">
            <ul style="height:100%">
                <li class="one styleSet" onclick="listByStatus('',1)">
                    <div class="spanList"><fmt:message code="meet.th.PendingMeeting"/></div>
                    <div class="spanNum" id="pendingCount"></div>
                </li>
                <li class="styleSet" onclick="listByStatus('',6)">
                    <div class="spanList"><fmt:message code="meeting.pendingApprovalCyclicMeeting" /></div>
                    <div class="spanNum" id="cyclePendingCount"></div>
                </li>
                <li class="styleSet" onclick="listByStatus('',2)">
                    <div class="spanList"><fmt:message code="meet.th.ApprovedMeeting"/></div>
                    <div class="spanNum" id="approvedCount"></div>
                </li>
                <li class="styleSet" onclick="listByStatus('',3)">
                    <div class="spanList"><fmt:message code="meet.th.InCession"/></div>
                    <div class="spanNum" id="processingCount"></div>
                </li>
                <li class="styleSet" onclick="listByStatus('',4)">
                    <div class="spanList"><fmt:message code="meet.th.UnauthorizedMeeting"/></div>
                    <div class="spanNum" id="notApprovedCount"></div>
                </li>
                <li class="styleSet" onclick="listByStatus('',5)">
                    <div class="spanList"><fmt:message code="meet.th.ClosinSession"/></div>
                    <div class="spanNum" id="overCount"></div>
                </li>
                <li class="" id="allMeetingRoon"><span><fmt:message code="meet.th.ConferenceRoomUsage"/></span></li>
            </ul>
        </div>
    </div>

    <div class="mainRight"style="width: 86%;">
        <div class="pagediv meetingManage" style="margin: 0 auto;width: 97%;display: block;" id="showList">
            <form class="layui-form" action="">
                <div class="layui-inline">
                    <label class="layui-form-label" style="font-size: 14px"><fmt:message code="meeting.meetingName" />：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="xiangmu" id="xiangmu" style="width: 200px" placeholder="<fmt:message code="meeting.pleaseInputMeetingName" />"
                               autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-form-text">
                    <label class="layui-form-label" style="font-size: 14px;margin-left: 50px"><fmt:message code="meeting.applicant" />：</label>
                    <div class="layui-input-inline">
            <textarea placeholder="<fmt:message code="meeting.pleaseSelectPersonnel" />" style="min-height: 38px ;height: 38px ;width: 200px" readonly
                      name="textUser" id="textUser"
                      class="layui-textarea"></textarea>
                    </div>
                    <a href="javascript:;" class="governor" id="market_pop"><fmt:message code="global.lang.add"/></a>
                    <a href="javascript:;" class="clearTwo" onclick="market_pop()"><fmt:message
                            code="global.lang.empty"/></a>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label"
                           style="width: 100px;font-size: 14px;margin-left: 50px"><fmt:message code="meeting.startTime" />：</label>
                    <div class="layui-input-inline">
                        <input id="nianfen" tyle="width: 150" class="layui-input" placeholder="<fmt:message code="meeting.pleaseSelectYear" />">
                        <span><fmt:message code="global.to" />：</span><input id="nianfen2" tyle="width: 150" class="layui-input"
                                               placeholder="<fmt:message code="meeting.pleaseSelectYear" />">
                    </div>
                </div>
                <div class="layui-inline" style="margin-left: 50px">
                    <div class="layui-input-inline" style="display: flex">
                        <label class="layui-form-label" style="font-size: 14px;margin-left:-50px"><fmt:message code="meeting.conferenceRoom" />：</label>
                        <select name="evLevel" id="meetRoom" lay-verify="required"
                                style="display:block; width: 200px;height: 38px;border: none">

                        </select>
                    </div>
                </div>
                <div class="layui-inline" style="">
                    <div class="layui-input-inline" style=" margin-left: 10px;margin-top: 10px">
                        <button type="button" class="layui-btn" id="insert"
                                style="margin-left: 800px;margin-bottom: 10px;"><fmt:message code="datasource.query" />
                        </button>
                    </div>
                </div>
                <table id="test" lay-filter="SettlementFilter1"></table>
            </form>
            <table>
                <thead>
                <tr>
                    <th style="text-align: center" width="12%"><fmt:message code="meet.th.ConferenceName"/></th>
                    <th style="text-align: center" width="12%"><fmt:message code="meeting.verificationCode" /></th>
                    <th style="text-align: center" width="10%"><fmt:message code="sup.th.Applicant"/></th>
                    <th style="text-align: center" width="17%"><fmt:message code="sup.th.ApplicationTime"/></th>
                    <th style="text-align: center" width="17%"><fmt:message code="sup.th.startTime"/></th>
                    <th style="text-align: center" width="17%"><fmt:message code="meet.th.EndTime"/></th>
                    <th style="text-align: center" width="9%"><fmt:message code="meet.th.ConferenceRoom"/></th>
                    <th style="text-align: center" width="25%"><fmt:message code="notice.th.operation"/></th>
                </tr>
                </thead>
                <tbody>
                </tbody>

            </table>
            <div id="dbgz_page" class="M-box3 fr" style="margin-top: 1%">

            </div>
        </div>
        <div class="usage" style="display: none;">
            <div id="fullCandar">
                <div class="leftBtn">
                    <span class="leftBtnOne"></span>
                    <span class="leftBtnTwo"><fmt:message code="notice.th.Today"/></span>
                    <span class="leftBtnThr"></span>
                </div>
                <div class="fullTime">
                    <span class="spanTime"><input type="text" class="layui-input" id="timeChoose"></span>
                </div>
                <div class="colorClass">
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
            <div class="div_room" style="padding-left: 10px;box-sizing: border-box;"></div>
        </div>
    </div>
</div>
<script>
    var timer = null;
    var datas;
    //日期控件
    $(function () {
        laydate.render({
            elem: '#nianfen'
            , format: 'yyyy-MM-dd'
        });
        laydate.render({
            elem: '#nianfen2'
            , format: 'yyyy-MM-dd'
        });
    })
    //选择申请人控件
    var user_id = '';
    $("#market_pop").on("click",function () {
        user_id = $("#textUser").attr("id");
        $.popWindow("/common/selectUserIMAddGroup?0");
    })

    //清除数据
    function market_pop() {
        $('#textUser').attr('dataid', '');
        $('#textUser').val('');
    }

    //会议室下拉列表
    $.ajax({
        url: '/meetingRoom/getAllMeetRoomInfo',
        type: 'get',
        dataType: 'json',
        success: function (obj) {
            $("#meetRoom").html("");
            var data = obj.obj;
            $("#meetRoom").append('<option value=""><fmt:message code="meet.th.Choosemeetingroom" /></option>');
            for (var i = 0; i < data.length; i++) {
                $("#meetRoom").append('<option value="' + data[i].sid + '">' + data[i].mrName + '</option>');
            }
        }
    });
    //查询接口
    $('#insert').on("click",function () {
        var currentPage = 1;
        var uid = $('#textUser').attr("dataid") ? $('#textUser').attr("dataid").replace(",", "") : "";
        $.ajax({
            url: '/meeting/meetingManage',
            type: "get",
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                managerId: $.cookie('uid'),
                status: 1,
                meetName: $('#xiangmu').val(),
                uid: uid,
                startTime: $('#nianfen').val(),
                endTime: $('#nianfen2').val(),
                meetRoomId: $("#meetRoom").val()
            },
            success: function (obj) {
                var data = obj.obj;
                $('#dbgz_page').pagination({
                    totalData: obj.totleNum,
                    showData: 10,
                    jump: true,
                    coping: true,
                    homePage: '',
                    endPage: '',
                    current: 1,
                    callback: function (index) {
                        mes.data.page = index.getCurrent();
                        mes.page();
                    }
                });
                var str = "";
                for (var i = 0; i < data.length; i++) {
                    str += '<tr><td  style="text-align: center" width="12%" title="' + data[i].meetName + '" class="tdStyle1"><a href="javascript:void(0);" class="meetingDetail"  sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
                        '<td style="text-align: center" width="10%" class="tdStyle1">' + function () {
                            if (data[i].meetCode != undefined && data[i].meetCode != '') {
                                return data[i].meetCode;
                            }
                            return "无";
                        }() + '</td>' +
                        '<td style="text-align: center" width="10%" class="tdStyle1">' + data[i].userName + '</td>' +
                        '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].createTime + '</td>' +
                        '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].startTime + '</td>' +
                        '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].endTime + '</td>' +
                        '<td style="text-align: center" width="9%" title="' + data[i].meetRoomName + '" class="tdStyle1">' + data[i].meetRoomName + '</td>' +
                        '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',2)"><fmt:message code="meet.th.Approval" /></a>' +
                        '<a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',4)"><fmt:message code="meet.th.NotApprove" /></a>' +
                        '<a href="javascript:;" style="" class="editData" sid="' + data[i].sid + '"><fmt:message code="menuSSetting.th.editMenu" /></a>' +
                        '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a></td>' +
                        '</tr>';
                }
                $("#showList tbody").html(str);


            }
        })
    })

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

    //日期补零
    function getNowFormatDate() {
        var day = new Date();
        var Year = 0;
        var Month = 0;
        var Day = 0;
        var CurrentDate = "";
        //初始化时间
        //Year       = day.getYear();//有火狐下2008年显示108的bug
        Year = day.getFullYear();//ie火狐下都可以
        Month = day.getMonth() + 1;
        Day = day.getDate();
        CurrentDate += Year + "-";
        if (Month >= 10) {
            CurrentDate += Month + "-";
        } else {
            CurrentDate += "0" + Month + "-";
        }
        if (Day >= 10) {
            CurrentDate += Day;
        } else {
            CurrentDate += "0" + Day;
        }

        return CurrentDate;
    }

    function transdate(endTime) {//转时间戳
        var date = new Date();
        date.setFullYear(endTime.substring(0, 4));
        date.setMonth(endTime.substring(5, 7) - 1);
        date.setDate(endTime.substring(8, 10));
        date.setHours(endTime.substring(11, 13));
        date.setMinutes(endTime.substring(14, 16));
        date.setSeconds(endTime.substring(17, 19));
        return Date.parse(date) / 1000;
    }

    function getLocalTime(nS) {//转日期格式
        // var DateTimArre=new Date(parseInt(nS) * 1000).toLocaleString().split(/\s/)[0].split('/');
        // var DateTime=DateTimArre.join('-')
        //针对360兼容模式时间问题处理
        var date = new Date(nS * 1000);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
        var D = (date.getDate() < 10 ? '0' + date.getDate() : date.getDate()) + ' ';
        var DateTime = Y + M + D
        return DateTime;
    }

    var myDate = transdate(getNowFormatDate());//初始时间戳

    // $('.spanTime').text(getLocalTime(myDate));

    var queryStatus = 1;//获取要查询列表的状态
    var cycle;
    var chooseTime = new Date().toLocaleString('zh', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit'
    }).replace(/\//g, '-')
    $(function () {

        //时间增加按钮
        // $('.leftBtnThr').on("click",function(){
        //     myDate+=86400;
        //     $('.spanTime').text(getLocalTime(myDate));
        //     getAllRoom(getLocalTime(myDate));
        // })
        // //时间减少按钮
        // $('.leftBtnOne').on("click",function(){
        //     myDate-=86400;
        //     $('.spanTime').text(getLocalTime(myDate));
        //     getAllRoom(getLocalTime(myDate));
        // })

        laydate.render({
            elem: '#timeChoose', //指定元素
            value: new Date(),
            done: function (value, date, endDate) { // 选择完毕的回调
                chooseTime = value
                getAllRoom(value)
            }
        });

        //各个状态的数量显示
        $.ajax({
            url: '/meeting/queryCountByStatu',
            type: 'get',
            dataType: 'json',
            success: function (obj) {
                var data = obj.object;
                $("#pendingCount").html(data.pendingCount);
                $("#cyclePendingCount").html(data.cyclePendingCount);
                $("#approvedCount").html(data.approvedCount);
                $("#processingCount").html(data.processingCount);
                $("#notApprovedCount").html(data.notApprovedCount);
                $("#overCount").html(data.overCount);
            }
        });
        //初始列表显示

        var ajaxPageLe = {
            data: {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                managerId: $.cookie('uid'),
                status: 1
            },
            page: function () {
                var me = this;
                $.ajax({
                    url: '/meeting/meetingManage',
                    type: 'get',
                    dataType: 'json',
                    data: me.data,
                    success: function (obj) {
                        var data = obj.obj;
                        var str = "";
                        for (var i = 0; i < data.length; i++) {
                            str += '<tr><td  style="text-align: center" width="12%" title="' + data[i].meetName + '" class="tdStyle1"><a href="javascript:void(0);" class="meetingDetail"  sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
                                '<td style="text-align: center" width="10%" class="tdStyle1">' + function () {
                                    if (data[i].meetCode != undefined && data[i].meetCode != '') {
                                        return data[i].meetCode;
                                    }
                                    return "无";
                                }() + '</td>' +
                                '<td style="text-align: center" width="10%" class="tdStyle1">' + data[i].userName + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].createTime + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].startTime + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].endTime + '</td>' +
                                '<td style="text-align: center" width="9%" title="' + data[i].meetRoomName + '" class="tdStyle1">' + data[i].meetRoomName + '</td>' +
                                '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',2)"><fmt:message code="meet.th.Approval" /></a>' +
                                '<a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',4)"><fmt:message code="meet.th.NotApprove" /></a>' +
                                '<a href="javascript:;" style="" class="editData" sid="' + data[i].sid + '"><fmt:message code="menuSSetting.th.editMenu" /></a>' +
                                '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a></td>' +
                                '</tr>';
                        }
                        $("#showList tbody").html(str);
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


        //点击会议室使用情况
        $('#allMeetingRoon').on("click",function () {
            $(this).addClass('one').siblings().removeClass('one');
            $('.usage').show();
            $('.meetingManage').hide();

            getAllRoom(getLocalTime(myDate));
        })
        $('.leftBtnTwo').on("click",function () {
            myDate = transdate(getNowFormatDate())
            // $('.spanTime').text(getLocalTime(myDate));
            laydate.render({
                elem: '#timeChoose', //指定元素
                value: new Date(),
                done: function (value, date, endDate) { // 选择完毕的回调
                    chooseTime = value
                    getAllRoom(value)
                }
            });
            getAllRoom(getLocalTime(myDate));
        })
    })

    //设置选中时的样式
    $(".styleSet").on("click",function () {
        $(this).addClass('one').siblings().removeClass('one');
        $('.meetingManage').show();
        $('.usage').hide();
    })

    //点击各个状态后显示的列表
    function listByStatus(cycleNo, status) {
        // 更新会议状态
        $.ajax({url: '/meeting/updateStatus', async: false});
        queryStatus = status;
        cycle = cycleNo
        var data;
        if (status <= 5) {
            data = {
                page: 1,//当前处于第几页
                pageSize: 10,//一页显示几条
                useFlag: true,
                managerId: $.cookie('uid'),
                status: status,
            }
        } else if (status == 6) {
            data = {
                page: 1,
                pageSize: 10,
                useFlag: true,
                status: 1,
                managerId: $.cookie('uid'),
                cycle: 1
            }
        } else if (status == 7) {
            data = {
                page: 1,
                pageSize: 10,
                useFlag: true,
                status: 1,
                managerId: $.cookie('uid'),
                cycleNo: cycleNo
            }
        }
        var ajaxPageLe = {
            data: data,
            page: function () {
                var me = this;
                $.ajax({
                    url: '/meeting/meetingManage',
                    type: 'get',
                    dataType: 'json',
                    data: me.data,
                    success: function (obj) {
                        var data = obj.obj;
                        datas = obj.obj;
                        var str = "";
                        for (var i = 0; i < data.length; i++) {
                            str += '<tr><td style="text-align: center" width="12%" class="tdStyle1" title="' + data[i].meetName + '"><a href="javascript:void(0);" class="meetingDetail" sid="' + data[i].sid + '">' + data[i].meetName + '</a></td>' +
                                '<td style="text-align: center" width="10%" class="tdStyle1">' + function () {
                                    if (data[i].meetCode != undefined && data[i].meetCode != '') {
                                        return data[i].meetCode;
                                    }
                                    return "无";
                                }() + '</td>' +
                                '<td style="text-align: center" width="10%" class="tdStyle1">' + data[i].userName + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].createTime + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].startTime + '</td>' +
                                '<td style="text-align: center" width="17%" class="tdStyle1">' + data[i].endTime + '</td>' +
                                '<td style="text-align: center" width="9%" class="tdStyle1" title="' + data[i].meetRoomName + '">' + data[i].meetRoomName + '</td>';
                            if (status == 1 || status == 4 || status == 7) {
                                str += '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',2)"><fmt:message code="meet.th.Approval" /></a>' +
                                    '<a href="javascript:;" style="" onclick="approve(' + data[i].sid + ',4)"><fmt:message code="meet.th.NotApprove" /></a>' +
                                    '<a href="javascript:;" style="" class="editData" sid="' + data[i].sid + '"><fmt:message code="menuSSetting.th.editMenu" /></a>' +
                                    '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a></td>' +
                                    '</tr>';
                            }
                            if (status == 2) {
                                var Content = data[i].videoContent;
                                str += '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>' +
                                    '<a href="javascript:;" style="" onclick="endMeeting(' + data[i].sid + ',5)"><fmt:message code="meet.th.End" /></a>' +
                                    <%--'<a href="javascript:;" style="" class="editData" sid="'+data[i].sid+'"><fmt:message code="menuSSetting.th.editMenu" /></a>'+--%>
                                    '<a href="javascript:;" style="" class="attendQR" sid="' + data[i].sid + '">二维码</a>' +
                                    function () {
                                        if (data[i].videoContent != undefined && data[i].videoConfFlag === "1" && data[i].status != 5) {
                                            return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a>';
                                        }
                                        return ''
                                    }() +
                                    '</td>' +
                                    '</tr>';
                            }
                            if (status == 3) {
                                str += '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>' +
                                    '<a href="javascript:;" style="" onclick="endMeeting(' + data[i].sid + ',5)"><fmt:message code="meet.th.End" /></a>' +
                                    '<a href="javascript:;" style="" class="attendQR" sid="' + data[i].sid + '">二维码</a>' +
                                    function () {
                                        if (data[i].videoContent != undefined && data[i].videoConfFlag === "1" && data[i].status != 5) {
                                            return '<a href="javascript:;" onclick="GetDataSet(' + JSON.stringify(data[i].videoContent).replace(/"/g, '&quot;') + ')">参加视频会议</a>';
                                        }
                                        return ''
                                    }() +
                                    '</td>' +
                                    '</tr>';
                            }
                            if (status == 5) {
                                str += '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',1)"><fmt:message code="mee.th.Participants" /></a>' +
                                    '<a href="javascript:;" style="" onclick="attendState(' + data[i].sid + ',2)"><fmt:message code="meet.th.ReadingStatus" /></a>' +
                                    '<a href="javascript:;" style="" onclick="delMeeting(' + data[i].sid + ')"' + '><fmt:message code="global.lang.delete" /></a>' +
                                    '</tr>';
                            }
                            if (status == 6) {
                                str += '<td style="text-align: center" width="25%"><a href="javascript:;" style="" onclick="listByStatus(' + data[i].cycleNo + ',7)">周期性会议审批</a>' +
                                    '</tr>';

                            }
                        }
                        $("#showList tbody").html(str);
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

    //批准和不批准会议
    function approve(sid, status) {
        if (status == 2) {//批准会议
            $.layerConfirm({
                title: '<fmt:message code="meet.th.ApprovalMeeting" />',
                content: '<fmt:message code="meet.th.AreMeeting" />？',
                icon: 0
            }, function () {
                $(".layui-layer-btn0").css("pointer-events", "none");
                $.ajax({
                    url: '/meeting/updMeetStatusById',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        sid: sid,
                        status: status
                    },
                    success: function (obj) {
                        if (obj.flag) {
                            $.layerMsg({
                                content: '<fmt:message code="meet.th.SuccessfulApproval" />！',
                                icon: 1
                            }, function () {
                                //更新列表
                                listByStatus(cycle, queryStatus);
                                //更新数量
                                //各个状态的数量显示
                                $.ajax({
                                    url: '/meeting/queryCountByStatu',
                                    type: 'get',
                                    dataType: 'json',
                                    success: function (obj) {
                                        var data = obj.object;
                                        $("#pendingCount").html(data.pendingCount);
                                        $("#cyclePendingCount").html(data.cyclePendingCount);
                                        $("#approvedCount").html(data.approvedCount);
                                        $("#processingCount").html(data.processingCount);
                                        $("#notApprovedCount").html(data.notApprovedCount);
                                        $("#overCount").html(data.overCount);
                                    }
                                });
                                $(".layui-layer-btn0").css("pointer-events", "auto");
                            })
                        } else {
                            if (obj.msg == "<fmt:message code="meet.th.conferenceRoomOccupied" />") {
                                $.layerMsg({content: '"' + obj.msg + '"！', icon: 2}, function () {
                                    $(".layui-layer-btn0").css("pointer-events", "auto");
                                })
                            }
                        }
                    }
                });
            })
        } else {//不批准会议
            layer.prompt({
                    formType: 2,
                    value: '',
                    title: '<fmt:message code="meet.th.NonApproval" />',
                    area: ['800px', '350px'], //自定义文本域宽高`
                    yes: function (index, elem) {
                        if ($(elem).find('textarea')[0].value == '') {
                            return layer.msg('请输入内容', {icon: 5});
                        }
                        $(".layui-layer-btn0").css("pointer-events", "none");
                        $.ajax({
                            url: '/meeting/updMeetStatusById',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                sid: sid,
                                status: status,
                                reason: $(elem).find('textarea')[0].value,
                            },
                            success: function (obj) {
                                if (obj.flag) {
                                    $.layerMsg({content: '操作成功！', icon: 1}, function () {
                                        //更新列表
                                        listByStatus(cycle, queryStatus)
                                        //更新数量
                                        //各个状态的数量显示
                                        $.ajax({
                                            url: '/meeting/queryCountByStatu',
                                            type: 'get',
                                            dataType: 'json',
                                            success: function (obj) {
                                                var data = obj.object;
                                                $("#pendingCount").html(data.pendingCount);
                                                $("#cyclePendingCount").html(data.cyclePendingCount);
                                                $("#approvedCount").html(data.approvedCount);
                                                $("#processingCount").html(data.processingCount);
                                                $("#notApprovedCount").html(data.notApprovedCount);
                                                $("#overCount").html(data.overCount);
                                            }
                                        });
                                        $(".layui-layer-btn0").css("pointer-events", "auto");
                                    })
                                }
                            }
                        });
                        layer.close(index);
                    }
                },
            )
        }
        var index = $('ul .one').index();
        if (index == 0) {
            $('.styleSet').eq(0).click();
        } else if (index == 3) {
            $('.styleSet').eq(3).click();
        }
    }

    //删除会议
    function delMeeting(sid) {
        $.layerConfirm({
            title: '<fmt:message code="meet.th.DeleteSession" />',
            content: '<fmt:message code="meet.th.DeterminesRecovered" />！',
            icon: 0
        }, function () {
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
                        listByStatus(cycle, queryStatus)
                        //更新数量
                        //各个状态的数量显示
                        $.ajax({
                            url: '/meeting/queryCountByStatu',
                            type: 'get',
                            dataType: 'json',
                            success: function (obj) {
                                var data = obj.object;
                                $("#pendingCount").html(data.pendingCount);
                                $("#cyclePendingCount").html(data.cyclePendingCount);
                                $("#approvedCount").html(data.approvedCount);
                                $("#processingCount").html(data.processingCount);
                                $("#notApprovedCount").html(data.notApprovedCount);
                                $("#overCount").html(data.overCount);
                                var index = $('ul .one').index();
                                if (index == 0) {
                                    $('.styleSet').eq(0).click();
                                } else if (index == 3) {
                                    $('.styleSet').eq(3).click();
                                } else if (index == 4) {
                                    $('.styleSet').eq(4).click();
                                }
                            }
                        });
                    })
                }
            });
        })
    }

    //结束会议
    function endMeeting(sid, status) {
        $.layerConfirm({
            title: '<fmt:message code="meet.th.leaveTheChair" />',
            content: '<fmt:message code="meet.th.EndMeeting" />？',
            icon: 0
        }, function () {
            $.ajax({
                url: '/meeting/updMeetStatusById',
                type: 'get',
                dataType: 'json',
                data: {
                    sid: sid,
                    status: status
                },
                success: function (obj) {
                    if (obj.flag) {
                        $.layerMsg({content: '<fmt:message code="meet.th.EndSuccess" />！', icon: 1}, function () {
                            //更新列表
                            listByStatus(cycle, queryStatus)
                            //更新数量
                            //各个状态的数量显示
                            $.ajax({
                                url: '/meeting/queryCountByStatu',
                                type: 'get',
                                dataType: 'json',
                                success: function (obj) {
                                    var data = obj.object;
                                    $("#pendingCount").html(data.pendingCount);
                                    $("#cyclePendingCount").html(data.cyclePendingCount);
                                    $("#approvedCount").html(data.approvedCount);
                                    $("#processingCount").html(data.processingCount);
                                    $("#notApprovedCount").html(data.notApprovedCount);
                                    $("#overCount").html(data.overCount);
                                    var index = $('ul .one').index();
                                    if (index == 1) {
                                        $('.styleSet').eq(1).click();
                                    } else if (index == 2) {
                                        $('.styleSet').eq(2).click();
                                    }
                                }
                            });
                        })
                    }
                }
            });
        })
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
                        /* skin: 'layui-layer-rim', //加上边框 */
                        offset: '80px',
                        area: ['800px', '400px'], //宽高
                        title: "<fmt:message code="meet.th.ViewParticipants" />",
                        closeBtn: 1,
                        content:
                            '<div class="mainRight attendContent">' +
                            '<a href="/meeting/queryAttendConfirm?export=true&meetingId=' + meetingId + '" class="btnSpan" style="float: right;margin: 10px;">导出</a>' +
                            '<div class="pagediv" style="margin: 0 auto;width: 98%;" id="showList">' +
                            '<table><thead>' +
                            '<tr> <th><fmt:message code="workflow.th.Serial" /></th><th><fmt:message code="userDetails.th.name" /></th> <th><fmt:message code="workflow.th.sector" /></th> <th><fmt:message code="userManagement.th.role" /></th><th>打卡状态</th><th>打卡时间</th><th><fmt:message code="hr.th.Explain" /></th></tr>' +
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
                                    '<td>' + data[i].userPrivName + '</td>' + '<td>' + data[i].attendFlagStr + '</td>' + '<td>' + data[i].confirmTime + '</td>' + '<td>' + data[i].remark + '</td>' +
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
                        /* skin: 'layui-layer-rim', //加上边框 */
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

    //初始化申请管理员下拉列表(修改弹框)
    /*function initManager(){
        $.ajax({
            url: '/syspara/getUserName',
            type: 'get',
            dataType: 'json',
            data: {
                paraName:"MEETING_MANAGER_TYPE"
            },
            success: function (obj) {
                var data=obj.object;
                var managerIdArray=data.paraValue.split(",");
                var managerNameArray=data.userName.split(",");
                var str="";
                for(var i=0;i<managerIdArray.length;i++){
                    str+='<option value="'+managerIdArray[i]+'">'+managerNameArray[i]+'</option>';
                }
                $(".managerId").html(str);
            }
        });
    }*/

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

    //初始化会议室下拉列表(修改弹框)
    function initMeetRoom() {
        $.ajax({
            url: '../../meetingRoom/getAllMeetRoom',
            type: 'get',
            dataType: 'json',
            async: false,
            success: function (obj) {
                var data = obj.obj;
                var str = "";
                for (var i = 0; i < data.length; i++) {
                    str += '<option value="' + data[i].sid + '">' + data[i].mrName + '</option>';
                }
                str += "<option value='0'>视频会议</option>";
                $(".meetRoomId").html(str);
            }
        });
    }

    //修改会议
    $('.pagediv').on('click', '.editData', function (event) {
        var sid = $(this).attr("sid");
        event.stopPropagation();
        layer.open({
            type: 1,
            title: ['<fmt:message code="meet.th.Editorial" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['600px', '500px'],
            shadeClose: true, //点击遮罩关闭
            btn: ['<fmt:message code="global.lang.save" />', '<fmt:message code="global.lang.close" />'],
            content: '<div class="div_table" style="margin-left: 15px;">' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="workflow.th.name" />：</span><span><input type="text" style="width: 180px;" name="typeName" class="inputTd meetName test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="email.th.main" />：</span><span><input type="text" style="width: 180px;" name="typeName" class="inputTd subject test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span><span><div class="inPole"><textarea name="txt" dataid="" class="userName test_null" id="userDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectUser" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearUser" class="clearUser "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                '<div class="div_tr"><span class="span_td">联系电话：</span><span><input type="text" style="width: 180px;" name="mobileNo" class="inputTd mobileNo test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span><span><div class="inPole"><textarea name="txt" dataid="" class="recorderName" id="recoderDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectRecorder" class="Add "><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearRecoder" class="clearRecoder "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span><span><select name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span><span><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span><span>从</span><span><input type="text" style="width: 140px;" name="typeName" class="inputTd startTime test_null" value=""  /></span><span><fmt:message code="global.lang.to" /></span><span><input type="text" style="width: 140px;" name="typeName" class="endTime test_null" value="" /></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                '<div class="div_tr"><span class="span_td">是否是视频会议：</span> ' +
                '<span><input style="height:auto" type="radio" name="isVideo" class="isVideo" value="1" >是</span>' +
                '<span><input style="height:auto"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" >否</span>' +
                '</div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span><span><select name="typeName" class="managerId test_null" id="managerId"></select></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="min-width: 220px;min-height:58px;"></textarea></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.internal" />：</span><span><div class="inPole"><textarea name="txt" class="attendee" id="attendeeDuser" user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span><span style="color: #FF0000;margin-left: 10px;font-size: 16px;">*</span></div>' +
                /*前台会议服务人员*/
                '<div class="div_tr"><span class="span_td">前台会议服务人员：</span><span><div class="inPole"><textarea name="serviceUser" id="serviceUser"  user_id="" value="" disabled style="min-width: 220px;min-height:60px;"></textarea><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addServiceUser"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearServiceUser"><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span><span><div class="inPole"><textarea name="txt" id="equipmentId" class="equipmentId" equipmentId="" disabled style="min-width: 220px;min-height:60px;"></textarea></span>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="addEquipment" class="addEquipment"><fmt:message code="global.lang.add" /></a></span>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearEquipment" class="clearEquipment"><fmt:message code="global.lang.empty" /></a></div></span></div>' + '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.WriteSchedule" />：</span><span><input type="checkbox" id="isWriteCalendar" class="isWriteCalendar"></span><span><fmt:message code="meet.th.Yes" /></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind" class="smsRemind"></span><span>事务通知</span><span><input type="checkbox" id="sms2Remind" class="sms2Remind"></span><span><fmt:message code="meet.th.SMSReminder" /></span><span><fmt:message code="meet.th.Advance" /></span><input type="text" name="resendHour" id="resendHour" class="resendHour" style="width:30px;"><span><fmt:message code="meet.th.hour" /></span><input type="text"class="resendMinute" id="resendMinute" style="width:30px;"><span><fmt:message code="meet.th.Reminder" /></span></div>' +
                '<div class="div_tr"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span><span><div class="inPole"><textarea name="meetDesc" id="meetDesc" class="meetDesc" value="" style="min-width: 300px;min-height:60px;"></textarea></div></span></div>' +
                '</div>',
            success: function () {
                laydate.render({
                    elem: '.startTime'
                    , type: 'datetime'
                    , trigger: 'click'
                });
                laydate.render({
                    elem: '.endTime'
                    , type: 'datetime'
                    , trigger: 'click'
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
                        initManager($(this).val());
                        $("input[name='isVideo']").each(function () {
                            $(this).prop("disabled", false);
                        });
                    }
                });
                //会议室
                initMeetRoom();
                //审批管理员
                initManager($('#meetRoomId').val());
                $.ajax({
                    url: '/meeting/queryMeetingById',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        sid: sid
                    },
                    success: function (obj) {
                        var data = obj.object;
                        $(".meetName").val(data.meetName);
                        $(".subject").val(data.subject);
                        $(".userName").val(data.userName);
                        $(".userName").attr("dataid", data.uid);
                        $(".recorderName").val(data.recorderName);
                        $(".recorderName").attr("dataid", data.recorderId);
                        $(".startTime").val(data.startTime);
                        $(".endTime").val(data.endTime);
                        $(".attendeeOut").val(data.attendeeOut);
                        $(".attendee").val(data.attendeeName);
                        $(".attendee").attr("dataid", data.attendee);
                        /*回显前台会议服务人员*/
                        $("#serviceUser").val(data.serviceUserName);
                        $("#serviceUser").attr("dataid", data.serviceUser);
                        $("#serviceUser").attr("user_id", data.serviceUserUserId);
                        /*$(".equipmentId").val()*/
                        if (data.isWriteCalednar == 1) {
                            $(".isWriteCalendar").attr("checked", true);
                        }
                        if (data.smsRemind == 0) {
                            $(".smsRemind").attr("checked", true)
                        }
                        if (data.sms2Remind == 0) {
                            $(".sms2Remind").attr("checked", true);
                        }
                        $(".resendHour").val(data.resendHour);
                        $(".resendMinute").val(data.resendMinute);
                        $(".meetDesc").val(data.meetDesc);
                        //会议室
                        $("#meetRoomId").val(data.meetRoomId);
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
                        $("#managerId").val(data.managerId);

                        $(".equipmentId").val(data.equipmentNames);
                        $(".equipmentId").attr("equipmentId", data.equipmentIds);
                        $('.mobileNo').val(data.mobileNo)
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
                        }
                    })
                })
            },
            yes: function (index) {
                var array = $(".test_null");
                for (var i = 0; i < array.length; i++) {
                    if (array[i].value == "") {
                        $.layerMsg({content: "<fmt:message code="sup.th.With*" />", icon: 2}, function () {
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
                if ($('#attendeeDuser').val() == "") {
                    $.layerMsg({content: '请添加出席人员（内部）', icon: 2});
                    return false;
                }
                var recorderId = $(".recorderName").attr("dataid");
                if (recorderId != "" && recorderId.indexOf(",") >= 0) {
                    recorderId = recorderId.substr(0, recorderId.length - 1);
                }
                var uid = $(".userName").attr("dataid");
                if (uid != "" && uid.indexOf(",") >= 0) {
                    uid = uid.substr(0, uid.length - 1);
                }

                var paraData = {
                    sid: sid,
                    meetName: $(".meetName").val(),
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
                    mobileNo: $('.mobileNo').val(),
                    videoConfFlag: $('.isVideo:checked').val(),
                    serviceUser: $("#serviceUser").attr("dataid"),
                }

                $.ajax({
                    url: '/meeting/updateMeetingById',
                    type: 'get',
                    dataType: 'json',
                    data: paraData,
                    success: function (obj) {
                        $.layerMsg({
                            content: '<fmt:message code="depatement.th.Modifysuccessfully" />！',
                            icon: 1
                        }, function () {
                            //更新列表
                            listByStatus(cycle, queryStatus);
                        })
                        layer.close(index);

                    }
                })
            },
        });
        $('#selectUser').on("click",function () {//选人员控件(申请人)
            user_id = 'userDuser';
            $.popWindow("../common/selectUser?0");
        });
        $('#selectRecorder').on("click",function () {//选人员控件（纪要员）
            user_id = 'recoderDuser';
            $.popWindow("../common/selectUser?0");
        });
        $('#selectAttendee').on("click",function () {//选人员控件（出席内部人员）
            user_id = 'attendeeDuser';
            $.popWindow("../common/selectUser");
        });
        $(document).on('click', '#addServiceUser', function () {//选人员控件（前台会议服务人员）
            user_id = 'serviceUser';
            $.popWindow("../common/selectUser");
        });
        $('#clearUser').on("click",function () { //清空人员(申请人)
            $('#userDuser').attr('user_id', '');
            $('#userDuser').attr('dataid', '');
            $('#userDuser').val('');
        });
        $('#clearRecoder').on("click",function () { //清空人员（纪要员）
            $('#recoderDuser').attr('user_id', '');
            $('#recoderDuser').attr('dataid', '');
            $('#recoderDuser').val('');
        });
        $('#clearAttendee').on("click",function () { //清空人员（出席内部人员）
            $('#attendeeDuser').attr('user_id', '');
            $('#attendeeDuser').attr('dataid', '');
            $('#attendeeDuser').val('');
        });
        $(document).on('click', '#clearServiceUser', function () { //清空人员（前台会议服务人员）
            $('#serviceUser').attr('user_id', '');
            $('#serviceUser').attr('dataid', '');
            $('#serviceUser').val('');
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
                btn: ['<fmt:message code="menuSSetting.th.menusetsure" />'],
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

    //点击会议名称显示会议详情
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
                if (data.attachmentList.length > 0) {
                    for (var i = 0; i < data.attachmentList.length; i++) {
                        str += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png"/><a href="/download?' + data.attachmentList[i].attUrl + '">' + data.attachmentList[i].attachName + '</a></div>'
                    }
                } else {
                    str = '';
                }
                layer.open({
                    type: 1,
                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                    area: ['600px', '500px'],
                    shadeClose: true, //点击遮罩关闭
                    btn: ['打印', '<fmt:message code="global.lang.close" />'],
                    content: '<div id="table"><div class="table"><table style="margin:auto;" class="detailTable">' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="workflow.th.name" />：</span></td><td><span>' + data.meetName + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="email.th.main" />：</span></td><td><span>' + data.subject + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="sup.th.Applicant" />：</span></td><td><span>' + data.userName + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td">联系电话：</span></td><td><span>' + data.mobileNo + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="meet.th.MeetingMinutesClerk" />：</span></td><td><span>' + data.recorderName + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="sup.th.ApplicationTime" />：</span></td><td><span>从 &nbsp;</span><span>' + data.startTime + '</span><span>&nbsp;<fmt:message code="global.lang.to" />&nbsp;</span><span>' + data.endTime + '</span></td><tr>' +
                        '<tr><td class="tabletd" width="30%"><span class="span_td"><fmt:message code="meet.th.ConferenceRoom" />：</span></td><td><span>' + data.meetRoomName + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ApprovalAdministrator" />：</span></td><td><span>' + data.managerName + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.external" />：</span></td><td><span>' + data.attendeeOut + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.internal" />：</span></td><td><span>' + data.attendeeName + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td">前台会议服务人员：</span></td><td><span>' + (data.serviceUserName || '') + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ConferenceRoomEquipment" />：</span></td><td><span>' + data.equipmentNames + '</span></td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="email.th.file" />：</span></td><td><span><div class="inPole">' + str + '</td><tr>' +
                        '<tr><td class="tabletd"><span class="span_td"><fmt:message code="meet.th.ConferenceDescription" />：</span></td><td><span>' + data.meetDesc + '</span></td><tr>' +
                        '</table></div></div>',
                    success: function () {
                        $('#table td').css({
                            "overflow": "hidden",
                            "text-overflow": "ellipsis",
                            "white-space": "nowrap",
                            "padding": 0,
                        });
                        if (data.status == 1 || data.status == 4) {
                            $(".layui-layer-btn0").css("display", "none")
                        }
                    },
                    yes: function () {
                        $('#table').jqprint({
                            debug: false,
                            importCSS: true,
                            printContainer: true,
                            operaSupport: false
                        });
                    }
                })
            }
        })
        //进行签阅
        $.ajax({
            url: '/meeting/readMeeting',
            type: 'get',
            dataType: 'json',
            data: {
                meetingId: $(this).attr("sid")
            },
            success: function (obj) {

            }
        })
    })

    //获取所有会议室
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
                        + "<td  class='oneTd' style='text-align: left;padding: 10px; width:100px'><fmt:message code="meeting.meetingName" /></td>";
                    for(var i = 0;i<24 ; i++){
                        tableStr = tableStr  + "<td width='28px'style='padding: 10px 0;text-align: left;' id='HOUR_"+i+"'>" + i + "</td>";
                    }
                    tableStr = tableStr +"</tr>";
                    for (var j=0;j<data.length;j++){
                        tableStr = tableStr + "<tr class=''>"
                            + "<td  align='left' class='TableData' style='text-align: left;padding: 0 0 0 10px;width:150px'>" + data[j].mrName + "</td>";
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
                var endHour = ""
                var offsetL = ""
                for(var i=0;i<data.length;i++){
                    var dataChild=data[i].meetingWithBLOBs;
                    var str='';
                    if(dataChild.length>0){
                        for(var j=0;j<dataChild.length;j++){
                            var starTime=dataChild[j].startTime.substr(11,5);  //显示的开始时间
                            var starFen=dataChild[j].startTime.substr(14,2);  //开始时间的分钟
                            var endTime=dataChild[j].endTime.substr(11,5);  //显示的结束时间
                             offsetL=parseInt(dataChild[j].startTime.substr(11,2));  //开始时间的小时
                            var endFen=dataChild[j].endTime.substr(14,2);   //结束时间的分钟
                             endHour=dataChild[j].endTime.substr(11,2);   //结束时间的小时
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
                                '<div style="text-align: left;" title="'+starTime+'--'+endTime+'">'+starTime+'<br><span class="endTime" id="">'+endTime+'</span></div>' +
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
                if (endHour-offsetL<=1){
                    $(".endTime").attr("id","endTime")
                }
            }
        })
    }

    $(window).resize( function  () {
        //当浏览器大小变化时
        var timeStr = $("#timeChoose").val();
        getAllRoom(timeStr)
    });

    //显示会议使用时间段
    function getMeetRoomTime(toData) {
        $("td[name='MEET_ROOM_TD']").empty();
        var widthTd = $("td[name='MEET_ROOM_TD']").width();
        var presonWidth = parseInt(widthTd / 24);
//	    console.log(presonWidth)
        //清空数据
    }

    //时间控件调用
    var start = {
        format: 'YYYY/MM/DD hh:mm',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        format: 'YYYY/MM/DD hh:mm',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    //点击二维码后的弹框attendQR
    $('#showList').on('click', '.attendQR', function () {
        var meetingId = $(this).attr('sid');
        $.ajax({
            type: 'get',
            url: '/meeting/updateCreateQrcodeTimeBySid',
            dataType: 'json',
            data: {
                sid: meetingId
            },
            success: function (res) {

            }
        });
        layer.open({
            type: 1,
            /* skin: 'layui-layer-rim', //加上边框 */
            offset: '80px',
            area: ['650px', '400px'], //宽高
            title: "二维码打卡",
            closeBtn: 1,
            content: '<div class="qrTotal" style="position:relative">' +
                '<div class="qrCenter" style="position:absolute;left:50%;top:50%;margin-left: -122px;margin-top: 40px;">' +
                '<span class="showQRCode" id="showQRCodes"  style="display: inline-block;"></span>' +
                '</div>' +
                '</div>',
            btn: ['<fmt:message code="global.lang.close" />'],
            success: function () {
                getQrcode(meetingId)
                timer = setInterval(function () {
                    getQrcode(meetingId)
                }, 25000)
            },
            end: function (index) {
                clearInterval(timer);
                timer = null;
                layer.close(index);
            }
        })
    })


    // 生成二维码的方法
    function getQrcode(meetingId) {
        $.ajax({
            type: 'get',
            url: '/meeting/updateCreateQrcodeTimeBySid',
            dataType: 'json',
            data: {
                sid: meetingId
            },
            success: function (res) {
                document.getElementById("showQRCodes").innerHTML = "";
                var qrcode = new QRCode(document.getElementById("showQRCodes"), {
                    width: 250,//设置宽高
                    height: 250
                });
                str = '{"mark":"SID_MEETING","sid":' + meetingId + '}';
                qrcode.makeCode(str);
            }
        });

    }

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

    //表哥列宽拉伸效果
    $("th").on("mouseover",function (e) {
        if (($(this).find("div").length <= 0)) {
            //1.鼠标移动到表头上时，在th内部添加一个div 元素，用于处理后续拖动事件
            $(this).append("<div class='th-sisehandler'></div>")

            //2.处理上面添加的元素的鼠标按下事件
            $(".th-sisehandler").on("mousedown",function (evt) {
                //3.在添加的元素上按下时，记录下当前的th表头
                let dragTh = $(this).parent()


                //4.记录按下时的鼠标位置
                let oldClientX = evt.clientX;
                //5.获取当前鼠标按下时的表头的宽度
                let oldWidth = dragTh.width();
                /*6.添加一个全局layer层，用于处理鼠标按下时鼠标移动事件，因为不能在第一步添加的元素上处理鼠标移动事件，添加的元素太小，
                    鼠标容易跑出范围，就捕获不到后续事件
                    所以添加一个全局的遮罩层，捕获鼠标移动事件。
                 */

                let changeSizeLayer = $('<div class="siselayer"></div>');
                $("body").append(changeSizeLayer);

                changeSizeLayer.on('mousemove', function (evt) {
                    //7.处理遮罩层的鼠标移动事件，计算新的表头宽度
                    var newWidth = evt.clientX - oldClientX + oldWidth;
                    //设置新的宽度
                    dragTh.attr('width', Math.max(newWidth, 1));

                });

                changeSizeLayer.on('mouseup', function (evt) {
                    //8.鼠标按键复位时，要清楚遮罩层
                    changeSizeLayer.remove();
                    dragTh.find('.th-sisehandler').remove();
                });
            })
        }

        $(this).on("mouseleave",function () {
            //9.鼠标离开表头时，要移除第一步添加的div
            $(this).find("div").remove()
        })
    })
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
