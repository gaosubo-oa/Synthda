<%--
  Created by IntelliJ IDEA.
  User: 戎成路
  Date: 2020/5/4
  Time: 10:36
  To change this template use File | Settings | File Templates.
--%>
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
    <title>部门门户</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/echarts.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script type="text/javascript" src="/js/calendar.js"></script>

    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            user-select: none;
        }

        .container {
            position: relative;
            padding: 10px;
            width: 100%;
            height: 100%;
            background-color: #f8f8f8;
            box-sizing: border-box;
            overflow: hidden;
            min-width: 1215px;
        }

        .content {
            position: relative;
            width: 100%;
            height: 100%;
            background-color: #f8f8f8;
            overflow-y: auto;
            overflow-x: hidden;
            box-sizing: border-box;
        }

        .section {
            display: flex;
            justify-content: space-around;
            height: 48%;
            min-height: 300px;
            margin: 10px 0;
            text-align: center;
        }

        .section_item {
            display: inline-block;
            box-shadow: 0 0 5px 1px rgba(0, 0, 0, .15);
        }

        .layui-card {
            text-align: left;
        }

        img {
            width: 100%;
            height: 100%
        }

        .icon {
            display: inline-block;
            background-position: 0 0;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .con_item_title {
            display: inline-block;
            height: 28px;
            line-height: 28px;
            font-size: 16px;
            margin-top: 5px;
            font-weight: 500;
        }

        .title_icon {
            width: 24px;
            height: 24px;
            vertical-align: top;
            margin-top: 1px;
            margin-right: 5px;

            /*background-image: url('/img/planCheck/menu/menu_icon.png');*/
        }

        a {
            display: inline-block;
            width: 100%;
        }

        a:hover {
            color: #5798D9;
        }
        a:active {
            color: #5798D9;
        }

        .main_news strong{
            display: block;
            width: 100%;
            font-size: 20px;
            overflow: hidden;
            white-space: nowrap;
            word-break: break-all;
            text-overflow: ellipsis;
        }

        .main_news p{
            text-indent: 2em;
            min-height: 48px;
            height: 96px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal;
            word-break: break-all;
            display: -webkit-box;
            -webkit-line-clamp: 4;
            line-clamp: 4;
            -webkit-box-orient: vertical;
        }

        .news_module {
            height: 100%;
            overflow: hidden;
        }

        .news_box {
            overflow: auto;
            height: 100%;
        }

        .list_item a {
            position: relative;
            line-height: 30px;
            height: 30px;
            font-size: 14px;
            font-weight: 600;
        }

        .list_item .news_title {
            position: absolute;
            left: 0;
            top: 0;
            right: 50px;
            bottom: 0;
            overflow: hidden;
            white-space: nowrap;
            word-break: break-all;
            text-overflow: ellipsis;
        }

        .list_item .news_date {
            position: absolute;
            top: 0;
            right: 5px;
        }

        /* 日历样式 START */

        .calendar {
            width: 280px;
            height: 330px;
        }

        .calendar-modal {
            display: none;
            position: absolute;
            background: #fdfdfd;
            border: 1px solid #e8e8e8;
            box-shadow: 1px 2px 3px #ddd;
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
            -ms-transform-style: preserve-3d;
        }

        .calendar-views {
            transform-style: preserve-3d;
        }

        .calendar .view {
            backface-visibility: hidden;
            position: absolute;
            top: 0;
            left: 0;
            *overflow: hidden;
            -webkit-transition: .6s;
            transition: .6s;
        }

        .calendar-d .view-month, .calendar-m .view-date {
            transform: rotateY(180deg);
            visibility: hidden;
            z-index: 1;
        }

        .calendar-d .view-date, .calendar-m .view-month {
            transform: rotateY(0deg);
            visibility: visible;
            z-index: 2;
        }

        .calendar-ct, .calendar-hd, .calendar-views .week, .calendar-views .days {
            overflow: hidden;
        }

        .calendar-views {
            width: 100%;
        }

        .calendar .view, .calendar-display, .calendar-arrow .prev, .calendar .date-items li {
            float: left;
        }

        .calendar-arrow, .calendar-arrow .next {
            float: right;
        }

        /*.calendar-hd {*/
        /*padding: 10px 0;*/
        /*height: 30px;*/
        /*line-height: 30px;*/
        /*}*/

        .calendar-display {
            font-size: 28px;
            text-indent: 10px;
            width: auto;
        }

        .view-month .calendar-hd {
            padding: 10px;
        }

        .calendar-arrow, .calendar-display {
            color: #ddd;
        }

        .calendar li[disabled] {
            color: #bbb;
        }

        .calendar li.old[disabled], .calendar li.new[disabled] {
            color: #eee;
        }

        .calendar-display .m, .calendar-views .week, .calendar-views .days .old, .calendar-views .days .new, .calendar-display:hover, .calendar-arrow span:hover {
            color: #888;
        }

        .calendar-arrow span, .calendar-views .days li[data-calendar-day], .calendar-views .view-month li[data-calendar-month] {
            cursor: pointer;
        }

        .calendar li[disabled] {
            cursor: not-allowed;
        }

        .calendar-arrow {
            width: 50px;
            margin-right: 10px;
        }

        .calendar-arrow span {
            font: 500 26px sans-serif;
        }

        .calendar ol li {
            position: relative;
            float: left;
            text-align: center;
            border-radius: 50%;
        }

        .calendar .week li, .calendar .days li {
            width: 40px;
            height: 40px;
            line-height: 40px;
        }

        .calendar .month-items li {
            width: 70px;
            height: 70px;
            line-height: 70px;
        }

        .calendar .days li[data-calendar-day]:hover, .calendar .view-month li[data-calendar-month]:hover {
            background: #eee;
        }

        .calendar .calendar-views .now {
            color: #fff;
            background: #66BE8C !important;
        }

        .calendar .calendar-views .selected {
            color: #66BE8C;
            background: #cde9d9 !important;
        }

        .calendar .calendar-views .dot {
            position: absolute;
            left: 50%;
            bottom: 4px;
            margin-left: -2px;
            width: 4px;
            height: 4px;
            background: #66BE8C;
            border-radius: 50%;
        }

        .calendar-views .now .dot {
            background: #fff;
        }

        .calendar .date-items {
            width: 300%;
            margin-left: -100%;
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
            filter: alpha(opacity=70);
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
            border-top-color: #000;
        }

        /* 日历样式 END */

        body ::-webkit-scrollbar {
            display: none;
        }

    </style>

</head>
<body>
<div class="container">
    <div class="content">
        <div class="section">
            <div class="section_item" style="width: 48%">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-card-header">
                        <h4 class="con_item_title" style="font-size: 14px">
                            <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC"></i>公司新闻
                        </h4>
                    </div>
                    <div class="layui-card-body" style="height: calc(100% - 43px); box-sizing: border-box;">
                        <div class="layui-row" style="height: 100%;">
                            <div class="layui-col-xs6" style="height: 100%; padding-right: 7px;">
                                <img src="https://www.pweg.cn/upload/8a3f8f8a6cb2a8bd016cb7527be63a13.jpg" alt="">
                            </div>
                            <div class="layui-col-xs6" style="height: 100%; padding-left: 7px;">
                                <a href="javascript:;" class="main_news">
                                    <strong title='龙岗项目三获深圳市"双优工地"称号'>龙岗项目三获深圳市"双优工地"称号</strong>
                                    <p>中国之治，经国序民，正其制度。制度优势是一个国家的最大优势，我国国家治理体系和治理能力是中国特色社会主义制度及其执行能力的集中体现。读懂“中国之治”，坚持和完善中国特色社会主义制度、推进国家治理体系和治理能力现代化，是关系党和国家事业兴旺发达、国家长治久安、人民幸福安康的重大问题。2020年1月2日起，人民网推出《中国之治》栏目，围绕政治、经济、社会、文化等多重维度，学习宣传党的十九届四中全会精神，聚焦“中国之治”，解析发展背后的“中国密码”。</p>
                                </a>
                                <div class="news_module" style="height: calc(100% - 130px);">
                                    <div class="news_box">
                                        <ul class="news_list">
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section_item" style="width: 25%">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-card-header">
                        <h4 class="con_item_title" style="font-size: 14px">
                            <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC"></i>通知公告
                        </h4>
                    </div>
                    <div class="layui-card-body" style="height: calc(100% - 43px); box-sizing: border-box;">
                        <div class="news_module">
                            <div class="news_box">
                                <ul class="news_list">
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                            <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                            <span class="news_date">12-04</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section_item" style="width: 25%">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-card-header">
                        <h4 class="con_item_title" style="font-size: 14px">
                            <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC"></i>工作日历
                        </h4>
                    </div>
                    <div class="layui-card-body" >
                        <div id="demo">
                            <div id="ca" style="margin: 0 auto;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section">
            <div class="section_item" style="width: 48%">
                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief" style="margin:0px">
                    <ul class="layui-tab-title">
                        <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC;margin-top: 14px;padding-left: 15px;"></i>
                        <li class="layui-this">工作子任务</li>
                        <li>部门绩效</li>
                    </ul>
                    <div class="layui-tab-content" style="height: 338px;">
                        <div class="layui-tab-item layui-show" style="height: calc(100% - 43px); box-sizing: border-box;">
                            <div class="news_module">
                                <div class="news_box">
                                    <ul class="news_list">
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="layui-tab-item"  style="height: calc(100% - 43px); box-sizing: border-box;">
                            <div class="news_module">
                                <div class="news_box">
                                    <ul class="news_list">
                                        <li class="list_item">
                                            <a href="javascript:;" title="张胜到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">张胜到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                        <li class="list_item">
                                            <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                <span class="news_date">12-04</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section_item" style="width: 25%">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-card-header">
                        <h4 class="con_item_title" style="font-size: 14px">
                            <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC"></i>待办事项
                        </h4>
                    </div>
                    <div class="layui-card-body" style="height: calc(100% - 43px); box-sizing: border-box;">
                        <div class="news_module">
                            <div class="news_box">
                                <ul class="news_list">
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color:cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color:cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color:cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color:cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                    <li class="list_item">
                                        <a href="javascript:;" title="关于做好公司人力资源管理系统...">
                                            <span class="news_title"><i class="layui-icon layui-icon-circle-dot" style="color: cornflowerblue;font-size: 10px;margin-right: 5px"></i>关于做好公司人力资源管理系统...</span>
                                            <span class="news_date">2019-10-18</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section_item" style="width: 25%">
                <div class="layui-card" style="height: 100%;">
                    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                        <ul class="layui-tab-title">
                            <i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC;margin-top: 14px;padding-left: 15px;"></i>
                            <li class="layui-this">公司发文</li>
                            <li>公司收文</li>
                        </ul>
                        <div class="layui-tab-content" style="height: 338px;">
                            <div class="layui-tab-item layui-show" style="height: calc(100% - 43px); box-sizing: border-box;">
                                <div class="news_module">
                                    <div class="news_box">
                                        <ul class="news_list">
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title"><i class="layui-icon layui-icon-rate-solid" style="font-size: 12px;color: cornflowerblue;"></i>刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="layui-tab-item"  style="height: calc(100% - 43px); box-sizing: border-box;">
                                <div class="news_module">
                                    <div class="news_box">
                                        <ul class="news_list">
                                            <li class="list_item">
                                                <a href="javascript:;" title="张胜到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">张胜到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                            <li class="list_item">
                                                <a href="javascript:;" title="刘源到电建生态公司调研并讲授专题党课">
                                                    <span class="news_title">刘源到电建生态公司调研并讲授专题党课</span>
                                                    <span class="news_date">12-04</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--<div class="layui-card-header">--%>
                        <%--<h4 class="con_item_title" style="font-size: 14px">--%>
                            <%--<i class="icon title_icon layui-icon layui-icon-template-1" style="color: #3393FC"></i>工作日历--%>
                        <%--</h4>--%>
                    <%--</div>--%>
                    <%--<div class="layui-card-body" style="height: calc(100% - 43px); box-sizing: border-box;">--%>
                    <%--</div>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
        $('#ca').calendar({
            width: 300,
            height: 190,
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
    })
</script>

</body>
</html>
