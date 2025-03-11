<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/lib/layDate-v5.0.9/laydate/theme/default/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" type="text/css" href="/css/FullCalendar/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1" />
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js" ></script>
    <script src="/js/common/language.js"></script>
    <script src="/lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
    <script type="text/javascript" charset="utf-8" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" charset="utf-8" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/fullcalendar/fullcalendar.min.js?20230322.7" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/fullcalendar/jquery-ui.custom.min.js?20230322.2" type="text/javascript" charset="utf-8"></script>

    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <title><fmt:message code="main.schedule"/> </title>
    <style>

        .calhover .fc-border-separate td:hover{
            background-color: #CFE8FC !important;
        }

        .calendar .fc-agenda-slots .fc-widget-content:hover{
            background-color: #CFE8FC  !important;
        }

        /*行大盒*/
        .control-group{
            margin-top:10px;
            margin-left: 100px;
            height:40px;
        }
        /*级别框*/
        .CAL_LEVEL{
            margin-left: 56px;
            height:29px;
        }
        /*内容框*/
        .CAL_CONTENT{
            width:274px;
            margin-left: 50px;
            height: 24px;;
            vertical-align: middle;
        }
        /*前四框*/
        .text_boder{
            border-radius:3px;
            margin-left: 8px;
            position:relative;
            bottom:0px;
        }
        #START_DATE,#EDN_DATE{
            width:278px;
            height:26px;
        }
        html{
            background:#fff;
        }
        body{
            margin:0px;
            positon:relative;
        }
        .fc-header{
            background: #fff;
        }
        body {

            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .container{
            backgrongd:#fff;
        }
        thead{
            background: #eee;
        }
        .fc-header tr{
            height:30px;
        }
        .fc table{
            margin-bottom: 0px;
        }
        .fc-header-title h2 {
            margin-top: 0;
            white-space: nowrap;
            color:#404060;
        }
        thead tr th{
            font-weight:500;
        }
        .fc-day-number{
            font-weight:300;
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
        /*input {*/
        /*-webkit-appearance: textfield;*/
        /*background-color: white;*/
        /*-webkit-rtl-ordering: logical;*/
        /*user-select: text;*/
        /*cursor: auto;*/
        /*padding: 1px;*/
        /*border-width: 1px !important;*/
        /*border-style: inset;*/
        /*border-color: initial;*/
        /*border-image: initial;*/
        /*color:#333;*/
        /*font-family:"微软雅黑";*/
        /*}*/
        textarea, select, button {
            text-rendering: auto;
            color: #333;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0px;
            text-shadow: none;
            display: inline-block;
            text-align: start;
            margin: 0em 0em 0em 0em;
            font-family:"微软雅黑";

        }
        input, textarea, select, button, meter, progress {
            -webkit-writing-mode: horizontal-tb;
        }
        .fc-state-highlight{
            background-color:#beddff !important;
        }

        li{
            list-style: none;
        }
        .style_a{
            margin-left:5px;
            margin-bottom:5px;
            color: #1687cb;
            text-decoration: none;
            font-size: 13px;
        }
        .title{
            /*margin-left: 2%;*/
            padding-left:27px;
            height:45px;
            line-height:50px;
            border-bottom:1px solid #ccc;
            font-size: 22px;
            color: rgb(73, 77, 89);
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }
        .titName{
            display:inline-block;
        }
        .content .box{
            border:none;
        }
        .row-fluid{
            border-top:none;
            border-top-color:#ccc;
        }
        .colorClass a{
            display: inline-block;
            width:16px;
            height:16px;
            margin-left:10px;
            vertical-align: middle;
        }
        .colorClass{
            color:#666;
            line-height:21px;
            position: absolute;
            right:27px;
            top:13px;
        }
        .test_null{
            border:1px solid #ccc!important;
        }
        .group_one{
            margin-top: 40px;
        }
        #TAKER_NAME,#OWNER_NAME{
            margin-left: 19px!important;
        }
        .TAKER,.OWNER{
            display: inline-block;
            position: relative;
            top:-42px;
            left:10px;
        }
        .typeone{
            display: inline-block;
            position: relative;
            top:-10px;
            top:0px\0;
        }
        .input-small{
            border-radius: 3px;
        }
        .control-go{
            height:60px;
            margin-top:10px;
            margin-bottom: 20px;
            margin-left:100px;
        }
        /*小导航栏*/
        .mintitle{
            width:300px;
            height:30px;
            padding:10px 20px;
        }
        .mintitle:hover{
            cursor:pointer;
        }
        .mintitle .mintittab{
            display:inline-block;
            width:100px;
            height:30px;
            text-align: center;
            line-height:30px;
            border-radius: 5px;
        }
        .active{
            background: #eee;
        }
        .disnone{
            display: none;
        }
        .cycleWork{

            position:relative;
        }
        .ty{
            display: inline-block;
            width: 200px;
        }
        .cycleWork  .search{
            padding-left:33px;
            width:100%;
            height:50px;
            line-height:50px;
        }
        .cycleWork  .search input{

        }
        .mr{
            margin-right:20px;
        }
        .submit{
            display:inline-block;
            width:50px;
            height:30px;
            text-align: center;
            line-height:30px;
            border-radius:5px;
            background: #00A5E4;
            margin:10px 0 0 20px;
            color: #ffffff;
        }
        .submit:hover{
            cursor:pointer;
        }
        table {
            border-collapse:collapse;
            width: 90%;
            margin: 10px auto;
        }
        th{
            text-align: center;
            background-color: #ffffff;
            padding: 8px;
            font-size: 12pt;
            color:#2F5C8F;
        }
        td{
            height:30px;
            text-overflow:ellipsis;
            white-space:nowrap;
            overflow:hidden;
            text-align:center;
            font-size: 11pt;
        }
        .conTh{
            width:300px;
        }
        .newcyc{
            position:absolute;
            top:10px;
            right:3%;
            display: block;
            width:100px;
            height:30px;
            line-height: 30px;
            background: #f00;
            color:#fff;
            border-radius: 5px;
            text-align:center;

        }
        .newcyc:hover{
            cursor:pointer;
        }
        /*新建页面 样式*/
        .newCycleWork{
            width:100%;

        }
        .innerbox{
            width:50%;
            margin:20px auto;
            font-size: 11pt;
        }
        .newTitle{
            color:#fff;
            height:50px;
            line-height: 50px;
            margin:0;
            padding:0;
            font-size:13pt;
            width:100%;
            text-align: center;
            background: #00a5e0;

        }
        .con{
            margin:20px  auto;
            width:100%;
            padding-left:220px;
        }
        .leftTit{
            margin-right:20px;
        }
        .rightTit{
            margin-left:10px;
            font-size: 9pt;
            color: #999999;
        }

        .con1{
            text-align: right;
            padding-left:0;
        }
        .jump-ipt{
            width: 38px;
            height: 38px;
            line-height:38px;
        }
        .newbtn{
            width:60px;
            height:30px;
            line-height:30px;
            background: #00a5e0;
            border-radius:5px;
            border:1px solid #eee;
            text-align: center;
            margin-right:20px;
        }
        #newcancel{
            background: #eee;
        }
        #remind{
            width:16px;
            height:16px;
        }
        input{
            width:200px;
            height: 28px;
        }
        #edit,#deletebtn{
            color:#00a5e0;
            width:40px;
            height:30px;
        }
        .head-top{
            position: initial;
        }
        span{
            font-size: 11pt;
        }
        .divTable{
            width: 100%;
            table-layout: auto;
            margin: 0;
        }
        .divTable tr td{
            padding: 5px;
        }
        .divTable tr td:first-of-type{
            width: 120px;
            border-right: #ccc 1px solid;
        }
        .divTable tr td:last-of-type{
            text-align: left;
        }
        .divTable tr td textarea{
            width: 400px;
            height: 60px;
            min-width: 400px;
            min-height: 60px;
        }
        .divTable tr td select{
            width: 203px;
            height: 28px;
        }
        .btnarr a{
            padding: 5px 15px;
            color: #fff;
            border-radius: 4px;
            margin: 0 10px;
        }
        .divTable tr td input[type="checkbox"]{
            width: 16px;
            height: 16px;
        }
        .layerTable td{
            padding: 5px;
        }
        .layerTable td:first-of-type{
            width: 100px;
            text-align: right;
        }
        .layerTable td:last-of-type{
            text-align: left;
        }
        .condQuery{
            margin-top: 20px;
            padding-left: 40px;
        }
        .condQuery select{
            width: 130px;
            height: 28px;
            border-radius:4px;
        }
        .queryData{
            background: url(/img/center_q.png) no-repeat;
            background-size: 74px;
            width: 74px;
            height: 29px;
            line-height: 30px;
            display: inline-block;
            padding-left: 30px;
            box-sizing: border-box;
            color:#000;
        }
        #calendar table tr{
            border: none;
        }
        .fc-day-header{
            font-weight:700
        }
        .fc-day-number{
            font-weight:700
        }
        .fc-event-title{
            margin-left: 5px;
        }

    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>
<div class="title">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dayli.png" alt="" style="vertical-align:middle;margin-bottom: 3px">
    <div class="titName" style="margin-left: 7px"><fmt:message code="main.schedule"/></div><%--日程安排--%>
</div>
<div class="head-top">
    <ul class="clearfix">
        <%--        我的日程--%>
        <li class="fl head-top-li active" id="myWork"><fmt:message code="calendar.th.myCalendar"/></li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <%--    周期性事务--%>
        <li class="fl head-top-li" id="cycleWork"><fmt:message code="calendar.th.Cyclical"/></li>
        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>
        <%--    我的日程查询--%>
        <li class="fl head-top-li" id="queryWork"><fmt:message code="calendar.th.MyInquiries"/></li>
    </ul>
