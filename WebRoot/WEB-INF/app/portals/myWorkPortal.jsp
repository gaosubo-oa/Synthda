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
            margin:5px;
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
        .card-head{
            display: flex;
            align-content: center;
            flex-direction: row;
        }
        .card-head li{
            height: 30px;
            border: 1px solid #cccccc;
            padding-top: 5px;
            text-align: center;
            border-left: none;
        }
        .counts{
            position: absolute;
            margin: 10px;
        }
        .layui-table-view{
            border:none;
            border-style: none;
        }
        .layui-table, .layui-table-view {
            margin: 0;
        }
        .layui-table-body {
            position: relative;
            overflow: auto;
            margin-right: -1px;
            margin-bottom: -4px;
        }
        .layui-table-header {
            border-width: 0;
            overflow: hidden;
        }
        .layui-table thead tr{
            background-color: #FFFFff;
        }
        #daiban-count,#nigao-count,#shouwen-count,#duban-count,#post-count,#received-count,#msg-count,#notice-count{
            background: red;
            color: white;
            border: red;
            border-radius: 50px;
            margin: 7px 0px 0px 10px;
        }
        .layui-table-view .layui-table{
            height: 100%;
        }
        .layui-table-view .layui-table tr td:first-child {
            text-align: start;
            color: #0088cc;
        }
        /*.layui-table-view .layui-table td {*/
        /*    padding: 5px 1px 5px 0px;*/
        /*    cursor: pointer;*/
        /*}*/
        /*.layui-table-view .layui-table thead tr th{*/
        /*    border-right: 1px solid #ccc;*/
        /*    border-bottom: 1px solid #ccc;*/
        /*}*/
        /*.layui-table-view .layui-table thead tr th:last-child{*/
        /*    border-right: none;*/
        /*    padding-right: 1px;*/
        /*}*/
        .content table{
            position: absolute;
        }
        .layui-none{
            position: relative;
            bottom: 50%;
        }
        .layui-table-view .layui-table {
            height: auto;
        }
        .layui-table-page{
            text-align: right;
        }
    </style>
</head>
<body>
<div style="padding: 8px;">
    <div class="container">
        <%--待办事项--%>
        <div class="transaction box_style" id="daiban" style="position: relative;">
            <div class="title">
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <strong>待办发文</strong>
                <span id="daiban-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="650105" more_type="1" url="/workflow/work/workList">更多<h2
                        style="display: none">待办发文</h2></span>
            </div>
            <div class="content">
                <table id="daibanDemo" lay-filter="daibanDemo"></table>
            </div>
        </div>

        <%--发文拟稿--%>
        <div class="fawenNigao box_style" id="" style="position:relative;">
            <div class="title">
                <img src="/img/main_img/theme6/announce.png" alt="">
                <strong>发文拟稿</strong>
                <span id="nigao-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="650101" url="/notice/InformTheView">更多<h2
                        style="display: none">发文拟稿</h2></span>
            </div>
            <div class="content">
                <table id="nigaoDemo" lay-filter="nigaoDemo"></table>
