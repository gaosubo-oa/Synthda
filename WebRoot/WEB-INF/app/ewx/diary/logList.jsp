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
    <meta http-equiv="Content-Type" content="text/html; charset=gbk">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <title>点评日志</title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../../lib/mui/mui/mui.min.js"></script>
    <script src="/lib/layui/layui/layui.js"></script>
    <link href="../../lib/mui/mui/mui.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="../css/diary/m/iStarted.css">
    <link rel="stylesheet" href="../css/diary/m/diary_base.css?20221103" />
    <link rel="stylesheet" href="/lib/layui/layuiadmin/layui/css/layui.css?20210319.1">
    <script type="text/javascript">
        var td_lang = {};
        td_lang.pda = {
            msg_1:'暂无更多信息',
            msg_2:'加载中...',
            msg_3:'页面加载错误',
            msg_4:'下拉刷新...',
            msg_5:'释放立即刷新...',
            msg_6:'上拉加载更多...',
            msg_7:'释放加载更多...',
            msg_8:'已全部加载完毕',
            msg_9:'读取附件中...',
            no_cnt:'暂无信息',
            cancel:'取消',
            reload:'重新加载',
        };	var P = "jfdrhe0g49n9g4bp5afvf5kmj6";
        var C_VER = "";
        var P_VER = "";
        var isIDevice = (/iphone|ipad/gi).test(navigator.appVersion);

    </script>

<%--    <script type="text/javascript">--%>
<%--        var WXS = {};--%>
<%--        var C_VER = "";--%>
<%--        var P_VER = "";--%>
<%--        var isIDevice = (/iphone|ipad/gi).test(navigator.appVersion);--%>
<%--        WXS.URI = window.location.protocol + "//" + window.location.host;--%>
<%--        WXS.WXState = "=4a2a0/9yIo3bsB8NzD0KyKtzHK+r5/Ry";--%>
<%--        WXS.P = "";--%>

<%--        wx.config({--%>
<%--            beta: true,--%>
<%--            debug: !true,--%>
<%--            appId: 'wxbde984c3488b837e',--%>
<%--            timestamp: '1655693203',--%>
<%--            nonceStr: 'BGOepyb67VNARV7M',--%>
<%--            signature: 'd2b6d4b53e89a8850d1cf10be8bb20dadfbf17d6',--%>
<%--            jsApiList: [--%>
<%--                'hideMenuItems','previewImage','chooseImage','uploadImage'--%>
<%--            ]--%>
<%--        });--%>

<%--        // 此为业务逻辑层可以独立使用，无关乎平台--%>
<%--        (function(TMSDK){--%>
<%--            TMSDK.ready(function () {--%>

<%--                TMSDK.hideOptionMenu();--%>

<%--                //TMSDK.previewImage($(".read_content .img_wrap"));--%>

<%--            })--%>
<%--        })(tMobileSDK);--%>

<%--        wx.error(function (res) {--%>
<%--            //alert(res.errMsg);--%>
<%--        });--%>

