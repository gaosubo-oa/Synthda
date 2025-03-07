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
    <title><fmt:message code="sys.th.fede"/></title>
    <%--<fmt:message code="global.page.first" />--%>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html;">
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/index.css?20220316"/>
    <link rel="stylesheet" type="text/css" href="/css/main/${sessionScope.InterfaceModel}/cont.css?20220316"/>
    <link rel="stylesheet" type="text/css" href="/css/main/theme1/m_reset.css"/>

    <link rel="stylesheet" href="/css/main/intranetBlue.css?20210311.1">
    <%--${sessionScope.InterfaceModel}--%>
    <script src="/js/common/language.js"></script>
    <script src="/js/xoajq/xoajq3.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery-migrate-3.4.0.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js"></script>
    <%--<script type="text/javascript" src="/js/main_js/index.js"></script>--%>
    <script src="/lib/drag/drag.js?20200403"></script>

    <script type="text/javascript" src="/lib/layui/layui/layui.all_v2.5.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/global.js?20201229.1"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableFilter.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableChild.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/lay/mymodules/tableMerge.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery-ui.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.iframe-transport.js"></script>
    <script type="text/javascript" src="/lib/jQuery-File-Upload-master/jquery.fileupload.js"></script>
    <script src="/lib/layui/layui/js/common.js?v=20190726" type="text/javascript" charset="utf-8"></script>
    <script src="/js/main_js/myOA.js"></script>

    <style>

        .daibanbuttom .left p {
            font-size: 14pt;
        }

        .daibanbuttom .leftOld p {
            font-size: 14pt;
        }

        .total .lis li:hover {
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

        .personInfos:hover {
            background-color: #4a9def;
        }

        .cont_main > ul > li {
            background: #fff !important;
        }

        .cont_main ul.total > li {
            background: #fff;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
        }

        .s_head, .notice_head, .wenjian_head {
            font-size: 12pt;
        }

        .total .bg_head {
            cursor: all-scroll;
        }

        .daibans {
            height: 262px;
            width: 100%;
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

        .s_container, .tainer, .s_cont, .daily {
            overflow-y: auto;
            height: 262px;
        }

        .e_mail li, .daily li, .tainer li, .new_total li {
            cursor: pointer;
        }

        .s_container ul li {
            font-size: 11pt;
            padding: 0 5px;
            /*width: auto;*/
            width: 100%;
            white-space: nowrap;
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
            width: 21%;
            line-height: 27px;
            color: #919191;
            text-align: right;
        }

        .every_timess {
            width: 50%;
            line-height: 5px;
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
            width: 70%;
            line-height: 28px;
            margin-left: 4px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .e_title {
            font-size: 11pt !important;
            height: 20px;
            width: 90% !important;
        }

        .d_title, .n_title {
            width: 90% !important;
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

        .head_title, .c_today, .c_tom, .c_nexttom, .c_head a, .more_notice, .more_wenjian {
            border: #3c92e5 1px solid;
        }

        .more_notice, .more_wenjian {
            margin: 4px 0 4px 4px;
        }

        .wenjian_list li, .more_notice, .more_wenjian {
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
            width: 45% !important;
            color: #1b5e8d;
        }

        .accessory, .n_accessory, .d_accessory {
            top: 30px;
        }

        .daibanbuttom .right .top {
            font-size: 14pt;
            font-weight: bold;
        }

        .workflowNum {
            font-size: 21px !important;
            color: #fd770c;
            line-height: 31px;
        }

        .workNums {
            font-size: 21px !important;
            color: #FF5722;
            line-height: 31px;
        }

        .workNum {
            font-size: 21px !important;
            color: #fd770c;
            line-height: 31px;
        }

        .every_logo {
            height: 117px
        }

        .every_logo img {
            margin-top: 9%;
        }

        .daibantop .right div > img {
            width: 40%;
            height: 40%;
            border-radius: 50%;
        }

        .iconTop{
            width: 20px;
        }
        .shuaxin{
            width: 15px;
        }

        .dangjian_flex{
            position: absolute;
            left: -210px;
            display: inline-flex;
        }

        .dangjian_more{
            position: absolute;
            float: left;
        }
        .e_img img, .d_img img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
        }

        .n_imgs img {
            width: 6px;
            height: 6px;
            margin-top: 30px;
            margin-left: 10px;
        }

        .n_words {
            width: 86%;
            height: 100%;
            margin-left: 6%;
        }

        .noticeType {
            width: 50px !important;
            height: 24px !important;
            line-height: 24px;
            margin-left: 10px;
            border: #3c92e5 1px solid !important;
        }

        .newType {
            height: 22px !important;
            line-height: 22px;
            margin-left: 10px;
            border: #3c92e5 1px solid !important;
        }

        .selectTy {
            width: 18%;
            max-width: 100px;
            height: 85.5%;
            font-size: 7.5pt;
            margin: 1px 5px;
        }

        .main::-webkit-scrollbar, .people_wenjian::-webkit-scrollbar {
            height: 8px;
        }

        .main::-webkit-scrollbar-thumb, .people_wenjian::-webkit-scrollbar-thumb {
            background-color: #c0c0c0;
        }

        .chedule_li .dydiv {
            position: absolute;
            right: 20px;
            top: 15px;
            font-size: 12px;
        }

        .taolunqu_title {
            line-height: 28px;
            margin-left: 6px;
        }

        .s_cont {
            height: 265px;
            overflow-y: auto;
        }

        .zhiweiOld {
            width: 100%;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
        }

        .e_word, .d_word, .n_word {
            width: calc(100% - 65px);
            height: 100%;
            margin-left: 2%;
            position: relative;
        }


        .divTxt, .divTxt2, .divTxt3 {
            margin: 5px 10px;
        }

        ol {
            list-style-type: decimal;
            margin-left: 15px;
        }

        .state {
            height: 70px;
            margin-left: 15px;
            margin-top: 10px;
        }

        .pen {
            width: 20px;
            height: 20px;
        }

        #revise {
            background-position: 5px 10px;
            padding-left: 30px;
            width: 220px;
            background-image: url("/img/menu/myOA/signature.png");
        }

        .an {
            margin-top: 30px;
            width: 250px;
            height: 55px;
            position: fixed;
            border-top: 1px solid rgb(238, 238, 238);

        }

        #save {
            width: 75px;
            height: 30px;
            position: absolute;
            top: 20px;
            left: 162px;
        }

        #revise {
            outline: none;
        }

        .penn:hover {
            background-color: rgb(235, 246, 255);
        }

    </style>

