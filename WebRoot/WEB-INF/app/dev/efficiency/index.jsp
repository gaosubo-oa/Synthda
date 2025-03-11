<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>效能监察</title>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=0.3, user-scalable=0, minimum-scale=0, maximum-scale=5.0,user-scalable=yes">
    <link rel="stylesheet" type="text/css" href="../css/base.css"/>
    <script src="../js/xoajq/xoajq1.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .navigation {
            margin-left: 3%;
        }

        .head {
            height: 45px;
            position:fixed;
            top:0px;
            background:#fff;
            width: 100%;
        }

    </style>
</head>
<body style="overflow: hidden">
<div>
    <%--标题头--%>
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id="" url="/FlowRunFu/KeyWorkConfirmation">
                <span class="one headli1_1">
                 重点工作确认
               </span>
                <img class="headli1_2" src="../img/twoth.png" alt=""/>
            </li>

            <li data_id="1" url="/FlowRunFu/KeyWorkSupervision">
                <span class="headli3_1">
                  重点工作监察
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2" url="/FlowRunFu/KeyWorkStatistics">
                <span class="headli3_1">
                  重点工作统计
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2" url="/FlowRunFu/routineWorkSupervision">
            <span class="headli3_1">
                  常规工作监察
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
            <li data_id="2" url="/FlowRunFu/routineWorkStatistic">
            <span class="headli3_1">
                  常规工作统计
               </span>
                <img src="../img/twoth.png" alt="" class="headli2_2"/>
            </li>
        </ul>
    </div>
</div>
<div style="width:100%;height:95%;">
    <iframe class="fixAssets_iframe" src="/FlowRunFu/KeyWorkConfirmation" frameborder="0" width="100%"
            height="100%"></iframe>
</div>
<script>
    //标题头操作
    $(function () {
        /*点击标题，获取对应的url，显示对应的src*/
        $('.index_head').on('click', 'li', function () {
            // 设置样式
            $('.index_head span').removeClass("one")
            $(this).children("span").addClass("one");
            // 获取url
            var url = $(this).attr('url');
            $('.fixAssets_iframe').attr('src', url);
        });
    });

    function show() {
        $('.index_head li').eq(0).find('span').addClass('one').parent().siblings().find('span').removeClass('one')
    }
</script>
</body>
</html>