<%--        var Util = {--%>
<%--            preLoadImage: function(obj, url){--%>
<%--                //图片的预加载--%>
<%--                var oImg = $(".read_content img");--%>
<%--                oImg.each(function(){--%>
<%--                    $(this).wrap("<div class='img_wrap'></div>");--%>
<%--                    var obj = $(this).parent(".img_wrap");--%>
<%--                    var url = $(this).attr("src");--%>
<%--                    var img = new Image();--%>
<%--                    img.src = url;--%>
<%--                    obj.addClass("WX_loading");--%>
<%--                    if(img.complete){--%>
<%--                        obj.removeClass("WX_loading").empty().append(img);--%>
<%--                        return;--%>
<%--                    }--%>
<%--                    img.onload = function(){--%>
<%--                        obj.removeClass("WX_loading").empty().append(img);--%>
<%--                    };--%>
<%--                    img.onerror = function(){--%>
<%--                        obj.html('图片加载失败！');--%>
<%--                        obj.removeClass("WX_loading");--%>
<%--                    };--%>
<%--                });--%>
<%--                return this;--%>
<%--            },--%>
<%--            pageTitle: function(t){--%>
<%--                document.title = t;--%>
<%--            },--%>
<%--            loadDefaultAvatar: function(o, s){--%>
<%--                o.onerror = function(){--%>
<%--                    o.src =  WXS.URI + "/static/images/avatar/" + s + ".png";--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>
<%--    </script>--%>

    <script>

        $(function(){
            $('body').delegate('.ui-attachment-wrap a[_href]','click',function(e){
                e.stopPropagation();
                e.preventDefault();
                e.stopImmediatePropagation();
                var me = $(this);
                //alert(this.getAttribute('_href'));
                if(me.attr("is_image") == 1){
                    var curUrl = me.attr("_href");
                    var urls = [];
                    var siblings = me.parent().children();
                    siblings.forEach(function(item){
                        if($(item).attr("is_image") == 1){
                            urls.push($(item).attr("_href"));
                        }
                    });

                    tMobileSDK.previewImage(curUrl,urls);
                } else {
                    //alert(this.getAttribute('_href'));
                    window.location.assign(this.getAttribute('_href'));
                    //window.location.assign('http://baidu.com');
                }

            });
        });

        //To collect some client infomations
        // tMobileSDK.collectInfo("http://stat.tongda2000.com/h5app/");
    </script>
</head>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>日志点评</title>
    <style>
        body {
            padding: 10px;
        }

        .layui-tab {
            margin-bottom: 0;
        }

        .layui-tab-title li {
            min-width: 77;
        }

        .layui-tab-item .calendar {
            width: 100%;
            text-align: center;
            padding-bottom: 10px;
        }

        .layui-tab-item .content {
            height: calc(100vh - 470px);
            overflow-y: scroll;
            background-color: #F2F2F2;
        }

        .dairy-item li {
            margin: 5px;
        }

        .dairy-item li .layui-card {
            border-radius: 5px;
        }

        .dairy-item li .layui-card .layui-card-header {
            height: 27px;
            line-height: 27px;
            font-size: 12px;
            color: black;
        }

        .dairy-item li .layui-card .layui-card-body {
            padding: 0 15px;
            line-height: 27px;
            font-size: 12px;
        }

        .comment,
        .consult {
            float: right;
        }

        .consult {
            margin-right: 10px;
        }

        .content-msg {
            color: #333;
            font-size: 12px;
        }

        .layui-btn-group {
            margin-top: 10px;
            width: 100%;
            text-align: center;
        }

        .layui-btn-group .layui-btn {
            height: 27px;
            line-height: 20px;
            font-size: 12px;
            padding: 0 15px;
            color: #666;
            background-color: #fff;
            border: 1px solid #ddd;
            box-sizing: border-box;
        }

        .layui-btn-group .layui-btn {
            border-right: 0;
        }

        .layui-btn-group .layui-btn:first-child {
            border-radius: 10px 0px 0px 10px;
        }

        .layui-btn-group .layui-btn:last-child {
            border-radius: 0px 10px 10px 0px;
            border-right: 1px solid #ddd;
        }

        .too-long-hide {
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            display: block;
        }

        .position-bottom {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
        }

        .layui-form-item label {
            padding-top: 5px;
        }

        .layui-form-item input {
            line-height: 30px;
            height: 30px;
        }

        .layui-form-item dl {
            top: 32px;
            max-height: 200px;
        }

        .layui-form-item dl dd {
            line-height: 30px;
        }

        .layui-tab-brief>.layui-tab-title .layui-this {
            color: #fea942;
        }

        .layui-tab-brief>.layui-tab-title .layui-this::after {
            border-bottom: 2px solid #fe9900
        }

        .layui-btn {
            background-color: #1772c0;
        }

        .layui-btn-primary {
            background-color: white;
        }

        .laydate-theme-molv .layui-laydate-content {
            border: 0;
        }

        .laydate-day-mark::after {
            background-color: #fe9900 !important;
        }

        .calendar div {
            width: 100%;
        }

        .calendar table {
            width: 100%;
        }

        #form-head .layui-form-item .layui-input-block {
            margin-left: 0;
            min-height: 0;
        }

        #form-head input {
            height: 30px;
            line-height: 23px;
            border-radius: 11px;
            border-width: 0;
            background-color: #F2F2F2;
        }
        .dot:after {
            content: "";
            position: absolute;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            left: 50%;
            bottom: -2px;
            margin-left: -1px;
            color: red;
        }
        #dot {
            color: red!important;
        }
        .layui-form-select {
            width: 220px;
        }
    </style>