</div>
<div class="container myWork">
    <div class="content">
        <div class="colorClass">
            <a href="javascript:;" style="background-color: rgb(255, 87, 87);"></a>
            <span><fmt:message code="attend.th.Importanturgent"/></span><%--重要/紧急--%>
            <a href="javascript:;" style="background-color: rgb(255, 149, 64);"></a>
            <span><fmt:message code="attend.th.ImportantNourgent"/></span><%--重要/不紧急--%>
            <a href="javascript:;" style="background-color: rgb(206, 132, 206);"></a>
            <span><fmt:message code="attend.th.NOImportanturgent"/></span><%--不重要/紧急--%>
            <a href="javascript:;" style="background-color: rgb(69, 162, 255);"></a>
            <span><fmt:message code="attend.th.NOImportantNOurgent"/></span><%--不重要/不紧急--%>
        </div>
        <div class="row-fluid" id="canShow" style="display: block;">
            <div class="span12">
                <div class="box">
                    <div class="box-content box-nomargin">
                        <div class="calendar calhover" id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row-fluid" id="canHide" style="display: none;">
            <div class="span12">
                <div class="box">
                    <div class="box-content box-nomargin">
                        <div class="calendar" id="calendars"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container cycleWork disnone head">
    <div class="tablebox">
        <span class="newcyc one" id="newCycleWork"><fmt:message code="global.lang.new"/></span>
        <div  class="search">
            <label class="fl mr" >
                <span class="fl" ><fmt:message code="global.lang.date"/>：</span>
                <label class="fl">
                    <input  id="beginTime" name="beginDate" placeholder="<fmt:message code="sup.th.startTime"/>"  type="text" />
                    <fmt:message code="global.lang.to"/>
                    <input  id="endTime" name="endDate" placeholder="<fmt:message code="meet.th.EndTime"/>"  type="text" />
                </label>
            </label>
            <label class="fl"><fmt:message code="attend.th.Contentofthings"/>:<input class='mr'id='content' name="content" type="text"/></label>
            <span class="submit fl one"><fmt:message code="global.lang.query"/></span>
        </div>
        <div style="clear: both;"></div>

        <table border="1" id="cycleWorkTable">
            <thead><tr>
                <th><fmt:message code="sms.th.StartDate"/></th>
                <th><fmt:message code="attend.th.EndDate"/></th>
                <th><fmt:message code="sup.th.startTime"/></th>
                <th><fmt:message code="meet.th.EndTime"/></th>
                <%--<th>提醒类型</th>--%>
                <%--<th>提醒日期</th>--%>
                <th><fmt:message code="attend.th.Remindertime"/></th>
                <th class="conTh"><fmt:message code="attend.th.Contentofthings"/></th>
                <th><fmt:message code="notice.th.operation"/></th>
            </tr></thead>
            <tbody  id="trList"></tbody>
        </table>
        <%--分页按钮--%>
        <div id="dbgz_page" class="M-box3 fr" style="margin-right: 6%;margin-top: 2%">

        </div>
    </div>
    <div class="newCycleWork disnone">
        <div class="innerbox">
            <input type="hidden" name="editType" value="">

            <table cellspacing="0" cellpadding="0" class="divTable" style="border-collapse:collapse;background-color: #fff">
                <tr>
                    <td class="hhhed" colspan="2" style="text-align: center;"><fmt:message code="NewPeriodic"/></td>
                </tr>
                <tr>
                    <td><fmt:message code="attend.th.startDate"/></td>
                    <td><input autocomplete="off" id="newBeginDate" name="beginTime" value="" type="text"/><span class="rightTit"><fmt:message code="EmptyDate"/></span></td>
                </tr>
                <tr>
                    <td><fmt:message code="attend.th.EndDate"/></td>
                    <td><input  autocomplete="off" id="newEndDate" name="endTime"  type="text"/><span class="rightTit"><fmt:message code="EmptyEnd."/></span></td>
                </tr>

                <tr>
                    <td><fmt:message code="sup.th.startTime"/></td>
                    <td><input autocomplete="off" id="beginTimeTime" name="beginTimeTime"  type="text"/></td>
                </tr>
                <tr>
                    <td><fmt:message code="meet.th.EndTime"/></td>
                    <td><input autocomplete="off"  id="endTimeTime" name="endTimeTime"  type="text"/></td>
                </tr>

                <tr>
                    <td><fmt:message code="attend.th.Typesofthings"/></td>
                    <td>
                        <select name="calType" id="calType">
                            <option value="1"><fmt:message code="attend.th.Worktransaction"/></option>
                            <option value="2"><fmt:message code="attend.th.Persontransaction"/></option>
                        </select>
                    </td>
                </tr>
                <tr id="symbol">
                    <td><fmt:message code="RepeatType"/></td>
                    <td>
                        <select name="repeatType" id="repeatType">
                            <option value="2"><fmt:message code="Reminding"/></option>
                            <option value="3"><fmt:message code="WeeklyReminding"/></option>
                            <option value="4"><fmt:message code="MonthlyReminding"/></option>
                            <option value="5"><fmt:message code="AnnualReminding"/></option>
                            <option value="6"><fmt:message code="RemindByWorking"/></option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="attend.th.Remindertime" /></td>
                    <td id="showHide">
                        <div style="display: block;"><input autocomplete="off"  id="remindTime" name="remindTime"  type="text" /></div>
                        <div style="display: none;">
                            <select name="week" id="week">
                                <option value="1"><fmt:message code="Monday"/></option>
                                <option value="2"><fmt:message code="sup.th.startTime"/></option>
                                <option value="3"><fmt:message code="Wednesday"/></option>
                                <option value="4"><fmt:message code="Thursday"/></option>
                                <option value="5"><fmt:message code="Friday"/></option>
                                <option value="6"><fmt:message code="Saturday"/></option>
                                <option value="0"><fmt:message code="Sunday"/></option>
                            </select>
                            <input autocomplete="off" id="remindTime_1" name="remindTime"  type="text" />
                        </div>
                        <div style="display: none;">
                            <select name="today" id="today">
                                <option value="1">1<fmt:message code="global.lang.day" /></option>
                                <option value="2">2<fmt:message code="global.lang.day" /></option>
                                <option value="3">3<fmt:message code="global.lang.day" /></option>
                                <option value="4">4<fmt:message code="global.lang.day" /></option>
                                <option value="5">5<fmt:message code="global.lang.day" /></option>
                                <option value="6">6<fmt:message code="global.lang.day" /></option>
                                <option value="7">7<fmt:message code="global.lang.day" /></option>
                                <option value="8">8<fmt:message code="global.lang.day" /></option>
                                <option value="9">9<fmt:message code="global.lang.day" /></option>
                                <option value="10">10<fmt:message code="global.lang.day" /></option>
                                <option value="11">11<fmt:message code="global.lang.day" /></option>
                                <option value="12">12<fmt:message code="global.lang.day" /></option>
                                <option value="13">13<fmt:message code="global.lang.day" /></option>
                                <option value="14">14<fmt:message code="global.lang.day" /></option>
                                <option value="15">15<fmt:message code="global.lang.day" /></option>
                                <option value="16">16<fmt:message code="global.lang.day" /></option>
                                <option value="17">17<fmt:message code="global.lang.day" /></option>
                                <option value="18">18<fmt:message code="global.lang.day" /></option>
                                <option value="19">19<fmt:message code="global.lang.day" /></option>
                                <option value="20">20<fmt:message code="global.lang.day" /></option>
                                <option value="21">21<fmt:message code="global.lang.day" /></option>
                                <option value="22">22<fmt:message code="global.lang.day" /></option>
                                <option value="23">23<fmt:message code="global.lang.day" /></option>
                                <option value="24">24<fmt:message code="global.lang.day" /></option>
                                <option value="25">25<fmt:message code="global.lang.day" /></option>
                                <option value="26">26<fmt:message code="global.lang.day" /></option>
                                <option value="27">27<fmt:message code="global.lang.day" /></option>
                                <option value="28">28<fmt:message code="global.lang.day" /></option>
                                <option value="29">29<fmt:message code="global.lang.day" /></option>
                                <option value="30">30<fmt:message code="global.lang.day" /></option>
                                <option value="31">31<fmt:message code="global.lang.day" /></option>
                            </select>
                            <input  autocomplete="off" id="remindTime_2" name="remindTime"  type="text" />
                        </div>
                        <div style="display: none;">
                            <select name="mouthDate" id="mouthDate">
                                <option value="1">1<fmt:message code="global.lang.month" /></option>
                                <option value="2">2<fmt:message code="global.lang.month" /></option>
                                <option value="3">3<fmt:message code="global.lang.month" /></option>
                                <option value="4">4<fmt:message code="global.lang.month" /></option>
                                <option value="5">5<fmt:message code="global.lang.month" /></option>
                                <option value="6">6<fmt:message code="global.lang.month" /></option>
                                <option value="7">7<fmt:message code="global.lang.month" /></option>
                                <option value="8">8<fmt:message code="global.lang.month" /></option>
                                <option value="9">9<fmt:message code="global.lang.month" /></option>
                                <option value="10">10<fmt:message code="global.lang.month" /></option>
                                <option value="11">11<fmt:message code="global.lang.month" /></option>
                                <option value="12">12<fmt:message code="global.lang.month" /></option>
                            </select>
                            <select name="today" id="today_1">
                                <option value="1">1<fmt:message code="global.lang.day" /></option>
                                <option value="2">2<fmt:message code="global.lang.day" /></option>
                                <option value="3">3<fmt:message code="global.lang.day" /></option>
                                <option value="4">4<fmt:message code="global.lang.day" /></option>
                                <option value="5">5<fmt:message code="global.lang.day" /></option>
                                <option value="6">6<fmt:message code="global.lang.day" /></option>
                                <option value="7">7<fmt:message code="attend.th.day" /></option>
                                <option value="8">8<fmt:message code="attend.th.day" /></option>
                                <option value="9">9<fmt:message code="attend.th.day" /></option>
                                <option value="10">10<fmt:message code="attend.th.day" /></option>
                                <option value="11">11<fmt:message code="attend.th.day" /></option>
                                <option value="12">12<fmt:message code="attend.th.day" /></option>
                                <option value="13">13<fmt:message code="attend.th.day" /></option>
                                <option value="14">14<fmt:message code="attend.th.day" /></option>
                                <option value="15">15<fmt:message code="attend.th.day" /></option>
                                <option value="16">16<fmt:message code="attend.th.day" /></option>
                                <option value="17">17<fmt:message code="attend.th.day" /></option>
                                <option value="18">18<fmt:message code="attend.th.day" /></option>
                                <option value="19">19<fmt:message code="attend.th.day" /></option>
                                <option value="20">20<fmt:message code="attend.th.day" /></option>
                                <option value="21">21<fmt:message code="attend.th.day" /></option>
                                <option value="22">22<fmt:message code="attend.th.day" /></option>
                                <option value="23">23<fmt:message code="attend.th.day" /></option>
                                <option value="24">24<fmt:message code="attend.th.day" /></option>
                                <option value="25">25<fmt:message code="attend.th.day" /></option>
                                <option value="26">26<fmt:message code="attend.th.day" /></option>
                                <option value="27">27<fmt:message code="attend.th.day" /></option>
                                <option value="28">28<fmt:message code="attend.th.day" /></option>
                                <option value="29">29<fmt:message code="attend.th.day" /></option>
                                <option value="30">30<fmt:message code="attend.th.day" /></option>
                                <option value="31">31<fmt:message code="attend.th.day" /></option>
                            </select>
                            <input autocomplete="off" id="remindTime_3" name="remindTime"  type="text" />
                        </div>
                        <div style="display: none;"><input autocomplete="off" id="remindTime_4" name="remindTime"  type="text" /></div>
                    </td>
                </tr>
                <tr>
                    <td><fmt:message code="attend.th.Contentofthings"/></td>
                    <td><textarea id="contant" style="vertical-align: middle;" rows="3" cols="20" ></textarea><span style="color:#ff0000;font-size: 13pt;margin-left: 5px;">*</span></td>
                </tr>
                <tr>
                    <td><fmt:message code="attend.th.Participant"/></td>
                    <td><textarea style="" rows="3" cols="20" id="textUser"></textarea><a href="javascript:;" class="addbtn" style="margin: 0 10px" id="addUser"><fmt:message code="global.lang.add"/></a><a href="javascript:;" class="delbtn" id="clearUser"><fmt:message code="global.lang.empty"/></a></td>
                </tr>
                <tr>
                    <td><fmt:message code="file.th.reminder"/></td>
                    <td><input name="smsRemind" type="checkbox" value="1" checked="checked"><fmt:message code="notice.th.reminderSend"/></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;" class="btnarr">
                        <a href="javascript:;" id="saveNew" data-type="0"><fmt:message code="global.lang.save"/></a>
                        <a href="javascript:;" id="backPrev"><fmt:message code="notice.th.return"/></a>
                    </td>
                </tr>
            </table>
        </div>

    </div>
