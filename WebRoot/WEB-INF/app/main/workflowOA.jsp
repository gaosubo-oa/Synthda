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
    <title><fmt:message code="sys.th.fede" /></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20201106.1"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/m_reset.css"/>

    <link rel="stylesheet" href="/css/main/intranetBlue.css">
    <%--${sessionScope.InterfaceModel}--%>
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/main_js/index.js"></script>
    <script src="/js/main_js/workflowOA.js?20190531.1"></script>
    <script src="/lib/drag/drag.js"></script>
    <style>
        .daibanbuttom .left p{
            font-size: 14pt;
        }
        .total .contain li:hover {
            background: #e8f4fc;
        }
        .daily_all li {
            margin-top: 0;
        }
        .richengHover:hover, .daibanHover:hover, .personInfo:hover, .rizhiHover:hover, .emailHover:hover {
            /* border: #fea8a8 1px solid; */
            box-shadow: 0 0 10px #47a4fb;
            z-index: 99;
        }
        .cont_main>ul>li {
            background: #fff!important;
        }
        .cont_main ul.total>li {
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }
        .s_head, .notice_head, .wenjian_head {
            font-size: 12pt;
        }
        .total .bg_head {
            cursor: all-scroll;
        }
        .daibans {
            height: 262px;
            background: #fff;
        }
        .daibantop {
            height: 131px;
        }
        .fl {
            float: left;
        }
        .daibans li {
            list-style: none;
        }
        .daibanbuttom {
            height: 131px;
        }
        .contain {
            border: none;
        }
        .contain {
            height: 294px;
        }

        .s_container, .tainer，, .s_cont {
            overflow-y: auto;
            height: 262px;
        }
        .e_mail li, .daily li, .tainer li, .new_total li {
            cursor: pointer;
        }
        .s_container ul li {
            font-size: 11pt;
            padding: 0 5px;
            width: auto;
        }
        .chedule_li {
            width: 100%;
            height: 41px !important;
            cursor: pointer;
            /* font-size: 11pt; */
        }
        .chedule_li div {
            float: left;
            margin-top: 7px;
            font-size: 11pt;
        }
        .every_times {
            width: 50%;
            line-height: 27px;
            color: #919191;
            text-align: right;
        }
        .c_head img {
            position: absolute;
            left: 7px;
            top: 8px;
        }
        .c_head a {
            display: block;
        }
        .richeng_title {
            width: 43%;
            line-height: 28px;
            margin-left: 4px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            /* font-size: 11pt; */
        }
        .e_title {
            font-size: 11pt!important;
            height: 20px;
            width:90%!important;
        }
        .d_title, .n_title{
            width:90%!important;
        }
        .c_all {
            width: 35px;
            height: 20px;
            background: #f0f0f0;
            color: #666;
            text-align: center;
            line-height: 20px;
            margin-top: 5px;
            border-radius: 4px;
            position: absolute;
            right: 169px;
            top: 2px;
        }
        .c_today {
            position: absolute;
            right: 129px;
            top: 2px;
        }
        .c_tom {
            position: absolute;
            right: 89px;
            top: 2px;
        }
        .c_nexttom {
            position: absolute;
            right: 49px;
            top: 2px;
        }
        .more {
            top: 2px;
            font-size: 12px;
        }
        .head_title, .c_today, .c_tom, .c_nexttom, .c_head a, .more_notice, .more_wenjian{
            border: #3c92e5 1px solid;
        }
        .more_notice, .more_wenjian{
            margin: 4px 0 4px 4px;
        }
        .wenjian_list li, .more_notice, .more_wenjian{
            font-weight: 300;
        }
        .s_container ul li {
            font-size: 11pt;
            padding: 0 5px;
            width: auto;
        }
        .chedule_all .chedule_li div {
            font-size: 11pt;
        }
        .r_title {
            width: 32% !important;
            color: #1b5e8d;
        }
        .accessory , .n_accessory , .d_accessory{
            top: 30px;
        }
        .daibanbuttom .right .top{
            font-size: 14pt;
            font-weight: bold;
        }
        .workflowNum{
            font-size: 21px!important;
            color: #fd770c;
            line-height: 31px;
        }

        .every_logo img{
            margin-top: 0;
        }
        .daiban{
            height:auto;
        }
        .RBleague{
            float: left;
            width: 49%;
            height:100%;
        }
        .redleague{
            border-right: 1px solid #b5b1b1;
        }
        #RBleagueBox .tainer{
            height:calc(100% - 35px);
        }
        .RBleagueLi .n_word{
            padding-left: 0px;
            width: 40%;
        }
        .RBleagueLi .n_name{
            width: 100%;
        }
        .RBleagueLi .n_img img{
            margin-left: 0;
        }
        .n_num{
            float: left;
            width: 36px;
            height: 100%;
            line-height: 50px;
            text-align: center;
            font-size: 12pt;
        }
        .n_num.specialF{
            color: #de9539;
            font-weight: 700;
        }
        .n_num.specialS{
            color: #b3b2b7;
            font-weight: 700;
        }
        .n_num.specialT{
            color: #dd978f;
            font-weight: 700;
        }
        .RBleagueLi .n_title{
            width: 100%!important;
            white-space: normal;
        }
    </style>