</head>
<body style="padding: 0;">
<div id="myTableGet" style="display:none">
    <li id="01" class="contain middle lis con_notice">
        <div class="notice_head bg_head">
                                <span class="s_head_top">
                                </span>
            <img src="/img/main_img/theme6/announce.png" alt="">
            <span class="model"><fmt:message code="notice.th.notice" /></span>
            <select name="noticeTypes" class="selectTy">
            </select>

            <ul class="notice_list" id="notice_listTwo" style="display: inline-flex">
                <img src="/img/refreshs.png" id="sx" onclick="announcement()" style="cursor: pointer;margin-left: -18%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="sxs" onclick="announcements()" style="display:none;cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">
                <li class="head_title sort actives" data-bool="" read="noRead" onclick="announcement(this)" id="all_notice" style="width: 38px;"><fmt:message code="email.th.unread"/></li>
                <li class="head_title sort " read="okRead" onclick="announcements(this)" id="yidus" data-bool=""><fmt:message code="email.th.read"/></li>
                <li class="head_title sort active" read="okReadAll" onclick="announcementsAll(this)" id="yiduAll" data-bool=""><fmt:message code="notice.th.all" /></li>
            </ul>
            <span class="more_notice" tid="0116" url="/notice/allNotifications" onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="notice.th.notice" /></h2>
                <a style="    color: #fff;"><fmt:message code="email.th.more"/></a>
                                </span>


        </div>
        <div class="tainer" style="position: relative">
            <%--    <ul class="notice_list" id="noticeTypes" style="left: 0px;margin-top: 5px;" >
               &lt;%&ndash;     <li class="head_title sort active actives noticeType" data-bool="01" onclick="announcement(this);announcements(this)"  >
                        通知
                    </li>
                    <li class="head_title sort noticeType" data-bool="02" onclick="announcement(this);announcements(this)" >
                        决定
                    </li>
                    <li class="head_title sort noticeType" data-bool="03"  onclick="announcement(this);announcements(this)">
                        通报
                    </li>
                    <li class="head_title sort noticeType" data-bool="04" onclick="announcement(this);announcements(this)" >
                        其他
                    </li>
                    <li class="head_title sort noticeType" data-bool="05" onclick="announcement(this);announcements(this)" >
                        推送
                    </li>&ndash;%&gt;
                </ul>--%>
            <%--<ul class="notify no_read_notice_two" style="margin-top: 30px;">--%>
            <ul class="notify no_read_notice_two">
            </ul>
        </div>
    </li>

    <li id="02" class="contain side lis con_new">
        <div class="s_head c_head bg_head" id="xinWen">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/icon_newsgrid.png" alt="">
            <span class="model model_news"><fmt:message code="main.news"/></span>
            <select name="newTypes" class="selectTy">
            </select>

            <ul class="notice_list" id="notice_listTwos" style="display: inline-flex">
                <img src="/img/refreshs.png" id="xin" onclick="administrivia()"
                     style="cursor: pointer;margin-left: -19%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="xins" onclick="administrivias()"
                     style="all_mdisplay:none;cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">

                <li class="head_title sort actives " data-id="1" id="xinnoRead" data-bool="" read="noRead" onclick="administrivia(this)" style="width: 38px;"><fmt:message code="email.th.unread"/>
                </li>
                <li class="head_title sort " data-id="2" read="okRead" id="xinokRead" onclick="administrivias(this)" data-bool=""><fmt:message code="email.th.read"/></li>
                <li class="head_title sort active" data-id="2" read="okReadAll" id="xinokReadAll" onclick="administriviasAll(this)" data-bool=""><fmt:message code="notice.th.all" /></li>
            </ul>
            <span name="news" class="more more_news" tid="0117" more_type="1" url="news/index"
                  onclick="parent.getMenuOpen(this)">
                <h2 class="hide hide_news"><fmt:message code="main.news" /></h2><a><fmt:message code="email.th.more"/></a></span>

            <%--<div>--%>
            <%--<div class="richeng_check news_all" read="noRead" data-bool="" onclick="administrivia(this)">未读</div>--%>
            <%--<div class="news_noread" read="okRead" onclick="administrivias(this)" data-bool="">已读</div>--%>
            <%--<span name="news" class="more more_news" tid="0117" more_type="1" url="news/index"--%>
            <%--onclick="parent.getMenuOpen(this)">--%>
            <%--<h2 class="hide">新闻</h2><a>更多</a></span>--%>
            <%--</div>--%>
        </div>

        <div class="s_container c_container new_total" style="position: relative">
            <%--<ul class="notice_list" id="newTypes" style="left: 0px;margin-top: 5px;height: auto" >--%>
            <%--&lt;%&ndash;  <li class="head_title sort active  newType" data-bool="01" onclick="administrivia(this);administrivias(this)"  >--%>
            <%--公司动态--%>
            <%--</li>--%>
            <%--<li class="head_title sort newType" data-bool="02" onclick="administrivia(this);administrivias(this)" >--%>
            <%--媒体关注--%>
            <%--</li>--%>
            <%--<li class="head_title sort newType" data-bool="03"  onclick="administrivia(this);administrivias(this)">--%>
            <%--行业资讯--%>
            <%--</li>--%>
            <%--<li class="head_title sort newType" data-bool="04" onclick="administrivia(this);administrivias(this)" >--%>
            <%--合作伙伴新闻--%>
            <%--</li>--%>
            <%--<li class="head_title sort newType" data-bool="05" onclick="administrivia(this);administrivias(this)" >--%>
            <%--客户新闻--%>
            <%--</li>--%>
            <%--<li class="head_title sort newType" data-bool="34224" onclick="administrivia(this);administrivias(this)" >--%>
            <%--新闻--%>
            <%--</li>&ndash;%&gt;--%>
            <%--</ul>--%>
            <%--<ul class="new_all" style="height: 72%;margin-top: 70px;">--%>
            <ul class="new_all" style="height: 72%;">
            </ul>
        </div>
    </li>

    <%--    领导指示精神--%>
    <li id="am" class="contain lis side con_new">
        <div class="notice_head bg_head">
                                <span class="s_head_top">
                                </span>
            <img src="/img/main_img/theme6/announce.png" alt="">
            <span class="model"><fmt:message code="mian.publication" /></span>
            <select name="lead" class="selectTy">
                <option data-bool="LDZSJS"><fmt:message code="mian.publication" /></option>
            </select>

            <ul class="notice_list" id="notice_listTwolead" style="display: inline-flex">
                <img src="/img/refreshs.png" id="sxlead" onclick="lead()"
                     style="cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="sxslead" onclick="leads()"
                     style="display:none;cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">

                <li class="head_title sort active actives" data-bool="" read="noRead" onclick="lead()"
                    style="width: 38px;"><fmt:message code="email.th.unread"/>
                </li>
                <li class="head_title sort " read="okRead" onclick="leads()" data-bool=""><fmt:message
                        code="email.th.read"/></li>
            </ul>
            <span class="more_notice" tid="0116" url="/notice/leadtions" onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="mian.publication" /></h2>
                <a style="    color: #fff;"><fmt:message code="email.th.more"/></a>
                                </span>


        </div>
        <div class="tainerlead" style="position: relative">
            <ul class="notify no_read_notice_twoam">
            </ul>
        </div>
    </li>


    <li id="2015" class="contain side lis con_new">
        <div class="s_head c_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/icon_newsgrid.png" alt="">
            <span class="model model_con_new"><fmt:message code="mian.externalNews" /></span>
        </div>
        <div class="s_container c_container new_total">
            <ul class="wznew_all">
            </ul>
        </div>
    </li>

    <li id="03" class="contain middle lis con_email">
        <div class="s_head c_head m_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/emailbox.png" alt="">
            <span class="model youjianxiang">
                                	<fmt:message code="notice.th.mail"/>
                                </span>
            <ul class="mail_title">
                <img src="/img/refreshs.png" id="em" onclick="youjian()"
                     style="cursor: pointer;margin-left: -20%;height: 16px;width: 16px;margin-top: -2px">

                <li class="head_title sort active" id="weidu" style="width: 42px;"><fmt:message code="email.th.unread"/>
                </li>
                <li class="head_title sort " id="yidu"><fmt:message code="email.th.read"/>
                </li>
                <li class="head_title sort" id="all_m"><fmt:message code="notice.th.all"/>
                </li>
            </ul>

            <span style="" class="more more_emil" tid="0101" url="email/index" onclick="parent.getMenuOpen(this)">
                                <h2 class="hide"><fmt:message code="main.email" /></h2>
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
        </div>
        <div class="e_mail">
            <ul class="all_mail" style="display: none">
            </ul>
            <ul class="no_read" style="display:block;">
            </ul>
            <ul class="read" style="display:none;">
            </ul>
        </div>
    </li>

    <li id="04" class="contain middle lis con_daiban">
        <div class="notice_head bg_head s_head c_head m_head ">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/backlog.png" alt="">
            <span class="model"><fmt:message code="workflow.th.BusinessApproval"/></span>
            <ul class="notice_list">
                <img src="/img/refreshs.png" id="yw" onclick="annount()"
                     style="cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="yws" onclick="announts()"
                     style="display:none;cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -2px">
                <li class="head_title sort active actives" data-bool="" onclick="annount(this)"
                    style="min-width: 38px;width: auto;">
                    <fmt:message code="attend.th.needDealt"/>
                </li>
                <li class="head_title sort " onclick="announts(this)" style="min-width: 38px;width: auto;">
                    <fmt:message code="attend.th.Have"/>
                </li>
            </ul>

            <span style="" class="more more_emil examine" tid="1020" url="/workflow/work/workList"
                  onclick="parent.getMenuOpen(this)">
                                <h2 class="hide"><fmt:message code="workflow.th.BusinessApproval"/></h2>
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
        </div>
        <div class="tainer">
            <ul class="daiban">
            </ul>
        </div>
    </li>

    <li id="06" class="contain side lis con_schedule">
        <div class="s_head c_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/schedule.png" alt="">
            <span class="model"> <fmt:message code="main.schedule"/></span>
            <span style=" position: absolute; right: 313px; width: 29px;height: 25px;">
                <img src="/img/refreshs.png" id="gw1" onclick="schedule()"
                     style="cursor: pointer;height: 16px;width: 16px;margin-top: -1px;">
            </span>
            <div style="right: 269px;" class="c_all " data-url="/schedule/getAllschedule" onclick="schedule(this)"><fmt:message
                    code="notice.th.all"/>
            </div>
            <div style="right: 225px;" class="c_today richeng_check" data-url="/schedule/getscheduleByDay" data-schedule="1"
                 onclick="schedule(this)"><fmt:message code="notice.th.Today"/>
            </div>
            <div style="width: 65px;right: 152px;" class="c_tom" data-url="/schedule/getscheduleByDay" data-schedule="2"
                 onclick="schedule(this)"><fmt:message code="main.th.Tomorrow"/>
            </div>
            <div style="width: 89px;right: 55px;" class="c_nexttom" data-url="/schedule/getscheduleByDay" data-schedule="3"
                 onclick="schedule(this)"><fmt:message code="main.th.AfterTomorrow"/>
            </div>
            <span class="more more_chedule" tid="0124" url="schedule/index" onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.schedule" /></h2>
											<a> <fmt:message code="global.lang.add"/></a>
								</span>
        </div>
        <div class="s_container c_container">
            <ul class="chedule_all">
            </ul>
        </div>
    </li>

    <li id="07" class="contain lis side con_function">
        <div class="s_head bg_head">
            <span class="s_head_top"></span>
            <img class="changyong_img"
                 src="/img/main_img/theme6/changyong.png" alt="">
            <span class="model" style="margin-left: 6px;">
                                	<fmt:message code="main.th.function"/>
                                </span>
            <!-- <span class="more"><a>管理</a></span> -->
        </div>
        <div class="s_container" id="application">

        </div>
    </li>

    <li id="08" class="contain lis side con_daily">
        <div class="s_head d_head bg_head">
            <span class="s_head_top"></span>

            <img src="/img/main_img/theme6/log.png" alt="">
            <span class="model"><fmt:message code="email.th.log"/></span>
            <ul class="daily_all">
                <img src="/img/refreshs.png" onclick="rizhis()"
                     style="cursor: pointer;margin-left: -26%;height: 16px;width: 16px;margin-top: -5px">

                <li class="my_daily active">
                    <fmt:message code="diary.th.own"/>
                </li>
            </ul>
            <span class="more_daily" tid="0128" url="diary/index" onclick="parent.getMenuOpen(this)">
                                	<a class="daily_more">
                                        <h2 class="hide"><fmt:message code="main.worklog" /></h2>
                                		<fmt:message code="email.th.more"/>
                                	</a>
                                </span>
        </div>
        <div class="daily">
            <ul class="all_daily">
            </ul>
        </div>
    </li>


    <li id="09" class="contain lis side con_file">
        <div class="wenjian_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/fliebox.png" alt="">
            <span class="model"><fmt:message code="file.th.file"/></span>
            <ul class="wenjian_list">
                <img src="/img/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=0" id="wj" onclick="fileCabinet(this)"
                     style="cursor: pointer;margin-left: -18%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" data-url="/newFilePri/getPriFileSort" id="wjs" onclick="fileCabinets()"
                     style="display:none;cursor: pointer;margin-left: -18%;height: 16px;width: 16px;margin-top: -2px">
                <li class="head_title sort active actives" onclick="fileCabinet(this)"
                    data-url="/newFilePub/getNewAllPrivateFile?sortId=0">
                    <fmt:message code="main.th.PublicFile" />
                </li>
                <li class="head_title sort" onclick="fileCabinets(this)"
                    data-url="/newFilePri/getPriFileSort">
                    <fmt:message code="main.th.PersonalFile" />
                </li>
            </ul>

            <span class="wenjian_span more_wenjian fileHome" tid="3001" url="/newFilePub/fileCabinetHome?0" onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.public" /></h2>
                                	<a style="color: #000;">
                                		<fmt:message code="email.th.more"/>
                                	</a>
                                </span>
        </div>
        <div class="s_cont">
            <ul class="pets_wenjian">
            </ul>
        </div>
    </li>

    <li id="10" class="contain lis side con_net">
        <div class="wenjian_head bg_head" style="position: relative;">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/webdisk.png" alt="">
            <span class="model"><fmt:message code="main.network"/></span>
            <ul class="wenjian_list">

            </ul>
            <span style="position: absolute;right: 48px;width: 30px;height: 30px; top: 0px;">
                <img src="/img/refreshs.png" onclick="wangluoyingpan(this)"
                     style="cursor: pointer;height: 16px;width: 16px;margin-top: 2px">
            </span>
            <span class="wenjian_span more_wenjian" tid="3010" url="/netdiskSettings/networkHardDisk?0"
                  onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.network" /></h2>
                <a style="color: #fff;"><fmt:message code="email.th.more"/></a>
            </span>
        </div>
        <div class="s_cont">
            <ul class="pets_yingpan" style="height: 100%;overflow-y: auto;">
            </ul>
            <ul class="people_yingpan" style="display:none;">
            </ul>

        </div>
    </li>

    <li id="11" class="contain lis side con_new">
        <div class="s_head c_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/commonTheme/theme6/icon_myMeeting.png" alt="" width="15px" height="15px" style="top: 10px;">
            <div style="width: 48px;" class="richeng_check news_all" read="noRead" data-bool="" onclick="">
                <fmt:message code="email.th.unread"/>
            </div>
            <div class="news_noread" read="okRead" onclick="" data-bool="">
                <fmt:message code="email.th.read"/>
            </div>
            <span class="model"><fmt:message code="dem.th.ConferenceNotice"/></span>

            <span class="more more_meeting" tid="601001" url="meeting/meetingList" onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.th.meet" /></h2>
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
        </div>
        <div class="s_container c_container new_total">
            <ul class="meeting">
            </ul>
        </div>
    </li>

    <li id="12" class="contain side lis con_new">
        <div class="s_head c_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/backlog.png" alt="">
            <span class="model"><fmt:message code="mian.matters" /></span>
            <div class="richeng_check news_all" onclick="adminiStrivias(this)">
                <fmt:message code="mian.toBeRead" />
            </div>
            <div class="news_noread" onclick="adminiStrivis(this)" data-bool="0">
                <fmt:message code="mian.haveRead" />
            </div>
            <span class="more more_new" tid="0117" url="ToBeReadController/toReadFile"
                  onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="mian.matters" /></h2>
                <a><fmt:message code="email.th.more"/></a>
            </span>
        </div>
        <div class="s_container c_container new_total">
            <ul class="new_alls">
            </ul>
        </div>
    </li>

    <li id="05" class="contain side lis con_daily">
        <div class="s_head d_head bg_head c_head">
            <span class="s_head_top"></span>
            <img style="width: 18px;height: 18px;" src="/img/commonTheme/theme6/doctment.png" alt="">
            <span class="model"><fmt:message code="email.th.document" /></span>
            <ul class="notice_list">
                <img src="/img/refreshs.png" id="gw" onclick="amange()"
                     style="cursor: pointer;margin-left: -11%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="gws" onclick="amanges()"
                     style="display:none;cursor: pointer;margin-left: -10%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="gl" onclick="amanget()"
                     style="display:none;cursor: pointer;margin-left: -10%;height: 16px;width: 16px;margin-top: -2px">
                <img src="/img/refreshs.png" id="gls" onclick="amangets()"
                     style="display:none;cursor: pointer;margin-left: -10%;height: 16px;width: 16px;margin-top: -2px">
                <li class="head_title sort active actives" data-bool="" url="\/document\/makeADraft" urls="0"
                    oldmenuUrl="document\/send\/backlog"
                    onclick="amange(this)" style="width: 48px;overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;">
                    <fmt:message code="doc.th.To-doList"/>
                </li>
                <li class="head_title sort " url="document\/inAbeyance" urls="1" onclick="amanges(this)" style="width: 48px;overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;" oldmenuUrl="document\/recv\/backlog">
                    <fmt:message code="main.communicationsToBeSubmitted" />
                </li>
                <li class="head_title sort " url="\/document\/IthasBeenDone" urls="2" onclick="amanget(this)" style="width: 48px;overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;" oldmenuUrl="document\/send/have">
                    <fmt:message code="doc.th.AlreadyDocument"/>
                </li>
                <li class="head_title sort " url="document\/received" urls="3" onclick="amangets(this)" style="width: 48px;overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;" oldmenuUrl="document\/recv/have">
                    <fmt:message code="main.communicationReceived" />
                </li>
            </ul>

            <span style="" class="more more_emild" tid="1020" url="\/document\/makeADraft" onclick='documentMore(this)'>
                                <h2 class="hide"><fmt:message code="main.document"/></h2>
                                	<a><fmt:message code="email.th.more"/></a>
                                </span>
        </div>
        <div class="daily">
            <ul class="gongwen"></ul>
        </div>
    </li>
    <%--今日看板--%>
    <li id="00" class="contain side  con_daily" style="display: none;">
        <div class="notice_head bg_head">
                                <span class="s_head_top">
                                </span>
            <img src="/img/main_img/theme6/ease.png" alt="">
            <span class="model"><fmt:message code="main.th.todayThekanban"/>
                                </span>
        </div>
        <div class="daibans" style="position: relative">
            <div style="width: 100%;height: 50%;margin-left:1px">
                <ul class="daibantop">
                    <li class="fl right personInfo">
                        <%--<div class="clearfix">--%>
                        <div style="float: left;width:100%;height: 100%;box-sizing: border-box;cursor: pointer;"
                             onclick="parent.getMenuOpen(this)" menu_tid="0140" data-url="/controlpanel/index">
                            <div>
                                <img class="fl nameurlOld" id="nameurlOld" src="/img/user/boy.png" alt=""
                                     style="position: relative;margin-top:10%;margin-left:30%"
                                     onerror="imgerror(this,1)">
                                <span class="fl" style="width: 60%;margin-left:50% ;margin-top:0%;">
                                <strong></strong>
                                <label style="cursor: pointer;" class="zhiwei"></label>
                                 <h2 class="hide"><fmt:message code="mian.panel" /></h2>
                            </span>
                            </div>
                        </div>
                        <%--</div>--%>
                    </li>
                    <li class="fl rights personInfo" style="cursor:pointer;%;background-color:#fff ">
                        <p class="top" style="margin-top:13px;margin-left:15px;font-size: 14pt;font-weight: bold;">
                            <fmt:message code="main.signatureOfPersonality" /></p>
                        <%--                            <fmt:message code="main.th.motto"/>--%>
                        <%--                        <textarea rows="4" cols="20"--%>
                        <%--                                  style="width:80%;height:60%;margin-left:35px;margin-top:10px;border:none;cursor:pointer;font-size:15px;resize:none;border-color:#fff "--%>
                        <%--                                  id="remark" onblur="disFuction(this)"></textarea>--%>
                        <div class="state" style="display: inline-block">
                            <%--                            <textarea id="remark" onblur="disFuction(this)">123</textarea>--%>

                        </div>
                        <div id="pen" class="pen" style="display: inline-block">
                            <img src="/img/menu/myOA/titleIcon.png" alt=""/>
                        </div>

                    </li>
                </ul>
            </div>
            <ul class="daibanbuttom clearfix" style="width: 100%;margin-left: 1px">
                <li class="fl left1 personInfo" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="1020" data-url="/workflow/work/workList">
                    <p style="margin-top: 34px;"><fmt:message code="main.to-doList" /></p>
                    <p style="margin-top: 5px;"><span class="workflowNum" style="font-size: 20pt;color:#3794cf"></span>
                    </p>
                    <h2 class="hide"><fmt:message code="main.to-doList" /></h2>
                </li>

                <li class="fl left personInfo" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="650105" data-url="/document/makeADraft">
                    <p style="margin-top: 34px;color:#3794cf"><fmt:message code="doc.th.To-doList"/></p>
                    <p style="margin-top: 5px;"><span class="workNum" style="font-size: 20pt;color:#3794cf"></span></p>
                    <h2 class="hide"><fmt:message code="main.oDoPost" /></h2>
                </li>
                <li class="fl lefts personInfo " style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="650505" data-url="/document/inAbeyance">
                    <p style="margin-top: 34px;"><fmt:message code="main.communicationsToBeSubmitted" /></p>
                    <p style="margin-top: 5px;"><span class="workNums" style="font-size: 20pt;color:#3794cf"></span></p>
                    <h2 class="hide"><fmt:message code="main.communicationsToBeSubmitted" /></h2>
                </li>

                <li class="fl left2 personInfo" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="0101" data-url="/email/index">

                    <%--<div class="fr " onclick="parent.getMenuOpen(this)" menu_tid="0101"  style="cursor:pointer;text-align: center;box-sizing: border-box;height: 100%;width: 30%;float: left;">--%>
                    <p style="margin-top: 34px;color:#3794cf"><fmt:message code="email.th.unreadmail"/></p>
                    <p style="margin-top: 8px;"><span class="worknums" style="font-size:17pt;color:#3794cf"></span></p>

                    <%--<img style="width: 50px;height:28px;margin-top: 42px;margin-left:42px;position: static;border-radius: 0;" src="/img/main_img/emaildianji.png" alt="">--%>
                    <%--<label style="color: #2a79d5;display: block;font-size: 11pt;margin-right:-85px;">写邮件</label>--%>
                    <h2 class="hide"><fmt:message code="notice.th.mail" /></h2>
                    <%--</div>--%>
                </li>

            </ul>
        </div>
    </li>
    <li id="0b" class="middle con_notice"
        style="float:left;height:294px;border:none;min-height: 200px;margin-left: 1.3%;margin-top: 1%;">
        <div class="notice_head bg_head">
                                <span class="s_head_top">
                                </span>
            <img src="/img/main_img/theme6/ease.png" alt="">
            <span class="model"><fmt:message code="main.th.todayThekanban" /></span>
        </div>
        <div class="daibans">
            <ul class="daibantop clearfix" style="">
                <li class="fl left richengHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="0124" data-url="/schedule/index">
                    <h4 style="margin: 0 auto;font-size: 16pt;;color: #fff;padding-top: 39px;font-weight:bold">
                        16:10:05</h4>
                    <h3 style="margin: 0 auto;font-size: 12pt;;color: #fff;padding-top: 10px;font-weight:bold">
                        2019-04-10 </h3>
                    <span style="color: #fff;margin-top: 5px;"></span>
                    <h2 class="hide"><fmt:message code="main.schedule" /></h2>
                </li>
                <li class="fl rightOld">
                    <div class="clearfix">
                        <div class="personInfo"
                             style="float: left;width: 70%;height: 100%;box-sizing: border-box;cursor: pointer;"
                             onclick="parent.getMenuOpen(this)" menu_tid="0140" data-url="/controlpanel/index">
                            <img class="fl nameurl" id="nameurl" src="/img/user/boy.png" alt=""
                                 style="position: static;margin-top: 40px;margin-left: 3%;border-radius:50%;width: 65px;height: 65px"
                                 onerror="imgerror(this,1)">
                            <span class="fl" style="margin-left:10px ;margin-top: 50px;width: 54%">
                                <strong style="font-size: 14pt;"></strong>
                                <label style="cursor: pointer;font-size: 12pt;margin-top: 6px;"
                                       class="zhiweiOld"></label>
                                 <h2 class="hide"><fmt:message code="mian.panel" /></h2>
                            </span>
                        </div>

                        <div class="fr emailHover" onclick="parent.getMenuOpen(this)" menu_tid="0101" data-url="email"
                             style="cursor:pointer;text-align: center;box-sizing: border-box;height: 100%;width: 30%;
    float: left;">
                            <img style="width: 45px;margin-top: 50px;position: static;border-radius: 0;"
                                 src="/img/main_img/emaildianji.png" alt="">
                            <label style="margin: 0;color: #2a79d5;display: block;
