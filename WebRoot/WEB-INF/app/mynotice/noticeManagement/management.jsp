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
    <title><fmt:message code="notice.th.notifymanage" /></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>

    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table tbody td{
            text-align: left!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        .pagediv{
            width: 98% !important;
        }
        .pagediv .page-bottom-outer-layer table td{
            font-size: 11pt !important;
        }
        .pagediv .page-top-inner-layer table th{
            font-size: 12pt !important;
        }
        .query {
            display: inline-block;
            width: 83px;
            height: 24px;
            line-height: 24px;
            cursor: pointer;
            background: url(../../img/btn_canceltop.png) no-repeat;
            font-size: 12px;
        }
    </style>
    <script src="/js/mynotice/management.js"></script>
</head>
<body>
    <div class="navigation">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
        <h2 id="noticeTitle"></h2>
        <label>
            <select name="type">
                <%--<option value="0"><fmt:message code="news.th.type" /></option>--%>
                <option value="0" id="noticeType"></option>
            </select>
            <span>生效状态:</span>
            <select name="status" id="status">
                <%--<option value="0"><fmt:message code="news.th.type" /></option>--%>
                <option value="" >全部</option>
                    <option value="4">待生效</option>
                    <option value="1">已生效</option>
                    <option value="5">已终止</option>
                    <option value="0">已过期</option>
            </select>
            <a href="javascript:;" class="submit"><fmt:message code="global.lang.query" /></a>
            <%--<a href="javascript:;" class="query">过期公告查询</a>--%>
        </label>
    </div>
    <div id="pagediv">

    </div>
</body>
</html>