</head>
<body style="padding: 0;">
<div class="main cont_main" id="contmain_1" data-tabid="1" style="z-index: 0;height: 100%;">
    <ul class="total"  style="">

        <li id="01" class="contain middle con_daiban">
            <div class="notice_head bg_head">
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <span class="model">待办受理
                                </span>
            </div>
            <div class="tainer">
                <ul class="daiban"></ul>
            </div>
        </li>

        <li id="02" class="contain side con_new">
            <div class="s_head c_head bg_head">
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/icon_newsgrid.png" alt="">
                <span class="model">工作动态</span>
                <div class="richeng_check news_all" onclick="administrivia(this)">
                    全部
                </div>
                <div class="news_noread" onclick="administrivia(this)" data-bool="0">
                    未读
                </div>
                <span class="more more_news" tid="0117" url="news/index" onclick="parent.getMenuOpen(this)">
                <h2 class="hide">新闻</h2>
                                	<a>更多
                                	</a>
                                </span>
            </div>
            <div class="s_container c_container new_total">
                <ul class="new_all"></ul>
            </div>
        </li>

        <li id="RBleagueBox" class="contain middle con_daiban">
            <div class="notice_head bg_head">
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <span class="model">红黑榜
                                </span>
            </div>
            <div class="tainer">
                <ul class="RBleague redleague">
                    <li class="RBleagueLi">
                        <div class="n_num specialF">1.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">系统管理员</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时15秒">用时15秒<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num specialS">2.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">李华</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时17秒">用时17秒<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num specialT">3.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">白雪</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时21秒">用时21秒<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num">4.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">李然</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时54秒">用时54秒<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num">5.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">蔡方堃</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时1小时40分">用时1小时40分<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>

                    </li>
                </ul>
                <ul class="RBleague blackleague">
                    <li class="RBleagueLi">
                        <div class="n_num specialF">1.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">管理员</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时22天">用时22天<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num specialS">2.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">蔡李华</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时1天">用时1天<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num specialT">3.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">蔡白雪</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时2小时40分">用时2小时40分<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num">4.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">蔡李然</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时1小时50分">用时1小时50分<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>
                    </li>
                    <li class="RBleagueLi">
                        <div class="n_num">5.</div>
                        <div class="n_img"><img onerror="imgerror(this,1)" src="http://oa.jinhuijiu.com:8090/img/user/boy.png"></div>
                        <div class="n_word"><h1 class="n_name">蔡方堃</h1><a href="javascript:void(0)" data-id="undefined" class="windowopen"><h2 class="n_title" title="用时1小时40分">用时1小时40分<span>&nbsp;</span></h2></a><span style="position: absolute;right: 10px;top: 21px;color: #999;"></span></div>

                    </li>
                </ul>
            </div>
        </li>

        <li id="03" class="contain middle con_yiban">
            <div class="notice_head bg_head">
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <span class="model">已办受理
                                </span>
            </div>
            <div class="tainer">
                <ul class="yiban"></ul>
            </div>
        </li>

        <li id="04" class="contain middle con_daiban">
            <div class="notice_head bg_head">
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <span class="model">平台在办流程
                                </span>
            </div>
            <div class="tainer">
                <ul class="zaiban"></ul>
            </div>
        </li>

        <li id="05" class="contain side con_function">
            <div class="s_head bg_head">
                <span class="s_head_top"></span>
                <img class="changyong_img" src="/img/main_img/theme6/changyong.png" alt="">
                <span class="model" style="margin-left: 6px;">
                                	常用功能
                                </span>
                <!-- <span class="more"><a>管理</a></span> -->
            </div>
            <div class="s_container" id="application"></div>
        </li>
    </ul>
</div>
</body>
</html>