font-size: 11pt;"><fmt:message code="email.title.waitmail" /></label>
                            <h2 class="hide"><fmt:message code="notice.th.mail" /></h2>
                        </div>
                    </div>
                </li>
            </ul>
            <ul class="daibanbuttom clearfix">
                <li class="fl leftOld daibanHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="1020" data-url="/workflow/work/workList">
                    <p style="margin-top: 34px;"><fmt:message code="attend.th.needDealt" /> : </p>
                    <p style="margin-top: 5px;"><span class="workflowNumOld" style="font-size: 20pt;"></span></p>
                    <h2 class="hide"><fmt:message code="main.mywork" /></h2>
                </li>
                <li class="fl right rizhiHover" style="cursor:pointer;" onclick="parent.getMenuOpen(this)"
                    menu_tid="0128" data-url="/diary/index">
                    <p class="top" style="margin-top: 32px;"><fmt:message code="diary.th.personLog" />:</p>
                    <p class="buttom"></p>
                    <h2 class="hide"><fmt:message code="main.worklog" /></h2>
                </li>
            </ul>
        </div>

        <div></div>
    </li>
    <%--    讨论区--%>
    <li id="14" class="contain side lis con_talk">
        <div class="s_head c_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/backlog.png" alt="">
            <span class="model"><fmt:message code="main.discussionArea" /></span>
            <span style="position: absolute;right: 48px;width: 30px;height: 30px; top: 0px;">
                <img src="/img/refreshs.png" id="tlq" onclick="talkAbout()"
                     style="cursor: pointer;height: 16px;width: 16px;margin-top: 2px">
            </span>
            <span class="more more_talk" tid="3020" url="bbs/index" onclick="parent.getMenuOpen(this)">
                 <h2 class="hide"><fmt:message code="main.discussionArea" /></h2>
                    <a><fmt:message code="email.th.more" /></a>
            </span>

        </div>
        <div class="s_container c_container new_total">
            <ul class="new_talk">
            </ul>
        </div>
    </li>

    <li id="98" class="contain middle lis con_notice edu_con_notice98" style="display: none">
        <div class="notice_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/announce.png" alt="">
            <span class="model"><fmt:message code="main.disclosureOfPartyAffairs" /></span>
            <ul class="notice_list" id="dangwu_listTwo">
                <li class="head_title sort active actives" data-bool="" onclick="dangwuopen(this)" id="all_dangwu"
                    style="width: 38px;">
                    <fmt:message code="notice.th.all" />
                </li>
            </ul>
            <span class="more_notice" menu_tid="0133" url="/partaffairsjsp/AffairsQuery"
                  onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.disclosureOfPartyAffairs" /></h2>
                    <a style="color: #fff;"><fmt:message code="email.th.more" /></a>
                </span>
        </div>
        <div class="tainer">
            <ul class="notify dangwuopen"></ul>
        </div>
    </li>
    <li id="99" class="contain middle lis con_notice edu_con_notice99" style="display: none">
        <div class="notice_head bg_head">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/announce.png" alt="">
            <span class="model"><fmt:message code="main.disclosureOfSchoolAffairs" /></span>
            <ul class="notice_list" id="xiaowu_listTwo">
                <li class="head_title sort active actives" data-bool="" onclick="xiaowuOpen(this)" id="all_xiaowu"
                    style="width: 38px;">
                    <fmt:message code="notice.th.all" />
                </li>
            </ul>
            <span class="more_notice" menu_tid="0134" url="/partaffairsjsp/SchoolAffairsQuery"
                  onclick="parent.getMenuOpen(this)">
                <h2 class="hide"><fmt:message code="main.disclosureOfSchoolAffairs" /></h2>
                    <a style="color: #fff;"><fmt:message code="email.th.more" /></a>
                </span>
        </div>
        <div class="tainer">
            <ul class="notify xiaowuOpen"></ul>
        </div>
    </li>

    <%--    自定义告示栏1--%>
    <li id="17" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="s_head bg_head">
            <div>
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="" style="float: left;margin-left: 5px;
    margin-top: 5px;">
                <strong><span class=" rigitem1" style="position: absolute;
    white-space: nowrap;margin-left: 5px;font-weight: bold;"></span></strong>
            </div>
            <div class="divContent">
                <div class="divTxt">
                </div>
            </div>
        </div>

    </li>
    <%--自定义告示栏2--%>
    <li id="18" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="s_head bg_head">
            <div>
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="" style="float: left;margin-left: 5px;
    margin-top: 5px;">
                <strong><span class=" rigitem2" style="position: absolute;
    white-space: nowrap;margin-left: 5px;font-weight: bold;"></span></strong>
            </div>
            <div class="divContent2">
                <div class="divTxt2">
                </div>
            </div>
        </div>

    </li>
    <%-- 自定义告示栏3--%>
    <li id="19" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="s_head bg_head">
            <div>
                <span class="s_head_top"></span>
                <img src="/img/main_img/theme6/backlog.png" alt="" style="float: left;margin-left: 5px;
    margin-top: 5px;">
                <strong><span class=" rigitem3" style="position: absolute;
    white-space: nowrap;margin-left: 5px;font-weight: bold;"></span></strong>
            </div>
            <div class="divContent3">
                <div class="divTxt3">
                </div>
            </div>
        </div>

    </li>


    <%--    自定义告示栏1机关党建--%>
    <li id="21" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="wenjian_head bg_head tab_active">
            <span class="s_head_top"></span>
