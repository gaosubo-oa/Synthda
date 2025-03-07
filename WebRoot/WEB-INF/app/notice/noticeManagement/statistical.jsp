
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
    <title><fmt:message code="notice.th.notifycount"/></title>
    <link rel="stylesheet" href="/lib/pagination/style/pagination.css">
    <link rel="stylesheet" href="/css/base/base.css?20201106.1">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/laydate/laydate.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table tbody td{
            text-align: center!important;
        }
        input{
            float: none;
        }
        .editAndDelete3{
            color: red;
        }
        label input[type=text]{
            width: 150px;
            vertical-align: middle;
            height: 28px;
            border-radius: 4px;
            padding-left: 10px;
            box-sizing: border-box;
        }
        label span{
            vertical-align: middle;
        }
        .btnarrs{
            padding:5px 5px;
            background: #2F8AE3;
            color: #fff!important;
            border-radius: 4px;
            margin-left:5px;
            font-size: 13px;
        }
        .pagediv{
            width: 98% !important;
            overflow: hidden !important;
        }
        .page-top-inner-layer{
            padding-right:0px!important;
        }
        .page-bottom-outer-layer,.page-bottom-inner-layer{
            width:100%;
        }
        #dbgz_page{
            display: none;
        }
    </style>
    <script src="/js/notice/statistical.js?20230324.1"></script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/la2.png" alt="">
    <h2><fmt:message code="notice.th.notifycount"/></h2>
    <label>
        <select name="type" id="dept_id">
            <option value="0"><fmt:message code="news.th.type"/></option>
        </select>


    </label>
    <label style="margin-left:3px;">
        <input type="text" readonly="readonly"
               placeholder="<fmt:message code="adding.th.Start"/>" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})" name="beginTime">
        <span><fmt:message code="global.lang.to"/></span>
        <input type="text"
               placeholder="<fmt:message code="adding.th.end"/>" name="endTime" readonly="readonly"
               onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
        <a href="javascript:;" class="btnarrs" data-type="1"><fmt:message code="notice.th.Statistics"/></a>
        <a href="javascript:;" class="btnarrs" data-type="2"><fmt:message code="global.lang.report"/></a>
        <a href="javascript:;" class="btnarrs" data-type="3"><fmt:message code="notice.th.Today"/></a>
        <a href="javascript:;" class="btnarrs" data-type="4"><fmt:message code="diary.th.thisW"/></a>
        <a href="javascript:;" class="btnarrs" data-type="5"><fmt:message code="diary.th.thisM"/></a>
        <a href="javascript:;" class="btnarrs" data-type="6"><fmt:message code="adding.th.ear"/></a>
    </label>
</div>
<div id="pagediv">

</div>
</body>
</html>