</head>

<body>
<div>
    <form id="form-head" class="layui-form" style="display: inline-block;width: calc(100% - 40px);">
        <div class="layui-form-item" style="margin-bottom: 0;">
            <div class="layui-input-block">
                <input type="text" name="bottomId" id="bottomId" autocomplete="off" placeholder="请选择或是输入需要的元素" class="layui-input"
                       style="position: absolute; z-index: 2; width: 200px; border-color: white;" lay-verify="required">
                <select name="bottomId_select" id="bottomId_select" class="layui-select" lay-filter="bottomId_select" lay-search>
                    <option value="">请选择下属人员</option>
                </select>
            </div>
        </div>
    </form>
    <i id="btn-show-query" class="layui-icon layui-icon-more" style="padding:7px;float:right;"></i>
    <form id="form-query" class="layui-form" style="display: none; padding: 10px;">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 86px;">关键词：</label>
            <div class="layui-input-block" style="margin-left: 86px;">
                <input id="keyword" type="text" name="keyword" placeholder="请输入关键字" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item position-bottom">
            <div class="layui-input-block" style="margin-left: calc(50% - 59px);">
                <button id="btn-query" class="layui-btn" lay-submit lay-filter="form-query">查询</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div class="layui-tab layui-tab-brief" lay-filter="laytab">
    <ul class="layui-tab-title" id="laytab" style="padding-left: calc(50% - 143px);">
        <li lay-id="all">全部</li>
        <li lay-id="week">周报</li>
        <li lay-id="diary">日报</li>
    </ul>
    <div class="layui-btn-group" id="btnGrpStatus">
        <button type="button" class="layui-btn">全部</button>
        <button type="button" class="layui-btn" style="background-color: #1772c0;color: #fff;border: 0;">未评</button>
        <button type="button" class="layui-btn">已评</button>
        <button type="button" class="layui-btn">未读</button>
        <button type="button" class="layui-btn">已读</button>
        <button type="button" class="layui-btn">只读</button>
    </div>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div class="calendar" id="laydateall"></div>
            <div class="content" id="contentall"></div>
        </div>
        <div class="layui-tab-item">
            <div class="calendar" id="laydateweek"></div>
            <div class="content" id="contentweek"><i class='layui-icon layui-icon-loading'></i></div>
        </div>
        <div class="layui-tab-item">
            <div class="calendar" id="laydatediary"></div>
            <div class="content" id="contentdiary"><i class='layui-icon layui-icon-loading-1'></i></div>
        </div>
    </div>
</div>
<div class="position-bottom" style="height: 32px;padding-left: 10px;padding-right: 10px;bottom:5px;">
    <button id="readAll" type="button" class="layui-btn" style="height: 32px;line-height: 32px;width: 100%;border-radius: 10px;">一键全部阅读</button>