<%--            <img class="shuxian" src="/img/main_img/myOA/shuxian.png" alt="" style="left: 0px;top: 22px">--%>
            <img src="/img/main_img/myOA/gaoshi.png" alt="" style="float: left;" class="iconTop">
            <span class="model"><fmt:message code="main.partyBuildingInGovernmentOrgans" /></span>
            <ul class="wenjian_list">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=1119" id="" onclick="organPartyBuilding(this)"
                     style="cursor: pointer;margin-top: -2px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=922" id="" onclick="organPartyBuilding(this)"
                     style="display:none;cursor: pointer;margin-top: -2px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=923" id="" onclick="organPartyBuilding(this)"
                     style="display:none;cursor: pointer;margin-top: -2px" class="shuaxin">
                <div id="dangjian_list" class="dangjian_flex">
                    <li class="head_title sort active actives hei" onclick="organPartyBuilding(this)" data-url="/newFilePub/getNewAllPrivateFile?sortId=1119"
                        urls="/newFilePub/DefineMenu?sortId=1119" style="" title="<fmt:message code="main.studyOfPartyHistory" />"><fmt:message code="main.studyOfPartyHistory" /></li>
                    <li class="head_title sort" onclick="organPartyBuilding(this)" data-url="/newFilePub/getNewAllPrivateFile?sortId=922"
                        urls="/newFilePub/DefineMenu?sortId=922"  style="" title="<fmt:message code="main.partyBuildingInGovernmentOrgans" />"><fmt:message code="main.partyBuildingInGovernmentOrgans" /></li>
                    <li class="head_title sort" onclick="organPartyBuilding(this)" data-url="/newFilePub/getNewAllPrivateFile?sortId=923"
                        urls="/newFilePub/DefineMenu?sortId=923"  title="<fmt:message code="main.partyConductAndCleanGovernment" />"><fmt:message code="main.partyConductAndCleanGovernment" /></li>
                </div>
                <span id="organMore" class="head_title sort dangjian_more" tid="3001" url="\/newFilePub\/fileCabinetHome" title="<fmt:message code="email.th.more" />" onclick="organMore(this)">
                <h2 class="hide"><fmt:message code="main.partyBuildingInGovernmentOrgans" /></h2>
                                	<a style="color: #2b7fe0;">
                                		<fmt:message code="email.th.more" />
                                	</a>
                                </span>
            </ul>

            <div class="divContent" style="margin-top: 20px">
                <div class="divTxt">
                </div>
            </div>
        </div>

        <div class="s_cont">
            <ul class="jiguan"></ul>
        </div>
    </li>
    <%--自定义告示栏2工作动态--%>
    <li id="20" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="wenjian_head bg_head">
            <span class="s_head_top"></span>
