<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link rel="stylesheet" href="/lib/layDate-v5.0.9/laydate/theme/default/laydate.css">
    <link rel="stylesheet" type="text/css" href="/lib/fullcalendar/css/fullcalendar.css"/>
    <link rel="stylesheet" type="text/css" href="/lib/fullcalendar/css/fullcalendar.print.css"/>
    <link rel="stylesheet" type="text/css" href="/css/FullCalendar/style.css"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="/lib/pagination/style/pagination.css"/>
    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">
    <%--    <link rel="stylesheet" href="/lib/layui/layui/css/layui.css?20210319.1">--%>
    <script src="/lib/layDate-v5.0.9/laydate/laydate.js"></script>
    <%--    <script src="/lib/layui/layui/layui.js"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/common/language.js"></script>
    <script src="/lib/fullcalendar/moment.min.js" type="text/javascript" charset="utf-8"></script>
<%--    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>--%>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>--%>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/lib/fullcalendar/fullcalendar.min.js?20230324.5" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/fullcalendar/zh-cn.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/fullcalendar/jquery-ui.custom.min.js" type="text/javascript" charset="utf-8"></script>

    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <title><fmt:message code="calendar.th.leadershipSchedule" /></title>
    <style>

        .calhover .fc-border-separate td:hover {
            background-color: #CFE8FC !important;
        }

        .calendar .fc-agenda-slots .fc-widget-content:hover {
            background-color: #CFE8FC !important;
        }

        /*行大盒*/
        .control-group {
            margin-top: 6px;
            margin-left: 100px;
            height: 40px;
        }

        /*级别框*/
        .CAL_LEVEL {
            margin-left: 56px;
            height: 29px;
        }

        /*内容框*/
        .CAL_CONTENT {
            width: 274px;
            margin-left: 50px;
            height: 24px;;
            vertical-align: middle;
        }

        /*前四框*/
        .text_boder {
            border-radius: 3px;
            margin-left: 8px;
            position: relative;
            bottom: 0px;
        }

        #START_DATE, #EDN_DATE {
            width: 276px;
            height: 26px;
        }

        html {
            background: #fff;
        }

        body {
            margin: 0px;
            positon: relative;
        }

        .fc-header {
            background: #fff;
        }

        body {

            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        .container {
            backgrongd: #fff;
        }

        thead {
            background: #eee;
        }

        .fc-header tr {
            height: 30px;
        }

        .fc table {
            margin-bottom: 0px;
        }

        .fc-header-title h2 {
            margin-top: 0;
            white-space: nowrap;
            color: #404060;
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
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;

        }

        input, textarea, select, button, meter, progress {
            -webkit-writing-mode: horizontal-tb;
        }

        .fc-state-highlight {
            background-color: #beddff !important;
        }

        li {
            list-style: none;
        }

        .style_a {
            margin-left: 5px;
            margin-bottom: 5px;
            color: #1687cb;
            text-decoration: none;
            font-size: 13px;
        }

        .title {
            /*margin-left: 2%;*/
            padding-left: 27px;
            height: 45px;
            line-height: 50px;
            /*border-bottom:1px solid #ccc;*/
            font-size: 22px;
            color: rgb(73, 77, 89);
            font-family: Microsoft yahei,Helvetica Neue,Helvetica,PingFang SC,Tahoma,Arial,sans-serif;
        }

        .titName {
            display: inline-block;
        }

        .content .box {
            border: none;
        }

        .row-fluid {
            border-top: none;
            border-top-color: #ccc;
        }

        .colorClass a {
            display: inline-block;
            width: 16px;
            height: 16px;
            margin-left: 10px;
            vertical-align: middle;
        }

        .colorClass {
            color: #666;
            line-height: 21px;
            position: absolute;
            right: 27px;
            top: 13px;
        }

        .test_null {
            border: 1px solid #ccc !important;
        }

        /*.group_one {*/
        /*    margin-top: 40px;*/
        /*}*/

        #TAKER_NAME, #OWNER_NAME {
            margin-left: 26px !important;
        }

        .TAKER, .OWNER {
            display: inline-block;
            position: relative;
            top: -42px;
            left: 25px;
        }

        .typeone {
            display: inline-block;
            position: relative;
            /*top: -10px;*/
            top: 0px \0;
        }

        .input-small {
            border-radius: 3px;
        }

        .control-go {
            height: 60px;
            margin-top: 10px;
            margin-bottom: 20px;
            margin-left: 100px;
        }

        /*小导航栏*/
        .mintitle {
            width: 300px;
            height: 30px;
            padding: 10px 20px;
        }

        .mintitle:hover {
            cursor: pointer;
        }

        .mintitle .mintittab {
            display: inline-block;
            width: 100px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            border-radius: 5px;
        }

        .active {
            background: #eee;
        }

        .disnone {
            display: none;
        }

        .cycleWork {

            position: relative;
        }

        .cycleWork .search {
            padding-left: 33px;
            width: 100%;
            height: 50px;
            line-height: 50px;
        }

        .cycleWork .search input {

        }

        .mr {
            margin-right: 20px;
        }

        .submit {
            display: inline-block;
            width: 50px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            border-radius: 5px;
            background: #00A5E4;
            margin: 10px 0 0 20px;
            color: #ffffff;
        }

        .submit:hover {
            cursor: pointer;
        }

        table {
            border-collapse: collapse;
            width: 90%;
            margin: 10px auto;
        }

        th {
            text-align: center;
            background-color: #ffffff;
            padding: 8px;
            font-size: 12pt;
            color: #2F5C8F;
        }

        td {
            height: 30px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
            text-align: center;
            font-size: 11pt;
        }

        .conTh {
            width: 300px;
        }

        .newcyc {
            position: absolute;
            top: 10px;
            right: 3%;
            display: block;
            width: 100px;
            height: 30px;
            line-height: 30px;
            background: #f00;
            color: #fff;
            border-radius: 5px;
            text-align: center;

        }

        .newcyc:hover {
            cursor: pointer;
        }

        /*新建页面 样式*/
        .newCycleWork {
            width: 100%;

        }

        .innerbox {
            width: 50%;
            margin: 20px auto;
            font-size: 11pt;
        }

        .newTitle {
            color: #fff;
            height: 50px;
            line-height: 50px;
            margin: 0;
            padding: 0;
            font-size: 13pt;
            width: 100%;
            text-align: center;
            background: #00a5e0;

        }

        .con {
            margin: 20px auto;
            width: 100%;
            padding-left: 220px;
        }

        .leftTit {
            margin-right: 20px;
        }

        .rightTit {
            margin-left: 10px;
            font-size: 9pt;
            color: #999999;
        }

        .con1 {
            text-align: right;
            padding-left: 0;
        }

        .jump-ipt {
            width: 38px;
            height: 38px;
            line-height: 38px;
        }

        .newbtn {
            width: 60px;
            height: 30px;
            line-height: 30px;
            background: #00a5e0;
            border-radius: 5px;
            border: 1px solid #eee;
            text-align: center;
            margin-right: 20px;
        }

        #newcancel {
            background: #eee;
        }

        #remind {
            width: 16px;
            height: 16px;
        }

        input {
            width: 200px;
            height: 28px;
        }

        #edit, #deletebtn {
            /*color:#00a5e0;*/
            width: 40px;
            height: 30px;
        }

        .head-top {
            position: initial;
        }

        span {
            font-size: 11pt;
        }

        .divTable {
            width: 100%;
            table-layout: auto;
            margin: 0;
        }

        .divTable tr td {
            padding: 5px;
        }

        .divTable tr td:first-of-type {
            width: 120px;
            border-right: #ccc 1px solid;
        }

        .divTable tr td:last-of-type {
            text-align: left;
        }

        .divTable tr td textarea {
            width: 400px;
            height: 60px;
            min-width: 400px;
            min-height: 60px;
        }

        .divTable tr td select {
            width: 203px;
            height: 28px;
        }

        .btnarr a {
            padding: 5px 15px;
            color: #fff;
            border-radius: 4px;
            margin: 0 10px;
        }

        .divTable tr td input[type="checkbox"] {
            width: 16px;
            height: 16px;
        }

        .layerTable td {
            padding: 5px;
        }

        .layerTable td:first-of-type {
            width: 100px;
            text-align: right;
        }

        .layerTable td:last-of-type {
            text-align: left;
        }

        .condQuery {
            margin-top: 20px;
            padding-left: 40px;
        }

        .condQuery select {
            width: 130px;
            height: 28px;
            border-radius: 4px;
        }

        .queryData {
            background: url(/img/center_q.png) no-repeat;
            background-size: 74px;
            width: 74px;
            height: 29px;
            line-height: 30px;
            display: inline-block;
            padding-left: 30px;
            box-sizing: border-box;
            color: #000;
        }

        #calendar table tr {
            border: none;
        }

        .fc-day-header {
            font-weight: 700
        }

        .fc-day-number {
            font-weight: 700
        }

        .fc-event-title {
            margin-left: 5px;
        }

        #save {
            background: url(/img/vote/saveBlue.png) no-repeat;
            color: #fff;
            line-height: 30px;
            font-size: 16px;
            width: 76px;
            height: 30px;
            cursor: pointer;
            padding-left: 32px;
            border: none;
            margin: 0;
            outline-style: none;
            margin-right: 15px;
        }

        #refull, .refull {
            color: #000;
            width: 76px;
            line-height: 30px;
            height: 30px;
            cursor: pointer;
            font-size: 16px;
            background: url(/img/vote/new.png) no-repeat;
            padding-left: 30px;
            border: none;
            margin: 0;
            outline-style: none;
            margin-right: 15px;
        }

        /*.refull{*/
        /*    background: white;*/
        /*}*/
        .select select {
            height: 30px;
            border-radius: 3px;
        }


        /*.header .title{*/
        /*    width: 90%;*/
        /*    margin: 0 auto;*/
        /*    padding: 0;*/
        /*    display: flex;*/
        /*    justify-content: space-between;*/
        /*}*/
        * {
            font-family: "Microsoft Yahei" !important;
        }

        .header {
            margin-top: 15px;
            height: 40px;
        }

        /*.header .title{*/
        /*    margin-left: 22px;*/
        /*}*/
        .header span {
            float: none;
            /*margin-top: 9px;*/
            font-size: 22px;
            color: #333;
            display: inline-block;
            margin-left: 10px;
            vertical-align: middle;
            margin-top: -6px;
            font-size: 14px;
        }

        .content_label ul li {
            height: 16px;
            line-height: 16px;
            padding: 5px 12px;
            margin: 25px 0px;
            font-size: 15px;
            border-radius: 3px;
            display: inline;
        }

        .content_label ul {
            margin: 15px 0;
        }

        .pagediv table thead {
            background: white;
            line-height: 40px;
            border-bottom: 1px #dddddd solid;
            font-size: 13pt;
            color: #2F5C8F;
            font-weight: bold;
            height: 50px;
            border: 0px;
        }

        /*.pagediv,#pagediv{*/
        /*    height: 60vh!important;*/
        /*    position: relative;*/
        /*}*/
        /*#dbgz_page{*/
        /*    position: absolute;*/
        /*    bottom: 0px;*/
        /*}*/
        .pagediv tr:hover {
            background-color: #D3E7FA;
        }

        .pagediv tr:nth-child(odd) {
            background-color: #F6F7F9;
        }

        .pagediv tr:nth-child(odd) {
            background-color: #F6F7F9;
        }

        #pageTbody tr {
            height: 40px;
        }

        .index_content_1 .one {
            color: white;
            padding: 4px;
        }

        .index_content_2 .one {
            color: white;
            padding: 4px;
        }

        .one {
            width: 120px;
            height: 30px;
            border: none;
            color: #fff;
            cursor: pointer;
            padding: 5px;
            text-align: center;
        }

        .editAndDelete {
            color: red;
        }

        .page-bottom-inner-layer {
            height: 100% !important;
            width: 97px;
            overflow-x: inherit !important;
        }

        .page-bottom-inner-layer > table {
            margin: 0;
        }

        .page-top-outer-layer, .page-bottom-outer-layer, .page-bottom-inner-layer {
            width: 100% !important;
            text-align: center;
        }

        .page-top-inner-layer table {
            width: 100% !important;
        }

        thead tr th {
            text-align: center !important;
            /*border-right: groove !important;*/
        }

        .page-bottom-inner-layer table {
            width: 100% !important;
        }

        .pagediv .page-top-inner-layer {
            padding-right: 0;
        }

        #pageTbody td {
            text-align: center;
            /*border-right: groove;*/
        }

        .editAndDelete0 {
            color: #0a6aa1 !important;
        }

        .editAndDelete1 {
            color: red !important;
        }
        .no_notice{
            width: inherit !important;
        }

        /*.layui-layer-content{*/
        /*    height: 88% !important;*/
        /*}*/
        /*#layui-layer100003{*/
        /*    height: 520px !important;*/
        /*}*/
        /*#layui-layer100002{*/
        /*    height: 80% !important;*/
        /*}*/
        /*.layui-layer,.layui-layer-page,.layer-anim{*/
        /*    height: 88% !important;*/
        /*}*/
    </style>
