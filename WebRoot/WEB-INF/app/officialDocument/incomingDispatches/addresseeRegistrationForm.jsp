<%--
  Created by IntelliJ IDEA.
  User: 骆鹏
  Date: 2017/7/27
  Time: 19:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="fmt" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><fmt:message code="doc.th.ReceivingRegistration" /></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="/css/officialDocument/officialDocument.css">

    <link rel="stylesheet" href="/lib/layer/skin/default/layer.css">
    <%--<link rel="stylesheet" href="/lib/pagination/style/pagination.css">--%>
    <link rel="stylesheet" href="/css/base.css">
    <script src="/js/common/language.js"></script>
    <script type="text/javascript" src="/js/xoajq/xoajq3.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery-migrate-3.4.0.js"></script>
    <script src="/js/jquery/jquery.cookie.js"></script>
    <script src="/lib/layer/layer.js?20201106"></script>
    <script src="/js/base/base.js?20220415.1"></script>
    <script src="/js/document/addresseeRegistrationForm.js?20230314.1"></script>
    <link rel="stylesheet" type="text/css" href="/css/commonTheme/${sessionScope.InterfaceModel}/commonTheme.css"/>
    <style>
        .tableDl dl dt span {
            vertical-align: middle;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            display: inline-block;
            width: 182px;
        }
        .noData{
            width: 421px;
            height: 150px;
            margin: 100px auto;
            background-color: #357ece;
            border-radius: 10px;
            box-shadow: 3px 3px 3px #2F5C8F;
            overflow: hidden;
            text-align: center;
        }
        .IMG{
            float: left;
            width: 75px;
            height: 75px;
            margin-top: 37px;
            margin-left: 11px;
        }
        .noData .IMG img{
            width:100%
        }
        .TXT{
            float: left;
            width: 307px;
            color: #fff;
            font-size: 16pt;
            margin-top: 46px;
            margin-left: 20px;
            line-height: 29px;
        }
        .liucheng2{
            width: 50%;
            margin-left: 17%;
            margin-top: 25px;
            cursor: pointer;
        }
        .up_pages .up_format {
            float: right;
            margin-right: 2%;
            margin-top: 10px;
            border-radius: 3px;
            border: #ccc 1px solid;
        }
        .up_pages .up_format ul {
            overflow: hidden;
            border-radius: 3px;
            padding-left: 0px;
        }
        .up_pages .up_format ul li {
            float: left;
            width: 40px;
            height: 30px;
            background-color: #f6f6f6;
            text-align: center;
            overflow: hidden;
        }
        .up_pages .up_format ul li img {
            margin-top: 5px;
        }
        .for_on {
            background-color: #fff !important;
        }
    </style>
</head>
<body class="bodybG">
<div class="headTop">
    <div class="headImg">
        <img src="/img/commonTheme/${sessionScope.InterfaceModel}/shouwendengji.png" alt="">
    </div>
    <div class="divTitle">
         <fmt:message code="doc.th.ReceivingRegistration" />
    </div>
    <div class="up_pages">
        <div class="up_format">
            <ul >
                <li class="for_on" title="默认模式" ><img src="/img/commonTheme/theme6/icon_zuoyou_sel_03.png" id="ul_imgs" style="width: 22px"></li>
                <li id="w2"  title="简约模式"><img src="/img/iCon_list_003.png" id="ul_img" style="width: 22px"></li>
            </ul>
        </div>
    </div>
</div>


<div class="tableDl clearfix" style="margin-top: 50px;">

</div>
<div class="noData" style="display: none">
    <div class="IMG"><img src="../img/sys/icon64_info.png"></div>
    <div class="TXT" id="TXT"><fmt:message code="document.th.ReceivingPermission" /></div>
</div>
</body>
</html>
