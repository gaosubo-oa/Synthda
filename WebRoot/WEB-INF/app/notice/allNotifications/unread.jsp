
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
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
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
        .navigation label select, .navigation label a{
            vertical-align: initial;
        }
        .navigation{
            margin-left: -350px;
        }
        .layui-layer-btn .layui-layer-btn0{
            height: 28px;
            line-height: 28px;
            margin: 6px 6px 0;
            padding: 0 15px;
            border: 1px solid #dedede;
            background-color: #f1f1f1;
            color: #333;
            border-radius: 2px;
            font-weight: 400;
            cursor: pointer;
            text-decoration: none;
        }
        #pageTbody tr td,div{
            text-align: center!important;
        }
    </style>

</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/weidugonggao.png" alt="">
    <h2><fmt:message code="notice.title.unreadannouncement"/></h2>
    <label>
        <select name="type">
            <%--<option value="0"><fmt:message code="notice.type.alltype"/></option>--%>
                <option value="0"><fmt:message code="notice.th.chosenotifytype" /></option>
        </select>
    </label>
    <label style="margin-left: 3px;">
        <fmt:message code="notice.th.effectivedate" />：<input type="text" placeholder="<fmt:message code="doc.th.enterDate"/>"
                  readonly="readonly"
                  onclick="laydate({istime: true, format: 'YYYY-MM-DD'})" name="sendTime" style="margin-right: 5px">
        <a href="javascript:;" class="submit"><fmt:message code="global.lang.query"/></a>
        <button id="button1" style="background-size: 74px;
    width: 110px;
    height: 30px;
    display: inline-block;
    border-radius: 4px;
    border: 1px solid #ccc;
    box-sizing: border-box;cursor: pointer;color: #000;margin-left: 5px;
    font-size: 15px;"><fmt:message code="notice.th.OneClickRead" /></button>
    </label>
</div>
<div id="pagediv">

</div>
<script type="text/javascript" src="/js/base/tablePage.js"></script>
<script type="text/javascript" src="/js/base/base.js"></script>
<script type="text/javascript" src="/lib/laydate/laydate.js"></script>
<script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
<script src="/js/notice/unread.js?20230322.1"></script>
</body>
</html>
