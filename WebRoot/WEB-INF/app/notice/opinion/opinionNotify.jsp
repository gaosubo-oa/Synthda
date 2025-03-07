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
            overflow: hidden !important;
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
        table tr {
            border: 1px solid #c0c0c0;
            line-height:40px;
        }

        table  tr:nth-child(odd) {
            background-color: #F6F7F9;
        }

        table  tr:nth-child(odd) {
            background-color: #F6F7F9;
        }

        .pagediv .page-bottom-outer-layer table tr td:nth-child(9){
            font-weight: normal;
            white-space: pre;
            height: 40px;
            padding:4px;
            box-sizing: border-box;
            text-overflow: ellipsis;
            font-size: 10pt;
            text-align: left;
            overflow: visible;
        }
    </style>
    <script src="/js/attachment/attachView.js?20210406.1" type="text/javascript" charset="utf-8"></script>
    <script src="/js/notice/opinionManagement.js?20220718"></script>
</head>
<body>
    <div class="navigation">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/gonggaoguanli.png" alt="">
        <h2><fmt:message code="notice.th.receiptStatus" /></h2><h2> <fmt:message code="userInfor.th.Allpersonnel" /><span id="qb">0</span>  <fmt:message code="main.th.people" /></h2><h2> <fmt:message code="notice.th.receiptReturn" /><span id="th">0</span>  <fmt:message code="main.th.people" /></h2><h2> <fmt:message code="notice.th.receiptHasBeenSubmitted" /><span id="fk">0</span>  <fmt:message code="main.th.people" /></h2><h2><fmt:message code="notice.th.receiptHasNotBeenSubmitted" /><span id="wfk">0</span>  <fmt:message code="main.th.people" /></h2>
        <h2 id="header"></h2>
    </div>
    <div id="pagediv">

    </div>
<script>
    $(function(){
        $.ajax({
            type:'get',
            url:'/syspara/selectTheSysPara?paraName=IS_SHOW_JMJ',
            dataType:'json',
            success:function (res) {
                if(res.object.length!=0){
                    var data=res.object[0]
                    if (data.paraValue!=0){
                        $('.navigation').before('<p style="color: red;font-family: Microsoft YaHei;font-weight: bolder;font-size: 16pt;margin-left: 35px;margin-top: 10px;"> 机密级★ </p>')
                    }
                }
            }
        })
    })
</script>
</body>
</html>