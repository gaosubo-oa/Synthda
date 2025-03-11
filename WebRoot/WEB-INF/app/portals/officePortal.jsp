<%--
  Created by IntelliJ IDEA.
  User: zhangyuan
  Date: 2020-04-09
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>办公门户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=10,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/lib/layui/layui/css/layui.css?20210319.1"/>
    <link rel="stylesheet" type="text/css" href="/css/base/base.css?20201106.1"/>
    <script type="text/javascript" src="/lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/lib/layui/layui/layui.all.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq2.js"></script>
    <script src="/js/base/base.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/js/HSTmeeting/base64.js" type="text/javascript"></script>
    <script src="/js/HSTmeeting/entermeeting.js?sid=2b2f9c37241432a91dc2f9343f5e4053" type="text/javascript"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
            background: #F6F7F7;
            color: #666;
        }

        .clearfix li {
            list-style: none;
            margin: 7px 25px;
            font-size: 9pt;
            background: #e8f4fc;
            border: 1px solid #3c92e5;
            color: #333;
        }

        .clearfix li:hover {
            background: #3c92e5;
            cursor: pointer;
            color: #fff;
        }

        .clearfix ul {
            overflow-y: auto;
        }

        .container {
            display: flex;
        }

        .box_style {
            width: 50%;
            background: white;
            border: 1px solid #0588c7;
            border-right: 0;
            border-bottom: 0;
        }

        .box_style ~ .box_style {
            border: 1px solid #0588c7;
        }

        .title {
            background: #e8f4fc;
            /*background: #4aa7e2;*/
            line-height: 32px;
            height: 32px;
            font-size: 14px;
            position: relative;
            color: white;
            border-bottom: 1px solid #0588c7;
        }

        .title img {
            vertical-align: sub;
            margin-left: 5px;
        }

        .title strong {
            font-style: normal;
            font-weight: bold;
            font-size: 12pt;
            color: #000;
        }

        .title span {
            float: right;
            border: #3c92e5 1px solid;
            border-radius: 4px;
            line-height: 20px;
            margin: 4px 10px 4px 0;
            padding: 0px 7px;
            background: #ffffff;
            cursor: pointer;
            font-size: 8pt;
            color: #2b7fe0;
        }

        .active {
            background: #3c92e5 !important;
            color: #fff !important;
        }

        /*定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
        ::-webkit-scrollbar {
            width: 1px; /*滚动条宽度*/
            height: 1px; /*滚动条高度*/
        }

        /*定义滚动条轨道 内阴影+圆角*/
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 1px rgba(0, 0, 0, 0);
            background-color: white; /*滚动条的背景颜色*/
        }

        /*定义滑块 内阴影+圆角*/
        ::-webkit-scrollbar-thumb {
            -webkit-box-shadow: inset 0 0 1px rgba(0, 0, 0, 0);
            background-color: white; /*滚动条的背景颜色*/
        }

        .box_style ul {
            overflow: hidden;
            overflow-y: auto;
        }

        .box_style li {
            list-style: none;
            height: 50px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
        }

        .box_style li:hover {
            background: #e8f4fc;
        }

        .box_style li img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            float: left;
            margin: 10px 5px 0 5px;
        }

        .box_style li div {
            /*width:60%;*/
            float: left;
        }

        .box_style li div h2,h3{
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        .box_style li h1 {
            height: 20px;
            line-height: 26px;
            color: #333333;
            font-size: 9pt;
            margin-bottom: 5px;
        }

        .box_style li h2 {
            color: #1b5e8d;
            height: 20px;
            line-height: 20px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 11pt;
        }

        .box_style li h3 {
            margin: 14px;
            font-size: 11pt;
            color: #1b5e8d;
        }

        .box_style li h3 b {
            /*font-size: 20px;*/
            margin-right: 5px;
        }

        .box_style li > span {
            display: block;
            margin: 15px 15px 0 0;
            color: #898989;
            font-size: 11pt;
            float: right;
        }

        .noData {
            position: relative;
            top: 50%;
            /*transform: translateY(-50%);*/
        }

        /*代办事项分页按钮媒体查询*/
        @media screen and (min-width: 374px) and (max-width: 767px) {
            .change-md-btn {
                position: absolute;
                right: 105px;
                bottom: 5px;
            }
        }

        @media screen and (min-width: 768px) {
            .change-lg-btn {
                position: absolute;
                right: 10px;
                bottom: 5px;
            }
        }

        @media screen and (min-width: 992px) {
            .change-sg-btn {
                position: absolute;
                right: 10px;
                bottom: 5px;
            }
        }

        .change-btn {
            /*border:1px solid #2b7fe0;*/
            display: none;
            border-radius: 15px;
        }

        .change-btn div {
            width: 32px;
            text-align: center;
            color: #2b7fe0;
            border-radius: 50%;
            display: inline-block;
            font-size: 20px;
            /*transition: all .2s;*/
        }

        .change-btn div + div {
            margin-left: 5px;
        }

        .change-btn div:hover {
            color: #fff;
            border-radius: 50%;
            transform: scale(1.2);
            -webkit-transform: scale(1.2); /*兼容-webkit-引擎浏览器*/
            -moz-transform: scale(1.2); /*兼容-moz-引擎浏览器*/
        }

        /*左不可用-0.5 4.6 右不可用1.5px -137.4  左可用-0.5 -89.4  右可用 1.5 -42.4*/
        #left-tigger, #left, #left-gongwen {
            border: 1px solid #ccc;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: -0.5px 4.6px;

        }

        #right-tigger, #right, #right-gongwen {
            border: 1px solid #2b7fe0;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: 1.5px -42.4px;
        }

        .left_use {
            border: 1px solid #2b7fe0 !important;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: -0.5px -89.4px !important;
        }

        .right_use {
            border: 1px solid #2b7fe0 !important;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: 1.5px -42.4px !important;
        }

        .left_unuse {
            border: 1px solid #ccc !important;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: -0.5px 4.6px !important;
        }

        .right_unuse {
            border: 1px solid #ccc !important;
            width: 35px;
            height: 35px;
            -webkit-border-radius: 50%;
            -moz-border-radius: 50%;
            border-radius: 50%;
            background-image: url('../../img/main_img/trigger-btn.png?20200417.2');
            background-repeat: no-repeat;
            background-size: 100%;
            background-position: 1.5px -137.4px !important;
        }

        .d-none {
            display: none !important;
        }

        .box_style li h3.titleName {
            display: inline-block;
            color: #333;
            margin-right: 5px;
        }

        .box_style li h3.mainName {
            display: inline-block;
            margin: 14px 0;
            margin-right: 5px;
        }

        .box_style li h3.timeDiv {
            display: inline-block;
            margin: 14px 0;
            font-size: 13px;
            color: #898989;
        }
        .noData {
            position: relative;
            top: 33%;
        }
    </style>