<%--            <img class="shuxian" src="/img/main_img/myOA/shuxian.png" alt="" style="left: 0px;top: 22px">--%>
            <img src="/img/main_img/myOA/gaoshi.png" alt="" style="float: left;" class="iconTop">
            <span class="model">main.workDynamics</span>
            <ul class="wenjian_list">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=0&read=&sendTime=&_=1672310541585" id="" onclick="dynamicState(this)"
                     style="cursor: pointer;margin-top: -2px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=1&read=&sendTime=&_=1672310541587" id="" onclick="dynamicState(this)"
                     style="display:none;cursor: pointer;margin-top: -2px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=2&read=&sendTime=&_=1672310541589" id="" onclick="dynamicState(this)"
                     style="display:none;cursor: pointer;margin-top: -2px" class="shuaxin">
                <div id="" class="dangjian_flex">
                    <li class="head_title sort active actives hei" onclick="dynamicState(this)" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=0&read=&sendTime=&_=1672310541585" style="" title="<fmt:message code="notice.th.all" />"><fmt:message code="notice.th.all" /></li>
                    <li class="head_title sort" onclick="dynamicState(this)" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=1&read=&sendTime=&_=1672310541587"  title="<fmt:message code="main.bureauOffice" />"><fmt:message code="main.bureauOffice" /></li>
                    <li class="head_title sort" onclick="dynamicState(this)" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=2&read=&sendTime=&_=1672310541589" style="margin-right: 5px;" title="<fmt:message code="main.generalAffairsOffice" />"><fmt:message code="main.generalAffairsOffice" /></li>
                    <%--                    <li class="head_title sort" onclick="organPartyBuilding(this)" data-url="/myNotice/notifyManage?specifyTable=3&page=1&pageSize=10&useFlag=true&typeId=3" style="margin-top: 19px;margin-right: 5px;" title="安全监察处">安全监察处</li>--%>
                </div>
                <span class="head_title sort dangjian_more" tid="0119" url="/myNotice/myAllNotifications?notice_type=3" title="<fmt:message code="email.th.more" />" onclick="parent.getMenuOpen(this)">
                <h2 class="hide">main.workDynamics</h2>
                                	<a style="color: #2b7fe0;">
                                		<fmt:message code="email.th.more" />
                                	</a>
                                </span>
            </ul>

            <div class="divContent" style="margin-top: 20px">
                <div class="divTxt">
                </div>
            </div>
        </div>

        <div class="s_cont">
            <ul class="dynamic_state"></ul>
        </div>
    </li>
    <%-- 自定义告示栏3办公管理--%>
    <li id="22" class="contain side lis con_talk" style="overflow-y: auto;overflow-x: hidden">
        <div class="wenjian_head bg_head tab_active">
            <span class="s_head_top"></span>
