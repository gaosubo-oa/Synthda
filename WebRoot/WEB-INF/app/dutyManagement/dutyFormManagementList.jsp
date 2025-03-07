
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
    <script type="text/javascript" src="/ui/js/xoajq/xoajq3.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
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
        .pagediv .page-bottom-outer-layer table td:last-child{
            border-right: 1px #dddddd solid;
        }
        .pagediv{
            overflow-x: hidden;
        }
        .newClass{
             float: right;
             width: 90px;
             height: 28px;
             color: #fff;
             font-size: 14px;
             line-height: 28px;
             margin: 2%  2% 0 0;
             cursor: pointer;
            text-align: center;
         }
        .newClass a {
            color: #fff;
        }
        .editAndDelete2{
            color: red;
        }
        .delete_check {
            display: inline-block;
            width: 70px;
            height: 28px;
            position: relative;
            color: #ffffff;
            border-radius: 3px;
            background: #2b7fe0;
            text-align: center;
            line-height: 28px;
            margin: 0px;
        }
    </style>
    <script src="/js/dutyManagement/dutyFormManagementList.js?20230309"></script>
</head>
<body>
<div class="navigation">
    <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
    <h2>值班管理</h2>
   <%-- <div class="newClass" id="report">
        <a href="javascript:;" class="btnsava"  ><fmt:message code="global.lang.report"/></a>
    </div>--%>

</div>
<input type="hidden" id="basePath" value="/">
<div id="pagediv">

</div>
</body>
</html>