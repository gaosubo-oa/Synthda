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
    <title>我的门户</title>
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
    <script type="text/javascript" src="/js/echarts.min.js"></script>
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
            width: 67%;
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
        .left3,.left4{
            width: calc(98%/2);
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
            height: 330px;
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
            -webkit-perspective: 1000;
            -moz-perspective: 1000;
            -ms-perspective: 1000;
            perspective: 1000;
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
        .calendar-d .view-month,
        .calendar-m .view-date {

            transform: rotateY(180deg);
            visibility: hidden;
            z-index: 1;
        }
        .calendar-d{
            margin: 0 auto;
        }
        .calendar-d .view-date,
        .calendar-m .view-month {
            transform: rotateY(0deg);
            visibility: visible;
            z-index: 2;
        }
        .calendar-ct,
        .calendar-hd,
        .calendar-views .week,
        .calendar-views .days {
            overflow: hidden;
        }
        .calendar-views {
            width: 100%;
        }
        .calendar .view,
        .calendar-display,
        .calendar-arrow .prev,
        .calendar .date-items li {
            float: left;
        }
        .calendar-arrow,
        .calendar-arrow .next {
            float: right;
        }
        .calendar-hd {
            padding: 10px 0;
            height: 30px;
            line-height: 30px;
        }
        .calendar-display {
            font-size: 28px;
            text-indent: 10px;
        }
        .view-month .calendar-hd {
            padding: 10px;
        }
        .calendar-arrow,
        .calendar-display {
            color: #ddd;
        }
        .calendar li[disabled] {
            color: #bbb;
        }
        .calendar li.old[disabled],
        .calendar li.new[disabled] {
            color: #eee;
        }
        .calendar-display .m,
        .calendar-views .week,
        .calendar-views .days .old,
        .calendar-views .days .new,
        .calendar-display:hover,
        .calendar-arrow span:hover {
            color: #888;
        }

        .calendar-arrow span,
        .calendar-views .days li[data-calendar-day],
        .calendar-views .view-month li[data-calendar-month] {
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
        .calendar .week li,
        .calendar .days li {
            width: 40px;
            height: 40px;
            line-height: 40px;
        }
        .calendar .month-items li {
            width: 70px;
            height: 70px;
            line-height: 70px;
        }
        .calendar .days li[data-calendar-day]:hover,
        .calendar .view-month li[data-calendar-month]:hover {
            background: #eee;
        }
        .calendar .calendar-views .now {
            color: #fff;
            background: #66be8c!important;
        }
        .calendar .calendar-views .selected {
            color: #66be8c;
            background: #CDE9D9!important;
        }
        .calendar .calendar-views .dot {
            position: absolute;
            left: 50%;
            bottom: 4px;
            margin-left: -2px;
            width: 4px;
            height: 4px;
            background: #66be8c;
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
    </style>
</head>
<body>
<div class="layui-fluid" style="padding: 10px;">
    <div style=" width: 67%;height: 200px">
        <div style=" background: url('/ui/img/default/backgroundMainCon_2.jpg') center center/cover no-repeat;height: 100%;"></div>
    </div>
    <div style="display:flex;margin-top: 10px;">
        <div class="left">
            <div class="left2" style=" background: #FFFFFF;margin-top: 5px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">流程中心</div>
                </div>
                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                    <ul class="layui-tab-title">
                        <li class="layui-this">待办</li>
                        <li>已办</li>
                        <li>办结</li>
                        <li>抄送</li>
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <table class="layui-table">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td><a>1111</a></td>
                                    <td>2019-10-16</td>
                                </tr>
                                <tr>
                                    <td><a>产品培训心得体会</a></td>
                                    <td>2018-12-28</td>
                                </tr>
                                <tr>
                                    <td><a>与前辈共同探讨－－产品应用心得体会</a></td>
                                    <td>2018-12-25</td>
                                </tr>
                                <tr>
                                    <td><a>2010年12月3日项目分享会心得体会</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>2018年4月17日项目分享会心得体会</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="layui-tab-item">
                            <table class="layui-table">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td><a>维森移动化政务办公平台解决方案v2.0</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>维森预算费控管理解决方案v2.0</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>2017维森移动化党建平台 解决方案(v1.0)</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>金融行业，银行专项解决方案</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>维森预算费控管理解决方案v1.0</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="layui-tab-item">
                            <table class="layui-table">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td><a>1111</a></td>
                                    <td>2019-10-16</td>
                                </tr>
                                <tr>
                                    <td><a>内蒙古伊利实业集团股份有限公司OA系统项目案例</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>福建中旅集团 OA系统项目案例</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>常德芙蓉大亚化纤有限公司 办公系统服务项目案例</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>黄龙体育中心 办公自动化系统项目案例</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="layui-tab-item">
                            <table class="layui-table">
                                <colgroup>
                                    <col>
                                    <col>
                                </colgroup>
                                <tbody>
                                <tr>
                                    <td><a>产品培训心得体会</a></td>
                                    <td>2018-12-28</td>
                                </tr>
                                <tr>
                                    <td><a>与前辈共同探讨－－产品应用心得体会</a></td>
                                    <td>2018-12-25</td>
                                </tr>
                                <tr>
                                    <td><a>2010年12月3日项目分享会心得体会</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>2018年4月17日项目分享会心得体会</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                <tr>
                                    <td><a>4 NMTD培训调查问卷（心得体会）</a></td>
                                    <td>2018-12-14</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="left3" style=" background: #FFFFFF;margin-top: 5px;float: left;height: 300px">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">新闻动态</div>
                </div>
                <div style="display: flex;text-align: center;margin-top: 20px;">
                    <div style=" width: 25%;cursor: pointer;position:relative; ">
                        <div style="opacity: 0.6;">
                            <img alt="运营体系知识地图" title="运营体系知识地图" class="block-item-bg" src="/img/default/100.jpg">
                            <img alt="运营体系知识地图" title="运营体系知识地图" class="block-item-icon" src="/img/default/19.png">
                        </div>
                        <div class="block-item-content"><a>运营体系知识地图</a></div>
                    </div>
                    <div style=" width: 25%;cursor: pointer;position: relative;">
                        <div style="opacity: 0.6;">
                            <img alt="入职培训知识地图" title="入职培训知识地图" class="block-item-bg" src="/img/default/101.jpg">
                            <img alt="入职培训知识地图" title="入职培训知识地图" class="block-item-icon" src="/img/default/20.png">
                        </div>
                        <div class="block-item-content"><a>入职培训知识地图</a></div>
                    </div>
                    <div style=" width: 25%;cursor: pointer;position: relative;">
                        <div style="opacity: 0.6;">
                            <img alt="产品功能知识地图" title="产品功能知识地图" class="block-item-bg" src="/img/default/102.jpg">
                            <img alt="产品功能知识地图" title="产品功能知识地图" class="block-item-icon" src="/img/default/21.png">
                        </div>
                        <div class="block-item-content"><a>产品功能知识地图</a></div>
                    </div>
                    <div style=" width: 25%;cursor: pointer;position: relative;">
                        <div style="opacity: 0.6;">
                            <img alt="销售岗位知识地图" title="销售岗位知识地图" class="block-item-bg" src="/img/default/103.jpg">
                            <img alt="销售岗位知识地图" title="销售岗位知识地图" class="block-item-icon" src="/img/default/22.png">
                        </div>
                        <div class="block-item-content"><a>销售岗位知识地图</a></div>
                    </div>
                </div>
            </div>
            <div class="left4" style=" background: #FFFFFF;margin-top: 5px;float: left;margin-left: 15px;height: 300px">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">重要通知</div>
                </div>

                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <table class="layui-table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td><a>1111</a></td>
                                <td>2019-10-16</td>
                            </tr>
                            <tr>
                                <td><a>产品培训心得体会</a></td>
                                <td>2018-12-28</td>
                            </tr>
                            <tr>
                                <td><a>与前辈共同探讨－－产品应用心得体会</a></td>
                                <td>2018-12-25</td>
                            </tr>
                            <tr>
                                <td><a>2010年12月3日项目分享会心得体会</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>2018年4月17日项目分享会心得体会</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td><a>维森移动化政务办公平台解决方案v2.0</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>维森预算费控管理解决方案v2.0</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>2017维森移动化党建平台 解决方案(v1.0)</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>金融行业，银行专项解决方案</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>维森预算费控管理解决方案v1.0</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td><a>1111</a></td>
                                <td>2019-10-16</td>
                            </tr>
                            <tr>
                                <td><a>内蒙古伊利实业集团股份有限公司OA系统项目案例</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>福建中旅集团 OA系统项目案例</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>常德芙蓉大亚化纤有限公司 办公系统服务项目案例</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>黄龙体育中心 办公自动化系统项目案例</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="layui-tab-item">
                        <table class="layui-table">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td><a>产品培训心得体会</a></td>
                                <td>2018-12-28</td>
                            </tr>
                            <tr>
                                <td><a>与前辈共同探讨－－产品应用心得体会</a></td>
                                <td>2018-12-25</td>
                            </tr>
                            <tr>
                                <td><a>2010年12月3日项目分享会心得体会</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>2018年4月17日项目分享会心得体会</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            <tr>
                                <td><a>4 NMTD培训调查问卷（心得体会）</a></td>
                                <td>2018-12-14</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
        <div class="right" style="width: 30%;margin-left: 15px;margin-top: -210px;">
            <div style="padding-top: 16px;background: #FFFFFF;height: 400px">
                <div id="demo">
                    <div id="calendar"></div>
                </div>
            </div>
            <div style="background: #FFFFFF;margin-top: 10px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">常用工具</div>
                </div>
                <div style="display: flex">
                    <div style="margin-top: 6px;width: 50%;">
                        <div class="fourTop">
                            <div style="padding-left: 20px;"><i style="color: #79B564"
                                                                class="layui-icon layui-icon-template-1"></i></div>
                            <div style="margin-left: 10px;">
                                <div><a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">35</a></div>
                                <div class="block-item-title">知识创建量</div>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 6px;width: 50%;">
                        <div class="fourTop">
                            <div style="padding-left: 20px;"><i style="color: #79B564"
                                                                class="layui-icon layui-icon-template-1"></i></div>
                            <div style="margin-left: 10px;">
                                <div><a class="number" style="color: #849daa;font-size: 18px;cursor: pointer;">345</a></div>
                                <div class="block-item-title">知识分享量</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="display: flex">
                    <div style="margin-top: 6px;width: 50%;">
                        <div class="fourBottom">
                            <div style="padding-left: 20px;"><i style="color: #79B564"
                                                                class="layui-icon layui-icon-template-1"></i></div>
                            <div style="margin-left: 10px;">
                                <div><a class="number" style="color: #2a7fff;font-size: 18px;cursor: pointer;">268</a></div>
                                <div class="block-item-title">知识阅读量</div>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top: 6px;width: 50%;">
                        <div class="fourBottom">
                            <div style="padding-left: 20px;"><i style="color: #79B564"
                                                                class="layui-icon layui-icon-template-1"></i></div>
                            <div style="margin-left: 10px;">
                                <div><a class="number" style="color: #65a94b;font-size: 18px;cursor: pointer;">55</a></div>
                                <div class="block-item-title">知识下载量</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="background: #FFFFFF;margin-top: 10px;">
                <div style="display: flex;border-bottom: 1px solid #F3F3F3;padding: 10px;">
                    <div style="background: #3393FC"><i style="color: white" class="layui-icon layui-icon-note"></i>
                    </div>
                    <div style="margin-left: 7px;">公文管理</div>
                </div>
                <div class="catListView">
                    <h3 class="catListTitle" style="text-align:center" id="title">阅读热度前15名</h3>
                    <div>
                        <ul>
                            <li>
                                <a title="E9-产品销售合同范本V测试">1、E9-产品销售合同范本V测试</a>
                                <span class="numClass">(76)</span>
                            </li>
                            <li>
                                <a title="1销售合同范本">2、1销售合同范本</a>
                                <span class="numClass">(29)</span>
                            </li>
                            <li>
                                <a title="湖南省国资委E9协同办公平台销售合同">3、湖南省国资委E9协同办公平台销售合同</a>
                                <span class="numClass">(18)</span>
                            </li>
                            <li>
                                <a title="上海纺织E9协同办公平台销售合同">4、上海纺织E9协同办公平台销售合同</a>
                                <span class="numClass">(17)</span>
                            </li>
                            <li>
                                <a title="诺基亚贝尔E9协同办公平台销售合同">5、诺基亚贝尔E9协同办公平台销售合同</a>
                                <span class="numClass">(14)</span>
                            </li>
                            <li>
                                <a title="E9-第三方产品采购合同范本V1.0">6、E9-第三方产品采购合同范本V1.0</a>
                                <span class="numClass">(11)</span>
                            </li>
                            <li>
                                <a title="1销售合同范本">7、1销售合同范本</a>
                                <span class="numClass">(11)</span>
                            </li>
                            <li>
                                <a title="上海莱士血液制品协同办公平台销售合同">8、上海莱士血液制品协同办公平台销售合同</a>
                                <span class="numClass">(11)</span>
                            </li>
                        </ul>
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
    // 基于准备好的dom，初始化echarts实例
//    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        color: ['#3398DB'],
        legend: {
            data: ['数量']
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'cross'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: ['客户案例', '解决方案', '项目文档', '产品知识', '技术文档', '品质管理', '合同文档', '公文档案', '咨询文档', '销售管理', '培训文档', '人事文档', '分享文档'],
                axisTick: {
                    alignWithLabel: true
                },
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow',
                },
                axisLabel: {
                    interval: 1
                }
            }
        ],
        yAxis: [
            {
                type: 'value',
            }
        ],
        series: [
            {
                name: '数量',
                type: 'bar',
                barWidth: '80%',
                data: [920, 830, 760, 695, 640, 580, 550, 500, 470, 450, 430, 400, 380]
            }
        ]
    };


    // 使用刚指定的配置项和数据显示图表。
//    myChart.setOption(option);

    $('#calendar').calendar({
        width: 380,
        height: 320,
        data: [
            {
                date: '2017/12/24',
                value: 'Christmas Eve'
            },
            {
                date: '2017/12/25',
                value: 'Merry Christmas'
            },
            {
                date: '2017/01/01',
                value: 'Happy New Year'
            }
        ],
        onSelected: function (view, date, data) {
            console.log('view:' + view)
            alert('date:' + date)
            console.log('data:' + (data || 'None'));
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
</script>
</html>