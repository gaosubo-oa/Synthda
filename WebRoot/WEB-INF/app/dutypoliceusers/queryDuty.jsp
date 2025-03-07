<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="../../lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" type="text/css" href="../../css/FullCalendar/style.css"/>
    <link rel="stylesheet" type="text/css" href="../lib/laydate.css"/>
    <script src="../../lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/xoajq/xoajq1.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="../../lib/fullcalendar/fullcalendar.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layer/layer.js?20201106"></script>
    <script src="../lib/laydate/laydate.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../js/jquery/jquery.cookie.js"></script>
    <script src="../js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="../../lib/layui/layui/layui.js"></script>
    <title>值班安排查询</title>
    <style>
        .fc-event-skin {
            border-color: #36c !important;
            background-color: #36c !important;
            color: #fff !important;
        }

        .control-group {
            text-align: center;
            margin-top: 15px;
        }

        .modal-body input[type=text] {
            padding-left: 5px;
        }

    </style>
    <style>
        body {
            position: relative;
        }

        .smallSelect {
            margin-left: 50px;
        }

        .CAL_CONTENT {
            margin-left: 50px;
        }

        .modal-header {
            margin-left: 20px;
        }

        .text_boder {
            width: 275px;
            height: 26px;
            border-radius: 4px;
            color: rgb(169, 169, 169);
        }

        .row-fluid {
            border-top-color: #3c8dbc !important;
            border-top-width: 3px;
        }

        .fc-header {
            background: #fff;
        }

        .content .box {
            border: none;
        }

        .content {
            background-color: #fff;
            /*position: relative;*/
        }

        body {
            margin: 0px;
        }

        body {
            background: url("") repeat !important;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        input {
            color: rgb(169, 169, 169) !important;
        }

        thead {
            background: #eee;
        }

        .fc-header tr {
            height: 30px;
        }

        .fc table {
            margin-bottom: -5px;
        }

        .fc-header-title h2 {
            margin-top: 0;
            white-space: nowrap;
            font-weight: 500;
        }

        thead tr th {
            font-weight: 500;
        }

        .fc-day-number {
            font-weight: 300;
        }

        .layui-layer-title {
            padding: 0 80px 0 20px;
            height: 42px;
            line-height: 42px;
            border-bottom: 1px solid #eee;
            font-size: 16px;
            color: #fff;
            overflow: hidden;
            background-color: #2b7fe0;
            border-radius: 2px 2px 0 0;
        }

        input {
            /*-webkit-appearance: textfield;*/
            background-color: white;
            -webkit-rtl-ordering: logical;
            user-select: text;
            cursor: auto;
            padding: 1px;
            border-width: 1px !important;
            border-style: inset;
            border-color: initial;
            border-image: initial;
            color: black !important;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        input, textarea, select, button {
            text-rendering: auto;
            color: initial;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0px;
            text-shadow: none;
            display: inline-block;
            text-align: start;
            margin: 0em 0em 0em 0em;
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
            color: black !important;
        }

        input, textarea, select, button, meter, progress {
            -webkit-writing-mode: horizontal-tb;
        }

        .CAL_LEVEL {
            height: 29px;
        }

        .layui-layer-page .layui-layer-btn {
            /*text-align: center;*/
        }

        .fc-state-highlight {
            background-color: #beddff !important;
        }

        input[placeholder], [placeholder], *[placeholder] {
            color: black !important;
        }

        :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #000;
            opacity: 1;
        }

        ::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #000;
            opacity: 1;
        }

        input:-ms-input-placeholder {
            color: #000;
            opacity: 1;
        }

        input::-webkit-input-placeholder {
            color: #000;
            opacity: 1;
        }

        :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #000;
            opacity: 1;
        }

        ::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #000;
            opacity: 1;
        }

        textarea:-ms-input-placeholder {
            color: #000;
            opacity: 1;
        }

        textarea::-webkit-input-placeholder {
            color: #000;
            opacity: 1;
        }

        .style_a {
            margin-left: 5px;
            margin-bottom: 5px;
        }

        .title {
            padding-left: 27px;
            height: 45px;
            line-height: 50px;
            border-bottom: 1px solid #ccc;
            font-size: 22px;
            color: rgb(73, 77, 89);
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        .fc table {
            margin-bottom: 0px;
        }

        .colorClass a {
            display: inline-block;
            width: 16px;
            height: 16px;
            vertical-align: middle;
        }

        .colorClass {
            position: absolute;
            right: 27px;
            top: 13px;
        }

        .select select {
            height: 30px;
            border-radius: 3px;
        }

        .ownerOrgAdd1 {
            text-decoration: none;
            padding: 0 10px;
            color: #1772c0;
        }

        .control-group span {
            display: inline-block;
            width: 100px;
        }
        .ownerOrgClear1{
            text-decoration: none;
            color: red;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="title" style=" background: #fff;">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dayQuery.png" alt="" style="vertical-align: middle">
        <div style='height: 45px;display:inline-block;line-height: 50px;border-bottom: 1px solid #ccc;font-size: 22px;color: rgb(73, 77, 89);font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;'>
            值班安排查询
        </div>
        <button type="button" class="layui-btn layui-btn-sm import" style="float: right;margin-right: 2%;margin-top:10px;"><span style="color: white">导入</span></button>
    <%--<button id="" style="margin-left:40px;margin-right:20px;">今天</button>--%>
    </div>
    <div class="content">
        <div class="row-fluid">
            <div class="span12">
                <div class="box">
                    <div class="box-content box-nomargin">
                        <div class="calendar" id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var arr = [];
    var searchArr = [];
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var timestamp = Date.parse(new Date());
    var timestamp = timestamp / 1000;
    //使下拉列表显示当前日期
    var yearArray = $("#selectYear option")
    for (var i = 0; i < yearArray.length; i++) {
        if (yearArray[i].value == y) {
            $($("#selectYear  option")[i]).attr("selected", true)
        }
    }
    var monthArray = $("#selectMonth option")
    for (var i = 0; i < monthArray.length; i++) {
        if (monthArray[i].value == m + 1) {
            $($("#selectMonth  option")[i]).attr("selected", true)
        }
    }

    //初始化下拉列表日
    function initselDay() {//获取本月的天数
        var month = parseInt(m + 1, 10);
        var d = new Date(y, month, 0);
        var monthArray = $("#selectDay option");
        var dayOpt;
        for (var i = 0; i < d.getDate(); i++) {
            dayOpt += '<option value=' + (i + 1) + '>' + (i + 1) + "<fmt:message code="attend.th.day"/>" + '</option>';
        }
        $("#selectDay").html(dayOpt);
    }
    //获取当前日期是本年度的第几周
    Date.prototype.getWeekOfYear = function (weekStart) { // weekStart：每周开始于周几：周日：0，周一：1，周二：2 ...，默认为周日
        weekStart = (weekStart || 0) - 0;
        if (isNaN(weekStart) || weekStart > 6)
            weekStart = 0;

        var year = this.getFullYear();
        var firstDay = new Date(year, 0, 1);
        var firstWeekDays = 7 - firstDay.getDay() + weekStart;
        var dayOfYear = (((new Date(year, this.getMonth(), this.getDate())) - firstDay) / (24 * 3600 * 1000)) + 1;
        return Math.ceil((dayOfYear - firstWeekDays) / 7) + 1;
    }
    var date = new Date(); // 注意：JS 中月的取值范围为 0~11
    var weekOfYear = date.getWeekOfYear(); // 当前日期是本年度第几周


    //判断是否是闰年
    function isLeapYear(year) {
        return (0 == year % 4 && ((year % 100 != 0) || (year % 400 == 0)));
    }
    $(document).ready(function () {
        //alert("加载开始1");
        var timestamp = Date.parse(new Date());
        var timestamp = timestamp / 1000;

        $.ajax({
            url: "/DutyPoliceUsers/findDutyPoliceWhere",
            type: "get",
            dataType: "json",
            success: function (data) {
                var arrObject;
                for (var i = 0; i < data.obj.length; i++) {
                    var arrObject = {
                        title: '局带班:' + esName(data.obj[i].btreeUsersName)+
                            '\n局值班：'+esName(data.obj[i].bdutyUsersName)+
                            '\n总站带班：'+esName(data.obj[i].ttreeUsersName)+
                            '\n总站值班：'+esName(data.obj[i].tdutyUsersName)+
                            '\n操作员：'+esName(data.obj[i].operatingUsers)+
                            '\n总站备勤：'+esName(data.obj[i].preparationUsersName)+
                            '\n中心值班长：'+esName(data.obj[i].cbigUsersName)+
                            '\n中心值班员：'+esName(data.obj[i].cpersonUsersName),
                        start: data.obj[i].dutyDate,
                        end: data.obj[i].dutyDate,
                        id: data.obj[i].dutyId,
                        color: "#ff5757",
                        backgroundColor: "#ff5757"
                    };
                    arr.push(arrObject);
                }
                if ($('#calendar').length > 0) {
                    var timestamp = Date.parse(new Date());
                    var timer = parseInt(timestamp) + 3600000;
                    var startTime = new Date(timestamp).Format('hh:mm:ss');
                    var endTime = new Date(timer).Format('hh:mm:ss');
                    $('#calendar').fullCalendar({
                        header: {
                            left: 'prev,next,today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'
                        },
                        buttonText: {
                            today: '<fmt:message code="meet.th.JumpthDay"/>'
                        },
                        editable: true,
                        events: arr,
                        dayClick: function (date, allDay, jsEvent, view) {
                            layer.open({
                                type: 1,
                                offset: '80px',
                                area: ['500px', 'auto'], //宽高
                                title: "值班新增",
                                closeBtn: 2,
                                content: '<div id="myModal" class="modal hide in">' +
                                '<div class="modal-header"></div>' +
                                '<div class="modal-body" id="new_modal">' +
                                '<div class="control-group"><span style="margin-left: -24px;">值班时间:</span>' +
                                '<input id="dutyDate" class="text_boder test_null" style="margin-right: 35px;" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})">' +
                                '<b style="color:red;font-size:25px;font-weight: normal">*</b></div>' +
                                '<div class="control-group"><span>局带班:</span><textarea id="btreeUsers"  rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>局值班:</span><textarea id="bdutyUsers"  rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>总站带班:</span><textarea id="ttreeUsers"  class="BigStatic" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>总站值班:</span><textarea id="tdutyUsers"  rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>操作员:</span><textarea id="operatingUsers" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>总站备勤:</span><textarea id="preparationUsers" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>中心值班长:</span><textarea id="cbigUsers" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group"><span>中心值班员:</span><textarea id="cpersonUsers" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;"></textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                '<div class="control-group items" style="margin-right: 75px;"><span>事务提醒:</span><input type="checkbox" class="remind" checked="checked" style="width:16px;height: 16px;vertical-align: middle;">发送事务提醒消息&nbsp;&nbsp;<input type="checkbox" class="smsRemind" style="width:16px;height: 16px;vertical-align: middle;">使用手机短信提醒</div>' +
                                '<div class="control-group"><span style="margin-left:-29px">事务提醒内容:</span><textarea cols="35" id="content" rows="2" class="BigStatic" wrap="yes"  style="width: 273px;border-radius:4px;vertical-align: middle;margin-right: 40px;height: 60px;margin-left:9px"></textarea><b style="color:red;font-size:25px;font-weight: normal;">*</b></div>' +
                                '</div><div class="modal-footer"></div></div>',
                                btn: ['<fmt:message code="global.lang.save"/>'],
                                success:function () {
                                    // 查询提醒权限
                                    $.ajax({
                                        type:'get',
                                        url:'/smsRemind/getRemindFlag',
                                        dataType:'json',
                                        data:{
                                            type:77
                                        },
                                        success:function (res) {
                                            if(res.flag){
                                                if(res.obj.length>0){
                                                    var data = res.obj[0];
                                                    // 是否默认发送
                                                    if(data.isRemind=='0'){
                                                        $('.remind').prop("checked", false);
                                                    }else if(data.isRemind=='1'){
                                                        $('.remind').prop("checked", true);
                                                    }
                                                    // 是否手机短信默认提醒
                                                    if(data.isIphone=='0'){
                                                        $('.smsRemind').prop("checked", false);
                                                    } else if (data.isIphone=='1'){
                                                        $('.smsRemind').prop("checked", true);
                                                    }
                                                    // 是否允许发送事务提醒
                                                    if(data.isCan=='0'){
                                                        $('.remind').prop("checked", false);
                                                        $('.smsRemind').prop("checked", false);
                                                        $('.items').hide();
                                                    }

                                                }
                                            }
                                        }
                                    })
                                    $(".ownerOrgAdd1").on("click",function(){
                                        user_id=$(this).prev().attr('id');
                                        $.popWindow("../common/selectUser");
                                    });
                                    $(".ownerOrgClear1").on("click",function(){
                                        $(this).siblings('textarea').val("");
                                        $(this).siblings('textarea').attr('user_id','');
                                    })
                                },
                                yes: function (index, layero) {
                                    if ($('#dutyDate').val()==''){
                                        layer.msg('值班时间不能为空', { icon:6});
                                        return false;
                                    }
                                    if ($('#content').val()==''){
                                        layer.msg('事务提醒内容不能为空', { icon:6});
                                        return false;
                                    }

                                    $.ajax({
                                        url: '/DutyPoliceUsers/editOrInsertDuty',
                                        data: {
                                            dutyDate:$('#dutyDate').val(),
                                            btreeUsers:$('#btreeUsers').attr('user_id'),
                                            bdutyUsers:$('#bdutyUsers').attr('user_id'),
                                            ttreeUsers:$('#ttreeUsers').attr('user_id'),
                                            tdutyUsers:$('#tdutyUsers').attr('user_id'),
                                            operatingUsers:$('#operatingUsers').attr('user_id'),
                                            preparationUsers:$('#preparationUsers').attr('user_id'),
                                            cbigUsers:$('#cbigUsers').attr('user_id'),
                                            cpersonUsers:$('#cpersonUsers').attr('user_id'),
                                            content:$('#content').val(),
                                            remind:function(){
                                                if($('.remind').prop('checked')==false){
                                                    return '0';
                                                }else {
                                                    return '1';
                                                }
                                            },
                                            smsRemind:function(){
                                                if($('.smsRemind').prop('checked')==false){
                                                    return '0';
                                                }else {
                                                    return '1';
                                                }
                                            }
                                        },
                                        type:'post',
                                        dataType: 'json',
                                        success: function (res) {
                                            var msg='失败';
                                            if(res.flag) {
                                                msg='成功';
                                            }
                                            layer.msg(msg, { icon:6},function () {
                                                location.reload();
                                            });
                                        }
                                    })
                                },
                            });
                        },
                        eventClick: function (calEvent, jsEvent, view) {
                            var dutyId = calEvent.id
                            var type_map = ["<fmt:message code="attend.th.Worktransaction"/>", "<fmt:message code="attend.th.Persontransaction"/>"];
                            var level_map = ["<fmt:message code="attend.th.Importanturgent"/>", "<fmt:message code="attend.th.ImportantNourgent"/>", "<fmt:message code="attend.th.NOImportanturgent"/>", "<fmt:message code="attend.th.NOImportantNOurgent"/>"];
                            $.ajax({
                                url: '/DutyPoliceUsers/findDutyPoliceById',
                                data: {
                                    dutyId: dutyId
                                },
                                dataType: 'json',
                                success: function (res) {
                                    var data=res.object
                                    layer.open({
                                        type: 1,
                                        offset: '80px',
                                        area: ['500px', '400px'], //宽高
                                        title: "值班编辑与删除",
                                        closeBtn: 2,
                                        content: '<div id="myModal" class="modal hide in">' +
                                        '<div class="modal-header"></div>' +
                                        '<div class="modal-body" id="new_modal">' +
                                        '<div class="control-group"><span style="margin-left: 14px;">值班时间:</span>' +
                                        '<input id="dutyDate" class="text_boder test_null" style="margin-right:-14px" value="' +esName(data.dutyDate) + '" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" onclick="laydate({istime: true, format: \'YYYY-MM-DD\'})">' +
                                        '<span style="color:red;font-size:25px ">*</span></div>' +
                                        '<div class="control-group"><span>局带班:</span><textarea id="btreeUsers" user_id="'+esName(data.btreeUsers)+'"  rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.btreeUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>局值班:</span><textarea id="bdutyUsers"  user_id="'+esName(data.bdutyUsers)+'" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.bdutyUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>总站带班:</span><textarea id="ttreeUsers" user_id="'+esName(data.ttreeUsers)+'"  class="BigStatic" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.ttreeUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>总站值班:</span><textarea id="tdutyUsers" user_id="'+esName(data.tdutyUsers)+'"  rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.tdutyUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>操作员:</span><textarea id="operatingUsers" user_id="'+esName(data.operatingUsers)+'" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.operatingUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>总站备勤:</span><textarea id="preparationUsers" user_id="'+esName(data.preparationUsers)+'" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.preparationUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>中心值班长:</span><textarea id="cbigUsers" user_id="'+esName(data.cbigUsers)+'" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.cbigUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1"  class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span>中心值班员:</span><textarea id="cpersonUsers" user_id="'+esName(data.cpersonUsers)+'" rows="2" class="BigStatic" wrap="yes" readonly="" style="width: 273px;border-radius:4px;vertical-align: middle;">'+esName(data.cpersonUsersName)+'</textarea><a href="javascript:;" class="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="ownerOrgClear1" class="style_a"><fmt:message code="global.lang.empty"/></a></div>' +
                                        '<div class="control-group"><span style="margin-left:-29px">事务提醒内容:</span><textarea cols="35" id="content" rows="2" class="BigStatic" wrap="yes"  style="width: 273px;border-radius:4px;vertical-align: middle;margin-right: 40px;height: 60px;margin-left:9px">'+esName(data.content)+'</textarea><b style="color:red;font-size:25px;font-weight: normal;">*</b></div>' +
                                        '</div><div class="modal-footer"></div></div>',
                                        btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>', '<fmt:message code="global.lang.delete"/>'],
                                        success: function (layero, index) {
                                            $(".ownerOrgAdd1").on("click",function(){
                                                user_id=$(this).prev().attr('id');
                                                $.popWindow("../common/selectUser");
                                            });
                                            $(".ownerOrgClear1").on("click",function(){
                                                $(this).siblings('textarea').val("");
                                                $(this).siblings('textarea').attr('user_id','');
                                            })
                                        },
                                        //编辑日程接口
                                        yes: function (index, layero) {
                                            if ($('#dutyDate').val()==''){
                                                layer.msg('值班时间不能为空', { icon:6});
                                                return false;
                                            }
                                            if ($('#content').val()==''){
                                                layer.msg('事务提醒内容不能为空', { icon:6});
                                                return false;
                                            }
                                            $.ajax({
                                                url: '/DutyPoliceUsers/editOrInsertDuty',
                                                data: {
                                                    dutyId:dutyId,
                                                    dutyDate:$('#dutyDate').val(),
                                                    btreeUsers:$('#btreeUsers').attr('user_id'),
                                                    bdutyUsers:$('#bdutyUsers').attr('user_id'),
                                                    ttreeUsers:$('#ttreeUsers').attr('user_id'),
                                                    tdutyUsers:$('#tdutyUsers').attr('user_id'),
                                                    operatingUsers:$('#operatingUsers').attr('user_id'),
                                                    preparationUsers:$('#preparationUsers').attr('user_id'),
                                                    cbigUsers:$('#cbigUsers').attr('user_id'),
                                                    cpersonUsers:$('#cpersonUsers').attr('user_id'),
                                                    content:$('#content').val()
                                                },
                                                type:'post',
                                                dataType: 'json',
                                                success: function (res) {
                                                    var msg='失败';
                                                    if(res.flag) {
                                                        msg='成功';
                                                    }
                                                    layer.msg(msg, { icon:6},function () {
                                                        location.reload();
                                                    });
                                                }
                                            })
                                        },
                                        //删除日程接口
                                        btn3: function () {
                                            $.layerConfirm({
                                                title: '<fmt:message code="workflow.th.suredel"/>',
                                                content: '<fmt:message code="workflow.th.que"/>？',
                                                icon: 0
                                            }, function () {
                                                $.ajax({
                                                    url: "/DutyPoliceUsers/deleteDuty",
                                                    type: "post",
                                                    data: {
                                                        dutyIds:dutyId
                                                    },
                                                    dataType: "json",
                                                    success: function (res) {
                                                        var msg='失败';
                                                        if(res.flag) {
                                                            msg='成功';
                                                        }
                                                        layer.msg(msg, { icon:6},function () {
                                                            location.reload();
                                                        });
                                                    }
                                                })
                                            })
                                        }
                                     });
                                }
                            })

                        },
                    });
                }
                //月视图查询切换
                $(".fc-button-month").click(function () {
                    //alert("11111");
                    $("#selectMonth").show();
                    $("#selectDay").hide();
                    $("#selectWeek").hide();
                });
                //周视图查询切换
                $(".fc-button-agendaWeek").click(function () {
                    //alert("22222");
                    $("#selectMonth").hide();
                    $("#selectDay").hide();
                    $("#selectWeek").show();
                    var weekArray = $("#selectWeek option")
                    for (var i = 0; i < weekArray.length; i++) {
                        if (weekArray[i].value == weekOfYear) {
                            $($("#selectWeek  option")[i]).attr("selected", true)
                        }
                    }
                });
                //日视图查询切换
                $(".fc-button-agendaDay").click(function () {
                    //alert("33333");
                    $("#selectMonth").show();
                    $("#selectDay").show();
                    initselDay();
                    $("#selectWeek").hide();
                    var dayArray = $("#selectDay option")
                    for (var i = 0; i < dayArray.length; i++) {
                        if (dayArray[i].value == d) {
                            $($("#selectDay  option")[i]).attr("selected", true)
                        }
                    }
                });
            }
        });
    });



    function digui(datas, departId) {
        var data = new Array();
        for (var i = 0; i < datas.length; i++) {
            if (datas[i].deptParent == departId) {
                datas[i]["childs"] = digui(datas, datas[i].deptId);
                data.push(datas[i]);
            }
        }
        return data;
    }

    //时间控件调用
    var start = {
        format: 'YYYY-MM-DD',
        istime: true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        format: 'YYYY-MM-DD',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    //判断是否为空
    var esName=(name)=>{
        if (name!=undefined){
            return name;
        }
        return '';
    }

    layui.use(['form', 'layedit', 'laydate','layedit','table','upload'], function() {
        var form = layui.form
            , layer = layui.layer
            , laydate = layui.laydate
            , layedit = layui.layedit
            , table = layui.table
            , upload = layui.upload;

        $('.import').click(function () {
            layer.open({
                type: 1,
                title: ['数据导入'],
                area: ['600px', '400px'],
                shadeClose: true, //点击遮罩关闭
                content: '<form id="ajaxform" method="post" action="/DutyPoliceUsers/ImportDutyPolice"  enctype="multipart/form-data"><div style="text-align: center">' +
                    '<button type="button" class="layui-btn layui-btn-normal" attachmentId="" attachmentName="" id="test3" style="height: 50px;width: 190px;margin-top: 70px"><i class="layui-icon" style="color: white"></i><span style="color: white">选择文件</span></button>' +
                    '<div style="margin-top: 20px;font-size: 20px;"><a style="color: #03a9f4"  href="/ui/file/dutypoliceusers/值班管理导入模板.xls">下载导入模板</a></div>' +
                    '<hr style="height: 2px;margin-top: 100px;"/>' +
                    '<div><span style="color: #03a9f4;">特别提示：在执行导入数据前,请先备份数据库</span></div></div></from>',
                success: function () {
                    upload.render({
                        elem: '#test3'
                        , url: '/DutyPoliceUsers/ImportDutyPolice'
                        , accept: 'file' //普通文件
                        , done: function (res) {//返回值接收
                            if (res.flag) {
                                layer.msg('导入成功!');
                                window.location.reload();
                            }
                        }
                    });
                },
            });
        })
    })
</script>
</body>

</html>
