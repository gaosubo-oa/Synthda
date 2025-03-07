
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><fmt:message code="notice.title.unreadannouncement"/></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script type="text/javascript" src="/js/common/language.js"></script>


    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        html{
            background: #fff;
        }
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        label input[type=text]{
            width: 150px;
            height: 28px;
            line-height: 28px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        .page-top-inner-layer{
            padding-right:0px!important;
        }
        .page-bottom-outer-layer,.page-bottom-inner-layer{
            width:100%;
        }
        .layui-layer-btn .layui-layer-btn0 {
            margin-right: 600px;
        }
    </style>

</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png" alt="">
    <h2><fmt:message code="notice.th.unreadNotifications" /></h2>
    <label>

        <fmt:message code="notice.th.publisher" />：<input type="text" name="" placeholder="<fmt:message code="notice.th.publisher" />" id="reles" />
    </label>
    <label style="margin-left: 3px;">
        <fmt:message code="notice.th.title" />：<input type="text" placeholder="<fmt:message code="main.th.ContentSearch" />" name="subject">
        <a href="javascript:;" class="submit"><fmt:message code="global.lang.query"/></a>
    </label>
</div>
<div id="pagediv">

</div>
<script type="text/javascript" src="/js/base/tablePage.js"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<script type="text/javascript" src="/lib/laydate/laydate.js"></script>
<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/notice/unreadPu_tuo.js?20201228.3"></script>
</body>
</html>