</div>
<script>
    window.addEventListener("pageshow", function(e){
        if(e.persisted){
            window.location.reload()
        }
    });
    var preDate = '';
    var tempData = {};
    var tempListData = {};
    var para = {
        tabId: 'week',
        day: '',
        start: '',
        end: '',
        logType: 3,//日志类型：0全部，1工作日志，3工作周报
        readStatus: 0,
        comStatus: 1,
        keyword: '',
        staffType: 0,//人员，0下属，1只读范围
        reading: 0
    };
    // var para = localStorage.getItem("log_list_para");
    // para = JSON.parse(para);
    // if (para == undefined || para == null) {
    //     para = {
    //         tabId: 'week',
    //         day: '',
    //         start: '',
    //         end: '',
    //         logType: 3,//日志类型：0全部，1工作日志，3工作周报
    //         readStatus: 0,
    //         comStatus: 1,
    //         keyword: '',
    //         staffType: 0,//人员，0下属，1只读范围
    //         reading: 0
    //     };
    // }
    layui.use(['laydate', 'laypage', 'layer', 'table', 'carousel', 'upload', 'element', 'slider'], function() {
        var laydate = layui.laydate; //日期
        var layer = layui.layer; //弹层
        var element = layui.element; //元素操作
        var form = layui.form;
        //tab切换事件
        element.on('tab(laytab)', function() {
            para.tabId = layui.$(this).attr("lay-id");
            if (para.tabId == "all"){
                para.logType = 0;
            } else if (para.tabId == "diary"){
                para.logType = 1;
            } else if (para.tabId == "week"){
                para.logType = 3;
            }
            loadDateData();
        });

        //加载日历数据
        function loadDateData() {
            var dateid = '#laydate' + para.tabId;
            layui.$(dateid).html('');
            //加载数据
            layui.$.ajax({
                url: '/diary/getBottomLogIdDates',
                type: 'POST',
                data: para,
                dataType: 'json',
                success: function(res) {
                    layui.$(dateid).html('');
                    tempData = res.object;
                    var mark = {};
                    for (var item in res.object) {
                        mark[item] = '';
                    }
                    //将日期直接嵌套在指定容器中
                    var dateIns = laydate.render({
                        elem: dateid,
                        mark: mark,
                        theme: '#fea942',
                        startOfWeek: 'monday',
                        value: para.day,
                        position: 'static',
                        showBottom: false,
                        ready: function(date) {
                            //日期页展示
                            layui.$(".layui-laydate-header").css("background-color", "#fff");
                            layui.$(".layui-laydate-header").css("border", "1px solid #e2e2e2");
                            layui.$(".layui-laydate-header").css("border-bottom", "none");
                            layui.$(".layui-laydate-header i").css("color", "#666");
                            layui.$(".layui-laydate-header span").css("color", "#666");
                            layui.$(".laydate-day-mark::after").css("background-color", "#666");
                            layui.$(".layui-laydate-main").css("width", "100%");
                            //
                            preDate = date.year + "-" + date.month;
                            loadDayData();
                        },
                        change: function(value, date, endDate) {
                            if (para.day != value){
                                setParaDate(new Date(value));
                            }
                            loadDayData();
                        },
                        done:function(value) {
                        }
                    });
                }
            });

        }
        //加载日志列表数据
        function loadDayData() {
            var contentId = "#content" + para.tabId;
            //获取列表id
            var diaIds = "";
            if (para.tabId == "week") {
                layui.$("td").removeClass("layui-this");
                var start = new Date(para.start);
                for (var i = 0; i < 7; i++) {
                    var datestr = DateFormat(start, "yyyy-MM-dd");
                    var nod = layui.$("td[lay-ymd='" + DateFormat(start, "yyyy-M-d") + "']");
                    if (nod.length < 1) {
                        continue;
                    }
                    nod.addClass("layui-this");
                    if (tempData != undefined && tempData != ""){
                        var temp = tempData[datestr];
                        if (temp != undefined && temp != "") {
                            diaIds += (diaIds == "" ? "" : ",") + temp;
                        }
                    }
                    start = new Date(start.setDate(start.getDate() + 1));
                }
            } else {
                if (tempData != undefined && tempData != ""){
                    diaIds = tempData[para.day];
                }
            }
            if (diaIds == undefined || diaIds == "") {
                layui.$(contentId).html("");
            }
            //
            var html = "<i class='layui-icon layui-icon-loading layui-anim layui-anim-rotate layui-anim-loop' style='font-size:30px;''></i>";
            html = "<div style='text-align:center;margin-top:50px;'>" + html + "</div>";
            layui.$(contentId).html(html);
            layui.$.ajax({
                url: '/diary/mobileTerminalCommentDiary',
                type: 'POST',
                data: para,
                dataType: 'json',
                success: function(data) {
                    layui.$(contentId).html("");
                    if (data.flag == false) {
                        return;
                    }
                    if (data.obj.length < 1) {
                        return;
                    }
                    data.obj = data.obj.sort((a, b) => {
                        return a.IS_READ - b.IS_READ;
                    })
                    data.obj = data.obj.sort((a, b) => {
                        return a.IS_COM - b.IS_COM;
                    })
                    tempListData = data.obj;
                    var html = "<ul class='dairy-item'>";
                    for (var item in data.obj) {
                        item = data.obj[item];
                        html += '<li data-id="' + item.diaId + '" style="margin: 5px 2px;">';
                        html += '<div style="overflow: hidden;background: #fff;height: 72px;">';
                        html += '<div style="width: 62px;height: 62px;float: left;margin: 5px;">';
                        html += '<img data-userId="' + item.userId + '" style="width: 100%;height: 100%;" src="'+function(){
                            if(item.avatar==''){
                                return '../../img/user/boy.png'
                            }else if(item.avatar=='0'){
                                return '../../img/user/boy.png'
                            }else if(item.avatar=='1'){
                                return '../../img/user/girl.png'
                            }else {
                                return '../../img/user/'+item.avatar
                            }
                        }() +'">';
                        html += '</div><div style="width: calc(100% - 72px);float: left;height: 100%;">';
                        html += '<div class="" style="color: #666;margin-top:5px">' + item.subject + '</div>';
                        html += '<div class="" style="height: calc(100% - 41px);">';
                        html += '<div style="position: relative;top: 40%;transform: translateY(-50%);">';
                        html += '<span style="color: #fe9900;font-size: 13px;">' + item.userName + '</span>';
                        html += '<span style="color: #c9c9c9;margin-left: 5px;font-size: 10px;">' + item.deptName + '</span></div>';
                        html += '</div><div style="width: 100%;float: left;font-size: 12px;line-height: 100%;">';
                        html += '<span class="" style="color: #666;">' + item.diaDate + '</span>';
                        html += '<span class="comment" style="margin-right: 5px;background:none;margin-left:0px;padding-left:0px;color: ' + function(){
                            if(item.isComments > 0){
                                return '#1772c0'
                            }else{
                                return '#fe9900'
                            }
                        }()
                        html += ';font-size: 9px;">评(' + item.comTotal + ')</span>' +
                            '<span class="consult" style="color: ' + function(){
                                if(item.numberOfQueries > 0){
                                    return '#1772c0'
                                }else{
                                    return '#fe9900'
                                }
                        }() + ';font-size: 9px;background: none">阅(' + item.numberOfQueries + ')</span>';
                        html += '</div></div></div></li>';
                    }
                    html += "</div>";
                    layui.$(contentId).html(html);
                    layui.$(contentId + " li").click(function() {
                        var diaId = layui.$(this).attr("data-id");
                        localStorage.setItem("log_list_para", JSON.stringify(para));
                        window.location = '/ewx/consult?id=' + diaId;
                    });
                }
            });
        }

        //头部搜索按钮点击事件;
        layui.$("#btn-show-query").click(function() {
            var width = layui.$("body").width() - 100;
            width = width < 500 ? width = 'auto' : width + "px";
            layer.open({
                title: '&nbsp;',
                type: 1,
                content: layui.$("#form-query"),
                offset: '100px',
                area: [width, '300px'],
                shadeClose: true
            });
        });
        //查询按钮点击事件
        form.on('submit(form-query)', function(data) {
            para.keyword = data.field.keyword;
            loadDateData();
            layer.closeAll();
            return false;
        });
        //头部选择人员
        //设置select 与 input 输入框联动
        form.on("select(bottomId_select)", function(data) {
            $("#bottomId").val($("#bottomId_select option:selected").text()); //这里直接将选中的内容设置给input框达到选择input时让它俩联动起来
            $("#bottomId_select").next().find("dl").css({"display": "note"});
            form.render();

            para.bottomId = layui.$("#bottomId_select").val();
            if (para.bottomId == undefined) {
                para.bottomId = "";
            }
            loadDateData();
        });
        //给input框加监听
        $("#bottomId").on('input',function () {
            //这里是获取input输入的值设置给select 这里的select 一定要添加一个 lay-search 这个属性，否则select 不可搜索
            var value =$("#bottomId").val();
            value = value.replace(/^\s*/,"");//利用正则去除左侧空格
            $("#bottomId_select").val(value);
            form.render();
            $("#bottomId_select").next().find(".layui-select-title input").click();
            var dl = $("#bottomId_select").next().find("dl").children();
            var j = -1;

            for (var i = 0; i < dl.length; i++){
                if (dl[i].innerHTML.indexOf(value) <= -1){
                    dl[i].style.display = "none";
                    j++;
                }
                if (j == dl.length-1){
                    $("#bottomId_select").next().find("dl").css({"display":"note"});
                }
            }
        });
        //按钮组点击事件
        layui.$("#btnGrpStatus button").click(function() {
            var nod = layui.$(this);
            var txt = nod.html();
            layui.$("#btnGrpStatus button").each(function(i, e) {
                var t = layui.$(e).html();
                layui.$(e).css("background-color", t == txt ? "#1772c0" : "");
                layui.$(e).css("color", t == txt ? "#fff" : "");
                layui.$(e).css("border", t == txt ? "0" : "");
            });
            if (txt == "全部") {
                para.readStatus = 0;
                para.comStatus = 0;
                para.staffType = 0;
            } else if (txt == "未读") {
                para.readStatus = 1;
                para.comStatus = 0;
                para.staffType = 0;
            } else if (txt == "已读") {
                para.readStatus = 2;
                para.comStatus = 0;
                para.staffType = 0;
            } else if (txt == "未评") {
                para.readStatus = 0;
                para.comStatus = 1;
                para.staffType = 0;
            } else if (txt == "已评") {
                para.readStatus = 0;
                para.comStatus = 2;
                para.staffType = 0;
            } else if (txt == "只读"){
                para.readStatus = 0;
                para.comStatus = 0;
                para.staffType = 1;
            }
            loadDateData();
        });
        layui.$("#readAll").click(function() {
            layer.confirm('确认阅读所有下属日志?', {
                icon: 3,
                title: '提示'
            }, function(index) {
                layer.close(index);
                para.reading = 1;
                var loadIndex = layer.load();
                layui.$.ajax({
                    url: '/diary/mobileTerminalCommentDiary',
                    type: 'POST',
                    data: para,
                    dataType: 'json',
                    success: function(data) {
                        // console.log(data);
                    },
                    complete: function() {
                        layer.close(loadIndex);
                    }
                });
                loadDateData();
            });
        });
        /*//加载头像数据
        function loadHeadImg() {
            if (tempListData.length < 1) {
                return;
            }
            var ids = tempListData[0].userId;
            for (var i = 1; i < tempListData.length; i++) {
                ids += "," + tempListData[i].userId;
            }
            layui.$.ajax({
                // url: '/hr/api/getOaHeadPortrait',//先使用oa头像回显
                url: '/ewx/getHeadPortrait',//获取企业微信头像
                type: 'POST',
                data: {
                    userIds: ids
                },
                dataType: 'json',
                success: function(data) {
                    if (data.flag == false) {
                        return;
                    }
                    layui.$("img").each(function() {
                        var nod = layui.$(this);
                        var userid = nod.attr("data-userId");
                        if (userid == undefined) {
                            return;
                        }
                        if (data.data[userid] != "") {
                            nod.attr("src", data.data[userid]);
                        } else {
                            nod.attr("src", "../../img/diary/m/head.png");
                        }
                        nod.show();
                    })
                }
            });
        }*/
        //初始化人员
        function loadFormBottom() {
            layui.$.ajax({
                url: '/userHierarchy/selectUserHierarchy',
                type: 'POST',
                data: {},
                dataType: 'json',
                success: function(data) {
                    if (data.flag == false) {
                        return;
                    }
                    if (data.object != undefined && data.object != null){
                        var userBottomIds = data.object.userBottomId.split(",");
                        var userBottomIdNames = data.object.userBottomIdName.split(",");
                        for (var i = 0; i < userBottomIds.length; i++) {
                            layui.$("#bottomId_select").append("<option value='" + userBottomIds[i] + "'>" + userBottomIdNames[i] + "</option>");
                        }
                        if (para.bottomId != undefined && para.bottomId != 0) {
                            layui.$("#bottomId_select").val(para.bottomId);
                        }
                    }
                    form.render();
                }
            });
        };
        //初始化
        loadFormBottom();
        if (para.day == "") {
            setParaDate(new Date());
        } else {
            var dd = new Date(para.day);
            if (dd.getDate() == NaN) {
                setParaDate(new Date());
            }
        }
        if (para.keyword != "") {
            layui.$("#keyword").val(para.keyword);
        }
        if (para.readStatus != 0) {
            var txt = para.readStatus == 1 ? "未读" : "已读";
            layui.$("#btnGrpStatus button").each(function(i, e) {
                var t = layui.$(e).html();
                layui.$(e).css("background-color", t == txt ? "#1772c0" : "");
                layui.$(e).css("color", t == txt ? "#fff" : "");
                layui.$(e).css("border", t == txt ? "0" : "");
            });
        }
        if (para.comStatus != 0) {
            var txt = para.comStatus == 1 ? "未评" : "已评";
            layui.$("#btnGrpStatus button").each(function(i, e) {
                var t = layui.$(e).html();
                layui.$(e).css("background-color", t == txt ? "#1772c0" : "");
                layui.$(e).css("color", t == txt ? "#fff" : "");
                layui.$(e).css("border", t == txt ? "0" : "");
            });
        }
        layui.$("li[lay-id='" + para.tabId + "']").click();
    });

    //设置参数时间;
    function setParaDate(date) {
        if (date == undefined) {
            date = new Date();
        }
        para.day = DateFormat(date, "yyyy-MM-dd");
        //初始化开始，结束时间  当首次进入
        if (para.start == "" && para.end == ""){
            var day = date.getDay();
            if (1 <= day && day <= 2){
                //周一和周二用上周
                para.start = DateFormat(getLastMonday(date), "yyyy-MM-dd");
                para.end = DateFormat(getLastSunday(date), "yyyy-MM-dd");
            } else if (day == 0 || (3 <= day && 6 >= day)) {
                //周三到周七用本周
                para.start = DateFormat(getMonday(date), "yyyy-MM-dd");
                para.end = DateFormat(getSunday(date), "yyyy-MM-dd");
            }
        } else {
            para.start = DateFormat(getMonday(date), "yyyy-MM-dd");
            para.end = DateFormat(getSunday(date), "yyyy-MM-dd");
        }
        var ym = DateFormat(date, "yyyy-MM");
        if (preDate != ym && preDate != '') {
            preDate = ym;
            return true;
        }
        return false;
    }
    //获取月份最后一天
    function getMonthLastDateFn(day) {
        let dateObj = new Date(day);
        let nextMonth = dateObj.getMonth() + 1; //0-11，下一个月
        dateObj.setMonth(nextMonth); //设置当前日期为下个月的1号
        dateObj.setDate(1); //1-31
        let nextMonthFirstDayTime = dateObj.getTime(); //下个月一号对应毫秒
        let theMonthLastDayTime = nextMonthFirstDayTime - 24 * 60 * 60 * 1000; //下个月一号减去一天，正好是这个月最后一天
        return new Date(theMonthLastDayTime);
    }
    //获取周一
    function getMonday(date) {
        var day = date.getDay() || 7;
        return new Date(date.getFullYear(), date.getMonth(), date.getDate() + 1 - day);
    };
    //获取周日
    function getSunday(date) {
        var day = date.getDay() || 7;
        return new Date(date.getFullYear(), date.getMonth(), date.getDate() + 7 - day);
    };
    //获取上周一
    function getLastMonday(date) {
        var mondayTime = getMonday(date).getTime();//本周一时间戳
        var oneDayTime = 24 * 60 * 60 * 1000;//一天的时间戳
        var lastMonday = new Date(mondayTime - oneDayTime * 7);//上周一
        return lastMonday;
    };
    //获取上周日
    function getLastSunday(date) {
        var sundayTime = getSunday(date).getTime();//本周日时间戳
        var oneDayTime = 24 * 60 * 60 * 1000;//一天的时间戳
        var lastSunday = new Date(sundayTime - oneDayTime * 7);//上周日
        return lastSunday;
    };
    //日期格式化
    function DateFormat(date, fmt) {
        var o = {
            "M+": date.getMonth() + 1,
            "d+": date.getDate(),
            "h+": date.getHours(),
            "m+": date.getMinutes(),
            "s+": date.getSeconds(),
            "q+": Math.floor((date.getMonth() + 3) / 3),
            "S": date.getMilliseconds()
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
    Date = function(Date) {
        MyDate.prototype = Date.prototype;
        return MyDate;

        function MyDate() {
            // 当只有一个参数并且参数类型是字符串时，把字符串中的-替换为/
            if (arguments.length === 1) {
                let arg = arguments[0];
                if (Object.prototype.toString.call(arg) === '[object String]' && arg.indexOf('T') === -1) {
                    arguments[0] = arg.replace(/-/g, "/");
                    // console.log(arguments[0]);
                }
            }
            let bind = Function.bind;
            let unbind = bind.bind(bind);
            return new(unbind(Date, null).apply(null, arguments));
        }
    }(Date);
</script>
</body>

</html>