<%--            <img class="shuxian" src="/img/main_img/myOA/shuxian.png" alt="" style="left: 0px;top: 22px">--%>
            <img src="/img/main_img/myOA/gaoshi.png" alt="" style="float: left;" class="iconTop">
            <span class="model"><fmt:message code="main.officeManagement" /></span>
            <ul class="wenjian_list">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=797" id="" onclick="officeManage(this)"
                     style="cursor: pointer;margin-top: -2px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" data-url="/newFilePub/getNewAllPrivateFile?sortId=76" id="" onclick="officeManage(this)"
                     style="display:none;cursor: pointer;margin-top: -2px" class="shuaxin">
                <div id="office_list"  class="" style="position: absolute;display:inline-flex;left: -95px;">
                    <li class="head_title sort active actives hei" onclick="officeManage(this)" data-url="/newFilePub/getNewAllPrivateFile?sortId=797"
                        urls="/newFilePub/DefineMenu?sortId=797" style="" title="<fmt:message code="dem.th.fileManagement" />"><fmt:message code="dem.th.fileManagement" /></li>
                    <li class="head_title sort" onclick="officeManage(this)" data-url="/newFilePub/getNewAllPrivateFile?sortId=76"
                        urls="/newFilePub/DefineMenu?sortId=76"  title="<fmt:message code="meet.th.management" />"><fmt:message code="meet.th.management" /></li>
                    <%--                    <li class="head_title sort" onclick="officeManage(this)" data-url="" style="margin-top: 19px;margin-right: 5px;" title="值班值守">值班值守</li>--%>
                </div>