<%--                <ul class="new" style="height: 320px"></ul>--%>
            </div>
        </div>
    </div>

    <div class="container">
        <%--待办收文--%>
        <div class="receiveWait box_style" style="border-bottom:1px solid #0588c7">
            <div class="title">
                <img src="/img/main_img/theme6/fliebox.png" alt="">
                <strong>待办收文</strong>
                <span id="shouwen-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="650505" url="/newFilePub/fileCabinetHome?0">更多<h2
                        style="display: none">待办收文</h2></span>
            </div>
            <div class="content">
                <table id="shouwenDemo" lay-filter="shouwenDemo"></table>
            </div>
        </div>
        <%--我的公文--%>
        <div class="gongwenDuban box_style" id="gongwen" style="position: relative;">
            <div class="title">
                <img src="/img/commonTheme/theme6/doctment.png" style="width: 18px;" alt="">
                <strong>公文督办</strong>
                <span id="duban-count" class="counts"></span>
                <span onclick="documentMore(this)" class="a" tid="6508" url="\/document\/makeADraft"
                      oldmenuUrl="document\/send\/backlog">更多<h2 style="display: none">公文督办</h2></span>
            </div>
            <div class="content">
                <table id="dubanDemo" lay-filter="dubanDemo"></table>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="fawenDone box_style" style="position: relative;">
            <div class="title">
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <strong>已办发文</strong>
                <span id="post-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="650110" more_type="1" url="/workflow/work/workList">更多<h2
                        style="display: none">已办发文</h2></span>
            </div>
            <div class="content">
                <table id="postDone" lay-filter="postDone"></table>
            </div>
        </div>

        <div class="shouwenDone box_style" style="position:relative;">
            <div class="title">
                <img src="/img/main_img/theme6/announce.png" alt="">
                <strong>已办收文</strong>
                <span id="received-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="650510" url="/notice/InformTheView">更多<h2
                        style="display: none">已办收文</h2></span>
            </div>
            <div class="content">
                <table id="receivedDone" lay-filter="receivedDone"></table>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="messageSubmit box_style" style="position: relative;">
            <div class="title">
                <img src="/img/main_img/theme6/backlog.png" alt="">
                <strong>信息报送</strong>
                <span id="msg-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="201903" more_type="1" url="/workflow/work/workList">更多<h2
                        style="display: none">信息报送</h2></span>
            </div>
            <div class="content">
                <table id="msgSubmit" lay-filter="msgSubmit"></table>
            </div>
        </div>

        <%--公告通知--%>
        <div class="announcement box_style" id="gonggao" style="position:relative;">
            <div class="title">
                <img src="/img/main_img/theme6/announce.png" alt="">
                <strong>公告通知</strong>
                <span id="notice-count" class="counts"></span>
                <span onclick="parent.getMenuOpen(this)" tid="0116" url="/notice/InformTheView">更多<h2
                        style="display: none">公告通知</h2></span>
            </div>
            <div class="content">
                <table id="noticeDemo" lay-filter="noticeDemo"></table>
                <%--                <ul class="new" style="height: 320px"></ul>--%>
            </div>
        </div>
    </div>