</head>
<body>
<div style="padding: 8px;margin-top:45px;">
    <div class="head-top">
        <ul class="clearfix">
            <li id="6501" menu_tid="650101" class="fl head-top-li" url="/document/draftArticlesOfCommunication"
                oldmenuUrl="document/send/draft" data-type="" onclick="documentActive(this)">发文拟稿<h2
                    style="display: none">发文拟稿</h2></li>
            <li id="6505" menu_tid="650501" class="fl head-top-li" data-type="0"
                url="document/addresseeRegistrationForm" oldmenuUrl="document/recv/register" data-type=""
                onclick="documentActive(this)">收文登记<h2 style="display: none">收文登记</h2></li>
        </ul>
    </div>

    <%--上面--%>
    <div class="container">
        <%--待办事项--%>
        <div class="transaction box_style" id="daiban" style="position: relative;">
            <%--翻页按钮--%>
            <div id="change-btn" class="change-md-btn  change-lg-btn change-sg-btn change-btn">
                <%--上一页--%>
                <div id="left-tigger" onclick="doChangePage(-1)" title="加载上一页">
                </div>
                <%--下一页--%>
                <div id="right-tigger" onclick="doChangePage(+1)" title="加载下一页">
                </div>
            </div>
            <div class="title">
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <strong>待办事项</strong>
                <span onclick="parent.getMenuOpen(this)" tid="1020" more_type="1" url="/workflow/work/workList">更多<h2
                        style="display: none">待办事项</h2></span>
            </div>
            <div class="content">
                <ul class="theMatters" style="height: 320px"></ul>
            </div>
        </div>

        <%--公告通知--%>
        <div class="announcement box_style" id="gonggao" style="border-bottom:0; position:relative;">
            <%--翻页按钮--%>
            <div id="gonggao-btn" class="change-md-btn  change-lg-btn change-sg-btn change-btn">
                <%--上一页--%>
                <div id="left" onclick="doannouncementShow(-1)" title="加载上一页">

                </div>
                <%--下一页--%>
                <div id="right" onclick="doannouncementShow(+1)" title="加载下一页">
                </div>
            </div>
            <div class="title">
                <img src="/img/main_img/theme6/announce.png" alt="">
                <strong>公告通知</strong>
                <span onclick="parent.getMenuOpen(this)" tid="0116" url="/notice/InformTheView">更多<h2
                        style="display: none">公告通知</h2></span>
                <span data-read="1" onclick="announcementShow(1)">已读</span>
                <span class="active" data-read="0" onclick="announcementShow(0)">未读</span>
            </div>
            <div class="content">
                <ul class="new" style="height: 320px"></ul>
            </div>
        </div>
    </div>

    <%--下面--%>
    <div class="container">
        <%--文件管理--%>
        <div class="file_Management box_style" style="border-bottom:1px solid #0588c7">
            <div class="title">
                <img src="/img/main_img/theme6/fliebox.png" alt="">
                <strong>文件管理</strong>
                <span onclick="parent.getMenuOpen(this)" tid="3001" url="/newFilePub/fileCabinetHome?0">更多<h2
                        style="display: none">文件管理</h2></span>
                <span onclick="personalFiles()" style="display: none">个人文件</span>
                <span onclick="announcement()">公共文件</span>
                <span class="active" onclick="lastFiles()">最新文件</span>
            </div>
            <div class="content">
                <ul class="Management" style="height: 320px"></ul>
            </div>
        </div>
        <%--我的公文--%>
        <div class="addressee box_style" id="gongwen" style="position: relative;">
            <%--翻页按钮--%>
            <div id="gongwen-btn" class="change-md-btn  change-lg-btn change-sg-btn change-btn">
                <%--上一页--%>
                <div id="left-gongwen" onclick=" Doamange(-1)" title="加载上一页">

                </div>
                <%--下一页--%>
                <div id="right-gongwen" onclick=" Doamange(+1)" title="加载下一页">

                </div>
            </div>
            <div class="title">
                <img src="/img/commonTheme/theme6/doctment.png" style="width: 18px;" alt="">
                <strong>我的公文</strong>
                <span onclick="documentMore(this)" class="a" tid="1020" url="\/document\/makeADraft"
                      oldmenuUrl="document\/send\/backlog">更多<h2 style="display: none">我的公文</h2></span>
                <span onclick="amange(1)" url="document\/inAbeyance" urls ='0' oldmenuUrl="document\/recv\/backlog">待办收文</span>
                <span class="active" onclick="amange(0)" url="\/document\/makeADraft" urls ='1'
                      oldmenuUrl="document\/send\/backlog">待办发文</span>
            </div>
            <div class="content">
                <ul class="document" style="height: 320px"></ul>
            </div>
        </div>
    </div>