<%--                <span id="office_more" class="head_title sort dangjian_more" tid="3001" url="" title="更多" onclick="officeMore(this)">--%>
<%--                <h2 class="hide">办公管理</h2>--%>
<%--                                	<a style="color: #6c6c6c;">--%>
<%--                                		更多--%>
<%--                                	</a>--%>
<%--                                </span>--%>
            </ul>

            <div class="divContent" style="margin-top: 20px">
                <div class="divTxt">
                </div>
            </div>
        </div>

        <div class="s_cont">
            <ul class="office_manage"></ul>
        </div>
    </li>

    <%--    速卓平台待办入口--%>
    <li id="23" class="contain middle lis con_daiban">
        <div class="wenjian_head bg_head s_head c_head m_head ">
            <span class="s_head_top"></span>
            <img src="/img/main_img/theme6/backlog.png" alt="" class="iconTop">
            <span class="model">速卓审批</span>
            <ul class="" style="top: 3px;position: absolute;right: 10px;">
                <img src="/img/main_img/myOA/refreshs.png" id="stayIcon" onclick="suzhuoStay()" style="cursor: pointer;margin-left: -26%;margin-top: 0px" class="shuaxin">
                <img src="/img/main_img/myOA/refreshs.png" id="doneIcon" onclick="suzhuoDone()" style="cursor: pointer;margin-left: -26%;margin-top: 0px" class="shuaxin">
                <li class="head_title sort active actives" data-bool="" onclick="suzhuoStay()"><fmt:message code="attend.th.needDealt"/></li>
                <li class="head_title sort" data-bool="" onclick="suzhuoDone()"><fmt:message code="attend.th.Have"/></li>
            </ul>

<%--            <span style="" class="more more_emil examine" tid="1020" url="/workflow/work/workList" onclick="parent.getMenuOpen(this)" style="top: 19px">--%>
<%--                                <h2 class="hide"><fmt:message code="workflow.th.BusinessApproval"/></h2>--%>
<%--                                	<a><fmt:message code="email.th.more"/></a>--%>
<%--                                </span>--%>
        </div>
        <div class="tainer suzhuoTainer">
            <ul class="suzhuo">
            </ul>
        </div>
    </li>
</div>
<div class="main cont_main" id="contmain_1" data-tabid="1" style="z-index: 0;height: 100%;">
    <ul class="total" style="min-width: 1200px;">

    </ul>
</div>
<script>
<%--    判断是否为七匹狼项目--%>