</div>
<div class="container queryWork" style="display: none;">
    <div class="condQuery">
        <span><fmt:message code="attend.th.Typesofthings"/>：</span>
        <select name="calType_query" id="calType_query" style="width: 218px;">
            <option value=""><fmt:message code="PleaseSelectTransactionType."/></option>
            <option value="1"><fmt:message code="attend.th.Worktransaction"/></option>
            <option value="2"><fmt:message code="main.affairs"/></option>
        </select>
        <span style="margin-left: 15px;"><fmt:message code="attend.th.Eventlevel"/>：</span>
        <select name="calLevel_query" id="calLevel_query" style="width: 218px;">
            <option value=""><fmt:message code="PleaseSelectEventLevel."/></option>
            <option value="1"><fmt:message code="attend.th.Importanturgent"/></option>
            <option value="2"><fmt:message code="attend.th.ImportantNourgent"/></option>
            <option value="3"><fmt:message code="attend.th.NOImportanturgent"/></option>
            <option value="4"><fmt:message code="attend.th.NOImportantNOurgent"/></option>
        </select>
        <a href="javascript:;" class="queryData" style="font-size: 12px;"><fmt:message code="global.lang.query"/></a>
    </div>
    <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;width: 60%;">
        <thead>
        <tr>
            <th><fmt:message code="attend.th.Contentofthings"/></th>
            <th><fmt:message code="attend.th.Typesofthings"/></th>
            <th><fmt:message code="sup.th.startTime"/></th>
            <th><fmt:message code="meet.th.EndTime"/></th>
            <th><fmt:message code="attend.th.Eventlevel"/></th>
        </tr>
        </thead>
        <tbody id="tbodyList">

        </tbody>
    </table>
