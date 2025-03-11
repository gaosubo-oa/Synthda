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
<title>会议室预订</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" type="text/css" href="/css/main/style.css" />
<link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
<link rel="stylesheet" href="/css/meeting/index.css?20220814">
<script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
<script src="../../lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
<script type="text/javascript" src="/lib/laydate/laydate.js"></script>
<script src="/lib/jQuery-File-Upload-master/jquery.fileupload.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/base/base.js?20190927.1"></script>

<script src="/js/module.js"></script>
<script src="/js/wdatepicker.js"></script>
<script src="/js/meeting/book/book.js?20221028.1"></script>
<script src="/form/3/inc/js/jquery.ezmark.js"></script>
<script src="/js/meeting/scroll/jquery.jscrollpane.min.js"></script>
<script src="/js/meeting/scroll/jquery.mousewheel.js"></script>
<script src="/js/meeting/scroll/mwheelIntent.js"></script>
<link rel="stylesheet" href="/css/meeting/book/index.css">
<link rel="stylesheet" href="/css/meeting/book/apply.css">
<link rel="stylesheet" href="/css/meeting/book/book.css">
<link rel="stylesheet" href="/css/meeting/book/ezmark.css">
<link rel="stylesheet" href="/css/meeting/book/global.css">
<link rel="stylesheet" href="/css/meeting/book/jquery.jscrollpane.css">
<link rel="stylesheet" href="/css/meeting/book/other.css">
<link rel="stylesheet" href="/css/meeting/uicore/jquery.ui.resizable.css">

<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css?20220814"/>
<style>
    .bodycolor {
        padding-top: 0px;
    }

    table tbody tr:nth-child(odd) {
        background-color: transparent;
    }

    .div_table {
        font-size: 14px;
    }

    .table {
        width: 90%;
        margin: 10px auto;
    }

    .table tbody tr:nth-child(odd) {
        background-color: #F6F7F9;
    }

    .table tbody tr:nth-child(even) {
        background-color: #fff;
    }

</style>