</head>
<link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
<body>

<div class="title">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/dayli.png" alt=""
         style="vertical-align:middle;margin-bottom: 3px">
    <div class="titName" style="margin-left: 7px"><fmt:message code="calendar.th.leadershipSchedule" /></div>
</div>

<div class="head-top">
    <ul class="clearfix">
        <%--        领导日程查询--%>
        <li class="fl head-top-li active" id="myWork"><fmt:message code="calendar.th.leaderScheduleInquiry" /></li>

        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>

        <%--    领导日程设置--%>
        <li class="fl head-top-li" id="cycleWork" style="display: none"><fmt:message code="calendar.th.leadershipScheduleSetting" /></li>
    </ul>
</div>
<div class="container myWork ">
    <div class="select" style=" background: #fff;">
        <span class="layui-input-inline">
            <input type="text" class="layui-input" id="selectYear" placeholder="yyyy" style="margin-left:20px;width:96px;height: 31px;display: inline-block;margin-top: -4px;"  onchange="query()">
        </span>
        <select class="" id="selectWeek" style="height: 23px;line-height: 0px;margin-left: 20px; display:none;">
            <option value="1"><fmt:message code="workflow.th.First" />1<fmt:message code="task_config.week" /></option>
            <option value="2"><fmt:message code="workflow.th.First" />2<fmt:message code="task_config.week" /></option>
            <option value="3"><fmt:message code="workflow.th.First" />3<fmt:message code="task_config.week" /></option>
            <option value="4"><fmt:message code="workflow.th.First" />4<fmt:message code="task_config.week" /></option>
            <option value="5"><fmt:message code="workflow.th.First" />5<fmt:message code="task_config.week" /></option>
            <option value="6"><fmt:message code="workflow.th.First" />6<fmt:message code="task_config.week" /></option>
            <option value="7"><fmt:message code="workflow.th.First" />7<fmt:message code="task_config.week" /></option>
            <option value="8"><fmt:message code="workflow.th.First" />8<fmt:message code="task_config.week" /></option>
            <option value="9"><fmt:message code="workflow.th.First" />9<fmt:message code="task_config.week" /></option>
            <option value="10"><fmt:message code="workflow.th.First" />10<fmt:message code="task_config.week" /></option>
            <option value="11"><fmt:message code="workflow.th.First" />11<fmt:message code="task_config.week" /></option>
            <option value="12"><fmt:message code="workflow.th.First" />12<fmt:message code="task_config.week" /></option>
            <option value="13"><fmt:message code="workflow.th.First" />13<fmt:message code="task_config.week" /></option>
            <option value="14"><fmt:message code="workflow.th.First" />14<fmt:message code="task_config.week" /></option>
            <option value="15"><fmt:message code="workflow.th.First" />15<fmt:message code="task_config.week" /></option>
            <option value="16"><fmt:message code="workflow.th.First" />16<fmt:message code="task_config.week" /></option>
            <option value="17"><fmt:message code="workflow.th.First" />17<fmt:message code="task_config.week" /></option>
            <option value="18"><fmt:message code="workflow.th.First" />18<fmt:message code="task_config.week" /></option>
            <option value="19"><fmt:message code="workflow.th.First" />19<fmt:message code="task_config.week" /></option>
            <option value="20"><fmt:message code="workflow.th.First" />20<fmt:message code="task_config.week" /></option>
            <option value="21"><fmt:message code="workflow.th.First" />21<fmt:message code="task_config.week" /></option>
            <option value="22"><fmt:message code="workflow.th.First" />22<fmt:message code="task_config.week" /></option>
            <option value="23"><fmt:message code="workflow.th.First" />23<fmt:message code="task_config.week" /></option>
            <option value="24"><fmt:message code="workflow.th.First" />24<fmt:message code="task_config.week" /></option>
            <option value="25"><fmt:message code="workflow.th.First" />25<fmt:message code="task_config.week" /></option>
            <option value="26"><fmt:message code="workflow.th.First" />26<fmt:message code="task_config.week" /></option>
            <option value="27"><fmt:message code="workflow.th.First" />27<fmt:message code="task_config.week" /></option>
            <option value="28"><fmt:message code="workflow.th.First" />28<fmt:message code="task_config.week" /></option>
            <option value="29"><fmt:message code="workflow.th.First" />29<fmt:message code="task_config.week" /></option>
            <option value="30"><fmt:message code="workflow.th.First" />30<fmt:message code="task_config.week" /></option>
            <option value="31"><fmt:message code="workflow.th.First" />31<fmt:message code="task_config.week" /></option>
            <option value="32"><fmt:message code="workflow.th.First" />32<fmt:message code="task_config.week" /></option>
            <option value="33"><fmt:message code="workflow.th.First" />33<fmt:message code="task_config.week" /></option>
            <option value="34"><fmt:message code="workflow.th.First" />34<fmt:message code="task_config.week" /></option>
            <option value="35"><fmt:message code="workflow.th.First" />35<fmt:message code="task_config.week" /></option>
            <option value="36"><fmt:message code="workflow.th.First" />36<fmt:message code="task_config.week" /></option>
            <option value="37"><fmt:message code="workflow.th.First" />37<fmt:message code="task_config.week" /></option>
            <option value="38"><fmt:message code="workflow.th.First" />38<fmt:message code="task_config.week" /></option>
            <option value="39"><fmt:message code="workflow.th.First" />39<fmt:message code="task_config.week" /></option>
            <option value="40"><fmt:message code="workflow.th.First" />40<fmt:message code="task_config.week" /></option>
            <option value="41"><fmt:message code="workflow.th.First" />41<fmt:message code="task_config.week" /></option>
            <option value="42"><fmt:message code="workflow.th.First" />42<fmt:message code="task_config.week" /></option>
            <option value="43"><fmt:message code="workflow.th.First" />43<fmt:message code="task_config.week" /></option>
            <option value="44"><fmt:message code="workflow.th.First" />44<fmt:message code="task_config.week" /></option>
            <option value="45"><fmt:message code="workflow.th.First" />45<fmt:message code="task_config.week" /></option>
            <option value="46"><fmt:message code="workflow.th.First" />46<fmt:message code="task_config.week" /></option>
            <option value="47"><fmt:message code="workflow.th.First" />47<fmt:message code="task_config.week" /></option>
            <option value="48"><fmt:message code="workflow.th.First" />48<fmt:message code="task_config.week" /></option>
            <option value="49"><fmt:message code="workflow.th.First" />49<fmt:message code="task_config.week" /></option>
            <option value="50"><fmt:message code="workflow.th.First" />50<fmt:message code="task_config.week" /></option>
            <option value="51"><fmt:message code="workflow.th.First" />51<fmt:message code="task_config.week" /></option>
            <option value="52"><fmt:message code="workflow.th.First" />52<fmt:message code="task_config.week" /></option>
            <option value="53"><fmt:message code="workflow.th.First" />53<fmt:message code="task_config.week" /></option>
        </select>
        <select class="" id="selectMonth" style="width:64px;" onchange="query()">
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
        <select class="" id="selectDay" style="display:none;">
        </select>
        <select name="USER_ID" id="selUser_id" style="width:130px;height: 30px;margin-right: 16px;margin-top:17px;"
                onchange="query()">
        </select>
        <span id="IsEdit" IsEdit="false"></span>
    </div>
    <div class="content" style="padding: 0px 20px 100px 20px;">
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

<div class="container cycleWork head" style="display:none; margin-left: 10px;">

    <%--领导日程设置页面初始化--%>
    <div class="chushihua">
        <div class="header">
            <div class="title">
                <img src="/img/commonTheme/${sessionScope.InterfaceModel}/flow_run_title.png">
                <span style="font-size: 22px"><fmt:message code="calendar.th.leadershipScheduleSetting" /></span>
                <button type="button" class="one" id="add_btn" style="width: 120px; float:right;margin-right: 2%;margin-top: 15px; font-size: 14px;height: 35px;    text-align: center; line-height: 35px;">
                    <img src="/img/mywork/newbuildworjk1.png" style="margin-bottom: 11px; margin-right: -6px;"/>
                    <span style="color: white;margin-bottom: 5px;"><fmt:message code="global.lang.new" /></span>
                </button>
            </div>
            <div id="pagediv" style="overflow-x: auto;">
                <%--                <table id="demo" lay-filter="test">position: absolute;right: 2%;float: right; </table>--%>

            </div>
        </div>
    </div>

    <table class="newNews">
        <tbody>
        <tr>
            <td class="blue_text">
                <span style="color: red;font-size: 20px;position: relative;top: 6px">*</span>
                <fmt:message code="calendar.th.leader" />:

            </td>
            <td>
                <textarea name="" id="lead" user_id="" style="width: 400px;height: 80px" disabled></textarea>
                <a href="javascript:;" id="lead_pop" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
                <a href="javascript:;" class="clearTwo" style="color:red" onclick="lead_pop()"><fmt:message
                        code="global.lang.empty"/></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="calendar.th.authorizedInquirers" />:
            </td>
            <td>
                <textarea name="" id="delete" user_id="" style="width: 400px;height: 80px" disabled></textarea>
                <a href="javascript:;" id="delete_pop" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
                <a href="javascript:;" class="clearTwo" style="color:red" onclick="delete_pop()"><fmt:message
                        code="global.lang.empty"/></a>
            </td>
        </tr>
        <tr>
            <td class="blue_text">
                <fmt:message code="calendar.th.authorizedEditors" />:
            </td>
            <td>
                <textarea name="" id="edit" user_id="" style="width: 400px;height: 80px" disabled></textarea>
                <a href="javascript:;" id="edit_pop" style="color:#1772c0"><fmt:message code="global.lang.add"/></a>
                <a href="javascript:;" class="clearTwo" style="color:red" onclick="edit_pop()"><fmt:message
                        code="global.lang.empty"/></a>
            </td>
        </tr>
        </tbody>
        <div>
            <tr style="text-align:center">
                <td colspan="2">
                    <button type="button" class="close_but" id="save"><fmt:message code="global.lang.save"/></button>
                    <button type="button" class="close_but" id="refull" onclick="clearAll()"><fmt:message code="global.lang.refillings"/></button>
                    <button type="button" class="refull returnF"><fmt:message code="notice.th.return" /></button>
                </td>
            </tr>
        </div>
    </table>