</div>
<script>
    // 发文拟稿和收文格式便捷跳转
    $('.head-top li').click(function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if ($(this).attr('data-type') == '') {
        } else if ($(this).attr('data-type') == '0') {
        }
    })
    var address
    // $('ul').height($(window).height() / 2 - 47)

    //标题栏右侧 添加选中效果
    $('.title span').click(function () {
        if (!$(this).hasClass('a')) {
            $(this).siblings().removeClass('active');
            $(this).addClass('active');
        }

    })
    //    代办事项鼠标移入移出事件
    $("#daiban").hover(function () {
        $("#change-btn").css('display', 'block');
    }, function () {
        $("#change-btn").css('display', 'none');
    })

    //    公告通知鼠标移出移入事件
    $("#gonggao").hover(function () {
        $("#gonggao-btn").css('display', 'block');
    }, function () {
        $("#gonggao-btn").css('display', 'none');
    })
    //    我的公文鼠标移入移出事件
    $("#gongwen").hover(function () {
        $("#gongwen-btn").css('display', 'block');
    }, function () {
        $("#gongwen-btn").css('display', 'none');
    })
    //代办事项翻页功能判断
    var pNum = 1, totlePage = 0;
    var maxpNum = 0;
    function doChangePage(num) {
        pNum += num
        if (pNum == 0) {
            pNum = 1;
        }
        if (pNum >= 1 && pNum <= maxpNum) {
            $.ajax({
                url: '/workflow/work/selectWork',
                type: 'get',
                data: {
                    page: pNum,
                    pageSize: 6,
                    useFlag: true,
                    userId: $.cookie('userId')
                },
                type: 'get',
                dataType: 'json',
                success: function (res) {
                    var data = res.obj;

                    if (res.totleNum == undefined) {
                        totlePage = 0;
                    } else {
                        totlePage = res.totleNum;
                        maxpNum = Math.ceil(totlePage / 6);

                    }
//                判断如果数据少于6条翻页按钮显示隐藏
                    if (totlePage <= 6) {
                        $("#change-btn").addClass('d-none');
                    } else {
                        $("#change-btn").removeClass("d-none");
                    }
//                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                    if (pNum <= 1) {

                        $("#left-tigger").addClass('left_unuse').removeClass("left_use")
                        $("#right-tigger").addClass('right_use').removeClass("right_unuse")
                    }
                    if (pNum >= maxpNum) {

                        $("#left-tigger").addClass('left_use').removeClass("left_unuse")
                        $("#right-tigger").addClass('right_unuse').removeClass("right_use")
                    }
                    if (pNum > 1 && pNum < maxpNum) {

                        $("#left-tigger").addClass('left_use').removeClass("left_unuse")
                        $("#right-tigger").addClass('right_use').removeClass("right_unuse")
                    }

                    var str = ''
                    if (data.length > 0) {
                        $('.theMatters').html("");
                        data.forEach(function (val, index) {
                            str = '<li onclick="windowOpenNew(this)" data-url="/workflow/work/workform?opFlag=' + data[index].opFlag + '&flowId=' + data[index].flowRun.flowId + '&flowStep=' + data[index].prcsId + '&runId=' + data[index].runId + '&prcsId=' + data[index].flowPrcs + '">'
                            str += '   <img src="/img/main_img/managementPortal/boy.png">'
                            str += '   <div>'
                            str += '       <h1 class="n_name">' + data[index].userName + '</h1>'
                            str += '       <h2 class="n_title">' + data[index].flowType.flowName + data[index].createTime + '</h2>'
                            str += '   </div>'
                            str += '   <span>' + format(data[index].createTime) + '</span>'
                            str += '</li>'
                            $('.theMatters').append(str);
                            // $('.theMatters div').width($(window).width() / 2 - 170)
                        })
                    } else {
                        str += '<div class="noData" style="text-align: center;border: none;">' +
                            '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                            '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                        '   </div>';
                        $('.theMatters').html(str);
                    }
                }
            });
        }


    }
    // 待办事项
    $.ajax({
        url: '/workflow/work/selectWork',
        type: 'get',
        data: {
            page: 1,
            pageSize: 6,
            useFlag: true,
            userId: $.cookie('userId')
        },
        type: 'get',
        dataType: 'json',
        success: function (res) {
            var data = res.obj;
            if (res.totleNum == undefined) {
                totlePage = 0;
            } else {
                totlePage = res.totleNum;
                maxpNum = Math.ceil(totlePage / 6);
            }
//                判断如果数据少于6条翻页按钮显示隐藏
            if (res.totleNum == undefined) {
                totlePage = 0;
            } else {
                totlePage = res.totleNum;
                maxpNum = Math.ceil(totlePage / 6);

            }
            if (totlePage <= 6) {
                $("#change-btn").addClass('d-none');
            } else {
                $("#change-btn").removeClass("d-none");
            }
//                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
//            if(pNum<=1){
//
//                $("#left-tigger").addClass('left_unuse').removeClass("left_use")
//                $("#right-tigger").addClass('right_use').removeClass("right_unuse")
//            }
//            if(pNum>=maxpNum){
//
//                $("#left-tigger").addClass('left_use').removeClass("left_unuse")
//                $("#right-tigger").addClass('right_unuse').removeClass("right_use")
//            }
//            if(pNum>1 && pNum<maxpNum){
//
//                $("#left-tigger").addClass('left_use').removeClass("left_unuse")
//                $("#right-tigger").addClass('right_use').removeClass("right_unuse")
//            }
            var str = ''
            if (data.length > 0) {
                data.forEach(function (val, index) {
                    str = '<li onclick="windowOpenNew(this)" data-url="/workflow/work/workform?opFlag=' + data[index].opFlag + '&flowId=' + data[index].flowRun.flowId + '&flowStep=' + data[index].prcsId + '&runId=' + data[index].runId + '&prcsId=' + data[index].flowPrcs + '">'
                    str += '   <img src="/img/main_img/managementPortal/boy.png">'
                    str += '   <div>'
                    str += '       <h1 class="n_name">' + data[index].userName + '</h1>'
                    str += '       <h2 class="n_title">' + data[index].flowType.flowName + data[index].createTime + '</h2>'
                    str += '   </div>'
                    str += '   <span>' + format(data[index].createTime) + '</span>'
                    str += '</li>'
                    $('.theMatters').append(str);
                    // $('.theMatters div').width($(window).width() / 2 - 170)
                })
            } else {
                str += '<div class="noData" style="text-align: center;border: none;">' +
                    '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                    '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                '   </div>';
                $('.theMatters').html(str);
            }
        }
    });

    //公告展示
    //    未读
    var gonggaoNum = 1, gonggaoPage = 0;
    var gonggaomaxNum = 0, _read = 0;
    //    已读
    var gonggaoNum1 = 1, gonggaoPage1 = 0;
    var gonggaomaxNum1 = 0;
    function doannouncementShow(num) {
//        首先判断要查看的是哪项0 1
        var active = $("#gonggao div.title").find('.active').attr('data-read');
        if (active == 0) {
            gonggaoNum += num;
            if (gonggaoNum <= 1) {
                gonggaoNum = 1;
            }
            if (gonggaoNum >= 1 && gonggaoNum <= gonggaomaxNum) {
                $.ajax({
                    url: '/notice/notifyManage',
                    type: 'get',
                    data: {
                        page: gonggaoNum,
                        read: _read,
                        pageSize: '6',
                        useFlag: 'true',
                        typeId: ''
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.totleNum == undefined) {
                            gonggaoPage = 0;
                        } else {
                            gonggaoPage = res.totleNum;
                            gonggaomaxNum = Math.ceil(gonggaoPage / 6);
                        }
//                判断如果数据少于6条翻页按钮显示隐藏
                        if (gonggaoPage <= 6) {
                            $("#gonggao-btn").addClass('d-none');
                        } else {
                            $("#gonggao-btn").removeClass("d-none");
                        }
//                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                        if (gonggaoNum <= 1) {

                            $("#left").addClass('left_unuse').removeClass("left_use")
                            $("#right").addClass('right_use').removeClass("right_unuse")
                        }
                        if (gonggaoNum >= gonggaomaxNum) {

                            $("#left").addClass('left_use').removeClass("left_unuse")
                            $("#right").addClass('right_unuse').removeClass("right_use")
                        }
                        if (gonggaoNum > 1 && gonggaoNum < gonggaomaxNum) {

                            $("#left").addClass('left_use').removeClass("left_unuse")
                            $("#right").addClass('right_use').removeClass("right_unuse")
                        }
                        $('.new').empty();//清空数据
                        var data = res.obj
                        var str = ''
                        if (data.length > 0) {
                            data.forEach(function (val, index) {
                                str = '<li onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[index].notifyId + '">'
                                str += '   <div>'
                                str += '       <h3 class="n_name"><b>•</b>' + data[index].subject + '</h3>'
                                str += '   </div>'
                                str += '   <span>' + format(data[index].notifyDateTime) + '</span>'
                                str += '</li>'
                                $('.new').append(str);
                                // $('.new div').width($(window).width() / 2 - 170)
                            })
                        } else {
                            str += '<div class="noData" style="text-align: center;border: none;">' +
                                '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                                '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                            '   </div>';
                            $('.new').html(str)
                        }
                    }
                });
            }
        }
        if (active == 1) {
            gonggaoNum1 += num;
            if (gonggaoNum1 <= 1) {
                gonggaoNum1 = 1;
            }
            if (gonggaoNum1 >= 1 && gonggaoNum1 <= gonggaomaxNum1) {
                $.ajax({
                    url: '/notice/notifyManage',
                    type: 'get',
                    data: {
                        page: gonggaoNum1,
                        read: active,
                        pageSize: '6',
                        useFlag: 'true',
                        typeId: ''
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.totleNum == undefined) {
                            gonggaoPage1 = 0;
                        } else {
                            gonggaoPage1 = res.totleNum;
                            gonggaomaxNum1 = Math.ceil(gonggaoPage1 / 6);
                        }
//                判断如果数据少于6条翻页按钮显示隐藏
                        if (gonggaoPage1 <= 6) {
                            $("#gonggao-btn").addClass('d-none');
                        } else {
                            $("#gonggao-btn").removeClass("d-none");
                        }
                        //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                        if (gonggaoNum1 <= 1) {

                            $("#left").addClass('left_unuse').removeClass("left_use")
                            $("#right").addClass('right_use').removeClass("right_unuse")
                        }
                        if (gonggaoNum1 >= gonggaomaxNum1) {

                            $("#left").addClass('left_use').removeClass("left_unuse")
                            $("#right").addClass('right_unuse').removeClass("right_use")
                        }
                        if (gonggaoNum1 > 1 && gonggaoNum1 < gonggaomaxNum1) {
                            $("#left").addClass('left_use').removeClass("left_unuse")
                            $("#right").addClass('right_use').removeClass("right_unuse")
                        }
                        $('.new').empty();//清空数据
                        var data = res.obj
                        var str = ''
                        if (data.length > 0) {
                            data.forEach(function (val, index) {
                                str = '<li onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[index].notifyId + '">'
                                str += '   <div>'
                                str += '       <h3 class="n_name"><b>•</b>' + data[index].subject + '</h3>'
                                str += '   </div>'
                                str += '   <span>' + format(data[index].notifyDateTime) + '</span>'
                                str += '</li>'
                                $('.new').append(str);
                                // $('.new div').width($(window).width() / 2 - 170)
                            })
                        } else {
                            str += '<div class="noData" style="text-align: center;border: none;">' +
                                '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                                '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                            '   </div>';
                            $('.new').html(str)
                        }
                    }
                });
            }
        }

    }
    announcementShow(0);
    function announcementShow(read) {
        _read = read;
        $.ajax({
            url: '/notice/notifyManage',
            type: 'get',
            data: {
                page: 1,
                read: read,
                pageSize: '6',
                useFlag: 'true',
                typeId: ''
            },
            dataType: 'json',
            success: function (res) {
                if (read == 0) {
                    if (res.totleNum == undefined) {
                        gonggaoPage = 0;
                    } else {
                        gonggaoPage = res.totleNum;
                        gonggaomaxNum = Math.ceil(gonggaoPage / 6);

                    }
//                判断如果数据少于6条翻页按钮显示隐藏
                    if (gonggaoPage <= 6) {
                        $("#gonggao-btn").addClass('d-none');
                    } else {
                        $("#gonggao-btn").removeClass("d-none");
                    }
                    //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                    if (gonggaoNum <= 1) {

                        $("#left").addClass('left_unuse').removeClass("left_use")
                        $("#right").addClass('right_use').removeClass("right_unuse")
                    }
                    if (gonggaoNum >= gonggaomaxNum) {

                        $("#left").addClass('left_use').removeClass("left_unuse")
                        $("#right").addClass('right_unuse').removeClass("right_use")
                    }
                    if (gonggaoNum > 1 && gonggaoNum < gonggaomaxNum) {
                        $("#left").addClass('left_use').removeClass("left_unuse")
                        $("#right").addClass('right_use').removeClass("right_unuse")
                    }
                } else if (read == 1) {
                    if (res.totleNum == undefined) {
                        gonggaoPage1 = 0;
                    } else {
                        gonggaoPage1 = res.totleNum;
                        gonggaomaxNum1 = Math.ceil(gonggaoPage1 / 6);

                    }
//                判断如果数据少于6条翻页按钮显示隐藏
                    if (gonggaoPage1 <= 6) {
                        $("#gonggao-btn").addClass('d-none');
                    } else {
                        $("#gonggao-btn").removeClass("d-none");
                    }
                    //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                    if (gonggaoNum1 <= 1) {

                        $("#left").addClass('left_unuse').removeClass("left_use")
                        $("#right").addClass('right_use').removeClass("right_unuse")
                    }
                    if (gonggaoNum1 >= gonggaomaxNum1) {

                        $("#left").addClass('left_use').removeClass("left_unuse")
                        $("#right").addClass('right_unuse').removeClass("right_use")
                    }
                    if (gonggaoNum1 > 1 && gonggaoNum1 < gonggaomaxNum1) {
                        $("#left").addClass('left_use').removeClass("left_unuse")
                        $("#right").addClass('right_use').removeClass("right_unuse")
                    }
                }


                $('.new').empty();//清空数据
                var data = res.obj
                var str = ''
                if (data.length > 0) {
                    data.forEach(function (val, index) {
                        str = '<li onclick="tiaozhuan(this)" data-url="/notice/detail?notifyId=' + data[index].notifyId + '">'
                        str += '   <div>'
                        str += '       <h3 class="n_name"><b>•</b>' + data[index].subject + '</h3>'
                        str += '   </div>'
                        str += '   <span>' + format(data[index].notifyDateTime) + '</span>'
                        str += '</li>'
                        $('.new').append(str);
                        // $('.new div').width($(window).width() / 2 - 170)
                    })
                } else {
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                        '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                        '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                    '   </div>';
                    $('.new').html(str)
                }
            }
        });
    }

    //文件管理 个人文件
    function personalFiles() {
        $.ajax({
            url: '/file/writeTreePerson',
            type: 'get',
            dataType: 'json',
            success: function (data) {
                $('.Management').empty();
                var str = '';
                if (data.length > 0) {
                    data.forEach(function (val, index) {
                        str = '<li data-num="1" data-id="' + data[index].id + '" menu_tid="0136" onclick="parent.getMenuOpen(this)" data-url="file_folder/index2.php">'
                        // str='<li data-num="1" data-id="'+data[index].id+'" menu_tid="3001" onclick="parent.getMenuOpen(this)" data-url="knowledge_management">'
                        str += '   <h2 style="display: none">个人文件</h2>'
                        str += '   <div>'
                        str += '       <h3 class="n_name"><b>•</b>' + data[index].text + '</h3>'
                        str += '   </div>'
                        str += '   <span>' + format(data[index].notifyDateTime) + '</span>'
                        str += '</li>'
                        $('.Management').append(str);
                    })
                } else {
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                        '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                        '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                    '   </div>';
                    $('.Management').html(str)
                }
            }
        });
    }

    //文件管理 公共文件
    function announcement() {
        $.ajax({
            url: '/file/writeTree',
            type: 'get',
            dataType: 'json',
            success: function (data) {
                $('.Management').empty();
                var str = '';
                if (data.length > 0) {
                    data.forEach(function (val, index) {
                        str = '<li data-num="1" data-id="' + data[index].id + '" menu_tid="3001" onclick="parent.getMenuOpen(this,2)" data-url="knowledge_management">'
                        str += '   <h2 style="display: none">公共文件</h2>'
                        str += '   <div>'
                        str += '       <h3 class="n_name"><b>•</b>' + data[index].text + '</h3>'
                        str += '   </div>'
                        str += '   <span>' + format(data[index].notifyDateTime) + '</span>'
                        str += '</li>'
                        $('.Management').append(str);
                    })
                } else {
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                        '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                        '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                    '   </div>';
                    $('.Management').html(str)
                }
            }
        });
    }

    //文件管理 最新文件
    lastFiles();
    function lastFiles() {
        $.ajax({
            url: '/newFileContent/selLastFiles',
            type: 'get',
            dataType: 'json',
            success: function (res) {
                var data = res.data;
                $('.Management').empty();
                var str = '';
                if (data.length > 0) {
                    data.forEach(function (val, index) {
                        str = '<li data-id="' + data[index].contentId + '" menu_tid="3001" onclick="parent.getMenuOpen(this,3)" data-url="knowledge_management">'
                        str += '   <div style="width: 100%;"><h2 style="display: none">最新文件</h2>'
                        str += '       <h3 class="titleName"><b>•</b>' + data[index].sortName + '</h3>'
                        str += '       <h3 class="mainName">' + data[index].subject + '</h3>'
                        str += '       <h3 class="timeDiv">（' + data[index].sendTime + '）</h3>'
                        str += '   </div>'
                        str += '</li>'
                        $('.Management').append(str);
                    })
                } else {
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                        '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                        '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                    '   </div>';
                    $('.Management').html(str)
                }
            }
        });
    }

    //我的公文'.acti点击更多的跳转
    function documentMore(me) {
        var urls = $(me).parent().find('.active').attr('urls');
        var url = $(me).parent().find('.active').attr('url');
        var element = $(me).parent().find('.active');
        if (urls == '1') {
            var tid = '650105';
        } else if (urls == '0') {
            var tid = '650505';
        }
        parent.getUrlMenuOpen(tid, element);
    }
    function documentActive(me) {
        var url = $(me).attr('url');
        var element = $(me);
        if (url == '/document/draftArticlesOfCommunication') {
            var tid = '650101';
        } else if (url == 'document/addresseeRegistrationForm') {
            var tid = '650501';
        }
        parent.getUrlMenuOpen(tid, element);
    }


    //    我的公文
    //    代办发文
    var gongwenNum = 1, gongwenPage = 0;
    var gongwenmaxNum = 0, _url = "";
    //    代办收文
    var gongwenNum1 = 1, gongwenPage1 = 0;
    var gongwenmaxNum1 = 0;
    function Doamange(num) {
//        首先判断url
        var url = $("#gongwen div.title").find('.active').attr('url');
        // 代办收文
        if (url == "/document/inAbeyance") {
            gongwenNum += num;
            if (gongwenNum <= 1) {
                gongwenNum = 1;
            }
            if (gongwenNum > gongwenPage) {
                gongwenNum = gongwenPage;
            }
            if (gongwenNum >= 1 && gongwenNum <= gongwenmaxNum) {
                // ajax
                $.ajax({
                    url: '/document/selWillDocSendOrReceive',
                    type: 'get',
                    data: {
                        page: gongwenNum,
                        pageSize: 6,
                        useFlag: true,
                        printDate: '',
                        dispatchType: '',
                        title: '',
                        docStatus: '',
                        flowId: '',
                        documentType: 1
                    },
                    dataType: 'json',
                    success: function (res) {
                        if (res.total == undefined) {
                            gongwenPage = 0;
                        } else {
                            gongwenPage = res.total;
                            gongwenmaxNum = Math.ceil(gongwenPage / 6);
                        }
//                判断如果数据少于6条翻页按钮显示隐藏
                        if (gongwenPage <= 6) {
                            $("#gongwen-btn").addClass('d-none');
                        } else {
                            $("#gongwen-btn").removeClass("d-none");
                        }
                        //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                        if (gongwenNum <= 1) {

                            $("#left-gongwen").addClass('left_unuse').removeClass("left_use")
                            $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                        }
                        if (gongwenNum >= gongwenmaxNum) {

                            $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                            $("#right-gongwen").addClass('right_unuse').removeClass("right_use")
                        }
                        if (gongwenNum > 1 && gongwenNum <= gongwenmaxNum) {
                            $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                            $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                        }
                        $('.document').empty();//清空数据
                        var data = res.datas;
                        var str = ''
                        if (data.length > 0) {
                            data.forEach(function (val, index) {
                                if (data[index].workLevel == 1) {
                                    var workLevel = '<span style="color: red;">【紧急】</span>';
                                } else if (data[index].workLevel == 2) {
                                    var workLevel = '<span style="color: red;">【特急】</span>';
                                } else {
                                    var workLevel = '';
                                }
                                str = '<li data-s="1" onclick="tiaozhuan(this)" data-url="/workflow/work/workform?&flowId=' + data[index].flowId + '&prcsId=' + data[index].realPrcsId + '&flowStep=' + data[index].step + '&runId=' + data[index].runId + '&tabId=' + data[index].id + '&tableName=' + data[index].tableName + '&isNomalType=false&hidden=true&opFlag=' + data[index].opFlag + '">'
                                str += '   <img src="/img/main_img/managementPortal/boy.png">'
                                str += '   <div>'
                                str += '       <h1 class="n_name">' + data[index].createrName + '</h1>'
                                str += '       <h2 class="n_title">' + workLevel + data[index].title + '</h2>'
                                str += '   </div>'
                                str += '   <span>' + format(data[index].createTime) + '</span>'
                                str += '</li>'
                                $('.document').append(str);
                                // $('.document div').width($(window).width() / 2 - 170)
                            })
                        } else {
                            str += '<div class="noData" style="text-align: center;border: none;">' +
                                '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                                '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                            '   </div>';
                            $('.document').html(str);
                        }
                    }
                });
            }
        }
        //代办发文
        else if (url == "/document/makeADraft") {
            gongwenNum1 += num;
            if (gongwenNum1 <= 1) {
                gongwenNum1 = 1;
            }
            if (gongwenNum1 > gongwenPage1) {
                gongwenNum1 = gongwenPage1;
            }
            if (gongwenNum1 >= 1 && gongwenNum1 <= gongwenmaxNum1) {
                //ajax
                $.ajax({
                    url: '/document/selWillDocSendOrReceive',
                    type: 'get',
                    data: {
                        page: gongwenNum1,
                        pageSize: 6,
                        useFlag: true,
                        printDate: '',
                        dispatchType: '',
                        title: '',
                        docStatus: '',
                        flowId: '',
                        documentType: 0
                    },
                    dataType: 'json',
                    success: function (res) {

                        if (res.total == undefined) {
                            gongwenPage1 = 0;
                        } else {
                            gongwenPage1 = res.total;
                            gongwenmaxNum1 = Math.ceil(gongwenPage1 / 6);
                        }
//                判断如果数据少于6条翻页按钮显示隐藏
                        if (gongwenPage1 <= 6) {
                            $("#gongwen-btn").addClass('d-none');
                        } else {
                            $("#gongwen-btn").removeClass("d-none");
                        }
                        //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                        if (gongwenNum1 <= 1) {

                            $("#left-gongwen").addClass('left_unuse').removeClass("left_use")
                            $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                        }
                        if (gongwenNum1 >= gongwenmaxNum1) {

                            $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                            $("#right-gongwen").addClass('right_unuse').removeClass("right_use")
                        }
                        if (gongwenNum1 > 1 && gongwenNum1 <= gongwenmaxNum1) {
                            $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                            $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                        }
                        $('.document').empty();//清空数据
                        var data = res.datas;
                        var str = ''
                        if (data.length > 0) {
                            data.forEach(function (val, index) {
                                if (data[index].workLevel == 1) {
                                    var workLevel = '<span style="color: red;">【紧急】</span>';
                                } else if (data[index].workLevel == 2) {
                                    var workLevel = '<span style="color: red;">【特急】</span>';
                                } else {
                                    var workLevel = '';
                                }
                                str = '<li data-s="1" onclick="tiaozhuan(this)" data-url="/workflow/work/workform?&flowId=' + data[index].flowId + '&prcsId=' + data[index].realPrcsId + '&flowStep=' + data[index].step + '&runId=' + data[index].runId + '&tabId=' + data[index].id + '&tableName=' + data[index].tableName + '&isNomalType=false&hidden=true&opFlag=' + data[index].opFlag + '">'
                                str += '   <img src="/img/main_img/managementPortal/boy.png">'
                                str += '   <div>'
                                str += '       <h1 class="n_name">' + data[index].createrName + '</h1>'
                                str += '       <h2 class="n_title">' + workLevel + data[index].title + '</h2>'
                                str += '   </div>'
                                str += '   <span>' + format(data[index].createTime) + '</span>'
                                str += '</li>'
                                $('.document').append(str);
                                // $('.document div').width($(window).width() / 2 - 170)
                            })
                        } else {
                            str += '<div class="noData" style="text-align: center;border: none;">' +
                                '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                                '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                            '   </div>';
                            $('.document').html(str);
                        }
                    }
                });
            }
        }
    }


    //我的公文
    amange(0)
    function amange(documentType) {

        $.ajax({
            url: '/document/selWillDocSendOrReceive',
            type: 'get',
            data: {
                page: 1,
                pageSize: 6,
                useFlag: true,
                printDate: '',
                dispatchType: '',
                title: '',
                docStatus: '',
                flowId: '',
                documentType: documentType
            },
            dataType: 'json',
            success: function (res) {
                if (documentType == 1) {
                    if (res.total == undefined) {
                        gongwenPage = 0;
                    } else {
                        gongwenPage = res.total;
                        gongwenmaxNum = Math.ceil(gongwenPage / 6);

                    }
//                判断如果数据少于6条翻页按钮显示隐藏
                    if (gongwenPage <= 6) {
                        $("#gongwen-btn").addClass('d-none');
                    } else {
                        $("#gongwen-btn").removeClass("d-none");
                    }
                    //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                    if (gongwenNum <= 1) {

                        $("#left-gongwen").addClass('left_unuse').removeClass("left_use")
                        $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                    }
                    if (gongwenNum >= gongwenmaxNum) {

                        $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                        $("#right-gongwen").addClass('right_unuse').removeClass("right_use")
                    }
                    if (gongwenNum > 1 && gongwenNum <= gongwenmaxNum) {
                        $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                        $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                    }
                } else if (documentType == 0) {
                    if (res.total == undefined) {
                        gongwenPage1 = 0;
                    } else {
                        gongwenPage1 = res.total;
                        gongwenmaxNum1 = Math.ceil(gongwenPage1 / 6);

                    }
//                判断如果数据少于6条翻页按钮显示隐藏
                    if (gongwenPage1 <= 6) {
                        $("#gongwen-btn").addClass('d-none');
                    } else {
                        $("#gongwen-btn").removeClass("d-none");
                    }
                    //                右可用 107。4 左可用165.4 右不可用 224.4 左不可用 -49.4
                    if (gongwenNum1 <= 1) {

                        $("#left-gongwen").addClass('left_unuse').removeClass("left_use")
                        $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                    }
                    if (gongwenNum1 >= gongwenmaxNum1) {

                        $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                        $("#right-gongwen").addClass('right_unuse').removeClass("right_use")
                    }
                    if (gongwenNum1 > 1 && gongwenNum1 <= gongwenmaxNum1) {
                        $("#left-gongwen").addClass('left_use').removeClass("left_unuse")
                        $("#right-gongwen").addClass('right_use').removeClass("right_unuse")
                    }

                }
                $('.document').empty();//清空数据
                var data = res.datas;
                var str = ''
                if (data.length > 0) {
                    data.forEach(function (val, index) {
                        if (data[index].workLevel == 1) {
                            var workLevel = '<span style="color: red;">【紧急】</span>';
                        } else if (data[index].workLevel == 2) {
                            var workLevel = '<span style="color: red;">【特急】</span>';
                        } else {
                            var workLevel = '';
                        }
                        str = '<li data-s="1" onclick="tiaozhuan(this)" data-url="/workflow/work/workform?&flowId=' + data[index].flowId + '&prcsId=' + data[index].realPrcsId + '&flowStep=' + data[index].step + '&runId=' + data[index].runId + '&tabId=' + data[index].id + '&tableName=' + data[index].tableName + '&isNomalType=false&hidden=true&opFlag=' + data[index].opFlag + '">'
                        str += '   <img src="/img/main_img/managementPortal/boy.png">'
                        str += '   <div>'
                        str += '       <h1 class="n_name">' + data[index].createrName + '</h1>'
                        str += '       <h2 class="n_title">' + workLevel + data[index].title + '</h2>'
                        str += '   </div>'
                        str += '   <span>' + format(data[index].createTime) + '</span>'
                        str += '</li>'
                        $('.document').append(str);
                        // $('.document div').width($(window).width() / 2 - 170)
                    })
                } else {
                    str += '<div class="noData" style="text-align: center;border: none;">' +
                        '       <img  src="/img/main_img/shouyekong.png" alt="">' +
                        '       <h5 style="text-align: center;color: #666;">' + '暂无数据' + '</h5>'
                    '   </div>';
                    $('.document').html(str);
                }
            }
        });
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
            // $(me).remove();
            // todoListNum--;
        }


        if ($('.daiban').find('li').length == 0) {
            var lis = '<div class="no_notice" style="text-align: center;border: none;">' +
                '<img style="margin-top: 62px;"  src="/img/main_img/shouyekong.png" alt="">' +
                '<h2 style="text-align: center;color: #666;">' + '暂无数据' + '</h2>' +
                '</div>';
            $('.daiban').html(lis);
        }
    }

    //跳转页面
    function tiaozhuan(that) {
        $.popWindow($(that).attr('data-url'), '公告详情', '20', '150', '1200px', '600px')
    }
    //时间戳转换
    function format(t) {
        if (t) {
            //处理ie下时间转换问题
            if (new Date(t).Format("yyyy-MM-dd") == 'NaN-aN-aN') {
                return t.split(' ')[0];
            } else {
                return new Date(t).Format("yyyy-MM-dd");
            }

        } else {
            return ''
        }
    }

    //参会
    function canHui(me) {
        layer.confirm('确定要参加会议吗？', function (index) {
            address = me.attr('roomAddr')
            entermeeting(me.attr('roomNo'), me.attr('roomPwd'), me.attr('userNameString'))
            layer.close(index);
        });
    }
    //PC客户端自动下载地址
    var clientForPCDownloadAddr = "http://www.hst.com/download/FMDesktop.exe";
    //登录会议室主函数
    function entermeeting(roomNo, roomPwd, nickName) {
        var roomId = roomNo;
        var roomPwd = roomPwd;
        var userName = '';
        var userPwd = '';
        var nickName = nickName;

        /* if(!isValidInput(roomId, roomPwd, userName, userPwd, nickName)){
         alert("请输入必要的参数");

         return;
         }*/

        var url = getURLForPC(roomId, roomPwd, userName, userPwd, nickName);
        if (isAndroid) {
            url = getURLForAndroid(roomId, roomPwd, userName, userPwd, nickName);
        } else if (isiOS) {
            url = getURLForIphone(roomId, roomPwd, userName, userPwd, nickName);
        }
        if (its.x.isIE() || its.x.isChrome() || its.x.isSafari()) {
            setTimeout(function () {
                window.location.href = url;
            }, 1);
        } else {
            document.getElementById("myiframe").src = url;
        }
    }
    function getUserType() {
        var userType;
        var obj = document.getElementsByName("userType");
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].checked)
                userType = obj[i].value;
        }
        return userType;
    }
</script>
</body>
</html>