<script type="text/javascript">
    var meeting = "";
    var rooms = "";

    var weekdays = "日一二三四五六";

    function DateCompare(date1, date2){
        var time1 = new Date(DateFormat(new Date(date1), "yyyy-MM-dd")).getTime();
        var time2 = new Date(DateFormat(new Date(date2), "yyyy-MM-dd")).getTime();

        return Math.round((time1 - time2) / 3600 / 24 / 1000);
    }

    function lowerCaseToUpper(num){
        var upperWeekNum;
        if (parseInt(num) === 0){
            upperWeekNum = "日";
        } else if (parseInt(num) === 1){
            upperWeekNum = "一";
        } else if (parseInt(num) === 2){
            upperWeekNum = "二";
        } else if (parseInt(num) === 3){
            upperWeekNum = "三";
        } else if (parseInt(num) === 4){
            upperWeekNum = "四";
        } else if (parseInt(num) === 5){
            upperWeekNum = "五";
        } else if (parseInt(num) === 6){
            upperWeekNum = "六";
        }

        return upperWeekNum;
    }

    //计算天数差的函数，通用 sDate1和sDate2是2002-12-18格式
    function DateDiff(sDate1, sDate2){
        var aDate, oDate1, oDate2, iDays;
        aDate = sDate1.split("-");
        oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]); //转换为12-18-2002格式
        aDate = sDate2.split("-");
        oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]);
        iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24); //把相差的毫秒数转换为天数
        return iDays;
    }

    function initDate(startTimeStr, endTimeStr){
        var differ = DateDiff(startTimeStr, endTimeStr);
        var nextDate;
        var localDate = new Date(Date.parse(startTimeStr.replace(/-/g, "/")));
        var currentWeek;
        var dateArr = [];
        for(var i = 0; i <= differ; i++){
            nextDate = localDate.getTime() + i*24*60*60*1000;
            var declareNextDate = new Date(nextDate);
            currentWeek = declareNextDate.getDay();
            dateArr[i] = DateFormat(declareNextDate, "yyyy-MM-dd") + "(周" + lowerCaseToUpper(currentWeek) + ")";
        }
        return dateArr;
    }

    function checkform(){
        var BTIME = $(".start").val();
        var ETIME = $(".end").val();
        var datFrom = getDateFromString(BTIME);
        var datTo = getDateFromString(ETIME);
        var numDays = (datTo-datFrom)/(1000*60*60*24);
        if(BTIME === ""){
            alert("请选择开始日期！");
            return false;
        }
        if(ETIME === ""){
            alert("请选择结束日期！");
            return false;
        }

        if(BTIME !== "" &&  ETIME !== "" ){
            if(ETIME < BTIME){
                alert("结束日期不能小于开始日期！");
                return false;
            }

            if(numDays >= 14){
                msg = "你输入的日期查询跨度超过2周系统加载较慢，确定要继续吗？";
                if(!window.confirm(msg)){
                    return false;
                }
            }
        }
        window.location.href = "/meeting/meetingReserve?meetRoomId=" + $(".bigSelect").val() + "&bTime=" + BTIME + "&eTime=" + ETIME + "&usage=" + usage;
    }

    function getDateFromString(strDate){
        var  arrYmd = strDate.split("-");
        var  numYear = parseInt(arrYmd[0],10);
        var  numMonth = parseInt(arrYmd[1],10)-1;
        var  numDay = parseInt(arrYmd[2],10);
        return new Date(numYear, numMonth, numDay);
    }

    function display1(t){
        var el = $("#areabox");
        if (t.checked){
            el.className = "areabox hidden";
        } else {
            el.className = "areabox";
        }
    }

    function fixHaslayout(o){
        if(o.nodeType){
            o.style.zoom = 1;
            o.style.zoom = 'normal';
        } else if(o instanceof jQuery){
            o.each(function(){
                fixHaslayout(this);
            });
        }
    }

    /**
     * 初始化x轴
     */
    function initAxisX(){
        function number2Time(n){
            var h = Math.floor(n);
            return (h < 10 ? ("0" + h) : h) + ":" + (n - h ? "30" : "00")
        }
        $(".axis-x div").each(function(i, e){
            $(e).html(number2Time(i / 2) + "<br>" + number2Time(i/2 + 0.5));
        });
    }

    var newMeeting = {};
    var bookers = [];
    function initMeetings(){
        var roomJson = eval("[" + rooms + "]");
        $.each(roomJson, function(i, e) {
            function handle(index, start, limit){
                newMeeting.id = index;
                newMeeting.day = index;
                //newMeeting.date = bookerDate[index].substring(0,10);
                newMeeting.roomId = e.id;
                newMeeting.start = start;
                newMeeting.limit = limit;
            }

            var date = [];
            var s = 0;
            $.each(bookerDate, function(j, date1) {
                if(weekdays.indexOf(date1.substring(12,13))>=0){
                    s = 1;
                } else {
                    s = 0;
                }

                var info = {
                    date: date1,
                    status: s
                };
                date.push(info);
            });

            var wb = new WeekBooker({
                renderTo: "#meeting",
                distance: 30,
                name: e.name,
                date: date,
                update: handle,
                beforecreate: function(day){
                    if(e.blackList === 0){
                        alert("不能申请此会议室，由于您违法了会议室的规章制度！");
                        return false;
                    }
                    var d = bookerDate[day];
                    if(weekdays.indexOf(d.substring(12, 13)) < 0){
                        alert("此会议室此时段禁止申请");
                        fixHaslayout($('body > .content'))
                        return false;
                    }
                },
                oncreate: handle
            });

            bookers.push(wb);
            $.each(e.meeting, function(k, t) {
                var meeting = new Meeting({
                    content: t.content,
                    start: t.start,
                    limit: t.limit,
                    id: t.id,
                    ppm: 2,
                    onclick: function(){
                        //查看详情窗口
                        $.ajax({
                            url: '/meeting/queryMeetingById',
                            type: 'get',
                            dataType: 'json',
                            data: {
                                sid: t.id
                            },
                            success: function (obj) {
                                var data = obj.object;
                                var str = '';
                                if (data.attachmentList && data.attachmentList.length > 0) {
                                    for (var i = 0; i < data.attachmentList.length; i++) {
                                        str += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png" alt=""/><a href="/download?' + data.attachmentList[i].attUrl + '">' + data.attachmentList[i].attachName + '</a></div>'
                                    }
                                } else {
                                    str = '';
                                }

                                var fileStr = '';
                                if (data.agendaList && data.agendaList.length > 0) {
                                    for (var j = 0; j < data.agendaList.length; j++) {
                                        fileStr += '<div style="line-height: 0;"><img style="width:16px;margin-right: 5px;" src="../img/file/cabinet@.png" alt=""/><a href="/download?' + data.agendaList[j].attUrl + '">' + data.agendaList[j].attachName + '</a></div>'
                                    }
                                } else {
                                    fileStr = '';
                                }

                                layer.open({
                                    type: 1,
                                    title: ['<fmt:message code="meet.th.SeeConferenceDetails" />', 'background-color:#2b7fe0;color:#fff;'],
                                    area: ['600px', '500px'],
                                    shadeClose: true, //点击遮罩关闭
                                    content: '<div class="table"><table style="margin:auto;border-collapse: collapse;">' +
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
                                        if (data.status === 1 || data.status === 4) {
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
                    },
                    status: t.status,
                    disabled: true
                });

                wb.bookers[t.day].add(meeting);
            });

        });
    }

    function getData(){
        if(!newMeeting.start && newMeeting.start !== 0){
            alert("请选择会议室及申请时间！");
            return "";
        }
        //微信申请会议后提示冲突。所以消灭
        for (var i in bookers){
              var b = bookers[i];
              if (b.crowd()){
                  alert("会议时间冲突！");
                  return false;
              }
        }

        var newMeetingDate = bookerDate[newMeeting.day].substring(0,10);
        var newMeetingStart = newMeeting.start;
        var newMeetingLimit = newMeeting.limit;
        var hourStart = parseInt(newMeetingStart / 60);
        if(hourStart < 10){
            hourStart = "0" + hourStart;
        }
        var minStart = parseInt(newMeetingStart % 60);
        if(minStart === 0){
            minStart = "00";
        } else {
            minStart = "30";
        }
        var startTime = newMeetingDate + " " + hourStart + ":" + minStart + ":00";//拼接出开始时间
        var newMeetingEnd = newMeetingStart + newMeetingLimit;
        var hourEnd = parseInt(newMeetingEnd / 60);
        if(hourEnd < 10){
            hourEnd = "0" + hourEnd;
        }

        var minEnd = parseInt(newMeetingEnd % 60);
        if(minEnd === 0){
            minEnd="00";
        } else {
            minEnd="30";
        }
        var endTime = newMeetingDate + " " + hourEnd + ":" + minEnd + ":00";//拼接出结束时间
        layer.open({
            type: 1,
            title: ['<fmt:message code="meet.th.ConferenceApplication" />', 'background-color:#2b7fe0;color:#fff;'],
            area: ['800px', '500px'],
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
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>联系电话：</span>' +
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
                '<div class="div_tr"><span class="span_td">是否是周期性事务：</span> ' +
                '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="1">是</span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="isCycle" class="isCycle" value="0">否</span></div>' +
                '<div class="div_tr" id="time_div1" style="display:none">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议日期：</span>' +
                '<span style="margin:0 5px;">从</span><span><input type="text" style="width: 140px;" name="cycleStartDate" id="cycleStartDate" class="inputTd startTime test_null" value="' + startTime.substring(0, 11) + '" /></span>' +
                '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                '<span><input type="text" style="width: 140px;" name="cycleEndDate" class="endTime test_null" id="cycleEndDate" value="' + endTime.substring(0, 11) + '"  /></span>' +
                '</div>' +
                '<div class="div_tr time_div0" style="display:none">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>会议时间：</span>' +
                '<span style="margin:0 5px;">从</span><span><input type="text" style="width: 140px;" name="cycleStartTime" id="cycleStartTime" class="inputTd startTime test_null" value="'+startTime+'"  /></span>' +
                '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                '<span><input type="text" style="width: 140px;" name="cycleEndTime" class="endTime test_null" id="cycleEndTime" value="' + endTime + '" /></span>' +
                '</div>' +
                '<div class="div_tr time_div0" style="display:none">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span>申请星期：</span>' +
                '<span id="WEEKEND0" class="WEEKEND" style="display:none"><input type="checkbox" name="W7" value="1" num="7">星期日</span>\n' +
                '<span id="WEEKEND1" class="WEEKEND" style="display:none"><input type="checkbox" name="W1" value="1" num="1">星期一</span>\n' +
                '<span id="WEEKEND2" class="WEEKEND" style="display:none"><input type="checkbox" name="W2" value="1" num="2">星期二</span>\n' +
                '<span id="WEEKEND3" class="WEEKEND" style="display:none"><input type="checkbox" name="W3" value="1" num="3">星期三</span>\n' +
                '<span id="WEEKEND4" class="WEEKEND" style="display:none"><input type="checkbox" name="W4" value="1" num="4">星期四</span>\n' +
                '<span id="WEEKEND5" class="WEEKEND" style="display:none"><input type="checkbox" name="W5" value="1" num="5">星期五</span>\n' +
                '<span id="WEEKEND6" class="WEEKEND" style="display:none"><input type="checkbox" name="W6" value="1" num="6">星期六</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ConferenceRoom" />：</span>' +
                '<span><select style="width: 42%;" name="typeName" class="meetRoomId test_null" id="meetRoomId"></select></span>' +
                '<span style="margin-left: 10px"><a href="javascript:;" class="meetRoomDetail"><fmt:message code="meet.th.SeeDetails" /></a></span>' +
                '</div>' +
                '<div class="div_tr" id="time_div2">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="sup.th.ApplicationTime" />：</span>' +
                '<span style="margin:0 5px;">从</span><span><input type="text" style="width: 150px; height: 40px;" name="typeName" id="beginTime" class="inputTd startTime test_null" autocomplete="off"/></span>' +
                '<span style="margin:0 5px;"><fmt:message code="global.lang.to" /></span>' +
                '<span><input type="text" style="width: 150px; height: 40px;" name="typeName" class="endTime test_null" id="endTime" autocomplete="off"/></span>' +
                '</div>' +
                '<div class="div_tr time_div0">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;"></span>打卡时间：</span>' +
                '<span style="margin-left: 5px;"><input type="text" style="width: 140px;margin-left: 0 0 0 10px;" name="signInTime" id="signInTime" class="inputTd  test_null"/></span>' +
                '<span style="margin:0 5px;">打卡时间：从开始时间到打卡时间，为打卡时间范围</span>' +
                '</div>' +
                '<div class="div_tr isVideo"><span class="span_td">是否是视频会议：</span> ' +
                '<span><input style="height:auto;margin-top: 2px;vertical-align: text-top;" type="radio" name="isVideo" class="isVideo" value="1" >是</span>' +
                '<span style="margin-left: 10px;"><input style="height:auto;margin-top: 2px;vertical-align: text-top;"  type="radio" checked="true" name="isVideo" class="isVideo" value="0" >否</span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.ApprovalAdministrator" />：</span>' +
                '<span><select style="width: 42%;" name="typeName" class="managerId test_null" id="managerId"></select></span>' +
                '</div>' +
                '<div class="div_tr">' +
                '<span class="span_td"><fmt:message code="meet.th.external" />：</span><span><div class="inPole" style="width:70%;"><textarea name="attendeeOut" id="attendeeOut" class="attendeeOut" value="" style="width: 84%;min-height:58px;resize: vertical;"></textarea></div></span></div>' +
                '<div class="div_tr"><span class="span_td"><span style="color: #FF0000;margin-right: 5px;font-size: 16px;vertical-align: middle;">*</span><fmt:message code="meet.th.internal" />：</span><span><div class="inPole" style="width:70%;">' +
                '<textarea name="txt" class="attendee test_null" id="attendeeDuser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>' +
                '<span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="selectAttendee" class="selectAttenddee"><fmt:message code="global.lang.add" /></a></span><span class="add_img" style="margin-left: 10px"><a href="javascript:;" id="clearAttendee" class="clearAttendee "><fmt:message code="global.lang.empty" /></a></span></div></span></div>' +
                /*前台会议服务人员*/
                ' <div class="div_tr"><span class="span_td" style="width:145px">前台会议服务人员：</span><span>\n' +
                '            <div class="inPole" style="width:70%;">\n' +
                '                <textarea name="serviceUser" id="serviceUser" user_id="" value="" disabled readonly style="width: 84%;min-height:60px;resize:none;"></textarea>\n' +
                '                <span class="add_img" style="margin-left: 6px"><a href="javascript:;" id="addServiceUser">\n' +
                '                        <fmt:message code="global.lang.add" /></a></span><span class="add_img"\n' +
                '                    style="margin-left: 6px"><a href="javascript:;" id="clearServiceUser">\n' +
                '                        <fmt:message code="global.lang.empty" /></a></span></div>\n' +
                '        </span>\n' +
                '    </div>\n' +
                '    <div class="div_tr">\n' +
                '        <span class="span_td" style="width:145px">\n' +
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
                '            <fmt:message code="meet.th.NotifyAttendees" />：</span><span><input type="checkbox" id="smsRemind"  class="smsRemind"></span><span style="margin-right: 10px;">事务通知</span>\n' +
                '            <span><input type="checkbox"\n' +
                '                id="sms2Remind" class="sms2Remind"></span><span>\n' +
                '            <fmt:message code="meet.th.SMSReminder" /></span><span style="margin-left: 10px;">\n' +
                '            <fmt:message code="meet.th.Advance" /></span><input type="text" style="width:30px" name="resendHour"   id="resendHour" class="resendHour"><span>\n' +
                '            <fmt:message code="meet.th.hour" /></span><input type="text" style="width:30px" class="resendMinute"   id="resendMinute"><span>\n' +
                '            <fmt:message code="meet.th.Reminder" /></span></div>\n' +
                //是否开启手写打卡
                '<div class="div_tr"><span class="span_td">是否开启手写打卡：</span> ' +
                '<span><input style="height: auto; vertical-align: text-top; margin-top: 2px;" type="radio" name="handwritingSignYn" class="handwritingSignYn" value="1">是</span><span style="margin-left: 10px;"><input style="height:auto;vertical-align: text-top; margin-top: 2px;" type="radio" checked="true" name="handwritingSignYn" class="handwritingSignYn" value="0">否</span></div>' +
                '    <div class="div_tr"><span class="span_td" style="text-align: right;text-align: right;display: block;width: 100%;" >\n' +
                '<div class="layui-row">' +
                '<div class="layui-col-xs12">' +
                '<div class="layui-form-item layui-form-text">\n' +
                '    <label class="layui-form-label" style="width: 130px;">会议议程附件:</label>\n' +
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
                '    <label class="layui-form-label" style="width: 130px;">附件:</label>\n' +
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
                layui.use(['table'], function () {
                    var laydate = layui.laydate;
                    //申请时间 开始
                    laydate.render({
                        elem: '#beginTime'
                        ,type: 'datetime'
                        ,value: startTime
                        ,trigger: 'click'
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                        ,done: function (value, date) {
                            var dYest = dateYest();
                            if (value <= dYest) {
                                $.layerMsg({content: '申请时间的开始时间请选择今天以后的时间!', icon: 0})
                            }
                        }
                    });
                    //申请时间 结束
                    laydate.render({
                        elem: '#endTime'
                        ,type: 'datetime'
                        ,value: endTime
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                        ,trigger: 'click'
                        ,done: function (value, date, endDate) {
                            //判断会议室是否被占用
                            $.get('/meeting/judgeMeeting', {
                                meetRoomId: $('#meetRoomId').val(),
                                startTime: $('#beginTime').val(),
                                endTime: $('#endTime').val()
                            }, function (res) {
                                if (res.code === '1') {
                                    $.layerMsg({content: res.msg, icon: 0})
                                    return false
                                }
                            })
                        }
                    });
                    //打卡时间
                    laydate.render({
                        elem: '#signInTime'
                        ,type: 'datetime'
                        ,trigger: 'click'
                        ,format: 'yyyy-MM-dd HH:mm:ss'
                    });
                    //会议日期 开始
                    laydate.render({
                        elem: '#cycleStartDate'
                        ,trigger: 'click'
                        ,format: 'yyyy-MM-dd'
                        ,done: function (value, date) {
                            week_select()
                        }
                    });
                    //会议日期 结束
                    laydate.render({
                        elem: '#cycleEndDate'
                        ,trigger: 'click'
                        ,format: 'yyyy-MM-dd'
                        ,done: function (value, date) {
                            week_select()
                        }
                    });
                    //会议时间 开始
                    laydate.render({
                        elem: '#cycleStartTime'
                        ,type: 'datetime'
                        ,trigger: 'click'
                        ,format: 'HH:mm:ss'
                    });
                    //会议时间 结束
                    laydate.render({
                        elem: '#cycleEndTime'
                        ,type: 'datetime'
                        ,trigger: 'click'
                        ,format: 'HH:mm:ss'
                    });
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
                })

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

                $('input[name="isCycle"]').click(function () {
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
                $('#meetRoomId').change(function () {
                    var opvalue = $(this).val();
                    if (opvalue === '0') {
                        $("input[name='isVideo']").each(function (index, item) {
                            $(this).prop("disabled", true);
                            if (index === 0) {
                                $(this).prop("checked", true);
                            }
                        });
                    } else {
                        $("input[name='isVideo']").each(function () {
                            $(this).prop("disabled", false);
                        });
                        initManager(opvalue)
                    }
                });
                if (!$('#meetRoomId').val()) {
                    layer.msg('没有可用的会议室，请联系管理员！', {icon: 0});
                    return false
                }
                initManager($('#meetRoomId').val());

                //点击会议室名称显示会议室详情
                $('.meetRoomDetail').click(function () {
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
                                var str = '<div class="table"><table style="margin:auto;border-collapse: collapse;">' +
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
                        if (obj.flag) {
                            if (obj.msg == "申请成功") {
                                $.layerMsg({content: '<fmt:message code="sup.th.SuccessfulApplication" />！', icon: 1}, function () {
                                    //更新列表
                                    listByStatus(queryStatus);
                                })
                                location.reload();
                                layer.close(index);
                            }
                        } else {
                            $.layerMsg({content: obj.msg, icon: 0});
                        }
                    }
                })
            }
        });
    }

    function GetRequest() {
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = {};
        if (url.indexOf("?") !== -1) {
            var str = url.substring(1);
            strs = str.split("&");
            for(var i = 0; i < strs.length; i ++) {
                theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
            }
        }
        return theRequest;
    }

    //日期格式化
    function DateFormat(date, format){
        var o = {
            "M+": date.getMonth() + 1,
            "d+": date.getDate(),
            "h+": date.getHours(),
            "m+": date.getMinutes(),
            "s+": date.getSeconds(),
            "q+": Math.floor((date.getMonth() + 3) / 3),
            "S": date.getMilliseconds()
        };
        if (/(y+)/.test(format)){
            format = format.replace(RegExp.$1, (date.getFullYear() + "").substring(4 - RegExp.$1.length));
        }
        for (var k in o){
            if (new RegExp("(" + k + ")").test(format)){
                format = format.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (("00" + o[k]).substring(("" + o[k]).length)));
            }
        }
        return format;
    }

    function explode(inputstring, separators) {
        inputstring = String(inputstring).substring(11);

        var fixedExplode = new Array(2);

        var index = inputstring.indexOf(separators);
        fixedExplode[0] = parseInt(inputstring.substring(0, index));
        fixedExplode[1] = parseInt(inputstring.substring(index + 1, index + 3));

        return fixedExplode;
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

    //初始化会议室下拉列表
    function initMeetRoom() {
        var data = $(".bigSelect").find("option");
        var str = "";
        for(var i = 0; i < data.length; i++){
            str += '<option value="' + data.eq(i).val() + '">' + data.eq(i).text() + '</option>';
        }
        if (str === "") {
            $("input[name='isVideo']").each(function (index, item) {
                $(this).prop("disabled", true);
                if (index === 0) {
                    $(this).prop("checked", true);
                }
            });
        }
        str += "<option value='0'>视频会议</option>";
        $(".meetRoomId").html(str);
        $(".meetRoomId").val($(".bigSelect").val());
    }

    //获取昨天时间最晚时间
    function dateYest() {
        var time = new Date();
        time.setTime(time.getTime() - 24 * 60 * 60 * 1000);
        var mon = time.getMonth() + 1
        var da = time.getDate()
        if (mon < 10) mon = "0" + mon;
        if (da < 10) da = "0" + da;
        return time.getFullYear() + "-" + mon + "-" + da + ' ' + '23:59:59';
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

    $(document).on('click', '#selectUser', function () {//选人员控件(申请人)
        user_id = 'userDuser';
        var selectUserOpen = "../common/selectUser?0";
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
    });
    $(document).on('click', '#selectRecorder', function () {//选人员控件（纪要员）
        user_id = 'recoderDuser';
        var selectUserOpen = "../common/selectUser?0";
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
    });
    $(document).on('click', '#selectAttendee', function () {//选人员控件（出席内部人员）
        user_id = 'attendeeDuser';
        var selectUserOpen = "../common/selectUser";
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
    });
    $(document).on('click', '#addServiceUser', function () {//选人员控件（前台会议服务人员）
        user_id = 'serviceUser';
        var selectUserOpen = "../common/selectUser";
        selectUsreLayerIndex = layer.open({
            type: 2,
            title: '选择用户',
            content: selectUserOpen,
            area: ['65%', '80%']
        })
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

</script>

<body class="bodycolor" style="overflow: auto; position: relative;">
<div id="query" style="align: center; top: 0px;">
    <form name="form1" action="">
        <table class="TableList" style="align: center; width: 100%;">
            <tr>
                <td class="TableContent"  nowrap style="align: left;">
                    会议室选择：
                    <select name="meetRoomId"  class="bigSelect" style="font-size: 13px;" onChange="checkform();">
                    </select>
                    &nbsp;&nbsp;
                    开始时间：
                    <input size="15" type="text" class="start" name="bTime" value="" onClick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                    &nbsp;&nbsp;
                    结束时间：
                    <input size="15" type="text" class="end" name="eTime" value="" onClick="laydate({istime: true, format: 'YYYY-MM-DD'})">
                    &nbsp;&nbsp;&nbsp;
                    <input  type="button" class="SmallButton" value="查询" onClick="return checkform();">
                    <span style="padding-left: 8px; color: #666666">( 企业微信日程中可直接选择会议室进行预定 )</span>
                </td>
                <td class="TableContent"></td>
            </tr>
        </table>
    </form>
</div>

<div class="content" style="width: 98%; min-width: 1000px; display: inline-block; position: relative;">
    <div class="legend">
        <b>图例说明：</b>
        <label><img src="/img/meeting/book/explain-a.jpg"><span>未预约</span></label>
        <label><img src="/img/meeting/book/explain-b.jpg"><span>待批准</span></label>
        <label><img src="/img/meeting/book/explain-c.jpg"><span>已批准</span></label>
        <label><img src="/img/meeting/book/explain-d.jpg"><span>进行中</span></label>
        <label><img src="/img/meeting/book/explain-e.jpg"><span>已结束</span></label>
    </div>

    <div class="contentwrapper">
        <div class="content_left">
            <div class="booker-title" style="width: 100%;">
                <div class="table-title" style="width: 152px; float: left;">
                    <ul>
                        <li style="width: 149px"><span>日期</span></li>
                    </ul>
                </div>
            </div>
            <div>
                <table>
                    <tbody>
                    <tr>
                        <td>
                            <div class="axis-y-date" id="meeting_date">
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="dateContent" style="width: 1200px; overflow-x: auto; overflow-y: hidden; position: relative;">
            <div class="booker-title" style="width: 2883px;">
                <div class="axis-x" style="width: 2882px;">
                    <div class="first"></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div></div>
                    <div class="last"></div>
                </div>
                <div style="clear:left;"></div>
                <div id="meeting"></div>
            </div>
        </div>

        <div id="btnContent" align="center" style="clear: both; margin-bottom: 20px;">
            <br />
            <input type="button" class="BigButton" value="提交" onClick="getData()" />
            <input type="button" class="BigButton" value="返回" onClick="window.location='/meetingRoom/roomManage'" />

            <input type="button" class="BigButton" value="关闭" onClick="window.close()" />
        </div>
    </div>
</div>

</body>
<script type="text/javascript">
    $("#dateContent").css("width", ($(window).width() - 168) + 'px');
    var bTime = GetRequest()['bTime'] === undefined ? "" : GetRequest()['bTime'];
    var eTime = GetRequest()['eTime'] === undefined ? "" : GetRequest()['eTime'];
    var meetRoomId = GetRequest()['meetRoomId'] === undefined ? "" : GetRequest()['meetRoomId'];
    var usage = GetRequest()['usage'] === undefined ? "" : GetRequest()['usage'];

    if(bTime === ""){
        bTime = DateFormat(new Date(), "yyyy-MM-dd");
        $(".start").val(bTime);
    } else {
        $(".start").val(bTime);
    }

    if(eTime === ""){
        var time = new Date().getTime() + (24 * 60 * 60 * 1000 * 6);
        eTime = DateFormat(new Date(time), "yyyy-MM-dd");
        $(".end").val(eTime);
    } else {
        $(".end").val(eTime);
    }

    //判断是否是查看使用情况
    if (usage !== "" && usage == "false"){
        $("#btnContent").hide();
    }

    //结束时间-开始时间
    var s_from_date = new Date(bTime).getTime();
    var s_to_date = new Date(eTime).getTime();
    var i_num_days = 0;
    var s_show_date = "";
    var s_week_name = "";
    if(s_to_date >= s_from_date){
        var str = "";
        for(var i = s_from_date; i <= s_to_date; i = i + 60*60*24*1000){
            s_show_date = DateFormat(new Date(s_from_date + i_num_days*60*60*24*1000), "yyyy-MM-dd");
            s_week_name = lowerCaseToUpper(new Date(s_from_date + i_num_days*60*60*24*1000).getDay());

            str += "<div class='item " + (i_num_days % 2 ? "odd" : "even") + "'>" + s_show_date + "(周" + s_week_name + ")" + "</div>";
            i_num_days++;
        }
        $("#meeting_date").html(str);
    }

    var bookerDate = initDate(bTime, eTime);

    $.ajax({
        url:"/meetingRoom/getAllMeetRoom",
        type:'post',
        dataType:'json',
        success:function (res1) {
            var str = '<option value=""><fmt:message  code="hr.th.PleaseSelect"/></option>';
            var data1 = res1.obj;
            if(res1.flag){
                for(var i = 0; i < data1.length; i++){
                    str += '<option value="'+data1[i].sid+'">'+data1[i].mrName+'</option>';
                }
            }

            $(".bigSelect").html(str);
            if(meetRoomId != ""){
                $(".bigSelect").val(meetRoomId);
            } else {
                $(".bigSelect").val(data1[0].sid);
            }

            $.ajax({
                url:"/meeting/selectMeetingReserve",
                type:'post',
                dataType:'json',
                data:{
                    meetRoomId: $(".bigSelect").val(),
                    startDate: $(".start").val() + " 00:00:00",
                    endDate: $(".end").val() + " 23:59:59"
                },
                success:function (res2) {
                    if (res2.flag){
                        var data2 = res2.obj;
                        var today = $(".start").val() + " 00:00:00";

                        for (var i = 0; i < data2.length; i++) {
                            var m_start = data2[i].startTime;
                            var m_end = data2[i].endTime;

                            var limit = 0;

                            var day_start = DateCompare(m_start, today);
                            var day_end = DateCompare(m_end, today);

                            var a_m_start_time = explode(m_start, ":");
                            var a_m_end_time = explode(m_end, ":");
                            var el_start = a_m_start_time[0]*60 + a_m_start_time[1];
                            var el_end = a_m_end_time[0]*60 + a_m_end_time[1];

                            if (day_start === day_end){
                                limit = (a_m_end_time[0] - a_m_start_time[0]) * 60 + (a_m_end_time[1] - a_m_start_time[1]);
                                meeting += "{day:" + day_start + ",content:\"" + data2[i].meetName + "\",start:" + el_start + ",limit:" + limit + ",status:\"" + data2[i].status + "\",id:\"" + data2[i].sid + "\"},";
                            } else {
                                for(var j = day_start; j <= day_end; j++){
                                    if(j === day_start){
                                        limit = 24*60 - el_start;
                                        meeting += "{day:" + j + ",content:\"" + data2[i].meetName + "\",start:" + el_start + ",limit:" + limit + ",status:\"" + data2[i].status + "\",id:\"" + data2[i].sid + "\"},";
                                    } else if(j === day_end){
                                        el_start = 0;
                                        limit = el_end;
                                        meeting += "{day:" + j + ",content:\"" + data2[i].meetName + "\",start:" + el_start + ",limit:" + limit + ",status:\"" + data2[i].status + "\",id:\"" + data2[i].sid + "\"},";
                                    } else {
                                        el_start = 0;
                                        limit = 24*60;
                                        meeting += "{day:" + j + ",content:\"" + data2[i].meetName + "\",start:" + el_start + ",limit:" + limit + ",status:\"" + data2[i].status + "\",id:\"" + data2[i].sid + "\"},";
                                    }
                                }
                            }
                        }

                        meeting = meeting.substring(0, meeting.length - 1);
                        var SIGN = 1;
                        rooms += "{name:\"" + $(".bigSelect option:selected").text() + "\",id:\"" + $(".bigSelect").val() + "\",blackList:" + SIGN + ",meeting:[" + meeting + "]}";
                    }

                    $(function(){
                        //do active
                        $(".meeting:not(.disabled)").on("mousedown", function(){
                            $(".active.meeting").removeClass("active");
                            $(this).addClass("active");
                        });

                        $('html,body').bind('scroll', function(){
                            fixHaslayout($('.week-booker, .axis-y-name>span'));
                        });

                        $('input[type=checkbox]').ezMark();
                        initMeetings();
                        initAxisX();
                        $("#dateContent").scrollLeft(1081);
                        document.onselectstart = function(){
                            return false;
                        }
                    });
                }
            })
        }
    })

</script>
</html>