</div>
<script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
<script type="text/javascript">
    var isShowSecret=false;

    var isShowSecret1=false;

    var isShowSecret2=false;
    //是否允许发送事务提醒，默认允许
    var isCan = true;
    //判断是否开启三员管理，如果开启则隐藏编辑功能
    var isOpenSanyuan = false;
    $.ajax({
        url:"/syspara/selectTheSysPara?paraName=IS_OPEN_SANYUAN",
        success:function(res) {
            var data = res.object[0];
            if(data.paraValue == 0) {
                //    进入此判断说明开启了三员管理
                isOpenSanyuan = true;
            }
        }
    })
    var user_id='';
    laydate.render({
        elem: '#beginTimeTime'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#newEndDate'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#newBeginDate'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#beginTime'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#endTime'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#endTimeTime'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#remindTime'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#remindTime_1'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#remindTime_2'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#remindTime_3'
        ,type: 'time'
        ,trigger: 'click'
    });
    laydate.render({
        elem: '#remindTime_4'
        ,type: 'time'
        ,trigger: 'click'
    });
    $('#newBeginDate').val(getNowFormatDate());
    var datat={
        calType:$('#calType_query option:selected').val(),
        calLevel:$('#calLevel_query option:selected').val()
    }
    $.ajax({
        type:'get',
        url:'../../schedule/getscheduleByTakerAndOwner',
        dataType:'json',
        data:datat,
        success:function (res) {
            $('#tbodyList').html('');
            var datas=res.obj;
            var str='';
            if(res.flag){
                if(datas.length>0){
                    for(var i=0;i<datas.length;i++){
                        str+='<tr>' +
                            '<td>'+datas[i].content+'</td>' +
                            '<td>'+function () {
                                if(datas[i].calType == '1'){
                                    return '<fmt:message code="attend.th.Worktransaction"/>';
                                }else {
                                    return '<fmt:message code="attend.th.Persontransaction"/>';
                                }
                            }()+'</td>' +
                            '<td>'+datas[i].stim+'</td>' +
                            '<td>'+datas[i].etim+'</td>' +
                            '<td>'+function () {
                                if(datas[i].calLevel == '1'){
                                    return '<fmt:message code="attend.th.Importanturgent"/>';
                                }else if(datas[i].calLevel == '2'){
                                    return '<fmt:message code="attend.th.ImportantNourgent"/>';
                                }else if(datas[i].calLevel == '3'){
                                    return '<fmt:message code="attend.th.NOImportanturgent"/>';
                                }else{
                                    return '<fmt:message code="attend.th.NOImportantNOurgent"/>';
                                }
                            }()+'</td>' +
                            '</tr>'
                    }

                }else{
                    str='<tr>' +
                        '<td colspan="5" class="no_notice" style="text-align: center;">' +
                        '<img style="" src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                        '</td>' +
                        '</tr>';
                }
                $('#tbodyList').html(str);
            }
        }
    })
    function getNowFormatDate() {
        var date = new Date();
        var seperator1 = "-";
        var month = date.getMonth() + 1;
        var strDate = date.getDate();
        if (month >= 1 && month <= 9) {
            month = "0" + month;
        }
        if (strDate >= 0 && strDate <= 9) {
            strDate = "0" + strDate;
        }
        var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate;
        return currentdate;
    }

    $(function () {
        $('#addUser').on('click',function () {
            user_id='textUser';
            $.popWindow("../common/selectUser");
        })
        $('#clearUser').on('click',function () {
            $('#textUser').val('');
            $('#textUser').attr('username','');
            $('#textUser').attr('dataid','');
            $('#textUser').attr('user_id','');
            $('#textUser').attr('userprivname','');
        })
        $('input[name="smsRemind"]').on('click',function () {
            var state=$(this).prop('checked');
            if(state==true){
                $(this).prop("checked",true);
                $(this).val('1');
            }else{
                $(this).prop("checked",false);
                $(this).val('0');
            }
        })
    })

    $(function(){
        // 查询提醒权限
        $.ajax({
            type:'get',
            url:'/smsRemind/getRemindFlag',
            dataType:'json',
            data:{
                type:5
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
                            isCan = false;
                            $('.remind').prop("checked", false);
                            $('.smsRemind').prop("checked", false);
                            $('.items').hide();
                        }

                    }
                }
            }
        })
    })


    //点击我的日程
    $('#myWork').on('click',function () {
        $('#myWork').addClass('active').siblings().removeClass('active');
        $('.myWork').removeClass('disnone');
        $('.cycleWork').addClass('disnone')
        $('.queryWork').hide();
    })
    //点击周期性事务
    $('#cycleWork').on('click',function () {
        $('#cycleWork').addClass('active').siblings().removeClass('active');
        $('.cycleWork').removeClass('disnone');
        $('.myWork').addClass('disnone');
        $('.queryWork').hide();
    })
    //    点击我的日程查询
    $('#queryWork').on('click',function () {
        $(this).addClass('active').siblings().removeClass('active');
        $('.cycleWork').addClass('disnone');
        $('.myWork').addClass('disnone');
        $('.queryWork').show();
    })
    //        点击查询
    $('.queryData').on('click',function () {
        var datat={

            calType:$('#calType_query option:selected').val(),
            calLevel:$('#calLevel_query option:selected').val()
        }
//        canlandData(datat);
        $.ajax({
            type:'get',
            url:'../../schedule/getscheduleByTakerAndOwner',
            dataType:'json',
            data:datat,
            success:function (res) {
                $('#tbodyList').html('');
                var datas=res.obj;
                var str='';
                if(res.flag){
                    if(datas.length>0){
                        for(var i=0;i<datas.length;i++){
                            str+='<tr>' +
                                '<td>'+datas[i].content+'</td>' +
                                '<td>'+function () {
                                    if(datas[i].calType == '1'){
                                        return '<fmt:message code="attend.th.Worktransaction"/>';
                                    }else {
                                        return '<fmt:message code="attend.th.Persontransaction"/>';
                                    }
                                }()+'</td>' +
                                '<td>'+datas[i].stim+'</td>' +
                                '<td>'+datas[i].etim+'</td>' +
                                '<td>'+function () {
                                    if(datas[i].calLevel == '1'){
                                        return '<fmt:message code="attend.th.Importanturgent"/>';
                                    }else if(datas[i].calLevel == '2'){
                                        return '<fmt:message code="attend.th.ImportantNourgent"/>';
                                    }else if(datas[i].calLevel == '3'){
                                        return '<fmt:message code="attend.th.NOImportanturgent"/>';
                                    }else{
                                        return '<fmt:message code="attend.th.NOImportantNOurgent"/>';
                                    }
                                }()+'</td>' +
                                '</tr>'
                        }

                    }else{
                        str='<tr>' +
                            '<td colspan="5" class="no_notice" style="text-align: center;">' +
                            '<img style="" src="/img/main_img/shouyekong.png" alt="">' +
                            '<h2 style="text-align: center;color: #666;">'+no_Data+'</h2>' +
                            '</td>' +
                            '</tr>';
                    }
                    $('#tbodyList').html(str);
                }
            }
        })

    })
    //请求周期性事务数据

    function undefindData(data) {
        if(data == undefined){
            return '';
        }else{
            return data;
        }
    }
    function worktype(num){
        switch(num)
        {
            case 2:
                return '<fmt:message code="Reminding"/>';
            case 3:
                return '<fmt:message code="WeeklyReminding"/>';
            case 4:
                return '<fmt:message code="MonthlyReminding"/>';
            case 5:
                return '<fmt:message code="AnnualReminding"/>';
            case 6:
                return '<fmt:message code="RemindByWorking"/>';
            default:
                return ''
        }
    }
    //进行条件查询方法，并在列表中显示
    var zhouData={
        page:1,//当前处于第几页
        pageSize:10,//一页显示几条
        useFlag:true,
        beginTimes:"",
        endTimes:"",
        content:""
    }
    initData(zhouData);

    /**
     * 查询按钮
     */
    $(".submit").on('click',function(){
        zhouData.beginTimes=$('#beginTime').val();
        zhouData.endTimes=$('#endTime').val();
        zhouData.content=$('#content').val();
        initData(zhouData);
    })

    //周期性事务删除
    $('#trList').on('click','.deletebtn',function () {
        var affId=$(this).parents('td').attr('data-id');
        layer.confirm('<fmt:message code="attend.th.qued"/>？', {
            btn: ['<fmt:message code="global.lang.ok"/>','<fmt:message code="depatement.th.quxiao"/>'] //按钮
        }, function(index){
            $.ajax({
                type:'post',
                url:'/Affair/deleteAffair',
                dataType:'json',
                data:{affId: affId},
                success:function (res) {
                    if (res.code == '100066'){
                        layer.msg('<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', {icon: 4});
                    } else if(res.flag){
                        layer.msg('<fmt:message code="workflow.th.delsucess"/>！', {icon: 1,time:1000});
                        layer.close(index);
                        initData(zhouData);
                    }else{
                        layer.msg('<fmt:message code="lang.th.deleSucess"/>！', {icon: 2,time:1000});
                        layer.close(index);
                    }
                }
            })
        }, function(index){
            layer.closeAll();
        });
    })

    //周期性事务编辑
    $('#trList').on('click','.editData',function () {
        $(".hhhed").html("<fmt:message code="calendar.th.editRecurringTasks" />")
        $('#saveNew').attr('data-type','1');
        var affId=$(this).parents('td').attr('data-id');
        $('input[name="editType"]').val(affId)
        $('.newCycleWork').removeClass('disnone').siblings().addClass('disnone');
        $.ajax({
            type:'get',
            url:'/Affair/selectAffair',
            dataType:'json',
            data:{
                affId:affId
            },
            success:function (res) {
                var datas=res.obj;
                if(res.flag){
                    $('input[name="beginTime"]').val((datas[0].beginTimes).substr(0,10));
                    $('input[name="endTime"]').val((datas[0].endTimes).substr(0,10));
                    $('input[name="beginTimeTime"]').val(datas[0].beginTimeTime);
                    $('input[name="endTimeTime"]').val(datas[0].endTimeTime);
                    $('#calType').val(datas[0].calType);
                    $('#repeatType').val(datas[0].type);
                    if(datas[0].type == '2'){
                        $('#showHide').find('div').eq(0).show().siblings().hide();
                        $('#remindTime').val(datas[0].remindTime);
                    }else if(datas[0].type == '3'){
                        $('#showHide').find('div').eq(1).show().siblings().hide();
                        $('#week').val(datas[0].remindDate);
                        $('#remindTime_1').val(datas[0].remindTime);
                    }else if(datas[0].type == '4'){
                        $('#showHide').find('div').eq(2).show().siblings().hide();
                        $('#today').val(datas[0].remindDate);
                        $('#remindTime_2').val(datas[0].remindTime);
                    }else if(datas[0].type == '5'){
                        $('#showHide').find('div').eq(3).show().siblings().hide();
                        var reDate=datas[0].remindDate.split('-');
                        $('#mouthDate').val(reDate[0]);
                        $('#today_1').val(reDate[1]);
                        $('#remindTime_3').val(datas[0].remindTime);
                    }
//                    $('input[name="remindTime"]').val(datas[0].remindTime);
                    $('#contant').val(datas[0].content);
                    $('#textUser').attr('user_id',datas[0].taker);
                    $('#textUser').val(datas[0].takerName);
                    if(datas[0].smsRemind == '1'){
                        $('input[name="smsRemind"]').prop('checked',true);
                    }else{
                        $('input[name="smsRemind"]').prop('checked',false);
                    }
                }
               if($('#contentSecrecy1').length<1){
                   $.ajax({
                       type:'get',
                       url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                       dataType:'json',
                       success:function (res) {
                           if (res.flag && res.object.length > 0) {
                               if (res.object[0].paraValue === "1") {
                                   isShowSecret = true;

                                   // 加密级下拉框
                                   $('#symbol').after('<tr><td style="display: inline-block;margin-left: 40px;">密级</td><td>' +
                                       '<select name="contentSecrecy" id="contentSecrecy1" style="width: 203px;height: 28px">' +
                                       '<option id="first1" value="">请选择密级</option>' +
                                       '</select><b style="color: red;margin-left: 5px">*</b></td></tr>');
                                   $.ajax({
                                       type: 'get',
                                       url: '/code/getCode?parentNo=CONTENT_SECRECY',
                                       dataType: 'json',
                                       success: function (res) {
                                           var str = '';
                                           if(datas[0].contentSecrecy===undefined){
                                               datas[0].contentSecrecy=''
                                           }
                                           for (let i = 0; i < res.obj.length; i++) {
                                               if(datas[0].contentSecrecy.indexOf(res.obj[i].codeNo)!=-1){
                                                   str += '<option selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>';
                                               }else {
                                                   str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>';
                                               }
                                           }
                                           $('#first1').after(str);
                                       }
                                   })

                               }
                           }
                       }
                   })
               }else{
                   $('#contentSecrecy1 option[value='+datas[0].contentSecrecy+']').prop('selected',true);
               }
            }
        })
    })

    //点击新建
    $('#newCycleWork').on('click',function(){
        $(".hhhed").html("<fmt:message code="NewPeriodic" />")
        $('.newCycleWork').removeClass('disnone').siblings().addClass('disnone');
        $('#saveNew').attr('data-type','0');
        if($('#contentSecrecy1').length<1){
            $.ajax({
                type:'get',
                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                dataType:'json',
                success:function (res) {
                    if (res.flag && res.object.length > 0) {
                        if (res.object[0].paraValue === "1") {
                            isShowSecret = true;

                            // 加密级下拉框
                            $('#symbol').after('<tr><td style="display: inline-block;margin-left: 40px;">密级</td><td>' +
                                '<select name="contentSecrecy" id="contentSecrecy1" style="width: 203px;height: 28px">' +
                                '<option id="first1" value="">请选择密级</option>' +
                                '</select><b style="color: red;margin-left: 5px">*</b></td></tr>');
                            $.ajax({
                                type: 'get',
                                url: '/code/getCode?parentNo=CONTENT_SECRECY',
                                dataType: 'json',
                                success: function (res) {
                                    var str = '';
                                    for (let i = 0; i < res.obj.length; i++) {
                                        str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>';
                                    }
                                    $('#first1').after(str);
                                }
                            })

                        }
                    }
                }
            })
        }else {
            $('#first1').prop('selected',true);
        }
    })

    //    改变重复类型
    $('#repeatType').on('change',function () {
        var index=$(this).find('option:selected').index();
        $('#showHide').find('div').eq(index).show().siblings().hide();
    })

    //确认新建
    $('#saveNew').on('click',function(){
        var saveType=$(this).attr('data-type');
        var remindDate='';
        var remindTime='';
        if($('#contant').val() == ''){
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheTaskDetails" />！',{icon:0});
            return;
        }
        if (isShowSecret){
            if($('#contentSecrecy1').val()==''){
                layer.msg('请选择密级！',{icon:0});
                return;
            }
        }
        if($('#beginTimeTime').val() == ''){
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheStartTime" />！',{icon:0});
            return;
        }
        if($('#endTimeTime').val() == ''){
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheEndTime" />！',{icon:0});
            return;
        }
        if($('#repeatType option:selected').val() == '2'){
            remindTime=$('#remindTime').val();
            remindDate='';
        }else if($('#repeatType option:selected').val() == '3'){
            remindDate=$('#week option:selected').val();
            remindTime=$('#remindTime_1').val();
        }else if($('#repeatType option:selected').val() == '4'){
            remindDate=$('#today option:selected').val();
            remindTime=$('#remindTime_2').val();
        }else if($('#repeatType option:selected').val() == '5'){
            remindDate=$('#mouthDate option:selected').val()+'-'+$('#today_1 option:selected').val();
            remindTime=$('#remindTime_3').val();
        }else{
            remindTime=$('#remindTime_4').val();
            remindDate='';
        }
        if(saveType == '0'){
            $.ajax({
                type:'post',
                url:'/Affair/insertAffair',
                dataType:'json',
                data:{
                    beginTimes:$('input[name="beginTime"]').val(),
                    endTimes:$('input[name="endTime"]').val(),
                    beginTimeTime:$('input[name="beginTimeTime"]').val(),
                    endTimeTime:$('input[name="endTimeTime"]').val(),
                    calType:$('#calType option:selected').val(),
                    type:$('#repeatType option:selected').val(),
                    remindDate:remindDate,
                    remindTime:remindTime,
                    content:$('#contant').val(),
                    taker:$('#textUser').attr('user_id'),
                    smsRemind:$('input[name="smsRemind"]').val(),
                    contentSecrecy:$('#contentSecrecy1').val()
                },
                success:function (res) {
                    if(res.flag){
                        layer.msg('<fmt:message code="diary.th.modify" />！',{icon:1})
                        initData(zhouData);
                        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
                        $('input[name="beginTime"]').val('')
                        $('input[name="endTime"]').val('')
                        $('input[name="beginTimeTime"]').val('')
                        $('#contant').val('')
                        $('#textUser').val('');
                        $('#textUser').attr('username','');
                        $('#textUser').attr('dataid','');
                        $('#textUser').attr('user_id','');
                        $('#textUser').attr('userprivname','');
                    }else{
                        layer.msg('<fmt:message code="meet.th.SaveFailed" />！',{icon:2})
                    }
                }
            })
        }else{
            for(var i=0;i<$("#showHide").find("input").length;i++){
                if($("#showHide").find("input").eq(i).parent().css("display") == "block"){
                    var saveremindTime = $("#showHide").find("input").eq(i).val();
                }
            }
            var edTypeId=$('input[name="editType"]').val();
            $.ajax({
                type:'post',
                url:'/Affair/updateAffair',
                dataType:'json',
                data:{
                    affId:edTypeId,
                    beginTimes:$('input[name="beginTime"]').val(),
                    endTimes:$('input[name="endTime"]').val(),
                    beginTimeTime:$('input[name="beginTimeTime"]').val(),
                    endTimeTime:$('input[name="endTimeTime"]').val(),
                    calType:$('#calType option:selected').val(),
                    type:$('#repeatType option:selected').val(),
                    remindTime:saveremindTime,
                    content:$('#contant').val(),
                    taker:$('#textUser').attr('user_id'),
                    smsRemind:$('input[name="smsRemind"]').val(),
                    contentSecrecy:$('#contentSecrecy1').val()||''
                },
                success:function (res) {
                    if(res.flag){
                        layer.msg('<fmt:message code="depatement.th.Modifysuccessfully" />！',{icon:1})
                        initData(zhouData);
                        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
                        $('input[name="beginTime"]').val('')
                        $('input[name="endTime"]').val('')
                        $('input[name="beginTimeTime"]').val('')
                        $('#contant').val('')
                        $('#textUser').val('');
                        $('#textUser').attr('username','');
                        $('#textUser').attr('dataid','');
                        $('#textUser').attr('user_id','');
                        $('#textUser').attr('userprivname','');
                    }else{
                        layer.msg('<fmt:message code="depatement.th.modifyfailed" />！',{icon:2});
                    }
                }
            })
        }

    })
    //返回
    $('#backPrev').on('click',function(){
        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
        $('input[name="beginTime"]').val('')
        $('input[name="endTime"]').val('')
        $('input[name="beginTimeTime"]').val('')
        $('#contant').val('')
        $('#textUser').val('');
        $('#textUser').attr('username','');
        $('#textUser').attr('dataid','');
        $('#textUser').attr('user_id','');
        $('#textUser').attr('userprivname','');
    })

    function xiangqingData(that) {
        var dataId=that.attr('data-id');
        $.ajax({
            type:'get',
            url:'/Affair/selectAffair',
            dataType:'json',
            data:{
                affId:dataId
            },
            success:function (res) {
                var datas=res.obj;
                layer.open({
                    type: 1,
                    /* skin: 'layui-layer-rim', //加上边框 */
//                    offset: '80px',
                    area: ['500px', '260px'], //宽高
                    title:"<fmt:message code="file.th.detail"/>",
                    content:'<table class="layerTable" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">' +
                    '<tr>' +
                    '<td><fmt:message code="attend.th.Remindertime"/>：</td>' +
                    '<td>'+datas[0].remindTime+'</td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td><fmt:message code="creator"/>：</td>' +
                    '<td>'+undefindData(datas[0].userName)+'</td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td><fmt:message code="attend.th.Participant"/>：</td>' +
                    '<td title="'+undefindData(datas[0].takerName)+'">'+undefindData(datas[0].takerName)+'</td>' +
                    '</tr>' +
                    '<tr>' +
                    '<td><fmt:message code="attend.th.Contentofthings"/>：</td>' +
                    '<td title="'+undefindData(datas[0].content)+'">'+undefindData(datas[0].content)+
                        '<span style="color:red">'+undefindData(datas[0].contentSecrecy)+'</span>'+
                        '</td>' +
                    '</tr>' +
                    '</table>',
                })
            }
        })

    }

    function initData(inData) {
        var ajaxPage={
            data:inData,
            init:function () {
            },
            page:function () {
                var me=this;
                $.get('/Affair/selectAffair',me.data,function (obj) {
                    $("#trList").html("");
//                var userId = $.cookie('userId');//用户id
//                var userPriv = $.cookie('userPriv');//用户角色
//                var userPrivOther = $.cookie('userPrivOther')?$.cookie('userPrivOther'):"";//用户辅助角色
                    var str="";
                    var data=obj.obj;
                    if(obj.flag){
                        for(var i=0;i<data.length;i++){
//                        if(userPriv==1||userPrivOther==1){
                            str+= '<tr>'+
                                '<td title="'+(data[i].beginTimes).substr(0,10)+'">'+(data[i].beginTimes).substr(0,10)+'</td>'+
                                '<td title="'+(data[i].endTimes).substr(0,10)+'">'+(data[i].endTimes).substr(0,10)+'</td>'+
                                '<td title="'+data[i].beginTimeTime+'">'+data[i].beginTimeTime+'</td>'+
                                '<td title="'+data[i].endTimeTime+'">'+data[i].endTimeTime+'</td>'+
//                                '<td title="">'+function(){
//                                    if(data[i].type == '2'){
//                                        return '按日提醒'
//                                    }else if(data[i].type == '3'){
//                                        return '按周提醒'
//                                    }else if(data[i].type == '4'){
//                                        return '按月提醒'
//                                    }else if(data[i].type == '5'){
//                                        return '按年提醒'
//                                    }else if(data[i].type == '6'){
//                                        return '按工作日提醒'
//                                    }else{
//                                        return ''
//                                    }
//                                }()+'</td>'+
//                                '<td title="'+undefindData(data[i].remindDate)+'">'+undefindData(data[i].remindDate)+'</td>'+
                                '<td title="'+undefindData(data[i].remindTime)+'">'+undefindData(data[i].remindTime)+'</td>'+
                                '<td title="'+undefindData(data[i].content)+'"><a href="javascript:;" data-id="'+data[i].affId+'" onclick="xiangqingData($(this))" >'+undefindData(data[i].content)+'</a></td>'+
                                '<td data-id="'+data[i].affId+'">'+function () {
                                    if(data[i].managerStatus){
                                        if(isOpenSanyuan) {
                                            return '<a href="javascript:void(0)" class="deletebtn"><fmt:message code="global.lang.delete" /></a>';
                                        }else {
                                            return '<a href="javascript:void(0)" style="margin-right: 10px;" class="editData"><fmt:message code="global.lang.edit" /></a><a href="javascript:void(0)" class="deletebtn"><fmt:message code="global.lang.delete" /></a>';
                                        }
                                    }else{
                                        return '';
                                    }
                                }()+'</td>'+
                                '</tr>'
                        }
                        $("#trList").html(str);
                    }
                    me.pageTwo(obj.totleNum,me.data.pageSize,me.data.page)
                },'json')
            },
            pageTwo:function (totalData, pageSize,indexs) {
                var mes=this;
                $('#dbgz_page').pagination({
                    totalData: totalData,
                    showData: pageSize,
                    jump: true,
                    coping: true,
                    homePage:'',
                    endPage: '',
                    current:indexs||1,
                    callback: function (index) {
                        mes.data.page=index.getCurrent();
                        mes.page();
                    }
                });
            }
        }
//    ajaxPage.init();
        ajaxPage.page();
    }

    var user_id;
    function clearOwnerName(){
        //console.log(id);
        $("#OWNER_NAME").val('');
        $("#OWNER_NAME").attr("user_id",'');
        $("#OWNER_NAME").attr("username",'');
        $("#OWNER_NAME").attr("dataid",'');
        $("#OWNER_NAME").attr("userprivname",'');

    }
    function parseISO8601(dateStringInRange) {
        var year = dateStringInRange.split('-')[0];
        var month = dateStringInRange.split('-')[1];
        var day = dateStringInRange.split('-')[2];

        var date = year + '/' +month+ '/' +day;
        //console.log(date);
        return date;
    }
    function clearTakerName(){
        //console.log(id);
        $("#TAKER_NAME").val('');
        $("#TAKER_NAME").attr("user_id",'');
        $("#TAKER_NAME").attr("username",'');
        $("#TAKER_NAME").attr("dataid",'');
        $("#TAKER_NAME").attr("userprivname",'');

    }
    function getLocalTime(nS){
//        console.log(nS)
        return new Date(parseInt(nS) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
    }


    $(document).ready(function(){
        //alert("加载开始1");
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var timestamp = Date.parse(new Date());
        var timestamp = timestamp / 1000;

        canlandData();

    });
    var userName='',userId='';
    $.ajax({
        url: '/Meetequipment/getuser',
        type: 'get',
        dataType: 'json',
        success: function (res) {
            userName=res.object.userName
            userId=res.object.userId
        }
    })
    function canlandData() {
        var arr=[];
        $.ajax({
            url:"../../schedule/getscheduleByTakerAndOwner",
            type:"get",
            dataType:"json",

            success:function (data){
                //alert("请求成功"); 5
                var arrObject;
                for(var i=0;i<data.obj.length;i++){
                    if(data.obj[i].calLevel==1){
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id:data.obj[i].calId,
                            calLevel:data.obj[i].calLevel,
                            calType:data.obj[i].calType,
                            takeIds:data.obj[i].taker,
                            takeName:data.obj[i].takeName,
                            ownerIds:data.obj[i].owner,
                            ownerName:data.obj[i].ownerName,
                            color:"#ff5757",
                            backgroundColor:"#ff5757",
                            beforeDay:data.obj[i].beforeDay,
                            beforeHour:data.obj[i].beforeHour,
                            beforeMin:data.obj[i].beforeMin,
                            beforeRemaind:data.obj[i].beforeRemaind,
                            edit:data.obj[i].edit,
                            userName:data.obj[i].userName,
                            contentSecrecy:data.obj[i].contentSecrecy
                        };
                    }else if(data.obj[i].calLevel==2){
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id:data.obj[i].calId,
                            calLevel:data.obj[i].calLevel,
                            calType:data.obj[i].calType,
                            takeIds:data.obj[i].taker,
                            takeName:data.obj[i].takeName,
                            ownerIds:data.obj[i].owner,
                            ownerName:data.obj[i].ownerName,
                            color:"#ff9540",
                            backgroundColor:"#ff9540",
                            beforeDay:data.obj[i].beforeDay,
                            beforeHour:data.obj[i].beforeHour,
                            beforeMin:data.obj[i].beforeMin,
                            beforeRemaind:data.obj[i].beforeRemaind,
                            edit:data.obj[i].edit,
                            userName:data.obj[i].userName,
                            contentSecrecy:data.obj[i].contentSecrecy

                        };
                    }else if(data.obj[i].calLevel==3){
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id:data.obj[i].calId,
                            calLevel:data.obj[i].calLevel,
                            calType:data.obj[i].calType,
                            takeIds:data.obj[i].taker,
                            takeName:data.obj[i].takeName,
                            ownerIds:data.obj[i].owner,
                            ownerName:data.obj[i].ownerName,
                            color:"#ce84ce",
                            backgroundColor:"#ce84ce",
                            beforeDay:data.obj[i].beforeDay,
                            beforeHour:data.obj[i].beforeHour,
                            beforeMin:data.obj[i].beforeMin,
                            beforeRemaind:data.obj[i].beforeRemaind,
                            edit:data.obj[i].edit,
                            userName:data.obj[i].userName,
                            contentSecrecy:data.obj[i].contentSecrecy
                        };
                    }else if(data.obj[i].calLevel==4){
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id:data.obj[i].calId,
                            calLevel:data.obj[i].calLevel,
                            calType:data.obj[i].calType,
                            takeIds:data.obj[i].taker,
                            takeName:data.obj[i].takeName,
                            ownerIds:data.obj[i].owner,
                            ownerName:data.obj[i].ownerName,
                            color:"#45a2ff",
                            backgroundColor:"#45a2ff",
                            beforeDay:data.obj[i].beforeDay,
                            beforeHour:data.obj[i].beforeHour,
                            beforeMin:data.obj[i].beforeMin,
                            beforeRemaind:data.obj[i].beforeRemaind,
                            edit:data.obj[i].edit,
                            userName:data.obj[i].userName,
                            contentSecrecy:data.obj[i].contentSecrecy
                        };
                    }else{
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id:data.obj[i].calId,
                            calLevel:data.obj[i].calLevel,
                            calType:data.obj[i].calType,
                            takeIds:data.obj[i].taker,
                            takeName:data.obj[i].takeName,
                            ownerIds:data.obj[i].owner,
                            ownerName:data.obj[i].ownerName,
                            color:"#45a2ff",
                            backgroundColor:"#45a2ff",
                            beforeDay:data.obj[i].beforeDay,
                            beforeHour:data.obj[i].beforeHour,
                            beforeMin:data.obj[i].beforeMin,
                            beforeRemaind:data.obj[i].beforeRemaind,
                            edit:data.obj[i].edit,
                            userName:data.obj[i].userName,
                            contentSecrecy:data.obj[i].contentSecrecy
                        };
                    }
                    arr.push(arrObject);
                }
                // console.log($('#calendar'));
                if($('#calendar').length > 0){
                    var timestamp = Date.parse(new Date());
                    var timer=parseInt(timestamp)+3600000;
                    var startTime=new Date(timestamp).Format('hh:mm:ss');
                    var endTime=new Date(timer).Format('hh:mm:ss');

                    $('#START_DATE').val(startTime);
                    $('#EDN_DATE').val(endTime)
                    // alert("加载开始2");
                    $('#calendar').fullCalendar({

                        header: {
                            left: 'prev,next,today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'

                        },
                        buttonText:{
                            today:'<fmt:message code="attend.th.Jumptoday"/>'
                        },
                        editable: true,
                        timeFormat: 'HH:mm',//时间格式
                        events:arr,
                        //新建日程
                        dayClick: function (date, allDay, jsEvent, view) {
                            /*date=new Date(date);*/
                            date=date._d.Format('yyyy-MM-dd');
                            layer.open({
                                type: 1,
//                                skin: 'layui-layer-rim', //加上边框
                                offset: '30px',
                                area: ['720px', '90%'], //宽高
                                title:"<fmt:message code="attend.th.Newschedule"/>",
                                closeBtn: 2,
                                btn:['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>'],
                                content:'<div id="myModal" class="modal hide in">' +
                                '   <div class="modal-header"></div>' +
                                '<div class="modal-body" id="new_modal">' +
                                // 事务内容
                                ' <div class="control-group group_one" id="transactionContent" >' +
                                '           <span class="typeone" style="color:red;font-size:14px">*</span>' +
                                '       <span class="typeone ty" style="font-size:14px"><fmt:message code="attend.th.Contentofthings"/>:</span> '+
                                '               <textarea style="resize:none; font-size:14px;vertical-align: inherit;" name="CAL_CONTENT"  id="CAL_CONTENT" placeholder="<fmt:message code="new.th.putcontent"/>" class="input input-xl CAL_CONTENT text_boder  test_null"></textarea>' +
                                '       </div>' +
                                // 事务类型
                                '       <div class="control-group">' +
                                '           <span style="color:red;font-size:14px ">*</span>' +
                                '           <span class="ty" style="font-size:14px"><fmt:message code="attend.th.Typesofthings"/>:</span>'+
                                '           <select class="smallSelect text_boder" name="CAL_TYPE text_boder" id="CAL_TYPE" style="height: 30px;width: 280px;">' +
                                '               <option value="1"><fmt:message code="attend.th.Worktransaction"/></option>' +
                                '               <option value="2"><fmt:message code="attend.th.Persontransaction"/></option>' +
                                '           </select>' +
                                '       </div>' +
                                // 开始时间
                                '       <div class="control-group" style=" clear:both">' +
                                '           <span style="color:red;font-size:14px ">*</span>' +
                                '           <span class="ty" style="font-size:14px"><fmt:message code="sup.th.startTime"/>:</span> '+
                                '           <input name="START_DATE" id="START_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" value="'+ date +'">' +

                                '       </div>' +
                                // 结束时间
                                '       <div class="control-group" id="endtimeArea1" style="">' +
                                '           <span style="color:red;font-size:14px ">*</span>' +
                                '           <span class="ty" style="font-size:14px"><fmt:message code="meet.th.EndTime"/>:</span> '+
                                '           <input name="EDN_DATE" id="EDN_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.EndDate"/>" type="text">' +

                                '       </div>' +
                                // 参与者
                                '       <div class="control-go" style="">' +
                                '           <span class="TAKER ty" style="font-size:14px;margin-left:0px"><fmt:message code="attend.th.Participant"/>:<br> <span style="font-size:8px;color:red;float:left">(<fmt:message code="calendar.th.onlyAbleToViewSchedule" />)</span> </span>' +
                                '           <textarea name="TAKER_NAME" id="TAKER_NAME" class="BigStatic" wrap="yes" readonly="" style="height:54px;width: 274px;border-radius:3px;"></textarea>' +
                                '       <a href="javascript:;" id="takerOrgAdd" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>'+
                                '           <a href="javascript:;" id="takerOrgClear" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                                '       </div>' +
                                // 所属者
                                '       <div class="control-go" style="">' +
                                '           <span class="OWNER ty" style="font-size:14px;margin-left:0px"><fmt:message code="attend.th.Subordinate"/>:<br><span style="font-size:8px;color:red;float:left">(<fmt:message code="calendar.th.canViewAndEditTheSchedule" />)</span></span> '+
                                '           <textarea cols="35" name="OWNER_NAME" id="OWNER_NAME" class="BigStatic" wrap="yes" readonly="" style="height:54px; width: 274px;border-radius:3px;"><fmt:message code="email.th.systemmanager" /></textarea>' +
                                '           <a href="javascript:;" id="ownerOrgAdd" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +

                                '           <a href="javascript:;" id="ownerOrgClear" onclick="clearOwnerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                                '       </div>' +
                                // 事件级别
                                '       <div class="control-group" style="">' +
                                '           <span style="color:red;font-size:14px ">*</span>' +
                                '           <span class="ty" style="font-size:14px"><fmt:message code="attend.th.Eventlevel"/>:</span>'+
                                '           <select id="CAL_LEVEL" class="CAL_LEVEL text_boder" style="height: 30px;width: 280px;margin-left: 7px;">' +
                                '               <option value="1"><fmt:message code="attend.th.Importanturgent"/></option>'+
                                '               <option value="2"><fmt:message code="attend.th.ImportantNourgent"/></option>' +
                                '               <option value="3"><fmt:message code="attend.th.NOImportanturgent"/></option>' +
                                '               <option value="4"><fmt:message code="attend.th.NOImportantNOurgent"/></option>' +
                                '           </select>' +
                                '       </div>' +
                                // 提醒时间
                                '       <div class="control-group">' +
                                '           <span class="ty" class="ty" style="font-size:14px;display:inline;margin:0 12px 0 10px;"><fmt:message code="attend.th.Remindertime"/>:</span><fmt:message code="meet.th.Advance"/><input type="text" name="BEFORE_DAY" id="BEFORE_DAY" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="attend.th.today"/><input type="text" name="BEFORE_HOUR" id="BEFORE_HOUR" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="meet.th.hour"/><input type="text" name="BEFORE_MIN" id="BEFORE_MIN" size="3" class="input input-small" style="width:30px" value="10"><fmt:message code="attend.th.Minutesreminder"/>'+
                                '       </div>' +
                                '   </div>' +
                                '   <div class="modal-footer"></div>' +
                                '<div class="control-group tixingBox"><span class="span_td tixing ty" style="margin-left:10px;margin-right:10px"><fmt:message code="notice.th.reminder" />:</span><span><input type="checkbox" class="remind" checked="checked" style="width:16px;vertical-align: middle;"><fmt:message code="notice.th.remindermessage" />&nbsp;&nbsp;<input type="checkbox" class="smsRemind" style="width:16px;vertical-align: middle;"><fmt:message code="vote.th.UseRemind" /></span></div>\n'+
                                '</div>',
                                yes: function(index, layero){
                                    var array=$(".test_null");
                                    for(var i=0;i<array.length;i++){
                                        if(array[i].value==""){
                                            $.layerMsg({content:"<fmt:message code="meet.th.AnAsterisk"/>",icon:3},function(){
                                            });
                                            return;
                                        }/*else{
                                         layer.msg('此客户已经添加过！')
                                         return false;



                                         }*/

                                    }
                                    if (isShowSecret1){
                                        if($('#contentSecrecy').val()==''){
                                            layer.msg('请选择密级！',{icon:0});
                                            return;
                                        }
                                    }
                                    //新建日程接口
                                    var calTime=Date.parse(new Date($("#START_DATE").val().replace(/-/g,"/")))/1000;
                                    var endTime=Date.parse(new Date($("#EDN_DATE").val().replace(/-/g,"/")))/1000;
                                    var calLevel=$("#CAL_LEVEL option:selected").attr("value");
                                    var calType=$("#CAL_TYPE option:selected").attr("value");
                                    var content=$("#CAL_CONTENT").val();
                                    var takerOrgAdd = $("#TAKER_NAME").attr("user_id");
                                    var ownerOrgAdd = $("#OWNER_NAME").attr("user_id");
                                    if(ownerOrgAdd.indexOf(userId)>-1){
                                        ownerOrgAdd=ownerOrgAdd
                                    }else{
                                        ownerOrgAdd=ownerOrgAdd+userId
                                    }
                                    var beforeDay=$("#BEFORE_DAY").val();
                                    var beforeHour=$("#BEFORE_HOUR").val();
                                    var beforeMin=$("#BEFORE_MIN").val();
                                    //console.log(takerOrgAdd);
                                    //console.log(ownerOrgAdd);
                                    //oldCodeName=$("select option:selected").val();
                                    //var calId=
                                    var data={
                                        //calId:calId,
                                        calType:calType,
                                        content:content,
                                        calTime:calTime,
                                        endTime:endTime,
                                        userId:$.cookie('userId'),
                                        calLevel:calLevel,
                                        owner:ownerOrgAdd,
                                        taker:takerOrgAdd,
                                        beforeDay:beforeDay,
                                        beforeHour:beforeHour,
                                        beforeMin:beforeMin,
                                        contentSecrecy:$('#contentSecrecy').val()||'',
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
                                    };




                                    $.ajax({
                                        url:"../../schedule/addCalender",
                                        data:data,
                                        type:"post",
                                        dataType:"json",
                                        success:function(){
                                            $.ajax({
                                                url:"../../schedule/getscheduleByTakerAndOwner",
                                                type:"get",
                                                dataType:"json",

                                                success:function (data){
                                                    //alert("请求成功");
                                                    if(data.flag==true){
                                                        var arrObject;
                                                        for(var i=0;i<data.obj.length;i++){
                                                            var arrObject = {
                                                                title: data.obj[i].content,
                                                                start: data.obj[i].stim,
                                                                end: data.obj[i].etim,
                                                                id:data.obj[i].calId,
                                                                contentSecrecy:data.obj[i].contentSecrecy

                                                            };
                                                            // console.log(data.obj[i].calId);
                                                            arr.push(arrObject);
                                                            //console.log(arr);
                                                        }
                                                        return arr;
                                                    }else if(data.flag==false){
                                                        $.layerMsg({content:'<fmt:message code="attend.th.NewFail"/>',icon:0},function(){});
                                                    }
                                                }
                                            });
                                            location.reload();
                                        }
                                    })

                                },
                                success:function(layero, index){
                                    if(!isCan) {
                                        $(".tixingBox").hide();
                                    }
                                    $.ajax({
                                        type:'get',
                                        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                                        dataType:'json',
                                        success:function (res) {
                                            if(res.object.length!=0){
                                                var data=res.object[0]
                                                if (data.paraValue!=0){
                                                    isShowSecret1=true;
                                                    $('#transactionContent').after('<div style="margin-left: 130px;" class="control-group">' +
                                                        '<span style="color:red;font-size:14px">*</span>'+
                                                        '<span>密级:</span>'+
                                                        '<select id="contentSecrecy" style="height: 30px;width: 280px;margin-left: 15px;">' +
                                                        '<option id="first">请选择密级</option>'+
                                                        '</select>'+
                                                        '</div>')
                                                    $.ajax({
                                                        type:'get',
                                                        url:'/code/getCode?parentNo=CONTENT_SECRECY',
                                                        dataType:'json',
                                                        success:function (res) {
                                                            var str=''
                                                            for (let i = 0; i <res.obj.length ; i++) {
                                                                str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                            }
                                                            $('#first').after(str)
                                                        }
                                                    })

                                                }
                                            }
                                        }
                                    })
                                    $('#OWNER_NAME').val(userName+",").attr('user_id',userId+",")
                                    laydate.render({
                                        elem: '#START_DATE'
                                        ,type: 'datetime'
                                        ,trigger: 'click'
                                    });
                                    laydate.render({
                                        elem: '#EDN_DATE'
                                        ,type: 'datetime'
                                        ,trigger: 'click'

                                    });
                                    var today = $('#START_DATE').val();
                                    var todayBegin = today + ' 09:00:00';
                                    var todayEnd = today + ' 11:00:00';
                                    $('#START_DATE').val(todayBegin);
                                    $('#EDN_DATE').val(todayEnd);
                                    $("#takerOrgAdd").on("click",function(){
                                        user_id='TAKER_NAME';
                                        $.popWindow("../common/selectUser");
                                    });
                                    $("#ownerOrgAdd").on("click",function(){
                                        user_id='OWNER_NAME';
                                        $.popWindow("../common/selectUser");
                                    });



                                }
                            });
                        },
                        //拖拽保存
                        eventDrop:function (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view){
                            //alert(123);
                            var calTime=Date.parse(new Date(event.start))/1000;
                            var endTime=Date.parse(new Date(event.end))/1000;
                            var calLevel=event.calLevel;
                            var calType=event.calType;
                            var content=event.title;
                            var calId=event.id;
                            var takerOrgAdd = event.taker;
                            var ownerOrgAdd = event.owner;
                            //var calId=calEvent.id;
                            var data={
                                calId:calId,
                                calType:calType,
                                content:content,
                                calTime:calTime,
                                endTime:endTime,
                                userId:$.cookie('userId'),
                                calLevel:calLevel,
                                owner:ownerOrgAdd,
                                taker:takerOrgAdd,
                            };
                            $.ajax({
                                url:"../../schedule/editCalender",
                                type:"post",
                                data:data,
                                dataType:"json",
                                success:function (){
                                    //location.reload();
                                }
                            })
                        },
                        //编辑已有日程
                        eventClick:function (calEvent, jsEvent, view){
                            console.log(calEvent)

                            if(calEvent.beforeRemaind ==""  || calEvent.beforeRemaind == undefined || calEvent.beforeRemaind == "undefined"){
                            }else{
                                var arrBefore=calEvent.beforeRemaind.split('|');
                                var beforeDay=arrBefore[0];
                                var beforeHour=arrBefore[1];
                                var beforeMin=arrBefore[2];
                            }

                            var content=calEvent.title;
                            //var calTime=getLocalTime(parseInt(calEvent.start,10));
                            //var endTime=getLocalTime(parseInt(calEvent.end,10));
                            var starttime=(calEvent.start)/1000;
                            var endtime=(calEvent.end)/1000;
                            //console.log(calEvent.start);
                            //console.log(calEvent.end);
                            var calTime=calEvent.start._i


                            var endTime=calEvent.end._i
                            var cal_level=calEvent.calLevel;
                            var cal_type=calEvent.calType;
                            var ownerName=calEvent.ownerName;
                            var takeName=calEvent.takeName;
                            var takeIds=calEvent.takeIds;
                            var ownerIds=calEvent.ownerIds;

                            var type_map=["<fmt:message code="attend.th.Worktransaction"/>","<fmt:message code="attend.th.Persontransaction"/>"];
                            var level_map=["<fmt:message code="attend.th.Importanturgent"/>","<fmt:message code="attend.th.ImportantNourgent"/>","<fmt:message code="attend.th.NOImportanturgent"/>","<fmt:message code="attend.th.NOImportantNOurgent"/>"];
                            var cal_type_str=type_map[cal_type-1];
                            var cal_type_str2;
                            if(cal_type==1){
                                cal_type_str2=type_map[1];
                                cal_type2=2;
                            }else{
                                cal_type_str2=type_map[0];
                                cal_type2=1;
                            }
                            if(calEvent.remind=='0'){
                                $('.remind').prop("checked", false);
                            }else if(calEvent.remind=='1'){
                                $('.remind').prop("checked", true);
                            }
                            if(calEvent.smsRemind=='0'){
                                $('.smsRemind').prop("checked", false);
                            } else if (calEvent.smsRemind=='1'){
                                $('.smsRemind').prop("checked", true);
                            }
                            var cal_level_str=level_map[cal_level-1];
                            layer.open({
                                type: 1,
                                /* skin: 'layui-layer-rim', //加上边框 */
                                offset: '30px',
                                area: ['600px', '90%'], //宽高
                                title:"<fmt:message code="attend.th.Scheduleedit"/>",

                                closeBtn: 2,
                                content: '<div id="myModal" class="modal hide in">' +
                                '<div class="modal-header"></div>' +
                                '<div class="modal-body" id="new_modal" style="max-height:300px;">' +
                                '<div class="control-group" style="margin-left: 86px;"><span class="ty"><fmt:message code="calendar.th.scheduleCreator" />:</span><label>' +
                                '<input style="background-color: rgb(235, 235, 228);width: 280px;" value="'+calEvent.userName+'" id="creator"  class="input input-xl CAL_CONTENT text_boder test_null text_boder" >' +
                                '</label></div>' +
                                '<div class="control-group" id="transactionContent">' +
                                '<span class="ty"><fmt:message code="attend.th.Contentofthings"/>:' +
                                '<textarea  name="CAL_CONTENT" style="height: auto;resize : none;width: 275px;" id="CAL_CONTENT" placeholder="<fmt:message code="notice.th.content"/>" class="input input-xl CAL_CONTENT text_boder test_null" ></textarea>'+
                                '</span>' +
                                '<span style="color:red;">*</span>' +
                                '</div>' +
                                '<div class="control-group">' +
                                '<span class="ty"><fmt:message code="attend.th.Typesofthings"/>:</span>'+
                                '<select class="smallSelect text_boder" name="CAL_TYPE" id="CAL_TYPE" style="height: 29px;width: 280px;">' +
                                '<option value="'+cal_type+'">'+cal_type_str+'</option>' +
                                '<option value="'+cal_type2+'">'+cal_type_str2+'</option>' +
                                '</select>' +
                                '<span style="color:red;font-size:14px ">*</span>' +
                                '</div>' +
                                '<div class="control-group" style=" clear:both">' +
                                '<span class="ty"><fmt:message code="sup.th.startTime"/>:</span>' +
                                '<input name="START_DATE" autocomplete="off" id="START_DATE" style="width: 280px;" class="text_boder test_null" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" value="'+calTime+'">' +
                                '<span style="color:red;font-size:14px ">*</span>' +
                                '</div>' +
                                '<div class="control-group" id="endtimeArea1" style="">' +
                                '<span class="ty"><fmt:message code="meet.th.EndTime"/>:</span>'+
                                '<input name="EDN_DATE" autocomplete="off" id="EDN_DATE" style="width: 280px;" class="text_boder test_null" placeholder="<fmt:message code="attend.th.EndDate"/>" type="text" value="'+endTime+'">' +
                                '<span style="color:red;font-size:14px ">*</span>' +
                                '</div>' +
                                '<div class="control-group" style="margin:-5px 0 10px 93px">' +
                                '<span class="TAKER" style="font-size:14px;top:-15px;margin-left: -1px;" class="ty"><fmt:message code="attend.th.Participant"/>:<br> <span style="font-size:8px;color:red;float:left">(<fmt:message code="calendar.th.onlyAbleToViewSchedule1" />)</span></span>'+
                                '<textarea name="TAKER_NAME1" id="TAKER_NAME1" class="BigStatic" wrap="yes" readonly="" style="height:54px;width: 276px;margin-left:26px;vertical-align: middle;border-radius:3px;" value="'+takeName+'"></textarea>' +
                                '<a href="javascript:;" id="takerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +
                                '<a href="javascript:;" id="takerOrgClear1" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                                '</div>' +
                                '<div class="control-group" style="margin-left:93px">' +
                                '<span class="TAKER ty" style="font-size:14px;top:0px;margin-left: -1px;"><fmt:message code="attend.th.Subordinate"/>:<br><span style="font-size:8px;color:red;float:left">(<fmt:message code="calendar.th.canViewAndEditTheSchedule1" />)</span></span>' +
                                '<textarea cols="35" value="'+ownerName+'" name="OWNER_NAME1" id="OWNER_NAME1" rows="2" class="BigStatic" wrap="yes" readonly="" style=" margin-left: 26px;height:30px; width: 276px;margin-top:24px;vertical-align:middle;border-radius:4px;"></textarea>' +
                                '<a href="javascript:;" id="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +
                                '<a href="javascript:;" id="ownerOrgClear1" onclick="clearOwnerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                                '</div>' +
                                '<div class="control-group" style="margin-left:70px;margin-top:10px">' +
                                '<span style="padding-left:30px;" class="ty"><fmt:message code="attend.th.Eventlevel"/>:</span>' +
                                '<select id="CAL_LEVEL" class="CAL_LEVEL text_boder" style="height: 29px;width: 283px;margin-left: 8px;margin-top:24px;">' +
                                '<option value="1"><fmt:message code="attend.th.Importanturgent"/></option>'+
                                '<option value="2"><fmt:message code="attend.th.ImportantNourgent"/></option>' +
                                '<option value="3"><fmt:message code="attend.th.NOImportanturgent"/></option>' +
                                '<option value="4"><fmt:message code="attend.th.NOImportantNOurgent"/></option>' +
                                '</select>' +
                                '</div>' +
                                '<div class="control-group" style="margin-left:70px;margin-top: 20px;">' +
                                '<span style="display:inline;padding-left:30px;margin-right: 10px;" class="ty"><fmt:message code="attend.th.Remindertime"/>:</span><fmt:message code="meet.th.Advance"/><input type="text" name="BEFORE_DAY" id="BEFORE_DAY" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="attend.th.today"/><input type="text" name="BEFORE_HOUR" id="BEFORE_HOUR" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="meet.th.hour"/><input type="text" name="BEFORE_MIN" id="BEFORE_MIN" size="3" class="input input-small" style="width:30px" value="10"><fmt:message code="attend.th.Minutesreminder"/>'+
                                '</div>' +
                                '<div class="control-group items"><span class="span_td tixing" style="margin-right:12px" class="ty"><fmt:message code="notice.th.reminder" />:</span><span><input type="checkbox" class="remind" checked="checked" style="width:16px;vertical-align: middle;"><fmt:message code="notice.th.remindermessage" />&nbsp;&nbsp;<input type="checkbox" class="smsRemind" style="width:16px;vertical-align: middle;"><fmt:message code="vote.th.UseRemind" /></span></div>\n'+
                                '</div>' +
                                '<div class="modal-footer"></div>' +
                                '</div>',
                                btn:['<fmt:message code="global.lang.save"/>','<fmt:message code="global.lang.close"/>','<fmt:message code="menuSSetting.th.deleteMenu"/>'],
                                success:function(layero, index){
                                    if(isOpenSanyuan) {
                                        $(".layui-layer-btn0").css("visibility","hidden")
                                    }
                                    if(!isCan) {
                                        $(".items").hide();
                                    }
                                    if(calEvent.edit==false){
                                        $('.layui-layer-btn0').hide()
                                        $('.layui-layer-btn2').hide()
                                        $('.control-group a').hide()
                                        $('#new_modal input').prop('disabled','disabled')
                                        $('#new_modal textarea').prop('disabled','disabled')
                                        $('#new_modal select').prop('disabled','disabled').css('background-color', 'rgb(235, 235, 228)')
                                    }else{
                                        $('.layui-layer-btn0').show()
                                        $('.layui-layer-btn2').show()
                                        $('.control-group a').show()
                                        $('#new_modal input').removeClass('disabled')
                                        $('#new_modal textarea').removeClass('disabled')
                                        $('#new_modal select').removeClass('disabled').css('background-color', '#fff');
                                        laydate.render({
                                            elem: '#START_DATE'
                                            ,type: 'datetime'
                                            ,trigger: 'click'
                                        });
                                        laydate.render({
                                            elem: '#EDN_DATE'
                                            ,type: 'datetime'
                                            ,trigger: 'click'
                                        });
                                    }
                                    $('#creator').prop('disabled','disabled').css('background-color','rgb(235, 235, 228)')
                                    var calTypeArray= $("#CAL_TYPE option")
                                    for(var i=0;i<calTypeArray.length;i++) {
                                        if (calTypeArray[i].value == cal_type) {
                                            $($("#CAL_TYPE  option")[i]).attr("selected", true)
                                        }
                                    }

                                    var calLevelArray= $("#CAL_LEVEL option")
                                    for(var i=0;i<calLevelArray.length;i++) {
                                        if (calLevelArray[i].value == cal_level) {
                                            $($("#CAL_LEVEL  option")[i]).attr("selected", true)
                                        }
                                    }
                                    $("#CAL_CONTENT").val(content);
                                    $("#TAKER_NAME1").val(takeName);
                                    $("#OWNER_NAME1").val(ownerName);
                                    $("#TAKER_NAME1").attr("user_id",takeIds);
                                    $("#OWNER_NAME1").attr("user_id",ownerIds);
                                    $("#takerOrgAdd1").on("click",function(){
                                        user_id='TAKER_NAME1';
                                        $.popWindow("../common/selectUser");
                                    });
                                    $("#ownerOrgAdd1").on("click",function(){
                                        user_id='OWNER_NAME1';
                                        $.popWindow("../common/selectUser");
                                    });
                                    $("#takerOrgClear1").on("click",function(){
                                        $("#TAKER_NAME1").val("");
                                        $("#TAKER_NAME1").attr('user_id','');
                                        $("#TAKER_NAME1").attr('username','');
                                        $("#TAKER_NAME1").attr('dataid','');
                                        $("#TAKER_NAME1").attr('userprivname','');
                                    })
                                    $("#ownerOrgClear1").on("click",function(){
                                        $("#OWNER_NAME1").val("");
                                        $("#OWNER_NAME1").attr('user_id','');
                                        $("#OWNER_NAME1").attr('username','');
                                        $("#OWNER_NAME1").attr('dataid','');
                                        $("#OWNER_NAME1").attr('userprivname','');
                                    })

                                    $('#BEFORE_DAY').val(beforeDay)
                                    $('#BEFORE_HOUR').val(beforeHour)
                                    $('#BEFORE_MIN').val(beforeMin)

                                    $.ajax({
                                        type:'get',
                                        url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                                        dataType:'json',
                                        success:function (res) {
                                            if(res.object.length!=0){
                                                var data=res.object[0]
                                                if (data.paraValue!=0){
                                                    isShowSecret2=true;
                                                    $('#transactionContent').after('<div style="margin-left: 118px;margin-top: 20px;" class="control-group">' +
                                                        '<span style="color:red;font-size:14px">*</span>'+
                                                        '<span>密级:</span>'+
                                                        '<select id="contentSecrecy2" style="height: 30px;width: 280px;margin-left: 15px;">' +
                                                        '<option id="first">请选择密级</option>'+
                                                        '</select>'+
                                                        '</div>')
                                                    $.ajax({
                                                        type: 'get',
                                                        url: '/code/getCode?parentNo=CONTENT_SECRECY',
                                                        dataType: 'json',
                                                        success: function (res) {
                                                            var str = ''
                                                            for (let i = 0; i < res.obj.length; i++) {
                                                                if (calEvent.contentSecrecy.indexOf(res.obj[i].codeNo) != -1) {
                                                                    str += '<option selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                                } else {
                                                                    str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                                }
                                                            }
                                                            $('#first').after(str)
                                                            //location.reload();
                                                        }
                                                    })

                                                }
                                            }
                                        }
                                    })

                                },
                                //编辑日程接口
                                yes: function(index, layero){
                                    //alert('html');
                                    //按钮【按钮三】的回调
                                    var array=$(".test_null");
                                    for(var i=0;i<array.length;i++){
                                        if(array[i].value==""){
                                            /*layer.tips("不能为空",".test_null", {
                                             area: ['100px', '30px']
                                             });*/
                                            $.layerMsg({content:"<fmt:message code="meet.th.AnAsterisk"/>",icon:3},function(){
                                            });
                                            return;
                                        }
                                    }
                                    if (isShowSecret2){
                                        if($('#contentSecrecy2').val()==''){
                                            layer.msg('请选择密级！',{icon:0});
                                            return;
                                        }
                                    }
                                    var start_time = parseISO8601($("#START_DATE").val());
                                    var end_time = parseISO8601($("#EDN_DATE").val());
                                    var calTime=Date.parse(new Date(start_time))/1000;
                                    var endTime=Date.parse(new Date(end_time))/1000;
                                    var calLevel=$("#CAL_LEVEL").val();
                                    var calType=$("#CAL_TYPE").val();
                                    var content=$("#CAL_CONTENT").val();
                                    var takerOrgAdd = $("#TAKER_NAME1").attr("user_id");
                                    var ownerOrgAdd = $("#OWNER_NAME1").attr("user_id");
                                    if(ownerOrgAdd.indexOf(userId)>-1){
                                        ownerOrgAdd=ownerOrgAdd
                                    }else{
                                        ownerOrgAdd=ownerOrgAdd+userId
                                    }
                                    var beforeDay=$("#BEFORE_DAY").val();
                                    var beforeHour=$("#BEFORE_HOUR").val();
                                    var beforeMin=$("#BEFORE_MIN").val();
                                    var contentSecrecy2=$('#contentSecrecy2').val()||'';
                                    var calId=calEvent.id;
                                    var data={
                                        calId:calId,
                                        calType:calType,
                                        content:content,
                                        calTime:calTime,
                                        endTime:endTime,
                                        userId:$.cookie('userId'),
                                        calLevel:calLevel,
                                        owner:ownerOrgAdd,
                                        taker:takerOrgAdd,
                                        beforeDay:beforeDay,
                                        beforeHour:beforeHour,
                                        beforeMin:beforeMin,
                                        contentSecrecy:contentSecrecy2,
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
                                    };


                                    $.ajax({
                                        url:"../../schedule/editCalender",
                                        type:"get",
                                        data:data,
                                        dataType:"json",
                                        success:function (){

                                            //alert('111');
//                                            $.ajax({
//                                                url:"../../schedule/getscheduleBycId",
//                                                type:"get",
//                                                dataType:"json",
//                                                data:data,
//                                                success:function (data){
//                                                    //alert("请求成功");
//                                                    var arrObject;
//                                                    for(var i=0;i<data.obj.length;i++){
//                                                        var arrObject = {
//                                                            title: data.obj[i].content,
//                                                            start: data.obj[i].stim,
//                                                            end: data.obj[i].etim,
//                                                            id:data.obj[i].calId
//                                                        };
//                                                        //console.log(arrObject);
//                                                        arr.push(arrObject);
//                                                        //console.log(arr);
//                                                    }
//                                                    return arr;
//                                                    location.reload();
//                                                }
//                                            });
                                            location.reload();
//                                            if($('.calendar').length > 0){
//
//                                                $('.calendar').fullCalendar({
//                                                    header: {
//                                                        left: 'prev,next,today',
//                                                        center: 'title',
//                                                        right: 'month,agendaWeek,agendaDay'
//                                                    },
//                                                    buttonText:{
//                                                        today:'跳转到当天'
//                                                    },
//                                                    editable: true,
//                                                    events:arr,
//                                                })
//                                            }

                                        }

                                    })

                                    //var layerIndex = layer.load(0, {shade: false});
                                    //layer.closeAll();

                                },
                                //删除日程接口
                                btn3:function(){
                                    $.layerConfirm({title:'<fmt:message code="menuSSetting.th.suredeleteMenu"/>',content:'<fmt:message code="workflow.th.que"/>',icon:0},function(){
                                        /* if(confirm("你确定要删除吗？")){
                                         //console.log();
                                         //var url='';*/
                                        var data={
                                            calId:calEvent.id
                                        };
                                        $.ajax({
                                            url:"../../schedule/delete",
                                            type:"post",
                                            data:data,
                                            dataType:"json",
                                            success:function (data){
                                                if (data.code == '100066'){
                                                    layer.msg('<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', {icon: 4});
                                                }else {
                                                    location.reload();
                                                }
                                            }

                                        })
                                        /* }else{
                                         return false;
                                         }*/
                                        //console.log(calEvent.id);
                                    })
                                }
                            });
                            //console.log("success");
                            //layer.closeAll();
                        },
                    });
                }
                //return arr;

            }
        })
    }

    //时间控件调用
    var start = {
        format: 'YYYY/MM/DD hh:mm:ss',
        /* min: laydate.now(), //设定最小日期为当前日期*/
        /* max: '2099-06-16 23:59:59', //最大日期*/
        istime: true,
        istoday: false,
        choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        format: 'YYYY/MM/DD hh:mm:ss',
        /*min: laydate.now(),*/
        /*max: '2099-06-16 23:59:59',*/
        istime: true,
        istoday: false,
        choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
</script>
</body>
</html>
