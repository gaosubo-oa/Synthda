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
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>公司门户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/calendar.js"></script>

    <style>
        html, body{
        font-family: "Microsoft Yahei" !important;
        }
        body {
            background: #EDF0F6;
        }

        .number:hover {
            color: #1195FB !important;
        }

        .fourTop {
            display: flex;
            font-size: 17px;
            /*width: 188px;*/
            height: 66px;
            border-top: 1px solid #ccc;
            border-right: 1px dashed #ccc;
            border-bottom: 1px dashed #ccc;
            padding-top: 12px;
        }

        .fourBottom {
            display: flex;
            font-size: 17px;
            /*width: 188px;*/
            height: 66px;
            border-right: 1px dashed #ccc;
            border-bottom: 1px dashed #ccc;
            padding-top: 12px;
        }

        .block-item-title {
            font-size: 12px;
            color: #5d5d5d;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-top: 8px;
        }

        .layui-icon {
            font-size: 20px;
        }

        .block-item-content {
            height: 37px;
            line-height: 37px;
            text-align: center;
        }

        .block-item:hover {
            background: #ebebeb;
            opacity: 0.8;
        }

        .left {
            width: 63%;
        }

        .left2 a {
            cursor: pointer;
        }

        .left2 .layui-table td {
            border: none;
        }

        .block-item-bg {
            width: 150px;
            height: 200px;
        }

        .block-item-bg:hover {
            opacity: 0.6;
        }

        .block-item-icon {
            position: absolute;
            top: 70px;
            left: 92px;
        }

        .left3 a:hover {
            color: #018efb !important;
        }

        .left3, .left4 {
            width: 48.9%;
        }

        .catListTitle {
            border: 1px solid #EBEBEB;
            color: #008ff3;
            font-size: 18px;
            font-weight: normal;
            padding: 10px 10px;
        }

        .catListView {
            padding: 0px 15px;
            margin-top: 22px;
            padding-bottom: 60px;
        }

        .catListView ul li {
            padding: 5px 15px;
            font-size: 12px;
            color: #777;
            height: 15px;
        }

        .catListView ul li:hover {
            background-color: #f5f5f5;
        }

        .catListView ul li a {
            color: #777;
            display: inline-block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            vertical-align: middle;
            width: calc(100% - 60px);
            cursor: pointer;
        }

        .numClass {
            color: red;
            width: 45px;
            margin-left: 30px;
        }

        .catListView ul {
            border: 1px solid #EBEBEB;
            border-top: none;
        }

        .list-content .headimg {
            width: 30px;
            height: 30px;
            line-height: 30px;
            background-size: 30px;
            border-radius: 20px;
            margin-top: 5px;
            cursor: pointer;
        }

        .td-item {
            font-size: 12px;
        }

        .tr-item {
            border-bottom: 1px solid #f3f3f3;
            margin: 10px 0px;
            padding-bottom: 10px;
        }

        .left4 td {
            border: none;
        }

        .calendar {
            width: 280px;
            height: 330px
        }

        .calendar-modal {
            display: none;
            position: absolute;
            background: #fdfdfd;
            border: 1px solid #e8e8e8;
            box-shadow: 1px 2px 3px #ddd
        }

        .calendar-inner {
            position: relative;
            z-index: 1;
            -webkit-perspective: 1 e3;
            -moz-perspective: 1 e3;
            -ms-perspective: 1 e3;
            perspective: 1 e3;
            -ms-transform: perspective(1000px);
            -moz-transform: perspective(1000px);
            -moz-transform-style: preserve-3d;
            -ms-transform-style: preserve-3d
        }

        .calendar-views {
            transform-style: preserve-3d
        }

        .calendar .view {
            backface-visibility: hidden;
            position: absolute;
            top: 0;
            left: 0;
            *overflow: hidden;
            -webkit-transition: .6s;
            transition: .6s
        }

        .calendar-d .view-month, .calendar-m .view-date {
            transform: rotateY(180deg);
            visibility: hidden;
            z-index: 1
        }

        .calendar-d .view-date, .calendar-m .view-month {
            transform: rotateY(0deg);
            visibility: visible;
            z-index: 2
        }

        .calendar-ct, .calendar-hd, .calendar-views .week, .calendar-views .days {
            overflow: hidden
        }

        .calendar-views {
            width: 100%
        }

        .calendar .view, .calendar-display, .calendar-arrow .prev, .calendar .date-items li {
            float: left
        }

        .calendar-arrow, .calendar-arrow .next {
            float: right
        }

        .calendar-hd {
            padding: 10px 0;
            height: 30px;
            line-height: 30px
        }

        .calendar-display {
            font-size: 28px;
            text-indent: 10px
        }

        .view-month .calendar-hd {
            padding: 10px
        }

        .calendar-arrow, .calendar-display {
            color: #ddd
        }

        .calendar li[disabled] {
            color: #bbb
        }

        .calendar li.old[disabled], .calendar li.new[disabled] {
            color: #eee
        }

        .calendar-display .m, .calendar-views .week, .calendar-views .days .old, .calendar-views .days .new, .calendar-display:hover, .calendar-arrow span:hover {
            color: #888
        }

        .calendar-arrow span, .calendar-views .days li[data-calendar-day], .calendar-views .view-month li[data-calendar-month] {
            cursor: pointer
        }

        .calendar li[disabled] {
            cursor: not-allowed
        }

        .calendar-arrow {
            width: 50px;
            margin-right: 10px
        }

        .calendar-arrow span {
            font: 500 26px sans-serif
        }

        .calendar ol li {
            position: relative;
            float: left;
            text-align: center;
            border-radius: 50%
        }

        .calendar .week li, .calendar .days li {
            width: 40px;
            height: 40px;
            line-height: 40px
        }

        .calendar .month-items li {
            width: 70px;
            height: 70px;
            line-height: 70px
        }

        .calendar .days li[data-calendar-day]:hover, .calendar .view-month li[data-calendar-month]:hover {
            background: #eee
        }

        .calendar .calendar-views .now {
            color: #fff;
            background: #66BE8C !important
        }

        .calendar .calendar-views .selected {
            color: #66BE8C;
            background: #cde9d9 !important
        }

        .calendar .calendar-views .dot {
            position: absolute;
            left: 50%;
            bottom: 4px;
            margin-left: -2px;
            width: 4px;
            height: 4px;
            background: #66BE8C;
            border-radius: 50%
        }

        .calendar-views .now .dot {
            background: #fff
        }

        .calendar .date-items {
            width: 300%;
            margin-left: -100%
        }

        .calendar-label {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            z-index: 2;
            padding: 5px 10px;
            line-height: 22px;
            color: #fff;
            background: #000;
            border-radius: 3px;
            opacity: .7;
            filter: alpha(opacity=70)
        }

        .calendar-label i {
            display: none;
            position: absolute;
            left: 50%;
            bottom: -12px;
            width: 0;
            height: 0;
            margin-left: -3px;
            border: 6px solid transparent;
            border-top-color: #000
        }

        .layui-tab-content td {
            border: none;
        }

        .every_logo {
            float: left;
            margin-top: 0%;
            margin-left: 6%;
            cursor: pointer;
            height: 107px;
            width: 23%;
            text-align: center;
            margin-top: 5px;
        }

        .every_logo h2 {
            width: 100%;
            height: 30%;
            text-align: center;
            line-height: 20px;
            font-size: 13px;
        }

        .every_logo img {
            margin-top: 9%;
        }

        table h2{
            font-size: 15px;
        }
    </style>