<%--<link rel="stylesheet" href="/css/main/intranetBlue.css?20210311.1">--%>
    $.get('/syspara/selectTheSysPara?paraName=MYPROJECT', function (res) {
        if(res.flag){
            qiParaValue = res.object[0].paraValue
            if(qiParaValue == 'septwolves' ){
                $.ajax({
                    type:'post',
                    url:'/users/getUserTheme',
                    dataType:'json',
                    success:function(res){
                        if(res.flag && res.object != null) {
                            if (res.object.theme == 5) {
                                jQuery('head').append('<link>');
                                a = jQuery('head').children(':last');
                                a.attr({
                                    rel: 'stylesheet',
                                    type: 'text/css',
                                    href: '/css/main/intranegreen.css?20220918'
                                });
                            }
                        }
                    }
                });
            }
        }
    });

    layui.use('layer', function () { //独立版的layer无需执行这一句
        var layer = layui.layer
        var signature;
        var tu
        var lu
        var cvb
        var val = ''
        var img
        var urlImg
        var imgUrl
        var imgUrl0
        var imgUrl1
        $.ajax({
            type: "post",
            url: "/users/getUserTheme",
            dataType:'json',
            data:'',
            async:false,
            success:function(res){
                if(res.flag){
                    if(res.object.theme == '20'){
                        window.location.href="/common/myOA2";
                    }
                }
            }
        })
        $('#pen').click(function () {
            layer.open({
                type: 1 //此处以iframe举例
                ,
                title: ''
                ,
                area: ['250px', '384px']
                ,
                shade: 0
                ,
                content: '<div>\n' +
                    '<input id="revise" onchange="myFunction()" placeholder="说说你的办公状态吧" style="border: 0; background-color: rgb(235,246,255); ' +
                    'height: 40px; background-repeat:no-repeat"></input>\n' +
                    '           <ul id="ul1">\n' +
                    '              <li value="1" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/1.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">认真办公中</p>' +
                    '               </li>\n' +
                    '              <li value="2" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/2.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">休息充电中</p>' +
                    '                   </li>\n' +
                    '              <li value="3" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/3.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">出差办事中</p>' +
                    '                   </li>\n' +
                    '              <li value="4" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/4.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">学习提高中</p>' +
                    '                   </li>\n' +
                    '              <li value="5" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/5.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">生病难受中</p>' +
                    '                   </li>\n' +
                    '              <li value="6" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/6.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">总结报告中</p>' +
                    '                   </li>\n' +
                    '              <li value="7" class="penn" style=" padding-left: 10px; line-height: 30px; height: 30px; margin-top: 5px;">' +
                    '                   <img class="pen" src="/img/menu/myOA/7.png" alt="" /> ' +
                    '                   <p style="display: inline-block;margin-left: 10px;" class="listItem">开会中</p>' +
                    '                   </li>\n' +
                    '           </ul>\n' +
                    '    <div class="an">\n' +
                    '            <button id="save" class="layui-btn" type="button">保存</button>\n' +
                    '    </div>\n' +
                    '       </div>'
                ,success:function(){
                    $.ajax({
                        type: 'get',
                        dataType: "JSON",
                        url: "/selectKanBan"
                        , success: function (data) {
                            signature = data.object;
                            imgUrl = signature.split("/")
                            imgUrl0 = imgUrl[0]
                            imgUrl1 = imgUrl[1]
                            var img = document.getElementById('revise');
                            img.style.backgroundImage = 'url("/img/menu/myOA/'+ imgUrl1 +'")';
                            $('#revise').val(imgUrl0)
                        }
                    })


                }

            })
            var list = document.getElementById('ul1').children;//获取所有的li标签
            for (var i = 0; i < list.length; i++) {//遍历每一个li标签
                list[i].setAttribute('index', i + 1); //给每一个li标签添加索引
                list[i].onclick = function () {
                    // alert("您点击了第"+this.getAttribute('index')+"个li标签");//获取添加的li标签的元素值
                    if (this.getAttribute('index') == 1) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/1.png')"
                    } else if (this.getAttribute('index') == 2) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/2.png')"
                    } else if (this.getAttribute('index') == 3) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/3.png')"
                    } else if (this.getAttribute('index') == 4) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/4.png')"
                    } else if (this.getAttribute('index') == 5) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/5.png')"
                    } else if (this.getAttribute('index') == 6) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/6.png')"
                    } else if (this.getAttribute('index') == 7) {
                        var img = document.getElementById('revise');
                        img.style.backgroundImage = "url('/img/menu/myOA/7.png')"
                    }
                }

            }

            // $(document).on('click', '#save', function () {
            $('#save').off().on('click', function () {
                $(".state").empty();
                val1 = $('#revise').val();
                var val=encodeURI(val1);
                if (tu == undefined){
                    $.ajax({
                        url: "/user/editUserSign?sign=" + val,
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            myfun()
                        }
                    })
                }else{
                    // 如果内容为空，图片也要清空
                    if (!val) tu ='';
                    $.ajax({
                        url: "/user/editUserSign?sign=" + val + "/" + tu,
                        type: 'get',
                        dataType: "JSON",
                        success: function (data) {
                            myfun()
                        }
                    })
                }

                layer.close(layer.index);

            });
            // if(val == ''){
            //     $('#revise').css('background-image','url("/img/menu/myOA/signature.png")')
            // }
            $("#revise").bind("input oninput",function(event){
                val = $('#revise').val();
                if(val == ''){
                    $('#revise').css('background-image','url("/img/menu/myOA/signature.png")')
                }
            });




        }),
            $(document).on('click', '.penn', function () {
                var inputVal =  $(this).children('.listItem').text();
                $('#revise').val(inputVal)
                // console.log($(".pen")[this.getAttribute('index')].src)
                var uri = $(".pen")[this.getAttribute('index')].src
                var url = uri.split("/")
                var img = "/" + "img/menu/myOA/";
                tu =  uri.substring(img.length);
                tu =  url[url.length-1];
            });



    })

    function myfun() {
        $.ajax({
            type: 'get',
            dataType: "JSON",
            url: "/selectKanBan"
            , success: function (data) {
                signature = data.object;
                imgUrl = signature.split("/")
                imgUrl0 = imgUrl[0]
                imgUrl1 = imgUrl[1]
                // lu = data.object.slice(-41)
                cvb = data.object.split("/")
                if(imgUrl0!='认真办公中'&&imgUrl0!='休息充电中'&&imgUrl0!='出差办事中'&&imgUrl0!='学习提高中'&&imgUrl0!='生病难受中'&&imgUrl0!='总结报告中'&&imgUrl0!='开会中'){
                    cvb[1]='/signature.png'
                }
                var img = "/" + "img/menu/myOA/";
                urlImg = img+cvb[1]
                cvb
                var strss = '<img src="' + urlImg + '" alt="" style="float: left; display: inline-block"/>'
                var strs = '<p id="wan" style="display: inline-block; margin-left: 5px; margin-right: 5px; font-size: 16px">' + cvb[0] + '</p>'
                $('.state').prepend(strss)
                $('.state').prepend(strs)
            }
        })
    }

    window.onload = function () {
        myfun()
    }
    // 查询项目类型
    $.ajax({
        url: "/syspara/selectByParaName?paraName=MYPROJECT",
        type: 'get',
        dataType: "JSON",
        success: function (data) {
            if (data.flag) {
                if (data.object != undefined && data.object.indexOf('edu') > -1) {
                    $('.model_news').text("校园快讯");
                    $('.hide_news').text("校园快讯");
                    $('.model_con_new').text("外部校园快讯");
                    $('.edu_con_notice98').show();
                    $('.edu_con_notice99').show();
                    dangwuopen(this);
                    xiaowuOpen(this);
                }
            }
        }
    })

    //公告下拉框
    $.ajax({
        url: "/sys/getNotifyTypeList?CodeNos=NOTIFY",
        type: 'get',
        dataType: "JSON",
        success: function (data) {
            var arr = data.obj;
            var str = '<option data-bool=""><fmt:message code="notice.th.all" /></option>';

            for (var i = 0; i < arr.length; i++) {
                if (arr[i].codeNo !== "LDZSJS") {
                    str += '<option data-bool="' + arr[i].codeNo + '">' + arr[i].codeName + '</option>'
                }

            }
            $('[name="noticeTypes"]').html(str)
        }
    })

    $('[name="noticeTypes"]').change(function () {
        if ($('#notice_listTwo .active').html() == '未读') {
            // announcement($(this).find('option:selected').attr('data-bool'))
            announcement(this)
        } else {
            announcements(this)
        }
    })
    $('[name="lead"]').change(function () {
        if ($('#notice_listTwolead .active').html() == '未读') {
            // announcement($(this).find('option:selected').attr('data-bool'))
            lead(this)
        } else {
            leads(this)
        }
    })


    //新闻下拉框
    $.ajax({
        url: "/code/GetDropDownBox",
        type: 'get',
        dataType: "JSON",
        data: {"CodeNos": "NEWS"},
        success: function (data) {
            var str = '<option data-bool=""><fmt:message code="notice.th.all" /></option>';
            for (var proId in data) {
                for (var i = 0; i < data[proId].length; i++) {
                    str += '<option  data-bool="' + data[proId][i].codeNo + '">' + data[proId][i].codeName + '</option>'
                }
            }
            $('[name="newTypes"]').html(str);
            if ($('#xinWen .active').attr('data-id') == '1') {
                administrivia(this)
            }
        }
    })

    $('[name="newTypes"]').change(function () {

        if ($('#xinWen .active').attr('data-id') == '1') {

            administrivia(this)

        } else if ($('#xinWen .active').attr('data-id') == '2') {

            administrivias(this)

        }
    })

//机关党建更多
function organMore(me){
    $.popWindow('/newFilePub/DefineMenu?sortId=921','<fmt:message code="main.public" />','20','150','1200px','600px')
}
//办公管理更多
function officeMore(me){
    var urls=$(me).prev().find('.active').attr('urls');
    $.popWindow(urls,'<fmt:message code="main.public" />','20','150','1200px','600px')
}
</script>
</body>
</html>
