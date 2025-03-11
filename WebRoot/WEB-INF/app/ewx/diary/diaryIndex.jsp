<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <title></title>
    <script src="/js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="../../js/base/base.js"></script>
    <script type="text/javascript" src="../../js/ewx/waterMark.js?20190819.2"></script>
    <script type="text/javascript" src="../lib/mui/mui/mui.min.js"></script>
    <script type="text/javascript" src="../js/diary/m/vue.min.js"></script>
    <%--    <link href="../lib/mui/mui/mui.min.css" rel="stylesheet">--%>
    <%--    <link rel="stylesheet" type="text/css" href="../css/diary/m/diary_base.css"/>--%>
    <style>
        html, body {
            height: 100%;
            padding: 0px;
            margin: 0px;
        }
        body {
            font-family: "Helvetica Neue",Helvetica,STHeiTi,sans-serif;
            line-height: 1.5;
            font-size: 16px;
            color: #000;
            background-color: #f8f8f8;
            -webkit-user-select: none;
            -webkit-text-size-adjust: 100%;
            -webkit-tap-highlight-color: transparent;
            outline: 0;
        }
        .main {
            width: 100%;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        .cbox {
            display: flex;
            flex-direction: column;
            flex: 13;
        }
        .indexHead{
            flex: 6;
            background: url(/img/diary/m/header.png);
            -webkit-background-size: 100% 100%;
            -moz-background-size: 100% 100%;
            -o-background-size: 100% 100%;
            background-size: 100% 100%;
        }
        .center {
            display: flex;
            width: 100%;
            flex-wrap: wrap;
            flex: 7;
        }
        .boder_rt {
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }
        .box {
            display: flex;
            flex-direction: column;
            width: 33.33%;
            box-sizing: border-box;
            justify-content: center;
            align-items: center;
        }
        .box img {
            width: 30px;
            height: 30px;
            display: block;
            margin-bottom: 13px;
        }
        .box span {
            font-size: 12px;
            letter-spacing: 0.06rem;
        }
        .boder_right {
            border-right: 1px solid #ddd;
        }
        .noComNum {
            position: absolute;
            right: 0px;
            top: 0px;
            background: #F81901;
            color: #fff;
            border-radius: 50%;
            width: 17px;
            text-align: center;
            padding: 4px;
            display: none;
            letter-spacing: 0.01rem !important;
        }
        .bottom {
            flex: 1;
            display: flex;
            box-sizing: border-box;
            border-top: 1px solid #000;
            width: 100%;
            background: #fff;
            padding: 0.3rem;
            z-index: 2;
        }
        .bottom div {
            display: flex;
            box-sizing: border-box;
            flex-direction: column;
            flex: 1;
            justify-content: center;
            align-items: center;
        }
        .bottom img {
            width: 35px;
            display: block;
        }
        .bottom span {
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="main">
    <div class="cbox">
        <div class="indexHead"></div>
        <div class="center">
            <div class="box boder_rt launch"><img src="/img/diary/m/wdfq.png"><span>我发起的</span></div>
            <div class="box boder_rt NoComment" style="position:relative"><img style="width: 30px;height: 30px;" src="/img/diary/m/Comment.png">
                <span>点评日志</span><span class="noComNum"></span>
            </div>
            <div class="box boder_rt share"><img src="/img/diary/m/fxgw.png"><span>分享给我的</span></div>
            <div class="box boder_rt query"><img src="/img/diary/m/rzcx.png"><span>我的下属</span></div>
            <div class="box boder_rt add"><img src="/img/diary/m/xjrz.png"><span>新建日志</span></div>
            <div class="box boder_right draft"><img src="/img/diary/m/cg.png"><span>草稿</span></div>
        </div>
    </div>
    <%--        <div class="tongji" style="display: none;flex: 13">--%>
    <%--            <iframe name="notices" src="/ewx/reportStatis" frameborder="0" style="height: 100%;width: 100%"></iframe>--%>
    <%--        </div>--%>
    <div class="bottom">
        <div class="manage"><img src="/img/diary/m/gl.png" alt=""><span>管理</span></div>
        <div class="stat"><img src="/img/diary/m/tj_.png" alt=""><span>统计</span></div>
    </div>
</div>
</body>
<script type="text/javascript" charset="gbk">
    //获取未点评日志的数量
    $.ajax({
        type:'get',
        url:'/diary/notCommentDiary',
        data:{
            startTime: DateFormat(getNowMonthFirst(), "yyyy-MM-dd"),
            endTime: DateFormat(getNowMonthLast(), "yyyy-MM-dd")
        },
        dataType:'json',
        success:function(res){
            if(res.flag && res.obj != null && res.obj.length > 0){
                $('.noComNum').show();
                $('.noComNum').html(res.totleNum);
            }
        }
    });

    /**
     * 获取本月第一天
     */
    function getNowMonthFirst(){
        var firstDay = new Date();
        firstDay.setDate(1);
        return firstDay;
    }

    /**
     * 获取本月最后一天
     */
    function getNowMonthLast(){
        var date = new Date();
        var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        return lastDay;
    }

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

    //跳转统计页
    $('.stat').click(function() {
        $('.manage img').attr("src", '/img/diary/m/gl_.png');
        $('.stat img').attr("src", '/img/diary/m/tj.png');
        // $('.cbox').css('display','none')
        // $('.tongji').css('display','block')
        location.href = "/ewx/reportStatis"
    })
    $('.manage').click(function() {
        $('.manage img').attr("src", '/img/diary/m/gl.png');
        $('.stat img').attr("src", '/img/diary/m/tj_.png');
        $('.cbox').css('display','flex')
        $('.tongji').css('display','none')
    })
    var diaType = $.GetRequest().dataType != undefined ? $.GetRequest().dataType : "";
    $('.launch').click(function() {
        location.href = "/ewx/iStartedList?type=initiated&dataType=" + diaType;
    })
    $('.share').click(function() {
        location.href = "/ewx/iStartedList?type=shareMy&dataType=" + diaType;
    })
    $('.draft').click(function() {
        location.href = "/ewx/diaryList?type=draft&dataType=" + diaType;
    })
    $('.NoComment').click(function() {
        location.href = "/ewx/logList?type=logList&dataType=" + diaType;
    })
    $('.query').click(function() {
        location.href = "/ewx/myBranch?type=myBranch&dataType=" + diaType;
    })
    $('.add').click(function() {
        location.href = "/ewx/diaryCreate?type=add&dataType=" + diaType;
    })
</script>
</html>