</div>
</div>

<%--领导日程设置页签--%>
<script>
    var arr = [];
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
    <%--    判断当前登录人是否是admin--%>
    $.ajax({
        type: 'get',
        dataType: 'json',
        url: '/Meetequipment/getuser',
        success: function (res) {
            var data = res.object
            if (data.userId == 'admin') {
                $('#cycleWork').css('display', 'block')
            }

        }

    })
    //判断是否开启事务提醒
    var isCan = true;
    $.ajax({
        type:'get',
        url:'/smsRemind/getRemindFlag',
        dataType:'json',
        data: {type:'5'},
        success:function(res){
            var data = res.obj[0];
            if(data.isCan == 0) {
                isCan = false;
            }
        }
    });
    $(function reloads() {
        var screenwidth = document.documentElement.clientWidth;
        // console.log(screenwidth*0.9)
        if (screenwidth > 2200) {
            var nums = screenwidth * 0.90;
            var sumwidth = screenwidth * 0.90 + 'px';
        } else {
            var nums = 1000;
            var sumwidth = '1000px';
        }
        var width1 = nums * 0.040 + '%';
        var width2 = nums * 0.040 + '%';
        var width3 = nums * 0.020 + '%';
        //表格数据初始化展示
        var pageObj = $.tablePage('#pagediv', sumwidth, [
            {
                width: width1,
                title: '<fmt:message code="calendar.th.leader" />',
                name: 'managerUserName',
                selectFun: function (n, obj) {
                    // console.log(obj)
                    // return obj.managerNames;
                    if (obj.managerNames == undefined) {
                        return "";
                    } else {
                        return obj.managerNames;
                        // return obj.managers;
                    }
                }
            },
            {
                width: width2,
                title: '<fmt:message code="calendar.th.authorizedInquirers" />',
                name: 'salesUserName',
                selectFun: function (n, obj) {
                    // return obj.queryPrivNames;
                    // console.log(obj.queryPrivNames==undefined)
                    if (obj.queryPrivNames == undefined) {
                        return "";
                    } else {
                        return obj.queryPrivNames;
                    }
                }
            },
            {
                width: width2,
                title: '<fmt:message code="calendar.th.authorizedEditors" />',
                name: 'salesUserName',
                selectFun: function (n, obj) {
                    // return obj.editPrivNames;
                    // console.log(obj.editPrivNames!=undefined)
                    if (obj.editPrivNames == undefined) {
                        return "";
                    } else {
                        return obj.editPrivNames;
                    }
                }
            },
            {
                width: width3,
                title: '<fmt:message code="notice.th.operation" />',
                name: 'orgAddress'
            }
        ], function (me) {
            var jumpipt = $('.jump-ipt').val();
            me.data.pageSize = 8;
            me.init('/calendarPriv/selAllCalendarPriv', [
                {name: '<fmt:message code="global.lang.edit" />'},
                {name: '<fmt:message code="global.lang.delete" />'}
            ])
        })

        // 返回
        $('.returnF').on('click',function () {
            $('.chushihua').css('display', 'block')
            $('.newNews').css('display', 'none')
        })
        //点击新建
        $('.newNews').css('display', 'none')
        $('#add_btn').on('click',function () {
            $('#save').attr('typeId', 1)
            // console.log("ds")
            $('.chushihua').css('display', 'none')
            $('.newNews').css('display', 'inline-table')
            var num = $('#save').attr('typeid')

            $('#lead').val('')
            $('#delete').val('')
            $('#edit').val('')

            // console.log(num)
            if (num == 1) {
                $('#save').on('click',function () {
                    console.log($('#lead').attr('user_id') == '')
                    if ($('#lead').val() != '' && $('#lead').attr('user_id') != '') {
                        $.ajax({
                            url: '/calendarPriv/saveCalendarPriv',
                            type: 'post',
                            dataType: 'json',
                            data: {
                                managers: $('#lead').attr('user_id'),
                                queryPrivUsers: $('#delete').attr('user_id'),
                                editPrivUsers: $('#edit').attr('user_id')
                            },
                            success: function (data) {
                                var data1 = data.object
                               $('.chushihua').css('display', 'block')
                                $('.newNews').css('display', 'none')
                                //不刷新文档  改用刷新表格形式
                               /* location.reload();*/
                                reloads();
                            }
                        }), function () {
                             layer.closeAll();
                        }
                    } else {
                        layer.msg('<fmt:message code="calendar.th.pleaseSelectALeader" />', {icon: 2});/*添加失败*/
                    }
                })

            }


        })

        //点击删除数据
        $('#pageTbody').on('click', '.editAndDelete1', function () {
            console.log(pageObj.arrs[$(this).attr('data-i')].privId)
            var privId = pageObj.arrs[$(this).attr('data-i')].privId
            layer.confirm(qued, {
                btn: [sure, cancel], //按钮
                title: '<fmt:message code="workflow.th.suredel" />'
            }, function () {
                $.ajax({
                    type: 'post',
                    url: '/calendarPriv/delCalendarPriv',
                    dataType: 'json',
                    data: {
                        privId: privId,
                    },
                    success: function (json) {
                        // console.log(pageObj.arrs[$(this).attr('data-i')])
                        console.log(json)
                        //第三方扩展皮肤
                        layer.msg('<fmt:message code="workflow.th.delsucess" />', {icon: 6});
                     /*   location.reload();*/
                        reloads();
                    }
                })
            }, function () {
                layer.closeAll();
            }
            )
        });

        //点击修改
        $('#pageTbody').on('click', '.editAndDelete0', function () {
            $('#save').attr('typeId', 2)
            // console.log(pageObj.arrs[$(this).attr('data-i')].privId)
            var privId = pageObj.arrs[$(this).attr('data-i')].privId
            $.ajax({
                type: 'post',
                url: '/calendarPriv/findCalendarPriv',
                dataType: 'json',
                data: {
                    privId: privId,
                },
                success: function (res) {
                    var data = res.object
                    console.log(data)
                    $('.newNews').css('display', 'inline-table')
                    $('.chushihua').css('display', 'none')
                    $('#lead').val(data.managerNames)
                    $('#delete').val(data.queryPrivNames)
                    $('#edit').val(data.editPrivNames)

                    $('#lead').attr('user_id', data.managers)
                    $('#delete').attr('user_id', data.queryPrivUsers)
                    $('#edit').attr('user_id', data.editPrivUsers)

                    console.log($('#save').attr('typeId'))
                    //修改保存
                    if ($('#save').attr('typeid') == 2) {
                        $('#save').on('click',function () {
                            console.log(privId)
                            if ($('#lead').val() != '' && $('#lead').attr('user_id') != '') {
                                $.ajax({
                                    url: '/calendarPriv/editCalendarPriv',
                                    type: 'post',
                                    dataType: 'json',
                                    data: {
                                        privId: privId,
                                        managers: $('#lead').attr('user_id'),
                                        queryPrivUsers: $('#delete').attr('user_id'),
                                        editPrivUsers: $('#edit').attr('user_id')
                                    },
                                    success: function (data) {
                                        console.log(data)
                                        $('.chushihua').css('display', 'block')
                                        $('.newNews').css('display', 'none')
                                      /*  location.reload();*/
                                        reloads();
                                    }
                                }), function () {
                                    layer.closeAll();
                                }
                            } else {
                                layer.msg('<fmt:message code="calendar.th.pleaseSelectALeader" />', {icon: 2});/*添加失败*/
                            }
                        })
                    }

                }
            })
        })


    });

    $("#delete_pop").on("click", function () {//选人员控件
        user_id = 'delete';
        $.popWindow("/common/selectUser");
    });
    $("#lead_pop").on("click", function () {//选人员控件
        user_id = 'lead';
        $.popWindow("/common/selectUser");
    });
    $("#edit_pop").on("click", function () {//选人员控件
        user_id = 'edit';
        $.popWindow("/common/selectUser");
    });

    function lead_pop() {
        $('#lead').removeAttr('user_id');
        $('#lead').removeAttr('user_id');
        $('#lead').attr('user_id', '');
        $('#lead').val('');
    }

    function delete_pop() {
        $('#delete').removeAttr('user_id');
        $('#delete').removeAttr('user_id');
        $('#delete').attr('user_id', '');
        $('#delete').val('');

    }

    function edit_pop() {
        $('#edit').removeAttr('user_id');
        $('#edit').removeAttr('user_id');
        $('#edit').attr('user_id', '');
        $('#edit').val('');
    }

    //清空所有内容
    function clearAll() {
        lead_pop();
        delete_pop();
        edit_pop();
    }

    function clearOwnerName() {
        //console.log(id);
        $("#OWNER_NAME").val('');
        $("#OWNER_NAME").attr("user_id", '');
        $("#OWNER_NAME").attr("username", '');
        $("#OWNER_NAME").attr("dataid", '');
        $("#OWNER_NAME").attr("userprivname", '');

    }

    //年选择器
    laydate.render({
        elem: '#selectYear'
        , type: 'year'
    });
    $('#selectYear').val(new Date().getFullYear())
    // })


</script>


