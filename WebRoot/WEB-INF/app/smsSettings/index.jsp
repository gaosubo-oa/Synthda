<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/12
  Time: 15:290
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title><fmt:message code="dem.th.SMSSettings"/></title>

    <style>
        .news{
            cursor: pointer;
        }
        #iframebox{
            width: 100%;
            height: calc(100% - 45px)
        }
        .head .index_head li img {
            margin-left: 10px;
        }
        .head .index_head li span {

            margin-left: 10px!important;

        }
    </style>
    <link rel="stylesheet" href="../../lib/layui/layui/css/layui.css?20210319.1">
    <link rel="stylesheet" href="/css/workflow/work/automaticNumbering.css">
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <script type="text/javascript" src="/js/jquery/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/layer/layer.js?20201106"></script>
    <script type="text/javascript" src="/lib/laydate/laydate.js"></script>
    <script type="text/javascript" src="../../lib/layui/layui/layui.js"></script>
    <script type="text/javascript" src="/js/base/base.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.form.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<body style="background: #fff">
<div class="navigation clearfix">
    <div class="head w clearfix">
        <ul class="index_head">
            <li data_id="0" data-num="1"><span class="headli1_1  one">短信网关管理</span><img class="headli1_2" src="../img/twoth.png" alt="" class="headli2_2">
            </li>
<%--           <li data_id="" data-num="2"><span class="headli2_1"><fmt:message code="dem.th.SMSReceivingManagement"/></span><img src="../img/twoth.png" alt="" class="headli2_2">--%>
<%--            </li>--%>

            <li data_id="1" data-num="3"><span class="headli3">已发短息管理</span><img src="../img/twoth.png" alt="" class="headli2_2">
            </li>

            <li data_id="" data-num="4"><span class="headli2_1"><fmt:message code="dem.th.RemindingAuthority"/></span><img src="../img/twoth.png" alt="" class="headli2_2">
            </li>
            <li data_id="1" data-num="5"><span class="headli3"><fmt:message code="dem.th.Reminding"/></span></span><img src="../img/twoth.png" alt="" class="headli2_2">
            </li>
            <li data_id="1" data-num="6"><span class="headli3"><fmt:message code="dem.th.OutgoingAuthority"/></span></span></span><img src="../img/twoth.png" alt="" class="headli2_2">
                <%--<img src="../img/twoth.png" alt="" class="headli2_2">--%>
            </li>
            <li data_id="1" data-num="7"><span class="headli3"><fmt:message code="dem.th.ModulePermissions"/></span></span><img src="../img/twoth.png" alt="" class="headli2_2">
            </li>
            <li data_id="1" data-num="8"><span class="headli3">发送短信</span>
            </li>
        </ul>
    </div>
</div>
<div id="iframebox" style="margin-top: 44px;height: calc(100% - 45px)">
    <iframe src="/smsSettings/indexnum1"  frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"  id="iframes"></iframe>

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
            // document.getElementById("iframebox").style.height = winHeight - 91  + "px";
            console.log(winHeight)
        }
        window.onresize = autodivheight;

        $('.index_head li').click(function(){
            $(this).find('span').addClass('one').parent().siblings().find('span').removeClass('one');
            var num = $(this).attr('data-num');
            $('#iframes').attr('src','/smsSettings/indexnum'+num);
        })
    })
</script>
</body>
</html>