</head>
<body>
<div class="layui-fluid" style="padding: 10px;">
    <div style=" width: 63%;height: 300px">
        <div style=" background: url('/ui/img/menu/company.jpg') center center/cover no-repeat;height: 100%;"></div>
    </div>
    <div style="display:flex;margin-top: 10px;">
        <div class="left">
            <div class="left2" style=" background: #FFFFFF;margin-top: 5px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">业务审批</div>
                </div>
                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                    <ul class="layui-tab-title">
                        <li class="layui-this">待办</li>
                        <li>已办</li>
                    </ul>
                    <div class="layui-tab-content" style="height: 268px;overflow-y: auto;">
                        <div class="layui-tab-item layui-show">
                            <table class="layui-table backlog">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                        <div class="layui-tab-item">
                            <table class="layui-table haveDone">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="left3" style=" background: #FFFFFF;margin-top: 5px;float: left;height: 378px">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">新闻动态</div>
                </div>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <table class="layui-table journalism">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="left4" style=" background: #FFFFFF;margin-top: 5px;float: left;margin-left: 2%;height: 378px">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">公告</div>
                </div>

                <div class="layui-tab-content" style="height: 83%; overflow-y: auto;">
                    <div class="layui-tab-item layui-show">
                        <table class="layui-table notice">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <div class="right" style="width: 36%;margin-left: 15px;margin-top: -310px;">
            <div style="padding-top: 30px;background: #FFFFFF;height: 400px">
                <div id="demo">
                    <div id="ca" style="margin: 0 auto;"></div>
                </div>
            </div>
            <div style="background: #FFFFFF;margin-top: 15px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">常用工具</div>
                </div>
                <div style="display: flex">
                    <div class="tool" style="margin: 0 auto;padding-bottom: 30px;"></div>
                </div>
            </div>
            <div style="background: #FFFFFF;margin-top: 15px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">工作计划管理</div>
                </div>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <table class="layui-table project" style="height: 248px">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    for (var i = 0; i < $('.layui-table tr').length; i++) {
        $('.layui-table tr').eq(i).find('td').eq(1).css('textAlign', 'right')
    }
    $('#ca').calendar({
        width: 320,
        height: 320,
        data: [
            {
                date: '2015/12/24',
                value: 'Christmas Eve'
            },
            {
                date: '2015/12/25',
                value: 'Merry Christmas'
            },
            {
                date: '2016/01/01',
                value: 'Happy New Year'
            }
        ],
        onSelected: function (view, date, data) {

        }
    });

    $('#dd').calendar({
        trigger: '#dt',
        zIndex: 999,
        format: 'yyyy-mm-dd',
        onSelected: function (view, date, data) {
            console.log('event: onSelected')
        },
        onClose: function (view, date, data) {
            console.log('event: onClose')
            console.log('view:' + view)
            console.log('date:' + date)
            console.log('data:' + (data || 'None'));
        }
    });
    var no_Data = "暂无数据";
    $(function () {
        administrivia();
        getApplication();
        workPlan();
        announcement();
        $.ajax({
            url: "/portals/selPortalsUser",
            type: "get",
            dataType: "json",
            success: function (res) {
                var userId = res.object.userId;
                annount(userId);
                announts(userId);
            }
        })
    });
    //公告查询方法 未读
    function announcement() {
        var obj = {
            page: 1,
            pageSize: 6,
            useFlag: true,
            typeId: 0,
            read: '',
            sendTime: ''
        };
        $.ajax({
            url: "/notice/notifyManage",
            type: 'get',
            data: obj,
            dataType: 'json',
            success: function (obj) {
                var data = obj.obj;
                var str_li = '';
                var notice_li = '';
                for (var i = 0; i < data.length; i++) {
                    str_li += '<tr class="chedule_li" style="width:100%" onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[i].notifyId + '">' +
                        '<td style="width:60%"><a style="width: 100px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display: inline-block;" title="' + data[i].subject + '">' + data[i].subject + '</a><td>' +
                        '<td class="every_times" style="float: right;padding-right: 10px;white-space: nowrap;">' + function () {

                            if (data[i].notifyDateTime != undefined) {
                                return data[i].notifyDateTime.split(/\s/g)[0]
                            } else {
                                return ''
                            }

                        }() + '</td>' +
                        '</tr>'


                }
                $('.notice tbody').html(str_li);
                if (data.length == 0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.notice tbody').html(lis);
                }
            }
        })
    }
    //工作计划管理
    function workPlan() {
        $.ajax({
            url: '/workPlan/selectWorkPlanByCond',
            type: 'get',
            data: {
                page: 1,
                pageSize: 6,
                useFlag: 'true',
                type: '',
                statusFlag: ''
            },
            dataType: 'json',
            success: function (obj) {

                var li = '';
                var data = obj.obj;
                for (var i = 0; i < data.length; i++) {
                    li += '<tr class="chedule_li" style="width:100%" onclick="tiaozhuan(this)" data-url="/workPlan/workPlanManager">' +
                        '<td style="width:60%"><a title="' + data[i].name + '">' + data[i].name + '</a><td>' +
                        '<td class="every_times" style="float: right;padding-right: 10px;">' + function () {

                            if (data[i].createDate != undefined) {
                                return data[i].createDate;
                            } else {
                                return ''
                            }


                        }() + '</td>' +
                        '</tr>'
                }
                $('.project tbody').html(li);
                if (data.length == 0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.project tbody').html(lis);
                }


            }
        });
    }
    //公司新闻
    function administrivia() {
        $.ajax({
            url: '/news/newsManage',
            type: 'get',
            data: {
                page: '1',
                read: 0,
                pageSize: '6',
                useFlag: 'true',
                typeId: ''
            },
            dataType: 'json',
            success: function (obj) {

                var li = '';
                var data = obj.obj;
                for (var i = 0; i < data.length; i++) {
                    li += '<tr class="chedule_li" onclick="tiaozhuan(this)" data-url="/news/detail?newsId=' + data[i].newsId + '">' +
                        '<td><a title="' + data[i].subject + '">' + data[i].subject + '</a><td>' +
                        '<td class="every_times" style="float: right;padding-right: 10px;">' + function () {

                            if (data[i].newsDateTime != undefined) {
                                return data[i].newsDateTime.split(/\s/g)[0];
                            } else {
                                return ''
                            }


                        }() + '</td>' +
                        '</tr>'
                }
                $('.journalism tbody').html(li);
                if (data.length == 0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.journalism tbody').html(lis);
                }


            }
        });
    }
    //获取我的门户的菜单模块
    function getApplication() {
        $.ajax({
            type: 'get',
            url: '/getMenu',
            dataType: 'json',
            success: function (res) {
                var data = res.obj;
                if (res.obj.length > 0) {
                    var str = '';
                    if (res.obj.length > 6) {
                        for (var i = 0; i < 6; i++) {
                            str += '<div class="every_logo" menu_tid="' + data[i].id + '" onclick="parent.getMenuOpen(this)" data-url="' + data[i].url + '">' +
                                '<img src="/img/main_img/app/' + data[i].id + '.png">' +
                                '<h2>' + data[i].name + '</h2>' +
                                '</div>'
                        }
                    } else {
                        for (var i = 0; i < data.length; i++) {
                            str += '<div class="every_logo" menu_tid="' + data[i].id + '" onclick="parent.getMenuOpen(this)" data-url="' + data[i].url + '">' +
                                '<img src="/img/main_img/app/' + data[i].id + '.png">' +
                                '<h2>' + data[i].name + '</h2>' +
                                '</div>'
                        }
                    }
                    $('.tool').html(str);
                }
                if (res.obj.length == 0) {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.tool').html(lis);
                }
            }
        })
    }
    //业务审批待办
    function annount(userId) {
        $.ajax({
            url: '/workflow/work/selectWork',
            type: 'get',
            dataType: 'json',
            data: {
                page: 1,
                pageSize: 6,
                useFlag: true,
                userId: userId
            },
            success: function (res) {
                var workFlow = res.obj;
                //加载门户工作、业务审批
                if (res.flag && workFlow.length > 0) {
                    var daiba_li = '';
                    for (var m = 0; m < workFlow.length; m++) {
                        var time = workFlow[m].receiptTime.replace(/\s/, ' ')
                        daiba_li += '<tr class="chedule_li" onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag=' + workFlow[m].opFlag + '&flowId=' + workFlow[m].flowRun.flowId + '&flowStep=' + workFlow[m].prcsId + '&runId=' + workFlow[m].runId + '&prcsId=' + workFlow[m].flowPrcs + '"  data-s="2" class="clearfix">' +
                            '<td><a>' + workFlow[m].flowRun.runName + '</a><td>' +
                            '<td class="every_times" style="float: right;padding-right: 10px;">' + function () {

                                if (workFlow[m].receiptTime.split(/\s/)[0] != undefined) {
                                    return workFlow[m].receiptTime.split(/\s/)[0].split(/\s/g)[0];
                                } else {
                                    return ''
                                }


                            }() + '</td>' +
                            '</tr>'

                    }
                    $('.backlog tbody').html(daiba_li);
                } else {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.backlog tbody').html(lis);
                }
            }
        })

    }
    //业务审批已办
    function announts(userId) {
        $.ajax({
            url: '/workflow/work/selectEndWord',
            type: 'get',
            dataType: 'json',
            data: {
                page: 1,
                pageSize: '6',
                useFlag: true,
                userId: userId
            },
            success: function (res) {
                var workFlow = res.obj;
                //加载门户工作、业务审批
                if (res.flag && workFlow.length > 0) {
                    var daiba_li = '';
                    for (var m = 0; m < workFlow.length; m++) {
                        var time = workFlow[m].deliverTime.replace(/\s/, ' ')
                        daiba_li += '<tr class="chedule_li" onclick="windowOpenNew(this)" type1="daiban" data-url="/workflow/work/workform?opFlag=' + workFlow[m].opFlag + '&flowId=' + workFlow[m].flowRun.flowId + '&flowStep=' + workFlow[m].prcsId + '&runId=' + workFlow[m].runId + '&prcsId=' + workFlow[m].flowPrcs + '"  data-s="2" class="clearfix">' +
                            '<td><a>' + workFlow[m].flowRun.runName + '</a><td>' +
                            '<td class="every_times" style="float: right;padding-right: 10px;">' + function () {

                                if (workFlow[m].receiptTime.split(/\s/)[0] != undefined) {
                                    return workFlow[m].receiptTime.split(/\s/)[0].split(/\s/g)[0];
                                } else {
                                    return ''
                                }


                            }() + '</td>' +
                            '</tr>'
                    }
                    $('.haveDone tbody').html(daiba_li);
                } else {
                    var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                        '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                        '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                        '</div>';
                    $('.haveDone tbody').html(lis);
                }
            }
        })
    }
    //待办工作点击事件
    function windowOpenNew(me) {
        /* if($(me).attr('data-s')==1){
         /!* window.open('/email/details?id='+$(me).find('.windowopen').attr('data-id'))*!/
         window.open($(me).attr('data-url'))
         }else */
        if ($(me).attr('data-s') == 2) {
            var objGet = $(me).attr('data-url');
            var runId = objGet.split('&runId=')[1].split('&prcsId=')[0];
            var prcsId = objGet.split('&prcsId=')[1].split('&isNomalType=')[0];
            if ($(me).parents('.custom_two').attr('id') == 'documentToDoList') {
                $.get('/ToBeReadController/querySmsIsRead', {runId: runId, prcsId: prcsId}, function (data) {
                    window.open(objGet);
                }, 'json')
            } else {
                window.open(objGet);
            }
        } else if ($(me).attr('data-s') == 3) {
            window.open('/notice/detail?notifyId=' + $(me).attr('data-qid'))
        } else if ($(me).attr('data-s') == 4) {
            window.open('/news/detail?newsId=' + $(me).attr('data-new'))
        } else if ($(me).attr('data-s') == 5) {
            var rl = $(me).attr('data-url')
            $.popWindow(rl, '公告详情', '20', '150', '1200px', '600px')
        } else if ($(me).attr('data-s') == 200) {
            var bodyId = $(me).attr('bodyId')
            $.ajax({
                type: "post",
                url: "/sms/setRead",
                dataType: 'JSON',
                data: {"bodyId": bodyId},
                success: function () {
                    window.open($(me).attr('data-url'))
                }
            });
        } else {
            window.open($(me).attr('data-url'))
        }
        if ($(me).parent().parent().prev().find('.custom_num') != undefined) {
            var todoNum = $(me).parent().parent().prev().find('.custom_num').text();
            $(me).parent().parent().prev().find('.custom_num').text(--todoNum)
        }
        var type1 = $(me).attr("type1");
        if (type1 == undefined || type1 != "daiban") {
            $(me).remove();
            todoListNum--;
        }
        if (todoListNum < 99) {
            $('#sns').html('<div class="he">' + todoListNum + '</div>');
        }

        if (todoListNum == 0) {
            $('#sns').find('.he').hide();
        }


        if ($('.daiban').find('li').length == 0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 45px;margin-bottom: 10px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">' + no_Data + '</h2>' +
                '</div>';
            $('.daiban').html(lis);
        }
    }
    //跳转页面
    function tiaozhuan(that) {
        $.popWindow($(that).attr('data-url'), '公告详情', '20', '150', '1200px', '600px')
    }
</script>
</html>