<script type="text/javascript">

    var user_id = '';
    laydate.render({
        elem: '#beginTimeTime'
        , type: 'time'
    });
    laydate.render({
        elem: '#newEndDate'
    });
    laydate.render({
        elem: '#newBeginDate'
    });
    laydate.render({
        elem: '#beginTime'
    });
    laydate.render({
        elem: '#endTime'
    });
    laydate.render({
        elem: '#endTimeTime'
        , type: 'time'
    });
    laydate.render({
        elem: '#remindTime'
        , type: 'time'
    });
    laydate.render({
        elem: '#remindTime_1'
        , type: 'time'
    });
    laydate.render({
        elem: '#remindTime_2'
        , type: 'time'
    });
    laydate.render({
        elem: '#remindTime_3'
        , type: 'time'
    });
    laydate.render({
        elem: '#remindTime_4'
        , type: 'time'
    });
    $('#newBeginDate').val(getNowFormatDate());

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
    //领导查询下拉框
    $(function () {
        // 领导日程查询 下拉框
        $.ajax({
            url: '/calendarPriv/getLeader',
            type: 'post',
            dataType: 'json',
            success: function (res) {
                var obj = res.object
                var str = ''
                var arr1 = [];

                var arr = [];
                for (let i in obj) {
                    //arr.push(obj[i]); //属性
                    //arr.push(obj[i]); //值
                    var o = {};
                    o[i] = obj[i];
                    arr.push(o);
                    str += '<option value="' + [i] + '"  userId="' + [i] + '">' + obj[i] + '</option>'
                }
                $('#selUser_id').append(str)

                canlandData()
            }
        })


        // 查询提醒权限
        $.ajax({
            type: 'get',
            url: '/smsRemind/getRemindFlag',
            dataType: 'json',
            data: {
                type: 5
            },
            success: function (res) {
                if (res.flag) {
                    if (res.obj.length > 0) {
                        var data = res.obj[0];
                        // 是否默认发送
                        if (data.isRemind == '0') {
                            $('.remind').prop("checked", false);
                        } else if (data.isRemind == '1') {
                            $('.remind').prop("checked", true);
                        }
                        // 是否手机短信默认提醒
                        if (data.isIphone == '0') {
                            $('.smsRemind').prop("checked", false);
                        } else if (data.isIphone == '1') {
                            $('.smsRemind').prop("checked", true);
                        }
                        // 是否允许发送事务提醒
                        if (data.isCan == '0') {
                            $('.remind').prop("checked", false);
                            $('.smsRemind').prop("checked", false);
                            $('.items').hide();
                        }

                    }
                }
            }
        })
    })

    $('#addUser').on('click',function () {
        user_id = 'textUser';
        $.popWindow("/common/selectUser");
    })
    $('#clearUser').on('click',function () {
        $('#textUser').val('');
        $('#textUser').attr('username', '');
        $('#textUser').attr('dataid', '');
        $('#textUser').attr('user_id', '');
        $('#textUser').attr('userprivname', '');
    })
    $('input[name="smsRemind"]').on('click',function () {
        var state = $(this).prop('checked');
        if (state == true) {
            $(this).prop("checked", true);
            $(this).val('1');
        } else {
            $(this).prop("checked", false);
            $(this).val('0');
        }
    })

    //点击我的日程
    $('#myWork').on('click', function () {
        $('#myWork').addClass('active').siblings().removeClass('active');
        $('.myWork').removeClass('disnone');
        $('.cycleWork').addClass('disnone')
        $('.queryWork').hide();
    })

    //点击日程设置
    $('#cycleWork').on('click', function () {
        $('#cycleWork').addClass('active').siblings().removeClass('active');
        $('.cycleWork').removeClass('disnone');
        $('.myWork').addClass('disnone');
        $('.queryWork').hide();
        $('.cycleWork ').show();
    })

    //    改变重复类型
    $('#repeatType').on('change',function () {
        var index = $(this).find('option:selected').index();
        $('#showHide').find('div').eq(index).show().siblings().hide();
    })

    //确认新建事务
    $('#saveNew').on('click',function () {
        var saveType = $(this).attr('data-type');
        var remindDate = '';
        var remindTime = '';
        if ($('#contant').val() == '') {
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheTaskDetails" />！', {icon: 0});
            return;
        }
        if ($('#beginTimeTime').val() == '') {
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheStartTime" />！', {icon: 0});
            return;
        }
        if ($('#endTimeTime').val() == '') {
            layer.msg('<fmt:message code="calendar.th.pleaseFillInTheEndTime" />！', {icon: 0});
            return;
        }
        if ($('#repeatType option:selected').val() == '2') {
            remindTime = $('#remindTime').val();
            remindDate = '';
        } else if ($('#repeatType option:selected').val() == '3') {
            remindDate = $('#week option:selected').val();
            remindTime = $('#remindTime_1').val();
        } else if ($('#repeatType option:selected').val() == '4') {
            remindDate = $('#today option:selected').val();
            remindTime = $('#remindTime_2').val();
        } else if ($('#repeatType option:selected').val() == '5') {
            remindDate = $('#mouthDate option:selected').val() + '-' + $('#today_1 option:selected').val();
            remindTime = $('#remindTime_3').val();
        } else {
            remindTime = $('#remindTime_4').val();
            remindDate = '';
        }
        if (saveType == '0') {
            $.ajax({
                type: 'post',
                url: '/Affair/insertAffair',
                dataType: 'json',
                data: {
                    beginTimes: $('input[name="beginTime"]').val(),
                    endTimes: $('input[name="endTime"]').val(),
                    beginTimeTime: $('input[name="beginTimeTime"]').val(),
                    endTimeTime: $('input[name="endTimeTime"]').val(),
                    calType: $('#calType option:selected').val(),
                    type: $('#repeatType option:selected').val(),
                    remindDate: remindDate,
                    remindTime: remindTime,
                    content: $('#contant').val(),
                    taker: $('#textUser').attr('user_id'),
                    smsRemind: $('input[name="smsRemind"]').val()
                },
                success: function (res) {
                    if (res.flag) {
                        layer.msg('<fmt:message code="diary.th.modify" />！', {icon: 1})
                        initData(zhouData);
                        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
                        $('input[name="beginTime"]').val('')
                        $('input[name="endTime"]').val('')
                        $('input[name="beginTimeTime"]').val('')
                        $('#contant').val('')
                        $('#textUser').val('');
                        $('#textUser').attr('username', '');
                        $('#textUser').attr('dataid', '');
                        $('#textUser').attr('user_id', '');
                        $('#textUser').attr('userprivname', '');
                    } else {
                        layer.msg('<fmt:message code="meet.th.SaveFailed" />！', {icon: 2})
                    }
                }
            })
        } else {
            var edTypeId = $('input[name="editType"]').val();
            $.ajax({
                type: 'post',
                url: '/Affair/updateAffair',
                dataType: 'json',
                data: {
                    affId: edTypeId,
                    beginTimes: $('input[name="beginTime"]').val(),
                    endTimes: $('input[name="endTime"]').val(),
                    beginTimeTime: $('input[name="beginTimeTime"]').val(),
                    endTimeTime: $('input[name="endTimeTime"]').val(),
                    calType: $('#calType option:selected').val(),
                    type: $('#repeatType option:selected').val(),
                    remindTime: $('input[name="remindTime"]').val(),
                    content: $('#contant').val(),
                    taker: $('#textUser').attr('user_id'),
                    smsRemind: $('input[name="smsRemind"]').val()
                },
                success: function (res) {
                    if (res.flag) {
                        layer.msg('<fmt:message code="depatement.th.Modifysuccessfully" />！', {icon: 1})
                        initData(zhouData);
                        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
                        $('input[name="beginTime"]').val('')
                        $('input[name="endTime"]').val('')
                        $('input[name="beginTimeTime"]').val('')
                        $('#contant').val('')
                        $('#textUser').val('');
                        $('#textUser').attr('username', '');
                        $('#textUser').attr('dataid', '');
                        $('#textUser').attr('user_id', '');
                        $('#textUser').attr('userprivname', '');
                    } else {
                        layer.msg('<fmt:message code="depatement.th.modifyfailed" />！', {icon: 2});
                    }
                }
            })
        }

    })

    //返回
    $('#backPrev').on('click',function () {
        $('.newCycleWork').addClass('disnone').siblings().removeClass('disnone');
        $('input[name="beginTime"]').val('')
        $('input[name="endTime"]').val('')
        $('input[name="beginTimeTime"]').val('')
        $('#contant').val('')
        $('#textUser').val('');
        $('#textUser').attr('username', '');
        $('#textUser').attr('dataid', '');
        $('#textUser').attr('user_id', '');
        $('#textUser').attr('userprivname', '');
    })

    function xiangqingData(that) {
        var dataId = that.attr('data-id');
        $.ajax({
            type: 'get',
            url: '/Affair/selectAffair',
            dataType: 'json',
            data: {
                affId: dataId
            },
            success: function (res) {
                var datas = res.obj;
                layer.open({
                    type: 1,
                    /* skin: 'layui-layer-rim', //加上边框 */
//                    offset: '80px',
                    area: ['500px', '260px'], //宽高
                    title: "<fmt:message code="file.th.detail"/>",
                    content: '<table class="layerTable" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">' +
                        '<tr>' +
                        '<td><fmt:message code="attend.th.Remindertime"/>：</td>' +
                        '<td>' + datas[0].remindTime + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="creator"/>：</td>' +
                        '<td>' + undefindData(datas[0].userName) + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="attend.th.Participant"/>：</td>' +
                        '<td title="' + undefindData(datas[0].takerName) + '">' + undefindData(datas[0].takerName) + '</td>' +
                        '</tr>' +
                        '<tr>' +
                        '<td><fmt:message code="attend.th.Contentofthings"/>：</td>' +
                        '<td title="' + undefindData(datas[0].content) + '">' + undefindData(datas[0].content) + '</td>' +
                        '</tr>' +
                        '</table>',
                })
            }
        })

    }

    //************************************************************编号设置*******************************************************



    function parseISO8601(dateStringInRange) {
        var year = dateStringInRange.split('-')[0];
        var month = dateStringInRange.split('-')[1];
        var day = dateStringInRange.split('-')[2];

        var date = year + '/' + month + '/' + day;
        //console.log(date);
        return date;
    }

    function clearTakerName() {
        //console.log(id);
        $("#TAKER_NAME").val('');
        $("#TAKER_NAME").attr("user_id", '');
        $("#TAKER_NAME").attr("username", '');
        $("#TAKER_NAME").attr("dataid", '');
        $("#TAKER_NAME").attr("userprivname", '');

    }

    function getLocalTime(nS) {
//        console.log(nS)
        return new Date(parseInt(nS) * 1000).toLocaleString().replace(/:\d{1,2}$/, ' ');
    }

    var arr = [];
    var searchArr = [];
    var date = new Date();
    var d = date.getDate();
    var m = date.getMonth();
    var y = date.getFullYear();
    var timestamp = Date.parse(new Date());
    var timestamp = timestamp / 1000;
    var userName = '', userId = '';
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
    $(function () {

        $.ajax({
            url: '/Meetequipment/getuser',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                userName = res.object.userName
                userId = res.object.userId
            }
        })
    })

    //初始化下拉列表日
    function initselDay() {//获取本月的天数
        var month = parseInt(m + 1, 10);
        var d = new Date(y, month, 0);
        var monthArray = $("#selectDay option");
        var dayOpt;
        for (var i = 0; i < d.getDate(); i++) {
            dayOpt += '<option value=' + (i + 1) + '>' + (i + 1) + "<fmt:message code="global.lang.day"/>" + '</option>';
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


    $(document).ready(function () {
        //alert("加载开始1");
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var timestamp = Date.parse(new Date());
        var timestamp = timestamp / 1000;
    });


    var userName = '', userId = '';

    function canlandData() {
        if ($('#calendar').length > 0) {
            var timestamp = Date.parse(new Date());
            var timer = parseInt(timestamp) + 3600000;
            var startTime = new Date(timestamp).Format('hh:mm:ss');
            var endTime = new Date(timer).Format('hh:mm:ss');

            $('#START_DATE').val(startTime);
            $('#EDN_DATE').val(endTime)
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next,today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'

                },
                buttonText: {
                    today: '<fmt:message code="attend.th.Jumptoday"/>'
                },
                editable: true,
                timeFormat: 'HH:mm    ',//时间格式
                events: function (start, end, timezone, callback) {
                    arr.splice(0, arr.length);//清空数组

                    $('#calendar').fullCalendar('removeEventSource', arr);
                    $.ajax({
                        url: "/schedule/getLeaderSchedule",
                        type: "get",
                        dataType: "json",
                        data: {
                            userId: $('#selUser_id').val()
                        },
                        success: function (data) {
                            //判断是否有  增删改 权限
                            if(data.flag && data.obj.length > 0 ){
                                $('#IsEdit').attr('IsEdit',data.obj[0].edit);
                            }
                            var arrObject;
                            for (var i = 0; i < data.obj.length; i++) {
                                if (data.obj[i].calLevel == 1) {
                                    var arrObject = {
                                        title: data.obj[i].content,
                                        start: data.obj[i].stim,
                                        end: data.obj[i].etim,
                                        contentSecrecy:data.obj[i].contentSecrecy,
                                        id: data.obj[i].calId,
                                        calLevel: data.obj[i].calLevel,
                                        calType: data.obj[i].calType,
                                        takeIds: data.obj[i].taker,
                                        takeName: data.obj[i].takeName,
                                        ownerIds: data.obj[i].owner,
                                        ownerName: data.obj[i].ownerName,
                                        color: "#ff5757",
                                        backgroundColor: "#ff5757",
                                        // beforeDay: data.obj[i].beforeDay,
                                        // beforeHour: data.obj[i].beforeHour,
                                        // beforeMin: data.obj[i].beforeMin,
                                        // beforeRemaind: data.obj[i].beforeRemaind,
                                        edit: data.obj[i].edit
                                    };
                                } else if (data.obj[i].calLevel == 2) {
                                    var arrObject = {
                                        title: data.obj[i].content,
                                        start: data.obj[i].stim,
                                        end: data.obj[i].etim,
                                        contentSecrecy:data.obj[i].contentSecrecy,
                                        id: data.obj[i].calId,
                                        calLevel: data.obj[i].calLevel,
                                        calType: data.obj[i].calType,
                                        takeIds: data.obj[i].taker,
                                        takeName: data.obj[i].takeName,
                                        ownerIds: data.obj[i].owner,
                                        ownerName: data.obj[i].ownerName,
                                        color: "#ff9540",
                                        backgroundColor: "#ff9540",
                                        // beforeDay: data.obj[i].beforeDay,
                                        // beforeHour: data.obj[i].beforeHour,
                                        // beforeMin: data.obj[i].beforeMin,
                                        // beforeRemaind: data.obj[i].beforeRemaind,
                                        edit: data.obj[i].edit
                                    };
                                } else if (data.obj[i].calLevel == 3) {
                                    var arrObject = {
                                        title: data.obj[i].content,
                                        start: data.obj[i].stim,
                                        end: data.obj[i].etim,
                                        contentSecrecy:data.obj[i].contentSecrecy,
                                        id: data.obj[i].calId,
                                        calLevel: data.obj[i].calLevel,
                                        calType: data.obj[i].calType,
                                        takeIds: data.obj[i].taker,
                                        takeName: data.obj[i].takeName,
                                        ownerIds: data.obj[i].owner,
                                        ownerName: data.obj[i].ownerName,
                                        color: "#ce84ce",
                                        backgroundColor: "#ce84ce",
                                        // beforeDay: data.obj[i].beforeDay,
                                        beforeHour: data.obj[i].beforeHour,
                                        beforeMin: data.obj[i].beforeMin,
                                        // beforeRemaind: data.obj[i].beforeRemaind,
                                        edit: data.obj[i].edit
                                    };
                                } else if (data.obj[i].calLevel == 4) {
                                    var arrObject = {
                                        title: data.obj[i].content,
                                        start: data.obj[i].stim,
                                        end: data.obj[i].etim,
                                        contentSecrecy:data.obj[i].contentSecrecy,
                                        id: data.obj[i].calId,
                                        calLevel: data.obj[i].calLevel,
                                        calType: data.obj[i].calType,
                                        takeIds: data.obj[i].taker,
                                        takeName: data.obj[i].takeName,
                                        ownerIds: data.obj[i].owner,
                                        ownerName: data.obj[i].ownerName,
                                        color: "#45a2ff",
                                        backgroundColor: "#45a2ff",
                                        // beforeDay: data.obj[i].beforeDay,
                                        // beforeHour: data.obj[i].beforeHour,
                                        // beforeMin: data.obj[i].beforeMin,
                                        // beforeRemaind: data.obj[i].beforeRemaind,
                                        edit: data.obj[i].edit
                                    };
                                }else{
                                    var arrObject = {
                                        title: data.obj[i].content,
                                        start: data.obj[i].stim,
                                        end: data.obj[i].etim,
                                        contentSecrecy:data.obj[i].contentSecrecy,
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
                                        userName:data.obj[i].userName
                                    };
                                }
                                arr.push(arrObject);
                            }
                            callback(arr);

                        }

                    });
                },
                <%--                        //新建日程--%>
                dayClick: function (date, calEvent, allDay, jsEvent, view) {
                    //判断是否有新增权限
                    var IsEdit = $('#IsEdit').attr('IsEdit');

                    if(IsEdit == 'false'){
                        return false;
                    }

                    date = date._d.Format('yyyy-MM-dd');
                    layer.open({
                        type: 1,
                        offset: '30px',
                        area: ['700px', '600px'], //宽高
                        title: "<fmt:message code="attend.th.Newschedule"/>",
                        closeBtn: 2,
                        content: '<div id="myModal" class="modal hide in">' +
                            '   <div class="modal-header"></div>' +
                            '<div class="modal-body" id="new_modal">' +
                            // 事务内容
                            ' <div class="control-group group_one" id="transactionContent" >' +
                            '           <span class="typeone" style="color:red;font-size:14px">*</span>' +
                            '       <span class="typeone" style="font-size:14px"><fmt:message code="attend.th.Contentofthings"/>:</span> ' +
                            '               <textarea style="resize:none; font-size:14px;" name="CAL_CONTENT"  id="CAL_CONTENT" placeholder="<fmt:message code="new.th.putcontent"/>" class="input input-xl CAL_CONTENT text_boder  test_null"></textarea>' +
                            '       </div>' +
                            // 事务类型
                            '       <div class="control-group">' +
                            '           <span style="color:red;font-size:14px ">*</span>' +
                            '           <span style="font-size:14px"><fmt:message code="attend.th.Typesofthings"/>:</span>' +
                            '           <select class="smallSelect text_boder" name="CAL_TYPE text_boder" id="CAL_TYPE" style="height: 30px;width: 280px;">' +
                            '               <option value="1"><fmt:message code="attend.th.Worktransaction"/></option>' +
                            <%--'               <option value="2"><fmt:message code="attend.th.Persontransaction"/></option>' +--%>
                            '           </select>' +
                            '       </div>' +
                            // 开始时间
                            '       <div class="control-group" style=" clear:both">' +
                            '           <span style="color:red;font-size:14px ">*</span>' +
                            '           <span style="font-size:14px"><fmt:message code="sup.th.startTime"/>:</span> ' +
                            '           <input name="START_DATE" id="START_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" value="' + date + '">' +

                            '       </div>' +
                            // 结束时间
                            '       <div class="control-group" id="endtimeArea1" style="">' +
                            '           <span style="color:red;font-size:14px ">*</span>' +
                            '           <span style="font-size:14px"><fmt:message code="meet.th.EndTime"/>:</span> ' +
                            '           <input name="EDN_DATE" id="EDN_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.EndDate"/>" type="text">' +

                            '       </div>' +
                            // 参与者
                            '       <div class="control-go" style="">' +
                            '           <span class="TAKER" style="font-size:14px;margin-left:0px"><fmt:message code="attend.th.Participant"/>:<br> <span style="font-size:8px;color:red;float:right">(<fmt:message code="calendar.th.onlyAbleToViewSchedule1" />)</span> </span>' +
                            '           <textarea name="TAKER_NAME" id="TAKER_NAME" class="BigStatic" wrap="yes" readonly="" style="height:54px;width: 274px;border-radius:3px;"></textarea>' +
                            '       <a href="javascript:;" id="takerOrgAdd" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +
                            '           <a href="javascript:;" id="takerOrgClear" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                            '       </div>' +
                            // 所属者
                            '       <div class="control-go" style="">' +
                            '           <span class="OWNER" style="font-size:14px;margin-left:0px"><fmt:message code="attend.th.Subordinate"/>:<br><span style="font-size:8px;color:red;float:right">(<fmt:message code="calendar.th.canViewAndEditTheSchedule1" />)</span></span> ' +
                            '           <textarea cols="35" name="OWNER_NAME" id="OWNER_NAME" class="BigStatic" wrap="yes" readonly="" style="height:54px; width: 274px;border-radius:3px;"><fmt:message code="email.th.systemmanager" /></textarea>' +
                            '           <a href="javascript:;" id="ownerOrgAdd" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +

                            '           <a href="javascript:;" id="ownerOrgClear" onclick="clearOwnerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                            '       </div>' +
                            // 事件级别
                            '       <div class="control-group" style="">' +
                            '           <span style="color:red;font-size:14px ">*</span>' +
                            '           <span style="font-size:14px"><fmt:message code="attend.th.Eventlevel"/>:</span>' +
                            '           <select id="CAL_LEVEL" class="CAL_LEVEL text_boder" style="height: 30px;width: 280px;margin-left: 6px;">' +
                            '               <option value="1"><fmt:message code="attend.th.Importanturgent"/></option>' +
                            '               <option value="2"><fmt:message code="attend.th.ImportantNourgent"/></option>' +
                            '               <option value="3"><fmt:message code="attend.th.NOImportanturgent"/></option>' +
                            '               <option value="4"><fmt:message code="attend.th.NOImportantNOurgent"/></option>' +
                            '           </select>' +
                            '       </div>' +
                            // 提醒时间
                            '       <div class="control-group">' +
                            '           <span style="font-size:14px;display:inline;margin:0 12px 0 10px;"><fmt:message code="attend.th.Remindertime"/>:</span><fmt:message code="meet.th.Advance"/><input type="text" name="BEFORE_DAY" id="BEFORE_DAY" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="attend.th.today"/><input type="text" name="BEFORE_HOUR" id="BEFORE_HOUR" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="meet.th.hour"/><input type="text" name="BEFORE_MIN" id="BEFORE_MIN" size="3" class="input input-small" style="width:30px" value="10"><fmt:message code="attend.th.Minutesreminder"/>' +
                            '       </div>' +
                            '   </div>' +
                            '   <div class="modal-footer"></div>' +
                            '<div class="control-group dataTixing"><span class="span_td tixing" style="margin-left:10px;margin-right:10px"><fmt:message code="notice.th.reminder" />:</span><span><input type="checkbox" class="remind" checked="checked" style="width:16px;vertical-align: middle;"><fmt:message code="notice.th.remindermessage" />&nbsp;&nbsp;<input type="checkbox" class="smsRemind" checked="checked" style="width:16px;vertical-align: middle;"><fmt:message code="vote.th.UseRemind" /></span></div>\n' +
                            '</div>',
                        btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>'],
                        yes: function (index, layero) {
                            var array = $(".test_null");
                            for (var i = 0; i < array.length; i++) {
                                if (array[i].value == "") {
                                    $.layerMsg({
                                        content: "<fmt:message code="meet.th.AnAsterisk"/>",
                                        icon: 3
                                    }, function () {
                                    });
                                    return;
                                }
                                // else{
                                //     layer.msg('此客户已经添加过！')
                                //     return false;
                                //
                                // }
                            }
                            //新建日程接口
                            var calTime = Date.parse(new Date($("#START_DATE").val().replace(/-/g, "/"))) / 1000;
                            var endTime = Date.parse(new Date($("#EDN_DATE").val().replace(/-/g, "/"))) / 1000;
                            var calLevel = $("#CAL_LEVEL option:selected").attr("value");
                            var calType = $("#CAL_TYPE option:selected").attr("value");
                            var content = $("#CAL_CONTENT").val();
                            var takerOrgAdd = $("#TAKER_NAME").attr("user_id");
                            var ownerOrgAdd = $("#OWNER_NAME").attr("user_id");
                            if (ownerOrgAdd.indexOf(userId) > -1) {
                                ownerOrgAdd = ownerOrgAdd
                            } else {
                                ownerOrgAdd = ownerOrgAdd + userId
                            }
                            // var beforeDay = $("#BEFORE_DAY").val();
                            // var beforeHour = $("#BEFORE_HOUR").val();
                            // var beforeMin = $("#BEFORE_MIN").val();
                            //console.log(takerOrgAdd);
                            //console.log(ownerOrgAdd);
                            //oldCodeName=$("select option:selected").val();
                            //var calId=
                            var data = {
                                //calId:calId,
                                calType: calType,
                                content: content,
                                calTime: calTime,
                                endTime: endTime,
                                userId: $.cookie('userId'),
                                calLevel: calLevel,
                                owner: ownerOrgAdd,
                                taker: takerOrgAdd,
                                contentSecrecy:$('#contentSecrecy').val()||'',
                                // beforeDay: beforeDay,
                                // beforeHour: beforeHour,
                                // beforeMin: beforeMin,
                                remind: function () {
                                    if ($('.remind').prop('checked') == false) {
                                        return '0';
                                    } else {
                                        return '1';
                                    }
                                },
                                smsRemind: function () {
                                    if ($('.smsRemind').prop('checked') == false) {
                                        return '0';
                                    } else {
                                        return '1';
                                    }
                                }
                            };
                            $.ajax({
                                url: "/schedule/addCalender",
                                data: data,
                                type: "post",
                                dataType: "json",
                                success: function () {
                                    $.ajax({
                                        url: "/schedule/getscheduleByTakerAndOwner",
                                        type: "get",
                                        dataType: "json",
                                        success: function (data) {
                                            //alert("请求成功");
                                            if (data.flag == true) {
                                                var arrObject;
                                                for (var i = 0; i < data.obj.length; i++) {
                                                    var arrObject = {
                                                        title: data.obj[i].content,
                                                        start: data.obj[i].stim,
                                                        end: data.obj[i].etim,
                                                        id: data.obj[i].calId
                                                    };
                                                    // console.log(data.obj[i].calId);
                                                    arr.push(arrObject);
                                                    //console.log(arr);
                                                }
                                                return arr;
                                            } else if (data.flag == false) {
                                                $.layerMsg({
                                                    content: '<fmt:message code="attend.th.NewFail"/>',
                                                    icon: 0
                                                }, function () {
                                                });
                                            }
                                        }
                                    });
                                    location.reload();
                                }
                            })

                        },
                        success: function (layero, index) {
                            if(!isCan) {
                             $(".dataTixing").hide();
                            }
                            $('#OWNER_NAME').val(userName).attr('user_id', userId)
                            laydate.render({
                                elem: '#START_DATE'
                                , type: 'datetime'
                            });
                            laydate.render({
                                elem: '#EDN_DATE'
                                , type: 'datetime'

                            });
                            var today = $('#START_DATE').val();
                            var todayBegin = today + ' 09:00:00';
                            var todayEnd = today + ' 11:00:00';
                            $('#START_DATE').val(todayBegin);
                            $('#EDN_DATE').val(todayEnd);
                            $("#takerOrgAdd").on("click", function () {
                                user_id = 'TAKER_NAME';
                                $.popWindow("/common/selectUser");
                            });
                            $("#ownerOrgAdd").on("click", function () {
                                user_id = 'OWNER_NAME';
                                $.popWindow("/common/selectUser");
                            });

                            $.ajax({
                                type:'get',
                                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                                dataType:'json',
                                success:function (res) {
                                    if(res.object.length!=0){
                                        var data=res.object[0]
                                        if (data.paraValue!=0){
                                            $('#transactionContent').after('<div style="margin-left: 135px;" class="control-group">' +
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


                        }
                    });
                },
                //拖拽保存
                eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
                    //alert(123);
                    var calTime = Date.parse(new Date(event.start)) / 1000;
                    var endTime = Date.parse(new Date(event.end)) / 1000;
                    var calLevel = event.calLevel;
                    var calType = event.calType;
                    var content = event.title;
                    var calId = event.id;
                    var takerOrgAdd = event.taker;
                    var ownerOrgAdd = event.owner;
                    //var calId=calEvent.id;
                    var data = {
                        calId: calId,
                        calType: calType,
                        content: content,
                        calTime: calTime,
                        endTime: endTime,
                        userId: $.cookie('userId'),
                        calLevel: calLevel,
                        owner: ownerOrgAdd,
                        taker: takerOrgAdd
                    };
                    $.ajax({
                        url: "/schedule/editCalender",
                        type: "post",
                        data: data,
                        dataType: "json",
                        success: function () {
                            //location.reload();
                        }
                    })
                },
                //编辑已有日程
                eventClick: function (calEvent, jsEvent, view) {
                    var content = calEvent.title;

                    var calTime = calEvent.start._i

                            var contentSecrecy = calEvent.contentSecrecy;
                            var endTime = calEvent.end._i
                            var cal_level = calEvent.calLevel;
                            var cal_type = calEvent.calType;
                            var ownerName = calEvent.ownerName;
                            var takeName = calEvent.takeName;
                            var takeIds = calEvent.takeIds;
                            var ownerIds = calEvent.ownerIds;
                            // var beforeDay = arrBefore[0];
                            // var beforeHour = arrBefore[1];
                            // var beforeMin = arrBefore[2];
                            var type_map = ["<fmt:message code="attend.th.Worktransaction"/>", "<fmt:message code="attend.th.Persontransaction"/>"];
                            var level_map = ["<fmt:message code="attend.th.Importanturgent"/>", "<fmt:message code="attend.th.ImportantNourgent"/>", "<fmt:message code="attend.th.NOImportanturgent"/>", "<fmt:message code="attend.th.NOImportantNOurgent"/>"];
                            var cal_type_str = type_map[cal_type - 1];
                            var cal_type_str2;
                            if (cal_type == 1) {
                                cal_type_str2 = type_map[1];
                                cal_type2 = 2;
                            } else {
                                cal_type_str2 = type_map[0];
                                cal_type2 = 1;
                            }
                            if (calEvent.remind == '0') {
                                $('.remind').prop("checked", false);
                            } else if (calEvent.remind == '1') {
                                $('.remind').prop("checked", true);
                            }
                            if (calEvent.smsRemind == '0') {
                                $('.smsRemind').prop("checked", false);
                            } else if (calEvent.smsRemind == '1') {
                                $('.smsRemind').prop("checked", true);
                            }
                            var cal_level_str = level_map[cal_level - 1];
                            layer.open({
                                type: 1,
                                //skin: 'layui-layer-rim', //加上边框
                                offset: '30px',
                                area: ['600px', '580px'], //宽高
                                title: "<fmt:message code="attend.th.Scheduleedit"/>",

                        closeBtn: 2,
                        content: '<div id="myModal" class="modal hide in">' +
                            '<div class="modal-header"></div>' +
                            '<div class="modal-body" id="new_modal" style="max-height:300px;">' +
                            '<div class="control-group" id="transactionContent">' +
                            '<label style="padding-left: 3px;"><fmt:message code="attend.th.Contentofthings"/>:' +
                            '<textarea  name="CAL_CONTENT" style="height: auto;resize : none" id="CAL_CONTENT" placeholder="<fmt:message code="notice.th.content"/>" class="input input-xl CAL_CONTENT text_boder test_null" ></textarea>' +
                            '</label>' +
                            '<span style="color:red;font-size:25px ">*</span>' +
                            '</div>' +
                            '<div class="control-group" style="margin-top: 18px;">' +
                            '<label style="padding-left: 3px;"><fmt:message code="attend.th.Typesofthings"/>:</label>' +
                            '<select class="smallSelect text_boder" name="CAL_TYPE" id="CAL_TYPE" style="height: 29px;width: 279px;">' +
                            '<option value="' + cal_type + '">' + cal_type_str + '</option>' +
                            // '<option value="' + cal_type2 + '">' + cal_type_str2 + '</option>' +
                            '</select>' +
                            '<span style="color:red;font-size:14px ">*</span>' +
                            '</div>' +
                            '<div class="control-group" style=" clear:both">' +
                            '<span><fmt:message code="sup.th.startTime"/>:</span>' +
                            '<input name="START_DATE" id="START_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.startDate"/>" type="text" value="' + calTime + '">' +
                            '<span style="color:red;font-size:14px ">*</span>' +
                            '</div>' +
                            '<div class="control-group" id="endtimeArea1" style="">' +
                            '<span><fmt:message code="meet.th.EndTime"/>:</span>' +
                            '<input name="EDN_DATE" id="EDN_DATE" class="text_boder test_null" placeholder="<fmt:message code="attend.th.EndDate"/>" type="text" value="' + endTime + '">' +
                            '<span style="color:red;font-size:14px ">*</span>' +
                            '</div>' +
                            '<div class="control-group" style="margin:5px 0 10px 93px">' +
                            '<span class="TAKER" style="font-size:14px;top:-15px;margin-left: -1px;margin-right:10px"><fmt:message code="attend.th.Participant"/>:<br> <span style="font-size:8px;color:red;float:right">(<fmt:message code="calendar.th.onlyAbleToViewSchedule1" />)</span></span>' +
                            '<textarea name="TAKER_NAME1" id="TAKER_NAME1" class="BigStatic" wrap="yes" readonly="" style="height:54px;width: 273px;margin-left:17px;vertical-align: middle;border-radius:3px;" value="' + takeName + '"></textarea>' +
                            '<a href="javascript:;" id="takerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +
                            '<a href="javascript:;" id="takerOrgClear1" onclick="clearTakerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                            '</div>' +
                            '<div class="control-group" style="margin-left:93px">' +
                            '<span class="TAKER" style="font-size:14px;margin-left: -1px;top:0px;margin-right:10px"><fmt:message code="attend.th.Subordinate"/>:<br><span style="font-size:8px;color:red;float:right">(<fmt:message code="calendar.th.canViewAndEditTheSchedule1" />)</span></span>' +
                            '<textarea cols="35" value="' + ownerName + '" name="OWNER_NAME1" id="OWNER_NAME1" rows="2" class="BigStatic" wrap="yes" readonly="" style=" margin-left: 17px;height:30px; width: 273px;margin-top:24px;vertical-align:middle;border-radius:4px;"></textarea>' +
                            '<a href="javascript:;" id="ownerOrgAdd1" onclick="" class="style_a"><fmt:message code="global.lang.add"/></a>' +
                            '<a href="javascript:;" id="ownerOrgClear1" onclick="clearOwnerName();" class="style_a"><fmt:message code="global.lang.empty"/></a>' +
                            '</div>' +
                            '<div class="control-group" style="margin-left:70px;margin-top:26px">' +
                            '<span style="padding-left:30px;"><fmt:message code="attend.th.Eventlevel"/>:</span>' +
                            '<select id="CAL_LEVEL" class="CAL_LEVEL text_boder" style="height: 29px;width: 279px;margin-left: 9px;margin-top:24px;">' +
                            '<option value="1"><fmt:message code="attend.th.Importanturgent"/></option>' +
                            '<option value="2"><fmt:message code="attend.th.ImportantNourgent"/></option>' +
                            '<option value="3"><fmt:message code="attend.th.NOImportanturgent"/></option>' +
                            '<option value="4"><fmt:message code="attend.th.NOImportantNOurgent"/></option>' +
                            '</select>' +
                            '</div>' +
                            '<div class="control-group" style="margin-left:70px;margin-top: 20px;">' +
                            '<span style="display:inline;margin:0 12px 0 10px;padding-left:20px;"><fmt:message code="attend.th.Remindertime"/>:</span><fmt:message code="meet.th.Advance"/><input type="text" name="BEFORE_DAY" id="BEFORE_DAY" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="attend.th.today"/><input type="text" name="BEFORE_HOUR" id="BEFORE_HOUR" size="3" class="input input-small" style="width:30px" value=""><fmt:message code="meet.th.hour"/><input type="text" name="BEFORE_MIN" id="BEFORE_MIN" size="3" class="input input-small" style="width:30px" value="10"><fmt:message code="attend.th.Minutesreminder"/>' +
                            '</div>' +
                            '<div class="control-group items"><span class="span_td tixing" style="margin-right:12px"><fmt:message code="notice.th.reminder" />:</span><span><input type="checkbox" class="remind" checked="checked" style="width:16px;vertical-align: middle;"><fmt:message code="notice.th.remindermessage" />&nbsp;&nbsp;<input type="checkbox" class="smsRemind" style="width:16px;vertical-align: middle;"><fmt:message code="vote.th.UseRemind" /></span></div>\n' +
                            '</div>' +
                            '<div class="modal-footer"></div>' +
                            '</div>',
                        btn: ['<fmt:message code="global.lang.save"/>', '<fmt:message code="global.lang.close"/>', '<fmt:message code="menuSSetting.th.deleteMenu"/>'],
                        success: function (layero, index) {
                                    if(!isCan) {
                                        $(".items").hide();
                                    }
                            if(isOpenSanyuan) {
                                $(".layui-layer-btn0").css("visibility","hidden");
                            }
                            if (!calEvent.edit) {
                                $('.layui-layer-btn0').hide()
                                $('.layui-layer-btn2').hide()
                                $('.control-group a').hide()
                                $('#new_modal input').prop('disabled', 'disabled')
                                $('#new_modal textarea').prop('disabled', 'disabled')
                                $('#new_modal select').prop('disabled', 'disabled').css('background-color', 'rgb(235, 235, 228)')
                            } else {
                                $('.layui-layer-btn0').show()
                                $('.layui-layer-btn2').show()
                                $('.control-group a').show()
                                $('#new_modal input').removeClass('disabled')
                                $('#new_modal textarea').removeClass('disabled')
                                $('#new_modal select').removeClass('disabled').css('background-color', '#fff')
                            }
                            $('#creator').prop('disabled', 'disabled').css('background-color', 'rgb(235, 235, 228)')
                            var calTypeArray = $("#CAL_TYPE option")
                            for (var i = 0; i < calTypeArray.length; i++) {
                                if (calTypeArray[i].value == cal_type) {
                                    $($("#CAL_TYPE  option")[i]).attr("selected", true)
                                } else {
                                    $
                                }
                            }

                            laydate.render({
                                elem: '#START_DATE'
                                , type: 'datetime'
                            });
                            laydate.render({
                                elem: '#EDN_DATE'
                                , type: 'datetime'
                            });

                            var calLevelArray = $("#CAL_LEVEL option")
                            for (var i = 0; i < calLevelArray.length; i++) {
                                if (calLevelArray[i].value == cal_level) {
                                    $($("#CAL_LEVEL  option")[i]).attr("selected", true)
                                }
                            }
                            $("#CAL_CONTENT").val(content);
                            $("#TAKER_NAME1").val(takeName);
                            $("#OWNER_NAME1").val(ownerName);
                            $("#TAKER_NAME1").attr("user_id", takeIds);
                            $("#OWNER_NAME1").attr("user_id", ownerIds);
                            $("#takerOrgAdd1").on("click", function () {
                                user_id = 'TAKER_NAME1';
                                $.popWindow("/common/selectUser");
                            });
                            $("#ownerOrgAdd1").on("click", function () {
                                user_id = 'OWNER_NAME1';
                                $.popWindow("/common/selectUser");
                            });
                            $("#takerOrgClear1").on("click", function () {
                                $("#TAKER_NAME1").val("");
                                $("#TAKER_NAME1").attr('user_id', '');
                                $("#TAKER_NAME1").attr('username', '');
                                $("#TAKER_NAME1").attr('dataid', '');
                                $("#TAKER_NAME1").attr('userprivname', '');
                            })
                            $("#ownerOrgClear1").on("click", function () {
                                $("#OWNER_NAME1").val("");
                                $("#OWNER_NAME1").attr('user_id', '');
                                $("#OWNER_NAME1").attr('username', '');
                                $("#OWNER_NAME1").attr('dataid', '');
                                $("#OWNER_NAME1").attr('userprivname', '');
                            })
                            $.ajax({
                                type:'get',
                                url:'/syspara/selectTheSysPara?paraName=IS_SHOW_SECRET',
                                dataType:'json',
                                success:function (res) {
                                    if(res.object.length!=0){
                                        var data=res.object[0]
                                        if (data.paraValue!=0){
                                            $('#transactionContent').after('<div style="margin-left: 123px;margin-top: 20px" class="control-group">' +
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
                                                        if(res.obj[i].codeNo == contentSecrecy) {
                                                            str += '<option selected value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                        }
                                                        str += '<option value="' + res.obj[i].codeNo + '">' + res.obj[i].codeName + '</option>'
                                                    }
                                                    $('#first').after(str)
                                                }
                                            })

                                        }
                                    }
                                }
                            })

                            // $('#BEFORE_DAY').val(beforeDay)
                            // $('#BEFORE_HOUR').val(beforeHour)
                            // $('#BEFORE_MIN').val(beforeMin)

                        },
                        //编辑日程接口
                        yes: function (index, layero) {
                            //alert('html');
                            //按钮【按钮三】的回调
                            var array = $(".test_null");
                            for (var i = 0; i < array.length; i++) {
                                if (array[i].value == "") {
                                    // layer.tips("不能为空",".test_null", {
                                    //  area: ['100px', '30px']
                                    //  })
                                    $.layerMsg({
                                        content: "<fmt:message code="meet.th.AnAsterisk"/>",
                                        icon: 3
                                    }, function () {
                                    });
                                    return;
                                }
                            }
                            var start_time = parseISO8601($("#START_DATE").val());
                            var end_time = parseISO8601($("#EDN_DATE").val());
                            var calTime = Date.parse(new Date(start_time)) / 1000;
                            var endTime = Date.parse(new Date(end_time)) / 1000;
                            var calLevel = $("#CAL_LEVEL").val();
                            var calType = $("#CAL_TYPE").val();
                            var content = $("#CAL_CONTENT").val();
                            var takerOrgAdd = $("#TAKER_NAME1").attr("user_id");
                            var ownerOrgAdd = $("#OWNER_NAME1").attr("user_id");
                            if (ownerOrgAdd.indexOf(userId) > -1) {
                                ownerOrgAdd = ownerOrgAdd
                            } else {
                                ownerOrgAdd = ownerOrgAdd + userId
                            }
                            // var beforeDay = $("#BEFORE_DAY").val();
                            // var beforeHour = $("#BEFORE_HOUR").val();
                            // var beforeMin = $("#BEFORE_MIN").val();
                            var calId = calEvent.id;
                            var data = {
                                calId: calId,
                                calType: calType,
                                content: content,
                                calTime: calTime,
                                endTime: endTime,
                                userId: $.cookie('userId'),
                                calLevel: calLevel,
                                owner: ownerOrgAdd,
                                taker: takerOrgAdd,
                                // beforeDay: beforeDay,
                                // beforeHour: beforeHour,
                                // beforeMin: beforeMin,
                                remind: function () {
                                    if ($('.remind').prop('checked') == false) {
                                        return '0';
                                    } else {
                                        return '1';
                                    }
                                },
                                smsRemind: function () {
                                    if ($('.smsRemind').prop('checked') == false) {
                                        return '0';
                                    } else {
                                        return '1';
                                    }
                                }
                            };

                            $.ajax({
                                url: "/schedule/editCalender",
                                type: "get",
                                data: data,
                                dataType: "json",
                                success: function () {
                                    location.reload();

                                }

                            })

                        },
                        //删除日程接口
                        btn3: function () {
                            $.layerConfirm({
                                title: '<fmt:message code="menuSSetting.th.suredeleteMenu"/>',
                                content: '<fmt:message code="workflow.th.que"/>',
                                icon: 0
                            }, function () {
                                // if(confirm("你确定要删除吗？")){
                                //console.log();
                                //var url='';
                                var data = {
                                    calId: calEvent.id
                                };
                                $.ajax({
                                    url: "/schedule/delete",
                                    type: "post",
                                    data: data,
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.code == '100066'){
                                            layer.msg('<fmt:message code="notice.th.noticeDeleteByIdsPrompt" />', {icon: 4});
                                        }else {
                                            location.reload();
                                        }
                                    }

                                })
                                // }
                                // else{
                                //  return false;
                                //  }
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
        //月视图查询切换
        $(".fc-button-month").on('click',function () {
            //alert("11111");
            $("#selectMonth").show();
            $("#selectDay").hide();
            $("#selectWeek").hide();
        });
        //周视图查询切换
        $(".fc-button-agendaWeek").on('click',function () {
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
        $(".fc-button-agendaDay").on('click',function () {
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

    //日期下拉菜单显示
    $("#selectMonth").on('change',function () {
        var str = '';
        var monthnum = $("#selectMonth option:selected").attr("value");
        var yearnum = $("#selectYear option:selected").attr("value");
        //var option;
        if (monthnum == 1 || monthnum == 3 || monthnum == 5 || monthnum == 7 || monthnum == 8 || monthnum == 10 || monthnum == 12) {
            for (var d = 1; d < 32; d++) {
                //var option = document.createElement("option");
                //var str='';
                str = str + '<option value="' + d + '">' + d + '<fmt:message code="global.lang.day"/></option>';
                //option.value = d;
                //option.innerHTML = d;
                //console.log(option[d].value);
            }
            //console.log(option.value);
        } else if (monthnum == 4 || monthnum == 6 || monthnum == 9 || monthnum == 11) {
            for (var d = 1; d < 31; d++) {
                //var option = document.createElement("option");
                //option.value = d;
                //option.innerHTML = d;
                //var str='';
                str = str + '<option value="' + d + '">' + d + '<fmt:message code="global.lang.day"/></option>';
                //console.log(option[d].value);
            }
            //console.log(option.value);
        } else if (monthnum == 2) {
            if (!isLeapYear(yearnum)) {
                for (var d = 1; d < 29; d++) {
                    //var option = document.createElement("option");
                    //option.value = d;
                    //option.innerHTML = d;
                    //console.log(option[d].value);
                    //var str='';
                    str = str + '<option value="' + d + '">' + d + '<fmt:message code="global.lang.day"/></option>';
                }
                //console.log(option.value);
            } else {
                for (var d = 1; d < 30; d++) {
                    //var option = document.createElement("option");
                    //option.value = d;
                    //option.innerHTML = d;
                    //var str='';
                    str = str + '<option value="' + d + '">' + d + '<fmt:message code="global.lang.day"/></option>';
                    //console.log(option[d].value);
                }
                //console.log(option.value);
            }
        }
        //console.log(option.value);
        $("#selectDay").html(str);
//        query();
    });
    //获取根据周数获取开始时间
    var weekGetTime = function (year, index) {
        var d = new Date(year, 0, 1);
        while (d.getDay() != 1) {
            d.setDate(d.getDate() + 1);
        }
        var to = new Date(year + 1, 0, 1);
        var i = 1;
        var arr = [];
        for (var from = d; from < to;) {
            if (i == index) {
                arr.push(from.getFullYear() + "-" + (from.getMonth() + 1) + "-" + from.getDate());
            }
            var j = 6;
            while (j > 0) {
                from.setDate(from.getDate() + 1);
                if (i == index) {
                    arr.push(from.getFullYear() + "-" + (from.getMonth() + 1) + "-" + from.getDate());
                }
                j--;
            }
            if (i == index) {
                return arr;
            }
            from.setDate(from.getDate() + 1);
            i++;
        }
    }
    //根据月份获取日期
    function monthGetDay(month) {
        var month_day;
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            var month_day = 31;
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            var month_day = 31;
        } else if (month == 4) {
            if (!isLeapYear(yearnum)) {
                var month_day = 28;
            } else {
                var month_day = 29;
            }
        }
        return month_day;
    }
    function query() {
        // alert()
        // console.log($('#selUser_id option').attr('userId'))
        arr.splice(0, arr.length);//清空数组
        var search_year = $("#selectYear").val();
        var search_year_num = parseInt($("#selectYear").val());
        var search_month = $("#selectMonth").val();
        var search_month_num = parseInt($("#selectMonth").val());
        var search_day = $("#selectDay").val();
        var search_day_num = parseInt($("#selectDay").val());
        var search_week = $("#selectWeek").val();
        //var search_week=$("#selectWeek").attr("value");
        var day_str = search_year + '-' + search_month + '-' + search_day;
        var month_day = monthGetDay(search_month);
        var dateArr1 = day_str.split("-");
        var choicedWeek = weekGetTime(search_year, search_week);
        var choicedWeekS = choicedWeek[0];
        var choicedWeekE = choicedWeek[6];
        var dateArr2 = choicedWeekS.split("-");
        var dateArr3 = choicedWeekE.split("-");
        var num = 1;
        var search_month_h = (search_month_num).toString();//setDate(dateArr1[1])+1);
        var search_day_h = (search_day_num).toString();
        var search_week_h = (parseInt(dateArr2[1])).toString();
        var deptId = $("#dept_id").val();
        if ($('#selectMonth').css('display') == 'inline-block' && $('#selectDay').css('display') == 'none') {
            if (search_month_num == 12) {
                var datas = {
                    calTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, 1)) / 1000,
                    endTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, month_day)) / 1000,
                    deptId: deptId,
                    userId: $("#selUser_id").val()
                };
                var search_month_h = (search_month_num).toString();
                //var timeHandle=search_year+'-'+search_month_h+'-1';
                var timeHandle = search_year + '-' + search_month_h + '-01';
            } else {
                var datas = {
                    calTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, 1)) / 1000,
                    endTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, month_day)) / 1000,
                    deptId: deptId,
                    userId: $("#selUser_id").val()
                };
                var search_month_h = (search_month_num).toString();
                if (search_month_h == 1 || search_month_h == 2 || search_month_h == 3 || search_month_h == 4 || search_month_h == 5 || search_month_h == 6 || search_month_h == 7 || search_month_h == 8 || search_month_h == 9) {
                    var timeHandle = search_year + '-0' + search_month_h + '-01';
                } else {
                    var timeHandle = search_year + '-' + search_month_h + '-01';
                }
            }

        } else if ($('#selectMonth').css('display') == 'inline-block' && $('#selectDay').css('display') == 'inline-block') {
            if (search_month_num < 10) {
                var search_day_h = parseInt($("#selectDay").val());
                var datas = {
                    calTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, dateArr1[2])) / 1000,
                    endTime: Date.parse(new Date(dateArr1[0], parseInt(dateArr1[1]) - 1, parseInt(dateArr1[2]) + 1)) / 1000,
                    deptId: deptId,
                    userId: $("#selUser_id").val()
                };
                if (search_day_h < 10) {
                    var timeHandle = search_year + '-0' + search_month + '-0' + search_day_h;
                } else if (search_day_h > 10) {
                    var timeHandle = search_year + '-0' + search_month + '-' + search_day_h;
                }
            } else if (search_month_num >= 10) {
                var search_day_h = parseInt($("#selectDay").val());
                if (search_day_h < 10) {
                    var timeHandle = search_year + '-' + search_month + '-0' + search_day_h;
                } else if (search_day_h > 10) {
                    var timeHandle = search_year + '-' + search_month + '-' + search_day_h;
                }
            }
        } else if ($('#selectWeek').css('display') == 'inline-block') {
            var datas = {
                calTime: Date.parse(new Date(dateArr2[0], parseInt(dateArr2[1]) - 1, dateArr2[2])) / 1000,
                deptId: deptId,
                userId: $("#selUser_id").val()
            }
            var timeHandle = dateArr2[0] + '-' + search_week_h + '-' + dateArr2[2];

        }

        $('#calendar').fullCalendar('removeEventSource', arr);
        $.ajax({
            url: '/schedule/getLeaderSchedule',
            type: 'post',
            dataType: 'json',
            data: {
                userId: $("#selUser_id").val(),
            },
            success: function (data) {
                if(data.flag && data.obj.length > 0 ){
                    $('#IsEdit').attr('IsEdit',data.obj[0].edit);
                }

                arr = [];
                for (var i = 0; i < data.obj.length; i++) {
                    if (data.obj[i].calLevel == 1) {
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id: data.obj[i].calId,
                            calLevel: data.obj[i].calLevel,
                            calType: data.obj[i].calType,
                            takeIds: data.obj[i].taker,
                            takeName: data.obj[i].takeName,
                            ownerIds: data.obj[i].owner,
                            ownerName: data.obj[i].ownerName,
                            color: "#ff5757",
                            backgroundColor: "#ff5757",
                            // beforeDay: data.obj[i].beforeDay,
                            // beforeHour: data.obj[i].beforeHour,
                            // beforeMin: data.obj[i].beforeMin,
                            // beforeRemaind: data.obj[i].beforeRemaind,
                            edit: data.obj[i].edit
                        };
                    } else if (data.obj[i].calLevel == 2) {
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id: data.obj[i].calId,
                            calLevel: data.obj[i].calLevel,
                            calType: data.obj[i].calType,
                            takeIds: data.obj[i].taker,
                            takeName: data.obj[i].takeName,
                            ownerIds: data.obj[i].owner,
                            ownerName: data.obj[i].ownerName,
                            color: "#ff9540",
                            backgroundColor: "#ff9540",
                            edit: data.obj[i].edit,
                            userName: data.obj[i].userName
                        };
                    } else if (data.obj[i].calLevel == 3) {

                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id: data.obj[i].calId,
                            calLevel: data.obj[i].calLevel,
                            calType: data.obj[i].calType,
                            takeIds: data.obj[i].taker,
                            takeName: data.obj[i].takeName,
                            ownerIds: data.obj[i].owner,
                            ownerName: data.obj[i].ownerName,
                            color: "#ce84ce",
                            backgroundColor: "#ce84ce",
                            edit: data.obj[i].edit,
                            userName: data.obj[i].userName
                        };
                    } else if (data.obj[i].calLevel == 4) {
                        var arrObject = {
                            title: data.obj[i].content,
                            start: data.obj[i].stim,
                            end: data.obj[i].etim,
                            id: data.obj[i].calId,
                            calLevel: data.obj[i].calLevel,
                            calType: data.obj[i].calType,
                            takeIds: data.obj[i].taker,
                            takeName: data.obj[i].takeName,
                            ownerIds: data.obj[i].owner,
                            ownerName: data.obj[i].ownerName,
                            color: "#45a2ff",
                            backgroundColor: "#45a2ff",
                            edit: data.obj[i].edit,
                            userName: data.obj[i].userName
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
                        userName:data.obj[i].userName
                    };
                    }
                    arr.push(arrObject);
                }

                if ($('#calendar').length > 0) {
                    $('#calendar').fullCalendar('gotoDate', timeHandle);
                    $('#calendar').fullCalendar('addEventSource', arr);
                    $('#calendar').fullCalendar('refetchEvents');
                }
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
        choose: function (datas) {
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
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
</script>
</body>
</html>
