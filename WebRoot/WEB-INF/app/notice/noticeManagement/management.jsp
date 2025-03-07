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
    <link rel="stylesheet" href="/css/base/base.css?20220826">
    <link rel="stylesheet" href="/css/notice/noticeManagement.css">
    <script src="/js/common/language.js"></script>

<%--    <script type="text/javascript" src="/js/xoajq/xoajq1.js"></script>--%>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
<%--    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>--%>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="../lib/layer/layer.js?20201106" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/js/base/tablePage.js"></script>
    <script src="/js/base/base.js"></script>
    <script src="/lib/pagination/js/jquery.pagination.min.js" type="text/javascript" charset="utf-8"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        table {
            table-layout: auto;
        }
        .page-bottom-inner-layer{
            overflow-x: unset!important;
        }
        .page-top-inner-layer{
            text-align: left;
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
        /*#pageTbody td:nth-of-type(3){*/
        /*    margin-right: 50px !important;*/
        /*}*/
        #pageTbody tr{
            height: auto;
            width: auto;
            display: flex;
        }
        /*#pageTbody tr td:nth-of-type(2){*/
        /*    float: start;*/
        /*}*/
        #pageTbody tr td:last-child{
            /*width: 244.8px;*/
            height: auto;
            display: flex;
            flex-wrap: wrap;
        }
        .pagediv{
            width: 99% !important;
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
        .navigation{
            height: 55px;
            line-height: 45px;
        }
        .pagediv .page-top-inner-layer table th{
            line-height: 20px;
        }
        .page-top-inner-layer{
            padding: 0px!important;
        }
        #dbgz_page{
            margin-top: 20px;
        }
        .notice_notop{
            background: #2F8AE3;
            width: 145px!important;
            border-radius: 10px;
        }
        .notice_notop span{
            color: #fff!important;
            line-height: 25px!important;
        }
        .notice_top{
            background: #2F8AE3;
            width: 68px!important;
            border-radius: 10px;
        }
        .notice_top span{
            color: #fff!important;
            line-height: 25px!important;
        }
        .delete_check{
            background: #2F8AE3;
            width: 140px!important;
            border-radius: 10px;
        }
        .delete_check span{
            color: #fff!important;
            line-height: 25px!important;
        }

    </style>
    <script src="/js/notice/management.js?20230525.1"></script>
</head>
<body>
    <div class="navigation">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
        <h2><fmt:message code="notice.th.notifymanage" /></h2>
        <label>
            <select name="type" style="width: 185px;">
                <%--<option value="0"><fmt:message code="news.th.type" /></option>--%>
                <option value=""><fmt:message code="notice.th.chosenotifytype" /></option>
            </select>
            <span><fmt:message code="notice.th.effectiveType" />:</span>
            <select name="status" id="status">
                <%--<option value="0"><fmt:message code="news.th.type" /></option>--%>
                <option value="" ><fmt:message code="notice.th.all" /></option>
                    <option value="4"><fmt:message code="notice.th.uneffective" /></option>
                    <option value="1"><fmt:message code="notice.th.effectived" /></option>
                    <option value="5"><fmt:message code="notice.th.hasEnd" /></option>
                    <option value="0"><fmt:message code="notice.th.expired" /></option>
            </select>
            <a href="javascript:;" class="submit"><fmt:message code="global.lang.query" /></a>
            <%--<a href="javascript:;" class="query">过期公告查询</a>--%>
        </label>
    </div>
    <div id="pagediv">

    </div>
</body>
</html>