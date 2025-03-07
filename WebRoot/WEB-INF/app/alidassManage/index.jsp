<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>阿里IDaaS设置</title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
</head>
<style>
    .main{
        margin-top:46px;
        width: 100%;
    }
</style>
<body>
<div class="head-top">
    <ul class="clearfix">
        <li class="fl head-top-li active" data-type="0">基础参数设置</li>
<%--        <li class="fl head-top-img"><img src="/img/twoth.png" alt=""></li>--%>
<%--        <li class="fl head-top-li" data-type="1">Lims组织用户同步IDaas</li>--%>
    </ul>
</div>
<div class="main" style="width:100%">
    <iframe name="notices" width="100%" height="100%" src="/idaas_manage/setting" frameborder="0"></iframe>
</div>

<script>
    $('.head-top li').click(function () {
        $(this).siblings('li').removeClass('active')
        $(this).addClass('active')
        if($(this).attr('data-type')=='0'){
            $('.main').find('iframe').prop('src','/idaas_manage/setting')
        }else if($(this).attr('data-type')=='1'){
            $('.main').find('iframe').prop('src','/alidaas_syn/synpage')
        }
    });
</script>
</body>
</html>
