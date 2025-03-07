<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>手机短信</title>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/theme6/commonTheme.css"/>
</head>
<style>
    .news{
        cursor: pointer;
    }
    #iframebox{
        width: 100%;
    }
    .head .index_head li img {
        margin-left: 10px;
    }
    .head .index_head li span {

        margin-left: 10px!important;

    }
</style>
<body style="background: #fff">
<div class="navigation clearfix">
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id="0" data-num="1"><span class="headli1_1  one">发送手机短信</span>
            </li>
            <li data_id="1" data-num="2"><span class="headli2_1">已发短信查询</span>
            </li>
        </ul>
    </div>
</div>
<div id="iframebox"style="margin-top: 44px;">
    <iframe src="/sendMSms/indexnum1"  frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"  id="iframes"></iframe>

</div>


<script>
    $(function(){
        autodivheight();
        function autodivheight() {
            var winHeight = 0;
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;
            if (document.documentElement && document.documentElement.clientHeight)
                winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
            document.getElementById("iframebox").style.height = winHeight - 91  + "px";
            console.log(winHeight)
        }
        window.onresize = autodivheight;

        $('.index_head li').on('click',function(){
            $(this).find('span').addClass('one').parent().siblings().find('span').removeClass('one');
            var num = $(this).attr('data-num');
            $('#iframes').attr('src','/sendMSms/indexnum'+num);
        })
    })
</script>
</body>
</html>