</div>
<script>
    var table//layui table
    var layer
    //各个table名
    var daibanFawen,waitShouwen,gongwenDuban,fawenDoneTab,shouwenDoneTab,messageSubmitTab,announcementTab
    //    代办发文
    var daibanPage = 1
    var gongwenNum = 1, gongwenPage = 0;
    var gongwenmaxNum = 0, _url = "";
    //    代办收文
    var gongwenNum1 = 1, gongwenPage1 = 0;
    var gongwenmaxNum1 = 0;
    //切换上一页下一页
    function pageChange(that){
        var dataPage
        dataPage = $(that).attr("data-page")
        if(dataPage == undefined){
            dataPage = $(that).parent().attr("data-page")
        }
        // console.log(dataPage)
        return dataPage
    }
    // 待办事项
    layui.use(['table','layer'], function(){
        table = layui.table;
        layer = layui.layer;
        //待办发文
        daibanFawen = table.render({
            elem: '#daibanDemo'
            ,height: 320
            ,skin: 'nob'
            ,cellMinWidth: 'auto'
            ,url: '/document/selWillDocSendOrReceive' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,limit:6
            ,where: {
                page: daibanPage,
                pageSize: 6,
                useFlag: true,
                printDate: '',
                dispatchType: '',
                title: '',
                docStatus: '',
                flowId: '',
                documentType: 0//待办发文
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.datas, //解析数据列表，
                    "count": res.total, //解析数据长度
                };
            }
            ,cols: [[
                {title: '文件标题', width:'41%', align:'center',templet: function(d){
                        var workLevel
                        if (d.workLevel == 1) {
                            workLevel = '<span style="color: red;">【紧急】</span>';
                        } else if (d.workLevel == 2) {
                            workLevel = '<span style="color: red;">【特急】</span>';
                        } else {
                            workLevel = '';
                        }
                        return workLevel + d.title
                    }
                }
                ,{field: 'createrName', width:'20%', title: '发送人', align:'center'}
                ,{title: '时间', width:'20%', align:'center',templet: function(d){
                        return format(d.createTime)
                    }
                }
                ,{title: '办理', width:'20%', align:'center',templet: function(d){
                        if(d.prFlag==1){
                            return '未接收';
                        }else {
                            return '办理中';
                        }
                    }
                }
            ]]
            ,done:function(res,first){
                $("#daibanDemo").css("width","100%");
                var totleNum = res.count
                $("#daiban-count").html(totleNum);
                //待办发文翻页
                $(".transaction").find('.layui-box a').on("click",function(){
                    var pages = pageChange(this)
                    setTimeout(function () {
                        daibanFawen.reload({
                            where:{
                                page: pages,
                                pageSize: 6
                            }
                        })
                    },800)
                    layer.close(index);
                });
            }
        });
        table.on('row(daibanDemo)', function(obj){
            var data = obj.data;
            window.open('/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '')
            //标注选中样式
            // obj.tr.attr("data-url",'/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '');
            // windowOpenNew(obj.tr)
        });
        //待办收文
        waitShouwen = table.render({
            elem: '#shouwenDemo'
            ,height: 320
            ,skin: 'nob'
            ,url: '/document/selWillDocSendOrReceive' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: gongwenNum,
                pageSize: 6,
                useFlag: true,
                printDate: '',
                dispatchType: '',
                title: '',
                docStatus: '',
                flowId: '',
                documentType: 1//待办收文
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.datas, //解析数据列表，
                    "count": res.total, //解析数据长度
                };
            }
            ,cols: [[
                {title: '文件标题', width:'41%', align:'center',templet: function(d){
                        var workLevel
                        if (d.workLevel == 1) {
                            workLevel = '<span style="color: red;">【紧急】</span>';
                        } else if (d.workLevel == 2) {
                            workLevel = '<span style="color: red;">【特急】</span>';
                        } else {
                            workLevel = '';
                        }
                        return workLevel + d.title
                    }
                }
                ,{field: 'createrName',title: '发送人', width:'20%', align:'center'}
                ,{title: '时间', width:'20%', align:'center',templet: function(d){
                        return format(d.createTime)
                    }
                }
                ,{title: '办理', width:'20%', align:'center',templet: function(d){
                        if(d.prFlag==1){
                            return '未接收';
                        }else {
                            return '办理中';
                        }
                    }
                }
            ]]
            ,done:function(res){
                $("#shouwenDemo").css("width","100%");
                var totleNum = res.count
                $("#shouwen-count").html(totleNum);
                //待办收文翻页
                $(".receiveWait").find('.layui-box a').on("click",function(){
                    var pages = pageChange(this)
                    waitShouwen.reload({
                        where:{
                            page: pages,
                            pageSize: 6
                        }
                    })
                })
            }
        });
        table.on('row(shouwenDemo)', function(obj){
            var data = obj.data;
            window.open('/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '')
        });
        //公文督办
        gongwenDuban = table.render({
            elem: '#dubanDemo'
            ,height: 320
            ,skin: 'nob'
            ,url: '/document/selOverseeTheOfficialDocument' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: 1,
                pageSize: 6,
                useFlag: true
                }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.datas, //解析数据列表，
                    "count": res.total, //解析数据长度
                };
            }
            ,cols: [[
                {fied:'title', title: '文件标题', width:'39%', align:'center',templet: function(d){
                        if(d.title!=undefined){
                            return d.title
                        }else {
                            return ""
                        }
                    }
                }
                ,{field: 'createrName',title: '发送人', width:'20%', align:'center'}
                ,{title: '时间', width:'20%', align:'center',templet: function(d){
                        return format(d.printDate)
                    }
                }
                ,{title: '办理', width:'20%', align:'center',templet: function(d){
                        if(d.prFlag==1){
                            return '未接收'
                        }else {
                            return '办理中'
                        }
                    }
                }
            ]]
            ,done:function(res){
                $("#dubanDemo").css("width","100%");
                var totleNum = res.count
                $("#duban-count").html(totleNum);
                //公文督办翻页
                $(".gongwenDuban").find('.layui-box a').on("click",function(){
                    var pages = pageChange(this)
                    gongwenDuban.reload({
                        where:{
                            page: pages,
                            pageSize: 6
                        }
                    })
                })
            }
        });
        table.on('row(dubanDemo)', function(obj){
            var data = obj.data;
            window.open('/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '')
        });
        getData()
        //发文拟稿
        function getData() {
            $.ajax({
                url: '/document/sortFlow',
                type: "get",
                data: {
                    page: 1,
                    mainType:'DOCUMENTTYPE',
                    detailType:'SENDNG'
                },
                success: function (res) {//返回的数据我放在data.obj.records里
                    var flowArrys=[]
                    var flowNameArrys=[]
                    var flowObj = {};
                    for(var i=0;i<res.datas.length;i++){
                        flowArrys.push(res.datas[i].flows);
                        for(var j=0;j<flowArrys[i].length;j++){
                            flowNameArrys.push(flowArrys[i][j]);
                        }
                    }
                    setData("#nigaoDemo",flowNameArrys);//调用setData渲染table
                },
                error: function (datas) {
                    console.log(datas.msg);
                }
            });
        }
        table.on('row(nigaoDemo)', function(obj){
            var data = obj.data;
            //标注选中样式
            obj.tr.attr("data-url",'/notice/detail?notifyId=' + data.notifyId + '');
            tiaozhuan(obj.tr)
        });
        //已办发文
        fawenDoneTab = table.render({
            elem: '#postDone'
            ,height: 320
            ,skin: 'nob'
            ,url: '/document/selOverDocSendOrReceive' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: 1,
                pageSize: 6,
                useFlag: true,
                printDate: '',
                dispatchType: '',
                title: '',
                docStatus: '',
                flowId: '',
                documentType: 0//已办发文
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.datas, //解析数据列表，
                    "count": res.total, //解析数据长度
                };
            }
            ,cols: [[
                {title: '文件标题', width:'41%', align:'center',templet: function(d){
                        var workLevel
                        if (d.workLevel == 0) {
                            workLevel = '<span style="color: green;">【普通】</span>';
                        }else if (d.workLevel == 1) {
                            workLevel = '<span style="color: green;">【紧急】</span>';
                        } else if (d.workLevel == 2) {
                            workLevel = '<span style="color: green;">【特急】</span>';
                        } else {
                            workLevel = '';
                        }
                        return workLevel + d.title
                    }
                }
                ,{field: 'createrName',title: '发送人', width:'20%', align:'center'}
                ,{title: '办结时间', width:'20%', align:'center',templet: function(d){
                        return format(d.deliverTime)
                    }
                }
                ,{field: 'state',title: '办理', width:'20%', align:'center'}
            ]]
            ,done:function(res){
                $("#postDone").css("width","100%");
                var totleNum = res.count
                $("#post-count").html(totleNum);
                //已办发文翻页
                $(".fawenDone").find('.layui-box a').on("click",function(e){
                    var pages = pageChange(e)
                    fawenDoneTab.reload({
                        where:{
                            page: pages,
                            pageSize: 6
                        }
                    })
                })
            }
        });
        table.on('row(postDone)', function(obj){
            var data = obj.data;
            window.open('/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '')
        });
        //已办收文
        shouwenDoneTab = table.render({
            elem: '#receivedDone'
            ,height: 320
            ,skin: 'nob'
            ,url: '/document/selOverDocSendOrReceive' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: 1,
                pageSize: 6,
                useFlag: true,
                printDate: '',
                dispatchType: '',
                title: '',
                docStatus: '',
                flowId: '',
                documentType: 1//已办收文
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.datas, //解析数据列表，
                    "count": res.total, //解析数据长度
                };
            }
            ,cols: [[
                {title: '文件标题', width:'40%', align:'center',templet: function(d){
                        var workLevel
                        if (d.workLevel == 0) {
                            workLevel = '<span style="color: green;">【普通】</span>';
                        }else if (d.workLevel == 1) {
                            workLevel = '<span style="color: green;">【紧急】</span>';
                        } else if (d.workLevel == 2) {
                            workLevel = '<span style="color: green;">【特急】</span>';
                        } else {
                            workLevel = '';
                        }
                        return workLevel + d.title
                    }
                }
                ,{field: 'createrName',title: '发送人', width:'20%', align:'center'}
                ,{title: '办结时间', width:'20%', align:'center',templet: function(d){
                        return format(d.deliverTime)
                    }
                }
                ,{field: 'state',title: '办理', width:'20%', align:'center'}
            ]]
            ,done:function(res){
                $("#receivedDone").css("width","100%");
                var totleNum = res.count
                $("#received-count").html(totleNum);
                //已办收文翻页
                $(".shouwenDone").find('.layui-box a').on("click",function(e){
                    var pages = pageChange(e)
                    shouwenDoneTab.reload({
                        where:{
                            page: pages,
                            pageSize: 6
                        }
                    })
                })
            }
        });
        table.on('row(receivedDone)', function(obj){
            var data = obj.data;
            window.open('/workflow/work/workform?&flowId=' + data.flowId + '&prcsId=' + data.realPrcsId + '&flowStep=' + data.step + '&runId=' + data.runId + '&tabId=' + data.id + '&tableName=' + data.tableName + '&isNomalType=false&hidden=true&opFlag=' + data.opFlag + '')
        });
        //信息报送
        messageSubmitTab = table.render({
            elem: '#msgSubmit'
            ,height: 320
            ,skin: 'nob'
            ,url: '/infomation/getHandleList' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: 1,
                pageSize: 6,
                useFlag: true
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.obj, //解析数据列表，
                    "count": res.totleNum, //解析数据长度
                };
            }
            ,cols: [[
                {field: 'title', title: '文件标题', width:'41%', align:'center'}
                ,{field: 'userName',title: '发送人', width:'20%', align:'center'}
                ,{title: '办结时间', width:'20%', align:'center',templet: function(d){
                        return format(d.createTime)
                    }
                }
                ,{field: 'state',title: '办理', width:'20%', align:'center',templet: function(d){
                        if(d.iscollection==0){
                            return "未采集"
                        }else{
                            return "已采集"
                        }
                    }
                }
            ]]
            ,done:function(res){
                $("#msgSubmit").css("width","100%");
                var totleNum = res.count
                $("#msg-count").html(totleNum);
                //信息报送翻页
                $(".messageSubmit").find('.layui-box a').on("click",function(){
                    var pages = pageChange(this)
                    messageSubmitTab.reload({
                        where:{
                            page: pages,
                            pageSize: 6
                        }
                    })
                })
            }
        });
        table.on('row(msgSubmit)', function(obj){
            var data = obj.data;
            obj.tr.attr("data-url",'/infomation/readDetail?dataType=2&id='+data.id+'&read='+1+'&is='+1);
            tiaozhuan(obj.tr)
        });
        //其他事项-公告通知
        announcementTab = table.render({
            elem: '#noticeDemo'
            ,height: 320
            ,skin: 'nob'
            ,url: '/notice/notifyManage' //数据接口
            ,page: {
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,where: {
                page: 1,
                pageSize: 6,
                useFlag: true,
                typeId: 0,
                read:'',
                sendTime:''
            }
            ,parseData: function(res){ //res 即为原始返回的数据
                return {
                    "code":0, //解析接口状态
                    "data": res.obj, //解析数据列表，
                    "count": res.totleNum, //解析数据长度
                };
            }
            ,cols: [[
                {title: '文件标题',  align:'center',templet: function(d){
                        return d.subject
                    }
                }
                ,{title: '时间', align:'center',templet: function(d){
                        return format(d.notifyDateTime)
                    }
                }
            ]]
            ,done:function(res){
                $("#noticeDemo").css("width","100%");
                var totleNum = res.count
                $("#notice-count").html(totleNum);
                //公告通知翻页
                $(".announcement").find('.layui-box a').on("click",function(){
                    var pages = pageChange(this)
                    announcementTab.reload({
                        where:{
                            page: pages,
                            pageSize: 6,
                            useFlag: true,
                            typeId: 0,
                            read:'',
                            sendTime:''
                        }
                    })
                })
            }
        });
        table.on('row(noticeDemo)', function(obj){
            var data = obj.data;
            obj.tr.attr("data-url",'/notice/detail?notifyId=' + data.notifyId);
            tiaozhuan(obj.tr)
        });
    });
    function setData(Id, data) {
        table.render({
            elem: Id  //table的id属性
            ,data: data  //后台获取的数据
            ,height: 320
            ,skin: 'nob'
            ,page:{
                layout: ['prev', 'next'] //自定义分页布局
            }
            ,limit:6
            ,cols: [[
                {title: '文件标题',  align:'center',templet: function(d){
                        return d.flowName
                    }
                }
            ]]
            ,done:function(res){
                $("#nigaoDemo").css("width","100%");
                var totleNum = res.count
                $("#nigao-count").html(totleNum);
            }
        });
    }
    // 发文拟稿和收文格式便捷跳转
    // $('.head-top li').click(function () {
    //     $(this).siblings('li').removeClass('active')
    //     $(this).addClass('active')
    //     if ($(this).attr('data-type') == '') {
    //     } else if ($(this).attr('data-type') == '0') {
    //     }
    // })
    // $('ul').height($(window).height() / 2 - 47)

    //标题栏右侧 添加选中效果
    // $('.title span').click(function () {
    //     if (!$(this).hasClass('a')) {
    //         $(this).siblings().removeClass('active');
    //         $(this).addClass('active');
    //     }
    //
    // })

    //我的公文'.acti点击更多的跳转
    // function documentMore(me) {
    //     var urls = $(me).parent().find('.active').attr('urls');
    //     var url = $(me).parent().find('.active').attr('url');
    //     var element = $(me).parent().find('.active');
    //     if (urls == '1') {
    //         var tid = '650105';
    //     } else if (urls == '0') {
    //         var tid = '650505';
    //     }
    //     parent.getUrlMenuOpen(tid, element);
    // }

    //待办工作点击事件
    // function windowOpenNew(me) {
        // window.open($(me).attr('data-url'))
    // }

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
</script>
</body>
</html>
